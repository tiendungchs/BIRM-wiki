# I-JEPA (Image-based Joint-Embedding Predictive Architecture)

**The first image instantiation of the JEPA design: from *one* spatially-large context block, predict the target-encoder's representations of four smaller blocks of the same image — no hand-crafted augmentations, no decoder, no negatives, no reconstruction, and collapse held off by an EMA target alone.**

> **Provenance.** Assran, Duval, Misra, Bojanowski, Vincent, Rabbat, LeCun & Ballas 2023, *Self-Supervised Learning from Images with a Joint-Embedding Predictive Architecture* (`raw/assran-2023-i-jepa.md`), Meta AI (FAIR) / Mila / NYU. The design it instantiates is [[wiki/entities/h-jepa.md]] (LeCun 2022, shared author); the system that scales it to video and to a robot is [[wiki/entities/v-jepa-2.md]] (Assran et al. 2025, shared first author). This is the page the wiki's JEPA lineage passed through without ever holding.

---

## Architecture

| Component | Spec |
|---|---|
| **Context encoder `f_θ`** | ViT (B/16 → G/16), processes **only the visible context patches** — the MAE efficiency trick, kept |
| **Target encoder `f_θ̄`** | Same ViT, weights an **exponential moving average** of `f_θ`. Sees the **whole image** |
| **Predictor `g_φ`** | A *narrow* ViT taking `s_x` plus one mask token per target patch (shared learnable vector + positional embedding); run **`M` times**, once per target block |
| **Loss** | `(1/M) Σ_i ‖ ĝ_φ(s_x, {m_j}_{j∈B_i}) − s_y(i) ‖²₂` — average L2 in representation space, on masked patch positions only |
| **Targets** | `M = 4` blocks, scale `(0.15, 0.20)`, aspect `(0.75, 1.5)`, sampled by masking the **output** of the target encoder |
| **Context** | **one** block, scale `(0.85, 1.0)`, unit aspect, with all overlapping target patches deleted → ~0.25 of the image survives |
| **Augmentations** | **none**. One view of each image per step |
| **Anti-collapse provision** | branch asymmetry only: predictor on the context side, EMA + stop-gradient on the target side. Zero coefficients in the loss |

**Two design choices carry the whole paper, and both are about *which pairs are sampled*, not about the loss.**

1. **The targets are masked at the target encoder's *output*, not its input.** The teacher sees the entire image, so each target patch representation is contextualised by material the student cannot see. The student is therefore trained on a target that is *not a function of its input* — and the L2 minimiser of a partly-unpredictable target is its conditional mean, which is exactly what the predictor visualisation below shows (pose and part identity retained, background and low-level detail averaged away). **(brainstorm)** This makes the "abstraction" the JEPA family claims for representation-space prediction partly a *sampling* effect rather than an encoder property: any information the context cannot recover is removed by the regression, not by the encoder deciding to discard it.
2. **The context block is large and spatially distributed; the targets are large and semantic.** Both scales are hyperparameters of the mask sampler, and the ablation below prices them at 34 points.

---

## Results

### ImageNet-1k linear evaluation (frozen backbone)

| Method | Arch. | Epochs | Top-1 |
|---|---|---|---|
| *No view augmentations* | | | |
| MAE | ViT-H/14 | 1600 | 77.2 |
| data2vec | ViT-L/16 | 1600 | 77.3 |
| CAE | ViT-L/16 | 1600 | 78.1 |
| **I-JEPA** | ViT-B/16 · L/16 · H/14 · H/16₄₄₈ | 600 · 600 · 300 · 300 | 72.9 · 77.5 · 79.3 · **81.1** |
| *With view augmentations* | | | |
| DINO | ViT-B/8 | 300 | 80.1 |
| iBOT | ViT-L/16 | 250 | 81.0 |

### ImageNet 1% labels (protocol: fine-tune *or* linear probe, whichever is better per method)

| Method | Arch. | Top-1 |
|---|---|---|
| MAE ViT-H/14 · data2vec ViT-L/16 | — | 71.5 · 73.3 |
| **I-JEPA** ViT-H/14 (300ep) · ViT-H/16₄₄₈ | — | 73.3 · **77.3** |
| BYOL RN200(2×) · DINO ViT-B/8 · MSN ViT-B/4 | — | 71.2 · 70.0 · 75.7 |

### Linear-probe transfer — the row that shows the trade rather than a win

