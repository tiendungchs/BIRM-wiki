# Learning Progress — the Derivative of One's Own Competence, Measured

**Learning progress (LP) is the temporal derivative of an agent's own performance on an activity, estimated over a short retrospective window *per activity*. It is a second, empirically uncorrelated determinant of what a free learner chooses to do next: competence itself (percent correct, PC) decides whether an activity is too easy, and LP decides whether it is worth continuing — and only the LP term keeps a learner off activities that cannot be learned at all.**

> **Provenance.** Ten, Kaushik, Oudeyer & Gottlieb 2021, *Humans monitor learning progress in curiosity-driven exploration*, Nat. Commun. 12:6053 (`raw/ten-2021-humans-monitor-learning-progress.md`). Primary behavioural study plus per-participant model fitting; `N = 382` after exclusions (400 recruited on Amazon Mechanical Turk, 18 excluded on a response-bias criterion). Equations below were checked against the article's LaTeX; the source's index ranges are reproduced as printed and their off-by-one is flagged.

This page is the **measurement** that [[wiki/concepts/intrinsic-motivation-typology.md]] listed as missing for its LPM/CPM cells, and the first entry in the wiki where an intrinsic-motivation formula is *fitted to individual behaviour* rather than run in a robot.

---

## The paradigm: a difficulty ladder with an unlearnable rung

| Activity | Rule governing the reward | Role |
|---|---|---|
| `A1` | 1 varying feature, that feature determines the food preference | easiest learnable |
| `A2` | 2 varying features, **one irrelevant** | 1-D with a distractor dimension |
| `A3` | preference is a **conjunction** of 2 varying features | hardest learnable |
| `A4` | 2 varying features, preference **redrawn at random** for every new stimulus | **unlearnable** — the stochastic trap, present by design |

Procedure: 15 forced-choice familiarisation trials on each activity → prospective learnability ratings → **250 free-choice trials** (pick an activity, see a random member, binary guess, immediate feedback) → subjective ratings. Instruction was the only between-group variable:

- **EG (external goal, `N = 196`)** — "maximise your learning *about all the 4 families*", plus an announced end-of-session test.
- **IG (internal goal, `N = 186`)** — choose anything, complete 250 trials, nothing else said.

`A4`'s presence is what makes this a test of LP rather than of difficulty preference: any monotone preference for *low* PC ends there permanently.

---

## The model — two terms, one softmax

Utility of activity `i` on trial `t`, fitted per participant by maximum likelihood (3 free parameters: `w_PC`, `w_LP`, `τ`; L-BFGS-B, restarted until the best fit recurs 50 times):

```
U_{i,t}  =  w_PC · PC_{i,t}  +  w_LP · LP_{i,t}                        (3.1)

p_t(choice_i) = exp(U_{i,t} · τ) / Σ_{k∈K} exp(U_{k,t} · τ)            (5.2)

PC_{i,t} = (1/15) Σ_{t′=t−15}^{t} y_{t′}                               (5.3)

LP_{i,t} = | (1/10) Σ_{t′=t−15}^{t−5} y_{t′}  −  (1/9) Σ_{t′=t−9}^{t} y_{t′} |   (5.4)
```

`y_{t′} ∈ {0,1}` is correct/incorrect. Both windows count **trials on that activity**, not wall-clock trials — so each activity carries its own clock, the abstract clock `t_g` of the competence family.

Four properties of this estimator that a builder should copy or reject deliberately:

| Property | As implemented | Consequence |
|---|---|---|
| **Absolute value on LP** | `\|Δ PC\|`, following the same choice in the artificial-curiosity implementations | Performance *decreases* (forgetting, a drifting rule) are as attractive as increases — the agent re-engages with a skill it is losing. A signed LP cannot do this |
| **Fixed 15-trial window** | equal to the number of familiarisation trials | The comparison class is a hand-set constant. This is the region-partition problem of [[wiki/concepts/intrinsic-motivation-typology.md]] solved by fiat, available only because the activity set is given and discrete |
| **Overlapping halves** | "first 10 and last 9 of the same stretch of 15" — the two sums share trials, and the printed index ranges span 11 and 10 samples for divisors 10 and 9 | LP is a smoothed, positively autocorrelated derivative, not a clean difference of disjoint halves; it lags a true change point by up to a window |
| **Model-free throughout** | no predictor of the environment anywhere; the only quantity read is the agent's own binary outcome history | LP here is a **competence**-family signal (CPM), not the knowledge-family LPM defined over prediction error — the two are distinguished on the typology page and this experiment measures only the first. The knowledge-family counterpart is now measured too, in 8-month-old infants and as an information gain rather than an error derivative ([[wiki/concepts/realised-information-gain.md]], Poli et al. 2020) |

