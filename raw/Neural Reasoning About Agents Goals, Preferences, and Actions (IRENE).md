---
title: "Neural Reasoning About Agents' Goals, Preferences, and Actions (IRENE)"
source: "https://arxiv.org/abs/2312.07122"
author:
  - "[[Matteo Bortoletto]]"
  - "[[Lei Shi]]"
  - "[[Andreas Bulling]]"
published: 2023-12-12
created: 2026-08-13
description: "AAAI 2024. IRENE = relational GraphSAGE state encoder (nodes = entities with type/position/colour/shape, edges = local/remote directional + adjacent + aligned relations) + 6-layer transformer context encoder over the 8 familiarisation trials, trained by next-position prediction on BIB's background set. State of the art on 3 of 5 BIB tasks (Multi-Agent 74.9 vs previous best 50.3; Irrational Agent 85.7; Blocking Barrier 83.5) yet still AT CHANCE on Preference (48.5), where the earlier VT model reaches 80.8 while collapsing to 34.1 - below chance - on Irrational Agent. THE CONTROL THE FIELD NEEDED: IRENE consumes the SYMBOLIC scene graph from BIB's JSON, not pixels, so 'the model was handed the state' does not explain the Bayesian model's advantage. Expectedness again scored as maximum prediction error. Internal inconsistency: Table 2's IRENE column reports Multi-Agent 79.4 where Table 1 reports 74.9 (the 48.9% improvement quoted in the text implies 74.9)."
tags:
  - "clippings"
  - "theory-of-mind"
  - "agency"
  - "graph-neural-network"
  - "benchmark"
  - "intuitive-psychology"
---

Title: Neural Reasoning About Agents' Goals, Preferences, and Actions (IRENE)

URL Source: https://arxiv.org/abs/2312.07122

