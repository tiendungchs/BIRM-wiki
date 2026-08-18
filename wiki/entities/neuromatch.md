# NeuroMatch

**A neural approximate solver for subgraph isomorphism: decompose target and query into anchored `k`-hop neighbourhoods, embed each with a GNN into an *order embedding* space where subgraph containment is a componentwise inequality, then answer queries by comparing coordinates instead of searching (Ying et al. 2020).**

> **Provenance.** Ying, Wang, You, Wen, Canedo & Leskovec 2020 (Stanford / Siemens), *Neural Subgraph Matching* (`raw/ying-2020-neural-subgraph-matching.md`). The transferable ideas live on [[wiki/concepts/subgraph-matching.md]].

---

## Architecture

| Component | Choice | Note |
|---|---|---|
| **Decomposition** | For every node `u ∈ G_T`, the `k`-hop neighbourhood `G_u` with `u` marked as **anchor** | A `k`-layer GNN embedding of `u` *is* an embedding of `G_u` |
| **Encoder** | GIN variant (Xu et al. 2018) with skip layers; **sum** aggregation; LeakyReLU; degree / clustering-coefficient / average-path-length features added for convergence | Backbone is swappable — the framework is GNN-agnostic |
| **Anchor marking** | One-hot feature distinguishing the anchor from the rest of the neighbourhood | Raises expressivity above the Weisfeiler-Lehman limit for `d`-regular graphs (the ID-GNN device) |
| **Embedding space** | Order embedding (McFee & Lanckriet 2009): `z_q[i] ≤ z_u[i] ∀i ⟺ G_q ⊆ G_u` | Alternatives ablated: box embeddings, MLP + cross-entropy, neural tensor network — all worse |
| **Energy / decision** | `E(z_q,z_u) = ‖max{0, z_q − z_u}‖²₂`; predict subgraph iff `E < t` | No neural module at query time; a coordinate test |
| **Loss** | Max-margin: `Σ_P E + Σ_N max{0, α − E}` | 3:1 negative:positive ratio; 10% hard negatives made by perturbing the query |
| **Query-stage inference** | Alignment matrix `A_{ij} = f(z_i, z_j)` over all `(q,u)` pairs; **mean** of entries for the binary decision | Mean beat the Hungarian algorithm; the matrix can still be fed to an assignment solver when an explicit mapping is wanted |
| **Voting refinement** | Reject a candidate pair if any `i ∈ N^(k)(q)` has no match in `N^(k)(u)` | Local-consistency propagation in embedding space |
| **Depth** | `k ≥` query diameter; `k = 10` reaches peak by small-world-ness | Pattern size bounded by depth |
| **Training curriculum** | Start at radius-1 single-target queries; on 20 plateaued epochs, increment radius up to 4, then double the number of target graphs up to 256 | Adam, lr `1e-3`, cosine annealing with restarts every 100 epochs; dataset regenerated every 50 epochs |
| **Query sampling** | Random BFS traversal on `G_T`, then the same traversal within `G_u` anchored at `u` (guarantees a positive) | Test-time alternatives: degree-weighted (MFinder), random walk with restart |
| **Complexity** | Embedding `O(K(\|E_T\|+\|E_Q\|))`, precomputable offline; query `O(\|V_T\|\|V_Q\|)` | Exact methods are exponential in query size |

---

## Key results

| Measurement | Value |
|---|---|
| Neighbourhood matching (Problem 2), AUROC×100 | SYNTHETIC 93.5 · COX2 97.2 · DD 97.9 · MSRC_21 96.1 · FIRSTMMDB 95.5 · PPI 89.9 · WORDNET18 89.3 (median 95.5) |
| vs. adapted neural graph matchers | GMNN 72.0–82.5, RDGCN 76.8–82.4 → ~20% average relative gain, at lower cost (no cross-graph attention) |
| Query-to-target decision (Problem 1), AUROC×100 | COX2 89.9 · DD 95.7 · MSRC_21 84.5 · FIRSTMMDB 91.9 · ENZYMES 92.9 · SYNTHETIC 75.2; +18.4% average over FastPFP / IsoRankN |
| Ablations (Problem 2, average effect) | no curriculum −6% and higher variance; MLP + cross-entropy, neural tensor network, box embeddings all below the order-embedding model |
| Runtime (query size ≤ 50, seconds) | NeuroMatch-order 0.03–0.04 · learned-comparator variant 0.44–0.49 · RI 7.5–12.8 · VF2 19.7–25.9 → ~100× the paper's headline claim; exact methods fall below 60% success at query size > 30 |
| Zero-shot transfer (train on synthetic ER / Barabási only) | ENZYMES 92.9→78.9 · COX2 97.2→93.9 · AIDS 94.3→92.2 · PPI 89.9→81.0 · IMDB-BINARY 81.8→74.2; beats some baselines trained *on* the target dataset |
| Sampling-distribution shift (MSRC, train BFS) | 98.79 / 98.58 / 98.38 on BFS / MFinder / random-walk test queries; BFS is the most robust training sampler |
| Query size relative to target | 28–59% of target nodes — the task is genuinely subgraph matching, not disguised graph isomorphism |
| Backbone sweep (ENZYMES accuracy) | GCN 6-layer 69.9 → GIN 8-layer 88.4 → SAGE 12-layer 90.5 → SAGE 8-layer + skip **91.5**; dropout ≈ no effect, sum aggregation best |

