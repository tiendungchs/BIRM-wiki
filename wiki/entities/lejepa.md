# LeJEPA (Latent-Euclidean JEPA)

**A JEPA whose anti-collapse provision is *derived* rather than chosen: prove that the isotropic Gaussian uniquely minimises downstream probe risk over unknown tasks, then enforce it with a sketched normality test — one coefficient, no predictor, no teacher, no stop-gradient, no register tokens, ~50 lines, stable to 1.8B parameters, and a training loss that correlates ρ_s ≈ 0.99 with downstream accuracy.**

> **Provenance.** Balestriero & LeCun 2025, *LeJEPA: Provable and Scalable Self-Supervised Learning Without the Heuristics* (`raw/balestriero-2025-lejepa.md`), arXiv:2511.08544v3, Brown / NYU / Meta-FAIR. Code released. This is the **primary source for SIGReg**, which the wiki has carried since [[wiki/entities/lewm.md]] (Maes et al. 2026) — a downstream application by an overlapping author group, ingested first.

Two things make this worth a page beyond "another JEPA". First, it is the wiki's only anti-collapse provision that begins with a *decision-theoretic derivation of the target* rather than with a mechanism that empirically avoids collapse. Second, it produces the instrument tensions **T164** and **T168** said nobody had: a **label-free scalar that ranks trained checkpoints by downstream quality**.

---

## Part 1 — Which distribution should the embeddings follow?

The question every entry in gap **G34** answers implicitly and none of them states. Fix the embedding matrix `Z ∈ R^{N×K}` and a total-variance budget (`Tr(Cov(Z)) = κ`, or the Frobenius / determinant / spectral variants — the choice does not change the optimum). Compare embeddings with the same column span and the same energy but different covariance spectra.

| Result | Statement |
|---|---|
| **Lemma 1** (bias, linear probe) | Whenever the covariance spectrum is not flat (`λ_K > λ_1`), there **always exists** a downstream task `y` for which the ridge estimator `β̂ = argmin ‖y − Zβ‖² + λ‖β‖²` has higher bias than under the isotropic embedding, for any `λ > 0` |
| **Lemma 2** (variance, linear probe) | At `λ = 0`, `tr(Var(β̂_aniso)) > tr(Var(β̂_iso))` — OLS total variance is minimised by isotropy |
| **Theorem 1** (nonlinear probes) | For radius-`r₀` k-NN, `ISB = r₀⁴/(K+2)² · τ_g² J(p) + O(r₀⁴)`; for Nadaraya–Watson kernel regression, `ISB ≤ (h²μ₂(K)/2)² (2B² + 8L² J(p)) + o(h⁴)`. Among all distributions under a scalar covariance constraint the **isotropic Gaussian is the unique minimiser** of the integrated squared bias |

Isotropy falls out of the linear analysis; **Gaussianity** is what the nonlinear analysis adds, through the Fisher-information-like functional `J(p)` of the density. So `N(0, I)` is not an aesthetic choice of target — it is the minimax-flavoured answer to *"minimise worst-case probe risk when the downstream task is unknown"*.

**What the theorem does and does not license.**

- It is **worst-case over tasks**. If the downstream task family *is* known, an anisotropy aligned with it is better by the same algebra — the theorem's force comes entirely from the foundation-model premise that `y` is unavailable at pretraining time.
- It constrains the **marginal distribution of the code**, nothing about relations among tokens within one input ([[wiki/entities/dinov3.md]]'s Gram anchoring) and nothing across time ([[wiki/entities/lewm.md]]'s temporal straightening, T153).
- It assumes probes of the stated families and a fixed total variance. It says nothing about a *finetuned* backbone.
- **It is contradicted where the data's intrinsic dimension is below `K`** — see the tension in §Limitations.

---

## Part 2 — SIGReg: how to enforce it at scale

