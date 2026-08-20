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

The augmentation result has a mechanism, and it is the sharpest statement of what negatives cost. Crops of one image share a colour histogram and histograms differ across images, so a *contrastive* task on crops alone is solved by colour histogram and the representation is never charged for anything else — the negatives define what the shortcut is ([[wiki/concepts/shortcut-learning.md]]). BYOL's target is not a discrimination but a regression onto a representation that already contains more, so any extra feature the target carries is worth encoding.

---

## The ablations that carry the architectural content

| Configuration | Top-1 | What it establishes |
|---|---|---|
| **Predict a fixed randomly-initialised network** (`τ = 1`, target never updated) | **18.8** ± 0.7 (the random target itself: **1.4**) | A representation can be bootstrapped out of a target carrying no learned information at all. Predicting noise-with-structure is a real training signal |
| Target = EMA, `τ_base ∈ {0.9, 0.99, 0.999}` | 68.4 / **72.5** / 69.8 | Wide plateau; the trade-off is targets that move too fast vs. too slowly |
| Target = online network, `τ = 0` (stop-grad only) | **0.3** | Collapse. Stop-gradient by itself does not prevent it |
| BYOL minus predictor (= unsupervised Mean Teacher) | **0.2–0.3** | Collapse. EMA target by itself does not prevent it either |
| Add SimCLR's negatives to BYOL (`β = 1`, temperature untuned) | 70.9 | Negatives *hurt* here; recoverable by retuning the temperature |
| SimCLR + target network (same negative count) | 69.4 → **71.0** | The EMA target helps by stabilisation alone, not by supplying more negatives as in MoCo |
| SimCLR + predictor | ≈ unchanged | The predictor is not a capacity fix |
| No target network, **optimal linear predictor** (closed-form regression on the batch each step) | **52.5** | The target network is substitutable |
| No target network, predictor LR raised | **66.5** | — same, and better |
| No target network, projector **and** predictor LR raised | ≈25 | The near-optimality must be the predictor's *relative* to the projector |

**Both stabilisers are necessary, and they are necessary for one reason.** The last three rows say the EMA target's role is to keep the predictor near-optimal — a slowly-moving target is a regression problem the predictor can stay solved for. Make the predictor optimal by other means and the EMA becomes unnecessary. So BYOL's two components are not two anti-collapse mechanisms but one, implemented twice.

