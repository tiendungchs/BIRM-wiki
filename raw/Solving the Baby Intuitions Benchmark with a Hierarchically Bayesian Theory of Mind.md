---
title: "Solving the Baby Intuitions Benchmark with a Hierarchically Bayesian Theory of Mind"
source: "https://arxiv.org/abs/2208.02914"
author:
  - "[[Tan Zhi-Xuan]]"
  - "[[Nishad Gothoskar]]"
  - "[[Falk Pollok]]"
  - "[[Dan Gutfreund]]"
  - "[[Joshua B. Tenenbaum]]"
  - "[[Vikash K. Mansinghka]]"
published: 2022-08-04
created: 2026-08-13
description: "Unrefereed 5-page arXiv preprint (v1, never revised; DARPA Machine Common Sense). HBToM: hierarchical Bayesian inverse planning with a Dirichlet prior over per-agent goal preferences theta_n and an inverse-Gamma prior over per-agent Boltzmann rationality beta_n, a FEASIBILIZE operation renormalising preferences over reachable goals, and a plausibility readout that is the PRODUCT of three surprise metrics (goal-posterior total variation, efficiency-posterior total variation, log-likelihood change). Pairwise accuracy 96.0-99.7 on every BIB task vs baselines at chance on Preference/Multi-Agent. WHAT IS SUPPLIED: 'Since the BIB dataset provides noise-free observations, the results presented here assume direct access to state variables'; environment dynamics are hand-written in PDDL for this gridworld; the three logistic classifiers' weights are fine-tuned on a synthetic validation set. The promised ablation ('in a future version of this paper') was never run."
tags:
  - "clippings"
  - "theory-of-mind"
  - "inverse-planning"
  - "bayesian"
  - "agency"
  - "hierarchical-priors"
---

Title: Solving the Baby Intuitions Benchmark with a Hierarchically Bayesian Theory of Mind

URL Source: https://arxiv.org/abs/2208.02914

