# Model-Free Episodic Control (MFEC)

**A growing table of the *highest* return ever obtained from each (state, action) pair, read by an unweighted `k`-nearest-neighbour average over a fixed embedding and written by backward sweep at the end of each episode — a value store that is deliberately not an expectation.** Blundell, Uria, Pritzel, Li, Ruderman, Leibo, Rae, Wierstra & Hassabis 2016, arXiv:1606.04460. Source: `raw/blundell-2016-model-free-episodic-control.md`.

The wiki's third primary source for episodic control and the first one chronologically — [[wiki/entities/neural-episodic-control.md]] is its direct successor and has carried its numbers second-hand until now. The reason to page it separately is not the architecture (NEC's is strictly better) but two things NEC does not contain: the **max-return write contract stated as a deliberate restriction of the environment class**, and the **exact-state-revisit statistics of the benchmarks**, which are the only measurement in the wiki of how much of a data-efficiency result is table lookup.

---

## Architecture

| Component | Spec |
|---|---|
| Embedding `φ` | **Fixed, never trained on reward.** Two variants: (i) random projection `φ: x → Ax`, `A ∈ R^{F×D}` Gaussian, `F = 64` — Johnson–Lindenstrauss, so relative distances in pixel space are approximately preserved; (ii) the 64 parameters (32 means + 32 log-standard-deviations) of a VAE posterior `q(z\|x)`, `z ∈ R^32`, trained on 1M frames of a **random policy** |
| Memory | One buffer per action, `(φ(o), value)` pairs; 10⁶ entries per action on Atari, 10⁵ on Labyrinth |
| Read (seen) | Return the stored value exactly |
| Read (novel) | **Unweighted mean of the `k` nearest states' values** — no kernel, no distance weighting. `k = 11` (Atari), `k = 50` (Labyrinth) |
| Write | End of episode, swept **backwards** `t = T…1` |
| Eviction | Least recently updated / used entry |
| Policy | `a_t = argmax_a Q̂^EC(s_t, a)`, `ε`-greedy at `ε = 0.005` |
| Discount | `γ = 1` (Atari), `γ = 0.99` (Labyrinth) |

```
Q^EC(s_t,a_t) ←  R_t                              if (s_t,a_t) ∉ Q^EC
                 max{ Q^EC(s_t,a_t), R_t }         otherwise

Q̂^EC(s,a)   =  (1/k) Σ_{i=1..k} Q^EC(s^(i), a)   if (s,a) ∉ Q^EC
                 Q^EC(s,a)                          otherwise
```

**The `max` is the whole design and the paper says so.** The stored value is an estimate of the *highest potential return* for a state-action pair, not of its expected return, and the authors flag it explicitly: "this is not a general purpose RL learning update: since the stored value can never decrease, it is not suited to rational action selection in stochastic environments." The architecture buys one-shot learning by **restricting the admissible environment class to near-deterministic transitions and rewards** — a design move the wiki has nothing else quite like, because every other agent here claims generality and pays for it in samples.

**Memory is the reason `φ` exists at all, and the number is worth keeping.** One raw 84×84 grey frame is ~28 KB; the experiments would need >300 GB. The embedding is a compression constraint first and an inductive bias second.

---

## Results

**Atari** (Ms. Pac-Man, Q\*bert, River Raid, Frostbite, Space Invaders), against [[wiki/entities/dqn.md]], prioritised replay ([[wiki/concepts/replay-prioritisation.md]]) and A3C:

- MFEC leads **all** baselines through the initial learning phase of every one of the five games.
- Overtaken later on Q\*bert and River Raid. The paper's own diagnosis: as episodes lengthen, the fraction of each episode that is *new* experience falls, and the parametric agents' non-local generalisation takes over.
- Median human-normalised scores across all 57 games are reported by the successor, not here — 12.8% at 1M, 45.4% at 10M, 61.9% at 40M frames ([[wiki/entities/neural-episodic-control.md]]).

