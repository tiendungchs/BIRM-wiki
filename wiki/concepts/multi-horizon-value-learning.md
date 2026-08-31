# Multi-Horizon Value Learning — One Torso, Many Discounts

**Learn a *set* of exponentially-discounted value functions, one per `γ`, from a shared representation; then any discount function expressible as `d(t) = ∫₀¹ w(γ)γᵗ dγ` — hyperbolic included — is recovered as a weighted sum of them, and the set itself turns out to be a better auxiliary task than the discounting scheme it was built to enable.**

> **Provenance.** Fedus, Gelada, Bengio, Bellemare & Larochelle 2019, *Hyperbolic Discounting and Learning over Multiple Horizons*, arXiv:1902.06865 (`raw/fedus-2019-hyperbolic-discounting-multiple-horizons.md`). Theory (hazard-prior ↔ discount-function equivalence, Lemma 5.1) plus two experiments: a synthetic Pathworld with unobserved per-episode hazard, and the full Arcade Learning Environment on Rainbow/C51 with sticky actions, 3 seeds.

---

## 1. A discount function is a posterior over how long you survive

Sozou 1998, restated in Markov-decision-process form. Survival `s(t) = P(alive at t)`; a risk-neutral agent values a future reward by the probability it lives to collect it, `v(r_t) = s(t)r_t`. Hazard rate `h(t) = −d/dt ln s(t)`.

| Prior over hazard `H = p(λ)` | Implied discount `d(t)` | Weighting `w(γ)` |
|---|---|---|
| Dirac delta `δ(λ−k)` — *no uncertainty* | `e^{−kt} = γ_k^t` (**standard RL**) | `(1/γ)δ(−ln γ − k)` |
| Exponential `(1/k)e^{−λ/k}` | `1/(1+kt)` (**hyperbolic**) | `(1/k)γ^{1/k−1}` |
| Uniform on `[0,k]` | `(1−e^{−kt})/(kt)` | `(1/k)γ^{−1}` on `γ ∈ [e^{−k},1]` |

`γ = e^{−λ}`: the discount factor **is** the per-step continuation probability. `λ→∞ ⇒ γ→0` (myopic), `λ→0 ⇒ γ→1` (far-sighted). `d(t)` is the Laplace transform of the hazard prior, under the change of variables `γ = e^{−λ}`.

**The equivalence that gives this teeth.** For a hazardous MDP `⟨S,A,R,P,H,d⟩` where `P_λ(s′|s,a) = e^{−λ}P(s′|s,a)`:

`Q_π^{δ(0),Γ_k}(s,a) = Q_π^{p_k,1}(s,a)`

Discounting hyperbolically in a *safe* world is exactly the same value function as not discounting at all in a world whose per-step death rate is drawn from `p_k`. **So choosing a discount function is choosing which distribution of risks your policy is robust to** — the same statement as `Q_π^{δ(0),γ^t} = Q_π^{δ(−ln γ),1}` for the exponential case, generalised. A single `γ` is not a neutral engineering knob; it is the assertion that the agent knows the environment's hazard rate exactly.

---

## 2. Non-exponential values from exponential TD learning

The obstruction was that temporal-difference methods need the Bellman recursion, and only exponential discounts compose. The dissolution is that a non-exponential discount need not compose — it need only be a **mixture** of ones that do.

**Lemma 5.1 (exponential weighting condition).** If `d(t) = ∫₀¹ w(γ)γᵗ dγ` then

`Q_π^{H,d}(s,a) = ∫₀¹ w(γ) Q_π^{H,γ}(s,a) dγ`

For the hyperbola, two equivalent integrals: `∫₀¹ γ^{kt} dγ = 1/(1+kt)` and (from the Laplace route) `(1/k)∫₀¹ γ^{1/k+t−1} dγ = 1/(1+kt)`. Each `Q_π^γ` is learned by ordinary Q-learning with its own `γ`, so every convergence guarantee and every trick in the TD literature survives.

**Practical agent.** `n_γ = 10` discount factors `G = [γ₀…γ_{n_γ}]`, spaced to emphasise large `γ`, capped at `γ_max = 0.99` to avoid the instability of `γ→1`; the integral becomes a lower Riemann sum `Q^Γ ≈ Σ_i (γ_{i+1}−γ_i)w(γ_i)Q^{γ_i}`. Architecturally: **one shared representation `h(s)`, one affine head per horizon**, `Q^{(i)}(s,a) = f(W_i h(s) + b_i)`. Each extra horizon costs one matrix.

