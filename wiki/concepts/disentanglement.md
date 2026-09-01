# Disentanglement

**A representation is disentangled when each coordinate of `r(x)` moves with exactly one ground-truth generative factor `z_i` — and it is a theorem that no purely unsupervised procedure can produce one, because an infinite family of completely entangled latents induces the identical observation distribution.**

> **Provenance.** Locatello, Bauer, Lucic, Rätsch, Gelly, Schölkopf & Bachem 2019, *Challenging Common Assumptions in the Unsupervised Learning of Disentangled Representations* (`raw/locatello-2019-challenging-disentanglement-assumptions.md`). One theorem plus >12,000 trained models: 6 methods × 6 regularization strengths × 7 datasets × 50 seeds, all 6 metrics implemented from scratch, `disentanglement_lib` and >10,000 checkpoints released.

---

## The formal setting

Two-step generative process: `z ~ P(z)` with factorized density `p(z) = Π_i p(z_i)`, then `x ~ P(x|z)`. Learn `r(x)`; the intuitive criterion is that after some permutation, `∂r_i/∂z_j = 0` for all `i ≠ j`.

This is the **`PA_i = ∅` corner of a structural causal model** — a trivial causal graph with no edges among the factors ([[wiki/concepts/independent-causal-mechanisms.md]]). Everything below is therefore a statement about the *easiest* case of causal representation learning.

---

## Theorem 1 — the impossibility

For `d > 1` and any `P` with factorized density, **there exists an infinite family of bijections `f : supp(z) → supp(z)` with**

- `∂f_i(u)/∂u_j ≠ 0` almost everywhere for **all** `i, j` — `z` and `f(z)` are *completely* entangled, every factor mixed into every other;
- `P(z ≤ u) = P(f(z) ≤ u)` for all `u` — identical marginal.

**Construction** (Appendix A): `f = g⁻¹ ∘ h⁻¹ ∘ A ∘ h ∘ g`, where `g_i(v) = P(z_i ≤ v_i)` is the coordinatewise CDF (mapping to a uniform cube), `h_i(v) = ψ⁻¹(v_i)` the coordinatewise standard-normal quantile (mapping to `N(0, I_d)`), and `A` an orthogonal matrix with **no zero entry**, e.g. the Householder reflection `A = I_d − 2vvᵀ` with `v_1 = √α`, `v_i = √((1−α)/(d−1))`, any `α ∈ (0, 0.5)`. `A` preserves `N(0, I_d)`, so the round trip preserves `P`; `A_ij ≠ 0` everywhere makes the Jacobian dense.

**Consequence.** Given `r(x)` perfectly disentangled w.r.t. `z`, the generative model with latent `ẑ = f(z)` has the same `P(x)` and `r(x)` is completely entangled w.r.t. it. An unsupervised learner sees only `P(x)` and cannot distinguish the two, so it must be entangled w.r.t. at least one of them.

| Reading | Statement |
|---|---|
| Weak (what the theorem literally says) | Unsupervised disentanglement is impossible **for arbitrary generative models** |
| Strong (what it does *not* say) | It does not say disentanglement is impossible in practice — real data may have structure a suitable inductive bias exploits |
| The obligation it creates | **Inductive biases are required on both the model and the dataset**, and both must be stated: one to select a solution set, one to make that set contain the truth |

Consistent with, but sharper than, the non-linear ICA (Independent Component Analysis) non-identifiability of Hyvärinen & Pajunen 1999: the novelty is the *explicit construction of a completely entangled latent*, and it holds for distributions not invariant to rotation (e.g. multivariate uniform), not only Gaussians.

---

## What the objectives actually enforce

All six methods are the VAE (Variational Auto-Encoder) evidence lower bound plus a regularizer; representation is the **encoder mean**, `r(x) = μ(x)`.

| Method | Penalty | Target of the penalty |
|---|---|---|
| β-VAE | `β` on the KL term | Bottleneck capacity |
| AnnealedVAE | Progressive capacity increase | One factor at a time, ordered by reconstruction gain |
| FactorVAE | Total correlation, adversarial density-ratio estimate | Aggregated posterior (**sampled**) |
| β-TCVAE | Total correlation, biased Monte-Carlo estimate | Aggregated posterior (**sampled**) |
| DIP-VAE-I / II | Mismatch between aggregated posterior and factorized prior; I penalises the off-diagonal covariance of `μ(x)` directly | I: the **mean**; II: the sampled code |

**The measured/optimized mismatch.** As regularization strength rises, the total correlation of the *sampled* representation falls — and the total correlation of the *mean* representation **rises**. Only DIP-VAE-I, which penalises the mean's covariance by construction, keeps it low. Same pattern under average pairwise mutual information. So five of six methods regularize a quantity that is not the one anyone uses downstream.

---

## The metric zoo, and what it agrees on

