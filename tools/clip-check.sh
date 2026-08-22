#!/usr/bin/env bash
# Validate freshly clipped sources in raw/ before they enter the ingest queue.
# Called by the ACQUIRE skill (.claude/skills/wiki-acquire), part B.
#
#   ./tools/clip-check.sh                 check every untracked file in raw/
#   ./tools/clip-check.sh raw/a.md ...    check the named files
#   ./tools/clip-check.sh --manifest F... check, then append a _work/manifest.tsv row per file
#
# Exit 0 if every file passes, 1 if any FAIL. WARN never fails the run.
# FAIL is reserved for "this file is not the article": bad name, too short, paywall
# stub, duplicate source. Frontmatter is preferred, not required, so it only WARNs.
# No `set -o pipefail`: a `grep -q` at the end of a pipe SIGPIPEs its upstream and
# inverts the pipeline's status under pipefail (see priority-tasks.md, 302-source pass).

set -u
cd "$(dirname "$0")/.."

MIN_WORDS=600            # below this a clip is almost always a stub or an abstract
DO_MANIFEST=0
if [ "${1:-}" = "--manifest" ]; then DO_MANIFEST=1; shift; fi

FILES="$*"
if [ -z "$FILES" ]; then
  FILES=$(git ls-files --others --exclude-standard raw/ | grep -E '\.(md|txt)$')
fi
if [ -z "$FILES" ]; then
  echo "clip-check: nothing to check (no untracked files in raw/)"; exit 0
fi

FAILS=0; WARNS=0; N=0
say() { printf '  %-5s %s\n' "$1" "$2"; }
fail() { say FAIL "$1"; FAILS=$((FAILS+1)); }
warn() { say WARN "$1"; WARNS=$((WARNS+1)); }

