# Precision Weighting

**Precision — the inverse variance of a prediction error — is a *represented quantity* in its own right, physically carried by synaptic gain, and once a system infers it by the same rule it uses for everything else, attention, salience, value and learning rate stop being separate mechanisms and become one number read in four places.**

> **Primary source.** `raw/friston-2009-free-energy-principle-rough-guide.md` — Friston, *Trends in Cognitive Sciences* 13(7):293–301, 2009. An opinion piece, so most claims below are proposals with supporting anatomy rather than results. Its two page-worthy contributions: the **three-way partition of what a brain represents** (states / parameters / precisions), and the argument that **value is redundant** once priors over sensory trajectories exist.

---

## Why free energy is minimised at all — the existence argument

The step [[wiki/concepts/predictive-coding-free-energy.md]] assumes and this source supplies:

```
H(Y) = −∫ p(y|m) ln p(y|m) dy = lim_{T→∞} (1/T) ∫_0^T −ln p(y(t)|m) dt      (ergodic assumption)
       └ entropy of an agent's sensory states ┘   └ long-term average of surprise ┘
F(y, μ) = −ln p(y|m) + D_KL( q(θ;μ) ‖ p(θ|y,m) )  ≥  −ln p(y|m)
```

| Step | Claim |
|---|---|
| A well-defined agent occupies a limited repertoire of states (a fish in water) | its equilibrium density has **low entropy** |
| Entropy = time-average surprise (ergodicity) | existing ⇒ avoiding surprising states |
| Surprise is not evaluable — it needs all hidden states of the world | but `F` **is** evaluable: a function of sensory input and brain states only |
| `F ≥ surprise`, gap = `D_KL(recognition ‖ true posterior)` | minimising `F` over `μ` makes the gap small (**Bayesian perception is derived, not hypothesised**) and simultaneously tightens the bound so that action on `F` is a good proxy for action on surprise |
| `F = complexity − accuracy`; **action can only change accuracy** | action must resample the world until the data match the current representation (active inference) |

Two consequences a builder should carry. (i) The **Bayesian-brain hypothesis is a corollary, not an assumption** — the argument runs from persistence to inference, so a system that must maintain itself in a narrow region of state space is *forced* into approximate posterior inference. (ii) Perception's job is instrumental: it exists to make the bound tight enough that action, which is the only channel that touches surprise itself, is not steering on a stale estimate. This is the wiki's cleanest statement of *why* the perception/action loop cannot be cut in half — the same point [[wiki/concepts/expected-free-energy.md]] later reaches as a performative fixed point.

---

## Three represented quantities, three substrates, three timescales

The partition that makes precision a first-class citizen rather than a hyperparameter:

| Represented | Sufficient statistic | Substrate | Dynamics | Cognitive name |
|---|---|---|---|---|
| **States** `{x, v}` — environmental causes, ms-scale | `μ^x, μ^v` | synaptic **activity** | first-order (`μ̇ = …`), minimise `F` itself — evidence accumulation | perceptual inference |
| **Parameters** `θ` — causal regularities, slow | `μ^θ` | synaptic **efficacy** | second-order, minimise the path-integral `A = ∫F dt`; driven by terms that *themselves* accumulate gradients (synaptic traces/tags) | perceptual learning, memory |
| **Precisions** `λ` — inverse variance of the random fluctuations | `μ^λ` | synaptic **gain** (postsynaptic sensitivity, neuromodulation, local synchrony) | second-order, minimises `A`, so **necessarily slower than the state dynamics** | attention, salience, learning rate |

Three design consequences:

- **The order of the dynamics is derived, not chosen.** Only time-dependent expectations minimise `F`; everything else minimises its path integral, which is *why* weights and gains obey second-order equations and need eligibility-trace-like variables. A builder who wants gain adaptation on the same timescale as activity is contradicting the objective, not just the biology.
- **Randomness in the world induces a representation.** Precision is not an engineering add-on for numerical stability; it is the sufficient statistic that stochasticity forces into existence. Any world model with noise has a third register whether or not the architect declares one.
- **The three optimisations are mutually dependent** — each gradient contains the others' expectations — so they cannot be trained as separate heads. This is the formal version of the wiki's recurring complaint that gains, weights and activity are treated as three unrelated subsystems.

---

## Attention *is* precision, not selection

