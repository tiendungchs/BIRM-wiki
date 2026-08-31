# Priority Tasks

What to read or write next. Derived from [[wiki/architectural-gaps.md]], from open problems on concept pages, and from lint passes. Reordered whenever a gap opens or closes.

## Status — lint pass, 302 sources

| Figure | Value | Command |
|---|---|---|
| Sources | **302** ingested, 1 skipped at gate, 303 files in `raw/` | `./tools/wiki-stats.sh` (`S15`) |
| Interval | **18 sources / 16 `INGEST` commits** since the 284 pass | `git log 36b194e..HEAD` |
| Waves | **13 closed at 10**, **14 closed at 8**; queue **exhausted** — 0 unchecked items | `grep -c '^- \[ \]' _work/ingest-queue.md` |
| Pages | 136 concepts, 118 entities, 5,735 `Connections` edges | `./tools/wiki-stats.sh` |
| Registries | 103 gaps (72 `OPEN`, 27 `PARTIAL`, 4 `CONTESTED`), 293 tensions (213 `LIVE`, 71 `LEANING`, 7 `BOTH`, 2 dual) — now index tables over `wiki/gaps/` and `wiki/tensions/`, 17 KB and 41 KB | `./tools/wiki-stats.sh`, `python3 tools/registry-index.py` |
| `S2` cadence | Honoured **six** times running: 19, 22, 20, 20, 20, **18** | — |

**Step 0 (source integrity): clean, second pass running, via the `S11` endpoint.** All 16 `INGEST` commits fall between `2026-08-22T03:47` and `2026-08-22T06:17`. Nearest incident window ended `2026-08-20T19:42` (major, multiple models); nearest Opus 5 window ended `2026-08-19T11:02`. **No ingest overlaps any incident. Nothing discarded.**

**Mechanical health: all eight checks green, `./tools/wiki-stats.sh` exits 0.** No orphans, no unindexed pages, no dead index entries, no broken links, no duplicate or missing `G`/`T` identifier, every page carrying `## Connections`, largest page 528 lines, smallest 69.

## The finding of this pass

**A check that is correct as an intention is not yet correct as a program, and this is the second consecutive pass where wiring one up produced hundreds of false positives on its first run.** Last pass: `S4` as written flagged **>500** rows and the true count was 4. This pass: `S1` as written flagged **765** asymmetric edges and the true count was **1**.

| Check | Defect in the prose version | Effect |
|---|---|---|
| `S1` | Pipeline ends in `grep -q`, which exits on first match and `SIGPIPE`s the upstream `awk`. Under `set -o pipefail` the pipeline then returns non-zero **on a match** | Every *symmetric* edge reported as asymmetric — 765 false positives, inverted semantics |
| `S1` (2nd) | `case` pattern's `)` inside `$( )` is mis-parsed by bash 3.2, the macOS system shell | Script would not run at all; `[[ ]]` used instead |
| `S14` | Never existed in any form | 5 gaps and 31 tensions cited by no page, invisible to every check for the wiki's whole history |

**Three consequences.**

1. **`S1`'s "wave-shaped cost" explanation from the last pass is refuted.** That pass attributed its 17 asymmetric edges (0.85/ingest, up 5.7×) to how many pages a wave *creates*. This interval created **13 new pages** — comparable to wave 12 — and produced **1** asymmetric edge, **0.056/ingest**. The spike was not a function of wave shape.
2. **The registries had no reachability check at all.** A row nothing cites is reachable from its own file and invisible from every page an ingest actually opens. `T105` — described in [[wiki/overview.md]] as *"the wiki's most damaging measurement result"* — was carried by **no page**. So were `T283`, `T284` and `T285`, all three created during this interval by the ingests that opened them.
3. **`S12` ran clean, which is its first real negative result.** Citation-overlap (≥3 shared sources *and* ≥3 shared pages) over all 396 rows returned **one** candidate, `G38`/`G42`, and reading it confirms siblings, not duplicates.

**Six checks moved from prose into `./tools/wiki-stats.sh` at this pass** (`S4`, `S1`, `S5b`, `S13`, `S14`, `S15`). The script now exits non-zero on any of them.

## Applied at this pass