Markdown Content:
Neural Reasoning About Agents’ Goals, Preferences, and Actions
Matteo Bortoletto, Lei Shi, Andreas Bulling
University of Stuttgart, Germany
{matteo.bortoletto, lei.shi, andreas.bulling}@vis.uni-stuttgart.de
Abstract
We propose the Intuitive Reasoning Network (IRENE) –
a novel neural model for intuitive psychological reason-
ing about agents’ goals, preferences, and actions that can
generalise previous experiences to new situations. IRENE
combines a graph neural network for learning agent and
world state representations with a transformer to encode the
task context. When evaluated on the challenging Baby Intu-
itions Benchmark, IRENE achieves new state-of-the-art per-
formance on three out of its five tasks – with up to 48.9 %
improvement. In contrast to existing methods, IRENE is able
to bind preferences to specific agents, to better distinguish
between rational and irrational agents, and to better under-
stand the role of blocking obstacles. We also investigate, for
the first time, the influence of the training tasks on test perfor-
mance. Our analyses demonstrate the effectiveness of IRENE
in combining prior knowledge gained during training for un-
seen evaluation tasks.
Introduction
Common-sense reasoning refers to a broad class of abil-
ities that enable agents to understand basic facts about
events, objects, beliefs, or desires (McCarthy 1989). Stud-
ies in developmental cognitive science have demonstrated
that even young infants have these abilities (Needham and
Baillargeon 1993; Gergely et al. 1995; Aguiar and Bail-
largeon 1999) while their absence can be linked to devel-
opmental disorders, such as autism (Baron-Cohen 1997).
Given its fundamental importance for human social cog-
nition and behaviour, it is imperative that artificial intelli-
gent (AI) agents possess similar capabilities to effectively
be understood by humans and in turn, understand them.
This is crucial for a wide variety of applications, such as
robotics (Mota and Sridharan 2019) or human-machine col-
laboration (Conti, Varde, and Wang 2022). Previous research
in machine common-sense reasoning has mainly focused on
evaluating language processing (Bhagavatula et al. 2020;
Huang et al. 2019; Zellers et al. 2019; Bisk et al. 2020;
Sap et al. 2019; Sakaguchi et al. 2021) or visual scene un-
derstanding (Yi et al. 2020; Smith et al. 2019; Ates et al.
2022) in a task-specific manner. More recently, several new
benchmarks have been introduced that allow to assess the
Copyright © 2024, Association for the Advancement of Artificial
Intelligence (www.aaai.org). All rights reserved.
more general ability of AI systems to reason about unex-
pected events or situations (Riochet et al. 2020; Gandhi et al.
2021; Dasgupta et al. 2021; Shu et al. 2021; Piloto et al.
2022; Weihs et al. 2022). Most of them focus on intuitive
physics (Yi et al. 2020; Smith et al. 2019; Ates et al. 2022;
Riochet et al. 2020; Dasgupta et al. 2021; Piloto et al. 2022;
Weihs et al. 2022; Piloto et al. 2018) in which computational
models have to reason about properties and interactions of
physical macroscopic objects. In contrast, comparably little
advances have been achieved in methods for intuitive psy-
chology, i.e. common-sense reasoning about other agents’
mental states from their observed behaviour (Gandhi et al.
2021; Shu et al. 2021).
Similar to studies in developmental cognitive science,
evaluation of common-sense reasoning abilities in these
benchmarks uses a violation of expectation paradigm (Bail-
largeon 1987, V oE). In a set of familiarisation trials, an ob-
server model has to form an expectation about a particular
agent behaviour. In a subsequent test trial, given the context
extracted from the familiarisation trials, the observer has to
judge how expected the behaviour of the agent is. Expected-
ness is defined as the observer’s prediction error with respect
to a ground truth (e.g. agent’s next action). The core idea be-
hind the V oE paradigm is to pair test trials that may not differ
much in traditional error metrics but differ in terms of human
reasoning. As such, V oE allows probing AI capabilities by
comparing scenarios that humans can differentiate based on
those capabilities.
Inspired by behavioural experiments with infants, Gandhi
et al. have recently introduced the Baby Intuitions Bench-
mark (Gandhi et al. 2021, BIB) – a set of tasks that require
an observer model to reason about agents’ goals, prefer-
ences, and actions by observing their behaviour in a grid-
world environment. The BIB poses two key challenges.
First, despite being performed in the same grid-world envi-
ronment, training and evaluation tasks differ in their number
and setting. Moreover, test trials in the training set present
only expected outcomes, requiring observer models to gen-
eralise to unseen situations by combining different pieces
of knowledge gained during training. Second, the bench-
mark not only challenges models’ ability to predict future
actions but also to use them to quantify the expectedness
of novel situations. As such, the BIB can be seen as posing
a meta-learning problem (Rabinowitz et al. 2018) in which
arXiv:2312.07122v1  [cs.AI]  12 Dec 2023
an observer model “learns to learn” about other agents’ be-
haviour. While initial models are based on the machine the-
ory of mind network (Rabinowitz et al. 2018), the most re-
cent model (Hein and Diepold 2022, VT) is based on a video
transformer (Neimark et al. 2021). VT is rather successful in
modelling agents’ preferences, but it fails in binding them to
specific agents. Moreover, VT struggles with understanding
the role of blocking barriers and that rational agents, in con-
trast to irrational ones, move efficiently towards their goal.
To address these limitations we introduce the Intuitive
Reasoning Network (IRENE) – a novel neural network for
core intuitive psychology. IRENE uses a graph neural net-
work (GNN) to obtain rich state embeddings by processing
graphs extracted from video frames as well as a transformer
to encode the familiarisation trials in a context vector. We
show that IRENE achieves new state-of-the-art performance
on three out of five reasoning tasks defined on the BIB. Our
model performs particularly well on tasks that existing mod-
els (Gandhi et al. 2021; Hein and Diepold 2022) struggle
with: binding preferences to specific agents, differentiating
between rational and irrational agents, and understanding
how to deal with obstacles that block the agents’ goal ob-
ject. We also show that for selected tasks, its predictions are
in line with infants’ responses collected on a subset of the
BIB (Stojni ´c et al. 2023). Finally, for the first time, we in-
vestigate the choice of training tasks on generalisation per-
formance. Our analyses demonstrate our model’s ability to
combine knowledge gained during training to solve unseen
evaluation tasks. Moreover, we show that training on one
type of task does not necessarily improve performance on
similar evaluation tasks but that training on unrelated tasks
can lead to improvements. 1
In summary, our contributions are two-fold:
• We propose IRENE – a novel model for intuitive psy-
chology that combines a GNN and a transformer to learn
rich state and context representations. IRENE achieves
new state-of-the-art performance on three out of five BIB
reasoning tasks. In particular, it is capable of binding
preferences to specific agents and of modelling blocking
obstacles and irrational agents better than existing mod-
els.
• We are first to provide a detailed analysis of the influence
of the chosen training tasks on performance. IRENE can
achieve new state-of-the-art reasoning performance only
when trained on all training tasks, showing its ability to
combine knowledge gained during training to solve un-
seen evaluation tasks.
Related Work
Common-Sense Reasoning Benchmarks
Benchmarks for common-sense reasoning are becoming in-
creasingly popular as they enable the first steps towards
intelligent, collaborative agents that reason like humans.
Most research has focused on evaluating language process-
ing (Bhagavatula et al. 2020; Huang et al. 2019; Zellers
1Our project web-page is accessible at https://perceptualui.org/
publications/bortoletto24 aaai/.
et al. 2019; Bisk et al. 2020; Sap et al. 2019; Sakaguchi
et al. 2021) or visual scene understanding (Yi et al. 2020;
Smith et al. 2019; Ates et al. 2022) through task-specific
assessments, e.g. predictive accuracy. However, a number
of benchmarks that aim to evaluate the general ability of
AI systems to reason about unexpected events or situations
have recently emerged (Riochet et al. 2020; Shu et al. 2021;
Gandhi et al. 2021; Dasgupta et al. 2021; Piloto et al. 2022;
Weihs et al. 2022). Most of these benchmarks focus on intu-
itive physics, targeting physical concepts such as continuity,
solidity, object persistence and gravity (Smith et al. 2019;
Riochet et al. 2020; Dasgupta et al. 2021; Piloto et al. 2022;
Weihs et al. 2022). Conversely, benchmarks that test mod-
els’ ability to reason about other agents have received less
attention. A notable exception is the recent BIB (Gandhi
et al. 2021) that is based on the findings that infants expect
other agents to have goals, preferences and engage in in-
strumental actions. The benchmark includes a set of tasks
to evaluate whether an AI observer can exhibit the same
capabilities. Like the BIB, AGENT tests whether models
can predict that agents have object-based goals and act ef-
ficiently (Shu et al. 2021). In contrast to the BIB, however,
AGENT does not evaluate whether models can reason about
multiple agents, inaccessible goals, instrumental actions, or
distinguish between rational and irrational agents. More-
over, whilst AGENT’s training and evaluation sets present
only minor differences and training is done using different
leave-out splits, the BIB provides a single canonical split
to maximise the evaluation of models’ generalisability. We
evaluate our model on the BIB given its accessibility and rel-
evance as a benchmark for assessing intuitive psychological
reasoning.
Models for Intuitive Psychology
Models for reasoning about agents’ behaviour and mental
states can be grouped into models based on Bayesian the-
ory (Baker, Saxe, and Tenenbaum 2011; Baker et al. 2017)
or deep learning (Rabinowitz et al. 2018). Shu et al. have
introduced Bayesian Inverse Planning and Core Knowl-
edge (BIPaCK) (Shu et al. 2021) that combines Bayesian
inverse planning (Baker et al. 2017) and physics simula-
tion (Battaglia, Hamrick, and Tenenbaum 2013), evaluat-
ing it on AGENT. More recently, Zhi et al. have evaluated
a Bayesian Theory of Mind model with hierarchical pri-
ors over agents’ preference and efficiency (HBToM) on the
BIB (Zhi-Xuan et al. 2022). However, this method makes
strong assumptions and uses a tailored definition of expect-
edness. Gandhi et al. define expectedness in terms of the
mean square error between the model prediction and the
ground-truth (Gandhi et al. 2021). Instead, HBToM com-
putes a plausibility score by training a set of logistic regres-
sion classifiers on a synthetic dataset similar to the BIB eval-
uation set. Therefore, in this work we do not compare our
results with those of HBToM.
On the BIB, Gandhi et al. (Gandhi et al. 2021) have pro-
posed a model based on the Theory of Mind neural network
(ToMnet) introduced by (Rabinowitz et al. 2018). More re-
cently, Hein et al. have proposed a method (VT) based on a
video transformer (Neimark et al. 2021) that encodes frames
Familiarisation
Test, Expected
Test, Unexpected
Error(E)
Error(U)
<> ?
Test, ExpectedFamiliarisation
Error(E)
Training
Evaluation
+
+
Figure 1: Training and evaluation on the Baby Intuitions
Benchmark (Gandhi et al. 2021). During training, a model
conducts eight familiarisation trials and a test trial, which
is always expected. The model’s weights are updated using
backpropagation on the error, computed with respect to the
expected test trial ground truth. Evaluation employs a vio-
lation of expectation paradigm: based on the familiarisation
trials, the model makes predictions on expected and unex-
pected test trials and both errors are compared. The model is
successful if the error on the expected trials is smaller than
that on the unexpected trials.
using a CNN and performs cross- and self-attention over
frames (Hein and Diepold 2022). In this work, we intro-
duce a novel method that uses a GNN (Gori, Monfardini,
and Scarselli 2005) to encode graphs built from frames and
a transformer (Vaswani et al. 2017) to generate context em-
beddings. On AGENT, Shu et al. have also used a GNN to
encode states, where graphs connect the agent node to all
the other nodes (Shu et al. 2021). Differently, our GNN per-
forms message passing using on heterogeneous graphs with
edges representing different spatial relations.
The Baby Intuitions Benchmark
The BIB consists of 2D videos of an agent moving and
interacting with different objects in a grid-world environ-
ment (see Figure 1). Both the agent and objects are repre-
sented as geometric shapes of different colours. The bench-
mark proposes five common-sense reasoning tasks ( Prefer-
ence, Multi-Agent, Inaccessible Goal, Efficient Action, and
Instrumental Action) derived from research on infant intu-
itive psychology, that require an observer model to reason
about agents’ goals, preferences, and actions by observing
their behaviour in a grid-world environment. The Efficient
Action and Instrumental Action present three sub-tasks each:
Efficiency Path Control, Efficiency Time Control, Efficiency
Irrational Agent) and Instrumental No Barrier, Instrumental
Blocking Barrier, Instrumental Inconsequential Barrier, re-
spectively. Task descriptions are provided in the Appendix.
An episode in the BIB includes nine trials with trajecto-
ries {τi}i=1,...,9, where each trajectory consists of a series of
state-action pairs τi = {(sij, aij)}j=1,...,T , with sij being
video frames and T the trial length. {τi}i=1,...,8 are famil-
iarisation trials and τ9 is the test trial. Familiarisation trials
serve to give a context to the model while test trials are used
to make predictions. A test trial can be consistent with the
familiarisation examples (expected outcome) or inconsistent
(unexpected outcome). According to the V oE paradigm, if
the observer is more surprised by the unexpected outcome,
this means that what they believed or predicted would hap-
pen is not in line with what actually occurred. Expected-
ness is defined as the observer model’s prediction error: a
model is successful if the prediction error on the unexpected
outcome is higher than the error on the expected outcome.
In practice, the prediction error is quantified by the mean
squared error (MSE) with respect to a ground truth (e.g. next
frame or action).
The authors provide a single canonical split for training
and evaluation, as they differ in terms of tasks and sam-
ple distributions. The evaluation set presents the tasks men-
tioned above. Familiarisation and test trials follow different
distributions: expected and unexpected trials are perceptu-
ally and conceptually different from familiarisation trials,
respectively. Consider, for example, thePreference task (see
Figure 1). In expected trials, the preferred object is located
differently than in familiarisation trials but the agent still
moves towards it. In the unexpected trials, the agent moves
towards the non-preferred object whose location is the same
as familiarisation.
The training set presents four tasks: Single-Object, No-
Navigation Preference , Single-Object Multiple-Agent and
Agent-Blocked Instrumental Action . The training tasks are
more trivial and less informative than the evaluation tasks,
compelling models to combine and generalise the knowl-
edge acquired from the different training tasks to solve the
evaluation tasks. For example, for the Instrumental Block-
ing Barrier task, a model has to put together knowledge of
navigation (Single-Object) and instrumental actions (Agent-
Blocked Instrumental Action ). However, at the same time,
the model has to generalise its knowledge: for example, in
the training trials ( Agent-Blocked Instrumental Action), the
agent is confined in the barrier, whereas in the evaluation
trials (Instrumental Blocking Barrier) it is the object which
is confined. For a detailed description of the dataset we re-
fer the interested reader to the original paper (Gandhi et al.
2021). We provide a brief summary in the Appendix.
Method
Graph Generation. In the BIB, each video is paired with
a json file containing information about the grid-world lay-
out, which we use to build graphs. Videos are sampled at
3 FPSand a graph Gij = (Vij, Eij) is built from each sam-
pled frame j = 1, . . . , Tin each trial i = 1, . . . ,9, where
Vij is a set of nodes and Eij a set of edges. Each entity
in a frame is assigned to a graph node vij ∈ Vij, which
has four features: type (e.g. “agent”), position (x and
y coordinates), colour (GBR channels) and shape (e.g.
Type
Shape
Colour
Position
Graph
Pooling
Fam. Node 
Embeddings
sss
Fam. Graph 
Embeddings s
a
CTX
Familiarisation 
frames
Test frame cType
Shape
Colour Graph
Pooling
Test Node 
Embeddings
s
Test Graph 
Embedding
a
Prediction Net
Context Encoder    
eij
vij
vij
eij Position
Context
Linear
Linear
Linear
Linear
ReLU+
Linear
ReLU+
Linear GNN 𝝓
Transformer 
Encoder 𝝍
MLP 𝝆
Linear
Linear
Linear
Linear
ReLU+
Linear
ReLU+
Linear GNN 𝝓
Average
CTX_1 … CTX_8
Figure 2: Architecture of IRENE. Inputs are graphs representing entities in a video frame. In the context encoder, the state
encoder includes a feature fusion module that combines the four node features into a single one, which is input to a GNN.
The encoded states are concatenated to the corresponding actions and to a special learnable CTX token. A transformer context
encoder produces a context embedding as the mean of theCXT embedding vectors of each familiarisation trial. In theprediction
net, the encoded test state is concatenated to the context and input into a MLP policy that outputs a prediction for the agent’s
next action.
“pentagon”). We represent categorical variables (type and
shape) as one-hot vectors while position and colour
are normalised between [−1, 1] and [0, 1], respectively.
Edges eij ∈ Eij represent spatial relationships and are de-
fined following (Jiang et al. 2021). Specifically, we consider
local directional relations, which identify the relative posi-
tion of two adjacent entities, remote directional relations ,
which do not require adjacency, and two non-directional re-
lations, adjacent and aligned (see the Appendix for formal
definitions).
Model Architecture. The architecture of our Intuitive
Reasoning Network (IRENE) is shown in Figure 2. Acontext
encoder parses the agent’s past trajectories (i.e. state-action
pairs) into a context vector, and a prediction net predicts the
future behaviour of the agent based on the context and the
current state. In the state encoder, a feature fusion module
combines the node features ( type, position, colour,
shape). For each node vij ∈ Vij, each feature vk
ij is first
embedded using a linear layer fk. Then, type, colour,
and shape are concatenated and passed through a first fu-
sion layer consisting of a ReLU activation (Fukushima 1975;
Nair and Hinton 2010) and a linear layer fF1. The output is
concatenated with the position embedding and passed
through the second fusion layer, analogous to the first:
vt,s,c
ij = fF1 (ReLU(
M
k=type,
shape,colour
fk(vk
ij))), (1)
v′
ij = fF2 (ReLU(fposition(vposition
ij ) ⊕ vt,s,c
ij )), (2)
where ⊕ indicates concatenation. The resulting vector con-
stitutes the input feature for the GNN that performs message
passing to update the node embeddings and produces a state
embedding hij by applying a final graph average pooling
operation:
hij = AvgPooling(ϕ(v′
ij, eij)). (3)
As different edges represent different relations, ϕ is a Re-
lational GNN (Schlichtkrull et al. 2018) which uses differ-
ent weights for each edge type. In particular, we use Graph-
SAGE layers with LSTM aggregation (Hamilton, Ying, and
Leskovec 2017).
In the context encoder, the state encoder outputs an em-
bedding vector hij for each frame graph Gij, obtained by
applying average pooling to the nodes. Then, the encoded
states {hij}j=1,...,T are concatenated to the corresponding
actions {aij}j=1,...,T and projected to the transformer input
dimension by a linear layer fproj. A learnable CTX token
is concatenated to each embedding vector. Thereafter, po-
sitional embedding is added, followed by layer normalisa-
tion (Ba, Kiros, and Hinton 2016). The result is input into a
transformer encoder ψ:
CTX′
i = ψ
 
