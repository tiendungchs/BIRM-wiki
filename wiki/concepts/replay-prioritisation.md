# Replay Prioritisation

**Replay decouples the order in which experience is *used* from the order in which it was *had*; prioritisation is the choice of the sampling distribution over the buffer, and that choice is a first-class architectural variable rather than an implementation detail.** Primary machine source: Schaul, Quan, Antonoglou & Silver 2016, *Prioritized Experience Replay*, ICLR (`raw/schaul-2016-prioritized-experience-replay.md`). Biological counterpart: [[wiki/concepts/offline-replay.md]].

[[wiki/entities/dqn.md]] samples uniformly and names the absence of prioritisation as its own defect. This page is the design space that fills that hole — what criteria exist, which ones have been measured, and the one place the measurements contradict each other.

---

## The existence result: ordering alone can be exponential

**Blind Cliffwalk** (Schaul et al. 2016, §3.1). `n` states, two actions, one of which ends the episode with zero reward; a random action sequence reaches the single non-zero reward with probability `2⁻ⁿ`, so the informative transitions are buried in an exponential mass of redundant failures.

| Agent | Same buffer, same Q-learning updates | Updates to solve |
|---|---|---|
| Uniform sampling | replay in arrival proportion | exponential in `n` |
| Oracle (greedily picks the transition that maximally reduces global loss *in hindsight*) | replay in optimal order | **exponentially fewer** |
| Greedy `\|δ\|` prioritisation | replay highest last-seen TD error | close to the oracle |

**This is the load-bearing claim of the whole area.** With the data, the architecture, the loss and the optimiser all held fixed, *the sampling distribution over a fixed buffer* moves sample complexity by an exponential factor in the sparse-reward regime. Nothing about representation, model class or exploration is involved. Any wiki claim that a sparse-reward failure is a *representational* failure has to first rule out that it is a scheduling failure ([[wiki/concepts/skill-acquisition-efficiency.md]]).

## The rule

```
P(i) = pᵢ^α / Σₖ pₖ^α                     α = 0 → uniform;  α = 1 → fully proportional

proportional variant:  pᵢ = |δᵢ| + ε      δ = r + γ·Q_target(s′, argmaxₐ Q(s′,a)) − Q(s,a)
rank-based variant:    pᵢ = 1 / rank(i)   rank over the buffer sorted by |δ| → P is a power law

wᵢ = ( 1/N · 1/P(i) )^β  / maxⱼ wⱼ        importance-sampling correction; update uses wᵢ·δᵢ
β: annealed linearly β₀ → 1               unbiased only where it matters — at convergence
```

| Component | Why it is there | What breaks without it |
|---|---|---|
| `\|δ\|` as the priority | Proxy for **expected learning progress**; already computed by any TD algorithm, so free | — |
| New transitions inserted at **maximal** priority | Guarantees every transition is seen at least once | Schaul's own measurement: a fraction of transitions are *never replayed* before falling out of the sliding window |
| `α < 1` (stochastic, not greedy) | Errors shrink slowly under function approximation, so greedy replay locks onto a small subset | Loss of diversity → overfitting; noise spikes amplified by bootstrapping |
| `ε > 0` (proportional variant) | A zero-error transition would never be revisited | Permanent dropout of solved transitions |
| Rank rather than magnitude | Insensitive to outliers; heavy tail guarantees diversity; stratified sampling (one transition per equal-probability segment) keeps minibatch gradient magnitude stable | Sensitivity to reward noise and error scale |
| IS weights `w` | Prioritisation changes the distribution the expectation is taken over, so the fixed point moves | Biased solution — tolerated early because policy, state distribution and bootstrap targets are non-stationary anyway |
| `w` normalised by `1/max w` | Weights only ever scale updates **down** | Step-size blowup |

