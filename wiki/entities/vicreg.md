# VICReg

**Three terms applied to each branch *separately* — a variance hinge, a covariance decorrelation, and a plain squared distance between views — which is the only anti-collapse provision in the wiki that survives the two branches having different weights, different architectures and different input modalities, because nothing in it is computed across the pair.**

> **Provenance.** Bardes, Ponce & LeCun 2022, *VICReg: Variance-Invariance-Covariance Regularization for Self-Supervised Learning*, ICLR (`raw/bardes-2022-vicreg.md`). The wiki has carried "VICReg" by name since the [[wiki/entities/h-jepa.md]] ingest as the named non-contrastive instance of its training criteria; this is the primary source.

---

## The objective

```
ℓ(Z, Z′) = λ·s(Z, Z′)  +  μ·[v(Z) + v(Z′)]  +  ν·[c(Z) + c(Z′)]

s(Z, Z′) = (1/n) Σ_i ‖z_i − z′_i‖²                        ← invariance, no normalisation
v(Z)     = (1/d) Σ_j max(0, γ − S(z^j, ε))                ← variance hinge, per dimension
           S(x, ε) = sqrt(Var(x) + ε),  γ = 1,  ε = 1e−4
c(Z)     = (1/d) Σ_{i≠j} [C(Z)]²_{ij}                      ← covariance, off-diagonal only
           C(Z) = (1/(n−1)) Σ_i (z_i − z̄)(z_i − z̄)ᵀ
```

`n` = batch, `d` = embedding width. `λ = μ = 25`, `ν = 1`.

| Component | Spec |
|---|---|
| Encoder `f_θ` | ResNet-50, 2048-d *representation* — the only part kept |
| **Expander** `h_φ` | 3 FC layers × **8192** (BN+ReLU on the first two, third linear). Discarded after pretraining |
| Branches | Siamese with shared weights *by default only*; the method does not require it (see below) |
| Augmentations | BYOL's set, symmetrised (crop 224², flip, colour jitter, grayscale, blur, solarisation) |
| Optimisation | LARS, 1000 epochs, batch 2048, base lr 0.2, wd `1e−6`, 10-epoch warmup, cosine decay |
| Cost | 11 h / 100 epochs on 32 V100, 11.3 GB peak (BYOL 10 h / **14.6 GB**; SwAV+multi-crop 13 h / 12.9 GB) |

**The two named jobs of the expander**, and the second is the paper's one theoretical contribution beyond the loss: (1) discard the information by which the two representations differ; (2) **expand the dimension non-linearly so that decorrelating the embedding reduces *dependencies*, not merely correlations, at the representation level.** Decorrelation is a second-moment statement and therefore weak; run through a non-linear expansion it becomes a constraint on higher-order statistics of the pre-image — the same move a kernel makes. The paper measures the downstream half (decorrelation at the embedding does decorrelate the representation) and does not measure the independence claim.

---

## Results (ResNet-50, 1000 epochs)

| Protocol | VICReg | [[wiki/entities/barlow-twins.md]] | [[wiki/entities/byol.md]] | SwAV (m-c) | Supervised |
|---|---|---|---|---|---|
| ImageNet linear, top-1 / top-5 | 73.2 / 91.1 | 73.2 / 91.0 | 74.3 / 91.6 | **75.3** | 76.5 |
| Semi-supervised 1%, top-1 / top-5 | 54.8 / **79.4** | **55.0** / 79.2 | 53.2 / 78.4 | 53.9 / 78.5 | 25.4 / 48.4 |
| Semi-supervised 10%, top-1 | 69.5 | 69.7 | 68.8 | **70.2** | 56.4 |
| Places205 / VOC07 / iNat18 (linear) | 54.3 / 86.6 / 47.0 | 54.1 / 86.2 / 46.5 | 54.0 / 86.6 / 47.6 | **56.7 / 88.9 / 48.6** | 53.2 / 87.5 / 46.7 |
| VOC07+12 det / COCO det / COCO seg | 82.4 / 39.4 / 36.4 | 82.6 / 40.0 / 36.7 | 82.5 / 39.8 / 36.1 | **82.6 / 41.6 / 37.8** | 81.3 / 39.0 / 35.4 |
| 20-NN / 200-NN ImageNet | 64.5 / 62.8 | 64.8 / 62.9 | **66.7 / 64.9** | 65.7 / 62.7 | — |

