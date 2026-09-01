# Environment Invariance

**A correlation is causal to the degree it is invariant across environments; the learnable target is therefore a representation `Φ` whose *optimal classifier is the same in every environment* (Arjovsky, Bottou, Gulrajani & Lopez-Paz 2019).**

This is the formal statement of the answer [[wiki/concepts/shortcut-learning.md]] and gaps `G6`/`G16` had been carrying informally ("multi-environment invariance, under assumptions"). It supplies what the informal version lacked: a definition, a differentiable objective, a theorem naming exactly how much environment diversity is required, and a task where empirical risk minimisation scores **below chance**.

> **Provenance.** Arjovsky et al. 2019 (`raw/arjovsky-2019-invariant-risk-minimization.md`), *Invariant Risk Minimization* (IRM).

---

## The principle

**Definition (invariant predictor).** `Φ : X → H` elicits an invariant predictor `w ∘ Φ` across environments `E` if one classifier `w` is simultaneously optimal for every `e ∈ E`:

```
w ∈ argmin_w̄ R^e(w̄ ∘ Φ)   for all e ∈ E
```

For squared error and cross-entropy the optimal classifier is a conditional expectation, so this is equivalent to the *testable* condition

```
E[Y^e | Φ(X^e) = h] = E[Y^e' | Φ(X^e') = h]    for all e, e', all h in the shared support
```

The objective to be minimised is worst-case rather than average risk — `R^OOD(f) = max_{e ∈ E_all} R^e(f)` — over *all* environments, including hypothetical ones, not only the sampled `E_tr`.

**Why this is the wiki's framing and not a new one.** In [[wiki/concepts/latent-graph-discovery.md]] terms: `Φ` is the node vocabulary and `w` is the edge set. IRM says the meta-graph is *what survives every instance*, and the environment index is the only observable that separates a stable edge from a spurious one.

---

## The reference failure and why four standard objectives fall to it

**Example 1 (SEM).** `X₁ ← N(0, σ²)`; `Y ← X₁ + N(0, σ²)`; `X₂ ← Y + N(0,1)`. So `X₁` causes `Y` and `X₂` is an *effect* of `Y`.

| Regressor | Coefficients | Invariant? |
|---|---|---|
| `X₁` alone | `α₁ = 1`, `α₂ = 0` | **Yes** — the only environment-independent fit, and the only one with finite `R^OOD` (let `X₂ → ∞`) |
| `X₂` alone | `α₂ = σ(e)²/(σ(e)² + ½)` | No — depends on `e` |
| `(X₁, X₂)` | `α₁ = 1/(σ(e)²+1)`, `α₂ = σ(e)²/(σ(e)²+1)` | No |

| Objective | What it does | Why it fails here |
|---|---|---|
| **ERM** (pool the environments) | minimise mean risk | Assigns large weight to `X₂` whenever the pooled `σ²(e)` is large; infinite `R^OOD` |
| **Robust learning** `max_e R^e − r_e` | minimise worst training-environment risk | **Prop. 2:** under KKT conditions its minimiser is a stationary point of `Σ_e λ_e R^e` — a *weighted ERM*. Buys **interpolation** across the training environments (`σ ∈ [10,20]`), never extrapolation |
| **Domain adaptation** (match `P(Φ(X^e))`) | match feature *marginals* | Enforces the wrong invariance: `P(X₁^e)` and `P(Y^e)` legitimately change across environments |
| **ICP** (Peters et al. 2016) | match residual *distributions* per environment | Fails when the noise variance of `Y` changes; also needs Gaussianity, a causal graph over observables, and scales exponentially in variables |

The negative result that matters for this wiki: **robustness is not invariance.** A min-max objective over environments is algebraically a re-weighted ERM, so every "train on the hardest environment" scheme inherits ERM's shortcut. Invariance is the strictly stronger requirement, and it is the one that buys extrapolation.

---

## IRMv1: from a bi-level problem to one penalty

The constrained form is bi-level (each constraint calls an inner optimisation). The practical objective is

```
min_Φ  Σ_{e ∈ E_tr}  R^e(Φ)  +  λ · ‖ ∇_{w|w=1.0} R^e(w · Φ) ‖²
```

