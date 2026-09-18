---
name: wiki-acquire
description: Acquire the next wave of sources — pick targets from the open gap/tension registries, resolve each to a clip-optimal HTML URL, probe it, and hand the user a want-list to clip with Obsidian Web Clipper; then validate and file what lands in raw/. Use when the ingest queue is empty or thin, when the user asks what to read or collect next, when a lint pass leaves acquisition tasks blocked on "human curation or a web-search pass", or when the user drops freshly clipped files in raw/.
---

# ACQUIRE

Turn open registry rows into a queue of clippable sources. **Fourth core operation**, upstream of `INGEST`.

Two halves, run in either order:
- **A — build the want-list** (targets → URLs → `_work/want-list.md`). The user clips.
- **B — file the drop** (`raw/*.md` → validated → manifest → queue). Then `INGEST` runs.

---

## A — Build the want-list

1. **Read the demand side, not the supply side.** `wiki/priority-tasks.md` (the `Acquire …` rows and `Blocked on: human curation or a web-search pass`), then `wiki/architectural-gaps.md` and `wiki/empirical-tensions.md`. A target is admissible only if it names the `G`/`T` row it addresses **and the decision that row cannot currently make**. No topic-shaped targets.
2. **Prefer rows that are cheap to settle**: read the indexes to shortlist by `Status` token and `Cited by` count, then open the shortlisted `wiki/gaps/gNNN.md` / `wiki/tensions/tNNN.md` for the detail — a row's `Closes when` field states exactly what a source must supply. Cheap rows: a `LIVE` tension between two named positions that have never been run head-to-head; a gap whose `Best current answer` is a brainstorm; an instrument (`I…`) with no primary source; an artefact cited second-hand on ≥3 pages with no file in `raw/`.
3. **Search** for the canonical source (`WebSearch`), then **resolve to a clip-optimal URL** — see the two tables below. The URL, not the DOI, is the deliverable. A URL on an **excluded venue** never reaches the user: re-resolve it to a mirror, or drop the target and say which registry row stays unsettled.
4. **Probe every URL with `WebFetch`** before it reaches the user. Classify:

   | Verdict | Meaning | Route |
   |---|---|---|
   | `clip` | full HTML article, equations and figures inline | **user clips** |
   | `self` | **open** page, text-only and equation-light (blog, docs, leaderboard, model card) | **I fetch and write `raw/` myself** |
   | `stub` | landing page, abstract-only, or a JavaScript shell | re-resolve to another venue |
   | `pdf-only` | no HTML anywhere | **the user downloads the PDF** into `raw/` — I have no institutional session and cannot fetch it — then I run `./tools/pdf2md.sh` and flag the manifest row `LOSSY` |

   `self` requires the page to be **open**, not merely text-only: an institution-gated
   page returns its paywall wrapper to `WebFetch`, which `clip-check.sh` then `FAIL`s as a
   stub. Gated pages are always `clip`, whatever their content looks like.

5. **Write `_work/want-list.md`** — one row per target, columns fixed by the file's header. Group by the wave block it will form.
6. **Hand over.** State the clip count, the self-clip count, and what each block closes.

### Clip-URL preference order

The user has **institutional access (UBO Brest)**, so a paywall is not a filter. The filter is **HTML vs PDF** — a PDF conversion is lossy on exactly the equations and figures the wiki needs.

| Venue | Resolve to | Note |
|---|---|---|
| arXiv | `arxiv.org/html/<id>` → else `ar5iv.labs.arxiv.org/html/<id>` | real MathML. **Never** `/pdf/` |
| Nature · Cell · Science · Neuron · PNAS | publisher HTML article page | reachable through the institution; richer than the mirror — prefer it |
| Biomedical with no good publisher HTML | `pmc.ncbi.nlm.nih.gov/articles/PMC…` | always open, tables as HTML |
| eLife · PLOS · Frontiers · MDPI | publisher HTML | open and HTML-native |
| Blogs · LessWrong · Alignment Forum · Distill · Transformer Circuits | canonical post | already HTML |
| Benchmarks · leaderboards · docs · model cards | the page itself | `self` route |
| `onlinelibrary.wiley.com` (Hippocampus, Eur. J. Neurosci., …) | PMC mirror if one exists → else the `pdf` route | Wiley serves the article as PDF only: the DOI page is a landing shell, so a clip captures nothing. Reachable through the institution — a format limit, not an exclusion, so it never belongs in the excluded-venues table. Evidence: Lavenex 2000, Teyler 2007 (wave 22) |
| Books, pre-2000 papers, scans | user downloads the PDF to `raw/`, then `./tools/pdf2md.sh` | flag `LOSSY` in the manifest. `--layout` for table-heavy sources; the script falls back to the OCR layer on scans |

### Excluded venues — outside the institutional subscription

The institution (UBO Brest) does **not** cover these. A target here is not a `clip`: the user
hits the same paywall `WebFetch` does, and the row sits `open` on the want-list forever. `WebFetch`
cannot tell this apart from a bot-block, so the list is the only source of truth — **check it
before probing**.

| Excluded | Scope | Evidence | Do instead |
|---|---|---|---|
| `science.org` | Science, Science Advances, all AAAS titles | Mongillo, Barak & Tsodyks 2008 (wave 20 row 9) — never obtainable | PMC mirror, author copy, or `pdf` route from an author PDF; else drop |
| `academic.oup.com/cercor` | Cerebral Cortex only — **`academic.oup.com/brain` is covered** (manifest rows 368, 369) | Elston 2003 (wave 20 row 11) — never obtainable | PMC mirror; else drop |

Maintenance: the moment the user reports a target they could not reach, add a row here with the
target that proved it and the narrowest scope that is actually blocked (a title, not a publisher,
unless the whole publisher is blocked). Then retire the want-list row per that file's rule —
one *Not acquired* line in `_work/ingest-queue.md`, then delete it.

---

## B — File the drop

1. **Validate:** `./tools/clip-check.sh` (no arguments = every untracked file in `raw/`). It exits non-zero on any `FAIL`.
2. **Repair or reject.** `FAIL` is reserved for *this file is not the article* — bad filename, too short, paywall stub, duplicate `source:`. Re-resolve the URL and re-clip rather than ingesting a stub. Frontmatter is **preferred, not required**: a missing `source:` only `WARN`s, at the cost of re-fetch and duplicate detection for that file — add one by hand when it is cheap.
3. **File:** `./tools/clip-check.sh --manifest <file>…` appends the `_work/manifest.tsv` row. Fill `topic`/`tier` by judgement — the script leaves them `?`.
4. **Queue:** append the entry to the wave block in `_work/ingest-queue.md`, then mirror the block into `priority-ingest.md`. Ordering within a wave is unchanged: **S**urvey → **F**ramework → **M**echanism/**B**enchmark → **R**esult → e**X**position, oldest first.
5. **Reconcile:** `./tools/wiki-stats.sh` must still satisfy `S15` (`sources + skipped = files in raw/`).

---

## Rules

- **Never clip a target that is not on the want-list** without first giving it a `G`/`T` row. Un-anchored acquisition is how a queue fills with sources no page needs.
- **Never put an excluded venue on the want-list.** A row the user cannot open is worse than no row: it blocks its `G`/`T` row silently.
- One wave ≈ **20 sources** ≈ one lint interval (`S2`).
- Do not batch-clip on the user's behalf by scraping; `self` route is for pages `WebFetch` renders faithfully.
