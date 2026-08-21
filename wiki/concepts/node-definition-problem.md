# The Node-Definition Problem — Fixing the Vertex Set Before the Graph Exists

**Before a single edge can be estimated, something must decide what the nodes are, and that decision silently absorbs part of the graph: relational content is conserved between *inside a unit* and *between units*, so enlarging the units deletes edges by swallowing them and shrinking the units multiplies edges without adding information. Macroscale functional connectomics has spent a decade discovering that this choice does not converge — refining granularity does not fix it, hard non-overlapping units cannot express the data's multiplicity, and the between-subject differences the resulting matrices report are contaminated by differences in *where each unit sits in that individual* rather than in how strongly it couples.**

> **Provenance.** Bijsterbosch, Valk, Wang & Glasser 2021, *Recent developments in representations of the connectome*, NeuroImage 243:118533, doi:10.1016/j.neuroimage.2021.118533 (`raw/bijsterbosch-2021-connectome-representations.md`). A review of eight years of methodological work on how resting-state fMRI is turned into a graph at all. Every other whole-brain page in the wiki ([[wiki/concepts/mean-field-reduction.md]], [[wiki/concepts/dynamic-repertoire.md]], [[wiki/concepts/metastability.md]], [[wiki/entities/fcann.md]]) starts *after* this step, from a connectome with `N` = 38/66/90/122 regions already given. This page is what was decided to produce that `N`, and what the decision cost.

---

## The conservation statement

The review's own analogy: to map all social interactions in a country you may treat each person as a unit, or group people into households, neighbourhoods, institutions. **As the units grow, the connectome gets sparser — not because interactions vanished, but because within-unit interactions stopped counting as edges.** There is a genuine ambiguity about "representing connectivity information as part of the unit definition or as between-unit connections", and a genuine ambiguity in the membership criteria themselves (the student who is in the dorm on weekdays and the family home on weekends — a unit with graded, overlapping membership).

| Granularity | Units in fMRI | Status |
|---|---|---|
| Finest measurable | voxel / cortical-surface vertex — already thousands of neurons | "Dense" connectomes at this scale carry behaviourally relevant information that is **lost** at parcel scale (Feilong et al. 2020) |
| Usual working scale | 6–1000 parcels, hierarchical splits possible | Chosen for computational, statistical and interpretational efficiency, not because the brain supplies it |
| Justification offered | each cortical area contributes a distinct computation to the network underlying a behaviour, has its own internal architecture and its own distant-connectivity fingerprint | Fails where areas are internally inhomogeneous — which the same authors state they usually are |

**Two second-order consequences a builder inherits.** Parcel *size* is itself a covariate: unequal parcel sizes change discoverability and apparent polygenicity across parcels, so a study wanting comparable statistics per node needs roughly equal-sized nodes for reasons that have nothing to do with anatomy. And whatever the units, the edge estimator is a second free choice — mean time series (binary parcels) or dual regression / back-projection (weighted parcels), then full correlation, partial correlation (regularised or not), or covariance.

---

## The axes of the choice

| Axis | Options | What it decides |
|---|---|---|
| **Hard vs soft** | binary membership (voxel in / out, usually no overlap) vs weighted membership (fuzzy borders, a voxel with high weight in several parcels) | Whether a unit can belong to more than one module at once |
| **Areal/regional vs network** | contiguous blobs (bilateral homologues are separate units) vs whole-brain multi-blob patterns that need not be interconnected | Whether a node is a place or a pattern |
| **Dimensionality** | 6–10 up to ~1000; hierarchical splits available | The conservation trade above |
| **Sample** | public atlases from young healthy adults vs one derived on the study sample | Whether the units transfer to a different age or a patient group |
| **Modality** | gyral/sulcal landmarks vs resting fMRI vs multimodal consensus (myelin, thickness, task, rest) | Which borders you get — they differ by modality, and in some regions do not exist in every modality |

A representative choice: HCP-MMP1.0 (Human Connectome Project MultiModal Parcellation) is derived from task, rest, myelin and cortical-thickness data jointly, which is why it can be used to argue about *atypical* topology at all — a single-modality border has nothing to disagree with.

---

## Multiplicity: why a finer parcellation does not rescue the hard partition

