---
title: "What Type of Inference is Active Inference?"
source: "https://arxiv.org/abs/2606.04935"
author:
  - "[[Wouter W. L. Nuijten]]"
  - "[[Mykola Lukashchuk]]"
  - "[[Thijs van de Laar]]"
  - "[[Bert de Vries]]"
published: 2026-06-03
created: 2026-08-09
description: "Proves the VFE of the epistemic-prior-augmented generative model equals the VFE of the predictive model plus explicit entropy corrections; separates the planning correction from the epistemic corrections; ablations show the novelty correction (information gain about model parameters) is the one that matters."
tags:
  - "clippings"
---

[2606.04935] What Type of Inference is Active Inference?

# What Type of Inference is Active Inference?

Wouter W. L. Nuijten

Affiliation: Department of Electrical Engineering

Eindhoven University of Technology

Eindhoven, the Netherlands

Affiliation: Lazy Dynamics

Utrecht, the Netherlands

  
Mykola Lukashchuk

Affiliation: Department of Electrical Engineering

Eindhoven University of Technology

Eindhoven, the Netherlands

  
Thijs van de Laar

Affiliation: Department of Electrical Engineering

Eindhoven University of Technology

Eindhoven, the Netherlands

  
Bert de Vries

Affiliation: Department of Electrical Engineering

Eindhoven University of Technology

Eindhoven, the Netherlands

Affiliation: Lazy Dynamics

Utrecht, the Netherlands

###### Abstract

Active inference casts decision-making as inference, with the Expected Free Energy (EFE) unifying goal-directed and information-seeking behavior.
Recent work showed that EFE minimization can be written as Variational Free Energy (VFE) minimization on a generative model augmented with epistemic priors.
We prove that the VFE of the augmented model can be rewritten as the VFE of the predictive model plus explicit entropy-correction terms, making the EFE contribution transparent.
We then show that proper EFE-based planning requires combining these epistemic corrections with a planning correction that turns marginal inference into policy optimization, yielding a full variational characterization of EFE-based planning.
This clarifies which corrections are needed for cross-entropy planning and for full EFE-based planning.
The same entropy-corrected formulation leads to a detailed message-passing scheme for EFE-based planning together with simpler ablations.
Experiments on three grid-world environments show that full EFE-based planning outperforms ablations that omit either the planning correction or the epistemic corrections.

## 1 Introduction

Sequential decision-making under uncertainty requires balancing exploitation of current knowledge against exploration to reduce uncertainty.
Classical reinforcement learning and optimal control address this through value functions or policy optimization [32, 3], but typically treat reward maximization and uncertainty reduction as separate objectives.

Planning-as-Inference (PAI) offers an alternative by casting control as probabilistic inference [2, 36], connecting control to variational inference and message passing [17].
Standard PAI methods optimize objectives such as expected utility or cross-entropy to preferences, but do not include an explicit epistemic drive to reduce environmental uncertainty.

Active inference (AIF) addresses this by minimizing the Expected Free Energy (EFE), unifying instrumental and epistemic objectives [12, 8].
22 showed that EFE minimization can be reformulated as Variational Free Energy (VFE) minimization on a model augmented with epistemic priors.
This brings active inference into the variational framework, but leaves open a key distinction: obtaining EFE inside a marginal variational objective is not yet the same as planning over policies.
Proper planning additionally requires the planning correction of 19.
This paper makes that separation explicit and derives a message-passing scheme for the combined objective.
Our contributions are:

- •

We show that proper EFE-based planning requires combining two entropy corrections: the planning correction of 19, which turns the expected-utility variational objective into policy optimization, and the epistemic corrections of 22, which turn marginal VFE minimization into EFE minimization. Together they yield a full variational characterization of EFE-based planning.

- •

We derive a principled message-passing family for these entropy-corrected objectives. Each added entropy term induces a corresponding channel reparameterization that resolves the circularity of posterior-dependent epistemic priors, and recovers both belief propagation and full active-inference planning within the same derivation.

- •

We validate the framework on three grid-world environments. They differ in where the value of information gathering lies: in some, sensing actions change the observation model itself; in others, a sensing action’s only value is novelty, the expected information gain about latent parameters. The alternating heuristic of 21 finds epistemic actions only in the first case; only the current joint scheme captures novelty.

## 2 Background

### 2.1 Generative Model for Sequential Decision-Making

We consider an agent that maintains a generative model predicting future observations, states, and the consequences of actions.
Following standard conventions [17, 19], we write this as a rollout model:

|
| $\displaystyle p(\bm{y},\bm{x},\bm{u},\theta)={}$
| $\displaystyle p(\theta)p(x_{0})\prod_{t=1}^{T}p(y_{t}|x_{t},\theta)$
|

|
|
| $\displaystyle\cdot p(x_{t}|x_{t-1},u_{t},\theta)\,p(u_{t})\,,$
|
| (1)

where $\bm{x}=(x_{0},\ldots,x_{T})$ are latent states, $\bm{y}=(y_{1},\ldots,y_{T})$ are observations, $\bm{u}=(u_{1},\ldots,u_{T})$ are actions, and $\theta$ are unknown model parameters.
Here $t=0$ denotes the current time, and the model predicts a rollout into the future over horizon $T$ .
The dynamics $p(x_{t}|x_{t-1},u_{t},\theta)$ may depend on parameters $\theta$ , capturing model uncertainty.
Throughout this paper we work in the discrete regime, so all integrals over $(y_{t},x_{t},\theta)$ in what follows reduce to finite sums.

To encode goals, we augment the model with preference priors $\hat{p}(x_{t})$ and $\hat{p}(y_{t})$ over desired states and observations [17]:

|
| $\displaystyle\hat{p}(\bm{y},\bm{x},\bm{u},\theta)\propto{}$
| $\displaystyle p(\theta)p(x_{0})\prod_{t=1}^{T}p(y_{t}|x_{t},\theta)\,p(x_{t}|x_{t-1},u_{t},\theta)$
|

|
|
| $\displaystyle\cdot p(u_{t})\,\hat{p}(x_{t})\,\hat{p}(y_{t})\,.$
|
| (2)

These preference priors can be understood as proportional to exponentiated rewards: $\hat{p}(x)\propto\exp(R(x))$ , connecting planning-as-inference to reward maximization [35].
Together, the rollout model (2) with preferences $\hat{p}(x_{t})$ and $\hat{p}(y_{t})$ defines our planning problem over horizon $T$ : find a policy $q(u_{t}|x_{t-1})$ whose induced predicted trajectory agrees with the preferences.

### 2.2 Variational Free Energy

Given a generative model, variational inference approximates the posterior by minimizing the Variational Free Energy over a family of tractable distributions $q$ [4]:

|
| $F_{\hat{p}}[q]=\mathbb{D}_{\mathrm{KL}}\left[q(\bm{y},\bm{x},\bm{u},\theta)\|\hat{p}(\bm{y},\bm{x},\bm{u},\theta)\right]\,.$
|
| (3)

Since all variables are unobserved in the planning setting (they represent future quantities), minimizing $F_{\hat{p}}[q]$ yields beliefs about future trajectories that are consistent with both the dynamics and the preference priors.

### 2.3 Factor Graphs and the Bethe Approximation

The generative model (2) factorizes into local terms, which can be represented as a Forney-style factor graph (FFG) [10, 18].
In an FFG, nodes represent factors (probability distributions) and edges represent variables; an edge connects to a node when the variable appears in that factor’s scope.
We write $\mathcal{E}(a)$ for the set of edges (variables) adjacent to factor node $a$ , and $\mathcal{V}(i)$ for the set of factor nodes adjacent to edge $i$ . The variables in the scope of factor $a$ are denoted $\bm{s}_{a}$ .

The Bethe approximation [40] exploits this structure by constraining the variational distribution to respect the factorization induced by the graph.
Each node $a$ maintains a local belief $q_{a}(\bm{s}_{a})$ over its adjacent variables $\bm{s}_{a}$ , and each edge $i$ maintains a singleton belief $q_{i}(s_{i})$ .
These beliefs must satisfy local consistency constraints:

|
| $\int q_{a}(\bm{s}_{a})\,\mathrm{d}\bm{s}_{a\setminus i}=q_{i}(s_{i})\quad\text{for all }i\in\mathcal{E}(a)\,.$
|
| (4)

Under these constraints, with entropy corrections that prevent double-counting of shared variables, the VFE reduces to the Bethe Free Energy:

|
| $\displaystyle F_{\text{Bethe}}[q]={}$
| $\displaystyle\sum_{a\in\mathcal{V}}\mathbb{D}_{\mathrm{KL}}\left[q_{a}(\bm{s}_{a})\|f_{a}(\bm{s}_{a})\right]$
|

|
|
| $\displaystyle+\sum_{i\in\mathcal{E}}(d_{i}-1)\,\mathbb{H}\left[q_{i}(s_{i})\right]\,,$
|
| (5)

where $\mathcal{V}$ is the set of nodes, $\mathcal{E}$ is the set of edges, $f_{a}$ is the factor at node $a$ , and $d_{i}$ is the degree (number of connected nodes) of edge $i$ .
Minimizing the Bethe Free Energy via message passing yields the belief propagation algorithm; on tree-structured graphs, this recovers exact marginals [28].
Details are provided in Appendix C.

### 2.4 Epistemic Priors

Standard variational inference does not distinguish between variable types: actions, states, observations, and parameters all enter the VFE symmetrically.
22 clarified the epistemic priors $\tilde{p}(u_{t})$ , $\tilde{p}(x_{t})$ , and $\tilde{p}(y_{t},x_{t})$ that encode which variables are controlled, inferred, or observed.
These priors augment the generative model:

|
| $\displaystyle\tilde{p}(\bm{y},\bm{x},\bm{u},\theta)\propto{}$
| $\displaystyle\hat{p}(\bm{y},\bm{x},\bm{u},\theta)$
|

|
|
| $\displaystyle\prod_{t=1}^{T}\tilde{p}(u_{t})\,\tilde{p}(x_{t})\,\tilde{p}(y_{t},x_{t})\,.$
|
| (6)

Each prior is defined in terms of entropies of conditionals11
1

We write $\mathrm{h}\!\left[q(y|x)\right]$ for the entropy of the conditional $q(y|x)$ , a function of $x$ , and $\mathbb{H}\left[q(y|x)\right]$ for the conditional entropy, a scalar: $\mathbb{H}\left[q(y|x)\right]=\mathbb{E}_{q(x)}\left[\mathrm{h}\!\left[q(y|x)\right]\right]$ . of the variational distribution $q$ :

|

|
| $\displaystyle\tilde{p}(u_{t})\propto\exp\bigl(\mathrm{h}\!\left[q(x_{t},x_{t-1}|u_{t})\right]-\mathrm{h}\!\left[q(x_{t-1}|u_{t})\right]\bigr)\,,$
|
| (7a)

|
| $\displaystyle\tilde{p}(x_{t})\propto\exp\bigl(\mathbb{E}_{q(\theta|x_{t})}\left[-\mathrm{h}\!\left[q(y_{t}|x_{t},\theta)\right]\right]\bigr)\,,$
|
| (7b)

|
| $\displaystyle\tilde{p}(y_{t},x_{t})\propto\exp\bigl(\mathbb{D}_{\mathrm{KL}}\left[q(\theta|y_{t},x_{t})\|q(\theta|x_{t})\right]\bigr)\,.$
|
| (7c)

22 showed that the VFE of the augmented model $F_{\tilde{p}}[q]$ is an upper bound on the expected EFE.
A notable feature is that the epistemic priors depend on the variational distribution $q$ itself, creating a circular dependency that complicates optimization.
A central contribution of this paper is to make that circularity explicit as entropy corrections in the objective, rather than leaving it implicit in posterior-dependent priors.

## 3 Related Work

##### Planning-as-Inference.

The PAI framework casts optimal control as inference in graphical models [2, 36], connecting control to variational methods and message passing [17].
Closely related formulations include linearly-solvable MDPs [34], path-integral control [15], KL control [14], and stochastic optimal control [29].
A known challenge is optimistic inference: conditioning on goals biases posteriors toward trajectories assuming favorable outcomes [17].
This issue was addressed by 19 with an entropy correction that turns the expected-utility variational objective into a proper control objective by penalizing plans that rely on fortuitous state realizations.

##### Active inference.

Active inference minimizes the Expected Free Energy, combining instrumental and epistemic value [12, 8, 26].
Existing methods employ specialized procedures: tree search [11], branching [7], or dynamic programming [27].
The status of the EFE as a variational objective has itself been scrutinized [20], motivating several works that seek to unify EFE with variational inference.
In a related direction, 24 combined estimation and control via belief propagation.
Building on the Generalized Free Energy [25], 16 and 38 modified the VFE to include epistemic terms.
Most recently, 22 showed that EFE minimization can be formulated as VFE minimization with epistemic priors, refining the preliminary construction of 9, and 21 implemented this via message passing with alternating updates between the posterior and epistemic priors.
A separate, complementary line of work [23, 33] casts exploration as posterior inference over value functions, targeting uncertainty in the value function rather than in the model parameters $\theta$ .
Our contribution is to connect these lines: the epistemic-prior construction provides the EFE correction to a marginal objective, the Lázaro-Gredilla construction provides the planning correction, and their combination yields a principled message-passing formulation of EFE-based planning.

## 4 Entropy Corrections for EFE-Based Planning

We now show that the epistemic priors from Section 2.4 and the planning correction of 19 play different roles.
The epistemic priors identify the corrections that transform marginal VFE minimization into EFE minimization.
The planning correction turns an expected-utility variational objective into a planning objective over policies.
Proper active-inference planning requires both.
More broadly, specifying a planning method is a three-way modeling choice: the generative model, the variable-role assignment among controlled, state, parameter, and observed quantities, and the entropy correction selecting the objective.
The AIF-specific commitment lives entirely in the last.
With no entropy corrections, minimizing the VFE $F_{\hat{p}}[q]$ of the preference-augmented model is simply marginal inference, or in the control setting, KL control [14]22
2

Kappen-style tempering $\hat{p}(x)\propto\exp(R(x)/\lambda)$ [15, 14] parameterizes the generative model (the preference prior), whereas Table 1 parameterizes the objective via entropy corrections; the two axes are orthogonal.; different objectives arise by adding entropy corrections to this same baseline.
The key question is which corrections are needed for proper EFE-based planning.

### 4.1 Cross-Entropy Planning

Marginal variational inference minimizes a cost over the full $q$ , which lets the joint commit to favorable state realizations that the policy alone cannot produce.
19 showed that turning this into planning, where the extracted policy $q(u_{t}|x_{t-1})$ actually attains the cost it appears to minimize, requires an entropy correction that penalizes action uncertainty:

|
| $\sum_{t=1}^{T}\mathbb{H}\left[q(x_{t-1},u_{t})\right]-\mathbb{H}\left[q(x_{t-1})\right]=\sum_{t=1}^{T}\mathbb{H}\left[q(u_{t}|x_{t-1})\right]\,.$
|
| (8)

See Appendix A.1 for the derivation.

Following the control-as-inference framework [17], rewards can be encoded as preference distributions via $\hat{p}(x)\propto\exp(R(x))$ .
As shown in Appendix A.3, adding the entropy correction (8) to the VFE transforms the objective into minimizing the cross-entropy between the state marginals and the preference distribution:

|
| $\min_{q}\sum_{t=1}^{T}\mathbb{H}\left[q(x_{t}),\hat{p}(x_{t})\right]+\text{const}\,,$
|
| (9)

where $\mathbb{H}\left[q,\hat{p}\right]=-\mathbb{E}_{q}\left[\log\hat{p}\right]$ is the cross-entropy.
Since $\mathbb{H}\left[q,\hat{p}\right]=-\mathbb{E}_{q}\left[R(x)\right]+\text{const}$ , minimizing cross-entropy is equivalent to maximizing expected reward.

