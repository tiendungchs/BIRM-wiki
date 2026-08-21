# Cortical Traveling Waves — Direction of Flow as a Property of the Wiring, Not of a Controller

**A traveling wave is an oscillation whose phase propagates repeatedly across space, from sources to sinks. Distance-decaying connectivity plus finite conduction delays make waves *emerge*; what makes them point in a particular direction is a spatial gradient in **instrength** — each node's summed incoming connection weight, `s_i = Σ_j a_ij`. Waves run from low-instrength to high-instrength regions, because a heavily-driven oscillator phase-lags in a delayed coupled system. The human connectome hosts such a gradient (low in temporal/parietal, high in frontal/occipital), it is present in every individual measured, and in a 1000-region Kuramoto model on that connectome it directs essentially every wave that emerges — across four frequency bands, conduction speeds of 1–10 m/s, and five orders of magnitude of coupling gain. Delete the delays and the waves lose their direction while keeping their existence. This is the wiki's first mechanism in which *which way information flows* is set by a static scalar field computable from the weight matrix alone, with nothing learned, gated or routed.**

> **Provenance.** Koller, Schirner & Ritter 2024, *Human connectome topology directs cortical traveling waves and shapes frequency gradients*, Nature Communications 15:3570, doi:10.1038/s41467-024-47860-x (`raw/koller-2024-connectome-traveling-waves.md`). Structural connectivity from probabilistic tractography in **776** Human Connectome Project participants, group-averaged with consistency thresholding onto the Schaefer-1000 parcellation; instrength gradients replicated in three further cohort/parcellation combinations (Lausanne `n` = 70; Schaefer-400 on Rockland `n` = 369; a 500-region equal-area random parcellation, `n` = 972). Dynamics simulated in The Virtual Brain (Kuramoto and Jansen–Rit nodes, RK4, 1 ms step, 100 runs × 10 s). Empirical target: resting-state MEG in 80–89 HCP subjects, source-reconstructed to the same 1000 regions.

---

## The two direction mechanisms, and the one that is measurable in humans

| Mechanism | Variable | Wave runs | Measurable non-invasively? |
|---|---|---|---|
| **Intrinsic frequency (IF) gradient** | `ω_i` — the frequency a unit would show *disconnected* | **high → low** IF | **No.** Requires slicing tissue into disconnected units; done in animals, never in humans |
| **Instrength gradient** (this paper) | `s_i = Σ_j a_ij` — summed incoming weight | **low → high** instrength | **Yes** — tractography gives it directly |
| *Effective frequency (EF) gradient* | the frequency a unit actually shows *while connected* | co-varies, but see the dissociation below | Yes (M/EEG) — and it is the quantity earlier work correlated with wave direction |

**EF is a consequence, not a cause.** The obvious alternative story — instrength suppresses EF, and the EF gradient is what steers the wave — is ruled out by a dissociation: at one parameter setting, 99/100 randomly initialised runs produce waves significantly aligned with the instrength gradient while only **1/100** shows a significant flow-potential↔EF correlation, and some EF patterns are orthogonal to or opposed to the flow. Instrength steers directly; EF is a second, partially independent readout of the same wiring.

## The model

Kuramoto oscillators with distance-dependent coupling and delays — the same equation as [[wiki/concepts/metastability.md]], read for its *spatial* rather than its coalition structure:

```
dθ_i/dt = ω_i + (K/N) Σ_j a_ij sin( θ_j(t − τ_ij) − θ_i(t) ),     τ_ij = L_ij / v
```

Cortical model defaults: `ω = 10 Hz`, `v = 3 m/s` (fibre lengths from tractography, `r = 0.8` with Euclidean distance), `K = 0.01`, `N = 1000`.

**Wave detection is a divergence test, not a fit.** From the instantaneous phases, compute the spatial phase gradient field `ξ`; at each node score its **angular similarity** to an idealised diverging field (1 = source, −1 = sink, 0 = unorganised); permute phases across space 1000× for significance. A timepoint counts as carrying a wave if at least one significant source or sink exists. Propagation is then summarised by the **wave flow potential** — the curl-free part of `ξ` under a Helmholtz decomposition, obtained by solving `Δ D = ∇·ξ`. It is a scalar landscape in which waves run downhill from peaks (sources) to valleys (sinks), so "does the wave follow the gradient" becomes one spatial correlation between two scalar maps, tested against a **spin-permutation null** (1000 random rotations) that preserves spatial autocorrelation.

## The instrength gradient exists in the human connectome

