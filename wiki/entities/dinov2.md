# DINOv2

**A self-supervised image encoder trained on an automatically curated 142M-image corpus by two simultaneous cross-entropy losses against an EMA teacher — one over the class token, one over masked patches — whose frozen features support linear read-outs of category, instance identity, depth and segmentation without ever being fine-tuned, and out of which object *parts* emerge as PCA components that match across pose, style and category.**

> **Provenance.** Oquab, Darcet, Moutakanni, Vo, Szafraniec et al. 2023, *DINOv2: Learning Robust Visual Features without Supervision* (`raw/oquab-2023-dinov2.md`), Meta AI Research / Inria. Models and code released (Apache 2.0). This is the primary source for the encoder the wiki has been citing by name since the world-models wave — DINO-WM's frozen backbone, [[wiki/entities/spelkenet.md]]'s segmentation baseline, and the DINOv2 column in [[wiki/entities/v-jepa-2.md]]'s comparisons.

---

## Architecture and objective

| Component | Spec |
|---|---|
| **Backbone** | ViT-g/14, 1.1B params, embed dim 1536 / 24 heads / 40 blocks, SwiGLU feed-forward, patch size 14. Smaller S/B/L are **distilled** from it, not trained from scratch |
| **Teacher** | EMA of the student, momentum cosine-scheduled `0.994 → 1`; updated every step. No predictor on either branch |
| **Image-level loss** | `L_DINO = −Σ p_t log p_s` — cross-entropy between softmaxed **prototype scores** (an MLP head onto 128k prototypes) of student and teacher class tokens, taken from *different crops* of one image |
| **Patch-level loss** | `L_iBOT = −Σ_i p_{ti} log p_{si}` over masked patch indices `i`: patches are masked for the student only, and the teacher's *visible* tokens at those positions are the target. **Separate head** — untying it from the DINO head beats sharing at this scale, reversing iBOT's own ablation |
| **Teacher normalisation** | softmax + centering by moving average, or **Sinkhorn–Knopp** (3 iterations, from SwAV) — a batch-level equipartition over prototypes applied to the *target* distribution |
| **Spread regulariser** | **KoLeo**, weight 0.1, on ℓ₂-normalised class tokens of the first global crop, per-GPU: `L_koleo = −(1/n) Σ_i log d_{n,i}`, `d_{n,i} = min_{j≠i} ‖x_i − x_j‖` — the Kozachenko–Leonenko differential-entropy estimator |
| **Resolution** | trained at 224, then **10k iterations at 518** at the end — near-parity with full high-res training at a fraction of its 3× cost |
| **Scale** | 625k iterations, batch 3072, 22k A100-hours for ViT-g (3.7 tCO₂eq — ~10× less than OpenCLIP ViT-G, which also trains a text encoder) |

**What is new relative to the wiki's joint-embedding entries.** There is no predictor and no negatives: the asymmetry that keeps [[wiki/entities/byol.md]] off its collapsed minimum is replaced by *normalising the teacher's output distribution* — centering subtracts a running mean over the batch, Sinkhorn–Knopp forces the batch's prototype assignments toward equipartition. Both are batch statistics that live in neither branch's parameters nor in an added loss term.

---

## Results (all with the backbone frozen unless stated)

