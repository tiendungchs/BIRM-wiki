# RigL (Rigged Lottery) — The Edge Set Learned by Magnitude Drop and Gradient Growth

**A sparse training method with fixed width, a fixed edge count and a fixed compute budget per step. Every `ΔT = 100` steps, each layer drops its smallest-magnitude weights. It then grows the same number of missing edges where the dense gradient `|∇_Θ L|` is largest, initialised at zero, with the swap fraction cosine-annealed to zero at ~¾ of training. On ResNet-50/ImageNet it beats every sparse method at matched training FLOPs. A net rewired this way beats a narrower dense net with the same weight count, and its learned mask, frozen and retrained from the original initialisation, is worth about 0.2 points over a random mask. The value is in the rewiring process, not in the final mask it produces.**

> **Provenance.** Evci, Gale, Menick, Castro & Elsen 2020, *Rigging the Lottery: Making All Tickets Winners*, ICML 2020 (arXiv:1911.11134; `raw/evci-2020-rigging-the-lottery-making-all-tickets-winners.md`). ImageNet-2012 (ResNet-50, MobileNet-v1/v2), CIFAR-10 (WideResNet-22-2), WikiText-103 character-level language modelling (GRU), MNIST (LeNet 300-100). 3 seeds, mean ± sd. The clip lost Figures 4–12. The MobileNet-v2, WikiText-103, CIFAR-10 and schedule-sweep results survive as text only. Table 4's "Static (ERK)" row repeats the S = 0.8/0.9 numbers and FLOPs of the Figure 2 table under the S = 0.95/0.965 headings, so it is treated as a clip or source error and not used. Everything below is from that source unless marked.

---

## Architecture

| Component | Spec | Note |
|---|---|---|
| **Initial mask** | Random sparse at per-layer sparsity `s^l`; overall `S = Σ_l s^l N^l / N` | Bias and batch-norm stay dense |
| **Per-layer allocation** | Uniform (`s^l = S`, first layer dense) · Erdős–Rényi (`1 − s^l ∝ (n^{l−1}+n^l)/(n^{l−1} n^l)`) · Erdős–Rényi-Kernel (adds `w^l + h^l` to the numerator and `w^l h^l` to the denominator) | Erdős–Rényi makes a layer's edge count scale with its **input + output units**, not with its dense size. Allocation is fixed for the whole run, so a FLOP target can be set in advance |
| **Drop** | `ArgTopK(−\|θ^l\|, k)` with `k = f_decay(t)(1 − s^l)N^l` | Smallest magnitude, per layer |
| **Grow** | `ArgTopK_{i ∉ active}(\|∇_{Θ^l} L_t\|, k)`: the same `k` missing edges with the largest instantaneous dense gradient, from one batch | New weights start at **zero**, so the output is unchanged at the moment of growth. Random or small along-gradient initial values were no better |
| **Schedule** | `f_decay(t) = (α/2)(1 + cos(tπ/T_end))`, `α = 0.3`, `ΔT = 100`, `T_end` ≈ ¾ of training | The swap fraction anneals to zero. After `T_end` the mask is frozen and only weights train |
| **Cost** | `(3 f_S ΔT + 2 f_S + f_D)/(ΔT + 1)` FLOPs per example; amortised to `∝ (1−S)` when `ΔT > 1/(1−S)` | The dense gradient is computed once per `ΔT`, layer by layer, and can be streamed keeping only the top-`k` |

**Drop rationale (Appendix A).** Deleting `θ_i` changes the loss by `ΔL_i = −∇_{θ_i}L · θ_i + R(θ_i²)`. The smallest `|θ_i|` bounds both terms. A weight can only stay small if its gradient stays small, so small magnitude also implies small saliency. **Grow rationale.** A zero-initialised edge with large `|∇|` lowers the loss fastest on the next step. Swapping flat directions for steep ones is offered as the mechanism for escaping saddle points.

### Place among sparse training methods (source Table 1)

| Method | Drop | Grow | FLOPs selectable in advance | Space and FLOPs `∝` |
|---|---|---|---|---|
| SNIP (Single-shot Network Pruning) | min `\|θ·∇L\|`, once, at initialisation | none | yes | sparse |
| DeepR (Deep Rewiring) | stochastic (sign flip → 0) | random | yes | sparse |
| SET ([[wiki/entities/sparse-evolutionary-training.md]]) | min `\|θ\|` | random | yes | sparse |
| DSR (Dynamic Sparse Reparameterization) | min `\|θ\|` | random, budget moves between layers | no | sparse |
| SNFS (Sparse Networks From Scratch) | min `\|θ\|` | momentum of the dense gradient, every step | no | **dense** |
| **RigL** | min `\|θ\|` | instantaneous dense gradient, every `ΔT` | yes | sparse |

