# andrychowicz-2017-hindsight-experience-replay

> Converted from `andrychowicz-2017-hindsight-experience-replay.pdf` on 2026-09-18 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

## **Hindsight Experience Replay**

**Marcin Andrychowicz** <sup>_∗_</sup> **,** **Filip Wolski,** **Alex Ray,** **Jonas Schneider,** **Rachel Fong,**
**Peter Welinder,** **Bob McGrew,** **Josh Tobin,** **Pieter Abbeel** <sup>_†_</sup> **,** **Wojciech Zaremba** <sup>_†_</sup>

OpenAI

**Abstract**

Dealing with sparse rewards is one of the biggest challenges in Reinforcement
Learning (RL). We present a novel technique called _Hindsight Experience Replay_
which allows sample-efficient learning from rewards which are sparse and binary
and therefore avoid the need for complicated reward engineering. It can be combined with an arbitrary off-policy RL algorithm and may be seen as a form of
implicit curriculum.
We demonstrate our approach on the task of manipulating objects with a robotic
arm. In particular, we run experiments on three different tasks: pushing, sliding,
and pick-and-place, in each case using only binary rewards indicating whether or
not the task is completed. Our ablation studies show that Hindsight Experience
Replay is a crucial ingredient which makes training possible in these challenging
environments. We show that our policies trained on a physics simulation can
be deployed on a physical robot and successfully complete the task. The video
presenting our experiments is available at `https://goo.gl/SMrQnI` .

**1** **Introduction**

Reinforcement learning (RL) combined with neural networks has recently led to a wide range of
successes in learning policies for sequential decision-making problems. This includes simulated
environments, such as playing Atari games (Mnih et al., 2015), and defeating the best human player
at the game of Go (Silver et al., 2016), as well as robotic tasks such as helicopter control (Ng et al.,
2006), hitting a baseball (Peters and Schaal, 2008), screwing a cap onto a bottle (Levine et al., 2015),
or door opening (Chebotar et al., 2016).

However, a common challenge, especially for robotics, is the need to engineer a reward function
that not only reflects the task at hand but is also carefully shaped (Ng et al., 1999) to guide the
policy optimization. For example, Popov et al. (2017) use a cost function consisting of five relatively
complicated terms which need to be carefully weighted in order to train a policy for stacking a
brick on top of another one. The necessity of cost engineering limits the applicability of RL in the
real world because it requires both RL expertise and domain-specific knowledge. Moreover, it is
not applicable in situations where we do not know what admissible behaviour may look like. It is
therefore of great practical relevance to develop algorithms which can learn from unshaped reward
signals, e.g. a binary signal indicating successful task completion.

One ability humans have, unlike the current generation of model-free RL algorithms, is to learn
almost as much from achieving an undesired outcome as from the desired one. Imagine that you are
learning how to play hockey and are trying to shoot a puck into a net. You hit the puck but it misses
the net on the right side. The conclusion drawn by a standard RL algorithm in such a situation would

_∗_ `marcin@openai.com`

_†_ Equal advising.

31st Conference on Neural Information Processing Systems (NIPS 2017), Long Beach, CA, USA.

be that the performed sequence of actions does not lead to a successful shot, and little (if anything)
would be learned. It is however possible to draw another conclusion, namely that this sequence of
actions would be successful if the net had been placed further to the right.

In this paper we introduce a technique called _Hindsight Experience Replay (HER)_ which allows the
algorithm to perform exactly this kind of reasoning and can be combined with any off-policy RL
algorithm. It is applicable whenever there are multiple _goals_ which can be achieved, e.g. achieving
each state of the system may be treated as a separate goal. Not only does HER improve the sample
efficiency in this setting, but more importantly, it makes learning possible even if the reward signal is
sparse and binary. Our approach is based on training universal policies (Schaul et al., 2015a) which
take as input not only the current state, but also a goal state. The pivotal idea behind HER is to replay
each episode with a different goal than the one the agent was trying to achieve, e.g. one of the goals
which was achieved in the episode.

**2** **Background**

In this section we introduce reinforcement learning formalism used in the paper as well as RL
algorithms we use in our experiments.

**2.1** **Reinforcement Learning**

We consider the standard reinforcement learning formalism consisting of an agent interacting with
an environment. To simplify the exposition we assume that the environment is fully observable.
An environment is described by a set of states _S_, a set of actions _A_, a distribution of initial states
_p_ ( _s_ 0), a reward function _r_ : _S × A →_ R, transition probabilities _p_ ( _st_ +1 _|st, at_ ), and a discount factor
_γ_ _∈_ [0 _,_ 1].

A deterministic policy is a mapping from states to actions: _π_ : _S_ _→A_ . Every episode starts with
sampling an initial state _s_ 0. At every timestep _t_ the agent produces an action based on the current state:
_at_ = _π_ ( _st_ ). Then it gets the reward _rt_ = _r_ ( _st, at_ ) and the environment’s new state is sampled from

_i_ = _t_ <sup>_γi−tri_</sup> <sup>.</sup>
The agent’s goal is to maximize its expected return E _s_ 0[ _R_ 0 _|s_ 0]. The Q-function or action-value

the distributionfunction is defined as _p_ ( _·|st, a Qt_ <sup>_π_</sup> )(. _s_ A discounted sum of future rewards is called a _t, at_ ) = E[ _Rt|st, at_ ]. _return_ : _Rt_ = <sup>�</sup> <sup>_∞_</sup>

Let _π_ <sup>_∗_</sup> denote an _optimal policy_ i.e. any policy _π_ <sup>_∗_</sup> s.t. _Q_ <sup>_π∗_</sup> ( _s, a_ ) _≥_ _Q_ <sup>_π_</sup> ( _s, a_ ) for every _s ∈_ _S, a ∈_ _A_
and any policy _π_ . All optimal policies have the same Q-function which is called _optimal Q-function_
and denoted _Q_ <sup>_∗_</sup> . It is easy to show that it satisfies the following equation called the _Bellman_ equation:

_._

_Q_ <sup>_∗_</sup> ( _s, a_ ) = E _s′∼p_ ( _·|s,a_ )

**2.2** **Deep Q-Networks (DQN)**

- _r_ ( _s, a_ ) + _γ_ max _a_ <sup>_′_</sup> _∈A_

max _a_ <sup>_′_</sup> _∈A_ <sup>_Q∗_</sup> <sup>(</sup> <sup>_s′, a′_</sup> <sup>)</sup>