Statistically indistinguishable from Barlow Twins on every image row (max gap 0.5). Seed variance is **< 0.1%** across three initialisations on linear eval. Scaling: N-ResNet-50(×2) 74.7 → N-ResNet-50(×4) 76.0 with the representation pinned at 2048-d, ResNeXt-101 76.1, ResNet-200(×2) **77.3**; widening the *representation* past 4096 does not pay (R50×2 75.5 → R50×4 75.6).

**Where it is not indistinguishable — the two experiments that are the actual reason for the method:**

| Setting | VICReg | Barlow Twins | Baseline |
|---|---|---|---|
| MS-COCO 5K retrieval, image→text R@1 / text→image R@1 (ResNet-152 + word-emb-GRU) | **33.6 / 45.2** | 31.4 / 42.9 | 30.3 / 41.3 (VSE++ *contrastive*) |
| ESC-50 audio, raw 1-D waveform branch ⊕ mel-spectrogram branch, linear top-1 | **78.4** | 75.4 | 72.7 (supervised ResNet-18) |
| ImageNet linear, branches with **different weights** (100 ep) | **66.5** | 64.2 | 63.1 (SimCLR) |
| … **different architectures** R50 / R101 | **68.1** | 65.3 | 63.9 |
| … **different architectures** R50 / ViT-S | **66.2** | 63.9 | 63.5 |
| … shared weights (reference) | 68.6 | 68.7 | 64.4 |

Shared-weight parity, asymmetric-setting separation of 2–4 points. The mechanism is one line: Barlow Twins' matrix is a **cross**-correlation between the two branches, so the two outputs must have comparable statistics for a target of `C = I` to be meaningful; VICReg's `v` and `c` are computed **within** a branch, so each branch can carry its own regularisation coefficient and its own output scale. The audio experiment is the extreme case — the two branches share no architecture, no dimension (384 vs 512) and no input representation.

---

## Ablations

### The term ablation, and the number that identifies Barlow Twins' hidden normalisation

| `λ` (inv) | `μ` (var) | `ν` (cov) | Top-1 | Reading |
|---|---|---|---|---|
| 1 | 0 | 0 | **collapse** | Invariance alone collapses — *the sharp contrast with Barlow Twins* |
| 25 | 0 | 1 | **collapse** | Covariance has no repulsive effect; it cannot prevent norm collapse |
| 0 | 25 | 1 | collapse | No signal without invariance |
| 1 | 1 | 0 | **57.5** | Invariance + variance is the whole anti-collapse minimum viable objective |
| 25 | 25 | 1 | **68.6** | Full |

**The 57.5 is the load-bearing datum, and it is a cross-paper identification.** Barlow Twins' invariance-*only* ablation reaches **57.3** without collapsing, and the wiki attributed that to the batch-wise standardisation hidden inside its loss ([[wiki/entities/barlow-twins.md]]). VICReg removes all standardisation and adds an explicit variance hinge; its invariance-only ablation **collapses**, and invariance-plus-variance recovers **57.5** — the same number to 0.2 points. So Barlow Twins' batch standardisation and VICReg's variance term are the *same provision implemented twice*, one implicit and uncounted, one explicit and priced. That closes the question the Barlow Twins ingest left open about where its anti-collapse actually lives.

### Coefficient robustness — an objective with a certifiable minimum that still collapses

| `λ, μ, ν` | 1,1,1 | 10,1,1 | 1,10,1 | 5,5,1 | 10,10,1 | 25,25,1 | 50,50,1 |
|---|---|---|---|---|---|---|---|
| Top-1 | **collapse** | **collapse** | **collapse** | 68.1 | 68.2 | **68.6** | 68.3 |

`λ = μ` with `ν < μ` converges; `λ ≠ μ`, or `ν ≥ μ`, is unstable or collapses. So the usable region is a ray (`λ = μ ≳ 5`, `ν = 1`) and the exact position on it is worth ±0.5 points; the same values transfer to MNIST and CIFAR-10/100 untouched.

