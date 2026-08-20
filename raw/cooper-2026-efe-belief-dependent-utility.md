---
title: "Expected Free Energy as Belief-Dependent Utility for rho-POMDPs"
source: "https://arxiv.org/abs/2607.16981"
author:
  - "[[Patrick Cooper]]"
  - "[[Alvaro Velasquez]]"
published: 2026-07-18
created: 2026-08-09
description: "EFE minimization equals solving a rho-POMDP whose belief-dependent utility is expected information gain at the derived weight w=1 nat; proven for observe-then-commit and factored-observation POMDPs; tested to |S|=65,536."
tags:
  - "clippings"
---

Expected Free Energy as Belief-Dependent Utility for 𝜌-POMDPs

arXiv is now an independent nonprofit!
Learn more

Back to arXiv

$\rho$ $\rho$ $\rho$ $\rho$ $w{=}1$ $\rho$ $w{=}1$ $\rho$

License: arXiv.org perpetual non-exclusive license

arXiv:2607.16981v1 [cs.AI] 18 Jul 2026

11institutetext: Department of Computer Science, University of Colorado Boulder,

Boulder, CO, USA

11email: {patrick.cooper,alvaro.velasquez}@colorado.edu

# Expected Free Energy as Belief-Dependent Utility for $\rho$ -POMDPs

Patrick Cooper

  
Alvaro Velasquez

###### Abstract

An agent acting under partial observability must decide when to gather information and which observations are worth their cost. Standard POMDPs value information only through its eventual effect on reward. The $\rho$ -POMDP framework instead rewards uncertainty reduction directly, through a belief-dependent utility $\rho$ , but in practice both the choice of $\rho$ and the weight placed on it are tuned by hand for every task. We show that active inference removes this tuning entirely. Minimizing Expected Free Energy (EFE) is exactly equivalent to solving a $\rho$ -POMDP whose utility is expected information gain, and the exploration weight is fixed at $w{=}1$ because the variational bound expresses pragmatic and epistemic value in the same units (nats). We prove this equivalence for observe-then-commit POMDPs and extend it to factored observation POMDPs, a broader class that covers interleaved observe-act problems such as non-destructive testing and mobile sensing, where gathering information leaves the hidden state unchanged. Experiments support the theory. Across environments ranging from the classic Tiger problem to RockSample and a new Structural Inspection benchmark with over $65{,}000$ states, the untuned weight matches or outperforms reward-only planning at the same horizon, avoids the over-exploration of bonuses tuned per task, and sits near the reward-maximizing knee of the success–reward Pareto frontier. The practical payoff is an exploration objective that works out of the box. In applications such as fault detection and medical screening, where every test has a price and every missed fault has a cost, EFE supplies a belief-dependent utility that is derived rather than tuned.

##
1 Introduction

Decision-making under partial observability requires agents to balance exploiting current knowledge against gathering information to reduce uncertainty about hidden states. In standard POMDPs, information gathering has no intrinsic value. It is useful only insofar as it leads to higher expected reward. This creates a well-known difficulty: the exploration–exploitation trade-off must be resolved either by the planning horizon or by heuristic exploration bonuses.

The $\rho$ -POMDP framework [1] addresses this by extending POMDPs with a belief-dependent utility $\rho(b)$ that allows the agent to derive value directly from properties of its belief state. This enables explicit optimization over uncertainty reduction, information gain, or other belief-state properties alongside task reward. However, the choice of $\rho$ remains largely heuristic and environment-specific.

Separately, the Active Inference (AIF) framework [12, 30] casts perception and action as approximate Bayesian inference, selecting policies that minimize Expected Free Energy (EFE). EFE naturally decomposes into a pragmatic term (goal-seeking) and an epistemic term (information-seeking). Because both terms come from a single variational objective, their relative scale is not free to choose. In the discrete-state formulation we use, the coefficient on expected information gain is fixed at $w{=}1$ when both terms are measured in nats, the natural-log unit of information (Proposition 1). The weight is a consequence of the derivation, not a hyperparameter.

We propose substituting EFE as $\rho$ in $\rho$ -POMDPs, yielding an agent whose epistemic foraging is a consequence of its objective rather than an engineered bonus.111Code and experiment data are available at https://github.com/PatrickAllenCooper/rho_aif. Our contributions are:

-
1.

Theory. A formal bridge between $\rho$ -POMDPs and active inference. We prove the equivalence for observe-then-commit POMDPs (Proposition 1), characterize when the canonical weight is near-optimal (Proposition 2), and extend the equivalence to factored observation POMDPs, interleaved settings where information gathering preserves the hidden state (Proposition 3).

-
2.

Evidence. Controlled comparisons against same-horizon planning, tuned information gain, and POMCP [39] across six observe-then-commit environments and four instances of the standard RockSample benchmark [41]. A Pareto analysis shows that $w{=}1$ Pareto-dominates same-horizon planning without per-environment search.

-
3.

Practical guidance. A characterization of when EFE-as- $\rho$ helps. The advantage appears when the agent must choose among multiple observation actions, and it grows with state space size ( $66.5\%$ vs. $2.5\%$ success on Tileworld $8{\times}8$ ) and with the number of observation actions ( $+7.82$ reward on RockSample[7,8]).

##
2 Related work

##### POMDPs and solvers.

POMDPs formalize sequential decision-making under state uncertainty [40, 22]. Exact solutions are PSPACE-complete. Point-based offline methods (PBVI [33], HSVI [41], SARSOP [23]) approximate the value function on reachable beliefs [38]. Online solvers plan from the current belief: POMCP [39] uses MCTS with UCB1 and rollout evaluation, DESPOT [45] searches a regularized sparse belief tree, and POMCPOW [42] extends POMCP with progressive widening for continuous spaces. All explore implicitly through stochastic simulations rather than explicitly valuing information gain. Section 6 and Appendix 0.T demonstrate the benefit of closed-form information valuation.

#####
$\rho$ -POMDPs.

Araya-López et al. [1] introduced $\rho$ -POMDPs, augmenting the reward with a belief-dependent utility $\rho:\Delta(S)\to\mathbb{R}$ , so the objective becomes $\max_{\pi}\mathbb{E}_{\pi}[\sum_{t}\gamma^{t}(R(s_{t},a_{t})+\rho(b_{t}))]$ . When $\rho$ is convex, the value function remains piecewise linear and convex (PWLC), preserving compatibility with standard solvers. Fehr et al. [10] extended this to Lipschitz-continuous non-convex $\rho$ , and Benchetrit et al. [3] developed $\rho$ -POMCPOW for continuous-space $\rho$ -POMDPs. Common choices for $\rho$ (entropy reduction, KL divergence from a target belief, and information gain) each encode a different notion of epistemic value, but the choice remains heuristic and environment-specific. Our contribution is to derive a principled $\rho$ from the variational bound of active inference, fixing the exploration weight without per-environment search.

##### Value of information and experimental design.

The idea that information has quantifiable decision-theoretic value predates both POMDPs and active inference. Howard [20] formalized the value of information in decision analysis, and Lindley [25] introduced expected information gain as a criterion for optimal Bayesian experimental design. In the bandit setting, information-directed sampling (IDS) [35] explicitly trades off instantaneous regret against information gain by minimizing the information ratio $\Gamma_{t}=\delta_{t}^{2}/g_{t}$ , where $\delta_{t}$ is the expected regret and $g_{t}$ is the information gain. The key structural difference from EFE is that IDS minimizes the ratio at each step (a relative weighting that adapts to the current belief), while EFE fixes the weight at $w{=}1$ (an absolute weighting derived from the variational bound). An IDS baseline adapted to the observe-then-commit structure would be informative but is beyond the scope of this work. Our observe-then-commit structure parallels sequential Bayesian experimental design, where the agent selects experiments (observations) to maximize information about an unknown state before making a terminal decision. The $\rho$ -POMDP framework with $\rho=I(b)$ operationalizes this connection. Our contribution is to show that EFE derives a canonical weight for the information gain term from first principles rather than treating it as a tunable parameter.

##### Active inference and EFE.

The Active Inference (AIF) framework [12] casts perception and action as variational inference under the free-energy principle. Parr et al. [31] provide a comprehensive textbook treatment. Friston et al. [13] formalized the decomposition of policy value into extrinsic (goal-seeking) and epistemic (information-seeking) components, showing that curiosity-driven exploration arises automatically from expected free energy minimization. Da Costa et al. [6] synthesized discrete-state AIF from first principles, showing that the posterior over policies takes the form $Q(\pi)\propto\exp(-\mathcal{G}(\pi))$ where $\mathcal{G}$ is the Expected Free Energy. Parr and Friston [30] showed that EFE decomposes into pragmatic value (divergence from preferred observations) and epistemic value (expected information gain), with both arising from a single variational bound, requiring no tunable exploration weight. Despite different constructions, EFE and Generalised Free Energy produce identical policy posteriors. The mathematical foundations of EFE have been critically examined: Millidge et al. [28] showed that naively extending the variational free energy into the future does not yield exploratory behavior, proposing the Free Energy of the Expected Future (FEEF) as an alternative with clearer mathematical grounding. Champion et al. [5] addressed the “unification problem” by formalizing how multiple EFE formulations relate to a single root definition under different assumptions about prior preferences. de Vries et al. [8] recast EFE-based planning as entropy-corrected variational inference with message-passing schemes, providing an alternative derivation that connects EFE to variational message passing.

##### Sophisticated inference.

Standard AIF evaluates policies myopically. Friston et al. [14] introduced sophisticated inference, a recursive extension implementing deep tree search over belief trajectories rather than states. Sophistication (maintaining beliefs about future beliefs) enables counterfactual reasoning about the downstream epistemic consequences of actions. Da Costa et al. [7] proved that this recursive scheme recovers Bellman-optimal policies for any finite horizon, whereas standard AIF achieves optimality only for single-step planning. Our recursive EFE agent (Equation 3) is derived from this framework, adapted to the $\rho$ -POMDP commit-action structure. The recursive counterfactual reasoning over future beliefs is preserved. What changes is that our observe-then-commit setting does not involve state transitions between time steps, simplifying the belief-trajectory computation.