_Deep_ _Q-Networks_ _(DQN)_ (Mnih et al., 2015) is a model-free RL algorithm for discrete action
spaces. Here we sketch it only informally, see Mnih et al. (2015) for more details. In DQN we
maintain a neural network _Q_ which approximates _Q_ <sup>_∗_</sup> . A _greedy_ policy w.r.t. _Q_ is defined as
_πQ_ ( _s_ ) = argmax _a∈AQ_ ( _s, a_ ). An _ϵ_ -greedy policy w.r.t. _Q_ is a policy which with probability _ϵ_ takes
a random action (sampled uniformly from _A_ ) and takes the action _πQ_ ( _s_ ) with probability 1 _−_ _ϵ_ .

During training we generate episodes using _ϵ_ -greedy policy w.r.t. the current approximation of
the action-value function _Q_ . The transition tuples ( _st, at, rt, st_ +1) encountered during training are
stored in the so-called _replay_ _buffer_ . The generation of new episodes is interleaved with neural
network training. The network is trained using mini-batch gradient descent on the loss _L_ which
encourages the approximated Q-function to satisfy the Bellman equation: _L_ = E ( _Q_ ( _st, at_ ) _−_ _yt_ ) <sup>2</sup>,
where _yt_ = _rt_ + _γ_ max _a′∈A Q_ ( _st_ +1 _, a_ <sup>_′_</sup> ) and the tuples ( _st, at, rt, st_ +1) are sampled from the replay
buffer <sup>1</sup> .

In order to make this optimization procedure more stable the targets _yt_ are usually computed using a
separate _target network_ which changes at a slower pace than the main network. A common practice

1The targets _yt_ depend on the network parameters but this dependency is ignored during backpropagation.

2

is to periodically set the weights of the target network to the current weights of the main network (e.g.
Mnih et al. (2015)) or to use a polyak-averaged <sup>2</sup> (Polyak and Juditsky, 1992) version of the main
network instead (Lillicrap et al., 2015).

**2.3** **Deep Deterministic Policy Gradients (DDPG)**

_Deep Deterministic Policy Gradients (DDPG)_ (Lillicrap et al., 2015) is a model-free RL algorithm
for continuous action spaces. Here we sketch it only informally, see Lillicrap et al. (2015) for more
details. In DDPG we maintain two neural networks: a _target policy_ (also called an _actor_ ) _π_ : _S_ _→A_
and an action-value function approximator (called the _critic_ ) _Q_ : _S × A →_ R. The critic’s job is to
approximate the actor’s action-value function _Q_ <sup>_π_</sup> .

Episodes are generated using a _behavioral policy_ which is a noisy version of the target policy, e.g.
_πb_ ( _s_ ) = _π_ ( _s_ ) + _N_ (0 _,_ 1). The critic is trained in a similar way as the Q-function in DQN but the
targets _yt_ are computed using actions outputted by the actor, i.e. _yt_ = _rt_ + _γQ_ ( _st_ +1 _, π_ ( _st_ +1)).
The actor is trained with mini-batch gradient descent on the loss _La_ = _−_ E _sQ_ ( _s, π_ ( _s_ )), where _s_
is sampled from the replay buffer. The gradient of _La_ w.r.t. actor parameters can be computed by
backpropagation through the combined critic and actor networks.

**2.4** **Universal Value Function Approximators (UVFA)**

_Universal Value Function Approximators (UVFA)_ (Schaul et al., 2015a) is an extension of DQN to
the setup where there is more than one goal we may try to achieve. Let _G_ be the space of possible
goals. Every goal _g_ _∈G_ corresponds to some reward function _rg_ : _S × A →_ R. Every episode starts
with sampling a state-goal pair from some distribution _p_ ( _s_ 0 _, g_ ). The goal stays fixed for the whole
episode. At every timestep the agent gets as input not only the current state but also the current goal
_π_ : _S_ _× G_ _→A_ and gets the reward _rt_ = _rg_ ( _st, at_ ). The Q-function now depends not only on a
state-action pair but also on a goal _Q_ <sup>_π_</sup> ( _st, at, g_ ) = E[ _Rt|st, at, g_ ]. Schaul et al. (2015a) show that in
this setup it is possible to train an approximator to the Q-function using direct bootstrapping from the
Bellman equation (just like in case of DQN) and that a greedy policy derived from it can generalize
to previously unseen state-action pairs. The extension of this approach to DDPG is straightforward.

**3** **Hindsight Experience Replay**

**3.1** **A motivating example**

Consider a bit-flipping environment with the state space _S_ = _{_ 0 _,_ 1 _}_ <sup>_n_</sup> and the action space _A_ =
_{_ 0 _,_ 1 _, . . ., n −_ 1 _}_ for some integer _n_ in which executing the _i_ -th action flips the _i_ -th bit of the state.
For every episode we sample uniformly an initial state as well as a target state and the policy gets a
reward of _−_ 1 as long as it is not in the target state, i.e. _rg_ ( _s, a_ ) = _−_ [ _s̸_ = _g_ ].

_̸_

Standard RL algorithms are bound to fail in this environment for
_n >_ 40 because they will never experience any reward other than _−_ 1.
Notice that using techniques for improving exploration (e.g. VIME
(Houthooft et al., 2016), count-based exploration (Ostrovski et al.,
2017) or bootstrapped DQN (Osband et al., 2016)) does not help
here because the real problem is _not_ in lack of diversity of states
being visited, rather it is simply impractical to explore such a large
state space. The standard solution to this problem would be to use
a shaped reward function which is more informative and guides the
agent towards the goal, e.g. _rg_ ( _s, a_ ) = _−||s −_ _g||_ <sup>2</sup> . While using a
shaped reward solves the problem in our toy environment, it may be
difficult to apply to more complicated problems. We investigate the
results of reward shaping experimentally in Sec. 4.4.

Instead of shaping the reward we propose a different solution which
does not require any domain knowledge. Consider an episode with

Figure 1: Bit-flipping experiment.

1.0

0.8

0.6

0.4

0.2

0.0

0 10 20 30 40 50
number of bits n

2 A polyak-averaged version of a parametric model _M_ which is being trained is a model whose parameters
are computed as an exponential moving average of the parameters of _M_ over time.

3

a state sequence _s_ 1 _, . . ., sT_ and a goal _g̸_ = _s_ 1 _, . . ., sT_ which implies
that the agent received a reward of _−_ 1 at every timestep. The pivotal idea behind our approach is to
re-examine this trajectory with a different goal — while this trajectory may not help us learn how to
achieve the state _g_, it definitely tells us something about how to achieve the state _sT_ . This information
can be harvested by using an off-policy RL algorithm and experience replay where we replace _g_ in
the replay buffer by _sT_ . In addition we can still replay with the original goal _g_ left intact in the replay
buffer. With this modification at least half of the replayed trajectories contain rewards different from

