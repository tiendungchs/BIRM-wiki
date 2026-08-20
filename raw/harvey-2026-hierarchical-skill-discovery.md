# harvey-unsupervised-hierarchical-skill-discovery-2026

> Converted from `harvey-unsupervised-hierarchical-skill-discovery-2026.pdf` on 2026-08-18 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

## **Unsupervised Hierarchical Skill Discovery**

**Damion Harvey** <sup>1</sup> **Geraud Nangue Tasse** <sup>1 2</sup> **Benjamin Rosman** <sup>1 2</sup> **Branden Ingram** <sup>1 2</sup> **Steven James** <sup>1 2</sup>

**Abstract**

We consider the problem of unsupervised skill segmentation and hierarchical structure discovery in
reinforcement learning. While recent approaches
have sought to segment trajectories into reusable
skills or options, most rely on action labels, rewards, or handcrafted annotations, limiting their
applicability. We propose a method that segments
unlabelled trajectories into skills and induces a
hierarchical structure over them using a grammarbased approach. The resulting hierarchy captures
both low-level behaviours and their composition
into higher-level skills. We evaluate our approach
in high-dimensional, pixel-based environments,
including Craftax and the full, unmodified version
of Minecraft. Using metrics for skill segmentation, reuse, and hierarchy quality, we find that our
method consistently produces more structured and
semantically meaningful hierarchies than existing
baselines. Furthermore, as a proof of concept,
we demonstrate that these discovered hierarchies
accelerate and stabilise learning on downstream
reinforcement learning tasks.

**1. Introduction**

Human planning operates hierarchically, reasoning in terms
of goals and sub-tasks rather than primitive actions (Correa et al., 2025; Ho et al., 2019). Similarly, reinforcement
learning (RL) agents in high-dimensional environments like
Minecraft benefit from hierarchical decompositions to improve learning efficiency and policy reuse (Tessler et al.,
2017; Nachum et al., 2019). While manually defined hierarchies, such as Hierarchical Task Networks (HTNs) (Erol
et al., 1994), are effective, they demand significant human
effort and domain expertise to create (Chen et al., 2021).

1University of the Witwatersrand, Johannesburg, South
Africa <sup>2</sup> Machine Intelligence and Neural Discovery (MIND)
Institute, University of the Witwatersrand, Johannesburg, South Africa. Correspondence to: Damion Harvey
_<_ damion.harvey1@students.wits.ac.za _>_ .

_Proceedings_ _of_ _the_ _43_ <sup>_rd_</sup> _International_ _Conference_ _on_ _Machine_
_Learning_, Seoul, South Korea. PMLR 306, 2026. Copyright 2026
by the author(s).

_Figure 1._ Example of HiSD applied to a Minecraft trajectory. **Step**
**1** : HiSD segments the observational trajectory into distinct skills,
such as get wood, craft tools, and gather stone. **Step** **2** : Using
these segmented trajectories, HiSD applies a grammar-based compression algorithm to induce a hierarchy over the discovered skills,
revealing reusable subroutines and their temporal organisation.

An alternative is learning structure directly from data. Prior
approaches explore this via reward signals or action supervision (Ranchod et al., 2015; Kipf et al., 2019); however, these
methods rely on strong assumptions, such as access to action
labels or known skill orderings, and typically produce flat
segmentations rather than deep, compositional hierarchies.

We propose Hierarchical Skill Discovery (HiSD), a fully
unsupervised framework for extracting reusable, multi-level
skill hierarchies purely from observational data. Crucially,
HiSD decouples structure discovery from policy execution:
unlike baselines that require actions during discovery (Lu
et al., 2021; Kipf et al., 2019), HiSD operates on observations only, enabling scalability to abundant unlabelled video
data (Baker et al., 2022). Our method combines temporal
action segmentation (TAS) to identify latent skills based
on visual coherence, and grammar-based sequence compression to induce structured hierarchies over them. An
overview of this method is pictured in Figure 1.

We evaluate HiSD on Craftax (Matthews et al., 2024) and
Minecraft (Baker et al., 2022), two domains requiring complex sequential decision-making. Across these domains,
HiSD delivers the strongest overall performance among the
compared methods, producing accurate skill segmentations
and more coherent multi-level hierarchies with fewer assumptions. Our contributions are: (1) a method integrating
TAS and grammar induction for unsupervised structure dis

1

**<u>Unsupervised Hierarchical Skill Discovery</u>**

covery; (2) an observational feature-only pipeline suitable
for unlabelled demonstrations; (3) empirical validation of
superior segmentation quality and abstraction depth; and
(4) a proof of concept demonstrating the utility of these
representations in accelerating downstream reinforcement
learning. <sup>1</sup>

**2. Background**

**2.1. Skill Segmentation and Identification**

Temporal action segmentation aims to partition a continuous observation sequence _T_ = ( _X_ 1 _, . . ., Xn_ ) into _M_ temporally contiguous segments, where _X_ _∈_ R <sup>_d_</sup> is a feature
vector, and _n_ is the length of the sequence, assigning each
a discrete skill label _zt_ _∈{_ 1 _, . . ., K}_ . Here _K_ represents
the maximum number of skills in the dataset. In the unsupervised setting, neither the ground truth labels nor the
boundaries are known.

Recent state-of-the-art approaches formulate this as an optimal transport problem. Specifically, ASOT (Xu & Gould,
2024) relaxes the segmentation into a soft assignment problem. Let _C_ _∈_ R <sup>_n×K_</sup> be a cost matrix whose entry _Ctk_
encodes the visual dissimilarity between observation feature
_Xt_ and the _k_ -th latent skill prototype. ASOT solves for an
assignment plan Γ _∈_ R <sup>_n_</sup> + <sup>_×K_</sup> by minimising a regularised

objective:

min _⟨C,_ Γ _⟩_ + _αR_ temp(Γ) + _λD_ KL(Γ <sup>_⊤_</sup> **1** _n ∥_ _q_ ) _,_ (1)

Γ

where _α_ _∈_ [0 _,_ 1] weights the temporal regularity term
against the visual matching cost, _λ >_ 0 controls the strength
of the aggregate-skill marginal penalty, **1** _n_ _∈_ R <sup>_n_</sup> is the allones vector (so that Γ <sup>_⊤_</sup> **1** _n_ is the column-marginal of Γ, i.e.
the aggregate distribution over skills induced by the assignment), and _q_ _∈_ ∆ _K_ is a target prior (typically uniform) over
the _K_ latent skills.

The temporal regularity term _R_ temp is realised as a GromovWasserstein (GW) component comparing two intra-space
cost matrices: a frame-side matrix _C_ <sup>_v_</sup> _∈_ R <sup>_n×n_</sup> encoding
temporal proximity, and a skill-side matrix _C_ <sup>_a_</sup> _∈_ R <sup>_K×K_</sup>

encoding skill identity. With radius parameter _r_ _∈_ [0 _,_ 1],
these are defined element-wise as

_Cik_ <sup>_v_</sup> <sup>=</sup>

1 _/r,_ 1 _≤|i −_ _k| ≤_ _nr_
_,_ _Cjl_ <sup>_a_</sup> <sup>=</sup> <sup>**1**</sup> <sup>[</sup> <sup>_j̸_</sup> <sup>=</sup> <sup>_l_</sup> <sup>]</sup> <sup>_,_</sup> <sup>(2)</sup>
0 _,_ otherwise

and combined under the quadratic GW loss _L_ ( _a, b_ ) = _ab_ to
yield

_jl_

Intuitively, _R_ temp penalises assignments in which two
frames within _nr_ steps of each other are mapped to different
skills, while imposing no penalty on transitions outside this
temporal radius, nor on adjacent frames mapped to the same
skill. The radius _r_ therefore directly controls the minimum
expected segment length, enforcing local smoothness and
preventing rapid flickering of labels.

This formulation utilises unbalanced optimal transport,
which allows the algorithm to handle missing and repeated
skills. It does not force every latent skill prototype to appear
in every episode, nor does it enforce a specific sequential
ordering. Furthermore, the KL-divergence term ( _D_ KL) acts
as a soft constraint on the aggregate skill distribution. This
enables the model to handle unbalanced datasets, where
certain skills dominate the dataset while critical interaction
skills appear only briefly, a characteristic of the datasets
used in this work (Xu & Gould, 2024).

**2.2. Grammar Sequence Compression**

To represent hierarchical structure, we employ the formalism of context-free grammars (CFGs). A CFG is defined
as a tuple _G_ = ( _N_ _,_ Σ _, P, S_ 0), where Σ is a set of terminal
symbols (atomic units), _N_ is a set of non-terminal symbols
(abstract variables), _P_ is a set of production rules replacing
non-terminals with sequences of symbols, and _S_ 0 is the
distinct start symbol.

A prominent method for grammar induction is Sequitur
(Nevill-Manning & Witten, 1997), a linear-time algorithm
capable of inferring hierarchical structure from data. Sequitur operates on a single discrete input string of terminal
symbols in Σ, and incrementally builds a hierarchy to compress it. It maintains two invariants: **(1) Digram Unique-**
**ness:** No pair of adjacent symbols appears more than once
in the grammar. If a repetition is found, a new non-terminal
rule is created to replace it. **(2)** **Rule** **Utility:** Every rule
must be used at least twice. Rules used only once are removed and their contents expanded. Sequitur processes the
input string deterministically, producing a grammar where
the start symbol _S_ 0 expands to exactly reproduce the original
input string. The resulting derivation tree forms a hierarchy:
the root is the full trajectory, internal nodes are discovered
non-terminal subroutines, and leaves are the atomic terminal skills. This is because non-terminals can consist of
both other non-terminals and terminals, allowing a recursive
structure.

**3. Related Work**

Long-horizon decision-making benefits from temporal abstraction and skill reuse, which allow agents to operate
at multiple levels of planning (Correa et al., 2025; Sutton
et al., 1999; Solway et al., 2014). We focus on the offline,

_R_ temp(Γ) =

_i,k∈_ [ _n_ ]
_j,l∈_ [ _K_ ]

- _Cik_ <sup>_v_</sup>

_L_

_ik_ <sup>_v_</sup> <sup>_,_</sup> <sup>_C_</sup> _jl_ <sup>_a_</sup>

- Γ _ij_ Γ _kl._ (3)