---

## What was measured

### The bivariate model wins

| Comparison | Result |
|---|---|
| Bivariate (`PC + LP`) mean AIC | **491.99** (SD 200.39) vs random-choice baseline 693.15 |
| Bivariate vs both univariate models | significant main effect of model form, `F(2,1089) = 43.99, p < 0.001`; **no** model-form × instruction interaction (`p = 0.716`) |
| Participants best fit by the bivariate model | EG **70.74%**, IG **74.01%**; ≥2 AIC points clear of next best in EG 58.51% / IG 62.71% |

The absent interaction is the load-bearing negative result: **sensitivity to LP does not require being told to learn.**

### The two weights are independent, and only one of them listens to instructions

| Quantity | IG (no goal given) | EG (goal given) | Test |
|---|---|---|---|
| `w_PC` (normalised) | **+0.255** (SD 0.724) — prefers easy | **−0.232** (SD 0.741) — prefers hard | `F(1,363) = 40.24, p < 0.001` |
| `w_LP` (normalised) | +0.079 (SD 0.640) | +0.062 (SD 0.631) | `F(1,363) = 0.065, p = 0.799` — **null** |
| correlation `w_PC` vs `w_LP` | `r(186) = −0.077, p = 0.298` | `r(175) = 0.062, p = 0.399` | uncorrelated in both groups |

**(brainstorm) Read as an architecture, this is the cleanest result on the page.** An externally supplied objective did not install a new drive and did not scale the exploration term — it **flipped the sign of one coefficient of a two-term intrinsic utility and left the other untouched**. If that generalises, the interface between an extrinsic goal and an intrinsic motivation system is a *write to the competence weight*, not a reward channel added alongside it — an unusually cheap way to make a curiosity-driven agent instructable (`R5`).

### LP is what avoids the unlearnable activity

Participants binned by normalised coefficients: PC-driven (`ŵ_PC ≈ −1, ŵ_LP ≈ 0`) vs LP-driven (`ŵ_LP ≈ 1, ŵ_PC ≈ 0`). Both prefer difficult activities; they differ on *which*.

| Outcome | PC-driven | LP-driven |
|---|---|---|
| Mastered ≥ 2 activities | 70.59% | **90.48%** |
| Mastered all 3 learnable | 34.98% | **64.29%** |
| Time on `A4` (unlearnable) | rises sharply after ~trial 80 | no rise; interaction slope EG `−47.6, t(104) = −2.73`; IG `−125.2, t(72) = −5.76` |

Group-level: lower `w_PC` predicts preference for **both** `A3` and `A4`; `ŵ_LP` predicts preference for `A3` **only**. That single dissociation is the whole argument for carrying a derivative term: *a competence term cannot tell a hard problem from an impossible one, and a derivative term can.* It is the direct answer to the stochastic-trap failure mode of predictive-novelty rewards (`NM`, `r = C·E_r`).

### Self-challenge and the inverted U

```
SC_{t,i} = 1 − ( PC_{t,i} − min_{k∈K} PC_{:t,k} ) / ( max_{k∈K} PC_{:t,k} − min_{k∈K} PC_{:t,k} )   (5.1)
```

`SC → 1` = habitually picking the lowest-PC activity available (over-challenge); `SC → 0` = under-challenge; normalisation is against the PC range **the participant has actually experienced so far**, which makes it a self-referential difficulty scale requiring no designer's difficulty labels.

- Difficulty-weighted final PC (`dwfPC = ⅙·fPC_{A1} + ⅓·fPC_{A2} + ½·fPC_{A3}`, last 15 trials on each) is an **inverted U in SC**: adding a quadratic term beats the linear model by `ΔAIC = 11.775`; quadratic coefficient `−0.016, t(360) = −1.966`, `R²_adj = 0.159`.
- The two failure modes sit on opposite arms: **EG participants who failed over-challenged; IG participants who failed under-challenged.** Participants who mastered all three sat at the top with statistically equal, intermediate SC regardless of instruction (`t(359) = 1.236, p = 0.217`).
- Group means: EG allocated **36.92%** of trials to the unlearnable `A4` (above chance, `p < 0.001`) and below chance to `A1`/`A2`; IG allocated **33.00%** to the *easiest* `A1` (`p < 0.001`). Final learning: EG `dwfPC` 0.756 vs IG 0.721 (`t(379.4) = 2.679, p = 0.008`).