with `λ ∈ [0, ∞)` trading predictive power against invariance, and `w = 1.0` a **fixed scalar dummy classifier** whose gradient norm measures how far `w` is from optimal in environment `e`. Three derivation steps, each of which is a reusable design lesson:

| Step | Move | Why |
|---|---|---|
| 1. Penalty choice | reject `D_dist = ‖w − w^e_Φ‖²`, use `D_lin = ‖E[ΦΦᵀ]w − E[ΦY]‖²` | `D_dist` is **discontinuous exactly at the invariant solution** (as the spurious coefficient `c → 0`, the least-squares rule compensates with `w^e → ∞`) and also decays as `‖c‖ → ∞`. Undoing the matrix inversion — measuring *violation of the normal equations* rather than distance between solutions — makes the penalty a polynomial with an easy minimum at `c = 0` |
| 2. Fix `w` | search only over `Φ` | `(γΦ, w/γ)` drives `D_lin → 0` with the ERM term untouched, so the pair is over-parametrised; for any invertible `Ψ`, `w∘Φ = (w∘Ψ⁻¹)∘(Ψ∘Φ)`, so `w` can be *chosen* |
| 3. Make `w` scalar | `Φ ∈ R^{1×d}`, `w̃ = 1.0` | **Theorem 4:** `v = Φᵀw` is a linear invariant predictor **iff** `vᵀ∇R^e(v) = 0` for all `e`. Rank-1 representations suffice to express any linear invariant predictor |

Minibatch estimator of the squared gradient norm: multiply the per-example `w`-gradients from **two independent minibatches** of the same environment — the product of two unbiased estimates of the gradient is an unbiased estimate of its squared norm, whereas squaring one minibatch's gradient is not.

**Geometry, and the cost.** Each orthogonality condition `vᵀ∇R^e(v) = 0` is a `(d−1)`-manifold (an ellipsoid, under squared loss); their intersection has several connected components and **one of them contains the trivial `v = 0`**. IRMv1 is therefore non-convex and initialisation-sensitive — the objective identifies the invariant set, it does not deliver it.

---

## What the guarantee buys

**Assumption 8 (linear general position, degree `r`).** `|E_tr| > d − r + d/r`, and the environments' `E[X^eX^eᵀ]x − E[X^eε^e]` span more than `d − r` dimensions for every non-zero `x`. Intuition: each new non-collinear environment removes one degree of freedom from the space of invariant solutions. The set of cross-product matrices violating it has **measure zero** (Theorem 10).

**Theorem 9.** With `Y^e = Z₁^e·γ + ε^e` (`Z₁ ⊥ ε`, `E[ε] = 0`) and `X^e = S(Z₁^e, Z₂^e)` for a scrambling `S` whose `Z₁`-component is left-invertible: if `E_tr` lies in linear general position of degree `r = rank(Φ)`, then invariance across `E_tr` **iff** invariance across `E_all`.

| Novelty vs. ICP | Consequence for a builder |
|---|---|
| No Gaussianity, no causal graph over observables, no restriction on intervention type | Applicable where "what causes what" is not even askable — pixels |
| Handles **scrambled** observations `S ≠ I` | The causal variables need not be observed features; IRM must *recover and filter a latent* — i.e. it is node-vocabulary discovery (`G4`, `G27`), not feature selection |
| Higher-rank `Φ` needs **fewer** environments (`d − r + d/r` falls as `r` grows) | Do not compress before enforcing invariance; a rank-preserving representation destroys less and costs less environment diversity |
| Objective differentiable in the environment covariances | Approximate invariance ⇒ approximately invariant solution. Unlike causal-discovery methods thresholding hypothesis tests, mild misspecification degrades gracefully rather than flipping a decision |

---

## Evidence

**Colored MNIST.** Label `ỹ = 1[digit ≥ 5]`, flipped with p = 0.25 (so digit shape is only 75% predictive); colour set by flipping `y` with `p^e ∈ {0.2, 0.1}` in training and **0.9** at test — the correlation's *sign* reverses.

