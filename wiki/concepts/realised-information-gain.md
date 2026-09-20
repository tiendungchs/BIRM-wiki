# Realised Information Gain — the KL Between Two Consecutive Posteriors, Measured as an Attention Gate

**Realised information gain is `D_KL(p^j ‖ p^{j−1})` — the divergence between the agent's predictive distribution *after* an observation and the one it held *before*. It is a retrospective, single-number read-out of how far the last observation moved the model, requires no counterfactual evaluation of unobserved outcomes, and in 8-month-old infants it is the dominant determinant of whether attention stays on a stimulus sequence — five times stronger than surprise and three times stronger than environmental predictability, with the three quantities entering behaviour through three different read-outs.**

> **Provenance.** Poli, Serino, Mars & Hunnius 2020, *Infants tailor their attention to maximize learning*, Sci. Adv. 6(39):eabb5053 (`raw/poli-2020-infants-tailor-attention-to-maximize-learning.md`). Eye-tracking study plus ideal-learner observer model; 50 infants recruited, `N = 43` analysed (M = 7 m29 d, SD = 12 d, 24 female; 6 excluded for <20 trials, 1 for a software crash). Equations 1–6 below are the source's own. The authors call the quantity "learning progress"; this page keeps their arithmetic and renames it, because the wiki already uses *learning progress* for a derivative over the agent's own achievement record ([[wiki/concepts/learning-progress.md]]) and these are not the same object.

---

## The paradigm: a four-alternative cue–target sequence with graded predictability

| Element | Value |
|---|---|
| Trial | cue (a shape, looming at centre, 1000 ms) → ISI (Inter-Stimulus Interval) 750 ms → target (same shape, rotating, in one of 4 quadrants, 1500 ms) → ITI (Inter-Trial Interval) 750 ms |
| Sequence | 15 trials, one shape throughout; 16 sequences per infant (8 shapes) |
| Predictability ladder | 4 sequences deterministic (one location 100%); 6 at 80/20; 6 at 60/40 — the residual mass spread over the other three locations |
| Stopping rule | look away ≥ 1 s ends the sequence; the next sequence starts when the infant looks back |
| Controls | target location pseudo-randomised across infants (so a left-side bias cannot masquerade as learning); each location 25% marginal across the whole task; a random-forest classifier was run on each candidate sequence and the sequence *resampled* if location at trial `N` was predictable from location at `N−1`, forcing the cue–target conditional to be the only learnable structure |

The resampling control is the design feature worth copying: **the task's only latent structure is the one the observer model is given**, so a regression of behaviour on the model's quantities cannot be picking up a second regularity the model does not represent.

---

## The observer model — Dirichlet–categorical, one line of update

Events `x` are target locations `k ∈ {1..4}`; a sequence up to trial `j` is `X^j = {x^1, …, x^j}`.

```
P(p | α)        = Dir(p ; α_k),        α = [1,1,1,1]                       (1)   weak uniform prior
P(p | X^j, α)   = Dir(p^j ; n_k^j + α_k)                                   (2)   conjugate update
p(x^j = k | X^{j−1}, α) = (n_k^{j−1} + 1) / (j − 1 + K),  K = 4            (3)   Laplace-smoothed predictive

surprise      I(x^j = k)   = −log₂ p(x^j = k | X^{j−1}, α)                 (4)
predictability −H(p^j)     = Σ_k p(x^j=k | X^j, α) · log₂ p(x^j=k | X^j, α) (5)
realised gain  D_KL(p^j ‖ p^{j−1}) = Σ_k p(x^j=k | X^j, α) · log₂ [ p(x^j=k | X^j, α) / p(x^j=k | X^{j−1}, α) ]   (6)
```

Four properties a builder should read off this, all of them consequences of `α = [1,1,1,1]` plus conjugacy:

| Property | Consequence |
|---|---|
| **New evidence weighs less as `j` grows** (eq. 3 denominator) | The learner is a stationary-world estimator with a built-in, non-tunable forgetting-free decay. Justified here because sequences *are* stationary; it is the first thing to break in a volatile environment, which is the mechanism the wiki's volatility pages price ([[wiki/concepts/contextual-inference.md]]) |
| **The prior is reset to eq. 1 at every sequence boundary** | Each sequence is assumed independent of the previous ones — i.e. the model is *given* the segmentation that a real learner has to infer. The regionalisation problem that every progress-based intrinsic reward hides ([[wiki/concepts/intrinsic-motivation-typology.md]]) is solved here by the experimenter's sequence structure |
| **`−H` is computed including trial `j`, surprise excluding it** | Deliberate, and the one place the paper splits its own predictor: saccadic latency is a *pre-target* measure, so for that regression `X^j` is replaced by `X^{j−1}`. A read-out's timing decides which version of the state variable is even available to it |
| **Eq. 6 is `D_KL(posterior ‖ prior)`, not an expectation over unseen outcomes** | This is the whole architectural point of the page — see below |

