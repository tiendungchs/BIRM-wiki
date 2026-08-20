# Deconstructing deep active inference

> Converted from `Deconstructing deep active inference.pdf` on 2026-08-18 via `pymupdf4llm`.
> Layout artefacts (broken equations, interleaved columns) are conversion noise, not the source.

---

## **Deconstructing deep active inference.**

**Th´eophile** **Champion** tmac3@kent.ac.uk
_University_ _of_ _Kent,_ _School_ _of_ _Computing_
_Canterbury_ _CT2_ _7NZ,_ _United_ _Kingdom_

**Marek** **Grze´s** m.grzes@kent.ac.uk
_University_ _of_ _Kent,_ _School_ _of_ _Computing_
_Canterbury_ _CT2_ _7NZ,_ _United_ _Kingdom_

**Lisa** **Bonheme** lb732@kent.ac.uk
_University_ _of_ _Kent,_ _School_ _of_ _Computing_
_Canterbury_ _CT2_ _7NZ,_ _United_ _Kingdom_

**Howard** **Bowman** H.Bowman@kent.ac.uk

_University_ _of_ _Birmingham,_ _School_ _of_ _Psychology,_

_Birmingham_ _B15_ _2TT,_ _United_ _Kingdom_

_University_ _of_ _Kent,_ _School_ _of_ _Computing_

_Canterbury_ _CT2_ _7NZ,_ _United_ _Kingdom_

_University_ _College_ _London,_ _Wellcome_ _Centre_ _for_ _Human_ _Neuroimaging_ _(honorary)_

_London_ _WC1N_ _3AR,_ _United_ _Kingdom_

**Editor:** **TO** **BE** **FILLED**

**Abstract**

Active inference is a theory of perception, learning and decision making, which can be applied to
neuroscience, robotics, psychology, and machine learning. Recently, intensive reasearch has been
taking place to scale up this framework using Monte-Carlo tree search and deep learning. The
end-goal of this activity is to solve more complicated tasks using deep active inference. First,
we review the existing literature, then, we progresively build a deep active inference agent as
follows: (i) implement a variational auto-encoder (VAE), (ii) implement a deep hidden Markov
model (HMM), (iii) implement a deep critical hidden Markov model (CHMM), and (iv) implement a complete deep active inference agent (DAI). For the CHMM and DAI agents, we have
experimented with five definitions of the expected free energy and three different action selection
strategies. According to our experiments, the models able to solve the dSprites environment are
the ones that maximise rewards. Finally, we compare the similarity of the representation learned
by the layers of various models (e.g., deep Q-network, CHMM, DAI) using centered kernel alignment. Importantly, the CHMM maximising reward and the CHMM minimising expected free
energy learn very similar representations except for the last layer of the critic network (reflecting the difference in learning objective), and the variance layers of the transition and encoder
networks. While performing further inspection of those (variance) layers, we found that the transition network of the reward maximising CHMM is a lot more certain than the transition network
of the CHMM minimising expected free energy. More precisely, the CHMM minimising expected
free energy is only confident about the world transition when performing action down. This suggests that the CHMM minimising expected free energy always picks the action down, and does
not gather enough data for the other actions. In contrast, the CHMM maximising reward, keeps
on selecting the actions left and right, enabling it to successfully solve the task. The only difference between those two CHMMs is the epistemic value, which aims to make the outputs of the
transition and encoder networks as close as possible. Thus, the CHMM minimising expected free

Champion et al.

energy repeatedly picks a single action (down), and becomes an expert at predicting the future
when selecting this action. This effectively makes the KL divergence between the output of the
transition and encoder networks small. Additionally, when selecting the action down the average
reward is zero, while for all the other actions, the expected reward will be negative. Therefore, if
the CHMM has to stick to a single action to keep the KL divergence small, then the action down
is the most rewarding. Thus, the appropriate formulation of the epistemic value in deep active
inference remains an open question.

**Keywords:** Deep Learning, Active Inference, Bayesian Statistics, Free Energy Principle, Reinforcement Learning

**1.** **Introduction**

Active inference is a unified framework for perception, learning, and planning that has emerged from theoretical neuroscience (Costa et al, 2020a; Champion et al, 2021, 2022b,a,c). This framework has successfully
explained a wide range of brain phenomena (Friston et al, 2016; Itti and Baldi, 2009; Schwartenbeck et al,
2018; FitzGerald et al, 2015), and has been applied to a large number of tasks in robotics and artificial
intelligence (Fountas et al, 2020; Pezzato et al, 2020; Sancaktar et al, 2020; C¸atal et al, 2020; Cullen et al,
2018; Millidge, 2019).
A promising area of research revolves around scaling up this theoretical framework to tackle increasingly complex tasks. Research towards this goal is generally driven from recent advances in machine
learning. For example, variational auto-encoders (Doersch, 2016; Higgins et al, 2017; Kingma and Welling,
2014; Rezende et al, 2014) have been key to the integration of deep neural networks within active inference (Sancaktar et al, 2020; C¸atal et al, 2020; Millidge, 2020), and the Monte Carlo tree search algorithm
(Browne et al, 2012; Silver et al, 2016) has been used to improve planning efficency (Fountas et al, 2020;
Champion et al, 2022b,a,c,d).

Another closely related field is reinforcement learning (Mnih et al, 2013; van Hasselt et al, 2015;
Lample and Chaplot, 2016), which addresses the same kind of tasks, where an agent must interact with
its environment. A known challenge in this field is the correlation between the consecutive samples,
which violates the standard i.i.d. assumption on which most of machine learning relies. To break this
correlation, researchers proposed to store past experiences of the agent inside a replay buffer (Mnih et al,
2013). Experiences can then be re-sampled randomly from the buffer to train the Q-network, which is
used to approximate Q-values. The Q-network is trained to minimize the mean squared error between its
output and a target value, which is defined as:

_,_

_y_ ( _ot, at_ ) = E _ot_ +1 _∼E_ ( _ot,at_ )

_rt_ + _γ_ _at_ max+1

_at_ max+1 _∈A_ <sup>_Qθa_</sup> <sup>(</sup> <sup>_ot_</sup> <sup>+1</sup> <sup>_, at_</sup> <sup>+1)</sup>

where _t_ is the present time step, _A_ is the set of available actions, _y_ ( _ot, at_ ) is the target Q-value to be
predicted, E is the expectation w.r.t the observations received from the environment, _rt_ is the reward
obtained by the agent when performing action _at_ in state <sup>1</sup> _ot_, _ot_ +1 is the state reached when performing
action _at_ in state _ot_, _E_ is the environment emulator from which _ot_ +1 is sampled, _γ_ is the discount factor
that discounts future rewards, and _Qθa_ ( _ot_ +1 _, at_ +1) is the output of the Q-network, i.e., the estimated
Q-value of performing action _at_ +1 in state _ot_ +1.

Unfortunatly, using the above target to train the Q-network can make the training unstable. Generally,
the problem is addressed by introducing a target network _Q_ <sup>ˆ</sup> _θ_ ˆ _a_ ( _ot_ +1 _, at_ +1), which is simply a copy of the
Q-network. The weights of the target network are then synchronized with the weights of the Q-network

1. Note, we are using the notation _oτ_ for the (observable) state at (an arbitrary) time step _τ_, instead of the more standard
notation _sτ_ . This is because we reserve the notation _sτ_ for the (unobserved) states that arise in the context of active
inference.

2

Deconstructing deep active inference.

every _K_ (learning) iterations (Mnih et al, 2013). The new target is obtained by replacing the Q-network
by the target network, i.e.,

       
_Q_ ˆ _θ_ ˆ _a_ ( _ot_ +1 _, at_ +1) _._

_y_ ( _ot, at_ ) = E _ot_ +1 _∼E_ ( _ot,at_ )

_rt_ + _γ_ max

_at_ +1 _∈A_

In Section 2, we review the existing literature and present: the Deep Q-network (DQN) agent (Mnih et al,
2013), the deep active inference with Monte-Carlo methods ( _DAIMC_ ) agent by Fountas et al (2020), the
deep active inference as variational policy gradients ( _DAIV PG_ ) approach by Millidge (2020), the deep
active inference agent of rubber hand illusion ( _DAIRHI_ ) by Rood et al (2020), the deep active inference
agent for humanoid robot control ( _DAIHR_ ) by Sancaktar et al (2020); Lanillos et al (2020); Oliver
et al (2019), the deep active inference agent based on the free action objective ( _DAIFA_ ) by Ueltzh¨offer
(2018), a deep active inference agent for partially observable Markov decision processes ( _DAIPOMDP_ )
by van der Himst and Lanillos (2020), as well as various methods for which the code is not available
online. We argue that while all these approaches illuminate important issues associated with realising a
deep active inference agent, a fully complete implementation has not yet been published. Consequently,
to systematically explore the construction of deep active inference agents, in Section 3, we incrementally
build such an agent. We start with a simple variational auto-encoder (VAE) composed of an encoder and
decoder network. Next, a transition network is added to create a deep hidden Markov model (HMM).
Then, a critic network is added to define a prior over actions, which leads to the critical HMM (CHMM).
Lastly, the policy network is added to approximate the posterior over actions leading to the full deep active
inference (DAI) agent. Then, in Section 4, we discuss our findings regarding the abilities and limitations
of each intermediate step. This section also presents an analysis and discussion of the representations
learned by each intermediate model. Finally, Section 6 puts our findings in context and concludes this
paper.

**2.** **Review** **of** **existing** **research**

In this section, we discuss the DQN agent from the reinforcement learning literature, six agents from the
active inference literature for which the code is available online ( _DAIMC_, _DAIV PG_, _DAIRHI_, _DAIHR_,
_DAIFA_, and _DAIPOMDP_ ), and a few other deep active inference agents for which the code is unavailable.
Finally, we explain how the representations learned by the agents can be compared using centered kernel
alignment. Note, the notation used throughout this section is summarised in Appendix A.

**2.1** _DQN_ **agent** **(Mnih** **et** **al,** **2013)**

Let us start with the DQN agent (Mnih et al, 2013), whose goal is to maximise the amount of reward
obtained over time. At each time step _τ_, the agent is observing an image _oτ_, and is allowed to perform one
action _aτ_ _∈A_ . After performing _aτ_ when observing _oτ_, the agent receives a reward _rτ_ . The Q-learning
algorithm (Sutton et al, 1998) aims to maximise reward by computing the Q-values _Q_ ( _oτ_ _, aτ_ ), for each
state-action pair ( _oτ_, _aτ_ ). The Q-values represent the expected amount of rewards obtained by taking
action _aτ_ in state _oτ_ . This approach is intractable for image based domains such as Atari games, since one
would need to store a vector of Q-values for each possible image. Instead, the DQN algorithm (illustrated
in Figure 1) has been developed, which uses a deep neural network _Qθa_ to approximate the Q-values.
More formally, _Qθa_ maps any observation to a vector of size # _A_ containing the Q-values of each possible
action, and we denote by _Qθa_ ( _oτ_ _, aτ_ ) the element at position _aτ_ in the output vector predicted by _Qθa_
when provided with the image _oτ_ . As we discussed in the introduction, the training stability of the Qnetwork is improved by introducing a target network _Q_ <sup>ˆ</sup> _θ_ ˆ _a_, which is structurally identical to the Q-network
and whose weights are synchronised with the weights of the Q-network every _K_ (learning) iterations. The
Q-network’s weights are then optimised using gradient descent to minimise the mean square error between

3

Champion et al.

the output of the Q-network and a target value, i.e., _θa_ <sup>_∗_</sup> <sup>= arg min</sup> _θa_ <sup>MSE[</sup> <sup>_Qθ_</sup> _a_ <sup>(</sup> <sup>_ot,_</sup> <sup>_•_</sup> <sup>)</sup> <sup>_, y_</sup> <sup>(</sup> <sup>_ot,_</sup> <sup>_•_</sup> <sup>)], where</sup> <sup>_y_</sup> <sup>(</sup> <sup>_ot, at_</sup> <sup>)</sup>

is the target Q-value for each state-action pair, and, as highlighted earlier, is defined as follows:

       
_Q_ ˆ _θ_ ˆ _a_ ( _ot_ +1 _, at_ +1) _._

_y_ ( _ot, at_ ) = E _ot_ +1 _∼E_ ( _ot,at_ )

_rt_ + _γ_ max

_at_ +1 _∈A_

Figure 1: This figure illustrates the DQN agent. Briefly, the image _ot_ is fed into the Q-network, and
the image _ot_ +1 is fed into the target network. The Q-network outputs the Q-values for each action at
time _t_, and the target network outputs the Q-values for each action at time _t_ + 1. Then, the reward, the
discount factor, and Q-values of each action at time _t_ + 1 are used to compute the target values _y_ ( _ot,_ <sup>_•_</sup> ).
Finally, the goal is to minimise the MSE between the prediction of the Q-network and the target values
by changing the weights of the Q-network.

**2.2** _DAIMC_ **agent** **(Fountas** **et** **al,** **2020)**

In this section, we review the _DAIMC_ agent proposed by Fountas et al (2020), which represents the most
ambitious and complete implementation of a deep active inference agent that accordingly adds important
new concepts to the field. The relevant code is available at the following URL: `[https://github.com/](https://github.com/zfountas/deep-active-inference-mc)`
`[zfountas/deep-active-inference-mc](https://github.com/zfountas/deep-active-inference-mc)` . The _DAIMC_ agent is composed of four deep neural networks, as
illustrated in Figures 2 and 3. The encoder _Eφs_ takes images as input, and outputs the mean and variance
of the variational distribution over hidden states, i.e., _Qφs_ ( _st_ ) = _N_ ( _st_ ; _µ, σ_ ), where _µ, σ_ = _Eφs_ ( _ot_ ). The
decoder _Dθo_ takes a state as input, and outputs the parameters of a product of Bernoulli distributions,
which can be interpreted as the expected (reconstructed) image _o_ ˆ _t_, i.e.,

_Pθo_ ( _ot|st_ ) = _B_ ernoulli( _ot_ ; ˆ _ot_ ) _,_

where _o_ ˆ _t_ = _Dθo_ ( _st_ ) are the values predicted by the decoder, and _B_ ernoulli( _ot_ ; ˆ _ot_ ) is a product of Bernoulli
distributions defined as:

Bernoulli( _ot_ [ _x, y_ ]; ˆ _ot_ [ _x, y_ ]) _,_

4

_B_ ernoulli( _ot_ ; ˆ _ot_ ) =

_x,y_

Deconstructing deep active inference.

Figure 2: This figure illustrates the _DAIMC_ agent, which is composed of an encoder, a decoder, a
transition network, and a policy network. The same VAE (encoder and decoder) is repeated in the figure
to reflect successive time-points.

where Bernoulli( <sup>_•_</sup> ; <sup>_•_</sup> ) is a Bernoulli distribution over the possible values of the pixel _ot_ [ _x, y_ ], parameterized
by the parameter _o_ ˆ _t_ [ _x, y_ ]. The transition network _Tθs_ takes a state-action pair as input, and outputs the
mean and variance of a Gaussian distribution over hidden states, i.e., _Pθs_ ( _sτ_ +1 _|sτ_ _, aτ_ ) = _N_ ( _sτ_ +1;˚ _µ,_ _ω_ <sup><u>˚</u></sup> <sup>_<u>σ</u>_</sup> _t_ <sup>),</sup>

where ˚ _µ,_ ˚ _σ_ = _Tθs_ ( _sτ_ _, aτ_ ), and _ωt_ is the top-down attention parameter modulating the precision of the
transition mapping (see below). The policy network _Pφa_ takes a state as input, and outputs a distribution
over actions, i.e., _Qφa_ ( _at|st_ ) = Cat( _at_ ; ˆ _π_ ), where _π_ ˆ = _Pφa_ ( _st_ ). Finally, the prior over actions is defined as
follows:

[ _πt_ = _at_ ] _P_ ( _π_ ) _,_ (1)

_P_ ( _at_ ) =

_π∈_ Π

where Π is the set of all possible policies, _πt_ is the action precribed by policy _π_ at time _t_, the square
brackets represent an indicator function that equals one if the condition within the bracket is satisfied
and zero otherwise, and _P_ ( _π_ ) is the prior over policies defined as:

_P_ ( _π_ ) = _σ_ [ _−G_ ( _π_ )] _,_

5

Champion et al.

where _σ_ [ <sup>_•_</sup> ] is the softmax function, and _G_ ( _π_ ) is the expected free energy (EFE) of policy _π_, which is
defined as:

_G_ ( _π_ ) =

_T_

_τ_ = _t_

_Gτ_ ( _π_ ) =

_T_

_τ_ = _t_

E _Q_ ˜

- ln _Q_ ( _sτ_ _, θ|π_ ) _−_ ln _P_ <sup>˜</sup> ( _oτ_ _, sτ_ _, θ|π_ ) _,_ (2)

where _Q_ <sup>˜</sup> = _Q_ ( _oτ_ _, sτ_ _, θ|π_ ) = _Q_ ( _θ|π_ ) _Q_ ( _sτ_ _|θ, π_ ) _Q_ ( _oτ_ _|sτ_ _, θ, π_ ) is the predictive posterior, and _P_ <sup>˜</sup> ( _oτ_ _, sτ_ _, θ|π_ ) =
_P_ ( _θ|sτ_ _, oτ_ _, π_ ) _P_ ( _sτ_ _|oτ_ _, π_ ) _P_ ( _oτ_ _|π_ ) is the target distribution. However, Equation 2 needs to be re-arranged
to be computed in practice <sup>2</sup>, and Section 2.2.3 will present this derivation. Finally, as shown in Figure 2,
the top-down attention parameter is computed as follows:

_<u>a</u>_
_ωt_ = 1 + exp( _−_ <sup>_<u>b−Dt</u>_</sup> ) <sup>+</sup> <sup>_d,_</sup>
_c_

where _Dt_ = _D_ KL [ _Qφa_ ( _at|st_ ) _|| P_ ( _at_ )], and _{a, b, c, d}_ are fixed hyperparameters. Intuitively, _ωt_ is high
when the posterior over actions (from the policy network) is close to the prior over actions (from the
expected free energy), and low when the posterior is far away from the prior. This, in turn, means
that extra uncertainty is introduced into the transition mapping (see paragraph before Equation 1) when
posterior over actions and prior over actions are very different. Finally, note that the number of terms
required to compute the prior over actions (defined in Equation 1) grows exponentially with the time
horizon of planning. Because this is intractable in practice, Fountas et al (2020) implemented a MonteCarlo tree search (MCTS) algorithm to evaluate the expected free energy of each action (see below).
Finally, action selection is performed by sampling from the following distribution:

_<u>N</u>_ <u>(ˆ</u> _<u>st, at</u>_ <u>)</u>
_P_ ˜( _at_ ) = <u>�</u>
_a_ ˆ _t_ <sup>_N_</sup> <sup>(ˆ</sup> <sup>_st,_</sup> <sup>ˆ</sup> <sup>_at_</sup> <sup>)</sup> <sup>_,_</sup>

where _s_ ˆ _t_ is the current state of the environment, and _N_ ( _st, at_ ) is the number of times action _at_ has been
visited from state _st_ during MCTS.

2.2.1 The Monte-Carlo tree search

In this section, we describe the planning algorithm used by _DAIMC_, i.e., Monte-Carlo tree search (MCTS).
MCTS is used to enhance the planning ability of the agent by allowing it to look into the future. At the
beginning of an action-perception cycle, the agent is provided with an image _ot_ . This image can be feed
into the encoder to get the mean vector _µ_ of the posterior over the latent states, i.e., _Qφs_ ( _st_ ) = _N_ ( _st_ ; _µ, σ_ ).
Since _µ_ is the mean of the Gaussian posterior, it can be interpreted as the maximum a posteriori (MAP)
estimate of the latent states at time step _t_ . This MAP estimate will constitute the root node of the
Monte-Carlo tree search (MCTS).

The first step of the MCTS is to use the Upper Confidence bounds for Trees (UCT) criterion to
determine which node in the tree should be expanded. Let the tree’s root _s_ ˆ _t_ be called the current node,
which is denoted _s_ ˆ _τ_ . If the current node has no children (i.e., no previously selected actions from the
current node), then it is selected for expansion. Alternatively, the child with the highest UCT criterion
becomes the new current node and the process is iterated until we reach a leaf node (i.e. a node from
which no action has previously been selected). The UCT criterion (Browne et al, 2012) of the child of _s_ ˆ _τ_
corresponding to action _a_ ˆ _τ_ is given by:

_UCT_ (ˆ _sτ_ _,_ ˆ _aτ_ ) = _−G_ <sup>¯</sup> (ˆ _sτ_ _,_ ˆ _aτ_ ) + _Cexplore ·_ <sup>_Qφa_</sup> <sup>(</sup> <sup>_aτ_</sup> <sup>= ˆ</sup> <sup>_aτ_</sup> <sup>_|sτ_</sup> <sup>=</sup> <sup>_s_</sup> <sup>ˆ</sup> <sup>_<u>τ</u>_</sup> <sup>)</sup> _,_

1 + _N_ (ˆ _sτ_ _,_ ˆ _aτ_ )

2. By “in practice”, we mean “in the code” or equivalently “when implementing the approach”.

6

Deconstructing deep active inference.

**_Qφa_** **(** **_aτ_** **_|sτ_** **)**

**input:** #S

**_Pθs_** **(** **_sτ_** **+1** **_|sτ_** **_, aτ_** **)**

**input:** #S + #A

**_Qφs_** **(** **_sτ_** **)**

**input:** 64 _×_ 64 _×_ #C

**_Pθo_** **(** **_oτ_** **_|sτ_** **)**

**input:** #S

