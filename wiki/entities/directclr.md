# DirectCLR

**A contrastive learner with no trainable projector: apply InfoNCE to a *fixed sub-vector* `r[0:d₀]` of the backbone's own output. 62.7% ImageNet linear evaluation against 61.1 for SimCLR with a trainable linear projector — and the reason it works is the paper's real content, that the projector's job is to be the place where dimensional collapse is allowed to happen.**

> **Provenance.** Jing, Vincent, LeCun & Tian 2022, *Understanding Dimensional Collapse in Contrastive Self-supervised Learning*, ICLR (`raw/jing-2022-dimensional-collapse-contrastive.md`), FAIR. ResNet-50, LARS, batch 4096, 100 ImageNet epochs — the SimCLR recipe held fixed throughout. Code: `facebookresearch/directclr`.

---

## The measurement that opens it

Train SimCLR normally (2-layer MLP projector, 128-d embedding `z`), collect `z` over ImageNet-val, take `C = (1/N)Σ(z_i − z̄)(z_i − z̄)ᵀ` and plot `log σ^k` sorted. **A block of singular values sits at zero.** The contrastive family — the one locus whose provision is *provably* a distribution-matching term with the full-rank uniform target `σ_{m-1}` ([[wiki/concepts/alignment-uniformity.md]]) — trains to a rank-deficient embedding as a matter of course. Non-contrastive methods were known to do this; the claim here is that negatives buy freedom from *complete* collapse and nothing more.

---

## Two mechanisms, and they are separable

Linear model `z = Wx`, additive-noise augmentation, InfoNCE, plain SGD (no momentum, no weight decay). Gradient flow `Ẇ = −G`, and `G = −WX` with

```
X  =  Σ̂₀ − Σ̂₁
Σ̂₀ = Σ_{i,j} α_ij (x_i − x_j)(x_i − x_j)ᵀ        weighted data covariance
Σ̂₁ = Σ_i (1 − α_ii)(x′_i − x_i)(x′_i − x_i)ᵀ     weighted augmentation covariance
```

both PSD, with `α_ij` the InfoNCE softmax weights. Everything follows from the sign of `X`.

| Mechanism | Condition | Result | Scope of the proof |
|---|---|---|---|
| **1 — strong augmentation** | `X` has negative eigenvalues, i.e. the augmentation's variance **exceeds the data's** along some direction | `W` acquires vanishing singular values ⟹ `C = WΣ_xWᵀ` is low-rank (Thm 1, Cor 1) | Single linear layer. Verified numerically with a block-diagonal augmentation covariance `block(0, k·I)`: raise `k`, watch the spectrum fall |
| **2 — implicit regularisation** | `X ≻ 0` (weak augmentation), **and the network is over-parametrised** | adjacent layers align (`A = V₂ᵀU₁ → I`, Thm 2), after which `σ̇₁^k = σ₁^k(σ₂^k)²·(v₁^kᵀ X v₁^k)` — each singular value's growth rate is **proportional to itself**, so the smallest never catch up (Thm 3, Cor 2) | Two-layer linear MLP. Extended empirically to `L > 2` (more layers ⟹ more collapsed dimensions) and to ReLU between layers (same effect). **`L = 1` shows no collapse**, which is the control |

Two things this settles that the wiki's collapse taxonomy did not have:

- **Augmentation strength has a closed-form collapse criterion, per direction.** Not "augmentations are a large lever" (T167) but `Σ̂₁ ⊀ Σ̂₀` ⟹ that direction dies. It is the same pair of matrices Tian, Chen & Ganguli 2021 reduce BYOL to (`X`, `X′`), now deciding rank rather than magnitude ([[wiki/entities/byol.md]]).
- **Depth is an anti-provision.** Over-parametrisation causes the collapse, by the standard deep-matrix-factorisation route (Arora et al. 2019, Gunasekar et al. 2018): more adjacent matrices align, and low-rank-ness in the product is amplified. Every method in the family stacks a 2–3 layer projector on the encoder, so every method pays this.

---

## The projector, explained — and it is a *sequestration* device

Train SimCLR with and without a projector and measure the spectrum of the **representation** `r` (the 2048-d ResNet output, the thing actually used downstream), not the embedding:

| | Representation `r` spectrum | ImageNet linear probe |
|---|---|---|
| SimCLR, no projector | **dimensionally collapsed** | 51.5 |
| SimCLR, 1-layer linear projector | full | 61.1 |
| SimCLR, 2-layer nonlinear projector | full | 66.5 |
| DirectCLR, no projector | full | **62.7** |

So the projector does not prevent dimensional collapse — it *relocates* it, one layer downstream of the read-out. The loss's own space is collapsed in every one of these runs; what the projector buys is that the collapse happens where nobody reads.

**Two propositions, both derived from mechanism 2 and both ablated.** Because the encoder's last layer `W₁ = U₁S₁V₁ᵀ` is fully trainable and will align to whatever sits after it (`V₂ᵀU₁ → I`), the projector `W₂ = U₂S₂V₂ᵀ` contributes only through `S₂`:

1. **A linear projector need only be diagonal** — its orthogonal factors are redundant.
2. **A linear projector need only be low-rank** — it converges there anyway.

| Projector | diagonal | low-rank | Top-1 |
|---|---|---|---|
| none | | | 51.5 |
| orthogonal-constrained (all `σ = 1`) | | | 52.2 |
| trainable linear | | | 61.1 |
| trainable **diagonal** | ✓ | | 60.2 |
| fixed **low-rank** | | ✓ | 62.3 |
| fixed low-rank diagonal (**= DirectCLR**) | ✓ | ✓ | **62.7** |

