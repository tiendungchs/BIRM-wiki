# LeWorldModel (LeWM)

**A joint-embedding predictive world model trained end-to-end from raw pixels with exactly two loss terms — next-embedding prediction plus a regulariser that forces the embedding distribution to be an isotropic Gaussian — no exponential moving average, no stop-gradient, no pretrained encoder, no auxiliary supervision: 15M parameters, one GPU, a few hours, and planning up to 48× faster than a foundation-model world model.**

> **Provenance.** Maes, Le Lidec, Scieur, LeCun & Balestriero 2026, *LeWorldModel: Stable End-to-End Joint-Embedding Predictive Architecture from Pixels* (`raw/maes-2026-leworldmodel-jepa-from-pixels.md`), arXiv:2603.19312v3, Mila/Université de Montréal + NYU + Samsung SAIL + Brown. Code released. The design lineage is [[wiki/entities/h-jepa.md]]; the at-scale sibling is [[wiki/entities/v-jepa-2.md]]; the objective it implements is the one analysed theoretically by Zhang et al. 2026 ([[wiki/concepts/objective-identifiability.md]]).

This is the wiki's **small** JEPA. Its interest is not a new capability but a subtraction: every stabiliser the JEPA lineage accumulated — EMA teacher, stop-gradient, frozen foundation encoder, proprioception, action decoders, seven-term VICReg objectives — is removed at once, and the resulting system still plans.

**SIGReg is not this paper's invention, and the wiki now holds the source** ([[wiki/entities/lejepa.md]], Balestriero & LeCun 2025 — an overlapping author group, ingested after this page). That source supplies the three things this page uses without stating: `N(0, I)` is *derived* as the distribution minimising linear-, k-NN- and kernel-probe risk over unknown downstream tasks rather than chosen; the Epps–Pulley statistic is picked over moment- and CDF-based tests because it alone has bounded gradients, differentiability and `O(N)` distributed cost; and `M` a few hundred suffices because directions are **resampled every step** (`M = 16` resampled beats thousands held fixed). It also removes the predictor entirely, which this page keeps.

**What is being subtracted has a name and a paper**: the EMA-target-plus-stop-gradient pair is BYOL's, transplanted from two-views-of-an-image to two-timesteps ([[wiki/entities/byol.md]]). The objection LeWM makes — that they correspond to no well-defined objective — is BYOL's own stated hypothesis rather than an outside criticism, and BYOL's ablations say what the subtraction has to replace: removing *either* the predictor or the EMA target collapses that system outright, so the two removed components were doing anti-collapse work that SIGReg now has to do alone.

---

## Architecture

| Component | Spec |
|---|---|
| Encoder `z_t = enc_θ(o_t)` | ViT-Tiny, ~5M params, patch 14, 12 layers, 3 heads, width 192, on `224×224` frames. Embedding = the **\[CLS\] token only**, then a 1-layer MLP projector with **BatchNorm** |
| Why the projector exists | The ViT's final **LayerNorm** normalises each embedding onto a sphere, which makes the isotropic-Gaussian objective unoptimisable. The projector is there to undo a normalisation, not to add capacity |
| Predictor `ẑ_{t+1} = pred_φ(z_t, a_t)` | 6-layer transformer, 16 heads, 10% dropout, ~10M params; `N`-frame history, temporal causal mask, autoregressive; its own projector on the output |
| Action conditioning | **AdaLN** at every layer, parameters **zero-initialised** so action conditioning enters gradually |
| Total | **~15M**, single GPU, hours |
| Data | Offline, reward-free, action-labelled trajectories of unspecified optimality; frame-skip 5 (5 actions grouped per block), batch 128, sub-trajectories of 4 frames |

**The one architectural fact worth carrying:** the observation is compressed to a **single 192-dimensional vector per frame**, against DINO-WM's patch-token grid — ~200× fewer tokens. Every speed number below is downstream of that choice, and so is the failure profile (§ *What the latent loses*).

---

