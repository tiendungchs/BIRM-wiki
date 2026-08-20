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
