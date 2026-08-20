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

## What this buys for building a reasoning model

- **The exploration term is not a hyperparameter.** `−log ρ_t(s)` falls out of the objective's gradient. A reasoning agent that must discover latent structure ([[wiki/concepts/latent-graph-discovery.md]]) needs to visit edges it has not traversed; here the drive to do so is the derivative of the planning objective, and the gridworld result shows it measurably accelerates identification of the transition kernel.
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
- **Nothing here makes the preference distribution `p̃` come from anywhere.** It is given. The pragmatic half of EFE is as unexplained as a reward function; the paper's own framing ("equivalent to reward maximisation in a latent MDP") makes that explicit rather than hiding it inside a free-energy story.

---

## Connections

- **[[wiki/concepts/predictive-coding-free-energy.md]]** — supplies the other half of the loop: that page's VFE fits `m = (p,ν)` to collected data and its recognition gap `D_KL(ν‖p(s|h))` is exactly what must vanish for this page's epistemic term to *be* mutual information rather than a state-marginal entropy.
- **[[wiki/concepts/simulation-based-planning.md]]** — this is the objective a rollout is scored by, and the structural result says what kind of search it is: convex over occupancies, so no Bellman-optimal value function exists, and planning must relinearise between iterations rather than back up a single `V`.
- **[[wiki/concepts/divergence-objectives.md]]** — the sign flip that page's open question needs: the variational bound is mode-seeking in perception, while EFE's `−H(ρ_t)` term is *entropy-maximising* over the imagined state marginal, so one principle takes both directions of the asymmetry depending on which phase it is running.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the epistemic term is a derived edge-coverage drive: `−log ρ_t(s)` pays the agent to place occupancy on states its current plan avoids, which is what makes the transition kernel identifiable at all.
- **[[wiki/concepts/amortized-inference.md]]** — the composed behaviour policy `β = π∘ν` is amortization split in two: `ν` is the compiled recognition network, `π` the compiled policy, and planning optimises only the second while holding the first fixed.
- **[[wiki/concepts/attention.md]]** — the epistemic/pragmatic trade-off that page inherits from active inference is here made precise as `⟨ℓ,μ⟩ + Φ(μ)`, one linear and one convex term with no free mixing coefficient between them.
- **[[wiki/concepts/energy-based-models.md]]** — a second reading of "minimise a scalar over a policy rather than over an activity": here the scalar is convex in the occupancy and the constraint set is a flow polytope, so the minimisation has a rate where the energy-based relaxation has none.
- **[[wiki/entities/aixi.md]]** — the same impossibility met with a different instrument: that page's proof that no optimality bound exists for an agent shaping its own data becomes, here, a performative fixed point that provably *exists* but whose reachability turns on an uncertified state-coverage floor.
- **[[wiki/concepts/event-segmentation.md]]** — the sharpest neural evidence that this page's two terms are physically separate: boundaries triggered by prediction *error* (the linear cost `ℓ`) recruit ventrolateral prefrontal cortex and are followed by widespread pattern stabilisation, while boundaries triggered by prediction *uncertainty* (the convex term `Φ`) recruit the dorsal attention network with almost no stabilisation — commit versus look-around, dissociated at 45 subjects (Nguyen et al. 2025).
- **[[wiki/concepts/precision-weighting.md]]** — the argument that makes this objective necessary rather than optional: since loss ≡ surprise and expected loss ≡ entropy, the value function is redundant and goals become priors over sensory trajectories, which removes the Bellman solve and leaves exactly the terms decomposed above (Friston 2009).
