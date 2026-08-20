# Temporal Abstraction and Options

**An option is an entire policy packaged as one selectable action — `o = ⟨I, π_o, β⟩` — so a single choice at the top level commits to a *variable-length* stretch of behaviour; that one move turns the Markov decision process into a semi-Markov one, and buys structured exploration and coarser credit assignment at the price of two problems it creates: where options come from, and which solutions they make unreachable.**

> **Provenance.** Botvinick, Niv & Barto 2009, *Hierarchically organized behavior and its neural foundations: a reinforcement learning perspective*, Cognition 113:262–280 (`raw/botvinick-2008-hierarchical-rl-behavior.md`). A review plus a new actor–critic implementation of Sutton, Precup & Singh's options framework, simulated on the four-rooms grid-world. Everything below is from that source unless marked.

---

## The formalism

| Object | Definition | What it adds over flat RL |
|---|---|---|
| **Option** `o` | `⟨I, π_o, β⟩` — initiation set `I ⊆ S`, option-specific policy `π_o : s → a` (where `a` may itself be an option), termination function `β` | A selectable item whose consequence is a *sequence*, not a step |
| **Root policy** | Selects among primitive actions **and** options with the same action-strength machinery | Hierarchy needs no separate selector — options are just extra arms |
| **Option prediction error** | `δ_o = [Σ_t γ^t r_t] + γ^k V(s_term) − V(s_init)`, computed **at termination** | Evaluation over a temporally extended event; the setting is a semi-Markov decision process (SMDP), not an MDP |
| **Pseudo-reward** | An internal reward delivered on reaching the option's *subgoal* state | The signal that shapes `π_o` when the external reward is silent |
| **Option-specific value function** `V_o(s)` | One value function per option, because both the pseudo-reward and the policy in force depend on which option is running | A flat `V` is *wrong*, not merely coarse, while an option is in control |

**Why temporal abstraction attacks the scaling problem — two separate mechanisms, routinely conflated:**

| | Mechanism | Effect in the four-rooms task |
|---|---|---|
| **Exploration** | An option's policy drives exploration down a committed partial path, so the tree is searched in chunks | A trajectory needing 7 independent primitive choices needs 2 option choices |
| **Credit assignment** | Learning updates happen only at option boundaries | Parameters adjusted at 2 decision points instead of 7 |

Both are *reductions in the number of independent decisions*, which is the only quantity temporal abstraction actually changes.

---

## Four extensions to the actor–critic, and their claimed neural addresses

The paper's contribution is that HRL is not an add-on module: it is four specific changes to an architecture the wiki already maps onto anatomy ([[wiki/entities/basal-ganglia.md]], [[wiki/entities/pbwm.md]]).

| # | Extension | Component | Proposed substrate | Supporting evidence cited |
|---|---|---|---|---|
| 1 | Represent *which option is in control*, and maintain it | Actor | Dorsolateral prefrontal cortex; also pre-SMA, premotor cortex | Task-set coding in DLPFC; guided-activation theory (an option identifier *selects* a policy implemented elsewhere rather than being one); rostral→caudal nesting of action levels |
| 2 | A separate set of action strengths **per option** | Actor | Dorsolateral striatum, gated by frontal input | DLS cells whose stimulus and action responses are task-context-dependent (the same grooming movement recruits different cells in isolation vs. within a sequence) |
| 3 | Option-specific value functions `V_o` | Critic | Orbitofrontal cortex — connected to both ventral striatum and DLPFC | OFC value coding shifts in parallel with strategy shifts |
| 4 | Prediction error scoped to the whole option | Critic | OFC (sustained reward prediction across extended task segments) + midbrain dopamine under an SMDP reading | OFC reward responses depend on the preceding wait time; SMDP accounts of dopamine responses to delayed reward |

**The distinctive prediction:** phasic dopamine at *subtask boundaries*, scaling with the option-level prediction error, and a reward-like response to **subgoal attainment** in structures responsive to exogenous reward. Untested at the time of writing; see T136 for why the prediction is framework-specific.

**The identifier/policy split is the load-bearing architectural claim.** Guided activation says prefrontal representations do not *contain* policies, they *select among* stimulus→response pathways elsewhere. That is exactly the option's split between its name (one vector, maintainable, gateable, composable) and its `π_o` (a big table, in the striatum). A machine hierarchy that stores the sub-policy inside the high-level representation loses this, and with it the ability to keep the upper level small.

---

## Negative transfer: the measured price of the wrong options

Two simulations on the same grid-world, and the second is the more damaging:

| Condition | Result |
|---|---|
| Options with **useless** subgoals (states adjacent to "windows" rather than doorways) | Learning is **slower than with primitive actions alone** — the agent spends its exploration inside committed suboptimal trajectories |
| Correct doorway options + a **new shortcut** opened between two rooms | Primitives only: the shortest path is found on 75% of runs. With the doorway options added: the agent converges on the doorway route and **ignores the passage completely** |

The second is not a slowdown but a *changed fixed point*: temporal abstraction prunes edges out of the effective graph, and an edge that no option traverses can stop being discovered even though it is still there and still primitive-reachable. This is the exploration benefit read with its sign reversed — commitment is the mechanism in both directions.

**(brainstorm)** This is the sharpest available statement of what hierarchy costs in the wiki's framing: an option set is a **hypothesis about the graph's bottlenecks**, and a wrong hypothesis is not a slower learner but a learner converging to the wrong path. It also gives a cheap diagnostic no HRL system reports — periodically run the primitive-only policy and compare returns; a persistent gap says the option set has closed off part of the graph. Related to, but stronger than, the negative transfer measured in [[wiki/entities/c-ts-model.md]], where a wrong task-set costs learning speed and not the solution.

---

## The option discovery problem

The paper's own conclusion is that this is HRL's central open problem, and it is the wiki's gap G33. Five families in the source, none settled, plus a sixth added by a later ingest:

| Family | Mechanism | What it needs that the wiki has |
|---|---|---|
| **Innate / evolved** | Options as genetically specified building blocks (rodent grooming syntax; motor primitives) | Nothing learned — the [[wiki/concepts/core-knowledge.md]] move applied to actions |
| **Trajectory statistics** | Record states/subsequences that recur in *rewarded* trajectories; frequent ones are bottlenecks and become subgoals | A visit-count store over successful paths; supported by human sensitivity to (hierarchical) sequence statistics |
| **Graph partitioning** | Build the state-transition graph explicitly, run a partitioning/clustering algorithm, take **access points between partitions** as subgoals | The state graph itself — i.e. this route consumes the output of [[wiki/concepts/latent-graph-discovery.md]] and returns a subgoal set |
| **Intrinsic motivation** | Unexpected salient events are intrinsically rewarding; the agent learns options that make them recur, and hierarchies of skills grow stepwise with no external task | A novelty/salience signal — the same midbrain dopamine cells that report reward prediction error also fire to salient novel stimuli. Matches infants' "circular reactions" |
| **Impasse- and socially-driven** | Soar-style: a subgoal is created when problem-solving hits an impasse, and the resolution is chunked. Or: infer subgoals from *observing others*, and receive them by teaching/shaping | Impasse detection; inverse planning ([[wiki/entities/hbtom.md]]) applied to recover another agent's subgoals rather than its goal |
| **Corpus compression (added by Harvey et al. 2026)** | Segment unlabelled *observation* trajectories into `K` recurring skills, collapse each episode to a symbol string, concatenate the corpus and run a grammar-induction algorithm; every production rule used at least twice is an option, and the parse tree is the hierarchy | Nothing the wiki does not have — no reward, no actions, no interaction, no transition graph. Subgoals are what *recurs across episodes*, not what bottlenecks; see [[wiki/entities/hisd.md]] |

**(brainstorm)** The graph-partitioning family is the one that closes a loop the wiki has left open on both ends. Latent graph discovery produces a transition graph and stops; hierarchical planning demands a subgoal decomposition and assumes one. Partitioning is the missing arrow between them, and it needs no new signal — bottleneck-ness is a property of the estimated adjacency alone, computable offline, and re-computable whenever the graph estimate changes. It also predicts the failure mode above: the partition is only as good as the graph estimate, so a shortcut discovered *after* options were compiled will not be reflected in them until the partition is redone. That makes "when to re-derive the option set" a scheduling problem for [[wiki/concepts/offline-replay.md]] rather than for the controller.

---

## Model-based HRL: option models

Temporal abstraction is presented in the cached/model-free setting, but transfers directly to search. An **option model** stores, for each option: the likely terminal state, the reward accrued during execution, and the *time* it takes. Equipped with these, look-ahead skips over long primitive sequences — search steps become saltatory, and the tree shrinks by the same factor exploration did. This is the mechanised form of the "jumpy, multi-scale planning" row in [[wiki/concepts/simulation-based-planning.md]], and it makes the option-duration term explicit, which the H-JEPA formulation ([[wiki/entities/h-jepa.md]]) does not carry.

---

## Where strict hierarchy fails

