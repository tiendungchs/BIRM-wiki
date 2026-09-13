# Projection Distortion — What a 2-D Embedding Can and Cannot Be Asked

**Extreme dimensionality reduction — hundreds or thousands of dimensions to 2 — destroys, by theorem and in measurement, every geometric property that the claims read off such a picture presuppose. Local neighbourhoods, between-group relations, distances, densities and trajectory directions are each measurably not preserved; the *sign* of the distortion is not predictable from the data; and an autoencoder fitted to an arbitrary target shape (an elephant, a flower) scores as well as or better than UMAP/t-SNE on the same fidelity metrics. So a structure visible only after projection is a statement about the projection until a control says otherwise, and the fidelity metrics themselves cannot pick the embedding out of the arbitrary ones.**

> **Provenance.** Chari & Pachter 2023, *The specious art of single-cell genomics*, PLOS Comput. Biol. 19(8):e1011288 (`raw/chari-2023-specious-art-single-cell-genomics.md`); code at `pachterlab/CP_2023`. Domain is single-cell transcriptomics, not neuroscience or interpretability — which is what makes it usable here: the pipeline under test (ambient counts → PCA to a few dozen dimensions → t-SNE/UMAP to 2) is the same pipeline the wiki's population-geometry and activation-geometry pages run, arrived at independently, and the distortion measurements are made against an *ambient space the experimenter has* rather than against a hypothesis.

---

## The assumption ledger

Each use of a 2-D embedding assumes preservation of a named property. Stating which one is what makes the distortion measurable.

| Use | Property assumed | Wiki analogue |
|---|---|---|
| Assess mixing / integration / batch correction; reference mapping | local (nearest-neighbour identity) **+** global (group-level trend) | "these two systems learned the same structure"; cross-subject alignment ([[wiki/concepts/population-geometry.md]]) |
| Validate clusters; read off separation, spread, heterogeneity | global, and distance if any quantitative statement is made | cluster-distance geometry, CCGP-adjacent claims read by eye |
| Density contours; comparing populations between conditions | distance | occupancy and "this regime appears only in condition B" |
| Trajectory inference, pseudotime, velocity arrows | local **+** distance (arrow direction and magnitude are computed *in* 2-D) | manifold trajectories, replay points placed on a fitted manifold |

Definitions used throughout: **local** = nearest-neighbour relations; **global** = relations between *groups* of points; **distance** = `L₂` or `L₁` between points. Distance preservation implies the other two.

---

## The measurements

All against the ambient space (log-normalised counts after highly-variable-gene selection) and against the intermediate PCA space, on in-vivo and cultured datasets, `n = 3–5` embeddings each.

