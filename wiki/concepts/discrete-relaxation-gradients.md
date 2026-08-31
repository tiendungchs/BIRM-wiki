# Discrete Relaxation Gradients

**Replace a non-differentiable discrete sample with a differentiable random variable that anneals to it, so a discrete latent — a symbol, an edge label, a routing decision, a commit — can sit inside a network trained end-to-end by ordinary backpropagation.**

> **Provenance.** Jang, Gu & Poole 2016, *Categorical Reparameterization with Gumbel-Softmax* (`raw/jang-2016-categorical-reparameterization-gumbel-softmax.md`), independently discovered as the *concrete distribution* by Maddison et al. 2016. The wiki takes it as the **anchor for the enabling mechanism behind every discrete-structure position it holds**: T147 position A, T148 position A, the binary-bottleneck family of G27, and the missing discrete commit of G91 all assume a trainable discrete node and none of them says how the gradient gets there.

This page is about a *tool*, not a claim about brains. It earns a page because the wiki keeps hitting the same wall from unrelated directions — a router's argmax ([[wiki/concepts/sparse-expert-routing.md]]), a spike threshold ([[wiki/entities/spiking-neural-networks.md]]), an allocation sort ([[wiki/entities/differentiable-neural-computer.md]]), a discrete state bottleneck ([[wiki/concepts/affordance-grounded-symbols.md]]) — and the escape is the same trick each time.

---

## The construction

**Gumbel-Max trick** (Gumbel 1954, Maddison et al. 2014) — an exact sampler for a categorical `z` with class probabilities `π₁…π_k`, encoded as one-hot corners of the simplex `Δ^{k-1}`:

```
z = one_hot( argmax_i [ g_i + log π_i ] ),    g_i ~ Gumbel(0,1) i.i.d.
```

The randomness is now an *input* (`g`), not an operation — which is exactly the reparameterization precondition. What blocks the gradient is the `argmax` alone. Replace it with a temperature-`τ` softmax:

```
y_i = exp((log π_i + g_i)/τ) / Σ_j exp((log π_j + g_j)/τ)
```

giving the **Gumbel-Softmax** density on the simplex

```
p_{π,τ}(y) = Γ(k) τ^{k-1} ( Σ_i π_i / y_i^τ )^{-k} Π_i ( π_i / y_i^{τ+1} )
```

`τ → 0` recovers the categorical exactly; `τ → ∞` goes uniform. `∂y/∂π` exists for all `τ > 0`, so the whole path `f(y) → θ` is one backward pass.

**Straight-Through (ST) Gumbel-Softmax.** Where the forward pass must be genuinely discrete — a discrete action space, a quantised code, a symbol a planner will consume — take `z = argmax(y)` forward and `∇_θ z ≈ ∇_θ y` backward. This buys sparse samples *even at high `τ`*, decoupling "how discrete is the sample" from "how noisy is the gradient", which the plain estimator ties together.

> Why ST-Gumbel beats plain ST (Bengio et al. 2013): plain ST backpropagates with respect to the sample-**independent** mean, so forward and backward disagree per-sample and variance rises. Each Gumbel-Softmax `y` is a differentiable proxy of *its own* `z`.

---

## The estimator landscape

Three families for `∇_θ E_{z~p_θ}[f(z)]`, and what each pays:

| Family | Mechanism | Bias | Cost |
|---|---|---|---|
| **Score function** (REINFORCE, likelihood ratio) | `E_z[f(z) ∇_θ log p_θ(z)]` | Unbiased | Variance scales **linearly with sample dimension** — the reason it is near-unusable for categoricals. Needs no gradient of `f` at all |
| **SF + control variate** (NVIL, DARN, MuProp, VIMCO) | Subtract a baseline `b(z)`, add back `μ_b` to stay unbiased | Unbiased (DARN biased — it drops `μ_b`) | An extra fitted network (NVIL), a Taylor expansion of `f` (MuProp), or `m` samples (VIMCO). Variance normalisation was *necessary* for competitive numbers |
| **Path derivative** (reparameterization, Gumbel-Softmax) | `z = g(θ, ε)`; differentiate through `g` | **Biased for `τ > 0`** | Requires `f` differentiable and `p_θ` reparameterizable. Lowest variance |

**Results** (binarised MNIST; nats, lower better). Numbers are the paper's Table 1:

| Task | SF | DARN | MuProp | ST | Annealed ST | Gumbel-S. | ST Gumbel-S. |
|---|---|---|---|---|---|---|---|
| Structured output prediction, Bernoulli | 72.0 | 59.7 | 58.9 | 58.9 | 58.7 | **58.5** | 59.3 |
| Structured output prediction, categorical | 73.1 | 67.9 | 63.0 | 61.8 | 61.1 | **59.0** | 59.7 |
| VAE, Bernoulli | 112.2 | 110.9 | 109.7 | 116.0 | 111.5 | **105.0** | 111.5 |
| VAE, categorical | 110.6 | 128.8 | 107.0 | 110.9 | 107.8 | **101.5** | 107.8 |

The categorical rows are the point: the gap over the best control-variate estimator is 4.0 and 5.5 nats, and it *widens* when the latent is categorical rather than Bernoulli — which is the regime every discrete-structure position in this wiki lives in.

---

## Temperature is the design knob

`τ` is a **bias–variance dial**, and the tradeoff runs the counterintuitive way:

| `τ` | Sample | Gradient variance | Bias vs. true categorical |
|---|---|---|---|
| small | near one-hot | **large** | small |
| large | smooth, → uniform | small | large |

Practice: start high, anneal to small-but-nonzero. The paper's VAE schedule is `τ = max(0.5, exp(−rt))` with `r ∈ {1e−5, 1e−4}` updated every `N ∈ {500, 1000}` steps; the structured-prediction task needed **no annealing at all** (`τ = 1` fixed). Schedule sensitivity is reported as low — "a variety of schedules and still perform well".

**Learned `τ` is entropy regularisation.** If `τ` is a parameter rather than a schedule, the model adaptively sets the confidence of its own proposals. That reframes the knob as a *per-node* quantity — and nothing in this literature learns one `τ` per latent node, which is what a graph with heterogeneous edge types would want **(brainstorm)**.

---

## The scaling argument — the load-bearing result for this wiki

Kingma et al. 2014's semi-supervised VAE has a categorical class latent `y` and cannot reparameterize it, so it **marginalises over all `k` classes**. With `D`, `I`, `G` the costs of sampling `q(y|x)`, `q(z|x,y)`, `p(x|y,z)`:

```
marginalisation:    O(D + k(I + G))     per step
Gumbel-Softmax:     O(D + I + G)        per step
```

Measured: **2× faster at 10 classes, 9.9× at 100 classes**, at matched quality (ELBO −106.8 → −109.6; unlabeled test accuracy 92.6% → 92.4%, and ST-Gumbel *above* marginalisation at 93.6%).

This is the result that matters here. Every wiki position that wants a discrete vocabulary wants a **large** one — a symbol set over an open world, an unbounded context set (T23 position B), a codebook that does not degrade into one code per observed composition (T148). Marginalisation makes vocabulary size a linear tax on every training step; single-sample relaxation makes it free. **The wiki's discrete positions were, before this, implicitly small-`k` positions.**

---

## What it does and does not settle for the wiki

| Row | What this supplies | What it leaves open |
|---|---|---|
| **G27** (nothing supplies the discretisation) | The *training* half of the binary-bottleneck family — DeepSym's and LatPlan's bottlenecks need exactly this gradient, and the survey never says which estimator | Nothing about the *criterion*. A relaxation makes any carving trainable; it does not say which carving is right. G27 is a criterion problem and stays one |
| **T147** (does inspectability need a discrete bottleneck?) | Removes position A's cost objection — a discrete bottleneck is no longer expensive or high-variance to train | Does not adjudicate. Position B's claim is about *where the learnable parameters live*, not about tractability |
| **T148** (discrete or continuous action alphabet?) | Removes the "8 codes because more is unaffordable" reading of position B's evidence: the codebook-size sweep nobody ran is now cheap to run | The transfer collapse at VQ-8 was never attributed to gradient variance, so this is a hypothesis about the sweep, not a result |
| **G91** (no architecture here has a discrete commit) | ST-Gumbel is a **dateable, exclusive, differentiable commit** — argmax forward, gradient backward — which is the one primitive the row says no wiki architecture has | Not the gate's *learning signal*. G91 needs credit to reach an admission decision whose payoff is many steps later; a path derivative needs a differentiable `f`, and a delayed exclusive publication is not one. This narrows G91 from two missing halves to one |
| **[[wiki/concepts/sparse-expert-routing.md]]** | The taxonomy's missing entry. Shazeer's escape was to route by `p_i` scaling and take the argmax's non-differentiability as a fixed cost; ST-Gumbel routes top-1 *and* gets gradient to `W_r` through the selection itself | No MoE result in the wiki uses it, so the win is unmeasured. THOR's uniform-random routing gaining 2 BLEU suggests the router gradient may not be the binding constraint |

