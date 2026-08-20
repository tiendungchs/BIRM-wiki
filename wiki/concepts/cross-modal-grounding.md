# Cross-Modal Grounding

**Grounding is attaching a linguistic symbol to the visual entity, attribute or *relation* it denotes, such that the binding survives rearrangement of the scene — and the measured state of the art is that objects bind and relations do not.**

> **Provenance.** `raw/bordes-2024-vision-language-modeling.md` — Bordes, Pang, Ajay, Li, Bardes, Petryk, Mañas, Lin, Mahmoud, Jayaraman, Ibrahim, Hall, Xiong, Lebensold, Ross, Jayakumar, Guo, Bouchacourt, Al-Tahan, Padthe, Sharma, Xu, Tan, Richards, Lavoie, Astolfi, Askari Hemmat, Chen, Tirumala, Assouel, Moayeri, Talattof, Chaudhuri, Liu, Chen, Garrido, Ullrich, Agrawal, Saenko, Celikyilmaz & Chandra, *An Introduction to Vision-Language Modeling*, arXiv:2405.17247, 2024. A **tutorial/survey**: every result below is reported there and attributed to its own source, not reproduced there. Claims that go beyond it are marked `(brainstorm)`.

This is the wiki's third grounding page and the only one where the symbol arrives from *outside*. [[wiki/concepts/affordance-grounded-symbols.md]] derives a symbol from what actions do to a thing; [[wiki/concepts/abstract-structural-codes.md]] derives one from graph position. Here the symbol is a word in a human corpus and the problem is *alignment*: find a map from that fixed vocabulary onto visual content. The lesson the field has paid for is that alignment does not decompose — a training signal that binds nouns to objects does **not** thereby bind prepositions to relations, and the reason is measurable in bits (below).

---

## The four training paradigms, and the one frame that unifies them

| Family | Objective | What `Z` is | Cost profile |
|---|---|---|---|
| **Contrastive** (CLIP, SigLIP, Llip) | InfoNCE over image/caption pairs; negatives = the *other captions in the minibatch* | Two encoders mapped into one shared space | Needs very large batches and corpora (CLIP: 400M pairs); no decoder, so "what does this embedding look like?" costs a `k`-NN over millions of images |
| **Masking** (FLAVA, MaskVLM) | Reconstruct masked image patches given unmasked text, and masked words given the unmasked image | Per-modality encoders + a fusion encoder | No batch dependency (no negatives ⟹ small batches, no temperature to tune); pays for a decoder back to input space |
| **Generative** (CoCa, Chameleon/CM3leon, Stable Diffusion, Parti) | Generate the caption, the image, or both | An implicit *joint* distribution over text and pixels | Most expensive to train; the only family whose latent can be inspected by decoding it |
| **Non-contrastive joint embedding** (VICReg, [[wiki/entities/vicreg.md]]) — *not in the survey's taxonomy; added here* | Squared distance between the two modalities' embeddings, plus a per-branch variance hinge and covariance decorrelation | Two independently regularised encoders in one space, no weight sharing, no shared architecture, no shared dimension | **No negatives at all**, so no batch dependency and no noise distribution to design; the anti-collapse coefficients are per branch. Demonstrated only at small scale (MS-COCO image↔caption R@1 33.6/45.2 vs a contrastive VSE++ at 30.3/41.3; ESC-50 waveform↔spectrogram 78.4 vs 72.7 supervised) |
| **Pretrained backbones** (Frozen, BLIP-2, MiniGPT, Qwen-VL, LLaVA) | Learn only a projection from a frozen vision encoder into a frozen LLM's token space | A mapping between two *given* spaces | Cheapest by orders of magnitude (MiniGPT-4: 4×A100 for ~10 h); inherits both models' biases and the LLM's hallucinations |

