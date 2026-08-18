# Complementary Learning Systems (CLS)

**Intelligence requires two memory systems with different learning rates — a fast, sparse, instance-based hippocampal store that encodes single experiences, and a slow, distributed neocortical store that extracts statistical structure — coupled by offline replay that transports information from the first to the second.**

CLS is the biological argument for the **two-timescale factorization** the wiki treats as mandatory: slow **W** (weights) / fast **M** (memory), see [[wiki/concepts/latent-graph-discovery.md]].

---

## Why two systems (the interference argument)

A single distributed learner trained on temporally correlated experience overwrites earlier solutions: parameters shift to the optimum for task 2 and destroy the configuration that solved task 1 (catastrophic forgetting). Two escapes exist, and CLS takes both:

1. **Interleave** the experience — but real experience arrives correlated and sequential, not interleaved.
2. **Buffer it elsewhere first** — encode rapidly in a system whose code is sparse enough that new items do not overlap old ones, then *replay* from that buffer to the slow learner in interleaved order, offline.

CLS was originally proposed (McClelland, McNaughton & O'Reilly 1995) precisely as the solution to this problem, which makes it a *derived* architecture rather than an anatomical accident: given correlated experience and a distributed slow learner, something with the hippocampus's properties is forced.

## The two systems

| Property | Hippocampus / medial temporal lobe | Neocortex |
|---|---|---|
| Learning rate | Fast — one exposure | Slow — many interleaved exposures |
| Code | Sparse, pattern-separated, conjunctive | Dense, distributed, overlapping |
| Content | Specific episodes, bound in context | Statistical regularities, semantics, skills |
| Retrieval | Content-addressable, cue completion | Generalization to new instances |
| Failure if used alone | No generalization, no compression | Catastrophic interference |
| Role in [[wiki/concepts/latent-graph-discovery.md]] | **Instance-graph** — this episode's topology, bound once | **Meta-graph** — structure shared across episodes |

**Replay** is the coupling: reinstatement of the structured activity patterns that accompanied the original event, during sleep and quiet rest, driving consolidation into cortex.

---

## Machine instantiations

| System | Mechanism | What it borrows | What it drops |
|---|---|---|---|
| **DQN experience replay** | A buffer of past transitions sampled at random during training | The interleaving function of replay; decorrelates consecutive experience, stabilizes value learning, multiplies data efficiency | The buffer is a *flat, uniform store* — no pattern separation, no conjunctive binding, no context |
| **Prioritized replay** | Sample transitions in proportion to TD error / reward magnitude | Matches the biological finding that hippocampal replay favours high-reward events | Priority is a scalar, not a structural criterion |
| **Episodic control** (model-free episodic control, neural episodic control) | Store (state, action, return) and act by similarity to stored states | The *fast* system used directly for behaviour, not only as a teacher for the slow system | No consolidation path back into the slow learner |
| **Memory-augmented networks** (Neural Turing Machine, DNC) | External content-addressable matrix written and read by a learned controller | Content-addressable retrieval; explicit control/storage separation | The controller's weights are the only slow learning; no replay-driven consolidation |

**The key empirical claim** (Hassabis et al. 2017): episodic control outperforms deep RL *early* in learning and succeeds on tasks requiring one-shot learning where deep RL fails — the predicted signature of a fast instance-based system, confirmed after being derived normatively.

---

## Mapping to the wiki's core framing

| CLS element | Latent-graph element |
|---|---|
| Neocortex, slow, many episodes | Slow **W** ← meta-graph: transition structure shared across the environment family |
| Hippocampus, fast, one episode | Fast **M** ← instance-graph: this task's particular topology |
| Pattern separation (sparse conjunctive codes) | De-aliasing (hardness source 3) — the same observation at structurally distinct positions gets distinct codes |
| Replay / consolidation | The channel by which instance experience *becomes* meta-structure — the wiki has no machine architecture that does this online |
| One-shot encoding | Instantiation is **binding**, not learning: the schema's free slots are filled in a single pass |

**(brainstorm)** The wiki's W/M split is usually justified by sample complexity (nothing identifies a high-dimensional instance function from k≈3 examples). CLS supplies an *independent* derivation of the same split from interference alone. Two unrelated arguments converging on the same factorization is the strongest structural evidence the wiki currently has that the split is not an arbitrary modelling choice.

---

## Open problems

- **Replay is a training-time device in AI and an online device in brains.** DQN replays into a gradient step during learning and then stops; the hippocampus replays throughout life. No wiki architecture consolidates instance-graph structure into the meta-graph *during deployment*.
- **What gets replayed is a policy, not a detail.** Reward-prioritized replay is the only criterion currently used; a structure-prioritized criterion (replay what most reduces uncertainty about the meta-graph) is unexplored here.
- **Consolidation is probably not copying.** Whether systems consolidation transfers episodes or *transforms* them into schemas is unsettled and is the subject of a later wave ([[wiki/architectural-gaps.md]]).
- **The replay buffer is "a very primitive hippocampus."** It lacks pattern separation, completion, and context binding — exactly the properties that make the biological system a de-aliaser.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — CLS is the biological derivation of the slow-W / fast-M split that LGD requires, and hippocampal pattern separation is the biological form of LGD's de-aliasing requirement.
- **[[wiki/concepts/continual-learning.md]]** — same problem (catastrophic interference), opposite solution family: CLS routes around interference with a second system, continual-learning methods protect weights inside one system.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the most complete worked example of the transfer thesis: a systems-level biological theory became a concrete AI training mechanism (experience replay) with measurable gains.
- **[[wiki/concepts/meta-learning.md]]** — both factorize learning into two timescales; meta-learning does it in one network's weights-vs-activity, CLS in two anatomically separate systems.
- **[[wiki/concepts/simulation-based-planning.md]]** — replay and preplay are the same hippocampal machinery run backwards and forwards; consolidation reuses the trajectory-generation capacity that planning needs.
