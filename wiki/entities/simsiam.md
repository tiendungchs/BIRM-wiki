# SimSiam

**A joint-embedding learner reduced to its minimum: two shared-weight branches, a predictor on one side, a stop-gradient on the other, and nothing else — no negatives, no momentum encoder, no clustering, no large batch. 68.1% ImageNet linear evaluation at 100 epochs, above every method it is a subtraction of, and the one component whose removal collapses it is the `detach()`.**

> **Provenance.** Chen & He 2021, *Exploring Simple Siamese Representation Learning* (`raw/chen-2021-simsiam.md`), FAIR. ResNet-50, SGD (no LARS), batch 256–512. The theory paper for the same system is Tian, Chen & Ganguli 2021 ([[wiki/entities/byol.md]] §The dynamics, solved); the method it subtracts from is [[wiki/entities/byol.md]].

---

## Architecture

| Component | Spec |
|---|---|
| **Encoder `f`** | ResNet-50 backbone + projection MLP, **3 layers**, hidden 2048-d, BN on every fc *including the output* (no ReLU on the output); weights **shared** between branches |
| **Predictor `h`** | 2-layer MLP, `2048 → 512 → 2048` — a **bottleneck** (hidden = `d/4`), BN on hidden only, no BN and no ReLU on the output |
| **Loss** | `L = ½·D(p₁, sg(z₂)) + ½·D(p₂, sg(z₁))`, `D` = negative cosine similarity of ℓ₂-normalised vectors (= MSE of normalised vectors up to a factor 2) |
| **Optimiser** | plain **SGD**, base `lr = 0.05 × BatchSize/256`, cosine decay, wd `1e-4` applied to BN scales and biases too, momentum 0.9; batch **256** default |
| **Kept at the end** | backbone only |

Twelve lines of PyTorch. The entire anti-collapse provision is `z = z.detach()` inside the distance function.

---

## The hub: every neighbour is SimSiam plus one component