_−_ 1 and learning becomes much simpler. Fig. 1 compares the final performance of DQN with and
without this additional replay technique which we call _Hindsight Experience Replay (HER)_ . DQN
without HER can only solve the task for _n ≤_ 13 while DQN with HER easily solves the task for _n_ up
to 50. See Appendix A for the details of the experimental setup. Note that this approach combined
with powerful function approximators (e.g., deep neural networks) allows the agent to learn how to
achieve the goal _g_ even if it has never observed it during training.

We more formally describe our approach in the following sections.

**3.2** **Multi-goal RL**

We are interested in training agents which learn to achieve multiple different goals. We follow the
approach from _Universal Value Function Approximators_ (Schaul et al., 2015a), i.e. we train policies
and value functions which take as input not only a state _s ∈S_ but also a goal _g_ _∈G_ . Moreover, we
show that training an agent to perform multiple tasks can be easier than training it to perform only
one task (see Sec. 4.3 for details) and therefore our approach may be applicable even if there is only
one task we would like the agent to perform (a similar situation was recently observed by Pinto and
Gupta (2016)).

We assume that every goal _g_ _∈G_ corresponds to some predicate _fg_ : _S_ _→{_ 0 _,_ 1 _}_ and that the agent’s
goal is to achieve any state _s_ that satisfies _fg_ ( _s_ ) = 1. In the case when we want to exactly specify the
desired state of the system we may use _S_ = _G_ and _fg_ ( _s_ ) = [ _s_ = _g_ ]. The goals can also specify only
some properties of the state, e.g. suppose that _S_ = R <sup>2</sup> and we want to be able to achieve an arbitrary
state with the given value of _x_ coordinate. In this case _G_ = R and _fg_ (( _x, y_ )) = [ _x_ = _g_ ].

Moreover, we assume that given a state _s_ we can easily find a goal _g_ which is satisfied in this state.
More formally, we assume that there is given a mapping _m_ : _S_ _→G_ s.t. _∀s∈S_ _fm_ ( _s_ )( _s_ ) = 1. Notice
that this assumption is not very restrictive and can usually be satisfied. In the case where each goal
corresponds to a state we want to achieve, i.e. _G_ = _S_ and _fg_ ( _s_ ) = [ _s_ = _g_ ], the mapping _m_ is just an
identity. For the case of 2-dimensional state and 1-dimensional goals from the previous paragraph
this mapping is also very simple _m_ (( _x, y_ )) = _x_ .

A universal policy can be trained using an arbitrary RL algorithm by sampling goals and initial states
from some distributions, running the agent for some number of timesteps and giving it a negative
reward at every timestep when the goal is not achieved, i.e. _rg_ ( _s, a_ ) = _−_ [ _fg_ ( _s_ ) = 0]. This does not
however work very well in practice because this reward function is sparse and not very informative.

In order to solve this problem we introduce the technique of Hindsight Experience Replay which is
the crux of our approach.

**3.3** **Algorithm**

The idea behind Hindsight Experience Replay (HER) is very simple: after experiencing some episode
_s_ goal used for this episode but also with a subset of other goals.0 _,_ _s_ 1 _, . . .,_ _sT_ we store in the replay buffer every transition _st_ Notice that the goal being pursued _→_ _st_ +1 not only with the original
influences the agent’s actions but not the environment dynamics and therefore we can replay each
trajectory with an arbitrary goal assuming that we use an off-policy RL algorithm like DQN (Mnih
et al., 2015), DDPG (Lillicrap et al., 2015), NAF (Gu et al., 2016) or SDQN (Metz et al., 2017).

One choice which has to be made in order to use HER is the set of additional goals used for replay.
In the simplest version of our algorithm we replay each trajectory with the goal _m_ ( _sT_ ), i.e. the goal
which is achieved in the final state of the episode. We experimentally compare different types and
quantities of additional goals for replay in Sec. 4.5. In all cases we also replay each trajectory with
the original goal pursued in the episode. See Alg. 1 for a more formal description of the algorithm.

4

**<u>Algorithm 1</u>** <u>Hindsight Experience Replay (HER)</u>

**Given:**

_•_ an off-policy RL algorithm A, _▷_ e.g. DQN, DDPG, NAF, SDQN

_•_ a strategy S for sampling goals for replay, _▷_ e.g. S( _s_ 0 _, . . ., sT_ ) = _m_ ( _sT_ )

_•_ a reward function _r_ : _S × A × G_ _→_ R. _▷_ e.g. _r_ ( _s, a, g_ ) = _−_ [ _fg_ ( _s_ ) = 0]
Initialize A _▷_ e.g. initialize neural networks
Initialize replay buffer _R_
**for** episode = 1, _M_ **do**

Sample a goal _g_ and an initial state _s_ 0.
**for** _t_ = 0 _,_ _T_ _−_ 1 **do**

Sample an action _at_

Sample an action _at_ using the behavioral policy from A:

_at_ _←_ _πb_ ( _st||g_ ) _▷_ _||_ denotes concatenation
Execute the action _at_ and observe a new state _st_ +1
**end for**
**for** _t_ = 0 _,_ _T_ _−_ 1 **do**

_rt_ := _r_ ( _st, at, g_ )

_rt_ := _r_ ( _st, at, g_ )
Store the transition ( _st||g,_ _at,_ _rt,_ _st_ +1 _||g_ ) in _R_ _▷_ standard experience replay
Sample a set of additional goals for replay _G_ := S( **current episode** )
**for** _g_ <sup>_′_</sup> _∈_ _G_ **do**

_r_ <sup>_′_</sup> := _r_ ( _st, at, g_ <sup>_′_</sup> )

_r_ <sup>_′_</sup> := _r_ ( _st, at, g_ <sup>_′_</sup> )
Store the transition ( _st||g_ <sup>_′_</sup> _,_ _at,_ _r_ <sup>_′_</sup> _,_ _st_ +1 _||g_ <sup>_′_</sup> ) in _R_ _▷_ HER
**end for**
**end for**
**for** _t_ = 1 _,_ _N_ **do**

Sample a minibatch _B_ from the replay buffer _R_
Perform one step of optimization using A and minibatch _B_
**end for**
**<u>end for</u>**