**This is a datum for [[wiki/concepts/objective-identifiability.md]] and it cuts against the wiki's own certifiability argument.** The wiki's stated preference for loss-term anti-collapse over BYOL's update-rule mechanism is that a term's minimum can be *stated and checked*. VICReg's minimum is non-collapsed for every positive `(λ, μ, ν)` — the variance hinge is violated by a constant encoder at any `μ > 0` — and yet training collapses across most of that space. **Certifying the minimum does not certify the trajectory.** The correct claim is narrower than the one the wiki has been making: a loss-term provision makes the *target* auditable, not the outcome.

**And the coefficient count the wiki has been quoting is wrong by a factor of two.** VICReg has **three** coefficients, one of which (`ν`) is fixed to 1 and two of which are tied (`λ = μ`) — one free scale. The "six coefficients for a VICReg-derived objective" that [[wiki/entities/lewm.md]] and gap G34 price against SIGReg's one belongs to **PLDM's seven-term end-to-end objective**, a downstream JEPA variant, not to VICReg. The honest comparison on tuning cost is 1 free scale vs 1 (`λ`), and the difference is *robustness within the count*: Barlow Twins' `λ` is flat over a 10× range and VICReg's ray has a collapse boundary two-fold away in either direction.

### Normalisation — the method that removes all of it

| Expander hidden layers | Embedding | Top-1 |
|---|---|---|
| standardised | **none** | **68.6** |
| standardised | standardised | 68.4 |
| none | standardised | 67.4 |
| standardised | `l2` (unit sphere) | **65.1** |

VICReg is the first joint-embedding method in the wiki whose embeddings are neither batch-standardised nor projected onto a sphere, and *not normalising is the best setting*. Left unconstrained, the covariance entries take values in a wider range than the `[−1, 1]` of a correlation matrix, "which seems to facilitate training". Standardisation is still useful **inside** the expander (≈ −1.2 when removed), i.e. as an optimisation aid rather than as an anti-collapse device.

**The `l2` row is a priced version of LeWM's dimensionality prior.** Projecting onto the unit sphere implicitly fixes each dimension's batch standard deviation at `1/√d`; the paper re-runs VICReg with that target (`γ = 1/√d`, `l2`-normalised invariance) and loses **3.5 points**. So committing the embedding to a specific geometry costs, in exactly the direction [[wiki/entities/lewm.md]]'s Two-Room failure predicts — and VICReg's own escape is to specify a variance *floor* per dimension and leave the joint shape free, which is the weakest distributional commitment of any anti-collapse term in the wiki.

### Asymmetry components, and the contradiction with the "not stackable" claim

100-epoch linear eval, `μ = 1` / `ν = 0.01` when regularisation is added to another method:

| Configuration | No reg | + variance | + variance & covariance |
|---|---|---|---|
| BYOL (EMA + predictor + BN) | 69.3 | **70.2** | 69.5 |
| SimSiam (stop-grad + predictor + BN) | 67.9 | 68.1 | 67.6 |
| stop-grad + predictor, **no BN** | **35.1** | 67.3 | 67.1 |
| stop-grad, no predictor | collapse | 56.8 | 66.1 |
| VICReg (no BN, no predictor) | collapse | 57.1 | 68.7 |
| **VICReg (BN, default)** | collapse | 57.5 | **68.6** |
| VICReg + predictor | collapse | 56.5 | 67.4 |

Four things:

1. **The predictor is redundant with variance regularisation, not hostile to it.** With variance regularisation, adding a predictor changes nothing (68.6 → 67.4 at 100 epochs; at 1000 epochs VICReg+predictor **exactly matches** VICReg at 73.2). Without it, both stop-gradient and predictor are necessary.
2. **Variance regularisation *improves* BYOL and SimSiam** (+0.9 / +0.2 at 100 epochs, shrinking to +0.2 for BYOL at 1000) and makes them converge faster. This directly contradicts the wiki's current general claim, taken from Barlow Twins, that dimension-contrastive and dynamical anti-collapse are mutually destructive — there the same graft cost **10 points**. New tension **T166**.
3. **Covariance regularisation, unlike variance, does not compose with a stop-gradient** — every row above loses a little when `c` is added on top of `v`, and the paper states outright that "optimization with SG and CR is hard".
4. **Batch normalisation in the expander is worth 1.0 to VICReg and ~33 points to SimSiam** (35.1 → 67.9 with BN). A method whose collapse-avoidance is a term degrades gracefully without BN; one whose collapse-avoidance is a dynamics does not.

