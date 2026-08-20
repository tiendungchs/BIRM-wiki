---
title: "Active Inference as a Convex Markov Decision Process"
source: "https://arxiv.org/abs/2607.20152"
author:
  - "[[Nikola Milosevic]]"
  - "[[Nicolas Hinrichs]]"
  - "[[Nico Scherf]]"
published: 2026-07-22
created: 2026-08-09
description: "For closed-loop policies under a fixed model, EFE minimization is a convex MDP: pragmatic, ambiguity and recognition terms are linear in the predictive state marginals; the state-marginal-entropy epistemic term is the only nonlinearity. Derives a mirror-descent algorithm and frames model refitting as performative RL."
tags:
  - "clippings"
---

Active Inference as a Convex Markov Decision Process

arXiv is now an independent nonprofit!
Learn more

Back to arXiv

License: CC BY 4.0

arXiv:2607.20152v1 [cs.LG] 22 Jul 2026

# Active Inference as a Convex Markov Decision Process

Nikola Milosevic

Max Planck Institute for Human Cognitive and Brain Sciences

Leipzig, Germany

nmilosevic@cbs.mpg.de
&Nicolás Hinrichs

Max Planck Institute for Human Cognitive and Brain Sciences

Leipzig, Germany

nhinrichs@cbs.mpg.de
&Nico Scherf

Max Planck Institute for Human Cognitive and Brain Sciences

Leipzig, Germany

nscherf@cbs.mpg.de
Corresponding author: nmilosevic@cbs.mpg.de. ORCID 0000-0003-1904-8867.

###### Abstract

Active Inference (AIF) frames adaptive behavior as the minimization of expected free energy (EFE), combining epistemic and pragmatic objectives within a single variational principle. We frame AIF as policy optimization and show that, for closed-loop control policies, EFE minimization can be formulated as a convex Markov decision process (MDP). In this formulation, the pragmatic terms are linear in the predictive state marginals and therefore equivalent to reward maximization in a latent MDP, while the epistemic value introduces a nonlinear component that distinguishes EFE minimization from standard reinforcement learning. This perspective further reveals the epistemic drive of active inference as a policy-dependent (performative) reward.
We analyze finite-horizon, discounted, and average-reward formulations of EFE and derive a mirror descent (MD) algorithm that locally linearizes the objective around the current state marginals, yielding a policy-dependent reward that is compatible with actor-critic methods and dynamic programming. Finally, we argue that coupling world-model learning with policy optimization gives active inference the structure of performative reinforcement learning, providing a route toward grounding active inference within modern reinforcement learning and optimization theory, including convergence analysis and principled policy improvement guarantees.

Keywords active inference $\cdot$
expected free energy $\cdot$
convex MDP $\cdot$
mirror descent $\cdot$
reinforcement learning

##
1 Introduction

Figure 1: The episodic active inference setting considered in this work: A) the environment admits a true partially observable decision process, while the agent learns a latent fully observable process using variational inference. B) In contrast to standard variational inference, the two decision processes are coupled: the variational distribution $\nu$ is used both in variational model learning and in action selection through the behavior policy $\beta=\pi\circ\nu$ . The agent acts in the environment using the behavior policy $\beta=\pi\circ\nu$ for multiple episodes, then uses the data to fit its model by Variational Free Energy (VFE) minimization to obtain $m=(p,\nu)$ , and uses that model to optimize its policy in imagination by minimizing the Expected Free Energy (EFE).

Model-based policy optimization (MBPO) lets an agent learn a world model from
environment interaction and then optimize a reactive policy on imagined rollouts
inside that model. In reinforcement
learning (RL), the properties of MBPO are well understood: algorithms converge
under suitable assumptions, and policy-improvement guarantees can be stated for
the expected reward [12].

Active Inference (AIF) [5, 6] can also be read as
MBPO. The agent learns a generative model of the environment, then selects actions by minimising an expected free energy (EFE) that
scores imagined future outcomes against a preference distribution.
Implementations use similar architectural components as recent world model-based RL methods [8, 10, 18]: a recurrent world model, an actor, and a critic, trained on imagined environment interactions. The optimization properties of EFE minimization, however, are far less understood than those of
reward-maximizing MBPO. It is not known whether the EFE minimum exists, whether it is unique, or what kind of optimization problem the combined VFE–EFE minimization constitutes. This blocks the transfer of efficient algorithms, and
their convergence and policy-improvement guarantees, from the RL literature to
the simulation of AIF agents.

AIF is formulated with inference, not policy optimization, in mind. To bring it
within reach of the RL toolbox we make two modifications to the standard
protocol (cf. [5]). First, we take an episodic view: rather
than updating on every environment step, VFE and EFE minimization each run over
one or more full episodes while the other’s target is held fixed, see Fig.˜1. This is only a mild
departure since standard AIF already freezes the model and variational posterior
during planning when it imagines future timesteps. We simply extend that
separation to the data-collection phase. Second, in place of the mean-field
posterior over the future we use a causal one, so that
imagination is Markov and can be realised by ancestral sampling, meaning the agent
can sample its own imagined rollouts efficiently and in a physically meaningful manner.

With these two modifications in place, our central claim is that EFE
minimization under a fixed model is a convex MDP [29, 30], the recent generalisation of RL in
which the objective can be an arbitrary convex functional of the state–action marginal at future timesteps rather than a linear one (as with expected reward). The per-step EFE is exactly of this form. Its extrinsic-value
and ambiguity terms are linear in the occupancy, while the epistemic value, the
negative state-marginal entropy, supplies a single convex term such that the whole of convex-MDP theory applies. At the exact-posterior limit this epistemic term coincides with the mutual information between states and observations, recovering the familiar information-gain reading of active inference. We return to this in Section˜3. In particular, convex MDPs admit extended
dynamic-programming methods that remain scalable and sample-efficient.

Finally, we show that allowing the agent to refit the model from data of the real environment significantly complicates the optimization problem. Active inference sits at the underexplored intersection of convex MDPs and performative reinforcement learning [22, 16, 24], where the reward and the environment dynamics respond to the agent’s deployed policy.

We take the observation-preference reading of the EFE as primary: it carries the mutual-information interpretation of epistemic value, and because the same recognition density scores both imagined inference and online inference, it makes the planning objective self-consistent with the agent’s perception.

#### Contributions.

-
(i)

Structure. We present the episodic policy optimization setting for AIF, where the EFE, without modification,
becomes a convex functional of the imagined step- $t$ state marginal, splitting into linear
terms (a latent-MDP reward) and a single convex nonlinearity (the epistemic
value). This gives EFE minimization the structure of a convex MDP.

-
(ii)

Algorithm and rate. We solve EFE minimization with a mirror-descent-inspired algorithm that yields a policy-dependent reward (a fixed reward, and a variable curiosity bonus). The resulting subproblem is
a combination of soft RL [9] and maximum entropy exploration [11], solved in closed form by softmax dynamic
programming. Our MD scheme (MD-AIF) converges at rate $O(1/K)$
by relative smoothness.

-
(iii)

Closing the loop. Refitting the world model to policy-induced
data makes the scheme performative [22]. We show that a performatively stable policy–model pair exists under mild assumptions, and sketch a path towards a performative AIF algorithm.

##
2 Episodic Active Inference

We consider a finite-horizon reward-free POMDP
$\mathcal{M}=(\mathcal{S},\mathcal{A},\mathcal{O},P,E,\sigma)$ , where $s_{t}\in\mathcal{S},a_{t}\in\mathcal{A}$ , and
$o_{t}\in\mathcal{O}$ are states, actions, and observations at time
$t\in[T]=\{0,\dots,T\}$ , with $\mathcal{S},\mathcal{A},\mathcal{O}$ finite. $P$ and $E$ are transition and emission kernels with full support and $\sigma$ is a start state distribution.

For the sake of clarity, we consider the memoryless finite-horizon setting in the main text. However, our results extend to the history-dependent and infinite horizon settings, see §3.2. A memoryless behavior policy $\beta:\mathcal{O}\to\Delta(\mathcal{A})$
induces the environment trajectory law

|
| $p^{\beta}(\tau)=\sigma(s_{0})E(o_{0}|s_{0})\prod_{t=0}^{T-1}\,\beta(a_{t}|o_{t})P(s_{t+1}|s_{t},a_{t})E(o_{t+1}|s_{t+1}).$
|
| (1)

An active inference agent consists of a variational world model $m=(p_{\theta},\nu_{\phi})$ with model parameters $\theta$ and variational parameters $\phi$ . We work primarily in the tabular parametrization setting and drop parameter indexes following [2]. Further, the agent deploys its behavior policy in the real environment by
chaining latent-state inference and action selection. Throughout, we consider composed behavior policies $\beta=\pi\circ\nu$ , where memoryless policies are of the form
$\beta(a_{t}|o_{t})=\sum_{s_{t}}\pi(a_{t}|s_{t})\,\nu(s_{t}|o_{t}),$
i.e. the agent first infers the latent state through the recognition density $\nu$ and then acts through the latent-state-conditioned policy
$\pi$ used in EFE optimization.

We consider an episodic model-based policy-optimization setting in which the
agent alternates between

-
1.

Model learning: explore the environment using $\beta$ , collect
trajectory data $\mathcal{D}$ over several episodes, and fit the world model
$m=(p,\nu)$ by minimising variational free energy (VFE) on the
data,

-
2.

Policy optimization: improve the behavior policy by
minimising expected free energy (EFE) on imagined trajectory data with
respect to the latent policy $\pi$ , using the latest world model.

One full pass through the active inference loop is

|
| $\pi\xmapsto{\ \mathrm{deploy}\ }\mathcal{D}(\pi)\xmapsto{\ \text{VFE}\ }m(\mathcal{D}(\pi))\xmapsto{\ \text{EFE}\ }\pi\big(m(\mathcal{D}(\pi))\big)=:\mathrm{AIF}(\pi),$
|
| (2)

and a fixed point satisfies $\pi^{*}=\mathrm{AIF}(\pi^{*})$ . The VFE and EFE steps can either be run to completion or interleaved episodically.
Crucially, the latent policy space $\Pi=\prod_{t}(\Delta_{\mathcal{A}})^{\mathcal{S}}$ does not depend on the
model and the natural question is under which conditions
repeated application of $\mathrm{AIF}$ admits such a fixed point and whether efficient algorithms exist that converge to it.

###
2.1 VFE: World Model Training

The model $m=(p,\nu)$ that the EFE phase plans against is the
output of a preceding perception/learning phase: minimization of VFE on data
gathered in the real environment. We record the VFE in the form that matches
the EFE below, with the same recognition density, so that the full loop (2) is well posed.

