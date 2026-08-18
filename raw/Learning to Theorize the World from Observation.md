---
title: "Learning to Theorize the World from Observation"
source: "https://arxiv.org/abs/2605.03413"
author:
  - "[[Doojin Baek]]"
  - "[[Gyubin Lee]]"
  - "[[Junyeob Baek]]"
  - "[[Hosung Lee]]"
  - "[[Sungjin Ahn]]"
published: 2026-05-05
created: 2026-08-11
description: "NEO (Neural Theorizer) + the Learning-to-Theorize (L2T) paradigm: induce an executable compositional program (a learned Language of Thought) from a single raw observation pair (x,y), with no DSL, no program labels, no task grouping. Theory programmer q_phi(z_ik | s_k, y) is a goal-conditioned policy over VQ codebook primitives; a SHARED deterministic transition model f_theta(s_k, z_ik) supplies their semantics; MDL selects program length k* = argmin_k lambda^k * l(y, y_hat_k); a state-grounding loss ||s_k - sg[E(D(s_k))]||^2 keeps intermediate states on the observation manifold. Benchmark: OTIB (GridWorld / arithmetic factorization / CIFAR-10 image editing), alpha in {0.33,0.66,1.00} controls what fraction of compositions are seen in training; metrics are self-explainability and TRANSFERABILITY (induce theory from a support pair, execute on a query pair). Key numbers: GridWorld alpha=0.33 comp-OOD transfer NEO 0.933 vs Disc-Mono 0.000 / Cont-Mono 0.000 / Cont-Mono-Opt 0.000; length-OOD 0.845. Arithmetic length-OOD collapses to 0.019-0.038 with the amortized policy but recovers to 0.696-0.707 with NEO-S test-time sampling (B up to 1024, ~180x inference cost). Ablations: removing state grounding collapses everything to 0.000 (primitiveness 0.002); an OVER-COMPLETE codebook |E|=36 (vs 6 ground-truth primitives) does not hurt and slightly helps (0.976 comp-OOD); lambda_MDL=1.2 destroys primitiveness (0.213) by rewarding short entangled programs, 0.8-1.0 works. Baselines Disc-Mono = LAPO/Genie, Cont-Mono = AdaWorld. ICML 2026 Oral (PMLR 306), arXiv:2605.03413v2."
tags:
  - "clippings"
  - "vocabulary-co-discovery"
  - "program-induction"
  - "language-of-thought"
  - "compositional-generalization"
  - "world-models"
  - "mdl"
---

Title: Learning to Theorize the World from Observation
Venue: ICML 2026 (Oral; PMLR 306). Text below extracted from the arXiv v2 PDF.

Learning to Theorize the World from Observation
Doojin Baek * 1 Gyubin Lee * 1 Junyeob Baek 1 Hosung Lee 1 Sungjin Ahn 1
Abstract
What does it mean to understand the world? Con-
temporary world models often operationalize un-
derstanding as accurate future prediction in la-
tent or observation space. Developmental cogni-
tive science, however, suggests a different view:
human understanding emerges through the con-
struction of internal theories of how the world
works, even before mature language is acquired.
Inspired by this theory-building view of cogni-
tion, we introduceLearning-to-Theorize, a learn-
ing paradigm for inferring explicit explanatory
theories of the world from raw, non-textual ob-
servations. We instantiate this paradigm with the
Neural Theorizer (NEO), a probabilistic neural
model that induces latent programs as a learned
Language of Thought and executes them through
a shared transition model. In NEO, a theory is
represented as an executable, compositional pro-
gram whose learned primitives can be systemat-
ically recombined to explain novel phenomena.
Experiments show that this formulation enables
explanation-driven generalization, allowing obser-
vations to be understood in terms of the programs
that generate them.
1. Introduction
“Instead of trying to produce a programme to simulate
the adult mind, why not rather try to produce one which
simulates the child’s?”(Alan Turing, 1950)
In his seminal 1950 paper (Turing, 1950), Alan Turing sug-
gested that artificial intelligence (AI) should not aim first
to reproduce the fully developed adult mind, but instead to
understand how an intelligent mind could be learned from
its earliest stages. This child-centered view reframes the
goal of AI: rather than asking only how to imitate mature
*Equal contribution 1KAIST. Correspondence to: Sungjin Ahn
<sungjin.ahn@kaist.ac.kr>.
Proceedings of the 43 rd International Conference on Machine
Learning, Seoul, South Korea. PMLR 306, 2026. Copyright 2026
by the author(s).
intelligent behavior, it asks what kind of learning process
gives rise to such behavior in the first place.
A central insight from developmental cognitive science is
that children are not merely passive predictors of sensory
inputs or imitators of linguistic behavior. Long before ac-
quiring mature language, they appear to construct and revise
internal theories of how the world works (Goddu & Gop-
nik, 2024; Dragoi, 2024; Liang et al., 2025; Luettgau et al.,
2025). This view, often referred to as thetheory-theory
of cognitive development or thebaby as a scientistper-
spective (Gopnik et al., 1999), holds that early cognition is
guided by the discovery of structured, reusable, and com-
positional explanations of observed phenomena (Goddu &
Gopnik, 2024; Dautriche & Chemla, 2025). In this sense,
the child’s mind is not simply a machine for forecasting
what will happen next, but atheory-building systemthat
learns to explainhowandwhythe world changes.
This theory-building view of cognition points to a richer
notion of understanding: the construction of internalex-
planatory structuresthat capture how observations are gen-
erated and transformed. These structures should be reusable
across instances, compositional across novel situations, and
explicit enough to support intervention and counterfactual
reasoning (Lake & Baroni, 2023; Sch ¨olkopf et al., 2021).
This implies a learning objective beyond future prediction:
inferring the abstract mechanisms that explain them.
However, most contemporary AI systems, including recent
world models, are not designed around this objective. They
are primarily optimized for future prediction in latent or ob-
servation space, reconstruction quality, or task-specific per-
formance (Maes et al., 2026; Zhu et al., 2024; Hafner et al.,
2019). These objectives do not require models to discover
explicit, reusable mechanisms that explain how observations
are generated and transformed. Instead, they can often be
satisfied by learning entangled composite transformations
that capture correlations among observed inputs and out-
puts. Such representations lack the compositional structure
needed to systematically recombine familiar components
in unfamiliar ways, making them brittle under distribution
shift or compositional generalization tests (Chollet, 2019).
This gap highlights a central open problem:Can an artifi-
cial system learn to construct explicit explanatory theories
of the world merely by observing raw, non-textual sensory
1
arXiv:2605.03413v2  [cs.LG]  4 Jun 2026
Learning to Theorize
Figure 1.Learning to Theorize (L2T) Framework. (a)Training data consists of observation pairs (x, y)generated by unobserved true
programs.(b)Under L2T, the model learns to discover reusable primitives (Rotate, Left, Down, and Paint) and to compose them into
executable theories.(c)Without L2T, the model instead memorizes entangled composite primitives (e.g., Left-Down) as indecomposed
single units.(d)Once the model has learned to theorize, novel phenomena (e.g., Down-Paint-Rotate) can be explained by recombining
learned primitives.(e)In contrast, memorized entangled representations fail to generalize to unseen programs.
inputs?Addressing this problem requires a shift in learning
objectives: from fitting input–output mappings to discover-
ing structured, compositional mechanisms that explain how
observations are generated and transformed.
In this paper, we take a step toward this goal by introduc-
ingLearning-to-Theorize (L2T), a learning paradigm for
inducing explicit theories from observation alone. Rather
than learning task-specific predictors or policies, L2T aims
to inferprogrammatic explanationsof how observations
are generated and transformed. A theory is represented as
an executable, compositional program whose learned prim-
itives can be systematically recombined to explain novel
phenomena. Learning therefore targets reusable explanatory
structures—internal “mental programs” (Chater & Oaksford,
2013; Dehaene et al., 2022).
To instantiate this paradigm, we propose theNeural Theo-
rizer (NEO), a probabilistic neural model for inferring latent
executable programs from paired observations. Given an
observation pair (x, y), NEO induces a discrete program
as a learned Language of Thought (Fodor, 1975), and ex-
ecutes it through a shared transition model to reconstruct
the target observation y. By sharing primitive operations
and the executor across examples, NEO is encouraged to
discover reusable operations, compose them into structured
programs, and infer unseen compositions at test time, includ-
ing programs longer than those observed during training.
We view NEO as an instance of aWorld Theory Model: a
world model whose central object of inference is to discover
an executable theory of a phenomenon.
Unlike prior approaches that rely on symbolic supervi-
sion (Nye et al., 2020), task grouping (Chollet, 2019), or
explicit program annotations (Mao et al., 2019), NEO learns
solely from raw observation pairs. This makes it possible
to train on minimally curated observational data, such as
temporally separated frames from trajectories, without as-
suming language descriptions, task labels, or ground-truth
programs. At test time, NEO is evaluated not only by how
accurately it reconstructs target observations, but also by
whether its inferred programs transfer across distinct in-
stances generated by the same underlying mechanism. This
directly tests whether the model has learned a reusable the-
ory rather than an instance-specific mapping.
Our contributions are summarized as follows:
• We formulateLearning-to-Theorize (L2T)as a learning
paradigm for inferring executable theories from raw ob-
servations, without relying on language, task labels, or
program supervision.
• We proposeNEO, a probabilistic neural model that learns
a latent Language of Thought and induces compositional
executable programs as explanations of how observations
are generated and transformed.
• We introduce theObservation-to-Theory Induction
Benchmark (OTIB), a benchmark for evaluating whether
models can infer reusable theories from observation with-
out program supervision or task grouping.
• We demonstrate that NEO achieves explanation-driven
generalization by transferring inferred programs across
instances, recombining primitives into unseen program
compositions, and generalizing to programs longer than
those observed during training.
2. Learning to Theorize
We define the ability to theorize the world as the capacity to
(i)discover reusable abstract primitivesacross phenomena,
(ii)learn how to composethem into structured explanations
of complex observations, and (iii)explain novel phenom-
enaby forming new compositions of the same primitives.
While theories may be instantiated in various concrete forms
(e.g., natural language, probabilistic programs, or symbolic
programs), we formulateLearning-to-Theorize (L2T)as a
problem of latent neural program induction from observa-
tion, in which programs act as executable representations of
theories. Accordingly, we use the termstheoryandprogram
2
Learning to Theorize
interchangeably when no confusion arises. An overview of
the L2T framework is shown in Figure 1.
Phenomenon and Generative Process.We model aphe-
nomenonas a pair of observations (x, y), where x∼p(x) is
a source observation and y is a corresponding target obser-
vation. For example, x may represent an observation of an
apple hanging from a tree, while y represents an observation
of the apple after it has fallen to the ground. We assume that
each phenomenon is generated by an underlying but unob-
served program (or causal mechanism) τ that transforms x
toy, i.e.,p(y|x, τ).
Compositional Structure of Programs.Aprogramis
a compositional object formed by combining a finite set
of primitive operations, whose execution defines a struc-
tured transformation of observations. Formally, let Z=
{z1, z2, . . . , zM } denote a set of primitive operations, where
each primitive zi is associated with an execution function
fzi :X → X. A program (or theory) τ of length K is
defined as an ordered sequence of primitives,
τ= (z i1 , zi2 , . . . , ziK ), z ik ∈ Z.
Program execution corresponds to functional composition
of the associated primitive functions,
fτ =f ziK
◦f ziK−1
◦ · · · ◦fzi1 .
Given a source observation x, the target observation is ob-
tained by executing the program y=f τ (x), or more gen-
erally, by a conditional distribution p(y|x, τ) =p
 
y|
fτ (x)

