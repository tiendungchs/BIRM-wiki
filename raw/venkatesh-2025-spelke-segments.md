# venkatesh-spelke-segments-2025

> Converted from `venkatesh-spelke-segments-2025.pdf` on 2026-08-18 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

<u>Stanford NeuroAI Lab</u>

## **Discovering and using Spelke segments**

**Rahul Venkatesh** <sup>_∗,_</sup> <sup>1</sup> <sup>_,†_</sup>, **Klemen Kotar** <sup>_∗,_</sup> <sup>1</sup>, **Lilian Naing Chen** <sup>_∗,_</sup> <sup>1</sup>,
**Seungwoo Kim** <sup>1</sup>, **Luca Thomas Wheeler** <sup>1</sup>, **Jared Watrous** <sup>1</sup>, **Ashley Xu** <sup>1</sup>, **Gia Ancone** <sup>1</sup>,
**Wanhee Lee** <sup>1</sup>, **Honglin Chen** <sup>2</sup>, **Daniel Bear** <sup>3</sup>, **Stefan Stojanov** <sup>1</sup>, **Daniel Yamins** <sup>1</sup> <sup>_,†_</sup>

1Stanford University, 2OpenAI, 3Noetik Inc.

**Abstract.** Segments in computer vision are often defined by semantic considerations and are highly
dependent on category-specific conventions. In contrast, developmental psychology suggests that
humans perceive the world in terms of Spelke objects—groupings of physical things that reliably
move together when acted on by physical forces. Spelke objects thus operate on category-agnostic
causal motion relationships which potentially better support tasks like manipulation and planning. In
this paper, we first benchmark the Spelke object concept, introducing the **SpelkeBench** dataset that
contains a wide variety of well-defined Spelke segments in natural images. Next, to extract Spelke
segments from images algorithmically, we build **SpelkeNet**, a class of visual world models trained to
predict distributions over future motions. **SpelkeNet** supports estimation of two key concepts for
Spelke object discovery: (1) the motion affordance map, identifying regions likely to move under a
poke, and (2) the expected-displacement map, capturing how the rest of the scene will move. These
concepts are used for “statistical counterfactual probing”, where diverse “virtual pokes” are applied on
regions of high motion-affordance, and the resultant expected displacement maps are used to define
Spelke segments as statistical aggregates of correlated motion statistics. We find that **SpelkeNet**
outperforms supervised baselines like SegmentAnything (SAM) on **SpelkeBench** . Finally, we show that
the Spelke concept is practically useful for downstream applications, yielding superior performance on
the 3DEditBench benchmark for physical object manipulation when used in a variety of off-the-shelf
object manipulation models. Project page: [https://neuroailab.github.io/spelke_net.](https://neuroailab.github.io/spelke_net)

_†_ Corresponding authors: rahulvenkk@gmail.com, dyamins@gmail.com.

**1** **Introduction**

As the work of developmental psychologist Elizabeth Spelke and others has shown, children in their
early months of life already possess notions of objecthood based on motion, segmenting the visual
world into bounded units that move and interact as cohesive wholes [1]. These early capabilities
enable infants to track and predict how objects behave under physical forces, laying the cognitive
groundwork for intuitive physical reasoning [2, 3, 4].

While the idea of such motion-based “Spelke objects” is cognitively natural, typical ontologies

of segmentation in the computer vision literature diverge substantially from the Spelke concept.
Standard segmentation datasets like COCO [5] and ADE20K [6] define segments based on semantic
or instance-level labels such as car, tree, or amorphous categories like “stuff” [7]. Although these are
useful for recognition tasks, the resulting masks often do not reflect how objects move or interact in
the real world. This highlights a core challenge in segmentation: conventional definitions may not
reflect the causal structure required for physical reasoning. In contrast, Spelke segments provide a
category-agnostic alternative by grouping regions based on their responses to forces, resulting in a
more functional notion of segmentation, which can serve as a useful foundation for vision systems in
robotics tasks like manipulation and planning (see Figure 2).

In this work, we introduce a self-supervised procedure for extracting Spelke segments from real-world

*Equal contribution. Author order randomly decided.

1

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

**Figure** **1:** **Overview** **of** **SpelkeNet’s** **capabilities.** Our model first predicts a probability of
motion map, indicating regions likely to undergo movement independent of camera motion—i.e.
candidate movable objects. We sample a point from this map and apply a virtual poke. Conditioned
on this intervention, our model completes the flow field. From this, we extract a grouping of
pixels, or a “segment” corresponding to an entity that would move as a cohesive whole under the
application of external forces (i.e. a Spelke object). On the right, we illustrate how these discovered
segments can be used in a physical object editing pipeline to precisely define the object we desire to
manipulate—ensuring that edits are applied to groups of pixels that would move together in the
real world as opposed to segments defined based on appearance or semantics. We show in this paper
that the Spelke segments we discover enable more physically plausible object manipulation.

static images, and show how these Spelke segments can be effectively used as the basis for physically
grounded object manipulation tasks.

We first benchmark the Spelke segment concept by introducing **SpelkeBench** : an evaluation dataset

designed to assess whether segmentation algorithms can identify Spelke segments. This benchmark
allows us to systematically measure how well a model’s output align with the Spelke concept. While
collecting such a dataset on a scale suitable for evaluation is feasible, collecting it on a scale suitable
for supervised training is prohibitively expensive. Capturing annotations that respect Spelke’s
core principles—cohesion, continuity, solidity, and contact—requires nuanced human judgment and
possibly some form of physical interaction, making it impractical to scale through conventional
labeling pipelines.

To sidestep this bottleneck, we turn to self-supervised visual world models. Specifically, we build
on the recently proposed Local Random Access Sequence Modeling ( **LRAS** ) [9], a probabilistic

2

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

framework that models sequences of locally quantized tokens. Here, we introduce **SpelkeNet** as
a specific instance of **LRAS** trained to predict a distribution of plausible future flow fields given
an input image. By virtue of being trained on large-scale internet videos, **SpelkeNet** acquires an
implicit understanding of “what moves together” in natural scenes without ever being given explicit
segmentation labels.

The autoregressive structure and locality properties of the **LRAS** framework are a natural architectural
foundation for **SpelkeNet** : Spelke segments can be discovered by applying localized virtual pokes
simply by appending optical flow tokens to the input sequence and having the model complete the
flow field to discover motion correlation patterns. In contrast, diffusion-based models [10] rely on

**Figure** **2:** **Benchmarking** **Spelke** **Segmentation:** **comparing** **Spelke** **segments** **with**
**conventional** **segmentation** **definitions.** SAM [8] produces fine-grained segments but often
includes regions that do not typically move independently when forces are applied—such as logos
on bottles, shadows, or sub-parts of objects like camera lenses—reflecting its focus on visual
distinctiveness over physical structure. Entity segmentation [7] more closely approximates the Spelke
notion of segmentation but still includes non-movable elements like walls, streets, and fixed shelves.
Our **SpelkeBench** benchmark is constructed by manually filtering out such segments (as described
in Section 3.1), retaining only those that correspond to physically grounded entities defined by
correlated motion in response to applied forces.

3

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

dense, global conditioning, making such targeted interventions hard.

To _discover_ Spelke segments, we introduce a “statistical counterfactual probing” procedure on
**SpelkeNet** —a model analog of the physical act of “poking” multiple times at a location in a static
image and observing, in the short (imagined) videos that would result, what else in the scene is
likely to move in response. To execute this procedure, we must first determine which regions in
the image are capable of moving when acted upon by external forces. For example, a chair or
car might respond to a push, while static elements like the sky or ground would not. Once these
candidate regions are identified, we simulate a virtual poke at a specific pixel and ask the model:
what else in the scene would move as a result? To realize this query, we extract two intermediate
representations from **SpelkeNet** : (1) a motion affordance map, indicating regions that are likely
to move when external forces are applied, and (2) an expected displacement map, predicting how
the rest of the scene would move in response to a virtual poke. We sample poke locations from
high-affordance regions (as shown in Figure 1) and analyze resulting displacement fields from diverse
virtual pokes to estimate patterns of correlated motion—yielding partitions of pixels (or segments)
that describe co-moving entities. This statistical counterfactual probing framework not only enables
object discovery but also holds promise for general-purpose robotics, where understanding movable
parts of an environment and the distribution of likely responses to hypothetical applied forces is
essential for planning and control. On our **SpelkeBench** benchmark, **SpelkeNet** outperforms both
self-supervised approaches like DINO [11] and supervised methods like SAM [8].

We then explore how these discovered Spelke objects can be _used_ in practice, focusing on the task of
3D physical object manipulation. In current practice, the typical pipeline for 3D object manipulation
begins by identifying an object to manipulate using an off-the-shelf segmentation model, followed
by applying a transformation to the selected segment to produce an edited image. While various
techniques exist for performing these edits, most assume a predefined segment that corresponds to
an object in the physical world. However, since standard segmentation models often reflect semantic
categories or texture similarity (as in SAM), but not entities that move together, the edits can often
appear unrealistic—affecting parts of multiple objects or fragmenting a single object. In contrast,
as shown on the right side of Figure 1, we find that using segments extracted using **SpelkeNet** leads
to edits that are significantly more physically plausible and align better with human expectations.
We evaluate **SpelkeNet** on the 3DEditBench benchmark [9], which assesses the realism and physical

consistency of 3D object manipulations. Our approach outperforms supervised baselines, including
SAM, demonstrating the importance of using segments defined based on what moves together in
the world (i.e. Spelke segments) for tasks involving physical manipulation.

In this way, our work addresses three key questions: (a) How can we _benchmark_ segmentation
models’ ability to capture the notion of pixel co-movement (i.e Spelke segments)? (b) How can such
segments be defined using a visual world model and _discovered_ in a self-supervised way? and (c)
Are Spelke segments a practically useful definition, i.e. can they be _used_ effectively in downstream
physical manipulation tasks?

**2** **Related Works**

**Evaluation** **datasets** **for** **segmentation:** Segmentation in computer vision is typically framed
as semantic [6, 5], instance [5, 12], or panoptic segmentation [13], and segments are labeled by
annotators based on category. They will search through the image for objects matching a given
category description and label the segment accordingly. However, these definitions often conflict
with the physical structure of scenes: masks may merge independently movable objects, split objects

4

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

into parts, or include amorphous “stuff” categories like sky or terrain [7]. Models trained and
evaluated on such datasets, including recent efforts like SAM [8], may produce segments that diverge
from the demands of downstream tasks like interaction and control [14]. In contrast, our work
introduces a new segmentation benchmark called **SpelkeBench** which is aligned with the notion
of Spelke objects [1]—a category-agnostic definition of segments as bounded regions that move as
physical units, which allows for a more physically grounded evaluation of segmentation models.

**Object** **segmentation** **models:** Numerous approaches to object segmentation based on supervised
learning have been proposed in prior work [15, 16, 17, 18, 19, 20]. While these models achieve strong
performance, they depend on large amounts of labeled data, which can be expensive to obtain. To
reduce reliance on annotations, recent unsupervised and self-supervised methods attempt to extract
object masks from unlabeled data by clustering attention maps from pre-trained contrastive learning
models [21, 22, 23, 24, 25, 26]. Methods like CutLER [27] and ProMerge [28] use these clusters
as pseudo-masks for distillation. However, these methods often struggle in scenes with multiple
objects of the same category, as contrastive learning tends to produce similar representations for
such instances, making them harder to distinguish. Here, we introduce **SpelkeNet**, a self-supervised
world model that extracts segments based on what moves together in the physical world. We show
that this approach is well-suited for downstream tasks such as object manipulation, compared to
other ways of defining segments.

**Emergent** **visual** **structures** **in** **world** **models:** Object-centric world models aim to decompose
scenes into discrete entities by imposing inductive biases that encourage low-dimensional, disentangled
object-centric representations to emerge. These models route information through a fixed number of
competing latent slots, often using soft attention bottlenecks and minimizing either future prediction
objectives (models such as MONet [29], Slot Attention [30], SAVi [31]) or contrastive objectives
like C-SWM [32]. These models do not scale to complex real-world datasets due to architectural
constraints—too many slots lead to degenerate solutions with minimal structure, while too few
make the reconstruction task ill-posed. In contrast, **SpelkeNet** defines a predictive world model
that enables the extraction of segments grounded in motion causality without having to bake in
architectural constraints.

_Counterfactual_ _World_ _Models_ _(CWM)_ [33, 34] are a class of world models that reveal object-level

structure by prompting a regression-based video predictor with targeted _interventions_ . Specifically,
CWM simulates object motion by copying an RGB patch from the input frame to a different
location in an otherwise fully masked target frame, and asking the model to reconstruct the target
frame. The optical flow between the predicted and original frames reveals sets of pixels that tend to
move together. However, this RGB-based intervention has important limitations. The copied pixel
values often fail to reflect how that region would appear if the object truly moved—due to changes
in lighting, occlusion, etc.—resulting in degraded predictions. Moreover, as CWM models are
deterministic, when multiple future motions are plausible (e.g. for articulated bodies like humans),
they produce blurred reconstructions that might result in inaccurate segments. **SpelkeNet** resolves
both these issues by a) specifying interventions via sparse flows that more meaningfully indicate
intended motion and b) using autoregressive generative modeling to estimate the marginals of and
sample over the distribution of plausible futures, avoiding averaging artifacts and enabling more
accurate computation of correlated motion statistics for object discovery.

