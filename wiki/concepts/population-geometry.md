# Population Geometry

**The level of description at which a population's activity is a point on a low-dimensional curved surface embedded in neuron-space, so that what a circuit represents is the *shape* of that surface and how task variables are arranged on it — not the tuning of any cell.**

[[wiki/concepts/objective-identifiability.md]] draws the wiki's sharpest methodological line: **population-level `g` is a legitimate prediction target; per-unit tuning is not**, because a task-forced low-dimensional latent can be projected onto a large population in many ways and nothing picks the projection. That line was stated and left without an instrument. This page is the instrument set, plus the wiki's strongest evidence that geometry is the thing conserved across brains while tuning is not (Nieh et al. 2021).

---

## Formal statement

`N` simultaneously recorded units give a state `s(t) = [s₁(t), …, s_N(t)] ∈ R^N`. The claim is that `s(t)` is confined to a manifold `M ⊂ R^N` of intrinsic dimension `d ≪ N`, and that the task variables are smooth functions on `M`.

| Quantity | Estimator | Value (mouse dorsal CA1, evidence-accumulation T-maze) |
|---|---|---|
| Intrinsic dimension `d` | Count neighbours within geodesic radius `r`; on a `d`-manifold `N(r) = c·r^d`, so fit the power law on a log-log plot over ~3 decades | `d = 5.4 [4.8, 6.0]` (95% bootstrap), in a **~450-dimensional** state space, `n = 7` animals |
| `d` by a second, independent route | Embed `M` in `d`-dimensional Euclidean space, reconstruct **held-out trials** from the `d` latents, correlate with real `ΔF/F` | Saturates at `d ≈ 5–6` — agrees with the power law |
| Curvature cost | Number of principal components needed to match the nonlinear embedding's held-out reconstruction | **29 / 40 / 47 PCs to match `d` = 4 / 5 / 6** — a linear count overstates the dimensionality by ~7–8× |

**The third row is the number to carry into every other page.** Wherever the wiki uses a *linear* dimensionality measure — participation ratio as the confound behind linear "neural predictivity" ([[wiki/concepts/objective-identifiability.md]]), PCA-based comparisons of representational richness — the quantity being measured is an artefact of how curved the manifold is, and can exceed the true latent count by nearly an order of magnitude. A model and a brain can differ by 8× in participation ratio while carrying the *same* 5-dimensional geometry.

---

## The instruments

| Instrument | Fitted object | What it reads out | Failure mode |
|---|---|---|---|
| **Intrinsic dimensionality** | Power law `N(r) = c·r^d` on geodesic neighbour counts | How many latent variables the task forced | The fit range is chosen by hand; inherits the arbitrary-threshold criticism the wiki already applies to grid scores ([[wiki/empirical-tensions.md]] T37) |
| **Held-out reconstruction** | `d` latents → all `N` cells, cross-validated per trial | Whether `d` is sufficient, independent of the distance estimator | Rewards smoothing; a thresholding nonlinearity had to be fitted to match calcium optics |
| **Leave-one-neuron-out** | Fit `M` on `N−1` cells, then regress latents → the held-out cell | Whether `M` is a *population* property rather than a per-cell curve fit — a single neuron's activity is predictable from the rest | Only tested on the 25 most active cells |
| **Variable regression onto latents** | Gaussian-process regression `latents → position / evidence / velocity / view angle / previous choice / previous correct` | Which task variables are smooth functions on `M`, continuous and binary alike | Decodability, not use — the same caveat as [[wiki/concepts/representation-probing.md]] |
| **Cross-subject hyperalignment** | A single rotation `R ∈ SO(d)`: `e_B = GPR_A(R·x_B)` | Whether the geometry is **task-specific or subject-specific** — the only instrument here that needs no shared units, no shared cells and no probe trained per subject | The rotation group is a modelling choice; `SO(5)` has 10 free parameters, cross-validated on half the session |
| **Sequence prediction** | Reconstruct activity from `d` latents, re-run the sequence detector, sweep the threshold for an ROC | Whether the geometry accounts for the circuit's *temporal* structure and not only its state distribution | Sequence detector has its own shuffle-defined threshold |
| **Input-geometry control** | Run the identical pipeline on the raw sensory stream (here: the VR video the animal saw) | Whether the manifold is a representation or a re-description of the input | Run once, on a 17×-downsampled single colour channel |

