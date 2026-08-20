# DINOv3

**A 7B-parameter self-supervised image encoder trained for 1M iterations on constant hyperparameter schedules, whose dense patch features *degrade over training* under the same objective that keeps improving its global ones — and whose fix is a loss on the patch-to-patch **similarity matrix** anchored to an earlier checkpoint of the model itself, leaving the features free to move as long as their relational structure holds.**

> **Provenance.** Siméoni, Vo, Seitzer, Baldassarre, Oquab et al. 2025, *DINOv3* (`raw/simeoni-2025-dinov3.md`), Meta AI Research / Inria / WRI. Technical report; models and code released. Successor to [[wiki/entities/dinov2.md]], and the first entry in the wiki where a self-supervised backbone kept **frozen** sets the state of the art on COCO detection and ADE20k segmentation against fully fine-tuned specialist pipelines.

---

## What is new relative to DINOv2

| | [[wiki/entities/dinov2.md]] | **DINOv3** |
|---|---|---|
| Backbone | ViT-g/14, 1.1B, learnable pos. emb. | **ViT-7B/16**, 6.7B, 40 blocks, embed 4096, 32 heads × 128, SwiGLU 8192, **axial RoPE**, 4 registers |
| Prototypes | 128k DINO / 128k iBOT, heads untied | **256k** DINO / **96k** iBOT, heads untied, MLPs 8192-8192-512 / -384 |
| Teacher normalisation | centering **or** Sinkhorn–Knopp | **Sinkhorn–Knopp in both objectives** (centering dropped) |
| Schedules | cosine on LR, WD, EMA momentum — horizon fixed in advance | **constant** LR, WD, EMA momentum; warmup only on LR and teacher temperature |
| Pretraining loss | `L_DINO + L_iBOT + 0.1·L_KoLeo` | same shape: `L_Pre = L_DINO + L_iBOT + 0.1·L_DKoleo`, KoLeo made **distributed** in sub-batches of 16 across GPUs |
| Corpus | LVD-142M, curated by retrieval from seed datasets | **LVD-1689M** — hierarchical `k`-means over a 17B Instagram pool (5 levels: 200M/8M/800k/100k/25k clusters) + retrieval curation + raw ImageNet-1k/22k/Mapillary |
| Batch composition | homogeneous | **10% homogeneous ImageNet-1k batches, 90% heterogeneous mixture** |
| Second training phase | none | **Gram anchoring** refinement, then high-resolution adaptation |
| Small models | distilled from ViT-g | distilled from ViT-7B, **multiple students in parallel**, and across architecture families (→ ConvNeXt) |

One micro-detail worth carrying because it is cheap and not in DINOv2: a **dedicated LayerNorm on the backbone outputs of local versus global crops** — +0.2 `k`-NN, +1 mIoU ADE20k, −0.02 RMSE NYUv2. The global/local asymmetry is worth normalising away separately.

**Data ablation** (200k-iteration runs, showing no single curation objective dominates):

| Corpus | IN1k `k`-NN | IN1k linear | ObjectNet | iNat2021 | Paris retrieval |
|---|---|---|---|---|---|
| Raw pool | 80.1 | 84.8 | 70.3 | 70.1 | 63.3 |
| Clustering only | 79.4 | 85.4 | **72.3** | 81.3 | 85.2 |
| Retrieval only | 84.0 | 86.7 | 70.7 | 86.0 | 82.7 |
| **Mixture (LVD-1689M)** | **84.6** | **87.2** | **72.8** | **87.0** | **85.9** |

Clustering buys balance/robustness (ObjectNet, retrieval-benchmark coverage), retrieval buys `k`-NN and fine-grained recognition, and the two are additive. This is the same *read-out-purchase* structure DINOv2 found term-by-term, found here corpus-by-corpus.

---

## The result the wiki did not predict: dense features collapse *during* training

Training the 7B for 1M iterations with a fixed, non-diverging loss:

| Read-out | Trajectory over 1M iterations |
|---|---|
| ImageNet-1k linear probe on the CLS token | **monotone increase throughout** |
| Pascal VOC linear probe on patch tokens (mIoU) | rises to ~200k, then **declines**; for the ViT-7B it ends **below its own early value** |
| Patch–patch cosine similarity maps | smooth and well-localised at 200k; by 600k a growing set of *irrelevant* patches scores high against the reference patch |
| Patch feature **norms** | **stable** — the registers work; this is not the high-norm-outlier artifact |
| CLS-token ↔ patch-token cosine similarity | **increases steadily** — patch tokens drift toward the global token, and locality is what is lost |