**Labyrinth** (3-D, first-person, 8 actions, against A3C):

| Level | Result |
|---|---|
| Forage (apples, reward +1) | MFEC finds an apple-seeking policy very quickly; A3C catches up and eventually wins with a more efficient route |
| Forage and Avoid (apples +1, lemons −1) | MFEC reaches the target score in **<3M frames**; A3C needs **>40M** |
| Double-T-Maze (colour cue at each junction, 1 apple / 3 lemons, sparse) | MFEC reaches positive expected reward at 20–30M frames; **A3C never exceeds zero at any budget** |

**Exact-state-revisit rate — the measurement that makes the rest interpretable:**

| Environment | Fraction of state-action pairs exactly matched in the buffers |
|---|---|
| Q\*bert | **60%** |
| Ms. Pac-Man | 50% |
| Space Invaders | 45% |
| Frostbite | 10% |
| River Raid | 10% |
| Labyrinth, all three levels | **<0.1%** |

Atari is deterministic with 30 possible initial states; Labyrinth is deterministic but randomises initial location and facing. So the Atari result is between 10% and 60% literal table lookup, and the Labyrinth result is essentially all interpolation. Logged as [[wiki/empirical-tensions.md]] `T353`.

**Effect of `k` — the instrument that separates lookup from interpolation:**

| Environment | Score vs. `k` |
|---|---|
| Atari, VAE features | **Flat** — no gain with more neighbours, except Q\*bert |
| Labyrinth, VAE features | **Strongly increasing** |

The authors read this exactly as it should be read: `k`-sensitivity is evidence that the neighbours are *doing* something, so it is a direct test of whether a store is generalising or retrieving. The wiki has no other cheap instrument for that question.

**Embedding comparison:**

| Setting | Random projection vs. VAE |
|---|---|
| Atari (high revisit) | No notable difference; random projection equal or better |
| Frostbite | VAE **worse** — a random policy cannot get far into the game, so the VAE's training set covers almost none of the relevant state space |
| Labyrinth (no revisit) | VAE better, and it is what makes the `k`-sweep gain possible |

**The Frostbite failure is the generalisable finding, not the footnote.** The representation was trained off a *random policy's* state distribution, so its coverage is bounded by the exploration that collected it — a learned embedding inherits the competence of whatever policy generated its data. That is a data-schedule claim ([[wiki/concepts/curriculum-learning.md]], `G32`), arriving from the representation-learning side rather than the training-order side.

**`ε = 0.005` is a factor of ten below DQN's and A3C's**, and the stated reason inverts the usual argument: "more exploration makes exploiting what is known harder". A one-shot learner needs less exploration because a single lucky trajectory is already permanently captured — which is also why Double-T-Maze works at all.

---

## Limitations

| Limitation | Consequence |
|---|---|
| **`max` is optimistic and never corrects** | In any stochastic environment the store converges to the best outcome ever observed, not the expected one. The environment class is restricted by the write rule, not by an assumption that can be relaxed ([[wiki/empirical-tensions.md]] `T352`) |
| **Unweighted `k`-NN read** | Every one of the `k` neighbours counts equally regardless of distance; NEC's inverse-square kernel is the direct fix, and `k` itself is a hand-set constant with no occupancy or margin term (`G42`) |
| **`φ` is fixed and reward-blind** | Random projections cannot resolve the few pixels that carry value; VAE latents spend capacity on reward-irrelevant detail. Learning the metric from reward is worth ~20 median points at 10M frames (NEC) |
| **No consolidation channel** | The table is the policy; nothing distils it into a function, which is what the late-training crossover measures (`G14`) |
| **Ungated write, heuristic eviction** | Everything is written; the oldest-touched entry is discarded, with no capacity signal (`G19`, `G42`) |
| **No transition model** | No re-goaling, no composition of a learned environment with a new reward (`G28`) |
| **Backward sweep is presented as replay and is not tested as one** | See below |

---

