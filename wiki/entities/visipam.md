# visiPAM (visual Probabilistic Analogical Mapping)

**The PAM mapper ([[wiki/entities/pam.md]]) with its verbal front end replaced by frozen vision encoders. Nodes are object parts with pretrained appearance or shape embeddings. Edges are hand-defined spatial-relation vectors. Mapping is graduated-assignment graph matching under a soft one-to-one prior. Nothing is trained on mapping. It beats a part-matching network trained on 37,330 problems, and tracks human mappings between 3D objects of different superordinate categories at item level (`r = 0.70`).**

> **Provenance.** Webb, T., Fu, S., Bihl, T., Holyoak, K. J. & Lu, H. (2023), *Zero-shot visual reasoning through probabilistic analogical mapping*, Nature Communications 14:5144 (`raw/webb-2023-zero-shot-visual-reasoning-probabilistic-analogical-mapping.md`, PMC HTML clip). Equations are intact. Algorithm 1 (an image) and all figures are lost. Supplementary Tables S1–S4 are cited in the text but not in the clip. Model code is not public (funder restriction); the analysis code and human data are.

The wiki reaches this model from [[wiki/concepts/analogical-mapping.md]]. It is that page's first mapper whose node attributes are computed from pixels. Like PAM, it is a reference for row 3 (alignment) of [[wiki/concepts/abstraction-graph.md]]'s requirements table, not a component.

---

## Architecture

| Stage | 2D images | 3D point clouds |
|---|---|---|
| **Nodes** | Part coordinates supplied by the dataset (10 per image in PPM (Pascal Part Matching); centroids of segmentation masks for the vehicle set) | ~2000 points per object, clustered by KMeans++ into **8** clusters; a node = one cluster |
| **Node attribute** | iBOT (image BERT pre-training with online tokenizer) ViT-L/16, ImageNet-1K, self-supervised masked image modelling. Final-layer 1024-d patch embeddings, bilinearly interpolated at each part coordinate | DGCNN (Dynamic Graph Convolutional Neural Network), supervised part segmentation on ShapeNetPart (16 **man-made** categories, ~17k models). 64-d third-EdgeConv-layer embedding, averaged over the cluster. **Never trained on animals** |
| **Edge attribute** (hand-defined, not learned) | `r_θ` = three cosines between the vectors `c_i − c_j`, `c_i − c_0`, `c_j − c_0` (`c_0` = object centroid); `r_δ = [c_j − c_i, c_i − c_0, c_j − c_0]` divided by the per-axis coordinate range. Edge = `[r_θ, r_δ]` | Same, in 3D, from cluster centres |
| **Mapper** | PAM, `α = 0.9`, 500 iterations | PAM, `α = 0.9`, 200 iterations |
| **Read-out** | Each target node takes its strongest source node; labels are transferred | Source marker → nearest source cluster → mapped target cluster → the point minimising `⅓(|Δd_local| + |Δd_global| + |Δd_feat|)` (distance to cluster centre, to object centre, in feature space) → projected to the 2D view shown to humans |

### Objective as printed

```
log p(G, G′ | M) = (1−α) · Σ_i Σ_{j≠i} Σ_i′ Σ_{j′≠i′} M_ii′ M_jj′ sim(r_ij, r_i′j′) / N(N−1)
                 +   α   · Σ_i Σ_i′ M_ii′ sim(o_i, o_i′) / N

p(M) = exp( (1/β) Σ M_ii′ log M_ii′ )          sim = cosine
```

- Similarity matrices are bistochastically normalised (10 iterations) before mapping, as in PAM.
- `M_0` is uniform (`1/N`) and `β_0 = 0.1`; `β` rises over iterations. In the algorithm, the edge term is normalised per node by `2(N−1)`.
- **This `α` is not PAM's `α`.** In Lu et al. 2022, `α` multiplies an unnormalised node sum and the edge sum carries no weight (`α` = 0.1 / 1 / 2). Here `α` and `1−α` weight two per-element means. Values do not transfer between the two pages.
- **The `β` direction is inconsistent in the published equations.** As printed, the prior's strength is `1/β`, so raising `β` *weakens* the pull toward a deterministic `M`. The text says higher `β` means a stronger isomorphism preference, and the annealing schedule needs that. In Gold & Rangarajan's graduated assignment, `β` is the softmax inverse temperature and the `M log M` term is an entropy barrier that keeps `M` soft at low `β`. *(Wiki reading.)* This is the same inconsistency the PAM page attributed to conversion damage. This clean HTML shows it is in the published form.

