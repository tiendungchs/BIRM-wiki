# Representational Collapse

**A learner satisfies its objective by representing nothing — a constant encoder, a latent with enough capacity to reach any target, or a read-out that degrades while the loss keeps falling. It is the cheapest solution to every self-supervised objective, and the provision against it is the single design decision that types a joint-embedding architecture.**

> **Promoted out of [[wiki/concepts/energy-based-models.md]] at the 171-ingest lint pass.** Collapse had grown to ~60% of that page across thirteen wave-7 ingests while the energy formalism itself is a separate claim, and the material was additionally spread over twelve entity pages with no page stating the loci side by side. The gap it answers is **G34**; the tensions it holds are T164, T166, T167, T168 and T171.

The reason it is not a training bug: **which architectures *can* collapse is a structural property.** Locate the free capacity and you have located the failure mode before any data arrive.

---

## The typing result

| Architecture | Collapses? | Mechanism |
|---|---|---|
| Deterministic prediction / regression | **No** | One `y` per `x`; the distance `D(y, ỹ)` guarantees a unique minimum. Also the reason it cannot represent multi-modality |
| Generative latent-variable (`ỹ = Dec(s_x, z)`) | **Yes** | If `z` has as many dimensions as `y`, every `y` is reachable at zero energy |
| Auto-encoder | **Yes** | If `dim(s_y) ≥ dim(y)`, the identity function reconstructs everything |
| Joint embedding (two encoders, energy `D(s_x, s_y)`) | **Yes** | Encoders emit a constant: `s_x = s_y` for all inputs, zero energy everywhere |

