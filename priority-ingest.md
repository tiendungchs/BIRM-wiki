# Current ingests

`_work/ingest-queue.md` hold the full ingest queue. This file contain only the current wave. Once a wave is fully ingested, replace the wave below with a new one.

## Pending — the hippocampal–prefrontal axis

Dropped in `raw/` after wave 18 closed; validated by `./tools/clip-check.sh` (0 FAIL, 0 WARN), manifest rows 377–381. Not from a want-list — clipped opportunistically, anchored to open registry rows after the fact.

Four reviews establish the anatomy and the channel, then the one model that claims the hippocampal side is a learned graph. Ingest order S → F, anatomy before the model.

One INGEST each:

- [x] `strange-2014-hippocampal-longitudinal-axis.md` — hippocampal-entorhinal · S · 2014 — long-axis gradients superimposed on sharply demarcated gene-expression domains — the dorsal/ventral dichotomy revised · `T51`, `G93`
- [x] `shin-2016-hippocampal-prefrontal-interaction-modes.md` — hippocampal-entorhinal · S · 2016 — theta coherence vs sharp-wave-ripple as two distinct communication modes on one pathway, each serving a different cognitive demand · `T100`, `T333`, `G54`
- [x] `eichenbaum-2017-prefrontal-hippocampal-episodic-memory.md` — hippocampal-entorhinal · S · 2017 — prefrontal↔hippocampal pathways and their intermediaries (nucleus reuniens, perirhinal / lateral entorhinal), oscillatory synchrony as the coupling; context-cued retrieval model · `T98`, `T100`, `G52`
- [x] `witter-2017-entorhinal-cortex-architecture.md` — hippocampal-entorhinal · S · 2017 — lateral vs medial entorhinal architecture, layer-specific input/output, the anatomy behind the two-stream split · `G43`, `T47`, `T41`
- [ ] `george-2021-clone-structured-cognitive-graphs.md` — hippocampal-entorhinal · F · 2021 — the CSCG primary source, cited second-hand across the wiki with no file in `raw/` until now; ingest last, after the anatomy · `T28`, `T29`, `G2`

Wave 18 closed at 5eccda8 — all ten targets and all nine between-wave clips ingested; see `_work/ingest-queue.md`.

## Wave 19 — where the cortex's predictive capacity lives, and how it learns to predict the sensory consequence of an action

Anchor: the user's query on TEM / Vector-HaSH generalisation. The wiki's answer — "all predictive capability is cortical, the hippocampus is an index" (`T28` position B) — rests on TEM's modelling assumption; the cortex-side pages carry the update rule and the wiring diagram but no measured circuit in which an action-based prediction of upcoming sensory content is generated, delivered and learned. All six want-list targets clipped; validated by `./tools/clip-check.sh` (0 FAIL, 0 WARN), manifest rows 382–387.

One INGEST each:

- [ ] `keller-2018-predictive-processing-canonical-cortical-computation.md` — predictive-coding · S · 2018 — user-clipped; positive and negative prediction-error neurons in L2/3, the top-down prediction they subtract, and which tests of the cell-class assignment have been run · `T28`, `T107`
- [ ] `wolpert-1998-internal-models-cerebellum.md` — world-models · F · 1998 — user-clipped; forward and inverse internal models as cerebellar computations with efference copy as input — a third locus `T107` never names; the wiki has no cerebellum page · `T107`
- [ ] `rao-1999-predictive-coding-visual-cortex.md` — predictive-coding · F · 1999 — user-clipped; the origin the predictive-coding page cites through Friston 2009: hierarchical generative model of natural images, feedback = prediction, feedforward = residual, end-stopping falls out · `T259`
- [ ] `hawkins-2019-framework-intelligence-cortical-grid-cells.md` — cortical-columns · F · 2019 — user-clipped (want-list route was `self`); the primary for `thousand-brains-theory`, which rested on an undated talk: displacement cells, the L6 location code, every column predicts its next input from a movement-updated location · `T66`, `T28`
- [ ] `leinweber-2017-sensorimotor-circuit-visual-flow-predictions.md` — predictive-coding · R · 2017 — user-clipped; A24b/M2 → V1 L2/3 carries a motor-based prediction of visual flow; couple running to reversed flow and the prediction reverses — the action→content map is learned in cortex with no hippocampal store · `T28`, `T107`, `G39`
- [ ] `schneider-2018-cortical-filter-acoustic-consequences-movement.md` — predictive-coding · R · 2018 — user-clipped; a mouse learns in days that its footsteps make a novel tone, and M2 → auditory-cortex inputs onto inhibitory interneurons come to cancel it — an acquisition schedule for `T97` · `T28`, `T97`

## Between-wave clips — dropped in `raw/` with wave 19

Not from the want-list; anchored to open registry rows after the fact. Validated with wave 19 (0 FAIL, 0 WARN), manifest rows 388–392; row 393 dropped later and appended at the end of this block. Two duplicate clips of the bioRxiv preprint of Whittington et al. 2025 were deleted — the Neuron version below supersedes them. Ingest order F → R, oldest first.

- [ ] `whittington-2025-tale-of-two-algorithms-structured-slots.md` — working-memory · F · 2025 — user-clipped; Neuron 113(2):321–333, published version of bioRxiv 2023.11.05.565662; prefrontal sequence memory as structured activity slots (one-hot role code), unified with hippocampal weight-stored cognitive maps — the slot-vs-weight comparison `T317` asks for · `T317`, `G104`, `T293`
- [ ] `bakermans-2025-hippocampal-composition-and-replay.md` — hippocampal-entorhinal · F · 2025 — user-clipped; Nat. Neurosci. 2025; hippocampal state space composed from reusable sub-blocks, replay as the mechanism that builds and stitches the composition; the `spacetime-attractor` page cites its preprint as the proposed training route · `T30`, `G22`, `T28`
- [ ] `derdikman-2009-grid-map-fragmentation-multicompartment.md` — hippocampal-entorhinal · R · 2009 — user-clipped; Nat. Neurosci. 12:1325–1332; grid maps fragment into per-compartment submaps in a hairpin maze, resetting at each turn — the environment, not the inference history, sets the map boundary · `T35`, `T46`, `T39`
- [ ] `hoydal-2019-object-vector-coding-mec.md` — hippocampal-entorhinal · R · 2019 — user-clipped; Nature 568:400–404; MEC cells fire at a fixed distance and direction from discrete objects, generalising across objects and environments — a landmark-anchored code alongside the self-motion grid · `T46`, `G39`
- [ ] `gornet-2024-cognitive-maps-visual-predictive-coding.md` — hippocampal-entorhinal · R · 2024 — user-clipped; Nat. Mach. Intell. 6:820–833; a network trained only on visual next-frame prediction assembles an implicit spatial map in its latent space with no coordinates or path-integration signal — a cortex-side route to a map, bearing on `T38` and `T28` position B · `T38`, `T28`, `G34`
- [ ] `braun-2009-motor-task-variation-structural-learning.md` — world-models · R · 2009 — user-clipped; Curr. Biol. 19(4):352–357; randomly varying the *parameter* of a visuomotor transformation with zero mean teaches its *structure* — a low-dimensional subspace of control space plus a metaparameter that moves along it; yields structure-specific facilitation, reduced anterograde/retrograde interference between ±60° rotations, and movement variability shaped *along* the learned subspace · `T93`, `G61`, `G82`
