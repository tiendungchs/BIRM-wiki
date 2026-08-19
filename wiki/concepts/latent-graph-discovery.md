# Latent Graph Discovery

**CORE PROBLEM FRAMING — The unified problem a brain-inspired reasoning model must solve.**

**Latent graph discovery (LGD) = infer the structure (nodes, edges, topology) of a relational graph from observations, then navigate it — where the graph is never given explicitly and must be recovered from partial, aliased, or sequential evidence.**

Working claim: abstract reasoning, analogy, planning, mathematics, navigation, and scientific discovery all reduce to recovering an implicit relational structure and using it to generate predictions, plans, or inferences.

> **Epistemic status — a chosen lens, not an established reduction.** Biologically warranted as a *substrate* on the **metric / transition-sampled slice** (structure that is orderable, continuous, or learned from traversal). On the **non-embeddable symbolic slice** (modular arithmetic, syntactic recursion, type-checking) it is untested and remains a bet. Rival one-problem reductions — program induction, probabilistic language of thought, free-energy attractor dynamics ([[wiki/concepts/predictive-coding-free-energy.md]]), **energy minimisation / constraint satisfaction** ([[wiki/concepts/energy-based-models.md]]) — explain the same data and are mutually foldable with navigation, so folding any of them *into* "navigation over a hypothesis graph" is a modeling choice, not a finding. The energy rival is the closest to a translation rather than a competitor: an edge label and a latent variable are the same free variable, and path search is `argmin` over a sequence of them.

---

## The Graph Formalization

| Element | Interpretation |
|---|---|
| **Nodes** | Observations / states of the world |
| **Edges** | Transformations / actions that move between states |
| **Edge labels** | The rule or operation applied (often unknown) |
| **Topology** | The relational skeleton of the domain |
| **Edge driver** | Whether an edge fires because the agent chose an action (controllable) or regardless of choice (exogenous: physics, other agents, time) |

The graph is **never directly observable**. It must be inferred from sequences of (observation, action, next-observation) triples — or from before/after pairs alone (ARC-AGI style), where edge labels are what must be recovered.

**And the node set is assumed, not given.** Every element above presupposes that experience already arrives discretised into states. On a continuous sensorimotor stream it does not. The one mechanism the wiki has for producing the discretisation is **event segmentation** — an event is a *set* of predictive encodings that holds over an extended period, an event boundary is a lasting change in that set, and an *event schema* ⟨precondition, transition, effect⟩ is a typed edge (Butz 2016). See [[wiki/concepts/event-segmentation.md]] and gap G27.

---

## Taxonomy: What Is Latent

Tasks differ by *which graph components are hidden*. This is more principled than domain enumeration: it says what the model must compute regardless of surface form.

These are **independent latent variables, not a partition**. A task is a *subset* of hidden bits — a bit-vector, not a category. Most real tasks set several at once, so appearing under multiple rows is expected.

| Latent variable | What must be computed when latent |
|---|---|
| **Node content / identity** | De-alias; infer partial state from path context |
| **Edge existence** (topology / adjacency) | Structure learning — discover which transitions are possible |
| **Edge labels** (rule per edge) | Single-hop function induction from endpoint pairs |
| **Edge vocabulary** (alphabet of labels) | Invent new primitives; co-discover the operator set |
| **Path** (composition connecting endpoints) | Multi-hop search / planning over a *known* move-set |
| **Goal node** | Infer what counts as a solution |

**What the estimate looks like when it is measured.** The one case where an *organism's* graph estimate has been read out directly (human entorhinal fMRI adaptation over a 12-node object graph, Garvert et al. 2017) returns three facts a model builder should treat as targets rather than as artefacts: the estimate is (i) acquired **incidentally** — no reward, no goal, no task that uses the structure, and no reportable awareness of it; (ii) **symmetric**, even though the experienced transitions were not; (iii) **not the adjacency matrix and not a Euclidean embedding**, but a traffic-weighted sum over paths (communicability / successor representation) that shortens well-travelled edges and lengthens rarely-used ones. So "discover the graph" in the biological case means *discover a predictive metric over it* ([[wiki/concepts/successor-representation.md]]), which is a strictly weaker object than the topology — enough to rank distances and to plan, not enough to recover which edges exist.