**A second, non-statistical reason for the IS weights.** Prioritisation makes high-error transitions be seen *many times* while `w` shrinks each individual gradient. Same total movement, smaller steps — so the optimiser re-approximates the Taylor expansion along the way and can follow curvature that a single large step would overshoot. Prioritisation + IS is thus also a **trust-region device**, not only a bias correction. This is why the only hyperparameter that had to change versus the baseline was a 4× *reduction* in step size.

**Cost.** Sampling and updating must not scale with `N = 10⁶`. Proportional: a **sum-tree** (each node the sum of its children, priorities at the leaves), `O(log N)` update and sample. Rank-based: precompute a piecewise-linear approximation to the CDF with `k` = minibatch-size equal-probability segments, sample one transition per segment. Greedy: binary heap, `O(1)` max, `O(log N)` update.

## What it buys

| Metric (Atari, human starts) | DQN | + prioritised (rank) | Double DQN | + rank | + proportional |
|---|---|---|---|---|---|
| Median normalised score | 48% | **106%** | 111% | 113% | **128%** |
| Mean | 122% | 418% | 355%¹ | 454% | **551%** |
| Games above human | 15 | 30 | 25 | 33 | 33 |
| Games improved over its own baseline | — | 41/49 | — | 38/57 | 42/57 |

¹ *baseline columns in the source's Table 1 are DQN(49 games) and tuned Double DQN(57 games); the mean is dominated by a single game (Video Pinball) and is not a reliable statistic.*

- **~2× faster learning**: the median curve reaches the fully-trained Double DQN score at 38–47% of total training.
- Prioritisation is **complementary** to Double Q-learning's overestimation fix — the two stack.
- Biggest effects where reward is delayed and learning otherwise fails to get off the ground at all (Battlezone, Zaxxon, Frostbite).
- One hyperparameter setting across all games: `α = 0.7, β₀ = 0.5` (rank), `α = 0.6, β₀ = 0.4` (proportional).
- Rank and proportional perform **about equally**, which the authors did not expect; their explanation is that DQN clips rewards and TD errors to `[−1,1]`, which already removes the outliers rank-based sampling exists to survive. **The robustness argument for ranks is therefore untested, not refuted** — it should reappear in any unclipped system.

## Two incidental measurements that indict uniform sampling

1. **Some transitions are never replayed** before dropping out of the sliding window; many more are first replayed long after they were encountered.
2. **Uniform sampling is implicitly biased toward stale transitions** — generated by a policy hundreds of thousands of updates old. Prioritisation partially corrects this for free, because recent transitions tend to carry larger error (old ones have had more chances to be corrected, and novel data is less well predicted).

So "uniform" is not the neutral baseline it is treated as; it is *recency-window-uniform with an age bias*, and the wiki's reading of DQN's buffer as accidental coverage-maximisation ([[wiki/entities/dqn.md]], T30) has to carry that qualification.

## The priority criterion is a design space, not a formula

`|δ|` is one proxy. Schaul's Appendix A enumerates the alternatives, all of which he flags as untested or inconclusive; the wiki's own biological rows are added here for comparison.

