# Intrinsic Timescale Measurement — Reading a Module's Memory Horizon Off Its Own Noise

**A unit's integration horizon can be measured without a task, without a stimulus, and without gradients: take many independent trials of the *same* quiescent epoch, correlate the activity in time bin `i` with the activity in bin `j` **across trials**, and fit the decay against lag. The time constant of that decay orders seven macaque cortical areas exactly as anatomical hierarchy does (`r_s = 0.97`), and the *offset* of the same fit — one extra parameter, free — reports how much variance lives at horizons longer than the probe window. Both are population statistics; neither is visible in a single neuron.**

> **Provenance.** Murray, Bernacchia, Freedman, Romo, Wallis, Cai, Padoa-Schioppa, Pasternak, Seo, Lee & Wang 2014, *A hierarchy of intrinsic timescales across primate cortex*, Nature Neuroscience 17:1661–1663, doi:10.1038/nn.3862 (`raw/murray-2014-hierarchy-intrinsic-timescales.md`). Re-analysis of single-neuron spike trains from **6 laboratories, 26 macaques, 7 cortical areas, 16 area×dataset cells**. No new recordings; the contribution is an estimator and the ordering it produces.

---

## The estimator

| Step | Definition |
|---|---|
| **Epoch** | The task **foreperiod** — fixation or lever-hold before stimulus onset, ≥ 500 ms, no task stimulus. Same epoch for every area, so the comparison across labs is well posed |
| **Binning** | Successive non-overlapping bins of `Δ = 50 ms` (results stable to ±20%) |
| **Statistic** | `R(iΔ, jΔ) = Cov(N_i, N_j) / sqrt(Var(N_i) Var(N_j))`, with covariance and variance taken **across trials**, `N` = spike count in that bin |
| **Fit** | `R(kΔ) = A [ exp(−kΔ/τ) + B ]`, `k = \|i − j\|`, fitted by Levenberg–Marquardt to **all neurons and all time pairs at once** — a population-level fit, not an average of per-neuron fits. Standard errors by delete-one jackknife |
| **Lag onset** | Fitting starts at the lag of *maximum decrease* of the mean autocorrelation, discarding the short-lag dip caused by refractoriness and adaptation |
| **Filters** | Every bin must have nonzero mean rate; trials restricted to the longest block whose total foreperiod spike count is statistically stationary, so slow session drift cannot manufacture autocorrelation |

**The load-bearing design choice is the across-trial correlation.** Covariance and variance subtract each bin's own mean, so any component locked to trial onset — ramping, anticipatory build-up, a fixed transient — is removed exactly. What survives is fluctuation *not* explained by the trial-averaged response. This is why the measurement can be called intrinsic: it is the noise, not the signal, and it needs no stimulus manipulation to isolate.

`the probe is the model's own variability under a constant input — cost: N forward passes with different noise seeds, no labels, no gradients`

---

## The result: a monotone ordering that matches anatomy

| Level | Areas | Intrinsic `τ` |
|---|---|---|
| Sensory | MT (medial temporal, visual), S1 (primary somatosensory) | shortest |
| Association | LIP (lateral intraparietal), S2 (secondary somatosensory) | intermediate |
| Prefrontal | LPFC (lateral prefrontal), OFC (orbitofrontal) | long |
| Medial prefrontal apex | ACC (anterior cingulate) | **longest, in every dataset containing it** |

| Claim | Statistic |
|---|---|
| Ordering consistent across the 6 independent datasets | `r_s = 0.89`, `P < 10^−5` (Spearman) |
| Ordering matches the Felleman–Van Essen / laminar-projection anatomical hierarchy | `r_s = 0.97`, `P = 0.002` — **OFC is the one area where physiology and anatomy disagree** |
| Same ordering holds in the somatosensory system (S1 → S2 → LPFC → OFC → ACC) | Identical rank correlation to the visual-prefrontal chain — not a visual-stream artefact |
| **Total spread of the intrinsic constants** | **50–350 ms — a factor of ~7 across the entire cortical hierarchy** |
| Negative control: mean firing rate does not explain it | `P = 0.51`, `t(9) = −0.69`, slope `−5.5 ± 7.9 ms/Hz` |

---

## The offset is the second measurement, and it is free

`B` absorbs every fluctuation slower than the observation window — power the exponential cannot resolve because the foreperiod ends first. Three results make it a usable read-out rather than a nuisance parameter:

| Result | Statistic | Reading |
|---|---|---|
| `B` correlates **positively** with `τ` | `P = 0.004`, `t(9) = 3.4` | Areas with slow fast-timescales also have more power at horizons beyond the window — **the hierarchy repeats at temporal ranges the probe cannot see** |
| `B` correlates with **trial-to-trial** spike-count correlation | `P = 0.002`, `t(9) = 3.9`, slope `1.3 ± 0.3` | Part of that slow variability persists *across trials*, i.e. across resets of the task |
| The `τ`–`B` correlation is not a fitting artefact | Off-diagonal parameter-covariance term negative in **11 of 16** area×dataset fits | Increasing `τ` in the fit *decreases* `B`, so the observed positive correlation runs against the fit's own bias |

