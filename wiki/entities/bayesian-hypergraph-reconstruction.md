# Bayesian Hypergraph Reconstruction — Which Cliques Were Groups, Decided by Code Length

**A posterior `P(H|G) ∝ P(G|H)P(H)` over hypergraphs `H` that project exactly onto an observed pairwise network `G`. Parsimony picks the groups: a hypergraph prior penalises every extra and every repeated hyperedge. Maximum a posteriori inference is minimum description length. Metropolis–Hastings sampling over a factor graph of `G`'s cliques gives the rest of the posterior. It is the wiki's first estimator that *searches* for which groups exist instead of scoring an enumerated list. Its hypothesis space is the cliques of an already-pairwise graph. So it recovers the group *identity* that projection to pairs erases. It cannot recover a group that projection makes invisible.**

> **Provenance.** Young, Petri & Peixoto 2021, *Hypergraph reconstruction from network data*, Communications Physics 4:135 / arXiv:2008.04948 (`raw/young-2021-hypergraph-reconstruction-from-network-data.md`, ar5iv clip). Implementation in graph-tool. Everything below is from that source unless marked. The per-dataset Jaccard scores (Supplementary Table 1) and per-network description lengths (Supplementary Table 2) are not in the clip, so no figure-only number is quoted here.

---

## Architecture

| Component | Spec | Note |
|---|---|---|
| **Data** | Undirected simple graph `G` (`N` nodes, `E` edges) | Pairwise only. No time series, no node states |
| **Latent** | Multi-hypergraph `H`: `A_{i₁…i_k} ≥ 0` hyperedges on each node set, sizes `2…L` | Repeats allowed a priori |
| **Projection** `P(G|H)` | `1` iff `G = 𝒢(H)`: every edge of `G` lies in ≥ 1 hyperedge, and no hyperedge contains a non-edge. Else `0` | **Noise-free.** The authors reject noisy projections because they "blur the lines between community detection and higher-order interaction reconstruction" |
| **Factor graph** | Nodes = edges of `G`; factors = **every** clique of `G`, included sub-cliques too; a factor connects to each edge it contains | `G = 𝒢(H)` ⇔ every edge-node touches ≥ 1 active factor. Condition (ii) holds by construction: no factor spans a non-edge. Stored as maximal cliques, expanded lazily |
| **Prior** `P(H)` | Poisson Random Hypergraph Model, PRHM (Darling & Norris 2005): `A_{i₁…i_k} ~ Poisson(λ_k)`, independent | Rate depends only on size `k` |
| **Hyperprior** | `λ_k ~ Exp(mean ν_k)` (maximum entropy on `[0,∞)` with finite mean), integrated out | Softens the density commitment |
| **Empirical Bayes** | `ν_k C(N,k) = μ` for all `k` (equal density per size), `Σ_k ν_k C(N,k) = E` ⇒ `μ = E/(L−1)` | One number from the data: the edge count |
| **Final prior** | `P(H) = Π_{k=2}^{L} E_k! / (Z_k μ C(N,k)^{E_k}) · [1/μ + 1]^{−(E_k+1)}`, with `Z_k = Π_m (m!)^{η_m^{(k)}}` | `E_k` = hyperedges of size `k`; `η_m^{(k)}` = size-`k` hyperedges repeated exactly `m` times |
| **Sampler** | Pick a maximal factor uniformly → a size `ℓ ∈ {2…k}` uniformly → a sub-factor of that size uniformly → `A ± 1` (forced `+1` at 0). Metropolis–Hastings acceptance; proposal ratio `1`, `½` or `2` | The authors call this move set "among the simplest one can propose" |
| **Initialisation** | One hyperedge per maximal clique of `G` | Reported to beat random, all-edges and empty starts. The posterior is "rugged" |

### Two properties of the posterior (proved in the paper)

| Property | Statement | Consequence |
|---|---|---|
| **No duplicates** | Adding an average `β` repeats on top of a fraction `α` of `k`-cliques: `log P(H) ∼ −α(1+β)C(N,k) log[(1 + 1/μ)/α]`, decreasing in `β` | Repeated interactions are unidentifiable from a projection and are scored down |
| **Minimal covers are local maxima** | For a cover `H_m` in which every edge of `G` lies in exactly one hyperedge, adding any size-`k` hyperedge multiplies the posterior by `(Z_k/Z′_k)·(E_k+1)/C(N,k)·[1/μ+1]^{−1} < 1` | The posterior's peaks are **non-overlapping clique covers**. Several can exist, so the method averages over them rather than picking one |

**MAP = MDL.** Description length `Σ = −log P(H)` for any `H` that projects to `G`. The maximum a posteriori `H*` is the cheapest hypergraph from which a receiver who knows the model can regenerate `G`.

