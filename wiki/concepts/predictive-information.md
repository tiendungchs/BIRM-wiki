# Predictive Information

**Predictive information `I_pred(T)` is the mutual information between a stream's past (duration `T`) and its entire future. It equals the *subextensive* part of the block entropy, `S(T) − 𝒮₀T`. As `T → ∞` it does one of three things: it stays finite, it grows as `(d/2)·log T` with `d` the effective dimension of what is being learned, or it grows as a power `T^ν`, `ν < 1` (nonparametric). Only the divergent part, its class plus its coefficient or exponent, is invariant to how the stream is recoded locally. The paper argues it is the unique measure of how much there is to learn.**

[[wiki/concepts/causal-states.md]] covers the finite class: a stationary process whose past–future information `𝐄` is bounded and whose minimal predictive state carries `C_μ` bits. This page covers the classes where `I_pred` diverges. That is the regime of an agent sampling an **environment family**: each stream draws its own parameters, so there is always more to learn. This is the regime of [[wiki/concepts/latent-graph-discovery.md]]'s two-level hierarchy.

> **Provenance.** Bialek, Nemenman & Tishby 2001, *Predictability, complexity and learning* (Neural Computation 13:2409–2463; arXiv physics/0007070; `raw/bialek-2001-predictability-complexity-and-learning.md`). It is a theory paper. The only data are three simulated Ising chains of 10⁹ spins, and Shannon's and Hilberg's English-guessing results, which it cites second-hand. The clip is an ar5iv HTML conversion. The 20 footnotes are missing (only their markers survive). Equation numbers in the prose do not always match the displayed equations, so this page cites results by content, not by number.

---

## Formalism

The stream `x(t)` is observed for `−T < t < 0` (the past) and `0 < t < T′` (the future). It is stationary, so block entropies depend only on duration.

| Object | Definition | Reading |
|---|---|---|
| **Predictive information** | `ℐ_pred(T,T′) = S(T) + S(T′) − S(T+T′)` | Mutual information between past and future. It is symmetric, so prediction and postdiction carry the same information |
| **Extensive / subextensive split** | `S(T) = 𝒮₀T + S₁(T)`, with `S₁ ≥ 0` and `S₁/T → 0` | `𝒮₀` is the entropy rate (noise). It **cancels** from `ℐ_pred`: predictability is the deviation from extensivity |
| **Whole-future limit** | `I_pred(T) = lim_{T′→∞} ℐ_pred(T,T′) = S₁(T)` | The information a sample of length `T` gives about the *entire* future. It equals the information that sample gives about the entire past |
| **Relevant fraction** | `I_pred(T)/S(T) → 0` | **Almost everything observed is useless for prediction.** Isolating the predictive bits is most of the job |
| **Code length per new symbol** | `ℓ(N) = −⟨log₂ P(x_{N+1} \| x_1…x_N)⟩ = S(N+1) − S(N)` | The cost of the next symbol given the history, i.e. the per-position compression curve |
| **Universal learning curve** | `Λ(N) = ℓ(N) − 𝒮₀ = S₁(N+1) − S₁(N) ≈ ∂I_pred/∂N` | Excess code length over a learner with perfect knowledge. **Its integral is the predictive information** |
| **Link to the usual learning curve** | For regression with Gaussian noise, `⟨χ²(N)⟩ → (2 ln 2)·Λ(N) + 1` | Generalisation error in the right units is `Λ(N)` |

**Learning as statistical mechanics.** Draw parameters `α` from a prior `𝒫(α)` at the start of the stream, then draw samples i.i.d. from `Q(x|α)`. The subextensive entropy is a free energy:

```
S₁(N) = −⟨log₂ Z(ᾱ; N)⟩_ᾱ ,   Z(ᾱ; N) = ∫ dD · ρ(D; ᾱ) · e^{−N·D}
ρ(D; ᾱ) = ∫ d^Kα 𝒫(α) δ[D − D_KL(ᾱ‖α)]
```

Energy is the Kullback–Leibler divergence from the true model, temperature is `1/N`, and `ρ` is the density of models at divergence `D` from the target. Collecting data **cools** the system toward the target. The whole asymptotic story is the behaviour of `ρ(D)` as `D → 0`.

---

## The three classes