| Protocol | DINOv2 ViT-g/14 | Best prior SSL | Best weakly-supervised |
|---|---|---|---|
| ImageNet-1k linear / `k`-NN | **86.5** / 83.5 | iBOT ViT-L 82.3 / 72.9; MAE ViT-H 76.6 / 49.4 | OpenCLIP-G 86.2; EVA-CLIP 86.4 |
| ImageNet-V2 (generalisation) | **78.4** | iBOT 72.4 | EVA-CLIP 77.4 |
| ImageNet-A / -R / Sketch | **75.9** / 78.8 / 62.5 | iBOT 41.5 / 51.0 / 38.5 | OpenCLIP-G 63.8 / **87.8** / **66.4** |
| Fine-tuned ImageNet-1k @448 | 88.9 (linear 86.7, **Δ = +2.2**) | — | SOTA 91.1 |
| iNat2018 / iNat2021 (never used for curation) | **81.6** / **85.7** | iBOT 66.3 / 74.6 | OpenCLIP-G 73.0 / 76.0 |
| SSv2 / K400 / UCF-101 (video, **no video in training**) | 38.3 / 78.4 / 91.2 | iBOT 38.7 | OpenCLIP-G 35.8 / 78.3 / 90.7 |
| Oxford-Hard instance retrieval (mAP) | **52.3** (ViT-L 54.0) | iBOT 12.7 | OpenCLIP-G 19.7 |
| ADE20k linear / +multiscale (mIoU) | 49.0 / 53.0 | iBOT 44.6 / 47.5 | OpenCLIP-G 39.3 / 46.0 |
| NYUd depth, linear-1 layer (RMSE ↓) | **0.344** | iBOT 0.417 | OpenCLIP-G 0.541 |
| NYUd → SUN RGB-D depth transfer (RMSE ↓) | **0.402** | iBOT 0.447 | OpenCLIP-G 0.537 |

**Three numbers carry most of the architectural content.**

1. **Fine-tuning buys +2.0 to +2.2 points.** A frozen backbone plus a linear layer is within noise of the whole system trained end to end — so "the underlying information is readily available", and a linear read-out is a nearly-sufficient interface. This is the strongest instance in the wiki of [[wiki/concepts/linear-representation-hypothesis.md]]'s premise arriving as an *engineering* result rather than an interpretability one.
2. **Instance retrieval separates from category recognition by 33 mAP.** DINOv2 beats OpenCLIP-G by +34 mAP on Oxford-Hard while trailing it by 5.3 on SUN397 classification. Category-level and instance-level granularity are different read-outs of the same frozen features, and the objective terms that buy them are *different* (below).
3. **Depth is linearly decodable and language supervision is worse at it.** iBOT ViT-L (300M, self-supervised) beats OpenCLIP ViT-G (1.8B, language-supervised) on all three depth benchmarks. Scene geometry is exactly the content [[wiki/concepts/cross-modal-grounding.md]]'s rate argument predicts a caption channel discards — nobody writes alt-text about metric depth ([[wiki/empirical-tensions.md]] T149).

---

## The ablation that matters: loss terms map onto read-out granularities

Removing one term at a time from the final recipe:

| Term removed | INet-1k linear | ImageNet-A | ADE20k mIoU | Oxford-M mAP |
|---|---|---|---|---|
| **− KoLeo** | 85.3 (−0.5) | 70.6 (−2.2) | 47.2 (+0.1) | **55.6 (−8.3)** |
| **− MIM (iBOT patch term)** | 85.3 (−0.5) | 72.0 (−0.8) | **44.2 (−2.9)** | 64.3 (+0.4) |
| *full recipe* | 85.8 | 72.8 | 47.1 | 63.9 |

**This is a decomposition the wiki's collapse taxonomy does not predict.** Both terms are worth ~0.5 on the standard linear probe — i.e. nothing — and each is worth a *large* amount on exactly one read-out, with sign flips on the other. The patch-level masked term buys **dense** structure and slightly costs instance retrieval; the entropy term buys **metric** structure (nearest-neighbour geometry) and does nothing for segmentation. Read against gap **G34**: an anti-collapse or spreading provision is not a single scalar property of a representation that more of is better, it is a purchase of a specific *read-out*, and the benchmark a designer optimises decides which term looks load-bearing. ImageNet linear probe — the field's default, and the metric almost every entry in [[wiki/concepts/energy-based-models.md]]'s tables is scored on — is the read-out that cannot see either.

