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

**The line now has direct empirical support, from the one dataset that measures both levels in the same neurons.** In mouse dorsal CA1 running an evidence-accumulation maze, the population manifold's geometry transfers *between animals* — 69 ± 9% (position) and 75 ± 10% (evidence) of it shared between the best pairs, with cross-animal evidence decoding statistically indistinguishable from within-animal — and the entire cross-brain difference is absorbed by a single `SO(5)` rotation, 10 parameters against a 5-dimensional structure. Nothing was matched cell to cell, and no cell-level correspondence is claimed. So the projection of the latent onto the population is exactly the part that varies between individuals of the *same species on the same task*, which is a stronger form of this page's argument than the model-vs-brain case it was made for (Nieh et al. 2021, [[wiki/concepts/population-geometry.md]]).

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
| Participation ratio / PC count as "dimensionality" | How many linear directions the activity spans | **It is not the latent count.** Matching the held-out reconstruction of a `d` = 4/5/6 nonlinear embedding of mouse CA1 activity took 29/40/47 principal components — a 7–8× overstatement. Two systems can differ by that factor in participation ratio while carrying the same geometry, so the confound in the row above is itself measured against the wrong quantity ([[wiki/concepts/population-geometry.md]]) |
| Linear probe ([[wiki/concepts/representation-probing.md]]) | Property is linearly decodable | Decodable ≠ used (T25) |

All four are *decodability* instruments, and this is the wiki's third independent statement that decodability is a weak constraint on mechanism.

---

## The one lever that breaks the many-to-one degeneracy: match the *trajectory*

Everything above concerns a comparison made at convergence. A trained model and a trained brain are two endpoints, and the many-to-one direction says endpoints do not identify the objective. **The learning path is a second observable, and it is far more constraining, because a model must reproduce every intermediate representation in the right order rather than one final one** (Sun et al. 2025, [[wiki/entities/cscg.md]]).

The demonstration: mouse dorsal CA1 learning a two-alternative cue–delay–choice task over weeks, with 3,000–5,000 cells tracked throughout. Six models — CSCG, softmax RNN, ReLU/sigmoid RNN, spiking Hebbian RNN with soft winner-take-all, LSTM, transformer — all solve the task. Three of them (CSCG, softmax RNN, Hebbian RNN) reach the *same* orthogonalized endpoint the brain reaches, so the endpoint discriminates nothing among them. Only CSCG reproduces the animals' order of decorrelation (within-track ambiguous regions → pre-far-reward → pre-near-reward). The authors' framing is worth adopting verbatim: this is **feature-matching on learning dynamics to infer a learning rule**, a class of instrument the wiki previously had only for endpoints.

| | Endpoint match | Trajectory match |
|---|---|---|
| What it can distinguish | Whether the objective/architecture *admits* the observed representation | Which of several admissible ones the system is running |
| Cost of obtaining it in a brain | One trained animal | Longitudinal cell-resolved recording across the entire learning period |
| Failure mode | Many-to-one (the whole of this page) | Depends on the modeller's input format, not only on the model |

**The last cell is the price, and it is charged immediately.** CSCG is fed a hand-written symbol sequence for the task. Reordering two symbols within the reward zone — water before reward-cue instead of after — leaves the learned transition graph identical and **inverts** the decorrelation order to the one the animals do not show. So the wiki's single dynamics-level model-brain match rests on an encoding choice the task does not determine (gap G46). This is audit item 2 of the checklist below reappearing one level up: the discriminating statistic came partly from the modeller's data format rather than from the model.

**(brainstorm)** The generalisation of item 2 that this suggests: for any claim "model M matches system S", perturb the *input representation* over the space of encodings a modeller could defensibly have chosen, and report the fraction that preserve the match. That is a sweep of the same kind as the >11,000-network sweep above, run over the pre-processing rather than over the hyperparameters — and no source in the wiki reports it.

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
- **What would a non-post-hoc grid prediction look like?** Nothing in the wiki states a phenomenon a task-trained model predicted *before* it was recorded. The nearest instance is item 5 of the audit rather than single-unit tuning: a task-trained model predicted that place-to-grid *relationships* survive remapping, and the prediction was then confirmed in existing recordings that had not been analysed that way (Whittington et al. 2018, [[wiki/empirical-tensions.md]] T39) — a population-level relational invariant, which is exactly the level this page says is legitimate. **A second, cleaner instance now exists.** The same model predicted that in a non-spatial task, hippocampal cells would remap spatially while retaining their lap preference; the prediction was stated as a mechanism (lap identity is carried by structural input, space by the conjunction), then measured against recordings collected for another purpose and confirmed (Whittington et al. 2020, data from Sun et al. 2020). It is again a *dissociation* — one dimension moves, another does not — rather than a tuning-curve resemblance, which is why it survives the objections this page raises against emergence claims.

