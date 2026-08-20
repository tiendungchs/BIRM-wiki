#!/usr/bin/env bash
# Convert PDFs in raw/ to Markdown so they are grep-able and cheap to ingest.
#
# Why: qmd only indexes wiki/, so raw/ format never affects search — but every
# INGEST reads raw/ directly. Markdown and plain text can be grepped and read in
# slices (sed -n); a PDF has to be loaded whole, and two-column layouts and
# tables come back mangled. Converting at drop time keeps ingests cheap.
#
# Backends, tried in this order (first one found wins):
#   pdftotext (poppler)   brew install poppler        — fast, good on text PDFs
#   mutool    (mupdf)     brew install mupdf-tools    — fallback extractor
#   markitdown            pip install markitdown[pdf] — real Markdown structure
#   pymupdf4llm           pip install pymupdf4llm     — best headings/tables
#
# Usage:
#   ./tools/pdf2md.sh                    — convert every PDF in raw/
#   ./tools/pdf2md.sh raw/paper.pdf ...  — convert specific files
#
# Options:
#   --force     overwrite an existing .md instead of skipping
#   --keep      leave the original .pdf in raw/ (default: move to raw/originals/)
#   --layout    spend more effort preserving layout. pymupdf4llm: enables the
#               GNN layout engine — better tables and reading order, but ~20x
#               slower. pdftotext: passes -layout, which helps tables but
#               interleaves the columns of two-column papers.
#   --backend B force a backend: pdftotext | mutool | markitdown | pymupdf4llm
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
RAW_DIR="$REPO_ROOT/raw"
ARCHIVE_DIR="$RAW_DIR/originals"

FORCE=0; KEEP=0; LAYOUT=0; BACKEND=""
FILES=()
while [[ $# -gt 0 ]]; do
    case "$1" in
        --force)   FORCE=1; shift ;;
        --keep)    KEEP=1; shift ;;
        --layout)  LAYOUT=1; shift ;;
        --backend) BACKEND="${2:-}"; shift 2 ;;
        -h|--help) sed -n '2,30p' "$0"; exit 0 ;;
        -*)        echo "error: unknown option $1" >&2; exit 1 ;;
        *)         FILES+=("$1"); shift ;;
    esac
done

# --- pick a backend ---------------------------------------------------------
have() { command -v "$1" >/dev/null 2>&1; }
have_py() { python3 -c "import $1" >/dev/null 2>&1; }

detect_backend() {
    have pdftotext   && { echo pdftotext;   return 0; }
    have mutool      && { echo mutool;      return 0; }
    have markitdown  && { echo markitdown;  return 0; }
    have_py pymupdf4llm && { echo pymupdf4llm; return 0; }
    return 1
}

if [[ -z "$BACKEND" ]] && ! BACKEND="$(detect_backend)"; then
    cat >&2 <<'MSG'
error: no PDF text extractor found. Install one of:

  brew install poppler          # pdftotext — recommended, fastest
  brew install mupdf-tools      # mutool
  pip install pymupdf4llm       # best structure (headings, tables)
  pip install 'markitdown[pdf]'

Then re-run: ./tools/pdf2md.sh
MSG
    exit 1
fi

# --- extraction -------------------------------------------------------------
# Each backend writes plain text / Markdown to stdout.
extract() {
    local pdf="$1"
    case "$BACKEND" in
        pdftotext)
            # No -layout by default: poppler's reading-order heuristic handles
            # two-column papers far better than physical-layout preservation.
            if [[ $LAYOUT -eq 1 ]]; then
                pdftotext -layout -nopgbrk -q "$pdf" -
            else
                pdftotext -nopgbrk -q "$pdf" -
            fi ;;
        mutool)      mutool draw -F txt -o - "$pdf" 2>/dev/null ;;
        markitdown)  markitdown "$pdf" ;;
        pymupdf4llm)
            # --layout enables pymupdf's GNN layout engine: better reading order
            # and tables, but ~20x slower (minutes per paper, not seconds), so
            # the heuristic path is the default.
            #
            # stdout is redirected into a buffer during conversion because the
            # library prints progress there; only the Markdown escapes.
            PDF2MD_LAYOUT=$LAYOUT python3 -c '