> "Attention is simply the process of optimising precision during hierarchical inference." — the paper's deliberate rejection of the Jamesian "taking possession by the mind".

Under a hierarchical model, the relative precision of the top-down empirical prior and the bottom-up sensory evidence *must* be estimated — it is the analogue of estimating the standard error in a *t*-test, and it controls how much influence each level's expectation has. Neurobiologically that is gain control on error units ([[wiki/concepts/canonical-cortical-microcircuit.md]]: `Π` on the superficial pyramidal cell), and cholinergic modulation of postsynaptic gain is the proposed carrier.

| Prediction | Fits |
|---|---|
| Attention is an **emergent property of prediction**, not a channel selector | high-precision prediction errors simply enjoy greater gain; nothing is switched off |
| Attentional modulation of local competition and contrast gain | measured (biased competition, contrast-gain effects) |
| Feature integration | falls out of relative precision across levels in a hierarchy |

**Where this collides with the wiki's other account of attention.** [[wiki/concepts/attention.md]] builds selection from a softmax over a query — a *competition* whose denominator is the capacity limit. Precision-weighting is multiplicative and has no denominator: two error populations can both be up-weighted, and nothing is normalised away. The two accounts make opposite predictions for an unattended-but-unpredicted stimulus (T118-adjacent; see the Kok et al. 2011 sign flip on [[wiki/concepts/canonical-cortical-microcircuit.md]]). **(brainstorm)** They may be the same mechanism at two levels: precision sets *how loud* each channel's residual is, and a downstream normalisation over those gains produces the capacity-limited winner-take-most. A machine version — a per-channel learned log-precision, then a softmax over precision-weighted residuals — would be cheap to test and would give the wiki its first attention module whose "capacity" is a derived quantity rather than a hyperparameter.

---

## Value is redundant: goals as priors over sensory trajectories

The strongest architectural claim in the source, and the one that matters for [[wiki/concepts/simulation-based-planning.md]]:

```
loss           ≡  surprise                 (bounded by F)
expected loss  ≡  entropy                  (bounded by the path-integral A = ∫F dt)
```

Because action under value-learning optimises exactly the quantity active sampling optimises, **the value function can be deleted and replaced by prior expectations about sensory trajectories**. Action then simply enforces those priors, and desired states are frequented as a side effect. Optimal priors are installed by perceptual learning in a training environment.

| What this buys | Why |
|---|---|
| **Optimal control without access to hidden world states** | the priors are over *sensory* trajectories, which are observed; a value function is over states, which are not |
| **No Bellman solve** | the intractable step — solving for `V` — is replaced by fitting a generative model, which the system is doing anyway |
| Demonstration | the mountain-car problem, solved by active sampling with no value learning (Friston et al. 2009) |

| What it costs | Why |
|---|---|
| **Re-goaling is model surgery, not a swapped reward** | a new goal means new priors, i.e. editing the generative model — this is gap **G28** stated from the other side rather than closed |
| Priors must come from a training environment | the source concedes they are *learned in* rather than *derived*, so goal specification is displaced into curriculum design (**G32**) |
| Precision becomes load-bearing for action itself | action is called on only when predictions are precise |

The last row is a falsifiable clinical prediction: **low precision ⇒ small prediction errors ⇒ poverty of action**, which is the bradykinesia of Parkinson's disease and of neuroleptic administration. A machine analogue — an agent whose action magnitude collapses when its priors' inferred precision drops — is a cheap sanity check that a precision register is doing real work rather than being a fitted scalar.

---

## The dopamine reinterpretation

| Standard view | This proposal |
|---|---|
| Dopamine encodes the **prediction error on value** (RPE, `r + γV(s′) − V(s)`) | Dopamine encodes the **value of prediction error** — i.e. its precision, which is the *learning rate* in a Rescorla–Wagner model. Value ≡ precision ≡ incentive salience |

The proposed symmetry: **dopamine** optimises precision in anterior (mesocortical/mesolimbic) systems predicting proprioceptive and interoceptive sensation — which is what value-learning *is* under this reading — while **acetylcholine** optimises precision for hierarchical inference on exteroceptive input in posterior systems, which is attention. One computational role, two territories. This directly contests the "one modulator, one distinct function" taxonomy (dopamine = reward error, serotonin = reward timescale, noradrenaline = action randomness, acetylcholine = memory-update speed), which is now paged in full with its own primary source — [[wiki/concepts/neuromodulatory-metaparameters.md]] (Doya 2002) — and which supplies what this account does not: a *nucleus-specific* placement for each quantity and six explicit control laws for setting them. What it lacks in exchange is a single objective, so nothing guarantees the four-channel loop converges. The source lists reconciling the two as open (see T122).

