# Waterbirds / CelebA-blond / MultiNLI-negation — the planted confound, and the regulariser that makes the worst group worse

**Sagawa, Koh, Hashimoto & Liang 2020 (ICLR).** Three datasets in which a nuisance attribute `a` is correlated with the label `y` **by construction**, partitioned into `m = |A| × |Y|` groups, and scored by **worst-group test accuracy** rather than by an average. This is the wiki's first primary source for `I1` of [[wiki/concepts/certification-instruments.md]] — the controlled-shortcut instrument, previously carried second-hand through [[wiki/concepts/shortcut-learning.md]]. The paper's finding is not that the confound is learned (that was known) but that the standard fix is **inert in the overparameterised regime and actively harmful when made to bite**: group distributionally robust optimization (DRO) is identical to empirical risk minimization (ERM) at zero training loss, and the same `ℓ2` penalty that lifts group DRO to 84.6% drives ERM from 60.0% down to **21.3%**.

> **Provenance.** `raw/sagawa-2020-group-dro-worst-case-generalization.md`, ar5iv rendering of arXiv:1911.08731. Tables 1–3 are images in the source; every number below is one the text states in prose.

---

## The three artefacts

| Dataset | `y` | Spurious `a` | Confound planted by | `n` train | Smallest group | `m` |
|---|---|---|---|---|---|---|
| **Waterbirds** (built for this paper: CUB birds segmented onto Places backgrounds) | waterbird / landbird | water / land background | **95%** of each bird type placed on its matching background | 4,795 | 56 (waterbirds on land) | 4 |
| **CelebA** | blond / dark hair | male / female | found in the corpus, not authored | 162,770 | 1,387 (blond males) | 4 |
| **MultiNLI** | entailment / neutral / contradiction | hypothesis contains *nobody, no, never, nothing* | crowdsourcing artefact (Gururangan et al. 2018) | 206,175 | 1,521 (entailment with negation) | 6 |

**What makes Waterbirds the reference artefact and not merely another biased dataset:** the pixel-level segmentation masks let the authors *set* the confound rate, so `95%` is a knob rather than a measurement, and the **validation and test splits are re-balanced** (equal counts on each background) while the training split stays skewed. The rare group is otherwise too small to estimate a score on. Two consequences the page must carry:

- Reported "average test accuracy" is a **re-weighted** average over groups, using the *training* proportions — otherwise the balanced test set would not be comparable to the skewed train set.
- The balanced validation split is an **oracle the deployment case does not have**. The paper says so: with a skewed validation set, tuning on worst-group accuracy "would be more challenging and noisy". So `I1`'s price includes a group-labelled, group-balanced validation set, not only group-labelled training data.

---

## Setup: group DRO

Training distribution `P = Σ_g q_g P_g`; uncertainty set `Q = {Σ_g q_g P_g : q ∈ Δ_m}`. Because a linear program's optimum sits at a vertex, the worst-case risk collapses to a max over groups:

```
R(θ) = max_{g∈G}  E_{(x,y)~P_g}[ℓ(θ; (x,y))]
θ_DRO = argmin_θ  max_{g∈G}  E_{(x,y)~P̂_g}[ℓ(θ; (x,y))]
```

`g` is observed **at training time only** — the model cannot read it at test time. The quantity the paper is about is the per-group generalization gap `δ_g = E_{P_g}[ℓ] − E_{P̂_g}[ℓ]`, and the worst-group gap `δ = R(θ) − R̂(θ)`.

---

## Result 1 — group DRO is a no-op wherever training loss vanishes

If a model attains zero training loss it is *simultaneously optimal* for the average and the worst-group training objective. There is nothing left for the robust objective to trade against.

| Regime (default hyperparameters, trained to convergence) | Worst-group **train** | Average **test** | Worst-group **test** |
|---|---|---|---|
| ERM, Waterbirds | ≥ 99.9 | 97.3 | **60.0** |
| ERM, CelebA | ≥ 99.9 | 94.8 | **41.1** |
| ERM, MultiNLI | ≥ 99.9 | 82.5 | **65.7** |
| Group DRO, all three | ≈ same | ≈ same | ≈ same |

Batch normalisation, the default `λ = 0.0001` `ℓ2` penalty and BERT's dropout are all present and none of them stops the interpolation. **The failure is entirely in `δ_g` and not at all in `R̂`** — which is why an objective defined on `R̂` cannot see it.

## Result 2 — regularisation is what makes the objective bite, and it cuts both ways

Raise `λ` by three to four orders of magnitude (`λ = 1.0` Waterbirds, `λ = 0.1` CelebA) until no model can interpolate. Now the two objectives must *choose* which group to fit.

| `λ` strong | Worst-group train | Worst-group test |
|---|---|---|
| ERM, Waterbirds | 35.7 | **21.3** |
| DRO, Waterbirds | 97.5 | **84.6** |
| ERM, CelebA | 40.4 | **37.8** |
| DRO, CelebA | 93.4 | **86.7** |