```
SIGReg(Z) = (1/M) Σ_{m=1}^{M} T( Z a_m ),      a_m ~ Unif(S^{K−1}),  resampled every step
T(u)      = N ∫ w(t) |φ̂_u(t) − φ_0(t)|² dt     (Epps–Pulley),  φ̂_u(t) = (1/N) Σ_n e^{i t u_n}
w(t)      = e^{−t²/2σ²},  φ_0 = CF of N(0,1)
```

**Sketching (§4.1).** The multivariate null `H₀ : P_θ = Q` is decomposed by the union-intersection principle into directional nulls `H₀(a) : a^⊤_# P_θ = a^⊤_# Q`, whose aggregate is consistent for the original by a modified **Cramér–Wold** theorem. The paper's global statistic is `max_a T`; the *loss* replaces the max by a mean, purely to avoid sparse gradients over directions.

**Why the Epps–Pulley statistic and not the obvious alternatives** — this is the part [[wiki/entities/lewm.md]] uses without deriving:

| Family | Instance | Why rejected / kept |
|---|---|---|
| **Moments** | Jarque–Bera, extended to the first four moments (EJB) | *Identifiability–stability conundrum.* A finite number of moments does not determine the distribution, so shortcut solutions survive; but the `k`-th moment's gradient norm scales `O(k)` and its Monte-Carlo gradient variance `O(k² m_{2(k−1)})`. Accuracy and stable training cannot be had together |
| **CDF** | Cramér–von Mises, Anderson–Darling, Watson, Shapiro–Wilk | Require **sorting**: non-differentiable order statistics, `O(N log N)`, and a synchronisation barrier that breaks the embarrassingly-parallel structure of distributed SGD. Kolmogorov–Smirnov additionally gives `ℓ_∞` (sparse) gradients |
| **Characteristic function** | **Epps–Pulley** | The empirical CF is a mean of complex exponentials — differentiable, and a single `all_reduce` across GPUs. **Bounded loss, gradient and curvature for any input distribution**: `‖∇_θ EP(a)‖ ≤ (4σ²/N) Σ_i ‖a^⊤ ∇_θ f_θ(x_i)‖`. `O(N)` time and memory. No hyperparameters beyond the quadrature |

The integral is a **17-knot trapezoid rule on `[−5, 5]`** (symmetry doubles the knots for free); the minibatch estimator carries an explicit `O(1/N)` bias, measured to be harmless down to **batch 16**. Cost: **0.465 ms** for `N = M = 512` on a V100.

**Why `M` random directions do not lose to the curse of dimensionality.** Two independent arguments:

1. **Smoothness.** For a density with Sobolev regularity `α`, the expected directional discrepancy over *all* directions, given the test is satisfied on `M` of them, decays as `M^{−2α/(K−1)}`. Deep networks are smooth (architecture + implicit and explicit regularisation), so `M = O(K)` suffices for an `ε`-approximation.
2. **SGD.** Directions are **resampled every step**, so the cumulative count grows linearly with training time. Measured: `M = 16` resampled beats a *fixed* set of thousands. This is the operative one — and it is the reason the wiki's "`M = 1024` projections" reads as a large number and is not.

Synthetic control: `N` samples in `D = 512` dimensions, isotropic Gaussian except two coordinates set to an adversarial "X" shape; with `M = 16` resampled directions, gradient descent on SIGReg alone finds and unfolds the two degenerate dimensions.

---

## Part 3 — The full objective

```
L_LeJEPA = λ · (1/V) Σ_v SIGReg({z_{n,v}}_n)  +  (1−λ) · (1/B) Σ_n L_pred({z_{n,v}}_v)

L_pred   = (1/V) Σ_{v'=1}^{V} ‖ μ_n − z_{n,v'} ‖²₂ ,      μ_n = (1/V_g) Σ_{v=1}^{V_g} z_{n,v}
```

Every view — global and local — regresses onto the **centroid of the global views**. The `V_g × V` pairwise form collapses algebraically to the centroid form, which is where the cost saving comes from. DINO's multi-crop supplies the views; nothing else of DINO survives.