| Metric | What it computes |
|---|---|
| BetaVAE score | Accuracy of a linear classifier predicting which factor was held fixed |
| FactorVAE score | Majority-vote classifier on a different feature, fixing a corner case of the above |
| MIG (Mutual Information Gap) | Normalized gap in mutual information between the top-two coordinates, per factor |
| Modularity | Whether each *dimension* depends on at most one factor |
| DCI Disentanglement (Disentanglement–Completeness–Informativeness) | Entropy of the normalized per-dimension importance for predicting a factor |
| SAP (Separated Attribute Predictability) | Mean gap in prediction error between the two most predictive dimensions, per factor |

Spearman rank correlation: all agree except **Modularity**, strongly on dSprites/Color-dSprites/Scream-dSprites, mildly elsewhere; two tight pairs (BetaVAE ↔ FactorVAE, MIG ↔ DCI). **Level of agreement is itself dataset-dependent** — so a single-dataset metric comparison is uninformative.

**Every one of these metrics needs ground-truth factor labels or the full generative model.** That is the crux of the next section.

---

## What the 12,000-model sweep found

| Question | Result |
|---|---|
| Does the objective decide the score? | Objective alone (categorical) explains **37%** of score variance; objective × regularization strength **59%**; the rest is the **random seed**. Score ranges across methods overlap heavily |
| Is there a hyperparameter rule of thumb? | No model dominates; no consistent direction for regularization strength across datasets or metrics |
| Can unsupervised scores select models? | Reconstruction error, KL, ELBO and estimated total correlation show no consistent rank correlation with any disentanglement metric |
| Can good hyperparameters transfer? | Only dSprites ↔ Color-dSprites correlate strongly. Probability that transfer-based selection beats **random** model selection: **80.7%** same metric + same dataset (different seed), **59.3%** same metric + different dataset, **54.9%** different metric + different dataset |
| Does disentanglement buy sample efficiency? | Statistical efficiency = accuracy@100 samples ÷ accuracy@10,000 samples, GBT and logistic-regression downstream heads. **No reliable relation** to any disentanglement score. Metrics do correlate with downstream *accuracy* on dSprites variants — but that may be the metrics partly measuring informativeness |

**A good run with a bad hyperparameter routinely beats a bad run with a good one.** The authors' own conclusion: *the objective function matters less than the seed*, and selecting the good run requires labels.

---

## The circularity, stated plainly

1. Theorem 1: unsupervised disentanglement requires inductive biases on model **and** data.
2. The dataset-side bias cannot be verified without knowing the true factors.
3. Every disentanglement metric requires the true factors.
4. Therefore tuning on a disentanglement score **is supervision**, and a study that fixes hyperparameters a priori and reports the best of them has shown that a good model *exists*, not how to find it.

**This is a model-selection gap, not only an identifiability one** (G108): even granting that some run in the sweep is well disentangled, no label-free procedure picks it out.

---

## Escapes named by the authors

| Route | Mechanism | Status in this wiki |
|---|---|---|
| Weak supervision by grouping | Pairs/groups known to share a factor | Not implemented anywhere in the wiki |
| **Temporal structure** | Non-linear ICA identifiability under temporal dependence (Hyvärinen & Morioka 2016) — the route the authors call most interesting | The wiki's sequence models have the structure and never claim the identifiability |
| **Interaction / interventions** | The learner acts, so the intervention distribution is part of the data | [[wiki/concepts/learned-world-models.md]] — and the identifiability theorem there makes the *behaviour policy's* conditional action variance the deciding quantity |
| Independent causal mechanisms | Sparse mechanism shift as a score over candidate factorizations | [[wiki/concepts/independent-causal-mechanisms.md]] (G6); circular in the same way — which factors are recoverable depends on which shifts were available |
| Distributional constraint on the code | Force `h(x) ~ N(0, I_d)`; recovery up to one orthogonal `Q` | [[wiki/entities/lejepa.md]], [[wiki/concepts/objective-identifiability.md]] fifth direction. **Note the irony:** the constraint is enforced by the same `A`-orthogonal symmetry Theorem 1 exploits, so `Q` is exactly the residual the theorem guarantees cannot be removed |

---

## What this means for building the model

The wiki's central architectural commitment — a content-invariant structural code `g` factored from content `x` (G1) — **is a disentanglement claim about two groups of factors**, so Theorem 1 applies to it verbatim.

| Consequence | Where it lands |
|---|---|
| `g`/`x` cannot be *discovered* from a static observation stream; it must be imposed | G16, already the wiki's position — now with a proof rather than an argument from shortcut learning |
| An objective for the factorization (G30) is necessary but provably **not sufficient**: the same objective admits a completely entangled solution with identical data likelihood | The empty objective slot cannot be filled by a factorization penalty alone; it needs a *dataset* assumption stated alongside |
| No label-free criterion selects the good run | G108. Every wiki architecture whose latent factorization is asserted rather than measured inherits this |
| Downstream benefit is unmeasured, not established | The wiki repeatedly treats "factorized ⇒ recombinable" as a premise ([[wiki/concepts/simulation-based-planning.md]], [[wiki/concepts/learned-world-models.md]]). The one direct test found no sample-complexity benefit (T326) |