##### Scaling active inference.

Discrete-state AIF with full policy enumeration is limited to small state–action spaces. Several lines of work address scaling. Fountas et al. [11] combined deep generative models with Monte Carlo tree search for EFE-optimal planning in continuous state spaces. Tschantz et al. [44] developed an RL-compatible objective (the free energy of the expected future) that inherits AIF’s exploration–exploitation balance while scaling to standard RL benchmarks. Maisto et al. [26] combined active inference with Monte-Carlo tree search for large POMDPs, achieving state-of-the-art on RockSample [41]. Our MCTS-EFE variant (Section 6) follows this direction, using EFE as a leaf heuristic within MCTS to extend planning horizons beyond exact tree search.

##### Exploration, control as inference, and intrinsic motivation.

The control-as-inference perspective [43, 24] casts reward maximization as variational inference. Maximum-entropy RL [17] and stochastic optimal control [34] are algorithmic instances. Millidge et al. [27] proved formal equivalence between AIF and control-as-inference. Sajid et al. [36] showed that intrinsic motivation behaviors arise under EFE. Intrinsic motivation methods, including curiosity [37, 32], typologies of intrinsic signals [29], Bayesian surprise [21], count-based exploration [2], VIME [19], and random network distillation [4], all require tunable bonus weights. Bayes-Adaptive MDPs [9, 16] and Bayesian RL more broadly [15] address model uncertainty (unknown dynamics), distinct from our focus on state uncertainty under a known model. Our $\rho$ -POMDP formalism makes the connection between EFE and these lines of work precise, inheriting formal properties (convexity, Lipschitz continuity) while fixing the exploration weight from first principles.

##
3 Methodology

###
3.1 The $\rho$ -POMDP framework

We restrict attention to observe-then-commit $\rho$ -POMDPs, in which the action set $\mathcal{A}$ partitions into observation actions $\mathcal{A}_{\text{obs}}$ (which update the belief at known cost but do not change the hidden state) and terminal commit actions $\mathcal{A}_{\text{com}}$ (which end the episode with state-dependent reward). An episode consists of a variable-length sequence of observation actions followed by a single commit action. The hidden state is fixed throughout.

A $\rho$ -POMDP extends the standard POMDP with a belief-dependent utility $\rho:\Delta(S)\rightarrow\mathbb{R}$ . The agent’s objective becomes:

|
| $\pi^{*}=\arg\max_{\pi}\mathbb{E}_{\pi}\left[\sum_{t=0}^{H}\gamma^{t}\left(R(s_{t},a_{t})+\rho(b_{t})\right)\right]$
|
| (1)

When $\rho=0$ , we recover the standard POMDP. When $\rho$ encodes information gain, the agent is explicitly rewarded for reducing uncertainty.

###
3.2 Expected Free Energy as $\rho$

In the standard AIF formulation, the EFE for a policy $\pi$ at future time $\tau$ is:

|
| $\mathcal{G}(\pi)=\underbrace{-\mathbb{E}_{Q(o_{\tau}|\pi)}[\ln P(o_{\tau}|C)]}_{\text{Pragmatic value}}-\underbrace{\mathbb{E}_{Q(o_{\tau}|\pi)}\left[D_{\mathrm{KL}}\left[Q(s_{\tau}|o_{\tau},\pi)\,\|\,Q(s_{\tau}|\pi)\right]\right]}_{\text{Epistemic value}}$
|
| (2)

where $P(o_{\tau}|C)$ encodes preferred outcomes and $D_{\mathrm{KL}}$ measures expected information gain. In our observe-then-commit setting, the pragmatic and epistemic terms take concrete forms. For commit actions, the pragmatic term reduces to expected reward under the current belief: $\mathcal{G}(\text{commit}_{i})=-\mathbb{E}_{b}[R_{i}]$ . We use the reward matrix directly rather than encoding rewards through preferred outcome distributions $P(o|C)$ , avoiding the preference-calibration issue flagged as a source of hidden tuning in prior AIF work. For observation actions, the pragmatic term is the known observation cost $c_{k}$ , and the epistemic term is the expected information gain $I_{k}(b)=H(b)-\mathbb{E}_{o}[H(b^{\prime}_{o}\mid\text{obs}_{k})]$ .

Following the sophisticated inference scheme of Friston et al. [14], the EFE agent evaluates actions via a recursive tree search over belief states:

|
| $\mathcal{G}(\text{observe}_{k})=c_{k}-I_{k}(b)+\mathbb{E}_{o}\!\left[\min_{a}\mathcal{G}(a\mid b^{\prime}_{o})\right]$
|
| (3)

The agent selects $\arg\min_{a}\mathcal{G}(a)$ . Standard AIF introduces a precision parameter $\beta$ via a softmax policy $Q(\pi)\propto\exp(-\beta\mathcal{G}(\pi))$ . Our deterministic $\arg\min$ corresponds to $\beta\to\infty$ , which eliminates this tunable knob. Equation 3 contains no separate exploration weight, and this is not a modeling shortcut. When EFE is written in nats, expected information gain enters on the same footing as the KL terms that define the variational objective. This shared scale is why the $\rho$ -POMDP reduction carries $w{=}1$ exactly (Proposition 1).

###
3.3 Formal equivalence with $\rho$ -POMDPs

We generalize the standard $\rho$ -POMDP formulation to action-dependent belief utilities $\rho(b,a)$ , where the augmented reward becomes $R(s,a)+\rho(b,a)$ . This is equivalent to a standard $\rho(b)$ formulation on an augmented belief-action space but avoids notational overhead. The structural results of Araya-López et al. [1] carry over when $\rho(\cdot,a)$ satisfies the relevant conditions for each fixed $a$ .

Define $V(a,b,d)\triangleq-\mathcal{G}(a,b,d)$ . Then Equation 3 becomes:

|
| $\displaystyle V(\text{observe}_{k},b,d)$
| $\displaystyle=-c_{k}+I_{k}(b)+\mathbb{E}_{o}\!\left[\max_{a}V(a,b^{\prime}_{o},d{+}1)\right]$
|
| (4)

|
| $\displaystyle V(\text{commit}_{i},b,d)$
| $\displaystyle=\mathbb{E}_{b}[R_{i}]$
|
| (5)

This is exactly the Bellman recursion for a $\rho$ -POMDP (Equation 1) with action-dependent belief utility:

###### Proposition 1

Define $\rho_{\mathrm{EFE}}(b,a)$ as:

|
| $\rho_{\mathrm{EFE}}(b,a)=\begin{cases}I_{a}(b)&\text{if }a\text{ is an observation action}\\
0&\text{if }a\text{ is a commit action}\end{cases}$
|

where $I_{a}(b)=H(b)-\mathbb{E}_{o|a}[H(b^{\prime}_{o})]$ is the expected information gain from observation action $a$ at belief $b$ . Then for undiscounted finite horizon ( $\gamma{=}1$ ), minimizing recursive EFE (Eq. 3) over horizon $H$ produces the same policy as solving the $\rho$ -POMDP Bellman equation $V^{*}(b)=\max_{a}\{R(b,a)+\rho_{\mathrm{EFE}}(b,a)+\mathbb{E}_{o}[V^{*}(b^{\prime}_{o})]\}$ over the same horizon.

######
Proof(Proof sketch)

The negation $V=-\mathcal{G}$ converts $\arg\min\mathcal{G}$ to $\arg\max V$ . Substituting into Equation 3: for observation actions, $V=-c_{k}+I_{k}(b)+\mathbb{E}_{o}[\max_{a^{\prime}}V(a^{\prime},b^{\prime}_{o})]$ , which matches the $\rho$ -POMDP Bellman backup with $R(b,\text{obs}_{k})=-c_{k}$ and $\rho=I_{k}(b)$ . For commit actions, $V=\mathbb{E}_{b}[R_{i}]$ with $\rho=0$ , matching a terminal $\rho$ -POMDP action. The recursive structure is identical, so the policies agree at every belief node.

Proposition 1 makes precise what EFE-as- $\rho$ means: the epistemic term of EFE functions as an action-dependent belief utility. Crucially, this is equivalent to Planning+IG with $w{=}1$ (in nats). EFE does not eliminate the weight. It derives a canonical weight from the variational bound, fixing $w{=}1$ without per-environment search. Whether this canonical choice is near-optimal is an empirical question we address in Section 5.2. The following result characterizes the conditions under which $w{=}1$ is near-optimal for expected reward.

###### Proposition 2

Consider a two-state observe-then-commit $\rho$ -POMDP with uniform prior $b(s_{0}){=}b(s_{1}){=}\tfrac{1}{2}$ , a single observation action (accuracy $p>\tfrac{1}{2}$ , cost $c>0$ ), and two commit actions (correct reward $R^{+}$ , incorrect penalty $R^{-}<0$ with $|R^{-}|>R^{+}$ ). Define the reward asymmetry ratio $\alpha=|R^{-}|/R^{+}$ and the informativeness ratio $\eta=I_{\max}/c$ where $I_{\max}=\ln 2-H_{\text{post}}(p)$ is the maximum expected information gain in nats. At $H{=}1$ , the minimum weight $w^{*}_{\mathrm{thresh}}$ at which observing yields higher expected reward than committing immediately is:

|
| $w^{*}_{\mathrm{thresh}}=\frac{c\;-\;\left(p-\tfrac{1}{2}\right)(R^{+}-R^{-})}{\,I_{\max}\,}=\frac{c\;-\;\left(p-\tfrac{1}{2}\right)(1+\alpha)\,R^{+}}{\,I_{\max}\,}$
|

For any $w>w^{*}_{\mathrm{thresh}}$ the agent observes before committing, yielding identical (and higher) expected reward. The threshold $w^{*}_{\mathrm{thresh}}$ is negative, making $w{=}1$ trivially sufficient, whenever $\alpha>c/[(p-\tfrac{1}{2})\,R^{+}]-1$ . In particular, $w^{*}_{\mathrm{thresh}}\to-\infty$ as $\alpha\to\infty$ for any fixed $p>\tfrac{1}{2}$ and $c>0$ : high reward asymmetry makes observation so valuable that any positive weight suffices.

######
Proof(Proof sketch)

