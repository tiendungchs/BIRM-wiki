# Attractor Dynamics

**A recurrent network's state settles, from anywhere in a basin, onto a stable state that the weights — not the input — define; so *retrieval, de-aliasing, maintenance and path integration all become one operation: relaxation.*** The wiki's most heavily used mechanism and, until this page, its only unwritten one: attractors appear on 39 of 73 concept and entity pages and were load-bearing on eight of them without a page stating what the mechanism buys or costs.

The page exists to make one distinction that the entity pages keep re-deriving: **what defines the fixed points** (content, or a frozen scaffold) is a separate design choice from **how many there are** (discrete, or a continuum), and almost every property a builder cares about — capacity, basin shape, spurious states, whether the store can say "nothing applies" — follows from those two choices rather than from the learning rule.

---

## The formalism

| Object | Statement |
|---|---|
| Dynamics | `τ dU/dt = −U + W r(U) + I^ext` — recurrent drive plus input, with `r` a pointwise nonlinearity |
| Energy (symmetric `W`) | `E(σ) = −½ σᵀJσ − bᵀσ`, non-increasing under asynchronous update; fixed points are local minima |
| Retrieval | `σ(0) = ` partial or noisy cue → iterate → `σ(∞) = ` the stored state whose basin contains the cue. Cost is one settling pass, **independent of library size** |
| Stochastic form | `σ_i(t+1) = L(β Σ_j J_ij σ_j(t)) + noise` — `β` is inverse temperature and, read as inference, the **precision of the prior**: `β → ∞` ignores the input entirely ([[wiki/entities/fcann.md]]) |
| Asymmetric part | Split `J = J^S + J^A`. Only `J^S` enters the stationary distribution; `J^A` induces flow *tangential* to its level sets — traversal without changing the landscape |

The last row is the wiki's cleanest statement of why an attractor network is not automatically a graph: the symmetric part supplies the *nodes*, the antisymmetric part supplies the *edges*, and a correlation-derived coupling matrix recovers only the first.

---

## The two design axes

### Axis 1 — what defines the fixed points

| Regime | Fixed points are… | Consequences | Instances |
|---|---|---|---|
| **Content-defined** | Written by a Hebbian/contrastive rule from the patterns themselves | Basins are shaped by pattern correlations, spurious mixture states exist, capacity is linear in fan-in, overload is **catastrophic** | [[wiki/entities/hopfield-network.md]], [[wiki/entities/rolls-treves-hippocampal-model.md]], [[wiki/entities/boltzmann-machine.md]] |
| **Prestructured / scaffold** | Fixed in advance by frozen dynamics (a grid code), with content attached by a random projection | Basins provably convex, uniform, spurious-free; capacity exponential in network size and set by the *address space*; overload degrades **resolution, not identity** | [[wiki/entities/vector-hash.md]] |
| **Orthogonalised** | Content-defined but driven mutually orthogonal | Kanter–Sompolinsky projector regime: maximal capacity, error-free recall, attractors = positive-eigenvalue eigenvectors of `J` | [[wiki/entities/fcann.md]] |
| **Masked** | A single weight matrix, gated per context: `a_i^k a_j^k c_ij^k` | Non-applicable memories are *deleted from the dynamics*, not out-competed; `O(1)` selection, but the mask's controller costs more than the memory | [[wiki/entities/context-modular-memory-network.md]] |

### Axis 2 — how many

| Regime | Statement | What it is for |
|---|---|---|
| **Discrete** | Isolated point attractors | Item memory, categorical de-aliasing, hypothesis selection |
| **Continuous (CANN)** | A connected manifold of marginally stable states — ring, torus, plane — from translation-invariant recurrence | Position, heading, evidence: any quantity that must be *held and moved smoothly* ([[wiki/concepts/path-integration.md]]) |
| **Sequential** | Slightly stronger forward than reverse weights, so the state walks a chain | Order for free; the transitions are driven by noise and nothing schedules them ([[wiki/concepts/working-memory.md]], [[wiki/entities/dense-sequence-memory.md]]) |

A continuum is what makes path integration expressible at all: the update `z_t = f(Wz_{t−1} + Ba_t)` moves the bump along the manifold, so equal total displacement lands on the same state *by construction* — the wiki's only mechanical answer to path-consistency (G3).

---

## What relaxation buys, and what it will not do