Markdown Content:
Solving the Baby Intuitions Benchmark
with a Hierarchically Bayesian Theory of Mind
Tan Zhi-Xuan1, Nishad Gothoskar 1, Falk Pollok 2,
Dan Gutfreund 2, Joshua B. Tenenbaum 1, Vikash K. Mansinghka 1
1MIT 2MIT-IBM Watson AI Lab
Email: xuan@mit.edu, nishadg@mit.edu, falk.pollok@ibm.edu
dgutfre@us.ibm.edu, jbt@mit.edu, vkm@mit.edu
Abstract—To facilitate the development of new models to
bridge the gap between machine and human social intelligence,
the recently proposed Baby Intuitions Benchmark provides a
suite of tasks designed to evaluate commonsense reasoning about
agents’ goals and actions that even young infants exhibit. Here
we present a principled Bayesian solution to this benchmark,
based on a hierarchically Bayesian Theory of Mind (HBToM).
By including hierarchical priors on agent goals and dispositions,
inference over our HBToM model enables few-shot learning of
the efﬁciency and preferences of an agent, which can then be used
in commonsense plausibility judgements about subsequent agent
behavior. This approach achieves near-perfect accuracy on most
benchmark tasks, outperforming deep learning and imitation
learning baselines while producing interpretable human-like
inferences, demonstrating the advantages of structured Bayesian
models of human social cognition.
I. I NTRODUCTION
From a very young age, humans display remarkable psy-
chological intuition about the mental lives and likely behavior
of other agents. For example, developmental psychologists
have shown that young infants expect agents to have object-
centered goals [1, 2], to act efﬁciently to achieve those goals
[3, 4], to choose goals based on inferred preferences [5, 6],
and to undertake instrumental actions in pursuit of those
goals [7, 8]. In contrast, many contemporary machine learning
approaches do not appear to demonstrate this structured prior
knowledge, leading to inferences and predictions about agents
that correspond poorly with human intuition [9, 10].
To facilitate the bridging of this gap, Gandhi et al. [10]
recently published the Baby Intuitions Benchmark (BIB), a
suite of tasks designed to test the ability of computational
models to judge the plausibility of agent behavior in ac-
cordance with infant psychological intuitions. In each task
instance, the model is presented with a series of familiarization
trials that contain information about an agent’s goals and
dispositions, followed by a test trial that may be consistent
or inconsistent with those goals and dispositions. They show
that deep learning and reinforcement learning baselines fail to
perform well on these tasks, leaving it an open question as to
what kinds of modeling approaches might succeed.
In this paper we describe a principled Bayesian approach
to solving this benchmark, which we refer to as a hierar-
chically Bayesian Theory of Mind (HBToM). Building upon
research on action understanding as Bayesian inverse planning
[9, 11, 12, 13, 14], we extend previous Bayesian Theory
of Mind models with hierarchical priors over the efﬁciency
and preferences of agents. This allows the HBToM model to
accumulate evidence about an agent’s efﬁciency and preferred
goals across multiple observation episodes, thereby forming
expectations about future agent goals and behavior from a
small number of previous interactions. The model can then be
used to quantify the plausibility of subsequent observations
based on how future inferences and behavior deviates from
those expectations. We show that this approach achieves
near-perfect accuracy on most benchmark tasks, while also
producing interpretable features for its plausibility judgements
which correspond to changes in attributed mental states and
dispositions, demonstrating the practical and theoretical advan-
tages of structured Bayesian models of human social cognition.
II. T HE BABY INTUITIONS BENCHMARK
We brieﬂy review the format of the Baby Intuitions Bench-
mark to aid understanding of the rest of this paper. BIB
consists of a suite of ﬁve task sets, evaluating the ability
of a computational model to account for an aspect of infant
intuitive psychology:
1) Efﬁciency: Agents are understood to act efﬁciently to
reach their goals, unless evidence suggests otherwise.
2) Preference: Agents are understood to prefer object-
based goals that they have sought in the past.
3) Multi-Agent: Separate agents are understood to have
separate object preferences.
4) Inaccessible Goals : Agents are understood to seek out
an accessible goal over an inaccessible one.
5) Instrumental Actions : Agents are understood to take
instrumental actions to achieve their goals.
Each task set consists a large number of episodes, where
each episode consists of 8 familiarization trials demonstrating
agent behavior, followed by a test trial that may contain
plausible or implausible behavior given what was shown in
the familiarization trials. For example, in the preference task,
an episode might contain 8 trials of an agent seeking a blue
object instead of a red object, but in the test trial, the agent
seeks out the red object instead. To succeed on the benchmark,
models must accurately judge whether the test trial is plausible
or implausible, measured relative to a paired episode with the
arXiv:2208.02914v1  [cs.AI]  4 Aug 2022
am,1
Action
sm,0
State
om,0
Obs.
sm,1
State
sm,2
State
om,1
Obs.
om,2
Obs.
am,2
Action
gi
Goal
gm
Goal
πm
Policy
θn
Pref .
nm
Ident.
Eﬃc.
βn
MN
Fig. 1: Graphical model of our hierarchical Bayesian Theory
of Mind, where N is the number of agents and M the number
of the trials.
same set of familiarization trials but a different test trial (or
vice versa). Full benchmark details can be found in [10].
III. A H IERARCHICALLY BAYESIAN THEORY OF MIND
We now introduce our hierarchically Bayesian Theory of
Mind, a hierarchical Bayesian model ofN agents acting across
M viewing trials. The structure of the model is represented
by Equations 1–9, and is depicted graphically in Figure 1.
For each agent n, we model uncertainty over which object
it tends to prefer, represented as a probability vector θn. We
also model uncertainty over the efﬁciency βn of the agent,
with higher βn corresponding to more direct motion towards
the goal. For each trial m, there is an associated agent nm and
corresponding initial state sm,0. The agent’s goal gm for that
trial is distributed according to their preference probabilities
θnm. Given this goal gm, the agent forms a policy πm to
achieve the goal, modulated by its efﬁciency βnm. Finally, the
agent acts according to this policy, leading to a state-action
trajectory (sm,0,am,1,sm,1,...,a m,T,sm,T ) and the observer
receives observations (om,0,...,o m,T ) of the states.
For each agent n:
Preference prior: θn∼P (θn) (1)
Efﬁciency prior: βn∼P (βn) (2)
For each trial m:
Agent identity: nm∼P (nm) (3)
Goal selection: gm∼P (gm|θnm ) (4)
Policy construction: πm∼P (πm|gm,βnm ) (5)
Initial state: sm,0∼P (sm,0|nm) (6)
For each timestep t:
Action selection: am,t∼P (am,t|sm,t−1,πm) (7)
State transition: sm,t∼P (sm,t|sm,t−1,am,t) (8)
Observation noise: om,t∼P (om,t|sm,t) (9)
In the following sections, we describe the details of each
model component. We then explain how Bayesian inference
about latent agent parameters is performed, the results of
which can be used to form plausibility judgements.
A. Agent Priors
Two key psychological ﬁndings tested by BIB are that (i)
human infants assume that agents have preferences, and (ii)
they also assume that agents act efﬁciently to achieve their
goals. These assumptions, however, are not wholly ﬁxed, as
evidenced by how infants habituate to the preferences and
efﬁciency of observed agents as they act across multiple
trials [6, 1, 4]. To account for such habituation, we adopt
a hierarchical model similar to hierarchical Bayesian inverse
reinforcement learning [15], placing priors on the goal proba-
bilities θn and efﬁciency βn of the agent:
P (θn) = Dir(α1,...,α G)
P (βn) = Inv-Gamma(a,b )
The probabilities θn represent a categorical distribution over
goal objects, but can also be interpreted as a soft preference:
The more an agent prefers an object, the more likely it will
select the object as a goal in a new trial. By watching which
object an agent selects across multiple trials, an observer can
infer likely values of θn, and hence perform few-shot learning
of the corresponding object preference. Similarly, by watching
how optimal the agent’s behavior is, the observer can infer
likely values of the efﬁciency parameter βn, habituating to
either efﬁcient or inefﬁcient behavior after multiple trials.
B. Goal Selection
For scenes with multiple objects, the agent nm in each trial
m has to decide which object shall be its goal. By default, it
does so according to its soft preference θnm:
P (gm|θnm ) = Categorical(θnm )
However, on some trials, objects may turn out to be inac-
cessible. In these cases, we assume the agent is aware that
some objects are out of reach, and adjusts its preferences θnm
by eliminating the inaccessible objects as possibilities, and
renormalizing the remaining probabilities, giving an adjusted
preference ˜θnm. We call this operation F EASIBILIZE , giving
the resulting goal distribution:
˜θnm = FEASIBILIZE (θnm)
P (gm|θnm) = Categorical(˜θnm)
By assuming that agents “feasibilize” their preferences, our
model accounts for the intuitive prediction that agents will
reach for an accessible but dispreferred object over an inac-
cessible but preferred one.
C. Policy Computation
Once a goalgm has been selected, the agent plans to achieve
that goal by constructing a policyπm, specifying a distribution
over goal-directed actions a for each state s the agent might
ﬁnd itself in. This can be done by representing the task of
reaching the goal gm as a Markov Decision Process (MDP)
with negative rewards on actions and reaching the chosen goal
as a termination condition. Solving the MDP produces Q-
values Q(s,a ) corresponding to the expected future reward
of taking action a in state s. In a deterministic environment,
Q(s,a ) thus corresponds to the (negative) total action cost
require to reach the goal gm froms by taking action a. For an
optimally efﬁcient agent, actions are then chosen by always
maximizing the Q-value. To account for potential inefﬁciency,
however, we instead make the standard assumption that actions
are sampled from a Boltzmann distribution, parameterized by
the agent’s efﬁciency βn:
πm(a|s) = exp(βnQ(s,a ))∑
a′ exp(βnQ(s,a′))
Higher values ofβn lead to more goal-directed actions, with
βn =∞ being optimal, and βn = 0 leading to uniformly
random actions. Because we model uncertainty over βn, our
model is able to account for a range of agent behaviors,
ranging from highly efﬁcient to random, and also habituate
to multiple exposures to one sort of behavior or the other.
D. Environment States and Observations
We model the environment dynamics P (st|at,st−1) of the
BIB environment as a discretized and deterministic gridworld,
where at each time step t, the agent may move between
adjacent unobstructed grid cells (including diagonal moves),
pick up objects in adjacent cells, or use a key it is holding
with an adjacent “lock”. Each action is assumed to incur a
unit cost, except for diagonal moves, which cost
√
2. These
dynamics are speciﬁed using the Planning Domain Deﬁnition
Language (PDDL), a commonly used speciﬁcation language
for symbolic planning domains and MDPs [16].
Given an environment state st, we can specify an ob-
servation model P (ot|st) that describes how observations
are distributed. Since the BIB dataset provides noise-free
observations, the results presented here assume direct access
to state variables, though a variant of our model that converts
3D observations to symbolic states exhibited similar perfor-
mance on the DARPA Machine Common Sense version of
the BIB dataset. Extensions to noisy image observations are
also possible through Bayesian inverse graphics [17].
E. Bayesian Inference
Having developed our HBToM model, Bayesian inference
can be performed over this model to determine an agent’s
likely dispositions and mental states, which can then be
used to quantify the observer’s expectations. Let ⃗ om,t :=
(o1,1:T1,o 2,1:T2,...om,1:t) be the observations received so far
up to timestep t of trial m, where o1,1:Tk are all observations
for the kth trial. We are interested in inferring the efﬁciency
βnm of agent nm, as well as their goal gm for trial m:
Efﬁciency posterior: P (βnm|⃗ om,t)
Goal posterior: P (gm|⃗ om,t)
Computing these posteriors requires applying Bayes rule
and marginalizing over all unobserved variables. While this
may appear to be computationally intensive, conjugacy as-
sumptions along with a few simpliﬁcations to the model allow
us to do this tractably (details in the Appendix).
IV. Q UANTIFYING PLAUSIBILITY
×
Maximum Change in
T otal Variation of Goal Posterior
Maximum Change in
T otal Variation of Eﬃciency Posterior
Maximum Change in
Log Observation Likelihood
Goal
Plausibility
Eﬃciency
Plausibility
Observational
Plausibility
Overall
Plausibility
Fig. 2: Classiﬁer that quantiﬁes the plausibility p of a trial m
based on measures of surprise with respect to the goal gm,
efﬁciency βn, and observations om,1:T .
In order to compute the plausibility of a test trial, we assume
that observers are simultaneously predicting and inferring the
mental states and dispositions of observed agents, experiencing
surprise when their inferences do not match their initial
predictions. In addition, observers may be surprised when an
observation just cannot be explained well by their model of
the agent, given everything they have seen before. We quantify
these notions of surprise using the following surprise metrics:
• Total variation in the goal posterior :
max
t
||Pt(gm)−P0(gm)||TV
where P0(gm) and Pt(gm) are the inferred distributions
over goals gm at the start and time t of trial m
respectively. This captures surprise due to the actual
goal differing from the one initially predicted.
• Total variation in the efﬁciency posterior
max
t
||Pt(βn)−P0(βn)||TV
where P0(βn) and PT (βn) are the inferred distributions
over agent efﬁciencyβn at the start and time t of the trial
m respectively. This captures surprise due to the agent
acting more or less efﬁciently than initially expected.
• Change in log observation likelihood
max
t
[
log P (om,0)
P (om,t|om,0:t−1)
]
where P (om,0) is the marginal likelihood of the initial
observation for trial m, and P (om,t|om,0:t−1) is the
marginal likelihood of the observation at timestep t given
all previous observations. This captures surprise due to
an observation being inexplicable under the model as a
whole, scaled by the likelihood of the initial observation.
To convert these surprise metrics into a plausibility rating
between 0 and 1, we pass each metric x through a logistic
regression classiﬁer f (x) with weight w and bias b:
f (x) = 1
1 + exp(wx +b)
Task HBToM BC-MLP BC-RNN Video-RNN
Efﬁciency 96.0 88.8 82.5 83.1
Path Control 94.9 94.0 92.8 99.2
Time Control 97.2 99.1 99.1 99.9
Irrational 96.6 73.8 56.5 50.1
Preference 99.7 26.3 48.3 47.6
Multi-Agent 99.2 48.7 48.2 50.3
Inaccessible Goals 99.7 76.9 81.6 74.0
Instrumental Actions 98.5 67.0 77.9 79.9
No Barrier 98.8 98.8 98.8 99.7
Inconsequential 97.0 55.2 78.2 77.0
Blocking Barrier 99.7 47.1 56.8 62.9
TABLE I: Pairwise accuracy of HBToM on BIB vs. baselines.
The output of each classiﬁer can be viewed as a plausibility
rating for each metric, wherepg is the goal plausibility derived
from the ﬁrst metric, pβ is the efﬁciency plausibility derived
from the second metric, andpo is the observational plausibility
derived from the third metric. Finally, we multiply these
ratings to get the overall plausibility p, which can viewed
as the probability that the trial is expected. This classiﬁer is
depicted in Figure 2.
By formulating the plausibility of a trial as a product
classiﬁer, we get the intuitive result that if a trial is surprising
according to any one metric, then it is surprising overall. For
example, if the agent ends up moving towards a goal that
is different than initially predicted, the total variation in the
goal posterior will be high, leading to a low value of pg, and
hence a low plausibility rating p. Similarly, if the agent acts
very inefﬁciently after many trials of efﬁcient action, the total
variation in the efﬁciency posterior will be high, leading to a
low value of pβ and hence p.
V. R ESULTS
We applied the modeling and inference approach described
in Section III to each BIB episode, resulting in goal and
efﬁciency posteriors for every trial of each episode. From
the test trial posteriors, we computed the surprise metrics
described in Section IV, and used them to compute plausibility
ratings for the test trial of each episode, where the weights of
the logistic classiﬁers were ﬁne-tuned on synthetic validation
dataset (see Appendix). For each set of paired episodes, we
compute pairwise correctness by checking if the plausibility
rating of the plausible episode is higher than the rating for its
implausible counterpart. Averaging across all episode pairs in
a task set gives the overall pairwise accuracy for that task.
Table I shows the pairwise accuracy of our method
(HBToM) on each benchmark task (along with subtasks where
present), compared to results from two deep-learning based
behavioral cloning baselines (BC-MLP, BC-RNN) and a video
prediction RNN baseline (Video-RNN) provided in the original
benchmark paper [10]. As can be seen, our method achieves
near-perfect pairwise accuracy on almost all tasks, while
signiﬁcantly outperforming the baseline methods. On a few
subtasks, it performs slightly worse than some baselines, but
this is made up for by its high performance across the board.
We attribute this success to the structured prior knowl-
edge embedded into our HBToM model, which corresponds
closely to an intuitive conceptual understanding of goal-
directed agents with preferences over possible goals, and
variation in how efﬁciently they achieve those goals. Because
of this prior structure, our method is able to rapidly draw
the right inferences about agent dispositions from just a small
number of habituation trials, and consequently make human-
like judgements about what subsequent behavior is plausible.
VI. D ISCUSSION
Thus far we have focused on the quantitative performance of
the HBToM model on BIB. In a future version of this paper, we
also aim to present a more detailed qualitative analysis of the
many ways in which the HBToM model produces human-like
inferences, and uses those inferences to then make plausibility
judgements. For example, we hope to illustrate the changes in
goal and efﬁciency posteriors over time, including phenomena
such as reversion to the initial goal prior when a new agent is
observed, habituation to the inefﬁciency of an irrational agent,
and a lack of change in the posterior over preferred goals when
only one goal is accessible.
The multifold aspect of plausibility judgements also lends
itself to ablation studies. In the future, we hope to better
understand the contribution of each of the surprise metrics,
analyzing how well each metric can do on its own without
the others. Our hypothesis is that no one metric is sufﬁcient:
Total variation in the goal posterior cannot determine plau-
sibility when there is only one goal, and total variation in
the efﬁciency posterior cannot determine plausibility if the
agent always acts efﬁciently (but suddenly changes their goal).
Change in log-likelihood might seem like a promising general
candidate, but we also expect that inexplicability alone is not
sufﬁcient to account for all the ways a human might ﬁnd an
observation surprising. More detailed analysis of our results
will allow us to tease apart these factors.
We conclude by reﬂecting on the limitations and advantages
of structured Bayesian models such as our HBToM at the
practical and theoretical levels. The primary limitation of such
models is that they can require more upfront conceptual and
engineering work. Effort is required to design and implement
approximately veridical models of environmental dynamics
and goal-directed agent behavior, which increases in difﬁculty
with more realistic environments and more complex goals.
This is in contrast to deep learning models trained to mimic
human social cognition while making minimal structural as-
sumptions, in which there has been increasing interest [18].
On the other hand, the performance of deep learning models
with minimal inductive bias on both BIB [10] and the related
AGENT benchmark [9] suggests that they often fail to general-
ize in human-like ways, as opposed to Bayesian inverse plan-
ning approaches such as our HBToM model and the BIPaCK
baseline in [9]. The beneﬁts of using such structured models
are manifold: They display high accuracy and generalization
ability in the environment they are designed for, often with
minimal to no training required. Taking advantage of recent
advances in probabilistic programming [19], they can also be
engineered to achieve rapid online inference [13], augmented
with neurally-guided inference [20], and extended to account
for higher-level aspects of human cognition [14].
Perhaps most importantly, structured Bayesian models pro-
vide more satisfying explanations of human behavior and
cognition [21]: Model components (e.g. preference priors)
and resulting inferences (e.g. goal posteriors) correspond to
widely-accepted theoretical constructs and folk psychological
concepts (e.g. preferences and goals), while helping us reﬁne
fuzzy concepts (e.g. plausibility) in the process of model
development. We hope that our HBToM model serves as an
illustration of these beneﬁts, inspiring future theoretically-
grounded approaches to understanding and replicating human
social cognition.
ACKNOWLEDGEMENTS
This work was supported by the DARPA Machine Common
Sense program (030523-00001).
REFERENCES
[1] Gy ¨orgy Gergely, Zolt ´an N ´adasdy, Gergely Csibra, and
Szilvia B´ır´o. Taking the intentional stance at 12 months
of age. Cognition, 56(2):165–193, 1995.
[2] Amanda L Woodward. Infants’ ability to distinguish
between purposeful and non-purposeful behaviors. Infant
behavior and development , 22(2):145–160, 1999.
[3] Gy ¨orgy Gergely and Gergely Csibra. Teleological rea-
soning in infancy: The infant’s naive theory of rational
action: A reply to Premack and Premack. Cognition, 63
(2):227–233, 1997.
[4] Shari Liu and Elizabeth S Spelke. Six-month-old infants
expect agents to minimize the cost of their actions.
Cognition, 160:35–42, 2017.
[5] Betty M Repacholi and Alison Gopnik. Early reason-
ing about desires: evidence from 14-and 18-month-olds.
Developmental psychology, 33(1):12, 1997.
[6] Jennifer Sootsman Buresh and Amanda L Woodward.
Infants track action goals within and across agents.
Cognition, 104(2):287–314, 2007.
[7] Mikołaj Hernik and Gergely Csibra. Infants learn endur-
ing functions of novel tools from action demonstrations.
Journal of experimental child psychology , 130:176–192,
2015.
[8] Sarah A Gerson, Neha Mahajan, Jessica A Sommerville,
Lauren Matz, and Amanda L Woodward. Shifting goals:
Effects of active and observational experience on infants’
understanding of higher order goals. Frontiers in Psy-
chology, 6:310, 2015.
[9] Tianmin Shu, Abhishek Bhandwaldar, Chuang Gan,
Kevin Smith, Shari Liu, Dan Gutfreund, Elizabeth
Spelke, Joshua Tenenbaum, and Tomer Ullman. AGENT:
A benchmark for core psychological reasoning. In
International Conference on Machine Learning , pages
9614–9625. PMLR, 2021.
[10] Kanishk Gandhi, Gala Stojnic, Brenden M Lake, and
Moira R Dillon. Baby Intuitions Benchmark (BIB):
Discerning the goals, preferences, and actions of others.
Advances in Neural Information Processing Systems , 34:
9963–9976, 2021.
[11] Chris L Baker, Rebecca Saxe, and Joshua B Tenenbaum.
Action understanding as inverse planning. Cognition, 113
(3):329–349, 2009.
[12] Julian Jara-Ettinger, Laura Schulz, and Josh Tenenbaum.
The naive utility calculus as a uniﬁed, quantitative frame-
work for action understanding. PsyArXiv, 2019.
[13] Tan Zhi-Xuan, Jordyn Mann, Tom Silver, Josh Tenen-
baum, and Vikash Mansinghka. Online Bayesian goal
inference for boundedly rational planning agents. Ad-
vances in Neural Information Processing Systems , 33,
2020.
[14] Arwa Alanqary, Gloria Z Lin, Joie Le, Tan Zhi-Xuan,
Vikash K Mansinghka, and Joshua B Tenenbaum. Mod-
eling the mistakes of boundedly rational agents within
a Bayesian theory of mind. Proceedings of the Annual
Meeting of the Cognitive Science Society, 43 (43) , 2021.
[15] Jaedeug Choi and Kee-Eung Kim. Hierarchical Bayesian
inverse reinforcement learning. IEEE Transactions on
Cybernetics, 45(4):793–805, 2014.
[16] Drew McDermott, Malik Ghallab, Adele Howe, Craig
Knoblock, Ashwin Ram, Manuela Veloso, Daniel Weld,
and David Wilkins. PDDL - the Planning Domain
Deﬁnition Language, 1998.
[17] Nishad Gothoskar, Marco Cusumano-Towner, Ben Zin-
berg, Matin Ghavamizadeh, Falk Pollok, Austin Garrett,
Josh Tenenbaum, Dan Gutfreund, and Vikash Mans-
inghka. 3DP3: 3D scene perception via probabilistic pro-
gramming. Advances in Neural Information Processing
Systems, 34, 2021.
[18] Neil C Rabinowitz, Frank Perbet, H Francis
Song, Chiyuan Zhang, SM Eslami, and Matthew
Botvinick. Machine theory of mind. arXiv preprint
arXiv:1802.07740, 2018.
[19] Marco F Cusumano-Towner, Feras A Saad, Alexander K
Lew, and Vikash K Mansinghka. Gen: a general-purpose
probabilistic programming system with programmable
inference. In Proceedings of the 40th ACM SIGPLAN
Conference on Programming Language Design and Im-
plementation, pages 221–236. ACM, 2019.
[20] Marco F Cusumano-Towner, Alexey Radul, David
Wingate, and Vikash K Mansinghka. Probabilistic pro-
grams for inferring the goals of autonomous agents.
arXiv preprint arXiv:1704.04977 , 2017.
[21] Tania Lombrozo. The structure and function of expla-
nations. Trends in cognitive sciences , 10(10):464–470,
2006.
[22] Andrew G Barto, Steven J Bradtke, and Satinder P Singh.
Learning to act using real-time dynamic programming.
Artiﬁcial intelligence, 72(1-2):81–138, 1995.
APPENDIX
Here we provide more technical details about our modeling
and inference approach, as well as parameter settings for
reproducibility. Code is available at https://github.
com/probcomp/SolvingBIB.jl.
A. Agent Priors
We assume that the preference vector θn has a ﬂat Dirichlet
distribution as its prior (αi = 1 for alli), a weak prior express-
ing equal preference for all objects. For the efﬁciency prior,
we assume an inverse Gamma distribution with parameters
a =b = 1, expressing a weak assumption that the agent tends
to be efﬁcient rather than random. In practice, the efﬁciency
prior is discretized into a categorical distribution over a ﬁxed
set of values ( βn ∈ {0.2, 0.2
√
2, 0.4, 0.4
√
2, 0.8}) for the
purposes of rapid and tractable inference.
B. Policy Computation
Given the relatively small state space of the BIB environ-
ment, it is possible to compute the optimal policyπm(a|s) sim-
ply via exhaustive value iteration (VI). For greater efﬁciency
however, we instead compute the value function and Q-value
function only for those states that occur in the observations,
leading to rapid inference that avoids wasteful computation of
values and Q-values for unvisited portions of the state-space.
This speed-up is possible because the environment is deter-
ministic, allowing us to directly compute the value function
V (s) as the negative of the cost of the cheapest plan from
state s to the goal. This cost can be computed by running A*
search with an admissible heuristic (e.g. Euclidean distance
to the goal) from each visited state s and its neighbors. A*
search will produce an optimal plan, and summing the costs
of each action in the plan gives the negative of the value
function. This can be extended to stochastic domains by using
the costs produced by A* search as initial value function
estimates in an asynchronous VI algorithm such as Real-Time
Dynamic Programming [22], enabling convergence to the true
value function and policy without requiring a large number of
iterations.
C. Environment States and Observations
We note that the true environmental dynamics of the BIB
environment are continuous. Hence, discretization of the envi-
ronment results in a loss of precision. However, it also enables
efﬁcient policy construction and inference over the discretized
state space, avoiding the need to sample continuous motion
plans. For similar reasons, we avoid the modelling the gradual
disappearance of removable barriers that occurs after they are
“unlocked” in the instrumental action stimuli. Given that this
process is deterministic, we instead assume that removable
barriers disappear immediately once the key is placed in the
lock, and ignore intermediate observations where the barrier
gradually disappears as part of a pre-processing step. We also
process the discretized agent trajectories so that zig-zagging
motion is smoothed into diagonal motion where possible.
D. Bayesian Inference
In order to perform rapid and tractable Bayesian inference
about agent goals and efﬁciency parameters, we make use of
the following insights and simpliﬁcations:
• Deterministic observations. Since we can reliably deter-
mine agent identities n1:m, states ⃗ sm,t, and actions ⃗ am,t
from the observations ⃗ om,t (provided as JSON ﬁles), we
can perform inference as if we are conditioning on those
variables directly. Particle ﬁltering extensions can be used
to handle noisy observations [13].
• Agent independence. The parameters of each agent n
are independent. Hence, we can perform inference about
each agent separately, ignoring trials with other agents.
• Discretization of efﬁciency distributions. Instead of
sampling efﬁciency parameters βn ∼ P (βn) to per-
form approximate inference, we can select a discrete
set {β1
n,...,β k
n} to grid over, limiting variance in in-
ference results. By choosing β1
n,...,β k
n representatively
(from efﬁcient to random), we can still draw the desired
qualitative inferences about an agent’s efﬁciency.
• Goal-preference conjugacy. Due to conjugacy between
the Dirichlet prior P (θn) over agent preferences and
the categorical goal distribution P (gm|θn), we can di-
rectly infer the distribution P (gm|g1,..,g m−1) of the
current goal gm given previous goals g1:m−1 using an
exact conjugate update. This can be generalized to case
where we cannot observe the goals directly. Because this
marginalizes outθn exactly, it obviates the need to sample
many values of θn to perform inference.
Making use of these insights, we perform inference in a
trial-by-trial manner, setting the prior over goals for trial
m as the goal posterior conditioned on all previous trials
p(gm|⃗ om−1,Tm−1 ), which can be computed via an exact con-
jugate update. Inference for the new trial is performed by
enumerating over all k values of βnm, and computing the
probabilities of the actions am,1:t under the corresponding
policyπm for eachβi
nm. Marginalizing over the goalgm gives
the posterior over efﬁciencies βnm, and vice versa.
E. Classiﬁer Tuning
To tune the weights and biases of the logistic regression
classiﬁers described in Section IV, we generate a synthetic
dataset of 220 episodes similar to the BIB evaluation episodes,
but already discretized into the appropriate PDDL representa-
tion. (We do not use the BIB training dataset because it lacks
implausible examples to tune against). Given the synthetic
dataset, we jointly optimize the biasb and weightw associated
with the total variation metrics, minimizing cross-entropy loss
with L2 regularization of 0.0001. For change in log-likelihood,
we manually tuned the coefﬁcients to account for outliers
since synthetic data may not match the test distribution. The
resulting weights and biases are shown below:
• Goal Total Variation: w =−11.81, b = 5.96
• Efﬁciency Total Variation: w =−9.42, b = 5.90
• Change in Log. Likelihood : w =−0.2, b = 2.0