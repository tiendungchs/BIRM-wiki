# Higher-Order Interactions — When the Relation Is Not Between Two Things

**A graph can only say that `i` relates to `j`. If the structure that matters is a relation among three or more elements — one that is not the sum of its pairs — then no adjacency matrix contains it, and no pairwise estimator can find it. The generalisations that do contain it (simplicial complexes, hypergraphs) come with a second object a graph has no word for: the **cavity**, a region where edges are conspicuously *absent*, which is structure carried by what is missing.**

> **Provenance.** Bassett & Sporns 2017, *Network neuroscience*, Nat Neurosci 20(3):353–364, doi:10.1038/nn.4502 (`raw/bassett-2017-network-neuroscience.md`), Figure 3 and the "Network analysis and modeling" section. A review; the applied-algebraic-topology results it points to are Giusti et al. and Sizemore et al. on cortical microcircuits. Nothing here is a computational result about reasoning — this page is the formal vocabulary plus one empirical hook, imported because every graph-discovery mechanism in the wiki is dyadic by construction.

---

## The objects

| Object | Definition | What it buys over a graph |
|---|---|---|
| **`k`-simplex** | A set of `k+1` all-to-all connected nodes, treated as **one unit**: 0-simplex = node, 1-simplex = edge, 2-simplex = filled triangle, 3-simplex = tetrahedron | The relation itself becomes a first-class element, rather than being reconstructed from its projections |
| **Simplicial complex** | A collection of simplices closed under taking faces | The generalisation of a graph that encodes non-dyadic relations |
| **Clique** | An all-to-all connected subgraph of any size | Structurally predisposed to **integrated** codes — every member sees every other |
| **Cavity** | A collection of `n`-simplices arranged so that they have an **empty geometric boundary** | Structurally predisposed to **segregated** codes — a hole in the relational fabric, i.e. information that a graph statistic records only as low density |
| **Hypergraph** | An edge may join any number of nodes | The same goal by a different route; no closure requirement |
| **Filtration** | Represent a *weighted* complex as a nested sequence of *unweighted* complexes, indexed by a threshold `τ` (or by time) | Replaces "pick a threshold" with "sweep it and keep the whole trajectory" |
| **Persistent homology / Betti curves** | Track when each cavity is created and when it collapses along the filtration; `β_n(τ)` counts `n`-dimensional cavities at each step | A threshold-free summary of a weighted network, with birth/death of features as the measurand |

**Two neighbouring generalisations from the same review**, kept here because they answer the same complaint — "a plain graph cannot say this":

| Generalisation | What it adds | Where it is used |
|---|---|---|
| **Multilayer networks** | Nodes connected by several *types* of edge, each type in its own layer, with **identity links** joining a node to its own copy in other layers to hard-code their non-independence. Layers = time points, subjects, tasks, states, ages, or imaging modalities | The principled way to hold structural and functional connectivity in one model; also the way to nest scales, since one node at a coarse layer becomes a *set* of nodes in the finer layer |
| **Annotated (decorated) graphs** | Attributes on nodes alongside edges — gene expression, cytoarchitecture, activity magnitude, morphology | Bridges nodal (univariate/multivariate) analyses with relational ones, so "what this node is" and "what it connects to" enter one model. See [[wiki/concepts/node-definition-problem.md]] |

---

## The empirical hook

Applied to structural connectivity of **cortical microcircuits**, algebraic-topological methods find, against a null:

- unexpectedly **high numbers of directed all-to-all connected cliques** of neurons;
- **cavities** — regions where edges are conspicuously absent.

Both are statements about non-random structure that dyadic statistics on the same matrix do not report. The review's framing of *why* the brain should have them: neural systems appear to employ higher-order interactions, and those interactions increase the complexity of the codes that produce the behavioural range observed.

---

## Why this matters for a reasoning model

