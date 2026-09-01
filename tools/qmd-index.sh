#!/usr/bin/env bash
# Build/update the qmd search index from all wiki pages, or search it.
#
# Portable across macOS and Ubuntu. Targets qmd 2.x (the TypeScript/Node CLI
# from https://github.com/tobi/qmd), which replaced the old per-document
# `document add --db-path ...` interface with a collection-based, project-local
# index stored under ./.qmd/ at the repo root.
#
# Install qmd (both OSes):
#   git clone https://github.com/tobi/qmd && cd qmd \
#     && npm install && npm run build && npm link
#   (Node >= 22 required. On macOS also: brew install sqlite.)
#
# Usage:
#   ./tools/qmd-index.sh                       — (re)index wiki + raw sources
#   ./tools/qmd-index.sh search "query"        — hybrid search over wiki/ (default)
#   ./tools/qmd-index.sh search --raw "query"  — search raw/ sources only
#   ./tools/qmd-index.sh search --all "query"  — search wiki/ + raw/ together
#   ./tools/qmd-index.sh status                — show index health
#
# Two collections are maintained: "brain-wiki" (wiki/) and "brain-raw" (raw/,
# .md + .txt; raw/originals/ PDFs are excluded by the glob). Search defaults to
# the wiki because for a QUERY the synthesis is the answer; --raw/--all are for
# ingest de-duplication and for going back to the primary text.
#
# Override the qmd binary with:  QMD=/path/to/qmd ./tools/qmd-index.sh ...
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WIKI_COLLECTION="brain-wiki"
WIKI_SUBDIR="wiki"          # collection path, relative to REPO_ROOT
RAW_COLLECTION="brain-raw"
RAW_SUBDIR="raw"            # collection path, relative to REPO_ROOT
RAW_PATTERN='**/*.{md,txt}' # sources are Markdown or plain text; PDFs stay out

# --- Locate the qmd binary (portable across macOS + Ubuntu) -----------------
find_qmd() {
    # 1) explicit override
    if [[ -n "${QMD:-}" ]]; then command -v "$QMD" 2>/dev/null && return 0; fi
    # 2) on PATH
    if command -v qmd >/dev/null 2>&1; then command -v qmd; return 0; fi
    # 3) common install locations on either OS.
    #    Includes conda envs: qmd is often installed into one (its bin lands in
    #    the env prefix), and that env may not be active in this shell.
    local c
    for c in \
        "${CONDA_PREFIX:-/nonexistent}"/bin/qmd \
        "$HOME"/{miniconda3,miniforge3,mambaforge,anaconda3}/envs/*/bin/qmd \
        /opt/{miniconda3,miniforge3,anaconda3}/envs/*/bin/qmd \
        "$HOME"/.nvm/versions/node/*/bin/qmd \
        "$HOME"/src/qmd/bin/qmd \
        /usr/local/bin/qmd \
        /opt/homebrew/bin/qmd \
        "$HOME"/.local/bin/qmd \
        /usr/lib/node_modules/@tobilu/qmd/bin/qmd \
        /usr/local/lib/node_modules/@tobilu/qmd/bin/qmd ; do
        [[ -x "$c" ]] && { echo "$c"; return 0; }
    done
    return 1
}

# qmd's launcher is `#!/usr/bin/env node` (falling back to bun), so a runtime
# must be on PATH even when the binary is found via an absolute path above.
require_node_runtime() {
    command -v node >/dev/null 2>&1 && return 0
    command -v bun  >/dev/null 2>&1 && return 0
    echo "error: found qmd at $QMD_BIN, but no 'node' (>=22) or 'bun' on PATH." >&2
    echo "  qmd is a Node CLI; activate the environment that provides its runtime." >&2
    case "$QMD_BIN" in
        */envs/*/bin/qmd)
            # Extract the env name from .../envs/<name>/bin/qmd
            local env_path="${QMD_BIN%/bin/qmd}"
            echo "  Looks like a conda env — try: conda activate ${env_path##*/}" >&2 ;;
    esac
    return 1
}