## The objective, and the hyperparameter count as the headline number

```
L_LeWM = ‖ẑ_{t+1} − z_{t+1}‖²₂  +  λ · SIGReg(Z)

SIGReg(Z) = (1/M) Σ_m T(Z u^(m)),   u^(m) ~ Unif(S^{d−1})
T(h) = ∫ w(t) |φ_N(t; h) − φ_0(t)|² dt        (Epps–Pulley statistic, φ_0 = N(0,1))
```

- **Cramér–Wold** does the work: matching every 1-D marginal of `Z` to `N(0,1)` is equivalent to matching the joint to `N(0, I)`. High-dimensional normality testing, which has no reliable direct estimator, becomes `M` univariate tests along random directions.
- `M = 1024` projections, `λ = 0.1`. **Nothing is stop-gradiented** — the prediction loss back-propagates into the *target* embedding as well as the predicted one, which is exactly the configuration the EMA lineage exists to avoid.

| Quantity | PLDM (the only other end-to-end pixel JEPA) | **LeWM** |
|---|---|---|
| Loss terms | 7 (VICReg-derived; [[wiki/entities/vicreg.md]] itself has 3) | **2** |
| Tunable loss hyperparameters | 6 | **1** (`λ`; `M` and the number of quadrature knots are measured to be inert) |
| Hyperparameter search cost | `O(n⁶)` grid | **`O(log n)` bisection** |
| Training curves | Noisy, non-monotone across several terms | Prediction loss falls monotonically; SIGReg drops sharply then plateaus |
| PushT success, 3 seeds | 78.0 ± 5.0 | **96.0 ± 2.83** (DINO-WM 92.0 ± 1.63) |
| `λ` robustness | — | >80% success for `λ ∈ [0.01, 0.2]`, peak ≈0.09; collapses only at 0.5, where the regulariser outweighs prediction |

**Why this belongs in the wiki as a result rather than an engineering note.** Gap **G34** says every self-supervised objective's cheapest solution is to represent nothing, and the wiki's answer column has carried two families (contrastive, and dimension-contrastive regularisers like [[wiki/entities/vicreg.md]] and [[wiki/entities/barlow-twins.md]]). This adds a third mechanism — **match the embedding distribution to a fixed target** — and prices the difference in the currency that decides whether anyone can use it: *how many coupled coefficients a practitioner must balance*. A six-dimensional grid search is not a worse version of a one-dimensional bisection; it is a different research programme.

**The comparison is against PLDM's objective, not against VICReg's** ([[wiki/entities/vicreg.md]]). VICReg itself has three coefficients, one fixed (`ν = 1`) and two tied (`λ = μ`) — **one free scale**, the same count as SIGReg's `λ`, and the values transfer unchanged from ImageNet to MNIST and CIFAR. The six/seven belongs to the *end-to-end pixel JEPA* built on top of it. So the correct version of this page's argument is not about counting but about **robustness within the count**: SIGReg's `λ` and Barlow Twins' `λ` are flat over wide ranges, while VICReg's ray has a collapse boundary a factor of two away in either direction (`λ=μ=1, ν=1` collapses; `λ=μ=5, ν=1` reaches 68.1).

---

## Planning

Identical in kind to [[wiki/entities/v-jepa-2.md]]: encode `o_1` and a goal image `o_g`, roll the predictor forward over a candidate action sequence, minimise a **terminal** latent cost, execute `K` actions, replan.

```
C(ẑ_H) = ‖ẑ_H − z_g‖²₂ ,   a*_{1:H} = argmin C ,   solver = CEM
```

| Environment (goal-image MPC, fixed hyperparameters across all four) | Result |
|---|---|
| **Push-T** (2D manipulation) | LeWM best; **+18% success over PLDM**, and beats DINO-WM *even when DINO-WM is given proprioception* |
| **Reacher** (2-joint arm) | LeWM best |
| **OGBench-Cube** (3D manipulation) | DINO-WM slightly ahead — attributed to visual complexity making end-to-end encoder training harder |
| **Two-Room** (simplest 2D navigation) | **LeWM worst** — see below |
| Planning wall-clock | <1 s per full plan; **~48–50× faster than DINO-WM**, comparable to PLDM |
| Under **fixed FLOPs** | LeWM significantly outperforms DINO-WM on both Push-T and OGBench-Cube |