fproj ({hij}T
j=1 ⊕ {aij}T
j=1) ⊕ CTXi

(4)
and the output CTX′
i are taken as trial representations. The
context encoder outputs a single context embedding ob-
tained by computing the mean of the eight familiarisation
trial representations,
c = 1
8
8X
i=1
CTX′
i. (5)
In the prediction net, a test frame graph G9,j = (V9j, E9j)
is encoded by the same state encoder (Eq. 1, 2, 3). The re-
sulting state embedding h9j is concatenated to the context
Evaluation Task BC-MLP BC-RNN Video-RNN VT IRENE
Preference 26.3 48.3 47.6 80.8 48.5
Multi-Agent 48.7 48 .2 50 .3 49.2 74.9
Inaccessible Goal 76.9 81.6 74.0 85 .5 85.8
Eff. Path Control 94.0 92 .8 99.2 97.5 98.1
Eff. Time Control 99.1 99 .1 99 .9 99.7 100.0
Eff. Irrational Agent73.8 56.5 50.1 34 .1 85.7
Eff. Action Average88.8 82.5 83.1 77.1 94.7
Inst. No Barrier 98.8 98.8 99.7 97.9 78.4
Inst. Incons. Barrier55.2 78 .2 77.0 91.9 52.4
Inst. Blocking Barrier47.1 56 .8 62.9 64.2 83.5
Inst. Action Average67.0 77.9 79.9 84.7 71.5
Table 1: V oE accuracy of existing models and IRENE on the
BIB evaluation set. Best score is in bold, second best score
is underlined, third best score is italic.
embedding c and input into an MLP policy ρ that outputs
the next action prediction:
apred = ρ(c ⊕ h9j), (6)
which in our case is represented by the agent’s next position
in the grid-world.
Experiments
Technical Details
IRENE’s feature fusion module encodes the node features
using linear layers of hidden dimension 96. The state en-
coder consists of two GraphSAGE layers for each rela-
tion, with hidden dimension 96 and ELU activation (Clev-
ert, Unterthiner, and Hochreiter 2015). The transformer en-
coder consists of a stack of six layers with four atten-
tion heads, feedforward dimension 512 and GELU activa-
tions (Hendrycks and Gimpel 2016). The prediction net uses
the same GNN and feature fusion module used in the con-
text encoder. The MLP policy has hidden dimensions 256,
128 and 256 and output dimension two, corresponding to the
(x, y) coordinates of the agent in the next frame. Additional
training details are reported in the Appendix.
Results
We compare IRENE with the three models originally pro-
posed by Gandhi et al. (Gandhi et al. 2021) – BC-MLP,
BC-RNN, and Video-RNN – as well as the more recent VT
model by Hein et al. (Hein and Diepold 2022). The V oE ac-
curacy scores on all evaluation tasks, averaged over three
different runs, are shown in Table 1. Given that results did
not vary much across different runs, we only report the er-
rors for all evaluations in the Appendix. In line with previ-
ous work (Gandhi et al. 2021; Hein and Diepold 2022), we
calculated expectedness as the maximum prediction error.
We additionally evaluated our model using the mean predic-
tion error and report these results in the Appendix. As can
be seen from Table 1, our model achieves state-of-the-art
results on three out of five tasks ( Multi-Agent, Inaccessible
Goal, Efficient Action). Moreover, when also considering the
Efficient Action and Instrumental Action sub-tasks, IRENE
achieves state-of-the-art results on five out of nine tasks. We
BIB Task LSTM GCN Local Remote IRENE
Preference 48.2 49 .7 49 .8 50 .7 48 .5
Multi-Agent 49.7 50 .3 98 .2 50 .0 79 .4
Inaccessible Goal 84.8 58 .1 41 .1 80 .6 85 .8
Eff. Path Control 97.3 94 .7 31 .7 98 .2 98 .1
Eff. Time Control 99.9 98 .5 37 .6 99 .8 100 .0
Eff. Irrational Agent52.4 89 .3 99 .7 83 .6 85 .7
Eff. Action Average 83.2 94 .2 56 .3 93 .9 94 .7
Inst. No Barrier 78.5 64 .6 51 .6 78 .7 78 .4
Inst. Incons. Barrier 53.3 52 .1 52 .4 52 .7 52 .4
Inst. Blocking Barrier83.2 48 .0 48 .9 83 .8 83 .5
Inst. Action Average71.7 54 .8 51 .0 71 .7 71 .5
Table 2: V oE accuracy for ablated versions of IRENE.
“LSTM” makes use of an LSTM context encoder instead of
the transformer; “GCN” substitutes GraphSAGE with GCN
layers; “Local” takes as input relational graphs with only
local directional relations; and “Remote” takes as input re-
lational graphs with only remote directional relations.
conducted t-tests to compare IRENE’s performance with the
baselines. All results were significant (α = 0.05, p <0.01)
with only two exceptions: Preference between IRENE and
BC-RNN; Time Control between IRENE and Video-RNN.
The larger improvements are in the Multi-Agent, Instrumen-
tal Blocking Barrier and Efficiency Irrational Agent tasks.
In the Multi-Agent task, IRENE dramatically outperforms
the other models, improving over the previous best score
(Video-RNN) by 48.9 %. In the Instrumental Blocking Bar-
rier sub-task, our model improves by 30 %on the previ-
ous best score (VT). In the Efficiency Irrational Agent task,
IRENE outperforms BC-MLP by 16 %. This results in an
improvement in the Efficient Action task of 6.6 %with re-
spect to the previous best model (BC-MLP). Similar to the
baseline methods, our model performs well on thePath Con-
trol and Time Control sub-tasks. Remarkably, the score on
the Time Control sub-task is perfect. Scores on the No Bar-
rier and Inconsequential Barrier tasks are lower than those
of the other methods. Overall, our model struggles the most
in the Preference (48.5) and Instrumental Action tasks (aver-
age 71.5), especially in the Inconsequential Barrier (52.4).
Ablation Studies
To investigate how different components of our method con-
tribute to these performance improvements, we performed a
series of ablation studies summarised in Table 2.
Graph Relations. We trained IRENE on graphs whose
edges represent only local or remote directional relations.
Using only local directional relations, the performance on
the Multi-Agent and Efficiency Irrational Agent tasks im-
proved to an almost perfect score. However, performance on
other tasks became worse, especially in the Time and Path
Control sub-tasks that other models solved almost perfectly.
This decrease in performance was to be expected as using lo-
cal relations alone leaves many nodes isolated, including the
agent’s node. As a consequence, the message passing is lack-
ing important information, such as the presence of obstacles
that are not adjacent to the agent or to the objects. Using only
Pref. Multi
Agent
Inacc.
Goal
Efficient
Action
Instr.
Action
Training tasks combination
IMP
IMS
IPS
MPS
PS
MP
IP
MS
IS
IM
P
M
I
S
Relative difference with respect to PMSI
-1.5 -23.5 -12.5 -8.0 0.6
0.2 -24.9 -15.6 -7.1 0.6
0.1 -25.9 1.1 -1.5 1.0
0.5 1.7 -7.9 -1.4 8.9
0.0 -23.0 0.9 0.1 8.2
-0.8 6.1 -25.0 -9.6 4.8
-0.9 -23.3 -33.6 -11.1 -0.9
-0.5 -24.7 -3.3 -5.4 13.4
-1.1 -19.2 -8.5 -7.4 0.3
0.7 -23.9 -20.5 -13.0 0.0
0.0 -26.2 -40.3 -39.1 -2.7
-2.0 -23.5 -12.4 -12.4 2.6
1.0 -23.7 -20.0 -15.6 0.3
1.4 -26.0 -7.9 -6.3 15.8
40
30
20
10
0
10
Figure 3: Relative difference of V oE scores obtained on the
evaluation set by training on all possible combinations of
training tasks with respect to training on all tasks.
remote relations, performance is comparable to the original
model except for Multi-Agent, which is at chance level. In
combination, this suggests that global relations contribute
more to the final scores than local ones.
State Encoder . We replaced the GraphSAGE layers with
GCN layers in the state encoder. The resulting model
achieved considerably worse scores in the Multi-Agent, In-
accessible Goal, Instrumental No Barrier and Blocking Bar-
rier (sub-)tasks. This suggests that GraphSAGE is more ef-
fective for modelling obstacles and, as such, is key for our
model to better understand the role of blocking barriers and
to bind preferences to specific agents.
Context Encoder . We also replaced the transformer en-
coder ψ with an LSTM. Performance remained mostly un-
changed except for theMulti-Agent and Efficiency Irrational
Agent tasks where performance dropped to chance level.
This is in line with (Gandhi et al. 2021) who showed that
models with an LSTM failed to adapt their predictions ac-
cording to whether an agent was rational or irrational dur-
ing familiarisation. In combination with the results obtained
when substituting GraphSAGE with GCN, this shows that
good performance on the Multi-Agent task can be obtained
only by including both GraphSAGE and a transformer in the
model architecture.
Analysis of the Training Tasks
Prior work on the BIB has focused on improving perfor-
mance (Gandhi et al. 2021; Hein and Diepold 2022) while
the question of if and how the choice of training task(s) im-
pacts performance remains under-explored. This is surpris-
ing given that, similar to human learning (Clarke and Roche
2010), it is reasonable to assume that computational mod-
els also benefit more from some training tasks than others.
To fill this gap, we performed the first investigations into
the influence of training tasks on evaluation performance.
New
Loc.
New
Obj.
1.0
0.5
0.0
0.5
1.0
Preference
New
Agent
Original
Agent
Multi-Agent
Inacc. Acc.
Inaccessible Goal
Eff. Ineff.
1.0
0.5
0.0
0.5
1.0
Efficient
Action
Eff. Ineff.
Inefficient
Action
Goal
Object
T ool
Instrumental
Action
Infant
BC-MLP
BC-RNN
Video-RNN
VT
IRENE
Figure 4: Z-scored means of infants’ looking times and mod-
els’ scores for expected and unexpected outcomes in the BIB
evaluation episodes. Positive values indicate expectedness,
negative values indicate unexpectedness.
To this end, we trained IRENE on the four individual tasks
as well as on all of their possible combinations. To indi-
cate a combination of training tasks, we used the follow-
ing notation: P = No-Navigation Preference, M = Single-
Object Multi-Agent, I = Agent-Blocked Instrumental Action,
S = Single-Object. For example, IMP indicates joint training
on Agent-Blocked Instrumental Action, Single-Object Multi-
Agent, and No-Navigation Preference tasks.
Relative differences in performance scores compared to
training on all tasks are shown in Figure 3 (absolute scores
are reported in the Appendix). Training only on a subset of
tasks generally leads to a decrease in performance – in some
cases drastic. This demonstrates the importance but also the
effectiveness of IRENE in extracting and combining knowl-
edge gained from different training tasks. One notable ex-
ception is when training on MPS: in this case the total av-
erage performance is comparable to full training ( 75.1 vs.
75.4). In particular, the score on the Inaccessible Goal task
is worse (77.7) while the one on theInstrumental Action task
is better (80.4), despite the model not having been trained on
I. Such improvement is due to better scores on sub-tasks in
which blocking barriers are absent or irrelevant: No Barrier
(84.8) and Inconsequential Barrier (92.7).
Training on S improved scores both on the No Barrier
and Inconsequential Barrier sub-tasks, resulting in a higher
score in the Instrumental Action task. When training on M,
performance on the Multi-Agent task is considerably worse
and training on P does not lead to improvements in thePref-
erence task. This is in line with the general observation that
training on one type of task does not always improve perfor-
mance for similar types of tasks in the evaluation set.
When trained on a subset of the tasks, performance scores
show a similar pattern. When IRENE is trained on P and M
but not on I (i.e. MPS, MP), performance on Multi-Agent is
good. Considering each evaluation task, while performance
on the Preference task remains unchanged, it degrades no-
tably for Multi-Agent, Inaccessible Goal, and Efficient Ac-
tion in most cases. The score on theInstrumental Action task
increased for selected combinations of training tasks (MPS,
PS, MS, S), especially in MS and S.
Comparison to Infants’ Intuitions
Figure 4 shows a comparison between the z-scored means
of infants’ looking times as collected by Stojni´c et al. (2023)
and the corresponding models’ scores for expected and un-
expected evaluation trials. As can be seen from the fig-
ure, our model’s expectations generally align with those
of the infants, specifically for the Inaccessible Goal , Ef-
ficient Action , Inefficient Action , and Instrumental Action
tasks. IRENE performs better in the Inefficient Action task
in which the other models are more surprised at the ex-
pected outcome than the unexpected one. One notable out-
lier is Multi-Agent for which infant behaviour differs from
all models. As reported by (Stojni ´c et al. 2023), this can be
explained by infants not always reacting as expected.
Discussion
Our experiments demonstrate the effectiveness of our model
in addressing intuitive psychology tasks. IRENE outper-
forms the state of the art for three out of five reasoning
tasks on the challenging Baby Intuitions Benchmark – in
some cases with significant improvements (see Table 1).
More specifically, IRENE better learns to bind preferences
to specific agents and to model the role of blocking barriers.
This suggests that, in contrast to existing models (Gandhi
et al. 2021; Hein and Diepold 2022), IRENE relies less on
heuristics, such as directly moving towards the goal object.
However, this also leads to lower scores on sub-tasks for
which such simple heuristics are sufficient and which, con-
sequently, allow models that employ them to perform better.
One example of this is the Instrumental Action tasks, where
models that did not learn the role of barriers during training
apply a simple heuristic – i.e. directly moving towards the
goal object – that works on the Instrumental No Barrier and
Inconsequential Barrier sub-tasks but not on the more chal-
lenging Blocking Barrier sub-task. In contrast, IRENE has
proven to be effective in handling complex tasks that cannot
be tackled by heuristics alone. This highlights the impor-
tance of training models that can truly reason, rather than
just applying shortcuts or heuristics, and resonates with the
well known problem of reward hacking in deep reinforce-
ment learning (Amodei et al. 2016). IRENE represents an
important advancement on this challenging endeavour. Our
model also obtains near-perfect or perfect scores on thePath
Control and Time Control sub-tasks, demonstrating that it
can effectively find the shortest path to an object goal. The
improved score on the Efficient Action task suggests that
IRENE can also better model rational agents’ behaviour. In
particular, in the Irrational Agent sub-task, our model can
distinguish between rational agents that move efficiently to-
wards their goal and irrational agents that are not as efficient.
The Irrational Agent is also the task in which the IRENE z-
scored mean is the closest to the infants’ (see Fig. 4).
Our ablation studies (see Table 2) demonstrate the ef-
fectiveness of the proposed combination of GraphSAGE
for agent and world state encoding with a transformer for
task context encoding. We speculate GraphSAGE performs
well thanks to inductivity: learning an aggregator allows the
model to effectively generate embeddings for nodes which
the model only sees during the evaluation trials. In addition,
the non-sequential nature of the transformer together with
its self-attention mechanism allow it to overcome LSTM
limitations. We also performed an extensive analysis to bet-
ter understand the importance of the chosen training tasks
on evaluation performance. Our results confirm the require-
ments set by Gandhi et al. (2021) who have argued that
models have to combine knowledge from different train-
ing tasks: IRENE performs best when trained on all train-
ing tasks while training only on a subset of tasks generally
leads to a decrease in performance (see Fig. 3). Exceptions
are mainly due to a lack of knowledge of blocking barriers,
which results in the effective heuristic of ignoring them al-
together.
Limitations and Future Work. By working on IRENE
we identified several points that we believe are crucial for fu-
ture work. First, IRENE does not perform better on all tasks
– just like the previous models we compared it to. This sug-
gests that further advances are still needed. To fully solve
the BIB tasks, it may also be necessary to learn complemen-
tary basic concepts, such as from intuitive physics. Second,
besides notable exceptions such as the BIB, advances on in-
tuitive psychology are currently slowed down by the lack
of accessible and well-maintained benchmarks. In particu-
lar, we would have liked to evaluate our model on AGENT
(Shu et al. 2021) – that covers an interesting environment
and complementary set of challenging reasoning tasks – but
AGENT does not provide any benchmark or model code.
Despite our significant efforts, re-implementing the method
and reproducing the results based solely on the information
provided in the paper turned out to be an extremely challeng-
ing task. Likely because of this also no other papers have
evaluated on AGENT to date. There is an urgent need for
the community to design and create new benchmarks to fos-
ter the development of “general neural common-sense rea-
soners”. Third, despite the general trend of designing bench-
marks to be used only for evaluation (Weihs et al. 2022), fu-
ture work should also explore how introducing new training
tasks allows models to learn more effectively. This resonates
with our suggestion to train models on data representing dif-
ferent basic concepts.
Conclusion
In this work we have proposed IRENE – a novel neural net-
work for reasoning about agents’ goals, preferences, and ac-
tions. IRENE sets new state-of-the-art on three out of five
tasks on the Baby Intuitions Benchmark, with improved
modelling of agents’ preferences, obstacle handling, and
distinguishing between rational and irrational agents. We
also demonstrated the effectiveness of IRENE in combin-
ing knowledge gained during training for unseen evaluation
tasks. These results are not only promising for advancing
human-like reasoning in AI systems but also shed new light
on the importance of the choice of training tasks for good
generalisation performance.
Acknowledgements
M. Bortoletto and A. Bulling were funded by the European
Research Council (ERC) under the European Union’s Hori-
zon 2020 research and innovation programme under grant
agreement No 801708. L. Shi was funded by the Deutsche
Forschungsgemeinschaft (DFG, German Research Founda-
tion) under Germany’s Excellence Strategy – EXC 2075 –
390740016. The authors would like to especially thank Pavel
Denisov, Hsiu-Yu Yang, Ekta Sood, and Manuel Mager
for numerous insightful discussions, and thank Ann-Sophia
M¨uller and Constantin Ruhdorfer for their technical support.
References
Aguiar, A.; and Baillargeon, R. 1999. 2.5-month-old infants’
reasoning about when objects should and should not be oc-
cluded. Cognitive Psychology, 39(2): 116–157.
Amodei, D.; Olah, C.; Steinhardt, J.; Christiano, P.; Schul-
man, J.; and Man ´e, D. 2016. Concrete Problems in AI
Safety. arXiv preprint arXiv:1606.06565.
Ates, T.; Atesoglu, M. S.; Yigit, C.; Kesen, I.; Kobas, M.;
Erdem, E.; Erdem, A.; Goksun, T.; and Yuret, D. 2022.
CRAFT: A Benchmark for Causal Reasoning About Forces
and inTeractions. Findings of the Association for Computa-
tional Linguistics.
Ba, J. L.; Kiros, J. R.; and Hinton, G. E. 2016. Layer Nor-
malization. arXiv preprint arXiv:1607.06450.
Baillargeon, R. 1987. Object Permanence in 3 1/2- and 4
1/2-Month-Old Infants. Developmental Psychology, 23(5):
655–664.
Baker, C.; Saxe, R.; and Tenenbaum, J. 2011. Bayesian The-
ory of Mind: Modeling Joint Belief-Desire Attribution. In
Proceedings of the Annual Meeting of the Cognitive Science
Society, volume 33.
Baker, C. L.; Jara-Ettinger, J.; Saxe, R.; and Tenenbaum,
J. B. 2017. Rational quantitative attribution of beliefs, de-
sires and percepts in human mentalizing. Nature Human
Behaviour, 1(4): 1–10.
Baron-Cohen, S. 1997. Mindblindness: An Essay on Autism
and Theory of Mind. MIT Press.
Battaglia, P. W.; Hamrick, J. B.; and Tenenbaum, J. B. 2013.
Simulation as an engine of physical scene understanding. In
Proceedings of the National Academy of Sciences , volume
110, 18327–18332. National Acad Sciences.
Bhagavatula, C.; Bras, R. L.; Malaviya, C.; Sakaguchi, K.;
Holtzman, A.; Rashkin, H.; Downey, D.; Yih, W.; and Choi,
Y . 2020. Abductive Commonsense Reasoning. In 8th In-
ternational Conference on Learning Representations, ICLR
2020, Addis Ababa, Ethiopia, April 26-30, 2020 . OpenRe-
view.net.
Bisk, Y .; Zellers, R.; Bras, R. L.; Gao, J.; and Choi, Y . 2020.
PIQA: Reasoning about Physical Commonsense in Natural
Language. In The Thirty-Fourth AAAI Conference on Ar-
tificial Intelligence, AAAI 2020, The Thirty-Second Innova-
tive Applications of Artificial Intelligence Conference, IAAI
2020, The Tenth AAAI Symposium on Educational Advances
in Artificial Intelligence, EAAI 2020, New York, NY, USA,
February 7-12, 2020, 7432–7439. AAAI Press.
Clarke, D.; and Roche, A. 2010. Teachers’ Extent of the
Use of Particular Task Types in Mathematics and Choices
behind That Use. Mathematics Education Research Group
of Australasia.
Clevert, D.-A.; Unterthiner, T.; and Hochreiter, S. 2015. Fast
and Accurate Deep Network Learning by Exponential Lin-
ear Units (ELUs). International Conference on Learning
Representations.
Conti, C. J.; Varde, A. S.; and Wang, W. 2022. Human-
Robot Collaboration With Commonsense Reasoning in
Smart Manufacturing Contexts. IEEE Transactions on Au-
tomation Science and Engineering.
Dasgupta, A.; Duan, J.; Ang Jr, M. H.; Lin, Y .; Wang, S.-h.;
Baillargeon, R.; and Tan, C. 2021. A Benchmark for Model-
ing Violation-of-Expectation in Physical Reasoning Across
Event Categories. arXiv preprint arXiv:2111.08826.
Fukushima, K. 1975. Cognitron: A self-organizing multi-
layered neural network. Biological Cybernetics, 20(3): 121–
136.
Gandhi, K.; Stojnic, G.; Lake, B. M.; and Dillon, M. R.
2021. Baby Intuitions Benchmark (BIB): Discerning the
goals, preferences, and actions of others. Advances in Neu-
ral Information Processing Systems, 34: 9963–9976.
Gergely, G.; N´adasdy, Z.; Csibra, G.; and B´ır´o, S. 1995. Tak-
ing the intentional stance at 12 months of age. Cognition,
56(2): 165–193.
Gori, M.; Monfardini, G.; and Scarselli, F. 2005. A new
model for learning in graph domains. In IEEE International
Joint Conference on Neural Networks, volume 2, 729–734.
Hamilton, W.; Ying, Z.; and Leskovec, J. 2017. Inductive
Representation Learning on Large Graphs. Advances in
Neural Information Processing Systems, 30.
Harris, C. R.; Millman, K. J.; van der Walt, S. J.; Gommers,
R.; Virtanen, P.; Cournapeau, D.; Wieser, E.; Taylor, J.; Berg,
S.; Smith, N. J.; Kern, R.; Picus, M.; Hoyer, S.; van Kerk-
wijk, M. H.; Brett, M.; Haldane, A.; del R ´ıo, J. F.; Wiebe,
M.; Peterson, P.; G´erard-Marchant, P.; Sheppard, K.; Reddy,
T.; Weckesser, W.; Abbasi, H.; Gohlke, C.; and Oliphant,
T. E. 2020. Array programming with NumPy. Nature,
585(7825): 357–362.
Hein, A.; and Diepold, K. 2022. Comparing Intuitions about
Agents’ Goals, Preferences and Actions in Human Infants
and Video Transformers. In Shared Visual Representations
in Human and Machine Intelligence Workshop at Advances
in Neural Information Processing Systems.
Hendrycks, D.; and Gimpel, K. 2016. Gaussian Error Linear
Units (GELUs). arXiv preprint arXiv:1606.08415.
Huang, L.; Le Bras, R.; Bhagavatula, C.; and Choi, Y . 2019.
Cosmos QA: Machine Reading Comprehension with Con-
textual Commonsense Reasoning. In Proceedings of the
2019 Conference on Empirical Methods in Natural Lan-
guage Processing and the 9th International Joint Confer-
ence on Natural Language Processing (EMNLP-IJCNLP) ,
2391–2401.
Hunter, J. D. 2007. Matplotlib: A 2D graphics environment.
Computing in Science & Engineering, 9(3): 90–95.
Jiang, Z.; Minervini, P.; Jiang, M.; and Rockt¨aschel, T. 2021.
Grid-to-Graph: Flexible Spatial Relational Inductive Biases
for Reinforcement Learning. In Proceedings of the 20th
International Conference on Autonomous Agents and Multi
Agent Systems, 674–682.
Kingma, D. P.; and Ba, J. 2014. Adam: A Method
for Stochastic Optimization. International Conference on
Learning Representations (Poster).
McCarthy, J. 1989. Artificial Intelligence, Logic and For-
malizing Common Sense. In Philosophical Logic and Arti-
ficial Intelligence, 161–190. Springer.
Mota, T.; and Sridharan, M. 2019. Commonsense Reason-
ing and Knowledge Acquisition to Guide Deep Learning on
Robots. In Robotics: science and systems.
Nair, V .; and Hinton, G. E. 2010. Rectified Linear Units
Improve Restricted Boltzmann Machines. In International
Conference on Machine Learning.
Needham, A.; and Baillargeon, R. 1993. Intuitions about
support in 4.5-month-old infants. Cognition, 47(2): 121–
148.
Neimark, D.; Bar, O.; Zohar, M.; and Asselmann, D.
2021. Video Transformer Network. In Proceedings of the
IEEE/CVF International Conference on Computer Vision ,
3163–3172.
Paszke, A.; Gross, S.; Massa, F.; Lerer, A.; Bradbury, J.;
Chanan, G.; Killeen, T.; Lin, Z.; Gimelshein, N.; Antiga, L.;
et al. 2019. Pytorch: An imperative style, high-performance
deep learning library. Advances in Neural Information Pro-
cessing Systems, 32.
Piloto, L.; Weinstein, A.; TB, D.; Ahuja, A.; Mirza, M.;
Wayne, G.; Amos, D.; Hung, C.-c.; and Botvinick, M. 2018.
Probing Physics Knowledge Using Tools from Develop-
mental Psychology. arXiv preprint arXiv:1804.01128.
Piloto, L. S.; Weinstein, A.; Battaglia, P.; and Botvinick, M.
2022. Intuitive physics learning in a deep-learning model
inspired by developmental psychology. Nature Human Be-
haviour, 1–11.
Rabinowitz, N.; Perbet, F.; Song, F.; Zhang, C.; Eslami,
S. A.; and Botvinick, M. 2018. Machine Theory of Mind.
In International Conference on Machine Learning , 4218–
4227. PMLR.
Reback, J.; McKinney, W.; Van Den Bossche, J.;
Augspurger, T.; Cloud, P.; Klein, A.; Hawkins, S.; Roeschke,
M.; Tratner, J.; She, C.; et al. 2020. pandas-dev/pandas: Pan-
das 1.0. 5. Zenodo.
Riochet, R.; Castro, M. Y .; Bernard, M.; Lerer, A.; Fergus,
R.; Izard, V .; and Dupoux, E. 2020. IntPhys: A Frame-
work and Benchmark for Visual Intuitive Physics Reason-
ing. IEEE Transactions on Pattern Analysis and Machine
Intelligence.
Sakaguchi, K.; Bras, R. L.; Bhagavatula, C.; and Choi,
Y . 2021. WinoGrande: An Adversarial Winograd Schema
Challenge at Scale. Communications of the ACM , 64(9):
99–106.
Sap, M.; Rashkin, H.; Chen, D.; Le Bras, R.; and Choi, Y .
2019. Social IQa: Commonsense Reasoning about Social
Interactions. In Proceedings of the 2019 Conference on Em-
pirical Methods in Natural Language Processing and the 9th
International Joint Conference on Natural Language Pro-
cessing (EMNLP-IJCNLP), 4463–4473.
Schlichtkrull, M.; Kipf, T. N.; Bloem, P.; Berg, R. v. d.;
Titov, I.; and Welling, M. 2018. Modeling Relational Data
with Graph Convolutional Networks. In European Semantic
Web Conference, 593–607. Springer.
Shu, T.; Bhandwaldar, A.; Gan, C.; Smith, K.; Liu, S.; Gut-
freund, D.; Spelke, E.; Tenenbaum, J.; and Ullman, T. 2021.
AGENT: A Benchmark for Core Psychological Reasoning.
In International Conference on Machine Learning , 9614–
9625. PMLR.
Smith, K.; Mei, L.; Yao, S.; Wu, J.; Spelke, E.; Tenenbaum,
J.; and Ullman, T. 2019. Modeling Expectation Violation
in Intuitive Physics with Coarse Probabilistic Object Rep-
resentations. Advances in Neural Information Processing
Systems, 32.
Stojni´c, G.; Gandhi, K.; Yasuda, S.; Lake, B. M.; and Dillon,
M. R. 2023. Commonsense psychology in human infants
and machines. Cognition, 235: 105406.
Vaswani, A.; Shazeer, N.; Parmar, N.; Uszkoreit, J.; Jones,
L.; Gomez, A. N.; Kaiser, Ł.; and Polosukhin, I. 2017. At-
tention Is All You Need. Advances in Neural Information
Processing Systems, 30.
Virtanen, P.; Gommers, R.; Oliphant, T. E.; Haberland,
M.; Reddy, T.; Cournapeau, D.; Burovski, E.; Peterson, P.;
Weckesser, W.; Bright, J.; van der Walt, S. J.; Brett, M.;
Wilson, J.; Millman, K. J.; Mayorov, N.; Nelson, A. R. J.;
Jones, E.; Kern, R.; Larson, E.; Carey, C. J.; Polat, ˙I.; Feng,
Y .; Moore, E. W.; VanderPlas, J.; Laxalde, D.; Perktold, J.;
Cimrman, R.; Henriksen, I.; Quintero, E. A.; Harris, C. R.;
Archibald, A. M.; Ribeiro, A. H.; Pedregosa, F.; van Mul-
bregt, P.; and SciPy 1.0 Contributors. 2020. SciPy 1.0: Fun-
damental Algorithms for Scientific Computing in Python.
Nature Methods, 17: 261–272.
Weihs, L.; Yuile, A. R.; Baillargeon, R.; Fisher, C.; Marcus,
G.; Mottaghi, R.; and Kembhavi, A. 2022. Benchmarking
Progress to Infant-Level Physical Reasoning in AI. Trans-
actions on Machine Learning Research.
Wes McKinney. 2010. Data Structures for Statistical Com-
puting in Python. In St ´efan van der Walt; and Jarrod Mill-
man, eds., Proceedings of the 9th Python in Science Confer-
ence, 56 – 61.
Yi, K.; Gan, C.; Li, Y .; Kohli, P.; Wu, J.; Torralba, A.; and
Tenenbaum, J. B. 2020. CLEVRER: Collision Events for
Video Representation and Reasoning. International Confer-
ence on Learning Representations.
Zellers, R.; Holtzman, A.; Bisk, Y .; Farhadi, A.; and Choi,
Y . 2019. HellaSwag: Can a Machine Really Finish Your
Sentence? In Proceedings of the 57th Annual Meeting of the
Association for Computational Linguistics, 4791–4800.
Zhi-Xuan, T.; Gothoskar, N.; Pollok, F.; Gutfreund, D.;
Tenenbaum, J. B.; and Mansinghka, V . K. 2022. Solving the
Baby Intuitions Benchmark with a Hierarchically Bayesian
Theory of Mind. Robotics: Science and Systems Workshop
on Social Intelligence in Humans and Robots.
Appendix
BIB Dataset Details
The BIB evaluation set contains different numbers of videos
for different tasks. Videos have been recorded at 25 FPS
with a resolution of 200 × 200 pixels. The five common-
sense reasoning tasks in the evaluation set are the following:
• Preference task: understand that an agent has a preferred
goal object;
• Multi-Agent task: bind preferences to specific agents;
• Inaccessible Goal task: understand the role of physical
obstacles and predict that an agent will approach another
object if the preferred one is not accessible;
• Efficient Action task: this task consists of three sub-tasks.
Learn that a rational agent will move efficiently towards
its goal in terms of (a) spatial distance ( Efficiency Path
Control) and (b) time ( Efficiency Time Control), as well
as (c) learn to differentiate between rational and irrational
agents (Efficiency Irrational Agent);
• Instrumental Action task: understand that agents remove
blocking barriers if it allows them to attain a higher-level
goal. The task consists of three sub-tasks, depending on
whether the barrier is (a) absent ( Instrumental No Bar-
rier), (b) blocking the goal object ( Instrumental Block-
ing Barrier), or (c) not blocking it ( Instrumental Incon-
sequential Barrier).
The training set presents four tasks that are more trivial and
less informative than the evaluation tasks:
• Single-Object task: an agent moves towards an object at
different locations in the grid-world;
• No-Navigation Preference task: an agent moves towards
a preferred object among two, with both objects very
close to the agent’s initial location;
• Single-Object Multiple-Agent task: similar to the Single-
Object Task but at a designed point in time a second agent
takes the initial agent’s place;
• Agent-Blocked Instrumental Action task: an agent is
trapped within a blocking barrier. To remove the barrier
and reach its goal, the agent first has to collect a key and
insert it into the barrier lock.
This compels models to combine and generalise the knowl-
edge acquired from the different training tasks to solve the
evaluation tasks.
Specifically, we used the evaluation set version 1.1, which
contains the following number of samples:
• Preference: 1,000 videos;
• Multi-Agent: 1,000 videos;
• Inaccessible Goal: 1,111 videos;
• Efficient Action:
– Efficiency Path Control: 1,500 videos;
– Efficiency Time Control: 1,000 videos;
– Efficiency Irrational Agent: 1,000 videos
• Instrumental Action:
– Instrumental No Barrier: 999 videos;
– Instrumental Blocking Barrier: 327 videos;
– Instrumental Inconsequential Barrier: 330 videos.
The training set contains:
• Single-Object: 8,000 videos;
• No-Navigation Preference: 7,985 videos;
• Single-Object Multiple-Agent: 3,200 videos;
• Agent-Blocked Instrumental Action: 3,200 videos.
Each video is paired with a json file containing information
about the grid-world layout, which we use to build frame
graphs.
Graph relations
Based on (Jiang et al. 2021), we built a graph for each
video frame with edges representing different spatial rela-
tions. Given two entities a and b in the grid-world, local di-
rectional relations are defined as
RightAdj(a, b) ← (xa = xb + l) ∧ (ya = yb),
LeftAdj(a, b) ← (xa = xb − l) ∧ (ya = yb),
TopAdj(a, b) ← (ya = yb + l) ∧ (xa = xb),
BottomtAdj(a, b) ← (ya = yb − l) ∧ (xa = xb),
TopRightAdj(a, b) ← (xa = xb + l) ∧ (ya = yb + l),
TopLeftAdj(a, b) ← (xa = xb − l) ∧ (ya = yb + l),
BottomRightAdj(a, b) ← (xa = xb + l) ∧ (ya = yb − l),
BottomLeftAdj(a, b) ← (xa = xb − l) ∧ (ya = yb − l).
where l is the spacing of the grid. Remote directional rela-
tions are defined as
Right(a, b) ← xa > xb,
Left(a, b) ← xa < xb,
Top(a, b) ← ya > yb,
Bottom(a, b) ← ya < yb.
Alignment and adjacency relations are defined as
Aligned(a, b) ← (xa = xb) ∨ (ya = yb),
Adjacent(a, b) ← (|xa − xb| ≤l) ∧ (|ya − yb| ≤l).
Technical Details
We trained IRENE for 32 epochs using the Adam opti-
miser (Kingma and Ba 2014) with β1 = 0.9, β2 = 0.99,
ϵ = 10−8 and learning rate η = 5·10−4. 80 %of the training
episodes were used for training while the rest were used for
validation. We selected hyperparameters empirically, i.e. did
Evaluation Task BC-MLP BC-RNN Video-RNN VT IRENE
Preference 26.3 48 .3 47.6 80.8 ± 0.0 48 .5 ± 0.0
Multi-Agent 48.7 48 .2 50 .3 49 .2 ± 0.0 74.9 ± 0.0
Inaccessible Goal 76.9 81 .6 74.0 85 .5 ± 0.0 85.8 ± 0.0
Eff. Path Control 94.0 92 .8 99.2 97 .5 ± 0.0 98 .1 ± 0.0
Eff. Time Control 99.1 99 .1 99 .9 99 .7 ± 0.0 100.0 ± 0.0
Eff. Irrational Agent 73.8 56 .5 50.1 34 .1 ± 0.1 85.7 ± 0.4
Eff. Action Average 88.8 82.5 83 .1 77.1 ± 0.0 94.7 ± 0.1
Inst. No Barrier 98.8 98.8 99.7 97 .9 ± 0.0 78 .4 ± 0.0
Inst. Incons. Barrier 55.2 78 .2 77.0 91.9 ± 0.0 52 .4 ± 0.0
Inst. Blocking Barrier 47.1 56 .8 62 .9 64.2 ± 0.1 83.5 ± 0.4
Inst. Action Average 67.0 77 .9 79.9 84.7 ± 0.0 71 .5 ± 0.1
Table 3: V oE accuracy of existing models and IRENE on the BIB evaluation set. Best score is in bold, second best score is
underlined, third best score is italic.
not perform any exhaustive hyperparameter tuning. All ex-
periments were conducted on a single NVIDIA Tesla V100
GPU with 32 GB VRAM and a batch size of 32.
We trained our models using PyTorch (Paszke et al. 2019)
with 7, 42 and 123 as random seeds. We performed our data
analysis using NumPy (Harris et al. 2020), Pandas (Reback
et al. 2020; Wes McKinney 2010), and SciPy (Virtanen et al.
2020). Figures were made using Matplotlib (Hunter 2007).
V oE Scores
V oE accuracy scores and error of existing models and
IRENE on the BIB evaluation set are reported in Table 3. As
discussed in the Discussion section, in contrast to existing
methods, IRENE relies less on heuristics, such as directly
moving towards the goal object. This leads to lower scores
on sub-tasks for which simple heuristics are sufficient. For
example, let us consider the Instrumental Action tasks. In
such tasks, models that did not learn the role of barriers dur-
ing training apply a simple heuristic -– i.e. directly moving
towards the goal object — that works on the Instrumental
No Barrier and Inconsequential Barrier sub-tasks but not on
the more challenging Blocking Barrier sub-task. In contrast,
IRENE is effective for complex tasks that cannot be tackled
by heuristics alone. This highlights the importance of train-
ing models that can truly reason, rather than just applying
shortcuts or heuristics.
Expectedness: Max vs. Mean.
Gandhi et al. have defined the expectedness of a test
trial as the model’s maximum prediction error on the trial
frames (Gandhi et al. 2021). The authors justified their
choice by claiming that alternatives, like using the mean,
consistently resulted in lower scores. In contrast, Hein et
al. have obtained higher scores when using the mean (Hein
and Diepold 2022). Table 4 shows that for IRENE, using the
mean leads to comparable scores to using the maximum for
most of the tasks, with the exception of Instrumental Block-
ing Barrier (improvement), Multi-Agent (deterioration) and
Efficiency Irrational Agent Agent(deterioration). To be com-
parable to the baseline models, in the main text we report
results using the maximum prediction error.
Ablation Studies – Absolute scores
Table 5 shows absolute scores with errors for our analysis of
the training tasks.
Analysis of the Training Tasks – Absolute scores
Table 6 shows absolute scores with errors for our analysis of
the training tasks.
Analysis of the Training Tasks – Relation Between
Training Tasks
The relation between different training task combinations
and performance change (see Figure 3 in the main text)
raises some interesting discussion points, which we report
in the following.
Training on M, MP, and IMP . We noticed that training
on M only does not boost performance for Multi-Agent, but
training on MP does. Yet, training on IMP again decreased
the performance on M.
Training on M does not improve performance for Multi-
Agent because, when training on M, the preferred object
is always located close to the agent’s initial location. In
these training samples the agent hardly moves and when our
model is exclusively trained on M, it thus fails to grasp the
dynamics of how agents should move. Consequently, when
tested in a Multi-Agent scenario where the agent needs to
navigate and reach preferred objects situated at various lo-
cations in the gridworld, the performance suffers.
However, training on MP increases performance. This is
directly related to the first point. When our model is exclu-
sively trained on M, it fails to grasp the dynamics of how
agents should move. However, in P the agent moves to var-
ious locations of the grid, allowing our model to learn how
agents move. This results in a boost in performance.
IMP again decreased the performance on Multi-Agent.
This happens because I is unrelated to Multi-Agent. In I, an
Evaluation Task VT VT (mean) IRENE IRENE (mean)
Preference 80.8 ± 0.0 82 .1 ± 0.0 48 .5 ± 0.0 49 .6 ± 0.0
Multi-Agent 49.2 ± 0.0 49 .1 ± 0.0 74 .9 ± 0.0 63 .6 ± 0.5
Inaccessible Goal 85.5 ± 0.0 89 .8 ± 0.0 85 .8 ± 0.0 88 .3 ± 0.1
Eff. Path Control 97.5 ± 0.0 97 .3 ± 0.0 98 .1 ± 0.0 97 .3 ± 0.0
Eff. Time Control 99.7 ± 0.0 99 .8 ± 0.0 100 .0 ± 0.0 100 .0 ± 0.0
Eff. Irrational Agent 34.1 ± 0.1 29 .5 ± 0.1 85 .7 ± 0.4 81 .2 ± 0.6
Eff. Action Average 77.1 ± 0.0 75 .5 ± 0.0 94 .7 ± 0.1 92 .9 ± 0.2
Inst. No Barrier 97.9 ± 0.0 98 .7 ± 0.0 78 .4 ± 0.0 83 .8 ± 0.0
Inst. Incons. Barrier 91.9 ± 0.0 96 .9 ± 0.0 52 .4 ± 0.0 52 .4 ± 0.0
Inst. Blocking Barrier 64.2 ± 0.1 82 .1 ± 0.1 83 .5 ± 0.4 99 .4 ± 0.0
Inst. Action Average 84.7 ± 0.0 92 .6 ± 0.0 71 .5 ± 0.1 78 .5 ± 0.0
Table 4: Performance of VT (Hein and Diepold 2022) and IRENE on the BIB evaluation set. Scores evaluate V oE judgements
in which expectedness is expressed as the maximum or mean (when specified) prediction error.
BIB Task LSTM GCN Local Remote IRENE
Preference 48.2 ± 0.0 49 .7 ± 0.0 50 .0 ± 0.2 50 .7 ± 0.0 48 .5 ± 0.0
Multi-Agent 49.7 ± 0.0 50 .3 ± 0.2 98 .0 ± 0.2 50 .0 ± 0.0 74 .9 ± 0.0
Inaccessible Goal 84.8 ± 0.2 58 .1 ± 0.3 41 .7 ± 0.5 71 .6 ± 0.0 85 .8 ± 0.0
Eff. Path Control 97.3 ± 0.0 94 .7 ± 0.0 31 .8 ± 0.1 90 .8 ± 0.1 98 .1 ± 0.0
Eff. Time Control 99.9 ± 0.0 98 .5 ± 0.0 37 .2 ± 0.3 99 .3 ± 0.5 100 .0 ± 0.0
Eff. Irrational Agent 52.4 ± 0.1 89 .3 ± 0.1 99 .4 ± 0.3 79 .2 ± 0.8 85 .7 ± 0.4
Eff. Action Average 83.2 ± 0.0 94 .2 ± 0.0 56 .1 ± 0.2 93 .9 ± 0.5 94 .7 ± 0.1
Inst. No Barrier 78.5 ± 0.0 64 .6 ± 0.2 50 .7 ± 0.8 78 .4 ± 0.3 78 .4 ± 0.0
Inst. Incons. Barrier 53.3 ± 0.0 52 .1 ± 0.0 52 .8 ± 0.3 52 .7 ± 0.0 52 .4 ± 0.0
Inst. Blocking Barrier 83.2 ± 0.4 48 .0 ± 0.3 45 .6 ± 0.0 83 .1 ± 0.6 83 .5 ± 0.4
Inst. Action Average 71.7 ± 0.1 54 .8 ± 0.2 49 .7 ± 0.4 71 .4 ± 0.3 71 .5 ± 0.1
Table 5: V oE scores for ablated versions of IRENE. “LSTM” makes use of an LSTM context encoder instead of the transformer;
“GCN” substitutes GraphSAGE with GCN layers; “Local” takes as input relational graphs with only local directional relations;
and “Remote” takes as input relational graphs with only remote directional relations.
agent is trapped within a blocking barrier. To remove the
barrier and reach its goal, the agent first has to collect a key
and insert it into the barrier lock. In theMulti-Agent task the
agent is not trapped and there is no key or barrier. Therefore,
performance on Multi-Agent never benefits from training on
I.
Training on MPS We also noticed that training on MPS
causes a decrease in Inaccessible Goal and an increase in
Instrumental Action. In the Inaccessible Goal task, during
the familiarisation trials, the agent navigates to its preferred
object in various locations. In the expected test trials, the
preferred object becomes inaccessible, causing the agent to
go to the non-preferred object. In unexpected test trials the
preferred object is accessible but the agent goes to the non-
preferred object. Training on MPS leads to a decrease in per-
formance on the Inaccessible Goal task because in MPS tri-
als the preferred object is always accessible, and the agent
can always reach it. The increase in performance on the In-
strumental Action task is due to a similar reason. The In-
strumental Action task comprises three sub-tasks. Two of
these sub-tasks, Instrumental No Barrier and Inconsequen-
tial Barrier , can be solved without requiring knowledge
about barriers (the test trials in Instrumental No Barrier
even lack barriers) by just applying simple heuristics. Con-
sequently, a model trained on MPS performs well in these
two tasks but poorly in the more challenging Instrumental
Blocking Barrier task. This performance pattern results in a
higher average score compared to a model that performs bet-
ter in the challenging Blocking Barrier task but not as well
in the other two.
Evaluation Task Training Tasks
IMPS IMP IMS IPS MPS PS MP IP MS IS IM P M I S
Preference 48.5±0.0 47.0±0.0 48.7±0.0 48.6±0.0 49.0±0.0 48.5±0.0 47.7±0.0 47.6±0.0 48.0±0.0 47.4±0.0 49.2±0.0 48.5±0.0 46.5±0.0 49.5±0.0 49.9±0.0
Multi-Agent 74.9±0.0 51.4±0.0 50.0±0.0 49.0±0.0 76.4±0.7 51.9±0.0 80.4±1.3 51.6±0.0 50.3±0.2 55.4±0.7 50.9±0.1 49.9±2.6 51.5±0.1 51.3±0.2 48.9±0.0
Inaccessible Goal 85.8±0.0 73.6±0.2 70.5±0.3 87.0±0.1 77.7±0.2 86.5±0.2 60.7±0.1 52.1±0.1 82.3±0.3 77.4±0.3 65.3±0.1 45.8±0.3 73.2±0.1 65.3±0.3 77.8±0.1
Eff. Path Control 98.1±0.1 90.8±0.2 98.6±0.0 97.5±0.0 94.7±0.0 95.2±0.0 81.7±0.0 81.0±0.0 97.9±0.1 97.8±0.0 94.7±0.0 49.2±0.2 97.3±0.1 89.5±0.0 98.4±0.1
Eff. Time Control100.0±0.0 98.3±0.0 100.0±0.0 99.9±0.0 100.0±0.0 100.0±0.0 95.3±0.0 92.1±0.0 100.0±0.0 100.0±0.0 99.4±0.0 66.4±0.1 99.9±0.0 94.4±0.0 100.0±0.0
Eff. Irrational Agent85.7±0.4 71.1±1.3 63.9±0.2 81.3±0.8 84.9±0.6 88.2±0.7 77.3±0.7 76.0±2.3 70.0±0.4 64.0±0.1 51.1±0.9 50.7±1.3 49.1±0.8 53.3±0.5 66.7±0.5
Eff. Action Average94.7±0.1 86.7±0.5 87.5±0.0 92.9±0.3 93.2±0.2 94.5±0.2 84.7±0.2 83.0±0.8 89.3±0.2 87.3±0.0 81.7±0.3 55.4±0.5 82.1±0.3 79.1±0.2 88.4±0.2
Inst. No Barrier 78.4±0.0 78.9±0.0 79.1±0.1 79.4±0.0 84.8±0.2 84.6±0.1 80.7±0.1 77.1±0.2 87.9±0.1 78.6±0.0 78.4±0.2 69.6±0.2 79.4±0.4 78.5±0.1 89.8±0.2
Inst. Incons. Barrier52.4±0.0 53.6±0.0 53.0±0.0 53.3±0.0 92.7±0.3 91.3±0.9 90.6±0.3 52.4±0.0 94.2±0.6 52.7±0.0 53.0±0.0 73.6±0.0 91.7±1.0 52.1±0.0 95.5±0.6
Inst. Blocking Barrier83.5±0.4 83.5±0.0 84.1±0.0 84.3±0.2 63.6±0.0 63.7±0.2 58.0±0.3 82.6±0.3 71.6±0.0 83.8±0.0 82.7±0.2 62.7±0.3 49.8±0.3 84.4±0.3 75.8±0.0
Inst. Action Average71.5±0.1 72.0±0.0 72.1±0.0 72.3±0.1 80.4±0.1 79.9±0.4 76.4±0.2 70.7±0.1 84.6±0.2 71.7±0.0 71.4±0.1 68.6±0.1 73.6±0.6 71.7±0.1 87.0±0.3
Table 6: V oE scores for all possible combinations of training tasks. We indicate a combination of training tasks with the following notation: P = No-Navigation
Preference, M = Single-Object Multi-Agent, I = Agent-Blocked Instrumental Action, S = Single-Object. For example, IMP means jointly training on No-Navigation
Preference, Single-Object Multi-Agent and Agent-Blocked Instrumental Action.