| Class | `I_pred(N→∞)` | Mechanism | Examples in the source |
|---|---|---|---|
| **Finite** | Constant | Nothing new to learn: the dynamics are too regular, or correlations have finite range | Periodic orbits (constant ≈ log of the period). Markov chains: `I_pred = ⟨log₂ P(x_n\|x_{n−1})/P(x_n)⟩` ≤ log(number of states). Ising chain with fixed coupling |
| **Logarithmic** | `(d/2)·log₂N` | Finite-dimensional model: `ρ(D→0) ∝ D^{(d−2)/2}` | `K`-parameter regression: `S₁ → (K/2)log₂N`, independent of the basis functions and, to leading order, of the prior. Ising chain whose coupling is redrawn every 400,000 spins. The onset of chaos (Grassberger) |
| **Power law** | `∝ N^{μ/(μ+1)}` | An essential singularity `ρ(D→0) ≈ A·exp(−B/D^μ)`: the effective parameter count grows as `N^ν`, `ν = μ/(μ+1) < 1` | Smooth 1-D density with a field-theory prior: `S₁ ≈ (1/2ln2)·√N·(L/l)^{1/2}`, i.e. the number of adaptive bins of width `√(l/NQ(x))` that fit in the range. Ising chain with long-range couplings of variance `1/(i−j)²`. Cellular automata capable of universal computation (Grassberger). **Written English: Hilberg's reanalysis of Shannon's guessing data gives `S₁ ∝ N^{1/2}`**, and Moby Dick letter statistics show the same strong subextensive term |

Rules the paper derives that a builder can use:

