# Abstraction Graph

**An abstraction graph is the sparse, lit subgraph of the world's derivation graph that a bounded agent holds: typed schemas with free variables as nodes, "derived from" with a premise set and a fidelity as the edge, ordered by generality, each node carrying a grain and a horizon on the world side and, on the agent side, an access cost, a precision, a suppression flag and a provenance pointer. It is what the meta-graph's vocabulary becomes when it is given depth and a budget, and the centre of this page is what holding one requires of an agent's architecture.**

> **Epistemic status — (brainstorm) throughout.** Assembled from a two-day brainstorming session (14–15 October 2026) and from wiki material, following the pattern of [[wiki/concepts/reasoning.md]]; no new source was ingested. Every empirical statement is cited to the page that carries it. The derivation graph is the world's hidden rule structure. The abstraction graph is an `L0` description of how an ideal bounded agent would internalise and compress that structure — what its competence looks like as if it held such a subgraph — and not a claim that any agent, the brain included, materialises it or recovers the hidden structure exactly. The one measured biological graph estimate shows what to expect instead: on the core framing's state graph the brain holds a predictive metric, not the topology (Garvert et al. 2017, [[wiki/concepts/latent-graph-discovery.md]]), whatever serves prediction rather than the structure itself, and the same should be expected one level up. The page's `L1` content is the requirements table below: fourteen constraints a decomposition must meet to hold the graph, each naming a component kind (a binder, a variable-length loop, a suppressor, an AND-OR controller) without committing to a realisation. The one `L1` decomposition assumed outright is a cache and a deriver, with the cache's contents chosen under a budget ([[wiki/concepts/amortized-inference.md]]). Where the page adopts one side of a `LIVE` tension it says so at the point of use (`T392` Position A, `T131` Position B).

---

## Two graphs

| Object | Definition | Held by |
|---|---|---|
| **Derivation graph** (world side) | The closure of the world's axioms and building blocks under derivation: every schema derivable from them, every coarse-graining of their variables, and each coarse-graining's *true* error `ε` — zero exactly when the coarse-graining is computationally closed ([[wiki/concepts/computational-closure.md]]) | In full, only by the **generator-agent**: the world's own simulator, which predicts the whole next state exactly at unbounded cost. The formal ceiling of this page, as [[wiki/entities/aixi.md]] is the core framing's |
| **Abstraction graph** (agent side) | A lit subgraph of the derivation graph with the per-node attributes below and an *estimated* `ε` on each lossy edge. Per agent: shaped by what it has met and what it can afford | Any bounded agent. An efficient agent predicts the *relevant part* of the next state with bounded error at a small fraction of the generator's cost, using lossy schemas over coarse variables |

**Relation to the core framing.** [[wiki/concepts/latent-graph-discovery.md]]'s nodes are world states and its edges are transitions. The abstraction graph's nodes are that framing's *node types and edge labels*. So it sits over the core framing's vocabulary, which that page holds as a flat alphabet (hardness source 2) and which [[wiki/concepts/reasoning.md]] shows every operation-definition takes as given. It fills the open problem "multi-level hierarchy — making W itself a discoverable graph" and gap `G9`. The state graph is unchanged: it is the world.

**Where the state graph is held is not assumed.** The requirements table names a brain candidate per row and takes no side on which tissue holds the instance graph the candidates operate on: `T28` (map or index, `LEANING` toward a map where no cortical structure applies and an index once one does), `T107` (hippocampal formation or cortical controller, `LIVE`), `T203` (abstract format hippocampal or shared, `LIVE`). The solution-side pages read against this table do take a side, and say so: [[wiki/entities/medial-prefrontal-cortex.md]]'s reading in the core framing assumes the subgraphs are hippocampal and the ventral tier selects among them (`T107` Position A), and [[wiki/concepts/schema-assimilation.md]]'s `cue → PFC selects schema → HPC retrieves the path` assumes the same. The rows below survive either answer; what moves with it is which row's brain candidate is a store and which is a reader.

**The base is finite, world-side.** Every learnable world has a finite base, because learnable means compressible ([[wiki/concepts/universal-induction.md]], read in reverse). Where the world contains other agents, their abstraction graphs are part of its base, so a theory of mind is a coarse model of another agent's lit set — which is where the edge-driver-latent benchmarks sit ([[wiki/entities/bib.md]], [[wiki/entities/agent-benchmark.md]]). Stochastic generators qualify; determinism is not assumed.

