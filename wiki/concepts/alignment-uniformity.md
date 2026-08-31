# Alignment and Uniformity

**The contrastive loss is not one objective but a sum of two, and they can be written down separately: `L_align` pulls positive pairs together, `L_uniform` spreads the marginal over the sphere. Optimising the two directly — with the softmax and the negatives deleted — matches or beats the loss they were derived from, and the pair of numbers doubles as a label-free quality metric.**

> **Provenance.** Wang & Isola 2020, *Understanding Contrastive Representation Learning through Alignment and Uniformity on the Hypersphere*, ICML (`raw/wang-2020-alignment-uniformity-hypersphere.md`). This is the primary source for locus 1 of [[wiki/concepts/representational-collapse.md]], which the wiki had until now carried only as "InfoNCE, SimCLR, MoCo" with no derivation.

---

## The two metrics

Encoder `f: R^n → S^{m-1}` (ℓ₂-normalised output). `p_pos` symmetric with marginal `p_data`.

```
L_align(f; α)   = E_{(x,y)~p_pos} ‖f(x) − f(y)‖₂^α                    α > 0,  used α = 2
L_uniform(f; t) = log E_{x,y iid~p_data} e^{−t‖f(x) − f(y)‖₂²}        t > 0,  used t = 2
```

Both are ≤10 lines of PyTorch (`torch.pdist`), and `L_uniform` avoids the softmax entirely — no partition function, no negative-sample bookkeeping.

**Why the Gaussian kernel and not something cheaper.** `G_t(u,v) = e^{−t‖u−v‖²}` is *strictly positive definite* on `S^d × S^d`, from which two properties follow that no naive spreading term has:

| | Statement |
|---|---|
| Prop. 1 | The normalised surface measure `σ_d` is the **unique** minimiser of `∫∫ G_t dμ dμ` over Borel probability measures on `S^d` |
| Prop. 2 | The `N`-point minimisers' counting measures converge weak\* to `σ_d` as `N → ∞` — so the finite-batch estimate is asymptotically correct |

Average pairwise **dot product** or **Euclidean distance** is minimised by *any* zero-mean distribution, so the obvious spreading terms do not have a uniform optimum at all. This is the technical reason a spreading provision needs a kernel rather than a moment.

---

## The decomposition theorem

For fixed `τ > 0`, as the number of negatives `M → ∞`:

```
lim_M  L_contrastive(f; τ, M) − log M
   =  −(1/τ)·E_{(x,y)~p_pos}[ f(x)ᵀf(y) ]        ← minimised iff f is perfectly aligned
      + E_{x~p_data} log E_{x⁻~p_data} e^{f(x⁻)ᵀf(x)/τ}   ← minimised exactly by the perfectly uniform encoders
```

with absolute deviation from the limit decaying as `O(M^{-1/2})`. Since practice uses `M = 65536` (MoCo) and empirically more negatives is monotonically better, the asymptotic regime is the operating regime.

`L_uniform` is the second term with the `log` pushed *outside* the outer expectation — same minimiser, pairwise rather than softmax form.

**Three things this settles that the wiki had been asserting without a source:**

1. **A contrastive loss is a non-parametric entropy estimator.** For `p_data` uniform over a finite dataset, the second term is exactly a **resubstitution entropy estimator** of `f(x)` under a von Mises–Fisher kernel density estimate: `= −Ĥ(f(x)) + log Z_vMF`, with vMF concentration **`κ = 1/τ`**. So the temperature is a *KDE bandwidth*, not a free softness knob — which is why it needs tuning per dataset and why a mis-set `τ` yields an encoder that is repairable rather than broken (below).
2. **The InfoMax reading is wrong, and the replacement is stronger.** `L_contrastive` is standardly justified as a lower bound on `I(f(x); f(y))`; the bound interpretation is known to be inconsistent with practice (a *tighter* bound gives worse representations). Under `I = H(f(x)) − H(f(x)|f(y))`: uniformity does correspond to large `H(f(x))`, but **alignment is strictly stronger than small `H(f(x)|f(y))`** — it demands `f(x) = f(y)` a.s., not merely low conditional entropy. The loss optimises *aligned and information-preserving*, which is a different and more specific property than high mutual information.
3. **Perfect alignment and perfect uniformity are jointly unachievable.** With `p_data`/`p_pos` formed by augmenting a *finite* dataset, no encoder is both: perfect alignment forces every augmentation of one image onto one point, which is a finite point set, hence not `σ_{m-1}`. The trade-off in the weight ratio is therefore **structural, not a tuning artefact**.

---

## Measured: replacing the loss with its own decomposition

Train on `w_a·L_align(α=2) + w_u·L_uniform(t=2)` alone — no softmax, no negatives.

