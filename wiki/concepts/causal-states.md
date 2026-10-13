# Causal States and ε-Machines

**Two histories are the same state iff they predict the same distribution over every future. The resulting partition of pasts (the *causal states*), together with its symbol-labelled transitions (the *ε-machine*), is the unique minimal maximally-predictive representation of a stationary process. For a passive observer it is the canonical answer to "which latent graph is there to discover".**

[[wiki/concepts/latent-graph-discovery.md]] treats the node set and the observation map as latent, and it lists aliasing as hardness source 3. Every mechanism the wiki has for that source (clone pools, path-integrated `g`, sparse conjunctive codes) is a *mechanism*. This page is the `L0` *specification* those mechanisms are scored against: the partition they should converge to, why it is the only one, and what it costs to hold.

> **Provenance.** Shalizi & Crutchfield 2001, *Computational Mechanics: Pattern and Prediction, Structure and Simplicity* (Santa Fe Institute Working Paper 99-07-044; arXiv cond-mat/9907176; `raw/shalizi-2001-computational-mechanics-pattern-prediction-structure-simplicity.md`). It is a proof paper with no experiments and no data. The clip is an ar5iv HTML conversion, and three parts of it are damaged. The theorem cross-references are ar5iv anchors ("Thm. 42", "Lemma 12"), so this page uses the paper's own numbering (Theorems 1–7, Lemmas 1–8). The determinism lemma (Lemma 5) survives only as a garbled LaTeX block, and its statement is recovered from that block. The proof of Theorem 4 is unreadable, but its statement is intact. The optimality and minimality results first appeared in an earlier paper by the same authors. Uniqueness (Theorem 3) is new here.

---

## Formalism

The setting is a stationary, discrete-time, discrete-valued process `↔S = …S₋₁S₀S₁…` over a countable alphabet `𝒜`. `←S` is the semi-infinite past and `→S` the semi-infinite future. `→S^L` is the next `L` symbols.

| Object | Definition | Reading |
|---|---|---|
| **Effective state** | Any partition `𝓡` of the set of pasts, via `η : ←𝐒 → 𝓡` | A candidate node set. All histories in one class are treated as equivalent for prediction |
| **Occam's pool** | The set of all such partitions | The hypothesis space; the job is to find its "shallowest point" |
| **Captures a pattern** | `∃L : H[→S^L \| 𝓡] < L·H[S]` | Predicts better than the i.i.d. baseline. The pattern's strength is `H[S] − H[→S^L\|𝓡]/L` at the least such `L` |
| **Statistical complexity** | `C_μ(𝓡) = H[𝓡]` | Average memory, in bits, that the partition keeps about the past |
| **Causal state** | `ε(←s) = { ←s′ : P(→S \| ←s) = P(→S \| ←s′) }` | The equivalence class of histories with identical conditional futures. Equivalently, it is the limit of partitions refined by futures of length 1, 2, 3, … |
| **Morph** | `P(→S \| σ)` | The "shape of the future" attached to a state. No two causal states share a morph |
| **Labelled transition** | `T_ij^(s) = P(𝒮′ = σ_j, →S¹ = s \| 𝒮 = σ_i)` | An edge from `σ_i` to `σ_j` labelled by the emitted symbol `s`. `T^(λ)` is the identity |
| **ε-machine** | `{ε, 𝐓}` | Causal states plus labelled transitions: a graph with symbol-labelled edges |
| **Excess entropy** | `𝐄 = I[←S ; →S]` | Information about the future that is *visible* in the observed past. Other names: predictive information, effective measure complexity |
| **Entropy rate** | `h_μ = lim_L H[→S^L]/L` | Irreducible per-symbol randomness |

---

## The results