**Fully differentiable.** The authors note the whole pipeline could be trained end-to-end on mapping, and decline to do so in order to model zero-shot reasoning.

---

## Key results

### 2D part matching (PPM test split: 5860 cat + 3200 horse problems; plus two new conditions)

| | Within: animals | Within: vehicles | Between: cat → horse |
|---|---|---|---|
| **visiPAM** (`α = 0.9`) | **63.2%** (59.1) | **69.5%** (58.8) | **67.9%** (59.9) |
| Nodes only (`α = 1`) | 55.5% (50.6) | 61.6% (48.1) | 62.3% (52.9) |
| Edges only (`α = 0`) | 47.8% (42.0) | 63.7% (50.9) | 51.5% (39.4) |
| SSMN (Structured Set Matching Network), trained on **37,330** problems from 4 other categories | 46.6% (40.7) | — | — |
| Chance | 10% | 26% | 20% |

Parentheses: chance-normalised (share of the range from chance to 100%). Accuracy is per part, with partial credit.

- **30% relative error reduction over SSMN** with no mapping training. *(Wiki check: 53.4% → 36.8% error.)*
- **Both halves are needed, in every condition.** Removing edges costs 5.6–7.9 points. Removing nodes costs 5.8–16.4.
- **Edge content matters.** Angular and vector-difference features each contribute (S2). Adding a connectivity bit (are two parts attached?) raises accuracy further (S3); that bit is supplied, not computed.
- **Horizontal reflection of the target leaves accuracy unchanged** (S1).
- **Planes are the worst case**, at 42.5% within-category, attributed to pose and viewpoint variation that 2D relations cannot absorb. *(Wiki computation: the vehicle score is the unweighted mean of cars and planes, so cars are ≈ 96.5%.)*
- **Errors cluster on lateralised parts.** Left/right feet and ears swap, and this accounts for "a large percentage" of errors (S2–S4).

### 3D objects vs humans (192 image pairs; 8 chairs, 8 animals; `n = 41` after exclusions from 59)

Design: 2 (target: animal vs man-made) × 2 (same vs different superordinate category), 48 trials per cell. Each trial asks the participant to place two markers on the target at the parts corresponding to two marked parts on the source. Adapted from Gentner 1977 ("if a tree had a knee…").

| Measure | Humans | visiPAM |
|---|---|---|
| Distance from mean human placement, same vs different superordinate | 8.08 vs **32.06** px (`F₁,₄₀ = 625.37`) | Same direction |
| Interaction: the category effect is larger when the target is an animal | `F₁,₄₀ = 19.29` | Reproduced (S6) |
| Overall distance to the human mean | 20 px | 25 px (objects average 213 × 135 px) |
| Item-level correlation of distances | — | **`r = 0.70`**; nodes-only 0.61, edges-only 0.60 (S4) |
| Bimodal placements on cross-category items (dip test, `p < .05`; e.g. chair back → horse head *or* horse back) | Present; both effects survive scoring against the nearest cluster | Scored against the nearest cluster: lower variance, same pattern (S8) |
| Markers left unplaced or returned to the corner (participants were told to do this when nothing corresponded) | 453 within-category, **2442** cross-category | Cannot abstain: every source part is mapped |

*(Wiki computation: each superordinate condition has 96 problems × 2 markers × 41 participants = 7872 markers, so humans abstain on **5.8%** of within-category markers and **31.0%** of cross-category ones.)*

---

## What the results establish

1. **A comparator with no learned parameters beats a learned one on held-out categories.** SSMN learns its embeddings and its relation scorers (spatial and appearance) on the task, enforces one-to-one exactly, and searches over deterministic mappings. visiPAM uses general-purpose embeddings and a cosine between relation vectors. The authors attribute the gap to SSMN's learned components "overfit[ting] to the specific examples observed during training". The categories are disjoint, so this is the Relation-Net-vs-inner-product contrast of [[wiki/concepts/relational-bottleneck.md]] at the scale of a whole pipeline.
2. **Object similarity is a constraint, not a contaminant.** The best `α` mixes both terms, and the human fit falls at both extremes. The authors re-read the human sensitivity to object similarity (Krawczyk, Holyoak & Hummel 2004), usually framed as a failure to abstract, as the use of a constraint that real-world mapping needs. This is the semantic constraint of multiconstraint theory ([[wiki/concepts/analogical-mapping.md]]), now measured on pixels.
3. **One mapper serves three modalities unchanged.** The PAM objective runs on Word2vec/BART (Lu et al. 2022), on iBOT patches and on DGCNN point embeddings. Only the encoders, `α` and the iteration count change. `(brainstorm)` This is the "single relational head over per-modality encoders" design [[wiki/concepts/analogical-mapping.md]] draws from the Hobeika meta-analysis. In a machine it holds by construction, because the head reads only cosines. It does not run the halve-the-head test that page asks for (`T338`).

