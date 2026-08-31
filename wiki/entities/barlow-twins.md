# Barlow Twins

**Two identical networks, no predictor, no stop-gradient, no momentum encoder and no negatives: the cross-correlation matrix between their embeddings on two views of the same batch is pushed toward the identity, so invariance is the diagonal and anti-collapse is the off-diagonal — one loss, one coefficient, and the only place in the wiki where a 1961 neuroscience principle is the objective rather than an analogy.**

> **Provenance.** Zbontar, Jing, Misra, LeCun & Deny 2021, *Barlow Twins: Self-Supervised Learning via Redundancy Reduction*, ICML (`raw/zbontar-2021-barlow-twins.md`). Named for H. Barlow's *redundancy-reduction* hypothesis (Barlow 1961): sensory processing recodes redundant input into a **factorial code** with statistically independent components. Code and checkpoints released.

---

## The objective

```
L_BT  =  Σ_i (1 − C_ii)²        ← invariance term (diagonal → 1)
       + λ Σ_i Σ_{j≠i} C_ij²    ← redundancy-reduction term (off-diagonal → 0)

C_ij  =  Σ_b z^A_{b,i} z^B_{b,j}  /  sqrt( Σ_b (z^A_{b,i})² · Σ_b (z^B_{b,j})² )
```

`b` indexes the batch, `i,j` index embedding dimensions. `C` is `D×D` (embedding width, **not** batch size), entries in `[−1, 1]`. Note the normalisation axis: embeddings are standardised **along the batch dimension**, where InfoNCE-family losses normalise along the *feature* dimension to get a cosine similarity.

| Component | Spec |
|---|---|
| **Twins** | One `f_θ`, weights shared, **fully symmetric** — same function, same update, gradients through both branches |
| Encoder | ResNet-50, 2048-d *representation* (kept for downstream use) |
| Projector | 3 linear layers × **8192** units, BN+ReLU after the first two; its output is the *embedding* fed to `L_BT`. Discarded after training |
| Augmentations | BYOL's set verbatim (crop, resize 224², flip, colour jitter, grayscale, blur, solarisation) |
| Optimisation | LARS, 1000 epochs, batch 2048 (works at 256), lr 0.2 / 0.0048 (biases+BN), 10-epoch warmup, cosine decay ÷1000, weight decay `1.5e−6`, `λ = 5e−3`. 32 V100 × 124 h (their BYOL reimplementation: 113 h) |

**Why it cannot collapse, stated as a fact about the matrix rather than about the dynamics:** a constant encoder gives an undefined/degenerate `C` after batch standardisation, and any rank-deficient embedding puts mass on off-diagonal entries. The minimum of `L_BT` is `C = I`, which *is* a full-rank decorrelated embedding. Nothing about the optimiser is invoked ([[wiki/empirical-tensions.md]] T164 position A, in its cleanest form).