**The generalisation:** collapse is *excess information capacity in whatever variable is free*. Rows 2–4 are one defect located in `z`, in `s_y`, and in the encoders — which yields an anti-collapse recipe per architecture (restrict `z`'s capacity, restrict `s_y`'s capacity, maximise the encoders' information content) and is why [[wiki/entities/h-jepa.md]]'s training criteria come in exactly four parts.

**Four ways to restrict a latent's information content**, plus the fifth this wiki added: discretisation/quantisation (`k` values ⟹ at most `k` zero-energy points); dimension or rank minimisation (`d`-dimensional `z` ⟹ a `d`-dimensional low-energy manifold); sparsification (`α‖z‖₁` ⟹ a *union* of low-dimensional manifolds, as in classical sparse coding); fuzzification (noise on `z`, as in the VAE); and **distribution matching**, which constrains the latent's *shape* rather than its capacity and is the only one of the five with a measured failure mode attached — the target's dimension must not exceed the data's ([[wiki/entities/lewm.md]]).

---

## The six loci

The wiki's central organising claim about collapse: the provision does not have to be a term in the loss, and across wave 7 it turned out to sit in six structurally different places. Ordered by how far each is from the objective.

| # | Locus | Instance | What holds the representation up |
|---|---|---|---|
| 1 | **A term over samples** (contrastive) | InfoNCE, SimCLR, MoCo, CPC, CLIP | Push down on `F(x,y)`, pull up on `F(x,ŷ)` for placed negatives |
| 2 | **A term over dimensions** (dimension-contrastive) | [[wiki/entities/barlow-twins.md]], [[wiki/entities/vicreg.md]] | Components of *one* vector must differ from each other — variance hinge against norm collapse, covariance against informational collapse |
| 3 | **A term over marginals** (distribution-matching) | [[wiki/entities/lewm.md]], [[wiki/entities/lejepa.md]] | Penalise deviation of the embedding's 1-D projections from `N(0,1)`; by Cramér–Wold, matching every marginal matches the joint |
| 4 | **The update rule** (dynamical) | [[wiki/entities/byol.md]] | Nothing in the loss. Predictor on one branch, EMA on the other — an asymmetry, not a term |
| 5 | **A normalisation, on the loss's inputs or on the target** | Barlow Twins' batch standardisation; DINOv2's teacher centering / Sinkhorn–Knopp equipartition ([[wiki/entities/dinov2.md]]) | Certifiable-looking, and appears in *no coefficient count* |
| 6 | **A term over relations within one input** | DINOv3's Gram anchoring ([[wiki/entities/dinov3.md]]) | `‖X_S X_Sᵀ − X_G X_Gᵀ‖_F²` on patch tokens against an earlier iterate of the same network — features free to move, relational structure held |

Two further entries that are *not* loci and are worth keeping distinct: the **pair sampler** (below), which changes nothing in the objective and moves the result more than any choice among rows 1–6; and the **label oracle** ([[wiki/entities/learningmatch.md]]), where a Siamese energy is regressed onto an *exactly computable* target so the degenerate solution is removed outright and every surviving design choice is about expressivity.

| | Contrastive | Dimension-contrastive | Distribution-matching | **Dynamical (BYOL)** |
|---|---|---|---|---|
| Provision lives in | loss | loss | loss | **update rule** |
| Coefficients | temperature | **1 free scale** (VICReg `λ=μ`, `ν=1`) | 1 | 0 in the loss (`τ`, predictor LR ratio instead) |
| Certifiable from the objective | yes | yes\* | yes | **no — there is no objective** |

\* *Certifiable in the target only.* VICReg's minimum is non-collapsed for every positive `(λ, μ, ν)` — a constant encoder violates the variance hinge at any `μ > 0` — and training nonetheless collapses over most of the coefficient space (`1,1,1`, `10,1,1`, `1,10,1` all collapse; `5,5,1` reaches 68.1). Stating a loss's minimum does not certify the trajectory.

---

## The ladder: rows 2 and 3 are one family

Substitute a different univariate test into SIGReg and the existing methods reappear ([[wiki/entities/lejepa.md]]): `T(u) = mean(u)² + (std(u) − 1)²` recovers **VICReg** in the many-slices limit; the Epps–Pulley statistic with its integral computed exactly is per-slice **kernel MMD**. So the dimension-contrastive and distribution-matching columns are **one family indexed by how many moments of the target the test constrains**.

| Rung | Test | Argument for it |
|---|---|---|
| `k = 2` | Second moment — `‖Cov(ZS^⊤) − I_K‖_F` on a random sketch `S ∈ R^{K×C}` | Cheap (`O(CK)` not `O(C²)`), therefore applicable to **internal hidden layers** rather than only a projector output; matches or beats the full test in 5 of 8 supervised settings, largest gap `+6.2` in its favour (Akbar 2026) |
| all moments | Empirical characteristic function (Epps–Pulley) | **Identifiability** — finitely many moments do not determine a distribution, so a family of non-Gaussian solutions satisfies a truncated objective exactly. Also stability: moment `k` has gradient norm `O(k)` and variance `O(k² m_{2(k−1)})`, while the characteristic function is bounded in loss, gradient and curvature for *any* input distribution |

**The ladder has been climbed in both directions and the bottom rung holds**, so identifiability and stabilisation are *separable goods* and the family should not be ordered by how much of the target it pins ([[wiki/empirical-tensions.md]] T171).

**And the target is derived rather than chosen** — the one normative statement in this whole area. At fixed total variance, anisotropy strictly raises both the bias (under any ridge penalty) and the variance of a linear probe; among all distributions under a scalar covariance constraint the **isotropic Gaussian uniquely minimises the integrated squared bias of radius-k-NN and kernel probes**. Isotropy from the linear analysis, Gaussianity from the nonlinear one. The volume-minimising column therefore has a statement of *what shape* the low-energy region should be, not merely that it should be small ([[wiki/concepts/population-geometry.md]], T169).

---

## What the wave-7 evidence took away

Four results, each removing something the taxonomy above was assumed to have.

**1. The families are not composable, and the exception identifies the mechanism.** Adding BYOL's predictor and stop-gradient to Barlow Twins costs **10 points** (71.4 → 61.3; either alone ≈ −1) — an update-rule asymmetry inside a system that already has a well-defined minimum moves the dynamics *away* from it. The reverse control agrees (BYOL with Barlow Twins' 8192-wide projector: 74.1 → 72.3). **But the generalisation fails on the sibling method:** VICReg takes the same graft neutrally (73.2 → 73.2) and *its* variance term added to BYOL buys +0.9. The surviving candidate for the conflict is the one component VICReg drops — batch standardisation inside the loss, i.e. locus 5, a second implicit cross-branch coupling ([[wiki/empirical-tensions.md]] T166).