**The families are not mutually exclusive** — most systems mix criteria — and one information-theoretic statement covers all of them (Dubois et al.; Federici et al., as presented in §2.3.3). Any transformation `f(X)` of the data induces an equivalence relation partitioning `f(𝒳)` into classes, with the requirement `f(x) ∼ f(x′) ⟹ p(z|f(x)) = p(z|f(x′))`. Masking, augmentation, *and the choice of which modality to look at* are all instances of `f`. Training is then a rate–distortion problem:

```
argmin_{p(z|x)}   I(f(X); Z)  +  β · H(X | Z)
                  └── rate ──┘   └ distortion ┘
```

| Term | Set by | Implementations |
|---|---|---|
| **Rate** `I(f(X);Z)` | the **data transformation**, not the loss | In masking VLMs the entropy bottleneck is bounded by a constant fixed by how much the masking removed |
| **Distortion** `H(X|Z)` | the **loss** | Auto-encoding bounds it by reconstruction; InfoNCE bounds it by scoring the *equivalence of two representations* — i.e. contrastive learning is compression **without** data reconstruction |

**The row above changes what is fixable and what is not.** The rate bound below is a property of the *data*, so it binds every family including the non-contrastive one — a 77-token caption caps the shared embedding no matter how the two branches are regularised. What the non-contrastive row removes is the separate, *objective*-side defect: with no negatives there is no noise distribution, hence no "two arrangements of one scene are almost never contrasted" failure. The two problems have been running together in this page's account of CLIP and they separate cleanly here **(brainstorm)** — which makes the untested prediction sharp: a VICReg-style image–text embedding should fail the relation benchmarks *just as badly* (rate), while being immune to the specific shortcut negatives author (distortion).

**The consequence that matters for grounding, and the reason relations fail:** for a multimodal VLM, *the information in `Z` is reduced to the minimum available from either source.* A caption is a short lossy summary of an image — the CLIP tokenizer caps at 77 tokens, ≈50 English words — so the rate term is set by the caption, and **everything the caption habitually omits is not merely unlearned but actively squeezed out of the representation.** Web alt-text names objects; it rarely specifies which is left of which, how many there are, or what is *not* present. The failure profile below is what that bottleneck looks like from the outside.

**(brainstorm)** This turns "improve grounding" from an optimisation problem into a **rate** problem, and it predicts the ordering of the repairs that work: dense captions (DCI: >1000 words per image, annotated per Segment-Anything region) raise the rate; bounding boxes raise it; hard negative captions do *not* raise it but re-shape the equivalence classes so that two captions differing only in word order stop being in the same class. It also predicts the one repair nobody in the survey tries: **drop the caption as the sole channel** and let a second view of the *image* carry the rate — which is exactly what the vision-only self-supervised lineage does, and is the mechanism behind T149.

---

## The failure profile

| Ability | Status | Instrument |
|---|---|---|
| Object naming | Works | Zero-shot ImageNet — a ResNet-101 CLIP matches a *supervised* ResNet at 76.2% and beats it on robustness benchmarks |
| **Spatial relations** | **At or below chance** | PUG (Photorealistic Unreal Graphics): a scene built one element at a time — background, then animal, then the animal moved left/right. VLMs are "not performing better than random chance when evaluating spatial relations" |
| **Word order / relation direction** | Fails | Winoground: two images, two captions differing *only* in word order ("some plants surrounding a lightbulb" vs "a lightbulb surrounding some plants"); score the correct pairing higher |
| **Attributes, relations, order** | Fails | ARO: negatives made by swapping the relation, attribute or order ("A horse eating grass" → "grass eating a horse") |
| Counting, negation | Fails | Named as open in §1 and §3.4; no benchmark singled out |
| Fine-grained scene detail | Fails | DCI crop–caption matching: match each sub-image to its own sub-caption |
| Physical plausibility **in video** | **At chance, humans >80%** | Synthetic videos that obey or violate physics (a ball that vanishes); VideoLLaMA and PandaGPT do not exceed random ([[wiki/concepts/violation-of-expectation.md]]) |