The last row is the one the wiki should demand of every manifold claim. It is the population-geometry analogue of audit item 2 in [[wiki/concepts/objective-identifiability.md]] — *is the target already the phenomenon?* — moved from a supervised readout to a sensory input: a low-dimensional structure in the activity means nothing if the input stream has the same structure.

---

## What Nieh et al. 2021 establishes

Mouse dorsal CA1, two-photon calcium imaging, 3144 neurons (449 ± 64 simultaneous), 7 animals, running a virtual-reality T-maze where reward depends on which wall showed more towers. **Accumulated evidence** (`#right − #left`) is the abstract variable: not innate, not perceptually present, computable only after the task rules are learned.

| Result | Detail | Why it matters here |
|---|---|---|
| **Single cells jointly code a physical and an abstract variable** | 917 cells with significant mutual information in the 2-D evidence × position (`E×Y`) space, exceeding both single-variable shuffle controls; **89.9%** beat both, 16% of the remainder were position-only, 6% evidence-only | The wiki's first **single-unit** demonstration that a learned, non-perceptual variable enters the hippocampal map. Every other "beyond space" entry on [[wiki/concepts/cognitive-map.md]] except the odour/time/frequency cells is fMRI |
| **Firing fields tile the abstract dimension** | 1.7 ± 0.3 fields per cell in `E×Y` space; 53% (490/917) multi-field | Evidence is coded like a place dimension — localised fields, not a monotonic ramp |
| **This is not splitter cells** | Choice-selective place sequences exist, but individual cells are *unreliable* trial-to-trial relative to a simpler alternation task — which is the prediction of joint coding (different trials traverse different evidence values), not of choice-conditioned place maps | Distinguishes a conjunctive map from a context-modulated one, using the *unreliability* as the signal |
| **~5-dimensional nonlinear manifold** | `d = 5.4 [4.8, 6.0]`; firing fields are localised *on* `M`; position and evidence appear as two **independent gradients** on `M` | The population claim, and the level at which the code is factorised (see below) |
| **Dimensionality is task-dependent** | A simpler one-side-cues version of the same maze yields a significantly *lower* `d` | `d` is a measurable readout of how many factors the task forced — see G40 below |
| **The geometry is shared across brains** | Hyperalignment by one `SO(5)` rotation: **69 ± 9%** (position) and **75 ± 10%** (evidence) of geometry shared between best pairs; cross-animal evidence decoding is **not significantly worse** than within-animal (`p = 0.81`), position slightly worse (`p = 0.016`) | The load-bearing result for this page — see below |
| **Sequences are trajectories on `M`** | 16 088 "doublets" (cell A reliably fires before cell B), each active in only 3.6 ± 0.01% of trials; reconstruction from 5 latents re-detects them at **TPR 0.87 / FPR 0.14**, and manifold path length predicts the inter-event *time*; choice-predictive doublets are more predictive than trial-ID-shuffled controls | Sequence structure is not a separate mechanism — it is the shadow of a path |
| **`M` is not the input's geometry** | MIND run on the visual stream the animal received gives a structure "fundamentally different" from `M` | The input-geometry control, passed |

---

## Entangled at the cell, factorised at the population — and this is gap G40's real knob

The two readings of this dataset are both true and they are at different levels:

| Level | Verdict |
|---|---|
| Single cell | **Entangled.** ~90% of informative cells carry a conjunction; position-only and evidence-only cells are a small minority. This is the `g̃ ⊙ x̃` outer-product regime of [[wiki/entities/tolman-eichenbaum-machine.md]], not a factorised code |
| Population | **Factorised.** On `M`, a trial advances along a position direction and *splits* along an independent evidence direction. Two nearly-orthogonal gradients over one surface |

