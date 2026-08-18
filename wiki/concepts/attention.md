# Attention

**Process a selected subset of the available information at each step, and use the freed capacity to update state and choose what to select next.**

Attention enters this wiki twice: as **external** selection (where to look in the input) and as **internal** selection (what to read from memory). The second is the operation that made multi-hop reasoning differentiable.

---

## The argument from modularity

The brain does not implement one global optimization principle in a uniform network; it is modular, with distinct interacting subsystems for memory, language and cognitive control (Hassabis et al. 2017). Attention is the most visible import of that stance into AI: the primate visual system does not process all input in parallel with equal priority, but shifts processing resources and representational coordinates among locations and objects in turn.

| Property of biological attention | Consequence when imported |
|---|---|
| Serial sampling of regions ("glimpses") | Architecture: take a glimpse, update internal state, select the next location |
| Prioritization of currently relevant information | Robustness to clutter — irrelevant objects can be ignored rather than encoded |
| Fixed processing resource independent of scene size | **Computational cost scales favourably with input size**, unlike whole-image convolution |
| Recentred representational coordinates | Object-centred rather than image-centred codes |

Reported results: glimpse-based models classify well under clutter where whole-image convolutional networks degrade; extensions outperform convolutional networks on difficult multi-object recognition in both accuracy and efficiency; attention improves image-to-caption generation.

**Attention selects core-typed objects, not regions.** Adult object-based attention inherits the object system's entry conditions and its capacity: 3–4 separately moving items can be tracked when their boundaries and motions obey cohesion and continuity, and entities *violating* those constraints cannot be tracked at all, at any set size (Scholl & Pylyshyn 1999; vanMarle & Scholl 2003; Marino & Scholl 2005; Spelke & Kinzler 2007). Two consequences for an imported attention mechanism: the unit of selection is supplied by an upstream prior rather than by the attention policy, and the capacity bound is a fixed small integer rather than a soft cost — dense machine attention has neither ([[wiki/concepts/core-knowledge.md]]).

---

## Internal attention: the spotlight turned on memory

Directing the same selection mechanism at the contents of memory rather than at the sensory input yields **content-addressable retrieval** — a concept itself imported into AI from neuroscience.

| Use | Effect |
|---|---|
| Read selection in memory-augmented networks | Enables the control/storage separation of [[wiki/concepts/working-memory.md]] |
| Alignment in machine translation | Selects which source positions inform each output step |
| Iterative "hops" through memory | Reasoning over multiple supporting statements that jointly answer a query — the differentiable form of multi-step inference |
| Incremental generation (attentional generative models) | Building an image by attending to one portion of a "mental canvas" at a time |

The memory-hop mechanism is also the paper's outstanding *prediction for neuroscience*: an equivalent iterative retrieval process has been proposed for human cognition, plausibly hippocampal, but no neural substrate has been described ([[wiki/concepts/neuroscience-ai-transfer.md]]).

---

## Reading in the core framing

| Attention operation | Latent-graph reading |
|---|---|
| Select next glimpse location | Choosing which edge to traverse when the evidence about the graph is gathered by acting |
| Content-addressable read | Retrieval of a node by its content `x` |
| One hop through memory | One edge traversal; a chain of hops is a path |
| Attention weights as a soft adjacency | **(brainstorm)** A query–key similarity matrix over stored items *is* a weighted adjacency over those items — attention is a dense, learned, one-step graph, which is why it substitutes for explicit traversal on short paths and degrades on long ones |
| Cost scaling with input size | The reason selection is mandatory: a full graph over all observations is quadratic and mostly empty |

**(brainstorm)** If attention is a soft adjacency, then the difference between attention and navigation is *how many steps of it the architecture can chain reliably*, and whether the adjacency is recomputed from content each time (attention) or persisted as structure (a graph). Persisting it is exactly what fast **M** is for.

---

## Open problems

