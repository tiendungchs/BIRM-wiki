# Computational Reuse — Memory as a Compute Resource

**Store the result of a computation so a later query pays for a lookup instead of the computation. This trades space for time, and three choices fix the design: the cached unit (a whole answer or a sub-solution), how an entry serves a query it was not computed for, and how long entries persist.**

> **Provenance.** Dasgupta & Gershman 2021, *Memory as a computational resource*, Trends in Cognitive Sciences 25(3):240–251, doi:10.1016/j.tics.2020.12.008 (`raw/dasgupta-2021-memory-as-a-computational-resource.md`). This is a review, so nearly every result below is **second-hand**, cited to the original by author name only. The clip has three defects. Equations 1–4 and Box 2's Equations I–II are blank placeholders; they are reconstructed below from the source's prose and the standard forms it names. The figures are images with no data. The reference list is stripped, so the years attached to cited works come from their standard citations, not from the clip. The clip's author field lists Gershman alone.

[[wiki/concepts/amortized-inference.md]] holds one half of this page: a learned network that maps a query to the answer the slow process would return. This page is the parent taxonomy. It places amortisation as **top-down memoization with a parametric memo-table**, beside the bottom-up caches the wiki carries under other names: the successor representation, the Kalman filter's sufficient statistics, value iteration, and option libraries.

---

## The trade

| Form | Content |
|---|---|
| Brute-force path search | `k^n` paths for `n` steps and `k` directions; `n = 10`, `k = 4` gives >10⁶ |
| Reuse | If the shortest paths A→B and B→C are cached, A→C via B is their concatenation. Every other path through those three points can be ignored |
| Fibonacci, `f(n) = f(n−1) + f(n−2)` (Eq. 1, reconstructed) | Naive recursion re-calls the same arguments, which is exponential. A memo-table makes it linear in `n` |
| Michie's interpolation (Eq. 2, reconstructed) | `f(n) ≈ √(f(n−1)·f(n+1))` for large `n`, because consecutive ratios converge to the golden ratio. A memo-table answers an *unseen* query from its neighbours |
| Hidden-Markov filtering (Box 2, Eq. II, reconstructed) | `P(z_n∣d_{1:n}) ∝ P(d_n∣z_n) Σ_{z_{n−1}} P(z_n∣z_{n−1}) P(z_{n−1}∣d_{1:n−1})`. The previous posterior *is* the cache. Without the Markov assumption, the sum runs over every `n`-step state history (Eq. I) |
| Bellman equation (Eq. 4, reconstructed) | `Q(s,a) = R(s,a) + E_{s′,a′}[Q(s′,a′)]`. Cached successor values stand in for the whole subtree |

The **Markov property** is what licenses the bottom-up cases. Conditional independence decides which sub-solutions can be stored and recombined, and so which caches are *correct* rather than approximate.

---

## Two decompositions

| | **Top-down** (memoization; Michie 1968) | **Bottom-up** (tabulation / dynamic programming) |
|---|---|---|
| What is cached | The output of the outermost call. Intermediates are discarded | Sub-problem solutions, cached as they are built |
| Order | The complex call runs first; sub-calls are cached lazily as they are invoked | The simplest sub-problems are solved first and composed upward |
| What it needs from the problem | Nothing | A decomposition: recursion, a Markov property, conditional independence |
| Cognitive model | Logan's **instance theory of automaticity** (1988): stimulus→response pairs kept in long-term declarative memory | Production systems — ACT-R (Adaptive Control of Thought–Rational) and Soar. Productions are strengthened by use and compiled into *chunks* |
| Machine model | Recognition network (variational autoencoder), Q-network — each "a distributed memo-table" | Kalman filter (cached posterior sufficient statistics), value iteration, temporal-difference learning, Dyna-style simulation into a temporal-difference cache |
| Strength | Simple and fully general | **Partial reuse**: sub-solutions serve whole queries never seen before |
| Weakness | Cannot exploit internal structure, so there is no partial reuse | Storing every intermediate makes a very large database to store and retrieve from. ACT-R strengthens a production by its **marginal** probability of being evoked, which assumes a factorised posterior over production sequences — a mean-field approximation that "can be highly inaccurate" |

**Three design issues any memo scheme must settle** (stated by Michie, organised by the source):

| Issue | Question | Range | Status in cognition |
|---|---|---|---|
| **Generalisation** | How does an entry answer a query it was not computed for? | Exact-match table → interpolation between neighbours → parametric network. A recognition network is "a sophisticated version of Michie's interpolation" | Query similarity is obvious for integers and undefined in general |
| **Persistence** | What is kept, and for how long? | Erase the table after every call (minimum space) → keep it forever (maximum space) | Open: how long completed computations persist, and in what form |
| **Decomposition** | What unit is cached? | Whole outputs (top-down) → sub-solutions (bottom-up) | Humans use both (below) |

---

## Evidence — four domains, one pattern

All second-hand via Dasgupta & Gershman 2021. Each domain shows an iterative algorithm, a later shift to retrieval, and some form of partial reuse.

