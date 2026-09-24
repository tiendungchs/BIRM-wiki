# HGNN (Hypergraph Neural Network) — A Hypergraph Convolution That Is a Graph Convolution on Reweighted Pairs

**A two-layer spectral convolution whose propagation matrix is built from a vertex × hyperedge incidence matrix `H` instead of an adjacency matrix: `X^{(l+1)} = σ(D_v^{-1/2} H W D_e^{-1} Hᵀ D_v^{-1/2} X^{(l)} Θ^{(l)})`. The paper sells it as a model of "high-order correlation". Read against the reducibility criterion of [[wiki/concepts/higher-order-interactions.md]], it is a negative control for `G105`, pairwise twice over. The hyperedges are *constructed* from a pairwise distance: each is one vertex plus its `K` nearest neighbours. The operator applied to them is an `N × N` matrix linear in the node states: a GCN (Graph Convolutional Network) on a reweighted clique projection.**

> **Provenance.** Feng, You, Zhang, Ji & Gao 2019, *Hypergraph Neural Networks*, AAAI 2019 / arXiv:1809.09401 (`raw/feng-2019-hypergraph-neural-networks.md`, ar5iv clip). Two tasks: citation-node classification (Cora, Pubmed) and 3-D object classification (ModelNet40, NTU (National Taiwan University) 3-D model dataset) on pre-extracted MVCNN (Multi-View Convolutional Neural Network) and GVCNN (Group-View Convolutional Neural Network) features. Everything below is from that source unless marked. The equivalence derivations are this page's, from the paper's own operator.

---

## Architecture

| Component | Spec | Note |
|---|---|---|
| **Hypergraph** | `G = (V, E, W)`; incidence `h(v,e) = 1` iff `v ∈ e`; `d(v) = Σ_e w(e)h(v,e)`, `δ(e) = Σ_v h(v,e)` | The lossless bipartite storage format of [[wiki/concepts/higher-order-interactions.md]]'s representation table |
| **Laplacian** | `Δ = I − D_v^{-1/2} H W D_e^{-1} Hᵀ D_v^{-1/2}` (Zhou, Huang & Schölkopf 2007) | From the smoothness regulariser `Ω(f) = ½ Σ_e Σ_{u,v∈e} (w(e)/δ(e)) (f(u)/√d(u) − f(v)/√d(v))²`, which is a **sum over pairs** inside each hyperedge |
| **Convolution** | Chebyshev expansion truncated at `K = 1`, `λ_max ≈ 2`, one shared `θ` → `Y = D_v^{-1/2} H W D_e^{-1} Hᵀ D_v^{-1/2} X Θ` | Derivation drops `W + I` to `W` by "≈"; `W` initialised to `I` |
| **Reading as a two-stage pass** | `Hᵀ`: node features → hyperedge features (mean via `D_e^{-1}`); `H`: hyperedge features → nodes | "Node–edge–node transform". **No nonlinearity at the hyperedge stage**: `σ` is applied only after both matrix products |
| **Hyperedge construction** | Visual: one hyperedge per object = the object + its `K = 10` nearest neighbours by Euclidean feature distance, so `H ∈ ℝ^{N×N}`. Citation: one hyperedge per node = the node + its graph neighbours | Every hyperedge is a ball in a **pairwise** metric; `H` is fixed before training |
| **Multi-modal fusion** | One `H_i` per feature modality, **concatenated** column-wise: `H = [H_1 ∣ H_2]` | Union of neighbourhoods, each normalised by its own `δ(e)` |
| **Net** | 2 layers, hidden 16, ReLU, dropout 0.5, Adam lr 0.001, softmax + cross-entropy on labelled nodes | Transductive: test nodes are inside `H` |

### What the operator is (derived here)

`P_ij = Σ_e w(e) h(i,e) h(j,e) / (δ(e) √(d(i) d(j)))`. This is a symmetric, non-negative `N × N` matrix with self-loops: the clique projection of `H` with each hyperedge's pairs weighted by `w(e)/δ(e)`. Consequences:

| Claim | Status |
|---|---|
| One HGNN layer = one GCN layer on the weighted clique projection `P` | Exact. The paper states only the `δ(e) = 2` special case: "coincident with the Laplacian of simple graph up to a factor of ½" |
| Two layers = `σ(P σ(P X Θ₁) Θ₂)`: a node-wise nonlinearity between two pairwise diffusions | No term multiplies two co-members' states. This is the "linear diffusion on a hypergraph" row of the reducibility table (Chitra & Raphael 2019, via Battiston et al. 2020) with learned channel mixing |
| What a clique projection loses (group identity, [[wiki/concepts/higher-order-interactions.md]]) is invisible to HGNN | Yes, apart from the `1/δ(e)` weight, which is a *size* signal and not an *identity* one |
| An `n`-bit-xor triple ([[wiki/concepts/o-information.md]]) can become a hyperedge | Only if its members are Euclidean neighbours in feature space. The construction stage is a similarity threshold, so it sees what a distance matrix sees |

---

## Results

### Citation (100-run mean, no dispersion reported)

| Method | Cora | Pubmed |
|---|---|---|
| DeepWalk | 67.2 | 65.3 |
| ICA (Iterative Classification Algorithm) | 75.1 | 73.9 |
| Planetoid | 75.7 | 77.2 |
| Chebyshev | 81.2 | 74.4 |
| GCN | 81.5 | 79.0 |
| **HGNN** | **81.6** | **80.1** |

Hyperedge = node + its 1-hop neighbours. The authors say the hypergraph is "quite similar to the graph", so the gain "is not very significant". Here the input is a graph, so the hypergraph adds no new information.

### Visual objects (accuracy %, GCN / HGNN; rows = node features, columns = features used to build the structure)

| Node feature ↓ / structure → | GVCNN | MVCNN | GVCNN+MVCNN |
|---|---|---|---|
| **ModelNet40** GVCNN | 91.8 / 92.6 | 91.5 / 91.8 | 92.8 / **96.6** |
| ModelNet40 MVCNN | 92.5 / 92.9 | 86.7 / 91.0 | 92.3 / **96.6** |
| ModelNet40 both | — | — | 94.4 / **96.7** |
| **NTU** GVCNN | 78.8 / 82.5 | 78.8 / 79.1 | 75.9 / **84.2** |
| NTU MVCNN | 74.0 / 77.2 | 71.3 / 75.6 | 73.2 / **83.6** |
| NTU both | — | — | 76.1 / **84.2** |

ModelNet40 against point-cloud methods: PointNet 89.2, PointNet++ 90.7, PointCNN 91.8, SO-Net 93.4, HGNN 96.7.

**Where the gap sits.**
- Single-modality structure: HGNN − GCN = 0.3 to 4.3.
- Fused structure: 2.3 to 10.4.
- On NTU, **GCN gets worse when given both modalities** (78.8 → 75.9 with GVCNN features), while HGNN gets better (82.5 → 84.2).

So the large margins sit exactly where the two arms use different fusion rules.

---

## Limitations

