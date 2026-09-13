# Label-Free Model Selection

**Pick the good run out of a training sweep using only the model and the unlabelled training data. This is the instrument `G108` asks for; what the field has are anti-collapse statistics that rank by how much of the representation's capacity survived, and none of them ranks by a structural property.**

> **Created at the Garrido et al. 2023 ingest.** `G108` had accumulated evidence on four pages ([[wiki/concepts/objective-identifiability.md]], [[wiki/concepts/disentanglement.md]], [[wiki/entities/lejepa.md]], [[wiki/concepts/alignment-uniformity.md]]) and owned none of them. The gap it answers is `G108`; the tensions it bears on are T310 and T314.

The slot exists because **every self-supervised objective in the wiki is tuned against labels it is not supposed to have.** The hyperparameters, the augmentation lists and the published numbers of the whole joint-embedding family were selected by monitoring a supervised linear probe on ImageNet's validation set — so "this method works without labels" is a statement about the weight updates and not about the design procedure (Garrido et al. 2023). The same point one level up is [[wiki/concepts/objective-identifiability.md]]'s audit item 1.

---

## The size of the hole

| Measurement | Number |
|---|---|
| Variance of a disentanglement score attributable to the objective | **37%** |
| …to objective × regularization strength | 59% |
| …to the **random seed** | ~41% |
| Rank correlation of reconstruction error / KL / ELBO / estimated total correlation with any disentanglement metric | **none consistent** |
| Hyperparameter transfer across datasets, vs. *random* model selection | 59.3% (54.9% if the metric also changes) |

(Locatello et al. 2019, >12,000 models, [[wiki/concepts/disentanglement.md]].) Since all six disentanglement metrics need ground-truth factors, tuning on them *is* supervision. So in the one literature where the question has been asked at scale, no admissible selector existed at all.

---

## The candidates

Ordered by how much of the representation each one's statistic actually looks at.