**Why a builder should care about the disagreement.** The two readings put the same signal in different slots: an RPE dopamine is a *teaching signal* consumed by a plasticity rule, while a precision dopamine is a *gain register* consumed by the inference dynamics — and a gain register is exactly what gaps **G50** (controller cannot set the gain of its own teaching signal) and **G56** (no run-time gain register) say the wiki lacks. Under the precision reading the register is not missing; it is *inferred by gradient descent on the same objective as everything else*, which is the only self-setting proposal the wiki has. What is missing is an implementation.

---

## How to represent a posterior at all: the code taxonomy

The other durable contribution — a menu of probabilistic neuronal codes with an explicit scaling argument. `q(s)` is the recognition density over states `s = {x, v}`, `μ` its sufficient statistics, `Z(μ)` a partition function.

| Family | Code | Form | What encodes what |
|---|---|---|---|
| **Free-form** | Particle | `∫(s−c)^n q(s) ds = (1/N) Σ_i (μ_i−c)^n` | moments encoded by *sample* moments of `N` neurons = particles |
| | Convolution | `q(s) = (1/Z) Σ_i μ_i φ_i(s)` | activity = amplitude of fixed basis functions (tuning curves) |
| | Probabilistic population code (PPC) | `q(s) ∝ Π_i exp(φ_i(s)) φ_i(s)^{μ_i}/μ_i!` | independent Poisson variability; **precision encoded by firing gain** |
| **Fixed-form** | Explicit multinomial | `q(s=s_i) ∝ μ_i + c` | activity ∝ probability of each discrete cause |
| | Logarithmic multinomial | `q(s=s_i) ∝ exp(μ_i) + c` | log-probability; subsumes log-likelihood-ratio codes; the hidden-Markov / evidence-accumulation family |
| | **φ-normal (Laplace)** | `q(φ(s)) ∝ exp(−½ μᵀ Π(μ) μ)` | **mean encoded explicitly, precision implicitly as a function of the mean** |

The argument for Laplace, which is also the argument a builder is implicitly making whenever they emit a mean and a fixed variance:

- **Free-form does not scale.** Representing a face with ~30 attributes needs a 30-dimensional state space populated with more particles/basis functions than the brain has neurons. Sample-based posteriors are exponential in latent dimensionality; parametric ones are not.
- **Non-Gaussian is recoverable cheaply.** A nonlinear change of variables `φ(s)` gives log-normal, etc., without leaving the fixed-form family — so the expressiveness objection is weaker than it looks.
- **Multinomial codes cannot represent dependencies among states** — fine for categorisation and decision tasks, useless for a correlated continuous world.
- **Laplace is maximally economical**: the conditional precision is derivable *from* the mean, so only the mean needs an explicit substrate.
- **The price is unimodality — one thing at a time.** Ambiguous figures give *bistable* percepts, not bimodal ones, which the source reads as evidence the brain does the same. But bimodal *priors* are documented in sensorimotor learning, so the claim is confined to the recognition density and is explicitly flagged as the framework's most exposed assumption.

**Convergences worth noting:** in hierarchical hidden-Markov models, belief propagation *is* predictive coding; and PPCs encode precision by firing gain where Laplace encodes it by synaptic gain — the same quantity, two substrates. So the taxonomy is a choice of substrate for one commitment, not four rival theories.

**(brainstorm) Reading the taxonomy against [[wiki/concepts/latent-graph-discovery.md]].** The unimodality constraint is a direct statement about node identity: a Laplace-coded system *cannot hold two candidate graph positions open simultaneously* — it must relax into one. That is a feature for de-aliasing (G2: relaxation commits, so the state is never a blend of two nodes) and a defect for search (G15: you cannot maintain a frontier of candidate paths in the same register). The natural resolution is that the multinomial/log-probability family is the right code for *discrete graph position* and the Laplace family for *continuous content within a node* — which is the `g`/`x` factorisation reappearing as a choice of probabilistic code rather than as a choice of variables.