---

---

## A third direction: the objective is not even fixed by the architecture

The two directions above assume the system *has* an objective and ask what an observer can recover. A predictive-coding network shows the weaker case: **the same architecture, the same weights and the same Hebbian update rule optimise different objectives depending on one scalar per layer.** With the input and output arms both at level 0 and an unconstrained apex, the ratio of the generative model's variance parameters `Σ^in : Σ^out` moves the learned solution continuously between forward regression (the backpropagation limit), the first principal component (equal precisions), and inverse regression — three standard algorithms, one network, one number (Whittington & Bogacz 2017, [[wiki/concepts/predictive-coding-free-energy.md]]).

| Consequence | For this page |
|---|---|
| The objective is a **parameter**, not a design choice | An audit that asks "which loss produced this representation?" can be answered "all of them, at different precisions" — the many-to-one direction with the many made explicit and continuous |
| The parameter is **physiologically ordinary** | Precision maps to synaptic gain / neuromodulatory state, so the same tissue under two neuromodulatory regimes is optimising two objectives. Nothing in the anatomy identifies which |
| It cuts the other way too **(brainstorm)** | If the precision *is* the objective, then measuring precision — not fitting tuning curves — is the identifiable experiment. This is the only route in the wiki where an objective claim reduces to a measurable circuit parameter rather than a model comparison |

---

## A fourth direction: the *learning algorithm* is the least identifiable component of all

The three directions above concern the objective. A large-scale controlled comparison adds the algorithm to the list. Across four datasets (MNIST, CIFAR-10, CIFAR-100, ImageNet 32×32), two cost functions, a batch-size sweep and a weight-initialisation sweep, equilibrium propagation on a predictive-coding energy is competitive with backpropagation **in every cell** — and the authors' own summary of the sweep is that end performance "depends prominently on the cost function and the batch size" and "depends little on the learning algorithm used" (Kerjan et al. 2026, [[wiki/concepts/energy-based-models.md]]). The magnitudes: on ImageNet 32×32, swapping mean-squared error for cross-entropy moves top-5 error 55.9 → 36.6, while swapping backpropagation for equilibrium propagation moves it ~0.1.

| Consequence | For this page |
|---|---|
| **Credit-assignment mechanism is not recoverable from performance** | Two learning rules with completely different locality properties, weight-transport requirements and phase structure land within noise of each other on four datasets. No behavioural or accuracy-level measurement distinguishes them, which is the many-to-one direction applied one level below the objective |
| **The identifiable choices are the ones the wiki treats as incidental** | Cost function, batch size and initialisation gain are the load-bearing variables; the algorithm is not. An emergence audit that names an *architecture* and a *rule* but leaves `C` unstated has named the two variables that do not matter and omitted one that does |
| **(brainstorm)** It cuts against the wiki's own selection criterion | Much of [[wiki/concepts/biologically-plausible-credit-assignment.md]] ranks rules by how closely they approximate backpropagation's gradient. If any of them, at scale, reaches backpropagation's accuracy regardless, then gradient alignment was never the quantity that discriminated — and the discriminating experiment has to be something other than a benchmark number: sample efficiency, forgetting, or the trajectory lever this page already names |

---

## Connections

