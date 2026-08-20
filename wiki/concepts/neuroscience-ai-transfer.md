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
| **Implementation** | Ion channels, spike timing, biophysics | **Declared out of scope** by Hassabis et al. 2017 — explicitly distinguishing this programme from Blue Brain and from neuromorphic reverse-engineering. Schmidgall et al. 2023 take the opposite position by construction: spike timing is claimed to carry *more* information than a rate code, and energy cost is treated as a first-order design constraint rather than an implementation detail |

The exclusion is a *choice*, not a finding, and it is contested — see [[wiki/empirical-tensions.md]] T1.

**What a transferred item is a component *of*.** Richards et al. 2019 sharpen the target of the whole channel: the deliverable is not a compact model of any neuron's response but a **compact normative explanation of how those responses emerge**, stated as three objects — objective function, learning rule, architecture — from which a non-compact trained model then follows (the relation natural selection has to phylogeny). Two consequences for the table above. First, every row can be sorted into one of the three slots, and the sort exposes the channel's blind spot: almost nothing has transferred into the **objective** slot, which is also the only one of the three that is *not directly observable* in brains. Second, the compactness is not an aesthetic preference — the three components must pass to offspring through the genome, which plausibly cannot specify vertebrate wiring, so they are under a hard information bound that the learned computation is not. See [[wiki/concepts/three-component-framework.md]].

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
| External content-addressable memory (Neural Turing Machine, differentiable neural computer — [[wiki/entities/differentiable-neural-computer.md]]) | Working-memory models separating a central executive from domain-specific buffers | **Control/storage separation** ([[wiki/concepts/working-memory.md]]) |
| Elastic weight consolidation | Dendritic-spine enlargement persisting across later learning; cascade models of synaptic state | Per-weight plasticity gating ([[wiki/concepts/continual-learning.md]]) |
| Grid-code-structured concept spaces | Entorhinal grid cells; functional-neuroimaging evidence of grid-like codes during abstract categorization | A *representation* for decomposing state spaces |
| Hebbian learning; Hopfield associative storage | Hebb 1949 (with a lineage back to William James); "cells that fire together, wire together" | A **learning rule**, near-wholesale ([[wiki/concepts/synaptic-plasticity.md]]) |
| Three-factor / reward-modulated plasticity; node perturbation → REINFORCE | Neuromodulatory broadcast (dopamine) gating Hebbian change | A learning rule *and* the policy-gradient estimator it turns out to be |
| Feedback alignment, e-prop, cell-type-specific neuromodulated credit assignment | Absence of weight transport in cortex; eligibility traces; genetic findings on neuronal signalling architectures | Constraints that generated new algorithms ([[wiki/concepts/biologically-plausible-credit-assignment.md]]) |
| Differentiable plasticity; neuromodulated differentiable plasticity | Synaptic plasticity and dopaminergic modulation, made differentiable | A **meta-objective** over a biological mechanism ([[wiki/concepts/meta-optimized-plasticity.md]]) |
| Spiking neural networks; neuromorphic hardware (Loihi, TrueNorth, SpiNNaker) | Membrane-potential integration and threshold spiking | The **implementation level itself** — the entry the exclusion above forbids ([[wiki/entities/spiking-neural-networks.md]]) |
| Deep reinforcement learning | Reward-driven learning emulating dopamine-neuron activity | An objective, and a full research programme (dexterous manipulation, locomotion, multi-agent coordination) |

**Pattern (brainstorm).** Every entry transferred either a **representation**, a **scheduling/gating policy**, or — after the Schmidgall et al. 2023 additions — a **local update rule**. Nothing on this list transferred the thing the wiki needs most: the **meta-graph / instance-graph separation** of [[wiki/concepts/latent-graph-discovery.md]]. The channel has been productive where the brain's answer is a local mechanism, and silent where its answer is an architecture-wide factorization — see gap G1 in [[wiki/architectural-gaps.md]].

**The update-rule column has a systematically worse record than the other two.** Representations and gating policies transferred and stayed; imported learning rules mostly underperform the engineered alternative they were meant to replace (feedback alignment fails at ImageNet scale; backpropagation-derived local rules generalize measurably worse; evolutionary rule discovery needs far more data than gradient methods). Read against this page's *validation* argument, that is the awkward case: the mechanism is unambiguously core to the brain and still underperforms, so the argument says redouble rather than abandon — which is unfalsifiable unless the criterion is stated in advance.

