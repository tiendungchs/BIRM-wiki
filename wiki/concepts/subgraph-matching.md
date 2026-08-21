# Subgraph Matching

**Decide whether a query relational pattern occurs inside a larger stored graph — and where. Formally: given target `G_T = (V_T, E_T)` and query `G_Q = (V_Q, E_Q)`, find every `H ⊆ G_T` isomorphic to `G_Q` (bijection `f: V_H ↦ V_Q` with `(f(v), f(u)) ∈ E_Q` iff `(v,u) ∈ E_H`, matching node/edge features too). NP-complete.**

This is the wiki's third graph operation, and the one it had been assuming without a mechanism. [[wiki/concepts/latent-graph-discovery.md]] covers *discovery* (recover the graph) and [[wiki/concepts/simulation-based-planning.md]] covers *navigation* (search a path in it). Neither says how a stored structure gets *recognised in* a new situation — which is the step every schema-based mechanism in the wiki silently performs.

| Where the wiki already assumes matching | The assumed operation |
|---|---|
| Instance-graph binding as "binding, not learning" ([[wiki/concepts/latent-graph-discovery.md]]) | Find the meta-graph fragment whose slots this instance fills |
| Event schema ⟨precondition, transition, effect⟩ firing ([[wiki/concepts/event-segmentation.md]]) | Test whether the precondition pattern holds of the current state |
| Core-knowledge **entry conditions** ([[wiki/concepts/core-knowledge.md]]) | Decide whether the input is in this system's domain |
| Analogy / structure-mapping (Gentner 1983, cited by Ying et al. 2020 as a subgraph-matching application) | Map the relational skeleton of a base onto a target |
| Retrieval from a fast **M** store keyed by structure rather than content | Query a memory by *shape* |

> **Provenance.** Ying, Wang, You, Wen, Canedo & Leskovec 2020, *Neural Subgraph Matching* (`raw/ying-2020-neural-subgraph-matching.md`). The architecture is [[wiki/entities/neuromatch.md]]; this page holds the transferable ideas.

---

## Why the exact route does not scale

| Method class | Behaviour |
|---|---|
| Exact combinatorial (Ullmann 1976; VF2, Cordella et al. 2004; RI, Bonnici et al. 2013) | Always correct, exponential worst case. Success rate drops below 60% at query size > 30 under a 10-minute budget; average 12.8–25.9 s where the neural route takes 0.03–0.04 s |
| Index-then-decompose (Sun et al. 2012) | Scales the *target* by pre-storing all 2–4-node components, but decomposing a query beyond a few tens of nodes becomes its own hard problem |
| Approximate heuristics (FastPFP, IsoRankN) | Convex relaxations / spectral alignment; 50–83 AUROC on the decision problem |
| Motif enumerators (Rand-ESU, MFinder, Motivo, ORCA) | Restricted to motifs of size < 6 — pattern *counting*, not pattern *querying* |

The relevant reading for this wiki: a schema library is useless if checking which schema applies costs exponential time in the schema's size. Matching is a **latency** problem before it is an accuracy problem — the same constraint [[wiki/concepts/amortized-inference.md]] raises for structured inference generally.

---

## The transferable move: put the relation in the geometry

Subgraph containment is a **partial order** over graphs. So embed graphs into a space whose geometry *is* a partial order, and the relational query collapses into a coordinate comparison.

**Order embedding constraint** (McFee & Lanckriet 2009), with `D` the embedding dimension:

```
z_q[i] ≤ z_u[i]  for all i = 1..D      iff      G_q ⊆ G_u
```

**Violation energy and max-margin loss** (`P` positives, `N` negatives, margin `α`):

```
E(z_q, z_u) = ‖ max{0, z_q − z_u} ‖²₂
L = Σ_P E(z_q, z_u) + Σ_N max{0, α − E(z_q, z_u)}
f(z_q, z_u) = 1  iff  E(z_q, z_u) < t
```

Four algebraic properties of the subgraph relation are then satisfied *by construction* rather than learned:

| Property of subgraph relation | Geometric counterpart |
|---|---|
| Transitivity (`G₁ ⊆ G₂ ⊆ G₃ ⟹ G₁ ⊆ G₃`) | `≼` is transitive on coordinates |
| Anti-symmetry (mutual containment ⟹ isomorphic) | `z₁ ≼ z₂ ≼ z₁ ⟹ z₁ = z₂` |
| Common subgraphs of `G₁, G₂` form a set | `z₃ ≼ z₁` and `z₃ ≼ z₂` ⟹ `z₃ ≼ min{z₁, z₂}` — the elementwise min is itself a valid embedding, i.e. the meet exists |
| Any two graphs share at least the trivial graph | Embeddings are positive, so a lower bound always exists |