| Benchmark | Read-out | Best `L_contrastive` | Best `L_align + L_uniform` |
|---|---|---|---|
| STL-10 | output + linear | 80.46 (`τ=0.19`) | **81.15** |
| STL-10 | fc7 + linear | 83.89 | **84.43** |
| NYU-Depth-V2 | conv5 depth MSE ↓ | 0.7024 | **0.7014** |
| ImageNet-100 (MoCo) | penultimate + linear top-1 | 72.80 (`τ=0.07`) | **74.60** |
| ImageNet (MoCo v2, 200 ep) | linear top-1 | 67.5 ± 0.1 | **67.69** |
| BookCorpus → MR (Quick-Thought) | logistic | **77.51** | 73.76 |
| BookCorpus → CR | logistic | **83.86** | 80.95 |

**The two text rows are the qualification the vision rows hide.** The substitution wins on every image benchmark and loses by 3–4 points on both sentence tasks, where positives are *neighbouring sentences* rather than augmentations of one item. The wiki's anti-collapse evidence is otherwise almost entirely vision; this is its one controlled case of a provision that does not transfer across modality, and the difference sits in the pair sampler ([[wiki/entities/i-jepa.md]]'s lever), not in the loss.

**The theoretical gap is the right way round.** Theorem 1 says the two terms are what contrastive learning optimises *at infinite negatives*; the empirical win says direct optimisation is better *at finite negatives*. Deleting the negatives improves on the objective that needs them.

---

## The trade-off is causal, and it has a degenerate end

- **Inverted-U over the weight ratio** (STL-10 sweep): both properties are necessary. When `w_a ≫ w_u` the encoder collapses outright (`exp L_uniform = 1`, all inputs to one vector). Quality is otherwise **insensitive while the ratio stays below ≈4** — a flat coefficient region of the same character as Barlow Twins' 10× flat `λ`.
- **Fine-tuning trajectories establish causation, not correlation.** Start from an encoder trained at a deliberately bad `τ = 2.5`; fine-tune on `L_align` only → alignment improves, uniformity *and accuracy* degrade; on `L_uniform` only → the mirror image; on both → both metrics and accuracy rise together. Metric and quality move together under intervention, which no correlational study over checkpoints establishes.

---

## As a label-free monitor

Across **304** STL-10, **64** NYU-Depth, **45** ImageNet-100 (MoCo) and **108** BookCorpus encoders — varying loss weights, `τ`, `α`, `t`, batch size, embedding dimension, epochs, learning rate and initialisation — the best-performing encoders are exactly those in the low-`L_align`, low-`L_uniform` corner, for image *and* text.

Two properties that distinguish it from the wiki's other label-free instrument ([[wiki/entities/lejepa.md]]'s `train_loss / λ^0.4`, Spearman ≈0.99 with linear-probe accuracy):

| | Wang & Isola 2020 | LeJEPA monitor |
|---|---|---|
| Shape | **two** numbers, a 2-D scatter with a corner | one scalar, rank-correlated |
| Read-outs validated on | linear, 5-NN, **conv-layer depth regression** | ImageNet linear probe |
| Computed from | validation-set embeddings, any encoder | the method's own training loss |

The dense read-out matters: [[wiki/entities/dinov3.md]]'s **partial collapse** is a dense-probe failure invisible to a global linear probe, and the standing complaint in [[wiki/empirical-tensions.md]] T168 is that no monitor is calibrated on the read-out that fails. This one was validated against a per-pixel depth regression from `conv4`/`conv5` activations — **(brainstorm)** so it is the wiki's best available candidate for that test, and the experiment is cheap: track `L_align`/`L_uniform` on patch tokens across a long DINOv3 run and check whether they turn at ~200k iterations where the dense probe does.

---

## Where this leaves the anti-collapse taxonomy

The six loci of [[wiki/concepts/representational-collapse.md]] treat "a term over samples" (locus 1) and "a term over marginals" (locus 3) as different families. Theorem 1 says locus 1 **is** locus 3 plus an invariance term:

```
contrastive  ≡  invariance term  +  distribution-matching term with target σ_{m-1}
VICReg       ≡  invariance term  +  per-dimension moment constraints
LeJEPA       ≡  invariance term  +  distribution-matching term with target N(0, I_K)
```

So the "moment ladder" that [[wiki/entities/lejepa.md]] uses to merge loci 2 and 3 extends to **locus 1 as well**, and it did so five years earlier. What differs across the three rows is only *which statistic of the marginal is pushed to which target*, and the ladder has a rung the wiki was not counting: a **kernel** test (average pairwise `G_t`) sitting between the moment tests and the characteristic-function test, with the same strict-positive-definiteness argument behind it that LeJEPA's Epps–Pulley statistic uses.

**And there were two derived targets, not one.** LeJEPA is described in the wiki as "the one normative statement in this whole area"; that is too strong. Both derive a target, from different premises:

| | Target | Derived from |
|---|---|---|
| Wang & Isola 2020 | uniform `σ_{m-1}` on `S^{m-1}` | maximal entropy / information preservation, plus the uniqueness of `σ_d` as the Gaussian-potential minimiser |
| Balestriero & LeCun 2025 | isotropic `N(0, I_K)` in `R^K` | worst-case downstream probe bias and variance |

