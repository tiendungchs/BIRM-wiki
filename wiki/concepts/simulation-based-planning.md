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
| **Chained recall as the online step, with a causal test** | In a two-stage inference task (`X→Y`, then `Y→Z`), hippocampal activity during `X` alone reinstates the *intermediary* `Y` — voxel patterns in humans, spike patterns in mice, with `Y`-cells firing after `X`-cells so the learned temporal order is preserved — and optogenetic dorsal-CA1 silencing during `X` abolishes the inferred choice while leaving direct `Y→Z` responding intact (Barron et al. 2020) |
| **The valuation of the simulated outcome is downstream, and it is not a value** | The inferred outcome `Z` is *not* decodable in hippocampus, but is decodable in medial prefrontal cortex and putative dopaminergic midbrain — including when `Z` is neutral, so what is represented is the outcome's identity, computed online from the cue rather than transferred to the cue during learning (Barron et al. 2020) |

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
| **Hierarchical Bayesian ToM** ([[wiki/entities/hbtom.md]]) | The inverse-planning row instantiated and measured (Zhi-Xuan et al. 2022). Forward: goal `g ~ Categorical(θ_n)`, policy `π(a\|s) ∝ exp(β_n Q(s,a))` on the MDP's Q-values. Inverse: 8 observed trials give a posterior over the agent's *preferences* `θ_n` and *rationality* `β_n`, then the 9th is scored for surprise. 96.0–99.7% on the Baby Intuitions Benchmark where behavioural-cloning and video-prediction nets sit at chance on the tasks needing cross-trial binding. Two exports beyond the numbers: rationality is a **continuous inferred latent** (`β=∞` optimal, `β=0` random) rather than an assumption, and preferences are renormalised over *reachable* goals before planning (FEASIBILIZE), which is what predicts reaching for an accessible dispreferred object |
| **Model-predictive control with a learned model** | The framing [[wiki/entities/h-jepa.md]] adopts wholesale: propose an action sequence, unroll the learned world model, sum a learned cost `F(x) = Σ_{t=1..T} C(s[t])`, back-propagate the cost gradient *into the action variables*, act on the first action, repeat (receding horizon). The only departure from 1960s optimal control is that model and cost are learned rather than written down. Its significance for this page is that it makes planning **differentiable end-to-end**, so path search stops being a discrete search problem — where the map is smooth |

**The gap.** Generative models produce rich coherent rollouts; using them *for control* is unsolved. The stated requirement is that rich internal models — approximate but accurate enough to plan on — be **learned from experience without strong priors hand-crafted by the experimenter**. That requirement is identical to the LGD problem statement.

---

## Three properties of human planning that machines lack

| Property | Description | Architectural demand |
|---|---|---|
| **Constructive recombination** | Humans construct fictitious scenarios by recombining familiar elements in novel ways | Compositional / disentangled representations — you cannot recombine what is not factorized |
| **Jumpy, multi-scale planning** | Terminal solutions, interim choice points and piecemeal steps are considered in parallel, not at one granularity | A hierarchy of temporal abstractions over the same graph: plan on a coarse meta-graph before the fine instance-graph |
| **Schema transfer** | A plan forged in one setting ("go through the door to reach the room") is reused in a structurally similar new one | Plans indexed by *structure* (`g`) rather than by content (`x`) — [[wiki/concepts/abstract-structural-codes.md]] |

### Jumpy planning, mechanised

The wiki's first concrete proposal for row 2, from [[wiki/entities/h-jepa.md]]:

| Element | Statement |
|---|---|
| **A high-level action is not an action** | It is a *condition the lower-level state must satisfy* for the high-level prediction to hold. `a₂[2]` is fed to a lower-level cost `C(s[2])` that measures the divergence between the fine state and that condition |
| **A subgoal is therefore a learned cost**, not a symbol | Which is why the intermediate action vocabulary can be learned rather than predefined — the point where every prior hierarchical-planning method stops |
| **The precedent is trivial** | A proportional servomechanism is exactly "given a target state, descend the squared distance to it". The novelty is only that the target lives in a *learned* abstract representation |
| **Levels are timescales** | Coarse levels predict further because they have discarded what is not predictable that far ahead — so abstraction and horizon are the same axis |
| **The described pass is greedy** | Top-down subgoal setting is acknowledged as inferior to joint optimisation across levels, which is not worked out |

