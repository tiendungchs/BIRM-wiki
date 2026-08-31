---
name: wiki-lint
description: Audit the whole wiki for structural decay — orphan pages, thin or overloaded pages, missing cross-references, concepts mentioned everywhere but lacking a page, unexpanded abbreviations — then propose and apply fixes and refresh priority-tasks / empirical-tensions. Use when the user says "lint the wiki", asks for a health check or audit, or after roughly every 20 ingests.
---

# LINT

Structural maintenance pass over the whole wiki. Find decay, propose a fix plan then repair.

## Steps

0. **Check problematic works:** check to see if any operation coincides with any Opus 5 elevated error period, reported by https://status.claude.com/ , and discard or fix them if possible.
1. **Read all three indexes** — `wiki/index-concepts.md`, `wiki/index-entities.md` — to establish full coverage.
2. **Read the open-problem files:** the registry indexes `wiki/architectural-gaps.md` and `wiki/empirical-tensions.md` (one line per row), and `wiki/priority-tasks.md`. Open detail files under `wiki/gaps/` and `wiki/tensions/` only for the rows the pass actually audits. Past pass notes are in `wiki/registry-audit.md`.
3. **Read all relevant concept and entity pages.** Batch the reads; this is the expensive part and it is not optional.
4. **Check for:**
   - **Orphans** — pages with no inbound links from any other page.
   - **Under-coverage** — important concepts or entities with thin or missing pages.
   - **Implicit concepts** — ideas referenced across several pages that have no page of their own.
   - **Overloaded pages** — a concept/entity page doing the work of two or three; propose a split.
   - **Unexpanded abbreviations** — uncommon abbreviations not expanded inline and not in `wiki/glossary.md`.
   - **Index drift** — pages on disk that are missing from an index, or index entries pointing at pages that no longer exist.
5. **Propose a plan** Order it: fixes applicable immediately first.
6. **Update indexes:** `wiki/index-concepts.md` / `wiki/index-entities.md` if pages were created.
7. **Refresh the registries** — edit detail files under `wiki/gaps/` and `wiki/tensions/`, `git mv` retired rows into `closed/`, add new ones as new files, then rebuild both index tables with `python3 tools/registry-index.py`. Never hand-edit an index table row. Append this pass's notes to `wiki/registry-audit.md`, not to the registry headers. Registry-specific checks:
   - Every detail file has a `**Closes when:**` naming an observation, not a wish. Rows still `_unset_` are lint debt.
   - `python3 tools/registry-index.py` reports rows cited by no concept or entity page — each is either wired to its carrying page or retired.
   - Rows whose `Closes when` is already satisfied by the wiki's own evidence are retired at this pass, not carried.

8. **Update** `wiki/priority-tasks.md` with fixes requiring multiple operations to apply, and new ingests to close the gaps/tensions (use WebSearch/WebFetch).
9. **Update cross-references** on every page touched, both directions.

## Useful checks

```bash
# orphan candidates: no inbound link from any content page.
# Must exclude the indexes (they list every page) and the page itself, or nothing is ever flagged.
for f in wiki/concepts/*.md wiki/entities/*.md; do
  n=$(grep -rlF "$f" wiki/concepts wiki/entities 2>/dev/null \
      | grep -vxF "$f" | wc -l | tr -d ' ')
  [ "$n" -eq 0 ] && echo "ORPHAN $f"
done

# index drift: pages on disk that no index lists
for f in wiki/concepts/*.md; do grep -qF "$f" wiki/index-concepts.md || echo "UNINDEXED $f"; done
for f in wiki/entities/*.md; do grep -qF "$f" wiki/index-entities.md || echo "UNINDEXED $f"; done
```

These are cheap pre-filters, not the audit. An "inbound link" found this way may be a bare mention rather than a real Connections entry — step 3 still requires reading the pages.

Re-index search after a lint that created or renamed pages:
```bash
./tools/qmd-index.sh
```