Early stopping (one epoch for ResNet-50, three for BERT) is the implicit form of the same lever and reproduces the effect on all three datasets: worst-group test ERM → DRO of **6.7 → 86.0** (Waterbirds), **25.0 → 88.3** (CelebA), **66.0 → 77.7** (MultiNLI). DRO pays 1–3 points of average accuracy.

**The two statements worth extracting, in the order of their consequence:**

1. **Regularisation is not needed for average generalisation and is needed for worst-case generalisation.** The modern-regime folklore ("train longer, generalize better") is a statement about `E_P`, and it does not transfer to `max_g E_{P_g}`.
2. **The same intervention moves the worst group in opposite directions depending on the objective.** Regularised ERM is the *worst* of the four cells above — worse than doing nothing (60.0 → 21.3). Capacity was the only thing letting ERM fit the rare group at all; take it away and ERM spends what is left on the majority. A regulariser is not a robustness intervention; it is an amplifier of whatever the objective was already ranking.

Increasing `ℓ2` on BERT/MultiNLI (`λ ∈ {0.01 … 10.0}`) gave the same or worse robust accuracy than `λ = 0`. So the lever is **architecture- and modality-specific**, and early stopping is the only one of the two that worked everywhere.

## Result 3 — group adjustment: pay the rare group for its larger gap

Even regularised, the gaps are unequal: on Waterbirds at `λ = 1.0` the smallest group has a 15.4% train–test accuracy gap against **1.0%** for the largest. So minimise an estimated upper bound instead, with a parameter-independent `1/√n_g` surrogate for `δ_g`:

```
θ_adj = argmin_θ  max_{g∈G} { E_{P̂_g}[ℓ(θ;(x,y))] + C/√n_g }
```

`C` a capacity constant tuned over `{0,…,5}` (best `C = 2` on Waterbirds). Worth **+5.9** worst-group points on Waterbirds — more than a third of the remaining error — and **+1.1** on CelebA, where `ℓ2` had already equalised the gaps. At `C = 4` the correction overshoots and the *large* groups degrade.

**This trick exists only in the group-DRO setting.** Under ERM the `1/√n_g` term is an additive constant in the mean and changes no argmin; only a `max` over unequal-sized groups feels it. It is structural risk minimization applied per group rather than per hypothesis class.

## Result 4 — importance weighting is not group DRO once the loss is non-convex

The natural cheap substitute is to resample each group with equal probability, `w_g = 1/P̂(g)`.

| Setting | Statement |
|---|---|
| **Convex** (Prop. 1) | For continuous convex `ℓ` and compact convex `Q`, `Θ`, there **exists** `Q* ∈ Q` such that the DRO minimiser `θ*` also minimises `E_{Q*}[ℓ]`. Reweighting suffices in principle |
| **Non-convex** (Counterexample 1) | Uniform `P` on two points, `Θ = [0,1]`: the DRO solution attains worst-case loss **0.6**, and *every* weighting `(w₁,w₂) ∈ Δ₂` has its minimiser at a point with worst-case loss **1.0**. No weights work at all |
| **The reconciling remark** | Under regularity conditions there is always a `Q` for which `θ*` is a **first-order stationary point** of the weighted risk. In the non-convex case that does not make it the minimiser |
| **Even if the weights existed** | They depend on `θ*`, and obtaining them means solving the dual DRO problem — so reweighting is never *cheaper* than DRO, only different |

Empirically: upweighting beats ERM on Waterbirds and CelebA and is slightly below DRO; on MultiNLI it falls **below ERM on both average and worst-group accuracy** — it drives the rare group's training accuracy very low at everyone else's expense. Inverse-frequency weighting is a heuristic with no guarantee, and the wiki should stop treating "just rebalance" as the null hypothesis it fails.

## Result 5 — the group partition can be sloppy

CelebA, `λ = 0.1`, with four **distractor** attributes added to the true one (*Eyeglasses*, *Smiling*, *Double Chin*, *Oval Face*): optimise the worst case over all `2⁶ = 64` groups, evaluate on the original four. Worst-group accuracy **78.9%**, against 86.7% for the oracle partition and 37.8% for regularised ERM. **The instrument degrades gracefully in the number of irrelevant attributes**, which is what makes it usable when the confound is suspected rather than known — and is the closest thing here to relaxing the partition requirement that `G6` is open on.

---

## The optimiser

Interleave stochastic gradient descent on `θ` with **exponentiated gradient ascent** on `q` — sample a group uniformly, upweight it by `exp(η_q ℓ)`, renormalise, then step `θ` scaled by `q_g`:

```
q'_g ← q_g exp(η_q ℓ(θ; (x,y))) ;  q ← q'/Σq' ;  θ ← θ − η_θ q_g ∇ℓ(θ; (x,y))
```

