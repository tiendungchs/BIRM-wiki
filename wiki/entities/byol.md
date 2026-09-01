# BYOL (Bootstrap Your Own Latent)

**A joint-embedding self-supervised learner with no negatives, no anti-collapse regulariser, and no loss it descends: an online encoder predicts the projection of a slowly-trailing copy of itself on a second augmented view, and collapse is prevented by the *asymmetry* between the two branches alone.**

> **Provenance.** Grill, Strub, Altché, Tallec, Richemond et al. 2020, *Bootstrap Your Own Latent: A New Approach to Self-Supervised Learning* (`raw/grill-2020-byol-self-supervised.md`), DeepMind. Code and checkpoints released. The lineage that inherits its two stabilisers is [[wiki/entities/h-jepa.md]] → [[wiki/entities/v-jepa-2.md]]; the system that removes them is [[wiki/entities/lewm.md]].

---

## Architecture

| Component | Spec |
|---|---|
| **Online branch** `θ` | encoder `f_θ` (ResNet-50 v1, representation `y` = final average pool, 2048-d) → projector `g_θ` (MLP 2048→4096→BN→ReLU→256, output **not** batch-normed) → **predictor `q_θ`** (same MLP shape) |
| **Target branch** `ξ` | same encoder + projector, **no predictor**, `stop-grad` on its output |
| **Target update** | `ξ ← τξ + (1−τ)θ` — exponential moving average of the online weights, `τ_base = 0.996` annealed to 1 on a cosine schedule |
| **Loss** | `L = ‖q̄_θ(z_θ) − z̄′_ξ‖²₂`, both terms ℓ₂-normalised; symmetrised by swapping which view enters which branch |
| **Views** | SimCLR's augmentation set: random resized crop, flip, colour jitter, optional grayscale, Gaussian blur, solarisation |
| **Optimisation** | LARS, cosine decay, 1000 epochs, batch 4096 on 512 TPUv3 cores (~8 h for ResNet-50); weight decay `1.5e−6` — **removing weight decay diverges**, in BYOL and in SimCLR |
| **Kept at the end** | `f_θ` only. Projector and predictor are discarded |

**The asymmetry is the whole design.** The two branches compute different functions (predictor on one side only) and are updated by different rules (gradient vs. EMA). Everything below follows from that and from nothing else — there is no variance term, no covariance term, no negatives, no distribution target.

---

## Results

| Protocol | BYOL | Best prior SSL | Supervised |
|---|---|---|---|
| ImageNet linear eval, ResNet-50 (1×) | **74.3** / 91.6 top-5 | InfoMin 73.0; SimCLR 69.3; MoCo v2 71.1 | 76.5 (weak baseline), 78.9 (strong) |
| ImageNet linear eval, ResNet-200 (2×), 250M params | **79.6** | 76.8 (30% more params) | — |
| Semi-supervised, 1% / 10% labels, ResNet-50 | **53.2 / 68.8** | SimCLR 48.3 / 65.6 | 25.4 / 56.4 |
| Transfer, linear, 12 datasets | beats SimCLR on **12/12**, Supervised-IN on **7/12** | — | — |
| VOC2012 segmentation (mIoU) / VOC07 detection (AP50) | **76.3 / 77.5** | SimCLR 75.2 / 75.2 | 74.4 / 74.4 |
| NYUv2 depth, pct < 1.25 | **84.6** | SimCLR 83.3 | 81.1 |

**Robustness — the two axes where the absence of negatives shows** (300-epoch ablations, 3 seeds):

| Perturbation | BYOL | SimCLR |
|---|---|---|
| Batch 4096 → 256 | flat | degrades steadily (fewer negatives) |
| Batch 4096 → 128 | small drop, attributed *solely* to BatchNorm — the only batch-size dependence in the pipeline | large drop |
| Remove colour distortion | **−9.1** | −22.2 |
| Crop only (all other augmentations removed) | **59.4** (−13.1) | 40.3 (−27.6) |

