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

- **What controls attention?** Selection policies here are learned end-to-end for a task; no account of goal-driven control of the spotlight, which is the same gap as "what initiates a rollout" in [[wiki/concepts/simulation-based-planning.md]].
- **Hop depth.** Multi-hop retrieval works for a few supporting statements; reliability along long chains is untested here and is the same problem as self-generated intermediate nodes (gap G10).
- **Content vs. structure addressing.** Attention retrieves by similarity of content; a navigator needs retrieval by structural position.
- **Serial vs. parallel.** Biological attention is serial and resource-bounded; dense machine attention is parallel and quadratic — the biological constraint may carry computational content the import dropped.

---

## Connections

- **[[wiki/concepts/working-memory.md]]** — attention is the read/write access discipline for an external memory; the controller acts on the store only through it.
- **[[wiki/concepts/latent-graph-discovery.md]]** — attention weights are a content-computed soft adjacency, i.e. a one-step graph recomputed per query rather than a persisted structure.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the clearest case of an import that arrived largely unacknowledged, and the source of an open prediction (a neural substrate for memory hops).
- **[[wiki/concepts/simulation-based-planning.md]]** — both need a control policy that decides where the next computation is spent; neither has one.