1All code used is available on our GitHub [Repository.](https://github.com/dami2106/Unsupervised-Hierarchical-Skill-Discovery)

2

**<u>Unsupervised Hierarchical Skill Discovery</u>**

observation-only setting, where trajectories contain state
features but no actions, rewards, or prior segmentation (Lu
et al., 2021).

**3.1. Skill Segmentation and Discovery**

Skill segmentation typically assumes access to state-action
trajectories or rewards (Ranchod et al., 2015; Kipf et al.,
2019). Approaches such as Compositional Imitation Learning and Execution (CompILE) (Kipf et al., 2019) and
Option-Critic (Bacon et al., 2017) segment demonstrations
into latent skills or options to accelerate RL. However, these
methods generally rely on action supervision. CompILE, in
particular, suffers from producing location-centric, redundant skills and necessitates prior knowledge of the average
length per skill per trajectory (and the number of segments).
Similarly, Bayesian methods like Nonparametric Bayesian
Reward Segmentation (NPBRS) (Ranchod et al., 2015) are
capable of inferring the number of skills from data but typically require heavy supervision, such as explicit rewards,
action labels, and environment interaction.

Other approaches, including spectral or change-point methods (Zhu et al., 2022; Konidaris et al., 2012) and online
unsupervised methods (Eysenbach et al., 2019), typically require active environment interaction. More recent work such
as SloTTAr (Gopalakrishnan et al., 2023) extends CompILE
and the Ordered Memory Policy Network (OMPN) (Lu
et al., 2021) with slot-based transformers to handle variable
subroutine counts. However, it still operates on state-action
trajectories to reconstruct action sequences and produces
flat segmentations rather than multi-level hierarchies. In
contrast, we discover skills from pre-collected observations
without access to actions, rewards, or interaction.

**3.2. Learning Multi-level Hierarchies from**
**Demonstration**

Several methods aim to learn multi-level task hierarchies,
commonly formalised as HTNs (Erol et al., 1994). These
approaches can be broadly divided into those that rely on
structured symbolic input and those that operate under weak
supervision. Structured-input methods assume substantial
prior knowledge in the form of annotated plans, logical
schemas, or explicit skill decompositions. For example,
HTN-Maker (Hogg et al., 2008), Circuit-HTN (Chen et al.,
2021), and CurricuLAMA (Nejati et al., 2006) induce hierarchical structures from heavily annotated data, requiring
domain expertise to label and segment tasks, as well as
access to correct skill sequencing.

In contrast, weakly supervised approaches attempt to infer
hierarchical structure directly from demonstrations using
some form of labels. Clique-Chain HTN (Hayes & Scassellati, 2016) and OMPN learn hierarchical structure from
demonstrations; however, OMPN still depends on action

labels, known skill orderings at inference time, and a predefined hierarchy depth. Grammar-based methods (Lange
& Faisal, 2019) similarly extract hierarchical macro-actions
from sequences of primitive actions.

**4. Hierarchical Skill Discovery**

The fundamental challenge in learning from demonstration
lies in parsing continuous, unlabelled observation streams
into distinct, reusable behavioural units. While this objective is shared by prior frameworks such as NPBRS (Ranchod
et al., 2015), CompILE (Kipf et al., 2019), and OMPN (Lu
et al., 2021), we seek to achieve this without relying on action labels, reward signals or online interaction. To this end,
we propose Hierarchical Skill Discovery, a framework to
extract reusable, multi-level skill hierarchies directly from
raw observational features. Our method bridges the gap
between low-level continuous control and symbolic planning by treating skill discovery as a two-stage process: (1)
_Segmentation_, which discretises continuous dynamics into
atomic behavioural units, and (2) _Structure Induction_, which
compresses these units into a compositional grammar. This
framework is presented in Figure 2.

**4.1. Unsupervised Skill Identification**

Given a dataset of _N_ unlabelled observation trajectories
_{T_ <sup>(1)</sup> _, . . ., T_ <sup>(</sup> <sup>_N_</sup> <sup>)</sup> _}_, we first aim to convert continuous features into discrete skill sequences, as seen in Figure 2a. The
grammar-induction stage in Section 4.2 operates on any
sequence of discrete skill indices and is therefore fully decoupled from the choice of segmentation algorithm; HiSD
is compatible with any TAS method that produces such labels. For our experiments, we instantiate this stage using the
ASOT framework described in Section 2.1. We treat the entire dataset of trajectories as a batch. For a given trajectory
_T_ <sup>(</sup> <sup>_i_</sup> <sup>)</sup> of feature embeddings _X_ <sup>(</sup> <sup>_i_</sup> <sup>)</sup>, we compute the optimal
transport plan Γ <sup>_∗_</sup> by solving Equation 1. We obtain framelevel discrete skill indices _z_ 1: <sup>(</sup> <sup>_i_</sup> _n_ <sup>)</sup> <sup>, with</sup> <sup>_z_</sup> _t_ <sup>(</sup> <sup>_i_</sup> <sup>)</sup> _∈{_ 1 _, . . ., K}_, via

**4.2. Symbolic Abstraction and Grammar Induction**

Once segmented, we abstract the data to identify higherlevel composition. This involves two steps: corpus construction and hierarchy induction.

We collapse contiguous frames (steps) sharing the same
label into single atomic symbols. A trajectory _z_ 1: <sup>(</sup> <sup>_i_</sup> _n_ <sup>)</sup> <sup>is</sup> <sup>re-</sup>

level discrete skill indices _z_ 1: <sup>(</sup> <sup>_i_</sup> _n_ <sup>)</sup> <sup>, with</sup> <sup>_z_</sup> _t_ <sup>(</sup> <sup>_i_</sup> <sup>)</sup> _∈{_ 1 _, . . ., K}_, via

a hardening step _zt_ <sup>(</sup> <sup>_i_</sup> <sup>)</sup> = arg max _k∈{_ 1 _,...,K}_ Γ <sup>_∗_</sup> _tk_ <sup>.</sup> <sup>These are</sup>

integer indices representing the discovered skills. Crucially,
unlike clustering methods that ignore time, this approach
enforces temporal consistency, ensuring that _z_ remains constant over coherent segments of behaviour. This effectively
transforms the continuous trajectory _T_ <sup>(</sup> <sup>_i_</sup> <sup>)</sup> into a sequence of
skill segments, visible in Figures 2b and 2c.

_t_ <sup>(</sup> <sup>_i_</sup> <sup>)</sup> = arg max _k∈{_ 1 _,...,K}_ Γ <sup>_∗_</sup> _tk_

3

**<u>Unsupervised Hierarchical Skill Discovery</u>**

|Col1|TAS|Col3|
|---|---|---|
||_TAS_||

|Col1|Col2|Sequence<br>Compression|Col4|H1<br>N1 N2<br>a b c d|
|---|---|---|---|---|
||||||
||||||

_Figure 2._ Overview of the HiSD pipeline. Demonstration trajecto
ries are first segmented into skills. These skill sequences are then
compressed and structured using a modified Sequitur algorithm,
which identifies recurring mid-level subroutines across the dataset.
The resulting grammar defines a hierarchical task decomposition.

duced to a sequence _S_ <sup>(</sup> <sup>_i_</sup> <sup>)</sup> = ( _α_ 1 _, α_ 2 _, . . ., αmi_ ), where each
_αj_ _∈_ Σ is a terminal symbol corresponding to one of the
_K_ discovered skills. This removes the variance of duration, allowing the model to focus purely on the structural
sequencing of skills.

Standard grammar induction operates on a single sequence.
To learn subroutines that generalise across episodes, we construct a unified corpus _Scorp_ by concatenating all episode
sequences separated by a unique boundary token _ϕ_ : _Scorp_ =
_S_ <sup>(1)</sup> _⊕_ _ϕ ⊕_ _S_ <sup>(2)</sup> _⊕· · · ⊕_ _ϕ ⊕_ _S_ <sup>(</sup> <sup>_N_</sup> <sup>)</sup> . We run the Sequitur
algorithm on _Scorp_ . We explicitly modify the induction
constraints to forbid the boundary token _ϕ_ from being included in any production rule. This ensures that learned
non-terminals capture behaviours internal to episodes, preventing the grammar from merging the end of one episode
with the start of another. This is shown in Figure 2d.

The result is a global grammar _G_ where terminal nodes
correspond to the atomic skills found in Stage 1 (Figure 2c),
and internal nodes represent discovered subroutines (such
as “Collect Wood” + “Make Workbench”). By parsing an
episode _S_ <sup>(</sup> <sup>_i_</sup> <sup>)</sup> using _G_, we generate a hierarchical tree _τ_ <sup>(</sup> <sup>_i_</sup> <sup>)</sup>

that decomposes the task into its constituent sub-goals. This
final hierarchy is evident in Figure 2e.

**5. Experiments and Domains**

Our experiments evaluate the ability of HiSD to discover
reusable skills and compositional structure in both fully
observable (Craftax) and partially observable (Minecraft)
domains. These environments present long-horizon challenges well-suited for analysing hierarchical reuse. To ensure baselines are evaluated under their most favourable
conditions, we provide CompILE and OMPN with ground
truth sub-task orderings, and we standardise the setting by
providing the maximum number of skills, _K_, to all models.
Beyond this, the methods differ substantially in the supervision they require: CompILE additionally requires action
labels and the number of segments per trajectory, OMPN
requires action labels and the depth of the hierarchy, while

HiSD operates without these supervisory signals (requiring
only _K_ ). Table 1 summarises this asymmetry.

**Method** **Actions** <sup>**Sub-task**</sup> **_K_** **Other**

**Order**

**HiSD (Ours)** - - ✓ CompILE ✓ ✓ ✓ segments per trajectory
OMPN ✓ ✓ ✓ hierarchy depth

_Table_ _1._ Supervision required by each method during
skill/hierarchy discovery. All methods receive the maximum number of skills _K_ . HiSD requires no further supervision, whereas
baselines additionally require action labels, ground truth subtask orderings, and structural priors (segment counts or hierarchy
depth).

In this work, we refer to “ground truth” labels not as universal truths, but as algorithmic annotations derived from
domain knowledge. For both environments, we construct
these labels programmatically by monitoring game state
changes (specifically inventory deltas and interaction logs)
to assign skill labels to trajectory segments. For Craftax and
Minecraft (Matthews et al., 2024; Baker et al., 2022), the approximate number of distinct skills can be inferred from the
game’s compositional structure: each distinct event, such as
gathering a resource, crafting an item, or placing a block,
corresponds to an individual skill.

**5.1. Craftax Environment**

Craftax (Matthews et al., 2024) is a 2D top-down environment inspired by Minecraft, where agents gather resources,
craft tools, and complete long-horizon survival-themed tasks
in a procedurally generated world. We modify the environment to make it fully observable and deterministic, yielding
a Markovian environment where the agent can observe the
full state at every timestep. Our modified Craftax environment provides a rendered 274 _×_ 274 _×_ 3 RGB image of the
top-down view of the game. The action space is reduced
from the original game, and consists of 4 cardinal movements and 12 non-movement actions covering interaction,
placement, and crafting. We generate a variety of tasks in
the Craftax domain, each described in detail below. For each
task there is a “static” and a “random” configuration: “static”
configurations are those where skills always occur in the
same order, while “random” configurations have variation in
the skill sequencing between episodes. Each task instance
includes a randomly generated world layout and a handcrafted goal. For a visual example and full discussion of the
modified environment, refer to Appendix A.1. We generate
500 expert trajectories per task configuration using an _A_ <sup>_∗_</sup>

planner guided by domain-specific heuristics. This setting
allows us to evaluate whether HiSD can extract consistent
skills and meaningful subroutines across diverse episodic
expert demonstrations. We implement the following tasks:

4

**<u>Unsupervised Hierarchical Skill Discovery</u>**

  - **Stone Pickaxe (Static and Random)** : Requires collecting wood, building a workbench, making a wooden
pickaxe, then collecting stone to craft a stone pickaxe. We evaluate both fixed and stochastic sub-task
orderings. There are 5 unique skills here.

  - **Wood-Stone Collection (Random)** : Involves gathering wood and stone without tool requirements. In this
configuration, we collect wood and stone, twice each,
in any order. This consists of 2 unique skills.

  - **Mixed Task (Static)** : A set of 6 goal types, each requiring a different sequence of skills such as collecting wood, crafting a wooden pickaxe, gathering stone,
or building a stone sword. In total, the dataset has 5
unique skills with varying orderings across trajectories.

To obtain compact feature representations from the raw
pixel observations, we employ principal component analysis
(PCA) (Pearson, 1901; Hotelling, 1933). We fit a separate
PCA model for each task using the aggregated dataset of
all observation frames, retaining 650 components to capture
approximately 99% of the total variance.

**5.2. Minecraft Environment**

To evaluate HiSD in a highly realistic and challenging setting, we turn to the full, unmodified version of Minecraft
(Guss et al., 2019; Baker et al., 2022), which presents a partially observable, long-horizon environment with complex
low-level controls. Unlike prior work that uses simplified
versions of Minecraft where crafting is treated as a discrete
action (Kanervisto et al., 2020), we use the native game interface without changes. This requires the agent to interact
via raw keyboard and mouse inputs. The agents operate using only raw pixel observations of size 640 _×_ 360 and issue
low-level control actions. Rather than relying on human
expert data, we collect successful trajectories using OpenAI’s pre-trained VPT (Video PreTraining) models (Baker
et al., 2022). We generate 500 episodes where the agent
collects two stone blocks. Unlike the A* planner in Craftax,
the VPT policy is not optimal; the resulting demonstrations
are noisy and exhibit human-like sub-optimality, including
redundant actions and wandering. This provides a test of
HiSD’s ability to extract structure from imperfect data in
partially observable domains.

We construct our dataset by halting the agent once it has
collected two blocks of stone. Ground truth annotations
are extracted algorithmically by cross-referencing inventory
deltas with interaction logs (such as block interaction and
destruction events) to map frames to specific skills. Visual features are extracted from first-person observations
using MineCLIP (Fan et al., 2022), which produces 512dimensional CLIP-like embeddings. From this data, we

curate two skill-labelled datasets: (1) an _All_ dataset containing 44 skills, and (2) a _Mapped_ dataset with 14 high-level
categories grouping semantically similar skills. For a visual
example, refer to Appendix A; for implementation details
regarding the skills and ground truth, refer to Appendix A.2.

**5.3. Skill Metrics**

We evaluate segmentation using three standard TAS metrics:
**Mean-over-Frames** **(MoF)**, measuring frame-wise accuracy but sensitive to class imbalance; **F1 Score**, a segmentlevel metric (overlap _>_ 50%) less biased toward frequent
classes; and **mean Intersection-over-Union (mIoU)**, which
robustly handles imbalance by strictly penalising over- and
under-segmentation. We compute these under two matching schemes: _Per_ (local alignment per episode) and _Full_
(global Hungarian alignment). We prioritise _Full_ mIoU to
assess globally reusable skills, contrasting with baselines
like CompILE and OMPN that report strict boundary-based
F1 scores ( _±_ 1 timestep) focused only on local segmentation
quality. We adopt standard TAS (IoU-based) metrics as
they are more robust to temporal noise and provide deeper
insight into the semantic, cross-episode consistency of the
discovered skills (Xu & Gould, 2024; Lea et al., 2017; Lu
et al., 2021; Kipf et al., 2019).

**5.4. Hierarchy Metrics**

To assess structural quality and reuse, we compute tree-level
metrics averaged over the dataset and compare them relative to the ground truth structure (generated by running
our modified Sequitur on clean ground truth labels). We
report: (1) **Unique** **Trees**, where a lower count indicates
consistent, reusable decomposition across episodes; (2) **Av-**
**erage Depth**, measuring the level of temporal abstraction
to detect under- or over-decomposition; (3) **Average Size**
(total nodes), evaluating representational parsimony relative
to the task’s logical complexity; and (4) **Branching Factors**
(mean/max children per node), reflecting the granularity of
the decomposition, where high branching suggests a lack of
intermediate subroutines.

**6. Results and Discussion**

This section presents our experimental evaluation across
both the Craftax and Minecraft domains. We analyse performance in two stages: first, we assess the _skill segmentation_
capabilities of each framework using standard quantitative
metrics, supplemented by qualitative visualisations. Second, we evaluate the _structural_ _quality_ of the hierarchies
induced by OMPN and HiSD using tree-level metrics and
representative visual outputs.

To ensure a rigorous comparison, we conduct an extensive
hyperparameter sweep for all methods; the search ranges

5

**<u>Unsupervised Hierarchical Skill Discovery</u>**

and final selected parameters are detailed in Appendix E.
While the quantitative results in Table 2 report averages over
5 random seeds, the qualitative hierarchy analysis utilises
the single best-performing run for each framework (selected
via mIoU) to illustrate peak representational capacity.

Due to space constraints, we present a curated subset of
visualisations in this section; the complete catalogue of discovered skills and hierarchies is available in Appendix D,
alongside a computational resource analysis in Appendix B.
Finally, we examine the sensitivity of our method to the
skill budget, _K_, in Appendix D. Our results indicate that
while the performance of HiSD is maximised when _K_
aligns with the ground truth, the framework is robust to
mis-specification; particularly in cases of over-estimation,
we observe that performance degrades gracefully rather than
suffering catastrophic collapse.

**6.1. Craftax Results**

6.1.1. SKILLS

Table 2 presents the skill metrics discussed above. On the
simpler WSWS Random task, we see that both baselines
perform relatively well in comparison to HiSD. However,
as task complexity increases (both in length and number
of skills), HiSD outperforms the baselines. In the Stone
Pickaxe Static task, which remains relatively simple, both
OMPN (Lu et al., 2021) and CompILE (Kipf et al., 2019)
struggle to achieve 50% Avg. mIoU. HiSD’s advantage
is also evident in Figure 3: in this evaluation, both baselines were supplied with the ground truth sub-task order at
inference time, yet they still fail to accurately detect skill
boundaries; CompILE, in particular, omits some skills entirely. Qualitatively, we observe that HiSD learns to group
perceptually distinct but semantically equivalent behaviours
into a single skill cluster. For example, in Craftax and
Minecraft, visually distinct approaches to the same object
(such as collecting wood from different directions or angles)
are consistently assigned to the same skill cluster. For a
visual example of this, refer to Appendix D.2.

6.1.2. HIERARCHY

Table 3 presents the results for the tree metrics. Ideally, the
learned hierarchies should reflect task complexity through
appropriate depth, generate consistent structures across similar episodes, and adaptively vary where skill sequencing
differs. The number of unique trees should also align closely
with the ground truth. This holds for HiSD on the simplest
tasks; for example, in WSWS Random it matches the ground
truth exactly (9 unique trees). In contrast, OMPN produces
a different hierarchy for nearly every episode, showing no
structural consistency. Its hierarchies are also larger in size
than those from HiSD, despite having similar depth, suggesting excessive branching at each level.

<u>Stone Pickaxe : Static</u>

Truth

HiSD

OMPN

CmpILE

_Figure_ _3._ Example of the skill segmentation performance in
the Stone Pickaxe Static Task in Craftax for all three baselines.
Colours indicate discovered skills: wood, table, wooden pickaxe,
stone, and stone pickaxe.

<u>Minecraft Collect Stone (Mapped)</u>

Truth

HiSD

OMPN

CmpILE

_Figure 4._ Example of the skill segmentation performance in the

Minecraft Mapped Task for all three approaches. Colours indicate
discovered skills: Walk, Mine Log, Craft Planks, Craft Table, Craft
Stick, Use Table, Craft Wooden Pickaxe, Mine Table, Mine Grass,
Mine Dirt, and Mine Stone.

**6.2. Minecraft Results**

We now present the same analysis in the Minecraft domain.
To enable OMPN and CompILE to operate in this setting,
we modify the dataset due to their reliance on discrete action
representations during training. Specifically, we discretise
the action space by collecting the unique set of all actions
observed in the original dataset. This results in 2385 unique
integer actions for the domain. By contrast, HiSD does
not require any action information and therefore operates
directly on observational trajectories.

6.2.1. SKILLS

Referring again to Table 2, HiSD outperforms both baselines.
This is a particularly strict test of observation-only segmentation: in Minecraft, walking transitions account for roughly
6% of frames, and walking-toward-wood is visually indistinguishable from walking-toward-stone in first-person view,
yet the two correspond to different goals. Despite this perceptual aliasing, HiSD’s temporal consistency prior allows
it to assign these segments coherently based on surrounding context. In the “All” setting, it achieves significantly
higher mIoU, indicating more accurate skill segmentation
and identification despite the class imbalance inherent to
the Minecraft environment. A qualitative example of the
segmentation on the Mapped task is shown in Figure 4.

6

**<u>Unsupervised Hierarchical Skill Discovery</u>**

**Task** **Framework** **Avg.** **mIoU** **F1 Per** **F1 Full** **mIoU Per** **mIoU Full** **MoF Per** **MoF Full**

**Craftax**
WSWS
Random

**Craftax**
Stone Pickaxe
Static

**Craftax**
Stone Pickaxe
Random

**Craftax**
Mixed Static

**Minecraft**
All

**Minecraft**
Mapped

HiSD 63% ( _±_ 12) 88% ( _±_ 6) 74% ( _±_ 11) 68% ( _±_ 9) 58% ( _±_ 16) 79% ( _±_ 7) 73% ( _±_ 14)
OMPN 75% ( _±_ 12) 96% ( _±_ 8) 91% ( _±_ 9) 78% ( _±_ 12) 72% ( _±_ 11) 86% ( _±_ 8) 83% ( _±_ 8)
CompILE **76% (** _±_ **4)** **100% (** _±_ **0)** **94% (** _±_ **3)** **78% (** _±_ **4)** **74% (** _±_ **4)** **86% (** _±_ **3)** **85% (** _±_ **3)**

HiSD **66% (** _±_ **15)** **83% (** _±_ **12)** **82% (** _±_ **13)** **67% (** _±_ **13)** **65% (** _±_ **17)** **74% (** _±_ **7)** **72% (** _±_ **11)**
OMPN 30% ( _±_ 4) 65% ( _±_ 6) 56% ( _±_ 4) 35% ( _±_ 5) 26% ( _±_ 4) 59% ( _±_ 2) 49% ( _±_ 3)
CompILE 45% ( _±_ 18) 72% ( _±_ 17) 67% ( _±_ 20) 50% ( _±_ 17) 40% ( _±_ 18) 70% ( _±_ 14) 64% ( _±_ 16)

HiSD **59% (** _±_ **2)** **79% (** _±_ **2)** **74% (** _±_ **4)** **63% (** _±_ **1)** **56% (** _±_ **3)** **73% (** _±_ **1)** **69% (** _±_ **3)**
OMPN 27% ( _±_ 3) 57% ( _±_ 5) 44% ( _±_ 1) 32% ( _±_ 5) 21% ( _±_ 2) 60% ( _±_ 2) 48% ( _±_ 2)
CompILE 32% ( _±_ 7) 56% ( _±_ 8) 52% ( _±_ 4) 35% ( _±_ 10) 29% ( _±_ 3) 65% ( _±_ 6) 58% ( _±_ 3)

HiSD **62% (** _±_ **10)** **81% (** _±_ **6)** **47% (** _±_ **8)** **71% (** _±_ **10)** **53% (** _±_ **11)** 74% ( _±_ 3) 64% ( _±_ 5)
OMPN 49% ( _±_ 9) 77% ( _±_ 4) 36% ( _±_ 7) 64% ( _±_ 5) 34% ( _±_ 13) 80% ( _±_ 3) 63% ( _±_ 8)
CompILE 56% ( _±_ 8) 81% ( _±_ 7) 39% ( _±_ 6) 70% ( _±_ 8) 41% ( _±_ 8) **81% (** _±_ **5)** **65% (** _±_ **7)**

HiSD **31% (** _±_ **2)** **55% (** _±_ **5)** **18% (** _±_ **3)** **49% (** _±_ **3)** **12% (** _±_ **1)** 38% ( _±_ 2) **32% (** _±_ **3)**
OMPN 14% ( _±_ 6) 29% ( _±_ 14) 7% ( _±_ 3) 21% ( _±_ 10) 7% ( _±_ 3) **54% (** _±_ **10)** 29% ( _±_ 6)
CompILE 6% ( _±_ 3) 18% ( _±_ 6) 4% ( _±_ 1) 10% ( _±_ 5) 2% ( _±_ 1) 36% ( _±_ 5) 19% ( _±_ 5)

HiSD **38% (** _±_ **5)** **64% (** _±_ **6)** **53% (** _±_ **7)** **43% (** _±_ **6)** **33% (** _±_ **5)** 51% ( _±_ 4) **49% (** _±_ **4)**
OMPN 14% ( _±_ 6) 28% ( _±_ 13) 15% ( _±_ 6) 19% ( _±_ 9) 8% ( _±_ 4) **54% (** _±_ **10)** 29% ( _±_ 5)
CompILE 6% ( _±_ 1) 14% ( _±_ 2) 11% ( _±_ 2) 6% ( _±_ 1) 5% ( _±_ 2) 35% ( _±_ 4) 34% ( _±_ 3)

_Table 2._ Comparison of different skill segmentation approaches. Higher is better for all metrics. Each entry reports the mean performance

over five runs, with the corresponding 95% confidence interval (shown in parentheses). “Full” denotes global alignment across all
episodes, while “Per” denotes per-episode alignment. When comparing average mIoU, HiSD outperforms all baselines on most tasks,
particularly those with added stochasticity or longer horizons. Ties are broken by smaller error.

6.2.2. HIERARCHY

Evaluating the hierarchy shows the same trends as Craftax,
except now we see much larger trees discovered due to the
stochastic and noisy Minecraft environment. Looking at
the “All” task that employs all 44 skills, we see that both
HiSD and OMPN produce a unique tree per episode. In
this case, even the ground truth contains 293 unique trees,
showing the amount of noise present in the dataset. This is
mirrored by the size of the trees discovered, where the size
is inflated by the stochasticity of the environment, leading
to far more skills being identified than required. Ultimately,
inconsistencies in the initial skill segmentation stage, amplified by the environment’s complexity, produce highly
variable symbolic sequences that prevent our deterministic
grammar from discovering a consistent underlying structure.
However, this trend does not necessarily continue in the
“Mapped” task where there are fewer skills to reason with.

Here, while HiSD still produces a unique tree per episode,
the size and the branching factors of the trees are far reduced from the “All” task, which allows us to both visualise
and understand the structure of the tree when analysing it
qualitatively.

**7. Reinforcement Learning Deployment**

We demonstrate the utility of the discovered hierarchies in
downstream RL. While discovery is observation-only, we

assume action labels are available during the downstream
phase to ground symbolic skills into executable policies
via Behavioural Cloning (BC); alternatively, methods like
Behavioural Cloning from Observation (Torabi et al., 2018)
could infer actions from observations and online interaction.
This distinguishes our approach from baselines like OMPN
that do not natively support modular option transfer. We
formulate discovered skills as options (Sutton et al., 1999).
For each skill, we train a low-level policy _πi_ ( _a|s_ ) using BC
and learn initiation _Ii_ and termination _βi_ ( _s_ ) conditions via
positive-unlabelled (PU) classifiers (Elkan & Noto, 2008)
trained on the segmented observations. Intermediate hierarchy nodes function as composite options, executing child
nodes sequentially according to the induced grammar. A
high-level agent trained with Maskable Proximal Policy
Optimization (PPO) (Schulman et al., 2017) outputs a categorical distribution over these valid options at each timestep,
using the learned initiation sets as action masks. For full
implementation details, refer to Appendix C.

**7.1. Craftax Evaluation**

We evaluate agents on a new “Craft Wooden Pickaxe” task,
a sub-goal of the larger “Craft Stone Pickaxe” task involving
wood collection and crafting sequences for a sparse reward
of +1. We compare PPO agents using HiSD skills and
hierarchies against OMPN, CompILE, primitive-action PPO,
and pure imitation learning baselines.

7

**<u>Unsupervised Hierarchical Skill Discovery</u>**

**Task** **Framework** **Unique Trees** _↓_ **Depth** **Size** **Avg.** **Branching** **Max Branching**

**Craftax**
WSWS
Random

**Craftax**
Stone Pickaxe
Static

**Craftax**
Stone Pickaxe
Random

**Craftax**
Mixed
Static

**Minecraft**
All

**Minecraft**
Mapped

Truth 9 3.98 5.96 1.64 2.00
HiSD 9 3.21 4.70 1.54 2.00
OMPN 499 3.34 6.73 2.04 2.47

Truth 1 3.00 9.00 4.00 7.00
HiSD 36 6.02 13.44 1.85 2.00
OMPN 500 4.94 16.20 2.05 4.54

Truth 7 5.19 11.93 1.97 2.84
HiSD 47 5.49 12.84 1.86 2.03
OMPN 500 4.88 15.54 2.01 5.10

Truth 5 3.53 5.66 1.57 2.07
HiSD 13 4.31 8.14 1.59 1.81
OMPN 391 3.11 7.53 1.92 2.84

Truth 293 8.15 22.69 1.97 2.25
HiSD 500 8.48 283.25 2.21 28.73
OMPN 500 4.90 113.19 7.88 43.87

Truth 151 8.15 21.36 2.03 3.01
HiSD 500 8.52 83.85 2.08 5.40
OMPN 500 4.90 113.19 7.88 43.87

_Table 3._ A table showing the comparison between trees discovered by: ground truth, HiSD and OMPN. We see in general that HiSD

discovers a more consistent decomposition, while generally resulting in smaller, more interpretable trees.

Figure 5 shows mean episode rewards across ten random
seeds. The HiSD Hierarchy agent demonstrates superior
sample efficiency, reaching near-optimal rewards within
_∼_ 30k steps. Crucially, it outperforms the HiSD Skills-Only
agent, confirming that compositional structure provides a
necessary inductive bias for temporal credit assignment.

Craftax - Make Wooden Pickaxe

Reward vs Timesteps

1.00

0.75

0.50

0.25

0.00

Environment Timesteps

Hierarchy(Ground Truth)
Hierarchy(HiSD)
Hierarchy(OMPN)

Skills Only(HiSD)
Skills Only(CompILE)
Primitive Actions

_Figure_ _5._ Mean episode rewards (±1 SD) over environment
timesteps for 10 random seeds on the Craftax Wooden Pickaxe
task. The HiSD hierarchy (orange) achieves higher and more stable
performance than the OMPN hierarchy (green) and the Skills-Only
variants for both HiSD (pink) and CompILE (brown), while closely
matching the ground truth hierarchy (blue). Primitive action PPO
(cyan) fails to solve the task.

In contrast, the OMPN hierarchy struggles to converge,
likely due to excessive branching factors inflating the action space, and PPO using only primitive actions fails to
solve the task entirely. CompILE Skills-Only similarly underperforms the HiSD hierarchy, reaching roughly 0.7 reward. Standard imitation learning (not shown) also fails,
achieving 0 reward. We further investigate how many actionlabelled demonstrations are needed to deploy the discovered
structures: a sweep over _N_ _∈{_ 10 _,_ 20 _, . . .,_ 500 _}_ episodes
(Appendix C.3) shows that the HiSD hierarchy reaches
0 _._ 94 _±_ 0 _._ 08 mean reward by _N_ = 250 and matches the
GT hierarchy from _N_ = 350 onward, with the segmentation stage itself remaining fully unsupervised throughout.
This indicates that although policy grounding requires action labels, the discovered hierarchy works in a low-data
regime, with relatively few demonstrations sufficing to recover near-optimal performance.

**7.2. Minecraft Evaluation**

We further validate our approach in Minecraft on a “Collect
Log” task using the Mapped dataset, comparing the HiSD
Hierarchy against HiSD Skills-Only, primitive action, and
ground truth baselines. Results in Minecraft (Figure 6)
mirror Craftax. Primitive action PPO fails due to the horizon
length. However, the HiSD Hierarchical agent successfully
solves the task 50% of the time. While Ground Truth yields
the highest performance, HiSD’s hierarchy outperforms the
flat HiSD Skills-Only agent, confirming that hierarchical
structure enables RL in complex environments.

8

**<u>Unsupervised Hierarchical Skill Discovery</u>**

10.0

7.5

5.0

2.5

0.0

0k 5k 10k 15k 20k 25k 30k

Minecraft - Mapped
<u>Reward vs Timesteps</u>

Environment Timesteps

Hierarchy(Ground Truth)
Hierarchy(HiSD)
Skills Only(HiSD)

Skills Only(Ground Truth)
Primitive Actions

_Figure_ _6._ Mean episode rewards (±1 SD) over environment
timesteps for 5 random seeds on the Minecraft Collect Log task.
The HiSD hierarchy (orange) achieves higher performance than
the Skills-Only (HiSD) variant (purple). We note that both fall
short of the ground truth setups that manage to solve the task 100%
of the time. Primitive action PPO (cyan) again fails to solve the
task.

**8. Limitations and Future Work**

HiSD operates on pre-extracted feature representations and
assumes a prior on the maximum number of skills _K_ ; integrating representation learning end-to-end is a natural
extension. While we treat _K_ as a fixed hyperparameter, it
could also be inferred adaptively by running HiSD with a
decreasing schedule of _K_ from a high initial estimate, using indicators such as the skill-label switching frequency,
the number of active clusters at convergence, or the aggregate segmentation cost as a stopping criterion. A further
structural assumption is that each timestep is assigned to a
single discrete skill: this is standard in temporal action segmentation and is shared by our baselines, but settings with
naturally concurrent behaviours (e.g., robotic manipulation
where grasping and locomotion overlap) may benefit from
multi-label or factored skill representations (e.g., via multilabel optimal transport), which we leave to future work. A
more fundamental limitation is that Sequitur is deterministic
and cannot absorb segmentation noise. As a result, nearduplicate skill sequences are treated as distinct, preventing
reuse of subroutines, as seen in Minecraft “All” where HiSD
produces 500 unique trees for a shared task. Probabilistic approaches such as PCFGs (Lari & Young, 1990) or fragment
grammars (O’Donnell et al., 2009), potentially augmented
with learned action effects, could address this by marginalising over noisy parses and capturing causal structure.

**9. Conclusion**

We introduce HiSD, a unified framework for unsupervised
skill segmentation and hierarchical structure discovery in re

inforcement learning domains. By bridging state-of-the-art
temporal action segmentation with grammar-based compres
and OMPN, producing hierarchies that are deeper, more
reusable, and semantically interpretable. Crucially, we show
that meaningful structure can be recovered purely from temporal coherence and visual similarity. As a proof of concept
for utility, we demonstrate that when these discovered abstractions are used in downstream RL, they significantly
accelerate learning, achieving performance comparable to
ground truth hierarchies while improving stability and enabling RL in complex, high-dimensional environments. Our
results suggest that unsupervised structure discovery offers
a scalable path toward generalist agents capable of learning
from abundant, unlabelled data.

**Acknowledgements**

Computations were performed using the High Performance
Computing (HPC) infrastructure provided by the Mathematical Sciences Support unit at the University of the Witwatersrand, Johannesburg. This work was supported in part by
the National Research Foundation (NRF) of South Africa
through the Thuthuka Funding Instrument (Grant Number:
TTK240416214385).

**Impact Statement**

This work contributes to the fields of reinforcement learning
and imitation learning by proposing a method for discovering skill hierarchies from observational data. Our approach
lowers the barrier to training capable agents by removing
the need for dense supervision and action labels. The generated hierarchies offer a degree of transparency often lacking in RL, facilitating better human-AI interaction. We do
not foresee any immediate negative societal consequences
resulting directly from this fundamental research, though
standard ethical considerations regarding the deployment of
autonomous decision-making systems apply.

**References**

Akiba, T., Sano, S., Yanase, T., Ohta, T., and Koyama,

M. Optuna: A next-generation hyperparameter optimization framework. In _Proceedings of the 25th ACM_
_SIGKDD_ _International_ _Conference_ _on_ _Knowledge_ _Dis-_
_covery_ _&_ _Data_ _Mining_, KDD ’19, pp. 2623–2631,

9

**<u>Unsupervised Hierarchical Skill Discovery</u>**

New York, NY, USA, 2019. Association for Computing Machinery. ISBN 9781450362016. doi: 10.1145/
3292500.3330701. URL [https://doi.org/10.](https://doi.org/10.1145/3292500.3330701)
[1145/3292500.3330701.](https://doi.org/10.1145/3292500.3330701)

Bacon, P.-L., Harb, J., and Precup, D. The Option-Critic

architecture. _Proceedings_ _of_ _the_ _AAAI_ _Conference_ _on_
_Artificial_ _Intelligence_, 31(1), Feb. 2017. doi: 10.1609/

aaai.v31i1.10916. [URL https://ojs.aaai.org/](https://ojs.aaai.org/index.php/AAAI/article/view/10916)
[index.php/AAAI/article/view/10916.](https://ojs.aaai.org/index.php/AAAI/article/view/10916)

Baker, B., Akkaya, I., Zhokov, P., Huizinga, J., Tang, J.,

Ecoffet, A., Houghton, B., Sampedro, R., and Clune, J.
Video PreTraining (VPT): learning to act by watching
unlabeled online videos. In Koyejo, S., Mohamed, S.,
Agarwal, A., Belgrave, D., Cho, K., and Oh, A. (eds.),
_Advances in Neural Information Processing Systems_, vol
ume 35, pp. 24639–24654. Curran Associates, Inc., 2022.

Chen, K., Srikanth, N. S., Kent, D., Ravichandar, H.,

and Chernova, S. Learning Hierarchical Task Networks with Preferences from Unannotated Demonstrations. In Kober, J., Ramos, F., and Tomlin, C. (eds.),
_Proceedings_ _of_ _the_ _2020_ _Conference_ _on_ _Robot_ _Learn-_
_ing_, volume 155 of _Proceedings_ _of_ _Machine_ _Learn-_
_ing_ _Research_, pp. 1572–1581. PMLR, 16–18 Nov
[2021. URL https://proceedings.mlr.press/](https://proceedings.mlr.press/v155/chen21d.html)
[v155/chen21d.html.](https://proceedings.mlr.press/v155/chen21d.html)

Correa, C. G., Sanborn, S., Ho, M. K., Callaway, F., Daw,

N. D., and Griffiths, T. L. Exploring the hierarchical structure of human plans via program generation. _Cognition_,
255:105990, February 2025. ISSN 0010-0277. doi: 10.
1016/j.cognition.2024.105990. [URL http://dx.doi.](http://dx.doi.org/10.1016/j.cognition.2024.105990)
[org/10.1016/j.cognition.2024.105990.](http://dx.doi.org/10.1016/j.cognition.2024.105990)

Elkan, C. and Noto, K. Learning classifiers from only
positive and unlabeled data. In _Proceedings of the 14th_
_ACM SIGKDD International Conference on Knowledge_
_Discovery_ _and_ _Data_ _Mining_, KDD ’08, pp. 213–220,
New York, NY, USA, 2008. Association for Computing Machinery. ISBN 9781605581934. doi: 10.
1145/1401890.1401920. URL [https://doi.org/](https://doi.org/10.1145/1401890.1401920)
[10.1145/1401890.1401920.](https://doi.org/10.1145/1401890.1401920)

Erol, K., Hendler, J., and Nau, D. S. HTN planning: Com
plexity and expressivity. In _AAAI_, pp. 1123–1128, 1994.

Eysenbach, B., Gupta, A., Ibarz, J., and Levine, S. Diversity

is All You Need: learning skills without a reward function.
In _International Conference on Learning Representations_
_(ICLR)_ _2019_, 2019. URL [https://openreview.](https://openreview.net/forum?id=SJx63jRqFm)
[net/forum?id=SJx63jRqFm.](https://openreview.net/forum?id=SJx63jRqFm) Poster.

Fan, L., Wang, G., Jiang, Y., Mandlekar, A., Yang, Y., Zhu,

H., Tang, A., Huang, D.-A., Zhu, Y., and Anandkumar, A.
MineDojo: Building open-ended embodied agents with

10

internet-scale knowledge. In Koyejo, S., Mohamed, S.,
Agarwal, A., Belgrave, D., Cho, K., and Oh, A. (eds.),
_Advances in Neural Information Processing Systems_, vol
ume 35, pp. 18343–18362. Curran Associates, Inc., 2022.

Gopalakrishnan, A., Irie, K., Schmidhuber, J., and van

Steenkiste, S. Unsupervised learning of temporal abstractions with slot-based transformers. _Neural Compu-_
_tation_, 35(4):593–626, 03 2023. ISSN 0899-7667. doi:
10.1162/neco ~~a~~ ~~0~~ [1567. URL https://doi.org/10.](https://doi.org/10.1162/neco_a_01567)
[1162/neco_a_01567.](https://doi.org/10.1162/neco_a_01567)

Guss, W. H., Houghton, B., Topin, N., Wang, P., Codel,

C., Veloso, M., and Salakhutdinov, R. MineRL: A
large-scale dataset of Minecraft demonstrations. In _Pro-_
_ceedings of the Twenty-Eighth International Joint Con-_
_ference_ _on_ _Artificial_ _Intelligence,_ _IJCAI-19_, pp. 2442–
2448. International Joint Conferences on Artificial Intelligence Organization, 7 2019. doi: 10.24963/ijcai.2019/
339. [URL https://doi.org/10.24963/ijcai.](https://doi.org/10.24963/ijcai.2019/339)
[2019/339.](https://doi.org/10.24963/ijcai.2019/339)

Hayes, B. and Scassellati, B. Autonomously construct
ing Hierarchical Task Networks for planning and humanrobot collaboration. In _2016 IEEE International Confer-_
_ence on Robotics and Automation (ICRA)_, pp. 5469–5476,
2016. doi: 10.1109/ICRA.2016.7487760.

Ho, M. K., Abel, D., Griffiths, T. L., and Littman, M. L.

The value of abstraction. _Current_ _Opinion_ _in_ _Behav-_
_ioral_ _Sciences_, 29:111–116, 2019. ISSN 2352-1546.
doi: https://doi.org/10.1016/j.cobeha.2019.05.001.
URL [https://www.sciencedirect.com/](https://www.sciencedirect.com/science/article/pii/S2352154619300026)
[science/article/pii/S2352154619300026.](https://www.sciencedirect.com/science/article/pii/S2352154619300026)
Artificial Intelligence.

Hogg, C., Munoz Avila, H., and Kuter, U.˜ HTN-MAKER:

learning HTNs with minimal additional knowledge engineering required. In _Proceedings_ _of_ _the_ _23rd_ _Na-_
_tional_ _Conference_ _on_ _Artificial_ _Intelligence_ _-_ _Volume_
_2_, AAAI’08, pp. 950–956. AAAI Press, 2008. ISBN
9781577353683.

Hotelling, H. Analysis of a complex of statistical variables

into principal components. _Journal of Educational Psy-_
_chology_, 24(6):417–441, 1933. doi: 10.1037/h0071325.
[URL https://doi.org/10.1037/h0071325.](https://doi.org/10.1037/h0071325)

Kanervisto, A., Karttunen, J., and Hautamaki,¨ V. Play
ing Minecraft with Behavioural Cloning. In Escalante, H. J. and Hadsell, R. (eds.), _Proceedings_
_of_ _the_ _NeurIPS_ _2019_ _Competition_ _and_ _Demonstra-_
_tion_ _Track_, volume 123 of _Proceedings_ _of_ _Machine_
_Learning_ _Research_, pp. 56–66. PMLR, 08–14 Dec
[2020. URL https://proceedings.mlr.press/](https://proceedings.mlr.press/v123/kanervisto20a.html)
[v123/kanervisto20a.html.](https://proceedings.mlr.press/v123/kanervisto20a.html)

**<u>Unsupervised Hierarchical Skill Discovery</u>**

Kipf, T., Li, Y., Dai, H., Zambaldi, V., Sanchez-Gonzalez,

A., Grefenstette, E., Kohli, P., and Battaglia, P. CompILE: Compositional Imitation Learning and Execution.
In _Proceedings of the 36th International Conference on_
_Machine_ _Learning_, pp. 3418–3428. PMLR, May 2019.
[URL https://proceedings.mlr.press/v97/](https://proceedings.mlr.press/v97/kipf19a.html)
[kipf19a.html.](https://proceedings.mlr.press/v97/kipf19a.html) ISSN: 2640-3498.

Konidaris, G., Kuindersma, S., Grupen, R., and Barto, A.

Robot learning from demonstration by constructing skill
trees. _The International Journal of Robotics Research_,
31:360–375, 05 2012. doi: 10.1177/0278364911428653.

Lange, R. T. and Faisal, A. Semantic RL with Action
Grammars: Data-efficient learning of hierarchical task abstractions, 2019. [URL https://arxiv.org/abs/](https://arxiv.org/abs/1907.12477)
[1907.12477.](https://arxiv.org/abs/1907.12477)

Lari, K. and Young, S. The estimation of stochastic context-free grammars using the InsideOutside algorithm. _Computer_ _Speech_ _&_ _Lan-_
_guage_, 4(1):35–56, 1990. ISSN 0885-2308. doi:
https://doi.org/10.1016/0885-2308(90)90022-X.
URL [https://www.sciencedirect.com/](https://www.sciencedirect.com/science/article/pii/088523089090022X)
[science/article/pii/088523089090022X.](https://www.sciencedirect.com/science/article/pii/088523089090022X)

Lea, C., Flynn, M. D., Vidal, R., Reiter, A., and Hager, G. D.

Temporal convolutional networks for action segmentation
and detection. In _2017 IEEE Conference on Computer_
_Vision and Pattern Recognition (CVPR)_, pp. 1003–1012,

2017. doi: 10.1109/CVPR.2017.113.

Lu, Y., Shen, Y., Zhou, S., Courville, A., Tenenbaum, J. B.,

and Gan, C. Learning task decomposition with Ordered
Memory Policy Network. In _International Conference_
_on_ _Learning_ _Representations_, 2021. URL [https://](https://openreview.net/forum?id=vcopnwZ7bC)
[openreview.net/forum?id=vcopnwZ7bC.](https://openreview.net/forum?id=vcopnwZ7bC)

Matthews, M., Beukman, M., Ellis, B., Samvelyan, M.,

Jackson, M. T., Coward, S., and Foerster, J. N. Craftax: A
lightning-fast benchmark for open-ended reinforcement
learning. In Salakhutdinov, R., Kolter, Z., Heller, K.,
Weller, A., Oliver, N., Scarlett, J., and Berkenkamp, F.
(eds.), _Proceedings of the 41st International Conference_
_on Machine Learning_, volume 235 of _Proceedings of Ma-_
_chine Learning Research_, pp. 35104–35137. PMLR, 21–
27 Jul 2024. URL [https://proceedings.mlr.](https://proceedings.mlr.press/v235/matthews24a.html)
[press/v235/matthews24a.html.](https://proceedings.mlr.press/v235/matthews24a.html)

Nachum, O., Tang, H., Lu, X., Gu, S., Lee, H., and Levine,

S. Why does hierarchy (sometimes) work so well in
reinforcement learning? _CoRR_, abs/1909.10618, 2019.
[URL http://arxiv.org/abs/1909.10618.](http://arxiv.org/abs/1909.10618)

Nejati, N., Langley, P., and Konik, T. Learning hierarchical

task networks by observation. In _Proceedings of the 23rd_
_International Conference on Machine Learning_, ICML

11

’06, pp. 665–672, New York, NY, USA, 2006. Association

for Computing Machinery. ISBN 1595933832. doi: 10.
1145/1143844.1143928. URL [https://doi.org/](https://doi.org/10.1145/1143844.1143928)
[10.1145/1143844.1143928.](https://doi.org/10.1145/1143844.1143928)

Nevill-Manning, C. G. and Witten, I. H. Identifying hier
archical structure in sequences: a linear-time algorithm.
_J._ _Artif._ _Int._ _Res._, 7(1):67–82, September 1997. ISSN
1076-9757.

O’Donnell, T. J., Tenenbaum, J. B., and Goodman, N. D.

Fragment grammars: Exploring computation and reuse in
language. Technical Report MIT-CSAIL-TR-2009-013,
Massachusetts Institute of Technology, Computer Science
and Artificial Intelligence Laboratory, March 2009. URL
[http://hdl.handle.net/1721.1/44963.](http://hdl.handle.net/1721.1/44963)

Pearson, K. LIII. on lines and planes of closest fit
to systems of points in space. _The_ _London,_ _Edin-_
_burgh,_ _and_ _Dublin_ _Philosophical_ _Magazine_ _and_ _Jour-_
_nal_ _of_ _Science_, 2(11):559–572, 1901. doi: 10.1080/
14786440109462720. [URL https://doi.org/10.](https://doi.org/10.1080/14786440109462720)
[1080/14786440109462720.](https://doi.org/10.1080/14786440109462720)

Ranchod, P., Rosman, B., and Konidaris, G. Nonparametric

Bayesian reward segmentation for skill discovery using
inverse reinforcement learning. In _2015_ _IEEE/RSJ_ _In-_
_ternational_ _Conference_ _on_ _Intelligent_ _Robots_ _and_ _Sys-_
_tems_ _(IROS)_, pp. 471–477. IEEE Press, 2015. doi:
10.1109/IROS.2015.7353414. URL [https://doi.](https://doi.org/10.1109/IROS.2015.7353414)
[org/10.1109/IROS.2015.7353414.](https://doi.org/10.1109/IROS.2015.7353414)

Schulman, J., Wolski, F., Dhariwal, P., Radford, A., and

Klimov, O. Proximal Policy Optimization Algorithms.
_CoRR_, abs/1707.06347, 2017. [URL http://arxiv.](http://arxiv.org/abs/1707.06347)
[org/abs/1707.06347.](http://arxiv.org/abs/1707.06347)

Solway, A., Diuk, C., Cordova, N., Yee, D., Barto, A. G.,´

Niv, Y., and Botvinick, M. M. Optimal behavioral hierarchy. _PLOS Computational Biology_, 10(8):1–10, 08 2014.
doi: 10.1371/journal.pcbi.1003779. URL [https://](https://doi.org/10.1371/journal.pcbi.1003779)
[doi.org/10.1371/journal.pcbi.1003779.](https://doi.org/10.1371/journal.pcbi.1003779)

Sutton, R. S., Precup, D., and Singh, S. Between MDPs and

Semi-MDPs: A framework for temporal abstraction in
reinforcement learning. _Artificial Intelligence_, 112(1-2):
181–211, 1999. doi: 10.1016/S0004-3702(99)00052-1.
URL [https://www.sciencedirect.com/](https://www.sciencedirect.com/science/article/pii/S0004370299000521)
[science/article/pii/S0004370299000521.](https://www.sciencedirect.com/science/article/pii/S0004370299000521)

Tessler, C., Givony, S., Zahavy, T., Mankowitz, D. J.,

and Mannor, S. A deep hierarchical approach to
lifelong learning in Minecraft. _Proceedings_ _of_ _the_
_AAAI_ _Conference_ _on_ _Artificial_ _Intelligence_, 31(1):
1553–1561, February 2017. doi: 10.1609/aaai.v31i1.
10744. URL [https://ojs.aaai.org/index.](https://ojs.aaai.org/index.php/AAAI/article/view/10744)
[php/AAAI/article/view/10744.](https://ojs.aaai.org/index.php/AAAI/article/view/10744)

**<u>Unsupervised Hierarchical Skill Discovery</u>**

Torabi, F., Warnell, G., and Stone, P. Behavioral cloning

from observation. In _Proceedings_ _of_ _the_ _27th_ _Inter-_
_national Joint Conference on Artificial Intelligence_, IJCAI’18, pp. 4950–4957. AAAI Press, 2018. ISBN
9780999241127.

Xu, M. and Gould, S. Temporally Consistent Unbalanced

Optimal Transport for Unsupervised Action Segmentation . In _2024 IEEE/CVF Conference on Computer Vision_
_and_ _Pattern_ _Recognition_ _(CVPR)_, pp. 14618–14627,
Los Alamitos, CA, USA, June 2024. IEEE Computer
Society. doi: 10.1109/CVPR52733.2024.01385. URL
[https://doi.ieeecomputersociety.org/](https://doi.ieeecomputersociety.org/10.1109/CVPR52733.2024.01385)
[10.1109/CVPR52733.2024.01385.](https://doi.ieeecomputersociety.org/10.1109/CVPR52733.2024.01385)

Zhu, Y., Stone, P., and Zhu, Y. Bottom-up skill discovery

from unsegmented demonstrations for long-horizon robot
manipulation. _IEEE Robotics and Automation Letters_, 7
(2):4126–4133, 2022. doi: 10.1109/LRA.2022.3146589.

12

**<u>Unsupervised Hierarchical Skill Discovery</u>**

**Appendix**

This section outlines and provides the supplementary information and figures for the main paper on _Unsupervised Hierarchi-_
_cal Skill Discovery_ . We note that all code written and used is available via our GitHub [Repository.](https://github.com/dami2106/Unsupervised-Hierarchical-Skill-Discovery)

**A. Environment Details and Examples**

Figure 7 provides examples of the observations from both Craftax (Matthews et al., 2024) and Minecraft (Baker et al., 2022)
environments.

**(A)** Example of an RGB observation from the modified Craftax
environment

**(B)** Example of an RGB observation from the Minecraft environment

_Figure 7._ Environment observation examples from Craftax (Matthews et al., 2024) (A) and Minecraft (Baker et al., 2022) (B).

**A.1. Craftax**

We model the Craftax environment (Matthews et al., 2024) as a fully observable Markov Decision Process (MDP), diverging
from its standard Partially Observable Markov Decision Process (POMDP) formulation. To achieve this, we introduce
specific modifications that simplify the dynamics and grant the agent global visibility:

1. **Global Observation:** The camera is fixed to capture the entire world state, removing partial observability.

2. **Stationary Mechanics:** Day/night cycles are disabled to maintain consistent lighting.

3. **Simplified Survival:** Health, energy, and food decay are disabled, giving the agent infinite stamina.

4. **Static Environment:** All autonomous entities (monsters and animals) are removed.

Each observation returned by the environment is a 274 _×_ 274 _×_ 3 RGB image representing a top-down view of the full
32 _×_ 32 map (see Figure 7A). The action space is restricted to 16 discrete primitives, categorised by functionality in Table 4.

**Category** **IDs** **Actions**

Movement 0, 1-4, 6 No-op, Move (L/R/U/D), Sleep
Interaction 5 Do Action (Break Block)
Placement 7-10 Place : Stone, Workbench, Furnace, Plant
Crafting 11-15 Craft : Pickaxes (Wood/Stone/Iron), Swords
(Stone/Iron)

_Table 4._ The condensed action space used in our modified Craftax environment.

13

**<u>Unsupervised Hierarchical Skill Discovery</u>**

A.1.1. CRAFTAX TASK AND SKILL STATISTICS

This section analyses the expert demonstrations collected for the Craftax environment. Figure 8 illustrates the distribution
of skills employed across varying tasks. This metric is derived by summing the number of steps (frames) a specific skill
is active over the entire dataset. We observe that all datasets (with the exception of the 2-skill WSWS Random dataset)
exhibit a long-tail distribution. In these cases, the “wood” interaction skill dominates, reflecting its role as a fundamental,
high-frequency discriminant action within the environment.

Additionally, we analyse task complexity and prerequisites. Table 5 details the episode length statistics. As expected,
complex tasks correlate with increased episode duration; simpler tasks average approximately 14 _−_ 16 steps, whereas harder
tasks average roughly 33 steps. Finally, Table 6 outlines the specific item dependencies and resource requirements necessary
to successfully complete each task.

7000

6000

5000

4000

3000

2000

1000

0

3500

3000

2500

2000

1500

1000

500

0

|7,192 Ground Truth Distribution: Stone Pickaxe (Static)|Col2|Col3|Col4|Col5|Col6|Col7|Col8|Col9|Col10|Col11|
|---|---|---|---|---|---|---|---|---|---|---|
|7,192|7,192|7,192|7,192|7,192|7,192|7,192|7,192|7,192|7,192|7,192|
||||||||||||
||||||||||||
||||||||||||
|||3,137<br>~~2,806~~|3,137<br>~~2,806~~|3,137<br>~~2,806~~|3,137<br>~~2,806~~|3,137<br>~~2,806~~|3,137<br>~~2,806~~|3,137<br>~~2,806~~|3,137<br>~~2,806~~|3,137<br>~~2,806~~|
|||||||~~1,753~~|~~1,753~~|~~1,753~~|~~1,753~~|~~1,753~~|
|||||||||1,000|1,000|1,000|
||||||||||||

Wood Stone Pick Stone Wooden Pick Table

Skill

_(a)_ Stone Pickaxe (Static)

|3,799 Ground Truth Distribution: Mixed (Static)|Col2|Col3|Col4|Col5|Col6|Col7|Col8|Col9|Col10|Col11|
|---|---|---|---|---|---|---|---|---|---|---|
|3,799|3,799|3,799|3,799|3,799|3,799|3,799|3,799|3,799|3,799|3,799|
|3,799|||||||||||
||||||||||||
||||||||||||
||||||||||||
||||||||||||
|||~~1,313~~<br>|~~1,313~~<br>|~~1,313~~<br>|~~1,313~~<br>|~~1,313~~<br>|~~1,313~~<br>|~~1,313~~<br>|~~1,313~~<br>|~~1,313~~<br>|
|||~~1,313~~<br>|||||||||
|||||777<br>624<br>~~443~~|777<br>624<br>~~443~~|777<br>624<br>~~443~~|777<br>624<br>~~443~~|777<br>624<br>~~443~~|777<br>624<br>~~443~~|777<br>624<br>~~443~~|
|||||777<br>624<br>~~443~~|||||||
|||||777<br>624<br>~~443~~|||||||
||||||||||||

Wood Stone Wooden Pick Table Stone Sword

Skill

_(c)_ Mixed Task (Static)

7000

6000

5000

4000

3000

2000

1000

0

4000

3000

2000

1000

0

|7,528 Ground Truth Distribution: Stone Pickaxe (Random)|Col2|Col3|Col4|Col5|Col6|Col7|Col8|Col9|Col10|Col11|
|---|---|---|---|---|---|---|---|---|---|---|
|7,528|7,528|7,528|7,528|7,528|7,528|7,528|7,528|7,528|7,528|7,528|
|7,528|||||||||||
||||||||||||
||||||||||||
||||||||||||
|||2,890<br>~~2,820~~|2,890<br>~~2,820~~|2,890<br>~~2,820~~|2,890<br>~~2,820~~|2,890<br>~~2,820~~|2,890<br>~~2,820~~|2,890<br>~~2,820~~|2,890<br>~~2,820~~|2,890<br>~~2,820~~|
|||||||~~1,760~~|~~1,760~~|~~1,760~~|~~1,760~~|~~1,760~~|
|||||||||1,000|1,000|1,000|
||||||||||||

Wood Stone Pick Stone Wood Pick Table

Skill

_(b)_ Stone Pickaxe (Random)

|4,329 Ground Truth Distribution: WSWS (Random)|Col2|Col3|Col4|Col5|
|---|---|---|---|---|
|4,329|4,329|4,329|4,329|4,329|
|4,329|||||
|||3,504|3,504|3,504|
|||3,504|||
||||||
||||||
||||||

Stone Wood

Skill

_(d)_ Wood-Stone Collection (Random)

_Figure 8._ **Ground truth skill distributions.** The histograms depict the frequency of skill usage across different Craftax tasks. The ‘wood‘

skill serves as a primary interaction mechanic in most configurations.

**Target** **Ingredients**

**Task Name** **Min** **Avg** **Max**

Stone Pickaxe (Static) 17 32.78 102
Stone Pickaxe (Random) 19 33.00 74
Mixed Task (Static) 3 14.91 58
Wood-Stone Coll. (Rand) 10 16.67 42

_Table 5._ Episode length statistics for expert demonstrations.

Wood Break 1 _×_ Tree
Workbench 2 _×_ Wood
Wood Pick 1 _×_ Wood + Bench
Stone Mine w/ Wood Pick
Stone Pickaxe 1 _×_ Wood + 1 _×_ Stone
Stone Sword 1 _×_ Wood + 1 _×_ Stone

_Table 6._ Crafting dependencies.

14

**<u>Unsupervised Hierarchical Skill Discovery</u>**

**A.2. Minecraft**

We adopt the Minecraft environment specification from MineRL (Guss et al., 2019), modelled as a POMDP. The agent
operates on high-dimensional sensory input, receiving RGB frames of size 640 _×_ 360 _×_ 3 at each timestep. To extract
semantic features for our experiments, these raw visual observations are encoded using the MineCLIP (CLIP4MC) video-text
encoder (Fan et al., 2022).

The agent utilises the standard MineRL action space, which corresponds to low-level keyboard and mouse commands. This
includes navigation, interaction, and GUI management (required for crafting items). The action space is a dictionary of
binary triggers (such as movement, or hotbar selection) and discretised camera controls. A summary of these action groups
is provided in Table 7. The camera bins used are: _{_ 0 <sup>_◦_</sup> _, ±_ 0 _._ 62 <sup>_◦_</sup> _, ±_ 1 _._ 61 <sup>_◦_</sup> _, ±_ 3 _._ 22 <sup>_◦_</sup> _, ±_ 5 _._ 81 <sup>_◦_</sup> _, ±_ 10 <sup>_◦_</sup> _}_

**Category** **Actions Included** **Type**

Movement Forward, Back, Left, Right, Jump, Sprint, Sneak Binary
Interaction Attack, Use, Drop, Pick Item, Swap Hands Binary
Interface Inventory, Escape (Menu/ No-Op) Binary
Hotbar Slots 1–9 Binary
Camera Pitch, Yaw Discrete (11 bins each)

_Table 7._ Summary of the standard MineRL action space. The camera actions are discretised into 11 distinct bins (Guss et al., 2019).

A.2.1. MINECRAFT TASK AND SKILL STATISTICS

This section analyses the expert demonstrations collected for the Minecraft environment. Figure 9 illustrates the distribution
of skills employed across the two task configurations: “All” (fine-grained) and “Mapped” (semantically grouped). This
metric is derived by summing the number of steps (frames) a specific skill is active over the entire dataset. Consistent with
the Craftax analysis in Appendix A.1.1, we observe a long-tail distribution in skill usage.

We further analyse task complexity and prerequisites in Table 8 and Table 9. The left panel details episode length statistics;
note that these are identical for both configurations as they share the same underlying trajectory data, differing only in
ground truth labelling. The right panel outlines the specific item dependencies and resource requirements necessary for
gathering resources and crafting. Note that any *stone* or *ore* block requires a Wooden Pickaxe to be broken
and collected; other blocks listed can be mined by hand.

Finally, Table 10 presents the semantic mapping schema used to condense the “All” task space into the “Mapped” space.
This aggregation groups visually or functionally similar items (such as all wood log variants) into single skill categories to
facilitate segmentation. Items not listed in this table retain their original fine-grained labels.

**Target** **Ingredients**

**Task Name** **Min** **Avg** **Max**

Minecraft (Mapped) 630 785.72 1078
Minecraft (All) 630 785.72 1078

_Table 8._ Episode length statistics (steps).

4 _×_ Planks 1 _×_ Log
Crafting Table 4 _×_ Planks
4 _×_ Sticks 1 _×_ Plank
Wood Pick 3 _×_ Plank + 2 _×_ Stick
Cobble/Stone Mine w/ Wood Pick

_Table 9._ Crafting dependencies.

15

**<u>Unsupervised Hierarchical Skill Discovery</u>**

Ground Truth Skill Distribution: Minecraft (All)

Ground Truth Skill Distribution: Minecraft (Mapped)

Mined Oak Log

|Col1|Col2|Col3|Col4|94,0|08|
|---|---|---|---|---|---|
|||33<br>41,378||||
||5<br>570<br>7,131<br>17,717<br>19,769<br>24,422<br>29,062<br>31,092<br>34,0|5<br>570<br>7,131<br>17,717<br>19,769<br>24,422<br>29,062<br>31,092<br>34,0|5<br>570<br>7,131<br>17,717<br>19,769<br>24,422<br>29,062<br>31,092<br>34,0|5<br>570<br>7,131<br>17,717<br>19,769<br>24,422<br>29,062<br>31,092<br>34,0|5<br>570<br>7,131<br>17,717<br>19,769<br>24,422<br>29,062<br>31,092<br>34,0|
|||||||
|||||||
|||||||
|||||||
|3<br>6<br>12<br>12<br>13<br>31<br>31<br>35<br>47<br>66<br>93<br>103<br>159<br>175<br>446<br>457<br>551<br>558<br>678<br>693<br>911<br>1,186<br>1,211<br>1,758<br>2,379<br>2,496<br>2,524<br>2,589<br>2,912<br>4,478<br>7,026<br>9,863<br>12,899<br>13,06<br>15,<br>1<br>|3<br>6<br>12<br>12<br>13<br>31<br>31<br>35<br>47<br>66<br>93<br>103<br>159<br>175<br>446<br>457<br>551<br>558<br>678<br>693<br>911<br>1,186<br>1,211<br>1,758<br>2,379<br>2,496<br>2,524<br>2,589<br>2,912<br>4,478<br>7,026<br>9,863<br>12,899<br>13,06<br>15,<br>1<br>|3<br>6<br>12<br>12<br>13<br>31<br>31<br>35<br>47<br>66<br>93<br>103<br>159<br>175<br>446<br>457<br>551<br>558<br>678<br>693<br>911<br>1,186<br>1,211<br>1,758<br>2,379<br>2,496<br>2,524<br>2,589<br>2,912<br>4,478<br>7,026<br>9,863<br>12,899<br>13,06<br>15,<br>1<br>|3<br>6<br>12<br>12<br>13<br>31<br>31<br>35<br>47<br>66<br>93<br>103<br>159<br>175<br>446<br>457<br>551<br>558<br>678<br>693<br>911<br>1,186<br>1,211<br>1,758<br>2,379<br>2,496<br>2,524<br>2,589<br>2,912<br>4,478<br>7,026<br>9,863<br>12,899<br>13,06<br>15,<br>1<br>|3<br>6<br>12<br>12<br>13<br>31<br>31<br>35<br>47<br>66<br>93<br>103<br>159<br>175<br>446<br>457<br>551<br>558<br>678<br>693<br>911<br>1,186<br>1,211<br>1,758<br>2,379<br>2,496<br>2,524<br>2,589<br>2,912<br>4,478<br>7,026<br>9,863<br>12,899<br>13,06<br>15,<br>1<br>|3<br>6<br>12<br>12<br>13<br>31<br>31<br>35<br>47<br>66<br>93<br>103<br>159<br>175<br>446<br>457<br>551<br>558<br>678<br>693<br>911<br>1,186<br>1,211<br>1,758<br>2,379<br>2,496<br>2,524<br>2,589<br>2,912<br>4,478<br>7,026<br>9,863<br>12,899<br>13,06<br>15,<br>1<br>|

0 20000 40000 60000 80000 100000

Frequency

_(a)_ Minecraft (All)

Mined Log

Mined Stone

Mined Crafting Table

Mined Dirt

Walked

Mined Grass

Crafted Stick

Crafted Plank

Crafted Crafting Table

Used Crafting Table

Crafted Wooden Pick

Mined Leaves

Mined Sand

Mined Coal Ore

|Col1|Col2|Col3|Col4|Col5|Col6|Col7|15|2,616|
|---|---|---|---|---|---|---|---|---|
||||||||||
|||127<br>41,378<br>42,191|||||||
||||||||||
||||||||||
||||||||||
||||||||||
||||||||||
||||||||||
||||||||||
||||||||||
||||||||||
||||||||||
||||||||||
|457<br>558<br>4,39<br>1<br>1|457<br>558<br>4,39<br>1<br>1|457<br>558<br>4,39<br>1<br>1|457<br>558<br>4,39<br>1<br>1|457<br>558<br>4,39<br>1<br>1|457<br>558<br>4,39<br>1<br>1|457<br>558<br>4,39<br>1<br>1|457<br>558<br>4,39<br>1<br>1|457<br>558<br>4,39<br>1<br>1|

0 20000 40000 60000 80000 100000 120000 140000 160000

Frequency

_(b)_ Minecraft (Mapped)

Mined Crafting Table
Mined Stone
Mined Dirt

Mined Spruce Log
Walked

Mined Grass Block
Crafted Stick

Mined Birch Log

Crafted Crafting Table
Used Crafting Table

Crafted Wooden Pick
Crafted Oak Planks
Mined Jungle Log

Mined Dark Oak Log

Crafted Spruce Planks
Mined Oak Leaves
Mined Granite
Mined Diorite

Mined Andesite

Crafted Birch Planks
Mined Grass

Mined Spruce Leaves
Mined Acacia Log
Mined Gravel

Crafted Jungle Planks
Mined Sand
Mined Vine

Mined Andesite

Mined Coal Ore

Crafted Dark Oak Planks
Mined Tall Grass
Mined Fern

Mined Large Fern

Crafted Acacia Planks
Mined Clay

Mined Birch Leaves
Mined Coarse Dirt
Mined Rose Bush
Mined Peony

Mined Dandelion

Mined Acacia Leaves
Mined Jungle Leaves
Mined Sugar Cane

Mined Oxeye Daisy

_Figure 9._ **Ground truth skill distributions for Minecraft Tasks.** The histograms show the frequency of skill usage. Again we see that

the Mine Wood skills serve as a primary interaction mechanic in both settings.

**Mapped Category** **Fine-Grained Skills (Original Labels)**

crafted ~~p~~ lank crafted ~~a~~ cacia ~~p~~ lanks, crafted ~~b~~ irch ~~p~~ lanks, crafted ~~d~~ ark ~~o~~ ak ~~p~~ lanks,
crafted ~~j~~ ungle ~~p~~ lanks, crafted ~~o~~ ak ~~p~~ lanks, crafted ~~s~~ pruce ~~p~~ lanks

mined ~~l~~ og mined ~~a~~ cacia ~~l~~ og, mined ~~b~~ irch ~~l~~ og, mined ~~d~~ ark ~~o~~ ak ~~l~~ og, mined ~~j~~ ungle ~~l~~ og,
mined ~~o~~ ak ~~l~~ og, mined ~~s~~ pruce ~~l~~ og, used ~~o~~ ak ~~l~~ og, used ~~s~~ pruce ~~l~~ og

mined ~~l~~ eaves mined ~~a~~ cacia ~~l~~ eaves, mined ~~b~~ irch ~~l~~ eaves, mined ~~j~~ ungle ~~l~~ eaves,
mined ~~o~~ ak ~~l~~ eaves, mined ~~s~~ pruce ~~l~~ eaves, mined ~~v~~ ines, mined ~~v~~ ine

mined ~~s~~ tone mined ~~a~~ ndesite, mined ~~c~~ lay, mined ~~d~~ iorite, mined ~~g~~ ranite, mined ~~g~~ ravel

mined ~~d~~ irt mined ~~c~~ oarse ~~d~~ irt

mined ~~g~~ rass mined ~~l~~ arge ~~f~~ ern, mined ~~d~~ andelion, mined ~~f~~ ern, mined ~~g~~ rass,
mined ~~g~~ rass ~~b~~ lock, mined ~~o~~ xeye ~~d~~ aisy, mined ~~p~~ eony, mined ~~r~~ ose ~~b~~ ush,
mined ~~s~~ ugar ~~c~~ ane, mined ~~t~~ all ~~g~~ rass

_Table 10._ Mapping of fine-grained skills to high-level categories. Skills not listed here (such as mined ~~c~~ oal) are retained in their

original form.

16

**<u>Unsupervised Hierarchical Skill Discovery</u>**

**B. Hardware Infrastructure and Computational Efficiency**

To assess the practical deployability of our method, we contrast the computational resources required for the baselines
(CompILE, OMPN) against our proposed method (HiSD).

BASELINE REQUIREMENTS
The baseline models (CompILE (Kipf et al., 2019), OMPN
(Lu et al., 2021)) imposed significant computational overhead. Training required a high-end workstation equipped
with an **Intel** **i9-10940X** **CPU**, **128GB** **of** **RAM**, and an
**NVIDIA RTX 3090 (24GB VRAM)** .
Despite this powerful hardware, the memory-intensive architectures of OMPN and CompILE necessitated relatively
small batch sizes. Consequently, these models exhibited
slow convergence and long training times, highlighting scaling limitations.

HISD EFFICIENCY (OURS)
HiSD was trained on a more modest setup: an **AMD Ryzen**
**9800X3D**, **32GB** **of** **RAM**, and an **NVIDIA** **RTX** **3080**
**(10GB VRAM)** .
Notably, HiSD is capable of training and inference on
consumer-grade GPUs with as little as **6GB VRAM** (RTX
3050). This low memory footprint and faster convergence
rate make HiSD a significantly more scalable solution, enabling deployment on standard consumer hardware without
the need for enterprise-grade compute clusters.

**Baselines (CompILE, OMPN)** **Ours (HiSD)**

**GPU VRAM Required** High ( _∼_ 24GB) Low (6–10GB)
**System RAM** 128GB 32GB
**Batch Size Limit** Restricted (Memory Bound) Flexible
**Training Duration** Slow Fast
**Min.** **GPU Spec** RTX 3090 (or equivalent) RTX 3050 (Consumer Grade)

_Table 11._ Comparison of hardware specifications and computational constraints. HiSD achieves comparable or superior performance with

significantly lower memory requirements.

**C. Downstream RL Configuration**

To evaluate the utility of the discovered structures, we instantiate the discovered skills as temporal options, denoted as
_ω_ = _⟨Iω, πω, βω⟩_ . We employ a two-stage process: first, we learn the initiation sets ( _Iω_ ) and termination conditions ( _βω_ )
using positive-unlabelled learning; second, we learn the intra-option policies ( _πω_ ) via Behavioural Cloning.

Hierarchical nodes (non-terminals in the induced grammar) are instantiated as composite options. These nodes do not
require separate policy learning; instead, they execute their constituent child options sequentially. A composite option
inherits the initiation condition of its first child and the termination condition of its last child, preserving the temporal logic
of the discovered hierarchy. However, we note that OMPN does not learn skills for the leaf nodes and instead represents leaf
nodes as sequences of primitive actions. Thus, we do not learn a BC model or a PU model for the OMPN hierarchies, only
for the segmented skills OMPN produces.

For the PU models, in both Craftax and Minecraft, we report the following metrics: Micro F1-Score, Macro Recall, Macro
Precision, and Overall Accuracy. In multi-label environments with significant class imbalance, reporting a single metric
is insufficient to capture model efficacy. We prioritise Micro F1-Score to provide an aggregate measure of global system
reliability by weighting each instance equally, while Macro Precision and Macro Recall ensure that performance is not
driven solely by majority classes, reflecting the model’s ability to generalise to rare skills. Finally, Overall Accuracy serves
as a baseline for the total reduction in classification error across the entire feature space. We note all PU and BC models
were trained with the computational requirements outlined in Table 11 (left) for the baselines.

**C.1. Craftax Skill Configuration**

For the Craftax domain, we utilise a combination of feature-based and pixel-based learning. While the structure discovery
and option applicability (PU models) operate on lower-dimensional PCA features for efficiency, the control policies (BC
and PPO) operate on pixel-based observations to retain spatial precision.

17

**<u>Unsupervised Hierarchical Skill Discovery</u>**

C.1.1. INITIATION AND TERMINATION (PU LEARNING)

We treat the identification of valid start and end states as a binary classification problem trained on positive and unlabelled
data. We employ the Elkan-Noto PU learning algorithm.

  - **Input Data:** PCA features reduced from the raw pixel observations ( _D_ = 650).

  - **Classifier:** We use a Support Vector Machine (SVM) as the base estimator with an RBF kernel, a regularisation
parameter _C_ = 10, and _γ_ = scale.

  - **Training:** Models are trained using a hold-out ratio of 0 _._ 2. We perform grouped cross-validation (5 folds) to select
decision thresholds that maximise the F1 score for each skill.

The performance of the learned initiation and termination models for the ground truth skills and discovered skills are
presented in Tables 12a, 12b, 12c, and 12d.

**Metric** **PU-Start** **PU-End**

Micro F1-Score 0.867 0.570
Macro Recall 0.926 0.780
Macro Precision 0.785 0.543
Overall Accuracy 0.955 0.954

_(a)_ Ground Truth Skills

**Metric** **PU-Start** **PU-End**

Micro F1-Score 0.519 0.142
Macro Recall 0.733 0.592
Macro Precision 0.342 0.195
Overall Accuracy 0.764 0.691

_(c)_ OMPN Discovered Skills

**Metric** **PU-Start** **PU-End**

Micro F1-Score 0.883 0.533
Macro Recall 0.925 0.728
Macro Precision 0.795 0.493
Overall Accuracy 0.961 0.951

_(b)_ HiSD Discovered Skills

**Metric** **PU-Start** **PU-End**

Micro F1-Score 0.752 0.359
Macro Recall 0.704 0.519
Macro Precision 0.518 0.360
Overall Accuracy 0.906 0.935

_(d)_ CompILE Discovered Skills

_Table 12._ Comparison of PU Start and End Learning results across the different methods.

C.1.2. INTRA-OPTION POLICIES (BEHAVIOURAL CLONING)

We learn a parametrised policy _πθ_ ( _a|s_ ) for each atomic skill using supervised learning on the expert demonstrations.

  - **Architecture:** We employ a ResNet-34 backbone pre-trained on ImageNet. The final classification layer is replaced to
output logits for the 16 primitive Craftax actions.

  - **Input:** Raw top-down RGB observations, resized to 256 _×_ 256 and normalised using ImageNet statistics.

  - **Optimisation:** We optimise the Cross-Entropy loss using the AdamW optimiser with a learning rate of 3 _×_ 10 <sup>_−_</sup> <sup>4</sup> and
weight decay of 3 _×_ 10 <sup>_−_</sup> <sup>4</sup> over 150 epochs.

C.1.3. HIGH-LEVEL PPO CONTROLLER

The downstream agent is trained using PPO with a standard Convolutional Neural Network policy.

  - **Input:** Raw 64 _×_ 64 top-down pixel observations (unlike the BC policies, the PPO agent does not use the ResNet
backbone).

  - **Action Space:** The action space is discrete and consists of the primitive actions plus the executable options.

  - **Masking:** We use Maskable PPO. At each timestep, the validity of a skill option is determined by querying the
corresponding PU initiation model on the current observation’s PCA features.

18

**<u>Unsupervised Hierarchical Skill Discovery</u>**

**C.2. Minecraft Configuration**

In the Minecraft domain, we leverage pre-trained MineCLIP embeddings for all stages of the pipeline to handle the
high-dimensional visual complexity. We enforce a global frameskip of 8 across the environment, BC training, and PPO
execution.

C.2.1. INITIATION (PU LEARNING)

Similar to Craftax, we learn initiation sets via PU learning. However, due to the high stochasticity and noise in the Minecraft
transitions, we found the termination (end) PU models to be unreliable. Therefore, in this configuration, we rely solely
on initiation models to gate skill availability, while termination is handled via fixed time horizons or implicit sub-goal
completion.

  - **Input Data:** 512-dimensional MineCLIP embeddings.

  - **Classifier:** We use a Logistic Regression base estimator with standard scaling, _L_ 2 regularisation ( _C_ = 10), and
balanced class weights.

  - **Training:** We use the Elkan-Noto wrapper with a hold-out ratio of 0 _._ 2. Thresholds are calibrated via stratified group
cross-validation to maximise the F1 score.

The performance of the initiation models is reported in Tables 13a and 13b.

**Metric** **PU-Start** **PU-End**

Micro F1-Score 0.590 0.088
Macro Recall 0.761 0.409
Macro Precision 0.642 0.034
Overall Accuracy 0.913 0.980

_(a)_ Ground Truth Skills.

**Metric** **PU-Start** **PU-End**

Micro F1-Score 0.857 0.108
Macro Recall 0.830 0.324
Macro Precision 0.764 0.028
Overall Accuracy 0.981 0.965

_(b)_ HiSD Discovered Skills

_Table 13._ Comparison of PU Start and End Learning results for Minecraft skills. PU-End results are included to motivate the decision to

use initiation models only in Minecraft.

C.2.2. INTRA-OPTION POLICIES (BEHAVIOURAL CLONING)

To address partial observability and the temporal nature of the MineCLIP features, we utilise recurrent neural networks for
the skill policies.

  - **Architecture:** A Gated Recurrent Unit (GRU) with a hidden size of 512 and a single layer. The network outputs a
multi-discrete action vector (buttons, yaw, and pitch).

  - **Input:** Sequences of MineCLIP embeddings with a sequence length of 32 steps.

  - **Optimisation:** We use the AdamW optimiser with a learning rate of 3 _×_ 10 <sup>_−_</sup> <sup>4</sup> . We employ a composite loss function:
Binary Cross-Entropy for button presses and Cross-Entropy for discretised camera actions.

C.2.3. HIGH-LEVEL PPO CONTROLLER

The high-level policy is trained using Maskable PPO with an MLP policy acting directly on the MineCLIP embeddings.

  - **Observation Space:** 512-dimensional MineCLIP feature vectors.

  - **Action Masking:** Available options are restricted by the PU initiation models.

  - **Execution:** Upon selection, a skill option (driven by the GRU BC policy) executes for up to 64 steps (512 wall-clock
ticks) or until the episode terminates. Composite options extend this budget proportionally to the number of leaf nodes
in their sequence.

19

**<u>Unsupervised Hierarchical Skill Discovery</u>**

**C.3. Sample Efficiency in Action Labels**

A natural practical question is whether the discovered structures remain useful when only a small number of action-labelled
demonstrations are available for option learning. While skill discovery in HiSD is observation-only, the downstream BC
policies do require action labels. To probe this, we conduct a sweep on the Craftax Wooden Pickaxe task in which we vary the
number of action-labelled episodes _N_ used to train the BC and PU components, while keeping the downstream PPO budget
fixed at 100k environment steps. The sweep covers _N_ _∈{_ 10 _,_ 20 _,_ 30 _,_ 40 _,_ 50 _,_ 60 _,_ 70 _,_ 80 _,_ 90 _,_ 100 _,_ 200 _,_ 250 _,_ 300 _,_ 350 _,_ 500 _}_
and is run across 10 PPO seeds per configuration. We report the mean episode reward ( _±_ 1 SD) averaged over the final 10%
of training steps in Table 14.

_N_ **GT Skills** **HiSD Skills** **GT Hierarchy** **HiSD Hierarchy**

10 0.00 ( _±_ 0.00) **0.20** ( _±_ 0.40) 0.00 ( _±_ 0.00) 0.00 ( _±_ 0.00)
20 **0.10** ( _±_ 0.30) 0.00 ( _±_ 0.00) 0.00 ( _±_ 0.00) 0.00 ( _±_ 0.00)
30 **0.96** ( _±_ 0.04) 0.05 ( _±_ 0.14) 0.50 ( _±_ 0.49) 0.00 ( _±_ 0.01)
40 **0.90** ( _±_ 0.17) 0.11 ( _±_ 0.33) 0.08 ( _±_ 0.22) 0.00 ( _±_ 0.00)
50 0.00 ( _±_ 0.00) 0.00 ( _±_ 0.00) 0.00 ( _±_ 0.00) 0.00 ( _±_ 0.00)
60 **0.93** ( _±_ 0.12) 0.85 ( _±_ 0.32) 0.77 ( _±_ 0.43) 0.00 ( _±_ 0.00)
70 **0.75** ( _±_ 0.43) 0.00 ( _±_ 0.00) 0.67 ( _±_ 0.46) 0.00 ( _±_ 0.00)
80 0.87 ( _±_ 0.33) 0.95 ( _±_ 0.11) **0.98** ( _±_ 0.03) 0.86 ( _±_ 0.29)
90 0.31 ( _±_ 0.37) **0.67** ( _±_ 0.45) 0.18 ( _±_ 0.35) 0.00 ( _±_ 0.00)
100 0.42 ( _±_ 0.50) **0.82** ( _±_ 0.24) 0.00 ( _±_ 0.00) 0.30 ( _±_ 0.43)
200 0.56 ( _±_ 0.48) **0.84** ( _±_ 0.31) 0.78 ( _±_ 0.44) 0.11 ( _±_ 0.22)
250 0.63 ( _±_ 0.48) 0.84 ( _±_ 0.31) **0.95** ( _±_ 0.04) 0.94 ( _±_ 0.08)
300 0.29 ( _±_ 0.45) 0.74 ( _±_ 0.43) 0.95 ( _±_ 0.04) **0.96** ( _±_ 0.08)
350 0.70 ( _±_ 0.43) **0.98** ( _±_ 0.02) 0.93 ( _±_ 0.12) 0.98 ( _±_ 0.03)
500 0.76 ( _±_ 0.40) 0.97 ( _±_ 0.02) **0.99** ( _±_ 0.02) 0.97 ( _±_ 0.05)

_Table 14._ Final mean episode reward ( _±_ 1 SD) across 10 PPO seeds on the Craftax Wooden Pickaxe task as a function of the number of

action-labelled demonstration episodes _N_ used for BC and PU training. Values are averaged over the final 10% of PPO training steps.
The downstream RL budget (100k environment steps) is held fixed across all entries. Bold indicates the highest mean reward in each row.

The results show that the discovered hierarchies remain useful even with far fewer action labels. Both the GT and HiSD
hierarchical agents reach near-perfect reward with low variance by _N_ = 300 to 500, and the HiSD Hierarchy is already at
0 _._ 94 _±_ 0 _._ 08 by _N_ = 250, which is a fairly modest budget by current RL standards. The flat-skill variants tend to score above
zero at lower _N_ than their hierarchical counterparts. This is expected, since composite options chain BC policies together
and small per-skill errors compound across stages. Once the BC stage becomes reliable, the hierarchical configurations pull
ahead, matching the trend reported in Section 7.

The intermediate- _N_ regime is clearly non-monotonic. Standard deviations of around 0 _._ 4 to 0 _._ 5 at _N_ _∈{_ 30 _,_ 60 _,_ 70 _,_ 90 _,_ 200 _}_
come from bimodal seed-level outcomes: individual PPO runs either solve the task or collapse to zero, with little in between.
The full collapse at _N_ = 50 across all four configurations suggests this is a property of the BC stage rather than any specific
discovery method, since the same pathology hits the ground truth skills and hierarchy. We report the raw numbers without
smoothing because we think the bimodality is informative on its own. It indicates that the bottleneck at small _N_ is BC
sample complexity, not the quality of the discovered structure. The segmentation stage itself is fully unsupervised and
unaffected by _N_ .

20

**<u>Unsupervised Hierarchical Skill Discovery</u>**

**D. Evaluation of Discovered Skills and Hierarchies**

In this section, we evaluate the semantic quality and structural coherence of the skills learned by HiSD. First, we analyse the
method’s sensitivity to the skill count parameter _K_ in Appendix D.1. Subsequently, we examine the object-centric nature of
the skills discovered during the first phase of training in Appendix D.2. Finally, we present a qualitative comparison of the
hierarchies discovered by HiSD against baseline methods, providing visual examples from both the Craftax and Minecraft
domains in Appendix D.3.

**D.1. Effects of Varying** _K_

We investigate the impact of the skill budget _K_ on segmentation performance across Craftax tasks. As detailed in Table 15,
accurately estimating the underlying number of skills is generally required to maximise segmentation quality. In most cases,
setting _K_ to the ground truth value yields the best performance across Average mIoU, F1, and MoF metrics.

For example, in the _Stone_ _Pickaxe_ _Static_ task, peak performance is achieved at the ground truth of _K_ = 5. However,
we observe that the method is relatively robust to over-estimation; setting _K_ = 7 results in only a marginal decrease in
performance metrics. Similarly, for _Stone Pickaxe Random_, performance remains stable across _K_ _∈{_ 5 _,_ 6 _,_ 7 _}_ . This suggests
that in stochastic environments with high execution variance, the model can effectively utilise additional skill slots to capture
variations of the same underlying behaviour without suffering from collapse.

In contrast, tasks such as _WSWS Random_ and _Mixed Static_ exhibit higher sensitivity to _K_ . We observe a sharper drop
in performance when deviating from the optimal value, particularly when _K_ is underestimated. This indicates that for
highly structured or repetitive tasks, a precise skill budget is critical to prevent the merging of distinct primitives or the
fragmentation of coherent behaviours.

**Task** **K** **Avg.** **mIoU** **F1 Per** **F1 Full** **mIoU Per** **mIoU Full** **MoF Per** **MoF Full**

**Craftax**

WSWS
Random

**Craftax**
Stone Pickaxe

Static

**Craftax**
Stone Pickaxe

Random

**Craftax**

Mixed

Static

**2** 0.72 0.84 0.93 0.71 0.73 0.83 0.83

3 0.40 0.36 0.65 0.29 0.50 0.38 0.58

4 0.41 0.34 0.56 0.31 0.51 0.38 0.52

3 0.40 0.66 0.66 0.40 0.40 0.67 0.67

4 0.40 0.66 0.66 0.40 0.40 0.67 0.67

**5** 0.78 0.94 0.93 0.78 0.78 0.81 0.81

6 0.47 0.64 0.66 0.46 0.47 0.64 0.65

7 0.76 0.82 0.83 0.76 0.76 0.71 0.72

3 0.33 0.55 0.60 0.30 0.36 0.60 0.66

4 0.45 0.62 0.66 0.43 0.48 0.63 0.68

**5** 0.61 0.80 0.77 0.64 0.58 0.74 0.71

6 0.58 0.66 0.77 0.52 0.65 0.61 0.70

7 0.59 0.61 0.72 0.52 0.66 0.59 0.68

3 0.41 0.34 0.74 0.20 0.62 0.47 0.70

4 0.51 0.39 0.77 0.35 0.68 0.57 0.72

**5** 0.69 0.49 0.83 0.63 0.74 0.65 0.75

6 0.65 0.51 0.84 0.55 0.75 0.68 0.76

7 0.49 0.36 0.72 0.40 0.57 0.59 0.69

_Table 15._ Ablation study varying the number of skills ( _K_ ) in the HiSD framework. The row corresponding to the ground truth number of

skills for each task is highlighted in **bold** . Results are reported for a single random seed.

21

**<u>Unsupervised Hierarchical Skill Discovery</u>**

**D.2. Type of Skills Learnt by HiSD**

Figure 10 provides a qualitative visualisation of the skills discovered by HiSD. A key strength of the method is its ability
to learn object-centric behaviours that are robust to positional variance. As illustrated, HiSD consistently classifies the
interaction with trees as a unified “Wood” skill, regardless of the agent’s approach vector or specific location in the grid.
Furthermore, the model successfully disentangles semantically distinct actions even in cluttered environments; for instance, it
sharply distinguishes the “Table” interaction from “Wood” gathering, even when the workbench is placed in close proximity
to the trees.

_Figure 10._ **Qualitative visualisation of learned skill primitives in the Stone Pickaxe Static task.** The timeline shows part of a trajectory
where HiSD correctly clusters semantically similar interactions despite varying agent positions, while maintaining clear boundaries
between distinct activities.

**D.3. Graphical Results and Discussion of Experiments**

We compare the performance of three different skill segmentation and hierarchy induction frameworks: HiSD, OMPN (Lu
et al., 2021), and CompILE (Kipf et al., 2019), across a variety of tasks in the Craftax and Minecraft environments. These
tasks vary in complexity, planning horizon, and stochasticity. Refer to the main paper for full metrics achieved on each task.

Below we provide some visual examples from a selection of the tasks employed in order to graphically compare the
approaches. The combination of quantitative performance and qualitative interpretability across a range of task types
illustrates that HiSD is a highly effective approach for skill segmentation and hierarchy discovery. While OMPN and
CompILE occasionally perform well in deterministic scenarios, they rely heavily on manual annotation and lack the capacity
for semantic skill alignment. CompILE performs reasonably in structured tasks but falls short under noise and longer
temporal dependencies. HiSD’s flexible, automatic decomposition of skill hierarchies proves particularly valuable in
real-world, partially observable domains, such as Minecraft. We note that OMPN’s trees must be manually annotated and do
not perform any skill matching like HiSD.

  - Figure 11 shows results for the _Mixed_ _Static_ task. HiSD identifies an extra, erroneous skill segment, seen in its
discovered hierarchy (Figure 11C), which does not appear in the ground truth (Figure 11B). However, even though
there is an additional incorrect node, we note that this hierarchy is still more informative and interpretable than the one
discovered by OMPN, pictured in Figure 11D.

  - Figure 12 illustrates the _Stone_ _Pickaxe_ _Random_ task. Here, HiSD perfectly recovers the ground truth hierarchy
(Figure 12C vs. Figure 12B). In contrast, OMPN’s hierarchy (Figure 12D) flattens all actions into a single subtree,
lacking any semantic mapping to skill boundaries. These results underscore HiSD’s strength in handling noisy,
variable-length trajectories.

  - Figure 13 presents the _Wood-Stone Collection (Random)_ task. All models, HiSD, OMPN, and the ground truth agree
on the same decomposition (see Figure 13B–D), suggesting that this task’s structure is simple and deterministic enough
to allow for consistent interpretation by different methods.

  - Figure 14 examines the _Stone Pickaxe Static_ task. Although the ground truth (Figure 14B) defines a flat hierarchy, HiSD
extracts a more informative tree structure (Figure 14C), revealing alternate sequencing between sub-tasks. Meanwhile,
OMPN again falls into the same pattern observed in _Stone Pickaxe Random_, collapsing the hierarchy and introducing
unnecessary low-level actions such as redundant walking nodes (Figure 14D).

22

**<u>Unsupervised Hierarchical Skill Discovery</u>**

- Figure 15 visualises the _Minecraft_ _Mapped_ task. HiSD produces a concise and generally informative hierarchy
(Figure 15A) that, while not matching the ground truth exactly (Figure 15B), captures the overall skill flow and structure
effectively. Some incorrect nodes and hierarchy placements are present, but the segmentation is coherent and useful.
OMPN’s hierarchy is omitted due to its excessive complexity and size, again revealing its limitations in scalability. The
segmentation comparison (Figure 15C) further supports HiSD’s advantage in structural reasoning.

Truth

HiSD

OMPN

CmpILE

<u>Mixed : Static</u>

**(A)** Skill Segmentation Comparison

**(B)** Ground Truth Hierarchy

**(C)** HiSD Discovered Hierarchy

**(D)** OMPN Hierarchy (Manual Annotation)

_Figure 11._ Figures from the Mixed Static task where the goal is to build a wooden pickaxe. (A) shows the skill segmentation between

baselines. (B) is the ground truth tree, (C) is the tree discovered by HiSD, and (D) is the tree discovered by OMPN.

Truth

HiSD

OMPN

CmpILE

<u>Stone Pickaxe : Random</u>

**(A)** Skill Segmentation Comparison

**(B)** Ground Truth Hierarchy

**(C)** HiSD Discovered Hierarchy

**(D)** OMPN Hierarchy (Manual Annotation)

_Figure 12._ Figures from the Stone Pickaxe Random task where the goal is to build a stone pickaxe. (A) shows the skill segmentation

between baselines. (B) is the ground truth tree, (C) is the tree discovered by HiSD, and (D) is the tree discovered by OMPN. We see HiSD
matches the ground truth exactly, however, OMPN decomposes everything into one subtree (left), with no meaningful connection between
subtrees and skills.

23

**<u>Unsupervised Hierarchical Skill Discovery</u>**

<u>Wood, Stone, Wood, Stone : Random</u>

Truth

HiSD

OMPN

CmpILE

**(A)** Skill Segmentation Comparison

**(B)** Ground Truth Hierarchy

**(C)** HiSD Discovered Hierarchy

**(D)** OMPN Hierarchy (Manual Annotation)

_Figure 13._ Figures from the Wood-Stone Collection (Random) task where the goal in this case is to collect wood and stone, twice each, in

any order. (A) shows the skill segmentation between baselines. (B) is the ground truth tree, (C) is the tree discovered by HiSD, and (D) is
the tree discovered by OMPN. In this case we see all implementations find the same tree decomposition.

<u>Stone Pickaxe : Static</u>

Truth

HiSD

OMPN

CmpILE

**(A)** Skill Segmentation Comparison

**(B)** Ground Truth Hierarchy

**(C)** HiSD Discovered Hierarchy

**(D)** OMPN Hierarchy (Manual Annotation)

_Figure_ _14._ Figures from the Stone Pickaxe Static task where the goal in this case is to collect a stone pickaxe. (A) shows the skill

segmentation between baselines. (B) is the ground truth tree, (C) is the tree discovered by HiSD, and (D) is the tree discovered by
OMPN. In this case, we see that even though the ground truth is a flat hierarchy, due to HiSD finding alternate skill sequencing, it leads to
an informative hierarchy. OMPN exhibits the same pattern as in the Stone Pickaxe Random task (Figure 12), where almost the entire
decomposition happens under one sub-task, as well as unnecessary nodes being discovered (such as the many walking nodes).

24

**<u>Unsupervised Hierarchical Skill Discovery</u>**

**(A)** Hierarchy Discovered by HiSD for the Minecraft Mapped task.

**(B)** Ground Truth Hierarchy for the Minecraft mapped task.

<u>Minecraft Collect Stone (Mapped)</u>

Truth

HiSD

OMPN

CmpILE

**(C)** Skill Segmentation Comparison

_Figure 15._ Figures from the Minecraft Mapped task where the goal is to collect 2 stone blocks. (A) is the tree discovered by HiSD, (B) is

the ground truth tree, and (C) shows the segmentation info. We note that the tree discovered by OMPN is omitted due to its size.

25

**<u>Unsupervised Hierarchical Skill Discovery</u>**

**E. Hyperparameter Selection**

We conduct an extensive hyperparameter optimisation for HiSD using the Optuna framework (Akiba et al., 2019). The
search space, detailed in Table 18, encompasses both continuous and categorical parameters critical for training stability and
evaluation performance. Notably, parameters such as n-frames were tuned over broad ranges to accommodate the varying
trajectory lengths inherent to Craftax and Minecraft tasks. Furthermore, toggles for upper-bound constraints and feature
standardisation were included to ensure HiSD could adapt robustly to different levels of data variability. This comprehensive
sweep facilitated strong generalisation across diverse domains.

In contrast, the baselines (OMPN and CompILE) required narrower, predominantly categorical search spaces due to
their substantial computational overhead (see Table 16 and Table 17). For OMPN, tuning focused on training dynamics
(il ~~t~~ rain ~~s~~ teps, il ~~l~~ r) and memory slot allocation (nb ~~s~~ lots). Similarly, CompILE required careful adjustment
of KL regularisation coefficients ( _βz, βb_ ) and prior update rates. Due to extreme resource demands in the Minecraft
environment, baseline hyperparameters for those tasks were manually configured based on domain expertise rather than
automated sweeping. This disparity in tuning strategies further underscores the computational efficiency of HiSD.

The final selected hyperparameters for HiSD, CompILE, and OMPN across all tasks are reported in Tables 21, 20, and 19,
respectively.

**Parameter** **Choices**

il ~~t~~ rain ~~s~~ teps _{_ 500, 1000, 3000, 5000 _}_
il ~~l~~ r _{_ 1e-5, 1e-4, 1e-3, 1e-1 _}_
il ~~c~~ lip _{_ 0.1, 0.2, 0.3, 0.8 _}_
il ~~r~~ ecurrence _{_ 10, 20, 30, 40 _}_
hidden ~~s~~ ize _{_ 64, 128, 256 _}_
nb ~~s~~ lots _{_ 2, 3, 4, 5, 6 _}_

_Table_ _16._ OMPN hyperparameter search space (Craftax). All

parameters are categorical.

**Parameter** **Choices**

train ~~s~~ teps _{_ 500, 3000, 5000 _}_
learning ~~r~~ ate _{_ 1e-4, 1e-3, 1e-1 _}_
_βz_ _{_ 0.01, 0.1, 0.5, 1.0 _}_
_βb_ _{_ 0.01, 0.1, 0.5, 1.0 _}_
prior ~~r~~ ate _{_ 3, 5, 10 _}_
hidden ~~s~~ ize _{_ 64, 128, 256 _}_

_Table 17._ CompILE hyperparameter search space (Craftax). All

parameters are categorical.

**Parameter** **Type** **Range / Choices**

_α_ -train/eval Float [0 _._ 01 _,_ 1 _._ 0] (step 0.01)

_λ_ -frames-train/eval Float [0 _._ 01 _,_ 0 _._ 1] (step 0.01)

_λ_ -actions-train/eval Float [0 _._ 01 _,_ 0 _._ 1] (step 0.01)

_ϵ_ -train/eval Float [0 _._ 001 _,_ 0 _._ 5] (step 0.001)

radius-gw Float [0 _._ 001 _,_ 0 _._ 1] (step 0.001)

_ρ_ Float [0 _._ 001 _,_ 0 _._ 3] (step 0.001)

learning-rate Categorical _{_ 1e-5, 1e-4, 1e-3, 1e-2, 1e-1 _}_
weight-decay Categorical _{_ 1e-8, ..., 1e-1 _}_ (log scale)

n-epochs Int [5 _,_ 50] (step 5)

ub-frames/actions Bool _{_ True, False _}_
std-feats Bool _{_ True, False _}_

n-frames (Craftax) Int [5 _,_ 500] (step 5)

n-frames (Minecraft) Int [100 _,_ 30000] (step 100)

_Table_ _18._ HiSD hyperparameter search space used in the Optuna study. Ranges are continuous unless specified as categorical sets.
Task-specific ranges for n-frames are noted.

26

**<u>Unsupervised Hierarchical Skill Discovery</u>**

**Task** **H-Dim** **Clip** **LR** **Recur.** **Slots**

_Craftax_

WSWS Rand 64 0.8 1e-4 10 2
Stone Stat 128 0.8 1e-3 20 6
Stone Rand 128 0.2 1e-3 10 6
Mixed Stat 128 0.2 1e-3 40 4

_Minecraft_

All 128 0.8 1e-4 20 8
Mapped 128 0.8 1e-4 20 8

_Table 19._ **OMPN** hyperparameters used. Columns: Hidden Size,

Clip, LR, Recurrence, Slots.

**Task**

**Task** _βb_ _βz_ **LR** **Prior** **H-Dim**

_Craftax_

WSWS Rand 0.01 0.1 1e-4 3 128
Stone Stat 0.1 0.01 1e-4 10 256
Stone Rand 1.0 0.1 1e-4 10 256
Mixed Stat 0.1 0.01 1e-3 3 256

_Minecraft_

All 0.1 0.1 1e-4 30 128
Mapped 0.1 0.1 1e-4 30 128

_Table 20._ **CompILE** hyperparameters used. Columns: _βb_, _βz_, LR,

Prior Rate, Hidden Size.

**Craftax** WSWS (Rand) 0.08 0.14 0.17 0.31 0.07 0.03 0.01 0.08 1e-4 5 60 0.04 0.04 T F F 0.001
**Craftax** Stone (Static) 0.14 0.11 0.38 0.02 0.10 0.10 0.03 0.10 1e-4 30 135 0.10 0.18 T F F 0.001
**Craftax** Stone (Rand) 0.22 0.59 0.02 0.01 0.09 0.06 0.10 0.10 0.01 5 110 0.01 0.12 F F T 0.01
**Craftax** Mixed (Static) 0.21 0.03 0.05 0.001 0.10 0.09 0.01 0.01 1e-4 50 205 0.09 0.01 F T T 0.001

**Minecraft** All 0.60 0.66 0.44 0.08 0.06 0.10 0.08 0.06 1e-4 45 1800 0.01 0.12 T F F 0.1
**Minecraft** Mapped 0.95 0.23 0.34 0.07 0.01 0.03 0.02 0.07 1e-4 30 9100 0.01 0.16 F F F 0

_Table 21._ Final hyperparameters for HiSD Skill Segmentation.

27
