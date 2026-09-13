# Timescale Estimator Bias — Why Every Fitted `τ` Is Too Short, and What Replaces the Fit

**Fitting an exponential to a *sample* autocorrelation does not estimate the timescale of the process that produced it. The sample autocorrelation of a finite time-series is negatively biased — it can be systematically *negative* at intermediate lags for a process whose true autocorrelation is strictly positive — and the bias grows with the true `τ`, with the number of timescales present, and with the shortness of the trial. The bias comes mainly from the sample mean, not from noise in the tail, and it cannot be subtracted because its size depends on the unknown answer. The fix is to stop fitting the analytical curve and instead fit a *generative model*: simulate synthetic data with the same duration, trial count, mean and variance, so that the synthetic summary statistic carries the same bias, and accept parameters whose synthetic autocorrelation (or power spectral density) is close to the observed one. Approximate Bayesian computation does this without a likelihood and returns a posterior over `τ` rather than a point estimate — which also gives a Bayes factor, so "how many timescales" becomes a decidable question instead of a modelling assumption.**

> **Provenance.** Zeraati, Engel & Levina 2022, *A flexible Bayesian framework for unbiased estimation of timescales*, Nature Computational Science 2:193–204, doi:10.1038/s43588-022-00214-3 (`raw/zeraati-2022-bayesian-unbiased-timescale-estimation.md`). Method paper: synthetic data with analytically known ground truth, a branching-network simulation, and one macaque V4 recording session (81 trials). Released as the `abcTau` Python package.

---

## The bias

Sample autocorrelation at lag `t_j`, from a series of length `N`:

```
AC_hat(t_j) = (1 / (σ_hat² (N−j))) Σ_{i=1}^{N−j} (A(t'_i) − μ_hat₁(j)) (A(t'_{i+j}) − μ_hat₂(j))
μ_hat₁(j) = mean over i = 1…N−j        μ_hat₂(j) = mean over i = j+1…N
```

| Property | Statement |
|---|---|
| **Sign** | Negative at all lags, for every estimator of `μ_hat`, `σ_hat` tried, and also via the inverse Fourier transform of the power spectral density (PSD) (Wiener–Khinchin) — so it is not a normalisation choice |
| **Visible signature** | On a log-linear plot the ground truth is a straight line; the sample curve bends away from it and, for processes with strictly positive true autocorrelation, **crosses zero at intermediate lags** (and therefore disappears off the log axis) |
| **What it scales with** | Larger for longer `τ`, larger when multiple timescales are present, smaller for longer trials — but still substantial at trial durations typical of neuroscience (`1 s` trials, `τ` of tens to hundreds of ms) |
| **Dominant cause** | Deviation of the **sample mean** from the true mean. Using the known true mean largely eliminates it; prior work had attributed the error to fitting noise in the autocorrelation tail, which this paper contradicts |
| **Why it cannot be corrected** | The bias depends on the true autocorrelation, which is the unknown. Analytic expressions exist for a single-timescale Markov process; they are intractable for mixtures or for added temporal structure |
| **Frequency domain is not an escape** | The bias survives into the sample PSD. A Lorentzian fit's answer then depends on the **fitted frequency range**, and without the ground truth there is no principled way to choose the range; small changes in range produce large errors, worst in the presence of spiking noise |
| **The comparison killer** | Because the bias depends on trial duration, **timescales fitted from datasets with different trial lengths are not comparable** — a difference in `τ` can be a difference in recording protocol |

**The pooling trap.** If the true mean is unknown but assumed constant across trials, estimating one sample mean over the whole dataset reduces the bias. If that assumption fails — mean rate drifting with behavioural state — pooling instead distorts the autocorrelation shape and **introduces spurious slow timescales**. Trial-wise means are biased; a pooled mean is biased differently and can manufacture the very slow component one is looking for.

---

## The replacement: fit a generative model, not a curve

Generative model — a linear mixture of Ornstein–Uhlenbeck (OU) processes, one per timescale, optionally plus oscillations, plus a noise model:

```
Ȧ(t') = −A(t')/τ + sqrt(2D) ξ(t')          Var[A] = Dτ        AC(t) = exp(−t/τ)
PSD(f) = c / (f² + f_knee²),  c = f_knee²/π,  τ = (2π f_knee)⁻¹
A(t') = Σ_{k=1}^{n} sqrt(c_k) A_k(t'),  Σ c_k = 1,  c_k ∈ [0,1],  τ₁ < τ₂ < … < τ_n
A_k(t'_{i+1}) = (1 − Δt'/τ_k) A_k(t'_i) + sqrt(2 D_k Δt') η_k(t'_i),   D_k = 1/τ_k
A_trans(t') = σ_hat · A(t') + μ_hat            (match observed mean and variance)
```