| Recommended default | Value | Ablation range |
|---|---|---|
| `λ` (the *only* hyperparameter) | **0.05** | Flat across the sweep; scale it up proportionally with view count |
| Views | `V_g = 2`, `V_l = 8` | `V_g = 1` is the one bad setting (53.1 vs 72.3 at `V = 4`) |
| Slices `\|A\|` | 1024 | 512 → 2048 worth <1 point |
| Quadrature knots / domain | 17 / `[−5, 5]` | 5 vs 17 vs 41 knots: ±0.3 |
| Batch | ≥128 | 128 → 1024: 72.2 → 74.7 |
| Projector | present, **narrow beats wide** (64-d best, 75.65; 1024-d 74.79) | — |

---

## Part 4 — What it deletes

Ablation on ImageNet-100, 400 epochs (top-1, frozen linear probe):

| Backbone | no predictor, no SWA | no predictor + SWA | predictor, no SWA | predictor + SWA |
|---|---|---|---|---|
| ResNet-50 (3-layer proj.) | **83.93** | 83.50 | 83.57 | 82.82 |
| ViT-S/8 (3-layer proj.) | 81.07 | **84.12** | 81.91 | 82.58 |

- **The predictor is not needed, and is mildly harmful.** In [[wiki/entities/byol.md]] and [[wiki/entities/i-jepa.md]] removing it collapses the system to chance; here it is a deletable component. What remains of teacher–student is **SWA** (stochastic weight averaging on the encoder producing `μ`), which buys ViTs ~3 points and ResNets nothing — a performance device, not an anti-collapse device.
- **Register tokens are not needed either.** 0/1/2/4/8 registers span **75.08–75.84** on a ViT-L/14. The paper's reading: the instabilities [[wiki/entities/dinov2.md]] and [[wiki/entities/dinov3.md]] introduced registers to fix are attributed to a **poorly conditioned objective**, not to a property of ViTs. (An attribution, not a controlled test — they do not run DINOv2's objective in this codebase.)
- **Architecture-agnostic.** ~50 `timm` models under 20M parameters, 8 families (ResNet, ViT, ConvNeXt, MaxViT, Swin, LeViT, …), unchanged recipe, ImageNet-10: **91.5–95%**. Every other entry in the wiki's SSL set is a ViT method or a ResNet method.

---

## Part 5 — The training loss predicts downstream accuracy (the result the wiki most needed)

| Quantity | Value |
|---|---|
| Spearman `ρ_s`(train loss, downstream linear-probe accuracy), across architectures, datasets, learning rates, weight decays, epoch budgets | **≈ 0.85** |
| With the `λ`-scaling law `C^{(α)} = ρ_s(train_loss / λ^α, test_acc)`, `α ≈ 0.4` | **≈ 0.99** |
| In the (SIGReg, prediction) plane | Iso-accuracy fronts are linear and point at the lower-left corner |

The stated problem: SSL pretraining has no reliable quality signal, so practitioners monitor a *supervised* probe, or unsupervised proxies (α-ReQ, RankMe, LiDAR); and "the latest JEPA models" have training losses with low correlation to downstream performance that may not even decrease monotonically.

**Why this bears directly on the wiki's open tensions.**

- **T164** ("must a collapse-avoiding learner descend a well-defined objective?") was settled to *a term certifies the target, not the trajectory* — VICReg's minimum is non-collapsed everywhere in coefficient space and training collapses anyway. A loss whose *value* is monotone in downstream quality certifies the trajectory too, which is the first concrete thing certifiability buys, and the first argument for A over B that is not aesthetic.
- **T168** ("is collapse-avoidance a property or a state?") concluded that certification must be **per read-out and monitored over the run**. This supplies the monitor — for free, with no labels.
- **(brainstorm) And it is probably blind to exactly DINOv3's failure.** The correlation is measured against *global* linear-probe accuracy. DINOv3's degradation was invisible to the ImageNet probe (which rose monotonically for 1M iterations) and visible only on **patch-token** read-outs. LeJEPA's SIGReg term scores the distribution of one embedding per view, so a dense read-out dying while the marginals stay Gaussian is not excluded by anything measured here. The cheap experiment: run LeJEPA long enough to enter DINOv3's regime and probe patch tokens against the loss. Nobody has — the longest run here is 400 epochs on ImageNet-100 and 100 on ImageNet-1k, against DINOv3's 1M iterations.