---

## Key results

### Planted groups, synthetic (Fig. 3; 10 realisations)

| Condition | Result |
|---|---|
| 10 disjoint hyperedges of unequal size, few random edges added | `H*` recovers the planted groups "perfectly" over the whole parameter range tried |
| Erdős–Rényi graph with the same edge count (the null) | No higher-order interactions beyond the random triangles expected at that density |
| Planted + 200 random edges | Planted groups still recovered; **spurious** extra groups appear from random triangles |
| Description length vs added random edges | Planted networks compress far better than their rewired nulls; the saving disappears as rewiring destroys the large cliques |

### Planted groups, empirical bipartite data (Fig. 4)

- **Setup.** 11 bipartite datasets (corporate boards, pollination, host–virus, location check-ins, crime and others). Each is read as a hypergraph, projected by the model's own rule, then reconstructed.
- **Metric.** Jaccard `J` over distinct hyperedges. Duplicates are ignored because a projection cannot show them.
- **Result.** "Good but imperfect", and above maximal-clique decomposition **on every dataset**, "often by a sizable margin". In many datasets the clique baseline recovers "nearly none" of the groups.

### Football network (Division I-A, Fall 2000; Figs. 5–6)

| Quantity | Value |
|---|---|
| Hyperedges of size > 2 in `H*` | 30 |
| Description length, `H*` vs maximal-clique hypergraph | **2411.3 vs 4246.5 bits (−43.2%)** |
| Mechanism | Interlocked maximal cliques share edges. The clique hypergraph pays for those shared edges twice; `H*` keeps one clique as a group and **breaks the other into smaller interactions** |
| Recovered groups vs obvious labels | Do not map cleanly to conferences or geography. One conference is best described as "two interlocking large hyperedges with a few interactions" |
| Uncertain at `α = 0.05` (presence probability in `[α, 1−α]`) | 16 triangles, 70 edges, 9 larger groups. They cluster together in space: competing covers of one region by hyperedges of different sizes |
| Sampling | 4,000 posterior samples, each 1,000 full sweeps apart |

### 15 empirical networks (Fig. 7)

| Predictor | Kendall `τ` with compression `Σ′ − Σ` | `τ` with mean group size |
|---|---|---|
| Average degree | **0.52** | 0.12 |
| Average local clustering `⟨C⟩` | **0.03** | 0.09 |

- Compression ranges from several orders of magnitude (political blogs) to none (Southern Women).
- `⟨C⟩ = 0` means no triangles, so no compression is possible. The bipartite Southern Women network is this case, with mean group size exactly 2.
- The largest mean group size is ~5 (airport network).
- The authors' reading: clustering is necessary but "fails to capture the correct type of redundancy". Interlocking cliques, which track density, are what compress.

---

## Limitations

| Limitation | Consequence |
|---|---|
| **The hypothesis space is the cliques of `G`** | A group is a candidate only if **all** its pairs are observed edges. An `n`-bit-xor triple ([[wiki/concepts/o-information.md]]) has zero pairwise dependence, so it has no edges in any dependence graph and can never be proposed. The method restores what projection *erased* (which clique was a group), never what projection *hid* (a group with no pairwise shadow) |
| **Group identity comes from the prior, not the data** | Every clique cover of `G` has likelihood exactly 1, so the data rule nothing out among them. What makes the problem well posed is the parsimony prior, which the authors say directly: the inverse problem is ill-posed until constraints are added. "Recovered" means "cheapest under PRHM" |
| **Parsimony fragments overlapping groups** | Two genuine groups sharing edges are charged twice, so `H*` keeps one and splits the other. Real overlapping groups (one author on two papers, one team in two rivalries) are systematically under-reported. This is shown in the football case and not measured against ground truth |
| **Noise-free projection** | Spurious edges create spurious triangles, and the method reads them as groups (Fig. 3c). Any front end that thresholds an estimated pairwise matrix inherits [[wiki/concepts/latent-graph-discovery.md]]'s precision problem, now also at the group level |
| **Compression vs maximal cliques is not a test** | The chain starts at the maximal-clique hypergraph, so `Σ′ ≥ Σ` by construction. The 43.2% figure measures how far the search moved, not whether it moved toward the truth |
| **One weak baseline** | Jaccard is compared only against maximal-clique decomposition. There is no greedy minimum clique cover, no Williamson & Tec (2018) random clique cover, and no reported ceiling. The planted test uses the model's own projection rule, so the observation model is matched by design |
| **Prior is simple** | No degree heterogeneity and no community structure. Equal expected density per size `k` is imposed, not fitted |
| **Sampler** | Rugged posterior; results depend on initialisation; no mixing diagnostics reported |
| **No reasoning task** | Social, ecological, infrastructure and neural-wiring networks only. The *C. elegans* connectome is among the 15, but no per-network result for it is in the clip |