Parameter vector for `n` timescales: `2n − 1` numbers (`n` timescales, `n−1` mixing weights). **The mixing weights are what makes the mixture a statement about allocation rather than about span** — `c_k` is the share of total variance at horizon `τ_k`, at fixed total variance.

Optimisation is by **adaptive approximate Bayesian computation (aABC)** — likelihood-free, because simulating the generative model is cheap while its likelihood is not:

| aABC step | Setting in the paper |
|---|---|
| Prior | Multivariate **uniform**; timescale range chosen broad around the direct-fit estimate (which can serve as a lower bound). Broader priors do not change the posterior shape, only the runtime |
| Simulate | Synthetic data with the **same duration, same number of trials, same mean, same variance** as the observed data — this is the whole mechanism: both summary statistics then carry the same finite-sample bias |
| Distance | Mean squared difference of autocorrelation over lags `[0, t_m]`, or of PSD over `[f_n, f_{n+m}]`, linear or log scale |
| Accept | `d < ε`; initial `ε = 1`; 500 accepted samples per iteration |
| Adapt | `ε` for the next iteration = **first quartile** of the accepted distances; proposal = Gaussian mixture over accepted samples, weighted by `ω_r ∝ π(θ_r)/π_hat(θ_r)`, random-walk kernel covariance `Σ = 2·Cov[θ]` (population Monte Carlo) |
| Stop | Acceptance rate `accR ≤ 0.003`. Smaller threshold → smaller final `ε`, better posterior, longer runtime |
| Point estimate | MAP of the joint posterior, smoothed with a Gaussian kernel and grid-searched |

**What the posterior buys beyond unbiasedness:** its width is the estimation uncertainty (controlled in simulation by the number of trials, i.e. the signal-to-noise ratio of the summary statistic); its *joint* structure exposes parameter correlations, solution manifolds and degeneracy; and it is invariant to choices that wreck the direct fit — changing the summary statistic or the fitted range moves the posterior's width but not its peak, because the same choice is applied to observed and synthetic data alike.

**Robustness to the wrong generative family.** Fitting a one-timescale OU model to the global activity of a **branching network** (binary units, activation probability `p = m/K`, analytical `AC(t_j) = exp(t_j ln m)`, so `τ = −1/ln m`) returns a posterior centred on the theoretical `τ` — the OU mixture is a usable estimator even when the data-generating mechanism is not an OU process, as long as the decay is exponential.

---

## Model selection: "how many timescales" becomes a test

Assuming equal priors over models `M₁`, `M₂`, the Bayes factor is approximated by the ratio of acceptance rates at each error threshold, which is the ratio of the distance CDFs:

```
B₂₁(ε) = accR_{M₂}(ε) / accR_{M₁}(ε) = CDF_{M₂}(ε) / CDF_{M₁}(ε)          B₂₁ > 1 → prefer M₂
```

Pre-condition (checked, not assumed): the two models' distance distributions must differ significantly — two-sided Wilcoxon rank-sum, with common-language effect size `CL = U/(n₁n₂)` — otherwise the summary statistic is insufficient for the comparison and ABC model selection is known to be inconsistent.

| Ground truth | Result | Reading |
|---|---|---|
| One-timescale OU | `B₂₁ < 1` for all `ε`; `P = 0.002`; mean `d_{M₁} = 6×10⁻⁵` vs `d_{M₂} = 8×10⁻⁵` | Correct. **The extra timescale is penalised by posterior *width*, not by a parameter count** — the two-timescale posterior is broader, so it samples bad parameter combinations more often |
| Two well-separated timescales (inhomogeneous Poisson) | `B₂₁ > 1`; `P < 10⁻¹⁰`; `6×10⁻⁴` vs `1.5×10⁻⁵` | Correct |
| Two *similar* timescales, autocorrelation shape gives no hint | `B₂₁ > 1`; `P < 10⁻¹⁰`; `10⁻⁶` vs `7×10⁻⁷` | Correct in the case where eyeballing fails; the one-timescale fit lands **between** the two true values |

---

## On real cortex

Macaque V4, 16-channel array across all layers, fixation on a blank screen for `3 s`, 81 trials, population spike counts in `1 ms` bins, PSTH subtracted to remove trial-locked trends, autocorrelations averaged across trials, fitted to `t_m = 150 ms`. Generative model: doubly stochastic — rate is one OU process (`M₁`) or a mixture of two (`M₂`), spike counts drawn from a **gamma** distribution to respect non-Poisson spiking.