---

## Part 6 — Results

| Setting | LeJEPA | Comparison |
|---|---|---|
| ImageNet-1k, ViT-L/14 (0.3B), 100 ep, online linear probe | **77.1** | — |
| ImageNet-1k, ConvNeXt-V2-Huge (0.6B), 100 ep | **78.5** | — |
| Transfer, 8 datasets, all-shot average, frozen backbone | ViT-L **79.48** (304M, 100 ep) | I-JEPA ViT-H 78.50 (632M, 300 ep); +STOP 80.70; IN-22k/900ep 80.82 |
| Transfer, 10-shot average | ViT-L **60.95** | I-JEPA ViT-H 60.51 |
| Fine-grained (DTD / flowers102 / food101), all-shot | **78.30 / 91.21 / 82.05** | I-JEPA ViT-H 73.32 / 86.47 / 81.02 |
| **Galaxy10 in-domain**, frozen probe, all samples | ResNet-34 **78.17**, ResNet-18 75.95 | DINOv3 ViT-S/16 71.38, DINOv2-S 67.62 |
| Galaxy10, full finetune | ResNet-34 **83.28** | DINOv3 81.60, DINOv2-S 78.34 |
| Galaxy10, 1 sample/class, frozen | ResNet-34 **31.08** | DINOv3 30.17, DINOv2-S 27.68 |
| Galaxy10 (11k images), in-domain vs frontier transfer | ResNet-34 **77.29** | I-JEPA ViT-H/14 (630M, IN-22k) **62.93** |
| flowers102 (**1020 training images**), in-domain from scratch | resnext26ts (8M) 82.19 | I-JEPA ViT-H/14 IN-22k 85.76 |
| ViT-g, 1.8B | Stable training loss, no heuristics | — |
| Emergent structure | PCA of last-layer features separates foreground/background; \[CLS\] attention thresholding segments and **tracks objects across video frames** with no segmentation labels | DINO's original emergent-attention result, reproduced without prototypes or teacher |

**The in-domain rows are the ones that change a wiki position.** A 21M-parameter ResNet trained from random initialisation on 11k galaxy images beats a 630M frontier encoder pretrained on ImageNet-22k by **14 points**, and beats DINOv3 under both frozen and finetuned protocols at every shot count. On natural-image data of comparable statistics (flowers102) the frontier model still wins. So the claim that survives is narrow and useful: **transfer learning's advantage is a function of distributional distance, and it inverts once the target domain leaves the pretraining distribution** — which is the classification-side version of **T154** and much cleaner than the control-side evidence, because the encoder is the only thing that varies.

---

## Part 7 — The family taxonomy collapses into one axis

The paper's §5.2 supplies the unification gap **G34**'s answer column has been missing. Substitute a *different univariate test* into SIGReg and existing methods reappear:

| Test `T` plugged into SIGReg | Recovers |
|---|---|
| `mean(u)² + (std(u) − 1)²` (first two moments) | **VICReg**, in the many-slices limit — SIGReg with this `T` enforces exactly `E[Z] = 0`, `Cov(Z) = I` ([[wiki/entities/vicreg.md]]) |
| Moments 3–4 added | Jarque–Bera / EJB — untested as an SSL objective |
| Epps–Pulley with the integral computed **exactly** rather than by quadrature | Per-slice **kernel MMD**, at quadratic complexity |

So the wiki's "dimension-contrastive vs distribution-matching" split is not two families: it is **one family indexed by how many moments of the target the test constrains**, and VICReg is its second-order truncation. The paper argues *against* that truncation on identifiability grounds (finitely many moments do not determine a distribution, so shortcut solutions survive — "a phenomenon already observed in VICReg"). Lineage on the sketching side: sliced score matching, sliced Wasserstein distance.