**What BYOL and SimSiam are doing, measured** (Figs. 4–5): their embeddings' per-dimension standard deviation tracks `1/√d` *exactly* — perfectly spread on the unit sphere — while the **representation**-level standard deviation is lower than it needs to be, and adding variance regularisation raises it, with the rise correlated to the accuracy gain. And even with no covariance term at all, both methods drive the representations' average off-diagonal correlation coefficient down on their own. **The update-rule mechanism and the dimension-contrastive terms produce the same two representation-level statistics.** They are not competing objectives; they are two implementations of one target, which is why grafting one onto the other buys ≈1 point at best (the residual is the "very slow collapse" the architectural tricks fail to fully arrest).

### Scaling

| Expander width | 256 | 512 | 1024 | 2048 | 4096 | 8192 | 16384 |
|---|---|---|---|---|---|---|---|
| Top-1 | 55.9 | 59.2 | 62.4 | 65.1 | 67.3 | **68.6** | 68.8 |

| Batch | 128 | 256 | 512 | 1024 | 2048 | 4096 |
|---|---|---|---|---|---|---|
| Top-1 | 67.3 | 67.9 | 68.2 | 68.3 | **68.6** | 67.8 |

Width dependence is steep and inherited from Barlow Twins' decorrelation mechanism, but it **saturates at 8192** (+0.2 to 16384) where Barlow Twins reported monotone gains through 16384 with no saturation — a small qualification of that page's "dimension is estimator quality, buy more of it" reading. Batch dependence is ±1.3 over a 32× range, against SimCLR's −4 at 256: the Gaussian-proxy-estimator argument transfers intact.

---

## Limitations

- **No prediction, no time, no planning.** A view-invariance method evaluated entirely as a frozen or fine-tuned feature extractor. Its role in the wiki is as the objective slot of the JEPA family, not as a world model.
- **The independence claim is unmeasured.** The expander's stated purpose is that decorrelation *after a non-linearity* removes dependencies in the pre-image; only the correlation half is measured.
- **The multimodal experiments are small.** MS-COCO (pretrained on MS-COCO itself) and ESC-50 (1600 training clips). They establish that the asymmetric setting *runs* and beats the matched baselines, not that it scales.
- **No augmentation-removal sweep**, so T165 gets no third data point from here.
- **The collapse boundary in coefficient space is reported, not explained.** Nothing predicts why `λ = μ = 1, ν = 1` collapses when `λ = μ = 5, ν = 1` reaches 68.1.

---

## Comparison

| | **VICReg** | [[wiki/entities/barlow-twins.md]] | [[wiki/entities/byol.md]] | SimCLR | [[wiki/entities/lewm.md]] |
|---|---|---|---|---|---|
| Anti-collapse lives in | loss (variance hinge + covariance), **per branch** | loss (off-diagonal) + batch standardisation, **across branches** | update rule | negatives | loss (SIGReg), per branch |
| Free coefficients | 1 scale (`λ=μ`, `ν=1`) — with a collapse boundary | 1 (`λ`, flat over 10×) | 0 in the loss | 1 (temperature) | 1 (`λ`) |
| Branches may differ in weights / architecture / **modality** | **yes / yes / yes** | degrades (−4.5 on weights) | no (EMA requires one architecture) | yes, but weak throughout | not tested |
| Embedding normalisation | **none** (`l2` costs 3.5) | batch standardisation (load-bearing, 18 pts) | `l2` | `l2` | implicit in the `N(0,I)` target |
| Distributional commitment | per-dimension variance **floor** only | second moments | none explicit | none explicit | full isotropic `N(0,I)` |
| Composes with predictor / stop-grad | **yes, neutrally** | **no, −10 points** | is that mechanism | — | not tested |
| Gains from embedding width | to 8192, then saturates | monotone to 16384 | saturates (8192 *hurts*) | saturates | fixed |

