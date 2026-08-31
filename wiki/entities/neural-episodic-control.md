# Neural Episodic Control (NEC)

**A deep RL agent whose value function is a growing table read by kernel-weighted `k`-nearest-neighbour lookup: a convolutional net supplies the key, one differentiable neural dictionary per action supplies the value, and the table's entries are updated with a tabular learning rate orders of magnitude faster than the network that indexes them.** Pritzel, Uria, Srinivasan, Puigdomènech, Vinyals, Hassabis, Wierstra & Blundell 2017, ICML. Source: `raw/pritzel-2017-neural-episodic-control.md`.

The wiki's second primary source for episodic control after [[wiki/entities/hami.md]], and the one the field actually cites. It is the clean statement of the **fast-store-as-policy** design: the store is not a teacher for a slow learner, it *is* the value function, and the slow learner exists only to supply the metric in which the store's keys are compared.

---

## Architecture

| Component | Spec |
|---|---|
| Embedding | The [[wiki/entities/dqn.md]] convolutional stack, unchanged, mapping pixels `s` → key `h` |
| Memory | One **differentiable neural dictionary** (DND) `M_a = (K_a, V_a)` per action; dynamically sized arrays; up to `5×10⁵` entries per action |
| Read | `o = Σ_i w_i v_i`, `w_i = k(h,h_i)/Σ_j k(h,h_j)`, restricted to the `p = 50` nearest neighbours found by kd-tree approximate search |
| Kernel | `k(h,h_i) = 1/(‖h−h_i‖²₂ + δ)`, `δ = 10⁻³` — **heavy-tailed by design**: a Gaussian kernel exponentially suppresses everything but the closest key, which the authors reject explicitly |
| Write | **Append-only, every step, no gate.** Key = the query key just used; value = the `N`-step return below. Exact key already present → tabular update instead of a duplicate |
| Eviction | Overwrite the entry **least recently returned as a neighbour** — recency of *retrieval*, not of writing |
| Slow update | `L2` loss between `Q(s,a)` and `Q^{(N)}` on minibatches of 32 from a `10⁵`-transition replay buffer, one update per 16 frames; gradients flow through the conv net **and** through the stored keys and values, at a learning rate far below `α` |

```
Q^{(N)}(s_t,a) = Σ_{j=0}^{N−1} γ^j r_{t+j} + γ^N · max_{a′} Q(s_{t+N}, a′)      N = 100

fast:  Q_i ← Q_i + α (Q^{(N)}(s,a) − Q_i)        α large, tabular Q-learning on the stored value
slow:  θ  ← θ − η ∇_θ ‖Q(s,a;θ) − R_t‖²          η ≪ α, R_t = Q^{(N)} stored in the replay buffer
```

**Two learning rates inside one differentiable architecture, and the split is the whole idea.** The store's values move at `α` (one experience is enough); the embedding that decides *which* stored values are nearby moves at `η` (slow, so keys stay stable and the table's addresses do not drift under it). `R_t` plays the role of DQN's target network — the buffer stores returns, not transitions, so there is no second frozen network anywhere.

**`N`-step returns are the third ingredient, and they are a deliberate interpolation.** Monte Carlo (`N → ∞`) propagates reward in one episode but evaluates the behaviour policy; one-step bootstrapping evaluates the optimal policy but crawls. `N = 100` buys speed of credit propagation at a known cost in optimality — the paper's own decomposition of NEC's speed into (DND, `N`-step, stable conv features).

---

## Results (Atari, 57 games, median human-normalised)

| Frames | NEC | MFEC | Prioritised replay | Nature DQN | A3C |
|---|---|---|---|---|---|
| 1M | **16.7%** | 12.8% | −2.4% | −0.7% | 0.4% |
| 4M | **36.0%** | 26.6% | 2.7% | 2.4% | 1.9% |
| 10M | **54.6%** | 45.4% | 22.4% | 15.7% | 3.6% |
| 20M | **72.0%** | 55.9% | 38.6% | 26.8% | 7.9% |
| 40M | 83.3% | 61.9% | **89.0%** | 52.7% | 18.4% |