---

## Empirical coverage claimed (and what it is worth)

The source's Table 1 lists what falls out of the formulation: hierarchical cortical organisation; distinct state and error subpopulations; forward = error (superficial pyramids), backward = predictions (deep pyramids); forward linear / backward nonlinear asymmetry mandated by nonlinearities in the generative model; low-pass dynamics in prediction cells; intrinsic stability from error suppression ("no strong loops"); attentional gain as precision scaling; short-term gain modulation necessarily slower than neuronal dynamics; Hebbian plasticity recovered as the parameter update; event-related potentials as self-limiting transients with late components reflecting top-down suppression; larger responses to surprising stimuli; repetition suppression / mismatch negativity as learned attenuation of error units.

**Assessment.** This is post-hoc coverage, not prediction — the same list is claimed by several frameworks. The parts that are load-bearing here are the ones that are *derived and quantitative*: the frequency asymmetry between error and state units ([[wiki/concepts/predictive-coding-free-energy.md]]), the required timescale separation between gain and activity dynamics, and the attention sign flip. Everything else is compatibility.

---

## The same quantity, derived without Bayes

The strongest independent support for this page's central claim comes from a source with no probability distribution in it anywhere ([[wiki/entities/conceptor.md]], Jaeger 2014). A three-layer signal-processing hierarchy de-noises a pattern at SNR = 0.5 while classifying which of four generators produced it. Each inter-layer link carries one scalar `τ_{[l,l+1]} ∈ [0,1]`, adapted online from **locally observable noise ratios**, and it is read in exactly two places:

```
u_{[l]} = τ_{[l−1,l]}·y^auto_{[l]} + (1−τ_{[l−1,l]})·y_{[l−1]}     which signal the layer believes
c_{[l]} = (1−τ_{[l,l+1]})·c^auto_{[l]} + τ_{[l,l+1]}·c_{[l+1]}     which hypothesis the layer believes
```

`τ → 1` makes the layer ignore the input and self-generate; the author names the failure mode outright as **confabulation** — an entirely noise-free output produced under a possibly wrong top-level hypothesis. In the run, `τ` drops briefly at each change of generator, letting the outside permeate upward, then returns to ~1.

Two things this adds. First, the author's own generalisation is this page's thesis with the Bayesian scaffolding removed: *maintaining a measure of trust is an intrinsically necessary component in any signal processing architecture which hosts a top-down pathway of guiding hypotheses.* If that is right, precision is not a consequence of doing variational inference — it is a requirement of having a top-down pathway at all, and the free-energy derivation explains *a* system that needs it rather than *why* it is needed. Second, it is a **worked machine instance** of the reversal this page describes in the abstract: at high `τ` the prior wins outright and the data are discarded, and the architecture beats a linear filter with the same number of trainable parameters precisely because it is willing to do that.

What it does not supply: `τ` is estimated from signal-to-noise ratios by a hand-written online rule, not inferred by the same machinery that infers everything else — so the "one rule, three represented quantities" partition above is not replicated, only the role.

---

## Open problems