**Text-guided** **vision** **foundation** **models:** Diffusion-based generative models [10] have shown impressive capabilities in text-guided image generation and editing, and have an implicit understanding
of objects and causal relationships. However, reliance on iterative global denoising makes it hard to
probe these models with localized physical interventions, which is required for answering questions

5

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

about causality—such as the effects of force application and object interactions. Similarly, while
vision-language models (VLMs) such as CLIP [35] and BLIP [36] excel at grounding global semantics
in images, text-based prompts have proven to be a sub-optimal control surface for fine-grained
spatial reasoning [37, 38]. **SpelkeNet** leverages the **LRAS** autoregressive modeling framework to
provide a robust control surface for spatially localized prompting, allowing sparse flow interventions
to be specified simply by appending a few flow tokens to the input sequence.

**Object** **manipulation:** Object manipulation involves applying transformations to objects to
generate novel scenes, and is a core task in computer vision. Most modern methods rely on spatial
segmentation masks to define the set of pixels to be edited [39, 40, 41, 42, 43]. For physically
plausible edits, it is critical that these segments correspond to parts of the scene that move together
in the real world. However, commonly used models like SAM [8] often produce masks that capture
subparts of objects that often do not move independently of the rest of the scene, leading to
implausible image edits. In contrast, **SpelkeNet** produces segments aligned with real-world physical
motion, enabling more accurate and realistic object manipulations for a wide range of physical
object manipulation models.

**3** **Methods**

**3.1** **Benchmarking Spelke segments:** **The SpelkeBench Benchmark**

To benchmark Spelke object discovery, we introduce the **SpelkeBench** benchmark—a curated set of
500 images with ground-truth Spelke segment annotations. These annotations follow the definition
proposed by developmental psychologist Liz Spelke [1]—Spelke segments are groups of pixels that
move together as a unit under a variety of virtual pokes applied to the object. Existing benchmarks
like COCO [5] and ADE20K [6] prioritize semantic or instance-level distinctions, often producing
segments that merge independently movable objects, split them into parts, or include amorphous
background regions. As illustrated in Figure 2, models like SAM frequently produce segments that
diverge from Spelke criteria. Since such models are evaluated using existing benchmarks, it is hard
to quantify their utility for tasks like robotic manipulation [14], which require an understanding
of which parts of a scene move together in the physical world. To address this gap, we introduce
a method to construct a meaningful benchmark that tests whether models understand the pixel
co-movement/Spelke object concept.

We curate a dataset of segmented objects from two complementary sources: the EntitySeg bench
mark [7] and the OpenX-Embodiment robotics dataset [44]. These datasets differ in their collection
paradigms: EntitySeg is designed for high-resolution internet imagery with dense segmentation
annotations, whereas OpenX consists of real-world, egocentric robot interactions. This contrast
allows us to evaluate segmentation models in both unconstrained image domains and physically
grounded robotics environments.

Since OpenX does not provide segment labels, we manually annotate _Spelke-consistent_ _segments_ for
a subset of 50 images. These annotations reflect the types of objects relevant for physical interaction
and manipulation tasks that are central to robot learning. For EntitySeg, we extract a high-quality
subset of 500 images using a three-stage filtering pipeline to filter out the annotated segments in
the dataset which do not align with Spelke’s principles:

 - _Stage_ _1:_ _Removal_ _of_ _amorphous_ _background_ _regions._ We exclude all regions labeled as
“stuff”—such as sky, ground, or terrain—based on the standard stuff-vs-things taxonomy [7].

These regions lack the individuated, cohesive properties associated with Spelke objects and

6

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

are typically not physically manipulable entities.

 - _Stage_ _2:_ _Filtering_ _non-movable_ _object_ _categories._ Despite being labeled as “things”, certain
objects like kitchen sinks, traffic signs, or large fixtures are functionally immovable in real-world
settings. We identify and remove such regions through manual inspection.

 - _Stage_ _3:_ _Final_ _curation_ _of_ _diverse,_ _high-quality_ _scenes._ From the filtered pool, we select 500