Figure 3: Neural network architectures of the _DAIMC_ agent. Orange blocks correspond to convolutional
layers, green blocks correspond to fully connected layers, blue blocks correspond to dropout, and yellow
blocks correspond to up-convolutional layers. For the dSprites environment, there are four actions (i.e.,
#A = 4), ten states (i.e., #S = 10), and only one channel (i.e., #C = 1). For the Animal-AI environment,
there are three actions (i.e., #A = 3), ten states (i.e., #S = 10), and three channels (i.e., #C = 3).7 These
are all trained to minimize variational free energy.

Champion et al.

where _G_ <sup>¯</sup> (ˆ _sτ_ _,_ ˆ _aτ_ ) is the average expected free energy of taking action _a_ ˆ _τ_ in state _s_ ˆ _τ_, _Cexplore_ is the exploration constant that modulates the amount of exploration at the tree level, _N_ (ˆ _sτ_ _,_ ˆ _aτ_ ) is the number of
times action _a_ ˆ _τ_ was visited in state _s_ ˆ _τ_, and _Qφa_ ( _aτ_ = ˆ _aτ_ _|sτ_ = _s_ ˆ _τ_ ) is the posterior probability of action _a_ ˆ _τ_
in state _s_ ˆ _τ_ as predicted by the policy network.

Let ˚ _sτ_ be the (leaf) node selected by the above selection procedure. The MCTS then expands one of
the children of ˚ _sτ_ . The expansion uses the transition network to compute the mean ˚ _µ_ of _Pθs_ ( _sτ_ +1 _|sτ_ =
˚ _sτ_ _, aτ_ = ˚ _aτ_ ), which is viewed as a MAP estimate of the states at time _τ_ + 1. Then, we need to estimate

the cost of (virtually) taking action ˚ _aτ_ . By definition, the cost is the expected free energy given by (2),
and Monte-Carlo rollouts can be run to improve its estimation. The final step of the planning iteration is
to back-propagate the cost of the newly expanded (virtual) action toward the root of the tree. Formally,
we write the update as follows:

_∀s ∈_ A˚ _sτ_ _∪{_ ˚ _sτ_ _},_ **_G_** _s_ _←_ **_G_** _s_ + **_G_** ˚ _sτ,_ (3)

where ˚ _sτ_ is the node that was selected for expansion, **_G_** _s_ is the expected free energy of _s_, and A˚ _sτ_ is the
set of all ancestors of ˚ _sτ_ in the tree. During the back propagation, we also update the number of visits as
follows:

_∀s ∈_ A˚ _sτ_ _∪{_ ˚ _sτ_ _},_ **_N_** _s_ _←_ **_N_** _s_ + 1 _._ (4)

If we let **_G_** <sup>_aggr_</sup> _s_ be the aggregated cost of an arbitrary node _s_ obtained by applying Equation 3 after each

expansion, then we are now able to express **_G_** <sup>¯</sup> _s_ formally as:

_<u>s</u>_

**_G_** ¯ _s_ = <sup>**_<u>G</u>_**</sup> <sup>_aggr_</sup>

**_N_** _s_

_._

Importantly, if the node _s_ corresponds to the state reached from state _s_ ˆ _τ_ by performing action _a_ ˆ _τ_,
then _G_ <sup>¯</sup> (ˆ _sτ_ _,_ ˆ _aτ_ ) = **_G_** <sup>¯</sup> _s_ and _N_ (ˆ _sτ_ _,_ ˆ _aτ_ ) = **_N_** _s_ . The planning procedure described above ends when the
maximum number of planning iterations is reached, or when a clear winner has been identified, i.e.,
if max _at P_ ( _at_ ) _−_ #1 _A_ <sup>_>_</sup> <sup>_Tdec_</sup> <sup>where</sup> <sup>#</sup> <sup>_A_</sup> <sup>is</sup> <sup>the</sup> <sup>number</sup> <sup>of</sup> <sup>possible</sup> <sup>actions,</sup> <sup>and</sup> <sup>_Tdec_</sup> <sup>is</sup> <sup>a</sup> <sup>(threshold)</sup>
hyperparameter.

2.2.2 Derivation of the variational free energy

In this section, we provide a derivation for the variational free energy used by Fountas et al (2020).
This derivation was introduced in (Millidge, 2020), and can be adapted to derive the variational free
energy of the models presented in Section 3. Recall, the goal of the variational free energy as classically
presented is to make the approximate posterior _Qφ_ ( _st, at_ ) as close as possible to the true posterior <sup>3</sup>

_P_ ( _st, at|ot, st−_ 1 _, at−_ 1), i.e.,

_Q_ <sup>_∗_</sup> _φ_ <sup>(</sup> <sup>_st, at_</sup> <sup>) = arg min</sup>

_Qφ_ ( _st,at_ )

_D_ KL [ _Qφ_ ( _st, at_ ) _|| P_ ( _st, at|ot, st−_ 1 _, at−_ 1)] _._

Using Bayes theorem, the linearity of expectation, and the fact that _Qφ_ ( _st, at_ ) integrates to one:

_Q_ <sup>_∗_</sup> _φ_ <sup>(</sup> <sup>_st, at_</sup> <sup>) = arg min</sup>

_Qφ_ ( _st,at_ )

= arg min

_Qφ_ ( _st,at_ )

= arg min

_Qφ_ ( _st,at_ )

_D_ KL [ _Qφ_ ( _st, at_ ) _|| P_ ( _st, at|ot, st−_ 1 _, at−_ 1)]

_D_ KL [ _Qφ_ ( _st, at_ ) _|| P_ ( _st, at, ot, st−_ 1 _, at−_ 1)] + ln _P_ ( _ot, st−_ 1 _, at−_ 1)

<u>�</u> <u>��</u> <u>�</u>
Constant w.r.t _Qφ_ ( _st,at_ )

_D_ KL [ _Qφ_ ( _st, at_ ) _|| P_ ( _st, at, ot, st−_ 1 _, at−_ 1)] _._

3. By posterior we mean a conditional distribution, where the given variables are those for which we observe a specific value.
Note, the value of _st−_ 1 is unknown but can be sampled from the posterior over _st−_ 1 (from the previous action-perception
cycle).

8

Deconstructing deep active inference.

Using the d-separation criteria (Koller and Friedman, 2009), it can be shown that:

_P_ ( _st, at, ot, st−_ 1 _, at−_ 1) = _Pθo_ ( _ot|st_ ) _P_ ( _at_ ) _Pθs_ ( _st|st−_ 1 _, at−_ 1) _Qφ_ ( _st−_ 1 _, at−_ 1) _,_

where _Qφ_ ( _st−_ 1 _, at−_ 1) is the variational posterior obtained through the inference process at the previous
time step. In the above equation, _Qφ_ ( _st−_ 1 _, at−_ 1) was used to replace _P_ ( _st−_ 1 _, at−_ 1), i.e., _Qφ_ ( _st−_ 1 _, at−_ 1)
was used as an empirical prior. Additionally, since _Qφ_ ( _st−_ 1 _, at−_ 1) is a constant w.r.t _Qφ_ ( _st, at_ ), the above
minimization problem reduces to:

_Q_ <sup>_∗_</sup> _φ_ <sup>(</sup> <sup>_st, at_</sup> <sup>)</sup> = arg min

_Qφ_ ( _st,at_ )

= arg min
_Qφa_ ( _at|st_ ) _Qφs_ ( _st_ )

_D_ KL [ _Qφ_ ( _st, at_ ) _|| Pθo_ ( _ot|st_ ) _P_ ( _at_ ) _Pθs_ ( _st|st−_ 1 _, at−_ 1)]

<u>�</u> <u>��</u> <u>�</u>
variational free energy

(5)

+ _D_ KL [ _Qφs_ ( _st_ ) _|| Pθs_ ( _st|st−_ 1 _, at−_ 1)]

E _Qφs_ ( _st_ )

_D_ KL [ _Qφa_ ( _at|st_ ) _|| P_ ( _at_ )]

_−_ E _Qφs_ ( _st_ )

- ln _Pθo_ ( _ot|st_ ) _._

By comparing the VFE in (5) and the EFE in (2), one can see an inconsistency. Namely, the parameters are
seen as latent variables in the EFE definition, c.f., _θ_ in (2), but they are regarded as parameters of neural
networks in the VFE, c.f., _θs_ and _θo_ in 5. Note, _θ_ cannot be both a parameter (i.e, parameter, vector, or
matrix) and a random variable, and if _θ_ is a random variable, one must define its probability density, i.e.,
_P_ ( _θ_ ). Additionally, this inconsistency raises the question of whether the EFE is really the expectation of
the VFE. To sum up, the _DAIMC_ agent is equipped with four deep neural networks modelling _Qφa_ ( _at|st_ ),
_Qφs_ ( _st_ ), _Pθs_ ( _st|st−_ 1 _, at−_ 1), and _Pθo_ ( _ot|st_ ). The weights of those networks are optimised using backpropagation to minimise the VFE given by (5). Note, (5) decomposes into two KL-divergence terms that
can be computed analytically, and the expectations can be approximated using a Monte-Carlo estimate.
Also, because _Pθo_ ( _ot|st_ ) is modelled as a product of Bernoulli distributions, the logarithm of _Pθo_ ( _ot|st_ )
reduces to the binary cross entropy.

2.2.3 Independence assumptions and the expected free energy

The EFE as stated in Equation (2) needs to be re-arranged because it cannot be easily evaluated. We
therefore present the derivation proposed by Fountas et al (2020). Then, we highlight two independence
assumptions, i.e., _sτ_ _⊥⊥_ _θ_ _|_ _π_ and _sτ_ _⊥⊥_ _θ_ _|_ _π, oτ_, used without explicitly presented proofs. Finally,
we propose an alternative derivation that does not require these two assumptions and produces a simpler result. Using the product rule of probability, one can see that _Q_ ( _sτ_ _, θ|π_ ) = _Q_ ( _θ|sτ_ _, π_ ) _Q_ ( _sτ_ _|π_ ) and

_P_ ˜( _oτ_ _, sτ_ _, θ|π_ ) = _P_ ( _oτ_ _|π_ ) _P_ ( _sτ_ _|oτ_ _, π_ ) _P_ ( _θ|sτ_ _, oτ_ _, π_ ). Using those two factorisations, the EFE given in (2),
i.e.,

_Gτ_ ( _π_ ) = E _Q_ ˜

- ln _Q_ ( _sτ_ _, θ|π_ ) _−_ ln _P_ <sup>˜</sup> ( _oτ_ _, sτ_ _, θ|π_ ) _,_

where _Q_ <sup>˜</sup> = _Q_ ( _oτ_ _, sτ_ _, θ|π_ ), and can be re-arranged as follows:

_Gτ_ ( _π_ ) = _−_ E _Q_ ˜

+ E _Q_ ˜

+ E _Q_ ˜

- ln _P_ <sup>˜</sup> ( _oτ_ _|π_ )�

- ln _Q_ ( _sτ_ _|π_ ) _−_ ln _P_ <sup>˜</sup> ( _sτ_ _|oτ_ _, π_ )�

- ln _Q_ ( _θ|sτ_ _, π_ ) _−_ ln _P_ <sup>˜</sup> ( _θ|sτ_ _, oτ_ _, π_ ) _._ (6)

Note, the above derivation follows the work of Fountas et al (2020).

9

Champion et al.

**Re-arranging** **the** **second** **term** **of** **Equation** (6) **according** **to** **Fountas** **et** **al** **(2020)**

First, the second term of Equation (6) is re-arranged into entropy terms for which an analytical solution
exists. In the supplementary material of (Fountas et al, 2020), the derivation proceeds as follows:

- ln _Q_ ( _sτ_ _|π_ ) _−_ ln _Q_ ( _sτ_ _|oτ_ _, π_ ) (7)

E _Q_ ˜

- ln _Q_ ( _sτ_ _|π_ ) _−_ ln _P_ <sup>˜</sup> ( _sτ_ _|oτ_ _, π_ ) =∆ E _Q_ ˜

= E _Q_ ( _θ|π_ ) _Q_ ( _sτ_ _|θ,π_ ) _Q_ ( _oτ_ _|sτ_ _,θ,π_ )

- ln _Q_ ( _sτ_ _|π_ ) _−_ ln _Q_ ( _sτ_ _|oτ_ _, π_ )

- 
) E _Q_ ( _sτ_ _|θ,π_ )[ln _Q_ ( _sτ_ _|π_ )] _−_ E _Q_ ( _sτ_ _|θ,π_ ) _Q_ ( _oτ_ _|sτ_ _,θ,π_ )[ln _Q_ ( _sτ_ _|oτ_ _, π_ )]

) E _Q_ ( _sτ_ _|θ,π_ )[ln _Q_ ( _sτ_ _|π_ )] _−_ E _Q_ ( _sτ_ _|θ,π_ ) _Q_ ( _oτ_ _|sτ_ _,θ,π_ )[ln _Q_ ( _sτ_ _|oτ_ _, π_ )]

= E _Q_ ( _θ|π_ )

= E _Q_ ( _θ|π_ )

- 
) E _Q_ ( _sτ_ _|θ,π_ )[ln _Q_ ( _sτ_ _|π_ )] _−_ E _Q_ ( _oτ_ _|θ,π_ ) _Q_ ( _sτ_ _,|oτ_ _,θ,π_ )[ln _Q_ ( _sτ_ _|oτ_ _, π_ )] _,_

) E _Q_ ( _sτ_ _|θ,π_ )[ln _Q_ ( _sτ_ _|π_ )] _−_ E _Q_ ( _oτ_ _|θ,π_ ) _Q_ ( _sτ_ _,|oτ_ _,θ,π_ )[ln _Q_ ( _sτ_ _|oτ_ _, π_ )]

where in the first line a distribution was renamed, i.e., _P_ <sup>˜</sup> ( _sτ_ _|oτ_ _, π_ ) =∆ _Q_ ( _sτ_ _|oτ_ _, π_ ). The next step in the
derivation (c.f. supplementals of Fountas et al (2020)) re-arranges this final expression to the following:

- E _Q_ ( _oτ_ _|θ,π_ )[ _H_ [ _Q_ ( _sτ_ _|oτ_ _, π_ )]] _−_ _H_ [ _Q_ ( _sτ_ _|π_ )] _._

E _Q_ ˜

- ln _Q_ ( _sτ_ _|π_ ) _−_ ln _Q_ ( _sτ_ _|oτ_ _, π_ ) = E _Q_ ( _θ|π_ )

However, the above equation assumes that _sτ_ _⊥⊥_ _θ_ _|_ _π_ and _sτ_ _⊥⊥_ _θ_ _|_ _π, oτ_ . In other words, some of the
conditioning on _θ_ has been dropped, i.e.,

E _Q_ ( _θ|π_ )

- E _Q_ ( _sτ_ _|θ,π_ )[ln _Q_ ( _sτ_ _|π_ )] _−_ E _Q_ ( _oτ_ _|θ,π_ ) _Q_ ( _sτ_ _,|oτ_ _,θ,π_ )[ln _Q_ ( _sτ_ _|oτ_ _, π_ )] (last expression of derivation 7)

= E _Q_ ( _θ|π_ )

= E _Q_ ( _θ|π_ )

- E _Q_ ( _sτ_ _|π_ )[ln _Q_ ( _sτ_ _|π_ )] _−_ E _Q_ ( _oτ_ _|θ,π_ ) _Q_ ( _sτ_ _|oτ_ _,π_ )[ln _Q_ ( _sτ_ _|oτ_ _, π_ )]

E _Q_ ( _oτ_ _|θ,π_ )

- _H_ [ _Q_ ( _sτ_ _|oτ_ _, π_ )]

- _−_ _H_ [ _Q_ ( _sτ_ _|π_ )]

_._

Whether this conditioning can be dropped or not depends on the factorisation of the distribution. In
other words, the two assumptions (i.e., _sτ_ _⊥⊥_ _θ_ _|_ _π_ and _sτ_ _⊥⊥_ _θ_ _|_ _π, oτ_ ) would have to be checked using the
d-separation criterion. However, this is difficult to do, since as mentioned previously, the parameters _θ_ are
latent variables in (2) but are regarded as parameters in (5), which makes the graphical model unclear.
Instead of attempting to prove that _sτ_ _⊥⊥_ _θ_ _|_ _π_ and _sτ_ _⊥⊥_ _θ_ _|_ _π, oτ_, we propose an alternative derivation
that does not require such independence assumptions.

**Alternative** **derivation** **of** **the** **second** **term** **of** **Equation** (6)

Restarting from the second term of Equation (6), we can re-arrange as follows:

- ln _Q_ ( _sτ_ _|π_ ) _−_ ln _Q_ ( _sτ_ _|oτ_ _, π_ )

E _Q_ ˜

- ln _Q_ ( _sτ_ _|π_ ) _−_ ln _P_ <sup>˜</sup> ( _sτ_ _|oτ_ _, π_ ) =∆ E _Q_ ˜

- ln _Q_ ( _sτ_ _|oτ_ _, π_ )

= E _Q_ ( _sτ_ _|π_ ) _Q_ ( _θ,oτ_ _|sτ_ _,π_ )

- ln _Q_ ( _sτ_ _|π_ ) _−_ E _Q_ ( _oτ_ _|π_ ) _Q_ ( _sτ_ _|oτ_ _,π_ ) _Q_ ( _θ|sτ_ _,oτ_ _,π_ )

- ln _Q_ ( _sτ_ _|π_ ) _−_ E _Q_ ( _oτ_ _|π_ ) _Q_ ( _sτ_ _|oτ_ _,π_ )

ln _Q_ ( _sτ_ _|π_ )

- ln _Q_ ( _sτ_ _|oτ_ _, π_ )

= E _Q_ ( _sτ_ _|π_ )

= E _Q_ ( _oτ_ _|π_ )

- _H_ [ _Q_ ( _sτ_ _|oτ_ _, π_ )] _−_ _H_ [ _Q_ ( _sτ_ _|π_ )] _,_

_H_ [ _Q_ ( _sτ_ _|oτ_ _, π_ )]

where in the first line a distribution was renamed, i.e., _P_ <sup>˜</sup> ( _sτ_ _|oτ_ _, π_ ) =∆ _Q_ ( _sτ_ _|oτ_ _, π_ ), two different factorizations of _Q_ <sup>˜</sup> are used going from the first to the second line, the linearity of expectations was used between
the first and second line, and the expectation w.r.t _θ_ was dropped (between lines two and three) because
the expectation of a constant is the constant itself. Importantly, the above derivation does not make any
assumption of independence, and leads to a simpler result. This alternative line of reasoning is beneficial
as it produces a stronger derivation that relies upon fewer assumptions. The simpler result produced by
this derivation, also have a practical implication. Indeed, the expectation w.r.t. _Q_ ( _θ|π_ ) disappears and
the expectation w.r.t. _Q_ ( _oτ_ _|θ, π_ ) is now w.r.t. _Q_ ( _oτ_ _|π_ ). Those two changes sugguest that a different
implementation of this term is required.

10

Deconstructing deep active inference.

**Re-arranging** **the** **third** **term** **of** **Equation** (6) **from** **Fountas** **et** **al** **(2020)**

For completeness, we now focus on the third term of (6), which can be re-arranged as follows:

- ln _Q_ ( _θ|sτ_ _, π_ ) _−_ ln _Q_ ( _θ|sτ_ _, oτ_ _, π_ )

E _Q_ ˜

- ln _Q_ ( _θ|sτ_ _, π_ ) _−_ ln _P_ <sup>˜</sup> ( _θ|sτ_ _, oτ_ _, π_ ) =∆ E _Q_ ˜

= E _Q_ ˜

- ln _Q_ ( _oτ_ _|sτ_ _, π_ ) _−_ ln _Q_ ( _oτ_ _|sτ_ _, θ, π_ ) _,_

where _P_ <sup>˜</sup> ( _θ|sτ_ _, oτ_ _, π_ ) was renamed as _Q_ ( _θ|sτ_ _, oτ_ _, π_ ), and Bayes theorem was used to get:

_<u>Q</u>_ <u>(</u> _<u>θ|sτ</u>_ _<u>, π</u>_ <u>)</u> _<u>Q</u>_ <u>(</u> _<u>oτ</u>_ _<u>|sτ</u>_ _<u>, π</u>_ <u>)</u>

_Q_ ( _θ|sτ_ _, π_ ) = <sup>_<u>Q</u>_</sup> <sup><u>(</u></sup> <sup>_<u>θ|sτ</u>_</sup> <sup>_<u>, oτ</u>_</sup> <sup>_<u>, π</u>_</sup> <sup><u>)</u></sup> <sup>_<u>Q</u>_</sup> <sup><u>(</u></sup> <sup>_<u>oτ</u>_</sup> <sup>_<u>|sτ</u>_</sup> <sup>_<u>, π</u>_</sup> <sup><u>)</u></sup> _⇔_

_Q_ ( _oτ_ _|sτ_ _, θ, π_ ) _Q_ ( _θ|sτ_ _, oτ_ _, π_ ) <sup>=</sup> _Q_ ( _oτ_ _|sτ_ _, θ, π_ ) <sup>_._</sup>

Finally, by recalling that _Q_ <sup>˜</sup> = _Q_ ( _oτ_ _, sτ_ _, θ|π_ ) = _Q_ ( _θ|π_ ) _Q_ ( _sτ_ _|θ, π_ ) _Q_ ( _oτ_ _|sτ_ _, θ, π_ ), and using the linearity of
expectation, we get:

- _H_ [ _Q_ ( _oτ_ _|sτ_ _, θ, π_ )]

E _Q_ ˜

- ln _Q_ ( _θ|sτ_ _, π_ ) _−_ ln _Q_ ( _θ|sτ_ _, oτ_ _, π_ ) = E _Q_ ( _oτ_ _,sτ_ _|π_ )

 - 
) ln _Q_ ( _oτ_ _|sτ_ _, π_ ) + E _Q_ ( _θ|π_ ) _Q_ ( _sτ_ _|θ,π_ )

 
) ln _Q_ ( _oτ_ _|sτ_ _, π_ )

- _H_ [ _Q_ ( _oτ_ _|sτ_ _, θ, π_ )]

_H_ [ _Q_ ( _oτ_ _|sτ_ _, θ, π_ )]

= E _Q_ ( _oτ_ _|sτ_ _,π_ ) _Q_ ( _sτ_ _|π_ )

- ln _Q_ ( _oτ_ _|sτ_ _, π_ ) + E _Q_ ( _θ|π_ ) _Q_ ( _sτ_ _|θ,π_ )

ln _Q_ ( _oτ_ _|sτ_ _, π_ )

      
= _−_ E _Q_ ( _sτ_ _|π_ ) _H_

- - <sup>�</sup>
_Q_ ( _oτ_ _|sτ_ _, π_ ) + E _Q_ ( _θ|π_ ) _Q_ ( _sτ_ _|θ,π_ )

- _H_ [ _Q_ ( _oτ_ _|sτ_ _, θ, π_ )] _,_

where because ln _Q_ ( _oτ_ _|sτ_ _, π_ ) is a constant w.r.t _θ_, we have been able to use:

E _Q_ ( _oτ_ _,θ,sτ_ _|π_ )[ln _Q_ ( _oτ_ _|sτ_ _, π_ )] = E _Q_ ( _oτ_ _,sτ_ _|π_ )[ln _Q_ ( _oτ_ _|sτ_ _, π_ )] _._

To sum up, this derivation provides an expression based on the following two entropy terms: _H_ [ _Q_ ( _oτ_ _|sτ_ _, π_ )]
and _H_ [ _Q_ ( _oτ_ _|sτ_ _, θ, π_ )], which the authors claim can be estimated (c.f. Appendix B for more details). Note
that our proposed alternative to the EFE (see below) uses this derivation for the third term of Equation
(6).

**The** **EFE** **from** **Fountas** **et** **al** **(2020)**

If one follows the derivation proposed by Fountas et al (2020), then the EFE is given by:

_Gτ_ ( _π_ ) = _−_ E _Q_ ˜

- ln _P_ <sup>˜</sup> ( _oτ_ _|π_ )�

+ E _Q_ ( _θ|π_ )

E _Q_ ( _oτ_ _|θ,π_ )

- _H_ [ _Q_ ( _sτ_ _|oτ_ _, π_ )]

- _−_ _H_ [ _Q_ ( _sτ_ _|π_ )]

_H_

- - <sup>�</sup>
_Q_ ( _oτ_ _|sτ_ _, π_ ) _._ (8)

+ E _Q_ ( _θ|π_ ) _Q_ ( _sτ_ _|θ,π_ )

- _H_ [ _Q_ ( _oτ_ _|sτ_ _, θ, π_ )] _−_ E _Q_ ( _sτ_ _|π_ )

Note, in Section 2.2, we focused on presenting the approach given in Fountas et al (2020), with some
adjustments for consistency. More details about the implementation of Equation 8 are presented in
Appendix B, along with some discrepancies between the paper and the code.

**Our** **proposed** **alternative** **to** **the** **EFE**

If one follows our alternative derivation, then the EFE is given by:

_Gτ_ ( _π_ ) = _−_ E _Q_ ˜

- ln _P_ <sup>˜</sup> ( _oτ_ _|π_ )�

+ E _Q_ ( _oτ_ _|π_ )

- _H_ [ _Q_ ( _sτ_ _|oτ_ _, π_ )] _−_ _H_ [ _Q_ ( _sτ_ _|π_ )] _,_

_H_

- - <sup>�</sup>
_Q_ ( _oτ_ _|sτ_ _, π_ ) _._

+ E _Q_ ( _θ|π_ ) _Q_ ( _sτ_ _|θ,π_ )

- _H_ [ _Q_ ( _oτ_ _|sτ_ _, θ, π_ )] _−_ E _Q_ ( _sτ_ _|π_ )

Finally, _DAIMC_ does solve the dSprites environment.

11

Champion et al.

**2.3** _DAIV PG_ **agent** **(Millidge,** **2020)**

In this section, we explain and discuss the approach of Millidge (2020). The code is available at the
following URL: `[https://github.com/BerenMillidge/DeepActiveInference](https://github.com/BerenMillidge/DeepActiveInference)` . Note that, though the
mathematics in the paper are based on the formalism of a partially observable Markov decision process
(POMDP), the code does not implement an encoder/decoder architecture, which means that the code
implements a fully observable decision process, i.e., MDP. Additionally, the _DAIV PG_ is composed of three
neural networks, as illustrated in Figures 4 and 5. The first is the transition network that predicts the
future observations based on the current observations and action, i.e., ˚ _oτ_ +1 = _Tθo_ ( _oτ_ _, aτ_ ). The second is
the policy network that models the variational distribution over actions _Qφa_ ( _aτ_ _|oτ_ ). The third is the critic
network that predicts the expected free energy of each action given the current observation. Moreover,
Millidge (2020) defines the prior over actions as follows:

_P_ ( _aτ_ _|oτ_ ) = _σ_ [ _−ζG_ ( _oτ_ _, aτ_ )] _,_

where _ζ_ is the precision of the prior over actions, _σ_ [ <sup>_•_</sup> ] is a softmax function, and _G_ ( _oτ_ _, aτ_ ) is the expected
free energy (EFE) of taking action _aτ_ when observing _oτ_ . In the paper, the mathematics are based on
the POMDP formalism. Therefore, _G_ ( _oτ_ _, aτ_ ) is denoted _G_ ( _sτ_ _, aτ_ ), and is defined as follows:

_G_ ( _sτ_ _, aτ_ ) = _−rτ_ + _D_ KL [ _Q_ ( _sτ_ ) _|| Q_ ( _sτ_ _|oτ_ )]

         - <u>��</u> <u>�</u>
intrinsic value

+ _G_ <sup>ˆ</sup> _θ_ ˆ _a_ ( _aτ_ +1 _, sτ_ +1) _,_ (9)

where _rτ_ is the reward gathered by the agent at time step _τ_, and _G_ <sup>ˆ</sup> _θ_ ˆ _a_ ( _aτ_ +1 _, sτ_ +1) is the target network
(i.e., a copy of the critic network whose weights are synchronised every _K_ iterations of learning). Now,
remember that in the implementation, there is no encoder _Q_ ( _sτ_ ) and no decoder _P_ ( _oτ_ _|sτ_ ). In other
words, there are no hidden states _sτ_, raising some uncertainty about how the intrinsic value is computed. The code available on Github <sup>4</sup> at the following URL: `[https://github.com/BerenMillidge/](https://github.com/BerenMillidge/DeepActiveInference)`
`[DeepActiveInference](https://github.com/BerenMillidge/DeepActiveInference)`, in the file `active_inference_with_Tmodel.jl` (see line 51) suggests that the
following equation is used:

- �2
_oτ_ +1[ _i_ ] _−_ ˚ _oτ_ +1[ _i_ ] _,_ (10)

intrinsic value =

_i_

where _oτ_ +1[ _i_ ] is the i-th observation received at time step _τ_ + 1, and ˚ _oτ_ +1[ _i_ ] is the (numerical) value of
the i-th observation (at time step _τ_ + 1) predicted by the transition network. More formally, the above
formulation for the intrisic value corresponds to the KL-divergence between two Gaussian distributions
both having an identity covariance matrix, i.e.,

- �2
_oτ_ +1[ _i_ ] _−_ ˚ _oτ_ +1[ _i_ ] _,_