- **[[wiki/entities/cscg.md]]** — the one instance in the wiki where this page's degeneracy is broken empirically: three architectures reach the same orthogonalized endpoint and only one reproduces the order in which a brain reaches it — bought at the cost of a symbol-encoding choice that flips the result.
- **[[wiki/concepts/path-integration.md]]** — the direct target: this page shows the task on that page does not by itself produce the code, so path-consistency of `g` remains an architectural commitment rather than something a loss discovers (T38).
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the strongest limit on the reverse channel: matched tuning curves and high linear predictivity certify neither the objective nor the algorithm, so a "validation" entry in that page's track record can be an artefact of the modeller's target choice or of representational dimensionality.
- **[[wiki/concepts/representation-probing.md]]** — the same weakness in a third instrument: grid score and regression predictivity are decodability measures, so "found in the model" and "found in the brain" are symmetric claims that both fall short of mechanism.
- **[[wiki/concepts/three-component-framework.md]]** — the sharpest available argument that the three slots are not separately identifiable from behaviour or representation: what looks like an objective result here is an architecture-and-target result, and the page's proposed sufficient property set is written into the objective slot.
- **[[wiki/concepts/abstract-structural-codes.md]]** — removes one leg of that page's support for a periodic `g`: hexagonal codes in trained networks come from centre–surround targets, not from the structural task, so the case rests on recordings and attractor theory.
- **[[wiki/concepts/shortcut-learning.md]]** — Morgan's Canon applied to modellers rather than models: never attribute to an objective what is adequately explained by the supervised target's second-order statistics.
- **[[wiki/concepts/latent-graph-discovery.md]]** — an identifiability failure one level up from G16: not only is the intended graph unidentifiable from data, the *objective* is unidentifiable from a system that has learned one.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the architecture whose grid-like units this page's argument bears on most directly; it is also the partial answer, since its structural code is trained on raw-observation prediction rather than on a hand-shaped spatial readout. Its 2018 precursor makes that concrete: the only target is a one-hot categorical over sensory identities, whose correlation matrix cannot be a centre–surround kernel, so audit item 2 is passed outright — while items 1, 3, 4, 5 and 6 are simply not reported. The 2020 primary paper keeps the same one-hot target and adds an argument this page should weigh: grid and band codes are claimed to follow from two constraints on `g` (distinct per state, invariant on return) that come from its role as a *memory address*, not from anything spatial — so if that derivation holds, periodicity is predicted by the architecture's function rather than smuggled in by a target. The audit items still go unreported in 2020 as well.
- **[[wiki/concepts/successor-representation.md]]** — the rival derivation that survives this critique differently: grid-like codes as eigenvectors of a transition operator need no chosen readout kernel, but they are also a *population* claim rather than a single-unit one, which is exactly the level this page says is legitimate.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the companion caveat on the biological side: that page's detector is an arbitrary threshold, this page's grid score is the same instrument applied to models, so T37 and T38 are one problem measured in two systems.
- **[[wiki/concepts/population-geometry.md]]** — the instrument for the level this page licenses, and the empirical demonstration that the licence is drawn in the right place: manifold geometry transfers across brains through one rotation while single-cell fields have no correspondence at all. It also adds a seventh audit item in spirit — run the pipeline on the raw *input* stream and check the shape is not already there.
- **[[wiki/entities/spiking-tem.md]]** — the first source in the wiki to run this page's audit on itself rather than be subjected to it: a mechanism-by-mechanism ablation table over four seeds, and a one-hot categorical target with no centre–surround second-order structure for the readout-correlation mechanism to exploit — while still failing items 3, 5 and 6 (no heterogeneous readout, no toroidal population invariant, no filtered-noise control), and its grids are 4-fold and phase-uniform, which is what item 5 would have predicted.
- **[[wiki/entities/mm-tem-hippoformer.md]]** — another one-hot-target case where grid-like units appear with no centre–surround readout anywhere in the loss, and the first to run a train-time/test-time control on the hyperparameter it credits with setting the scale (changing the prediction horizon after training leaves the period unchanged) — while still leaving module structure, adjacent-scale ratios and filtered-noise controls unreported.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — the identifiability question moved onto the learning rule: a meta-loss over a fixed candidate basis with an L1 penalty is an explicit device for making *which mechanism did the work* recoverable, where a per-synapse discovered rule leaves it unidentifiable.
- **[[wiki/concepts/manifold-constrained-learning.md]]** — the strongest support in the wiki for this page's central line that population-level structure is a legitimate target: a factor-analysis subspace fitted to baseline activity goes on to predict which of two confound-matched decoder perturbations an animal can learn, so the population object earns its status by predicting a manipulation rather than by fitting the data it came from (Sadtler et al. 2014).
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the sharpest instance of the many-to-one direction: one network's objective is set by a per-layer variance parameter, so backpropagation, principal-component analysis and inverse regression are the same architecture at three precision ratios and no representation can distinguish which one was intended.
- **[[wiki/concepts/energy-based-models.md]]** — the controlled sweep that puts the *learning algorithm* on this page's non-identifiability list: equilibrium propagation and backpropagation land within noise of each other across four datasets, while the cost function moves top-5 error by ~19 points (Kerjan et al. 2026).