- **The target relations are already n-ary, and the discovery machinery is not.** The wiki's relational benchmarks are built from non-dyadic relations: an ARC transformation, a Raven's row, a PGM triple `(relation, object, attribute)` ([[wiki/entities/pgm.md]]). The wiki's *representations* can hold them — vector-symbolic binding composes `n` factors, tensor products are `n`-way by construction ([[wiki/concepts/vector-symbolic-binding.md]]). But every **discovery** mechanism here estimates pairs: attention is a query–key matrix, Hebbian co-fluctuation is a covariance, inverse covariance is a precision matrix, transition counting is over `(s, s')`. A three-way regularity present only in the triple is not merely hard to find — it is not in the hypothesis space. Logged as `G105`.
- **Absence as structure.** A cavity is defined by the edges that are *not* there, arranged so that the boundary does not close. No weighted-adjacency statistic in the wiki treats a missing edge as anything but a small number, and the pages that most need it — walls and blocked corridors in a world model, the "every edge exists" failure of installed-manifold architectures noted at `G6` — are asking for exactly this: a representation in which *unreachability* is a positive fact.
- **Filtration is the disciplined answer to the thresholding problem the wiki has already priced.** [[wiki/concepts/latent-graph-discovery.md]] shows that discovery-by-thresholding is ill-posed on sparse graphs at any estimator quality — ≈6% precision at 80% recall on a 3%-dense graph, ≈28% even with the exact generating couplings ([[wiki/concepts/function-to-structure-inference.md]]). The persistent-homology move is to stop choosing: sweep `τ` from "no edges" to "all edges" and keep the features that *survive* a long stretch of the sweep. **(brainstorm)** That converts a binary edge decision with terrible precision into a persistence score, and it is directly runnable on any learned weight matrix or attention map — the reported object being a Betti curve rather than a thresholded graph.
- **Multilayer nesting is the formal statement of the two-level hierarchy's *representation*, not its learning.** One node at a coarse layer = a set of nodes at the finer layer, with identity links carrying the non-independence — which is the meta-graph/instance-graph relation of [[wiki/concepts/latent-graph-discovery.md]] written as one object rather than two. It does not supply the *learning* split (that is the sample-budget argument), but it does say the two levels need not live in separate data structures.

---

## Open problems

- **No demonstrated predictive payoff.** The review reports that topological methods *find* non-random cliques and cavities. Nothing cited shows a higher-order feature predicting behaviour, function or a transition better than a pairwise one — the case for the extra machinery is currently structural, not empirical.
- **Cost.** Persistent homology over a dense weighted complex is expensive in the number of nodes and in the simplex dimension; the review gives no complexity figures and no guidance on where the cut-off should be.
- **Nothing learns hyperedges.** Every method here *analyses* a complex that is already given by thresholding a measured matrix. There is no estimator that infers a three-way relation directly from data the way covariance infers a pair — which is the actual missing component.
- **What a cavity means functionally is asserted.** "Cliques → integrated codes, cavities → segregated codes" is the review's reading of the geometry, not a measured relation to any code.
- **The node set problem is inherited whole.** A simplex is a set of nodes, so every indeterminacy on [[wiki/concepts/node-definition-problem.md]] — granularity, soft membership, state-dependence — propagates upward, and a coarser parcellation swallows higher-order structure faster than it swallows edges.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — the constraint this page places on that framing: its formalisation defines edges as pairs, so a domain whose regularity is genuinely `n`-ary is outside the stated hypothesis space; and its thresholding-is-ill-posed result is what makes filtration/persistence the right reporting object rather than a single recovered edge set.
- **[[wiki/concepts/node-definition-problem.md]]** — the upstream half of the same complaint: that page shows relational content moves between nodes and edges as the units change, this one shows a further slice of it lives in relations of order > 2 that neither unit nor edge can hold — and supplies the annotated-graph formalism for putting nodal attributes and edges in one model.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — what its six converging measures cannot see: degree, betweenness, k-core and participation are all functions of a dyadic adjacency matrix, so a clique or a cavity in the same data is scored only through its pairwise shadow.
- **[[wiki/concepts/network-control-theory.md]]** — the same review's other generalisation, and one this page limits: minimum-energy control is computed on a dyadic `A`, so higher-order structure is outside the controllability calculation by construction.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the representation side of `n`-ary relations, already solved: an associative binder plus superposition holds a whole relation with any number of role–filler pairs in one fixed-width vector, and a bound relation can itself fill a role — so what is missing is a *discovery* operator for higher-order structure, not a way to store it.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the quantitative reason to prefer a persistence sweep to a threshold: precision at any single operating point is ≈6–28% on a sparse graph, so a feature's *survival across thresholds* is a better-conditioned statistic than its presence at one.
- **[[wiki/concepts/tensor-product-representation.md]]** — where the representational answer to `n`-ary relations comes from, and why arity is not the hard part: recursive role decomposition yields tensors of rank 3 and above whose units stand for `n`-way feature conjunctions, and `left_of(a,b)` reduces to nested one-place roles (`left_of_b(a)`), so multi-argument relations are syntactic sugar over role decomposition — leaving discovery, not storage, as `G105`.