intrinsic value = _D_ KL [ _Q_ ( _oτ_ +1) _|| P_ ( _oτ_ +1 _|oτ_ _, aτ_ )] =

_i_

where _P_ ( _oτ_ +1 _|oτ_ _, aτ_ ) = _N_ ( _oτ_ +1;˚ _oτ_ +1 _, I_ ) and _Q_ ( _oτ_ +1) is a Gaussian distribution with mean vector _oτ_ +1
and an identity covariance matrix. However, note that (9) is the definition of the expected free energy in
the POMDP setting. As explained by Costa et al (2020b), the expected free energy in the MDP setting
is given by:

_G_ ( _at_ : _T_ _−_ 1 _, ot_ ) _≈_

_T_

_τ_ = _t_ +1

_D_ KL [ _P_ ( _oτ_ _|at_ : _T_ _−_ 1 _, ot_ ) _|| P_ ( _oτ_ )] _,_

4. We are referring to the version of the code that was available on github on the 6th of June 2022.

12

Deconstructing deep active inference.

where _P_ ( _oτ_ ) are the prior preferences of the agent (related to rewards in reinforcement learning), and
_P_ ( _oτ_ _|at_ : _T_ _−_ 1 _, ot_ ) is the transition mapping. Importantly, this definition for the expected free energy does
not decompose into extrinsic and intrinsic terms as in (9). Thus, (as it stands) the implementation of
the _DAIV PG_ agent is a mixture between the POMDP and MDP setting, where the generative model
corresponds to an MDP, and the expected free energy is adapted from the POMDP setting.

We conclude this section by dicussing the training procedure of the transition, policy and critic networks. As explained in the paper, the transition network is trained to minimise the variational free enery.
Additionally, because of the Gaussian assumptions (with identity covariance matrices) mentioned above,
the KL-divergence reduces to the mean square error (MSE). Thus, the transition network is updated to
minimise the MSE between the observations made by the agent at time _τ_ +1, and the observations (˚ _oτ_ +1)
predicted by the transition network, i.e.,

_θo_ <sup>_∗_</sup>

_o_ <sup>_∗_</sup> <sup>= arg min</sup>

   
MSE _oτ_ +1 _,_ ˚ _oτ_ +1

_,_

_θo_

where ˚ _oτ_ +1 = _Tθo_ ( _oτ_ _, aτ_ ). The policy network is trained to minimise the KL-divergence between the
variational posterior over actions _Qφa_ ( _aτ_ _|oτ_ ) and the prior over actions _P_ ( _aτ_ _|oτ_ ), i.e.,

_φ_ <sup>_∗_</sup> _a_

<sup>_∗_</sup> _a_ <sup>= arg min</sup>

_D_ KL [ _Qφa_ ( _aτ_ _|oτ_ ) _|| P_ ( _aτ_ _|oτ_ )] _,_

_φa_

which minimises the variational free energy. Finally, the critic is trained by minimising the MSE between
the target EFE as defined in (9) and the ouput of the critic _Gθa_ ( _oτ_ _,_ <sup>_•_</sup> ):

_θa_ <sup>_∗_</sup>

_a_ <sup>_∗_</sup> <sup>= arg min</sup>

MSE

_G_ ( _oτ_ _,_ <sup>_•_</sup> ) _, Gθa_ ( _oτ_ _,_ <sup>_•_</sup> )

_._

_θa_

_DAIV PG_ is able to solve the CartPole environment.

_Tθo_ ( _oτ_ _, aτ_ )

**input:** #O + #A

_Qφa_ ( _aτ_ _|oτ_ )

**input:** #O

_Gθa_ ( _oτ_ _,_ <sup>_•_</sup> )

**input:** #O

There is no encoder

**_Q_** **(** **_sτ_** **)**, and no
decoder **_P_** **(** **_oτ_** **_|sτ_** **)** .

Figure 4: Neural networks architecture of the _DAIV PG_ agent. Green blocks correspond to fully connected
layers. The first neural network is the transition network that takes as input the observation and action
at time step _τ_, and outputs the mean of a Gaussian distribution over observation at time step _τ_ + 1. The
second neural network is the policy network that models the variational posterior over actions. The third
neural network is the critic that takes as input an observation and outputs the expected free energy of
each action.

13

Champion et al.

Figure 5: This figure illustrates the _DAIV PG_ agent. The only new part is the policy network, which takes
as input the hidden state at time _t_ and ouputs the parameters _π_ ˆ of the variational posterior over actions.
Importantly, the _DAIV PG_ takes actions based on the EFE.

**2.4** _DAIRHI_ **agent** **(Rood** **et** **al,** **2020)**

In this section, we explain and discuss the approach of Rood et al (2020). Put simply, this paper proposes
a variational auto-encoder (VAE), which is able to account for results that were observed in the context of
the rubber-hand illusion (RHI) experiment. In the experiment in Rood et al (2020), an agent (i.e., either
a human or a computer) is able to move an arm in a 3D space. However, the agent does not observe the
real position of the arm, instead, the agent sees an artificial hand placed in a different location. This can
be implemented using virtual reality (for humans) or within a simulator (for computers). Since, Rood
et al (2020) restricted themself to the context of a VAE, this approach cannot be considered as a complete
implementation of deep active inference. More precisely, the transition and critic (or policy) networks are
missing.

**2.5** _DAIHR_ **agent** **(Sancaktar** **et** **al,** **2020;** **Lanillos** **et** **al,** **2020;** **Oliver** **et** **al,** **2019)**

In this section, we explain and discuss the following approaches: Sancaktar et al (2020), Lanillos et al
(2020), and Oliver et al (2019). Briefly, those papers propose a free energy minimisation scheme based
on a single decoder network, which is used to control Nao, TIAGo, and iCub robots, respectively. Since,

14

Deconstructing deep active inference.

Sancaktar et al (2020); Lanillos et al (2020); Oliver et al (2019) restricted themself to the context of a
single decoder, this approach can not be considered as a complete implementation of deep active inference.
More precisely, the encoder, transition and critic (or policy) networks are missing.

**2.6** _DAIFA_ **agent** **(Ueltzh¨offer,** **2018)**

In this section, we review the approach proposed by Ueltzh¨offer (2018). The original code of this paper is available on GitHub at the following URL: `[https://github.com/kaiu85/deepAI_paper](https://github.com/kaiu85/deepAI_paper)` . This
approach is composed of four deep neural networks. The encoder _Eφs_ models the approximate posterior over states _Qφs_ ( _st|st−_ 1 _, ot_ ) as a Gaussian distribution, i.e., _Qφs_ ( _st|st−_ 1 _, ot_ ) = _N_ ( _st_ ; _µ, σ_ ) where
_µ, σ_ = _Eφs_ ( _st−_ 1 _, ot_ ). The decoder _Dθo_ models the likelihood mapping _Pθo_ ( _oτ_ _|sτ_ ) as a Gaussian distribution,
i.e., _Pθo_ ( _oτ_ _|sτ_ ) = _N_ ( _oτ_ ; _µo, σo_ ) where _µo, σo_ = _Dθo_ ( _sτ_ ). The transition network _Tθs_ models the transition
mapping _Pθs_ ( _sτ_ _|sτ_ _−_ 1) as a Gaussian distribution, i.e., _Pθs_ ( _sτ_ _|sτ_ _−_ 1) = _N_ ( _sτ_ ;˚ _µ,_ ˚ _σ_ ) where ˚ _µ,_ ˚ _σ_ = _Tθs_ ( _sτ_ _−_ 1).
Note that, the transition network is only conditioned on the previous state. This is because the action
is contained in the observations predicted by the decoder. More precisely, the experiments were run in
the MountainCar environment, which means that the agent is observing the x position of the car _o_ <sup>_x_</sup> _τ_ <sup>.</sup>

Additionally, according to the idea of proprioception, the agent observes its own action, i.e., _o_ <sup>_a_</sup> _τ_ _−_ 1 <sup>=</sup> <sup>_aτ_</sup> <sup>_−_</sup> <sup>1</sup>

where _aτ_ _−_ 1 is the action performed by the agent at time _τ_ _−_ 1. In what follows, we let _oτ_ = ( _o_ <sup>_x_</sup> _τ_ <sup>_, oa_</sup> _τ_ _−_ 1 <sup>)</sup> <sup>be</sup>

<sup>_x_</sup> _τ_ <sup>_, oa_</sup> _τ_

where _aτ_ _−_ 1 is the action performed by the agent at time _τ_ _−_ 1. In what follows, we let _oτ_ = ( _o_ <sup>_x_</sup> _τ_ <sup>_, oa_</sup> _τ_ _−_ 1 <sup>)</sup> <sup>be</sup>

the concatenation of the x position of the car and the action taken by the agent. Importantly, because
_oτ_ contains _o_ <sup>_a_</sup> _τ_ _−_ 1 <sup>,</sup> <sup>the</sup> <sup>latent</sup> <sup>space</sup> <sup>has</sup> <sup>to</sup> <sup>(implicitly)</sup> <sup>encode</sup> <sup>the</sup> <sup>action</sup> <sup>for</sup> <sup>the</sup> <sup>decoder</sup> <sup>to</sup> <sup>successfully</sup>

_oτ_ contains _o_ <sup>_a_</sup> _τ_ _−_ 1 <sup>,</sup> <sup>the</sup> <sup>latent</sup> <sup>space</sup> <sup>has</sup> <sup>to</sup> <sup>(implicitly)</sup> <sup>encode</sup> <sup>the</sup> <sup>action</sup> <sup>for</sup> <sup>the</sup> <sup>decoder</sup> <sup>to</sup> <sup>successfully</sup>

predict the observations. Finally, the policy network _Pθa_ models the prior over actions _Pθa_ ( _aτ_ _|sτ_ ) as a
Gaussian distribution, i.e., _Pθa_ ( _aτ_ _|sτ_ ) = _N_ ( _aτ_ ; _µa, σa_ ) where _µa, σa_ = _Pθa_ ( _sτ_ ). Figure 6 illustrates the
architectures of those deep neural networks. Then, Ueltzh¨offer (2018) defines the free action objective as
the cumulated variational free energy over time:

accuracy

<u>�</u> �� <u>�</u>

<u>�</u> <u>�</u>

_−_ E _Qφs_ ( _sτ_ _|sτ_ _−_ 1 _,oτ_ ) ln _Pθo_ ( _oτ_ _|sτ_ )

complexity

<u>�</u> �� <u>�</u>

<u>�</u> <u>�</u> <u>�</u> <u>��</u>        
_−_ E _Qφs_ ( _sτ_ _|sτ_ _−_ 1 _,oτ_ ) ln _Pθo_ ( _oτ_ _|sτ_ ) + _D_ KL [ _Qφs_ ( _sτ_ _|sτ_ _−_ 1 _, oτ_ ) _|| Pθs_ ( _sτ_ _|sτ_ _−_ 1)]

<u>�</u> �� VFE _τ_

_FA_ ( _o_ 1: _T, φ, θ_ ) =

_T_

_τ_ =1

<u>�</u>
ln _Pθo_ ( _oτ_ _|sτ_ )

<u>�</u>
+

_,_

where _s_ 0 = (0 _, ...,_ 0) is a vector of zeros representing the initial hidden state, _T_ is the time horizon,
_Pθo_ ( _oτ_ _|sτ_ ), _Qφs_ ( _sτ_ _|sτ_ _−_ 1 _, ot_ ), _Pθs_ ( _sτ_ _|sτ_ _−_ 1) are modeled using Gaussian distributions whose parameters
are predicted by the decoder, encoder and transition network, respectively. Figure 7 illustrates the
computation of the free action objective, and the action-perception cycle of the agent. The first actionperception cycle is initiated when the intital hidden state _s_ 0 is being fed into the policy network, which
outputs the parameters of a Gaussian distribution over actions. Then, an action _a_ ˆ0 is sampled from
this Gaussian, and executed in the environment leading to a new observation _o_ <sup>_x_</sup> 1 <sup>.</sup> <sup>Next,</sup> <sup>the</sup> <sup>action</sup> <sup>_a_</sup> <sup>ˆ0</sup> <sup>is</sup>

concatenated with _o_ <sup>_x_</sup> 1 <sup>to</sup> <sup>form</sup> <sup>_o_</sup> <sup>1.</sup> <sup>The</sup> <sup>observation</sup> <sup>_o_</sup> <sup>1</sup> <sup>and</sup> <sup>the</sup> <sup>state</sup> <sup>_s_</sup> <sup>0</sup> <sup>are</sup> <sup>then</sup> <sup>fed</sup> <sup>into</sup> <sup>the</sup> <sup>encoder</sup> <sup>that</sup>

outputs the parameters of a Gaussian distribution over _s_ ˆ1. Lastly, a state is sampled from this Gaussian
distribution and is used as input to the next action-perception cycle. This process continues until reaching
the time horizon.

Within each action-perception cycle, the variational free energy of this time step is computed. To
compute VFE _τ_, the state _sτ_ is fed into both the tansition network and the encoder. Both networks
output the parameters of a Gaussian distribution over _sτ_ +1. A state is sampled from the distribution
predicted by the encoder, and is used as input to the decoder that outputs the parameters of a Gaussian
distribution over _oτ_ +1. Finally, the parameters of the Gaussian distribution over _oτ_ +1 is used to compute
the accuracy term, and the parameters of the two Gaussian distributions over _sτ_ +1 are used to compute
the complexity term.

We now focus on the prior preferences of the agent. Usually, prior preferences are part of the expected
free energy. However, Ueltzh¨offer (2018) takes a different approach. Recall, the latent variable _sτ_ is

15

Champion et al.

modeled using a multivariate Gaussian. The _DAIFA_ agent reserves the first dimension of the latent space
to the encoding of the prior preferences. Specifically, the transition network predicts the mean vector and
the diagonal of the covariance matrix (i.e., another vector) of a multivariate Gaussian over latent states.
The first element in the mean vector is clamped to the target x position, and the first element of the
variance vector is set to a relatively small value. This effectively propels the agent towards the target
location. Additionally, the encoder predicts another set of mean and variance vectors. The first element
of the mean vector predicted by the encoder is clamped to the current x position observed by the agent,
and the first element of the variance vector is set to a relatively small value. Note, clamping the value of
the first element of the mean and variance vectors predicted by the transition is uncontentious, i.e., this is
simply how the generative model is defined. However, clamping the value of the first element of the mean
and variance vectors predicted by the encoder may be debated. Specifically, the encoder is supposed to
predict the variational distribution, which is an approximation of the true posterior. However, clamping
the value of the first element of the mean and variance vectors predicted by the encoder is likely to push
the variational posterior further from the true posterior.

_Qφs_ ( _st|ot, st−_ 1)

**input:** #O + #S

_Pθo_ ( _oτ_ _|sτ_ )

**input:** #S

_Pθs_ ( _sτ_ _|sτ_ _−_ 1)

**input:** #S

**size:** #S + #S

_Pθa_ ( _aτ_ _|sτ_ )

**input:** #S

Figure 6: Neural networks architecture of the _DAIFA_ agent. Green blocks correspond to fully connected
layers. The first neural network is the encoder that takes as input the state at time _t_ _−_ 1 and the
observation at time _t_, and outputs the parameters of a distribution over the state at time _t_ . The second
neural network is the decoder that takes as input the state at time _τ_, and outputs the parameters of a
distribution over the observation at time _τ_ . The third is the transition network that takes as input the
state at time step _τ_ _−_ 1, and outputs the parameters of a distribution over the state at time step _τ_ . The
fourth neural network is the policy network that models the prior over actions, i.e., the policy takes as
input a state at time _τ_ and outputs the parameters of a distribution over the actions at time step _τ_ .
Finally, THS stands for tangent hyperbolic and softplus, i.e., the tangent hyperbolic activation is over
the first half of the neurons and the softplus activation function is over the second half, and LS stands
for linear activation function and softplus, i.e., the linear activation is over the first half of the neurons
and the softplus activation function is over the second half.

There are a number of important aspects of the _DAIFA_ agent. First, there is no expected free energy,
instead the agent is trained to minimise the cumulated variational free energy over time. Second, this
approach unrolls the partially observable Markov decision process over time. In other words, the code
builds a huge computational graph containing the encoder, decoder, transition and policy networks for
each action-perception cycle. Therefore, the approach is computationally intensive and can become in

16

Deconstructing deep active inference.

tractable for a large time horizon. Third, the _DAIFA_ requires the modeller to encode the prior preferences
within the distributions predicted by the encoder and transition network. This can limit the applicability
of the approach. Indeed, as previously explained, one can encode the prior preferences of the agent for
the MountainCar problem within the first dimension of the latent space.

However, manually encoding the prior preferences in the latent space has two major drawbacks. First,
the model needs to be modified from one environment to the next. This is because for each environment,
the prior preferences of the agent will be different. Second, for some environments, it is unclear how the
prior preferences may be defined. For example, when playing PacMan, the agent needs to eat all the dots,
while simultaneously avoiding the ghosts. How can this be encoded in the model’s latent space? This is
particularly challenging because the only observation made by the agent is an image of the game, i.e., the
agent does not directly have access to the positions of PacMan and the ghosts.

Figure 7: Action-perception cycles (in black) and estimation of the free action objective (in red). Note,
˚ _µ_, ˚ _σ_, _µ_ ˆ and _σ_ ˆ are used to compute the complexity terms of the variational free energy, while _µo_ and _σo_

are used to compute the accuracy term of the variational free energy.

**2.7** _DAIPOMDP_ **agent** **(van** **der** **Himst** **and** **Lanillos,** **2020)**

In this section, we review the approach proposed by van der Himst and Lanillos (2020). The code is available here: `[https://github.com/Grottoh/Deep-Active-Inference-for-Partially-Observable-MDPs](https://github.com/Grottoh/Deep-Active-Inference-for-Partially-Observable-MDPs)` .
The _DAIPOMDP_ agent is composed of five deep neural networks.

The decoder _Dθo_ models _Pθo_ ( _oτ_ _|sτ_ ) as a product of Bernoulli distributions, therefore: _Pθo_ ( _oτ_ _|sτ_ ) =
_B_ ernoulli( _oτ_ ; ˆ _oτ_ ) where _o_ ˆ _τ_ = _Dθo_ ( _sτ_ ). The transition network _Tθs_ models _Pθs_ ( _sτ_ +1 _|sτ_ _, aτ_ ) as a Gaussian
distribution, i.e., _Pθs_ ( _sτ_ +1 _|sτ_ _, aτ_ ) = _N_ ( _sτ_ +1 _|_ ˚ _µ,_ ˚ _σ_ ) where ˚ _µ,_ ln˚ _σ_ = _Tθs_ ( _sτ_ _, aτ_ ). The critic _Gθa_ outputs a
vector containing the predicted expected free energy of each action, which is used to define the prior over
action as _Pθa_ ( _aτ_ _|sτ_ ) = _σ_ [ _−ζGθa_ ( _sτ_ _,_ <sup>_•_</sup> )], where _σ_ [ <sup>_•_</sup> ] is a softmax function, _ζ_ is the precision of the prior over
actions, and _Gθa_ ( _sτ_ _,_ <sup>_•_</sup> ) is the expected free energy of each action as predicted by the critic network when
state _sτ_ is provided as input. The variational posterior over states _Qφs_ ( _st_ ) is a Gaussian distribution
modelled by the encoder _Eφs_, i.e., _Qφs_ ( _st_ ) = _N_ ( _st_ ; _µ, σ_ ) where _µ,_ ln _σ_ = _Eφs_ ( _ot_ ). The variational posterior
over actions _Qφa_ ( _at|st_ ) is a categorical distribution modelled by the policy network _Pφa_, i.e., _Qφa_ ( _at|st_ ) =
Cat( _at_ ; ˆ _π_ ) where _π_ ˆ = _Pφa_ ( _st_ ). Then, the agent is supposed to minimise the variational free energy defined

17

as follows:

_Q_ <sup>_∗_</sup> _φ_ <sup>(</sup> <sup>_st, at_</sup> <sup>) = arg min</sup>

_Qφ_ ( _st,at_ )

= arg min

_Qφ_ ( _st,at_ )

Champion et al.

_D_ KL [ _Qφa_ ( _at|st_ ) _Qφs_ ( _st_ ) _|| Pθo_ ( _ot|st_ ) _Pθs_ ( _st|st−_ 1 _, at−_ 1) _Pθa_ ( _at|st_ )]

_D_ KL [ _Qφs_ ( _st_ ) _|| Pθs_ ( _st|st−_ 1 _, at−_ 1)] + _D_ KL [ _Qφa_ ( _at|st_ ) _|| Pθa_ ( _at|st_ )] _−_ E _Qφs_ ( _st_ )[ln _Pθo_ ( _ot|st_ )] _._

However, as explained in the paper, the KL-divergence (over states) is replaced by the mean square error
(MSE) as follows:

_Q_ <sup>_∗_</sup> _φ_ <sup>(</sup> <sup>_st, at_</sup> <sup>) = arg min</sup>

_Qφ_ ( _st,at_ )

MSE( _µ,_ ˚ _µ_ ) + _D_ KL [ _Qφa_ ( _at|st_ ) _|| Pθa_ ( _at|st_ )] _−_ E _Qφs_ ( _st_ )[ln _Pθo_ ( _ot|st_ )] _,_

where _µ_ and ˚ _µ_ are the mean vectors predicted by the encoder and the transition network, respectively.
The paper justifies this substitution by saying that the maximum a posteriori (MAP) estimate is used to
compute the state prediction error, instead of using the KL-divergence over the densities. However, the
state prediction error and the KL-divergence over states are two different quantities, which are only equal
when the two densities over states are Gaussian distributions with identity covariance matrix. However,
the distribution predicted by the encoder network does not have an identity covariance matrix.

Put simply, in this context, the MSE and the KL-divergence between the densities over state are not
necessarily equivalent. As a result, the _DAIPOMDP_ agent may not always follow the free energy principle.

**2.8** _DAISSM_ **agent** **(van** **der** **Himst** **and** **Lanillos,** **2020)**

The deep active inference agent proposed by (C¸atal et al, 2020) is based on a state space model, and is
therefore called _DAISSM_ . The code of this approach was not available online, but we were able to retrieve
it from the authors. Importantly, _DAISSM_ is an offline approach meaning that the model is trained first
on a fixed dataset gathered either by taking random actions in the environment or by manually controlling
the robot. Then, when the model is trained, the expected free energy of different sequences of actions
can be estimated using imaginary rollouts, and the first action of the policy with the lowest expected free
energy is executed in the environment.

**2.9** **Active** **exploration** **for** **robotic** **manipulation** **(Schneider** **et** **al,** **2022)**

The last paper that we review (Schneider et al, 2022) is motivated from a reinforcement learning perspective, where the agent aims to maximise reward. However, instead of greedily maximising reward, the
agent also maximises the information gain between the model parameters and the expected states and
rewards, i.e.,

+ _β_ E _P_ ( **_s_** _,_ **_r_** _|π,st_ )

- _,_ where: _f_ ( **_r_** ) =

_t_ + _H_

_τ_ = _t_ +1

_rτ_ (11)

max

- _D_ KL [ _P_ ( _θ|_ **_s_** _,_ **_r_** _, π, st_ ) _|| P_ ( _θ_ )]

E _P_ ( **_r_** _|π_ )
_π_

- _f_ ( **_r_** )�

- <u>��</u> <u>�</u>
Expected reward

<u>�</u> <u>��</u> <u>�</u>
Information gain

where _t_ is the current time step, _H_ is the time horizon of planning, _π_ is the agent policy, _θ_ are the
parameters of the model, **_r_** = **_r_** _t_ +1: _t_ + _H_ is the sequence of rewards between time step _t_ + 1 and _t_ + _H_,
**_s_** = **_s_** _t_ +1: _t_ + _H_ is the sequence of states between time step _t_ + 1 and _t_ + _H_, and _β_ is a hyper-parameter
modulating the impact of information gain. Note, the distribution over the sequence of rewards **_r_** obtained
by the agent when behaving according to a policy _π_, i.e., _P_ ( **_r_** _|π_ ), is not deterministic. Indeed, the same
policy can produce different trajectories of states as the transition mapping is stochastic, and those
different states can produce different rewards. Notice, the expectation w.r.t _P_ ( **_r_** _|π_ ) is iterating over all
possible sequences of rewards, and passing each sequence to _f_ ( **_r_** ). Then, the authors demonstrate the
relationship between Equation 11 and the expected free energy. This relationship is explained in more
details in (Schneider, N.D.), and relies on the the following assumptions:

18

Deconstructing deep active inference.

1. the states _sτ_ and rewards _rτ_ are latent variables for all _τ_ _∈{t_ + 1 _, ..., t_ + _H}_

2. the generative model contains observed variables for states _o_ <sup>_s_</sup> _τ_ <sup>and</sup> <sup>rewards</sup> <sup>_o_</sup> _τ_ <sup>_r_</sup>

3. the likelihood mappings, i.e., _P_ ( _o_ <sup>_r_</sup> _τ_ <sup>_|rτ_</sup> <sup>)</sup> <sup>and</sup> <sup>_P_</sup> <sup>(</sup> <sup>_os_</sup> _τ_ <sup>_|sτ_</sup> <sup>),</sup> <sup>are</sup> <sup>delta</sup> <sup>distributions</sup> <sup>which</sup> <sup>effectively</sup> <sup>make</sup>

the latent variables fully observable, except for the model parameters _θ_ that are distributed according
to a delta distribution at time step zero and remain fixed over time

