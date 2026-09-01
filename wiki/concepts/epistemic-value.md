# Epistemic Value

**The value of an action that changes only what the agent knows. Four incompatible quantities are in circulation under this one name, they are defined over different distributions, and where anyone has ablated them the term that pays is almost never the term the theory derives.**

This page is the measurement half of [[wiki/concepts/expected-free-energy.md]]. That page holds what the objective *is* — the decomposition `G(π) = ⟨ℓ, μ^π⟩ + Φ(μ^π)`, the convex-MDP class it belongs to, and the ρ-POMDP identity that fixes the exploration weight at `w = 1` without tuning. This page holds what happens when the term is switched off: four independent ablation literatures across message passing, deep networks, gradient descent and a human electroencephalography study, which between them are the wiki's only evidence that a derived exploration drive earns its place.

They were split apart because the two halves disagree. The theory side says the objective is well-posed, its weight is derived, and its dominant term is information gain about *parameters*. The measurement side says that the version anyone actually runs is one-step, state-based, wrongly signed, and beaten by its own reward-only ablation — and that the one gradient implementation where the term *does* pay needed a different correction in each of two environments.

---

## Four quantities, one name

The single most useful product of reading these sources together, and it is not stated in any of them:

| # | Quantity | Over what distribution | Pays for | Where it is derived |
|---|---|---|---|---|
| E1 | `Φ = −Σ_t H(ρ_t^π)` | predictive **state marginal** — states the agent will occupy | *spreading*: coverage of the state space | the convex-MDP decomposition ([[wiki/concepts/expected-free-energy.md]]) |
| E2 | `I_a(b) = H(b) − E_o[H(b'_o)]` | **belief over a fixed hidden state** | *sharpening*: concentration of the belief | the ρ-POMDP identity, at `w = 1` |
| E3 | novelty `= D_KL[q(θ\|y,x) ‖ q(θ\|x)]` | belief over **model parameters** | information gain about the model itself | Theorem 1's entropy corrections, below |
| E4 | ambiguity `= E H[q(y\|x,θ)]` (penalised) | **observation kernel** given state and parameters | reducing how equivocal the sensor is | same |

E1 and E2 are what the theory pages derive. **E3 is what the ablations find carries the effect**, wherever a sensing action does not itself change the sensor — and it is excluded by construction from the convex-MDP result and scored over the wrong object by the ρ-POMDP identity. For a graph-discovery agent E3 is the relevant one by construction, because the unknown is the graph, and a graph is a parameter rather than a state.

**The audit that separates a real epistemic term from an impostor.** If an agent that freezes its own policy can drive its epistemic term to zero, the term is a **self-consistency penalty, not an information gain**. E1 and E2 pass — an occupancy cannot be made to spread, nor a belief to sharpen, by refusing to act. The deep estimator in the third section below fails, and its measured failure mode is exactly that: pick one action forever, become expert at predicting it, drive the divergence to zero.

---

## EFE is a set of entropy corrections to plain variational inference — and only one of them pays

> **Third primary source.** `raw/nuijten-2026-what-inference-is-active-inference.md` — Nuijten, Lukashchuk, van de Laar & de Vries, arXiv:2606.04935, 2026. Milosevic et al. classify the optimisation problem and Cooper & Velasquez identify the objective with a ρ-POMDP; this source asks what *distinguishes* the objective from ordinary planning-as-inference, answers with an exact algebraic identity, and then ablates the pieces.

**Theorem 1 (entropy-corrected form).** Let `p̂` be the preference-augmented rollout model (goals as priors `p̂(x_t)`, `p̂(y_t)`, with `p̂(x) ∝ exp R(x)`), and `p̃` that model further augmented with the epistemic priors that encode which variables are controlled / inferred / observed. Then, exactly:

```
F_p̃[q] = F_p̂[q] + Σ_t ( 2·H[q(y_t|x_t,θ)] − H[q(x_t|x_{t-1},u_t)] − H[q(y_t|x_t)] )
```

Grouped the standard way, `H[q(y|x,θ)]` is **ambiguity** (penalised) and `H[q(y|x)] − H[q(y|x,θ)]` is **novelty**, the expected information gain about the *parameters* `θ` (rewarded) — the factor of two is these two groupings overlapping.

**The AIF-specific commitment lives entirely in the correction term.** Specifying a planning method is a three-way choice — (i) the generative model, (ii) the assignment of variable roles among controlled / state / parameter / observed, (iii) the entropy correction that selects the objective. (i) and (ii) are shared with every planning-as-inference method; only (iii) is active inference. The ladder:

| Objective | Correction added to `F_p̂[q]` | What changes |
|---|---|---|
| Baseline VFE | `0` | marginal inference; in control, KL control |
| **Cross-entropy planning** (VBP) | `+Σ_t H[q(u_t\|x_{t-1})]` | *how control is posed* — penalises action uncertainty so the extracted policy actually attains the cost it appears to minimise; kills optimistic inference (conditioning on goals otherwise buys favourable state realisations the policy cannot produce). Reduces to `min_q Σ_t H[q(x_t), p̂(x_t)]` = expected-reward maximisation |
| **Risk-minimising planning** | CE `− Σ_t H[q(x_t\|x_{t-1},u_t)]` | adds Friston's *risk*; an intermediate ablation |
| **EFE-based planning** | CE `+ Σ_t (2H[q(y_t\|x_t,θ)] − H[q(x_t\|x_{t-1},u_t)] − H[q(y_t\|x_t)])` | *what* is optimised — adds ambiguity and novelty |

Two corrections, two jobs: **the planning correction changes how control is posed; the EFE correction changes what objective is optimised.** Proper active-inference planning needs both, and neither implies the other — Theorem 1 alone yields EFE inside a *marginal* objective, which is not yet planning over policies.

**Implementation: channel reparameterization.** A conditional entropy is not a function of any single coordinate in a Bethe/factor-graph optimisation (a conditional is a ratio of region beliefs). Gibbs' inequality `H[q(y|x)] = min_r E_q[−log r(y|x)]` promotes each corrected conditional to a free variational parameter (a *channel*), exactly rather than as a bound. Each correction then acts locally on one factor kernel:

```
f̃_obs(y,x,θ) = p(y|x,θ)·r_{y|xθ}²(y|x,θ) / r_{y|x}(y|x)
f̃_dyn(x,x',θ,u) = p(x|x',θ,u)·r_{u|x}(u|x') / r_{x|xu}(x|x',u)
```

The objective is then a standard Bethe free energy on the modified graph, so **the whole family runs as sum-product message passing with kernels substituted for factors** — belief propagation, VBP, risk-minimising planning and full EFE planning are one derivation at different channel counts, and the posterior-dependent epistemic priors' circularity becomes an ordinary joint optimisation over beliefs and channels (fixed point: each `r*` equals the corresponding conditional of its region belief).

**Learning and planning are deliberately separated, and that is what makes novelty additive.** `θ` is updated by Bayesian filtering on *real* observations; during planning it is held at `q(θ)` (backward messages into `θ` from simulated factors are simply not sent). Because every step's novelty is then scored against a common `θ` baseline, the *global* information gain about `θ` decomposes into per-step factors and is additive over the horizon. **(brainstorm)** This is a concrete answer to a question the wiki keeps deferring — how a graph-discovery agent can credit an individual probe for what it reveals about global structure. Freeze the structural belief across the rollout and per-probe information gains stop double-counting; let it update inside the rollout and they do not sum.

### Ablations: novelty is the term that does the work

Three grid-worlds with the layout itself as the unknown parameter `θ`, 1000 episodes, all methods sharing belief machinery and differing only in which channels are active. **Nuijten-MP** is the prior alternating heuristic (epistemic priors recomputed as literal prior factors between BP sweeps, novelty prior omitted).

| Method | Corrections | Frozen Lake success | RockSample reward / retrieval | Wumpus success |
|---|---|---|---|---|
| BP | none | 51.9% | 1.00 / 0.0% | 1.2% |
| VBP | planning | 54.5% | 1.00 / 0.0% | 5.5% |
| RM-MP | + dynamics | 50.0% | 1.00 / 0.0% | 24.0% |
| Nuijten-MP | ambiguity only, heuristic | **95.6%** | 1.00 / 0.0% | 5.0% |
| **AIF-MP** | planning + dynamics + observation | **95.9%** | **4.01 / 98.7%** | **40.7%** |

The environments are chosen to separate *where epistemic value lives*. In Frozen Lake a SCAN action persistently changes the observation kernel, so its value shows up as reduced **ambiguity** and the heuristic finds it as easily as the joint scheme. In canonical RockSample and Wumpus World no action changes the observation model — a CHECK buys one noisy reading whose entire value is what it says about `θ`, i.e. pure **novelty**. There, every method without the novelty term walks straight to the exit (`0.0%` retrieval), because under a uniform quality prior sampling an unchecked rock has negative expected reward and so CHECK is worthless.

| Correction | Empirical worth |
|---|---|
| Planning (`+H[q(u\|x)]`) | modest (`51.9 → 54.5%`) |
| Dynamics (`−H[q(x\|x,u)]`) | nothing under deterministic dynamics; substantial under stochastic (Wumpus `5.5 → 24.0%`) |
| Ambiguity | large *only* when a sensing action persistently changes the observation kernel |
| **Novelty** (info gain about `θ`) | the rest — and it is all-or-nothing where sensing is one-shot (`0.0% → 98.7%` retrieval) |

The gap to the heuristic is an **objective mismatch, not a scheduling artefact**: treating epistemic priors as literal priors recomputed outside the variational objective drops the novelty prior, and the method collapses to its planning-only core exactly when novelty is the only source of epistemic value.

### What this changes for the wiki

