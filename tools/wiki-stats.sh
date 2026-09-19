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

# S21: S1 checks that a Connections edge between two *pages* is answered. The same
# relation one level down -- a registry row citing another row by id in its body -- had
# no check at all, and two hand audits found 11 of 11 sampled references one-way
# (L33). Both write orders produce it: the new row citing the old one and never being
# cited back, and the ingest editing the old row to name the new one and never editing
# the new one back -- so the check runs over every row, not only new ones. The
# pre-existing one-way references are grandfathered in _work/rowref-baseline.txt (each
# a standing repair candidate for LINT, not a failure), on the S19 pattern; a pair
# outside that file is a reference this wave wrote and did not answer. Hard fail.
S21RAW=$(python3 - <<'PYEOF'
import re, glob, os
files = {}
for d, pre in (('wiki/gaps', 'G'), ('wiki/tensions', 'T')):
    for f in glob.glob(d + '/*.md') + glob.glob(d + '/closed/*.md'):
        m = re.match(r'^[gt](\d+)\.md$', os.path.basename(f))
        if m:
            files[pre + str(int(m.group(1)))] = f
txt = {k: open(v).read() for k, v in files.items()}
out = []
for rid in files:
    for ref in sorted(set(re.findall(r'`([GT]\d+)`', txt[rid]))):
        if ref != rid and ref in files and not re.search(r'\b' + rid + r'\b', txt[ref]):
            out.append(rid + ' -> ' + ref)
print('\n'.join(sorted(out)))
PYEOF
)
S21=$(comm -23 <(printf '%s\n' "$S21RAW") <(LC_ALL=C sort _work/rowref-baseline.txt))
S21N=$(printf '%s\n' "$S21RAW" | grep -c . || true)
if [ -z "$S21" ]; then
  echo "S21 OK        no new one-way row-to-row reference ($S21N grandfathered)"
else
  echo "S21 VIOLATED  $(echo "$S21" | wc -l | tr -d ' ') row references a wave wrote and did not answer:"
  echo "$S21" | sed 's/^/              /'; FAIL=1
fi
S21STALE=$(comm -13 <(printf '%s\n' "$S21RAW") <(LC_ALL=C sort _work/rowref-baseline.txt) | wc -l | tr -d ' ')
[ "$S21STALE" -gt 0 ] && echo "S21 note      $S21STALE baseline pairs are now symmetric or gone -- prune _work/rowref-baseline.txt"

# S15: the queue must reconcile exactly against raw/. Every source file is either
# ingested (- [x]), skipped at the gate (- [-]) or still pending (- [ ]); every queue entry has a file.
SKIPPED=$(grep -c '^- \[-\]' _work/ingest-queue.md || true)
PENDING=$(grep -c '^- \[ \]' _work/ingest-queue.md || true)
# L35 (lint 27): the two membership tests were ~480 short-lived `echo | grep -qxF`
# pipelines whose reader exits on the first match -- the same SIGPIPE-under-pipefail
# hazard S1's header documents -- and S15 twice named an already-queued file as
# unqueued while the arithmetic on the same run reconciled. Both sets are now one
# `comm` over two sorted lists: no early-exiting reader, ~480x fewer processes, and
# the two halves of the check are derived from the same pair of lists.
RAWNAMES=$(cd raw && ls *.md *.txt 2>/dev/null | LC_ALL=C sort -u)
RAWFILES=$(printf '%s\n' "$RAWNAMES" | grep -c . || true)
QNAMES=$(grep -oE '^- \[[x  -]\] `[^`]+`' _work/ingest-queue.md | grep -oE '`[^`]+`' | tr -d '`' | LC_ALL=C sort -u)
ORPHAN_Q=$(comm -23 <(printf '%s\n' "$QNAMES") <(printf '%s\n' "$RAWNAMES"))
UNQUEUED=$(comm -13 <(printf '%s\n' "$QNAMES") <(printf '%s\n' "$RAWNAMES"))
if [ $((SOURCES + SKIPPED + PENDING)) -eq "$RAWFILES" ] && [ -z "$ORPHAN_Q" ] && [ -z "$UNQUEUED" ]; then
  echo "S15 OK        queue reconciles with raw/: $SOURCES ingested + $SKIPPED skipped + $PENDING pending = $RAWFILES files"
