# Confidence Calibration — The Bias Term Is One Parameter Wide, and Modern Networks Broke It While Getting Better

**Calibration is the requirement that a stated probability match the base rate it names: `P(Ŷ=Y | P̂=p) = p`. It is *one* of the two terms a confidence number decomposes into ([[wiki/concepts/metacognitive-efficiency.md]]: calibration `C` and resolution `R`), and this page's result is that the two are not merely separable in theory but separable in *cost*: on every architecture tested, the entire calibration defect of a modern network is removed by fitting **a single scalar** on a held-out set, and doing so changes **no prediction, no ranking and no accuracy — exactly zero of them**. The corollary is the load-bearing one for this wiki: an architecture's confidence bias is cheap and its confidence *resolution* is not purchasable at all, so any effort spent on "the model is overconfident" is spent on the wrong half.**

> **Provenance.** Guo, Pleiss, Sun & Weinberger 2017, *On Calibration of Modern Neural Networks*, ICML (`raw/guo-2017-calibration-modern-neural-networks.md`). Empirics: ResNet / ResNet-SD / Wide ResNet / DenseNet / LeNet on Birds, Cars, ImageNet, CIFAR-10/100, SVHN; DAN-3 on 20 News and Reuters; TreeLSTM on SST. All closed-set classification. The causal claims in §"What broke it" are the authors' own, and they disclaim causality.

Why this earns a page rather than a paragraph: [[wiki/concepts/metacognitive-efficiency.md]] names the calibration/resolution split and states that "the learning of that mapping is barely studied"; [[wiki/concepts/selective-prediction.md]] shows a policy needs resolution *only*. Neither says what the calibration term costs to fix, whether it is high- or low-dimensional, or what in a training pipeline produces it. This page answers all three, and the answers are surprising in the direction that matters (cheap, one-dimensional, produced by the things that improve accuracy).

---

## The formalism, and the instrument

| Object | Definition |
|---|---|
| **Perfect calibration** | `P(Ŷ = Y | P̂ = p) = p ∀p ∈ [0,1]` — unachievable, and `P̂` continuous, so every practical measure bins |
| Reliability diagram | `acc(B_m)` plotted against `conf(B_m)` over `M` equal-width confidence bins; the identity line is perfect. Shows no bin *masses*, so it cannot say how much of the data is calibrated |
| **ECE** | `Σ_m (|B_m|/n)·|acc(B_m) − conf(B_m)|` — the `M`-term Riemann–Stieltjes sum of `E_P̂[ |P(Ŷ=Y|P̂=p) − p| ]`. The paper's primary metric, `M = 15` |
| **MCE** | `max_m |acc(B_m) − conf(B_m)|` — the worst-case bin. **The authors report it as unreliable**: "very sensitive to the binning scheme and less suited for small test sets" |
| NLL | `−Σ_i log π̂(y_i|x_i)`; minimised in expectation iff `π̂(Y|X) = π(Y|X)`, so it is an indirect calibration measure and the quantity training actually descends |

**ECE is an estimator with a free parameter and the wiki has been quoting calibration numbers without it.** `M` is a binning choice; MCE's instability across binning schemes is the same defect at its extreme (SST fine-grained TreeLSTM: temperature scaling improves ECE 6.71 → 2.56 while MCE *worsens* 27.85 → 44.75 on the same predictions). [[wiki/entities/hle.md]]'s RMS calibration error of 73–89% inherits this: a binned deviation statistic on 2,500 items with no stated bin count and no stated bin occupancies.

---

## What broke it — miscalibration is a property of the modern recipe, not of neural networks

The headline comparison is a controlled one: on CIFAR-100, a 5-layer LeNet is well calibrated at 44.9% error; a 110-layer ResNet is badly miscalibrated at 27.8% error. **Accuracy and calibration moved in opposite directions across a decade of architecture progress.**

| Factor swept | Direction | Reading |
|---|---|---|
| **Depth** (ResNet, 64 filters/layer, CIFAR-100) | ECE grows substantially with depth while error falls | |
| **Width** (14 layers, filters/layer swept) | Same | Capacity, not depth specifically |
| **Batch Normalization** (6-layer ConvNet, ±BN) | ECE **worse** with BN, accuracy slightly better; holds at every learning rate tried | The enabler of very deep nets is also a miscalibrator |
| **Weight decay** (110-layer ResNet, swept) | ECE keeps falling well past the weight-decay value that minimises error | **Calibration and accuracy are not optimised by the same hyperparameter** — the single sharpest practical statement in the paper |

