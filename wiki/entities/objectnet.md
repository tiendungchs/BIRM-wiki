# ObjectNet — controls placed in the capture process, and the 40–45% that was never in the image

**Barbu et al. 2019 (NeurIPS, MIT CSAIL/CBMM).** A 50,000-image, 313-class **test-only** object-recognition set in which background, object rotation and imaging viewpoint are **randomly assigned to the photographer before the photo exists**, and annotated per image. ImageNet-trained detectors lose **40–45%** top-1 and top-5 on the 113 overlapping classes. The paper's value to this wiki is not the artefact but the move: the other o.o.d. instruments here apply a transformation to an image someone else already framed, and this one intervenes on the *data-generating process*, which is the only way to vary the nuisance parameters — pose, viewpoint, object–context relation — that no image-space operation can reach ([[wiki/entities/imagenet-c.md]] omits exactly these).

---

## The design

| Element | Choice | Why it is load-bearing |
|---|---|---|
| **Controls** | 4 backgrounds (kitchen, living room, bedroom, washroom) × 3 viewpoints (top, 45° angled, side) × 50 rotations (uniform on the sphere, nearby points snapped to equator and poles) | Each is **sampled** and then **annotated**, so the score decomposes by control rather than arriving as one drop |
| **Instruction channel** | Worker moves to phone via QR code; a labelled **rectangular prism** with two class-specific semantically meaningful orthogonal axes (the *front* and *top* of a chair) is animated from a default pose into the target pose, then overlaid on the live camera for alignment | Remembering a requested rotation is "too unreliable"; the AR overlay is what makes a nuisance parameter *assignable* to an untrained annotator |
| **Anti-instance bias** | Workers are never shown an image of the desired object, only a 1–4 word description (forks and spoons excepted — axis agreement too low, sketches used instead) | Prevents the collection UI from selecting canonical instances, which is the bias the dataset exists to remove |
| **Class balance** | 420 household candidates → 313 after removing immovable (16), unsafe (8), ambiguous (10), privacy (5), living (2) and too-rare (52); classes offered to workers **inversely proportional to their frequency** | A near-uniform class histogram bought at collection time rather than by post-hoc resampling |
| **Test set only** | No paired training set, and a licence clause forbidding parameter updates on the images | "Separating training and test set collection may be an important tool to avoid correlations between the two which are easily accessible to large models but not detectable by humans" |
| **Leak marker** | Every image carries a **one-pixel red border**, stripped on the fly before testing | A published test image becomes reverse-image-searchable, so its presence in *any* training corpus is detectable by a third party — proposed as a standard for all vision datasets |
| **Scale/cost** | 5,982 workers, 95,824 images captured, **50,000 retained** (48% discarded), ≈1.5 min/object, $10/hour | The waste rate is the instrument's real price, and it is itemised: 23% photographed screens, 20% from centralised worker sites (background reuse), 10% wrong background, 0.2% faces, 0.03% private information |

Validators were instructed to be **permissive** — rule an image out only on a clear constraint violation — explicitly so the set is not biased toward images humans find easy.

---

## Result 1 — the drop, and it is differenced

Top-1/top-5 on the **113 ImageNet-overlapping classes**, against the same models' ImageNet accuracy on those same classes: **40–45% lower**, for AlexNet (2012), VGG-19 (2014), ResNet-152 (2016), Inception-v4 (2017), NASNet-A (2018) and PNASNet-5L (2018). ObjectNet accuracy *tracks* ImageNet accuracy across the sequence — the models did improve — and **the gap does not close**.

- The comparison is made against the same model's own pre-shift score on the same class subset, i.e. `F15` of [[wiki/concepts/certification-instruments.md]] satisfied by construction, and it delivers the same verdict ImageNet-C's `Relative mCE` reaches on a disjoint shift family in the same period: six years of architecture progress did not buy the differenced quantity.
- ObjectNet is deliberately **easier** than ImageNet in every other respect — objects centred, rarely and lightly occluded, backgrounds mostly uncluttered — so the drop cannot be charged to a general increase in difficulty.

## Result 2 — the drop decomposes into the three controls, and recomposes

ResNet-152, per-control accuracy on the overlapping classes, distributions reranked best-to-worst within each class and then averaged (a flat curve would mean the control is irrelevant to the model):