**One cross-domain unifier worth naming.** [[wiki/entities/spiking-neural-networks.md]]'s surrogate gradients, this page's relaxation, and the ignored sort discontinuities in [[wiki/entities/differentiable-neural-computer.md]] are the same manoeuvre — smooth the discontinuity in the backward pass, keep it in the forward pass — arrived at independently in three literatures. EventProp is the sole dissenter, computing the *exact* gradient by splitting the loss integral at event times rather than smoothing anything ([[wiki/empirical-tensions.md]] T298).

---

## Limits

- **The objective stops being a bound.** With a learned categorical prior and non-discrete samples, the training loss "is no longer a variational bound". The paper's defence is empirical: annealing plus this objective still minimises the *actual* bound measured on validation and test. Anyone using this in a system whose correctness argument rests on an ELBO is relying on that observation, not on a theorem.
- **Train/test mismatch is structural.** Samples are continuous during training and discretised at evaluation. The plain estimator is therefore always evaluated in a regime it was not trained in — and it is precisely the plain estimator that wins the tables above, with ST (which has no mismatch) consistently 1–6 nats worse.
- **Scale.** The largest categorical latent demonstrated is `20 × 10` on MNIST, plus a 100-class speed test on *random* labels. Nothing here shows a relaxed discrete latent surviving the regime where T148's continuous code won (2000M frames).
- **`τ` has no derivation.** Chosen by validation sweep, annealed by a hand-picked schedule. The "learned `τ` = entropy regularisation" reading is offered and not evaluated.
- **`k` must be fixed in advance.** The simplex has a dimension. This is orthogonal to — and incompatible with — T23 position B's unbounded context set under a Dirichlet process, where the whole point is that `k` is not known **(brainstorm: a stick-breaking Gumbel-Softmax would be the obvious join and the wiki has no source on one)**.

---

## Connections

- **[[wiki/concepts/sparse-expert-routing.md]]** — supplies the entry that page's taxonomy is missing: ST-Gumbel gets gradient into the router weights *through the top-`k` selection*, where Shazeer's construction only gets it through the `p_i` scaling and treats the argmax as an accepted dead end.
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the training mechanism its whole family presupposes: DeepSym's and LatPlan's binary bottlenecks are exactly the discrete latent this estimator was built for, and the low-variance categorical gradient is what would let their two-valued bottleneck become a `k`-way one.
- **[[wiki/concepts/latent-graph-discovery.md]]** — makes edge *existence* and edge *label* trainable variables rather than hand-supplied structure: a categorical over `k` relation types per node pair, relaxed during training and hard at inference, is the smallest differentiable graph-inference layer this framing admits **(brainstorm)**.
- **[[wiki/concepts/event-segmentation.md]]** — a boundary decision is a Bernoulli latent, and this is the estimator for it: relaxing the boundary indicator would let the segmenter be trained by the downstream task's loss instead of by a hand-set threshold, which is G27's specific complaint about the detectors on offer **(brainstorm)**.
- **[[wiki/entities/spiking-neural-networks.md]]** — the same manoeuvre in a different literature: a spike threshold is a discrete node, surrogate gradients smooth it in the backward pass exactly as this smooths an argmax, and EventProp is the dissenting exact-gradient route (T298).
- **[[wiki/entities/differentiable-neural-computer.md]]** — its allocation sort is a discrete decision whose gradient discontinuities are simply ignored; this page names the principled alternative, and the DNC's report that ignoring them is "apparently harmless" is evidence about when the relaxation is not worth its bias.
- **[[wiki/concepts/amortized-inference.md]]** — the semi-supervised speedup is an amortisation result: single-sample inference through a discrete latent replaces an explicit `O(k)` marginalisation, which is what makes a large discrete vocabulary affordable to infer over.
- **[[wiki/concepts/attention.md]]** — hard attention (select one item, discretely) versus soft attention (mix) is the same argmax-vs-softmax choice, and Gumbel-Softmax is the interpolation between them with a trainable temperature.
- **[[wiki/architectural-gaps.md]]** — supplies the training half of `G27`'s bottleneck family and the commit primitive of `G91`, while leaving both rows' criterion/credit halves untouched.
- **[[wiki/empirical-tensions.md]]** — removes the tractability objection to position A of `T147` and `T148`, makes `T148`'s unrun codebook-size sweep cheap, and opens `T298` (smoothed vs. exact gradients through a discrete node).