| | CIFAR100 | Places205 | iNat18 | **Clevr/Count** | **Clevr/Dist** (depth) |
|---|---|---|---|---|---|
| data2vec ViT-L/16 | 81.6 | 54.6 | 28.1 | 85.3 | 71.3 |
| MAE ViT-H/14 | 77.3 | 55.0 | 32.9 | **90.5** | **72.4** |
| **I-JEPA ViT-H/14** | 87.5 | 58.4 | 47.6 | 86.7 | **72.4** |
| DINO ViT-B/8 (aug.) | 84.9 | 57.9 | 55.9 | 86.6 | 53.4 |
| iBOT ViT-L/16 (aug.) | **88.3** | **60.4** | **57.3** | 85.7 | 62.8 |

**Read the columns, not the average.** Against the augmentation-based methods, dropping view invariance costs **~10 points on fine-grained category** (iNat18: 47.6 vs 57.3) and buys **10–19 points on depth** (Clevr/Dist: 72.4 vs 53.4/62.8). Against the pixel-reconstruction methods it is the mirror image: +14.7 on iNat18, −3.8 on object counting. **Invariance to a hand-crafted augmentation set is not a scalar virtue of a representation; it is the purchase of one read-out at the price of another** — the same decomposition [[wiki/entities/dinov2.md]] found term-by-term (KoLeo buys retrieval, the masked-patch loss buys segmentation, the ImageNet linear probe sees neither). The paper's own claim to beat view-invariance methods on counting rests on 86.7 vs 86.6, which is noise; the depth column is the real result.

### Efficiency

| Comparison | Fact |
|---|---|
| vs MAE (pixel targets) | ~**7% slower per iteration** (targets must be encoded) but converges in ~**5× fewer iterations** → >10× less compute at ViT-H/14 |
| vs iBOT (multi-view) | a ViT-**H**/14 I-JEPA costs less than a ViT-**S**/16 iBOT (>2.5×); one view per image instead of a multi-crop stack |
| Absolute | ViT-H/14 ImageNet pretraining in <1200 GPU-hours (16 A100s, <72 h) |

Two independent sources of the saving, worth keeping separate: **latent targets remove entropy the model would otherwise spend capacity on** (the MAE comparison), and **single-view training removes the multi-crop forward passes** (the iBOT comparison). Only the first is an argument for JEPA; the second is an argument against augmentation-based objectives generally.

---

## The two ablations that carry the architectural content

### 1. Where the loss is computed — the wiki's cleanest price on T162

| Target | Arch. | Epochs | ImageNet-1% top-1 |
|---|---|---|---|
| **Target-encoder output** | ViT-L/16 | 500 | **66.9** |
| **Pixels** | ViT-L/16 | 800 | **40.7** |

Same architecture, same masking, same data, **more** epochs for the losing arm: moving the loss from input space to representation space is worth **+26.2 points**, and it is the only controlled measurement of the JEPA lineage's founding commitment in the wiki ([[wiki/empirical-tensions.md]] T162). The mechanism claimed is elimination — an abstract target has already discarded pixel detail that no context can predict, so the predictor is never charged for it.

### 2. Which pairs are sampled — 34 points from the mask distribution alone

ViT-B/16, 300 epochs, ImageNet-1% linear evaluation. Architecture, loss and data identical in every row; only the mask sampler changes.

| Mask | Targets | Context | Context ratio | Top-1 |
|---|---|---|---|---|
| **multi-block** | 4 × Block(0.15, 0.2) | Block(0.85, 1.0) × complement | 0.25 | **54.2** |
| block | 1 × Block(0.6) | complement | 0.4 | 20.2 |
| random | Random(0.6) | complement | 0.4 | 17.6 |
| rasterized | 3 quadrants | 1 quadrant | 0.25 | 15.5 |

**This is the most consequential number in the paper and the wiki did not have its equivalent.** Every anti-collapse entry the wiki carries — negatives, variance/covariance, SIGReg, EMA asymmetry — is a variation in the *objective*, and the spread across that whole family on comparable protocols is a few points. Here a single distribution over *which sub-images get paired* moves a fixed objective by a factor of 3.5. Two of the losing rows are the default settings of the masked-image-modelling literature (block, random), and the third (rasterized) is the most natural "predict the rest of the scene" formulation. So the lever [[wiki/entities/h-jepa.md]] concedes it does not know how to set — what gets represented, decided by inductive bias — has a concrete, cheap and very large instance: **the pair sampler.** Recorded as [[wiki/empirical-tensions.md]] T167 and as an answer under G32.

**The mechanism, decomposed into the two knobs the table varies:**

| Knob | Failing setting | Why it fails |
|---|---|---|
| **Target scale** | random patches, or one 0.6 block | Scattered small targets are predictable from local texture continuation; the task is solved without object-level content |
| **Context informativeness** | one quadrant | A single corner is spatially uninformative about the rest; the target is *unpredictable*, so the conditional mean is nearly constant and the gradient carries little |