**The successor qualifies this decomposition in one important way** (Siméoni et al. 2025, [[wiki/entities/dinov3.md]]). The masked-patch term *buys* dense structure — that stands — but it does not *hold* it. Scaling the same recipe to a ViT-7B for 1M iterations, the patch-level linear probe peaks at ~200k iterations and ends **below its own early value** while the ImageNet linear probe rises monotonically, with `L_iBOT` present and being minimised the whole time; the ViT-g shows the same decline more mildly. A per-patch cross-entropy against prototype assignments constrains each patch and not the relations among them, and the relations are what erode (CLS↔patch cosine similarity rises steadily; patch norms stay stable, so this is not the register artifact). One further read-out separates in the same source: **DINOv2 fails at unsupervised object discovery** — a non-parametric graph cut on its patch-similarity graph — despite its strong *parametric* dense probes, attributed to feature-map artifacts a fitted linear head absorbs and a graph cut cannot.

**KoLeo is a third shape of spread term, and it is the non-parametric one.** [[wiki/entities/barlow-twins.md]]'s ingest recorded the reading that a contrastive loss is a *non-parametric* entropy estimator of the embedding distribution while a variance/covariance penalty is a **Gaussian-parametrised proxy** for it. KoLeo is the non-parametric estimator applied directly and without negatives: nearest-neighbour spacing is Kozachenko–Leonenko's differential-entropy estimate, minimising `−Σ log d_{n,i}` maximises it. It costs one term at weight 0.1, is computed within a GPU's shard with no cross-communication, and its measured effect is confined to the read-out that is literally a nearest-neighbour search ([[wiki/concepts/retrieval-capacity.md]]).

**The incremental recipe table also contains a probing result the wiki should carry.** Building DINOv2 from iBOT by adding components one at a time, `k`-NN and linear top-1 **rank the same models differently**: LayerScale + high stochastic depth is `k`-NN +0.9 / linear −1.2; 128k prototypes is +1.2 / −0.1; SwiGLU is −0.2 / +0.6; untying the heads is +0.3 / −0.2. The authors optimise for `k`-NN on the stated assumption that "linear probe performance is lower-bounded by the `k`-NN performance". Two read-outs of one frozen representation disagree about which of two encoders is better, which is a probe-choice confound of the same shape as the label-basis confound on [[wiki/concepts/representation-probing.md]] — and the recipe was steered by the choice.

---

## The emergent property: part correspondence with no part supervision

PCA over patch tokens, thresholded on the first component:

| Component | What it turns out to be |
|---|---|
| **1st** | An unsupervised **foreground/background** split — thresholding its sign delineates the main object's boundary |
| **2nd–4th** (recomputed on foreground patches across several images of a category) | **Object parts**, matched across images: same colour lands on the same part despite changes of pose, style (photo vs drawing) and even object identity |
| Direct patch matching (ℓ₂ distance + assignment + non-maximum suppression) | Matches "semantic regions that serve similar purpose" **across categories** — a plane's wing to a bird's wing |

Nothing in the objective mentions parts. This is the wiki's cleanest case of a *correspondence* relation falling out of a discriminative self-supervised objective, and it is the relation [[wiki/concepts/subgraph-matching.md]] and analogical reasoning need: a plane-wing↔bird-wing match is a structural alignment between two objects that share no appearance statistics. **(brainstorm)** The measurement is worth stealing independently of the model — an assignment problem over patch features, scored between two *different* objects, is a label-free analogy probe, and the wiki has none. It would separate "the encoder has a part vocabulary" from "the encoder has a category vocabulary" in one instrument.

**The limit on the same property, from the wiki's own instrument page.** DINO-family features **merge same-category instances** — two chairs come out as one segment, because a discriminative objective is defined to pull instances of a category together ([[wiki/entities/spelkenet.md]]). Parts generalise *across* objects and instances do not individuate *within* a category: the same objective buys the first and forbids the second, and no downstream read-out undoes it.

---

## The data pipeline, and the circularity in it

LVD-142M is built with no metadata, no text and no supervision — only the model's own metric:

1. Crawl 1.2B images from web `<img>` tags; PCA-hash dedup, NSFW filter, face blur.
2. Self-deduplicate by `k`=64 nearest neighbours at cosine > 0.6 over a copy-detection embedding, keep one per connected component → 1.1B. Remove near-duplicates of any benchmark train/test split → 744M.
3. Embed with a ViT-H/16 pretrained on ImageNet-22k; **retrieve** `N`=4 (or 32) nearest neighbours of each image in a set of *curated* seed datasets, or, for small seeds, `k`-means the uncurated pool into 100k clusters and sample 10k images from each cluster a seed lands in.

| Training data (matched iterations, ViT-g) | INet-1k | Im-A | ADE-20k | Oxford-M | iNat2018 |
|---|---|---|---|---|---|
| ImageNet-22k | 85.9 | 73.5 | 46.6 | 62.5 | 81.1 |
| **Uncurated, same 142M count** | 83.3 | **59.4** | **48.5** | 54.3 | **68.0** |
| LVD-142M | 85.8 | 73.9 | 47.7 | **64.6** | 82.3 |

**Curation is worth 14 points on ImageNet-A and 14 on iNat2018 at matched size and matched compute** — the strongest primary-source version of [[wiki/concepts/shortcut-learning.md]]'s "zero-shot is a coverage measurement", and it says the purchase is made by the *distribution*, not by the count. The LVD-142M advantage also **grows with model size**: at ViT-S the two corpora are close, at ViT-g the curated one wins nearly everywhere.

**Two things qualify it.** First, uncurated data *wins* on ADE20k segmentation (48.5 vs 47.7) — the dense read-out is the one that prefers raw diversity, which is consistent with the term-decomposition above (dense structure is bought by the patch loss and by data variety, not by concept balance). Second, and the paper does not raise it: **the retrieval seeds are the train splits of the evaluation benchmarks.** ADE20k, Cityscapes, KITTI, NYUd, Oxford, Paris, Met and AmsterTime all appear in the "retrieving pretraining data" column. Near-duplicates of test splits are removed, so this is not leakage, but the pretraining distribution is *defined as the neighbourhood of the eval distributions* — which makes "general-purpose features" a claim resting on the rows that were untouched by curation (iNaturalist, Places205, and the three video benchmarks), where the model does still win.

---

## Distillation: the small models are not trained

ViT-L/14 distilled from ViT-g/14 beats ViT-L/14 trained from scratch on **12/12** benchmarks. The procedure is the training loop with the teacher replaced by a frozen larger model, masking and stochastic depth removed, and the *EMA of the student* kept as the final model. Two consequences:

- The wiki's teacher–student vocabulary ([[wiki/concepts/generalization-optimized-consolidation.md]]) gets a machine instance where the direction is the interesting one: a *smaller* net trained on a *larger* net's outputs beats the same net trained on the data, so what the teacher supplies is not capacity but a target distribution that is easier to fit than the objective it came from.
- Every DINOv2-S/B/L number in this wiki — including the ones it is used as a baseline for — is a distillation result and not an independent training run. The architecture-vs-objective attribution that [[wiki/concepts/objective-identifiability.md]] warns about has a third confound here: *which model in the family the features came from*.

---

## Limitations