| Criterion | `pᵢ ∝` | Fixes | Status |
|---|---|---|---|
| **TD-error magnitude** | `\|δ\|` | surprise, cheaply | Deployed, `2×` on Atari (Schaul et al. 2016) |
| **Derivative of the error** | `\|δ_now\| − \|δ_last replayed\|` | **unlearnable transitions** — noisy rewards, partial observability, capacity limits, where `\|δ\|` stays high forever | Tried, no gain in near-deterministic environments; the correct test is a stochastic one and it has not been run |
| **Weight-change norm** | `‖Δθ‖` | same, by delegating learnable-vs-unlearnable to an adaptive optimiser that damps high-noise directions | Untested |
| **Sign asymmetry** | boost `δ > 0` over `δ < 0` of equal magnitude | Anna Karenina argument: many ways to be worse than expected, one way to be better, so positive errors are more informative — **and an asymmetry in replay frequency is observed in rats** (Singer & Frank 2009) | Inconclusive |
| **Episodic return** | boost whole episodes by return-to-go | Matches the rodent finding that reward-associated sequences replay more | Proposed from neuroscience, not run |
| **Staleness bonus** | `\|δ_last\| + c·(t − t_last)` | guarantees every transition is revisited; implementable at zero cost by subtracting a multiple of the global step count on each priority update | Untested |
| **Predecessor boosting** | add `\|δᵢ\|` to the priority of the transition *into* `sᵢ` | a large update at a state changes the bootstrap target of everything leading into it — value trickles backward, like eligibility traces; explicitly modelled on **reverse replay in rodents** (Foster & Wilson 2006) and on prioritised sweeping | Proposed; the closest machine analogue of biology's reverse SWR |
| **Novelty in observation space** | any novelty measure | the diversity problem, without stochasticity | Untested |
| **Inverse visitation / cross-episode recurrence** | upsample the under-sampled, keep what recurs | the *transfer* objective, not the sample-efficiency one | Biology's demonstrated criterion ([[wiki/concepts/offline-replay.md]], [[wiki/concepts/recall-gated-consolidation.md]]); no machine implementation |
| **Uniform coverage of arrivals** | reservoir, `min(n/t,1)` | catastrophic forgetting across tasks | Best rule measured in continual RL ([[wiki/entities/continual-dreamer.md]]) |
| **Expected value of backup** | `Gain(s,a) × Need(s)` | the criterion `\|δ\|` is a proxy *for* — value of the update to behaviour, times how often the update will be used | Derived from first principles and validated against rodent replay, never run in a machine learner (Mattar & Daw 2018; section below) |

**Hybrids are free.** Nothing stops sampling one fraction of each minibatch under one criterion and the rest under another — a straightforward answer to the arbitration problem [[wiki/concepts/offline-replay.md]] raises for the eight jobs it assigns to one substrate, and one nobody has run **(brainstorm)**.

## The normative criterion: `EVB = Gain × Need`

Mattar & Daw 2018 (`raw/mattar-2018-prioritized-memory-access.md`) ask the question this page's table samples heuristically: **what is the priority, if you derive it rather than propose it?** The unit of computation is one Bellman backup — pick a stored experience `e_k = (s_k, a_k, r_k, s'_k)` and apply the TD update to `Q(s_k,a_k)` off-policy. The utility of doing so is the extra return it buys.

```
EVB(s_k,a_k) = E_πnew[ Σ γⁱR_{t+i} | S_t=s ] − E_πold[ Σ γⁱR_{t+i} | S_t=s ]
             = Need(s_k) × Gain(s_k,a_k)