| Problem | Example | Why options cannot express it |
|---|---|---|
| **Shared structure across tasks** | spreading jam on bread / mustard on a hotdog / icing on a cake | Options are atomic; there is no representation of the partial overlap between three near-identical policies |
| **Context-sensitive subtasks** | picking up a pencil, with hand rotation depending on whether you will write or erase | A subtask that must know its parent's context is not a self-contained unit, so the levels stop being independent |
| **Generalisation to a new state** | — | Options key on *identical* states; two different situations calling for one policy cannot be merged (the complementary failure to [[wiki/entities/c-ts-model.md]], which clusters states and cannot extend in time) |

The paper's own verdict: human behaviour is **quasi**-hierarchical, and the same tension between compositionality and context-sensitivity has been noted inside HRL. **(brainstorm)** Every failure here is a failure to *factorize the option itself*: an option is a symbol with a policy attached rather than a point in a policy space, so nothing is shared between neighbours. The wiki's `g`/`x` split predicts the repair — represent an option as (abstract manoeuvre `g`, bound content `x`), which makes "spread X on Y" one option with slots and makes context-sensitivity a modulation of `x` rather than a violation of the hierarchy. Nothing in the source does this.

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| Option | A **compiled path** through the graph, reified as one edge between its initiation set and its termination set |
| Subgoal | A node the compiled edges point at — chosen for its position in the graph (bottleneck), not for its reward |
| Pseudo-reward | A locally supplied gradient that carves a path toward a node the global reward says nothing about |
| SMDP prediction error | Credit assigned over an edge of variable length, so the learner's time-step and the graph's edge stop being the same thing |
| Negative transfer | A compiled edge set that *hides* primitive edges, i.e. the option library becomes a lossy overlay on the graph rather than an index into it |
| Option model | The same compiled edge annotated with `(terminal state, accrued reward, duration)` — what makes coarse edges usable for search |

---

## Open problems

