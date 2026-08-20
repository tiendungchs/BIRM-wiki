# peng-gcq-grid-code-quantization-2025

> Converted from `peng-gcq-grid-code-quantization-2025.pdf` on 2026-08-18 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

## **Vector Quantization in the Brain: Grid-like Codes in** **World Models**

**Xiangyuan Peng** <sup>_∗_</sup> **Xingsi Dong** <sup>_∗†_</sup>
```
1900012762peng@pku.edu.cn dxs19980605@pku.edu.cn

```

**Si Wu** <sup>_†_</sup>
```
siwu@pku.edu.cn

```

PKU-Tsinghua Center for Life Sciences, Academy for Advanced Interdisciplinary Studies.
IDG/McGovern Institute for Brain Research, Center of Quantitative Biology, Peking University.

School of Psychological and Cognitive Sciences,
Key Laboratory of Machine Perception (Ministry of Education).

_∗_ : Equal contribution.

_†_ : Corresponding authors.

**Abstract**

We propose Grid-like Code Quantization (GCQ), a brain-inspired method for compressing observation–action sequences into discrete representations using grid-like
patterns in attractor dynamics. Unlike conventional vector quantization approaches
that operate on static inputs, GCQ performs spatiotemporal compression through
an action-conditioned codebook, where codewords are derived from continuous
attractor neural networks and dynamically selected based on actions. This enables
GCQ to jointly compress space and time, serving as a unified world model. The
resulting representation supports long-horizon prediction, goal-directed planning,
and inverse modeling. Experiments across diverse tasks demonstrate GCQ’s effectiveness in compact encoding and downstream performance. Our work offers both
a computational tool for efficient sequence modeling and a theoretical perspective
on the formation of grid-like codes in neural systems.

**1** **Introduction**

VQ-VAE [1] introduces discrete latent variables into the autoencoding framework through vector
quantization (VQ) [2], allowing the model to compress high-dimensional continuous inputs into
discrete, tokenized representations. This capability has led to its widespread application across
various domains, including images [3, 4], video [5], speech [6], actions [7], and multimodal data [8],
demonstrating its versatility in handling complex, diverse inputs. The success of VQ-VAE underscores the utility of compressing inputs into reusable codes as a general computational strategy for
preprocessing and organizing data across a wide range of tasks.

Biological systems face the similar challenge: how to process and represent high-dimensional, continuous inputs arising from multiple sensory and motor modalities. In parallel, the brain exhibits grid-like
codes (GCs), which serve as general-purpose neural patterns for encoding information. GCs are extensively observed across various brain regions. Initially identified in the medial entorhinal cortex for
spatial navigation [9], GCs have since been observed in the neocortex [10, 11, 12] and associated with
representing abstract concepts beyond space, such as time and relational knowledge [10, 11, 13, 14].
This widespread neural activity is characterized by bump-like patterns, periodicity, and typically
disentangled representations.

Building on this insight, we propose a brain-inspired VQ method, Grid-like Code Quantization (GCQ),
which uses the principles of GCs to structure the codebook. Specifically, we use continuous attractor
neural networks (CANNs) [15, 16, 17] to generate grid-like activity patterns, where each stable

39th Conference on Neural Information Processing Systems (NeurIPS 2025).

state—bump—acts as a codeword. Due to the finite number of neurons, these bumps naturally form
a discretized representation [18]. Unlike traditional VQ methods that use a static codebook, GCQ
introduces an action-conditioned codebook: a dynamic set of codewords formed by CANN-generated
bumps whose transitions are modulated by actions. This enables GCQ to perform quantization
not on isolated observations, but on observation–action sequences, allowing the representations to
capture temporal dependencies and behavioral context. Moreover, assigning distinct CANNs to
different action types naturally yields disentangled representations, facilitating generalization and
compositionality.

The overall GCQ pipeline follows an encoder–quantizer–decoder architecture, adapted for actionconditioned sequence compression (Fig. 2). Specifically, the model processes an observation–action
sequence, where the action sequence is used to construct an action-conditioned codebook, and the
observation sequence is passed through the encoder to produce a corresponding latent sequence. This
latent sequence is then quantized via template matching with the action-conditioned codebook. The
matched codewords are passed to the decoder, which reconstructs the original observation sequence.
Since the codebook is fixed, training requires only a commitment loss and a reconstruction loss.
To enable gradient flow through the discrete quantization step, we use a straight-through estimator
(STE).

GCQ is a dynamic compression approach that operates on observation–action sequences, and therefore
serves as a form of world model [19, 20]. Unlike prior world models that rely on a two-stage design
to separately compress space and time—typically using models like VQ-VAE for static spatial
observations and autoregressive models [21] for temporal dynamics—GCQ performs spatial and
temporal compression jointly.

In summary, our contributions are as follows:

    - To the best of our knowledge, GCQ is the first model to unify spatial and temporal compression through an action-conditioned quantization process. This enables direct compression of
observation–action sequences, offering an integrated alternative to conventional two-stage
world models. (Sec. 4)

    - GCQ’s spatiotemporal compression yields a cognitive map, which supports long-horizon
prediction, goal-directed planning, and the derivation of an inverse model. In particular,
goal-directed planning becomes computationally simple, as it reduces to finding a sequence
of valid bump transitions on the map. (Sec. 5).

    - GCQ offers insights into the formation of GCs in the brain, enhancing our understanding of
neural representations (Sec. 6).

**2** **Related Work**

**VQ** **methods** Vanilla VAEs [22] often suffer from posterior collapse in their latent spaces when
compressing high-dimensional data [23], impairing downstream tasks. VQ-VAEs [1] address this by
enforcing a structured latent space through discretization. Due to their superior compression efficiency
and tokenization paradigm, VQ has become a standardized module in single-modal preprocessing
pipelines in machine learning [3, 4]. In multimodal settings, these compressed tokens further act
as a universal interface across modalities [5]. Meanwhile, numerous studies have proposed diverse
codebook designs to enhance compression rates [24, 25, 26]. Unlike most learnable codebooks, FSQ
uses a predefined codebook. Similarly, our GCQ utilizes a fixed codebook derived from continuous
attractor dynamics. Critically, our method diverges from conventional VQ approaches by performing
sequence-to-sequence template matching rather than single-frame matching.

**World** **models** [19, 20] provide a framework for predicting future observations conditioned on
actions. Most world models based on encoder–decoder architectures first compress observations
using a VAE, and then model temporal dynamics in the latent space using temporal predictors such
as RNNs [27, 28], Transformers [29], S4 models [30], or continuous Hopfield networks [31]. These
approaches typically follow a two-stage design, with spatial and temporal compression handled
separately. In contrast, GCQ is also an encoder–decoder world model, but it performs spatial and
temporal compression jointly. There also exist decoder-only world models [32] that skip explicit
compression and directly predict future observations. However, these models often struggle with
planning due to the high computational cost of operating in the raw observation space. GCQ, by

2

Attractors

𝐼

(C)

𝑒!

~~"~~ <sup>~~,~~</sup> <sup>$</sup>

𝑈

(D)

𝑒"," 𝑒"," + 𝑎$%

$% 𝑒"," + 𝑎$ <sup>&</sup> 𝑒"," + 𝑎'% 𝑒"," + 𝑎'&

𝑒! ~~%~~

~~"~~

<u>!</u> ~~%~~ <sup>~~,&~~</sup> <sup><u>!</u></sup> ~~"~~

CANN

𝑒&! ~~%~~

<u>!</u> ~~%~~ <sup>~~,~~</sup> <sup><u>!</u></sup> ~~"~~

~~"~~

(E)

𝑒"," + 𝑎'% 𝑒"," + 𝑎'&

'% 𝑒"," + 𝑎'& 𝑒"," + 𝑎∅

Figure 1: (A) Schematic of a CANN: Each green dot represents a neuron uniformly distributed on a
torus. The neurons receive external input _I_ . (B) Energy landscape of CANN dynamics: Each local
minimum in the energy landscape corresponds to an attractor state, which manifests as a 2D Gaussian
bump on the torus. (C) Template matching via CANN dynamics: The CANN inherently performs
template matching between the external input _I_ and its attractor states. The input _I_ is matched to
the attractor that maximizes their inner product. (D) Attractor transition: Under four distinct actions,
the attractor initially at position (0 _,_ 0) stabilizes to four new attractor states. (E) Due to the periodic
boundary conditions of the CANN, bump movements along the two axes naturally form grid-like
patterns.