---

## The measured dissociation: three quantities, three read-outs

Three dependent variables, all `z`-scored *within participant* (so no group-level scaling absorbs an individual difference). Look-aways: additive Cox model with time-varying covariates (`mgcv`), conditional AIC (Akaike Information Criterion) with the Wood et al. smoothing-parameter correction, subjects as random factor, both sequence-wise and task-wise trial count as covariates. Latency and looking time: GLMs (Generalized Linear Models) with a **logistic** response distribution chosen off a Cullen–Frey graph (500 bootstrap draws), which beat the normal-error linear model by `ΔAIC = 147` and `248` respectively. All VIFs (Variance Inflation Factors) < 5 (surprise 2.28, predictability 2.45, gain 2.78, time 1.04) — so the three information-theoretic regressors are correlated but separably estimable.

| Read-out | What it indexes | Surprise | Predictability `−H` | Realised gain `D_KL` |
|---|---|---|---|---|
| **P(look away)** — the decision to stop spending resources | continued engagement | **↑** monotone: more surprise → more look-away. Wald χ² = 19.38, edf = 3, `p < 0.001` | **∩** inverted U: look away if too predictable *or* too unpredictable. Wald χ² = 21.87, edf = 1, `p < 0.001` | **↓** monotone: more gain → keep looking. Wald χ² = 48.87, edf = 4, `p < 0.001` |
| **Saccadic latency** — how fast gaze reaches the target | quality of the learned predictive model | **significant** | **significant** | *n.s.* |
| **Looking time on target** — trial-by-trial processing | magnitude of the update being performed | *n.s.* | *n.s.* | **significant** (controlling for saccadic latency, `r = −0.59` with it, and for time) |

Effect sizes on the look-away hazard, as `e^{|β|}` (the same statistic Kidd et al. used, chosen for cross-study comparability):

| Quantity | `e^{|β|}` | Fitted functional form in the follow-up GLM |
|---|---|---|
| **Realised gain** | **7.02** | linear |
| Surprise | 2.44 | linear |
| Predictability | 1.27 | quadratic |

The full model beat every partial model on corrected AIC. **The dissociation is the result, not the ranking.** One posterior, three functionals of it, and each one lands on a different behavioural channel: the *quality* of the model shows up in a motor latency, the *size of the current update* shows up in dwell time and in the stay/leave decision, and the *entropy* of the environment shows up only in the stay/leave decision and weakly. A single scalar "interest" variable cannot produce this pattern.

---

## Realised vs. prospective information gain — the architectural point

The wiki already holds one KL-over-parameters curiosity term: E3 novelty `D_KL[q(θ|y,x) ‖ q(θ|x)]` in expected free energy ([[wiki/concepts/epistemic-value.md]]), the term the ablations find carries the whole effect. Eq. 6 is *syntactically the same divergence* and computationally a different object.

| | **Prospective** (E3, expected free energy) | **Realised** (eq. 6, this page) |
|---|---|---|
| Argument | a *hypothetical* observation `y` under each candidate action | the observation that actually arrived |
| Cost | one belief update per (action × outcome) branch, then an expectation — the reason planners truncate horizons | one subtraction of two posteriors the learner already computed |
| What it can drive | action **selection** — where to look next | engagement **gating** — whether to keep looking, and how long to dwell |
| What it cannot do | run at reflex timescales | choose among unsampled alternatives; it is blind to a better option never tried |

**(brainstorm) This is a clean L2 split worth building to.** A curiosity architecture does not need one epistemic quantity, it needs two with different prices: a cheap realised gain on the *stay/leave* and *dwell* decisions, running every trial and requiring no model of the alternatives, and an expensive prospective gain consulted only when the cheap signal says leave. That ordering makes the expensive computation rare by construction and it matches what the infant data show — the gain term dominates the look-away hazard (`e^{|β|} = 7.02`) while nothing in the paradigm asks the infant to compare unsampled sequences. It also predicts a specific failure the wiki has no measurement of: an agent gated on realised gain alone will sit indefinitely in a region whose updates are large but useless, because the divergence between two consecutive posteriors does not know whether those posteriors are converging on anything. The infant paradigm cannot see this failure — its sequences are stationary and 15 trials long.