| Domain | Algorithm signature | Shift to memory | Partial (bottom-up) reuse |
|---|---|---|---|
| **Arithmetic** | Children's *min-count*: start at the larger addend and increment, so reaction time (RT) rises linearly with the smaller addend | The RT function flattens by ~age 10. Adults on **alphabet arithmetic** (`A + 2 = C`) shift from counting to retrieval with practice | Multidigit decomposition (`31 + 25 = 30 + 20 + 1 + 5`). Logan's whole-answer race does not capture it |
| **Imagery** | Mental rotation: RT rises linearly with angular difference (Shepard & Metzler 1971) | The RT function flattens after extensive practice (Tarr & Pinker 1989) | Multipart objects are represented as a hierarchy of relative coordinate frames, so part poses are cached and reused in a whole-object transform. **The unit of reuse is not the whole instance** |
| **Probabilistic inference** | Bayes' rule over a combinatorial hypothesis space; iterative sampling or variational optimisation | Recognition network. The ventral visual stream is proposed as one: a face-inference model recovers 3D form and identity robustly across lighting and pose, and its internal layers match macaque face-processing population activity (Yildirim et al. 2020) | The Kalman filter caches posterior sufficient statistics and updates them in closed form, keeping compute bounded on an infinite stream. Sampling and variational extensions cover sequential tasks with no closed form (multiple-object tracking, sentence comprehension) |
| **Planning** | Exhaustive tree search, `2¹⁰ > 1000` sequences for two actions over ten steps | Chess and Go players evaluate positions from memory of familiar boards. A Q-network is a distributed memo-table | **Policy fragments** (Huys et al. 2015): see below |