---

## Results

### ResNet-50, ImageNet-2012 — top-1 %, training FLOPs relative to dense (dense 76.8 ± 0.09 at 3.2e18)

| Method | S = 0.8 | S = 0.9 | S = 0.95 | S = 0.965 |
|---|---|---|---|---|
| Static (random mask, frozen) | 70.6 | 65.8 | 59.5 | 55.4 |
| SNIP | 72.0 | 67.2 | **57.8** (below Static) | **52.0** (below Static) |
| Small-Dense (narrower, same weight count) | 72.1 | 68.9 | — | — |
| SET | 72.9 | 69.6 | 64.4 | 60.8 |
| **RigL** (0.23× / 0.10× / 0.23× / 0.13× FLOPs) | **74.6** | **72.0** | **67.5** | **65.0** |
| Small-Dense 5× | 73.9 | 71.3 | — | — |
| **RigL 5×** | **76.6** | **75.7** | **73.1** | **71.1** |
| RigL, Erdős–Rényi-Kernel | 75.1 | 73.0 | 69.7 | 67.2 |
| RigL 5×, Erdős–Rényi-Kernel (2.09× / 1.23× FLOPs at 0.8 / 0.9) | **77.1** | **76.4** | **74.5** | **72.7** |
| SNFS, Erdős–Rényi-Kernel (0.61× / 0.50× FLOPs) | 75.2 | 72.9 | 70.0 | 67.1 |
| Magnitude pruning, dense → sparse (Gale et al. 2019; 0.56× / 0.51×) | 75.6 | 73.9 | 70.6 | — |
| Pruning 1.5× | 76.5 | 75.2 | 72.7 | 69.26 |

- **Ordering of growth rules at fixed budget:** random mask < init-time saliency < random regrowth < gradient regrowth. SET "saturates around 75%" when training is extended. RigL does not saturate there.
- **Dynamic sparse beats a narrower dense net with the same weight count** at every matched point: +2.5 (0.8), +3.1 (0.9), and +2.7 / +4.4 at 5×.
- RigL 5× at 96.5% sparsity with Erdős–Rényi-Kernel allocation reaches 72.75% at 0.11× inference FLOPs, ~3.5 points above extended pruning.
- **Erdős–Rényi-Kernel beats uniform allocation in every method and at every sparsity**, and the margin grows with sparsity. It costs ~2× the inference FLOPs at the same weight count, because it keeps the wide 1×1 convolutions denser. Two nets with the same sparsity are not comparable unless their FLOPs are reported too.

### MobileNet-v1, ImageNet, all runs 5× (dense 72.1)

| S | Small-Dense 5× | Pruning (Zhu & Gupta 2018) | RigL 5× | RigL 5×, Erdős–Rényi-Kernel |
|---|---|---|---|---|
| 0.75 | 66.0 | 67.7 | **71.5** | **71.9** |
| 0.9 | 57.7 | 61.8 | **67.0** | **68.1** |

**Big-Sparse:** width multiplier **1.98** at 75% sparsity, i.e. the dense model's parameter count and FLOPs spread over ~2× the channels, reaches **76.4** (Erdős–Rényi-Kernel 77.0 at 1.91× FLOPs) against dense 72.1: **+4.3 at the same weights and FLOPs**. The dense arm is not reported at 5×, so part of this is schedule. MobileNet-v2 results are text only: RigL is again best by a large margin.

### Other settings (text only, figures lost)

| Setting | Finding |
|---|---|
| WikiText-103, GRU 512, 75% sparse, character level | RigL > SNFS ≈ > SET. SET barely improves with longer training. **RigL stays below magnitude pruning**, which the authors flag as open |
| CIFAR-10, WideResNet-22-2 (dense 94.1%) | Some 50%-sparse nets beat dense, i.e. sparsity acts as a regulariser. RigL matches pruning at a fraction of the cost. At equal final *training* loss RigL is ~0.5 points below pruning on test, so it optimises as well but generalises slightly worse. Training Static longer barely helps |
| Schedule sweep (ResNet-50, S = 0.8) | Best at `ΔT = 100` with `α = 0.3–0.5`. Still > 73.5% at `ΔT = 1000`. For SET and SNFS, higher `α` pairs with longer `ΔT`. Cosine ≈ linear decay; a constant schedule needs low `α` |
| SNFS momentum | 0.99 best; 0 (instantaneous gradient) ≈ 0.9. A long gradient memory helps only at extreme values (batch 4096) |

