# Overview — Brain-Inspired Models for Abstract Reasoning

Master synthesis. Rewritten every ~10 ingests or whenever a major insight changes the picture.

> **State of the wiki:** ingest is at **wave 0 of 16** (foundations), 1 of 303 sources folded in. The framing below is inherited from [[wiki/concepts/latent-graph-discovery.md]], which was written before the corpus was ingested; the waves ahead are the test of it, not its confirmation. Read every "current best understanding" claim as provisional at this depth.

---

## The Central Thesis

Building a machine capable of abstract reasoning is a search problem in a vast and sparsely populated space of architectures. The brain is the only known point in that space that works, so its **computational and algorithmic** organization is the best available prior over where to look — not because biological fidelity is a virtue, but because it is the cheapest source of non-arbitrary constraints. Biological plausibility is a guide, not a requirement; what does not earn its place computationally is dropped. See [[wiki/concepts/neuroscience-ai-transfer.md]].

The transfer is bidirectional and that matters: temporal-difference learning went from animal conditioning to AI and came back as the dopamine prediction-error theory. A mechanism that survives the round trip has been validated twice.

---

## Master Problem Framing: Latent Graph Discovery

**Infer the structure of a relational graph from observations, then navigate it — where the graph is never given and must be recovered from partial, aliased, or sequential evidence.** Full statement, taxonomy, and the six sources of hardness: [[wiki/concepts/latent-graph-discovery.md]].

Two commitments follow, and they organize the whole wiki:

1. **Two levels, not one.** A domain is a *family* of environments — shared laws instantiated per task. A flat learner fits the mixture, a distribution no individual instance follows. So parameters must split by sample budget: a slow, pooled **meta-graph** learner (weights, **W**) and a fast, low-dimensional **instance-graph** binder (memory, **M**).
2. **Discovery and use are different problems.** Recovering the graph and searching it are separable in easy tasks and simultaneous in hard ones. [[wiki/concepts/simulation-based-planning.md]] is the use half; it currently sits on an unfilled dependency, because nothing supplies the model it plans over.

**The framing is a lens, not a proven reduction.** It is biologically warranted on the metric/embeddable slice of structure and untested on the genuinely symbolic slice. Program induction, the probabilistic language of thought, and free-energy attractor dynamics are live rivals that explain the same data. This is tension T2 in [[wiki/empirical-tensions.md]] and the single most consequential open question here.

---

## Current Best Understanding

**The two-timescale split is over-determined.** Three independent arguments converge on it: sample complexity (k≈3 demonstrations cannot identify a high-dimensional instance function), minimum description length (mechanism-plus-parameters is a strictly shorter code than N instances), and catastrophic interference ([[wiki/concepts/complementary-learning-systems.md]] was *derived* from the interference problem before it was an anatomical claim). Convergence from unrelated directions is the strongest structural evidence the wiki has.

**The split has at least two realizations, and they are not rivals.** Complementary learning systems put the fast level in a separate anatomical store; meta-RL puts it in the recurrent *activity* of a network whose weights are frozen ([[wiki/concepts/meta-learning.md]]). Episodic bindings plausibly want the first, policies the second.

**Neuroscience→AI transfer has a shape.** Everything that has transferred was a representation (convolution, distributed codes, grid codes) or a scheduling/gating policy (replay, dropout, elastic weight consolidation, attention). Nothing that transferred was a *factorization*. Since factorization is exactly what the wiki needs, either the channel is biased or nobody has looked — gap G1 in [[wiki/architectural-gaps.md]].

**Local credit assignment is probably not a blocker.** Feedback alignment, predictive-coding networks and energy-based models all approximate backpropagation with local updates, with concrete links to spike-timing-dependent plasticity ([[wiki/concepts/biologically-plausible-credit-assignment.md]]). The classical implausibility objection has weakened enough that substrate choice can be deferred.

**Current models fail structurally, not numerically.** LLM failures on perturbed mathematics preserve 97–99% arithmetic accuracy while collapsing on topology edits; models score ~15–20% on composing rule rewrites even when every rewrite is visible. The deficit is in maintaining and manipulating graph structure, not in executing operations.

---

## Key Open Problems

| | Problem | Where |
|---|---|---|
| 1 | Does the navigation framing survive contact with non-embeddable symbolic structure? | T2, [[wiki/empirical-tensions.md]] |
| 2 | Where does the task family `p(T)` come from, if the agent must discover it? | G3, [[wiki/architectural-gaps.md]] |
| 3 | How is instance experience consolidated into shared structure *during deployment*? | G2 |
| 4 | How is a rich internal model learned without hand-crafted priors? | G4 |
| 5 | What controls simulation — when to plan, how deep, when to stop? | G5 |
| 6 | How is an edge set that the agent itself edits planned over? | G6, hardness source 6 |
| 7 | How do humans transfer abstract structure across domains? Unknown on *both* sides | G10 |

---

## Promising Directions

- **Factorized codes as the unifying answer.** Compositional recombination, jumpy hierarchical planning, and plan-schema transfer are three separate demands from the planning literature that all reduce to "separate `g` from `x`" — the same factorization the hippocampal-coding literature arrives at independently. Planning may need little machinery of its own beyond a good graph and a search over it.
- **Structure-prioritized replay.** Replay is currently prioritized by reward magnitude. A criterion of *uncertainty reduction over the meta-graph* is unexplored and is the natural bridge across gap G2.
- **Factorization as the continual-learning method.** Rather than an importance penalty over a flat network, protect meta-graph parameters and leave instance-graph parameters fully plastic. The W/M split may already be the answer to catastrophic forgetting ([[wiki/concepts/continual-learning.md]]).
- **Reification of rules as ordinary nodes.** If a rule is a first-class object with its own factorized code, "rule change" becomes an ordinary edge and non-stationary topology reduces to stationary discovery over a lifted graph.
- **Virtual brain analytics.** Applying neuroscience's measurement toolkit to networks, with the advantage of ground-truth access and arbitrary causal manipulation — the ancestor of mechanistic interpretability, and the wiki's route to checking whether a model actually built the graph it appears to have built.

---

## Major Controversies

| | Controversy | Status |
|---|---|---|
| **Does the implementation level matter?** | Systems-neuroscience says no (algorithmic level is substrate-neutral); neuromorphic/spiking says timing, energy and one-shot plasticity *are* the computation | T1 — unresolved, wave 11 supplies the other side |
| **Is the reduction to navigation legitimate?** | Program induction, probabilistic language of thought and free-energy dynamics are mutually foldable rivals; folding them into navigation is a choice | T2 — unresolved |
| **Is "neuroscience-inspired" causal or retrofitted?** | Explicit for TD, PDP, replay, EWC; plausibly retrofitted for attention and memory hops | T5 — affects how much a biological argument should move a design decision |
| **Does chain-of-thought fix reasoning or only select among memorized paths?** | Ground-truth CoT helps, self-generated CoT hurts; the residual shortcut reliance suggests it cannot repair a wrong edge vocabulary | T4 — leaning: CoT selects paths, it does not build reliable nodes |