Gain(s_k,a_k) = Σ_a Q_πnew(s_k,a)·[ π_new(a|s_k) − π_old(a|s_k) ]
Need(s_k)     = Σ_i γⁱ δ_{S_{t+i}, s_k}  =  μ_πold(s_k)        ← row s of (I − γT)⁻¹, i.e. the SR
```

The derivation is one rewriting: a backup can only pay off by *changing the policy at the target state*, and that payoff is collected once per future visit to that state. So a sum over all future timesteps factorises into (per-visit improvement) × (discounted expected visits).

| Term | What it is | Where it points | Where the agent gets it |
|---|---|---|---|
| **Gain** | Improvement in expected return at `s_k` from the policy change the backup induces, evaluated under the *new* `Q` | **Behind** the agent after a surprise — value has to be pushed back to the predecessors where it changes a choice | Requires knowing the backup's effect **before** deciding to do it |
| **Need** | Discounted count of expected future visits to `s_k` from the current state | **Ahead** of the agent — the states about to be used | Free: it is the [[wiki/concepts/successor-representation.md]] row for the current state; during sleep, the stationary distribution |

**The product is a conjunction, not a sum.** A backup that changes behaviour at a state never to be revisited has zero utility; so does a backup at a high-traffic state that changes nothing. Both single-term criteria — `|δ|` (gain-like, no need) and inverse-visitation (need-like, no gain) — are the degenerate corners of this rule.

### One operation, three phenomena

Ordering backups by `EVB` in a grid-world, with no parameter fitting, reproduces the replay literature:

| Which term dominates | Sequence produced | Matching recording |
|---|---|---|
| Gain, after an outcome | **Reverse**, from the agent back toward the start, depth-first (each backup makes its own predecessor the next-best backup) | Reverse SWR sequences at reward receipt (Foster & Wilson 2006; Ambrose et al. 2016) |
| Need, before a run | **Forward**, from the agent toward the goal (an `n`-step backup extends to `n+1` and carries every preceding action) | Forward replay at the start of a run, initiation bias at the animal's location |
| Need under the stationary distribution, agent absent | **Remote/offline**, concentrated on the rewarded arm of a T-maze | Sleep replay biased to rewarded regions (Ólafsdóttir et al. 2015) |

This is the paper's central architectural claim (and the wiki's first branch-selection rule derived from expected return rather than proposed — `G15`): **planning, learning and consolidation are not three functions competing for one substrate — they are one operation (propagate value along the graph) whose direction is set by which of two terms is larger.** That is a direct, and partial, answer to the arbitration problem [[wiki/concepts/offline-replay.md]] raises: three of its eight jobs collapse into one scalar comparison.

### Four places it separates from `|δ|` and from prioritised sweeping

Prioritised sweeping triggers on any large prediction error and propagates backward, breadth-first. `EVB` differs in ways that are *measured*, not stipulated:

| Prediction | `EVB` | `\|δ\|` / PS | Data |
|---|---|---|---|
| Reward **increase** at the end of a run | more reverse replay | more | Confirmed for both |
| Reward **decrease** (to zero) at the end of a run | **less** reverse replay — the news is bad but no better action exists, so gain ≈ 0 | more (`\|δ\|` is symmetric) | Reverse replay *decreases* (Ambrose et al. 2016) — discriminating |
| **Negative** outcome with an escape available (shock zone) | large gain: propagating it makes the agent stop going there | large | Replay extends toward a previously shocked track end the animal never enters (Wu et al. 2017) |
| Direction and shape | forward **and** backward; extended sequences, because need channels the search along a trajectory | backward, breadth-first | Recorded sequences are extended and bidirectional |

The reward-decrease row is the sharp one. `|δ|` cannot produce a *decrease* in replay from a large error; gain can, because gain is defined over policy change and not over surprise. **Surprise is a proxy for the value of a computation; it is not the value of a computation, and the sign asymmetry is where the proxy visibly fails.**

### Familiarity: the two terms move in opposite directions

| With experience | Gain | Need | Net observable |
|---|---|---|---|
| Prediction errors shrink, policy stabilises | **↓** | — | Fewer significant replay events overall (matches novel > familiar tracks) |
| Behaviour crystallises onto a route | — | **↑ concentrated** | Conditional on an event occurring, well-travelled states participate *more* (matches dwell-time-dependent reactivation) |

This dissolves an apparent inconsistency in the replay literature — reports of replay both increasing and decreasing with familiarity are measuring different dependent variables, one dominated by each term. It also yields an asymmetry with teeth for a builder: **only real experience updates need; replay updates only gain.** Replay is therefore self-extinguishing — it can consume the value of its own remaining computations but cannot manufacture new relevance. A buffer read policy built on this rule needs no separate annealing schedule.

### What it does not supply

- **Gain is not computable by the agent it is defined for.** It requires knowing how the backup will change the policy *before* choosing whether to run it. The paper is explicit that this is a normative bound, not a mechanism; a process model needs an approximation, and none is offered. Need has no such problem — it is the SR.
- **Myopia.** `EVB` is per-backup and ignores that a backup can set up later, more valuable backups. The recursive gain that generates extended sequences is therefore an emergent by-product rather than something the objective prices.
- **No uncertainty.** The simulated environments are deterministic and stationary, so nothing in the rule prices the *variance* of a value estimate — the term any real deliberation account needs, and the one the model's own predecessors (Daw et al. 2005) had.
- **One scale.** Backups are single transitions; with temporally extended actions the prioritisation is claimed to carry over unchanged, over trajectories rather than states — asserted, not run ([[wiki/concepts/temporal-abstraction-options.md]]).
- **A fixed budget.** 20 planning steps at each episode boundary, hand-set. The rule orders computations; it does not say how many to buy — `G15`'s *how deep* clause ([[wiki/architectural-gaps.md]]).

### The machine translation nobody has run

`p_i = |δ_i|` → `p_i = Gain_i × Need_i` is a drop-in replacement for the priority in this page's sum-tree, and **half of it is already free** in any agent maintaining a successor representation or a learned transition model. The other half is the obstacle: gain requires a counterfactual policy evaluation per candidate transition.

**(brainstorm) Three cheap surrogates the paper's own simulations motivate.** (i) *Advantage gap* — approximate gain by `max(0, |δ_i| − [Q(s,a₁) − Q(s,a₂)])`, the amount by which the error exceeds the current margin between the top two actions; zero exactly when the update cannot flip the argmax, which reproduces the reward-decrease asymmetry at the cost of one comparison. (ii) *Softmax-shift* — under a `β`-softmax the policy change is `≈ β·π(a|s)(1−π(a|s))·δ`, so gain is `|δ|` gated by the target state's *policy entropy*: prioritise error at states where the agent is still undecided, deprioritise it where it is committed. This costs nothing and is the single-line version of the whole result. (iii) *Need from the buffer* — the SR row is estimable by counting how often stored successors of the current state appear downstream, so need is available even without a model.

**(brainstorm) The sharper consequence for this wiki is that the two failure modes of `|δ|` have the same fix.** This page already notes that `|δ|` burns replay on *unlearnable* transitions, where error stays high forever. Gain kills those for free: an unlearnable transition's error is noise, so it does not systematically move the policy, so its gain is ≈ 0 in expectation even while `|δ|` is large. And need kills the *stale* transitions the aliasing regime accumulates. So `Gain × Need` is not merely a better prior — it is the criterion the derivative-of-error and staleness-bonus rows in the table above were each groping toward with one term.

## `(α, β)` is a two-knob family that contains the standard off-policy corrections

| Setting | Recovers |
|---|---|
| `α = 0, β = 1`, `w = ρ` | weighted importance sampling |
| `α = 1, β = 0`, `p = min(1, ρ)` | rejection sampling |
| `p = ρ·\|δ\|` | hybrid: off-policy correction × expected learning progress |

`ρ` = the on-policy/behaviour likelihood ratio. **The interesting content is that off-policy correction and learning-progress prioritisation are the same knob**, so a system needing both does not need two mechanisms — and the interpolated settings, which nothing uses, are exactly where high-variance `ρ` would be tamed.

## It is not specific to reinforcement learning

Prioritised *supervised* learning: sample the dataset non-uniformly by last-seen error. On class-imbalanced MNIST (99% of digits 0–4 removed from train, test left balanced), **uninformed** prioritised sampling (`α = 1, β = 0` — given no hint that the test distribution differs) approaches the generalisation of an **informed** uniform baseline that was told to reweight the rare classes 100×, and learns faster. Mechanism: rare-class errors shrink more slowly, so those samples are drawn disproportionately, while the common-class samples that get drawn are the ones near the decision boundary — hard-negative mining and re-balancing falling out of one rule that knows about neither ([[wiki/concepts/shortcut-learning.md]]).

**(brainstorm) This is the strongest single argument that prioritisation is not an RL trick.** A rule with no access to class labels recovers most of the benefit of knowing them. If the same holds for *structural* rarity — rare relations, rare compositions — then error-driven sampling is a cheap partial substitute for the curriculum that [[wiki/concepts/compositionality.md]] keeps needing and nobody can specify.

## The extension nobody ran: prioritised *storage*

Schaul's §6 is explicit that his paper prioritises only *which stored transition to replay*, and that the same signal should govern **admission and erasure** — drop transitions unlikely ever to be replayed again, which cuts redundancy (frequently visited states have low error) and auto-adapts to what is already learned. He also flags the constraint that makes this urgent: **DQN's memory is dominated by the replay buffer, not by the network.** Two warnings he attaches: erasure is final so it needs a stronger diversity guarantee than down-weighting does (e.g. an age term to prevent cycles), and priority is the natural place to modulate *externally sourced* experience — human demonstrations, planner rollouts — by knowing its source.

**This is the axis [[wiki/entities/continual-dreamer.md]] actually measured**, five years later, and it measured it with the *opposite* criteria winning: reservoir admission beats error-shaped admission. Both papers agree that admission and mini-batch selection are separate control variables; they disagree about which direction each should point.

## The contradiction

Schaul: surprise-prioritised sampling is a 2× speedup and a state of the art. Kessler et al. 2023: uncertainty-proportional sampling is the *worst* rule tried, at the non-continual baseline. Same family of criterion, opposite verdicts — filed as [[wiki/empirical-tensions.md]] T299, whose most likely resolution is that the two are optimising different things (single-task sample efficiency vs. retention across tasks) and that the criterion is correct for one and actively harmful for the other.

## Why this matters for a reasoning model

- **(brainstorm) The Blind Cliffwalk is a latent-graph result in disguise.** The environment is a chain where almost every edge is uninformative and one is not; the oracle's advantage is that it propagates value *backwards along the graph* in the right order. Predecessor boosting is the local, model-free approximation of that ordering, and it is the same operation prioritised sweeping does with a model. So the sampling distribution over a replay buffer is a *substitute for having the transition graph* — [[wiki/concepts/latent-graph-discovery.md]] gets partial credit from a buffer with no graph in it at all, provided the buffer is read in a value-propagating order.
- **The buffer's read policy is a controller.** [[wiki/concepts/offline-replay.md]] assigns eight jobs to one substrate and finds no arbitrator. `P(i) ∝ pᵢ^α` with the criterion swappable *is* the missing arbitrator's interface — one distribution, one exponent, hybridisable per-minibatch. Naming that interface does not tell you the policy, but for the offline jobs that share the buffer — `G14`'s consolidation channel and the replay half of `G15` — it turns "no mechanism" into "one unspecified exponent and one swappable statistic".
- **`|δ|` fails exactly where reasoning lives.** Its known failure mode is *unlearnable* transitions — noise, partial observability, capacity limits — where error stays high forever and the agent replays them forever. In a partially observed, aliased environment (the regime any latent-graph learner is in by construction) high TD error is the signature of a state that *needs splitting*, not of a state that needs more gradient. **(brainstorm)** That suggests a criterion the source does not list: prioritise by `|δ|` when the error is falling and route to *state-splitting* when it is not — making the derivative-of-error criterion a de-aliasing trigger rather than a sampling weight ([[wiki/concepts/pattern-separation-completion.md]], T29).
- **Neuroscience was cited before the fact here, unusually.** §2 opens by citing rodent evidence that high-TD-error transitions are preferentially replayed (Singer & Frank 2009; Foster & Wilson 2006) as motivation, and Appendix A returns to rat asymmetry and reverse replay for its extensions. This is a cleaner case for [[wiki/concepts/neuroscience-ai-transfer.md]] than DQN's replay itself, where the biology was offered afterwards — though the criterion the field then deployed (`|δ|`) is the one biology least supports.

---

## Connections

- **[[wiki/entities/alphazero.md]]** — the design that removes this page's question rather than answering it: self-play regenerates data from the latest parameters, so there is no buffer to sample and the only remaining distribution knob is Dirichlet noise on the search root's prior.

- **[[wiki/concepts/offline-replay.md]]** — the biological object whose sampling filter this page is the machine design space for; the two disagree about direction, since biology upsamples the under-visited and this page's deployed rule upsamples the high-error.
- **[[wiki/entities/dqn.md]]** — the system this modifies: the only change is the sampling rule over an otherwise identical buffer, network, loss and evaluation, which is what makes the exponential Blind Cliffwalk gap attributable to scheduling alone.
- **[[wiki/entities/neural-episodic-control.md]]** — the rival answer to the same sample-efficiency problem, measured head-to-head on the same 57 games: prioritisation changes *when* a stored transition is used to fit weights, episodic control changes *where the value lives*, and the store wins by 2–3× median human-normalised score below 20M frames while prioritisation wins from 40M on — so the two interventions are not competing for the same regime.
- **[[wiki/entities/continual-dreamer.md]]** — the same knob measured across tasks instead of within one, with the opposite outcome, and the paper that actually ran the *admission*-side extension Schaul proposed.
- **[[wiki/concepts/complementary-learning-systems.md]]** — supplies the primary source for that page's "prioritized replay" row and corrects it: the deployed criterion is TD-error magnitude, not reward, and reward-based prioritisation appears only as an unrun neuroscience-motivated alternative.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — a rare case where the rodent finding is cited as motivation *before* the engineering rather than as convergent support afterwards, which makes it the better test case for that page's attribution question than replay itself.
- **[[wiki/concepts/reward-prediction-error.md]]** — the quantity used as the priority is the same `δ` that page tracks as a dopaminergic signal; prioritisation makes `|δ|` a *control* signal over what gets learned next, not only a learning signal.
- **[[wiki/concepts/simulation-based-planning.md]]** — prioritised sweeping is the model-based ancestor of this rule; the difference is that sweeping orders updates using a known transition model and this orders them from stored samples alone.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the Blind Cliffwalk shows that reading a buffer in a value-propagating order substitutes for possessing the transition graph, so replay order is a partial, model-free source of the structure that framing wants.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — an exponential sample-complexity gap produced by the sampling schedule alone, which is a confound for any claim that a sparse-reward failure is representational.
- **[[wiki/concepts/shortcut-learning.md]]** — the class-imbalanced MNIST result: error-driven sampling recovers most of the benefit of label-aware reweighting without knowing the labels, i.e. it counteracts a frequency-driven shortcut for free.
- **[[wiki/concepts/continual-learning.md]]** — replay-buffer selection is the rehearsal family's central free parameter, and this page is the evidence that its setting can dominate the architecture it is attached to.
- **[[wiki/concepts/amortized-inference.md]]** — the "where the cache is stale" replay criterion that page implies is exactly a staleness bonus, listed here as a zero-cost priority term nobody has run.
- **[[wiki/concepts/successor-representation.md]]** — supplies half the normative priority for free: `Need(s_k)` *is* the SR row of the agent's current state, so any agent already caching `S` can compute the occupancy half of `EVB` at no cost, and the SR's own updates carry the same `EVB` as the corresponding value updates (Mattar & Daw 2018).
- **[[wiki/concepts/simulation-based-planning.md]]** — the reframing that makes this page and that one the same question: planning *is* ordering Bellman backups over remembered experience, so a rollout policy and a buffer read policy are one object seen from two ends.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the claimed but unrun extension of `Gain × Need`: prioritisation is asserted to carry over unchanged when the unit of backup is a temporally extended action rather than a single transition, which would make replay a search over options instead of over states.
- **[[wiki/concepts/offline-replay.md]]** — a second, sharper relation: `EVB` collapses three of that page's eight jobs (planning, learning, consolidation) into one operation whose direction is set by which of two terms dominates, which is the only arbitration policy the wiki has for them.