### LeNet 300-100, MNIST — edge learning also selects units (Appendix B)

Start with 99% / 89% sparse first and second layers. At the end, delete every neuron left with no incoming or outgoing edge. Architectures are written as input pixels–hidden 1–hidden 2.

| Method | Surviving architecture | Sparsity | Training GFLOPs | Size (bytes) | Error % (best / final) |
|---|---|---|---|---|---|
| VIB (Variational Information Bottleneck), best structured baseline | 97-71-33 | 0 | 13,521.6 | 38,696 | 1.6 |
| **RigL** | **408-100-69** | 0.870 | 482.0 | 31,914 | 1.44 / 1.48 |
| RigL+ (retrain from the found architecture, new init) | 375-62-51 | 0.886 | 206.3 | 16,113 | 1.57 / 1.69 |

- About half the input pixels lose every edge. The surviving input degree concentrates on the image centre, as in SET, with no loss term asking for it.
- The structured baselines report the best test error seen during training, so both numbers are given.

### No special tickets (Appendix E, ResNet-50, S = 0.8)

| Initialisation | Training | Top-1 | Training FLOPs |
|---|---|---|---|
| Original init + RigL's final mask | Static | 70.82 | 0.46× (includes the RigL run that found the mask) |
| Original init + RigL's final mask | RigL | 73.93 | 0.46× |
| Random | RigL | 74.55 | 0.23× |
| Random | RigL 2× | **76.06** | 0.46× |

Against Static with a random mask (70.6), the frozen learned mask adds **~0.2 points**. Continuing to rewire from a random start adds ~4. Restarting from the "winning ticket" is *worse* than a random restart under RigL. The caveat the source itself cites is that at ResNet-50 scale lottery tickets need weights rewound to an early training step, not the original initialisation, so the Static arm here is a weak version of the lottery ticket claim.

### Why static sparse training fails — the loss landscape (§4.4)

| Probe | Result |
|---|---|
| Linear path, static-sparse solution → pruning solution | High-loss barrier |
| Quadratic and cubic Bézier curves optimised **inside the sparse subspace** | Still a barrier |
| Quadratic Bézier optimised **in the full dense space** | Near-monotone path to the better solution |
| Restart from the static solution with RigL vs with Static | RigL escapes the basin; static retraining does not |

Reading: a fixed sparse mask can trap optimisation in a basin that is isolated *within its own subspace*. Growing edges reaches the dense-space path. This is the same kind of failure as the optimisation knee in [[wiki/concepts/width-versus-parameter-count.md]], where low connectivity fails by not fitting the training set.

### Bugs the authors report (Appendix M)

- The dense gradients of **masked** weights were not all-reduced across replicas. Fixing this added 0.5–1 points to RigL and SNFS.
- SNIP first kept the edges with the largest `|∇L|` and fell **far below a random mask**. Keeping the largest saliency `|θ·∇L|` put it above random. So the gradient magnitude that works as a *growth* criterion for zero weights fails as a *keep* criterion for trained ones.

---

## Limitations

| Limitation | Consequence |
|---|---|
| **i.i.d. accuracy only** | No distribution shift, no compositional or relational task, no robustness score. Nothing speaks to the wiki's `g`/`x` separation |
| **Language modelling is the counter-case** | On the one sequence task RigL loses to dense → sparse pruning. The gradient-growth advantage is shown on convolutional vision |
| **The growth signal is one batch** | Instantaneous `\|∇\|` from 4096 examples. SNFS's momentum ablation says a longer window helps only at 0.99. The window is not varied for RigL |
| **Dense arms are not matched at 5×** | Every 5× comparison except Small-Dense lacks a dense 5× reference, so "sparse matches dense" at 5× mixes in schedule length |
| **Speed is FLOP-counted, not timed** | As with SET, no wall-clock measurement on sparse hardware |
| **Allocation is hand-set, not learned** | Erdős–Rényi-Kernel wins but is a fixed formula. DSR's learned reallocation was dropped to keep FLOPs fixed |
| **Biology is absent** | The paper makes no biological claim. Every biological reading below is the wiki's `(brainstorm)` |

---

## Comparison