#### Generative model and recognition.

With actions treated as given, the agent’s generative model over a trajectory
$\tau=(s_{0},o_{0},a_{0},\dots,a_{T-1},s_{T},o_{T})$ factorises as

|
| $p(o_{0:T},s_{0:T}|a_{0:T-1})=p(s_{0})p(o_{0}|s_{0})\prod_{t=0}^{T-1}p(o_{t+1}|s_{t+1})p(s_{t+1}|s_{t},a_{t}),$
|
| (3)

and states are inferred with the history-conditioned recognition density

$\nu(s_{0:T}|o_{0:T},a_{0:T-1})=\prod_{t=0}^{T}\nu(s_{t}|o_{t})$ .
Again, under direct parametrization, we drop the parameter indexes and consider the memoryless case. The history-dependent case is discussed in Section˜3.2.

#### VFE.

Let $\mathcal{D}(\pi)$ be the distribution of histories $h_{T}=(o_{0:T},a_{0:T-1})$ obtained
by running $\beta=\pi\circ\nu$ in the real environment. The variational free
energy of $m$ on data $\mathcal{D}$
is

|
| $\mathcal{F}(m;\mathcal{D})=\underbrace{\mathbb{E}_{h\sim\mathcal{D}}\big[-\log p(o_{0:T}|a_{0:T-1})\big]}_{\text{surprise}}+\underbrace{\mathbb{E}_{h\sim\mathcal{D}}\,D_{\mathrm{KL}}\big(\nu(s_{0:T}|h)\,\|\,p(s_{0:T}|h)\big)}_{\text{recognition gap}\,\geq\,0},$
|
| (4)

where $p(s_{0:T}|o,a)$ is the exact Bayesian posterior under (3). The bound is tight precisely when $\nu$ equals that posterior. This
non-negative recognition gap is the same quantity that controls EFE accuracy. VFE-optimality of $\nu$ is what makes the EFE phase score against an accurate posterior. The model-learning phase targets

|
| $m^{*}(\pi)\in\arg\min_{m}\ \mathcal{F}(m;\mathcal{D}(\pi)),$
|
| (5)

where the optimum $m^{*}$ generally depends on the policy $\pi$ used to generate the trajectory data via $\beta=\pi\circ\nu$ .

###
2.2 EFE: Planning in a Latent MDP

Given a model $m=(p,\nu)$ , a latent policy $\pi$ induces the purely imagined trajectory law

|
| $q^{\pi}(\tau;m)=q_{0}(s_{0})\,p(o_{0}|s_{0})\prod_{t=0}^{T-1}\pi_{t}(a_{t}|s_{t})\,p(s_{t+1}|s_{t},a_{t})\,p(o_{t+1}|s_{t+1}),$
|
| (6)

with predictive state marginals $\rho_{t}^{\pi}(s)=\mathbb{P}_{q^{\pi}}(s_{t}=s)$ of $q^{\pi}$ at time $t$ satisfying the recursion

|
| $\rho_{t+1}^{\pi}(s^{\prime})=\sum_{s,a}p(s^{\prime}|s,a)\,\pi_{t}(a|s)\,\mu_{t}^{\pi}(s,a),\quad\mu_{t}^{\pi}(s,a)\coloneqq\rho_{t}^{\pi}(s)\pi_{t}(a|s)$
|
| (7)

where $\rho_{0}^{\pi}=q_{0}$ is given. For example, it can be an additional factor $q_{0}(s_{0})=\nu(s_{0})$ in the variational posterior or derived from the recognition density $q_{0}(s_{0})=\nu(s_{0}|o_{0})$ where $o_{0}\sim\mathcal{D}$ is sampled from a dataset (cf. Dreamer [10]).
Sampling is ancestral: the agent acts causally in imagination. Then we define the AIF planning problem as follows.

Given an active inference agent with model $m$ , a (biased) observation preference $\tilde{p}$ , and a latent trajectory distribution $q^{\pi}(\cdot;m)$ , define the finite-horizon EFE by

|
| $\displaystyle\mathcal{G}(\pi;m)$
| $\displaystyle=\sum_{t=0}^{T}G_{t}(\pi;m)=\sum_{t=0}^{T}\mathbb{E}_{q^{\pi}}\!\big[\,g_{t}(s_{t},o_{t})\,\big],$
|
| (8)

|
| $\displaystyle g_{t}(s_{t},o_{t})$
| $\displaystyle=\underbrace{\log\rho_{t}^{\pi}(s_{t})}_{\text{predictive marginal}}\underbrace{-\log\nu(s_{t}|o_{t})-\log p(o_{t}|s_{t})-\log\tilde{p}(o_{t})}_{=:-\log\tilde{p}(s_{t},o_{t})\ \text{(biased model)}},$
|
| (9)

where $\nu$ is the agent’s recognition density.
The planning (policy optimization) problem is

|
| $\pi^{*}(m)\in\arg\min_{\pi}\mathcal{G}(\pi;m).$
|
| (10)

This particular definition of the EFE is one of many variants used throughout the literature [5, 21, 19].
It is the one that appears in policy optimization [18, 17], designed for consistency with the agent’s behavior policy ( $\beta=\pi\circ\nu$ ) and tractability in simulation.

#### The epistemic value as mutual information.

The intrinsic value is the negative state-marginal entropy $-\mathcal{H}(\rho_{t})$ , which under Eq.˜8 appears in place of the mutual information because the recognition density $\nu$
is held fixed. If $\nu$ is replaced by the exact model posterior $p(s|o)$ (the idealised case, attained at VFE convergence (4)), this term becomes the negative mutual information $-I_{t}(S;O)$ between states and observations at time $t$ .
This is the classical epistemic/information-gain value of active inference [21, 19]. The two readings coincide exactly at EFE convergence, so the convex-MDP structure preserves the information-theoretic interpretation of the EFE. Only the nonlinearity is named differently, depending on whether the recognition density is variational or exact.

#### Convex-MDP structure.

We show in §3 that $\min_{\pi}\mathcal{G}(\pi;m)$ is a convex MDP for fixed $m$ , solvable by repeated dynamic programming with policy-dependent rewards. These rewards are precisely the EFE gradients with respect to the state-marginal of trajectory law (6). Note that this structure is independent of the exact EFE variant, see Appendix A, of history dependence, see §3.2, and of parameter uncertainty, since the model and variational parameters are fixed during planning.

##
3 EFE Minimization is a Convex MDP

Our main structural result is that EFE minimization is a convex MDP under a fixed given model $m=(p,\nu)$ . This can be read off immediately from the objective, once the EFE is brought into its state-action marginal form.

######
Lemma 1.

We write $\mu^{\pi}=(\mu_{t}^{\pi})_{t=0}^{T}$ . The EFE Eq.˜8 can be written as

|
| $\mathcal{G}(\pi)=\Gamma(\mu^{\pi})\coloneqq\;\langle\ell,\mu^{\pi}\rangle+\Phi(\mu^{\pi}),$
|
| (11)

where $\ell\coloneqq\ell_{t}(s,a)=-\mathbb{E}_{o\sim p(\cdot|s)}\log\tilde{p}(s,o)$ , $\Phi(\mu^{\pi})=-\sum_{t}\mathcal{H}(\rho^{\pi}_{t})$ is the neg. marginal Shannon entropy, and
$\langle\cdot,\cdot\rangle$ is the Euclidean inner product on
$\mathbb{R}^{\mathcal{S}\times\mathcal{A}\times[T]}$ .

The inner product is linear in $\mu^{\pi}$ whenever the preference distribution $\tilde{p}$ is independent of $\mu^{\pi}$ and $\Phi$ is (not strictly) convex, since $-\mathcal{H}$ is strictly convex, but $-\mathcal{H}(\sum_{a}\mu^{\pi}(\cdot,a))$ is only convex in $\mu^{\pi}$ .

###
3.1 Planning as a Convex MDP

While $\mathcal{G}$ can be written as a functional of some $\mu_{t}\in\Delta(\mathcal{S}\times\mathcal{A})$ , the marginals can not move freely on the entire simplex, since they are fully determined by $\pi$ through Eq.˜6. Like the state-marginals, the state-action marginals $\mu_{t}^{\pi}$ that arise from some policy $\pi$ must satisfy flow constraints for all $t\in[T{-}1]$ and $\ s^{\prime}\in\mathcal{S}$ :

|
| $\displaystyle\sum_{a}\mu_{0}^{\pi}(s,a)$
| $\displaystyle=q_{0}(s),\quad\sum_{a^{\prime}}\mu_{t+1}^{\pi}(s^{\prime},a^{\prime})=\sum_{s,a}p(s^{\prime}|s,a)\,\mu_{t}^{\pi}(s,a).$
|
| (12)

These constraints are a result of our choice of planning distribution, which turns imagination into a Markov process.

######
Definition 1 (Occupancy polytope [23, 20]).

Let

|
| $\mathcal{K}=\{(\mu_{t})_{t=0}^{T}\in(\Delta_{\mathcal{S}\times\mathcal{A}})^{T+1}|\eqref{eq:flow}\text{ holds}\},$
|
| (13)

which is a compact convex polytope. Every $\mu\in\mathcal{K}$
corresponds to a unique policy $\pi_{t}(a|s)=\mu_{t}(s,a)/\sum_{a^{\prime}}\mu_{t}(s,a^{\prime})$ wherever $\rho_{t}(s)>0$ .

Due to the one-to-one correspondence of $\pi$ and $\mu^{\pi}$ (specifically, $\pi\mapsto\mu^{\pi}$ is a bijection onto the interior of $\mathcal{K}$ ), the problems
$\min_{\pi}\mathcal{G}(\pi)$ and $\min_{\mu\in\mathcal{K}}\Gamma(\mu)$ are equivalent.

######
Proposition 1 (EFE minimization is a convex MDP).

Finite-horizon EFE minimization under a fixed model is a finite-horizon convex MDP, meaning

|
| $\min_{\pi}\mathcal{G}(\pi)\equiv\min_{\mu\in\mathcal{K}}\Gamma(\mu),$
|
| (14)

where $\mu^{\pi}=(\mu^{\pi}_{t})_{t}$ is the collection of all step- $t$ state-action marginals under $q^{\pi}$ and Eq.˜14 is a convex program over policy-induced state-action marginals, i.e. a convex MDP [29, 20].

###### Proof.

By Lemma˜3, $\Gamma$ is convex. Further, $\mathcal{K}$ is a convex polytope [23, 20], thus Eq.˜14 is a convex program in state-action occupancies, exactly the convex MDP (concave-utility) problem of [20].
∎