We call this cross-entropy planning: the agent maximizes expected reward (equivalently, minimizes cross-entropy to preferences) while committing to a policy.

### 4.2 EFE as Entropy Corrections

The epistemic priors introduced in Section 2 augment the generative model with terms that encode variable roles.
The VFE of this augmented model can be expressed as the original VFE plus entropy corrections.
This rewriting is an exact algebraic identity.

###### Theorem 1 (Entropy-corrected form of active inference).

The variational objective of 22 can be written as:

|
| $F_{\tilde{p}}[q]=F_{\hat{p}}[q]+\sum_{t=1}^{T}2\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]\\
-\mathbb{H}\left[q(x_{t}|x_{t-1},u_{t})\right]-\mathbb{H}\left[q(y_{t}|x_{t})\right]\,.$
|
| (10)

###### Proof.

See Appendix A.2.
∎

Each prior contributes a specific correction: $\tilde{p}(u_{t})$ produces $-\mathbb{H}\left[q(x_{t}|x_{t-1},u_{t})\right]$ , $\tilde{p}(x_{t})$ produces $+\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]$ , and $\tilde{p}(y_{t},x_{t})$ contributes a further $+\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]-\mathbb{H}\left[q(y_{t}|x_{t})\right]$ via the identity $\mathbb{E}_{q}\left[\mathbb{D}_{\mathrm{KL}}\left[q(\theta|y_{t},x_{t})\|q(\theta|x_{t})\right]\right]=\mathbb{H}\left[q(y_{t}|x_{t})\right]-\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]$ , producing the factor of two.
Together these corrections produce EFE minimization inside a marginal variational objective: the $+2\,\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]$ term pushes beliefs toward state-parameter configurations whose observations are informative, which is what epistemic means in AIF.
The signs pull in opposite directions: the negative terms favor spreading belief over reachable states and predicted observations, while the positive term favors concentrating it on informative configurations.
This tension returns as a min-max structure in the message-passing scheme (Section 5.3).
Grouped differently, the observation-side corrections match standard EFE terminology [8]: one factor of $\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]$ penalizes ambiguity, and the remaining $\mathbb{H}\left[q(y_{t}|x_{t})\right]-\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]$ enters negatively and rewards novelty, the expected information gain about $\theta$ .
Ambiguity depends only on the observation kernel at a given state; novelty depends on the joint posterior over observations, states, and parameters.
This distinction drives the empirical separation in Section 6.
By itself, however, (10) does not yet yield EFE-based planning, because it lacks the planning correction (8).

### 4.3 EFE-Based Planning

The missing step is to combine the marginal-EFE corrections of Theorem 1 with the planning correction of Section 4.1.
Adding only the dynamics-side term $-\mathbb{H}\left[q(x_{t}|x_{t-1},u_{t})\right]$ to cross-entropy planning yields risk-minimizing planning, which minimizes what 12 call risk; it is a useful intermediate ablation, but not yet full EFE-based planning because it omits the observation-side epistemic corrections.

Appendix B proves that the resulting EFE-based planning objective is

|
| $\displaystyle\min_{q}\;$
| $\displaystyle F_{\hat{p}}[q]+\sum_{t=1}^{T}\mathbb{H}\left[q(u_{t}|x_{t-1})\right]+\sum_{t=1}^{T}\Bigl(2\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]$
|

|
|
| $\displaystyle\qquad\quad-\mathbb{H}\left[q(x_{t}|x_{t-1},u_{t})\right]-\mathbb{H}\left[q(y_{t}|x_{t})\right]\Bigr)\,.$
|
| (11)

The first sum is the planning correction; the second sum is the EFE correction.
Only their combination yields proper EFE-based planning.

### 4.4 Comparison of Objectives

Table 1: Entropy corrections needed to move from baseline variational inference to proper EFE-based planning.

| Objective
| Added entropy correction

| Baseline VFE / Marginal inference
| $0$

| Cross-entropy planning [19]
| $+\sum_{t}\mathbb{H}\left[q(u_{t}|x_{t-1})\right]$

| Risk-minimizing planning
| CE $-\sum_{t}\mathbb{H}\left[q(x_{t}|x_{t-1},u_{t})\right]$

| EFE-based planning
| CE $+\sum_{t}2\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]-\mathbb{H}\left[q(x_{t}|x_{t-1},u_{t})\right]-\mathbb{H}\left[q(y_{t}|x_{t})\right]$

Table 1 summarizes the progression: the planning correction changes how control is posed (cross-entropy planning), the EFE correction changes what objective is optimized (marginal EFE), and only their combination yields proper EFE-based planning, the objective implemented in our experiments.
The channel reparameterizations required for message passing follow directly from these correction terms (Section 5.1); we turn to that next.

## 5 Message Passing for EFE-Based Planning

The full EFE-based planning objective (11) adds four conditional entropy terms to the VFE: one for the policy, one for the dynamics, and two for the observation model.
In the Bethe framework a conditional distribution is a ratio of region beliefs, so these terms are not functions of any single coordinate of the optimization problem.
We resolve this by introducing auxiliary conditional distributions (channels) that promote the corrected conditionals to free variational parameters, yielding a message-passing family that generalizes standard belief propagation.

### 5.1 Channel Reparameterization

Figure 1: Forney factor graph for the generative model (1). Square nodes are factors; edges are variables. The time slice between the dashed lines is repeated for $T$ timesteps.

The FFG representation (Section 2.3) makes the locality of channel reparameterization explicit: each correction acts on a single factor node, while the remainder of the graph is unchanged from standard sum-product (Figure 1).
The key identity is the variational characterization of conditional entropy (Gibbs’ inequality):

|
| $\mathbb{H}\left[q(y|x)\right]=\min_{r}\mathbb{E}_{q(y,x)}\left[-\log r(y|x)\right]\,,$
|
| (12)

with equality when $r(y|x)=q(y|x)$ , so the substitution is exact rather than a bound.
We introduce four normalized conditional distributions as channels: $r_{u|x,t}(u_{t}|x_{t-1})$ , $r_{x|xu,t}(x_{t}|x_{t-1},u_{t})$ , $r_{y|x\theta,t}(y_{t}|x_{t},\theta)$ , and $r_{y|x,t}(y_{t}|x_{t})$ , as free variational parameters for each time step $t$ (see Appendix D for formal definitions).
Substituting (12) into the corrections of (11) yields a well-posed optimization in which each channel enters the factor it corrects according to the sign of its entropy term: the positive corrections place $r_{u|x,t}$ and $r_{y|x\theta,t}$ (squared) in numerators, while the negative corrections place $r_{x|xu,t}$ and $r_{y|x,t}$ in denominators.
This yields the kernels:

|
| $\tilde{f}_{\mathrm{obs}_{t}}(y_{t},x_{t},\theta)=\frac{p(y_{t}|x_{t},\theta)\,r_{y|x\theta,t}^{2}(y_{t}|x_{t},\theta)}{r_{y|x,t}(y_{t}|x_{t})}\,,$
|
| (13a)

|
| $\tilde{f}_{\mathrm{dyn}_{t}}(x_{t},x_{t-1},\theta,u_{t})=\frac{p(x_{t}|x_{t-1},\theta,u_{t})\,r_{u|x,t}(u_{t}|x_{t-1})}{r_{x|xu,t}(x_{t}|x_{t-1},u_{t})}.$
|
| (13b)

With these substitutions, the EFE-based planning objective becomes a standard Bethe free energy over the modified factor graph, jointly optimized over beliefs and channels.
The kernels (13) replace the original factor functions in the message-passing equations, making the procedure iterative: the channel beliefs $r$ depend on variational beliefs $q$ and vice versa. The proof for $T=1$ is given in Appendix D. The full scheme comes from the additivity of the Lagrangian and the entropic corrections, see Appendix D.6 for details.

### 5.2 Message-Passing Equations

Figure 2: Factor graph for a single time slice of the generative model (1). The observation factor $f_{\mathrm{obs}_{t}}$ and dynamics factor $f_{\mathrm{dyn}_{t}}$ receive kernels $\tilde{f}_{\mathrm{obs}_{t}}$ and $\tilde{f}_{\mathrm{dyn}_{t}}$ from (13) under the EFE-based planning objective. Numbered messages are computed in a forward pass over all time slices, lettered messages in a subsequent backward pass.

Since the modified objective has a Bethe form, the stationarity conditions yield sum-product-style message updates. The only difference from standard belief propagation is that each factor uses its kernel (13) in place of the original.

Each factor $a$ sends to a neighboring factor $b$ the integral of its kernel over incoming messages on adjacent edges:

|
| $\mu_{jb}(s_{j})\propto\!\int\!\tilde{f}_{a}(\bm{s}_{a})\!\!\prod_{i\in\mathcal{E}(a)\setminus j}\!\!\mu_{ia}(s_{i})\,\mathrm{d}\bm{s}_{a\setminus j}\,.$
|
| (14)

For unmodified factors (priors, data likelihoods), $\tilde{f}_{a}=f_{a}$ .

##### Singleton beliefs.

Singleton beliefs are computed by normalizing the product of colliding messages on an edge,

|
| $q^{*}(s_{i})\propto\mu_{ia}(s_{i})\mu_{ib}(s_{i})\,,$
|
| (15)

with $\{a,b\}=\mathcal{V}(i)$ the nodes adjacent to edge $i$ . The full forward-backward schedule is shown in Figure 2.

##### Region beliefs.

Region beliefs are computed by multiplying the factor function with all inbound messages and normalizing,

|
| $q^{*}(\bm{s}_{a})\propto\tilde{f}_{a}(\bm{s}_{a})\prod_{i\in\mathcal{E}(a)}\mu_{ia}(s_{i})\,.$
|
| (16)

##### Channel updates.

At the fixed point, each channel recovers the true conditional under its factor belief:

|

|
| $\displaystyle r_{u|x,t}^{*}(u_{t}|x_{t-1})$
| $\displaystyle=q_{u|x,t}^{*}(u_{t}|x_{t-1})\,,$
|
| (17a)

|
| $\displaystyle r_{y|x\theta,t}^{*}(y_{t}|x_{t},\theta)$
| $\displaystyle=q_{y|x\theta,t}^{*}(y_{t}|x_{t},\theta)\,,$
|
| (17b)

|
| $\displaystyle r_{y|x,t}^{*}(y_{t}|x_{t})$
| $\displaystyle=q_{y|x,t}^{*}(y_{t}|x_{t})\,,$
|
| (17c)

|
| $\displaystyle r_{x|xu,t}^{*}(x_{t}|x_{t-1},u_{t})$
| $\displaystyle=q_{x|xu,t}^{*}(x_{t}|x_{t-1},u_{t})\,,$
|
| (17d)

where the beliefs $q$ are conditionals derived from the respective region beliefs around factors $f_{\mathrm{obs}_{t}}$ and $f_{\mathrm{dyn}_{t}}$ at time $t$ . The marginal observation channel $r_{y|x,t}^{*}$ is obtained by marginalizing $\theta$ from the observation factor belief (see Appendix D).

##### Learning vs. planning.

Learning and planning are kept separate. The parameters $\theta$ are updated by Bayesian filtering on real observations as they arrive, whereas during planning $\theta$ is held fixed at the current belief $q(\theta)$ : the backward messages into $\theta$ from the (simulated) observation and dynamics factors are not sent. This is what lets the global parameter information gain decompose into the per-step novelty factors $\tilde{p}(y_{t},x_{t})$ of (7c). Each step’s novelty is then scored against a common $\theta$ baseline, so it is additive across the horizon. The omitted messages are well-defined; holding $\theta$ fixed during planning keeps per-step novelty well-posed.

Algorithm 1 EFE-Based Planning Message Passing

1:

Generative model factors $\{f_{\mathrm{obs}_{t}},f_{\mathrm{dyn}_{t}}\}_{t=1}^{T}$ , priors $p(\theta),p(x_{0}),p(u_{t})$ , goal priors $\hat{p}_{x}(x_{t}),\hat{p}_{y}(y_{t})$

2:

Action beliefs $\{q_{u_{t}}^{*}(u_{t})\}_{t=1}^{T}$

3:

Initialize all messages $\mu\leftarrow 1$ , channels $r_{u|x},r_{y|x\theta},r_{y|x},r_{x|xu}\leftarrow$ uniform

4:

repeat

5:

  for $t=1,\ldots,T$ do

6:

   Compute sum-product messages (14)

7:

   Update region beliefs (16)

8:

   Update channels (17), (18)

9:

   Update kernels (13)

10:

  end for

11:

  Update singleton beliefs (15)

12:

until convergence

13:

return $\{q_{u_{t}}^{*}(u_{t})\}_{t=1}^{T}$

The same construction yields a family of algorithms: Value Belief Propagation (VBP) [19] uses only the policy reparameterization, risk-minimizing planning (Table 1) additionally uses the dynamics-side reparameterization, and full EFE-based planning further adds the observation-side reparameterizations. The corresponding VBP derivation is given in Appendix E.

### 5.3 Convergence

The kernels (13) contain opposing channel corrections (Section 4): $r_{u|x}$ and $r_{y|x\theta}$ appear in numerators, while $r_{x|xu}$ and $r_{y|x}$ appear in denominators, inducing a min-max structure in the joint optimization.
Because each channel reparameterization is a local rewrite of a single kernel, the per-update cost matches standard loopy belief propagation up to the channel updates.
Standard BP convergence guarantees, however, do not transfer to this min-max setting, and we apply arithmetic damping to channels for each update $n$ :

|
| $r_{c}^{n}\propto(1-\lambda)\,r_{c}^{n-1}+\lambda\,r_{c}^{*}\,,$
|
| (18)

for each channel $c\in\{u|x,x|xu,y|x\theta,y|x\}$ . Here $\lambda\in[0,1]$ is the damping parameter and $r_{c}^{*}$ denotes the newly computed channel from (17). We select $\lambda$ per method and environment from a convergence sweep; at the selected value the channel-based methods reach a stationary VFE plateau, typically within $150$ iterations (see Appendix F.5).

## 6 Experiments

We design experiments to test the behavioral effect of progressively adding the entropy corrections in Table 1.
Full experimental details are deferred to Appendix F33
3

Code available at https://github.com/biaslab/UAI-MP-AIF-JAX.
All environments use discrete state spaces with exact factor evaluations, isolating the effect of the entropy corrections and channel-augmented schemes from errors introduced by approximate message computation.

### 6.1 Setup

##### Environments.

We adapt three classic grid-world environments into epistemic planning benchmarks by treating the environment layout as an unknown parameter $\theta$ in the generative model (1).
All environments support cardinal movement but differ in how epistemic value arises, which determines which observation-side corrections a method must capture.
In Frozen Lake, information gathering changes the observation model itself, so its value is visible as reduced ambiguity.
In canonical RockSample and Wumpus World, sensing actions affect only a single observation, so their value is pure novelty: it lies entirely in what the resulting reading reveals about $\theta$ .

Frozen Lake [6, 37]:
The agent observes binary “hole/safe” sensors for every cell on the grid, with noise that increases with distance from the agent.
A SCAN action switches the agent into a persistent scan mode in which all observations become near-deterministic, at the cost of one time step and a lower prior preference.

RockSample $(4,3)$ [31]:
The canonical RockSample benchmark on a $4{\times}4$ grid with $3$ rocks at known positions and unknown quality (good or bad), defining $\theta$ ( $8$ configurations).
The agent has one CHECK action per rock, returning a noisy quality reading whose accuracy degrades with distance to that rock, and receives no rock information otherwise.
It can SAMPLE a rock for a reward or penalty depending on quality, or EXIT for a fixed reward.

