# Meta-Learning (Learning to Learn)

**A slow outer optimization over a *distribution of tasks* shapes a fast inner learner, so that adaptation to a newly drawn task costs few samples.**

```
θ* = argmin_θ  E_{T ~ p(T)} [ L_T( A(θ, D_T^train) ) ]
```

`A` is the inner adaptation procedure and `θ` the slow parameters. The inner loop may be gradient descent, or — the case that matters most here — the *recurrent dynamics of a network whose weights are frozen*.

---

## Why it is load-bearing

Meta-learning is the optimization statement of the same two-level structure [[wiki/concepts/latent-graph-discovery.md]] reaches from sample complexity:

| Meta-learning | Latent-graph framing | CLS framing |
|---|---|---|
| Outer loop over `p(T)` | Meta-graph: structure shared across the environment family | Neocortex, slow |
| Inner loop within one `T` | Instance-graph: this task's topology, bound in-episode | Hippocampus, fast |
| Slow parameters `θ` | Slow **W** | Cortical weights |
| Inner-loop state | Fast **M** | Hippocampal trace |

A flat learner optimizes average performance *before* adaptation and therefore fits the mixture `E_θ[p(obs|θ)]`, which no individual instance follows. Meta-learning optimizes performance *after* adaptation — the objective that makes the two-level split explicit rather than emergent.

---

## Meta-RL: the inner learner as activity, not weights

Use reinforcement learning to optimize the weights of a recurrent network across many related tasks. The trained network's *activity dynamics* then implement a second, free-standing RL algorithm that learns within an episode, faster than the outer algorithm, with the weights held fixed. Two learners, one network, two substrates (weights vs. state).

**Biological reading** (Hassabis et al. 2017): a relatively slow dopaminergic RL algorithm trains prefrontal recurrent dynamics until those dynamics constitute a faster RL algorithm in their own right — a role for prefrontal cortex in RL alongside the established dopamine-based mechanism. This is the wiki's clearest *reverse* transfer: an AI construct that became a hypothesis about the brain ([[wiki/concepts/neuroscience-ai-transfer.md]]).

**Architectural consequence:** the fast level need not be a separate memory module. Fast **M** can be *state in a recurrent system*, provided the slow level has shaped the dynamics to make that state a useful learner. That is a genuinely different answer from CLS's "build a second system", and both are live ([[wiki/empirical-tensions.md]] T2).

---

## Instantiations

| Instance | Inner loop | Result |
|---|---|---|
| **Learning sets** (animal learning) | Behavioural strategy shift across a series of problems | The original demonstration: animals learn *how to solve the problem class*, not the problem. Later restudied in developmental psychology |
| **One-shot concept learning** (structured probabilistic models; deep generative models) | Similarity to a support set / amortized inference | The "characters challenge": recognize and generate novel instances of an unfamiliar handwritten character from a single exemplar — easy for humans, hard for classical AI |
| **Meta-RL** (recurrent policy over a task distribution) | Recurrent activity | Within-episode learning faster than the outer algorithm |
| **Progressive networks** | Lateral connections into frozen prior columns | Far transfer between video games; simulation-to-real transfer for a robot arm with a large cut in real-world training time. Resembles a computational model of sequential task learning in humans |

Progressive networks are a boundary case: transfer without a meta-objective, by *keeping* prior solutions and adding capacity — non-forgetting bought with unbounded growth ([[wiki/concepts/continual-learning.md]]).

---

## The knowledge-boundedness limit

The inner learner adapts only within the envelope the outer loop sampled. `p(T)` is a hard boundary: a family the outer loop never saw is not "few-shot hard", it is out of scope. Any claim that a meta-learned system generalizes structurally has to specify the task distribution it was trained over.

**(brainstorm)** This makes the wiki's target *not* "better meta-learning" but a **third level**: the outer loop's task distribution should itself be discoverable rather than given. That is the same recursion as the rewrite-graph in hardness source 6, and the same problem as gap G9 — two levels suffice while the family is fixed.

---

## Open problems

- **Where does `p(T)` come from?** Every result above assumes a hand-built task distribution; self-generated curricula are the unaddressed half.
- **Does the inner loop learn structure or select among encoded rules?** Recurrent inner learners are not shown to acquire *new* transition rules.
- **Weights vs. activity for the fast level** — CLS and meta-RL disagree, and they may be complementary (episodic fast-M for bindings, recurrent fast-M for policies).
- **Meta-learning the plasticity rule** rather than the initialization is a distinct, less-explored branch.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — meta-learning is the optimization statement of LGD's two-level hierarchy: the outer loop learns the meta-graph, the inner loop binds the instance-graph.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the same two-timescale factorization realized across two anatomical systems rather than in weights-vs-activity within one network.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — meta-RL is the wiki's clearest AI→neuroscience transfer, supplying a hypothesis about prefrontal recurrent dynamics.
- **[[wiki/concepts/continual-learning.md]]** — meta-learning optimizes forward transfer to *new* tasks; continual learning protects retention of *old* ones; progressive networks sit in both.
- **[[wiki/concepts/working-memory.md]]** — recurrent activity is the substrate meta-RL uses for its inner loop, so the capacity and gating limits of activity-based memory bound what the inner learner can hold.
- **[[wiki/concepts/abstract-structural-codes.md]]** — a content-invariant structural code is what would let the outer loop's learned regularity be reused in a domain populated by entirely new objects.
- **[[wiki/concepts/simulation-based-planning.md]]** — reusing a plan across structurally similar environments is meta-learning's objective restated in planning terms: the outer loop supplies the schema the rollout instantiates.