Optimization problems of this kind are referred to as convex [29], general-utility [30, 27], or concave-utility MDPs [20] in the RL literature. Specifically, EFE minimization has the structure of maximum-entropy exploration [11] combined with standard reward maximization, here in the episodic/finite-horizon setup studied by [20].
Convex MDPs are more general than standard MDPs. While standard MDPs also have a convex program representation, the objective there is linear, and the nonlinear case does not admit global value functions. However, specialized dynamic programming methods exist, which we will exploit in the algorithmic development of §4.

###
3.2 History-Dependent and Infinite-Horizon Extensions

So far we have discussed the finite-horizon memoryless setting. However, this was mostly for clarity, and our results readily apply to history-dependent and infinite-horizon formulations. To restore the convex MDP structure on the history process, one must augment the state space with the space of histories. Note that this state is analogous to the imagined state of the Dreamer [10, 18] architecture.

Table 1: Infinite-horizon extensions of the EFE objective. The two axes correspond to whether entropy is computed after temporal aggregation of occupancies or before it, and whether the temporal aggregation is discounted or stationary.

|
|

Discounted

|

Stationary

|

time $\to$ state

|

$\displaystyle\begin{aligned} d_{\gamma}^{\pi}&=(1-\gamma)\sum_{t=0}^{\infty}\gamma^{t}\mu_{t}^{\pi}\\[2.0pt]
\mathcal{G}_{\gamma}^{\mathrm{agg}}(\pi)&=\langle\ell,d_{\gamma}^{\pi}\rangle-\mathcal{H}(d^{\pi})\end{aligned}$

|

$\displaystyle\begin{aligned} d_{\infty}^{\pi}&=\lim_{T\to\infty}\frac{1}{T}\sum_{t=0}^{T-1}\mu_{t}^{\pi}\\[2.0pt]
\mathcal{G}_{\infty}^{\mathrm{agg}}(\pi)&=\langle\ell,d_{\infty}^{\pi}\rangle-\mathcal{H}(d_{\infty}^{\pi})\end{aligned}$

|

state $\to$ time

|

$\displaystyle\mathcal{G}_{\gamma}^{\mathrm{step}}(\pi)=(1-\gamma)\sum_{t=0}^{\infty}\gamma^{t}G_{t}(\pi)$

|

$\displaystyle\mathcal{G}_{\infty}^{\mathrm{step}}=\lim_{T\to\infty}\frac{1}{T}\sum_{t=0}^{T-1}G_{t}$

######
Lemma 2 (History augmentation).

The history-dependent version of Eq.˜8 given by Eq.˜45 induces a convex MDP on the augmented state $x=(h,s)$ .

Generalizing to infinite horizons is also possible, however, it comes with modeling choices. Due to the nonlinearity of the objective, one must choose how to combine state and time averages, see Table˜1. The key distinction is that the entropy operator does not commute with time aggregation, but we must aggregate time in the infinite-horizon formulation to avoid infinite-dimensional decision variables. By concavity of $\mathcal{H}$ and Jensen’s inequality,

|
| $\mathcal{H}(d^{\pi})\geq(1-\gamma)\lim_{T\to\infty}\sum_{t=0}^{T}\gamma^{t}\mathcal{H}(\mu_{t}^{\pi}),\quad d^{\pi}(s,a)=(1-\gamma)\lim_{T\to\infty}\sum_{t=0}^{T}\gamma^{t}\mu_{t}^{\pi}(s,a),$
|
| (15)

with equality only when all $\mu_{t}^{\pi}$ are identical. Details on existence and algorithmic consequences are given in Appendix D.2, see also [27].

##
4 Solving EFE Minimization by Soft RL

The convex nonlinearity of the EFE makes the per-step reward depend on the policy’s
state-marginal, so a single value function cannot capture the objective globally. Convex MDP methods resolve this by linearising the objective at each iterate. Policy optimization algorithms based on mirror descent [4, 14, 20] are particularly well-suited for EFE minimization: every step
replaces the EFE by its first-order surrogate around the current state-marginal, turning the convex MDP into a sequence of ordinary soft-MDP problems whose reward is recomputed between iterations.
The reason why this works is that MD lets us choose a Bregman divergence $D_{\Psi}$ through the convex generator $\Psi$ in its update

|
| $\mu^{k+1}\in\arg\min_{\mu\in\mathcal{K}}\big\{\langle\nabla\Gamma(\mu^{k}),\mu\rangle+\eta^{-1}D_{\Psi}(\mu\,\|\,\mu^{k})\big\},$
|
| (16)

where $\eta$ is a stepsize. We choose

|
| $D_{\Psi}(\mu\|\mu^{k})=\sum_{t,s}\rho_{t}(s)D_{\mathrm{KL}}(\pi^{\mu}_{t}(\cdot|s)\|\pi^{\mu^{k}}_{t}(\cdot|s)),$
|
| (17)

where $\Psi$ is the negative conditional entropy, see Appendix C and [20] for details. With this choice, Eq.˜16 has a closed-form solution that is exactly the soft-Bellman backup used in Algorithm˜1.

Algorithm˜1 is the active-inference instance of MD-CURL [20, Alg. 2], which is a convex
MDP solver using mirror descent [4]. Here it is specialized by the EFE objective, whose nonlinearity is the state-marginal negative entropy $\Phi$ . The linearized per-iteration reward $r^{k}=-\nabla\Gamma(\mu^{k})$ carries the state-marginal term $-\log\rho_{t}^{k}(s)-1$ and the static preference reward $-\ell_{t}$ .

Algorithm 1 MD-AIF

1:world model $m=(p,\nu)$ ; preference $\tilde{p}_{t}$ ; horizon $T$ ; step size $\eta$ ; init. belief $q_{0}$ ; current policy $\bar{\pi}$ .

2: $\text{MD-AIF}(\pi^{k};m,\tilde{p}_{t},T,\eta,q_{0})$ computes the update Eq.˜16.

3: $\mu_{0}\leftarrow q_{0}$ ;

4:for $t=0,\dots,T-1$ do

5:   $\mu_{t+1}(s^{\prime})\leftarrow\sum_{s,a}p(s^{\prime}|s,a)\,\bar{\pi}(a|s)\,\mu_{t}(s)$

6: $\triangleright$ linearized reward: negative EFE gradient $r=-\nabla\Gamma(\mu)$

7:for all $t,s,a$ do

8:   $r_{t}(s,a)\leftarrow\mathbb{E}_{o}\log\tilde{p}(s,o)\;-\,\log\rho_{t}(s)-1$

9: $\triangleright$ Backward pass: soft (free-energy) value iteration

10: $V_{T+1}(\cdot)\leftarrow 0$

11:for $t=T,\dots,0$ do

12:   $Q_{t}(s,a)\leftarrow r_{t}(s,a)+\sum_{s^{\prime}}p(s^{\prime}|s,a)\,V_{t+1}(s^{\prime})$

13:   $V_{t}(s)\leftarrow\eta^{-1}\log\sum_{a}\bar{\pi}(a|s)\exp\!\big(\eta\,Q_{t}(s,a)\big)$

14: $\triangleright$ Mirror step: multiplicative (softmax) policy update

15:for all $t,s$ do

16:   $\pi_{t}(a|s)\leftarrow\dfrac{\bar{\pi}(a|s)\exp\!\big(\eta\,Q_{t}(s,a)\big)}{\sum_{a^{\prime}}\bar{\pi}(a^{\prime}|s)\exp\!\big(\eta\,Q_{t}(s,a^{\prime})\big)}$

17:return $\pi_{t}$ for all $t$

#### Natural Policy Gradient of the EFE.

With the conditional-negative-entropy generator $\Psi$ , MD-AIF approximates natural
gradient descent on the EFE over the policy manifold [3]. The proximal term of (16) is, to second order, the squared Riemannian norm

|
| $D_{\Psi}(\mu\,\|\,\mu^{k})=\tfrac{1}{2}\,\big\|\pi^{\mu}-\pi^{\mu^{k}}\big\|_{\mathbf{F}^{k}}^{2}+O(\|\delta\|^{3}),\quad\mathbf{F}^{k}=\bigoplus_{t,s}\rho_{t}^{\pi}(s)\,\mathrm{diag}(\pi_{t}^{k}(\cdot|s))^{-1}$
|
| (18)

and the step
$\pi_{t}^{k+1}(\cdot|s)=\pi_{t}^{k}(\cdot|s)+\eta_{k}\,F_{t}^{k}(s)^{-1}\,Q_{t}^{k}(s,\cdot)+O(\eta_{k}^{2})$
is precisely the first-order expansion of the multiplicative update of Algorithm˜1. MD-AIF is therefore an efficient implementation of Kakade’s natural policy gradient (NPG; [13]) on the EFE, see also [25, 3] for the general duality between MD and NPG.

######
Proposition 2 (Convergence of MD-AIF).

Run Algorithm 1 for $K$ steps with a fixed model $m$
and step size $\eta=1/L$ from a full-support $\mu^{0}\in\mathcal{K}$ . Then $\Gamma$ is $L$ -smooth relative
to $\Psi$ on the flow polytope with constant $L=\tfrac{1}{2}T(T+1)$ , and

|
| $\min_{0\leq k\leq K}\mathcal{G}(\pi^{k};m)-\mathcal{G}(\pi^{\star};m)\ \leq\ \frac{L\,D_{\Psi}(\mu^{\star}\|\mu^{0})}{K+1}\ =\ O(1/K),$
|

where $D_{\Psi}$ is the Bregman divergence generated by $\Psi(\mu)=\sum_{t,s,a}\mu_{t}(s,a)\log\pi^{\mu}_{t}(a|s)$ .

###### sketch.

The proof relies on showing that the algorithm solves the mirror descent update exactly for the chosen Bregman divergence $D_{\Psi}(\mu||\mu^{\prime})$ and that $\Gamma$ is relatively smooth w.r.t. $\Psi$ . One then invokes the relative smoothness bound [15] for the rate.
∎

##
5 Performative Active Inference

###
5.1 Closing the Loop

The fixed-model results above assume the planner sees a model that does not change as the
policy changes. Closing the active inference loop (2) breaks that
assumption: after deploying $\pi$ the agent refits its world model to the data that $\pi$
itself induced, so the reward $\ell_{\pi}$ and the augmented dynamics $P_{\pi}$ that the next
planning phase optimizes against are functions of the deployed policy. This is exactly
the structure of performative reinforcement learning [22, 16, 24],
in which the trajectory distribution reacts to the deployed decision rule.

A single round of the closed loop maps a deployed policy to its model-conditioned mirror
step. Writing $m_{\pi}=m^{\star}(\mathcal{D}(\pi))$ for the VFE-refit model and $Q^{\pi}$ for the soft
action-value produced by the backward recursion of Proposition˜4 under $m_{\pi}$ , the
performative mirror operator $\mathcal{P}:\Pi\to\Pi$ (Definition˜4) is the softmax
update