images that contain only Spelke-consistent regions. We also ensure that this set is diverse in
terms of object types, spatial arrangements, and scene complexity.

**3.2** **Discovering Spelke segments**

**Local** **Random** **Access** **Sequence** **Modeling** ( **LRAS** ) [9], is a sequence modeling framework
inspired by large language models (LLMs) that causally predicts locally quantized image (i.e. RGB)
and optical flow patches. In this section, we describe the **LRAS** architecture and provide details
about how some of its properties make it a strong candidate for our goal of Spelke object discovery.

The **LRAS** framework operates on a unified vocabulary comprising RGB and flow “content” tokens
and a set of “pointer” tokens for each modality that specifies one of _l_ spatial locations in the image
grid—resulting in a vocabulary _V_ that can be partitioned into four disjoint sets of integers:

 - _I_ <sup>(rgb)</sup> : RGB pointer tokens  - [0 _, l_ )

 - _X_ : RGB content tokens  - [ _l, l_ + _|X|_ )

 - _I_ <sup>(flow)</sup> : Flow pointer tokens  - [ _l_ + _|X|,_ 2 _l_ + _|X|_ )

 - _F_ : Flow content tokens  - [2 _l_ + _|X|,_ 2 _l_ + _|X|_ + _|F|_ )

When constructing sequences, each content token (i.e. RGB or flow) is paired with a corresponding

pointer token that specifies its spatial location. This (pointer, content) pairing allows sequences to
be arranged in arbitrary spatial order. Additionally, since the pointer tokens are modality-specific,
they serve as a way of “asking” the model to decode a desired modality. For example, a pointer
token from _I_ <sup>(rgb)</sup> prompts the model to decode an RGB token at a given location, while one from
_I_ <sup>(flow)</sup> can query for a flow token at that same location. Token sequences are denoted as <sup>1</sup>

**x** = [( _i_ <sup>(rgb)</sup> 1

<sup>(rgb)</sup> 1 _, x_ 1) _, . . .,_ ( _i_ <sup>(rgb)</sup> _N_

<sup>(rgb)</sup> _N_ _, xN_ )] _,_ **f** = [( _i_ <sup>(flow)</sup> 1

<sup>(flow)</sup> 1 _, f_ 1) _, . . .,_ ( _i_ <sup>(flow)</sup> _M_

<sup>(flow)</sup> _M_ _, fM_ )]

_xt_ _∈X_ _,_ _ft_ _∈F,_ _i_ <sup>(rgb)</sup> _t_

<sup>(rgb)</sup> _t_ _∈I_ <sup>(rgb)</sup> _,_ _i_ <sup>(flow)</sup> _t_

<sup>(flow)</sup> _t_ _∈I_ <sup>(flow)</sup>

A special camera pose token _c_ representing the relative camera motion between frames can optionally
be included to form the final sequence, **z** = **x** _⊕_ [ _c_ ] _⊕_ **f** . Here, _⊕_ denotes concatenation.

The model is trained like an LLM—it learns to predict the next token, conditioned on all preceding
tokens. More concretely, the model outputs a categorical distribution over the unified vocabulary _V_,
and is trained to minimize cross-entropy loss between this distribution and the target next token.
Since the tokens appear in random spatial order, there is no need to “learn” the ordering, so the
prediction of the pointer tokens is not supervised [9].

During inference, the sequence model can accept a sequence composed of any subset of the combined
sequence **z** . In prior work [9], the **LRAS** framework was used to generate a complete flow field by

1In practice, for efficiency purposes, we reduce the number of pointer tokens by grouping each pointer with a
patch of content tokens—each pointer token is followed by four content tokens as illustrated in Figure 3.

7

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

**Figure** **3:** **SpelkeNet** **Architecture.** The **left** panel illustrates **SpelkeNet** —an instance of the
**LRAS** [9] framework applied to the task of optical flow completion for Spelke object discovery. The
input consists of a tokenized RGB image ( _{xk,_ _k_ _∈I}_ ) and a sparse _virtual_ _poke_ indicated by a flow
token, _f_ . Each token is paired with a pointer token indicating its spatial location, forming a 1D
sequence of (pointer, content) pairs. The model accepts this sequence and predicts a categorical
distribution _D_ [ _ij_ ] over the flow token vocabulary for _every_ spatial location _ij_ in the image. The
**right** panel shows that autoregressively sampling from these distributions yields a complete flow
field in pixel space—at each step we randomly select an undecoded location _ij_, and sample a flow
token _f_ <sup>ˆ</sup> _∼D_ [ _ij_ ] from the distribution predicted by the model. We then append the pair ( _ij,_ _f_ <sup>ˆ</sup> ) to
the input sequence, which is fed back into the model to generate a new distribution _D_, and the
process repeats. In this way, the input sequence grows over time, progressively completing the flow
field, representing how the scene responds to the virtual poke. We discover Spelke segments by
analyzing the motion correlation patterns of these resulting flow fields.

conditioning only on RGB tokens and the camera pose (i.e. **z** = **x** _⊕_ [ _c_ ]), achieving state-of-the-art
performance on tasks like monocular depth estimation and novel view synthesis [9].

**SpelkeNet:** **an** **instance** **of** **LRAS** **for** **Spelke** **object** **discovery.** Here, our goal is to discover
pixel co-movement in natural images, i.e. what moves together when external forces are applied.
We propose to discover such causal relationships by injecting localized virtual pokes and using a
world model to infer what else in the scene moves. Among existing generative world modeling
techniques, the **LRAS** paradigm is particularly well-suited for this task. Unlike diffusion models [10],
which require dense, global conditioning, the autoregressive structure of **LRAS** supports composable
input sequences. Our model, **SpelkeNet** is a specific instance of **LRAS** that leverages it’s flexible
sequence design properties to apply sparse, localized interventions simply by appending to the input
sequence a flow token _fk_, representing the motion to be applied and a pointer token _ik_, indicating
the spatial location of the poke—and discovers Spelke objects by completing the flow field which
indicates how the rest of the scene will respond to the poke.

_Disentangling_ _object_ _motion_ _from_ _camera_ _motion._ In natural videos, pixel motion can arise either

due to external forces acting on objects or due to camera movement. However, for discovering
Spelke objects, we are specifically interested in motion caused by external perturbations to objects,
not from camera-induced motion. If we provide the model with a sparse flow input (a virtual poke)
without additional context, it has no way of knowing whether the input motion arose from forces

8

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

acting on objects or camera movement. Consequently, the model might complete the flow field in
ways that conflate both sources of motion, making it difficult to isolate responses that are effects
of the applied poke. To ensure that the predicted motion is attributed solely to the virtual poke,
we must explicitly condition the model on a _static_ _camera_ . With the **LRAS** paradigm, this form
of controlled probing is simple to implement: we simply append a zero camera pose token to the
input sequence, guiding the model to interpret any input motion as arising exclusively from external
forces and not from camera displacement. We formalize this input as:

**z** _f_ = **x** _⊕_ [ _c_ = 0] _⊕_ [( _ik, fk_ )] _,_

**Decoding** **strategies.** Given the input sequence, **SpelkeNet** predicts for every spatial location,
_ik_ _∈I_ <sup>(flow)</sup>, a categorical distribution _D_ [ _ik_ ] over _V_ . <sup>2</sup> In practice, _D_ [ _ik_ ] is obtained by querying the
model by appending a pointer token to the end of the sequence:

Ψ( **z** _f_ _⊕_ [ _ik_ ]) _�→D_ [ _ik_ ]

**SpelkeNet** can be thought of as a composite function Ψ that returns a set of flow distributions, one
for each spatial location:

Ψ( **z** _f_ ) =

- _D_ [ _ik_ ] _∀_ _ik_ _∈I_ <sup>(flow)�</sup>

To infer what else in the scene will move as a result of the poke _fk_, we can use Ψ to complete the
flow field, either in parallel or autoregressively. In parallel decoding, all spatial locations are sampled
independently, _f_ <sup>ˆ</sup> _k_ <sup>(par)</sup> _∼D_ [ _ik_ ], resulting in the spatially completed flow field, <sup>ˆ</sup> **f** <sup>(par)</sup> = [ _f_ <sup>ˆ</sup> _k_ <sup>(par)</sup> ] _k∈I_ . We

denote this method as Ψ <sup>par</sup> flow <sup>:</sup>