**The relation slot is the whole deficit**, and it is the same localisation the caption-network failures gave qualitatively ("a man thrown off a horse" → "a woman riding a horse", [[wiki/concepts/compositionality.md]]) now with paired-image controls behind it. Parts recovered, arrangement not represented.

---

## The instrument is broken in three separate ways

Every repair below is cheap, and none is standard practice. This is a G17 problem inside the field that most needs it.

**1. A model with all parameters equal to zero scores 100%.** Most compositional benchmarks are binary discriminations (correct caption vs perturbed caption) scored by `argmax`. They do not handle ties — and a model that has **collapsed**, assigning both captions the same representation, produces exactly a tie. `argmax` on a tie returns the first element, and the correct caption is conventionally placed first. *The field's principal instrument for the property that collapse destroys is maximally fooled by collapse.* The survey's own recommended fix is one line: add an epsilon of noise, or track ties explicitly. This is the sharpest concrete instance in the wiki of gap **G34** meeting gap **G17**.

**2. The negative caption has no negative image, so language priors suffice.** ARO-style benchmarks generate negatives procedurally and cheaply but supply no image matching them. A "coffee cup" is always photographed on a table, so a model can score the pair from *caption plausibility alone* without consulting the image — the surprisingly-strong-baseline problem of [[wiki/concepts/shortcut-learning.md]], built into the benchmark's construction rather than into the model. Two fixes, with different costs: Winoground finds a real image for the negative caption (expensive, small); PUG *renders* the paired scene with one element moved (cheap, synthetic, and the only design that can separate "did not recognise the object" from "recognised both objects and not the relation").

**3. Procedural negatives are detectable as text.** Hard negatives generated by swapping words are frequently ungrammatical or incoherent, so the discrimination is solvable by a fluency judgement with no visual content at all; SUGARCREPE regenerates them with an LLM to close the channel.

**A fourth instrument worth stealing for probing generally.** *Déjà vu memorization*: CLIP models remember objects present in a training image even when the caption never mentions them. The measurement is the interesting part — a `k`-NN decode of objects from the caption embedding is run twice, once on the target model and once on a **reference model trained without that image–caption pair**, and memorization is the *gap*. This is the same differencing move as scoring against `n = 20` randomly-initialised networks ([[wiki/concepts/violation-of-expectation.md]]): a per-item null that separates "this model memorised it" from "this correlation is in the world". The reported mitigation is text randomization — mask a random fraction of caption tokens each epoch — which in the rate–distortion frame is *lowering the rate on purpose*.

---

## Repairs that are actually deployed

| Repair | Mechanism | Limit named by the source |
|---|---|---|
| **Bounding-box supervision** (X-VLM) | Box regression + IoU loss ties each caption fragment to a region; 16M images with box annotations | Requires annotation at scale |
| **Pseudo-labelled boxes** (Kosmos-2) | Extract nouns with spaCy, run a grounding detector (GLIP) to box them, pair each box with its expression — web-scale and free | Bounded by the detector: rare nouns it fails on become failures the downstream VLM inherits. A grounding model trained on another grounding model's output cannot exceed it |
| **Negative captioning** | Add procedurally-generated wrong captions as hard negatives during *training*, not just evaluation | Re-shapes the equivalence classes; does not add rate |
| **Dense captions** (DCI) | Segment the image (Segment Anything), have humans describe each part, >1000 words per image, 7,805 images | Human annotation cost caps the corpus at evaluation/fine-tuning scale, not pretraining scale |
| **Instruction tuning + RLHF** (LLaVA 1.5/-RLHF/-NeXT) | Align outputs with human preference | Addresses what the model *says*, not what it represents |

---

## The decoder question

The survey states the disagreement in its own words: *"Some researchers argue that having the ability to generate images given words is an important step towards creating a good world model while other researchers argue that such a reconstruction step is not needed."* The second position is the JEPA lineage's founding commitment ([[wiki/entities/h-jepa.md]], [[wiki/entities/v-jepa-2.md]], [[wiki/entities/lewm.md]]) — predict in representation space, never in pixels.