| | **RigL** | [[wiki/entities/sparse-evolutionary-training.md]] | [[wiki/entities/hag-reservoir.md]] | Static random (`width-versus-parameter-count`) | Dense → sparse pruning |
|---|---|---|---|---|---|
| Edge set | Learned, frozen at ¾ training | Learned every epoch | Grown from empty | Drawn once | Starts dense, shrinks |
| Erase criterion | Smallest `\|θ\|` | Smallest `\|θ\|` | Random | — | Smallest `\|θ\|` |
| Growth criterion | **Largest `\|∇L\|`**, zero init | Random | Largest activity correlation | — | None |
| Cost `∝` | `1 − S` | `1 − S` | Grows to homeostasis | `1 − S` | Dense at start |
| ResNet-50, S = 0.8, 1× | **74.6** | 72.9 | not run | 70.6 | 75.6 at 0.56× FLOPs |
| Beats narrower dense at matched weights? | Yes, on every ResNet-50 and MobileNet point | Yes, on ResNet-50 | — | **No on ResNet-50** (70.6 vs 72.1); yes on ResNet-18 (Golubeva 2021) | — |

**(brainstorm) RigL is the hybrid the SET page asked for, with an error signal in place of activity.** For a dense layer, `∇_{W_ij} L = Σ_batch δ_i x_j`: postsynaptic error times presynaptic activity, summed over a batch. So "grow where `|∇|` is largest" is correlation-based growth, as in HAG, except that the postsynaptic term is an error, not an activity. That is the same pre-activity × post-error form as eHebb (error-based Hebbian plasticity) in [[wiki/concepts/synaptic-plasticity.md]]. Magnitude erase plus error-correlation growth is therefore a candidate *local* structural rule, provided an error term is available at the postsynaptic unit. HAG found a long correlation window mattered, and RigL uses one batch, so the window is the open parameter.

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| Mask | Current hypothesis about which variable pairs interact |
| Drop smallest `\|θ\|` | Delete the edges the fit has least use for |
| Grow largest `\|∇\|` | Greedy score-based edge addition: add the missing edge whose inclusion would most improve the objective. This is the classic structure-search move, run inside gradient training |
| Anneal to `T_end`, then freeze | A search phase followed by a commitment phase. Structure is revised while weights are still moving, then fixed |
| Static basin isolation | A structure frozen before the weights are fit can trap the fit in a basin that no path inside that structure leaves |
| No special tickets | The graph found by the search is worth ~0.2 points without the search. What transfers is the revision process, not its output |

**(brainstorm) Keep the hypothesis graph revisable while its parameters are fit.** Any latent-graph learner that commits to an edge set first and then fits weights on it is the Static arm. Here that arm lands in an isolated basin and, with the learned mask, recovers only ~0.2 of the ~4 points that continued rewiring gives. It also says the wiki should not expect a copied structure to carry the gain by itself, whether copied from morphology (`T64`) or from a previous run, without the process that found it.

---

## Connections

- **[[wiki/entities/sparse-evolutionary-training.md]]** — the same drop rule with growth changed from random to gradient-directed. That one change moves ResNet-50 at 80% sparsity from 72.9 to 74.6 and removes SET's saturation at ~75% under longer training, which prices SET's blind regrowth.
- **[[wiki/entities/hag-reservoir.md]]** — both grow edges by a correlation, but HAG correlates pre- and postsynaptic *activity* over a long window without labels, while RigL correlates presynaptic activity with postsynaptic *error* over one batch. HAG's random pruning is the operation RigL replaces with smallest-magnitude drop.
- **[[wiki/concepts/width-versus-parameter-count.md]]** — the same weight-budget question with the opposite sign for a frozen random mask: on ResNet-50 a random-mask wide net loses to the narrower dense net (70.6 vs 72.1), while on ResNet-18 it wins. With a rewired mask the wide sparse net wins at every point, and Big-Sparse MobileNet is +4.3 at identical weights and FLOPs.
- **[[wiki/concepts/synaptic-plasticity.md]]** — supplies a priced *growth* criterion to set beside the magnitude erase criterion. Grow where `|pre-activity × post-error|` is largest. The SNIP bug shows the same gradient magnitude fails as a keep criterion, so growth and retention need different statistics.
- **[[wiki/concepts/cellular-scaling-rules.md]]** — Erdős–Rényi allocation sets a layer's edges in proportion to its input + output units, i.e. roughly constant edges per unit across layers. It beats uniform per-layer density in every method and at every sparsity, so how the wiring-per-unit ratio is spread across stages matters as well as its average (`G101`).
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — a second machine network that deletes its weakest edges first and scores the deletion by accuracy alone. Its LeNet run also deletes whole units that end with no edges, a k-core-like erosion that emerges from edge learning, but reachability is never measured.
- **[[wiki/entities/dendritic-ann.md]]** — the "no special tickets" result bears on `T64` from the process side. A learned mask, frozen and retrained, is worth ~0.2 points over random, so copying a found structure without the process that found it buys little, whether the copy comes from morphology or from a previous run.