|
| $\mathcal{P}(\pi)_{t}(a|x)\;=\;\frac{\pi_{t}(a|x)\,\exp\!\big(\eta\,Q^{\pi}_{t}(x,a)\big)}{\sum_{b}\pi_{t}(b|x)\,\exp\!\big(\eta\,Q^{\pi}_{t}(x,b)\big)},$
|
| (19)

and a performatively stable policy is a fixed point $\pi^{\star}=\mathcal{P}(\pi^{\star})$ : a policy
that is already optimal for the model its own deployment produces. Existence follows from a
standard fixed-point argument once the loop is continuous and the policy simplex compact.

######
Proposition 3 (Existence, informal; see Proposition˜5).

Under a support floor on the model class and continuity of the policy-to-model map, the performative mirror operator $\mathcal{P}$ has a fixed point
$\pi^{\star}=\mathcal{P}(\pi^{\star})$ .

Existence does not imply i) that the retraining iterates reach such a point rapidly, and ii) that a given fixed point has the desired properties, e.g. the model converges to the true environment dynamics. We instead hypothesize a simplified regime in which a guarantee could hold and demonstrate the active-inference feature that obstructs it.

###
5.2 Toward a Convergence Guarantee

A clean case for full AIF convergence is i) well-specified tabular parametrization ii) with exact-recognition, and iii) state coverage under all deployed policies. If all three hold, the deployed policy only changes how frequently each transition is seen, never which are seen or what the model converges to.
The refit target is then policy-independent and the coupled iteration is a one-way cascade of two contractions, the policy converging to the model-optimal solution.

However, the coverage assumption is unlikely to hold under diverse behavior policies in complex environments, where AIF is arguably most promising. The epistemic drive in the EFE actively pushes mass onto under-visited states and so helps coverage naturally, but it does not certify a uniform minimum of state coverage.
When coverage fails, the refit target becomes policy-dependent. Moreover, the parameter-based novelty terms in the EFE may induce complex $\pi$ -dependence. Ultimately, the cascade can close into an unstable feedback loop. This is the regime of performative RL [22, 16]. We therefore leave a convergence analysis to future work, where natural routes are reduction to online learning via dataset aggregation [26] or the mixed delayed repeated retraining of [24]. The experiments of Section˜6 instead probe the closed loop with the simplifying assumptions: interleaving MD-AIF planning with fully-observed model refitting and measuring how fast the learned kernel approaches the truth.

##
6 Experiments

We test the two structural predictions of the convex-MDP view on deterministic
gridworlds: that MD-AIF (Proposition˜4) converges at the $O(1/K)$ rate of
Proposition˜2 with the policy-dependent reward driving
broad state coverage, and that closing the model-learning loop
accelerates identification of the environment. Environment, hyperparameter, and
baseline details are in App. F.

Figure 2: MD-AIF on gridworld environments.
(A, top two rows) $5\times 5$ deterministic gridworld.
Left: EFE convergence (log–log scale)
for MD-AIF, RL (no novelty), and EFE gradient descent, together with the theoretical $O(1/k)$ rate (dashed).
MD-AIF converges faster and to a lower value, driven by regularized dynamic programming.
Right: Per-step imagined occupancy $\rho_{t}(s)$ at convergence ( $k=100$ ) for MD-AIF (top) and RL (bottom) at five timesteps
$t\in\{0,3,6,9,12\}$ . MD-AIF spreads probability mass broadly across the grid before concentrating toward the goal, whereas RL greedily channels mass along the direct path. Both rows share the same color scale.
(B) $10\times 10$ deterministic gridworld with uniform preference (pure epistemic drive).
Left: Mean total-variation error
$\overline{\mathrm{TV}}(\hat{p},p^{\star})$ of the model fit as a function of environment steps under the interleaved model–policy loop.
MD-AIF’s information-gain drive produces broader state coverage,
accelerating model learning relative to RL and EFE gradient descent.
AIF agents [5] plan myopically over short horizons ( $T\!=\!3$ exact; $T\!=\!5$ via Monte Carlo with $N_{\rm mc}=100$ samples).
Right: Per-state model error
$\mathrm{TV}(\hat{p},p^{\star})=\mathbb{E}_{a\sim\pi_{T}}\,\mathrm{TV}(\hat{p}(\cdot|s,a),p^{\star}(\cdot|s,a))$
after 2500 environment steps.

Convergence and occupancy.
On a $5\times 5$ grid with a Manhattan-distance preference, we compare MD-AIF with
entropy-regularised RL and Euclidean gradient descent on the EFE.
MD-AIF attains a lower EFE and tracks the theoretical $O(1/K)$ line
(Fig.˜2A, left), while its imagined occupancy spreads across the grid
before concentrating on the goal, in contrast to the direct channel taken by RL
(Fig.˜2A, right).

Model learning.
With a uniform preference, the EFE reduces to a pure epistemic drive. Interleaving
policy optimization with model refitting, the performative loop of MD-AIF yields broader coverage and faster reduction of the model error $\overline{\mathrm{TV}}(\hat{p},p^{\star})$ than RL, EFE gradient descent, or short-horizon EFE planning [5], see Fig.˜2B.

##
7 Conclusion

For closed-loop policies under a fixed model, expected free energy minimization is a convex MDP:
the pragmatic, ambiguity, and recognition terms form a linear latent-MDP reward, and the
epistemic value is the only nonlinearity, a convex negative state-marginal entropy. This places
EFE in the convex MDP class and makes its algorithms available, notably MD, which agrees with
the natural policy gradient on the EFE up to second order and converges at its standard $O(1/K)$ relative-smoothness rate.
Refitting the model and the recognition density to policy-induced data closes the loop and makes it performative. Here we prove existence of a stable policy-model pair (Proposition˜5) and leave convergence to future work.

## Appendix

##
Appendix A The expected free energy variants

######
Definition 2 (EFE variants).

The general integrand (8) specialises as follows.

-
•

Information gain (observation preference). Setting $\tilde{p}_{t}(s_{t},o_{t})=p(s_{t}|o_{t})\tilde{p}(o_{t})$ in (8) yields

|
| $g^{\mathrm{IG}}_{t}(s_{t},o_{t})\coloneqq\log\rho_{t}^{\pi}(s_{t})-\log p(s_{t}|o_{t})-\log\tilde{p}_{t}(o_{t}).$
|
| (20)

This reflects an idealized planning scenario, where the agent can compute the Bayesian state posterior under its own model.

-
•

Approximate information gain. Setting $\tilde{p}_{t}(s_{t},o_{t})=\nu(s_{t}|o_{t})\tilde{p}(o_{t})$ in (8) yields

|
| $g^{\mathrm{AIG}}_{t}(s_{t},o_{t})\coloneqq\log\rho_{t}^{\pi}(s_{t})-\log\nu(s_{t}|o_{t})-\log\tilde{p}_{t}(o_{t}),$
|
| (21)

which implements the same information gain term as above, but assuming variational inference is performed in the future, too.

-
•

Risk–ambiguity (state preferences). Placing preferences on states, $\tilde{p}(s)$ , and omitting recognition gives (cf. [5])

|
| $g^{\mathrm{RA}}_{t}(s_{t},o_{t})\coloneqq\log\rho_{t}^{\pi}(s_{t})-\log p(o_{t}|s_{t})-\log\tilde{p}(s_{t}).$
|
| (22)

This is equivalent to setting $\tilde{p}_{t}(s_{t},o_{t})=p(o_{t}|s_{t})\tilde{p}_{t}(o_{t})$ in (8).

-
•

Action Complexity. Optionally, add the action-complexity term to obtain

|
| $g^{\mathrm{AC}}_{t}(s_{t},a_{t},o_{t})=g_{t}(s_{t},o_{t})+\log\tfrac{\pi_{t}(a_{t}|s_{t})}{\bar{\pi}_{t}(a_{t}|s_{t})}.$
|

Action complexity is used in Control as Inference formulations of RL [9] and in deep learning based AIF implementations [18] and it can be seen as a replacement for the policy prior in myopic AIF implementations [5].

##
Appendix B EFE minimization as a convex MDP

We develop the occupancy form of the general EFE; the variants follow by
substituting their linear cost.

Using Eq.˜6 as the trajectory distribution, the
agent plans by acting in imagination and confines optimization to the
dynamically feasible occupancies (those satisfying the Chapman–Kolmogorov flow
constraints below).
This is also the structure which allows us to write EFE minimization as a convex MDP.

######
Lemma 3.

We write $\mu^{\pi}=(\mu_{t}^{\pi})_{t=0}^{T}$ . The EFE Eq.˜8 can be written as

|
| $\mathcal{G}(\pi;m)=\sum_{t=0}^{T}\sum_{s\in\mathcal{S}}\sum_{a\in\mathcal{A}}\mu_{t}^{\pi}(s,a)\left[\log\rho_{t}^{\pi}(s)-\sum_{o\in\mathcal{O}}p(o|s)\log\tilde{p}(s,o)\right],$
|
| (23)

or compactly

|
| $\mathcal{G}(\pi)=\;\langle\ell,\mu^{\pi}\rangle+\Phi(\mu^{\pi}),$
|
| (24)

where $\ell\coloneqq\ell_{t}(s,a)=-\mathbb{E}_{o\sim p(\cdot|s)}\log\tilde{p}(s,o)$ , $\Phi(\mu^{\pi})=-\sum_{t}\mathcal{H}(\rho^{\pi}_{t})$ is the neg. marginal Shannon entropy, and
$\langle\cdot,\cdot\rangle$ is the Euclidean inner product on
$\mathbb{R}^{\mathcal{S}\times\mathcal{A}\times[T]}$ .

###### Proof.

Starting from (8), the one-step expected free energy at time $t$ depends only on the marginal of the trajectory at $t$ :

|
| $G_{t}(\pi;m)=\sum_{s\in\mathcal{S}}\sum_{o\in\mathcal{O}}\rho_{t}^{\pi}(s)p(o|s)\left[\log\rho_{t}^{\pi}(s)-\log\tilde{p}(s,o)\right].$
|
| (25)

Summing over timesteps on both sides and expanding $\rho_{t}^{\pi}(s)=\sum_{a}\mu_{t}^{\pi}(s,a)$ yields the first result. Collecting terms and marginalizing the first $\mu_{t}^{\pi}$ yields the second.
∎

######
Lemma 4.

$\mathcal{G}$ is convex as a functional of $\mu^{\pi}$ . Further, for each $t$ , the functional $G_{t}$ is convex in $\mu_{t}$ , and $\rho_{t}$ .