The orthogonal row is the sharp one: a projector whose singular values are *pinned at 1* — maximally full-rank, no capacity removed — performs like having no projector at all. **What the projector contributes is exactly its ability to throw dimensions away.**

---

## The method

`z = r[0:d₀]`, `ẑ = z/‖z‖`, standard InfoNCE on `ẑ`. `d₀` is the only new hyperparameter (`d₀ = 360` of 2048 used; the curve degrades at both ends — too little gradient signal as `d₀ → 0`, and `d₀ → 2048` *is* SimCLR-without-projector). Equivalently: a fixed diagonal projector with `d₀` ones and `2048 − d₀` zeros.

| Ablation | Result | What it shows |
|---|---|---|
| Linear probe on the sub-vector `z` **only** | 47.9 vs 62.7 on the whole `r` | The un-gradiented tail `r[d₀:]` carries most of the information |
| **Random** `d₀` dimensions re-drawn every step, instead of a fixed sub-vector | **43.0** | The alignment effect (Thm 2) needs a *stationary* subspace to align to. Dropout-style dimension selection destroys the mechanism |

The tail is informative because of the **residual connection**: the low-rank gradient entering `r` becomes full-rank after passing back through the last nonlinear conv block, so the hidden layer `h` (also 2048-d) is trained on all channels, and `h` is added into `r` on the forward pass.

---

## Limitations

- **The nonlinear projector is unexplained and still wins by 3.8 points.** The theory covers linear projectors; the paper's own disclaimer is that DirectCLR does not remove the nonlinear-projector mechanism, it *inherits* it from the backbone's last block via the residual path. The best-performing configuration in the whole paper is the one the theory does not cover.
- **The proofs are linear.** Mechanism 2's extension to ReLU and to `L > 2` is a 16×16 toy simulation, not a theorem; mechanism 1's "strong augmentation" is explicitly said to become a more complicated condition (higher-order statistics, manifold geometry vs. network capacity) in the nonlinear case.
- **`X` is treated as fixed** in Thm 1, though `α_ij` depends on the current embeddings.
- **No downstream evidence beyond linear probing**, which is the read-out [[wiki/empirical-tensions.md]] T310 questions — and the paper's central claim is precisely that a *different* read-out (the embedding) is collapsed while this one is healthy.

---

## Why this matters for building a reasoning model

1. **It supplies the per-direction criterion the collapse taxonomy was missing on the data side.** "Do not let the nuisance transformation's variance exceed the signal's, in any direction you want to keep" is a designable statement about an augmentation set / pair sampler, which nothing else in the wiki's G34 material provides.
2. **It makes the throwaway head a first-class architectural component.** If collapse is going to happen, the design question is *where*, and the answer is: in a module deleted at the end. **(brainstorm)** The same move should be available to any objective with a degenerate direction — attach the loss to a low-rank projection of the representation and let the projection absorb the degeneracy, rather than adding a term to forbid it. For [[wiki/concepts/latent-graph-discovery.md]]'s structural code `g`, this predicts that a path-consistency loss should be applied through a discardable head, so that the trivially-consistent constant solution is available *there* and not in the code itself.
3. **Depth interacts with the objective, not just with capacity.** A deeper trunk makes every self-supervised objective more collapse-prone by implicit rank minimisation, independent of the anti-collapse term — a scaling consideration in the opposite direction from the usual one.

---

## Connections

- **[[wiki/concepts/representational-collapse.md]]** — the parent, and the page this most changes: collapse here is neither prevented nor prevented-from-being-total but *relocated* into a discarded head, and both of its causes (augmentation variance, over-parametrisation) sit outside every provision that page catalogues.
- **[[wiki/concepts/alignment-uniformity.md]]** — the measured counterpart to that page's theorem: the contrastive loss's minimiser is the full-rank uniform `σ_{m-1}`, and the trained embedding's covariance is rank-deficient, which is what "the minimum is not in the feasible set" looks like as a spectrum.
- **[[wiki/entities/byol.md]]** — the same two augmentation matrices (`X`, `X′`) and the same alignment-of-adjacent-layers lemma, run on the contrastive branch of the family rather than the dynamical one: there they set the non-collapsed fixed point's magnitude, here they set its rank.
- **[[wiki/entities/simsiam.md]]** — the method whose ablation table this completes: SimSiam shows each neighbour's designated anti-collapse device is deletable, and this shows the component none of them deletes — the projector — is doing a job no coefficient count records.
- **[[wiki/entities/barlow-twins.md]]** — the opposite bet on the same component: an 8192-wide projector with monotone gains in width, where this argues the projector should be *low-rank*, so the family disagrees by a factor of ~20 on the dimension the loss should see.
- **[[wiki/entities/vicreg.md]]** — the dimension-contrastive term is a direct provision against exactly the failure measured here, applied in the embedding space this page argues is the wrong place to care about.
- **[[wiki/concepts/population-geometry.md]]** — the same quantity read from the other side: participation ratio / covariance rank as a measure of a population code, here as a training pathology rather than a task-imposed dimensionality.
- **[[wiki/entities/cpc.md]]** — the objective whose embeddings this page measures as rank-deficient, at its origin: CPC introduces the loss and the `I ≥ log N − L_N` reading, and the collapse found here is invisible to both.
