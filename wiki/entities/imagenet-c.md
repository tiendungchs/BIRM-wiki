# ImageNet-C and ImageNet-P — average-case robustness, and the differencing that separates it from accuracy

**Hendrycks & Dietterich 2019.** Two evaluation-only datasets built by pushing the ImageNet validation set through *common* (not adversarial) image degradations: **ImageNet-C** — 15 corruption types × 5 severities = 75 corrupted copies — and **ImageNet-P** — >30-frame perturbation *sequences* per image under 10 mild perturbations. The paper's value to this wiki is not the datasets but two measurement designs: a **robustness score differenced against the model's own clean error**, which is what stops a robustness number from silently re-reporting accuracy, and a **label-free prediction-stability score** read off a perturbation sequence.

---

## The two robustness definitions, and what they are not

| Quantity | Definition | Read as |
|---|---|---|
| **Corruption robustness** | `E_{c∼C}[P_{(x,y)∼D}(f(c(x)) = y)]` | *Average*-case accuracy over a declared corruption family `C` with `P_C(c)` approximating real-world frequency |
| **Perturbation robustness** | `E_{ε∼E}[P_{(x,y)∼D}(f(ε(x)) = f(x))]` | Prediction *stability* — the model is compared to **itself**, so no labels enter |
| Adversarial robustness (contrast) | `min_{‖δ‖_p < b} P(f(x+δ) = y)` | *Worst*-case, over small additive, **classifier-tailored** perturbations |

The corruption/perturbation pair is classifier-agnostic and average-case; the adversarial one is classifier-specific and worst-case. The paper's position is that the field's use of "robustness" for the third alone is the mistake — speech recognition never made it, because common acoustic corruptions are "ever-present and unsolved".

---

## The artefact

| | ImageNet-C | ImageNet-P |
|---|---|---|
| Unit | one corrupted image | a >30-frame sequence per source image |
| Family | 15 types in 4 categories — **noise** (Gaussian, shot, impulse) · **blur** (defocus, frosted glass, motion, zoom) · **weather** (snow, frost, fog, brightness) · **digital** (contrast, elastic, pixelate, JPEG) | 10 types; noise sequences are i.i.d. draws from a clean base, the rest are **temporal** (each frame perturbs the previous): motion/zoom blur, snow, brightness, translate, rotate, tilt, scale |
| Severity | 5 levels per type, plus per-image variation at fixed severity (each fog cloud is unique) | one mild step per frame, so the sequence never leaves the natural-image manifold |
| Held-out validation set | 4 extra corruptions (speckle noise, Gaussian blur, spatter, saturate) | 4 extra perturbations (speckle noise, Gaussian blur, spatter, shear) |
| Editions | CIFAR-10-C, Tiny ImageNet-C, ImageNet 64×64-C, Inception-sized | same set |

**Protocol, and it is the load-bearing part.** Train on ImageNet (or anything else); **never train on the benchmark**; report whether you did. The separate validation corruptions exist so that hyperparameter selection does not consume the test family — the analogue of a private split for a *shift family* rather than for an item set. Rationale given: humans generalise to novel corruptions (new Instagram filters) without being trained on them, so a method that must see a corruption first has not demonstrated the ability being measured.

---

## The metrics

All are normalised by AlexNet's error on the same corruption, so that "fog is harder than brightness" does not dominate the average:

```
CE_c^f          = (Σ_{s=1..5} E_{s,c}^f) / (Σ_{s=1..5} E_{s,c}^AlexNet)          → mCE  = mean over the 15 c
Relative CE_c^f = (Σ_s E_{s,c}^f − E_clean^f) / (Σ_s E_{s,c}^AlexNet − E_clean^AlexNet) → Relative mCE
FP_p^f  = P_{x∼S}(f(x_j) ≠ f(x_{j−1}))                → FR = FP^f/FP^AlexNet      → mFR   (label-free)
uT5D_p^f = E_{x∼S}[d(τ(x_j), τ(x_{j−1}))]             → T5D = uT5D^f/uT5D^AlexNet → mT5D  (label-free, graded)
```

`d` is a displacement metric on the top-5 slice of the ranking permutation: 0 if the two top-5 lists agree, and a class's displacement stops accumulating once it leaves the top 5. Class probabilities are deliberately **not** used, because models differ in calibration.

**The differencing is the contribution.** `mCE` measures corrupted-set accuracy; `Relative mCE` subtracts the model's own clean error first, so it measures *degradation* — how much the model loses when the corruption arrives. The two orderings come apart, and the wiki's general form of the lesson: **any post-shift score that is not differenced against the same model's pre-shift score is partly an accuracy measurement, and a field reporting the undifferenced version will read accuracy progress as robustness progress.**

---

## Results — the headline is a null