**The neuroconnectionist research programme** is the current name for the joint enterprise: use ANNs as a *computational language* in which to state and test theories of brain computation. Its evidential base is that task-tailored deep networks show striking similarity to the brain in handling spatial and visual information. Its exposure is Morgan's Canon below — representational similarity is a weak constraint on the algorithm.

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
- **The channel can be run in reverse: cognition constrains biology.** Lake et al. 2017 argue the clearest path to formalizing intelligence goes through the "software" before the "hardware", on the grounds that what we *know* about the brain is not clear-cut — many widely accepted ideas about neural computation are biologically dubious or uncertain, claims of (im)plausibility rest on stylized assumptions wrong in their details, and they are usually made at the cellular/synaptic level with few links to systems-level or subcortical organization. Two consequences they draw: **(a)** backpropagation's biological implausibility rightly failed to hold back the research programme, because the data constrain it in neither direction; **(b)** "a hypothetical biological mechanism should be viewed with skepticism if it is *cognitively* implausible" — the LTP/Hebb case being their example ([[wiki/concepts/synaptic-plasticity.md]], [[wiki/empirical-tensions.md]] T13). This is the sharpest statement in the wiki of the position that the transfer channel is not privileged in the biology→AI direction.
- **Physiological plausibility is not sufficient — behavioural realism is a second criterion.** A mechanism can satisfy every anatomical objection and still fail to learn anything hard: target propagation removes weight transport, gradient transport and derivative transport, and lands at chance on ImageNet, while feedback alignment stays 22 top-1 points behind backpropagation on the same net (Bartunov et al. 2018, [[wiki/concepts/biologically-plausible-credit-assignment.md]]). Since humans learn tasks unrelated to their evolution, a rule that cannot reach hard-task competence has not earned transfer — but the inference is contested, because the stripped-down model may be failing for the phenomena it omits rather than for the rule ([[wiki/empirical-tensions.md]] T78).
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
- **[[wiki/entities/spiking-neural-networks.md]]** — the test case for the implementation-level exclusion: if spike timing is informative, a purely functional specification of a reasoning architecture is incomplete.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the largest single block of *learning-rule* transfers (Hebb, STDP, three-factor, eligibility traces), and the block with the weakest performance record relative to engineered alternatives.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — the channel used in a third mode: rather than importing a mechanism or exporting an algorithm, take a biological mechanism and hand its free parameters to an optimizer.
- **[[wiki/concepts/shortcut-learning.md]]** — supplies Morgan's Canon as the discipline this channel needs in reverse: matched behaviour licenses no inference about the algorithm, and biological learners take shortcuts too, so the brain offers better priors rather than immunity.
- **[[wiki/concepts/causal-model-building.md]]** — the rival source of constraint: cognitive science rather than neuroscience, with the "software before hardware" argument and the claim that a biologically motivated mechanism which is cognitively implausible should be doubted rather than imported.
- **[[wiki/concepts/core-knowledge.md]]** — a candidate transfer of a *prior* rather than a mechanism or a gating policy, and the only case in the wiki with direct evidence that the prior is installable (object cognition in visually inexperienced newborn chicks).
- **[[wiki/concepts/three-component-framework.md]]** — states what this channel is ultimately importing: not compact models of neurons but the three compact objects whose interaction makes neural responses emerge, with the genome bottleneck as the argument for why they must be compact.
- **[[wiki/concepts/objective-identifiability.md]]** — the audit this whole channel needs: a matched tuning curve identifies neither the brain's loss (many losses share minima) nor its solution (one loss has many minima), and high linear "neural predictivity" may track a model's representational dimensionality rather than any detailed similarity — so the reverse channel's validation entries are provisional.
- **[[wiki/concepts/pattern-separation-completion.md]]** — a candidate import of the *scheduling/gating* type: a mode signal (cholinergic, or a closed loop from completion error) switching a store between writing separately and reading associatively — the pattern this page says has transferred well.
- **[[wiki/entities/tem-transformer.md]]** — a transfer case with no transfer in it: transformers were built with no reference to the brain and turn out to be algebraically the hippocampal model, so the evidence is about convergence on one computation rather than about import, and the payoff runs backwards (a neuroscience model gains the machine architecture's speed and scale).
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — a candidate import of the gating/scheduling type rather than the representation type: a differentiated inhibitory control layer with one output per coding feature, plus a wiring rule (fan-in width) for assigning outputs to features, against the single global normalizer that is the standard machine analogue of inhibition.
- **[[wiki/concepts/dendritic-computation.md]]** — the strongest available test case for whether the implementation level carries computational content (T1): what transfers is a nonlinearity plus a sparse connectivity pattern, not biophysics, and it arrives with a numerical prediction of a biological constant that was subsequently confirmed rather than a post-hoc resemblance.
- **[[wiki/entities/dendritic-ann.md]]** — the minimal-import test case: the only thing carried across is a connectivity mask (no biophysics, no nonlinearity, no learning rule), so it measures how much of the dendritic advantage is architectural — 1–3 orders of magnitude in parameters, plus a flip from class-specific to mixed-selective coding (Chavlis & Poirazi 2025).
- **[[wiki/entities/hodgkin-huxley-model.md]]** — the limit case for this page's argument in both directions: a fitted dynamical exponent (`n⁴`) predicted a molecular stoichiometry decades before it was measured, which is the strongest evidence form transfer can get — while the model itself is maximally accurate about the substrate and silent at Marr levels 1–2, so accuracy about the brain and usefulness for building a reasoner come apart cleanly here.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — a test case for importing *connectivity* rather than a representation or a rule: a typed-edge graph with measured scale ratios, transferable with no biophysics attached — and a caution about how far anatomy alone gets you, since the functional interpretation of that graph is labelled a tentative hypothesis by its own authors and remains untested (Douglas & Martin 2004).
- **[[wiki/entities/differentiable-neural-computer.md]]** — the flagship product of the central-executive/buffer transfer, and the case where the borrowing ran computation-first: the three addressing modes were chosen for engineering reasons and the biological parallels (CA3 one-shot write, dentate sparsity, free-recall contiguity) were noticed afterwards and never tested.
- **[[wiki/concepts/dynamic-network-connectivity.md]]** — an implementation-level candidate (T1) that survives the filter: strip the channel identities and what transfers is a content-free multiplicative gain register on existing connections whose set-point is a global state scalar, which is an architectural commitment rather than biophysics (Arnsten et al. 2010).
