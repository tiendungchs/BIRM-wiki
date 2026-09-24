# Higher-Order Interactions — When the Relation Is Not Between Two Things

**A graph can only say that `i` relates to `j`. If the structure that matters is a relation among three or more elements — one that is not the sum of its pairs — then no adjacency matrix contains it, and no pairwise estimator can find it. The generalisations that do contain it (simplicial complexes, hypergraphs) come with a second object a graph has no word for: the **cavity**, a region where edges are conspicuously *absent*, which is structure carried by what is missing. And the group term only matters to a reader that is *nonlinear* in the group: any linear process on hyperedges is exactly a process on reweighted pairs.**

> **Provenance.** (1) Bassett & Sporns 2017, *Network neuroscience*, Nat Neurosci 20(3):353–364, doi:10.1038/nn.4502 (`raw/bassett-2017-network-neuroscience.md`), Figure 3 and the "Network analysis and modeling" section — the vocabulary and the cortical-microcircuit hook. (2) Battiston, Cencetti, Iacopini, Latora, Lucas, Patania, Young & Petri 2020, *Networks beyond pairwise interactions: structure and dynamics*, Physics Reports 874:1–92, arXiv:2006.01764 (`raw/battiston-2020-networks-beyond-pairwise-interactions-structure-and-dynamics.md`) — representations and their losses, measures, Hodge Laplacians, generative models, diffusion/synchronization/contagion/games with group terms, estimation from time series, and applications. Both are reviews; every number below from (2) is carried second-hand from the primary it names, and none is about reasoning.

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

## Which representation loses what (Battiston et al. 2020, §II)

Worked on one interaction set: `V = {a,b,c,d,e}`, `𝓘 = {[a,b,c],[a,d],[d,c],[c,e]}` — one triple, three pairs.

| Representation | Keeps | Loses or invents | Consequence for a builder |
|---|---|---|---|
| **Graph** (unfold each interaction into its pairs) | Pairwise reachability | **Group identity** — from `{[a,b],[b,c],[c,a],[a,d],[d,c],[c,e]}` nothing says whether `[a,c,d]` was an interaction. Not invertible | Every attention/covariance/transition-count store is this row |
| **Clique complex** (fill every clique) | Groups, if every group is a clique | **Invents** `[a,c,d]` — a fictitious triple assembled from `[a,d]`, `[d,c]` and the `[a,c]` induced by `[a,b,c]` | Recovering groups by clique-finding over a learned graph over-fills; edge-only under-fills. Both errors, opposite signs |
| **Bipartite / incidence matrix** (node layer × interaction layer) | **Everything** — lossless | Nodes never interact directly; every relation is mediated by a layer of a different type, and operators (Laplacian) on it do not translate into the projection's | The one storage format that is both lossless and consumer-agnostic |
| **Motifs** | Which *pattern* of edges each group has | Count grows as `2^{C(r,2)}` graphs on `r` nodes; motif-constrained null models become unsampleable above order 2; constructing a graph with a fixed `dk`-series is NP-complete for `k ≥ 3` | Enumerating candidate relation *types* is the exponential step, not holding them |
| **Simplicial complex** | Groups explicitly, plus boundary operators, homology, Hodge Laplacians | Requires all `2^k` sub-faces of every `k`-simplex | Wrong where a triple acts and no pair does — a three-author paper with no two-author papers, a pathway needing exactly three genes |
| **Hypergraph** | Any group, no closure; hyperedges may even contain hyperedges | Tooling: hypergraph Laplacians are recent and have few applications | The most general and least equipped |

**Conversion rules.** The *facet* list of a simplicial complex (simplices contained in no other) is a bipartite graph in disguise and identifies the complex uniquely, as maximal cliques identify a graph. A hypergraph is the facet list of some simplicial complex **iff no hyperedge is contained in another**. The Hasse diagram (one node per simplex, one edge per inclusion differing by one dimension) is the fully unfolded form, and boundary-built operators move only along its edges.