| Network | Clean err | mCE | **Relative mCE** | mFR | mT5D |
|---|---|---|---|---|---|
| AlexNet | 43.5 | 100.0 | **100.0** | 100.0 | 100.0 |
| SqueezeNet | 41.8 | 104.4 | **117.9** | 112.6 | 112.9 |
| VGG-11 | 31.0 | 93.5 | **123.3** | 74.9 | 83.9 |
| VGG-19 | 27.6 | 88.9 | **122.9** | 66.9 | 78.6 |
| VGG-19+BN | 25.8 | 81.6 | **111.1** | 65.1 | 80.5 |
| ResNet-18 | 30.2 | 84.7 | **103.9** | 72.8 | 87.0 |
| ResNet-50 | 23.9 | 76.7 | **105.0** | 58.0 | 78.3 |

Three findings, in decreasing order of how much they cost the field:

1. **`mCE` falls monotonically with clean accuracy while `Relative mCE` does not fall at all** — every architecture from VGG-11 to ResNet-50 degrades *worse* than AlexNet under corruption. "From AlexNet to ResNet, corruption robustness in itself has barely changed"; the apparent gains are accuracy gains re-expressed. **Our "superhuman" classifiers are decidedly subhuman.**
2. **Corruption and perturbation robustness are different axes.** VGGNets are worse than ResNets on ImageNet-C and equal or better on ImageNet-P; batch normalisation makes VGG-19 *more* corruption-robust (88.9 → 81.6 mCE) and *less* perturbation-robust (mT5D 78.6 → 80.5). No single robustness number exists.
3. **Perturbations need not be adversarial to break a classifier.** ResNet-18 flips its top-1 prediction between **adjacent frames of a scale sequence 15.6% of the time** — the image having moved one increment, still clean, still in-distribution.

---

## What moved the numbers, and what did not

| Intervention | Effect | Reading |
|---|---|---|
| **Feature aggregation** (ResNet-50 → ResNeXt-50) | mCE 76.7 → **68.2**, Relative mCE 105.0 → 88.6, mFR 58.0 → 52.4 | Gains *outpace* the 1-point accuracy gain — the differenced score moves, so this is robustness and not accuracy |
| **Size** (DenseNet-121 → -161; ResNeXt-50 → -101) | mCE 73.4 → 66.4; 68.2 → **62.2**, Relative mCE 88.6 → **80.1**, mFR 52.4 → 43.2 | "More representations, more redundancy, more capacity" — monotone in both robustness axes |
| **Multiscale architectures** (Multigrid, MSDNet) | mCE 76.7 → 73.3 / 73.6, no perturbation benefit | Fine detail and global representation processed *in tandem* suppresses pixel noise; a purely corruption-side gain |
| **Stylized-ImageNet augmentation** (Geirhos et al. 2019) | mCE 76.7 → **69.3** | The texture-bias fix is also the largest single-augmentation corruption fix — the data lever |
| **CLAHE histogram equalisation** (fine-tune 5 epochs) | mCE 76.7 → 74.5, clean error 23.87 → 23.55 | Input standardisation imported from speech; small, free |
| **Adversarial Logit Pairing** | −41% mFP, −40% mT5D on Tiny ImageNet-P | A **bypassed** ℓ∞ adversarial defence, worthless for its stated purpose, delivering the paper's largest *perturbation* gain — the interaction between worst-case and average-case robustness is not understood |
| **Stability training** (noise-softmax matching) | mCE *worse* than baseline at every setting; mFR 58 → 57 | A method validated on subtle differences fails a diverse corruption set — "benchmarking robustness-enhancing techniques requires a diverse test set" |
| **Image denoising** (non-local means, noise-estimated) | mCE 76.7 → **82.1** | Targeted restoration strips detail from the corruptions it was not aimed at; net harm |
| **10-crop classification** | Accuracy up, mCE gain does not outpace it | An ensemble over positions buys accuracy, not stability |
| **Smaller/pruned models** (CondenseNet C=G=4, 8) | mCE 80.8, 84.6 at 26.3%, 28.9% error | "Simpler models generalise better" fails here — pruning costs robustness on top of accuracy |

---

## Subtype robustness — a second, cheaper shift axis buried in Appendix G

Take an existing **taxonomy** (ImageNet-22K), pick 25 broad types (bird, vehicle, fungus, …), call a subtype *seen* if it is in ImageNet-1K and *unseen* otherwise, fine-tune only the last layer of a pretrained classifier to predict the 25 broad types from **seen** subtypes, and test on unseen ones. The correct answer for an unseen bird species is still "bird".

- Result: a substantial seen/unseen gap on a **25-class** problem after training on millions of images, and the architectures "hardly deviate from the trendline" — the same signature as the Relative mCE null.
- Why it is worth having: the shift is **declared by an existing label hierarchy**, so it needs no generator, no annotator, no authored variations and no corruption code — the cheapest declared-abstraction shift available for natural images, and the only one in the wiki that reuses a taxonomy someone else already built.

---

## What a builder should take

