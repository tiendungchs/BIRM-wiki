# Width Versus Parameter Count — Units and Edges Priced Separately at a Fixed Weight Budget

**Every "bigger is better" result in deep learning raises width and weight count together, so neither has ever been priced alone. Hold the weight count fixed and grow width by static random sparsification and the answer separates: **width is the determining variable**, weight count is secondary as long as the model still reaches high training accuracy. A ResNet-18 at 11.7M weights spread over width 181 matches the same architecture at 90.7M weights (70.66 vs 70.91 top-1 on ImageNet); the optimum for convolutional models sits at **1–10% connectivity**, a widening factor of 3–10.**

> **Provenance.** Golubeva, Neyshabur & Gur-Ari 2021, *Are wider nets better given the same number of parameters?*, ICLR 2021 (arXiv:2010.14495), `raw/golubeva-2021-wider-nets-same-parameter-count.md`. Image classification only: one-hidden-layer MLP on MNIST, ResNet-18 on ImageNet / CIFAR-10 / CIFAR-100 / SVHN. Theory section is a GP-kernel calculation for a 2-layer ReLU net with Bernoulli–Gaussian weights.

---

## The decoupling problem and the three instruments

Width is hidden units (fully-connected) or output channels (convolutional). Raising it ordinarily raises the weight count, so an adjustment is needed — and the adjustment is the experiment's only degree of freedom.

| Method | Construction | Verdict | Why |
|---|---|---|---|
| **Linear bottleneck** | `W ∈ ℝ^{d_i×d_o}` → `W₁W₂`, `W₁ ∈ ℝ^{d_i×d_b}`, `W₂ ∈ ℝ^{d_b×d_o}`, `d_b ≤ min(d_i,d_o)`. Widen `d_i,d_o`, shrink `d_b` — a low-rank constraint on `W` | **Rejected** | Expressive power is unchanged at `d_b = min`, but factorising a matrix changes the gradient-descent trajectory. Accuracy does rise with width, yet stays *below* the un-factorised ResNet-18 baseline (dashed lines): the implicit regularisation of the reparametrisation is an uncontrolled confound |
| **Non-linear bottleneck** | Modify layers in *pairs*: raise the first layer's input dimension, lower its output dimension (`d_b < d`). Keeps the number of non-linear layers fixed | **Rejected** | No empirical gain from widening except one model (`1.8e5` weights), and mild there |
| **Static random sparsity** | Widen by factor `f`, then zero weights so the trainable count matches the baseline. Mask drawn at random at initialisation and **held static**; weights removed per layer *proportionally to layer size*; BatchNorm untouched and uncounted; uniform within each tensor | **Adopted** | The only method that changes the weight count without altering network structure or depth |

**`connectivity` := (parameters of the sparse model) / (parameters of a dense model of the same width).** Sparsity here is a *control*, not a subject: the mask is random and fixed precisely so that no pruning heuristic contributes. (A result cited by the source, author not recoverable from the clip, says a random fixed mask matches sophisticated init-time pruning at the same per-layer sparsity distribution, so the control is not obviously costing performance.)

---

## The measurements

**MLP, MNIST, one hidden layer.** Weights fixed at **3970**; widths 5 → 640, i.e. connectivity 1 → `5/640 ≈ 0.008`; last-layer connectivity swept 1.0 → 0.1 independently.

| Finding | Number |
|---|---|
| Optimal connectivity (ReLU) | **3–6%**, widening factor 16–32 |
| Last-layer connectivity at the optimum | **> 80%** — strip the *large* first layer, protect the small last one |
| Deep **linear** MLP (no ReLU) | Also improves with width at fixed weights — so the gain is **not** the extra capacity a wider ReLU net enjoys |

**ResNet-18, ImageNet.** Top-1 test accuracy, weights in millions in parentheses. Every sparse model carries the same 11.7M weights as the width-64 dense baseline.