- **Option discovery is unsolved** and is the reason the framework's benefit cannot be claimed unconditionally (gap G33). Every family above either presupposes the graph, presupposes a task distribution, or presupposes a teacher.
- **Nothing sets the number or granularity of options**, the same unpinned quantity as the number of task-sets ([[wiki/entities/c-ts-model.md]]'s `α`) and the depth of the event hierarchy ([[wiki/concepts/event-segmentation.md]]).
- **Nothing decides when to *discard* an option.** The shortcut simulation shows a stale option library actively suppressing discovery, and no mechanism in HRL retires an option or re-derives the set.
- **Pseudo-reward may not exist.** The options and MAXQ frameworks give each subtask its own reward function; HAM has none, shaping subtask policies with exogenous reward plus fixed structural constraints. The frameworks therefore predict *different* dopamine signatures at subgoals, so the flagship neural prediction is not a prediction of HRL but of one of its variants ([[wiki/empirical-tensions.md]] T136).
- **The subtask-boundary coding evidence is indirect.** DLPFC task-set coding is established; discrete coding of *subtask segments within* a hierarchically structured task is not directly shown.
- **Hierarchy is asserted for the actor and left flat for the critic's substrate.** Option-specific value functions require one `V_o` per option; nothing says how OFC would index them, how many can coexist, or what happens on a switch — the same capacity question every fast store in the wiki dodges (gap G42).

---

## Connections

- **[[wiki/entities/vl-jepa.md]]** — the empirical shape an abstraction hierarchy is supposed to have, measured: at matched encoder, a coarser (sentence-embedding) prediction target loses to a finer (visual-feature) one at 1 s anticipation and wins by a margin that grows at every horizon out to 10 s, which is the case for temporal abstraction stated as a curve rather than as an argument.
- **[[wiki/concepts/simulation-based-planning.md]]** — supplies the missing content of that page's "jumpy, multi-scale planning" row twice over: an option model (terminal state, accrued reward, *duration*) is what lets search skip over primitive sequences, and the option-discovery families are the first candidate mechanisms for its "who sets the subgoals?" problem (gap G33).
- **[[wiki/concepts/latent-graph-discovery.md]]** — the two-way arrow: graph partitioning turns an estimated transition graph into a subgoal set with no new signal, and the negative-transfer result shows the traffic returns damaged — a compiled option library overlays the graph and can hide primitive edges from further discovery.
- **[[wiki/concepts/policy-abstraction-hierarchy.md]]** — the other axis of hierarchy, and the pair is exhaustive: that page's orders abstract over *rules* (a rule whose output names a rule) while options abstract over *time* (an action whose execution names a policy), with the same rostro-caudal frontal machinery claimed for both — so a builder must decide whether one stack serves both or two are needed.
- **[[wiki/entities/c-ts-model.md]]** — the complementary decomposition, stated by that model's own authors: HRL structures the action space in time and cannot cluster two different states onto one policy; C-TS structures the state space within a decision and cannot extend it in time. Their negative-transfer results also differ in kind — a wrong task-set costs speed, a wrong option set costs the solution.
- **[[wiki/entities/basal-ganglia.md]]** — the actor–critic anatomy this page extends: option-specific policies are proposed to live in dorsolateral striatum with frontal input selecting among them, which is the striatal side of the identifier/policy split and adds a *temporal* structuring of the same loops the model census already disputes.
- **[[wiki/entities/pbwm.md]]** — the mechanism for extension 1 that this page assumes and does not build: maintaining "which option is in control" is exactly a gated prefrontal stripe, and PBWM's basal-ganglia write-enable supplies the initiation/termination events the option framework needs a signal for.
- **[[wiki/concepts/event-segmentation.md]]** — the perceptual counterpart of an option boundary: segmentation cuts the *observed* stream where the event model breaks, options cut the *acted* stream where a subgoal is reached, and the two are only guaranteed to coincide if subgoals are chosen at predictability boundaries — which no discovery family above requires.
- **[[wiki/concepts/amortized-inference.md]]** — the option is a cached path, so temporal abstraction is amortisation applied to *action sequences* rather than to posteriors; and the uncertainty-arbitration rule it carries is what would decide whether a stale option is executed or re-planned, which HRL leaves unanswered.
- **[[wiki/entities/h-jepa.md]]** — the modern restatement, with one element added and one dropped: subgoals become learned costs rather than symbolic states (removing the need for a subgoal vocabulary), while the option's duration model and its termination function have no counterpart, so its levels are fixed time-scales rather than variable-length commitments.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the claim that periodic structural codes "decompose a state space in a way that exposes subgoals" gets its consumer here: bottleneck subgoals are what an option library is compiled from, so a structural code is only useful for hierarchy to the extent that its partition boundaries coincide with the graph's access points.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — options are the wiki's cleanest statement of what prior experience *is* in that page's formalism: a set of compiled partial paths, whose value on a new task is entirely determined by whether the new task's optimal trajectory passes through their subgoals — positive transfer and negative transfer from one and the same quantity.
- **[[wiki/concepts/compositionality.md]]** — the failure case that names the requirement: options cannot express the overlap between "spread jam on bread" and "spread icing on a cake" because an option is an atom with a policy attached rather than a composition of a manoeuvre with its arguments.
- **[[wiki/entities/hbtom.md]]** — the social route to option discovery, already mechanised in the wiki: inverse planning recovers another agent's goals from its trajectories, and applying it to *sub*-goals is how a learner would import an option library from a demonstrator instead of deriving one.
- **[[wiki/entities/hisd.md]]** — the sixth discovery family and the first built one: symbolise an unlabelled observation corpus by temporal action segmentation, run Sequitur over the strings, and take every rule used at least twice as an option — subgoals defined by *recurrence* instead of bottleneck-ness, with the option-of-options nesting this page permits but never constructs, and with the measured result that the nesting beats the same options used flat (Harvey et al. 2026).
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the circularity this page's discovery families sit inside: symbols discovered by effect-equivalence are defined over a *given* action repertoire, and options are policies over states those symbols define, so neither bootstraps the other and G4's vocabulary co-discovery reappears with an extra loop (Taniguchi et al. 2023).
- **[[wiki/entities/adaworld.md]]** — the missing input to every discovery family on this page, obtained without a repertoire: latent actions induce the primitive alphabet from unlabeled video, but they are strictly one-step edge labels with no temporal extent, so they supply what options are built *from* and say nothing about how long one lasts.
- **[[wiki/entities/v-jepa-2.md]]** — an option sequence compiled by hand and shown to be load-bearing: real-robot pick-and-place is three goal images on a fixed 4/10/4 step timetable with no termination detector, and it is what reduces the planner to horizon 1 — so the hand-authored decomposition is substituting for search depth, and the source lists the un-decomposed version as a task it cannot do (G33).
- **[[wiki/entities/hit-jepa.md]]** — the contrast case that isolates what a resolution hierarchy is not: its three levels are fixed ÷2 max-poolings with no termination condition, no variable-length commitment and no horizon differential, so the abstraction is coarse-graining of a sequence rather than temporal chunking of a policy — and it still buys out-of-distribution robustness, which no option formulation claims (Li et al. 2025).
- **[[wiki/concepts/cross-embodiment-transfer.md]]** — the orthogonal abstraction axis: options abstract over *how long* an action lasts, that page over *whose body* executes it; the robot-policy field's shared interfaces are all exactly one step long, so an options layer would sit above them with nothing in the wiki doing both (Kawaharazuka et al. 2025).