4. the variance of the transition mapping _P_ ( _sτ_ +1 _|sτ_ _, aτ_ _, θ_ ) does not depend on the parameters _θ_,
e.g., _P_ ( _sτ_ +1 _|sτ_ _, aτ_ _, θ_ ) = _N_ ( _sτ_ +1; **_µ_** _,_ **_σ_** ) where **_µ_** = _fθ_ ( _sτ_ _, aτ_ ) is predicted by a neural network with
parameters _θ_, and **_σ_** = _σI_ is a diagonal matrix whose diagonal elements are equal to _σ_ .

Importantly, while the above assumptions allow the authors to derive the expected free energy from
Equation 11, these assumptions also impose a lot of constraints on the model. For example, the proof
does not hold if the likelihood mappings are not delta distributions. In this paper, we focus on such
models. To conclude, this approach is a great contribution to reinforcement learning applied to robotic
control, but cannot be considered as a complete deep active inference agent. The code of this approach
is available at the following URL: `[https://github.com/TimSchneider42/aerm](https://github.com/TimSchneider42/aerm)` .

**2.10** **Representational** **similarity** **with** **centered** **kernel** **alignment**

The goal of representational similarity metrics is, as its name indicates, to measure the similarity between
two representations. In the context of deep learning, these representations correspond to R <sup>_n×p_</sup> matrices
of activations, where _n_ is the number of data examples and _p_ the number of neurons in a layer. In this
paper, we aim to use such metrics to compare the representations learned by the deep learning models
described in Section 3 and the representations learned by a DQN.

For our analysis, we will use Centred Kernel Alignment (CKA) (Cortes et al, 2012; Cristianini et al,
2002), a normalised version of the Hillbert-Schmidt Independence Criterion (HSIC) (Gretton et al, 2005),
which measures the alignment between the _n_ _×_ _n_ kernel matrices of two representations. Kornblith
et al (2019) have shown that for deep learning applications, linear kernels with centred layer activations
worked well. We thus focus on the linear CKA, also known as RV-coefficient (Robert and Escoufier, 1976).
Moreover, it has been shown to provide results similar to other representational similarity metrics, while
being faster to compute (Bonheme and Grzes, 2022).

For conciseness, we will refer to linear CKA as CKA in the rest of this paper. We now define CKA
more formally. Given the centered layer activations _x ∈_ R <sup>_n×m_</sup> and _y_ _∈_ R <sup>_n×p_</sup> taken over _n_ data examples,
CKA is defined as:

_CKA_ ( _x, y_ ) = _<u>∥y</u>_ <sup>_T_</sup> _<u>x∥</u>_ <sup>2</sup> _<u>F</u>_

_<u>F</u>_
_∥x_ <sup>_T_</sup> _x∥F ∥y_ <sup>_T_</sup> _y∥F_

_,_

where _∥·∥F_ is the Frobenius norm, which is defined as:

_l_

_j_ =1

~~�~~

<u>�</u> _k_
��

_i_ =1

_|aij|_ <sup>2</sup> _,_

_∥a∥F_ =

tr( _aa_ <sup>_T_</sup> ) =

where _a ∈_ R <sup>_k×l_</sup> is an arbitrary _k × l_ matrix, and _a_ <sup>_T_</sup> is the transpose of _a_ .

**Limitations** **of** **CKA** While CKA leads to accurate results in practice, it can be overly sensitive to
differences in neural architectures (Maheswaranathan et al, 2019), and can thus underestimate the similarity between activations coming from layers of different type (e.g., convolutional and deconvolutional).
Thus, we will only discuss the variation of similarity when analysing such cases. For example, we will not
compare _CKA_ ( _a, b_ ) and _CKA_ ( _a, c_ ) if _a_ and _b_ are convolutional layers but _c_ is linear. We will, however,
compare _CKA_ ( _a, c_ ) and _CKA_ ( _b, c_ ).

19

Champion et al.

**3.** **Incrementally** **building** **a** **deep** **active** **inference** **agent**

All of the deep active inference models we have presented make important contributions, illustrating a
range of possible implementations. However, we do not feel that any of these approaches is a complete
and definitive realisation of deep active inference. We have highlighted limitations of these published
approaches throughout our presentation. Accordingly, in the remainder of this paper, we step back
to first principles and “build up” an agent component-by-component to determine which parts of a
“natural” deep active inference framework underlie its capacity to solve or fail to solve inference problems.
Additionally, throughout this component-by-component investigation, we compare the different variants
of deep active inference that result with a standard (well-attested) approach: a deep Q-network (Mnih
et al, 2013). Thus, in this section, we progresively build a deep active inference agent. Section 3.1 presents
the dSprites environment in which all our simulations will be run. This environment was picked to test
whether an active inference agent is able to solved the dSprites problem, as explored in (Fountas et al,
2020). Section 3.2 describes how the agents introduced later in this paper interact with the environment.
Then, Section 3.3 introduces a variational auto-encoder (VAE) agent, Section 3.4 discusses a deep hidden
Markov model (HMM) agent, Section 3.5 presents a deep critical HMM (CHMM) agent, and finally,
Section 3.6 introduces a complete deep active inference agent. Note, the notation used throughout this
section are summarised in Appendix A.

**3.1** **dSprites** **environment**

The dSprites environment is based on the dSprites dataset (Matthey et al, 2017), initially designed for
analysing the latent representation learned by variational auto-encoders (Doersch, 2016). The dSprites
dataset is composed of images of squares, ellipses and hearts. Each image contains one shape (square,
ellipse or heart) with its own scale, orientation, and ( _X, Y_ ) position. In the dSprites environment, the
agent is able to move those shapes around by performing four actions (i.e., UP, DOWN, LEFT, RIGHT).
To make the task tractable, the action selected by the agent is executed eight times in the environment
before the beginning of the next action-perception cycle, i.e., the _X_ or _Y_ position is increased or decreased
by eight between time step _t_ and _t_ +1. The goal of the agent is to move all squares towards the bottom-left
corner of the image and all ellipses and hearts towards the bottom-right corner of the image, c.f. Figure
8.

Figure 8: This figure illustrates the dSprites environment, in which the agent must move all squares
towards the bottom-left corner of the image and all ellipses and hearts towards the bottom-right corner
of the image. The red arrows show the behaviour expected from the agent.

20

Deconstructing deep active inference.

**3.2** **Agent-environment** **interaction**

In this section, we present how all the agents introduced in the next sections interact with the environment.
Each agent was trained for _N_ = 500 _K_ iterations. At the begining of a trial, the environment is reset to
a random state and the agent receives an observation <sup>5</sup> _ot_ . Using _ot_, the agent selects an action _at_, which
is then executed in the environment. This leads the agent to receive a new obervation _ot_ +1, a reward
_rt_ +1 and a boolean _done_ describing whether the trial is over or not. Then, the new experience ( _ot_, _at_,
_ot_ +1, _rt_ +1, _done_ ) is added to the replay buffer, from which a batch is sampled to train the various neural
networks of the agent. Finally, if the trial has ended, then the environment is reset to a random state
leading to a new observation _ot_, otherwise _ot_ +1 becomes the new _ot_ closing the action-perception cycle.
Algorithm 1 summarises the agent-environment interaction.

**<u>Algorithm</u>** **<u>1:</u>** <u>The</u> <u>interaction</u> <u>between</u> <u>the</u> <u>agent</u> <u>and</u> <u>the</u> <u>environment.</u>

**Input:** _env_ the environment,

_agent_ the agent,
_buffer_ the replay buffer,
_N_ the number of training iterations.
space
_ot_ = env.reset() `//` `Get` `the` `initial` `observation` `from` `environment`
**repeat** _N_ **times**

_at_ _←_ select ~~a~~ ction( _ot_ ) `//` `Select` `an` `action`
_ot_ +1 _, rt_ +1 _, done ←_ env.execute( _at_ ) `//` `Execute` `the` `action` `in` `the` `environment`
buffer.push ~~n~~ ew ~~e~~ xperience( _ot_, _at_, _ot_ +1, _rt_ +1, _done_ ) `//` `Add` `the` `experience` `to` `the`
```
    replay buffer
```

agent.learn(buffer) `//` `Perform` `one` `iteration` `of` `training`
**if** _done_ _==_ _True_ **then**

_ot_ _←_ env.reset() `//` `Reset` `the` `environment` `when` `a` `trial` `ends`
**else**

_ot_ _←_ _ot_ +1
**end**

**end**

**3.3** **Variational** **auto-encoder**

In this section, we present our first agent based on a variational auto-encoder. The agent is composed of
two deep neural networks, i.e., an encoder and a decoder. The encoder _Eφs_ takes as input an image _ot_
and outputs the parameters of the variational posterior _Qφs_ ( _st_ ) = _N_ ( _st_ ; _µ, σ_ ), where _µ_ is the mean vector
of the Gaussian distribution, and _σ_ are the diagonal elements of the covariance matrix. The decoder _Dθo_
models the likelihood mapping _Pθo_ ( _ot|st_ ), which attributes a probability to each image _ot_ given a state
_st_, and is defined as:

_Pθo_ ( _ot|st_ ) = _B_ ernoulli( _ot_ ; ˆ _ot_ ) _,_

where _o_ ˆ _t_ = _Dθo_ ( _st_ ) are the values predicted by the decoder, and _B_ ernoulli( _ot_ ; ˆ _ot_ ) is a product of Bernoulli
distributions defined as:

_B_ ernoulli( _ot_ ; ˆ _ot_ ) =

_x,y_

Bernoulli( _ot_ [ _x, y_ ]; ˆ _ot_ [ _x, y_ ]) _,_

where Bernoulli( <sup>_•_</sup> ; <sup>_•_</sup> ) is a Bernoulli distribution over the possible values of the pixel _ot_ [ _x, y_ ], parameterized
by the parameter _o_ ˆ _t_ [ _x, y_ ], which is predicted by the decoder network. The goal of the agent is to minimise

5. Each observation contains a sequence of three images, i.e., the image corresponding to the current state of the environment,
and the two images gathered during the previous two time steps.

21

Champion et al.

the variational free energy (VFE):

**_F_** = _D_ KL [ _Qφs_ ( _st_ ) _|| Pθo_ ( _ot, st_ )] = _D_ KL [ _Qφs_ ( _st_ ) _|| Pθo_ ( _ot|st_ ) _P_ ( _st_ )] _,_

where _P_ ( _st_ ) = _N_ ( _st_ ; 0 _, I_ ) is an isotropic (multivariate) Gaussian with variance one. The VFE can be
re-arranged as follows:

**_F_** = _D_ KL [ _Qφs_ ( _st_ ) _|| P_ ( _st_ )] _−_ E _Qφs_ ( _st_ )[ln _Pθo_ ( _ot|st_ )] _,_

where the KL-divergence between two Gaussian distributions can be computed using an analytical solution, and the expectation of the logarithm of _Pθo_ ( _ot|st_ ) is approximated by a Monte-Carlo estimate using
a single sample _s_ ˆ _t_ _∼_ _Qφs_ ( _st_ ). The sample _s_ ˆ _t_ is obtained using the reparameterisation trick as follows:
_s_ ˆ _t_ = _µ_ + _σ ⊙_ _ϵ_ ˆ, where _⊙_ is an element-wise product between two vectors, and _ϵ_ ˆ _∼N_ ( _ϵ_ ; 0 _, I_ ).

To sum up, this agent takes random actions, and stores its experiences in a replay buffer (c.f. Section
3.2). Then, batches of experiences ( _ot_, _at_, _ot_ +1, _rt_ +1, _done_ ) are sampled from the replay buffer. The
observations at time step _t_ are then fed into the encoder, which outputs the mean and log variance of
a Gaussian distribution _Qφs_ ( _st_ ) = _N_ ( _st_ ; _µ, σ_ ). A latent state is sampled from _Qφs_ ( _st_ ) using the reparameterisation trick, and is then provided as input to the decoder which outputs the parameters of
Bernoulli distributions _o_ ˆ _t_ . The KL-divergence between _Qφs_ ( _st_ ) and _P_ ( _st_ ) is computed analytically, and
the logarithm of _Pθo_ ( _ot|st_ ) reduces to the binary cross entropy (BCE) because _Pθo_ ( _ot|st_ ) is a product of
Bernoulli distributions. Next, the VFE is obtained by subtracting the BCE from the KL-divergence, and
back-propagation is used to update the weights of the encoder and decoder networks. Figure 9 illustrates
the VAE agent presented in this section. Note, this agent takes random actions.

Figure 9: This figure illustrates the VAE agent. From left to right, we have the input image _ot_, the
encoder network, the layer of mean _µ_ and log variance ln _σ_, the epsilon random variable used for the
reparameterisation trick, the latent state _s_ ˆ _t_, the decoder network, and finally, the reconstructed image

_o_ ˆ _t_ . Note, there are no actions in this agent’s generative model. Therefore, the VAE agent takes random
actions.

**3.4** **Deep** **hidden** **Markov** **model**

In this section, we present our second agent based on a hidden Markov model. Similarly to the VAE
agent, the HMM agent is composed of an encoder network modelling _Qφs_ ( _sτ_ ), and a decoder network
modelling _Pθo_ ( _oτ_ _|sτ_ ). However, the prior over the hidden states at time step _t_ + 1 depends on the hidden
states and action at time step _t_ . This prior is modelled by the transition network _Tθs_ that predicts
the parameters of the Gaussian distribution _Pθs_ ( _st_ +1 _|st, at_ ) = _N_ ( _st_ +1;˚ _µ,_ ˚ _σ_ ), where ˚ _µ_ is the mean of the
Gaussian distribution, and ˚ _σ_ are the diagonal elements of the covariance matrix. Recall, that the goal of
the inference process is to fit the approximate posterior _Qφs_ ( _st_ ) to the true posterior _P_ ( _st|ot, st−_ 1 _, at−_ 1).
Formally, this optimisation can be written as the minimization of the Kullback-Leibler divergence between

22

Deconstructing deep active inference.

the approximate and the true posterior, i.e.,

_Q_ <sup>_∗_</sup> ( _st_ ) = arg min

_Qφs_ ( _st_ )

_D_ KL [ _Qφs_ ( _st_ ) _|| P_ ( _st|ot, st−_ 1 _, at−_ 1)] _._

Using a derivation almost identical to the one presented in Section 2.2.2, the VFE can be proven to be:

_Q_ <sup>_∗_</sup> _φ_

(12)

<sup>_∗_</sup> _φs_ <sup>(</sup> <sup>_st_</sup> <sup>)</sup> <sup>=</sup> arg min

_Qφs_ ( _st_ )

_D_ KL [ _Qφs_ ( _st_ ) _|| Pθo_ ( _ot|st_ ) _Pθs_ ( _st|st−_ 1 _, at−_ 1)]

<u>�</u> <u>��</u> <u>�</u>
variational free energy

_D_ KL [ _Qφs_ ( _st_ ) _|| Pθs_ ( _st|st−_ 1 _, at−_ 1)] _−_ E _Qφs_ ( _st_ )[ _Pθo_ ( _ot|st_ )] _._

= arg min

_Qφs_ ( _st_ )

The VFE of Equation 12 can be computed in a similar way to the VAE agent. Put simply, this agent
takes random actions, and stores its experiences in a replay buffer (c.f. Section 3.2). Then, batches of
experiences ( _ot−_ 1, _at−_ 1, _ot_, _rt_, _done_ ) are sampled from the replay buffer. The observations at time step
_t −_ 1 are feed into the encoder, which outputs the mean and log variance of a Gaussian distribution
_Qφs_ ( _st−_ 1) = _N_ ( _st−_ 1; _µ, σ_ ). A latent state is sampled from _Qφs_ ( _st−_ 1) using the re-parameterisation trick,
and is then provided as input to the transition network along with action _at−_ 1. The transition network
outputs the parameters of the Gaussian distributions _Pθs_ ( _st|st−_ 1 _, at−_ 1) = _N_ ( _st_ ;˚ _µ,_ ˚ _σ_ ). Additionally, the
observations at time step _t_ can be fed into the encoder to get the parameters of _Qφs_ ( _st_ ) = _N_ ( _st_ ; ˆ _µ,_ ˆ _σ_ ).
Sampling from _Qφs_ ( _st_ ) using the reparameterisation trick gives a state _s_ ˆ _t_ that when given as input to
the decoder produces the parameters of a product of Bernoulli distributions _o_ ˆ _t_ +1. The KL-divergence
between _Qφs_ ( _st_ ) and _Pθs_ ( _st|st−_ 1 _, at−_ 1) is computed analytically, and the logarithm of _Pθo_ ( _ot|st_ ) reduces
to the binary cross entropy (BCE) because _Pθo_ ( _ot|st_ ) is a product of Bernoulli distributions. Next, the
VFE is obtained by subtracting the BCE from the KL-divergence, and back-propagation is used to update
the weights of the encoder, decoder and transition networks. Figure 10 illustrates the HMM agent.

**3.5** **Deep** **critical** **HMM**

In this section, we present our third agent that incorporates a critic network to the deep HMM presented
in the previous section. The resulting model is called a deep CHMM and is illustrated in Figure 11.
The CHMM is equipped with an encoder _Eφs_ modelling _Qφs_ ( _sτ_ ), a decoder _Dθo_ modelling _Pθo_ ( _oτ_ _|sτ_ ), a
transition network _Tθs_ modelling _Pθs_ ( _st|st−_ 1 _, at−_ 1), and a critic network _Gθa_ that predicts the expected free
energy (see below) of each action. The critic is then used to define the prior over actions as: _Pθa_ ( _at|st_ ) =
_σ_ [ _−ζGθa_ ( _st,_ <sup>_•_</sup> )], where _ζ_ is the precision of the prior over actions, and _Gθa_ ( _st,_ <sup>_•_</sup> ) is the EFE of taking
each action in state _st_ as predicted by the critic. The encoder, decoder and transition networks are all
trained in the same way as before to minimise the VFE. The critic however is trained to minimise the
smooth L1 norm between its output _Gθa_ ( _st,_ <sup>_•_</sup> ) and the target G-values _y_ ( <sup>_•_</sup> ), i.e., the critic minimises
SL1[ _Gθa_ ( _st,_ <sup>_•_</sup> ) _, y_ ( <sup>_•_</sup> )]. Note, the SL1 was picked because it is less sensitive to outliers than the MSE, and
is defined as:

_,_

_SL_ 1[ _x, y_ ] =

�0 _._ 5 _×_ <sup><u>(</u></sup> <sup>_<u>x−y</u>_</sup> <sup><u>)2</u></sup> if _|x −_ _y| < β_
_β_

_|x −_ _y| −_ 0 _._ 5 _× β_ otherwise

where _β_ is an hyper-parameter such that as _β_ goes to zero, the SL1 loss converges to the L1 loss, and
when _β_ tends to + _∞_, the SL1 loss converges to a constant zero loss. Intuitively, the SL1 loss uses a
squared term if the absolute element-wise error falls below _β_, and an L1 term otherwise. Addtionally, the
target G-values are defined as:

       
_G_ ˆ _θ_ ˆ _a_ ( _st_ +1 _, at_ +1) _,_

_y_ ( _at_ ) = _Gt_ +1( _at_ ) + _γ_ E _Qφs_ ( _st_ +1)

max
_at_ +1 _∈A_

where _Qφs_ ( _st_ +1) can be computed by feeding the image _ot_ +1 sampled from the replay buffer as input to
the encoder, _Gt_ +1( _at_ ) is the expected free energy at time _t_ + 1 after taking action _at_ (see below), and _γ_ is

23

Champion et al.

Figure 10: This figure illustrates the HMM agent. On the left and right, one can see two auto-encoders,
i.e., one at time step _t_ and one at time step _t_ + 1. In the middle, the transition network takes as
input the state and action at time _t_, i.e., (ˆ _st, at_ ), and outputs the mean ˚ _µ_ and log variance ln˚ _σ_ of a
Gaussian distribution. By sampling the latent variable _ϵ_, and using the reparameterisation trick, we
get the latent state outputed by the transition network: ˚ _st_ +1 = ˚ _µ_ + ˚ _σ_ _⊙_ _ϵ_ ˆ where _ϵ_ ˆ is sampled from a
Gaussian distribution with mean zero and variance one. Importantly, the model seems to be composed
of two disconnected parts, however, the variational free energy will have a complexity term between the
Gaussian distributions outputed by the transition network and encoder at time _t_ + 1. Note, this agent
takes random actions.

a discount factor. Note, the above Equation is an application of Bellman’s equation (Bellman, 1952) to
the expected free energy. Also, as for the DQN agent, we improved the training stability by implementing
a target network _G_ <sup>ˆ</sup> _θ_ ˆ _a_, which is structurally identical to the critic and whose weights are synchronised with
the weights of the critic every _K_ (learning) iterations. The last question to answer before focusing on the
subject of the EFE is: how does the CHMM select the action to be performed in the environment?

There are at least four possibilities: (i) select a random action, (ii) select the action that maximises
EFE according to the critic, i.e., _a_ <sup>_∗_</sup> _t_ <sup>= arg max</sup> _at_ <sup>_Gθ_</sup> _a_ <sup>(</sup> <sup>_st, at_</sup> <sup>), (iii) sample an action from a softmax function</sup>

EFE according to the critic, i.e., _a_ <sup>_∗_</sup> _t_ <sup>= arg max</sup> _at_ <sup>_Gθ_</sup> _a_ <sup>(</sup> <sup>_st, at_</sup> <sup>), (iii) sample an action from a softmax function</sup>

of the output of the critic, i.e., _a_ <sup>_∗_</sup> _t_ <sup>_∼_</sup> <sup>_σ_</sup> <sup>[</sup> <sup>_Gθ_</sup> _a_ <sup>(</sup> <sup>_st,_</sup> <sup>_•_</sup> <sup>)] where</sup> <sup>_σ_</sup> <sup>[</sup> <sup>_•_</sup> <sup>] is a softmax function, and (iv) use the˚</sup> <sup>_ϵ_</sup> <sup>-greedy</sup>

<sup>_∗_</sup> _t_ <sup>_∼_</sup> <sup>_σ_</sup> <sup>[</sup> <sup>_Gθ_</sup> _a_ <sup>(</sup> <sup>_st,_</sup> <sup>_•_</sup> <sup>)] where</sup> <sup>_σ_</sup> <sup>[</sup> <sup>_•_</sup> <sup>] is a softmax function, and (iv) use the˚</sup> <sup>_ϵ_</sup> <sup>-greedy</sup>

24

Deconstructing deep active inference.

algorithm with exponential decay, i.e., select a random action with probabilty ˚ _ϵ_ or select the best action
with probability 1 _−_ ˚ _ϵ_ where ˚ _ϵ_ starts with a high value and decays exponentially fast.

Figure 11: This figure illustrates the CHMM agent. The only new part is the critic network, which takes
as input the hidden state at time _t_ and ouputs the expected free energy of each action **_G_** . Importantly,
the CHMM takes actions based on the EFE.

3.5.1 Expected free energy

In this section, we discuss the definition of the expected free energy (EFE) before investigating various
ways to implement it in the context of deep active inference. Recently in (Parr and Friston, 2019), the
expected free energy was defined as:

_T_

_τ_ = _t_ +1

_G_ ( _π_ ) =

_T_

_Gτ_ ( _π_ ) =

_τ_ = _t_ +1

E _P_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|π_ )

- ln _Q_ ( _sτ_ _|π_ ) _−_ ln _P_ ( _oτ_ _, sτ_ )� _,_ (13)

where _P_ ( _oτ_ _|sτ_ ) is the likelihood mapping, _Q_ ( _sτ_ _|π_ ) is the variational distribution, and in the literature,
_P_ ( _oτ_ _, sτ_ ) is called the generative model but is better understood as a target distribution encoding the
prior preferences of the agent. Indeed, assuming the standard generative model of active inference (i.e.,

25

Champion et al.

Figure 12: This figure illustrates the computation of the critic’s loss function when the critic is only
maximising reward, i.e., when Equation 19 is used for the expected free energy. Briefly, the state _st_ is
fed into the Critic, and the state _st_ +1 is fed into the target network. The critic outputs the G-values for
each action at time _t_, and the target network outputs the G-values for each action at time _t_ + 1. Then,
the reward, the discount factor, and G-values of each action at time _t_ + 1 are used to compute the target
values _y_ ( <sup>_•_</sup> ). Finally, the goal is to minimise the SL1 between the prediction of the critic and the target
values by changing the weights of the critic.

a partially observable Markov decision process), the hidden states _sτ_ should depend on _sτ_ _−_ 1 and _aτ_ _−_ 1.
This point is important because it impacts the question of whether _P_ ( _oτ_ _, sτ_ ) is indeed the generative
model, and therefore whether the expected free energy is the expectation of the variational free energy.
According to the free energy principle, an active inference agent must minimise its (variational) free
energy. However, if such a relationship cannot be established between the expected and variational free
energy, then one cannot claim that an agent minimising expected free energy also minimises its variational
free energy. Additionally, we need to re-arrange the definition of the EFE stated in (13) to allow rewards
to be incorporated:

_Gτ_ ( _π_ ) = E _P_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|π_ )

= E _P_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|π_ )

_≈_ E _P_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|π_ )

- ln _Q_ ( _sτ_ _|π_ ) _−_ ln _P_ ( _oτ_ _, sτ_ )�

- ln _Q_ ( _sτ_ _|π_ ) _−_ ln _P_ ( _sτ_ _|oτ_ ) _−_ ln _P_ ( _oτ_ )�

- ln _Q_ ( _sτ_ _|π_ ) _−_ ln _Q_ ( _sτ_ ) _−_ ln _P_ ( _oτ_ )�

- ln _P_ ( _oτ_ )

= _D_ KL [ _Q_ ( _sτ_ _|π_ ) _|| Q_ ( _sτ_ )]

<u>�</u> <u>��</u> <u>�</u>
epistemic value

_−_ E _P_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|π_ )

<u>�</u> <u>��</u> <u>�</u>
extrinsic value

_,_ (14)

3.5.2 A principled estimate of the EFE at time _t_ + 1?

Now, the question is how to estimate (14), and we focus on the case where _τ_ = _t_ + 1. Note, because
_τ_ = _t_ +1, the policy _π_ contains only one action _at_, i.e., _π_ = _at_ . In the tabular version of active inference, the
variational distribution is composed of a factor _Q_ ( _sτ_ _|π_ ). However, in the deep active inference literature,

26

Deconstructing deep active inference.

the variational distribution does not contain such a factor. Generally, a Monte-Carlo estimate is used as
follows:

_N_

_Q_ ( _st_ +1 _|at_ ) = E _Qφs_ ( _st_ )

- _Pθs_ ( _st_ +1 _|st, at_ )

_≈_ <sup><u>1</u></sup>

_N_

_i_ =1

_Pθs_ ( _st_ +1 _|st_ = _s_ ˆ <sup>_i_</sup> _t_ <sup>_, at_</sup> <sup>)</sup> <sup>_,_</sup> (15)

where _s_ ˆ <sup>_i_</sup> _t_

where _s_ ˆ <sup>_i_</sup> _t_ <sup>_∼_</sup> <sup>_Qφ_</sup> _s_ <sup>(</sup> <sup>_st_</sup> <sup>).</sup> <sup>Importantly,</sup> <sup>for</sup> <sup>the</sup> <sup>expected</sup> <sup>free</sup> <sup>energy</sup> <sup>to</sup> <sup>be</sup> <sup>the</sup> <sup>expectation</sup> <sup>of</sup> <sup>the</sup> <sup>variational</sup>

free energy, _Q_ ( _st_ +1 _|at_ ) should be a factor of the variational distribution. However, (15) is estimated using
a factor of the generative model _Pθs_ ( _st_ +1 _|st_ = _s_ ˆ <sup>_i_</sup> _t_ <sup>_, at_</sup> <sup>).</sup> <sup>This</sup> <sup>is</sup> <sup>a</sup> <sup>conceptual</sup> <sup>issue,</sup> <sup>associated</sup> <sup>with</sup> <sup>current</sup>

a factor of the generative model _Pθs_ ( _st_ +1 _|st_ = _s_ ˆ <sup>_i_</sup> _t_ <sup>_, at_</sup> <sup>).</sup> <sup>This</sup> <sup>is</sup> <sup>a</sup> <sup>conceptual</sup> <sup>issue,</sup> <sup>associated</sup> <sup>with</sup> <sup>current</sup>

deep active inference approaches, such as Fountas et al (2020). In what follows, we use _N_ = 1 leading to
a simplified version of the estimate:

_Q_ ( _st_ +1 _|at_ ) _≈_ _Pθs_ ( _st_ +1 _|st_ = _s_ ˆ _t, at_ ) _._ (16)

Note, in the above equation, _s_ ˆ <sup>_i_</sup> _t_ <sup>is</sup> <sup>denoted</sup> <sup>_s_</sup> <sup>ˆ</sup> <sup>_t_</sup> <sup>because</sup> <sup>there</sup> <sup>is</sup> <sup>only</sup> <sup>one</sup> <sup>sample,</sup> <sup>i.e.,</sup> <sup>_N_</sup> <sup>= 1.</sup> <sup>At</sup> <sup>this</sup> <sup>point,</sup>

we have an estimate for _Q_ ( _st_ +1 _|at_ ) and _Qφs_ ( _st_ ) is the variational distribution. The only missing piece is
an estimate of the extrinsic value. In the tabular version of active inference, the preferences of the agent
can be related to the rewards from the reinforcement learning literature. In this paper, we follow (Costa
et al, 2020b) and define the prior preferences as:

<u>exp(</u> _<u>ψrτ</u>_ <u>[</u> _<u>oτ</u>_ <u>])</u>
_P_ ( _oτ_ ) = <u>�</u>
_oτ_ <sup>exp(</sup> <sup>_ψrτ_</sup> <sup>[</sup> <sup>_oτ_</sup> <sup>])</sup> <sup>_,_</sup>

where _ψ_ is the precision of the prior preferences, and _rτ_ [ _oτ_ ] is the reward obtained when making observation
_oτ_ . Taking the logarithm of the above equation leads to:

ln _P_ ( _oτ_ ) = _ψrτ_ [ _oτ_ ] _−_ ln

_oτ_

exp( _ψrτ_ [ _oτ_ ])

= _ψrτ_ [ _oτ_ ] + _C,_ (17)

where we used the fact that the summation over all _oτ_ is a normalisation term, i.e., a constant. Using
(17), we can now create an estimate of the extrinsic value as follows:

_M_

_i_ =1

_M_

E _Pθo_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|at_ )

- ln _P_ ( _oτ_ )

_≈_ <sup><u>1</u></sup>

_M_

_i_ =1

ln _P_ ( _oτ_ = _o_ ˆ _τ_ ) = <sup><u>1</u></sup>

_M_

_ψrτ_ [ _oτ_ ] + _C,_

where _o_ ˆ _τ_ _∼_ _Pθo_ ( _oτ_ _|sτ_ = _s_ ˆ _τ_ ) and _s_ ˆ _τ_ _∼_ _Q_ ( _sτ_ _|at_ ). In what follows, we use _M_ = 1 and discard the constant <sup>6</sup>,
which leads to a simplified version of the estimate:

E _Pθo_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|at_ )� ln _P_ ( _oτ_ )� =∆ _ψrτ_ [ _oτ_ ] =∆ _ψrτ_ _,_

where we simplied the notation by deno in which all our simulations will be ting _rτ_ [ _oτ_ ] as _rτ_ . To conclude,
we have the following estimate for the EFE at time _τ_ = _t_ + 1:

_Gt_ +1( _at_ ) _≈_ _D_ KL [ _Q_ ( _st_ +1 _|at_ ) _|| Qφs_ ( _st_ +1)] _−_ E _Pθo_ ( _ot_ +1 _|st_ +1) _Q_ ( _st_ +1 _|at_ )

- ln _P_ ( _ot_ +1)�

_≈_ _D_ KL [ _Pθs_ ( _st_ +1 _|st_ = _s_ ˆ _t, at_ ) _|| Qφs_ ( _st_ +1)] _−_ _ψrt_ +1 _,_ (18)

where _s_ ˆ _t_ _∼_ _Qφs_ ( _st_ ), _Pθs_ ( _st_ +1 _|st, at_ ) is known from the generative model, _Qφs_ ( _st_ +1) is known from the
variational distribution, the KL-divergence can be estimated using an analytical solution, _ψ_ is a hyperparameter modulating the precision of the prior preferences, and _rt_ +1 is the reward obtained at time step
_t_ + 1. As shown in Figure 12, the reward at time step _t_ + 1 is used to compute the target values that
must be predicted by the critic network.

6. Removing a constant does not influence which policy is the best. Indeed, _π_ <sup>_∗_</sup> = arg max _π G_ ( _π_ ) = arg max _π G_ ( _π_ ) _−_ _C_ .

27

Champion et al.

3.5.3 Other definitions of the EFE at time _t_ + 1

In the previous section, we have presented what may be a principled way to estimate the EFE. As will be
discussed later in this paper, this estimate of the EFE was not very fruitful empirically. To explore the
range of alternatives, we also experimented with the following definitions, which contain relatively minor
perturbations of the epistemic value term:

_G_ <sup>1</sup> _t_ +1 <sup>(</sup> <sup>_at_</sup> <sup>) =</sup> <sup>_H_</sup> <sup>[</sup> <sup>_Qφ_</sup> _s_ <sup>(</sup> <sup>_st_</sup> <sup>+1)]</sup> <sup>_−_</sup> <sup>_H_</sup> <sup>[</sup> <sup>_Pθ_</sup> _s_ <sup>(</sup> <sup>_st_</sup> <sup>+1</sup> <sup>_|st_</sup> <sup>=</sup> <sup>_s_</sup> <sup>ˆ</sup> <sup>_t, at_</sup> <sup>)]</sup> <sup>_−_</sup> <sup>_ψrt_</sup> <sup>+1</sup> <sup>_,_</sup>

_G_ <sup>2</sup> _t_ +1 <sup>(</sup> <sup>_at_</sup> <sup>) =</sup> <sup>_H_</sup> <sup>[</sup> <sup>_Pθ_</sup> _s_ <sup>(</sup> <sup>_st_</sup> <sup>+1</sup> <sup>_|st_</sup> <sup>=</sup> <sup>_s_</sup> <sup>ˆ</sup> <sup>_t, at_</sup> <sup>)]</sup> <sup>_−_</sup> <sup>_H_</sup> <sup>[</sup> <sup>_Qφ_</sup> _s_ <sup>(</sup> <sup>_st_</sup> <sup>+1)]</sup> <sup>_−_</sup> <sup>_ψrt_</sup> <sup>+1</sup> <sup>_,_</sup>

_G_ <sup>3</sup> _t_ +1 <sup>(</sup> <sup>_at_</sup> <sup>) =</sup> <sup>_D_</sup> <sup>KL</sup> <sup>[</sup> <sup>_Qφ_</sup> _s_ <sup>(</sup> <sup>_st_</sup> <sup>+1)</sup> <sup>_|| Pθ_</sup> _s_ <sup>(</sup> <sup>_st_</sup> <sup>+1</sup> <sup>_|st_</sup> <sup>=</sup> <sup>_s_</sup> <sup>ˆ</sup> <sup>_t, at_</sup> <sup>)]</sup> <sup>_−_</sup> <sup>_ψrt_</sup> <sup>+1</sup> <sup>_,_</sup>

where all the entropy terms and the KL-divergence were computed analytically. Also, we experimented
with simply predicting the (negative) expected future reward as follows:

_G_ <sup>4</sup> _t_ +1 <sup>(</sup> <sup>_at_</sup> <sup>) =</sup> <sup>_−ψrt_</sup> <sup>+1</sup> <sup>_,_</sup> (19)

which is effectively making the job of the critic identical to the job of the Q-network in the DQN agent
(c.f. Section 2.1 for details). More precisely, they are identical, except for the fact that the Q-network is
taking observations as input, while the critic takes hidden states.

**3.6** **Deep** **active** **inference**

In this section, we discuss the full deep active inference (DAI) agent illustrated in Figure 13. Put simply,
this agent is composed of five deep neural networks, i.e., the encoder, the decoder, the transition, the critic
and the policy network. The decoder _Dθo_ models _Pθo_ ( _oτ_ _|sτ_ ) as a product of Bernoulli distributions, i.e.,
_Pθo_ ( _oτ_ _|sτ_ ) = _B_ ernoulli( _oτ_ ; ˆ _oτ_ ) where _o_ ˆ _τ_ = _Dθo_ ( _sτ_ ). The transition network _Tθs_ models _Pθs_ ( _sτ_ +1 _|sτ_ _, aτ_ ) as
a Gaussian distribution, i.e., _Pθs_ ( _sτ_ +1 _|sτ_ _, aτ_ ) = _N_ ( _sτ_ +1 _|_ ˚ _µ,_ ˚ _σ_ ) where ˚ _µ,_ ln˚ _σ_ = _Tθs_ ( _sτ_ _, aτ_ ). The critic _Gθa_
outputs a vector containing the predicted expected free energy of each action, which is used to define the
prior over action as _Pθa_ ( _aτ_ _|sτ_ ) = _σ_ [ _−ζGθa_ ( _sτ_ _,_ <sup>_•_</sup> )], where _σ_ [ <sup>_•_</sup> ] is a softmax function and _ζ_ is the precision
of the prior over actions. With this in mind, the full generative model of the agent is:

_T_ _−_ 1

_τ_ =0

_Pθs_ ( _sτ_ +1 _|sτ_ _, aτ_ ) _Pθa_ ( _aτ_ _|sτ_ ) _,_

_Pθ_ ( _oo_ : _T, so_ : _T, ao_ : _T_ _−_ 1) = _P_ ( _s_ 0)

_T_

_τ_ =0

_Pθo_ ( _oτ_ _|sτ_ )

where _P_ ( _s_ 0) = _N_ ( _s_ 0; _µ_ 0 _, σ_ 0) is a Gaussian prior over initial hidden states. Let _t_ be the present time
step. The DAI agent maintains posterior beliefs over the present states _st_ and action _at_ . The variational
posterior over states _Qφs_ ( _st_ ) is a Gaussian distribution modelled by the encoder _Eφs_, i.e., _Qφs_ ( _st_ ) =
_N_ ( _st_ ; _µ, σ_ ) where _µ,_ ln _σ_ = _Eφs_ ( _ot_ ). The variational posterior over actions _Qφa_ ( _at|st_ ) is a categorical
distribution modelled by the policy network _Pφa_, i.e., _Qφa_ ( _at|st_ ) = Cat( _at_ ; ˆ _π_ ) where _π_ ˆ = _Pφa_ ( _st_ ). The
full variational distribution is therefore defined as:

_Qφ_ ( _at, st_ ) = _Qφa_ ( _at|st_ ) _Qφs_ ( _st_ ) _._

The variational free energy of the DAI agent is derived in a similar way to the VFE of Section 2.2.2, and
is defined as:

_Q_ <sup>_∗_</sup> _φ_ <sup>(</sup> <sup>_st, at_</sup> <sup>) = arg min</sup>

_Qφ_ ( _st,at_ )

= arg min

_Qφ_ ( _st,at_ )

_D_ KL [ _Qφ_ ( _st, at_ ) _|| Pθo_ ( _ot|st_ ) _Pθs_ ( _st|st−_ 1 _, at−_ 1) _Pθa_ ( _at|st_ )]

<u>�</u> <u>��</u> <u>�</u>
variational free energy

(20)

- + _D_ KL [ _Qφs_ ( _st_ ) _|| Pθs_ ( _st|st−_ 1 _, at−_ 1)]

E _Qφs_ ( _st_ )

- _D_ KL [ _Qφa_ ( _at|st_ ) _|| Pθa_ ( _at|st_ )]

_−_ E _Qφs_ ( _st_ )[ln _Pθo_ ( _ot|st_ )] _._

28

Deconstructing deep active inference.

Figure 13: This figure illustrates the DAI agent. The only new part is the policy network, which takes
as input the hidden state at time _t_ and ouputs the parameters _π_ ˆ of the variational posterior over actions.
Importantly, the DAI takes actions based on the EFE.

The VFE is therefore a function of _st−_ 1, _at−_ 1, and _ot_ . Both _at−_ 1, and _ot_ can be obtained from the
replay buffer, and _st−_ 1 can be sampled from the variational distribution predicted by the encoder network
when observation _ot−_ 1 is provided as input. Also, the KL-divergences can be computed analytically,
the expectations w.r.t _Qφs_ ( _st_ ) can be approximated using a Monte-Carlo estimate, and the logarithm of
the likelihood mapping reduces to the binary cross entropy because _Pθo_ ( _ot|st_ ) is a product of Bernoulli
distributions. Thus, all the VFE terms can be estimated, and the encoder, decoder, transition and policy

29

Champion et al.

networks can be trained to minimise the VFE using gradient descent. The critic’s weights are optimised
as in Section 3.5 using gradient descent to minimise the smooth L1 norm between the critic’s output
_Gθa_ ( _st,_ <sup>_•_</sup> ) and the target G-values _y_ ( <sup>_•_</sup> ), i.e., SL1[ _Gθa_ ( _st,_ <sup>_•_</sup> ) _, y_ ( <sup>_•_</sup> )] _,_ where the target G-values are defined
as:

       
_G_ ˆ _θ_ ˆ _a_ ( _st_ +1 _, at_ +1) _,_

_y_ ( _at_ ) = _Gt_ +1( _at_ ) + _γ_ E _Qφs_ ( _st_ +1)

max
_at_ +1 _∈A_

where _Qφs_ ( _st_ +1) can be computed by feeding the image _ot_ +1 sampled from the replay buffer as input to
the encoder, _γ_ is a discount factor, and _Gt_ +1( _at_ ) is the expected free energy received at time _t_ + 1 after
taking action _at_, i.e.,

_Gt_ +1( _at_ ) _≈_ _D_ KL [ _Pθs_ ( _st_ +1 _|st_ = _s_ ˆ _t, at_ ) _|| Qφs_ ( _st_ +1)] _−_ _ψrt_ +1 _,_ (21)

where _s_ ˆ _t_ _∼_ _Qφs_ ( _st_ ), _ψ_ is a hyperparamter modulating the precision of the prior preferences, and _rt_ +1 is
the reward obtained at time step _t_ + 1. Note, we also experimented with other definitions of the EFE
at time _t_ + 1 as presented in Section 3.5.3. Finally, with regard to the action selection performed by the
DAI agent, there are at least four possibilities: (i) select a random action, (ii) select the action with the
highest posterior probability according to the policy network, i.e., _a_ <sup>_∗_</sup> _t_ <sup>= arg max</sup> _at_ <sup>_Qφ_</sup> _a_ <sup>(</sup> <sup>_at|st_</sup> <sup>),</sup> <sup>(iii)</sup> <sup>sample</sup>

highest posterior probability according to the policy network, i.e., _a_ <sup>_∗_</sup> _t_ <sup>= arg max</sup> _at_ <sup>_Qφ_</sup> _a_ <sup>(</sup> <sup>_at|st_</sup> <sup>),</sup> <sup>(iii)</sup> <sup>sample</sup>

an action from the posterior over actions, i.e., _a_ <sup>_∗_</sup> _t_ <sup>_∼_</sup> <sup>_Qφ_</sup> _a_ <sup>(</sup> <sup>_at|st_</sup> <sup>),</sup> <sup>and</sup> <sup>(iv)</sup> <sup>use</sup> <sup>the ˚</sup> <sup>_ϵ_</sup> <sup>-greedy</sup> <sup>algorithm</sup> <sup>with</sup>

an action from the posterior over actions, i.e., _a_ <sup>_∗_</sup> _t_ <sup>_∼_</sup> <sup>_Qφ_</sup> _a_ <sup>(</sup> <sup>_at|st_</sup> <sup>),</sup> <sup>and</sup> <sup>(iv)</sup> <sup>use</sup> <sup>the ˚</sup> <sup>_ϵ_</sup> <sup>-greedy</sup> <sup>algorithm</sup> <sup>with</sup>

exponential decay, i.e., random action with probabilty ˚ _ϵ_ or best action with probability 1 _−_ ˚ _ϵ_ .

**4.** **Results**

In this section, we discuss the results obtained by the DQN agent and each model presented in Section 3 at
solving the dSprites problem. The code that can be used to reproduce all the experiements can be found
on GitHub at the following URL: `[https://github.com/ChampiB/Challenges_Deep_Active_Inference](https://github.com/ChampiB/Challenges_Deep_Active_Inference)` .
Section 4.1 presents the results obtained by the DQN agent. Section 4.2 presents the VFE obtained by
the VAE agent, and shows the reconstructed images produced by the VAE. Section 4.3 shows the VFE of
the HMM agent as well as the generated sequences of images. Section 4.4 illustrates the VFE obtained
by the CHMM as well as the reward obtained by this model when using different action selection schemes
and different definitions for the EFE. Finally, Section 4.5 dicusses the VFE obtained by the DAI agent,
as well as the rewards obtained by this model. Note, each time CKA is used in the following sections, we
sampled 5K data examples, and we used them to compute all the CKA scores.

**4.1** **DQN** **agent**

In this section, we report the results obtained from the DQN agent. As shown in Figure 14, the DQN was
able to accumulate a total amount of reward of around 50K. This result confirms the correctness of our
implementation, and gives us a baseline which can be used to evaluate the performance of the CHMM and
DAI agents. To better understand the representations learned by a DQN, we compute the CKA scores
between the activations of its layers. We can see in Figure 15 that while the layers closer to the input
retain some similarity with each other, the last two layers learn highly specific representations.

30

Deconstructing deep active inference.

Training Iterations

Figure 14: This figure illustrates the cumulated rewards obtained by the DQN agent during the 500K
training iterations.

Value_1

Value_2

Value_3

Value_4

Value_5

Value_6

1.0

0.8

0.6

0.4

0.2

0.0

Model=DQN

Figure 15: Value X labels the X-th layer of the value network, i.e., Value ~~1~~ is the closest to the input
and Value ~~6~~ is the output layer. We can see that the first three layers of the DQN learn very similar
representations (CKA is close to 1). The representations learned by the fourth layer start to diverge
(CKA is lower), and the last two layers learn highly specific representations that are very different from
the previous layers (CKA is close to 0), but slightly similar to each other.

**4.2** **VAE** **agent**

In this section, we report the results obtained by the VAE agent. As shown in Figure 16, the VFE
decreases as training progresses. Also, at the end of the 500K training iterations, the VAE is able to
properly reconstruct the images, c.f., Figure 18. Additionally, since the VAE takes random actions in
the environment, the agent was unable to solve the task and accumulated a total amount of reward of
around -7K. Those results suggest our implementation is correct, and gives us a baseline for the amount
of rewards obtained under random play in the dSprites environment.

31

Champion et al.

Training Iterations

Figure 16: This figure illustrates the variational free energy of the VAE agent during the 500K iterations
of training.

Encoder_1

Encoder_2

Encoder_3

Encoder_4

Encoder_5

Encoder_mean

Encoder_variance

1.0

0.8

0.6

0.4

0.2

0.0

Value_1

Value_2

Value_3

Value_4

Value_5

Value_6

1.0

0.8

0.6

0.4

0.2

0.0

Model=VAE

(a)

Model=VAE

(b)

Figure 17: Encoder ~~X~~ is to the X-th layer of the encoder network, i.e., Encoder ~~1~~ is the closest to the input
and Encoder ~~5~~ is the one just before the mean and variance layers. Encoder ~~m~~ ean and Encoder ~~v~~ ariance
are the mean and variance layers of the encoder network, respectively. (a) shows the similarity between
the representations learned by different layers of the encoder of a VAE. (b) shows the similarity between
the representations learned by a DQN and a VAE. Note, both the VAE and DQN take images as input
and need to process them to either learn a compact representation and reconstruct the images or predict
the cumulated reward, respectively. Thus, both learn to represent edges and combination of edges in their
first layers.

To observe the representations learned by VAEs, we compute the CKA scores between the activations of
the different layers of the encoder. We can see in Figure 17a that the representations are strongly similar
between all layers, with the exception of the mean and variance representations at the output end (last
two layers), similarly to what was observed in Bonheme and Grzes (2022), and is therefore expected. As
illustrated in Figure 17b, these representations are generally similar to those learned by the DQN in early
layers but the representations of the last two layers strongly differ, reflecting the difference of learning
objectives between the VAE and DQN.

32

Deconstructing deep active inference.

### Reconstruction (R): Ground Truth (GT):

Figure 18: This figure illustrates the reconstructed image produced by the VAE after 500K training
iterations. The columns alternate between the input images and the reconstructed images.

**4.3** **HMM** **agent**

In this section, we report the results obtained by the HMM agent. As shown in Figure 19, the VFE
decreases as training progresses. By comparing Figure 16 and 19, one can see that the HMM has a
lower VFE than the VAE. This is because the agent has more flexibility regarding the prior, i.e., the
log-likelihood is the same between the two models but the complexity term is smaller for the HMM than
for the VAE. Also, at the end of the 500K training iterations, the HMM is able to properly generate sequences of images, c.f., Figure 21. Additionally, since the HMM takes random actions in the environment,
the agent was unable to solve the task and accumulated a total amount of reward of around -7K. These
results suggest that our implementation is correct, and comfirm our baseline for the amount of rewards
obtained under random play in the dSprites environment.

Similarly to VAEs, we are interested in observing the representations learned by the encoder of the
HMM, and also by its transition network. The representations learned by the encoder of the HMM follow the same trend as those learned by VAEs with an even more marked dissimilarity between the log
variance of the HMM and the other representations learned by this model, as illustrated in Figures 20a
and 20b. We can further observe in Figure 20a that the transition network learns representations similar
to the mean representation (Encoder ~~m~~ ean of HMM) in its first three layers, while the representations
learned by the last layer (Transition ~~v~~ ariance) are not similar to any other representations learned by the
transition or encoder networks. We can also see in Figure 20b that the mean and variance representations (Encoder ~~m~~ ean and Encoder ~~v~~ ariance) learned by HMMs are different from those learned by VAEs,
possibly indicating that the transition network influences these two representations. Similarly to VAEs,
one can observe in Figure 20c, that the representations learned by the variance layers of the encoder and
transition networks (Encoder ~~v~~ ariance and Transition ~~v~~ ariance) are very different to the representation
learned by the DQN. In contrast, the first four layers of the encoder (Encoder ~~1~~ to Encoder ~~4~~ ) are similar

33

Champion et al.

to the representation learned by the first layers of the DQN (Value ~~1~~ to Value ~~4~~ ), but are very different
from the last two layers (Value ~~5~~ and Value ~~6~~ ).

Training Iterations

Figure 19: This figure illustrates the variational free energy of the HMM agent during the 500K iterations
of training.

Encoder_1

Encoder_2

Encoder_3

Encoder_4

Encoder_5

Encoder_mean

Encoder_variance

Transition_1

Transition_2

Transition_mean

Transition_variance

1.0

0.8

0.6

0.4

0.2

0.0

