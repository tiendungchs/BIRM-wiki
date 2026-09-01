# SpelkeNet and SpelkeBench

**A 7B autoregressive flow-completion world model used as an *instrument* rather than as a predictor: poke a static image with a single synthetic optical-flow token, sample the distribution of flow fields that follow, and read an object off the pixels that consistently move with the poke — objecthood as a statistic of imagined interventions, with no slot, no bottleneck and no segmentation label anywhere in training.**

> **Provenance.** Venkatesh, Kotar, Chen et al. 2025, *Discovering and using Spelke segments* (`raw/venkatesh-2025-spelke-segments.md`), Stanford NeuroAI Lab (Yamins). Builds on **LRAS** (Local Random Access Sequence modeling, Chen et al.) for the backbone and on **CWM** (Counterfactual World Models, Bear et al.) for the probing idea. Named for the Spelke object of [[wiki/concepts/core-knowledge.md]].

Two things make this the wiki's most useful segmentation entry. First, it is the **cohesion detector** that core knowledge's entry condition presupposes and never specifies — learned, self-supervised, from internet video. Second, the structure it extracts is not a label the experimenter supplied, which makes it one of the few instruments in the wiki that reads a *discovered* partition out of a trained model rather than confirming a named one ([[wiki/concepts/representation-probing.md]]).

---

## The object definition

| Ontology | Grouping criterion | Failure it produces on SpelkeBench |
|---|---|---|
| Semantic / instance (COCO, ADE20K) | Category label | Merges independently movable objects; splits objects into parts; admits amorphous "stuff" |
| **SAM** (Segment Anything, supervised, point-promptable) | Visual distinctiveness | Segments logos on bottles, printed designs, shadows, camera lenses, human skin — regions that never move independently |
| Entity segmentation | Category-agnostic "thing"-ness | Closer, but keeps walls, streets, fixed shelves |
| **Spelke object** | **Pixels that move together under an applied force**, category-agnostic | — |

The Spelke definition is the wiki's [[wiki/concepts/causal-model-building.md]] criterion applied to a *partition* rather than to a transition: group by response to intervention, not by appearance. It is not a refinement of semantic segmentation — it cross-cuts it, and the paper's whole benchmark-construction argument is that no existing dataset scores it.

**SpelkeBench**: 500 EntitySeg images filtered in three stages — (1) drop all "stuff" regions, (2) drop functionally immovable "things" (kitchen sinks, traffic signs, large fixtures) by manual inspection, (3) curate for diversity — plus 50 hand-annotated OpenX-Embodiment robot frames. The filtering is manual because the annotation *cannot* be scaled: cohesion, continuity, solidity and contact judgements need a human or a physical interaction, which is the stated reason the discovery method has to be self-supervised.

---

## Architecture: LRAS, and why the sequence format is the load-bearing choice

| | Spec |
|---|---|
| Backbone | LLaMA-architecture autoregressive transformer, **7B**, 32 layers, 4096 embed, 32 heads |
| Vocabulary | Four disjoint integer sets: RGB pointers `I^(rgb)`, RGB content `X`, flow pointers `I^(flow)`, flow content `F` |
| Tokenisation | Convolutional autoencoder quantises each **4×4 pixel patch** into an independent 16-bit code ⇒ 65,536-token RGB vocabulary; a second, similar quantiser for optical-flow patches |
| Sequence | `z = x ⊕ [c] ⊕ f`, each content token paired with a **pointer token** naming its spatial location (one pointer per 4 content tokens in practice); `c` = relative camera-pose token |
| Training | Next-token cross-entropy, seq len 4096, batch 512, 200k steps, **64 H100 × ~14 days**. BVD (7k h internet video) + ScanNet++, CO3D, RealEstate-10K, Kinetics, SSv2, OpenX; flow from SeaRAFT, quantised |
| Labels | **None** — no segmentation supervision at any point |

The `(pointer, content)` pairing is the entire architectural argument, and it is a claim about **interveneability as a design property**:

- Pointer tokens are modality-specific, so appending a flow pointer *asks* the model to decode flow at a named location. The model is queried, not just run.
- Sequences can be assembled in arbitrary spatial order, so a **sparse, localised intervention** is expressible as two appended tokens `[(i_k, f_k)]`. Nothing is masked, inpainted or re-encoded.
- Diffusion models are ruled out for this job explicitly: iterative *global* denoising requires dense conditioning, so a one-pixel counterfactual has no place to go. Vision-language models are ruled out for the same reason at a different granularity — text is a poor control surface for fine-grained spatial intervention.

**(brainstorm)** This generalises past vision and is the transferable half of the paper. The wiki has treated a world model's interface as an afterthought of its objective; here the *format of the input sequence* decides which counterfactual questions the model can be asked at all. A model with a global conditioning interface is not a worse causal model — it is a causal model with no query language.

**Camera conditioning as the disentangler.** Pixel motion in natural video comes from applied forces *or* from the camera. Appending `c = 0` (zero camera pose) tells the model to attribute all motion to external forces. One token converts an ambiguous prediction into an interventional one — the cheapest instance in the wiki of [[wiki/concepts/learned-world-models.md]]'s controllable/non-controllable factorisation, and it is bought at inference time on a model that was never trained to factorise.

---

## The four extractions

All read off `Ψ(z) = {D[i_k] ∀ i_k ∈ I^(flow)}`, the categorical flow distribution the model predicts at every location.

**Flow-token epigraphy** (the enabling trick). Flow tokens are locally quantised but globally decoded, so a single token means nothing in isolation. Each is assigned a 2D vector post hoc by statistical aggregation over the inputs that produced it: `f_j ↦ v_j = (1/|S_j|) Σ_{u ∈ S_j} u`, `S_j = {u ∈ R² : tokenizer(u) = f_j}`. This is what turns a categorical distribution over an opaque codebook into an expectation in physical units.

| Extraction | Formula | What it is |
|---|---|---|
| **Motion affordance map** | `p_motion[i_k] = Σ_{f_j ∈ F_motion} D[i_k, j]`, where `F_motion = {f_j : ‖v_j‖₂ > τ}`, conditioned on `x ⊕ [c=0]` with **no poke** | Per-pixel probability of moving under *some* external force. Sky, walls, floors low; cups, plates, chairs high. A learned movability prior, obtained by summing a token subset |
| **Expected displacement map** | `E_disp[i_k] = Σ_j D[i_k, j] · v_j` (parallel), or `E_disp^seq = (1/T) Σ_t Σ_j f̂_t^(seq)[i_k]·v_j` over `T` autoregressive rollouts | How the whole scene moves given the poke — a dense counterfactual velocity field over a still image |
| **Expected motion correlation** | `dot[u] = (1/R) Σ_{r=1..R} ⟨f^(r), E_disp^(r)[u]⟩`, then **Otsu threshold** | The segment. Averaging the poke·response inner product over `R` diverse poke directions suppresses unprompted flow elsewhere (it varies across pokes and diverges in direction), leaving only pixels bound to the poked one |
| **Pairwise affinity** | motion descriptor `φ[u] = [f̂¹_(1,1)(u), …, f̂^t_(n,r)(u)] ∈ R^{2NRT}`; `A[u,v] = φ[u]ᵀφ[v]` | The **pairwise causal structure of the scene in motion space** — the full graph, of which one segment is one thresholded row |

**Auto-discovery** clusters `A` by an iterative select–threshold–refine loop: pick the probe centre whose affinity row has the highest mean (strongest binding to the rest of its object), Otsu-threshold it into `M⁽⁰⁾`, average the affinity rows of all remaining probe points inside `M⁽⁰⁾`, re-threshold, remove the covered centres, repeat until no probe points remain.

**Two sources of sample diversity, and the second is unusual.** (i) Sampling flow tokens from `D[i_k]`; (ii) **varying the autoregressive decoding order** — because earlier-decoded tokens condition later ones, decoding the torso before the leg yields a globally different completion than the reverse. Random-access decoding turns permutation of the generation order into a legitimate posterior-exploration knob, which a raster-scan model does not have.