**They agree on directions and disagree on the radius.** An isotropic Gaussian's *directional* marginal is exactly `σ_{K-1}`; the two targets differ only in whether the norm `‖z‖` is left free to carry information (LeJEPA: χ_K-distributed, part of the target) or normalised away (here: discarded by construction). That is a crisp and testable disagreement, and it is live — see [[wiki/empirical-tensions.md]] T304.

---

## Why the hypersphere at all

The paper's own arguments, which it also flags as incompletely settled:

- **Necessity, for this loss specifically.** Without a norm constraint the softmax in `L_contrastive` can be made arbitrarily sharp by scaling all features — the loss is minimisable by growing the norm rather than by learning anything. This is a property of dot-product-in-a-softmax, and does **not** transfer to losses without one.
- **Linear separability.** Well-clustered classes on a sphere form spherical caps, which are linearly separable from the rest of the space; the same clustering in `R^m` is not. Since linear separability is the field's default quality criterion, the geometry is partly chosen to fit the instrument ([[wiki/concepts/representation-probing.md]]).
- **Stability.** Fixed-norm vectors stabilise training wherever dot products are ubiquitous.
- **Stated open:** "why the unit hypersphere is a nice feature space is not yet rigorously answered."

---

## Open problems

- **The text failure is unexplained.** Direct optimisation loses 3–4 points where positives are neighbouring sentences. Nothing in the derivation is modality-specific, so either the finite-negative advantage is vision-specific or the `p_pos` assumption (symmetry, matching marginal) is violated by sentence adjacency — the second is checkable and unchecked.
- **Perfect alignment is unreachable and nobody prices the gap.** Every certifiability argument in the wiki states a loss's minimum; here the minimum is provably not attained for any finite dataset with augmentations, which is a fourth narrowing of "certified by construction" beyond the three on [[wiki/concepts/representational-collapse.md]].
- **`τ` is a bandwidth with no selection rule.** Reading `κ = 1/τ` makes temperature a density-estimation hyperparameter, for which bandwidth-selection theory exists and has never been applied here.
- **Uniformity is a statement about the *marginal* only.** It says nothing about relations among codes, which is what [[wiki/concepts/latent-graph-discovery.md]] needs and what [[wiki/entities/dinov3.md]]'s Gram anchoring supplies — a perfectly uniform embedding can have arbitrary relational structure.

---

## Connections

- **[[wiki/concepts/representational-collapse.md]]** — the parent: this page is locus 1's derivation, and it collapses locus 1 into locus 3's family by showing the contrastive loss *is* an invariance term plus a distribution-matching term with target `σ_{m-1}`.
- **[[wiki/concepts/divergence-objectives.md]]** — supplies what the second term actually estimates: a vMF-kernel resubstitution entropy estimate of the embedding marginal, which replaces the InfoMax mutual-information reading that page's rate–distortion split otherwise inherits.
- **[[wiki/concepts/population-geometry.md]]** — the target this page derives is that page's normative shape seen from the sphere: uniformity on `S^{m-1}` is the directional marginal of the isotropic Gaussian, so the two derivations agree on anisotropy and differ only on the norm.
- **[[wiki/concepts/representation-probing.md]]** — the geometry is chosen partly to fit the instrument: spherical caps are linearly separable where Euclidean clusters are not, and linear separability is the read-out everything here is scored by.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the limit of a marginal constraint: uniformity fixes where codes sit and says nothing about the relations among them, which is the whole content of the framing.
- **[[wiki/entities/lejepa.md]]** — the same move made five years later with a different target and a different derivation (probe bias, not entropy), and the reason this page's ladder claim is a correction rather than an addition: locus 1 was already on the ladder.
- **[[wiki/entities/vicreg.md]]** — the disagreement made measurable: this page argues ℓ₂ normalisation onto the sphere is necessary and beneficial, and VICReg measures it costing 3.5 ImageNet points with no normalisation anywhere (T304).
- **[[wiki/entities/barlow-twins.md]]** — the entropy-estimator reading that page states as the mechanism behind its scaling curves, with the derivation supplied here: the contrastive term is the non-parametric estimator, the cross-correlation penalty its Gaussian-parametrised proxy.
- **[[wiki/entities/dinov2.md]]** — the third shape of the same quantity: KoLeo is the nearest-neighbour entropy estimator with *no* negatives, where the uniformity term here is the kernel estimator *with* them, and their read-out payoffs differ.
- **[[wiki/entities/dinov3.md]]** — the failure this page's monitor might be able to see and the others cannot, since the metrics here were validated on a dense conv-layer regression read-out as well as a global probe.
- **[[wiki/entities/simsiam.md]]** — uniformity reached with no uniformity term and a direct measurement of it: the per-channel std of `z/‖z‖` sits at `1/√d`, the isotropic-Gaussian value, whenever the stop-gradient is present and goes to 0 the instant it is removed — so the same statistic this page derives as an optimum doubles as the field's cheapest collapse monitor.
- **[[wiki/entities/i-jepa.md]]** — the lever that explains this page's one negative result: the vision→text gap tracks the pair sampler (augmentations vs. neighbouring sentences), not the loss.
