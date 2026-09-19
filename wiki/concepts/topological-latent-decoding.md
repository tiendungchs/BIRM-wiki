# Topological Latent Decoding — Recovering a Latent Variable From the *Shape* of Population Activity, With No Labels

**Estimate the topology of a population's state cloud first (persistent homology), fit an object of that topology to it (a spline), parameterize the object by arc length, and decode any state by projecting it to the nearest point. The latent variable is the parameterization — never regressed against a measured covariate, so the decoder can be run where no covariate exists (sleep) and can disagree with the measured one.**

> **Provenance.** Chaudhuri, Gerçek, Pandey, Peyrache & Fiete 2019, *The intrinsic attractor manifold and population dynamics of a canonical cognitive circuit across waking and sleep*, Nat. Neurosci., doi:10.1038/s41593-019-0460-x (`raw/chaudhuri-2019-intrinsic-attractor-manifold-head-direction-circuit.md`). The method is named **SPUD** (Spline Parameterization for Unsupervised Decoding). Data are re-analysed from Peyrache et al. 2015: mouse anterodorsal thalamic nucleus (`ADn`), 7 animals, open-field foraging plus intervening REM and non-REM sleep. A contemporaneous independent method (Rybakken, Baas & Dunn 2019) uses persistent *co*homology for the same purpose.

This page is the estimator [[wiki/concepts/population-geometry.md]] names as missing — "topology is not dimension, and needs a different estimator" — and the route by which criterion C1 of [[wiki/concepts/attractor-identification.md]] is actually measured rather than asserted.

---

## The procedure

| Step | Operation | Detail as run |
|---|---|---|
| 1 | Bin spikes → point cloud in `R^N` | ~100 ms bins for decoding, 1 s counts for homology; **square-root** the rates to stabilise variance; *all* recorded cells, no tuning-based subselection |
| 2 | Optional pre-reduction | Isomap to `D_e` with `D_m ≪ D_e ≪ N` (3 for pictures, 10 before homology). **Not required** — direct high-dimensional fits were *better* when data sufficed |
| 3 | Topology | Persistent homology (Ripser) → Betti barcodes `H0, H1, H2`; a feature persisting over many scales is real |
| 4 | Intrinsic dimension | Correlation dimension and related estimators |
| 5 | Fit | Piecewise-linear closed curve with `K = 12` knots, initialised by `k`-means, minimising `(Σ_i ‖x_i − L(y)‖)·\|L(y)\|` — the length factor is the regulariser |
| 6 | Parameterize | Arc length along the curve, rescaled to `[0, 2π)`. This is the **latent variable estimate (LVE)**, `α` |
| 7 | Decode | Project a state to the nearest point of the curve; read off `α` |

**The one robustness patch, and it is generic.** Persistent homology is severely outlier-sensitive. `nt-TDA`: take a neighbourhood of radius = the 1st percentile of the pairwise-distance distribution, count neighbours per point, and delete the bottom 20th percentile of that count. This is what made homology work on REM data at all.

---

## Why this is not dimensionality reduction

**Every global embedding method in the wiki — PCA, Isomap, LLE, t-SNE, UMAP — assumes the manifold is topologically trivial** (a crumpled hole-free plane or ball). Consequences, stated as a hard failure rather than a caveat:

- A 1-D ring needs **2** dimensions to embed. So global reduction returns, at best, a *two*-parameter description of a *one*-dimensional variable — it cannot recover the latent even in principle, and the reported dimensionality is inflated by exactly the topology.
- SPUD never builds a global low-dimensional embedding. Steps 5–7 are **local, on-manifold coordinates** of matching topology, which is why they work for rings, tori and anything else with a hole.

This is a sharper statement than [[wiki/concepts/projection-distortion.md]]'s neighbour-corruption numbers: there the embedding distorts, here it is structurally incapable of the answer.

---

## What the instrument bought on the head-direction circuit