**Measured, one wave later, and it does not favour the top of the ladder** (§Part 8, Akbar 2026). A sketched *second-moment* test — `‖Cov(ZS^⊤) − I‖_F` — matches or beats the full Epps–Pulley test in 5 of 8 supervised settings, with the biggest gap (+6.2) in its favour. Identifiability is still the argument for climbing; nothing yet shows the climb buys accuracy ([[wiki/empirical-tensions.md]] T171).

**(brainstorm)** This is the sharpest reframing the ingest yields, and it makes the wiki's coefficient-count ordering of anti-collapse provisions look like the wrong axis twice over — [[wiki/entities/i-jepa.md]] already showed the pair sampler dwarfs the loss choice (T167), and now the loss choices that remain are points on a single moment-ladder. The design question worth asking is **how much of the target distribution to specify** (2 moments → all of them → all of them plus relational structure), and each extra specification is a stronger prior that pays off only when the data can satisfy it.

---

## Part 8 — SIGReg outside self-supervision, and the moment ladder measured

> **Provenance (second source, wave 7.26).** Akbar 2026, *Weak-SIGReg: Covariance Regularization for Stable Deep Learning* (`raw/akbar-2026-weak-sigreg-covariance-regularization.md`), arXiv:2603.05924v1, Kreasof AI. Single author, one dataset (CIFAR-100), no seed variance reported — treat the numbers as directional `(tentative)`. It matters anyway, because it runs the two experiments the sections above could not: SIGReg with a **known** downstream task, and the moment ladder's two ends **head to head**.

**Weak-SIGReg — the ladder's bottom rung, made cheap by the same sketch:**

```
L_weak(Z) = ‖ Cov(Z S^⊤) − I_K ‖_F ,    S ∈ R^{K×C},  S_ij ~ N(0,1)/√C,  K = 64
```

Sketch first, then match the second moment of the sketch. Memory `O(C²) → O(CK)`, which is what makes it applicable to **internal hidden layers of width 1024**, not just to a projector output. Applied with `α = 0.1` as an auxiliary term on top of ordinary supervised cross-entropy.

| Setting (CIFAR-100, top-1) | No SIGReg | Strong (Epps–Pulley, all moments) | **Weak (2 moments, sketched)** |
|---|---|---|---|
| ViT + AdamW + Mixup/CutMix/RandAugment | **20.73 — collapse** | 70.20 | **72.02** |
| ViT, expert-tuned baseline (wd, abs. pos-emb, init, LR schedule, drop-path) | 70.76 | **72.71** | 71.65 |
| ViT + **Muon**, no augmentation | 58.77 | 63.16 | **67.52** |
| ViT + Muon + augmentation | 62.44 | 74.34 | **74.56** |
| ViT (fixed) + Muon + augmentation | 75.87 | **76.98** | 76.24 |
| 6-layer MLP, ReLU, **no BN, no residuals**, pure SGD, no augmentation | 26.77 | 35.99 | **42.17** |
| Same MLP + Mixup/CutMix | 38.08 | 38.70 | 38.40 |
| ResNet-18 + SGD (BN + residuals already present) | 79.03 / 82.13 | 78.86 / 81.18 | 79.42 / 82.13 |

**Four things this changes for the wiki.**