**This is an architecture-slot answer with numbers attached** ([[wiki/concepts/three-component-framework.md]]): swapping the order-embedding loss for a learned comparator — an MLP with cross-entropy, a neural tensor network, or box embeddings — costs 2–5 AUROC points *and* an order of magnitude in query time, because a learned comparator must be run per pair while a geometric one is a coordinate test. Box embeddings lose specifically because they cannot guarantee a non-empty intersection.

**Composition survives message passing** (Observation 2 in the source). With **sum** aggregation, if all layer-`k−1` embeddings satisfy the order constraint then so do the layer-`k` embeddings: growing a neighbourhood by one hop is monotone in the embedding. Subgraph composition and message-passing composition are the same operation, which is why a curriculum over query complexity helps (below) and why sum aggregation beats mean/max here.

---

## Locality: matching decomposed into anchored neighbourhoods

A `k`-layer GNN embedding of node `u` *is* an embedding of `u`'s `k`-hop neighbourhood `G_u`. So the global problem is replaced by many local ones:

| Stage | Operation | Cost |
|---|---|---|
| **Embedding (offline)** | For every `u ∈ G_T`, embed the `k`-hop neighbourhood `G_u` | `O(K·\|E_T\|)`, precomputable before any query arrives |
| **Query** | Embed each `q ∈ G_Q` anchored at `q`; compare all pairs → alignment matrix `A_{ij} = f(z_i, z_j)` | `O(K·\|E_Q\|)` + `O(\|V_T\|·\|V_Q\|)` comparisons |
| **Decision** | Aggregate `A` — plain **mean** of entries beat the Hungarian algorithm on the binary decision | negligible |

Two details that generalise beyond this task:

- **Voting** (Observation 1/3): if `q` matches `u`, then every `i ∈ N^(k)(q)` must have some matching `j ∈ N^(l)(u)`, `l ≤ k` — the query's shortest paths are upper-bounded by the target's, since a subgraph cannot create shortcuts. Rejecting a pair when any neighbour fails is a cheap consistency check over the *neighbourhood* of a candidate match. This is the local-consistency propagation of classical constraint satisfaction, run in embedding space.
- **Anchoring buys expressive power.** One-hot marking the anchor node distinguishes computation graphs that plain message passing cannot (3-cycle vs. 4-cycle and other `d`-regular cases), lifting the model above the Weisfeiler-Lehman ceiling that limits GIN-class networks — the ID-GNN trick. **Identity is injected as a feature, not derived.**

**(brainstorm)** The anchor is the same device the framing calls `g`: a marker saying *which position in the structure I am currently at*, carried alongside content. Here it is one bit per node and it is what makes an otherwise position-blind encoder able to tell structurally distinct positions apart — the cheapest possible instance of the `g`/`x` split ([[wiki/concepts/abstract-structural-codes.md]]), and evidence that the split is worth points even in its most degenerate form.

---

## Results (Ying et al. 2020)

| Task | NeuroMatch | Best baseline |
|---|---|---|
| Neighbourhood matching (Problem 2), AUROC×100, 7 datasets | 89.3–97.9, median 95.5 | GMNN 72.0–82.5; RDGCN 76.8–82.4 (~20% relative gain) |
| Query-to-target decision (Problem 1), AUROC×100 | 75.2–95.7 | FastPFP / IsoRankN, +18.4% average gain |
| Query latency | 0.03–0.04 s | VF2 19.7–25.9 s; RI 7.5–12.8 s; learned-comparator variant 0.44–0.49 s |
| Curriculum ablation | +6% average, lower variance, faster convergence | — |
| Transfer: train on synthetic Erdős-Rényi / Barabási graphs only, test on real | 74.2–93.9 AUROC×100 | vs. 81.8–97.2 in-domain; beats some baselines *trained on the target dataset* |
| Cross-sampling-strategy generalization (train BFS → test MFinder / random walk) | 98.4–98.8 | — |

The transfer row is the strongest general claim: **structural matching skill learned on random graphs transfers to chemistry, biology, image and social-network graphs without fine-tuning.** Structure is domain-general in exactly the way the meta-graph is supposed to be. The stated caveat is decisive — the synthetic graphs carry no node features, so only feature-blind matching transfers, and feature-aware transfer is left open.

---

## Limits, and the one that matters most