---

## Limitations

- **No certificate.** Approximate throughout; correctness can only be checked by the exponential methods it replaces.
- **Precision collapses under natural skew.** DD, queries of size ≤ 7, averaged confusion matrix: TP 68.2 / FN 8.3 / FP 70.5 / TN 1030.9 — recall 89%, **precision 49%**, at 97.9 AUROC. Against a whole memory, one in two returned matches is spurious ([[wiki/empirical-tensions.md]] T22).
- **Feature transfer unsolved.** The synthetic pretraining corpus has no node features and real datasets differ in feature dimension, so transfer only covers structure-only matching — stated as open by the source.
- **Expressivity is borrowed.** Anchoring lifts the model past WL for `d`-regular cases, but the backbone is still message-passing; stronger GNNs are named as future work.
- **Shape assumptions.** Queries must be connected (else split); evaluation caps diameter at 8; `k` must cover the query diameter.
- **The decision problem, not the mapping.** The headline metrics are binary AUROC; producing an explicit node correspondence needs a downstream assignment step (Hungarian, or Fey et al. 2020's consensus).

---

## Comparison

| System | What it computes | Cost | Guarantee | Relation to this wiki |
|---|---|---|---|---|
| **NeuroMatch** | Subgraph containment via order-embedding geometry | `O(\|V_T\|\|V_Q\|)` after offline encoding; 0.03 s | None | Structural retrieval as a coordinate test |
| **VF2 / RI** (exact) | All isomorphic embeddings | Exponential; 7.5–25.9 s, <60% success beyond size 30 | Exact | The ground truth the neural route has no access to |
| **FastPFP / IsoRankN** | Approximate alignment (convex relaxation / spectral) | 0.56–1.45 s | None | 50–83 AUROC; beaten by 18.4% |
| **GMNN / RDGCN** (adapted graph matchers) | Cross-graph attention similarity | Higher — attention over all node pairs, per query | None | Vector embeddings with no geometric structure; ~20% worse |
| **NM-MLP / NM-NTN** (ablations) | Learned pairwise comparator | 10× slower at query time | None | Isolates the geometry as the source of both accuracy and speed |
| **NM-BOX** (ablation) | Box embeddings | Comparable | None | Fails specifically on the intersection property — cannot guarantee a common subgraph |
| **[[wiki/entities/bayesian-program-learning.md]]** | Program explaining an exemplar | Search over programs | Posterior | The other route to "which stored structure explains this?" — generative and slow, where this is discriminative and fast |

---

## Connections

- **[[wiki/concepts/subgraph-matching.md]]** — the concept page this architecture instantiates: order embeddings, anchored decomposition, voting, and the limits that follow.
- **[[wiki/concepts/latent-graph-discovery.md]]** — takes the graph as *given* on both sides and solves the retrieval operation the framing assumes; it is evidence about the *use* half only, and about matching rather than path search.
- **[[wiki/concepts/amortized-inference.md]]** — the clearest worked case of structural amortisation in the wiki: an NP-complete query answered by precomputed embeddings plus a coordinate comparison, with the cost moved offline.
- **[[wiki/concepts/energy-based-models.md]]** — a contrastive energy model whose asymmetric hinge `‖max{0, z_q − z_u}‖²` makes representational collapse self-defeating rather than needing a separate anti-collapse term.
- **[[wiki/concepts/compositionality.md]]** — supplies the curriculum's justification: the order constraint composes across message-passing layers, so query complexity must grow monotonically during training (+6%).
- **[[wiki/concepts/abstract-structural-codes.md]]** — the anchor one-hot is a minimal structural code, and is what lifts the encoder above the Weisfeiler-Lehman ceiling.
- **[[wiki/entities/bayesian-program-learning.md]]** — the generative counterpart for the same question ("which stored structure accounts for this instance?"), paying search cost for a posterior where NeuroMatch pays an un-flagged error rate for speed.
