# Expected Free Energy

**The active-inference planning objective: score an imagined future by how far its observations fall from a preference distribution *and* by how uncertain the agent still is about it — and, once written over state-action occupancies, it is a reward-maximisation problem plus exactly one nonlinear term.**

Where [[wiki/concepts/predictive-coding-free-energy.md]] holds *variational* free energy (VFE) — the perception/learning objective, minimised over the model given data — this page holds *expected* free energy (EFE): the same currency evaluated over trajectories the agent has not taken yet, minimised over the **policy**. The two alternate: VFE fits the world model to collected data, EFE optimises the policy against that model in imagination.

> **Primary source.** `raw/milosevic-2026-active-inference-convex-mdp.md` — Milosevic, Hinrichs & Scherf, arXiv:2607.20152, 2026. Its contribution is structural, not empirical: it identifies *what kind of optimization problem* EFE minimisation is, which had not been settled (existence, uniqueness, and the class of the minimum were all open), and thereby imports the reinforcement-learning toolbox — convergence rates, policy-improvement guarantees — into active inference.

---

## The decomposition: linear reward + one convex term

Setting: finite-horizon reward-free POMDP `M = (S, A, O, P, E, σ)`. The agent holds a variational world model `m = (p, ν)` — generative `p`, recognition density `ν` — and deploys the **composed** behaviour policy `β(a|o) = Σ_s π(a|s) ν(s|o)`: infer the latent state, then act on it. Planning is over `π` alone; `Π` does not depend on the model.

Imagined trajectory law (ancestral, hence Markov and cheaply sampled):

```
q^π(τ) = q_0(s_0) p(o_0|s_0) Π_t π_t(a_t|s_t) p(s_{t+1}|s_t,a_t) p(o_{t+1}|s_{t+1})
ρ_t^π(s) = P_{q^π}(s_t = s)              predictive state marginal
μ_t^π(s,a) = ρ_t^π(s) π_t(a|s)           state-action occupancy
```

EFE and its per-step integrand:

```
G(π;m) = Σ_t E_{q^π}[ g_t(s_t,o_t) ]
g_t = log ρ_t^π(s_t)  −  log ν(s_t|o_t) − log p(o_t|s_t) − log p̃(o_t)
       └ epistemic ┘    └──────────── −log p̃(s_t,o_t), the "biased model" ────────────┘
```

**Lemma (occupancy form).** `G(π) = Γ(μ^π) = ⟨ℓ, μ^π⟩ + Φ(μ^π)`, with

| Term | Definition | Type |
|---|---|---|
| `ℓ_t(s,a) = −E_{o∼p(·\|s)} log p̃(s,o)` | pragmatic + ambiguity + recognition | **linear** in `μ` — an ordinary reward in a latent MDP |
| `Φ(μ) = −Σ_t H(ρ_t^π)` | negative state-marginal entropy | **convex**, not strictly — the *only* nonlinearity |

Everything that distinguishes active inference from reinforcement learning is `Φ`. Drop it and EFE minimisation *is* reward maximisation on the latent state space.

**The epistemic term is mutual information only at convergence.** `−H(ρ_t)` stands in for `−I_t(S;O)` because `ν` is held fixed during planning; substituting the exact posterior `p(s|o)` — which is what VFE-optimality delivers, since the recognition gap in `F(m;D) = surprise + E D_KL(ν‖p(s|h))` is exactly zero there — recovers the classical information-gain reading. So the convex-MDP structure does not cost the information-theoretic interpretation; the two names refer to the same term at different points of the loop.

**The structure is robust to the variant.** All four EFE variants in circulation share `linear + negative entropy`:

| Variant | Integrand | Nonlinearity |
|---|---|---|
| Information gain (observation preference) | `log ρ_t − log p(s_t\|o_t) − log p̃(o_t)` | `Φ` |
| Approximate information gain (variational future inference) | `log ρ_t − log ν(s_t\|o_t) − log p̃(o_t)` | `Φ` |
| Risk–ambiguity (state preference) | `log ρ_t − log p(o_t\|s_t) − log p̃(s_t)` | `Φ` |
| + action complexity `log π_t(a\|s)/π̄_t(a\|s)` | any of the above | `R = Φ + Ψ` (state-action neg. entropy) |

They differ only in the linear cost `ℓ` and in whether the entropy is over states or over state-actions. The action-complexity row is the control-as-inference / deep-active-inference term, and it is what keeps the optimum **interior** (a joint-entropy barrier) — without it the softmax update can never populate an action it currently plays with probability zero.

---

## Why "convex MDP" is the right name, and what it costs