The row that matters is the third. Every other anti-collapse provision in the wiki couples the two branches — through shared weights, through a cross-correlation matrix, or through an EMA that copies one branch's parameters into the other. VICReg's does not, and that is what makes a **non-contrastive multimodal joint embedding** possible at all: no negatives means no noise distribution, so none of the failure modes [[wiki/concepts/cross-modal-grounding.md]] attributes to CLIP's in-batch-caption negatives has a place to arise. The rate bound survives untouched — a caption still caps what the shared embedding can carry — but the *shortcut* channel is closed by construction.

---

## Connections

- **[[wiki/entities/barlow-twins.md]]** — the cross-paper identification that settles where Barlow Twins' anti-collapse sits: its invariance-only ablation reaches 57.3 without collapsing, VICReg's collapses and needs the variance hinge to reach 57.5, so the batch standardisation Barlow Twins never counts as a term *is* VICReg's `v` implemented implicitly; and moving the penalty from the cross-branch to the per-branch matrix is what buys the asymmetric and multimodal settings (+2 to +4 points).
- **[[wiki/entities/byol.md]]** — the measured relationship between the two anti-collapse kinds: BYOL's embeddings sit perfectly on the sphere while its *representations* stay under-spread and slowly decorrelating, adding VICReg's variance term raises that spread and buys +0.9, and BYOL minimises the average correlation coefficient on its own without any covariance term — so update rule and loss term drive the same two statistics rather than competing.
- **[[wiki/entities/h-jepa.md]]** — the primary source for its first named training-criteria instance: criteria 1–2 (information maximisation on each encoder) are here a variance hinge plus a covariance penalty applied *separately per branch*, which is exactly what the design needs for `s_x` and `s_y` to come from different modalities.
- **[[wiki/concepts/energy-based-models.md]]** — the dimension-contrastive column's working instance, with the volume-minimising regulariser split into two independently ablatable halves: the variance hinge blocks *norm* collapse and the covariance term blocks *informational* collapse, and neither substitutes for the other (25/0/1 collapses, 1/1/0 reaches 57.5).
- **[[wiki/entities/lewm.md]]** — corrects the coefficient count that page prices SIGReg against (VICReg is one free scale, not six — the six is PLDM's seven-term objective) and supplies the missing measurement of its dimensionality-prior claim: constraining VICReg's embedding to the unit sphere, i.e. fixing each dimension's variance at `1/√d`, costs **3.5 points**.
- **[[wiki/concepts/objective-identifiability.md]]** — the sharpest limit on the wiki's certifiability argument: VICReg's minimum is provably non-collapsed for every positive coefficient triple, yet training collapses across most of the coefficient space, so a loss-term anti-collapse provision certifies the *target* and not the trajectory.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the non-contrastive alternative to that page's entire contrastive column: image–text and audio–spectrogram joint embeddings trained with no negatives at all, beating both a contrastive baseline and Barlow Twins, which removes the in-batch-caption noise distribution while leaving the caption's rate bound intact.
- **[[wiki/concepts/divergence-objectives.md]]** — the estimator argument applies here with one qualification: the batch-size independence transfers (±1.3 over 32×), but the width gain **saturates at 8192**, so a second-moment penalty on a single branch's covariance is a cheaper estimator than a cross-correlation and stops paying sooner.
- **[[wiki/concepts/shortcut-learning.md]]** — a design that closes the noise-distribution channel by having no noise distribution: with no negatives anywhere, the shortcut a contrastive multimodal objective inherits from "the other captions in this minibatch" cannot arise, though nothing here tests whether the resulting representation carries relations.
- **[[wiki/entities/dinov2.md]]** — the same quantity estimated the other way, and priced per read-out: this page's variance hinge and covariance penalty are second-moment surrogates for the differential entropy KoLeo estimates non-parametrically, and at foundation scale that entropy term is worth +8.3 mAP on retrieval, ~0 on segmentation and 0.5 on ImageNet linear.