else
  echo "S15 VIOLATED  $SOURCES ingested + $SKIPPED skipped + $PENDING pending vs $RAWFILES files in raw/"
  [ -n "$ORPHAN_Q" ] && { echo "              queued with no file:"; echo "$ORPHAN_Q" | sed 's/^/                /'; }
  [ -n "$UNQUEUED" ] && { echo "              in raw/ but not queued:"; echo "$UNQUEUED" | sed 's/^/                /'; }
  FAIL=1
fi

# S20: a pending queue row must be *true*. S15 reconciles an arithmetic identity
# over three terms and never asks whether a `- [ ]` is still unread, so a queue that
# stopped being maintained certifies itself: on entry to lint 27 the sum was exact at
# 467 + 1 + 13 = 481 and all thirteen pending terms were false (L30/L32, third
# recurrence, 28 rows then 17 then 13 of 13). Ingest commits are named by the source
# slug, so the evidence is one string match per pending row. Positive evidence only:
# a source ingested before the naming convention leaves no commit, so a missing match
# is not a claim that the row is genuinely pending -- a *present* match is proof it is
# not. Hard fail, because every self-count the wiki publishes descends from this file.
GITLOG=$(git log --format=%s)
S20=$(for f in $(grep -oE '^- \[ \] `[^`]+`' _work/ingest-queue.md | grep -oE '`[^`]+`' | tr -d '`'); do
    slug=$(echo "${f%.*}" | cut -d- -f1,2)
    [[ "$GITLOG" == *"ingest($slug)"* ]] && echo "$f -- ingest($slug) is in the git log"
  done)
if [ -z "$S20" ]; then
  echo "S20 OK        no pending queue row has an ingest commit behind it ($PENDING pending)"
else
  echo "S20 VIOLATED  $(echo "$S20" | wc -l | tr -d ' ') of $PENDING pending rows were ingested and never ticked:"
  echo "$S20" | sed 's/^/              /'; FAIL=1
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

# S19: the level-admission rule. A registry row may be opened only at L0, L1, L2
# or L0-INSTR. L3/L4 material belongs in a concept/entity page body, where search
# finds it when a realization is finally chosen; as a registry row it is carried by
# every later lint for nothing. The L3/L4 rows that predate the rule are
# grandfathered in _work/level-baseline.txt (each is a standing demotion candidate
# for LINT, not a failure); anything L3/L4 outside that file is a new row that broke
# the rule. The spec-slot exception was removed with the spec (012c108); the check
# was deleted with it and restored at lint(23) without the clause.
L34=$(grep -lE '^\*\*Level:\*\* `L[34]`' wiki/gaps/g[0-9]*.md wiki/tensions/t[0-9]*.md 2>/dev/null | sort)
S19=$(comm -23 <(echo "$L34") <(sort _work/level-baseline.txt))
if [ -z "$S19" ]; then
  echo "S19 OK        no registry row opened at L3/L4 since the ladder rule ($(wc -l < _work/level-baseline.txt | tr -d ' ') grandfathered)"
else
  echo "S19 VIOLATED  rows opened at L3/L4 against the admission rule:"
  echo "$S19" | sed 's/^/              /'; FAIL=1
fi
# A baseline entry that is no longer an L3/L4 row (re-levelled or retired) inflates
# the grandfather count; tracked, not enforced.
S19STALE=$(comm -13 <(echo "$L34") <(sort _work/level-baseline.txt) | wc -l | tr -d ' ')
[ "$S19STALE" -gt 0 ] && echo "S19 note      $S19STALE baseline entries are no longer L3/L4 rows -- prune _work/level-baseline.txt"

exit $FAIL
