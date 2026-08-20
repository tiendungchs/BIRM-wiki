# Spacetime Attractor (STA)

**A prefrontal attractor network whose fixed points are entire future trajectories: neurons are tuned to a *(location, delay)* pair, consecutive delay-subspaces are wired by the environment's adjacency matrix, and reward enters as a separate input to each delay — so planning is one relaxation pass rather than a search** (Jensen, Doohan, Sablé-Meyer, Reinert, Baram, Akam & Behrens 2026, `raw/jensen-2026-planning-prefrontal-cortex.md`, eLife reviewed preprint).

The wiki's first mechanistic circuit model that plans **by inference rather than by rollout**. Its one-line claim: ring attractors infer the present heading, grid attractors infer the present position, and the same motif with one extra axis — *delay* — infers the future.

---

## Architecture

| Component | Statement |
|---|---|
| Unit | `r_δi` = "I expect to be at location `s_i` in `δ` actions". `δ = 0` is the present |
| Subspace | All units sharing a delay `δ`; within-subspace normalisation makes `r_δ·` a **distribution over desired locations at that delay** |
| Recurrence between `δ` and `δ±1` | The environment **adjacency matrix `A_ij`** — one copy per consecutive subspace pair. Consistent (co-trajectory) states excite, inconsistent states inhibit |
| Recurrence within a subspace | Mutual inhibition (one location per delay) |
| Input to `δ = 0` | Current agent location (`R_0i = 20` at the current state) |
| Input to `δ > 0` | `R_δi` = reward available at `s_i` in `δ` actions, gain `β = 9` — **reward is time-indexed, so each subspace can be told something different** |
| Nonlinearity | Exponential, with normalisation per subspace; inhibition floored at `ε = −100` |
| Dynamics | `τ = 50` iterations, white noise `σ = 0.1`; 400 iterations run to convergence before each action |
| Read-out | Greedy over subspace `δ = 1`, restricted to states reachable from the current one |
| Conveyor belt | After acting, the content of subspace `δ` moves to `δ − 1`; an identity feed-forward term is added between consecutive subspaces for 100 iterations after each action to stabilise the shift (borrowed from the fly head-direction "update neurons", [[wiki/entities/fly-central-complex.md]]) — not required for any main result |
| Stabiliser | Weight noise is restricted to be **negative** (`U(−0.025, −0.015)` added to `A`), which prevents the representation "teleporting" between non-adjacent locations |

**The four components, minimally stated:** (i) different populations for different future times; (ii) connections = world structure; (iii) current location into the present subspace; (iv) reward into all future subspaces. Relaxation then trades two pressures off — reward input pulls each subspace toward high-value locations, neighbouring-subspace input forces the sequence to be a *realisable path* — and the fixed point is the reward-maximising trajectory.

---

## Why this is not the usual world-model rollout

| | Sequential simulation (MCTS, Dyna, model-predictive control) | **Spacetime attractor** |
|---|---|---|
| World model stored as | One transition function applied repeatedly | **Many explicit copies**, one per pair of consecutive subspaces |
| Futures considered | One at a time, serially | All at once, in parallel, by relaxation |
| Cost at decision time | Grows with depth × branching | One settling pass; depth = number of subspaces |
| Novel environment | Adapts immediately | Needs the structure already embedded (or gated in, below) |
| Time-varying goals | Handled by re-simulating | **Native** — subspace `δ` just receives a different reward |

This is "planning as inference" (Botvinick & Toussaint 2012; Levine 2018) given a circuit. The paper's proposed division of labour across the brain:

| System | Regime it owns |
|---|---|
| Striatal temporal-difference learning | Rewards stable across trials — fastest, least flexible |
| Hippocampal successor representation | Rewards changing between trials but constant within one |
| **Prefrontal STA** | Rewards changing *within* the planning horizon |
| Explicit search / replay | Novel structure; can be *seeded* by partial STA plans |

---

## Results

### Handcrafted STA vs TD vs SR — four tasks of increasing reward dynamics

| Task | Reward | TD | SR | STA |
|---|---|---|---|---|
| 1. Fixed goal, all trials | static | ✓ | ✓ | ✓ (as an inferred path, not a value function) |
| 2. Goal resampled per trial | static within trial | ✗ | ✓ | ✓ |
| 3. Moving goal (interception) | moves within trial | ✗ | ✗ — the SR is a *time-averaged* occupancy and cannot say *when* the agent is where | ✓ — intercepts in space **and** time |
| 4. Reward landscape: `R(t, s) ~ U(−1, 1)` independently per state per timestep | fully dynamic | ✗ | ✗ | ✓ |

Metric: probability of choosing the optimal *first* action, where optimal = first step of the cumulative-reward-maximising trajectory. Task 4 is the discriminating one — it requires forgoing immediate reward for a later payoff, on a 4×4 maze over six actions.