| Property | Instrument | Result |
|---|---|---|
| **Local** | Jaccard distance between each cell's 30 nearest neighbours in 2-D and in ambient space (1.0 = no overlap) | Mean **consistently > 0.7**; rises with dataset size. 2-D against *its own* PCA parent space: **> 0.8**, at every PCA dimension tried. Dropping PCA-preprocessing does not help and sometimes worsens it; `PCA-2D` can be worse than nonlinear reduction without PCA. The most *homogeneous* dataset (mESCs) is among the worst despite being small |
| **Global** | Correlation of cell-type neighbour *rankings* (from mean pairwise distance between types) to ambient | **≤ 0.4**, and at least **33% lower** than the PCA space's own value; some correlations warped or **reversed** in sign. Same under `L₁`. Correlation falls at each step of the pipeline |
| **Distance** | Groups of cells equidistant in ambient space — all-pairs "near" or all-pairs "far" — replotted in 2-D (~2.5 M such groups of 3–8 cells found) | Near-groups and far-groups show **the same dispersion pattern** in the embedding: quantitatively distinct relations become indistinguishable |
| **Distance, sized** | Ratio of maximum to minimum pairwise distance within a group, 2-D vs ambient or vs PCA | Inflated **4× to 200×**, for equidistant groups and for nearest-neighbour groups alike; the inflation **grows with the number of points** in the group. Higher-dimensional PCA spaces keep ratios near ambient |
| **Distance, bounded** | Johnson–Lindenstrauss | Preserving pairwise distances to within **20%** for **10,000** points requires **≥ 1,842 dimensions**. Distortion at 2 is not a tuning failure |
| **Label recoverability** | Predict a held-out 30% of labels from the 50 nearest neighbours | Consistently **worse in 2-D** than in the higher-dimensional space — including under *supervised* UMAP, which is given the labels |
| **Cluster separation** | Kolmogorov–Smirnov distance between inter-type and intra-type pairwise-distance distributions | Moves in **both directions across datasets**: reduction shrinks the inter/intra gap for some and inflates it for others. There is no "conservative direction" to argue in |
| **Mixing verdict** | Fraction of each cell's neighbours sharing its batch label, ambient vs 2-D | **Reversed twice, in opposite directions, on one dataset**: log-normalised data is well-mixed in ambient and unmixed in 2-D; variance-stabilised-and-scaled data is bimodally *unmixed* in ambient and unimodally well-mixed in 2-D |
| **Method ranking** | Two integration methods (MNN, Scanorama) on the same pair of datasets | Ambient mixing distributions are **similar**; the UMAPs give **opposite** pictures. So a published "method A integrates better" can be a property of the display |
| **Reference mapping** | Transform high-dimensional **uniformly distributed** points through UMAP coordinates fitted on a real dataset | The uniform points acquire structure **resembling the donor dataset** — false structure manufactured by the mapping |
| **Density** | Contour plots at `n_neighbors` / perplexity 5 vs 50 | Populations that appear present in one condition and absent in the other **appear and disappear** with the hyperparameter; relative density scales between conditions flip |
| **Trajectory** | Velocyto RNA-velocity arrows computed on embeddings at `n_neighbors` 17 vs 50 | Lost continuity, **reversed arrow directions**, and **new developmental pathways** that are not in the other embedding |
| **Known manifold** | Swiss roll (a 2-D manifold embedded in 3-D, ground truth known) | UMAP does not recover the plane at any setting; islands and spurious clusters appear, local neighbours scramble, worse as the roll is tightened |
| **Non-biological control** | MNIST | Digit clusters are muddled at the point level while the same data classifies at high accuracy in higher dimensions — the apparent cleanliness is partly plotting order |

---

## Two structural results that transfer beyond the numbers

**1. The fidelity metrics do not identify the embedding — "Picasso".** An autoencoder can be trained to place cells in an **arbitrary 2-D shape** (a von Neumann elephant; a flower) while preserving ambient cell-to-cell distances to a degree *not much different* from t-SNE or UMAP. Scored on correlation of inter-type distances (between-cluster relations) and intra-type distances (within-cluster spread) against ambient, on three datasets, the elephant **matches t-SNE/UMAP — and beats both on intra-type correlation on every dataset** — including against dens-SNE/densMAP, which exist specifically to preserve density. Cells of the same type sit together inside the trunk.

The consequence is not "UMAP is bad." It is that **the quantities usually offered as evidence that an embedding is faithful are satisfied by an embedding carrying no information in its shape**, so those quantities cannot license a shape-based claim. This is the missing negative control for every geometric read-out in the wiki that is produced by *fitting* (`G115`).

**2. The display is not an independent check on the analysis.** In the standard toolchains (Scanpy, Seurat) the **same** `k`NN graph, built in the PCA space, is passed to the clustering algorithm **and** to the embedding algorithm. The picture that "confirms" the clusters is a second rendering of the object the clusters were computed from, so it will show clusters whether or not that graph reflects any underlying structure. Circular validation at the pipeline level, invisible at the figure level.