---

## Comparison

| | **This method** | Maximal-clique decomposition | [[wiki/entities/hgnn.md]] | Triplet estimators (Kralemann; max-ent `γ_ijk`) | [[wiki/concepts/o-information.md]] |
|---|---|---|---|---|---|
| Input | Pairwise graph `G` | Pairwise graph `G` | Features + kNN construction | Time series / spike patterns | Joint distribution |
| Searches for which groups exist? | **Yes** (MCMC over covers) | No (deterministic) | No (fixed kNN balls) | No (enumerates all triples) | No (scores a given set) |
| Candidates | Cliques of `G` | Maximal cliques of `G` | One ball per node | All triples of ≤ ~10 units | Any given set |
| Can find a zero-pairwise-signal group? | **No** | No | No | Yes (triplet terms, triplet locking) | Yes (`Ω < 0`) |
| Uncertainty | Full posterior, per-group presence probability | None | None | Fit statistics | None |
| Scale shown | Real networks up to the political-blog network | Same | Thousands of nodes | `N ≤ 9` | `n = 4` case study |

---

## Reading in the core framing

- **`G105`: the first "searches" entry, on the wrong input.** The row's Status said no estimator searches for which groups exist. This one does. It samples over covers of real networks, with calibrated presence probabilities and a built-in random-graph null. But its candidates are cliques of a pairwise graph, which is the route `Closes when` excludes ("not by composing or thresholding pairwise scores"). It supplies the *search half*. The *detection half* (a group with no pairwise shadow) belongs to the triplet estimators and `Ω`, which enumerate. **(brainstorm)** The missing learner is the product of the two: this sampler's add/remove moves over a factor graph, with candidate factors proposed by a synergy score (`Ω < 0`, or a triplet coupling), not by clique membership.
- **It is the missing writer for an incidence-matrix store.** [[wiki/concepts/higher-order-interactions.md]] proposes a slot memory whose rows are multi-hot membership vectors and notes that "what is missing is an estimator that writes rows". **(brainstorm)** Given a co-occurrence graph from any pairwise front end (transition counts, attention, covariance), this posterior writes the rows. Its per-group presence probability is the confidence a consumer should read. Its preference for non-overlapping covers is a known bias to correct, for example with a prior that allows shared members.
- **A measured case for `T155`, with both signs.** A within-instance description-length objective selects planted structure better than the naive decomposition on every dataset tested (Position A). By the same mechanism, it fragments one of any two groups that share edges, because an edge covered twice costs twice (Position B's "brevity distorts the vocabulary", here as splitting, not fusing). See [[wiki/tensions/t155.md]].
- **The representation table's two errors, traded off by code length.** Edge-only reconstruction *under-fills*. Clique filling *over-fills* (it invents `[a,c,d]` in [[wiki/concepts/higher-order-interactions.md]]'s worked example). The maximal-clique baseline over-fills, and the MDL cover sits between the two. What sets the operating point is the prior, not the data.
- **Average degree predicts compressibility and clustering does not** (`τ` 0.52 vs 0.03). **(brainstorm)** For a learned graph, a cheap test of whether a group representation will pay off is the density of *interlocking* cliques, not the clustering coefficient.

---

## Connections

- **[[wiki/concepts/higher-order-interactions.md]]**: the estimator that page's representation table implies but did not have. The table says a graph under-fills groups and a clique complex over-fills them. This method picks among clique covers of the graph by code length, so it recovers the group identity projection erased. It is the first entry in that page's estimator table that searches over which groups exist, not over an enumerated list.
- **[[wiki/concepts/latent-graph-discovery.md]]**: an inference over a second latent level stacked on that page's first. The pairwise graph `G` is treated as observed, and the hypergraph is inferred from it. So every error in estimating `G` (transitive closure, the ≈6–28% precision of thresholding) becomes spurious triangles and then spurious groups, which the planted-plus-noise experiment shows.
- **[[wiki/entities/hgnn.md]]**: the other half of the construction problem. HGNN *builds* hyperedges as fixed kNN balls and reads them with a pairwise operator. This method *infers* hyperedges by searching a posterior but never reads them with a model. Together they cover construction and reading, and neither is irreducible to pairs.
- **[[wiki/concepts/o-information.md]]**: the blind spot this method cannot leave. It proposes only cliques of the observed graph, and an `n`-bit-xor group has every pairwise dependence at zero, so it never enters the factor graph. `Ω` detects exactly those groups but does not search, so the two are complementary halves of `G105`.