**The Two-Room failure is the informative cell, and it is a statement about anti-collapse regularisers in general.** The environment's *intrinsic* dimensionality is low; the target distribution is an isotropic Gaussian in a 192-dimensional space. Forcing a low-complexity data stream to fill a high-dimensional Gaussian degrades the representation. **(brainstorm)** Read as a design rule: an anti-collapse term is not a neutral safety device but a **prior on the latent's geometry**, and it carries a dimensionality specification that must be matched to the environment. **VICReg's per-component variance hinge is the weakest form of the same commitment, and the cost of strengthening it is measured** ([[wiki/entities/vicreg.md]]): a variance *floor* per dimension leaves the joint shape free, but re-running VICReg with the embedding `l2`-normalised — which fixes each dimension's variance at exactly `1/√d`, i.e. specifies the geometry the way SIGReg's `N(0, I)` does — costs **3.5 points** on ImageNet, an environment whose intrinsic dimension is not in doubt. So the price of a geometric commitment is charged even where the target dimensionality is *right*, and Two-Room is that price plus a mismatch. The ablation supplies the other side of the same knob — performance collapses below embedding dimension ≈184 and saturates above it — so the usable band is bounded on both ends and neither bound is predicted by anything.

---

## What the latent contains

### Probing physical quantities (linear and MLP probes, [[wiki/concepts/representation-probing.md]])

Push-T, linear probe, MSE ↓:

| Property | DINO-WM | PLDM | **LeWM** |
|---|---|---|---|
| Agent location | 1.888 ± 0.500 | 0.090 ± 0.311 | **0.052 ± 0.149** |
| Block location | **0.006 ± 0.007** | 0.122 ± 0.341 | 0.029 ± 0.073 |
| Block angle | **0.050 ± 0.101** | 0.446 ± 0.625 | 0.187 ± 0.359 |

LeWM beats PLDM everywhere and is competitive with DINO-WM; on OGBench-Cube it is best on *positional* quantities (block position, end-effector position) while DINO-WM keeps a clear advantage on **velocity and rotational** ones. **All three fail on block orientation** (quaternion, yaw).

**The comparison is confounded and the authors say so:** DINOv2 saw ~124M images spanning a far wider distribution, so its probe advantage is attributable to pretraining data rather than to any modelling choice. This is the probing-page hazard in a clean instance — *a probe ranks representations, not objectives*, and the two systems differ in objective, architecture, parameter count and training corpus at once.

### Read-outs that need no labels

| Instrument | Finding |
|---|---|
| **Post-hoc decoder** (trained after the fact, never in the loop) | A single 192-d embedding reconstructs the visual scene; predictor rollouts from 3 context frames animate the arm and preserve global scene structure, while fine detail (end-effector angle) is not preserved |
| **t-SNE of the latent** | Sweeping agent and block through the x–y plane produces an embedding that preserves neighbourhood relations and relative position — the environment's spatial layout survives into a 192-d vector |
| **Violation of expectation** | See below |

---

## Violation of expectation: a surprise signal that is selectively *physical*