| Limitation | Consequence |
|---|---|
| **The comparator's graph is a different object, not HGNN's graph with the hyperedges removed.** GCN gets a dense Gaussian affinity `A_ij = exp(−2D_ij²/Δ̄)` over all pairs; HGNN gets a `K = 10` neighbourhood incidence | Sparsification and "hyperedge order" are confounded in every visual cell. No arm runs GCN on the kNN (`k`-nearest-neighbour) graph, or on `P` itself, which by the derivation above would reproduce HGNN's propagation |
| **Fusion rules differ between arms**: GCN averages the two affinity matrices; HGNN takes the union of hyperedges, each normalised by its own degree | The largest reported gains (8.1–10.4 on NTU) are in the fused columns, where the GCN arm itself degrades. They measure the fusion rule, not arity |
| **No structure-free baseline** on the same features, e.g. an MLP (multilayer perceptron) on GVCNN+MVCNN | The 96.7 vs point-cloud comparison mixes input modality (12-view image features vs raw points), transductive use of test nodes, and structure. It does not isolate structure |
| **Hyperedges are constructed, not learned or estimated** | `H` is a fixed function of a pairwise distance. Nothing in the model decides which groups exist (`G105`'s "searches for which groups exist" clause) |
| **No nonlinearity inside the group** | By the reducibility criterion the model is denied nothing by projection to pairs. "High-order correlation" in the paper means *multi-hop smoothing over neighbourhoods*, not an interaction among `≥ 3` states |
| **Reporting** | No dispersion on any number. One text claim ("gains of … 2.0% … on NTU" for GVCNN features / MVCNN structure) disagrees with its own Table 5 (78.8 → 79.1 = 0.3) |

---

## Comparison

| | **HGNN** | GCN (Kipf & Welling 2017) | [[wiki/entities/dense-associative-memory.md]] | [[wiki/entities/neuromatch.md]] |
|---|---|---|---|---|
| Structure input | Incidence `H` (kNN balls) | Adjacency `A` | None; memories `ξ^μ` learned | Given query and target graphs |
| Group term | `1/δ(e)` weight in a pairwise operator | none | `F(ξ^μ·σ) = (ξ^μ·σ)^n`, an `n`-body term | none (GIN (Graph Isomorphism Network) neighbourhood sum) |
| Nonlinear in co-members' states? | **No** | No | **Yes** | No (sum, then MLP) |
| Structure discovered? | No; kNN construction | No | Memories fit to labels | No |
| Solves a zero-pairwise-signal triple? | No | No | Yes (XOR at `N = 3`, `n ≥ 3`) | — |

---

## Reading in the core framing

- **`G105`, negative control.** It is the most-cited "hypergraph learner" and fails both halves of `Closes when`:
  - the `n`-ary relation is not inferred (kNN construction);
  - the operator is not beyond pairs (clique projection).
  
  It moves no evidence. It fixes the *baseline* any future `G105` candidate must beat: HGNN on the same data. A candidate that does not beat it has not shown arity doing anything.
- **What the architecture does buy (brainstorm).**
  - It is the cheapest running implementation of *store groups as an incidence matrix*, with message passing through a hyperedge layer.
  - The upgrade the reducibility criterion demands is local: put a nonlinearity, or a role-dependent weight (edge-dependent vertex weights), **between** `Hᵀ` and `H`, so the hyperedge stage reads a function of its members that is not a sum. That makes the reader irreducible.
  - Construction remains a separate, unsolved step.
- **Similarity-thresholded construction inherits the transitive-closure bias.** [[wiki/concepts/latent-graph-discovery.md]] shows that an inner-product/distance estimator reports path sums. A kNN ball is that estimator thresholded per node. So HGNN's hyperedges are neighbourhoods of the closure, not groups of the generator.

---

## Connections

- **[[wiki/concepts/higher-order-interactions.md]]**: the worked machine instance of that page's reducibility criterion. HGNN's operator `D_v^{-1/2} H W D_e^{-1} Hᵀ D_v^{-1/2}` is a hypergraph diffusion with edge-independent vertex weights, hence exactly a clique projection weighted by `w(e)/δ(e)`. Its "high-order" label therefore names multi-hop smoothing, not a group term.
- **[[wiki/concepts/latent-graph-discovery.md]]**: the construction half of the same failure. Hyperedges are kNN balls in a Euclidean feature space, i.e. a thresholded similarity matrix. That page shows such a matrix reports the transitive closure rather than the generator, and it is fixed before learning, so nothing is discovered.
- **[[wiki/entities/dense-associative-memory.md]]**: the contrast case on the reader side. A degree-`n` energy term multiplies co-members' states and solves a zero-pairwise-signal XOR. HGNN applies `σ` only after linear aggregation, so it cannot, whatever its incidence matrix contains.
- **[[wiki/concepts/o-information.md]]**: the discriminator HGNN's construction never consults. A synergy-dominated triple (`Ω < 0`, every pairwise mutual information zero) need not be a Euclidean neighbourhood. A kNN-built hypergraph can omit exactly the groups `Ω` would flag.
