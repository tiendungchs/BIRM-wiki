# Neuroscience → AI Transfer

**Importing the brain's *computational-* and *algorithmic-level* solutions (Marr levels 1–2) into machine architectures, treating biological plausibility as a search heuristic rather than a design constraint.**

This is the wiki's methodological premise: the reason a brain-inspired model is worth building at all. Everything else here is downstream of the argument on this page.

---

## Why look at the brain

| Argument | Statement | Force |
|---|---|---|
| **Sparse search space** | The space of possible general-intelligence architectures is vast and very sparsely populated with working solutions (Hassabis et al. 2017) | Random or purely mathematical search is unlikely to land on one; a known solution is a prior over where to look |
| **Existence proof** | The brain is the *only* extant system that demonstrably achieves the target capability | Removes the question "is this achievable?" and replaces it with "how is it achieved?" |
| **Validation channel** | Finding that an already-invented algorithm is implemented biologically is evidence it belongs in a general system | Resource-allocation signal: if a method underperforms but is core to the brain, redoubled engineering is more likely to pay off than abandonment |

The first two motivate *inspiration*; the third is a distinct and often-overlooked payoff — **validation**. They fail differently: inspiration failures waste effort on a mechanism that does not generalize; validation failures mis-prioritize an entire research programme.

## Which level transfers

| Marr level | Content | Transferable? |
|---|---|---|
| **Computational** | What problem the system solves and why | **Yes** — the primary target. Framing transfers (e.g. "the brain solves relational structure inference", → [[wiki/concepts/latent-graph-discovery.md]]) |
| **Algorithmic** | The representations and processes that realize it | **Yes** — the main working level. Factorized codes, replay schedules, gating, attention |
| **Implementation** | Ion channels, spike timing, biophysics | **Mostly not** — deliberately excluded by the Hassabis programme; this is where Blue Brain and pure neuromorphic reverse-engineering sit |

The exclusion is a *choice*, not a finding, and it is contested — see [[wiki/empirical-tensions.md]]. Spiking / neuromorphic work argues the implementation level carries computational content (energy, timing codes, one-shot plasticity) that is lost at the algorithmic level.

---

## Track record: what has actually transferred

| AI mechanism | Biological origin | What transferred |
|---|---|---|
| CNN: nonlinear transduction, divisive normalization, max pooling, layer hierarchy | V1 simple/complex cells; convergent-divergent cortical hierarchy | Architecture + receptive-field structure |
| Distributed (vector) representations, machine translation embeddings | Parallel Distributed Processing movement's sentence-processing models | Representational format |
| Dropout | Poisson-like stochasticity of biological firing | A regularizer derived from noise |
| Temporal-difference learning | Second-order conditioning in animals (value conferred CS→CS, not only CS→US) | An algorithm, near-wholesale |
| Experience replay (DQN) | Hippocampal replay + [[wiki/concepts/complementary-learning-systems.md]] | A *training schedule*, not an architecture |
| Prioritized replay | Hippocampal replay preferentially reinstates high-reward events | A weighting on that schedule |
| Episodic control | Hippocampal one-shot episodic memory; normative accounts favouring it under low experience | Non-parametric fast control |
| Glimpse / attention models | Primate visual attention shifting resources among locations and objects | Resource allocation + cost scaling with input size |
| External content-addressable memory (DNC, Neural Turing Machine) | Working-memory models separating a central executive from domain-specific buffers | **Control/storage separation** — enabled shortest-path search over a subway map and Tower-of-Hanoi block manipulation, tasks previously argued to require symbol processing and variable binding |
| Elastic Weight Consolidation | Dendritic-spine enlargement persisting across later learning; cascade models of synaptic state | Per-weight plasticity gating ([[wiki/concepts/continual-learning.md]]) |
| Grid-code-structured concept spaces | Entorhinal grid cells; fMRI evidence of grid-like codes during abstract categorization | A *representation* for decomposing state spaces |