Encoder_1

Encoder_2

Encoder_3

Encoder_4

Encoder_5

Encoder_mean

Encoder_variance

Transition_1

Transition_2

Transition_mean

Transition_variance

1.0

0.8

0.6

0.4

0.2

0.0

Value_1

Value_2

Value_3

Value_4

Value_5

Value_6

1.0

0.8

0.6

0.4

0.2

0.0

Model=HMM

(a)

Model=VAE

(b)

Model=HMM

(c)

Figure 20: Transition ~~X~~ is to the X-th layer of the transition network, i.e., Transition ~~1~~ is the closest
to the input and Transition ~~2~~ is the one just before the mean and variance layers. Transition ~~m~~ ean and
Transition ~~v~~ ariance are the mean and variance layers of the transition network, respectively. (a) shows the
similarity between the representations learned by different layers of the encoder and transition network
of an HMM. (b) shows the similarity between the representations learned by an HMM and a VAE. (c)
shows the similarity between the representations learned by a DQN and an HMM.

34

Deconstructing deep active inference.

### Reconstruction (R): Ground Truth (GT):

Figure 21: This figure illustrates the sequences of reconstructed images generated by the HMM after
500K training iterations. The columns alternate between the ground truth images and the reconstructed
images. Time passes vertically (from top to bottom), and within each column, the same action is executed
repeatedly.

**4.4** **CHMM** **agent**

In this section, we report the results obtained by the CHMM agent, when using different action selection
strategies and different definitions of the expected free energy. Figure 22 presents the cumulated rewards
obtained by the CHMM agents using an ˚ _ϵ_ -greedy algorithm for action selection, as well as the total
rewards obtained by the DQN agent. The critic network of the CHMM agents were trained to predict the
five definitions of the expected free energy proposed in Section 3.5. Note, the DQN agent performs better
that any of the CHMM agents, and the only agent that solves the task is the CHMM maximising reward
only, i.e., without any information gain. Figure 23 presents the same experiement as Figure 22 except
that the CHMM agents were using softmax sampling for action selection. In this setting, none of the
CHMM agents were able to solve the task. Finally, Figure 24 presents yet again the same experiements
but this time the CHMM agents were selecting the best action according to the critic. In this setting,
only the CHMM maximising reward was able to solve the task. Also, by comparing Figures 22 and 24,
it becomes clear that the CHMM using an ˚ _ϵ_ -greedy algorithm performs better than the CHMM selecting
the best action according to the critic. Put simply, the latter suffers from a lack of exploration that slows
down its learning.

Additionally, Figure 25 represents the variational free energy of the CHMM agent using the ˚ _ϵ_ -greedy
algorithm. All the agents were able to minimise their variational free energy, except the one displayed in
orange whose VFE suddenly became equal to NaN (i.e., Not a Number); this agent was minimising the
expected free energy as defined by _G_ <sup>1</sup> . Note, _G_ <sup>1</sup> is neither the reward nor the “principled” expected free
energy, _G_ <sup>1</sup> is one of definitions that we experimented with to explore alternative definitions. Also, the

35

Champion et al.

variational free energy of the CHMM agents using softmax sampling and best action selection are not
presented, because their results are very similar to the results shown in Figure 25.

Finally, Figure 26 shows examples of predicted trajectories after a CHMM (maximising reward) was
trained. By comparing with Figure 21, we see that the CHMM does not understand the dynamics of the
environment as well as the HMM agent. This sugguests a conflict between the two goals of the agent,
i.e., maximising reward <sup>7</sup> (or expected free energy) and learning a model of the world. More precisely,
Figure 21 shows that an HMM agent taking random actions is able to gather a large diversity of training
examples and learns the dynamic of the environment beautifully, but does not solve the task. In contrast,
the CHMM maximising reward solves the task but learns a poor model of the environment, c.f., Figure
26.

DQN:

CHMM[ _G_ <sup>4</sup> ]:

CHMM[ _G_, _G_ <sup>2</sup>, _G_ <sup>3</sup> ]:

CHMM[ _G_ <sup>1</sup> ]:

Training iterations

Figure 22: This figure illustrates the total amount of reward gathered by the CHMM agents (with ˚ _ϵ_ greedy action selection) during the 500K iterations of training. The only two models that were able to
solve the task are the ones maximising reward (without information gain), i.e., the DQN agent in red and
the CHMM whose critic network was predicting only reward in gray.

7. As shown in Figure 12, the reward is used to compute the target values that must be predicted by the critic network.

36

Deconstructing deep active inference.

Figure 23: This figure illustrates the total amount of reward gathered by the CHMM agents (with softmax
sampling) during the 500K iterations of training. The only model that was able to solve the task is the
DQN agent in red, and all CHMM agents failed.

Figure 24: This figure illustrates the total amount of reward gathered by the CHMM agents (with best
action selection) during the 500K iterations of training. The only two models that were able to solve
the task are the ones maximising reward (without information gain), i.e., the DQN agent in red and the
CHMM whose critic network was predicting only reward in pink.

37

Champion et al.

Training iterations

CHMM[ _G_ ]:

CHMM[ _G_ <sup>1</sup> ]:
CHMM[ _G_ <sup>2</sup> ]:
CHMM[ _G_ <sup>3</sup> ]:
CHMM[ _G_ <sup>4</sup> ]:

Figure 25: This figure illustrates the variational free energy of the CHMM agents during the 500K
iterations of training. All the agents were able to minimise their variational free energy, except the one
displayed in orange which crashed; this agent was minimising the expected free energy as defined by _G_ <sup>1</sup> .
More precisely, the variational free energy took the value “Not a Number” (NaN), which is visible because
of the thick horizontal line between 270K and 500K training iterations.

### Reconstruction (R): Ground Truth (GT):

Figure 26: This figure illustrates the sequences of reconstructed images generated by a CHMM (maximising reward) after 500K training iterations. The columns alternate between the ground truth images
and the reconstructed images. Time passes vertically (from top to bottom), and within each column, the
same action is executed repeatedly.

38

Deconstructing deep active inference.

4.4.1 How do CHMMs learn?

**CHMM** **with** ˚ _ϵ_ **-greedy** **action** **selection** As illustrated in Figure 22, only the CHMM whose critic
maximises the reward was able to solve the task. We could thus expect the representations learned by
this CHMM to be closer to those learned by the DQN than those learned by the other CHMMs. We can
see in Figure 28 that the last two layers of the critic network of the CHMM maximising the reward are
indeed a bit more similar to the representations of the last two layers of the DQN than the representations
learned when the critic is minimising the EFE (see intersection of Value ~~5~~ and Value ~~6~~ with Critic ~~3~~ and
Critic ~~4~~, i.e., bottom right corner of the matrix). However, the representations learned by the critic of
both CHMMs are still quite different from the last two layers of the DQN (CKA is lower than 0.4, bottom
right corner of the matrix, again). Interestingly, the first four layers of the CHMM maximising the reward
retain a high similarity with the earlier layers of the DQN (4 _×_ 4 region at upper left), suggesting some
common representations between models. We can further see in Figure 27a that the CKA score between
the encoder, transition and critic networks is higher or equal to 0.6 (except for the variance layer of the
transition and the last layer of the critic), indicating that the transition and critic networks of the CHMM
maximising the reward retain some information from the encoder. The information retained by the first
three layers of the critic when the CHMM minimises the EFE is much lower, as illustrated in Figures 27b.

Encoder_1
Encoder_2
Encoder_3
Encoder_4
Encoder_5
Encoder_mean
Encoder_variance

Encoder_1
Encoder_2
Encoder_3
Encoder_4
Encoder_5
Encoder_mean
Encoder_variance

Encoder_1
Encoder_2
Encoder_3
Encoder_4
Encoder_5
Encoder_mean
Encoder_variance

Transition_1
Transition_2
Transition_mean
Transition_variance

Critic_1
Critic_2
Critic_3
Critic_4

1.0

0.8

0.6

0.4

0.2

0.0

Transition_1
Transition_2
Transition_mean
Transition_variance

Critic_1
Critic_2
Critic_3
Critic_4

1.0

0.8

0.6

0.4

0.2

0.0

Transition_1
Transition_2
Transition_mean
Transition_variance

Critic_1
Critic_2
Critic_3
Critic_4

1.0

0.8

0.6

0.4

0.2

0.0

Model=CHMM, Action= -greedy,

Gain=Reward

(a)

Model=CHMM, Action= -greedy,

Gain=EFE

(b)

Model=CHMM, Action= -greedy,

Gain=EFE

(c)

Figure 27: (a) shows the similarity between the representations learned by different layers of the encoder, transition

and critic networks of a CHMM whose critic maximises the reward (with˚ _ϵ_ -greedy selection). (b) shows the similarity

between the representations learned by different layers of the encoder, transition and critic networks of a CHMM

whose critic minimises the EFE (with˚ _ϵ_ -greedy selection) (c) shows the similarity between the representations learned

by two CHMMs, one whose critic optimises EFE and the other optimises reward (both with ˚ _ϵ_ -greedy selection).

Value_1

Value_2

Value_3

Value_4

Value_5

Value_6

1.0

0.8

0.6

0.4

0.2

0.0

Value_1

Value_2

Value_3

Value_4

Value_5

Value_6

1.0

0.8

0.6

0.4

0.2

0.0

Model=CHMM, Action= -greedy,

Gain=Reward

(a)

Model=CHMM, Action= -greedy,

Gain=EFE

(b)

Figure 28: (a) shows the similarity between the representations learned by a CHMM whose critic maximises the

reward (with ˚ _ϵ_ -greedy selection) and a DQN; (b) shows the similarity between the representations learned by a

CHMM whose critic minimises the EFE (with ˚ _ϵ_ -greedy selection) and a DQN

39

Champion et al.

**CHMM** **with** **best** **action** **selection** As illustrated in Figure 24, only the CHMM whose critic maximises the reward was able to solve the task. However, one can see in Figure 29 that the CHMM
whose critic minimises the EFE learns representations similar to those of the CHMM maximising the
reward in most layers, with the exception of the variance layer of the encoder and transition network
(Encoder ~~v~~ ariance and Transition ~~v~~ ariance). To better understand the differences between the representations learned by the variance layer of both models, we fed 5K state-action pairs through the transition
network, and displayed the distribution of the variances outputed by the transition network. This analysis
reveals that the variance (of the variance layer) of the transition network is very small and does not change
much when maximising the reward but is larger and varies more when minimising the EFE as illustrated
in Figure 30. This reflects a higher uncertainty of the transitions for the CHMM minimising EFE. More
specifically, the CHMM minimising EFE seems to be confident for the action down, but is very uncertain
for all the other actions, which suggests that the CHMM minimising EFE always picks the action down
and does not gather enough data for the other actions.

Encoder_1
Encoder_2
Encoder_3
Encoder_4
Encoder_5
Encoder_mean
Encoder_variance

Transition_1
Transition_2
Transition_mean
Transition_variance

Critic_1
Critic_2
Critic_3
Critic_4

1.0

0.8

0.6

0.4

0.2

0.0

Encoder_1
Encoder_2
Encoder_3
Encoder_4
Encoder_5
Encoder_mean
Encoder_variance

Transition_1
Transition_2
Transition_mean
Transition_variance

Critic_1
Critic_2
Critic_3
Critic_4

1.0

0.8

0.6

0.4

0.2

0.0

Encoder_1
Encoder_2
Encoder_3
Encoder_4
Encoder_5
Encoder_mean
Encoder_variance

Transition_1
Transition_2
Transition_mean
Transition_variance

Critic_1
Critic_2
Critic_3
Critic_4

1.0

0.8

0.6

0.4

0.2

0.0

Model=CHMM, Action=Best Action,

Gain=Reward

(a)

Model=CHMM, Action=Best Action,

Gain=EFE

(b)

Model=CHMM, Action=Best Action,

Gain=EFE

(c)

Figure 29: (a) shows the similarity between the representations learned by different layers of the encoder, transition

and critic networks of a CHMM whose critic maximises the reward (with best action selection). (b) shows the

similarity between the representations learned by different layers of the encoder, transition and critic networks

of a CHMM whose critic minimises the EFE (with best action selection) (c) shows the similarity between the

representations learned by two CHMMs, one whose critic optimises EFE and the other that optimises reward (both

with best action selection).

(a) (b)

Figure 30: (a) shows one latent dimension of the variance layer of the transition network for the CHMM maximising

the reward. (b) shows one latent dimension of the variance layer of the transition network for the CHMM minimising

the EFE. Both figures are typical of the distributions of variance activations in the two models. Note, only the

action down has low variance for the CHMM minimising the EFE. This suggests that the CHMM minimising the

EFE always picks the action down, and does not gather enough data for the other actions.

40

Deconstructing deep active inference.

**CHMM** **with** **softmax** **action** **selection** As illustrated in Figure 23, none of the CHMMs with
softmax action selection were able to solve the task. Once again, the variance (of the variance layer) of the
transition network is very different in the CHMM whose critic minimises the EFE compared to the CHMM
whose critic maximises the reward (see Figure 31c at the intersection of the two Transition ~~v~~ ariances).
We further observe the same trend regarding the uncertainty of the output of the transition network when
optimising the EFE, as shown in Figure 32. While this may explain why the model optimising the EFE
does not solve the task, this does not indicate why the model maximising the reward cannot solve the
task, and we can hypothesise that those results may be attributed to the softmax action selection. More
precisely, if the values predicted by the critic network are very close to each other, then an agent using
softmax sampling may perform random actions.

Encoder_1
Encoder_2
Encoder_3
Encoder_4
Encoder_5
Encoder_mean
Encoder_variance

Encoder_1
Encoder_2
Encoder_3
Encoder_4
Encoder_5
Encoder_mean
Encoder_variance

Encoder_1
Encoder_2
Encoder_3
Encoder_4
Encoder_5
Encoder_mean
Encoder_variance

Transition_1
Transition_2
Transition_mean
Transition_variance

Critic_1
Critic_2
Critic_3
Critic_4

1.0

0.8

0.6

0.4

0.2

0.0

Transition_1
Transition_2
Transition_mean
Transition_variance

Critic_1
Critic_2
Critic_3
Critic_4

1.0

0.8

0.6

0.4

0.2

0.0

Transition_1
Transition_2
Transition_mean
Transition_variance

Critic_1
Critic_2
Critic_3
Critic_4

1.0

0.8

0.6

0.4

0.2

0.0

Model=CHMM, Action=Softmax,

Gain=Reward

(a)

Model=CHMM, Action=Softmax,

Gain=EFE

(b)

Model=CHMM, Action=Softmax,

Gain=EFE

(c)

Figure 31: (a) shows the similarity between the representations learned by different layers of the encoder,
transition and critic networks of a CHMM whose critic maximises the reward (with softmax action selection). (b) shows the similarity between the representations learned by different layers of the encoder,
transition and critic networks of a CHMM whose critic minimises the EFE (with softmax action selection).
(c) shows the similarity between the representations learned by two CHMMs, one whose critic optimises
EFE and the other that optimises reward (both with softmax action selection).

4.4.2 Degenerate behaviour with the expected free energy?

Up to now, we saw that the CHMM minimising expected free energy (EFE) was not able to solve the
task. Also, we discovered that the transition network is uncertain for the actions: up, left, and right,
which suggests that the CHMM minimising EFE always takes action down. Figure 33 corroborates this
story. Indeed, Figure 33a shows that the agent minimising EFE almost exclusively picked action down,
and Figure 33b shows that the entropy of the prior over actions very quickly converges to zero.

In contrast, the CHMM maximising reward, keeps on selecting the actions right and left, which enables
it to drag the shape towards the appropriate corner (see Figure 33c). Also, as shown in Figure 33d, the
entropy of the prior over actions remained a lot higher than zero. Note, the only difference between the
CHMM minimising EFE and the one maximising reward is the information gain, which is defined as the
KL divergence between the output of the transition and encoder networks. Since the EFE is minimised,
the output of those two networks need to be as close as possible to each other.

41

Champion et al.

(a)

(b)

Figure 32: (a) shows one latent dimension of the variance layer of the transition network for the CHMM maximising

the reward. (b) shows one latent dimension of the variance layer of the transition network for the CHMM minimising

the EFE. Both figures are representative of the distributions of variance activations in the two models. Note, only

the action down has low variance for the CHMM minimising the EFE. This suggests that the CHMM minimising

the EFE always pick the action down, and does not gather enough data for the other actions.

0 100000 200000 300000 400000 500000
Training iterations

(b)

0 100000 200000 300000 400000 500000
Training iterations

(d)

Down

Right

Left

Up

(a)

0 100000 200000 300000 400000 500000
Training iterations

(c)

1.38

1.36

1.34

1.32

1.30

1.28

1.26

Figure 33: (a) shows the action taken for each planning iteration when the CHMM is minimising expected free

energy. (b) shows the entropy of the prior over actions when the CHMM is minimising the EFE. (c) shows the

action taken for each planning iteration when the CHMM is maximising reward. (d) shows the entropy of the prior

over actions when the CHMM is maximising reward.

42

Deconstructing deep active inference.

This suggests that the CHMM minimising EFE is picking a single action (down), and becomes an
expert at predicting the future when selecting this action. This effectively makes the KL divergence
between the output of the transition and encoder networks small. Additionally, when selecting the action
down, the average reward is zero, because (in the dSprites dataset) there are as many shapes on the left
of the image as on the right, and when crossing the bottom line, the agent receives a reward which is
linearly increasing (or decreasing) as a corner is approached and is zero at the center of the image. For all
the other actions, the expected reward will be negative because after 50 action-perception cycles without
crossing the bottom line, the trial is interrupted and the agent receive a reward of -1. Thus, if the CHMM
has to stick to a single action to keep the KL divergence small, then the best action it can choose is down,
i.e., action down has the highest expected reward.

Also, Figure 34 shows the impact of adding X% of the information gain into the objective function,
i.e., the agent starts by only maximising reward (c.f. Equation 19), and after 200K training iterations
minimises reward plus X% of the information gain. One can see that adding even 1% of the information
gain already dramatically decreases the amount of reward gathered.

To conclude, the same information gain that is intended to give an EFE minimising agent its exploration behaviour, also prevents the agent from solving the dSprites environment. This is because the
agent is reduced to picking a single action, leading to a suboptimal policy.

CHMM[50%]:
CHMM[25%]:
CHMM[15%]:
CHMM[5%]:
CHMM[1%]:
CHMM[0%]:

Training iterations

Figure 34: This figure illustrates the total reward aggregated by CHMM agents during the 500K iterations
of training. All the agents start by only maximising reward, and after 200K training iterations, X% of
the information gain is added to the objective function. Note, even adding 1% of the information gain
is enough to drastically reduce the total reward aggregated by the agent. The differences in trajectories
before 200K are arbitrary, arising from differences in random initializations.

**4.5** **DAI** **agent**

In this section, we report the results obtained by the DAI agent, when using different action selection
strategies and different definitions of the expected free energy. First, most of the fifteen DAI agents
crashed because of numerical instability, i.e., the VFE suddenly became “Not a Number”. The only DAI
agent that survived (i.e., did not crash) was maximising rewards while performing softmax sampling for
action selection. Figure 38 shows that the DAI agent successfully minimises its variational free energy,
but as shown in Figure 37, the DAI agent does not solve the task and performs as well as a random agent.
Finally, Figure 35 shows sequences of images produced by the DAI agent after 500K training iterations.

43

Champion et al.

Note, while the agent does not solve that task, it understands the dynamics of the environment pretty
well. However, the agent struggles with images representing hearts.

By comparing Figures 21, 26 and 35, we see that the DAI agent with softmax sampling has a better
reconstruction than the CHMM agent with the ˚ _ϵ_ -greedy algorithm (which is presented in Figure 26).
In contrast, the DAI agent does not reconstruct the sequences of images as well as the HMM agent
performing random actions (which is presented in Figure 21).

Reconstruction (R):

Ground Truth (GT):

Figure 35: This figure illustrates the sequences of reconstructed images generated by the DAI after
500K training iterations. The columns alternate between the ground truth images and the reconstructed
images. Time passes vertically (from top to bottom), and within each column, the same action is executed
repeatedly.

1.0

0.8

0.6

0.4

0.2

0.0

Value_1

Value_2

Value_3

Value_4

Value_5

Value_6

1.0

0.8

0.6

0.4

0.2

0.0

Value_1

Value_2

Value_3

Value_4

Value_5

Value_6

1.0

0.8

0.6

0.4

0.2

0.0

Encoder_1
Encoder_2
Encoder_3
Encoder_4
Encoder_5
Encoder_mean
Encoder_variance

Transition_1
Transition_2
Transition_mean
Transition_variance

Critic_1
Critic_2
Critic_3
Critic_4

Model=CHMM, Action=Softmax,

Gain=Reward

(a)

Model=DAI, Action=Softmax,

Gain=Reward

(b)

Model=DAI, Action=Softmax,

Gain=Reward

(c)

Figure 36: (a) shows the similarity between the representations learned by a DQN and a CHMM maximising the reward and using softmax action selection. (b) shows the similarity between the representations
learned by a DQN and a DAI maximising the reward and using softmax action selection. (c) shows the
similarity between the representations learned by a CHMM and a DAI. Both maximise the reward and
use softmax action selection.

44

Deconstructing deep active inference.

As previously mentioned, the only DAI that did not crash during training used softmax action selection
and had a critic maximising reward. We can see in Figures 36b and 36a that the representational similarity
between this DAI and DQN is very close to the representational similarity between a DQN and a CHMM
using the same action selection and maximising reward. This is further confirmed by a comparison
between the CHMM and the DAI model in Figure 36c. Interestingly, we can see that the policy and critic
network learn similar representations, indicating that the policy network is learning correctly. However,
we previously inferred that the softmax action selection may be suboptimal and this seems to hold true
for the DAI as well, given that it is unable to solve the task.

DQN

_DAI_ [ _G_ <sup>4</sup> ]

Training Iterations

Figure 37: This figure illustrates the total amount of reward gathered by a DAI agent during the 500K iterations of

training. This agent was maximising rewards while sampling actions from a softmax function of the policy network

output. Put simply, the DAI agent does not solve the task and performs at the level of a random agent.

Training Iterations

Figure 38: This figure illustrates the variational free energy of the DAI agent during the 500K iterations of training.

This agent was maximising reward while sampling actions from a softmax function of the policy network output.

The agent was able to minimise its variational free energy.

45

Champion et al.

**5.** **Discussion** **of** **epistemic** **value**

In this section, we discuss the decomposition of the expected free energy into epistemic and extrinsic
value. More precisely, intrigued by the poor results of deep active inference agents (e.g., CHMM and
DAI), we seek to understand the damaging impact of the epistemic value on performance. Assuming the
following definition for the epistemic value:

**_EV_** = E _P_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|π_ )

- ln _P_ ( _sτ_ _|oτ_ ) _−_ ln _Q_ ( _sτ_ _|π_ )� _,_

we set up two experiments (c.f., Appendix C for details) in which all the disributions are stored in tables.
In other words, the following categorical distributions are represented using matrices: _P_ ( _oτ_ _|sτ_ ), _Q_ ( _sτ_ _|π_ ),
and _P_ ( _sτ_ _|oτ_ ).

In the first experiement, the prior over states _P_ ( _sτ_ ) is fixed, and the likelihood _P_ ( _oτ_ _|sτ_ ) is becoming
more and more uniform. While this is happening, the true posterior _P_ ( _sτ_ _|oτ_ ) becomes more similar to
the approximate posterior _Q_ ( _sτ_ _|π_ ), and the epistemic value decreases; see left panel of Figure 39. This is
the expected behaviour, and in this setting, the epistemic value encourages exploration.

In the second experiment, the likelihood _P_ ( _oτ_ _|sτ_ ) is fixed and has rather high entropy, while the
prior over states _P_ ( _sτ_ ) is shifted in one direction on the state axis. As a result of this, the true posterior
_P_ ( _sτ_ _|oτ_ ) becomes more different to the approximate posterior _Q_ ( _sτ_ _|π_ ), but this causes the epistemic value
to decrease; see Figure 39, right panel. This is a degenerate behaviour, as in this setting, the epistemic
value discourages exploration.

To sum up, the expected free energy decomposition into epistemic and extrinsic value  - as presented
in Equation (10) of Parr and Friston (2019) - seems to exhibit two very different behaviours depending
on how the distributions are defined, c.f., Figure 39. This is particularly important in the deep active
inference literature, which builds on this equation. For example, the graphs presented in Section 4.4.2
indicate that the CHMM agent minimising expected free energy is focusing almost exclusively on the
action “down”, i.e., it is not exploring, which leads to poor performance.

**6.** **Conclusion**

In this paper, we challenged the common assumption that deep active inference is a solved problem, by
highlighting the challenges that need to be resolved for the field to move forward. We reviewed eight
approaches implementing deep active inference: (a) _DAIMC_ by Fountas et al (2020), (b) _DAIV PG_ by
Millidge (2020), (c) _DAIRHI_ by Rood et al (2020), (d) _DAIHR_ by Sancaktar et al (2020), (e) _DAIFA_ by
Ueltzh¨offer (2018), (f) _DAIPOMDP_ by van der Himst and Lanillos (2020), (g) _DAISSM_ by C¸atal et al
(2020), and (h) the approach by Schneider et al (2022) for which the code was not available online.

