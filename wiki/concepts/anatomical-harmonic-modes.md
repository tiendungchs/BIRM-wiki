# Anatomical Harmonic Modes — A Fixed Spectral Basis for Cortical Activity, Generated From Wiring Before Any Data Arrive

**Write cortical activity as a weighted sum of the eigenvectors of a Laplacian built from anatomy alone: `F(x,t) = Σ_k a_k(t) ψ_k(x)`. The basis `{ψ_k}` is *generated analytically from the wiring rule* — no activity, no fitting, no dimensionality reduction after the fact — and the entire state of the brain at time `t` collapses to the coefficient vector `a(t)`. Which anatomy you feed the Laplacian is then an empirical question, and the answer is that a two-term wiring rule wins: an exponential decay with Euclidean distance (the exponential distance rule) *plus* the rare long-range connections that violate it. ~20 modes out of 200 carry the bulk of the reconstruction of both resting connectivity and 47 task-activation maps.**

> **Provenance.** Vohryzek, Sanz-Perl, Kringelbach & Deco 2024, *Human brain dynamics are shaped by rare long-range connections over and above cortical geometry*, PNAS 122, doi:10.1073/pnas.2415102122 (`raw/vohryzek-2024-long-range-connections-brain-dynamics.md`). 255 Human Connectome Project participants (twins and siblings excluded; a separate 100-participant replication), left hemisphere only, 32,492 surface vertices, parcellated to 180 Glasser regions for scoring. 15 min resting fMRI + 47 task contrasts from 7 task domains. Structure from the group-average high-resolution vertex-wise diffusion connectome of Pang et al. 2023 — the same data and the same benchmark that paper used to argue for *geometry*, re-run against a wiring-based basis. The disagreement is **T251** in [[wiki/empirical-tensions.md]].

---

## The construction

| Step | Object | Definition |
|---|---|---|
| 1 | Wiring rule | `C^EDR_ij = A e^{−λ r(i,j)}`, `r` = Euclidean distance on the cortical mesh. Fitted to the human diffusion connectome by least squares over 400 equal-distance bins spanning 10–170 mm: `A = 0.066`, `λ = 0.162 mm⁻¹` |
| 2 | The exceptions | Long-range (LR) edge = a structural weight **>3 SD above the mean of its own distance bin**, at distance **>40 mm**. Rare by construction; added on top of the continuous EDR matrix to give `EDR+LR` |
| 3 | Laplacian | Normalised graph Laplacian from `L = D − A`, `D = diag(Σ_j A_ij)` |
| 4 | Modes | `Δ_A ψ_k = λ_k ψ_k`; eigenvalues sorted ascending = ascending spatial frequency, so `ψ_1` has the longest wavelength |
| 5 | Projection | `a_k(t) = ⟨F(x,t), ψ_k(x)⟩` — an inner product, because the basis is orthogonal by construction. Task maps are the same with `a_k(t) → a_k` |

**Four bases compared, all on identical data:**

| Basis | Anatomy assumed | Operator |
|---|---|---|
| Geometry | The folded cortical surface *is* the connectivity | Laplace–Beltrami operator on the mesh (cubic finite elements) |
| EDR binary | Distance decay, thresholded against a random weight distribution | Graph Laplacian, `λ = 0.12 mm⁻¹` |
| EDR continuous | Distance decay, all weights kept | Graph Laplacian, `λ = 0.12 mm⁻¹` |
| **EDR+LR** | Distance decay **+ the outliers to it** | Graph Laplacian, `λ = 0.162 mm⁻¹` |

The geometry basis is not an independent hypothesis so much as a *limit* of the other three: the heat kernel is the optimal locality-preserving solution and the Laplace–Beltrami eigenfunctions inherit an exponential kernel (Belkin & Niyogi), so "cortical folding" and "exponential distance rule" are the same claim stated in two coordinate systems. The only thing that separates the bases is whether the rare violations of that claim are represented at all — **folding cannot express an anterior–posterior fibre, because there is no way to fold two ends of a sheet into adjacency and keep everything else in place.**