**(brainstorm)** This dissolves half of gap G24 without touching it. If the horizon is set *per level* by what that level's representation can still predict, planning depth is not a free parameter at all — it is read off the representation. The unanswered part is why any particular level's predictability boundary sits where it does, which relocates the depth question from the planner into the encoder.

**Uncertainty is where it gets expensive.** With a `k`-valued latent per predictor per step, trajectories branch as `k^t`; pruning is named (MCTS) and not designed. With several sampled trajectories the actor can minimise expected cost *or* a mean/variance combination — planning for risk rather than for expectation, which no other entry on this page does.

**(brainstorm)** All three are consequences of the factorization the wiki already requires. Recombination needs `x` separable; jumpy planning needs a coarser `g`; schema transfer needs plans keyed on `g`. The planning literature reaches the factorized code from a completely different direction than the hippocampal-coding literature — a convergence worth taking seriously: planning may need no machinery of its own beyond a good graph and a search over it.

---

---

## Plans vs. policies: what a rollout must be scored over

> `raw/nuijten-2026-efe-planning-variational-inference.md` — Nuijten, van de Laar & de Vries, arXiv:2606.20658, 2026.

A distinction every entry in the *Machine instantiations* table above quietly takes a side on, with a measured cost for getting it wrong.

| | **Plan** | **Policy** |
|---|---|---|
| Object | fixed sequence `u = (u_1,…,u_T)` | state-conditioned `q(u_t\|x_{t-1})` |
| Represents | what the agent will do | what the agent will do *in each state it might reach* |
| Who does this | model-predictive control (action-sequence optimisation, [[wiki/entities/h-jepa.md]]), standard EFE planning, most MCTS rollout scoring | Sophisticated Inference (recursive belief modelling); variational inference over a joint posterior, then marginalise |

**The failure is specific and it only appears under stochastic transitions.** Suppose action `u_1` leads to either of two intermediate states, and each requires a *different* follow-up to reach the goal. Then `(u_1, u_2^{(1)})` fails whenever the transition goes the other way, and so does `(u_1, u_2^{(2)})`. Every plan containing `u_1` scores badly in isolation, so `u_1` is undervalued — even though taking `u_1` and then adapting is optimal. **Plan-based scoring cannot represent "and then I will still get to choose", so it prices enabling actions as if the agent were about to go rigid.**

The repair costs nothing structural: run inference over the *joint* posterior `q(y,x,u,θ)` and marginalise,

```
q(u_t|x_{t-1}) = q(u_t, x_{t-1}) / q(x_{t-1})
```

which scores `u_1` against all reachable futures *paired with the responses the agent would make to each* — contingency without recursive belief modelling and without a tree. Impose the generative model's own Markov factorization on the posterior and `q(u_t|x_{t-1})` is literally a per-timestep factor, so the policy is not extracted after planning, it is a variational parameter.

**Measured.** On a stochastic maze where a cue resolves a latent goal but costs a step and carries a prior penalty: plan-based standard EFE planning visits the cue in 66% of episodes and succeeds in 61%, because it cannot anticipate being able to *react* to what the cue says and so takes a guaranteed-mediocre sink instead; the two policy-based methods visit it in 100% (94% and 100% success). Under *deterministic* transitions (a T-maze) plan- and policy-based methods are indistinguishable at 100% — which is why the distinction is invisible in most of the wiki's benchmarks.

**(brainstorm)** This sharpens the value-of-information argument generally: **information is only worth gathering by an agent that models itself as still able to choose afterwards.** A planner that scores fixed sequences will always undervalue probing, in proportion to how much of the environment's branching it cannot commit around. That makes plan-vs-policy a precondition for gap G15's *which branch* question rather than a detail of it — before deciding where to spend a rollout, the scorer must be over an object that can express contingency.