**Pattern (brainstorm).** Every entry above transferred either a **representation** or a **scheduling/gating policy**. Nothing on this list transferred the thing the wiki actually needs: the **two-level meta-graph / instance-graph separation** of [[wiki/concepts/latent-graph-discovery.md]]. The transfer channel has been productive precisely where the brain's answer is a local mechanism, and silent where its answer is an architecture-wide factorization. That asymmetry is a prediction about where the next transfer must come from, and it is logged in [[wiki/architectural-gaps.md]].

---

## The reverse channel: AI → neuroscience

Transfer is bidirectional, and the reverse direction is what upgrades a metaphor into a validated mechanism.

| AI contribution | Neuroscience consequence |
|---|---|
| TD prediction error | Midbrain dopaminergic firing matches the TD error signal — the canonical "virtuous circle" case: animal conditioning → TD → dopamine theory |
| CNN model comparison | >30 architectures compared against ventral-stream representations; deep supervised nets fit best; explains rising category-orthogonal (position, size) coding up the stream |
| LSTM gating | Motivated gating-based maintenance models of prefrontal working memory |
| Meta-RL | Slow dopaminergic RL may train a *free-standing second* RL algorithm in prefrontal recurrent dynamics ([[wiki/concepts/meta-learning.md]]) |
| Memory-hop architectures | Predicts an iterative "hop through memory" substrate for multi-statement reasoning; no neural substrate yet identified |

**Virtual brain analytics** — the transfer of *tools* rather than mechanisms: dimensionality reduction of network states, receptive-field mapping, activity maximization, and lesion analogues applied to artificial networks. AI researchers hold ground-truth access to every component plus arbitrary causal manipulation, a position no experimental neuroscientist has. This is the ancestor of modern mechanistic interpretability.

---

## Limits and failure modes

- **Nothing transferred whole.** The historical pattern is idea-level stimulation and initial leads, never a full-fledged solution re-implemented in silicon. Expect a mechanism to arrive as a constraint on the search, not as a module.
- **Post-hoc narrative risk.** Many "neuroscience-inspired" mechanisms (attention, memory hops) were plausibly reachable by engineering alone; the inspiration claim is often retrofitted. Treat the track-record table as *compatibility* evidence, not *causal* evidence, except where the historical record is explicit (TD, PDP, EWC, replay).
- **Transfer learning is the weak link on both sides.** How humans or animals achieve far transfer of abstract structure is largely unknown neuroscientifically, so this is the one place where the transfer channel currently has nothing to send.
- **A guide, not a requirement.** From an engineering standpoint what works is what matters; biological detail that does not earn its place computationally should be dropped.

---

## Open problems

- Is the implementation level really discardable, or does it carry the one-shot/energy/timing content the algorithmic level cannot express? (Contested — see [[wiki/empirical-tensions.md]].)
- What is the *validation* status of the LGD framing itself: is latent graph discovery something the brain provably does, or a lens? (See the epistemic-status note on [[wiki/concepts/latent-graph-discovery.md]].)
- The transfer record contains no instance of a *factorization* transferring. Is that a fact about the channel, or about what has been looked for?

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — this page supplies the licence for reading brain mechanisms as answers to the latent-graph problem; LGD supplies the target that decides which biological mechanisms are worth importing.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the single most productive transfer in the table (replay, episodic control); the case study that shows a systems-level biological architecture can move into an AI training loop.
- **[[wiki/concepts/meta-learning.md]]** — meta-RL is the clearest *reverse*-direction transfer, where an AI construct became a hypothesis about prefrontal dynamics.
- **[[wiki/concepts/continual-learning.md]]** — EWC is the transfer of a synaptic-stability mechanism into a weight-space regularizer; the mechanism-to-objective conversion pattern.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — tests the boundary of the "implementation level does not matter" claim: if backprop cannot be realized locally, the algorithmic level was never substrate-neutral.
- **[[wiki/concepts/simulation-based-planning.md]]** — the area Hassabis et al. name as the hardest open challenge and where transfer is currently only aspirational.
