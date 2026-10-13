# Want-list — sources to acquire

Produced by the `wiki-acquire` skill, part A. Consumed by the human's Obsidian Web Clipper.
Nothing is clipped that is not on this list; every row names the registry row it settles.

**This file holds the ACTIVE want-list only.** A row leaves it the moment it is filed
(it is then tracked in `_work/manifest.tsv` and `_work/ingest-queue.md`) or the moment it
is judged unreachable (recorded once under the wave's *Not acquired* line in
`_work/ingest-queue.md`, then dropped). No archive, no history — the gitlog is the changelog.

**Access:** institutional (UBO Brest) — a paywall is not a filter. The filter is **HTML vs PDF**:
a PDF conversion is lossy on exactly the equations and figures the wiki needs.

**Route column:** `clip` = human, Obsidian Web Clipper · `self` = Claude fetches and writes `raw/` ·
`pdf` = last resort, `./tools/pdf2md.sh`, flagged `LOSSY`.

**Status column:** `open` → `clipped` → `filed` (then the row is deleted from this file).

After clipping, drop the files in `raw/` and run:

```bash
./tools/clip-check.sh              # validate every untracked file in raw/
./tools/clip-check.sh --manifest raw/<file>.md   # then file the manifest row
```

---

## Active

**Wave 30 — what a bounded predictor must internalize.** Eighteen of nineteen rows were filed on
2026-10-13 (manifest 528–545, `_work/ingest-queue.md`). One row stays open: the clip must come from the
`/htm` view, not the article landing page.

### Block B — what fast learning costs in generality (`T16`, `G26`)

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| B4 | Rathmanner & Hutter 2011, *A philosophical treatise of universal induction* | `https://www.mdpi.com/1099-4300/13/6/1076/htm` | Entropy 13(6) | `clip` | `T16`, `G26` | **The readable form of B3, with the objections.** Epicurus, Occam, Bayes and Turing combined into Solomonoff induction, then the known problems: the choice of reference machine, the structure-blindness of a length prior, the gap between the mixture's asymptotic guarantee and a single finite program. The last is `T16`'s own caveat (passive mixture against finite-horizon program), so this is the source that keeps the two regimes apart. Open HTML; MDPI blocks the fetcher. **First clip (2026-10-13, from the `/1076` landing URL) captured only the abstract and references, 1293 words: re-clip from the `/htm` view, which carries the full article body** | `open` |

One row: one `clip`. It gives `T16` the readable form of its Position A primary (Solomonoff 1964, filed)
with the objections, including the passive-mixture-versus-finite-program caveat that is `T16`'s own.