**Information-bottleneck reading** (the paper's Appendix A): find `Z` maximally informative about the sample and minimally informative about the distortion applied; `λ` **is** the IB trade-off parameter. InfoNCE has no such parameter, only a temperature.

---

## Results (ResNet-50 throughout)

| Protocol | Barlow Twins | BYOL | SimCLR | SwAV | Supervised |
|---|---|---|---|---|---|
| ImageNet linear eval, top-1 / top-5 | 73.2 / 91.0 | **74.3** / 91.6 | 69.3 / 89.0 | **75.3** | 76.5 |
| Semi-supervised 1% labels, top-1 / top-5 | **55.0 / 79.2** | 53.2 / 78.4 | 48.3 / 75.5 | 53.9 / 78.5 | 25.4 / 48.4 |
| Semi-supervised 10% labels, top-1 | 69.7 | 68.8 | 65.6 | **70.2** | 56.4 |
| Places-205 / VOC07 / iNat18 (linear, fixed features) | 54.1 / 86.2 / 46.5 | 54.0 / 86.6 / 47.6 | 52.5 / 85.5 / 37.2 | **56.7 / 88.9 / 48.6** | 53.2 / 87.5 / 46.7 |
| VOC07+12 detection AP_all / COCO det AP^bb / COCO seg AP^mk | 56.8 / 39.2 / 34.3 | — | — | 56.1 / 38.4 / 33.8 | 53.5 / 38.2 / 33.3 |

Competitive rather than dominant on linear eval; **best in the wiki's most label-scarce cell** (1% ImageNet). The transfer and detection numbers are within noise of the best method on each row.

---

## The ablations that carry the architectural content

300-epoch baseline: **71.4 / 90.2**.

### Loss-term ablations — and one result the wiki's collapse taxonomy does not predict

| Loss variant | Top-1 | What it establishes |
|---|---|---|
| Baseline | 71.4 | — |
| **Invariance term only** (no off-diagonal penalty) | **57.3** | *Does not collapse.* An objective whose only term is "make the two views agree" still reaches 57.3% — because the embeddings are standardised along the batch before `C` is formed, and a constant unit has zero batch variance. **The anti-collapse provision is partly in the normalisation, not in the term the paper advertises**. **Identified across papers** ([[wiki/entities/vicreg.md]]): VICReg strips all standardisation and its invariance-only ablation *does* collapse; restoring an explicit per-dimension variance hinge recovers **57.5**, the same number to 0.2 points. So this row's hidden provision is VICReg's `v` term implemented implicitly |
| **Redundancy term only** (no invariance) | **0.1** | Decorrelation alone is worthless — chance. The off-diagonal term is a *constraint*, never a signal |
| Normalise along feature dim instead (covariance, cosine-style) | 69.8 | Slight loss; the axis choice is real but not decisive |
| No BN in projector hidden layers | 71.2 | Inert |
| No BN **and** no batch standardisation (cross-**covariance**) | 53.4 | −18 points. Confirms the row above: removing the batch-wise standardisation is what actually costs |
| Cross-entropy with temperature over the same `C` | 63.3 | Same quantity penalised, different functional form, −8 points. **What is penalised does not determine performance; how it is penalised does** |

The 57.3% row is the one worth carrying: the wiki has been classifying anti-collapse provisions as *loss term* ([[wiki/entities/vicreg.md]], SIGReg), *update rule* ([[wiki/entities/byol.md]]) or *negatives*. This is a fourth locus — **a normalisation layer inside the loss** — which is certifiable like a term but appears nowhere in the coefficient count. It is a *locus*, not a distinct mechanism: the VICReg identification above shows the same provision written as a term costs one coefficient and buys the freedom to weight it per branch.

### Symmetry-breaking: BYOL's mechanism, added on top, *hurts*

| Configuration | stop-grad | predictor | Top-1 |
|---|---|---|---|
| Baseline (symmetric) | — | — | **71.4** |
| (a) | ✓ | — | 70.5 |
| (b) | — | ✓ | 70.2 |
| (c) | ✓ | ✓ | **61.3** |

Row (c) is a 10-point loss from adding exactly the two components BYOL cannot run without. The two anti-collapse strategies are **not** composable *here*: an update-rule asymmetry inside a system that already has a well-defined minimum moves the dynamics away from it. The converse control is also run — BYOL with a Barlow-Twins-sized projector (8192³) and an 8192-d embedding drops from 74.1 to **72.3**, so the width that Barlow Twins needs is not a general SSL improvement.

**The generalisation does not survive the sibling method** ([[wiki/entities/vicreg.md]], tension **T166**). VICReg takes a predictor and stop-gradient *neutrally* (73.2 → 73.2 at 1000 epochs) and its variance term added to BYOL *helps* by +0.9. The one component VICReg removed relative to Barlow Twins is precisely the batch standardisation, which makes it the surviving candidate for what conflicts with a stop-gradient **(brainstorm)**: a normalisation computed across the batch inside the loss is a second implicit coupling between the branches, and an EMA/stop-gradient is a third. Rows (a)–(c) above are then a three-way interaction, not a two-family incompatibility — and the covariance term is the piece that does *not* compose either way ("optimization with SG and CR is hard").

### Batch size and embedding width — the two scaling facts, and they have one mechanism

| Sweep | Barlow Twins | SimCLR | BYOL |
|---|---|---|---|
| Batch 2048 → 256 | ~flat (best 71.7 at batch 1024) | **−4 pp** | flat |
| Projector output dim 16 → 16384 | **monotone increase throughout**, no saturation | saturates early | saturates early |
| *(VICReg, same mechanism)* | steep to 8192, then **saturates** (+0.2 to 16384) | — | — |
| `λ ∈ [0.002, 0.02]` | 70.8–71.6 | (no analogue) | (no analogue) |

**The mechanism the paper gives, and it explains both rows at once.** InfoNCE's contrastive term is a *non-parametric* entropy estimator of the embedding distribution (Wang & Isola 2020) — non-parametric estimators need many samples and degrade with dimension, so InfoNCE needs a big batch and gains nothing from a wide embedding. `L_BT` is a **proxy entropy estimator under a Gaussian parametrisation**: it only estimates second moments, which are cheap in samples and well-behaved in dimension. Hence small batches suffice and width keeps paying.

**The width result is stranger than it looks.** The encoder output is fixed at 2048-d, so the intrinsic dimensionality of the deployed representation is capped *below* the embedding width the loss keeps rewarding — at 16384 the projector is expanding 8×. The extra dimensions are not carrying representational capacity; they are **supplying more decorrelation constraints on the same 2048-d code**. **(brainstorm)** That is a different reading of "dimension" from every other one in the wiki: [[wiki/concepts/retrieval-capacity.md]] counts dimensions as addressable questions and [[wiki/concepts/sparse-distributed-representations.md]] counts them as interference-free overlap, while here dimension is a property of the *estimator*, paid at training time and thrown away. It predicts that the gain should saturate once the constraint count exceeds what the 2048-d code can violate — a curve nobody has run, and the paper's own stated blocker is memory, not principle.

---

## What the paper concedes

- **Augmentation-fragile.** Progressively removing augmentations degrades Barlow Twins like SimCLR (≈−25 points at crop-only, read from Fig. 3) and unlike BYOL (−13.1). The authors' framing is a defence: the representation is *"better controlled by the specific set of distortions used"*, where BYOL's invariances are "generic and intriguingly independent" of them. This contradicts the wiki's current mechanism for that ablation — see [[wiki/empirical-tensions.md]] T165.
- **The twin may be unnecessary for the anti-collapse half.** Preliminary and unshown: computing the off-diagonal penalty from the **auto**-correlation of a single network's embedding performs similarly. If that holds, redundancy reduction needs no second view at all and only the invariance term does — which would split the objective across two architectures.
- **IMAX (Becker & Hinton 1992) is the ancestor and does not scale.** `L = log |C(Z^A − Z^B)| / |C(Z^A + Z^B)|` is an actual information quantity under a Gaussian-noise assumption and has the same two-term shape; the authors' attempts to make it work on ImageNet **failed**. So the retreat from an information quantity to a proxy with a free `λ` is what bought the scale.
- **Hard whitening is the same idea and loses.** W-MSE (Ermolov et al. 2020) whitens each batch exactly by Cholesky decomposition, then takes a cosine similarity: 66.3% top-1. The soft constraint beats the hard one by ~7 points.
- Evaluated only as a frozen (or fine-tuned) feature extractor. No prediction, no planning, no temporal structure — this is a *view*-predictive method, not a world model.

---

## Comparison

| | **Barlow Twins** | [[wiki/entities/byol.md]] | SimCLR | [[wiki/entities/vicreg.md]] | [[wiki/entities/lewm.md]] |
|---|---|---|---|---|---|
| Anti-collapse lives in | **loss (off-diagonal) + batch standardisation** | update rule | negatives | loss (variance hinge + covariance) | loss (SIGReg normality test) |
| Branch asymmetry | **none** (adding it costs 10 pts) | predictor + EMA (both required) | none | none | none |
| Negatives / batch dependence | none; flat to 256 | none | **yes**, −4 pp at 256 | none | none |
| Coefficients | **1** (`λ`, flat over a 10× range) | 0 in the loss (`τ`, LR ratio instead) | 1 (temperature) | 1 free scale (`λ=μ`, `ν=1`) — with a collapse boundary | 1 |
| Contrastive over | **dimensions** | — | samples | dimensions | marginals |
| What it assumes about the embedding | second moments suffice (Gaussian proxy) | nothing explicit | a good noise distribution | per-dimension variance floor | full isotropic `N(0,I)` |
| Descends a well-defined loss | **yes** | **no** | yes | yes | yes |
| Gains from embedding width | **monotone to 16384** | saturates (and 8192 *hurts*) | saturates | mild | fixed by the target's dimension |

The last two rows are the pair to keep. Barlow Twins and LeWM sit at the same coefficient count from opposite ends: **estimate only the second moments and let the width grow** vs. **specify the whole target distribution and pay a dimensionality prior**. LeWM's failure mode (an environment whose intrinsic dimension is below the target's) has no Barlow Twins analogue, because decorrelating an over-wide embedding of a low-dimensional world is satisfiable — the off-diagonal term asks for independence, not for occupancy.