**2. The pair sampler is a larger lever than the choice of family.** Hold the loss, architecture and dataset fixed and vary only which blocks are context and which are target — ImageNet-1% linear evaluation moves **15.5 → 54.2** ([[wiki/entities/i-jepa.md]]). The two failure modes are opposite and both are collapse: targets predictable from local continuation make `D(s_x, s_y)` cheap without any content, and a context uninformative about its target makes the conditional mean nearly constant — collapse arrived at *from the data side*. The wiki's coefficient-count preference ordering therefore ranks a component that is not the biggest one ([[wiki/empirical-tensions.md]] T167).

**3. A read-out can be destroyed while nothing collapses.** DINOv3's 7B runs 1M iterations on `L_DINO + L_iBOT + 0.1·L_KoLeo` with no term diverging, no encoder going constant, patch norms stable, and the ImageNet linear probe rising **monotonically throughout** — while a linear probe on the *patch* tokens peaks at ~200k iterations and ends **below its own early value**, visible only as a steadily rising CLS↔patch cosine similarity. This is **partial collapse**, and it has three consequences: nothing has excess capacity (two objectives compete for one code and one wins over training *time*); **training horizon is a design variable with a coefficient in nobody's objective**; and the fix *repairs* rather than prevents — `L_Gram` applied after 1M iterations recovers the dense read-outs within 10k, but only from a **young** teacher, since a 1M-iterate anchor already has the disease ([[wiki/empirical-tensions.md]] T168).

**4. The premise itself is wrong: an objective with no degenerate minimum collapses anyway.** A ViT trained with plain supervised cross-entropy has no trivial minimum — the label term forbids a constant encoder — and reaches **20.73%** top-1 on CIFAR-100 under AdamW with Mixup/CutMix/RandAugment, recovering to **72.02%** when a covariance-isotropy term is added (Akbar 2026). The offered framing is **Dean–Kawasaki**: hidden-layer representations are a particle density under stochastic dynamics, and the flux injected by finite batches, high learning rates and aggressive augmentation drives it into a degenerate state *that no term in the loss prices*. On that reading every provision in the tables above is a **drift control** first and a minimum-shaping device second — consistent with its two other measured behaviours: near no-ops where BN and residual connections already hold the geometry (ResNet-18, −0.95 to +0.39), and additively stackable with an optimiser that constrains the *update* rather than the representation (Muon: 62.44 → 74.56 with Weak SIGReg on top), rather than fighting it the way an update-rule graft fights a well-defined minimum.

---

## The discrete case behaves differently, and it is measured

Everything above is about a continuous embedding. The one place the wiki has an ablation over a *discrete* selection variable is the mixture-of-experts router, where collapse is the rich-get-richer path — a favoured expert receives more inputs, trains faster, is favoured more ([[wiki/entities/sparsely-gated-moe.md]], Shazeer et al. 2017, 256 experts, 1B-word LM):

| Balance loss | Test ppl | `CV(Importance)` | `max(Load)/mean(Load)` |
|---|---|---|---|
| none | **39.8** | 3.04 | **17.80** |
| importance only, `w = 0.2` | 35.6 | 0.06 | 1.47 |
| load only, `w = 0.2` | 35.7 | 0.22 | 1.15 |
| both, `w = 0.01` … `1.0` | 35.6–35.7 | 0.48 → 0.03 | 1.37 → 1.07 |

Two disanalogies with the continuous loci, both useful:

- **The coefficient does not matter.** Every non-zero setting across a 100× range lands within 0.1 ppl. Compare VICReg, which collapses over most of its coefficient space and needs `5,5,1` to reach 68.1 — *stating a loss's minimum does not certify the trajectory* is a statement about continuous embeddings, and does not obviously carry to a discrete selection variable.
- **Two different quantities are being held up and only one is quality-relevant.** `Importance` (batch sum of gate *values*) and `Load` (smooth estimate of the *count* of inputs routed) are near-interchangeable for perplexity; only the load term controls the tail, which is the number that decides whether a device runs out of memory. So one provision buys quality and a second buys an engineering property, and the ablation separates them cleanly.

**(brainstorm) The mechanism for the insensitivity is probably that a discrete argmax has no null solution to fall into.** A constant encoder is a reachable point of a continuous embedding space; a router that sends everything to one expert still emits a valid partition and is punished directly by the task loss, because the surviving expert has a finite capacity the corpus overruns. The provision therefore only has to break a symmetry, not exclude a minimum — which predicts that discretising a latent should make its anti-collapse term easy to tune, and is a cheap test of the discretisation row in the four-ways-to-restrict list above.

