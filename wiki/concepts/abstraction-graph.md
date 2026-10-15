# Abstraction Graph

**An abstraction graph is the sparse, lit subgraph of the world's derivation graph that a bounded agent holds: typed schemas with free variables as nodes, "derived from" with a premise set and a fidelity as the edge, ordered by generality, each node carrying an access cost, a precision, a suppression flag and a provenance pointer. It is what the meta-graph's vocabulary becomes when it is given depth and a budget, and the centre of this page is what holding one requires of an agent's architecture.**

> **Epistemic status — (brainstorm) throughout.** Assembled from a two-day brainstorming session (14–15 October 2026) and from wiki material, following the pattern of [[wiki/concepts/reasoning.md]]; no new source was ingested. Every empirical statement is cited to the page that carries it. The graph is an `L0` object — a description of what a bounded agent's competence looks like as if it held this structure — and makes no claim about how the structure is represented or learned. The one `L1` claim attached is that there is a cache and a deriver, with the cache's contents chosen under a budget ([[wiki/concepts/amortized-inference.md]]). Whether the graph is ever materialised is a separate question, and the one measured biological estimate answers it negatively for the metric slice: a predictive metric, not a topology (Garvert et al. 2017, [[wiki/concepts/latent-graph-discovery.md]]).

---

## Two graphs

| Object | Definition | Held by |
|---|---|---|
| **Derivation graph** (world side) | The closure of the world's axioms and building blocks under derivation: every schema derivable from them, every coarse-graining of their variables, and each coarse-graining's *true* error `ε` — zero exactly when the coarse-graining is computationally closed ([[wiki/concepts/computational-closure.md]]) | In full, only by the **generator-agent**: the world's own simulator, which predicts the whole next state exactly at unbounded cost. The formal ceiling of this page, as [[wiki/entities/aixi.md]] is the core framing's |
| **Abstraction graph** (agent side) | A lit subgraph of the derivation graph with the per-node attributes below and an *estimated* `ε` on each lossy edge. Per agent: shaped by what it has met and what it can afford | Any bounded agent. An efficient agent predicts the *relevant part* of the next state with bounded error at a small fraction of the generator's cost, using lossy schemas over coarse variables |

**Relation to the core framing.** [[wiki/concepts/latent-graph-discovery.md]]'s nodes are world states and its edges are transitions. The abstraction graph's nodes are that framing's *node types and edge labels*. So it sits over the core framing's vocabulary, which that page holds as a flat alphabet (hardness source 2) and which [[wiki/concepts/reasoning.md]] shows every operation-definition takes as given. It fills the open problem "multi-level hierarchy — making W itself a discoverable graph" and gap `G9`. The state graph is unchanged: it is the world.

**The base is finite, world-side.** Every learnable world has a finite base, because learnable means compressible ([[wiki/concepts/universal-induction.md]], read in reverse). Where the world contains other agents, their abstraction graphs are part of its base, so a theory of mind is a coarse model of another agent's lit set — which is where the edge-driver-latent benchmarks sit ([[wiki/entities/bib.md]], [[wiki/entities/agent-benchmark.md]]). Stochastic generators qualify; determinism is not assumed.

**Disambiguation.** On the compositional-generalisation pages ([[wiki/entities/cfq.md]], [[wiki/entities/scan.md]]) "derivation" names the per-instance parse tree, an instance-graph object. Here it names the relation between schemas.

---

## Nodes and edges

| Element | Definition | Consequence |
|---|---|---|
| **Node** | A typed proposition schema with free variables | A **concept** is a schema with a unary head (`fork(P, A, B)`); a **rule** has at least one free variable and a precondition; a **fact** has none. Facts are the shallow end, the leaves |
| **Edge** | "Derived from": a *premise set* → one conclusion (AND); a node may have several alternative derivations (OR) | The graph is an AND-OR graph. A derivation of `X` is an AND-tree rooted at `X`; its **premises** are the nodes where expansion stops. "Go down as far as needed" = expand toward deeper premises until every premise is lit |
| **Fidelity** | **Exact**: instantiate a variable, add a precondition, chain two schemas, unfold a definition. **Lossy**: replace variables by a coarse-graining of them; the conclusion then holds with error `ε` at that grain | Deduction, which the reasoning census says no wiki definition covers, lives on exact edges. Induction and discovery are lossy edges run upward: lighting a deep coarse rule from many shallow facts |
| **Direction** | General → specific throughout | Specialisation is instantiation. Inheritance: a rule applies to a concept and to all its specialisations, never to its generalisations |