Truncating at `γ_max` is the dominant approximation error and it grows with `t` — Pathworld mean-squared error 0.002 at `γ_max = 0.999` vs 2.281 at `γ_max = 0.9`.

---

## 3. What the experiments separate

**Pathworld** (`N` paths, length `d(i)=i²`, reward `r(i)=i`, unobserved `λ ∼ H` drawn per episode, true `k = 0.05`). Trained hyperbolically under no hazard, evaluated undiscounted under hazard — i.e. the discount is being used purely as a robustness device.

| Value estimator | MSE over paths |
|---|---|
| Hyperbolic (matched prior) | **0.002** |
| `γ = 0.975` | 0.566 |
| `γ = 0.95` | 1.461 |
| `γ = 0.9` / `0.99` | 2.25 / 2.29 |

Robustness to misspecification is the load-bearing result: with the coefficient wrong by 2–4× (`k ∈ [0.025,0.2]` against true `0.05`) the errors (0.49–1.28) still beat every single-`γ` agent, and when the true hazard is *uniform* rather than exponential the hyperbolic estimator (0.235) still edges the best tuned exponential (0.266). A tuned `γ = 0.975` can pick the right arg-max path while getting the entire value *profile* wrong — which is invisible until the arg-max action is removed or a non-trivial intertemporal trade-off appears.

**Two preconditions the paper states for any of this to matter:** (i) uncertain hazard, (ii) non-trivial intertemporal decisions (small-near vs large-far). With a single true hazard rate an optimal `γ* = e^{−λ_env}` exists and hyperbolic discounting buys nothing.

**Arcade Learning Environment — the surprise.** Hyper-Rainbow (acts on hyperbolic Q-values) improves on Rainbow in 14/19 games. But **Multi-Rainbow** — same multi-horizon heads, still acting on a single `γ_action` — performs *nearly identically*. The gain is the auxiliary task, not the discounting. Multi-C51 beats C51 in 9/10 games.

| Interaction | Result |
|---|---|
| Multi-horizon + n-step returns | Composes well |
| Multi-horizon + prioritized replay | **Hurts 4/10 games** (Pong, Venture, Gravitar, Zaxxon) when TD errors are *averaged* across heads |
| Prioritize by the largest `γ`'s TD error instead | Preliminary, better |

The prioritization failure is informative rather than incidental: an average over heads with different horizons is not an error signal about anything in particular. Compare [[wiki/concepts/replay-prioritisation.md]], where the priority of a backup is a normative quantity (`Need × Gain`) and the discount enters the `Need` term explicitly — there is no reason a mean over ten `Need` terms should rank experiences correctly.

---

## 4. What a builder takes from this

| Finding | Consequence |
|---|---|
| `d(t) = ∫ w(γ)γᵗ dγ` | **Time-inconsistency does not forbid dynamic programming.** It forbids *one* stationary value function; a family of them, each stationary, recombines into the inconsistent kernel at read-out. The wiki's `γ^k` machinery is not refuted by a hyperbolic behavioural kernel — it is the basis set for it (T141) |
| Discount ≡ hazard prior | The horizon hyperparameter becomes a **statement of belief about environmental risk**, which is at least the kind of object an agent could estimate. Uncertainty about `λ` — not a preference for the near term — is what produces the hyperbola |
| Many horizons, one torso | Cost is one affine map per horizon; the representation is shared. A horizon ensemble is close to free once the encoder exists — and it collapses the one-kernel-vs-two-systems dispute of T140, since a bank of exponential heads summed by `w(γ)` *is* both descriptions at once |
| Multi-horizon as auxiliary task | Predicting the *same* reward stream at many timescales regularises the representation better than the discounting scheme it enables. No new labels, no new environment interaction, no auxiliary reward design |
| Prioritization must not average over heads | Any mechanism downstream of a value ensemble needs to name *which* horizon it is reading |

**(brainstorm) The auxiliary-task result is the one that generalises past reinforcement learning.** Ten heads on one torso, all predicting the same signal under ten decay rates, is a **timescale-decomposition objective** — the temporal analogue of the multi-scale spatial codes of [[wiki/concepts/path-integration.md]] and of the eigenspace-per-horizon story on [[wiki/concepts/successor-representation.md]] (where `ϒ = Σ_n γⁿΛⁿ` is one basis re-weighted per horizon). Nothing in the construction is specific to reward: a self-supervised model could predict its own future embedding under a bank of decay rates and get the same representational pressure, which is a testable and cheap addition to the objectives on [[wiki/concepts/objective-identifiability.md]]. Nobody in the wiki has run it.

