# Simulation-Based Planning

**Select actions by rolling an internal model of the environment forward and evaluating imagined outcomes, instead of reading them off a cached policy.**

In the wiki's core framing this is **path search over the latent graph**: the internal model *is* an estimate of the instance-graph, and planning is finding a route through it. See [[wiki/concepts/latent-graph-discovery.md]].

---

## Model-free vs model-based

| | Model-free (e.g. DQN) | Model-based / simulation |
|---|---|---|
| What is learned | State/action → value or policy | Transition and reward structure |
| Compute at decision time | Cheap — one forward pass | Expensive — rollouts |
| Data efficiency | Poor; needs many samples per accurate estimate | High; one model update revalues many states |
| Response to a changed reward | **Insensitive** — the policy must be relearned | Immediate — revalue the same model |
| Response to a changed transition | Insensitive | Immediate, if the model is updated |
| Failure mode | Reactive, inflexible | Model error compounds along the rollout |

The flexibility asymmetry is the reason this matters for abstract reasoning: a reasoning agent is defined by its ability to answer counterfactual and novel-goal queries, and only the model-based side can do that without retraining.

---

## Evidence that biology plans this way

| Observation | Content |
|---|---|
| **Hippocampal preplay at choice points** | When a rat pauses at a decision point, ripples of hippocampal activity resemble those seen during subsequent traversal of each available trajectory — as if simulating each alternative before committing |
| **Non-spatial human planning** | Similar sequential reinstatement reported during abstract, non-spatial planning tasks |
| **Scrub jay caching** | Food caching takes into account the *future* conditions of recovery — planning that cannot be explained by cached value |
| **Rat cognitive maps** | Support inductive inference during wayfinding and one-shot learning in mazes |
| **Division of labour** | The hippocampus instantiates the internal model; goal-contingent *valuation* of simulated outcomes occurs downstream in orbitofrontal cortex and striatum |
| **Shared substrate** | Imagination, episodic future thinking, and simulation-based planning depend on a common hippocampal substrate — the same machinery that supports recall |

The mechanism that *initiates and steers* the rolling-forward is unresolved; the leading proposal is prefrontal control acting on the hippocampus — which has a direct AI parallel: a controller that queries an environment model with task-relevant goals and receives predicted states back.

---

## Machine instantiations

| System | Role |
|---|---|
| **Dyna** | The origin: interleave real experience with simulated experience from a learned model; explicitly motivated by "mental models" theories of human learning |
| **Monte Carlo tree search** | Forward search used to improve a value function and/or policy; the search half of expert Go play |
| **Deep generative environment models** | Generate temporally consistent sample sequences reflecting the geometric layout of newly experienced environments — the direct analogue of hippocampal binding of components into a coherent imagined experience |
| **Controller/model separation architectures** | An explicit split between a policy controller and an environment model, queried bidirectionally; used for planning over interacting physical objects |

**The gap.** Generative models can produce rich, coherent rollouts; using them *for control* remains unsolved. The stated requirement is that rich internal models — necessarily approximate but accurate enough to plan on — be **learned from experience without hand-crafted priors**. That requirement is identical to the LGD problem statement.

---

## Three properties of human planning that machines lack

| Property | Description | Architectural demand |
|---|---|---|
| **Constructive recombination** | Humans construct fictitious scenarios by recombining familiar elements in novel ways | Compositional / disentangled representations — you cannot recombine what is not factorized |
| **Jumpy, multi-scale planning** | Humans consider terminal solutions, interim choice points and piecemeal steps *in parallel*, not at one granularity | A hierarchy of temporal abstractions over the same graph; equivalently, a coarse meta-graph planned on before the fine instance-graph |
| **Schema transfer** | A plan forged in one setting ("go through the door to reach the room") is reused in a structurally similar new environment | Plans indexed by *structure* (position in the meta-graph `g`) rather than by content (`x`) |

**(brainstorm)** All three are consequences of the same factorization the wiki already requires. Recombination needs `x` separable; jumpy planning needs a coarser `g`; schema transfer needs plans keyed on `g` not `x`. That the planning literature arrives at the factorized code from a completely different direction than the hippocampal-coding literature is a convergence worth taking seriously — planning may not need machinery of its own beyond a good graph and a search over it.

---

## Open problems

- **Learning the model without priors.** Everything above assumes a model exists; acquiring it *is* latent graph discovery.
- **What initiates a rollout, and what stops it?** No account of the control policy over simulation — when to plan, how deep, which branch, when the answer is good enough.
- **Compounding model error.** Rollout accuracy decays with horizon; jumpy hierarchical planning may be as much an error-control device as an efficiency device.
- **Planning over an edge set the agent itself edits** (hardness source 6) — models score ~15–20% even when every rule change is observable, controllable and bounded.
- **Creativity.** The hardest stated target: an agent that plans hierarchically and generates solutions that elude humans.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — simulation-based planning is the *use* half of LGD (path search over the discovered graph); LGD is the *discovery* half that planning presupposes.
- **[[wiki/concepts/complementary-learning-systems.md]]** — replay (backward, for consolidation) and preplay (forward, for planning) are the same hippocampal trajectory-generation machinery serving two functions.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — named there as the area where transfer is currently aspirational: the biology is suggestive, the mechanism for guiding simulation is unknown on both sides.
- **[[wiki/concepts/meta-learning.md]]** — schema transfer of plans across structurally similar environments is meta-learning's objective stated in planning terms.
