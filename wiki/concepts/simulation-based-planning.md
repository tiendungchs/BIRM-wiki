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

## Open problems

- **Learning the model without priors.** Everything above assumes a model exists; acquiring it *is* latent graph discovery.
- **What initiates a rollout, and what stops it?** No account of the control policy over simulation — when to plan, how deep, which branch, when the answer is good enough (gap G15).
- **The depth question has no answer even in the ideal agent.** In AIXI, planning *is* expectimax over the future — `max_y Σ_x max_y … Σ_x (credit sum)` — and the horizon `m_k` is the model's only remaining free parameter. Every parameter-free proposal fails: known lifetime `T` is unavailable, exponential discounting introduces a timescale `1/λ`, power-law discounting `k^−α` introduces a dynamic one, and the unbounded limit misbehaves (Hutter's example has the *optimal* agent postpone the rewarding action forever and score zero). The least arbitrary choice is `h_k = β·k` — farsightedness proportional to elapsed history, `β ≈ 1` matching the observation that humans of age `k` rarely plan beyond `k` years. Gap G24; see [[wiki/entities/aixi.md]].
- **Compounding model error.** Rollout accuracy decays with horizon; jumpy hierarchical planning may be as much an error-control device as an efficiency device.
- **Creativity.** The hardest stated target: an agent that plans hierarchically and generates solutions that elude humans.
- **Who sets the subgoals?** H-JEPA's hierarchical planner requires a module that decomposes a task into a sequence of individually achievable subgoals and configures the cost for each. The source calls that module "the most mysterious" in its architecture and leaves it explicitly unspecified — so the mechanism above assumes the decomposition rather than producing it (gap G33).
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
- **[[wiki/entities/h-jepa.md]]** — the fullest worked instantiation of this page: model-predictive control on a learned world model and a learned cost, with high-level actions reinterpreted as conditions on lower-level states, which is the wiki's first mechanism for the jumpy multi-scale row above.
- **[[wiki/entities/hbtom.md]]** — the inverse direction with numbers on it: run the same MDP rollout machinery backwards over another agent's trajectory to recover its utilities and its degree of rationality, in a domain where the transition model is hand-supplied so only the inversion is being tested.
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
- **[[wiki/concepts/expected-free-energy.md]]** — and the stopping rule that objective implies: rewriting expected free energy as a ρ-POMDP utility makes *keep observing vs. commit* a single scalar comparison whose crossover emerges from the derived weight `w = 1` rather than from a threshold, which is the first answer in the wiki to G15's *when is the answer good enough* — at the price of holding only where information-gathering leaves the hidden state intact (Cooper & Velasquez 2026).
- **[[wiki/concepts/shortcut-learning.md]]** — supplies the re-goaling protocol as an intended-solution test that costs no distribution shift: hold transitions fixed, swap the reward, and measure retraining.
- **[[wiki/entities/c-ts-model.md]]** — the within-trial hierarchy that is *not* an option: task-set selection constrains which actions are viable without extending the decision in time, filling the state-space half of hierarchy that the options framework leaves out.
- **[[wiki/concepts/precision-weighting.md]]** — the proposal to delete the value function outright: rollouts are scored against prior expectations over *sensory* trajectories, which are observed, rather than against a `V` over hidden states that must be solved for — demonstrated on mountain car, at the cost that re-goaling becomes model surgery (Friston 2009, G28).
