# Overview — Brain-Inspired Models for Abstract Reasoning

Master synthesis. Rewritten after every ~10 ingests, or whenever a major insight changes the picture.

> **State of the wiki:** 2 sources ingested (Hassabis et al. 2017, *Neuroscience-Inspired Artificial Intelligence*; Geirhos et al. 2020, *Shortcut Learning in Deep Neural Networks*). Sections below stay placeholders until enough sources are in to defend a thesis; the concept skeleton is listed in [[wiki/index-concepts.md]].

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

---

## Key Open Problems

*Empty — promoted here from concept-page open-problem sections and from [[wiki/architectural-gaps.md]].*

---

## Promising Directions

*Empty — filled by ingests.*

---

## Major Controversies

*Empty — the load-bearing ones are promoted here from [[wiki/empirical-tensions.md]].*