| Property | Statement | Where it bites |
|---|---|---|
| **Retrieval is search-free** | One settling pass, no comparison step, no explicit query against a library | G37's third answer: retrieval by relaxation costs the same at any library size, which subgraph matching ([[wiki/concepts/subgraph-matching.md]]) never achieves |
| **Completion is the same operation as recognition** | A partial cue and a full one differ only in where they start | [[wiki/concepts/pattern-separation-completion.md]] — and the separation/completion bias (G38) is exactly *how steep* the basin walls are |
| **No certificate** | The network cannot distinguish a correct completion from a confident wrong one; aging failure is precisely this | The confident-over-generalisation failure mode, and the reason a per-read confidence signal ([[wiki/entities/sparse-distributed-memory.md]]'s `\|s_u\|`) or a two-threshold novelty read ([[wiki/entities/vector-hash.md]]) has to be bolted on |
| **Capacity is closed-form and the overload behaviour is a design choice** | `p_max ≈ k·C/(a ln(1/a))` for the recurrent-Hebbian case (catastrophic); logarithmic-in-count for the scaffold case (graceful) | G42 — the only stores in the wiki that know when they are full are attractor networks |
| **The stored library has no similarity structure** | In the randomly-addressed variants a retrieved item's neighbours in the store are unrelated to it | Kills "give me structures like this one" — the query a schema library exists to answer |
| **Stability is anti-mobility** | A state is held reliably *because* it resists being moved, which is what makes search, tracking and update slow | The dilemma [[wiki/entities/adaptive-cann.md]] resolves with one slow negative-feedback term |

---

## The control knob: adaptation

The single most transferable result on this page is that **one scalar moves a fixed circuit through four qualitatively different computations without changing a weight** ([[wiki/entities/adaptive-cann.md]]): adaptation gain `m` against input strength `α`, with both switching thresholds analytic (`m = τ/τ_v` and `m = τ/τ_v + α/A_u`) — locked-to-input → oscillating around the estimate → running free through the state space. Parked at the boundary with noise, exploration breadth is itself a formula (`α_Lévy = 1 + 2µ/γ²`).

That converts two of the wiki's mode-switch questions into continuous knobs: *when to roll out* and *how broadly* (G15), and, one level down, *how long to hold before releasing* in working memory. What sets the gain is exogenous in every model here, so the gap is sharply localised — a controller for one scalar.

**A second knob, at the read-out rather than in the dynamics** ([[wiki/entities/dense-sequence-memory.md]]): steepening the nonlinearity applied to the state–pattern overlap takes sequence capacity from linear in `N` to polynomial or exponential, with the code, the sparsity and the learning rule untouched. It is the cheapest capacity lever in the wiki and it is orthogonal to fan-in, active fraction and address space.

**A third, in the synapses rather than in the activity** ([[wiki/entities/stp-flickering-cann.md]]): short-term plasticity gives the recently-occupied attractor a gain advantage that survives the disappearance of its sensory support, so a "memory" persists in synaptic state while activity correlation with it has essentially vanished. This is the wiki's one worked case of a bias over attractors held somewhere other than the state.

**A fourth use of the same adaptation term, this time to abolish the fixed points outright** ([[wiki/entities/trnn.md]], Liu et al. 2025): put A-CANN's `τ_v dV/dt = −V + mr` on every unit of a *trained* ReLU recurrent net, sparsify the recurrence and split it into three blocks, and the network can no longer hold anything — so it learns to carry the delay in a moving trajectory instead. Activity entropy rises and mean squared rate falls with the resulting transient index, and the network beats its persistent-activity twin on distractors, on 2–6 remembered items and on spatial navigation at equal parameter count. Read against the row above: **stability-is-anti-mobility is not a dilemma to be balanced but a choice with a measured winner on these tasks**, and the losing side is the one a trained recurrent net picks by default.

**And the wiki's one case where relaxation loses a like-for-like comparison** ([[wiki/entities/stsp-working-memory-rnn.md]], Kozachkov et al. 2022). Trained on the same working-memory task, fixed-weight recurrent networks converge on this page's default solution — point attractors under `tanh`, line attractors under ReLU, one per remembered item, with the distractor knocking the state out of a basin and the basin recapturing it. They perform the task, and they are *less* like prefrontal cortex than networks that hold nothing in activity at all. Two costs of the attractor solution are measured there rather than argued: the landscape has to be **fine-tuned**, so ablating 10–20% of synapses destroys it (a plastic-synapse network tolerates >50%); and by construction it keeps the item decodable from activity throughout the delay, which the recorded population does not.

---

## Relevance to a reasoning model

- **Attractors are the node set, not the graph.** Every use in the wiki supplies discrete, addressable, re-recognisable states — which is exactly what G27 says the graph formalisation presupposes and nothing supplies. What relaxation does *not* supply is the edges: the traversal has to come from an asymmetric term, a sequence chain, or an external action signal.
- **It makes the fast store cheap and the slow learner no easier.** Relaxation gives instance-level binding, de-aliasing and retrieval at one settling pass each. The scaffold that makes it work well is, in the best case in the wiki, *installed outright* — grid modules, periods, torus topology all supplied ([[wiki/entities/vector-hash.md]]) — so capacity and structure discovery are demonstrably separable problems and solving the first buys nothing toward the second (G1).
- **It is the wiki's only mechanism with a self-test that needs no data.** Attractor–eigenvector alignment and convergence time against a degree-preserving permutation of the same weights are computable from the weight matrix alone ([[wiki/entities/fcann.md]]) — a structural instrument in a list ([[wiki/concepts/representation-probing.md]]) that is otherwise entirely label-dependent.
- **(brainstorm)** The separation/completion knob and orthogonality are the same quantity at two scales: sparsification makes stored items orthogonal *at write time*, while a contrastive rule drives them orthogonal by subtracting what the network already predicts. The second needs no sparsity constraint and no allocation decision, and its anti-Hebbian term is exactly "do not re-store what you can already reconstruct" — the cheapest imaginable answer to *when to write* (G19).

---

## Open problems

- **Nothing sets the gain.** Adaptation strength, inverse temperature `β`, and the separation/completion bias are three names for "how deep the basins are", and all three are exogenous in every model here (G38, G15).
- **The library has no metric.** Randomly-assigned addresses buy convex spurious-free basins and destroy the neighbour relation, so a store optimised for retrieval cannot answer a similarity query — and the fix (data-dependent addressing) reintroduces the correlations the randomisation removed ([[wiki/empirical-tensions.md]] T55).
- **Correlated data breaks the bounds qualitatively.** Capacity derived from i.i.d. random patterns is not conservative but *wrong*: 200,000 MovingMNIST frames well inside the predicted capacity are recalled not at all ([[wiki/entities/dense-sequence-memory.md]]).
- **No account of where the manifold comes from** (G47). Every continuous attractor here has its topology built in by translation-invariant weights, so the manifold is a claim the designer makes about the domain before any data arrive. Nothing in the wiki learns it, and nothing would notice if it were wrong.
- **Item capacity and sequence capacity are different numbers** and only one is ever reported (G42).

---

## Connections

- **[[wiki/entities/hopfield-network.md]]** — the canonical content-defined discrete case: this page's energy function, capacity limit and spurious-state problem are all stated there first.
- **[[wiki/entities/fcann.md]]** — supplies the orthogonalised regime, the `β`-as-prior-precision reading, and the `J = J^S + J^A` split that separates this page's landscape from its traversal.
- **[[wiki/entities/adaptive-cann.md]]** — turns the stability-vs-mobility dilemma stated here into one scalar with analytic switching thresholds.
- **[[wiki/entities/stp-flickering-cann.md]]** — the bias over attractors held in synaptic state rather than in activity, with a theta rhythm as the release mechanism.
- **[[wiki/entities/stsp-working-memory-rnn.md]]** — the comparison this page loses: trained fixed-weight networks pick point or line attractors for a delay task, and are both more fragile to synapse loss and less like the recorded prefrontal population than a network with no persistent delay activity.
- **[[wiki/entities/vector-hash.md]]** — the prestructured-scaffold regime: convex spurious-free basins, exponential capacity, graceful overload, and no similarity structure.
- **[[wiki/entities/context-modular-memory-network.md]]** — the masked regime, where non-applicable attractors are deleted from the dynamics rather than out-competed.
- **[[wiki/entities/dense-sequence-memory.md]]** — the sequential regime, and the read-out-nonlinearity knob that buys capacity without touching the code or the rule.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the quantitative biological instance: `p_max`, diluted connectivity, and the catastrophic-overload failure mode.
- **[[wiki/entities/sparse-distributed-memory.md]]** — the non-recurrent relative, and the source of the per-read confidence signal relaxation itself cannot produce.
- **[[wiki/entities/boltzmann-machine.md]]** — the stochastic-sampling version of the same energy landscape, where relaxation becomes inference rather than retrieval.
- **[[wiki/entities/fly-central-complex.md]]** — a ring attractor observed end to end in an identified population, including the offset-preserving reset no model here has.
- **[[wiki/concepts/path-integration.md]]** — what a continuous attractor is *for*: the manifold is what makes displacement accumulation path-consistent by construction.
- **[[wiki/concepts/pattern-separation-completion.md]]** — completion *is* relaxation; the separation/completion bias is the steepness of this page's basins.
- **[[wiki/concepts/working-memory.md]]** — maintenance as occupancy of a fixed point, and the noise-driven attractor chain that produces order for free.
- **[[wiki/concepts/energy-based-models.md]]** — the general frame: an attractor is a minimum of a scalar compatibility function, and inference is `argmin` over it.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — relaxation to a joint minimum is the composition-by-constraint-satisfaction mechanism proposed for G21.
- **[[wiki/concepts/subgraph-matching.md]]** — the rival answer to G37: explicit structural comparison, which scales with library size where relaxation does not, and which returns a score where relaxation returns only a state.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — sparsity is what makes stored states near-orthogonal, and therefore what sets basin separation at write time.
- **[[wiki/concepts/latent-graph-discovery.md]]** — attractors supply the node set the framing presupposes, and supply no edges.
- **[[wiki/entities/hag-reservoir.md]]** — the wiki's one case of a recurrent coupling matrix being *grown from data* rather than hand-specified, which is the missing half of G47; what it grows is symmetric by construction (`r_ij = r_ji`), so it builds this page's `J^S` — fixed points — and none of the `J^A` that would supply traversal.
- **[[wiki/concepts/population-geometry.md]]** — the measurement side: a manifold of stable states is what population geometry reads out, and intrinsic dimensionality is the only available handle on a topology this page always imposes by hand (G47).
- **[[wiki/concepts/recall-gated-consolidation.md]]** — uses relaxation as a *signal* rather than as a computation: agreement between feedforward and recurrent input, `x·(Wx)`, is high exactly when the input sits in a stored basin, which makes attractor depth the familiarity scalar that licenses a long-term write.
- **[[wiki/entities/btsp-cam.md]]** — a basin without a landscape: a purely feedforward binary-weight map in which masked cues still return the stored trace, because one-shot learning makes each unit's weighted-sum distribution *bimodal* and the threshold sits in the gap. It is a fourth entry for Axis 1 — fixed points defined by neither content nor scaffold but by **which units were gated** during learning — and it detaches "attractor-like completion" from relaxation, so this page's search-free-retrieval row is available at one step rather than ~100.
- **[[wiki/concepts/manifold-constrained-learning.md]]** — the behavioural price of the topology this page always imposes: recurrence that stabilises a manifold is also what forbids leaving it, and in M1 the activity patterns off the fitted manifold turn out to be unlearnable within a session however useful they would be — so a designer's wrong manifold is not an inaccuracy but a region of behaviour the system cannot reach (G47). The same page now also charges the *antisymmetric* part: monkeys cannot volitionally reverse an M1 trajectory even though the reversed path visits the same states, which is what a fixed `J^A` predicts and what a purely symmetric landscape does not (talk-nd-brain-learning-limits, **(tentative)**).
- **[[wiki/entities/trnn.md]]** — the case where relaxation is what a trained recurrent net does *by default* and removing it helps: self-inhibition, sparse recurrence and block topology suppress fixed points, raise activity entropy, lower mean squared firing rate, and win on distractor, multi-item and spatial working-memory tasks at matched parameter count (Liu et al. 2025).
- **[[wiki/concepts/control-unity-and-diversity.md]]** — hands this page a behavioural signature to be responsible for: dopamine depletion in marmoset prefrontal cortex impairs delayed response *and improves* extra-dimensional set-shifting, which one basin-depth parameter with opposite signs on maintenance and escape would produce, and which no shared-control-budget model can (Friedman & Robbins 2021).
