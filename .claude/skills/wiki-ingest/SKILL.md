---
name: wiki-ingest
description: Ingest a new source into the wiki — read a document in raw/, decide whether it helps build a reasoning model, then fold its takeaways into concept/entity pages, and update indexes, cross-references. Use when the user drops a file in raw/ and says "ingest X", asks to add a paper/article/talk to the wiki, or pastes a source to be filed.
---

# INGEST

Fold a source into the wiki so the insight lives on concept/entity pages.

## Steps (in order)

1. **Read the source file fully.** Never ingest from an abstract or a skim.
2. **Read** `wiki/index-concepts.md`, `wiki/index-entities.md`, and `wiki/architectural-gaps.md` to know what exists and what the wiki needs.
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
9. **Handle contradictions.** If the source contradicts an existing wiki claim, add a row to `wiki/empirical-tensions.md` and update the prose on the affected pages to carry both positions (or the settled framing, if there is one).

## Scope discipline

- Minimize prose: tables, bullets, equations. Every sentence must carry information relevant to building a reasoning model.
- Speculation is welcome but must be marked `(brainstorm)`; non-scientific-source claims get `(tentative)`.