The occupancies cannot roam the simplex: they must satisfy Chapman–Kolmogorov flow constraints

```
Σ_a μ_0(s,a) = q_0(s),      Σ_{a'} μ_{t+1}(s',a') = Σ_{s,a} p(s'|s,a) μ_t(s,a)
```

whose feasible set `K` is a compact convex polytope, and `π ↦ μ^π` is a bijection onto its interior. So `min_π G(π) ≡ min_{μ∈K} Γ(μ)`: a **convex program over policy-induced occupancies** — the convex / general-utility / concave-utility MDP class.

| Consequence | Statement |
|---|---|
| **Existence and global optimality** | `Γ` convex on a compact convex polytope: a minimum exists, and any first-order stationary point is global |
| **No global value function** | The per-step reward depends on `ρ_t`, i.e. on the policy itself, so Bellman optimality does not hold and a single `V` cannot represent the objective. This is the price of the nonlinearity |
| **Not strictly convex** | `−H(Σ_a μ(·,a))` is convex but flat in directions that leave `ρ` unchanged, so **uniqueness in `μ` is not obtained** — only in `ρ` |
| **Independent of the details** | Holds for every EFE variant, for history-dependent policies (augment the state to `x = (h,s)` — the same augmentation Dreamer-style recurrent world models already perform), and under fixed parameter uncertainty |

**Infinite horizon forces a modelling choice, because entropy does not commute with time aggregation.** Aggregating time is unavoidable (otherwise the decision variable is infinite-dimensional), but `H(d^π) ≥ (1−γ) Σ_t γ^t H(μ_t^π)` by Jensen, with equality only when all `μ_t^π` coincide. So there are two genuinely different objectives — entropy *after* aggregation (`G^agg`, one entropy of the discounted occupancy) versus entropy *per step then aggregated* (`G^step`) — crossed with discounted vs stationary averaging. **This is a hidden degree of freedom in every deep active-inference implementation**: the "epistemic bonus" means something different depending on where the time average is taken, and the `agg` form rewards visiting different states *across* time while the `step` form rewards uncertainty *at each* time.

---

## MD-AIF: solving it by soft dynamic programming

Mirror descent linearises `Γ` at the current occupancy, turning the convex MDP into a sequence of ordinary **soft** MDPs whose reward is recomputed each iteration:

```
μ^{k+1} ∈ argmin_{μ∈K} { ⟨∇Γ(μ^k), μ⟩ + η^{-1} D_Ψ(μ‖μ^k) },
D_Ψ(μ‖μ^k) = Σ_{t,s} ρ_t(s) D_KL( π_t^μ(·|s) ‖ π_t^{μ^k}(·|s) )      Ψ = conditional negative entropy
```

With that Bregman generator the update has a **closed form** — exactly a soft-Bellman backup:

| Step | Update |
|---|---|
| Forward | `μ_{t+1}(s') ← Σ_{s,a} p(s'\|s,a) π̄(a\|s) μ_t(s)` |
| **Linearised reward** `r = −∇Γ(μ)` | `r_t(s,a) ← E_o log p̃(s,o) − log ρ_t(s) − 1` |
| Backward (soft value iteration) | `Q_t(s,a) ← r_t(s,a) + Σ_{s'} p(s'\|s,a) V_{t+1}(s')`;  `V_t(s) ← η^{-1} log Σ_a π̄(a\|s) exp(η Q_t(s,a))` |
| Mirror step (multiplicative) | `π_t(a\|s) ← π̄(a\|s) exp(η Q_t(s,a)) / Σ_{a'} π̄(a'\|s) exp(η Q_t(s,a'))` |

**Three things to take from the reward line.** (i) It splits into a *fixed* preference reward `E_o log p̃(s,o)` and a *variable curiosity bonus* `−log ρ_t(s)`: the agent is paid, at every iteration, for putting occupancy where its own current plan does not. (ii) The bonus is recomputed between iterations, which is what "policy-dependent (performative) reward" means concretely. (iii) The resulting subproblem is soft RL + maximum-entropy exploration — two objectives the RL literature already solves separately, here derived rather than combined by hand.

**Rate and identity.** `Γ` is `L`-smooth relative to `Ψ` with `L = ½T(T+1)`, giving `min_k G(π^k) − G(π*) ≤ L·D_Ψ(μ*‖μ^0)/(K+1) = O(1/K)`. To second order `D_Ψ` is the squared Riemannian norm under the Fisher metric `F^k = ⊕_{t,s} ρ_t(s)·diag(π_t^k(·|s))^{-1}`, so **MD-AIF is Kakade's natural policy gradient on the EFE** — the multiplicative softmax update is the first-order expansion of the natural gradient step. Note the horizon dependence: `L ∝ T²`, so the step size must shrink quadratically in the planning depth.