**Scale consequence.** The tabular joint posterior is exponential in horizon (180,256 parameters for a 5-state maze at `T=4`); the Markov-factorized posterior is linear, and runs MiniGrid DoorKey-8×8 at `T=20` (89% success) where the enumerating tabular planners cannot be instantiated at all. See [[wiki/concepts/expected-free-energy.md]].


---

## When to stop searching: uncertainty crossing as a depth rule

> `raw/daw-2005-uncertainty-based-arbitration.md` — Daw, Niv & Dayan, *Nature Neuroscience* 8:1704–1711, 2005.

The flexibility/speed trade-off cited above has a mechanism, and it is a quantity a planner can compute. Both controllers are run as approximate Bayesian learners; the estimate used for an action is the one whose **posterior variance** is smaller. Two consequences belong on this page rather than on [[wiki/concepts/amortized-inference.md]], where the full account sits:

- **Search has an uncertainty cost that grows with depth.** Pruning and partial expansion inject *computational noise* into a derived value, modelled as accumulating with each search iteration. So a rollout's value gets *less* trustworthy the further it is carried, independently of model error — and this term, not data scarcity, is what eventually makes the cache the more reliable source. It predicts the within-chain dissociation: an overtrained action one step from reward stays devaluation-sensitive while the action before it does not.
- **Partial evaluation turns that into a stopping rule.** Expand a path partway, substitute cached values for the unexpanded sub-trees, and compare the two uncertainties **at each node**: expand while the tree's accumulated computational noise is below the cache's uncertainty about the sub-tree, fall back when it is not. Depth is then not a parameter but the crossing point of two variances the agent is already maintaining (gaps G15, G24).

**A structural routing signal, free from the model already held.** Caching is relatively advantageous under **fan-out** (one state followed randomly by several); linear or **fan-in** topologies favour search. This is the only criterion in the wiki that reads *when to plan* off the graph's shape rather than off experience or a resource budget — and the tree system's own transition estimate is what it is computed from, so it costs nothing extra ([[wiki/concepts/latent-graph-discovery.md]]).

**(brainstorm)** The missing piece for a machine is exactly the noise term. Monte-Carlo tree search reports a visit count and a value, never an estimate of how much its own truncation cost it; without that, the crossing never happens and there is no principled moment to stop expanding or to hand the behaviour to a cached policy. A cheap surrogate — variance across independently pruned rollouts of the same node, compared against a value-head ensemble's variance — would instantiate the rule with machinery already present in AlphaZero-style planners, and would make planning depth an emergent per-node quantity instead of a schedule.

---

## Open problems