_k_ <sup>(par)</sup> _∼D_ [ _ik_ ], resulting in the spatially completed flow field, <sup>ˆ</sup> **f** <sup>(par)</sup> = [ _f_ <sup>ˆ</sup> _k_ <sup>(par)</sup>

<sup>par</sup> flow <sup>:</sup>

ˆ **f** <sup>(par)</sup> = Ψ <sup>par</sup> flow <sup>(</sup> <sup>**z**</sup> <sup>_f_</sup> <sup>)</sup> <sup>_._</sup>

In contrast, sequential decoding starts from an initial sequence **z** 0 = **z** _f_ . We then iteratively select
an undecoded, random location _ik_, query the current model distribution _D_ 0 = Ψ( **z** 0), sample a
token: _f_ <sup>ˆ</sup> _k_ <sup>(seq)</sup> _∼D_ 0[ _ik_ ] _,_ and append it to the sequence:

**z** _q_ +1 _←_ **z** _q ⊕{_ ( _ik,_ _f_ <sup>ˆ</sup> _k_ <sup>(seq)</sup> ) _}_

This process continues until the entire flow field is decoded, with each prediction step refining the
model’s estimate of distribution: _Dq_ +1 = Ψ( _zq_ +1). This sequential decoding process results in the
dense flow field, <sup>ˆ</sup> **f** <sup>(seq)</sup> = [ _f_ <sup>ˆ</sup> _k_ <sup>(seq)</sup> ] _k∈I_ . We denote this method as Ψ <sup>seq</sup> flow <sup>:</sup>

_k_ <sup>(seq)</sup> ] _k∈I_ . We denote this method as Ψ <sup>seq</sup> flow

<sup>seq</sup> flow <sup>:</sup>

ˆ **f** <sup>(seq)</sup> = Ψ <sup>seq</sup> flow <sup>(</sup> <sup>**z**</sup> <sup>_f_</sup> <sup>; seed =</sup> <sup>_t_</sup> <sup>)</sup>

Sequential decoding is especially valuable when modeling objects with many degrees of freedom,
such as articulated bodies like humans or mechanical tools, and deformable materials like cloth or
paper, where different parts are causally linked and must move in a coordinated way. For example,
in human motion, movement of one part—say, the lower hand—imposes constraints on how other
parts, like the upper arm or torso, can respond. Decoding tokens sequentially allows the model to
respect these causal dependencies, as each token is generated in the context of previously decoded

2Although the model predicts a distribution over the entire unified vocabulary, not just the flow token subset _F_,
sampling from this distribution yields a flow token _f_ _∼D_ [ _ik_ ] because the model is trained to produce a flow token
whenever it encounters a preceding flow pointer token.

9

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

ones (such as the motion of the lower hand in this example), resulting in globally consistent motion.
In contrast, parallel decoding offers faster inference but can yield locally plausible yet globally
inconsistent flow fields—e.g. the upper arm moving independently of the lower hand—leading to
physically implausible outcomes.

**Defining** **Spelke** **objects** **using** **SpelkeNet.** Our approach builds on the idea of _counterfactual_
_probing_, introduced in CWM [34], where Spelke objects are discovered by simulating localized virtual
pokes through local patch motion interventions and analyzing the outcome of the intervention.
However, since CWM is regression-based, it produces a single deterministic output—an important
limitation, because in the physical world, responses to pokes are often _multimodal_ . Consider a
simple example of moving a person’s hand. In the physical world, one of two things can plausibly
happen: either the hand moves independently while the rest of the body remains fixed, or the entire
person translates, causing the hand to move along with it. Both are physically valid outcomes. But
as CWM is deterministic, it is forced to average over these distinct possibilities, leading to blurry or
ambiguous motion completions that fail to reveal which parts of the scene tend to move together.

To address this limitation, we propose a more expressive definition of Spelke objects using a
generative world model like **SpelkeNet**, which generates multiple plausible future motions of a scene.
We operationalize Spelke objects as groups of pixels that consistently move together across multiple

plausible outcomes of a world model, under different virtual pokes. This requires modeling the
_distribution_ of possible responses to external forces.

We implement this using _statistical_ _counterfactual_ _probing_ on **SpelkeNet**, a stochastic extension of

the original CWM counterfactual procedure. Instead of generating a single prediction like CWM,
we use **SpelkeNet** to produce a diverse set of _imagined_ flow completions for various virtual pokes at
a candidate spatial location. Diversity arises from two sources of randomness:

1. **Sampling** **flow** **tokens** from the learned distribution _D_ [ _ik_ ]: For a fixed index _ik_, we draw
multiple flows _fk_ _∼D_ [ _ik_ ] to explore the local responses the model deems plausible. For
example, in the human motion scenario discussed above, different samples can make the same
body part move in distinct yet physically feasible ways.

2. **Varying** **the** **decoding** **order** of spatial indices _ik_ : Because **SpelkeNet** is a sequence model,
tokens decoded earlier condition those decoded later. Shuffling the order therefore changes
how motion propagates through the object—e.g. decoding the torso _before_ the leg yields a
different global outcome than decoding the leg first.

Computing what is effectively a marginal (i.e. a probability-weighted integral) over these diverse
generations, allows us to obtain a robust definition of Spelke objects using **SpelkeNet** . We now
describe a few useful structure extractions from **SpelkeNet** that support statistical counterfactual
probes.

**Motion** **affordance** **maps** . To discover Spelke objects, we must first identify the candidate
locations where virtual pokes can be applied—which pixels in the scene lie on regions that are likely
to move under external forces (i.e. _movable_ _entities_ ). We refer to this notion as the probability of
motion affordance map, denoted _p_ motion. Such motion-centric affordance maps are especially useful
in robotics applications where we need to identify high motion affordance regions that are likely to
move under interaction (e.g. a cup or plate). Regions that typically do not move upon external
forces (e.g. sky, walls, and flooring) would have low motion affordance.

To compute _p_ motion, we define a set of flow tokens that correspond to motion greater than some
threshold _τ_, and then sum their estimated probabilities. As the flow tokens, _fj_, are by themselves

10

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

**Figure** **4:** **Spelke** **object** **discovery** **using** **statistical** **counterfactual** **probing** . To discover
movable objects, multiple virtual pokes are applied at a location sampled on the _p_ motion map that
indicates which regions are likely to move under the application of external forces. The average dot
product of the poke vector with the expected displacement maps isolates the desired segment.

not interpretable, we map each flow token to a 2D flow vector, **v** _j_, through an epigraphy on the flow
vocabulary <sup>3</sup> and define the token set corresponding to motion as:

_F_ motion = _{fj_ _∈F | ∥_ **v** _j∥_ 2 _> τ_ _},_ where _τ_ is a threshold

Next, given a sequence of RGB tokens **x**, as we are only interested in finding regions that are likely
to move under external forces, we concatenate the sequence with a token indicating zero camera
motion to discount it (i.e. **z** = **x** _⊕_ [ _c_ = 0]) and obtain the predicted flow token distributions
_D_ [ _ik_ ] = Ψ( **z** )[ _ik_ ], _∀ik_ _∈I_ . Using these distributions, the probability of _motion_ at each spatial
location _ik_, is computed by summing over the token set _F_ motion:

_p_ motion[ _ik_ ] =

 

_fj_ _∈F_ motion

_D_ [ _ik, j_ ]

In this way, _p_ motion : _I_ _→_ [0 _,_ 1] is a 2D heatmap of the regions likely to move under external forces.
Figures 4 and 1 illustrate some examples of these maps.

**Expected** **Displacement** **Maps.** Having identified regions of high motion-affordance, we can
sample candidate locations and condition the model on virtual pokes in those regions. To discover
Spelke objects, we introduce a useful quantity called the “expected displacement map”, which is the
estimate of the likely flow at each location conditioned on the poke. In robotics settings, this map
can provide valuable guidance about how objects might move if interacted with, even before the
robot makes contact with objects in the scene.

3Flow token epigraphy: **SpelkeNet** uses a learnt _local_ _patch_ _quantization_ to produce flow tokens, but relies on a
_global_ _decoder_ to generate coherent, high-quality flow fields. As a result, tokens cannot be interpreted by decoding

them in isolation—their meaning emerges only in the context of the full sequence. However, since the tokenizer is local,
we can find which continuous flow vectors map to it by performing a kind of token space epigraphy—by assigning
meaning to discrete flow tokens through statistical aggregation of typical input flow fields that produced them:

<u>1</u>
_fj �→_ **v** _j_ =
_|Sj|_

**u** _∈Sj_

**u** _,_ where _Sj_ = <sup>�</sup>

11

**u** _∈_ R <sup>2</sup> _|_ tokenizer( **u** ) = _fj_

- _._

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

We use our flow model to apply a virtual poke represented with the flow token, _fk_, at location _ik_ _∈I_,

construct an input sequence, **z** = **x** _⊕_ [ _c_ = 0] _⊕_ [( _ik, fk_ )], and obtain the predicted distribution,
_D_ [ _ik_ ] = Ψ( **z** )[ _ik_ ], _∀k_ _∈I_ . We then compute the expected displacement as the probability-weighted
average of flow vectors **v** _j_, where each **v** _j_ maps to token _fj_ as defined by flow token epigraphy <sup>3</sup> :