**The estimate can also contain edges that were never traversed, and the brain writes them offline.** Edge *existence* need not be observed to be stored: two separately learned links `X→Y` and `Y→Z` can be composed into a direct `X→Z` edge with no experience of the pair. Recording the write is the only way to tell the composed edge from an online chained retrieval that leaves no trace, and Barron et al. 2020 do both — awake hippocampal ripples increasingly co-activate `X₁` and `Z₁` (without the intermediary, over and above either cell group's own rate change, and only for the chain ending in reward), while at choice time the hippocampus reinstates the intermediary rather than the endpoint. So the biological graph estimate is **closed under composition selectively, offline, and value-gated**, not maintained as the transitive closure of everything observed — which is a concrete answer to what the "structure learning" row costs when the graph is large ([[wiki/concepts/offline-replay.md]]).

**And the graph can be assembled from *marginals* the observer never saw jointly.** Park et al. 2021 taught subjects two 1-D rank orders over the same 16 entities on separate days, by adjacent-pair comparisons only, never presenting the two dimensions together and never asking for their combination. Hippocampal and entorhinal pattern dissimilarity then scaled with **2-D Euclidean** distance in the product space, significantly better than with either 1-D distance alone, and inferred direct vectors across that plane drove a six-fold entorhinal/prefrontal code — including on pairs faced for the first time. Two things this adds to the taxonomy above:

- **A latent variable the table does not have: the *dimensionality* of the space the nodes live in.** Both marginals were fully observed; what was latent was that they are axes of one space rather than two separate orderings. Nothing in the wiki's model inventory performs this composition — TEM-family learners and successor-representation estimators alike consume transitions *within* the space they build, so a dimension never co-sampled with another cannot be joined to it.
- **The joint estimate is built unprompted and then queried off-policy.** No reward, no task demand, no report of having built it — the same incidental profile as Garvert et al. 2017 — but here it is subsequently *used* for a decision value that was never trained (see [[wiki/concepts/cognitive-map.md]]), which is the discover-then-navigate loop (G5) running end-to-end in a human on a structure with no continuum in the input.

**And one node set can carry several graphs at once — "the" graph is a modelling assumption, not a fact about the domain.** The same 12 objects that carry Garvert et al. 2017's learned transition graph also carry a lifetime semantic taxonomy over the identical nodes, and a re-analysis entering both distances as competing regressors recovers **both** in the hippocampal formation, in **non-overlapping** territory, with each effect at zero in the other's region (Zheng et al. 2024, [[wiki/concepts/cognitive-map.md]]). Three consequences for the taxonomy above:

- **The latent-variable table is incomplete by one row: *which* structure the observations are being read against.** Every entry assumes a single target graph, so "discover the edges" is well-posed. With several structures live over one node set, an estimator that fits one distance function per item pair silently averages them, and the averaged metric is a graph no structure has.
- **The two were acquired by different channels and stayed separate.** One arrived as sampled transitions, the other as accumulated semantic experience with no transitions at all — so the two halves of the discovery problem (edge existence from a walk, similarity from co-occurring properties) are not competing accounts of one mechanism but *both running*, on the same items, at once.
- **The parallel structures are the substrate a routing policy would need (G12), and nothing supplies the router.** Keeping them apart is what makes it cheap to switch which dimension a query reads; nothing in the source says what performs the switch, which leaves G37's retrieval one step short again — it picks the context, not the structure over the items in it.

**Edge-label-latent vs. path-latent** — the two discriminators are *single edge vs. composed sequence* and *is the vocabulary known?*
- **Edge-label latent** — many (start, end) pairs given; infer the one transformation mapping input→output.
- **Path latent** — one (start, end) pair; vocabulary already known; find the *sequence* connecting them.

**"Topology given" ≠ "the solver knows the graph."** It is the technical claim that adjacency is *fixed in advance by an explicit map or by known rules*, so no structure-learning-from-observation is required. The graph may still be astronomically large and mostly dark. Edge *existence* and edge *semantics* are orthogonal: an affordance can be enumerable (topology given) while what it does is latent (label ✓, vocabulary ✓).

**Benchmark × latent-variable mapping** (extended by each ingest that adds a benchmark page):

| Benchmark | Node content | Edge existence | Edge label | Edge vocabulary | Path | Goal node |
|---|---|---|---|---|---|---|
| [[wiki/entities/arc-agi.md]] | given | n/a (single edge) | **latent** | **latent** (described, not supplied in program form) | latent when chained | **latent** (output grid constructed from scratch) |
| Omniglot | given | n/a | **latent** | given (pen strokes) | latent (stroke sequence) | given |
| Atari / DotA2 | given | latent | given (game rules) | given (button set) | **latent** | given (score) |
| Baby Intuitions Benchmark ([[wiki/entities/hbtom.md]]) | given (symbolic states) | given (gridworld, hand-written PDDL) | given | given | given | **latent** (which object the agent is after, plus *how rational* it is) |
| Tokenised mazes ([[wiki/entities/maze-solving-transformers.md]]) | given (one token per cell) | given *in-context*, in randomised order — must be re-represented, not discovered | given (move to an adjacent cell) | given | **latent** (the shortest route) | given (target token) |

A benchmark is only informative about a latent variable *the solver's developer also did not know* — see [[wiki/concepts/skill-acquisition-efficiency.md]] on developer-aware generalization. On that criterion the second and third rows measure local generalization regardless of how many variables they mark latent, because their task types were public when the solvers were written.

---

## Two-Level Graph Hierarchy

Every domain is a **family of environments**, not one environment: shared laws instantiated per task with different objects and bindings — `p(obs) = ∫ p(obs | θ_shared, θ_inst) p(θ_inst) dθ_inst`. Three consequences:

- **A flat model fits the wrong object** — a single-level estimator fits the mixture `E_θ[p(obs|θ)]`, a distribution no individual instance follows. "OOD failure" is what fitting a mixture to a component means.
- **Sample budgets differ by orders of magnitude** — a few demonstrations per instance vs. unlimited episodes per family. Parameters must split *by sample budget*: pooled/slow vs. low-dimensional residual/fast. The hierarchy is a **sample-complexity decomposition** before it is a cognitive claim (MDL: `|θ_shared| + N·|θ_inst|` beats `N·|instance|`).
- **Instantiation is binding, not learning** — the meta-graph is a schema with free slots; the instance-graph binds them, so acquisition can be one-shot.
  - **And binding presupposes a match.** Before slots can be filled, the *right* schema must be found in the library and aligned with the current situation — a subgraph-matching query, NP-complete in general and the one operation the framing had left unmechanised. Making it a coordinate comparison in an order-embedding space is the current best answer ([[wiki/concepts/subgraph-matching.md]], [[wiki/entities/neuromatch.md]]).

The two levels are poles of a continuum, not a claim that features come in exactly two kinds.

| Level | Role | Examples |
|---|---|---|
| **Meta-graph** | Shared transition structure across all tasks in the domain | Arithmetic operators; kinship relations; ARC-AGI transformation types |
| **Instance-graph** | Task-specific topology for a single problem | The particular equation to solve; one ARC-AGI grid pair |

A system that conflates the levels cannot transfer — it must relearn the meta-graph for each instance. Separating them is the core requirement of structural generalization.

Mapping to the two-timescale factorization (W = slow **w**eights, gradient-updated across episodes; M = fast **m**emory, bound within an episode) and to the factorized code:

| Meta-graph | Instance-graph |
|---|---|
| Slow **W** — shared structure across episodes | Fast **M** — episode-specific binding |
| **g** — structural code, position in the meta-graph | **x** — sensory code, node content |
| — | **p = f(g, x)** — conjunction anchoring content to graph position |

**The measurable payoff of the split: `O(E)` experience becomes `O(V)`.** An agent without the meta-graph must traverse every *edge* to know the graph; an agent that has it needs only to visit every *node*, because the edges are implied by structure it already has. TEM's prediction accuracy tracks the fraction of nodes visited rather than edges taken, and on the paper's illustrative graph 18 steps suffice to infer all 42 links (Whittington et al. 2020, [[wiki/entities/tolman-eichenbaum-machine.md]]). This is the wiki's cleanest quantitative statement of what the two-level hierarchy buys, and it is the right benchmark axis for any candidate: plot performance against *nodes visited* and against *edges taken*, and the gap between the curves is how much meta-graph the system actually has.

---

## Sources of Hardness

| Source | Description | Architectural implication |
|---|---|---|
| **1. Two-level entanglement** | Meta-graph rules and instance quirks co-occur in every observation | Factorized latent space + two learning rates |
| **2. Unknown vocabulary** | Action set and/or node types not given; inferred alongside structure | Learnable observation and transformation embeddings. **A knob, from the energy reading:** if an edge label is a latent variable, the vocabulary's size is that latent's *information capacity*, controllable by discretisation, rank, sparsity or noise ([[wiki/concepts/energy-based-models.md]]) — `k` discrete values give at most `k` labels, a `d`-dimensional latent gives a `d`-dimensional family. The vocabulary question becomes a regularisation question |
| **3. Observation aliasing** | The same observation occurs at structurally distinct positions | Clone cells or path-integrated identity — both now built: a frozen per-observation clone pool learned by expectation-maximisation ([[wiki/entities/cscg.md]]) and an action-accumulated code ([[wiki/concepts/path-integration.md]]). Sequences are what make it soluble at all: identical observations do not have identical futures |
| **4. Simultaneity** | Structure must be inferred *while* navigating — no discovery-then-use separation | Joint loop: update graph estimate and navigate concurrently. Butz 2016's predictive processing loop (predict → fuse sensory evidence → relax to mutual consistency, every cycle, while acting) is joint at the *instance* level; its weights still adapt slowly, so the meta level keeps the separation |
| **5. Spurious edges** | Training correlations produce false edges that work in-distribution and fail out of it — the *default* outcome, not a corner case (Geirhos et al. 2020) | Force invariant causal edge discovery across environments; explicit intermediate-node traversal |
| **6. Non-stationary topology** | The edge set rewrites *within a single episode*, violating the fixed-but-hidden assumption shared by 1–5 | Discover the stationary generator of the rewrites; re-infer the instance-graph online |

**Source 3 is now observed being solved, and the observation adds a requirement no row above states: de-aliasing is not implied by task success.** In mouse CA1 learning a task built entirely out of aliased observations, the population separates the confusable states over weeks, in a fixed order, ending near-orthogonal — while recurrent networks, long short-term memory networks and transformers trained on the identical sequence reach the same *predictive accuracy* with their aliased states still highly correlated (Sun et al. 2025, [[wiki/entities/cscg.md]]). The reason is structural: next-observation prediction only requires the states to be separable in the low-dimensional subspace the readout reads, leaving every other direction free. So a system can pass every behavioural test this page's benchmarks apply and hold a *merged* graph internally, resolved only at the readout. Two consequences:

- **De-aliasing must be paid for separately** — by an architectural choice (soft winner-take-all / competitive inhibition) or by an explicit decorrelation term in the loss. Both were shown sufficient; the prediction objective alone was not. This is the same shape as the `g`/`x` argument below: the property has to be imposed, not discovered.
- **Behavioural success is not evidence of node identity.** Add this to gap G17's ledger: i.i.d. testing cannot certify structure discovery, and now neither can *out-of-distribution* success on a task whose latent states are separable in the readout subspace. The only instruments that saw the difference were representational ([[wiki/concepts/population-geometry.md]]).

**Source 5 is an identifiability problem, not a training problem.** Many decision rules fit the observations; the causal one and the spurious one are *equally consistent* with any single environment, so no amount of in-distribution data or optimization selects between them — "which rule is intended is in the eye of the beholder" (Geirhos et al. 2020). Two consequences the rest of this page depends on:

- **The environment family is the identifiability condition.** The multi-environment signal that makes an invariant (causal) edge distinguishable from a correlational one is exactly the family structure of the two-level hierarchy. The meta-graph is *defined* as what survives across instances, so the hierarchy is not only a sample-complexity decomposition — it is what makes the intended graph well-posed at all.
- **The `g`/`x` factorization must be paid for, not discovered.** A shortcut is by construction a rule reading `x` where the intended rule reads `g`; since the data does not separate them, the split has to be imposed through inductive bias — architecture, training data, loss, or optimizer. See [[wiki/concepts/shortcut-learning.md]] for the four levers and gap G16.

Corollary for evaluation: **i.i.d. testing cannot certify that any architecture on this page discovered a graph** — it cannot distinguish a recovered meta-graph from a correlation that happens to hold in the sample (gap G17). The scoring table below needs out-of-distribution tests to be meaningful.

And the shift must be one the *architecture's developer* did not see either: Chollet 2019 shows that skill on any task known in advance can be bought outright with priors (hard-code the solution) or with data (dense-sample the situation space), neither of which touches generalization. So the scoring table needs tasks with non-zero **developer-aware generalization difficulty**, not merely out-of-distribution ones — see [[wiki/concepts/skill-acquisition-efficiency.md]].

**Source 6 does not defeat the W/M split.** Distinguish (a) the object-level edges currently in effect, which mutate mid-episode, from (b) the generator that changes them, which is stationary. Assign **(b) → slow W** and **(a) → fast M** (now continuously updated rather than written once). Equivalently, **lift rule-state into the node**: on `s' = (base_state, rule_config)` the graph is stationary again — topology only looked dynamic because the rule dimension was marginalized out. Two catches:

- **Tractability, not stationarity, is the constraint.** The lifted space is `(base) × (rule-configs)`; learnable only when rule-config factorizes and rewrites are sparse, legible, bounded, and meta-stationary. A rewrite process with *no compressible generator* is unsolvable in principle — for any learner — because there is nothing to learn.
- **A third tier can survive the fold.** Two levels suffice when the rewrite is expressible in the same vocabulary as base transitions; self-amendment that edits the rule-changing rules themselves needs a distinct rewrite-graph level.

**Biological reading — reification:** the brain likely represents a *rule as a first-class object* (a node with its own factorized code) rather than as special machinery, so "rule-change" becomes an ordinary edge over rule-nodes handled by the same relational apparatus.

---

## Architectural Requirements

| Requirement | Mechanism |
|---|---|
| Two-level separation | Factorized latent space: g (meta-graph position) ≠ x (node content) |
| Meta-graph learning | Slow W update over many episodes |
| Instance-graph binding | Fast Hebbian M within episode. Biology splits this into **two rules with different integration windows**: behavioral timescale synaptic plasticity writes a *node* in one shot, spike-timing-dependent plasticity accumulates *edges* over many; the pair is in principle expressive enough for any graph (Liao & Losonczy 2024; [[wiki/concepts/synaptic-plasticity.md]]) |
| De-aliasing | Path-context-sensitive identity (clone cells or path-integrated g) |
| Path-consistency | g must commute: same meta-graph position via any path — supplied by an additive update over composing actions ([[wiki/concepts/path-integration.md]]), where it holds by construction, on domains whose actions compose (G41) |
| Vocabulary learning | Observation + action embeddings learnable, not fixed |
| Causal edge invariance | Edges learned from invariant causal structure, not i.i.d. correlations |
| Multi-level hierarchy | W itself structured as a discoverable graph (open problem) |

---

## Formal Ceiling

**AIXI** (Hutter 2000) is the only known system satisfying all six hardness sources at once: a Bayesian mixture over *all computable environments* — hence over all latent graphs, vocabularies, aliasing structures, and topologies, including non-stationary ones — acting by expectimax. Conditioning on full history resolves aliasing; topology change is absorbed into the environment posterior. Full architecture, results and scoring row: [[wiki/entities/aixi.md]].

Three corrections the source itself forces on the wiki's earlier reading of this ceiling:

- **The ceiling is two walls, not one.** Uncomputability is the famous one and **AIXItl** removes it (enumerate all programs of length `≤ l̃` carrying a proof that they never overrate their own expected credit; act on the highest self-certified value; `O(2^l̃·t̃)` per cycle). The second wall does not come down: **there is no credit bound for any agent whose actions influence its observations** — proved, not merely unfound (gap G25). Optimality guarantees exist on the *passive* slice (prediction, classification) and provably cannot exist in general on the active one.
- **The mixture absorbs the two-level hierarchy rather than representing it.** Nothing in AIXI is factorized into `g` and `x`; the meta-graph exists only as a marginal of the posterior. So the ceiling demonstrates that the factorization is not *logically* required — it is required by finite capacity. Worse, the simplicity prior selects a short program, not a structured one, so even the ideal inductor need not expose the graph in navigable form (gap G26).
- **Learnability = compressibility.** The only property of the environment entering the convergence bounds is `K(µ)`. This is the same statement as hardness source 6's "a rewrite process with no compressible generator is unsolvable in principle", now general: a domain is learnable to the extent it has a short description, independent of its size, stochasticity or stationarity. See [[wiki/concepts/universal-induction.md]].

**Environment assumptions are a second scoring axis.** Because no bound holds for arbitrary `µ`, guarantees must be relativized to *separability classes* — passive / factorizable / stationary / (generalized) Markovian / uniform / forgetful / farsighted / asymptotically learnable, in increasing generality. Alongside "which hardness sources does this architecture reach", ask "which environment assumptions is it buying its guarantee with". The useful domains sit above the Markovian line that most practical architectures assume.

*Architecture-by-architecture scoring against the six sources: [[wiki/entities/aixi.md]] supplies the reference row; other architectures to be filled by ingests.*

---

## Open Problems

- **The non-embeddable symbolic slice** — does the navigation frame survive structure with no metric embedding (modular arithmetic, syntactic recursion)?
- **Multi-level hierarchy** — making W itself a discoverable graph rather than a flat meta-graph.
- **Vocabulary co-discovery at scale** — inducing primitives *and* their semantics without a hand-given DSL, beyond toy domains.
- **Reliable self-generated intermediate nodes** — traversal degrades when the model must produce its own intermediate structure.
- **Routing** — which structures belong to the transition-sampled (hippocampal-analog) module vs. a declarative/relational one.

---

## Connections

- **[[wiki/entities/hag-reservoir.md]]** — this page's problem run one level down, on the network's own wiring rather than on the environment's states: a local unsupervised rule grows the edge set from co-fluctuation statistics, and inherits both limitations verbatim — correlation is symmetric, so no edge is directed, and nothing carries the discovered structure from one environment to the next.
- **[[wiki/entities/vector-hash.md]]** — the same storage-and-retrieval layer at exponential capacity and with the discovery layer removed by construction: `g` is installed and frozen, the assignment of content to a position in `g` is *random*, and the traversal order for a non-spatial episode is supplied by the modeller.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — a fully worked storage-and-retrieval layer with the discovery layer absent: arbitrary one-trial bindings, exact completion from any fragment, closed-form capacity, and no mechanism that notices two episodes share a relational form.

- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the methodological licence for treating brain mechanisms as candidate answers to this problem; its track record shows every past transfer moved a representation or a gating policy, never a factorization.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the biological derivation of the slow-W / fast-M split from interference alone, independent of this page's sample-complexity argument; hippocampal sparse coding is the de-aliasing mechanism (hardness 3).
- **[[wiki/concepts/meta-learning.md]]** — the optimization statement of the two-level hierarchy: outer loop over `p(T)` learns the meta-graph, inner loop binds the instance-graph.
- **[[wiki/concepts/continual-learning.md]]** — the write mechanism for slow W: without protection against catastrophic forgetting the meta-graph cannot accumulate across environment families.
- **[[wiki/concepts/working-memory.md]]** — control/storage separation supplies the only architecture that performs explicit multi-hop traversal (shortest path over a subway map), on a graph that is *given*, not discovered.
- **[[wiki/concepts/attention.md]]** — a query–key similarity matrix is a content-computed soft adjacency, i.e. a one-step graph recomputed per query instead of persisted as structure.
- **[[wiki/concepts/simulation-based-planning.md]]** — the *use* half of this page: planning is path search over the estimated graph, and it presupposes the discovery half.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the candidate implementation of `g`; periodic (grid-like) codes are the only concrete proposal so far for making it path-consistent.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — decides whether a slow-W meta-graph learner is trainable in a neural substrate at all, and locality constrains which architectures can carry it.
- **[[wiki/concepts/shortcut-learning.md]]** — the empirical account of hardness source 5: spurious edges are the *default* learned solution across every subfield, and i.i.d. evaluation cannot distinguish them from the intended structure.
- **[[wiki/concepts/offline-replay.md]]** — where the edges are actually written and filtered: an internally generated curriculum that resamples experience toward what recurs across episodes, which is a mechanism preferring structural over spurious edges without any objective that distinguishes them.
- **[[wiki/concepts/offline-replay.md]]** — and where edges are *invented*: ripples compose two learned links into a direct one for pairs never experienced together, so the estimate grows between exposures rather than only during them (Barron et al. 2020).
- **[[wiki/concepts/synaptic-plasticity.md]]** — the candidate write rule for fast **M** during the episode; it can bind an instance-graph's weights but carries no notion of node identity or path, so it supplies the mechanism without the representation.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — instantiates the hierarchy literally (slow **W** = plasticity coefficients, fast **M** = the weights they write), and its self-referential variants are the first named candidate for the third tier gap G9 demands.
- **[[wiki/entities/spiking-neural-networks.md]]** — offers a substrate-level primitive for *directed* edges via the spike-timing asymmetry, which a rate-coded architecture has to learn as content instead.
- **[[wiki/entities/aixi.md]]** — the formal ceiling made concrete: covers all six hardness sources, supplies the reference row of the scoring table, and shows the two-level factorization is a finite-capacity requirement rather than a logical one.
- **[[wiki/concepts/universal-induction.md]]** — the prior that makes the ceiling work, and the source of the passive/active split: structure discovery is guaranteed for an observer and provably uncertifiable for a participant.
- **[[wiki/concepts/core-knowledge.md]]** — the pre-installed case: six meta-graph fragments given by evolution rather than discovered, which converts hardness source 2 from vocabulary induction into composition across fixed vocabularies.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the free-energy rival stated in full: one residual-minimisation rule covering perception, learning and action, whose activity/weight split reproduces fast **M** / slow **W** and whose three typed prediction channels are a concrete bet on the architecture lever gap G16 demands.
- **[[wiki/concepts/compositionality.md]]** — makes the meta-graph productive: a finite vocabulary of parts and relations generates an unbounded set of instance-graphs, which is what lets binding be one-shot instead of a fresh structure-learning problem.
- **[[wiki/concepts/causal-model-building.md]]** — says what the recovered edges are supposed to *be*: steps of the process that generated the data, not sufficient predictors of it — the criterion that separates an intended edge from a spurious one.
- **[[wiki/concepts/amortized-inference.md]]** — supplies the speed constraint this page ignores: a graph estimate too slow to query is not usable for navigation, and the proposed remedy is compiling inference into a feed-forward proposer.
- **[[wiki/entities/bayesian-program-learning.md]]** — the two-level hierarchy realized architecturally rather than emergently: a shared library of primitives and relations as the meta-graph, a per-concept stochastic program as the instance-graph.
- **[[wiki/concepts/event-segmentation.md]]** — supplies the discretisation this page assumes: events are nodes, event schemata are edges carrying preconditions and effects, episodes are compressed paths, and backward chaining through preconditions is path search run from the goal.
- **[[wiki/concepts/three-component-framework.md]]** — the specification language this page lacks: any answer here must be stated as an objective function, a learning rule, or an architecture, and the `g`/`x` factorization is currently stated only as the last of the three.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — supplies the scoring axis this page's hardness table presupposes: an architecture's row means nothing unless the benchmark it was scored on has non-zero *developer-aware* generalization difficulty.
- **[[wiki/concepts/energy-based-models.md]]** — the translation of this page into a scalar landscape: nodes are minima, edge labels are latent variables, path search is `argmin` over a latent sequence — which converts the edge-vocabulary problem into a latent-capacity problem with an actual knob on it.
- **[[wiki/entities/h-jepa.md]]** — the wiki's most complete design against this page's requirements: the two levels realised as prediction timescales, the vocabulary as regularised latents, online replanning for simultaneity, and a fully differentiable path from cost gradient to action — with no empirical evidence for any of it.
- **[[wiki/entities/hbtom.md]]** — the opposite corner of the taxonomy from ARC: everything but the goal node is hand-supplied, which is what makes it readable as a clean test of the *use* half — and its two-level hierarchy is the `p(obs) = ∫ p(obs\|θ_shared, θ_inst)` decomposition written out literally as a hyperprior over per-agent parameters.
- **[[wiki/entities/arc-agi.md]]** — the pure edge-label-latent benchmark with a co-latent vocabulary: hardness sources 1 and 2 isolated, 3–6 designed out, and the first row of the benchmark table above.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the sharpest counterexample to compression-implies-structure: 48.0% on flattened ImageNet patches, beating PNG, with no object, depth or 2-D adjacency recovered (gap G26).
- **[[wiki/concepts/intelligence-density.md]]** — supplies a scaling test for whether a recovered structure is real: holding the meta-graph means covering an unbounded family of instance-graphs at fixed description length, while memorised instances force `C` to grow with the family (Choi 2026).
- **[[wiki/concepts/subgraph-matching.md]]** — the third operation alongside discovery and navigation: deciding whether a stored structure *occurs in* a new situation, which "instantiation is binding, not learning" presupposes and no page here had mechanised.
- **[[wiki/entities/neuromatch.md]]** — the retrieval side taken as far as it currently goes: graph given on both sides, containment made a coordinate comparison, ~100× faster than exact search, transferring from random graphs to real domains without fine-tuning.
- **[[wiki/concepts/contextual-inference.md]]** — supplies the arbitration step the framing left implicit: a posterior over which stored structure is currently generating the data, which decides retrieval, allocation of a new structure, and how much each existing one is updated; its context variable is hardness source 6's rule-config reified as a first-class latent (Heald et al. 2021).
- **[[wiki/concepts/representation-probing.md]]** — the first instrument in the wiki that looks *inside* a trained model for the graph rather than inferring it from behaviour, and the one that shows the page's two halves failing independently (a verified-good estimate with invalid routing over it).
- **[[wiki/entities/maze-solving-transformers.md]]** — the cleanest available separation of discovery from use: the whole maze is linearly decodable from one token's residual stream at layer 2, and the rollouts it supports still cross walls (Ivanitskiy et al. 2023).
- **[[wiki/concepts/pattern-separation-completion.md]]** — the biological form of the allocate-vs-reuse decision: de-aliasing (hardness 3) and retrieval are the two ends of one transfer curve mapping input similarity to output similarity, tuned rather than switched (Yassa & Stark 2011).
- **[[wiki/concepts/cognitive-map.md]]** — this framing in its home domain, and the source of a third operation beside discovery and navigation: *anchoring*, fixing which stored structure applies and where the agent currently sits on it, with boundaries and geometry as the cues that do the fixing (Epstein et al. 2017, gap G39).
- **[[wiki/concepts/path-integration.md]]** — the compressed alternative to storing a graph, and the wiki's first mechanism (rather than brainstorm) for path-consistency of `g`: identity accumulated from actions, so new nodes cost nothing and generalisation needs no graph matching (Whittington et al. 2022).
- **[[wiki/concepts/successor-representation.md]]** — what a state-space is *for*, once discovered: a discounted future-occupancy matrix that makes value a linear read-out and multi-step planning a spectral operation. It is also the only *measured* form of a biological graph estimate — symmetric, traffic-weighted, non-Euclidean — which sets what "discovered" should mean here (Garvert et al. 2017).
- **[[wiki/entities/cscg.md]]** — hardness source 3's clone-cell answer built: a frozen 0/1 emission per observation converts state-space discovery into transition learning, fast and local, with zero transfer. It also carries this page's evidence that source 3 is a *separate* requirement from task success: sequence models solve the aliased task without splitting the nodes.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the two-level hierarchy realised end-to-end: a shared path-integrating meta-graph plus a one-shot relational memory binding this instance's contents, trained only to predict the next observation, and the source of this page's node-vs-edge measure of how much meta-graph a system has.
- **[[wiki/entities/temporal-context-model.md]]** — the cheapest graph-metric recovery in the wiki: edges presented in random order produce an embedding whose inner products fall off with graph distance, from one normalised leaky integrator plus a Hebbian outer product, with no objective, no search and no supplied node ordering.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — the map-selection step the framing presupposes: a nonparametric posterior deciding which stored graph generated the current observations and when to allocate a new one, with the correspondence (orientation) of each candidate graph maximised before the comparison.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the parallel-discovery reading of this framing: instead of one posterior over one graph, many partial estimates built redundantly over different input spaces and integrated by consensus, which relocates the hard step from inference to arbitration (G43).
- **[[wiki/concepts/objective-identifiability.md]]** — the identifiability failure one level above G16: not only is the intended graph unidentifiable from the data, the *objective* is unidentifiable from a system that has learned one — so no emergence experiment can tell this framing which loss to write down.
- **[[wiki/entities/tem-transformer.md]]** — the two-level split stated in a transformer's own terms: the action-keyed transition operators are slow weights holding the meta-graph, the key/value cache is this environment's instance-graph, and the causal mask *is* the store growing as evidence is gathered.
- **[[wiki/entities/spiking-tem.md]]** — turns hardness source 3 from an obstacle into the *cause*: sweeping observation ambiguity while holding the architecture fixed shows a structural code emerges only in the ambiguous regime and vanishes when observations identify the state, which predicts that a richly-observed domain will not grow a meta-graph no matter what objective is applied.
- **[[wiki/entities/mm-tem-hippoformer.md]]** — a third implementation of the instance level, and the first where it is a *function* rather than a store: the meta-graph lives in slow weights that generate an action-conditioned transition operator, this environment's `g`–`x` bindings live in the fast weights of a small MLP, and the write is a gradient step scaled by prediction error instead of a Hebbian outer product or a cache append.
- **[[wiki/concepts/population-geometry.md]]** — the graph estimate seen as a surface instead of as nodes and edges: task variables are coordinates on it, sequences are paths, and the fraction of geometry that transfers between two brains through one rotation (69–75%) is the closest measurement the wiki has of how much of a recovered structure belongs to the *task* rather than to the learner.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — supplies a *within-step* schedule this framing assumes away: which excitatory source drives the code is handed over mid-traversal of a single node (entorhinal prediction on entry, recurrent retrieval on exit) by two different inhibitory channels, so "estimate the graph" and "read the stored transition" are time-multiplexed inside one step rather than summed.
- **[[wiki/entities/sparse-distributed-memory.md]]** — a complete storage-and-addressing layer with the discovery layer absent by construction, and explicit about the cost: the memory assigns no meaning beyond a reliability estimate, so its usefulness rests entirely on an upstream encoder in which Hamming distance already equals semantic distance. Sequences are stored as pointer chains (`address = previous word`), which represents a path but not a branching graph.
- **[[wiki/entities/dense-sequence-memory.md]]** — the capacity budget any discovered graph must be stored within, measured on the degenerate graph: nodes supplied, exactly one edge per node, and the only derived quantity is how many edges can be traversed before one bit flips and the trajectory is lost for good.
- **[[wiki/entities/context-modular-memory-network.md]]** — a multigraph store with the discovery layer absent: one fixed edge set, one binary mask per graph, edges shared across graphs, switching graphs free of plasticity — the substrate a library of environment structures needs, and the demonstration that the edge set can even be random, but with neither of the two operations that make it a library (which mask applies now, where new masks come from).
- **[[wiki/concepts/sparse-distributed-representations.md]]** — prices hardness source 3 (aliasing) and nothing else: given distinct sparse high-dimensional codes for two graph positions, the false-merge rate of deciding "have I been here before" is a named number that does not grow with the number of known positions, so de-aliasing stops being a mechanism problem and becomes an encoder problem.
- **[[wiki/entities/dendritic-ann.md]]** — a prior placed on the *edge set* instead of on weights: a fixed mask declares which input variables may interact before any interaction is learned, which is this page's hypothesis space narrowed by hand — and a learned mask would be the discovery step itself (Chavlis & Poirazi 2025).
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — two corrections to how an inferred graph should be read, from the one connectome anyone has traced by hand: cortex distinguishes *driver* edges (set what the target represents) from *modulator* edges (set only how strongly), so a single-edge-type graph is under-specified; and because recurrent amplification lets a <10% input select the circuit's state, an edge's magnitude is a poor estimator of its causal influence (Douglas & Martin 2004).
- **[[wiki/entities/thousand-brains-theory.md]]** — parallel partial estimation with consensus replacing a single posterior, plus a constraint the plain version lacks: agreement is required at matched positions in a reference frame, so a surviving hypothesis has passed a pose test rather than a label test.

- **[[wiki/concepts/memory-allocation-excitability.md]]** — an edge-writing mechanism whose criterion is *when* rather than *what*: two episodes encoded inside an hours-long excitability window are allocated to overlapping cell populations and are thereby linked, with no comparison, no retrieval and no similarity metric — the cheapest relation-writing operation in the wiki, and one that cannot distinguish a causal pairing from a coincidental one.
- **[[wiki/concepts/temporal-coding.md]]** — the cheapest existence proof that a *latent* variable can be estimated by a purely local unsupervised rule: Hebbian selection over a bank of random axonal delays tunes a coincidence detector to the interaural time difference, recovering sound azimuth with no teacher, no target and no backward pass — and it is also the sharpest statement of the limit, since the result is a bank of independent detectors with no relations between them (Gerstner et al. 1996).
- **[[wiki/concepts/attractor-dynamics.md]]** — relaxation supplies the discrete, re-recognisable node set the framing presupposes (G27) and supplies no edges.
- **[[wiki/concepts/recall-gated-consolidation.md]]** — a promotion criterion for edges moving from the instance-graph into the meta-graph: an edge is written to slow **W** only if the fast store already recalls it, so recurrence across encounters — not reward, not error magnitude — decides what becomes shared structure.
- **[[wiki/entities/btsp-cam.md]]** — a node store for the instance graph priced out end to end: one-shot, 1 bit per weight, read in one step, with traces for similar items actively pushed apart at learning time. It supplies vocabulary and no structure — the traces are unordered and unlinked — so it sits on the node side of this framing's node/edge split with the edges still owed to a second rule.
- **[[wiki/concepts/manifold-constrained-learning.md]]** — a network-level bound on the discovery half: a population cannot quickly learn to express activity patterns outside the span it already has, so whatever structure is recovered must be representable in the current latent basis — identifiability constrained by the learner's own geometry rather than by the data (Sadtler et al. 2014).
