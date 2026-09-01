# Sparsely-Gated Mixture-of-Experts Layer

**A layer of up to 131,072 identical feed-forward experts with a noisy top-`k` router, inserted convolutionally between stacked LSTM layers, trained end to end by backpropagation with two auxiliary balance losses — the first demonstration that conditional computation buys real capacity at fixed compute (Shazeer et al. 2017).**

> **Provenance.** Shazeer, Mirhoseini, Maziarz, Davis, Le, Hinton & Dean 2017, *Outrageously Large Neural Networks: The Sparsely-Gated Mixture-of-Experts Layer* (`raw/shazeer-2017-sparsely-gated-mixture-of-experts.md`, ICLR). The originating system for [[wiki/concepts/sparse-expert-routing.md]]; that page holds the taxonomy and the five years of results that followed, this page holds the mechanism as first stated and the measurements only this source reports.

The layer matters here for two things the survey literature no longer states: **the noise term is a differentiability device, not an exploration device**, and the capacity win is contingent on data volume in a way that is measured rather than asserted.

---

## Architecture

| Component | Definition |
|---|---|
| Experts `E_1…E_n` | Identical-architecture feed-forward nets, **separate parameters**, one ReLU hidden layer of thousands of units; ~1M params each (LM) or ~2M (MT) |
| Output | `y = Σ_i G(x)_i · E_i(x)`; `G(x)_i = 0` ⟹ `E_i` never evaluated |
| Router | `H(x)_i = (x·W_g)_i + StandardNormal()·Softplus((x·W_noise)_i)`, then `G(x) = Softmax(KeepTopK(H(x), k))`, non-top-`k` entries set to `−∞` |
| `k` | 4 (LM), 2–4 (MT). Conjectured `k ≥ 2` necessary "to compare and optimise the relative performance" — **later falsified** by Switch's `k = 1` |
| Placement | Between two stacked LSTM layers, applied **convolutionally**: called once per text position, a different expert combination at each |
| Hierarchical variant | `a` groups × `b` experts, primary gate over groups × secondary gate within — reduces the router's branching factor from `n` to `a + b`; used for 256/1024/4096 experts |
| Init | `W_g = W_noise = 0`, so at step 0 the router is **pure noise** and the load is uniform by construction (the soft constraints need time to bind, and an OOM in the interim is fatal) |

Gradient reaches `W_g` only through the `p_i` scaling of the selected experts — the argmax is dead. This is the deliberate escape from the reinforcement-learning formulation of expert selection ([[wiki/concepts/discrete-relaxation-gradients.md]] holds the alternative that would have made the selection itself differentiable).

---

## The noise term does two jobs, and the second is the interesting one

`Importance(X)_i = Σ_{x∈X} G(x)_i` is the batch-wise sum of gate values — differentiable, but it constrains *mass*, not *count*: one expert can take three examples at weight 0.9 while another takes thirty at weight 0.09. The count is discrete and carries no gradient.

The noise supplies one. With `σ_i(x) = Softplus((x·W_noise)_i)` and everything else's noise held fixed, the probability that expert `i` survives the top-`k` is available in closed form:

```
P(x,i) = Φ( [ (x·W_g)_i − kth_excluding(H(x), k, i) ] / σ_i(x) )
Load(X)_i = Σ_{x∈X} P(x,i)
L_load = w_load · CV(Load(X))²          L_importance = w_imp · CV(Importance(X))²
```

**`Load` is a smooth estimator of a discrete count, obtained by integrating the injected noise analytically rather than by relaxing the sample.** The trainable `W_noise` makes the sharpness of that estimator per-input and learned. This is a third route past a discrete bottleneck alongside relaxation and score-function estimation, and it is the one that applies when the quantity needing a gradient is an *aggregate statistic over a batch* rather than the sample itself.

---

## Load collapse, quantified

The rich-get-richer failure mode with a number attached (MoE-256, 10 epochs, 1B-word benchmark):

| `w_importance` | `w_load` | Test ppl | `CV(Importance)` | `CV(Load)` | `max(Load)/mean(Load)` |
|---|---|---|---|---|---|
| 0.0 | 0.0 | **39.8** | 3.04 | 3.01 | **17.80** |
| 0.2 | 0.0 | 35.6 | 0.06 | 0.17 | 1.47 |
| 0.0 | 0.2 | 35.7 | 0.22 | 0.04 | 1.15 |
| 0.1 | 0.1 | 35.6 | 0.06 | 0.05 | 1.14 |
| 1.0 | 1.0 | 35.7 | 0.03 | 0.02 | 1.07 |