Three environments (TwoRoom, PushT, OGBench-Cube), three trajectories each: unperturbed, **visual** perturbation (an object's colour changes abruptly), **physical** perturbation (objects teleport to random positions). Surprise = prediction–observation discrepancy in latent space.

| Perturbation | LeWM | PLDM | DINO-WM |
|---|---|---|---|
| Physical (teleport) | Pronounced spike, **significant in all three environments** (paired *t*-test, `p < 0.01`) | Significant in two | Detected in two, neither perturbation significant in the third |
| Visual (colour) | Weaker, **not significant** | Significant in two | Detected in two |

**This is the wiki's first VoE result where the *dissociation* is the finding rather than the score.** A latent trained only to be predictable under action conditioning discards colour and keeps continuity of position — so the surprise signal is aligned with the physical regularity and blind to the appearance change, without anyone having specified which is which. Against tension **T146** (a VoE score's free parameters), this is the cheap version of the fix: instead of choosing a summary statistic over the error trace to maximise a score, report a *paired contrast between two perturbation types* on the same trace, where the confound of "how surprising is any change at all" cancels.

**(brainstorm)** It also inverts the usual reading of the compact latent as a liability. Colour-blindness is an information loss, and here it is exactly what makes the surprise signal a physics detector. A foundation encoder trained for visual discrimination cannot have this property by construction — it is *paid* to notice colour — which predicts that the more general the pretrained representation, the worse it works as a violation detector. That is testable on the numbers already in the table.

**It has since been tested, on a much larger model, and it splits.** Garrido et al. 2025 run VoE on **V-JEPA** — a general-purpose foundation video encoder, 300M–630M parameters, ~1M hours of natural video, the exact "more general pretrained representation" the prediction indicts ([[wiki/concepts/violation-of-expectation.md]]). Two halves of the prediction go opposite ways:

- **Refuted on generality.** V-JEPA is the *best* violation detector in the comparison — the only model significantly above an untrained null on all three of IntPhys, GRASP and InfLevel — and performance **rises** monotonically with encoder size and with corpus breadth. Generality does not cost violation sensitivity.
- **Confirmed on colour.** V-JEPA's gain over the null on **colour constancy is not significant**, in a model whose surprise otherwise works and whose corpus is full of colour. So the blindness is not an artefact of a 192-d bottleneck; two independent latent predictors, three orders of magnitude apart in data and one in parameters, both report physical violations and both ignore an object changing colour.

**(brainstorm)** What survives is a sharper claim than the original: *predicting in a representation space* — not compactness — is what selects continuity over appearance, because an appearance change is exactly the kind of unpredictable detail the encoder is paid to discard, at any scale. The remaining discriminator between the two accounts is a *capacity* sweep on one architecture, which nobody has run.

---

## Temporal straightening, emergent — and the authors call it collapse

Measured over training, with no term encouraging it (`v_t = z_{t+1} − z_t`):

```
S_straight = mean_{i,t} cos(v_t^(i), v_{t+1}^(i))          → increases monotonically during training
```

- LeWM's latent trajectories become increasingly straight on PushT as a **purely emergent** phenomenon.
- **LeWM is straighter than PLDM, which has an explicit temporal-smoothness regulariser.**
- The authors' own explanation: SIGReg constrains the marginal at each timestep and says nothing *across* time, so the unconstrained temporal dimension drifts toward a **temporal collapse** — successive embeddings evolving along near-linear paths. They report it as beneficial and do not test it causally.

This lands on the neuroscience temporal-straightening hypothesis (Hénaff et al.) from the opposite direction: there straightening is the property a good perceptual representation *has*, here it is what an under-constrained temporal axis *degenerates into*. Recorded as tension **T153** and folded into [[wiki/concepts/population-geometry.md]].

---

## Comparison

| | **LeWM** | [[wiki/entities/v-jepa-2.md]] | PLDM | DINO-WM |
|---|---|---|---|---|
| Encoder | ViT-Tiny, **trained from pixels** | ViT-g 1B, pretrained then frozen | trained from pixels | DINOv2, frozen |
| Anti-collapse | SIGReg — distribution matching to `N(0, I)` | EMA teacher + stop-gradient | [[wiki/entities/vicreg.md]]-derived, 7 terms | none needed (frozen encoder) |
| Loss hyperparameters | **1** | EMA rate + masking schedule | 6 | — |
| Latent per frame | one 192-d vector | patch grid | patch grid | patch grid |
| Params | **~15M** | 1B + 300M | — | 300M+ |
| Planner | CEM on `‖ẑ_H − z_g‖²`, MPC | CEM on `‖ẑ_H − z_g‖₁`, horizon 1 | CEM | CEM |
| Planning cost | **<1 s per plan** | 16 s/action | ≈LeWM | ~48× LeWM |
| Multi-modal futures | no (deterministic) | no | no | no |
| Hierarchy | no | no | no | no |
| Real robot | no — 2D/3D sim only | **yes, zero-shot** | no | no |

