# SSL Transfer Benchmark (Ericsson et al. 2021) — 13 self-supervised encoders, one backbone, 40 downstream tasks, read out at two depths

**Ericsson, Gouk & Hospedales 2021, CVPR** (`raw/ericsson-2021-how-well-self-supervised-models-transfer.md`). Thirteen published Self-Supervised Learning (SSL) encoders plus a supervised baseline, **all ResNet-50(1×), 23.5 M backbone parameters, all pre-trained on the same ImageNet-1k train split**, evaluated on 40 downstream tasks under a fixed protocol. Architecture and pre-training data are held constant, so the only free variable is the *objective and its augmentation list*.

Why it earns a page: it is the wiki's only source that runs the **same encoder set through two read-out depths on the same tasks**, which is the exact measurement [[wiki/empirical-tensions.md]] `T310` was opened on and which [[wiki/entities/mae.md]] supplies for one pair of methods only. Everything else here is secondary to that.

---

## The suite

| Block | Datasets | Read-out | Metric |
|---|---|---|---|
| Many-shot recognition | *Kornblith set*: Aircraft, Caltech-101, Cars, CIFAR-10/100, DTD, Flowers, Food-101, Pets, SUN397, VOC2007 (11) | Multinomial logistic regression on frozen features **and** full fine-tuning (5,000 SGD-Nesterov steps) | top-1 (mAP for VOC) |
| Few-shot recognition | Kornblith minus VOC (10) + CD-FSL: CropDiseases, EuroSAT, ISIC2018, ChestX (4) | Nearest-centroid (Prototypical Networks) on frozen features; 5-way {5,20,50}-shot, 600 episodes | accuracy ± 95% CI |
| Detection | PASCAL VOC (`trainval07`+`trainval12` → `test2007`) | Faster R-CNN + Feature Pyramid Network, backbone **frozen** (all but last residual block) **and** fully fine-tuned | AP, AP50, AP75 |
| Dense prediction | NYUv2 surface normals (PSPNet); ADE20K semantic segmentation (UPerNet) | fine-tuned | angular error / % within 11.25°, 22.5°, 30°; mean IoU, pixel accuracy |

**Encoders.** Contrastive: InsDis (NPID), MoCo-v1/v2, PIRL, SimCLR-v1/v2, InfoMin, BYOL. Clustering: PCL-v1/v2, SeLa-v2, DeepCluster-v2, SwAV. Baseline: torchvision supervised ResNet-50. Pre-training length, augmentation list and loss differ per method and are **not** controlled — the paper's own stated limitation.

---

## The load-bearing result: read-out depth is not a monotone rescaling of the ranking

The paper reports both rankings and never correlates them with each other. **Computed here from its Table 1 and Table 4** (`(brainstorm)` only in the sense that the arithmetic is the wiki's, not the authors'; the inputs are their published numbers):

| Task block | Frozen vs. adapted read-out, over all 14 encoders | Spearman `ρ` | Pearson `r` |
|---|---|---|---|
| Many-shot recognition, 11-dataset average | linear probe vs. full fine-tune | **0.736** | 0.736 |
| VOC detection, AP | frozen backbone vs. full fine-tune | **0.174** | **−0.007** |

Largest individual displacements:

| Encoder | Recognition: probe rank → fine-tune rank | Detection: frozen rank → fine-tune rank |
|---|---|---|
| MoCo-v2 | 8 → 4 | **13 → 1** (2nd best frozen, **worst** fine-tuned; AP 54.22 → 44.74) |
| InfoMin | 7 → 5 | **12 → 2** (AP 53.45 → 44.92) |
| SimCLR-v2 | 11 → 7 | 14 → 8 (best frozen, mid fine-tuned) |
| SeLa-v2 | **6 → 12** | 2 → 5 |
| PCL-v1 | **1 → 6** (worst probe, mid fine-tune) | 7 → 13 |
| BYOL | 12 → 10 | 11 → **14** |
| DeepCluster-v2 / SwAV | 14 → 14 / 13 → 13 | 3 → 7 / 6 → 9 |

*(rank 1 = worst, 14 = best.)*

**Reading.** The frozen probe is not uniformly invalid and not uniformly valid — its validity is a function of *how far the downstream task is from the pre-training task*. On many-shot recognition it preserves roughly three-quarters of the rank information; the top of the table (DeepCluster-v2, SwAV, BYOL) is stable across depth, and the mid-field is not. On detection it preserves **none**: the frozen-AP and fine-tuned-AP orderings are statistically unrelated, and the two methods that look best frozen are the two worst adapted. This generalises `T310`'s evidence base from one pair of encoders on one architecture to fourteen encoders on two task families, and it converts the tension from "does the instrument invert?" to "**on which tasks is the instrument valid at all?**".