. This formulation highlights that programs represent
compositional and reusable transformations of observations.
Compositional Generalization and Training Dataset.We
denote by Z ∗ the space of all finite-length sequences of
primitives inZ. Because the compositional program space
Z ∗ grows exponentially with program length, only a small
subset of all possible programs can be realized during train-
ing. We therefore assume that training data are generated by
a restricted subset Ttrain ⊂ Z∗
K, where Z ∗
K ⊂ Z∗ denotes
the set of programs of length at mostK.
The training dataset Dtrain ={(x n, yn)}N
n=1 consists of phe-
nomena generated as yn =f τn (xn) with τn ∼p train(τ)
and τn ∈ Ttrain. Importantly, the programs {τn} and their
associated functions {fτn } are latent and never observed;
only the resulting observation pairs (xn, yn) are available
for learning. Consequently, training seeks to jointly infer a
theory τ for each phenomenon and to learn a shared set of
execution functions that realize these theories.
This dataset assumption is highly general and requires mini-
mal task-specific curation. In a canonical world-modeling
setting, one may simply set xn =x tn and yn =x tn+t′n as
temporally separated observations, where both the time in-
dex tn and the time lag t′
n are unobserved. Unlike datasets
such as ARC-AGI (Chollet, 2019), which assume few-shot
groups of examples sharing the same underlying program,
our formulation imposes no such structure: Dtrain consists of
i.i.d. phenomena. Thus, the approach is directly applicable
to large-scale datasets.
Test-Time Generalization.At test time, we evaluate the
model on phenomena generated by programs drawn from
a disjoint subset Ttest satisfying Ttest ⊂ Z∗
K′ ⊂ Z∗, Ttest ∩
Ttrain =∅ , and K ′ > K. Thus, test-time evaluation requires
not onlycompositional generalizationto previously unseen
programs, but alsolength generalization, i.e., productivity,
to longer compositions than those realized during training.
Given a test phenomenon (x, y), the model must infer a
latent program ˆτthat explains the observation by compos-
ing previously learned primitives, ˆτ= arg maxτ∈T test p(τ|
x, y), with ˆτ /∈ Ttrain. We interpret successful inference in
this regime as evidence ofLearning-to-Theorize.
Evaluation: Program Transferability.We evaluate in-
duced theories at the execution level by testing whether
inferred programs act as reusable and transferable compo-
sitional explanations. At test time, we consider pairs of
phenomena (x(1), y(1)) and (x(2), y(2)) generated by the
same latent program τ∈ Ttest. The model first infers a
program ˆτfrom (x(1), y(1)) and then applies it to x(2) to
obtain ˆy(2) =D θ(fˆτ(x(2))). Performance is measured by
an observation-space error dobs(ˆy(2), y(2)). This protocol
assesses whether the learned theory captures a transferable
generative mechanism, rather than merely fitting individual
input–output pairs.
3. Neural Theorizer
To address the L2T problem, we propose the Neural Theo-
rizer (NEO), a probabilistic neural architecture that learns
to infer latent executable programs as theories from paired
observations; Figure 2 provides an overview of the architec-
ture.
3.1. Probabilistic Modeling
NEO is trained to maximize the conditional likelihood
pθ(y|x) . To explicitly model theory construction, we intro-
duce two latent variables: a programτ= (z i1 , . . . , ziK ) and
its execution trace s= (s 1, . . . , sK+1 ). Under a Markov
assumption, the conditional distribution is written as
pθ(y|x) =
Z
pθ(y|s K+1)p θ(τ, s|x)dτ ds.(1)
The prior over programs and execution traces factorizes
according to the following generative process:pθ(τ, s|x)
=p θ(s1 |x)
KY
k=1
pθ(zik |s k)p θ(sk+1 |s k, zik ).(2)
3
Learning to Theorize
Program Execution
Theory Programmer
Minimum Description
Figure 2.Computation graph of Neural Theorizer (NEO). NEO infers a latent program by iteratively selecting a primitive zik with the
theory programmer qϕ(zik |s k, y)and executing it via the transition model pθ(sk+1 |s k, zik). Each intermediate state sk is decoded
into a full reconstruction ˆyk =D θ(sk); through state grounding (Sec. 3.4), these intermediate predictions are explicitly regularized to
remain valid observations, preventing degenerate or blurry intermediate states. The MDL criterion selects the shortest accurate explanation
lengthk ∗ (green), which in turn provides a learning signal that favors short yet accurate program compositions (Sec. 3.3).
Here, pθ(s1 |x) defines an encoder mapping observations
to latent states, pθ(zik |s k) defines a theory programmer
that selects primitive operations, and pθ(sk+1 |s k, zik )
defines a shared Markov transition operator implementing
primitive execution. For simplicity, we assume a fixed pro-
gram length K; in Section 3.3, we introduce a method for
adaptive program length selection.
Since the marginalization in Eq. (1) is intractable, we in-
troduce a variational posterior qϕ(τ, s|x, y) to approxi-
mate the true posterior and optimize the evidence lower
bound (Kingma & Welling, 2013; Jordan et al., 1999):
logp θ(y|x)≥E qϕ(τ,s|x,y) [logp θ(y|s K+1 )]
−KL(q ϕ(τ, s|x, y)∥pθ(τ, s|x)).(3)
3.2. Theory Programmer
We define the variational posterior over programs and exe-
cution traces as follows:q ϕ(τ, s|x, y)
=p θ(s1 |x)| {z }
encoder
KY
k=1
qϕ(zik |s k, y)| {z }
theory programmer
pθ(sk+1 |s k, zik )| {z }
program execution
,(4)
where the encoder and the execution model are shared with
the generative model in Eq. (2).
Thetheory programmer qϕ(zik |s k, y)defines a goal-
conditioned policy over primitive operations. Given the
current latent state sk and the target observation y, it se-
lects the next primitive zik so as to steer the execution trace
toward a latent state that explainsy, thereby inducing a com-
positional program without explicit program supervision.
Concretely, we implement qϕ(zik |s k, y)as a neural net-
work that takes as input the current latent state sk and the
encoded target observation sy =E θ(y), and outputs a cat-
egorical distribution over M ′ primitive categories. Since
the true number of primitives M is unknown, M ′ is treated
as a hyperparameter. In practice, this discrete selection is
realized via a vector-quantized variational autoencoder (VQ-
V AE) (Van Den Oord et al., 2017), which provides a discrete
codebook E={e 1, . . . , eM ′} of primitive symbols while
enabling end-to-end training of the theory programmer.
Importantly, the primitives {zi} form the vocabulary of a
learnedLanguage of Thought: they are abstract symbols
without predefined semantics. Their meaning is not spec-
ifieda priori, but is induced through the shared execution
model, which assigns operational semantics by defining
how each symbol transforms latent states. In this way, NEO
jointly learns both thesyntaxof programs (how primitives
are composed) and theirsemantics(how these compositions
realize state transitions) directly from observation.
By iteratively applying the theory programmer and the
shared execution model, NEO constructs an explicit ex-
ecution trace s1 →s 2 → · · · →sK+1 that realizes the
inferred program as a sequence of latent state transitions.
The final state sK+1 is then decoded to reconstruct the target
observationˆyτ =D θ(sK+1).
3.3. Minimum Description Length Principle
Assuming a fixed program length K is unrealistic, as it
forces simple phenomena to be over-decomposed into un-
necessarily long programs, producing fine-grained primi-
tives with limited reuse and increasing the risk of overfitting.
To address this issue, we adopt the Minimum Description
Length (MDL) principle (Gr¨unwald, 2007) and assume that,
among competing explanations, the theory that generates
the shortest program provides the most compositional and
reusable set of primitives and their operations.
Specifically, we favor explanations that achieve both (i)
low reconstruction loss and (ii) short program length. Con-
4
Learning to Theorize
cretely, for each intermediate execution step k, we compute
a reconstruction ˆyk =D θ(sk) and select the theory length
k∗ = arg min
k∈{1,...,K+1}
λk
MDL ℓ(y,ˆyk),(5)
where λMDL >1 controls the strength of the simplicity
bias and penalizes longer programs exponentially. After
selecting the explanation length k∗, the model is updated
by backpropagating the loss in Eq. (3) only from the corre-
sponding predictionˆyk∗.
3.4. Practical Implementation
Deterministic execution.In the general formulation, prim-
itive execution is modeled as a stochastic state transition
pθ(sk+1 |s k, zik ). In this work, however, for simplicity
and training stability, we adopt a deterministic special case
and implement execution as sk+1 =f θ(sk, zik ), which
corresponds to a degenerate transition distribution with all
probability mass concentrated at a single next state. Un-
der deterministic execution, the likelihood reduces to a
reconstruction loss ℓ(y,ˆyτ )≡ −logp θ(y|x, τ) where
ˆyτ =D θ(fτ,θ (Eθ(x))).
State Grounding.A limitation of the formulation is that
intermediate states sk for k≤K are not required to corre-
spond to valid observations, as long as the final state sK+1
reconstructs y. We find that this flexibility hinders the dis-
covery of compositional program structure, since the model
may learn shortcut transitions that are not useful as reusable
building blocks. To address this issue, we ground each in-
termediate state to the encoder’s latent space by enforcing
consistency through a decode–encode cycle:
Lstate =
KX
k=1

sk −sg[E θ(Dθ(sk))]

2
.(6)
Here, sg[·] denotes the stop-gradient operator. This loss
updates only the transition model, encouraging each sk to
lie on the manifold of valid latent representations.
Training objective of the practical implementation.When
the discrete program τ is implemented using a VQ-V AE,
the variational KL term in Eq. (3) is not computed explic-
itly; instead, discreteness is enforced through the standard
codebook and commitment losses LVQ, resulting in the
following objective:
LNEO(θ, ϕ) =Eqϕ,θ(τ|x,y) [ℓ(y,ˆyτ )]
+λ vq LVQ +λ state Lstate.(7)
Given the MDL-selected program length k∗ from Eq. (5),
we optimize a truncated version of this objective by back-
propagating only through the corresponding prediction ˆyk∗
and ignoring all subsequent execution steps. This enforces
the MDL principle during learning by encouraging the
model to explain each phenomenon using the shortest accu-
rate program. Additionally, we use pretrained parameters for
the encoder and decoder for simplicity and stability. A de-
tailed description of the pretrained model is in Appendix F.
3.5. Inference at Test Time
At test time, NEO infers a theory for a previously unseen
phenomenon (x, y)by iteratively constructing a program
through the theory programmer. Starting from the initial
latent state s1 =E θ(x), the model sequentially selects prim-
itive operations according to qϕ(zik |s k, y)and applies the
transition model to obtain sk+1 =f θ(sk, zik ). Execution is
terminated when the reconstruction error falls below a pre-
defined threshold, ℓ(y,ˆyk)≤ε , at which point the current
program is returned as the inferred theory.
Because programs are constructed compositionally, this pro-
cedure naturally supportslength generalization: the model
can generate programs longer than those observed during
training simply by continuing the same primitive compo-
sition process. Moreover, inference permits explicitinter-
ventionby overriding the theory programmer’s primitive
selection, enabling exploration of counterfactual execution
traces and the discovery of novel program trajectories. Pseu-
docodes for both training and inference are provided in
Appendix B.
4. Related Works
In this section, we briefly discuss the related works while
providing a more detail discussion in the Appendix G. Our
work is related to several lines of research. First, latent ac-
tion and world models aim to learn compact latent dynamics
from observation-only data, including latent action models
such as LAPO (Schmidt & Jiang, 2024), AdaWorld (Gao
et al., 2025), LAPA (Ye et al., 2025), and Genie (Bruce
et al., 2024), as well as world models such as RSSM, and
Dreamer (Hafner et al., 2018; 2019; 2020; 2024). Second,
abstract reasoning benchmarks such as ARC-AGI (Chol-
let, 2019; Chollet et al., 2025; 2026) study program induc-
tion from few demonstrations under fixed representational
biases. Third, neural program induction and synthesis ap-
proaches, including NTM (Graves et al., 2014), NPI (Reed &
de Freitas, 2016), LEAPS (Trivedi et al., 2022), HPRL (Liu
et al., 2023), LPN (Macfarlane & Bonnet, 2025), and Dream-
Coder (Ellis et al., 2020), investigate learning executable
programs from input–output behavior, typically within pre-
defined symbolic program spaces. Finally, compositional
representation learning has been explored through adap-
tive tokenization (Duggal et al., 2024; 2025) and emergent
communication methods (Elberg et al., 2025), which learn
variable-length, compositional descriptions.
5
Learning to Theorize
Table 1.Performance comparison on the GridWorld envi-
ronment.Results show mean across three runs for each metric.
NEO-S is evaluated withB= 64budget.
αMethod In-distributionComp. OOD Length OOD
Self-Ex. Transf.Self-Ex. Transf.Self-Ex. Transf.
0.33
Disc-Mono 0.9880.983 0.000 0.000 0.000 0.000Cont-Mono 0.975 0.001 0.431 0.000 0.053 0.000Cont-Mono-Opt0.9940.000 0.726 0.000 0.209 0.000NEO (Ours) 0.914 0.911 0.934 0.933 0.853 0.845NEO-S (Ours)0.993 0.970 0.995 0.976 0.978 0.907
0.66
Disc-Mono 0.978 0.973 0.000 0.000 0.000 0.000Cont-Mono 0.979 0.000 0.929 0.000 0.531 0.000Cont-Mono-Opt0.991 0.000 0.972 0.000 0.805 0.001NEO (Ours) 0.966 0.965 0.964 0.963 0.930 0.927NEO-S (Ours)0.997 0.987 0.998 0.987 0.991 0.949
1.00
Disc-Mono 0.928 0.921 · · 0.000 0.000Cont-Mono 0.982 0.000 · · 0.673 0.000Cont-Mono-Opt0.992 0.000 · · 0.877 0.001NEO (Ours) 0.953 0.949 · · 0.902 0.898NEO-S (Ours)0.995 0.975 · · 0.986 0.926
Table 2.Performance comparison on the Arithmetic Factor-
ization Reasoning task.Results show mean across three runs for
each metric. NEO-S is evaluated withB= 1024budget.
αMethod In-distributionComp. OOD Length OOD
Self-Ex. Transf.Self-Ex. Transf.Self-Ex. Transf.
0.33
Disc-Mono 0.8900.668 0.005 0.004 0.012 0.009Cont-Mono 0.834 0.001 0.165 0.000 0.321 0.000Cont-Mono-Opt0.866 0.001 0.218 0.000 0.394 0.000NEO (Ours) 0.847 0.792 0.357 0.345 0.045 0.038NEO-S (Ours)0.857 0.809 0.831 0.759 0.620 0.524
0.66
Disc-Mono 0.737 0.572 0.005 0.002 0.006 0.004Cont-Mono 0.500 0.002 0.086 0.000 0.158 0.001Cont-Mono-Opt0.565 0.002 0.122 0.000 0.216 0.001NEO (Ours) 0.794 0.731 0.609 0.573 0.023 0.019NEO-S (Ours)0.977 0.939 0.994 0.959 0.766 0.696
1.00
Disc-Mono 0.662 0.475 · · 0.006 0.004Cont-Mono 0.810 0.000 · · 0.649 0.000Cont-Mono-Opt0.846 0.000 · · 0.743 0.000NEO (Ours) 0.724 0.675 · · 0.025 0.023NEO-S (Ours)0.990 0.954 · · 0.799 0.707
5. Experiments
Our experiments evaluate whether NEO can (1) discover
latent primitive operations that are never directly observed
during training and (2) explain dynamics arising from pre-
viously unseen program compositions. To this end, we
introduce the Observation-to-Theory Induction Benchmark.
5.1. Observation to Theory Induction Benchmark
Observation-to-TheoryInductionBenchmark (OTIB) eval-
uates whether a model can infer reusable primitives from
raw observation pairs (x, y)without supervision. Its central
criterion istransferable explanation: a theory induced from
one transition should generalize to new inputs, rather than
memorizing instance-specific mappings.
We define a training set and three evaluation sets: In-
Distribution (ID) test, compositional Out-of-Distribution
(OOD), and length OOD. Following SVIB-style (Kim et al.,
2023) compositional generalization, we consider all pro-
gram compositions within an observable complexity range
and include an α fraction of them in the training set (ID);
the remaining compositions in this range form the composi-
tional OOD set. We useα∈ {0.33,0.66,1.00}throughout
our experiments. Our sampling ensures that some primi-
tives are never observed in isolation and instead appear only
as parts of longer, entangled programs, requiring models
to discover them by decomposing multi-step hidden transi-
tions; smaller α increases this difficulty. By construction,
the training compositions alone contain sufficient evidence,
in principle, to recover the full primitive set via such decom-
position.
Each evaluation instance consists of asupportpair
(x(1), y(1)) and aquerypair (x(2), y(2)) generated by the
same latent program τ. Given the support pair, a model
induces a theory ˆτfrom (x(1), y(1)). The induced theory is
then executed on x(1) and x(2) to produce predictions ˆy(1)
and ˆy(2). We defineself-explainabilityas d(ˆy(1), y(1)) and
transferabilityas d(ˆy(2), y(2)), where d is a domain-specific
evaluation metric on outputs. Transferability specifically
tests whether the induced theory is reusable (i.e., general-
izes to new inputs) rather than encoding instance-specific
information abouty (1).
We instantiate OTIB in three domains: GridWorld, Arith-
metic Reasoning, and Image Editing.
GridWorldis a controlled 10×10 environment where an ob-
ject moves via latent motion primitives (up/down/left/right).
Training uses programs of length 1–3. We report composi-
tional OOD transfer under the resultingα-splits and evaluate
extrapolation to longer programs up to length 8. See Ap-
pendix C.3 for details.
Arithmetic Factorization Reasoningis a symbolic reason-
ing benchmark. Each observation is an integer pair (x, y),
where y is produced by applying a sequence of primitives
from {×2,×3,×5,×7} to x. We train on length 1–3 pro-
grams and use α to vary which compositions are included
in training versus held out. Evaluation covers compositional
OOD within lengths 1–3 and length OOD generalization to
programs of length 4–6. Details appear in Appendix C.5.
Image Editingis a visual transformation task on CIFAR-
10, where primitives correspond to 8 editing operations
(e.g., rotation, brightness adjustment, masking). Models are
trained on compositions of length 1–2. We then test compo-
sitional OOD transfer within lengths 1–2 and generalization
to longer edits of length 3–4. Implementation details are
deferred to Appendix C.6.
5.2. Baselines
Discrete Monolithic (Disc-Mono).A conditional VQ-V AE
that auto-encodes y conditioned on x, representing the pro-
6
Learning to Theorize
Figure 3.Comparison of image-editing performance across α-controlled dataset complexity and OOD settings, including length
OOD.NEO consistently outperforms baselines across all α-controlled OOD regimes and length OOD, for both self-explainability and
transferability, as measured by theℓ 1 distance between the predicted imageˆyand the ground-truth targety(lower is better).
gram as a single quantized vector. This corresponds to latent
action models such as LAPO (Schmidt & Jiang, 2024) and
Genie (Bruce et al., 2024).
Continuous Monolithic (Cont-Mono).A conditional β-
V AE (Higgins et al., 2016) that represents the program as a
single continuous latent vector z∈R d. This corresponds to
a latent action model such as AdaWorld (Gao et al., 2025).
Continuous Monolithic with Program Optimization
(Cont-Mono-Opt).This extends Cont-Mono by itera-
tively refining the program vector z via gradient ascent on
logp(y|x, z) , providing a stronger baseline with test-time
search, inspired by LPN (Macfarlane & Bonnet, 2025).
Note that while some baselines correspond to latent action
models, our focus is not on learning actions for control but
on discovering more abstract compositional primitives for
explanation and theory construction. We provide further
experimental details in Appendix C, D.3.
5.3. GridWorld Results
Table 1 reports performance across α-ratings on in-
distribution, compositional OOD, and length OOD tasks.
NEO consistently outperforms baselines, which largely fail
to generalize. Disc-Mono transfers well in-distribution (e.g.,
0.983 at α= 0.33) but collapses on OOD, suggesting that
single vector programs do not yield compositional under-
standing. Cont-Mono scores high on self-explainability
yet still show near-zero transfer, consistent with encoding
y-specific information in the latent rather than inducing a
reusable theory. In contrast, NEO maintains strong OOD
transfer even at the hardest setting (e.g., 0.933, 0.845 on
compositional, length OOD at α= 0.33), highlighting the
importance of Learning to Theorize. To further examine the
test-time scalability of our approach, we introduce NEO-
S, which augments NEO with a sampling-based test-time
search procedure. NEO-S further improves transferability
with test-time search; see Sec. 5.6 and Appendix D.1 for
details and additional comparative results.
x
y
 Cont-MonoDisc-Mono NEO (ours)