---

## What a provision actually buys

Collapse-avoidance is not a scalar virtue of a representation. It is a purchase of a particular **read-out**, and the field's default benchmark sees almost none of the difference ([[wiki/entities/dinov2.md]]):

| Provision | ImageNet linear probe | The read-out it actually buys |
|---|---|---|
| KoLeo entropy term (`−(1/n) Σ_i log min_{j≠i}‖x_i − x_j‖`) | ~0.5 | **+8.3 mAP** instance retrieval; nothing on segmentation |
| Masked-patch (iBOT) term | ~0.5 | **+2.9 mIoU** segmentation; slightly *negative* on retrieval |

Three shapes of the same quantity, which is worth stating because it is the cleanest unification the area has: **a contrastive loss is a non-parametric entropy estimator *with* negatives; the variance/covariance terms are a Gaussian-parametrised proxy for the same quantity; KoLeo is the non-parametric estimator with *no* negatives, computed from nearest-neighbour spacing alone.**

**And the instrument this suggests exists.** LeJEPA's training loss has Spearman correlation **≈0.85** with downstream linear-probe accuracy across architectures, datasets, learning rates and epoch budgets, rising to **≈0.99** under the rescaling `train_loss / λ^0.4` — a label-free ranking of checkpoints, i.e. the first thing certifiability *buys* rather than promises. **(brainstorm)** It is calibrated on exactly the read-out that survived DINOv3's partial collapse, so the monitor and the known failure have not yet met, and the obvious experiment is to run the rescaled-loss ranking against the *patch-token* probe on a long run and see whether the correlation survives.

---

## The measurement is complicit

**The instrument that would detect collapse rewards it.** The standard vision-language compositionality benchmarks (Winoground, ARO, SUGARCREPE) are binary caption discriminations resolved by `argmax`, which returns the first element on a tie — so a fully collapsed model, assigning both captions one representation, **ties every item and scores 100%** where the correct caption is listed first (Bordes et al. 2024, [[wiki/concepts/cross-modal-grounding.md]]). The field's principal measurement of the property collapse destroys is maximally passed by collapse, and the fix costs one line of scoring code.

This is the same shape as G17 one level down: the certification instrument admits the degenerate solution it is supposed to exclude.

---

## Why this matters for building a reasoning model

1. **It is the first filter on any candidate objective for `g`.** G30 asks for a quantity maximised when the structural code is path-consistent and minimised when it is content-contaminated. Any such quantity must be checked against collapse *before anything else*, because a constant `g` is path-consistent trivially — commutativity holds when every path lands on the same point. **The wiki's deepest gap has a degenerate solution built into its own success criterion**, and this page is where the check lives.
2. **It is [[wiki/concepts/shortcut-learning.md]] in the limit case**, with the shortcut being nothing at all — which is why the anti-collapse literature is the most quantitative body of evidence the wiki has on how a learner finds the cheapest rule consistent with its objective.
3. **It makes "certified by construction" a weaker claim than the wiki assumed.** Three narrowings in sequence: certifiable in the *target* not the trajectory (VICReg), certifiable *per read-out* not globally (DINOv3), and — if the Dean–Kawasaki reading holds — not certifiable from the loss at all, because the driving term is the optimiser's flux. The practical consequence is that collapse-avoidance becomes a **monitoring requirement** on a running system rather than a property established once at design time ([[wiki/empirical-tensions.md]] T168).
4. **The relational locus is the one to copy.** Row 6 is the only provision that constrains *structure among codes* rather than the placement of one code, which is the shape everything in [[wiki/concepts/latent-graph-discovery.md]] wants — and it was invented to fix a failure the other five could not see.

---

## Open problems