| width | 64 | 90 | 128 | 181 | 256 |
|---|---|---|---|---|---|
| dense | 68.03 (11.7) | 69.11 (22.8) | 70.22 (45.7) | 70.91 (90.7) | 71.89 (180.6) |
| sparse | – | **69.56** (11.7) | 70.02 (11.7) | 70.66 (11.7) | 70.53 (11.7) |

- At width 90 the sparse model **beats** the dense model of twice the size.
- At width 181 it holds 70.66 against 70.91 at **7.8× fewer weights**, and beats the 45.7M dense model of width 128.
- The curve turns over at width 256, and *test* accuracy declines at the same width *training* accuracy does: the ceiling is an **optimisation** failure at low connectivity, not a capacity failure.
- Across CIFAR-10/100 and SVHN the same shape holds; the effect is strongest for harder tasks and for narrow baselines that never reach 100% training accuracy — but survives in models that do fit the training set.
- The fraction of the dense improvement attributable to width alone (sparse/baseline gap ÷ dense/baseline gap) is **most of it**, for every width at which training accuracy stays high.

---

## Why width, at a fixed weight count — the kernel argument

For `f(x) = (nd)^{-1/2} v^T[ux]_+` with each parameter drawn `N(0, σ²)` with probability `p` and `0` otherwise, `σ² = p⁻¹`, and the GP kernel `Θ_GP(x,y) := ∇_v f(x)^T ∇_v f(y)`:

```
E_θ[(Θ_GP − Θ_GP^∞)²] = (1/d²)[K̃₁,ₚ − K₁]² + (1/d²n)[K̃₂,ₚ − K̃₁,ₚ²]        (Theorem 1)
K̃_{l,p}(x,y) = σ^{2l} Σ_{s∈{0,1}^d} p^{Σsᵢ}(1−p)^{d−Σsᵢ} K_l(x_s, y_s)
```

and, for independent random inputs with `pd ≫ 1`,

```
E_θ[(Θ_GP − Θ_GP^∞)²] ≈ (1/4d)[ ¼(1/√p − 1)² + (d/n)(1 − 1/π²) ]
```

**Read the two terms as a bias–variance split on the *kernel*, not on the function.** The first term is the price of sparsity (it blows up as `p → 0`, independent of `n`); the second is finite-width fluctuation, killed by large `n`. At fixed parameter count `np = const` and `n ≫ 1` the distance is minimised at

```
p* ≈ √(np / 4d)
```

The conjecture the paper tests: **a finite network's performance tracks how close its kernel at initialisation is to the infinite-width kernel**, and widening at fixed weight count is a way of getting closer. Empirically the kernel-distance minimum and the trained-accuracy maximum fall at a similar width (Figure 8b), with the closed form matching the measured distance when `dp ≫ 1`. This is a correlation at one MLP setting, not a derivation of the ImageNet result.

---

## What a builder takes from it

| Move | Statement |
|---|---|
| **Report width and weight count as two axes, never one** | Every scaling claim in the wiki that reads "more parameters" is confounded; at least on image classification the operative variable is unit count. Any units-to-competence number (`P5`) must state the weight budget it was measured at, or it prices the wrong thing |
| **A fixed synapse budget is better spent on units than on fan-in** | The direct machine reading, and it is the *opposite* of the rodent cortical exponent: rodents buy `s̄ ∼ N^0.74` (bigger arbours per unit), primates hold fan-in constant and add units, and this result says the primate move is the one that pays — at least until connectivity falls below the point where optimisation breaks ([[wiki/concepts/cellular-scaling-rules.md]]) |
| **The knee is an optimisation knee** | Train accuracy and test accuracy fail together. The design rule is therefore "widen until the optimiser stops fitting the training set", which is a *measurable* stopping criterion rather than a hyperparameter |
| **Random static sparsity is a usable default** | No pruning schedule, no mask search, no dynamic rewiring — the mask is drawn once and frozen. Whatever a learned sparse topology buys, it is not what this result is made of |
| **The gain is not capacity** | The deep *linear* MLP shows the same effect, so the explanation cannot be "a wider ReLU net expresses more functions" **(brainstorm: this is the strongest single reason to believe the kernel-geometry account over an expressivity account)** |
| **Unrealised on current hardware** | 1–10% connectivity is a compute saving only on a substrate where an absent edge costs nothing — which is the neuromorphic argument ([[wiki/entities/dendritic-ann.md]]) reached from an accuracy result rather than an energy one |