At $H{=}1$ , the agent observes once and commits. A Planning+IG agent with weight $w$ observes iff $-c+w\cdot I(b)+\max_{i}\mathbb{E}_{b^{\prime}_{o}}[R_{i}]>\max_{i}\mathbb{E}_{b}[R_{i}]$ , where the left side is the observe-then-commit value and the right side is the immediate commit value. For the uniform prior, the immediate commit value is $(R^{+}+R^{-})/2$ . After one observation, the posterior concentrates: with probability $p$ the agent is correct, yielding expected commit value $p\cdot R^{+}+(1-p)\cdot R^{-}$ . The net gain from observing is $(p-\frac{1}{2})(R^{+}-R^{-})-c+w\cdot I_{\max}$ . Setting this to zero gives $w^{*}_{\mathrm{thresh}}=[c-(p-\frac{1}{2})(R^{+}-R^{-})]/I_{\max}$ . Substituting $R^{-}=-\alpha R^{+}$ yields the second form. When $\alpha\gg 1$ , the marginal reward improvement $(p-\frac{1}{2})(1+\alpha)R^{+}$ dominates the cost $c$ , making $w^{*}_{\mathrm{thresh}}$ negative, so the agent should observe at any $w\geq 0$ , including $w{=}1$ .

Table 1 validates Proposition 2 across our environments, computing $\alpha$ , $\eta$ , the threshold $w^{*}_{\text{thresh}}$ , and comparing against the observed reward-maximizing weight from the Pareto sweep (Section 5.2).

Table 1: Reward asymmetry ( $\alpha$ ), informativeness ( $\eta$ ), observation threshold $w^{*}_{\text{thresh}}$ from Proposition 2, and observed reward-maximizing weight from the Pareto sweep. When $w^{*}_{\text{thresh}}<0$ , any positive weight (including $w{=}1$ ) induces observation.

| Environment
| $\alpha$
| $\eta$
| $w^{*}_{\text{thresh}}$
|
$w{=}1$ sufficient?

|
$w^{*}_{\text{ret}}$ (observed)

| Testbed
| $1.0$
| $7.5$
| $+0.60$
| Yes, but over-explores
| $0.5$

| Tiger
| $10.0$
| $0.6$
| $-5.04$
|
Yes ( $\alpha\gg 1$ )

| $1.0$

| Diagnosis
| $5.0$
| $0.5$
| $-2.34$
|
Yes ( $\alpha\geq 5$ )

| $0.5$

| Bandit
| $1.1$
| $1.2$
| $-0.12$
| Yes (marginal)
| $1.0$

| Tileworld
| $5.0$
| $0.5$
| $-2.34$
|
Yes ( $\alpha\geq 5$ )

| $0.5$

The proposition is stated for $H{=}1$ and two states. The multi-step case is harder to analyze because the observation threshold shifts with belief, but the qualitative prediction holds: environments where $\alpha\geq 5$ (Tiger, Diagnosis, Tileworld) have $w^{*}_{\text{thresh}}\ll 0$ , meaning $w{=}1$ is far above the threshold and near-optimal. The low-asymmetry Testbed ( $\alpha{=}1$ ) has $w^{*}_{\text{thresh}}>0$ but below 1, so $w{=}1$ still induces observation but assigns more weight to information than is instrumentally optimal, consistent with our finding that EFE over-explores there (Appendix 0.C). On the Bandit ( $\alpha{=}1.1$ ), $w^{*}_{\text{thresh}}$ is slightly negative at $H{=}1$ . At $H{>}1$ , multi-step planning amplifies the value of each observation, bringing the effective reward-maximizing weight toward 1.

##### Extension to discounting.

With $\gamma<1$ , the recursive EFE becomes $\mathcal{G}(\text{obs}_{k})=c_{k}-I_{k}(b)+\gamma\,\mathbb{E}_{o}[\min_{a}\mathcal{G}(a,b^{\prime}_{o})]$ , giving $V(\text{obs}_{k})=-c_{k}+I_{k}(b)+\gamma\,\mathbb{E}_{o}[\max_{a}V(a,b^{\prime}_{o})]$ . The information gain term $I_{k}(b)$ appears undiscounted at the current step, while future values are discounted. This preserves the $\rho$ -POMDP equivalence with $\rho(b,a)=I_{a}(b)$ , but the effective ratio of epistemic to pragmatic weight increases at early steps relative to late steps. In the undiscounted case ( $\gamma{=}1$ ), both terms are weighted equally at every depth. With $\gamma<1$ , the agent places relatively more value on immediate information gain compared to future reward, producing slightly more exploratory behavior at early steps. Our experiments (Appendix 0.Q) confirm that performance is robust across $\gamma\in\{0.9,0.95,0.99,1.0\}$ .

##### Extension to factored observation POMDPs.

Proposition 1 assumes the observe-then-commit structure. We now extend the equivalence to a broader class that includes interleaved observe-act POMDPs.

######
Definition 1(Factored observation POMDP)

A POMDP is a factored observation POMDP if its state decomposes as $s=(s_{\mathrm{vis}},s_{\mathrm{hid}})$ where $s_{\mathrm{vis}}$ is fully observable and $s_{\mathrm{hid}}$ is hidden, and the action set partitions into: (i) observation actions $\mathcal{A}_{\mathrm{obs}}$ that produce observations about $s_{\mathrm{hid}}$ without changing $s_{\mathrm{hid}}$ (though they may change $s_{\mathrm{vis}}$ ), (ii) navigation actions $\mathcal{A}_{\mathrm{nav}}$ that change $s_{\mathrm{vis}}$ deterministically without changing $s_{\mathrm{hid}}$ and produce no informative observation, and (iii) exploitation actions $\mathcal{A}_{\mathrm{exp}}$ that yield reward dependent on $s_{\mathrm{hid}}$ .

Observe-then-commit POMDPs are the special case where $\mathcal{A}_{\mathrm{nav}}=\emptyset$ and $s_{\mathrm{vis}}$ is trivial. RockSample [41] is an instance: $s_{\mathrm{vis}}$ is the agent’s grid position (fully observable), $s_{\mathrm{hid}}$ is the vector of rock qualities (hidden, fixed), check actions are observation actions, moves are navigation actions, and sample/exit are exploitation actions.

###### Proposition 3

In a factored observation POMDP (Definition 1), let $b$ denote the belief over $s_{\mathrm{hid}}$ . For any action $a$ that preserves $s_{\mathrm{hid}}$ (i.e., $a\in\mathcal{A}_{\mathrm{obs}}\cup\mathcal{A}_{\mathrm{nav}}$ ), the transition–observation coupling term vanishes: $\Delta_{T}(b,a)=0$ , and $\rho_{\mathrm{EFE}}(b,a)=I_{a}(b)$ for observation actions, $\rho_{\mathrm{EFE}}(b,a)=0$ for navigation actions.

######
Proof(Proof sketch)

When action $a$ preserves $s_{\mathrm{hid}}$ , the transition on the hidden component is $T_{\mathrm{hid}}(s^{\prime}_{\mathrm{hid}}|s_{\mathrm{hid}},a)=\delta(s^{\prime}_{\mathrm{hid}}=s_{\mathrm{hid}})$ . The belief update over $s_{\mathrm{hid}}$ is then $b^{\prime}(s_{\mathrm{hid}})\propto P(o|s_{\mathrm{hid}},s^{\prime}_{\mathrm{vis}},a)\,b(s_{\mathrm{hid}})$ , depending only on the observation likelihood, identical to the observe-then-commit case. The posterior that would incorporate transitions, $b^{\prime}_{o,T}$ , coincides with the observation-only posterior $b^{\prime}_{o}$ , so $D_{\mathrm{KL}}[b^{\prime}_{o,T}\|b^{\prime}_{o}]=0$ . For observation actions, EFE reduces to cost minus information gain plus expected continuation, matching the $\rho$ -POMDP Bellman equation with $\rho=I_{a}(b)$ . For navigation actions, the observation is uninformative ( $I_{a}(b)=0$ ), giving $\rho=0$ .

Proposition 3 extends the formal bridge from observe-then-commit to any POMDP where the hidden state is preserved by information-gathering and navigation actions. The agent interleaves observation, navigation, and exploitation. At each decision point, the EFE-as- $\rho$ equivalence holds for the observation and navigation subtree. This covers RockSample, mobile sensor placement, and sequential testing with spatial access costs, where the agent must navigate to observation locations before gathering information. Section 5.4 validates this extension empirically across four RockSample instances.

The factored observation structure is common in practice whenever the quantity being measured is static or slow-changing relative to the decision horizon (Table 2). The key requirement, that $T_{\mathrm{hid}}(s^{\prime}_{\mathrm{hid}}|s_{\mathrm{hid}},a)=\delta(s^{\prime}_{\mathrm{hid}}=s_{\mathrm{hid}})$ for observation and navigation actions, breaks when information-gathering itself alters the hidden state. In such settings, the coupling term $\Delta_{T}\neq 0$ and the canonical-weight equivalence does not hold. We discuss this further in the limitations paragraph of Section 6.

Table 2: Taxonomy of real-world POMDPs by factored observation structure. Factored settings preserve the hidden state under observation and navigation actions, while non-factored settings do not.

|

Factored ( $\Delta_{T}{=}0$ )

|

Non-factored ( $\Delta_{T}{\neq}0$ )

|

Non-destructive testing

|

Destructive testing (drilling)

|

Medical imaging (CT, MRI)

|

Biopsy / tissue sampling

|

Structural inspection

|

Active interventions

|

Environmental monitoring

|

Predator–prey (target moves)

|

Security screening

|

Chemical testing (consumes sample)

|

Mineral exploration

|

Quantum measurement

|

Mobile sensor networks

|

Adversarial surveillance

###
3.4 Agents

We compare six agents (Table 3), all sharing the same belief-update machinery and differing only in objective function and planning depth. The Planning and Planning+IG baselines use the same recursive tree search as the EFE agent, isolating the effect of the $\rho$ function from planning depth.

Table 3: Agent specifications. All use exact Bayesian belief updates over a known generative model.

| Agent
|
$\rho$ function

| Horizon
| Controls for

