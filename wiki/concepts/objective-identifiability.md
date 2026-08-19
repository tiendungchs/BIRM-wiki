# Objective Identifiability

**Which loss a system optimizes cannot be recovered from its representations, and which representation a loss yields cannot be recovered from the loss — so "tuning curve X emerged from task Y" is not a claim about Y unless the inductive biases carrying X are accounted for.**

This page is the audit procedure the wiki needs before it may read any *emergence* result as evidence about an objective. Its case study is the one the wiki leans on hardest: grid cells emerging from path integration (Schaeffer, Khona & Fiete 2022).

---

## The two directions of non-identifiability

| Direction | Statement | Consequence for the wiki |
|---|---|---|
| **Many-to-one** (loss → solution) | Numerous different loss functions share the same/similar minima. Reproducing observed responses therefore does *not* identify the objective the brain optimizes | Kills claim 1 of task-optimized modelling ("the model reveals which problem the brain solves"). Applies to the wiki's own objective slot (G30): a matching representation licenses no choice among candidate objectives |
| **One-to-many** (loss → solutions) | A given loss has several minima; the brain selects one under its constraints (energetics, neuron number, downstream use, evolutionary history), the network selects another under its own (initialisation, optimizer, gradient-descent path) | Kills claim 2 ("the model makes novel single-neuron predictions"). Even the *correct* objective need not yield the biological solution |

The stated escape is the only one available: **specify the inductive biases and constraints of the target system.** Expecting single-neuron correspondence without them is the paper's informal **No Free Lunch for Neuroscience**.

**Where correspondence *is* expected to survive.** Low-dimensional latent representations forced by the task are robust and abstract enough to predict population structure — "any model finding ripe apples in photos will represent round red objects". What is not expected without extra constraints is *single-unit tuning*, because a necessary low-dimensional latent can be projected onto a large population in a multiplicity of ways, and nothing in the task picks the projection. This is a sharp architectural line for the wiki: **population-level `g` is a legitimate prediction target; per-unit tuning is not.**

---

## The case study: >11,000 path-integrating networks

Setup follows the deep-learning grid-cell literature: 2.2 m × 2.2 m arena, RNN/LSTM/GRU/UGRNN receives initial position plus velocities, trained by backpropagation through time to output an encoding of position. Sweeps over architecture, activation (sigmoid/tanh/ReLU/linear), optimizer (SGD/Adam/RMSProp), dropout, initialisation, L2, seed, and readout target. Success criterion deliberately lenient: **a single hidden unit with grid score > 0.8 counts as "possibly has grid cells"**; position error < 10 cm counts as path integration solved.

| Finding | Detail |
|---|---|
| **PI is learned; grids are not** | Most networks path-integrate optimally. Very few show grid-like units. Consistent with earlier work where networks solved PI, multi-environment self-localization and SLAM-like disambiguation with no grid units |
| **The readout target decides everything** | Cartesian, polar and **Gaussian** readouts produce no grids. Only Difference-of-Softmaxes (DoS), and a narrow subset of Difference-of-Gaussians (DoG), do |
| **An undocumented implementation detail is load-bearing** | Three papers' texts and supplements report an equi-norm **DoG** target; their code uses **DoS**. Trained with equi-norm DoG, ideal grid-forming ReLU networks produce no lattices. Densely sweeping the theoretically feasible `α_E/α_I` region: **1 run of 1086** matched the DoS grid-score distribution, and its two sibling seeds did not |
| **Grid period is a hyperparameter, not a prediction** | Period increases monotonically with readout width `σ_E`. Period *values* are therefore set by the programmer |
| **No modules** | Grid-period distributions are unimodal in almost every run — one module, where the brain has discretely many. Adjacent-period ratios obtained by sweeping `σ_E` come out near 1, versus the biological ≈1.2–1.5 |
| **Biological readouts abolish grids** | Give the readout population place-cell-like heterogeneity — multiple fields (`1 + Pois(3)`) and multiple scales (`σ_E ~ U(0.06, 1.0)` m, surround `s ~ U(1.25, 4.5)`) — and position decoding stays as good while grids disappear. Grid emergence requires a **translation-invariant** readout code, which place cells are not: as a population they over-represent borders, landmarks and rewards |
| **Fragility** | Even with DoS, modest changes to `σ_E`, and seed changes, can remove grids |