## What the modes reconstruct

| Target | Result |
|---|---|
| **Long-range functional connectivity** (the subset of pairs with `FC > 0.5` *and* Euclidean distance `> 40 mm`) | All four bases decrease monotonically in mean-squared-error distance: ≈0.03 at 20 modes, ≈0.01 at 100, ≈0.005 at 200. At 200 modes EDR+LR beats geometry (`p < 0.0005`) and EDR continuous (`p < 10⁻⁴`), both Bonferroni-corrected paired `t` over 255 subjects |
| **47 task-activation maps** | Same monotone shape, plateau near 0.02. Per-mode contribution has a sharp elbow at ~20 modes. Restricted to the first 20 modes, EDR+LR reconstructs more accurately than geometry on average across all 47 contrasts |
| **Shuffled-LR null** | Randomly relocating the long-range edges within the EDR+LR graph destroys the advantage — the *specific* placement of the rare edges is what carries it, not the extra edge count or the extra weight |
| **Raw structural connectome as the basis** | *Worse* than all four. The winning object is not "the measured wiring" but an analytic wiring law plus its outliers — the EDR term denoises the short-range half that tractography estimates badly |

## The three qualifications the headline does not carry

1. **EDR+LR vs EDR binary is not significant.** The significant contrasts are against geometry and against EDR continuous. A thresholded, purely distance-based graph with no long-range term is statistically indistinguishable from the winner on the resting-state benchmark.
2. **The advantage lives in the global signal.** Regress the global signal out of the resting fMRI and the EDR+LR-vs-geometry difference goes non-significant. The authors take this as principled (global fluctuation is an emergent network effect worth keeping, not a nuisance) — but it means the result is stated in a preprocessing convention that a large fraction of the field does not use.
3. **Behaviour does not discriminate the bases.** Reconstructions from *all four* bases predict fluid intelligence (PMAT24 correct responses) and processing speed, and the prediction is driven by brain state (task > rest) consistently across representations. So the basis that reconstructs activity best buys nothing measurable at the behavioural read-out — logged as **G87** in [[wiki/architectural-gaps.md]].

## Why this matters for building a reasoning model

- **A generated manifold, not a measured one.** Every low-dimensional description elsewhere in the wiki is recovered by running a dimensionality-reduction algorithm on activity. Here the coordinate system is a closed-form function of the connectivity matrix, available before the system is switched on — which makes "the state is low-dimensional" a falsifiable architectural claim rather than a post-hoc summary (see G82).
- **~20 numbers is the working state.** Both spontaneous and evoked activity live in the same ≤20-dimensional span. If that survives, the interface between a whole-brain substrate and a symbolic controller is a short real vector, not a 32k-vertex field.
- **Rare edges are basis-shaping, not throughput-shaping.** The standard argument for long-range connections is communication cost. This is a different argument: a handful of exceptions to a distance rule change the *eigenvectors* of the whole operator, so they redefine the coordinates every other computation is expressed in. `(brainstorm)` The design lever is not "add skip connections for gradient flow" but "add the minimum number of long edges that make the low-frequency eigenvectors align with the task's activation maps" — a spectral objective on the wiring, computable without running the network.
- **The connection to graph transformers is exact.** Laplacian eigenvectors of a graph are already the standard positional encoding for graph attention. This paper says which graph to take them from for cortex, and reports that the *low* eigenvectors are where the content is. `(brainstorm)` A learned architecture could put the exception set itself under optimisation: keep a fixed exponential-decay prior over a spatial embedding, learn a sparse residual of long edges, and the basis follows.
- **The failure mode is stated honestly.** Reconstruction fidelity and functional consequence come apart here (qualification 3). Any architecture justified by "it reconstructs the target representation better" inherits this — the wiki has no case yet where a better basis produced a better decision.

## Open problems