1. **Collapse is not a property of the SSL objective's degenerate minimum.** A ViT minimising plain supervised cross-entropy has no constant-encoder solution — the label term prices it — and the run collapses anyway (20.73%). The paper's framing is Dean–Kawasaki: the representation density is a particle system, and the *stochastic flux* from small batches, high learning rates and aggressive augmentation drives it into a degenerate state that no term in the objective forbids. This is the cleanest available argument for **T168**'s B-side, and stronger than [[wiki/entities/dinov3.md]]'s, which still had a self-supervised objective to suspect. Caveat: "collapse" here is *inferred from the accuracy*, with no rank, spectrum or participation-ratio measurement reported.
2. **Climbing the moment ladder does not pay where the wiki assumed it would.** §Part 7 records the identifiability case for pinning *all* moments rather than two. Head to head, the two-moment truncation wins 5 of 8 rows and loses 3, all three losses on already-stabilised baselines and by ≤1.1 points, while the largest single gap in the table (**MLP, +6.2 for Weak over Strong**) runs the other way. So identifiability and stabilisation are separable goods: the extra moments buy uniqueness of the solution set, and the *stabilising* work is apparently done at `k = 2`. Recorded as [[wiki/empirical-tensions.md]] **T171**.
3. **The optimality theorem's "unknown task" premise is not load-bearing for the *stability* claim.** Part 1's qualification — with a known task family an aligned anisotropy is better — predicts SIGReg should be at best inert under supervised training. It is worth +51 points. The theorem is about probe risk at a converged optimum; this is about reaching one at all, and the two arguments for isotropy do not have the same domain.
4. **Representation geometry and update geometry compose additively.** Muon (orthogonalised updates) rescues the collapsed ViT to 62.44 on its own; Weak-SIGReg on top takes it to 74.56, and the best number in the paper is architecture heuristics + Muon + Strong SIGReg (76.98). Against **T166**, whose A-side is Barlow Twins losing 10 points to a BYOL-style graft, this is a clean case of two anti-collapse provisions from different loci stacking — and the distinguishing feature is that Muon constrains the *update* while SIGReg constrains the *representation*, so neither drags the other off its minimum. The ResNet-18 rows add the no-op control: where BN and residuals already hold the geometry, SIGReg costs ≈0 (−0.95 to +0.39), so it is safe as a default rather than a repair.

**What it does not show.** No sketch-dimension ablation (`K = 64` throughout), no `α` sweep, no measurement of the covariance spectrum it is supposedly fixing, one dataset, and an internal inconsistency the paper reads past: Weak beats Strong on the untuned ViT and loses to it on the tuned one, so "additive gains" is uneven and the ranking of the two rungs may be a function of how well-conditioned the run already is.

---

## Limitations

| Stated / evident | Reading |
|---|---|
| The optimality theorem assumes the downstream task is **unknown** | With a known task family the argument reverses; the theorem is a foundation-model premise, not a universal one |
| Vision only | No language, no video, no control. The wiki's world-model use of SIGReg ([[wiki/entities/lewm.md]]) is *not* covered by the theorems — a temporal sequence's marginals being Gaussian says nothing about the transition |
| Short schedules | 100 epochs ImageNet-1k, 400 ImageNet-100. The failure mode [[wiki/entities/dinov3.md]] found appears at 200k–1M iterations, past everything measured here |
| The minibatch Epps–Pulley estimator is **biased** `O(1/N)` | Unbiased alternatives (U-statistic debiasing, sample splitting) named and not explored |
| Not stated: **the target's dimensionality is a free parameter with a measured cost** | [[wiki/entities/lewm.md]]'s Two-Room failure and [[wiki/entities/vicreg.md]]'s `ℓ₂`-normalisation −3.5 both say forcing a low-intrinsic-dimension stream into a `K`-dimensional isotropic Gaussian hurts. The theorem fixes the *shape* at a given `K` and is silent on choosing `K` — recorded as [[wiki/empirical-tensions.md]] **T169** |
| Not stated: nothing constrains **relations** | Neither within an input (patch tokens) nor across time. Both are where the wiki's two known partial-collapse results live (T153, T168) |
| The register-token claim is an attribution | LeJEPA is stable without registers; that DINOv2/v3's instabilities were objective-conditioning is inferred, not demonstrated |
| The identifiability case for pinning *all* moments is untested against pinning two | Part 8 tests it and the two-moment truncation wins more rows than it loses, on one dataset in a supervised setting — so the ladder's top rung is justified by theory and not yet by measurement (T171) |
| The theorem assumes the task is unknown; the *stabilisation* effect does not | SIGReg is worth +51 points under fully supervised CIFAR-100 training, where the task is known and the theorem predicts at best inertness — probe-risk optimality and optimisation stability are two arguments for isotropy with different domains (Part 8) |

---

## Comparison