HER may be seen as a form of implicit curriculum as the goals used for replay naturally shift from
ones which are simple to achieve even by a random agent to more difficult ones. However, in contrast
to explicit curriculum, HER does not require having any control over the distribution of initial
environment states. Not only does HER learn with extremely sparse rewards, in our experiments
it also performs better with sparse rewards than with shaped ones (See Sec. 4.4). These results are
indicative of the practical challenges with reward shaping, and that shaped rewards would often
constitute a compromise on the metric we truly care about (such as binary success/failure).

**4** **Experiments**

The video presenting our experiments is available at `https://goo.gl/SMrQnI` .

This section is organized as follows. In Sec. 4.1 we introduce multi-goal RL environments we use for
the experiments as well as our training procedure. In Sec. 4.2 we compare the performance of DDPG
with and without HER. In Sec. 4.3 we check if HER improves performance in the single-goal setup.
In Sec. 4.4 we analyze the effects of using shaped reward functions. In Sec. 4.5 we compare different
strategies for sampling additional goals for HER. In Sec. 4.6 we show the results of the experiments
on the physical robot.

**4.1** **Environments**

The are no standard environments for multi-goal RL and therefore we created our own environments.
We decided to use manipulation environments based on an existing hardware robot to ensure that the
challenges we face correspond as closely as possible to the real world. In all experiments we use a
7-DOF Fetch Robotics arm which has a two-fingered parallel gripper. The robot is simulated using
the _MuJoCo_ (Todorov et al., 2012) physics engine. The whole training procedure is performed in
the simulation but we show in Sec. 4.6 that the trained policies perform well on the physical robot
without any finetuning.

5

Figure 2: Different tasks: _pushing_ (top row), _sliding_ (middle row) and _pick-and-place_ (bottom row).
The red ball denotes the goal position.

Policies are represented as Multi-Layer Perceptrons (MLPs) with Rectified Linear Unit (ReLU)
activation functions. Training is performed using the _DDPG_ algorithm (Lillicrap et al., 2015) with
_Adam_ (Kingma and Ba, 2014) as the optimizer. For improved efficiency we use 8 workers which

average the parameters after every update. See Appendix A for more details and the values of all
hyperparameters.

We consider 3 different tasks:

1. _Pushing_ . In this task a box is placed on a table in front of the robot and the task is to move
it to the target location on the table. The robot fingers are locked to prevent grasping. The
learned behaviour is a mixture of pushing and rolling.

2. _Sliding_ . In this task a puck is placed on a long slippery table and the target position is outside
of the robot’s reach so that it has to hit the puck with such a force that it slides and then
stops in the appropriate place due to friction.

3. _Pick-and-place_ . This task is similar to pushing but the target position is in the air and the
fingers are not locked. To make exploration in this task easier we recorded a _single_ state in
which the box is grasped and start half of the training episodes from this state <sup>3</sup> .

**States:** The state of the system is represented in the MuJoCo physics engine and consists of angles
and velocities of all robot joints as well as positions, rotations and velocities (linear and angular) of
all objects.

**Goals:** Goals describe the desired position of the object (a box or a puck depending on the task)
with some fixed tolerance of _ϵ_ i.e. _G_ = R <sup>3</sup> and _fg_ ( _s_ ) = [ _|g_ _−_ _s_ **object** _|_ _≤_ _ϵ_ ], where _s_ **object** is
the position of the object in the state _s_ . The mapping from states to goals used in HER is simply
_m_ ( _s_ ) = _s_ **object** .

**Rewards:** Unless stated otherwise we use binary and sparse rewards _r_ ( _s, a, g_ ) = _−_ [ _fg_ ( _s_ <sup>_′_</sup> ) = 0]
where _s_ <sup>_′_</sup> if the state _after_ the execution of the action _a_ in the state _s_ . We compare sparse and shaped
reward functions in Sec. 4.4.

**State-goal distributions:** For all tasks the initial position of the gripper is fixed, while the initial
position of the object and the target are randomized. See Appendix A for details.

3This was necessary because we could not successfully train any policies for this task without using the
demonstration state. We have later discovered that training is possible without this trick if only the goal position
is sometimes on the table and sometimes in the air.

6

**Observations:** In this paragraph _relative_ means relative to the _current_ gripper position. The policy
is given as input the absolute position of the gripper, the relative position of the object and the target <sup>4</sup>,
as well as the distance between the fingers. The Q-function is additionally given the linear velocity of
the gripper and fingers as well as relative linear and angular velocity of the object. We decided to
restrict the input to the policy in order to make deployment on the physical robot easier.

**Actions:** None of the problems we consider require gripper rotation and therefore we keep it fixed.
Action space is 4-dimensional. Three dimensions specify the desired relative gripper position at
the next timestep. We use MuJoCo constraints to move the gripper towards the desired position but
Jacobian-based control could be used instead <sup>5</sup> . The last dimension specifies the desired distance
between the 2 fingers which are position controlled.

**Strategy** S **for sampling goals for replay:** Unless stated otherwise HER uses replay with the goal
corresponding to the final state in each episode, i.e. S( _s_ 0 _, . . ., sT_ ) = _m_ ( _sT_ ). We compare different
strategies for choosing which goals to replay with in Sec. 4.5.

**4.2** **Does HER improve performance?**

In order to verify if HER improves performance we evaluate DDPG with and without HER on all
3 tasks. Moreover, we compare against DDPG with count-based exploration <sup>6</sup> (Strehl and Littman,
2005; Kolter and Ng, 2009; Tang et al., 2016; Bellemare et al., 2016; Ostrovski et al., 2017). For
HER we store each transition in the replay buffer twice: once with the goal used for the generation
of the episode and once with the goal corresponding to the final state from the episode (we call this
strategy `final` ). In Sec. 4.5 we perform ablation studies of different strategies S for choosing goals
for replay, here we include the best version from Sec. 4.5 in the plot for comparison.

DDPG DDPG+count-based exploration DDPG+HER DDPG+HER (version from Sec. 4.5)

100%

80%

60%

40%

20%

0%

|Col1|Col2|Col3|Col4|Col5|
|---|---|---|---|---|
||||||
||||||
||||||
||||||
||||||

0 50 100 150 200

100%

80%

60%

40%

20%

<u>pushing</u>

0%
0 50 100 150 200

<u>sliding</u>
100%

80%

60%

40%

20%

0%

epoch number (every epoch = 800 episodes = 800x50 timesteps)

Figure 3: Learning curves for multi-goal setup. An episode is considered successful if the distance
between the object and the goal at the end of the episode is less than 7cm for pushing and pick-andplace and less than 20cm for sliding. The results are averaged across 5 random seeds and shaded
areas represent one standard deviation. The red curves correspond to the `future` strategy with _k_ = 4
from Sec. 4.5 while the blue one corresponds to the `final` strategy.