- **No certificate.** An approximate matcher cannot say when it is wrong; exact methods are the only source of ground truth and they are the thing being replaced. A schema-retrieval mechanism built this way inherits an un-flagged error rate (gap G37).
- **AUROC hides the deployment metric.** On DD with small queries the average confusion matrix is TP 68.2 / FN 8.3 / FP 70.5 / TN 1030.9 — recall 89%, **precision 49%** — at 97.9 AUROC. Subgraph hits are rare, so a ranking metric on a balanced sample says almost nothing about a matcher run against a whole memory. See [[wiki/empirical-tensions.md]] T22.
- **Depth must cover the query.** `k` must be at least the query's diameter (`k = 10` sufficed by small-world-ness; test queries capped at diameter 8). Pattern size is bounded by network depth — an architectural, not a learned, limit.
- **Topology is not enough to license a match** (Forbus, Gentner & Law 1995, [[wiki/entities/macfac.md]]). A separate objection to the whole framing, from the analogy literature: two isomorphic structures with no shared relational *content* are not a match that a reasoner should accept — "Fred loves New York" / "General Motors sells cars". Structure-mapping's answer is **tiered identicality**: relations must match identically or be re-represented into a canonical form until they do, while functions and entities may be substituted freely. A purely structural matcher — this page's included — has no version of that test, and the measured cost of loosening it is on record: ARCS's WordNet-graded predicate similarity is what generates most of its false positives, and removing it repairs them without changing the architecture. **Node/edge labels are not decoration on a graph query; the strictness of the label test is what sets precision.**
- **Connected, feature-limited queries.** Disconnected queries must be split; feature transfer is unsolved.
- **The expressivity ceiling is inherited, not fixed.** Anchoring pushes past WL for `d`-regular cases; the backbone remains a message-passing GNN and the source explicitly leaves stronger backbones as future work.

---

## What this gives a reasoning model (brainstorm)

- **A lattice of schemata, readable from coordinates.** If a library of meta-graph fragments is embedded under the order constraint, "which schema applies here?" is a range query for points to the lower-left, and "which schema is more general?" is a coordinate comparison — the abstraction hierarchy is *implied by the geometry* instead of stored as extra edges. Embedding magnitude tracks graph size in the reported t-SNE, so generality has an axis.
- **Retrieval becomes an amortisation target, not a search.** Target embeddings are computed offline and reused across every query — the slow **W** / fast **M** split applied to a memory: expensive structural encoding pooled across episodes, cheap per-episode query ([[wiki/concepts/amortized-inference.md]]).
- **The energy is already an energy.** `E(z_q, z_u) = ‖max{0, z_q − z_u}‖²₂` trained with a hinge and negative samples is a contrastive latent-free EBM in the sense of [[wiki/concepts/energy-based-models.md]] — with the unusual property that it *cannot* collapse: the asymmetry of `max{0, ·}` means a constant encoder gives zero energy to positives **and** to negatives, which the margin term punishes. Order structure is an anti-collapse device (gap G34).
- **Curriculum is not a training trick here.** Queries grow from 1-hop upward as performance plateaus, and the source attributes the +6% to the *compositional* nature of the task: a larger pattern is built from matched smaller ones, so the order constraint at hop `k` is only learnable once hop `k−1` holds. That is a concrete case of [[wiki/concepts/compositionality.md]] dictating a training schedule, and a partial answer to gap G32's "nothing designs the experience stream".

---

## Connections