E <sup>par</sup>

disp <sup>[</sup> <sup>_ik_</sup> <sup>] =</sup>

_j_

_D_ [ _ik, j_ ] _·_ **v** _j,_ _∀ik_ _∈I_

The result is a dense 2D vector field over spatial locations, decoded in parallel: E <sup>par</sup> disp

The result is a dense 2D vector field over spatial locations, decoded in parallel: E <sup>par</sup> disp <sup>:</sup> <sup>_I_</sup> <sup>_→_</sup> <sup>R2.</sup> <sup>We</sup>

denote this method using the function Ψ <sup>par</sup> disp <sup>:</sup>

<sup>par</sup> disp <sup>:</sup>

E <sup>par</sup> disp

disp <sup>par</sup> <sup>(</sup> <sup>**z**</sup> <sup>)</sup>

<sup>par</sup>

disp <sup>= Ψ</sup> disp <sup>par</sup>

To obtain a more faithful estimate of E <sup>par</sup> disp

<sup>par</sup> disp <sup>,</sup> <sup>we</sup> <sup>can</sup> <sup>also</sup> <sup>average</sup> <sup>predictions</sup> <sup>over</sup> <sup>multiple</sup> <sup>stochastic</sup>

generations (i.e rollouts) of the model. Denoting **f** <sup>ˆ</sup> _t_

(seq) = Ψseqflow

generations (i.e rollouts) of the model. Denoting **f** <sup>ˆ</sup> _t_ (seq) = Ψseqflow <sup>(</sup> <sup>**z**</sup> <sup>_,_</sup> <sup>seed =</sup> <sup>_t_</sup> <sup>) as the set of sequentially</sup>

decoded flows in the _t_ <sup>th</sup> rollout, where each rollout is one sequential completion of the flow field
conditioned on **z**, the expected displacement map, computed in sequential mode can be written as:

<sup>seq</sup>

disp <sup>[</sup> <sup>_ik_</sup> <sup>] =</sup> <sup><u>1</u></sup>

_T_

E <sup>seq</sup>

_T_

(seq)[ _ik_ ] _·_ **v** _j._

_T_

_t_ =1

**f** ˆ _t_

We denote this method using the function Ψ <sup>seq</sup> disp <sup>:</sup>

E <sup>seq</sup> disp

<sup>seq</sup>

disp <sup>= Ψ</sup> disp <sup>seq</sup>

disp <sup>seq</sup> <sup>(</sup> <sup>**z**</sup> <sup>)</sup>

Some examples of these maps are shown in Figure 4. To simplify the notation going forward, unless
the superscript (seq/par) is specified, we’ll assume either sequential or parallel modes can be used.

**Statistical** **counterfactual** **probing** **for** **Spelke** **object** **discovery.** Using these structure
extractions, we first sample a location that is likely to move: _k_ such that _p_ motion( _k_ ) _>_ _τp_ . Then,
to discover Spelke objects we will identify regions that consistently move together under various
virtual pokes applied at _k_ . We use our flow model to apply diverse virtual pokes _{f_ <sup>(</sup> <sup>_r_</sup> <sup>)</sup> _}_ <sup>_R_</sup> _r_ =1 <sup>,</sup> <sup>at</sup> <sup>_k_</sup> <sup>.</sup>

For each direction _f_ <sup>(</sup> <sup>_r_</sup> <sup>)</sup>, we compute the expected displacement field, given the input sequence:

E <sup>(</sup> disp <sup>_r_</sup> <sup>)</sup> <sup>= Ψdisp(</sup> <sup>**x**</sup> <sup>_⊕_</sup> <sup>_c_</sup> <sup>= 0</sup> <sup>_⊕_</sup> <sup>[</sup> <sup>_ik, f_</sup> <sup>(</sup> <sup>_r_</sup> <sup>)])</sup> <sup>_._</sup>

To discover co-moving entities (i.e. Spelke objects), we computed the _expected_ _motion_ _correlation_,

dot¯ [ _u_ ] at each location _u ∈I_, by averaging across various pokes, the dot product between the poke
vector _f_ <sup>(</sup> <sup>_r_</sup> <sup>)</sup> and the expected displacement map E <sup>(</sup> disp <sup>_r_</sup> <sup>)</sup> <sup>[</sup> <sup>_u_</sup> <sup>]:</sup>

dot[¯ _u_ ] = <sup><u>1</u></sup>

_R_

_R_

_r_ =1

- _f_ <sup>(</sup> <sup>_r_</sup> <sup>)</sup> _,_ E <sup>(</sup> disp <sup>_r_</sup> <sup>)</sup>

_._

<sup>(</sup> disp <sup>_r_</sup> <sup>)</sup> <sup>[</sup> <sup>_u_</sup> <sup>]</sup>

Finally, Otsu thresholding [45] of dot¯ yields our desired Spelke segment. Refer to Figure 4 for a
more detailed illustration of this procedure. In practice, we find that using the sequential model to
aggregate over multiple stochastic generations of the model is more effective. This is especially the
case for objects with many degrees of freedom, like humans and deformable objects (see above),

12

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

**Figure** **5:** **Automatic** **discovery** **of** **Spelke** **segments** . We extract probability of motion maps
from an image, and use it to sample candidate poke points **(top** **left)** . We apply an optical flow
vector “poke” to the image at the sampled points and obtain dense flow fields conditioned on the
poke **(top** **right)** which are used to compute affinity maps. As shown in the **bottom** panel, these
maps enable the extraction of segments using iterative clustering (see Section 3.2).

although more expensive to compute. However, we also find that reasonable results can be achieved
in parallel mode as well.

**Automatically** **discovering** **every** **Spelke** **object** **in** **a** **scene** . So far, we have shown how Spelke
segments can be extracted from point prompts. However, in many real-world settings, especially in
robotics, it is advantageous to automatically discover _every_ independently movable segment/Spelke
object in a scene without requiring manual point-prompting. For example, a household robot tasked
with clearing a dining table must infer that a plate and its contents will move as a unit, while a
napkin resting on the plate is an independent entity, so it can plan appropriate grasps and avoid
unintended collisions.

We now describe a method to extract the full set of Spelke segments in a scene automatically. Our

approach consists of two steps. First, we compute a dense pixel-to-pixel affinity matrix that captures
the likelihood that a pair of pixels will move together under virtual force. In essence, this process
recovers the pairwise causal structure of the scene, revealing which regions are causally entangled in
motion space. An iterative clustering algorithm is then applied to this matrix to isolate a complete
set of independently movable entities.

_Computing_ _the_ _affinity_ _matrix_ . We begin by sampling locations from the motion affordance map.

These points are where we “poke” to collect flows.

_K_ = _{ k_ 1 _,_ _k_ 2 _,_ _. . .,_ _kN_ _}_ _⊂I,_ _p_ motion[ _ki_ ] _>_ _τp._

We then build a motion descriptor for each pixel using the following procedure:

For each _n_ = 1 _, . . ., N_, choose _R_ poke-directions _{fn_ <sup>(</sup> <sup>_r_</sup> <sup>)</sup>

<sup>_R_</sup> _r_ =1 <sup>.</sup> <sup>For</sup> <sup>each</sup> <sup>(</sup> <sup>_n, r_</sup> <sup>)</sup> <sup>and</sup> <sup>each</sup> <sup>of</sup> <sup>_t_</sup> <sup>= 1</sup> <sup>_, . . ., T_</sup>

_n_ <sup>(</sup> <sup>_r_</sup> <sup>)</sup> <sup>_}R_</sup> _r_

13

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

random seeds, compute the flow completion given the input image tokens **x**,

_n_ <sup>(</sup> <sup>_r_</sup> <sup>)]</sup> <sup>_,_</sup> <sup>seed =</sup> <sup>_t_</sup> <sup>)</sup>

**f** ˆ _t_

( _n,r_ ) = Ψseqflow