###### Proof.

By Eq.˜24,

|
| $\displaystyle\mathcal{G}(\pi)$
| $\displaystyle=\;\langle\ell,\mu^{\pi}\rangle+\Phi(\mu^{\pi})=\;\sum_{t=0}^{T}\left[\langle\ell_{t},\mu^{\pi}\rangle-\mathcal{H}(\rho_{t}^{\pi})\right],$
|
| (26)

where the second inner product is on $\mathbb{R}^{\mathcal{S}\times\mathcal{A}}$ .
Further, $-\mathcal{H}$ is convex as a function of $\rho_{t}$ . Since marginalization is linear and a composition of a linear and a convex function is convex, $-\mathcal{H}$ is convex as a function of $\mu_{t}$ , but not strictly convex. The step-t inner products are linear (hence, convex) in $\mu_{t}$ whenever $-\log\tilde{p}$ is independent of $\mu_{t}$ , which holds for all variants (Definition˜2). Since sums of convex functions are convex, each $G_{t}$ is convex in $\mu_{t}$ . $\mathcal{G}$ and $\Phi(\mu^{\pi})$ are also convex in $\mu^{\pi}$ .
∎

In the state-action marginals, all variants in Appendix A share the same structure: a linear cost plus a convex negative-entropy term. They differ in the linear cost $\ell$ and in whether the nonlinearity is the joint negative entropy $R$ (with action complexity) or the state-marginal negative entropy $\Phi$ (without action compexity). All optimization machinery below depends only on this distinction.

######
Definition 3 (Occupancy Entropies).

Throughout we write

|
| $\Gamma(\cdot)\coloneqq\langle\ell,\cdot\rangle+\Phi(\cdot),$
|

so that the general EFE is

|
| $\mathcal{G}(\pi;m)=\Gamma(\mu^{\pi})=\langle\ell,\mu^{\pi}\rangle+\Phi(\mu^{\pi}).$
|

Write the occupancy entropies

|
| $\displaystyle\Phi(\mu)$
| $\displaystyle=\sum_{t,s,a}\mu_{t}(s,a)\log\sum_{a^{\prime}}\mu_{t}(s,a^{\prime})$
| $\displaystyle\text{(state negative entropy)},$
|
| (27)

|
| $\displaystyle\Psi(\mu)$
| $\displaystyle=\sum_{t,s,a}\mu_{t}(s,a)\log\frac{\mu_{t}(s,a)}{\sum_{a^{\prime}}\mu_{t}(s,a^{\prime})}$
| $\displaystyle\text{(conditional negative entropy)},$
|
| (28)

|
| $\displaystyle R(\mu)$
| $\displaystyle=\sum_{t,s,a}\mu_{t}(s,a)\log\mu_{t}(s,a)$
| $\displaystyle\text{(state-action negative entropy)}.$
|
| (29)

Note that $R=\Phi+\Psi$ .

##
Appendix C Details on Mirror Descent Active Inference

We solve the inner problem $\min_{\pi}\mathcal{G}(\pi)$ , by mirror descent (Bregman proximal gradient)
with the conditional-negative-entropy generator $\Psi$ :

|
| $\mu^{k+1}\in\arg\min_{\mu\in\mathcal{K}}\big\{\langle\nabla\Gamma(\mu^{k}),\mu\rangle+\eta_{k}^{-1}D_{\Psi}(\mu\,\|\,\mu^{k})\big\},$
|
| (30)

where

|
| $D_{\Psi}(\mu\|\mu^{k})=\sum_{t,s}\rho^{\mu}_{t}(s)D_{\mathrm{KL}}(\pi^{\mu}_{t}(\cdot|s)\|\pi^{\mu^{k}}_{t}(\cdot|s))$
|
| (31)

is the Bregman divergence generated by $\Psi$ .
We use $\Psi$ throughout: it yields the
closed-form softmax/DP update below.

######
Proposition 4 (MD-AIF as softmax dynamic programming).

The mirror step (16) with generator $\Psi$ is solved in closed form by the
multiplicative (softmax) policy update

|
| $\pi_{t}^{k+1}(a|s)\;\propto\;\pi_{t}^{k}(a|s)\,\exp\!\big(\eta_{k}\,Q_{t}^{k}(s,a)\big),$
|

where the free-energy action value $Q_{t}^{k}$ is computed by the backward soft recursion

|
| $\displaystyle Q_{T}^{k}$
| $\displaystyle=r_{T}^{k},\quad$
|
| (32)

|
| $\displaystyle Q_{t}^{k}(s,a)$
| $\displaystyle=r_{t}^{k}(s,a)+\sum_{s^{\prime}}p(s^{\prime}|s,a)V_{t+1}^{k}(s^{\prime}),\quad$
|
| (33)

|
| $\displaystyle V_{t}^{k}(s)$
| $\displaystyle=\sum_{a}\pi_{t}^{k}(a|s)\Big[Q_{t}^{k}(s,a)-\eta_{k}^{-1}\log\tfrac{\pi_{t}^{k}(a|s)}{\pi_{t}^{k-1}(a|s)}\Big],$
|
| (34)

with the linearized reward $r_{t}^{k}=-\nabla\Gamma(\mu^{k})_{t}$ .

###### Proof.

The surrogate reward is the negative gradient of the smooth part
$\Gamma=\langle\ell,\mu\rangle+\Phi$ at the current iterate. $\Phi$ depends
on $\mu$ only through the state marginals $\rho_{t}(s)=\sum_{a}\mu_{t}(s,a)$ and differentiating the step- $t$ marginal directly gives
$r_{t}^{k}(s,a)=-\ell_{t}(s,a)-\log\rho_{t}^{k}(s)-1$ . With
$\Psi(\mu)=\sum_{t,s,a}\mu_{t}(s,a)\log\pi^{\mu}_{t}(a|s)$ the Bregman divergence
factorises as

|
| $D_{\Psi}(\mu\|\mu^{k})=\sum_{t,s}\rho^{\mu}_{t}(s)D_{\mathrm{KL}}(\pi^{\mu}_{t}(\cdot|s)\|\pi^{\mu^{k}}_{t}(\cdot|s)).$
|

Substituting $\mu_{t}(s,a)=\rho_{t}(s)\pi_{t}(a|s)$ , the subproblem (16)
becomes, up to $\pi$ -independent terms,

|
| $\min_{\pi}\ \sum_{t,s}\rho_{t}^{\pi}(s)\sum_{a}\pi_{t}(a|s)\Big[-r_{t}^{k}(s,a)+\eta_{k}^{-1}\log\tfrac{\pi_{t}(a|s)}{\pi_{t}^{k}(a|s)}\Big]$
|

subject to (12). Introducing multipliers for
the flow constraints identifies them with the value function $V_{t}^{k}$ and the
action value $Q_{t}^{k}$ above, see [20] for details. For each $(t,s)$ the inner minimization over the
simplex is an entropy-regularised linear program whose stationarity condition
(one multiplier for normalisation) gives the Gibbs solution
$\pi_{t}^{k+1}(a|s)\propto\pi_{t}^{k}(a|s)\exp(\eta_{k}Q_{t}^{k}(s,a))$ . Since
$Q_{t}^{k}$ depends only on $V_{t+1}^{k}$ , a single backward pass $t=T,\dots,0$
solves the system. This is mirror descent modified policy iteration [14, 28, 7] on a finite horizon problem [20].
∎

See 2

###### Proof.

The softmax update solves the mirror descent update on $\Gamma$ with generator $\Psi$ exactly and keeps each iterate interior, so the relative smoothness bound [15, Thm. 3.1] with $\eta=1/L$ holds along the trajectory as long as $\langle\nabla^{2}\Gamma\rangle\leq L\langle\nabla^{2}\Psi\rangle$ , which holds as a direct consequence of Theorem 1 below.
∎

######
Lemma 5 (Markov contraction).

For a Markov kernel $K:\mathcal{Y}\to\mathcal{Z}$ , $\nu>0$ on $\mathcal{Y}$ , signed $v$ on $\mathcal{Y}$ : $\ \|Kv\|_{K\nu}\leq\|v\|_{\nu}$ .

###### Proof.

$(Kv)(z)^{2}=\big(\sum_{y}K(z|y)v(y)\big)^{2}\leq(K\nu)(z)\sum_{y}K(z|y)\tfrac{v(y)^{2}}{\nu(y)}$ by
Cauchy–Schwarz; divide by $(K\nu)(z)$ , sum over $z$ , use $\sum_{z}K(z|y)=1$ .
∎

######
Theorem 1 (Relative smoothness).

On the polytope tangent space $\mathcal{T}\mathcal{K}$ , the EFE $\Gamma$ is $L$ -smooth relative to $\Psi$ on $\mathcal{K}$ with $L=\tfrac{1}{2}T(T+1)$ .

###### Proof.

Relative smoothness for twice differentiable $\Gamma$ and $\Psi$ is the condition $\ \nabla^{2}\Gamma(\mu)\preceq\tfrac{1}{2}T(T+1)\,\nabla^{2}\Psi(\mu)$ on $\mathcal{T}\mathcal{K}$ , see [15]. We read the two Fisher metrics off the identity $R=\Phi+\Psi$ of
Definition˜3 at the level of Bregman divergences. The Bregman divergence of the joint negentropy $R$ is the sum of per-step relative entropies, and is generally linear in the generating function

|
| $\underbrace{\textstyle\sum_{t}D_{\mathrm{KL}}(\mu_{t}\|\mu_{t}^{\prime})}_{D_{R}}=\underbrace{\textstyle\sum_{t}D_{\mathrm{KL}}(\rho_{t}\|\rho_{t}^{\prime})}_{D_{\Phi}}+\underbrace{\textstyle\sum_{t,s}\rho_{t}(s)\,D_{\mathrm{KL}}\!\big(\pi_{t}(\cdot\mid s)\|\pi_{t}^{\prime}(\cdot\mid s)\big)}_{D_{\Psi}}.$
|

The KL-divergence obeys
$D_{\mathrm{KL}}(x,x+\delta x)=\tfrac{1}{2}\|\delta x\|_{x}^{2}+o(\|\delta x\|^{2})$ , where $\|v\|^{2}_{x}=\sum_{i}\frac{v(i)^{2}}{x(i)}$ is the fisher length at $v$ . Expanding each term to second order yields the Pythagorean split of the per-step Fisher metric and identifies all three quadratic forms at once:

|
| $\underbrace{\textstyle\sum_{t}\|\delta\mu_{t}\|^{2}_{\mu_{t}}}_{\nabla^{2}R[\delta\mu]}=\underbrace{\textstyle\sum_{t}\|\delta\rho_{t}\|^{2}_{\rho_{t}}}_{\nabla^{2}\Gamma[\delta\mu]=\nabla^{2}\Phi[\delta\mu]}+\underbrace{\textstyle\sum_{t,s}\rho_{t}(s)\,\|\delta\pi_{t}(\cdot\mid s)\|^{2}_{\pi_{t}}}_{\nabla^{2}\Psi[\delta\mu]}.$
|
| (35)

The only
nonlinear part of $\Gamma$ is $\Phi=-\sum_{t}\mathcal{H}(\rho_{t})$ , and $\Phi$ depends on $\mu$ only through
the linear map $\rho(\cdot)=\sum_{a}\mu(\cdot,a)$ , so its Hessian carries no conditional part,

|
| $\nabla^{2}\Gamma[\delta\mu]=\sum_{t}\|\delta\rho_{t}\|^{2}_{\rho_{t}}.$
|

Second, the $D_{\Psi}$ block of
(35) gives

|
| $\nabla^{2}\Psi[\delta\mu]=\sum_{t}\sum_{s}\rho_{t}(s)\,\|\delta\pi_{t}(\cdot\mid s)\|^{2}_{\pi_{t}}.$
|

Thus $\nabla^{2}\Gamma$ and $\nabla^{2}\Psi$ are the marginal and conditional blocks of the same per-step
Fisher metric. Relative smoothness is the statement that $L\nabla^{2}\Psi$ upper bounds $\nabla^{2}\Gamma$ for some finite $L$ .

The marginal variation $\delta\rho_{t}$ is fully determined by the conditional components $\{\rho_{t^{\prime}}\delta\pi_{t^{\prime}}\}_{t^{\prime}<t}$ through the flow map Eq.˜12. Writing
$w_{t^{\prime}}:=\rho_{t^{\prime}}\!\otimes\!\delta\pi_{t^{\prime}}$ for the conditional component of $\delta\mu_{t^{\prime}}$ (so
$\sum_{s,a}w_{t^{\prime}}=\sum_{s}\rho_{t^{\prime}}\sum_{a}\delta\pi_{t^{\prime}}=0$ ), and linearising $\rho_{t+1}=P_{\pi_{t}}\rho_{t}$
with $\delta\rho_{0}=0$ and $P_{\pi}=\pi\circ P$ gives:

|
| $\delta\rho_{t}=\sum_{t^{\prime}<t}K_{t^{\prime}\to t}\,w_{t^{\prime}},\qquad K_{t^{\prime}\to t}:=\underbrace{P_{\pi_{t-1}}\cdots P_{\pi_{t^{\prime}+1}}}_{\delta\mu_{t^{\prime}}\to\delta\mu_{t}}\,\underbrace{P\vphantom{P_{\pi}}}_{\mu_{t^{\prime}}\to\rho_{t^{\prime}+1}}.$
|

As a composition of row-stochastic kernels, $K_{t^{\prime}\to t}$ is itself a Markov kernel. Applying
Lemma˜5,

|
| $\|K_{t^{\prime}\to t}\,w_{t^{\prime}}\|_{\rho_{t}}\;\leq\;\|w_{t^{\prime}}\|_{\mu_{t^{\prime}}}=\sqrt{\textstyle\sum_{s}\rho_{t^{\prime}}(s)\,\|\delta\pi_{t^{\prime}}(\cdot|s)\|^{2}_{\pi_{t^{\prime}}}}.$
|

The triangle and Cauchy–Schwarz inequalities over the $t$ sources give

|
| $\|\delta\rho_{t}\|^{2}_{\rho_{t}}\leq\Big(\textstyle\sum_{t^{\prime}<t}\|K_{t^{\prime}\to t}w_{t^{\prime}}\|_{\rho_{t}}\Big)^{2}\leq t\sum_{t^{\prime}<t}\sum_{s}\rho_{t^{\prime}}(s)\,\|\delta\pi_{t^{\prime}}(\cdot|s)\|^{2}_{\pi_{t^{\prime}}}$
|

and summing over $t$ with $\sum_{t=0}^{T}t=\tfrac{1}{2}T(T+1)$ gives

|
| $\displaystyle\nabla^{2}\Gamma[\delta\mu]=\sum_{t}\|\delta\rho_{t}\|^{2}_{\rho_{t}}$
| $\displaystyle\leq\tfrac{1}{2}T(T+1)\sum_{t^{\prime}}\sum_{s}\rho_{t^{\prime}}(s)\,\|\delta\pi_{t^{\prime}}(\cdot|s)\|^{2}_{\pi_{t^{\prime}}}$
|

|
|
| $\displaystyle=\tfrac{1}{2}T(T+1)\,\nabla^{2}\Psi[\delta\mu],$
|

i.e. $\Gamma$ is $L$ -smooth relative to $\Psi$ on the flow-polytope tangent with $L=\tfrac{1}{2}T(T+1)$ .
∎

##
Appendix D History dependent and infinite horizon formulations

The episodic memoryless development of Appendices˜B, C and E transfers to history-dependent policies and posterior densities, as well as to the
discounted and average-reward settings with appropriate extensions of the standard EFE definition.

###
D.1 History-dependence

Consider the finite-horizon reward-free POMDP
$\mathcal{M}=(\mathcal{S},\mathcal{A},\mathcal{O},P,E,\sigma)$ as before.
Further, let the history at time
$t$ be $h_{t}=(o_{0:t},a_{0:t-1})$ , updated by $h_{t+1}=h_{t}\cdot(a_{t},o_{t+1})$
with $h_{0}=(o_{0})$ , and let $\mathcal{H}=\bigcup_{t<T}(\mathcal{A}\times\mathcal{O})^{t}\times\mathcal{O}$ be the
space of histories. The behavior policy $\beta:\mathcal{H}\times\mathcal{T}\to\Delta(\mathcal{A})$
in the history-dependent case is of the form

|
| $\beta(a_{t}|h_{t})=\sum_{s_{t}}\pi(a_{t}|h_{t},s_{t})\nu(s_{t}|h_{t})$
|
| (36)

and induces the environment trajectory law

|
| $p^{\beta}(\tau)=\sigma(s_{0})E(o_{0}|s_{0})\prod_{t=0}^{T-1}\,\beta(a_{t}|h_{t})P(s_{t+1}|s_{t},a_{t})E(o_{t+1}|s_{t+1}).$
|
| (37)

Given a model $m=(p,\nu)$ with history-dependent variational density $\nu(s_{t}|h_{t})$ , a latent policy $\pi(a_{t}|h_{t},s_{t})$ induces the purely imagined trajectory law

|
| $q^{\pi}(\tau;m)=q_{0}(s_{0})\,p(o_{0}|s_{0})\prod_{t=0}^{T-1}\pi_{t}(a_{t}|h_{t},s_{t})\,p(s_{t+1}|s_{t},a_{t})\,p(o_{t+1}|s_{t+1}),$
|
| (38)

with predictive history-state marginals $\rho^{\pi}_{t}(s,h)=\mathbb{P}_{\pi}(s_{t}=s,h_{t}=h)$ .

######
Lemma 6 (Augmented-state recursion).

For history-dependent variational density $\nu(s_{t}|h_{t})$ , define the augmented state space
$\mathcal{X}=\mathcal{H}\times\mathcal{S}$ and the augmented kernel

|
| $p(x^{\prime}|x,a)=p\big((s^{\prime},h^{\prime})|(s,h),a\big)=\mathbf{1}[h^{\prime}=h\cdot(a,o^{\prime})]\,p(o^{\prime}|s^{\prime})\,p(s^{\prime}|s,a).$
|
| (39)

Then the imagined process (38) satisfies

|
| $\rho_{0}^{\pi}=q_{0},\qquad\rho_{t+1}^{\pi}(x^{\prime})=\sum_{x,a}p(x^{\prime}|x,a)\,\pi_{t}(a|x)\,\rho_{t}^{\pi}(x),$
|
| (40)

where $\rho^{\pi}_{t}((s,h))=\mathbb{P}(s_{t}=s,h_{t}=h)$ are the history-state marginals of the trajectory distribution $q$ at time $t$ .

###### Proof.

The imagined law (38) is a product of per-step
kernels, hence the law of a Markov process, and $h_{t}=(o_{0:t},a_{0:t-1})$ is a
deterministic function of the prefix, so $x_{t}=(h_{t},s_{t})$ is determined by it.

Condition on the prefix $(s_{0:t},o_{0:t},a_{0:t-1})$ together with $a_{t}$ . The
only factors carrying the next variables are $p(s_{t+1}|s_{t},a_{t})\,p(o_{t+1}|s_{t+1})$ ,
so $(s_{t+1},o_{t+1})$ has conditional law $p(s^{\prime}|s_{t},a_{t})\,p(o^{\prime}|s^{\prime})$ ,
depending on the past only through $(s_{t},a_{t})$ ; and $h_{t+1}=h_{t}\cdot(a_{t},o_{t+1})$
is a deterministic function of $(h_{t},a_{t},o_{t+1})$ . Since the append is injective,
for fixed $(h,a,h^{\prime})$ at most one $o^{\prime}$ satisfies $h^{\prime}=h\cdot(a,o^{\prime})$ , so marginalising
$o_{t+1}$ gives

|
| $\displaystyle p(x^{\prime}|x,a)$
| $\displaystyle=\Pr\!\big[x_{t+1}=(h^{\prime},s^{\prime})|x_{t}=(h,s),\,a_{t}=a\big]$
|
| (41)

|
|
| $\displaystyle=\sum_{o^{\prime}}\mathbf{1}[h^{\prime}=h\cdot(a,o^{\prime})]\,p(o^{\prime}|s^{\prime})\,p(s^{\prime}|s,a),$
|
| (42)

which depends on the past only through $(x_{t},a_{t})$ : $(x_{t})_{t}$ is a controlled
Markov chain with the augmented kernel. The action satisfies
$a_{t}\sim\pi_{t}(\cdot|h_{t},s_{t})=\pi_{t}(\cdot|x_{t})$ , so the law of total
probability gives

|
| $\displaystyle\rho_{t+1}^{\pi}(x^{\prime})$
| $\displaystyle=\sum_{x,a}\Pr\!\big[x_{t+1}=x^{\prime}|x_{t}=x,a_{t}=a\big]\,\pi_{t}(a|x)\,\rho_{t}^{\pi}(x)$
|
| (43)

|
|
| $\displaystyle=\sum_{x,a}p(x^{\prime}|x,a)\,\pi_{t}(a|x)\,\rho_{t}^{\pi}(x),$
|
| (44)

