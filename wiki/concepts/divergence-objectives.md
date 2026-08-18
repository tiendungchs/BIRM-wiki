# Divergence Objectives

**Surprisal `−log q(x)` is the only additive measure of "how unexpected"; averaging it under the *true* distribution gives cross-entropy `H(P,Q)`, subtracting the irreducible part gives `KL(P‖Q) = H(P,Q) − H(P)`, and because `H(P)` does not depend on the model, minimising cross-entropy *is* minimising divergence — which is why almost every objective in this wiki is one loss wearing four names.**

The wiki repeatedly reaches for these quantities without owning them: log-loss on [[wiki/concepts/prediction-compression-equivalence.md]], residual surprise on [[wiki/concepts/predictive-coding-free-energy.md]], the "first sufficient predictor" complaint on [[wiki/concepts/shortcut-learning.md]], the objective slot on [[wiki/concepts/three-component-framework.md]]. This page is that shared vocabulary in one place, plus the one architecturally load-bearing fact about it: **the divergence is asymmetric, so the choice of which distribution sits in which argument decides what a fitted model does with ambiguity.**

> **Provenance.** `raw/talk-nd-cross-entropy-first-principles.txt` — an explainer talk (no author, no date), not a scientific source. Everything on the ladder below is standard information theory and is safe; the worked numbers are the talk's own and are reproduced here because they make the asymmetry concrete. Claims that go beyond the talk are marked `(brainstorm)`.

---

## The ladder

All values in **nats** (natural log), matching the talk.

| Quantity | Definition | Reads as |
|---|---|---|
| **Surprisal** | `s(x) = log(1/q(x)) = −log q(x)` | How surprised a believer in `q` is on seeing `x`. Zero at `q(x)=1`, `→∞` as `q(x)→0` |
| **Entropy** | `H(P) = Σ_x p(x)·(−log p(x))` | Average surprisal of a *correct* believer — the distribution's irreducible uncertainty |
| **Cross-entropy** | `H(P,Q) = Σ_x p(x)·(−log q(x))` | Average surprisal of a believer in `Q` watching a world that runs on `P`. Outcomes weighted by `P`, surprise scored by `Q` |
| **KL divergence** | `KL(P‖Q) = Σ_x p(x)·log(p(x)/q(x)) = H(P,Q) − H(P)` | The surprise attributable **purely to being wrong**, with the world's own noise peeled off |

**Why the logarithm is forced, not chosen.** Require a surprisal measure that (i) decreases in probability, (ii) vanishes at `q=1`, and (iii) is **additive over independent events** — being right about three simultaneous dice is three times the feat of one, while the probability is the *product*. Turning products into sums is the defining property of the logarithm, so `−log q` is the unique form up to base. The additivity axiom is the whole content: it is why code lengths add, why log-loss decomposes over a sequence, and why every objective in this wiki is a *sum* over timesteps rather than a product.

**Gibbs' inequality:** `H(P,Q) ≥ H(P)`, with equality iff `P = Q` (equivalently `KL ≥ 0`). Believing the wrong model can only ever *raise* your average surprise. This is the guarantee that makes the whole apparatus a loss function at all — the objective has a floor, that floor is achieved only by the truth, and the gap to the floor is the divergence.