| Myopic
| $\rho=0$
| $H{=}1$
| Weakest baseline

| Planning
| $\rho=0$
| $H>1$
| Planning depth

| Info Gain
| $w\cdot I(b)$
| $H{=}1$
| Epistemic bonus (myopic)

| Planning+IG
| $w\cdot I(b)$
| $H>1$
| IG + planning depth

| EFE
|
$I_{a}(b)$ via EFE

| $H>1$
|
Joint objective (Prop. 1)

| Epistemic-only
|
$I_{a}(b)$ only

| $H>1$
| Ablation: no pragmatic term

Planning+IG is the critical baseline: it uses the same tree search as the EFE agent with an additive IG bonus at the same horizon. By Proposition 1, the EFE agent is exactly Planning+IG with $w{=}1$ , so any advantage is attributable to the weight choice rather than a different mechanism. The Epistemic-only agent sets $\mathcal{G}(\text{commit})=0$ , removing reward awareness. It commits at chance on all environments, which confirms that the pragmatic term is essential. EFE computation is validated against pymdp [18] (Appendix 0.K).

For Info Gain and Planning+IG, $w$ is tuned per environment via grid search over $\{0.1,0.5,1,2,5,10,20,50,100\}$ on 200 tuning episodes. The Pareto analysis (Section 5.2) sweeps the full weight space.

##
4 Experiments

All environments are implemented as OpenAI Gymnasium environments following the observe-then-commit structure of Section 3. Main results use 1,000 episodes per seed across 5 random seeds ( $\{42,123,456,789,1024\}$ ) for a total of 5,000 episodes. Results report the mean across all episodes. Statistical comparisons use $t$ -tests with Holm–Bonferroni correction, with bootstrap CIs in Appendix 0.O. Comparison against POMCP (including compute-matched analysis with wall-clock timing at budgets 500–5,000 simulations) is in Appendix 0.T. Full specifications are in Appendix 0.H.

##### Tiger

[22]. Two states, one observation action (listen, accuracy 0.85), two commit actions. Rewards: correct $+10$ , incorrect $-100$ , listen cost $-1$ .

##### Sequential diagnosis.

$N{=}4$ conditions, $K{=}2$ binary tests (accuracy 0.80), $N$ diagnose actions. Correct $+10$ , incorrect $-50$ , test cost $-1$ . The agent must choose which test to run.

##### Structured bandit.

$K{=}4$ arms, $K$ inspect actions (accuracy 0.80, cost $-0.5$ ), $K$ pull actions. Best arm $+10$ , others $+1$ . The agent must choose which arm to inspect.

##### Tileworld.

An $N{\times}N$ grid ( $N{=}6$ , $|S|{=}36$ ) with a hidden target tile. $K{=}6$ scan actions partition the grid via bit-level splits of row/column indices, each returning a noisy binary signal (accuracy $0.80$ , cost $-1$ ). $N^{2}$ commit actions collect at a specific cell (correct $+10$ , incorrect $-50$ ). A spatial generalization of diagnosis that produces visually interpretable belief evolution (Figure 2).

##### RockSample

[41]. An $N{\times}N$ grid with $K$ rocks at known positions, each with hidden binary quality. Move actions change the agent’s position. Check actions produce distance-dependent noisy observations of rock quality. Sampling collects the rock at the current position (good $+10$ , bad $-10$ ), and exiting gives $+10$ . All actions cost $-0.5$ . We evaluate RS[5,3], RS[7,4], RS[7,8], and RS[11,11]. Unlike the above environments, RockSample has interleaved observe-act dynamics with state transitions, the setting addressed by Proposition 3.

##### Structural inspection.

$N$ components at known spatial locations on a grid, each with a hidden binary state (nominal/faulty, prior $p_{\text{fault}}{=}0.3$ ). There are $K{=}2$ non-destructive test types: visual (accuracy $0.70$ , cost $-0.5$ ) and detailed (accuracy $0.90$ , cost $-2$ ). The agent navigates between components, runs tests, and declares a diagnosis for each. Correct nominal $+2$ , correct fault $+5$ , missed fault $-50$ , false alarm $-5$ , move cost $-0.5$ . This is a factored observation POMDP (tests do not change fault states), mapping directly to industrial inspection, medical screening, and fault detection domains. We evaluate $N{=}8$ ( $|S|{=}256$ ) and $N{=}16$ ( $|S|{=}65{,}536$ ).

Two additional environments, a two-state testbed (Appendix 0.C) and navigation (Appendix 0.I), delimit the EFE agent’s applicability on mild-penalty and small-state-space settings.

##
5 Results

###
5.1 Core environments

Table 4: Results across three core environments (5,000 total episodes: 1,000 per seed $\times$ 5 seeds). $w^{*}$ : per-environment tuned weight. Reward shown as mean $\pm$ SE. Full agent set in Appendix 0.B. Effect sizes on reward (Cohen’s $d$ ) are in Appendix 0.O.

| Environment
| Agent
| Obs.
| Success
| Reward

|

Tiger
[-1pt] $H{=}6,\;w^{*}{=}20$

| Myopic
| $1.00$
| 84.6%
| $-7.98\pm 0.56$

| Planning
| $4.28$
| 99.5%
| $+5.15\pm 0.12$

| Planning+IG
| $4.20$
| 99.4%
| $+5.19\pm 0.12$

| EFE
| $\mathbf{4.22}$
| $\mathbf{99.5\%}$
| $\mathbf{+5.23\pm 0.11}$

|

Diagnosis
[-1pt] $H{=}3,\;w^{*}{=}100$

| Myopic
| $2.00$
| 64.2%
| $-13.48\pm 0.41$

| Planning
| $5.91$
| 89.2%
| $-2.37\pm 0.26$

| Planning+IG
| $13.21$
| 99.3%
| $-3.63\pm 0.10$

| EFE
| $\mathbf{9.73}$
| $\mathbf{97.1\%}$
| $\mathbf{-1.50\pm 0.15}$

|

Bandit
[-1pt] $H{=}2,\;w^{*}{=}100$

| Myopic
| $2.04$
| 61.7%
| $+5.53\pm 0.06$

| Planning
| $3.24$
| 69.6%
| $+5.65\pm 0.06$

| Planning+IG
| $12.41$
| 99.8%
| $+3.78\pm 0.04$

| EFE
| $\mathbf{5.16}$
| $\mathbf{87.3\%}$
| $\mathbf{+6.27\pm 0.05}$

On Tiger (single observation action), all multi-step agents achieve roughly $99.5\%$ success, and EFE matches tuned alternatives without weight selection. The Epistemic-only ablation commits at chance ( $50.1\%$ on Tiger, $25.1\%$ on Bandit, $0.0\%$ on Tileworld $6{\times}6$ , Appendix 0.B). Pure information gain without reward alignment produces catastrophic exploration, so the pragmatic term is essential.

On the multi-observation-action environments, EFE Pareto-dominates Planning. It achieves substantially higher success and comparable or better reward at the same time, without any tuning. On Diagnosis, EFE outperforms same-horizon Planning in success rate ( $97.1\%$ vs. $89.2\%$ , $+7.9$ pp) while achieving substantially better reward ( $-1.50$ vs. $-2.37$ ). On Bandit, EFE achieves both higher success ( $87.3\%$ vs. $69.6\%$ , $+17.7$ pp) and the highest reward ( $+6.27$ vs. $+5.65$ ). Bootstrap 95% CIs (10,000 resamples over 5,000 episodes) confirm non-overlapping reward intervals: on Bandit, EFE $+6.38$ $[+6.29,+6.47]$ vs. Planning $+5.65$ $[+5.54,+5.76]$ , and on Diagnosis, EFE $-1.58$ $[-1.89,-1.29]$ vs. Planning $-2.72$ $[-3.26,-2.19]$ . Planning+IG at tuned weights ( $w{=}100$ ) reaches near-ceiling success ( $99.3\%$ on Diagnosis, $99.8\%$ on Bandit) but at substantial reward cost due to over-exploration: 13.21 tests on Diagnosis ( $-3.63$ reward) and 12.41 inspections on Bandit ( $+3.78$ reward). Viewed in the success–reward plane (Figure 1), the EFE agent sits at the Pareto knee on every environment, while Planning sacrifices success rate and Planning+IG sacrifices reward. The pattern is consistent: EFE’s joint pragmatic–epistemic objective knows when to stop exploring, while additive IG bonuses with tuned weights do not.

Effect sizes clarify where the differences lie. Cohen’s $d$ on reward between EFE and same-horizon Planning is negligible on Tiger, Diagnosis, and Bandit ( $|d|<0.2$ , Table 19), because both agents already achieve reasonable returns once they explore enough. The key gap is whether they explore the right observations. On success rate, where that gap appears, $d$ is substantially larger: $d\approx 0.33$ on Diagnosis and $d\approx 0.47$ on Bandit (Appendix 0.O), in the small-to-medium range. This two-axis pattern is exactly the Pareto story: EFE moves the under-served objective (success) without sacrificing reward. Medium-to-large reward $d$ values ( $d>0.7$ ) emerge against over-exploring baselines and on environments where Planning fails to explore sufficiently (Tileworld $d>2.0$ ).

###
5.2 Pareto analysis: the canonical $w{=}1$

By Proposition 1, EFE is exactly Planning+IG with $w{=}1$ . We sweep $w$ from $0.01$ to $200$ on all environments (Figure 1).

Figure 1: Pareto analysis: success rate vs. mean reward as $w$ varies from 0.01 to 200. Diamond: $w{=}1$ (canonical EFE weight). Star: EFE agent. On all environments, $w{=}1$ sits at or near the Pareto knee, the inflection point where further weight increases buy marginal accuracy at substantial reward cost.

On every environment, $w{=}1$ sits near the reward-maximizing weight $w^{*}_{\text{ret}}$ , while the success-maximizing weight $w^{*}_{\text{succ}}$ lies at $20$ – $200$ . We emphasize that $w{=}1$ is near-optimal for reward, not for success rate: agents requiring near-certain accuracy (e.g., safety-critical applications) would benefit from higher weights at the cost of reduced reward. The contribution of EFE is deriving a principled weight from the variational bound that is near-optimal for reward maximization, rather than a grid search whose optimum changes by orders of magnitude across tasks.

