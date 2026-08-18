# Overview — Brain-Inspired Models for Abstract Reasoning

Master synthesis. Rewritten after every ~10 ingests, or whenever a major insight changes the picture.

> **State of the wiki:** 3 sources ingested (Hassabis et al. 2017, *Neuroscience-Inspired Artificial Intelligence*; Geirhos et al. 2020, *Shortcut Learning in Deep Neural Networks*; Schmidgall et al. 2023, *Brain-Inspired Learning in Artificial Neural Networks: a Review*). Sections below stay placeholders until enough sources are in to defend a thesis; the concept skeleton is listed in [[wiki/index-concepts.md]].

---

## The Central Thesis

*Empty — written once enough sources are in to state a thesis and defend it.*

---

## Master Problem Framing: Latent Graph Discovery

**Infer the structure of a relational graph from observations, then navigate it — where the graph is never given and must be recovered from partial, aliased, or sequential evidence.** Full statement, taxonomy, and the six sources of hardness: [[wiki/concepts/latent-graph-discovery.md]].

---

## Current Best Understanding

*Too early for a synthesis. What the first ingest establishes:*

- The brain is used as a **prior over architectures**, not as a specification: computational and algorithmic level transfer, implementation level is declared out of scope (contested — [[wiki/empirical-tensions.md]] T1).
- The **two-timescale split** (fast instance store / slow structural learner) arrives independently from biology (complementary learning systems) and from optimization (meta-learning), and both are instantiated in working machines. The **factorized code** `p = f(g, x)` that the framing also demands is not instantiated anywhere yet — gap G1.
- Every mechanism that has historically transferred was a *representation* or a *gating/scheduling policy*. No factorization has ever transferred ([[wiki/concepts/neuroscience-ai-transfer.md]]).

*What the second ingest establishes:*

- **The intended solution is not a function of the data.** Shortcut and structural rules are equally consistent with any single environment, so the `g`/`x` factorization the framing demands cannot be discovered — it must be bought with inductive bias, on one of exactly four levers: architecture, training data, loss, optimizer (gap G16, [[wiki/concepts/shortcut-learning.md]]).
- **The environment family is doing double duty.** It was introduced as a sample-complexity decomposition; it is also the *identifiability* condition that makes an invariant edge distinguishable from a correlational one. This is the first claim in the wiki that two independent arguments converge on the same structure.
- **Measurement is a prerequisite, not a detail.** i.i.d. benchmarks cannot separate a discovered graph from a correlation, so no architecture the wiki will ingest can be scored against the six hardness sources without an out-of-distribution test with a well-defined intended solution (gap G17).
- **Biology is not a source of immunity.** Rats, students and conditioned animals take shortcuts too. What the brain supplies is a better *prior*, which is exactly the architecture lever — and Morgan's Canon is the discipline that keeps matched behaviour from being read as matched algorithm.

*What the third ingest establishes:*

- **The update rule is now a first-class design object.** [[wiki/concepts/synaptic-plasticity.md]] (Hebb → STDP → three-factor → node perturbation → eligibility traces) is the only family that writes weights *during deployment*, which is what binding an instance-graph in-episode literally requires. [[wiki/concepts/meta-optimized-plasticity.md]] then makes the rule itself the object of an outer search — the first mechanism in the wiki where slow **W** is a *searched* object rather than a parameter blob, and the first named candidate for the third tier (gap G9, now `PARTIAL`).
- **Locality has a measured price.** Backpropagation-derived local rules generalize worse and more variably than backpropagation through time, and the deficit does not close by scaling the step size ([[wiki/empirical-tensions.md]] T7). Feedback alignment fails at ImageNet scale; only sign-symmetry matches backpropagation there, and it is the variant that still transports sign information. "Biologically plausible" and "approximates backpropagation" pull against each other.
- **The shortcut problem recurs one level down.** Every local rule is a coactivity detector, so it writes on shortcut-driven coactivity exactly as readily as on structural coactivity. Fixing gap G6 in the slow learner does not fix it in the fast store (new gap G19).
- **The weights-vs-activity question may be a change of basis.** Parameter-sharing in a meta-learner makes activations interpretable as weights, and self-attention's products can be cast as learned weight updates that implement gradient descent — so tension T2 may be about degrees of freedom and decay timescale rather than about architecture.
- **The implementation-level exclusion is now actively contested.** [[wiki/entities/spiking-neural-networks.md]] — the wiki's first entity page — argues spike timing carries more information than a rate code and that energy is a first-order constraint (T1). Its most interesting property for this wiki is unclaimed in the literature: the STDP sign flip is a substrate-level *directed*-edge detector.

---

## Key Open Problems

*Empty — promoted here from concept-page open-problem sections and from [[wiki/architectural-gaps.md]].*

---

## Promising Directions

*Empty — filled by ingests.*

---

## Major Controversies

*Empty — the load-bearing ones are promoted here from [[wiki/empirical-tensions.md]].*
