# MAE (Masked Auto-Encoder)

**Mask 75% of an image's patches at random, run the encoder over the surviving 25% *only*, and let a small decoder rebuild the raw pixels of the missing patches from the encoder output plus a shared mask token — an asymmetric denoising auto-encoder whose whole design content is (i) where the mask token is injected and (ii) how much is removed.**

> **Provenance.** He, Chen, Xie, Li, Dollár & Girshick 2022, *Masked Autoencoders Are Scalable Vision Learners* (`raw/he-2022-masked-autoencoders.md`), Facebook AI Research. The wiki has cited this system as the pixel-reconstruction pole of [[wiki/empirical-tensions.md]] T162 on [[wiki/entities/i-jepa.md]], [[wiki/entities/dinov2.md]], [[wiki/entities/dinov3.md]] and [[wiki/concepts/violation-of-expectation.md]] without ever holding its primary source.

---

## Architecture

| Component | Spec |
|---|---|
| **Masking** | Non-overlapping 16×16 patches; sample *uniformly without replacement*; default **75% removed**. Implemented as shuffle → truncate → (encode) → append mask tokens → unshuffle. No sparse ops |
| **Encoder** | Standard ViT (B/16 → H/14) applied to the **visible patches only**. Mask tokens never enter it, so pre-training and deployment see the same kind of input |
| **Decoder** | 8 Transformer blocks × 512-d, **<10% FLOPs per token** vs the encoder; input is encoded visible tokens **+ one shared learned mask token per missing patch**, all with positional embeddings. **Discarded after pre-training** |
| **Target** | Raw pixels of masked patches; per-patch mean/std normalisation on top (the better variant) |
| **Loss** | MSE **on masked patches only** — `L = (1/\|M\|) Σ_{i∈M} ‖ x̂_i − x_i ‖²` |
| **Anti-collapse provision** | **None, and none needed.** The target is a fixed function of the input, so this is the deterministic-regression row of [[wiki/concepts/representational-collapse.md]]'s typing table — the unique minimiser is the true pixel value |
| **Augmentation** | random-resized crop + horizontal flip. Nothing else; the paper's own claim is that *masking does the job augmentation does elsewhere* |

**The two designs are one design.** Removing the mask token from the encoder is what makes 75% masking *cheap* (encoder cost ∝ 25% of tokens, and attention is quadratic), and 75% masking is what makes removing it *safe* (enough context survives). Ablated separately they are worth 14 linear points and 19 linear points respectively; together they buy a 2.8–4.1× wall-clock speedup on the same hardware.

---

## The ablations, all ViT-L/16, 800 epochs, ImageNet-1k (ft = fine-tune, lin = linear probe)

| Knob | Setting | ft | lin | The claim it settles |
|---|---|---|---|---|
| **Masking ratio** | 10–75% sweep | flat over 40–80% | **54.6 → 73.5** | Vision's information density is low: BERT's 15% leaves the task solvable by local texture continuation. The optimum is 5× the language ratio |
| **Mask token in encoder** | with `[M]` | 84.2 | **59.6** | A 14-point linear collapse from a *train/deploy input-distribution gap* alone — the encoder is asked to represent an input type that never occurs downstream. Also 3.3× the FLOPs |
| | without `[M]` | 84.9 | 73.5 | |
| **Decoder depth** | 1 block | 84.8 | **65.5** | The decoder absorbs *reconstruction specialisation*. A deep decoder leaves the encoder's last layers free to be abstract; with fine-tuning the encoder can re-specialise itself, so the knob is invisible (ft flat at 84.4–84.9) |
| | 8 blocks | 84.9 | 73.5 | |
| **Target** | pixel | 84.9 | 73.5 | **High-frequency content is load-bearing.** Truncating to the top-96 patch-space PCA coefficients — i.e. keeping exactly the predictable, low-frequency part — *costs* 0.3 ft / 1.2 lin |
| | pixel, per-patch norm | **85.4** | **73.9** | |
| | patch PCA-96 | 84.6 | 72.3 | |
| | dVAE token (BEiT) | 85.3 | 71.6 | Discrete semantic tokenisation, at the cost of a second pre-training stage on 250M extra images, buys **nothing** over normalised pixels (Table 7: Δ ≤ 0.2 across IN1K/COCO/ADE20K) |
| **Augmentation** | none (centre crop) | **84.0** | 65.7 | Compare: crop-only costs [[wiki/entities/byol.md]] 13 points and SimCLR 28. **Random masking *is* the augmentation** — a fresh mask each iteration is a fresh training example, and no invariance group is ever declared |
| | crop, random size | 84.9 | 73.5 | |
| | crop + colour jitter | 84.3 | 71.9 | Adding a nuisance direction *hurts*, the opposite sign to every contrastive method |
| **Mask sampler** | random, 75% | 84.9 | **73.5** | Second, independent instance of the pair-sampler lever (T167) |
| | block, 50% | 83.9 | 72.3 | |
| | block, 75% | 82.8 | **63.9** | Too hard: higher training loss, blurrier reconstructions |
| | grid (keep 1 of 4) | 84.0 | 66.0 | Too easy: lower training loss, *sharper* reconstructions, worse features |