- **Which latent regulariser.** Discrete, low-dimensional, sparse, noisy and distribution-matched are all offered; nothing says which is best, and the choice determines the *shape* of the representable outcome set (points vs. manifold vs. union of manifolds). Distribution matching adds a criterion nobody was scoring by — how many coupled coefficients must be balanced — and a new failure, since a fixed target imposes a latent dimension a low-complexity environment cannot fill.
- **Nothing predicts which asymmetries suffice.** BYOL restricts no free capacity and does not collapse, so *architecture plus objective does not determine whether collapse happens* — the optimiser is a third argument, and the recipe "locate the free capacity and restrict it" is sufficient but not necessary.
- **Training horizon has no coefficient.** Partial collapse is a function of how long the run goes, and no objective in the wiki contains a term in it.
- **No collapse monitor is calibrated against partial collapse.** The one label-free monitor that exists (rescaled LeJEPA loss) is calibrated on the read-out that partial collapse spares.
- **Is a preference ordering by coefficient count defensible at all?** LeWM's one coefficient and BYOL's zero are not the same kind of zero, and locus 5 shows that a provision can sit in a normalisation layer and appear in no count whatsoever. **(brainstorm)** The honest ordering is probably by *what can be said about the trained system afterwards*, which ranks the derived-target methods first and the dynamical ones last regardless of tuning burden.

---

## Connections

