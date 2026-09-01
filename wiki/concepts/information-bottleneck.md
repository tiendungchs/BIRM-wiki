# Information Bottleneck

**Compression is undefined until a *relevance variable* is named: minimise `I(X;X̂) − β·I(X̂;Y)` and the optimum is the minimal sufficient statistic of `X` for `Y`. So "how many bits did the model keep" is the wrong question — the rate splits exactly into relevant and irrelevant bits, and only the second is what a learner should be charged for.**

The wiki has been reaching for this object without owning it: an information bottleneck is what induces AdaWorld's latent action alphabet ([[wiki/entities/adaworld.md]]), what the rate–distortion split on [[wiki/concepts/divergence-objectives.md]] is a generalisation of, and what [[wiki/entities/pfc-columnar-planning-model.md]]'s compression cascade stops on. This page is the principle itself.

> **Provenance.** Tishby & Zaslavsky 2015, *Deep Learning and the Information Bottleneck Principle* (`raw/tishby-2015-deep-learning-information-bottleneck.md`) — a 5-page position paper. The IB method is Tishby, Pereira & Bialek 1999; the finite-sample bounds are Shamir, Sabato & Tishby 2010; the bifurcation analysis is Rose 1998 and Rose, Gurewitz & Fox 1990, all carried second-hand. **The paper reports no experiments and no measurements of any kind** — every claim below is a bound, an identity, or a conjecture the authors flag as such.

---

## The formalism

Assume the Markov chain `Y → X → X̂` (the representation sees only `X`).

| Quantity | Definition | Reads as |
|---|---|---|
| **Rate** | `R = I(X;X̂)` | Complexity / description length of the representation |
| **Relevance** | `I_Y = I(X̂;Y)` | How much of `I(X;Y)` survived |
| **Objective** | `L[p(x̂\|x)] = I(X;X̂) − β·I(X̂;Y)` | Compress `X`, subject to keeping `Y` |
| **Distortion** | `d_IB(x,x̂) = D_KL[p(y\|x) ‖ p(y\|x̂)]` | A rate–distortion problem whose distortion measure is *not fixed* — it depends on the map being optimised |
| **Expected distortion** | `D_IB = I(X;Y\|X̂)` | Relevant information the representation failed to capture |
| **Equivalent objective** | `L̃ = I(X;X̂) + β·I(X;Y\|X̂)` | Same problem, differing by the constant `I(X;Y)` |
| **`β`** | Negative inverse slope of the information curve | Exchange rate between bits kept and bits of relevance lost |

Optimum (self-consistent, iterated Arimoto–Blahut style; **not convex**, so no uniqueness guarantee):

```
p(x̂|x) = p(x̂)/Z(x;β) · exp(−β·D_KL[p(y|x) ‖ p(y|x̂)])
p(y|x̂) = Σ_x p(y|x)·p(x|x̂)
p(x̂)   = Σ_x p(x)·p(x̂|x)
```

Exact sufficiency `I(X;Y) = I(Y;Ŷ)` holds iff `X̂` is a sufficient statistic; for general `p(X,Y)` no exact minimal sufficient statistic exists and the prediction chain `X → X̂ → Y` is simply false.

**The rate decomposes.** Not stated in the paper, but immediate from its Markov chain and the chain rule:

```
I(X;X̂)  =  I(X̂;Y)  +  I(X̂;X|Y)
 rate       relevant     irrelevant
```

This is the direct answer to the open problem [[wiki/concepts/prediction-compression-equivalence.md]] raises — *the rate does not decompose* — for one of the three splits that page wants. It separates relevant from nuisance bits exactly. It still does not separate memorised marginals from in-context adaptation from recovered structure, and it costs a named `Y`.

---

## Layers are a Markov chain, and that is the whole of the architectural argument

Each layer sees only the previous one, so the data-processing inequality gives, for `i ≥ j`:

```
I(Y;X) ≥ I(Y;h_j) ≥ I(Y;h_i) ≥ I(Y;Ŷ)
```

**Relevant information destroyed at one layer is unrecoverable at every layer above it.** Equality holds iff every layer is a sufficient statistic of its input. Each layer should therefore maximise `I(Y;h_i)` while minimising `I(h_{i−1};h_i)` — the per-layer criterion `I(h_{i−1};h_i) + β·I(Y;h_{i−1}|h_i)`, with `h_0 = X`, `h_{m+1} = Ŷ`.

Two things this buys that the wiki had no instrument for:

| Score | Definition | What it bounds |
|---|---|---|
| **Generalization gap** | `ΔG = D_N − D*_IB(n)` | Relevant information the network did not capture although it could have |
| **Complexity gap** | `ΔC = R_N − R*(n)` | Unnecessary complexity the network is carrying |

where `D_N = I(X;Y|Ŷ)` and `R_N = I(X;Ŷ)` for the output layer, and `(R*(n), D*_IB(n))` is the finite-sample optimum below. **Squared error and every other distortion the wiki uses can only score the output layer**; `d_IB` scores a hidden layer or a single unit, because it is defined against `p(y|·)` rather than against a target vector. Moving from low- to high-level representations along the network is exactly decreasing `β`.