- **Is one role (precision) enough for all neuromodulators?** The rival taxonomy assigns distinct computations to dopamine, serotonin, noradrenaline and acetylcholine; this account assigns one computation in different territories. No experiment in the wiki separates them (T122).
- **Bayesian surprise vs. the free-energy bound.** Salience is empirically driven by observations that change beliefs (Bayesian surprise), not by rarity — formally relating that to the bound on Shannon surprise is unfinished, and it is exactly what a curiosity term needs.
- **Can the system entertain ambiguity?** No electrophysiological or psychophysical evidence for multimodal recognition densities is claimed to exist; the framework predicts there is none. This is a falsifiable, and currently untested, architectural commitment.
- **Gradient descent or stochastic search?** The whole scheme assumes deterministic descent on `F`, but eye movements look like an optimal *stochastic* search. Whether the optimiser is a descent or a sampler is open, and it is the difference between a relaxation network and a particle filter.
- **No human neural correlate of uncertainty *magnitude* has been found where the value of resolving it is measurable.** Per-timepoint regression of source-space power onto each expected-free-energy term separately recovers the value of reducing novelty and the value of reducing variability but nothing for the degree of either (Zhang et al. 2025, [[wiki/empirical-tensions.md]] T127). If precision has its own substrate, the substrate is not showing up alongside the quantities it is supposed to weight — though the null is underpowered, since the task never swept uncertainty magnitude.
- **Is one confidence scalar enough, when the variance has several sources?** The measurable version: regress the per-item confidence recovery after repair ([[wiki/entities/hle-verified.md]]) against the *defect category* — Q1 semantic ambiguity, Q3 missing information, Q5 notation corruption are three different variance sources. A system with one undifferentiated confidence output should not distinguish them; a system with a represented precision over latents should. The data exist and the regression has not been run.
- **Precision is inferred but never grounded.** Nothing says where the precision of a *prior* comes from at the top of the hierarchy — the same regress as the missing top-level prior, moved into the second-order statistics.
- **Some precisions behave as constants, and the theory does not say which.** The hollow-mask illusion is the clean case: the face-is-convex prior wins the accuracy/complexity trade even when the observer *knows* the mask is concave, so a correct reportable-level belief cannot lower that prior's precision (`talk-nd-free-energy-principle`, **(tentative)**). Under this page's partition every precision is a `μ^λ` optimised on the same path integral as the rest; an impenetrable prior is a `μ^λ` with the gradient cut. That is either an extra architectural fact the principle does not supply, or evidence that the second-order optimisation is confined to a subset of the hierarchy — logged as [[wiki/empirical-tensions.md]] T128. Note the practical upside: a frozen precision is the cheapest implementation of an installed prior ([[wiki/concepts/core-knowledge.md]]), and the illusion is its diagnostic signature rather than its defect.

---

## Connections

- **[[wiki/concepts/epistemic-value.md]]** — the fitted coefficients on the three expected-free-energy terms are precisions, and the human study there returns a null this page has to absorb: the *value of resolving* each uncertainty has a cortical correlate and the *degree* of it has none, which is the opposite of treating uncertainty as a first-class encoded quantity.