| # | Fix | Detail |
|---|---|---|
| 1 | `G61`'s unescaped `H(A\|C)` | **Third consecutive pass** this expression class has broken a row (`G80` at 264, `G92` at 284). Escape `\|` inside any `H(·\|·)`, `p(·\|·)`, `·\|_{·}` written in a cell |
| 2 | `G104` had **no `From` cell** | Its `OPEN` token was being read as its source list |
| 3 | `wiki/index-concepts.md:33` missing trailing `\|` | The `developmental-heterochrony` row |
| 4 | `L14` closed — glossary reclassified | **64 of 108 `## Benchmarks` rows were machine-learning entries.** Now 378 / 231 / 47. One row (`RC`, recurrent collateral) was also misfiled in `## Machine learning` |
| 5 | **5 duplicate glossary keys merged** (`EMA`, `RPE`, `SIGReg`, `SWR`, `TVB`), 2 genuine collisions disambiguated in the key (`RC (reservoir computing)` / `RC (recurrent collateral)`, `SWA (slow-wave activity)` / `SWA (stochastic weight averaging)`) | New defect class; no check had ever looked. Now `S13` |
| 6 | 7 abbreviations added (`S6`) | `TTT`, `SimCLR`, `ResNet`, `GPT`, `ImageNet`, `MNIST`, `CIFAR-10/100` |
| 7 | `G98`'s bare `OPEN` normalised | Same defect as `G55`/`G67`/`G68` last pass; that pass matched the token, not the string |
| 8 | 9 reciprocal registry citations added | `G13`, `G55`, `G85`, `G92`, `G104`; `T105`, `T283`, `T284`, `T285`. `G38`↔`G42` linked both ways |
| 9 | [[wiki/overview.md]] **sections 16 and 17 written** | Waves 13 and 14. Header, `Key Open Problems` (2 rows), `Promising Directions` (6 entries) and `Major Controversies` (6 rows) brought forward |
| 10 | Six published self-counts corrected | 284→**302** sources, 126→136 concepts, 115→118 entities, 95→103 gaps, 277→**293** tensions, 236→293 in the controversies header |