---

## Compression is *necessary* for generalization

With finite support, `K = |X̂|`, and `Î` the empirical estimate from `n` samples (Shamir et al. 2010):

```
I(X̂;Y) ≤ Î(X̂;Y) + O(K·|Y|/√n)        I(X;X̂) ≤ Î(X;X̂) + O(K/√n)
```

with the effective `K ≈ 2^{I(X̂;X)}` — so the bound is a function of the *rate*, not of the cardinality of `X`.

- **The bounds do not depend on `|X|` at all.** The IB curve is well estimated for compressed representations and badly estimated for complex ones. Sample complexity is charged for what the representation keeps, not for how big the input is.
- **The input layer holds the most information about `Y` and generalizes worst**, because its description is too complex. The hidden layers exist to reach a rate where the worst-case generalization error is tolerable. This is the paper's sharpest claim: compression is not a nicety, it is the precondition.
- **The right amount of compression is a function of `n`, not of the task.** `(R*(n), D*_IB(n))` is where the worst-case bound is minimised; as `n` grows it slides toward the complex end. Any architecture with a fixed capacity is at the optimum for exactly one sample size.
- **The empirical information curve is over-optimistic at its complex end**, so the most-informative point on it is not the most informative point on the true curve.

---

## Where depth comes from: bifurcations

The information curve has **bifurcation points** at critical `β` — phase transitions between topologically different representations (a cluster split, a dimensionality change). These are properties of `p(X,Y)` alone, independent of any model.

The paper's conjecture, in three steps:

1. A sigmoidal unit computes the exact posterior `p(y|x)` only when the class-conditional likelihood ratio factorises, `p(x|y)/p(x|y′) = Π_j [p(x_j|y)/p(x_j|y′)]^{n·p(x_j)}` — i.e. when the inputs are **conditionally independent given the label**, with `w_j = log p(x_j|y)/p(x_j|y′)`, `b = log p(y)/p(y′)`, `h_j = n·p(x_j)`. A single unit can only cut hyperplanes; hidden layers exist to decouple the inputs until that condition holds.
2. The critical `β` of an IB bifurcation is set by the **largest eigenvalue of the second-order correlations of `p(X,Y|X̂(β))`**.
3. Linear separability breaks down when those same conditional second-order correlations stop being negligible — *the same eigenvalues*. So **the optimal layers sit at values of `β` just after each bifurcation**, and phase transitions that are linearly independent can be merged into one layer.

If it holds, the number of layers and the features per layer are **read off the joint distribution** rather than designed — architecture search becomes an eigenvalue problem. The paper offers no experiment for this, and the wiki's record says the opposite ([[wiki/empirical-tensions.md]] `T318`, gap `G29`).

---

## What it says for building a reasoning model

| Consequence | Detail |
|---|---|
| **The objective slot has a second argument nobody records** | [[wiki/concepts/three-component-framework.md]] logs *which* loss. IB says a compression objective is meaningless without a named relevance variable, and the choice of `Y` decides what the representation is allowed to be. Two systems with the same loss and different `Y` are not variants |
| **Determinism is suboptimal by construction** | The paper states outright that approaching the IB limit **requires stochastic maps between layers**, and that it is not known why or when stochasticity helps. A deterministic layer over a discrete `X` has `I(X;h) = H(X)` — the rate term is degenerate and the objective has nothing to press on. Every architecture in the wiki with deterministic layers is off the curve for a structural reason, not a training reason |
| **`ΔG` and `ΔC` are per-layer, label-free of the target vector** | The only score in the wiki that can say a *hidden* layer is carrying unnecessary complexity. [[wiki/entities/pfc-columnar-planning-model.md]] is the wiki's one system that already stops on this criterion (run the cascade until retained task-relevant information starts falling, ~85% of the bound) |
| **(brainstorm) The wanted objective is IB with `Y` = a *family* of targets** | Gap `G26` wants description length priced separately for structural position `g` and content `x`. The IB shape gives that for free if `Y` ranges over an environment family rather than one label set: `min I(X;X̂) − β·Σ_e I(X̂;Y_e)` charges one rate against relevance that must hold in every environment, which is [[wiki/concepts/environment-invariance.md]]'s criterion written as a bottleneck. Nothing in the wiki runs this |
| **(brainstorm) `β` is a run-time variable, not a hyperparameter** | Since `β` indexes position on the curve and the finite-sample optimum moves with `n`, an agent whose data grows should be *walking* the curve rather than sitting on it. That is [[wiki/concepts/precision-weighting.md]]'s gain register applied to the compression/relevance trade, and it is the same object gap `G50` says no controller can set for itself |

---

## Open problems