###
5.3 Tileworld: spatial epistemic foraging

To test whether EFE’s advantage extends to larger state spaces, we introduce a spatial generalization: the Tileworld projects the Diagnosis partition structure onto an $N{\times}N$ grid ( $|S|{=}N^{2}$ ), producing spatially interpretable belief evolution (Figure 2, with step-by-step belief strips in Appendix 0.F).

Table 5: Tileworld $6{\times}6$ (2,500 episodes: 500 per seed $\times$ 5 seeds, $H{=}2$ ). Tuned weight $w^{*}{=}100$ .

| Agent
| Scans
| Success
| Reward

| Myopic
| $0.00$
| 2.7%
| $-48.39$

|
Planning ( $H{=}2$ )

| $15.68$
| 73.7%
| $-21.47$

|
Planning+IG ( $w{=}100$ )

| $33.38$
| 98.4%
| $-24.31$

|
EFE ( $H{=}2$ )

| $\mathbf{14.81}$
| $\mathbf{72.8\%}$
| $\mathbf{-21.13}$

EFE achieves the highest reward ( $-21.13$ ), scanning 14.81 times, less than half of Planning+IG’s 33.38 scans, which erode reward despite reaching 98.4% success. The same over-exploration pattern from Diagnosis and Bandit recurs at this larger scale. Figure 2 visualizes the mechanism: EFE concentrates belief efficiently via partition-based narrowing and commits once confident, while Planning lacks scan-selection guidance and Info Gain continues scanning past the point of diminishing returns.

Figure 2: Agent comparison on the same $6{\times}6$ Tileworld episode. EFE (top) commits correctly with efficient scanning. Planning (middle) explores with less direction before committing. Info Gain (bottom) over-scans well past the point of diminishing returns. Red circle: committed cell. Green star: target.

##### Spatial scaling.

We scale the grid from $4{\times}4$ to $8{\times}8$ with all agents (Figure 3). At $8{\times}8$ ( $|S|{=}64$ ), reward-only Planning collapses to $2.5\%$ success while EFE maintains $66.5\%$ . Planning+IG at $w{=}100$ achieves $98.0\%$ success but at substantial reward cost due to extensive scanning. This reveals a nuanced picture: EFE ( $w{=}1$ ) achieves the best reward at every scale and matches or exceeds Planning in success, but tuned Planning+IG ( $w{=}100$ ) achieves higher success rates at larger grids by exploring more. The reward-maximizing weight $w^{*}_{\text{ret}}$ does not shift with $|S|$ (EFE’s reward remains highest), but its gap to the success-maximizing weight $w^{*}_{\text{succ}}$ widens. Safety-critical applications at large scale would therefore benefit from higher weights.

Figure 3: Tileworld scaling ( $H{=}2$ , 200 episodes per seed $\times$ 5 seeds) across all agents. Planning collapses at $8{\times}8$ ( $|S|{=}64$ ), while EFE maintains $66.5\%$ . Tuned Planning+IG ( $w{=}100$ ) achieves $98.0\%$ but at higher reward cost.

##### Observation structure sensitivity.

A natural concern is whether EFE’s advantage on Tileworld depends on the highly structured bit-level partition of scan actions. We test this by replacing the deterministic row/column splits with two alternative observation structures: random partitions (each scan randomly assigns cells to two groups, breaking orthogonality) and overlapping partitions (scans use random linear combinations of coordinates, producing correlated and partially redundant observations). On $6{\times}6$ Tileworld ( $H{=}2$ , 200 episodes $\times$ 5 seeds), EFE achieves the best reward under all three modes: bitwise $-20.52$ (74.2% success), random $-29.15$ (56.1%), overlapping $-46.73$ (9.8%). Planning follows the same pattern: $-21.44$ (73.7%), $-30.41$ (54.5%), $-47.61$ (8.5%). EFE’s reward advantage over Planning is consistent across modes ( $+0.9$ , $+1.3$ , $+0.9$ ), confirming that the result is not an artifact of the structured observation model. As expected, random and overlapping modes reduce absolute performance because scans provide less complementary information, but the relative ranking of agents is preserved.

###
5.4 Interleaved observe-act: RockSample

To validate Proposition 3 beyond observe-then-commit settings, we evaluate on RockSample [41], a standard POMDP benchmark with interleaved observe-act dynamics. An agent navigates an $N{\times}N$ grid containing $K$ rocks at known positions, each with hidden binary quality. Actions include move (N/S/E/W, cost $-0.5$ ), check rock $k$ (noisy observation, accuracy decays with distance), sample (collect rock at current position: good $+10$ , bad $-10$ ), and exit ( $+10$ ). All agents use depth-limited belief-space tree search over factored beliefs (independent per-rock), differing only in the information gain weight $w$ .

Table 6: RockSample results with tree-search agents (500 episodes $\times$ 5 seeds for RS[5,3]–[7,8] and 50 $\times$ 2 seeds for RS[11,11]). EFE ( $w{=}1$ ) achieves the highest or near-highest reward on all instances while avoiding bad rocks, confirming Proposition 3. Steps and Checks are omitted because tree-search agents evaluate all actions at each node. Per-step attribution is in Appendix 0.S.

| Instance
| Agent
| Steps
| Checks
| Good
| Bad
| Reward

| RS[5,3]
| Greedy
| –
| –
| $1.49$
| $1.51$
| $+3.71$

|
Planning ( $w{=}0$ )

| –
| –
| $1.06$
| $0.08$
| $+14.00$

|
Planning+IG ( $w{=}5$ )

| –
| –
| $1.34$
| $0.02$
| $+15.67$

|
EFE ( $w{=}1$ )

| –
| –
| $\mathbf{1.34}$
| $\mathbf{0.02}$
| $\mathbf{+15.67}$

| RS[7,4]
| Greedy
| –
| –
| $1.98$
| $2.02$
| $-0.88$

|
Planning ( $w{=}0$ )

| –
| –
| $0.98$
| $0.04$
| $+14.39$

|
Planning+IG ( $w{=}5$ )

| –
| –
| $1.50$
| $0.02$
| $+13.47$

|
EFE ( $w{=}1$ )

| –
| –
| $\mathbf{1.38}$
| $\mathbf{0.00}$
| $\mathbf{+15.47}$

| RS[7,8]
| Greedy
| –
| –
| $3.50$
| $4.50$
| $-7.09$

|
Planning ( $w{=}0$ )

| –
| –
| $0.45$
| $0.05$
| $+11.75$

|
Planning+IG ( $w{=}5$ )

| –
| –
| $2.55$
| $0.05$
| $+20.82$

|
EFE ( $w{=}1$ )

| –
| –
| $\mathbf{2.15}$
| $\mathbf{0.05}$
| $\mathbf{+19.57}$

|

RS[11,11]
[-1pt] $|S|{=}2048$

| Greedy
| –
| –
| $5.33$
| $5.67$
| $-21.90$

|
Planning ( $w{=}0$ )

| –
| –
| $0.50$
| $0.01$
| $+13.64$

|
Planning+IG ( $w{=}5$ )

| –
| –
| $0.53$
| $0.01$
| $+13.66$

|
EFE ( $w{=}1$ )

| –
| –
| $\mathbf{0.50}$
| $\mathbf{0.01}$
| $\mathbf{+13.64}$

On RS[5,3] and RS[7,4], EFE ( $w{=}1$ ) achieves the highest reward. On RS[7,8], EFE ( $w{=}1$ ) scores $+19.57$ vs. Planning’s $+11.75$ ( $+7.82$ gap), showing that the advantage grows with the number of observation actions, consistent with the observe-then-commit findings. On all instances up to RS[7,8], EFE samples dramatically fewer bad rocks than Greedy (0.00–0.05 vs. 1.51–5.67), confirming that the information gain term drives checking behavior.

On RS[11,11] ( $|S|{=}2{,}048$ ), EFE and Planning achieve identical reward ( $+13.64$ ), with all information-aware agents vastly outperforming Greedy ( $+13.6$ vs. $-21.9$ ). This result demonstrates tractability, since the factored belief tree search handles 2,048 states in seconds, but it does not differentiate EFE from reward-only planning. At depth 2, the tree search horizon is too shallow relative to the 11-rock environment: all informed agents converge to a conservative “check nearest rock, sample if good, exit” strategy. Depth 3 is computationally intractable at this scale, requiring orders of magnitude more search time per step. This mirrors the Tileworld scaling finding (Figure 3), where EFE’s advantage requires sufficient depth relative to the state space. The RS[7,8] result, where EFE achieves a $+7.82$ reward gap over Planning, shows that EFE differentiation emerges when the observation action count ( $K{=}8$ ) provides sufficient room for directed information gathering within the search horizon. Detailed results including POMCP baselines are in Appendix 0.S.

###
5.5 Structural inspection

To validate Proposition 3 on a domain-realistic benchmark and demonstrate scalability beyond existing environments, we implement a Structural Inspection POMDP mapping directly to industrial fault detection, medical screening, and non-destructive testing domains. The agent inspects $N$ components arranged spatially, each with a hidden binary state (nominal/faulty). Two non-destructive test types provide accuracy–cost trade-offs: a visual check (accuracy 0.70, cost 0.5) and a detailed test (accuracy 0.90, cost 2.0). The agent navigates between components, selects tests, and declares diagnoses with asymmetric penalties (missed fault $-50$ , false alarm $-5$ ). Tests do not alter component states, so this is a factored observation POMDP and Proposition 3 applies.

Table 7: Structural Inspection results. $N{=}8$ uses 2,500 episodes (500 per seed $\times$ 5 seeds) and $N{=}16$ uses 1,000 episodes (200 per seed $\times$ 5 seeds). Reward shown as mean $\pm$ SE. EFE ( $w{=}1$ ) achieves the best reward–accuracy trade-off. Accuracy: fraction of components correctly diagnosed.

| Instance
| Agent
| Accuracy
| Missed
| Tests
| Reward

|

$N{=}8$
[-1pt] $|S|{=}256$

| Greedy
| 70.7%
| $2.34$
| $0.0$
| $-114.33\pm 1.33$