| Result | Number | Why it matters |
|---|---|---|
| **The state cloud is a ring** | `H1` one persistent feature, `H2` none (contrast: a simulated grid module gives `H2`) | The topology is *measured*, in a state space of thousands of cells, against behaviour that was **at least 5-dimensional** (position, orientation, linear and angular speed) — so the 1-D answer is not inherited from the task |
| **The blind latent matches the measured covariate** | `α` ≈ head angle up to origin and handedness; regressing rates on `α` recovers tuning curves with no head-angle data anywhere in the pipeline | Direct validation that representation topology matches represented-variable topology |
| **The blind latent *beats* the measured covariate** | `α` explains more cross-validated spiking variance than measured head direction, and matches a supervised tuning-curve decoder's internal estimate better than it matches the real angle | **The label is the noisier quantity.** The internal representation may be a wrong, past, or future heading estimate — or the goniometer may be wrong — and an unsupervised decoder is the only instrument that can be right when the label is not |
| **There is nothing else in there** | Shared ring coding accounts for **94%** of between-neuron covariation; synthetic data from `α`-tuning + independent data-matched-Fano-factor spiking reproduces the cloud; residual covariance after removing `α` is structureless | A *purely* 1-D code down to the noise floor. Postsubicular cells and `ADn` during non-REM do show extra dimensions, so the negative is not an insensitivity of the method |
| **Isometry** | Uniform arc-length parameterization decodes well with **no** per-region rescaling | Equal code length per equal angle — criterion C4, and the property an integrator needs so a unit velocity input means the same thing everywhere on the manifold |

**Why a purely 1-D answer is a stronger claim than a physical ring.** The fly ellipsoid body has an anatomical ring; that is compatible with the same cells coding other things too. A 1-D *state-space* manifold forbids it.

---

## The instrument's second job: dynamics on and off the fitted object

Once a manifold is fitted, velocity vectors between consecutive states decompose into radial (toward the object) and tangential (along it). This converts two attractor criteria from qualitative claims into permutation-tested numbers, and it is the part with no machine analogue anywhere in the wiki.

| Measurement | Result during REM (no directional input from the world) | Criterion it settles |
|---|---|---|
| **Flux magnitude, off- vs on-manifold** | Net flux significantly **larger** off-manifold, in both radial and tangential components; bins split at the 50th percentile of distance to the spline; null = shuffled assignment of velocity vectors to points, 1000 permutations | C2 (flow-back), measured during **spontaneous** activity with no perturbation applied — the noise does the perturbing |
| **Flow field along the manifold** | Roughly uniform bars, no convergence points | No discrete fixed points on the ring |
| **log density of decoded angle along the ring** | Flat within across-session variability | Energetic equivalence of manifold states |
| **Squared angular displacement vs lag** | **Linear** in REM (unbiased diffusion), **quadratic** at short lags in waking (correlated velocity drive) | The state is a free particle on the ring when the drive is removed; the same curve validates that the decoder is time-resolved enough |

---

## The load-bearing physics: which noise can move a state on a manifold

The diffusion constant is the fidelity of the memory, and its decomposition is the page's most exportable result.

| Quantity | Value |
|---|---|
| Measured REM diffusion | **1.1 ± 0.04 rad² s⁻¹** (other animals 0.52 ± 0.03, 1.3 ± 0.06) |
| Predicted from **independent per-neuron** noise in a matched network model | **20–50× smaller** |
| Accounted for by **low-dimensional noise aligned to the manifold** | SD 8.5 rad² s⁻¹, temporal correlation ≤ 20 ms — *comparable in amplitude to the waking head-velocity drive* |

The reason is geometric and general: **a unit of high-dimensional isotropic noise has variance `1/N` along the manifold.** Independent per-unit noise — Poisson spiking, or any input projecting in a spatially uncorrelated way — is therefore nearly impotent at moving the state, and over-dispersion does not rescue it. Only noise entering through a channel *aligned* to the manifold moves the code, and that is the same channel the velocity input uses.

Two consequences:

- **Fidelity is limited by input noise, not internal noise** — a conclusion previously established for sensory and sensorimotor pathways, now shown for a cognitive memory/integration circuit.
- **The update channel and the corruption channel are the same wire.** A designer cannot reduce drift by making units quieter; drift is set by the alignment of the drive. This is `G124`.

---

## Instrument validity: the wake-trained decoder sees nothing where there is something

