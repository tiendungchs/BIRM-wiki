---
title: "AGENT: A Benchmark for Core Psychological Reasoning"
source: "https://proceedings.mlr.press/v139/shu21a.html"
author:
  - "[[Tianmin Shu]]"
  - "[[Abhishek Bhandwaldar]]"
  - "[[Chuang Gan]]"
  - "[[Kevin A. Smith]]"
  - "[[Shari Liu]]"
  - "[[Dan Gutfreund]]"
  - "[[Elizabeth Spelke]]"
  - "[[Joshua B. Tenenbaum]]"
  - "[[Tomer D. Ullman]]"
published: 2021-07-01
created: 2026-08-13
description: "ICML 2021 (PMLR 139:9614-9625). 3D-animation VOE benchmark for core intuitive psychology in four scenarios (goal preferences, action efficiency, unobserved constraints, cost-reward trade-offs), validated against 300 AMT raters on 240 trials. Two baselines: BIPaCK (Bayesian inverse planning + PyBullet physics + RRT* planner) and ToMnet-G (GNN+LSTM extension of ToMnet). MAIN-PAPER RESULT IS GROUND-TRUTH STATE: BIPaCK .96 overall vs ToMnet-G .90 vs single human .91, and BIPaCK barely degrades under leave-one-type-out (.94) and leave-one-scenario-out (.94) while ToMnet-G falls to .65/.71. SUPPLEMENTARY TABLE 2, with a trained Mask R-CNN + ResNet-34 derenderer instead of ground-truth state: BIPaCK .65, ToMnet-G .51 (chance). Human accuracy-correlation across trial types: BIPaCK 0.55, ToMnet-G 0.06. ToMnet-G's failures are shortcut heuristics the controls were designed to rule out."
tags:
  - "clippings"
  - "intuitive-psychology"
  - "theory-of-mind"
  - "core-knowledge"
  - "benchmark"
  - "inverse-planning"
  - "agency"
---

Title: AGENT: A Benchmark for Core Psychological Reasoning

URL Source: https://proceedings.mlr.press/v139/shu21a.html

Markdown Content:
AGENT: A Benchmark for Core Psychological Reasoning
Tianmin Shu 1 Abhishek Bhandwaldar 2 Chuang Gan 2 Kevin A. Smith 1 Shari Liu 1 Dan Gutfreund 2
Elizabeth Spelke 3 Joshua B. Tenenbaum1 Tomer D. Ullman3
Abstract
For machine agents to successfully interact with
humans in real-world settings, they will need to
develop an understanding of human mental life.
Intuitive psychology, the ability to reason about
hidden mental variables that drive observable ac-
tions, comes naturally to people: even pre-verbal
infants can tell agents from objects, expecting
agents to act efﬁciently to achieve goals given con-
straints. Despite recent interest in machine agents
that reason about other agents, it is not clear if
such agents learn or hold the core psychology
principles that drive human reasoning. Inspired
by cognitive development studies on intuitive psy-
chology, we present a benchmark consisting of
a large dataset of procedurally generated 3D ani-
mations, AGENT (Action, Goal, Efﬁciency, coN-
straint, uTility), structured around four scenarios
(goal preferences, action efﬁciency, unobserved
constraints, and cost-reward trade-offs) that probe
key concepts of core intuitive psychology. We
validate AGENT with human-ratings, propose
an evaluation protocol emphasizing generaliza-
tion, and compare two strong baselines built on
Bayesian inverse planning and a Theory of Mind
neural network. Our results suggest that to pass
the designed tests of core intuitive psychology
at human levels, a model must acquire or have
built-in representations of how agents plan, com-
bining utility computations and core knowledge
of objects and physics.1
1. Introduction
In recent years, there has been a growing interest in build-
ing socially-aware agents that can interact with humans in
1Massachusetts Institute of Technology 2MIT-IBM Watson
AI Lab 3Harvard University. Correspondence to: Tianmin Shu
<tshu@mit.edu>.
Proceedings of the 38 th International Conference on Machine
Learning, PMLR 139, 2021. Copyright 2021 by the author(s).
1The dataset and the supplementary material are available at
https://www.tshu.io/AGENT.
Goal objects
Agent
ObstaclesNormal Path
OccluderSurprising Path
FamiliarizationTest
FamiliarizationTest
Scenario 1: Goal Preferences
Scenario 3: Unobserved Constraints
Scenario 2: Action EﬃciencyFamiliarizationTest
FamiliarizationTestScenario 4: Cost-Reward Trade-oﬀs
A B
C D
Figure 1. Schematic of the four key scenarios of core intuitive psy-
chology evaluated in AGENT. Each scenario is color coded. Solid
arrows show the typical behavior of the agent in the familiarization
video(s) or in the expected test video. Dashed arrows show agent
behavior in the surprising test video. In Unobserved Constraints
trials (C), a surprising test video shows an unexpected outcome
(e.g. no barrier) behind the occluder.
the real world (Dautenhahn, 2007; Sheridan, 2016; Puig
et al., 2020). This requires agents that understand the moti-
vations and actions of their human counterparts, an ability
that comes naturally to people. Humans have an early-
developing intuitive psychology, the ability to reason about
other people’s mental states from observed actions. From
infancy, we can easily differentiate agents from objects, ex-
pecting agents to not only follow physical constraints, but
also to act efﬁciently to achieve their goals given constraints.
Even pre-verbal infants can recognize other people’s costs
and rewards, infer unobserved constraints given partially ob-
served actions, and predict future actions (Baillargeon et al.,
2016; Gergely & Csibra, 2003; Liu et al., 2017; Woodward,
1998). This early core psychological reasoning develops
with limited experience, yet generalizes to novel agents and
situations, and forms the basis for commonsense psycholog-
ical reasoning later in life.
Like human infants, it is critical for machine agents to de-
velop an adequate capacity of understanding human minds,
in order to successfully engage in social interactions. Recent
work has demonstrated promising results towards building
agents that can infer the mental states of others (Baker et al.,
2017; Rabinowitz et al., 2018), predict people’s future ac-
tions (Kong & Fu, 2018), and even work with human part-
ners (Rozo et al., 2016; Carroll et al., 2019). However, to
arXiv:2102.12321v4  [cs.AI]  26 Jul 2021
AGENT: A Benchmark for Core Psychological Reasoning
date there has been a lack of rigorous evaluation benchmarks
for assessing how much artiﬁcial agents learn about core
psychological reasoning, and how well their learned repre-
sentations generalize to novel agents and environments.
In this paper, we present AGENT (Action, Goal, Efﬁciency,
coNstraint, uTility), a benchmark for core psychology rea-
soning inspired by experiments in cognitive development
that probe young children’s understanding of intuitive psy-
chology. AGENT consists of a large-scale dataset of 3D
animations of an agent moving under various physical con-
straints and interacting with various objects. These anima-
tions are organized into four categories of trials, designed
to probe a machine learning model’s understanding of key
situations that have served to reveal infants’ intuitive psy-
chology, testing their attributions of goal preferences (Fig-
ure 1A; Woodward 1998), action efﬁciency (Figure 1B;
Gergely et al. 1995), unobserved constraints (Figure 1C;
Csibra et al. 2003), and cost-reward trade-offs (Figure 1D;
Liu et al. 2017). As we detail in Section 3.1, each scenario
is based on previous developmental studies, and is meant
to test a combination of underlying key concepts in human
core psychology. These scenarios cover the early under-
standing of agents as self-propelled physical entities that
value some states of the world over others, and act to maxi-
mize their rewards and minimize costs subject to constraints.
In addition to this minimal set of concepts, a model may
also need to understand other concepts to pass a full battery
of core intuitive psychology, including perceptual access
and intuitive physics. Although this minimal set does not
include other concepts of intuitive psychology such as false
belief, it is considered part of ‘core psychology’ in young
children who cannot yet pass false belief tasks, and forms
the building blocks for later concepts like false belief.
Like experiments in many infant studies, each trial has two
phases: in the familiarization phase, we show one or more
videos of a particular agent’s behavior in certain physical
environments to a model; then in the test phase, we show
the model a video of the behavior of the same agent in a
new environment, which either is ‘expected’ or ‘surpris-
ing,’ given the behavior of the agent in familiarization. The
model’s task is to judge how surprising the agent’s behaviors
in the test videos are, based on what the model has learned
or inferred about the agent’s actions, utilities, and physi-
cal constraints from watching the familiarization video(s).
We validate AGENT with large-scale human-rating trials,
showing that on average, adult human observers rate the ‘sur-
prising’ test videos as more surprising than the ‘expected’
test videos.
Unlike typical evaluation for Theory of Mind reasoning (Ra-
binowitz et al., 2018), we propose an evaluation protocol
focusing on generalization. We expect models to perform
well not only in test trials similar to those from training,
but also in test trials that require generalization to differ-
ent physical conﬁgurations within the same scenario, or to
other scenarios. We compare two strong baselines for The-
ory of Mind reasoning: (i) Bayesian Inverse Planning and
Core Knowledge, which combines Bayesian inverse plan-
ning (Baker et al., 2017) with physical simulation (Battaglia
et al., 2013), and (ii) ToMnet-G, which extends the The-
ory of Mind neural network (Rabinowitz et al., 2018). Our
experimental results show that ToMnet-G can achieve rea-
sonably high accuracy when trained and tested on trials of
similar conﬁgurations or of the same scenario, but faces a
strong challenge of generalizing to different physical situ-
ations, or a different but related scenario. In contrast, due
to built-in representations of planning, objects, and physics,
BIPaCK achieves a stronger performance on generalization
both within and across scenarios. This demonstrates that
AGENT poses a useful challenge for building models that
achieve core psychological reasoning via learned or built-
in representations of agent behaviors that integrate utility
computations, object representations, and intuitive physics.
In summary, our contributions are: (i) a new benchmark
on core psychological reasoning consisting of a large-scale
dataset inspired by infant cognition and validated by hu-
man trials, (ii) a comprehensive comparison of two strong
baseline models that extends prior approaches for mental
state reasoning, and (iii) a generalization-focused evaluation
protocol. We plan to release the dataset and the code for
data generation.
2. Related Work
Machine Social Perception. While there has been a long
and rich history in machine learning concerning human be-
havior recognition (Aggarwal & Ryoo, 2011; Caba Heilbron
et al., 2015; Poppe, 2010; Choi & Savarese, 2013; Shu et al.,
2015; Ibrahim et al., 2016; Sigurdsson et al., 2018; Fouhey
et al., 2018) and forecasting (Kitani et al., 2012; Koppula &
Saxena, 2013; Alahi et al., 2016; Kong & Fu, 2018; Liang
et al., 2019), prior work has typically focused on classifying
and/or predicting motion patterns. However, the kind of core
psychological reasoning evaluated in AGENT emphasizes
mental state reasoning. This objective is loosely aligned
with agent modeling in work on multi-agent cooperation
or competition (Albrecht & Stone, 2018), where a machine
agent attempts to model another agent’s type, deﬁned by
factors such as intentions (Mordatch & Abbeel, 2018; Puig
et al., 2020), rewards (Abbeel & Ng, 2004; Ziebart et al.,
2008; Hadﬁeld-Menell et al., 2016; Shu & Tian, 2018), or
policies (Sadigh et al., 2016; Kleiman-Weiner et al., 2016;
Nikolaidis et al., 2017; Lowe et al., 2017; Wang et al., 2020;
Xie et al., 2020). In addition, the recent interest in value
alignment (Hadﬁeld-Menell et al., 2016) is also essentially
about learning key aspects of intuitive psychology, includ-
AGENT: A Benchmark for Core Psychological Reasoning
ing goal preferences, rewards, and costs. Here, we present a
rigorously designed and human-validated dataset for bench-
marking a machine agent’s ability to model aspects of other
agents’ mental states that are core to human intuitive psy-
chology. These protocols can be used in future work to build
and test models that reason and learn about other minds the
way that humans do.
Synthetic Datasets for Machine Perception. Empowered
by graphics and physics simulation engines, there have been
synthetic datasets for various problems in machine scene
understanding (Zitnick et al., 2014; Ros et al., 2016; John-
son et al., 2017; Song et al., 2017; Xia et al., 2018; Riochet
et al., 2018; Jiang et al., 2018; Groth et al., 2018; Crosby
et al., 2019; Yi et al., 2019; Bakhtin et al., 2019; Nan et al.,
2020; Netanyahu et al., 2021). Many of these datasets fo-
cusing on social perception are either built using simple 2D
cartoons (Zitnick et al., 2014; Gordon, 2016; Netanyahu
et al., 2021), or focus on simpler reasoning tasks (Cao et al.,
2020). Concurrent with this paper, Gandhi et al. 2021 have
proposed a benchmark, BIB (Baby Intuitions Benchmark),
for probing a model’s understanding of other agents’ goals,
preferences, actions in maze-like environments. The tests
proposed in AGENT have conceptual overlap with BIB,
with three key differences: First, in addition to the common
concepts tested in both benchmarks (goals, preferences, and
actions), the scenarios in AGENT probe concepts such as
unobserved constraints and cost-reward trade-offs, whereas
BIB focuses on the instrumentality of actions (e.g., using a
sequence of actions to make an object reachable before get-
ting it). Second, trials in AGENT simulate diverse physical
situations, including ramps, platforms, doors, and bridges,
while BIB contains scenes that require more limited knowl-
edge of physical constraints: mazes with walls. Third, the
evaluation protocol for AGENT emphasizes generalization
across different scenarios and types of trials, while BIB
focuses on whether intuitive psychology concepts can be
learned and utilized from a single large training set in the
ﬁrst place. BIB also provides baseline models that build
on raw pixels or object masks, while our baseline models
address the separate challenges presented by AGENT and
focus more on incorporating the core knowledge of objects
and physics into the psychological reasoning. We see that
AGENT and BIB provide complementary tools for bench-
marking machine agents’ core psychology reasoning, and
relevant models could make use of both.
Few-shot Imitation Learning. The two-phase setup of
the trials in AGENT resembles few-shot imitation learning
(Duan et al., 2017; Finn et al., 2017; Yu et al., 2018; James
et al., 2018; Huang et al., 2019; Silver et al., 2020), where
the objective is to imitate expert policies on multiple tasks
based on a set of demonstrations. This is critically different
from the objective of our benchmark, which is to asses how
well models infer the mental states of a particular agent
from a single or few familiarization videos, and predict the
same agent’s behavior in a different physical situation.
3. AGENT Dataset
3.1. Overview
Figure 2 summarizes the design of trials in AGENT, which
groups trials into four scenarios. All trials have two phases:
(i) a familiarization phase showing one or multiple videos
of the typical behaviors of a particular agent, and (ii) a
test phase showing a single video of the same agent either
in a new physical situation (the Goal Preference, Action
Efﬁciency and Cost-Reward Trade-offs scenarios) or the
same video as familiarization but revealing a portion of
the scene that was previously occluded (Unobserved Con-
straints). Each test video is either expected or surprising. In
an expected test video, the agent behaves consistently with
its actions from the familiarization video(s) (e.g. pursues
the same goal, acts efﬁciently with respect to its constraints,
and maximizes rewards), whereas in a surprising test video,
the agent aims for a goal inconsistent with its actions from
the familiarization videos, achieves its goal inefﬁciently, or
violates physics. Each scenario has several variants, includ-
ing both basic versions replicating stimuli used in infant
studies, and additional types with new setups of the physical
scenes, creating more diverse scenarios and enabling harder
tests of generalization.
Scenario 1: Goal Preferences. This subset of trials probes
if a model understands that an agent chooses to pursue a
particular goal object based on its preferences, and that pur-
suing the same goal could lead to different actions in new
physical situations, following Woodward (1998). Each trial
includes one familiarization video and a test video, where
two distinct objects (with different shapes and colors) are
placed on either side of an agent. For half of the test videos,
the positions of the objects change from familiarization to
test. During familiarization, the agent prefers one object
over the other, and always goes to the preferred object. In
a expected test video, the agent goes to the preferred ob-
ject regardless of where it is, whereas in a surprising test
video, the agent goes to the less preferred object. A good
model should expect a rational agent to pursue its preferred
object at test, despite the varying physical conditions. To
show a variety of conﬁgurations and thus control for low
level heuristics, we deﬁne four types of trials for the Goal
Preferences scenario (Figure 2), that vary the relative cost
to pursue either one of the goal objects in the familiariza-
tion video and the test video. In Type 1.1 and Type 1.2,
reaching either one of the objects requires the same effort
as during familiarization, whereas in Type 1.3 and Type 1.4,
the agent needs to overcome a harder obstacle to reach its
preferred object. In Type 1.1 and Type 1.3, the agent needs
to overcome the same obstacle to reach either object in the
AGENT: A Benchmark for Core Psychological Reasoning
FamiliarizationExpectedSurprising
Type 2.1 Type 2.2 Type 2.3
 Type 2.4