| Selector | Statistic | Fits / tunes anything? | Validated against | Known failure |
|---|---|---|---|---|
| **Supervised linear probe** (the field's default) | top-1 on a held-out labelled set | trains a classifier; needs labels | itself | not label-free at all; and it is a *format* measurement — T310 |
| **Pretext task** (e.g. rotation prediction) | accuracy of an auxiliary head | trains a classifier | augmentation-policy selection | needs the pretext transform to be one the model is *not* invariant to, which the augmentation list decides |
| **α-ReQ** (Agrawal et al. 2022) | power-law decay exponent `α` of the eigenspectrum | no | hyperparameter selection | the power-law prior **fails on the embeddings** and is known not to hold under collapse; worst case 32.3 against a 68.3 oracle |
| **RankMe** (Garrido et al. 2023) | `exp(H(σ̄))` — entropy of the ℓ¹-normalised singular values of the embedding matrix | **no** — no parameters, no training | 110 models × 5 methods × 11 datasets, ID and OOD | necessary, not sufficient; within one method only; saturates past the class count |
| **`(L_align, L_uniform)`** (Wang & Isola 2020, [[wiki/concepts/alignment-uniformity.md]]) | two scalars on validation embeddings | no | 521 encoders, 4 datasets, 2 modalities, incl. a **dense** conv-layer depth regression | two numbers, not an ordering; computed on the embedding (T314) |
| **Rescaled training loss** ([[wiki/entities/lejepa.md]]) | `train_loss / λ^0.4` | one exponent | Spearman `ρ_s ≈ 0.85`, `≈0.99` rescaled | one loss family; **unavailable to the EMA lineage**, which has no loss whose value means anything ([[wiki/entities/byol.md]]) |
| **Seed averaging with reported variance** | the variance itself | no | — | measures the hole rather than filling it, and almost nobody does it |

---

## RankMe, in full

$$\text{RankMe}(Z) = \exp\left(-\sum_{k=1}^{\min(N,K)} p_k \log p_k\right), \quad p_k = \frac{\sigma_k(Z)}{\|\sigma(Z)\|_1} + \epsilon$$

`Z ∈ R^{N×K}` is the **embedding** matrix — the projector output, not the backbone representation — on the *source* (training) dataset.

| Implementation point | Value |
|---|---|
| Why entropy rather than a threshold count | `rank(Z) = Σ 1{σ_k > max_i σ_i · max(M,N) · ε}` needs a data-type-dependent `ε` (~10⁻⁷ for float32); the entropy form needs no threshold and additionally quantifies **whitening**, which is what makes a probe on top easy to fit |
| Samples needed | **25,600**, ablated; not the full set |
| Hyperparameters | none |
| Cost | minutes; one SVD |
| Selection rule | take the highest rank; on a plateau of equal ranks take the first value achieving it (only defined when the hyperparameter is ordered) |
| Where to tap DINO | *before* the last projector layer — the clustering layer breaks it |
| Where it breaks | iNat-18 pre-training with an 8192-wide projector on a 2048-d representation: rank is capped at 2048, so "take the highest" must be replaced by a hand-set threshold |

**The experimental base.** 5 methods (SimCLR, VICReg, VICReg-exp, VICReg-ctr, DINO), all ResNet-50 with an 8192–8192–2048 MLP projector, 100 epochs on ImageNet with LARS; 110 models; evaluated on 11 datasets (ImageNet + iNat-18, Places205, EuroSat, SUN397, StanfordCars, CIFAR-10/100, Food101, VOC07, CLEVR-count). Hyperparameters swept are the ones that move the rank: temperature, loss weights, learning rate, weight decay.

### What it recovers

Top-1 under selection by `RankMe` vs. by the labelled ImageNet oracle, on the **representations** (backbone output, projector discarded):

| | VICReg cov. | VICReg inv. | VICReg LR | VICReg WD | SimCLR temp. | SimCLR LR | SimCLR WD | DINO t-temp. | DINO s-temp. |
|---|---|---|---|---|---|---|---|---|---|
| ImageNet oracle (labels) | 68.2 | 68.2 | 68.6 | 68.0 | 68.5 | 68.5 | 68.3 | 72.3 | 72.4 |
| α-ReQ | 67.9 | 67.5 | **59.5** | 67.8 | 63.5 | 68.1 | **32.3** | 71.7 | 66.2 |
| **RankMe** | 67.8 | 67.9 | 68.2 | 67.8 | 67.1 | 68.0 | 68.3 | 72.2 | 72.4 |

Gap to the labelled oracle: **under half a point on average**, with no labels, no optimisation and no parameters. On the embeddings (Table 1 of the source) the same pattern holds and α-ReQ's worst case is 36.2 against a 59.7 oracle.

**And it beats the labelled oracle out of distribution in three separate places** — SimCLR temperature, OOD average, embeddings: 56.4 vs 54.7; iNat-18-pretrained VICReg covariance weight, OOD average: **60.91 vs 60.70** (and 60.65 for an ImageNet-labelled oracle, 56.51 for α-ReQ). Selecting on a labelled source-domain probe is *itself* a biased selector for downstream use, which is the same finding [[wiki/entities/ssl-transfer-benchmark.md]] reports from the other side.

### Why rank at all

Three results compose into one bound, and none of them is about self-supervision:

| Step | Statement |
|---|---|
| Eckart–Young–Mirsky | `‖Y − P‖²_F ≥ Σ_{r=R+1}^{C} σ²_r(Y)` for `P` of rank `R` — approximating a target needs at least the target's rank |
| A linear probe cannot help | `rank(ZW + 1bᵀ) ≤ min(rank(Z), rank(W)) + 1`, so `min_{W,b} ‖Y − ZW − 1bᵀ‖²_F` inherits the same lower bound |
| Cover's theorem | probability that a randomly labelled point set is linearly separable rises with the embedding rank `R` and falls with the sample count `N` |

**Proposition 5.1.** *Maximum training accuracy in linear regression or classification increases with the embeddings' rank, and for classification plateaus once the rank exceeds the number of classes.*

That is a statement about **training** accuracy on the **embedding** of the **source** dataset. Getting from there to test accuracy on the representation of a target dataset costs three empirical hypotheses, which the paper validates rather than proves:

| Hypothesis | Evidence |
|---|---|
| (i) linear probes do not overfit | train and test accuracy highly correlated across all datasets |
| (ii) embedding and representation performance are monotonically linked | measured, near-monotone |
| (iii) source and target embedding rank are monotonically linked — `rank(Z_target) ∝ rank(Z_source)` | Pearson **> 0.99**, *provided the source is diverse and the target overlaps it semantically*; StanfordCars, which barely overlaps ImageNet, has the weakest scaling and is also where the rank criterion picks the wrong model |

Hypothesis (iii) is the load-bearing one and it is the one with a named precondition, so the instrument's validity is a function of the source corpus's diversity — the label-free analogue of T310's "validity is a function of the distance between probe task and downstream task".

### The boundaries the source states itself

- **Necessary, not sufficient.** High rank is required for good downstream performance; the highest-rank model is not always the best (VICReg on StanfordCars, where the class count is small relative to the rank).
- **Within one method only.** Rank is not the sole determinant of performance, so comparing SimCLR to DINO by RankMe is not licensed — it is a *hyperparameter* selector, not a *method* selector.
- **It saturates.** The theory's plateau at the class count means the criterion is uninformative for few-class downstream tasks and most informative where the class count is large (iNat-18, 8142 classes).

### It survives leaving the linear regime, which is the surprise

RankMe is derived entirely from linear-separability arguments, so the expectation is that a nonlinear read-out would break it — a rank-deficient SimCLR embedding is exactly what an MLP head should be able to rescue. It does not happen:

| Read-out | Behaviour of the rank↔performance relation |
|---|---|
| 3-layer MLP head (2048, ReLU), SUN397 | same curves as linear |
| `k`-NN (best of 36 `k` × temperature combinations), ImageNet | same — and `k`-NN scores *euclidean-distance preservation*, not linear separability |
| semi-supervised fine-tuning, ImageNet-1% / 10% | small drops vs. the task oracle (38.7 vs 39.7; 62.7 vs 62.7) |
| VOC07+12 detection fine-tuning, AP50 | **matches or beats the labelled ImageNet linear oracle** (79.7 vs 78.2; 81.0 vs 81.0) |

The last two rows are the ones that matter beyond this page: they are a **third independent source for T310**, and they arrive at it from a new direction. On a dense task, a label-free rank criterion outranks the field's labelled instrument. See [[wiki/empirical-tensions.md]] T310.

---

## Why this does not close `G108`

`G108`'s `Closes when` asks for a quantity that ranks runs by a **structural** property — factorization, invariance, graph fidelity — validated on a dataset it was not tuned on. RankMe satisfies the second half outright (11 datasets, two pre-training corpora, never tuned) and fails the first:

| Requirement | RankMe |
|---|---|
| computable from model + unlabelled data | ✅ |
| ranks checkpoints/runs | ✅ within a method |
| validated out of distribution | ✅ |
| ranks by a **structural** property | ❌ — it ranks by *capacity*. Effective rank is an anti-collapse statistic: it says how many directions survived, not how they are organised |

**The distinction is not pedantic, and the source's own theory is what makes it sharp.** Proposition 5.1 bounds *training* accuracy of an arbitrary linear read-out. A representation that is full-rank because it memorised the training set direction-by-direction scores identically to one that is full-rank because it factorised the generative factors — Cover's theorem does not distinguish them, and neither does the entropy of a singular-value spectrum. What buys the downstream correlation is hypothesis (iii), an empirical regularity about corpora, not the theory.

**(brainstorm) The test that would separate the two is cheap and nobody has run it.** Take the >12,000-model disentanglement sweep — where ground-truth factors *are* available and where no label-free selector exists — and compute RankMe on each model's code. If effective rank correlates with a disentanglement metric, rank is doing structural work and `G108` is much closer to closed than this page says. If it correlates only with reconstruction quality, then the wiki has a *capacity* selector and a *structure* selector is still missing, and the two literatures can stop being cited as though they were about one problem.

---

## Open problems

- **Every selector here is computed on the embedding, which is the space T314 says is supposed to be rank-deficient.** RankMe, `(L_align, L_uniform)` and the rescaled LeJEPA loss are all projector-output statistics. RankMe's 110-model sweep is a direct measurement in that space and it says *more rank is monotonically better* — which is evidence for T314's position A on the monitor question. It does not refute B: RankMe's within-one-method restriction is exactly the restriction under which B's cross-architecture projector ablation (pinned-singular-value projector 52.2 ≈ no projector 51.5; fixed low-rank 62.3) is not a counterexample. **Nobody has computed RankMe on the *representation*.**
- **No selector in the table ranks a method, only a hyperparameter.** Every entry is explicitly or implicitly within-family. The question a practitioner actually asks — which objective to use on a new corpus — has no label-free answer at all.
- **No selector is calibrated against partial collapse.** [[wiki/entities/dinov3.md]]'s dense read-out peaks at ~200k iterations and ends below its own early value while the global linear probe rises monotonically. RankMe on patch tokens across that run is an unrun experiment, and `(L_align, L_uniform)` — the only monitor validated on a dense read-out — is the other candidate. Both cost one training run that has already been done.
- **A selector for the EMA lineage.** BYOL-descended systems have no loss value, and the projector-spectrum selectors have not been reported on them. Since that lineage includes most of the wiki's JEPA family, the instrument gap is worst exactly where the wiki's architectural interest is.
- **The class-count plateau makes the criterion useless for the wiki's own targets.** A structural code `g` ([[wiki/concepts/latent-graph-discovery.md]]) is a low-dimensional object by design. A criterion that rewards rank up to the number of downstream classes and then saturates gives no signal at the dimensionality a graph code lives at — so the instrument that exists is calibrated on the regime the wiki is not in.

---

## Connections

- **[[wiki/concepts/disentanglement.md]]** — the measurement of the hole this page is about: 41% of a disentanglement score is seed, no unsupervised quantity rank-correlates with any metric, and every metric that does needs ground-truth factors — which is what makes `G108` a gap rather than an inconvenience. It is also where the structural-vs-capacity test proposed above would be run.
- **[[wiki/concepts/objective-identifiability.md]]** — the parent problem: this page is audit item 1 turned into an instrument requirement, since "our objective produces M" is only a claim that a run producing M *exists* until something can pick that run out without labels.
- **[[wiki/concepts/representational-collapse.md]]** — the reason every selector here is a spectrum statistic: collapse is the cheapest solution to every self-supervised objective, so the first thing a label-free criterion can measure is how much of it happened, and effective rank is exactly that measured smoothly rather than as a threshold count.
- **[[wiki/entities/directclr.md]]** — the opposing measurement in the same space: it finds a trained contrastive embedding rank-deficient by design and identifies the projector's job as *discarding* dimensions, while this page's criterion rewards rank in that same embedding. The two are reconciled — not settled — by RankMe's within-one-method restriction (T314).
- **[[wiki/concepts/alignment-uniformity.md]]** — the other parameter-free selector, and the only one validated against a dense read-out: two scalars rather than an ordering, over 521 encoders spanning two modalities.
- **[[wiki/entities/lejepa.md]]** — the loss-value selector (`ρ_s ≈ 0.85`, `≈0.99` rescaled), and the case that shows what a *derived* target buys: an isotropic Gaussian embedding is both the probe-risk minimiser and full-rank, so the quantity this page selects on is what that objective is built to produce directly.
- **[[wiki/concepts/representation-probing.md]]** — the instrument this page is trying to replace: a probe needs labels and an ontology, and every row of that page's failure list is a reason not to select checkpoints with one. The relation runs both ways — RankMe's theory is a statement about what a *linear probe* can achieve, so the selector is derived from the instrument's limits.
- **[[wiki/entities/ssl-transfer-benchmark.md]]** — the other source showing that a labelled source-domain probe is a biased selector for downstream use: there the frozen/adapted rank correlation falls to 0.17 on detection, here a label-free rank criterion beats the ImageNet linear oracle on VOC detection outright.
- **[[wiki/entities/mae.md]]** — the read-out-depth evidence this page's fine-tuning results join: two of MAE's own ablations are visible only to the frozen probe, which is the same claim as "the labelled oracle is selecting on format" arrived at by ablation rather than by selection.
- **[[wiki/entities/dinov3.md]]** — the failure no selector here is calibrated on: a correctly-minimised objective whose dense read-out decays over training while every global measurement improves, so a monitor that tracks the global probe would certify a run that is degrading.
- **[[wiki/entities/byol.md]]** — the lineage this page cannot serve: no loss value to rank by, because the dynamics is hypothesised not to descend any joint objective.
- **[[wiki/concepts/latent-graph-discovery.md]]** — why the gap is load-bearing rather than an engineering detail: the structural code the framing needs is low-dimensional, and a capacity-based selector has no signal there, so choosing a run that discovered a graph is currently not possible without the graph.
- **[[wiki/concepts/projection-distortion.md]]** — the same measurement-validity discipline run on the other kind of spectrum claim: a statistic computed off a fitted low-dimensional object does not identify that object, which is why the arbitrary-shape control exists there and why the structural-vs-capacity control is missing here.
- **[[wiki/concepts/certification-instruments.md]]** — where this instrument belongs in the register: it certifies nothing about content, only that the representation did not throw its capacity away, which is a precondition rather than a certificate.