During non-REM sleep the `ADn` manifold is **not** the waking ring. It is a **cone** whose circular rim is the waking/REM ring, carrying two latents:

| Manifold coordinate | Decoded content |
|---|---|
| Tangential (circular) | Head direction — matches two differently-assumptioned wake-trained supervised decoders |
| Radial (spoke from centroid) | **Population firing rate** — the slow global amplitude fluctuations of non-REM, down to nearly the zero-activity cone tip |

Modelling: the same attractor circuit reproduces waking, REM and non-REM if the **global** input to all neurons is given large multiplicative suppressive fluctuations (amplitude ≤ 1). Read backwards, that says a *discrete* attractor in the total drive pins the manifold's radius across waking and REM, and non-REM releases it — a second, amplitude-dimension attractor nobody was looking for.

**The methodological result.** Wake-trained supervised decoders report non-REM dynamics as fast, structureless diffusion, because they project cone states onto the waking ring *before* estimating dynamics. On the native manifold the dynamics are two regimes: confined diffusion, and **coherent sweeps** — directionally persistent, quadratic in squared displacement, at **8× waking speed**, coincident with transient ~12 Hz (spindle-band) local-field-potential power, hence with hippocampal sharp waves. Reproducing sweeps in the model additionally requires temporally correlated (200 ms) fluctuations injected through the **low-dimensional velocity input**, not through the global gain.

So: *a decoder fitted in one behavioural state can be structurally blind to the structure of another*, and the failure mode is reporting noise. This generalises past sleep — it is the same error as scoring a model's out-of-distribution states in the in-distribution basis.

---

## The two-dimensional case: a grid module, and a different route from topology to coordinates

> **Provenance.** Gardner, Hermansen, Pachitariu, Burak, Baas, Dunn, Moser & Moser 2022, *Toroidal topology of population activity in grid cells*, Nature 602:123–128, doi:10.1038/s41586-021-04268-7 (`raw/gardner-2022-toroidal-topology-of-grid-cell-population-activity.md`). Neuropixels recordings in medial entorhinal cortex / parasubiculum of freely moving rats: 3 rats, 4 sessions, 7,671 single units, **6 grid modules of 66–189 grid cells**; open-field foraging, an elevated wagon-wheel track with four radial spokes (no walls), REM and slow-wave sleep. Same topological school as the cohomology method cited above (Rybakken, Baas & Dunn).

SPUD fits an *object* of the measured topology and parameterizes it by arc length. That works for a ring and does not extend to a torus — there is no arc length on a 2-manifold. The 2-D route replaces steps 5–7 with **cohomological decoding**: the circular coordinates are read off the barcode's own cocycle representatives, so no object is fitted at all.

| Step | SPUD (1-D) | This route (2-D) |
|---|---|---|
| Point cloud | 100 ms–1 s bins, `√`-rates, all cells | 50 ms samples of Gaussian-smoothed rates (`σ` = 50 ms awake / 25 ms slow-wave); speed `> 2.5 cm s⁻¹`; **pure grid cells of one module only** |
| Pre-reduction | Isomap, optional | **6 principal components, always** — and the number is predicted, not chosen: a hexagonal-torus code has a 6-dimensional linear embedding (`cos`/`sin` of three axes), and the variance drop after PC6 is observed in every module, with the first six PCs individually grid-like in space |
| Outlier patch | `nt-TDA` density threshold | Keep the 15,000 most active vectors, then a fuzzy-neighbourhood ("UMAP first step") resampling to **1,200 points**, `k` = 1,500 → 800 |
| Topology | Persistent homology (Ripser) | Persistent **co**homology (Ripser, `ℤ₄₇` coefficients) — cohomology is what supplies cocycle representatives, hence decoding |
| Fit | Piecewise-linear closed curve, `K` = 12 knots | **Nothing is fitted.** Take the Vietoris–Rips complex at the scale where the two longest `H¹` bars live, lift each bar's cocycle from `ℤ₄₇` to `ℤ`, smooth by least squares over edges → two circular coordinates per vertex |
| Parameterize / decode | Arc length, project to nearest point | The product of the two circular maps *is* the toroidal coordinate; interpolate to the rest of the session by a firing-rate-weighted mass centre, **leave-one-cell-out** when the coordinate is used to score that cell |
| Null | Velocity-vector shuffle for flux | Spike trains rolled by a random lag, 1,000 times; the longest bar in any shuffle is the significance criterion |