The evidence the survey assembles cuts the other way, and it cuts precisely on **relations**. A conditional generative model is a classifier by Bayes' rule with no retraining:

```
p_θ(c_i | x) = p(c_i) · p_θ(x | c_i) / Σ_j p(c_j) · p_θ(x | c_j)
```

— autoregressively `log p_θ(x|c) = Σ_k log p_θ(t_k | t_<k, c)` over image tokens, or for diffusion `log p_θ(x|c) ∝ −E_{t,ε}‖ε − ε_θ(x_t, c)‖²`. This is *analysis by synthesis*, the oldest idea in the book (Naive Bayes, LDA), viable again only because the generative models got good. Four reported advantages:

| Property | Finding |
|---|---|
| **Compositional reasoning** | Generative classifiers **far outperform** discriminative methods like CLIP on Winoground — the exact benchmark where the whole field fails |
| Effective robustness | Better out-of-distribution performance at matched in-distribution accuracy |
| Shape bias | More shape bias and better alignment with human judgement than discriminative models — i.e. the [[wiki/concepts/shortcut-learning.md]] texture shortcut is weaker |
| Test-time adaptation | Can be jointly adapted with a discriminative model using *unlabelled* test examples, helping under online distribution shift |

The cost is inference: diffusion classification needs hundreds to thousands of network evaluations per test image, scaling with the number of classes. Recorded as **T162**.

**(brainstorm)** The rate–distortion frame says why this is not a coincidence. Reconstruction is a distortion term that charges for *every* omitted bit of `x`; InfoNCE is a distortion term that charges only for confusing `x` with a batch-mate. Two images differing only in the arrangement of the same objects are near-identical under a bag-of-objects code and are almost never each other's hard negative in a random minibatch, so the contrastive distortion is nearly blind to arrangement *by construction* — while the reconstruction distortion is not, because the pixels move. If that is the mechanism, the JEPA position survives intact in a repaired form: what is needed is not a decoder to pixels but a distortion term that prices arrangement, and the cheapest available one is a **paired negative image** rather than a paired negative caption.

---

## Video makes the rate problem explicit

- **Temporal supervision barely exists.** Internet captions describe scene *content*, not motion. The survey's phrasing: this makes "a video model downgrade to an image model". CLIP models trained on video exhibit a **noun bias**, which is a rate statement — the caption channel carries objects and not interactions.
- **Compute makes it worse.** 24 fps costs 24× storage and processing over the same content, and successive frames are far more redundant than pixels within a frame. So the modality with the most information per second is the one on which the least supervision exists.
- **The repair is to drop the caption.** VideoPrism trains a video encoder on video alone, explicitly to limit the impact of imperfect captions.
- **Benchmarks mostly do not need time.** "Which sport are people playing?" over a football match is answerable from one frame; EgoSchema and the ActivityNet/MSVD/MSRVTT-QA family are the exceptions that force frame retrieval or action localisation.

---

## "Zero-shot" is a data-coverage measurement

Zero-shot performance of VLMs depends mostly on **how much the downstream concept is present in the pretraining data** (Udandarao et al., cited in §3.1), and every CLIP variant — including the deliberately balanced MetaCLIP, which caps each of 500k Wikipedia/WordNet queries at 20k samples — still shows imbalanced performance across downstream concepts, because web data is long-tailed. Data *pruning* beats the scaling law (DataComp), which relocates the lever from quantity to curation.

This is [[wiki/concepts/skill-acquisition-efficiency.md]]'s point arriving from the multimodal side: a "zero-shot" score is a purchase, priced in pretraining frequency, and it certifies nothing about generalisation difficulty.

---

## Reading in the core framing