---

## Limitations

| Stated | Reading |
|---|---|
| **Short horizons only**; hierarchical world modelling named as the fix | The same limitation V-JEPA 2 reports. Two independent JEPA implementations now end at the level H-JEPA says should not be alone |
| **Needs offline data with sufficient coverage** | Untracked as a quantity. [[wiki/concepts/learned-world-models.md]]'s `ρ_tr` — the behaviour policy's conditional action excitation — is exactly what "coverage" means here, and it is neither measured nor reported (G63) |
| **SIGReg weakens in low-intrinsic-dimension environments** | The Two-Room result; a mismatch between the target distribution's dimension and the environment's |
| **Requires action labels** | Inverse dynamics named as the escape. [[wiki/entities/adaworld.md]] is the literature's answer, on the pixel branch |
| Not stated: **deterministic transition** | Squared loss on a point prediction, so the predictor returns the conditional mean. Planner exploitation ([[wiki/concepts/learned-world-models.md]]) applies, and a 192-d bottleneck gives CEM less surface to exploit than a patch grid — untested |
| Not stated: **no real-world evaluation** | Every result is in simulation with clean backgrounds, which is the regime where discarding colour is free |

---

## Connections

- **[[wiki/entities/vl-jepa.md]]** — the frozen-target endpoint priced elsewhere (−7.3 classification against a slowly-trained target encoder), and the architecture that names SIGReg as a drop-in replacement for its InfoNCE uniformity term and leaves it untried.
- **[[wiki/entities/dinov3.md]]** — sharpens T154 from the amortisation side: a *frozen* self-supervised backbone plus a 100M-parameter head now beats fully fine-tuned specialists on COCO detection, ADE20k segmentation and monocular depth, so the pretrained-encoder route's cost is entirely front-loaded and the case against it has to rest on planning-time token count alone.