**(brainstorm) Eq. 6 is also not the LPM the typology defines.** LPM is the derivative of prediction *error* over a window; eq. 6 is the size of a *belief* move on a single trial. They come apart where it matters most: under a genuinely random 25/25/25/25 target distribution, prediction error is high and flat (LPM ≈ 0, correctly reporting no progress) while eq. 6 stays non-zero forever, because a Dirichlet posterior under noise keeps jittering. The `α = [1,1,1,1]` prior plus the `1/(j−1+K)` decay is what makes the jitter shrink — i.e. **this quantity's protection against the stochastic trap is supplied by the prior's arithmetic, not by the reward's form**. That is a cheaper solution than a windowed derivative and a more fragile one.

---

## What it buys the wiki's standing rows

- **`T358` (novelty: bonus or penalty?) gets both signs out of one regression.** In the same additive model, on the same infants, surprise raises the look-away hazard (`e^{|β|} = 2.44`, a penalty) and realised gain lowers it (`7.02`, a bonus). So the question "is novelty a bonus or a penalty" is mis-posed at the level the tension states it: two quantities that both increase with unfamiliarity carry opposite signs simultaneously, and the *stronger* one is the progress-like term. The paper's own reconciliation is the predictive-coding two-policy story — when information is inconsistent with the model an agent can update or disregard, and look-away is the second policy ([[wiki/concepts/predictive-coding-free-energy.md]]).
- **`T370` (does uninstructed free play converge on an intermediate set-point?) gains an inverted U and loses a claim.** The inverted U is *present* and in the uninstructed direction — nobody instructed an 8-month-old — but it sits on **environmental entropy**, not on the learner's own success rate, and it is the weakest of the three effects (`1.27`). Position A's 70–80%-correct set-point is a statement about competence; this is a statement about the environment's predictability. The row does not close: no individual-level distribution is reported, and there is no unlearnable rung (every sequence has a modal location).
- **The novelty/familiarity-preference contradiction in the infant-looking literature gets a mechanism.** Infants stay on familiar stimuli *while* those stimuli still yield gain and switch when gain drops, which generates a familiarity preference early in a sequence and a novelty preference late in it from one signal. The source ties this to habituation as opponent hippocampal selective inhibition against cortical long-term potentiation — an `L3` claim carried here and not registered.

---

## Reading in the core framing

| Element | Latent-graph reading |
|---|---|
| `p^j` | the agent's estimate of one node's out-edge weights (cue → four candidate targets) |
| `D_KL(p^j ‖ p^{j−1})` | how much the last traversal rewrote that node's out-edges — a *local, per-node* frontier indicator, no global model needed |
| `−H(p^j)` | how committed that node's out-edges now are; the inverted U says a node is worth standing on only while its edges are neither undetermined nor settled |
| surprise | a mismatch on one edge, which the data say drives *disengagement* rather than investigation |
| sequence-boundary prior reset | the graph is given as a disjoint union of 16 independent subgraphs; the segmentation problem is removed |

The load-bearing transfer: **a frontier can be marked per-node, retrospectively, at the cost of one subtraction**, and that is enough to reproduce the dominant term in a human attention-allocation policy. Every frontier mechanism in the wiki that requires an archive ([[wiki/entities/go-explore.md]]), a second agent ([[wiki/entities/asymmetric-self-play.md]]) or a windowed competence estimate ([[wiki/concepts/learning-progress.md]]) is more expensive than this.

---

## Open problems