From Fig. 3 it is clear that DDPG without HER is unable to solve any of the tasks <sup>7</sup> and DDPG with
count-based exploration is only able to make some progress on the sliding task. On the other hand,
DDPG with HER solves all tasks almost perfectly. It confirms that HER is a crucial element which
makes learning from sparse, binary rewards possible.

4The target position is relative to the current _object_ position.
5The successful deployment on a physical robot (Sec. 4.6) confirms that our control model produces
movements which are reproducible on the physical robot despite not being fully physically plausible.

6 We discretize the state space and use an intrinsic reward of the form _α/_ _~~√~~_ _N_, where _α_ is a hyper
parameter and _N_ is the number of times the given state was visited. The discretization works as follows. We take the relative position of the box and the target and then discretize every coordinate using
a grid with a stepsize _β_ which is a hyperparameter. We have performed a hyperparameter search over
_α_ _∈{_ 0 _._ 032 _,_ 0 _._ 064 _,_ 0 _._ 125 _,_ 0 _._ 25 _,_ 0 _._ 5 _,_ 1 _,_ 2 _,_ 4 _,_ 8 _,_ 16 _,_ 32 _},_ _β_ _∈{_ 1cm _,_ 2cm _,_ 4cm _,_ 8cm _}_ . The best results were
obtained using _α_ = 1 and _β_ = 1cm and these are the results we report.

6 We discretize the state space and use an intrinsic reward of the form _α/_ _~~√~~_

7We also evaluated DQN (without HER) on our tasks and it was not able to solve any of them.

7

100%

80%

60%

40%

20%

0%

epoch number (every epoch = 800 episodes = 800x50 timesteps)

Figure 4: Learning curves for the single-goal case.

**4.3** **Does HER improve performance even if there is only one goal we care about?**

In this section we evaluate whether HER improves performance in the case where there is only one
goal we care about. To this end, we repeat the experiments from the previous section but the goal
state is identical in all episodes.

From Fig. 4 it is clear that DDPG+HER performs much better than pure DDPG even if the goal state
is identical in all episodes. More importantly, comparing Fig. 3 and Fig. 4 we can also notice that
HER learns faster if training episodes contain multiple goals, so in practice it is advisable to train on
multiple goals even if we care only about one of them.

**4.4** **How does HER interact with reward shaping?**

So far we only considered binary rewards of the form _r_ ( _s, a, g_ ) = _−_ [ _|g −_ _s_ **object** _|_ _>_ _ϵ_ ]. In this
section we check how the performance of DDPG with and without HER changes if we replace
this reward with one which is shaped. We considered reward functions of the form _r_ ( _s, a, g_ ) =
_λ|g −_ _s_ **object** _|_ <sup>_p_</sup> _−|g −_ _s_ <sup>_′_</sup> **object** <sup>_|p_</sup> <sup>, where</sup> <sup>_s′_</sup> <sup>is the state of the environment after the execution of the</sup>

action _a_ in the state _s_ and _λ ∈{_ 0 _,_ 1 _},_ _p ∈{_ 1 _,_ 2 _}_ are hyperparameters.

Fig. 5 shows the results. Surprisingly neither DDPG, nor DDPG+HER was able to successfully
solve any of the tasks with any of these reward functions <sup>8</sup> .Our results are consistent with the fact
that successful applications of RL to difficult manipulation tasks which does not use demonstrations
usually have more complicated reward functions than the ones we tried (e.g. Popov et al. (2017)).

The following two reasons can cause shaped rewards to perform so poorly: (1) There is a huge
discrepancy between what we optimize (i.e. a shaped reward function) and the success condition (i.e.:
is the object within some radius from the goal at the end of the episode); (2) Shaped rewards penalize
for inappropriate behaviour (e.g. moving the box in a wrong direction) which may hinder exploration.
It can cause the agent to learn not to touch the box at all if it can not manipulate it precisely and we
noticed such behaviour in some of our experiments.

Our results suggest that domain-agnostic reward shaping does not work well (at least in the simple
forms we have tried). Of course for every problem there exists a reward which makes it easy (Ng
et al., 1999) but designing such shaped rewards requires a lot of domain knowledge and may in some
cases not be much easier than directly scripting the policy. This strengthens our belief that learning
from sparse, binary rewards is an important problem.

**4.5** **How many goals should we replay each trajectory with and how to choose them?**

In this section we experimentally evaluate different strategies (i.e. S in Alg. 1) for choosing goals to
use with HER. So far the only additional goals we used for replay were the ones corresponding to

8We also tried to rescale the distances, so that the range of rewards is similar as in the case of binary rewards,
clipping big distances and adding a simple (linear or quadratic) term encouraging the gripper to move towards
the object but none of these techniques have led to successful training.

8

<u>pick-and-place</u>
100%

80%

60%

40%

20%

0%
0 50 100 150 200

100%

80%

60%

40%

20%

<u>pushing</u>

0%
0 50 100 150 200

<u>sliding</u>
100%

80%

60%

40%

20%

0%

150 200 0 50 100 150 200 0 50

epoch number (every epoch = 800 episodes = 800x50 timesteps)

Figure 5: Learning curves for the shaped reward _r_ ( _s, a, g_ ) = _−|g −_ _s_ <sup>_′_</sup> **object** <sup>_|_</sup> <sup>2</sup> <sup>(it performed best</sup>

among the shaped rewards we have tried). Both algorithms fail on all tasks.

|no HER final random episode future<br>pushing sliding pick-and-place<br>1.0 1.0<br>0.8 0.8<br>0.6 0.6<br>0.4 0.4<br>0.2 0.2|Col2|Col3|Col4|Col5|Col6|Col7|Col8|Col9|Col10|
|---|---|---|---|---|---|---|---|---|---|
|||||||||||
|||||||||||
|||||||||||
|||||||||||
|||||||||||

1 2 4 8 16 all

<u>pick-and-place</u>
1.0

0.8

0.6

0.4

0.2

0.0
1 2 4 8 16 all

1.0

0.8

0.6

0.4

0.2

0.0
1 2 4 8 16 all

1.0

0.8

0.6

0.4

0.2

<u>pushing</u>

0.0
1 2 4 8 16 all

1 2 4 8 16 all

<u>sliding</u>
1.0

0.8

0.6

0.4

0.2

0.0

16 all 1 2 4 8 16 all 1 2

number of additional goals used to replay each transition with

