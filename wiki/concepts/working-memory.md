# Working Memory

**Maintain and manipulate a small set of items in an active store over a delay, under the control of a process that is separate from the store itself.**

The classic cognitive decomposition — a central executive plus separate domain-specific buffers (e.g. a visuo-spatial sketchpad), instantiated in prefrontal cortex and interconnected areas — is the source of the **control/storage separation** that turned out to matter most for machine reasoning (Hassabis et al. 2017).

In the wiki's framing, working memory is the substrate of fast **M**: the place where an instance-graph is bound and held while it is being navigated. See [[wiki/concepts/latent-graph-discovery.md]].

---

## Two designs for holding information over time

| | **Entangled** (recurrent nets, LSTM) | **Separated** (external memory) |
|---|---|---|
| Storage | Distributed in the same units that compute | An explicit memory matrix |
| Control | Same weights that store also sequence the computation | A controller network that attends to, reads and writes memory |
| Biological analogue | Attractor dynamics; gated maintenance in prefrontal recurrent circuits | Central executive + domain-specific buffers |
| Capacity coupling | Memory capacity is tied to unit count and interferes with computation | Memory scales independently of the controller |
| Demonstrated ceiling | State of the art across many sequence domains; can report on latent variable state after training on program text | Tasks that elude LSTMs: **shortest path through a graph such as a subway map**, block manipulation in a Tower-of-Hanoi variant |

The lineage runs: neuroscience-inspired recurrent networks with attractor dynamics and rich sequential behaviour → detailed models of human working memory → **gating** (information admitted into a fixed activity state and maintained until output is required), which is the mechanism LSTMs share with prefrontal maintenance models. The reverse-direction influence also holds: LSTM gating motivated gating-based models of prefrontal working memory ([[wiki/concepts/neuroscience-ai-transfer.md]]).

---

## Why control/storage separation matters for reasoning

The differentiable neural computer (DNC) — a neural controller reading and writing an external memory matrix, trained end-to-end — solves tasks that were argued to require **symbol processing and variable binding**, and therefore to lie outside the reach of neural networks. Two of those tasks are literally latent-graph tasks:

| Task | Latent-graph reading |
|---|---|
| Shortest path in a subway map | **Path latent**: topology given as input, vocabulary known, the composition connecting two nodes must be searched |
| Tower-of-Hanoi block manipulation | Path latent under constraints, with a goal node that must be matched exactly |

**What this establishes:** an externalized, content-addressable, writable store is sufficient to make a differentiable network do explicit graph traversal. **What it does not establish:** discovery — in both tasks the graph is *given to the network as input*, so the hard part of LGD (inferring edges and vocabulary from observation) is not tested. Memory-augmented networks are evidence about the *navigate* half only.

## Order for free: noise-driven attractor transitions

A third design, and the only one in the wiki that derives the *capacity number* rather than stipulating it (Rolls 2013, [[wiki/entities/rolls-treves-hippocampal-model.md]]). Hippocampal and prefrontal neurons fire at different points within a delay period — a **rate code for time** — and a recurrent network reproduces this without any oscillatory clock:

| Ingredient | Effect |
|---|---|
| Several attractors with slightly stronger forward than reverse weights | The state walks the chain in order |
| Spiking noise | Drives each transition; nothing schedules it |
| Adaptation | Kills the current attractor and biases the next toward the least-recently-active one |

Two payoffs. **Order comes free with storage** — items bound to time-encoding populations by the same associative rule that binds them to places, so recall in the presented order needs no extra mechanism. And **the span is derived**: noise limits the chain to perhaps `7 ± 2` sequential states, offered as the origin of the classic capacity limit and of why recency items are naturally recalled in order. Under this account working-memory capacity is a *dynamical* property (how many noisy transitions stay distinguishable) rather than a slot count — which predicts capacity should vary with adaptation and noise level, not with unit count.

Rolls contrasts this directly with theta/gamma phase-coding accounts of serial order ([[wiki/empirical-tensions.md]] T32), and concedes the site is unsettled: the natural substrate is the CA3 recurrent network, while part of the temporal-order lesion evidence implicates CA1.

**Duration.** Nothing restricts these mechanisms to seconds: LSTMs and DNCs can maintain information across many thousands of training cycles, so the same machinery may serve longer-term memory (e.g. retaining the contents of a book). The functional distinction "working vs. long-term" does not map onto an architectural one here.

---

## Mapping to the core framing

| Working-memory element | Latent-graph element |
|---|---|
| Buffer contents | Fast **M** — the instance-graph binding for this episode |
| Controller | The search/navigation policy over that graph |
| Gating (what enters, what is protected) | Which observations count as evidence about the current instance |
| Content-addressable read | Retrieval by node content `x`; the missing piece is retrieval by structural position `g` |
| Iterative memory "hops" | Multi-hop traversal — reasoning over several supporting statements ([[wiki/concepts/attention.md]]) |

### The world state as a writable store

A distinct argument for the same architecture, from efficiency rather than from capability ([[wiki/entities/h-jepa.md]]): a typical action modifies a *small part* of the world, but a network that passes state as a vector rewrites all of it every step. So the world state should live in a key-value memory with one entry per entity — move a bottle from the kitchen to the dining room and exactly three entries change.

| Operation | Form |
|---|---|
| Read | `v = Σ_j Normalize(Match(k_j, q))_j · v_j`, with `Normalize` competitive/thresholded, e.g. `c_j = exp(c̃_j) / (γ + Σ_k exp(c̃_k))` |
| Write | `Update(r, v, c) = c·r + (1−c)·v` on matched entries |
| **Allocate** | If the query is far from every key (the `γ` threshold), create a new slot with key `q` |

All differentiable, so gradients pass through the store. Two readings this wiki should carry:

- **Update locality is architecturally enforced**, which is what an instance-graph in fast **M** needs and what a monolithic state vector cannot provide.
- **The allocation threshold is a de-aliasing decision** (gap G2): "far from every key" means *this is a new node*, not a noisy version of an old one. It is the wiki's cheapest de-aliasing mechanism so far, and also its most fragile — identity is decided by a single scalar in a learned metric, with nothing path-sensitive about it.

**(brainstorm)** The DNC result and the CLS story converge on the same object from opposite directions: an external, content-addressable, fast-written store. Working memory contributes the part CLS lacks — an explicit **controller** with a learned read/write policy. A reasoning architecture plausibly needs one store with two access disciplines (episodic write-once for consolidation; controller-driven read/write for manipulation), not two stores.

---

## Open problems

- **Binding and variables.** The DNC demonstrates variable-binding-like behaviour without showing that a reusable variable *representation* exists; whether the binding generalizes to novel structures is untested here.
- **Capacity and interference in the buffer** — no account of what happens when the instance-graph exceeds the memory matrix.
- **Structural addressing.** Reads are by content similarity; navigation needs addressing by graph position (path-consistent `g`, gap G3).
- **Interpretability.** Networks with external memory are the case that resists virtual brain analytics most stubbornly.

---

## Connections

- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — derives the `7 ± 2` span from noise-driven transitions between asymmetrically coupled attractors, making capacity a dynamical rather than a slot limit, and puts serial order in the same recurrent network that stores episodes.

- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the only architecture in this ingest that performs explicit multi-hop graph traversal, and marks the boundary: it navigates a *given* graph, it does not discover one.
- **[[wiki/concepts/attention.md]]** — attention is the read mechanism of an external memory; internal attention and content-addressable retrieval are the same operation.
- **[[wiki/concepts/complementary-learning-systems.md]]** — external memory is the engineering form of the fast store; working memory adds the controller that decides what is written and read.
- **[[wiki/concepts/meta-learning.md]]** — meta-RL's inner learner lives in recurrent activity, i.e. in entangled working memory; its capacity limits are working-memory limits.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — control/storage separation is the transfer that produced graph-traversal-capable networks, and gating is the case where influence ran both ways.
- **[[wiki/concepts/simulation-based-planning.md]]** — the controller/model split used for planning is the same separation applied to an environment model instead of a memory matrix.
- **[[wiki/concepts/core-knowledge.md]]** — the object system's set-size limit (~3 in infants, 4 in monkeys, 3–4 in adult object tracking) is the same small-integer capacity this page's store has, and it holds across species and cultures, so the bound may be one shared resource rather than a coincidence of two.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — under parameter sharing, activations are interpretable as weights and attention as a weight update, so an activity-based store and a plastic-weight store are the same object in different bases and this page's capacity limits transfer directly onto plastic memory.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — active maintenance falls out as the limiting case `α = β = γ = 0` of the predictive-coding update (hold the current encoding when neither top-down prediction nor bottom-up error is precise), so a store is not needed as separate machinery (Butz 2016).
- **[[wiki/concepts/event-segmentation.md]]** — the multiplicative gate that maintains an item until further notice is the same gate that detects an event boundary; maintenance and segmentation are one mechanism read at two timescales.
- **[[wiki/entities/h-jepa.md]]** — applies the control/storage separation to the *environment model*: world state held in a per-entity key-value store with sparse updates and threshold-triggered slot allocation, so an action edits three entries instead of rewriting a state vector.
- **[[wiki/concepts/compositionality.md]]** — differentiable programming (external memory, stacks, queues, Neural Turing Machine → Differentiable Neural Computer → Neural Programmer-Interpreter) is the machine route to composition over data structures, and the reason those systems are read as learning *programs* — in a representation "more like assembly language" than a causal model of a domain (Lake et al. 2017).
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — prices the in-context store: a Transformer compresses only a few kilobytes at a time, so the fast level's capacity is a fixed byte budget with quadratic cost, and its value is measurable as bits saved per additional byte of context.
- **[[wiki/concepts/intelligence-density.md]]** — promotes recurrence from an efficiency choice to a necessary condition: without a loop the domain is pinned to the input dimension, so reuse of a rule across positions is impossible and `ℐ` cannot diverge (Choi 2026).
- **[[wiki/concepts/subgraph-matching.md]]** — supplies the missing addressing mode for the fast store: retrieval keyed by structural *shape* (does this pattern occur here?) rather than by content vector, answered as a coordinate comparison against precomputed neighbourhood embeddings.
- **[[wiki/concepts/contextual-inference.md]]** — gives fast **M** a specific content: not the instance-graph but the *mixing weights over stored memories*, which is what a working-memory distractor task disrupts (producing evoked recovery in a motor-adaptation paradigm; Heald et al. 2021).
- **[[wiki/entities/maze-solving-transformers.md]]** — multi-hop traversal without a separate addressable store: an entire graph held in the residual stream of one token, with the reliability degradation along the path that an external store was introduced to fix (Ivanitskiy et al. 2023).
- **[[wiki/concepts/cognitive-map.md]]** — supplies the map this page assumes: shortest-path traversal over a subway map is route planning with the graph handed over, and that page is where the graph, its anchoring to the world, and its goal-distance read-outs come from.
- **[[wiki/entities/temporal-context-model.md]]** — recency without a buffer and without prefrontal cortex: a unit-norm leaky integrator that advances only when input arrives gives short- and long-term recency from one mechanism, with maintenance placed in entorhinal cortex.
- **[[wiki/entities/tem-transformer.md]]** — a fully specified store discipline: the key/value cache is the memory, the query is a structural address, and the *write* policy is stated rather than assumed — store a conjunction only if it is not already there, else attention is biased toward whatever was revisited most.