Averaging within a parcel assumes the parcel has **one** dominant connectivity profile. Function and microstructure are usually variable within a region, inconsistent across modalities, overlapping, and organised along **more than one axis of variance** (Haak & Beckmann 2020). The review's flat statement: this *cannot* be overcome with finer-grained parcellations (Bijsterbosch et al. 2020) — a finer hard partition is still one-profile-per-unit, just with more units. Note also the irony that "homogeneity" is what some parcellation algorithms optimise, while spatially overlapping weighted components achieve *higher* homogeneity than the hard parcellations optimising for it.

Two escapes, both of which change what a node is:

| Representation | Object | What it adds |
|---|---|---|
| **Overlapping modes** — PROFUMO (Probabilistic Functional Modes), a hierarchical Bayesian decomposition with spatial *and* temporal priors, no spatial-independence constraint | Weighted, overlapping networks estimated jointly at group and individual level | A **spatial overlap correlation matrix alongside the temporal correlation matrix** — a second, orthogonal channel of edges. Individual differences in *spatial overlap* have been more strongly behaviour-related than individual differences in temporal correlation (Bijsterbosch et al. 2019) |
| **Gradients** — eigendecomposition of the vertex-to-vertex (or parcel-to-parcel) connectivity-profile similarity matrix | Several continuous coordinates per vertex; similar values = similar connectivity profile = "integrated", maximally different values = "segregated" | A **low-dimensional coordinate system** replacing a node list. Principal axis runs unimodal/primary → transmodal association, aligning with cortical expansion in primate evolution; a tertiary axis juxtaposes the default mode network against the multiple-demand network. Reliably derivable from connectome data, and tracks genetic, transcriptomic and evolutionary gradients |

Plus time-resolved representations that make the node set a function of `t` — hidden Markov models over states, and quasi-periodic waves.

**The historical resolution the authors endorse is "both".** The segregation-vs-holism argument is a century old (Brodmann and the Vogts against Bailey, von Bonin, Lashley), and the modern gradient-vs-parcel debate is not its rerun: visual areas have well-defined borders **and** gradual gradients in functional connectivity riding on top of them along the dorsal and ventral streams. Van Essen & Glasser's bridge: *any specific behaviour has a distinctive functional network, similar behaviours have largely overlapping ones, and each cortical area is responsible for a portion of the computations needed to produce that behaviour when working in concert with its partners*. Areas and networks are different projections, not rival ontologies.

---

## The load-bearing confound: topography is read out as connectivity

**Between-subject differences in a parcellated connectome are mixed with between-subject differences in the spatial topography of the networks** (Bijsterbosch et al. 2018; Li et al. 2019). If subject A's parcel boundary is 4 mm from where subject B's is, the mean time series of the "same" node is drawn from partly different tissue, and the resulting edge-weight difference is reported as a difference in *coupling*. The effect is substantial at network level.

| Where the variance actually lives | Consequence |
|---|---|
| Size, shape and position of areas and networks — representable as parcel surface areas/volumes, or as grayordinate-wise isotropic/anisotropic distortion and registration-displacement maps | Called "a fertile untapped resource for biomarkers" — i.e. the confound is itself signal, once separated |
| Coupling strength between correctly-aligned units | The quantity everyone thought they were measuring |

The mitigation is architectural, not statistical: **areal-feature-based cross-subject registration**, applied *after* per-subject denoising, forces most differences in area size/shape/position to be absorbed by the registration warp rather than to leak into the measured connectivity — "limiting the information leakage at the level of cortical areas is an important step towards disambiguating spatial and connectivity information". Wiki-general form: **when node identity is estimated per-instance, node placement and edge weight are not identifiable from the edge matrix alone; you need an explicit alignment field to subtract** ([[wiki/concepts/objective-identifiability.md]]).

---

## Individualised node sets, and topology-breaking variation

Inter-individual variability in functional organisation is largest in association cortex, is already present in newborns, and has a similar spatial distribution in macaques — so it is a structured, evolved property, not measurement slop. Group atlases buy correspondence and contrast-to-noise; individual atlases buy accuracy. The trade is empirical: more resting fMRI per subject markedly improves the reliability of individual connectivity estimates.