| Problem | State |
|---|---|
| Static bases, dynamic target | The coefficients `a_k(t)` are computed but never modelled: no dynamics, no transition structure, no dwell times. The paper reconstructs a *time-averaged* connectivity and *static* task maps, and explicitly defers the temporally-evolving description |
| Is the elbow at 20 modes a property of the brain or of fMRI? | BOLD is spatially smooth and low-pass; a smooth field will be compactly represented in *any* smooth basis. There is no null here that fixes the smoothness and asks what the elbow would be |
| Left hemisphere only | Inherited from Pang et al. 2023 for comparability. The interhemispheric edges — the clearest case of a fibre that folding cannot express — are excluded by construction, which if anything understates the long-range effect |
| Nothing learns the exception set | The 3-SD / 40-mm threshold is a hand-set definition. What is the *smallest* set of long edges that achieves a given reconstruction, and does it coincide with the connector hubs? |
| Whose modes? | Group-average connectome, group-average mesh. Individual differences in the basis are not measured, so it is unknown whether the coefficient vector is comparable across people |

## Connections

- **[[wiki/concepts/structured-flows-on-manifolds.md]]** — the same claim from the two ends: that page argues symmetry breaking by heterogeneous long-range fibres is what gives a reduced flow any structure at all, and this page measures it — deleting the long-range exceptions (or shuffling their positions) degrades exactly the low-frequency modes the flow would live in.
- **[[wiki/concepts/population-geometry.md]]** — the contrast that page's caution demands: every manifold there is recovered by an algorithm from activity, whereas this basis is a closed-form function of the connectivity matrix, so it is the wiki's one *generated* low-dimensional coordinate system.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — supplies the anatomical identity of the exceptions: the rare >3 SD long-range edges are the between-module mass this page's connector hubs carry, and the shuffled-LR null says their placement, not their count, is what does the work.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the direction that works, used in its cheapest form: structure is never inferred here, it is *assumed as a two-parameter law*, and the raw structural connectome performing worse than the fitted law is the same tractography-noise result read as a modelling recommendation.
- **[[wiki/concepts/mean-field-reduction.md]]** — the `W = W_hom(|x−y|) + W_het(x,y)` split of that page's neural-field rung, measured: `W_hom` is the exponential distance rule with `λ = 0.162 mm⁻¹`, `W_het` is the 3-SD outlier set, and here the split is used to build a basis rather than to test resting-state stability.
- **[[wiki/concepts/dynamic-repertoire.md]]** — what this page leaves out: the repertoire is the trajectory of `a(t)` through the mode space, and the paper computes those coefficients but models no dynamics on them, so the two pages describe the same object's coordinates and its motion respectively.
- **[[wiki/concepts/node-definition-problem.md]]** — a partial escape from it: the decomposition runs at 32,492 vertices with no parcellation, and the Glasser-360 atlas enters only at the scoring step, so the basis itself is parcellation-free even though every reported number is not.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the navigation side given a coordinate system: if the state is a ≤20-dimensional coefficient vector over a basis fixed by the graph, then navigating the graph and moving in the spectral embedding of the graph are the same operation — which is the assumption graph attention already makes with Laplacian positional encodings.
- **[[wiki/concepts/metastability.md]]** — the missing dynamical layer named from the other side: `σ_R` measures how much of the repertoire is visited, and this page supplies the axes that variance would be expressed in.
- **[[wiki/concepts/cortical-traveling-waves.md]]** — the sibling construction from the same wiring: a spectral *basis* here, a *direction field* there, both closed-form from anatomy before any activity is observed — and both find a synthesised exponential-distance-rule connectome reproduces much of the effect (there it spontaneously grows its own instrength gradient and directs waves along it), which is the same reason T251 stays live (Koller et al. 2024).
- **[[wiki/concepts/small-world-topology.md]]** — the statistic that cannot adjudicate this page's comparison: geometry, the exponential distance rule, and the distance rule plus rare long-range exceptions all score as small-world, so separating them required a reconstruction test rather than a topology summary.
