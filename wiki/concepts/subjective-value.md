# Subjective Value — the Discount Is Applied Before the Comparison

**The quantity a chooser compares is not the outcome but a scalar the agent computes from it by its own, idiosyncratic, temporally-stable discount kernel — and that scalar is explicitly represented, on a common currency, in tissue, quantitatively matching the kernel fitted to the same person's behaviour.**

> **Provenance.** Kable & Glimcher 2007, *The neural correlates of subjective value during intertemporal choice*, Nature Neuroscience 10:1625–1633 (`raw/kable-2007-subjective-value-intertemporal-choice.md`). Twelve subjects fitted behaviourally across three sessions spanning 1–6 months; the ten with stable discount functions scanned with fMRI while choosing between a fixed immediate $20 and a delayed reward ($20.25–$110, 6 h–180 d). Method: a **psychometric–neurometric comparison** — fit the discount kernel to behaviour, fit a second one to the blood-oxygen signal, and test whether the two rates covary *and* have zero mean difference.

Why this earns a page rather than a paragraph on [[wiki/concepts/neuromodulatory-metaparameters.md]]: that page treats the discount factor as a **metaparameter of the learning rule** — a knob on a broadcast channel that shapes how `V` is *learned*. This source shows the discount is visible in the *represented value itself*, at choice time, with the subject's own parameter, in regions that do not select actions. Those are different architectural placements, and only one of them is measured.

---

## The kernel

| Form | Equation | Fit |
|---|---|---|
| **Hyperbolic** | `SV = A / (1 + kD)` | Median `R² = 0.95` (range 0.84–0.98) across all subjects |
| Single exponential | `SV = A·e^(−cD)` | Worse than hyperbolic for every subject |
| Sum of two exponentials (β–δ) | `SV = A·(w·e^(−βD) + (1−w)·e^(−δD))` | As good as hyperbolic — behaviourally *unidentifiable* from it |

`A` = objective amount, `D` = delay in days, `k` = subject-specific discount rate.

**The spread of `k` is the point.** Most patient subject `k = 0.0005` (prefers $21 in a month to $20 now); most impulsive `k = 0.1189` (prefers $20 now to $68 in a month) — a **238×** range, and 10 of 12 subjects held their rate constant across sessions separated by up to six months. So the horizon parameter is a *trait*: wide across agents, near-fixed within one, on a stationary task.

---

## What was measured

| Claim | Evidence |
|---|---|
| Three regions track subjective value | Ventral striatum, medial prefrontal cortex, posterior cingulate cortex; group random-effects, voxelwise `P < 0.001`, extent > 100 mm³; effect confined to 6–10 s into the trial, i.e. to the presentation of the delayed option |
| Value beats the objective variables | Subjective value outscored amount, delay and choice in both peak `z` and cluster extent. Pairwise, it won in **100%** of ventral-striatal, ≥85% of posterior-cingulate and ≥62% of medial-prefrontal voxels. Of the objective regressors only *delay* reached significance, and only in medial prefrontal cortex |
| The **subject's own** `k` beats a population `k` | Fitting all subjects one fixed discount rate loses the effect in ventral striatum and posterior cingulate entirely |
| Neurometric ≈ psychometric | Neural `k` estimated by refitting the hyperbola to the time courses: rises with behavioural `k` (slope_ALL = 0.69 ± 0.16, `P = 0.0002`) **and** the neural − behavioural difference is centred on zero (median_ALL = −0.0009, `P = 0.67`). Both halves are required; either alone is compatible with the region coding something else |
| Replicated in unbiased ROIs | ROIs defined without reference to the neural discount rate reproduce both halves (slope 0.70 ± 0.31, `P = 0.03`; difference median −0.0009, `P = 0.93`) |
| Not choice difficulty or attention | Two independent difficulty indices produce no effect in any of the three regions |
| Not movement | Value is coded whether the reward is taken by a button press or by *withholding* one — so these are outcome-value areas that must feed action-value areas (posterior parietal), not motor areas |

**The falsification.** The β–δ dual-system reading (McClure et al. 2004) assigned exactly these three regions to an *impulsive* system that values immediate rewards. It fails two ways here: activity varies when only the **delayed** option changes, and the neural rate is neither steeper than behaviour (as `β` requires; difference median −0.0081, `P = 0.001`) nor shallower (as `δ` requires; +0.0024, `P < 0.0001`). One system carrying a non-exponential kernel, not two exponential systems in competition. See [[wiki/empirical-tensions.md]] T140.

---

## What a builder takes from this