The two failures are opposite: too-easy targets and too-hard ones. The multi-block setting is a deliberately placed operating point between them, and nothing in the paper or the wiki predicts where that point is without a sweep (open problem below).

### 3. Scale

| Pretrain | Arch. | CIFAR100 | Places205 | iNat18 | Clevr/Count | Clevr/Dist |
|---|---|---|---|---|---|---|
| IN1k | ViT-H/14 | 87.5 | 58.4 | 47.6 | 86.7 | 72.4 |
| IN22k | ViT-H/14 | 89.5 | 57.8 | 50.5 | **88.6** | **75.0** |
| IN22k | ViT-G/16 | 89.5 | **59.1** | **55.3** | 86.7 | 73.0 |

More data helps everywhere; more *model* helps semantics and **hurts** the low-level tasks — attributed to ViT-G/16's larger patches, i.e. the input tokenisation, not the capacity. A reminder that in this family patch size is a read-out choice masquerading as an efficiency setting.

---

## What the predictor represents (RCDM probe)

After pretraining, freeze the context encoder and predictor, and train an **RCDM** conditional diffusion decoder to map the average-pooled predictor output back to pixels. Sample it several times per input: what is **constant across samples** is what the representation contains, what **varies** is what it does not.

| Constant across samples | Varies across samples |
|---|---|
| Object *parts* with the correct **pose** (back of a bird, roof of a car) | Precise low-level detail |
| **Positional uncertainty** — the extent and placement of the predicted region | Background |

This is a probe of a different type from everything on [[wiki/concepts/representation-probing.md]]: no labels, no ontology, no decoder class chosen to be weak. It answers "what is in here?" by *sampling the pre-image* rather than by fitting a hypothesis to the activations, which is the one instrument that does not presuppose the structure it looks for. Its cost is that the answer is a set of pictures and must be read by a human — it returns a grouping, not a number.

---

## Comparison

| | **I-JEPA** | [[wiki/entities/byol.md]] | [[wiki/entities/dinov2.md]] (iBOT/DINO) | MAE | [[wiki/entities/lewm.md]] |
|---|---|---|---|---|---|
| Where the loss lives | representation space | representation space | representation space (prototype scores) | **pixels** | representation space |
| What supplies the pair | **masking** | augmentations | augmentations + masking | masking | time (`t → t+1`) |
| Anti-collapse | EMA + predictor asymmetry | EMA + predictor asymmetry | EMA + **teacher output normalisation**, no predictor | none needed (bottleneck) | **SIGReg**, one coefficient |
| Coefficients | **0** | 0 | 0 (+ KoLeo at 0.1) | — | 1 |
| Certifiable from the objective | **no** | no | no | yes | yes |
| Augmentation-free | **yes** | no | no | yes | yes |

**I-JEPA is BYOL's mechanism with the pair source swapped.** Same predictor-on-one-branch, same EMA-plus-stop-gradient, same absence of any objective whose gradient descent these dynamics are ([[wiki/empirical-tensions.md]] T164) — with masking substituted for augmentation as the way two compatible views are produced. That substitution is what removes the colour-histogram shortcut BYOL's crop-only ablation exposed: two blocks of one image do not differ by a nuisance transformation, so there is no nuisance to be invariant to and none to accidentally key on. What replaces it is the shortcut this page's masking ablation exhibits — local texture continuation — which is the same failure relocated from the augmentation set to the mask sampler ([[wiki/concepts/shortcut-learning.md]]).

---

## Limitations

- **Zero anti-collapse coefficients means zero certifiability.** The EMA is inherited wholesale from BYOL along with the admission that no loss corresponds to it; nothing here revisits that.
- **The mask sampler is a five-number hyperparameter (`M`, target scale range, target aspect range, context scale, overlap rule) worth 34 points, and it was tuned by search.** No criterion is offered for setting it on a new modality — and it is the component that does *not* transfer, since "block of an image" has no obvious analogue in a graph or a symbol stream.
- **Fine-grained category recognition remains behind the augmentation-based methods** (iNat18 47.6 vs 57.3), so the augmentation-free claim is a trade and is reported as one only if the transfer table is read column-wise.
- **The 1% protocol is asymmetric** — fine-tuning or linear probing per method, whichever is better — so that table mixes two adaptation budgets.
- **No hierarchy, no latent `z`, no actions, no planning.** This is one JEPA level on static images; every distinctive claim of [[wiki/entities/h-jepa.md]] above the core remains untested here.

---

## Open problems