| Approach | How correspondence is maintained | Failure mode it addresses |
|---|---|---|
| **Areal classifier** — learn each area's multimodal fingerprint, then find it grayordinate-wise in a new individual | By *fingerprint*, not by position | Finds areas in subjects whose layout is atypical and therefore cannot be aligned by any registration |
| **Individualised network mapping** (Wang et al. 2015) — iteratively adjust a group atlas per subject, weighting the group prior *down* where inter-subject variability is known to be high or where this subject's SNR is good | Group prior as a per-region, per-subject-strength anchor | Lets the individual's idiosyncrasies drive the solution without losing the labels. Validated against invasive cortical stimulation mapping in surgical patients |
| **PROFUMO** | Hierarchical Bayesian: group and individual levels optimised jointly | Same, in a generative model |
| **Hyperalignment** | Abandons voxel/vertex correspondence entirely; aligns subjects on activation or correlation information alone | The only one that can handle **topology-breaking** differences — and it improves on areal-feature registration |

**The number that makes this unavoidable:** area 55b splits or swaps position in **11% of subjects**. No smooth warp can align a split area to an unsplit one. So there exist units whose cross-instance correspondence is not a spatial transform at all, and matching them is a *graph-matching* problem on connectivity fingerprints ([[wiki/concepts/subgraph-matching.md]]). The authors' proposed hybrid — use the areal classifier to establish corresponding areal searchlights, then hyperalign *within* each area — is a two-level correspondence scheme: discrete matching above, continuous alignment below, because topological correspondence breaks down below area scale even between healthy adults.

An open biological question the classifier makes askable: **do all humans have the same set of brain areas, or do some have extra areas and some missing ones?** The node *count* is not known to be a constant across individuals. Denoising accuracy gates the answer in both directions — noise can create an area, over-aggressive cleanup can delete one.

---

## What counts as signal is decided before the graph is built

Denoising is a prior commitment about which variance is allowed to become an edge, and the review is unusually explicit that several standard choices are wrong.

| Step | Recommended | Rejected, and why |
|---|---|---|
| Spatially specific artefact (motion, physiology, scanner) | **Spatial ICA + FIX classifier, per subject**, before cross-subject registration; a "soft" scrub that removes variance in proportion to a frame's noise and also cleans sub-threshold frames | Hard scrubbing — all-or-nothing, and leaves artefact in retained frames; it also costs more temporal degrees of freedom than ICA whenever the artefacts share information |
| Global respiratory (CO₂-driven) fluctuation, which spatial ICA does **not** remove | **Temporal ICA at group level** (works where samples along the orthogonalised axis are plentiful — 10⁵ timepoints in a big dataset, as spatial ICA works per-subject with 10⁵ voxels) | Global signal regression: removes task-related neural signal and **spuriously inflates anticorrelations** in functional connectivity |
| Head motion | Retain the neurally-driven part | Aggressive regression of all movement-explained variance — motion, like any behaviour, produces genuine sensorimotor BOLD (T2\*) as well as artefact (S0), and regressing everything deletes the former |
| Thermal noise | Neuroanatomically-informed spatial smoothing (i.e. a good parcellation) — reduces noise without spending temporal degrees of freedom | Denoisers that cost degrees of freedom, unless the downstream analysis is correlation-based enough to profit |
| Unvalidated defaults | — | Band-pass filtering, tissue-based nuisance regressors, blind tissue-based PCA: never validated against a known-ground-truth task paradigm |

The general principle, and it transfers: **choose which signal to keep as an explicit, justified step, rather than letting a preprocessing default impose it silently.** Motion is the sharpest case — you may legitimately want to remove even the *neural* consequences of head motion, but that is a study decision, not a cleanup.

---

## The effect-size correction

Brain–behaviour correlations from small samples are inflated and inconsistent because of sampling variability (Marek et al. 2020). Findings that passed significance in small studies necessarily had large apparent effects and have largely failed to replicate. The correction the field is asked to accept: **realistic, reproducible effect sizes are much smaller than published ones, and are still worth investigating** — which requires the `N` = 10⁴–10⁵ cohorts (UK Biobank, ABCD) rather than a better statistic. Read as a lesson for evaluation generally: an effect size selected for by a significance threshold is a biased estimate of itself ([[wiki/concepts/certification-instruments.md]]).

---

## For a builder