Wumpus World [30]:
Pit, wumpus, and gold positions define $\theta$ ( $25$ configurations).
The classic dynamics are simplified to isolate the epistemic challenge: the agent has no orientation or inventory and navigates by cardinal movement.
The agent observes noisy breeze, stench, and glitter adjacency signals and has uncertain position.
A SCAN action sharpens the adjacency signals for a single step, after which the noise reverts; position channels are unaffected.
Even a precise reading only narrows $\theta$ : a breeze indicates a nearby pit but not which neighbor, so the agent must triangulate across multiple positions.

##### Methods.

We compare five methods. The first four correspond to message-passing implementations of the entropy-corrected objectives in Section 4.4, with channel configurations as specified in Algorithm 1:

- 1.

BP: standard belief propagation, no entropy correction.

- 2.

VBP: cross-entropy planning, implemented as the principled channelized scheme from Appendix E.

- 3.

RM-MP: risk-minimizing planning (Table 1), using the planning channel together with the dynamics channel; reduces to VBP under deterministic dynamics.

- 4.

AIF-MP: full EFE-based planning, using the planning, dynamics, and observation channels (Algorithm 1).

- 5.

Nuijten-MP [21]: an alternating heuristic that treats the epistemic priors as literal prior factors, recomputed from the current posterior between belief-propagation sweeps, and does not incorporate the novelty prior (7c).

All methods except BP include the planning correction, so the experiments ablate the EFE-side corrections on top of a fixed planning baseline rather than the planning correction itself.

### 6.2 Results and Discussion

Table 2 reports performance for all methods across three environments.
The results show where each correction matters and where accounting for novelty becomes necessary.

Table 2: Performance across three environments with 95% confidence intervals, averaged over 1000 episodes. Best per metric (non-overlapping CIs) in bold.

|
| Frozen Lake
| RockSample
| Wumpus World

| Method
| Success (%)
| Avg. reward
| Retrieval (%)
| Success (%)

| BP
| $51.9\;[48.8,55.0]$
| $1.00\;[1.00,1.00]$
| $0.0$
| $1.2\;[0.5,1.9]$

| VBP
| $54.5\;[51.4,57.6]$
| $1.00\;[1.00,1.00]$
| $0.0$
| $5.5\;[4.1,6.9]$

| RM-MP
| $50.0\;[46.9,53.1]$
| $1.00\;[1.00,1.00]$
| $0.0$
| $24.0\;[21.4,26.6]$

| Nuijten-MP
| $\bm{95.6}\;[94.3,96.9]$
| $1.00\;[1.00,1.00]$
| $0.0$
| $5.0\;[3.6,6.4]$

| AIF-MP
| $\bm{95.9}\;[94.7,97.1]$
| $\bm{4.01}\;[3.90,4.12]$
| $\bm{98.7}$
| $\bm{40.7}\;[37.7,43.7]$

##### Epistemic actions that change the observation model (Frozen Lake).

Both active inference methods dominate ( ${\sim}96\%$ success, overlapping confidence intervals), substantially outperforming all baselines.
Both learn to SCAN.
Because scan mode persistently changes the observation kernel, reaching scan-mode states already pays off through reduced ambiguity, so the alternating heuristic finds the epistemic action as readily as the joint scheme.
RM-MP performs comparably to BP and VBP (overlapping confidence intervals): the dynamics correction is neither beneficial nor harmful in this regime.

##### Novelty-driven sensing (RockSample and Wumpus World).

In canonical RockSample, no action changes the observation model: a CHECK buys a single noisy reading whose only value is the information it carries about rock quality.
AIF-MP is the only method that checks and samples, retrieving $98.7\%$ of good rocks for an average reward of $4.01$ .
Every baseline, including Nuijten-MP, walks straight to the exit (reward $1.00$ , zero retrieval): under the uniform quality prior, sampling an unchecked rock has negative expected reward, so without the novelty term CHECK has no value and EXIT is optimal.
Wumpus World repeats this pattern under local readings: even a precise one-step scan does not reveal the global layout, since multiple hazard configurations produce the same breeze and stench patterns, so a scan only narrows $\theta$ .
AIF-MP again clearly leads ( $40.7\%$ ), while Nuijten-MP performs at the level of VBP ( $5.0\%$ vs. $5.5\%$ , overlapping confidence intervals): without an exploitable change in the observation model, the alternating heuristic reduces to its planning-only core.
RM-MP is the strongest baseline ( $24.0\%$ ): the slip-perturbed dynamics activate its dynamics channel, but without the observation-side corrections it cannot value what a scan reveals about $\theta$ .
The remaining gap is an objective mismatch, not a scheduling artifact: 21 treat the epistemic priors as literal prior factors, recomputed outside the variational objective between belief-propagation sweeps, and do not incorporate the novelty prior (7c), whereas AIF-MP treats all four channels as variational parameters of a single joint objective with closed-form stationary conditions (17), through which the expected information gain about $\theta$ propagates into the plan.
Representative trajectories are shown in Appendix F.3.

##### Synthesis.

The alternating heuristic captures half of the observation-side story: it responds to ambiguity, the precision of the observation kernel at reachable states, but not to novelty, the information observations carry about $\theta$ .
Ambiguity stands in for novelty when an epistemic action persistently changes the observation model (Frozen Lake); when sensing actions affect only a single observation, the heuristic collapses to planning-only performance while AIF-MP does not degrade.
Across all environments, the planning correction yields modest gains and the dynamics correction helps only under stochastic dynamics (Wumpus World); most of the gap to AIF-MP is explained by the observation-level corrections.
Accounting for novelty requires the joint variational treatment; treating the epistemic priors as literal priors and leaving out the novelty prior does not suffice.

## 7 Conclusion

This paper clarifies the variational structure of active inference planning.
Theorem 1 shows that the epistemic-prior construction of 22 admits an explicit entropy-corrected reformulation: relative to baseline VFE minimization, it adds a specific set of entropy corrections that yields marginal EFE minimization, making explicit which terms contribute the epistemic part of the objective.
Proper EFE-based planning additionally requires the planning correction of 19, and the combined objective leads directly to a message-passing construction via channel reparameterization.
That construction recovers a family of algorithms, including VBP, risk-minimizing planning, and full EFE-based planning (Algorithm 1).

Empirically, the planning and dynamics corrections account for only modest gains, while the observation-side corrections separate along the ambiguity/novelty split: only the joint channelized scheme captures novelty, the expected information gain about model parameters, and sustains performance when sensing actions affect only a single observation.

##### Limitations and future work.

The opposing signs of the entropy corrections induce a min-max structure in the joint optimization over beliefs and channels, which in practice requires damped channel updates for stable convergence (Section 5.3).
Standard belief propagation convergence guarantees do not transfer to this setting, and developing convergence theory for the channel-augmented scheme is an open problem; the damping parameter $\lambda$ also currently requires manual per-environment adjustment.
We restrict to discrete state spaces where exact factor evaluations are available; understanding how the channel reparameterization interacts with further factorization constraints on the variational posterior (e.g., mean-field or structured approximations) is an important direction.

{contributions}

W.W.L. Nuijten and M. Lukashchuk contributed equally to this work.
W.W.L. Nuijten developed the entropy decomposition framework.
M. Lukashchuk derived the message-passing scheme.
Both authors contributed to writing and experiments.
T. van de Laar contributed to the conceptualization of the method and supervision.
B. de Vries has a supervisory and editorial role.

###### Acknowledgements.

This publication is part of the project ROBUST: Trustworthy AI-based Systems for Sustainable Growth with project number KICH3.LTP.20.006, which is (partly) financed by the Dutch Research Council (NWO), GN Hearing, and the Dutch Ministry of Economic Affairs and Climate Policy (EZK) under the program LTP KIC 2020-2023.

## References