- **[[wiki/concepts/energy-based-models.md]]** — the parent page and the source of the typing result: collapse is the landscape going flat, and *where the free capacity sits* in an energy `F_w(x,y)` is what predicts whether it can happen at all.
- **[[wiki/concepts/objective-identifiability.md]]** — the strongest available instance: BYOL shows the representation may be a fixed point of a dynamics with *no minimum of anything* behind it, so not merely that several losses share a minimum but that there may be no loss to recover.
- **[[wiki/concepts/shortcut-learning.md]]** — collapse is the shortcut problem in its purest form: a constant encoder is the cheapest rule satisfying the objective, and every provision on this page exists to make it unavailable.
- **[[wiki/concepts/population-geometry.md]]** — supplies the normative target: isotropy minimises linear-probe bias and variance, so the anti-collapse question "how much volume" gets an answer to "what shape".
- **[[wiki/concepts/divergence-objectives.md]]** — the same objects one level up: the anti-collapse terms are divergences between an embedding distribution and a fixed target, and the moment ladder is a statement about which divergences are estimable at high dimension.
- **[[wiki/concepts/latent-graph-discovery.md]]** — why this page is a precondition rather than a detail: a constant structural code is trivially path-consistent, so the framing's own success criterion admits the degenerate solution and must be paired with a provision from here.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the complicit instrument: `argmax`-scored caption discriminations return 100% to a fully collapsed model, and the same page supplies the NCE derivation showing a contrastive method's noise distribution is a free parameter nobody reports.
- **[[wiki/concepts/representation-probing.md]]** — the read-out whose degradation defines partial collapse, and the reason certification has to be per-probe: two probes on one encoder moved in opposite directions across 1M iterations.
- **[[wiki/concepts/retrieval-capacity.md]]** — the read-out that entropy terms buy (+8.3 mAP from KoLeo), and an independent structural ceiling on the joint-embedding row that is *not* about collapse: a factorised energy is a rank-`d` bilinear form.
- **[[wiki/concepts/learned-world-models.md]]** — where the provision becomes a design constraint rather than a training concern: a latent world model's encoder is the free variable, and freezing a pretrained one is the field's most common way of sidestepping this page entirely.
- **[[wiki/concepts/three-component-framework.md]]** — collapse is what makes the objective slot hard to fill: the cheapest solution to any predictability objective is degenerate, so a candidate for `g` needs a fourth component that the framework does not name.
- **[[wiki/concepts/universal-induction.md]]** — restricting a latent's information content is a description-length argument in continuous clothing: bounding the bits available to name a hypothesis.
- **[[wiki/entities/h-jepa.md]]** — the architecture whose four training criteria are the recipe on this page written as a specification, and still the wiki's most complete design carrying no evidence of its own.
- **[[wiki/entities/byol.md]]** — locus 4: an asymmetry rather than a term, with the two stabilisers shown to be one mechanism (a near-optimal predictor substitutes for the EMA outright — closed-form linear regression 52.5%, raised predictor LR 66.5%).
- **[[wiki/entities/barlow-twins.md]]** — locus 2's founding instance and the discovery of locus 5: deleting the off-diagonal term leaves 57.3% rather than collapse, because the cross-correlation is formed from batch-standardised embeddings and a constant unit has zero batch variance.
- **[[wiki/entities/vicreg.md]]** — locus 2 split into its two ablatable halves (variance against norm collapse, covariance against informational collapse, neither substituting for the other), applied per branch; also the only argument in the wiki for why a projector must *widen*.
- **[[wiki/entities/lewm.md]]** — locus 3 built and priced: one effective coefficient against six coupled ones, no EMA and no stop-gradient, at the cost of committing the latent to a dimensionality the environment may not have.
- **[[wiki/entities/lejepa.md]]** — the derivation of locus 3's target and the collapse of loci 2–3 into one moment ladder; also the label-free checkpoint monitor, and (via Akbar 2026) the result that removes this page's founding premise.
- **[[wiki/entities/dinov2.md]]** — locus 5 on the *target* side (teacher centering / Sinkhorn–Knopp), plus the pricing that shows a spreading provision buys one read-out and not others.
- **[[wiki/entities/dinov3.md]]** — locus 6 and partial collapse: the failure this page's taxonomy could not see, and the only provision that constrains relations among codes rather than the placement of one.
- **[[wiki/entities/i-jepa.md]]** — the pair sampler as the lever that is not on any of the tables and moves the result by a factor of 3.5, more than the spread across all four families.
- **[[wiki/entities/learningmatch.md]]** — the control with no row here: regression onto an exactly computable similarity removes the degenerate solution outright, so every surviving design choice is about expressivity.
- **[[wiki/entities/v-jepa-2.md]]** — the scale case for the frozen-encoder sidestep, and the reason T154 is on the table: neither it nor DINO-WM trains the encoder at all, so neither pays this page's price.
- **[[wiki/entities/hit-jepa.md]]** — a JEPA *stack* trained without collapsing, under `SmoothL1 + VarLoss + CovLoss` at every level, which retires "no demonstration that a stack can be trained at all" while leaving the argument that motivates stacking untested.
- **[[wiki/entities/vl-jepa.md]]** — the continuous version of the non-term entry: the target branch's own learning supplies the asymmetry, with the decoder invoked only on demand.
- **[[wiki/concepts/subgraph-matching.md]]** — the one energy shape that makes collapse *self-punishing*: `E = ‖max{0, z_q − z_u}‖²₂` is asymmetric, so a constant embedding violates the order relation the loss encodes rather than satisfying it.
- **[[wiki/entities/neuromatch.md]]** — the same asymmetric hinge in a working retrieval system, and therefore the wiki's cleanest instance of a design that needs no separate anti-collapse provision.
- **[[wiki/entities/transformer.md]]** — the stated design reason for multi-head attention, and a rare case of a collapse mitigation priced by ablation: a single head's weighted average over positions gives "reduced effective resolution due to averaging attention-weighted positions", and at *constant* total compute the head count has an interior optimum (1 head 24.9 BLEU, 8 heads 25.8, 32 heads 25.4) — so anti-averaging is traded directly against per-head scoring width (Vaswani et al. 2017).
- **[[wiki/concepts/sparse-expert-routing.md]]** — this page's problem stated over a *discrete* selection variable: without intervention a favoured expert receives more tokens, trains faster and is favoured more, and the four remedies (auxiliary balance loss, linear-assignment/optimal-transport constraint, expert-choice routing that makes imbalance structurally impossible, dense-to-sparse annealing) are the same four families that appear wherever a discrete latent must not collapse.
- **[[wiki/concepts/environment-invariance.md]]** — the same failure in an invariance objective: the null representation `Φ₀ = 0` makes every linear classifier optimal in every environment, so it satisfies the invariance penalty exactly and only the risk term rejects it.
- **[[wiki/entities/sparsely-gated-moe.md]]** — this page's failure mode over a discrete variable, with the only clean coefficient sweep the wiki has for it: an unpenalised router reaches `max/mean` load 17.8 and costs 4.2 perplexity points, and *every* non-zero balance coefficient across a 100× range recovers full quality — the opposite of the continuous-embedding sweeps, and the reason the discretisation row of the four-ways-to-restrict list deserves separate treatment.
- **[[wiki/entities/switch-transformer.md]]** — the anti-collapse provision for a discrete selection variable in its minimal form: a single term `α·E·Σ_i f_i P_i` pairing the non-differentiable dispatch fraction `f_i` with the differentiable mean router probability `P_i`, so the gradient flows through the second while the first supplies the target, with `α = 10⁻²` chosen from a sweep across `10⁻¹…10⁻⁵` that again showed the coefficient barely matters.
