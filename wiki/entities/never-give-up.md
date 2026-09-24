# Never Give Up (NGU) — A Novelty Bonus Read From an Episodic Store That Is Wiped Every Episode

**An exploration bonus computed by a `k`-nearest-neighbour query over a per-episode store of the agent's own embeddings: `r^episodic_t ≈ 1/√(Σ_{f_i ∈ N_k} K(f(x_t), f_i) + c)`, where `f` is trained only by inverse dynamics. It is multiplied by a slow, life-long Random Network Distillation (RND) factor. The store is emptied at every episode start, so the bonus never runs out over training. A Universal Value Function Approximator (UVFA) `Q(x, a, β_i)` learns `N` policies on one set of weights, from purely exploitative (`β₀ = 0`) to most exploratory (`β_{N−1} = β`). Each `β_i` gets its own discount.**

> **Provenance.** Badia, Sprechmann, Vitvitskyi, Guo, Piot, Kapturowski, Tieleman, Arjovsky, Pritzel, Bolt & Blundell 2020, *Never Give Up: Learning Directed Exploration Strategies*, ICLR 2020 / arXiv:2002.06038 (`raw/badia-2020-never-give-up-learning-directed-exploration-strategies.md`). Base agent: R2D2 (Recurrent Replay Distributed DQN), 256 actors, 35B frames per run, 3 seeds. Environments: Random Disco Maze (pycolab) and all 57 Atari games. Everything below is from that source unless marked. Learning curves are figures only; the numbers below come from Tables 1–5 and 10 and from the text.

---

## Architecture

| Component | Spec | Note |
|---|---|---|
| **Embedding `f : 𝒪 → ℝᵖ`** ("controllable state") | Siamese convolutional net; `p(a \| x_t, x_{t+1}) = h(f(x_t), f(x_{t+1}))`, `h` = 1-hidden-layer MLP + softmax, trained by maximum likelihood on the last 5 frames of each replayed sequence | The inverse-dynamics filter of [[wiki/entities/intrinsic-curiosity-module.md]], with **no forward model**. `p = 32` works best on Montezuma's Revenge; 16 is unstable |
| **Episodic memory `M`** | Slot store of `f(x_0) … f(x_{t−1})`; **emptied at episode start**; capacity 30,000, ring buffer | Every step writes one entry. Nothing is gated or consolidated |
| **Episodic bonus** | `k = 10` neighbours; inverse kernel `K(x,y) = ε / (d²(x,y)/d²_m + ε)`, where `d²_m` is a running mean of the squared `k`-th-neighbour distance. Distances below cluster distance `ξ = 0.008` are set to 0. `r = 0` if similarity `s > s_m = 8`, else `1/s` | A pseudo-count `1/√n` (after Strehl & Littman), with `n` replaced by kernel mass. A Dirac `K` makes the count exact and removes all generalisation |
| **Life-long factor `α_t`** | RND error, normalised: `α_t = 1 + (err(x_t) − μ_e)/σ_e` | Changes by gradient descent, so slowly. The episodic term changes with every memory write, so fast |
| **Combined bonus** | `r^i_t = r^episodic_t · min{max{α_t, 1}, L}`, `L = 5` | Multiplicative. `α_t` is clipped from below at 1, so as RND's novelty fades the bonus falls back to the unmodulated episodic term, **not to zero** |
| **Policy family** | UVFA `Q(x, a, β_i)` over `r^{β_i} = r^e + β_i r^i`, `N = 32`. `β_i` follows a sigmoid schedule that crowds values near 0 and near `β = 0.3` | One network. The `β_i` one-hot, the previous action and the previous `r^i` and `r^e` are all inputs |
| **Discount per policy** | `γ_i` spaced evenly in log(1 − γ), from `γ_0 = 0.997` (exploit) to `γ_{N−1} = 0.99` (most exploratory) | The dense intrinsic reward allows a short horizon. The sparse extrinsic reward needs a long one |
| **Learner** | Transformed Retrace double-Q loss; R2D2 LSTM; prioritised replay of length-80 sequences | Feeding `r^i` in as an input is the authors' fix for the non-Markov reward the bonus creates |
| **Actors** | Actor `j` is fixed to `β_{j mod (N−1)}`, `ε`-greedy | **The exploration degree is assigned per actor by rule. Nothing learns which `β` to act with.** Evaluation acts greedily at `β₀ = 0` |