| Property | Value |
|---|---|
| Distribution | Right-skewed (skewness 1.33, `z` = 13.48, `p` < 0.01) — a few very-high-instrength regions, most weak |
| Topography | Increases from **temporal and parietal** (low) → **frontal and occipital** (high) |
| Spatial scale | Quantified by spectrospatial mode analysis on the cortical mesh (Fourier generalised to a surface): low-frequency modes dominate; **mode 5**, wavelength **202 mm**, contributes significantly in **every one of the 776 subjects** |
| Replication | Present in all three validation cohorts/parcellations |
| Caveat | Instrength topography is pipeline-sensitive — Gajwani et al. compared 1760 diffusion pipelines and found tractography algorithm and parcellation dominate; streamline normalisation by region size or fibre length changes the map |

## The control ladder — what each ingredient is doing

All rows are the same 1000-region model; `r` is the spatial correlation between the average flow potential and the *original* instrength gradient.

| Model | Waves present (% of time) | Instrength-directed | `r` | What it isolates |
|---|---|---|---|---|
| **Empirical SC, delays from fibre length** | 87.2% | all | **−0.74** | the claim |
| Shuffled connection strengths | ≈0% | — | 0.02 | distance-decay of *weights* is what makes waves exist at all |
| Synthetic exponential-distance-rule surrogate | 100% | none *of the original* | −0.04 | waves follow **whatever instrength gradient the generating process happens to produce** — here frontal→parietal |
| **Zero delay** (SC intact) | 24.1% | **none** | −0.02 | **delays are what convert an instrength gradient into a direction** |
| Constant 23 ms delay | 96.3% | 95.1% | −0.64 | distance-*dependence* of delays is not required; a uniform lag suffices |
| Instrength-normalised SC | 94.7% | none | — | removing the gradient removes the direction; hub statistics (degree, betweenness, eigenvector centrality) explain nothing of the residual systematic flow |
| Jansen–Rit neural masses instead of phase oscillators | 71.8% | 41.7% | −0.63 | survives a step up [[wiki/concepts/mean-field-reduction.md]]'s ladder to a model with explicit E/I populations |

Robust to added noise and to random dispersion of intrinsic frequencies. Across a full sweep (`ω` ∈ {1, 10, 20, 40} Hz; `v` ∈ 1–10 m/s; `K` ∈ 10⁻⁵–10), waves emerge in a broad interior band — none at very low `K` (below critical coupling) or very high `K` (full synchrony or erratic behaviour) — and **wherever they emerge they follow the instrength gradient**. Higher intrinsic frequency requires faster conduction to sustain waves. Simulated wave speeds stay <5 m/s, matching empirical large-scale cortical waves.

## The two gradients interact, and the balance point is where wave *type* changes

Superimpose an IF gradient of the same spatial shape but opposing sign on the instrength gradient and sweep its amplitude:

| IF gradient range | Wave direction |
|---|---|
| none (all 10 Hz) | fully instrength-directed |
| **9.25–10.75 Hz** (scaling ≈ 0.75) | **balanced** — direction collapses and the dynamics become heterogeneous: spiral waves, plane waves, source–sink waves and episodes of full synchrony across runs |
| 8.5–11.5 Hz | fully IF-directed (opposite sense) |

**This is the paper's most exportable idea.** A ±0.75 Hz detuning of local oscillators is enough to reverse the direction of flow over a fixed wiring. Rotating waves — which also dominate the instrength-normalised control — appear to be what the system does when *no* gradient is decisive. So the architecture gets a **stable anatomical default direction plus a cheap dynamic override**, and the override variable is local frequency, not connection weight. Candidate biological carriers named by the authors: a stimulus accelerating local oscillations in the receiving area, or thalamocortical loops imposing a large-scale IF gradient in advance of input.

## Fit to resting MEG, and the frequency-band split

| Fit | Alpha | Beta | Gamma |
|---|---|---|---|
| Phase-locking-value functional connectivity (PLV-FC), best `r` | 0.564 | 0.591 | 0.594 |
| Phase-lag-index functional connectivity (PLI-FC; zero-lag components discarded), best `r` | **0.46** | 0.36 | 0.14 |
| At the best-fitting point: instrength ↔ flow potential | −0.66 | −0.65 | −0.65 |
| At the best-fitting point: instrength ↔ EF | −0.85 | −0.86 | −0.87 |

**The load-bearing coincidence:** the models that best reproduce empirical MEG functional connectivity are *the same models* that produce instrength-directed waves and **smooth** (rather than clustered) EF gradients. Fit was not optimised for wave direction; it came along with it.

**Opposing alpha and beta gradients need two subnetworks.** Empirically (replicating Mahjoory et al.), alpha EF rises occipital→prefrontal while beta EF rises prefrontal→occipital. One connectome cannot produce both. Non-negative matrix factorisation over the 776 individual SCs — chosen because non-negativity makes components readable as *additive subnetworks* — yields 5 components by held-out-imputation cross-validation, with two of them carrying opposed anterior–posterior instrength gradients. Those two alone:

| | Full SC model | α + β subnetworks |
|---|---|---|
| Alpha EF fit (concordance correlation) | 0.20 | **0.69** |
| Beta EF fit | 0.38 | **0.50** |
| Combined FC+EF fit | — | +62% (α), +47% (β) |

The two subnetworks together explain 36% of SC variance and their combined instrength correlates `r = 0.96` with the full connectome's — i.e. **the decomposition is not adding wiring, it is separating a single measured matrix into parts that carry contradictory gradients**, and letting each part run at its own frequency and conduction speed (α at ~9–10 m/s, β at ~2 m/s). Whether such frequency-specific structural subnetworks exist (layer-specific candidates) or whether the bands interact is open; MRI resolution cannot currently decide.

---

## Why this matters for building a reasoning model

- **A routing prior that costs nothing to compute and nothing to run.** Everywhere else in the wiki, "where does this signal go next" is a learned object: attention logits, a gating network, a learned adjacency. Here it is `s_i = Σ_j a_ij` — one sum per node over the weight matrix you already have — plus a delay. Any recurrent architecture with delayed message passing over a fixed graph *already has* a preferred direction of flow implied by its column sums, and no architecture in the wiki reads it. Logged as **G88** in [[wiki/architectural-gaps.md]].
- **Delays are not a nuisance to be zeroed.** The zero-delay control is the sharpest result on the page: waves still occur 24% of the time, but **not one** follows the gradient. Direction is a *delay-dependent* property. Since almost every artificial network is the `τ → 0` limit ([[wiki/concepts/mean-field-reduction.md]]), the entire phenomenon is unavailable to them by construction — the same conclusion [[wiki/concepts/learnable-synaptic-delays.md]] reaches from the expressivity side, arrived at here from the dynamics side. And a *constant* 23 ms lag is nearly as good as the true fibre-length delays, so the cheap version works.
- **Two-timescale control with one knob each.** Slow: the weight matrix sets a default direction and it is stable over years. Fast: a ±0.75 Hz local frequency offset overrides it. `(brainstorm)` This is an unusually clean separation for a builder — bake the default routing into the wiring (free, no parameters), and expose *local time constants* as the runtime control variable rather than the weights. In a spiking or oscillatory substrate, that control is a single scalar per module.
- **Anatomy generates a functional coordinate, again.** [[wiki/concepts/anatomical-harmonic-modes.md]] generates a *basis* from wiring; this page generates a *direction field* from wiring — both closed-form from the connectivity, both available before the system runs. Together they narrow **G82** from "no manifold is generated" to "two anatomical constructions generate one, and neither has dynamics on it yet". Note the shared surprise: the surrogate built from a deterministic exponential distance rule spontaneously develops its own instrength gradient and reliably directs waves along it, so the geometry-vs-wiring dispute (**T251**) has a third reading — geometry and wiring may be arguing about *which* gradient, not whether there is one.
- **A directional read-out that is cheap to instrument.** The flow potential is a Helmholtz decomposition of a phase-gradient field: one Laplacian solve on the module graph, no training, no labels. It gives a scalar landscape per timepoint from which "which modules are currently sourcing and which are sinking" reads off directly — a monitoring statistic for a modular architecture that sits alongside `σ_R` ([[wiki/concepts/metastability.md]]) and participation coefficient `B` ([[wiki/concepts/integration-segregation-balance.md]]), and unlike both of them it is *signed*.
- **Bands as separable subnetworks over one substrate.** The NMF result says a single weight matrix can be additively decomposed into parts whose instrength gradients disagree, each running at its own frequency and speed, superposing into the observed dynamics. `(brainstorm)` The architectural analogue is a shared weight matrix decomposed into a small number of non-negative components, each assigned its own oscillation rate and lag — several routing directions coexisting on one set of wires, addressed by frequency. That is a multiplexing scheme, and it is cheaper than maintaining separate graphs.

## Open problems

