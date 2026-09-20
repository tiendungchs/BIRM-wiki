# Option-Critic — Option Discovery as Gradient Descent on the Task Return

**Drop the subgoal. Differentiate the ordinary discounted return with respect to the intra-option policy parameters `θ` and the termination parameters `ϑ`, and both fall out as policy-gradient theorems — so the option's policy, its termination condition and the policy over options are all learned end-to-end from the environment's own reward, with no pseudo-reward, no subgoal vocabulary, no bottleneck statistic and no demonstration. The only thing the modeller supplies is the number of options.**

> **Provenance.** Bacon, Harb & Precup 2017, *The Option-Critic Architecture*, AAAI 2017 / arXiv:1609.05140 (`raw/bacon-2017-option-critic-architecture.md`). Two theorems plus experiments in four-rooms (tabular), Pinball (continuous state, linear Fourier bases) and four Arcade Learning Environment games (deep convolutional network). Everything below is from that source unless marked.

The ninth option-discovery family on [[wiki/concepts/temporal-abstraction-options.md]], and the only one in which options are a **byproduct of ordinary policy optimisation** rather than the output of a separate discovery procedure run on a graph, a corpus or a spectrum.

---

## The two gradients

Setting: Markov options `ω = ⟨I_ω, π_ω, β_ω⟩` with `I_ω = S` for all `ω` (every option available everywhere), call-and-return execution, and the augmented chain over state–option pairs `(s, ω)`.

| Object | Definition |
|---|---|
| Option value | `Q_Ω(s,ω) = Σ_a π_{ω,θ}(a\|s) · Q_U(s,ω,a)` |
| State–option–action value | `Q_U(s,ω,a) = r(s,a) + γ Σ_{s′} P(s′\|s,a) · U(ω,s′)` |
| Value upon arrival | `U(ω,s′) = (1 − β_{ω,ϑ}(s′)) Q_Ω(s′,ω) + β_{ω,ϑ}(s′) V_Ω(s′)` |
| Advantage over options | `A_Ω(s′,ω) = Q_Ω(s′,ω) − V_Ω(s′)` |

| Theorem | Gradient | Reading |
|---|---|---|
| **1 · Intra-option policy gradient** | `Σ_{s,ω} μ_Ω(s,ω\|s_0,ω_0) Σ_a ∂π_{ω,θ}(a\|s)/∂θ · Q_U(s,ω,a)` | The effect of a *primitive-level* change on the **global** return — not on the option's own reward function. This is the whole departure from pseudo-reward methods, which optimise each option against its own objective and never ask how the change propagates |
| **2 · Termination gradient** | `−Σ_{s′,ω} μ_Ω(s′,ω\|s_1,ω_0) ∂β_{ω,ϑ}(s′)/∂ϑ · A_Ω(s′,ω)` | Terminate when the running option is worse than the average over options. The advantage appears **as a consequence of the derivation**, not as a variance-reduction baseline — which makes the theorem "a gradient-based interrupting Bellman operator" |

`μ_Ω` is the discounted weighting of state–option pairs; under options-everywhere the augmented chain is ergodic with a unique stationary distribution. The critic holds `Q_U` and `A_Ω`; the actor holds `π_Ω`, the `π_ω` and the `β_ω`. Two-timescale: values fast, policies and terminations slow.

**The practical shortcut:** learning `Q_U` separately from `Q_Ω` wastes parameters and samples, so the one-step off-policy target `g_t^(1)` — identical to intra-option Q-learning's — is used as the `Q_U` estimator in the deep runs.

---

## Results