*Closed at the registry restructure:* **`P1`**/**`L13`** (status is a token field again), **`P2`** (`Kind` column), **`L10`** (a gap cell is a file now).

*Closed:* **`P3`** — the human deleted **121 provenance blockquotes** from [[wiki/architectural-gaps.md]] at commit `0354006`; 2 KB of blockquote remains against 163 KB before. **`L14`** — glossary reclassified. **`L12`**, **`L11`** remain closed.

## Registry restructure (applied after the 302-source pass)

`architectural-gaps.md` and `empirical-tensions.md` were 356 KB and 641 KB — ~91k and ~164k tokens — and `wiki-ingest` read the gap file in full on **every ingest**. Both are now index tables only; each row's prose lives in its own file under `wiki/gaps/` or `wiki/tensions/`.

| # | Change | Effect |
|---|---|---|
| 1 | 103 gaps → `wiki/gaps/g001.md`…, 293 tensions → `wiki/tensions/t001.md`… | Verified byte-lossless against the original table cells for all 396 rows |
| 2 | Registries reduced to `id / title / status token / citation count / detail link` | 356 KB → 17 KB, 641 KB → 41 KB. Filenames unchanged, so the 233 + 245 pages citing `G`/`T` ids need no edit |
| 3 | `Status` is a token field again; reasoning moved to each detail file's `## Status` | **Closes `P1` / `L13`.** The column that held 137 KB of prose now holds one token |
| 4 | `part` / `arrangement` promoted from a header paragraph to a `Kind` column | **Closes `P2`.** `G84 G85 G88 G90 G91 G93` are the six `arrangement` rows |
| 5 | Historical lint-pass notes → [[wiki/registry-audit.md]] | Removed from every ingest's read path; append new pass notes there |
| 6 | `**Closes when:**` written on all 396 rows | Each names the observation that would retire it. No row could previously close because none had a criterion — which is why both registries had zero closed rows across their whole history |
| 7 | `tools/registry-index.py` rebuilds both tables from the detail files | Never hand-edit a table row. It also reports rows cited by no concept or entity page (`L15`) |
| 8 | `S16`, `S17` added to `./tools/wiki-stats.sh` | Index-matches-details, and every row has a `Closes when` |
| 9 | Oversized-cell audit (`L10`) is moot | A cell is now a file; `G37` at 17 KB is a 17 KB page, not a table row. Row prose no longer breaks the table, so the `\|`-escaping defect class (`G61`, `G80`, `G92` — three consecutive passes) cannot recur |

## Now

| # | Task | Why | Blocked on |
|---|---|---|---|
| P21 | **Acquire the next wave's sources — the queue is empty for the first time** | **New, and it is now the binding constraint.** 0 unchecked items across all 15 waves. Every remaining task in this file is either an experiment (`P4`–`P10`) or an acquisition (`P17`, `P19`, `P20`), and no ingest can happen until sources land. `P17`/`P19`/`P20` name the three highest-value targets | Human curation or a web-search pass |
| P4 | **Ablate the interface** — learnable hybrid unit vs fixed converter, matched architecture | *Carried.* `T235` is `LIVE — B asserted, not measured`. [[wiki/concepts/transthalamic-context-routing.md]] says a real inter-module edge carries **two cargoes on two routes**, so the thing to ablate may be the second channel | Ready to attempt |
| P12 | **Re-price `G37` against the retrieval result** | **Promoted from `Next`, and wave 13 is why.** [[wiki/entities/cn-dpm.md]] gives `G37` its first number: forgetting **0.0**, gating **48.18%** at five components and **31.14%** at twenty. `G37` is also the fastest-growing cell in the file (15,386 → **17,027**, +11%) | Ready to attempt |
| P6 | **Score one joint-embedding model on held-out *transformations*** | *Carried.* [[wiki/concepts/manifold-untangling.md]]'s criterion is strictly stronger than the linear probes seventeen entity pages report; one protocol change re-prices all of them and supplies `L6`'s missing column | Ready to attempt |
| P5 | **Report units-to-competence for anything** | *Carried.* The only admissible evidence for the spiking substrate if its advantage is unit *count* (`T234`). Derivable from existing runs | Ready to attempt |
| P22 | **Run the effective-model ladder on one wiki architecture** | **New, from wave 13.** [[wiki/concepts/multi-token-embedding.md]] supplies the wiki's first instrument that *prices* an interpretation: replace each component with the simplest stand-in, re-run end to end, report accuracy at every rung (100 → 98 → 90 → 94 → 85%). Directly runnable against [[wiki/entities/othellogpt.md]], which is `P13`(a) | Ready to attempt |
| P7 | **Run `I8` and `I9` against the wiki's own entity pages** | *Carried.* The two instruments needing nothing but the model itself. The inventory's cost ordering is still untested *as a claim* | Ready to attempt |
| P23 | **Re-score one benchmark null under a second frame** (`T291`) | **New, from wave 14, and the cheapest re-analysis in the file.** The comparative literature gets opposite answers from the same subjects under cooperative vs competitive framings. Every null in the wiki was collected under exactly one frame, so every one of them is ambiguous between *absent capability* and *undeployed capability* (`G102`) | Ready to attempt |
| P8 | **Collect a per-item human error *profile* on one benchmark** | *Carried.* Job 4 at [[wiki/concepts/human-baseline.md]] and `F4`: aggregate parity is compatible with an orthogonal mechanism (.90 vs .91 accuracy at **0.06** profile correlation) | Human curation, or a re-analysis request |
| P9 | **Build the write-mask experiment (`G52`), and build `G64` with it** | *Carried.* Still the cheapest concrete architecture proposal here. `P4` is its prerequisite. **Wave 13 supplies its baseline**: uniform reservoir sampling, which beat every priority rule tested | — |
| P10 | **Run the `g`/`x` objective search, collapse filter first** | *Carried.* `G30` remains the deepest gap. A candidate must separate a real structural code from a constant `g` ([[wiki/concepts/representational-collapse.md]]) | Ready to attempt |

## Next

| # | Task | Why | Blocked on |
|---|---|---|---|
| P24 | **Give one architecture a growth schedule** (`G100`) | **New, from wave 14, and it stopped being a metaphor.** [[wiki/concepts/developmental-heterochrony.md]] measures the shape: a **vector of per-module phase offsets** over a trajectory whose form is conserved, sparse (~4% of components), gray-matter-specific. Not "train it slower". Nothing in the wiki has any growth schedule at all | Ready to attempt |
| P11 | **Score architectures against the six hardness sources** | *Carried, unmoved for nine passes.* 118 entity pages, instrument still empty. A **facet vector**, not a scalar (`G13`, now cited from [[wiki/concepts/latent-graph-discovery.md]]) | Ready to attempt |
| P13 | **Run wave 7's two specified-and-unrun experiments.** (a) Probe/ablate OthelloGPT's end-game features (`T157`/`T158`). (b) LeJEPA rescaled-loss checkpoint ranking against a patch-token probe | *Carried.* **`P22` supplies the missing method for (a)** and `T285` supplies the reason to run it: the wiki's record says every "not decomposable" verdict so far dissolved under a better frame | Ready to attempt |
| P14 | Merge the two de-aliasing mechanisms on paper: [[wiki/entities/cscg.md]]'s frozen clone pools against path-integrated position | *Carried, unmoved for nine passes.* The clone-pool construction is the rate-level answer to element distinctness, which one spiking neuron computes in a single unit (`G80`) | — |
| P15 | **Run the `γ_effective` readout** | *Carried.* `T141` is `LIVE` and load-bearing: if the kernel is hyperbolic, `δ` is an error on a quantity with no stationary value function | Ready to attempt |
| P16 | **Instrument one existing store with a read log** | *Carried, and wave 13 gives it a number to beat.* [[wiki/entities/cn-dpm.md]]'s gate scores 31.14% at twenty components. Log *which* structure was retrieved and score the schedule separately from the contents | Ready to attempt |
| P17 | Acquire a source on **conditional or gated inductive bias** (mixture-of-experts routing, typed representations, neuro-symbolic type systems) | *Carried, and wave 13 sharpened it into a live disagreement.* `T283`: must the router be Bayes' rule over generative models, or may it be a discriminative network? Two wiki entities take opposite sides and have never been run head-to-head. Also supplies `G12`'s and `G91`'s router | Human curation or a web-search pass |
| P19 | Acquire sources for the controlled-shortcut benchmarks (Shift-MNIST / biased CelebA / unfair dSprites) and for ObjectNet / ImageNet-C | *Carried.* `I1` is the first instrument in the inventory and has no primary source for its image half. `P6` sharpens what to read them for | Human curation or a web-search pass |
| P20 | Acquire sources for artefacts named across pages with no file in `raw/`: deep Q-network / experience replay, elastic weight consolidation, progressive networks, episodic control, Monte Carlo tree search | *Carried, and wave 13 did **not** close it.* The continual-learning block ingested CLS, neuromodulation, CN-DPM, CH-HNN and Continual Dreamer — elastic weight consolidation is still second-hand on five pages | Human curation or a web-search pass |
| P18 | Acquire Liao et al. 2022 — the inhibitory-plasticity model of the replay filter | *Carried.* [[wiki/concepts/offline-replay.md]] asserts inhibitory plasticity as the filter's substrate on modelling grounds; `T30` cannot be adjudicated from a review | Human curation |
| P25 | Acquire a source on **edge-density scaling** (`G101`) | **New, from wave 14.** 2.75× cortical volume on 1.25× the neurons — the difference is neuropil, i.e. connections. Every scaling argument in the wiki is about units, and no result in it says what a higher synapse-per-unit ratio buys | Human curation or a web-search pass |

## Structural work

| # | Task | Why |
|---|---|---|
| L15 | **27 tension rows are cited by no page** | *Carried.* `T3 T14 T19 T54 T60 T66 T70 T71 T72 T73 T74 T87 T95 T101 T102 T103 T115 T163 T181 T194 T198 T200 T243 T244 T246 T255 T268`. Each needs one judged sentence on the right page, or retiring against its own `Closes when`. `tools/registry-index.py` now prints the list on every rebuild, so the check is free |

| L6 | **Decide whether the joint-embedding entity pages should stay separate** | *Carried.* Seventeen of them, several deferring their central claim to [[wiki/concepts/representational-collapse.md]]. Not merge candidates; the shared comparison table is missing from most. `P6` supplies its one comparable column |
| L8 | **The `Connections` block is the wiki's only navigational structure and it is unweighted** | *Carried.* **5,735 edges over 254 pages**, all one type, none marked *primary*. Cheapest fix unchanged: mark one edge per page as primary. Note it is now verified bidirectional by `S1` in the script rather than by hand |

| L16 | **The glossary's section discipline is enforced only by a duplicate check** | **New, and it is the residue of `L14`.** `S13` catches duplicate keys; **nothing catches a row filed under the wrong heading**, which is the failure that put 64 machine-learning rows under `## Benchmarks`. Section membership is a judgement, so the mechanical proxy is the append point: entries must be appended inside their section, not at end of file. Cheapest fix: have `INGEST` insert by section rather than by append |

| L17 | **The 396 `Closes when` fields are written and unaudited** | **New, and it is the price of writing them in one pass.** Every gap and tension now names the observation that would retire it, but no row has been checked against its own criterion — some are plausibly *already satisfied* by evidence the wiki holds, which would make them the first rows ever to close. The audit is one read per row and belongs to the next lint pass |

## Standing

| # | Rule | State at this pass |
|---|---|---|
| S1 | Keep `Connections` bidirectional | **1 asymmetric edge over 18 sources — 0.056/ingest, down 15× from 0.85**, on 13 new pages. **The last pass's wave-shape explanation is refuted.** Now enforced by `./tools/wiki-stats.sh`, and note the prose version of this check was inverted (see the finding above) |
| S2 | Lint after ~every 20 ingests | Honoured six times running: 19, 22, 20, 20, 20, 18 |
| S3 | Re-run `./tools/qmd-index.sh` after each ingest | A stale index hides existing pages and causes duplicates |
| S4 | Check table rows by column count — **reset the expected width at every table boundary** | **In the script.** Found 3 real defects this pass. `{w=0}` as the default action is the whole fix. Standing sub-rule, now fired three passes running: **escape `\|` inside `H(·\|·)`, `p(·\|·)` and `·\|_{·}`** — fix the *expression class*, not the row that was found |
| S5 | Overview's source count is checked and exits non-zero | Violated on entry for the **sixth** time (284 vs 302). The script caught it; five prose versions never did |
| S5b | **Overview's tension count likewise** | **New.** The controversies header said 236 against 293 — a stale count in a *second* place that `S5` did not cover. Any figure the overview publishes needs its own comparison, not a rule saying figures should be right |
| S6 | Write abbreviations the way the glossary lists them | 7 added. Use a non-alphanumeric lookaround on both sides; a naive `[A-Z]{2,6}` extractor splits inside longer tokens and returns mostly proper nouns |
| S7 | A concept reaching ~50% of a host page is a page — and the host need not be a page | Demonstrated seven times. Below it: a variable load-bearing on two pages and owned by neither is a **gap row** (`G80`) |
| S8 | Every cited `G`/`T` identifier has a row; no row shares an identifier | Clean. `G79`, `T182`, `T184` resolve as historical prose from merges, which is correct |
| S9 | A number quoted against a human is incomplete without its protocol | **Extended to models by `T291`**: a capability number is incomplete without its *frame*. A null under one framing does not measure the capability |
| S10 | Every published self-count names the command that produces it — **and something runs it** | Violated on entry in six places again. The answer is not a stricter rule; it is that each figure needs a comparison in the script. `S5b`, `S14` and `S15` are that principle applied three more times |
| S11 | Check source integrity through `https://status.claude.com/api/v2/incidents.json`, not the status page | Held for the second pass. The page returns a JavaScript shell no fetch path can read |
| S12 | Check both registries for cross-wave duplicates by reading, not by `grep` | **Ran clean — its first negative result.** Signature: rows sharing ≥3 source citations *and* ≥3 carrying pages. One candidate over 396 rows, and it was a sibling pair. Cheapest at a wave close |
| S13 | **No glossary key may appear twice** | **New, in the script.** A genuine collision between two expansions is disambiguated *in the key* — `RC (reservoir computing)` — so the check stays exact. Found 7 on its first run: 5 true duplicates, 2 collisions |
| S14 | **A registry row and its carrying pages must cite each other, both directions** | **New, in the script.** Hard-fails on any uncited gap; the uncited-tension count is emitted as a tracked figure. This is `S1` applied to the registries, and nothing enforced it in either direction until this pass |
| S15 | **The queue must reconcile exactly against `raw/`** | **New, in the script.** `sources + skipped = files`, and every queue entry resolves to a file. Verified: **302 + 1 = 303**. The 11-file gap between `grep -c '^- \[x\]'` and `ls raw/*.md` is entirely `.txt` sources and one `- [-]` gate skip — a reconciliation the wiki had never run |