### RNNs trained on task 4 rediscover the STA

Supervised training to output optimal actions from (location, full reward function) inputs, with penalties on firing rates and weight magnitude. All three defining STA properties appear:

| Property | Evidence |
|---|---|
| Explicit future representation | Linear decoders (cross-validated by holding out the current location, so the read-out must **generalise across trajectories**) recover the location at each future `δ` during both planning and execution |
| Conveyor belt | A decoder trained to read location at `t = 3` from activity at `t = 1` reads location at `t + 2` from activity at any `t` |
| World model in the weights | Recurrent weights between adjacent subspaces correlate with the maze adjacency matrix at **0.91 ± 0.07** (control environments: 0.72 ± 0.06); weights between subspaces `Δ` apart track the **`Δ`-th order adjacency matrix**; `δ = 0` receives location input and `δ` receives the reward at `δ` |
| Attractor dynamics | Weak perturbation of the converged state decays; strong perturbation of *one location on a competing path* flips the representation to that **entire path**, including unperturbed subspaces; equal-magnitude random-direction perturbations do nothing |

Two negative results carry as much weight as the positives:

- RNNs trained on the **simpler** tasks do not learn explicit future representations, and fail on task 4; the task-4 RNN solves the simple tasks. **A generality/efficiency trade-off**: the STA solution costs more neurons, synapses and firing rate, so a regulariser buys the cheaper non-planning solution wherever the task permits it. The paper offers this as a reason PFC occupies so much cortex — an argument no value-coding theory of PFC makes.
- RNNs with too few hidden units to build an STA fail the task outright rather than finding another solution, i.e. gradient descent does not readily find an alternative algorithm.

Also: unlike the handcrafted STA, the trained RNN *relaxes back* to the original fixed point after a perturbation is removed — a smoother attractor landscape with fewer local minima than the hand-wired one.

### Generalisation across structures without plasticity

Trained with a different maze each trial (walls supplied as a binary input), the RNN performs nearly as well as a single-maze network, and its **effective** subspace-to-subspace connectivity matches whichever maze it is currently in. The mechanism:

- The units encode **future transitions** `s_i → s_j at delay δ`, not future locations. This costs more neurons.
- A learned scaffold contains every transition possible in *some* environment; consecutive-transition pairs are wired together.
- Wall input **inhibits the representations of the transitions it blocks**, so the surviving scaffold is the current environment's structure.
- Verified: transitions are decodable; consistent consecutive transitions are the connected ones; a wall input projects specifically onto transitions through that wall.

**This is input-mediated gating of a generic structural scaffold — a fixed weight matrix reconfigured within a trial.** It is the same trick as [[wiki/entities/context-modular-memory-network.md]]'s mask, applied to a world model instead of a memory library.

---

## What it buys the wiki

1. **A second, cheaper answer to "how deep, when to stop" (G15/G24).** There is no rollout to schedule: depth is a structural constant (the number of subspaces), and the plan is finished when the dynamics converge. The horizon question does not disappear, it *moves into the anatomy* — planning depth is a neuron budget, linear in the number of subspaces.
2. **Attractors that are edges, not just nodes.** [[wiki/concepts/attractor-dynamics.md]] states that relaxation supplies the node set and no traversal. Here the fixed point is an entire *path*: the trajectory is in the settled state rather than in a sequence of states, so the edges are carried by the between-subspace weights while the dynamics stay relaxational.
3. **A world model that is read in parallel.** Copies of `A` between every consecutive subspace pair is the wiki's first architecture where "having a model" and "simulating with it" are the same operation.
4. **A mechanism for structural re-use that needs no weight change** — inhibitory gating of a superset scaffold — which is a direct candidate for G47's missing half in the discrete case: the topology is not learned per environment, it is *carved out of a learned superset by input*.
5. **Working memory and planning unified.** The sequence-memory representations of El-Gaby et al. 2023 and Xie et al. 2022 (concurrent subspaces for each step of a future sequence, with correlations reflecting task structure even at rest) become the *substrate* of planning rather than a separate function ([[wiki/concepts/working-memory.md]]).

---

## Predictions (the paper is theory; there is no dataset that tests it)

| Prediction | Shared with a plain sequence-memory account? |
|---|---|
| Distinct PFC subspaces represent distinct steps of a plan after planning | Yes |
| Optogenetic activation of a future subspace biases behaviour toward that state **at the corresponding delay** | Yes |
| Effective connectivity between subspaces reflects environment structure (noise correlations, holographic stimulation) | **No — unique to the STA** |
| Different neuron sets represent the future in environments of different structure | **No** |
| Those neurons are connected according to that environment's structure, gated by sensory or hippocampal input | **No** |