- **Learning the model without priors.** Everything above assumes a model exists; acquiring it *is* latent graph discovery.
- **The model is only as good off-policy as the data-collection policy was noisy.** A planner necessarily queries the model at action sequences that are rare under the behaviour distribution, and in the one setting where this is provable, a model with on-policy excess risk `δ` can have counterfactual error `δ / ρ_tr(π)`, where `ρ_tr` is the weakest conditional action excitation of the policy that produced the training data. Measured: goal-conditioned terminal error over a fixed candidate bank falls sharply with `ρ_tr` and is nearly eliminated when it is large, and at `ρ_tr = 0` the predicted reachable set is wrong while on-policy prediction stays accurate. So a planner's competence is bounded by a property of its *own past behaviour*, which no planner on this page measures (Zhang et al. 2026, [[wiki/concepts/learned-world-models.md]], gap G63).
- **What initiates a rollout, and what stops it?** No account of the control policy over simulation — when to plan, how deep, which branch, when the answer is good enough (gap G15). The uncertainty-crossing rule above supplies a *stopping* criterion and a *depth* criterion from one quantity, but it presupposes calibrated variances on both sides, including one no machine planner computes — the uncertainty a truncated search injects into its own valuation (Daw et al. 2005).
- **The depth question has no answer even in the ideal agent.** In AIXI, planning *is* expectimax over the future — `max_y Σ_x max_y … Σ_x (credit sum)` — and the horizon `m_k` is the model's only remaining free parameter. Every parameter-free proposal fails: known lifetime `T` is unavailable, exponential discounting introduces a timescale `1/λ`, power-law discounting `k^−α` introduces a dynamic one, and the unbounded limit misbehaves (Hutter's example has the *optimal* agent postpone the rewarding action forever and score zero). The least arbitrary choice is `h_k = β·k` — farsightedness proportional to elapsed history, `β ≈ 1` matching the observation that humans of age `k` rarely plan beyond `k` years. Gap G24; see [[wiki/entities/aixi.md]].
- **The horizon edge re-introduces the plan/policy failure.** Marginalising a joint posterior buys contingency only inside the planning horizon; at the boundary the agent again scores as though it will never choose again, and nobody has measured whether enabling actions are undervalued there (Nuijten et al. 2026).
- **Compounding model error.** Rollout accuracy decays with horizon; jumpy hierarchical planning may be as much an error-control device as an efficiency device.
- **Creativity.** The hardest stated target: an agent that plans hierarchically and generates solutions that elude humans.
- **Who sets the subgoals?** H-JEPA's hierarchical planner requires a module that decomposes a task into a sequence of individually achievable subgoals and configures the cost for each. The source calls that module "the most mysterious" in its architecture and leaves it explicitly unspecified — so the mechanism above assumes the decomposition rather than producing it (gap G33). **The first hardware demonstration hands the whole thing to the experimenter and shows how much it buys**: V-JEPA 2-AC solves real-robot pick-and-place from three goal images on a fixed timetable — sub-goal 1 for 4 steps, sub-goal 2 for 10, final goal for 4 — with no achievement detector, and the source lists "pick-and-place *without* image sub-goals" as a non-greedy task it cannot do. The decomposition is exactly what makes a **horizon-1** planner sufficient, so a hand-authored subgoal sequence is not a convenience here; it is standing in for search depth ([[wiki/entities/v-jepa-2.md]]).
- **Whether the planner should have a separate policy at all is unsettled.** Everything on this page assumes the transition model and the policy are distinct objects, which is what makes re-goaling a test. The predictive-coding robotics lineage entangles them on purpose — one joint model of sensation and action, behaviour generated by inference — and reports its results from that choice; Taniguchi et al. 2023 pose "to what extent should we decouple world model and policy representations?" as open ([[wiki/empirical-tensions.md]] T142).
- **How much needs to be simulated at all.** Passive dynamic walkers walk with no controller and no model; morphological computation and subsumption architecture got flexible behaviour with the world used as its own model. No criterion here says which parts of a task are cheaper to offload to body–environment dynamics than to represent — though every such demonstration is sensorimotor and none answers a counterfactual query, which is what the model is wanted for ([[wiki/empirical-tensions.md]] T143).
- **Differentiability buys nothing where it is needed most.** Gradient-based action inference works when the action-to-cost map is smooth; high-abstraction choices are qualitative and discontinuous, and there the fallbacks are dynamic programming, beam search and MCTS — the classical methods the differentiable design was meant to displace.

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
- **[[wiki/concepts/expected-free-energy.md]]** — and what the rollout must be scored *over* rather than *by*: marginalising a joint posterior into `q(u_t|x_{t-1})` prices an action against the responses the agent would make to each stochastic outcome, which fixed-sequence scoring cannot express and which is what keeps information-gathering worth doing (Nuijten et al. 2026).
- **[[wiki/entities/h-jepa.md]]** — the fullest worked instantiation of this page: model-predictive control on a learned world model and a learned cost, with high-level actions reinterpreted as conditions on lower-level states, which is the wiki's first mechanism for the jumpy multi-scale row above.
- **[[wiki/entities/hbtom.md]]** — the inverse direction with numbers on it: run the same MDP rollout machinery backwards over another agent's trajectory to recover its utilities and its degree of rationality, in a domain where the transition model is hand-supplied so only the inversion is being tested.
- **[[wiki/entities/irene.md]]** — the control that limits what an efficiency score licenses: a next-position regressor with no planner and no utility inversion matches or beats inverse planning on the path- and time-efficiency subtasks, so competence there is not evidence that a forward model is being run backwards.
- **[[wiki/concepts/energy-based-models.md]]** — planning restated as constraint satisfaction: the action sequence is a set of free variables and the plan is the configuration minimising a summed energy, which makes actions and latents the same kind of object.
- **[[wiki/entities/maze-solving-transformers.md]]** — the map is verifiably present and the routing is still wrong: the fork decision (`first_path_choice`) is the worst sub-task in every model × dataset cell, which localises the deficit in search rather than in the world model (Ivanitskiy et al. 2023).
- **[[wiki/concepts/representation-probing.md]]** — the diagnostic that keeps a planning failure from being blamed on the model: if the transition structure probes clean, what is broken is search, valuation or control (gap G15).
- **[[wiki/concepts/cognitive-map.md]]** — the neural read-outs of path search: entorhinal Euclidean distance as an admissible heuristic over hippocampal path distance, degree/closeness centrality represented before the search as pruning information (gap G15), breadth-first-search cost in lateral prefrontal cortex, and goal direction realised by transiently re-pointing the heading system rather than by a goal-direction vector — planning by simulating being there (Epstein et al. 2017).
- **[[wiki/concepts/successor-representation.md]]** — the cached end of the same spectrum: `v = Sr` replaces rollout with a matrix product, and "intuitive planning" needs only the start and goal grid codes — at the cost of failing when an obstacle appears.
- **[[wiki/concepts/path-integration.md]]** — the cheapest planner in the wiki: with a path-integrated code, direction and distance to a goal are a vector subtraction rather than a search.
- **[[wiki/entities/cscg.md]]** — planning by inference: condition a generative sequence model on a start and a goal state and infer the intervening actions, with no value function and no tree.
- **[[wiki/concepts/offline-replay.md]]** — the same trajectory-generation machinery measured against the planning claim and found only partly to support it: most replay is remote rather than imminent, so rollout is one sampling policy of a mechanism that mostly serves consolidation ([[wiki/empirical-tensions.md]] T30).
- **[[wiki/concepts/offline-replay.md]]** — and the alternative to rolling forward at all: if rest-phase ripples have already written the composed `X→Z` edge, the choice needs one lookup rather than a chain of retrievals, which makes offline edge construction a competitor to online simulation rather than a supplier for it (Barron et al. 2020).
- **[[wiki/entities/adaptive-cann.md]]** — turns the rollout/hold decision into a continuous parameter instead of a mode switch: adaptation gain relative to input strength moves one circuit from locked-to-the-world, through sweeping around the current estimate, to running free through the state space, with the two switching thresholds in closed form (G15's interface, still without its controller).
- **[[wiki/entities/fcann.md]]** — prices the control signal a policy over dynamics would need: an additive input at SNR ≈ 0.005, in one region (nucleus accumbens), reproduces empirically observed whole-brain trajectory changes, so redirecting an attractor system costs far less than its intrinsic drive — the actuator for G15 is cheap even though its controller is still missing.
- **[[wiki/entities/differentiable-neural-computer.md]]** — planning by writing the decision down instead of rolling out: the first block-puzzle action is decodable from memory ~60 steps before execution, so the search happens at write time and execution is a read — an amortisation of rollout into a store rather than a rollout-control policy (G15).
- **[[wiki/concepts/cognitive-control.md]]** — the same missing policy in the retrieval direction: a task model is evoked by pattern completion from whichever cues the situation supplies, which is exactly the case where a rollout most needs to be initiated by something *other* than the situation, so both pages inherit gap G37 from opposite ends (Miller et al. 2002).
- **[[wiki/concepts/controller-knowledge-vs-process.md]]** — retrieval as a substitute for rollout: online activation of a stored goal-oriented event sequence *is* prediction of the subsequent events, so wherever a matching stored path exists no simulation is needed — and prefrontal damage removes exactly that forward prediction.
- **[[wiki/entities/nucleus-reuniens.md]]** — a candidate substrate for controller-specified rollout: the medial prefrontal → reuniens → septal hippocampus pathway is required for representing the future path during goal-directed behaviour, which puts the plan inside the world model rather than in a separate planner reading it (Ito et al. 2015, in Jin & Maren 2015).
- **[[wiki/entities/meta-rl-agent.md]]** — the strongest challenge to this page's diagnostic: a recurrent network trained by a *model-free* algorithm reproduces the model-based two-step stay pattern and model-based reward-prediction errors (`r² = 0.89` vs `5.8 × 10⁻⁷`) with its weights frozen, so the signature identifies the emergent inner algorithm and not the mechanism that produced it (Wang et al. 2018).
- **[[wiki/entities/spacetime-attractor.md]]** — the rival to rolling forward at all: instantiate one copy of the world model per pair of consecutive future timesteps and *infer* the whole trajectory as an attractor state, which evaluates all futures in parallel, makes planning depth an anatomical constant rather than a scheduling decision (G15/G24), and beats the successor representation exactly where reward changes within the horizon (Jensen et al. 2026).
- **[[wiki/entities/pfc-columnar-planning-model.md]]** — the third way of evaluating all futures at once: a reward signal diffuses backwards along learned reverse edges with per-relay attenuation, so distance-to-goal is a firing rate rather than a stored value, and the depth at which the wave hits the noise floor *is* the planning horizon — a physical answer to G24 that a discount factor only reparameterises (Martinet et al. 2011).
- **[[wiki/concepts/expected-free-energy.md]]** — the active-inference objective a rollout is scored by, plus what kind of search that makes planning: convex over policy-induced occupancies, so no globally Bellman-optimal value function exists and the planner must relinearise its reward between iterations rather than back up a single `V` (Milosevic et al. 2026).
- **[[wiki/concepts/expected-free-energy.md]]** — and a planner for it that is not a search at all: each entropy correction in the objective becomes a local kernel rewrite on a factor graph, so scoring imagined futures runs as damped sum-product message passing over a forward–backward schedule rather than as rollout enumeration (Nuijten et al. 2026).
- **[[wiki/concepts/expected-free-energy.md]]** — and the stopping rule that objective implies: rewriting expected free energy as a ρ-POMDP utility makes *keep observing vs. commit* a single scalar comparison whose crossover emerges from the derived weight `w = 1` rather than from a threshold, which is the first answer in the wiki to G15's *when is the answer good enough* — at the price of holding only where information-gathering leaves the hidden state intact (Cooper & Velasquez 2026).
- **[[wiki/concepts/shortcut-learning.md]]** — supplies the re-goaling protocol as an intended-solution test that costs no distribution shift: hold transitions fixed, swap the reward, and measure retraining.
- **[[wiki/entities/c-ts-model.md]]** — the within-trial hierarchy that is *not* an option: task-set selection constrains which actions are viable without extending the decision in time, filling the state-space half of hierarchy that the options framework leaves out.
- **[[wiki/concepts/precision-weighting.md]]** — the proposal to delete the value function outright: rollouts are scored against prior expectations over *sensory* trajectories, which are observed, rather than against a `V` over hidden states that must be solved for — demonstrated on mountain car, at the cost that re-goaling becomes model surgery (Friston 2009, G28).
- **[[wiki/entities/deep-active-inference-agent.md]]** — the conflict a control policy over simulation inherits, with numbers: the agent that learns the transition structure best is the one taking uniformly random actions and scoring at chance, while the agent that solves the task predicts the environment worse — so G15's controller is also a data-collection policy for the model it rolls out on (Champion et al. 2023).
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — makes the horizon a regulated quantity rather than a chosen one: value estimates learned with `γ → 1` have high variance, the variance is visible in the TD error, so an agent can lower its own discount factor exactly when its long-range predictions stop being reliable — a computable answer to G24 that needs no lifetime estimate, and one carried by a specific transmitter (Doya 2002).
- **[[wiki/concepts/amortized-inference.md]]** — and the quantity that decides between them: posterior variance per action, with the tree's variance growing by a *computational noise* term at each search iteration, so overtraining, task simplicity and distance from reward all push control to the cache while task complexity and reward proximity keep it in the search (Daw et al. 2005).
- **[[wiki/concepts/temporal-abstraction-options.md]]** — fills the "jumpy, multi-scale planning" row with a mechanism and supplies the first candidates for this page's *who sets the subgoals?* problem: an **option model** annotates a compiled path with its terminal state, accrued reward and expected **duration**, which is what lets search skip primitive sequences, and option discovery is attempted by trajectory-frequency bottlenecks, graph partitioning, intrinsic motivation on unexpected salient events, impasses, or inferring another agent's subgoals (Botvinick, Niv & Barto 2009, gap G33).
- **[[wiki/concepts/evidence-accumulation.md]]** — G15's *when is the answer good enough* half in closed form, for the restricted case where the candidates are already enumerated: threshold the normalised posterior over candidates rather than the score of the leader, with the normaliser computed by a dedicated subcircuit. Asymptotically optimal for any `N`, decision time growing only as `ln N`, and silent about depth and branch selection — the enumeration requirement is exactly what an open-ended planner lacks (Bogacz & Gurney 2007).
- **[[wiki/entities/hisd.md]]** — isolates the value of the decomposition from the value of temporal abstraction: with the discovered skill set held fixed, making the grammar's composite nodes selectable beats using the same skills flat, and both beat primitive-action PPO, which fails the task outright (Harvey et al. 2026).
- **[[wiki/concepts/subjective-value.md]]** — a fourth answer to G24's *how deep* that is neither derived nor regulated: the horizon is a per-agent constant, wide across agents (238×) and stable within one over six months — and the fitted kernel is hyperbolic, so it admits no stationary value function for a rollout to be scored against (Kable & Glimcher 2007, T141).
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the discrete branch of this page: when the world model is carved into effect-equivalence classes, the rollout is handed to an off-the-shelf symbolic planner and depth becomes a search parameter over rules rather than a horizon over a learned latent — with the continuous cost the plan will actually incur left unscored (Taniguchi et al. 2023).
- **[[wiki/concepts/learned-world-models.md]]** — the object this page searches over, with the design choices spelled out: a *deterministic* learned transition is exploitable by the planner running on it (the optimiser finds action sequences whose imagined return is model error), which makes stochastic transitions a planning requirement rather than a modelling preference (Long et al. 2025).
- **[[wiki/concepts/learned-world-models.md]]** — the quantitative version of "model error compounds": the planner evaluates candidates off the behaviour distribution, so its terminal error tracks the conditional action excitation of the data-collection policy rather than the model's training loss, and the two move in opposite directions as the actor improves (Zhang et al. 2026).
- **[[wiki/concepts/reward-prediction-error.md]]** — where this page's scoring inherits an unadjudicated problem: rollout values presume a stationary value function, which the hyperbolic kernel behind `δ`'s `V` term forbids (T141).
- **[[wiki/entities/v-jepa-2.md]]** — this page's method with the energy written down and measured: `E = ‖P(â_{1:T}; s_k, z_k) − z_g‖₁` over a goal *embedding*, minimised by the cross-entropy method at horizon 1, with the landscape verified smooth and locally convex around the true action — which is the precondition H-JEPA's gradient-based planner needs and had never been checked; and it prices the rollout, since the same planner affords 800 candidates in 16 s on a latent model and 80 in 4 min on a pixel-generative one.
- **[[wiki/entities/adaworld.md]]** — this page's method run on an induced action alphabet: cross-entropy-method MPC with the cost supplied by cosine similarity to a goal image beats a Q-table built from the identical 100-samples-per-action budget 56.67% to 27.17%, while the same planner over an action-agnostic model scores at chance.
- **[[wiki/entities/gcq.md]]** — planning with neither rollout nor search: the greedy operator `s_i ⊖ s_j = argmin_{a∈A} ‖s_j + a − s_i‖` picks one valid bump displacement per step at constant cost, re-observes, and stops when the no-op is selected. It is this page's cheapest planner after path-integration's subtraction — and it scores only latent distance, so nothing stops it descending into an obstacle the map does not represent.
