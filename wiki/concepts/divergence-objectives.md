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

**A third position the table does not have: the divergence as a *term*, not the objective.** Both rows above put a divergence between model and world. A contrastive energy-based learner produces one between **two states of the same model**: the exact objective of a finite-nudge equilibrium-propagation rule decomposes as `J(θ) = E_{ρ_1}[ℓ] + T·KL(ρ_1‖ρ_0)`, task loss under the nudged (target-aware) distribution plus a divergence pulling the *free* distribution toward it (Litman 2025, [[wiki/concepts/energy-based-models.md]]). Neither argument is the data. The divergence is not fitted, it is **paid** — it is what the learner is charged for needing a nudge at all, and driving it to zero means the network reaches the target-consistent state unprompted. Temperature `T` is the exchange rate. **(brainstorm)** This is the same shape as the information bottleneck and as a variational free energy, and it suggests the wiki's "which direction should a reasoning model minimise?" question below is malformed for any architecture with two operating phases: the useful divergence there is *internal*, between what the system does when supervised and what it does when left alone, and its direction is fixed by which phase you want to become the default.

Consequence for the core framing. When a transition is genuinely one-to-many — a car at a fork, an exogenous edge driver ([[wiki/concepts/latent-graph-discovery.md]]) — forward KL forces the predictor to place mass *between* the branches, producing the averaged, physically impossible continuation that motivates the refusal-to-predict on [[wiki/concepts/energy-based-models.md]]. The blur is not a capacity failure; it is the objective's specified optimum. An energy function escapes it precisely by not being a normalised `Q` in either argument, so neither direction of the divergence applies to it.

---

## The other decomposition: rate and distortion

Cross-entropy splits a loss into *irreducible* and *model's fault*. A second split, orthogonal to it, separates what the **data pipeline** costs from what the **loss** costs — and it is the one that covers every self-supervised objective in the wiki at once (Dubois et al.; Federici et al., as presented in Bordes et al. 2024, [[wiki/concepts/cross-modal-grounding.md]]).

Any transformation `f(X)` of the data induces an equivalence relation partitioning `f(𝒳)`, with the constraint `f(x) ∼ f(x′) ⟹ p(z|f(x)) = p(z|f(x′))`. Masking, augmentation, cropping, *and the choice of which of two modalities to read* are all instances of `f`. Learning is then

```
argmin_{p(z|x)}   I(f(X); Z)  +  β · H(X | Z)
                  └── rate ──┘   └ distortion ┘
```

| Term | Fixed by | How each family pays it |
|---|---|---|
| **Rate** `I(f(X);Z)` — how much survives | the **data transformation** | Masked auto-encoding: an entropy bottleneck `log q(z)` bounded by a *constant* determined by how much the masking removed. Multimodal: `Z` is reduced to the **minimum** information available from either source |
| **Distortion** `H(X|Z)` — what preservation means | the **loss** | Auto-encoding bounds it by `log q(x|z)`; InfoNCE bounds it by scoring the *equivalence of two representations*, i.e. contrastive learning is compression **without** reconstruction |

**Why this belongs on this page.** It reclassifies a design decision the wiki has been treating as an objective choice. Whether a model can represent word order, arrangement or motion is a **rate** question settled by the augmentation/masking/modality pipeline before the loss is ever evaluated — so two systems with the same objective and different `f` are not variants, they have different information budgets. It also gives the sharpest available statement of why caption supervision fails on relations: the caption *is* the `f`, and the rate is its length ([[wiki/concepts/cross-modal-grounding.md]]).

**(brainstorm)** Put against the four levers of [[wiki/concepts/shortcut-learning.md]]: this says the *data* lever and the *goal* lever act on different terms of one functional and therefore cannot substitute for each other, which is a sharper version of the three-vs-four-lever dispute (T15) than either side has stated.

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
- **[[wiki/entities/boltzmann-machine.md]]** — a worked case of the forward-KL optimum with a twist this page should carry: maximum likelihood makes the fitted landscape mode-covering, but the model is *used by sampling*, so the blur stays in `p` and never reaches the output — mode-covering is only fatal for architectures that emit a summary statistic.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — where the internal-divergence reading has teeth: the "bias" of a finite nudge in a two-phase local rule is exactly `T·KL(ρ_1‖ρ_0)`, so what looked like an approximation error is a divergence term the learner deliberately pays (Litman 2025).
- **[[wiki/concepts/expected-free-energy.md]]** — the case that makes this page's "which direction?" question phase-relative rather than model-relative: the same free-energy principle runs the reverse, mode-seeking KL in perception and an explicitly *entropy-maximising* term `−Σ_t H(ρ_t)` over the imagined state marginal in planning, so a single agent covers modes in imagination and seeks one in inference (Milosevic et al. 2026).
- **[[wiki/concepts/precision-weighting.md]]** — where the reverse-KL direction becomes an architectural commitment: the gap between free energy and surprise is that KL, and its mode-seeking behaviour is why the recognition density is claimed to be unimodal — bistable rather than bimodal percepts — which is the framework's most exposed and least tested assumption (Friston 2009).
- **[[wiki/entities/deep-active-inference-agent.md]]** — this page's question decided at the level of behaviour rather than fit: `D_KL[P_θs ‖ Q_φs]`, its reverse, and the two entropy differences between them are four defensible readings of one "epistemic value", and swapping between them turns a working agent into one that emits a single action forever, or into one whose loss goes `NaN` (Champion et al. 2023).
- **[[wiki/concepts/cross-modal-grounding.md]]** — the rate–distortion decomposition above, and its one architecturally load-bearing corollary: in a multimodal objective the latent's information content is capped by the *weaker* channel, so a 77-token caption sets the budget for what a 400M-image vision encoder is allowed to keep.
- **[[wiki/concepts/retrieval-capacity.md]]** — where the choice of contrastive loss moves a *capacity* limit rather than a convergence rate: the dimension bound is charged per unit of score margin, InfoNCE maximises margin, and a sigmoid contrastive loss reportedly realizes the same relevance matrix in fewer dimensions (Bangachev et al. 2025, via Weller et al. 2026).
- **[[wiki/entities/byol.md]]** — a controlled instance of the rate–distortion split: two learners sharing the augmentation set `f(X)` (hence the rate) and differing only in the distortion term, which is why removing colour jitter costs them both, and why the paper's stated blocker for extending to audio/video/text is an `f(X)` problem rather than a loss problem.