**What the barcode has to show.** A torus is one `H0`, **two** `H1` and one `H2` bar of long lifetime. All six modules produced exactly that in the open field, all six again on the wagon-wheel track, `p < 0.001` against the roll null.

### Results, and the three that are new to the wiki

| Result | Number | Why it matters |
|---|---|---|
| **The torus is measured, and it is the *twisted* (hexagonal) one** | The two decoded circles intersect at **60°**; rhombus sides 0.67 m and 0.72 m; idealized square vs hexagonal tori give distinguishable stripe angles as controls | The geometry is read out, not asserted. A model claiming a grid code now has a two-number target (angle, side ratio) rather than "a torus" |
| **The internal coordinate beats the external covariate** | Toroidal position carries more bits per spike than physical position in **5/6** modules (open field) and 4/6 (track); cross-validated Poisson GLM deviance favours the toroidal covariate in 5/6 in both environments | The 2-D repeat of this page's central claim: the blind latent is the better description of the units. Here the label is *position*, the most trusted covariate in the field |
| **Grid distortions are in the chart, not in the code** | Track geometry demonstrably broke the spatial periodicity of single cells (autocorrelogram), and the toroidal barcode and per-cell toroidal fields were unchanged | **The state space is rigid and the world→state map is what deforms.** Every reported grid distortion — walls, corners, landmarks, reward — is therefore a statement about the anchoring map (`G39`), not about the integrator's manifold |
| **Invariance across environments** | Toroidal field centres move 31.5 ± 6.3° between environments (shuffle 135.8 ± 1.7°, maximum possible ≈ 254.6°); toroidal rate-map correlation `r` = 0.79 ± 0.07 (shuffle 0.01). Using *one* environment's parameterization for both: 16.0 ± 3.4°, `r` = 0.95 ± 0.02 | Criterion C3 of [[wiki/concepts/attractor-identification.md]], in its per-cell form |
| **Invariance into sleep** | Torus recovered in **5/6** modules in REM, **4/6** in slow-wave sleep; centres move 31.5 ± 15.4° (REM) and 29.8 ± 14.3° (slow-wave) from waking, `r` = 0.80 ± 0.15 and 0.83 ± 0.12; ~99% of cells beat the shuffle on toroidal information | The strongest form of input withdrawal, run on a 2-D manifold. This is the row the wiki previously held on a review's summary |
| **Cell cost, on real data** | ~**60** cells for `> 50%` detection probability (subsampling a 149-cell module) | Against the ~35 *simulated* grid cells quoted above. The real-data price is roughly double, and still trivial at model scale |

### The failure mode is a mixed population, and that is a measurement-validity result

The two modules that did *not* yield a torus in sleep are explained, and the explanation is not noise. Clustering cells by their **spike-train temporal autocorrelogram** (not by tuning) gives three classes, each present in several modules and each with a characteristic spike width: **bursty**, **non-bursty**, **theta-modulated**.

| Class | Share of conjunctive grid × direction cells | Toroidal information / explained deviance | Sleep |
|---|---|---|---|
| Bursty | — | **Highest**, in every module and every state | Carries the torus alone in module R1 during slow-wave sleep |
| Non-bursty | — | Intermediate | — |
| Theta-modulated | **80%** of all conjunctive cells (and only 11% of pure grid cells) | Lowest; pairwise correlations track head direction rather than toroidal position | Cohomology on this class alone returns a **circle** — the head-direction one |

Two consequences that generalise past grid cells.

- **Reading the wrong subpopulation returns the wrong manifold, not a noisy one.** The theta-modulated class is a genuine 1-D ring inside a population whose majority is on a 2-torus, and pooling them degraded the barcode. A topology estimate is therefore only as good as the partition of units it is run on, and nothing in the procedure proposes that partition — here it came from a cheap, tuning-blind statistic (temporal autocorrelogram shape) that any model layer also has.
- **The cheap statistic was enough.** Temporal spiking statistics, with no reference to what the cells encode, recovered a functionally meaningful split. The machine analogue is clustering units by their autocorrelation in time before running any geometry, and it is unrun anywhere in the wiki.