## Comparison

| System | Value written | Read | Embedding | Environment class assumed |
|---|---|---|---|---|
| **MFEC** | `max` over Monte Carlo returns | Unweighted mean of `k` NN | **Fixed** (random projection or VAE) | Near-deterministic, stated |
| [[wiki/entities/neural-episodic-control.md]] | `N`-step return, tabular Q-learning update at large `α` | Kernel-weighted 50-NN, `1/(d²+δ)` | **Learned by TD** | General (the update can decrease) |
| [[wiki/entities/hami.md]] | Cumulative return, keep the `max` | **Exact match** on a quantised symbol window | Frozen contrastive, then quantised | Near-deterministic, unstated |
| [[wiki/entities/dqn.md]] | — (buffer of transitions) | — | Learned by TD | General |

**MFEC and HAMI take the same side of the write contract and NEC takes the other.** Two of the wiki's three primary episodic-control sources keep the maximum and one tracks an expectation; only MFEC states what that costs. See `T352`.

---

## Why this matters for a reasoning model

- **(brainstorm) The revisit statistic is a benchmark property the wiki should demand of every sample-efficiency claim, and it is nearly free to compute.** A data-efficiency advantage measured on an environment with a 60% exact-revisit rate is mostly a measurement of the environment. MFEC is the only agent in the wiki that reports the number for its own benchmarks, and it reports it *against itself* — the Labyrinth experiments exist precisely because the Atari numbers are not interpretable without it. The general form: **before crediting a system with generalisation, report what fraction of its test-time queries it has literally seen.** The same statistic is undefined for most of the wiki's benchmarks not because it is hard but because nobody asks ([[wiki/concepts/human-baseline.md]], `G17`).
- **(brainstorm) `k`-sensitivity is the agent-side half of that instrument, and it is cheaper than any probe.** Sweep the number of neighbours the read averages over; a flat curve says the store is a lookup table, a rising curve says the neighbours carry information. It needs no labels, no retraining and no held-out split, and unlike a linear probe it measures the *deployed* read path rather than a surrogate one. The wiki's other fast stores ([[wiki/entities/hami.md]], NEC, [[wiki/entities/sparse-distributed-memory.md]]) each have a read width that could be swept the same way and none of them was.
- **(brainstorm) Restricting the environment class is an underused design move.** Every architecture in the wiki is built for general stochastic environments and pays a sample-complexity tax for a generality the target domains may not need. MFEC's `max` rule is the one clean instance of the opposite bet: declare determinism, get one-shot learning, and state the failure mode. For a reasoning model over near-deterministic latent graphs — which is what [[wiki/concepts/latent-graph-discovery.md]] describes — the tax may be avoidable in the same way, and the question is *which* of the wiki's modules could legitimately declare determinism rather than whether any could.
- **The backward sweep is a replay claim the paper does not test.** The update loop runs `t = T…1` and is offered as an algorithmic instance of awake reverse replay (Foster & Wilson 2006). But with Monte Carlo returns and a `max` write, the *result* is order-independent — every `R_t` is computable in either direction and the max is commutative. So the backward sweep here is an implementation convenience, and the biological analogy is decorative, unlike in TD-based schemes where reverse order genuinely accelerates credit propagation. A live case of the pattern [[wiki/concepts/neuroscience-ai-transfer.md]] tracks: the neuroscience cited after the fact for a device chosen on other grounds.
- **The arbitration proposal is the paper's most substantive theoretical contribution and it is two-factor.** The discussion posits **four** control systems — model-based planning (prefrontal), habitual model-free (dorsolateral striatum), model-free episodic (hippocampal, this paper), and model-based episodic — and claims the selector runs on *decision time and working-memory resources available* first, and on *the residual uncertainty of the slower system* second. That is a sharper answer than the uncertainty-only account ([[wiki/concepts/complementary-learning-systems.md]]'s "when to trust the fast system"): under time pressure the planning options are simply unavailable, so the arbitration is over a *reduced* set rather than reweighted. The predicted experiment is stated and, as far as the wiki knows, unrun — manipulate decision timing or load working memory with an orthogonal task, and measure medial-temporal-lobe-to-output coherence under different statistical conditions.
- **Scrub jays are the paper's argument that episodic control is not merely a warm-up phase.** A bird caching food is better off recalling the exact hiding spot than sampling from a distribution over likely locations (Clayton & Dickinson 1998). Where the reward structure is a set of *particulars* rather than a statistical regularity, the instance store is the asymptotically correct system and no amount of consolidation improves it. This bounds `G14`: the consolidation channel the wiki keeps asking for is not universally desirable, which is the same conclusion [[wiki/concepts/generalization-optimized-consolidation.md]] reaches from the analysis side.