Also observed in the ViT-g (to a lesser extent), and in an independent 7B DINO scaling effort (Web-DINO), which posts the worst dense numbers of any model compared here (ADE20k 42.7 at 7B/14, versus DINOv2 ViT-g's 49.5). **Scaling a DINOv2-style recipe without addressing this makes the dense read-outs worse, not better.**

**Why this is a structural result and not an engineering nuisance.**

1. **The objective is being descended the whole time.** Nothing collapses in the sense the wiki's collapse taxonomy defines ([[wiki/concepts/energy-based-models.md]]): no term goes flat, no encoder emits a constant, the certifiable properties of `L_DINO + L_iBOT` are intact. What degrades is a *property of the representation that no term in the loss measures*.
2. **The patch-level term is present throughout and does not prevent it.** DINOv2's ablation attributed dense structure to `L_iBOT` (−2.9 mIoU when removed). That attribution survives — but the term buys dense structure without *holding* it, because the term is a cross-entropy against per-patch prototype assignments, not a constraint on how patches relate to one another.
3. **The two objectives are measurably independent.** The paper reports "a relative independence between learning strong discriminative features and maintaining local consistency" — the global and dense metrics are uncorrelated across the run — with the global term dominating as training proceeds. The failure is one objective winning a competition the loss never states.

This is the wiki's first observation of **partial, read-out-specific collapse under a well-defined objective**, and it is a direct qualification of T164 (see [[wiki/empirical-tensions.md]] T168).

---

## Gram anchoring: a loss on the relations, not on the features

Let `X_S`, `X_G ∈ R^{P×d}` be the ℓ₂-normalised patch features of the student and of a **Gram teacher** for one image of `P` patches. Then

```
L_Gram = ‖ X_S X_Sᵀ − X_G X_Gᵀ ‖_F²
```

and the refinement objective is `L_Ref = w_D·L_DINO + L_iBOT + w_DK·L_DKoleo + w_Gram·L_Gram`, on global crops only.

| Design choice | Statement and evidence |
|---|---|
| **The constrained object is the Gram matrix** | All `P²` pairwise dot products. The features themselves are **free to move** provided the structure of similarities is preserved — an invariance to any rotation of the patch code |
| **The teacher is the model's own past** | An **early** iterate (100k–200k) of the EMA teacher, which is *worse globally and better densely*. 100k and 200k are interchangeable; a **1M-iteration** Gram teacher is **detrimental**, because its own patch consistency is already degraded |
| **The teacher is refreshed** | Reset to the current EMA teacher every 10k iterations, so the anchor tracks the run rather than pinning it to a fixed past |
| **It repairs, it does not merely prevent** | Applied only *after* 1M iterations — i.e. onto already badly degraded features — dense-task gains appear **within the first 10k iterations** |
| **The teacher may be run at a different scale than the student** | Feed the Gram teacher images at **2× resolution**, then bicubic-downsample its feature map 2× to match the student. Higher-resolution patch consistency survives the downsampling; distilling it is worth a further **+2 mIoU on ADE20k** (`L_HRef`) |
| **It partitions the objectives** | Adding `L_Gram` makes the **iBOT** loss fall faster and leaves the **DINO** loss essentially unchanged — evidence that Gram and iBOT act on the features the same way and the image-level term acts differently |
| **It is required at high resolution too** | Without Gram anchoring in the 10k-iteration high-resolution adaptation phase, dense performance "degrades significantly" |

**Where this sits in the anti-collapse taxonomy.** Every locus the wiki has catalogued — negatives, variance/covariance terms, distribution matching, an update-rule asymmetry, a normalisation of the teacher's output distribution — constrains the *embedding of a single item*. Gram anchoring constrains the **second-order structure over a set of items within one input**, and its target is supplied by the same network at an earlier time. It is the first entry in the taxonomy whose target is neither the data, nor another view, nor a fixed distribution, but **the model's own earlier relational geometry**.

**(brainstorm) The `g`/`x` reading, which is why this matters beyond vision.** Gap **G30** asks for a quantity that is high when a structural code is intact and indifferent to the content filling it. `L_Gram` is not that quantity — it says nothing about path consistency and it needs a reference model — but it is the closest object in the wiki to the *shape* of one: a differentiable, label-free penalty on **relations between elements**, invariant to any transformation that preserves inner products, and demonstrably trainable jointly with a content objective that would otherwise destroy the relations. The measured behaviour is the one the `g`/`x` factorisation wants: the content code kept improving (ImageNet monotone up), the relational code was being eaten, and a term on the relations alone recovered it in 1% of the training budget without costing the content code. Read against [[wiki/concepts/population-geometry.md]], `X X^T` is a representational-similarity matrix — the wiki's standard *measurement* instrument for comparing two systems' geometry — used here as a **training target**, which is a move the wiki has not otherwise recorded.

**(brainstorm) The consolidation reading.** A slowly-refreshed copy of an earlier self, replayed against the current self to protect a structure the online objective is eroding, is the functional shape of [[wiki/concepts/generalization-optimized-consolidation.md]] and of a replay-based continual-learning constraint ([[wiki/concepts/continual-learning.md]]) — with the difference that what is rehearsed is not data and not weights but a **similarity structure**. That makes it a functional-regularisation method in a setting nobody calls continual learning: the "tasks" are the two read-outs, presented simultaneously, and one of them is forgetting.

---

## Post-training

| Stage | Content |
|---|---|
| **Resolution scaling** | 10k iterations with **mixed resolutions** — global crops ∈ {512, 768}, local ∈ {112, 168, 224, 336}. Gram anchoring (7B as its own Gram teacher) is essential here. Afterwards local features **improve with input size**, and feature maps stay stable at resolutions above **4096**, far beyond the 768 training maximum — attributed to RoPE plus **RoPE-box jittering**: patch coordinates in a `[−1,1]` box randomly rescaled to `[−s,s]`, `s ∈ [0.5, 2]` |
| **Distillation** | Teacher is the **fixed** 7B (not an EMA), same objective, **no Gram anchoring needed** — the consistency problem does not appear in students. ViT-S (21M), S+ (29M), B (86M), L (0.3B), H+ (0.8B), plus ConvNeXt T/S/B/L. **Multi-student parallel pipeline**: run teacher inference once on the union of all GPUs, all-gather, then each student group trains — adding a student *lowers* per-GPU cost and adds only that student's training compute |
| **Text alignment** | dino.txt recipe (LiT): backbone **frozen**, train a text encoder from scratch, two transformer layers on the vision side, and match text against the **concatenation of the CLS token and the mean-pooled patch embeddings** — which is what buys dense open-vocabulary segmentation |

**The distillation result that matters:** ViT-H+ (0.8B) is **on par with the 8× larger 7B teacher**, and DINOv3 ConvNeXt models — no CLS token, no attention — inherit the 7B ViT's features across an architecture-family boundary, beating ImageNet-22k-supervised ConvNeXts by **+17.9 mIoU (CNX-T)** and **+14.5 (CNX-L)** on ADE20k. The supervised baselines *degrade* from resolution 256 to 512 while the distilled ones improve.

---

## Results — all with the backbone frozen

**Dense read-outs, linear probe on frozen patch tokens:**

| | DINOv3 7B/16 | DINOv2 g/14 | AM-RADIOv2.5 g/14 | PEspatial G/14 | SigLIP 2 g/16 | PEcore G/14 |
|---|---|---|---|---|---|---|
| ADE20k mIoU | **55.9** | 49.5 | 53.0 | 49.3 | 42.7 | 38.9 |
| Cityscapes mIoU | **81.1** | 75.6 | 78.4 | 73.2 | 64.8 | 61.1 |
| NYUv2 RMSE ↓ | **0.309** | 0.372 | 0.340 | 0.362 | 0.494 | 0.590 |
| NAVI geometric correspondence | **64.4** | 60.1 | 59.4 | 53.8 | 49.4 | 39.9 |
| SPair semantic correspondence | **58.7** | 56.1 | 56.8 | 49.6 | 42.6 | 23.1 |
| DAVIS tracking `J&F` (large res.) | **83.3** | 76.6 | 81.4 | 70.5 | 62.9 | 49.8 |

Two things in that table are load-bearing beyond the ranking. **AM-RADIOv2.5 and PEspatial are distilled from SAM / SAM 2 — i.e. from mask supervision — and lose to a purely self-supervised model on every dense row.** And **DINOv3 is the only model whose tracking score rises monotonically with resolution**; PEspatial *falls* from 74.5 to 70.5 on DAVIS between medium and large.

**Global read-outs:**

| | DINOv3 7B | DINOv2 g | PEcore G | SigLIP 2 g | ViT-22B (supervised) |
|---|---|---|---|---|---|
| ImageNet-1k linear val / V2 / ReaL | 88.4 / **81.4** / 90.4 | 87.3 / 79.5 / 89.9 | **89.3** / 81.6 / 90.4 | 89.1 / 81.6 / 90.5 | 89.5 / 83.2 / 90.9 |
| ImageNet-R / Sketch | 91.1 / 71.3 | 81.1 / 65.4 | 92.2 / 71.9 | 92.2 / 71.8 | 94.3 / — |
| ImageNet-A / -C ↓ / ObjectNet | 86.9 / **19.6** / 79.0 | 81.7 / 24.1 / 66.4 | **89.0** / 22.7 / **80.2** | 84.6 / 30.0 / 78.6 | 83.8 / — / 74.3 |
| Oxford-Hard / Met / AmsterTime retrieval | **60.7** / **55.4** / **56.5** | 58.2 / 44.6 / 48.9 | 27.1 / 0.5 / 18.9 | 32.7 / 10.6 / 23.1 | — |
| iNat2021 | **89.8** | 86.1 | 87.0 | 82.7 | — |

**This is the first time a self-supervised model reaches parity with weakly- and fully-supervised models on classification** — 0.7–0.9 points behind on ImageNet-val, *level* on the cleaner V2 and ReaL splits, and best-in-table on corruptions. The wiki's DINOv2 entry recorded the language-supervised advantage on ImageNet-R/Sketch as a standing SSL deficit; it is now ≈1 point. **The instance-retrieval gap widens rather than closes** — Met 55.4 vs 0.5 for PEcore is a factor the caption channel simply does not carry ([[wiki/concepts/cross-modal-grounding.md]]).

**Frozen backbone as a system component** — the section that changes what "frozen" is worth:

| Task | System | Trainable params | Result | Previous best |
|---|---|---|---|---|
| COCO detection | frozen 7B + Plain-DETR (encoder kept outside the backbone) | **100M** | **66.1 mAP** (TTA); **COCO-O 66.4 mAP, ER 36.8** | EVA-02+Co-DETR 65.9 fine-tuned, 300M trainable; COCO-O 63.7 / 34.3 |
| ADE20k segmentation | frozen 7B + ViT-Adapter (**injector removed**) + Mask2Former | 927M decoder | **63.0 mIoU** | ONE-PEACE 63.0 with 2.2B trainable |
| Relative monocular depth | frozen 7B + DPT, Depth Anything V2 pipeline and losses | DPT head | NYUv2 4.3 ARel / 98.0 δ₁; KITTI 7.3 / 96.7; ETH3D 5.4 / 97.5; ScanNet 4.4 / 98.1 | DAv2 (fine-tuned ViT-g) 4.4 / 97.9, 7.5 / 94.7, 13.1 / 86.5 |
| 3D geometry (VGGT) | DINOv3 ViT-L swapped for DINOv2 ViT-L, pipeline unchanged | — (backbone fine-tuned here) | Re10K 86.3, CO3Dv2 89.6, DTU 0.368, ScanNet-1500 AUC@5 35.2 | VGGT 85.3, 88.2, 0.382, 33.9 |
| Video classification (attentive probe) | frozen 7B, per-frame features | 4-layer transformer | SSv2 70.8, K400 88.2, UCF101 93.5 | V-JEPA 2 g/16: **SSv2 75.4**, K400 84.3 |

*"To the best of our knowledge, this makes it the first competitive detection model to use a frozen backbone."* Depth is the sharper claim: the Depth Anything V2 pipeline's whole premise is that DINOv2 features bridge the **sim-to-real** gap (SAM's do not); swapping in DINOv3 **and freezing it** beats the fine-tuned original everywhere.

