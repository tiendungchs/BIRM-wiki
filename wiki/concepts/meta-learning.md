# Meta-Learning (Learning to Learn)

**A slow outer optimization over a *distribution of tasks* shapes a fast inner learner, so that adaptation to a newly drawn task costs few samples.**

```
θ* = argmin_θ  E_{T ~ p(T)} [ L_T( A(θ, D_T^train) ) ]
```

where `A` is the inner adaptation procedure and `θ` the slow parameters. The inner loop may be gradient descent, or — the case that matters most here — the *recurrent dynamics of a network whose weights are frozen*.

---

## Why it is load-bearing for this wiki

Meta-learning is the machine-learning name for the same two-level structure [[wiki/concepts/latent-graph-discovery.md]] arrives at from sample complexity:

| Meta-learning | Latent-graph framing | CLS framing |
|---|---|---|
| Outer loop over `p(T)` | Meta-graph: structure shared across the environment family | Neocortex, slow |
| Inner loop within one `T` | Instance-graph: this task's topology, bound in-episode | Hippocampus, fast |
| Slow parameters `θ` | Slow **W** | Cortical weights |
| Inner-loop state | Fast **M** | Hippocampal trace |

A domain is a *family* of environments with shared laws and per-instance bindings. A flat learner fits the mixture `E_θ[p(obs|θ)]` — a distribution no individual instance follows. Meta-learning is the explicit statement of that objective: optimize for performance *after* adaptation, not before.

---

## Meta-RL: the inner learner as activity, not weights

The strongest form: use RL to optimize the weights of a recurrent network across many related tasks. The trained network's *activity dynamics* implement a second, freestanding RL algorithm that learns within an episode with the outer algorithm's weights held fixed. Two learners, one network, two substrates (weights vs. state).

**Biological reading** (Hassabis et al. 2017; and a growing prefrontal-RL literature): a relatively slow dopaminergic RL algorithm trains prefrontal recurrent dynamics until those dynamics constitute a faster RL algorithm in their own right. This is the wiki's clearest *reverse* transfer — an AI construct that became a hypothesis about the brain rather than the other way round ([[wiki/concepts/neuroscience-ai-transfer.md]]).

**Why this matters architecturally:** it shows the fast level need not be a separate memory module. Fast **M** can be *state in a recurrent system*, provided the slow level has shaped the dynamics to make that state a useful learner. That is a genuinely different answer from CLS's "build a second anatomical system", and both are live.

---

## Instantiations

| Instance | Inner loop | Evidence / result |
|---|---|---|
| **Learning sets** (Harlow, animal learning) | Behavioural strategy shift across problem series | The original demonstration: animals learn *how to solve the problem class*, not the problem |
| **One-shot concept learning** (matching networks, and structured probabilistic models on the "characters challenge") | Similarity to embedded support set | Classify a novel handwritten character from a single exemplar — hard for classical AI, easy for humans |
| **Meta-RL** (recurrent policy over task distribution) | Recurrent activity | Faster within-episode learning than the outer algorithm |
| **Deep generative one-shot models** (DRAW-derived) | Amortized inference | Generate new samples of a concept from one example |
| **Progressive networks** | Lateral connections to frozen prior columns | Far transfer between video games; sim-to-real robot arm transfer with large reduction in real-world training |

Progressive networks are an interesting boundary case: transfer without a meta-objective, by *keeping* prior solutions and adding capacity. It buys non-forgetting at the price of unbounded growth — see [[wiki/concepts/continual-learning.md]].

---

## The knowledge-boundedness limit

The inner learner can only adapt within the envelope the outer loop sampled. `p(T)` is a hard boundary: a task family the outer loop never saw is not "few-shot hard", it is out of scope. This is the precise mechanism behind the failure logged against LLMs and LRMs on [[wiki/concepts/latent-graph-discovery.md]] — in-context learning is a meta-learned inner loop, so it generalizes exactly as far as pretraining's task distribution reached and no further. ARC-AGI-3-style tasks are constructed to sit outside it.

**(brainstorm)** This suggests the wiki's target is not "better meta-learning" but a *third* level: the outer loop's task distribution must itself be discoverable rather than given. That is the same recursion as the rewrite-graph in hardness source 6 — meta-graph over meta-graphs. Two levels suffice when the family is fixed; the open question is whether the family can be learned.

---

## Open problems

- **Where does `p(T)` come from?** Every result above assumes a hand-built task distribution. Self-generated task distributions (curricula, open-endedness) are the unaddressed half.
- **Does the inner loop learn structure or interpolate?** Recurrent inner learners are not known to acquire *new* transition rules, only to select among rules the outer loop encoded.
- **Weights vs. activity for the fast level.** CLS says separate system; meta-RL says recurrent state; the wiki has no evidence deciding between them, and they may be complementary (episodic fast-M for bindings, recurrent fast-M for policies).
- **Meta-learning the plasticity rule itself** (rather than the initialization) is a distinct and less-explored branch.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — meta-learning is the optimization statement of LGD's two-level hierarchy: outer loop learns the meta-graph, inner loop binds the instance-graph.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the same two-timescale factorization realized in two anatomical systems rather than in weights-vs-activity within one network.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — meta-RL is the wiki's clearest AI→neuroscience transfer, supplying a hypothesis about prefrontal recurrent dynamics.
- **[[wiki/concepts/continual-learning.md]]** — meta-learning optimizes forward transfer to *new* tasks; continual learning protects backward retention of *old* ones; progressive networks sit in both.