|
Planning ( $w{=}0$ )

| 73.0%
| $0.07$
| $12.7$
| $-17.85\pm 0.34$

|
Planning+IG ( $w{=}5$ )

| 94.9%
| $0.10$
| $18.7$
| $-22.82\pm 0.35$

|
EFE ( $w{=}1$ )

| $\mathbf{87.9\%}$
| $\mathbf{0.08}$
| $18.0$
| $\mathbf{-20.60\pm 0.34}$

|

$N{=}16$
[-1pt] $|S|{=}65{,}536$

| Greedy
| 70.0%
| $4.81$
| $0.0$
| $-237.46\pm 2.93$

|
Planning ( $w{=}0$ )

| 78.2%
| $0.26$
| $22.3$
| $-46.09\pm 0.94$

|
Planning+IG ( $w{=}5$ )

| 91.4%
| $0.24$
| $28.1$
| $-43.51\pm 0.85$

|
EFE ( $w{=}1$ )

| $\mathbf{86.1\%}$
| $\mathbf{0.27}$
| $32.8$
| $\mathbf{-45.71\pm 0.94}$

EFE ( $w{=}1$ ) achieves the best reward–accuracy trade-off on both instances. On $N{=}8$ ( $|S|{=}256$ ), EFE achieves $87.9\%$ accuracy with reward $-20.60\pm 0.34$ , gaining $+14.9$ pp accuracy over Planning ( $73.0\%$ , $-17.85$ ) at a moderate reward cost. Planning+IG ( $w{=}5$ ) achieves $94.9\%$ accuracy but at $-22.82$ reward: it over-tests, spending resources on visual checks where a single detailed test suffices. On $N{=}16$ ( $|S|{=}65{,}536$ ), EFE outperforms Planning by $+7.9$ pp accuracy ( $86.1\%$ vs. $78.2\%$ ) with comparable reward ( $-45.71\pm 0.94$ vs. $-46.09\pm 0.94$ , $p>0.05$ ). This is the largest state space in our evaluation and confirms that the factored belief tree search scales to realistic domains. The asymmetric penalty structure ( $\alpha=25$ ) places this firmly in the regime where Proposition 2 predicts $w{=}1$ is near-optimal.

###
5.6 Summary

The results reveal a consistent pattern across observe-then-commit, interleaved, and domain-realistic settings. EFE matches Planning+IG at $w{=}1$ , confirming Propositions 1 and 3. The canonical weight sits at the Pareto knee without per-environment search. On Diagnosis and Bandit, EFE Pareto-dominates same-horizon planning with higher success and better reward. On Tileworld, RockSample, and Inspection, it matches or improves upon Planning in reward at comparable or higher accuracy. The advantage grows with state space size and observation action count, scaling to $|S|{=}65{,}536$ on Inspection ( $N{=}16$ ), and it carries over to interleaved observe-act POMDPs with state transitions (RockSample, Inspection).

##
6 Discussion

##### When does EFE-as- $\rho$ help?

EFE’s advantage requires two conditions: (1) multiple observation actions with differential informativeness, and (2) sufficient planning horizon for recursive EFE to propagate epistemic value. When condition (1) fails, as on Tiger with its single listen action, reward-only planning matches EFE. The Tileworld adds a third axis: as the state space grows, the reward signal becomes too diffuse to guide scan selection, and EFE’s advantage increases (Figure 3). Within-episode dynamics (Appendix 0.L) show the mechanism: EFE concentrates belief via partition-based narrowing and commits once the value of committing exceeds the value of observing, a crossover that emerges automatically from $w{=}1$ without tuning (Figure 7, Appendix 0.G).

##### The canonical weight and why it works.

EFE does not eliminate the exploration–exploitation weight. It derives one from the variational bound. The Pareto analysis (Figure 1) shows this weight sits near the reward-maximizing $w^{*}_{\text{ret}}$ on every environment, while $w^{*}_{\text{succ}}$ lies at $20$ – $200$ . The gap between $w^{*}_{\text{ret}}$ and $w^{*}_{\text{succ}}$ has practical implications: $w{=}1$ optimizes expected reward, not success probability. In safety-critical settings where near-certain accuracy is required, a higher weight may be appropriate, though such weights must still be tuned per-environment, and EFE provides a principled starting point. Increasing $w$ beyond 1 buys marginal accuracy at substantial reward cost. Moreover, adding planning depth to a weighted IG bonus amplifies the weight’s effect ( $w{=}100$ on Bandit: Planning+IG takes 12.41 inspections vs. myopic Info Gain’s 10.99), making the tuning problem harder with depth. EFE avoids this because both terms arise from the same variational bound and share a common scale in nats. The canonical weight is $w{=}1$ precisely because information gain is measured in the same units (nats) as the KL divergence in the variational bound. This is a consequence of the mathematical structure rather than an empirical coincidence. In bits (base 2), the corresponding weight would be $w=1/\ln 2\approx 1.44$ . The Pareto analysis shows that the reward-optimal weight is insensitive to this factor: the knee is broad, and $w\in[0.5,2.0]$ yields near-identical reward on all environments, making the nat/bit distinction practically irrelevant.

The canonical weight’s advantage requires $\gamma\geq 0.99$ on multi-observation environments. Our discount-sensitivity analysis (Appendix 0.Q) reveals a sharp transition: on Diagnosis ( $N{=}4$ ), EFE’s success advantage over Planning is $+7.8$ pp at $\gamma{=}1.0$ but drops to $+1.0$ pp at $\gamma{=}0.95$ and reverses at $\gamma{=}0.90$ ( $-1.6$ pp). The mechanism is that discounting truncates the effective planning horizon below the number of observations needed for confident diagnosis, erasing EFE’s advantage. On Tiger (single observation), EFE is insensitive to $\gamma$ across the entire range $[0.90,1.0]$ . This is a meaningful practical limitation: applications with high time pressure or non-stationary environments that mandate heavy discounting will not benefit from EFE’s epistemic drive.

##### Zero-shot weight transfer.

The tuning problem is not merely inconvenient. It transfers catastrophically. We evaluate each environment’s success-maximizing weight $w^{*}_{\text{succ}}$ on all other environments (Table 8). On Tiger, transferring $w^{*}{=}100$ from Diagnosis drops reward from $+5.02$ (EFE) to $+4.13$ , as the agent over-explores. On the Testbed, transferring $w^{*}{=}20$ from Tiger drops reward from $+0.39$ (EFE) to $-0.16$ . On Tiger alone, the native $w^{*}{=}20$ achieves $+5.42$ (slightly above EFE’s $+5.02$ ), but this weight transfers poorly to all other environments. Across all 16 environment–weight pairs, EFE ( $w{=}1$ ) achieves the best or near-best reward on every environment without tuning, while every transferred weight underperforms EFE on at least one target. The success-maximizing weight varies by $5\times$ across environments ( $w^{*}{=}20$ for Tiger vs. $w^{*}{=}100$ for Bandit), making zero-shot deployment with a tuned weight unreliable. EFE sidesteps this entirely: its weight is derived, not tuned, and transfers robustly.

Table 8: Zero-shot weight transfer: mean reward achieved by each weight on each environment. EFE ( $w{=}1$ ) achieves the best or near-best reward on all four targets. Each success-tuned $w^{*}$ underperforms EFE on other environments. Bold: best reward per environment.

| Weight
| Tiger
| Diagnosis
| Bandit
| Testbed

|
$w{=}1$ (EFE)

| $+5.02$
| $\mathbf{-0.99}$
| $\mathbf{+6.38}$
| $\mathbf{+0.39}$

|
$w{=}20$ (Tiger $w^{*}$ )

| $\mathbf{+5.42}$
| $-1.75$
| $+4.98$
| $-0.16$

|
$w{=}50$ (Testbed $w^{*}$ )

| $+4.15$
| $-3.75$
| $+4.42$
| $-0.37$

|
$w{=}100$ (Diag./Band. $w^{*}$ )

| $+4.13$
| $-3.57$
| $+3.65$
| $-0.41$

##### When is $w{=}1$ near-optimal?

Proposition 2 formalizes the conditions for $H{=}1$ , two states: the observation threshold $w^{*}_{\text{thresh}}$ depends on the reward asymmetry ratio $\alpha=|R^{-}|/R^{+}$ , the observation informativeness $\eta=I_{\max}/c$ , and the observation accuracy $p$ . Table 1 validates this across our environments. The key predictor is $\alpha$ : environments with high penalty asymmetry ( $\alpha\geq 5$ : Tiger, Diagnosis, Tileworld) have $w^{*}_{\text{thresh}}\ll 0$ , meaning $w{=}1$ is far above the threshold and near-optimal.

To assess whether the $H{=}1$ analysis extends to multi-step planning, we conducted a Monte Carlo study over 100 randomly generated two-state environments (sampling $\alpha\in[1,50]$ , $p\in[0.55,0.95]$ , cost $\in[0.1,5]$ ). For each environment and $H\in\{1,2,3\}$ , we compute the reward-optimal $w^{*}$ by grid search and classify $w{=}1$ as near-optimal when the reward gap from $w^{*}$ is within $\max(5\%,0.5)$ of the best reward (Figure 12). The near-optimality rate increases from 9% at $H{=}1$ to 22% at $H{=}2$ and 32% at $H{=}3$ , confirming that multi-step planning amplifies the value of observation and expands the region where $w{=}1$ is near-optimal. For high-asymmetry environments ( $\alpha\geq 10$ ), the improvement is sharper: 11% $\to$ 24% $\to$ 32%. This is consistent with the Bandit result, where $\alpha{=}1.1$ and the $H{=}1$ analysis predicts marginal sufficiency, yet multi-step EFE at $H{=}2$ achieves $87.3\%$ success (Table 4).

Many real-world decision problems have $\alpha\gg 1$ : in medical diagnosis, fault detection, and security screening, a missed condition costs far more than another test. This is exactly the regime where $w{=}1$ is well calibrated, and the multi-step analysis shows the advantage grows with planning depth. The practical consequence is that in these domains the exploration weight can be deployed as-is, with no per-task search.

##### Robustness to model misspecification.