**The mechanism, stated by the authors: NLL overfits while 0/1 loss does not.** After the training set is (nearly) fit, NLL can still be reduced by *sharpening* the predictive distribution, so a higher-capacity model becomes more confident on average by construction. Measured on CIFAR-100 with a 110-layer ResNet-SD: after the learning-rate drop at epoch 250, test NLL rises for the rest of training while test error *falls* from 29% to 27%.

> **The interpretive claim worth carrying:** high-capacity, lightly-regularised networks are not immune from overfitting — the overfitting **relocates into probabilistic error rather than classification error**. That is a direct qualification of the Zhang et al. 2017 "large models with little regularization generalise anyway" result: they generalise in 0/1 loss and do not generalise in NLL, and nothing in an accuracy-only evaluation can see the difference.

Supporting evidence for the sharpening account: pre-calibration output entropy falls steadily through training while NLL rises, and the optimal `T` fitted at each epoch *rises* in step — the miscalibration is literally the softmax growing colder than the data warrants.

---

## The fix, and its price

All methods are **post-hoc**, fitted on a held-out labelled validation set, network frozen. That validation set is the external referent `G89` demands of a calibrator — the cheapest form of it in the wiki.

| Method | Parameters | Touches the argmax? |
|---|---|---|
| Histogram binning | `M` bin values | **Yes** |
| Isotonic regression | `M` + boundaries, jointly | **Yes** |
| BBQ (Bayesian binning into quantiles) | Bayesian average over *all* binning schemes | **Yes** |
| Matrix scaling | `W z + b`, `K² + K` | **Yes** |
| Vector scaling | diag `W`, `2K` | Yes (in principle) |
| **Temperature scaling** | **one scalar `T`**, `q = σ_SM(z/T)` | **No — provably** |

**ECE (%), `M = 15`, selected rows:**

| Dataset / model | Uncalibrated | Hist. binning | Isotonic | BBQ | **Temp.** | Vector | Matrix |
|---|---|---|---|---|---|---|---|
| CIFAR-100 / ResNet-110 | 16.53 | 2.66 | 4.99 | 5.46 | **1.26** | 1.32 | 25.49 |
| CIFAR-100 / DenseNet-40 | 10.37 | 2.68 | 4.51 | 3.59 | **1.18** | 1.09 | 21.87 |
| CIFAR-10 / ResNet-110 | 4.60 | 0.58 | 0.81 | 0.54 | 0.83 | 0.88 | 1.00 |
| ImageNet / ResNet-152 | 5.48 | 4.36 | 4.77 | 3.56 | **1.86** | 2.23 | — (fails to converge) |
| Birds / ResNet-50 | 9.19 | 4.34 | 5.22 | 4.12 | **1.85** | 3.00 | 21.13 |
| 20 News / DAN-3 | 8.02 | 3.60 | 5.52 | 4.98 | 4.11 | 4.61 | 9.10 |

Four results, each with a consequence:

1. **Temperature scaling wins on every vision task and is competitive on NLP**, at one parameter, ~10 conjugate-gradient iterations, and a `nn.MulConstant` between logits and softmax.
2. **It beats vector and matrix scaling, which strictly generalise it.** The fitted vector-scaling `W` comes back with near-constant entries — it *rediscovers* a scalar. The authors' conclusion, and the one this wiki should carry: **network miscalibration is intrinsically low-dimensional.** Matrix scaling with `K²` parameters overfits the validation set catastrophically at `K = 100–200` (CIFAR-100 ECE 16.53 → **25.49**, i.e. worse than doing nothing) and does not converge at `K = 1000`.
3. **The general methods lose to the simple ones throughout** — histogram binning beats isotonic regression and BBQ, both of which contain it. Calibration is best corrected by models too small to fit anything but the offset.
4. **Every method except temperature scaling buys ECE with accuracy.** Test error under histogram binning: ImageNet/DenseNet-161 **22.57 → 48.32**, ImageNet/ResNet-152 **22.31 → 48.10**, CIFAR-100/ResNet-110 27.83 → 34.78, Birds/ResNet-50 22.54 → 55.02. Matrix scaling: CIFAR-100 27.83 → 38.77. Temperature scaling's error column is **bit-identical to uncalibrated in all 19 rows**, because `argmax_k z^(k)/T = argmax_k z^(k)` for `T > 0`.