- **The wiki's open problem "the epistemic value is over *states*, not parameters" is now the main result, inverted.** The convex-MDP reduction explicitly excludes parameter-novelty terms, and the ρ-POMDP identity scores information gain about a *belief over a fixed hidden state*. This source measures the term both exclude and finds it carries nearly the whole effect wherever sensing does not alter the sensor. See [[wiki/empirical-tensions.md]] T124.
- **"Active inference vs. planning-as-inference" is a one-line difference, and it is auditable.** Any implementation can be placed on the ladder above by asking which entropy corrections its loss contains. Several methods that call themselves active inference sit at cross-entropy planning plus ambiguity.
- **The `−H(ρ_t)` / `I_a(b)` pair on this page is now a triple.** Three distinct "epistemic terms" are in circulation: coverage over states one will occupy (Milosevic), sharpening of a belief over a fixed hidden state (Cooper), and information gain about *model parameters* (this source). Only the third pays in the environments where sensing is one-shot. **(brainstorm)** For a reasoning agent the third is the relevant one by construction — the unknown is the graph, which is a parameter, not a state.
- **The cost is a min-max.** The corrections carry opposing signs, so the joint optimisation over beliefs and channels is min-max: standard belief-propagation convergence guarantees do not transfer, arithmetic damping `r^n ∝ (1−λ)r^{n−1} + λr*` is required, `λ` is tuned per environment, and convergence takes ~150 iterations. The wiki's cleanest derived exploration drive is also its least stable optimiser.

---

## Implemented in neural networks, the epistemic term does not pay — and one form of it collapses the policy

> **Fourth primary source.** `raw/champion-2023-deconstructing-deep-active-inference.md` — Champion, Grześ, Bonhême & Bowman, 2023. The first three sources are analyses of the objective; this one is an ablation of its *estimators*. A four-rung agent ladder (VAE → HMM → critical HMM → full deep active inference) crossed with five one-step definitions of `G` and three action-selection rules, on one environment, against a deep Q-network control. Full architecture, results and reviewed prior implementations: [[wiki/entities/deep-active-inference-agent.md]].

**The headline is negative and it is an ablation, not an opinion.** Across all three action-selection rules, the only agents that solve the task are the ones whose critic predicts `G⁴ = −ψr` — reward with the epistemic term deleted. The "principled" estimate `G = D_KL[P_θs(s_{t+1}|ŝ_t,a_t) ‖ Q_φs(s_{t+1})] − ψr` and the three entropy-difference variants all fail; one (`H[Q_φs] − H[P_θs] − ψr`) diverges to `NaN`. Adding the policy network on top — the full DAI agent — makes it worse: 14 of 15 configurations crash, and the survivor performs at the random baseline.

**The failure has a named mechanism, and it is self-consistency.** The KL above is *minimised*, and it is minimised whenever the transition network agrees with the encoder. An agent can force that by shrinking its own data distribution: pick one action forever, become expert at predicting it, KL → 0. Measured — action-prior entropy → 0, the histogram almost entirely one action, and the transition network's variance head low **only** for that action. Deleting the term restores exploration.

**(brainstorm) This is the dark-room objection arriving as a training curve.** The information-gain reading requires the divergence to enter `G` with a minus (a bonus for *expected belief change*); the deep estimator has it entering with a plus (a penalty for model–encoder *disagreement*). One usable audit follows: **if an agent that freezes its own policy can drive its epistemic term to zero, the term is a self-consistency penalty, not an information gain.** `−H(ρ_t)` and `I_a(b)` both fail that test correctly — you cannot make an occupancy spread out or a belief sharpen by refusing to act.

**A tabular experiment shows the ambiguity is in the decomposition, not only the estimator.** With `EV = E[ln P(s_τ|o_τ) − ln Q(s_τ|π)]` stored as matrices: flattening the likelihood makes `P(s|o)` approach `Q(s|π)` and `EV` fall (correct — maximising `EV` seeks informative observations); shifting the *prior* under a fixed high-entropy likelihood makes `P(s|o)` diverge from `Q(s|π)` and `EV` **also** fall (degenerate — maximising `EV` now destroys information). The epistemic/extrinsic split of Parr & Friston 2019 eq. 10, which every source above builds on, therefore has two opposite exploratory readings depending on which distribution is moving.

**And the deep estimator breaks the link to variational free energy outright.** For `G` to be the expectation of `F`, the factor `Q(s_{t+1}|a_t)` must belong to the *variational* distribution; every deep implementation surveyed, including Fountas et al. 2020, estimates it as `1/N Σ_i P_θs(s_{t+1}|ŝ_t^i, a_t)` — a factor of the **generative** model. The Nuijten identity on this page (`F_p̃ = F_p̂ + entropy corrections`) is exact for the objective; it says nothing about an estimator that has substituted `P` for `q` inside the expectation.

### What this changes for the wiki