**Reconstruction quality and representation quality move in opposite directions.** Grid masking reconstructs better and represents worse; block-75 reconstructs worse and represents worse. The pixel loss is therefore not a monotone proxy for what the encoder learns, and there is no value of it that identifies the good operating point — the same non-identifiability [[wiki/concepts/objective-identifiability.md]] states for behavioural scores, arriving here through the training loss itself.

### Scaling and cost

| | Fact |
|---|---|
| Schedule | Linear-probe accuracy **has not saturated at 1600 epochs**; MoCo v3 saturates at 300 — while the MAE encoder sees 25% of patches per epoch against contrastive learning's 200%+ |
| Wall-clock | ViT-L 800 epochs: 42.4 h with `[M]` in the encoder → **15.4 h** without → 11.6 h with a 1-block decoder (128 TPU-v3 cores) |
| ImageNet-1k fine-tune, IN1K data only | ViT-B **83.6** · ViT-L **85.9** · ViT-H **86.9** · ViT-H@448 **87.8**, vs from-scratch 82.3/82.6/83.1 and MoCo v3 83.2/84.1 |
| Transfer | COCO AP^box ViT-L **53.3** vs supervised 49.3 and MoCo v3 49.3; ADE20K mIoU ViT-L **53.6** vs supervised 49.9, MoCo v3 49.1. iNat and Places beat prior bests obtained by pre-training on 1B and 3.5B images |

The gain over supervised pre-training **grows with model size** (ViT-B +2.4 AP^box, ViT-L +4.0), which is the paper's actual claim: not that masked reconstruction produces better features at a fixed scale, but that it removes the label ceiling that makes large ViTs overfit IN1K.

---

## The result that reaches outside this page: linear probing does not rank these encoders

| Blocks fine-tuned (ViT-L) | 0 (linear probe) | ½ (MLP sub-block) | 1 | 4 | 24 (full) |
|---|---|---|---|---|---|
| **MAE** | 73.5 | 79.1 | **81.0** | close to full | 84.9 |
| **MoCo v3** | **higher than MAE** | — | lower | lower by 2.6 | lower |

Tuning a *single* Transformer block moves MAE 7.5 points; tuning half of one moves it 5.6. And the ordering of two methods **inverts** at the first non-zero adaptation budget: MoCo v3 wins the frozen linear probe and loses at every partial depth tested, on COCO, and on ADE20K. The authors' reading — *"linear separability is not the sole metric"* — is stronger than it sounds: it says the frozen-linear protocol measures how much of the representation is already in one particular readable format, and that this quantity is uncorrelated with how much structure the representation contains. Recorded as [[wiki/empirical-tensions.md]] T310, and it bears directly on T162, whose flagship measurement (66.9 vs 40.7, I-JEPA latent vs pixel targets) is taken with exactly this instrument.

---

## Comparison

| | **MAE** | [[wiki/entities/i-jepa.md]] | [[wiki/entities/byol.md]] / [[wiki/entities/simsiam.md]] | [[wiki/entities/dinov2.md]] |
|---|---|---|---|---|
| Where the loss lives | **pixels** | representation space | representation space | prototype scores |
| What supplies the pair | masking | masking | augmentations | augmentations + masking |
| Anti-collapse | **not required** (fixed target) | EMA + predictor asymmetry | EMA / stop-grad asymmetry | EMA + teacher normalisation |
| Certifiable from the objective | **yes** | no | no | no |
| Augmentation-free | **yes** (−7.8 lin, −0.9 ft) | yes | no | no |
| Compute at matched accuracy | ~10× I-JEPA's at ViT-H | 1× | — | — |
| Frozen linear probe | weak | strong | strong | strongest |
| Any adaptation at all | **strong** | strong | — | strongest |

**MAE and I-JEPA differ in exactly one place** — whether the regression target is the pixel array or an EMA encoder's output — and the wiki holds a controlled measurement of that difference in one direction only (I-JEPA's 66.9 vs 40.7 on ImageNet-1% linear evaluation). This page supplies the counterweight rather than a rebuttal: on Clevr object counting MAE ViT-H beats I-JEPA ViT-H 90.5 to 86.7 and ties on depth, its transfer numbers on COCO and ADE20K are the best in that comparison, and the instrument the 26-point gap was measured with is the one this page shows to be uninformative about adapted performance.

---

## Limitations

- **The reasoning claim is a figure, not a measurement.** Plausible-but-wrong completions at mask ratios *above* the trained one (Fig. 4) are offered as evidence of "gestalt" understanding. No compositional, relational or physical-plausibility benchmark is run; every reasoning-relevant claim here is an extrapolation from ImageNet top-1 and segmentation mIoU.
- **The masking ratio, the mask sampler and the decoder depth were each found by sweep**, and the winning settings sit between two named failure modes (solvable by texture continuation / unpredictable from context) with no criterion for locating that point in advance — the same open problem I-JEPA leaves.
- **Nothing here is temporal, causal or actionable.** The task is single-frame in-painting; there is no `z`, no action, no hierarchy, no planning.
- **`75%` is a statement about ImageNet's redundancy, not about vision.** The claimed mechanism — natural images are spatially redundant, language is not — predicts that the optimal ratio should move with the data's information density, and nothing measures that density independently of the sweep.
- **Loss value and representation quality are anti-correlated across the mask-sampler rows**, so the objective supplies no model-selection signal; every choice on this page was made against a downstream ImageNet score.