No obstacle in test Obstacle out of the 
way in test
A smaller obstacle in 
test
A different type of 
obstacle in test
Type 2.5
Path in the fam. 
violates solidity in test
FamiliarizationExpectedSurprising
Type 3.1 Type 3.2
No barrier in the 
surprising video
Inefficient path in the 
surprising situation
B Scenario2: Action Efficiency C Scenario 3: Unobserved constraints
FamiliarizationExpectedSurprising
Type 1.1 Type 1.2 Type 1.3
 Type 1.4
Familiarization
Type 4.1 Type 4.2
A   Scenario 1: Goal Preferences D Scenario4: Cost-Reward Trade-offs
Equal cost in fam.
Equal cost in test
Equal cost in fam. 
Low goal cost in test
High goal cost in fam.
Equal cost in test
High goal cost in fam.
Low goal cost in test Equal cost in test
Surprising
Expected
 SurprisingExpected
Low cost for the preferred object in test
Figure 2. Overview of trial types of four scenarios in AGENT. Each scenario is inspired by infant cognition and meant to test a different
facet of intuitive psychology. Each type controls for the possibility of learning simpler heuristics. Example videos can be viewed at
https://www.tshu.io/AGENT.
test video, but reaching the less desired object in the test
video of Type 1.2 and Type 1.4 requires a higher effort for
the agent than reaching the preferred object does.
Scenario 2: Action Efﬁciency. This task evaluates if a
model understands that a rational agent is physically con-
strained by the environment and tends to take the most
efﬁcient action to reach its goal given its particular physical
constraints (e.g., walls or gaps in the ﬂoor). This means that
an agent may not follow the same path for the same goal if
the physical environment is no longer the same as before.
In the familiarization video, we show an agent taking an
efﬁcient path to reach a goal object given the constraints. In
Type 2.1, that constraint is removed, and at test, agent takes
a more efﬁcient path (expected), or takes the same path as
it had with the constraint in place (surprising). Types 2.2-4
further extend this scenario by ensuring that a model cannot
use the presence of the obstacle to infer that an agent should
jump by placing the obstacle out of the way (2.2), using a
smaller obstacle (2.3), or introducing a door or a bridge into
the obstacle (2.4). By introducing a surprising path in which
the agent moves through the wall, Type 2.5 ensures that the
model is not simply ignoring constraints and predicting that
the closest path to a straight line is the most reasonable.
Scenario 3: Unobserved Constraints. By assuming that
agents tend to take the most efﬁcient action to reach their
goals (Scenarios 1-2), infants are also able to infer hidden
obstacles based on agents’ actions. Speciﬁcally, after seeing
an agent that performs a costly action (e.g. jumps up and
lands behind an occluder), infants can infer that there must
be an unobserved physical constraint (e.g. a obstacle behind
the occluder) that explains this action (Csibra et al., 2003).
To evaluate if a model can reason about hidden constraints
in this way, we designed two types of trials for Scenario
3. In both types of trials, we show an agent taking curved
paths to reach a goal object (either by jumping vertically
or moving horizontally), but the middle of the agent’s path
is hidden behind an occluder (the wall appearing in the
middle of the familiarization video in Figure 2C). In these
videos, the occluder partially hides the agent from view,
and it is clear that the agent is deviating from a straight
path towards its goal. In the test videos, the occluder falls
after the agent reaches goal object, potentially revealing the
AGENT: A Benchmark for Core Psychological Reasoning
unseen physical constraints. Similar to Csibra et al. (2003),
in the expected video, the occluder falls to reveal an obstacle
that justiﬁes the action that the agent took as efﬁcient; in the
surprising video, the occluder falls to reveal an obstacle that
makes the observed actions appear inefﬁcient. The videos
of Type 3.2 control for the absence of an object behind the
occluder being a signal for surprise by revealing an obstacle
that nonetheless makes the agent’s actions inefﬁcient (a
smaller wall that the agent could have leapt over or moved
around with less effort, or a wall with a doorway that the
agent could have passed through).
Scenario 4: Cost-Reward Trade-offs. Scenario 1 requires
reasoning about preferences over different goal states, and
Scenarios 2 and 3 require reasoning about cost functions
and physical constraints. However, infants can do more than
reason about agents’ goals and physically grounded costs in
isolation. They can also infer what goal objects agents prefer
from observing the level of cost they willingly expend for
their goals (Liu et al., 2017). To succeed here, infants need
to understand that agents plan actions based on utility, which
can be decomposed into positive rewards and negative costs
(Jara-Ettinger et al., 2016). Rational action under this frame-
work thus requires agents (and observers of their actions)
to trade off the rewards of goal states against the costs of
reaching those goal states. Following experiments designed
to probe infants’ understanding of rewards and costs (Liu
et al., 2017), we construct two types of trials for Scenario
4. Here we show the agent acting towards each of two goal
objects under two different physical situations (four famil-
iarization videos in total). In the ﬁrst two familiarization
videos, the agent overcomes an obstacle with a medium
difﬁculty (a wall/platform/ramp with a medium height, or
a chasm with a medium width) to reach the object that it
likes more, but gives up when the obstacle becomes too
difﬁcult (e.g., the maximum height or width). In the remain-
ing two familiarization videos, the agent overcomes an easy
obstacle to reach the less preferred object, but decides not
to pursue the same object when there is a medium-difﬁculty
obstacle. During the testing phase, both objects are present
in the scene for the ﬁrst time. The agent goes to the more
preferred object in the expected video, but goes to the less
preferred object in the surprising video. Type 4.1 shows no
obstacles, or obstacles of the same difﬁculty, between the
agent and the two objects in the test videos. In Type 4.2, a
more difﬁcult obstacle is placed between the agent and the
less preferred object at test. In both cases, a rational agent
will tend to choose the object it likes more, which requires
either the same amount of action cost to reach as the less
preferred object (Type 4.1) or even less action cost than the
less preferred object (Type 4.2). The key question is whether
the model can infer this preference from the familiarization
videos, and generalize it to the test video.
We introduce the human inductive biases in these four sce-
Door
Ramp Platform
Chasm Bridge
Wal
l
ObstaclesObject Shapes
Figure 3. Object shapes and obstacles used in AGENT.
narios for two main reasons: (1) Human inductive biases
are useful starting points for machine models, likely to help
ﬁnd better reward/cost functions than the ones based on raw
states, and improve sample efﬁciency. Prior work on in-
verse reinforcement learning emphasizes the importance of
human inductive biases for engineering useful features for
the reward functions, such as the “known features” assump-
tion in (Abbeel & Ng, 2004). (2) Even if an AI can ﬁnd a
good, non-human-like reward function without human bi-
ases, a machine agent that successfully interacts with people
needs to predict and reason about human intuition (Hadﬁeld-
Menell et al., 2016). In such cases, inductive biases serve as
common ground to promote mutual understanding.
3.2. Procedural Generation
To generate each trial, we ﬁrst sample a physical scene
graph for each familiarization and test video that satisﬁes
the constraints speciﬁed for each trial type. In this scene
graph, we deﬁne the number, types, and sizes of obstacles
(e.g., walls, ramps, etc.), the texture of the ﬂoor (out of 8
types), the texture of the background wall (out of 3 types),
as well as the shapes, colors, sizes, and the initial positions
of the agent and all objects. We then instantiate the scene
graph in an open sourced 3D simulation environment, TDW
(Gan et al., 2020). We deﬁne the goal of the agent in each
trial by randomly assign preferences of objects to the agent,
and simulate the agent’s path through the environment using
(i) hand-crafted motion heuristics such as predeﬁned way
points and corresponding actions (i.e., walking, jumping,
climbing) to reach each way point in order to overcome an
obstacle of certain type and size, and (ii) a gaze turning mo-
tion that is naturally aligned with behaviors such as looking
at the surrounding at beginning and looking forward while
moving. We sample object shapes and obstacles from the
set depicted in Figure 3. Note that agent shapes are always
sampled from the sphere, cone, and cube subset.
3.3. Dataset Structure
There are 8400 videos in AGENT. Each video lasts from 5.6
s to 25.2 s, with a frame rate of 35 fps. With these videos, we
constructed 3360 trials in total, divided into 1920 training
trials, 480 validation trials, and 960 testing trials (or 480
pairs of expected and surprising testing trials, where each
AGENT: A Benchmark for Core Psychological Reasoning
Agent
Obstacle
Object
 Physics Engine
Physics ParametersAgent Parameters
Planner
Sampled
Trajectory
<latexit sha1_base64="nhDuaTilWzq6pvMpx+LgfL+VzRM=">AAAB6nicbVBNS8NAEJ34WetX1aOXxSJ4KomIeix68Vip/YA2ls120y7dbMLuRCihP8GLB0W8+ou8+W/ctjlo64OBx3szzMwLEikMuu63s7K6tr6xWdgqbu/s7u2XDg6bJk414w0Wy1i3A2q4FIo3UKDk7URzGgWSt4LR7dRvPXFtRKwecJxwP6IDJULBKFqpXn90e6WyW3FnIMvEy0kZctR6pa9uP2ZpxBUySY3peG6CfkY1Cib5pNhNDU8oG9EB71iqaMSNn81OnZBTq/RJGGtbCslM/T2R0ciYcRTYzoji0Cx6U/E/r5NieO1nQiUpcsXmi8JUEozJ9G/SF5ozlGNLKNPC3krYkGrK0KZTtCF4iy8vk+Z5xbusuPcX5epNHkcBjuEEzsCDK6jCHdSgAQwG8Ayv8OZI58V5dz7mrStOPnMEf+B8/gDR4I1+</latexit>
S
0
<latexit sha1_base64="8f6wipsjcZ+Sor5K4XK+ETPuCI0=">AAAB7XicbVBNSwMxEJ3Ur1q/qh69BIvgqewWUY9FLx4r2A9ol5JNs21sNlmSrFCW/gcvHhTx6v/x5r8xbfegrQ8GHu/NMDMvTAQ31vO+UWFtfWNzq7hd2tnd2z8oHx61jEo1ZU2qhNKdkBgmuGRNy61gnUQzEoeCtcPx7cxvPzFtuJIPdpKwICZDySNOiXVSq9cY8X6tX654VW8OvEr8nFQgR6Nf/uoNFE1jJi0VxJiu7yU2yIi2nAo2LfVSwxJCx2TIuo5KEjMTZPNrp/jMKQMcKe1KWjxXf09kJDZmEoeuMyZ2ZJa9mfif101tdB1kXCapZZIuFkWpwFbh2et4wDWjVkwcIVRzdyumI6IJtS6gkgvBX355lbRqVf+y6t1fVOo3eRxFOIFTOAcfrqAOd9CAJlB4hGd4hTek0At6Rx+L1gLKZ47hD9DnDw1wjsk=</latexit>
  2
<latexit sha1_base64="WhuG/p575b70Ifi0Xct7q9nN4aQ=">AAAB73icbVBNS8NAEN34WetX1aOXxSJ4KkkR9Vj04rFCv6ANZbOdtEs3m7g7EUron/DiQRGv/h1v/hu3bQ7a+mDg8d4MM/OCRAqDrvvtrK1vbG5tF3aKu3v7B4elo+OWiVPNocljGetOwAxIoaCJAiV0Eg0sCiS0g/HdzG8/gTYiVg2cJOBHbKhEKDhDK3V6jREg61f7pbJbceegq8TLSZnkqPdLX71BzNMIFHLJjOl6boJ+xjQKLmFa7KUGEsbHbAhdSxWLwPjZ/N4pPbfKgIaxtqWQztXfExmLjJlEge2MGI7MsjcT//O6KYY3fiZUkiIovlgUppJiTGfP04HQwFFOLGFcC3sr5SOmGUcbUdGG4C2/vEpa1Yp3VXEfLsu12zyOAjklZ+SCeOSa1Mg9qZMm4USSZ/JK3pxH58V5dz4WrWtOPnNC/sD5/AGfUY+y</latexit>
⇥ 2
<latexit sha1_base64="pm6hM0GJkgTKv/ok8NzGrSqI11U=">AAAB9XicbVBNSwMxEM3Wr1q/qh69BIvgqewWUY9FD3qsYD+gu5bZNNuGJtklySpl6f/w4kERr/4Xb/4b03YP2vpg4PHeDDPzwoQzbVz32ymsrK6tbxQ3S1vbO7t75f2Dlo5TRWiTxDxWnRA05UzSpmGG006iKIiQ03Y4up767UeqNIvlvRknNBAwkCxiBIyVHvwhmMy/ASFg0qv1yhW36s6Al4mXkwrK0eiVv/x+TFJBpSEctO56bmKCDJRhhNNJyU81TYCMYEC7lkoQVAfZ7OoJPrFKH0exsiUNnqm/JzIQWo9FaDsFmKFe9Kbif143NdFlkDGZpIZKMl8UpRybGE8jwH2mKDF8bAkQxeytmAxBATE2qJINwVt8eZm0alXvvOrenVXqV3kcRXSEjtEp8tAFqqNb1EBNRJBCz+gVvTlPzovz7nzMWwtOPnOI/sD5/AFdw5Js</latexit>
ˆ  2
Physics Engine Planner
<latexit sha1_base64="fApcWDXkFBNmYFz1P2bg1D54J8w=">AAAB7XicbVDLSgNBEOz1GeMr6tHLYBA8hV0R9Rj04jGCeUCyhNlJbzJmdmaZmRVCyD948aCIV//Hm3/jJNmDJhY0FFXddHdFqeDG+v63t7K6tr6xWdgqbu/s7u2XDg4bRmWaYZ0poXQrogYFl1i33ApspRppEglsRsPbqd98Qm24kg92lGKY0L7kMWfUOqnRqQ14N+iWyn7Fn4EskyAnZchR65a+Oj3FsgSlZYIa0w781IZjqi1nAifFTmYwpWxI+9h2VNIETTieXTshp07pkVhpV9KSmfp7YkwTY0ZJ5DoTagdm0ZuK/3ntzMbX4ZjLNLMo2XxRnAliFZm+TnpcI7Ni5AhlmrtbCRtQTZl1ARVdCMHiy8ukcV4JLiv+/UW5epPHUYBjOIEzCOAKqnAHNagDg0d4hld485T34r17H/PWFS+fOYI/8D5/AAvsjsg=</latexit>
  1
<latexit sha1_base64="T7DM4Yqbk89LZbNWiersJVFisU8=">AAAB73icbVBNS8NAEJ3Ur1q/qh69LBbBU0lE1GPRi8cK/YI2lM120y7dbOLuRCihf8KLB0W8+ne8+W/ctjlo64OBx3szzMwLEikMuu63U1hb39jcKm6Xdnb39g/Kh0ctE6ea8SaLZaw7ATVcCsWbKFDyTqI5jQLJ28H4bua3n7g2IlYNnCTcj+hQiVAwilbq9BojjrTv9csVt+rOQVaJl5MK5Kj3y1+9QczSiCtkkhrT9dwE/YxqFEzyaamXGp5QNqZD3rVU0YgbP5vfOyVnVhmQMNa2FJK5+nsio5ExkyiwnRHFkVn2ZuJ/XjfF8MbPhEpS5IotFoWpJBiT2fNkIDRnKCeWUKaFvZWwEdWUoY2oZEPwll9eJa2LqndVdR8uK7XbPI4inMApnIMH11CDe6hDExhIeIZXeHMenRfn3flYtBacfOYY/sD5/AGdzY+x</latexit>
⇥ 1
Sampled
Trajectory
<latexit sha1_base64="pQFheuM8JYil1fkQpzODN711BLM=">AAAB9XicbVBNS8NAEJ34WetX1aOXYBE8lUREPRY96LGC/YAmlsl22y7d3YTdjVJC/4cXD4p49b9489+4bXPQ1gcDj/dmmJkXJZxp43nfztLyyuraemGjuLm1vbNb2ttv6DhVhNZJzGPVilBTziStG2Y4bSWKoog4bUbD64nffKRKs1jem1FCQ4F9yXqMoLHSQzBAkwU3KASOO36nVPYq3hTuIvFzUoYctU7pK+jGJBVUGsJR67bvJSbMUBlGOB0Xg1TTBMkQ+7RtqURBdZhNrx67x1bpur1Y2ZLGnaq/JzIUWo9EZDsFmoGe9ybif147Nb3LMGMySQ2VZLaol3LXxO4kArfLFCWGjyxBopi91SUDVEiMDapoQ/DnX14kjdOKf17x7s7K1as8jgIcwhGcgA8XUIVbqEEdCCh4hld4c56cF+fd+Zi1Ljn5zAH8gfP5A1w/kms=</latexit>
ˆ
  1
Figure 4. Overview of the generative model for BIPaCK. The
dashed arrow indicates extracting states via the ground-truth or a
perception model.
pair shares the same familiarization video(s)). All training
and validation trials only contain expected test videos.
In the dataset, we provide RGB-D frames, instance segmen-
tation maps, and the camera parameters of the videos as well
as the 3D bounding boxes of all entities recorded from the
TDW simulator. We categorize entities into three classes:
agent, object, and obstacle, which are also available. For
creating consistent identities of the objects in a trial, we
deﬁne 8 distinct colors and assign the corresponding color
codes of the objects in the ground-truth information as well.
3.4. Dataset Usage
As our experimental results in Section 5.4 show, training
from scratch on just our dataset will not work. Instead,
we suggest that to pass the tests, it is necessary to acquire
additional knowledge, either via inductive biases in the ar-
chitectures, or from training on additional data. Speciﬁcally,
learning within this dataset may focus on extracting and rep-
resenting (1) the dynamic 3D scenes, and (2) the agent prop-
erties in the familiarization trials. Additional training may
follow a modular paradigm (training different model compo-
nents such as perception, or planning on other datasets), or
a ﬁnetuning paradigm (model components trained on other
datasets could be ﬁnetuned with our training trials).
4. Baseline Methods
We propose two strong baseline methods for the benchmark
built on well-known approaches to Theory of Mind reason-
ing. We provide a sketch of both methods here, and discuss
implementation details in the supplementary material.
4.1. Bayesian Inverse Planning and Core Knowledge
The core idea of Bayesian inverse planning is to infer hid-
den mental states (such as goals, preferences, and beliefs),
through a generative model of an agent’s plans (Baker et al.,
2017). Combined with core knowledge of physics (Bail-
largeon, 1996; Spelke et al., 1992), powered by simulation
(Battaglia et al., 2013), we propose the Bayesian Inverse
Planning and Core Knowledge (BIPaCK) model.
We ﬁrst devise a generative model that integrates physics
simulation and planning (Figure 4). Given the frame of the
current step, we extract the entities (the agent, objects, and
obstacles) and their rough state information (3D bounding
boxes and color codes), either based on the ground-truth pro-
vided in AGENT, or on results from a perception model. We
then recreate an approximated physical scene in a physics
engine that is different from TDW (here we use PyBullet;
Coumans & Bai 2016–2019). In particular, all obstacle enti-
ties are represented by cubes, and all objects and the agent
are recreated as spheres. As the model has no access to the
ground-truth parameters of the physical simulation in the
procedural generation, nor any prior knowledge about the
mental states of the agents, it has to propose a hypothesis of
the physics parameters (coordinate transformation, global
forces such as gravity and friction, and densities of entities),
and a hypothesis of the agent parameters (the rewards of
objects and the cost function of the agent). Given these
inferred parameters, the planner (based on RRT∗; Karaman
et al. 2011) samples a trajectory accordingly.
We deﬁne the generative model as G(S0, Φ, Θ), where
S0 ={s0
i}i=N is the initial state of a set of entities, N,
and Φ and Θ are the parameters for the physics engine and
the agent respectively. In particular, Θ = (R, w), where
R ={rg}g∈G indicates the agent’s reward placed over a
goal objectg∈G , andC(sa,s′
a) = w⊤f is the cost func-
tion for the agent, parameterized as the weighted sum of
the force needed to move the agent from its current state
sa to the next state s′
a. The generative model samples a
trajectory in the next T steps from S0, ˆΓ = {st
a}T
t=1, to
jointly maximize the reward and minimize the cost, i.e.,
ˆΓ =G(S0, Φ, Θ)
= arg max
Γ={sta}T
t=1
∑
g∈G
rgδ(sT
a,sg)−
T−1∑
t=0
C(st
a,st+1
a ),
(1)
where δ(sT
a,sg) = 1 if the ﬁnal state of the agent
(sT
a ) reaches goal object g whose state is sg, otherwise
δ(sT
a,sg) = 0. Note that we assume object-oriented goals
for all agents as a built-in inductive bias. Based on Eq. (1),
we can deﬁne the likelihood of observing an agent trajectory
based on given parameters and the initial state as
P (Γ|S0, Φ, Θ) =e−βD(Γ,ˆΓ) =e−βD(Γ,G(S0,Φ,Θ)), (2)
whereD is the euclidean distance between two trajectories2,
andβ = 0.2 adjusts the optimality of an agent’s behavior.
The training data is used to calibrate the parameters in BI-
PaCK. Given all Ntrain trajectories and the corresponding
2As two trajectories may have different lengths, we adopt dy-
namic time wrapping (Berndt & Clifford, 1994) for computing the
distance.
AGENT: A Benchmark for Core Psychological Reasoning
GNN LSTM
GNN
Scene GraphNode Embeddings
LSTM
Familiarization 1
Familiarization N
…
…
The initial state of the test video GNN LSTM MLP
Updateagent position
Pooling
<latexit sha1_base64="UdEwVWHb8UW+A9cVan3h6/iKbXQ=">AAAB+nicbVDLSsNAFJ3UV62vVJduBovgqiQi6rLoxmUF+4A2lMlk0g6dTMLMjVpiP8WNC0Xc+iXu/BsnbRbaemDgcM693DPHTwTX4DjfVmlldW19o7xZ2dre2d2zq/ttHaeKshaNRay6PtFMcMlawEGwbqIYiXzBOv74Ovc790xpHss7mCTMi8hQ8pBTAkYa2NV+wAQQ3I8IjPwwe5wO7JpTd2bAy8QtSA0VaA7sr34Q0zRiEqggWvdcJwEvIwo4FWxa6aeaJYSOyZD1DJUkYtrLZtGn+NgoAQ5jZZ4EPFN/b2Qk0noS+WYyT6gXvVz8z+ulEF56GZdJCkzS+aEwFRhinPeAA64YBTExhFDFTVZMR0QRCqatiinBXfzyMmmf1t3zunN7VmtcFXWU0SE6QifIRReogW5QE7UQRQ/oGb2iN+vJerHerY/5aMkqdg7QH1ifP26hlB4=</latexit>
  x