- **The log coefficient counts effective dimensions, not parameters.** It is the phase-space dimension `d` defined by `ρ ∝ D^{(d−2)/2}`, which is smaller than `K` when the Fisher matrix is degenerate (a redundant parameterisation). Parameters that can be traded for one another are not charged.
- **The asymptote holds only for `N ≫ d_VC`** (VC dimension, see [[wiki/glossary.md]]). With `d_VC = ∞` at finite `K` (the paper's example is `Q(x|α) ∝ exp(−sin αx)`) and a wide prior, early data are better fitted by a wrong, large `α`. Learning then stalls until the data overwhelm the prior box and collapses suddenly onto the truth. **No uniform `N` exists at which this happens**, and the paper expects "aha!" phase transitions in such classes. A model class with unbounded capacity therefore predicts *abrupt* learning curves by construction.
- **Too much freedom is as bad as too little.** As `μ → ∞` (bins grow in proportion to samples) the subextensive term becomes extensive and predictive information vanishes. Learning is impossible.
- **Unknown parameters and long-range correlations are interchangeable.** If the conditional process itself has `𝒮₀* = (K*/2)log₂N`, then `S₁ = ((K+K*)/2)log₂N`. A mean-field magnet can be described either way, exactly. From the stream alone, "a hidden parameter held fixed" and "long memory in the dynamics" are information-equivalent.
- **Predictive codes beat two-part codes once parameters grow.** In the paper's reading of Rissanen et al. 1992: when the parameter count grows with `N`, a code that is optimal at each `N` (prequential) is strictly shorter than a nonpredictive code optimised for all the data at once. For finite-parameter classes the two are asymptotically equal.

---

## Why only the divergent part counts (the uniqueness argument)

| Constraint on a complexity measure | What it removes |
|---|---|
| Shannon's three axioms, applied to an ensemble | Leaves the entropy `S(T)` |
| Invariance to *instantaneous* coordinate changes of `x` | The extensive term `𝒮₀T` (a continuous variable's entropy depends on its units; mutual information does not) |
| Invariance to *temporally local* transformations (mixing within a window `τ ≪ T`), equivalently to the choice of a reference distribution built from **local operators** | **Constant subextensive terms**, which such transformations change |
| What survives | **The divergent subextensive term: its class plus its coefficient or exponent** |

The polymer analogy makes the point concrete. The number of `N`-step lattice walks is `𝒩 ∼ A·N^γ·z^N`. The term `log₂z` is lattice-dependent, `log₂A` is lattice-dependent, and only `γ·log₂N` is universal. A one-dimensional reference distribution built from local operators has no phase transition. So any choice of local "expectations" (spelling-error models, word-level statistics) changes only the extensive and constant parts. Two readers who differ on the global topic of a text may legitimately disagree about its richness. Two readers who differ only on local spelling may not.

**Placement among complexity measures** (the paper's own survey):

| Measure | Relation to `I_pred` |
|---|---|
| Kolmogorov complexity | Dominated by the extensive term, so it measures randomness |
| Thermodynamic depth (Lloyd & Pagels) | Does not fully discard the extensive term |
| Excess entropy / effective measure complexity | `lim I_pred`. Finite only in the finite class. The paper's objection is that this covers only that class (Shalizi & Crutchfield's excess entropy) |
| Statistical complexity `C_μ` = true measure complexity (Grassberger) | The entropy of the **minimal** compression of the past that keeps all of `I_pred`. It bounds logical depth from below, since decoding must read it |
| Rissanen's model complexity / stochastic complexity | Equals `S₁` to leading order, `(K/2)log₂N` in the parametric case. The difference: minimum description length (MDL) is an inference procedure with a complexity *penalty*, whereas here inference is purely Bayesian and `I_pred` is a property of the data ensemble. `I_pred` also separates infinite-VC and nonparametric classes, which MDL's asymptotics do not |

The paper rejects `C_μ` and excess entropy as **the** complexity measure because they are constant subextensive terms. The wiki uses `C_μ` as the `L0` target for de-aliasing. The disagreement is logged as [[wiki/empirical-tensions.md]] `T409`.

---

## The biological claims

| Claim | Content | Status |
|---|---|---|
| **Efficient coding of the predictive bits** | Nonpredictive information is useless to an organism, because action takes time. The nervous system should therefore represent the *predictive* information efficiently, not the current state (contrast Attneave/Barlow redundancy reduction). Test: does a neuron's information about the stimulus *future* reach the bound set by the input statistics, given the bits it holds about the past? | Proposed, not tested in the source |
| **Learning efficiency** | A human's `Λ(N)` is bounded by the stimulus series' own `I_pred`. The ratio defines an efficiency of learning in Barlow's sense. Efficiency may fail at a critical task complexity, which would bound the complexity of the brain's internal models | Proposed. The paper lists the paradigms (saccade reaction times after a probability switch; Saffran-style statistical learning; Markov-vs-random discrimination) |
| **Biology operates at `N ≪ N_c`** | A model with `K` parameters beats a nonparametric one with `I_pred ∼ A·N^ν` only past `N_c ∼ [(K/2Aν)·log₂(K/2A)]^{1/ν}`. 10 mm² of inferotemporal cortex holds `K ∼ 5×10⁹` synapses, while foveations over ~10 waking years give `N ≲ 10⁹` examples. So **learning succeeds only through priors that are sensible over the space of models** | An order-of-magnitude argument |
| **Language is in the power-law class** | `S₁ ∝ N^{1/2}` from Shannon's guessing data (Hilberg) | Second-hand. The paper asks for a re-run designed to detect subextensive terms at large `N` |

---

## What it says for building a reasoning model

| Consequence | Detail |
|---|---|
| **Every stream splits into three budgets** | `S(N) = 𝒮₀N` (noise; nothing learns it) + constant (structure a fixed model already predicts) + divergent (what this stream still has to teach). **(brainstorm)** In the wiki's hierarchy, a *known* meta-graph lives in the constant term, and instance binding is the `(K_inst/2)log₂N` divergence. Apply the per-parameter price separately to each group: meta-parameters inform all `E` episodes and cost `(K_meta/2)·log₂(EN)` bits, while instance parameters are re-paid every episode at `(K_inst/2)·log₂N`. That is the "MDL: `\|θ_shared\| + N·\|θ_inst\|`" line on [[wiki/concepts/latent-graph-discovery.md]] with its prices filled in. It assumes the regularity conditions above hold for each group |
| **A task family has a growth class, and the class is an `L0` property** | Finite (a fixed graph under fixed observations), logarithmic (fixed meta-graph, finite instance parameters) or power-law (the instance graph grows with exposure). **(brainstorm)** The class says which learners can profit: a finite-class benchmark saturates once the graph is synchronised, so it cannot discriminate learners at large `N`. A power-law family has no parametric asymptote in reach (`N ≪ N_c`), so priors decide the score. This is an ensemble-defined quantity for "how much there is to learn" that is not built on Kolmogorov complexity (`G31`), though it is not developer-aware |
| **A model-free ceiling on learning speed** | For any predictor, expected cumulative code length is `≥ S(N)`, so its cumulative excess over `𝒮₀N` is `≥ I_pred(N)`. On a synthetic family with known `𝒮₀` and `I_pred`, `η(N) = I_pred(N) / [L_model(N) − 𝒮₀N] ∈ (0,1]` is a learning efficiency in bits **(brainstorm)**. The in-context compression-vs-position curve on [[wiki/concepts/prediction-compression-equivalence.md]] is `ℓ(N)`, and its excess over `𝒮₀` is `Λ(N)`. Registered as certification instrument `I49` |
| **The per-parameter price is `½·log₂N` bits** | On a parametric class, each *effective* parameter costs `½log₂N`. At `N = 10⁹` that is ≈15 bits, close to the 16 bits a float16 charge assigns. **(brainstorm)** So the 14008% adjusted rate on [[wiki/concepts/prediction-compression-equivalence.md]] (`G35`) is not mainly an artefact of crude accounting. The escape routes the theory names are the effective dimension `d ≪ K` (degenerate Fisher directions are free) and predictive (prequential) coding, which is strictly shorter once the parameter count grows with data. Caveat: Chinchilla's 70 B parameters exceed enwik9's 10⁹ bytes, so `N ≫ d_VC` fails and the asymptotic price does not apply as stated |
| **Abrupt learning is expected, not anomalous** | Infinite-capacity classes with wide priors have no uniform convergence point and show sudden transitions in performance against `N`. **(brainstorm)** A sudden late jump in a learning curve diagnoses the model class. It is not evidence of a separate discovery mechanism |
| **Store versus dynamics is invisible in the stream** | `K + K*` equivalence: predictability from a fixed hidden parameter and from intrinsic long-range correlation give the same `S₁`. **(brainstorm)** The environment-side counterpart of `G112`'s carrier non-identifiability: whether the fast level holds an instance variable in a separate store or in long-memory activity cannot be read off the information the stream supplies (`T2`) |
| **The node set as the most efficient compression of `I_pred`** | The paper proposes defining order parameters as the variables that compress predictive information most efficiently. This is the information bottleneck with `X` = past and `Y` = future. **(brainstorm)** It is a criterion for the coarse variables that should become graph nodes (`G27`). At the maximal-information end it is the causal-state partition |

---

## Open problems

- **No estimator at scale.** `S₁` is a small correction to a large extensive term. The Ising demonstration needed 10⁹ samples, and the power-law exponent for language rests on one reanalysis of guessing data.
- **The power-law class has one worked case.** Only the 1-D smooth density with a field-theory prior is computed in full. The prior's length scale `l` enters the coefficient, and a scale-free (coordinate-invariant) version is conjectured, not shown. Higher dimensions and other smoothness penalties are heuristic ("smoother → smaller power, higher dimension → larger power").
- **Passive and stationary only.** The future being predicted does not depend on the predictor's actions. In an active agent the stream is policy-dependent, so `I_pred` is a property of the policy–environment pair (`G63`, as on [[wiki/concepts/causal-states.md]]).
- **The efficiency experiments were never run** in the source. Neither the predictive-coding-of-the-future test on a sensory neuron nor `Λ(N)` for a human learner is measured.
- **Fluctuation control is proved only for finite `d_VC`.** The infinite-VC and nonparametric cases rest on structural risk minimisation arguments deferred to a thesis (Nemenman 2000).

---

## Connections

- **[[wiki/concepts/causal-states.md]]** — the finite class of this page. Excess entropy is `lim I_pred` when that limit is finite, and `C_μ` is the entropy of the minimal past-compression that keeps all of `I_pred`. This page classifies the divergent regime that page lists as "infinite machines". It also argues that only the divergent part is description-invariant, which is the opposite of that page's use of `C_μ` as the structure measure (`T409`).
- **[[wiki/concepts/information-bottleneck.md]]** — the same authors' method applied with `X` = past and `Y` = future: the optimal compression curve of `I(x̂_past; x_future)` against `I(x̂_past; x_past)`, bounded by `I_pred`. The paper also states that generically no compression keeps all predictive information, except when sufficient statistics exist.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — gives that page's per-position compression curve a theory: `ℓ(N) = S(N+1) − S(N)`, its excess over the entropy rate is the universal learning curve, and the integral of that excess is bounded below by `I_pred`. It also prices a parameter at `½log₂N` bits, which bears on the two-part-code failure that page records.
- **[[wiki/concepts/universal-induction.md]]** — the ensemble, parametric counterpart of Solomonoff's bound. A computable `µ` has finite description, so the cumulative squared prediction error of the mixture stays below `ln 2·K(µ)`. A real-valued parameter has unbounded description, and specifying it to the precision the data support costs `½log₂N` per dimension. That is why `I_pred` diverges here and Solomonoff's sum converges.
- **[[wiki/concepts/latent-graph-discovery.md]]** — measures the two-level hierarchy in bits. The entropy rate is unlearnable noise, the constant term is what a known meta-graph already predicts, and the divergent term is the instance binding left to learn, at `½log₂N` bits per effective instance parameter (brainstorm).
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — supplies a computable denominator for learning efficiency: a learner's excess code length set against the stream's own `I_pred`, in Barlow's sense. The class and coefficient of `I_pred` give an ensemble quantity for "how much there is to learn" that is not built on Kolmogorov complexity (`G31`).
- **[[wiki/concepts/inductive-bias.md]]** — the `N ≪ N_c` argument: with more synapses than lifetime examples, the brain sits where a nonparametric class out-predicts any parametric one, so learning succeeds only through priors over models. This is Baxter's point that the bias, not the data, carries the load, reached from the sample count rather than from the task count.
- **[[wiki/concepts/certification-instruments.md]]** — supplies `I49`, the learning-efficiency ratio against a known `I_pred`. It certifies the *rate* at which a model extracts what a stream offers, not which structure it holds.
