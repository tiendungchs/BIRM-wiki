#!/usr/bin/env bash
# Emit every count the wiki publishes about itself, with the command that produces it.
# Called at the top of LINT.
set -uo pipefail
cd "$(dirname "$0")/.."

n() { printf '%-22s %6s   %s\n' "$1" "$2" "$3"; }

SOURCES=$(grep -c '^- \[x\]' _work/ingest-queue.md)
CONCEPTS=$(ls wiki/concepts | wc -l | tr -d ' ')
ENTITIES=$(ls wiki/entities | wc -l | tr -d ' ')
GAPS=$(grep -cE '^\| G[0-9]+ \|' wiki/architectural-gaps.md)
TENSIONS=$(grep -cE '^\| T[0-9]+ \|' wiki/empirical-tensions.md)
EDGES=$(for f in wiki/concepts/*.md wiki/entities/*.md; do
    awk '/^#+ *Connections/{c=1;next} /^#+ /{if(c)c=0} c' "$f" \
    | grep -ohE 'wiki/[a-z0-9/-]+\.md' | sort -u
  done | wc -l | tr -d ' ')

echo "wiki self-counts   ($(git rev-parse --short HEAD))"
echo
n sources    "$SOURCES"  "grep -c '^- \[x\]' _work/ingest-queue.md"
n concepts   "$CONCEPTS" "ls wiki/concepts | wc -l"
n entities   "$ENTITIES" "ls wiki/entities | wc -l"
n gaps       "$GAPS"     "grep -cE '^| G[0-9]+ |' wiki/architectural-gaps.md"
n tensions   "$TENSIONS" "grep -cE '^| T[0-9]+ |' wiki/empirical-tensions.md"
n edges      "$EDGES"    "Connections-block links, deduped per page"
echo
printf '%-22s %6s KB\n' "architectural-gaps"  "$(( $(wc -c < wiki/architectural-gaps.md) / 1024 ))"
printf '%-22s %6s KB\n' "empirical-tensions"  "$(( $(wc -c < wiki/empirical-tensions.md) / 1024 ))"
printf '%-22s %6s KB\n' "wiki total"          "$(( $(cat wiki/*.md wiki/concepts/*.md wiki/entities/*.md | wc -c) / 1024 ))"

GLOSS_ML=$(awk '/^## Machine learning/{s=1;next} /^## /{s=0} s && /^\| / && $0 !~ /^\|[- :|]+\|$/ && $0 !~ /^\| *Abbrev/' wiki/glossary.md | wc -l | tr -d ' ')
GLOSS_NS=$(awk '/^## Neuroscience/{s=1;next} /^## /{s=0} s && /^\| / && $0 !~ /^\|[- :|]+\|$/ && $0 !~ /^\| *Abbrev/' wiki/glossary.md | wc -l | tr -d ' ')
GLOSS_BM=$(awk '/^## Benchmarks/{s=1;next} /^## /{s=0} s && /^\| / && $0 !~ /^\|[- :|]+\|$/ && $0 !~ /^\| *Abbrev/' wiki/glossary.md | wc -l | tr -d ' ')
n "glossary ml/ns/bm" "$GLOSS_ML/$GLOSS_NS/$GLOSS_BM" "rows per '## ' section of wiki/glossary.md"

FAIL=0

# S5: the overview's published source count must equal the derived one.
CLAIMED=$(grep -oE '\*\*[0-9]+ sources ingested\*\*' wiki/overview.md | grep -oE '[0-9]+' | head -1)
echo
if [ "$CLAIMED" = "$SOURCES" ]; then
  echo "S5  OK        overview says $CLAIMED sources, derived $SOURCES"
else
  echo "S5  VIOLATED  overview says ${CLAIMED:-<none>} sources, derived $SOURCES"
  FAIL=1
fi

# S5b: the overview's published tension count must equal the derived one.
CLAIMED_T=$(grep -oE '\[\[wiki/empirical-tensions\.md\]\] \([0-9]+ rows' wiki/overview.md | grep -oE '[0-9]+' | head -1)
if [ "$CLAIMED_T" = "$TENSIONS" ]; then
  echo "S5b OK        overview says $CLAIMED_T tensions, derived $TENSIONS"
else
  echo "S5b VIOLATED  overview says ${CLAIMED_T:-<none>} tensions, derived $TENSIONS"
  FAIL=1
fi

# S4: every table row must carry its separator's column count. Reset the width at
# each table boundary ({w=0}) or one table's width is carried into the next.
S4=$(find wiki -name '*.md' | sort | xargs awk '/^\|/{l=$0;gsub(/\\\|/,"",l);n=gsub(/\|/,"",l)-1;if(/^\|[- :\|]+\|$/){w=n;next};if(w>0&&n!=w)print FILENAME":"FNR" (cols="n", expected="w")";next}{w=0}')
if [ -z "$S4" ]; then
  echo "S4  OK        every table row matches its separator's column count"
else
  echo "S4  VIOLATED"; echo "$S4" | sed 's/^/              /'; FAIL=1
fi

# S1: every Connections edge must be answered from the target's own Connections block.
# NOTE: never end this pipeline in `grep -q`. grep -q exits on the first match,
# which SIGPIPEs the upstream awk; under `set -o pipefail` that makes every
# *symmetric* edge report as asymmetric (765 false positives when first wired).
# Capture the block, then match it as a string. (Not `case` -- bash 3.2 on macOS
# mis-parses a case pattern's `)` inside $( ).)
cxblock() { awk '/^#+ *Connections/{c=1;next} /^#+ /{if(c)c=0} c' "$1"; }
S1=$(for f in wiki/concepts/*.md wiki/entities/*.md; do
    for t in $(cxblock "$f" | grep -ohE 'wiki/(concepts|entities)/[a-z0-9.-]+\.md' | sort -u); do
        [ -f "$t" ] || { echo "BROKEN $f -> $t"; continue; }
        back=$(cxblock "$t")
        [[ "$back" == *"$f"* ]] || echo "ONEWAY $f -> $t"
      done
  done)
if [ -z "$S1" ]; then
  echo "S1  OK        all $EDGES Connections edges are bidirectional and resolve"
else
  echo "S1  VIOLATED  $(echo "$S1" | wc -l | tr -d ' ') asymmetric or broken edges"
  echo "$S1" | sed 's/^/              /'; FAIL=1
fi

# S14: a registry row that no concept/entity page cites is unreachable from the
# wiki's working surface -- an ingest will never meet it. Gaps must be reachable.
uncited() {
  ids=$(grep -oE "^\| $2[0-9]+ \|" "$1" | grep -oE "$2[0-9]+")
  for id in $ids; do
    grep -rlE "\b$id\b" wiki/concepts wiki/entities >/dev/null 2>&1 || echo "$id"
  done
}
S14=$(uncited wiki/architectural-gaps.md G)
if [ -z "$S14" ]; then
  echo "S14 OK        every gap row is cited by at least one page"
else
  echo "S14 VIOLATED  gap rows no page cites:"; echo "$S14" | tr '\n' ' ' | sed 's/^/              /'; echo; FAIL=1
fi
UNCITED_T=$(uncited wiki/empirical-tensions.md T | wc -l | tr -d ' ')
echo "S14 note      $UNCITED_T of $TENSIONS tension rows are cited by no page (tracked, not enforced)"

# S18: S14 asks only that SOME page cites a gap. The stronger relation is
# provenance: a gap's "## From" names the pages that carry it, and each of those
# should cite the gap back. A page named in From that never says the id is a gap
# whose own source page does not know it exists. Tracked, not enforced --
# a From entry may name a page as context rather than as carrier.
S18=$(python3 - <<'PYEOF'
import re, glob, os
n = 0
for f in sorted(glob.glob('wiki/gaps/g*.md')):
    rid = 'G' + str(int(re.sub(r'\D', '', os.path.basename(f))))
    m = re.search(r'\n## From\n(.*?)(\n## |\Z)', open(f).read(), re.S)
    if not m:
        continue
    for t in sorted(set(re.findall(r'wiki/(?:concepts|entities)/[a-z0-9-]+\.md', m.group(1)))):
        if os.path.exists(t) and not re.search(r'\b' + rid + r'\b', open(t).read()):
            n += 1
print(n)
PYEOF
)
echo "S18 note      $S18 gap From-edges where the named carrying page never cites the row (tracked, not enforced)"

# S15: the queue must reconcile exactly against raw/. Every source file is either
# ingested (- [x]), skipped at the gate (- [-]) or still pending (- [ ]); every queue entry has a file.
SKIPPED=$(grep -c '^- \[-\]' _work/ingest-queue.md || true)
PENDING=$(grep -c '^- \[ \]' _work/ingest-queue.md || true)
RAWFILES=$(cd raw && ls *.md *.txt 2>/dev/null | wc -l | tr -d ' ')
QNAMES=$(grep -oE '^- \[[x  -]\] `[^`]+`' _work/ingest-queue.md | grep -oE '`[^`]+`' | tr -d '`' | sort -u)
ORPHAN_Q=$(for f in $QNAMES; do [ -f "raw/$f" ] || echo "$f"; done)
UNQUEUED=$(cd raw && for f in *.md *.txt; do echo "$QNAMES" | grep -qxF "$f" || echo "$f"; done)
if [ $((SOURCES + SKIPPED + PENDING)) -eq "$RAWFILES" ] && [ -z "$ORPHAN_Q" ] && [ -z "$UNQUEUED" ]; then
  echo "S15 OK        queue reconciles with raw/: $SOURCES ingested + $SKIPPED skipped + $PENDING pending = $RAWFILES files"
else
  echo "S15 VIOLATED  $SOURCES ingested + $SKIPPED skipped + $PENDING pending vs $RAWFILES files in raw/"
  [ -n "$ORPHAN_Q" ] && { echo "              queued with no file:"; echo "$ORPHAN_Q" | sed 's/^/                /'; }
  [ -n "$UNQUEUED" ] && { echo "              in raw/ but not queued:"; echo "$UNQUEUED" | sed 's/^/                /'; }
  FAIL=1
fi

# S13: no glossary key may appear twice. A genuine collision between two different
# expansions is disambiguated in the key itself, e.g. "RC (reservoir computing)".
S13=$(awk '/^\| / && $0 !~ /^\|[- :|]+\|$/ && $0 !~ /^\| *Abbrev/{split($0,a,"|");k=a[2];gsub(/^ +| +$/,"",k);print k}' wiki/glossary.md | sort | uniq -d)
if [ -z "$S13" ]; then
  echo "S13 OK        no duplicate glossary key"
else
  echo "S13 VIOLATED  duplicate glossary keys:"; echo "$S13" | sed 's/^/              /'; FAIL=1
fi

# S16: the registry index tables must be exactly what tools/registry-index.py derives
# from the detail files under wiki/gaps/ and wiki/tensions/. Rebuilding is a no-op when
# they agree, so run it on a scratch copy of the repo state and diff.
S16TMP=$(mktemp -d)
cp wiki/architectural-gaps.md wiki/empirical-tensions.md "$S16TMP/"
python3 tools/registry-index.py >/dev/null 2>&1
if diff -q "$S16TMP/architectural-gaps.md" wiki/architectural-gaps.md >/dev/null &&
   diff -q "$S16TMP/empirical-tensions.md" wiki/empirical-tensions.md >/dev/null; then
  echo "S16 OK        both registry indexes match their detail files"
else
  echo "S16 VIOLATED  a registry index was hand-edited or a detail file changed without a rebuild"
  echo "              tools/registry-index.py has already rewritten them; review the diff"
  FAIL=1
fi
rm -rf "$S16TMP"

# S17: every registry detail file names the observation that would retire it.
S17=$(grep -L 'Closes when:\*\* [^_]' wiki/gaps/g[0-9]*.md wiki/tensions/t[0-9]*.md 2>/dev/null)
if [ -z "$S17" ]; then
  echo "S17 OK        every registry row has a Closes when"
else
  echo "S17 VIOLATED  $(echo "$S17" | wc -l | tr -d ' ') rows have no Closes when:"
  echo "$S17" | sed 's/^/              /'; FAIL=1
fi

exit $FAIL