| Finding | Consequence for an architecture |
|---|---|
| The discount is *inside* the represented value | A value head should emit already-discounted scalars, not `(magnitude, delay)` pairs corrected downstream. Anything reading the value — the selector of [[wiki/concepts/evidence-accumulation.md]], the comparator in [[wiki/entities/basal-ganglia.md]] — then needs no time argument at all |
| One scalar, one currency | Delayed money, immediate money, and (by the cited literature) gains and losses all land on the same axis in the same voxels — which is the precondition for the `argmax`/threshold machinery the wiki already has, and the thing a multi-objective agent must manufacture explicitly |
| Outcome value ≠ action value | Two stages, separately addressable: valuation of *outcomes* (these three regions) feeding valuation of *actions* (parietal). A model that computes `Q(s,a)` directly collapses them and loses the ability to re-goal without relearning the action values (gap G28) |
| The kernel is hyperbolic | `SV = A/(1+kD)` is **time-inconsistent**: preferences between the same two rewards reverse as both approach, so no stationary `V` exists over which dynamic programming converges. Every value function in the wiki uses `γ^k`. This is a live design question, not a settled biological detail — T141 |
| `k` is a stable trait, not a tracked statistic | Doya's closed loop sets `γ` from `Var(δ)` *within a lifetime*. Here the same parameter does not move over six months. The two are compatible only if the loop's input was stationary throughout — which, in a lab intertemporal-choice task, it was — so the paper does not refute the control law, it shows the regime where the control law has nothing to do |
| Psychometric–neurometric matching as an instrument | The **two-part test** — the internal estimate must covary with the behavioural one *and* have zero mean offset from it — is stronger than the decoding tests on [[wiki/concepts/representation-probing.md]], and it is directly runnable on an artificial agent: fit the kernel to its choices, fit a second kernel to a unit's activations, and check both halves. A network that merely correlates with value fails the offset half |

**(brainstorm) The idiosyncrasy is the load-bearing observation, not the anatomy.** A fixed population discount rate was *worse* than each subject's own in two of three regions — meaning the horizon is a per-agent parameter that has to be estimated from that agent's behaviour before its internals become legible. Transposed to a machine: the discount factor of a trained agent is a recoverable, measurable property of its value representation, and one could read `γ_effective` off the activations of a network trained with an entirely different nominal `γ` — a check on whether the horizon the optimiser was given is the horizon the network actually learned. Nobody in the wiki has run this.

---

## Limitations

| Limit | Consequence |
|---|---|
| The combination rule is unidentifiable | One option was held constant at $20, so sum, difference, ratio of the two values, and chosen-option value, all predict the same signal. The paper cannot say *which* comparison the regions compute — only that a discounted value is present |
| No delayed-vs-delayed condition | Untested whether these regions value delayed options the same way when no immediate option is on the screen |
| Two subjects excluded for unstable `k` | The sample is *selected* for the stability the paper then reports; agents using cut-off heuristics rather than a smooth kernel were scanned out of the study |
| Amount-linearity assumed | If subjective value is nonlinear in money, the fitted curves are discounted-utility functions rather than pure discount functions — the subjectivity claim survives, the kernel's functional form does not |
| Correlational, blood-oxygen, group-level | No causal test that the signal is *used*; the discount could be applied upstream and merely reflected here |

---

## Connections

- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the same parameter at the other end of the pipe: that page sets `γ` as a broadcast metaparameter of the *learning rule* from `Var(δ)`, this one finds the discount already applied in the *represented value* at choice time, with a per-agent rate stable over six months. Together they say the horizon is written once into the value code and only re-tuned when the environment's reliability changes (T134, T141).
- **[[wiki/entities/basal-ganglia.md]]** — supplies the input the selection algorithm assumes: the ventral striatum carries a discounted scalar per option, which is exactly the "salience" `y_i` the multihypothesis-sequential-probability-ratio-test mapping takes as given and never derives.
- **[[wiki/concepts/evidence-accumulation.md]]** — what is being accumulated: the evidence in an economic choice is a *subjective* value with the agent's own kernel already folded in, so the discriminability `(μ⁺−μ⁻)/σ` that sets decision time is a property of the discount rate too — a steep discounter faces an easier discrimination on the same objective pair.
- **[[wiki/concepts/simulation-based-planning.md]]** — a horizon that is neither derived nor regulated but *fixed per agent*, and a non-exponential one: a hyperbolic kernel has no stationary value function, so the wiki's `γ^k` rollout scoring is not what this brain does (gap G24).
- **[[wiki/concepts/representation-probing.md]]** — the strongest probe protocol in the wiki, from outside machine learning: fit a parametric psychophysical function to behaviour, fit the same functional form to internal activity, and require both covariation across agents *and* zero mean offset. Correlation alone passes many wrong hypotheses; the offset test is what killed the β–δ account.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — adds a fifth candidate function to that page's reverse-inference contest for the medial wall, and one with a quantitative signature rather than a contrast: subjective value with a subject-specific rate, in the human homologue of the ventral tier.
- **[[wiki/concepts/expected-free-energy.md]]** — the tension the discount kernel creates for that objective: discounting below the number of observations a confident commit needs destroys the epistemic term's advantage outright, and a hyperbolic kernel discounts the near future *less* and the far future *more* than any exponential fitted to it — so where the epistemic payoff sits on the delay axis decides whether hyperbolic discounting helps or hurts.
- **[[wiki/concepts/latent-graph-discovery.md]]** — prices the nodes rather than the edges: traversal needs a scalar per candidate destination, and this page says that scalar is computed by the traverser's own kernel and is comparable across otherwise incommensurable outcomes — the currency the search's `argmax` presupposes.
- **[[wiki/concepts/reward-prediction-error.md]]** — what this page's kernel undermines: `δ = r + γV(s′) − V(s)` presumes a stationary value function, and a hyperbolic discount admits none, so the trait-like `k` measured here and the feedback-controlled `γ` the error term assumes cannot both be right (T141).
- **[[wiki/concepts/default-self-model.md]]** — value as a second channel rather than the estimate itself: in self-referential trait judgment the applicability estimate (medial prefrontal + posterior cingulate) and the valence signal (ventral anterior cingulate) are carried by different populations and dissociate.