- Human level on ≈**25% of the 57 games within 10M frames** (185 h of game time is the 40M-frame mark, against DQN's 200M).
- **The crossover is the result.** NEC dominates by an order of magnitude in data below 20M frames and is overtaken by prioritised replay at 40M; on *mean* normalised score the parametric agents pull away much earlier and much further (40M: NEC 144.8%, prioritised 332.3%, `Q*(λ)` 440.9%), i.e. NEC raises the floor across many games and does not chase the ceiling on any.
- **No reward clipping**, and this changes behaviour rather than only scores. On Ms. Pac-Man and Alien, agents trained with rewards clipped to `{−1,0,+1}` cannot distinguish a pellet from a ghost eaten after a power pill and collect the easy small rewards; NEC maximises the true score and goes for the power pill (Alien 3460.6 vs 800.5 for prioritised replay at 10M).
- **NEC > MFEC because the embedding is trained by TD, not chosen.** MFEC keys on random projections of pixels or on a VAE latent; the former cannot resolve the few pixels that determine value, the latter spends capacity on reward-irrelevant detail like the on-screen score. Learning the metric from the reward signal is the paper's sole architectural claim against MFEC and it is worth ~20 median points at 10M.
- **Sparse reward, partial credit:** at 10M frames Montezuma's Revenge is 42.1 (NEC) and 76.4 (MFEC) against **0.0** for DQN, prioritised replay and A3C — a non-parametric store gets *something* where value backup through a network gets nothing, without any exploration bonus.
- **Where it loses:** Breakout 13.6 (MFEC 86.2), Enduro 1.4, Skiing worst of all seven agents — long, dense-reward games whose asymptote a table interpolated from 50 neighbours cannot reach.

---

## Limitations

| Limitation | Consequence |
|---|---|
| **No consolidation channel** | The DND is the policy. Nothing distils the table into the conv net, so the store must be carried at deployment and its size grows with experience — gap G14 in its purest form, and the likely cause of the 40M crossover: the parametric agents keep improving on the same data the table can only store |
| **Write everything, decide nothing** | The authors argue *against* learned write gating (as in the differentiable neural computer) on the grounds that learning when to write is slow — an explicit engineering position on G19, purchased with `5×10⁵` slots per action |
| **Capacity is a hyperparameter; eviction is a heuristic** | Least-recently-retrieved, with no capacity estimate and no signal that the store is full (G42) |
| **Key drift is unmodelled** | Slow embedding updates change the geometry under keys already written; nothing re-indexes them, and stability is bought only by making `η` small |
| **Read cost scales with the store** | Every decision is `|A|` approximate-nearest-neighbour queries over a half-million-entry array; kd-trees make this tractable, not free |
| **Values are point estimates** | No uncertainty anywhere, so the kernel's weighted average cannot distinguish "50 neighbours agree" from "50 neighbours are far away" — the heavy-tailed kernel is a robustness hack in place of a confidence read |
| **Interpolation is the only generalisation** | Between-neighbour averaging in a value-shaped metric; there is no transition model, no factorisation and no re-goaling ([[wiki/concepts/simulation-based-planning.md]], G28) |

---

## Comparison

| System | Memory key | Read | Value written | Write policy | Store's role |
|---|---|---|---|---|---|
| **NEC** | Learned conv embedding, **TD-shaped** | Kernel-weighted 50-NN, heavy-tailed kernel | `N`-step `Q` (`N=100`) | Every step; tabular update on exact match | Is the value function |
| MFEC (Blundell et al. 2016) | Random projection or VAE latent, **fixed** | Mean of `k` NN; exact match returns the stored value | Monte Carlo return, keep the max | Every step | Is the value function |
| [[wiki/entities/hami.md]] | Quantised 6-bit event/context symbol window | **Exact match** (content-addressable) | Cumulative return, keep the max | Episode end; novel only | Is the policy |
| [[wiki/entities/dqn.md]] | — | — | — | Uniform buffer of raw transitions | Buffer feeds one parametric learner |
| [[wiki/entities/differentiable-neural-computer.md]] | Learned content key | Attention over the matrix | Whatever the controller writes | **Learned** write head; wiped per episode | Working memory for the controller |

**NEC and HAMI are the same architecture at two settings of one knob — how much the key is compressed.** NEC keeps a real vector, pays a `k`-NN search, gets graded similarity, and saturates capacity because every noisy re-encounter is a new entry. HAMI quantises to a short symbol, pays an equality test, loses graded similarity, and bounds capacity by alphabet size. Both then get their de-aliasing from allocation bookkeeping rather than from inference.

---

## Why this matters for a reasoning model

- **(brainstorm) NEC is the strongest evidence in the wiki that the wiki's fast/slow split can be *inverted*.** [[wiki/concepts/complementary-learning-systems.md]] assigns the instance graph to the fast store and the meta graph to the slow learner, with transport running fast → slow. Here the slow learner holds no structure at all: it learns only *what counts as nearby*, and every value, every policy decision and all credit assignment live in the fast store. That is the same division of labour [[wiki/entities/hami.md]] gets by freezing a contrastive encoder, arrived at independently and *learned end-to-end from reward*. Two primary sources, two mechanisms, one assignment: **the slow system's first job is identity, not structure** ([[wiki/concepts/latent-graph-discovery.md]], hardness source 3).
- **(brainstorm) The 40M crossover prices what the missing consolidation channel is worth.** NEC and prioritised replay see the same data; NEC extracts far more from the first 20M frames and less from the next 20M. Nothing in NEC is *wrong* at 40M — the table is strictly larger and the metric strictly better trained. What the parametric agents have is a mechanism that turns repeated experience into a *smoother* function rather than more entries. So G14's channel is not a nicety for continual learning; it is the specific thing that converts a data-efficiency advantage into an asymptotic one, and its absence is measurable as a crossing point on a learning curve. **A builder's test falls out of this**: any claimed consolidation channel should move the crossing point right, or delete it.
- **(brainstorm) The reward-clipping result is the wiki's cleanest natural experiment on objective identifiability.** Two agents, the same games, the same scoring — one optimises a sign-preserved surrogate and the other the true return, and the *qualitative strategy* differs (collect pellets vs. hunt ghosts). The surrogate was adopted for optimisation reasons (one learning rate across 49 score scales) and a non-parametric value store simply does not need it, because a table has no shared learning rate to protect ([[wiki/concepts/objective-identifiability.md]]).
- **The kernel choice is a separation/completion setting in disguise.** A Gaussian kernel is near-exact-match (maximal separation, no generalisation); an unnormalised uniform average over 50 neighbours is maximal completion. NEC picks `1/(d²+δ)` to sit between them and states the reason — avoid putting all the weight on one point when every neighbour is far. That is [[wiki/concepts/pattern-separation-completion.md]]'s knob as a *read-side* parameter rather than a write-side one, and unlike HAMI's threshold it was never swept (G38).
- **Credit propagation and value-store speed are separable, and the paper conflates them.** `N`-step returns would speed up DQN too; the DND's contribution is isolated only against MFEC, which also has a store. The wiki should read NEC's advantage over prioritised replay as (store + `N`-step + no clipping) and not as a measurement of the store alone.

---

## Connections

- **[[wiki/entities/alphazero.md]]** — the opposite trade on decision-time compute: one kernel read from a stored table versus 800 tree simulations, both replacing a slowly gradient-fed value function, and both giving up transfer to do it.

- **[[wiki/entities/dqn.md]]** — supplies NEC's convolutional stack unchanged and is the agent it inverts: identical perception, with the value function moved out of the weights into a table, which is what removes both the target network and the need for reward clipping.
- **[[wiki/entities/hami.md]]** — the same fast-store-as-policy design with the key quantised to a symbol instead of kept as a vector, which is exactly the trade NEC pays for at capacity (append-every-step into `5×10⁵` slots with least-recently-retrieved eviction) and buys with graded similarity.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the primary source for that page's *episodic control* row, and its sharpest version: the fast store used directly for behaviour beats every parametric agent below 20M frames and is overtaken at 40M, which dates the cost of having no transport channel.
- **[[wiki/concepts/replay-prioritisation.md]]** — the rival answer to the same sample-efficiency problem, and the agent NEC crosses: prioritisation changes *when* a transition is used to fit weights, NEC changes *where the value lives*, and the two are measured head-to-head on the same 57 games.
- **[[wiki/concepts/retrieval-capacity.md]]** — an agent whose *policy* is a top-`k` retrieval by inner-product-like ranking over a learned embedding, so that page's bound on how many distinct retrieval sets a `d`-dimensional store can address is a bound on how many distinct value estimates NEC can express; the embedding width is tuned by sweep and never related to store size (`5×10⁵` entries per action).
- **[[wiki/concepts/pattern-separation-completion.md]]** — the completion bias appears here as a *read-side* kernel choice: `1/(d²+δ)` is picked over a Gaussian precisely to stop the read collapsing onto its nearest neighbour when all neighbours are far.
- **[[wiki/concepts/objective-identifiability.md]]** — the natural experiment: dropping reward clipping (which a table does not need) changes not just scores but the strategy the agent adopts on Ms. Pac-Man and Alien.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the largest data-efficiency gain in the wiki's Atari record that comes from *where the value is stored* rather than from schedule, exploration or architecture depth.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a system that gets partial credit on Montezuma's Revenge with no exploration bonus and no state inference, purely because a stored return survives being visited once; and one whose slow learner's entire job is deciding which observations count as the same node.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the design NEC argues against by name: a learned write head that must be trained and a memory wiped per episode, against an ungated append-only store that persists across episodes.
- **[[wiki/concepts/memory-read-and-erase.md]]** — the write side deliberately left unlearned, with erasure demoted to a recency heuristic, on the stated grounds that learning when to write is slower than buying capacity.
- **[[wiki/concepts/attention.md]]** — the read is softmax attention with the exponential replaced by a heavy-tailed inverse-square kernel and the context restricted to 50 approximate neighbours, which is what makes a half-million-entry store readable at all.