**Disambiguation.** On the compositional-generalisation pages ([[wiki/entities/cfq.md]], [[wiki/entities/scan.md]]) "derivation" names the per-instance parse tree, an instance-graph object. Here it names the relation between schemas.

---

## Nodes and edges

| Element | Definition | Consequence |
|---|---|---|
| **Node** | A typed proposition schema with free variables | A **concept** is a schema with a unary head (`fork(P, A, B)`); a **rule** has at least one free variable and a precondition; a **fact** has none. Facts are the shallow end: the most specific nodes, with nothing derived from them |
| **Edge** | "Derived from": a *premise set* → one conclusion (AND); a node may have several alternative derivations (OR) | The graph is an AND-OR graph. A derivation of `X` is an AND-tree rooted at `X`; its **premises** are the nodes where expansion stops. "Go down as far as needed" = expand toward deeper premises until every premise is lit |
| **Fidelity** | **Exact**: instantiate a variable, add a precondition, chain two schemas, unfold a definition. **Lossy**: replace variables by a coarse-graining of them; the conclusion then holds with error `ε` at that grain | Deduction, which the reasoning census says no wiki definition covers, lives on exact edges. Induction and discovery are not a third edge kind: they light a deep node from many shallow lit facts, its edges to those facts staying exact instantiations, with the uncertainty carried as the new node's precision (below), not as `ε`. **Exact is a formal kind, not a neural one.** The one lesion series that tests deduction and analogy together separates items by how many mutually irreducible structures a step must hold at once (indeterminate against determinate syllogisms), not by validity (Mole et al. 2025, [[wiki/entities/lateral-frontoparietal-network.md]], [[wiki/concepts/reasoning.md]]); the quantity the anatomy sees is row 14 of the requirements table, which cuts across exact and lossy |
| **Direction** | General → specific throughout. Convention: deep is *down*, so derivation runs upward from premises to conclusion and expansion runs downward from a conclusion to its premises; induction lights a node further down | Specialisation is instantiation. Inheritance: a rule applies to a concept and to all its specialisations, never to its generalisations |

**Worked case (chess).** `fork(P, A, B) ⟺ attacks(P, A) ∧ attacks(P, B) ∧ A ≠ B` is a concept derived *exactly* from the base predicates; unfold it and the movement rules are back. "Knight forks king and queen, queen unprotected → queen lost in two plies" is derivable from the movement rules plus "the king must leave check" by a long exact chain, and is one step once `fork` is lit. So a concept is a *named sub-derivation* that shortens every derivation through it — [[wiki/entities/dreamcoder.md]]'s library — which is why one can understand without articulating: the long chain exists whether or not the lemma is named. `material = Σ piece values` is a *chosen* coarse-graining of the piece-position variables, a lossy edge with no exact chain behind it; "material advantage of two or more → likely win" is not derivable from the axioms by any exact chain, holds at the grain of `material` with some `ε`, and is the kind of node an efficient agent's graph is mostly made of.

---

## Three axes, not one

| Axis | Property of | Measures | Ordering comes from |
|---|---|---|---|
| **Generality** (deep / shallow) | a *schema* | how many situations its preconditions admit | derivation: specialising makes a schema shallower |
| **Grain** (coarse / fine) | a *variable* | how much of the state the many-one map discards | the coarse-graining lattice ([[wiki/concepts/computational-closure.md]]) |
| **Horizon** (long / short) | a *prediction* | how many generator steps ahead the conclusion is about | the generator |

Only generality orders the graph; grain and horizon are node attributes. Chess separates all three: the knight-move rule is deep, fine and one-ply; the material heuristic is deep, coarse and long; a memorised opening line is shallow, fine and medium; "opposite-coloured bishops draw" is mid-depth, coarse and long.

**Two caveats on the grain axis.** Its floor is the causal-state partition, the coarsest partition that loses nothing about the future, with an asymmetry: a predictor may over-split it at zero loss but never over-merge ([[wiki/concepts/causal-states.md]]). And the axis assumes a coarse variable is a partition. Some systems have finite linear dimension and no finite node set ([[wiki/concepts/predictive-state-representations.md]]); for those the coarse variable is a vector of test predictions and its grain is a rank, not a cell count.

Two correlations are statable as conjectures with a mechanism, and neither is a definition:

- **Long horizon selects coarse grain** — the "abstraction level = prediction horizon" claim of [[wiki/concepts/abstract-structural-codes.md]] is a *selection* claim on one attribute, not an identity between axes: train a representation to stay predictable far ahead and it discards what cannot be predicted far ahead. Against it: sufficiency for the *whole* future needs a finer partition as the horizon grows ([[wiki/concepts/causal-states.md]], the fixed-horizon remark). The two reconcile because the predictable information shrinks with horizon while the distinctions needed to keep all of it grow, so the conjecture is about what a bounded representation keeps, not about the sufficient partition.
- **Deep reaches coarse at bounded length** — at a bounded number of derivation steps a deep exact schema reaches only what is near it, so the cheap predictions from a deep-lit store are the coarse invariants. This is a budget consequence, which is why it looks like a definition from inside.

---

## Agent-side attributes

| Attribute | Meaning | Biological register |
|---|---|---|
| **Access cost** | What it costs to read the node now; a function of which store serves the read | Per store, table below |
| **Precision** | How far the node is trusted. Below one everywhere on the agent side: only the derivation graph holds truths. An exact derivation inherits its premises' precision; a lossy one adds `ε`. Updated by evidence, with the step scaled by expected information gained ([[wiki/concepts/synaptic-plasticity.md]]) | A register separate from strength, on a slower timescale ([[wiki/concepts/precision-weighting.md]]); accessibility declines while precision does not (`T392`) |
| **Suppressed** | A competing node is winning. Refutation never deletes | Extinction adds a second, context-limited association; weights become unreachable and reacquisition is fast; abandonment has its own channel ([[wiki/entities/lateral-habenula.md]]) |
| **Provenance** | The derivation that lit the node, or one of three terminal values: observed, told, innate. The registry already asks for this: `G71`, a generated inference is never tagged as one | The hippocampus reinstates the *intermediary* of a composed edge at choice time (Barron et al. 2020, [[wiki/concepts/offline-replay.md]]) |

Derived states are computed, not stored: **conjectured** = low precision; **refuted** = suppressed; **forgotten** = access cost has risen. This adopts Position A of `T392`, a `LIVE` row: forgetting is loss of address, not of the trace. The gate-out column of the store table below lists Position B's mechanisms (decay, addressed erase, an index "designed to be lost"), and under A each of those raises access cost rather than deleting; **derivable-but-unlit** and **unreachable** fall out of the AND-OR expansion. **Innate** = installed with high precision at low access cost, a strong default and not a constraint — defeasible at the conceptual level through symbol systems ([[wiki/concepts/core-knowledge.md]], `T11`).

**The stores run in parallel, not as a ladder** (the `L1` evidence; every row second-hand from the page named).

| Holding state | Page | Gate in | Gate out | Hold cost | Read cost | Precision |
|---|---|---|---|---|---|---|
| Working memory, activity | [[wiki/concepts/working-memory.md]] | gated write | decay or addressed erase | continuous spiking | direct | partly graded |
| Working memory, silent (synaptic) | [[wiki/concepts/synaptic-plasticity.md]] | recent firing | ~1 s decay | ~free | a probe must recruit the trace | by firing |
| Labile episodic index | [[wiki/concepts/complementary-learning-systems.md]] | one shot (dendritic plateau) | "designed to be lost" in ~1 week | — | cue-dependent completion | threshold |
| Durable episodic index | [[wiki/concepts/generalization-optimized-consolidation.md]] | repetition or reward | — | — | same | threshold |
| Way-station: the controller's template (ventromedial prefrontal in human, medial prefrontal in rat) | [[wiki/concepts/schema-assimilation.md]], [[wiki/entities/medial-prefrontal-cortex.md]] | the mapping among codes the controller already holds, written in a ~2 h post-task window and over ~2 weeks (Euston et al. 2012); engaged by conflict with stored structure, not by age | the specific associate leaves for ventrolateral prefrontal and anterior temporal cortex at ~3 months while the template function stays (Gilboa & Marlatte 2017) | — | selects among what the fast store returns; sets gain over posterior stores before the input arrives | by integration demand; the one store that is required at retrieval and not at encoding |
| Consolidated / semantic | [[wiki/concepts/recall-gated-consolidation.md]] | recurrence, or stop at minimum held-out error | overfitting past the optimum; interference | — | generalising read, via whichever module has lower error | graded, linear in repetitions |
| Habit | [[wiki/concepts/value-free-habit.md]] | execution frequency alone, no reward term; thousands of trials | not weakened by extinction, only overridden | — | deliberation → 0 (measured as `VPI < R̄τ`, Keramati et al. 2011, [[wiki/concepts/amortized-inference.md]]) | **stale**: keeps the old choice after the value flips (`T405`); the rival reading is a value cache whose backup has not yet run, repaired by rest ([[wiki/concepts/computational-reuse.md]]) |
| Ingrained synapse | [[wiki/concepts/continual-learning.md]] | repeated confirmation deepens a cascade | optogenetic erasure; writability moves both ways | — | — | graded |
| Innate | [[wiki/concepts/core-knowledge.md]] | evolution | defeasible conceptually | — | low (installed) | high at install, revisable (`T11`) |