| # | Statement | What it means for a model |
|---|---|---|
| **Lemma 1** (Old Country) | `H[→S^L \| 𝓡] ≥ H[→S^L \| ←S]` for every partition | Nothing beats the whole past. The question is how much of the past can be forgotten at no cost |
| **Thm 1** (maximal prescience) | `H[→S^L \| 𝓡] ≥ H[→S^L \| 𝒮]` for all `𝓡`, all `L`. **Corollary 1:** causal states are sufficient statistics, `I[→S^L ; 𝒮] = I[→S^L ; ←S]` | Causal states lose nothing about the future. They "record every difference (about the past) that makes a difference (to the future)" |
| **Lemma 2** | Past and future are conditionally independent given the causal state | The causal state is a complete interface between past and future, so nothing else needs to be carried |
| **Lemma 7** (refinement) | Every *prescient rival* `𝓡̂` (equally predictive at every `L`) is a refinement of the causal-state partition, except on a measure-zero set. Hence there is a function `g` with `𝒮 = g(𝓡̂)` almost always | **Any optimal predictor's internal states can be read out as causal states by a fixed function.** It may split a causal state, but it may never merge two |
| **Thm 2** (minimality) | `C_μ(𝓡̂) ≥ C_μ(𝒮)` for every prescient rival. Causal states are **minimal** sufficient statistics | The least memory any optimal predictor can hold is `C_μ` bits. This also makes `C_μ` a property of the *process*: without minimality, internal states could be elaborated without bound |
| **Thm 3** (uniqueness) | A prescient rival with `C_μ(𝓡̂) = C_μ(𝒮)` equals the causal-state partition, except on a measure-zero set | Prescient + minimal ⇒ identified. There is exactly one graph at the optimum |
| **Lemma 5** (determinism) | `T_ij^(s) > 0` for at most one `j` per `(i, s)`: the current state and the next symbol fix the next state | The graph is **unifilar**. The state is a deterministic function of the start state and the symbol string, so tracking it needs no inference once it is synchronised |
| **Lemma 6** | Causal states at different times are conditionally independent given the intermediate state | The state sequence is a Markov chain, a generalisation of Markov states. The class of processes is strictly richer than finite Markov chains |
| **Thm 4** (minimal stochasticity) | `H[𝓡̂′ \| 𝓡̂] ≥ H[𝒮′ \| 𝒮]` | No optimal rival has more deterministic state-to-state transitions |
| **Thm 5** (bounds of excess) | `𝐄 ≤ C_μ`, with equality iff `H[𝒮 \| →S] = 0` | **What is visible in the data underestimates what must be stored.** For range-`R` block-Markov sources, `C_μ = 𝐄 + R·h_μ`. They are equal only at zero entropy rate, e.g. period `p`: `C_μ = 𝐄 = log₂ p` |
| **Lemma 8** | `h[→S \| 𝓡̂] = h[→S]` | Knowing the state lowers uncertainty at every finite horizon but leaves the asymptotic rate unchanged |
| **Thm 6** (control) | `H[S] − h_μ ≤ C_μ`. The finite-entropy version (Thm 7) is `H[→S] − H[→S \| 𝓡̂] ≤ C_μ` | Ashby's law of requisite variety: fixing the state can cut per-symbol uncertainty by at most the state's own entropy |
| **Prop 1** | The labelled transition matrices, with probabilities stripped to 0/1, generate a **monoid** under multiplication. Forbidden concatenations map to the zero matrix | The ε-machine's algebra is a *generalised symmetry*. Its subgroups are symmetries in the ordinary sense |
| **App C** | The causal states of the time-reversed process differ in general, and forward and reverse `C_μ` need not be equal (the entropy rate is equal) | Time asymmetry is a measurable property of a process. A model that reads its input in only one direction holds one of two distinct graphs |

**The theorems hold only for futures of every length.** By Theorem 2's Remark 2, two histories that agree on futures up to length `L` and differ beyond it are different causal states. A partition that merges them predicts `→S^L` just as well and is simpler. An objective scored on a fixed horizon therefore selects a *coarser* graph than the ε-machine.

---

## Rival representations, from the paper's comparisons

| Representation | Prescient? | Minimal? | Hidden states identified? |
|---|---|---|---|
| Whole history `←S` | Yes | No, maximal | — |
| Block / order-`R` window (sequence blocks taken as states) | Only on block-Markov sources of range `≤ R` | Only when block configurations are isomorphic to causal states, and then `C_μ = 𝐄 + R·h_μ`. A window longer than the range carries excess | No. Sofic processes have finite ε-machines yet are only the *limit* of ever-longer block-Markov models (Weiss; App G.8) |
| An arbitrary generating hidden Markov model | Yes | No: internal states can be elaborated without bound | **No.** The internal states of the generator are not a property of the observed process |
| Rissanen's context algorithm (minimum description length) | Approximately | No: on a random source it estimates a state count that grows at least logarithmically with data, where the ε-machine has one state | No |
| Kolmogorov–Chaitin complexity | Single object, exact reproduction | — | No. It is uncomputable, and it is maximal for random strings, so it measures randomness, not structure |
| Wiener–Kolmogorov filtering | Yes, for its class | — | The states are left implicit in the operators, and the theory splits linear from nonlinear prediction |
| Nerode equivalence classes | — | Yes | The finite, non-stochastic special case: regular languages and finite automata |
| **Causal states** | **Yes** | **Yes** | **Yes, uniquely** |