| Comparison | Result |
|---|---|
| One vs two timescales | `CDF_{M₂} > CDF_{M₁}` for all `ε` → **two timescales**, against the single-exponential description the cortical timescale literature standardly assumes |
| Direct double-exponential fit `AC(t) = c₁e^{−t/τ₁} + (1−c₁)e^{−t/τ₂}` vs aABC MAP | Direct fit gives **systematically smaller** timescales, as in the synthetic cases |
| Which parameters actually describe the data (parametric-bootstrap sampling, Wilcoxon) | MAP wins: `P < 10⁻¹⁰`; mean distance `10⁻⁴` (MAP) vs `3×10⁻⁴` (direct fit) — **3× worse** |
| Lag range matters even for the direct fit | Including all lags rather than stopping at `t_m` makes the direct fit's bias larger |

---

## Relevance to a reasoning model

- **Every `τ` in this wiki is a direct-fit point estimate, and all of them are low.** [[wiki/concepts/intrinsic-timescale-measurement.md]]'s `50–350 ms` across seven macaque areas is exactly the construction audited here: a direct exponential fit to an across-trial sample autocorrelation, over foreperiods of `≥ 500 ms`. The bias grows with `τ`, so the slow areas are compressed more than the fast ones and the reported **7× spread is a lower bound on the true spread** — an under-estimate whose size is unknown and area-dependent. That cuts against the `G67` update that used the narrow spread to argue a bank need not span decades. **(brainstorm)** It does not threaten the *ordering*, which is monotone in `τ` as long as the bias is monotone in `τ` — the rank correlation is the robust part of that result and the magnitudes are the fragile part.
- **Cross-dataset comparison of timescales is unlicensed unless trial durations match.** Murray et al. pool six laboratories with different foreperiod designs; the bias depends on trial duration. The `r_s = 0.89` cross-dataset consistency is therefore stronger evidence than it looks (it survives a nuisance variable that should have scrambled it), while any *numerical* comparison of one lab's `τ` to another's is not supported.
- **`B` and `τ` may be the same artefact seen twice. (brainstorm)** The offset `B` in Murray's fit absorbs everything slower than the window; the bias audited here also grows with the true `τ`, and the pooled-mean trap *manufactures* slow components. The reported positive `τ`–`B` correlation — the wiki's one-fit discriminator between gradient-generated and hand-provisioned timescale banks — is defended in the source only against the *fitting procedure's* parameter covariance (negative in 11 of 16 fits), not against finite-sample bias, which is a different mechanism. Re-running both fits inside a generative loop would cost one posterior per area and either confirms the discriminator or removes it.
- **A model's modules can be measured this way at far lower cost than cortex.** The whole expense of aABC is simulating synthetic data matched to the observed data; for a trained network the generator *is* the network, trials are free, and the duration constraint is whatever the architecture's context is. So the diagnostic [[wiki/concepts/intrinsic-timescale-measurement.md]] transfers with its bias correction attached: `N` forward passes at fixed input with different noise seeds, bin each module's trace, fit a mixture of OU processes by aABC, report a posterior per module. **(brainstorm)** The cheap thing to do first is the *pre-processing* check the paper ships — parametric bootstrap from the direct-fit parameters, compare the bootstrap mean to the direct-fit estimate — which prices the bias for a given trace length before committing to the full posterior.
- **"How many timescales" is the `G67` question, and it now has an estimator.** `G67` asks how many bands a model needs and where the edges go, and every answer in the wiki is authored. `B₂₁(ε)` decides `n` from data, on the model's own activity, label-free, and the mixing weights `c_k` report how variance is allocated across the chosen horizons at fixed total variance — which is the quantity [[wiki/entities/ms-ssm.md]]'s stratification result makes load-bearing. It does not close `G67`, because nothing *learns* the allocation: the test ranks hypotheses a designer supplies.
- **A posterior is the right currency for a design decision. (brainstorm)** A point estimate of a module's horizon cannot say whether two modules differ; a posterior can, and two posteriors that overlap heavily are the signature that one timescale would do — which is the paper's own evidence for `n = 1` in the single-OU case. Any claim in the wiki that a model has separated timescales is currently made with point estimates and is therefore untestable at the level it is asserted.
- **The OU mixture is a reusable null for slow structure.** Exponential decay plus a mixing weight is the minimal hypothesis for "this signal has memory". A claim that a module's dynamics are *more* than a sum of leaky integrators — oscillatory content, non-exponential decay, `1/f` with exponent ≠ 2 — is testable by the same Bayes-factor machinery against an OU-mixture alternative, which the wiki's metastability and repertoire claims do not currently do ([[wiki/concepts/metastability.md]], [[wiki/concepts/dynamic-repertoire.md]]).