**Object discovery — a fourth read-out that dissociates from the other three.** With TokenCut on output features, **DINOv2 fails at unsupervised object discovery** despite its strong dense linear probes, which the paper attributes to feature-map artifacts; DINOv3 beats both DINO and DINOv2 (+5.9 CorLoc on VOC07). So "dense linear-probe quality" and "the feature graph partitions into objects" are **different properties**, and the parametric probe cannot see the difference — a non-parametric read-out can ([[wiki/concepts/representation-probing.md]]).

**Domain generality.** The identical recipe on **SAT-493M** (493M 512×512 Maxar images at 0.6 m, RGB mean/std the only change): 100k pretrain + 10k Gram + 8k high-res. Frozen, RGB-only, it sets the state of the art on **12 of 15** Earth-observation tasks against DOFA and Prithvi-v2, which use 6+ spectral bands *and* task-specific fine-tuning. Canopy-height MAE 2.42 → **2.02** on Open-Canopy. The split that matters: **the satellite model wins the metric task (canopy height), the *web* model wins the semantic ones** (GEO-Bench segmentation mean 75.9 vs 75.0; iSAID 71.4 vs 64.8; DIOR 80.5 vs 76.6). Domain-specific pretraining buys sensor-specific radiometric priors; it does not buy semantics, which transfer from a corpus with no satellites in it.