---

## Results

**Point-prompted segmentation** (prompt = centroid of the ground-truth segment; 8 poke directions × 3 rollouts):

| | SAM2 (heira-L, **supervised**) | DINOv1-B/8 | DINOv2-L/14 | DINOv2-G/14 | CWM | **SpelkeNet** |
|---|---|---|---|---|---|---|
| Average Recall | 0.4816 | 0.2708 | 0.2524 | 0.2254 | 0.3271 | **0.5411** |
| mIoU | 0.6225 | 0.4990 | 0.4931 | 0.4553 | 0.4807 | **0.6811** |

**Automatic (unprompted) discovery** — the ranking does not survive:

| | SAM2 | CutLER | ProMerge | **SpelkeNet** |
|---|---|---|---|---|
| AP | 0.11 | 0.41 | **0.42** | 0.35 |
| AR | **0.62** | 0.32 | 0.34 | 0.46 |
| mIoU | **0.68** | 0.42 | 0.43 | 0.57 |
| F1 | 0.17 | 0.34 | 0.36 | **0.38** |

**Downstream — 3DEditBench** (100 real images with ground-truth 3D-transformed counterparts). Same editing pipeline, SAM mask swapped for a SpelkeNet segment. Edit Adherence = IoU between predicted and ground-truth segment in the *edited* image:

| Editing model | EA with SAM | EA with SpelkeNet | Δ |
|---|---|---|---|
| LRAS-3D | 0.633 | **0.776** | +0.143 |
| LightningDrag | 0.536 | **0.679** | +0.143 |
| DiffusionHandles | 0.495 | **0.576** | +0.081 |
| Diffusion-as-Shader | 0.503 | **0.640** | +0.137 |

MSE, PSNR, LPIPS and SSIM improve on every row too. The result that matters is the *invariance*: four unrelated editing architectures, one segmentation swap, the same ~0.08–0.14 gain. The choice of ontology, not the choice of generator, is what was limiting.

---

## The failure modes are diagnostic

| Model | How it fails | Diagnosis |
|---|---|---|
| **SAM** (supervised) | Splits objects into visually distinct sub-parts; segments texture and print | Trained on an ontology defined by visual distinctiveness. Its errors are *correct* under its own definition |
| **DINO** (contrastive SSL) | **Merges same-category instances** | The contrastive objective pulls instances of one category together by construction, so it cannot individuate them. A representational commitment made at pretraining time that no readout can undo |
| **CWM** (deterministic counterfactual probe) | Diffuse flow fields; merges nearby objects | Regression to the conditional *mean* over multimodal outcomes. Poking a hand has two valid answers — the hand moves alone, or the whole person translates — and averaging them blurs both. Compounded by intervening in **RGB** (copy a patch elsewhere), which mis-states appearance under new lighting/occlusion |
| **SpelkeNet** | Auto-discovery underperforms its own prompted result | Poke-point selection, not segment extraction (below) |

**The CWM→SpelkeNet delta is the wiki's cleanest evidence that a counterfactual probe needs a *distribution*, not a prediction** (AR 0.327 → 0.541, mIoU 0.481 → 0.681, same probing logic). Determinism is not a mere efficiency choice: where the world's response to an intervention is genuinely multi-modal, a conditional-mean predictor answers a question nobody asked. This is [[wiki/concepts/learned-world-models.md]]'s transition trichotomy — deterministic vs stochastic — showing up in a *perception* module, and with the failure visible as blur in the output rather than as planner exploitation.

---

## Emergent extractions the authors did not train for

| Finding | Evidence | Why it matters here |
|---|---|---|
| **Support hierarchy** | Poking the object at the bottom of a stack returns a segment containing every object it supports | The model has the *contact/support* relation of intuitive physics, readable by the same probe with no change. A relational edge, extracted by an operation designed to extract nodes |
| **Material properties** | `p_motion` is near-uniform across rigid objects (laptops, cardboard boxes) and **localised near the poke** for deformable ones (cloth, plastic covers) | A rigidity readout for free. The *shape of the affordance map*, not its magnitude, carries the material type |