**And a short measurement orders a long one.** In the Lee dataset, the decay constant of each neuron's modulation by past reward — the *reward timescale*, **5–10 s, an order of magnitude longer than any `τ` here** — orders LIP < LPFC < ACC in exactly the intrinsic ordering. A ~100 ms noise statistic taken with no task predicts the ranking of a seconds-long functional memory.

---

## What is measured is a population, not a unit

Single-neuron autocorrelations are **heterogeneous** (Supplementary Fig. 2): the light-grey per-neuron traces scatter widely and the clean exponential appears only in the population mean. The authors fit at the population level for exactly this reason and state the conclusion twice — the intrinsic timescale is *"a characteristic at the population level rather than at the single-neuron level"*, and the definition *"does not refer to single-neuron physiology or imply that the timescale does not change with stimulus conditions."*

Both disclaimers bite the wiki directly:
- Every timescale bank here attaches `τ` to a **unit** — [[wiki/entities/ltc.md]]'s per-unit rate, [[wiki/entities/ms-ssm.md]]'s per-block eigenvalues, [[wiki/entities/s4.md]]'s shared `Δ`, DEXAT's per-neuron adaptation constants ([[wiki/concepts/spike-frequency-adaptation.md]]). The measurement that motivates all of them is not a per-unit quantity ([[wiki/empirical-tensions.md]] T323).
- The paper is measured in **one** epoch under **one** drive condition, so it cannot arbitrate whether `τ` is stimulus-invariant — which is precisely what [[wiki/empirical-tensions.md]] T319 needs and what this paper is routinely (over-)cited for.

---

## Relevance to a reasoning model

- **The diagnostic [[wiki/concepts/timescale-hierarchy.md]] asked for now has a protocol.** That page's closing brainstorm proposes ranking modules by autocorrelation time constant and had no measured procedure. Here it is, transferred verbatim: hold the input fixed (or at a null token), run `N` independent forward passes differing only in noise seed / dropout mask, bin each module's activation trace, compute the **across-run** correlation between bin `i` and bin `j`, fit `A[exp(−kΔ/τ) + B]` on the pooled units of that module. No labels, no gradients, no task.
- **The trial-mean subtraction is what makes it portable.** It removes everything driven by the input, so the same statistic is comparable between a module that is doing work and one that is idle — which is why the biological version can compare an area processing nothing to another area processing nothing across six labs. A probe that measured driven responses would confound horizon with tuning.
- **`B` is a horizon detector that costs nothing.** One extra fit parameter reports whether a module carries variance past the probe window, and in cortex it also indexes persistence *across episode boundaries*. Any architecture claiming cross-episode state ([[wiki/concepts/continual-learning.md]], [[wiki/concepts/fast-weight-programming.md]]) has a cheap falsifiable signature: `B > 0` in the modules that are supposed to carry it and near zero elsewhere. Nothing in the wiki measures it.
- **The `τ`–`B` correlation is a test that separates the two provisioning stories. (brainstorm)** A hand-stratified bank assigns each band its own decay constant independently, so there is no reason for a module's fast constant to predict its slow-variance share — `τ ⊥ B`. A spectrum generated by one scalar gradient on a coupling matrix ([[wiki/concepts/timescale-hierarchy.md]]) makes both the fast eigenvalues and the slow ones move together with the gradient, so `τ` and `B` must correlate. Cortex shows the correlation. That is a one-fit discriminator between "bank" and "gradient" architectures, runnable on any trained model, and it is not run anywhere.
- **The intrinsic spread is small and the functional spread is not — so the bank does not have to span the decades.** Seven-fold across the whole hierarchy intrinsically, ten-fold longer for the functional (reward) memory, with the *same ordering*. **(brainstorm)** This says the expensive part of a multi-horizon system is not provisioning `τ` over decades but arranging recurrence/coupling that amplifies a modest intrinsic gradient into a long functional one — which is a direct argument against `G67`'s framing of the target as a wide eigenvalue measure and in favour of a narrow gradient plus structure. [[wiki/entities/ms-ssm.md]] partitions eigenvalues dyadically over `2^s·K`; cortex's intrinsic partition would be well inside a single one of those bands.
- **Cheap ordering of a slow quantity by a fast one.** Measuring how long a module holds task-relevant information requires long trials, many of them, and a task. Measuring `τ` requires a quiet window and noise. The biological result is that the second ranks the first. For model selection this is the difference between an evaluation sweep and a forward pass.

---

## Open problems

