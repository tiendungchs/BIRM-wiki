# Neuroscience → AI Transfer

**Importing the brain's *computational-* and *algorithmic-level* solutions (Marr levels 1–2) into machine architectures, treating biological plausibility as a search heuristic rather than a design constraint.**

This is the wiki's methodological premise: the reason a brain-inspired model is worth building at all. Everything else here is downstream of the argument on this page.

---

## Why look at the brain

| Argument | Statement | Force |
|---|---|---|
| **Sparse search space** | The space of possible general-intelligence architectures is vast and very sparsely populated with working solutions (Hassabis et al. 2017) | Random or purely mathematical search is unlikely to land on one; a known solution is a prior over where to look |
| **Existence proof** | The brain is the *only* extant system that demonstrably achieves the target capability | Replaces "is this achievable?" with "how is it achieved?" |
| **Validation channel** | Finding that an already-invented algorithm is implemented biologically is evidence it belongs in a general system | Resource-allocation signal: if a method underperforms but is core to the brain, redoubled engineering is more likely to pay off than abandonment |

The first two motivate *inspiration*; the third is a distinct and often-overlooked payoff — **validation**. They fail differently: inspiration failures waste effort on a mechanism that does not generalize; validation failures mis-prioritize an entire research programme.

## Which level transfers

| Marr level | Content | Transferable? |
|---|---|---|
| **Computational** | What problem the system solves and why | **Yes** — framing transfers (e.g. "the brain infers relational structure", → [[wiki/concepts/latent-graph-discovery.md]]) |
| **Algorithmic** | The representations and processes that realize it | **Yes** — the main working level: factorized codes, replay schedules, gating, attention |
| **Implementation** | Ion channels, spike timing, biophysics | **Declared out of scope** by Hassabis et al. 2017 — explicitly distinguishing this programme from Blue Brain and from neuromorphic reverse-engineering |

The exclusion is a *choice*, not a finding, and it is contested — see [[wiki/empirical-tensions.md]] T1.

---

## Track record: what has actually transferred

| AI mechanism | Biological origin | What transferred |
|---|---|---|
| Artificial neuron; incremental supervised learning; unsupervised efficient coding | 1940s–60s models of neural computation | The unit and the learning rule |
| Convolutional network: nonlinear transduction, divisive normalization, max pooling, layer hierarchy | V1 simple/complex cells; convergent-divergent cortical hierarchy | Architecture + receptive-field structure |
| Distributed (vector) representations of words and sentences | Parallel Distributed Processing models of sentence processing | Representational format |
| Dropout | Poisson-like stochasticity of biological firing | A regularizer derived from noise |
| Temporal-difference learning | Second-order conditioning (value conferred stimulus→stimulus, not only stimulus→reward) | An algorithm, near-wholesale |
| Experience replay (deep Q-network) | Hippocampal replay + [[wiki/concepts/complementary-learning-systems.md]] | A *training schedule*, not an architecture |
| Prioritized replay | Hippocampal replay preferentially reinstates high-reward events | A weighting on that schedule |
| Episodic control | Hippocampal one-shot memory; normative accounts favouring it under low experience | Non-parametric fast control |
| Glimpse / attention models | Primate visual attention shifting resources among locations and objects | Resource allocation + favourable cost scaling with input size ([[wiki/concepts/attention.md]]) |
| External content-addressable memory (Neural Turing Machine, differentiable neural computer) | Working-memory models separating a central executive from domain-specific buffers | **Control/storage separation** ([[wiki/concepts/working-memory.md]]) |
| Elastic weight consolidation | Dendritic-spine enlargement persisting across later learning; cascade models of synaptic state | Per-weight plasticity gating ([[wiki/concepts/continual-learning.md]]) |
| Grid-code-structured concept spaces | Entorhinal grid cells; functional-neuroimaging evidence of grid-like codes during abstract categorization | A *representation* for decomposing state spaces |

**Pattern (brainstorm).** Every entry transferred either a **representation** or a **scheduling/gating policy**. Nothing on this list transferred the thing the wiki needs most: the **meta-graph / instance-graph separation** of [[wiki/concepts/latent-graph-discovery.md]]. The channel has been productive where the brain's answer is a local mechanism, and silent where its answer is an architecture-wide factorization — see gap G1 in [[wiki/architectural-gaps.md]].

---

## The reverse channel: AI → neuroscience