import sys, os, io, contextlib, pymupdf4llm
pymupdf4llm.use_layout(os.environ.get("PDF2MD_LAYOUT") == "1")
noise = io.StringIO()
with contextlib.redirect_stdout(noise):
    md = pymupdf4llm.to_markdown(sys.argv[1])
sys.stdout.write(md)
' "$pdf" ;;
        pymupdf-text)
            # Last-resort flat-text extraction. Recovers the invisible OCR layer
            # of scanned PDFs, which pymupdf4llm discards as non-visible text.
            python3 -c '
import sys, pymupdf
doc = pymupdf.open(sys.argv[1])
for page in doc:
    sys.stdout.write(page.get_text())
    sys.stdout.write("\n\n")
' "$pdf" ;;
        *) echo "error: unknown backend '$BACKEND'" >&2; return 1 ;;
    esac
}

# Strip form feeds and collapse runs of blank lines to at most one.
tidy() { tr -d '\f' | cat -s; }

# --- collect inputs ---------------------------------------------------------
if [[ ${#FILES[@]} -eq 0 ]]; then
    while IFS= read -r f; do FILES+=("$f"); done \
        < <(find "$RAW_DIR" -maxdepth 1 -type f -iname '*.pdf' | sort)
fi

if [[ ${#FILES[@]} -eq 0 ]]; then
    echo "No PDFs found in raw/. Nothing to do."
    exit 0
fi

echo "Backend: $BACKEND"
converted=0; skipped=0; failed=0

for pdf in "${FILES[@]}"; do
    [[ -f "$pdf" ]] || { echo "  skip (missing): $pdf" >&2; failed=$((failed+1)); continue; }
    base="$(basename "$pdf")"
    stem="${base%.*}"
    out="$RAW_DIR/$stem.md"

    if [[ -e "$out" && $FORCE -eq 0 ]]; then
        echo "  skip (exists): $stem.md    — use --force to overwrite"
        skipped=$((skipped+1)); continue
    fi

    body="$(extract "$pdf" | tidy)" || { echo "  FAIL: $base" >&2; failed=$((failed+1)); continue; }
    # Cheap emptiness test: a glob match short-circuits on the first non-space
    # character. Do NOT use ${body// /} here — global substitution over a
    # 100KB+ string pegs bash 3.2 at 100% CPU for minutes.
    used="$BACKEND"
    if [[ "$body" != *[![:space:]]* ]] && [[ "$BACKEND" != "pymupdf-text" ]] && have_py pymupdf; then
        # An OCR'd scan carries its text in an invisible layer that the Markdown
        # backends drop. Retry flat before giving up.
        body="$(BACKEND=pymupdf-text extract "$pdf" | tidy)" || true
        used="pymupdf-text (fallback)"
    fi
    if [[ "$body" != *[![:space:]]* ]]; then
        echo "  FAIL (no extractable text — image-only PDF): $base" >&2
        failed=$((failed+1)); continue
    fi

    {
        echo "# $stem"
        echo
        echo "> Converted from \`$base\` on $(date +%Y-%m-%d) via \`$used\`."
        echo "> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source."
        echo
        echo '---'
        echo
        printf '%s\n' "$body"
    } > "$out"

    echo "  ok: $base -> $stem.md ($(wc -c <"$out" | tr -d ' ') bytes, $used)"
    converted=$((converted+1))

    if [[ $KEEP -eq 0 ]]; then
        mkdir -p "$ARCHIVE_DIR"
        mv "$pdf" "$ARCHIVE_DIR/$base"
    fi
done

echo
echo "Converted $converted, skipped $skipped, failed $failed."
if [[ $KEEP -eq 0 && $converted -gt 0 ]]; then echo "Originals moved to raw/originals/."; fi
exit 0