**Experiments (deterministic gridworlds, tabular).**

| Test | Result |
|---|---|
| 5×5 grid, Manhattan-distance preference | MD-AIF tracks the theoretical `O(1/K)` line and reaches a lower EFE than entropy-regularised RL or Euclidean gradient descent on the EFE |
| Imagined occupancy `ρ_t` at convergence | MD-AIF **spreads mass across the grid before concentrating on the goal**; RL channels mass straight down the direct path |
| 10×10 grid, uniform preference (pure epistemic drive), model refit interleaved | MD-AIF reduces model error `TV(p̂,p*)` faster per environment step than RL, EFE gradient descent, or short-horizon (`T = 3–5`) myopic AIF planning |

The second and third rows are the same fact seen twice: the epistemic term buys **state coverage**, and coverage is what makes the world model identifiable. This is the wiki's clearest instance of an agent whose exploration objective is *derived from* its inference objective rather than bolted on as an `ε`-greedy or count-based bonus.

---

## Closing the loop makes active inference performative

The convex-MDP result holds **for a fixed model**. The full loop is

```
π --deploy--> D(π) --VFE--> m(D(π)) --EFE--> π(m(D(π))) =: AIF(π)
```

so after deployment the agent refits `m` to data *its own policy* induced: both the linear cost `ℓ_π` and the transition kernel `P_π` become functions of the deployed policy. This is **performative reinforcement learning** — and the decision-dependence runs through the agent's own model-learning step, not through any response of the environment.

| Result | Content |
|---|---|
| **Existence** | Under a support floor on the tabular model class (`p(s'\|s,a) ≥ ε_0`) and continuity of `π ↦ m`, the performative mirror operator `P` is a continuous self-map of a compact convex polytope, so Brouwer gives a **performatively stable** `π* = P(π*)`: a policy already optimal for the model its own deployment produces |
| **Fixed points are inner-optimal** | At `π*` the multiplicative update is inactive, so `Q^{π*}` is constant on the support and (56) is the variational inequality `⟨∇Γ_{π*}(μ^{π*}), μ − μ^{π*}⟩ ≥ 0` — sufficient for global optimality by convexity. Without action complexity this only holds *on the support*, since a multiplicative update cannot revive an unplayed action |
| **Convergence: open** | Left to future work. Suggested routes: dataset aggregation (reduction to online learning), or mixed delayed repeated retraining |
| **When it would be easy** | Well-specified tabular model + exact recognition + **state coverage under every deployed policy**. Then the refit target is policy-independent and the loop is a one-way cascade of two contractions |
| **Why that fails** | Coverage is exactly what breaks in the complex environments where active inference is interesting. The epistemic drive *pushes* mass onto under-visited states but **certifies no uniform coverage floor**, and parameter-novelty terms add further `π`-dependence. The cascade can then close into an unstable feedback loop |

**This is gap G25 met from the active-inference side.** That row records that no optimality certificate exists for an agent whose actions shape its data. This source neither refutes nor escapes it: it converts the question into a fixed-point problem, proves the fixed point *exists*, and localises the obstruction to a single missing quantity — **a lower bound on state coverage induced by the deployed policy**. An epistemic term that came with such a floor would turn the whole loop into a contraction. None does.

---

## The epistemic term is an information-gain bonus at a *derived* weight — and only that

> **Second primary source.** `raw/cooper-2026-efe-belief-dependent-utility.md` — Cooper & Velasquez, arXiv:2607.16981, 2026. Where Milosevic et al. classify the optimisation problem, this source identifies the *objective itself* with an older, plainer one and then measures what the identification is worth: EFE minimisation **is** a ρ-POMDP whose belief-dependent utility is expected information gain, entered at coefficient `w = 1`.

**Proposition 1 (observe-then-commit POMDPs).** With actions partitioned into observation actions `A_obs` (cost `c_k`, belief update, hidden state unchanged) and terminal commit actions `A_com`, recursive EFE

```
G(observe_k) = c_k − I_k(b) + E_o[ min_a G(a | b'_o) ]        I_k(b) = H(b) − E_{o|k}[H(b'_o)]
G(commit_i)  = −E_b[R_i]
```

is, under `V ≜ −G`, exactly the ρ-POMDP Bellman recursion `V*(b) = max_a { R(b,a) + ρ_EFE(b,a) + E_o[V*(b'_o)] }` with