- **Is there a principle for the mask distribution, or only a sweep?** The winning setting sits between two named failure modes (predictable-from-texture, unpredictable-from-context). A predictability *statistic* computable before training — e.g. the mutual information between context and target under a cheap proxy model — would turn the 34-point lever into a design rule. Nothing in the wiki computes one.
- **How much of the "semantic level" credited to representation-space prediction is the contextualised target?** The two are confounded here: targets are both latent *and* computed with global context. An ablation with a target encoder restricted to the target block would separate them and is not run.
- **(brainstorm) Does the mask lever survive the modality change the JEPA lineage claims as its advantage?** The stated case against augmentation-based methods is that image augmentations do not generalise to audio or text. The mask sampler that replaces them is at least as image-specific — scale, aspect ratio and spatial contiguity all presuppose a 2-D grid. The generalisable statement of the multi-block criterion would have to be modality-free: *sample targets large enough to be non-trivial under the model's local structure, and a context that is informative about them* — which is a specification and not yet a procedure.

---

## Connections

- **[[wiki/entities/dinov3.md]]** — the other half of this page's lesson about what a loss does not see: the mask sampler moves the representation further than any anti-collapse term does, and the *training horizon* moves it too — a dense read-out peaking at 200k iterations and ending below its start under a correctly-minimised objective. Neither the pair distribution nor the stopping point is a coefficient in anyone's loss.


- **[[wiki/entities/h-jepa.md]]** — the design this instantiates for images, and the first evidence that its central bet pays: prediction in representation space is worth +26.2 points over the same architecture predicting pixels — while supplying a concrete instance of the lever that design concedes it cannot set, the mask sampler at 34 points.
- **[[wiki/entities/v-jepa-2.md]]** — the direct descendant: same lab, same objective shape, same EMA-teacher masked-feature prediction moved to video, scaled 1B×1M-hours and given an action-conditioned predictor and a planner; every architectural choice it does not explain is settled here.
- **[[wiki/entities/byol.md]]** — the mechanism this inherits unchanged (predictor on one branch, EMA on the other, no anti-collapse term) with the pair source swapped from augmentations to masking, which removes the colour-histogram shortcut BYOL's crop-only ablation exposed and installs a texture-continuation one in its place.
- **[[wiki/entities/dinov2.md]]** — the head-to-head on what an augmentation set buys: DINOv2's lineage (DINO/iBOT) wins fine-grained category by ~10 points and loses depth by 10–19, so the two encoders differ by which read-out was purchased rather than by quality.
- **[[wiki/entities/lewm.md]]** — the same JEPA core with the anti-collapse provision moved back *into* the loss: one SIGReg coefficient and no EMA, against this page's zero coefficients and no certifiability.
- **[[wiki/concepts/energy-based-models.md]]** — the formalism: this is a joint-embedding predictive architecture whose energy is L2 prediction error in latent space, kept off its flat minimum by an update-rule asymmetry rather than by any term.
- **[[wiki/concepts/shortcut-learning.md]]** — the data lever with a number on it: mask distribution moves a fixed objective from 15.5 to 54.2, and two of the losing settings are what the masked-image-modelling field uses by default.
- **[[wiki/concepts/objective-identifiability.md]]** — the sharpest available demonstration that a loss does not name a representation: one loss, one architecture, one dataset, four pair samplers, a factor of 3.5 in the result.
- **[[wiki/concepts/representation-probing.md]]** — a label-free probe of a different type: decode the frozen predictor's output with a conditional diffusion model and read what is invariant across samples, returning a grouping rather than a score and presupposing no ontology.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the boundary case of the identity: predicting a *learned, moving* target is not coding anything, so a JEPA's loss has no code length and the compression stand-in for "how much structure was found" is unavailable to the family the wiki is most interested in.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the image-space instance of the framing: the context block is a partial observation, the target blocks are unobserved nodes, and training is learning the edges — with the mask sampler deciding which edges are ever traversed.
- **[[wiki/entities/hit-jepa.md]]** — this page's masking design reused in a three-level stack, with one sampler addition the ablation here never tested: masks drawn 50/50 successive vs scattered, explicitly to force local and long-range dependence out of the same encoder — the same lever T167 prices at 15.5 → 54.2, exercised as a mixture rather than a choice (Li et al. 2025).
- **[[wiki/entities/lejepa.md]]** — the head-to-head this page loses on efficiency and wins on the lever it discovered: a 304M ViT-L at 100 epochs beats this page's 632M ViT-H at 300 on all-shot transfer average (79.48 vs 78.50) with the EMA-plus-predictor asymmetry replaced by one derived distribution-matching coefficient — while its pairs come from multi-crop augmentation, so the 15.5 → 54.2 sampler swing measured here is untouched by anything it changes (T167).
