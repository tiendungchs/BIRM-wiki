# Selective Prediction — Splitting the Answer From the Decision to Answer, and Buying a Guarantee With Coverage

**A predictor is two functions, not one: a classifier `f` and a selection function `g` that may return *don't know*. Once the pair is the object, performance stops being a scalar and becomes a **risk–coverage curve**, and the free parameter along that curve is a dial the user sets rather than a property of the model. The consequence that matters here: a *finite-sample, distribution-free guarantee* on error becomes purchasable — not by improving the model, but by rejecting enough of the domain, and the price is stated in coverage.**

> **Provenance.** Geifman & El-Yaniv 2017, *Selective Classification for Deep Neural Networks*, NIPS 2017 (`raw/geifman-2017-selective-classification.md`). Formalism from El-Yaniv & Wiener 2010; reject option from Chow 1957. Empirical work is VGG-16 / ResNet-50 on CIFAR-10, CIFAR-100 and ImageNet. Nothing here is about reasoning; the object it supplies is.

Why this earns a page rather than a paragraph on [[wiki/concepts/metacognitive-efficiency.md]]: that page scores a confidence *read-out*. This one turns a read-out into a **policy with a proof attached**, and the proof is the only guaranteed competence claim in the wiki (`G89`).

---

## The formalism

| Object | Definition |
|---|---|
| Selective classifier | `(f,g)(x) = f(x)` if `g(x)=1`, else **don't know**; `g : X → {0,1}` |
| Coverage | `φ(f,g) = E_P[g(x)]` — probability mass of the non-rejected region |
| **Selective risk** | `R(f,g) = E_P[ℓ(f(x),y)·g(x)] / φ(f,g)` — risk *conditioned on having answered* |
| Risk–coverage curve | `R` as a function of `φ`. The full performance profile; a single accuracy is the point `φ = 1` |
| Confidence-rate function | `κ_f : X → ℝ⁺`, assumed only to **rank**. `g_θ(x) = 1 ⟺ κ_f(x) ≥ θ` |
| The target | `Pr_{S_m}{ R(f,g) > r* } < δ` — pick `r*` and `δ`, maximise `φ` subject to it |

**The ideal `κ_f` is defined and is not achievable:** `κ_f(x₁) ≤ κ_f(x₂) ⟺ ℓ(f(x₁),y₁) ≥ ℓ(f(x₂),y₂)`. Note what it asks — *loss monotonicity*, i.e. pure **resolution** in [[wiki/concepts/metacognitive-efficiency.md]]'s decomposition, with calibration irrelevant. A selective classifier does not need the confidence number to mean anything; it needs the ordering to be right. The threshold supplies the scale.

---

## SGR — where the guarantee comes from

```
SGR(f, κ_f, δ, r*, S_m):
  sort S_m by κ_f;  z_min = 1;  z_max = m;  k = ⌈log₂ m⌉
  repeat k times:
     z = ⌈(z_min+z_max)/2⌉;  θ = κ_f(x_z);  g_i = g_θ
     r̂_i = empirical selective risk of (f,g_i) on S_m
     b*_i = B*(r̂_i, δ/k, g_i(S_m))                 ← binomial-tail bound, Lemma 3.1
     if b*_i < r* then z_max = z else z_min = z
  return (f, g_k), b*_k
```

Three separable ingredients, and the third is the one the wiki lacks elsewhere:

1. **Lemma 3.1** — `b` solving `Σ_{j=0}^{m·r̂} C(m,j) b^j (1−b)^{m−j} = δ` is the **tightest numerical bound** on true risk from an empirical risk on a labelled sample; Hoeffding and friends are slack approximations of it (Gascuel & Caraux 1992).
2. **Theorem 3.2** — the bound survives the fact that `g_i` *selects* the sample it is then evaluated on. The trick: apply Lemma 3.1 under the projected distribution `P_g = P(X,Y | g(X)=1)`, note `R(f|P_g) = R(f,g)` identically, then condition on `|g_i(S_m)| = n` and sum — the conditional bound holds for every `n`, so it holds unconditionally.
3. **Union bound over the search** — `k = ⌈log₂ m⌉` thresholds are tested, so each is tested at `δ/k`. The binary search costs a factor of ~13–15 in confidence and nothing else.