Our main results assume exact knowledge of the generative model. Appendix 0.R investigates robustness when the agent’s believed observation accuracy differs from the true value by up to $\pm 0.15$ . On Tiger, success rates remain above 96.7% across all mismatch levels. On Diagnosis, degradation is larger but graceful. Overestimating sensor accuracy (positive mismatch) is more harmful than underestimating it, because the agent commits prematurely on insufficient evidence. EFE’s intrinsic epistemic drive provides a partial buffer: even with a miscalibrated model, the information gain term still encourages observation, compensating for overconfident planning.

##### Approximate planning with MCTS-EFE.

The exact tree search cost $\mathcal{O}(K\cdot|\mathcal{O}|^{H})$ limits practical horizons to $H{=}2$ – $3$ with $K\geq 3$ . To push beyond this, we implement MCTS with EFE as a leaf heuristic: the tree policy uses UCB1 with observation-outcome enumeration, and leaf nodes are evaluated via greedy EFE rollouts. On Tiger at $H{=}10$ , MCTS-EFE with 500 simulations achieves 97.2% success (7.2s per 200 episodes), compared to 89.7% for POMCP at matched budget (1.7s). This demonstrates that EFE’s closed-form information valuation provides a substantially stronger leaf heuristic than semi-informed rollouts. The comparison is designed to be fair to POMCP: our implementation already uses belief-optimal commits (not purely random rollouts): observations are sampled uniformly, but the rollout terminates with the commit action maximizing expected reward under the Bayesian-updated belief (Appendix 0.T). The remaining performance gap therefore reflects the value of directed observation selection: EFE chooses which test to run based on information gain, while POMCP samples tests uniformly. The claim is not that EFE-based planning exceeds state-of-the-art POMDP solvers, but that the EFE leaf heuristic provides a principled, zero-tuning alternative to heuristic rollout design. POMCP with fully informed rollouts (e.g., using domain knowledge or a learned value function for observation selection) would narrow the gap further.

The approach also scales to multiple observation actions. For single-observation environments, the observation-outcome enumeration (2 outcomes per action) keeps expansion costs low. On Diagnosis ( $N{=}4$ , $K{=}2$ tests), MCTS-EFE at $H{=}5$ achieves $98.0\%$ success compared to POMCP’s $71.3\%$ at matched budget (200 simulations), demonstrating that EFE scales to multi-observation environments. To validate on a larger multi-observation environment, we evaluate on Tileworld $6{\times}6$ ( $|S|{=}36$ , $K{=}6$ scans). MCTS-EFE(50) achieves $96.0\%$ success and $-19.04$ reward, outperforming both Exact-EFE (75.0%, $-20.11$ ) and POMCP at matched (50) or higher (200) simulation budgets ( $2.0\%$ / $15.0\%$ success). The improvement over exact tree search reflects MCTS’s ability to concentrate samples on promising observation sequences. The $81$ – $94$ pp gap over POMCP confirms that EFE’s directed observation selection is essential at this scale: POMCP’s semi-informed rollouts cannot identify which of the 6 scans to perform. For larger observation spaces, more efficient tree policies, such as progressive widening or double progressive widening [3], would further improve scalability. We leave this to future work.

##### When to use EFE-as- $\rho$ : summary.

Our analysis identifies the following conditions favoring EFE over tuned alternatives:

-
•

Reward asymmetry $\alpha\geq 5$ : the penalty for a wrong commit far exceeds the observation cost, making $w{=}1$ automatically near-optimal (Proposition 2).

-
•

Multiple observation actions: EFE’s joint pragmatic–epistemic objective selects which information to gather, producing gains over reward-only planning even at matched horizon.

-
•

Moderate to large state spaces ( $|S|\geq 16$ ): as the reward signal diffuses, directed information gathering becomes essential, and EFE’s advantage grows with $|S|$ (Figure 3), scaling to $|S|{=}65{,}536$ on Structural Inspection.

-
•

Interleaved observe-act with preserved hidden state: when the hidden state does not change under observation and navigation actions (factored observation POMDPs, Table 2), the canonical-weight equivalence holds and EFE directs both where to go and what to check (Tables 6, 7).

-
•

Cross-environment deployment: when the weight cannot be tuned per-task, $w{=}1$ transfers robustly while tuned weights fail catastrophically (Table 8).

-
•

Planning horizon $H\geq 2$ : recursive EFE propagates epistemic value across steps. At $H{=}1$ , it reduces to myopic IG with $w{=}1$ .

EFE is not recommended when $\alpha\approx 1$ (symmetric penalties), in navigation-style POMDPs where observations are tied to translation and a greedy mover already receives informative feedback (Table 17), or when model misspecification exceeds $\pm 0.15$ in observation accuracy.

##### Limitations and future work.

The formal equivalence extends from observe-then-commit (Proposition 1) to factored observation POMDPs (Proposition 3), covering settings where observation actions preserve the hidden state. POMDPs where information-gathering actions change the hidden state (e.g., destructive testing) require the full coupling term $\Delta_{T}$ and are not covered. Extending the formal treatment to such settings remains future work. For slowly drifting hidden states (e.g., progressive disease), $\Delta_{T}$ is small but nonzero. The approximation error scales with the per-step transition entropy $H(s^{\prime}_{\mathrm{hid}}|s_{\mathrm{hid}},a)$ , and characterizing the regime where this remains acceptable is an open question.

On the practical side, scaling MCTS-EFE to multi-observation environments requires more efficient tree policies, as discussed above. The EFE agent assumes a known generative model. The misspecification analysis (Appendix 0.R) shows graceful degradation with moderate model errors, but extending to full model learning (where AIF and BAMDPs converge) remains important future work. Navigation (Appendix 0.I) shows that scale alone does not rescue epistemic planning when the observation model is proximity-based: NavMyopic leads at $3{\times}3$ , $5{\times}5$ , and $7{\times}7$ . The practical contrast is with domains that offer explicit, choice-set observation actions (Diagnosis, Tileworld, RockSample), where $|S|\geq 16$ marks the regime in which EFE separates from reward-only planning.

##### Broader impact.

This work is primarily theoretical. The principled derivation of exploration weights could benefit safety-critical decision-making by reducing reliance on ad-hoc tuning.

##
7 Conclusion

The $\rho$ -POMDP framework and active inference converge on the same mathematical object: a belief-dependent utility that adds information gain at weight $w{=}1$ to the reward signal. EFE does not eliminate the exploration–exploitation trade-off. Instead, it replaces ad hoc bonus weights with a coefficient fixed by the variational geometry (nats), which then doubles as the Planning+IG weight in Proposition 1. The Pareto analysis shows this canonical weight is near-optimal for expected reward across all tested test-selection environments, sitting at the knee where further increases buy marginal accuracy at substantial reward cost. Safety-critical applications requiring near-certain accuracy may benefit from higher weights. A Monte Carlo study over randomly generated environments (Appendix 0.P) confirms that the near-optimality basin widens with planning horizon, extending the $H{=}1$ analysis of Proposition 2 to multi-step settings.

Proposition 3 extends the formal equivalence beyond observe-then-commit to factored observation POMDPs, validated on RockSample (up to $|S|{=}2{,}048$ ) and a new Structural Inspection benchmark ( $|S|$ up to $65{,}536$ ) mapping directly to industrial fault detection and medical screening domains. On Inspection ( $N{=}16$ ), EFE achieves $86.1\%$ diagnostic accuracy where planning scores $78.2\%$ , at comparable reward ( $p>0.05$ ). Comparison against POMCP with semi-informed rollouts (random observations, belief-optimal commits, Appendix 0.T) shows that EFE’s advantage comes from directed observation selection, not from using a stronger solver. Domain-informed POMCP rollouts would narrow this gap, but they require per-environment engineering that EFE avoids. MCTS-EFE on Tiger achieves 97.2% success at $H{=}10$ with 500 simulations, outperforming POMCP (89.7%) at matched compute. The advantage is most pronounced in multi-observation-action settings: on the $8{\times}8$ Tileworld, EFE achieves $66.5\%$ success where reward-only planning collapses to $2.5\%$ . The message for practitioners is simple: wherever an agent must pay for its observations and answer for its mistakes, the exploration weight it needs is not a hyperparameter to search over, because active inference already supplies it.

{credits}

####
7.0.1 \discintname

The authors have no competing interests to declare that are relevant to the content of this article.

## References