Both are qualitative (figure-level, no metric). They are listed because they say the probe is a general structure-extraction interface on a world model, not a segmentation algorithm — and the paper closes by nominating time-lapse microscopy (intracellular structures) and galaxy-evolution data (gravitationally bound systems) as domains where nobody has an objecthood prior to supply.

---

## Limitations

- **Auto-discovery is bottlenecked on choosing where to poke.** Given the right point prompt the model beats a supervised baseline; asked to choose its own prompts from `p_motion`, it loses to SAM2 on AR and mIoU. The authors attribute this to poor flow rollouts from sub-optimal samples and to the clustering strategy. This is gap **G60** with an unusually clean measurement: the model *does* choose its own retrieval query, and query selection is where it loses the advantage its extraction machinery earned.
- **Cost.** Each segment needs `R` pokes × `T` autoregressive rollouts of a 7B model over a full flow field; the affinity matrix needs `N × R × T` completions for one image. Sequential decoding is stated as better than parallel and "more expensive to compute", with no numbers given. No latency figure appears anywhere in the paper — which, by [[wiki/concepts/learned-world-models.md]]'s G62 argument, is half of the utility measurement.
- **Thresholds everywhere.** `τ` (what counts as motion), `τ_p` (which pixels can be poked), and Otsu at two places. Otsu is at least a *derived* threshold (it maximises inter-class variance of the observed histogram) rather than a hand-set constant, which is more than any boundary detector on [[wiki/concepts/event-segmentation.md]] manages.
- **Movable-only by construction.** Stage 2 of the benchmark deletes functionally immovable objects, so the evaluation never asks the model to individuate a wall, a shelf or a road. A robot planning around obstacles needs exactly those.
- **The proposed fix reintroduces the supervision.** The authors' named next step is to **distil** the auto-discovered segments into a SAM-style architecture. That would trade the query language for speed — a distilled segmenter cannot be poked.
- **No agency.** Every intervention is imagined. Nothing is ever poked in the world, so nothing checks that the model's counterfactual is right; the benchmark scores it against *human* Spelke judgements, not against physics.

---

## Comparison to the wiki's other entity-discovery routes

| Route | Where entities come from | Cost |
|---|---|---|
| **Slot architectures** (MONet, Slot Attention, SAVi, C-SWM, FOCUS) | An architectural bottleneck: `K` competing latent slots with a soft attention bottleneck, trained by prediction or contrast | Does not scale to real scenes — too many slots gives degenerate solutions, too few makes reconstruction ill-posed. `K` is a hyperparameter of the *architecture* |
| **CWM** | Deterministic counterfactual probe on a regression video model | Blurred multimodal responses; RGB-patch interventions mis-state appearance |
| **SpelkeNet** | A **statistic over the samples** of an unconstrained generative model. No slots, no `K`, no object variable anywhere in the network | Inference-time expense; the number of segments comes out of a clustering loop rather than being fixed, so it is unbounded and unaudited |
| **Effect-equivalence** ([[wiki/concepts/affordance-grounded-symbols.md]]) | Real actions on real objects, grouped by shared effect | Needs an embodied agent and a repertoire; recovers only distinctions some action makes |
| **Event segmentation** ([[wiki/concepts/event-segmentation.md]]) | Change in the active predictive-encoding set | Carves *time*, not space; detector unlearned |

Recorded as [[wiki/empirical-tensions.md]] T151.

---

## Connections

- **[[wiki/entities/dinov3.md]]** — the successor to the baseline this page critiques, and the critique survives it: sharper, artifact-free patch features fix *class-agnostic* object discovery (where DINOv2 fails outright despite strong dense probes) without giving the encoder any way to individuate two instances of one category — so instance-merging is a commitment of the discriminative objective, not a resolution limit of the feature map.