Figure 6: Ablation study of different strategies for choosing additional goals for replay. The top row
shows the highest (across the training epochs) test performance and the bottom row shows the average
test performance across all training epochs. On the right top plot the curves for `final`, `episode` and
`future` coincide as all these strategies achieve perfect performance on this task.

the final state of the environment and we will call this strategy `final` . Apart from it we consider the
following strategies:

_•_ `future`   - replay with _k_ random states which come from the same episode as the transition
being replayed and were observed _after_ it,

_•_ `episode`   - replay with _k_ random states coming from the same episode as the transition
being replayed,

_•_ `random`   - replay with _k_ random states encountered so far in the whole training procedure.

All of these strategies have a hyperparameter _k_ which controls the ratio of HER data to data coming
from normal experience replay in the replay buffer.

The plots comparing different strategies and different values of _k_ can be found in Fig. 6. We can
see from the plots that all strategies apart from `random` solve pushing and pick-and-place almost
perfectly regardless of the values of _k_ . In all cases `future` with _k_ equal 4 or 8 performs best and it
is the only strategy which is able to solve the sliding task almost perfectly. The learning curves for

9

Figure 7: The pick-and-place policy deployed on the physical robot.

`future` with _k_ = 4 can be found in Fig. 3. It confirms that the most valuable goals for replay are the
ones which are going to be achieved in the near future <sup>9</sup> . Notice that increasing the values of _k_ above
8 degrades performance because the fraction of normal replay data in the buffer becomes very low.

**4.6** **Deployment on a physical robot**

We took a policy for the pick-and-place task trained in the simulator (version with the `future` strategy
and _k_ = 4 from Sec. 4.5) and deployed it on a physical fetch robot without any finetuning. The box
position was predicted using a separately trained CNN using raw fetch head camera images. See
Appendix B for details.

Initially the policy succeeded in 2 out of 5 trials. It was not robust to small errors in the box position
estimation because it was trained on perfect state coming from the simulation. After retraining the
policy with gaussian noise (std=1cm) added to observations <sup>10</sup> the success rate increased to 5 _/_ 5. The
video showing some of the trials is available at `https://goo.gl/SMrQnI` .

**5** **Related work**

The technique of experience replay has been introduced in Lin (1992) and became very popular
after it was used in the DQN agent playing Atari (Mnih et al., 2015). _Prioritized_ experience replay
(Schaul et al., 2015b) is an improvement to experience replay which prioritizes transitions in the
replay buffer in order to speed up training. It it orthogonal to our work and both approaches can be
easily combined.

Learning simultaneously policies for multiple tasks have been heavily explored in the context of
policy search, e.g. Schmidhuber and Huber (1990); Caruana (1998); Da Silva et al. (2012); Kober et al.
(2012); Devin et al. (2016); Pinto and Gupta (2016). Learning off-policy value functions for multiple
tasks was investigated by Foster and Dayan (2002) and Sutton et al. (2011). Our work is most heavily
based on Schaul et al. (2015a) who considers training a _single_ neural network approximating multiple
value functions. Learning simultaneously to perform multiple tasks has been also investigated for
a long time in the context of Hierarchical Reinforcement Learning, e.g. Bakker and Schmidhuber
(2004); Vezhnevets et al. (2017).

Our approach may be seen as a form of implicit curriculum learning (Elman, 1993; Bengio et al.,
2009). While curriculum is now often used for training neural networks (e.g. Zaremba and Sutskever
(2014); Graves et al. (2016)), the curriculum is almost always hand-crafted. The problem of automatic
curriculum generation was approached by Schmidhuber (2004) who constructed an asymptotically
optimal algorithm for this problem using program search. Another interesting approach is PowerPlay
(Schmidhuber, 2013; Srivastava et al., 2013) which is a general framework for automatic task selection.
Graves et al. (2017) consider a setup where there is a fixed discrete set of tasks and empirically
evaluate different strategies for automatic curriculum generation in this settings. Another approach
investigated by Sukhbaatar et al. (2017) and Held et al. (2017) uses self-play between the policy and
a task-setter in order to automatically generate goal states which are on the border of what the current
policy can achieve. Our approach is orthogonal to these techniques and can be combined with them.

9We have also tried replaying the goals which are close to the ones achieved in the near future but it has not
performed better than the `future` strategy

10The Q-function approximator was trained using exact observations. It does not have to be robust to noisy
observations because it is not used during the deployment on the physical robot.

10

**6** **Conclusions**

We introduced a novel technique called Hindsight Experience Replay which makes possible applying
RL algorithms to problems with sparse and binary rewards. Our technique can be combined with an
arbitrary off-policy RL algorithm and we experimentally demonstrated that with DQN and DDPG.

We showed that HER allows training policies which push, slide and pick-and-place objects with a
robotic arm to the specified positions while the vanilla RL algorithm fails to solve these tasks. We
also showed that the policy for the pick-and-place task performs well on the physical robot without
any finetuning. As far as we know, it is the first time so complicated behaviours were learned using
only sparse, binary rewards.

**Acknowledgments**

We would like to thank Ankur Handa, Jonathan Ho, John Schulman, Matthias Plappert, Tim Salimans,
and Vikash Kumar for providing feedback on the previous versions of this manuscript. We would
also like to thank Rein Houthooft and the whole OpenAI team for fruitful discussions as well as
Bowen Baker for performing some additional experiments.

**References**

Abadi, M., Agarwal, A., Barham, P., Brevdo, E., Chen, Z., Citro, C., Corrado, G. S., Davis, A., Dean, J., Devin,

M., et al. (2016). Tensorflow: Large-scale machine learning on heterogeneous distributed systems. _arXiv_
_preprint arXiv:1603.04467_ .

Bakker, B. and Schmidhuber, J. (2004). Hierarchical reinforcement learning based on subgoal discovery and

subpolicy specialization. In _Proc. of the 8-th Conf. on Intelligent Autonomous Systems_, pages 438–445.

Bellemare, M., Srinivasan, S., Ostrovski, G., Schaul, T., Saxton, D., and Munos, R. (2016). Unifying count
based exploration and intrinsic motivation. In _Advances in Neural Information Processing Systems_, pages
1471–1479.

Bengio, Y., Louradour, J., Collobert, R., and Weston, J. (2009). Curriculum learning. In _Proceedings of the 26th_

_annual international conference on machine learning_, pages 41–48. ACM.

Caruana, R. (1998). Multitask learning. In _Learning to learn_, pages 95–133. Springer.