<latexit sha1_base64="nhDuaTilWzq6pvMpx+LgfL+VzRM=">AAAB6nicbVBNS8NAEJ34WetX1aOXxSJ4KomIeix68Vip/YA2ls120y7dbMLuRCihP8GLB0W8+ou8+W/ctjlo64OBx3szzMwLEikMuu63s7K6tr6xWdgqbu/s7u2XDg6bJk414w0Wy1i3A2q4FIo3UKDk7URzGgWSt4LR7dRvPXFtRKwecJxwP6IDJULBKFqpXn90e6WyW3FnIMvEy0kZctR6pa9uP2ZpxBUySY3peG6CfkY1Cib5pNhNDU8oG9EB71iqaMSNn81OnZBTq/RJGGtbCslM/T2R0ciYcRTYzoji0Cx6U/E/r5NieO1nQiUpcsXmi8JUEozJ9G/SF5ozlGNLKNPC3krYkGrK0KZTtCF4iy8vk+Z5xbusuPcX5epNHkcBjuEEzsCDK6jCHdSgAQwG8Ayv8OZI58V5dz7mrStOPnMEf+B8/gDR4I1+</latexit>
S
0
<latexit sha1_base64="bSD4W4R7bEOZNw/B6cHmRC2HLKo=">AAAB9HicbVBNS8NAEN34WetX1aOXxSJ4KomIeix68VjBfkAbymY7bZduNnF3Uiyhv8OLB0W8+mO8+W/ctDlo64OBx3szzMwLYikMuu63s7K6tr6xWdgqbu/s7u2XDg4bJko0hzqPZKRbATMghYI6CpTQijWwMJDQDEa3md8cgzYiUg84icEP2UCJvuAMreRDt4PwhCkfMj3tlspuxZ2BLhMvJ2WSo9YtfXV6EU9CUMglM6btuTH6KdMouIRpsZMYiBkfsQG0LVUsBOOns6On9NQqPdqPtC2FdKb+nkhZaMwkDGxnyHBoFr1M/M9rJ9i/9lOh4gRB8fmifiIpRjRLgPaEBo5yYgnjWthbafY+42hzKtoQvMWXl0njvOJdVtz7i3L1Jo+jQI7JCTkjHrkiVXJHaqROOHkkz+SVvDlj58V5dz7mrStOPnNE/sD5/AFcOZJ8</latexit>
e char
emental
<latexit sha1_base64="g+BTOcbO07blJ7aaavIcfow53kY=">AAACMHicbVDLSgNBEJz1bXxFPXoZDIIghF0R9Rj0oEcFo0I2ht5JrxmcfTDTq4ZlP8mLn6IXBUW8+hVOYsBHLBgoqqrp6QpSJQ257rMzMjo2PjE5NV2amZ2bXygvLp2aJNMC6yJRiT4PwKCSMdZJksLzVCNEgcKz4Gq/559dozYyiU+om2IzgstYhlIAWalVPvA7QLlPeEtBmN8WxUVOG17hKwwJtE5u+FCA+Ab326gI+LfcKlfcqtsHHybegFTYAEet8oPfTkQWYUxCgTENz02pmYMmKRQWJT8zmIK4gktsWBpDhKaZ9w8u+JpV2jxMtH0x8b76cyKHyJhuFNhkBNQxf72e+J/XyCjcbeYyTjPCWHwtCjPFKeG99nhbahSkupaA0NL+lYsOaBBkOy7ZEry/Jw+T082qt111j7cqtb1BHVNsha2ydeaxHVZjh+yI1Zlgd+yRvbBX5955ct6c96/oiDOYWWa/4Hx8AtkEq94=</latexit>
ˆx
t +1
 ˆx