- **No temporal objective, and it still wins on video.** Frames are averaged (or concatenated for SSv2) and a linear classifier is fitted. That it beats OpenCLIP-G on SSv2 by 2.5 says more about the caption channel's weakness than about DINOv2's motion content — and V-JEPA 2's controlled encoder swap has DINOv2 *last* of four on temporal video QA (45.7 average vs 52.3), which is where the missing temporal objective shows ([[wiki/entities/v-jepa-2.md]]).
- **No decoder, no generative model, no predictor kept.** It is an encoder; there is no `p(x)`, no rollout, no way to ask what an embedding looks like except by `k`-NN. Everything downstream that uses it as a world-model backbone (DINO-WM) supplies its own dynamics.
- **Instances are not individuated** (above) — a representational commitment made by the objective at pretraining time.
- **Geographic and income bias remains large.** Dollar Street: Africa 74.0 vs Europe 89.7, low income 67.4 vs high income 90.5. Better than SEERv2 on every cell and still heavily Western-skewed — the curation pipeline balances *visual clusters*, which is not the same as balancing the world. (The prose reports these gaps as 25.7% and 31.7% where its own table gives 15.7 and 23.1 absolute points; the two are not reconciled in the paper.)
- **Every ablation is a single ImageNet-scale training run.** No seeds, no error bars, on a table whose increments are 0.1–0.5 points.
- **The curation pipeline needs a pretrained encoder to start.** It is bootstrapped from an ImageNet-22k ViT-H/16, so "no supervision" holds for the training objective and not for the dataset's definition.

---

## Comparison

| | **DINOv2** | [[wiki/entities/byol.md]] | [[wiki/entities/barlow-twins.md]] / [[wiki/entities/vicreg.md]] | [[wiki/entities/lewm.md]] | OpenCLIP |
|---|---|---|---|---|---|
| Target | EMA teacher's prototype distribution | EMA teacher's projection | the other view's embedding | its own future embedding | the other modality |
| Negatives | no | no | no | no | in-batch captions |
| Predictor on one branch | **no** | yes | no | yes (world model) | no |
| Anti-collapse provision | **teacher-output normalisation** (centering / Sinkhorn–Knopp) + KoLeo entropy term | update-rule asymmetry | variance + covariance terms | SIGReg | negatives |
| Certifiable minimum | no | no | yes | yes | yes |
| Extra terms and what they buy | MIM → dense; KoLeo → metric | — | — | — | — |
| Read-outs demonstrated frozen | classification, retrieval, segmentation, **depth** | classification, transfer | classification, transfer | control/planning | classification |

**Where it sits in the wiki's argument.** DINOv2 is the encoder against which the end-to-end JEPA case is made ([[wiki/empirical-tensions.md]] T154): its ~142M-image corpus is the "foundation-scale pretraining" LeWM's 15M pixel model is claimed to be unnecessary against, and its patch-token grid is the ~200× token count that makes DINO-WM ~48× slower to plan with. Having the primary source changes one thing about that comparison — the corpus is not merely large, it is *shaped*, and the shaping is worth more than the count.

---

## Connections