?
Cont-Mono-Opt
br p
mask
Figure 4.Visualization of explanations for a compositional
OOD in the image-editing task ( α= 0.66).The leftmost column
shows the observed source–target pair (x, y). Baseline models
generate y via a single-step prediction or by relying on action
combinations observed only in the in-distribution data, and thus
fail to decompose the novel OOD transformation. In contrast, NEO
explains the same phenomenon as a sequence of learned primitive
actions, enabling systematic OOD generalization through explicit
compositional explanations.
5.4. Arithmetic Factorization Reasoning Results
Table 2 reports performance on Arithmetic Reasoning across
different α-ratings. NEO consistently outperforms base-
line methods, demonstrating strong compositional gener-
alization even under partial training coverage (e.g., 0.345
at α=0.33 and 0.573 at α=0.66), indicating that it suc-
cessfully acquires reusable multiplicative primitives (see
Sec. 5.6 for more details).
Note that on this task, length OOD generalization is sub-
stantially more challenging: transitions such as x=73→
y=273,750 require inferring a six-step factorization (×5×
5×5×5×3×2 ) and executing exact multi-digit arith-
metic. Consequently, when relying solely on the learned
policy, NEO attains low length-OOD transfer accuracy
(0.019–0.038) but still outperforms monolithic baselines
(near-zero). Importantly, this limitation does not stem from
missing primitives but from the difficulty of selecting and
composing them correctly over longer horizons. The search-
based counterpart, NEO-S, addresses this by performing
7
Learning to Theorize
x y
k∗
=2
k∗
=2
fi1
fi2
fi1
fi1
fi2
v flip
h flip
br p
hue p
hue m
k∗
=1
Figure 5.Visualization of instance-wise program length selec-
tion under the MDL principle.For each instance, the model
selects an optimal program length k∗ that aligns with the ground-
truth number of underlying transitions, demonstrating adaptive
explanation length rather than a fixed horizon. In addition, the
selected programs recover semantically correct action sequences;
see Sec. C.6.1 for details on primitive definitions.
test-time search over program compositions (Fig. 6(b)), lead-
ing to dramatic performance gains. Test-time scaling boosts
length-OOD accuracy from approximately 0.02 to 0.696
at α=0.66 and 0.707 at α=1.00. The large gains from
test-time scaling suggest that NEO already learns the re-
quired primitives, and additional search mainly improves
their long-horizon recomposition.
5.5. Image Editing Results
Figure 3 shows that NEO consistently achieves the lowest
L1 distance ( ↓) on both compositional OOD and length
OOD across all α-ratings, indicating robust programmatic
understanding in high-dimensional continuous pixel space.
Figure 4 illustrates how NEO explains compositional ood
program: while baselines generate y via a single monolithic
vector program, NEO composes reusable primitives into
an executable theory (e.g.,brightness+followed bymask),
yielding faithful explanations even for previously unseen
phenomena. Finally, Figure 5 shows that NEO can automat-
ically select an optimal explanation length k∗, adapting the
complexity of the induced program to that of the underlying
transformation (see Appendix C.7 for more results.).
5.6. Analysis
Discovering Unseen Primitives.Figure 7 reports theprim-
itivenessof learned codes, measured by how well the primi-
tives induced by a model align with the ground-truth (GT)
primitive set (See Appendix C.2.2 for a detailed definition).
The GT bar reflects the fraction of primitives that are di-
rectly observable in training observations (relative to the full
primitive set); thus, a model that simply memorizes what is
observable can only appear comparable to GT. In contrast,
NEO consistently achieves much higher score—often ap-
proaching the full primitive set—even when only a small
Table 3.Ablations on grounding loss, codebook size ( |E|), and
λMDL.Without grounding loss, intermediate programs drift from
meaningful state space, leading to degradation. The codebook size
and the MDL weight control the expressive capacity of the program
space and the pressure toward shorter explanations, respectively,
inducing a trade-off between expressivity and program length.
Method Prim. In-distributionComp. OODLength OOD
Self-Ex. Transf.Self-Ex. Transf.Self-Ex. Transf.
NEO (Base) 1.000 0.914 0.911 0.934 0.933 0.853 0.845-No Grounding0.002 0.000 0.000 0.000 0.000 0.000 0.000
NEO +|E|=361.000 0.962 0.956 0.980 0.976 0.935 0.930-w/λMDL=1.2 0.213 0.732 0.621 0.228 0.160 0.221 0.169-w/λMDL=0.8 1.000 0.916 0.856 0.859 0.956 0.750 0.748
subset is directly observed (low α). This suggests that NEO
resolves theories into finer, reusable primitive units, provid-
ing the appropriate compositional building blocks.
Scaling at Test-time.Since the theory programmer qϕ(z|
s, y)is probabilistic, it can generate multiple plausible the-
ories from a single observation x→y , enabling test-time
search (denoted as NEO-S). Given a sampling budgetB, we
draw B candidate theories and select a single theory via ma-
jority voting (i.e., the most consistently supported candidate
among the samples for explaining the same x→y pair). We
then measure transferability by evaluating whether this one
selected theory generalizes to new inputs beyond the original
observation. Figure 6(a) shows that increasing B consis-
tently improves both self-explainability and transferability,
while monolithic baselines remain flat—demonstrating that
compositional structure enables effective test-time search.
Furthermore, because learned primitives are reusable and
composable, the program executor enables intervention at
the primitive level. By increasing the sampling tempera-
ture, we choose the primitive to intervene the world model,
enabling exploratory compositions—simulating transitions
only through latent states never encountered during training.
Figure 6 (b) visualizes how sampling-based search expands
the theory programmer’s choices on Arithmetic Factoriza-
tion: the blue edges trace the default argmax selections made
by the theory programmer, while the orange dashed edges
are alternative primitives sampled via exploration. This ex-
pands the search over program compositions from the same
x→y pair and increases the chance of finding a correct
execution path within a limited search budget. Figure 20
shows that this exploration further improves performance
when combined with sufficient budget.
5.7. Ablation Studies
To better understand what drives NEO’s strong empirical
behavior, we analyze key design choices: state grounding
loss and codebook size|E|with MDL weightλ MDL.
State grounding is essential.We found that removing
state grounding causes training to collapse, with primitive-
8
Learning to Theorize
(b)
Figure 6.(a)Test-time scaling via sampling on GridWorld. As the sampling budget increases, NEO approaches near-perfect accuracy,
while monolithic baselines fail to improve. Shaded regions show variability across runs. (b)Execution paths of sampled programs
on the Arithmetic Factorization Reasoning task. Test-time scaling is achieved by sampling diverse compositions of reusable learned
primitives. Black solid lines denote argmax selections by theory programmer; blue dashed lines denote sampled selctions from softmax
distribution induced by theory programmer. See Appendix E for more examples.
Figure 7.Primitiveness of learned codebook across tasks and
dataset complexity ( α).GT denotes the maximum achievable
primitiveness only with directly observed primitves.
ness dropping to 0.002 and both self-explainability and
transferability becoming zero across all splits. This sug-
gests that grounding anchors each intermediate state back to
the model’s state manifold, ensuring that subsequent primi-
tive operations are applied within a consistent representation
rather than drifting off-manifold into unstable latents.
Resolution of Theories.We also examine codebook size
|E| and the MDL weight λMDL. To rule out concerns that
our results depend on choosing |E| close to the ground
truth, we additionally test a highly over-complete code-
book. Even with substantial over-capacity (e.g., |E|= 36),
where the model could in principle allocate separate codes
to observed training compositions, NEO instead induces
primitive-level codes and composes them into multi-step
explanations. However, λMDL crucially shapes the learning
dynamics: whenλ MDL is too large (e.g.,1.2), the model is
incentivized to adopt overly short, entangled program expla-
nations, yielding low primitiveness and poor transferability.
Figure 8 clarifies this effect: the dashed GT line denotes the
program length obtained when each training composition
is explained using the ground-truth primitive program, and
λMDL ∈ {0.8,1.0}yields explanation lengths that closely
track this GT length. Together with primitiveness= 1.0 in
Table 3, this indicates that NEO recovers the full set of
underlying primitives—including those never directly ob-
served—and that the theory programmer composes them
into multi-step programs rather than memorizing observed
compositions. Additional details, including visualizations
of the role of each code, are provided in Appendix C.4.
6. Limitations & Discussion
This work should be viewed as an initial proof of concept
forLearning-to-Theorize. The current formulation assumes
a relatively small, discrete set of primitives and short pro-
gram lengths, which limits its scalability to domains with
long-horizon, continuous, or highly structured dynamics.
Moreover, primitive semantics are induced only through re-
construction, and therefore are not guaranteed to align with
human-interpretable concepts or truly causal factors. Our in-
ference procedure also relies on deterministic execution and
reconstruction-based stopping criteria, which may be brit-
tle under noise, ambiguity, or partial observability. Finally,
our experiments are restricted to controlled synthetic bench-
marks. Extending L2T to richer, real-world environments
with complex perceptual inputs, stochastic dynamics, and
open-ended theory spaces remains an important direction
for future work.
7. Conclusion
We introducedLearning-to-Theorize, a learning paradigm
in which models acquire explanatory theories by inducing
executable, compositional programs from observation. We
instantiated this paradigm with theNeural Theorizer (NEO),
a probabilistic neural model that learns reusable primitives
and composes them into latent programs to explain observed
phenomena. By representing theories as programs and reg-
ulating their complexity through the MDL principle, NEO
achieves explanation-driven generalization to unseen pro-
gram compositions and to programs longer than those ob-
served during training. Although our results are limited
to controlled settings, they provide a proof of concept that
structured, programmatic theories can be learned from raw
observations. More broadly, our findings point toward world
models that move beyond prediction-centric learning toward
explanatory, compositional understanding.
9
Learning to Theorize
Acknowledgements
This research was supported by the Brain Pool Plus Program
(No. 2021H1D3A2A03103645) and the GRDC (Global Re-
search Development Center) Cooperative Hub Program (RS-
202400436165) through the National Research Foundation
of Korea (NRF), funded by the Ministry of Science and ICT
(MSIT). The authors thank all the members of the Machine
Learning and Mind Lab (MLML) for their helpful discus-
sions and support. In particular, we are grateful to Hyeonseo
Cho, Minsu Kim, Mingyu Jo, Seungju Back, and Junyeong
Park for their valuable feedback and encouragement. SJ
thanks Yoshua Bengio for helpful discussions.
Impact Statement
This work introduces a new learning paradigm, Learning-
to-Theorize, and a model that induces executable theories
from observation. By shifting learning from direct predic-
tion toward the discovery of reusable explanatory structure,
this research may contribute to improved generalization,
interpretability, and abstraction in future AI systems, with
potential relevance to scientific modeling and world mod-
eling. The work is primarily methodological and does not
target applications involving human subjects, personal data,
or automated decision-making. As with other representation-
learning methods, the proposed approach could be misused
if applied without appropriate safeguards; however, we do
not identify risks specific to this contribution beyond those
generally associated with machine learning research. We
emphasize that this work is intended as a foundational study
of learning mechanisms rather than a deployment-oriented
system.
References
Andreas, J., Rohrbach, M., Darrell, T., and Klein, D. Neural
module networks, 2017. URL https://arxiv.org/
abs/1511.02799.
Bruce, J., Dennis, M., Edwards, A., Parker-Holder, J.,
Shi, Y ., Hughes, E., Lai, M., Mavalankar, A., Steiger-
wald, R., Apps, C., Aytar, Y ., Bechtle, S., Behbahani,
F., Chan, S., Heess, N., Gonzalez, L., Osindero, S.,
Ozair, S., Reed, S., Zhang, J., Zolna, K., Clune, J.,
de Freitas, N., Singh, S., and Rockt ¨aschel, T. Ge-
nie: Generative interactive environments, 2024. URL
https://arxiv.org/abs/2402.15391.
Chater, N. and Oaksford, M. Programs as causal models:
Speculations on mental programs and mental representa-
tion.Cognitive science, 37(6):1171–1191, 2013.
Chollet, F. On the measure of intelligence.arXiv preprint
arXiv:1911.01547, 2019.
Chollet, F., Knoop, M., Kamradt, G., and Landers, B. Arc
prize 2024: Technical report, 2025. URL https://
arxiv.org/abs/2412.04604.
Chollet, F., Knoop, M., Kamradt, G., and Landers, B. Arc
prize 2025: Technical report, 2026. URL https://
arxiv.org/abs/2601.10904.
Dautriche, I. and Chemla, E. Evidence for compositional
abilities in one-year-old infants.Communications Psy-
chology, 3(1):37, 2025.
Dehaene, S., Al Roumi, F., Lakretz, Y ., Planton, S., and
Sabl´e-Meyer, M. Symbols and mental programs: a hy-
pothesis about human singularity.Trends in Cognitive
Sciences, 26(9):751–766, 2022.
Dragoi, G. The generative grammar of the brain: a critique
of internally generated representations.Nature Reviews
Neuroscience, 25(1):60–75, 2024.
Duggal, S., Isola, P., Torralba, A., and Freeman, W. T.
Adaptive length image tokenization via recurrent alloca-
tion, 2024. URL https://arxiv.org/abs/2411.
02393.
Duggal, S., Byun, S., Freeman, W. T., Torralba, A., and
Isola, P. Single-pass adaptive image tokenization for min-
imum program search, 2025. URL https://arxiv.
org/abs/2507.07995.
Elberg, R., del Rio, F., Petrache, M., and Parra, D. A
compressive-expressive communication framework for
compositional representations, 2025. URL https://
arxiv.org/abs/2501.19182.
Ellis, K., Solar-Lezama, A., and Tenenbaum, J. Sampling
for bayesian program learning. InAdvances in Neural In-
formation Processing Systems 29: Annual Conference on
Neural Information Processing Systems 2016, December
5-10, 2016, Barcelona, Spain, pp. 1289–1297, 2016.
Ellis, K., Wong, C., Nye, M., Sable-Meyer, M., Cary, L.,
Morales, L., Hewitt, L., Solar-Lezama, A., and Tenen-
baum, J. B. Dreamcoder: Growing generalizable, inter-
pretable knowledge with wake-sleep bayesian program
learning, 2020. URL https://arxiv.org/abs/
2006.08381.
Feser, J. K., Brockschmidt, M., Gaunt, A. L., and Tarlow,
D. Differentiable functional program interpreters, 2017.
URLhttps://arxiv.org/abs/1611.01988.
Fodor, J. A.The language of thought, volume 5. Harvard
university press, 1975.
Gao, S., Zhou, S., Du, Y ., Zhang, J., and Gan, C. Ada-
world: Learning adaptable world models with latent
10
Learning to Theorize
actions, 2025. URL https://arxiv.org/abs/
2503.18938.
Goddu, M. K. and Gopnik, A. The development of human
causal learning and reasoning.Nature Reviews Psychol-
ogy, 3(5):319–339, 2024.
Gopnik, A., Meltzoff, A. N., and Kuhl, P. K.The scientist in
the crib: Minds, brains, and how children learn.William
Morrow & Co, 1999.
Graves, A., Wayne, G., and Danihelka, I. Neural turing
machines, 2014. URL https://arxiv.org/abs/
1410.5401.
Gr¨unwald, P. D.The minimum description length principle.
MIT press, 2007.
Hafner, D., Lillicrap, T., Fischer, I., Villegas, R., Ha, D.,
Lee, H., and Davidson, J. Learning latent dynamics for
planning from pixels.arXiv preprint arXiv:1811.04551,
2018.
Hafner, D., Lillicrap, T., Ba, J., and Norouzi, M. Dream to
control: Learning behaviors by latent imagination.arXiv
preprint arXiv:1912.01603, 2019.
Hafner, D., Lillicrap, T., Norouzi, M., and Ba, J. Mas-
tering atari with discrete world models.arXiv preprint
arXiv:2010.02193, 2020.
Hafner, D., Pasukonis, J., Ba, J., and Lillicrap, T. Master-
ing diverse domains through world models, 2024. URL
https://arxiv.org/abs/2301.04104.
Higgins, I., Matthey, L., Pal, A., Burgess, C., Glorot, X.,
Botvinick, M., Mohamed, S., and Lerchner, A. beta-
vae: Learning basic visual concepts with a constrained
variational framework. 2016.
Jordan, M. I., Ghahramani, Z., Jaakkola, T. S., and Saul,
L. K. An introduction to variational methods for graphical
models.Machine learning, 37(2):183–233, 1999.
Kim, Y ., Singh, G., Park, J., Gulcehre, C., and Ahn, S.
Imagine the unseen world: A benchmark for system-
atic generalization in visual world models, 2023. URL
https://arxiv.org/abs/2311.09064.
Kingma, D. P. and Welling, M. Auto-encoding variational
bayes.arXiv preprint arXiv:1312.6114, 2013.
Krizhevsky, A. and Hinton, G. Learning multiple layers of
features from tiny images.Master’s thesis, Department
of Computer Science, University of Toronto, 2009.
Lake, B. M. and Baroni, M. Generalization without sys-
tematicity: On the compositional skills of sequence-
to-sequence recurrent networks, 2018. URL https:
//arxiv.org/abs/1711.00350.
Lake, B. M. and Baroni, M. Human-like systematic general-
ization through a meta-learning neural network.Nature,
623(7985):115–121, 2023.
Lake, B. M., Ullman, T. D., Tenenbaum, J. B., and Gersh-
man, S. J. Building machines that learn and think like peo-
ple, 2016. URL https://arxiv.org/abs/1604.
00289.
Liang, Z., Glitz, L., Hefner, M. B., Lan, D., Klein-Flugge,
M., and Summerfield, C. Distinct roles of hippocampus
and neocortex in symbolic compositional generalization.
BioRxiv, pp. 2025–08, 2025.
Liu, G.-T., Hu, E.-P., Cheng, P.-J., yi Lee, H., and Sun,
S.-H. Hierarchical programmatic reinforcement learning
via learning to compose programs, 2023. URL https:
//arxiv.org/abs/2301.12950.
Luettgau, L., Chen, N., Erdmann, T., Veselic, S., Kurth-
Nelson, Z., Moran, R., and Dolan, R. J. A neural mech-
anism for compositional generalization of structure in
humans (version posted online april 19, 2025). 2025.
Macfarlane, M. V . and Bonnet, C. Searching latent pro-
gram spaces, 2025. URL https://arxiv.org/
abs/2411.08706.
Maes, L., Lidec, Q. L., Scieur, D., LeCun, Y ., and
Balestriero, R. Leworldmodel: Stable end-to-end joint-
embedding predictive architecture from pixels.arXiv
preprint arXiv:2603.19312, 2026.
Mao, J., Gan, C., Kohli, P., Tenenbaum, J. B., and Wu, J.
The neuro-symbolic concept learner: Interpreting scenes,
words, and sentences from natural supervision.Interna-
tional Conference on Learning Representations, 2019.
Nye, M., Solar-Lezama, A., Tenenbaum, J., and Lake, B. M.
Learning compositional rules via neural program synthe-
sis.Advances in Neural Information Processing Systems,
33:10832–10842, 2020.
Reed, S. and de Freitas, N. Neural programmer-interpreters,
2016. URL https://arxiv.org/abs/1511.
06279.
Ruis, L., Andreas, J., Baroni, M., Bouchacourt, D., and
Lake, B. M. A benchmark for systematic generalization
in grounded language understanding.Advances in neural
information processing systems, 33:19861–19872, 2020.
Schmidt, D. and Jiang, M. Learning to act without actions.
InInternational Conference on Learning Representations,
2024. Spotlight.
Sch¨olkopf, B., Locatello, F., Bauer, S., Ke, N. R., Kalch-
brenner, N., Goyal, A., and Bengio, Y . Toward causal
11
Learning to Theorize
representation learning.Proceedings of the IEEE, 109(5):
612–634, 2021.
Tenenbaum, J. B., Kemp, C., Griffiths, T. L., and Goodman,
N. D. How to grow a mind: Statistics, structure, and
abstraction.Science, 331(6022):1279–1285, 2011. doi:
10.1126/science.1192788.
Trivedi, D., Zhang, J., Sun, S.-H., and Lim, J. J. Learning
to synthesize programs as interpretable and generalizable
policies, 2022. URL https://arxiv.org/abs/
2108.13643.
Turing, A. M. Computing machinery and intelligence.Mind,
59(236):433–460, 1950. ISSN 00264423. URL http:
//www.jstor.org/stable/2251299.
Van Den Oord, A., Vinyals, O., et al. Neural discrete rep-
resentation learning.Advances in neural information
processing systems, 30, 2017.
Ye, S., Jang, J., Jeon, B., Joo, S., Yang, J., Peng, B., Man-
dlekar, A., Tan, R., Chao, Y .-W., Lin, B. Y ., Liden, L.,
Lee, K., Gao, J., Zettlemoyer, L., Fox, D., and Seo,
M. Latent action pretraining from videos, 2025. URL
https://arxiv.org/abs/2410.11758.
Zhu, Z., Wang, X., Zhao, W., Min, C., Li, B., Deng, N., Dou,
M., Wang, Y ., Shi, B., Wang, K., et al. Is sora a world
simulator? a comprehensive survey on general world
models and beyond.arXiv preprint arXiv:2405.03520,
2024.
12
Learning to Theorize
A. Use of Large Language Models
During the preparation of this manuscript, the authors used large language models (e.g., Claude, GPT-4) to assist with
refining prose, improving grammatical clarity, and enhancing readability. These tools were not used for generating scientific
ideas, experimental design, data analysis, or drawing conclusions. All content was critically reviewed, verified, and revised
by the authors, who take full responsibility for the final manuscript.
B. Pseudocode of NEO
Algorithm 1Training NEO (Neural Theorizer)
Require:Training setD train ={(x n, yn)}N
n=1, program priorp(τ), number of unroll stepsK, learning rateη
Require:EncoderE θ, decoderD θ, program inference networkq ϕ(τ|x, y), program execution networkf θ(s, z)
1:foreach training iterationdo
2:Sample a minibatch{(x, y)}fromD train
3:Encode observations:s 1 ←E θ(x),s y ←E θ(y)
4:fork= 1toKdo
5:Sample a primitive:z ik ∼q ϕ(zik |s k, sy)
6:Execute primitive:s k+1 ←f θ(sk, zik )
7:end for
8:Length selection:k ∗ ←arg mink λk
MDL ·ℓ(y, Dθ(sk))
9:Reconstruction loss:L rec ←ℓ(y, Dθ(sk∗ ))
10:State grounding loss:L state = PK
k=1 ∥sk −sg[E θ(Dθ(sk))]∥2
11:Total loss:L ← L rec +λ vqLvq +λ stateLstate
12:Update parameters:(ϕ, θ)←(ϕ, θ)−η∇ ϕ,θL
13:end for
Algorithm 2Inference with NEO: Transfer Evaluation
Require:Test example(x s, ys, xq, yq)(support input/output, query input/target)
Require:Trained encoderE θ, decoderD θ, program inferenceq ϕ, executionf θ
Require:Max program unroll stepsK, MDL coefficientλ MDL
1:// Phase 1: Support rollout (program extraction)
2:s 1 ←E θ(xs),s y ←E θ(ys)
3:fork= 1toKdo
4:z ik ←arg maxz qϕ(z|s k, sy){greedy action selection}
5:s k+1 ←f θ(sk, zik )
6:end for
7:// Length selection (shortest correct / MDL):
8:k ∗ ←arg mink λk
MDL ·ℓ(y s, Dθ(sk+1)){prefer shorter correct programs}
9:Extracted program:τ ∗ = (zi1 , . . . , zik∗ )
10:
11:// Phase 2: Transfer rollout (program application to query)
12:s ′
1 ←E θ(xq)
13:fork= 1tok ∗ do
14:s ′
k+1 ←f θ(s′
k, zik ){reuse extracted primitives}
15:end for
16:ˆyq ←D θ(s′
k∗+1)
17:returnˆy q, correct←(ˆy q =y q)
13
Learning to Theorize
Algorithm 3Test-Time Scaling with NEO (select@B)
Require:Test example(x s, ys, xq, yq), sampling budgetB, temperatureT
Require:Trained encoderE θ, decoderD θ, program inference networkq ϕ, execution networkf θ, codebookC
Require:Max unroll stepsK
1:// Phase 1: SampleBprograms on support pair
2:s 1 ←E θ(xs),s y ←E θ(ys)
3:forb= 1toBdo
4:s (b)
1 ←s 1
5:fork= 1toKdo
6:Compute logits:ℓ j =−∥q ϕ(s(b)
k , sy)−c j∥2/Tfor eachc j ∈ C
7:Sample:z (b)
ik ∼Softmax(ℓ){temperature-scaled sampling}
8:s (b)
k+1 ←f θ(s(b)
k , z(b)
ik )
9:end for
10:Length selection:k ∗
b ←arg mink λk
MDL ·ℓ(y s, Dθ(s(b)
k+1))
11:τ (b) ←(z (b)
i1 , . . . , z(b)
ik∗
b
)
12:end for
13:
14:// Phase 2: Filter and select
15:S ← {b|Dθ(s(b)
k∗
b +1) =ys}
16:ifS ̸=∅then
17:b ∗ ←arg maxb∈S |{b′ ∈ S |τ(b′) =τ (b)}| {most frequent program}
18:else
19:returnfailure
20:end if
21:
22:// Phase 3: Transfer
23:s ′
1 ←E θ(xq)
24:fork= 1tok ∗
b∗ do
25:s ′
k+1 ←f θ(s′
k, z(b∗)
ik )
26:end for
27:ˆyq ←D θ(s′
k∗
b∗ +1)
28:returnˆy q, correct←(ˆy q =y q)
C. Additional Experimental Details
C.1. Baselines
To evaluate the benefit of compositional program structure, we compare NEO against three baselines that represent programs
as monolithic vectors rather than as sequences of primitives. These baselines span different design choices: whether the
program representation is discrete or continuous, and whether inference is amortized or optimized at test time. Importantly,
while some baselines correspond to architectures used in latent action models for control, our focus is not on learning actions
for policy execution but on discovering compositional primitives for explanation and theory construction.
Discrete Monolithic (Disc-Mono).This baseline represents a program as a single quantized vector using a conditional
VQ-V AE architecture (Van Den Oord et al., 2017). Given an observation pair(x, y), the encoder maps the transformation
into a discrete codebook entry z∈ E={e 1, e2, . . . , e|E| }, where |E| is the codebook size. The program is thus a single
discrete symbol selected from a finite vocabulary, with no internal compositional structure. The decoder reconstructs y
from x and the selected codebook entry z. Training follows the standard VQ-V AE objective with commitment loss and
codebook update via codebook loss or exponential moving average. This architecture corresponds to latent action models
such as LAPO (Schmidt & Jiang, 2024) and Genie (Bruce et al., 2024), which learn discrete action representations from
observation pairs. This baseline tests whether a discrete but non-compositional representation suffices for generalization to
unseen program compositions.
14
Learning to Theorize
Continuous Monolithic (Cont-Mono).This baseline represents a program as a single continuous latent vector using a
conditional β-V AE architecture (Higgins et al., 2016). Given an observation pair(x, y), the encoder produces a Gaussian
posterior qϕ(z|x, y) =N(µϕ(x, y), σ2
ϕ(x, y)), where z∈R d serves as the program representation. The decoder reconstructs
yfromxandz. Training maximizes the ELBO:
L=E qϕ(z|x,y) [logp θ(y|x, z)]−βKL(q ϕ(z|x, y)∥p(z)),(8)
where p(z) =N(0, I)is a standard Gaussian prior andβ controls the strength of disentanglement pressure. Inference is fully
amortized: a single forward pass through the encoder produces z without iterative refinement. This architecture corresponds
to world models such as AdaWorld (Gao et al., 2025), which learn continuous latent dynamics from observations. This
baseline tests whether continuous representations without compositional structure can capture transferable transformations.
Continuous Monolithic with Optimization (Cont-Mono-Opt).This baseline extends Cont-Mono by optimizing the
program vector at test time rather than relying solely on amortized inference. Given a phenomenon (x, y), the latent vector
zis first initialized from the amortized encoder and then refined via gradient ascent on the reconstruction objective:
z(t+1) =z (t) +η∇ z logp θ(y|x, z(t)),(9)
where η is the learning rate and the optimization runs for a fixed number of steps. This provides a stronger baseline by
allowing the model to search for a better explanation at test time, while still lacking compositional structure. The architecture
corresponds to approaches such as Latent Program Network (LPN) (Macfarlane & Bonnet, 2025), which employ latent
optimization for improved inference. This baseline tests whether test-time optimization over a continuous latent space can
compensate for the absence of primitive decomposition, and whether the limitation of monolithic baselines stems from
amortization gap or from the lack of compositional structure itself.
C.2. Evaluation Metrics
C.2.1. CODE–PRIMITIVEALIGNMENTMETRIC
In this section, we report the code–primitive alignment metric, which quantifies how well each learned code in the codebook
corresponds to a ground-truth primitive operation. The goal of this metric is to evaluate whether the learned codes capture
meaningful and reusable primitives, rather than entangled or ambiguous transformations.
Formally, let Z=z i denote the set of learned codes and A=a j the set of ground-truth primitives. Given a test set of
N inputs (xn)N
n=1, we measure the alignment between code zi and primitive aj by counting how often applying zi to xn
produces an outcomey aj
n consistent with the effect ofa j:
Ci,j =
NX
n=1
1

