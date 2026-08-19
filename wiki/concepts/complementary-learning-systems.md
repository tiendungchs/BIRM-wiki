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

**Replay** is the coupling: reinstatement, during sleep and quiet rest, of the structured activity patterns that accompanied the original event, driving consolidation into cortex. Replay is biased toward events that led to high reinforcement — but reward is **not** the criterion, and may not even be the main one. Replay upsamples rarely-visited space, prefers remote over imminent trajectories, and actively suppresses salient-but-idiosyncratic stimuli; consolidating everything overfits, so the channel is a *filter* rather than a pipe. Full account: [[wiki/concepts/offline-replay.md]] (Liao & Losonczy 2024).

---

## The return path has a wiring constraint

CLS names replay as the channel and stops. Rolls 2013 derives what the *retrieval* channel must look like, and the derivation is unusually strong for a biological argument because it is arithmetic.

Recall to cortex is a **reverse hierarchy of pattern associators**: CA3 → CA1 → deep entorhinal layers → parahippocampal/perirhinal → association cortex, each stage a heteroassociative net whose backprojecting synapses were modified during encoding (when forward-driven cortical firing coincided with backprojected hippocampal activity). Retrieval therefore *reinstates the cortical activity pattern present at encoding*, in every area that participated — the face in temporal cortex, the place in parietal, the reward in orbitofrontal.

| Constraint | Statement | Consequence |
|---|---|---|
| Per-stage capacity | Same form as the CA3 bound: `p ≈ k'C/(a ln(1/a))`, with `a` the local sparseness and `C` the backprojections received per cell | Every stage must carry at least as many memories as CA3 stores |
| Fan-out requirement | `C^HBP = C^RC · a_nc / a_CA3` — ≥ 12,000 hippocampally-originating afferents per cortical cell even in the best case | **A monosynaptic CA3→cortex readout is impossible**; each CA3 cell would need `C^HBP ×` (cortical cells / CA3 cells) synapses |
| Therefore | The backprojection must be **polysynaptic with gradual fan-out per stage** | Quantitative account of why cortex has as many backward as forward connections |

**(brainstorm) The machine reading is a cost model nobody applies.** Every retrieval-augmented architecture in the wiki treats the read-out from the fast store as free — one attention operation from a memory matrix into the model's residual stream. This says the *decompression* side of consolidation is the expensive half, that its cost scales with the ratio of cortical sparseness to store sparseness, and that the only affordable implementation is a staged expansion. A fast store that is very sparse (good for capacity) is *harder* to read back out, which is a trade-off the sparse-memory literature does not price.

**Two further CLS commitments the source revises:**

- **Forgetting is required, and it is reallocation.** The store has a hard capacity; exceeding it loses most of what is retrievable, not the marginal item. Heterosynaptic LTD overwriting old memories, plus fresh random CA3 sets for new episodes, is the proposed mechanism — so the retention window is set by *the acquisition rate of new episodes*, not by a clock. Testable and untested: in a constant restricted environment, hippocampal representations should remain stable indefinitely and no retrograde-amnesia gradient should be demonstrable.
- **"Neocortical representations changed after learning" is not evidence of transfer.** If the CA1 code changes, downstream cortical firing changes through *fixed* connections. Any consolidation claim needs to separate a changed input from a changed weight — a confound the machine analogue (frozen encoder, changed memory contents) has exactly.

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
  - **Partly answered, without replay.** Whittington et al. 2018 train the two learners *jointly*: a fast Hebbian write into the conjunctive store and slow gradient descent over the structural generator, end-to-end, so the slow learner is optimised precisely for *making the fast store's contents predictable and addressable*. Transport is continuous and online rather than an offline replay episode. Evidence that the coupling works: memories survive 400+ steps although backpropagation through time is truncated at 25, i.e. the retention is the Hebbian store's and the addressing is the gradient learner's. What it does not model is the CLS claim proper — nothing ever *moves* into cortex, so the fast store is never relieved ([[wiki/entities/tolman-eichenbaum-machine.md]]).
