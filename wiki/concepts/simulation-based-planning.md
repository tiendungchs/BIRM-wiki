# Simulation-Based Planning

**Select actions by rolling an internal model of the environment forward and evaluating imagined outcomes, instead of reading them off a cached policy.**

In the wiki's framing this is **path search over the latent graph**: the internal model *is* an estimate of the graph, and planning is finding a route through it. See [[wiki/concepts/latent-graph-discovery.md]].

---

## Model-free vs model-based

| | Model-free (e.g. deep Q-network) | Model-based / simulation |
|---|---|---|
| What is learned | State/action → value or policy | Transition and reward structure |
| Compute at decision time | Cheap — one forward pass | Expensive — rollouts |
| Data efficiency | Poor; many samples per accurate estimate | Higher; one model update revalues many states |
| Response to a changed outcome value | **Insensitive** — the policy must be relearned | Immediate — revalue on the same model |
| Failure mode | Reactive, inflexible | Model error compounds along the rollout |

The flexibility asymmetry is why this matters for abstract reasoning: a reasoning agent is defined by its ability to answer counterfactual and novel-goal queries, and only the model-based side can do that without retraining.

---

## Evidence that biology plans this way

| Observation | Content |
|---|---|
| **Hippocampal preplay at choice points** | When a rat pauses at a decision point, ripples of hippocampal activity resemble those seen during subsequent traversal of each available trajectory — as if simulating each alternative before committing |
| **Non-spatial human planning** | Similar sequential reinstatement reported during abstract, non-spatial planning |
| **Scrub jay caching** | Food caching takes into account the future conditions of recovery — not explicable by cached value |
| **Rat cognitive maps** | Support inductive inference during wayfinding and one-shot learning in mazes |
| **Division of labour** | Hippocampus instantiates the internal model; goal-contingent *valuation* of simulated outcomes occurs downstream in orbitofrontal cortex and striatum |
| **Shared substrate** | Imagination, envisioning the future and simulation-based planning depend on a common hippocampal substrate — the machinery that supports recall also generates the simulations |

What *initiates and steers* the rolling-forward is unresolved; the leading proposal is prefrontal control acting on the hippocampus — which has a direct AI parallel: a controller that queries an environment model with task-relevant goals and receives predicted states back ([[wiki/concepts/working-memory.md]]).

---

## Machine instantiations

| System | Role |
|---|---|
| **Dyna** | The origin: interleave real experience with simulated experience from a learned model; explicitly motivated by "mental model" theories of human learning |
| **Monte Carlo tree search** | Forward search used to update a value function and/or policy; the search half of expert Go play |
| **Deep generative environment models** | Generate temporally consistent sample sequences reflecting the geometric layout of newly experienced realistic environments — the analogue of hippocampal binding of components into a coherent imagined experience |
| **Controller/model separation** | An explicit split between a policy controller and an environment model, queried bidirectionally; used for planning over interacting physical objects |

**The gap.** Generative models produce rich coherent rollouts; using them *for control* is unsolved. The stated requirement is that rich internal models — approximate but accurate enough to plan on — be **learned from experience without strong priors hand-crafted by the experimenter**. That requirement is identical to the LGD problem statement.

---

## Three properties of human planning that machines lack

| Property | Description | Architectural demand |
|---|---|---|
| **Constructive recombination** | Humans construct fictitious scenarios by recombining familiar elements in novel ways | Compositional / disentangled representations — you cannot recombine what is not factorized |
| **Jumpy, multi-scale planning** | Terminal solutions, interim choice points and piecemeal steps are considered in parallel, not at one granularity | A hierarchy of temporal abstractions over the same graph: plan on a coarse meta-graph before the fine instance-graph |
| **Schema transfer** | A plan forged in one setting ("go through the door to reach the room") is reused in a structurally similar new one | Plans indexed by *structure* (`g`) rather than by content (`x`) — [[wiki/concepts/abstract-structural-codes.md]] |

**(brainstorm)** All three are consequences of the factorization the wiki already requires. Recombination needs `x` separable; jumpy planning needs a coarser `g`; schema transfer needs plans keyed on `g`. The planning literature reaches the factorized code from a completely different direction than the hippocampal-coding literature — a convergence worth taking seriously: planning may need no machinery of its own beyond a good graph and a search over it.

---

## Open problems

- **Learning the model without priors.** Everything above assumes a model exists; acquiring it *is* latent graph discovery.
- **What initiates a rollout, and what stops it?** No account of the control policy over simulation — when to plan, how deep, which branch, when the answer is good enough (gap G15).
- **The depth question has no answer even in the ideal agent.** In AIXI, planning *is* expectimax over the future — `max_y Σ_x max_y … Σ_x (credit sum)` — and the horizon `m_k` is the model's only remaining free parameter. Every parameter-free proposal fails: known lifetime `T` is unavailable, exponential discounting introduces a timescale `1/λ`, power-law discounting `k^−α` introduces a dynamic one, and the unbounded limit misbehaves (Hutter's example has the *optimal* agent postpone the rewarding action forever and score zero). The least arbitrary choice is `h_k = β·k` — farsightedness proportional to elapsed history, `β ≈ 1` matching the observation that humans of age `k` rarely plan beyond `k` years. Gap G24; see [[wiki/entities/aixi.md]].
- **Compounding model error.** Rollout accuracy decays with horizon; jumpy hierarchical planning may be as much an error-control device as an efficiency device.
- **Creativity.** The hardest stated target: an agent that plans hierarchically and generates solutions that elude humans.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — simulation-based planning is the *use* half of LGD (path search over the discovered graph); LGD is the *discovery* half that planning presupposes.
- **[[wiki/concepts/complementary-learning-systems.md]]** — replay (backward, for consolidation) and preplay (forward, for planning) are the same hippocampal trajectory-generation machinery serving two functions.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — named as the area where transfer is still aspirational: the biology is suggestive, the mechanism guiding simulation unknown on both sides.
- **[[wiki/concepts/meta-learning.md]]** — schema transfer of plans across structurally similar environments is meta-learning's objective stated in planning terms.
- **[[wiki/concepts/working-memory.md]]** — the controller/model split used for planning is the control/storage separation applied to an environment model instead of a memory matrix.
- **[[wiki/concepts/abstract-structural-codes.md]]** — jumpy hierarchical planning needs the state space decomposed into subgoals, which is the function claimed for periodic structural codes.
- **[[wiki/concepts/attention.md]]** — both need a policy that decides where the next unit of computation is spent; neither supplies one.
- **[[wiki/entities/aixi.md]]** — expectimax over a universal mixture is this page's mechanism in idealized form, and it shows the horizon problem is formal rather than practical: no parameter-free planning depth exists.
- **[[wiki/concepts/universal-induction.md]]** — supplies the model the rollout runs on in the ideal case, and the result that greedy one-step evaluation suffices only where the agent's actions do not shape its observations — i.e. planning depth > 1 is forced exactly by being an agent.
- **[[wiki/concepts/core-knowledge.md]]** — the object system's principles (cohesion, continuity, action-on-contact) are transition constraints, i.e. a candidate hand-specified environment model for the rollout to run on.