---

## Limitations

| Limitation | Detail |
|---|---|
| Rewards are given | `R(t, s)` is supplied as ground truth input for the whole horizon. Estimating it is delegated to unnamed circuits — and it is exactly the hard half in any real task |
| Structure is given | Walls arrive as a binary input. Learning the scaffold is not modelled; hippocampal replay into cortex is *proposed* as the training route (Bakermans et al. 2023; Ou et al. 2025) |
| Neuron cost is linear in horizon | `\|states\| × horizon` units, and the transition-coding variant multiplies that by the branching factor. Hierarchy is offered as the fix (stacked STAs give horizon exponential in depth) but "learning appropriate abstractions and embedding them in an STA remains an unsolved challenge" |
| Redundant learning | Each consecutive-subspace copy of `A` is learned independently, which the authors call inefficient |
| Scale | 4×4 grid mazes, six-action trials, 5 RNN seeds per condition |
| Environment is autonomous | Structure and reward evolve independently of the agent. Key-door problems and social interaction are sketched (below), not implemented |
| No data | Every quantitative claim is about the model or the trained RNN; the experimental predictions are unrun |

---

## Extensions the paper sketches

- **Hierarchy.** Couple an abstract STA to a detailed one: the abstract plan's next state becomes the goal input of the finer STA. Plan length becomes exponential in hierarchy depth. Unsolved: where the abstraction comes from ([[wiki/concepts/abstract-structural-codes.md]]).
- **Agent-dependent structure (key-door).** Make the structural gating a function of the spacetime representation itself — a unit for "at the key at delay `δ`" disinhibits "through the door at delay `> δ`". This closes the loop that the wall-input mechanism leaves open.
- **Theory of mind by coupled STAs.** STA `A`'s reward input is STA `B`'s output and vice versa; the joint system relaxes to a fixed point where each agent's plan is optimal against the other's predicted plan. A neural implementation of recursive inverse planning, competing with [[wiki/entities/hbtom.md]]'s explicit Bayesian nesting.

**(brainstorm)** The transition-coding variant is more interesting than the paper's framing admits. Once units mean "move `s_i → s_j` at delay `δ`", the scaffold *is* a meta-graph and each environment is a mask over it — which is [[wiki/concepts/latent-graph-discovery.md]]'s two-level split realised in a single weight matrix, with the instance-graph held in inhibitory input rather than in a separate fast store. The open question the paper does not ask: where the superset comes from when the state space is not a grid, and whether a mask-per-environment can be *inferred* rather than observed.

**(brainstorm)** The STA also inverts the usual reading of the SR's failure mode. The SR fails on dynamic reward because it marginalises over time; the STA succeeds by *not* marginalising — it keeps one copy of the state space per timestep. That is a straight memory-for-flexibility trade, and it predicts a measurable signature: any system that can intercept a moving target must spend representational capacity proportional to its horizon. A reasoning model that plans over changing constraints therefore cannot be built on a single cached predictive map, however good.

---

## Comparison

| Model | Where the world model lives | How the future is used | Dynamic reward |
|---|---|---|---|
| **Spacetime attractor** | Copies of `A` in recurrent weights between delay-subspaces | Whole trajectory inferred simultaneously as a fixed point | ✓ per-timestep input |
| [[wiki/concepts/successor-representation.md]] | `S = Σ γⁿ Tⁿ`, time-marginalised | `v = Sr`, one product | ✗ |
| [[wiki/entities/tolman-eichenbaum-machine.md]] | Structural code `g` + sensory binding | One state at a time in a sequence | n/a |
| [[wiki/entities/cscg.md]] | Learned clone transition matrix | Condition on start and goal, infer the actions between | Reward not represented |
| [[wiki/entities/h-jepa.md]] | Learned encoder + predictor | Gradient descent on actions through an unrolled model | ✓ via the cost |
| [[wiki/entities/meta-rl-agent.md]] | Nowhere explicit — in LSTM dynamics | No explicit future | ✓ implicitly |
| [[wiki/entities/adaptive-cann.md]] | Ring/plane topology | Sweeps *one* state forward at a time | n/a |

---

## Connections