**Reachability depends on the required overlap.** A `k`-walk steps between hyperedges sharing ≥ `k` vertices; on the same object the `k = 1` walk recovers the underlying graph's connectivity, while `k = 2` already fragments it into mesoscale components. "Connected" is a parameterised relation on a higher-order object, not a property of it.

---

## When a group term changes anything — the reducibility criterion

| Process | With the group term | Reducible to weighted pairs? | Source (via the review) |
|---|---|---|---|
| **Linear diffusion** on a triangle tensor | `ẋ_i = Σ_jk a^Δ_ijk[(x_j − x_i) + (x_k − x_i)] = −2 Σ_j ℓ^Δ_ij x_j`, with `ℓ^Δ` a Laplacian weighted by triangle membership | **Yes, exactly** | Neuhäuser, Mellor & Lambiotte 2020 |
| **Random walk on a hypergraph, edge-independent vertex weights** | Pick an incident hyperedge, then a member | **Yes** — some weighting of the clique projection gives the identical walk; the proof runs through time-reversibility | Chitra & Raphael 2019 |
| **Random walk, edge-*dependent* vertex weights** (a node weighs differently in different hyperedges, e.g. first vs middle author) | Stationary `p_i = Σ_{σ∋i} ρ_σ ω(σ) γ_σ(i)` | **No** — the chain is not time-reversible, so no weighted graph reproduces it | Chitra & Raphael 2019 |
| **Nonlinear hypergraph Laplacians** (flow from the max- to the min-density member of each hyperedge) | Second eigenvalue bounds expansion (Cheeger generalised) | **No** | Louis 2015; Chan et al. 2015 |
| **Nonlinear 3-body consensus** | `ẋ_i = Σ_jk A_ijk s(|x_j − x_k|)[(x_j−x_i)+(x_k−x_i)]`, `s = exp(λ·)` | **No** for `λ ≠ 0`: the mean is no longer conserved — it drifts to the initial majority (`λ < 0`, agreeing co-members reinforce) or to balance (`λ > 0`); `λ = 0` recovers linear consensus | Neuhäuser et al. 2020 |

**Reducible does not mean "same as the naive projection".** A size-weighted hypergraph walk (Carletti et al. 2020) on a hub `h` with `m` size-2 hyperedges and a node `c` in one size-`k` hyperedge: the unweighted clique projection gives stationary `p_h ∝ m`, `p_c ∝ k`; the hypergraph walk gives `p_h ∼ m`, `p_c ∼ 1 + (k−1)²`. The two rankings **invert** for `k + 1 ≤ m ≤ 1 + (k−1)²`. So even a linear reader needs the *right* weights, which the group structure supplies and an estimated pairwise graph does not.