**Worked case (chess).** `fork(P, A, B) ⟺ attacks(P, A) ∧ attacks(P, B) ∧ A ≠ B` is a concept derived *exactly* from the base predicates; unfold it and the movement rules are back. "Knight forks king and queen, queen unprotected → queen lost in two plies" is derivable from the movement rules plus "the king must leave check" by a long exact chain, and is one step once `fork` is lit. So a concept is a *named sub-derivation* that shortens every derivation through it — [[wiki/entities/dreamcoder.md]]'s library — which is why one can understand without articulating: the long chain exists whether or not the lemma is named. `material = Σ piece values` is a *chosen* coarse-graining, derived from nothing; "material advantage of two or more → likely win" is not derivable from the axioms by any exact chain, holds at the grain of `material` with some `ε`, and is the kind of node an efficient agent's graph is mostly made of.

---

## Three axes, not one

| Axis | Property of | Measures | Ordering comes from |
|---|---|---|---|
| **Generality** (deep / shallow) | a *schema* | how many situations its preconditions admit | derivation: specialising makes a schema shallower |
| **Grain** (coarse / fine) | a *variable* | how much of the state the many-one map discards | the coarse-graining lattice ([[wiki/concepts/computational-closure.md]]) |
| **Horizon** (long / short) | a *prediction* | how many generator steps ahead the conclusion is about | the generator |

Only generality orders the graph; grain and horizon are node attributes. Chess separates all three: the knight-move rule is deep, fine and one-ply; the material heuristic is deep, coarse and long; a memorised opening line is shallow, fine and medium; "opposite-coloured bishops draw" is mid-depth, coarse and long. Two correlations are statable as conjectures with a mechanism, and neither is a definition:

- **Long horizon selects coarse grain** — the "abstraction level = prediction horizon" claim of [[wiki/concepts/abstract-structural-codes.md]] is a *selection* claim on one attribute, not an identity between axes: train a representation to stay predictable far ahead and it discards what cannot be predicted far ahead.
- **Deep reaches coarse at bounded length** — at a bounded number of derivation steps a deep exact schema reaches only what is near it, so the cheap predictions from a deep-lit store are the coarse invariants. This is a budget consequence, which is why it looks like a definition from inside.

---

## Agent-side attributes

| Attribute | Meaning | Biological register |
|---|---|---|
| **Access cost** | What it costs to read the node now; a function of which store serves the read | Per store, table below |
| **Precision** | How far the node is trusted. Below one everywhere on the agent side: only the derivation graph holds truths. An exact derivation inherits its premises' precision; a lossy one adds `ε`. Updated by evidence, with the step scaled by expected information gained ([[wiki/concepts/synaptic-plasticity.md]]) | A register separate from strength, on a slower timescale ([[wiki/concepts/precision-weighting.md]]); accessibility declines while precision does not (`T392`) |
| **Suppressed** | A competing node is winning. Refutation never deletes | Extinction adds a second, context-limited association; weights become unreachable and reacquisition is fast; abandonment has its own channel ([[wiki/entities/lateral-habenula.md]], `G120`) |
| **Provenance** | The derivation that lit the node, or one of three leaf values: observed, told, innate | The hippocampus reinstates the *intermediary* of a composed edge at choice time (Barron et al. 2020, [[wiki/concepts/offline-replay.md]]) |

Derived states are computed, not stored: **conjectured** = low precision; **refuted** = suppressed; **forgotten** = access cost has risen, since storage is "effectively indelible" and forgetting is loss of address (`T392`, `T89`); **derivable-but-unlit** and **unreachable** fall out of the AND-OR expansion. **Innate** = installed with high precision at low access cost, a strong default and not a constraint — defeasible at the conceptual level through symbol systems ([[wiki/concepts/core-knowledge.md]], `T11`).

**The stores run in parallel, not as a ladder** (the `L1` evidence; every row second-hand from the page named).