| | **LeJEPA** | [[wiki/entities/i-jepa.md]] | [[wiki/entities/dinov2.md]] / [[wiki/entities/dinov3.md]] | [[wiki/entities/vicreg.md]] | [[wiki/entities/byol.md]] |
|---|---|---|---|---|---|
| Anti-collapse locus | loss — **full distribution match** to `N(0,I)` | update rule (EMA + predictor) | teacher-output normalisation + KoLeo (+ Gram anchoring) | loss — variance hinge + covariance, per branch | update rule |
| Target derived or chosen | **derived** (Theorem 1) | n/a | chosen | chosen | n/a |
| Coefficients | **1** (`λ`, flat) | 0 | ≥3 + schedules | 1 free scale, collapse boundary 2× away | 0 (`τ`, LR ratio instead) |
| Predictor | **no** | yes (necessary) | no | no | yes (necessary) |
| EMA teacher | **no** (SWA optional, +0 to +3) | yes (necessary) | yes | no | yes (necessary) |
| Registers needed | **no** | n/a | yes | n/a | n/a |
| Architecture family | **any** (8 families) | ViT | ViT | ResNet | ResNet |
| Loss ↔ downstream accuracy | **ρ_s 0.85 → 0.99** | not reported (stated poor) | not reported | not reported | not reported |
| Pairs from | multi-crop augmentation | **masking** (the dominant lever, T167) | multi-crop + masking | augmentation | augmentation |
| Largest run | ViT-g 1.8B (stability only) | ViT-H/16₄₄₈ | 7B, 1M iters | ResNet-50 | ResNet-200×2 |

---

## Connections

