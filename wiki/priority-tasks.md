# Priority Tasks

What to read or write next. Derived from [[wiki/architectural-gaps.md]], from open problems on concept pages, and from lint passes. Reordered whenever a gap opens or closes.

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