---

## Open problems

| Problem | Why it is open |
|---|---|
| **Exponential decay is assumed** | The framework defines timescale as an exponential decay rate, i.e. a Lorentzian PSD with `1/f` exponent exactly 2. For the many signals whose exponent differs there is **no accepted definition of timescale at all**. The paper's partial answer: an augmented generative model that carries a background process of arbitrary PSD shape, agnostic to its mechanism — which separates a well-defined `τ` from the background but does not define the background's own timescales |
| **Cost** | Estimating a full posterior is far more expensive than a point fit (the paper ships a bootstrap pre-check precisely so the cheap route can be used when it is safe). No wiki measurement has paid either price |
| **Model selection can be inconclusive** | With little data the Bayes factor fails to separate hypotheses, and the remedy named is "collect more data" — which for a biological recording is not available retroactively |
| **Finding the generative model is the new hard part** | For processes with complex temporal dynamics, no candidate model may capture the data; the method then selects the best of a bad set. The burden moves from estimator choice to model-family choice, where it is less visible |
| **Sufficiency of the summary statistic is only checked pairwise** | The Wilcoxon pre-test certifies that *these two* models' autocorrelation expectations differ, not that the autocorrelation is sufficient in general |
| **Nothing in the wiki has been re-estimated** | The audit applies to every `τ` the wiki cites; none has been re-run. `G114` |

---

## Connections

- **[[wiki/concepts/intrinsic-timescale-measurement.md]]** — the measurement this page audits: that estimator is a direct exponential fit (plus offset) to an across-trial sample autocorrelation over `≥ 500 ms` foreperiods, which is exactly the construction shown here to return systematically short timescales with a bias that grows with `τ` and with trial shortness, so its ordering is robust and its `50–350 ms` spread is a lower bound (`G114`).
- **[[wiki/concepts/stationary-surrogate-null.md]]** — the same cure for the same disease on a different statistic: both pages replace an analytic expectation with a **generative process matched to the real data's length and spectrum** and score the estimator against it — there to absorb the sampling variability of a covariance, here to absorb the finite-sample bias of an autocorrelation — and both conclude that an autocorrelated signal's naive estimator reports a property of the window rather than of the system.
- **[[wiki/concepts/timescale-hierarchy.md]]** — the mechanism whose only external validation runs through the audited estimator: one scalar gradient on the macaque connectome generates a spectrum whose *ordering* matches the measured areal `τ`, which survives this audit, while the match of absolute values to `50–350 ms` does not, since the model's eigenvalues are exact and the data's are biased short.
- **[[wiki/concepts/parallel-timescale-streams.md]]** — the competing claim about how many timescales an area has, now with a test: that page finds six concurrent streams by fitting an authored state alphabet, this page decides the number of timescales from a Bayes factor on the signal's own autocorrelation, and on V4 it chooses **two** over one — the first evidence in the wiki that "one `τ` per area" loses a model comparison.
- **[[wiki/concepts/mean-field-reduction.md]]** — the other route to a spectrum: there the time constants are eigenvalues of an operator *derived* from a hand-specified neuron model, here they are parameters *inferred* from data through a deliberately generic OU mixture — the same object estimated top-down and bottom-up, and nothing has compared the two on one system.
- **[[wiki/concepts/metastability.md]]** — an unpaid null: any statistic claiming that dwell times or coupling variance indicate an operating point is computed on strongly autocorrelated signals over finite windows, and an OU mixture fitted by this machinery is the minimal generative alternative it has never been scored against.
- **[[wiki/concepts/representation-probing.md]]** — the complementary instrument and the same validity lesson: a decoder needs labels and reports *what* is carried, this estimator needs neither and reports *how long* — and both are only as good as the null that prices their finite-sample behaviour.
- **[[wiki/entities/ms-ssm.md]]** — the architecture whose design object this estimator measures: MS-SSM's gain comes from *allocating* a fixed state budget across bands, and the OU mixture's weights `c_k` are exactly that allocation read off data — so a band structure can now be proposed and scored rather than only authored (`G67`).
- **[[wiki/concepts/projection-distortion.md]]** — the sibling `L0-INSTR` audit with the same repair shape: there the fix for a biased summary statistic is a generative model that carries the same bias, here the fix for an uninformative fidelity statistic is a control embedding that carries the same fitting procedure — in both cases the instrument is rescued by constructing an object that shares its defect.