| Algorithm | Train-env acc. | Test-env acc. |
|---|---|---|
| ERM | 87.4 ± 0.2 | **17.1 ± 0.6** (below chance) |
| IRM | 70.8 ± 0.9 | **66.9 ± 2.5** |
| Random guessing | 50 | 50 |
| Optimal invariant model | 75 | 75 |
| ERM on grayscale (oracle) | 73.5 ± 0.2 | 73.0 ± 0.4 |

Two readings the wiki should keep. (1) **Below chance is the signature of a shortcut, not of failure to learn** — the same diagnosis [[wiki/entities/bib.md]] and [[wiki/entities/agent-benchmark.md]] make from anti-correlated scores. (2) **IRM buys o.o.d. accuracy by giving up in-distribution accuracy** (87.4 → 70.8). Any model-selection procedure that ranks on pooled validation error will reject the invariant model; the paper cross-validates `λ` on a *held-out environment*, which is the only honest protocol and is itself a demand for environment diversity.

Invariance is **approximate, and worst at the tails** of `P(h)`: with few samples where `P(h)` is small, differences in `P(y|h,e)` are hard to estimate and hence hard to minimise. And `P(y=1|h)` is visibly non-linear in `h`, so the linear-`w` restriction is binding in practice, not only in theory.

**Synthetic (8 setups: scrambled/unscrambled × fully/partially observed × homo/heteroskedastic, 3 environments, 1000 samples each).** IRM recovers causal weights orders of magnitude more accurately than ERM (log-scale axes) and beats ICP by a large margin in every condition. ICP behaves conservatively — rejecting most covariates as causes gives it small non-causal weights and large causal-weight error, which is the shape of a method optimised for precision on a problem that needs recall.

---

## Invariance as causation — and the escape from causal graphs