**The augmentation row now has a counter-example and the mechanism below is contested.** Barlow Twins — no negatives, no discrimination, a dimension-contrastive loss — degrades on the same progressive-removal sweep *like SimCLR* (≈ −25 at crop-only), not like BYOL (Zbontar et al. 2021, [[wiki/entities/barlow-twins.md]]). So "the negatives author the shortcut" cannot be the whole explanation; the surviving candidate is that BYOL's EMA target carries features **no augmentation demanded**, making it the outlier rather than SimCLR ([[wiki/empirical-tensions.md]] T165). The paragraph below is the wiki's original reading, kept because it is still the mechanism for the SimCLR–BYOL gap specifically.

The augmentation result has a mechanism, and it is the sharpest statement of what negatives cost. Crops of one image share a colour histogram and histograms differ across images, so a *contrastive* task on crops alone is solved by colour histogram and the representation is never charged for anything else — the negatives define what the shortcut is ([[wiki/concepts/shortcut-learning.md]]). BYOL's target is not a discrimination but a regression onto a representation that already contains more, so any extra feature the target carries is worth encoding.

---

## The ablations that carry the architectural content

| Configuration | Top-1 | What it establishes |
|---|---|---|
| **Predict a fixed randomly-initialised network** (`τ = 1`, target never updated) | **18.8** ± 0.7 (the random target itself: **1.4**) | A representation can be bootstrapped out of a target carrying no learned information at all. Predicting noise-with-structure is a real training signal |
| Target = EMA, `τ_base ∈ {0.9, 0.99, 0.999}` | 68.4 / **72.5** / 69.8 | Wide plateau; the trade-off is targets that move too fast vs. too slowly |
| Target = online network, `τ = 0` (stop-grad only) | **0.3** | Collapse — *in this recipe*. Under SGD at batch 256 with output-BN on the projector and an undecayed bottleneck predictor, the same deletion gives **68.1** ([[wiki/entities/simsiam.md]], [[wiki/empirical-tensions.md]] T308), so this row establishes the EMA's necessity for BYOL-as-configured, not for the mechanism |
| BYOL minus predictor (= unsupervised Mean Teacher) | **0.2–0.3** | Collapse. EMA target by itself does not prevent it either |
| **Barlow Twins' 8192-wide projector + 8192-d embedding** (Zbontar et al. 2021) | 74.1 → **72.3** | The width a dimension-contrastive loss keeps profiting from is *harmful* here — BYOL's embedding width saturates and then costs |
| Add SimCLR's negatives to BYOL (`β = 1`, temperature untuned) | 70.9 | Negatives *hurt* here; recoverable by retuning the temperature |
| SimCLR + target network (same negative count) | 69.4 → **71.0** | The EMA target helps by stabilisation alone, not by supplying more negatives as in MoCo |
| SimCLR + predictor | ≈ unchanged | The predictor is not a capacity fix |
| No target network, **optimal linear predictor** (closed-form regression on the batch each step) | **52.5** | The target network is substitutable |
| No target network, predictor LR raised | **66.5** | — same, and better |
| No target network, projector **and** predictor LR raised | ≈25 | The near-optimality must be the predictor's *relative* to the projector |

**Both stabilisers are necessary here, and they are necessary for one reason** — but "here" is doing work: SimSiam deletes the EMA outright and trains to 68.1% ([[wiki/entities/simsiam.md]]), so the necessity is a property of this configuration and the stop-gradient is the component neither system survives without (T308).

**The one reason.** The last three rows say the EMA target's role is to keep the predictor near-optimal — a slowly-moving target is a regression problem the predictor can stay solved for. Make the predictor optimal by other means and the EMA becomes unnecessary. So BYOL's two components are not two anti-collapse mechanisms but one, implemented twice. **The "one mechanism" survives; "near-optimal" does not** — the next section derives the substitution from the learning dynamics and shows that a predictor set to the *exact* least-squares optimum every step scores 40.67 against 74.51 for a gradient-trained one, so what the EMA supplies is a rate ratio and a curriculum, not proximity to a closed-form solution (Tian et al. 2021, [[wiki/empirical-tensions.md]] T305).