- **The vertex set is a hyperparameter with a conservation law attached.** Any system that discovers a graph from a continuous stream is making this choice implicitly (G27, G75). The review's contribution is that the choice is *not* asymptotically innocuous: it does not converge as granularity increases, and the same relational content appears as node-internal structure or as an edge depending on where the line was drawn.
- **Nodes should probably be soft.** Hard partitions demonstrably cannot express multiplicity, weighted overlapping components achieve higher within-unit homogeneity than partitions optimising for it, and overlap gives a *second edge matrix* (spatial overlap) that carried more behavioural information than the temporal one. The wiki's only existing soft, overlapping, partially-ordered node set is [[wiki/entities/conceptor.md]] — an independent arrival at the same design from recurrent-network state space **(brainstorm)**.
- **Node sets and coordinate systems are alternatives, not stages.** Gradients replace "which unit is this?" with "where is this in a `k`-dimensional connectivity-profile space", which is the same move as [[wiki/concepts/population-geometry.md]] one level up, and makes integration/segregation a *distance* rather than a partition property.
- **Per-instance node estimation needs an alignment field, or the edges lie.** This is the transferable form of the topography confound and it applies to any architecture that re-parses each episode into objects before relating them.
- **Correspondence may have to be two-level.** Discrete fingerprint matching for units that can split, merge or swap; continuous alignment inside a unit. A single smooth warp cannot cover 11% of cases even between healthy adult humans.

---

## Open problems