**Temperature scaling is maximum entropy under a moment constraint** (paper's Claim 1). Maximising `−Σ_i Σ_k q(z_i)^(k) log q(z_i)^(k)` subject to normalisation and to

```
Σ_i z_i^(y_i)  =  Σ_i Σ_k z_i^(k) q(z_i)^(k)        "average true-class logit = average weighted logit"
```

has the unique solution `q(z)^(k) = e^{λ z^(k)} / Σ_j e^{λ z^(j)}`, i.e. `T = 1/λ`. So the calibrator is not a heuristic squash: it is *the* least-committal distribution consistent with one measured moment of the logits.

---

## The result that matters here: calibration and the abstention policy are **orthogonal**

Temperature scaling is a strictly monotone transform of every logit and preserves the order of `max_k σ_SM(z/T)^(k)` across inputs. Therefore:

| Quantity | Effect of temperature scaling |
|---|---|
| Accuracy | **Zero**, exactly |
| ECE / RMS calibration error | Collapses, typically ~10× |
| `κ_f` ranking, and hence the entire risk–coverage curve of [[wiki/concepts/selective-prediction.md]] | **Zero**, exactly |
| AUROC2 / metacognitive sensitivity | **Zero**, exactly (AUROC is rank-based) |
| `meta-d′/d′` | Unchanged in the sensitivity numerator; the bias term moves |

This closes a loop the wiki had open in two places at once:

- [[wiki/concepts/metacognitive-efficiency.md]]'s worked example — *a rater who scores every correct answer 90% and every error 80% is badly calibrated with excellent resolution, and one affine correction makes her ideal* — now has a machine instance, at scale, with the affine correction reduced to **one parameter** and shown to be sufficient on 19 model/dataset pairs.
- `T320` asks whether a model's own softmax ranks its own errors. This paper says the **softmax is badly miscalibrated and the ranking still works** ([[wiki/concepts/selective-prediction.md]]'s CIFAR-10/ImageNet guarantees use the raw, uncalibrated max-softmax of exactly these architectures). Miscalibration is therefore *not* an explanation for any failure of `κ_f`, and any wiki page that reads a large RMS calibration error as evidence that a system "does not know what it does not know" is over-reading its own number.

---

## What this buys a reasoning model **(brainstorm)**

- **The calibrator `G89` asks for exists, costs one float, and is not the hard part.** A single scalar fitted against a labelled held-out set is a correction with a referent genuinely outside the estimating loop — Beer's orbitofrontal corrector ([[wiki/concepts/default-self-model.md]]) in its minimum implementable form. What it does *not* supply is a competence *model*: `T` is a global constant, not a function of the query, and it does not amortise across a distribution shift.
- **`T` should be a per-problem-class vector, and that is the same object [[wiki/concepts/selective-prediction.md]] arrives at from the other side.** One scalar per class `{T_c}` (bias) and one threshold per class `{θ_c}` (policy) fitted on the same per-class labelled sample give a two-number competence statement per problem class, at the cost of one sort and one line search. Nobody has run this, and the obstacle is labels, not machinery.
- **The reasoning-model version of the NLL/0-1 disconnect is the one to worry about.** Training that keeps pushing likelihood down after the answers are right *sharpens*, and a sharpened policy is one that stops exploring alternatives — which is [[wiki/concepts/refinement-loop.md]]'s and [[wiki/concepts/simulation-based-planning.md]]'s worst case, not merely a reporting defect. On a closed-set classifier the sharpening costs nothing but the confidence number; on a search process it costs the branch.
- **Temperature is a precision scalar and the wiki already has a theory of it.** `1/T = λ` is exactly a gain on the evidence entering a softmax — [[wiki/concepts/precision-weighting.md]]'s `Π`, one number over the whole model. Two things follow. (i) The result that *vector* scaling degenerates to a scalar is a measured statement that the precision defect of a trained network is **rank-1**, which is unexpectedly friendly to the wiki's low-rank-gain-register argument (a handful of scalars over a hierarchy, not a per-synapse quantity). (ii) The optimal `T` *drifts monotonically upward during training* — so a fixed gain register is wrong even for a stationary task, and a self-setting one has a target it can measure (post-calibration entropy and validation NLL coincide at the optimum, which is a fixed-point condition an architecture could run online).
- **Weight decay is a calibration hyperparameter that the field tunes on accuracy.** The wiki's architectures inherit this by default. If calibration is wanted, there is a second optimum and it is not where anyone stopped.
- **Regularisation-by-BatchNorm buys accuracy and sells calibration.** Any brain-inspired normalisation import ([[wiki/concepts/excitation-inhibition-balance.md]]-style gain control) should be checked on both axes, because the one paper that swept it found the trade.

---

## Open problems