```
ρ_EFE(b,a) = I_a(b)  for observation actions,   0  for commit actions.
```

**So EFE = Planning+InfoGain at `w = 1`, exactly.** The paper is explicit that this does not *eliminate* the exploration weight — it derives one. The coefficient is 1 because the variational bound puts pragmatic and epistemic value in the same unit (nats); in bits it would be `1/ln 2 ≈ 1.44`, and the reward-optimal basin is broad enough (`w ∈ [0.5, 2]` near-identical) that the unit choice is practically irrelevant.

**Proposition 3 (how far the identity reaches).** It holds in any **factored observation POMDP**: state `s = (s_vis, s_hid)` with `s_vis` observable, and every observation and navigation action leaving `s_hid` fixed, `T_hid(s'|s,a) = δ(s'=s)`. Then the transition–observation coupling `Δ_T(b,a) = D_KL[b'_{o,T} ‖ b'_o]` vanishes and `ρ_EFE = I_a(b)`. It **fails** wherever information-gathering changes what is being measured — destructive testing, biopsy, active intervention, moving targets, quantum measurement. For slowly drifting hidden state the error scales with the per-step transition entropy `H(s'_hid | s_hid, a)`; the acceptable regime is unquantified.

**Proposition 2 (when `w = 1` is the *right* weight).** Two states, uniform prior, one observation action of accuracy `p` and cost `c`, commit rewards `R⁺` / `R⁻ = −αR⁺`, `I_max = ln 2 − H_post(p)`:

```
w*_thresh = [ c − (p − ½)(1 + α) R⁺ ] / I_max
```

Observation is worth taking for any `w > w*_thresh`, and `w*_thresh < 0` — so *any* positive weight suffices — whenever the **reward asymmetry** `α = |R⁻|/R⁺` exceeds `c/[(p−½)R⁺] − 1`. High asymmetry (`α ≥ 5`: Tiger, Diagnosis, Tileworld) puts `w = 1` far above threshold. Symmetric penalties (`α ≈ 1`) put it above the reward-optimal weight, and the agent over-explores.

### What the measurements say

Six observe-then-commit environments, four RockSample instances, and a new Structural Inspection benchmark (`|S|` up to 65,536); 1,000 episodes × 5 seeds; all agents share belief-update machinery and tree-search depth, differing only in `ρ`.

| Finding | Number |
|---|---|
| `w = 1` sits at the **Pareto knee** of the success–reward frontier on every environment | Reward-maximising `w*_ret ∈ [0.5, 1]`; success-maximising `w*_succ ∈ [20, 200]` |
| Advantage over reward-only planning grows with state-space size | Tileworld 8×8: 66.5% vs. 2.5% success |
| …and with the number of observation actions | RockSample[7,8]: `+19.57` vs. `+11.75` reward (`+7.82`) |
| Tuned additive bonuses over-explore, and depth amplifies the error | Diagnosis at `w = 100`: 13.21 tests, 99.3% success, `−3.63` reward vs. EFE's 9.73 tests, 97.1%, `−1.50` |
| Tuned weights **transfer catastrophically**; `w = 1` does not | `w*_succ` varies 5× across four environments; every transferred weight underperforms `w = 1` on at least one target |
| The pragmatic term is not optional | Epistemic-only ablation commits at chance (50.1% Tiger, 25.1% Bandit, 0.0% Tileworld) |
| The identity's *practical* value is conditional | `w = 1` is reward-near-optimal in only 9 / 22 / 32 % of 100 random two-state environments at `H = 1 / 2 / 3` |
| Discounting destroys the advantage | Diagnosis: `+7.8 pp` over planning at `γ = 1.0`, `+1.0 pp` at `γ = 0.95`, **`−1.6 pp` at `γ = 0.90`** — discounting truncates the horizon below the number of observations a confident commit needs |
| EFE as an **MCTS leaf heuristic** beats semi-informed rollouts at matched compute | Tiger `H = 10`: 97.2% vs. POMCP 89.7%; Tileworld 6×6: 96.0% vs. 2–15% |
| Robustness to a misspecified observation model is graceful, asymmetrically | ±0.15 accuracy error: Tiger stays >96.7%; *over*estimating accuracy hurts more (premature commit) |

**Where EFE is not recommended by its own authors:** symmetric penalties (`α ≈ 1`), navigation-style POMDPs where observation is tied to translation and a greedy mover already gets informative feedback, model misspecification beyond ±0.15, `H = 1` (it degenerates to myopic information gain), and `γ < 0.99` with multiple observation actions.