---

## Connections

- **[[wiki/concepts/energy-based-models.md]]** — the founding instance of that page's *dimension-contrastive* column, previously cited there only by name: the volume-minimising regulariser is here an explicit `D×D` matrix penalty, and its ablations add a locus the page's taxonomy lacks (a normalisation, not a term) plus the finding that dimension-contrastive and dynamical anti-collapse are mutually destructive.
- **[[wiki/concepts/alignment-uniformity.md]]** — the derivation behind this page's estimator argument: the contrastive term is a resubstitution entropy estimator of the embedding marginal under a von Mises–Fisher KDE with bandwidth `κ = 1/τ`, which is the "non-parametric estimator" half of the Gaussian-proxy claim stated as a theorem rather than an analogy.
- **[[wiki/entities/vicreg.md]]** — the sibling that keeps the off-diagonal penalty and replaces everything else: per-branch covariance instead of cross-branch cross-correlation, an explicit variance hinge instead of batch standardisation (the 57.3/57.5 identification), and the resulting freedom for the two branches to differ in weights, architecture and modality — which is worth 2–4 points wherever this page's cross-correlation matrix has to compare unlike statistics.
- **[[wiki/entities/byol.md]]** — the direct control in both directions: BYOL's predictor and stop-gradient added to Barlow Twins cost 10 points, and Barlow Twins' 8192-wide projector added to BYOL costs 1.8 — so neither method's stabiliser is a general improvement, and the two are alternative *whole designs* rather than components.
- **[[wiki/entities/lewm.md]]** — the same one-coefficient target reached four years earlier by a weaker distributional commitment (second moments vs. the full `N(0,I)`), which is why Barlow Twins has no equivalent of LeWM's intrinsic-dimension failure and LeWM has no equivalent of Barlow Twins' unbounded width gain.
- **[[wiki/entities/h-jepa.md]]** — one of the two named non-contrastive instantiations of its four training criteria; this page supplies the measured version, and the invariance-only ablation (57.3%, no collapse) says criteria 1–2 are not the only thing standing between the design and a constant encoder.
- **[[wiki/concepts/divergence-objectives.md]]** — supplies the mechanism behind two scaling laws at once: a contrastive term is a *non-parametric* entropy estimator (sample-hungry, dimension-cursed) while `L_BT` is a Gaussian-parametrised proxy for the same quantity, so the batch-size and embedding-width curves are one statistical fact about estimators, not two engineering results.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the wiki's cleanest case of a neuroscience *principle* transferring as an objective term rather than as an architecture: Barlow's 1961 factorial-code hypothesis becomes `Σ_{i≠j} C_ij²`, with the transfer's cost visible (a decorrelation penalty is worthless alone — 0.1% — and only pays as a constraint on an invariance objective).
- **[[wiki/concepts/retrieval-capacity.md]]** — a third reading of embedding dimension alongside that page's addressability count: here the width that keeps helping is the *projector's*, not the deployed representation's, so dimension is bought as estimator quality at training time and then discarded.
- **[[wiki/concepts/shortcut-learning.md]]** — the counter-case to the wiki's "negatives author the shortcut" mechanism: Barlow Twins has no negatives and degrades under augmentation removal like SimCLR anyway, so augmentation fragility is not a contrastive-specific defect (T165).
- **[[wiki/concepts/objective-identifiability.md]]** — the sharpest datum for the certifiability side: the minimum of `L_BT` is stated as a matrix identity, so an auditor can check what the trained system was for without running it — and the cross-entropy-over-`C` variant (−8 points) shows the *penalty's shape* is a second, unidentified degree of freedom on top of which quantity is penalised.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the opposite prescription over the same variable: decorrelation asks a dense code's components to be statistically independent, where sparsity asks a high-dimensional code's *supports* to be near-disjoint; both are redundancy reduction, and only the second buys the overlap arithmetic that page prices.
- **[[wiki/entities/dinov2.md]]** — the non-parametric counterpart to this page's Gaussian-proxy reading: KoLeo estimates the embedding's differential entropy directly from nearest-neighbour spacing (`−Σ log d_{n,i}`, weight 0.1, no negatives, no cross-GPU communication), and its measured benefit lands entirely on instance retrieval (+8.3 mAP) and not on the linear probe.
- **[[wiki/entities/lejepa.md]]** — the generalisation that explains this page's single flat coefficient: constraining `C → I` is a statement about two moments stated exactly, and SIGReg is the same construction with the whole target distribution pinned by a characteristic-function test — same coefficient count, no non-Gaussian solutions left satisfying it.
- **[[wiki/concepts/representational-collapse.md]]** — locus 2's founding instance and the discovery of locus 5: deleting the off-diagonal term leaves 57.3% rather than collapse, because the batch standardisation that forms the cross-correlation is itself a provision.
- **[[wiki/concepts/manifold-untangling.md]]** — the biological ancestor of this objective, and the difference worth naming: the invariance term is "make two views agree" with the pairing supplied by a hand-written augmentation list, where the ventral stream infers the same nuisance directions from the input stream's own temporal statistics — discovered rather than declared, local, and revisable in hours (gap `G95`).