**Worked entropy (talk's example).** A thick coin landing heads 49% / tails 49% / edge 2%: surprisal 0.71 on a face, 3.91 on the edge, so `H ≈ 0.78` nats — *higher* than a fair coin's `H = log 2 ≈ 0.69`, because the rare third outcome buys more uncertainty than the slight bias removes.

---

## The asymmetry, and why it is architectural

`H(P,Q) ≠ H(Q,P)`. The talk's worked pair, `P` or `Q` = rigged coin `(0.99, 0.01)`, the other = fair `(0.5, 0.5)`:

| Scenario | Truth `P` | Model `Q` | `H(P,Q)` | `H(P)` | `KL(P‖Q)` |
|---|---|---|---|---|---|
| Believe fair, actually rigged | `(.99, .01)` | `(.5, .5)` | **0.69** | 0.056 | **0.64** |
| Believe rigged, actually fair | `(.5, .5)` | `(.99, .01)` | **2.31** | 0.693 | **1.61** |

Same two distributions, ~3.5× difference. The mechanism: the second row's model assigns `0.01` to an outcome that occurs half the time, and `−log 0.01 = 4.6` nats of surprise arriving on 50% of trials dominates the average. **Assigning near-zero probability to something that actually happens is the expensive error; assigning moderate probability to something that never happens is cheap.**

**(brainstorm)** This is the mode-covering / mode-seeking split, and it is the choice the wiki has been making implicitly:

| Direction | Penalises | Fitted `Q` behaviour | Where the wiki uses it |
|---|---|---|---|
| **Forward `KL(P‖Q)`** — expectation under the data | `q` small where `p` large | **Mode-covering**: spreads mass over every mode, blurs, hallucinates mass between modes rather than risk a zero | Maximum likelihood, autoregressive log-loss — i.e. every model on [[wiki/concepts/prediction-compression-equivalence.md]] |
| **Reverse `KL(Q‖P)`** — expectation under the model | `q` large where `p` small | **Mode-seeking**: locks onto one mode and ignores the rest; never asserts what is false, routinely omits what is true | Variational inference, and the free-energy bound on [[wiki/concepts/predictive-coding-free-energy.md]] |

Consequence for the core framing. When a transition is genuinely one-to-many — a car at a fork, an exogenous edge driver ([[wiki/concepts/latent-graph-discovery.md]]) — forward KL forces the predictor to place mass *between* the branches, producing the averaged, physically impossible continuation that motivates the refusal-to-predict on [[wiki/concepts/energy-based-models.md]]. The blur is not a capacity failure; it is the objective's specified optimum. An energy function escapes it precisely by not being a normalised `Q` in either argument, so neither direction of the divergence applies to it.

---

## Why the code says cross-entropy and the theory says KL

`KL(P‖Q) = H(P,Q) − H(P)`, and `H(P)` is a property of the data alone — no setting of the model's parameters changes how diverse cats in the world are. So:

- `argmin_Q KL(P‖Q) = argmin_Q H(P,Q)`. The two objectives have the same minimiser and differ by an additive constant.
- Estimating `H(P)` from finite samples costs compute and buys nothing, so implementations skip it. Every cross-entropy loss in a training script is a KL divergence with an unestimated constant dropped.
- **Diagnostic cost of dropping it:** the loss value then carries no information about *how far from optimal* the model is, because the floor is unknown. A cross-entropy of 2.1 is uninterpretable in isolation; only differences between models on the same data mean anything. Anyone wanting an absolute readout — "this model has recovered `x`% of the available structure" — must pay for `H(P)` after all, and on real data that estimate is exactly the uncomputable quantity [[wiki/concepts/universal-induction.md]] is about.

---

## What this settles for the framing

| Claim | Status |
|---|---|
| The objective slot is empty by default | **False, sharpened.** The slot's default occupant is `H(P,Q)`, and it arrives with a *specified* preference — mode-covering — that nobody chose ([[wiki/concepts/three-component-framework.md]]) |
| Cross-entropy is loss-lever-neutral | **False (gap G16).** It terminates at the first `Q` matching `P`'s marginals. Two models with identical cross-entropy — one reading structure, one reading a shortcut — are indistinguishable to it *by construction*, because the objective is a function of the predictive distribution only and never of how it was computed |
| Surprise is a property of the world | **No — of the mismatch.** The talk's sharpest point: flipping 10 heads on a rigged coin feels astonishing while being, in truth, likely. Surprisal measured against a wrong model is a report on the model, not the event. **(brainstorm)** For an agent this is the good news: a residual is a *self-directed* signal, which is exactly the licence [[wiki/concepts/predictive-coding-free-energy.md]] needs to treat prediction error as a learning target rather than as noise |
| Generative modelling and probabilistic perception are the same problem | **Asserted by the talk, consistent with the wiki.** Both are "fit `Q` to an inaccessible `P` and sample from it"; the free energy principle and diffusion models are named as the two ends |

---

## Open problems

- **No divergence sees mechanism.** Every quantity here is a functional of `P` and `Q` as *distributions*. A structural rule and a shortcut that induce the same predictive distribution have identical loss at every point. Nothing on the loss lever alone can therefore buy the `g`/`x` factorization (G1, G16) — the discrimination has to come from architecture, from multiple environments, or from a term that is not a divergence.
- **Which direction should a reasoning model minimise?** The wiki uses forward KL everywhere it trains a predictor and reverse KL everywhere it does variational inference, with no argument for either. For one-to-many transitions the mode-covering optimum is visibly wrong, and mode-seeking discards branches a planner needs.
- **`H(P)` is unknown on real data**, so no absolute measure of "how much structure is left" exists — the same wall as the uncomputable `K(µ)`, met from the loss side.
- **Continuous states.** The talk waves at continuous distributions as "many tiny bins"; differential entropy is not bin-invariant and can be negative, so the surprisal intuition does not survive the limit unchanged. Any model whose latent graph has continuous node content inherits this.

---

## Connections

- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the same quantity from the coding side: `H(P,Q)` is expected code length under a wrong codebook, and `KL(P‖Q)` is precisely the bits wasted per symbol by using it, so the compression rates on that page are this page's divergence in different units.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — supplies the information-theoretic reading of the residual `e`: prediction error is surprisal, minimising it is minimising cross-entropy against sensation, and the free-energy bound is the *reverse* direction (mode-seeking), which is why that architecture settles into one attractor rather than blurring across several.
- **[[wiki/concepts/energy-based-models.md]]** — the motivated escape: unnormalised `F(x,y)` is subject to neither direction of the divergence, which is how it represents a one-to-many transition that forward KL would answer with an average of the branches.
- **[[wiki/concepts/three-component-framework.md]]** — names what silently fills the objective slot, and shows the slot has a hidden second parameter (which argument of the divergence the model occupies) that no component of that framework currently records.
- **[[wiki/concepts/shortcut-learning.md]]** — the formal statement of the loss-lever complaint: cross-entropy is a functional of the predictive distribution alone, so a shortcut and the intended rule that agree on `Q` are provably indistinguishable to it, whatever the training data.
- **[[wiki/concepts/universal-induction.md]]** — the floor this page's objective descends toward: `H(P)` is the irreducible term, and for a computable environment `K(µ)` bounds how fast a mixture predictor closes the gap to it.