**(brainstorm)** The sharpest transferable audit item: for any architecture in the wiki whose latents are called factorized, **name the inductive bias on the data**, not only on the model. Architectural biases (typed channels, two-rate schedules, action conditioning) are all model-side; Theorem 1 says a model-side bias alone selects a solution set without guaranteeing the truth is in it. No wiki page currently states a dataset-side bias for `g`/`x`, which is the missing half of every factorization argument here.

**(brainstorm)** The seed result is the more corrosive half for the wiki's practice. If 41% of a disentanglement score's variance is seed, then any single-run "our architecture yields a factorized code" figure in the wiki is a draw from a distribution nobody has sampled — the same complaint [[wiki/concepts/objective-identifiability.md]] audit item 1 makes about grid cells, now measured in a second literature with a number attached.

---

## Open problems

- **No dataset-side bias has ever been stated.** The theorem demands biases on model *and* data; the literature supplies only model-side ones, and the paper does not name a candidate data-side assumption either.
- **Is the mean/sampled mismatch a bug or the whole result?** Five methods provably regularize the wrong object. Nobody has re-run the study with the sampled code as the representation.
- **Does the impossibility survive weak supervision quantitatively?** The escapes are named, not priced — no count of how many grouped pairs or how much temporal dependence buys identifiability, the way [[wiki/concepts/environment-invariance.md]] prices environments.
- **Toy datasets only.** All seven are synthetic with `≤ 6` factors and known ground truth; the paper concedes conclusions may not transfer to natural data — and the datasets where metrics agree least are the ones with a stochastic `P(x|z)`.
- **No concrete benefit demonstrated, in this study or any other the authors are aware of.** Interpretability and fairness are proposed as better places to look than sample complexity.

---

## Connections

- **[[wiki/concepts/objective-identifiability.md]]** — the same non-identifiability one level up: that page shows the *objective* is not recoverable from a trained system, this one shows the *latent* is not recoverable from the data, and the sweep here supplies audit item 1 with a number (37% of score variance from the objective, 41% from the seed).
- **[[wiki/concepts/independent-causal-mechanisms.md]]** — disentanglement is the `PA_i = ∅` corner of that page's causal factorization, so Theorem 1 is an impossibility result for the *easiest* case of causal representation learning, and the harder cases inherit it.
- **[[wiki/concepts/environment-invariance.md]]** — the one escape in the wiki that is *priced*: environments in linear general position remove degrees of freedom at a stated rate, which is what the escapes named here lack.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the core framing's hardest constraint: the hidden factors are not merely difficult to infer from observations, they are provably not determined by them without a data-side assumption.
- **[[wiki/concepts/learned-world-models.md]]** — both the escape and the counterexample: acting supplies interventions that break the tie, and the recovery theorem there names the behaviour policy's conditional action variance as the quantity — while the compositional-generalisation argument on that page assumes disentangled entity representations that this page says cannot be obtained unsupervised.
- **[[wiki/concepts/simulation-based-planning.md]]** — the wiki's most direct use of the unmeasured premise: recombination is said to require factorized representations, and the one study that tested factorization's downstream value found no sample-complexity benefit (T326).
- **[[wiki/concepts/shortcut-learning.md]]** — the disentanglement route listed there as a defence against shortcuts is the one this page shows is unidentifiable without a data-side bias, which is the same bias G6 needs to separate causal from correlational edges.
- **[[wiki/entities/integrated-world-modeling-theory.md]]** — the architecture that takes a disentangled VAE as a *given* building block; this page says that block is not obtainable by the objective it is assumed to come from.
- **[[wiki/entities/lejepa.md]]** — the distributional-constraint escape, and the exact place the residual ambiguity shows: the isotropic Gaussian is preserved by every orthogonal `A`, which is the same symmetry Theorem 1's construction rides, so recovery "up to `Q`" is the theorem's irreducible remainder rather than a technical artefact.
- **[[wiki/concepts/population-geometry.md]]** — the level at which the residual `Q` stops mattering: if only population geometry is claimed, an orthogonal mixing is not an error, which makes the geometry-level claim the one Theorem 1 does not touch.
- **[[wiki/concepts/representation-probing.md]]** — the instrument problem underneath: every disentanglement metric here is a supervised decodability measure over ground-truth factors, so "disentangled" is certified by the same class of instrument the wiki already flags as weak evidence of mechanism.
- **[[wiki/entities/adaworld.md]]** — a live instance of the seed/hyperparameter finding: `β` in a β-VAE bottleneck decides how much frame-to-frame change is called "action", reported from single runs at each setting.
- **[[wiki/concepts/information-bottleneck.md]]** — β-VAE's `β` is a bottleneck-capacity knob, so the disentanglement literature is a compression trade-off curve read as a factorization criterion; this page is the evidence the reading is not licensed.