- **[[wiki/concepts/attractor-dynamics.md]]** — adds a design point neither axis covers: fixed points defined by a *scaffold that is a world model*, so a single settled state is a whole trajectory and the "attractors are nodes, not edges" limitation is lifted by adding a delay axis rather than an antisymmetric term.
- **[[wiki/concepts/simulation-based-planning.md]]** — the direct rival mechanism: planning by recognition instead of by rollout, which removes the rollout-control policy (G15) by construction and makes planning depth an anatomical constant rather than a scheduling decision.
- **[[wiki/concepts/successor-representation.md]]** — the model this one is built to beat: the SR marginalises occupancy over time and therefore cannot intercept a goal that moves *within* a trial, which is exactly the regime the STA claims for prefrontal cortex.
- **[[wiki/concepts/working-memory.md]]** — supplies the empirical substrate: concurrent prefrontal subspaces coding each step of a future sequence are reinterpreted as the state variable a planner relaxes, which unifies sequence maintenance and planning in one circuit.
- **[[wiki/entities/meta-rl-agent.md]]** — the theory this one extends by naming the mechanism: an RNN meta-trained on dynamic planning tasks turns out to implement an STA in its dynamics, so "PFC is a recurrent meta-learner" gains a specific inner algorithm instead of an opaque one.
- **[[wiki/concepts/meta-learning.md]]** — the same two-timescale split with the fast level made legible: structure in weights, per-trial reward and walls in inputs, adaptation entirely in dynamics.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — supplies the lesion-side motivation: prefrontal cortex is dispensable for stimulus–response and stable-reward behaviour but required for reversal and time-varying goals, which is the task boundary the STA reproduces computationally.
- **[[wiki/concepts/offline-replay.md]]** — the proposed teacher: replaying experienced trajectories from hippocampus into cortex is the only offered route to learning the many redundant copies of the adjacency matrix from one experience cache.
- **[[wiki/concepts/latent-graph-discovery.md]]** — an unusually literal instantiation: the meta-graph is a learned superset of transitions in the weights, the instance-graph is carved from it by inhibitory wall input, and path search is relaxation rather than search.
- **[[wiki/concepts/cognitive-map.md]]** — puts the map in prefrontal cortex rather than hippocampus and indexes it by *time to arrival*, so the same structural knowledge is stored once per planning step instead of once per state.
- **[[wiki/entities/fly-central-complex.md]]** — the borrowed part: the identity feed-forward term that shifts the plan by one step after each action is modelled on the fly's head-direction update neurons, making "conveyor belt" dynamics path integration along the delay axis.
- **[[wiki/entities/context-modular-memory-network.md]]** — the same gating logic on different content: a fixed weight matrix made environment-specific by deleting non-applicable connections from the dynamics, here transitions blocked by walls rather than memories outside the context.
- **[[wiki/entities/hbtom.md]]** — the competing theory-of-mind story: explicit Bayesian inverse planning with a posterior over utilities and rationality, versus two coupled attractors relaxing to a mutual best response.
- **[[wiki/concepts/abstract-structural-codes.md]]** — names the missing piece of the hierarchical extension: stacked STAs give exponential horizon only if some mechanism supplies the abstract state space, which this model assumes and does not build.
- **[[wiki/entities/h-jepa.md]]** — the machine-learning counterpart of the same goal: both plan by optimising over a learned model, one by gradient descent on action variables through an unrolled predictor, the other by relaxation of a network whose weights *are* the unrolled predictor.
- **[[wiki/concepts/energy-based-models.md]]** — the frame the model fits without invoking: the whole trajectory is the free variable and the plan is the configuration minimising a compatibility function whose terms are reward (input) and realisability (recurrence).
- **[[wiki/entities/trnn.md]]** — the direct counterweight to this page's attractor result: trained recurrent networks avoid fixed points on purely mnemonic delay tasks and win by doing so, so which mechanism training selects appears to depend on whether the objective is to hold an item or to satisfy constraints over a future trajectory ([[wiki/empirical-tensions.md]] T106).
- **[[wiki/entities/stsp-working-memory-rnn.md]]** — the other side of the same tension: fixed-weight networks that settle into point or line attractors on a delay task are fragile to synapse loss and less like recorded prefrontal populations, which this model's planning results do not contradict so much as bound ([[wiki/empirical-tensions.md]] T106).
- **[[wiki/entities/pfc-columnar-planning-model.md]]** — the same commitment (evaluate all futures in parallel in prefrontal cortex) reached by diffusion over a *distance* axis instead of relaxation over a *delay* axis; complementary failures, since only this page handles reward changing within the horizon and only the columnar model learns its own nodes and its own hierarchy (Martinet et al. 2011).
- **[[wiki/entities/adaptive-cann.md]]** — the sweeping alternative this model replaces: one bump moved forward through state space by an adaptation current, against one population per future timestep — a sweep schedule to control, versus a cost linear in horizon.
- **[[wiki/entities/cscg.md]]** — the other planning-by-inference model in the wiki, with the roles swapped: a learned clone transition matrix conditioned on start and goal infers actions sequentially, where copies of the adjacency matrix wired between delay-subspaces settle the whole sequence at once.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the same structural-code-plus-binding idea moved from *where am I* to *where will I be*: one state at a time in a sequence, versus one population per future timestep — which is what buys planning under a reward that changes within the horizon.