**A third, smaller, and immediately actionable one.** The default metric of UMAP/t-SNE is `L₂`. Measured by **relative contrast** — a norm's ability to separate near from far in high dimensions — `L₁` scores higher than `L₂` **across every dataset tested**. The metric that every geometric claim is computed under is a free parameter that was never set on evidence.

---

## What this does to the wiki's own instruments

- **`T159` gains its missing measurement, from outside the domain.** The wiki's version of this question is whether the compositional geometry of activation vectors — additive at cos 0.993 inside a fitted 3-D subspace, 0.395 in the raw residual stream — is a property of the representation or of the projection ([[wiki/concepts/linear-representation-hypothesis.md]], [[wiki/concepts/representation-probing.md]]). Chari & Pachter do not settle the activation-space case, but they establish that the *generic* answer for a fitted 2–3 dimensional summary of a high-dimensional space is the unfavourable one, on data where the ambient space is available for comparison and where the distortion can be sized: local structure > 0.7 Jaccard away, global rankings reversible, `D/d` inflated up to 200×. **The burden of proof therefore sits on the projected claim, not on its critic.**
- **The wiki's geometric instruments split cleanly by exposure.** CCGP, parallelism score and shattering dimensionality ([[wiki/concepts/population-geometry.md]]) are computed by decoders in the *ambient* population space and are not exposed; the ceiling on `SO(d)` alignment is set by the fitted subspace and is partly exposed; anything read off a UMAP figure — the learning-stage shape sequence, off-manifold clouds, ripple points placed on a running-derived manifold — is fully exposed and should be carried with its ambient-space counterpart or not at all.
- **Hyperparameter-conditioned appearance is the specific failure to guard against.** Two of the measured reversals (a population present/absent; a velocity arrow's direction) come from changing *one* neighbour-count parameter with the data fixed. Any wiki claim of the form "a regime appears at stage *k*" or "the trajectory runs from A to B" needs the same sweep before it is a result.

**(brainstorm) The three cheap controls, in ascending cost.** (i) **Report the ambient column.** Whatever statistic carries the claim, compute it in the un-projected space as well — the mixing reversals are visible with no extra machinery. (ii) **Sweep the neighbour parameter** over the published range and show the claim survives; a claim that does not survive the sweep is a hyperparameter. (iii) **Run the Picasso control**: fit an embedding to an arbitrary target shape under the same fidelity objective, and report your statistic for it. If the elephant matches, the statistic is not evidence for your shape.

**(brainstorm) The `JL` number is a design constraint, not only a critique.** `≥ 1,842` dimensions for 20% distance fidelity at 10,000 points prices any architecture that routes through a low-dimensional bottleneck and then expects downstream *distances* to be meaningful — a retrieval index, a latent replay buffer, a bottlenecked world-model state. It says the bottleneck is safe for what survives a many-to-one map (identity, category) and unsafe for what needs a metric (similarity ranking, nearest-neighbour retrieval, interpolation), and it gives the dimension count at which the second becomes safe. Compare the sphere-packing bound on [[wiki/concepts/retrieval-capacity.md]], which prices the same bottleneck by *how many questions* can be asked of it rather than by distance fidelity.

---

## Open problems

- **The activation-space replication does not exist.** Every measurement here is on gene-expression counts. The identical protocol — Jaccard of `k`NN, group-ranking correlation, `D/d` inflation, Picasso — is runnable on a residual stream or a recorded population *today*, at no experimental cost, and no one in the wiki's literature has run it (`G115`, `T159`).
- **No positive statement replaces the negative one.** The paper's alternatives — targeted embeddings with an explicitly optimised metric (MCML/bMCML), dendrograms, graph diagrams, higher-dimensional trajectory inference, analysis in the ambient space — all require the analyst to *name the property to be preserved first*, which is exactly what an exploratory instrument is for not having to do. A label-free, distortion-bounded exploratory instrument is not on offer here or anywhere in the wiki.
- **The norm is unset.** `L₁` beats `L₂` on relative contrast across datasets, but which biological or representational features drive the contrast values is unexplored, so the recommendation is "measure it per dataset" rather than a rule.
- **How much of the sign ambiguity is data-dependent?** Inter/intra separation moves both ways and mixing reverses in both directions. Nothing in the paper predicts which direction a given dataset will get, which means a distortion cannot be argued away as conservative in either direction — but also that no correction is available.

---

## Connections

- **[[wiki/concepts/population-geometry.md]]** — the page most exposed to this one, and the reason the exposure is uneven: CCGP, parallelism and shattering dimensionality are ambient-space decoder statistics that inherit none of these failure modes, while the learning-stage shape sequence and the ripple-on-manifold result are read off UMAP figures whose local structure is measurably > 0.7 Jaccard from the ambient neighbourhood and whose appearance changes with one hyperparameter.
- **[[wiki/concepts/representation-probing.md]]** — supplies the fitted *subspace* as a free parameter alongside label basis and probe class; this page prices that parameter with an out-of-domain measurement, and adds the negative control that page's table has no entry for — an arbitrary-target embedding scoring as well as the real one on the fidelity metrics.
- **[[wiki/concepts/linear-representation-hypothesis.md]]** — where the wiki's own version of the question lives (`T159`): additive composition at cos 0.993 projected against 0.395 raw. This page does not settle that case but establishes the prior against the projected column.
- **[[wiki/concepts/manifold-constrained-learning.md]]** — the one case where a fitted low-dimensional object earns its status by *predicting an unseen manipulation*, which is the standard this page implies: a projection is evidence when it forecasts a perturbation's outcome, not when it looks structured.
- **[[wiki/concepts/structured-flows-on-manifolds.md]]** — the complementary demand: that page asks a manifold for a *generator* (an instability, low-rank connectivity, a broken symmetry), this one shows that without such a generator the fitted surface is not distinguishable from an elephant fitted under the same objective.
- **[[wiki/concepts/timescale-estimator-bias.md]]** — the sibling `L0-INSTR` result and the same repair shape: there the summary statistic (sample autocorrelation) is biased and the fix is a generative model carrying the same bias; here the summary statistics (neighbour and distance correlations) are uninformative and the fix is a control embedding carrying the same fitting procedure. In both, the instrument is rescued by constructing something that shares its defect.
- **[[wiki/concepts/stationary-surrogate-null.md]]** — the same move one level up: a null that reproduces the reported structure out of an assumption-free generator, which is what the Picasso embedding is for shape claims and what stationary simulated data is for dynamic-connectivity claims.
- **[[wiki/concepts/retrieval-capacity.md]]** — the other bound on what a low-dimensional code can be asked: sphere packing limits *how many distinct retrieval sets* are addressable, Johnson–Lindenstrauss limits *how faithfully distances survive*, and a bottleneck design has to clear both.
- **[[wiki/concepts/node-definition-problem.md]]** — the upstream version of the circularity here: connectome "gradients" are an embedding of a profile-similarity matrix, and if the same matrix defines both the parcels and the space they are displayed in, the display cannot validate the parcellation.
- **[[wiki/concepts/manifold-untangling.md]]** — the case where dimensionality reduction is the *object of study* rather than an instrument: there the network's own cascade is claimed to flatten identity manifolds, scored by a fixed linear reader on held-out transformations, so the claim never passes through a fitted visualisation and is not exposed to this page.
- **[[wiki/concepts/objective-identifiability.md]]** — the same underdetermination one level out: there a task-forced low-dimensional latent can be mapped onto a population in many ways and nothing picks the mapping; here many 2-D targets fit the data equally well and nothing picks the target.
- **[[wiki/concepts/label-free-model-selection.md]]** — the same measurement-validity discipline applied to a spectrum rather than to a scatter plot: a statistic computed off a fitted low-dimensional object does not identify that object, which is why an arbitrary-shape control is needed there and why a structure-vs-capacity control is missing for effective rank (`G108`).