**What this is not.** It is not a calibration method and not an uncertainty estimate. It converts a *ranking* plus a *labelled held-out sample* into a threshold with a proof. The referent is the labels.

---

## Measured, δ = 0.001 throughout

| Dataset / task | Model | Target risk `r*` | Test risk | **Test coverage** | Bound `b*` |
|---|---|---|---|---|---|
| CIFAR-10 | VGG-16 | 0.01 | 0.0092 | **78.6%** | 0.0099 |
| CIFAR-10 | VGG-16 | 0.05 | 0.0486 | 96.0% | 0.0491 |
| CIFAR-100 | VGG-16 | 0.02 | 0.0187 | **21.3%** | 0.0197 |
| CIFAR-100 | VGG-16 | 0.15 | 0.1327 | 67.5% | 0.1498 |
| ImageNet top-1 | ResNet-50 | 0.02 | 0.0164 | 25.9% | 0.0199 |
| ImageNet top-5 | ResNet-50 | 0.01 | 0.0085 | 38.1% | 0.0099 |
| ImageNet top-5 | ResNet-50 | 0.02 | 0.0189 | **59.4%** | 0.0200 |

- **The bound is never violated and is never loose** — `b*` sits within ~0.0001–0.005 of `r*` in every row, and test risk sits under `b*` in every row. The binomial bound is not a formality bought with an order of magnitude.
- **The curve's shape is the interesting quantity, not any point on it.** CIFAR-10 buys a 10× error reduction for 21 points of coverage; CIFAR-100 pays 79 points of coverage for the same target. **The exchange rate between coverage and risk is a property of the dataset**, i.e. of how well the confidence order tracks the loss on *that* distribution — which is exactly a resolution measurement, reported as a curve instead of an AUROC.
- **A selective classifier at partial coverage beats the full-coverage state of the art**, and the comparison is not fair and is made anyway: CIFAR-100 at 67.5% coverage reaches 13.3% error against the then-best 18.85% at full coverage. The wiki should treat *every* accuracy number quoted against a selective one as incomparable unless coverage is stated (`F15` in [[wiki/concepts/certification-instruments.md]]: an undifferenced score is partly a different score).

---

## The confidence-rate comparison, and why it bites

Two `κ_f` are tried:

| `κ_f` | Definition | Cost |
|---|---|---|
| **Softmax response (SR)** | `max_j f(x|j)` — the largest output logit's softmax | **Zero.** One forward pass, already computed |
| **MC-dropout** | Minus the variance, across repeated dropout-perturbed forward passes, of the neuron for the most probable class (Gal & Ghahramani 2016) | `n` forward passes |

| Result | Reading |
|---|---|
| CIFAR-10 / CIFAR-100: risk–coverage curves **nearly identical** | The extra passes buy nothing |
| ImageNet top-1, 60% coverage: **SR ≈10% error, MC-dropout >20%** | The extra passes buy something **negative**, and the gap is a factor of two |

**This is a direct hit on `G89`'s closing clause** — *"beat a confidence scalar read off the same forward pass"*. The wiki had been treating that scalar as the weak baseline to be beaten. Here it is the *strong* baseline: the one sampling-based alternative tried loses, and loses worst on the hardest dataset. The proposed intuition (Fig. 1, MNIST) is that the penultimate layer's true-positive activations are both higher and **spread over many neurons**, so the softmax max aggregates a large number of independent detections — i.e. SR is strong because it is an ensemble already, and re-ensembling it by dropout perturbs the aggregation rather than adding to it *(the paper offers no rigorous account; this reading is `(brainstorm)`)*.

---

## What the guarantee costs — the assumptions, stated as a bill

| Assumption | Consequence if violated | Where the wiki already violates it |
|---|---|---|
| `S_m` is i.i.d. from the same `P` as deployment | The bound says **nothing**. It is a statement about a fixed distribution, not about robustness | Every distribution-shift result in the wiki: [[wiki/entities/objectnet.md]]'s 40–45% drop, [[wiki/entities/math-perturb.md]]. A guaranteed 1% risk transfers to a shifted domain not at all |
| Labels are available on `S_m` | The calibrator is a **labelled sample**, not a model, so it does not amortise and cannot run per-query on an unseen distribution | `G89` asks for an *amortised* competence model; this supplies a one-off threshold |
| 0/1 loss, bounded label set | Undefined for open-ended generation | The same wall [[wiki/concepts/metacognitive-efficiency.md]] hits: `d′` and `κ_f`-as-max-softmax both need a closed response set. Named as future work in the source |
| `f` is fixed and trained for full coverage | `g` is fitted to a classifier that was never asked to be rejectable. The paper names joint training of `(f,g)` as the **main open problem** | Every architecture in the wiki, all of which optimise the `φ=1` point |
| One risk target, symmetric | No control over false-positive vs false-negative rates separately; no regression | Named as future work |