Overall, those approaches brought interesting ideas such as: using deep neural networks to predict the
parameters of the distributions of interest, using Monte-Carlo tree search for planning in active inference,
and using a bootstrap estimate of the expected free energy to train a critic network. Yet, we struggled
to replicate some of the results claimed, e.g. training _DAIMC_ on the animal AI environment, and we
were unable to access code in some instances. Ideally, future research should draw inspiration from the
open science framework, by making the code that produced the claimed results open source. Also, the
definition of the expected free energy varied between papers. This suggests that additional research is
required to clarify the definition and justification of the expected free energy both in tabular and deep
active inference (c.f., Section 5 and Appendix C). To sum up, recent research on deep active inference
(Fountas et al, 2020; Millidge, 2020; Rood et al, 2020; Sancaktar et al, 2020; Ueltzh¨offer, 2018; van der
Himst and Lanillos, 2020; C¸atal et al, 2020) has made an important first step towards a complete deep
active inference agent, but a number of details still need to be honed, e.g., the definition and derivation
of the expected free energy, and reproducibilty of research. For more details, the reader is referred to
Section 2.

46

Deconstructing deep active inference.

Similarity of posteriors: _P_ ( _sτ_ _|oτ_ ) and _Q_ ( _sτ_ _|π_ )

Similarity of posteriors: _P_ ( _sτ_ _|oτ_ ) and _Q_ ( _sτ_ _|π_ )

Figure 39: The left-most figure shows the result of the first experiment where the likelihood was becoming
more and more uniform. In this setting, the epistemic value encourages exploration, as maximising the
epistemic value makes the true posterior _P_ ( _sτ_ _|oτ_ ) as different as possible to the approximate posterior
_Q_ ( _sτ_ _|π_ ), leftward on x-axis. However, the right-most figure illustrates the result of the second experiment
where the prior over states was changing. In this case, the epistemic value does not promote exploration, as
maximising the epistemic value makes the true posterior _P_ ( _sτ_ _|oτ_ ) as similar as possible to the approximate
posterior _Q_ ( _sτ_ _|π_ ), rightward on x-axis. Indeed, in this case, maximising the epistemic value causes
information to be lost.

After reviewing existing research, we tried to progressively implement a deep active inference agent.
First, we produced a variational auto-encoder agent that takes random actions. This agent was able to
learn a useful (latent) representation of the task. However, since the agent takes random actions, it was
unable to solve the task. Then, we added the transition network to create the hidden Markov model
(HMM) agent, which also takes random actions. The agent was able to learn a good represenation of the
task and of its dynamics, but was not able to solve the task.

Next, we tried to incorporate a critic network into the approach leading to the critical hidden Markov
model (CHMM). In this context, we experimented with several possible implementations of the expected
free energy. We also tried to remove the information gain and simply predict the reward. Additionally,
we implemented three types of action selection strategies, namely: best action according to the expected
free energy, softmax sampling, and epsilon-greedy.

When the epsilon-greedy algorithm was used, only the agent maximising reward was able to solve the
task. However, the agent requires more training iterations than a simple deep Q-network to learn the right
behaviour. This may be explained by the fact that the CHMM not only has to learn to solve the task,
but also learn the dynamics of the environment. When softmax sampling was used, all the agents failed
to solve the task. One of them perfoming even worse than an agent selecting random actions. Lastly,
when selecting the best action, only the reward maximising agent was able to solve the task. Importantly,
according to our experiments, the agent using the epsilon-greedy algorithm received the highest amount of
cumulated rewards and learned to solve the task the fastest. Additionally, the reward maximising agents
properly solve the task, but the quality of their latent representation is not as good as that of an HMM
agent. This may be due to the fact that when performing reward maximising actions, the data available
to learn the model of the environment lacks diversity, i.e., not enough exploration.

Next, we tried to incorporate a policy network into the approach leading to a complete deep active
inference agent (DAI). As for the CHMM agent, we experiemented with several possible implementations

47

Champion et al.

of the expected free energy, tried to remove the information gain and simply predict the reward, and
implemented three types of action selection strategies, namely: best action according to the expected free
energy, softmax sampling, and epsilon-greedy algorithm. When the epsilon-greedy algorithm was used or
the best action was selected, all agents failed to solve the task. When using softmax sampling, most of
the agents were numerically unstable and crashed, and the remaining agents failed to solve the task.

Finally, we compared the similarity of the representation learned by the layers of various models (e.g.,
deep Q-network, CHMM, DAI, etc...) using centered kernel alignment. This reveals that the DQN learns
general features in its first few layers, and very specialised features in its last two layers. The VAE learns
similar features to the DQN in the first layers, but differs from the DQN in the last two layers, reflecting
the difference in learning objectives. Similarly, the HMM learns similar features to the DQN in the first
layers, but differs from the representation learned by the DQN in the last two layers. Also, the mean and
variance representations learned by the HMM are different from their VAE counterparts, which suggests
that the transition network influences the latent representation of the model.

Additionally, when using the ˚ _ϵ_ -greedy algorithm for action selection, the representations learned by
the CHMM maximising reward is closer to the DQN than the CHMM minimising expected free energy is
to the DQN. Importantly, the critic network of the reward maximising CHMM retains more information
from the encoder than the CHMM minimising expected free energy. When the best action (according
to the critic network) is selected, the CHMM maximising reward and the CHMM minimising expected
free energy learn very similar representations except for the variance layers of the transition and encoder
network. While performing further inspection of those (variance) layers, we found that the transition
network of the reward maximising CHMM is a lot more certain than the transition network of the
CHMM minimising expected free energy. More precisely, the CHMM minimising expected free energy is
only confident about the world transition when performing action down. This suggests that the CHMM
minimising expected free energy always picks the action down, and does not gather enough data for the
other actions. Visualising the distribution of actions selected as training progresses corroborates this
story by showing that the agent minimising EFE almost exclusively picks action down. In contrast, the
CHMM maximising reward, keeps on selecting the actions left and right, which enables it to successfully
solve the task. The only difference between those two CHMMs is the epistemic value, which aims to make
the outputs of the transition and encoder network as close as possible. Thus, the CHMM minimising
expected free energy is picking a single action (down), and becomes an expert at predicting the future
when selecting this action. This effectively makes the KL divergence between the output of the transition
and encoder networks small. Additionally, when selecting the action down, the average reward is zero,
while for all the other actions, the expected reward will be negative. Therefore, if the CHMM has to stick
to a single action to keep the KL divergence small, then the action down is the most rewarding.

The same observations about the variance layers also applies to CHMMs using softmax sampling for
action selection. While this may explain why the model optimising the expected free energy does not
solve the task, it does not explain why the model maximising the reward cannot solve the task, and we
can hypothesise that those results may be due to the softmax action selection. More precisely, if the
values predicted by the critic network are very close to each other, then an agent using softmax sampling
may perform random actions. Note, increasing the gain parameter may help the agent to differentiate
between values close to each other.

In addition, the representational similarity between the DAI (maximising reward using softmax sampling) and DQN is very close to the representational similarity between a DQN with a CHMM (maximising
reward using softmax sampling). Also, the DAI’s policy and critic network learn similar representations,
which indicates that the policy network is learning correctly. Thus, the fact that the DAI (maximising
reward using softmax sampling) fails in the dSprites environment is likely due to the softmax action
selection and not to the representation learned by the model.

Lastly, our investigations of the expected free energy often used in deep active inference (Fountas et al,
2020), suggests that degenerate behaviour can arise from it, in certain situations. This could explain why

48

Deconstructing deep active inference.

adding epistemic value to our planning objective seems to have such a damaging impact on the agent’s
capacity to explore its environment and gain information. The use of this definition of the expected free
energy in the deep learning context may be at the core of our difficulty getting deep active inference to
work and may also explain some of the presentational uncertainties (e.g., additions of minus signs) found
in the deep active inference literature.

To conclude, the field of deep active inference has benefited from a large variety of ideas from the
reinforcement and deep learning literature. In the future, it would be valuable to provide an approach
that satisfies the following five desirata: (i) the approach is complete, i.e., it is composed of an encoder,
a decoder, a transition network, a policy network and (optionally) a critic network, (ii) the mathematics
underlying the approach is errorless and consistent with the free energy principle, (iii) the implementation
is consistent with the mathematics, (iv) the code is publicly available so that the correctness of the
implementation can be verified and the results reproduced, and (v) the approach is able to solve tasks
with a large input space, e.g. image-based tasks. We believe that such an approach will benefit the field
of deep active inference by providing a strong and reproducible baseline against which future research
could benchmark.

**Acknowledgments**

We thank Karl J. Friston, Thomas Parr, Lancelot Da Costa, and Zafeirios Fountas for useful discussions
and feedback surronding this paper, as well as for pointing us towards important resources such as their
new book and several papers.

**References**

Bellman R (1952) On the theory of dynamic programming. Proc Natl Acad Sci U S A 38(8):716–719

Bonheme L, Grzes M (2022) How do Variational Autoencoders Learn? Insights from Representational

Similarity. arXiv e-prints arXiv:2205.08399, `2205.08399`

Browne CB, Powley E, Whitehouse D, Lucas SM, Cowling PI, Rohlfshagen P, Tavener S, Perez D,

Samothrakis S, Colton S (2012) A survey of monte carlo tree search methods. IEEE Transactions on
Computational Intelligence and AI in Games 4(1):1–43

C¸atal O, Wauthier S, De Boom C, Verbelen T, Dhoedt B (2020) Learning generative state space models

for active inference. Frontiers in Computational Neuroscience 14:574,372

Champion T, Grze´s M, Bowman H (2021) Realizing Active Inference in Variational Message Passing: The

Outcome-Blind Certainty Seeker. Neural Computation 33(10):2762–2826, DOI 10.1162/neco ~~a~~ ~~0~~ 1422,
URL `[https://doi.org/10.1162/neco_a_01422](https://doi.org/10.1162/neco_a_01422)`, `[https://direct.mit.edu/neco/article-pdf/33/](https://direct.mit.edu/neco/article-pdf/33/10/2762/1963368/neco_a_01422.pdf)`
```
 10/2762/1963368/neco_a_01422.pdf

```

Champion T, Bowman H, Grze´s M (2022a) Branching time active inference: Empirical study and com
plexity class analysis. Neural Networks 152:450–466, DOI https://doi.org/10.1016/j.neunet.2022.05.010,
URL `[https://www.sciencedirect.com/science/article/pii/S0893608022001824](https://www.sciencedirect.com/science/article/pii/S0893608022001824)`

Champion T, Da Costa L, Bowman H, Grze´s M (2022b) Branching time active inference: The theory and

its generality. Neural Networks 151:295–316, DOI https://doi.org/10.1016/j.neunet.2022.03.036, URL

```
 https://www.sciencedirect.com/science/article/pii/S0893608022001149

```

Champion T, Grze´s M, Bowman H (2022c) Branching Time Active Inference with Bayesian Filtering.

Neural Computation 34(10):2132–2144, DOI 10.1162/neco ~~a~~ ~~0~~ 1529, URL `[https://doi.org/10.1162/](https://doi.org/10.1162/neco_a_01529)`