### Three properties the bonus is built to have

| # | Property | Mechanism |
|---|---|---|
| (i) | Fast discouragement of revisits **within** an episode | Every step writes to `M` |
| (ii) | Slow discouragement of states visited many times **across** episodes | `α_t` from RND, trained by gradient descent |
| (iii) | Ignores what the agent cannot affect | `f` is trained only to predict the agent's action |

---

## Results

### Random Disco Maze (no extrinsic reward, `N = 1`, `β = 0.3`)

A new random 21×21 maze each episode. Walking into a wall ends the episode. **Every wall fragment is recoloured at random from 5 colours at every step**, so the agent almost never sees the same observation twice.

| Embedding `f` | Behaviour |
|---|---|
| Learned (inverse dynamics) | Covers the maze by a depth-first-search-like strategy: goes as deep as possible along a branch, then backtracks, often a few dozen steps, to an unexplored branch |
| Fixed random projection | No directed exploration. Learns to avoid walls, then oscillates between two cells: the colours make every step novel |
| RND baseline | Same as random projection |

Both failing agents learn to avoid walls because termination "would limit the amount of intrinsic reward it would receive".

### Six hard-exploration Atari games (Table 1; mean ± s.e., 3 seeds, 35B frames)

| | Gravitar | Montezuma | Pitfall! | Private Eye | Solaris | Venture |
|---|---|---|---|---|---|---|
| Human | 3.4k | 4.8k | 6.5k | 69.6k | 12.3k | 1.2k |
| Best baseline (per game) | 15.7k | 11.6k | 0.0 | 11k | 5.5k | 2.0k |
| RND (as published) | 3.9k | 10.1k | −3 | 8.7k | 3.3k | 1.9k |
| R2D2 + RND (same budget) | 15.6k | 10.4k | −0.5 | 19.5k | 4.3k | 2.7k |
| R2D2 (Retrace) | 13.3k | 2.3k | −3.5 | 32.5k | 6.0k | 2.0k |
| NGU(`N=1`) without RND | 12.4k | 3.0k | **15.2k ± 9.4k** | 40.6k | 5.7k | 46 |
| NGU(`N=1`) | 11.0k | 8.7k | 9.4k | 60.6k | 5.9k | 876 |
| **NGU(`N=32`)** | 14.1k | 10.4k | 8.4k | **100.0k** | 4.9k | 1.7k |