which is (40), where $\rho_{t}^{\pi}(x)$ is written as a measure on $\mathcal{X}$ . The base case fixes $\rho_{0}^{\pi}$ to the law of the
initial augmented state $x_{0}=(h_{0},s_{0})$ prescribed by (38), written
$q_{0}$ as a measure on $\mathcal{X}$ .
∎

In the history-dependent case, we would define the EFE as

|
| $\mathcal{E}(\pi;m)=\sum_{t=0}^{T}\sum_{x\in\mathcal{X}}\sum_{a\in\mathcal{A}}\pi_{t}(a|x)\,\rho_{t}^{\pi}(x)\left[\log\rho_{t}^{\pi}(x)-\sum_{o\in\mathcal{O}}p(o|s)\log\tilde{p}(x)\right],$
|
| (45)

where we overload notation and write $\log\tilde{p}(x)=\log\tilde{p}(s,o)$ as a density on $\mathcal{X}$ .

See 2

###### Proof.

Lemma˜6 applies directly to $\mathcal{E}$ , so the optimization problem

|
| $\min_{\pi}\mathcal{E}(\pi;m)$
|
| (46)

is a convex MDP, but on the augmented state-space $\mathcal{X}$ .
∎

######
Remark 1 (Augmented state in practice).

The history component of $x\in\mathcal{X}$ makes $|\mathcal{X}|$ grow with $t$ . In a function-approximation implementation, $h$ is typically summarised by a
recurrent state, e.g. write $x=f(h,s)$ . Replace $s\to x$ and the tabular sweeps of Algorithm˜1 remain unchanged. The memoryless variant
(Definition˜2) drops $h$ entirely and recovers a standard $\mathcal{S}$ -state
convex-MDP solver.

###
D.2 Infinite-horizon formulations

Extending the EFE to the infinite horizon introduces a choice absent in the finite-horizon case: how the future is aggregated inside the nonlinear entropy term (cf. Table˜1). Throughout we work in the stationary regime where $\mathcal{M}$ , $\ell$ , and $\pi$ are time-homogeneous on the augmented state $x=f(h,s)$ of Remark˜1, now over $t\in\mathbb{N}$ .

#### Discounted occupancy.

Fix $\gamma\in(0,1)$ and a stationary $\pi$ . The normalized discounted occupancy

|
| $d^{\pi}(x,a)=(1-\gamma)\sum_{t=0}^{\infty}\gamma^{t}\,\mu_{t}^{\pi}(x,a),\qquad\sum_{x,a}d^{\pi}(x,a)=1,$
|
| (47)

collapses the time-indexed flow constraints (12), summed against the weights $(1-\gamma)\gamma^{t}$ , into the single Bellman-flow constraint

|
| $\sum_{a}d^{\pi}(x^{\prime},a)=(1-\gamma)\,q_{0}(x^{\prime})+\gamma\sum_{x,a}p(x^{\prime}|x,a)\,d^{\pi}(x,a),\qquad x^{\prime}\in\mathcal{X}.$
|
| (48)

The discounted occupancy polytope $\mathcal{K}_{\gamma}=\{d\in\Delta(\mathcal{X}\times\mathcal{A}):\eqref{eq:disc-flow}\}$ is again compact convex, and on full-support policies $\pi\mapsto d^{\pi}$ is a bijection with inverse $\pi(a|x)=d(x,a)/d(x)$ (Definition˜1).

#### Two aggregation conventions.

Since entropy is not additive across the discount weights, the finite-horizon objective $\mathcal{G}=\langle\ell,\mu\rangle-\sum_{t}\mathcal{H}(\rho_{t})$ has two inequivalent stationary analogues.

(a) Aggregate, then score. Apply the entropy to the single aggregate occupancy,

|
| $\mathcal{G}_{\gamma}^{\mathrm{agg}}(\pi)=\langle\ell,d^{\pi}\rangle-\mathcal{H}\big(d^{\pi}(x)\big)=\langle\ell,d^{\pi}\rangle+\Phi(d^{\pi}),$
|
| (49)

the maximum-entropy-exploration objective of [11]. This is a linear functional minus the entropy of a single $d\in\mathcal{K}_{\gamma}$ , hence convex, and is the cleanest extension: all of Appendices˜B and C applies with $\mu_{t}$ replaced by $d$ and the finite recursion of Proposition˜4 by the stationary soft-Bellman fixed point

|
| $\displaystyle Q^{k}(x,a)$
| $\displaystyle=r^{k}(x,a)+\gamma\sum_{x^{\prime}}p(x^{\prime}|x,a)\,V^{k}(x^{\prime}),$
|
| (50)

|
| $\displaystyle V^{k}(x)$
| $\displaystyle=\textstyle\sum_{a}\pi^{k}(a|x)\big[Q^{k}(x,a)-\eta_{k}^{-1}\log\tfrac{\pi^{k}(a|x)}{\pi^{k-1}(a|x)}\big],$
|
| (51)

with $r^{k}=-\nabla(\langle\ell,d\rangle+\Phi)(d^{k})$ , solved to a contraction tolerance inside each mirror step. The natural-gradient reading and $O(1/K)$ rate carry over with the discounted relative-smoothness constant [14].

(b) Score, then aggregate. Apply the entropy per step,

|
| $\mathcal{G}_{\gamma}^{\mathrm{step}}(\pi)=\sum_{t=0}^{\infty}\gamma^{t}\Big[\langle\ell,\mu_{t}^{\pi}\rangle-\mathcal{H}\big(\mu_{t}^{\pi}(x,a)\big)\Big],$
|
| (52)

the term-by-term analogue of the finite-horizon EFE. By strict concavity of $\mathcal{H}$ on the mixture $d^{\pi}=(1-\gamma)\sum_{t}\gamma^{t}\mu_{t}^{\pi}$ ,

|
| $\mathcal{H}\big(d^{\pi}\big)\;\geq\;(1-\gamma)\sum_{t}\gamma^{t}\,\mathcal{H}\big(\mu_{t}^{\pi}\big),$
|
| (53)

with equality iff all $\mu_{t}^{\pi}$ coincide; hence (a) $\neq$ (b), the aggregate convention crediting occupancy spread across time as if spread within a step. Objective (52) is convex in $(\mu_{t})_{t}$ but not a function of $d$ alone, so it must be optimized over per-step occupancies (truncated at $\sim(1-\gamma)^{-1}$ ), and the backward recursion no longer collapses to a single fixed point.

#### Average-reward limit.

As $\gamma\to 1$ , convention (a) yields the stationary occupancy

|
| $d^{\pi}_{\infty}(x,a)=\lim_{T\to\infty}\frac{1}{T}\sum_{t=0}^{T-1}\mu_{t}^{\pi}(x,a),$
|
| (54)

which requires more than Assumption 2: under a unichain assumption [23] on

$p_{\pi}(x^{\prime}|x)=\sum_{a}p(x^{\prime}|x,a)\pi(a|x)$ , every stationary $\pi$ induces a unique $d_{\infty}^{\pi}$ independent of $q_{0}$ and the limit exists. The per-step averages $\bar{\ell}(\pi)=\lim_{T}\frac{1}{T}\sum_{t}\mathbb{E}_{\mu_{t}^{\pi}}[\ell]$ and $\bar{\mathcal{H}}(\pi)=\lim_{T}\frac{1}{T}\sum_{t}\mathcal{H}(\mu_{t}^{\pi})$ again satisfy $\bar{\mathcal{H}}(\pi)\geq\mathcal{H}(d_{\infty}^{\pi})$ , so aggregation and EFE computation do not commute. The convex-MDP structure and the mirror/natural-gradient solver survive in average-reward form for $\mathcal{H}(d_{\infty}^{\pi})$ , e.g. [1]; the full AIF loop we leave to future work.

##
Appendix E Performative active inference

In the design of MD-AIF, we made the strong assumption, that the learned model stays fixed during policy optimization. However, the interesting question is whether the optimization problem remains well-posed if the agent is allowed to update its model during policy optimization, which would restore the AIF problem in full spirit. Consider, for example, the Algorithm 2. From the optimized policy’s perspective, now both the reward and the dynamics are functions of the policy, or equivalently, the occupancy. This puts AIF squarely into the framework of performative RL [16, 24].

Algorithm 2 Performative MD-AIF with variable world model (sketch).

1:initial world model $m^{0}=(p^{0},\nu^{0})$ ; horizon $T$ ; initial policy $\pi^{0}$ ; iterations $K$ .

2:initialise $\pi^{0}_{t}(\cdot|x)\leftarrow\bar{\pi}_{t}(\cdot|x)$ (or uniform) for all $t,x$

3:for $k=0,1,\dots,K-1$ do

4:   $m^{k+1}\leftarrow\text{MIN-VFE}(m^{k};\pi^{k})$

5:   $\tilde{p}^{k+1},q^{k+1}_{0}\leftarrow\text{Extract}(m^{k+1})$

6:   $\pi^{k+1}\leftarrow\text{MD-AIF}(\pi^{k};m^{k+1},\tilde{p}^{k+1},T,\eta,q^{k+1}_{0})$

7:return $\pi^{K}$

To see this, consider the one pass of the full loop (2). Deploying $\pi$ (behavior $\beta=\pi\circ\nu$ ) in the real environment induces the
history distribution $\mathcal{D}(\pi)$ ; the perception step returns the VFE-optimal model

|
| $m^{\star}(\mathcal{D}(\pi))\in\arg\min_{m\in\mathcal{M}}\mathcal{F}\big(m;\mathcal{D}(\pi)\big)\;=:\;\big(p_{\pi},\nu_{\pi}\big),$
|

and this refit model is what the planner sees: it supplies a linear pseudo-cost
$\ell_{\pi}$ and the augmented transition kernel $P_{\pi}$ of Lemma˜6,

|
| $\ell_{\pi}:=\ell\big(m^{\star}(\mathcal{D}(\pi))\big),\qquad P_{\pi}:=p\big(m^{\star}(\mathcal{D}(\pi))\big).$
|

Thus the decision-dependence is the composition

|
| $\pi\ \xmapsto{\ \mathcal{D}\ }\ \mathcal{D}(\pi)\ \xmapsto{\ \mathrm{VFE}\ }\ m^{\star}(\mathcal{D}(\pi))\ \xmapsto{\quad}\ \big(\ell_{\pi},P_{\pi}\big),$
|

i.e. it runs through the agent’s own model-learning step, not through a
primitive environment response: the reward and dynamics react to $\pi$ only because
the model is refit to $\pi$ ’s data. Passing to occupancies through the normalisation
$\pi^{\mu}(a|x)=\mu(x,a)/\sum_{b}\mu(x,b)$ (cf. [16], eq. (2)), set
$\ell_{\mu}:=\ell_{\pi^{\mu}}$ , $P_{\mu}:=P_{\pi^{\mu}}$ , and the EFE pseudo-reward $r_{\mu}:=-\ell_{\mu}$ .