[49](https://doi.org/10.1162/neco_a_01529)

[Champion](https://doi.org/10.1162/neco_a_01529) et al.

`[neco_a_01529](https://doi.org/10.1162/neco_a_01529)`, `[https://direct.mit.edu/neco/article-pdf/34/10/2132/2042425/neco_a_01529.](https://direct.mit.edu/neco/article-pdf/34/10/2132/2042425/neco_a_01529.pdf)`
```
 pdf

```

Champion T, Grze´s M, Bowman H (2022d) Multi-modal and multi-factor branching time active inference.

DOI 10.48550/ARXIV.2206.12503, URL `[https://arxiv.org/abs/2206.12503](https://arxiv.org/abs/2206.12503)`

Cortes C, Mohri M, Rostamizadeh A (2012) Algorithms for Learning Kernels Based on Centered Align
ment. J Mach Learn Res 13(1):795–828

Costa LD, Parr T, Sajid N, Veselic S, Neacsu V, Friston K (2020a) Active inference on discrete state
spaces: a synthesis. `2001.07203`

Costa LD, Sajid N, Parr T, Friston K, Smith R (2020b) The relationship between dynamic programming

and active inference: the discrete, finite-horizon case. `2009.08111`

Cristianini N, Shawe-Taylor J, Elisseeff A, Kandola JS (2002) On Kernel-Target Alignment. In:

Dietterich TG, Becker S, Ghahramani Z (eds) Advances in Neural Information Processing Systems, vol 14, MIT Press, Vancouver, Canada, pp 367–373, URL `[http://papers.nips.cc/paper/](http://papers.nips.cc/paper/1946-on-kernel-target-alignment.pdf)`
```
 1946-on-kernel-target-alignment.pdf

```

Cullen M, Davey B, Friston KJ, Moran RJ (2018) Active inference in openai gym: A paradigm for

computational investigations into psychiatric illness. Biological Psychiatry: Cognitive Neuroscience
and Neuroimaging 3(9):809  - 818, DOI https://doi.org/10.1016/j.bpsc.2018.06.010, URL `[http://www.](http://www.sciencedirect.com/science/article/pii/S2451902218301617)`
`[sciencedirect.com/science/article/pii/S2451902218301617](http://www.sciencedirect.com/science/article/pii/S2451902218301617)`, computational Methods and Modeling in Psychiatry

Doersch C (2016) Tutorial on variational autoencoders. `1606.05908`

FitzGerald THB, Dolan RJ, Friston K (2015) Dopamine, reward learning, and active inference. Frontiers in

Computational Neuroscience 9:136, DOI 10.3389/fncom.2015.00136, URL `[https://www.frontiersin.](https://www.frontiersin.org/article/10.3389/fncom.2015.00136)`
```
 org/article/10.3389/fncom.2015.00136

```

Fountas Z, Sajid N, Mediano PAM, Friston K (2020) Deep active inference agents using Monte-Carlo

methods. `2006.04176`

Friston K, FitzGerald T, Rigoli F, Schwartenbeck P, Doherty JO, Pezzulo G (2016) Active inference and

learning. Neuroscience & Biobehavioral Reviews 68:862 – 879, DOI https://doi.org/10.1016/j.neubiorev.
2016.06.022

Gretton A, Bousquet O, Smola A, Sch¨olkopf B (2005) Measuring Statistical Dependence with Hilbert
Schmidt Norms. In: Jain S, Simon HU, Tomita E (eds) Algorithmic Learning Theory, Springer Berlin
Heidelberg, pp 63–77

van Hasselt H, Guez A, Silver D (2015) Deep reinforcement learning with double Q-learning. `1509.06461`

Higgins I, Matthey L, Pal A, Burgess C, Glorot X, Botvinick M, Mohamed S, Lerchner A (2017) beta
VAE: Learning basic visual concepts with a constrained variational framework. In: 5th International
Conference on Learning Representations, ICLR 2017, Toulon, France, April 24-26, 2017, Conference
Track Proceedings, OpenReview.net, URL `[https://openreview.net/forum?id=Sy2fzU9gl](https://openreview.net/forum?id=Sy2fzU9gl)`

van der Himst O, Lanillos P (2020) Deep active inference for partially observable mdps. CoRR

abs/2009.03622, URL `[https://arxiv.org/abs/2009.03622](https://arxiv.org/abs/2009.03622)`, `2009.03622`

50

Deconstructing deep active inference.

Itti L, Baldi P (2009) Bayesian surprise attracts human attention. Vision Research 49(10):1295 - 1306,

DOI https://doi.org/10.1016/j.visres.2008.09.007, URL `[http://www.sciencedirect.com/science/](http://www.sciencedirect.com/science/article/pii/S0042698908004380)`
`[article/pii/S0042698908004380](http://www.sciencedirect.com/science/article/pii/S0042698908004380)`, visual Attention: Psychophysics, electrophysiology and neuroimaging

Kingma DP, Welling M (2014) Auto-Encoding Variational Bayes. In: International Conference on Learn
ing Representations, Banff, Canada, vol 2, URL `[http://arxiv.org/abs/1312.6114](http://arxiv.org/abs/1312.6114)`

Koller D, Friedman N (2009) Probabilistic graphical models: principles and techniques. MIT press

Kornblith S, Norouzi M, Lee H, Hinton G (2019) Similarity of Neural Network Representations Revisited.

In: Chaudhuri K, Salakhutdinov R (eds) Proceedings of the 36th International Conference on Machine
Learning, PMLR, Long Beach, USA, Proceedings of Machine Learning Research, vol 97, pp 3519–3529,
URL `[http://proceedings.mlr.press/v97/kornblith19a.html](http://proceedings.mlr.press/v97/kornblith19a.html)`

Lample G, Chaplot DS (2016) Playing fps games with deep reinforcement learning. `1609.05521`

Lanillos P, Cheng G, et al (2020) Robot self/other distinction: active inference meets neural networks

learning in a mirror. arXiv preprint arXiv:200405473

Maheswaranathan N, Williams A, Golub M, Ganguli S, Sussillo D (2019) Universality and individu
ality in neural dynamics across large populations of recurrent networks. In: Wallach H, Larochelle
H, Beygelzimer A, d'Alch´e-Buc F, Fox E, Garnett R (eds) Advances in Neural Information Processing Systems, Curran Associates, Inc., vol 32, URL `[https://proceedings.neurips.cc/paper/2019/](https://proceedings.neurips.cc/paper/2019/file/5f5d472067f77b5c88f69f1bcfda1e08-Paper.pdf)`
```
 file/5f5d472067f77b5c88f69f1bcfda1e08-Paper.pdf

```

Matthey L, Higgins I, Hassabis D, Lerchner A (2017) dsprites: Disentanglement testing sprites dataset.

https://github.com/deepmind/dsprites-dataset/

Millidge B (2019) Combining active inference and hierarchical predictive coding: A tutorial introduction

and case study. URL `[https://doi.org/10.31234/osf.io/kf6wc](https://doi.org/10.31234/osf.io/kf6wc)`

Millidge B (2020) Deep active inference as variational policy gradients. Journal of Mathematical Psychol
ogy 96:102,348, DOI https://doi.org/10.1016/j.jmp.2020.102348, URL `[http://www.sciencedirect.](http://www.sciencedirect.com/science/article/pii/S0022249620300298)`
```
 com/science/article/pii/S0022249620300298

```

Mnih V, Kavukcuoglu K, Silver D, Graves A, Antonoglou I, Wierstra D, Riedmiller M (2013) Playing

atari with deep reinforcement learning. `1312.5602`

Oliver G, Lanillos P, Cheng G (2019) Active inference body perception and action for humanoid robots.

arXiv preprint arXiv:190603022

Parr T, Friston KJ (2019) Generalised free energy and active inference. Biological cybernetics 113(5
6):495–513

Pezzato C, Hernandez C, Wisse M (2020) Active inference and behavior trees for reactive action planning

and execution in robotics. `2011.09756`

Rezende DJ, Mohamed S, Wierstra D (2014) Stochastic Backpropagation and Approximate Inference in

Deep Generative Models. In: Xing EP, Jebara T (eds) Proceedings of the 31st International Conference
on Machine Learning, PMLR, Bejing, China, Proceedings of Machine Learning Research, vol 32, pp
1278–1286, URL `[http://proceedings.mlr.press/v32/rezende14.html](http://proceedings.mlr.press/v32/rezende14.html)`

51

Champion et al.

Robert P, Escoufier Y (1976) A Unifying Tool for Linear Multivariate Statistical Methods: The RV
Coefficient. Journal of the Royal Statistical Society Series C (Applied Statistics) 25(3):257–265, URL

```
 http://www.jstor.org/stable/2347233

```

Rood T, van Gerven M, Lanillos P (2020) A deep active inference model of the rubber-hand illusion.

In: Verbelen T, Lanillos P, Buckley CL, De Boom C (eds) Active Inference, Springer International
Publishing, Cham, pp 84–91

Sancaktar C, van Gerven M, Lanillos P (2020) End-to-end pixel-based deep active inference for body

perception and action. `2001.05847`

Schneider T (N.D.) Active inference for robotic manipulation, unpublished

Schneider T, Belousov B, Abdulsamad H, Peters J (2022) Active inference for robotic manipulation. arXiv

preprint arXiv:220610313

Schwartenbeck P, Passecker J, Hauser TU, FitzGerald THB, Kronbichler M, Friston K (2018) Com
putational mechanisms of curiosity and goal-directed exploration. bioRxiv DOI 10.1101/411272,
URL `[https://www.biorxiv.org/content/early/2018/09/07/411272](https://www.biorxiv.org/content/early/2018/09/07/411272)`, `[https://www.biorxiv.org/](https://www.biorxiv.org/content/early/2018/09/07/411272.full.pdf)`
```
 content/early/2018/09/07/411272.full.pdf

```

Silver D, Huang A, Maddison CJ, Guez A, Sifre L, van den Driessche G, Schrittwieser J, Antonoglou I,

Panneershelvam V, Lanctot M, Dieleman S, Grewe D, Nham J, Kalchbrenner N, Sutskever I, Lillicrap
TP, Leach M, Kavukcuoglu K, Graepel T, Hassabis D (2016) Mastering the game of go with deep
neural networks and tree search. Nature 529(7587):484–489, DOI 10.1038/nature16961, URL `[https:](https://doi.org/10.1038/nature16961)`
```
 //doi.org/10.1038/nature16961

```

Sutton RS, Barto AG, et al (1998) Introduction to reinforcement learning. MIT press Cambridge

Ueltzh¨offer K (2018) Deep active inference. Biol Cybern 112(6):547–573, DOI 10.1007/s00422-018-0785-7,

URL `[https://doi.org/10.1007/s00422-018-0785-7](https://doi.org/10.1007/s00422-018-0785-7)`

52

**Appendix** **A:** **Notation**

|Symbol|Meaning|
|---|---|
|_sτ_, _oτ_, _rτ_, _aτ_|State, observation, reward and action at time step _τ_, respectively.|
|_or_<br>_τ_, ˆ_sr_<br>_τ_, ˚_or_<br>_τ_|An observation in which a reward has been encoded as explained in Figure 40, the hidden<br>state sampled from the encoder when feeding _or_<br>_τ_ as input, and the observation reconstructed<br>by the decoder from the output of the transition network, respectively.|
|ˆ_sτ_, ˆ_oτ_|A state sampled from the encoder at time step _τ_ when _oτ_ is provided as input, and the image<br>reconstructed by the decoder at time _τ_ when using ˆ_sτ_ as input, respectively.|
|˚_oτ_|The observations at time step _τ_ predicted by the transition network.|
|_si_:_j_, _oi_:_j_, _ai_:_j_|Respectively, the set of states, observations, and actions between time step _i_ and _j_ (included).|
|_π_, _πτ_, _π′_|A policy, i.e. a sequence of actions, the action prescribed by the policy at time step _τ_, and<br>another policy whose size is smaller or equal than the size of _π_, respectively.|
|_A_, Π|The set of possible actions, and the set of possible policies, respectively.|
|A_s_|The set of all anscestors of a node _s_.|
|#_A,_ #_C,_ #_S,_ #_O_|The number of actions, channels, states and observations, respectively.|
|_Qθa_, ˆ_Q_ˆ_θa_|The Q-network parameterised by _θa_, and the target network parameterised by ˆ_θa_|
|_Gθa_, ˆ_G_ˆ_θa_|The critic network parameterised by _θa_, and the target network parameterised by ˆ_θa_.|
|_Eφs_, _Dθo_|The encoder network parameterised by _φs_, and the decoder network parameterised by _θo_.|
|_Pφa_|The policy network parameterised by _φa_.|
|_Tθs_, _Tθo_|The transition network parameterised by _θs_ or _θo_, respectively.|
|_θ_, _φ_|All the parameters of the generative model, and the variational distribution, respectively.|
|_a_, _b_, _c_, _d_|Four hyperparameters involved in the computation of _ωt_.|
|_N_(_sτ, aτ_)|The number of times action _aτ_ was explored in state _sτ_.|
|_t_, _γ_|The present time step, and the discount factor, respectively.|
|_ζ_, _ψ_|The precision of the prior over actions, and the precision of the prior preferences.|
|_ϵ_, ˆ_ϵ_|The random variable used in the re-parameterisation trick, and a sample of epsilon.|
|˚_ϵ_|The probability of selecting a random actions when using the ˚_ϵ_-greedy algorithm.|
|_Tdec_|A hyperparameter deﬁning the threshold value corresponding to a clear winner during MCTS.|
|_G_(_π_), _Gτ_(_π_)|The expected free energy (EFE) of policy _π_, and the EFE received at time<br>step _τ_ when following policy _π_, respectively.|
|¯**_G_**_s_, **_G_**aggr<br>_s_<br>, **_G_**_s_, **_N_**_s_|The average EFE, the aggregated EFE, the EFE, and the number of visits<br>of a node _s_, respectively.|
|_µo, σo, µa, σa_|The mean and variance vectors predicted by the encoder and policy networks of the _DAIFA_.|
|_µ_, _σ_|The mean and variance of the Gaussian distribution over _st_ predicted by the encoder.|
|˚_µ_, ˚_σ_|The mean and variance of the Gaussian distribution over _st_+1 predicted by the transition.|
|ˆ_µ_, ˆ_σ_|The mean and variance of the Gaussian distribution over _st_+1 predicted by the encoder.|
|ˆ_π_|The parameters of the categorical distribution over _at_ predicted by the policy network.|
|_ωt_|The top-down attention parameter modulating the precision of the transition mapping.|
|[ condition ]|An indicator function that equals one if the condition is satisﬁed and zero otherwise.|
|_σ_[ _•_ ]|The softmax function.|
|Cat(_x_;_ φx_)|A categorical distribution over _x_ parameterised by _φx_.|
|Bernoulli(_x_;_ φx_)|A Bernoulli distribution over _x_ parameterised by _φx_.|
|_B_ernoulli(_x_;_ φx_)|A product of Bernoulli distributions over _x_ parameterised by _φx_.|
|_N_(_x_;_ µx, σx_)|A multivariate Gaussian over _x_ parameterised by a mean vector _µx_, and<br>a diagonal covariance matrix whose diagonal elements are _σx_.|
|_X_<br>_i→Y_, _X m_<br>_→Y_<br>|_X_ is fed as _input_ to _Y_, and the _mean_ of the distribution predicted by _X_ is fed as input to _Y_ .|
|_X_<br>_s→Y_, _X →Y_|a _sample_ from the distribution predicted by _X_ is fed as input to _Y_, and _X_ outputs _Y_ .|

Table 1: Notation of Sections 2 and 3.

Champion et al.

**Appendix** **B:** _DAIMC_ **discrepancies** **between** **the** **paper** **and** **the** **code**

In this section, we focus on the authors’ implementation of _DAIMC_ available on GitHub: `[https://](https://github.com/zfountas/deep-active-inference-mc/)`
`[github.com/zfountas/deep-active-inference-mc/](https://github.com/zfountas/deep-active-inference-mc/)` . First, according to a personal communication
with one of the authors, the code available on GitHub (on the 6th of June 2022) is not the same as the
one used to run the experiments of the paper. Below, we describe the discrepancies between the paper
and the code. For example, the computation of _ωt_ in the paper is as follows:

_<u>a</u>_
_ωt_ =
1 + exp( _−_ <sup>_<u>b−Dt</u>_</sup> ) <sup>+</sup> <sup>_d,_</sup>
_c_

while the code uses the following formula:

_ωt_ = _a ×_

<u>1</u>
1 _−_
1 + exp <u>�</u> _−_ <sup>_<u>Dt−b</u>_</sup>

_c_

<u>�</u>

+ _d._

_c_

Also, the paper states that MCTS is perfomed to compute the prior over policies during training. However, in the code, MCTS is only used when testing the model, i.e., no MCTS when training the agent.
Additionally, the paper states that actions are selected by sampling from:

_<u>N</u>_ <u>(ˆ</u> _<u>st, at</u>_ <u>)</u>
_P_ ˜( _at_ ) = <u>�</u>
_a_ ˆ _t_ <sup>_N_</sup> <sup>(ˆ</sup> <sup>_st,_</sup> <sup>ˆ</sup> <sup>_at_</sup> <sup>)</sup> <sup>_._</sup>

However, the code selects an entire sequence of actions _π_ = (˚ _at,_ ˚ _at_ +1 _, ...,_ ˚ _at_ + _n_ ) recursively from the root
node in the tree. At each step in the recursion, the node with the highest number of visits ˚ _aτ_ is selected.
Then, actions cancelling each other are removed from the sequence, e.g., if _aτ_ = _LEFT_ and _aτ_ +1 =
_RIGHT_ then both actions are removed from the sequence. This procedure generates a new sequence
of actions _π_ <sup>_′_</sup> of equal or smaller length. Finally, the entire sequence of actions _π_ <sup>_′_</sup> is performed in the
environment. This avoids the repetition of the planning process for each action-perception cycle (saving
computational time), however, this also requires domain knowledge (to remove actions that cancel each
other out).

Additionally, in the paper, experiments are run on both the dSprites environment and the animal AI
environment. However, the code does not allow the replication of the results on the animal AI environment,
i.e., the code handling the animal AI environment has been removed. In addition, the evaluation of the
expected free energy is non trivial (see below) and the details are not discussed in the paper. Before
explaining how the terms of the EFE are computed, we introduce notation that allows us to express those
computational steps concisely. For example, we note:

_o_ <sup>_r_</sup> _t_

_→i_ Encoder _→s_ Transition _→m_ ˚ _s_ <sup>_r_</sup> _t_ +1 <sup>_,_</sup>

meaning that _o_ <sup>_r_</sup> _t_ <sup>is</sup> <sup>used</sup> <sup>as</sup> <sup>_input_</sup> <sup>(</sup> <sup>_→i_</sup> <sup>)</sup> <sup>for</sup> <sup>the</sup> <sup>encoder,</sup> <sup>then</sup> <sup>a</sup> <sup>state</sup> <sup>is</sup> <sup>_sampled_</sup> <sup>(</sup> <sup>_→s_</sup> <sup>)</sup> <sup>from</sup> <sup>the</sup> <sup>distribution</sup>

predicted by the encoder and used as input for the transition network, finally, the _mean_ ( _→_ <sup>_m_</sup> ) of the
distribution predicted by the transition network is used as a maximum aposteriori estimate of ˚ _s_ <sup>_r_</sup> _t_ +1 <sup>.</sup> <sup>Note,</sup>

meaning that _o_ <sup>_r_</sup> _t_

distribution predicted by the transition network is used as a maximum aposteriori estimate of ˚ _s_ <sup>_r_</sup> _t_ +1 <sup>.</sup> <sup>Note,</sup>

the transition network takes two inputs (i.e., a state and an action), when using our concise notation we
implicitly assume that the actions prescribed by the policy <sup>8</sup> _π_ are provided as input to the transition
network. Also, for each time step _τ_, the reward _rτ_ collected by the agent is encoded in the pixels of the
image _oτ_ as explained in Figure 40, leading to a new image _o_ <sup>_r_</sup> _τ_ <sup>.</sup> <sup>As</sup> <sup>illustrated</sup> <sup>on</sup> <sup>the</sup> <sup>right</sup> <sup>of</sup> <sup>Figure</sup> <sup>41,</sup>

image _oτ_ as explained in Figure 40, leading to a new image _o_ <sup>_r_</sup> _τ_ <sup>.</sup> <sup>As</sup> <sup>illustrated</sup> <sup>on</sup> <sup>the</sup> <sup>right</sup> <sup>of</sup> <sup>Figure</sup> <sup>41,</sup>

the encoder/decoder networks are trained to predict the resulting images _o_ <sup>_r_</sup> _τ_ <sup>.</sup> <sup>The</sup> <sup>computation</sup> <sup>of</sup> <sup>the</sup>

first term in equation (8) is illustrated on the left of Figure 41. Concisely, we have:

_o_ <sup>_r_</sup> _t_

_→i_ Encoder _→s_ Transition _→s_ Decoder _→m_ ˚ _o_ <sup>_r_</sup> _t_ +1 <sup>_._</sup>

8. _π_ is the policy for which the expected free energy is being computed.

54

Deconstructing deep active inference.

Figure 40: This figure illustrates how the reward _rτ_ _∈_ [ _−_ 1 _,_ 1] is encoded in image _oτ_ . On the left, the
plus and minus signs shows where the reward will be encoded in the image if the reward is positive or
negative, respectively. In the middle, a positive reward is being encoded on the left side of the image. On
the right, a negative reward is being encoded on the right of the image.

Next, a matrix (˚ _rt_ +1) encoding the maximum reward that the agent can gather is used as parameter of
Bernoulli distributions to compute the logarithm of the probability (i.e., **_L_** ) of the three first rows of
the reconstructed image ˚ _o_ <sup>_r_</sup> _t_ +1 <sup>.</sup> <sup>Note,</sup> <sup>as</sup> <sup>explained</sup> <sup>in</sup> <sup>Figure</sup> <sup>40,</sup> <sup>the</sup> <sup>first</sup> <sup>three</sup> <sup>rows</sup> <sup>contain</sup> <sup>the</sup> <sup>predicted</sup>

reward obtained at time _t_ + 1. Finally, the mean of **_L_** is then computed and is multiplied by ten to get
E _Q_ ˜[ln _P_ <sup>˜</sup> ( _oτ_ _|π_ )]. Similarly, the computation of _H_ [ _Q_ ( _sτ_ _|π_ )] proceeds as follows:

_o_ <sup>_r_</sup> _t_

_→i_ Encoder _→s_ Transition _→_ ˚ _µ,_ ln˚ _σ,_

where _Q_ ( _sτ_ _|π_ ) is equated with _N_ ( _sτ_ ;˚ _µ,_ ˚ _σ_ ), and an analytical solution is used to compute the entropy of
_Q_ ( _sτ_ _|π_ ). Next, the computation of _H_ [ _Q_ ( _oτ_ _|sτ_ _, π_ )] proceeds as follows:

_o_ <sup>_r_</sup> _t_

_→i_ Encoder _→s_ Transition _→s_ Decoder _→m_ ˚ _o_ <sup>_r_</sup> _t_ +1 <sup>_,_</sup>

where observation ˚ _o_ <sup>_r_</sup> _t_

where observation ˚ _o_ <sup>_r_</sup> _t_ +1 <sup>is</sup> <sup>equated</sup> <sup>to</sup> <sup>the</sup> <sup>parameters</sup> <sup>of</sup> <sup>the</sup> <sup>Bernoulli</sup> <sup>distribution</sup> <sup>_Q_</sup> <sup>(</sup> <sup>_oτ_</sup> <sup>_|sτ_</sup> <sup>_, π_</sup> <sup>),</sup> <sup>and</sup> <sup>an</sup>

analytical solution is used to compute _H_ [ _Q_ ( _oτ_ _|sτ_ _, π_ )]. Surprisingly, another observation ˚ _o_ <sup>_r_</sup> _t_ +1 <sup>sampled</sup>

analytical solution is used to compute _H_ [ _Q_ ( _oτ_ _|sτ_ _, π_ )]. Surprisingly, another observation ˚ _o_ <sup>_r_</sup> _t_ +1 <sup>sampled</sup>

exactly as before is equated to the parameters of the Bernoulli distribution _Q_ ( _oτ_ _|sτ_ _, θ, π_ ), and the same
analytical solution is used to compute _H_ [ _Q_ ( _oτ_ _|sτ_ _, θ, π_ )]. Finally, _H_ [ _Q_ ( _sτ_ _|oτ_ _, π_ )] is computed by feeding
˚ _o_ <sup>_r_</sup> _t_ +1 <sup>back</sup> <sup>into</sup> <sup>the</sup> <sup>encoder</sup> <sup>to</sup> <sup>obtain</sup> <sup>the</sup> <sup>mean</sup> <sup>and</sup> <sup>log-variance</sup> <sup>of</sup> <sup>the</sup> <sup>Gaussian</sup> <sup>distribution</sup> <sup>_Q_</sup> <sup>(</sup> <sup>_sτ_</sup> <sup>_|oτ_</sup> <sup>_, π_</sup> <sup>),</sup>

˚ _o_ <sup>_r_</sup> _t_ +1 <sup>back</sup> <sup>into</sup> <sup>the</sup> <sup>encoder</sup> <sup>to</sup> <sup>obtain</sup> <sup>the</sup> <sup>mean</sup> <sup>and</sup> <sup>log-variance</sup> <sup>of</sup> <sup>the</sup> <sup>Gaussian</sup> <sup>distribution</sup> <sup>_Q_</sup> <sup>(</sup> <sup>_sτ_</sup> <sup>_|oτ_</sup> <sup>_, π_</sup> <sup>),</sup>

and the analytical solution for the entropy of a Gaussian is used to compute _H_ [ _Q_ ( _sτ_ _|oτ_ _, π_ )].

In summary, two samples of ˚ _o_ <sup>_r_</sup> _t_ +1 <sup>(sampled</sup> <sup>as</sup> <sup>described</sup> <sup>in</sup> <sup>Figure</sup> <sup>40)</sup> <sup>have</sup> <sup>been</sup> <sup>equated</sup> <sup>to</sup> <sup>the</sup>

parameters of two diferent distributions, i.e., _Q_ ( _oτ_ _|sτ_ _, θ, π_ ), and _Q_ ( _oτ_ _|sτ_ _, π_ ). Additionally, a third sample
of ˚ _o_ <sup>_r_</sup> _t_ +1 <sup>(sampled</sup> <sup>in</sup> <sup>the</sup> <sup>same</sup> <sup>way)</sup> <sup>has</sup> <sup>also</sup> <sup>been</sup> <sup>used</sup> <sup>as</sup> <sup>input</sup> <sup>to</sup> <sup>the</sup> <sup>distribution</sup> <sup>_P_</sup> <sup>˜(</sup> <sup>_oτ_</sup> <sup>_|π_</sup> <sup>).</sup> <sup>Lastly,</sup> <sup>while</sup>

In summary, two samples of ˚ _o_ <sup>_r_</sup> _t_

of ˚ _o_ <sup>_r_</sup> _t_ +1 <sup>(sampled</sup> <sup>in</sup> <sup>the</sup> <sup>same</sup> <sup>way)</sup> <sup>has</sup> <sup>also</sup> <sup>been</sup> <sup>used</sup> <sup>as</sup> <sup>input</sup> <sup>to</sup> <sup>the</sup> <sup>distribution</sup> <sup>_P_</sup> <sup>˜(</sup> <sup>_oτ_</sup> <sup>_|π_</sup> <sup>).</sup> <sup>Lastly,</sup> <sup>while</sup>

Fountas et al (2020) defines the EFE as in (8), the code turns a plus into a minus, leading to the following
definition of the EFE:

- ln _P_ <sup>˜</sup> ( _oτ_ _|π_ )�

- ln _P_ <sup>˜</sup> ( _oτ_ _|π_ )

_Gτ_ ( _π_ ) = _−_ E _Q_ ˜

_−_ E _Q_ ( _θ|π_ )

E _Q_ ( _oτ_ _|θ,π_ )

- _H_ [ _Q_ ( _sτ_ _|oτ_ _, π_ )]

- _−_ _H_ [ _Q_ ( _sτ_ _|π_ )]

- _H_ [ _Q_ ( _oτ_ _|sτ_ _, θ, π_ )] _−_ E _Q_ ( _sτ_ _|π_ )

- _H_ [ _Q_ ( _oτ_ _|sτ_ _, θ, π_ )]

_H_

- - <sup>�</sup>
_Q_ ( _oτ_ _|sτ_ _, π_ ) _,_

+ E _Q_ ( _θ|π_ ) _Q_ ( _sτ_ _|θ,π_ )

where the red minus was a plus.

55

Champion et al.

|Col1|r<br>t+1<br>o<br>t+1|Col3|
|---|---|---|
||_rt_+1 <br>_ot_+1||
||||

The variational

auto-encoder
at time _t_ + 1
is used to train

the encoder
and decoder

networks.

Figure 41: This figure illustrates the computation of E _Q_ ˜[ln _P_ <sup>˜</sup> ( _oτ_ _|π_ )] in (the code of) Fountas et al (2020).
The environment at time _t_ provides the agent with an image _ot_ and a reward _rt_ randomly sampled from
the interval [ _−_ 1; 1]. Then, action ˆ _at_ is performed in the environment and the agent observes an image _ot_ +1
and a reward _rt_ +1, where _rt_ +1 is computed according to the function presented in the center of the image.
Next, the reward at time _t_ and _t_ + 1 are encoded in the images received at time _t_ and _t_ + 1, respectively,
c.f., Figure 40 for details about the encoding. The encoded image at time _t_ + 1 (i.e., _o_ <sup>_r_</sup> _t_ +1 <sup>)</sup> <sup>is</sup> <sup>then</sup> <sup>fed</sup> <sup>into</sup>

the encoder, the re-parameterisation trick is then used to sample a state from the variational posterior.
This state is fed into the decoder which tries to reconstruct the image inputed into the encoder. Once

_o_ ˆ <sup>_r_</sup> _t_

_o_ ˆ <sup>_r_</sup> _t_ +1 <sup>has</sup> <sup>been</sup> <sup>computed,</sup> <sup>the</sup> <sup>weights</sup> <sup>of</sup> <sup>the</sup> <sup>encoder</sup> <sup>and</sup> <sup>decoder</sup> <sup>are</sup> <sup>learned</sup> <sup>using</sup> <sup>back-propagation.</sup> <sup>On</sup>

the other hand, the encoded image at time _t_ (i.e., _o_ <sup>_r_</sup> _t_ <sup>)</sup> <sup>is</sup> <sup>used</sup> <sup>to</sup> <sup>compute</sup> <sup>E</sup> _Q_ <sup>˜[ln</sup> <sup>_P_</sup> <sup>˜(</sup> <sup>_oτ_</sup> <sup>_|π_</sup> <sup>)].</sup> <sup>More</sup> <sup>precisely,</sup>

the other hand, the encoded image at time _t_ (i.e., _o_ <sup>_r_</sup> _t_ <sup>)</sup> <sup>is</sup> <sup>used</sup> <sup>to</sup> <sup>compute</sup> <sup>E</sup> _Q_ <sup>˜[ln</sup> <sup>_P_</sup> <sup>˜(</sup> <sup>_oτ_</sup> <sup>_|π_</sup> <sup>)].</sup> <sup>More</sup> <sup>precisely,</sup>

the _o_ <sup>_r_</sup> _t_ <sup>is</sup> <sup>fed</sup> <sup>into</sup> <sup>the</sup> <sup>encoder,</sup> <sup>and</sup> <sup>a</sup> <sup>state</sup> <sup>is</sup> <sup>sampled</sup> <sup>from</sup> <sup>the</sup> <sup>variational</sup> <sup>posterior</sup> <sup>_Qφ_</sup> _s_ <sup>(</sup> <sup>_st_</sup> <sup>).</sup> <sup>This</sup> <sup>state</sup>

is then fed as input into the transition network along with the action prescribed by _π_ at time _t_, i.e., _at_ .
A state at time _t_ + 1 can then be sampled from the distribution predicted by the transition network.
This state is then inputed into the decoder, which outputs ˚ _o_ <sup>_r_</sup> _t_ +1 <sup>.</sup> <sup>Next,</sup> <sup>a</sup> <sup>matrix</sup> <sup>(i.e., ˚</sup> <sup>_rt_</sup> <sup>+1)</sup> <sup>encoding</sup> <sup>the</sup>

maximum reward that the agent can gather is used as a parameter of a Bernoulli distribution to compute
the logarithm of the probability (i.e., **_L_** ) of the first three rows of _o_ ˆ <sup>_r_</sup> _t_ +1 <sup>,</sup> <sup>i.e.,</sup> <sup>_R_</sup> <sup>(˚</sup> <sup>_or_</sup> _t_ +1 <sup>).</sup> <sup>The</sup> <sup>mean</sup> <sup>of</sup> <sup>**_L_**</sup> <sup>is</sup>

then computed and is multiplied by ten to obtain E _Q_ ˜[ln _P_ <sup>˜</sup> ( _oτ_ _|π_ )].

<sup>_r_</sup> _t_ +1 <sup>,</sup> <sup>i.e.,</sup> <sup>_R_</sup> <sup>(˚</sup> <sup>_or_</sup> _t_

56

Deconstructing deep active inference.

**Appendix** **C:** **Analysis** **of** **the** **epistemic** **value**

In this appendix, we study the expected free energy decomposition into epistemic and extrinsic value
as given in Equation (10) of Parr and Friston (2019). A particular reason for being interrested in this
formulation is that it is the version of the expected free energy that has the most influenced the deep
active inference approaches, such as Fountas et al (2020). Starting with the definition of the expected
free energy, see Equation (14) in the main-body:

_Gτ_ ( _π_ ) = E _P_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|π_ )

= E _P_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|π_ )

- ln _Q_ ( _sτ_ _|π_ ) _−_ ln _P_ ( _oτ_ _, sτ_ )�

- ln _Q_ ( _sτ_ _|π_ ) _−_ ln _P_ ( _sτ_ _|oτ_ ) _−_ ln _P_ ( _oτ_ )�

_−_ E _P_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|π_ )

= _−_ E _P_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|π_ )

- ln _P_ ( _sτ_ _|oτ_ ) _−_ ln _Q_ ( _sτ_ _|π_ )�

- ln _P_ ( _oτ_ )�

<u>�</u> <u>��</u> <u>�</u>
Epistemic value

<u>�</u> <u>��</u> <u>�</u>
Extrinsic value

In the rest of this appendix, we will focus on the epistemic value and report two experiments. In the first
experiment, the prior over states (c.f., left-most graph in Figure 45) is equal to the approximate posterior
(c.f., Figure 42), and the likelihood (c.f., Figure 43) is becoming more and more uniform (c.f., Figure 44).
Note, if the likelihood becomes uniform, then the true posterior _P_ ( _sτ_ _|oτ_ ) becomes equal to the prior over
states _P_ ( _sτ_ ), i.e.,

<u>1</u>
_P_ ( _sτ_ _|oτ_ ) _∝_ _P_ ( _oτ_ _|sτ_ ) _P_ ( _sτ_ ) = _|oτ_ _|_ <sup>_P_</sup> <sup>(</sup> <sup>_sτ_</sup> <sup>)</sup> <sup>_,_</sup>

where _|oτ_ _|_ is the number of observations at time step _τ_, and after renormalisation _P_ ( _sτ_ _|oτ_ ) = _P_ ( _sτ_ ). The
left-most graph of Figure 39 shows that the epistemic value decreases as the likelihood becomes more
uniform, i.e., the epistemic value decreases as the true posterior _P_ ( _sτ_ _|oτ_ ) becomes more similar to the
approximate posterior _Q_ ( _sτ_ _|π_ ). This behaviour is to be expected, as the epistemic value is bigger when
the true posterior _P_ ( _sτ_ _|oτ_ ) and the approximate posterior _Q_ ( _sτ_ _|π_ ) are more different. Thus, maximising
epistemic value will promote exploration and information gain.

In the second experiment, the likelihood has high entropy (c.f., right-most graph in Figure 44), and the
prior over states is shifting from left to right (c.f., Figure 45). When the prior over states _P_ ( _sτ_ ) and the
approximate posterior _Q_ ( _sτ_ _|π_ ) are different, the joint distribution _P_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|π_ ) will be more similar
to the approximate posterior _Q_ ( _sτ_ _|π_ ) than it is to the true posterior _P_ ( _sτ_ _|oτ_ ). Indeed, as the likelihood
is almost uniform, the true posterior _P_ ( _sτ_ _|oτ_ ) will almost be equal to the prior over states _P_ ( _sτ_ ). At the
same time, as the likelihood is almost uniform, it will not have much impact on the joint distribution
_P_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|π_ ) and the approximate posterior _Q_ ( _sτ_ _|π_ ) will dominate. To sum up, when the prior over
states _P_ ( _sτ_ ) and the approximate posterior _Q_ ( _sτ_ _|π_ ) are different:

  - the true posterior will almost be equal to the prior over states _P_ ( _sτ_ _|oτ_ ) _≈_ _P_ ( _sτ_ )

  - the joint distribution _P_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|π_ ) will be more similar to _Q_ ( _sτ_ _|π_ ) than it is to _P_ ( _sτ_ _|oτ_ )

Therefore, the joint distribution _P_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|π_ ) will tend to be large when the difference within the
expectation is negative (c.f., Figure 46). Indeed, as the joint is similar to the approximate posterior, it
means that the joint distribution is large when the approximate posterior is large and the true posterior is
smaller. This implies that the logarithm of true posterior will be very negative, while the logarithm of the
approximate posterior will be less negative, i.e., closer to zero. Then, the logarithm of the approximate
posterior will be substrated from the logarithm of the true posterior, i.e., a small positive number will be
added to a very negative number. Therefore, the result will be negative.

The right-most graph of Figure 39 shows that the epistemic value increases as the prior _P_ ( _sτ_ ) and
therefore the true posterior _P_ ( _oτ_ _|sτ_ ) becomes more similar to the approximate posterior _Q_ ( _sτ_ _|π_ ). This
behaviour should not be observed, as the epistemic value is bigger when the true posterior _P_ ( _sτ_ _|oτ_ ) and
the approximate posterior _Q_ ( _sτ_ _|π_ ) are more similar. Thus, maximising epistemic value will not promote
exploration. In fact, it will recommend a strong focus on a single action as was observed in Figure 33.

57

Champion et al.

Figure 42: This figure illustrates the approximate posterior _Q_ ( _sτ_ _|π_ ), which is distributed according to a
binomial distribution corresponding to 6 trials with a probability of success of 0.5.

Figure 43: This figure provides two views of the same likelihood mapping _P_ ( _oτ_ _|sτ_ ), i.e., one from the
front and one from behind. The likelihood was created by sliding a binomial distribution (corresponding
to 6 trials with a probability of success of 0.5) across the observation axis, each time the state increases
by one. Finally, when the binomial reached its most extreme position, it stays the same for the remaining
states.

Figure 44: During the first experiement, we changed the likelihood mapping _P_ ( _oτ_ _|sτ_ ) by making it more
and more uniform. This change is shown in the figure from left to right.

58

Deconstructing deep active inference.

Figure 45: During the second experiement, we changed the prior over states _P_ ( _sτ_ ) by making it more
and more different to the approximate posterior _Q_ ( _sτ_ _|π_ ). This change is shown in the figure from left to
right.

Figure 46: To compute the epistemic value, we first computed the difference between the logarithm of the
true posterior ln _P_ ( _sτ_ _|oτ_ ) and the logarithm of the approximate posterior ln _Q_ ( _sτ_ _|π_ ) for all the values taken
by the observation _oτ_ (c.f., left-most figure). Then, we computed the joint distribution _P_ ( _oτ_ _|sτ_ ) _Q_ ( _sτ_ _|π_ )
used in the expectation (c.f., middle figure). Next, we compute the element-wise product between the
matrices illustrated in the left-most and middle figures (c.f., right-most figure). Finally, the epistemic
value is obtained by summing up all the elememts of the element-wise product. In this instance, the
epistemic value will be strongly negative.

59
