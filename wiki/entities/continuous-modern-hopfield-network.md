# Continuous Modern Hopfield Network (Ramsauer et al. 2020)

**Take the exponential-interaction modern Hopfield energy, apply `−log`, and add `½ξᵀξ` to keep the state bounded. The result is an energy over *continuous* states whose minimiser is reached by `ξ^new = X softmax(β Xᵀξ)` — which, with `β = 1/√d_k` and a value projection applied afterwards, is `softmax(QKᵀ/√d_k)V` verbatim. So a transformer attention layer is one step of a convergent associative retrieval with an exponential capacity bound, a retrieval-error bound exponential in pattern separation, and a single scalar `β` that decides whether the read returns one pattern, an average over a similar subset, or the mean of everything.** Ramsauer, Schäfl, Lehner, Seidl, Widrich, Adler, Gruber, Holzleitner, Pavlović, Sandve, Greiff, Kreil, Kopp, Klambauer, Brandstetter & Hochreiter, *Hopfield Networks is All You Need*, ICLR 2021 (arXiv 2008.02217).

This is the primary source for an identity the wiki has been quoting second-hand on four pages ([[wiki/entities/hopfield-network.md]], [[wiki/entities/tem-transformer.md]], [[wiki/entities/two-body-dense-associative-memory.md]], [[wiki/glossary.md]]'s `CHN` entry). What it adds beyond the identity: the **fixed-point taxonomy** that makes `β` an architectural dial, the **one-step retrieval theorem** that is why the identity is usable in a feedforward stack at all, and — the result that matters most for the wiki — a **measurement of which regime trained attention heads actually occupy**, which turns out to be the one where the capacity theorem does not apply.

> **Provenance.** `raw/ramsauer-2020-hopfield-networks-is-all-you-need.md` — ar5iv rendering of arXiv 2008.02217, 39 857 words, read in slices. All figures are images absent from the clip, so the BERT head distributions below are read from the figure captions and the accompanying text, not off the plots.

---

## The construction

| Object | Statement |
|---|---|
| Stored patterns | `X = (x_1,…,x_N)`, `x_i ∈ ℝ^d`, `M = max_i ‖x_i‖` |
| State (query) | `ξ ∈ ℝ^d` — **continuous**, where [[wiki/entities/dense-associative-memory.md]] and [[wiki/entities/hopfield-network.md]] are bipolar |
| Energy | `E = −lse(β, Xᵀξ) + ½ ξᵀξ + β⁻¹ log N + ½M²`, with `lse(β,x) = β⁻¹ log Σ_i exp(βx_i)` |
| Bounds | `0 ≤ E ≤ 2M²` |
| Update | `ξ^new = f(ξ) = X p = X softmax(β Xᵀξ)` |
| Convergence | `f` is the Concave–Convex Procedure on `E = ½ξᵀξ` (convex) `− lse` (concave), so `E(ξ^t) → E(ξ*)`; strengthened past Zangwill to give `‖ξ^{t+1} − ξ^t‖ → 0` and convergence to a stationary point whenever the level set of stationary points is finite |

**The two heuristic steps are worth naming, because the wiki already holds the principled version.** `−log` of Demircigil's energy, then `+½ξᵀξ` to bound the norm — both are introduced to make the construction work rather than derived. [[wiki/entities/two-body-dense-associative-memory.md]] obtains the same energy as one choice of Lagrangian pair (`L_h = log Σ_μ e^{h_μ}`, `L_v = ½Σ_i v_i²`) in a bipartite two-body network, with the boundedness falling out instead of being added. This page is the result; that one is the derivation.

**Why the norm has to be bounded and the binary model did not need it.** A bipolar state has fixed length by construction; a float state does not, and `−lse` alone is unbounded below along `ξ`. The quadratic term is therefore the *price of continuity*, and it is also what makes the fixed-point equation a softmax-weighted average rather than a sign.

---

## Storage capacity

**Definition used throughout** (Definition 1 / 5): `x_i` is **stored** if a sphere `S_i` around it contains a single fixed point `x_i*` to which every point of `S_i` converges, and the spheres are disjoint. The canonical sphere is `S_i = {ξ : ‖ξ − x_i‖ ≤ 1/(βNM)}`. `x_i` is **retrieved** to `ε` if one update lands `ε`-close to `x_i*`; the **retrieval error** is `‖x̃_i − x_i‖`.

| Pattern placement | Result | Conditions |
|---|---|---|
| **Random**, on the sphere of radius `M = K√(d−1)` | `N ≥ √p · c^{(d−1)/4}` with probability `1−p`, where `c = b/W_0(exp(a + ln b))`, `a = 2(1+ln(2βK²p(d−1)))/(d−1)`, `b = 2K²β/5`, `W_0` the upper branch of the Lambert `W` function | `c ≥ 3.1546` proven at `β=1, K=3, d=20, p=0.001`; `c ≥ 1.3718` at `β=1, K=1, d=75, p=0.001` |
| **Placed** (adversarially chosen) | `N = 2^{2(d−1)}` | `β=1`, `M = 2√(d−1)`, `d ≥ 4`; or `M = 1.7√(d−1)`, `d ≥ 50` |
| **Placed**, larger radius | larger still | `M = 5√(d−1)`, `d ≥ 3`; or `M = 4√(d−1)`, `d ≥ 13` |

**The capacity is exponential in `d` and the base is a *radius* choice.** `K` — the pattern norm in units of `√(d−1)` — enters `c` directly. Larger patterns are further apart at fixed dimension, so a store that normalises its keys to a larger sphere holds more of them; this is the continuous analogue of [[wiki/entities/dense-associative-memory.md]]'s exponent `n`, and unlike `n` it costs nothing in the read-out nonlinearity. Layer normalisation in a transformer sets this parameter silently.

---

## One-step retrieval, and the quantity everything is exponential in

**Separation.** `Δ_i := x_iᵀx_i − max_{j≠i} x_iᵀx_j`. The pattern is separated iff `0 < Δ_i`; for equal-norm patterns `Δ_i = ½ min_{j≠i} ‖x_i − x_j‖²`.

```
‖f(ξ) − x_i*‖  ≤  ‖J^m‖₂ ‖ξ − x_i*‖
‖J^m‖₂         ≤  2 β N M² (N−1) exp(−β (Δ_i − 2 max{‖ξ−x_i‖, ‖x_i*−x_i‖} M))
‖f(ξ) − x_i‖   ≤  2 (N−1) M exp(−β (Δ_i − 2 max{…} M))
‖x_i − x_i*‖   ≤  2 e (N−1) M exp(−β Δ_i)         (when both distances ≤ 1/(2βM))
```

So for well-separated patterns **one update retrieves**, with error exponentially small in `βΔ_i`. This is the whole reason the construction is usable in a deep network: a layer is activated once, and a store that needs to settle cannot be a layer.

**The trade-off, stated by the paper as the thing it inherits from every Hopfield model:** small `Δ_i` buys high storage capacity and costs convergence speed and retrieval accuracy; large `Δ_i` buys one-step retrieval at exponentially low error and costs capacity. `β` and the pattern radius both multiply `Δ_i` in the exponent, so **there are three knobs (`β`, `M`, the data's own geometry) and one exponent they all enter**. `G42`'s "sized by structure rather than by hyperparameter" is half-satisfied here: the bound is derived, and its argument `Δ_i` is a property of the *stored contents* measurable at run time — but `β` and `M` are still set at design time and nothing computes `Δ_i`.

---

## The three fixed-point regimes — `β` as the dial

| Regime | When | Fixed point | Softmax vector `p` |
|---|---|---|---|
| **(a) Global** | no pattern separated from the rest | close to the arithmetic mean of all `x_i` | ≈ uniform, `p_i ≈ 1/N` |
| **(b) Metastable** | a subset of patterns similar to each other and jointly separated from the rest | close to the mean of that subset; iterations started at any member converge to it | mass spread over the subset |
| **(c) Single pattern** | `Δ_i` large | `x_i* ∈ S_i` | ≈ one-hot |

**This is the wiki's cleanest statement that "retrieve" and "average" are the same operation at two temperatures.** `β → ∞` makes every pattern separated and the read a hard `argmax`; `β → 0` collapses everything to the global mean. A metastable state is not a spurious state and not a failure — it is a *learned pooling over a cluster*, and the capacity theorems apply to it unchanged if each metastable state is treated as one item.

**Spurious states are not eliminated, and the count is not bounded by `N`.** Writing the energy as a mixture,

```
exp(−E)  ∝  ( Σ_{i=1}^{N} λ(x_i,β) · G(ξ; x_i, β⁻¹ I) )^{β⁻¹},    λ(x_i,β) = exp(½β‖x_i‖²)
```

the minima of `E` are exactly the **modes of a Gaussian mixture** with `N` components of isotropic covariance `β⁻¹I`. A Gaussian mixture with `N` components can have **more than `N` modes** — so a store with `N` patterns can have more than `N` fixed points, and the classical spurious-minimum problem survives the move to exponential interaction. [[wiki/entities/vector-hash.md]] remains the wiki's only store that is provably spurious-free.

---

## The attention identity

Map raw patterns into a `d_k`-dimensional associative space: `X^T = K = Y W_K`, `Ξ^T = Q = R W_Q`, `V = Y W_K W_V`. Then the update rule, post-multiplied by `W_V` and with softmax written as a row vector,

```
Z = softmax(β R W_Q W_Kᵀ Yᵀ) Y W_K W_V  =  softmax( (1/√d_k) Q Kᵀ ) V      at  β = 1/√d_k
```

Four things this fixes for the wiki's reading of `softmax(QKᵀ/√d_k)V`:

| Consequence | Statement |
|---|---|
| **`1/√d_k` is an inverse temperature, not a numerical patch** | [[wiki/entities/transformer.md]] introduces it because large `d_k` saturates the softmax. Here it is `β`, the parameter that selects which of the three fixed-point regimes a head operates in — so the architecture has **hard-coded the regime selector to a function of head width** and never exposed it. Ramsauer make it a learnable parameter, and report it matters in combination with the learning rate |
| **One attention step is one update of a convergent iteration** | Iterating the same layer is legitimate — the energy descends monotonically — so "multiple updates" is a free knob for trading compute against fixed-point precision with **no added parameters** |
| **Self-attention is the special case `R = Y`** | Query set = stored set, `W_K W_V` collapsed to `W_V`; encoder–decoder cross-attention is the general two-set case with the memory filled by the encoder output |
| **A capacity number attaches to every head** | `N ≥ √p c^{(d−1)/4}` in `d = d_k`, with the caveat below that trained heads are not in the regime the theorem describes |

---

## What trained attention heads actually do — the measurement

Define `k` = the minimal number of softmax values needed to sum to 0.90 (the **size of the metastable state**), take `k̄` = the median of its distribution over sequences, and classify each head against sequence length `N`:

| Class | Criterion | Meaning | Where it lives in `bert-base-cased` |
|---|---|---|---|
| I | `k̄ > N/2` | averaging over a very large number of patterns (≈ regime (a)) | **first / lower layers** |
| II | `N/8 < k̄ ≤ N/2` | large metastable state | middle layers (3, 4, 5) |
| III | `N/32 < k̄ ≤ N/8` | medium metastable state | **last layers** |
| IV | `k̄ ≤ N/32` | small metastable state or single-pattern fixed point (regime (c)) | middle layers (6, 7, 8) |

**Trained heads are predominantly in metastable states.** Very few heads are doing the single-pattern retrieval the capacity theorem is about, and the lower layers are doing something a learned input-independent kernel can do instead: replacing them with **Gaussian averaging heads** (softmax replaced by a discrete Gaussian over position with learned `μ_i, σ_i`) costs `2N` parameters per head against `2 d_k d_y`, a **95.5× reduction** at BERT-base sizes, at the price of input-independence.

**Class IV heads commit early and then stop learning.** Tracking `k` through BERT-small pre-training (12 layers, 4 heads, `N`=128, 1.45M steps), middle-layer heads switch into class IV at **9 000–10 000 steps**, coinciding with the second large drop in the loss, and thereafter the Frobenius norm of the softmax Jacobian — which is what carries gradient to `W_Q, W_K` — stays near zero. **The head is frozen by the sharpness of its own softmax.** The paper raises but does not settle whether this is functional or harmful.

**(brainstorm) This is a self-inflicted, diagnosable training pathology and the wiki has no page for it.** A head that enters regime (c) has `p` one-hot, so `diag(p) − ppᵀ ≈ 0`, so `∂ξ^new/∂ξ = β X (diag(p) − ppᵀ) Xᵀ ≈ 0` — sharpening the read *is* vanishing the gradient. That predicts a cheap intervention nobody in the source tries: anneal `β` upward, or floor the row entropy, so that heads reach their final sharpness after the representations they address have stopped moving rather than before. It also predicts that the well-known difficulty of training transformers without warmup is partly a regime-commitment problem, not only an optimisation-scale one.

---

## The three Hopfield layers

| Layer | Query `R` | Memory `Y` | What it replaces |
|---|---|---|---|
| `Hopfield` | from input / previous layer | from input / previous layer or a supplied reference set | Transformer attention exactly (with skip connections in a ResNet = BERT); sequence-to-sequence, point-set association, retrieval |
| `HopfieldPooling` | **static, learned** | from input | pooling, averaging, LSTM/GRU, permutation-equivariant layers; one such layer performs multiple-instance learning by learning a query that averages over the class-indicative instances of a bag |
| `HopfieldLayer` | from input | **static, learned** — initialisable from the training set, a reference set or prototypes | a fully connected layer; approximations to SVM, `k`-nearest-neighbour, learning vector quantisation. With `y_i = (z_i, t_i)` and `W_K, W_V` designed so the softmax sees `z_i` and the output reads `t_i`, the layer is a **learned kernel regression on the training set** |

Four functionalities the energy analysis hands the layers for free: multiple updates (precision without parameters), `β` (metastable-state size, learnable), the associative-space dimension (storage capacity), and pattern normalisation (fixed-point dynamics via norm and shift — i.e. **layernorm is a capacity control**).

**Beyond `N` fixed patterns.** Causal masking (a large negative constant inside the softmax) makes the store auto-regressive over an unbounded pattern sequence `X_t = (x_1,…,x_t)`. **Forgetting** is one further term: subtract `γ(t−i)` inside the `lse`, giving exponential recency weighting with `γ` the forgetting rate. That is the wiki's cheapest forgetting operator — a scalar added to the energy, with the descent argument intact — and `G42` has been recording "no store here has a forgetting rate" for its whole life.

---

## Reported results

| Task | Number |
|---|---|
| MIL: Tiger / Elephant / UCSB breast cancer (AUC) | **91.3±0.5 / 94.9±0.3 / 89.5±0.8** — new state of the art on all three |
| MIL: Fox | 64.05±0.4 — **loses** to MILES (73.8±1.6) and path encoding (71.2±1.4) |
| Immune-repertoire classification (DeepRC, ≈300 000 instances per bag) | AUC **0.832±0.022** vs SVM/MinMax 0.825±0.022, burden test 0.699±0.041 |
| UCI, 75 small datasets | best average rank difference (**−3.92**); **not** significant against SVM (−3.23, `p`=0.15), SNN (−2.85, `p`=0.10) or RandomForest (−2.79, `p`=0.05) |
| Drug design | SIDER **0.672±0.019**, BACE **0.902±0.023** (state of the art); HIV and BBBP not claimed |

---

## What this contributes to the wiki

| Claim | Why it matters |
|---|---|
| **An attention layer's temperature is its regime selector, and it is hard-coded** | `β = 1/√d_k` ties the retrieve-vs-average decision to head width. Making it learnable is a one-parameter change to any transformer in the wiki, and the fixed-point taxonomy says exactly what is being traded |
| **One-step retrieval with error `∝ exp(−βΔ_i)`** | The condition under which a recurrent store may be used as a feedforward layer, stated as an inequality on a measurable property of the stored set rather than as an empirical observation |
| **Capacity exponential in `d_k` with the base set by the pattern radius** | A second continuous route to the exponential store, independent of [[wiki/entities/dense-associative-memory.md]]'s exponent `n`, and the one that applies to key/value caches as they are actually built |
| **Trained heads occupy the regime the capacity theorem excludes** | The wiki has been attaching a capacity number to attention on the strength of the identity. The measurement says most heads are averaging over `N/32`–`N/2` entries, i.e. deliberately *not* separating patterns — so the capacity bound describes an operating point transformers largely avoid (`T390`) |
| **A forgetting term that is one addend in the energy** | `−γ(t−i)` inside the `lse`. `G42`'s standing hole — every store here asserts forgetting without a rate — gets a rate, a mechanism and an intact convergence argument, though no schedule for `γ` |
| **Spurious states survive: more than `N` modes from `N` patterns** | Exponential capacity does not buy a clean landscape. The Gaussian-mixture form makes this a statement about mixture modes rather than about glassy physics |
| **`HopfieldLayer` makes a fully connected layer a kernel regression on the training set** | The store's contents can be the data itself, so "memorise the training set" becomes an architectural option with a capacity bound rather than a pathology |

**(brainstorm) `Δ_i` is the run-time occupancy signal `G42` has been asking for, and it costs one `max` per read.** Every bound on this page is exponential in `Δ_i`, and `Δ_i` is computable from the key matrix alone — `x_iᵀx_i − max_{j≠i} x_iᵀx_j`, which for equal-norm keys is half the squared nearest-neighbour distance. A store that tracked `min_i Δ_i` would know, before any retrieval failed, that its worst-separated item had entered the regime where a read returns a blend; and `β Δ_i` is directly comparable across stores of different size. No entry in `G42` reports this, and unlike [[wiki/entities/sparse-distributed-memory.md]]'s `|s_u|` (a per-*read* confidence) it is a per-*store* fullness number available without a query. The catch is honest and structural: `Δ_i` is `O(N²)` to maintain exactly, and the whole point of an exponential store is that `N` is large.

**(brainstorm) Read the BERT class distribution as a depth-wise schedule and it is the wrong way round.** Lower layers average globally (class I), middle layers retrieve single patterns (class IV), last layers average over medium sets (class III). A designer asked to lay out a reasoning stack would put broad pooling early and *sharp* retrieval late — the last layer is where a specific answer is needed. The measured order instead sharpens in the middle and re-blurs at the end, which is consistent with the middle layers doing the addressing and the final layers doing an output-space vote over candidates. If that reading is right, the class-III layers are where [[wiki/concepts/evidence-accumulation.md]]'s competition lives in a transformer, and they are the layers the paper itself names as the target for improvement.

---

## Limitations

| Limit | Consequence |
|---|---|
| **Capacity is i.i.d.-random-patterns on a sphere** | Same standing caveat as every bound in `G42` ([[wiki/empirical-tensions.md]] T61). The `2^{2(d−1)}` figures are for *placed* (adversarially chosen) patterns and say nothing about data |
| **`β` and `M` are design-time** | The bound is derived, but nothing in a running store reads its own `Δ_i`, refuses a write, or reports a margin. `G42` does not move off `PARTIAL` |
| **No write rule** | Patterns are supplied or learned by backpropagation through the layer. One-shot writing — the defining property of the wiki's fast store — is absent, exactly as in [[wiki/entities/two-body-dense-associative-memory.md]] (`T62` untouched) |
| **Spurious states unbounded** | More modes than components is possible and no count is given |
| **The energy's two steps are heuristic** | `−log` then `+½ξᵀξ`; the principled derivation is elsewhere |
| **The head analysis is descriptive** | Operating classes are measured, never manipulated. No head is forced into a class to see what breaks, and the class-IV freezing is raised as a question and left |
| **Gaussian averaging heads are proposed, not benchmarked here** | Parameter count is computed; no downstream accuracy is reported in the clip |
| **The benchmark wins are small-data** | UCI (not significant against three runner-ups), four MIL sets (one loss), two of four drug-design sets. Nothing here is a language-model result, despite the title |
| **Forgetting has no schedule** | `γ` is introduced with no rule for setting it and no experiment |

---

## Connections

- **[[wiki/entities/hopfield-network.md]]** — the last row of that page's failure table made primary: continuous states remove the one-unit-per-bit cost, `0.14N` becomes exponential in `d`, and convergence drops from a settling pass to a single update — while the two properties that page treats as intrinsic to the classical model, spurious minima and a design-time capacity, both survive intact.
- **[[wiki/entities/dense-associative-memory.md]]** — the same capacity move made continuous: there the exponent `n` of `F(x)=x^n` is the knob and states are bipolar, here `F = exp` is fixed and the knobs are `β` and the pattern radius `K`, so the capacity base is set by *geometry* rather than by the read-out nonlinearity — and the separation/completion trade-off that page reads off `n` is read off `βΔ_i` here.
- **[[wiki/entities/two-body-dense-associative-memory.md]]** — the principled derivation of this page's energy: model B's Lagrangian pair (`log Σ_μ e^{h_μ}`, `½Σ_i v_i²`) at `τ_h → 0` yields this update with the boundedness falling out instead of being added by hand, and it adds the ceiling `N_mem ≤ N_h` that this page's exponential bound assumes away.
- **[[wiki/concepts/attention.md]]** — the identity `ξ^new = X softmax(β Xᵀξ)` ⇒ `softmax(QKᵀ/√d_k)V` stated from the memory side, which converts that page's central operator into an associative read with an energy, a convergence proof for iterating it, a capacity bound in `d_k`, and the finding that `1/√d_k` is an inverse temperature selecting which of three fixed-point regimes a head occupies.
- **[[wiki/entities/transformer.md]]** — the post-hoc theory of that page's operator: `1/√d_k`, introduced there purely to stop the softmax saturating, is the regime selector here; multi-head's "reduced effective resolution due to averaging attention-weighted positions" is regime (a) named from the other side; and iterating a layer becomes licit because the update descends an energy.
- **[[wiki/concepts/attractor-dynamics.md]]** — a discrete-attractor store whose *number* of fixed points is continuously controllable: at low `β` the landscape has one global minimum, at high `β` one per pattern, and in between one per cluster, so "how many attractors" stops being an architectural commitment and becomes a temperature — with the Gaussian-mixture form showing that the count can exceed the number of stored patterns.
- **[[wiki/concepts/retrieval-capacity.md]]** — the same exponential-in-`d` shape reached from opposite directions, and the two bounds are on different quantities: here `N ≥ √p c^{(d−1)/4}` counts *items* a `d_k`-dimensional store holds at a separation `Δ_i`, there `C(n,k) ≤ (1+1/γ)^d` counts *retrieval sets* the same `d` can address at a margin `γ` — and `βΔ_i` and `γ` play the identical role of the margin that converts a combinatorial count into a usable one.
- **[[wiki/concepts/fast-weight-programming.md]]** — the same layer read with the softmax deleted: removing it makes the store a sum of outer products with a hard rank capacity `d_dot` and correctable writes, keeping it makes the store a non-parametric cache with exponential capacity and no write operation at all — so softmax-vs-linear attention is a choice between a bounded programmable matrix and an unbounded content list.
- **[[wiki/entities/tem-transformer.md]]** — the model that runs on this page's identity, and it uses the pre-softmax version: its attractor update `q_t M_t = Σ_τ (q_t·p_τ) p_τ` is this update at `β → 0` on the dot products, i.e. deliberately in the averaging regime, with keys carrying structural addresses and values content.
- **[[wiki/concepts/energy-based-models.md]]** — a worked case of making an energy *continuous* without losing its minima: `−log` of the exponential-interaction energy plus a quadratic confinement term keeps the fixed points and buys differentiability, which is what lets an energy-based store be dropped into a gradient-trained stack as a layer.
- **[[wiki/concepts/pattern-separation-completion.md]]** — separation made a scalar with a bound attached: `Δ_i = ½ min_{j≠i} ‖x_i − x_j‖²` for equal-norm patterns, and every retrieval-error bound on this page is `exp(−βΔ_i)` — so "how separated must two memories be" has a numerical answer for the first time, and the metastable regime is completion-over-a-cluster rather than a failure.
- **[[wiki/concepts/memory-read-and-erase.md]]** — the cheapest erase operator in the wiki: subtracting `γ(t−i)` inside the `lse` gives exponential recency weighting with the descent guarantee intact, so forgetting is one addend in the energy rather than a separate eviction policy — but `γ` is never scheduled and nothing is ever actually removed from `X`.
- **[[wiki/entities/vector-hash.md]]** — the contrast that survives exponential capacity: both stores hold a number of states exponential in a dimension, but prestructured fixed points are provably convex and spurious-free where this page's Gaussian-mixture energy can have more modes than it has stored patterns, so capacity and landscape cleanliness are independent purchases.
- **[[wiki/entities/sparse-distributed-memory.md]]** — the two available occupancy signals, at different granularities: `|s_u|` is a per-read confidence computed from the vote margin, `Δ_i` here is a per-store separation computed from the keys alone without any query, and neither system gates on its own number.
- **[[wiki/concepts/sparse-expert-routing.md]]** — the same softmax-sharpening pathology at a different address: a head that commits to regime (c) has `diag(p) − ppᵀ ≈ 0` and stops receiving gradient, which is the continuous analogue of a router that collapses onto one expert, and the `1/√d_k` and the router z-loss are the same patch applied to the same failure.