| Problem | Why it is open |
|---|---|
| **Why capacity, BN and low weight decay miscalibrate is unexplained** | The authors state it as future work. Sharpening-after-fit explains capacity; it does not explain BN at matched accuracy |
| **Nothing here survives distribution shift** | The validation set is assumed i.i.d. with deployment. `T` fitted on one distribution is a constant applied to another — the same bill [[wiki/concepts/selective-prediction.md]] pays for its bound |
| **Undefined for open-ended generation** | `P̂` needs a normalised posterior over a bounded answer set. A sequence log-probability is not one, so neither ECE nor `T` transfers to a generator without first constructing a closed candidate set (`T320`'s proposed boundary) |
| **ECE's binning is a free parameter and MCE's is a defect** | No `M` is justified; MCE moves in the opposite direction to ECE on the same predictions. Any wiki calibration number quoted without `M` and bin occupancies is under-specified |
| **The calibration/accuracy hyperparameter conflict has no joint objective** | Weight decay has two optima; nobody trains against both. The analogue of [[wiki/concepts/selective-prediction.md]]'s "joint training of `(f,g)`" for the bias term |
| **Direction of the capacity effect at frontier scale is disputed** | `T325`: a controlled depth/width sweep says larger is worse-calibrated; the wiki's largest observational comparison says the two most accurate frontier models are the two best calibrated |

---

## Connections

- **[[wiki/concepts/metacognitive-efficiency.md]]** — supplies the machine instance of that page's central dissociation: the calibration term `C` is removable by a one-parameter affine correction on the logits with the resolution term `R` provably untouched (rank-preserving), so its "scale-learning is barely studied" open problem is answered for closed-set classifiers and remains open for everything else.
- **[[wiki/concepts/selective-prediction.md]]** — the orthogonal half of the same confidence number: temperature scaling changes `κ_f`'s *values* and not its *order*, so it moves ECE by 10× and the risk–coverage curve by exactly nothing; and the two per-class fits (`{T_c}` for bias, `{θ_c}` for policy) come off the same labelled sample.
- **[[wiki/concepts/precision-weighting.md]]** — `1/T` is a single global precision on the logits, and the finding that a full diagonal gain (vector scaling) degenerates to a constant is a measurement that a trained network's precision defect is **rank-1**; the optimal `T` drifting upward through training is the same page's argument that a gain register cannot be a fixed constant.
- **[[wiki/concepts/default-self-model.md]]** — the minimum viable external corrector: one scalar fitted against held-out labels is Beer's post-hoc calibration mechanism (**A**) implemented, and its success on the bias term is why that page's mechanism **B** (upstream evidence gating) is the one still unaddressed.
- **[[wiki/concepts/certification-instruments.md]]** — contributes `I35` (reliability diagram + ECE, with the one-parameter refit as the diagnostic that separates a scale offset from an information loss) and a fourth reading of `F15`: an unrepaired calibration error is partly a *scale* artefact, and the arithmetic fix is a single line search rather than a matched-difficulty design.
- **[[wiki/entities/hle.md]]** — the wiki's largest calibration measurement, reinterpreted: RMS calibration error of 73–89% is the term this page shows is one parameter wide on closed-set tasks, so it licenses no claim about error discrimination; its unexplained ordering (best models best calibrated) is the opposite of this paper's controlled capacity sweep and is registered as `T325`.
- **[[wiki/entities/math-dataset.md]]** — its AUROC 68.8% is rank-based and therefore **invariant** to any temperature applied to the same model, which makes it the one wiki confidence number that a calibration fix could not have produced or destroyed.
- **[[wiki/entities/shortcut-suite.md]]** — its confidence–accuracy gap *widening on the shortcut arm relative to a matched standard arm* is the case this page's global scalar cannot fix: a single `T` corrects an offset, not a defect conditional on which channel the answer came from, so an input-conditional miscalibration is evidence of something a temperature cannot absorb.
- **[[wiki/concepts/information-bottleneck.md]]** — the entropy-maximisation derivation makes temperature scaling the least-committal distribution matching one measured logit moment; NLL overfitting is the same objective run past the point where the extra bits describe the training sample rather than the label.
- **[[wiki/entities/prm800k.md]]** — miscalibration load-bearing inside an experiment rather than reported next to it: the large PRM used as a labelling oracle for the paper's only clean process-vs-outcome comparison is *"slightly miscalibrated in the direction of favouring positive labels"*, and the correction is a hand-chosen 20%-negative threshold rather than a fitted temperature — so the headline ablation rests on one uncalibrated constant, in exactly the regime (a per-step binary head) where this page's one-parameter fix would have applied.