- **Pitfall!:** the first non-zero score without demonstrations, hand-crafted features or state restoration (authors' claim). NGU(`N=32`) explores **46 rooms per episode** on average and crosses 14 rooms before the first extrinsic reward.
- **RND hurts on Pitfall! and helps on Montezuma's Revenge.** Montezuma without RND: 3.0k (`N=32`, Table 3) against 10.4k with it. The authors give three hypotheses for Pitfall!: rooms alias each other, so a new room earns little life-long novelty; the on-screen timer is a spurious novelty source; and RND-driven agents keep "interacting with danger". None is tested.
- **`N=32` beats `N=1` on 4 of 6 hard games**, and on Pitfall! the reverse holds. The authors' reading is that exploration and exploitation policies are nearly the same there.

### Ablations on 8 games (Table 3; 5 dense-reward + Montezuma, Pitfall!, Private Eye)

| Change from NGU(`N=32`, `β=0.3`, CMR (Cross-Mixture Ratio) = 0) | Hard games | Dense games |
|---|---|---|
| `N = 2` / `8` | Pitfall! −1.6 / −1.9; Private Eye ~40k. Superhuman only on Montezuma | error bars overlap |
| `N = 16` | Pitfall! 5.0k; Private Eye 52.0k | overlap |
| **CMR = 0.5**: half of each policy's batch comes from other `β`s | slightly worse on average (Montezuma best, 12.0k) | overlap |
| `β = 0.2` / `0.5` | worse on average | overlap |
| **Without RND** | Montezuma 3.0k; Pitfall! 7.7k; Private Eye 40.5k | overlap |
| **Without `r^e`** (intrinsic reward only) | Montezuma 3.4k; Pitfall! 600 | Still **superhuman on average across the 5 dense games**. Breakout scores 383 by surviving |

- **CMR result:** "the power of acting differently for different conditioning mixtures is mostly acquired through the **shared weights** of the model rather than shared data".
- **Selection caveat:** the hyperparameters were grid-searched on these same 8 games. The rule was "most games above human", and only NGU(`N=32`) is superhuman on all 8.

### Atari-57 and the two ends of the family

| Agent | Median human-normalised score |
|---|---|
| Nature DQN | 95% |
| IMPALA (Importance Weighted Actor-Learner Architecture) | 191.8% |
| R2D2 (Retrace) | 1451.8% |
| **NGU(`N=32`)** | **1354.4%** (the abstract says 1344.0%; the source is inconsistent) |
| R2D2 | 1920.6% |

- Above human on **51 of 57** games. It stays below R2D2 on the median. On Breakout and Beam Rider NGU(`N=32`) gives 532.8 / 68.7k against R2D2's 837.7 / 188.2k. The authors' reading: the intrinsic signal "still slightly interfere[s]" with the exploitative head through the shared representation.
- **NGU(`N=1`) fails on Pong (−9.4)**; `N=32` recovers it (19.6). A single policy with a non-vanishing bonus cannot turn exploration off.
- **Acting at `β₀ = 0` vs `β₃₁ = 0.3`** (Figure 6, Table 10) gives three regimes:
  1. Both converge to the same policy (Q\*Bert; the commonest case).
  2. The heads diverge, and the exploitative head profits from what the exploratory ones found (Pitfall! 7.8k vs 1.3k; R2D2 never scores).
  3. The exploratory head scores higher: Montezuma's Revenge 16.8k at `β = 0.3` vs 10.4k at `β = 0`. Scores above 16k need the second level, which takes "many non-greedy and sometimes irreversible actions". The exploit head does not consolidate that route.
- **Adversarial pairs fail.** On Surround and Ice Hockey the exploratory and exploitative policies are "almost adversarial" and one parameterisation cannot hold both (Surround −9.6 vs R2D2(Retrace) 9.8; Ice Hockey −4.1 vs 85.1).

### Appendix I — what the controllable state holds, and an oracle

| Measurement | Result |
|---|---|
| Linear probe of `f` for the agent's `(x, y)` (Montezuma), gradients stopped | Error ~12 units, under 10% of the range. Stays flat as new rooms are found |
| Same, for room identity (24 rooms) | ~20% error against 96% chance. **Present although inverse dynamics does not need it**, with error jumps as rooms are added |
| NGU(`N=1`) with an **oracle** controllable state (RAM: `x`, `y`, room + 24·level, keys held) | Higher score than with learned `f`. With RND: close to 15,000 mean and 25 rooms per episode; 3/5 seeds reach level 2, one reaches level 3. Without `r^e`: still a very high extrinsic score and >20 rooms |
| Oracle state + **memory kept across 3 episodes** (a "meta-episode") | The agent picks **a different key–door combination in each of the 3 episodes**. Score 14,660 ± 196 in the first episode after a wipe, **34,040 ± 9,835** in the third; >30 rooms; reaches level 2 consistently. **Not seen with learned `f`**: the authors presume the keys-held signal in `f` is too weak |

The probe has no control (no random-`f` or untrained-`f` baseline), so "present" means linearly decodable from this `f`. It does not show that the bonus reads it.

---

## Limitations

| Limitation | Consequence |
|---|---|
| **The exploration degree is not selected** | Actors are hard-assigned `β_i`, and evaluation always uses `β₀`. `β` is grid-searched and depends on the extrinsic reward's scale. Adapting `β` by Population-Based Training or meta-gradients is left as future work (`G61`) |
| **One representation for all `β`** | Measured interference on Breakout and Beam Rider. Failure when the policies are adversarial (Surround, Ice Hockey). The authors propose non-shared representations |
| **The exploit head does not always absorb the exploratory head's finds** | Montezuma: 16.8k exploratory vs 10.4k exploitative. Long-horizon credit through irreversible, non-greedy steps is not transferred by weight sharing |
| **Two-step inverse dynamics defines "controllable"** | Consequences that take more than one step to show are invisible to `f`, as the authors state. The oracle-state gap (~15k with RND, 34k with meta-episodes, vs 10.4k learned) prices what `f` misses |
| **The wipe does the non-exhaustion** | The bonus stays alive because the store is reset, not because anything grows. Within an episode it still falls as `M` fills (`G129`) |
| **The life-long factor is RND with its failure modes** | Room aliasing, timers and danger-seeking are hypothesised to make it hurt on Pitfall! |
| **Budget and seeds** | 35B frames, 256 actors, 3 seeds. Hyperparameters tuned on the 8 ablation games |
| **No state restoration, but also no global frontier** | Meta-episode key–door diversity appears only with the oracle state. With learned `f` the key-saving failure of [[wiki/entities/random-network-distillation.md]] is not shown to be fixed |

---

## Comparison

| | **NGU** | [[wiki/entities/random-network-distillation.md]] | [[wiki/entities/intrinsic-curiosity-module.md]] | [[wiki/entities/go-explore.md]] | [[wiki/entities/neural-episodic-control.md]] |
|---|---|---|---|---|---|
| Where novelty lives | Per-episode `k`-NN store × a parametric RND factor | Predictor weights | Forward-model weights | Persistent archive of cells | — (the store holds returns) |
| Typology cell ([[wiki/concepts/intrinsic-motivation-typology.md]]) | UM (a count over the store), modulated by UM-in-NM form | UM in NM form | NM | UM, used as a selection weight | none |
| Stochastic-trap defence | Inverse-dynamics embedding, no forward model | Deterministic target | Inverse-dynamics embedding + forward error | Nothing is predicted | — |
| Profile over training | **Does not vanish**: reset each episode; the RND factor fades to 1× | Falls, at a fixed rate | Falls to ~0 | Weight `1/√(C+1)` falls; archive persists | — |
| Explore/exploit separation | `β`-conditioned heads on shared weights | One policy, two value heads | One policy | Separate phases: explore, then robustify | — |
| Montezuma's Revenge | 10.4k (`β₀`); 16.8k (`β = 0.3`); 34k with oracle state + meta-episode | 8,152 mean; 17,500 best | not run | 1.7M / 97,728 | 42.1 @ 10M frames |
| Pitfall! | 8.4k (`N=32`); 15.2k (`N=1`, no RND) | −3 | not run | 102,571 / 20,093 | — |

**The kernel is borrowed from episodic control.** NGU's `K` is the inverse-square kernel of [[wiki/entities/neural-episodic-control.md]], with the same `k`-NN read over a slot store. NEC reads the store for **value**; NGU reads it for **density**, and the density is the reward.

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| `f` | A node space fixed by what one step of the agent's own action tells apart (as in ICM). It also keeps room identity, which inverse dynamics does not need (Appendix I) |
| `M` within an episode | The walk so far, as a set of visited nodes. The bonus is inverse kernel density over that set, so it scores nodes and never edges |
| Episodic bonus behaviour | Depth-first traversal emerges in Disco Maze: a per-episode visited set plus a density penalty is enough to produce depth-first search with backtracking, with no stack or frontier stored explicitly |
| Meta-episode memory | Keeping `M` across 3 episodes makes the reward a penalty on *repeating a previous episode's path*, so the agent enumerates alternative branches (key–door combinations) over episodes. **(brainstorm)** This is an episode-level search over paths, with the store as the closed list |
| `β` family | A set of traversal policies over one graph model, indexed by how much unexplored structure is worth. Nothing chooses among them online |

**(brainstorm) What the page offers `G129`.** NGU is the first reward on the wiki computed as a **query over the agent's own store**. That is the structural move `G129` asks for, but with the wrong statistic. It reads *density* (how much of the store is near `x`), not *frontier* (how many held items have unheld neighbours). So within an episode it falls as the store fills, and across training it stays level only because the store is wiped. Changing the statistic is cheap: the same `k`-NN query already returns the neighbour set. Counting stored neighbours that have fewer than `k` stored neighbours of their own gives a frontier-size readout from the same index. Nobody has run it.

**(brainstorm) What the page offers `T358`.** Disco Maze is a clean termination control. The only terminal event is a wall, and even agents whose bonus is meaningless learn to avoid walls because ending the episode forfeits bonus. This matches ICM's Mario agent dodging enemies. A positive episodic bonus plus termination produces avoidance, so that arm of `T358` gets safety from the episode boundary. The counter-observation is on Pitfall!: the RND life-long factor, which is non-episodic, is blamed for "interacting with danger". But this is the authors' hypothesis, not a measurement.

---

## Connections

- **[[wiki/entities/random-network-distillation.md]]** — built in as the slow half: NGU's life-long factor `α_t` is RND's normalised error, clipped to `[1, 5]`, and it multiplies a fast episodic count instead of acting as the reward. The head-to-head is run on one budget: R2D2 + RND scores −0.5 on Pitfall!, where NGU scores 8.4k. Removing RND from NGU drops Montezuma's Revenge 10.4k → 3.0k and raises Pitfall!.
- **[[wiki/entities/intrinsic-curiosity-module.md]]** — the same inverse-dynamics embedding with the forward model removed: ICM rewards forward error inside `φ`, NGU rewards `k`-NN sparsity inside `f`. Disco Maze repeats ICM's white-noise control with noise that changes at every step, and an untrained `f` fails it, so the inverse loss is what makes the filter.
- **[[wiki/entities/neural-episodic-control.md]]** — the store and kernel NGU borrows (same senior authors): a slot memory read by `k`-NN under an inverse-square kernel. NEC's store holds returns and persists; NGU's holds embeddings, is wiped per episode, and its read is a density that becomes the reward.
- **[[wiki/entities/go-explore.md]]** — two answers to detachment with opposite store lifetimes. Go-Explore's archive never forgets and is read as a selection weight. NGU's memory is wiped every episode (or every meta-episode) and read as a reward. The meta-episode variant is NGU's only route to the key–door choice RND fails on, and it works only with the oracle state Go-Explore also uses.
- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — a UM count whose support is the current episode rather than the lifetime, multiplied by a lifetime UM-in-NM-form factor: two counts at two timescales combined by product. The typology's one-reward-per-agent format has no slot for this.
- **[[wiki/concepts/explore-exploit-division-of-labour.md]]** — the separation built as a family of heads on one network rather than as phases: exploitation at `β₀` and exploration at `β > 0` train simultaneously, and the measured costs of sharing are interference on dense games and failure when the two policies are adversarial.
- **[[wiki/concepts/multi-horizon-value-learning.md]]** — a bank of discounts tied to a bank of reward mixtures: `γ_i` falls from 0.997 to 0.99 as `β_i` rises, so horizon and intrinsic weight co-vary along one index. The shared-torso benefit that page attributes to multiple horizons cannot be separated here from the benefit of multiple `β`s.
- **[[wiki/concepts/self-boosting-knowledge-acquisition.md]]** — the first reward on the wiki that reads the agent's own store, which is the structural move `G129` takes from that page. But the statistic is density rather than frontier size, so the reward falls within an episode and is kept alive across training only by wiping the store.
- **[[wiki/concepts/general-danger-channel.md]]** — two machine observations on `T358`'s sign question: in Disco Maze a positive episodic bonus plus termination teaches wall avoidance with no penalty term, and on Pitfall! the authors blame the non-episodic RND factor for danger-seeking (hypothesis only, not measured).
- **[[wiki/entities/hac.md]]** — a second UVFA used for something other than goals: HAC conditions on a target state, NGU on an exploration weight `β`. In both, the conditioning input is assigned from outside (a higher level, or a per-actor rule), and nothing learns to set it from the agent's own state.
