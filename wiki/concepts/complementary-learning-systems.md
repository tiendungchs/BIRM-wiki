# Complementary Learning Systems

**Intelligence requires two memory systems with different learning rates — a fast, sparse, instance-based hippocampal store that encodes single experiences, and a slow, distributed neocortical store that extracts statistical structure — coupled by offline replay that transports information from the first into the second.**

Complementary learning systems (CLS) is the biological argument for the **two-timescale factorization** the wiki treats as mandatory: slow **W** (weights) / fast **M** (memory). See [[wiki/concepts/latent-graph-discovery.md]].

---

## Why two systems (the interference argument)

A single distributed learner trained on temporally correlated experience overwrites earlier solutions: parameters shift toward the optimum for task 2 and destroy the configuration that solved task 1 (catastrophic forgetting). Two escapes exist, and CLS takes both:

1. **Interleave** the experience — but real experience arrives correlated and sequential, not interleaved.
2. **Buffer it elsewhere first** — encode rapidly in a system whose code is sparse enough that new items do not overlap old ones, then *replay* from that buffer to the slow learner in interleaved order, offline.

CLS was proposed as the solution to this problem, which makes it a *derived* architecture rather than an anatomical accident: given correlated experience and a distributed slow learner, something with the hippocampus's properties is forced (Hassabis et al. 2017, reviewing McClelland, McNaughton & O'Reilly).

## The two systems

| Property | Hippocampus / medial temporal lobe | Neocortex |
|---|---|---|
| Learning rate | Fast — one exposure | Slow — many interleaved exposures |
| Code | Sparse, instance-based, conjunctive | Dense, distributed, overlapping |
| Content | Specific episodes, bound in context | Statistical regularities, semantics, skills |
| Retrieval | Content-addressable | Generalization to new instances |
| Failure if used alone | No generalization, no compression | Catastrophic interference |
| Role in [[wiki/concepts/latent-graph-discovery.md]] | **Instance-graph** — this episode's topology, bound once | **Meta-graph** — structure shared across episodes |

**Replay** is the coupling: reinstatement, during sleep and quiet rest, of the structured activity patterns that accompanied the original event, driving consolidation into cortex. Replay is biased toward events that led to high reinforcement.

---

## Machine instantiations

| System | Mechanism | What it borrows | What it drops |
|---|---|---|---|
| **Experience replay** (deep Q-network) | Buffer of past transitions sampled during training | The interleaving function of replay: decorrelates consecutive experience, stabilizes value learning in structured sequential environments, multiplies data efficiency | A flat uniform store — no sparse conjunctive code, no context binding |
| **Prioritized replay** | Sample transitions in proportion to reward / error magnitude | Matches the biological finding that replay favours highly rewarding events; empirically improves on uniform replay | Priority is a scalar, not a structural criterion |
| **Episodic control** | Store (state, action, return); act by similarity between the current input and stored events | The *fast* system used directly for behaviour, not only as a teacher for the slow one | No consolidation path back into the slow learner |
| **Memory-augmented networks** | External content-addressable matrix read/written by a learned controller | Content-addressable retrieval; explicit control/storage split ([[wiki/concepts/working-memory.md]]) | Controller weights are the only slow learning; no replay-driven consolidation |

**The key empirical claim** (Hassabis et al. 2017): episodic control outperforms deep RL *early* in learning and succeeds on tasks that depend heavily on one-shot learning, where deep RL architectures fail — the signature predicted by the normative theory *before* the architectures existed. This is the paper's cleanest example of neuroscience acting as a validation channel ([[wiki/concepts/neuroscience-ai-transfer.md]]).

---

## Mapping to the wiki's core framing

| CLS element | Latent-graph element |
|---|---|
| Neocortex, slow, many episodes | Slow **W** ← meta-graph: transition structure shared across the environment family |
| Hippocampus, fast, one episode | Fast **M** ← instance-graph: this task's particular topology |
| Sparse conjunctive coding | De-aliasing (hardness source 3): the same observation at structurally distinct positions receives distinct codes |
| Replay / consolidation | The channel by which instance experience *becomes* meta-structure — no machine architecture in this ingest does this online (gap G14) |
| One-shot encoding | Instantiation is **binding**, not learning: a schema's free slots filled in a single pass |

**(brainstorm)** The wiki justifies the W/M split by sample complexity — nothing identifies a high-dimensional instance function from a handful of examples. CLS supplies an *independent* derivation of the same split from interference alone. Two unrelated arguments converging on one factorization is the strongest structural evidence the wiki currently holds that the split is not an arbitrary modelling choice.

---

## Open problems

- **Consolidation is missing in silico.** Machine replay serves *stabilization of one learner*, not *transport between two*. The direction hippocampus→cortex — instance structure becoming meta structure — has no machine analogue here.
- **Fast level: separate system or recurrent state?** CLS says a second anatomical store; meta-RL says activity dynamics of one network ([[wiki/concepts/meta-learning.md]]). Unresolved — see [[wiki/empirical-tensions.md]] T2.
- **What gets replayed.** Reward-prioritization is the only selection criterion demonstrated; a structural criterion (replay what disambiguates the graph) is unexplored.
- **When to trust the fast system.** Episodic control wins early and loses late; nothing arbitrates the handover.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the biological derivation of the slow-W / fast-M split, and maps hippocampal sparse coding onto the de-aliasing requirement.
- **[[wiki/concepts/continual-learning.md]]** — same interference problem, different solution: add a second fast system rather than gate plasticity within one; replay and weight protection are complementary, not rival.
- **[[wiki/concepts/meta-learning.md]]** — the rival implementation of the same two-timescale factorization, with the fast level carried by recurrent activity instead of a separate store.
- **[[wiki/concepts/simulation-based-planning.md]]** — replay (backward, for consolidation) and preplay (forward, for planning) are the same hippocampal trajectory-generation machinery serving two functions.
- **[[wiki/concepts/working-memory.md]]** — external content-addressable memory is the engineering form of the fast store; working memory adds the controller that decides what is written and read.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the most productive single transfer in the historical record, and the one case where a normative biological prediction was confirmed after the fact in machines.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the hippocampal–entorhinal system holds the fast instance store and the structural code in one anatomy, which is what makes binding content to graph position cheap.
- **[[wiki/concepts/synaptic-plasticity.md]]** — short- and long-term plasticity give the same fast/slow timescale split *within a single synapse*, so the separation this page states anatomically is already present one level down and does not require two systems to exist.
