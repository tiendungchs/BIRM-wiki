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

### Wave 24 — the parse itself: visual understanding as a mechanism, not a substrate

From a QUERY pass asking whether visual understanding is covered. The answer is an **asymmetry
between the registries and the pages**, not a missing topic.

**The demand side is already written.** Seven rows name the problem and three of them are about
nothing else: `T215` (is the ARC visual/textual gap perceptual or a reasoning deficit — already
`LEANING B`, *perception*), `T191` (commit to one parse or carry several), `T151` (do objects live
in the architecture or in a read-out), `G75` (nothing chooses how to parse the input), `G73`
(nothing constructs a problem representation), `G27` (nothing supplies the discretisation),
`T154` (does a control-usable visual model need foundation-scale pretraining).

**The supply side is empty.** `wiki/concepts/` holds **no** page for any visual mechanism —
grep over all of `wiki/` returns **0** files for *visual routine*, *active vision*, *perceptual
grouping*, *object file*, *FINST*, *multiple object tracking*, *mental imagery*, *what-where*;
1 for *figure-ground*, 2 for *slot attention*, 2 for *dorsal stream*, 2 for *numerosity*.
Of 444 files in `raw/`, ~17 touch vision and nearly all use it as a **substrate** for something
else — predictive coding (`rao-1999`, `kerjan-2026`), replay (`ji-2007`), cognitive maps
(`gornet-2024`) — or as an **SSL objective** (DINOv2/3, I-JEPA, V-JEPA-2, MAE, BYOL, VICReg,
LeJEPA), or as **robustness scoring** (ImageNet-C, ObjectNet, Stylized-ImageNet). The three
entities that do hold a parse ([[wiki/entities/spelkenet.md]], [[wiki/entities/arc-vsa-solver.md]],
[[wiki/entities/resonator-network.md]]) each declare their factors before the task is seen, which
is exactly what `G75` records as the unanswered half.

So the wiki can *state* that perception is the bottleneck and cannot say **what a perceptual
mechanism is made of**. This wave buys the mechanism vocabulary (block A) and the measurements
that price it on ARC-format tasks (block B).

**Probe results, all 2026-09-18.** `arxiv.org/html/…` renders full body, equations and tables
inline for rows 8–11 (figures are `<img>` references, which the clipper follows). `biorxiv.org/…v2.full`
renders but `WebFetch` truncates mid-Results — `clip`, not `self`, on the wave-23 eLife precedent.
`annualreviews.org` answers `403` (bot-block, not a paywall verdict; Annual Reviews is not on the
excluded-venues table) — `clip`, with the ResearchGate author copy as fallback if UBO fails.
`nature.com` answers the usual `303 → idp.nature.com` session wall — `clip`, precedent from waves
22–23. Rows 1, 4 and 5 are `pdf`: Elsevier serves pre-1995 *Cognition* as a scan, and rows 4–5
have open author copies that are PDF-native. No target sits on an excluded venue; none duplicates
a `_work/manifest.tsv` row.

