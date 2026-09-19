# Stationary Surrogate Null — The Baseline Any Claim of "Dynamics" Has to Beat

**Before a fluctuating statistic may be called a state change, it has to be scored against synthetic data that is *stationary by construction* and matched to the real data in covariance, power spectrum and length. When that null is built for resting-state fMRI, it reproduces the published dynamic-connectivity phenomenology almost exactly — sliding-window "states" at `r = 0.96`, the same cluster-validity curve, the same two-dimensional scatter with no separable clusters — so the appearance of a state sequence is a property of the estimator, not of the brain. What is left of real resting non-stationarity, after the null and after head-motion censoring, is small and is mostly fluctuating drowsiness.**

> **Provenance.** Laumann, Snyder, Mitra, Gordon, Gratton, Adeyemo, Gilmore, Nelson, Berg, Greene, McCarthy, Tagliazucchi, Laufs, Schlaggar, Dosenbach & Petersen 2017, *On the stability of BOLD fMRI correlations*, Cerebral Cortex 27(10):4719–4732, doi:10.1093/cercor/bhw265 (`raw/laumann-2017-stability-bold-fmri-correlations.md`). 10 subjects × 10 sessions × 30 contiguous minutes of resting BOLD (300 min/subject), 333-parcel cortical atlas, plus three re-used data sets for the sleep and task comparisons.

---

## Constructing the null

| Step | Operation |
|---|---|
| 1 | Sample random normal deviates of the same dimensionality and length as the real run |
| 2 | Multiply in the spectral domain by the **mean parcel power spectrum** of the real (already band-passed, `0.009 < f < 0.08` Hz) data |
| 3 | Project onto the **eigenvectors of the real covariance matrix**, estimated over the full 30-min run |

Result: a surrogate with the real data's network structure, the real data's `1/f`-like spectral content and the real data's length, and **no non-stationarity anywhere** — the generating covariance is a single fixed matrix. Matlab code released by the authors.

**Two design points that make it the right null rather than a convenient one.** The spectrum must be matched because BOLD's long-range temporal autocorrelation is what makes the effective sample size far smaller than the frame count ([[wiki/concepts/function-to-structure-inference.md]]); a white-noise surrogate would under-state sampling variability by a large factor. The length must be matched because the statistic below is itself length-dependent — the authors always regenerate the surrogate at the real run's length rather than quoting an asymptotic value.

---

## The statistic: multivariate kurtosis of Mardia

For zero-mean frames `Y_j ∈ ℝ^d`, `1 ≤ j ≤ n`:

```
C    = (1/n) Σ_j Y_j Y_jᵀ                    (sample covariance)
D_jk = Y_jᵀ C⁻¹ Y_k                          (squared Mahalanobis distance between frames)
b_nd = (1/n) Σ_i [D_ii]²                     (multivariate kurtosis)
```

| Property | Value |
|---|---|
| Expectation under stationary multivariate normality, `n → ∞` | `d(d + 2)` — for `d = 30`, **960** |
| Realised under the matched stationary surrogate at real run length | **~945–952** (finite `n` and filtered spectra bias it *down*) |
| Why order 4 | The sampling variability of a statistic of order `m` scales with the moment of order `2m`; functional connectivity is a covariance, order 2, so its variability is read off the fourth moment |
| What it costs | No window size, no window function, no overlapping-window dependence — the arbitrary choices of the sliding-window method disappear |
| What it covers | All pairs of regions at once, versus the pairwise formulation of the alternatives |
| What it does **not** cover | Non-stationary *spectral* content at constant covariance is invisible to it; and elevated kurtosis cannot distinguish non-constant covariance from stationary non-normality |

