#!/usr/bin/env bash
# Emit every count the wiki publishes about itself, with the command that produces it.
# Called at the top of LINT (step 1) and by INGEST. See priority-tasks.md S10/L11.
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

# S5: the overview's published source count must equal the derived one.
CLAIMED=$(grep -oE '\*\*[0-9]+ sources ingested\*\*' wiki/overview.md | grep -oE '[0-9]+' | head -1)
echo
if [ "$CLAIMED" = "$SOURCES" ]; then
  echo "S5 OK        overview says $CLAIMED sources, derived $SOURCES"
else
  echo "S5 VIOLATED  overview says ${CLAIMED:-<none>} sources, derived $SOURCES"
  exit 1
fi