| Problem | Why it is open |
|---|---|
| **No mechanism** | The authors state explicitly that what produces the gradient is left open, and list four uncommitted candidates: cellular/synaptic time constants, glutamate-receptor composition, short-term plasticity and neuromodulation, or stronger recurrent excitation partly cancelling leak. [[wiki/concepts/timescale-hierarchy.md]] and [[wiki/concepts/broadcast-hierarchy.md]] are the wiki's two rival fillings |
| **One drive condition** | Foreperiod only. The most-cited use of this result — that `τ` is an area label — is not tested here, because the areas are never recorded under a second input regime ([[wiki/empirical-tensions.md]] T319) |
| **Population-only** | Single-neuron heterogeneity is reported and not explained. Whether the heterogeneity is measurement noise, a genuine within-area distribution, or cell-type structure is undetermined — and it decides whether a per-unit `τ` is even the right object (T323) |
| **`B` has no ceiling** | The offset lumps every timescale longer than ~1 s together. It says slow power exists, not how slow, so it ranks modules but does not size a horizon |
| **OFC breaks the anatomical map** | Physiological and anatomical hierarchies agree at `r_s = 0.97` with exactly one exception, and it is unexplained — an area where dynamics and laminar projection patterns come apart |
| **The functional link is one dataset** | Reward timescales: three areas, one lab, median statistic, purely correlational. The claim that intrinsic `τ` predicts functional horizon rests on three points |
| **Nothing learns the gradient** | Same terminal limitation as every timescale source in the wiki: the ordering is measured, no plasticity rule produces it, and `G67` stays open |

---

## Connections

- **[[wiki/concepts/timescale-hierarchy.md]]** — the mechanism proposed for exactly this measurement: Chaudhuri et al. scale recurrent excitatory gain by one scalar along an SLN hierarchy and get a spectrum whose ordering matches these seven areas, while this page supplies the ordering itself, the estimator that produced it, and the `τ`–`B` correlation that a hand-provisioned bank should not show.
- **[[wiki/concepts/broadcast-hierarchy.md]]** — the rival mechanism for the same numbers: hypomyelination, low neurite density and convergent input give the apex a long integration window through conduction physics rather than recurrent gain, and this page is the shared observation neither account has been run against ([[wiki/empirical-tensions.md]] T319).
- **[[wiki/concepts/parallel-timescale-streams.md]]** — the same question asked with the opposite instrument: that page fits an authored 126-state coalition alphabet to whole-brain signals and finds six *concurrent* streams, this page fits a two-parameter decay to one area's own spiking noise and finds one constant per area — so the two disagree on whether an area has *a* timescale at all, and the offset `B` here is the only hint in this measurement that more than one horizon is present.
- **[[wiki/concepts/representation-probing.md]]** — a probe with the opposite dependency: decoders need labels and a task to say what a population carries, this estimator needs neither and says only how long it carries anything, so the two are complementary axes of the same interrogation and the noise-based one is the cheaper screen.
- **[[wiki/concepts/perturbation-elicitability.md]]** — the causal counterpart: that page ranks cortical sites by whether focal stimulation changes reportable content, this page ranks them by spontaneous decay, and both find monotone gradients running to the transmodal apex — which raises the untested question of whether the two orderings are the same ordering.
- **[[wiki/concepts/working-memory.md]]** — the capacity this measurement predicts without testing it: the reward-timescale result orders seconds-long memory traces by a hundreds-of-milliseconds noise statistic, so a store's horizon may be readable before the store is used.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the area that comes out slowest in every dataset that contains it (ACC), which places the wiki's medial-prefrontal machinery at the top of the temporal hierarchy as well as the anatomical one.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the anatomical hierarchy this ordering is validated against: laminar patterns of long-range projections give the discrete rank, and physiology reproduces it at `r_s = 0.97` with OFC as the single exception.
- **[[wiki/concepts/population-geometry.md]]** — the same insistence that the unit of description is the population: the exponential fit exists only in the pooled data and single neurons scatter, so a temporal quantity joins the geometric ones in being defined at the population level (T277, T323).
- **[[wiki/concepts/neuronal-parameter-heterogeneity.md]]** — the provisioning this measurement does not license: HIFI learns a per-neuron `[τ, γ, C, u_th, u_re]` and validates it against recorded per-neuron distributions, whereas the areal `τ` here is explicitly not a single-neuron property, so the two "heterogeneous time constants" are different objects that the wiki has been treating as one ([[wiki/empirical-tensions.md]] T323).
- **[[wiki/entities/ms-ssm.md]]** — the quantitative constraint this page puts on a hand-stratified bank: the entire cortical intrinsic spread is ~7×, narrower than one of MS-SSM's dyadic bands, while the functional spread it predicts is an order of magnitude wider — so the band edges and the horizons they buy are not the same scale.
- **[[wiki/concepts/spike-frequency-adaptation.md]]** — where the per-unit reading of this result gets spent: adaptation stores fix span with a per-neuron adaptation constant (`G78`), a parameterisation this measurement neither supports nor refutes because it never resolves single neurons.