- **[[wiki/concepts/energy-based-models.md]]** — adds a fifth anti-collapse locus to that page's taxonomy and it is neither a term nor an update rule: a **normalisation of the teacher's output distribution** (running-mean centering, or Sinkhorn–Knopp equipartition over the batch's prototype assignments), sitting where Barlow Twins' batch standardisation sits but applied to the target rather than to the loss's input.
- **[[wiki/concepts/retrieval-capacity.md]]** — supplies the term that buys the read-out that page bounds: KoLeo maximises nearest-neighbour spacing and is worth +8.3 mAP on instance retrieval and ~0 on segmentation, so spreading features is specifically a purchase of inner-product-ranking quality, not a general representational virtue.
- **[[wiki/concepts/representation-probing.md]]** — a probe-choice confound with the recipe built on top of it: `k`-NN and linear top-1 rank four of this model's design decisions in opposite directions, and the authors selected components by `k`-NN on the assumption that linear is lower-bounded by it.
- **[[wiki/concepts/linear-representation-hypothesis.md]]** — the engineering form of the hypothesis: fine-tuning the whole 1.1B backbone beats a single linear layer on frozen features by 2.0 points, and depth — a quantity never trained on — is linearly decodable from patch tokens.
- **[[wiki/concepts/shortcut-learning.md]]** — the coverage argument with a matched-size control: 142M curated images beat 142M uncurated ones from the same crawl by 14 points on ImageNet-A and iNat2018, so the purchase is made by the distribution and not by the count — and the curation loop is the model's own metric, which makes the pretraining distribution a neighbourhood of the eval distributions.
- **[[wiki/concepts/compositionality.md]]** — an emergent part vocabulary with no part supervision: PCA components of patch tokens align across pose, style and category (a plane's wing to a bird's wing), which is structural correspondence appearing in a model whose objective mentions only whole-image and masked-patch agreement.
- **[[wiki/concepts/subgraph-matching.md]]** — the matching operation run on learned features rather than on a graph: patch-to-patch assignment across two images of different objects recovers functionally corresponding parts, which is a label-free correspondence probe the wiki's instrument list does not have.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the sharpest test of that page's rate bound: a language-supervised encoder five times larger loses on all three depth benchmarks to a self-supervised one, and depth is exactly what a 77-token caption never carries.
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — a machine teacher–student instance where distillation beats direct training on 12/12 benchmarks at fixed architecture, so what the teacher transfers is a more fittable target than the objective it was itself trained on.
- **[[wiki/concepts/objective-identifiability.md]]** — three confounds stacked in one family: the small models are distilled rather than trained, the corpus is curated by the model's own metric, and the two auxiliary loss terms are invisible to the benchmark the family is ranked on.
- **[[wiki/entities/byol.md]]** — the same EMA-teacher skeleton with the asymmetry relocated: no predictor at all, collapse held off by normalising the teacher's output distribution instead, which shows BYOL's predictor is one implementation of the asymmetry rather than the asymmetry itself.
- **[[wiki/entities/barlow-twins.md]]** — the non-parametric counterpart to its Gaussian-proxy spread term: KoLeo estimates the embedding's differential entropy from nearest-neighbour spacing directly, at weight 0.1 and with no cross-GPU communication.
- **[[wiki/entities/vicreg.md]]** — the same distinction from the other side: a per-dimension variance hinge and an off-diagonal covariance penalty are second-moment surrogates for the quantity KoLeo estimates non-parametrically, and here that quantity is measured to matter for one read-out only.
- **[[wiki/entities/spelkenet.md]]** — this page's emergent-parts result and that page's instance-merging critique are the same objective seen twice: a discriminative loss that pulls category instances together buys correspondence *across* objects and forbids individuation *within* a category.
- **[[wiki/entities/v-jepa-2.md]]** — the controlled comparison that bounds this page's video results: with backbone frozen, alignment data and LLM held fixed, DINOv2 is last of four encoders on temporal video QA, which localises the deficit in the missing temporal objective rather than in scale.
- **[[wiki/entities/lewm.md]]** — the entity whose whole argument is against this one: DINO-WM builds on these frozen patch tokens, and a 15M end-to-end pixel JEPA beats it under matched FLOPs and plans ~48× faster, so the question this page's corpus poses is whether the amortisation is worth its token count ([[wiki/empirical-tensions.md]] T154).
- **[[wiki/concepts/learned-world-models.md]]** — the frozen-encoder branch's backbone: every world model in the wiki that does not train its own encoder trains on these features, so their invariances (category-merged instances, no temporal structure) are inherited by the dynamics fitted on top.
- **[[wiki/entities/dinov3.md]]** — the successor, and the qualification of this page's central ablation: `L_iBOT` buys dense structure but does not hold it, so at 7B and 1M iterations the dense read-outs decay under the same objective that keeps improving the global ones — fixed by a term on the patch-**similarity matrix** anchored to an earlier iterate of the model itself, and closing this page's standing SSL deficits on ImageNet-R/Sketch and ObjectNet while widening the instance-retrieval lead.
- **[[wiki/entities/i-jepa.md]]** — the augmentation-free head-to-head, and the clearest statement of what a hand-crafted view set buys: this page's lineage (DINO/iBOT) wins fine-grained category by ~10 points (iNat18 57.3 vs 47.6) and loses Clevr depth by 10–19, at >2.5× the compute per unit of encoder — the same read-out-purchase decomposition this page found term-by-term, found here augmentation-set-by-augmentation-set.