### The simulated positive control, which the 1-D case does not have

Both a lateral-inhibition-only continuous-attractor model (Couey et al. 2013) and a twisted-torus model (Guanella et al. 2007), simulated noiselessly and passed through the same pipeline, return the same four-bar barcode and the same 60° stripe pair; idealized square and hexagonal tori return the expected distinct decodings. So the instrument is calibrated on objects of known topology *and* on the generative models it is being used to adjudicate — which is what licenses reading a negative as a property of the data rather than of the estimator.

---

## Limits the source states

- Persistent homology is outlier-sensitive (patched above), computationally slow, and **cannot distinguish topologically trivial manifolds of different geometry** (a hyperplane from a filled ball). It is a first pass that detects or excludes non-trivial features; geometry needs a different tool afterwards.
- "No other coded variable" is always "down to this dataset's SNR". Sessions were 9–50 neurons with 8–30 HD-tuned; smaller structures than the noise cannot be excluded.
- The 1-D claim assumes recorded cells are representative samples of the population.
- Autonomy is localised only to "the brain", not to `ADn` — longer-range interactions are not excluded.
- Temporal resolution was ~100 ms; 5–10 ms decoding, which is what would probe fast dynamics and spike-pattern codes, needs larger simultaneous populations.

**The sample-size fact worth carrying:** ~**35** simulated grid cells suffice for persistent homology to reveal the 2-torus, and ~**60** recorded ones (Gardner et al. 2022, above). Topology is cheap in cells — far cheaper than the "thousands" [[wiki/concepts/attractor-identification.md]] quotes for direct manifold recovery.

---

## Relevance to a reasoning model

- **This is the wiki's only decoder that can be right when the label is wrong.** Every instrument on [[wiki/concepts/representation-probing.md]] and [[wiki/concepts/population-geometry.md]] is anchored to an experimenter-named variable; CCGP and the parallelism score need the condition grid enumerated in advance. SPUD needs nothing named, which is the only way to discover a variable the designer did not think of — the measurement form of [[wiki/concepts/latent-graph-discovery.md]]'s node-discovery problem.
- **(brainstorm) It is directly runnable on a trained network and has not been.** Take a recurrent model's hidden states over an episode, run steps 1–7, and ask: what topology, what dimension, does the recovered `α` beat the task variable at predicting unit activity, and does the answer survive zeroing the input? All four are free on a model — the state is fully observed and perturbation is a line of code — and the third is the one with teeth: *if a blind latent explains a network's units better than the variable it was trained on, the network is representing something else*, and no interpretability method in the wiki would notice.
- **Flux asymmetry is the cheapest causal-looking test that requires no intervention.** Off-manifold return flow measured against a velocity-shuffle null converts "is it an attractor" into a permutation test over trajectories the system generated on its own. On a model this needs no perturbation protocol at all.
- **The `1/N` argument bounds a whole class of robustness claims.** Dropout, unit noise and per-weight jitter are all high-dimensional perturbations, so their effect on a low-dimensional code falls as `1/N` — a model can be highly robust to them and arbitrarily fragile to a small correlated perturbation of its update channel. Robustness reported against independent noise is therefore close to uninformative for a manifold code.

---

## Open problems