- **What controls attention?** Selection policies here are learned end-to-end for a task; no account of goal-driven control of the spotlight, which is the same gap as "what initiates a rollout" in [[wiki/concepts/simulation-based-planning.md]]. The one architectural proposal in the wiki is H-JEPA's **configurator** — a module that primes perception, world model and cost for the current task by modulating their parameters and attention circuits, implemented in transformer modules as *extra input tokens* that change the connection graph. It supplies the interface and not the policy: how it chooses a task decomposition is left unspecified by its own author (gap G33).
- **Hop depth.** Multi-hop retrieval works for a few supporting statements; reliability along long chains is untested here and is the same problem as self-generated intermediate nodes (gap G10).
- **Content vs. structure addressing.** Attention retrieves by similarity of content; a navigator needs retrieval by structural position.
- **Where does the unit of selection come from?** Glimpse models select regions; biological object-based attention selects *objects*, individuated by a prior that runs before selection. Nothing here specifies who computes that individuation, which is gap G23's entry test in another place.
- **Serial vs. parallel.** Biological attention is serial and resource-bounded; dense machine attention is parallel and quadratic — the biological constraint may carry computational content the import dropped.

---

## Connections

- **[[wiki/concepts/working-memory.md]]** — attention is the read/write access discipline for an external memory; the controller acts on the store only through it.
- **[[wiki/concepts/latent-graph-discovery.md]]** — attention weights are a content-computed soft adjacency, i.e. a one-step graph recomputed per query rather than a persisted structure.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the clearest case of an import that arrived largely unacknowledged, and the source of an open prediction (a neural substrate for memory hops).
- **[[wiki/concepts/simulation-based-planning.md]]** — both need a control policy that decides where the next computation is spent; neither has one.
- **[[wiki/concepts/shortcut-learning.md]]** — selecting a feature subset is also *deselecting* everything else, so an attention policy fixes which invariances the decision rule has, i.e. which shortcuts remain available to it.
- **[[wiki/concepts/core-knowledge.md]]** — raises attention from an efficiency device to a binding bottleneck: competition for a limited attentional resource is the stated reason two specialized modules cannot pool their outputs into one representation.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — recovers attention as *action abstracted from execution*: active inference pointed at internal predictive encodings instead of at the world, which makes attentional control and behavioural control one mechanism and supplies the selection policy this page lacks (Butz 2016).
- **[[wiki/concepts/event-segmentation.md]]** — an event boundary is a lasting change in the currently active encoding set, i.e. the signal that says *now re-select*; segmentation supplies the timing that attention supplies the target for.
- **[[wiki/concepts/amortized-inference.md]]** — attention is how a fast amortized mapping is decomposed into a sequence of sub-queries rather than one shot: caption models attend to each object as it is mentioned, and generative models attend to one image region at a time, which is what makes a feed-forward pass a *proposal* rather than an answer.
- **[[wiki/concepts/three-component-framework.md]]** — lists focused attention as one of four canonical inductive biases, i.e. a prior inserted through the architecture slot rather than learned from data.
- **[[wiki/entities/h-jepa.md]]** — its configurator is the goal-driven spotlight controller this page lacks, and it makes modulation-by-token the concrete mechanism: extra transformer inputs reconfigure the connection graph of the module being primed.
- **[[wiki/concepts/subgraph-matching.md]]** — the rival retrieval mechanism: a dot-product score is content similarity against a one-step soft adjacency, where an order embedding tests *containment of a whole multi-hop pattern*, which is what querying a schema library requires and similarity cannot express.
- **[[wiki/entities/maze-solving-transformers.md]]** — the soft-adjacency brainstorm above, measured: one head (L5H3) places its attention on tokens at *path* length 1 from the current position, i.e. it has learned the in-context adjacency matrix rather than the lattice's, and a second appears to be half a reversed induction head pointing at the goal (Ivanitskiy et al. 2023).
- **[[wiki/concepts/representation-probing.md]]** — supplies the instrument that identified those heads (direct logit attribution) and the caveat attached to it: decomposing a logit says which head writes toward the answer, not what computation it performs.