- **[[wiki/entities/neuromatch.md]]** — the architecture this page is drawn from: GIN-with-skips encoder, order-embedding loss, anchored neighbourhood decomposition, voting.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the third operation the framing needs: discovery recovers a graph, navigation searches it, matching decides whether a stored fragment occurs in a new one — which is what "instantiation is binding, not learning" presupposes.
- **[[wiki/concepts/amortized-inference.md]]** — matching is the case where amortisation is *structural*: an NP-complete relational query is compiled into an offline encoding plus a coordinate comparison, so cost moves from query time to precompute time.
- **[[wiki/concepts/energy-based-models.md]]** — the violation energy is a contrastive EBM whose asymmetric form makes collapse self-punishing, and the four preserved order properties are constraints written into the energy's *shape* rather than into its training data.
- **[[wiki/concepts/compositionality.md]]** — the composition guarantee under sum aggregation, and the curriculum it motivates: a pattern is matched by composing matched sub-patterns, so training must grow query complexity monotonically.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the anchor one-hot is the minimal `g`: a marker of *which position* the encoder is describing, and the sole reason the model exceeds the Weisfeiler-Lehman limit.
- **[[wiki/concepts/event-segmentation.md]]** — event schemata fire when their precondition pattern matches the current state; this page supplies the missing mechanism for that test, and the diameter bound says how large a precondition may be.
- **[[wiki/concepts/core-knowledge.md]]** — entry conditions are matching queries over a fixed schema library, which is what makes the library's *retrieval* cost, not just its contents, an architectural question.
- **[[wiki/concepts/attention.md]]** — the alternative retrieval mechanism: attention scores content similarity against a soft one-step adjacency, where an order embedding scores *containment* of a whole multi-hop pattern, which is what a schema query needs and dot-product similarity cannot express.
- **[[wiki/concepts/working-memory.md]]** — the store this operation would query: a fast **M** keyed by structural shape rather than by content vector.
- **[[wiki/concepts/contextual-inference.md]]** — the statistical counterpart of the same retrieval step: this page tests *does this pattern occur here* geometrically and deterministically, contextual inference tests *which of my stored models is generating this* probabilistically and sequentially, and only the latter also decides when to allocate a new structure.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the same retrieval query answered by attractor dynamics instead of an order embedding: does this fragment occur in the store, resolved by settling rather than by a coordinate comparison.
- **[[wiki/concepts/cognitive-map.md]]** — names what happens after a match succeeds: the correspondence must be given an orientation and offset (anchoring) before positions in the retrieved structure can be read, which is the step matching stops short of.
- **[[wiki/concepts/attractor-dynamics.md]]** — the rival answer to G37 — explicit structural comparison scales with library size where relaxation does not, and returns a score where relaxation returns only a state.
- **[[wiki/concepts/equilibrium-propagation.md]]** — the concrete opening for a matching objective: splitting the energy as `F = E + βC` decouples the cost from the network, so a structural matching score is exactly the kind of `C` that contrastive Hebbian learning and the Boltzmann machine may not choose and this decomposition may.
- **[[wiki/entities/irene.md]]** — the same relational message-passing toolkit pointed at a scene instead of a query graph (GraphSAGE with per-edge-type weights, learned aggregators for inductivity), and with the same boundary: the edge set is hand-written spatial predicates, so what is learned is node embedding, never edge existence.
- **[[wiki/concepts/program-induction.md]]** — the retrieval half of library re-use: before a stored sub-program can be recombined it must be found and aligned, which is this page's query approximated in an order-embedding space.
- **[[wiki/concepts/retrieval-capacity.md]]** — the term this page's amortisation argument is missing: precomputing target embeddings is what makes structural retrieval `O(1)` per query and simultaneously bounds how many distinct query answers a `D`-dimensional geometry can realize, with the un-amortised joint scorer the only architecture that escapes the bound (Weller et al. 2026).
- **[[wiki/entities/dinov2.md]]** — the matching operation run over learned features instead of a graph: patch-to-patch assignment (ℓ₂ distance + assignment + non-maximum suppression) between images of *different* objects recovers functionally corresponding parts, which is a label-free correspondence probe with no node or edge labels supplied.
- **[[wiki/entities/learningmatch.md]]** — the continuous counterpart of this page's query, and the case that bounds its lesson: containment is transitive so an order embedding encodes it exactly and beats every learned comparator, while a *curved metric* over a continuous parameter manifold has no such algebraic handle and the learned comparator becomes the only component that matters.
- **[[wiki/concepts/representational-collapse.md]]** — the one energy shape that makes the degenerate solution *self-punishing*: the asymmetric hinge encodes an order relation that a constant embedding violates rather than satisfies, so no separate provision is needed.
- **[[wiki/entities/macfac.md]]** *(also)* — the source of the sharpest objection to a purely topological match criterion (tiered identicality: relations identical or re-represented, functions and entities free) and of the measurement behind it — loosening the label test is what generates false positives, independently of the search machinery. And: the same filter-then-verify skeleton with a *derived* filter: functor counts bound the number of match hypotheses the exact matcher would generate, so over-counting is the only failure direction — the soundness argument a learned order embedding cannot make, and the reason this page's missing certificate (G37 (i)) is a property of the estimator's construction rather than an add-on.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the same retrieval question answered at the other end of the pipeline: this page makes the *comparator* structural (order embedding over a GNN encoding) where an HRR keeps the comparator a dot product and makes the *code* structural, and reproduces the full MAC/FAC ordering `LS > AN^cm > AN > SS > FA` in 100/100 runs without any alignment search (Plate, NIPS 7).
- **[[wiki/concepts/analogical-mapping.md]]** — the step after the match: containment says a stored structure applies, mapping says which node is which, and it is the operation whose `O(n⁴)`–`O(n!)` cost (ACME, SME) is the historical reason this page exists — reduced to `O(n²)` dot products by an episode-dependent re-encoding rather than by a learned embedding.
- **[[wiki/entities/ilp-arc-synthesizer.md]]** — the same matching step done by brute-force enumeration of candidate object pairs within and across grids, at a scale (a handful of typed objects) small enough that no approximation is needed — the control case for what the order-embedding machinery is buying.
- **[[wiki/concepts/circuit-size-separation.md]]** — the atomic case of this page's operation, priced: *does any element of one pattern coincide with the corresponding element of another* is Maass's `CD_n`, computed by a single spiking neuron using delays alone and all weights 1, against `≥ n/log(n+1)` threshold gates or `Ω(n^{1/4})`–`Ω(n^{1/2})` sigmoidal units.