[[wiki/architectural-gaps.md]] G40 asks when a system should factorise and when it should entangle, and had no controller and no measurement. This dataset supplies the measurement and relocates the question: **factorisation is a property of the population geometry, not of tuning curves**, so a model can be scored on it without any cell-level correspondence — exactly the level [[wiki/concepts/objective-identifiability.md]] says is legitimate. And `d` itself is the candidate observable for the controller: a task with fewer independent factors produced a lower-dimensional manifold in the *same* circuit, so "how many things is this task making me track" is readable from the geometry rather than having to be declared.

**(brainstorm)** The clean experiment this suggests is a dimensionality ledger. Train one model on a family of tasks that share components, estimate `d` per task, and check whether `d` grows with the number of independently varying factors and *saturates* once components recombine (the factorised regime, where new tasks are new points on an old manifold) rather than growing linearly (the entangled regime, where each task gets its own bespoke surface). That is G40's "factorise when the task set is factorised" rule made into a curve that can be plotted, and it needs no labels beyond the task index.

---

## The shared geometry is the reusable code, and the rotation is the pose

The hyperalignment result is the strongest thing in the ingest for the wiki's central architecture.

- 69–75% of the manifold's geometry transfers between animals, and evidence decoding transfers with **no significant loss**.
- The entire cross-brain difference absorbed by one element of `SO(5)` — **10 parameters** — against a 5-dimensional geometry supporting the whole task.
- Single-cell fields, by contrast, have no cross-animal correspondence at all; nothing was matched cell to cell.

This is the *empirical* instance of the split [[wiki/concepts/cognitive-map.md]] derived twice and had never seen measured: a large reusable structural code plus one small parameter that says how it is posed. There it was `φ_k`, an argmax over rotational offsets when orienting a stored map ([[wiki/entities/hidden-state-inference-remapping.md]]); in the fly it was the physically separable bump-to-landmark offset ([[wiki/entities/fly-central-complex.md]]). Here the same shape appears across *brains* rather than across environments, with the symmetry group named (`SO(d)`) because the space is a Euclidean embedding.

**(brainstorm) The cheapest export on this page is a model-comparison instrument.** To ask whether two systems learned the same structure, do not compare weights, units, or probe accuracies. Fit each system's manifold, search `SO(d)` for the rotation that best transfers a decoder from one to the other, and report the fraction of variance the rotation carries. It is label-free once the task variables are known, unit-count-free, and architecture-free — so it works model↔model, model↔brain and brain↔brain with one procedure. It is also the only instrument in the wiki that could compare a model to a brain without training a probe on ground-truth labels, which is the circularity [[wiki/concepts/representation-probing.md]] cannot escape. What it does not escape: it presupposes the group. Where the alignment is not a rotation — a permutation, a reparameterisation, a nonlinear warp — the instrument silently under-reports shared structure, which is the same residue as G39.

---

## Sequences are not primitives

The doublet analysis dissolves a distinction the wiki has been carrying. A "sequence" of cell activations is fully accounted for by a path through a 5-dimensional surface: identity at TPR 0.87 / FPR 0.14 from the latents alone, *and* timing, since manifold path length between the two firings predicts the elapsed time better than path lengths taken from other trials.

| Consequence | Statement |
|---|---|
| **Storage** | A system does not need to store sequences if it stores the geometry and a policy for moving on it. This is the same cost argument [[wiki/entities/vector-hash.md]] makes from capacity — reconstruct a tangent vector, let the manifold regenerate the state — arrived at from measurement instead of from theory |
| **Rare events come free** | Each doublet occurs in 3.6% of trials, yet the manifold predicts it. Sequence-level structure that is far too sparse to learn pairwise is implied by the geometry |
| **Prediction for replay** | The source proposes that non-spatial replay sequences in humans are organised by the same manifold geometry, by analogy with the online case measured here. Untested — no replay was recorded ([[wiki/concepts/offline-replay.md]]) |

---

## Open problems