Three observations against reading this as stages: the hippocampal trace stays for as long as the memory is retained at all ("transformation, not transfer", complementary learning systems); on Position B of `T131` (migration, a `LIVE` row supported for stimulus→response skills while motor sequences favour distillation), both basal-ganglia loops retain a complete policy, so automatisation is a change in which loop wins; and habit is a *different quantity* — action frequency, not a more-consolidated value — so "practice makes automatic and refined" splits into two quantities, read cost falling and precision rising, that dissociate. The closest the wiki comes to the ladder, "a chain of three or more stores with successively stricter gates", is listed as unexplored on [[wiki/concepts/recall-gated-consolidation.md]].

---

## What gets lit

**The cache objective.** Light the nodes that maximise `frequency × value × derivation cost saved / memory`. Reward has one role: it weights the query. The objective is a memo-table policy in the sense of [[wiki/concepts/computational-reuse.md]], whose three design issues map onto this page one to one: *generalisation* (how an entry serves a query it was not computed for) is the free variable, *persistence* is access cost, *decomposition* (whole answer or sub-solution) is concept against fact. The four measured gates are each a one-sided approximation:

| Gate | Approximates | Page |
|---|---|---|
| Recurrence: write to the slow store iff the fast store already recalls it | frequency | [[wiki/concepts/recall-gated-consolidation.md]] |
| Stop promoting at minimum held-out error | frequency, through generalisation | [[wiki/concepts/generalization-optimized-consolidation.md]] |
| Execution frequency, no reward term | frequency | [[wiki/concepts/value-free-habit.md]] |
| Reward × confidence as the recall factor; offline composition only for the rewarded chain | value | [[wiki/concepts/recall-gated-consolidation.md]], [[wiki/concepts/offline-replay.md]] |