---

## What it says for building a reasoning model

| Consequence | Detail |
|---|---|
| **De-aliasing has an exact target** (`G2`) | Two contexts must share a code iff their conditional futures are identical. They must get distinct codes iff they differ in *any* future of *any* length. This is a criterion for the output of [[wiki/entities/cscg.md]]'s clone allocation, of path-integrated `g`, and of every other de-aliaser, not a mechanism. The refinement lemma sets the asymmetry: an optimal predictor may over-split (cost: excess memory) but may never over-merge (cost: lost prescience) |
| **What a passive observer can identify** (`G16`) | The ε-machine is a function of `P(↔S)` alone, and it is unique. Any generator with more internal structure is *not* identifiable: "we could trivially elaborate internal states, while still generating the same observed process". On the passive, stationary slice, the identifiable graph is therefore exactly the coarsest prescient partition, and any finer graph a designer wants is bias. The paper's "causal" is Humean (invariant succession, made probabilistic), not interventional |
| **Structure is a separate axis from randomness and from code length** (`G26`) | An i.i.d. source has one causal state and `C_μ = 0`, while its Kolmogorov complexity is maximal. Complexity is "orthogonal" to entropy rate. `C_μ` "is not a description length", and the context-algorithm row above is the concrete case where a description-length state estimator grows a structure the ε-machine does not have. The selection rule is: *among equally predictive partitions, take the least state entropy*. This charges for the partition, not for the code |
| **A memory floor for any optimal predictor** | Every prescient predictor holds `≥ C_μ` bits of state entropy, and `𝐄` (the past–future mutual information any block statistic estimates) is only a lower bound on that. Even on a range-`R` block-Markov source, where the `R`-symbol window *is* the causal state, `C_μ = 𝐄 + R·h_μ`: `R·h_μ` bits of required memory are invisible to every estimate of `𝐄`. **(brainstorm)** [[wiki/entities/dqn.md]]'s 4-frame stack and a bounded Transformer context are block-state predictors. They are optimal only on block-Markov sources of range up to the window, they carry excess when the window exceeds the range, and no finite window is prescient on a sofic process (finite ε-machine). A sofic test stream therefore separates them from any model that infers a state |
| **Path-consistency without a constraint** (`G3`) **(brainstorm)** | Two histories with the same future are one state by definition, and unifilarity makes the state reached a deterministic function of the start state and the symbol string. Two routes to the same node therefore end in the same code *because* identity is defined by the future. No consistency term is needed. [[wiki/concepts/path-integration.md]] gets the same property from displacement arithmetic, which needs actions that compose |
| **A composition test** (`G41`) **(brainstorm)** | Proposition 1 hands over the algebra. Reconstruct the ε-machine of the joint action–observation stream and check whether each `(state, action)` pair fixes the successor *whatever observation is co-emitted*. If it does, the 0/1 action matrices alone generate a monoid acting on the states, and a code computed from actions alone is a position. If the successor needs the observation, path integration would silently alias. Invertibility is not required: [[wiki/concepts/path-integration.md]] already states that composition is a monoid, not a group |
| **A recurrent next-step predictor is scored on every horizon** **(brainstorm)** | The fixed-horizon caveat above applies to a partition scored on `→S^L`. Suppose the state is updated recursively, `𝓡_{t+1} = f(𝓡_t, s_t)`, and is optimal for the next symbol at *every* step. Then by the chain rule it is optimal for every `L`, and so it must refine the causal states. Recurrence, not loss horizon, is what forces the full graph |
| **The prediction frontier is the information bottleneck with `Y` = the future** **(brainstorm)** | The paper conjectures a path of optimal machines from the one-state, zero-complexity machine to the ε-machine, each minimal for its degree of prescience. Read through [[wiki/concepts/information-bottleneck.md]] with `X = ←S` and `Y = →S`, this is that page's information curve, with the causal-state partition at `β → ∞`. That gives a canonical relevance variable for the passive case, the one thing the bottleneck page says latent graph discovery lacks |
| **Actions turn the graph into a joint property** (`G63`) **(brainstorm)** | The paper's sixth assumption is prediction from the process's own past only. Fold an agent's actions into the symbol stream, as [[wiki/entities/cscg.md]] does with `p(z′, a \| z)`, and the ε-machine becomes a property of the *policy–environment* pair. Change the policy and the identified graph changes. This is `G63`'s claim that the behaviour policy is a load-bearing parameter of world-model estimation, written in this formalism |

---

## The paper's assumptions, and what lifting each costs