### What this changes for the wiki

- **The stopping rule is the finding, not the weight.** The agent commits when the value of committing exceeds the value of observing, a crossover that appears without tuning. This is the first *runtime-computable* answer in the wiki to the "when is the answer good enough" half of gap G15 — and it is one scalar comparison, not a metacognitive estimator.
- **The over-exploration failure is diagnostic.** Tuned bonuses reach higher success and *lose* reward, and planning depth amplifies the miscalibration (`w = 100` on Bandit: 12.41 inspections at depth vs. 10.99 myopic). An additive epistemic bonus and a derived one differ mainly in *when they stop*.
- **The two "epistemic terms" in this page are not the same object.** Milosevic's `Φ = −Σ_t H(ρ_t^π)` pays for *spreading* the predictive state marginal; Cooper's `I_a(b) = H(b) − E_o[H(b'_o)]` pays for *sharpening* the belief over a fixed hidden state. **(brainstorm)** They are consistent because they act on different distributions — coverage over states one *will occupy*, concentration over states the world *is in* — but a deep implementation that writes "epistemic bonus" without saying which distribution it is over has the same silent degree of freedom the `G^agg`/`G^step` choice already has.
- **`Δ_T = 0` is a constraint a reasoning agent will violate.** [[wiki/concepts/latent-graph-discovery.md]]'s agent gathers information by *acting on* the structure it is inferring, which is the intervention case (`Δ_T ≠ 0`) the equivalence explicitly excludes. The clean derivation covers passive measurement — diagnosis, inspection, sensing — not experiment.

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

## What this buys for building a reasoning model

- **The exploration term is not a hyperparameter — but it *is* a coefficient, and its value is a claim that can be wrong.** `−log ρ_t(s)` falls out of the objective's gradient, and the ρ-POMDP reduction names what the gradient is worth: an information-gain bonus at exactly `w = 1` nat (Cooper & Velasquez 2026). That is a derived weight, not the absence of one, and it is reward-near-optimal in only ~32% of random two-state environments at depth 3 ([[wiki/empirical-tensions.md]] T123). A reasoning agent that must discover latent structure ([[wiki/concepts/latent-graph-discovery.md]]) needs to visit edges it has not traversed; here the drive to do so is the derivative of the planning objective, and the gridworld result shows it measurably accelerates identification of the transition kernel.
- **The graph-discovery loop is one algorithm with two alternating steps, not two systems.** VFE writes the graph, EFE walks it, and the coupling between them is the wiki's G5 (no joint discover-and-navigate loop) written as a fixed-point equation. **(brainstorm)** G5's complaint has always been that structure learning is offline relative to behaviour; here the offline-ness is *deliberate and episodic* — model frozen during planning, policy frozen during fitting — and the price is named exactly (performativity), which is more progress than an architecture that interleaves them and cannot say what it has broken.
- **Curiosity is mode-covering, and that is the opposite of the free-energy bound's usual direction.** [[wiki/concepts/divergence-objectives.md]] records that variational free energy optimises the *reverse*, mode-seeking KL — which is why relaxation lands in one attractor. But minimising `Φ = −Σ_t H(ρ_t)` **maximises** the entropy of the imagined state marginal: the planner is paid to spread. So the same principle is mode-seeking in perception and mode-covering in imagination, and the sign flip is not a contradiction but a division of labour — commit hard to one interpretation of the present, keep the imagined future broad. **(brainstorm)** For a planner over a one-to-many transition this is the right pairing, and it suggests the wiki's open question "which direction should a reasoning model minimise?" has an answer of the form *per phase*, not per model.
- **Horizon enters as a smoothness constant** (`L = ½T(T+1)`), not as a discount. Gap G24 asks where planning depth comes from; this source does not answer it, but it prices it: the optimisation cost of a deeper plan is quadratic in the depth, independent of the environment.
- **The augmentation `x = (h,s)` is the recurrent world model.** History-dependent EFE is a convex MDP on the augmented state, and the paper notes this augmented state is what Dreamer-class architectures already carry. So the theory applies to deep implementations without modification — the tabular restriction is on the *algorithm* (softmax dynamic programming), not on the structural result.

---

## Open problems