- **[[wiki/concepts/disentanglement.md]]** — where this system's `h(x) ~ N(0, I_d)` constraint meets its limit: the isotropic Gaussian is preserved by every dense orthogonal matrix, which is exactly the family Locatello et al.'s construction rides, so "recovery up to `Q`" is the impossibility theorem's irreducible remainder rather than an artefact of the proof technique.
- **[[wiki/entities/vl-jepa.md]]** — the concrete untried site for this page's objective: a cross-modal JEPA whose anti-collapse provision is InfoNCE's batch-dependent uniformity term, which names SIGReg as a drop-in and leaves it to future work.
- **[[wiki/entities/lewm.md]]** — the downstream application the wiki held first: SIGReg transplanted from two-views-of-an-image to two-timesteps-of-a-trajectory, with the same `λ`-robustness and the same removal of EMA and stop-gradient. This page supplies what that one asserts — *why* `N(0, I)` and not some other target, *why* Epps–Pulley and not moments, and *why* a few hundred random directions suffice — and its Two-Room failure is the empirical limit on this page's Theorem 1.
- **[[wiki/entities/vicreg.md]]** — recovered as a **special case**: SIGReg with the degenerate test `mean² + (std−1)²` is VICReg in the many-slices limit, so the dimension-contrastive family is the second-moment truncation of distribution matching, and the paper's identifiability argument (finitely many moments do not determine a distribution) is a stated case *against* that truncation. **And the special case measures at least as well as the general one** — sketched to `O(CK)` and applied to internal hidden layers, VICReg's covariance term wins 5 of 8 head-to-head rows against the full Epps–Pulley test (T171).
- **[[wiki/entities/barlow-twins.md]]** — the same second-moment ceiling reached from the cross-correlation side (`C → I` is a statement about two moments), which is why both it and SIGReg get a single flat coefficient while VICReg's ray has a collapse boundary: they constrain a target that is stated exactly, and differ only in how much of the distribution the statement covers.
- **[[wiki/entities/byol.md]]** — the mechanism this design removes and prices: BYOL's predictor and EMA are each individually necessary there (removing either collapses at ~0.3%), and here the predictor is deletable with no loss and the EMA survives only as optional SWA worth ~3 points on ViTs and 0 on ResNets, so what was load-bearing becomes a performance tweak once the distribution is constrained directly (T164).
- **[[wiki/entities/i-jepa.md]]** — the head-to-head inside the JEPA lineage: 304M / 100 epochs beats 632M / 300 epochs on all-shot transfer average (79.48 vs 78.50) and on every fine-grained dataset, with zero anti-collapse coefficients replaced by one — while conceding the larger lever, since I-JEPA's pair sampler moves a fixed objective by 15.5 → 54.2 and everything on this page moves it by a few points (T167).
- **[[wiki/entities/dinov2.md]]** — the encoder this page's in-domain result is aimed at: a 21M ResNet trained from scratch on 11k galaxy images beats DINOv2-S and DINOv3 under frozen probing, finetuning and every shot count, which locates transfer learning's advantage in distributional proximity rather than in corpus size (T154).
- **[[wiki/entities/dinov3.md]]** — two-way tension: this page removes register tokens and attributes their necessity to a poorly conditioned objective, while DINOv3's partial-collapse result is exactly the failure this page's label-free loss signal would not see, since it is measured against a *global* probe and DINOv3's global probe rose monotonically while the dense read-out died (T168).
- **[[wiki/entities/hit-jepa.md]]** — the complementary blind spot: SIGReg is a per-branch, per-view constraint, and hi-JEPA's factor-465 collapse came from an inter-level channel that no per-branch term scores, so a distribution match on each level's embedding would not have caught it either.
- **[[wiki/concepts/energy-based-models.md]]** — supplies that page's taxonomy with a *derivation* for the distribution-matching family's target and then collapses the taxonomy: the loss families are one moment-ladder indexed by how much of the target distribution the test constrains. §Part 8 goes further: a supervised objective with no degenerate minimum collapses under the same conditions and is repaired by the same term, so that page's families are drift controls before they are minimum-shaping devices.
- **[[wiki/concepts/population-geometry.md]]** — the strongest normative claim in the wiki about what a representational geometry should *be*: isotropy minimises linear-probe bias and variance, and the isotropic Gaussian uniquely minimises k-NN and kernel-probe integrated squared bias, when the read-out task is unknown. The claim is also wider than the theorem: isotropy repairs a collapsed *supervised* ViT, where the task is known and the probe-risk argument does not apply, so a second mechanism — gradient conditioning through depth — is doing part of the work.
- **[[wiki/concepts/objective-identifiability.md]]** — Zhang et al. 2026's identifiability theorem assumes an exactly-Gaussian encoder as a *technical* condition; this page shows that same condition is independently optimal on decision-theoretic grounds, so the assumption is not a convenience — and the loss↔accuracy correlation is the first label-free way to tell whether a run reached the minimiser those theorems are about.
- **[[wiki/concepts/representation-probing.md]]** — inverts the usual direction: instead of using a probe to rank representations, it derives the representation that minimises probe risk over unknown tasks, which makes the probe's own bias/variance the design target rather than the measurement.
- **[[wiki/concepts/shortcut-learning.md]]** — the identifiability argument in its shortcut form: a test that constrains finitely many moments leaves a family of distributions satisfying it, and the encoder is free to sit anywhere in that family, which is the paper's stated reason to prefer a characteristic-function test over a moment-matching one.
- **[[wiki/entities/learningmatch.md]]** — the inverse prescription for the same problem: this page shapes the *embedding distribution* so that the simplest read-out is optimal, Green et al. 2025 leave the embedding alone (encoder depth barely moves the error) and grow the *read-out* instead, because their target similarity varies with position on the manifold and no translation-invariant distance form can express it ([[wiki/empirical-tensions.md]] T173).
- **[[wiki/concepts/alignment-uniformity.md]]** — the prior derived target, and the correction to "the one normative statement in this area": uniformity on `S^{m-1}` was derived in 2020 from entropy maximisation and the uniqueness of `σ_d` as the Gaussian-potential minimiser, agreeing with this page's `N(0,I_K)` on every direction and disagreeing only on whether the norm carries information (T304) — and the moment ladder it defines already contained the *contrastive* loss, which this page treats as a separate family.
- **[[wiki/concepts/representational-collapse.md]]** — the derivation of locus 3's target, the moment ladder that folds loci 2 and 3 into one family, the label-free checkpoint monitor, and the result that removes the whole taxonomy's founding premise.