- **No criterion selects among representations.** Parcellated, overlapping-mode, gradient and time-resolved representations are complementary, and a result obtained in one has no clear implication for another — the review's explicit worry about siloing, and its call for comparative benchmarking before clinical translation.
- **The optimal amount, paradigm (rest vs task vs naturalistic movie) and field strength of data for individual areal classification is uncharacterised.**
- **Is the node count a per-individual variable?** Unanswered, and gated by denoising quality.
- **Directionality remains out of reach from fMRI.** The temporal slowness of BOLD and regional variability in the haemodynamic response function undermine lag-based causal estimates specifically; Bayesian nets and resting-state dynamic causal modelling are the live hopes. Every connectome in the wiki is therefore **undirected by instrument**, which is a hard limit for a framing whose edges are transitions ([[wiki/concepts/latent-graph-discovery.md]]).
- **The biological meaning of an fMRI edge is still open** — validating against invasive tracing and invasive recording in non-human primates is the proposed route.

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — the step that framing assumes has already happened: nodes and edges are taken as given, and this page shows the assumption is a *choice with a conservation law* — relational content moves between node-internal structure and edges as granularity changes, so "discover the graph" is underspecified until the vertex set is fixed (G27), and fMRI edges are additionally undirected by instrument.
- **[[wiki/concepts/mean-field-reduction.md]]** — the same coarse-graining question asked of *dynamics* rather than of *space*: that ladder decides how many moments of a population's density to keep, this page decides which patch of cortex counts as a population at all, and the two choices are made independently by every whole-brain model in the wiki.
- **[[wiki/concepts/dynamic-repertoire.md]]** — a third confound stacked on that page's window-dependence: a functional network is window-dependent *and* its very nodes were fixed by a parcellation that mixes coupling with topography, so a "network" is doubly a construct of the measurement.
- **[[wiki/concepts/metastability.md]]** — the reason that page's six-model comparison could not be run cleanly: the models use different connectomes at different parcellations, which this page shows is not a cosmetic difference but a redistribution of relational content between nodes and edges.
- **[[wiki/entities/fcann.md]]** — the wiki's whole-brain attractor model, whose 122-parcel node set and long-window correlation matrix are exactly the two commitments audited here; its between-subject and clinical contrasts inherit the topography/coupling confound unless areal-feature-based registration was used.
- **[[wiki/concepts/population-geometry.md]]** — gradients are that page's method applied to connectivity profiles instead of to neural state: `k` continuous coordinates per unit, with integration/segregation read as distance, so a partition is replaced by an embedding.
- **[[wiki/concepts/subgraph-matching.md]]** — what cross-individual correspondence becomes once units can split, swap or go missing (area 55b, 11% of subjects): matching by connectivity fingerprint rather than by position, i.e. graph matching, with continuous alignment only *inside* a matched unit.
- **[[wiki/concepts/objective-identifiability.md]]** — a concrete non-identifiability with a concrete fix: node placement and edge weight are not separable from an edge matrix alone, and the fix is to model the alignment field explicitly so that spatial variance is absorbed by the warp instead of being reported as coupling.
- **[[wiki/entities/conceptor.md]]** — the wiki's only soft, overlapping, graded-membership node set, arrived at from recurrent state space rather than from cortex; this page is the empirical argument that such a node set is *necessary* rather than merely elegant, since hard partitions cannot express multiplicity at any granularity.
- **[[wiki/concepts/event-segmentation.md]]** — the wiki's other answer to G27, and the temporal counterpart of this one: event segmentation carves the stream into nodes along time, parcellation carves the sheet into nodes along space, and both face the same question of whether the boundaries are real or imposed.
- **[[wiki/concepts/certification-instruments.md]]** — the measurement lesson transferred: effect sizes selected by a significance threshold in small samples are biased estimates of themselves, so a benchmark result and a brain–behaviour correlation fail in the same way when the sample is small and the filter is significance.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — one of the regions where the individual-variability problem is worst: association cortex carries the largest inter-subject variability in functional organisation, so any claim about "the" MPFC node in a group connectome is an average over the most variable part of the sheet.
- **[[wiki/concepts/effective-connectivity.md]]** — the live hope named in this page's directionality problem, taken to its current state: direction and sign are recovered not from lags in the BOLD signal but as *parameters of an inverted generative model*, which makes them available at whole-brain scale per subject (>40,000 connections in minutes) while making them contingent on the model class rather than on the data — and the vertex set it inverts against is the one this page audits.
- **[[wiki/entities/virtual-brain-twin.md]]** — the downstream system that inherits every choice this page catalogues, plus a measurement of how undetermined they are: 70 international teams analysing the same fMRI dataset produced **no two identical pipelines** and sizeable variation in the statistical results, with comparable studies for tractography done and for EEG underway — so a "personalised" connectome is personalised through an undetermined procedure (Hashemi et al. 2025).
- **[[wiki/concepts/connectome-state-transformation.md]]** — a use of the connectome that this page's unresolved choice sits underneath: a rank-10 operator carrying a resting graph into a task graph is defined entirely on one 268-parcel atlas, so every quantity it reports — the number of subsystems, the state-general/task-specific split, the sample cost — is stated in units this page shows do not converge, and nothing tests whether the operator survives re-parcellation.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — the structural connectome this page's conservation law applies to most literally: its 54%-within-subregion edge-mass figure is *definitionally* a function of unit size, its 66 units are sulcal/gyral landmarks, and its own authors close by proposing individual functional-connectivity parcellation instead.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the conservation law with a number on it: the *same* five brains and the *same* data give a structure–function correlation of `r = 0.66` at 66 nodes and `r = 0.36` at 998, because coarsening moves within-unit relations into the node, so no structure-explains-function figure is quotable without its parcellation.
- **[[wiki/concepts/integration-segregation-balance.md]]** — a case where the parcellation choice *is* the measurement boundary: within- and between-module connectivity partition each node's budget, so coarsening the atlas mechanically converts between-module mass into within-module mass and moves the entire cartographic profile without anything in the brain changing.
- **[[wiki/concepts/anatomical-harmonic-modes.md]]** — a partial escape: the Laplacian decomposition runs on 32,492 surface vertices with no parcellation and the atlas enters only when scoring reconstruction error, so the *basis* is parcellation-free even though every reported number is not (Vohryzek et al. 2024).
- **[[wiki/concepts/cortical-traveling-waves.md]]** — the parcellation choice stated as a method requirement rather than a caveat: wave analysis needs many approximately equal-area parcels (≥400, here 1000), and instrength topography is the wiki's most pipeline-sensitive quantity — 1760 diffusion pipelines give materially different maps, with tractography algorithm and parcellation the dominant factors (Koller et al. 2024).
- **[[wiki/concepts/parallel-timescale-streams.md]]** — the problem propagated into a state alphabet: 126 blueprint states are all subsets of seven Yeo networks over 68 Desikan regions assigned by geometric distance, so every occupancy, lifetime and transition statistic there is conditioned on a parcellation and network assignment that nothing learns (Alderson et al. 2026).