compressing both space and time into a compact latent representation, enables more efficient planning
and inference.

**Cognitive map with CANNs** Unlike classical attractor networks [33]—which store discrete, unstructured patterns—CANNs encode structured patterns organized by metric relationships. This
geometric regularity facilitates flexible state transitions through predefined operators [34], enabling
operations like metric-based navigation and relational inference. Recent advances [35] have harnessed
predefined CANNs as structured latent states for representation learning, empirically validating their
ability to model neural population dynamics. Further work [36] proposes that structured latent spaces
can map biologically to the entorhinal-hippocampal loop, a core circuit for spatial and episodic
memory. However, existing implementations rely on biologically constrained online learning, which
limits scalability. Our GCQ framework uses offline learning, enhancing parallelism and enabling
application to large-scale datasets.

**3** **CANNs and Template Matching**

In this section, we will briefly introduce CANNs, explain how they can form bumps as attractor states.
In parallel, for VQ, the latent state obtained by the encoder must undergo template matching with
codewords. We will demonstrate that CANNs inherently implement template matching between representations and bump states through their intrinsic dynamics. Finally, we will show how transitions
between distinct attractor states can be mediated by actions.

GCs can naturally be modeled by bumps in CANNs (Fig. 1E). The formation of CANNs does not
require complex optimization but relies on translation-invariant connectivity and periodic boundary
conditions. CANNs have been widely used as canonical models to elucidate the encoding of features
in neural systems, including, for example, the encoding of orientation [37], head direction [38] and
spatial location [17, 39]. CANNs can be expressed through various mathematical formulations. Here,
we adopt a relatively concise form [16] to demonstrate their principles. We consider _N_ <sup>2</sup> neurons
distributed on a toroidal ( _S_ <sup>1</sup> _× S_ <sup>1</sup> ) surface. These neurons are indexed by their positions on the torus
_θ_ _∈{θi}_ <sup>_N_</sup> _i_ =1 <sup>and</sup> <sup>_φ_</sup> <sup>_∈{φj}_</sup> _j_ <sup>_N_</sup> =1 <sup>, where</sup> <sup>_θi_</sup> <sup>and</sup> <sup>_φj_</sup> <sup>are uniformly distributed over (</sup> <sup>_−π, π_</sup> <sup>] (Fig. 1A).</sup>

<sup>_N_</sup> _i_ =1 <sup>and</sup> <sup>_φ_</sup> <sup>_∈{φj}_</sup> _j_ <sup>_N_</sup>

_θ_ _∈{θi}_ <sup>_N_</sup> _i_ =1 <sup>and</sup> <sup>_φ_</sup> <sup>_∈{φj}_</sup> _j_ <sup>_N_</sup> =1 <sup>, where</sup> <sup>_θi_</sup> <sup>and</sup> <sup>_φj_</sup> <sup>are uniformly distributed over (</sup> <sup>_−π, π_</sup> <sup>] (Fig. 1A).</sup>

Let _Uθ,φ_ ( _t_ ) and _rθ,φ_ ( _t_ ) denote the synaptic input and firing rate, respectively, of the neuron located

3

at ( _θ, φ_ ) at time _t_ . The dynamics of the CANN are governed by:

    
_τ_ <sup>_<u>∂Uθ,φ</u>_</sup> <sup><u>(</u></sup> <sup>_<u>t</u>_</sup> <sup><u>)</u></sup> = _−Uθ,φ_ ( _t_ ) + _ρ_

_∂t_

_θ_ <sup>_′_</sup> _,φ_ <sup>_′_</sup>

_Wθ,φ_ ( _θ_ <sup>_′_</sup> _, φ_ <sup>_′_</sup> ) _rθ′,φ′_ ( _t_ ) + _Iθ,φ_ ( _t_ ) _,_ (1)

where _τ_ is the synaptic time constant and _ρ_ is the neuronal density. _Wθ,φ_ ( _θ_ <sup>_′_</sup> _, φ_ <sup>_′_</sup> ) is the recurrent
neuronal connections weights between neuron ( _θ, φ_ ) and neuron ( _θ_ <sup>_′_</sup> _, φ_ <sup>_′_</sup> ),

_<u>S</u>_ <sup>2</sup> <sup><u>+</u></sup> <sup>_<u>||φ −</u>_</sup> <sup>_<u>φ′||</u>_</sup> _<u>S</u>_ <sup>2</sup>

_Wθ,φ_ ( _θ_ <sup>_′_</sup> _, φ_ <sup>_′_</sup> ) = 2 _πaJ_ <sup>2</sup> <sup>exp</sup> - _−_ <sup>_<u>||θ −</u>_</sup> <sup>_<u>θ′||</u>_</sup> _<u>S</u>_ <sup>2</sup>

_<u>S</u>_
2 _a_ <sup>2</sup>

_._ (2)

The norm _∥·∥S_ denotes the shortest path between two points on the circle, ensuring periodic boundary
and translation-invariant conditions. The parameters _J_ and _a_ control the strength and width of the
Gaussian connectivity, respectively. The nonlinear relationship between the firing rate _rθ,φ_ ( _t_ ) and the
synaptic input _Uθ,φ_ ( _t_ ) is implemented by divisive normalization, which is written as,

(3)
_θ_ <sup>2</sup> <sup>_′_</sup> _,φ_ <sup>_′_</sup> <sup>(</sup> <sup>_t_</sup> <sup>)</sup> <sup>_,_</sup>

_rθ,φ_ ( _t_ ) =

_Uθ,φ_ <sup>2</sup> <sup>(</sup> <sup>_t_</sup> <sup>)</sup>

1 + _kρ_ <sup><u>�</u></sup> _θ_ <sup>_′_</sup> _,φ_ <sup>_′ Wθ,φ_</sup> <sup>(</sup> <sup>_θ_</sup>

_θ_ <sup>_′_</sup> _,φ_ <sup>_′ Wθ,φ_</sup> <sup>(</sup> <sup>_θ′, φ′_</sup> <sup>)</sup> <sup>_U_</sup> _θ_ <sup>2</sup>

_U_ <sup>2</sup>

where _k_ controls the normalization strength. In reality, divisive normalization could be implemented
by shunting inhibition [40].

Previous studies [16, 41] have established that the CANN dynamics governed by Eq. (1) possess _N_ <sup>2</sup>
stationary states (attractors) when the external input _Iθ,φ_ ( _t_ ) = 0 (Fig. 1B). Each state corresponds to
a 2D Gaussian bump on the torus, centered at coordinates ( _θ, φ_ ), with the firing rate of the neuron at
position ( _θ_ <sup>_′_</sup> _, φ_ <sup>_′_</sup> ) given by:

- _−_ <sup>_<u>∥θ −</u>_</sup> <sup>_<u>θ′∥</u>_</sup> _<u>S</u>_ <sup>2</sup>

_<u>S</u>_
2 _a_ <sup>2</sup>

_eθ,φ_ ( _θ_ <sup>_′_</sup> _, φ_ <sup>_′_</sup> ) = _A_ exp

_<u>S</u>_ <sup>2</sup> <sup><u>+</u></sup> <sup>_<u>∥φ −</u>_</sup> <sup>_<u>φ′∥</u>_</sup> _<u>S</u>_ <sup>2</sup>

_,_ (4)

where _A_ = �1 + (1 _−_ 32 _πa_ <sup>2</sup> _k/J_ <sup>2</sup> _ρ_ ) <sup>1</sup> <sup>_/_</sup> <sup>2�</sup> _/_ (4 _πa_ <sup>2</sup> _kρ_ ) is the amplitude. When _Iθ,φ_ ( _t_ ) is a constant

input, prior work [42] demonstrated that after its removal, the network converges to an attractor
determined by:

_θ_ <sup>_′_</sup> _,φ_ <sup>_′_</sup>

_θ_ <sup>_∗_</sup> _, φ_ <sup>_∗_</sup> = max

_θ,φ_

_θ_ <sup>_∗_</sup> _, φ_ <sup>_∗_</sup> = max

_eθ,φ_ ( _θ_ <sup>_′_</sup> _, φ_ <sup>_′_</sup> ) _Iθ′,φ′,_ (5)

which demonstrates that CANN dynamics effectively perform template matching between the input _I_
and the _N_ <sup>2</sup> attractors according to their inner product. (Fig. 1C).

The bump in CANNs exhibit high mobility, enabling controlled movement through mechanisms such
as: anti-symmetric connections [43], negative feedback [44, 43], velocity neurons [45]. Such bump
displacements correspond to transitions between attractor states. For the toroidal CANN described
above, each attractor can undergo local two-dimensional displacements in the _θ, φ_ plane. We define
two orthogonal action bases aligned with the _θ_ and _φ_ axes (Fig. 1D),

_a_ <sup>_±_</sup> _θ_

<sup>_±_</sup> _φ_ <sup>=</sup> <sup>_eθ,φ±_</sup> <sup>∆</sup> <sup>_φ_</sup> <sup>_−_</sup> <sup>_eθ,φ._</sup> (6)

<sup>_±_</sup> _θ_ <sup>=</sup> <sup>_eθ±_</sup> <sup>∆</sup> <sup>_θ,φ −_</sup> <sup>_eθ,φ,_</sup> _a_ <sup>_±_</sup> _φ_

where ∆ _φ_ and ∆ _θ_ denote a small displacement step.

**4** **Grid-like Code Quantization**

In this section, we first introduce the action-conditioned codebook in GCQ and the template matching
process for sequences. We then describe how GCQ enables bidirectional mapping between real-world
actions and latent transitions, and propose a greedy operator for measuring distances on the cognitive
map to support inverse modeling and planning.

**4.1** **Action-conditioned codebook and sequence matching**

We first introduce the key difference between GCQ and VQ from a high-level perspective. In the VQ
method, the encoder first compresses the observation _o_ into _s_, which is then matched to the closest
codes in the codebook through template matching, producing ˆ _s_ . The decoder then reconstructs ˆ _o_ from
_s_ ˆ. In GCQ, the input consists of an action-observation sequence _{o_ 1 _, a_ 1 _, o_ 2 _, a_ 2 _, ..., on}_ . The encoder

4

𝑜!
𝑎!

𝑜$ 𝑜% 𝑜# 𝑜(

𝑎$ 𝑎% 𝑎#

action-conditioned codebook

|Col1|Col2|Col3|Col4|Col5|Col6|Col7|Col8|Col9|Col10|
|---|---|---|---|---|---|---|---|---|---|
|||||||||||
|||||||||||

|Col1|𝑒<br>'|Col3|𝑒 + 𝑎<br>' !|Col5|𝑒 + 𝑎<br>' !:$|Col7|𝑒 + 𝑎<br>' !:%|Col9|𝑒 + 𝑎<br>' !:#|
|---|---|---|---|---|---|---|---|---|---|
||𝑒$<br>…||𝑒$ + 𝑎!<br>…||𝑒$ + 𝑎!:$<br>…||𝑒$ + 𝑎!:%<br>…||𝑒$ + 𝑎!:#<br>…|

)𝑜! )𝑜$ )𝑜% )𝑜# )𝑜(