Convergence of the average iterate in the convex case, via online mirror descent on the saddle point (Nemirovski et al. 2009):

```
E[ε_T] ≤ 2m √( 10 (B_Θ² B_∇² + B_ℓ² log m) / T )
```

`O(1/√T)`, linear in the group count `m`, logarithmic in it through the loss bound. Runtime overhead over plain SGD is **< 5%**. The prior group-DRO algorithm picks the single worst group each step; replacing that hard max with a gradient update on `q` is what buys both stability and the guarantee — the same soft-vs-hard-argmax substitution that makes attention differentiable.

---

## Where this sits among the wiki's shortcut instruments

| Instrument | Shift declared over | Confound is | Needs at training time | Reads out |
|---|---|---|---|---|
| **Waterbirds** (`I1`) | a named attribute `a`, crossed with `y` | **planted at a chosen rate** (95%) | group labels `(x,y,g)` + a group-**balanced** validation set | worst-group accuracy |
| [[wiki/entities/stylized-imagenet.md]] | one named feature (texture) | removed by construction | nothing — the shift is in the data | cue-conflict shape share |
| [[wiki/entities/objectnet.md]] | pose, viewpoint, background | randomised at capture | nothing (test-only) | differenced top-1 drop |
| [[wiki/entities/imagenet-c.md]] | 15 authored corruptions | applied post hoc | nothing (test-only) | mCE / Relative mCE |
| [[wiki/entities/shortcut-suite.md]] | an injected tautological clause | appended, label-preserving by proof | nothing | share of decision on the cue |

**The distinguishing feature is that this is the only one that also supplies a *training objective*.** Every other entry certifies a finished model; this one names the groups during training and asks what the best achievable worst-group score is. That is what makes its negative result informative: even handed the partition, the answer is "84.6%, and only if you also regularise hard", not "solved".

---

## Limitations the paper states

- **The partition is given.** Nothing here infers `a`. Result 5 softens this to "a superset of attributes will do", not to "no attributes".
- **The `1/√n_g` adjustment is a heuristic**, not the generalization gap; `C` is tuned on the balanced validation set.
- **Shifts must be expressible as pre-specified groups.** The authors' defence is enumerative (batch effects in biology, imaging artefacts and patient demographics in medicine), not general.
- **The interaction between early stopping and group adjustment is not characterised** — group losses have not converged, so the bound being minimised is not the one being measured.

---

## Connections

- **[[wiki/concepts/shortcut-learning.md]]** — the primary artefact behind that page's `I1`, and the sharpest measurement of its "goal — loss function" lever: holding architecture, data and optimiser fixed and changing only `E_P[ℓ] → max_g E_{P_g}[ℓ]` moves worst-group test accuracy from 21.3 to 84.6, while the *same* regulariser applied under the average objective moves it from 60.0 to 21.3.
- **[[wiki/concepts/certification-instruments.md]]** — supplies `I1` from a primary source, and adds two prices the inventory entry did not state: the instrument needs a group-**balanced** validation split as well as group labels, and it degrades gracefully (86.7 → 78.9) when the attribute set is a superset of the true confound.
- **[[wiki/concepts/environment-invariance.md]]** — the counterexample that bounds that page's "robustness is not invariance" result: a min-max over environments is a weighted ERM only at *stationarity*, and in the non-convex regime no weighting need reach the min-max solution at all — so worst-case optimisation is strictly stronger than reweighting **within** the given group family, while remaining unable to extrapolate beyond it, which is what invariance buys and this does not.
- **[[wiki/concepts/inductive-bias.md]]** — the hypothesis-space reading of Result 2: a capacity restriction is not a bias *toward* anything, so which solution a shrinking `H` gives up is decided by the objective — the identical `λ = 1.0` penalty lands Waterbirds' worst group at 84.6 under a max-over-groups objective and at 21.3 under a mean objective that scored 60.0 without it.
- **[[wiki/concepts/objective-identifiability.md]]** — a loss-side narrowing of the solution set that costs a group partition instead of an environment family, and the demonstration that it is inert unless the model is also prevented from reaching zero training loss.
- **[[wiki/entities/stylized-imagenet.md]]** — the same confound attacked from the data lever rather than the loss lever: author an environment where the spurious feature carries no information, versus keep the skewed data and reweight the objective over known groups. Both need the confound named in advance; only this one needs per-example labels for it.
- **[[wiki/entities/objectnet.md]]** — the complementary control: nuisance parameters randomised at capture so no group is rare, against a confound planted at a chosen rate so the rare group is the measurement.
- **[[wiki/concepts/memorisation-vs-generalisation.md]]** — the regime boundary this page is about: in the interpolating regime the training loss is uninformative about every group at once, so any objective defined on it is a no-op, and departing from interpolation is the precondition for the objective to select anything.