| Domain | Setup | Result |
|---|---|---|
| **Four-rooms** | goal at east doorway, moved to a random cell in the lower-right room after 1000 episodes; `γ = 0.99`, `r = +1` at goal only; Boltzmann `π_ω`, sigmoid `β_ω`; 4 or 8 options; 350 runs | Recovers faster than primitive actor–critic and SARSA(0) after the goal moves; the **initial** option set is learned from scratch at a rate comparable to primitive methods — i.e. the usual "options cost more up front, pay off on transfer" trade is not paid |
| **Four-rooms, terminations** | same | Termination probability concentrates **near the doorways** — the bottleneck subgoals of the entire discovery literature, recovered without being encoded, from return maximisation alone |
| **Pinball** | continuous position/velocity, 5 primitive thrusts, `−5` per thrust / `−1` per null action, `+10000` at target; Fourier basis order 3; 2–4 options | Near-optimal option set by **40 episodes**; options are temporally extended and specialised (one option used consistently near the goal). Konidaris & Barto's skill chaining on the same domain requires a 10-episode gestation period before an option may be used at all |
| **Arcade Learning Environment** (Asterix, Ms. Pac-Man, Seaquest, Zaxxon) | DQN convolutional stack → 512-unit dense layer shared by `π_Ω`, all `π_ω` (linear-softmax) and all `β_ω` (sigmoid, one output per option); 8 options; one parameter set across all four games | Goal-achieving options learned from the ground up within **200 episodes**; beats the original DQN in Asterix, Seaquest and Zaxxon despite having more parameters |
| **Seaquest, 2 options** | — | Each option specialises on a behaviour sequence containing either the up or the down button; the same structure a graph-partitioning discovery algorithm found in that game |

---

## Three degeneracies, and what each one reveals

The architecture works only with three additions that the theorems do not motivate. Each marks a quantity the return objective does not contain.

| Degeneracy | Patch | What it means |
|---|---|---|
| **Options shrink to primitives.** The termination gradient drives `β → 1` over time | Add `ξ = 0.01` to the advantage: `A_Ω(s,ω) + ξ`. This imposes a `ξ`-margin below the best option, making the advantage positive for near-optimal options and *stretching* them | The source states the reason outright: **primitive actions are sufficient for solving any Markov decision process**, so return maximisation has no reason to prefer an option. Temporal abstraction is not return-optimal and never will be — it is optimal against a budget (samples, transfer, exploration) that the discounted return does not carry |
| **Intra-option policies collapse to deterministic** | Entropy penalty on low-entropy `π_ω` (the A3C regulariser) | Attributed by the source to policy gradients with deep networks in general, not to option-critic — but the effect is that option *identity* stops being informative if every option is a delta function on one action |
| **High-variance intra-option gradient** | `Q_Ω` added as a baseline in the intra-option estimator | Substantially improved the action distributions inside options and overall performance |

**(brainstorm)** The `ξ` margin is the wiki's clearest instance of a missing objective being smuggled in as a hyperparameter. [[wiki/concepts/optimal-hierarchy-criterion.md]] supplies exactly the term `ξ` stands in for — a decomposition's Bayesian model evidence over a *task ensemble*, provably the shortest code for the behaviours and the fewest trials to discover a randomly drawn task. Option-critic optimises a single task's return and so is structurally incapable of representing why an option should exist; `ξ` is a scalar bribe paid to keep options alive. The testable consequence: `ξ` should not be tunable freely but derivable from the task ensemble's description length, and a `ξ` fitted per-domain is a measurement of that quantity.

---

## The routing question, answered by elimination (`T367`)

`T367` asks whether the subgoal-level prediction error rides its own channel or the reward channel masked by the running option. Option-critic takes a third route: **there is no second error at all.** The only reward anywhere in the architecture is `r(s,a)`; the option's identity enters as an *argument to the critic* (`Q_U(s,ω,a)`, `Q_Ω(s,ω)`), not as a gate on a second signal. The option level is distinguished from the goal level by **which value table is indexed**, never by which error is broadcast.