**Amortisation leaves a measurable bias** (Dasgupta et al. 2018, 2020; the authors' own work):

| Finding | Mechanism |
|---|---|
| An inference is biased by recent inferences computed for **other** queries, and the bias scales with query overlap | Past inferences are written into the recognition model's shared parameters |
| The bias requires a **capacity limit** — a bottleneck in the input→output mapping | Shared structure between posteriors is forced only when capacity is short |
| People are more accurate at Bayesian inference with **realistic** probabilities | Training on queries drawn from the environment allocates capacity to high-probability queries |
| **Manipulating the historical query distribution shifts the bias** | The causal test of preferential allocation |

**Planning reuses sub-plans, and the reuse costs optimality** (Huys et al. 2015). Subjects chose action sequences from a random start state. Starting in state 1, the optimal 4-step path is `1-2-5-1-2`, but subjects preferred `1-2-3-4-2`. The reading is that they had already solved the optimal 3-step path, and reusing it reduced the 4-step problem to a single-step choice. Fragment reuse **grew across trials**, which fits a memo-table that is filling up.

**Stale caches produce devaluation-insensitivity.** A rodent that keeps pressing a lever for food it is sated on is choosing a state whose cached value has not yet been updated, while other cache entries have been. That inconsistency is what a budget-limited planner leaves when it must prioritise some updates over others. Three observations the source cites (citations stripped in the clip):
- With more time, more cognitive resources or more incentive, humans update their caches more.
- People given the chance to simulate during quiet rest adapt better to task changes.
- The size of that adaptation tracks neural measures of mental simulation.

**Episodic control is top-down plan caching for the low-data regime** (Lengyel & Dayan 2008). A whole action sequence is stored as a unit and replayed from the same start state. With little experience the agent can neither build an accurate model nor average enough samples for an accurate cached value, so a single remembered episode is its best estimate. Simulations and analysis support this. The machine descendants are [[wiki/entities/model-free-episodic-control.md]] and [[wiki/entities/neural-episodic-control.md]].

---

## What this changes for a builder

| Point | Consequence |
|---|---|
| **Logan's race is an arbitration rule with neither a comparison nor a price** | Algorithm and memory run in parallel and the response is whichever finishes first: `RT = min(T_alg, T_mem,1, …, T_mem,N)`, with every algorithm run depositing one more instance. The wiki holds three other rules: relative posterior variance, value of computation (`T135`), and contingency against habit concentration (`T405`). A race needs no arbiter at all, and under a deadline the faster process wins more often by construction. **(brainstorm)** So a deadline shift toward cached responding, which `T135`'s closing design reads as evidence for cost–benefit pricing, is also predicted by a race with nothing priced. Separating them needs a variable the race ignores, such as stakes with the deadline fixed — the Kool et al. manipulation already on that row |
| **The unit of reuse is a decomposition-level choice** | A top-down cache cannot give partial reuse. The source names the consequence for recognition networks: they "require a lot of data and struggle to generalize compositionally". A bottom-up cache gets partial reuse only from a decomposition it is handed |
| **(brainstorm) The latent graph is the bottom-up cache's key schema** | Bottom-up reuse is licensed by conditional independence: a sub-solution is reusable exactly where the problem factorises. In [[wiki/concepts/latent-graph-discovery.md]] terms, discovering the graph *is* discovering which sub-results may be cached and recombined. A reasoner that has the graph gets partial reuse for free, and one that lacks it can only memoize whole answers. This is a reason for graph discovery that does not depend on navigation |
| **(brainstorm) The amortisation bias is a free probe of a model's capacity allocation** | Interleave queries with controlled overlap into any amortised reasoner and measure how much the answer to query `j` shifts after query `i`. A non-zero, overlap-graded shift indicates a shared, capacity-limited mapping. Shifting the query history should move the shift. Neither probe needs access to the internals |
| **(brainstorm) Stale-cache habits predict something value-free habits do not** | Under the partial-update reading, devaluation-insensitivity should shrink with rest, time or incentive, because each buys more backups. A value-free `H` is written only by executed actions ([[wiki/concepts/value-free-habit.md]]), so offline simulation cannot touch it. Rest-dependent repair is a third wedge for `T405`, besides omission and unrewarded repetition — though rest could also act through the model-based side, which this test alone does not exclude |
| **A cache of sufficient statistics is exact only under the model that licensed it** | Solomonoff 1964 (§3.1.3, [[wiki/concepts/universal-induction.md]]): an inductor can fold its whole past into a modified machine and then code only new data. The exact version saves nothing, because coding on that machine is as hard as recoding everything. A useful version is a lossy summary, and a lossy summary can miss future structure: a symbol-frequency table cannot detect that the sequence later repeats exactly. This is the Markov-property condition above, with the failure mode named. The same paper's rule, that raw data predicts at least as well as the laws summarising it, argues for keeping the corpus beside the cache |
| **Space is a second resource** | [[wiki/concepts/resource-rationality.md]]'s Eq. 3 charges an opportunity cost on time. A cache is paid for in storage and saves time later, so the criterion needs a storage term before it can price a memo-table. The source poses "what is memory's role in the accuracy–cost trade-off" as an outstanding question. This supports that page's *many currencies* reading: space is not time |

---

## Open problems

The source's outstanding questions, each mapped to where it lands in the wiki:

- **No measured costs.** Neither the time cost of computing nor the space cost of caching has been measured, so the space–time trade cannot be fitted. That is the [[wiki/concepts/resource-rationality.md]] Eq. 3 cost term with storage added.
- **When to cache.** Nothing says how the brain decides what to store. This is `G19`/`G42` (write gating, capacity) restated for computed results rather than for experiences.
- **Generalising a cache entry to novel inputs.** This is [[wiki/concepts/amortized-inference.md]]'s training-distribution problem.
- **Combining top-down and bottom-up memoization.** No architecture in the source does both. **(brainstorm)** [[wiki/entities/dreamcoder.md]] is the nearest: it caches whole solved programs and then compresses them into reusable sub-routines. That is top-down caching converted into a bottom-up library offline, in a symbolic store.
- **Representations that permit partial reuse.** Relative coordinate frames for imagery and policy fragments for planning are the two named cases. The general form is [[wiki/concepts/compositionality.md]]'s requirement seen from the storage side.
- **Which memory system holds cached computations** — episodic, declarative or semantic — and how to tell them apart behaviourally and neurally. Unanswered.
- **Persistence.** How long completed computations persist, and in what form, is unknown. For the stale-option failure, this is [[wiki/concepts/temporal-abstraction-options.md]]'s "nothing decides when to discard an option".

---

## Connections

- **[[wiki/concepts/amortized-inference.md]]** — the parametric, top-down half of this page's taxonomy: a recognition network is Michie's interpolating memo-table. This page adds the measured bias such a mapping leaves (overlap-graded, capacity-dependent, shifted by the query history) and the bottom-up alternative it cannot provide, which is partial reuse.
- **[[wiki/concepts/resource-rationality.md]]** — prices time and leaves out space. A cache is a storage outlay that buys future time, so this page's trade is a second resource axis in that page's Eq. 3, and an argument for its plural-currencies reading.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — an option is a cached sub-plan. Huys et al.'s fragment reuse is the human measurement of that compilation together with its price: the cached 3-step path pulls the 4-step choice away from the optimum, which is negative transfer observed in people.
- **[[wiki/entities/model-free-episodic-control.md]]** — the machine form of Lengyel & Dayan's episodic control, which is top-down plan caching. Its exact-revisit statistic measures how often such a cache is hit exactly rather than interpolated, which is the generalisation issue of this page's memo-table, quantified.
- **[[wiki/concepts/successor-representation.md]]** — a bottom-up cache: half the Bellman computation stored and recombined with any reward vector. Its obstacle-insertion failure is the stale-cache failure this page uses to explain devaluation-insensitivity.
- **[[wiki/concepts/universal-induction.md]]** — the ideal inductor's incremental form is this page's bottom-up cache: Solomonoff 1964 folds the past into the machine as a summary, and warns that any summary cheap enough to be useful is lossy and can miss later structure. That is persistence and correctness stated for the limit case.
- **[[wiki/concepts/value-free-habit.md]]** — the rival reading of the same devaluation data. Here a habit is a value cache that has not yet been updated; there it is an action frequency that never reads value. Only the stale cache should be repaired by rest or offline simulation.