A predictor is invariant across `E_all(C)` **iff** it attains optimal `R^OOD` **iff** it uses only the **direct causal parents** of `Y`: `v(x) = E_{N_Y}[f_Y(Pa(Y), N_Y)]`. Environments are interventions on a shared SEM; *valid* interventions are those keeping the graph acyclic, leaving `E[Y|Pa(Y)]` unchanged, and keeping `V[Y|Pa(Y)]` finite (a relaxation of ICP, which forbids touching `Y`'s noise at all).

**Why this framing beats a graph for our purposes.** Two arguments the wiki should adopt:

- **Laws that are invariant but not structural.** `PV = nRT` and `F = Gm₁m₂/r²` are prominent invariances that no SEM states comfortably (*what causes what?*). Invariance is the more general notion; the causal graph is one way to certify it.
- **Causation does not happen between pixels.** For perceptual input the causal graph over observables is meaningless. Invariant correlations in images are a *proxy* for causation among the real-world concepts the camera captured — which means recovering latents is mandatory, and IRM's scrambled-observation setting is the honest one. This is precisely `G27` (nothing supplies the discretisation) meeting `G6`: **invariance is a criterion for a good node vocabulary, not only for a good edge set** — and the wiki's first objective that scores a representation by something other than its predictive sufficiency.
- **The whole graph is rarely the goal.** "In rare occasions we are truly interested in the entire causal graph." The target is the *invariances that improve generalisation*, which licenses a much cheaper object than full structure learning.

---

## Two things that are already doing this, unlabelled

The min-max objective (18) is expensive and needs `E ⊂ ℙ_G` to be supplied. Schölkopf et al. 2021 read three standard pieces of machine-learning practice as approximations to it, which reframes them as **environment authoring** rather than as regularisation:

| Practice | What it approximates | What it cannot do |
|---|---|---|
| **Pre-training on a huge diverse corpus** | enriches `P(X,Y)` so that ERM's single environment already contains information about other members of `ℙ_G` | Still plain ERM; helps only if the enriched distribution happens to cover the test environment, which is untestable a priori |
| **Data augmentation** | *specifies* a set of interventions `E` the model must be robust to (crops, rotations, flips), then relaxes the max to an expectation by sampling from them | The invariance must be **named in advance** — the same limitation [[wiki/entities/stylized-imagenet.md]] pays, and exactly what the IRM formulation avoids |
| **Self-supervision / pretext tasks** | learns about `P(X)` so few labels suffice downstream | The pretext task is hand-designed; the source's proposal is to *derive* pretext tasks from the ICM principle instead, which nobody has done |
| **Adversarial training** | the one that optimises (18) literally, with `ℙ_G` the attack set rather than a set of natural interventions | The attack set is an `l_p` ball, i.e. a crude model of human robustness rather than of the world's interventions |

**The reading for a builder.** Augmentation and IRM sit at opposite ends of one axis: augmentation names the nuisance and manufactures the environment, IRM names neither and pays for it in environment count. Nothing in the wiki occupies the middle — a method that *discovers* which transformations are nuisances from a non-stationary stream — and that middle is where [[wiki/concepts/independent-causal-mechanisms.md]]'s Sparse Mechanism Shift hypothesis lives.

---

## The other identification lever: restrict the function class

Environment diversity is not the only way to make a causal structure identifiable, and for the two-variable case it is not even available (conditional independence is a ternary notion, so `n = 2` has no non-trivial Markov implications). Restricting the *function class* breaks the cause/effect symmetry instead: a distribution generated by an additive noise model `Y = f(X) + V` cannot be fit by an additive noise model in the reverse direction, except when `f` is linear and the noises Gaussian (Hoyer et al. 2009; Peters et al. 2014; Schölkopf et al. 2021). It generalises to nonlinear rescalings, loops, confounders and multi-variable settings.

This costs **one** distribution rather than `d − r + d/r` of them, and it is orthogonal to everything on this page — but it has been lifted only to pairwise causal-direction classification, never to "rich hierarchies of latent causal variables", which is the only case this wiki needs. Details and the identifiability table at [[wiki/concepts/independent-causal-mechanisms.md]].

---

## Open problems

- **No nonlinear general position.** The authors could not state, let alone prove, the analogue of Assumption 8 for nonlinear `Φ`. Every guarantee here is linear; every experiment that matters (Colored MNIST) is not covered by any theorem.
- **The environment-count gap.** Theorem 9 needs `|E_tr|` to scale *linearly with the parameter count of `Φ`* — hopeless at scale. Experiments recover the invariance with **two**. The proposed explanation (problems where `E[Y^e|Φ(X^e)]` cannot match across two environments unless `Φ` is causal) is a conjecture, and identifying that problem class is named as the route to a learning theory of invariance.
- **Linear `w` admits non-invariant solutions.** The null representation `Φ₀ = 0` makes every linear `w` optimal, so `D_lin = 0`, yet `w ∘ Φ₀` is not invariant when `E[Y^e] ≠ 0`. Only the ERM term rejects it. Enforcing invariance over a *larger* class `W` should discard more non-invariant predictors with fewer environments — no penalty `D` for nonlinear `W` is known. **This is the same collapse-outlawing bookkeeping that [[wiki/concepts/representational-collapse.md]] and `G34` describe: an invariance penalty, like every joint-embedding objective, is trivially satisfied by representing nothing.**
- **Who supplies the environment partition?** IRM is *given* `E_tr`. Nothing here infers it, and splitting a dataset by an arbitrary conditioning variable can manufacture spurious correlations and destroy the invariance of interest. `G6` stays open for exactly this reason.
- **Disjoint supports.** If `P(X^e)` have disjoint supports across environments there is no a-priori reason a predictor generalises outside their union; IRM's stated defence is that a *simple* invariant `w` (linear) may extrapolate. The paper's own dialogue floats the better version and does not pursue it: **assume compositional structure in `w` instead of linearity**, since compositional assumptions are exactly what let one learn in one region of input space and evaluate in another (`(brainstorm)` — this connects [[wiki/concepts/compositionality.md]] to o.o.d. identifiability as a *substitute* for environment diversity, which no page in the wiki currently claims).
- **Causal or anticausal supervised learning?** Whether `P(Y^e|X^e)` is stable in ordinary supervised learning is disputed inside the source itself ([[wiki/empirical-tensions.md]] T297), and the answer decides whether ERM's success is principled or lucky.

---

## Connections

- **[[wiki/concepts/shortcut-learning.md]]** — supplies the formal object that page's "domain generalisation" route only named: a testable invariance condition, a differentiable penalty, and the theorem stating how many environments the identifiability argument costs (`d − r + d/r`).
- **[[wiki/concepts/latent-graph-discovery.md]]** — the environment index is the observable that separates a meta-graph edge from an instance edge; IRM is the loss-side statement of the two-level hierarchy, with `Φ` as vocabulary and `w` as edge set.
- **[[wiki/concepts/causal-model-building.md]]** — the rival definition of what makes a model causal: *invariance* rather than *resemblance to the generative process*, which reaches laws (`PV = nRT`) that no structural equation model states and needs no causal data of the right type.
- **[[wiki/concepts/objective-identifiability.md]]** — the loss-lever answer to non-identifiability: an environment family plus an invariance penalty is the one construction that provably narrows the solution set, one degree of freedom per non-collinear environment.
- **[[wiki/concepts/meta-learning.md]]** — the same multi-environment signal read as an outer loop; IRM enforces invariance directly instead of via adaptation speed, so it needs no inner-loop update and cannot exploit fast adaptation as a causal signal.
- **[[wiki/concepts/representational-collapse.md]]** — the null representation `Φ₀ = 0` satisfies the invariance penalty exactly, so an invariance objective needs an ERM term to outlaw collapse for the same reason a joint-embedding objective needs three (`G34`).
- **[[wiki/concepts/divergence-objectives.md]]** — the constructive complement: cross-entropy on one environment cannot separate a shortcut from the intended rule because it is a functional of `Q` alone; IRM adds a term that is *not* a functional of the pooled predictive distribution, and that is exactly what the separation costs.
- **[[wiki/concepts/contextual-inference.md]]** — the missing half: IRM is handed the environment partition, whereas contextual inference is the machinery that would have to *infer* it; wiring the two together is the shape of a system that closes `G6` rather than assuming it away **(brainstorm)**.
- **[[wiki/concepts/compositionality.md]]** — the source's own alternative to environment diversity: a compositional restriction on `w` would license extrapolation to regions where no environment has support, which is where invariance alone gives no guarantee.
- **[[wiki/entities/mlc.md]]** — the same identifiability argument realised by *presentation* rather than by penalty: resampling the latent mapping per episode makes stored associations worthless, which is environment diversity paid for in the sampler instead of in the loss.
- **[[wiki/entities/simsiam.md]]** — invariance built into the architecture rather than penalised in the loss: weight-sharing across two augmented views is argued to be an inductive bias for augmentation-invariance in the same sense convolution is one for translation-invariance, and the code it converges on is identified as the augmentation-averaged representation `E_T[f(T(x))]`.
- **[[wiki/entities/bib.md]]** — supplies the diagnostic reading of Colored MNIST's 17.1%: below-chance accuracy is evidence of an anti-correlated shortcut, not of failure to learn.
- **[[wiki/entities/imagenet-c.md]]** — what an *average*-case robustness benchmark can and cannot certify, in this page's own vocabulary: `E_{c∼C}[·]` over a declared corruption family is the weighted-ERM object shown here to interpolate between environments and never extrapolate, so a low mCE certifies coverage of the authored corruptions and is silent about an unauthored one — and its held-out corruption set is the closest thing that literature has to an unseen environment.
- **[[wiki/entities/stylized-imagenet.md]]** — the non-parametric version of this page's move: instead of penalising an environment-varying classifier, *author* an environment in which the spurious feature is pure noise (every texture replaced by a random painting's style). It needs no environment labels, no penalty and no linear-general-position assumption, and it recovers the invariant feature — at the cost of requiring the spurious feature to be named in advance, which is exactly what the IRM formulation avoids.
- **[[wiki/concepts/independent-causal-mechanisms.md]]** — the principle this page's penalty enforces, and the reason an invariance should exist at all: the conditional `P(Y|Pa(Y))` is stable because it *is* an autonomous mechanism, and its Sparse Mechanism Shift corollary supplies the only candidate in the wiki for scoring a factorization without the environment partition this page is handed.
- **[[wiki/concepts/information-bottleneck.md]]** — the same criterion written as a compression problem **(brainstorm)**: replacing the bottleneck's single relevance variable with a sum over environments, `min I(X;X̂) − β·Σ_e I(X̂;Y_e)`, charges one shared rate against relevance that must hold everywhere — which is this page's penalty expressed as a budget rather than as a gradient norm, and unrun.