Chebotar, Y., Kalakrishnan, M., Yahya, A., Li, A., Schaal, S., and Levine, S. (2016). Path integral guided policy

search. _arXiv preprint arXiv:1610.00529_ .

Da Silva, B., Konidaris, G., and Barto, A. (2012). Learning parameterized skills. _arXiv preprint arXiv:1206.6398_ .

Devin, C., Gupta, A., Darrell, T., Abbeel, P., and Levine, S. (2016). Learning modular neural network policies

for multi-task and multi-robot transfer. _arXiv preprint arXiv:1609.07088_ .

Elman, J. L. (1993). Learning and development in neural networks: The importance of starting small. _Cognition_,

48(1):71–99.

Foster, D. and Dayan, P. (2002). Structure in the space of value functions. _Machine Learning_, 49(2):325–346.

Graves, A., Bellemare, M. G., Menick, J., Munos, R., and Kavukcuoglu, K. (2017). Automated curriculum

learning for neural networks. _arXiv preprint arXiv:1704.03003_ .

Graves, A., Wayne, G., Reynolds, M., Harley, T., Danihelka, I., Grabska-Barwi´nska, A., Colmenarejo, S. G.,

Grefenstette, E., Ramalho, T., Agapiou, J., et al. (2016). Hybrid computing using a neural network with
dynamic external memory. _Nature_, 538(7626):471–476.

Gu, S., Lillicrap, T., Sutskever, I., and Levine, S. (2016). Continuous deep q-learning with model-based

acceleration. _arXiv preprint arXiv:1603.00748_ .

Held, D., Geng, X., Florensa, C., and Abbeel, P. (2017). Automatic goal generation for reinforcement learning

agents. _arXiv preprint arXiv:1705.06366_ .

Houthooft, R., Chen, X., Duan, Y., Schulman, J., De Turck, F., and Abbeel, P. (2016). Vime: Variational

information maximizing exploration. In _Advances in Neural Information Processing Systems_, pages 1109–
1117.

11

Kingma, D. and Ba, J. (2014). Adam: A method for stochastic optimization. _arXiv preprint arXiv:1412.6980_ .

Kober, J., Wilhelm, A., Oztop, E., and Peters, J. (2012). Reinforcement learning to adjust parametrized motor

primitives to new situations. _Autonomous Robots_, 33(4):361–379.

Kolter, J. Z. and Ng, A. Y. (2009). Near-bayesian exploration in polynomial time. In _Proceedings of the 26th_

_Annual International Conference on Machine Learning_, pages 513–520. ACM.

Levine, S., Finn, C., Darrell, T., and Abbeel, P. (2015). End-to-end training of deep visuomotor policies. _arXiv_

_preprint arXiv:1504.00702_ .

Lillicrap, T. P., Hunt, J. J., Pritzel, A., Heess, N., Erez, T., Tassa, Y., Silver, D., and Wierstra, D. (2015).

Continuous control with deep reinforcement learning. _arXiv preprint arXiv:1509.02971_ .

Lin, L.-J. (1992). Self-improving reactive agents based on reinforcement learning, planning and teaching.

_Machine learning_, 8(3-4):293–321.

Metz, L., Ibarz, J., Jaitly, N., and Davidson, J. (2017). Discrete sequential prediction of continuous actions for

deep rl. _arXiv preprint arXiv:1705.05035_ .

Mnih, V., Kavukcuoglu, K., Silver, D., Rusu, A. A., Veness, J., Bellemare, M. G., Graves, A., Riedmiller, M.,

Fidjeland, A. K., Ostrovski, G., et al. (2015). Human-level control through deep reinforcement learning.
_Nature_, 518(7540):529–533.

Ng, A., Coates, A., Diel, M., Ganapathi, V., Schulte, J., Tse, B., Berger, E., and Liang, E. (2006). Autonomous

inverted helicopter flight via reinforcement learning. _Experimental Robotics IX_, pages 363–372.

Ng, A. Y., Harada, D., and Russell, S. (1999). Policy invariance under reward transformations: Theory and

application to reward shaping. In _ICML_, volume 99, pages 278–287.

Osband, I., Blundell, C., Pritzel, A., and Van Roy, B. (2016). Deep exploration via bootstrapped dqn. In

_Advances In Neural Information Processing Systems_, pages 4026–4034.

Ostrovski, G., Bellemare, M. G., Oord, A. v. d., and Munos, R. (2017). Count-based exploration with neural

density models. _arXiv preprint arXiv:1703.01310_ .

Peters, J. and Schaal, S. (2008). Reinforcement learning of motor skills with policy gradients. _Neural networks_,

21(4):682–697.

Pinto, L. and Gupta, A. (2016). Learning to push by grasping: Using multiple tasks for effective learning. _arXiv_

_preprint arXiv:1609.09025_ .

Polyak, B. T. and Juditsky, A. B. (1992). Acceleration of stochastic approximation by averaging. _SIAM Journal_

_on Control and Optimization_, 30(4):838–855.

Popov, I., Heess, N., Lillicrap, T., Hafner, R., Barth-Maron, G., Vecerik, M., Lampe, T., Tassa, Y., Erez, T., and

Riedmiller, M. (2017). Data-efficient deep reinforcement learning for dexterous manipulation. _arXiv preprint_
_arXiv:1704.03073_ .

Schaul, T., Horgan, D., Gregor, K., and Silver, D. (2015a). Universal value function approximators. In

_Proceedings of the 32nd International Conference on Machine Learning (ICML-15)_, pages 1312–1320.

Schaul, T., Quan, J., Antonoglou, I., and Silver, D. (2015b). Prioritized experience replay. _arXiv_ _preprint_

_arXiv:1511.05952_ .

Schmidhuber, J. (2004). Optimal ordered problem solver. _Machine Learning_, 54(3):211–254.

Schmidhuber, J. (2013). Powerplay: Training an increasingly general problem solver by continually searching

for the simplest still unsolvable problem. _Frontiers in psychology_, 4.

Schmidhuber, J. and Huber, R. (1990). _Learning to generate focus trajectories for attentive vision_ . Institut für

Informatik.

Silver, D., Huang, A., Maddison, C. J., Guez, A., Sifre, L., Van Den Driessche, G., Schrittwieser, J., Antonoglou,

I., Panneershelvam, V., Lanctot, M., et al. (2016). Mastering the game of go with deep neural networks and
tree search. _Nature_, 529(7587):484–489.

Srivastava, R. K., Steunebrink, B. R., and Schmidhuber, J. (2013). First experiments with powerplay. _Neural_

_Networks_, 41:130–136.

12