- **One manifold, one task.** Nothing here says how the manifolds for two tasks relate, whether they share dimensions, or what happens on the transition. That is G40's reuse question and this paper does not touch it.
- **No learning trajectory.** The task takes weeks to train and the geometry is measured once, in a session selected for imaging quality. Nothing measures the manifold *forming*, so the discovery half of [[wiki/concepts/latent-graph-discovery.md]] gets no constraint.
- **Decodability again.** Manifold inference is correlational. No intervention perturbed the population along a latent direction, so "the animal uses the geometry" is unlicensed exactly as it is for a linear probe (T25).
- **The abstract variable is scalar, continuous and metric.** `#right − #left` is a running count with a natural order. Nothing here says a manifold forms for a non-metric symbolic variable, which is the non-embeddable slice (G11) and the same limit [[wiki/concepts/abstract-structural-codes.md]] records for the concept-space grid result.
- **The estimator is threshold-bearing.** `d` comes from a hand-chosen power-law fit range, and the sequence detector from a shuffle-defined cutoff. Both are the instrument class the wiki distrusts elsewhere.
- **Why five?** No account is offered of why `d ≈ 5` for a task with two nominal variables. Velocity, view angle, previous choice and previous-trial correctness are all decodable from `M`, which plausibly consumes the remainder — but the decomposition is not done, so the dimension count is not yet an *inventory*.

---

## Connections

- **[[wiki/concepts/objective-identifiability.md]]** — supplies this page's reason to exist (population structure is a legitimate prediction target, single-unit tuning is not) and receives its instrument, plus the number that bounds its own dimensionality confound: a linear PC count can exceed the true latent dimension by 7–8×, so two systems differing in participation ratio may carry identical geometry.
- **[[wiki/concepts/representation-probing.md]]** — the same inside-the-system ambition with the labels removed: a probe asks whether a *named* structure is decodable, manifold inference asks what shape the activity has before naming anything, and cross-subject rotation alignment is the one comparison here that does not need ground truth. Both stop at decodability without intervention.
- **[[wiki/concepts/cognitive-map.md]]** — supplies the single-unit case its "beyond space" table lacked (a learned, non-perceptual variable with firing fields, in mouse CA1) and the measured instance of its reusable-code-plus-pose decomposition, with the pose realised as a 10-parameter `SO(5)` rotation between brains.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the opposite pole of the same architecture: `g` requires content-invariance, and this page's cells are ~90% conjunctive, so the invariance appears only after the population geometry is extracted — which says where in a model the factorisation is allowed to live.
- **[[wiki/architectural-gaps.md]]** — G40 gets its first measurement: entanglement is a cell-level fact and factorisation a population-level one, and intrinsic dimensionality responds to how many factors the task forces.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the model whose evidence-accumulation prediction this is: a 2-D map spanned by position × accumulated evidence, predicted from next-observation prediction and then recorded. It also predicts the conjunctive (`g̃ ⊙ x̃`) cell-level code this page measures at ~90%.
- **[[wiki/entities/vector-hash.md]]** — the theoretical version of this page's sequence result: store a tangent vector on a low-dimensional manifold and let the dynamics regenerate the state, here confirmed as a measurement (the geometry predicts sequence identity *and* timing).
- **[[wiki/concepts/offline-replay.md]]** — online sequences are paths on the manifold; the source's untested proposal is that offline replay sequences are organised by the same geometry, which would make replay's sampling distributions choices of trajectory rather than choices of stored episode.
- **[[wiki/entities/fly-central-complex.md]]** — the same reusable-code-plus-offset structure in a circuit small enough to record entirely, with the offset physically separable rather than fitted; that page's ring is `d = 1` and hand-identified, this page's surface is `d ≈ 5` and inferred.
- **[[wiki/concepts/path-integration.md]]** — the manifold's position gradient is what an integrator moves along, and the evidence gradient is a second integrator over a non-spatial quantity in the same population, which is the composition-of-integrators question made concrete in one circuit.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the geometry is the graph estimate seen as a surface rather than as nodes and edges: task variables are coordinates on it, sequences are paths, and the shared-across-brains fraction is the closest thing the wiki has to a measurement of how much of a recovered structure is the *task's* rather than the learner's.
