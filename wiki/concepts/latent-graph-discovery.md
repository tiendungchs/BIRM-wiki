# Latent Graph Discovery

**CORE PROBLEM FRAMING — The unified problem a brain-inspired reasoning model must solve.**

**Latent graph discovery (LGD) = infer the structure (nodes, edges, topology) of a relational graph from observations, then navigate it — where the graph is never given explicitly and must be recovered from partial, aliased, or sequential evidence.**

Working claim: abstract reasoning, analogy, planning, mathematics, navigation, and scientific discovery all reduce to recovering an implicit relational structure and using it to generate predictions, plans, or inferences.

> **Epistemic status — a chosen lens, not an established reduction.** Biologically warranted as a *substrate* on the **metric / transition-sampled slice** (structure that is orderable, continuous, or learned from traversal). On the **non-embeddable symbolic slice** (modular arithmetic, syntactic recursion, type-checking) it is untested and remains a bet. Rival one-problem reductions — program induction, probabilistic language of thought, free-energy attractor dynamics — explain the same data and are mutually foldable with navigation, so folding any of them *into* "navigation over a hypothesis graph" is a modeling choice, not a finding.

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

**Edge-label-latent vs. path-latent** — the two discriminators are *single edge vs. composed sequence* and *is the vocabulary known?*
- **Edge-label latent** — many (start, end) pairs given; infer the one transformation mapping input→output.
- **Path latent** — one (start, end) pair; vocabulary already known; find the *sequence* connecting them.

**"Topology given" ≠ "the solver knows the graph."** It is the technical claim that adjacency is *fixed in advance by an explicit map or by known rules*, so no structure-learning-from-observation is required. The graph may still be astronomically large and mostly dark. Edge *existence* and edge *semantics* are orthogonal: an affordance can be enumerable (topology given) while what it does is latent (label ✓, vocabulary ✓).

*Benchmark × latent-variable mapping: to be filled by ingests.*

---

## Two-Level Graph Hierarchy

Every domain is a **family of environments**, not one environment: shared laws instantiated per task with different objects and bindings — `p(obs) = ∫ p(obs | θ_shared, θ_inst) p(θ_inst) dθ_inst`. Three consequences:

- **A flat model fits the wrong object** — a single-level estimator fits the mixture `E_θ[p(obs|θ)]`, a distribution no individual instance follows. "OOD failure" is what fitting a mixture to a component means.
- **Sample budgets differ by orders of magnitude** — a few demonstrations per instance vs. unlimited episodes per family. Parameters must split *by sample budget*: pooled/slow vs. low-dimensional residual/fast. The hierarchy is a **sample-complexity decomposition** before it is a cognitive claim (MDL: `|θ_shared| + N·|θ_inst|` beats `N·|instance|`).
- **Instantiation is binding, not learning** — the meta-graph is a schema with free slots; the instance-graph binds them, so acquisition can be one-shot.

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

---

## Sources of Hardness

| Source | Description | Architectural implication |
|---|---|---|
| **1. Two-level entanglement** | Meta-graph rules and instance quirks co-occur in every observation | Factorized latent space + two learning rates |
| **2. Unknown vocabulary** | Action set and/or node types not given; inferred alongside structure | Learnable observation and transformation embeddings |
| **3. Observation aliasing** | The same observation occurs at structurally distinct positions | Clone cells or path-integrated identity |
| **4. Simultaneity** | Structure must be inferred *while* navigating — no discovery-then-use separation | Joint loop: update graph estimate and navigate concurrently |
| **5. Spurious edges** | Training correlations produce false edges that work in-distribution and fail out of it | Force invariant causal edge discovery across environments; explicit intermediate-node traversal |
| **6. Non-stationary topology** | The edge set rewrites *within a single episode*, violating the fixed-but-hidden assumption shared by 1–5 | Discover the stationary generator of the rewrites; re-infer the instance-graph online |

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
| Instance-graph binding | Fast Hebbian M within episode |
| De-aliasing | Path-context-sensitive identity (clone cells or path-integrated g) |
| Path-consistency | g must commute: same meta-graph position via any path |
| Vocabulary learning | Observation + action embeddings learnable, not fixed |
| Causal edge invariance | Edges learned from invariant causal structure, not i.i.d. correlations |
| Multi-level hierarchy | W itself structured as a discoverable graph (open problem) |

---

## Formal Ceiling

**AIXI** (Hutter 2000) is the only known system satisfying all six hardness sources at once: a Bayesian mixture over *all computable environments* — hence over all latent graphs, vocabularies, aliasing structures, and topologies, including non-stationary ones — acting by expectimax. Conditioning on full history resolves aliasing; topology change is absorbed into the environment posterior. It fails only on computability. Every real architecture is a bounded-program approximation, failing on whichever hardness sources its search budget cannot reach.

*Architecture-by-architecture scoring against the six sources: to be filled by ingests.*

---

## Open Problems

- **The non-embeddable symbolic slice** — does the navigation frame survive structure with no metric embedding (modular arithmetic, syntactic recursion)?
- **Multi-level hierarchy** — making W itself a discoverable graph rather than a flat meta-graph.
- **Vocabulary co-discovery at scale** — inducing primitives *and* their semantics without a hand-given DSL, beyond toy domains.
- **Reliable self-generated intermediate nodes** — traversal degrades when the model must produce its own intermediate structure.
- **Routing** — which structures belong to the transition-sampled (hippocampal-analog) module vs. a declarative/relational one.

---

## Connections

*Empty — populated as concept and entity pages are created by ingests.*
