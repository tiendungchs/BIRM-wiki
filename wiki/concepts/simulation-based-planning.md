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

**They are not exclusive, and the traffic runs both ways.** Considerable evidence has the brain running both, competing over control and cooperating over training, arbitrated by metacognitive processes on a rational speed/flexibility trade-off (Daw, Niv & Dayan 2005; Keramati et al. 2011); plans are *amortized* into cached values by letting the model-based system simulate training data for the model-free one, possibly offline (Sutton 1990; Gershman, Markman & Otto 2014), and model-based behaviour becomes automatic with training (Economides et al. 2015). See [[wiki/concepts/amortized-inference.md]].

---

## The re-goaling test

The cleanest behavioural signature of model-based control, and a usable evaluation protocol (gap G17).

Construct variants of one task that are **identical in transition structure and differ only in the reward function**. Frostbite admits at least eleven (Lake et al. 2017): get the *lowest* score; get closest to 300 without going over; beat a friend but only barely; survive as long as possible; die as fast as possible; clear each level at the last possible second; reach the furthest level ignoring score; find Easter eggs; collect only fish; touch every ice floe exactly once; teach the game to someone else. A competent human player shifts to any of these with little or no additional learning; a DQN must be retrained, and changing object colours or appearance alone is enough to destroy its performance.

Go supplies the same test at a different scale: board sizes from 9×9 to 38×38, non-rectangular and non-planar boards (torus, Möbius strip, cube, diamond lattice), holes cut in the board, and rule changes (First Capture Go, NoGo, Time Is Money Go), plus multi-player and team variants. Skilled humans adapt; AlphaGo's learned value functions and policies "seem unlikely to generalize as flexibly", and most variants would need reprogramming and retraining *by the humans who built it*.

**Why it is a good instrument.** The transition model is held fixed by construction, so the only thing varying is what the agent must do with it — which isolates the *use* half of the framing from the *discovery* half. It needs no distribution shift in the observations, so it is cheaper than an o.o.d. benchmark, and it has the property gap G17 demands: a well-defined intended solution.

**(brainstorm)** Restated in the wiki's terms, re-goaling is a **modularity test on the graph estimate**: it passes only if the environment model is stored separately from the value function, so that an arbitrary new reward can be composed with it at query time. A system that cannot re-goal has entangled the two, whatever its architecture diagram says. That makes it a direct probe of gap G1's factorization along an axis the wiki has not used — not `g` vs `x`, but *transitions* vs *preferences*.

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
| **Intuitive physics engine** | Simulation as the *model* of a cognitive competence rather than as a planner component: reconstruct objects with mass, elasticity and friction, apply forces, roll forward. Fits adult tower-stability judgements quantitatively, and answers hypothetical and counterfactual queries (remove blocks, glue them, change the material, jostle the table) that each require new features and new training for a discriminative account ([[wiki/concepts/core-knowledge.md]]) |
| **Bayesian inverse planning** | The same idea for other minds, and the only one here that **nests recursively**: planning is an MDP/POMDP over an agent's utilities and beliefs, and inverting it recovers those utilities and beliefs from observed actions. Learning from watching an expert needs no trial of one's own — infer that birds are dangerous from the fact that avoidance is the best explanation of the expert's behaviour |

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
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — supplies the switch that turns perception into simulation (drop the bottom-up gain `γ → 0`, drive biased competition `β ≪ 0`) and the drive that initiates a rollout (homeostatic divergence read as free energy), which is the first candidate mechanism for gap G15's *when to plan* half (Butz 2016).
- **[[wiki/concepts/amortized-inference.md]]** — the compilation direction: rollouts generate training data for a model-free controller, so habitization is planning being cached rather than planning being abandoned, and arbitration between the two supplies a second candidate answer to gap G15's *when to plan*.
- **[[wiki/concepts/causal-model-building.md]]** — supplies what the rollout runs on: a model is usable for planning only if its steps correspond to the environment's generative steps, and the re-goaling test above is that page's richness criterion applied to control.
- **[[wiki/concepts/compositionality.md]]** — constructive recombination, listed here as a missing property, is compositionality applied to imagined scenarios; and sub-goal composition is the only cited route to planning under sparse reward.
- **[[wiki/concepts/event-segmentation.md]]** — supplies the multi-scale graph to plan over (episodes compress schema chains) and runs path search *backwards*: chain event schemata by matching a desired final event to another schema's preconditions.