| Control | Spread between best and worst setting |
|---|---|
| Object rotation | **20%** |
| Background | **15%** |
| Viewpoint | **15%** |

**The recomposition is the strongest claim in the paper:** selecting only the better-performing settings of the three controls *recreates dataset bias* and restores detector performance to roughly its ImageNet level. So the 40–45% is not a residue of a hundred small differences — it is three named nuisance variables, and the paper can put them back.

Per-class spread is enormous and rarely quoted: plunger, safety pin and drill sit at 60–80%; French press, pitcher and plate below 5%.

## Result 3 — fine-tuning resistance, which is what makes the controls the explanation

As a one-time exception to its own no-training clause, the paper retrains **only the last layer** of an ImageNet ResNet-152:

| Images/class | 113 overlapping classes | all 313 classes |
|---|---|---|
| 0 | 29% | — |
| 8 | 39% | 23% |
| 16 | 45% | 28% |
| **64** (half the dataset) | **50%** | **31%** |

Reference point: across the 11 datasets of Kornblith et al. 2018, **8 images per class** buys ≈**+37%** top-1 (SD 11), with only two datasets below +30 and those because they already started above 60.

**Read it as a validation step, not a result.** The alternative explanation for any hard benchmark is that its images are idiosyncratic — a domain the model has not seen and could cheaply acquire. Fine-tuning is the test of that explanation, and here it fails: the transfer that normally costs 8 images per class costs more than 64 and still lands 45 points below ImageNet. *"Merely seeing images from this dataset does not allow detectors to easily understand the properties of its objects."* **Any benchmark claiming a shortcut has been removed should report this curve** — a shift that fine-tunes away in a few shots was a domain gap, and a shift that does not is a structural one.

## The human reference

**~95%**, "preliminary", across **seven annotators**, on the presence question. No per-item profile, no attempt budget, no exclusion protocol reported — so by [[wiki/concepts/human-baseline.md]]'s parameters it is a solvability certificate and not a denominator. The failure cases are named and are the interesting part: unusual instances of the class, and **degenerate viewpoints** — i.e. the human ceiling is limited by the same control axis the models fail on, at a much later point along it.

---

## What a builder should take

- **The nuisance directions that matter are not image-space operations.** Rotation in depth, viewpoint and object–context relation cannot be produced by a filter over an existing photograph; they require a new photograph. Every augmentation list in the wiki is a list of things you can do to an array ([[wiki/entities/byol.md]], [[wiki/entities/barlow-twins.md]], [[wiki/entities/dinov2.md]]), which is why `G95`'s declared invariance groups omit precisely the variables that cost 40–45% here.
- **A dataset can be an experiment.** Controls are randomised *before* the observation and recorded with it, so the analysis is a factorial read-out rather than a correlational one — the missing methodological half of benchmark construction, and it required no new modelling idea, only a collection platform.
- **Recomposition is the honest test of a decomposition.** Reporting per-control drops is cheap; showing that restoring the favourable settings restores the original score is what licenses the claim that those controls *are* the gap.
- **The 48% discard rate is the cost line to plan against**, and its largest component (23% photographs of screens) is a shortcut the workers invented — the collection process has its own shortcut-learning problem, defended against by manual review of every image.
- `(brainstorm)` **The red border generalises past vision.** A cheap, semantically inert, exactly-searchable marker embedded in every published test item converts contamination detection from a statistical inference over model behaviour ([[wiki/concepts/benchmark-contamination.md]]'s `I19`, and `F14`'s null-equals-worst-case degeneracy) into a **string match over corpora**, run by anyone with corpus access rather than by the model's owner. The text analogue is a per-item nonce token; nobody in the wiki does it.

---

## Limitations

- **The intended solution is still ImageNet's.** Requirement 1 of [[wiki/concepts/certification-instruments.md]] is satisfied only as far as object-category labels satisfy it, so a drop is attributable to a named *nuisance* but not to a named *abstraction* — the complement of [[wiki/entities/pgm.md]], where the shift is declared over the generator's own structure.
- **The rotation histogram is the rotation *requested*.** Workers hit ≈20° of the target depending on the axis, not all objects are equally rotatable, and post-hoc cleaning skews the distribution; the authors state the true rotation distribution is more skewed than the published one.
- **Residual confounds are conceded**: some object classes are more likely to be held than others, some classes are predisposed to particular colours and materials, and shape/texture coverage per class is not guaranteed.
- **The domain is bounded by manipulability** — indoor household objects that a worker can safely move, so nothing large, fixed, dangerous, alive or fragile.
- **The no-fine-tuning clause is a licence, not a mechanism.** The red border makes leakage *detectable*; nothing prevents it, and the same erosion `F1` describes applies.
- **`n` per cell.** 313 classes × ~160 images (SD 44) spread over 4 × 3 × 50 = 600 control combinations means the per-class-per-control cells are tiny, which is why the per-control figures are reported as reranked aggregates rather than as a factorial table.