---

## Open problems

- **Is there a predictability statistic that sets the mask ratio?** MAE and I-JEPA both need the target to be non-trivial and the context to be informative, and both find the operating point by sweep. A cheap pre-training estimate of `I(context; target)` would turn two large levers into one design rule.
- **(brainstorm) What is the "decoder depth" knob in a system with no decoder?** Deep-decoder-improves-linear-probe says the last encoder layers were being consumed by output specialisation, and that a *read-out head of sufficient depth* is what lets an encoder stay abstract. Every frozen-feature evaluation in the wiki fixes that head at depth 0 or 1. The transferable version of this ablation is: report a read-out-depth *curve*, not a point, for any representation claim.
- **(brainstorm) Does the high-frequency result survive to modalities where "high frequency" means "noise"?** PCA-truncating the target hurts here, which is the cleanest evidence in the wiki against the JEPA argument that unpredictable detail is capacity wasted. But on ImageNet the discarded high-frequency band is texture, which is diagnostic ([[wiki/entities/stylized-imagenet.md]]); on video or sensor streams it may be sensor noise. The disagreement between the two families may be a fact about datasets rather than about objectives.

---

## Connections

- **[[wiki/entities/i-jepa.md]]** — the one-variable counterfactual: same masking, same ViT, same data, target moved from pixels to an EMA encoder's output for +26.2 points on ImageNet-1% linear evaluation — a measurement this page's partial-fine-tuning result says is taken with the wrong instrument, and which this page's efficiency trick (encode only visible patches) I-JEPA keeps wholesale.
- **[[wiki/entities/byol.md]]** — the augmentation-dependence contrast with a number on both sides: crop-only costs BYOL 13 points and SimCLR 28, while this system loses 7.8 linear (and 0.9 fine-tuned) with augmentation removed *entirely*, because a fresh random mask each iteration is already a fresh example.
- **[[wiki/entities/simsiam.md]]** — the same question asked from the other pole: SimSiam subtracts anti-collapse machinery until only the stop-gradient remains, while this page needs none at all, because a fixed pixel target has a unique minimiser and no degenerate solution to defend against.
- **[[wiki/entities/dinov2.md]]** — the method whose recipe was selected on a frozen `k`-NN probe, against this page's demonstration that frozen probes and one-block-adapted probes rank encoders in opposite orders.
- **[[wiki/entities/dinov3.md]]** — the same instrument-dependence along the training axis rather than the adaptation axis: one frozen encoder's CLS-linear probe rises monotonically while its patch-linear probe peaks and declines, where here one encoder's ranking flips between depth-0 and depth-1 read-outs.
- **[[wiki/entities/stylized-imagenet.md]]** — the counterpart on what the high-frequency band contains: texture is a *nameable nuisance* whose removal buys 22% → 81% shape bias there, and is part of the reconstruction target whose truncation costs accuracy here — so the same band is a shortcut for a classifier and a training signal for an auto-encoder.
- **[[wiki/concepts/representational-collapse.md]]** — the boundary case of that page's typing table: a fixed input-space target makes collapse structurally impossible, which is why this is the only system in the family with zero anti-collapse provision and full certifiability, and why it pays for that with a weak frozen read-out.
- **[[wiki/concepts/representation-probing.md]]** — supplies the adaptation-budget axis of the probe-choice problem: read-out *depth* is a free parameter with enough leverage to invert a method ranking (73.5 → 81.0 from one block), and every frozen-feature table in the wiki fixes it at zero.
- **[[wiki/concepts/objective-identifiability.md]]** — the training loss itself made non-identifying: across the mask-sampler ablation, lower reconstruction loss and sharper reconstructions accompany *worse* representations, so no value of the objective distinguishes the good run from the bad one.
- **[[wiki/concepts/shortcut-learning.md]]** — the mechanism behind the masking-ratio result: at low ratios the task is solvable by extending lines and textures from neighbouring patches, so the shortcut is defeated by *removing more evidence* rather than by any change to the loss.
- **[[wiki/concepts/divergence-objectives.md]]** — the reconstruction pole of that page's data-pipeline/loss split: the pipeline term is random masking and the loss term is MSE, and the PCA-truncation ablation prices what the loss is charged for material no context can predict.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the case where the identity holds cleanly and is still uninformative: the loss *is* a code length on a fixed target, so unlike a JEPA this system's objective is a genuine compression score — and it anti-correlates with representation quality across the mask-sampler rows.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the degenerate instance of the framing: visible patches are observed nodes, masked patches are unobserved ones, and the edges are learned — but the reconstruction is scored in the *observation* space, so nothing forces the intermediate estimate to be the graph rather than an interpolator.