Figure 2: Schematic of GCQ: The action-observation sequence is encoded by the encoder into a latent
state composed of _m_ = 3 codes. Through sequence template matching with the action-conditioned
codebook, the decoder reconstructs the predicted observations. The gray arrows indicate the template
matching process, and the gray dashed boxes represent the matching targets.

compresses the observation sequence _o_ 1: _n_ = _{o_ 1 _, o_ 2 _, ..., on}_ into _s_ 1: _n_, which is then matched to the
closest codes in the action-conditioned codebook via template matching, yielding ˆ _s_ 1: _n_ . The decoder
then reconstructs ˆ _o_ 1: _n_ from ˆ _s_ 1: _n_ .

In GCQ, each code corresponds to an attractor in the CANN (Fig. 1B). In the previous section,
we used _θ_ and _φ_ to index different attractors; for simplicity, we will now use natural numbers as
attractor indices. Each code consists of _d_ neurons, and the codebook contains _K_ attractors. A
simple implementation sets _K_ = _d_, where each attractor’s center coincides with a single neuron.
Alternatively, we can set _K_ _>_ _d_, causing some attractor centers to fall between two neurons. In
practice, different combinations of _K_ and _d_ can be selected. The state representation _si_ _∈_ R <sup>_m×d_</sup>,
meaning that _si_ is composed of _m_ codes.

Additionally, we manually define a mapping between the action sequence _ai_ _∈A_ from the dataset
and the action combinations applied to the CANNs. For notational simplicity, we hereafter use _ai_ to
refer to an action in either the original space or the CANN space. In the latter context, _ai_ _∈_ R <sup>_m×d_</sup>

represents the composite action over _m_ bumps, with its component _a_ <sup>_j_</sup> _i_ <sup>_∈_</sup> <sup>R</sup> <sup>_d_</sup> <sup>denoting the action</sup>

applied to the _j_ -th bump in Eq.(6). Each CANN supports five distinct actions, resulting in up to
5 <sup>_m_</sup> possible action combinations across _m_ CANNs. Since this mapping is injective, the discrete
action space must satisfy _|A| ≤_ 5 <sup>_m_</sup> . For continuous actions, a CANN can define transitions in two
directions, imposing the constraint dim( _A_ ) _≤_ 2 _m_ .

After establishing the mapping, we quantize the latent representation _s_ 1: _n_ = _{s_ <sup>_j_</sup> 1: _n_ <sup>_}_</sup> _j_ <sup>_m_</sup> =1 <sup>.</sup> <sup>This</sup>

representation consists of a set of _m_ parallel sequences, where each _s_ <sup>_j_</sup> 1: _n_ <sup>corresponds to a sequence</sup>

from one of the _m_ CANNs (as depicted by the dashed lines in Fig. 2). The quantization process is
performed independently for each of these _m_ sequences. For each latent sequence _s_ <sup>_j_</sup> 1: _n_ <sup>, we perform a</sup>

template matching procedure. This involves comparing _s_ <sup>_j_</sup> 1: _n_ <sup>against a set of</sup> <sup>_K_</sup> <sup>candidate trajectories.</sup>

Each candidate trajectory is generated by applying the known action sequence _a_ <sup>_j_</sup> 1: _n−_ 1 <sup>to a base bump</sup>

state _ei_ . We denote this operation as:

_ei ⊕_ _a_ <sup>_j_</sup> 1: _n−_ 1 <sup>=</sup> <sup>_{ei, ei_</sup> <sup>+</sup> <sup>_a_</sup> 1 <sup>_j_</sup> <sup>_, . . ., ei_</sup> <sup>+</sup> <sup>_aj_</sup> 1: _n−_ 1 <sup>_},_</sup> (7)

<sup>_j_</sup> 1: _n−_ 1 <sup>=</sup> <sup>_ei_</sup> <sup>+ �</sup> _t_ <sup>_n_</sup> =1 <sup>_−_</sup> <sup>1</sup> <sup>_a_</sup> _t_ <sup>_j_</sup>

where _ei_ + _a_ <sup>_j_</sup>

where _ei_ + _a_ <sup>_j_</sup> 1: _n−_ 1 <sup>=</sup> <sup>_ei_</sup> <sup>+ �</sup> _t_ <sup>_n_</sup> =1 <sup>_−_</sup> <sup>1</sup> <sup>_a_</sup> _t_ <sup>_j_</sup> <sup>.</sup> <sup>The index</sup> <sup>_k_</sup> <sup>of the best-matching codeword for the</sup> <sup>_j_</sup> <sup>-th latent</sup>

sequence is found by minimizing a distance metric (e.g., the L2 norm) between the latent sequence
and each of the _K_ candidate trajectories:

_kj_ = arg _i∈{_ min1 _,..,K}_ <sup>_||s_</sup> 1: <sup>_j_</sup> _n_ <sup>_−_</sup> <sup>(</sup> <sup>_ei ⊕_</sup> <sup>_a_</sup> 1: <sup>_j_</sup> _n−_ 1 <sup>)</sup> <sup>_||_</sup> (8)

5

(A) Long-horizon prediction (B) Goal-directed planning

𝑜" 𝑎" 𝑜$

|Col1|Col2|Col3|Col4|Col5|Col6|Col7|
|---|---|---|---|---|---|---|
||||||||
||||||||

|𝑒# + 𝑎!:$<br>𝑒" + 𝑎!:$<br>…|Col2|𝑒# + 𝑎!:'<br>𝑒" + 𝑎!:'<br>…|
|---|---|---|
|𝑒# + 𝑎!:$<br>𝑒" + 𝑎!:$<br>…|𝑎'|𝑎'|

)𝑜' )𝑜(

|Col1|𝑒#|Col3|𝑒# + 𝑎!|Col5|𝑒# + 𝑎!:"|Col7|
|---|---|---|---|---|---|---|
||𝑒"<br>…||𝑒" + 𝑎!<br>…||𝑒" + 𝑎!:"<br>…|𝑒" + 𝑎!:"<br>…|