- [1]
$\mathbb{H}\left[q(x_{0})\right]+\sum_{t=1}^{T}\mathbb{H}_{q}[x_{t}|x_{t-1},u_{t}]\,,$ $\mathbb{H}_{q}[x_{t}|x_{t-1},u_{t}]=-\int q(x_{t},x_{t-1},u_{t})\log q(x_{t}|x_{t-1},u_{t})\mathrm{d}x_{t}\mathrm{d}x_{t-1}\mathrm{d}u_{t}$ $\mathbb{H}\left[q(\bm{x},\bm{u})\right]$ $u_{t}$ $x_{t}$ $u_{t}$ $x_{t+1}$ $\mathbb{H}\left[q(x_{0})\right]+\sum_{t=1}^{T}\mathbb{H}_{q}[x_{t}|x_{t-1},u_{t}]=\mathbb{H}\left[q(\bm{x},\bm{u})\right]+\sum_{t=1}^{T}\mathbb{H}\left[q(x_{t-1})\right]-\mathbb{H}\left[q(x_{t-1},u_{t})\right]\,.$ $\displaystyle\mathbb{H}\left[q(x_{0})\right]$ $\displaystyle+\sum_{t=1}^{T}\mathbb{H}_{q}[x_{t}|x_{t-1},u_{t}]$ $\displaystyle=\mathbb{H}\left[q(x_{0})\right]+\sum_{t=1}^{T}\left(-\iiint q(x_{t},x_{t-1},u_{t})\log q(x_{t}|x_{t-1},u_{t})\mathrm{d}x_{t}\mathrm{d}x_{t-1}\mathrm{d}u_{t}\right)\,,$ $\displaystyle=\mathbb{H}\left[q(x_{0})\right]+\sum_{t=1}^{T}\left(-\iiint q(x_{t},x_{t-1},u_{t})\log\frac{q(x_{t},x_{t-1},u_{t})}{q(u_{t}|x_{t-1})q(x_{t-1})}\mathrm{d}x_{t}\mathrm{d}x_{t-1}\mathrm{d}u_{t}\right)\,.$ $\displaystyle=\mathbb{H}\left[q(x_{0})\right]+\sum_{t=1}^{T}\left(-\iiint q(x_{t},x_{t-1},u_{t})\log\frac{q(x_{t},x_{t-1},u_{t})}{q(x_{t-1})}\mathrm{d}x_{t}\mathrm{d}x_{t-1}\mathrm{d}u_{t}\right.$ $\displaystyle\qquad\left.+\iiint q(x_{t},x_{t-1},u_{t})\log q(u_{t}|x_{t-1})\mathrm{d}x_{t}\mathrm{d}x_{t-1}\mathrm{d}u_{t}\right)\,,$ $\displaystyle=\mathbb{H}\left[q(x_{0})\right]+\sum_{t=1}^{T}\underbrace{\left(-\iiint q(x_{t},x_{t-1},u_{t})\log q(x_{t},u_{t}|x_{t-1})\mathrm{d}x_{t}\mathrm{d}x_{t-1}\mathrm{d}u_{t}\right)}_{\mathbb{H}_{q}[x_{t},u_{t}|x_{t-1}]}$ $\displaystyle\qquad+\sum_{t=1}^{T}\iint q(x_{t-1},u_{t})\log\frac{q(x_{t-1},u_{t})}{q(x_{t-1})}\mathrm{d}x_{t-1}\mathrm{d}u_{t}\,.$ $\mathbb{H}\left[q(x_{0})\right]+\sum_{t=1}^{T}\mathbb{H}_{q}[x_{t},u_{t}|x_{t-1}]=\mathbb{H}\left[q(\bm{x},\bm{u})\right]\,.$ $\displaystyle\sum_{t=1}^{T}\iint q(x_{t-1},u_{t})\log\frac{q(x_{t-1},u_{t})}{q(x_{t-1})}\mathrm{d}x_{t-1}\mathrm{d}u_{t}$ $\displaystyle=\sum_{t=1}^{T}\underbrace{\iint q(x_{t-1},u_{t})\log q(x_{t-1},u_{t})\mathrm{d}x_{t-1}\mathrm{d}u_{t}}_{-\mathbb{H}\left[q(x_{t-1},u_{t})\right]}$ $\displaystyle\qquad-\underbrace{\int q(x_{t-1})\log q(x_{t-1})\mathrm{d}x_{t-1}}_{-\mathbb{H}\left[q(x_{t-1})\right]}\,,$ $\displaystyle=\sum_{t=1}^{T}\mathbb{H}\left[q(x_{t-1})\right]-\mathbb{H}\left[q(x_{t-1},u_{t})\right]\,.$ $\sum_{t}\mathbb{H}\left[q(x_{t-1},u_{t})\right]-\mathbb{H}\left[q(x_{t-1})\right]=\sum_{t}\mathbb{H}\left[q(u_{t}|x_{t-1})\right]$ $\mathbb{H}\left[q(u_{t}|x_{t-1})\right]$ $q(\bm{y},\bm{x},\bm{u},\theta)$ $\tilde{p}(x_{t})=\exp\bigl(\mathbb{E}_{q(\theta|x_{t})}\left[-\mathrm{h}\!\left[q(y_{t}|x_{t},\theta)\right]\right]\bigr)\,.$ $-\int q(x_{t})\log\tilde{p}(x_{t})\mathrm{d}x_{t}=\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]\,.$ $\tilde{p}(x_{t})$ $\displaystyle-\int q(x_{t})\log\tilde{p}(x_{t})\mathrm{d}x_{t}$ $\displaystyle=-\int q(x_{t})\int q(\theta|x_{t})\int q(y_{t}|x_{t},\theta)\log q(y_{t}|x_{t},\theta)\mathrm{d}y_{t}\mathrm{d}\theta\mathrm{d}x_{t}$ $\displaystyle=-\iiint q(y_{t}|x_{t},\theta)\,q(\theta|x_{t})\,q(x_{t})\log q(y_{t}|x_{t},\theta)\mathrm{d}y_{t}\mathrm{d}\theta\mathrm{d}x_{t}$ $\displaystyle=-\iiint q(y_{t},x_{t},\theta)\log q(y_{t}|x_{t},\theta)\mathrm{d}y_{t}\mathrm{d}x_{t}\mathrm{d}\theta$ $\displaystyle=\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]\,.$ $q(\bm{y},\bm{x},\bm{u},\theta)$ $\tilde{p}(u_{t})=\exp\bigl(\mathrm{h}\!\left[q(x_{t},x_{t-1}|u_{t})\right]-\mathrm{h}\!\left[q(x_{t-1}|u_{t})\right]\bigr)\,.$ $-\int q(u_{t})\log\tilde{p}(u_{t})\mathrm{d}u_{t}=-\mathbb{H}\left[q(x_{t}|x_{t-1},u_{t})\right]\,.$ $\tilde{p}(u_{t})$ $\displaystyle-\int q(u_{t})$ $\displaystyle\log\tilde{p}(u_{t})\mathrm{d}u_{t}$ $\displaystyle=\int q(u_{t})\left(\iint q(x_{t},x_{t-1}|u_{t})\log q(x_{t},x_{t-1}|u_{t})\mathrm{d}x_{t}\mathrm{d}x_{t-1}\right.$ $\displaystyle\qquad\left.-\int q(x_{t-1}|u_{t})\log q(x_{t-1}|u_{t})\mathrm{d}x_{t-1}\right)\mathrm{d}u_{t}$ $\displaystyle=\int q(u_{t})\left(\iint\frac{q(x_{t},x_{t-1},u_{t})}{q(u_{t})}\log\frac{q(x_{t},x_{t-1},u_{t})}{q(u_{t})}\mathrm{d}x_{t}\mathrm{d}x_{t-1}\right.$ $\displaystyle\qquad\left.-\int\frac{q(x_{t-1},u_{t})}{q(u_{t})}\log\frac{q(x_{t-1},u_{t})}{q(u_{t})}\mathrm{d}x_{t-1}\right)\mathrm{d}u_{t}$ $\displaystyle=\iiint q(x_{t},x_{t-1},u_{t})\log\frac{q(x_{t},x_{t-1},u_{t})}{q(u_{t})}\mathrm{d}x_{t}\mathrm{d}x_{t-1}\mathrm{d}u_{t}$ $\displaystyle\qquad-\iint q(x_{t-1},u_{t})\log\frac{q(x_{t-1},u_{t})}{q(u_{t})}\mathrm{d}x_{t-1}\mathrm{d}u_{t}$ $\displaystyle=-\mathbb{H}\left[q(x_{t},x_{t-1},u_{t})\right]+\mathbb{H}\left[q(u_{t})\right]+\mathbb{H}\left[q(x_{t-1},u_{t})\right]-\mathbb{H}\left[q(u_{t})\right]$ $\displaystyle=\mathbb{H}\left[q(x_{t-1},u_{t})\right]-\mathbb{H}\left[q(x_{t},x_{t-1},u_{t})\right]=-\mathbb{H}\left[q(x_{t}|x_{t-1},u_{t})\right]\,.$ $q(\bm{y},\bm{x},\bm{u},\theta)$ $\tilde{p}(y_{t},x_{t})=\exp\bigl(\mathbb{D}_{\mathrm{KL}}\left[q(\theta|y_{t},x_{t})\|q(\theta|x_{t})\right]\bigr)\,.$ $-\iint q(y_{t},x_{t})\log\tilde{p}(y_{t},x_{t})\mathrm{d}y_{t}\mathrm{d}x_{t}=\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]-\mathbb{H}\left[q(y_{t}|x_{t})\right]\,.$ $\tilde{p}(y_{t},x_{t})$ $\displaystyle-\iint q(y_{t},x_{t})$ $\displaystyle\log\tilde{p}(y_{t},x_{t})\mathrm{d}y_{t}\mathrm{d}x_{t}$ $\displaystyle=-\iint q(y_{t},x_{t})\left(\int q(\theta|y_{t},x_{t})\log\frac{q(\theta|y_{t},x_{t})}{q(\theta|x_{t})}\mathrm{d}\theta\right)\mathrm{d}y_{t}\mathrm{d}x_{t}$ $\displaystyle=-\iint q(y_{t},x_{t})\left(\int q(\theta|y_{t},x_{t})\log\frac{q(y_{t},x_{t},\theta)}{q(y_{t},x_{t})}-\log\frac{q(x_{t},\theta)}{q(x_{t})}\mathrm{d}\theta\right)\mathrm{d}y_{t}\mathrm{d}x_{t}$ $\displaystyle=-\iiint q(y_{t},x_{t},\theta)\left(\log q(y_{t},x_{t},\theta)-\log q(y_{t},x_{t})-\log q(x_{t},\theta)+\log q(x_{t})\right)\mathrm{d}y_{t}\mathrm{d}x_{t}\mathrm{d}\theta$ $\displaystyle=\underbrace{-\iiint q(y_{t},x_{t},\theta)\log q(y_{t},x_{t},\theta)\mathrm{d}y_{t}\mathrm{d}x_{t}\mathrm{d}\theta}_{\mathbb{H}\left[q(y_{t},x_{t},\theta)\right]}$ $\displaystyle\qquad+\underbrace{\iiint q(y_{t},x_{t},\theta)\log q(y_{t},x_{t})\mathrm{d}y_{t}\mathrm{d}x_{t}\mathrm{d}\theta}_{-\mathbb{H}\left[q(y_{t},x_{t})\right]}$ $\displaystyle\qquad+\underbrace{\iiint q(y_{t},x_{t},\theta)\log q(x_{t},\theta)\mathrm{d}y_{t}\mathrm{d}x_{t}\mathrm{d}\theta}_{-\mathbb{H}\left[q(x_{t},\theta)\right]}$ $\displaystyle\qquad-\underbrace{\iiint q(y_{t},x_{t},\theta)\log q(x_{t})\mathrm{d}y_{t}\mathrm{d}x_{t}\mathrm{d}\theta}_{\mathbb{H}\left[q(x_{t})\right]}$ $\displaystyle=\mathbb{H}\left[q(y_{t},x_{t},\theta)\right]-\mathbb{H}\left[q(y_{t},x_{t})\right]-\mathbb{H}\left[q(x_{t},\theta)\right]+\mathbb{H}\left[q(x_{t})\right]$ $\displaystyle=\bigl(\mathbb{H}\left[q(y_{t},x_{t},\theta)\right]-\mathbb{H}\left[q(x_{t},\theta)\right]\bigr)-\bigl(\mathbb{H}\left[q(y_{t},x_{t})\right]-\mathbb{H}\left[q(x_{t})\right]\bigr)$ $\displaystyle=\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]-\mathbb{H}\left[q(y_{t}|x_{t})\right]\,.$ $\displaystyle F_{\tilde{p}}[q]$ $\displaystyle=\int q(\bm{y},\bm{x},\bm{u},\theta)\log\frac{q(\bm{y},\bm{x},\bm{u},\theta)}{\tilde{p}(\bm{y},\bm{x},\bm{u},\theta)}$ $\displaystyle=\int q(\bm{y},\bm{x},\bm{u},\theta)\log\frac{q(\bm{y},\bm{x},\bm{u},\theta)}{p(\bm{y},\bm{x},\bm{u},\theta)\prod_{t=1}^{T}\tilde{p}(x_{t})\tilde{p}(u_{t})\tilde{p}(y_{t},x_{t})}$ $\displaystyle=\underbrace{\int q(\bm{y},\bm{x},\bm{u},\theta)\log\frac{q(\bm{y},\bm{x},\bm{u},\theta)}{p(\bm{y},\bm{x},\bm{u},\theta)}}_{F_{\hat{p}}[q]}+$ $\displaystyle\qquad-\sum_{t=1}^{T}\Bigg(\iiiint q(\bm{y},\bm{x},\bm{u},\theta)\log\tilde{p}(x_{t})\mathrm{d}\bm{y}\mathrm{d}\bm{x}\mathrm{d}\bm{u}\mathrm{d}\theta+\iiiint q(\bm{y},\bm{x},\bm{u},\theta)\log\tilde{p}(u_{t})\mathrm{d}\bm{y}\mathrm{d}\bm{x}\mathrm{d}\bm{u}\mathrm{d}\theta+$ $\displaystyle\qquad+\iiiint q(\bm{y},\bm{x},\bm{u},\theta)\log\tilde{p}(y_{t},x_{t})\mathrm{d}\bm{y}\mathrm{d}\bm{x}\mathrm{d}\bm{u}\mathrm{d}\theta\Bigg)$ $\displaystyle=F_{\hat{p}}[q]+\sum_{t=1}^{T}\left(-\int q(x_{t})\log\tilde{p}(x_{t})\mathrm{d}x_{t}-\int q(u_{t})\log\tilde{p}(u_{t})\mathrm{d}u_{t}-\iint q(y_{t},x_{t})\log\tilde{p}(y_{t},x_{t})\mathrm{d}y_{t}\mathrm{d}x_{t}\right)\,.$ $\displaystyle F_{\tilde{p}}[q]$ $\displaystyle=F_{\hat{p}}[q]+\sum_{t=1}^{T}\Big(\underbrace{\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]}_{\text{\hyperref@@ii[lem:p_tilde_x]{Lemma\penalty\ \ref *{lem:p_tilde_x}}}}\underbrace{{}-\mathbb{H}\left[q(x_{t}|x_{t-1},u_{t})\right]}_{\text{\hyperref@@ii[lem:p_tilde_u]{Lemma\penalty\ \ref *{lem:p_tilde_u}}}}+\underbrace{\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]-\mathbb{H}\left[q(y_{t}|x_{t})\right]}_{\text{\hyperref@@ii[lem:p_tilde_x_y]{Lemma\penalty\ \ref *{lem:p_tilde_x_y}}}}\Big)$ $\displaystyle=F_{\hat{p}}[q]+\sum_{t=1}^{T}2\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]-\mathbb{H}\left[q(x_{t}|x_{t-1},u_{t})\right]-\mathbb{H}\left[q(y_{t}|x_{t})\right]\,.$ $\lambda>0$ $\lambda$ $\hat{p}_{\lambda}(x_{t})\propto\exp(\lambda R_{t}(x_{t}))$ $q(\bm{x},\bm{u})$ $\mathbb{E}_{q(\bm{x},\bm{u})}\left[\sum_{t=1}^{T}R_{t}(x_{t})\right]=-\frac{1}{\lambda}\sum_{t=1}^{T}\mathbb{H}\left[q(x_{t}),\hat{p}_{\lambda}(x_{t})\right]+\text{const}\,.$ $\log\hat{p}_{\lambda}(x_{t})=\lambda R_{t}(x_{t})-\log Z_{t,\lambda}$ $Z_{t,\lambda}=\int\exp(\lambda R_{t}(x_{t}))\mathrm{d}x_{t}$ $\displaystyle\mathbb{H}\left[q(x_{t}),\hat{p}_{\lambda}(x_{t})\right]$ $\displaystyle=-\mathbb{E}_{q(x_{t})}\left[\log\hat{p}_{\lambda}(x_{t})\right]$ $\displaystyle=-\mathbb{E}_{q(x_{t})}\left[\lambda R_{t}(x_{t})-\log Z_{t,\lambda}\right]$ $\displaystyle=-\lambda\mathbb{E}_{q(x_{t})}\left[R_{t}(x_{t})\right]+\log Z_{t,\lambda}\,.$ $\mathbb{E}_{q(x_{t})}\left[R_{t}(x_{t})\right]=-\frac{1}{\lambda}\mathbb{H}\left[q(x_{t}),\hat{p}_{\lambda}(x_{t})\right]+\frac{1}{\lambda}\log Z_{t,\lambda}$ $t$ $\frac{1}{\lambda}\sum_{t}\log Z_{t,\lambda}$ $q$ $F_{\lambda}^{\text{planning}}=\frac{1}{\lambda}\log\mathbb{E}_{p(\bm{x},\bm{u})}\left[\exp\left(\lambda\sum_{t=1}^{T}R_{t}\right)\right]$ $\mathbb{E}_{q}\left[\sum_{t}R_{t}\right]$ $\hat{p}_{\lambda}(x_{t})\propto\exp(\lambda R_{t}(x_{t}))$ $-\frac{1}{\lambda}\sum_{t}\mathbb{H}\left[q(x_{t}),\hat{p}_{\lambda}(x_{t})\right]$ $\frac{1}{\lambda}$ $F_{\lambda}^{\text{planning}}$ $\sum_{t}\mathbb{H}\left[q(x_{t}),\hat{p}_{\lambda}(x_{t})\right]$ $\hat{p}_{\lambda}(x_{t})\propto\exp(\lambda R_{t}(x_{t}))$ $\lambda$ $\tilde{p}(\bm{y},\bm{x},\bm{u},\theta)$ $\bm{\pi}=\{\pi_{t}(u_{t}|x_{t-1})\}_{t=1}^{T}$ $\max_{\bm{\pi}}\log\sum_{\bm{y},\bm{x},\bm{u},\theta}\tilde{p}(\bm{y},\bm{x},\bm{u},\theta)\prod_{t=1}^{T}\pi_{t}(u_{t}|x_{t-1})=\max_{q}\;\bigl\langle\log\tilde{p}\bigr\rangle_{q}+\mathbb{H}\left[q(\bm{y},\bm{x},\bm{u},\theta)\right]-\sum_{t=1}^{T}\mathbb{H}\left[q(u_{t}|x_{t-1})\right]\,,$ $q(\bm{y},\bm{x},\bm{u},\theta)$ $\pi_{t}^{*}(u_{t}|x_{t-1})=q^{*}(u_{t}|x_{t-1})$ $q$ $\max_{\bm{\pi}}\log\sum_{\bm{y},\bm{x},\bm{u},\theta}\tilde{p}(\bm{y},\bm{x},\bm{u},\theta)\prod_{t=1}^{T}\pi_{t}(u_{t}|x_{t-1})=-\min_{q}\;F_{\tilde{p}}[q]+\sum_{t=1}^{T}\mathbb{H}\left[q(u_{t}|x_{t-1})\right]\,,$ $F_{\tilde{p}}[q]=\mathbb{D}_{\mathrm{KL}}\left[q\|\tilde{p}\right]$ $\bm{\pi}$ $\displaystyle\sum_{\bm{y},\bm{x},\bm{u},\theta}\tilde{p}(\bm{y},\bm{x},\bm{u},\theta)\prod_{t=1}^{T}\pi_{t}(u_{t}|x_{t-1})$ $\displaystyle\qquad\propto\sum_{\bm{y},\bm{x},\bm{u},\theta}\rho_{\bm{\pi}}(\bm{y},\bm{x},\bm{u},\theta)\prod_{t=1}^{T}\hat{p}(x_{t})\hat{p}(y_{t})\,,$ $\rho_{\bm{\pi}}(\bm{y},\bm{x},\bm{u},\theta):=p(\theta)\,p(x_{0})\!\prod_{t=1}^{T}p(y_{t}|x_{t},\theta)\,p(x_{t}|x_{t-1},u_{t},\theta)\,p(u_{t})\,\tilde{p}(u_{t})\,\tilde{p}(x_{t})\,\tilde{p}(y_{t},x_{t})\,\pi_{t}(u_{t}|x_{t-1})\,.$ $\log\hat{p}(x_{t})$ $\log\hat{p}(y_{t})$ $\pi_{t}(u_{t}|x_{t-1})$ $\sum_{t}\mathbb{H}\left[q(u_{t}|x_{t-1})\right]$ $\pi_{t}^{*}(u_{t}|x_{t-1})=q^{*}(u_{t}|x_{t-1})$ $F_{\tilde{p}}[q]$ $\min_{q}\;F_{\hat{p}}[q]+\underbrace{\sum_{t=1}^{T}2\mathbb{H}\left[q(y_{t}|x_{t},\theta)\right]-\mathbb{H}\left[q(x_{t}|x_{t-1},u_{t})\right]-\mathbb{H}\left[q(y_{t}|x_{t})\right]}_{\Delta^{\mathrm{AIF}}}+\underbrace{\sum_{t=1}^{T}\mathbb{H}\left[q(u_{t}|x_{t-1})\right]}_{\Delta^{\mathrm{planning}}}\,.$ $p(\bm{x})=f_{1}(x_{1})\,f_{2}(x_{1},x_{2},x_{3})\,f_{3}(x_{2},x_{4})\,f_{4}(x_{3})\,f_{5}(x_{4})$ $p(\bm{s})=\prod_{a\in\mathcal{V}}f_{a}(\bm{s}_{a})\,,$ $f_{a}$ $\bm{s}_{a}\subseteq\bm{s}$ $\mathcal{G}=(\mathcal{V},\mathcal{E})$ $\mathcal{V}$ $\mathcal{E}$ $i\in\mathcal{E}$ $a\in\mathcal{V}$ $s_{i}$ $f_{a}$ $\mathcal{E}(a)$ $a$ $\mathcal{V}(i)$ $i$ $i$ $d_{i}=|\mathcal{V}(i)|$ $s_{i}$ $q_{a}(\bm{s}_{a})$ $a\in\mathcal{V}$ $q_{i}(s_{i})$ $i\in\mathcal{E}$ $q_{\mathrm{Bethe}}(\bm{s})=\frac{\prod_{a\in\mathcal{V}}q_{a}(\bm{s}_{a})}{\prod_{i\in\mathcal{E}}q_{i}(s_{i})^{d_{i}-1}}\,.$ $s_{i}$ $d_{i}$ $q_{a}$ $q_{i}$ $d_{i}$ $q_{i}^{d_{i}-1}$ $d_{i}=1$ $\displaystyle\int q_{a}(\bm{s}_{a})\,\mathrm{d}\bm{s}_{a\setminus i}$ $\displaystyle=q_{i}(s_{i})\quad\text{for all }a\in\mathcal{V},\;i\in\mathcal{E}(a)\,,$ $\displaystyle\int q_{a}(\bm{s}_{a})\,\mathrm{d}\bm{s}_{a}$ $\displaystyle=1\quad\text{for all }a\in\mathcal{V}\,.$ $s_{i}$ $q_{i}$ $\mathcal{L}_{\mathcal{G}}$ $\log q_{\mathrm{Bethe}}(\bm{s})=\sum_{a\in\mathcal{V}}\log q_{a}(\bm{s}_{a})-\sum_{i\in\mathcal{E}}(d_{i}-1)\log q_{i}(s_{i})\,.$ $\log p(\bm{s})=\sum_{a\in\mathcal{V}}\log f_{a}(\bm{s}_{a})\,.$ $F[q]=\int q(\bm{s})\log\frac{q(\bm{s})}{p(\bm{s})}\,\mathrm{d}\bm{s}$ $F[q]=\int q(\bm{s})\left[\sum_{a\in\mathcal{V}}\log q_{a}(\bm{s}_{a})-\sum_{i\in\mathcal{E}}(d_{i}-1)\log q_{i}(s_{i})-\sum_{a\in\mathcal{V}}\log f_{a}(\bm{s}_{a})\right]\mathrm{d}\bm{s}\,.$ $g(\bm{s}_{a})$ $a$ $\int q(\bm{s})\,g(\bm{s}_{a})\,\mathrm{d}\bm{s}=\int q_{a}(\bm{s}_{a})\,g(\bm{s}_{a})\,\mathrm{d}\bm{s}_{a}\,,$ $q$ $q_{a}$ $\bm{s}_{a}$ $h(s_{i})$ $\int q(\bm{s})\,h(s_{i})\,\mathrm{d}\bm{s}=\int q_{i}(s_{i})\,h(s_{i})\,\mathrm{d}s_{i}\,.$ $F[q]=\sum_{a\in\mathcal{V}}\int q_{a}(\bm{s}_{a})\log\frac{q_{a}(\bm{s}_{a})}{f_{a}(\bm{s}_{a})}\,\mathrm{d}\bm{s}_{a}-\sum_{i\in\mathcal{E}}(d_{i}-1)\int q_{i}(s_{i})\log q_{i}(s_{i})\,\mathrm{d}s_{i}\,.$ $F_{\text{Bethe}}[q]=\sum_{a\in\mathcal{V}}\mathbb{D}_{\mathrm{KL}}\left[q_{a}(\bm{s}_{a})\|f_{a}(\bm{s}_{a})\right]+\sum_{i\in\mathcal{E}}(d_{i}-1)\,\mathbb{H}\left[q_{i}(s_{i})\right]\,,$ $\min_{\{q_{a},q_{i}\}\in\mathcal{L}_{\mathcal{G}}}F_{\text{Bethe}}[q]\,,$ $\mathcal{L}_{\mathcal{G}}$ $q(\bm{s})=\prod_{i}q_{i}(s_{i})$ $\theta$ $T=1$ $r_{u|x}(u_{1}|x_{0})$ $p(y_{1},x_{1},x_{0},\theta,u_{1})=p(\theta)\,p(x_{0})\,p(u_{1})\,p(x_{1}|x_{0},\theta,u_{1})\,p(y_{1}|x_{1},\theta)\,\hat{p}_{x}(x_{1})\,\hat{p}_{y}(y_{1}).$ $f_{\mathrm{obs}}(y_{1},x_{1},\theta)=p(y_{1}|x_{1},\theta)$ $f_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1})=p(x_{1}|x_{0},\theta,u_{1})$ $\theta$ $x_{0}$ $u_{1}$ $x_{1}$ $y_{1}$ $q_{\mathrm{obs}}(y_{1},x_{1},\theta),\qquad q_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1}),$ $q_{\theta}(\theta),\quad q_{x_{0}}(x_{0}),\quad q_{x_{1}}(x_{1}),\quad q_{y_{1}}(y_{1}),\quad q_{u_{1}}(u_{1}),$ $\displaystyle\int q_{\mathrm{obs}}(y_{1},x_{1},\theta)\,\mathrm{d}y_{1}\,\mathrm{d}x_{1}\,\mathrm{d}\theta$ $\displaystyle=1,$ $\displaystyle\int q_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1})\,\mathrm{d}x_{1}\,\mathrm{d}x_{0}\,\mathrm{d}\theta\,\mathrm{d}u_{1}$ $\displaystyle=1,$ $\displaystyle\int q_{\mathrm{obs}}(y_{1},x_{1},\theta)\,\mathrm{d}x_{1}\,\mathrm{d}\theta$ $\displaystyle=q_{y_{1}}(y_{1}),$ $\displaystyle\int q_{\mathrm{obs}}(y_{1},x_{1},\theta)\,\mathrm{d}y_{1}\,\mathrm{d}\theta$ $\displaystyle=q_{x_{1}}(x_{1}),$ $\displaystyle\int q_{\mathrm{obs}}(y_{1},x_{1},\theta)\,\mathrm{d}y_{1}\,\mathrm{d}x_{1}$ $\displaystyle=q_{\theta}(\theta),$ $\displaystyle\int q_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1})\,\mathrm{d}x_{0}\,\mathrm{d}\theta\,\mathrm{d}u_{1}$ $\displaystyle=q_{x_{1}}(x_{1}),$ $\displaystyle\int q_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1})\,\mathrm{d}x_{1}\,\mathrm{d}\theta\,\mathrm{d}u_{1}$ $\displaystyle=q_{x_{0}}(x_{0}),$ $\displaystyle\int q_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1})\,\mathrm{d}x_{1}\,\mathrm{d}x_{0}\,\mathrm{d}u_{1}$ $\displaystyle=q_{\theta}(\theta),$ $\displaystyle\int q_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1})\,\mathrm{d}x_{1}\,\mathrm{d}x_{0}\,\mathrm{d}\theta$ $\displaystyle=q_{u_{1}}(u_{1}).$ $\displaystyle r_{y|x\theta}(y_{1}|x_{1},\theta),\qquad r_{y|x}(y_{1}|x_{1}),\qquad r_{x|xu}(x_{1}|x_{0},u_{1}),\qquad r_{u|x}(u_{1}|x_{0}),$ $\displaystyle\int r_{y|x\theta}(y_{1}|x_{1},\theta)\,\mathrm{d}y_{1}$ $\displaystyle=1\quad\forall(x_{1},\theta),$ $\displaystyle\int r_{y|x}(y_{1}|x_{1})\,\mathrm{d}y_{1}$ $\displaystyle=1\quad\forall x_{1},$ $\displaystyle\int r_{x|xu}(x_{1}|x_{0},u_{1})\,\mathrm{d}x_{1}$ $\displaystyle=1\quad\forall(x_{0},u_{1}),$ $\displaystyle\int r_{u|x}(u_{1}|x_{0})\,\mathrm{d}u_{1}$ $\displaystyle=1\quad\forall x_{0}.$ $\displaystyle q_{\mathrm{sep}}(x_{1},\theta)$ $\displaystyle:=\int q_{\mathrm{obs}}(y_{1},x_{1},\theta)\,\mathrm{d}y_{1},$ $\displaystyle q_{yx}(y_{1},x_{1})$ $\displaystyle:=\int q_{\mathrm{obs}}(y_{1},x_{1},\theta)\,\mathrm{d}\theta,$ $\displaystyle q_{\mathrm{trip}}(x_{1},x_{0},u_{1})$ $\displaystyle:=\int q_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1})\,\mathrm{d}\theta,$ $\displaystyle q_{\mathrm{pair}}(x_{0},u_{1})$ $\displaystyle:=\int q_{\mathrm{trip}}(x_{1},x_{0},u_{1})\,\mathrm{d}x_{1},$ $\displaystyle q_{ux}(u_{1},x_{0})$ $\displaystyle:=\int q_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1})\,\mathrm{d}x_{1}\,\mathrm{d}\theta.$ $q_{ux}(u_{1},x_{0})=q_{\mathrm{pair}}(x_{0},u_{1})$ $T=1$ $\Delta F_{\mathrm{comb}}=\underbrace{2\mathbb{H}\left[q(y_{1}|x_{1},\theta)\right]-\mathbb{H}\left[q(x_{1}|x_{0},u_{1})\right]-\mathbb{H}\left[q(y_{1}|x_{1})\right]}_{\Delta^{\mathrm{AIF}}}+\underbrace{\mathbb{H}\left[q(u_{1}|x_{0})\right]}_{\Delta^{\mathrm{planning}}}.$ $+\mathbb{H}\left[q(u_{1}|x_{0})\right]$ $-\mathbb{E}_{q_{\mathrm{dyn}}}\left[\log r_{u|x}(u_{1}|x_{0})\right]$ $r_{u|x}$ $-\mathbb{H}\left[q(x_{1}|x_{0},u_{1})\right]$ $+\mathbb{E}_{q_{\mathrm{dyn}}}\left[\log r_{x|xu}(x_{1}|x_{0},u_{1})\right]$ $r_{x|xu}$ $+2\mathbb{H}\left[q(y_{1}|x_{1},\theta)\right]$ $-2\mathbb{E}_{q_{\mathrm{obs}}}\left[\log r_{y|x\theta}(y_{1}|x_{1},\theta)\right]$ $r_{y|x\theta}^{2}$ $-\mathbb{H}\left[q(y_{1}|x_{1})\right]$ $+\mathbb{E}_{q_{yx}}\left[\log r_{y|x}(y_{1}|x_{1})\right]$ $r_{y|x}$ $\displaystyle F_{\mathrm{comb}}[q,r]$ $\displaystyle=\int q_{\mathrm{obs}}\log\frac{q_{\mathrm{obs}}}{p(y_{1}|x_{1},\theta)}\,\mathrm{d}y_{1}\,\mathrm{d}x_{1}\,\mathrm{d}\theta-2\int q_{\mathrm{obs}}\log r_{y|x\theta}\,\mathrm{d}y_{1}\,\mathrm{d}x_{1}\,\mathrm{d}\theta$ $\displaystyle+\int q_{yx}(y_{1},x_{1})\log r_{y|x}(y_{1}|x_{1})\,\mathrm{d}y_{1}\,\mathrm{d}x_{1}$ $\displaystyle+\int q_{\mathrm{dyn}}\log\frac{q_{\mathrm{dyn}}}{p(x_{1}|x_{0},\theta,u_{1})}\,\mathrm{d}x_{1}\,\mathrm{d}x_{0}\,\mathrm{d}\theta\,\mathrm{d}u_{1}$ $\displaystyle+\int q_{\mathrm{dyn}}\log r_{x|xu}(x_{1}|x_{0},u_{1})\,\mathrm{d}x_{1}\,\mathrm{d}x_{0}\,\mathrm{d}\theta\,\mathrm{d}u_{1}$ $\displaystyle-\int q_{\mathrm{dyn}}\log r_{u|x}(u_{1}|x_{0})\,\mathrm{d}x_{1}\,\mathrm{d}x_{0}\,\mathrm{d}\theta\,\mathrm{d}u_{1}$ $\displaystyle-\int q_{x_{0}}\log p(x_{0})\,\mathrm{d}x_{0}-\int q_{u_{1}}\log p(u_{1})\,\mathrm{d}u_{1}-\int q_{y_{1}}\log\hat{p}_{y}(y_{1})\,\mathrm{d}y_{1}$ $\displaystyle+(d_{\theta}-1)\mathbb{H}\left[q_{\theta}\right]-\int q_{\theta}\log p(\theta)\,\mathrm{d}\theta$ $\displaystyle+(d_{x_{1}}-1)\mathbb{H}\left[q_{x_{1}}\right]-\int q_{x_{1}}\log\hat{p}_{x}(x_{1})\,\mathrm{d}x_{1}.$ $d_{\theta}=3,\qquad d_{x_{0}}=2,\qquad d_{x_{1}}=3,\qquad d_{y_{1}}=2,\qquad d_{u_{1}}=2.$ $\displaystyle\tilde{f}_{\mathrm{obs}}(y_{1},x_{1},\theta)$ $\displaystyle=\frac{p(y_{1}|x_{1},\theta)\,r_{y|x\theta}^{2}(y_{1}|x_{1},\theta)}{r_{y|x}(y_{1}|x_{1})},$ $\displaystyle\tilde{f}_{\mathrm{dyn}}^{\mathrm{comb}}(x_{1},x_{0},\theta,u_{1})$ $\displaystyle=\frac{p(x_{1}|x_{0},\theta,u_{1})\,r_{u|x}(u_{1}|x_{0})}{r_{x|xu}(x_{1}|x_{0},u_{1})}.$ $\tilde{f}_{\mathrm{obs}}(y_{1},x_{1},\theta)=\frac{p(y_{1}|x_{1},\theta)\,r_{y|x\theta}^{2}(y_{1}|x_{1},\theta)}{r_{y|x}(y_{1}|x_{1})},$ $r_{u|x}$ $r_{x|xu}$ $\lambda_{\mathrm{obs}},\quad\lambda_{\mathrm{dyn}},\quad\lambda_{y_{1}}(y_{1}),\quad\lambda_{\theta}^{(\mathrm{obs})}(\theta),\quad\lambda_{x_{1}}^{(\mathrm{obs})}(x_{1}),\quad\lambda_{x_{1}}^{(\mathrm{dyn})}(x_{1}),\quad\lambda_{x_{0}}(x_{0}),\quad\lambda_{u_{1}}(u_{1}),\quad\lambda_{\theta}^{(\mathrm{dyn})}(\theta),$ $\nu_{\mathrm{obs}}(x_{1},\theta),\qquad\nu_{y|x}(x_{1}),\qquad\nu_{x}(x_{0},u_{1}),\qquad\nu_{u|x}(x_{0}).$ $\displaystyle\mathcal{L}_{\mathrm{comb}}$ $\displaystyle=F_{\mathrm{comb}}[q,r]$ $\displaystyle+\lambda_{\mathrm{obs}}\left(\int q_{\mathrm{obs}}(y_{1},x_{1},\theta)\,\mathrm{d}y_{1}\,\mathrm{d}x_{1}\,\mathrm{d}\theta-1\right)$ $\displaystyle+\lambda_{\mathrm{dyn}}\left(\int q_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1})\,\mathrm{d}x_{1}\,\mathrm{d}x_{0}\,\mathrm{d}\theta\,\mathrm{d}u_{1}-1\right)$ $\displaystyle+\int\lambda_{y_{1}}(y_{1})\left(\int q_{\mathrm{obs}}(y_{1},x_{1},\theta)\,\mathrm{d}x_{1}\,\mathrm{d}\theta-q_{y_{1}}(y_{1})\right)\mathrm{d}y_{1}$ $\displaystyle+\int\lambda_{\theta}^{(\mathrm{obs})}(\theta)\left(\int q_{\mathrm{obs}}(y_{1},x_{1},\theta)\,\mathrm{d}y_{1}\,\mathrm{d}x_{1}-q_{\theta}(\theta)\right)\mathrm{d}\theta$ $\displaystyle+\int\lambda_{x_{1}}^{(\mathrm{obs})}(x_{1})\left(\int q_{\mathrm{obs}}(y_{1},x_{1},\theta)\,\mathrm{d}y_{1}\,\mathrm{d}\theta-q_{x_{1}}(x_{1})\right)\mathrm{d}x_{1}$ $\displaystyle+\int\lambda_{x_{1}}^{(\mathrm{dyn})}(x_{1})\left(\int q_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1})\,\mathrm{d}x_{0}\,\mathrm{d}\theta\,\mathrm{d}u_{1}-q_{x_{1}}(x_{1})\right)\mathrm{d}x_{1}$ $\displaystyle+\int\lambda_{x_{0}}(x_{0})\left(\int q_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1})\,\mathrm{d}x_{1}\,\mathrm{d}\theta\,\mathrm{d}u_{1}-q_{x_{0}}(x_{0})\right)\mathrm{d}x_{0}$ $\displaystyle+\int\lambda_{u_{1}}(u_{1})\left(\int q_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1})\,\mathrm{d}x_{1}\,\mathrm{d}x_{0}\,\mathrm{d}\theta-q_{u_{1}}(u_{1})\right)\mathrm{d}u_{1}$ $\displaystyle+\int\lambda_{\theta}^{(\mathrm{dyn})}(\theta)\left(\int q_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1})\,\mathrm{d}x_{1}\,\mathrm{d}x_{0}\,\mathrm{d}u_{1}-q_{\theta}(\theta)\right)\mathrm{d}\theta$ $\displaystyle+\iint\nu_{\mathrm{obs}}(x_{1},\theta)\left(\int r_{y|x\theta}(y_{1}|x_{1},\theta)\,\mathrm{d}y_{1}-1\right)\mathrm{d}x_{1}\,\mathrm{d}\theta$ $\displaystyle+\iint\nu_{y|x}(x_{1})\left(\int r_{y|x}(y_{1}|x_{1})\,\mathrm{d}y_{1}-1\right)\mathrm{d}x_{1}$ $\displaystyle+\iint\nu_{x}(x_{0},u_{1})\left(\int r_{x|xu}(x_{1}|x_{0},u_{1})\,\mathrm{d}x_{1}-1\right)\mathrm{d}x_{0}\,\mathrm{d}u_{1}$ $\displaystyle+\int\nu_{u|x}(x_{0})\left(\int r_{u|x}(u_{1}|x_{0})\,\mathrm{d}u_{1}-1\right)\mathrm{d}x_{0}.$ $q_{\mathrm{obs}}$ $q_{\mathrm{obs}}^{*}(y_{1},x_{1},\theta)\propto\frac{p(y_{1}|x_{1},\theta)\,r_{y|x\theta}^{2}(y_{1}|x_{1},\theta)}{r_{y|x}(y_{1}|x_{1})}e^{-\lambda_{y_{1}}(y_{1})}e^{-\lambda_{\theta}^{(\mathrm{obs})}(\theta)}e^{-\lambda_{x_{1}}^{(\mathrm{obs})}(x_{1})}.$ $q_{\mathrm{dyn}}$ $\displaystyle\int q_{\mathrm{dyn}}\log q_{\mathrm{dyn}}-\int q_{\mathrm{dyn}}\log p(x_{1}|x_{0},\theta,u_{1})+\int q_{\mathrm{dyn}}\log r_{x|xu}(x_{1}|x_{0},u_{1})$ $\displaystyle-\int q_{\mathrm{dyn}}\log r_{u|x}(u_{1}|x_{0})+\text{(multiplier terms)}.$ $\frac{\delta\mathcal{L}_{\mathrm{comb}}}{\delta q_{\mathrm{dyn}}}=0$ $\log q_{\mathrm{dyn}}+1-\log p(x_{1}|x_{0},\theta,u_{1})+\log r_{x|xu}(x_{1}|x_{0},u_{1})-\log r_{u|x}(u_{1}|x_{0})+\lambda_{\mathrm{dyn}}+\lambda_{x_{1}}^{(\mathrm{dyn})}+\lambda_{x_{0}}+\lambda_{u_{1}}+\lambda_{\theta}^{(\mathrm{dyn})}=0.$ $q_{\mathrm{dyn}}^{*}(x_{1},x_{0},\theta,u_{1})\propto\frac{p(x_{1}|x_{0},\theta,u_{1})\,r_{u|x}(u_{1}|x_{0})}{r_{x|xu}(x_{1}|x_{0},u_{1})}e^{-\lambda_{x_{1}}^{(\mathrm{dyn})}(x_{1})}e^{-\lambda_{x_{0}}(x_{0})}e^{-\lambda_{u_{1}}(u_{1})}e^{-\lambda_{\theta}^{(\mathrm{dyn})}(\theta)}.$ $\displaystyle r_{y|x\theta}^{*}(y_{1}|x_{1},\theta)$ $\displaystyle=\frac{q_{\mathrm{obs}}(y_{1},x_{1},\theta)}{q_{\mathrm{sep}}(x_{1},\theta)}=q(y_{1}|x_{1},\theta),$ $\displaystyle r_{y|x}^{*}(y_{1}|x_{1})$ $\displaystyle=\frac{q_{yx}(y_{1},x_{1})}{q_{x_{1}}(x_{1})}=q(y_{1}|x_{1}).$ $r_{x|xu}$ $\frac{\delta\mathcal{L}_{\mathrm{comb}}}{\delta r_{x|xu}(x_{1}|x_{0},u_{1})}=\frac{q_{\mathrm{trip}}(x_{1},x_{0},u_{1})}{r_{x|xu}(x_{1}|x_{0},u_{1})}+\nu_{x}(x_{0},u_{1})=0.$ $r_{x|xu}^{*}(x_{1}|x_{0},u_{1})=\frac{q_{\mathrm{trip}}(x_{1},x_{0},u_{1})}{q_{\mathrm{pair}}(x_{0},u_{1})}=q(x_{1}|x_{0},u_{1}).$ $r_{u|x}$ $r_{u|x}$ $x_{1}$ $\theta$ $q_{ux}(u_{1},x_{0})$ $-\int q_{ux}(u_{1},x_{0})\log r_{u|x}(u_{1}|x_{0})\,\mathrm{d}u_{1}\,\mathrm{d}x_{0}+\int\nu_{u|x}(x_{0})\left(\int r_{u|x}(u_{1}|x_{0})\,\mathrm{d}u_{1}-1\right)\mathrm{d}x_{0}.$ $-\frac{q_{ux}(u_{1},x_{0})}{r_{u|x}(u_{1}|x_{0})}+\nu_{u|x}(x_{0})=0.$ $\nu_{u|x}(x_{0})=q_{x_{0}}(x_{0})$ $r_{u|x}^{*}(u_{1}|x_{0})=\frac{q_{ux}(u_{1},x_{0})}{q_{x_{0}}(x_{0})}=q(u_{1}|x_{0}).$ $d_{y_{1}}=d_{x_{0}}=d_{u_{1}}=2,\qquad d_{\theta}=d_{x_{1}}=3,$ $y_{1}$ $x_{0}$ $u_{1}$ $\lambda_{y_{1}}(y_{1})=-\log\hat{p}_{y}(y_{1}),\qquad\lambda_{x_{0}}(x_{0})=-\log p(x_{0}),\qquad\lambda_{u_{1}}(u_{1})=-\log p(u_{1});$ $\theta$ $x_{1}$ $\lambda_{\theta}^{(\mathrm{obs})}(\theta)+\lambda_{\theta}^{(\mathrm{dyn})}(\theta)=-\log q_{\theta}^{*}(\theta)-1-\log p(\theta),$ $\lambda_{x_{1}}^{(\mathrm{obs})}(x_{1})+\lambda_{x_{1}}^{(\mathrm{dyn})}(x_{1})=-\log q_{x_{1}}^{*}(x_{1})-1-\log\hat{p}_{x}(x_{1}).$ $a$ $\tilde{f}_{a}$ $\mathcal{E}(a)$ $\mu_{a\to j}(s_{j})\propto\int\tilde{f}_{a}(\bm{s}_{a})\prod_{i\in\mathcal{E}(a)\setminus j}\mu_{i\to a}(s_{i})\,\mathrm{d}\bm{s}_{a\setminus j}.$ $\displaystyle\mu_{\mathrm{obs}\to\theta}(\theta)$ $\displaystyle=\iint\frac{p(y_{1}|x_{1},\theta)\,r_{y|x\theta}^{2}(y_{1}|x_{1},\theta)}{r_{y|x}(y_{1}|x_{1})}\mu_{y_{1}\to\mathrm{obs}}(y_{1})\mu_{x_{1}\to\mathrm{obs}}(x_{1})\,\mathrm{d}y_{1}\,\mathrm{d}x_{1},$ $\displaystyle\mu_{\mathrm{obs}\to x_{1}}(x_{1})$ $\displaystyle=\iint\frac{p(y_{1}|x_{1},\theta)\,r_{y|x\theta}^{2}(y_{1}|x_{1},\theta)}{r_{y|x}(y_{1}|x_{1})}\mu_{y_{1}\to\mathrm{obs}}(y_{1})\mu_{\theta\to\mathrm{obs}}(\theta)\,\mathrm{d}y_{1}\,\mathrm{d}\theta,$ $\displaystyle\mu_{\mathrm{obs}\to y_{1}}(y_{1})$ $\displaystyle=\iint\frac{p(y_{1}|x_{1},\theta)\,r_{y|x\theta}^{2}(y_{1}|x_{1},\theta)}{r_{y|x}(y_{1}|x_{1})}\mu_{x_{1}\to\mathrm{obs}}(x_{1})\mu_{\theta\to\mathrm{obs}}(\theta)\,\mathrm{d}x_{1}\,\mathrm{d}\theta.$ $\displaystyle\mu_{\mathrm{dyn}\to\theta}(\theta)$ $\displaystyle=\iiint\frac{p(x_{1}|x_{0},\theta,u_{1})\,r_{u|x}(u_{1}|x_{0})}{r_{x|xu}(x_{1}|x_{0},u_{1})}\mu_{x_{1}\to\mathrm{dyn}}(x_{1})\mu_{x_{0}\to\mathrm{dyn}}(x_{0})\mu_{u_{1}\to\mathrm{dyn}}(u_{1})\,\mathrm{d}x_{1}\,\mathrm{d}x_{0}\,\mathrm{d}u_{1},$ $\displaystyle\mu_{\mathrm{dyn}\to x_{1}}(x_{1})$ $\displaystyle=\iiint\frac{p(x_{1}|x_{0},\theta,u_{1})\,r_{u|x}(u_{1}|x_{0})}{r_{x|xu}(x_{1}|x_{0},u_{1})}\mu_{x_{0}\to\mathrm{dyn}}(x_{0})\mu_{u_{1}\to\mathrm{dyn}}(u_{1})\mu_{\theta\to\mathrm{dyn}}(\theta)\,\mathrm{d}x_{0}\,\mathrm{d}u_{1}\,\mathrm{d}\theta,$ $\displaystyle\mu_{\mathrm{dyn}\to x_{0}}(x_{0})$ $\displaystyle=\iiint\frac{p(x_{1}|x_{0},\theta,u_{1})\,r_{u|x}(u_{1}|x_{0})}{r_{x|xu}(x_{1}|x_{0},u_{1})}\mu_{x_{1}\to\mathrm{dyn}}(x_{1})\mu_{u_{1}\to\mathrm{dyn}}(u_{1})\mu_{\theta\to\mathrm{dyn}}(\theta)\,\mathrm{d}x_{1}\,\mathrm{d}u_{1}\,\mathrm{d}\theta,$ $\displaystyle\mu_{\mathrm{dyn}\to u_{1}}(u_{1})$ $\displaystyle=\iiint\frac{p(x_{1}|x_{0},\theta,u_{1})\,r_{u|x}(u_{1}|x_{0})}{r_{x|xu}(x_{1}|x_{0},u_{1})}\mu_{x_{1}\to\mathrm{dyn}}(x_{1})\mu_{x_{0}\to\mathrm{dyn}}(x_{0})\mu_{\theta\to\mathrm{dyn}}(\theta)\,\mathrm{d}x_{1}\,\mathrm{d}x_{0}\,\mathrm{d}\theta.$ $\displaystyle q_{\mathrm{obs}}^{*}(y_{1},x_{1},\theta)$ $\displaystyle\propto\tilde{f}_{\mathrm{obs}}(y_{1},x_{1},\theta)\,\mu_{y_{1}\to\mathrm{obs}}(y_{1})\mu_{x_{1}\to\mathrm{obs}}(x_{1})\mu_{\theta\to\mathrm{obs}}(\theta),$ $\displaystyle q_{\mathrm{dyn}}^{*}(x_{1},x_{0},\theta,u_{1})$ $\displaystyle\propto\tilde{f}_{\mathrm{dyn}}^{\mathrm{comb}}(x_{1},x_{0},\theta,u_{1})\,\mu_{x_{1}\to\mathrm{dyn}}(x_{1})\mu_{x_{0}\to\mathrm{dyn}}(x_{0})\mu_{\theta\to\mathrm{dyn}}(\theta)\mu_{u_{1}\to\mathrm{dyn}}(u_{1}).$ $\displaystyle q_{\theta}^{*}(\theta)$ $\displaystyle\propto p(\theta)\,\mu_{\mathrm{obs}\to\theta}(\theta)\,\mu_{\mathrm{dyn}\to\theta}(\theta),$ $\displaystyle q_{x_{1}}^{*}(x_{1})$ $\displaystyle\propto\hat{p}_{x}(x_{1})\,\mu_{\mathrm{obs}\to x_{1}}(x_{1})\,\mu_{\mathrm{dyn}\to x_{1}}(x_{1}),$ $\displaystyle q_{x_{0}}^{*}(x_{0})$ $\displaystyle\propto p(x_{0})\,\mu_{\mathrm{dyn}\to x_{0}}(x_{0}),$ $\displaystyle q_{u_{1}}^{*}(u_{1})$ $\displaystyle\propto p(u_{1})\,\mu_{\mathrm{dyn}\to u_{1}}(u_{1}),$ $\displaystyle q_{y_{1}}^{*}(y_{1})$ $\displaystyle\propto\hat{p}_{y}(y_{1})\,\mu_{\mathrm{obs}\to y_{1}}(y_{1}).$ $\displaystyle r_{y|x\theta}^{*}(y_{1}|x_{1},\theta)$ $\displaystyle=q(y_{1}|x_{1},\theta),$ $\displaystyle r_{y|x}^{*}(y_{1}|x_{1})$ $\displaystyle=q(y_{1}|x_{1}),$ $\displaystyle r_{x|xu}^{*}(x_{1}|x_{0},u_{1})$ $\displaystyle=q(x_{1}|x_{0},u_{1}),$ $\displaystyle r_{u|x}^{*}(u_{1}|x_{0})$ $\displaystyle=q(u_{1}|x_{0}).$ $r_{x|xu}$ $\mathbb{H}\left[q(x_{1}|x_{0},u_{1})\right]$ $r_{u|x}$ $\mathbb{H}\left[q(u_{1}|x_{0})\right]$ $T$ $T=1$ $r_{y|x\theta,t}(y_{t}|x_{t},\theta),\quad r_{y|x,t}(y_{t}|x_{t}),\quad r_{x|xu,t}(x_{t}|x_{t-1},u_{t}),\quad r_{u|x,t}(u_{t}|x_{t-1}).$ $\displaystyle\tilde{f}_{\mathrm{obs}_{t}}(y_{t},x_{t},\theta)$ $\displaystyle=\frac{p(y_{t}|x_{t},\theta)\,r_{y|x\theta,t}^{2}(y_{t}|x_{t},\theta)}{r_{y|x,t}(y_{t}|x_{t})},$ $\displaystyle\tilde{f}_{\mathrm{dyn}_{t}}^{\mathrm{comb}}(x_{t},x_{t-1},\theta,u_{t})$ $\displaystyle=\frac{p(x_{t}|x_{t-1},\theta,u_{t})\,r_{u|x,t}(u_{t}|x_{t-1})}{r_{x|xu,t}(x_{t}|x_{t-1},u_{t})}.$ $f_{\mathrm{obs}_{t}}$ $\displaystyle\mu_{\mathrm{obs}_{t}\to\theta}(\theta)$ $\displaystyle=\iint\frac{p(y_{t}|x_{t},\theta)\,r_{y|x\theta,t}^{2}(y_{t}|x_{t},\theta)}{r_{y|x,t}(y_{t}|x_{t})}\mu_{y_{t}\to\mathrm{obs}_{t}}(y_{t})\mu_{x_{t}\to\mathrm{obs}_{t}}(x_{t})\,\mathrm{d}y_{t}\,\mathrm{d}x_{t},$ $\displaystyle\mu_{\mathrm{obs}_{t}\to x_{t}}(x_{t})$ $\displaystyle=\iint\frac{p(y_{t}|x_{t},\theta)\,r_{y|x\theta,t}^{2}(y_{t}|x_{t},\theta)}{r_{y|x,t}(y_{t}|x_{t})}\mu_{y_{t}\to\mathrm{obs}_{t}}(y_{t})\mu_{\theta\to\mathrm{obs}_{t}}(\theta)\,\mathrm{d}y_{t}\,\mathrm{d}\theta,$ $\displaystyle\mu_{\mathrm{obs}_{t}\to y_{t}}(y_{t})$ $\displaystyle=\iint\frac{p(y_{t}|x_{t},\theta)\,r_{y|x\theta,t}^{2}(y_{t}|x_{t},\theta)}{r_{y|x,t}(y_{t}|x_{t})}\mu_{x_{t}\to\mathrm{obs}_{t}}(x_{t})\mu_{\theta\to\mathrm{obs}_{t}}(\theta)\,\mathrm{d}x_{t}\,\mathrm{d}\theta.$ $f_{\mathrm{dyn}_{t}}$ $\displaystyle\mu_{\mathrm{dyn}_{t}\to\theta}(\theta)$ $\displaystyle=\iiint\frac{p(x_{t}|x_{t-1},\theta,u_{t})\,r_{u|x,t}(u_{t}|x_{t-1})}{r_{x|xu,t}(x_{t}|x_{t-1},u_{t})}$ $\displaystyle\qquad\times\mu_{x_{t}\to\mathrm{dyn}_{t}}(x_{t})\mu_{x_{t-1}\to\mathrm{dyn}_{t}}(x_{t-1})\mu_{u_{t}\to\mathrm{dyn}_{t}}(u_{t})\,\mathrm{d}x_{t}\,\mathrm{d}x_{t-1}\,\mathrm{d}u_{t},$ $\displaystyle\mu_{\mathrm{dyn}_{t}\to x_{t}}(x_{t})$ $\displaystyle=\iiint\frac{p(x_{t}|x_{t-1},\theta,u_{t})\,r_{u|x,t}(u_{t}|x_{t-1})}{r_{x|xu,t}(x_{t}|x_{t-1},u_{t})}\mu_{x_{t-1}\to\mathrm{dyn}_{t}}(x_{t-1})\mu_{u_{t}\to\mathrm{dyn}_{t}}(u_{t})\mu_{\theta\to\mathrm{dyn}_{t}}(\theta)\,\mathrm{d}x_{t-1}\,\mathrm{d}u_{t}\,\mathrm{d}\theta,$ $\displaystyle\mu_{\mathrm{dyn}_{t}\to x_{t-1}}(x_{t-1})$ $\displaystyle=\iiint\frac{p(x_{t}|x_{t-1},\theta,u_{t})\,r_{u|x,t}(u_{t}|x_{t-1})}{r_{x|xu,t}(x_{t}|x_{t-1},u_{t})}\mu_{x_{t}\to\mathrm{dyn}_{t}}(x_{t})\mu_{u_{t}\to\mathrm{dyn}_{t}}(u_{t})\mu_{\theta\to\mathrm{dyn}_{t}}(\theta)\,\mathrm{d}x_{t}\,\mathrm{d}u_{t}\,\mathrm{d}\theta,$ $\displaystyle\mu_{\mathrm{dyn}_{t}\to u_{t}}(u_{t})$ $\displaystyle=\iiint\frac{p(x_{t}|x_{t-1},\theta,u_{t})\,r_{u|x,t}(u_{t}|x_{t-1})}{r_{x|xu,t}(x_{t}|x_{t-1},u_{t})}\mu_{x_{t}\to\mathrm{dyn}_{t}}(x_{t})\mu_{x_{t-1}\to\mathrm{dyn}_{t}}(x_{t-1})\mu_{\theta\to\mathrm{dyn}_{t}}(\theta)\,\mathrm{d}x_{t}\,\mathrm{d}x_{t-1}\,\mathrm{d}\theta.$ $\displaystyle q_{\mathrm{obs},t}^{*}(y_{t},x_{t},\theta)$ $\displaystyle\propto\tilde{f}_{\mathrm{obs}_{t}}(y_{t},x_{t},\theta)\,\mu_{y_{t}\to\mathrm{obs}_{t}}(y_{t})\mu_{x_{t}\to\mathrm{obs}_{t}}(x_{t})\mu_{\theta\to\mathrm{obs}_{t}}(\theta),$ $\displaystyle q_{\mathrm{dyn},t}^{*}(x_{t},x_{t-1},\theta,u_{t})$ $\displaystyle\propto\tilde{f}_{\mathrm{dyn}_{t}}^{\mathrm{comb}}(x_{t},x_{t-1},\theta,u_{t})\,\mu_{x_{t}\to\mathrm{dyn}_{t}}(x_{t})\mu_{x_{t-1}\to\mathrm{dyn}_{t}}(x_{t-1})\mu_{\theta\to\mathrm{dyn}_{t}}(\theta)\mu_{u_{t}\to\mathrm{dyn}_{t}}(u_{t}).$ $\displaystyle r_{y|x\theta,t}^{*}(y_{t}|x_{t},\theta)$ $\displaystyle=q_{t}(y_{t}|x_{t},\theta),$ $\displaystyle r_{y|x,t}^{*}(y_{t}|x_{t})$ $\displaystyle=q_{t}(y_{t}|x_{t}),$ $\displaystyle r_{x|xu,t}^{*}(x_{t}|x_{t-1},u_{t})$ $\displaystyle=q_{t}(x_{t}|x_{t-1},u_{t}),$ $\displaystyle r_{u|x,t}^{*}(u_{t}|x_{t-1})$ $\displaystyle=q_{t}(u_{t}|x_{t-1}).$ $\displaystyle q_{x_{t}}^{*}(x_{t})$ $\displaystyle\propto\hat{p}_{x}(x_{t})\,\mu_{\mathrm{obs}_{t}\to x_{t}}(x_{t})\,\mu_{\mathrm{dyn}_{t}\to x_{t}}(x_{t})\,\mu_{\mathrm{dyn}_{t+1}\to x_{t}}(x_{t}),$ $\displaystyle q_{\theta}^{*}(\theta)$ $\displaystyle\propto p(\theta)\prod_{\tau=1}^{T}\mu_{\mathrm{obs}_{\tau}\to\theta}(\theta)\,\mu_{\mathrm{dyn}_{\tau}\to\theta}(\theta),$ $\displaystyle q_{u_{t}}^{*}(u_{t})$ $\displaystyle\propto p(u_{t})\,\mu_{\mathrm{dyn}_{t}\to u_{t}}(u_{t}),$ $\displaystyle q_{y_{t}}^{*}(y_{t})$ $\displaystyle\propto\hat{p}_{y}(y_{t})\,\mu_{\mathrm{obs}_{t}\to y_{t}}(y_{t}).$ $t=1$ $\mu_{x_{0}\to\mathrm{dyn}_{1}}(x_{0})=p(x_{0})$ $t=T$ $\mu_{\mathrm{dyn}_{T+1}\to x_{T}}$ $\tilde{f}_{\mathrm{dyn}_{t}}^{\mathrm{comb}}(x_{t},x_{t-1},\theta,u_{t})=\frac{p(x_{t}|x_{t-1},\theta,u_{t})\,q(u_{t}|x_{t-1})}{q(x_{t}|x_{t-1},u_{t})}.$ $r_{y|x\theta}$ $r_{y|x}$ $q_{\mathrm{obs}}(y_{1},x_{1},\theta)$ $q_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1})$ $q_{\theta},q_{x_{0}},q_{x_{1}},q_{y_{1}},q_{u_{1}}$ $r_{u|x}(u_{1}|x_{0}),\quad\text{subject to}\quad\int r_{u|x}(u_{1}|x_{0})\,\mathrm{d}u_{1}=1\quad\forall\,x_{0}.$ $\mathbb{H}\left[q(u_{1}|x_{0})\right]=\min_{r_{u|x}}\mathbb{E}_{q_{\mathrm{pair}}(x_{0},u_{1})}\left[-\log r_{u|x}(u_{1}|x_{0})\right],$ $r_{u|x}(u_{1}|x_{0})=q(u_{1}|x_{0})$ $q_{\mathrm{pair}}(x_{0},u_{1}):=\iint q_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1})\,\mathrm{d}x_{1}\,\mathrm{d}\theta$ $(x_{0},u_{1})$ $\Delta F_{\mathrm{VBP}}=+\mathbb{H}\left[q(u_{1}|x_{0})\right].$ $\displaystyle F_{\mathrm{VBP}}[q,r_{u|x}]$ $\displaystyle=\int q_{\mathrm{obs}}\log\frac{q_{\mathrm{obs}}}{p(y_{1}|x_{1},\theta)}\,\mathrm{d}y_{1}\,\mathrm{d}x_{1}\,\mathrm{d}\theta$ $\displaystyle+\int q_{\mathrm{dyn}}\log\frac{q_{\mathrm{dyn}}}{p(x_{1}|x_{0},\theta,u_{1})}\,\mathrm{d}x_{1}\,\mathrm{d}x_{0}\,\mathrm{d}\theta\,\mathrm{d}u_{1}$ $\displaystyle-\int q_{\mathrm{dyn}}\log r_{u|x}(u_{1}|x_{0})\,\mathrm{d}x_{1}\,\mathrm{d}x_{0}\,\mathrm{d}\theta\,\mathrm{d}u_{1}$ $\displaystyle+\text{(the usual singleton Bethe terms)}.$ $+\mathbb{H}\left[q(u_{1}|x_{0})\right]$ $-\mathbb{E}_{q}\left[\log r_{u|x}\right]$ $r_{u|x}$ $r_{x|xu}$ $\nu_{u|x}(x_{0})$ $q_{\mathrm{obs}}$ $q_{\mathrm{obs}}^{*}(y_{1},x_{1},\theta)\propto p(y_{1}|x_{1},\theta)\,e^{-\lambda_{y_{1}}(y_{1})}\,e^{-\lambda_{\theta}^{(\mathrm{obs})}(\theta)}\,e^{-\lambda_{x_{1}}^{(\mathrm{obs})}(x_{1})}.$ $p(y_{1}|x_{1},\theta)$ $q_{\mathrm{dyn}}$ $q_{\mathrm{dyn}}$ $-\int q_{\mathrm{dyn}}\log r_{u|x}(u_{1}|x_{0})$ $\frac{\delta\mathcal{L}}{\delta q_{\mathrm{dyn}}}=0$ $\log q_{\mathrm{dyn}}+1-\log p(x_{1}|x_{0},\theta,u_{1})-\log r_{u|x}(u_{1}|x_{0})+\lambda_{\mathrm{dyn}}+\lambda_{x_{1}}^{(\mathrm{dyn})}+\lambda_{x_{0}}+\lambda_{u_{1}}+\lambda_{\theta}^{(\mathrm{dyn})}=0.$ $q_{\mathrm{dyn}}^{*}(x_{1},x_{0},\theta,u_{1})\propto p(x_{1}|x_{0},\theta,u_{1})\,r_{u|x}(u_{1}|x_{0})\,e^{-\lambda_{x_{1}}^{(\mathrm{dyn})}(x_{1})}\,e^{-\lambda_{x_{0}}(x_{0})}\,e^{-\lambda_{u_{1}}(u_{1})}\,e^{-\lambda_{\theta}^{(\mathrm{dyn})}(\theta)}.$ $\tilde{f}_{\mathrm{dyn}}(x_{1},x_{0},\theta,u_{1}):=p(x_{1}|x_{0},\theta,u_{1})\,r_{u|x}(u_{1}|x_{0})$ $r_{u|x}$ $r_{u|x}$ $-\int q_{\mathrm{pair}}(x_{0},u_{1})\log r_{u|x}(u_{1}|x_{0})\,\mathrm{d}u_{1}\,\mathrm{d}x_{0}+\int\nu_{u|x}(x_{0})\left(\int r_{u|x}(u_{1}|x_{0})\,\mathrm{d}u_{1}-1\right)\mathrm{d}x_{0}.$ $-\frac{q_{\mathrm{pair}}(x_{0},u_{1})}{r_{u|x}(u_{1}|x_{0})}+\nu_{u|x}(x_{0})=0.$ $\int r_{u|x}\,\mathrm{d}u_{1}=1$ $\nu_{u|x}(x_{0})=q_{x_{0}}(x_{0})$ $q_{x_{0}}(x_{0})=\int q_{\mathrm{pair}}(x_{0},u_{1})\,\mathrm{d}u_{1}$ $r_{u|x}^{*}(u_{1}|x_{0})=\frac{q_{\mathrm{pair}}(x_{0},u_{1})}{q_{x_{0}}(x_{0})}=q(u_{1}|x_{0}),$ $\tilde{f}_{\mathrm{obs}}=p(y_{1}|x_{1},\theta)$ $\tilde{f}_{\mathrm{dyn}}=p(x_{1}|x_{0},\theta,u_{1})\,r_{u|x}(u_{1}|x_{0})$ $\mu_{i\to a}$ $\displaystyle\mu_{\mathrm{obs}\to\theta}(\theta)$ $\displaystyle=\iint p(y_{1}|x_{1},\theta)\,\mu_{y_{1}\to\mathrm{obs}}(y_{1})\,\mu_{x_{1}\to\mathrm{obs}}(x_{1})\,\mathrm{d}y_{1}\,\mathrm{d}x_{1},$ $\displaystyle\mu_{\mathrm{obs}\to x_{1}}(x_{1})$ $\displaystyle=\iint p(y_{1}|x_{1},\theta)\,\mu_{y_{1}\to\mathrm{obs}}(y_{1})\,\mu_{\theta\to\mathrm{obs}}(\theta)\,\mathrm{d}y_{1}\,\mathrm{d}\theta,$ $\displaystyle\mu_{\mathrm{obs}\to y_{1}}(y_{1})$ $\displaystyle=\iint p(y_{1}|x_{1},\theta)\,\mu_{\theta\to\mathrm{obs}}(\theta)\,\mu_{x_{1}\to\mathrm{obs}}(x_{1})\,\mathrm{d}x_{1}\,\mathrm{d}\theta.$ $p(x_{1}|x_{0},\theta,u_{1})\,r_{u|x}(u_{1}|x_{0})$ $\displaystyle\mu_{\mathrm{dyn}\to\theta}(\theta)$ $\displaystyle=\iiint p(x_{1}|x_{0},\theta,u_{1})\,r_{u|x}(u_{1}|x_{0})\,\mu_{x_{0}\to\mathrm{dyn}}(x_{0})\,\mu_{u_{1}\to\mathrm{dyn}}(u_{1})\,\mu_{x_{1}\to\mathrm{dyn}}(x_{1})\,\mathrm{d}x_{1}\,\mathrm{d}x_{0}\,\mathrm{d}u_{1},$ $\displaystyle\mu_{\mathrm{dyn}\to x_{1}}(x_{1})$ $\displaystyle=\iiint p(x_{1}|x_{0},\theta,u_{1})\,r_{u|x}(u_{1}|x_{0})\,\mu_{x_{0}\to\mathrm{dyn}}(x_{0})\,\mu_{u_{1}\to\mathrm{dyn}}(u_{1})\,\mu_{\theta\to\mathrm{dyn}}(\theta)\,\mathrm{d}x_{0}\,\mathrm{d}u_{1}\,\mathrm{d}\theta,$ $\displaystyle\mu_{\mathrm{dyn}\to x_{0}}(x_{0})$ $\displaystyle=\iiint p(x_{1}|x_{0},\theta,u_{1})\,r_{u|x}(u_{1}|x_{0})\,\mu_{x_{1}\to\mathrm{dyn}}(x_{1})\,\mu_{u_{1}\to\mathrm{dyn}}(u_{1})\,\mu_{\theta\to\mathrm{dyn}}(\theta)\,\mathrm{d}x_{1}\,\mathrm{d}u_{1}\,\mathrm{d}\theta,$ $\displaystyle\mu_{\mathrm{dyn}\to u_{1}}(u_{1})$ $\displaystyle=\iiint p(x_{1}|x_{0},\theta,u_{1})\,r_{u|x}(u_{1}|x_{0})\,\mu_{x_{0}\to\mathrm{dyn}}(x_{0})\,\mu_{\theta\to\mathrm{dyn}}(\theta)\,\mu_{x_{1}\to\mathrm{dyn}}(x_{1})\,\mathrm{d}x_{1}\,\mathrm{d}x_{0}\,\mathrm{d}\theta.$ $\displaystyle q_{\mathrm{obs}}^{*}(y_{1},x_{1},\theta)$ $\displaystyle\propto p(y_{1}|x_{1},\theta)\,\mu_{y_{1}\to\mathrm{obs}}(y_{1})\,\mu_{x_{1}\to\mathrm{obs}}(x_{1})\,\mu_{\theta\to\mathrm{obs}}(\theta),$ $\displaystyle q_{\mathrm{dyn}}^{*}(x_{1},x_{0},\theta,u_{1})$ $\displaystyle\propto p(x_{1}|x_{0},\theta,u_{1})\,r_{u|x}(u_{1}|x_{0})\,\mu_{x_{1}\to\mathrm{dyn}}(x_{1})\,\mu_{x_{0}\to\mathrm{dyn}}(x_{0})\,\mu_{\theta\to\mathrm{dyn}}(\theta)\,\mu_{u_{1}\to\mathrm{dyn}}(u_{1}).$ $r_{u|x}^{*}(u_{1}|x_{0})=\frac{q_{\mathrm{pair}}(x_{0},u_{1})}{q_{x_{0}}(x_{0})}=q(u_{1}|x_{0}),\quad\text{where }q_{\mathrm{pair}}(x_{0},u_{1})=\iint q_{\mathrm{dyn}}^{*}\,\mathrm{d}x_{1}\,\mathrm{d}\theta.$ $\displaystyle q_{\theta}^{*}(\theta)$ $\displaystyle\propto p(\theta)\,\mu_{\mathrm{obs}\to\theta}(\theta)\,\mu_{\mathrm{dyn}\to\theta}(\theta),$ $\displaystyle q_{x_{1}}^{*}(x_{1})$ $\displaystyle\propto\hat{p}_{x}(x_{1})\,\mu_{\mathrm{obs}\to x_{1}}(x_{1})\,\mu_{\mathrm{dyn}\to x_{1}}(x_{1}),$ $\displaystyle q_{x_{0}}^{*}(x_{0})$ $\displaystyle\propto p(x_{0})\,\mu_{\mathrm{dyn}\to x_{0}}(x_{0}),$ $\displaystyle q_{u_{1}}^{*}(u_{1})$ $\displaystyle\propto p(u_{1})\,\mu_{\mathrm{dyn}\to u_{1}}(u_{1}),$ $\displaystyle q_{y_{1}}^{*}(y_{1})$ $\displaystyle\propto\hat{p}_{y}(y_{1})\,\mu_{\mathrm{obs}\to y_{1}}(y_{1}).$ $T$ $r_{u|x,t}(u_{t}|x_{t-1})$ $t=1,\ldots,T$ $+\sum_{t}\mathbb{H}\left[q(u_{t}|x_{t-1})\right]$ $T{=}1$ $f_{\mathrm{obs}_{t}}$ $\displaystyle\mu_{\mathrm{obs}_{t}\to\theta}(\theta)$ $\displaystyle=\iint p(y_{t}|x_{t},\theta)\,\mu_{y_{t}\to\mathrm{obs}_{t}}(y_{t})\,\mu_{x_{t}\to\mathrm{obs}_{t}}(x_{t})\,\mathrm{d}y_{t}\,\mathrm{d}x_{t},$ $\displaystyle\mu_{\mathrm{obs}_{t}\to x_{t}}(x_{t})$ $\displaystyle=\iint p(y_{t}|x_{t},\theta)\,\mu_{y_{t}\to\mathrm{obs}_{t}}(y_{t})\,\mu_{\theta\to\mathrm{obs}_{t}}(\theta)\,\mathrm{d}y_{t}\,\mathrm{d}\theta,$ $\displaystyle\mu_{\mathrm{obs}_{t}\to y_{t}}(y_{t})$ $\displaystyle=\iint p(y_{t}|x_{t},\theta)\,\mu_{\theta\to\mathrm{obs}_{t}}(\theta)\,\mu_{x_{t}\to\mathrm{obs}_{t}}(x_{t})\,\mathrm{d}x_{t}\,\mathrm{d}\theta.$ $f_{\mathrm{dyn}_{t}}$ $p(x_{t}|x_{t-1},\theta,u_{t})\,r_{u|x,t}(u_{t}|x_{t-1})$ $\displaystyle\mu_{\mathrm{dyn}_{t}\to\theta}(\theta)$ $\displaystyle=\iiint p(x_{t}|x_{t-1},\theta,u_{t})\,r_{u|x,t}(u_{t}|x_{t-1})\,\mu_{x_{t-1}\to\mathrm{dyn}_{t}}(x_{t-1})$ $\displaystyle\qquad\times\mu_{u_{t}\to\mathrm{dyn}_{t}}(u_{t})\,\mu_{x_{t}\to\mathrm{dyn}_{t}}(x_{t})\,\mathrm{d}x_{t}\,\mathrm{d}x_{t-1}\,\mathrm{d}u_{t},$ $\displaystyle\mu_{\mathrm{dyn}_{t}\to x_{t}}(x_{t})$ $\displaystyle=\iiint p(x_{t}|x_{t-1},\theta,u_{t})\,r_{u|x,t}(u_{t}|x_{t-1})\,\mu_{x_{t-1}\to\mathrm{dyn}_{t}}(x_{t-1})\,\mu_{u_{t}\to\mathrm{dyn}_{t}}(u_{t})\,\mu_{\theta\to\mathrm{dyn}_{t}}(\theta)\,\mathrm{d}x_{t-1}\,\mathrm{d}u_{t}\,\mathrm{d}\theta,$ $\displaystyle\mu_{\mathrm{dyn}_{t}\to x_{t-1}}(x_{t-1})$ $\displaystyle=\iiint p(x_{t}|x_{t-1},\theta,u_{t})\,r_{u|x,t}(u_{t}|x_{t-1})\,\mu_{x_{t}\to\mathrm{dyn}_{t}}(x_{t})\,\mu_{u_{t}\to\mathrm{dyn}_{t}}(u_{t})\,\mu_{\theta\to\mathrm{dyn}_{t}}(\theta)\,\mathrm{d}x_{t}\,\mathrm{d}u_{t}\,\mathrm{d}\theta,$ $\displaystyle\mu_{\mathrm{dyn}_{t}\to u_{t}}(u_{t})$ $\displaystyle=\iiint p(x_{t}|x_{t-1},\theta,u_{t})\,r_{u|x,t}(u_{t}|x_{t-1})\,\mu_{x_{t-1}\to\mathrm{dyn}_{t}}(x_{t-1})\,\mu_{\theta\to\mathrm{dyn}_{t}}(\theta)\,\mu_{x_{t}\to\mathrm{dyn}_{t}}(x_{t})\,\mathrm{d}x_{t}\,\mathrm{d}x_{t-1}\,\mathrm{d}\theta.$ $\displaystyle q_{\mathrm{obs},t}^{*}(y_{t},x_{t},\theta)$ $\displaystyle\propto p(y_{t}|x_{t},\theta)\,\mu_{y_{t}\to\mathrm{obs}_{t}}(y_{t})\,\mu_{x_{t}\to\mathrm{obs}_{t}}(x_{t})\,\mu_{\theta\to\mathrm{obs}_{t}}(\theta),$ $\displaystyle q_{\mathrm{dyn},t}^{*}(x_{t},x_{t-1},\theta,u_{t})$ $\displaystyle\propto p(x_{t}|x_{t-1},\theta,u_{t})\,r_{u|x,t}(u_{t}|x_{t-1})\,\mu_{x_{t}\to\mathrm{dyn}_{t}}(x_{t})\,\mu_{x_{t-1}\to\mathrm{dyn}_{t}}(x_{t-1})\,\mu_{\theta\to\mathrm{dyn}_{t}}(\theta)\,\mu_{u_{t}\to\mathrm{dyn}_{t}}(u_{t}).$ $r_{u|x,t}^{*}(u_{t}|x_{t-1})=q_{t}(u_{t}|x_{t-1}),\quad\text{where }q_{t}(u_{t}|x_{t-1})=\frac{q_{\mathrm{pair},t}(x_{t-1},u_{t})}{q_{x_{t-1}}(x_{t-1})}\,,$ $q_{\mathrm{pair},t}(x_{t-1},u_{t})=\iint q_{\mathrm{dyn},t}^{*}\,\mathrm{d}x_{t}\,\mathrm{d}\theta$ $\displaystyle q_{x_{t}}^{*}(x_{t})$ $\displaystyle\propto\hat{p}_{x}(x_{t})\,\mu_{\mathrm{obs}_{t}\to x_{t}}(x_{t})\,\mu_{\mathrm{dyn}_{t}\to x_{t}}(x_{t})\,\mu_{\mathrm{dyn}_{t+1}\to x_{t}}(x_{t}),$ $\displaystyle q_{\theta}^{*}(\theta)$ $\displaystyle\propto p(\theta)\prod_{\tau=1}^{T}\mu_{\mathrm{obs}_{\tau}\to\theta}(\theta)\,\mu_{\mathrm{dyn}_{\tau}\to\theta}(\theta),$ $\displaystyle q_{u_{t}}^{*}(u_{t})$ $\displaystyle\propto p(u_{t})\,\mu_{\mathrm{dyn}_{t}\to u_{t}}(u_{t}),$ $\displaystyle q_{y_{t}}^{*}(y_{t})$ $\displaystyle\propto\hat{p}_{y}(y_{t})\,\mu_{\mathrm{obs}_{t}\to y_{t}}(y_{t}).$ $t=1$ $\mu_{x_{0}\to\mathrm{dyn}_{1}}(x_{0})=p(x_{0})$ $t=T$ $\mu_{\mathrm{dyn}_{T+1}\to x_{T}}$ $(q,r_{u|x})$ $r_{u|x,t}$ $t$ $r_{u|x,t}^{*}(u_{t}|x_{t-1})=q(u_{t}|x_{t-1})$ $p(x_{t}|x_{t-1},\theta,u_{t})\,q(u_{t}|x_{t-1})$ $4{\times}4$ $1-p_{\text{slip}}$ $p_{\text{slip}}/3$ $p_{\text{slip}}=0.1$ $\theta$ $15$ $2$ $0.2$ $14$ $2n_{\text{pos}}$ $0.999/0.001$ $n_{\text{pos}}$ $\text{noise}=\alpha_{\text{base}}+\alpha_{\text{range}}\cdot d/d_{\text{max}}$ $d$ $\theta$ $0.999/0.001$ $2\times n_{\text{pos}}$ $32$ $4{\times}4$ $|\mathcal{U}|=5$ $2n_{\text{pos}}$ $n_{\text{pos}}$ $\hat{p}(x_{T})$ $\theta$ $15$ $p(\theta)=1/15$ $p(x_{0})$ $1$ $c_{\text{scan}}=0.1$ $p(u_{t})=w_{u_{t}}/\sum_{u}w_{u}$ $p(\text{move})\approx 0.244$ $p(\text{SCAN})\approx 0.024$ $T=15$ $400$ $1000$ $15$ $i$ $i$ $(4,3)$ $\theta$ $4{\times}4$ $\theta$ $3$ $n_{\theta}=8$ $\alpha_{\text{pos}}=0.1$ $i$ $d$ $p(\text{correct}\mid d)=\tfrac{1}{2}\bigl(1+2^{-d/d_{1/2}}\bigr)$ $d_{1/2}=2$ $d=0$ $d=d_{1/2}$ $75\%$ $d\to\infty$ $i$ $+2$ $-3$ $+1$ $p_{\text{slip}}=0$ $n_{\text{pos}}=16$ $4{\times}4$ $|\mathcal{U}|=9$ $n_{\text{pos}}$ $3$ $\hat{p}(x_{T})$ $\tau=1$ $8$ $p(\theta)=1/8$ $1$ $c_{\text{exit}}=0.5$ $T=12$ $100$ $1000$ $25$ $i$ $i$ $1.00\;[1.00,1.00]$ $0.0$ $3.00$ $1.00\;[1.00,1.00]$ $0.0$ $3.00$ $1.00\;[1.00,1.00]$ $0.0$ $3.00$ $1.00\;[1.00,1.00]$ $0.0$ $3.00$ $4.01\;[3.90,4.12]$ $98.7$ $8.56$ $p_{\text{slip}}=0.01$ $0$ $\theta$ $25$ $4$ $p_{\text{tp}}=1-\alpha_{\text{obs}}$ $p_{\text{fp}}=0.1\,\alpha_{\text{obs}}$ $n_{\text{pos}}$ $0.999/0.001$ $\theta$ $2\times n_{\text{pos}}$ $50$ $5{\times}5$ $|\mathcal{U}|=5$ $3$ $n_{\text{pos}}$ $\hat{p}(x_{T})$ $\theta$ $25$ $p(x_{0})$ $0$ $1$ $c_{\text{scan}}=0.7$ $p(u_{t})=w_{u_{t}}/\sum_{u}w_{u}$ $p(\text{move})\approx 0.213$ $p(\text{SCAN})\approx 0.149$ $T=8$ $150$ $1000$ $16$ $i$ $i$ $16$ $41$ $12$ $2$ $47$ $15$ $10$ $-10^{12}$ $-\infty$ $10^{-30}$ $-10^{12}$ $-10^{12}$ $\lambda=1.0$ $\lambda$ $\lambda$ $1.0$ $1.0$ $1.0$ $0.9$ $0.9$ $0.9$ $0.25$ $0.25$ $0.25$ $1.0$ $1.0$ $1.0$ $0.9$ $0.9$ $0.75$ $p(\theta)$ $t=0$ $\lambda\in\{0.25,0.4,0.5,0.6,0.75,0.9\}$ $\lambda=1.0$ $5$ $1{,}000$ $10^{-4}$ $\lambda$ $80\%$ $\lambda\leq 0.4$ $\lambda\geq 0.5$ $60$ $100\%$ $100\%$ $\lambda=0.9$ $20\%$ $\lambda=0.25$ $100\%$ $100\%$ $\lambda\leq 0.75$ $80\%$ $\lambda=0.9$ $40\%$ $\lambda\geq 0.6$ $\lambda$ $5$ $1{,}000$ ${\sim}5$ $150$ $1\sigma$ $\lambda$ $\lambda=0.25$ $\lambda=0.9$ $\lambda=0.75$ $0.9$ ${\sim}320$ $150$