Strehl, A. L. and Littman, M. L. (2005). A theoretical analysis of model-based interval estimation. In _Proceedings_

_of the 22nd international conference on Machine learning_, pages 856–863. ACM.

Sukhbaatar, S., Kostrikov, I., Szlam, A., and Fergus, R. (2017). Intrinsic motivation and automatic curricula via

asymmetric self-play. _arXiv preprint arXiv:1703.05407_ .

Sutton, R. S., Modayil, J., Delp, M., Degris, T., Pilarski, P. M., White, A., and Precup, D. (2011). Horde: A

scalable real-time architecture for learning knowledge from unsupervised sensorimotor interaction. In _The_
_10th International Conference on Autonomous Agents and Multiagent Systems-Volume 2_, pages 761–768.
International Foundation for Autonomous Agents and Multiagent Systems.

Tang, H., Houthooft, R., Foote, D., Stooke, A., Chen, X., Duan, Y., Schulman, J., De Turck, F., and Abbeel, P.

(2016). # exploration: A study of count-based exploration for deep reinforcement learning. _arXiv preprint_
_arXiv:1611.04717_ .

Tobin, J., Fong, R., Ray, A., Schneider, J., Zaremba, W., and Abbeel, P. (2017). Domain randomization for

transferring deep neural networks from simulation to the real world. _arXiv preprint arXiv:1703.06907_ .

Todorov, E., Erez, T., and Tassa, Y. (2012). Mujoco: A physics engine for model-based control. In _Intelligent_

_Robots and Systems (IROS), 2012 IEEE/RSJ International Conference on_, pages 5026–5033. IEEE.

Vezhnevets, A. S., Osindero, S., Schaul, T., Heess, N., Jaderberg, M., Silver, D., and Kavukcuoglu, K. (2017).

Feudal networks for hierarchical reinforcement learning. _arXiv preprint arXiv:1703.01161_ .

Zaremba, W. and Sutskever, I. (2014). Learning to execute. _arXiv preprint arXiv:1410.4615_ .

13

**A** **Experiment details**

In this section we provide more details on our experimental setup and hyperparameters used.

**Bit-flipping experiment:** We used a network with 1 hidden layer with 256 neurons. The length of
each episode was equal to the number of bits and the episode was considered successful if the goal
state was achieved at an arbitrary timestep during the episode. All other hyperparameters used were
the same as in the case of DDPG experiments.

**State-goal distributions:** For all tasks the initial position of the gripper is fixed, for the pushing
and sliding tasks it is located just above the table surface and for pushing it is located 20cm above the
table. The object is placed randomly on the table in the 30cm x 30cm (20c x 20cm for sliding) square
with the center directly under the gripper (both objects are 5cm wide). For pushing, the goal state is
sampled uniformly from the same square as the box position. In the pick-and-place task the target is
located in the air in order to force the robot to grasp (and not just push). The _x_ and _y_ coordinates
of the goal position are sampled uniformly from the mentioned square and the height is sampled
uniformly between 10cm and 45cm. For sliding the goal position is sampled from a 60cm x 60cm
square centered 40cm away from the initial gripper position. For all tasks we discard initial state-goal
pairs in which the goal is already satisfied.

**Network architecture:** Both actor and critic networks have 3 hidden layers with 64 hidden units
in each layer. Hidden layers use ReLu activation function and the actor output layer uses tanh. The
output of the tanh is then rescaled so that it lies in the range [ _−_ 5cm _,_ 5cm]. In order to prevent tanh
saturation and vanishing gradients we add the square of the their preactivations to the actor’s cost
function.

**Training** **procedure:** We train for 200 epochs. Each epoch consists of 50 cycles where each
cycle consists of running the policy for 16 episodes and then performing 40 optimization steps on
minibatches of size 128 sampled uniformly from a replay buffer consisting of 10 <sup>6</sup> transitions. We
update the target networks after every cycle using the decay coefficient of 0 _._ 95. Apart from using
the target network for computing Q-targets for the critic we also use it in testing episodes as it is
more stable than the main network. The whole training procedure is distributed over 8 threads. For
the Adam optimization algorithm we use the learning rate of 0 _._ 001 and the default values from
Tensorflow framework (Abadi et al., 2016) for the other hyperparameters. We use the discount factor
of _γ_ = 0 _._ 98 for all transitions including the ones ending an episode. Moreover, we clip the targets
used to train the critic to the range of possible values, i.e. [ _−_ 1 _−_ <u>1</u> _γ_ <sup>_,_</sup> <sup>0].</sup>

**Input scaling:** Neural networks have problems dealing with inputs of different magnitudes and
therefore it is crucial to scale them properly. To this end, we rescale inputs to neural networks so
that they have mean zero and standard deviation equal to one and then clip them to the range [ _−_ 5 _,_ 5].
Means and standard deviations used for rescaling are computed using all the observations encountered
so far in the training.

**Exploration:** The behavioral policy we use for exploration works as follows. With probability
20% we sample (uniformly) a random action from the hypercube of valid actions. Otherwise, we
take the output of the policy network and add independently to every coordinate normal noise with
standard deviation equal to 5% of the total range of allowed values on this coordinate.

**Simulation:** Every episode consists of 50 environment timesteps, each of which consists of 10
MuJoCo steps with ∆ _t_ = 0 _._ 002 _s_ . MuJoCo uses soft constraints for contacts and therefore object
penetration is possible. It can be minimized by using a small timestep and more constraint solver
epochs but it would slow down the simulation. We encountered some penetration in the pushing task
(the agent learnt to push the box into the table in a way that it is pushed out by contact forces onto the
target). In order to void this behaviour we added to the reward a term penalizing the squared depth of
penetration for every contact pair.

14

**Training time:** Training for 200 epochs took us approximately 2.5h for pushing and the pick-andplace tasks and 6h for sliding (because physics simulation was slower for this task) using 8 cpu
cores.

**B** **Deployment on the physical robot**

We have trained a convolutional neural network (CNN) which predicts the box position given the
raw image from the fetch head camera. The CNN was trained using only images coming from the
Mujoco renderer. Despite the fact that training images were not photorealistic, the trained network
performs well on real world data thanks to a high degree of randomization of textures, lightning and
other visual parameters in training. This approach called _domain randomization_ is described in more
detail in Tobin et al. (2017).

At the beginning of each episode we initialize a simulated environment using the box position
predicted by the CNN and robot state coming from the physical robot. From this point we run the
policy in the simulator. After each timestep we send the simulated robot joint angles to the real one
which is position-controlled and uses the simulated data as targets.

15