- **Fast level: separate system or recurrent state?** CLS says a second anatomical store; meta-RL says activity dynamics of one network ([[wiki/concepts/meta-learning.md]]). Unresolved — see [[wiki/empirical-tensions.md]] T2.
- **What gets replayed** — **partly answered, and against the machine version.** Reward-prioritisation is what machine replay copies; biology's demonstrated criteria run the other way (upsample the under-visited, suppress the non-recurring, prefer remote to imminent), and the proposed principle is an inductive bias toward *transferable* content rather than toward valuable content (Liao & Losonczy 2024; [[wiki/concepts/offline-replay.md]]). What remains open is the mechanism — inhibitory plasticity is predicted by modelling and not established — and whether the criterion is structural in the graph-disambiguating sense.
- **One mechanism, five sampling policies.** Interleaving, consolidation, planning, offline state-space construction and amortization each imply a different replay distribution, and nothing arbitrates between them ([[wiki/concepts/offline-replay.md]]).
- **When to trust the fast system.** Episodic control wins early and loses late; nothing arbitrates the handover.
- **When does transport happen?** The standard answer is sleep. Rolls 2013 argues for *waking*: recall during waking retrieves the relevant memories under rational guidance, so only useful episodes seed semantic structure, whereas noise-driven stochastic firing in sleep risks consolidating confabulation — the dream argument. [[wiki/empirical-tensions.md]] T34.
- **Capacity and generalisation are optimised by different models of the same tissue.** The most quantitative hippocampal model in the wiki ([[wiki/entities/rolls-treves-hippocampal-model.md]]) has no transfer story at all; the models with a transfer story state no capacity. Nothing has both.

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
- **[[wiki/concepts/core-knowledge.md]]** — an entity typed by a different core system is individuated without path context, so module membership supplies a discrete de-aliasing tag alongside the sparse conjunctive code.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — reaches the same two-timescale split from a third premise: one free-energy objective minimised over *activity* (fast) and over *weights* (slow), so the split needs neither two anatomies nor a sample-complexity argument (Butz 2016).
- **[[wiki/concepts/amortized-inference.md]]** — a third job for the same offline replay machinery: not decorrelating a training stream and not consolidating episodes, but compiling model-based rollouts into model-free cached values during dreaming or quiet wakefulness.
- **[[wiki/entities/hbtom.md]]** — localises what a missing fast store costs: deep baselines match a structured model on within-trajectory judgements and collapse to chance exactly where a latent must persist across trials and stay keyed to an agent identity.
- **[[wiki/concepts/contextual-inference.md]]** — a third answer to the same interference problem: not one fast store plus one slow store, but a *growing set* of slow stores with an inference process deciding which is being written to, so protection comes from low responsibility rather than from sparse coding (Heald et al. 2021).
- **[[wiki/concepts/pattern-separation-completion.md]]** — supplies the mechanism behind "sparse conjunctive code": the fast store's non-overlap is a tunable transfer curve implemented by dentate-gyrus expansion recoding, with a separate anatomical read port so retrieval need not fight storage (Yassa & Stark 2011).
- **[[wiki/concepts/cognitive-map.md]]** — the consolidation gradient measured on *structure*: maps learned before medial temporal damage survive it in schematized form, with retrosplenial/medial parietal cortex the cortical store and the hippocampus still required for fine spatial detail (Epstein et al. 2017).
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — hippocampal indexing theory implemented: the fast store holds only bindings between two cortical codes (structure and sensory), which makes consolidation the learning of what makes those bindings predictable rather than the transport of episodes — and its 2018 precursor runs the fast Hebbian write and the slow gradient step in one end-to-end objective, which is the wiki's only online version of this page's coupling.
- **[[wiki/entities/cscg.md]]** — the opposite assignment of the same anatomy: the *map itself* lives in the fast store, so cortex consolidates already-de-aliased state spaces rather than raw experience ([[wiki/empirical-tensions.md]] T28).
- **[[wiki/concepts/successor-representation.md]]** — makes "what gets replayed" a parameter: every multi-step transition shares one eigenbasis, so diffusive, super-diffusive (Lévy) and successor-distance sampling differ only in a diagonal reweighting.
- **[[wiki/concepts/offline-replay.md]]** — the contents of this page's coupling channel: replay is filtered rather than veridical, which turns "transport episodes to cortex" into "decide which episodes deserve to become structure".
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — supplies the missing return path with a wiring constraint (`C^HBP = C^RC a_nc/a_CA3`, hence a polysynaptic reverse hierarchy), a capacity bound on the fast store, and forgetting-as-random-reallocation instead of decay.
- **[[wiki/entities/temporal-context-model.md]]** — the limiting case of a contentless fast store: the hippocampus only reinstates entorhinal states, so cortex does all the remembering, and the abolition of pair-coding in area TE by rhinal lesion shows the similarity structure being *imposed* on cortex by medial temporal feedback.