**(brainstorm) It also gives Doya's second proposal a machine implementation.** [[wiki/concepts/neuromodulatory-metaparameters.md]] lists, as an untested alternative substrate for `γ`, "selection among parallel loops with different native timescales" — cortico-basal-ganglia loops, amygdala, cerebellum. That is *this architecture*: horizons held in parallel, a controller choosing or weighting among them. Under that reading serotonin does not set `γ` at all; it sets `w(γ)`, the read-out weighting over a fixed bank, and the hazard-prior equivalence says a change in `w` is a change in the risk the agent believes it faces. It also predicts what a lesion should do — remove a horizon, not shift one.

---

## Limitations

| Limit | Consequence |
|---|---|
| Hazard is constant within an episode | `λ` is drawn once per episode and never varies with `t`. Real risk is time-varying and, as the paper notes, is a joint property of *policy* and environment — a dangerous policy manufactures its own hazard, so time-preference and policy should co-adapt. Untouched |
| The two contributions do not co-validate | Pathworld shows hyperbolic *valuation* wins; ALE shows the *auxiliary task* wins and the discounting scheme contributes nothing measurable. No environment demonstrates both at once |
| ALE's hazard is a stand-in | Sticky actions are a thin and artificial hazard; the paper concedes this is why acting hyperbolically does not help there |
| `γ_max = 0.99` in practice | The integral is truncated well short of 1, which is where the hyperbola's long tail lives — the deployed agent approximates a much shorter-horizon kernel than the theory describes |
| Riemann sum, `n_γ = 10` | No analysis of how the approximation error propagates into the *policy*, only into the value estimate |
| 3 seeds | Standard for the era, thin for a per-game improvement claim |

---

## Connections

- **[[wiki/concepts/subjective-value.md]]** — supplies the kernel this page shows how to compute: the hyperbola fitted to human choice and to human value-region time courses (`SV = A/(1+kD)`, median `R² = 0.95`) is exactly `∫₀¹ w(γ)γᵗ dγ` under an exponential hazard prior, so the measured behavioural kernel and a bank of ordinary TD learners are the same object seen from two ends (T141).
- **[[wiki/concepts/reward-prediction-error.md]]** — repairs the objection that page raises against itself: `δ = r + γV(s′) − V(s)` presumes a stationary `V`, and a hyperbolic kernel admits none — but *ten* `δ`s, one per horizon, each perfectly well-formed, reconstruct the hyperbolic value at read-out. The prediction error stays exponential; only the aggregation is not.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — turns that page's `γ`-as-broadcast-scalar into `γ`-as-read-out-weighting: instead of one chemically-carried discount factor, a fixed bank of horizons plus a weighting `w(γ)` that encodes the agent's hazard prior — which is a machine implementation of Doya's own untested "parallel loops with different native timescales" alternative.
- **[[wiki/concepts/simulation-based-planning.md]]** — removes the kernel objection from rollout scoring: a time-inconsistent discount does not stop the rollout from being scored, it only means the score is a weighted sum over horizon-specific returns rather than one geometric sum (gap G24).
- **[[wiki/concepts/replay-prioritisation.md]]** — where the ensemble breaks: averaging temporal-difference errors across horizons to set replay priority *hurts* 4/10 Atari games, and the normative `Need × Gain` priority is defined per-`γ` (`Need` is a row of `(I−γT)⁻¹`), so a value ensemble needs a per-horizon prioritization rule rather than a mean.
- **[[wiki/concepts/successor-representation.md]]** — the same many-horizons-one-basis structure on the state-occupancy side: `ϒ = Σ_n γⁿΛⁿ` re-weights one eigenbasis per discount, here one shared encoder is re-weighted per discount, and both make the horizon a read-out parameter rather than a training-time commitment.
- **[[wiki/concepts/epistemic-value.md]]** — the discounting-vs-information conflict, priced: the hazard reading says a low `γ` is a belief that you will die before the information pays off, which is why discounting below the number of observations a confident commit needs destroys the epistemic term's advantage (G24).
- **[[wiki/concepts/latent-graph-discovery.md]]** — the traversal depth as a distribution rather than a number: the agent holds a prior over how far the graph is worth walking before the walk is cut short, and the value read-out is the marginal over that prior.