- **Convergence of the closed loop is unproven**, and the obstruction is coverage, not the optimizer. Everything about active inference as a *learning* scheme (rather than a planning scheme) is therefore still uncertified.
- **The step size scales as `1/T²`**, and the algorithm is demonstrated only on tabular deterministic gridworlds up to 10×10. No evidence that MD-AIF's advantage over entropy-regularised RL survives function approximation.
- **Uniqueness fails**: `Φ` is convex but not strictly, so distinct policies can achieve the same optimum. What the agent actually does at the optimum is underdetermined by the objective.
- **Which infinite-horizon variant is the right one** is a modelling choice the literature has been making silently. No principle selects between `G^agg` and `G^step`.
- **The epistemic value is over *states*, not parameters.** Parameter-novelty ("model-uncertainty") terms used in practical implementations are excluded from the convex-MDP result and are named as a source of extra policy-dependence — the reduction is clean exactly where it is least like a learning agent.
- **…and parameter-novelty is exactly the term that pays.** Ablated across three grid-worlds, the information gain about `θ` accounts for nearly the whole performance gap wherever sensing actions do not alter the observation kernel — `98.7%` vs. `0.0%` rock retrieval (Nuijten et al. 2026). So the two clean theoretical results cover the term with the least measured effect, and the term with the most measured effect has no theory. **[[wiki/empirical-tensions.md]] T124.**
- **Novelty is additive only because learning is frozen during planning.** Per-step novelty decomposes from the global information gain about `θ` only if backward messages into `θ` are withheld during the rollout. An agent that updates its structural belief *inside* imagination has no additive epistemic score, and nothing says what the right objective is there.
- **The channelised scheme has no convergence theory.** Opposing correction signs make the joint optimisation min-max; belief-propagation guarantees do not transfer, and the damping constant is hand-set per environment (Nuijten et al. 2026).
- **The equivalence stops at intervention.** `ρ_EFE = I_a(b)` requires observation actions to leave the hidden state fixed (`Δ_T = 0`). An agent that learns structure by *changing* it — the case a reasoning agent is in — needs the coupling term, and no treatment of it exists (Cooper & Velasquez 2026).
- **The derived weight optimises reward, not accuracy.** The success-maximising weight is 20–200× the derived one on every environment tested, so any agent that must be *right* rather than *profitable* is back to tuning.
- **The epistemic drive does not survive discounting.** Its advantage over reward-only planning requires `γ ≥ 0.99` when there are several observation actions, and reverses at `γ = 0.90`. Every deep implementation that discounts is outside the regime where the term has been shown to pay.
- **No implementation has ever shown the epistemic term paying its way.** Across five one-step neural estimators × three action-selection rules × two agent depths, the reward-only ablation wins every comparison, and the closest thing to a principled estimate collapses the policy onto a single action ([[wiki/empirical-tensions.md]] T125, Champion et al. 2023). Whether that is a fact about EFE or about horizon-1 state-based estimators is exactly what nobody has tested.
- **The epistemic term's *sign* is not standardised, and it is not checked.** Written as a bonus for expected belief change it drives exploration; written as a penalty for disagreement between the forward model and the encoder it drives the agent to stop acting. Both are in circulation under the name "epistemic value", and the tabular experiment shows the underlying decomposition itself flips exploratory reading depending on whether the likelihood or the prior is the distribution moving (Champion et al. 2023).
- **The deep estimator is not the objective.** `Q(s_{t+1}|a_t)` is estimated from a factor of the *generative* model rather than the variational distribution in every deep implementation surveyed, so none of the exact results on this page — the convex-MDP reduction, the ρ-POMDP identity, the entropy-correction theorem — is known to describe what deep active-inference code minimises.
- **Plan-based scoring is wrong under stochastic dynamics, and nothing says how deep the contingency must be represented.** Marginalising a joint posterior recovers within-horizon adaptability for free, but only *within* the horizon: at the boundary the agent again evaluates as if it will never choose again. Whether the underestimation of enabling actions reappears at the horizon edge is untested (Nuijten et al. 2026).
- **The two corrections have no joint theory, only a pair of environments each.** The action-entropy planning correction is worth `+2.6%` in one paper's grid-worlds and `+85%` in the other's DoorKey; the epistemic priors are worth everything in the T-maze and exactly nothing in DoorKey. No principle predicts in advance which regime a task is in ([[wiki/empirical-tensions.md]] T126).
- **The complexity term `C(u)` in `q*(u) = σ(−P(u) − G(u) − C(u))` is derived and then never studied.** It penalises plans that require large belief change, i.e. it opposes exploration, and every EFE implementation that uses Friston's `σ(−G)` silently sets it to zero.
- **The epistemic priors are functions of the posterior they weight.** Planning is a fixed-point problem, not a minimisation; gradient descent converges empirically on three environments and there is no guarantee.
- **The brain appears to encode the *value* of resolving uncertainty but not its *degree*.** Regressing source-space power on the degree of novelty yields nothing after FDR correction while the value of reducing novelty and of reducing variability both survive (Zhang et al. 2025). If that holds under a design that varies uncertainty parametrically, then the quantity a biological planner carries is already `uncertainty × worth-of-resolving`, and an architecture with a separate uncertainty register is representing something the brain does not ([[wiki/empirical-tensions.md]] T127).
- **Every human neural correlate of `G` and of its terms is *negative*.** Higher expected free energy, higher value-of-reducing-variability and higher value-of-reducing-novelty all predict *lower* induced power, at every stage and every peak region, and the source does not address the sign. Until it is explained, the mapping from the objective's arithmetic to a measured neural signal is unsigned, which is the empirical counterpart of this page's existing complaint that the epistemic term's sign is not standardised.
- **The terms may be assembled in sequence rather than computed at once.** Extrinsic value's correlate precedes expected free energy's within the choice epoch (Zhang et al. 2025). Nothing in any formulation on this page predicts a temporal order among the terms, and no implementation has one.
- **Nothing here makes the preference distribution `p̃` come from anywhere.** It is given. The pragmatic half of EFE is as unexplained as a reward function; the paper's own framing ("equivalent to reward maximisation in a latent MDP") makes that explicit rather than hiding it inside a free-energy story.