| # | Assumption | Status in the source |
|---|---|---|
| 1 | Exact joint probabilities over blocks of every length are known | **No finite-sample theory.** Reconstruction algorithms exist (batch and online), and they are "fairly evident" to converge with infinite data. Error statistics, confidence regions and convergence rates are listed as future work. The only analytical result cited gives the average number of estimated causal states versus data size, for certain process classes |
| 2 | Discrete values | Probably liftable with more mathematics |
| 3 | Discrete time | Probably liftable |
| 4 | Pure time series, no spatial extent | Treating space-time paths as time series works for compression, but it is not known whether it captures structure |
| 5 | Stationarity | Results extend formally, but "unclear how much substantive content these extensions have" |
| 6 | Prediction from the process's own past only | Defended as a feature: two copies of one document predict each other perfectly, and that says nothing about the pattern either holds |

Two further caveats run through every theorem. The state set can be finite, countably infinite, a continuum or a Cantor set, so **the graph is not guaranteed to be finite**. Every optimality and uniqueness statement is also "almost everywhere": a minimal prescient rival may disagree with the ε-machine on histories of measure zero.

---

## Open problems

- **No sample complexity.** The specification is exact and the learner is not. Nothing says how many symbols are needed to recover an ε-machine with `k` states at a given confidence. That is the quantity a wiki benchmark would have to report (`G17`).
- **Non-stationary topology.** Hardness source 6 and `G7` are exactly the regime the paper cannot cover.
- **No inputs.** The theory is passive. Controlled processes, where the agent's choices shape the next symbol, need an input–output (transducer) version that this paper does not give. The passive/active split on [[wiki/concepts/universal-induction.md]] appears here as assumption 6.
- **Infinite machines.** When the causal-state set is uncountable, the "graph" is not a graph a navigator can hold, and nothing in the paper says which finite approximation to keep. The prediction-frontier conjecture is the candidate.
- **Single-scale.** One process gives one ε-machine. The hierarchical reconstruction the paper mentions is cited but not developed, so nothing here produces the wiki's meta-graph / instance-graph split (`G1`, `G9`).

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the framing's node set in closed form for the passive, stationary case: nodes are the classes of histories with identical futures, edges are symbol-labelled unifilar transitions, and the result is unique. Hardness source 3 is then the problem of *estimating* this partition, not of choosing it.
- **[[wiki/entities/cscg.md]]** — the closest running mechanism: a clone pool with frozen 0/1 emissions, pruned by Viterbi training to the minimal state count (48 on a 6×8 room). This is ε-machine reconstruction approximated by expectation–maximisation. Unlike an ε-machine, its learned transitions are not forced to be unifilar.
- **[[wiki/concepts/information-bottleneck.md]]** — the same minimal-sufficient-statistic object with the relevance variable fixed. Here `Y` is the entire future and the optimum is a partition that always exists, though it may be uncountable. The paper's conjectured "prediction frontier" is that page's information curve for `X` = past.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the axis this page is orthogonal to. Code length is driven by the entropy rate, structure by `C_μ`. An i.i.d. source is maximally incompressible and structurally trivial, so a compression rate alone cannot say how much graph a model found.
- **[[wiki/concepts/universal-induction.md]]** — the individual-sequence, exact-reproduction, uncomputable predecessor that the paper argues against: Kolmogorov complexity measures randomness, not pattern. This page keeps the passive slice and its guarantees, and it trades universality for an ensemble definition that is computable from `P(↔S)`.
- **[[wiki/concepts/certification-instruments.md]]** — supplies `I48`: on a synthetic process with a known ε-machine, prescience plus minimality *identifies* the graph (Theorem 3). A model's internal states can therefore be certified as having recovered the structure, not merely as predicting well.
- **[[wiki/concepts/learned-world-models.md]]** — names the floor under the "model as sufficient statistic for a policy" role: a recurrent predictive state such as World Models' `h_t` is at best a prescient rival, so it refines the causal states and carries at least `C_μ` bits. Its excess over `C_μ` is memory the controller reads and does not need.
- **[[wiki/entities/dqn.md]]** — the block-state rival made concrete: a 4-frame stack is an order-4 window. It is prescient only on block-Markov sources of range ≤ 4, it is minimal only when its blocks coincide with causal states, and no finite window is prescient on a sofic process.
- **[[wiki/concepts/path-integration.md]]** — two routes to path-consistency: there identity is built by composing displacements and needs actions that compose (`G41`); here identity is defined by future equivalence and comes free, and the ε-machine's monoid is the object on which the composition precondition could be tested.