**Why collapse is unstable (the paper's hypothesis, not a proof).** With an optimal predictor `q⋆(z_θ) = E[z′_ξ | z_θ]`, the online update follows in expectation the gradient of the **expected conditional variance** `Σ_i Var(z′_{ξ,i} | z_θ)`. Since `Var(X|Y,Z) ≤ Var(X|Y)` for any `Z`, *discarding* information from the online projection can never lower the objective — a constant `z_θ` is the worst possible conditioner. The EMA then copies whatever new variability the online branch has acquired into the target, so the target's information content ratchets up rather than being minimised. Minimising the same quantity with respect to `ξ` would collapse; BYOL does not do that, and that is exactly why:

> **BYOL's target update is not in the direction of `−∇_ξ L`. The authors hypothesise that there is no loss `L_{θ,ξ}` whose joint gradient descent is BYOL's dynamics** — the stated analogy is a GAN, where no scalar is jointly minimised by both players.

---

## The claim worth extracting: an anti-collapse mechanism that is not a term

The wiki's collapse taxonomy ([[wiki/concepts/energy-based-models.md]], gap **G34**) has carried three families, all of them *terms in an objective*: sample-contrastive (negatives), dimension-contrastive (VICReg/Barlow Twins variance + covariance), distribution-matching (SIGReg, [[wiki/entities/lewm.md]]). BYOL is a fourth kind and not a fourth member: **the anti-collapse provision is a property of the update rule, not of the loss.** The loss at every step is a plain regression that a constant encoder minimises perfectly; the dynamics never go there.

| | Contrastive | Dimension-contrastive | Distribution-matching | **BYOL (dynamical)** |
|---|---|---|---|---|
| Where the provision lives | loss | loss | loss | **update rule** |
| Cost model | negatives may grow exponentially in `dim(y)` | representation width | one coefficient + a dimensionality prior | **none in the loss; ~2× compute for the second branch** |
| Coefficients to tune | temperature | 6 (VICReg-derived) | 1 (`λ`) | **0** (but `τ` and the predictor's LR ratio move in) |
| Certifiable | yes — the objective's minimum is not collapsed | yes | yes | **no — no objective exists to certify** |
| Fails when | batch too small; noise distribution misses the relevant perturbation | width too small | environment's intrinsic dimension < target's | predictor falls behind the target (`τ = 0`), or is removed |

The trade in the last two rows is the point. BYOL buys the cheapest anti-collapse mechanism anyone has found and pays for it by leaving the field with a system whose behaviour is a fact about SGD rather than a fact about an objective — which is the strongest form of the non-identifiability on [[wiki/concepts/objective-identifiability.md]]: not *which* loss produced this representation, but *whether there is one*.

---

## Limitations

- **The augmentation set is the prior, and it is hand-designed.** The paper's own stated blocker for other modalities: BYOL generalises to audio/video/text only if someone supplies comparable augmentations. In [[wiki/concepts/divergence-objectives.md]]'s rate–distortion split, the augmentation *is* `f(X)` and therefore fixes the rate — what BYOL is allowed to keep is decided before its loss is evaluated.
- **No mechanism for one-to-many.** The target is a single vector and the loss is squared error onto it. There is no latent `z` and no way to represent alternative continuations — the property [[wiki/concepts/energy-based-models.md]] treats as the reason to refuse to predict.
- **Collapse-avoidance is empirical.** The conditional-variance argument assumes an optimal predictor and no symmetrisation or normalisation; undesirable equilibria are admitted to exist and merely not observed.
- **BatchNorm sits in the loop.** The paper attributes its only batch-size dependence to BN in the encoder without asking what BN contributes to collapse-avoidance — an implicit batch statistic in a method advertised as negative-free.
- **Evaluated only as a frozen feature extractor.** Every number is linear eval, fine-tuning or transfer. Nothing here tests prediction, planning, or any use of the *predictor*, which is discarded.

---

## Comparison

| | **BYOL** | SimCLR | MoCo | Mean Teacher | VICReg | [[wiki/entities/lewm.md]] | [[wiki/entities/v-jepa-2.md]] |
|---|---|---|---|---|---|---|---|
| Negatives | no | yes (in-batch) | yes (memory bank) | no | no | no | no |
| EMA target | yes | no | yes (for negatives) | yes | no | **no** | yes (`0.99925`) |
| Predictor on one branch | **yes** | no | no | **no → collapses** | no | yes (the world-model predictor) | yes |
| Anti-collapse | dynamics | negatives | negatives | supervised loss | variance + covariance terms | SIGReg | EMA + stop-grad (BYOL's) |
| Descends a well-defined loss | **no** | yes | yes | yes | yes | yes | no |
| Predicts across | two views of one image | — | — | — | two views | **time**, action-conditioned | **time**, masked patches |

The right-hand columns are the reason this 2020 paper is a wave-7 ingest: the JEPA lineage's target-encoder-plus-stop-gradient is BYOL's mechanism transplanted from view-prediction to time-prediction, and it arrived with a caveat — *no objective corresponds to it* — that the lineage inherited silently and that LeWM's whole subtraction is aimed at.

---

## Connections

- **[[wiki/concepts/energy-based-models.md]]** — supplies the fourth anti-collapse family for that page's contrastive/regularised split, and the one that breaks its framing: the provision is in the update rule rather than the loss, so a joint-embedding architecture can avoid the collapse its energy landscape permits without any term that pushes energy up anywhere.
- **[[wiki/concepts/objective-identifiability.md]]** — the limit case of that page's many-to-one direction: BYOL's authors hypothesise *no* loss is jointly descended, so the representation cannot be attributed to an objective at all, only to a dynamics.
- **[[wiki/entities/h-jepa.md]]** — the design whose four training criteria this refutes as necessary conditions: BYOL implements criterion 3 (predictability) alone, omits 1, 2 and 4 (information maximisation and latent capacity limits), and does not collapse.
- **[[wiki/entities/lewm.md]]** — the direct answer: the EMA teacher and stop-gradient LeWM removes are exactly this page's two components, and its objection — that they correspond to no well-defined objective — is this paper's own admission, restated as a reason to replace them.
- **[[wiki/entities/v-jepa-2.md]]** — inherits the mechanism at scale: masked feature prediction with an EMA teacher at `τ = 0.99925` is BYOL's asymmetry with the second view replaced by a future frame.
- **[[wiki/concepts/amortized-inference.md]]** — the predictor is an amortised regression whose *staleness* is the design variable: a closed-form optimal linear predictor (52.5%) or a faster-learning one (66.5%) substitutes for the EMA target entirely, so this is a case where how well the amortiser tracks its exact solution decides whether the whole system learns anything.
- **[[wiki/concepts/shortcut-learning.md]]** — the crop-only ablation isolates the mechanism by which negatives *create* a shortcut: a discrimination between crops is solvable by colour histogram, so the contrastive objective terminates there, while a regression onto a richer target keeps paying for extra features (59.4% vs 40.3%).
- **[[wiki/concepts/divergence-objectives.md]]** — a clean instance of the rate–distortion split: BYOL and SimCLR differ only in the distortion term, and the augmentation set they share fixes the rate — which is why removing colour jitter costs both of them, and why the paper's stated blocker for other modalities is an `f(X)` question, not a loss question.
- **[[wiki/concepts/representation-probing.md]]** — qualifies the random-initialisation null: an untrained network scores 1.4% as a classifier but supports 18.8% when used as a *prediction target*, so "random network" is a floor for read-out and not a statement that its activations are structureless.
- **[[wiki/concepts/violation-of-expectation.md]]** — the same qualification where the wiki relies on it hardest: the `n = 20` untrained-network null is a chance level for a behavioural score, and this result shows the same networks carry enough structure to teach a downstream encoder.