| AI contribution | Neuroscience consequence |
|---|---|
| Temporal-difference prediction error | Midbrain dopaminergic firing matches the TD error signal — the canonical "virtuous circle": animal conditioning → TD → dopamine theory |
| Convolutional-network model comparison | >30 architectures scored against ventral-stream representations; deep supervised nets fit best, and account for the *rise* of category-orthogonal (position, size) coding up the stream |
| Long short-term memory gating | Motivated gating-based maintenance models of prefrontal working memory |
| Meta-reinforcement learning | Slow dopaminergic RL may train a free-standing second RL algorithm in prefrontal recurrent dynamics ([[wiki/concepts/meta-learning.md]]) |
| Memory-hop architectures | Predict an iterative "hop through memory" substrate for reasoning over multiple supporting statements; no neural substrate identified yet |

**Virtual brain analytics** — transfer of *tools* rather than mechanisms: dimensionality reduction of network states, receptive-field mapping, activity maximization, lesion analogues, applied to artificial networks. AI researchers hold ground-truth access to every component plus arbitrary causal manipulation, a position no experimental neuroscientist has (Hassabis et al. 2017). Networks with external memory remain the hardest case to characterize this way.

---

## Limits and failure modes

- **Nothing transferred whole.** The historical pattern is idea-level stimulation and initial leads, never a full-fledged solution re-implemented in silicon. Expect a mechanism to arrive as a constraint on the search, not as a module.
- **Post-hoc narrative risk.** Several "neuroscience-inspired" mechanisms were plausibly reachable by engineering alone; the paper itself notes inspiration is often drawn "without explicit acknowledgment", which cuts both ways. Treat the track-record table as *compatibility* evidence except where the historical record is explicit (TD, PDP, replay, EWC) — see [[wiki/empirical-tensions.md]] T5.
- **Transfer learning is the weak link on both sides.** How humans or animals achieve far transfer of abstract structure is stated as *unknown* and largely unstudied — the one place where the channel currently has nothing to send.
- **A guide, not a requirement.** From an engineering standpoint what works is what matters; biological detail that does not earn its keep computationally should be dropped.
- **The same-strategy assumption is a fallacy on both channels.** Matched performance does not license inferring a matched algorithm: Marr's implementation level may differ *and so may level 2*. Comparative Psychology's name for the error is anthropomorphism, and its correction is Morgan's Canon — restated for machine learning as *never attribute to high-level abilities that which can be adequately explained by shortcut learning* (Geirhos et al. 2020). This bites hardest on the reverse channel: a network that matches ventral-stream representations, or a benchmark score read as "reasoning", may be doing something much lower on the scale. See [[wiki/concepts/shortcut-learning.md]].
- **Biological learners take shortcuts too.** Rats "discriminating colour" by paint odour, students rote-learning for multiple-choice exams, and the blocking effect in conditioning are the same failure mode as texture bias and reward hacking. The brain is therefore not a source of shortcut-*immunity* — only of priors that make some solutions cheaper. What is worth importing is the prior, not the learning rule's supposed robustness.

---

## Open problems

- Is the implementation level really discardable, or does it carry one-shot/energy/timing content the algorithmic level cannot express? (T1.)
- Is latent graph discovery something the brain provably does, or a lens? (See the epistemic-status note on [[wiki/concepts/latent-graph-discovery.md]].)
- The record contains no instance of a *factorization* transferring. Is that a fact about the channel, or about what has been looked for?

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the licence for reading brain mechanisms as answers to the latent-graph problem; LGD supplies the target that decides which biological mechanisms are worth importing.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the single most productive transfer in the table (replay, episodic control): a systems-level biological architecture that moved into an AI training loop.
- **[[wiki/concepts/meta-learning.md]]** — meta-RL is the clearest *reverse*-direction transfer, where an AI construct became a hypothesis about prefrontal dynamics.
- **[[wiki/concepts/continual-learning.md]]** — elastic weight consolidation is a synaptic-stability finding converted into a loss term: the mechanism-to-objective conversion pattern.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — tests the boundary of the "implementation level does not matter" claim: if backpropagation cannot be realized locally, the algorithmic level was never substrate-neutral.
- **[[wiki/concepts/simulation-based-planning.md]]** — named as the hardest open challenge and the area where transfer is still aspirational: the biology is suggestive, the control mechanism unknown on both sides.
- **[[wiki/concepts/working-memory.md]]** — control/storage separation is the transfer that produced graph-traversal-capable networks, i.e. the one entry that touches reasoning directly.
- **[[wiki/concepts/attention.md]]** — the modularity argument (brains are not one uniform optimizer) entered AI mostly unspoken, via attention; the case study for unacknowledged transfer.
- **[[wiki/concepts/abstract-structural-codes.md]]** — grid-like coding of conceptual spaces is the newest item in the track record, and the only one whose biological evidence is still a single report.
- **[[wiki/concepts/shortcut-learning.md]]** — supplies Morgan's Canon as the discipline this channel needs in reverse: matched behaviour licenses no inference about the algorithm, and biological learners take shortcuts too, so the brain offers better priors rather than immunity.
