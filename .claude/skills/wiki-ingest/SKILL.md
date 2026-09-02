---
name: wiki-ingest
description: Ingest a new source into the wiki — read a document in raw/, decide whether it helps build a reasoning model, then fold its takeaways into concept/entity pages, and update indexes, cross-references. Use when the user drops a file in raw/ and says "ingest X", asks to add a paper/article/talk to the wiki, or pastes a source to be filed.
---

# INGEST

Fold a source into the wiki so the insight lives on concept/entity pages.

## Steps (in order)

1. **Read the source file fully.** Never ingest from an abstract or a skim.
2. **Read** `wiki/index-concepts.md`, `wiki/index-entities.md`, and the gap index `wiki/architectural-gaps.md` to know what exists and what the wiki needs.
3. **Search for related pages** on the title and key terms:
   ```bash
   ./tools/qmd-index.sh search "query terms"
   ```
   Fall back to `grep -r "terms" wiki/` if qmd errors.
4. **Read all related pages in parallel** before editing any of them.
5. **Gate:** does this content add anything to help build a brain-inspired model capable of abstract reasoning? If not, skip the ingest.
6. **Integrate contents:** update related `wiki/concepts/` and `wiki/entities/` pages or create new ones if needed. Reference the new paper to all newly added claims.
7. **Update indexes:** `wiki/index-concepts.md` / `wiki/index-entities.md` if new pages were created.
8. **Update cross-references** both directions — new page → existing pages, and existing pages → new page. Each Connections entry states the *mechanism* of the relationship.
9. **Handle contradictions.** If the source contradicts an existing wiki claim, first apply the **admission rule** below. If the contradiction is admissible, create a tension: write `wiki/tensions/tNNN.md` (next free id — `Status` token, `Level` token, `Closes when`, `Position A`, `Position B`, `Where it bites`, `Status` reasoning), then run `python3 tools/registry-index.py` to fold it into `wiki/empirical-tensions.md`. Update the prose on the affected pages to carry both positions (or the settled framing, if there is one), and cite the row by id. If it is not admissible, the contradiction still goes into the page prose carrying both positions — it just gets no registry row.
10. **Registry edits go in the detail file, never in the index table.** Changing a gap's evidence means editing `wiki/gaps/gNNN.md`; changing its status means editing that file's `**Status:**` token. Rebuild with `python3 tools/registry-index.py`. If new evidence satisfies a row's `Closes when`, `git mv` the file into `closed/` and rebuild.

## Admission rule (registry rows)

A new registry row — gap or tension — may be opened **only** if either:

- its `**Level:**` is `L0`, `L1`, `L2` or `L0-INSTR`; **or**
- it closes an existing `§12` open slot in `_brainstorm/birm-spec.md`.

Levels: `L0` behaviour · `L0-INSTR` measurement validity, worked at `L0`
priority · `L1` decomposition · `L2` signal flow (including what is
*architecturally denied* to a reader) · `L3` realization · `L4`
substrate/instrument · `META`.

A source's `L3`/`L4` content is still ingested — it goes into the body of the
relevant concept or entity page, where search finds it when a realization is
finally chosen. It does **not** get a registry row: an unactionable row is
carried by every later lint for nothing.

Write the `**Level:**` token into the detail file at creation time;
`tools/registry-index.py` hard-errors without it.

## Scope discipline

- Minimize prose: tables, bullets, equations. Every sentence must carry information relevant to building a reasoning model.
- Speculation is welcome but must be marked `(brainstorm)`; non-scientific-source claims get `(tentative)`.