- **[[wiki/concepts/counterfactual-probing.md]]** — the method abstracted away from vision: this page is its worked instance and its only quantitative evidence, and the CWM comparison is where the "aggregate over a distribution, not a prediction" requirement gets its number.
- **[[wiki/concepts/core-knowledge.md]]** — supplies the definition (a Spelke object is the entity type the object system admits) and receives the missing mechanism: the cohesion detector that the entry condition presupposes, learned from unlabeled video rather than stipulated (that page's last open problem, gap G23).
- **[[wiki/concepts/causal-model-building.md]]** — the criterion made into a partition: this groups pixels by response to intervention rather than by appearance, and it gets its interventional data from a *model* rather than from acting, which is the one route to causal data that costs neither an agent nor a labelled generative trace.
- **[[wiki/concepts/learned-world-models.md]]** — a fourth role for the same object, alongside neural simulator / dynamics model / reward model: the world model as a **structure-extraction instrument**, queried by intervention and never rolled out for control at all; and the deterministic-vs-stochastic transition distinction reappearing as a perception failure (CWM's blur).
- **[[wiki/concepts/representation-probing.md]]** — the complementary instrument: that page's probes fit a decoder from activations to a *named* structure, this one intervenes on the input and clusters the output distribution, so it returns a partition nobody labelled and escapes the labels-are-the-answer circularity of gap G17.
- **[[wiki/concepts/event-segmentation.md]]** — the sibling answer to gap G27 on the orthogonal axis: that page cuts the stream into temporal nodes by predictive change, this one cuts the frame into spatial entities by co-response to imagined force, and neither mechanism produces the other's units.
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the same carving criterion (group by intervention response) with the intervention imagined instead of executed: it needs no body and no repertoire, and it pays by never checking its counterfactual against the world.
- **[[wiki/concepts/attention.md]]** — the object system's entry condition is what object-based attention inherits, so a learned cohesion detector is also a proposal for what an attentional unit *is* in a system that was never given objects.
- **[[wiki/entities/v-jepa-2.md]]** — the opposite bet on the same substrate: predict in an abstract embedding space so detail can be discarded, versus predict in an explicit quantised flow space so a localised counterfactual can be *addressed* — one buys planning latency, the other buys a query language (tension T18, T152).
- **[[wiki/entities/adaworld.md]]** — the mirror image on the action side: there the model induces a latent action alphabet and applies it to a *whole frame*, here the action is a single hand-specified flow vector at one named pixel and the output is a partition; both use a world model to recover a vocabulary nobody labelled.
- **[[wiki/entities/gcq.md]]** — the other entry in this wave whose discrete codes come from quantising flow/observation patches, and the contrast is instructive: there the codebook is installed and interpretable by construction, here the flow codebook is learned and *uninterpretable*, requiring post-hoc epigraphy to recover what each token means.
- **[[wiki/entities/arc-agi.md]]** — the benchmark that declares Spelke's four core systems as its complete prior list and then hands the grid to the solver already discretised; SpelkeNet is what would have to run first if the same tasks arrived as pixels.
- **[[wiki/concepts/shortcut-learning.md]]** — DINO's instance-merging is the cleanest case in the wiki of an objective's shortcut becoming a *permanent* representational commitment: the contrastive loss is defined to collapse same-category instances, so no readout can individuate them afterwards.
- **[[wiki/entities/neo-neural-theorizer.md]]** — the same intervention move in a different slot: both override a model's own conditioning to read structure out of it, but this page pokes a *stochastic* model and reads a partition, while NEO's executor is deterministic — the property this page's negative control (CWM) shows is fatal when the true response is plural.
- **[[wiki/entities/dinov2.md]]** — the primary source for this page's segmentation baseline, and the other half of the same objective's ledger: the discriminative loss that merges same-category instances also produces *part* correspondence across pose, style and category, so what it forbids within a category it buys across objects.
- **[[wiki/concepts/independent-causal-mechanisms.md]]** — the closest thing in the wiki to a measurement of ICM's influence clause: grouping sites by co-response to an imagined force recovers the units that can be intervened on separately, with no object variable anywhere in the model.