---

## Comparison

| Benchmark | Shift is declared over | Applied | Needs | Fine-tunes away? |
|---|---|---|---|---|
| **ObjectNet** | background, rotation, viewpoint — randomised **at capture** | to the world, before the photograph | a crowd platform, an AR pose UI, ~1.5 min/image and a 48% discard rate | **No** — 64 images/class buys 21 points where 8 normally buys ~37 |
| [[wiki/entities/imagenet-c.md]] | 15 authored corruptions × 5 severities | to the array, after the photograph | corruption code | Yes, and it did — corruption augmentation is now standard |
| [[wiki/entities/stylized-imagenet.md]] | one nameable feature (texture), crossed against another | to the array, after the photograph | a style-transfer model | It is *designed* to be trained on |
| [[wiki/entities/pgm.md]] | a `[relation, object, attribute]` triple | to the generator | a symbolic generator | n/a — generated |
| [[wiki/entities/conceptarc.md]] | concept instantiation | to the author | a concept inventory + author | n/a |

---

## Connections

- **[[wiki/concepts/certification-instruments.md]]** — supplies **I29**, control-at-capture: the only instrument in the inventory that intervenes on the data-generating process rather than on a finished item, which is what makes pose, viewpoint and object–context shifts available at all; it also contributes the fine-tuning-resistance curve as a *validation* step every shortcut-removing dataset should report, and it satisfies `F15` by construction while returning the same null.
- **[[wiki/entities/imagenet-c.md]]** — the complementary half of the same 2019 verdict and the page whose stated blind spot this one fills: ImageNet-C's 15 corruptions are all 2-D image-space operations and none changes viewpoint, occlusion or object–context relation, so the two together cover the two disjoint halves of the nuisance space, and both report that architecture progress from AlexNet onward moved the raw score and not the differenced one.
- **[[wiki/entities/stylized-imagenet.md]]** — the same year's other answer to the same question, from the opposite end of the nameability axis: a cue conflict reads out *which* feature the rule uses but needs the two features named in advance, while ObjectNet varies nuisance parameters whose effect on the decision rule is never identified — so one returns a rule's content on a nameable shortcut and the other returns a magnitude on an unnameable one.
- **[[wiki/concepts/shortcut-learning.md]]** — the largest single measurement of the page's core claim on natural images: removing three brittle priors that were never part of the task definition costs 40–45%, and *re-adding* them restores the score, so the priors were carrying that share of the decision.
- **[[wiki/concepts/manifold-untangling.md]]** — the missing scoreboard for that page's actual claim: the ventral stream's stated job is tolerance to identity-preserving transformations of pose, position and viewpoint, ImageNet-C omits exactly those, and this is the only benchmark in the wiki that varies them on real images with the value annotated per item — with the rotation control (20% spread) the largest single term.
- **[[wiki/concepts/benchmark-contamination.md]]** — supplies the cheapest *preventive* marker in that page's table: a one-pixel red border makes every published test image reverse-image-searchable, moving leak detection from a statistical inference about a model to a lookup anyone with corpus access can run — the answer to `F14` for datasets that can carry an inert marker.
- **[[wiki/concepts/human-baseline.md]]** — a solvability certificate rather than a denominator (~95%, seven annotators, preliminary, no budget or exclusion protocol stated), and a case where the human failure modes name the same axis as the machine ones (degenerate viewpoints, atypical instances) at a far later point along it.
- **[[wiki/entities/dinov3.md]]** — where this benchmark now sits as a routine robustness column (79.0–80.2 for the 7B model against 66.4 for a size-matched baseline), which is the reading ObjectNet was built to make possible: a number that moves with *what the representation is made of* rather than with ImageNet accuracy.