---

## Limitations

- **The temporal deficit is unchanged.** V-JEPA 2 still wins SSv2 by 4.6 points with an 8× smaller model. Appearance-driven video benchmarks (UCF101, K400) do not separate the models; the motion-driven one does, and no image objective closes it ([[wiki/entities/v-jepa-2.md]]).
- **Gram anchoring is not ablated as an objective.** `w_Gram` is never swept, `L_Gram` is never compared against alternative relational penalties (e.g. the neighbour-ordering objective of the cited prior work), and the choice of Frobenius norm on the Gram matrix is asserted rather than tested. The wiki knows the mechanism works and does not know which of its parts is load-bearing.
- **It requires a second network and a hand-picked checkpoint.** The Gram teacher is an extra forward pass at 2× resolution, and the *usable window* for the anchor (100k–200k good, 1M harmful) is discovered empirically. A method whose safety device must be harvested before the failure it prevents has begun is awkward to deploy on a first run of anything new.
- **Every number below 7B is a distillation result.** As with DINOv2 — worse here, since the family now spans two architecture families, so ConvNeXt results say nothing about training ConvNeXts self-supervised.
- **The corpus is 1.7B images from Instagram**, unreleasable, and curated with DINOv2 embeddings — so the bootstrap dependency of the DINOv2 page is now a *generational* one: each model's corpus is defined by its predecessor's metric.
- **Instances are still not individuated** and there is still no decoder, no `p(x)`, no dynamics — everything downstream supplies its own ([[wiki/entities/spelkenet.md]], [[wiki/concepts/learned-world-models.md]]).
- **Cost.** 61,440 H100-hours (47 MWh, 18 tCO₂eq) for the 7B pretrain alone; ~9M GPU-hours and ~2600 tCO₂eq for the project. Against DINOv2's 3.7 tCO₂eq, the dense-feature fix arrives with a ~5× per-model and ~700× per-project multiplier.