**Why, analytically.** Take the continuous-attractor dynamics `ṙ(x) = −r(x) + g(W ⋆ r)` with translation-invariant `W(Δx)`. Pattern formation requires the Fourier transform `f̃(k)` to peak at `k* ≠ 0` with `f̃(k*) > 1`, where

`f̃(k) = α_E σ_E exp(−σ_E²k²/2) − α_I σ_I exp(−σ_I²k²/2)`, `[k*]² = (2/(σ_E² − σ_I²)) · log(α_E σ_E³ / α_I σ_I³)`

An inhibitory surround is what moves the peak off the origin; as `σ_I → ∞` or `α_I → 0` the maximum sits at `k* = 0` — a uniform, non-periodic state. Sorscher et al.'s bridge to trained networks is that gradient descent on `‖P − W_readout r‖²` behaves like `ṙ = −λr + Σr` with `Σ_{x,x'} = Σ_i P_i(x)P_i(x')ᵗ`, the **readout correlation matrix** playing the role of `W`. So the periodicity was never in the task: it is in the second-order statistics of the supervised target the modeller chose. A DoG/DoS target *is* a centre–surround interaction; a Gaussian target is not, and in the continuum limit cannot pattern.

**The reading for this wiki:** the "grid cells fall out of path integration" result is closer to *hand-designing a continuous attractor via the loss* than to discovering an objective. It is post-hoc: given the non-genericity, these models would not have predicted grid cells had grid cells not already been known.

---

## The measurement critique: neural predictivity tracks dimensionality

A separate and more general hazard. Networks trained on single-field single-scale DoS readouts were reported to explain mouse mEC variance at nearly the mouse-to-mouse ceiling — while, per the above, learning few grid cells, one module, and requiring biologically wrong readouts. Conjecture with preliminary evidence: **linear-regression "neural predictivity" rewards high-dimensional representations because they are richer regression bases**, not detailed similarity. Across 5 architectures × ReLU × DoS, mean **participation ratio** of rate maps correlates with published predictivity. Independently confirmed in macaque vision and human audition during review.

| Instrument | What it certifies | The confound |
|---|---|---|
| Grid score threshold | A pattern is *findable* in one unit | Arbitrary threshold; false positives without shuffle controls (T37) |
| Linear regression to neural data | Target activity lies in the span of model activity | Span grows with intrinsic dimensionality — a model can win by being higher-dimensional than its competitors |
| Linear probe ([[wiki/concepts/representation-probing.md]]) | Property is linearly decodable | Decodable ≠ used (T25) |

All three are *decodability* instruments, and this is the wiki's third independent statement that decodability is a weak constraint on mechanism.

---

## Applying it: an emergence audit

A checklist for any claim in this wiki of the form "mechanism M emerges from objective O":

1. **What fraction of runs?** Over architectures, activations, optimizers, hyperparameters and seeds — not the tuned configuration.
2. **Is the target already the phenomenon?** Compute the second-order statistics of the supervised target and ask whether M is implied by them. If the readout correlation matrix has the shape of the mechanism's interaction kernel, nothing emerged.
3. **Does M survive a biologically realistic readout/input?** Heterogeneity is the cheap test, and it is the one that killed grids here.
4. **Are the quantitative values predictions or hyperparameters?** Sweep the suspected hyperparameter and see whether the value follows it.
5. **Do the population-level *relational* invariants hold?**, not just single-unit tuning — the invariance of cell–cell relationships across environments and states is what the first-principles models actually predicted and what experiment confirmed.
6. **Compare against filtered noise**, not against zero. Low-pass-filtered thresholded noise scores non-trivially on grid score, and most DoG runs did not beat it.

**The standard the paper sets, and which the wiki should adopt:** report *the conditions under which the tuning does and does not emerge*, and name which inductive biases were critical. First-principles continuous attractor models made out-of-distribution predictions later confirmed (invariant cell–cell relationships defining a toroidal manifold; grid-like patterning on the cortical sheet); deep-learning models should be held to that.

---

## The positive proposal: what a sufficient objective set might be

Path integration is *not a sufficiently constraining task*. Theory of grid codes says the code's real job is packing and maximally separating a large set of coding states in a compact space. Hypothesised sufficient set for grid emergence:

| # | Property | Slot ([[wiki/concepts/three-component-framework.md]]) |
|---|---|---|
| 1 | Non-negative activity | Architecture |
| 2 | Translation-invariant path-integrating code | Architecture / update rule |
| 3 | Exponential representational capacity | Objective |
| 4 | Intrinsic error correction | Objective |
| 5 | Uniformly distributed (whitened) information across cells | Objective |

Three of the five are *general properties of neural codes* rather than grid-specific, which is what would make them de novo rather than post hoc. **(brainstorm)** This is the most concrete candidate content the wiki has for the empty objective slot (G30): capacity + error correction + whitening, on top of an architecture that integrates actions. Note none of the five mentions space, so if the set is sufficient it should produce a periodic `g` in any path-integrable domain — which is a testable route into G41 as well.

---

## Open problems

- **No bias-accounting procedure exists.** The audit above is a checklist, not a measure. Nothing quantifies how much of an emergent phenomenon came from the target's statistics versus the task (G44).
- **How much of the wiki's biological warrant survives?** The wiki imports `g` partly because trained networks reproduce it. If reproduction is target-driven, the argument is circular and the warrant is only the first-principles attractor theory plus recordings.
- **Is dimensionality-matching the whole of the model-comparison literature's signal?** If linear predictivity is largely a dimensionality effect, every "this network best matches area X" claim in the wiki's track record ([[wiki/concepts/neuroscience-ai-transfer.md]]) needs re-reading. The relevant analysis code is not open source.
- **What would a non-post-hoc grid prediction look like?** Nothing in the wiki states a phenomenon a task-trained model predicted *before* it was recorded. The nearest instance is item 5 of the audit rather than single-unit tuning: a task-trained model predicted that place-to-grid *relationships* survive remapping, and the prediction was then confirmed in existing recordings that had not been analysed that way (Whittington et al. 2018, [[wiki/empirical-tensions.md]] T39) — a population-level relational invariant, which is exactly the level this page says is legitimate.

---

## Connections

- **[[wiki/concepts/path-integration.md]]** — the direct target: this page shows the task on that page does not by itself produce the code, so path-consistency of `g` remains an architectural commitment rather than something a loss discovers (T38).
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the strongest limit on the reverse channel: matched tuning curves and high linear predictivity certify neither the objective nor the algorithm, so a "validation" entry in that page's track record can be an artefact of the modeller's target choice or of representational dimensionality.
- **[[wiki/concepts/representation-probing.md]]** — the same weakness in a third instrument: grid score and regression predictivity are decodability measures, so "found in the model" and "found in the brain" are symmetric claims that both fall short of mechanism.
- **[[wiki/concepts/three-component-framework.md]]** — the sharpest available argument that the three slots are not separately identifiable from behaviour or representation: what looks like an objective result here is an architecture-and-target result, and the page's proposed sufficient property set is written into the objective slot.
- **[[wiki/concepts/abstract-structural-codes.md]]** — removes one leg of that page's support for a periodic `g`: hexagonal codes in trained networks come from centre–surround targets, not from the structural task, so the case rests on recordings and attractor theory.
- **[[wiki/concepts/shortcut-learning.md]]** — Morgan's Canon applied to modellers rather than models: never attribute to an objective what is adequately explained by the supervised target's second-order statistics.
- **[[wiki/concepts/latent-graph-discovery.md]]** — an identifiability failure one level up from G16: not only is the intended graph unidentifiable from data, the *objective* is unidentifiable from a system that has learned one.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the architecture whose grid-like units this page's argument bears on most directly; it is also the partial answer, since its structural code is trained on raw-observation prediction rather than on a hand-shaped spatial readout. Its 2018 precursor makes that concrete: the only target is a one-hot categorical over sensory identities, whose correlation matrix cannot be a centre–surround kernel, so audit item 2 is passed outright — while items 1, 3, 4, 5 and 6 are simply not reported.
- **[[wiki/concepts/successor-representation.md]]** — the rival derivation that survives this critique differently: grid-like codes as eigenvectors of a transition operator need no chosen readout kernel, but they are also a *population* claim rather than a single-unit one, which is exactly the level this page says is legitimate.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the companion caveat on the biological side: that page's detector is an arbitrary threshold, this page's grid score is the same instrument applied to models, so T37 and T38 are one problem measured in two systems.