| | Option-critic | Pseudo-reward architectures |
|---|---|---|
| Errors broadcast | 1 (`δ` against `Q_U`) | 2 (`δ` and the pseudo-reward prediction error) |
| `r̃` : `r` ratio | **does not exist** — `G33`'s farming question is dissolved, not answered | set by fiat, `1` : `1` in the simulations |
| Subgoal capture ([[wiki/concepts/conditioned-reinforcement.md]], Cronin 1980) | impossible by construction — the agent has nothing to pay itself with | the standing failure mode |
| What the option level costs | one extra index on the value function | a wire plus a gain calibration per level |
| Cannot express | an option pursued for its own sake; a level with an objective the root does not share; any option that is *not* return-serving | — |

The source also says the accommodation is available: if pseudo-rewards are wanted, the two gradients are simply taken with respect to them instead, "so long as it comes in the form of an additive differentiable function". Option-critic is therefore the **single-channel pole** of `T367` made constructive, and it is the null hypothesis every own-channel hierarchy owes a comparison against.

**(brainstorm)** The "cannot express" row is the price and it is not small. Every want-construction mechanism in the wiki — conditioned reinforcement, token economies, intrinsic motivation — builds an intermediate target whose pull is *detached* from the primary reward, which is precisely what makes it survive devaluation and usable in a new task. Option-critic's options have no such detachment: they are shadows of the current return and re-shape as it changes. That is why the four-rooms result cuts both ways — the doorway terminations are discovered *because* the reward is at a doorway's far side, so the option set is not a model of the graph, it is a factorisation of one reward function.

---

## Limitations the source names

| Limitation | Consequence |
|---|---|
| **All options available everywhere** (`I_ω = S`) | The largest one by the authors' own verdict. Learned initiation sets would need a classifier over features, costing about as much as evaluating `π_Ω` itself under function approximation, plus a flow condition linking initiation sets to terminations to keep the augmented chain ergodic. Left to future work |
| **Number of options is hand-set** | 2–8 throughout; nothing selects it — the same unpinned quantity as every other discovery family |
| **Biased discounted gradient** | Neglecting `γ^t Π(1−β_i)` factors biases the estimators; correcting them is possible and explicitly *not recommended*, because the unbiased estimators' sample complexity is too high |
| **No retirement, no re-derivation** | Options are continually updated rather than compiled, which sidesteps staleness — but nothing removes an option or changes their number |
| **No option-of-options** | The formalism permits `a` to be an option; nothing in the architecture or experiments nests them |

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| Option | A compiled edge whose endpoints are never named — `β` defines where it ends only implicitly, through the value function |
| Discovery | Not a search over the graph but a **local deformation of an initialised edge set** under return pressure; the graph is never built, estimated or partitioned |
| Doorway terminations | The bottleneck structure recovered as a *fixed point* of return maximisation rather than as a graph statistic — evidence that bottleneck-ness and return-optimality coincide in four-rooms, with no claim that they coincide generally (`T365` says they come apart on diffusion time) |
| `ξ` margin | An explicit prior that the graph's compiled edge set should be non-empty, which the return objective denies |

---

## Connections