---

## Limitations

| Limitation | Stated? | Consequence |
|---|---|---|
| **Nodes are given.** 2D part coordinates come from benchmark annotation. 3D nodes come from KMeans++ with `K = 8` fixed in advance | Partly (clustering is described "to reduce the computation cost") | The carving is computed only in 3D, and its granularity is set by hand. The parse is fixed before the task is seen (`G75`, `G27`) |
| **Edges are authored geometry.** Centroid-relative angles and offsets; connectivity helps but is supplied | Stated (wants richer relations, and topology derived from 2D) | Nothing about the relation vocabulary is learned here, unlike BART (`G4`) |
| **Lateralised confusions; planes at 42.5%** | Stated | 2D relations miss 3D pose. `(brainstorm)` The angular half of the edge code (cosines) is unchanged by reflection, and accuracy is unchanged by reflecting the target, so the lateralised errors and the reflection robustness may be one property: a relation code that cannot see handedness separates mirror-image parts only by appearance |
| **Purely bottom-up** | Stated. Proposed fix: add visual-attention parameters to the optimisation so the matching objective re-weights the encoder's features (cf. Copycat's interleaving) | Perception is never revised by the mapping (`G73`) |
| **Every source part maps** | Visible | Humans leave 31% of cross-category markers unplaced against 5.8% within-category; the model has no slack column (same limit as PAM) |
| **One deterministic mapping per pair** | Visible | Bimodal human populations are handled by scoring against the nearest cluster, not reproduced (`T306`) |
| **No non-visual knowledge** | Stated: semantic and functional knowledge "was a significant contributing factor to human mapping judgments" | Candidates named: word embeddings, CLIP-style multimodal embeddings, BART |
| **No schema induction** | Stated (Gick & Holyoak 1983 named as the target) | Pairwise analogies only |
| SSMN is compared on its original condition only | Visible | The vehicle and between-category conditions have no trained baseline |

---

## Comparison to related models

| | **visiPAM** | [[wiki/entities/pam.md]] | SSMN (Choi et al. 2018) | SME on geometric analogies (Lovett & Forbus 2017, [[wiki/entities/sme.md]]) | End-to-end matrix solvers ([[wiki/entities/pgm.md]]) |
|---|---|---|---|---|---|
| Input | Pixels (2D) or point clouds (3D) + part locations | Chosen keywords | Pixels + part locations | Hand-designed sketch-to-symbol encoding | Pixels |
| Node code | Frozen self-supervised or segmentation embeddings | Word2vec | Learned for the task | Symbols | Learned |
| Relation code | Hand-defined geometry, cosine-compared | Learned BART posteriors | Learned scorer networks | Predicates, identity match | Implicit |
| One-to-one | Soft, annealed | Soft, annealed | Hard, search over mappings | Structural consistency | — |
| Mapping training | **None** | None | 37,330 problems | None | 10⁴–10⁶ problems |
| Human comparison | Item-level 3D placements, `r = 0.70` | Seven verbal simulations | — | Most of Raven's Standard Progressive Matrices solved | — |

---

## Connections

- **[[wiki/entities/pam.md]]** — the reasoning module, unchanged: visiPAM swaps PAM's Word2vec/BART graph for vision-derived nodes and hand-defined spatial edges, re-parameterises `α` as a convex mix of per-element means, and builds the visual extension that page's Limitations list as proposed.
- **[[wiki/concepts/analogical-mapping.md]]** — its first mapper with node attributes computed from pixels, and a pixel-level measurement of that page's semantic constraint: object similarity and relational similarity each add 5.6–16.4 points over the other alone, and human item-level fit drops at either extreme.
- **[[wiki/concepts/relational-bottleneck.md]]** — two results for that page: a learned relation scorer (SSMN) loses on held-out categories to an explicit cosine, the Relation-Net negative control seen across a whole pipeline; and pure relational mapping (`α = 0`) is the worst setting on natural images, evidence that the graded bottleneck that page lists as unbuilt is functional and not only a fit to human content effects.
- **[[wiki/entities/dinov2.md]]** — runs the label-free analogy probe that page proposes, on DINOv2's ancestor encoder: assignment over iBOT patch features alone (`α = 1`) maps 55.5% of animal parts across different images, and centroid-relative spatial edges add 7.7 points.