| VLM object | Latent-graph reading |
|---|---|
| Noun ↔ object binding | Node labelling — solved, at web scale |
| Preposition/verb ↔ relation binding | **Edge** labelling — the gap. Gap **G4** (vocabulary co-discovery) with the vocabulary *given* and still not attaching |
| Caption as training signal | A rate limiter on the instance-graph: whatever the caption omits cannot survive in `Z` |
| Contrastive objective | Learns the node set; is nearly blind to the arrangement, because two arrangements of the same nodes are not each other's negatives |
| Bounding boxes | An explicit binding channel, hand-supplied — the [[wiki/concepts/shortcut-learning.md]] *data* lever spent on the relation slot |

**The transferable conclusion for a builder:** language is an attractive supervision channel because the vocabulary is free and already compositional, and it is a *bad* one for structure because natural captions are node-lists. A model that needs edges must get them from a channel that carries edges — paired scenes differing by one relation, boxes, dense annotation, or the agent's own actions ([[wiki/concepts/affordance-grounded-symbols.md]]) — and no amount of caption data substitutes.

---

## Open problems

- **No repair addresses relations directly.** Boxes localise *objects*; dense captions describe *regions*; hard negatives perturb *text*. Nothing supervises a relation as a first-class object, which is why IRENE's result (hand the model typed spatial edges and message passing, and binding still fails at chance — [[wiki/entities/irene.md]]) is not contradicted by any repair here.
- **Is the bottleneck the rate or the objective?** The rate argument predicts that dense captions alone should fix relations; the distortion argument predicts they should not, because arrangement is still not priced. Both are testable on DCI and neither test is reported. **A third experiment has now been run and it favours the objective** (Chen et al. 2025, [[wiki/entities/vl-jepa.md]]): hold the corpora — and therefore the rate — fixed, and change only how the caption is consumed, from a contrastive partner to a JEPA prediction *target* whose encoder is trained at 0.05× learning rate. Text hard-negative discrimination rises above CLIP, SigLIP2 and Perception Encoder from a smaller text encoder (SugarCrepe++ 63.9 vs 58.6; VISLA 42.9 vs 40.4), with the gain concentrated in the **swap** categories — the ones that reorder a fixed word bag — and Replace-Relation at a tie. Two things stop it from settling the question: the protocol is text-only, so it measures the caption *encoder* and not the image↔relation binding the page is about; and it is an `argmax` triplet benchmark with no reported tie-handling, i.e. bug 1 above.
- **The tie-break bug's blast radius is unknown.** Published numbers on Winoground/ARO/SUGARCREPE-family benchmarks were mostly produced without the check. Nobody has re-scored them.
- **Generative classifiers are impractical at inference**, so the compositional advantage is currently unusable in any deployed system — and there is no analysis separating how much of it comes from *modelling pixels* versus from *Bayes-rule scoring over an explicit hypothesis set*, which a discriminative model could also be given.
- **Cross-modal memorization has no general probe.** Joint-embedding VLMs have no decoder, so the déjà vu test needs a `k`-NN over a held-out public set plus a second trained model; there is no way to ask a CLIP directly what it memorised about an image.

---

## Connections

- **[[wiki/entities/vl-jepa.md]]** — a partial answer to this page's rate-vs-objective question: with the caption corpora and hence the *rate* unchanged, consuming captions as a JEPA prediction *target* rather than as a contrastive partner lifts hard-negative text discrimination above CLIP, SigLIP2 and Perception Encoder (SugarCrepe++ 63.9 vs 58.6) from a smaller text encoder — concentrated in the word-order **swap** categories, tied on Replace-Relation, and text-only, so image↔relation binding is still unmeasured and the tie-break bug still unhandled.
- **[[wiki/entities/dinov3.md]]** — the rate argument's widest measured margin: the best language-supervised encoder scores **0.5** GAP on Met instance retrieval against 55.4, and 23.1 against 58.7 on dense semantic correspondence, while beating the self-supervised model on ImageNet-A — captions carry category and carry neither identity nor geometry.


- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the same word, opposite direction: there a symbol is *derived* from the effects of the agent's actions and needs no corpus; here the symbol is given by language and only the mapping is learned — which is why that route grounds relations (effects are relational) and this one grounds nouns.
- **[[wiki/concepts/compositionality.md]]** — supplies the diagnosis this page measures: objects recovered, arrangement not represented, so the caption defaults to the most frequent training arrangement; Winoground/ARO/PUG are that failure with paired controls.
- **[[wiki/concepts/shortcut-learning.md]]** — three benchmark-side shortcuts documented here (language priors with no negative image, procedural negatives detectable as ungrammatical text, and an `argmax` tie-break a zero model wins), plus the finding that zero-shot scores track pretraining concept frequency.
- **[[wiki/concepts/divergence-objectives.md]]** — the rate–distortion statement that unifies the four families: rate is fixed by the data transformation, distortion by the loss, and contrastive learning is compression *without* reconstruction.
- **[[wiki/entities/vicreg.md]]** — the multimodal joint embedding with no negatives anywhere, which removes this page's noise-distribution defect while leaving its rate bound untouched: the two branches are regularised separately, so image and caption encoders need share neither architecture nor output dimension.
- **[[wiki/concepts/energy-based-models.md]]** — the derivation of the contrastive family used here: InfoNCE is an NCE approximation to an energy model's intractable negative-sample term, and CLIP's noise distribution is literally "the other captions in this minibatch".
- **[[wiki/concepts/violation-of-expectation.md]]** — an independent replication of that page's null result on a different model class: VideoLLaMA and PandaGPT do not exceed chance on physics-violating videos where humans exceed 80%; and the déjà vu reference-model gap is the same differencing move as the untrained-network null.
- **[[wiki/concepts/representation-probing.md]]** — a probe that needs a second *trained* model rather than a second read-out: memorization is only defined as a gap against a reference model that never saw the item, which is the strictest control any probe in the wiki uses.
- **[[wiki/entities/v-jepa-2.md]]** — the counter-case that makes the rate argument concrete: a video encoder trained with no language at all beats language-supervised encoders at feeding a language model ([[wiki/empirical-tensions.md]] T149), which is what should happen if the caption is the bottleneck rather than the bridge.
- **[[wiki/entities/h-jepa.md]]** — the position this page's generative-classifier evidence attacks (**T162**): reconstruction is held unnecessary, yet the models that reconstruct are the ones that win on the compositional benchmark.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — "zero-shot" performance tracking pretraining concept frequency is that page's purchase argument measured in a corpus: the score is bought, and buying it certifies no generalisation.
- **[[wiki/concepts/language-of-thought.md]]** — the contrast that sharpens both: a language of thought is compositional *because it has a syntax*, whereas a VLM ingests natural-language strings and recovers only their lexicon — evidence that consuming compositional text does not install compositional structure.
- **[[wiki/entities/irene.md]]** — the control that rules out the easy explanation: giving a model typed spatial relations and a message-passing architecture does not produce binding either, so the deficit is not merely that captions lack relational vocabulary.
- **[[wiki/concepts/learned-world-models.md]]** — the survey's own framing of the decoder debate is a world-model debate: whether being able to generate the observation is constitutive of having a model of it, or an expensive read-out of one.
- **[[wiki/entities/dinov2.md]]** — the sharpest test of this page's rate bound, on a quantity no caption carries: a language-supervised encoder five times larger loses on all three monocular-depth benchmarks (NYUd RMSE 0.541 vs 0.344) to self-supervised features, and even a 300M self-supervised iBOT beats a 1.8B OpenCLIP there.
- **[[wiki/concepts/cross-embodiment-transfer.md]]** — the same binding problem with a third term added: a language instruction is the most body-independent rung of that page's ladder and the only one with a vocabulary humans already agree on, which is why the robot-policy field's hierarchies pass *sentences* between levels rather than latents (Kawaharazuka et al. 2025).