-
Araya-López et al. [2010]
$\rho$ $\rho$ $\epsilon$ $\arg\min_{a}\mathcal{G}(a,b,d)=\arg\max_{a}V_{\rho}(a,b,d)$ $V_{\rho}$ $\rho$ $\rho_{\mathrm{EFE}}(b,a)$ $V(a,b,d)\triangleq-\mathcal{G}(a,b,d)$ $\arg\min_{a}\mathcal{G}=\arg\max_{a}V$ $i$ $\mathcal{G}(\text{commit}_{i})=-\mathbb{E}_{b}[R_{i}]$ $V(\text{commit}_{i},b)=\mathbb{E}_{b}[R_{i}]$ $\rho$ $V_{\rho}(\text{commit}_{i},b)=\mathbb{E}_{b}[R_{i}]+\rho_{\mathrm{EFE}}(b,\text{commit}_{i})=\mathbb{E}_{b}[R_{i}]+0$ $k$ $\mathcal{G}(\text{obs}_{k})=c_{k}-I_{k}(b)+\mathbb{E}_{o}[\min_{a^{\prime}}\mathcal{G}(a^{\prime},b^{\prime}_{o})].$ $V(\text{obs}_{k},b)=-c_{k}+I_{k}(b)+\mathbb{E}_{o}[\max_{a^{\prime}}V(a^{\prime},b^{\prime}_{o})].$ $\rho$ $R(b,\text{obs}_{k})=-c_{k}$ $\rho_{\mathrm{EFE}}(b,\text{obs}_{k})=I_{k}(b)$ $V_{\rho}(\text{obs}_{k},b)=-c_{k}+I_{k}(b)+\gamma\mathbb{E}_{o}[\max_{a^{\prime}}V_{\rho}(a^{\prime},b^{\prime}_{o})].$ $\gamma=1$ $H-d$ $V(a,b,d)=V_{\rho}(a,b,d)$ $a$ $b$ $d$ $\times$ $H{=}6$ $+10/{-}100$ $1.00$ $-7.98\pm 0.56$ $H{=}6$ $4.28$ $+5.15\pm 0.12$ $w{=}20$ $4.25$ $+5.31\pm 0.10$ $w{=}20$ $4.20$ $+5.19\pm 0.12$ $0.00$ $-44.93\pm 0.78$ $H{=}6$ $\mathbf{4.22}$ $\mathbf{99.5\%}$ $\mathbf{+5.23\pm 0.11}$ $N{=}4$ $K{=}2$ $H{=}3$ $\times$ $2.00$ $-13.48\pm 0.41$ $H{=}3$ $5.91$ $-2.37\pm 0.26$ $w{=}100$ $13.27$ $-3.75\pm 0.10$ $w{=}100$ $13.21$ $-3.63\pm 0.10$ $H{=}3$ $\mathbf{9.73}$ $\mathbf{97.1\%}$ $\mathbf{-1.50\pm 0.15}$ $K{=}4$ $H{=}2$ $\times$ $2.04$ $+5.53\pm 0.06$ $H{=}2$ $3.24$ $+5.65\pm 0.06$ $w{=}50$ $10.99$ $+4.48\pm 0.04$ $w{=}100$ $12.41$ $+3.78\pm 0.04$ $0.00$ $+3.26\pm 0.06$ $H{=}2$ $\mathbf{5.16}$ $\mathbf{87.3\%}$ $\mathbf{+6.27\pm 0.05}$ $6{\times}6$ $\times$ $H{=}2$ $0.00$ $-48.39$ $H{=}2$ $15.68$ $-21.47$ $w{=}100$ $32.32$ $-23.50$ $w{=}100$ $33.38$ $-24.31$ $200.0$ $-200.00$ $H{=}2$ $\mathbf{14.81}$ $\mathbf{72.8\%}$ $\mathbf{-21.13}$ $8{\times}8$ $\times$ $H{=}2$ $66.5\%$ $0.00$ $-49.10$ $H{=}2$ $0.00$ $-49.10$ $w{=}1$ $0.00$ $-48.30$ $w{=}100$ $39.93$ $-31.13$ $w{=}100$ $39.90$ $-31.90$ $200.0$ $-200.00$ $H{=}2$ $\mathbf{17.87}$ $\mathbf{74.2\%}$ $\mathbf{-23.37}$ $N{=}16$ $K{=}4$ $H{=}2$ $\times$ $4.00$ $-29.30$ $H{=}2$ $11.84$ $-14.34$ $w{=}1$ $4.00$ $-29.90$ $w{=}100$ $26.56$ $-17.46$ $w{=}100$ $26.64$ $-17.44$ $200.0$ $-200.00$ $H{=}2$ $\mathbf{11.81}$ $\mathbf{79.5\%}$ $\mathbf{-14.11}$ $H{=}4$ $+1/{-}1$ $w^{*}{=}50$ $w{=}1$ $1.00$ $+0.40\pm 0.01$ $H{=}4$ $3.22$ $\mathbf{+0.49\pm 0.01}$ $w{=}50$ $12.02$ $-0.20\pm 0.01$ $w^{*}{=}50$ $13.99$ $-0.40\pm 0.01$ $H{=}4$ $5.55$ $\mathbf{97.1\%}$ $+0.39\pm 0.01$ $+1/{-}1$ $+0.39$ $+0.49$ $p<0.001$ $w{=}50$ $w{=}1$ $|R^{-}|/|R^{+}|=1$ $w^{*}_{\text{ret}}<1$ $|R^{-}|/|R^{+}|\gg 1$ $w{=}1$ $H{=}6$ $|R^{-}|{=}1$ $500$ $w{=}20$ $|R^{-}|{=}100$ $N{=}8$ $H{=}3$ $K$ $N{=}8$ $K$ $K{=}1$ $K$ $6{\times}6$ $H{=}6$ $|S|$ $-1.0$ $+10$ $-100$ $-0.1$ $+1$ $-1$ $N{=}4$ $-1.0$ $+10$ $-50$ $K{=}4$ $-0.5$ $+10$ $+1$ $-0.5$ $+20$ $6{\times}6$ $-1.0$ $+10$ $-50$ $K=\lceil\log_{2}N\rceil$ $K=2\lceil\log_{2}N\rceil$ $150$ $\times$ $5$ $750$ $3n^{2}$ $H{=}2$ $|S|$ $3{\times}3$ $9$ $91.1\%$ $+2.34$ $83.2\%$ $-5.26$ $H{=}2$ $86.5\%$ $-0.84$ $5{\times}5$ $25$ $79.2\%$ $-19.08$ $73.6\%$ $-25.83$ $H{=}2$ $73.1\%$ $-25.92$ $7{\times}7$ $49$ $68.0\%$ $-34.65$ $62.1\%$ $-43.52$ $H{=}2$ $61.6\%$ $-42.86$ $w{=}1$ $7{\times}7$ $N=2$ $16$ $\times$ $H{=}2$ $N$ $-2.74$ $+3.35$ $-2.98$ $\mathbf{+3.59}$ $-12.81$ $-2.78$ $-12.69$ $-2.78$ $-22.69$ $-8.49$ $-21.44$ $-9.01$ $-29.98$ $-15.69$ $-29.04$ $\mathbf{-14.30}$ $H{=}2$ $N$ $H{=}3$ $+7.9$ $+13.8$ $N{=}2$ $+39.1$ $N{=}16$ $N{=}8$ $K{=}3$ $N{=}8$ $K{=}3$ $N{=}8$ $K{=}3$ $N{=}8$ $K{=}3$ $K{=}3$ $K{=}3$ $w{=}1$ $t$ $d$ $d$ $d$ $|d|{<}0.2$ $0.2$ $0.5$ $0.5$ $0.8$ $|d|{>}0.8$ $d$ $s$ $d$ $+0.44$ $-0.01$ $+0.01$ $-0.01$ $-0.03$ $-0.19$ $+1.34$ $+1.33$ $+0.53$ $+0.07$ $+0.24$ $+0.23$ $+0.21$ $+0.20$ $+0.67$ $+0.79$ $d$ $-0.02$ $+0.27$ $+0.33$ $+0.47$ $d>1.3$ $d\approx 0.7$ $0.8$ $w{=}1$ $H$ $\alpha$ $\alpha\in[1,50]$ $p\in[0.55,0.95]$ $\in[0.1,5]$ $\gamma\in\{0.9,0.95,0.99,1.0\}$ $\gamma$ $\gamma$ $\Delta$ $-$ $\gamma$ $\gamma$ $\Delta$ $+5.24$ $+0.4$ $+6.15$ $+5.52$ $+0.2$ $+5.36$ $+4.74$ $-0.6$ $+5.66$ $+5.79$ $+0.4$ $+5.47$ $-3.98$ $-1.6$ $-3.08$ $-2.56$ $+1.0$ $-3.12$ $-1.56$ $+7.0$ $-1.65$ $-1.30$ $+7.8$ $-2.07$ $+5.30$ $-4.8$ $+5.70$ $+5.41$ $-3.0$ $+5.68$ $+6.23$ $+22.0$ $+5.53$ $+6.15$ $+16.2$ $+5.56$ ${\geq}99\%$ $\gamma$ $\gamma{=}0.9$ $0.95$ $\gamma{=}0.9$ ${\sim}2$ ${\sim}6$ $\gamma{=}0.95$ $\gamma{=}0.99$ $\gamma{=}0.99$ $+7.0$ $+22.0$ $\gamma\geq 0.99$ $p_{\text{agent}}$ $p_{\text{true}}$ $p_{\text{true}}{=}0.85$ $H{=}4$ $p_{\text{agent}}-p_{\text{true}}$ $p_{\text{agent}}$ $-0.15$ $+5.11$ $-0.05$ $+5.46$ $\pm 0.00$ $+5.32$ $+0.05$ $+3.66$ $+0.10$ $+4.30$ $-0.15$ $+5.20$ $\pm 0.00$ $+5.36$ $+0.10$ $+3.92$ $p_{\text{true}}{=}0.80$ $H{=}3$ $p_{\text{agent}}$ $-0.15$ $-2.36$ $-0.05$ $-1.11$ $\pm 0.00$ $-1.36$ $+0.05$ $-2.62$ $+0.10$ $-2.52$ $-0.15$ $-2.65$ $\pm 0.00$ $-2.40$ $+0.10$ $-3.04$ $\pm 0.15$ $12.0$ $1.50$ $1.50$ $+4.03\pm 17.24$ $w{=}1$ $19.4$ $1.16$ $\mathbf{0.33}$ $\mathbf{+8.63\pm 10.63}$ $21.0$ $2.00$ $2.00$ $-0.58\pm 20.12$ $w{=}1$ $29.3$ $1.71$ $\mathbf{0.43}$ $\mathbf{+8.20\pm 12.35}$ $0.33$ $0.43$ $+8.63$ $+4.03$ $+8.20$ $-0.58$ $w{=}5$ $w{=}10$ $w{=}5$ $w{=}10$ $w{=}1$ $+8.64$ $+8.63$ $w{=}1$ $+8.20$ $+5.57$ $\{500,1000,2000,5000\}$ $4.30$ $+5.48$ $1.67$ $-3.42$ $\mathbf{4.29}$ $\mathbf{99.2\%}$ $\mathbf{+4.83}$ $6.02$ $-4.42$ $3.91$ $-10.04$ $\mathbf{9.76}$ $\mathbf{96.6\%}$ $\mathbf{-1.80}$ $3.35$ $+5.79$ $14.41$ $+2.51$ $\mathbf{5.19}$ $\mathbf{89.0\%}$ $\mathbf{+6.42}$ $6{\times}6$ $-20.72$ $-48.36$ $\mathbf{73.0\%}$ $\mathbf{-21.22}$ $-10.04$ $-1.80$ $K{=}2$ $+2.51$ $+6.42$ $6{\times}6$ $|S|{=}36$ $\times$ $H{=}10$ $H{=}6$