---

## Comparison

| | **DINOv3** | [[wiki/entities/dinov2.md]] | [[wiki/entities/i-jepa.md]] | [[wiki/entities/v-jepa-2.md]] | [[wiki/entities/barlow-twins.md]] / [[wiki/entities/vicreg.md]] |
|---|---|---|---|---|---|
| Anti-collapse provision | teacher-output normalisation (Sinkhorn–Knopp) + KoLeo + **Gram anchor on `XXᵀ`** | teacher-output normalisation + KoLeo | none (EMA + narrow predictor) | EMA + predictor | variance + covariance terms |
| What the provision constrains | **pairwise similarity structure within one input** | the target's marginal over prototypes | — | — | per-dimension statistics across a batch |
| Target supplied by | **the model's own earlier iterate** | the current EMA teacher | current EMA teacher | current EMA teacher | the other view |
| Failure it addresses | **read-out-specific degradation over training time** | full collapse | full collapse | full collapse | full collapse |
| Certifiable minimum | no (anchor is a moving reference) | no | no | no | yes |
| Frozen-backbone SOTA demonstrated | **detection, segmentation, depth, 3D** | depth, segmentation (probe-level) | classification | video QA | classification |

---

## Connections

- **[[wiki/entities/dinov2.md]]** — the direct predecessor, and the model whose ablation this page qualifies: DINOv2's `L_iBOT` was shown to *buy* dense structure (+2.9 mIoU), and DINOv3 shows the same term does not *hold* it — the dense read-out decays over 1M iterations while the term is being minimised, because a per-patch prototype cross-entropy constrains each patch and not the relations among them.
- **[[wiki/concepts/energy-based-models.md]]** — a sixth anti-collapse locus, and the first that constrains **second-order structure over a set of tokens within one input** rather than the embedding of a single item, with its target supplied by the network's own earlier iterate rather than by data, another view or a fixed distribution.
- **[[wiki/concepts/population-geometry.md]]** — takes that page's representational-similarity matrix, the wiki's standard instrument for *comparing* two systems' geometry, and uses it as a **training target**: `‖X_S X_Sᵀ − X_G X_Gᵀ‖_F²` optimises a system toward another system's similarity structure while leaving its features free up to any inner-product-preserving transformation.
- **[[wiki/concepts/representation-probing.md]]** — two probes of one frozen encoder move in **opposite directions along the training run** (ImageNet linear monotone up, VOC patch-linear peaking at 200k and falling below its start), and a third — non-parametric graph partitioning for object discovery — fails on DINOv2 where the parametric dense probe succeeds; so probe choice decides not only which model looks better but which *checkpoint* does.
- **[[wiki/concepts/continual-learning.md]]** — a stability–plasticity failure inside a single stationary pretraining run: nothing about the data distribution changes, and one read-out is nonetheless overwritten by another, with the repair taking the shape of functional regularisation against a stored earlier self rather than parameter- or data-level rehearsal.
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — the teacher–student direction inverted in time rather than in size: the teacher is the *same network 800k steps earlier*, worse on the metric being optimised and better on the one being lost, and 10k steps of anchoring to it repairs damage accumulated over 800k.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the closest thing the wiki holds to a trainable objective for the relational half of the `g`/`x` split: a label-free penalty on relations between elements, invariant to any transformation preserving inner products, measured to protect relational structure without costing the content code that was destroying it (gap G30).
- **[[wiki/entities/i-jepa.md]]** — the other half of the same lesson about what a loss does not see: I-JEPA showed the pair *sampler* moves the representation further than the anti-collapse term does; DINOv3 shows the *training horizon* does too, and neither is a coefficient in anyone's objective.
- **[[wiki/entities/v-jepa-2.md]]** — bounds this page's video results from the same direction it bounded DINOv2's: frozen per-frame features plus an attentive probe reach 88.2 on appearance-driven K400 (beating V-JEPA 2 by 3.9) and lose SSv2 by 4.6, so scale and dense-feature quality do not substitute for a temporal objective.
- **[[wiki/entities/spelkenet.md]]** — the instance-merging critique survives the upgrade: cleaner, sharper patch features improve *object discovery* (a class-agnostic partition) without giving the encoder any way to individuate two instances of one category, which is a commitment of the discriminative objective and not of the feature map's resolution.
- **[[wiki/entities/lewm.md]]** — sharpens T154 from the amortisation side: a frozen backbone now beats fine-tuned specialists on detection, segmentation and depth with a 100M-parameter head, so the cost of the foundation-encoder route is entirely front-loaded and the argument against it has to be made on planning-time token count alone.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the rate argument's widest margin yet: on Met instance retrieval the best language-supervised encoder scores **0.5** GAP against 55.4, and on dense correspondence PEcore reaches 23.1 SPair recall against 58.7 — while the *same* encoder family beats DINOv3 on ImageNet-A. Captions carry category and carry neither identity nor geometry.
- **[[wiki/concepts/learned-world-models.md]]** — the frozen-encoder branch's backbone upgraded: VGGT's 3D estimates improve on all four metrics from swapping DINOv2 for DINOv3 with the pipeline otherwise unchanged, so the geometry available to a downstream world model is set by the encoder's patch consistency.
- **[[wiki/concepts/shortcut-learning.md]]** — the curation argument at 12× scale, now with the two curation objectives separated: clustering buys balance and robustness, retrieval buys `k`-NN and fine-grained recognition, and neither dominates — a corpus is a mixture of purchases, not a size.
- **[[wiki/entities/lejepa.md]]** — two disagreements at once: it trains ViT-L to ViT-g without register tokens (0–8 registers span 0.7 points) and attributes their necessity here to a poorly conditioned objective; and its label-free loss↔accuracy signal (`ρ_s` up to 0.99), which is the monitor T168 asks for, is calibrated against *global* probes — precisely the read-out that stayed healthy here while the dense one decayed, so it is untested on the failure it would be used to catch.
- **[[wiki/concepts/representational-collapse.md]]** — locus 6, and partial collapse: the failure the taxonomy could not see, where a read-out degrades over 1M iterations while every term is being correctly minimised.