end if 𝑎- == 𝑎.

Figure 3: (A) Schematic of long-horizon prediction. The figure illustrates the process of initializing
with a sequence of length 3 and predicting two future observations. (B) Schematic of goal-directed
planning. Some gray arrows are omitted for clarity. The blue arrows represent the mapping from
actions in the latent space to real agent actions. Through iterative action generation, environment
interaction, and observation, the agent continues until it outputs a no-op action _a∅_, indicating that the
goal has been reached.

Finally, the quantized sequence ˆ _s_ <sup>_j_</sup> 1: _n_ <sup>is constructed using this optimal codeword</sup> <sup>_ek_</sup> _j_ <sup>.</sup> <sup>The complete</sup>

quantized representation ˆ _s_ 1: _n_ is the collection of these individually quantized sequences:

_s_ ˆ <sup>_j_</sup>

<sup>_j_</sup> 1: _n_ <sup>=</sup> <sup>_ek_</sup> _j_ <sup>_⊕_</sup> <sup>_a_</sup> 1: <sup>_j_</sup> _n−_ 1 <sup>_,_</sup> and _s_ ˆ1: _n_ = _{s_ ˆ <sup>_j_</sup> 1:

<sup>_j_</sup> 1: _n_ <sup>_}_</sup> _j_ <sup>_m_</sup> =1 (9)

When computing the loss in GCQ using backpropagation (BP), we adopt the same straight-through
estimator (STE) as in the VQ method, copying gradients from the decoder input to the encoder
output to enable gradient flow to the encoder. GCQ uses two loss terms: a reconstruction loss and a
commitment loss:

_L_ = _||o_ 1: _n −_ _o_ ˆ1: _n||_ <sup>2</sup> + _β ∥s_ 1: _n −_ sg [ˆ _s_ 1: _n_ ] _∥_ <sup>2</sup> (10)

where sg[ _·_ ] denotes the stop-gradient operation and _β_ adjusts the strength of the commitment loss.

In GCQ, the encoder and decoder are not designed in the same way as in conventional VQ models.
Traditional VQ architectures often use ResNet-based building blocks, which provide each code with
only a limited receptive field. As a result, modifying a single code typically leads to only local
changes in the reconstructed observation. In contrast, GCQ assigns each code to an action, and
altering the action can result in global changes to the observation. This necessitates that each code
has access to global information during encoding and decoding. To address this, we explore three
architectural variants for the encoder and decoder: (1) ResNet followed by a fully connected layer,
(2) ViT [46], and (3) a hybrid of ResNet and ViT. Among these, ViT achieves the best trade-off in
terms of parameter efficiency, training stability, and overall performance (Table.1).

**4.2** **Operations on cognitive map**

GCQ uses a structured latent space, allowing an agent’s actions in the real environment to correspond
to simple movements of bumps within the latent space. In effect, GCQ constructs a space defined by
bump dynamics, which can be interpreted as a cognitive map. By establishing a mapping between
observations and this map, actions in the real space can be projected onto the map to determine
position changes, and conversely, movements within the map can be mapped back to real-space
actions. This bidirectional mapping enables GCQ to support both inverse modeling and goal-directed
planning. Specifically, to compute the distance between two states _si_ and _sj_, we define an operation
on the cognitive map. Since bump movements are action-driven and only valid actions produce
feasible transitions, we introduce the following operation:

_si ⊖_ _sj_ = arg min _a∈A_ <sup>_|sj_</sup> <sup>+</sup> <sup>_a −_</sup> <sup>_si|._</sup> (11)

This operation represents a greedy step: it selects the best valid action _a_ that moves _sj_ one step closer
to _si_ .

6

(A) (B) (C) (D)

(E)