Three readings a builder should carry:

- **Unpenalised discrete selection collapses hard and costs 4.2 perplexity points**, with the most-loaded expert taking 17.8× the mean.
- **The penalty is almost free to tune.** Every non-zero setting lands within 0.1 ppl of every other across a 100× range of `w`. This is unusual — the anti-collapse coefficient sweeps on the joint-embedding side of the wiki are *not* like this ([[wiki/concepts/representational-collapse.md]]: VICReg collapses over most of its coefficient space). A discrete selection variable appears to be far easier to hold up than a continuous embedding.
- **The two losses are near-interchangeable for quality and separable for engineering.** Either alone recovers full perplexity; only `w_load` controls the tail (`max/mean` 1.47 vs 1.15), which is the quantity that decides whether a device runs out of memory.

---

## Results: capacity only pays if the data pay for it

| Setting | Finding |
|---|---|
| 1B-word LM, ~8M ops/timestep held fixed | 4 → 4096 experts: **24% lower test perplexity** at equal compute. Returns diminish past ~1B MoE parameters |
| 1B-word LM, high capacity (4.3B params) | 34.1 ppl at **8.9M** ops/timestep vs 34.7 for the 151M-param published SOTA at 151M ops/timestep — beats it at **6% of the compute**; 28.0 ppl at 142.7M ops |
| 100B-word LM, ~8M ops/timestep | Improves monotonically to **65,536 experts / 68B params (99.994% layer sparsity)**, 39% below the compute-matched baseline — then **degrades at 131,072 experts**, "possibly a result of too much sparsity" |
| WMT'14 En→Fr / En→De | +1.34 / +1.12 BLEU over GNMT at 85M vs 214M ops/timestep |
| Multilingual MT (12 pairs) | One 8.7B MoE at 102M ops/timestep beats multilingual GNMT on **11 of 12** pairs (up to +5.84 BLEU) and beats the **12 separately trained monolingual** models on 8 of 12. Fails only En→Ko, attributed to oversampling of a rare pair |
| Efficiency | 0.72–1.56 TFLOPS/GPU against a 1.07–1.29 dense baseline; experts are only 37–46% of total FLOPs |

**The capacity–data interaction is the load-bearing result.** The same architecture saturates at ~1B parameters on 829M words and keeps paying to 68B parameters on 100B words. Extra parameters are not extra ability; they are extra *room for information the corpus actually contains*, and the wiki should read every sparse-capacity claim as indexed to a token budget.

**And there is a measured sparsity ceiling.** 65,536 experts helps, 131,072 hurts, at constant data and constant compute. Each expert's batch is `kbd/n`; past some `n` an expert sees too few examples to be estimated. This is the same statistic that governs whether a growing module library can be trained at all ([[wiki/entities/cn-dpm.md]]) and it is the only number in the literature that bounds the useful size of such a library from *below the router*, independently of whether the router can retrieve correctly.

---

## The bandwidth argument, and why modules cannot be small

An expert's compute-to-I/O ratio equals **its hidden layer size** (weights are `in×hid` and `hid×out`; traffic is `in + out`). For the ratio to exceed a GPU cluster's compute-to-bandwidth ratio — "thousands to one" — the hidden layer must be thousands of units wide.

**(brainstorm)** This is a hardware fact that reads as an architectural constraint with a biological analogue. A conditionally-computed module pays a fixed communication cost to be reached, so there is a minimum size below which a module is not worth addressing — and the same inequality is what wiring cost imposes on cortical modules, where long-range axons are metabolically and volumetrically expensive and the ratio of local computation to projected output sets whether a distinct area is worth having. The wiki's fine-grained module proposals (typed primitives, per-relation experts) sit on the wrong side of this inequality on current hardware, which is a reason the field's experts stay coarse and lexical that is *independent* of anything about learning.

---

## Limitations

- **Every routed unit is a token position.** Nothing in the design routes a step of a computation, and the reasoning-transfer deficit later measured across this whole family is what one predicts from that ([[wiki/concepts/sparse-expert-routing.md]]).
- **Experts are homogeneous by construction** — identical architecture, identical size — so the routing decision allocates parameters and never compute per input.
- **Specialisation is lexical.** In the 2048-expert En→Fr encoder, experts key on the *innovation/research* lexical field, on the article "a" introducing a direct object in a leadership verb phrase, and on synonyms of *speed*. One function word, two semantic fields, no relation and no rule.
- **The router is a function of an already-contextualised embedding**, so nothing in the analysis separates a context-sensitive router from a token-identity one — the caveat that keeps `T296` live.
- **`k ≥ 2` was asserted from a gradient argument and was wrong**, which cost the field a 2× routing overhead for four years. A gradient-availability argument is not an argument about what a network can learn.
- Discontinuity of the top-`k` gate is acknowledged as "theoretically scary" and dismissed empirically; no analysis is offered.