- **Nothing constructs a manifold from a topology specification.** The instrument reads topology and does not write it — `G47` (nothing learns the topology it represents on) and `G82` (every manifold is measured, none is generated) are both untouched by a better estimator, and this source makes that explicit rather than closing it.
- **The 1-D result has no explanation.** With extra coding dimensions excluded, "why does the brain use thousands of cells for one circular variable" becomes a sharp unanswered question — and the `1/N` result is a partial answer (large `N` is what makes high-dimensional noise impotent) that the source does not itself make.
- **The amplitude attractor is inferred, not found.** A discrete attractor in the total drive that pins manifold radius across waking and REM is required by the model fit; the circuit supplying it is unidentified.
- **Sweeps have no demonstrated consumer.** Coincidence with spindle-band power and hence hippocampal sharp waves is a timing correlation; nothing shows the heading sweep is used by anything, so "replay in the head-direction system" is an inference from shape and timing only.
- **No graded score.** Like C3, the topology verdict is pass/fail on a chosen barcode threshold; nothing reports *how much* ring there is, which a model comparison would need.
- **The one experiment that would separate a deformed chart from a deformed manifold has not been run.** The toroidal manifold survived an elevated track whose geometry broke single-cell periodicity — but that track had **no walls**, and the wiki's other result on environment geometry is that *walls* re-zero the integrator and replace the two-dimensional code with a repeating one-dimensional submap, while a wall-free "virtual hairpin" leaves it intact (Derdikman et al. 2009, [[wiki/concepts/path-integration.md]]). The two findings are therefore consistent and untested against each other. Run persistent cohomology on a grid module in a **walled** multicompartment maze: if the torus survives, compartmentalisation is entirely a property of the space→torus chart; if the barcode loses a `H¹` bar, the manifold itself is being cut, and "the code is rigid" is false exactly where the wiki most needs it (`G47`, `T347`).
- **Nothing proposes the partition of units the estimate is run on.** Three temporally-defined cell classes share the grid modules and one of them lies on a *different* manifold (a head-direction ring); the pooled estimate is degraded, not merely noisier. Which subset of a population to run topology on is a free parameter of every result on this page, chosen here by a tuning-blind clustering that nobody has justified as the right one.

---

## Connections

- **[[wiki/concepts/attractor-identification.md]]** — this page is how that page's criteria C1 and C4 are actually measured, and it supplies the flux instrument that turns C2 into a permutation test on spontaneous activity; that page's head-direction scoreboard row is this source's result.
- **[[wiki/concepts/population-geometry.md]]** — answers that page's standing open problem that every instrument there returns a *number* and none returns a topology, and inverts one of its assumptions: global embedding is not merely lossy for a ring, it is structurally unable to recover the latent.
- **[[wiki/concepts/projection-distortion.md]]** — the quantitative version of the same warning for trivial topology (neighbour corruption, distance inflation); this page adds the case where the failure is categorical rather than graded, and the fix is to never build a global embedding.
- **[[wiki/entities/anterior-thalamic-nuclei.md]]** — the circuit measured: the anterodorsal nucleus, whose head-direction population is the wiki's best-identified continuous attractor, and whose manifold changes shape between sleep stages.
- **[[wiki/concepts/path-integration.md]]** — supplies the isometry that page's composition argument assumes, and the result that the velocity channel is also the dominant noise channel, so integration fidelity is a property of the drive rather than of the units (`G124`).
- **[[wiki/concepts/offline-replay.md]]** — the sleep half: coherent sweeps at 8× waking speed on the non-REM manifold, invisible to a wake-trained decoder, coincident with spindle-band power and therefore with hippocampal sharp waves.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the measurement counterpart of the framing's first step: recover the latent variable's identity and topology from observations alone, with no label and no assumed coordinate system.
- **[[wiki/concepts/stationary-surrogate-null.md]]** — the same discipline applied to a different estimator class: here the nulls are a velocity-shuffle for flux and a tuning-curve-plus-independent-spiking surrogate for "is there anything besides the ring".
- **[[wiki/concepts/representation-probing.md]]** — the contrast that defines this page: a probe asks whether a *named* variable is linearly present, this asks what variable is there at all, so it can return a variable that predicts the units better than the task label does.
- **[[wiki/entities/entorhinal-cortex.md]]** — the system where the same instrument yields a 2-torus, measured directly in six grid modules across waking, an elevated track and both sleep stages (Gardner et al. 2022), and where the population turns out to be three temporally-defined cell classes of which only the bursty one carries the manifold robustly.
- **[[wiki/concepts/structured-flows-on-manifolds.md]]** — supplies the flow half of that formalism's central object as a measurement rather than a model: the flux decomposition is the empirical form of "the flow on the manifold does the computation".
- **[[wiki/concepts/manifold-constrained-learning.md]]** — the same manifold read as a constraint rather than a description; this page's off-manifold flux is the mechanism that page's unlearnable outside-manifold perturbations run into.