**Why collapse is unstable (the paper's hypothesis, not a proof).** With an optimal predictor `q⋆(z_θ) = E[z′_ξ | z_θ]`, the online update follows in expectation the gradient of the **expected conditional variance** `Σ_i Var(z′_{ξ,i} | z_θ)`. Since `Var(X|Y,Z) ≤ Var(X|Y)` for any `Z`, *discarding* information from the online projection can never lower the objective — a constant `z_θ` is the worst possible conditioner. The EMA then copies whatever new variability the online branch has acquired into the target, so the target's information content ratchets up rather than being minimised. Minimising the same quantity with respect to `ξ` would collapse; BYOL does not do that, and that is exactly why:

> **BYOL's target update is not in the direction of `−∇_ξ L`. The authors hypothesise that there is no loss `L_{θ,ξ}` whose joint gradient descent is BYOL's dynamics** — the stated analogy is a GAN, where no scalar is jointly minimised by both players.

---

## The dynamics, solved

> Tian, Chen & Ganguli 2021, *Understanding Self-Supervised Learning Dynamics without Contrastive Pairs* (`raw/tian-2021-ssl-dynamics-without-contrastive-pairs.md`), FAIR + Stanford. The theory paper for this page: the ablation table above is *derived* rather than reported, and one of its readings is overturned.

**Setting.** Bias-free two-layer linear model — online `W`, predictor `W_p`, target `W_a` — under `J = ½E‖W_p f_1 − sg(f_{2a})‖²`. SimSiam is the same system with `W_a = W` and Eqn. 3 deleted; the stop-gradient stays. In the large-batch, small-step limit the gradient flow is

```
Ẇ_p = α_p(−W_p W(X + X′) + W_a X)Wᵀ − ηW_p          (1)
Ẇ   = W_pᵀ(−W_p W(X + X′) + W_a X)      − ηW        (2)
Ẇ_a = β(−W_a + W)                                    (3)
```

with `X := E[x̄x̄ᵀ]` the covariance of the *augmentation-averaged* datapoint and `X′ := E_x[V_{x′|x}[x′]]` the data-averaged augmentation covariance — so **the augmentation distribution enters the dynamics as exactly two matrices**, a signal term and a noise term, and nothing else about it matters at this order.

### Three theorems

| | Statement | What it settles |
|---|---|---|
| **T1 — balancing** | `W(t)Wᵀ(t) = α_p⁻¹W_pᵀ(t)W_p(t) + e^{−2ηt}C`, `C` fixed by initialisation, holding for BYOL *and* SimSiam independent of `W_a`'s dynamics | The predictor cannot absorb the matching on its own and leave `W` useless: whatever `W_p` learns, `W` learns. Weight decay erases `C`, i.e. **`η > 0` is what makes the trained system independent of its initialisation** — and the measured cost of `η = 0` is 74.51 → 70.6–71.4 (STL-10, 100 ep) |
| **T2 — stop-gradient** | Remove the stop-gradient at `W_a = W` and the flow becomes `d/dt vec(W) = −H(t)vec(W)` with `H` positive semi-definite; if `inf_t λ_min(H) ≥ λ_0 > 0` then `W(t) → 0` | The 0.3% row above is a **proof**, not an observation, in this setting. Same reduction with no predictor (`W_p = I`). Collapse under symmetric updates is a linear contraction, not a bad basin |
| **T3 — eigenspace alignment** | `d/dt[F, W_p] = −[F, W_p]K − K[F, W_p]` where `F := WXWᵀ` is the predictor's own input correlation and `K = (1+σ²)[½α_p F + W_p² − τW_p/(1+σ²)] + (3/2)ηI`; if `λ_min(K) ≥ λ_0 > 0` then `‖[F, W_p]‖_F ≤ e^{−2λ_0 t}‖[F(0), W_p(0)]‖_F` | The predictor's eigenbasis **converges to the eigenbasis of its own input covariance** — verified in ResNet-18/STL-10 BYOL, where `W_p` also drifts towards symmetry and positive-definiteness on its own. This is the condition every hyperparameter below is competing to satisfy |

### The per-mode reduction, and why collapse is not all-or-nothing

Once `W_p` and `F` share an eigenbasis `U`, with `W_p = U diag[p_j] Uᵀ` and `F = U diag[s_j] Uᵀ`, the whole system decouples into one 3-D nonlinear ODE **per eigenmode** (2-D for SimSiam, where `τ ≡ 1`):

```
ṗ_j   = α_p s_j[τ − (1+σ²)p_j] − ηp_j
ṡ_j   = 2p_j s_j[τ − (1+σ²)p_j] − 2ηs_j
s_j τ̇ = β(1−τ)s_j − τṡ_j/2
```

with an exact integral `s_j(t) = α_p⁻¹p_j²(t) + e^{−2ηt}c_j` — the **invariant parabola**. Weight decay is what makes `c_j → 0`, after which `s_j = p_j²/α_p` exactly and the reduced flow is `ṗ_j = p_j²[τ − (1+σ²)p_j] − ηp_j`, with fixed points

```
p*_{j0} = 0   (stable iff η > 0),   p*_{j±} = [τ ± √(τ² − 4η(1+σ²))] / 2(1+σ²)
```

`p*_{j+}` is the useful non-collapsed state, `p*_{j−}` is the **basin boundary**. Three consequences the wiki's collapse taxonomy did not have:

- **Collapse is per-mode.** Each eigendirection independently either escapes to `p*_{j+}` or falls into 0. A run is not collapsed or healthy; it retains some number of modes, which is dimensional collapse arriving from the dynamics rather than from the loss ([[wiki/concepts/representational-collapse.md]]).
- **The non-collapsed fixed point prices the augmentation.** `p*_{j+} → τ/(1+σ²)` as `η → 0`: **larger augmentation variance `σ²` gives a smaller representation magnitude**, which is what modelling invariance is supposed to mean, and the invariant parabola transfers that property to `s_j`.
- **Collapse-avoidance is an initial-condition question.** At `η = 0` the sufficient criterion is `s_j(0) > p_j²(0)/α_p` — lie above the parabola. So *the same architecture and the same loss collapse or do not depending on where they start*, and `α_p` (the predictor's relative learning rate) directly enlarges the escaping region.

### What each hyperparameter is actually doing

Both `Δ_j := p_j[τ − (1+σ²)p_j] − η > 0` (growth) and `Δ_j < ½[α_p(1+σ²)s_j + η]` (T3's alignment stays stable) must hold. Every knob is a move on this pair.

| Knob | Positive | Negative |
|---|---|---|
| **Predictor relative LR `α_p`** | shrinks the collapsed region at `η = 0`; loosens the alignment upper bound | large `α_p` drives `p_j` past the target so the pair cannot be held simultaneously |
| **Weight decay `η`** | erases initialisation memory (T1), lifts `λ_min(K)` so alignment can happen, loosens the upper bound | raises `p*_{j−}` — the **collapse basin grows with weight decay** — and for `η > τ²/4(1+σ²)` only the collapsed fixed point remains |
| **EMA rate `β`** | an **automatic curriculum**: early on `W` moves fast so `τ` is small, setting a low goal `τ/(1+σ²)` for `p_j` that a small positive `Δ_j` reaches without breaking the upper bound; as `s_j` stabilises `τ` rises and the goal is raised, ratcheting `p_j` and `s_j` up while alignment is preserved | slow `β` is slow training; small `τ` raises `p*_{j−}`, so more modes are trapped in the collapsed basin |

**This is where the wiki's "the two stabilisers are one mechanism" claim gets its derivation and its correction.** The EMA is substitutable — but by the *rate ratio*, not by optimality. The theory predicts two substitutes and both were then measured: `α_p > 1` makes a symmetric predictor work with no EMA at all (STL-10, CIFAR-10), and so does putting weight decay on the predictor only (`η̄_p = 4e−4`, `η̄_s = 0`), which slows `p_j` relative to `s_j` and restores T3's condition without any target network.

### The predictor's asymmetry is load-bearing, and it is not a capacity argument

| Predictor | With EMA | Without EMA |
|---|---|---|
| symmetric `W_p`, 1 linear layer | **75.09** ± 0.48 | **36.62** ± 1.85 |
| unconstrained `W_p`, 1 linear layer | 74.51 ± 0.47 | 72.85 ± 0.16 |
| symmetric, 2-layer BN+ReLU | 71.58 ± 6.46 | 35.59 ± 2.10 |
| unconstrained, 2-layer BN+ReLU | **78.85** ± 0.25 | 65.98 ± 0.71 |

STL-10, 100 epochs. On ImageNet the same contrast is total: a symmetric linear predictor in SimSiam (no EMA) scores **0.1% top-1 — chance** — against 68.1% unconstrained. Yet symmetry *helps* whenever an EMA is present, and unconstrained `W_p` drifts towards symmetry during training anyway. So the skew-symmetric part of `W_p` is not extra capacity being used; it is a **substitute for the EMA's curriculum**, doing the same job of keeping the alignment condition satisfiable early, and it is redundant once the EMA supplies it. The wiki's `q_θ`-as-amortiser reading covers the symmetric part only ([[wiki/concepts/amortized-inference.md]]).

### DirectPred: the predictor with no gradients

T3 says `W_p` ends in `F`'s eigenbasis; the invariant parabola says `p_j ∝ √s_j`. Skip the optimisation and write the answer down:

```
F̂ ← ρF̂ + (1−ρ)E_B[f fᵀ]        (no zero-centring — centring hurts)
F̂ = Û diag[s_j] Ûᵀ,   p_j = √s_j + ε·max_j s_j,   W_p = Û diag[p_j] Ûᵀ
```

| Setting | Top-1 |
|---|---|
| STL-10 100 ep, gradient-trained linear `W_p` (baseline) | 74.51 |
| STL-10 100 ep, DirectPred `ε = 0` / with `ε = 0.1` | 76.77 / **77.38** |
| STL-10 100 ep, DirectPred with gradient steps interleaved (`freq > 1`) | **80.28** |
| STL-10 100 ep, DirectPred with 6 random input partitions (a feature-dependent `F̂`) | 78.20 ± 0.16 (2-layer predictor: 78.85) |
| ImageNet 300 ep, BYOL 2-layer predictor / linear predictor / **DirectPred** | 72.5 · 90.8 / 69.9 · 89.6 / **72.4 · 91.0** |

**The 256×256 predictor matrix in a ResNet-50 BYOL run can be replaced by an eigendecomposition of a running second-moment estimate with no loss.** Two readings worth keeping: the `ε` term is a floor on small eigenvalues, and setting `p_j = √max(s_j − c_j, 0)` with `c_j > 0` is catastrophic — it zeroes small modes into the collapsed basin, the per-mode picture confirmed by construction. And the partition experiment says what a 2-layer predictor buys: a **feature-dependent** `F̂`, i.e. a different local second moment per region of input space, recovering most of the 1-layer/2-layer gap without nonlinearity.

**The optimality conjecture is false.** BYOL and SimSiam both argued the predictor should be kept *optimal* — minimal `ℓ₂` error predicting the target from the online output. Solve that regression exactly and plug it in every minibatch and STL-10 gives **40.67 ± 0.50** (39.45 without EMA) against 74–75 for gradient descent; plugging in every 5 minibatches is worse still (35.63). DirectPred is *not* the optimal predictor — `√s_j` is the invariant-parabola value, not the least-squares solution — and interleaving gradient steps beats setting it every step. The quantity that matters is the predictor's **rate** relative to the online network, not its distance from the closed-form optimum ([[wiki/empirical-tensions.md]] T305).

## The claim worth extracting: an anti-collapse mechanism that is not a term

The wiki's collapse taxonomy ([[wiki/concepts/energy-based-models.md]], gap **G34**) has carried three families, all of them *terms in an objective*: sample-contrastive (negatives), dimension-contrastive ([[wiki/entities/vicreg.md]]/Barlow Twins variance + covariance), distribution-matching (SIGReg, [[wiki/entities/lewm.md]]). BYOL is a fourth kind and not a fourth member: **the anti-collapse provision is a property of the update rule, not of the loss.** The loss at every step is a plain regression that a constant encoder minimises perfectly; the dynamics never go there.

**What it is doing, measured against the terms it replaces** (Bardes et al. 2022, [[wiki/entities/vicreg.md]]). Two statistics, tracked through BYOL and SimSiam pretraining: the embeddings' per-dimension standard deviation sits *exactly* at `1/√d` — perfectly spread on the unit sphere, so no norm collapse — while the average off-diagonal correlation coefficient of the **representations** falls on its own, with no decorrelation term anywhere in the loss. The dynamical mechanism therefore drives the same two quantities the dimension-contrastive terms impose explicitly. What it does *not* fully arrest is the representation-level variance: bolting VICReg's variance hinge onto BYOL raises it and buys **+0.9** at 100 epochs (69.3 → 70.2), decaying to +0.2 at 1000, i.e. faster convergence plus a residual "very slow collapse" the architectural tricks leave on the table. The two kinds are not rival objectives; they are two implementations of one target, which is why the graft is worth ≈1 point rather than 10 ([[wiki/empirical-tensions.md]] T166).

| | Contrastive | Dimension-contrastive | Distribution-matching | **BYOL (dynamical)** |
|---|---|---|---|---|
| Where the provision lives | loss | loss | loss | **update rule** |
| Cost model | negatives may grow exponentially in `dim(y)` | representation width | one coefficient + a dimensionality prior | **none in the loss; ~2× compute for the second branch** |
| Coefficients to tune | temperature | 1 free scale (VICReg: `λ=μ`, `ν=1`; the *6* the wiki quoted is PLDM's seven-term objective) | 1 (`λ`) | **0** (but `τ` and the predictor's LR ratio move in) |
| Certifiable | yes — the objective's minimum is not collapsed | yes | yes | **no — no objective exists to certify** |
| Fails when | batch too small; noise distribution misses the relevant perturbation | width too small | environment's intrinsic dimension < target's | predictor falls behind the target (`τ = 0`), or is removed |

The trade in the last two rows is the point. BYOL buys the cheapest anti-collapse mechanism anyone has found and pays for it by leaving the field with a system whose behaviour is a fact about SGD rather than a fact about an objective — which is the strongest form of the non-identifiability on [[wiki/concepts/objective-identifiability.md]]: not *which* loss produced this representation, but *whether there is one*.

---

## Limitations

- **The augmentation set is the prior, and it is hand-designed.** The paper's own stated blocker for other modalities: BYOL generalises to audio/video/text only if someone supplies comparable augmentations. In [[wiki/concepts/divergence-objectives.md]]'s rate–distortion split, the augmentation *is* `f(X)` and therefore fixes the rate — what BYOL is allowed to keep is decided before its loss is evaluated.
- **No mechanism for one-to-many.** The target is a single vector and the loss is squared error onto it. There is no latent `z` and no way to represent alternative continuations — the property [[wiki/concepts/energy-based-models.md]] treats as the reason to refuse to predict.
- **Collapse-avoidance is empirical *here*, and analytic one model down.** The conditional-variance argument assumes an optimal predictor and no symmetrisation or normalisation; undesirable equilibria are admitted to exist and merely not observed. Tian et al. 2021 replaces the argument with a solved flow in a bias-free two-layer *linear* network — which locates the undesirable equilibria exactly (`p_j < p*_{j−}`, per eigenmode) rather than removing them, and leaves the nonlinear, ℓ₂-normalised, BatchNorm-containing system that is actually trained untouched.
- **BatchNorm sits in the loop.** The paper attributes its only batch-size dependence to BN in the encoder without asking what BN contributes to collapse-avoidance — an implicit batch statistic in a method advertised as negative-free.
- **Evaluated only as a frozen feature extractor.** Every number is linear eval, fine-tuning or transfer. Nothing here tests prediction, planning, or any use of the *predictor*, which is discarded.

---

## Comparison

| | **BYOL** | SimCLR | MoCo | Mean Teacher | [[wiki/entities/vicreg.md]] / [[wiki/entities/barlow-twins.md]] | [[wiki/entities/lewm.md]] | [[wiki/entities/v-jepa-2.md]] |
|---|---|---|---|---|---|---|---|
| Negatives | no | yes (in-batch) | yes (memory bank) | no | no | no | no |
| EMA target | yes | no | yes (for negatives) | yes | no | **no** | yes (`0.99925`) |
| Predictor on one branch | **yes** | no | no | **no → collapses** | no — adding predictor **and** stop-grad costs BT 10 points, VICReg 0 | yes (the world-model predictor) | yes |
| Anti-collapse | dynamics | negatives | negatives | supervised loss | variance + covariance terms; BT: cross-correlation → `I` | SIGReg | EMA + stop-grad (BYOL's) |
| Descends a well-defined loss | **no** | yes | yes | yes | yes | yes | no |
| Predicts across | two views of one image | — | — | — | two views | **time**, action-conditioned | **time**, masked patches |

**The nearest neighbour is missing from this table because it is this page minus one column.** [[wiki/entities/simsiam.md]] is BYOL with the EMA target deleted and the weights shared — same predictor, same stop-gradient, same loss shape — at 68.1 / 71.3 (100 / 800 epochs) against 66.5 / 74.3 here. It wins the short-budget column and loses the long one, which is the cleanest available statement of what the momentum encoder actually buys: not collapse prevention but a target smooth enough to keep improving for 800 epochs.

The right-hand columns are the reason this 2020 paper is in the wiki: the JEPA lineage's target-encoder-plus-stop-gradient is BYOL's mechanism transplanted from view-prediction to time-prediction, and it arrived with a caveat — *no objective corresponds to it* — that the lineage inherited silently and that LeWM's whole subtraction is aimed at.

---

## Connections

- **[[wiki/entities/simsiam.md]]** — this page minus the momentum encoder, and the reason the `τ = 0` ablation row is now a recipe-dependent result rather than a fact about the mechanism (T308); it also supplies the candidate objective this page says does not exist — an alternating minimisation over a per-image variable `η` in which the stop-gradient is a consequence rather than a device.
- **[[wiki/entities/vl-jepa.md]]** — this page's *rate ratio between two networks* as a literal scalar with an interior optimum: with a genuinely separate target network in another modality, a learning-rate multiplier on the target branch is swept and both endpoints lose (full speed −3.6, frozen −7.3, best at 0.05–0.10), so the lineage's two shipped settings are the two ends of a continuum.
- **[[wiki/concepts/energy-based-models.md]]** — supplies the fourth anti-collapse family for that page's contrastive/regularised split, and the one that breaks its framing: the provision is in the update rule rather than the loss, so a joint-embedding architecture can avoid the collapse its energy landscape permits without any term that pushes energy up anywhere.
- **[[wiki/concepts/objective-identifiability.md]]** — the limit case of that page's many-to-one direction: BYOL's authors hypothesise *no* loss is jointly descended, so the representation cannot be attributed to an objective at all, only to a dynamics — and the solved flow makes that concrete, since the trained `W_p` is fixed by `F`'s eigenspectrum and the initial condition decides which modes survive, both of which are properties of the trajectory and of neither the architecture nor the loss.
- **[[wiki/entities/h-jepa.md]]** — the design whose four training criteria this refutes as necessary conditions: BYOL implements criterion 3 (predictability) alone, omits 1, 2 and 4 (information maximisation and latent capacity limits), and does not collapse.
- **[[wiki/entities/vicreg.md]]** — the measurement of what this page's update rule accomplishes: BYOL's embeddings already sit at `1/√d` on the sphere and its representations decorrelate with no term asking them to, so the dynamical and dimension-contrastive mechanisms target the same two statistics — and grafting VICReg's variance hinge on is worth only +0.9, the size of the residual slow collapse.
- **[[wiki/entities/barlow-twins.md]]** — the symmetric alternative and the mutual control: its cross-correlation-to-identity loss needs neither of this page's components, and bolting them on costs it 10 points, while its 8192-wide projector costs BYOL 1.8 — so the two designs' stabilisers are competing rather than stackable, and its negative-free augmentation fragility undercuts this page's shortcut reading (T165).
- **[[wiki/entities/lewm.md]]** — the direct answer: the EMA teacher and stop-gradient LeWM removes are exactly this page's two components, and its objection — that they correspond to no well-defined objective — is this paper's own admission, restated as a reason to replace them.
- **[[wiki/entities/v-jepa-2.md]]** — inherits the mechanism at scale: masked feature prediction with an EMA teacher at `τ = 0.99925` is BYOL's asymmetry with the second view replaced by a future frame.
- **[[wiki/concepts/amortized-inference.md]]** — the predictor is an amortised regression whose *staleness* is the design variable: a closed-form optimal linear predictor (52.5%) or a faster-learning one (66.5%) substitutes for the EMA target entirely, so this is a case where how well the amortiser tracks its exact solution decides whether the whole system learns anything — with the sign of that dependence inverted by Tian et al. 2021, where the exact optimum plugged in every step gives 40.67 and a rule ignoring least squares altogether (`p_j = √s_j`) gives 77.38.
- **[[wiki/concepts/shortcut-learning.md]]** — the crop-only ablation isolates the mechanism by which negatives *create* a shortcut: a discrimination between crops is solvable by colour histogram, so the contrastive objective terminates there, while a regression onto a richer target keeps paying for extra features (59.4% vs 40.3%).
- **[[wiki/concepts/divergence-objectives.md]]** — a clean instance of the rate–distortion split: BYOL and SimCLR differ only in the distortion term, and the augmentation set they share fixes the rate — which is why removing colour jitter costs both of them, and why the paper's stated blocker for other modalities is an `f(X)` question, not a loss question.
- **[[wiki/concepts/representation-probing.md]]** — qualifies the random-initialisation null: an untrained network scores 1.4% as a classifier but supports 18.8% when used as a *prediction target*, so "random network" is a floor for read-out and not a statement that its activations are structureless.
- **[[wiki/concepts/violation-of-expectation.md]]** — the same qualification where the wiki relies on it hardest: the `n = 20` untrained-network null is a chance level for a behavioural score, and this result shows the same networks carry enough structure to teach a downstream encoder.
- **[[wiki/entities/dinov2.md]]** — the same EMA-teacher skeleton at foundation scale with the asymmetry relocated: no predictor anywhere, collapse held off by normalising the *teacher's output distribution* (running-mean centering, or Sinkhorn–Knopp equipartition over 128k prototypes), which shows this page's predictor is one implementation of the asymmetry rather than the asymmetry itself.
- **[[wiki/entities/i-jepa.md]]** — this page's mechanism with the pair source swapped: predictor on one branch, EMA on the other, zero anti-collapse coefficients, but the two views are two *blocks of one image* rather than two augmentations of it — which removes the colour-histogram shortcut the crop-only ablation exposed and replaces it with a texture-continuation one authored by the mask sampler.
- **[[wiki/entities/lejepa.md]]** — where this page's two necessary components become optional: with the embedding distribution constrained directly to `N(0, I)`, the predictor is deletable at no cost (83.93 without vs 83.57 with, ResNet-50) and the EMA survives only as evaluation-time weight averaging worth ~3 points on ViTs and 0 on ResNets — so what is load-bearing here is load-bearing *relative to an unconstrained loss*, not intrinsically (T164).
- **[[wiki/concepts/representational-collapse.md]]** — locus 4 of six, and the one that removes the recipe's necessity: an asymmetry in the update rule rather than a term in the loss, with the two stabilisers shown to be one mechanism — and the locus whose failure mode the solved dynamics types, since `p*_{j−}` is a basin boundary each eigenmode crosses or does not, making *partial* collapse the generic outcome of a dynamical provision rather than a separate phenomenon.
- **[[wiki/concepts/manifold-untangling.md]]** — the same substitution seen from biology: the pairing rule is doing the work, and the biological version replaces the designer's augmentation distribution with the temporal statistics of the input, which an agent could observe for itself (gap `G95`).
- **[[wiki/entities/mae.md]]** — the measured other end of this page's augmentation dependence: crop-only costs this system 13 points and SimCLR 28, while a masked auto-encoder loses 7.8 linear and 0.9 fine-tuned with augmentation removed *entirely*, because a fresh random mask per iteration is already a fresh example — so the augmentation list is load-bearing for the joint-embedding pair source specifically, not for self-supervision.
- **[[wiki/entities/directclr.md]]** — the same two augmentation matrices (`X`, `X′`) and the same align-then-reduce-to-singular-values method, applied to the contrastive branch of the family: here they set the non-collapsed fixed point's *magnitude*, there they decide its *rank*.