- **Report the differenced score.** Every o.o.d. number in this wiki that is not conditioned on the same model's in-distribution number is ambiguous between "more robust" and "better". This is `F15` at [[wiki/concepts/certification-instruments.md]].
- **Robustness is a vector.** Corruption and perturbation dissociate under a single architectural change (batch normalisation), which is conclusion 1 of the certification inventory arriving from a fourth direction.
- **Prediction stability is free.** `mFR`/`mT5D` need no labels, no second model and no ground truth — only the ability to apply a small perturbation twice. For a reasoning model this transfers directly: a solver whose answer flips between two renderings of one problem has not executed a rule over the problem's structure.
- **Capacity is a lever on the differenced score** — the wiki's clearest evidence for it, and it points opposite to the language-side measurement ([[wiki/empirical-tensions.md]] T300, T228).
- **The failed enhancements are the more useful half.** Denoising, stability training, cropping and pruning all target a *plausible* mechanism of corruption robustness and all fail or backfire; the two that work (aggregation/size, and style augmentation) change what the representation is *made of*.

---

## Limitations

- **Average-case over a hand-declared family.** `P_C(c)` is asserted, not measured; the 15 corruptions are what the authors could implement, so "general robustness" is general over the authored set. Compare [[wiki/entities/pgm.md]], where the shift family is the generator's own symbolic structure and therefore complete by construction.
- **The intended solution is never stated.** ImageNet's own label semantics do all the work, so requirement 1 of [[wiki/concepts/certification-instruments.md]] is satisfied only as far as ImageNet satisfies it — which [[wiki/concepts/shortcut-learning.md]] argues is not far.
- **Corruptions are trainable.** The protocol asks researchers not to fit them and provides held-out corruptions, but nothing enforces it; six years on, corruption-augmentation is standard practice and published mCEs are not comparable across that line.
- **All corruptions are 2-D image-space operations** — none changes viewpoint, occlusion, or object–context relations, which is exactly the shift class ObjectNet was later built for.
- **The normalising baseline is a model.** Every number here is relative to AlexNet, so a corruption AlexNet happens to survive is scored as harder than one it does not.

---

## Comparison

| Benchmark | Shift is declared over | Needs | Labels needed | Detects |
|---|---|---|---|---|
| **ImageNet-C** | 15 authored image-space corruptions × 5 severities | corruption code | yes | degradation under nuisance transformation, differenced against clean error |
| **ImageNet-P** | 10 mild perturbations, applied in sequence | the same code | **no** | prediction instability inside a natural-image neighbourhood |
| [[wiki/entities/pgm.md]] | the generator's `[relation, object, attribute]` triples | a symbolic generator | yes | which named abstraction fails to transfer |
| [[wiki/entities/math-perturb.md]] | validity of the *solution method* | two expert rewrites per item | yes | unchecked preconditions on a retrieved procedure |
| [[wiki/entities/conceptarc.md]] | concept instantiation | a concept inventory + author | yes | per-concept coverage |
| [[wiki/entities/shortcut-suite.md]] | an injected tautological cue | a string concatenation | yes | share of the decision resting on a cue |

---

## Connections

- **[[wiki/concepts/shortcut-learning.md]]** — supplies that page's texture claim with its corruption-side number (Stylized-ImageNet augmentation is worth 76.7 → 69.3 mCE) and the measurement design its instrument list lacked: a robustness score differenced against the model's own clean error, without which six years of architecture progress read as robustness progress that the differenced score says never happened.
- **[[wiki/concepts/certification-instruments.md]]** — supplies `I26` (perturbation-sequence stability: a label-free flip rate and a graded top-5 displacement, measured *between adjacent frames* so no output is privileged as the reference), `I27` (held-out-subtype generalisation declared by an existing taxonomy) and `F15` (an undifferenced post-shift score is partly an accuracy score).
- **[[wiki/entities/dinov2.md]]** — the same axis measured on a self-supervised encoder, where corruption robustness becomes a *purchase* made by the curation pipeline rather than by the architecture; the 14-point ImageNet-A gap from matched-size curated data is the data-lever counterpart of the aggregation/size gain here.
- **[[wiki/entities/dendritic-ann.md]]** — the opposite side of the size finding at a different scale: a sparse, structured, parameter-poor network reports *better* noise robustness at matched accuracy, while pruning a convolutional network for size (CondenseNet) costs both accuracy and mCE — so whether small-and-structured buys robustness is a question about the sparsity pattern, not about parameter count (T64, T300).
- **[[wiki/concepts/environment-invariance.md]]** — the contrast that defines what this benchmark is not: an average over a corruption distribution is exactly the weighted-ERM object that page shows cannot extrapolate, so a low mCE certifies interpolation over the authored family and says nothing about an unauthored one.
- **[[wiki/concepts/human-baseline.md]]** — the reference this benchmark asserts rather than measures: the whole argument rests on humans being untroubled by snow, blur and pixelation, and no human mCE was collected, so the "subhuman" verdict is an appeal rather than a number.
- **[[wiki/concepts/manifold-untangling.md]]** — what the corruption family is a proxy for: tolerance to identity-preserving image transformations is the ventral stream's stated computational job, and mCE is the closest thing the wiki has to scoring a model on it — with the caveat that pose, position and occlusion, the transformations that page is actually about, are the ones ImageNet-C omits.
- **[[wiki/entities/ventral-visual-stream.md]]** — the same complaint from 2012 and the same repair: a benchmark that does not vary the nuisance parameters cannot separate systems, and this paper's contribution is to vary them on a declared, severity-graded scale.