- **The gap between the theory and the code is now the interesting object.** Three 2026 results say the objective is well-posed, derived-weight, and dominated by a parameter-novelty term. This 2023 ablation says that the version anyone actually runs is one-step, state-based, self-consistency-signed, and beaten by its own reward-only ablation. Both can be true, and the conjunction is a specification: a deep implementation that would test the theory needs depth > 1, a novelty term over `θ`, and a sign audit. None of the eight reviewed systems has all three. See [[wiki/empirical-tensions.md]] T125.
- **The confound cuts the other way too.** All five definitions here are horizon-1, which Cooper & Velasquez independently report as the regime where EFE degenerates to myopic information gain. So the paper may be measuring shallow EFE rather than EFE — which is itself a finding, since horizon-1 is what the deep literature ships.
- **Exploration and model quality are not the same objective, and the ladder separates them.** The agent that learns the transition structure best takes uniformly random actions and scores at chance; the agent that solves the task predicts the environment worse. Whatever supplies the epistemic drive must serve both, and no term on this page has been shown to.
- **"Which KL, in which direction" is a behavioural choice.** Four defensible readings of the same epistemic quantity produce four different agents, one of which is numerically unstable. [[wiki/concepts/divergence-objectives.md]]'s question is usually posed about fitting; here it decides whether the agent moves.

---

## The same objective by gradient descent — and the correction that pays depends on where the uncertainty lives

> **Fifth primary source.** `raw/nuijten-2026-efe-planning-variational-inference.md` — Nuijten, van de Laar & de Vries, arXiv:2606.20658, 2026. Same group as the third source, six weeks later, and the two are the *same result derived twice for two different optimisers*: there the corrections are entropy terms implemented as factor-graph channels and run by message passing; here they are **epistemic priors** in the denominator of an ordinary variational free energy, run by Adam on a JAX-parameterised posterior. What is new is (i) the complexity term that survives the decomposition, (ii) a plan-vs-policy ablation, and (iii) a temporal factorization that gets active inference onto a standard reinforcement-learning benchmark.

**Proposition 1.** Augment the rollout model with a preference prior `p̂(x)` *and* three epistemic priors, and assume the posterior factorizes as `q(y,x,u,θ) = q(y,θ|x) q(x|u) q(u)`:

```
F[q] = E_q[ log q(y,x,u,θ) / ( p(y,x,u,θ) · p̂(x) · p̃(u) p̃(x) p̃(y,x) ) ]

p̃(u)   ∝ exp(  H[q(x|u)] )                              → risk
p̃(x)   ∝ exp( −E_{q(θ|x)} H[q(y|x,θ)] )                 → ambiguity
p̃(y,x) ∝ exp(  D_KL[ q(θ|y,x) ‖ q(θ|x) ] )              → novelty

⇒  F[q] = E_{q(u)}[G(u)]  +  E_q[ log q(y,x,u,θ)/p(y,x,u,θ) ]  +  const
              expected plan cost            complexity
```

Each prior is exactly the negative of the entropy term it is meant to cancel, so "epistemic prior" is a bookkeeping device, not a preference — the authors say so. The priors depend on `q`, so the optimisation is a **fixed point**: minimise a free energy whose priors are functions of the minimiser. Gradient descent converges anyway on all three environments tested, which is the practical difference from the channel scheme (min-max, hand-tuned damping, ~150 iterations).

**The optimal posterior over plans carries a third term the standard formula omits.**

```
q*(u) = σ( −P(u) − G(u) − C(u) ),    P(u) = −log p(u),   C(u) = complexity of the plan-conditioned posterior
```

Friston et al. 2021 give `σ(−G)`; the variational derivation adds the plan prior *and* the belief-change cost `C(u)`. **(brainstorm)** `C(u)` is a bias toward plans the agent's current beliefs already support — a laziness term with the same shape as the description-length penalty [[wiki/concepts/universal-induction.md]] pays for hypotheses. It is the one term on this page that argues *against* exploration, and it appears for free.

### Plans vs. policies: the ablation that separates the two corrections