- **[[wiki/concepts/temporal-abstraction-options.md]]** — the ninth discovery family and the only one that needs no second signal of any kind: the intra-option policy gradient and the termination gradient are derivatives of the *same* discounted return the flat learner maximises, so discovery and learning stop being separate problems. It also supplies that page's "nothing sets granularity" open problem with a reason rather than a restatement — primitives suffice for any Markov decision process, so the return objective actively prefers `β → 1` and granularity must be imposed from outside (here, a `ξ = 0.01` advantage margin).
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — the architecture that removes the quantity that page measures: option-critic has one error, against `Q_U(s,ω,a)`, with the option entering as an index on the value function rather than as a second reward, so `T367`'s routing question does not arise for it and the `r̃` : `r` ratio has no referent.
- **[[wiki/concepts/optimal-hierarchy-criterion.md]]** — supplies the objective that option-critic's `ξ` hyperparameter stands in for: an option inventory is scored by its model evidence over a task *ensemble*, which is the term a single task's discounted return cannot contain — and is why a return-maximising termination gradient collapses options unless bribed.
- **[[wiki/concepts/eigenoption-discovery.md]]** — the opposite pole of the same axis: eigenoptions consult the reward *never* and read options off the transition Laplacian, option-critic consults nothing *but* the reward and reads them off its gradient; the pair brackets the discovery literature, and the eigenvalue ladder gives graded timescales for free where option-critic's timescale is whatever `ξ` sustains.
- **[[wiki/concepts/conditioned-reinforcement.md]]** — the failure mode option-critic is immune to and the capability it forfeits with it: with no manufactured intermediate reward the agent cannot prefer its subgoal to its goal (Cronin 1980), and equally cannot hold a want that survives devaluation of the primary reward, so its options re-shape whenever the return does.
- **[[wiki/concepts/hindsight-goal-relabelling.md]]** — the other architecture that obtains hierarchy's benefit without a subgoal vocabulary, from the opposite direction: relabelling manufactures dense signal inside a flat learner, option-critic manufactures temporal commitment without dense signal, and neither has been run against the other at matched interaction budget.
- **[[wiki/entities/dqn.md]]** — the flat baseline and the shared substrate: the same three convolutional layers and 512-unit dense layer, with `π_Ω`, eight `π_ω` and eight `β_ω` as linear heads on it, beating the original in three of four games — so the option layer is measured as a *head* on an otherwise unchanged learner.
- **[[wiki/entities/hisd.md]]** — the supervision contrast: HiSD discovers options from an unlabelled observation corpus with no reward and no interaction and then must learn policies for them, option-critic discovers policies and terminations from reward-driven interaction and never names a skill — so the two split the discovery problem along "what recurs" versus "what pays".
- **[[wiki/entities/cscg.md]]** — the graph-partitioning route to the same doorway subgoals, and the comparison that matters: CSCG needs a de-aliased transition estimate and an offline partitioner to find room boundaries, option-critic's terminations land near the same doorways from return pressure alone in a fully observed grid — which leaves open whether the return route survives aliasing at all, since it has no state model to be aliased.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the unusual claim in this architecture's four-rooms result: the option set is learned from scratch at a rate *comparable to primitive methods* while still transferring, so the up-front cost that normally prices temporal abstraction is not paid.
- **[[wiki/entities/feudal-networks.md]]** — the opposite pole of `T367`, built at the same scale and the paper that beats this one: FuN severs the inter-level gradient and pays its Worker a second, directional reward, and its "non-feudal" ablation — `g` trained by gradients from the lower level with no intrinsic reward, i.e. this architecture's coupling — is reported as significantly inferior, with ×20 (Asterix), ×3 (Zaxxon) and ×2 (Ms. Pac-Man) on the four games compared, against the caveat that option-critic's own baseline was DQN rather than A3C-LSTM. The pair also splits on granularity: `ξ = 0.01` bribes options to persist here, two hard-wired integers (`c`, `r` = 10) impose the timescale there.
- **[[wiki/entities/diayn.md]]** — the same bottleneck reached from the opposite premise: this architecture's terminations concentrate at the four-rooms doorways under return pressure, while DIAYN's gridworld optimum prefers short-border partitions — hence the same doorways — from an information objective that never sees a reward, so bottleneck-ness is a fixed point of two incompatible objectives rather than of either one.
- **[[wiki/entities/go-explore.md]]** — both architectures refuse to name an intermediate target, for opposite reasons and with opposite outcomes: this page dissolves the subgoal into option policies differentiated from the return, Go-Explore externalises the frontier into an archive keyed by a count bonus and learns nothing about structure at all, and only the second solves the sparse-reward games the options literature is motivated by (`T402`).
- **[[wiki/entities/asymmetric-self-play.md]]** — the third arrangement of setter and solver, and the one this page is the null for: option-critic has no setter at all and dissolves the intermediate target into option policies learned from the return, where asymmetric self-play externalises the setter into a second agent with its own adversarial objective; neither has been run against the other, or against [[wiki/entities/feudal-networks.md]]'s cooperative Manager, at matched interaction budget.