t
+   x
Figure 5. Architecture of ToMnet-G. The scene graphs are con-
structed based on the ground-truth or a separately trained percep-
tion model (hence the dashed arrows).
initial states in the training set (from both familiarization
videos and test videos),Xtrain ={(Γi,S 0
i )}i∈Ntrain, we can
compute the posterior probability of the parameters:
P (Φ, Θ|Xtrain)∝
∑
i∈Ntrain
P (Γi|S0
i, Φ, Θ)P (Φ)P (Θ) (3)
whereP (Φ) andP (Θ) are uniform priors of the parame-
ters. For brevity, we deﬁne Ptrain(Φ, Θ) = P (Φ, Θ|Xtrain).
Note that trajectories and the initial states in the videos of
Unobserved Constraints are partially occluded. To obtain
Xtrain, we need to reconstruct the videos. For this, we (i)
ﬁrst remove the occluder from the states, and (ii) reconstruct
the full trajectories by applying a 2nd order curve ﬁtting to
ﬁll the occluded the portion.
For a test trial with familiarization video(s), Xfam =
{(Γi,S 0
i )}i∈Nfam, and a test video, (Γtest,S 0
test), we adjust
the posterior probability of the parameters from Eq. (3):
P (Φ, Θ|Xfam, Xtrain)∝
∑
i∈Nfam
P (Γi|S0
i , Φ, Θ)Ptrain(Φ, Θ). (4)
We then deﬁne the surprise rating of a test video by
computing the expected distance between the predicted
agent trajectory and the one observed from the test video:
EP(Φ,Θ|Xfam,Xtrain)
[
D(Γtest,G (S0
test, Φ, Θ))
]
.
4.2. Theory of Mind Neural Network
We extend ToMnet (Rabinowitz et al., 2018) to tackle the
more challenging setting of AGENT, creating the second
baseline model, ToMnet-G (see Figure 5). Like the original
ToMnet, the network encodes the familiarization video(s) to
obtain a character embedding for a particular agent, which
is then combined with the embedding of the initial state to
predict the expected trajectory of the agent. The surprise rat-
ing of a given test video is deﬁned by the deviation between
the predicted trajectory ˆΓ and the observed trajectory Γ in
the test video. We extended ToMnet by using a graph neural
network (GNN) to encode the states, where we represent all
entities (including obstacles) as nodes. The input of a node
includes its entity class (agent, object, obstacle), bounding
box, and color code. We pass the embedding of the agent
node to the downstream modules to obtain the character
embeddingechar and the mental state embeddingemental. We
train the network using a mean squared error loss on the
trajectory prediction:L(ˆΓ, Γ) = 1
T
∑T
i=1||ˆxt− xt||2.
To ensure that ToMnet-G can be applied to trials in Unob-
served Constraints consistent with how it is applied to trials
in other scenarios, we reconstruct the familiarization video
and the initial state of the test video, using the same recon-
struction method in Section 4.1. After the reconstruction,
we can use the network to predict the expected trajectory
for computing the surprise rating. Here, we use the recon-
structed trajectory for calculating the surprise rating.
5. Experiments
5.1. Evaluation Metric
Following Riochet et al. (2018), we deﬁne a metric based on
relative surprise ratings. For a paired set ofN+ surprising
test videos and N− expected test videos (which share the
same familiarization video(s)), we obtain two sets of sur-
prise ratings,{r+
i}N+
i=1 and{r−
j}N−
j=1 respectively. Accuracy
is then deﬁned as the percentage of the correctly ordered
pairs of ratings: 1
N+N−
∑
i,j 1(r+
i >r−
j ).
5.2. Experiment 1: Human Baseline
To validate the trials in AGENT and to estimate human
baseline performance for the AGENT benchmark, we con-
ducted an experiment in which people watched familiar-
ization videos and then rated the relevant test videos on a
sliding scale for surprise (from 0, ‘not at all surprising’ to
100, ‘extremely surprising’). We randomly sampled 240
test trials (i.e., 25% of the test set in AGENT) covering all
types of trials and obstacles. We recruited 300 participants
from Amazon Mechanical Turk, and each trial was rated
by 10 participants. The participants gave informed consent,
and the experiment was approved by an institutional review
board. Participants only viewed one of either the ‘expected’
or ‘surprising’ variants of a scene.
We found that the average human rating of each surprising
video was always signiﬁcantly higher than that of the cor-
responding expected video, resulting in a 100% accuracy
when using ratings from an ensemble of human observers.
To estimate the accuracy of a single human observer, we
adopted the same metric deﬁned in Section 5.1, where we
ﬁrst standardized the ratings of each participant so that they
are directly comparable to the ratings from other partici-
pants. We report the human performance in Table 1.
AGENT: A Benchmark for Core Psychological Reasoning
Table 1. Human and model performance. The ‘All’ block reports results based on models trained on all scenarios, whereas ‘G1’ and ‘G2’
report model performance on ‘G1: leave one type out’ and ‘G2: leave one scenario out‘ generalization tests. Here, G1 trains a separate
model for each scenario using all but one type of trials in that scenario, and evaluates it on the held out type; G2 trains a single model on
all but one scenario and evaluates it on the held out scenario. Blue numbers show where ToMnet-G generalizes well (performance >.8).
Red numbers show where it performs at or below chance (performance≤.5).
Condition
Method Goal Preferences Action Efﬁciency Unobs. Cost-Reward All
1.1 1.2 1.3 1.4 All 2.1 2.2 2.3 2.4 2.5 All 3.1 3.2 All 4.1 4.2 All
Human .95 .95 .92 .97 .95 .87 .93 .86 .95 .94 .91 .88 .94 .92 .82 .91 .87 .91
All
ToMnet-G .57 1.0 .67 1.0 .84 .95 1.0 .95 1.0 1.0 .98 .93 .87 .89 .82 .97 .89 .90
BIPaCK .97 1.0 1.0 1.0 .99 1.0 1.0 .85 1.0 1.0 .97 .93 .88 .90 .90 1.0 .95 .96
G1
ToMnet-G .50 .90 .63 .88 .75 .90 .75 .45 .90 .05 .66 .58 .77 .69 .48 .48 .48 .65
BIPaCK .93 1.0 1.0 1.0 .98 1.0 1.0 .80 1.0 1.0 .97 .93 .82 .86 .88 1.0 .94 .94
G2
ToMnet-G .37 .95 .63 .88 .71 .35 .60 .75 .68 .85 .65 .63 .80 .73 .55 .95 .75 .71
BIPaCK .93 1.0 1.0 1.0 .98 1.0 1.0 .75 1.0 .95 .95 .88 .85 .87 .83 1.0 .92 .94
5.3. Experiment 2: Evaluation on Seen Scenarios and
Types
Table 1 summarizes human performance and the perfor-
mance of the two methods when the models are trained and
tested on all types of trials within all four scenarios. Note
that all results reported in the main paper are based on the
ground-truth state information. We report the model per-
formance based on the states extracted from a perception
model in the supplementary material. When given ground-
truth state information, BIPaCK performs well on all types
of trials, on par or even better than the human baseline.
ToMnet-G also has a high overall accuracy when tested on
all trial types it has seen during training, but performs less
evenly across types within a scenario compared to BIPaCK,
mostly due to overﬁtting certain patterns in some types. E.g.,
in Type 1.2 and 1.4, the agent always moves away from the
object when it needs to overcome a high cost obstacle dur-
ing the test phase, so ToMnet-G uses that cue to predict the
agent’s behavior, rather than reasoning about agent’s costs
and preferences given the familiarization videos (these are
the kind of heuristics controls are designed to rule out in
infant studies). The correlation between BIPaCK’s accuracy
and the human performance on different types is 0.55, ver-
sus a correlation of 0.06 between ToMnet-G and the human
performance.
5.4. Experiment 3: Generalization Tests
We conduct four types of generalization tests. The ﬁrst
trains a separate model for each scenario using all but one
type of trials in that scenario, and evaluates it on the held
out type (‘G1: leave one type out’). The second trains a
single model on all but one scenario and evaluates it on the
held out scenario (‘G2: leave one scenario out’). The third
trains a model on a single trial type within a scenario and
evaluates it on the remaining types of the same scenario
(‘G3: single type’). The fourth trains a model on a single
scenario and evaluates it on the other three scenarios (‘G4:
single scenario’).
We compare the performance of the two models on these
four generalization tests in Table 1 (G1 and G2), Figure 6
(G3), and Figure 7 (G4). In general, we ﬁnd little change
in BIPaCK’s performance in various generalization con-
ditions. The largest performance drop of BIPaCK comes
from Type 2.3 (highlighted in magenta boxes in Figure 6B),
where the distribution of the parameters estimated from the
training trials has a signiﬁcant effect on the trajectory pre-
diction (e.g., the model mistakenly predicts going around
the wall, instead of the ground truth trajectory of jumping
over the wall, due to an inaccurately learned cost function).
In cases wherein this cost function was mis-estimated, BI-
PaCK still does adjust its beliefs in the correct direction
with familiarization: if it does not adjust its posterior using
the familiarization video(s) (Eq. 4), there would be a further
10-15% performance drop. ToMnet-G, on the other hand,
performs well in only a few generalization conditions (e.g.,
results highlighted in blue in Table 1 and in Figure 6A, and
Figure 7A). There are two main challenges that ToMnet-G
faces (highlighted in red in Table 1, Figure 6A, and Fig-
ure 7A): (i) predicting trajectories in unfamiliar physical
situations; and (ii) reliably computing costs and rewards
that are grounded to objects and physics. These results
complement the ﬁndings about the performance of ToMnet-
based models reported in Gandhi et al. 2021, suggesting
that current model-free methods like ToMnet have a lim-
ited capacity for (i) inferring agents’ mental states from a
small number of familiarization videos, and (ii) generalizing
the knowledge of the agents to novel situations. We report
comprehensive results in the supplementary material.
AGENT: A Benchmark for Core Psychological Reasoning
Goal Preferences
Training Type
Testing Type
Unobserved Constraints
Cost-RewardTrade-oﬀs
Training Type
Unobserved Constraints
Cost-RewardTrade-oﬀs
Testing Type
A   ToMnet-G B   BIPaCK
Goal PreferencesAction EﬃciencyAction Eﬃciency
Accuracy
Testing Type
Figure 6. Performance of TomNet-G (A) and BIPaCK (B) on the ‘G3: single type’ test. This test trains a model on a single trial type
within a scenario and evaluates it on the remaining types of the same scenario. Blue boxes show good generalization from ToMnet-G
(off-diagonal performance >.8), whereas red boxes show where it performs at or below chance (off-diagonal performance≤.5); magenta
boxes show failures of BIPaCK (off-diagonal performance <.8).
Testing Scenario
A   ToMnet-GB   BIPaCK
Accuracy
Training Scenario
Figure 7. Performance of TomNet-G (A) and BIPaCK (B) on the
‘G4: single scenario’ test. This test trains a model on a single sce-
nario and evaluates it on the other three scenearios. GP, AE, UC,
and CT represent Goal Preferences, Action Efﬁciency, Unobserved
Constraints, and Cost-Reward Trade-offs respectively. Blue boxes
show good generalization from ToMnet-G (off-diagonal perfor-
mance >.8, comparable to the performance when trained on the
full training set), whereas red boxes show where it performs at or
below chance (off-diagonal performance≤.5).
6. Conclusion
We propose AGENT, a benchmark for core psychology rea-
soning, which consists of a large-scale dataset of cognitively
inspired tasks designed to probe machine agents’ under-
standing of key concepts of intuitive psychology in four sce-
narios – Goal Preferences, Action Efﬁciency, Unobserved
Constraints, and Cost-Reward Trade-offs. We validate our
tasks with a large-scale set of empirical ratings from hu-
man observers, and propose several evaluation procedures
that require generalization both within and across scenar-
ios. For the proposed tasks in the benchmark, we build two
baseline models (BIPaCK and ToMnet-G) based on existing
approaches, and compare their performance on AGENT to
human performance. Overall, we ﬁnd that BIPaCK achieves
a better performance than ToMnet-G, especially in tests of
strong generalization.
Our benchmark presents exciting opportunities for future
research on machine commonsense on intuitive psychol-
ogy. For instance, while BIPaCK outperforms ToMnet-G
in almost all conditions, it also requires an accurate recon-
struction of the 3D state and a built-in model of the physical
dynamics, which will not necessarily be available in real
world scenes. It is an open question whether we can learn
generalizable inverse graphics and physics simulators on
which BIPaCK rests. There has been work on this front
(e.g., Piloto et al. 2018; Riochet et al. 2020; Wu et al. 2017),
from which probabilistic models built on human core knowl-
edge of physics and psychology could potentially beneﬁt.
On the other hand, without many built-in priors, ToMnet-G
demonstrates promising results when trained and tested on
similar scenarios, but it still lacks a strong generalization
capacity both within scenarios and across them. General-
ization could be potentially improved with more advanced
architectures, or pre-training on a wider variety of physical
scenes to learn a more general purpose simulator. These
open areas for improvement suggest that AGENT is a well-
structured diagnostic tool for developing better models of
intuitive psychology.
Acknowledgements
This work was supported by the DARPA Machine Common
Sense program, MIT-IBM AI LAB, and NSF STC award
CCF-1231216.
References
Abbeel, P. and Ng, A. Y . Apprenticeship learning via inverse
reinforcement learning. In Proceedings of the twenty-ﬁrst
international conference on Machine learning , pp. 1,
2004.
Aggarwal, J. K. and Ryoo, M. S. Human activity analysis:
A review. ACM Computing Surveys (CSUR), 43(3):1–43,
2011.
Alahi, A., Goel, K., Ramanathan, V ., Robicquet, A., Fei-
Fei, L., and Savarese, S. Social lstm: Human trajectory
prediction in crowded spaces. In Proceedings of the IEEE
AGENT: A Benchmark for Core Psychological Reasoning
conference on computer vision and pattern recognition,
pp. 961–971, 2016.
Albrecht, S. V . and Stone, P. Autonomous agents modelling
other agents: A comprehensive survey and open problems.
Artiﬁcial Intelligence, 258:66–95, 2018.
Baillargeon, R. Infants’ understanding of the physical world.
Journal of the Neurological Sciences, 143(1-2):199–199,
1996.
Baillargeon, R., Scott, R. M., and Bian, L. Psychological
reasoning in infancy. Annu. Rev. Psychol., 67(1):159–186,
2016.
Baker, C. L., Jara-Ettinger, J., Saxe, R., and Tenenbaum,
J. B. Rational quantitative attribution of beliefs, desires
and percepts in human mentalizing. Nature Human Be-
haviour, 1(4):1–10, 2017.
Bakhtin, A., van der Maaten, L., Johnson, J., Gustafson, L.,
and Girshick, R. Phyre: A new benchmark for physical
reasoning. Advances in Neural Information Processing
Systems, 32:5082–5093, 2019.
Battaglia, P. W., Hamrick, J. B., and Tenenbaum, J. B. Sim-
ulation as an engine of physical scene understanding.
Proceedings of the National Academy of Sciences , 110
(45):18327–18332, 2013.
Berndt, D. J. and Clifford, J. Using dynamic time warping
to ﬁnd patterns in time series. In KDD workshop, pp.
359–370. Seattle, W A, USA:, 1994.
Caba Heilbron, F., Escorcia, V ., Ghanem, B., and Car-
los Niebles, J. Activitynet: A large-scale video bench-
mark for human activity understanding. In Proceedings
of the ieee conference on computer vision and pattern
recognition, pp. 961–970, 2015.
Cao, Z., Gao, H., Mangalam, K., Cai, Q.-Z., V o, M., and
Malik, J. Long-term human motion prediction with scene
context. In European Conference on Computer Vision,
pp. 387–404. Springer, 2020.
Carroll, M., Shah, R., Ho, M. K., Grifﬁths, T. L., Seshia,
S. A., Abbeel, P., and Dragan, A. On the utility of learning
about humans for human-ai coordination. arXiv preprint
arXiv:1910.05789, 2019.
Choi, W. and Savarese, S. Understanding collective activ-
itiesof people from videos. IEEE transactions on pat-
tern analysis and machine intelligence, 36(6):1242–1257,
2013.
Coumans, E. and Bai, Y . Pybullet, a python module for
physics simulation for games, robotics and machine learn-
ing. http://pybullet.org, 2016–2019.
Crosby, M., Beyret, B., and Halina, M. The animal-ai
olympics. Nature Machine Intelligence, 1(5):257–257,
2019.
Csibra, G., B´ır´o, Z., Ko´os, O., and Gergely, G. One-year-
old infants use teleological representations of actions
productively. Cogn. Sci., 27(1):111–133, 2003.
Dautenhahn, K. Socially intelligent robots: dimensions
of human–robot interaction. Philosophical transactions
of the royal society B: Biological sciences , 362(1480):
679–704, 2007.
Duan, Y ., Andrychowicz, M., Stadie, B. C., Ho, J., Schnei-
der, J., Sutskever, I., Abbeel, P., and Zaremba, W. One-
shot imitation learning. arXiv preprint arXiv:1703.07326,
2017.
Finn, C., Yu, T., Zhang, T., Abbeel, P., and Levine, S. One-
shot visual imitation learning via meta-learning. In Con-
ference on Robot Learning, pp. 357–368. PMLR, 2017.
Fouhey, D. F., Kuo, W.-c., Efros, A. A., and Malik, J. From
lifestyle vlogs to everyday interactions. In Proceedings
of the IEEE Conference on Computer Vision and Pattern
Recognition, pp. 4991–5000, 2018.
Gan, C., Schwartz, J., Alter, S., Schrimpf, M., Traer, J.,
De Freitas, J., Kubilius, J., Bhandwaldar, A., Haber, N.,
Sano, M., et al. Threedworld: A platform for interac-
tive multi-modal physical simulation. arXiv preprint
arXiv:2007.04954, 2020.
Gandhi, K., Stojnic, G., Lake, B. M., and Dillon, M. R.
Baby Intuitions Benchmark (BIB): Discerning the goals,
preferences, and actions of others. arXiv preprint
arXiv:2102.11938, 2021.
Gergely, G. and Csibra, G. Teleological reasoning in infancy:
The na¨ıve theory of rational action.Trends Cogn. Sci., 7
(7):287–292, 2003.
Gergely, G., N´adasdy, Z., Csibra, G., and B´ır´o, S. Taking
the intentional stance at 12 months of age. Cognition, 56
(2):165–193, 1995.
Gordon, A. Commonsense interpretation of triangle behav-
ior. In Proceedings of the AAAI Conference on Artiﬁcial
Intelligence, 2016.
Groth, O., Fuchs, F. B., Posner, I., and Vedaldi, A. Shapes-
tacks: Learning vision-based physical intuition for gener-
alised object stacking. In Proceedings of the European
Conference on Computer Vision (ECCV), pp. 702–717,
2018.
Hadﬁeld-Menell, D., Dragan, A., Abbeel, P., and Russell,
S. Cooperative inverse reinforcement learning. arXiv
preprint arXiv:1606.03137, 2016.
AGENT: A Benchmark for Core Psychological Reasoning
Huang, D.-A., Xu, D., Zhu, Y ., Garg, A., Savarese, S.,
Fei-Fei, L., and Niebles, J. C. Continuous relaxation of
symbolic planner for one-shot imitation learning. arXiv
preprint arXiv:1908.06769, 2019.
Ibrahim, M. S., Muralidharan, S., Deng, Z., Vahdat, A.,
and Mori, G. A hierarchical deep temporal model for
group activity recognition. In Proceedings of the IEEE
Conference on Computer Vision and Pattern Recognition,
pp. 1971–1980, 2016.
James, S., Bloesch, M., and Davison, A. J. Task-embedded
control networks for few-shot imitation learning. In Con-
ference on Robot Learning, pp. 783–795. PMLR, 2018.
Jara-Ettinger, J., Gweon, H., Schulz, L. E., and Tenenbaum,
J. B. The na¨ıve utility calculus: Computational principles
underlying commonsense psychology. Trends Cogn. Sci.,
20(8):589–604, 2016.
Jiang, C., Qi, S., Zhu, Y ., Huang, S., Lin, J., Yu, L.-F.,
Terzopoulos, D., and Zhu, S.-C. Conﬁgurable 3d scene
synthesis and 2d image rendering with per-pixel ground
truth using stochastic grammars. International Journal
of Computer Vision, 126(9):920–941, 2018.
Johnson, J., Hariharan, B., van der Maaten, L., Fei-Fei, L.,
Lawrence Zitnick, C., and Girshick, R. Clevr: A diag-
nostic dataset for compositional language and elementary
visual reasoning. In Proceedings of the IEEE Confer-
ence on Computer Vision and Pattern Recognition , pp.
2901–2910, 2017.
Karaman, S., Walter, M. R., Perez, A., Frazzoli, E., and
Teller, S. Anytime motion planning using the rrt ∗. In
2011 IEEE International Conference on Robotics and
Automation, pp. 1478–1483. IEEE, 2011.
Kitani, K. M., Ziebart, B. D., Bagnell, J. A., and Hebert,
M. Activity forecasting. In European Conference on
Computer Vision, pp. 201–214. Springer, 2012.
Kleiman-Weiner, M., Ho, M. K., Austerweil, J. L., Littman,
M. L., and Tenenbaum, J. B. Coordinate to cooperate
or compete: abstract goals and joint intentions in social
interaction. In CogSci, 2016.
Kong, Y . and Fu, Y . Human action recognition and predic-
tion: A survey. arXiv preprint arXiv:1806.11230, 2018.
Koppula, H. and Saxena, A. Learning spatio-temporal struc-
ture from rgb-d videos for human activity detection and
anticipation. In International conference on machine
learning, pp. 792–800. PMLR, 2013.
Liang, J., Jiang, L., Niebles, J. C., Hauptmann, A. G., and
Fei-Fei, L. Peeking into the future: Predicting future
person activities and locations in videos. In Proceedings
of the IEEE/CVF Conference on Computer Vision and
Pattern Recognition, pp. 5725–5734, 2019.
Liu, S., Ullman, T. D., Tenenbaum, J. B., and Spelke, E. S.
Ten-month-old infants infer the value of goals from the
costs of actions. Science, 358(6366):1038–1041, Novem-
ber 2017.
Lowe, R., Wu, Y ., Tamar, A., Harb, J., Abbeel, P.,
and Mordatch, I. Multi-agent actor-critic for mixed
cooperative-competitive environments. arXiv preprint
arXiv:1706.02275, 2017.
Mordatch, I. and Abbeel, P. Emergence of grounded compo-
sitional language in multi-agent populations. In Proceed-
ings of the AAAI Conference on Artiﬁcial Intelligence ,
2018.
Nan, Z., Shu, T., Gong, R., Wang, S., Wei, P., Zhu, S.-C.,
and Zheng, N. Learning to infer human attention in daily
activities. Pattern Recognition, pp. 107314, 2020.
Netanyahu, A., Shu, T., Katz, B., Barbu, A., and Tenen-
baum, J. B. PHASE: PHysically-grounded Abstract So-
cial Events for machine social perception. In Proceedings
of the AAAI Conference on Artiﬁcial Intelligence (AAAI),
2021.
Nikolaidis, S., Hsu, D., and Srinivasa, S. Human-robot mu-
tual adaptation in collaborative tasks: Models and experi-
ments. The International Journal of Robotics Research,
36(5-7):618–634, 2017.
Piloto, L., Weinstein, A., TB, D., Ahuja, A., Mirza, M.,
Wayne, G., Amos, D., Hung, C.-c., and Botvinick, M.
Probing Physics Knowledge Using Tools from Develop-
mental Psychology. arXiv:1804.01128 [cs], 2018.
Poppe, R. A survey on vision-based human action recogni-
tion. Image and vision computing, 28(6):976–990, 2010.
Puig, X., Shu, T., Li, S., Wang, Z., Tenenbaum, J. B., Fidler,
S., and Torralba, A. Watch-And-Help: A Challenge for
Social Perception and Human-AI Collaboration. arXiv
preprint arXiv:2010.09890, 2020.
Rabinowitz, N., Perbet, F., Song, F., Zhang, C., Eslami,
S. A., and Botvinick, M. Machine theory of mind. In
International conference on machine learning, pp. 4218–
4227. PMLR, 2018.
Riochet, R., Castro, M. Y ., Bernard, M., Lerer, A., Fergus,
R., Izard, V ., and Dupoux, E. IntPhys: A Framework
and Benchmark for Visual Intuitive Physics Reasoning.
arXiv:1803.07616 [cs], 2018.
Riochet, R., Sivic, J., Laptev, I., and Dupoux, E. Occlu-
sion resistant learning of intuitive physics from videos.
arXiv:2005.00069 [cs, eess], 2020.
AGENT: A Benchmark for Core Psychological Reasoning
Ros, G., Sellart, L., Materzynska, J., Vazquez, D., and
Lopez, A. M. The synthia dataset: A large collection
of synthetic images for semantic segmentation of ur-
ban scenes. In Proceedings of the IEEE conference on
computer vision and pattern recognition, pp. 3234–3243,
2016.
Rozo, L., Calinon, S., Caldwell, D. G., Jimenez, P., and
Torras, C. Learning physical collaborative robot behav-
iors from human demonstrations. IEEE Transactions on
Robotics, 32(3):513–527, 2016.
Sadigh, D., Sastry, S., Seshia, S. A., and Dragan, A. D. Plan-
ning for autonomous cars that leverage effects on human
actions. In Robotics: Science and Systems , volume 2.
Ann Arbor, MI, USA, 2016.
Sheridan, T. B. Human–robot interaction: status and chal-
lenges. Human factors, 58(4):525–532, 2016.
Shu, T. and Tian, Y . M 3RL: Mind-aware Multi-agent
Management Reinforcement Learning. arXiv preprint
arXiv:1810.00147, 2018.
Shu, T., Xie, D., Rothrock, B., Todorovic, S., and Zhu, S.-
C. Joint inference of groups, events and human roles in
aerial videos. In Proceedings of the IEEE Conference
on Computer Vision and Pattern Recognition, pp. 4576–
4584, 2015.
Sigurdsson, G. A., Gupta, A., Schmid, C., Farhadi, A.,
and Alahari, K. Charades-ego: A large-scale dataset
of paired third and ﬁrst person videos. arXiv preprint
arXiv:1804.09626, 2018.
Silver, T., Allen, K. R., Lew, A. K., Kaelbling, L. P., and
Tenenbaum, J. Few-shot bayesian imitation learning with
logical program policies. In Proceedings of the AAAI
Conference on Artiﬁcial Intelligence, pp. 10251–10258,
2020.
Song, S., Yu, F., Zeng, A., Chang, A. X., Savva, M., and
Funkhouser, T. Semantic scene completion from a single
depth image. In Proceedings of the IEEE Conference
on Computer Vision and Pattern Recognition, pp. 1746–
1754, 2017.
Spelke, E. S., Breinlinger, K., Macomber, J., and Jacobson,
K. Origins of knowledge. Psychol. Rev., 99(4):605–632,
October 1992.
Wang, R. E., Wu, S. A., Evans, J. A., Tenenbaum, J. B.,
Parkes, D. C., and Kleiman-Weiner, M. Too many cooks:
Bayesian inference for coordinating multi-agent collabo-
ration. arXiv e-prints, pp. arXiv–2003, 2020.
Woodward, A. L. Infants selectively encode the goal object
of an actor’s reach. Cognition, 69(1):1–34, 1998.
Wu, J., Lu, E., Kohli, P., Freeman, W. T., and Tenenbaum,
J. B. Learning to See Physics via Visual De-animation.
In Neural Information Processing Systems, pp. 12, 2017.
Xia, F., R. Zamir, A., He, Z.-Y ., Sax, A., Malik, J., and
Savarese, S. Gibson env: real-world perception for em-
bodied agents. In Computer Vision and Pattern Recogni-
tion (CVPR), 2018 IEEE Conference on. IEEE, 2018.
Xie, A., Losey, D. P., Tolsma, R., Finn, C., and Sadigh, D.
Learning latent representations to inﬂuence multi-agent
interaction. arXiv preprint arXiv:2011.06619, 2020.
Yi, K., Gan, C., Li, Y ., Kohli, P., Wu, J., Torralba, A.,
and Tenenbaum, J. B. Clevrer: Collision events for
video representation and reasoning. arXiv preprint
arXiv:1910.01442, 2019.
Yu, T., Finn, C., Xie, A., Dasari, S., Zhang, T., Abbeel, P.,
and Levine, S. One-shot imitation from observing hu-
mans via domain-adaptive meta-learning. arXiv preprint
arXiv:1802.01557, 2018.
Ziebart, B. D., Maas, A. L., Bagnell, J. A., and Dey, A. K.
Maximum entropy inverse reinforcement learning. In
Aaai, volume 8, pp. 1433–1438. Chicago, IL, USA, 2008.
Zitnick, C. L., Vedantam, R., and Parikh, D. Adopting
abstract images for semantic scene understanding. IEEE
transactions on pattern analysis and machine intelligence,
38(4):627–638, 2014.