**The `L2` statement.** A reader of a group relation is denied nothing by projection to pairs **unless** it is nonlinear inside the group (multiplicative in co-members' states) or weights a node by which group it is in. Every discovery operator in the wiki — covariance, precision matrix, query–key score, transition count — is linear-in-pairs, which is the mechanism behind `G105`'s blindness rather than a restatement of it. The operators on the right side of the table are exactly [[wiki/entities/dense-associative-memory.md]]'s `F(x) = x^n` (nonlinear in the group) and a role-dependent weight (edge-dependent vertex weight ≈ a role binding, [[wiki/concepts/vector-symbolic-binding.md]]) **(brainstorm)**.

---

## What the nonlinear group term does to dynamics

| System | Pairwise only | With higher-order terms | Source (via the review) |
|---|---|---|---|
| Kuramoto, all-to-all, pure 3-body `sin(θ_j + θ_k − 2θ_i)` | Continuous transition at `K_1*` | Incoherence stable at **every** `K_2`; abrupt desynchronization on decreasing `K_2`; a **continuum** of stable 2-cluster states, each with its own collapse point | Skardal & Arenas 2019a; Tanaka & Aoyagi 2011 |
| Kuramoto on a macaque connectome (248 nodes; 3-cliques → 2-simplices, 4-cliques → 3-simplices) | — | Explosive synchronization with hysteresis for `K_2 + K_3 > 2`; sync stays stable with **repulsive** pairwise coupling `K_1 < 0`. Authors' reading: a mechanism for fast switching between brain states | Skardal & Arenas 2019b |
| Identical oscillators, multi-order Laplacian `l^(q)_ij = q k^(q)_i δ_ij − â^(q)_ij` | — | Higher order → more stable synchrony; more orders present → more stable still; mixed attractive/repulsive orders can go either way | Lucas, Cencetti & Battiston 2020 |
| Oscillators placed *on edges*, projected by Hodge decomposition onto nodes and triangles | — | Continuous when the two projections are uncoupled, **explosive** when adaptively coupled | Millán, Torres & Bianconi 2020 |
| Chaos in `N = 4` identical phase oscillators | Needs ≥ 4 nontrivial harmonics | 2 harmonics suffice | Bick, Ashwin & Rodrigues 2016 |
| SIS contagion, mean field `ρ̇ = −μρ + Σ_d β_d⟨k_d⟩ρ^d(1−ρ)` | Continuous transition | At 2-simplex infectivity `λ_Δ = 2.5`: **discontinuous** transition, bistable region, the unstable branch separating the basins — so the *initial seed size* decides the outcome | Iacopini et al. 2019 |
| Threshold contagion on hypergraphs | — | Critical-mass dynamics, first- and second-order transitions, hysteresis; offered as the reason measured committed-minority thresholds span 10–40% (group-size-dependent local thresholds) | de Arruda, Petri & Moreno 2020 |
| Random replicator ecology (pairwise `α`, 3-body `β`, 4-body `γ`) | Coexistence lost above `α_c ∝ 1/N` (May's bound) | `β_c` independent of `N`; `γ_c` **rises** with `N` — pairwise terms upper-bound diversity, 4-body terms lower-bound it | Bairey, Kelsic & Kishony 2017 |
| Competition for a vacated site | Two-seedling contest: neutral cycles, destroyed by any death-rate difference | Three-seedling tournament: **globally stable** fixed point at the same `x*`; 4th+ order only speeds convergence | Grilli et al. 2017 |
| Public goods game | On the one-mode projection | On the true group structure (bipartite): more cooperation under every update rule tested | Gómez-Gardeñes et al. 2011 |

**The common mechanism.** A `ρ^d` (`d ≥ 2`) term in the mean field creates a saddle-node pair: coexisting attractors, hysteresis, and a separatrix that acts as a threshold without being written as a parameter.

**(brainstorm) Ignition's non-linearity is this term.** [[wiki/concepts/ignition.md]] locates the all-or-none commit in NMDA's voltage dependence — feedback amplifies only what is already depolarised. Written as a rate equation, pre-activity × post-depolarisation-from-other-co-members is a product of two co-members' states on the third's input, i.e. a 3-body term in its eliminated form (next section). Prediction carried over from simplicial contagion: whether a coalition ignites is set by its **initial size** relative to the unstable branch, not by input amplitude alone — testable on any recurrent commit gate by sweeping seed size at fixed total drive.

---

## Where higher-order terms come from

| Route | Statement | Source |
|---|---|---|
| **Phase reduction at second order** | Pairwise-coupled identical nonlinear oscillators reduce to Kuramoto–Sakaguchi at `O(ε)`; at `O(ε²)` 2-, 3- and 4-body phase terms appear, traced to cubic nonlinearities of the original units | Ashwin & Rodrigues 2016 |
| — same, for the mean-field complex Ginzburg–Landau equation | First-order reduction shows only sync/incoherence; second/third order reproduces quasiperiodic partial sync and cluster states | León & Pazó 2019 |
| — same, in hardware | Ring of 8 nanoelectromechanical oscillators with nearest-neighbour physical links; the second-order phase model needs 3-body and next-nearest terms to reproduce weak chimeras, travelling waves and inhomogeneous sync observed in the device | Matheny et al. 2019 |
| **Effective ⊋ structural** | Effective phase couplings are a superset of structural ones; the extra links appear only at `O(ε²)` | Kralemann et al. 2011 |
| **Elimination of hidden variables** | A rank-one-sum `n`-body energy is exactly a two-body network with its hidden units integrated out | [[wiki/entities/two-body-dense-associative-memory.md]] |

Two independent derivations, one conclusion: **a many-body term is the generic signature of either eliminated fast variables or second-order weak coupling.** For estimation this cuts both ways — a higher-order interaction recovered from data is not evidence of a higher-order *mechanism*, and a pairwise substrate is no argument that group terms are absent from its dynamics.

---

## Estimating a higher-order interaction from data

| Estimator | Data | Recovers | Limit |
|---|---|---|---|
| **Maximum-entropy model with triplet terms** — `P(σ) = Z⁻¹exp(Σα_iσ_i + Σβ_ijσ_iσ_j + Σγ_ijkσ_iσ_jσ_k + …)` | Binarised spike patterns | A fitted three-way coupling per triple — the direct analogue of how a precision matrix estimates a pair. Adding it improved mesoscale predictions (avalanches in awake monkey, visual responses in anaesthetised cat; Yu et al. 2011) | Binary states only (continuous signals must be binarised); ignores spatial and temporal structure; data requirement grows with order. Two other primaries the review cites for the same point carry pairwise-sufficiency titles (Schneidman et al. 2006, "Weak pairwise correlations imply strongly correlated network states"; Ganmor et al. 2011, "Sparse low-order interaction network…"), so the neural evidence is read as mixed |
| **Effective phase-coupling reconstruction** (Kralemann, Pikovsky & Rosenblum 2011) | One scalar time series per node → phases → fit `θ̇_i = ω_i + h_i(θ_1…θ_N)` as a Fourier series; strength of each term by its partial norm | Directed pair **and triplet** couplings on van der Pol networks of `N` = 3, 5, 9 | Extra links detected, some true `O(ε²)` effective links, some spurious, and no way yet to tell which; needs non-synchronised trajectories covering the `N`-torus, so data grows exponentially in `N` |
| **Partial triplet analysis** (Kralemann et al. 2014) | Fit `h` on every triple instead of every pair | True links detected as well as by pairwise partial analysis; the **spurious links pairwise partial analysis creates are avoided** (`N` = 3, 4) | Small networks |
| **Triplet synchronization index** `γ_ijk = |⟨e^{i(nθ_i + mθ_j + lθ_k)}⟩|` (Kralemann et al. 2013) | Phases | Triplet locking invisible to every pairwise `n:m` index; measured in coupled mechanical metronomes as triplets locked while **no pair** is (Jia et al. 2015) | Necessary, not sufficient — other phase dependencies also raise it |
| **Dynamical Bayesian inference** (Stankovski et al. 2015) | Noisy oscillators with time-varying couplings and frequencies | Pairs, triplets, quadruplets; validated on a 5-oscillator simulation and multichannel EEG, beating pairwise-only inference | Small networks |

**The review's own verdict:** no inference scheme yet tests hypotheses about higher-order interactions, and complex contagion may be indistinguishable from simplicial contagion on aggregate data without microscopic mechanism — an identifiability limit of the same shape as [[wiki/gaps/g016.md]].

---

## The Hodge Laplacian — cavities by linear algebra

| Object | Formula | Use |
|---|---|---|
| Boundary matrix `B_k` | `(B_k)_{βα} = ±1` if `(k−1)`-simplex `β` is a face of `k`-simplex `α`, sign by orientation; `∂_k ∘ ∂_{k+1} = 0` | Chains ↔ faces |
| Combinatorial (Hodge) Laplacian | `L_k = B_kᵀB_k + B_{k+1}B_{k+1}ᵀ` (down-then-up + up-then-down); `L_0` is the graph Laplacian | Diffusion `ẋ_σ = −Σ(L_k)_{σσ′}x_{σ′}` on edges, triangles, … |
| Kernel = homology | `ker L_k ≅ H_k`, so `dim ker L_k = β_k` | **The number of `k`-dimensional holes of a given complex, by one eigen-decomposition — no filtration** |
| Hodge decomposition | `C_k = im(B_kᵀ) ⊕ ker L_k ⊕ im(B_{k+1})` | Edge flows split into gradient, harmonic (circulation around holes) and curl parts |

Machine uses reported: edge-flow denoising by projecting onto near-conserved flows (Schaub & Segarra 2018, street traffic); **semi-supervised inference of unlabelled edge flows** under a divergence-free prior, with active selection of the most informative edges to label (Jia et al. 2019); an edge random walk on a doubled (both-orientation) state space whose zero-eigenvectors are the harmonic flows (Schaub et al. 2020); diffusion at order `k` with its own spectral dimension, rising with `k` (Torres & Bianconi 2020).

**(brainstorm) Absence as structure, operationalised.** A wall in a navigable space is a hole; a flow that must go round it and cannot cross it is a harmonic edge flow. A world model storing transitions as signed edge flows rather than node values can read "circulate, don't cross" off `ker L_1` — the unreachability-as-a-positive-fact representation `G6`'s world models lack — at eigen-decomposition cost instead of a persistence sweep.

---

## Measured in brains (via Battiston et al. 2020, §IX.2)

| Finding | Source |
|---|---|
| Hippocampal pairwise spike correlations → order complex (clique complex per density) → Betti curves **below** shuffled nulls and matching random *geometric* complexes: the correlation structure alone encodes a low-dimensional space, with no receptive fields or stimulus used | Giusti et al. 2015 |
| Place-cell coactivity complex over exploration: spurious cycles die, persistent ones are the environment's holes; the time to eliminate spurious cycles estimates the minimal learning time; a flickering complex keeps its topology by compensatory activity | Babichev, Morozov & Dabaghian 2018 |
| Reconstructed cortical microcircuit simulation: stimuli elicit many high-dimensional directed cliques and cavities absent from nulls matched on degree and clustering; a neuron's pairwise correlation grows with the number and order of simplices it belongs to | Reimann et al. 2017 |
| Human white matter: large cliques more frequent than a minimally-wired null; cliques sit around cavities that recur across subjects | Sizemore et al. 2018b |
| Toddler semantic networks: voids (knowledge gaps) open and close over development, with closure timing tracking connection pattern more than semantic content | Sizemore et al. 2018a |
| Macroscale resting functional networks: higher-order interactions present but **weak**, pairwise dominant | Huang et al. 2017 |
| …yet higher-order features are test–retest reliable, separate psilocybin from placebo (homological scaffold, Petri et al. 2014) and mark disorders | several |

---

## Why this matters for a reasoning model

- **The target relations are already n-ary, and the discovery machinery is not.** The wiki's relational benchmarks are built from non-dyadic relations: an ARC transformation, a Raven's row, a PGM triple `(relation, object, attribute)` ([[wiki/entities/pgm.md]]). The wiki's *representations* can hold them — vector-symbolic binding composes `n` factors, tensor products are `n`-way by construction ([[wiki/concepts/vector-symbolic-binding.md]]). But every **discovery** mechanism here estimates pairs: attention is a query–key matrix, Hebbian co-fluctuation is a covariance, inverse covariance is a precision matrix, transition counting is over `(s, s')`. A three-way regularity present only in the triple is not merely hard to find — it is not in the hypothesis space. Logged as `G105`; the reducibility criterion above says *why* — all four are linear in pairs.
- **Store groups as an incidence matrix, project per consumer.** The representation table makes the choice concrete: the bipartite/incidence form is the only lossless, operator-agnostic one; a graph under-fills and a clique complex over-fills. **(brainstorm)** A slot memory whose rows are multi-hot membership vectors over entities *is* an incidence matrix, so the storage side costs nothing new — what is missing is an estimator that writes rows.
- **Absence as structure.** A cavity is defined by the edges that are *not* there, arranged so that the boundary does not close. The Hodge Laplacian supplies the operator (above); the pages that most need it — walls and blocked corridors in a world model, the "every edge exists" failure of installed-manifold architectures noted at `G6` — are asking for a representation in which *unreachability* is a positive fact.
- **Filtration is the disciplined answer to the thresholding problem the wiki has already priced.** [[wiki/concepts/latent-graph-discovery.md]] shows that discovery-by-thresholding is ill-posed on sparse graphs at any estimator quality — ≈6% precision at 80% recall on a 3%-dense graph, ≈28% even with the exact generating couplings ([[wiki/concepts/function-to-structure-inference.md]]). The persistent-homology move is to stop choosing: sweep `τ` from "no edges" to "all edges" and keep the features that *survive* a long stretch of the sweep. **(brainstorm)** That converts a binary edge decision with terrible precision into a persistence score, and it is directly runnable on any learned weight matrix or attention map — the reported object being a Betti curve rather than a thresholded graph.
- **Group terms buy commitment and stability.** Bistability, hysteresis, stable coexistence of many alternatives (Bairey, Grilli) and synchrony that survives repulsive pairwise coupling are properties a winner-selection or commit stage wants; pairwise dynamics deliver them only through extra machinery.
- **Multilayer nesting is the formal statement of the two-level hierarchy's *representation*, not its learning.** One node at a coarse layer = a set of nodes at the finer layer, with identity links carrying the non-independence — which is the meta-graph/instance-graph relation of [[wiki/concepts/latent-graph-discovery.md]] written as one object rather than two. It does not supply the *learning* split (that is the sample-budget argument), but it does say the two levels need not live in separate data structures.
- **A prior over groups exists off the shelf. (brainstorm)** The Indian Buffet Process — the multi-membership sibling of the Chinese Restaurant Process, both exchangeable — is a prior over which sets each node joins, i.e. over hypergraph incidence. [[wiki/concepts/contextual-inference.md]] runs a Chinese-Restaurant-Process prior over contexts (one per moment); swapping in the buffet process lets an observation belong to several latent groups at once.

---

## Open problems

- **Predictive payoff: reported, second-hand, without effect sizes.** Bassett & Sporns cited none. Battiston et al. report higher-order features beating pairwise ones in several places — hypergraphlets for protein function prediction (Gaudelet et al. 2018), partial triplet over partial pairwise phase analysis, Bayesian triplet/quadruplet inference on EEG, triplet max-entropy terms for avalanche prediction, hyperdegree over degree for gene essentiality, a hypergraph random walk for microbe–disease association — but the review reports no magnitudes, and its neural citations include two pairwise-sufficiency results. The case is no longer only structural; it is not yet quantified.
- **Cost.** Simplicial complexes store `2^k` faces per `k`-simplex; hypergraphlet orbits number 65 up to order 3, > 6,000 at order 4 and > 10⁵ at order 5; motif-constrained null models are unsampleable above order 2. Phase-coupling estimators need data exponential in `N`. Every working estimator above enumerates its candidate groups.
- **Nothing learns hyperedges at scale.** The estimators above fit a group coefficient for every enumerated candidate on ≤ ~10 nodes (or on binary units); none *searches* for which groups exist. **Partly answered at the measurement level**: the O-information `Ω(Xⁿ) = C(Xⁿ) − B(Xⁿ)` is computed from the joint distribution with no thresholding and no predictor/target split, costs `2n+1` entropy terms, and returns a signed scalar saying whether a group is redundancy- or synergy-dominated (Rosas et al. 2019, [[wiki/concepts/o-information.md]]). It scores a *given* set rather than searching for one — `G105` is `PARTIAL`, not closed.
- **A worked case of the blindness, with a number.** An `n`-bit xor has **zero** pairwise mutual information at every pair while attaining the most negative O-information possible (`Ω = 2−n`): a covariance, precision-matrix or attention-score estimator returns the empty graph on a system whose entire regularity is present. This is the cavity complaint above restated as a distribution rather than a geometry.
- **Coupling-function choice is unexplored.** For three oscillators the symmetric `sin(θ_j + θ_k − 2θ_i)` and the asymmetric `sin(2θ_j − θ_k − θ_i)` (the one phase reduction produces) are both admissible, the number of asymmetric choices grows with order, and the review states their dynamical consequences have not been studied systematically.
- **Genuine vs apparent.** Since group terms arise from eliminated variables and from second-order weak coupling, "is this interaction genuinely higher-order?" has no data-only answer; the review names this as the field's central inference problem.
- **What a cavity means functionally is asserted.** "Cliques → integrated codes, cavities → segregated codes" is Bassett & Sporns's reading of the geometry, not a measured relation to any code.
- **The node set problem is inherited whole.** A simplex is a set of nodes, so every indeterminacy on [[wiki/concepts/node-definition-problem.md]] — granularity, soft membership, state-dependence — propagates upward, and a coarser parcellation swallows higher-order structure faster than it swallows edges.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — the constraint this page places on that framing: its formalisation defines edges as pairs, so a domain whose regularity is genuinely `n`-ary is outside the stated hypothesis space; its thresholding-is-ill-posed result is what makes filtration/persistence the right reporting object; and the reducibility criterion says which readers of a discovered structure need the group terms at all (nonlinear or role-weighted ones).
- **[[wiki/concepts/node-definition-problem.md]]** — the upstream half of the same complaint: that page shows relational content moves between nodes and edges as the units change, this one shows a further slice of it lives in relations of order > 2 that neither unit nor edge can hold — and supplies the annotated-graph formalism for putting nodal attributes and edges in one model.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — what its six converging measures cannot see: degree, betweenness, k-core and participation are all functions of a dyadic adjacency matrix, so a clique or a cavity in the same data is scored only through its pairwise shadow.
- **[[wiki/concepts/network-control-theory.md]]** — the same review's other generalisation, and one this page limits: minimum-energy control is computed on a dyadic `A`, so higher-order structure is outside the controllability calculation by construction.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the representation side of `n`-ary relations, already solved: an associative binder plus superposition holds a whole relation with any number of role–filler pairs in one fixed-width vector — and a role binding is the machine form of the edge-dependent vertex weight that makes a hypergraph walk irreducible to pairs.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the quantitative reason to prefer a persistence sweep to a threshold: precision at any single operating point is ≈6–28% on a sparse graph, so a feature's *survival across thresholds* is a better-conditioned statistic than its presence at one.
- **[[wiki/concepts/o-information.md]]** — the measurement half of this page's structural argument: where simplicial complexes and persistent homology analyse a complex obtained by thresholding an already-estimated pairwise matrix, `Ω = C − B` reads the redundancy/synergy *kind* of a group of `n` variables straight off the joint distribution — so topology says where the non-dyadic structure sits and `Ω` says what it is, and the `n`-bit xor gives this page's cavity argument a distribution with a number attached.
- **[[wiki/concepts/tensor-product-representation.md]]** — where the representational answer to `n`-ary relations comes from, and why arity is not the hard part: recursive role decomposition yields tensors of rank 3 and above whose units stand for `n`-way feature conjunctions, and `left_of(a,b)` reduces to nested one-place roles (`left_of_b(a)`), so multi-argument relations are syntactic sugar over role decomposition — leaving discovery, not storage, as `G105`.
- **[[wiki/entities/dense-associative-memory.md]]** — this page's `n`-bit-xor blindness argument answered on the energy side rather than diagnosed: a degree-`n` term in `E = −Σ_μ F(ξ^μ·σ)` *is* an `n`-body interaction whose coefficients are fit by gradient descent — the "nonlinear inside the group" reader the reducibility criterion demands — and a 3-body energy on `N = 3` units solves XOR where the quadratic (= pairwise = linear perceptron) model provably cannot. The restriction is what keeps `G105` from closing: the `n`-way tensor is a sum of rank-one terms `(ξ^μ·σ)^n`, so an arbitrary hyperedge is still not in the hypothesis space (Krotov & Hopfield 2016).
- **[[wiki/entities/two-body-dense-associative-memory.md]]** — the constructive answer to "an `n`-body term needs an `n`-body synapse", now with an independent second derivation: every rank-one-sum energy is the integrated-out form of a bipartite two-body network, and phase reduction of pairwise-coupled oscillators produces 3- and 4-body terms at second order in coupling — two routes to "a many-body term is what eliminated variables leave behind" (Krotov & Hopfield 2021; Ashwin & Rodrigues 2016).
- **[[wiki/entities/neuron-astrocyte-associative-memory.md]]** — the elimination argument generalised past neurons: a quartic interaction among firing rates is what lateral calcium transport between the astrocytic processes wrapping different synapses looks like after the chemistry is integrated out, so a higher-order term is the generic trace of *any* eliminated fast variable, cellular or not — while the realisable class remains sums of rank-one terms (Kozachkov, Slotine & Krotov 2023).
- **[[wiki/concepts/ignition.md]]** — the same saddle-node mechanism at network scale: a `ρ²` group term in a mean field produces a discontinuous transition, bistability and a seed-size threshold with no threshold parameter, and NMDA's coincidence-gated feedback is a 3-body term in eliminated form **(brainstorm)** — which predicts that coalition size, not only input amplitude, decides the commit.
- **[[wiki/concepts/metastability.md]]** — the Kuramoto-on-a-connectome system that page measures with `σ_R`, extended with simplicial couplings: 3- and 4-body terms turn the continuous transition into an explosive, hysteretic one and add a continuum of multistable cluster states, so the working point that page tunes by one global gain is also moved by the *order* of the couplings.
- **[[wiki/concepts/topological-latent-decoding.md]]** — the same persistent-homology instrument pointed at a different complex: that page fits the topology of the population *state cloud*, this page's hippocampal result (Giusti et al. 2015) builds a clique complex from the pairwise *correlation matrix* and finds low-dimensional geometry in its Betti curves — two routes to a latent space with no covariate named.
- **[[wiki/concepts/network-communication-models.md]]** — what that page's random-walk models become on groups: a hypergraph walk is reducible to a walk on a correctly weighted projection only when vertex weights are edge-independent, and even then its stationary ranking inverts against the naive clique projection over a whole range of hub sizes (Carletti et al. 2020), so a routing statistic computed on a projected graph can rank nodes wrongly.
- **[[wiki/concepts/self-boosting-knowledge-acquisition.md]]** — two definitions of a knowledge gap on one store: that page's gap is an edge crossing the boundary of the held subgraph, Sizemore et al. 2018a's is a topological void in a semantic network, closed over development on a schedule tracking connection pattern more than content — a cavity count and a frontier count are different intrinsic rewards over the same structure.
- **[[wiki/concepts/contextual-inference.md]]** — the membership prior this page would borrow **(brainstorm)**: that page's Chinese-Restaurant-Process prior assigns each moment to one latent context, and its exchangeable multi-membership sibling, the Indian Buffet Process, is a prior over hypergraph incidence — an observation in several latent groups at once.
- **[[wiki/entities/human-supragranular-pyramidal-neuron.md]]** — a single-cell instance of this page's reducibility criterion: a human L2/3 branch that responds only inside an input-strength window is nonlinear in the group, so one cell computes the exclusive-or that any reader linear in pairs misses (Gidon et al. 2020, via Galakhova et al. 2022).