| Holding state | Page | Gate in | Gate out | Hold cost | Read cost | Precision |
|---|---|---|---|---|---|---|
| Working memory, activity | [[wiki/concepts/working-memory.md]] | gated write | decay or addressed erase | continuous spiking | direct | partly graded |
| Working memory, silent (synaptic) | [[wiki/concepts/synaptic-plasticity.md]] | recent firing | ~1 s decay | ~free | a probe must recruit the trace | by firing |
| Labile episodic index | [[wiki/concepts/complementary-learning-systems.md]] | one shot (dendritic plateau) | "designed to be lost" in ~1 week | — | cue-dependent completion | threshold |
| Durable episodic index | [[wiki/concepts/generalization-optimized-consolidation.md]] | repetition or reward | — | — | same | threshold |
| Consolidated / semantic | [[wiki/concepts/recall-gated-consolidation.md]] | recurrence, or stop at minimum held-out error | overfitting past the optimum; interference | — | generalising read, via whichever module has lower error | graded, linear in repetitions |
| Habit | [[wiki/concepts/value-free-habit.md]] | execution frequency alone, no reward term | not weakened by extinction, only overridden | thousands of trials | deliberation → 0 | **stale**: keeps the old choice after the value flips (`T405`) |
| Ingrained synapse | [[wiki/concepts/continual-learning.md]] | repeated confirmation deepens a cascade | optogenetic erasure; writability moves both ways | — | — | graded |
| Innate | [[wiki/concepts/core-knowledge.md]] | evolution | defeasible conceptually | — | — | graded reading favoured |

Three facts against reading this as stages: the hippocampal trace stays for as long as the memory is retained at all ("transformation, not transfer", complementary learning systems); both basal-ganglia loops retain a complete policy, so automatisation is a change in which loop wins (`T131`); and habit is a *different quantity* — action frequency, not a more-consolidated value — so "practice makes automatic and refined" splits into two quantities, read cost falling and precision rising, that dissociate. The closest the wiki comes to the ladder, "a chain of three or more stores with successively stricter gates", is listed as unexplored on [[wiki/concepts/recall-gated-consolidation.md]].

---

## What gets lit

**The cache objective.** Light the nodes that maximise `frequency × value × derivation cost saved / memory`. Reward has one role: it weights the query. The four measured gates are each a one-sided approximation:

| Gate | Approximates | Page |
|---|---|---|
| Recurrence: write to the slow store iff the fast store already recalls it | frequency | [[wiki/concepts/recall-gated-consolidation.md]] |
| Stop promoting at minimum held-out error | frequency, through generalisation | [[wiki/concepts/generalization-optimized-consolidation.md]] |
| Execution frequency, no reward term | frequency | [[wiki/concepts/value-free-habit.md]] |
| Reward × confidence as the recall factor; offline composition only for the rewarded chain | value | [[wiki/concepts/recall-gated-consolidation.md]], [[wiki/concepts/offline-replay.md]] |