- **No `Y`, no bottleneck.** IB is a supervised principle. [[wiki/concepts/latent-graph-discovery.md]] has no label variable — the relevance target is precisely what the learner does not have — so the principle cannot be applied to the wiki's core problem without first answering *relevant to what*. Self-supervised uses substitute a surrogate (a future frame, an augmented view), which imports the surrogate's blind spots into the rate.
- **Nothing here is measured.** No experiment, no estimator, no dataset. Mutual information between a high-dimensional continuous layer and its input is the hard part and is not addressed; the finite-support assumption is doing heavy lifting in every bound.
- **The bifurcation→layer correspondence is a conjecture** with no worked case, and the optimisation is non-convex, so even the curve it is stated over is only approachable heuristically.
- **The bound is worst-case in `K`, and `K ≈ 2^{I(X̂;X)}` is not observable** for a trained network without an MI estimator — so `ΔG` and `ΔC`, the two instruments the paper contributes, cannot currently be computed for any model in the wiki.
- **Compression necessary ≠ compression sufficient.** [[wiki/concepts/prediction-compression-equivalence.md]] supplies the counterexample from the other side: world-class code length with none of the graph recovered (`G26`).

---

## Connections

- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the unconditional version of this page: that page charges total code length, this one splits the same rate into `I(X̂;Y)` and `I(X̂;X|Y)` and charges only the second, which is the decomposition that page names as missing — bought at the price of a relevance variable it does not need.
- **[[wiki/concepts/divergence-objectives.md]]** — the rate–distortion split there is the IB with the distortion term generalised: `f(X)` fixes the rate and the loss fixes the distortion, whereas here the distortion `D_KL[p(y|x)‖p(y|x̂)]` is *derived* from the relevance variable rather than authored, and `β` is the negative inverse slope of the resulting curve.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the multimodal case as a bottleneck: the weaker channel caps `I(X̂;Y)`, so a 77-token caption is the relevance variable that sets what a 400M-image encoder may keep, and text randomization is deliberately lowering the rate.
- **[[wiki/entities/adaworld.md]]** — the wiki's only running instance at scale: a β-VAE bottleneck (`β = 2×10⁻⁴`) between consecutive frames, with the *next frame* as the relevance variable, which induces a continuous action alphabet across 1016 environments — and inherits this page's blind spot, since a bottleneck relevant to "predict the next frame" cannot distinguish an agent's action from the weather.
- **[[wiki/entities/pfc-columnar-planning-model.md]]** — the per-layer criterion used as a stopping rule rather than a diagnosis: compress the place code stage by stage until retained task-relevant information starts falling (~85% of the bound), and the stage past that point is demonstrably unable to plan — an empirical `ΔG` where this page can only define one.
- **[[wiki/concepts/broadcast-hierarchy.md]]** — the anatomical form of the DPI chain: convergent input onto fewer, slower, broader units is a rate reduction per level, hierarchical level *is* a position on the information curve, and the cortex's lossiness is targeted at sufficiency for action, which is a relevance variable stated behaviourally.
- **[[wiki/concepts/latent-graph-discovery.md]]** — where the principle runs out: the framing's whole difficulty is that there is no `Y`, so the quantity IB compresses toward is exactly the thing to be discovered; any application to graph discovery must first name a surrogate relevance variable, and the choice of surrogate is a prior, not a derivation.
- **[[wiki/concepts/three-component-framework.md]]** — adds a hidden field to the objective slot: a compression objective is undefined without a relevance variable, so the slot has an argument (`Y`) that the framework's specification does not currently record.
- **[[wiki/concepts/environment-invariance.md]]** — the constructive combination this page suggests: replacing the single `Y` with relevance that must hold across environments turns IB into an invariance criterion charged against one shared rate (`G16`, `G26`).
- **[[wiki/concepts/manifold-untangling.md]]** — the geometric statement of step 1 of the bifurcation argument: a unit cuts hyperplanes, so depth exists to reach the representation where the classes are linearly separable — this page adds *when* that happens, at the `β` where the conditional second-order correlations stop being negligible.
- **[[wiki/concepts/memorisation-vs-generalisation.md]]** — the same claim from the task side: a task with no macrofeatures admits no compression, so `I(X;X̂)` cannot fall without `I(X̂;Y)` falling with it, and the finite-sample bound says such a task cannot be generalized from at all — the lookup table is the IB curve degenerating to the diagonal.
- **[[wiki/concepts/mean-field-reduction.md]]** — the same "read the architecture off a spectrum" move in the dynamical setting: modes above the spectral gap of the ensemble operator are what to keep, as bifurcation eigenvalues here decide how many representational levels to keep (`G67`).
- **[[wiki/concepts/energy-based-models.md]]** — the internal-divergence form: `J(θ) = E[ℓ] + T·KL(ρ_1‖ρ_0)` has the same shape as `L̃`, task term plus a divergence paid at an exchange rate, with `T` playing `1/β` and neither argument being the data.
- **[[wiki/entities/cpc.md]]** — the surrogate-relevance move this page names as the self-supervised escape, run at scale: `Y` = the observation `k` steps ahead, with the horizon `k` acting as `β` (longer horizons keep only slow features) — and the blind spot made visible, since speaker identity is predictive of the future and survives at 97.4% linear decodability alongside phone content.
- **[[wiki/concepts/confidence-calibration.md]]** — the same objective read at its other end: temperature scaling is the maximum-entropy distribution consistent with one measured moment of the logits, while NLL overfitting is that objective run past the point where extra bits describe the training sample rather than the label — accuracy improving while test likelihood degrades.