---

## Connections

- **[[wiki/entities/neural-episodic-control.md]]** — the direct successor, which keeps the store and replaces all three of its weak parts: fixed embedding → TD-learned, unweighted `k`-NN → inverse-square kernel, `max` over Monte Carlo returns → tabular Q-learning on `N`-step returns, worth ~20 median human-normalised points at 10M Atari frames.
- **[[wiki/entities/hami.md]]** — the other store that keeps the maximum rather than the expectation, reached from the opposite direction: quantise the key to a symbol and read by exact match, which makes the near-determinism assumption implicit where MFEC states it.
- **[[wiki/entities/dqn.md]]** — the parametric agent MFEC is set against, and the source of the 84×84 grey-scale preprocessing it inherits; the contrast is that DQN's expected-return objective is what forces both the sample cost and the ten-times-higher exploration rate.
- **[[wiki/concepts/complementary-learning-systems.md]]** — supplies that page's episodic-control row with its founding architecture, and its open problem "when to trust the fast system" with a two-factor answer: time-and-working-memory availability gates which systems are *available*, uncertainty then selects among those.
- **[[wiki/concepts/replay-prioritisation.md]]** — the rival use of the same experience: prioritisation reorders what a parametric learner fits, MFEC stores the return itself and never fits anything, and the two are compared on the same five Atari games.
- **[[wiki/concepts/offline-replay.md]]** — the backward end-of-episode sweep is the wiki's clearest case of reverse replay cited as provenance for an update whose result is order-independent, so it belongs in that page's ledger as an analogy rather than a mechanism.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the read is maximal completion with no separation control at all: an unweighted average over `k` neighbours however far away they are, which is the extreme NEC's kernel choice was made to back away from.
- **[[wiki/concepts/curriculum-learning.md]]** — the Frostbite VAE failure is a data-schedule result in disguise: the embedding is trained on a random policy's state distribution and inherits its coverage, so representation quality is bounded by the policy that collected the data.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — supplies that page's "unlimited experience" channel with a measured example running the other way: MFEC is close to the locality-sensitive hashtable the page names as the degenerate case, and the revisit statistics say how close, per benchmark.
- **[[wiki/concepts/latent-graph-discovery.md]]** — an agent that declines the inference problem entirely and still gets positive reward on a sparse, cue-conditioned maze where a policy-gradient learner gets none, purely because one successful trajectory is never forgotten.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — a two-way entry: the reverse-replay citation is post-hoc decoration, while the instance-vs-statistics division of labour genuinely shaped the architecture, so the same paper sits on both sides of that page's ledger.
- **[[wiki/concepts/memory-read-and-erase.md]]** — write everything, erase by least-recently-used, with the only content-sensitivity in the *value* (keep the max) rather than in the write decision.
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — the scrub-jay argument is the behavioural form of that page's analytical result: for a relation the slow learner cannot model, the optimal amount of transport out of the fast store is zero.
- **[[wiki/concepts/simulation-based-planning.md]]** — named in the paper's own taxonomy as the system MFEC is *not*: the discussion's fourth cell, model-based episodic planning, is conjectured and never built, here or anywhere in the wiki.
