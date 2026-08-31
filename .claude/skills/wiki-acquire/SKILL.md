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
3. **Search** for the canonical source (`WebSearch`), then **resolve to a clip-optimal URL** — see the table below. The URL, not the DOI, is the deliverable.
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
| Books, pre-2000 papers, scans | user downloads the PDF to `raw/`, then `./tools/pdf2md.sh` | flag `LOSSY` in the manifest. `--layout` for table-heavy sources; the script falls back to the OCR layer on scans |

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
- One wave ≈ **20 sources** ≈ one lint interval (`S2`).
- Do not batch-clip on the user's behalf by scraping; `self` route is for pages `WebFetch` renders faithfully.