---

## Comparison

| System | Routed unit | Router | Experts | Balance provision |
|---|---|---|---|---|
| **Sparsely-gated MoE** (2017) | Token position | Learned, noisy top-`k`, `k = 2–4` | 4–131,072 identical FFNs | Two auxiliary CV² losses |
| [[wiki/entities/switch-transformer.md]] (2022) | Token | Learned, `k = 1` | ≤2048 identical FFNs, in place of the Transformer FFN | One auxiliary loss + float32 router + 0.1× init + expert dropout |
| [[wiki/entities/neural-module-networks.md]] | Sub-question | **Unlearned** dependency parser | 5 heterogeneous *typed* modules | None needed — layout comes from syntax |
| [[wiki/entities/cn-dpm.md]] | Whole example | Bayesian responsibility (CRP × likelihood) | Grown on demand, classifier + density each | Dirichlet-process prior |

---

## Connections

- **[[wiki/concepts/sparse-expert-routing.md]]** — the originating system for that page's primitive: this page holds the noisy-top-`k` gate as first written, the two balance losses with the ablation table behind them, and the capacity-vs-data measurement, while that page holds the taxonomy and the downstream results that superseded the `k ≥ 2` conjecture.
- **[[wiki/concepts/representational-collapse.md]]** — supplies the discrete-variable instance with numbers: an unregularised router collapses to `max/mean` load 17.8 and 4.2 ppl, and — unlike every continuous-embedding provision on that page — the repair is insensitive to its coefficient across a 100× range, which suggests a discrete selection variable is a *structurally easier* thing to hold up than an embedding.
- **[[wiki/concepts/discrete-relaxation-gradients.md]]** — the third route past a discrete bottleneck, and the one that page lacks: instead of relaxing the sample (Gumbel-softmax) or estimating with a score function, integrate the injected noise analytically to get `P(x,i) = Φ(·)`, a smooth estimator of a *batch-level count* whose sharpness `Softplus(x·W_noise)` is itself learned.
- **[[wiki/entities/neural-module-networks.md]]** — the same year's opposite answer to the same question: keep the modules few, heterogeneous and typed, route a sub-question rather than a token, and do not learn the router at all — which is where relational specialisation appears and where this system's lexical experts do not.
- **[[wiki/entities/cn-dpm.md]]** — the expansion-family counterpart: both grow capacity by adding experts, but CN-DPM's router must *retrieve* the right expert without labels (48.18% at 5 experts) where this system's router only has to be self-consistent, so the two together separate the cost of allocating a library from the cost of indexing one.
- **[[wiki/entities/transformer.md]]** — the host the layer moved to: nothing here is Transformer-specific — the MoE sits between LSTM layers and is applied convolutionally over positions, which is exactly the substitution later made for the Transformer feed-forward block.
- **[[wiki/concepts/continual-learning.md]]** — the multilingual result is the strongest positive transfer measurement in this family: one 8.7B sparse model beats twelve separately trained monolingual models on 8 of 12 language pairs at half the compute, so conditional parameters bought sharing *and* task-specific capacity in the same model rather than trading them.
- **[[wiki/concepts/emergent-modularity.md]]** — the first large-scale measurement of that page's claim, and a negative one: 2048 modules emerged from scale plus a routing bottleneck alone, and what they encode is a lexical field, an article, and a synonym set.
- **[[wiki/entities/switch-transformer.md]]** — the successor that removed four of this design's components at once (top-`k` → top-1, two balance losses → one, the noise-integrated `Load` estimator → plain input jitter, the hierarchical gate → a flat softmax) with no quality cost, which retroactively prices the apparatus above: the `k ≥ 2` conjecture stated here was false, and the differentiability machinery around the batch count turns out to be optional once the balance loss pairs a raw dispatch count with a differentiable probability.
- **[[wiki/entities/universal-transformer.md]]** — the other axis of conditional computation, measured without touching parameter count: instead of selecting *which* experts run at fixed depth, one shared block runs a per-position variable number of times, which moved WMT14 EN→DE by 0.9 BLEU at matched parameters — so depth-conditioning and parameter-conditioning are independent levers and no source in the wiki combines them.