Figure 4: (A)(B) Reconstruction FID and prediction FID for GCQ and VQ+UNet across different
model sizes. (C) Prediction FID of GCQ varies with changes in the initialization length. (D)
Prediction FID of GCQ (#Para:112M), VQ+UNet (96M) and VQ+Transformer (121M) changes as
the prediction length increases. (E) Predictions on GSV dataset. The first patch in each row represents
the trajectory drawn by the action. The first three rows correspond to movement actions, while the
last two rows correspond to rotation actions. In practice, different actions are encoded within a single
GCQ, enabling their use. For visualization convenience, they are plotted separately here. Rows
1, 2, and 4 show GCQ predictions with different initialization lengths (orange frames), predicting
subsequent observations (blue frames). Rows 3 and 5 show VQ+UNet predictions under the same
conditions. As the prediction length increases, the images become blurry.

**5** **Experiment**

As a spatiotemporal compression model, GCQ is first evaluated in ablation studies to demonstrate its
ability to compress and reconstruct observations. We then show that GCQ, when used as a world
model, supports long-horizon prediction, goal-directed planning, and inverse modeling. Compared to
traditional two-stage models, GCQ exhibits superior performance in long-range prediction tasks.

**Datasets.** We evaluate GCQ on four datasets, all of which contain image-based observations. The
2DMaze [47] dataset is a virtual environment where actions correspond to the agent’s movements.
Each observation contains a full view of the maze, providing complete information. The Google
Street View (GSV) dataset represents real-world environments with partial observations; the actions
include both translational movements and rotational head turns in two directions. In the MPI3D [48]
and 3DShapes [49] datasets, actions are defined as abstract feature-level changes.

**Baselines.** We compare GCQ with traditional two-stage world models. VQ-VAE is used in the first
stage for spatial compression. The codebook size in GCQ and VQ-VAE is kept the same for a fair
comparison. For modeling temporal relationships, we use a UNet that predicts the next latent state
_st_ +1 based on the current latent state _st_ and action _at_ . We refer to this baseline as ’VQ+UNet.’ For
action embedding in the UNet, we follow the approach from LAPO [7]. To further model temporal
dependencies, we also adopt a Transformer-based architecture following TransDreamer [29]. We
refer to this baseline as ’VQ+Transformer.’

**Evaluation Metrics.** To evaluate the quality of the model-generated observations, we report peak
signal-to-noise ratio (PSNR) for pixel-level reconstruction fidelity, and use the Fréchet Inception
Distance (FID) [50] to assess the quality of generated images.

**Ablations** We first conducted ablation experiments on the GSV dataset. Table 1 presents the
performance of three different encoder-decoder network building blocks. It can be observed that
the ViT and Hybrid models achieve better performance with fewer parameters. However, during the

7

experiments, we found that the Hybrid model was less stable in training and converged more slowly
than ViT. Therefore, unless otherwise specified, all subsequent experiments utilized the ViT-structured
network. The GCQ exhibits scalability with model size similar to VQ+UNet, both in reconstruction
and prediction. (Fig. 4A,B).

Model type Image size #Para. FIDr _↓_ FIDp _↓_ PSNRr _↑_ PSNRp _↑_

Resnet 3 _×_ 80 _×_ 40 330M 48.05 48.57 25.70 25.59

3 _×_ 80 _×_ 40 64M 21.29 22.31 29.07 28.54
Hybrid
3 _×_ 128 _×_ 128 140M 41.55 41.91 26.31 25.59

3 _×_ 80 _×_ 40 90M 13.27 13.92 31.32 31.34
ViT
3 _×_ 128 _×_ 128 112M 42.56 43.41 27.82 27.77

Table 1: Model comparisons on the Street View dataset. FIDr, FIDp, PSNRr, and PSNRp represent
the FID and PSNR scores for reconstruction and prediction, respectively. _↓_ and _↑_ indicate that lower
or higher values are better. The ResNet model was not trained on higher resolution images because
its architecture includes a fully connected layer after the convolutional backbone, resulting in an
excessively large number of parameters.

We also make the bump-like codes in the codebook learnable by using the following loss function:

_L_ = _||o_ 1: _n −_ _o_ ˆ1: _n||_ <sup>2</sup> + _β ∥s_ 1: _n −_ sg [ˆ _s_ 1: _n_ ] _∥_ <sup>2</sup> + _γ ∥_ sg [ _s_ 1: _n_ ] _−_ _s_ ˆ1: _n∥_ <sup>2</sup> (12)

However, our experiments show that making the codes learnable actually degrades performance.
We attribute this to the fact that, unlike the relatively simple codes in VQ, our codes exhibit more
complex dynamic relationships. Allowing the codes themselves to be trained may therefore reduce
training stability.

Model FIDp _↓_ PSNRp _↑_

GCQ (fixed) 43.41 27.77
GCQ (learnable) 47.76 24.48

Table 2: Effect of learnable vs. fixed codes in GCQ.

**Long-horizon prediction.** After being initialized with an observation-action sequence, GCQ can
perform actions directly in the latent space to predict future observations (Fig. 3A). Notably, its
prediction performance remains stable regardless of the length of the initialization sequence (Fig. 4C;
Fig. 4E, rows 1–2). As shown in Fig. 4D, the performance of the VQ method degrades as the
prediction horizon increases, whereas GCQ maintains robust predictive quality due to its stable latent
structure (Fig. 4E, rows 2–3). This is a key advantage of GCQ: by constructing a consistent cognitive
map, it effectively addresses the instability issues commonly seen in current world models [51]—such
as inaccurate predictions after completing a full rotation in the environment (Fig. 4E, rows 4–5). GCQ
also demonstrates strong zero-shot prediction capabilities on relatively simple datasets. As shown in
Fig. 5, rows 1–2, the model produces reasonable predictions in environments it has never encountered
during training. Furthermore, by treating abstract feature transitions as a form of action, GCQ can
also be used to predict observation changes driven by abstract-level variations. These predictions
likewise exhibit long-range stability (Fig. 5, rows 3–4).

**Goal-directed planning.** Given a goal and an initial position, the GCQ can utilize the distance in the
cognitive map to generate the most desirable action for the current step. After executing the action, a
new observation is obtained, and this process is iterated, continuously reducing the distance to the
goal in the cognitive map until the goal is reached (Fig. 3B, Fig. 6 rows, 1–2). The computation of
the action at each step is of constant complexity.

**Inverse model.** Given a sequence of observations, the GCQ can first map them onto the cognitive
map and then use goal-directed planning to determine the action or sequence of actions between
adjacent observations, thus implementing the inverse model. The corresponding action sequence can
be applied to the latent representation of another observation, and using the prediction capability, the
generated sequence under this set of actions can be obtained (Fig. 6 rows, 3–4).

8

size

color

Figure 5: With the same setup as Fig. 4E, Rows 1–2: Prediction on the 2DMaze dataset. Rows 3–4:
Prediction on the 3DShapes dataset.

Goal-directed planning

Inverse modeling

Figure 6: Rows 1–2: Goal-directed planning. The first patch shows the trajectory after planning, with
orange indicating the starting point, red indicating the endpoint, and blue representing the planned
route. The subsequent red-framed patches represent the endpoint, orange-framed patches represent
the starting point, and blue-framed patches represent intermediate observations encountered during
the process. Rows 3–4: Inverse modeling. The top row displays the given observation sequence. The
bottom row starts with the first patch showing the action trajectory inferred from the observation
sequence, with orange indicating the given initial observation, followed by the sequence generated
based on the action trajectory.

**6** **Discussion**

In this work, we introduced GCQ, a brain-inspired framework for compressing observation–action
sequences into discrete, structured representations. GCQ uses continuous attractor dynamics to
generate grid-like codewords, and selects them in an action-conditioned manner to capture both
spatial and temporal dependencies. This spatiotemporal quantization process produces compact
latent representations that serve as cognitive maps, enabling long-horizon prediction, goal-directed
planning, and inverse modeling. Our experiments demonstrate that GCQ supports generalization
across tasks while offering interpretability through its structured latent space.

**Insights for Neuroscience.** Beyond its practical performance, GCQ also offers a new computational
hypothesis for the emergence of GCs in the brain. Traditionally, the formation of neurons with
structured tuning properties was approached through handcrafted models [52], which provided
only limited explanatory power. In contrast, the machine learning paradigm offers a data-driven
framework: artificial neural networks are optimized to perform cognitive tasks, and their internal
representations are analyzed to reveal emergent coding principles. Following this approach, prior
studies have shown that GCs can arise when networks are trained to perform path integration under
biologically constraints [53, 54, 55]. Subsequent work has emphasized the importance of predictive
rather than reconstructive objectives [56] and extended the analysis to more general frameworks such
as world models and predictive learning [57]. Efforts to induce disentangled representations through
architectural or loss function constraints have further refined these insights [58, 59]. However, the
robustness of grid-like pattern emergence remains debated [60], with some studies [61] suggesting
that specific architectural features (e.g., one-hot inputs) are necessary.

9

Recent developmental findings add a new dimension to this discussion. Experiments show that
toroidal activity patterns emerge in the medial entorhinal cortex even before sensory experience [62].
Intriguingly, such toroidal structures can be naturally modeled by bump attractors in CANNs. This
suggests that the brain may possess preconfigured low-dimensional structures capable of bump
activity, even prior to learning. Consistent with this, recent work has argued that GCs likely emerge
from internal CANN mechanisms rather than from purely feedforward architectures [63].

This leads us to a novel hypothesis inspired by GCQ: GCs may arise not from optimizing networks,
but from learning to map sensory experience onto a set of preexisting bump-based activity patterns.
In GCQ, the codebook is defined by CANN-generated bumps before learning begins. The learning
process then consists of associating observation–action sequences with combinations of these fixed
codewords. Similarly, we speculate that the brain may use a fixed set of toroidal patterns—produced
by CANNs—as a biological codebook. Through experience, the brain learns to map external sensory
inputs onto these internal structures, endowing them with meaning and interpretability, allowing for
the decoding of grid-like patterns. This perspective suggests a unified model of how the brain may
simultaneously achieve compression and semantic organization of sensory information.

**Static Setting.** We also evaluated GCQ in a static setting, where the sequence length is 1. In this case,
we compared GCQ with VQ-VAE on ImageNet [64], finding that GCQ suffered minimal performance
degradation. This suggests that the use of a fixed codebook does not significantly harm performance
on static tasks. For further details, refer to Appendix A.

**Scalability of Action.** Our current work utilizes 2D attractors, where each has 5 potential transitions
(four shifts and one stationary). With such _m_ CANNs, the model can represent 5 <sup>_m_</sup> distinct actions. If
we use _P_ -dimensional attractors, the number of states per CANN will become 2 _P_ +1, yielding a total
action space of (2 _P_ + 1) <sup>5</sup> . Therefore, GCQ can be scaled to higher-dimensional action spaces by
adjusting both _m_ and _P_ . For the experiments in this paper, which involve relatively low-dimensional
actions, 2D attractors are sufficient.

**Future Work.** A promising direction for advancing GCQ lies in enabling the encoder and decoder
to process entire sequences holistically, rather than treating each sequence element independently.
Incorporating ViTs with spatial-temporal attention could serve as an effective approach toward
this goal. Moreover, scaling GCQ to larger and more diverse datasets would facilitate a deeper
investigation into its generalization capabilities and robustness across a broader range of tasks and
domains.

**Acknowledgments**

This work was supported by the National Natural Science Foundation of China (no. T2421004 to
S.W.), the Science and Technology Innovation 2030-Brain Science and Brain-inspired Intelligence
Project (no. 2021ZD0200204, S.W.).

10

**References**

[1] Aaron Van Den Oord, Oriol Vinyals, et al. Neural discrete representation learning. _Advances in_

_neural information processing systems_, 30, 2017.

[2] Robert Gray. Vector quantization. _IEEE Assp Magazine_, 1(2):4–29, 1984.

[3] Robin Rombach, Andreas Blattmann, Dominik Lorenz, Patrick Esser, and Björn Ommer. High
resolution image synthesis with latent diffusion models. In _Proceedings_ _of_ _the_ _IEEE/CVF_
_conference on computer vision and pattern recognition_, pages 10684–10695, 2022.

[4] Patrick Esser, Robin Rombach, and Bjorn Ommer. Taming transformers for high-resolution

image synthesis. In _Proceedings of the IEEE/CVF conference on computer vision and pattern_
_recognition_, pages 12873–12883, 2021.

[5] Andreas Blattmann, Robin Rombach, Huan Ling, Tim Dockhorn, Seung Wook Kim, Sanja

Fidler, and Karsten Kreis. Align your latents: High-resolution video synthesis with latent
diffusion models. In _Proceedings of the IEEE/CVF conference on computer vision and pattern_
_recognition_, pages 22563–22575, 2023.

[6] Tuan Vu Ho, Quoc Huy Nguyen, Masato Akagi, and Masashi Unoki. Vector-quantized varia
tional autoencoder for phase-aware speech enhancement. 2022.

[7] Dominik Schmidt and Minqi Jiang. Learning to act without actions. _arXiv_ _preprint_
_arXiv:2312.10812_, 2023.

[8] Yecheng Wu, Zhuoyang Zhang, Junyu Chen, Haotian Tang, Dacheng Li, Yunhao Fang, Ligeng

Zhu, Enze Xie, Hongxu Yin, Li Yi, et al. Vila-u: a unified foundation model integrating visual
understanding and generation. _arXiv preprint arXiv:2409.04429_, 2024.

[9] Torkel Hafting, Marianne Fyhn, Sturla Molden, May-Britt Moser, and Edvard I Moser. Mi
crostructure of a spatial map in the entorhinal cortex. _Nature_, 436(7052):801–806, 2005.

[10] Christian F Doeller, Caswell Barry, and Neil Burgess. Evidence for grid cells in a human

memory network. _Nature_, 463(7281):657–661, 2010.

[11] Alexandra O Constantinescu, Jill X O’Reilly, and Timothy EJ Behrens. Organizing conceptual

knowledge in humans with a gridlike code. _Science_, 352(6292):1464–1468, 2016.

[12] Joshua Jacobs, Christoph T Weidemann, Jonathan F Miller, Alec Solway, John F Burke, Xue
Xin Wei, Nanthia Suthana, Michael R Sperling, Ashwini D Sharan, Itzhak Fried, et al. Direct
recordings of grid-like neuronal activity in human spatial navigation. _Nature_ _neuroscience_,
16(9):1188–1190, 2013.

[13] KiJung Yoon, Sam Lewallen, Amina A Kinkhabwala, David W Tank, and Ila R Fiete. Grid cell

responses in 1d environments assessed as slices through a 2d lattice. _Neuron_, 89(5):1086–1099,
2016.

[14] Dmitriy Aronov, Rhino Nevers, and David W Tank. Mapping of a non-spatial dimension by the

hippocampal–entorhinal circuit. _Nature_, 543(7647):719–722, 2017.

[15] Shun-ichi Amari. Dynamics of pattern formation in lateral-inhibition type neural fields. _Biolog-_

_ical cybernetics_, 27(2):77–87, 1977.

[16] Si Wu, Kosuke Hamaguchi, and Shun-ichi Amari. Dynamics and computation of continuous

attractors. _Neural Computation_, 20(4):994–1025, 2008.

[17] Yoram Burak and Ila R Fiete. Accurate path integration in continuous attractor network models

of grid cells. _PLoS computational biology_, 5(2):e1000291, 2009.

[18] Marcella Noorman, Brad K Hulse, Vivek Jayaraman, Sandro Romani, and Ann M Hermundstad.

Maintaining and updating accurate internal representations of continuous variables with a
handful of neurons. _Nature Neuroscience_, 27(11):2207–2217, 2024.

11

[19] Jiirgen Schmidhuber. Making the world differentiable: On using self-supervised fully recurrent n

eu al networks for dynamic reinforcement learning and planning in non-stationary environments,
1990.

[20] Yann LeCun. A path towards autonomous machine intelligence version 0.9. 2, 2022-06-27.

_Open Review_, 62(1), 2022.

[21] Grégoire Delétang, Anian Ruoss, Paul-Ambroise Duquenne, Elliot Catt, Tim Genewein, Christo
pher Mattern, Jordi Grau-Moya, Li Kevin Wenliang, Matthew Aitchison, Laurent Orseau, et al.
Language modeling is compression. _arXiv preprint arXiv:2309.10668_, 2023.

[22] Diederik P Kingma and Max Welling. Auto-encoding variational bayes. _arXiv_ _preprint_
_arXiv:1312.6114_, 2013.

[23] Ananya Harsh Jha, Saket Anand, Maneesh Singh, and VS Rao Veeravasarapu. Disentangling

factors of variation with cycle-consistent variational auto-encoders. In _Proceedings_ _of_ _the_
_European Conference on Computer Vision (ECCV)_, pages 805–820, 2018.

[24] Sander Dieleman, Charlie Nash, Jesse Engel, and Karen Simonyan. Variable-rate discrete

representation learning. _arXiv preprint arXiv:2103.06089_, 2021.

[25] Aurko Roy, Ashish Vaswani, Arvind Neelakantan, and Niki Parmar. Theory and experiments

on vector quantized autoencoders. _arXiv preprint arXiv:1805.11063_, 2018.

[26] Fabian Mentzer, David Minnen, Eirikur Agustsson, and Michael Tschannen. Finite scalar

quantization: Vq-vae made simple. _arXiv preprint arXiv:2309.15505_, 2023.

[27] Junyoung Chung, Kyle Kastner, Laurent Dinh, Kratarth Goel, Aaron C Courville, and Yoshua

Bengio. A recurrent latent variable model for sequential data. _Advances in neural information_
_processing systems_, 28, 2015.

[28] Danijar Hafner, Timothy Lillicrap, Ian Fischer, Ruben Villegas, David Ha, Honglak Lee, and

James Davidson. Learning latent dynamics for planning from pixels. In _International conference_
_on machine learning_, pages 2555–2565. PMLR, 2019.

[29] Chang Chen, Yi-Fu Wu, Jaesik Yoon, and Sungjin Ahn. Transdreamer: Reinforcement learning

with transformer world models. _arXiv preprint arXiv:2202.09481_, 2022.

[30] Mohammad Reza Samsami, Artem Zholus, Janarthanan Rajendran, and Sarath Chandar. Mas
tering memory tasks with world models. _arXiv preprint arXiv:2403.04253_, 2024.

[31] James Whittington, Timothy Muller, Shirely Mark, Caswell Barry, and Tim Behrens. Gener
alisation of structural knowledge in the hippocampal-entorhinal system. _Advances in neural_
_information processing systems_, 31, 2018.

[32] Amir Bar, Gaoyue Zhou, Danny Tran, Trevor Darrell, and Yann LeCun. Navigation world

models. _arXiv preprint arXiv:2412.03572_, 2024.

[33] S-I Amari. Learning patterns and pattern sequences by self-organizing nets of threshold elements.

_IEEE Transactions on computers_, 100(11):1197–1206, 1972.

[34] Junfeng Zuo, Ying Nian Wu, Si Wu, and Wenhao Zhang. The motion planning neural circuit in

goal-directed navigation as lie group operator search. In _The Thirty-eighth Annual Conference_
_on Neural Information Processing Systems_, 2024.

[35] Xingsi Dong, Xiangyuan Peng, and Si Wu. Predictive learning in energy-based models with

attractor structures. _arXiv preprint arXiv:2501.13997_, 2025.

[36] Sarthak Chandra, Sugandha Sharma, Rishidev Chaudhuri, and Ila Fiete. Episodic and associative

memory from spatial scaffolds in the hippocampus. _Nature_, pages 1–13, 2025.

[37] R Ben-Yishai, R Lev Bar-Or, and H Sompolinsky. Theory of orientation tuning in visual cortex.

_Proceedings of the National Academy of Sciences_, 92(9):3844–3848, 1995.

12

[38] Kechen Zhang. Representation of spatial orientation by the intrinsic dynamics of the head
direction cell ensemble: a theory. _The Journal of Neuroscience_, 16(6):2112–2126, 1996.

[39] Bruce L McNaughton, Francesco P Battaglia, Ole Jensen, Edvard I Moser, and May-Britt Moser.

Path integration and the neural basis of the’cognitive map’. _Nature_ _Reviews_ _Neuroscience_,
7(8):663–678, 2006.

[40] Simon J Mitchell and R Angus Silver. Shunting inhibition modulates neuronal gain during

synaptic excitation. _Neuron_, 38(3):433–445, 2003.

[41] C. C Alan Fung, K. Y. Michael Wong, and Si Wu. A moving bump in a continuous manifold: A

comprehensive study of the tracking dynamics of continuous attractor neural networks. _Neural_
_Computation_, 22(3):752–792, 2010.

[42] Sophie Deneve, Peter E Latham, and Alexandre Pouget. Reading population codes: a neural

implementation of ideal observers. _Nature Neuroscience_, 2(8):740–745, 1999.

[43] Yuanyuan Mi, CC Fung, KY Wong, and Si Wu. Spike frequency adaptation implements

anticipative tracking in continuous attractor neural networks. _Advances in neural information_
_processing systems_, 27, 2014.

[44] K Wong, He Wang, Si Wu, and Chi Fung. Attractor dynamics with synaptic depression.

_Advances in Neural Information Processing Systems_, 23, 2010.

[45] Wenhao Zhang, Ying Nian Wu, and Si Wu. Translation-equivariant representation in recurrent

networks with a continuous manifold of attractors. _Advances in Neural Information Processing_
_Systems_, 35:15770–15783, 2022.

[46] Alexey Dosovitskiy, Lucas Beyer, Alexander Kolesnikov, Dirk Weissenborn, Xiaohua Zhai,

Thomas Unterthiner, Mostafa Dehghani, Matthias Minderer, Georg Heigold, Sylvain Gelly, et al.
An image is worth 16x16 words: Transformers for image recognition at scale. _arXiv preprint_
_arXiv:2010.11929_, 2020.

[47] Karl Cobbe, Christopher Hesse, Jacob Hilton, and John Schulman. Leveraging procedural

generation to benchmark reinforcement learning. _arXiv preprint arXiv:1912.01588_, 2019.

[48] Muhammad Waleed Gondal, Manuel Wuthrich, Djordje Miladinovic, Francesco Locatello,

Martin Breidt, Valentin Volchkov, Joel Akpo, Olivier Bachem, Bernhard Schölkopf, and Stefan
Bauer. On the transfer of inductive bias from simulation to the real world: a new disentanglement
dataset. In H. Wallach, H. Larochelle, A. Beygelzimer, F. d'Alché-Buc, E. Fox, and R. Garnett,
editors, _Advances in Neural Information Processing Systems_, volume 32. Curran Associates,
Inc., 2019.

[49] Chris Burgess and Hyunjik Kim. 3d shapes dataset. https://github.com/deepmind/3dshapes
dataset/, 2018.

[50] Martin Heusel, Hubert Ramsauer, Thomas Unterthiner, Bernhard Nessler, and Sepp Hochreiter.

Gans trained by a two time-scale update rule converge to a local nash equilibrium. _Advances in_
_neural information processing systems_, 30, 2017.

[51] Fei Deng, Junyeong Park, and Sungjin Ahn. Facing off world model backbones: Rnns,
transformers, and s4. _Advances in Neural Information Processing Systems_, 36:72904–72930,
2023.

[52] David H Hubel and Torsten N Wiesel. Receptive fields and functional architecture of monkey

striate cortex. _The Journal of physiology_, 195(1):215–243, 1968.

[53] Christopher J Cueva and Xue-Xin Wei. Emergence of grid-like representations by training

recurrent neural networks to perform spatial localization. _arXiv preprint arXiv:1803.07770_,
2018.

[54] Andrea Banino, Caswell Barry, Benigno Uria, Charles Blundell, Timothy Lillicrap, Piotr

Mirowski, Alexander Pritzel, Martin J Chadwick, Thomas Degris, Joseph Modayil, et al. Vectorbased navigation using grid-like representations in artificial agents. _Nature_, 557(7705):429–433,
2018.

13

[55] Ben Sorscher, Gabriel Mel, Surya Ganguli, and Samuel Ocko. A unified theory for the origin

of grid cells through the lens of pattern formation. _Advances in neural information processing_
_systems_, 32, 2019.

[56] Stefano Recanatesi, Matthew Farrell, Guillaume Lajoie, Sophie Deneve, Mattia Rigotti, and

Eric Shea-Brown. Predictive learning as a network mechanism for extracting low-dimensional
latent space representations. _Nature communications_, 12(1):1417, 2021.

[57] James CR Whittington, Timothy H Muller, Shirley Mark, Guifen Chen, Caswell Barry, Neil

Burgess, and Timothy EJ Behrens. The tolman-eichenbaum machine: unifying space and
relational memory through generalization in the hippocampal formation. _Cell_, 183(5):1249–
1263, 2020.

[58] James CR Whittington, Will Dorrell, Surya Ganguli, and Timothy EJ Behrens. Disentanglement

with biological constraints: A theory of functional cell types. _arXiv preprint arXiv:2210.01768_,
2022.

[59] Yusi Chen, Huanqiu Zhang, Mia Cameron, and Terrence Sejnowski. Predictive sequence

learning in the hippocampal formation. _Neuron_, 112(15):2645–2658, 2024.

[60] Ben Sorscher, Gabriel C Mel, Aran Nayebi, Lisa Giocomo, Daniel Yamins, and Surya Ganguli.

When and why grid cells appear or not in trained path integrators. _bioRxiv_, pages 2022–11,
2022.

[61] Rylan Schaeffer, Mikail Khona, and Ila Fiete. No free lunch from deep learning in neuroscience:

A case study through models of the entorhinal-hippocampal circuit. _Advances_ _in_ _neural_
_information processing systems_, 35:16052–16067, 2022.

[62] M. GUARDAMAGNA, E. HERMANSE, J. CARPENTER, C. LYKKEN, B. DUNN, E. I.

MOSER, and M.-B. MOSER. Experience-independent emergence of toroidal and ring manifolds
in the entorhinal cortex. _Neuroscience Meeting Planner. Chicago, IL. :_ _Society for Neuroscience,_
_2024. Online_, (PSTR190.07. 2024), 2024.

[63] Richard J Gardner, Erik Hermansen, Marius Pachitariu, Yoram Burak, Nils A Baas, Benjamin A

Dunn, May-Britt Moser, and Edvard I Moser. Toroidal topology of population activity in grid
cells. _Nature_, 602(7895):123–128, 2022.

[64] Jia Deng, Wei Dong, Richard Socher, Li-Jia Li, Kai Li, and Li Fei-Fei. Imagenet: A large
scale hierarchical image database. In _2009 IEEE conference on computer vision and pattern_
_recognition_, pages 248–255. Ieee, 2009.

14

**NeurIPS Paper Checklist**

1. **Claims**

Question: Do the main claims made in the abstract and introduction accurately reflect the
paper’s contributions and scope?

Answer: [Yes]

Justification: Our abstract and introduction accurately reflect the paper’s contributions and
scope.

Guidelines:

       - The answer NA means that the abstract and introduction do not include the claims
made in the paper.

       - The abstract and/or introduction should clearly state the claims made, including the
contributions made in the paper and important assumptions and limitations. A No or
NA answer to this question will not be perceived well by the reviewers.

       - The claims made should match theoretical and experimental results, and reflect how
much the results can be expected to generalize to other settings.

       - It is fine to include aspirational goals as motivation as long as it is clear that these goals
are not attained by the paper.

2. **Limitations**

Question: Does the paper discuss the limitations of the work performed by the authors?

Answer: [Yes]

Justification: See Section 6.

Guidelines:

       - The answer NA means that the paper has no limitation while the answer No means that
the paper has limitations, but those are not discussed in the paper.

       - The authors are encouraged to create a separate "Limitations" section in their paper.

       - The paper should point out any strong assumptions and how robust the results are to
violations of these assumptions (e.g., independence assumptions, noiseless settings,
model well-specification, asymptotic approximations only holding locally). The authors
should reflect on how these assumptions might be violated in practice and what the
implications would be.

       - The authors should reflect on the scope of the claims made, e.g., if the approach was
only tested on a few datasets or with a few runs. In general, empirical results often
depend on implicit assumptions, which should be articulated.

       - The authors should reflect on the factors that influence the performance of the approach.
For example, a facial recognition algorithm may perform poorly when image resolution
is low or images are taken in low lighting. Or a speech-to-text system might not be
used reliably to provide closed captions for online lectures because it fails to handle
technical jargon.

       - The authors should discuss the computational efficiency of the proposed algorithms
and how they scale with dataset size.

       - If applicable, the authors should discuss possible limitations of their approach to
address problems of privacy and fairness.

       - While the authors might fear that complete honesty about limitations might be used by
reviewers as grounds for rejection, a worse outcome might be that reviewers discover
limitations that aren’t acknowledged in the paper. The authors should use their best
judgment and recognize that individual actions in favor of transparency play an important role in developing norms that preserve the integrity of the community. Reviewers
will be specifically instructed to not penalize honesty concerning limitations.

3. **Theory assumptions and proofs**

Question: For each theoretical result, does the paper provide the full set of assumptions and
a complete (and correct) proof?

Answer: [Yes]

15

Justification: See Section3.

Guidelines:

    - The answer NA means that the paper does not include theoretical results.

    - All the theorems, formulas, and proofs in the paper should be numbered and crossreferenced.

    - All assumptions should be clearly stated or referenced in the statement of any theorems.

    - The proofs can either appear in the main paper or the supplemental material, but if
they appear in the supplemental material, the authors are encouraged to provide a short
proof sketch to provide intuition.

    - Inversely, any informal proof provided in the core of the paper should be complemented
by formal proofs provided in appendix or supplemental material.

    - Theorems and Lemmas that the proof relies upon should be properly referenced.

4. **Experimental result reproducibility**

Question: Does the paper fully disclose all the information needed to reproduce the main experimental results of the paper to the extent that it affects the main claims and/or conclusions
of the paper (regardless of whether the code and data are provided or not)?

Answer: [Yes]

Justification: See Section 5 and the code in supplementary material.

Guidelines:

    - The answer NA means that the paper does not include experiments.

    - If the paper includes experiments, a No answer to this question will not be perceived
well by the reviewers: Making the paper reproducible is important, regardless of
whether the code and data are provided or not.

    - If the contribution is a dataset and/or model, the authors should describe the steps taken
to make their results reproducible or verifiable.

    - Depending on the contribution, reproducibility can be accomplished in various ways.
For example, if the contribution is a novel architecture, describing the architecture fully
might suffice, or if the contribution is a specific model and empirical evaluation, it may
be necessary to either make it possible for others to replicate the model with the same
dataset, or provide access to the model. In general. releasing code and data is often
one good way to accomplish this, but reproducibility can also be provided via detailed
instructions for how to replicate the results, access to a hosted model (e.g., in the case
of a large language model), releasing of a model checkpoint, or other means that are
appropriate to the research performed.

    - While NeurIPS does not require releasing code, the conference does require all submissions to provide some reasonable avenue for reproducibility, which may depend on the
nature of the contribution. For example
(a) If the contribution is primarily a new algorithm, the paper should make it clear how

to reproduce that algorithm.
(b) If the contribution is primarily a new model architecture, the paper should describe

the architecture clearly and fully.
(c) If the contribution is a new model (e.g., a large language model), then there should

either be a way to access this model for reproducing the results or a way to reproduce
the model (e.g., with an open-source dataset or instructions for how to construct
the dataset).
(d) We recognize that reproducibility may be tricky in some cases, in which case

authors are welcome to describe the particular way they provide for reproducibility.
In the case of closed-source models, it may be that access to the model is limited in
some way (e.g., to registered users), but it should be possible for other researchers
to have some path to reproducing or verifying the results.

5. **Open access to data and code**

Question: Does the paper provide open access to the data and code, with sufficient instructions to faithfully reproduce the main experimental results, as described in supplemental
material?

16

Answer: [Yes]

Justification: We have included the code for reproducing the main results in supplementary
material.

Guidelines:

    - The answer NA means that paper does not include experiments requiring code.

    - Please see the NeurIPS code and data submission guidelines ( `[https://nips.cc/](https://nips.cc/public/guides/CodeSubmissionPolicy)`
`[public/guides/CodeSubmissionPolicy](https://nips.cc/public/guides/CodeSubmissionPolicy)` ) for more details.

    - While we encourage the release of code and data, we understand that this might not be
possible, so “No” is an acceptable answer. Papers cannot be rejected simply for not
including code, unless this is central to the contribution (e.g., for a new open-source
benchmark).

    - The instructions should contain the exact command and environment needed to run to
reproduce the results. See the NeurIPS code and data submission guidelines ( `[https:](https://nips.cc/public/guides/CodeSubmissionPolicy)`
`[//nips.cc/public/guides/CodeSubmissionPolicy](https://nips.cc/public/guides/CodeSubmissionPolicy)` ) for more details.

    - The authors should provide instructions on data access and preparation, including how
to access the raw data, preprocessed data, intermediate data, and generated data, etc.

    - The authors should provide scripts to reproduce all experimental results for the new
proposed method and baselines. If only a subset of experiments are reproducible, they
should state which ones are omitted from the script and why.

    - At submission time, to preserve anonymity, the authors should release anonymized
versions (if applicable).

    - Providing as much information as possible in supplemental material (appended to the
paper) is recommended, but including URLs to data and code is permitted.

6. **Experimental setting/details**

Question: Does the paper specify all the training and test details (e.g., data splits, hyperparameters, how they were chosen, type of optimizer, etc.) necessary to understand the
results?

Answer: [Yes]

Justification: See Section 5.

    - The answer NA means that the paper does not include experiments.

    - The experimental setting should be presented in the core of the paper to a level of detail
that is necessary to appreciate the results and make sense of them.

    - The full details can be provided either with the code, in appendix, or as supplemental
material.

7. **Experiment statistical significance**

Question: Does the paper report error bars suitably and correctly defined or other appropriate
information about the statistical significance of the experiments?

Answer: [Yes]

Justification: We used fid and PSNR to evaluate our work.

Guidelines:

    - The answer NA means that the paper does not include experiments.

    - The authors should answer "Yes" if the results are accompanied by error bars, confidence intervals, or statistical significance tests, at least for the experiments that support
the main claims of the paper.

    - The factors of variability that the error bars are capturing should be clearly stated (for
example, train/test split, initialization, random drawing of some parameter, or overall
run with given experimental conditions).

    - The method for calculating the error bars should be explained (closed form formula,
call to a library function, bootstrap, etc.)

    - The assumptions made should be given (e.g., Normally distributed errors).

    - It should be clear whether the error bar is the standard deviation or the standard error
of the mean.

17

    - It is OK to report 1-sigma error bars, but one should state it. The authors should
preferably report a 2-sigma error bar than state that they have a 96% CI, if the hypothesis
of Normality of errors is not verified.

    - For asymmetric distributions, the authors should be careful not to show in tables or
figures symmetric error bars that would yield results that are out of range (e.g. negative
error rates).

    - If error bars are reported in tables or plots, The authors should explain in the text how
they were calculated and reference the corresponding figures or tables in the text.

8. **Experiments compute resources**

Question: For each experiment, does the paper provide sufficient information on the computer resources (type of compute workers, memory, time of execution) needed to reproduce
the experiments?

Answer: [Yes]

Justification: See Section B

Guidelines:

    - The answer NA means that the paper does not include experiments.

    - The paper should indicate the type of compute workers CPU or GPU, internal cluster,
or cloud provider, including relevant memory and storage.

    - The paper should provide the amount of compute required for each of the individual
experimental runs as well as estimate the total compute.

    - The paper should disclose whether the full research project required more compute
than the experiments reported in the paper (e.g., preliminary or failed experiments that
didn’t make it into the paper).

9. **Code of ethics**

Question: Does the research conducted in the paper conform, in every respect, with the
NeurIPS Code of Ethics `[https://neurips.cc/public/EthicsGuidelines](https://neurips.cc/public/EthicsGuidelines)` ?

Answer: [Yes]

Justification: Our work conform with the NeurIPS Code of Ethics.

Guidelines:

    - The answer NA means that the authors have not reviewed the NeurIPS Code of Ethics.

    - If the authors answer No, they should explain the special circumstances that require a
deviation from the Code of Ethics.

    - The authors should make sure to preserve anonymity (e.g., if there is a special consideration due to laws or regulations in their jurisdiction).

10. **Broader impacts**

Question: Does the paper discuss both potential positive societal impacts and negative
societal impacts of the work performed?

Answer: [NA]

Justification: There is no societal impact of the work performed.

Guidelines:

    - The answer NA means that there is no societal impact of the work performed.

    - If the authors answer NA or No, they should explain why their work has no societal
impact or why the paper does not address societal impact.

    - Examples of negative societal impacts include potential malicious or unintended uses
(e.g., disinformation, generating fake profiles, surveillance), fairness considerations
(e.g., deployment of technologies that could make decisions that unfairly impact specific
groups), privacy considerations, and security considerations.

    - The conference expects that many papers will be foundational research and not tied
to particular applications, let alone deployments. However, if there is a direct path to
any negative applications, the authors should point it out. For example, it is legitimate
to point out that an improvement in the quality of generative models could be used to

18

generate deepfakes for disinformation. On the other hand, it is not needed to point out
that a generic algorithm for optimizing neural networks could enable people to train
models that generate Deepfakes faster.

    - The authors should consider possible harms that could arise when the technology is
being used as intended and functioning correctly, harms that could arise when the
technology is being used as intended but gives incorrect results, and harms following
from (intentional or unintentional) misuse of the technology.

    - If there are negative societal impacts, the authors could also discuss possible mitigation
strategies (e.g., gated release of models, providing defenses in addition to attacks,
mechanisms for monitoring misuse, mechanisms to monitor how a system learns from
feedback over time, improving the efficiency and accessibility of ML).
