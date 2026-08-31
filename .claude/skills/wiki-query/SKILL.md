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
   If the question is about what is unsolved or disputed, read the registry indexes `wiki/architectural-gaps.md` / `wiki/empirical-tensions.md` — one line per row — and open `wiki/gaps/gNNN.md` or `wiki/tensions/tNNN.md` only for the rows the answer turns on. A row's `Closes when` field is the fastest answer to "what would settle this?".
3. **Read all relevant pages** — in parallel, in full.
4. **Synthesize.** Cite wiki pages as `[[wiki/path/page.md]]`. Where the wiki cannot answer or the answer cannot be derived from it, say so explicitly, give your own opinion, and name concrete sources worth ingesting. Keep in mind
7. **Propose an update plan if** the query and the synthesis reveal new important insights.


## Talking to the user

The user understands machine learning well at a high level but is **not deeply
technical**, and is **less familiar with neuroscience**. So:

- In summaries and questions, use plain language. Spell out any symbol or piece of
  jargon in the same sentence you first use it ("the fast binding memory `M` — the
  scratchpad that holds *this* puzzle's specifics").
- Be explicit, never implicit. State the consequence, not just the change.
- When a decision is needed, surface it as a clearly-marked choice with concrete
  options, their consequences, and a recommendation. Never bury it in a paragraph.