| Method | What SimSiam removes | The removed component's stated job |
|---|---|---|
| [[wiki/entities/byol.md]] | the momentum encoder | prevent collapse (BYOL's claim) / supply a smoother target |
| SimCLR (locus 1, [[wiki/concepts/alignment-uniformity.md]]) | the negatives | repel different images out of the constant solution |
| SwAV | online clustering + Sinkhorn–Knopp | a balanced partition, which cannot be constant |
| MoCo | the queue **and** the momentum encoder | maintain many consistent negatives |

**Each neighbour's designated anti-collapse mechanism can be deleted and the system still trains.** What survives all four subtractions is the Siamese shape plus the stop-gradient, which is the paper's argument that the *weight-sharing Siamese structure itself* is the operative inductive bias — invariance modelled by architecture the way translation invariance is modelled by convolution, rather than by a term.

---

## What is and is not the provision

| Varied | Result | Reading |
|---|---|---|
| **stop-gradient removed** | **0.1%** (chance); training loss reaches its minimum `−1` immediately, per-channel std of `z/‖z‖` → **0** | Collapse solutions *exist* and are found instantly. Architecture alone — predictor, BN, ℓ₂-norm all unchanged — does not exclude them |
| with stop-gradient | 67.7 ± 0.1 over 5 trials; std of `z/‖z‖` sits at **`1/√d`** | The value for a zero-mean isotropic Gaussian: outputs scattered on the sphere, i.e. the *uniformity* half of [[wiki/concepts/alignment-uniformity.md]] reached with no term asking for it |
| **predictor `h` removed** | **0.1%** — collapse. Under the symmetrised loss this is provable: the gradient direction equals that of `D(z₁,z₂)` scaled by ½, so stop-gradient becomes a no-op | The predictor is what makes the stop-gradient mean anything |
| `h` frozen at random init | **1.5%** — loss stays high, **not** collapse | Failure to converge, a different mode from collapse. `h` must track the current representation |
| `h` with **constant** `lr` (no decay) | **68.1** > 67.7 baseline | The predictor should *not* be allowed to converge — direct support for the rate-not-optimality reading (T305) |
| batch size 64 / 256 / 4096 | 66.1 / **68.1** / 64.0 | Flat 64→2048 on plain SGD. SimCLR and SwAV need 4096; the drop at 4096 is SGD's, not collapse |
| **all BN removed from both heads** | **34.6%**, no collapse | BN is an optimisation aid, not an anti-collapse device — the wiki's locus 5 does not apply here |
| BN added to the predictor's *output* | unstable, oscillating loss | — |
| cosine → **cross-entropy** similarity | 63.2 (vs 68.1) | Collapse-prevention is not a property of the cosine |
| **asymmetric** loss (Eq. 3, one direction) | 64.8; 67.3 with two pairs sampled | Symmetrisation is denser sampling of `T`, worth ~1 point, unrelated to collapse |
| output dim `d` = 256 / 2048 | 65.3 / **68.1** | Keeps improving to 2048, unlike MoCo/SimCLR/BYOL which saturate at 256–512 |

---

## The hypothesis: an alternating optimisation, and stop-gradient as its consequence

The wiki's standing statement of this family is that there is *no* objective ([[wiki/concepts/objective-identifiability.md]], T164). SimSiam offers a candidate — not a loss over `θ` alone, but a two-variable problem solved by alternation:

```
L(θ, η) = E_{x,T} ‖ F_θ(T(x)) − η_x ‖²        minimise over BOTH θ and η
```

`η` is **not** a network output. It is one free vector per image — an argument of the optimisation, of size proportional to the dataset. The analogy is k-means: `θ` ≈ the cluster centres, `η_x` ≈ the assignment of sample `x`.

| Subproblem | Solution | What it becomes in the algorithm |
|---|---|---|
| `θ^t ← argmin_θ L(θ, η^{t−1})` | one SGD step | **The stop-gradient is a consequence, not a trick** — `η^{t−1}` is a constant in this subproblem, so no gradient flows to it |
| `η^t ← argmin_η L(θ^t, η)` | `η^t_x ← E_T[F_{θ^t}(T(x))]` — the augmentation-averaged representation | Approximated by **one** sample: `η^t_x ← F_{θ^t}(T'(x))`, which is the second branch |
| the ignored `E_T[·]` | — | **What the predictor `h` is for**: its own optimum is `h(z₁) = E_z[z₂] = E_T[f(T(x))]`, exactly the expectation dropped by the one-sample approximation, learnable because `T` is resampled across epochs |

**Three proof-of-concept experiments, and they are the reason this is more than a story.**

| Prediction | Test | Result |
|---|---|---|
| SimSiam is the `k = 1` case of a *multi*-step alternation | cache `η_x` for all images, then run `k` inner SGD steps | 1-step **68.1**, 10-step **68.7**, 100-step **68.9**, 1-epoch 67.0 — the expensive versions are *better*, so the alternating formulation is the general case and SimSiam is its cheap approximation |
| `h` exists only to approximate `E_T[·]` | replace it with a **moving average** `η^t_x ← m·η^{t−1}_x + (1−m)F_{θ^t}(T'(x))`, `m = 0.8`, **and delete `h`** | **55.0%** — against 0.1% (collapse) for deleting `h` with no moving average. A memory bank over `η` substitutes for the predictor |
| symmetrisation is denser sampling of `T` | asymmetric variant | 64.8 → 67.3 when a second pair is sampled (above) |

**The honest limit, stated by the authors:** the hypothesis says what is being optimised; it does **not** explain why collapse is avoided. Their offered reason is a trajectory argument — `η` initialised from a random network is not constant, and the optimiser never computes gradients over all `η_x` jointly, so the constant solution is hard to reach from that start. That is the same claim the linear dynamics later made precise as an initialisation-dependent escape condition `s_j(0) > p_j²(0)/α_p` (Tian et al. 2021, [[wiki/entities/byol.md]]).

---

## Grafting: two more composability data points

| Graft | Result | |
|---|---|---|
| SimCLR **+ predictor** | 66.5 → 66.4 | neutral |
| SimCLR **+ predictor + stop-gradient** | 66.5 → 66.0 | neutral-to-slightly-negative |
| SwAV **+ predictor** | 66.5 → 65.2 | mildly harmful |
| SwAV **− stop-gradient** (trained end-to-end through Sinkhorn–Knopp) | **NaN** | SwAV is *itself* an alternating formulation; its stop-gradient is structural, not optional |

These sit beside the Barlow Twins (−10) and VICReg (0.0) grafts in T166. The pattern they support: the update-rule asymmetry is **inert** where a sample-contrastive term already fixes the minimum, **catastrophic** only where a second implicit cross-branch coupling exists (Barlow Twins' batch standardisation), and **mandatory** where the method is already alternating (SwAV).

---

## Results

| Method | batch | negatives | momentum enc. | 100 ep | 200 ep | 400 ep | 800 ep |
|---|---|---|---|---|---|---|---|
| SimCLR (repro.+) | 4096 | ✓ | | 66.5 | 68.3 | 69.8 | 70.4 |
| MoCo v2 (repro.+) | 256 | ✓ | ✓ | 67.4 | 69.9 | 71.0 | 72.2 |
| BYOL (repro.) | 4096 | | ✓ | 66.5 | 70.6 | 73.2 | **74.3** |
| SwAV (repro.+) | 4096 | | | 66.5 | 69.1 | 70.7 | 71.8 |
| **SimSiam** | **256** | | | **68.1** | 70.0 | 70.8 | 71.3 |

**Best at 100 epochs, worst-scaling with budget.** SimSiam wins the short-run column outright and gains only +3.2 over 8× more training where BYOL gains +7.8. Transfer (VOC/COCO detection and instance segmentation, 200-epoch pretrain) is competitive with all four and, under a retuned recipe (`lr = 0.5`, `wd = 1e-5`), the best or within 0.5 of the best on every one of the twelve columns — including over ImageNet-**supervised** pretraining, which every method in the table beats on detection.

---

## Why this matters for building a reasoning model

- **The cheapest anti-collapse provision in the wiki is one line and zero coefficients**, and its price is a *training-horizon* ceiling rather than a hyperparameter budget — which is the same axis DINOv3's partial collapse turned out to live on ([[wiki/concepts/representational-collapse.md]], T168). A provision can be free at design time and expensive at scale.
- **It supplies the wiki's only worked example of "a stop-gradient is an alternating minimisation over a variable that is not a network output".** That template transfers directly: wherever a design has a target the loss must not differentiate through — a JEPA's target encoder, a slow world-model, a memory whose contents are optimised rather than emitted — the question to ask is *what is the second variable set, and would a multi-step schedule over it do better?* Here it did (+0.8), which nobody in the JEPA lineage has tested.
- **The predictor is an amortiser of an expectation over nuisance transformations**, with the substitution test to prove it (moving-average `η` replaces it at 55%). That is a concrete instance of [[wiki/concepts/amortized-inference.md]]'s pattern where a network is trained to output a quantity too expensive to compute, and it is the clearest statement available of *what* invariance a Siamese design buys: the code of `x` is the mean of its augmented codes.
- **It removes the batch from the design.** Every other member of this family couples the anti-collapse provision to the batch — negatives coexisting in it, a partition balanced over it, a cross-correlation standardised along it. SimSiam's provision is per-sample, which is the only version of this family that could run on a stream of one experience at a time.

---

## Limitations

- **No account of non-collapse.** The alternating formulation explains the stop-gradient and the predictor; the authors explicitly decline to explain why the trajectory avoids the constant solution. That was later closed *only* in a bias-free two-layer linear model with no ℓ₂ normalisation and no BN — none of which this system lacks.
- **The gains stop.** Above ~400 epochs it is the weakest of the five, so whatever the EMA buys BYOL is real and is not collapse prevention.
- **Everything is ImageNet linear evaluation + COCO/VOC.** No dense-read-out probe of the kind that exposed partial collapse, and no test of whether the `1/√d` spread survives a long run.
- **The `η` formulation is a hypothesis about *this* algorithm, not a derivation of it.** Multi-step alternation is a different algorithm that works better; that is evidence for the family, not a proof that 1-step SGD is doing alternating minimisation.

---

## Connections

- **[[wiki/entities/byol.md]]** — the method this is a subtraction of, and the direct empirical conflict: BYOL reports 0.3% when its momentum encoder is removed and SimSiam reports 68.1% for the same removal under a different recipe (T308); it is also the system whose solved linear dynamics are literally this one with `W_a = W`.
- **[[wiki/concepts/representational-collapse.md]]** — the home page for the provision: this is locus 4 stripped to its minimum, and it is the source of three of that page's negative results — BN is not the provision (34.6% without it, no collapse), the batch is not the provision (flat 64→2048), and the cosine is not the provision (cross-entropy works).
- **[[wiki/concepts/objective-identifiability.md]]** — the strongest available answer to that page's sixth direction: there may be no loss over `θ` *alone*, but there is a candidate two-variable objective whose alternating minimisation has the stop-gradient as a consequence, with multi-step alternation as the confirming experiment.
- **[[wiki/concepts/amortized-inference.md]]** — the predictor read as an amortiser of `E_T[f(T(x))]`, with the un-amortised version built (a moving-average memory bank over per-image variables) and priced at 55%.
- **[[wiki/concepts/alignment-uniformity.md]]** — the per-channel std sitting at `1/√d` is the uniformity half reached with no uniformity term, which is the sharpest instance of that page's two statistics being drivable by an update rule rather than a loss.
- **[[wiki/entities/vicreg.md]]** — the comparison that separates the two ways of driving those statistics: VICReg imposes variance and decorrelation explicitly, SimSiam reaches the same `1/√d` implicitly, and grafting each onto the other is worth ≈0 (T166).
- **[[wiki/entities/barlow-twins.md]]** — the other end of the composability result: the predictor + stop-gradient graft costs it 10 points where it costs SimCLR 0.5, which localises the conflict on batch standardisation rather than on the asymmetry.
- **[[wiki/entities/i-jepa.md]]** — the same skeleton with the pair sampler moved from augmentation to masking; SimSiam is the control showing how little of the machinery around that skeleton is load-bearing.
- **[[wiki/entities/lewm.md]]** — the opposite programme: LeWM removes the stop-gradient on the grounds that it descends no objective, and this page is the strongest counter-argument that it descends *an* objective, just not one over the network's parameters alone.
- **[[wiki/concepts/environment-invariance.md]]** — the paper's architectural claim in its general form: weight-sharing across two views is an inductive bias *for* invariance in the same way convolution is one for translation, so invariance can be a property of the architecture rather than a penalty.
- **[[wiki/entities/mae.md]]** — the same subtraction taken one step further by changing the target rather than the machinery: with a *fixed* input-space target there is no degenerate solution to defend against, so the predictor and the stop-gradient this page reduces to are both unnecessary — at the cost of the weakest frozen linear probe in the family (T310).