- **[[wiki/concepts/core-knowledge.md]]** — supplies the content this page could implement as second-order statistics: an installed prior is a latent whose prior precision is clamped above what evidence can move, which also predicts the impenetrable illusion that certifies the clamp exists (T128).
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the parent page: this one supplies the derivation *upstream* of its update rule (why free energy is the thing minimised, via ergodicity and the entropy of sensory states) and unpacks the `α, β, γ` precision gates into a represented quantity with its own substrate and timescale.
- **[[wiki/concepts/attention.md]]** — the rival account of the same phenomenon: selection by a normalised competition over a query, versus multiplicative gain on a residual with no denominator; the two differ on whether attention has a capacity limit by construction.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — where precision is physically placed: `Π` on the postsynaptic gain of the superficial pyramidal cell, which is what makes attention and prediction separable, opposed controls on one signal.
- **[[wiki/concepts/expected-free-energy.md]]** — the forward-looking half: this page says value is redundant because goals are priors over sensory trajectories; that page says what is left once the value function is gone is a linear latent-MDP reward plus one convex epistemic term.
- **[[wiki/concepts/simulation-based-planning.md]]** — the concrete cash value of deleting the value function: rollouts are scored against prior expectations over sensory trajectories rather than against a `V` that must be solved for, which removes the Bellman solve and moves the difficulty into where the priors come from.
- **[[wiki/concepts/synaptic-plasticity.md]]** — precision *is* the learning rate: read as the Rescorla–Wagner rate parameter, an inferred gain register is a plasticity rule that sets its own step size from its own uncertainty rather than from a schedule.
- **[[wiki/concepts/divergence-objectives.md]]** — supplies the quantity whose two readings this page turns on: the `F ≥ surprise` gap is a reverse KL, and the unimodality of the recognition density is that direction's mode-seeking behaviour rather than an independent assumption.
- **[[wiki/concepts/amortized-inference.md]]** — the code taxonomy is the same choice seen from the representation side: a free-form posterior is sample-based and scales badly, a fixed-form one is a small vector of sufficient statistics and is what an amortised recognition network can actually emit.
- **[[wiki/concepts/population-geometry.md]]** — the measurement counterpart of the taxonomy: whether a population encodes a distribution by sample moments, by basis amplitudes or by a mean-plus-implicit-precision is a question about the geometry of the recorded activity, and the three codes predict different intrinsic dimensionalities for the same latent.
- **[[wiki/concepts/dynamic-network-connectivity.md]]** — the biological gain register this page's precision would set: content-free, seconds-reversible multiplicative gating of individual synapses by dopamine, noradrenaline and acetylcholine, i.e. the substrate G56 asks for, here given a normative set-point rule.
- **[[wiki/entities/pbwm.md]]** — the wiki's implemented dopamine model and the contrast case: its PVLV term is a *teaching signal* delivered from outside the network, whereas precision-dopamine would be an inferred gain consumed by the inference dynamics themselves (T122).
- **[[wiki/concepts/latent-graph-discovery.md]]** — the code taxonomy lands on the framing as a substrate choice: discrete multinomial codes for graph position, Laplace codes for within-node content, with unimodality buying commitment (G2) at the cost of a maintained search frontier (G15).
- **[[wiki/concepts/contextual-inference.md]]** — the multimodal-posterior case this page's unimodality claim rules out: there, responsibility is genuinely split across context models and the resulting posterior is a mixture, which a Laplace code cannot express.
- **[[wiki/concepts/cognitive-control.md]]** — the top-down bias signal read as a precision: raising the gain on one channel's residual and biasing competition toward it are the same operation seen from the inference and the control sides.
- **[[wiki/concepts/expected-free-energy.md]]** — the fitted-precision reading made concrete and then partly undercut: the three coefficients scaling that page's `G` terms are estimated per participant as precisions over preferences and contingencies and vary widely across 25 people, so epistemic drive is an individual-differences parameter — yet the *degree* of uncertainty those precisions weight has no measurable correlate while the value of resolving it does (Zhang et al. 2025, T127).
- **[[wiki/entities/basal-ganglia.md]]** — the reason T122 can be left open without stalling: the striatal opponent architecture consumes a dopamine transient as a signed change in excitability *and* in plasticity across two receptor-typed populations, and would do so identically whether the transient is a reward prediction error or an inferred precision — so the mechanism is evidence for neither reading, and the review says as much (Gerfen & Surmeier 2011).
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the rival taxonomy stated in full, with its own source: four chemicals carrying four distinct reinforcement-learning quantities (`δ`, `γ`, `β`, `α`) instead of one computation in four territories. The disagreement is deeper than dopamine's content (T122) — it is whether a gain has a *derivation* (descent on one free energy, convergence inherited, biological specificity lost) or a *control law* (computed from the learning signal's own variance and sign oscillation, specific to a nucleus, convergence unaddressed) (Doya 2002).
- **[[wiki/concepts/amortized-inference.md]]** — the same inverse-variance logic applied one level up, at controller granularity rather than channel granularity, with one deliberate difference: Daw et al. 2005 take the *more certain* controller's estimate outright instead of blending, so reliability selects a source rather than setting a gain — which is what a system must do when the two estimates come from incompatible computations rather than from two views of one quantity.
- **[[wiki/concepts/evidence-accumulation.md]]** — a precision on the *evidence* rather than on a prediction error, with a property none of this page's precisions has: the optimal integrator gain is `g* = (μ⁺−μ⁻)/σ²`, and its cost is one-sided — overestimating it is free while underestimating it is bounded — so the correct policy is to saturate the gain instead of inferring it (Bogacz & Gurney 2007).
- **[[wiki/concepts/energy-based-models.md]]** — the page that arrives at this page's knob empirically from the other side: its top-down/bottom-up balance is a fixed temperature, and reading that temperature as a ratio of inverse variances is what turns it into a state-dependent, inferred gain.
- **[[wiki/concepts/reward-prediction-error.md]]** — the rival identity for the same firing record, stated as a page: an error on value consumed by a plasticity rule versus this page's inferred inverse variance consumed by the inference dynamics (T122), with the striatal mechanism indifferent between them.
- **[[wiki/entities/autotom.md]]** — confidence promoted from a weight to an *objective*: the negative entropy of a query's posterior, minus a variable count, is the whole criterion by which an agent model is grown and stopped — which is this page's Goodhart problem with nothing beside it, since no likelihood term ties the selected model back to the observations ([[wiki/empirical-tensions.md]] T189).
- **[[wiki/entities/conceptor.md]]** — precision arrived at from control theory rather than from variational inference: a per-link trust scalar adapted from local noise ratios, mixing bottom-up signal against a top-down hypothesis in a hierarchy with no generative model and no free energy — including this page's confabulation failure mode, named and demonstrated at `τ → 1` (Jaeger 2014).
- **[[wiki/entities/gpqa.md]]** — an unmeasured confidence result hiding in a capability benchmark: giving GPT-4 a search tool leaves accuracy flat (+0.7 points) while abstention rises from 4% to 37%, i.e. the retrieved evidence may have improved the system's estimate of its own uncertainty without changing its answers — and the reporting protocol backed off to the closed-book answer, discarding exactly that signal.
- **[[wiki/entities/hle-verified.md]]** — the wiki's first measurement separating *uncertainty about the answer* from *uncertainty about the question*: on items whose statement was broken, every one of seven frontier models reports lower confidence **before anyone tells it the item is broken**, recovering +1.83 to +11.08 points once the statement is repaired, against ≈0 shift on unchanged items. An underspecified problem is a high-variance likelihood, and the confidence field is partly reporting that variance rather than the model's own ignorance — which is the concrete payoff of treating precision as a represented quantity in a language model. It also revises the sibling entry below: 7–10 of HLE's RMS calibration points are the benchmark's noise, not the model's overconfidence.
- **[[wiki/entities/hle.md]]** — the wiki's largest direct measurement of the failure this page's machinery is supposed to prevent: 2,500 items, a confidence field required in every response, and RMS calibration error of 73–89% at 2.7–13.4% accuracy. The unrun follow-up is whether a reasoning trace is itself a precision signal — the two lowest calibration errors belong to the two reasoning models, and matched-subset re-scoring would say whether that is mechanism or arithmetic.
- **[[wiki/concepts/mean-field-reduction.md]]** — a candidate set-point rule for G50/G56 that is not a gain on a channel: in a sheet of coupled neural masses, the ratio of input coupling to internal coupling `C_sens/C_sheet` has two clean regimes — an incoherent sheet is *synchronised* by an input, a coherent one is *desynchronised* by the identical input and its spatial entropy rises — and driving the sheet's ongoing activity to zero suppresses the evoked response outright, so ongoing-activity level is a precision gate that needs no gating variable (Deco et al. 2008).
- **[[wiki/concepts/dynamic-repertoire.md]]** — a second candidate set-point from the same lineage, and one where the sign is counter-intuitive: the regulated quantity is *distance to the oscillatory-instability line*, and sitting comfortably far inside the stable region is a failure mode, because the oscillatory return that carries all the structure is then suppressed and noise produces nothing (Deco, Jirsa & McIntosh 2011).
- **[[wiki/concepts/metastability.md]]** — makes the set-point measurable rather than merely asserted: distance to the bifurcation is read off `σ_R`, the temporal variance of the global order parameter, computable from module activity alone with no weights, labels or task — and one scalar coupling gain moves the whole network across it.
- **[[wiki/concepts/default-self-model.md]]** — a candidate precision term with a lesion behind it: on Beer's bottom-up account, orbitofrontal cortex down-weights an optimistic self-prior against contextual constraints, and removing it produces a social-cognition illusion by exactly the mechanism that produces visual ones.
- **[[wiki/concepts/ignition.md]]** — the rival account of the same gate: a precision term multiplies a prediction-error channel continuously and graded, where ignition is discrete, exclusive and thresholded, so the two disagree on whether "what the system is currently working on" is a scalar field over channels or a single winner.
- **[[wiki/concepts/loopy-belief-propagation.md]]** — where precision comes from if integration is a decoding problem: each modality is a channel with its own noise model, so how much a message moves the joint estimate is set by the channel statistics rather than by a learned attention weight.
- **[[wiki/concepts/transthalamic-context-routing.md]]** — a candidate anatomical carrier for a precision term and the experiment that stops one step short: silencing a single thalamocortical projection removes a cortical area's arousal-dependent modulation without touching its sensory responses, which is the separated gain wire the theory wants — but visual responses were never split by behavioural state, so the multiplicative effect on the content stream is undemonstrated (Neske & Cardin 2025).
- **[[wiki/concepts/random-feedback-addressing.md]]** — a mechanism for the assumption this page cannot state: multiplicative gain on a prediction error presupposes the gain can be delivered where it belongs, and near-random reciprocal connectivity is how a unit with no way to *name* its target still applies gain to the right sensory population and to no other (Park & Serences 2025).