#### A — what a visual mechanism is made of

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 1 | Ullman 1984, *Visual routines* | `https://www.sciencedirect.com/science/article/abs/pii/0010027784900234` | Cognition 18(1–3):97–159 | `pdf` | `G75`, `G73`, `T191` | **The only account in the literature where the parse is a *program* rather than a setting.** A small set of elemental operations — shift of processing focus, indexing, boundary tracing, marking, bounded activation (colouring) — assembled *per task* into a routine over a base representation. `G75`'s `Closes when` asks for a model that chooses its decomposition per task from an open space rather than a fixed menu; this is the specification of what that open space would be made of, and it is the piece [[wiki/entities/arc-vsa-solver.md]]'s six-hypothesis menu is a degenerate case of. Try the ScienceDirect HTML first — if it is a scan, download and flag `LOSSY` | `open` |
| 2 | Roelfsema 2006, *Cortical algorithms for perceptual grouping* | `https://www.annualreviews.org/content/journals/10.1146/annurev.neuro.29.051605.112939` | Annu. Rev. Neurosci. 29:203–227 | `clip` | `G27`, `T278`, `T151` | **The criterion `G27` has been asking for, computed rather than declared.** Splits grouping in two: *base-grouping*, coded by single cells tuned to feature conjunctions, fast because it is feedforward selectivity; and *incremental grouping*, which spreads response enhancement over horizontal and feedback connections and therefore **costs time proportional to the thing being grouped**. That time cost is a measurable stopping condition — the same role the deflation loop plays in [[wiki/entities/resonator-network.md]], but with the factors not declared in advance. `T278` (is a feedforward pass sufficient) gets its cleanest statement of what the recurrence is *for* | `open` |
| 3 | Roelfsema group 2024/2026, *How the visual brain can learn to parse images using a multiscale, incremental grouping process* | `https://www.biorxiv.org/content/10.1101/2024.06.17.599272v2.full` | bioRxiv 2024.06.17.599272 (v2); PMID 41984938 | `clip` | `G75`, `T151`, `G34` | **A parser whose grouping criterion is *learned*, which is the thing neither `T151` position has.** Position A (slot architectures) fixes `K` at design time and does not scale to real scenes; position B (SpelkeNet) recovers objects post hoc at `R×T` rollouts per segment and hands a planner no variable. A trained multiscale incremental grouper is the third option the row has never been given, and it is the only candidate in reach where the parse is both learned *and* leaves a persistent tag a downstream reader can bind to | `open` |
| 4 | Pylyshyn 2001, *Visual indexes, preconceptual objects, and situated vision* | `https://ruccs.rutgers.edu/images/archive/personal-zenon-pylyshyn/docs/cognition2001-reprint.pdf` | Cognition 80(1–2):127–158 · open author reprint | `pdf` | `G39`, `G75`, `T191` | **A pointer to a thing that does not categorise the thing — the wiki has no such object.** FINSTs individuate and track 4–6 items across changes in their properties and locations, *before* any conceptual description, so a relation can be computed over individuals without those individuals being described. `G39` (nothing anchors a retrieved structure to the present situation) is this problem stated from the memory side; ARC-AGI-3's frame sequences are it stated from the benchmark side — "the same object, one turn later" is unavailable to every architecture in the wiki. Also gives `T191` its missing middle: carry several *indices*, one parse | `open` |
| 5 | Ballard, Hayhoe, Pook & Rao 1997, *Deictic codes for the embodiment of cognition* | `https://www.cs.utexas.edu/~dana/bbs.pdf` | Behav. Brain Sci. 20(4):723–767 · open author copy | `pdf` | `G25`, `G32`, `G73` | **Perception as a sequence of actions, priced in actions — which is [[wiki/entities/arc-agi-3.md]]'s own scoring rule.** Deictic strategies ("do it where I am looking") replace a full scene representation with a fixation that binds a variable to a location, collapsing the computation at the cost of a serial schedule. `G25` (optimality cannot be certified for an agent whose actions shape its data) and `G32` (nothing designs the experience stream) are both about this loop and neither holds a source in which *looking* is one of the actions. The wiki's attention pages ([[wiki/concepts/attention.md]], [[wiki/concepts/priority-map.md]]) describe selection; none describes selection as a move | `open` |
| 6 | Pearson 2019, *The human imagination: the cognitive neuroscience of visual mental imagery* | `https://www.nature.com/articles/s41583-019-0202-9` | Nat. Rev. Neurosci. 20:624–634 | `clip` | `G90`, `G15` | **`G90`'s `Closes when` asks for an internally generated mode that competes with the input-driven one — this is that mode, in the one modality where its strength is measurable.** Imagery runs the sensory hierarchy backwards, is graded from aphantasia to hyperphantasia, and *competes* with afferent perception in a way that binocular-rivalry priming quantifies. `G90` is an `arrangement` row, so it will not be closed by a component; what it needs first is a worked case of the arbitration, and this supplies one with a dial on it. `G15` (no control policy over simulation) reads the same material as the question of what turns the mode on | `open` |
| 7 | Kravitz, Saleem, Baker & Mishkin 2011, *A new neural framework for visuospatial processing* | `https://www.nature.com/articles/nrn3008` | Nat. Rev. Neurosci. 12:217–230 | `clip` | `G30`, `T47`, `G43` | **The wiki holds the `what` pathway ([[wiki/entities/ventral-visual-stream.md]]) and has 2 mentions of the `where` one.** Three distinct dorsal pathways — parieto-prefrontal, parieto-premotor, parieto-medial-temporal (via posterior cingulate and retrosplenial) — each with its own targets, which is why "where/how" is the wrong label. `G30` says the `g`/`x` factorization occupies one slot of three; the spatial-relation code that a grid task runs almost entirely on lives in the slot the wiki has never opened. Lands directly on the new [[wiki/entities/retrosplenial-cortex.md]] via the third pathway | `open` |
| 8 | Nieder 2016, *The neuronal code for number* | `https://www.nature.com/articles/nrn.2016.40` | Nat. Rev. Neurosci. 17(6):366–382 | `clip` | `G4`, `G27` | **One vocabulary primitive with a measured code and a stated grain — which is what `G4` says nobody supplies.** Number neurons encode cardinality invariantly across modality and across simultaneous vs sequential presentation, with a tuning width that sets the grain by a stated principle (Weber scaling) rather than by the author's hand. Every ARC-format task set counts, and no wiki page says how a count is represented. Small-n subitizing vs large-n estimation is also a concrete instance of `G27`'s discretisation question at a scale where the answer is known | `open` |

#### B — what it costs, measured on ARC-format tasks