---

## Connections

- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the sharpest statement of how the two halves relate: the planning objective on this page *is* that page's variational free energy plus four explicit conditional-entropy corrections, an exact algebraic identity, so active inference is not a different currency but the same one with named terms added (Nuijten et al. 2026).
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — supplies the other half of the loop: that page's VFE fits `m = (p,ν)` to collected data and its recognition gap `D_KL(ν‖p(s|h))` is exactly what must vanish for this page's epistemic term to *be* mutual information rather than a state-marginal entropy.
- **[[wiki/concepts/simulation-based-planning.md]]** — this is the objective a rollout is scored by, and the structural result says what kind of search it is: convex over occupancies, so no Bellman-optimal value function exists, and planning must relinearise between iterations rather than back up a single `V`.
- **[[wiki/concepts/simulation-based-planning.md]]** — and the wiki's first runtime-computable stopping rule for a rollout: the agent observes while `−c_k + I_k(b) + E_o[max V]` exceeds `max_i E_b[R_i]` and commits when it does not, a crossover that needs no tuned threshold and no metacognitive estimator (G15's *when is the answer good enough*; Cooper & Velasquez 2026).
- **[[wiki/concepts/divergence-objectives.md]]** — the sign flip that page's open question needs: the variational bound is mode-seeking in perception, while EFE's `−H(ρ_t)` term is *entropy-maximising* over the imagined state marginal, so one principle takes both directions of the asymmetry depending on which phase it is running.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the epistemic term is a derived edge-coverage drive: `−log ρ_t(s)` pays the agent to place occupancy on states its current plan avoids, which is what makes the transition kernel identifiable at all.
- **[[wiki/concepts/latent-graph-discovery.md]]** — and the boundary of that drive's derivation: the information-gain reading holds only where the probe leaves the graph unchanged (`Δ_T = 0`, factored-observation POMDPs), so measuring a latent structure and intervening on it are formally different problems and only the first is covered (Cooper & Velasquez 2026).
- **[[wiki/concepts/amortized-inference.md]]** — the composed behaviour policy `β = π∘ν` is amortization split in two: `ν` is the compiled recognition network, `π` the compiled policy, and planning optimises only the second while holding the first fixed.
- **[[wiki/concepts/attention.md]]** — the epistemic/pragmatic trade-off that page inherits from active inference is here made precise as `⟨ℓ,μ⟩ + Φ(μ)`, one linear and one convex term with no free mixing coefficient between them.
- **[[wiki/concepts/energy-based-models.md]]** — a second reading of "minimise a scalar over a policy rather than over an activity": here the scalar is convex in the occupancy and the constraint set is a flow polytope, so the minimisation has a rate where the energy-based relaxation has none.
- **[[wiki/entities/aixi.md]]** — the same impossibility met with a different instrument: that page's proof that no optimality bound exists for an agent shaping its own data becomes, here, a performative fixed point that provably *exists* but whose reachability turns on an uncertified state-coverage floor.
- **[[wiki/concepts/event-segmentation.md]]** — the sharpest neural evidence that this page's two terms are physically separate: boundaries triggered by prediction *error* (the linear cost `ℓ`) recruit ventrolateral prefrontal cortex and are followed by widespread pattern stabilisation, while boundaries triggered by prediction *uncertainty* (the convex term `Φ`) recruit the dorsal attention network with almost no stabilisation — commit versus look-around, dissociated at 45 subjects (Nguyen et al. 2025).
- **[[wiki/concepts/objective-identifiability.md]]** — the same identifiability question asked of the planner's objective rather than of the task's: EFE and Planning+InfoGain-at-`w=1` are behaviourally indistinguishable by construction (Proposition 1), so no experiment on an agent's actions can license "it is doing active inference" over "it has a tuned bonus" (Cooper & Velasquez 2026).
- **[[wiki/concepts/precision-weighting.md]]** — the argument that makes this objective necessary rather than optional: since loss ≡ surprise and expected loss ≡ entropy, the value function is redundant and goals become priors over sensory trajectories, which removes the Bellman solve and leaves exactly the terms decomposed above (Friston 2009).
- **[[wiki/concepts/simulation-based-planning.md]]** — the objective made runnable without tree search: promoting each corrected conditional to a free channel via Gibbs' inequality turns the whole ladder (belief propagation → cross-entropy planning → risk-minimising → full EFE) into sum-product message passing on one factor graph with kernels substituted for factors (Nuijten et al. 2026).
- **[[wiki/concepts/latent-graph-discovery.md]]** — the empirical case for the parameter reading of the epistemic term: when the unknown layout *is* the parameter `θ` and a probe returns one noisy reading, only the novelty correction makes probing worth anything at all — which is precisely the situation of an agent inferring a hidden graph (Nuijten et al. 2026).
- **[[wiki/entities/deep-active-inference-agent.md]]** — the implementation side of this page and its sharpest counterweight: five one-step neural estimators of `G`, each beaten by its own reward-only ablation, with the failure traced to an epistemic term that an agent minimises by restricting its own data distribution rather than by gathering information ([[wiki/empirical-tensions.md]] T125, Champion et al. 2023).
- **[[wiki/concepts/simulation-based-planning.md]]** — the representational condition under which this objective's epistemic term survives stochastic dynamics: score a *policy* `q(u_t|x_{t-1})` obtained by marginalising the joint posterior, not a fixed plan, or the value of an action whose worth is what it enables gets charged the cost of every rigid continuation of it (Nuijten et al. 2026).
- **[[wiki/concepts/amortized-inference.md]]** — the scalability route that replaces enumeration: imposing the generative model's Markov structure on the variational posterior makes the parameter count linear rather than exponential in the horizon, and the per-step factor `q(u_t|x_{t-1})` *is* the compiled reactive policy (Nuijten et al. 2026).
- **[[wiki/concepts/precision-weighting.md]]** — the empirical wedge between the two pages: that page makes uncertainty a represented quantity with its own substrate, while regression of human source-space power finds correlates for the *value of reducing* novelty and variability and none for the *degree* of either (Zhang et al. 2025, [[wiki/empirical-tensions.md]] T127).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — where the two epistemic terms are physically separated in a human brain: uncertainty about the hidden *state* is valued and updated in medial orbitofrontal cortex, uncertainty about the *parameters* is valued in rostral middle frontal gyrus and updated in precentral gyrus, so T124's two candidate terms have different addresses rather than being one quantity (Zhang et al. 2025).
- **[[wiki/concepts/objective-identifiability.md]]** — the complete class theorem as a self-imposed limit on a model-comparison win: any behaviour–reward pair is describable as ideal Bayesian decision-making under *some* prior, so beating model-free and model-based reinforcement learning by BIC on human choices licenses the existence of priors reproducing the data and not the claim that the brain minimises this objective (Zhang et al. 2025).
- **[[wiki/entities/deep-active-inference-agent.md]]** — and the estimator defect that decouples every exact result above from running code: deep implementations substitute the generative factor `P_θs(s_{t+1}|ŝ_t,a_t)` for the variational `Q(s_{t+1}|a_t)` inside the expectation, so their `G` is not the expectation of their `F`.
- **[[wiki/concepts/subjective-value.md]]** — sharpens this page's discounting result by changing the kernel's shape: the biologically fitted kernel is hyperbolic, which discounts the near future *less* and the far future *more* than any exponential fitted to the same choices, so whether discounting destroys the epistemic advantage depends on where along the delay axis the information-gathering actions sit, not on `γ` alone.
- **[[wiki/entities/autotom.md]]** — the same entropy term used for a different job and without its partner: here `−H` scores a *model structure* rather than an imagined future, and it appears alone rather than beside a preference/likelihood term, so the resulting search maximises certainty about the answer with nothing pulling it back toward the evidence ([[wiki/empirical-tensions.md]] T189).