---

## Open problems

- **Image classification only.** No sequence model, no reasoning benchmark, no task where the wiki's `g`/`x` distinction is even stateable. Whether "width is the operative variable" survives onto a task with compositional structure is untested.
- **The kernel conjecture is correlational.** Kernel distance is computed at *initialisation*, for a 2-layer net, on a subset of MNIST; the ResNet-18 result has no kernel measurement at all. Nothing rules out a training-dynamics account that predicts the same optimum.
- **`p*` is untested as a design rule.** The formula `p* ≈ √(np/4d)` is derived under independent random inputs — the one assumption real data violates hardest — and is never used to *predict* the optimum of a convolutional model.
- **The converse sweep is absent.** Fixing unit count and raising edge density is the other half (`G101`), and no experiment here runs it: every point in the study moves width, so the result bounds what units buy without pricing what fan-in buys.
- **Depth is held fixed throughout.** Both bottleneck methods were designed to keep the number of non-linear layers constant, so the study prices width against weights and says nothing about width against depth.
- **Per-layer allocation is a free parameter with a measured gradient.** Proportional-to-size removal won among the variants tried, and the MLP sweep says the optimum keeps the small output layer dense — an allocation rule that was tuned empirically on two models and given no principle.

---

## Connections

- **[[wiki/concepts/cellular-scaling-rules.md]]** — the same units-versus-wiring trade with the clades' answers reversed into a machine test: that page measures `M ∼ N^a` and reports that primates add units at constant wiring-per-unit while rodents grow the arbour, and this page holds the *edge* budget fixed and finds that spending it on more units wins, which is the primate exponent shown to be the better buy on a task rather than merely the cheaper one.
- **[[wiki/concepts/connectivity-scaling-bottleneck.md]]** — the two results compose into one budget statement and disagree about the conclusion: that page says a scaled spatial network is *forced* to thin its edges (density 52% → 31–37% across primates) and reads the thinning as a cost paid in redundancy, while this page finds a regime where thinning the edges to 1–10% and spending the saving on units is a net *gain* — so edge-rationing under growth may be closer to an optimum than to a compromise **(brainstorm)**.
- **[[wiki/concepts/circuit-size-separation.md]]** — supplies the missing denominator for that page's units-to-competence currency: a "this function costs `Ω(n)` units" bound compares unit counts across substrates, and this result says unit count and weight count come apart by up to 7.8× in a trained network, so a units claim and a parameters claim are not interchangeable ([[wiki/empirical-tensions.md]] T234, `P5`).
- **[[wiki/entities/dendritic-ann.md]]** — the same structural-sparsity move with the mask chosen rather than random: that model handcrafts a restricted fan-in (16 of 784) from dendritic morphology and buys 1–3 orders of magnitude in parameters, this one draws the mask uniformly at random and gets the benefit anyway — which brackets how much of the dendritic result is *topology* and how much is merely *sparsity at width*.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the same word for two different objects, and the distinction matters: that page's sparsity is in the **activity** (active fraction `a/n` held at 0.5–3% by inhibition, priced in recognition error), this page's is in the **connectivity** (1–10% of weights present, priced in test accuracy at fixed budget) — the two optima land in a numerically similar band and have no established relation.
- **[[wiki/concepts/sparse-expert-routing.md]]** — the deployed version of this trade-off and the reason the saving is currently notional: mixture-of-experts raises unit count at fixed per-token fan-in, which is this page's move made *routable* so that the absent edges cost no compute, where static random sparsity gets the accuracy and none of the speed on dense hardware.
- **[[wiki/concepts/intelligence-density.md]]** — a direct measurement in that page's currency with the surprising sign: `C(S)` counted in weights can be held constant while accuracy rises, so description length and unit count are separately purchasable, and any density score must declare which one it is dividing by.