**The group-level IG result contradicts the wiki's standing "free play settles at 70–80% correct" claim** (`T370`): uninstructed learners as a group under-challenged, and the intermediate operating point was the signature of a *subgroup* (29.59% of IG mastered all three activities), not of the condition.

---

## Reading in the core framing

| Element | Latent-graph reading |
|---|---|
| `PC_{i,t}` | how reliably the agent can traverse the edges inside region `i` right now |
| `LP_{i,t}` | whether that region's structure is still **yielding** to the agent — a frontier indicator over the graph, computed without any model of the graph |
| `A4` | a region with no latent structure at all; the only signal that says so is that competence stops moving |
| `w_PC` sign | which side of the competence frontier to sit on — set here by an *external* sentence |
| `SC` normalisation | difficulty measured against the agent's own experienced range, i.e. a graph-free, self-calibrating hardness scale |

---

## Open problems

- **The activity set is given, discrete and small (`K = 4`).** Every hard part of LP in the open case — what counts as one activity, when to split a region, how to compare progress across regions — is removed by the design. The estimator does not survive contact with a continuous sensorimotor space unchanged.
- **No neural measurement.** This is a behavioural fit; the review literature says the same (`no neural measurement of a learning-progress signal is cited`, [[wiki/concepts/information-sampling-vs-search.md]]). Where LP is computed, and by what, is untouched — and the obvious candidate signal, a pseudo-reward prediction error in anterior cingulate cortex, was measured in a different paradigm ([[wiki/concepts/pseudo-reward-prediction-error.md]]).
- **Only the choice policy is modelled; the learning process is not.** The authors explicitly eschew modelling forgetting, switching costs, effort and uncertainty preference, and fit choices against *observed* success rates. So `w_LP` is a sensitivity to a signal the experimenters computed, not evidence that the participant computes that exact statistic.
- **Novelty could not be separated.** A familiarity term (the reciprocal of novelty) leaves `w_PC` and `w_LP` important, but familiarity is defined by past choices and so is circular as a predictor of choices — it accounts for choice autocorrelation without explaining it.
- **Absolute-value LP is untested against signed LP in humans.** The `|·|` is inherited from machine implementations for the forgetting case, and this experiment has no condition where performance declines — so the data constrain the positive branch only.
- **Two terms, no principle for their weights.** `w_PC` and `w_LP` are free parameters fitted per person, and the paper's own prediction is that their relative importance should depend on the environment's composition (LP matters more the more unlearnable activities there are). Nothing measures that — `G30` again.
- **The effort term is absent.** Choosing `A3` costs more than choosing `A1`, and the utility has no subtrahend ([[wiki/concepts/expected-value-of-control.md]]); part of the IG group's easy-activity bias is indistinguishable from effort avoidance.

---

## Connections

- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — the measurement its LPM/CPM cells were waiting for, and a correction to how that page frames them: the typology treats competence and competence-progress as *alternative* reward formulas, and the fit here says they are **uncorrelated co-determinants** of one utility, so the right object is a weight vector over the families rather than a choice among them.
- **[[wiki/concepts/information-sampling-vs-search.md]]** — supplies the search-regime existence proof this page quantifies, and now disagrees with it at group level: free play there settles at 70–80% correct, and uninstructed participants here over-allocated to the *easiest* activity while the intermediate operating point marked only the subgroup that mastered everything (`T370`).
- **[[wiki/concepts/curriculum-learning.md]]** — the self-paced `λ` that page lists as missing, fitted rather than proposed: the learner's own `|Δ PC|` per activity orders the training distribution with no oracle easiness measure, and the inverted U says the ordering has an optimum a hand-set schedule can miss from either side.
- **[[wiki/concepts/replay-prioritisation.md]]** — the same derivative-of-error quantity consumed by a different module: prioritisation reads `|δ|` to decide *what to rehearse*, this reads `|Δ PC|` to decide *what to do next*, and the wiki's record is that error-magnitude works as a rehearsal priority while its derivative is what keeps an actor out of a stochastic trap — a distinction invisible to any typology that defines rewards without naming their consumer.
- **[[wiki/concepts/metacognitive-efficiency.md]]** — what the fit presupposes and does not measure: a `w_LP` significantly different from zero means the participant's choices track a statistic of their own recent accuracy, which is a type-2 read-out whose *sensitivity* is never scored here, so an unfitted participant may have the drive and a noisy competence estimate rather than no drive (`G89`).
- **[[wiki/concepts/epistemic-value.md]]** — the competence-side counterpart to its knowledge-side terms: `E1`–`E4` are all defined over beliefs about the world, `PC`/`LP` over the agent's own achievement record, and the two have never been fitted to the same behaviour — so the wiki still cannot say whether a human free-play choice is better predicted by information gain or by competence progress.
- **[[wiki/concepts/general-danger-channel.md]]** — the third arm of `T358` given a fitted human coefficient: neither a monotone novelty bonus nor an annealing novelty penalty produces the observed pattern, but a derivative term does — it predicts the abandonment of `A4`, which is simultaneously the most novel and the least learnable activity available.
- **[[wiki/concepts/expected-value-of-control.md]]** — the missing subtrahend for this page's utility: `U = w_PC·PC + w_LP·LP` prices two benefits and no cost, so the easiest-activity bias of the uninstructed group is confounded with plain effort avoidance, which that page would score as a lower `Cost(signal)` rather than as a competence preference.
- **[[wiki/concepts/hindsight-goal-relabelling.md]]** — the machine scheme that manufactures the same easy-to-hard ordering with neither of this page's terms: there is no competence estimate and no derivative anywhere, the goal sampler's reachability does all the work — so the wiki now has a self-paced curriculum *with* a progress signal (here) and one *without* (there), and no experiment comparing them.
- **[[wiki/concepts/latent-graph-discovery.md]]** — LP as a model-free frontier indicator: the derivative of competence marks which regions of the graph are still yielding structure, which is the only quantity on the page computable without possessing any part of the graph, and the `A4` result is the first measurement of it rejecting a region that has no structure to find.
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — the candidate neural implementation this page lacks: a prediction error computed against a self-set intermediate goal is the signal an LP-driven learner would need to make progress on an activity trainable, and it is measured in a paradigm where the subgoal is supplied rather than chosen.
- **[[wiki/concepts/explore-exploit-division-of-labour.md]]** — the opposite prediction about persistence, from the developmental side: a progress-weighted learner abandons an activity it is not improving at, while preschoolers keep sampling options that have already produced costs — and are right to, because that sampling is what reveals a two-dimensional rule the adults' early stop conceals, so "abandon what you are not learning from" and "keep probing what you have already been punished for" are both defensible and this page's utility cannot express the second (Gopnik 2020).
- **[[wiki/concepts/self-boosting-knowledge-acquisition.md]]** — the opposite non-stationarity, with a free discriminating design: this page's `LP` decays to zero at mastery because the activity is exhausted, while a reward emitted at the boundary of the knowledge store peaks at *half*-mastery and rises over the whole first half of a large domain — and this page's additive fitted utility `w_PC·PC + w_LP·LP` is directly testable against that framework's multiplicative competence × knowledge-gain gate on data of exactly this kind (Murayama 2022).
- **[[wiki/entities/asymmetric-self-play.md]]** — the same frontier-tracking behaviour with the derivative deleted: the signal that a region is exhausted is not a fall in this page's `LP` but a fall in a *second agent's* payoff, so the set-point is an equilibrium of a two-player game that no agent estimates. The predicted cost is exactly what this page's progress term exists to prevent — nothing stops the proposer parking on a narrow unlearnable trick, and the only counterweight is a hand-set 20% chance of facing a past opponent (`T403`).
- **[[wiki/concepts/realised-information-gain.md]]** — the same word, the other family, and the other population: this page's `LP = |Δ PC|` is a windowed derivative over the learner's own *achievement* record in 382 adults, that page's `D_KL(p^j ‖ p^{j−1})` is a single-trial belief-update magnitude over the *environment* in 43 infants, and both are reported by their authors as "learning progress". Two consequences. (i) The typology's knowledge/competence dissociation is now measured on both sides but never in the same behaviour, so which one a free learner reads is open. (ii) The stochastic-trap protection is achieved differently — here by taking a derivative, there by a Dirichlet prior whose `1/(j−1+K)` decay shrinks posterior jitter — and the derivative is the more robust of the two, because it survives a non-stationary rule where the prior's arithmetic does not.