- **The quantity is not a progress estimate and is reported as one.** Eq. 6 measures update magnitude on one trial. Nothing in the design distinguishes "the model is converging" from "the model is being pushed around", because every sequence is stationary and has a modal location. The discriminating condition — a sequence with no modal location, as `A4` is on [[wiki/concepts/learning-progress.md]] — is absent.
- **`D_KL` and surprise are correlated by construction** (VIF 2.78 / 2.28) and the paradigm cannot decorrelate them: a surprising target is exactly what moves a Dirichlet posterior. The coefficients are separately estimable, not separately manipulable.
- **The observer model is an analysis tool, not a claim about the infant.** A fitted `β` on eq. 6 says infant behaviour tracks a statistic the experimenters computed; it does not say the infant computes that statistic, and the paper says so. Same limitation as the human learning-progress fit.
- **No mechanism, by the authors' own statement.** Whether the gain is intrinsically rewarding, whether it recruits the dopaminergic machinery that fires for informational rewards ([[wiki/concepts/reward-prediction-error.md]]), or whether ordinary reward feedback does the work, is untested here. Nothing is measured in the brain.
- **Engagement is inferred from look-away, and look-away is overdetermined.** Fussiness, fatigue, and the parent are all in the residual; the design controls the last of these by instruction only (parents told not to redirect attention). Background music was played throughout to raise baseline attention to the screen — an uncontrolled additive on every trial.
- **`K = 4`, 15 trials, one latent parameter per sequence.** The posterior is 4-dimensional and conjugate. Nothing here says what eq. 6 costs or means when the belief is over a graph rather than a categorical, which is the case the wiki needs.
- **No test of the two-tier scheme the page proposes.** Realised gain gating dwell while prospective gain chooses targets is a `(brainstorm)` division of labour with a measurement on one tier and none on the other.

---

## Connections

- **[[wiki/concepts/learning-progress.md]]** — the same word for two different quantities, now both measured: that page fits `|Δ PC|` over the agent's own *achievement* record in 382 adults, this one fits `D_KL(p^j ‖ p^{j−1})` over beliefs about the *environment* in 43 infants. The typology's claim that the knowledge and competence families dissociate is therefore no longer a prediction — but the two have never been fitted to the same behaviour, so which one a free learner actually reads is still open.
- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — fills the knowledge-family cell that page listed as having no human measurement, and does it with an IGM-shaped quantity rather than the LPM the page expected: the fitted signal is an information gain over a posterior, not a derivative of prediction error, so the family is confirmed and the specific formula inside it is not.
- **[[wiki/concepts/epistemic-value.md]]** — the same divergence stripped of its expectation: E3 scores a hypothetical observation under each candidate action and pays a belief update per branch, eq. 6 scores the observation that arrived and costs one subtraction. The prospective form can select an action and the realised form cannot; the realised form can gate engagement at reflex timescales and the prospective form cannot.
- **[[wiki/concepts/divergence-objectives.md]]** — a KL that is neither fitted nor paid but *read*: both arguments are the agent's own successive posteriors, so no direction-of-divergence choice arises between model and world, and the asymmetry that page makes architectural reappears as the question of whether the update is scored from the new belief's perspective (as eq. 6 does) or the old one's.
- **[[wiki/concepts/information-sampling-vs-search.md]]** — the infant end of that page's developmental ladder, with the ordering of its heuristics measured: the intermediate-complexity preference it treats as the headline effect is the *weakest* of three simultaneous terms here (`1.27` against `7.02`), and the strong one is the progress-like quantity the page endorses on robot evidence.
- **[[wiki/concepts/attention.md]]** — what sets the spotlight's dwell and release, on the one page that holds the spotlight's machinery: the selection mechanism there says how one item is amplified, and this says the release signal is a scalar computed from the learner's own belief movement, which is a controller input that page's two-stage model does not name.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the source's own reconciliation of its two opposite-signed coefficients: an inconsistency between observation and model admits two policies, update or disregard, and the monotone surprise penalty on the look-away hazard is the second policy being taken — which makes disengagement a *predicted* behaviour of a prediction-error-minimising system rather than a failure of curiosity.
- **[[wiki/concepts/explore-exploit-division-of-labour.md]]** — the same developmental claim at the opposite end of the timescale: that page has the explore phase as an externally subsidised *life stage*, this has a stay/leave gate running trial-by-trial at 8 months, and the gate's set-point is not scheduled by anything — so a phase account and a per-trial-signal account of infant exploration are both on the wiki with no experiment separating a slow schedule from a fast signal whose statistics drift.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the cheapest frontier indicator on the wiki: the divergence between two consecutive posteriors over one node's out-edges marks that node as still yielding, needs no archive, no second agent and no competence estimate, and reproduces the dominant term of a measured human attention policy.
- **[[wiki/concepts/curriculum-learning.md]]** — the self-paced `λ` at the earliest age it has been measured, and a warning about its form: the ordering signal is a *retrospective* belief-update magnitude rather than any forward estimate of learnability, so the schedule it produces cannot anticipate an easier item it has never sampled.
- **[[wiki/concepts/metacognitive-efficiency.md]]** — the read-out this page needs and does not have: an `e^{|β|} = 7.02` on realised gain means looking behaviour tracks the size of the infant's own belief move, which presupposes access to a quantity about the learner's own state, and nothing here scores how *accurately* that access reports it.