M(zi, xn, yaj
n , aj)

,
where M(·) is a task-dependent matching criterion. The resulting matrix C∈R |Z|×|A| forms the code–primitive alignment
matrix.
The matching criterion differs across domains. (1) In GridWorld and Arithmetic Reasoning, where exact correctness is
well-defined, M counts a match if the predicted output exactly matches the ground-truth output at all pixels (or symbols). (2)
In Image Editing, where exact matches are ambiguous, we compare the output generated by each code against all candidate
ground-truth primitive combinations and count the primitive that yields the minimum reconstruction loss, resulting in a soft
alignment based on loss minimization.
C.2.2. ACTIONPRIMITIVENESS
To measure how completely the learned action space can reproduce the atomic (primitive) transformations of the environment,
we introduce theAction Primitivenessmetric.
Primitive Evaluation Dataset.We construct an evaluation dataset Dprim where each ground-truth primitive action g∈ G
is applied exactly once:
Dprim ={(x, y)|y=Oracle(x, g), g∈ G}(10)
15
Learning to Theorize
This dataset serves as a comprehensive testbed to verify whether the model can replicate every atomic transformation in the
environment.
Primitiveness Computation.For each input-output pair (x, y)∈ Dprim, we check whether there exists at least one learned
actiona∈ Athat can produce an output identical to the targety:
Primitiveness= 1
|Dprim|
X
(x,y)∈Dprim
max
a∈A
1[ˆya =y](11)
where ˆya =Dec(p ψ(Enc(x), a))is the reconstructed output obtained by applying learned action a through the transition
model, and 1[·] is the indicator function that returns 1 if the condition is satisfied and 0 otherwise. The equality ˆya =y
requires that all cells (pixels) of the generated output exactly match the target.
Interpretation.Action Primitiveness measures thecoverageof the learned action space over the ground-truth primitive
actions. A score of 1.0 indicates that the model has learned at least one action capable of reproducing each oracle primitive,
ensuring complete expressiveness. Conversely, a lower score reveals gaps in the learned action repertoire, where certain
atomic transformations cannot be replicated by any single learned action.
This metric complements Action Purity: while Purity measures whether each learned action corresponds to asingleoracle
action (one-to-one correspondence), Primitiveness measures whetheralloracle actions are covered by the learned action
space (completeness).
C.3. GridWorld Details
C.3.1. GRIDWORLDPRIMITIVES
In GridWorld, the environment consists of a10×10 grid with a single object. The object can be acted on by four ground-truth
motion primitives as shown in Table 4
Table 4.Ground-truth primitives used in the GridWorld task.
Primitive Description
move upMove the object one cell upward
move rightMove the object one cell to the right
move downMove the object one cell downward
move leftMove the object one cell to the left
C.3.2. GRIDWORLDTESTSETTING
Dataset Construction.We construct OTIB-GridWorld splits overshortprograms of length 1–3 ground-truth primitive
steps, and evaluatelength OODusinglongerprograms of length 4–8 steps. Following the (Kim et al., 2023)-style protocol,
we define a small set ofanchorprograms that are always included in training to ensure basic coverage of the underlying
space. In GridWorld, the anchors are the four “triple-move” programs that apply the same motion primitive three times (i.e.,
UUU, DDD, LLL, RRR); these anchors provide coarse coverage such that other short displacements can, in theory, be obtained
via interpolation within the short-program space. For each α, we then sample an α fraction of the remaining short programs
into training, and hold out the rest asCompositional OOD. For evaluation, we collect 5,000 compositional-OOD instances
perα, and a separate length-OOD set of 10,000 instances (shared acrossα-splits) generated from 4–8 step programs.
Max Transition Length K.For the GridWorld task, the training data includes compositions of up to three primitives, and
we set the max transition length to K= 4 during training. The same value is used for in-distribution and compositional
OOD inference. For length OOD evaluation, where transformations involve compositions of up to eight primitives, we
increase the max transition length toK= 10to allow the model to construct longer explanations.
(a)α= 0.33
16
Learning to Theorize
Training:Anchors)UUU, DDD, LLL, RRR. Randomly sampled)U, LU, DL, DR, DD, DDL, DRR.
Compositional OOD:L,R,D, LL, RR, UU, RU, RRL, LLU, DLL, RUU, DDR, RRU.
(b)α= 0.66
Training: Anchors: UUU, DDD, LLL, RRR . Randomly sampled: U, D, R, LU, DL, DR, UU, DD, RR,
LUU, LLU, DRR, DDR, RRU.
Compositional OOD:L, LL, DLL, RU, RUU, DDR.
(c)α= 1.00
Training:Anchors:UUU, DDD, LLL, RRR. All remaining programs are included.
Compositional OOD:None.
C.4. GridWorld Results
0 5K 10K 15K 20K
Step
1.0
1.5
2.0
2.5
3.0
3.5
4.0
Mean Explanation Length
MDL = 1.2
MDL = 1.0
MDL = 0.8
GT Length
Figure 8.Mean explanation length over training for different MDL weights λMDL. Larger λMDL encourages shorter explanations,
while smallerλ MDL yields longer explanations
Figure 9.Code–primitive alignment in GridWorld α= 0.33 (|E|= 6). Each row is a learned code and each column is a ground-truth
primitive transformation; counts indicate how often a code is assigned to a primitive. The near one-to-one structure shows that the
codebook captures primitive-level actions rather than entangled programs.
17
Learning to Theorize
Figure 10.Code–primitive alignment in GridWorld α= 0.33 (λMDL = 0.8). Each row is a learned code and each column is a
ground-truth primitive transformation; counts indicate how often a code is assigned to a primitive. The codebook captures primitive-level
actions rather than entangled programs.
18
Learning to Theorize
Figure 11.Code–primitive alignment in GridWorld α= 0.33 (λMDL = 1.0). Most learned codes align with the four ground-truth
motion primitives, indicating successful primitive recovery. Interestingly, a small number of codes capture short composite motions (e.g.,
right–down), suggesting that with a slightly weaker pressure toward multi-step decomposition, the codebook can also allocate capacity to
frequent entangled subroutines while largely preserving primitive-level structure.
19
Learning to Theorize
Figure 12.Code–primitive alignment in GridWorld α= 0.33 (λMDL = 1.2). In contrast to smaller λMDL, the mapping no longer exhibits
a near alignment with the four ground-truth motion primitives. Instead, many codes specialize tocomposite(entangled) transformations,
indicating that a largerλ MDL shifts learning toward memorizing short programs rather than recovering primitive-level actions.
20
Learning to Theorize
C.5. Arithmetic Factorization Reasoning Details
C.5.1. ARITHMETICFACTORIZATIONREASONINGPRIMITIVES
Table 5.Ground-truth primitives used in the Arithmetic Factorization Reasoning task.
Primitive Description
×2Multiply 2 to current number.
×3Multiply 3 to current number.
×5Multiply 5 to current number.
×7Multiply 7 to current number.
C.5.2. ARITHMETICFACTORIZATIONREASONINGTESTSETTING
Dataset Construction.We construct OTIB-Arithmetic withshortprograms of length 1–3 primitive steps, and evaluate
length OODonlongerprograms of length 4–6 steps. Following the SVIB (Kim et al., 2023)-style protocol, we define
anchorprograms that are always included in training: the 3 repeated-multiplication sequences ( ×2×2×2 , ×3×3×3 ,
×5×5×5 , ×7×7×7 ). Unlike OTIB-GridWorld, decomposing repeated multiplication into individual primitives is
non-trivial. For each α, we sample an α fraction of the remaining short programs into training and hold out the rest as
compositional OOD, stratified by program length. We evaluate on 1,000 compositional-OOD instances per program
combination per α, and 5,000 length-OOD instances (shared across α-splits) generated from 4–6 step programs. We report
held-out combinations for compositional OOD test in Table 6.
Max Transition Length K.For the Arithmetic Factorization Reasoning task, the training data includes compositions
of up to three primitives, and we set the max transition length to K= 3 during training. The same value is used for
in-distribution and compositional OOD inference. For length OOD evaluation, where transformations involve compositions
of up to 6 primitives, we increase the max transition length toK= 6to allow the model to construct longer explanations.
Table 6.Held-out programs for compositional OOD evaluation in OTIB-Arithmetic. Bold programs indicate single primitives that never
appear in isolation during training.
αHeld-out Programs
0.33×3 , ×5, ×2×5 , ×2×7 , ×3×5 , ×3×7 , ×2×3 2,
×22 ×5 , ×22 ×7 , ×2×3×7 , ×32 ×5 , ×2×5 2,
×2×7 2,×3×5×7,×3×7 2,×5×7 2
0.66×3 , ×3×5 , ×2×5 , ×3×7 2, ×22 ×7 , ×32 ×5 ,
×2×3×7,×2 2 ×5
1.00 None
21
Learning to Theorize
C.5.3. ARITHMETICFACTORIZATIONREASONINGRESULTS
Figure 13.Code–primitive alignment in Arithmetic Factorization Task α= 0.33 (|E|= 16 ). Despite being given an overcomplete
codebook, NEO discovers and utilizes only the true underlying primitives, demonstrating that the model learns to identify the minimal set
of reusable operations rather than exploiting excess capacity.
Figure 14.Code–primitive alignment in Arithmetic Factorization Task α= 0.66 (|E|= 16). Even with an overcomplete codebook, NEO
learns to use only the true underlying primitives, identifying the minimal set of reusable operations rather than exploiting excess capacity.
22
Learning to Theorize
Figure 15.Code–primitive alignment in Arithmetic Factorization Taskα= 1.00(|E|= 16).
23
Learning to Theorize
C.6. Image Editing Details
C.6.1. IMAGEEDITINGPRIMITIVES
Table 7.Ground-truth image editing primitives used in the Image Editing task.
Category Primitive Description
Brightnessbrightness plus(br p)Increase brightness by a factor of 1.5
brightness minus (br m)Decrease brightness by a factor of 0.5
Huehue plus(hue p)Rotate hue by +0.3 on the color wheel
hue minus(hue m)Rotate hue by−0.3on the color wheel
Fliphorizontal flip(h flip)Flip image horizontally (left–right)
vertical flip(v flip)Flip image vertically (top–bottom)
Othersrotation(rot)Rotate image by90 ◦ clockwise
masking(mask)Apply a gray (128) square mask to the top-left quadrant (25% of image size)
C.6.2. IMAGEEDITINGTESTSETTING
Dataset Construction.The image editing dataset is constructed based on CIFAR-10 (Krizhevsky & Hinton, 2009),
following the official train–test split. Each sample is generated by applying one or more editing primitives to an input
image, and only transformations whose pixel-wise difference exceeds a predefined threshold are retained to ensure semantic
relevance. We consider a total of 8 primitives, summarized in Table 7. Action sequences are composed under a canonical
ordering to avoid redundant permutations.
IID and OOD settings are defined by the set of primitive compositions observed during training. In the IID and OOD splits,
sequences of length one or two are used, while the Length-OOD setting consists of longer compositions of three to four
primitives. The parameter α controls the fraction of compositions included in the IID set, with smaller α inducing more
severe distribution shifts. Only canonical compositions that produce sufficiently large transformations are included. All IID
and OOD composition cases are listed in Tables 8, 9, and 10 forα= 0.33,0.66, and1.0, respectively.
Table 8.IID and OOD combinations forα= 0.33.
Split Category Combinations
IID Level 1[horizontal flip],[masking],[vertical flip]
Level 2[br m, br m], [br p, br p], [hue m, hue m],
[hue p, hue p], [rot, rot] , [br m, hue m],
[br m, hue p], [br m, mask] , [br m, rot] , [br m,
v flip], [br p, hue m], [br p, hue p], [h flip,
rot],[hue p, mask],[rot, v flip]
OOD Level 1brightness minus, brightness plus, hue minus,
hue plus,rotation
Level 2[br m, h flip], [br p, h flip], [br p, mask] ,
[br p, rot] , [br p, v flip], [h flip, hue m],
[h flip, hue p], [h flip, mask] , [h flip,
v flip], [hue m, mask] , [hue m, rot] , [hue m,
v flip], [hue p, rot] , [hue p, v flip], [mask,
rot],[mask, v flip]
24
Learning to Theorize
Table 9.IID and OOD combinations forα= 0.66.
Split Category Combinations
IID Level 1[horizontal flip], [masking], [vertical flip],
[brightness plus],[hue plus]
Level 2[br m, br m], [br p, br p], [hue m, hue m],
[hue p, hue p], [rot, rot] , [br m, h flip],
[br m, hue m], [br m, hue p], [br m, mask] ,
[br m, rot] , [br m, v flip], [br p, h flip],
[br p, hue m], [br p, hue p], [br p, rot] ,
[h flip, hue p], [h flip, rot] , [hue m, mask] ,
[hue m, rot] , [hue m, v flip], [hue p, mask] ,
[hue p, v flip],[rot, v flip]
OOD Level 1[brightness minus],[hue minus],[rotation]
Level 2[br p, mask] , [br p, v flip], [h flip, hue m],
[h flip, mask] , [h flip, v flip], [hue p, rot] ,
[mask, rot],[mask, v flip]
Table 10.Full list of IID combinations forα= 1.0.
Category Combinations
Level 1 (IID)[rotation] , [horizontal flip], [masking], [vertical flip],
[brightness minus], [brightness plus], [hue minus],
[hue plus]
Level 2 (IID)[br m, br m], [br p, br p], [hue m, hue m], [hue p, hue p],
[rot, rot] , [br m, hue m], [br m, hue p], [br m, mask] ,
[br m, rot] , [br m, v flip], [br p, hue m], [br p, hue p],
[h flip, rot] , [hue p, mask] , [rot, v flip], [br m,
h flip], [br p, h flip], [br p, mask] , [br p, rot] , [br p,
v flip], [h flip, hue m], [h flip, hue p], [h flip, mask] ,
[h flip, v flip], [hue m, mask] , [hue m, rot] , [hue m,
v flip], [hue p, rot] , [hue p, v flip], [mask, rot] , [mask,
v flip]
Length-OOD Setting.The Length-OOD dataset consists of compositions of three to four primitives, which are never
observed during training. After canonicalization, we obtain 79 valid compositions for length three (from 512 permutations)
and 152 for length four (from 4096 permutations), yielding a total of 231 valid combinations. As in the IID/OOD splits,
only transformations exceeding the difference threshold are retained.
Max Transition Length K.For the Image Editing task, training data consists of compositions of one or two primitives,
and we therefore set K= 3 during training. The same setting is used for in-distribution and compositional OOD inference.
For length OOD evaluation, where transformations involve compositions of three or four primitives, we increase the max
transition length toK= 6to accommodate longer explanations.
C.7. Image Editing Results
C.7.1. FULLPERFORMANCE COMPARISON.
As shown in Table 11, our method consistently outperforms the baselines across most evaluation settings, not only in
self-explainability but also in transfer performance, particularly under out-of-distribution conditions.
For reference, a trivial identity baseline (L1 distance between x and y) yields 0.212 under compositional OOD and 0.271
under length OOD, whereas NEO achieves substantially lower errors in the range of 0.09–0.12.
25
Learning to Theorize
Table 11.Performance comparison on the Image Editing environment.Results show mean across three runs for each metric.
αMethod In-distribution Comp. OOD Length OOD
Self-Ex. Transf. Self-Ex. Transf. Self-Ex. Transf.
0.33
Disc-Mono 0.060.06 0.16 0.17 0.18 0.19
Cont-Mono 0.050.08 0.14 0.17 0.16 0.19
Cont-Mono-Opt 0.050.08 0.13 0.16 0.16 0.19
NEO (Ours) 0.06 0.07 0.11 0.12 0.12 0.13
0.66
Disc-Mono 0.070.07 0.14 0.15 0.16 0.17
Cont-Mono 0.060.13 0.13 0.18 0.15 0.21
Cont-Mono-Opt 0.060.13 0.12 0.18 0.14 0.21
NEO (Ours) 0.07 0.07 0.09 0.09 0.11 0.11
1.00
Disc-Mono 0.08 0.08 · · 0.16 0.17
Cont-Mono 0.060.12 · · 0.13 0.18
Cont-Mono-Opt 0.060.12 · · 0.12 0.18
NEO (Ours) 0.07 0.07 · · 0.10 0.10
C.7.2. CODE–PRIMITIVEALIGNMENTMATRIX.
For the Image Editing experiments, we construct a code–primitive alignment matrix by selecting, for each code, the ground
truth primitive action with the lowest reconstruction loss. In addition to comparing against all action primitives present in
the dataset, we include a no-operation primitive corresponding to the original image. This allows the confusion matrix to
capture both meaningful action alignments and cases where a code represents identity-preserving transformations.
(a) α= 0.33.As shown in Figure 16, when α= 0.33, the model successfully discovers three distinct primitive codes,
despite five primitive operators being entirely absent from the IID dataset. This demonstrates the model’s ability to induce
meaningful primitives from limited and incomplete supervision
Alpha = 0.33 , NEO (ours) 
Figure 16.Code–primitive alignment in Image Editingα= 0.33.
(b) α= 0.66.As shown in Figure 17, when α= 0.66, the model correctly recovers all three missing primitive operators
that are not directly observed in the IID dataset. This highlights its capacity to decompose composed transformations and to
identify reusable, general-purpose action primitives underlying observed phenomena.
26
Learning to Theorize
Alpha = 0.66 , NEO (ours) 
Figure 17.Code–primitive alignment in Image Editingα= 0.66.
(c) α= 1.0.As shown in Figure 18, when α= 1.0, the model consistently recovers all primitive codes, even though all
actions are uniformly represented in the dataset. Notably, the learned codebook aligns with the most elementary action
primitives, indicating a preference for minimal and fundamental explanations.
Alpha = 1.0, NEO(ours)
Figure 18.Code–primitive alignment in Image Editingα= 1.0.
27
Learning to Theorize
D. Additional Analysis
D.1. Test Time Scaling
GridWorldWe conduct test-time scaling on GridWorld by sampling B∈ {1,2,4,8,16,32,64} candidate theories from
the probabilistic theory programmer and selecting a single theory via majority voting before transfer. We report both
self-explainability and transferability in Figure 19; importantly, majority voting is performed over theories induced from the
same observationx→yand does not use any additional supervision.
Figure 19.Test-time scaling results on GridWorld domain.
D.2. Arithmetic Factorization Reasoning
Arithmetic Factorization ReasoningWe conduct test-time scaling on Arithmetic Factorization Reasoning by sampling
B∈ {1,4,16,64,256,1024} candidate theories from the probabilistic theory programmer and selecting a single theory
via majority voting before transfer. We report transferability in Figure 20; importantly, majority voting is performed over
theories induced from the same observationx→yand does not use any additional supervision.
28
Learning to Theorize
10 1
 100 101