| Problem | State |
|---|---|
| Nothing learns | Weights are tractography, delays are fibre length over a swept velocity, coupling is a swept scalar, intrinsic frequency is set by hand. The same terminal limitation as every whole-brain page in the wiki |
| No task, no behaviour | Every number is a fit to resting connectivity or a spatial correlation between maps. Wave direction is never shown to affect a computation, a decision or a readout |
| The theory is asserted, not derived | The mechanism rests on the known analytic result that high-instrength nodes phase-lag in delayed coupled-oscillator systems; the authors note that combining it with a spatial gradient "could be a theoretical foundation" — the derivation is not carried out |
| Instrength is pipeline-dependent | 1760 diffusion pipelines give materially different instrength topographies; the group-average, consistency-thresholded Schaefer-1000 map is one choice among many, and thresholding itself reshapes it |
| Frequency-specific subnetworks are unobserved | The α/β subnetworks are a decomposition of a diffusion matrix that has no layer resolution. They are consistent with layer-specific frequency channels but are not evidence of them |
| Beta waves are ambiguous | In the full-SC model, beta waves were detected 38% of the time with only 6% instrength-directed, and the authors state the supplementary movies show no visible beta waves — the beta story only works after the subnetwork decomposition |
| Anatomy vs. state | Whether wave direction is fixed by wiring or set dynamically is unresolved — ECoG alpha/theta match the instrength gradient at rest *and* on task, while infra-slow fMRI and macaque gamma waves follow the principal *functional* gradient, and M/EEG alpha directions vary. Logged as **T252** in [[wiki/empirical-tensions.md]] |
| Rotating waves are unquantified | They dominate whenever gradients are absent or balanced and were never measured; the wiki has no account of what a rotating wave computes |

## Connections

- **[[wiki/concepts/metastability.md]]** — the same Kuramoto-on-a-connectome system read along the other axis: that page measures *how much* the coalition structure churns (`σ_R`, a scalar with no spatial content), this one measures *which way* the phase propagates while it churns — and both require the same delayed, partially-synchronised interior regime, since waves vanish at low coupling and at full synchrony alike.
- **[[wiki/concepts/mean-field-reduction.md]]** — the rung that predicted this: its neural-field row states that restoring finite conduction speed `c` turns the parked attractor bump into a travelling pulse, and this page supplies the network-scale version plus the missing ingredient — a travelling pulse has no preferred *direction* until the coupling kernel's row sums vary across space. The Jansen–Rit control confirms the effect survives one rung up from phase oscillators.
- **[[wiki/concepts/learnable-synaptic-delays.md]]** — the dynamics-side argument for the same parameter: delays there buy `Θ(n log n)` VC dimension per programmable delay, and here they buy the entire directional structure of network flow — zero-delay networks produce waves but not one of them is gradient-aligned, so a `τ = 0` architecture forfeits the phenomenon by construction.
- **[[wiki/concepts/anatomical-harmonic-modes.md]]** — the sibling construction: both derive a functional coordinate system in closed form from anatomy before any activity is observed (a spectral basis there, a direction field here), and both find that a *synthesised* exponential-distance-rule connectome reproduces much of the effect — which is the same finding that keeps T251 alive.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — the same summed-weight statistic put to a different use: strength and centrality define *where the bottleneck is*, whereas the spatial **gradient** of strength defines *which way traffic flows through it* — and notably the instrength-normalised control shows degree, betweenness and eigenvector centrality explain none of the residual wave direction, so hub membership and flow direction are separate facts about one matrix.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — what a phase relation between two areas licenses, made directional: a consistent non-zero phase lag across a spatial gradient is a wave, not a coupling artefact, and the PLI-FC result (alpha 0.46, gamma 0.14) says the non-zero-lag component of resting synchrony is largely an alpha-band phenomenon.
- **[[wiki/concepts/dynamic-repertoire.md]]** — supplies the spatial half of the repertoire: that page's manifold is a set of *configurations*, and this page says the anatomy also fixes a preferred *trajectory direction* through them, stable on the timescale of white matter rather than of a task.
- **[[wiki/concepts/effective-connectivity.md]]** — a directionality estimate that requires no model inversion: instrength is a column sum of the structural matrix and the flow potential is one Laplacian solve, so a signed flow direction is obtained without fitting a generative model to the time series.
- **[[wiki/concepts/integration-segregation-balance.md]]** — a second graph-derived control statistic on the same substrate: participation coefficient says how a node's edge mass is *distributed*, instrength says how much arrives, and only the latter is claimed to set a direction.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the forward direction used at its strongest: not "predict the functional connectivity matrix" but "predict a spatiotemporal property of the dynamics", where the structural gradient survives shuffling, normalisation and delay-removal controls that a correlation-matching benchmark would not have applied.
- **[[wiki/concepts/latent-graph-discovery.md]]** — navigation given a direction: if the discovered graph carries an instrength gradient, then traversal has a default downhill sense supplied by the weights themselves, and a local frequency offset is enough to reverse it — a graph-navigation policy with no policy network.
- **[[wiki/concepts/node-definition-problem.md]]** — the parcellation dependence stated as a requirement rather than a caveat: wave analysis needs many, approximately equal-area parcels (≥400, here 1000), and instrength topography is the single quantity in the wiki most demonstrably sensitive to the pipeline that produced the vertex set.
- **[[wiki/entities/virtual-brain-twin.md]]** — the simulator these results run in, and the platform where the claim would be personalised: cortical travelling waves are listed there as something surface-based simulation buys, and this page is what they are for.