if ! QMD_BIN="$(find_qmd)"; then
    echo "error: 'qmd' not found." >&2
    echo "  Install: git clone https://github.com/tobi/qmd && cd qmd \\" >&2
    echo "             && npm install && npm run build && npm link" >&2
    echo "  Or set QMD=/path/to/qmd" >&2
    exit 1
fi

require_node_runtime || exit 1

# Run everything from the repo root so qmd uses the project-local ./.qmd index.
cd "$REPO_ROOT"

# --- search / status pass-throughs ------------------------------------------
if [[ "${1:-}" == "search" ]]; then
    shift
    scope=("--collection" "$WIKI_COLLECTION")
    case "${1:-}" in
        --raw)  scope=("--collection" "$RAW_COLLECTION"); shift ;;
        --all)  scope=("--collection" "$WIKI_COLLECTION" "--collection" "$RAW_COLLECTION"); shift ;;
        --wiki) shift ;;
    esac
    # `query` = hybrid BM25 + vector + LLM rerank (best quality).
    "$QMD_BIN" query "$*" "${scope[@]}" -n 10
    exit 0
fi

if [[ "${1:-}" == "status" ]]; then
    "$QMD_BIN" status
    exit 0
fi

# --- indexing pass ----------------------------------------------------------
# Bootstrap the project-local index on first run.
if [[ ! -f "$REPO_ROOT/.qmd/index.yml" ]]; then
    echo "No project-local index found — initializing ./.qmd ..."
    "$QMD_BIN" init
fi

# Ensure the collection exists (idempotent; add only if missing).
# Capture first: piping straight into `grep -q` closes the pipe early, and
# under `pipefail` qmd's resulting SIGPIPE would clobber the exit status.
collection_list="$("$QMD_BIN" collection list 2>/dev/null || true)"
for spec in "$WIKI_COLLECTION:$WIKI_SUBDIR" "$RAW_COLLECTION:$RAW_SUBDIR"; do
    name="${spec%%:*}"; subdir="${spec##*:}"
    if ! printf '%s\n' "$collection_list" | grep -q "^$name "; then
        echo "Creating collection '$name' -> ./$subdir ..."
        "$QMD_BIN" collection add "./$subdir" --name "$name"
    fi
done

# qmd 2.x ignores `collection add --pattern`, always writing "**/*.md". The raw/
# tree also holds .txt talk transcripts, so patch the pattern in index.yml
# directly (idempotent) and let `qmd update` pick the extra files up.
ensure_raw_pattern() {
    local yml="$REPO_ROOT/.qmd/index.yml"
    [[ -f "$yml" ]] || return 0
    grep -qF "pattern: \"$RAW_PATTERN\"" "$yml" && return 0
    RAW_COLLECTION="$RAW_COLLECTION" RAW_PATTERN="$RAW_PATTERN" python3 - "$yml" <<'PY'
import os, re, sys
path, name, pattern = sys.argv[1], os.environ["RAW_COLLECTION"], os.environ["RAW_PATTERN"]
text = open(path).read()
# Rewrite only the `pattern:` line inside the raw collection's block.
block = re.compile(r"(^  %s:\n(?:    .*\n)*?    pattern: )(.*)$" % re.escape(name), re.M)
new, n = block.subn(lambda m: m.group(1) + '"%s"' % pattern, text)
if n:
    open(path, "w").write(new)
    print("  patched %s pattern -> %s" % (name, pattern))
PY
}
ensure_raw_pattern

echo "Re-indexing wiki pages and raw sources..."
"$QMD_BIN" update
# `--timeout 0` disables qmd's 30-minute embed session cap: with raw/ indexed
# a cold run is well over an hour, and the cap silently leaves docs pending.
echo "Updating embeddings (no session cap; a cold run takes >1h)..."
"$QMD_BIN" embed --timeout 0
echo "Done. Search with: ./tools/qmd-index.sh search [--raw|--all] \"your query\""