- **[[wiki/entities/v-jepa-2.md]]** — the same architecture at the opposite end of the scale axis, and the head-to-head this literature needs: 15M trained from pixels versus 1B pretrained and frozen, both planning by CEM on a goal-embedding distance, with the small model winning on planning latency and per-FLOP control performance and never leaving simulation.
- **[[wiki/entities/h-jepa.md]]** — the design both instantiate, audited from the cheap end: this system supplies the missing anti-collapse criterion in a single term with one coefficient, and leaves the stack, the latent `z` and the learned cost as unbuilt as V-JEPA 2 does.
- **[[wiki/concepts/energy-based-models.md]]** — supplies the third anti-collapse family for that page's contrastive/regularised split: neither sample- nor dimension-contrastive but **distribution-matching**, driving the embedding's marginals onto a fixed target by a normality test along random projections.
- **[[wiki/concepts/learned-world-models.md]]** — the second joint-embedding entry in that page's survey, and the first whose transition is small enough for the compute argument to run the other way: latency comes from the token count, not from the prediction space.
- **[[wiki/concepts/simulation-based-planning.md]]** — the cheapest instance of MPC over a learned latent in the wiki (<1 s per plan), which converts the planning-cost argument from "latent beats pixels" to "token count beats both".
- **[[wiki/concepts/objective-identifiability.md]]** — the implemented soft version of the exactly-Gaussian encoder constraint Zhang et al. 2026's Theorem 1 assumes: SIGReg is what an approximate `h(x) ~ N(0, I_d)` looks like in a real training loop, so this is the closest the wiki has to an empirical test-bed for that identifiability result.
- **[[wiki/concepts/representation-probing.md]]** — a probe comparison whose confound the authors name themselves: the best-probing representation is the one pretrained on ~124M images, so probe rank tracks training corpus rather than objective.
- **[[wiki/concepts/population-geometry.md]]** — supplies that page's temporal geometry entry and a warning attached to it: latent trajectories straighten monotonically over training with nothing asking them to, and the straightening is more plausibly an under-constrained temporal axis collapsing than a property the objective bought.
- **[[wiki/concepts/core-knowledge.md]]** — a violation-of-expectation signal that separates physical from visual violations without being told the difference, which is the closest thing in the wiki to an entry condition emerging from a predictability objective alone.
- **[[wiki/concepts/counterfactual-probing.md]]** — the contrast case: the same family of world model, probed by comparing *perturbed against unperturbed real trajectories* rather than by injecting a counterfactual into the conditioning path, which is why this system needs no special conditioning interface and gets no partition out.
- **[[wiki/concepts/violation-of-expectation.md]]** — the protocol this page's dissociation result belongs to, and where its prediction (general pretraining should hurt violation detection) is tested against a 1M-hour foundation video model and splits: refuted on scale, confirmed on colour.
- **[[wiki/entities/lejepa.md]]** — the primary source for this page's regulariser, and the limit on it: there `N(0, I)` is proved to be the probe-risk-minimising embedding distribution *at a given dimension `K`*, with nothing said about choosing `K` — which is exactly the free parameter the Two-Room failure here charges for.
- **[[wiki/entities/simsiam.md]]** — the strongest counter to this system's stated motive: the stop-gradient it removes as "corresponding to no well-defined objective" is derivable as the `θ`-subproblem of an alternating minimisation over the network plus one free vector per image, with multi-step alternation confirming the reading — so the objection is that the objective ranges over more than the parameters, not that there is none.
- **[[wiki/entities/byol.md]]** — the paper this system's headline subtraction is aimed at: the EMA teacher and stop-gradient removed here are BYOL's, and BYOL's own ablations say they were doing anti-collapse work (removing either collapses it), so SIGReg is not simplifying a redundancy but replacing a mechanism.
- **[[wiki/entities/vicreg.md]]** — the objective this page's coefficient-count argument was aimed at, corrected and re-aimed: VICReg has one free scale rather than six (the six is PLDM's), so the difference SIGReg buys is robustness rather than count — and VICReg's `l2`-normalised variant prices this page's dimensionality-prior claim at 3.5 points even on data whose intrinsic dimension is ample.
- **[[wiki/entities/barlow-twins.md]]** — the same one-coefficient tuning surface reached from a weaker distributional commitment: matching second moments (`C → I`) instead of the full `N(0,I)`, which is why it has no analogue of this page's intrinsic-dimension failure — decorrelating an over-wide embedding of a low-dimensional world is satisfiable where filling an isotropic Gaussian is not — and why its gains from embedding width are unbounded (to 16384) where here the width is fixed by the target.
- **[[wiki/entities/dinov2.md]]** — the encoder inside DINO-WM, i.e. the thing this page's whole subtraction is against: 1.1B parameters over a curated 142M-image corpus and a patch-token grid, against 15M parameters and one 192-d vector — and the primary source adds that the corpus's advantage is a matter of *shaping* (curated vs uncurated at matched 142M is worth 14 points) rather than of count (T154).
- **[[wiki/entities/i-jepa.md]]** — the image ancestor of the JEPA core this page strips: identical predictor-plus-EMA skeleton with zero anti-collapse coefficients, against this page's one certifiable coefficient and no EMA — and the source of the number this page's whole subtraction assumes, the +26.2 points that latent targets buy over pixel targets.
- **[[wiki/concepts/representational-collapse.md]]** — locus 3 built and priced: one effective coefficient against six coupled ones, no EMA and no stop-gradient, at the cost of committing the latent to a dimensionality the environment may not have.
