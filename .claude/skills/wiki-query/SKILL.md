---
name: wiki-query
description: Answer a research question from the wiki — search, read the relevant pages, synthesize an answer grounded in the wiki content.
---

# QUERY

Answer from the wiki first, then update it if new insights revealed.

## Steps

1. **Search** on the question terms:
   ```bash
   ./tools/qmd-index.sh search "query terms"
   ```
   Fall back to `grep -r "terms" wiki/` if qmd errors.
2. **Read `wiki/index-concepts.md` + `wiki/index-entities.md`** to make sure the search did not miss an obvious page.
3. **Read all relevant pages** — in parallel, in full.
4. **Synthesize.** Cite wiki pages as `[[wiki/path/page.md]]`. Where the wiki cannot answer or the answer cannot be derived from it, say so explicitly, give your own opinion, and name concrete sources worth ingesting.
7. **Propose an update plan if** the query and the synthesis reveal new important insights.