---

## The second instrument result: ImageNet top-1 stops predicting transfer as the task shifts

Pearson `r` and Spearman `ρ` between logit-transformed ImageNet top-1 and logit-transformed downstream performance (the paper's Fig. 2, reported qualitatively there):

| Downstream block | Correlation with ImageNet top-1 |
|---|---|
| Many-shot recognition | high |
| Few-shot, low domain shift (Kornblith) | fairly strong |
| Few-shot, high domain shift (CropDiseases, EuroSAT, ChestX) | weaker but present |
| Few-shot, ISIC2018 (skin lesion; unstructured texture, least object-like) | **absent** |
| Detection | present; AP50 strongest, **frozen correlates better than fine-tuned** |
| Surface normals | weak but clear |
| Semantic segmentation (ADE20K) | weak; **non-existent for ranks** |

Two nulls worth carrying separately. PCL-v1 is the *worst* recognition encoder in the suite (linear avg 56.73, last of 14) and the *best* ADE20K segmenter (mIoU 0.2983, 75.00% pixel accuracy). The supervised baseline is among the worst on both dense tasks (mIoU 0.2563) while winning ImageNet top-1 (77.20). So the single scalar the SSL field optimises is, for spatially sensitive tasks, near-orthogonal to the thing it is used to predict.

---

## Headline transfer numbers

| Setting | Best SSL | Supervised | Note |
|---|---|---|---|
| Many-shot linear, 11-dataset avg | DeepCluster-v2 **78.92** (SwAV 77.97, BYOL 77.05) | 73.75 | SSL wins on all but one dataset; +10 abs. on Aircraft and Cars |
| Many-shot fine-tune, avg | DeepCluster-v2 **85.56** (SwAV 85.33, SeLa-v2 84.86) | 84.60 | margin nearly gone |
| Few-shot 5-way 20-shot, Kornblith | BYOL / DeepCluster-v2 | **wins on 8 of 10** | supervised wins by 5+ on Aircraft and Cars — the *reverse* of the many-shot linear result |
| Few-shot, CD-FSL (large domain shift) | DeepCluster-v2, SwAV, BYOL | beaten on all four | supervised advantage is specific to low domain shift |
| VOC detection AP | SimCLR-v2 **54.95** frozen / BYOL **54.91** fine-tuned | 51.99 / 53.26 | |
| NYUv2 normals, mean angular error | SimCLR-v2 **28.77** (BYOL 30.56) | 33.52 | SSL wins by 4–10% across metrics |
| ADE20K mIoU | PCL-v1 **0.2983** | 0.2563 | supervised near-worst |

**The one place supervision still wins is few-shot recognition at low domain shift** — the regime with the least adaptation *and* the least distribution shift, i.e. exactly where the frozen features are used raw on ImageNet-like data. That is a coherent picture with the depth result above: supervised features are pre-formatted for ImageNet-like linear separation, and the advantage evaporates as soon as either the read-out or the domain is allowed to move.

---

## What the features contain: two label-free probes

**Feature inversion** (deep image prior, encoder–decoder trained to match the frozen features), 14 models × 15 datasets:

- Supervised reconstructions are perceptually closest to the originals and have **markedly cleaner colour**; SSL reconstructions lose colour fidelity.
- Correlation of reconstruction quality with ImageNet top-1: perceptual (VGG) distance **−0.69**; colour error red **−0.56**, green −0.11, blue −0.22.
- The authors' conjecture: the heavy colour-distortion augmentations that every modern SSL method uses train colour-*invariant* features, so the information is discarded rather than reformatted.

**Occlusion-based, task-agnostic attention** (slide an occluder; per-pixel mean feature distance between clean and occluded encodings; summarised as the % of the attention map above its own mean):

- Supervised features attend to **smaller** regions; SSL features are attentively diffuse.
- Attentive diffusion correlates with ImageNet top-1 at **0.09** and with many-shot linear transfer at **0.38** — so it is a property the pre-training metric cannot see and transfer can.
- Qualitatively, on an aircraft image the supervised baseline attends mostly to the *sky*; SSL encoders attend to the aircraft. This is the authors' explanation for the supervised model's 10-point deficit on Aircraft and Cars under a linear probe, and they read it as **attentive overfitting** of label supervision.

---

## Calibration

Expected Calibration Error (ECE, 15 bins) over the two many-shot benchmarks, with and without post-hoc temperature scaling:

- **Unscaled linear:** several SSL encoders are significantly better calibrated than the supervised baseline.
- **Unscaled fine-tuned:** the supervised model is best.
- **After temperature scaling, fine-tuned:** supervised is surpassed by DeepCluster-v2 and SwAV.
- Strong **inverse** correlation of ECE with ImageNet top-1 — better SSL encoders are better calibrated downstream — weakened but not removed by temperature scaling.

The last two bullets are a mild qualification of [[wiki/concepts/confidence-calibration.md]]'s headline (the calibration defect is one scalar wide): a residual, *pre-training-strategy-dependent* calibration difference survives the scalar fit and even changes sign relative to it.

---

## Limitations

- **The encoders are not matched on anything but backbone and pre-training set.** Epoch budget, augmentation list, batch size, projector and loss all differ; a ranking difference cannot be attributed to the objective family.
- **No domain-specific SSL arm.** The paper cannot say whether ImageNet-pre-trained SSL beats SSL trained on the target domain — its own stated main limitation, and the question that decides whether "universal pre-training" is even the right frame.
- One architecture (ResNet-50), one pre-training corpus, vision only. The read-out-depth result is therefore convolutional-only; the [[wiki/entities/mae.md]] version of the same finding is ViT-only. Neither has been run on the other's substrate.
- The correlation figures (Fig. 1, 2, 3, 4) are reported graphically; only the numbers quoted above appear in the text.
- Only **two** read-out depths, so the "curve over read-out depth" repair `T310` proposes is still unrun by anyone — this source supplies its two endpoints on 14 encoders and nothing between them.

---

## Comparison to the wiki's other read-out-depth evidence

| | [[wiki/entities/mae.md]] (He et al. 2022) | This page (Ericsson et al. 2021) |
|---|---|---|
| Encoders compared | 2 (MAE, MoCo v3) | 14 |
| Backbone | ViT-L | ResNet-50 |
| Depth axis | **continuous** — 0, ½, 1, 4, … blocks unfrozen | two points — frozen, fully adapted |
| Recognition finding | ranking **inverts** at depth 1 | ranking largely survives (`ρ` = 0.74) with 5–6-place mid-field churn |
| Dense/detection finding | frozen loser wins COCO and ADE20K | frozen-vs-adapted AP ranking is **uncorrelated** (`ρ` = 0.17) |
| Together | | the effect is not architecture-specific, not method-pair-specific, and is **strongest where the downstream task is least like classification** |

---

## Connections

- **[[wiki/entities/mae.md]]** — the other half of the same measurement, on the axis this page lacks: MAE sweeps read-out depth continuously on two ViT encoders where this page takes two depths on fourteen ResNets, and the two agree that the frozen probe's ordering is a statement about format; together they are the evidence base for `T310`.
- **[[wiki/concepts/representation-probing.md]]** — supplies the adaptation-budget row's sample size: the probe-capacity problem stated there is here priced across 14 encoders and shown to be *task-conditional* rather than uniform, with `ρ` falling from 0.74 on recognition to 0.17 on detection.
- **[[wiki/concepts/representational-collapse.md]]** — every anti-collapse family on that page (contrastive, clustering, EMA) appears here under one backbone and one dataset, so the family comparison that page reports second-hand is available at matched architecture; and the read-out-depth result says the frozen numbers those comparisons use are only valid for recognition-like read-outs.
- **[[wiki/concepts/confidence-calibration.md]]** — pre-training strategy is a *downstream* calibration variable that survives temperature scaling, which is the first datapoint in the wiki against that page's "the whole defect is one scalar".
- **[[wiki/concepts/shortcut-learning.md]]** — the occlusion-attention result is a shortcut measurement without a cue conflict: label supervision concentrates attention on a smaller region (sky, not aircraft), and diffusion correlates with transfer (0.38) and not with the pre-training metric (0.09).
- **[[wiki/entities/byol.md]]**, **[[wiki/entities/dinov2.md]]**, **[[wiki/entities/barlow-twins.md]]**, **[[wiki/entities/simsiam.md]]** — the joint-embedding lineage whose published linear-probe numbers this page re-measures at matched backbone and then re-ranks at a second read-out depth.
- **[[wiki/entities/stylized-imagenet.md]]** — the same "what did the augmentation list delete" question answered by the other instrument: there a texture nuisance is *removed* from the data and the shape bias measured behaviourally; here the colour nuisance is removed by augmentation and the loss measured *inside* the representation by feature inversion.
- **[[wiki/concepts/label-free-model-selection.md]]** — the same finding reached without labels: this page shows a frozen ImageNet probe carries no rank information for detection, and there a label-free spectrum criterion *beats* that probe as a selector on VOC detection (79.7 vs 78.2) — two independent routes to the conclusion that the field's default selector is biased for dense downstream use (T310).