Practical constraint: the `333 × 333` covariance is rank-deficient (BOLD's dimensionality is well below its parcel count), so `C⁻¹` is unstable — reduce to `d = 30` principal components first. That reduction is a node-definition decision of the kind [[wiki/concepts/node-definition-problem.md]] catalogues, taken here for numerical rather than theoretical reasons.

---

## What the null absorbs, and what survives it

| Source of apparent "dynamics" | Evidence | Verdict |
|---|---|---|
| **Sampling variability** | `k`-means (`k = 7`) on sliding-window (100 s) correlation matrices gives "states" in the *stationary surrogate* matching the real states at `r = 0.96 ± 0.01`; identical cluster-validity-index curves over `k = 2–10`; neither real nor simulated two-dimensional projections show separable clusters | **Artefact.** The dominant term |
| **Head motion** | Uncensored kurtosis vs mean framewise displacement: `r = 0.50`, `p = 10⁻⁷`, far above the surrogate line. Censoring frames at `FD > 0.2 mm` effectively eliminates the relation; kurtosis rises monotonically with the censoring threshold. Random frame removal has a much smaller effect — it is the high-motion frames specifically | **Artefact.** Second largest |
| **Fluctuating drowsiness** | Kurtosis vs a covariance-derived sleep index (built from an EEG-staged data set, visual cortex excluded): `r = 0.315`, `p = 0.0044`, after censoring. Quantitatively dwarfed by motion. Subjects drift toward sleep over a 30-min run; ~⅓ of public resting data sets contain sleep within minutes | **Real, neural, and the largest genuine term** |
| **Residual excess** | A small unexplained excess over the surrogate remains after both corrections — incomplete motion removal, underestimated sleep, fluctuating arousal, or unconstrained cognition | **Open, and small** |

**The positive controls matter as much as the null.** The statistic is not blind:

| Imposed state change | Result |
|---|---|
| Simulated eyes-open covariance switching to eyes-closed halfway through a run | Two-state simulation gives systematically higher kurtosis than one-state — the statistic detects a covariance change of a *subtle*, well-documented kind |
| Real task/rest block alternation (`N = 24`, 470 s runs, evoked responses regressed out first) | Kurtosis significantly above matched continuous rest for all three paradigms — coherence discrimination `t(23) = 3.05`, semantic judgement `t(23) = 3.51`, mental rotation `t(23) = 5.19`; mental rotation largest, and it also induces the largest correlation-structure change |

So imposed cognitive state changes *are* detectable in correlation structure, and continuous rest sits closer to the stationary null than any task-alternation condition. The claim is narrow and therefore strong: **rest does not contain state changes of the magnitude an ordinary block design imposes.**

---

## What stationarity does not forbid

The paper is careful about its own scope, and the wiki should carry the carve-outs with the result:

- **Single-frame co-activation patterns.** A multivariate normal process spends ~5% of samples beyond ±2 SD; "snapshots" in which one network's topography transiently dominates are expected under the null, not evidence against it.
- **Behavioural influence of instantaneous state.** Ongoing fluctuations may bias perception and motor output while the second-order statistics stay constant — the authors' frictionless-pendulum analogy: stationary motion can still trip a switch at the end of each swing.
- **Propagation.** Lag-based spatiotemporal sequences on a ±1 s timescale are fully consistent with stationarity provided the propagation pattern is stable within state — and that pattern *is* sensitive to eye state, task history, time of day and slow-wave sleep, and separates autism from controls where conventional functional connectivity shows no difference. **Time-dependence survives; non-stationarity of covariance does not** ([[wiki/concepts/cortical-traveling-waves.md]]).
- **Spectral non-stationarity** is outside the statistic entirely.

---

## Relevance to a reasoning model

- **A general discipline, not an fMRI result.** The construction generalises to any claim that a trained network "switches states": generate surrogate activations matched in covariance, per-unit spectrum and length, run the *same* clustering or change-point estimator on them, and report the difference. Every state-discovery result in the wiki that uses sliding windows or `k`-means on windowed correlations is currently unscored against this null.
- **Clustering manufactures clusters.** `k`-means returns `k` centroids whether or not the data is clustered; the cluster-validity index used in the source literature did not discriminate real from stationary data at any `k` from 2 to 10. A state inventory is only evidence for states if the null fails to produce it.
- **Sampling variability has a formula, and short windows are hopeless.** Variability of an order-2 statistic scales with the order-4 moment; with strong temporal autocorrelation the effective `n` collapses. A correlation-based graph estimated over 100 s of a `0.01–0.08` Hz signal carries a few independent samples, not a few hundred — which is why [[wiki/concepts/latent-graph-discovery.md]]'s window parameter cannot be shortened toward "instantaneous graph" by any amount of engineering.
- **The residual is where the design pressure is. (brainstorm)** If rest is a single covariance and imposed tasks move it, then the interesting architectural quantity is not a repertoire being sampled at rest but the *size of the smallest input-driven perturbation* that shifts the correlation structure detectably — the `t`-values above rank three tasks by exactly that. A reasoning architecture whose module-coupling statistics do not move under task is not thereby broken; the brain's barely move either.
- **The stability itself needs an explanation.** The authors' proposal: resting correlations reflect the maintenance of long-term functional architecture — ongoing activity as the substrate of homeostatic and Hebbian upkeep — rather than moment-to-moment cognitive content ([[wiki/concepts/synaptic-plasticity.md]]). Under that reading, a resting connectome is a *slow* variable by function, and fitting an architecture to it is fitting to the maintenance process, not to the computation.

---

## Open problems

- **Kurtosis ≠ stationarity.** It tests multivariate normality with constant covariance. Higher-order and spectral non-stationarity tests exist (Last & Shumway 2008; Jentsch & Subba Rao 2015) and are not run; the paper chose kurtosis for multivariate tractability.
- **The two readings of elevated kurtosis are not separated anywhere.** Non-constant covariance in a normal process versus constant-covariance non-normality remain confounded; the authors argue the first is more likely for task and sleep effects but do not demonstrate it.
- **The sleep term is a floor, not an estimate.** The sleep index omits visual cortex (eye-state confound) and aggressive motion censoring probably discarded drowsy epochs, so the drowsiness contribution is systematically under-counted — meaning the genuinely neural share of resting variability could be larger than reported, while the artefactual share cannot be smaller.
- **No individual-level verdict.** Everything is a population relation between kurtosis and a nuisance variable; the paper never certifies a *particular* session as stationary, which is what a per-subject modelling pipeline would need.
- **Applies only to what BOLD measures.** The result bounds infra-slow haemodynamic covariance. It says nothing about non-stationarity at electrophysiological timescales, where the alphabet of co-activation states turns over in tens of milliseconds ([[wiki/concepts/parallel-timescale-streams.md]]).

---

## Connections

- **[[wiki/concepts/dynamic-repertoire.md]]** — the page this null is aimed at: that page's resting wandering, read through BOLD, is largely reproduced by data that is stationary by construction, so the repertoire claim has to be carried by the models' own delay/noise mechanisms rather than by the fMRI phenomenology it was motivated with ([[wiki/empirical-tensions.md]] T240).
- **[[wiki/concepts/function-to-structure-inference.md]]** — the same quantity from the other side: there a fixed-coupling 998-node simulation fails to reproduce its own functional connectivity across an 8-min window, which is this page's sampling-variability term measured in a system whose ground truth is known; together they say low functional-connectivity reliability is an estimator property and not evidence of a moving target.
- **[[wiki/entities/fcann.md]]** — the wiki architecture most exposed: its coupling matrix is a long-window resting estimate, which this page *supports* (one correlation structure is the right description of rest) while raising the bar on its dynamics claims, since its covariance-matched Gaussian null (NM3) does not match the data's power spectrum and therefore under-states sampling variability relative to the surrogate used here.
- **[[wiki/concepts/metastability.md]]** — the caution this page imposes on `σ_R` and on "fluidity": any variance-of-connectivity statistic computed over sliding windows of a slow, strongly autocorrelated signal inherits a large stationary baseline, so an operating-point claim needs the surrogate's `σ_R` reported beside the data's.
- **[[wiki/concepts/cortical-traveling-waves.md]]** — the time-dependent measurement that survives the null intact: propagation structure is consistent with stationarity, is reproducible across large groups, and distinguishes autism from controls where conventional functional connectivity does not — so lag, not windowed correlation, is where resting BOLD's temporal information actually is.
- **[[wiki/concepts/parallel-timescale-streams.md]]** — the null it did and did not run: its *spatial* alphabet is tested against phase-randomised surrogates (spectra preserved), which is this page's construction, while its transition matrices and lifetime distributions are tested only against occupancy- and lifetime-preserving shuffles, which do not absorb sampling variability the way a covariance-and-spectrum-matched stationary surrogate does.
- **[[wiki/concepts/node-definition-problem.md]]** — the dimensionality reduction this statistic forces: `C⁻¹` is unstable at 333 parcels because BOLD's true dimensionality is far lower, so the measurement is made on 30 principal components, a vertex set chosen by numerical necessity rather than by anatomy.
- **[[wiki/concepts/timescale-estimator-bias.md]]** — the same construction applied to the other statistic: there a generative model matched to the real data's duration, trial count, mean and variance is fitted so that synthetic and observed summary statistics carry the *same* finite-sample bias, which is this page's surrogate logic turned from a null into an estimator — a matched generative process can either absorb an artefact or supply an unbiased parameter, and the two pages are the same discipline in its two uses.
- **[[wiki/concepts/intrinsic-timescale-measurement.md]]** — the other measurement-validity page, and the same failure mode from the opposite direction: both show that an autocorrelated signal's naive estimator is biased by finite sample size, there for `τ` and here for a covariance, and both fix it by comparing against a generative process whose answer is known.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a hard floor on the discovery side: the window cannot be shortened toward an instantaneous graph, because the effective sample size of a correlation estimate on a band-limited autocorrelated signal collapses long before the window does.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the authors' explanation for the stability they measure: ongoing activity primarily serves Hebbian/homeostatic maintenance of the existing architecture rather than carrying momentary content, which makes a resting correlation matrix a read-out of the slow variable rather than of the computation.
- **[[wiki/concepts/projection-distortion.md]]** — the same move applied to shape rather than to dynamics: a null generated under an assumption-free construction (an embedding fitted to an arbitrary target shape) reproduces the fidelity statistics that a published embedding's structure is defended by, exactly as stationary simulated data reproduces the sliding-window state inventory here.
- **[[wiki/concepts/attractor-identification.md]]** — the same demand aimed at the generator rather than at the estimator: this page guards against structure manufactured by a windowed statistic, that page against a manifold imposed by the input or by a low-rank feedforward projection, and both make the claim turn on a control condition rather than on the strength of the observed structure.