Three environments, chosen so that each isolates a different failure. `F_marginal` = VFE + preference prior only (KL control). `F_planning` = `F_marginal` + the Lázaro-Gredilla action-entropy correction (the wiki's *cross-entropy planning* rung). `F_active` = full epistemic priors. Standard EFE planning and Sophisticated Inference are tabular pymdp baselines.

| Environment | What is unknown | `F_marginal` | `F_planning` | `F_active` | Standard EFE (plan-based) | Sophisticated Inference |
|---|---|---|---|---|---|---|
| T-maze (deterministic) | latent context `θ` behind a cue | 48% | 52% | **100%** | 100% | 100% |
| Reactivity Maze (stochastic) | `θ` + which action works depends on realised state | 0% (safe sink) | 17% | **100%** | 61% (cue 66%) | 94% |
| MiniGrid DoorKey-8×8 (partially observable, `T=20`) | key/door locations, revealed by a 3×3 field of view | 4% | **89%** | **89%** | cannot run | cannot run |

Read the columns, not the bold: **the two corrections are necessary in disjoint regimes, and neither subsumes the other.**

| Regime | Which correction pays | Why |
|---|---|---|
| Uncertainty concentrated in a latent parameter resolved by a *dedicated* probe (cue) | epistemic priors (`F_active`) | nothing else can anticipate that a detour will resolve `θ`; cue-visit rate is 0% without them |
| Long-horizon multi-step coordination under partial observability, uncertainty resolved *incidentally* by moving | the action-entropy planning correction (`F_planning`) | `4% → 89%`; without it the agent cannot chain find-key → unlock → goal. Epistemic priors "neither help nor hinder" here |

This is a direct qualification of the third source's ranking, where the planning correction was worth `51.9 → 54.5%` and novelty carried everything. Both measurements are from the same group; they disagree because the environments put the uncertainty in different places. See [[wiki/empirical-tensions.md]] T126.

**The plan-vs-policy result is the part with an architectural consequence.** A *plan* is a fixed sequence `u = (u_1,…,u_T)`; a *policy* is `q(u_t|x_{t-1})`. Under stochastic transitions, plan-based EFE evaluation systematically undervalues an action whose worth lies in what it *enables*: if `u_1` leads to either of two intermediate states, each requiring a different follow-up, then both `(u_1, u_2^{(1)})` and `(u_1, u_2^{(2)})` score badly in isolation and `u_1` inherits their cost. Inference over the *joint* posterior and marginalising —

```
q(u_t|x_{t-1}) = q(u_t, x_{t-1}) / q(x_{t-1})
```

— prices `u_1` against *all* future trajectories paired with the responses the agent would make, so contingency is recovered without recursive belief modelling. Measured: Reactivity Maze, plan-based Standard EFE visits the cue in 66% of episodes because it cannot anticipate being able to react to what the cue says; `F_active` and Sophisticated Inference visit it in 100%. **The agent must be able to represent that it will still be able to choose later, or information-gathering does not look worth it.**

**Scalability comes from temporal factorization, and it is what gets EFE onto a benchmark.** The tabular joint posterior is exponential in the horizon (180,256 parameters for a five-state T-maze at `T=4`). Imposing the generative model's own Markov structure on the posterior —

```
q(y,x,u,θ) = q(θ) Π_t q(u_t|x_{t-1}) q(x_t|x_{t-1},u_t,θ) q(y_t|x_t,θ)
```

— makes it linear in `T`, *and* the factor `q(u_t|x_{t-1})` is literally the reactive policy. DoorKey-8×8 at `T=20` runs; Standard EFE planning and Sophisticated Inference cannot be instantiated there at all, because both enumerate states and observations.

### What this changes for the wiki

- **"EFE needs tree search" is retired.** Two independent variational routes now run the same objective without enumeration: message passing with channel kernels, and plain gradient descent on a factorized posterior. The remaining obstacle to a deep implementation is the estimator defect (fourth source), not the search.
- **The policy/plan distinction is a *representational* requirement on the planner, not a search heuristic.** It costs nothing extra — the same joint posterior, marginalised differently — and it is what makes epistemic value survive stochasticity. Any rollout scorer in the wiki that evaluates fixed action sequences ([[wiki/concepts/simulation-based-planning.md]]'s model-predictive-control row, H-JEPA's action-sequence optimisation) inherits the same underestimation.
- **The epistemic term *did* pay here, in a gradient-based implementation.** `F_active` beats every ablation on both environments where the unknown is a latent parameter, and beats Sophisticated Inference (100% vs 94%) on the stochastic one. This is the first entry in the wiki where a gradient-optimised epistemic term earns its place — narrowing [[wiki/empirical-tensions.md]] T125 to *neural amortised one-step estimators* rather than gradient optimisation as such.

---

## Sixth primary source: the terms are separately localised in the human brain — and only their *values* are, not their magnitudes

> **Sixth primary source.** `raw/zhang-2025-novelty-variability-active-inference.md` — Zhang, Tian, Liu & Wu, *eLife* 13:RP92892, 2025. The first five sources are analyses or ablations of the objective in silico. This one asks whether the decomposition is *real in a brain*: N=25 human electroencephalogram (EEG), a contextual two-armed bandit in which information carries an explicit price, Bayesian-information-criterion (BIC) model comparison of active inference against model-free and model-based reinforcement learning, and per-timepoint linear regression of source-space induced power onto each term of `G` separately.

**Task.** Two choices per trial, 120 trials. First choice: `Stay` (free, no information) vs. `Cue` (`−1` reward, reveals the current context of the risky path). Second choice: `Safe` (`+6` always) vs. `Risky` (`0/3/6/9/12`, distribution set by the hidden context, which resamples every trial). Context 1 pays `[+12 55%, +9 25%, +6 10%, +3 5%, 0 5%]`, Context 2 the mirror image. The design is what makes the ingest worth doing: **the price of information is a task parameter, the hidden state is resampled each trial (so variability never decays), and the model parameters are learned across trials (so novelty does)** — the two uncertainties of T124 are put on different timescales inside one task and can therefore be regressed separately.

| Model | Free parameters | BIC |
|---|---|---|
| **Active inference** (Eq. 9, coefficients on all three `G` terms + `α`) | 4 | **best** |
| Model-based reinforcement learning | `α, γ`, prior | worse |
| Model-free reinforcement learning | `α, γ` | worst |

The behavioural signature the fit is carrying: participants **paid for the cue far more often than they stayed**, which a reward-only learner has no reason to do. The fitted coefficients are *precisions* in the sense of [[wiki/concepts/precision-weighting.md]] — one scaling novelty-seeking, one scaling variability-avoidance, one the learning rate — and they vary widely across the 25 participants, so "how much epistemic drive" is an individual-differences parameter, not a constant of the objective.

### The localisation table

Each row is a separate per-timepoint regression of source-space induced power on one regressor, FDR-corrected. **Every reported significant correlate has a negative mean *t*** (higher regressor value → lower induced power); the paper does not comment on the sign.

| Stage | What the agent is doing | Regressor | Peak region (mean *t*) |
|---|---|---|---|
| First choice | pay for information? | **expected free energy** | **frontal pole** (−3.23); superior temporal gyrus |
| First choice | " | value of reducing **variability** | **medial orbitofrontal cortex** (−3.08); post-/precentral gyrus |
| First choice | " | extrinsic value | middle temporal gyrus |
| First result | belief update over the **hidden state** | reducing variability | **medial orbitofrontal cortex** (−3.00); rostral middle frontal, lateral orbitofrontal |
| Second choice | safe vs. risky | **expected free energy** | **rostral middle frontal gyrus** (−4.82, `p<0.001`); caudal middle frontal, middle temporal |
| Second choice | " | value of reducing **novelty** | rostral middle frontal gyrus (−3.07); superior frontal, insula, lateral orbitofrontal |
| Second choice | " | extrinsic value | rostral middle frontal gyrus (`p<0.001`) |
| Second choice | " | **degree** of novelty | **nothing survives FDR** |
| Second result | belief update over **parameters** | reducing novelty | **precentral gyrus** |
| Second result | " | prediction error | bank of superior temporal sulcus, inferior temporal, lateral occipital |

Three readings a builder should take:

- **The two uncertainties have different addresses.** Variability (hidden state) is orbitofrontal at both its valuation and its update; novelty (parameters) is rostral middle frontal at valuation and **precentral** at update. That is a *learning-rate-carrying* separation, not a relabelling: the same architecture updates `q(s)` and `q(θ)` in different tissue, which is the anatomical form of the freeze-`θ`-during-planning split that makes novelty additive (Nuijten et al. 2026, above).
- **`G` beats its own reward term as a neural regressor** in both choice stages, and in the second choice it does so at `p<0.001` where extrinsic value alone is also strong — the integrated quantity tracks cortex better than the pragmatic half does. This is the wiki's only evidence that the *sum* rather than the reward term is the quantity a brain carries into action selection.
- **Extrinsic value's correlate appears *earlier* in the epoch than expected free energy's.** The authors read this as reward-first, then integration with information value. **(brainstorm)** If that ordering is real it is an architectural constraint the wiki has nowhere else: `G` is not computed as one expression but *assembled*, pragmatic term first, epistemic term arriving late enough to be interruptible. A deep implementation with a one-shot `G`-head ([[wiki/entities/deep-active-inference-agent.md]]) cannot express that, and the failure mode of those heads — the epistemic term dominating into policy collapse — is exactly what a late, additive, low-precision epistemic contribution would prevent.

### The null that matters: value of resolving, not amount of uncertainty

The degree of novelty has **no** surviving correlate; the degree of variability likewise. What is encoded is the *value of reducing* each. This cuts against the wiki's default reading of [[wiki/concepts/precision-weighting.md]], where uncertainty is a first-class represented quantity with its own substrate (synaptic gain) — here the represented object appears to be an epistemic *value*, i.e. uncertainty already multiplied by what resolving it is worth. See [[wiki/empirical-tensions.md]] T127. The paper's own caveat is the honest one: the task did not parametrically vary uncertainty magnitude, so this is a null under low power, not a demonstration of absence.

### What this changes for the wiki

- **T125 gains a data point on a system that is not an agent.** Every prior entry asks whether the epistemic term improves *task performance*; this one asks whether it improves *fit to a biological decision-maker*, and it does. Those are different claims and the paper is explicit about why the second is weak: under the **complete class theorem** (Wald 1947), any behaviour–reward pair is describable as ideal Bayesian decision-making under *some* prior, so a BIC win over reinforcement learning licenses "there exist priors reproducing this behaviour" and nothing stronger. That is the same non-identifiability Cooper & Velasquez prove for the objective, conceded in advance by an author who benefits from ignoring it — see [[wiki/concepts/objective-identifiability.md]].
- **Sensor-level result runs against the exploration literature's sign.** Amplitude was *greater* in the second half of the experiment (low novelty) across left/right frontal, central and left parietal clusters, whereas late-positive-potential studies report greater response under *high* novelty. The definitions differ — perceptual discriminability there, expected information gain here — but the disagreement is not resolved, only named.
- **Theta tracks state uncertainty specifically.** Not-asked trials (hidden state unknown) show higher theta-band power than asked trials, alongside frontal and central amplitude differences. The wiki's only frequency-band handle on which of the two uncertainties a circuit is carrying.
---

## The same disagreement signal is a working exploration reward and a failing replay priority

> `raw/kessler-2023-world-models-continual-rl.md` — Kessler et al. 2023 ([[wiki/entities/continual-dreamer.md]]). Not an active-inference system: the epistemic quantity is Plan2Explore's **latent disagreement**, the variance of a deep ensemble predicting the next RSSM features `[z_{t+1}, h_{t+1}]`, added to the model-predicted extrinsic reward as `r = α_i r_i + α_e r_e` (`α_i = α_e = 0.9`).

Two things this page did not have.

**A use for an epistemic term that is not exploration-for-reward: it removes a task-boundary oracle.** Every prior continual-reinforcement-learning exploration strategy resets a schedule when the task changes — `ε`-greedy per task, an entropy regulariser per task — and therefore needs to be told. Model disagreement rises when the environment changes *because* it changed, so the same signal that drives exploration also implicitly detects the boundary. That is an argument for an epistemic term that does not depend on it paying against reward, and it is the strongest one on this page.

**And it pays inconsistently, in a direction the page should record.** On 3-task Minigrid the bonus *costs* 0.26 average performance (0.72 → 0.46). On 8-task Minihack — larger state spaces, harder skills — it *gains* 0.19 (0.09 → 0.28) and cuts forgetting from 0.37 to 0.13. Sign flips with task difficulty, on the same architecture and the same intrinsic reward.

**The sharp result is the asymmetry of use.** The identical uncertainty quantity, used to weight *which stored episodes the world model trains on* (uncertainty sampling), performs at the level of the non-continual baseline — worse than uniform sampling on every metric. So `r_i` is a good thing to act on and a bad thing to rehearse on. **(brainstorm)** The mechanism is plausible and untested: an exploration bonus is consumed the moment it is acted on, whereas a replay priority is *persistent* — the buffer keeps re-presenting whatever the model could not predict, which is disproportionately the noise it will never predict. Any architecture that reuses one uncertainty estimate for both jobs (and the natural expected-free-energy agent does) inherits this, and the fix is a decay on the epistemic weight in the replay path that nothing in the wiki has.

---

## Open problems

- **The epistemic value in the theory is over *states*; the epistemic value that pays is over *parameters*.** Parameter-novelty is excluded from the convex-MDP result and named there as a separate problem, and the ρ-POMDP identity scores information gain about a belief over a *fixed* hidden state. Ablated across three grid-worlds, information gain about `θ` accounts for nearly the whole performance gap wherever sensing actions do not alter the sensor ([[wiki/empirical-tensions.md]] T124).
- **Novelty is additive only because learning is frozen during planning.** Per-step novelty decomposes from the global information gain about `θ` only if backward messages into `θ` are withheld during the rollout. Let the structural belief update inside the rollout and per-probe information gains double-count and stop summing. Nothing says what a *continual* agent — which must update `θ` — should do instead.
- **The channelised scheme has no convergence theory.** Opposing correction signs make the joint optimisation over beliefs and channels min-max; belief-propagation guarantees do not transfer, damping is required, `λ` is hand-set per environment, and convergence takes ~150 iterations. The wiki's cleanest derived exploration drive is also its least stable optimiser.
- **No neural implementation has ever shown the epistemic term paying its way.** Across five one-step estimators × three action-selection rules × two agent depths, the reward-only ablation wins every time, and the full deep active-inference agent crashes in 14 of 15 configurations. The confound cuts both ways: all five definitions are horizon-1, which is independently the regime where the objective degenerates to myopic information gain — so this may be a measurement of *shallow* epistemic value rather than of epistemic value.
- **The term's *sign* is not standardised and is not checked.** Written as a bonus for expected belief change it drives exploration; written as a penalty for disagreement between the forward model and the encoder it drives policy collapse. Both appear in published implementations under the same name.
- **The deep estimator is not the objective.** For `G` to be the expectation of `F`, the factor `Q(s_{t+1}\|a_t)` must belong to the *variational* distribution; every deep implementation surveyed estimates it from a factor of the **generative** model. The exact identities on [[wiki/concepts/expected-free-energy.md]] therefore say nothing about the estimators that are actually run.
- **The derived weight optimises reward, not accuracy.** The success-maximising weight is 20–200× the derived one on every environment tested, so an agent that must be *right* rather than *profitable* has no derivation to appeal to — and tuned weights transfer catastrophically across environments while `w = 1` does not.
- **The epistemic drive does not survive discounting.** Its advantage over reward-only planning requires `γ ≥ 0.99` when several observation actions are available, and reverses at `γ = 0.90`. Every deep implementation in the wiki discounts.
- **The two corrections have no joint theory, only a pair of environments each.** The action-entropy planning correction is worth `+2.6%` in one paper's grid-worlds and `+85%` in the other's DoorKey; the epistemic priors are worth everything in the first and nothing in the second. Both results are from the same group. Nothing predicts which correction a new environment needs, and the only available discriminator — where the uncertainty *lives* — is a property of the environment that an agent must itself infer.
- **The complexity term `C(u)` is derived and then never studied.** In `q*(u) = σ(−P(u) − G(u) − C(u))` it penalises plans requiring large belief change — i.e. it opposes exploration — and every EFE agent in the wiki omits it.
- **The epistemic priors are functions of the posterior they weight**, so planning is a fixed-point problem rather than a minimisation. Gradient descent converges empirically on three environments and there is no proof.
- **Plan-based scoring is wrong under stochastic dynamics, and nothing says how deep the contingency must be represented.** Marginalising a joint posterior recovers within-horizon adaptability for free; what it does not say is when a full recursive belief model is nonetheless required.
- **The brain appears to encode the *value of resolving* uncertainty but not its *degree*.** Regressing source-space power on the degree of novelty yields nothing surviving FDR correction, while the value of reducing it does — which cuts against the wiki's default reading of [[wiki/concepts/precision-weighting.md]], where uncertainty is a first-class encoded quantity.
- **Every human neural correlate of `G` and of its terms is *negative*** (higher value → lower induced power), and no source comments on the sign. Until it is explained, the localisation table supports *separation* of the terms and not their polarity.
- **The terms may be assembled in sequence rather than computed at once.** Extrinsic value's correlate precedes expected free energy's within the choice epoch. Nothing in any formulation on either page has a temporal order; every one computes `G` as a single scalar.

---

## Connections

- **[[wiki/entities/continual-dreamer.md]]** — the epistemic term's one unambiguous payoff in the wiki: model disagreement rises when the environment changes, so it supplies continual exploration with no task-boundary oracle — alongside the finding that the same quantity is harmful when used to prioritise replay instead of action.
- **[[wiki/concepts/expected-free-energy.md]]** — the objective this page ablates. That page derives what the epistemic term *is* (`Φ`, and `I_a(b)` at weight `w = 1`) and proves what class of optimisation problem it makes; this page holds the four literatures asking whether switching it off changes anything, and the answer differs from the derivation in both the quantity (E3, not E1/E2) and the verdict.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the other half of the alternation: variational free energy fits the model to collected data, and every epistemic quantity here is defined over a distribution that fitting produced. The `q`-vs-`p` substitution that breaks the deep estimator is a failure to keep that distinction.
- **[[wiki/entities/deep-active-inference-agent.md]]** — the agent ladder the negative result comes from: full architecture, five estimator definitions, three action-selection rules, and the reward-only ablation that beats all of them.
- **[[wiki/concepts/precision-weighting.md]]** — the fitted coefficients on the three `G` terms are precisions, and the human study's null (value encoded, degree not) is a direct constraint on how precision can be represented.
- **[[wiki/concepts/divergence-objectives.md]]** — "which KL, in which direction" is usually asked about fitting; here it decides whether the agent moves at all, and four defensible readings of one epistemic quantity produce four different agents, one numerically unstable.
- **[[wiki/concepts/simulation-based-planning.md]]** — the plan-vs-policy result is a representational requirement on the rollout: scoring a fixed action sequence systematically undervalues an action whose worth depends on a response the agent has not yet chosen.
- **[[wiki/concepts/latent-graph-discovery.md]]** — why E3 is the relevant quantity for this wiki: the unknown is the graph, which enters the generative model as a parameter, so the epistemic term a graph-discovering agent needs is the one both theory results exclude.
- **[[wiki/concepts/cognitive-control.md]]** — the localisation table's architectural payload: the two uncertainties have different addresses (orbitofrontal for state variability, rostral middle frontal for parameter novelty, precentral at parameter update), which is a controller factorised by *what kind of uncertainty* rather than by task.
- **[[wiki/concepts/meta-learning.md]]** — freezing `θ` during the rollout is what makes per-step novelty additive, and it is the same slow/fast split: the parameter belief is the slow level and must be held still while the fast level plans over it.
- **[[wiki/concepts/multi-horizon-value-learning.md]]** — what the discount factor *means* when it truncates the epistemic term: `γ = e^{−λ}` is a per-step survival probability, so discounting below the number of observations a confident commit needs is the belief that the agent will not live to spend the information (Fedus et al. 2019, via Sozou 1998).

- **[[wiki/entities/world-models-vmc.md]]** — the cheapest exploration bonus in the wiki and the one with no extra machinery: negate the world model's own predictive loss in the real environment, so the objective that fits the model is also the signal that decides where to collect (proposed, not measured).