**Concept formation, in series.** Closure bounds the `ε` a coarse concept *can* have ([[wiki/concepts/computational-closure.md]]: lumpable ⟹ zero; [[wiki/concepts/emergent-macrostates.md]]: a level is worth keeping when its predictive efficiency beats the finer level's). The cache objective decides whether to *pay* for it at that `ε`, which is [[wiki/entities/dreamcoder.md]]'s compression step. Hence what gets internalised is chosen by convenience, not cleanliness: near-synonyms survive because the cache objective, not closure, decides, and some coarse concepts cannot be made reliable however convenient.

**Plasticity falls out of the node kind.** Ground facts (no free variables) are written in one shot; a schema with free variables needs many instances. That is the one-shot node rule against the many-shot edge rule on [[wiki/concepts/synaptic-plasticity.md]], where "requiring many exposures *is* the spuriousness filter".

**Budgets.** All priced by the opportunity-cost rate `λ` of [[wiki/concepts/resource-rationality.md]].

| Budget | Where it enters |
|---|---|
| Perception | The observation is a coarse-graining of the true state: the core framing's observation-map bit, with [[wiki/concepts/emergent-macrostates.md]]'s `f : Γ → Ξ` as the map |
| Memory | Number of lit nodes × per-store hold cost |
| Compute | Derivation steps per query; the exchange rate against accuracy is hand-set in every architecture that varies its own compute (`G107`) |
| Time | The world moves while the agent derives |
| Energy / action | Folded into `λ` |
| Ingraining | The per-store hold cost of lowering a node's access cost |
| Experience selection | Observation is free per unit and time-bounded, so which experience to seek is a priced choice ([[wiki/concepts/epistemic-value.md]], [[wiki/concepts/information-sampling-vs-search.md]], `G129`) |

---

## Scoring, and the two levels

- **The front.** An abstraction graph is a point on an accuracy-versus-compute front against the derivation graph: the error it incurs on the queries it faces per unit derivation it runs. Deep-lit (general, slow) and shallow-lit (fast, brittle) are two corners; at fixed memory the optimum is sparsely lit across depths. Nothing in the wiki scores a vocabulary this way.
- **The meta-graph, agent-side.** The lit schemas general enough to apply to every instance of a family. This is a second definition beside the core framing's world-side `θ_shared`, not a replacement; the difference between the two is the measurable quantity (what the agent is missing, or has over-specialised). Where no common lit ancestor exists the agent must light one, which is the core framing's discovery case. The stronger reading, meta-graph = the *lowest* common lit ancestor, is a conjecture.
- **Mapping onto W / M.** Schemas ↔ slow stores ↔ meta-graph; ground facts ↔ fast stores ↔ instance-graph. The named exception: ground facts consolidate (a capital city is a ground fact in the slow store), which is the price of relevance as the criterion.

---

## Understanding

**An agent understands a domain `D` to the extent that a small, deep, lit set `R` derives almost all of `D` within budget**, scored by `|R|`, the depth of `R`, and coverage of `D` against the derivation graph, estimated on the facts the agent knows.

| In words | In the graph |
|---|---|
| "The correct root cause(s)" | A small `R` of deep lit schemas: one for life (self-replication), three for economics and governance (human nature, game theory, every decision is a compromise) |
| "With enough context and time, explain almost everything about it" | Derivations from `R` to almost every fact of `D`, runnable within budget, with the instance's ground facts as context |
| "Correct framing", "like choosing the loss function" | Framing = choosing `R`. A candidate `R` is refuted when a derivation from it reaches a contradiction or an unbounded regress (an immortal adaptable being needs regulation of its regulation), or cannot reach known facts of `D` (any attribute of life other than replication fails to derive the others) |
| "It all clicks" | A compression event: connecting one node lights many derivations at once — the [[wiki/concepts/simplicity-principle.md]] (posit the hidden cause when the data compress better with it) and the richness protocol of [[wiki/concepts/causal-model-building.md]] (one representation answers classify, generate, explain) |
| "Almost": the boundary cases | Targets whose derivation runs through a coarse concept with large `ε` at that target's grain. "Makes copies of itself" is exact for a cell and lossy for a virus, since the copying needs host machinery. The residue is derived from the fidelity attribute, not stipulated |

Three qualifications, all from the attributes above:

- **Nothing is absolute.** `R` has a precision like every other node, and it is not derived bottom-up — no one derives the whole domain of life. It is *reinforced*: each new fact of `D` that `R` derives raises it, each contradiction lowers it, by a step scaled to surprise. "Forming a theory" is lighting a deep node at low precision.
- **Dissonance has a size.** The cost of revising `R` is the number of lit nodes whose provenance pointer runs back through `R`: its dependent cone. That is computable from the pointers and gives a prediction (P7 below).
- **Understanding is not compression.** `G26` says a short description need not expose structure ([[wiki/concepts/universal-induction.md]]); what separates the two is that the derivations from `R` must be *runnable by the agent*, which is the "with enough context and time" clause.

What this buys the rest of the wiki: a success criterion for framing, which [[wiki/concepts/reasoning.md]] records that R6 lacks (a framing is correct when its `R` covers `D`), and a use for the R7 perturbation tests ([[wiki/entities/gsm8k.md]], [[wiki/entities/math-perturb.md]]): a content swap tests whether the derivation, not the fact, is what is lit. It addresses only `G73`'s weaker demand — selecting among frames the agent already holds — and not the construction of one.

---

## Architectural requirements

The page's centre. Each row is forced by one feature of the graph together with one limit of the agent; the brain column names the candidate mechanism, the reference column names a computational model that approximated the row, as a worked example and not as a component.

| # | Requirement | Forced by | Brain candidate | Reference model | Status |
|---|---|---|---|---|---|
| 1 | Store items are typed schemas with free variables: relations held as objects | the node kind | role-filler codes ([[wiki/entities/esbn.md]], [[wiki/concepts/activity-slots.md]]) | ESBN; vector-symbolic binding | `G104`: the role is a slot, not a type addressable apart from its filler |
| 2 | A binder that instantiates free variables from the instance's context | exact edge: instantiate | hippocampal conjunctive binding | [[wiki/concepts/vector-symbolic-binding.md]] | roles stop being separately addressable once bound |
| 3 | Variable-length chaining: an inference-time loop whose length is set by the query | derivation length is query-dependent | prefrontal–basal-ganglia loop; working-memory control | [[wiki/concepts/adaptive-computation-time.md]], [[wiki/entities/universal-transformer.md]] | the step price is hand-set (`G107`) |
| 4 | A lossy abstraction operator with an error register per coarse concept | lossy edges | cortical coarse-graining; precision as gain | closure as the criterion ([[wiki/concepts/computational-closure.md]]) | nothing tracks `ε` per concept |
| 5 | Access cost and precision as separate registers over parallel stores | the attributes | the store table above; [[wiki/concepts/precision-weighting.md]] | arbitration by posterior variance (Daw 2005, [[wiki/concepts/amortized-inference.md]]) | `T392` |
| 6 | A context-gated suppressor for refuted nodes | suppressed, never deleted | extinction as a second association; infralimbic cortex; [[wiki/entities/lateral-habenula.md]] | none | `G120` |
| 7 | A cache policy approximating `frequency × value × cost saved / memory` | the cache objective | consolidation gates; [[wiki/concepts/replay-prioritisation.md]]; habit | DreamCoder's compression; prioritised sweeping | no implementation of the full objective (`T81`) |
| 8 | An AND-OR controller: choose the branch to expand, stop at lit premises | framing = choosing `R` | prefrontal control; commitment by [[wiki/concepts/evidence-accumulation.md]] | AND-OR search; tree search in [[wiki/entities/alphazero.md]] | `G73`'s weaker demand only |
| 9 | A provenance pointer per lit node | the attributes | reinstatement of the intermediary ([[wiki/concepts/offline-replay.md]]) | none | no model has it |
| 10 | Experience selection priced by `λ` | the budget table | [[wiki/concepts/epistemic-value.md]]; [[wiki/concepts/information-sampling-vs-search.md]] | the novelty term of expected free energy | `G129` |
| 11 | One-shot write for ground facts, many-shot for schemas | node kind + the W / M mapping | BTSP vs STDP ([[wiki/concepts/synaptic-plasticity.md]]) | [[wiki/entities/btsp-cam.md]] | built |
| 12 | Precondition check at the stated grain before a schema is applied | inheritance + `ε` | option initiation sets ([[wiki/concepts/temporal-abstraction-options.md]]); event schemas ⟨precondition, transition, effect⟩ ([[wiki/concepts/event-segmentation.md]]) | the initiation set `I` | partly built |
| 13 | A slow store carrying the agent-side meta-graph across episodes | the two levels | cortex ([[wiki/concepts/complementary-learning-systems.md]]) | [[wiki/entities/tolman-eichenbaum-machine.md]] | built |

---

## Tests and open problems

**Tests attached to rows.**

| Test | Row | Instrument |
|---|---|---|
| P1: at fixed memory, error on novel queries trades against derivation steps along a front bounded by the generator | scoring | ponder-step counts against accuracy ([[wiki/concepts/adaptive-computation-time.md]], [[wiki/entities/universal-transformer.md]]) |
| P4: ground facts light in one shot; a schema with `k` free variables needs many instances, rising with `k` | 11 | the one-shot / many-shot plasticity split; sample-complexity curves across PGM-style regimes |
| P5: an agent whose lit set holds the family's common ancestors shows the `O(V)` saving; a shallow-lit agent shows `O(E)` | 13 | nodes-visited against edges-taken curves ([[wiki/entities/tolman-eichenbaum-machine.md]]) |
| P6: perturbation invariance holds for nodes lit by derivation and fails for nodes lit by observation or testimony | 9 | R7 tests with provenance recorded ([[wiki/entities/gsm8k.md]], [[wiki/entities/math-perturb.md]]) |

**Open problems.**

- **P2, no instrument.** The probability a hypothesis is entertained should decay with its derivation distance from the lit set: confirmation bias as a budget effect, since searching from lit nodes is cheaper than from the trunk.
- **P3, no direct instrument.** At bounded derivation length, deep schemas yield only coarse predictions; closure's per-level predictive-information shares are the nearest quantity.
- **P7, no instrument.** Resistance to revising a belief grows with the size of its dependent cone.
- **Nothing tracks `ε` per coarse concept**, in any model or any measurement (row 4). The `ε = 0` case coincides with the interpretability literature's notion of a valid causal abstraction (interventions commute between a coarse and a fine model), which is absent from the wiki and is an acquisition target.
- **Whether the generality ordering is computable by the agent.** "Down" is implicit in provenance pointers; choosing a *deep* `R` for framing needs an estimate of depth, and coverage is the only candidate here.
- **The precision propagation rule is stated qualitatively** (inherits, plus `ε`) and no formula is committed to.
- **Elegance is deliberately not defined.** "A short derivation from a deep premise" is a pair (premise depth, tree size) that could be reported per derivation; it is left out as a human preference the requirements do not need.

---

## How this page is used

The direction of derivation is: the world's structure plus the agent's limits ⇒ the graph ⇒ the requirements table ⇒ brain candidates per row ⇒ reference models as worked examples. It is run from both ends at once — from the problem (the world, the benchmarks) and from the solution (the brain) — looking for a path between them, which is the `L0 → L1 → L2` ladder of the schema with the realisation found last. The wiki's computational models are references for how a row was approximated, each reproducing a few properties of one region with many compromises, and not components to be assembled; the programme is to understand the connections and mechanisms of the regions a row names and replicate each as closely as possible.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — the framing this page sits over: its nodes are that page's node types and edge labels, its state graph is untouched, and it fills that page's "multi-level hierarchy" open problem and `G9` with an ordered, budget-selected vocabulary instead of a flat alphabet.
- **[[wiki/concepts/reasoning.md]]** — supplies two things that census lacks: a definition of deduction (the exact edges) and a success criterion for R6 (a framing is correct when its chosen root set covers the domain), and uses its R7 tests to separate a lit derivation from a lit fact.
- **[[wiki/concepts/abstraction.md]]** — this page's generality axis is that census's O-family (a rule's distance from an action) given a graph, and its lossy edge is Courellis et al.'s compression definition with the discarded detail priced by `ε`.
- **[[wiki/concepts/abstract-structural-codes.md]]** — that page's "abstraction level = prediction horizon" is read here as a selection claim on one of three axes (long horizon selects coarse grain), not as the ordering of the graph.
- **[[wiki/concepts/problem-framing.md]]** — framing is choosing the root set `R` to expand from, which answers `G73`'s weaker demand (select among held frames) and leaves its stronger one (construct a frame) untouched.
- **[[wiki/concepts/amortized-inference.md]]** — the one `L1` claim this page makes is that page's: a cache and a deriver, with the cache's contents the thing this page's objective selects; its arbitration by posterior variance is the reference for row 5.
- **[[wiki/concepts/resource-rationality.md]]** — prices every budget in this page's table by the same opportunity-cost rate, and supplies the objection this page inherits: the cost–benefit computation lives in the outer loop, so the cache policy is learned, not run.
- **[[wiki/concepts/computational-closure.md]]** — bounds the error a lossy edge can have: a coarse-graining that is computationally closed has `ε = 0`, and the conditional mutual information that measures the failure is the error register row 4 asks for.
- **[[wiki/concepts/simplicity-principle.md]]** — the "it clicks" event of understanding is that page's criterion: a hidden cause is posited when the data compress better with it, here as one node lighting many derivations at once.
- **[[wiki/concepts/recall-gated-consolidation.md]]** — its recurrence gate is the frequency-side approximation to this page's cache objective, and its open problem (a chain of stores with successively stricter gates) is the nearest the wiki comes to the permanence ladder this page rejects in favour of parallel stores.
- **[[wiki/concepts/value-free-habit.md]]** — the row that breaks the ladder: a habit is cheap to read and stale, so automaticity and precision are two attributes here rather than one, and execution frequency is a reward-free gate on the frequency side of the objective.
- **[[wiki/concepts/precision-weighting.md]]** — the biological register for this page's precision attribute, separate from strength and slower, which is what lets a node be trusted while its access cost rises.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the one-shot node rule against the many-shot edge rule is this page's node kind in plasticity terms: ground facts in one shot, schemas with free variables over many instances; and the information-scaled step is the update rule its precision attribute assumes.
- **[[wiki/concepts/core-knowledge.md]]** — innate schemas as nodes installed at high precision and low access cost, strong defaults rather than constraints, which is why no immutability bit is carried.
- **[[wiki/concepts/program-induction.md]]** — the library is an abstraction graph built by a cache-like objective (DreamCoder's compression step), which is the reason this page does not claim a fourth unbuilt component; what the library lacks is lossy edges and a stated budget.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the parallel-stores evidence ("transformation, not transfer") that replaces a permanence ladder with per-store hold and read costs, and the slow store row 13 names.
- **[[wiki/concepts/epistemic-value.md]]** — the price of the experience-selection budget: observation is free per unit and time-bounded, so which experience to seek is that page's quantity spent at the rate `λ`.
- **[[wiki/concepts/causal-model-building.md]]** — its richness protocol is the behavioural face of understanding as defined here: one root set answering classify, generate and explain is one `R` with high coverage, and a shortcut rule is a lit fact with no derivation behind it.