Supplementary Material
AGENT: A Benchmark for Core Psychological Reasoning
Tianmin Shu 1 Abhishek Bhandwaldar 2 Chuang Gan 2 Kevin A. Smith 1 Shari Liu 1 Dan Gutfreund 2
Elizabeth Spelke 3 Joshua B. Tenenbaum1 Tomer D. Ullman3
RGB Depth Segmentation
Figure 1. Example RGB frame, depth map, instance segmentation
map provided in AGENT.
Wall Door
Ramp Platform
Chasm Bridge
Extended SetBasic Set
Figure 2. The basic set and the extended set of object shapes and
obstacles in AGENT.
A. Dataset Details
A.1. Multi-modal Input
In additional to the ground-truth states and object labels,
we also provide RGB frames, depth maps, and instance
segmentation maps for all videos in AGENT as shown in
Figure 1.
A.2. Statistics
There are two sets of the object shapes and obstacles in
AGENT – a basic and an extended set (as depicted in Fig-
ure 2). In AGENT, there are 1100 trials generated with
the basic set, and the remaining ones are generated with
the extended. This split enables us to conduct evaluation
1Massachusetts Institute of Technology 2MIT-IBM Watson
AI Lab 3Harvard University. Correspondence to: Tianmin Shu
<tshu@mit.edu>.
of generalization to novel shapes and obstacles unseen in
training (see Section D.2).
Videos in AGENT are rendered with 3 background wall
textures and 7 ﬂoor textures (as shown in Figure 3).
Table 1 summarizes the number of trials in each type in
AGENT for the training, validation, and testing sets.
B. Model Implementation Details
B.1. BIPaCK
Planner. We devise an RRT∗-based planner, which ﬁrst
searches for the most efﬁcient path from the initial position
to the target position, then computes the force needed to
move the agent along the path. For computing the cost
between two positions, sa,s′
a, we ﬁrst compute the force
needed to move from sa,s′
a. When sa ands′
a are on the
same surface (on the ground, a ramp, or a platform), we
compute the force needed to move in the direction fromsa
tos′
a at a constant speed. In practice, we set the constant
speed to be the average speed of agents in the training trials.
When moving from sa to s′
a requires an elevation in the
vertical direction, such as jumping over a wall or a chasm,
or jump onto a platform, we derive the minimum vertical
force needed to reach s′
a without colliding into the wall /
platform, or fall into a chasm, while maintaining a constant
speed for the horizontal motion vjump
h = 1.3. We deﬁne
a collision check condition for the expansion in RRT∗, as
illustrated in Figure 4, so that it is allowed to go from one
side of a wall or chasm and reach to the other side, or go
from the ground and land onto a platform, but it is not
allowed to land onto a wall or in a chasm.
Physics parameters. For the physics parameters, we con-
sider coordinate transformation, gravity, friction, densities
of entities, and time unit (how long a step in the video cor-
respond to one simulation step in PyBullet). Most of these
parameters have little effect on the ﬁnal accuracy as the
remaining parameters can compensate their effects (e.g., the
large gravity could be offset by a lower cost weight for the
vertical forces), so we set them to be constant in all scenar-
ios. In particular, we set the gravity to be 9.81, densities
AGENT: A Benchmark for Core Psychological Reasoning
Table 1. The number of trials for each type in AGENT.
Set Goal Preferences Action Efﬁciency Unobs. Cost-Reward All
1.1 1.2 1.3 1.4 All 2.1 2.2 2.3 2.4 2.5 All 3.1 3.2 All 4.1 4.2 All
Train 120 160 120 160 560 80 80 80 160 80 480 160 240 400 240 240 480 1920
Val 30 40 30 40 140 20 20 20 40 20 120 40 60 100 60 60 120 480
Test 60 80 60 80 280 40 40 40 80 40 240 80 120 200 120 120 240 960
Background Wall Textures FloorTextures
Figure 3. Background wall and ﬂoor textures in AGENT.
Invalid expansionValid expansion (moving on a surface) Valid expansion (jumping)
Figure 4. Illustration of valid and invalid expansions in our RRT∗-based planner.
of all moveable entities to be 1 (note that we also assume
that obstacle blocks are always immobile), and time unit to
be 5 ms per simulation step. In addition, the 3D states in
the original videos have a different coordinate system than
the one in PyBullet. For this, we have to determine which
axis in the original coordinate system corresponds to the
vertical axis in PyBullet (the mapping of the two horizontal
axes do not matter in our approach). We achieve this by
setting the axis which has the least amount of change in the
agents’ trajectories (since they mainly travel horizontally).
Finally, we need to search for the friction from a ﬁxed range
{0, 0.05, 0.1, 0.15, 0.2} (we deﬁne the friction as a constant
force applied to an agent moving on any surface in PyBul-
let). In our experiments, a friction between 0 and 0.1 result
in a similar performance.
Agent parameters. As discussed in the main paper, we
search for the best reward and cost function for an agent.
In this work, we set the cost function to be C(sa,s′
a) =
w⊤f =whfh +wvfv, wherefh andfv are the horizontal
and vertical force the agent needs to move from sa tos′
a.
We always set wh = 1 , and consider a ﬁnite set for wv,
i.e., {0.1, 0.2, 0.3, 0.5, 1.0, 10.0}. We assume a continuous
range for the rewards of goal objects, i.e.,rg ∈ (0, 100.0],
∀g ∈ G .
AGENT: A Benchmark for Core Psychological Reasoning
MLP
Position x
Position y
Position z
Yaw
Pitch
Roll
Camera Position x
Camera  Position y
Camera  Position z
Camera  Yaw
Camera  Pitch
Camera  Roll
ResNet
34
Mask
R-CNN
…
Seg. Mask of Entity i
3D bboxof Entity i
and the camera parameters
Width
Height
Length
Figure 5. Network architecture of the derender.
Sampling. For each test video, we sample 10 trajectories
to compute score. Using 10 parallel processes, on a 16-
core CPU with 64 GB RAM, it takes 1-3 s to compute the
surprising score for a test video.
B.2. ToMnet-G
Network architecture. Each GNN consists of N nodes;
each node has an input,vi = (xi,a i), wherexi is the cen-
ter of the 3D bounding box xi, and ai is the appearance
information, including the object label, the width, length,
and height of the 3D bounding box, and the orientation of
the bounding box. The node input is encoded byφv(vi) =
[φx
v (xi),φ a
v(ai)], where bothφx
v andφa
v are a 32-dim fully-
connected (FC) layer. The edge between nodei andj is en-
coded by a 64-dim FC layer,φe(vi,v j). For the agent node,
we connect all other entities to it and aggregate the edge em-
beddings by a sum-pool. Concatenated with the embedding
of the agent node itself, we get [φv(vi), ∑
j⁄=iφe(vi,v j)],
which is passed to a 64-dim FC layer to get the ﬁnal agent
node embedding φagent([φv(vi), ∑
j⁄=iφe(vi,v j)]). For a
familiarization videok, this is then passed to an LSTM with
64 hidden units to get a encoding of the videoek
fam (i.e., the
last latent state of the LSTM). By a sum-pool over the en-
coding of all familiarization videos, we getechar = ∑
kek
fam.
For a test video, the agent node embedding is concatenated
withechar and passed to two 64-dim FC layers, followed by
an LSTM with 64 hidden units. The hidden state of this
LSTM becomesemental. Concatenatingemental andechar, we
predict the displacement of the agent in one stepδx with an
FC layer.δx is then used to updatexi in the agent node’s
input. We predict the movement of the agent until the end
of the test video.
Training. We train the network using Adam (Kingma & Ba,
2014), with a batch size of 16, and a learning rate of 0.001.
C. Derendering for Visual Perception
In order to test the performance of baseline models that only
have access to the videos, we introduce a visual perception
front-end. This derenderer model extracts the 3D states of
each entity in a video over time, which are then used as the
inputs to BIPaCK and ToMnet-G.
Network architecture. Figure 5 shows the architecture of
the derender, which ﬁrst obtains instance segmentation from
a video frame using Mask R-CNN (He et al., 2017), and then
recognizes the 3D bounding of each entity and the camera
parameters based the mask of each entity, using a ResNet-34
(He et al., 2016) and a two fully-connected layers (which
are 256-dim and 15-dim respectively). In particular, we
have 11 object labels for the instance segmentation: agent,
obstacle, 8 goal object color codes (each represents a unique
object identity deﬁned by its color code), and occluder. This
design ensures that we can reconstruct the rough 3D scene
without overﬁtting to certain object shapes in the training
data, and the approximated scenes should be sufﬁcient for
the downstream psychological reasoning tasks.
Training. We adopt a two-phase training procedure: we
ﬁrst ﬁnetune Mask R-CNN (which is pretrained on Ima-
geNet; Deng et al. 2009) using the ground-truth segmen-
tation masks, and then train the remaining part based on
segmentation masks from the ﬁxed Mask R-CNN. We sam-
ple 36,000 frames from the training trials of all types as the
training set, and 14,000 frames from the validation trials as
the validation set. For both training stages, we use Adam
with a learning rate of 0.000067, and a batch size of 160.
AGENT: A Benchmark for Core Psychological Reasoning
Table 2. Model performance based on derendering results. ‘All’ indicates performance of models trained on all concepts.
Condition
Method Goal Preferences Action Efﬁciency Unobs. Cost-Reward All
1.1 1.2 1.3 1.4 All 2.1 2.2 2.3 2.4 2.5 All 3.1 3.2 All 4.1 4.2 All
All
ToMnet-G .53 .56 .47 .56 .54 .45 .70 .45 .73 .15 .52 .55 .35 .43 .50 .57 .53 .51
BIPaCK .77 .73 .80 .65 .73 .60 .65 .85 .50 .70 .63 .45 .62 .55 .63 .75 .69 .65
Goal Preferences Action Efﬁciency Unobs. Cost-Reward All
1.1 1.2 1.3 1.4 All 2.1 2.2 2.3 2.4 2.5 All 3.1 3.2 All 4.1 4.2 All
SD .05 .05 .11 .03 .06 .08 .05 .09 .06 .11 .09 .10 .06 .08 .09 .10 .10 .08
D. Additional Results
D.1. The Variance of Human Performance
We report the standard deviations of human performance as
shown in Table D.1. The results suggest that the variance of
the human performance is relatively small and thus validates
the data as well as the experimental procedure.
D.2. Generalization to Unseen Shapes and Obstacles
In addition to the four generalization tests, we also evalu-
ate the models’ performance on trials generated with the
extended set shown in Figure 2 when only trained on trials
synthesized from the basic set. Even when we provide the
ground-truth bounding boxes of all entities, ToMnet-G’s
averaged accuracy still drops to 0.57, whereas BIPaCK-
achieves an accuracy of 0.95. Although ToMnet-G did not
have the opportunity to encode these objects during its train-
ing (as opposed to BIPaCK, for which the encoding into
simple shapes is ﬁxed), this nonetheless highlights the need
for generalizable object representations when faced with
novel physical environments.
D.3. Results Based on Derendering
The averaged IoU (Intersection over Union) between the 3D
bounding boxes generated by the derender and the ground-
truth is 0.07 (SD=0.11). This low IoU is mainly caused by in-
accurate center position and orientation estimations. Given
the noisy derendering results, we evaluate the ToMnet-G and
BIPaCK trained on all types and all scenarios, as reported
in Table 2. Without the ground-truth 3D states, the perfor-
mance of both models drops signiﬁcantly. However, more
advanced derenderers with better position and orientation
estimates could ameliorate this drop.
D.4. Qualitative Results
We visualize some typical failures examples of both ToMnet-
G and BIPaCK in different generalization tests in Figure 6,
where we show the predicted agent trajectories and the
ground-truth agent trajectories in the expected test videos,
indicating failure modes of both models. Note that both
models have access to the ground-truth 3D states of the
objects and obstacles.
ToMnet-G: violations of physics. While ToMnet-G can
predict that an agent will travel towards its goal as efﬁciently
as possible, it can ignore constraints and predict that the
object will take non-physical paths (e.g., passing through
solid obstacles; Figure 6ABDH).
ToMnet-G: inefﬁcient paths. ToMnet-G sometimes pre-
dicts inefﬁcient paths (e.g., jumping unnecessarily when the
obstacle is out of the way; Figure 6G).
ToMnet-G: incorrect goal selections. ToMnet-G can
make erroneous goal predictions, e.g., selecting no clear
goal for the agent (Figure 6CE), or predicting the wrong
goal (Figure 6DF).
BIPaCK: mis-estimates of cost. In some situations, BI-
PaCK will incorrectly estimate the costs of moving hori-
zontally vs. jumping, and thus will, for instance, select a
longer path around an obstacle rather than a short hop over
it (Figure 6H).
References
Deng, J., Dong, W., Socher, R., Li, L.-J., Li, K., and Fei-Fei,
L. Imagenet: A large-scale hierarchical image database.
In 2009 IEEE conference on computer vision and pattern
recognition, pp. 248–255. Ieee, 2009.
He, K., Zhang, X., Ren, S., and Sun, J. Deep residual learn-
ing for image recognition. In Proceedings of the IEEE
conference on computer vision and pattern recognition ,
pp. 770–778, 2016.
He, K., Gkioxari, G., Doll ´ar, P., and Girshick, R. Mask r-
cnn. In Proceedings of the IEEE international conference
on computer vision, pp. 2961–2969, 2017.
Kingma, D. P. and Ba, J. Adam: A method for stochastic
optimization. arXiv preprint arXiv:1412.6980, 2014.
AGENT: A Benchmark for Core Psychological Reasoning
GTToMnet-GBIPaCK
EG3: single type (trained on Type 4.2), Type 4.1
 FG3: single type (trained on Type 4.1), Type 4.2
CG2: leave one scenario out, Type 1.1
 DG2: leave one scenario out, Type 1.3
AG1: leave one type out, Type 2.5
 BG1: leave one type out, Type 2.3
GTToMnet-GBIPaCK GTToMnet-GBIPaCK
GTToMnet-GBIPaCK
GG4: single scenario (trained on Scenario 3: UC), Type 2.2 HG3: single type (trained on Type 2.1), Type 2.3
Figure 6. Qualitative results of failure examples in different generalization tests. Here we show approximated scenes where objects and
agents are represented by spheres and the obstacles are recreated with cubes. The agent is always represented by the red sphere. All
examples are the models’ prediction or the ground-truth (GT) agent behaviors in the expected test videos.