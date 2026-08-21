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

## Whether the epistemic term pays is a separate question, and it has its own page

Four ablation literatures — factor-graph message passing, deep neural estimators, gradient-descent variational planning, and a human electroencephalography study — measure what happens when the epistemic term is switched off. They do not agree with the derivations above, and the disagreement is substantive rather than empirical noise: **the term that carries the measured effect is information gain about model *parameters*, which the convex-MDP result excludes by construction and which the ρ-POMDP identity scores over the wrong object.** Four distinct quantities circulate under the one name, and one of them collapses the policy. All of it is at [[wiki/concepts/epistemic-value.md]].

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
- **The equivalence stops at intervention.** `ρ_EFE = I_a(b)` requires observation actions to leave the hidden state fixed (`Δ_T = 0`). An agent that learns structure by *changing* it — the case a reasoning agent is in — needs the coupling term, and no treatment of it exists (Cooper & Velasquez 2026).
- **Nothing here makes the preference distribution `p̃` come from anywhere.** It is given. The pragmatic half of EFE is as unexplained as a reward function; the paper's own framing ("equivalent to reward maximisation in a latent MDP") makes that explicit rather than hiding it inside a free-energy story.

---

## Connections

- **[[wiki/concepts/epistemic-value.md]]** — the measurement half of this page, split out at the 244-source lint: this page derives the epistemic term and fixes its weight, that one holds the four literatures that ablate it and the four incompatible quantities circulating under its name, of which the one that pays is excluded from the derivation here.
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
- **[[wiki/entities/arc-agi-3.md]]** — the benchmark that demands this page's epistemic term and withholds its pragmatic one: an agent is dropped into an environment with unknown action semantics and is never told the win condition, so `C` — the preference distribution every formulation of expected free energy takes as given — is precisely the missing input (gap G72), and exploration cost is charged in the same units as execution.
- **[[wiki/concepts/broadcast-hierarchy.md]]** — the objective implied by cortical abstraction being *lossy by design*: the generative model targets metabolically efficient approximations sufficient for guiding action rather than reconstructions, which is this page's pragmatic term acting as a floor on the residual a predictive hierarchy is worth driving down.