**Concept formation, in series.** Closure bounds the `ε` a coarse concept *can* have ([[wiki/concepts/computational-closure.md]]: lumpable ⟹ zero; [[wiki/concepts/emergent-macrostates.md]]: a level is worth keeping when its predictive efficiency beats the finer level's). The cache objective decides whether to *pay* for it at that `ε`, which is [[wiki/entities/dreamcoder.md]]'s compression step. Hence what gets internalised is chosen by convenience, not cleanliness: near-synonyms survive because the cache objective, not closure, decides, and some coarse concepts cannot be made reliable however convenient.

**Plasticity falls out of the node kind.** Ground facts (no free variables) are written in one shot; a schema with free variables needs many instances. That is the one-shot node rule against the many-shot edge rule on [[wiki/concepts/synaptic-plasticity.md]], where "requiring many exposures *is* the spuriousness filter".

**Budgets.** All priced by the opportunity-cost rate `λ` of [[wiki/concepts/resource-rationality.md]]. `λ` has units: as the inverse temperature `β` of [[wiki/concepts/thermodynamic-bounded-rationality.md]] it is a sample count, and that page gives the outer-loop objection (the cost–benefit is learned, not run) its mechanism: the agent does not reason about its constraint, it derives until the resource runs out. The alternative to a price is an aspiration level, a stopping rule for derivation that drifts with how hard success is to reach ([[wiki/concepts/satisficing.md]]). This page prices every budget by `λ` and inherits the outer-loop objection with it; the aspiration level is the `G107` answer that needs no exchange rate, and it is not used here.

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

- **The front.** An abstraction graph is a point on an accuracy-versus-compute front against the derivation graph: the error it incurs on the queries it faces per unit derivation it runs. This is bounded optimality (Russell & Subramanian 1995, [[wiki/concepts/resource-rationality.md]]): optimise over programs for a machine, not over actions, and the lit set is the program. Deep-lit (general, slow) and shallow-lit (fast, brittle) are two corners; at fixed memory the optimum is sparsely lit across depths. Nothing in the wiki scores a vocabulary this way.
- **The meta-graph, agent-side.** The lit schemas general enough to apply to every instance of a family. This is a second definition beside the core framing's world-side `θ_shared`, not a replacement; the difference between the two is the measurable quantity (what the agent is missing, or has over-specialised). Where no common lit ancestor exists the agent must light one, which is the core framing's discovery case. The stronger reading, meta-graph = the *lowest* common lit ancestor, is a conjecture.
- **Mapping onto W / M.** Schemas ↔ slow stores ↔ meta-graph; ground facts ↔ fast stores ↔ instance-graph. The named exception: ground facts consolidate (a capital city is a ground fact in the slow store), which is the price of relevance as the criterion. **The exception is biology's main measured case, not a corner.** What consolidates into the medial prefrontal controller is exactly a ground-fact mapping, context + event → response, with the vocabulary of codes already in the controller at acquisition (Euston et al. 2012, [[wiki/entities/medial-prefrontal-cortex.md]]); the specific associate then leaves the ventromedial template for ventrolateral prefrontal and anterior temporal cortex at three months ([[wiki/concepts/schema-assimilation.md]]). So the slow store is reached in two stages through a way-station, which the store table carries as its own row, and the clean "schemas slow, facts fast" split is the limit the measured trajectory tends to, not the trajectory.

---

## Understanding

**An agent understands a domain `D` to the extent that a small, deep, lit set `R` derives almost all of `D` within budget**, scored by `|R|`, the depth of `R`, and coverage of `D` against the derivation graph, estimated on the facts the agent knows.

| In words | In the graph |
|---|---|
| "The correct root cause(s)" | A small `R` of deep lit schemas: one for life (self-replication), three for economics and governance (human nature, game theory, every decision is a compromise) |
| "With enough context and time, explain almost everything about it" | Derivations from `R` to almost every fact of `D`, runnable within budget, with the instance's ground facts as context |
| "Correct framing", "like choosing the loss function" | Framing = choosing `R`. A candidate `R` is refuted when a derivation from it reaches a contradiction or an unbounded regress (an immortal adaptable being needs regulation of its regulation), or cannot reach known facts of `D` (any attribute of life other than replication fails to derive the others) |
| "It all clicks" | A compression event: connecting one node lights many derivations at once — the [[wiki/concepts/simplicity-principle.md]] (posit the hidden cause when the data compress better with it) and the richness protocol of [[wiki/concepts/causal-model-building.md]] (one representation answers classify, generate, explain). A competing account: abrupt learning is a model-class property, an unbounded-capacity class with a wide prior stalls and then collapses onto the truth with no uniform `N`, and no compression event is needed ([[wiki/concepts/predictive-information.md]]) |
| "Almost": the boundary cases | Targets whose derivation runs through a coarse concept with large `ε` at that target's grain. "Makes copies of itself" is exact for a cell and lossy for a virus, since the copying needs host machinery. The residue is derived from the fidelity attribute, not stipulated |

Three qualifications, all from the attributes above:

- **Nothing is absolute.** `R` has a precision like every other node, and it is not derived bottom-up — no one derives the whole domain of life. It is *reinforced*: each new fact of `D` that `R` derives raises it, each contradiction lowers it, by a step scaled to surprise. "Forming a theory" is lighting a deep node at low precision.
- **Dissonance has a size.** The cost of revising `R` is the number of lit nodes whose provenance pointer runs back through `R`: its dependent cone. That is computable from the pointers and gives a prediction (P7 below).
- **Understanding is not compression.** `G26` says a short description need not expose structure ([[wiki/concepts/universal-induction.md]]); formally, `C_μ` is not a description length, and a description-length state estimator grows structure the ε-machine does not have ([[wiki/concepts/causal-states.md]]). What separates the two here is that the derivations from `R` must be *runnable by the agent*, which is the "with enough context and time" clause.

What this buys the rest of the wiki: a success criterion for framing, which [[wiki/concepts/reasoning.md]] records that R6 lacks (a framing is correct when its `R` covers `D`), and a use for the R7 perturbation tests ([[wiki/entities/gsm8k.md]], [[wiki/entities/math-perturb.md]]): a content swap tests whether the derivation, not the fact, is what is lit. It addresses only `G73`'s weaker demand — selecting among frames the agent already holds — and not the construction of one.

---

## Architectural requirements

The page's centre. Each row is forced by one feature of the graph together with one limit of the agent; the brain column names the candidate mechanism, the reference column names a computational model that approximated the row, as a worked example and not as a component.

| # | Requirement | Forced by | Brain candidate | Reference model | Status |
|---|---|---|---|---|---|
| 1 | Store items are typed schemas with free variables: relations held as objects | the node kind | inferior parietal cortex holds first-order relations as objects, activation scaling with relation count; items and relations are separate load currencies ([[wiki/entities/lateral-frontoparietal-network.md]]); role-filler codes ([[wiki/entities/esbn.md]], [[wiki/concepts/activity-slots.md]]) | ESBN; vector-symbolic binding | `G104`: the role is a slot, not a type addressable apart from its filler. The parietal store's only causal evidence is a null (posterior lesions spare the relational decision), so it is a readout or a background condition until relation *count* is manipulated in a lesion series |
| 2a | A binder for ground facts: content joined to a position or context in one shot | exact edge: instantiate, at the fact end | hippocampal conjunctive binding; wide ventral fields and slow theta bind non-adjacent elements ([[wiki/concepts/hippocampal-long-axis.md]]) | [[wiki/concepts/vector-symbolic-binding.md]] | built in the fast store; roles stop being separately addressable once bound |
| 2b | A binder for schemas: decide which element of the instance fills which free variable (role-filler alignment) | exact edge: instantiate, at the schema end | rostrolateral prefrontal cortex, the one site with a necessity result for relational matching, graded by afferent fan-in (Urbanski et al. 2016); contested by a right frontal network at `n = 247` (`T336`); [[wiki/entities/lateral-frontoparietal-network.md]] | [[wiki/entities/lisa.md]] (synchrony binding, 2–3 propositions); [[wiki/entities/sme.md]] | the operation [[wiki/concepts/reasoning.md]] records every schema mechanism assumes and none performs ([[wiki/concepts/analogical-mapping.md]]); no registry row names the alignment step itself (`G104` is independence during binding, `G37` is retrieval) |
| 3 | Variable-length chaining: an inference-time loop whose length is set by the query | derivation length is query-dependent | rat dorsal-tier prefrontal–basal-ganglia loop for sequencing, whose human homologue is not established ([[wiki/entities/medial-prefrontal-cortex.md]]); dorsolateral prefrontal cortex as the effort tier that scales with difficulty and not with relational structure ([[wiki/entities/lateral-frontoparietal-network.md]]); working-memory control | [[wiki/concepts/adaptive-computation-time.md]], [[wiki/entities/universal-transformer.md]] | the step price is hand-set (`G107`); length is measured, width (row 14) is not |
| 4 | A lossy abstraction operator with an error register per coarse concept | lossy edges | cortical coarse-graining; precision as gain | closure as the criterion ([[wiki/concepts/computational-closure.md]]); the paired-rollout test ([[wiki/concepts/exact-coarse-graining.md]]) | no model tracks `ε` per concept; one instrument exists given simulator access |
| 5 | Access cost and precision as separate registers over parallel stores | the attributes | the store table above; [[wiki/concepts/precision-weighting.md]] | arbitration by posterior variance (Daw 2005) or by value of perfect information against `R̄τ` (Keramati 2011), both on [[wiki/concepts/amortized-inference.md]] | `T392`; which rule arbitrates is `T135`, `LIVE` |
| 6 | A context-gated suppressor for refuted nodes | suppressed, never deleted | three legs of one loop, not rivals: (i) at the store's input gateway, medial prefrontal → perirhinal and lateral entorhinal deep layers narrows what the store may complete from (`G110`, [[wiki/entities/hippocampal-prefrontal-channel.md]]); (ii) after retrieval, the controller suppresses the candidates the context does not license, the store having returned all of them (Preston & Eichenbaum 2013, [[wiki/concepts/schema-assimilation.md]]); (iii) at the controller, the channel's own terminals drive feed-forward inhibition so context withholds output (`T98`); extinction as a second association in infralimbic cortex; abandonment on [[wiki/entities/lateral-habenula.md]] | none | unbuilt; no registry row names it. Which leg the row needs is unassigned: (i) and (ii) suppress a node, (iii) suppresses an output, and refutation of a lit schema is measured by none of the three |
| 7 | A cache policy approximating `frequency × value × cost saved / memory` | the cache objective | consolidation gates; [[wiki/concepts/replay-prioritisation.md]]; habit | DreamCoder's compression; prioritised sweeping | no implementation of the full objective (`T81`) |
| 8 | An AND-OR controller: choose the branch to expand, stop at lit premises | framing = choosing `R` | prefrontal control; commitment by [[wiki/concepts/evidence-accumulation.md]] | the metalevel MDP (Hay et al. 2012; Callaway et al. 2022, [[wiki/concepts/resource-rationality.md]]); [[wiki/entities/alphazero.md]]'s UCT root is the counter-case | `G73`'s weaker demand only. No index policy: the branch to expand cannot be scored from that branch alone, and myopic control provably stops too early |
| 9 | A provenance pointer per lit node | the attributes | reinstatement of the intermediary ([[wiki/concepts/offline-replay.md]]) | none | no model has it: a generated inference is never tagged as one (`G71`) |
| 10 | Experience selection priced by `λ` | the budget table | [[wiki/concepts/epistemic-value.md]]; [[wiki/concepts/information-sampling-vs-search.md]] | the novelty term of expected free energy | `G129` |
| 11 | One-shot write for ground facts, many-shot for schemas | node kind + the W / M mapping | BTSP vs STDP ([[wiki/concepts/synaptic-plasticity.md]]) | [[wiki/entities/btsp-cam.md]] | built |
| 12 | Precondition check at the stated grain before a schema is applied | inheritance + `ε` | option initiation sets ([[wiki/concepts/temporal-abstraction-options.md]]); event schemas ⟨precondition, transition, effect⟩ ([[wiki/concepts/event-segmentation.md]]) | the initiation set `I` | partly built |
| 13 | A slow store carrying the agent-side meta-graph across episodes | the two levels | cortex ([[wiki/concepts/complementary-learning-systems.md]]) | [[wiki/entities/tolman-eichenbaum-machine.md]] | built |
| 14 | Width: several mutually irreducible structures held live at once, so that a schema's variables can range over schemas (a relation between relations) | an AND edge with `k` premises needs `k` co-held nodes; a second-order schema needs two first-order ones held apart | rostrolateral prefrontal cortex as fan-in convergence (degrades with sources cut) or a right frontal network as parallel occupancy (degrades with co-active structures at fixed sources); the one human-specific anatomical novelty is the rostrolateral ↔ parietal edge; development frees the site by offloading first-order work to the parietal store ([[wiki/entities/lateral-frontoparietal-network.md]]) | [[wiki/entities/lisa.md]]'s phase capacity of 2–3 propositions | `T336`, `T338` `LIVE`; second-order is the deepest order tested in tissue; no wiki architecture reports a width sweep, and the two readings make opposite scaling predictions that one sweep separates |

---

## Tests and open problems

**Tests attached to rows.**

| Test | Row | Instrument |
|---|---|---|
| P1: at fixed memory, error on novel queries trades against derivation steps along a front bounded by the generator | scoring | ponder-step counts against accuracy ([[wiki/concepts/adaptive-computation-time.md]], [[wiki/entities/universal-transformer.md]]) |
| P4: ground facts light in one shot; a schema with `k` free variables needs many instances, at `½ log₂N` bits per effective free variable ([[wiki/concepts/predictive-information.md]]), so rising with `k` | 11 | the one-shot / many-shot plasticity split; sample-complexity curves across PGM-style regimes |
| P5: an agent whose lit set holds the family's common ancestors shows the `O(V)` saving; a shallow-lit agent shows `O(E)` | 13 | nodes-visited against edges-taken curves ([[wiki/entities/tolman-eichenbaum-machine.md]]) |
| P6: perturbation invariance holds for nodes lit by derivation and fails for nodes lit by observation or testimony | 9 | R7 tests with provenance recorded ([[wiki/entities/gsm8k.md]], [[wiki/entities/math-perturb.md]]) |

**Open problems.**

- **P2, no instrument.** The probability a hypothesis is entertained should decay with its derivation distance from the lit set: confirmation bias as a budget effect, since searching from lit nodes is cheaper than from the trunk.
- **P3, no direct instrument.** At bounded derivation length, deep schemas yield only coarse predictions; closure's per-level predictive-information shares are the nearest quantity.
- **P7, no instrument.** Resistance to revising a belief grows with the size of its dependent cone.
- **No model tracks `ε` per coarse concept** (row 4). One measurement exists given simulator access: evolve two micro states the concept maps to one code, and the difference decays (an irrelevant merge, `ε = 0`), persists while the codes stay equal (a relevant level), or the codes diverge (not closed) ([[wiki/concepts/exact-coarse-graining.md]]). That split also shows `ε` here folds two quantities: error on the coarse variable's own dynamics, and information discarded about the fine state. The `ε = 0` case coincides with the interpretability literature's notion of a valid causal abstraction (interventions commute between a coarse and a fine model), which is absent from the wiki and is an acquisition target.
- **Whether the generality ordering is computable by the agent.** "Down" is implicit in provenance pointers; choosing a *deep* `R` for framing needs an estimate of depth, and coverage is the only candidate here.
- **The precision propagation rule is stated qualitatively** (inherits, plus `ε`) and no formula is committed to.
- **Elegance is deliberately not defined.** "A short derivation from a deep premise" is a pair (premise depth, tree size) that could be reported per derivation; it is left out as a human preference the requirements do not need, following the bounded-optimality remark that the best procedure may be neither elegant nor illuminating ([[wiki/concepts/resource-rationality.md]]).

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
- **[[wiki/concepts/resource-rationality.md]]** — prices every budget in this page's table by the same opportunity-cost rate, and supplies the objection this page inherits: the cost–benefit computation lives in the outer loop, so the cache policy is learned, not run. Its bounded optimality names this page's front (the lit set is the program optimised for the machine), and its metalevel MDP is the formal object for row 8.
- **[[wiki/concepts/computational-reuse.md]]** — the parent of the cache objective: Michie's three design issues map onto this page as generalisation = the free variable, persistence = access cost, decomposition = concept against fact; its stale-cache reading of habit is the rival to `T405` in the store table.
- **[[wiki/concepts/causal-states.md]]** — the floor of the grain axis: the minimal sufficient partition, which a predictor may over-split at zero loss but never over-merge; its fixed-horizon remark runs against the "long horizon selects coarse grain" conjecture, and its "`C_μ` is not a description length" is the formal backing for understanding not being compression.
- **[[wiki/concepts/predictive-state-representations.md]]** — contests the grain axis's assumption that a coarse variable is a partition: a system of finite linear dimension with no finite node set has a predictive state whose grain is a rank, not a cell count.
- **[[wiki/concepts/predictive-information.md]]** — prices a free variable at `½ log₂N` bits per effective parameter, giving P4 a rate; its abrupt-learning result is the competing account of "it all clicks" as a model-class property rather than a compression event.
- **[[wiki/concepts/exact-coarse-graining.md]]** — the one instrument for row 4's error register: a paired rollout from two micro states sharing a code gives three outcomes, and its relevant/irrelevant split separates two quantities this page's `ε` folds together.
- **[[wiki/concepts/satisficing.md]]** — the alternative to pricing every budget by `λ`: an aspiration level as the stopping rule for derivation, which answers `G107` without an exchange rate and is the alternative this page does not take.
- **[[wiki/concepts/thermodynamic-bounded-rationality.md]]** — gives `λ` units (the inverse temperature `β` as a sample count) and the mechanism behind the outer-loop objection: the agent does not reason about its constraint, it derives until the resource runs out.
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
- **[[wiki/entities/lateral-frontoparietal-network.md]]** — the solution-side anchor for rows 1, 2b, 3 and 14: parietal cortex holds first-order relations as objects, rostrolateral cortex aligns roles to fillers and compares relations of relations (fan-in or parallel occupancy, `T336`), dorsolateral cortex pays the search cost, and its lesion series is the reason exact edges are a formal kind the anatomy does not separate.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the solution-side anchor for rows 5, 6, 7 and 12 and the store table's way-station: the ventral tier selects which subgraph is live and suppresses the rest, prices resolution of state uncertainty, and holds the one measured consolidation trajectory, in which a ground-fact mapping migrates while the vocabulary stays, which is this page's "named exception" as the main case.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — supplies leg (i) of row 6: top-down control is applied at the store's input gateway (perirhinal and lateral entorhinal deep layers, `G110`), not to the store or its output, and the channel's terminals supply leg (iii), feed-forward inhibition at the controller.
- **[[wiki/concepts/hippocampal-long-axis.md]]** — the grain axis as anatomy and row 2a's binder: place fields widen tenfold from dorsal to ventral, so one structure binds item-in-place at one end and context gist at the other, and only the coarse end reaches the controller, which fixes the grain of what row 6 and row 12 operate on before any computation does.
- **[[wiki/concepts/schema-assimilation.md]]** — the division of labour this page's cache and deriver map onto (store returns, controller selects), the integrate-versus-separate split between medial and lateral prefrontal cortex with no arbitration rule, and the three-stage trajectory (hippocampus → ventromedial template → ventrolateral and anterior temporal cortex) that the store table's way-station row records.
- **[[wiki/entities/hippocampal-formation.md]]** — the hub for the structure this page names as brain candidate in rows 2a, 9 and 11, written under this page's rule that computational models are references for how a row was approximated rather than components.