| # | Target | Clip URL | Venue | Route | Closes | Settles | Status |
|---|---|---|---|---|---|---|---|
| 9 | Wang, Huang, Zhang, Wang & Ma 2026, *Your Reasoning Benchmark May Not Test Reasoning: Revealing Perception Bottleneck in Abstract Reasoning Benchmarks* | `https://arxiv.org/html/2512.21329` | arXiv 2512.21329v2, 2026-01-09 | `clip` | `T215`, `T291`, `G17` | **The highest-value row on the wave: it runs `T215`'s `Closes when` almost verbatim.** `T215` says the discriminating experiment is to supply the parse alongside the image and re-score, and calls it "cheap and unrun". This is an error-attribution protocol across Mini-ARC, ACRE and Bongard-LOGO concluding that perception, not reasoning, is the dominant factor in the human–model gap. If the protocol matches, `T215` moves to `RESOLVED B` and **every ARC score in the wiki has to be re-read** as a joint perception-and-reasoning measurement. `T291` (has the capability been measured, or its deployment under one frame) is the same claim generalised | `open` |
| 10 | Rahmanzadehgervi, Bolton, Taesiri & Nguyen 2024, *Vision language models are blind* | `https://arxiv.org/html/2407.06581v6` | arXiv 2407.06581v6 · ACCV 2024 | `clip` | `T215`, `G17`, `G36` | **The floor under row 9, and a ready-made instrument.** BlindTest is 7 tasks no reasoning step survives — do two circles overlap, how many times do two lines intersect, count nested squares, count grid rows and columns, trace a single-coloured path. Four frontier VLMs average 58.07%; the best is 77.84% against a human 100%. Path tracing and row/column counting are *precisely* the operations an ARC grid demands, and they are measured in isolation from any rule. Candidate `I`-row instrument: a perception floor to report beside any ARC score | `open` |
| 11 | Li et al. 2025, *ARC Is a Vision Problem!* | `https://arxiv.org/html/2511.14761` | arXiv 2511.14761, 2025-11-18 | `clip` | `T215`, `G73`, `T154` | **The constructive answer to row 9 and the wave's one positive result.** Reformulates ARC as image-to-image translation on a canvas that carries the visual priors — vanilla ViT, trained from scratch on ARC data only, generalising to unseen tasks by test-time training: **60.4% on ARC-1**, competitive with frontier LLMs and close to average human. It is the cleanest existing evidence for `T215` position B, since the reasoning stack is *removed* and the score goes up. `T154` gets its counterexample: no foundation-scale pretraining at all. Pairs against [[wiki/concepts/test-time-training.md]] | `open` |
| 12 | Acuaviva, Davtyan, Hassan, Stapf, Rahimi, Alahi & Favaro 2025, *Rethinking Visual Intelligence: Insights from Video Pretraining* | `https://arxiv.org/html/2510.24448` | arXiv 2510.24448v2, 2025-11-03 | `clip` | `T154`, `G95`, `T151` | The row that keeps 11 honest by taking the other side. Video diffusion models adapted with LoRA are compared against LLMs on ARC-AGI (16.75% two-attempt, CogVideoX1.5-5B), ConceptARC across 16 concept categories, plus Sudoku, mazes and cellular automata — the claim being that **spatiotemporal pretraining is where the structural inductive bias comes from**. `T154` position A with a new corpus type; `G95` reads it as an invariance group discovered from dynamics rather than declared by an augmentation list. Rows 11 and 12 disagree about whether the prior must be pretrained, on overlapping task sets — ingest as a tension candidate | `open` |

**Counts.** 12 targets: **9 `clip`**, **3 `pdf`** (rows 1, 4, 5 — rows 4 and 5 are open author
copies, row 1 may be a scan), **0 `self`**. Block A closes work on `G4`, `G15`, `G25`, `G27`,
`G30`, `G32`, `G34`, `G39`, `G43`, `G73`, `G75`, `G90`, `T47`, `T151`, `T191` and `T278`;
block B on `G17`, `G36`, `G73`, `G95`, `T151`, `T154`, `T215` and `T291`. Nothing dropped at
resolution. Two pairs are deliberately opposed: rows 2–3 (declared vs learned grouping criterion)
and rows 11–12 (is the visual prior trainable from the task alone, or must it be pretrained).

**Expected pages after ingest:** `wiki/concepts/visual-routines.md`, `wiki/concepts/perceptual-grouping.md`,
`wiki/concepts/visual-indices.md`, `wiki/concepts/active-vision.md`, `wiki/concepts/mental-imagery.md`,
`wiki/concepts/numerosity.md`, `wiki/entities/dorsal-visual-stream.md`, `wiki/entities/varc.md`,
`wiki/entities/blindtest.md`. `G75` and `T215` are the two rows most likely to change status.