# ---- per-file checks -------------------------------------------------------
for f in $FILES; do
  N=$((N+1))
  base=$(basename "$f")
  FAILS_BEFORE=$FAILS
  echo "$f"
  if [ ! -f "$f" ]; then fail "no such file"; continue; fi

  STEM=${base%.*}
  LEGACY=0
  [ "$(grep -c -F -- "$STEM" _work/ingest-queue.md)" -gt 0 ] && LEGACY=1
  [ "$LEGACY" -eq 1 ] && say note "already in _work/ingest-queue.md — legacy source, FAILs reported as WARN"
  gate() { if [ "$LEGACY" -eq 1 ]; then warn "$1"; else fail "$1"; fi; }

  # C1 filename convention: author-year-slug.md, year is 4 digits or 'nd'
  if [ -z "$(printf '%s' "$base" | grep -E '^[a-z0-9]+-([0-9]{4}|nd)-[a-z0-9-]+\.(md|txt)$')" ]; then
    gate "filename is not author-year-slug.md  (got '$base')"
  fi

  # C2/C3 frontmatter and provenance
  HAS_FM=0
  [ "$(head -1 "$f")" = "---" ] && HAS_FM=1
  if [ "$HAS_FM" -eq 1 ]; then
    FM=$(awk 'NR>1 && /^---[[:space:]]*$/{exit} NR>1' "$f")
    # strip the key only — a URL is full of colons, so do NOT split on ':'
    SRC=$(printf '%s\n' "$FM" | sed -n 's/^source:[[:space:]]*//p' | head -1 | tr -d '"' | tr -d ' ')
    TITLE=$(printf '%s\n' "$FM" | sed -n 's/^title:[[:space:]]*//p' | head -1 | tr -d '"')
    BODY=$(awk 'f{print} /^---[[:space:]]*$/{n++; if(n==2) f=1}' "$f")
    [ -z "$SRC" ] && warn "frontmatter has no source: URL — no re-fetch, no duplicate detection"
    [ -z "$TITLE" ] && warn "frontmatter has no title:"
  else
    SRC=""; TITLE=""; BODY=$(cat "$f")
    # Frontmatter is preferred, not mandatory: a clipped .md usually has it, a
    # transcript or a pdf2md conversion does not. Never a FAIL — only a warning
    # that re-fetch and duplicate detection are unavailable for this file.
    warn "no frontmatter — no source: URL, so no re-fetch and no duplicate detection"
  fi

  # C4 length
  WORDS=$(printf '%s' "$BODY" | wc -w | tr -d ' ')
  if [ "$WORDS" -lt "$MIN_WORDS" ]; then
    gate "only $WORDS words — stub, abstract, or a failed clip"
  else
    say ok "$WORDS words"
  fi

  # C5 paywall / consent / JS-shell residue
  STUB=$(grep -icE 'access through your institution|purchase pdf|sign in to continue|subscribe to (read|continue)|enable javascript|accept all cookies' "$f")
  [ "$STUB" -gt 0 ] && gate "$STUB paywall/consent/JS-shell marker(s) — clip captured the wrapper, not the article"

  # C6 broken math: TeX commands sitting outside any math delimiter
  BADMATH=$(grep -cE '\\(frac|sum_|int_|nabla|partial|mathbb|mathcal|hat\{|sigma|theta)' "$f")
  DOLLARS=$(grep -o '\$' "$f" | wc -l | tr -d ' ')
  if [ "$BADMATH" -gt 0 ] && [ "$DOLLARS" -eq 0 ]; then
    warn "$BADMATH TeX command(s) but no \$ delimiter — equations likely flattened; consider re-clipping the HTML view"
  fi
  ODD=$((DOLLARS % 2))
  [ "$ODD" -eq 1 ] && warn "odd number of \$ ($DOLLARS) — unbalanced math delimiter"

  # C7 unresolvable images: vault-local or embedded, neither survives the repo
  BADIMG=$(grep -cE '!\[[^]]*\]\((app://|file://|data:image|\.\./|attachments/)' "$f")
  [ "$BADIMG" -gt 0 ] && warn "$BADIMG image link(s) point outside the repo (app://, file://, data:, attachments/)"

  # C8 raw HTML residue from a bad clip
  HTMLRES=$(grep -cE '<(div|span|figure|table|script)[ >]|&nbsp;' "$f")
  [ "$HTMLRES" -gt 12 ] && warn "$HTMLRES lines of raw HTML residue — clipper did not convert cleanly"

  # C9 duplicate source URL or duplicate stem elsewhere in raw/
  if [ -n "$SRC" ] && [ ${#SRC} -gt 12 ]; then
    # exact match on the extracted URL, not a substring of it
    DUP=$(awk -v want="$SRC" -v self="$f" '
      FNR==1{infm=0}
      /^---[[:space:]]*$/{infm=!infm; next}
      infm && /^source:/{u=$0; sub(/^source:[[:space:]]*/,"",u); gsub(/["\r ]/,"",u);
                          if(u==want && FILENAME!=self) print FILENAME; nextfile}
    ' raw/*.md 2>/dev/null | head -3 | tr '\n' ' ')
    [ -n "$DUP" ] && fail "same source: URL already in $DUP"
  fi

  # ---- optional: append the manifest row ----------------------------------
  if [ "$DO_MANIFEST" -eq 1 ] && [ "$FAILS" -gt "$FAILS_BEFORE" ]; then
    say skip "not filed — fix the FAIL above, then re-run with --manifest"
  elif [ "$DO_MANIFEST" -eq 1 ]; then
    if [ -n "$(awk -F'\t' -v n="$base" 'NR>1 && $4==n{print "y"; exit}' _work/manifest.tsv)" ]; then
      say skip "manifest row already exists"
    else
      ID=$(awk -F'\t' 'NR>1 && $1+0>m{m=$1+0} END{printf "%03d", m+1}' _work/manifest.tsv)
      AUTHOR=$(printf '%s' "$STEM" | awk -F- '{print $1}')
      YEAR=$(printf '%s' "$STEM" | awk -F- '{print $2}')
      printf '%s\tCLIPPED\t%s\t%s\t%s\t%s\t?\t?\t?\t?\tH\tclipped %s\t%s\n' \
        "$ID" "$base" "$base" "$AUTHOR" "$YEAR" "${SRC:-no-source}" "$WORDS" >> _work/manifest.tsv
      say ok "manifest row $ID appended — set topic/tier/wave/seq by hand"
    fi
  fi
done

echo
printf 'clip-check: %s file(s), %s FAIL, %s WARN\n' "$N" "$FAILS" "$WARNS"
[ "$FAILS" -gt 0 ] && exit 1
exit 0