######
Assumption 1 (Smoothness of performative map; cf. [16]).

We assume the model-learning loop is $(\varepsilon_{r},\varepsilon_{p})$ -sensitive: for all
occupancies $\mu,\mu^{\prime}$ ,

|
| $\|\ell_{\mu}-\ell_{\mu^{\prime}}\|\leq\varepsilon_{r}\,\|\mu-\mu^{\prime}\|,\qquad\|P_{\mu}-P_{\mu^{\prime}}\|\leq\varepsilon_{p}\,\|\mu-\mu^{\prime}\|.$
|

This is [16], Assumption 1, transported onto the refit map
$\mu\mapsto m^{\star}(\mathcal{D}(\pi^{\mu}))$ ; the proof below uses only continuity of
$\mu\mapsto(\ell_{\mu},P_{\mu})$ .

######
Definition 4 (Performative mirror operator).

Let $\Pi=\prod_{t=0}^{T}\prod_{x\in\mathcal{S}}\Delta(\mathcal{A})$ be the (episodic) policy simplex. Deploying $\pi\in\Pi$ induces the model $m_{\pi}=m^{\star}(\mathcal{D}(\pi))$ ,
the occupancy $\mu^{\pi}\in\mathcal{K}(m_{\pi})$ , and the linearized reward

|
| $r^{\pi}_{t}=-\big(\nabla_{\mu}\Gamma(\mu;m_{\pi})\big|_{\mu=\mu^{\pi}}\big)_{t}.$
|

Let $Q^{\pi}$ be the soft
action-value produced from $r^{\pi}$ by the backward recursion of Proposition˜4 under $m_{\pi}$ .
The performative mirror operator $\mathcal{P}:\Pi\to\Pi$ is the single step

|
| $\mathcal{P}(\pi)_{t}(a|x)\;=\;\frac{\pi_{t}(a|x)\,\exp\!\big(\eta\,Q^{\pi}_{t}(x,a)\big)}{\sum_{b}\pi_{t}(b|x)\,\exp\!\big(\eta\,Q^{\pi}_{t}(x,b)\big)}.$
|
| (55)

A fixed point $\pi^{\star}=\mathcal{P}(\pi^{\star})$ is a performatively stable point.

######
Assumption 2 (Support floor).

For the fixed model $m=(p,\nu)$ in the model class, there exists an $\,\epsilon_{0}>0$ with
$p(s^{\prime}|s,a)\geq\epsilon_{0}$ , $p(o|s)>0$ , $q_{0}(s)>0$ ;
$\mathcal{M}$ (tabular, floored at $\epsilon_{0}$ ) is compact convex.

######
Proposition 5 (Existence).

Under Assumption 2 and the sensitivity assumption 1, $\mathcal{P}$ has a fixed point.

###### Proof.

$\Pi$ is a nonempty compact convex polytope. The map $\mathcal{P}$ of (55) is
single-valued and maps into $\Pi$ , since each $\mathcal{P}(\pi)_{t}(\cdot|s)$ is an explicit
normalised positive vector in $\Delta(\mathcal{A})$ . Further, it is continuous, since the softmax is
smooth and $\pi\mapsto Q^{\pi}$ is a finite composition of continuous maps in $m_{\pi}$ , which
depends continuously on $\pi$ by Assumption 1. Brouwer’s theorem gives
$\pi^{\star}=\mathcal{P}(\pi^{\star})$ .
∎

######
Remark 2 (Fixed points are inner-optimal).

At a fixed point $\pi^{\star}=\mathcal{P}(\pi^{\star})$ the multiplicative update (55) is
inactive, so $Q^{\pi^{\star}}_{t}(x,a)$ is constant across $\operatorname{supp}\pi^{\star}_{t}(\cdot|x)$ .
With $Q^{\pi^{\star}}=-\nabla\Gamma_{\pi^{\star}}(\mu^{\pi^{\star}})$ this is the variational inequality

|
| $\big\langle\nabla\Gamma_{\pi^{\star}}(\mu^{\pi^{\star}}),\,\mu-\mu^{\pi^{\star}}\big\rangle\ \geq\ 0\qquad\forall\,\mu\in\mathcal{K}(m_{\pi^{\star}}),$
|
| (56)

the first-order condition for $\min_{\mu}\Gamma_{\pi^{\star}}(\mu)$ . Since $\Gamma_{\pi^{\star}}$ is convex
(Proposition˜1), (56) is sufficient for global optimality. With action-complexity (or an additional
$\Psi$ -regulariser), the joint-entropy barrier of Proposition˜1 keeps the optimum
interior and existence (Proposition˜5) yields a performatively stable point. Without action complexity, only the support-stationary point of (56), as (55) cannot populate an unplayed action.

##
Appendix F Experimental details

###
F.1 Convergence experiment

A deterministic $5\times 5$ grid with four actions (left, right, up, down);
wall collisions result in staying in place.
The agent starts at the top-left corner (state $0$ ) and the goal is at
the bottom-right corner (state $24$ ).
The preference distribution is

|
| $\log\tilde{p}(s)\propto-\alpha\,d(s,s_{\rm goal}),\qquad\alpha=0.5,$
|
| (57)

where $d$ is the Manhattan distance, normalised to a probability simplex.

Methods.
Three optimizers are compared on the EFE objective
with planning horizon $H=12$ and $K=100$ iterations each.

-
•

MD-AIF (Algorithm˜1).
Mirror-descent with the conditional-entropy generator $\Psi$ ,
constant step size $\eta=0.05$ , matching the assumption of Proposition˜2.
The linearized reward at iteration $k$ is
$r_{t}^{k}(s,a)=\log\tilde{p}(s)-\log\rho_{t}^{k}(s)$ ,
combining the preference term and the novelty term
$-\log\rho_{t}^{k}(s)$ that rewards imagined states currently
under low occupancy.
Policy initialised uniformly.

-
•

RL (greedy, no novelty).
Identical to MD-AIF but with the novelty term removed,
i.e. $r_{t}^{k}(s,a)=\log\tilde{p}(s)$ .
This reduces to soft value iteration on a static reward,
equivalent to entropy-regularised policy gradient toward $\tilde{p}$ .

-
•

EFE gradient descent.
Euclidean gradient descent on $\Gamma$ directly in the softmax
logit space $\theta_{t}\in\mathbb{R}^{S\times A}$ , using exact
reverse-mode autodiff through the occupancy recursion
$\rho_{t+1}(s^{\prime})=\sum_{s,a}\hat{p}(s^{\prime}|s,a)\pi_{t}(a|s)\rho_{t}(s)$ .
Constant step size $\eta=0.05$ .

#### Convergence plot.

The y-axis shows $\Gamma(\rho^{k})-\Gamma^{\star}$ , where $\Gamma^{\star}$ is
the minimum across all three methods and all iterates.
The $O(1/k)$ reference line is fitted to MD-AIF’s initial gap:
$C/k$ with $C=\Gamma(\rho^{0})-\Gamma^{\star}$ .
Both axes are logarithmic.

#### Occupancy snapshots.

For each method at convergence ( $k=K$ ), the per-step imagined state
occupancy $\rho_{t}(s)$ is shown at five evenly spaced timesteps
$t\in\{0,\lfloor H/4\rfloor,\lfloor H/2\rfloor,\lfloor 3H/4\rfloor,H\}=\{0,3,6,9,12\}$ .
Both MD-AIF and RL use the same color scale so occupancy
concentrations are directly comparable across rows.

###
F.2 Model-learning experiment

A deterministic $10\times 10$ grid ( $S=100$ states, $A=4$ actions).
Start: top-left (state $0$ ); goal: bottom-right (state $99$ ).
The log-preference is uniform ( $\log\tilde{p}(s)=\mathrm{const}$ )
so the EFE reduces to pure state-entropy maximization;
the only drive is the novelty term $-\log\rho_{t}^{k}(s)$ .

Algorithms.
Each of $R=20$ rounds proceeds as follows:

-
1.

Run $K=120$ policy-optimization steps on the current estimated
transition model $\hat{p}$ (one mirror/gradient step per inner iteration).

-
2.

Deploy the resulting policy: sample $E=5$ episodes of length $H=25$
from the true environment by ancestral sampling
( $a_{t}\sim\pi_{t}(\cdot|s_{t})$ , $s_{t+1}\sim p^{\star}(\cdot|s_{t},a_{t})$ ).

-
3.

Refit $\hat{p}$ by Dirichlet-MAP with pseudocount $\alpha_{0}=10^{-3}$ :

|
| $\hat{p}(s^{\prime}|s,a)=(N(s,a,s^{\prime})+\alpha_{0})/\sum_{s^{\prime\prime}}(N(s,a,s^{\prime\prime})+\alpha_{0}).$
|

Both the policy optimization and the model update use a constant step
size $\eta=0.05$ throughout (no decay).
Four planning algorithms are compared. All share the same deployment and
refitting procedure.

-
•

MD-AIF. Mirror-descent EFE minimization (Algorithm˜1), $\eta=0.05$ .

-
•

RL. MD-AIF without entropy.

-
•

EFE gradient descent. Euclidean gradient on logits,
$\eta=0.05$ .

-
•

AIF $T{=}3$ (exact, [5]). For each state $s$ , enumerate all
$4^{3}=64$ action sequences of length $T_{\rm dc}=3$ , evaluate
$G(\pi|s)=\sum_{t^{\prime}>t}\sum_{s^{\prime}}b_{t^{\prime}}(s^{\prime})\log b_{t^{\prime}}(s^{\prime})$ for belief state $b$ , form $\pi\propto\sum_{\text{seq}:a_{0}=a}\exp(-G(\text{seq}|s))$ ,
and marginalise.

-
•

AIF $T{=}5$ (MC). Same as above but with
$T_{\rm dc}=5$ and $N_{\rm mc}=100$ randomly sampled sequences
per policy computation (Monte Carlo).

#### Evaluation.

After each deployment round the model error is measured as the mean
total-variation distance between the estimated and true kernels:

|
| $\overline{\mathrm{TV}}(\hat{p},p^{\star})=\frac{1}{SA}\sum_{s,a}\tfrac{1}{2}\|\hat{p}(\cdot|s,a)-p^{\star}(\cdot|s,a)\|_{1}.$
|
| (58)

The x-axis reports cumulative environment steps. The grey dashed line marks the error of the Dirichlet-MAP estimate with no data (prior only):
$\overline{\mathrm{TV}}\approx(S-1)/S=(100-1)/100=0.99$ .