Sampling T emperature
0.0
0.1
0.2
0.3
0.4
0.5
0.6
0.7
0.8select@B Accuracy (trans)
T est-Time Scaling: Accuracy vs T emperature (Length OOD)
B=1
B=4
B=16
B=64
B=256
B=1024
Figure 20.Test-time scaling on Arithmetic Reasoning (Length OOD).Transfer accuracy improves with both sampling budget B
and temperature, demonstrating that NEO’s compositional structure enables effective test-time scaling. Higher temperatures encourage
exploration of diverse primitive compositions, while larger budgets increase the probability of finding correct programs.
D.3. Computational Resource Analysis
Computational Cost.We note that theory induction prioritizes the quality of the discovered explanation over inference
speed. Nevertheless, computational efficiency remains an important practical consideration, and we provide a detailed
comparison across methods.Disc-Mono / Cont-Monoperform a single forward pass.Cont-Mono-Optadditionally
performs iterative gradient-based optimization of the program vector at inference time.NEOperforms K sequential forward
passes through the transition network.NEO-Srepeats the K-step rollout B times with different sampled programs, scaling
asO(K×B). Within each domain, all methods share the same pretrained encoder and decoder.
GridWorld (NVIDIA RTX 3090, batch size 128).
Table 12.Computational cost comparison on GridWorld.
Method Train (ms/batch) Total Train Time (s) Inference (ms/batch)
Disc-Mono 49.8 5,835 (150 ep) 28.3
Cont-Mono 50.2 5,882 (150 ep) 26.6
Cont-Mono-Opt – – 91.2
NEO (Ours) 75.4 5,890 (100 ep) 41.1
NEO-S (B= 8) – – 42.5
NEO-S (B= 64) – – 174.0
Arithmetic Factorization Reasoning (NVIDIA RTX 4090, batch size 512).
Table 13.Computational cost comparison on arithmetic reasoning.
Method Train (ms/batch) Total Train Time (s) Inference (ms/batch)
Disc-Mono 25.0 9,920 (200 ep) 13.0
Cont-Mono 23.1 9,900 (200 ep) 12.1
Cont-Mono-Opt – – 178.9
NEO (Ours) 78.9 14,300 (200 ep) 27.5
NEO-S (B= 8) – – 42.1
NEO-S (B= 1024) – – 4867.3
Image Editing (NVIDIA RTX 4090, batch size 64).
29
Learning to Theorize
Table 14.Computational cost comparison on image editing.
Method Train (ms/batch) Total Train Time (s) Inference (ms/batch)
Disc-Mono 58.7 26,816 (50 ep) 24.53
Cont-Mono 50.1 22,925 (50 ep) 23.41
Cont-Mono-Opt – – 571.35
NEO (Ours) 106.7 48,779 (50 ep) 38.06
Overall, NEO incurs approximately 2× higher training cost than single-pass baselines due to sequential transitions. At
inference time, it is slower than single-pass methods but significantly more efficient than gradient-based optimization (Cont-
Mono-Opt). For NEO-S, the additional cost from repeated sampling directly trades off with improved out-of-distribution
generalization.
Dataset Sizes.We report the number of training and evaluation examples across domains, including in-distribution (ID),
compositional OOD, and length OOD settings.
GridWorld.
Table 15.Dataset sizes for GridWorld.
Setting Train ID Test Comp. OOD Test Length OOD Test
α= 1.00100,000 10,000 – 20,000
α= 0.66100,000 10,000 10,000 20,000
α= 0.33100,000 10,000 10,000 20,000
Arithmetic Factorization Reasoning.
Table 16.Dataset sizes for arithmetic reasoning.
Setting Train ID Test Comp. OOD Test Length OOD Test
α= 1.00279,611 27,961 – 15,317
α= 0.66206,520 20,651 80,401 15,317
α= 0.33147,968 14,796 146,306 15,317
Image Editing.
Table 17.Dataset sizes for image editing.
Setting Train ID Test Comp. OOD Test Length OOD Test
α= 1.001,170,000 234,000 – 393,886
α= 0.661,120,000 224,000 440,000 393,886
α= 0.33720,000 144,000 840,000 393,886
E. Visualization Results
In this section, we visualize the model’s rollout results to qualitatively analyze NEO’s behavior.
30
Learning to Theorize
E.1. GridWorld
Figure 21.NEO visualization on length OOD task.
E.2. Arithmetic Factorization Reasoning
x5
x3 x3
x3 x2 x3
x3
x2
x3
x3
x2
x2
x3
x5
x2
x2
x3
x5
x2 x3
x5
x5
x2x2
x5
x5
000166
x
000830 002490 007470
000498 000996 002988
008964
004980
014940
044820
000332 000664 005976
017928 089640
y
029880089640
y
Input Step 1 Step 2 Step 3 Step 4 Step 5 Step 6
Sample 2 | Target: 089640
Input Correct Incorrect Argmax Sampled
x3
x3 x3
x2
x3 x3
x2 x3x3
x2
x3
x2
x2
003326
x
009978 029934 089802
006652 019956 059868
179604
269406
538812
y
538812
y
Input Step 1 Step 2 Step 3 Step 4 Step 5
Sample 17 | Target: 538812
Input Correct Incorrect Argmax Sampled
Figure 22.NEO visualization on length OOD task. Sampled with budgetB= 1024and temperatureτ= 1.0.
31
Learning to Theorize
F . Model Hyperparameters
For reproducibility, we report the hyperparameters used in all experiments. The settings were guided by prior work and
empirical validation to ensure stable training and consistent evaluation. We use largely shared hyperparameters across tasks,
introducing task-specific configurations only when necessary, as detailed in the respective sections.
We briefly describe the pretraining setup used to define the latent space for our method. For GridWorld and Image Editing,
we employ a CNN-based variational autoencoder (V AE) to learn latent representations prior to training. In contrast, for
Arithmetic Reasoning, we directly learn embedding vectors and perform all operations within the resulting latent space.
Detailed hyperparameter configurations for pretraining and reconstruction are provided below.
For Arithmetic Reasoning and Image Editing, we apply a linear scheduling of the MDL length penalty λMDL over the course
of training, enabled when use λMDL scheduling is set to true. Specifically, λMDL is annealed linearly from λstart
MDL to λend
MDL.
This design encourages the model to first discover and stabilize primitive operations during early training, and subsequently
to compose them into explanations whose length adapts to the underlying complexity of the transformation.
F .1. GridWorld
Table 18.Pretraining hyperparameters for the state V AE in GridWorld experiments. The same pretrained model is used for NEO and all
baselines.
Hyperparameter Value
Training
Learning Rate5e−3
Weight Decay1e−2
LR Scheduler Cosine Annealing
Min LR Ratio 0.005
Precision bf16-mixed
Batch Size 512
Max Epochs 500
Gradient Clipping 1.0
Architecture
State Encoder CNN
State Decoder CNN
Hidden Dimension (dmodel) 32
Feedforward Dimension (dff) 128
Dropout 0.1
State Dimension 32
VAE
V AEβ1e−5
Loss Weights
Auto Reconstruction Loss 1.0
32
Learning to Theorize
Table 19.GridWorldα= 0.33Experiments Hyperparameters. We conducted experiments on three seed values.
Hyperparameter NEO Disc-Mono Cont-Mono Cont-Mono-Opt
Training
Learning Rate5e−4 5e−3 5e−3 5e−3
Weight Decay1e−2 1e−2 1e−2 1e−2
Warmup Ratio 0.1 0.05 0.05 0.05
LR Scheduler Cosine Cosine Cosine Cosine
Min LR Ratio 0.1 0.1 0.1 0.1
Precision bf16-mixed bf16-mixed bf16-mixed bf16-mixed
Batch Size 128 128 128 128
Max Epochs 100 150 100 100
Gradient Clipping 1.0 1.0 1.0 1.0
Two-Timescale Learning Rate
Policy LR Scale 0.25 0.25 0.25 0.25
Transition LR Scale 1.0 1.0 1.0 1.0
Architecture
State Encoder CNN CNN CNN CNN
State Decoder CNN CNN CNN CNN
Policy Network FiLM-MLP FiLM-MLP FiLM-MLP FiLM-MLP
Transition Network FiLM-MLP FiLM-MLP FiLM-MLP FiLM-MLP
Hidden Dimension (dmodel) 32 32 32 32
Feedforward Dimension (dff) 128 128 128 128
State Dimension 32 32 32 32
Action Dimension 16 16 16 16
Num Action Tokens 1 1 1 1
Max Transition Length (K) 4 1 1 1
Latent Action Space
Action Space Type Discrete (VQ) Discrete (VQ) Continuous (V AE) Continuous (V AE)
Codebook Size 6 36 – –
Commitment Cost (β) 0.25 0.25 – –
Gumbel-Softmaxτ start 0.3 0.3 – –
Gumbel-Softmaxτ end 0.1 0.1 – –
V AEβ– – 0.01 0.01
Loss Weights
Reconstruction Loss 1.0 1.0 1.0 1.0
Grounding Loss 0.1 – – –
Action VQ Loss 1.0 1.0 – –
λMDL 0.95 – – –
Test-Time Optimization
Gradient Search Steps – – – 5
33
Learning to Theorize
Table 20.GridWorldα= 0.66Experiments Hyperparameters. We conducted experiments on three seed values.
Hyperparameter NEO Disc-Mono Cont-Mono Cont-Mono-Opt
Training
Learning Rate5e−4 5e−3 5e−3 5e−3
Weight Decay1e−2 1e−2 1e−2 1e−2
Warmup Ratio 0.05 0.05 0.05 0.05
LR Scheduler Cosine Cosine Cosine Cosine
Min LR Ratio 0.1 0.1 0.1 0.1
Precision bf16-mixed bf16-mixed bf16-mixed bf16-mixed
Batch Size 128 128 128 128
Max Epochs 50 150 100 100
Gradient Clipping 1.0 1.0 1.0 1.0
Two-Timescale Learning Rate
Policy LR Scale 0.25 0.25 0.25 0.25
Transition LR Scale 1.0 1.0 1.0 1.0
Architecture
State Encoder CNN CNN CNN CNN
State Decoder CNN CNN CNN CNN
Policy Network FiLM-MLP FiLM-MLP FiLM-MLP FiLM-MLP
Transition Network FiLM-MLP FiLM-MLP FiLM-MLP FiLM-MLP
Hidden Dimension (dmodel) 32 32 32 32
Feedforward Dimension (dff) 128 128 128 128
State Dimension 32 32 32 32
Action Dimension 16 16 16 16
Num Action Tokens 1 1 1 1
Max Transition Length (K) 4 1 1 1
Latent Action Space
Action Space Type Discrete (VQ) Discrete (VQ) Continuous (V AE) Continuous (V AE)
Codebook Size 6 36 – –
Commitment Cost (β) 0.25 0.25 – –
Gumbel-Softmaxτ start 0.3 0.3 – –
Gumbel-Softmaxτ end 0.1 0.1 – –
V AEβ– – 0.01 0.01
Loss Weights
Reconstruction Loss 1.0 1.0 1.0 1.0
Grounding Loss 0.1 – – –
Action VQ Loss 1.0 1.0 – –
λMDL 0.95 – – –
Test-Time Optimization
Gradient Search Steps – – – 5
34
Learning to Theorize
Table 21.GridWorldα= 1.00Experiments Hyperparameters. We conducted experiments on three seed values.
Hyperparameter NEO Disc-Mono Cont-Mono Cont-Mono-Opt
Training
Learning Rate5e−4 5e−3 5e−3 5e−3
Weight Decay1e−2 1e−2 1e−2 1e−2
Warmup Ratio 0.05 0.05 0.05 0.05
LR Scheduler Cosine Cosine Cosine Cosine
Min LR Ratio 0.1 0.1 0.1 0.1
Precision bf16-mixed bf16-mixed bf16-mixed bf16-mixed
Batch Size 128 128 128 128
Max Epochs 50 150 100 100
Gradient Clipping 1.0 1.0 1.0 1.0
Two-Timescale Learning Rate
Policy LR Scale 0.25 0.25 0.25 0.25
Transition LR Scale 1.0 1.0 1.0 1.0
Architecture
State Encoder CNN CNN CNN CNN
State Decoder CNN CNN CNN CNN
Policy Network FiLM-MLP FiLM-MLP FiLM-MLP FiLM-MLP
Transition Network FiLM-MLP FiLM-MLP FiLM-MLP FiLM-MLP
Hidden Dimension (dmodel) 32 32 32 32
Feedforward Dimension (dff) 128 128 128 128
State Dimension 32 32 32 32
Action Dimension 16 16 16 16
Num Action Tokens 1 1 1 1
Max Transition Length (K) 4 1 1 1
Latent Action Space
Action Space Type Discrete (VQ) Discrete (VQ) Continuous (V AE) Continuous (V AE)
Codebook Size 6 36 – –
Commitment Cost (β) 0.25 0.25 – –
Gumbel-Softmaxτ start 0.3 0.3 – –
Gumbel-Softmaxτ end 0.1 0.1 – –
V AEβ– – 1e-3 1e-3
Loss Weights
Reconstruction Loss 1.0 1.0 1.0 1.0
Grounding Loss 0.1 – – –
Action VQ Loss 1.0 1.0 – –
λMDL 1.00 – – –
Test-Time Optimization
Gradient Search Steps – – – 5
35
Learning to Theorize
F .2. Arithmetic Reasoning
Table 22.Pretraining hyperparameters for the learned state embeddings in arithmetic reasoning experiments. The same pretrained
embedding model is used for NEO and all baselines.
Hyperparameter Value
Training
Learning Rate3e−3
Weight Decay1e−2
LR Scheduler Cosine Annealing
Min LR Ratio 0.005
Precision bf16-mixed
Batch Size 512
Max Epochs 500
Gradient Clipping 1.0
Architecture
State Encoder Embedding Layer
State Decoder Linear
State Embedding Dimension 8
VAE
V AEβ2e−5
Loss Weights
Auto Reconstruction Loss 1.0
36
Learning to Theorize
Table 23.Arithmetic Factorization Reasoning Experiments Hyperparameters (allα). We conducted experiments on three seed values.
Hyperparameter NEO Disc-Mono Cont-Mono Cont-Mono-Opt
Training
Learning Rate1.5e−3 1.5e−3 1.5e−3 1.5e−3
Weight Decay1e−2 1e−2 1e−2 1e−2
Warmup Ratio 0.05 0.05 0.05 0.05
LR Scheduler Cosine Cosine Cosine Cosine
Min LR Ratio 0.1 0.1 0.1 0.1
Precision bf16-mixed bf16-mixed bf16-mixed bf16-mixed
Batch Size 512 512 512 512
Max Epochs 200 200 200 200
Gradient Clipping 1.0 1.0 1.0 1.0
Two-Timescale Learning Rate
Policy LR Scale 0.5 0.5 0.5 0.5
Transition LR Scale 1.0 1.0 1.0 1.0
Architecture
State Encoder Embedding Layer Embedding Layer Embedding Layer Embedding Layer
State Decoder Linear Linear Linear Linear
Policy Network Transformer Transformer Transformer Transformer
Transition Network Cross-Attention Cross-Attention Cross-Attention Cross-Attention
Policyd model /d ff 64 / 256 64 / 256 64 / 256 64 / 256
Policy Heads / Layers 4 / 6 4 / 6 4 / 6 4 / 6
Transitiond model /d ff 32 / 128 32 / 128 32 / 128 32 / 128
Transition Heads / Layers 2 / 4 2 / 4 2 / 4 2 / 4
State Dimension 8 8 8 8
Action Dimension 4 4 4 4
Num State Tokens 6 6 6 6
Num Action Tokens 1 1 1 1
Max Transition Length (K) 3 1 1 1
Latent Action Space
Action Space Type Discrete (VQ) Discrete (VQ) Continuous (V AE) Continuous (V AE)
Codebook Size 16 40 – –
Gumbel-Softmaxτ start 0.3 0.3 – –
Gumbel-Softmaxτ end 0.05 0.05 – –
τScheduling Ratio 0.25 0.25 – –
EMA Decay 0.99 0.99 – –
Orthogonal Reg Weight 10 10 – –
V AEβ– –2e−4 2e−4
Loss Weights
Reconstruction Loss 1.0 1.0 1.0 1.0
Grounding Loss 0.5 – – –
Action VQ Loss 1.0 1.0 – –
λMDL (start→end)1.01→0.99– – –
MDL Scheduling Ratio 0.1 – – –
Test-Time Optimization
Gradient Search Steps – – – 30
Gradient Steps lr – – – 0.1
37
Learning to Theorize
F .3. Image Editing
Table 24.Pretraining Hyperparameters (State V AE) for Image Editing Experiments. We use the same pretrained model for NEO and
Baselines experiments.
Hyperparameter Value
Training
Learning Rate5e−4
Weight Decay1e−2
LR Scheduler Cosine Annealing
Min LR Ratio 0.005
Precision bf16-mixed
Batch Size 512
Max Epochs 500
Gradient Clipping 1.0
Architecture
State Encoder CNN
State Decoder CNN
Hidden Dimension (dmodel) 32
Feedforward Dimension (dff) 128
Dropout 0.1
State Dimension 256
VAE
V AEβ1e−4
Loss Weights
Auto Reconstruction Loss 1.0
38
Learning to Theorize
Table 25.Image Editingα= 1.0Experiments Hyperparameters. We conducted experiments on three seed values.
Hyperparameter NEO Disc-Mono Cont-Mono Cont-Mono-Opt
Training
Learning Rate1e−3 1e−3 1e−3 1e−3
Weight Decay1e−2 1e−2 1e−2 1e−2
Warmup Ratio 0.05 0.05 0.05 0.05
LR Scheduler Cosine Cosine Cosine Cosine
Min LR Ratio 0.1 0.1 0.1 0.1
Precision bf16-mixed bf16-mixed bf16-mixed bf16-mixed
Batch Size 64 64 64 64
Max Epochs 50 50 50 50
Gradient Clipping 1.0 1.0 1.0 1.0
Two-Timescale Learning Rate
Policy LR Scale 0.25 0.25 0.25 0.25
Transition LR Scale 0.5 0.5 0.5 0.5
Architecture
State Encoder CNN CNN CNN CNN
State Decoder CNN CNN CNN CNN
Policy Network FiLM-MLP FiLM-MLP FiLM-MLP FiLM-MLP
Transition Network FiLM-MLP FiLM-MLP FiLM-MLP FiLM-MLP
Hidden Dimension (dmodel) 32 32 32 32
Feedforward Dimension (dff) 128 128 128 128
State Dimension 256 256 256 256
Action Dimension 16 16 16 16
Num Action Tokens 1 1 1 1
Max Transition Length (K) 3 1 1 1
Latent Action Space
Action Space Type Discrete (VQ) Discrete (VQ) Continuous (V AE) Continuous (V AE)
Codebook Size 16 64 – –
Commitment Cost (β) 0.25 0.25 – –
Gumbel-Softmaxτ start – – – –
Gumbel-Softmaxτ end – – – –
V AEβ– – 1e-3 1e-3
Loss Weights
Reconstruction Loss 1.0 1.0 1.0 1.0
Grounding Loss 0.1 – – –
Action VQ Loss 0.5 0.5 – –
λMDL 1.01 – – –
Test-Time Optimization
Gradient Search Steps – – – 30
Gradient Steps lr – – – 1.0
39
Learning to Theorize
Table 26.Image Editingα= 0.66Experiments Hyperparameters. We conducted experiments on three seed values.
Hyperparameter NEO Disc-Mono Cont-Mono Cont-Mono-Opt
Training
Learning Rate1e−3 1e−3 1e−3 1e−3
Weight Decay1e−2 1e−2 1e−2 1e−2
Warmup Ratio 0.05 0.05 0.05 0.05
LR Scheduler Cosine Cosine Cosine Cosine
Min LR Ratio 0.1 0.1 0.1 0.1
Precision bf16-mixed bf16-mixed bf16-mixed bf16-mixed
Batch Size 64 64 64 64
Max Epochs 50 50 50 50
Gradient Clipping 1.0 1.0 1.0 1.0
Two-Timescale Learning Rate
Policy LR Scale 0.25 0.25 0.25 0.25
Transition LR Scale 0.5 0.5 0.5 0.5
Architecture
State Encoder CNN CNN CNN CNN
State Decoder CNN CNN CNN CNN
Policy Network FiLM-MLP FiLM-MLP FiLM-MLP FiLM-MLP
Transition Network FiLM-MLP FiLM-MLP FiLM-MLP FiLM-MLP
Hidden Dimension (dmodel) 32 32 32 32
Feedforward Dimension (dff) 128 128 128 128
State Dimension 256 256 256 256
Action Dimension 16 16 16 16
Num Action Tokens 1 1 1 1
Max Transition Length (K) 3 1 1 1
Latent Action Space
Action Space Type Discrete (VQ) Discrete (VQ) Continuous (V AE) Continuous (V AE)
Codebook Size 16 64 – –
Commitment Cost (β) 0.25 0.25 – –
Gumbel-Softmaxτ start – – – –
Gumbel-Softmaxτ end – – – –
V AEβ– – 1e-3 1e-3
Loss Weights
Reconstruction Loss 1.0 1.0 1.0 1.0
Grounding Loss 0.1 – – –
Action VQ Loss 0.5 0.5 – –
useλ MDL scheduling true – – –
λstart
MDL 1.05 – – –
λend
MDL 1.0 – – –
Test-Time Optimization
Gradient Search Steps – – – 30
Gradient Steps lr – – – 1.0
40
Learning to Theorize
Table 27.Image Editingα= 0.33Experiments Hyperparameters. We conducted experiments on three seed values.
Hyperparameter NEO Disc-Mono Cont-Mono Cont-Mono-Opt
Training
Learning Rate1e−3 1e−3 1e−3 1e−3
Weight Decay1e−2 1e−2 1e−2 1e−2
Warmup Ratio 0.05 0.05 0.05 0.05
LR Scheduler Cosine Cosine Cosine Cosine
Min LR Ratio 0.1 0.1 0.1 0.1
Precision bf16-mixed bf16-mixed bf16-mixed bf16-mixed
Batch Size 64 64 64 64
Max Epochs 50 50 50 50
Gradient Clipping 1.0 1.0 1.0 1.0
Two-Timescale Learning Rate
Policy LR Scale 0.25 0.25 0.25 0.25
Transition LR Scale 0.5 0.5 0.5 0.5
Architecture
State Encoder CNN CNN CNN CNN
State Decoder CNN CNN CNN CNN
Policy Network FiLM-MLP FiLM-MLP FiLM-MLP FiLM-MLP
Transition Network FiLM-MLP FiLM-MLP FiLM-MLP FiLM-MLP
Hidden Dimension (dmodel) 32 32 32 32
Feedforward Dimension (dff) 128 128 128 128
State Dimension 256 256 256 256
Action Dimension 16 16 16 16
Num Action Tokens 1 1 1 1
Max Transition Length (K) 3 1 1 1
Latent Action Space
Action Space Type Discrete (VQ) Discrete (VQ) Continuous (V AE) Continuous (V AE)
Codebook Size 16 64 – –
Commitment Cost (β) 0.25 0.25 – –
Gumbel-Softmaxτ start – – – –
Gumbel-Softmaxτ end – – – –
V AEβ– – 0.0001 0.0001
Loss Weights
Reconstruction Loss 1.0 1.0 1.0 1.0
Grounding Loss 0.1 – – –
Action VQ Loss 0.5 0.5 – –
useλ MDL scheduling true – – –
λstart
MDL 1.01 – – –
λend
MDL 1.0 – – –
Test-Time Optimization
Gradient Search Steps – – – 30
Gradient Steps lr – – – 1.0
41
Learning to Theorize
G. Extended Related Works
G.1. Language of Thought and Cognitive Theory Learning.
The Language of Thought hypothesis (Fodor, 1975) proposes that human cognition operates over compositional symbolic
representations. Related ideas appear in Bayesian program learning (Ellis et al., 2016) and cognitive models of concept
formation, where hypotheses are represented as programs or rules (Lake et al., 2016; Tenenbaum et al., 2011). These
approaches highlight the importance of structured, interpretable representations for generalization and explanation. Our
work is inspired by this perspective but departs from symbolic modeling: NEO learns both the vocabulary and semantics of a
Language of Thought in a neural and data-driven manner. Programs are latent and continuous in execution, while remaining
discrete and compositional in structure, enabling theory induction directly from observation.
G.2. Neural Program Induction & Program Synthesis
A long line of work studies neural program induction and program synthesis from input–output examples, including Neural
Programmer-Interpreter (Reed & de Freitas, 2016), differentiable interpreters (Feser et al., 2017), NTM (Graves et al.,
2014), NPI (Reed & de Freitas, 2016), LEAPS (Trivedi et al., 2022), HPRL (Liu et al., 2023), LPN (Macfarlane & Bonnet,
2025) and program synthesis frameworks such as DreamCoder (Ellis et al., 2020). These methods typically assume access
to symbolic inputs, explicit domain-specific languages, or task-level supervision that specifies the program space. In
contrast, our work addresses program induction directly from raw, non-symbolic observations without predefined grammars
or program annotations. Moreover, while prior approaches often focus on solving specific tasks, NEO learns a reusable
library of primitives and induces latent programs as explanatory theories, emphasizing compositionality and transfer across
phenomena rather than task-specific correctness.
G.3. ARC-AGI.
ARC-AGI (Chollet, 2019; Chollet et al., 2025; 2026) evaluates abstract reasoning by requiring models to infer algorithmic
programs from a small number of demonstration pairs. These benchmarks primarily emphasize reasoning and generalization
in low-data regimes, while treating the underlying primitives and representational biases as largely fixed rather than learned.
In contrast, our work focuses on discovering such primitives directly from raw observations in an unsupervised manner.
Furthermore, whereas ARC-AGI is formulated over explicitly defined tasks with support sets, our framework operates on
independent (x, y)transitions and supports both program induction and the learning of a reusable compositional language.
G.4. Compositional and Systematic Generalization.
Adaptive tokenization (Duggal et al., 2024; 2025) and emergent communication methods (Elberg et al., 2025) study variable-
length, compositional representations for images learned without explicit supervision, aiming at efficient representation or
communication of individual observations. More broadly, compositional generalization has been explored in neural module
networks (Andreas et al., 2017), and benchmarks such as SCAN (Lake & Baroni, 2018), gSCAN (Ruis et al., 2020), showing
that explicit compositional structure can improve systematic generalization to novel combinations. However, most existing
approaches rely on symbolic inputs, hand-designed primitives, or task formulations with few-shot support sets that share an
underlying rule. In contrast, our formulation removes these assumptions by learning variable-length, compositional programs
directly from raw observation pairs, allowing explanations to adapt to the complexity of the underlying transformation and
enabling compositional structure to emerge from data rather than being imposed by dataset design.
G.5. Latent Action Models (LAM) & World Models.
A line of work including LAPO (Schmidt & Jiang, 2024), AdaWorld (Gao et al., 2025), LAPA (Ye et al., 2025), and
Genie (Bruce et al., 2024) studies latent action models that learn dynamics from observation-only video data by inferring
unobserved actions as latent variables. These methods are primarily designed as scalable pretraining mechanisms to recover
action representations in the absence of action labels, supporting downstream control or prediction. Relatedly, world
models such as RSSM and Dreamer (Hafner et al., 2018; 2019; 2020; 2024) focus on learning compact latent dynamics
representations to enable prediction and planning. While these approaches aim to model environment dynamics, our
framework targets a different problem setting: given an arbitrary observation pair (x, y), we seek to induce a theory that
explains the transformation itself. Consequently, our approach is not restricted to single-step next-frame prediction and
instead emphasizes learning reusable primitives over more general transformations.
42