seqflow <sup>(</sup> <sup>**x**</sup> <sup>_, c_</sup> <sup>= 0</sup> <sup>_,_</sup> <sup>[</sup> <sup>_ik_</sup> _n_ <sup>_, f_</sup> _n_ <sup>(</sup> <sup>_r_</sup> <sup>)</sup>

Then for each _u ∈I_ the motion descriptor,

( _n,r_ )( _u_ )� _∈_ R2 _N R T ._

_φ_ [ _u_ ] =

- **f** ˆ1(1 _,_ 1) _,_ _. . .,_ **f** ˆ _t_

Finally, the affinity matrix can be described as the pairwise dot product of motion descriptors:

_A_ [ _u, v_ ] = _φ_ [ _u_ ] <sup>_⊤_</sup> _φ_ [ _v_ ] _,_ _∀_ _u, v_ _∈I._

For simplicity, we denote _A_ [ _u_ ] to be the affinity of the pixel _u_ with the rest of the image.

_Clustering_ _the_ _affinity_ _matrix_ _to_ _extract_ _segments._ Given the precomputed affinity matrix _A_, we

extract segments in an iterative “select–threshold–refine” loop. At each step, we choose the most
confident probe center _ki_ <sup>_∗_</sup>, defined as the one whose affinity-row _A_ [ _ki_ <sup>_∗_</sup> ] has the highest mean over all
pixels—indicative of strong binding to the other pixels that make up the object. We apply Otsu’s
method to threshold this row, yielding an initial mask _M_ <sup>(0)</sup> . We then gather all remaining poke
points _kj_ that lie within _M_ <sup>(0)</sup> and average their affinity-rows to form:

<u>1</u>
_A_ avg =
_|{j_ : _kj_ _∈_ _M_ <sup>(0)</sup> _}|_

 

_kj_ _∈M_ <sup>(0)</sup>

_A_ [ _kj_ ]

We threshold _A_ avg via Otsu’s method to obtain a refined mask _M_ <sup>(</sup> <sup>_t_</sup> <sup>)</sup>, for _t_ = 0. All centers contained

in _M_ <sup>(</sup> <sup>_t_</sup> <sup>)</sup> are then removed from consideration, and the loop repeats on the remaining set of poke
points. Once no poke points remain, the algorithm returns the complete set of extracted segments
_{M_ <sup>(1)</sup> _, . . ., M_ <sup>(</sup> <sup>_T_</sup> <sup>)</sup> _}_ . Figure 5 illustrates this procedure using an example.

**3.3** **Using Spelke segments for physically plausible object manipulation**

Now that we have described how Spelke segments can be discovered given point samples, we discuss
how they can be used in practical applications that require an understanding of pixel co-movement.
We consider the standard task of object manipulation shown in Figure 6 : an input image is

given along with a user-defined edit prompt specifying the desired 2D/3D transformation, and
an object mask tells the editing model which parts of the scene to apply the transformation on.
Successful manipulation relies on having a physically meaningful object segment as downstream
object transformations can suffer if a segment corresponds to a region that is not independently
movable. Spelke segments are grounded in physical principles: they group pixels based on correlated
motion under virtual forces. This makes them a more suitable primitive for physically plausible
editing—here, we demonstrate that the choice of segmentation method significantly affects the
realism of the edit. In this way, we show that Spelke segments are not just a theoretical concept,
but have practical utility in downstream tasks.

**The** **LRAS** **framework** **enables** **both** **image** **editing** **and** **segmentation** **via** **flexible** **sequence**
**design.** In this paper, we leverage the **LRAS** framework to build **SpelkeNet** —a flow completion
model for discovering Spelke segments. To recap, **SpelkeNet** is trained to complete flow fields
conditioned on an input sequence comprising RGB tokens **x** and a sparse virtual poke **f** . The input
sequence is denoted as:

**z** = **x** _⊕_ **f** _,_

14

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

**Figure** **6:** **Standard** **pipeline** **for** **object** **editing** **using** **segmentation** **masks:** We substitute
SAM segments for Spelke objects predicted by **SpelkeNet** and find that they yield more intuitive
and physically plausible edits.

The model predicts a complete flow field representing how the rest of the scene will move as a result
of the poke. By analyzing the resulting flow field, we discover Spelke segments.

The same underlying **LRAS** framework can also be used to define an image editing model in pixel
space. Prior work [9] demonstrates this by building **LRAS-3D** —an instance of the **LRAS** framework
that is conditioned on input RGB tokens **x** and dense flow tokens **f** <sup>dense</sup> that specify a desired object
transformation to be applied:

**z** ˜ = **x** _⊕_ **f** <sup>dense</sup> _._

Given this sequence, the model predicts a distribution over RGB tokens:

_D_ <sup>rgb</sup> [ _ik_ ] = Ψedit(˜ **z** )[ _ik_ ] _,_ _∀ik_ _∈I._

To construct an **f** <sup>dense</sup> that represents a transformation targeting a particular object in the scene, a
segmentation mask must be specified. Prior work relies on off-the-shelf methods such as SAM [8] to
define these masks, which often represent regions which do not move as a unified whole, resulting in
implausible edits.

Here, we show that the **LRAS** framework itself can be used to define a segmentation model, removing
the reliance on external segmentation methods. By a simple modification of the sequence structure—e.g., prompting with sparse pokes and analyzing the flow response—we obtain segments better
aligned with the demands of physical reasoning and manipulation. In this way, we demonstrate in
this paper that the **LRAS** framework unifies both segmentation and image editing within a single,
token-based autoregressive modeling paradigm.

**4** **Results**

**4.1** **Point-prompted segmentation**

**Task** **&** **Dataset.** To evaluate our model’s ability to extract Spelke objects, we formalize the
task as point-promoted segmentation: given a point on an object, the goal is to recover the region
that would move together if a virtual force were applied at that point. To evaluate Spelke object
discovery, we use **SpelkeBench** : our 500-image benchmark described in Section 3.1.

**Baselines.** We compare against several strong baselines. For supervised segmentation, we use
SAM2 (heira-large) [8], a state-of-the-art point prompt-based method. For self-supervised baselines,

15

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

we evaluate DINOv1 [21] and DINOv2 [11], which reveal semantic object structure via attention
maps—segments are obtained by thresholding attention maps at a prompted location. We also
compare to Counterfactual World Models (CWM) [33, 34], which segment objects by generating
local patch motion interventions and thresholding the estimated optical flow (using RAFT [46])
between the outcome of the intervention and the original image.

**Evaluation** **details** **&** **metrics.** For each ground truth segment, we generate a point prompt using
the centroid or, if outside the mask, the point farthest from the boundary. We run 8 poke directions
and 3 autoregressive flow completions per prompt with the procedure described in Section 3.2, and
we use the same setup for CWM. We use Average Recall (AR) and mean intersection-over-union

**Figure** **7:** **Qualitative** **results** **for** **point-promoted** **segmentation** **across** **models.** **SpelkeNet**
yields sharper segments, better aligned with Spelke’s definition of grouping pixels based on comovement, compared to SAM2, DINO, and CWM. More results are provided in the attached
supplementry.

16

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

**Table** **1:** **Quantitative** **evaluation** **of** **point-prompted** **segmentation** **accuracy** **across**
**models.** We report Average Recall (AR) and mean Intersection over Union (mIoU) for various
segmentation methods. **SpelkeNet** outperforms both self-supervised baselines (DINO, CWM) and
the supervised SAM2 model.

SAM2 DINOv1-B/8 DINOv2-L/14 DINOv2-G/14 CWM **SpelkeNet**

AR 0.4816 0.2708 0.2524 0.2254 0.3271 **0.5411**
mIoU 0.6225 0.4990 0.4931 0.4553 0.4807 **0.6811**

(i.e. mIoU) to measure performance. AR is defined as the fraction of GT segments that the model

detects. Here, a GT segment is classified as _detected_ if the predicted segment obtains an IoU less
than some threshold _τ_ . In practice, we compute the average AR across multiple IoU thresholds
(0.5 - 0.99). Intuitively, we can think of AR as measuring how likely it is that the GT segments are

detected by the model and the mIoU metric as measuring how precisely each segment boundary is
predicted.

**Qualitative** **and** **Quantitative** **Comparisons** . **SpelkeNet** outperforms all baselines across both
Average Recall (AR) and mean IoU (mIoU), surpassing self-supervised methods like DINO and
CWM, as well as the supervised baseline SAM, as shown in Table 1.

Qualitatively, as depicted in Figure 7, although SAM performs well in many cases, it often segments
non-movable regions such as textures, printed designs, or object subparts such as human skin, relying
on appearance rather than physical coherence. This suggests that semantic and texture-driven
segmentation can be misaligned with the goal of identifying physically grounded, movable objects.
Meanwhile, contrastive learning methods like DINO exhibit a different failure mode, merging

**Figure** **8:** **CWM** **Segmentation** **failure** **modes** **in** **complex** **scenes.** Each row shows a
challenging example where CWM struggles. The first column shows the input image with the
patch motion prompt (red arrow). The second column displays the counterfactual prediction
generated by CWM. The third column shows the RAFT-predicted flow field between the input and
counterfactual image. The final column presents the resulting segment obtained by thresholding the
flow magnitude. Compared to **SpelkeNet**, CWM often produces diffuse motion fields due to blurry
RGB reconstruction and inaccurate object boundaries.

17

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

same-category instances, as the contrastive learning objective brings representations of instances of
the same object closer. These observations highlight a fundamental limitation of such models for the
task of discovering Spelke segments. CWM, while stronger than other self-supervised methods, often
merges nearby objects. This happens because the model often generates blurry reconstructions, as
its RGB pixel regression objective during training does not account for uncertainty. As a result,
the flow estimation may produce diffuse or extended motion fields, causing nearby objects to be
grouped together, as illustrated in Figure 7 and 8.

In contrast, **SpelkeNet** yields sharp, high-quality segments closely aligned with the Spelke definition.
This can be largely attributed to the ability to prompt the model with local cues and to the
probabilistic flow completion architecture that explicitly accounts for uncertainty in visual scenes.

**4.2** **Automatic discovery of Spelke segments**

**Task.** So far, we have quantified how well our method discovers Spelke segments given point
prompts. However, as we discussed in Section 3.2, it is often desirable to automatically discover
every Spelke segment in the scene. We show illustrative examples of discovered segments using the
auto-discovery method proposed in Section 3.2 in Figure 9 and evaluate performance quantitatively
in Table 2, on our **SpelkeBench** benchmark.

**Evaluation** **Metrics.** To evaluate segmentation quality, we compute Average Precision (AP),
Average Recall (AR), F1-Score, and mIoU. Unlike point-prompted segmentation, where a point on
a ground-truth object is provided and the model predicts a segment associated with that specific
point, auto-segmentation outputs a set of segments without indicating which ground-truth objects
they represent. To determine which predicted segment should be matched to which ground-truth
segment, we compute the pairwise IoU matrix and apply the Hungarian method [47] to find the
best one-to-one matching, which is a necessary first step before we can compute our metrics.

We then compute how many segments the model successfully detects by counting the number of

**Figure** **9:** **Illustration** **of** **unprompted** **Spelke** **segment** **discovery** **using** **SpelkeNet.** The
corresponding discovered segments are highlighted, demonstrating the ability of **SpelkeNet** to
automatically identify every physically coherent, movable entity in the scene without manual
prompts.

18

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

**Table** **2:** **Quantitative** **evaluation** **of** **unprompted** **automatic** **segmentation** **across** **models**
**on** **SpelkeBench.** We find that **SpelkeNet** obtains competitive performance compared to existing
self-supervised methods.

SAM2 [8] CutLER [27] ProMerge [28] **SpelkeNet**

AP 0.11 0.41 **0.42** 0.35
AR 0.62 0.32 0.34 **0.46**
mIoU 0.68 0.42 0.43 **0.57**
F1-score 0.17 0.34 0.36 **0.38**

predicted segments that are matched to ground-truth segments (i.e those that have an IoU greater
than some threshold _τ_ ). Given these detected segments, Average Precision (AP) measures the
fraction of predicted segments that end up being matched and detected (i.e those that are in-fact
Spelke objects). Average Recall (AR), by contrast, measures the fraction of ground-truth segments
that are successfully detected by the model <sup>4</sup> . Intuitively, a model that predicts only a few high
quality segments may achieve high precision but low recall as it may miss many segments, while a
model that over-segments may boost recall at the cost of precision. The F1-Score balances these
two metrics by computing their harmonic mean, providing an aggregate measure of segmentation
performance. Finally, to assess how accurately the model predicts the boundaries of objects at the
pixel-level, we use mIoU. For each GT segment _g_ _∈_ _G_, where _G_ is the set of all GT segments, we
use the IoU with its matched prediction (if any), or assign 0 if unmatched:

<u>1</u>
mIoU =
_|G|_

_g∈G_

IoU( _g,_ matched( _g_ ))

**Results.** Overall, we find that **SpelkeNet** outperforms other self-supervised methods such as
CutLER [27] and ProMerge [28] on most evaluation metrics. ProMerge slightly exceeds **SpelkeNet**
in AP due to its tendency to predict fewer segments than those in the GT—some of which align
well with ground truth and thus boost precision—at the cost of lower recall, as some objects are
missed. For fairness, we report numbers only from the segment extraction stage for both CutLER
and ProMerge, and not from their final distilled models.

Compared to supervised methods like SAM2 [8], **SpelkeNet** achieves a higher F1 score, although
its AR and mIoU are lower. This is largely expected: SAM often over-segments scenes based
on texture and semantic cues, leading to multiple masks for a single Spelke object. While this
increases the likelihood that at least one segment aligns with ground truth (improving recall), it
reduces interpretability for physical reasoning, as these segments do not always capture true pixel
co-movement. This makes them less useful for downstream robotic applications which could benefit
from such structure extractions.

Interestingly, while our method outperforms SAM on point-prompted segmentation metrics, this
advantage does not fully translate to the automatic setting. This suggests that when given the right
point prompts, **SpelkeNet** is capable of producing high-quality segments. However, in their absence,
performance may degrade due to occasional poor flow rollouts from sub-optimal point samples or
to limitations in the current clustering strategy. This points towards a promising future direction:
distilling our automatically discovered segments into a segmentation architecture like SAM could

4Both AP and AR are averaged over multiple IoU thresholds in the range _τ_ = (0 _._ 5 _,_ 0 _._ 99)

19

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

**Figure** **10:** **Qualitative** **comparisons** **of** **scene** **edits** **using** **SAM** **masks** **versus** **SpelkeNet**
**segments.** Each row shows the original image, the user click location, and the resulting edited image
using segments from different methods. Note that while the results shown here are computed using
the state-of-the-art **LRAS-3D** model for object editing, our segments are agnostic of the specific editing
method used and can improve the results of any editing model as shown in Table 3. Additional
results are reported in the attached supplementary material.

potentially factor out noise and improve performance, in the same spirit as distillation pipelines
used in prior work [27, 24, 28].

**4.3** **Using Spelke segments for object manipulation**

**Task.** We consider the task of object-centric scene editing, where a user clicks a point on an object
and provides an edit prompt specifying a 2D or 3D transformation. The object mask is generated
from this point selection using a segmentation model. Here, we will present evidence that realistic
edits require masks that reflect physically movable entities such as Spelke segments.

**Dataset.** To evaluate the utility of **SpelkeNet** segments for object manipulation, we use 3DEditBench, recently introduced in [9]. The benchmark contains 100 real world images with associated
point prompts, 3D transformation and resulting ground truth edited images with the transformation
applied. It comprises of a diverse range of object types undergoing physical changes such as rotations,
translations, and inter object occlusions.

**Baselines.** We evaluate our segments within several widely used image editing pipelines, including Lightning Drag [40], DiffusionHandles [41], and the recently introduced Diffusion-as-Shader
model [43], which demonstrated impressive performance on object manipulation tasks. We also evaluate the **LRAS-3D** model [9], a state-of-the-art model for image editing, built on the **LRAS** framework.
For each method, we compare edits using SAM masks versus our **SpelkeNet** segments to isolate the
effect of segmentation quality on edit realism and physical plausibility.

**Metrics.** While standard metrics like PSNR, SSIM, and LPIPS capture image quality, prior
work [41] has shown they often fail to reflect edit accuracy. To address this, they introduced the
Edit Adherence (EA) metric, which measures how well the transformed object aligns with ground
truth by computing the IoU between ground truth and predicted segments in the edited image. We
report both this metric as well as standard image quality metrics.

20

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

**Table** **3:** **Quantitative** **evaluation** **of** **edit** **quality** **across** **segmentation** **methods** **and**
**editing** **pipelines.** We report results for edits generated using SAM versus **SpelkeNet** segments
across four editing models. Lower _↓_ is better, higher _↑_ is better.

Method Segment MSE _↓_ PSNR _↑_ LPIPS _↓_ SSIM _↑_ EA _↑_

**SpelkeNet** **0.009** **21.64** **0.213** **0.698** **0.776**
LRAS-3D [9]
SAM 0.013 20.17 0.255 0.685 0.633

**SpelkeNet** **0.017** **19.16** **0.195** **0.672** **0.679**
LightningDrag [40]
SAM 0.020 18.18 0.241 0.658 0.536

**SpelkeNet** **0.024** **17.42** **0.364** **0.555** **0.576**
DiffusionHandles [41]
SAM 0.031 16.15 0.419 0.526 0.495

**SpelkeNet** **0.015** **19.29** **0.194** **0.707** **0.640**
DiffusionAsShader [43]
SAM 0.019 18.20 0.253 0.682 0.503

**Qualitative** **and** **Quantitative** **Comparisons.** We find that **SpelkeNet** segments consistently
outperforms SAM, yielding physically grounded segments that improve realism across diverse image
editing models (see Table 3). In contrast, SAM-generated masks capture only sub-parts of objects,
resulting in fragmented or implausible edits (see Figure 10).

**5** **Conclusion & Future Work**

In this paper, we show how a class of self-supervised visual world models—trained to predict
plausible motion from input RGB images—can be used to discover motion-defined Spelke object
entities from static images via zero-shot statistical counterfactual probing. To evaluate this approach,
we introduce a new benchmark, **SpelkeBench**, which measures this capability, and find that our
model, **SpelkeNet** achieves superior results in comparison to both supervised and self-supervised
segmentation methods on this benchmark.

While Spelke segments have largely been explored in cognitive science, we show in this paper that

they align well with the kinds of abstractions needed for physically grounded computer vision and
robotics tasks, such as selecting and manipulating coherent parts of a scene. When applied to the

**Figure** **11:** **Support** **relationship** **understanding** **capabilities.** When applying a virtual poke
to an object, the extracted Spelke segment includes both the directly contacted object and all the
objects it physically supports, which implies an implicit understanding of the support hierarchy
within a scene.

21

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

**Figure** **12:** **Emergent** **material** **property** **understanding** **capabilities.** We find that motion
probability maps are uniform in case of rigid objects, but more localized near the virtual poke for
deformable objects. This can potentially enable the discovery of material properties.

3DEditBench object manipulation benchmark, Spelke segments enabled more physically plausible
editing as they reflect what truly moves together in the scene. On the other hand, we found that
models like SAM often split up or combine objects in ways that are inconsistent with how they move,
resulting in segments that may be less useful when the goal is to physically manipulate objects.

Looking ahead, we observe that causal probe-based structure extractions from **SpelkeNet** may
also offer a pathway to inferring other properties of the scene beyond segmentation. We find that
segments from **SpelkeNet** can reveal support relationships between objects. As shown in Figure 11,
when virtually poking an object at the bottom of a stacked structure, the extracted segment includes
every entity that the object physically supports. Additionally, as illustrated in Figure 12, the
_p_ motion maps produced can be used to infer physical attributes such as rigidity or material type. For
instance, rigid objects like laptops and cardboard boxes tend to exhibit a uniform probability across
the segment, while deformable objects such as cloth and plastic covers often show more localized
motion responses near the poke point. Exploring this connection between motion response patterns
and physical properties is a promising direction for future work.

Though our focus in this paper has been on human-centric macroscopic physical scenes, the
underlying philosophy of using predictive models to uncover causal and structural patterns through
probing could open new avenues for data-driven discovery in other domains where humans have
less direct intuition about the nature of objecthood. For example, in medical imaging, a model
trained on time-lapse microscopy might help identify cohesive intra-cellular structures or track
morphological changes, while in astrophysics, models trained on galaxy evolution data could be
probed to discover gravitationally bound systems.

22

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

**Acknowledgements**

This work was supported by the following awards: Simons Foundation grant SFI-AN-NC-GBCulmination-00002986-05, National Science Foundation CAREER grant 1844724, National Science
Foundation Grant NCS-FR 2123963, Office of Naval Research grant N00014-20-1-2589, ONR MURI
N00014-21-1-2801, ONR MURI N00014-24-1-2748, and ONR MURI N00014-22-1-2740. We also
thank Stanford HAI, Stanford Data Science, the Marlowe team, and the Google TPU Research
Cloud team for providing computing support.

**—** **Supplementary** **Materials** **—**

In this supplementary material, we provide additional qualitative results and further details about
our architecture. This document is organized as follows:

 - **Section** **6:** **Additional** **Qualitative** **results.**

**–** More illustrations showing probability of motion maps (i.e _p_ motion) and expected direction

of motion maps (i.e Edisp) on real-world images and how they are used for Spelke segment
discovery (Section 6.1).

**–** Additional point-prompted segmentation results (Section 6.2).

**–** More examples of downstream object manipulation using our Spelke segments (Sec
tion 6.3).

 - **Section** **7:** **Further** **Architectural** **Details**

**6** **Additional Qualitative Results**

**6.1** **Additional Examples illustrating our Spelke Segment Discovery Algorithm**

In Section 3.2 and Figure 4 of the main paper, we outlined our algorithm for discovering Spelke
segments by simulating virtual pokes and aggregating directional flow responses. Here, in Figure 13
we provide additional examples visualizing the full process—from poke point sampling to segment
extraction—highlighting the emergence of coherent, manipulable object masks. These visualizations
further support the robustness and consistency of our flow-based grouping method across a diverse
range of objects and scenes. These results also include more examples of probability of motion maps
and expected direction of motion maps. However, unlike Figure 4 of the main paper which only
showed these maps generated in parallel mode, here we depict the expected direction of motion
maps computed using multiple autoregressive rollouts (i.e. Eseq)

**6.2** **Point-Prompted Segmentation Results**

In Section 4.1 of the main paper, we evaluated segmentation quality under point-prompted settings
on our SpelkeEntitySeg benchmark **SpelkeBench** . Here, we present additional qualitative results
comparing our method to baselines including SAM2 [8], DINOv2 [11], and CWM [33]. As shown in
Figure 14, our method consistently produces cohesive and physically plausible segments, in contrast
to alternatives that often fragment objects or include extraneous background.

23

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

**6.3** **Object Manipulation Using Predicted Segments**

We previously demonstrated in Section 4.3 of the main paper, the importance of physically grounded

segmentation for object manipulation. Here, in Figure 15 we include further qualitative comparisons of edits generated using our predicted segments versus those from SAM [8]. As illustrated,
segments aligned with Spelke objecthood significantly improve edit realism, spatial coherence, and
transformation consistency across multiple 3DEditBench [9] examples.

**7** **SpelkeNet Specifications**

**7.1** **Model Architecture**

LRAS [9] is a generative visual world model that predicts plausible optical flow fields conditioned on
an RGB frame. It is a 7 billion-parameter autoregressive transformer (standard LLaMA architecture

[48], 32 layers, 4096 embed dimensions, 32 attention heads) that operates over local patch tokens
and can generate the predicted flow field in any order, sequentially or in parallel.

**7.2** **RGB and Flow Quantization**

The LRAS pipeline starts with a lightweight convolutional auto-encoder which quantizes each 4 × 4
pixel patch into an independent 16-bit code, yielding a 65,536-token vocabulary for RGB images (a
second, similar quantizer is used to quantize optical-flow patches).

**7.3** **Enabling both locality and random access**

During serialization of the RGB and flow tokens into a 1D causal sequence, the model inserts special
pointer tokens that tell the decoder which patch location to fill next, letting it generate images
in an arbitrary or explicitly user-defined order instead of the usual raster scan. This locality plus
random-access design promotes compositionality and gives every patch equal causal power. It also
allows for fully parallel decoding, illustrating the current best estimate of the model’s prediction at
any step during the decoding (as described in Section 3.2 in the main paper).

**7.4** **Dataset preparation**

The model is pre-trained on BVD (Big Video Dataset [9]) - a 7k hour dataset of diverse Internet
videos mixed with standard 3-D vision datasets such as ScanNet++ [49], CO3D [50], RealEstate-10K

[51] and standard video datasets such as Kinetics [52], SomethingSomethingv2 [53] and OpenX
embodiment [44]. Camera pose information is provided to the model whenever available in the
dataset, and optical flow for every frame pair is computed with the SeaRAFT [46] model and
quantized.

**7.5** **Training details**

The model is trained with sequence lengths of 4096 and a batch size of 512 for 200k steps with
next-token cross-entropy loss. The quantizers themselves are first trained on Kinetics-400 frames
with simple L2 reconstruction loss. The model was trained on 64 H100 GPUs for approximately 14
days.

24

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

**Figure** **13:** **More** **illustrations** **of** **our** **Spelke** **segment** **discovery** **algorithm** . To discover
movable objects, we apply multiple virtual pokes at locations sampled from the _p_ motion map (column
2). While the model consistently propagates flow across the poked object (column 3), it also
generates unprompted flow on other objects. However, since this unprompted flow varies across
pokes and typically diverges in direction from the input poke, it gets suppressed when averaging the
dot product (column 4) and helps us isolate independently movable entities as shown in the last
column. Note that we average across 5 pokes, but only show two rows here for brevity.

25

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

**Figure** **14:** **Additional** **qualitative** **results** **for** **point-promoted** **segmentation** **across**
**models.** **SpelkeNet** yields sharper, more “Spelke-like” segments compared to SAM2, DINO, and
CWM.

26

<u>SpelkeNet</u> <u>Stanford NeuroAI Lab</u>

**Figure** **15:** **Additional** **qualitative** **comparisons** **of** **scene** **edits** **using** **SAM** **masks** **versus**
**SpelkeNet** **segments.** Each row shows the original image, the user click location, and the resulting
edited image using different segmentation methods.