---

## The wiki has been drawing risk–coverage curves without naming them

| Existing measurement | What it is in this vocabulary |
|---|---|
| [[wiki/entities/olymmath.md]] `Pass@64 = 74.0` vs `Cons@64 = 22.0` | Two points on the curve with the selector swapped — coverage the generator paid for, discarded by a bad `κ_f`. At 1.5B, `P@64 = 30.0 / C@64 = 0.0` is a `κ_f` **anti-correlated** with loss, the exact negation of loss monotonicity |
| [[wiki/entities/poe-arc-solver.md]] acceptance threshold `T = 9% → 0.5%` | A sweep of `θ`, reported as two numbers instead of a curve: candidate-set coverage +7.5, final score +0.2 |
| [[wiki/entities/gpqa.md]] abstention 4.0% → 37.2%, accuracy flat | A move **along** the coverage axis with the risk axis unchanged — the curve is flat there, so the abstentions were uninformative |
| [[wiki/entities/arc-vsa-solver.md]] mean max-softmax over parse similarities | A `κ_f` over *discretisations* rather than answers, already computed and never thresholded (its own page flags this) |
| [[wiki/entities/switch-transformer.md]] token rerouting on expert overflow | Abstention at the module level, worth nothing — a wrong module is worse than no module, which is a statement about the *cost of a rejection*, the term this formalism sets to zero |

**The formalism's cost model is where it and the wiki disagree.** `R(f,g)` charges nothing for a rejection; coverage is reported separately and the trade is left to the user. In a reasoning system a rejection is not free — it triggers a tool call, a re-plan, or a human. The cost-based rejection literature the paper explicitly declines to use (Chow 1957; Cordella et al. 1995) is the one a [[wiki/concepts/refinement-loop.md]] actually needs, and the paper's argument for declining — that the costs are unquantifiable for an autopilot — is weaker for a solver, where the cost of a re-plan is *measured in tokens*.

---

## What this buys a reasoning model **(brainstorm)**

- **It makes "know what you don't know" a scalar with a dial rather than a virtue.** The abstention policy is one number `θ`, set post-hoc against a target, with the model untouched. Any architecture in the wiki that emits a scored candidate already has a `κ_f`; none of them thresholds it.
- **The guarantee is the missing half of `G68`.** A rejector that is *internal* cannot lift the proposer's ceiling — this paper agrees, and shows it does not have to: at fixed `f` it moves error to any target by moving coverage. So the wiki's proposer/rejector framing should carry two distinct claims: an internal `κ_f` buys a **trade with a proof**, an external verifier buys a **ceiling lift without one**. They are not competitors.
- **Coverage is the honest reporting axis for every ARC-style result.** A solver that emits an answer on every task and one that abstains on a third are currently scored on the same line. Reporting `(risk, coverage)` costs nothing and is the cheapest instrument in the wiki (`I34`).
- **A per-problem-class threshold is a competence model in the sense `G89` wants, and is one line of code.** Fit `θ_c` per class `c` with a per-class labelled sample; the vector `{θ_c}` *is* an amortised, calibrated statement of what the system is good at, and it costs `Σ_c m_c` labels. The reason nobody does this is the labels, not the mechanism.
- **Selective prediction is where an [[wiki/concepts/adaptive-computation-time.md]] halting unit should be trained, not where it currently is.** ACT's ponder cost is a hand-set scalar with no target; SGR shows the same knob has a *specified* target available — the halting rule is a `g`, and a risk target is what the ponder-cost hyperparameter is standing in for.

---

## Open problems

| Problem | Why it is open |
|---|---|
| **Joint training of `(f,g)`** | The paper's own named main open problem. A classifier optimised for full coverage is not the classifier that maximises coverage at a fixed risk — nothing in the wiki trains for the second |
| **Nothing beats max-softmax** | One alternative tried, and it lost. Whether a `κ_f` that is not a read-out of the answer path exists at all is `G89`'s question, now with a hard baseline attached |
| **The guarantee has no shift-robust version** | The bound is over a fixed `P`. The interesting deployments are all shifted, and a coverage guarantee that silently fails is worse than none |
| **Open-ended generation has no `κ_f` and no `d′`** | Same wall as [[wiki/concepts/metacognitive-efficiency.md]]. Sequence log-probability is length-confounded; the wiki's one AUROC on it is 68.8% |
| **Rejection is priced at zero** | The risk–coverage trade assumes an abstention is free. For a system that must do *something*, the right object is a cost-weighted curve, and nobody has drawn one |
| **Relation to active learning is asserted and unexplored** | El-Yaniv & Wiener 2012 link selective classification to active learning for linear classifiers; for deep networks it is untried, and it is the route by which a rejection could become a *training signal* rather than a refusal |

---

## Connections

- **[[wiki/concepts/metacognitive-efficiency.md]]** — the two halves of one measurement: that page factors a confidence read-out into bias/sensitivity/efficiency, this one shows only the **sensitivity** half is needed for a policy, because a threshold absorbs any monotone re-scaling of the confidence scale. The risk–coverage curve is a sensitivity measurement reported as a curve rather than as an AUROC, and it is defined wherever a ranking is.
- **[[wiki/concepts/external-verification.md]]** — the complementary move: a verifier changes *which* answer is emitted at fixed coverage, `g` changes *whether* one is emitted at fixed `f`. Both are rejectors; only this one comes with a bound, and only that one can raise the ceiling.
- **[[wiki/concepts/certification-instruments.md]]** — contributes `I34`, the only instrument in the inventory whose output is a **proved bound** rather than a score, and a second reading of `F15`: an accuracy quoted without a coverage is not comparable to one quoted with it.
- **[[wiki/concepts/adaptive-computation-time.md]]** — the same decision at a different exit: ACT decides *how long to think* with an unspecified target, `g` decides *whether to answer* with a specified one; a halting unit trained against a risk target is the untried combination.
- **[[wiki/concepts/evidence-accumulation.md]]** — the mechanism a `κ_f` would be if it were dynamic: a bound on a decision variable *is* a threshold on a confidence rate, and the collapsing-bound literature is the time-varying `θ` this static formalism has no version of.
- **[[wiki/concepts/precision-weighting.md]]** — precision is the quantity `κ_f` is meant to report; this page says the report only ever needs to be **ordinally** correct, which weakens what a precision estimate must achieve to be usable.
- **[[wiki/concepts/default-self-model.md]]** — a competence model reduced to its minimum viable form: a per-class threshold vector fitted against labels, amortised across queries, with a proof — and with a calibrator (the labelled sample) that is genuinely outside the estimating loop, which is that page's requirement met in the cheapest possible way and only for a fixed distribution.
- **[[wiki/entities/olymmath.md]]** — its Pass@k / Cons@k table is a two-point risk–coverage measurement, and its 1.5B `C@64 = 0.0` is the empirical counter-case to this page's central assumption: a confidence order can be *anti*-monotone in loss, at which point rejecting the low-`κ` tail raises risk (T320).
- **[[wiki/entities/poe-arc-solver.md]]** — its acceptance-threshold sweep is a `θ` sweep, and its aggregator ordering (`∏` > `min` > mean > `max`) is a comparison of `κ_f` constructions over *views*, orthogonal to this page's `κ_f` over classes; the two "max is best / max is worst" results are about different maxima.
- **[[wiki/entities/gpqa.md]]** — its abstention shift is a coverage move with no risk move, i.e. a measured point where the risk–coverage curve is flat and the rejections carry no information.
- **[[wiki/entities/switch-transformer.md]]** — module-level abstention priced: rerouting overflowed tokens rather than dropping them buys nothing, so a rejection is not free at the module level even though this formalism prices it at zero.
- **[[wiki/entities/esbn.md]]** — a match-strength signal read off the store's own addressing dot products (`c_k = σ(γ M_v·z + β)`) rather than from a calibration head — and its architectural substitute, a single learned default memory row, which makes the *mixedness* of a retrieval the familiarity signal.
