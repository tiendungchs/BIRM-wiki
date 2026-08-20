# HiT-JEPA (Hierarchical Interactions of Trajectory Semantics via a Joint Embedding Predictive Architecture)

**Three JEPAs stacked over a Conv1D/MaxPool pyramid of the *same* sequence, each predicting masked targets at its own resolution, coupled only by passing the coarse level's attention matrix down to the fine level — the wiki's first *trained* hierarchical JEPA, and the finding is that the stack buys zero-shot transfer rather than in-distribution accuracy.**

> **Provenance.** Li, Xue, Ao, Song & Salim 2025, *HiT-JEPA: A Hierarchical Self-supervised Trajectory Embedding Framework for Similarity Computation* (`raw/li-2025-hit-jepa-trajectory-embedding.md`), UNSW. Domain is urban GPS trajectory similarity search, not reasoning; it is held here because it is the only system in the wiki that builds the *stack* [[wiki/entities/h-jepa.md]] proposes and [[wiki/entities/v-jepa-2.md]], [[wiki/entities/i-jepa.md]] and [[wiki/entities/lewm.md]] all decline to build. Direct predecessor: T-JEPA (Li et al. 2024), a single-level trajectory JEPA, which is also the strongest baseline.

---

## Architecture

| Component | Spec |
|---|---|
| **Input tokenisation** | GPS point → **Uber H3 hexagonal cell** (resolution 11 Porto, 10 T-Drive/GeoLife/TKY/NYC, **4** for ocean-scale AIS). Cells form a graph `G=(V,E)`, six equidistant neighbours per node; node embeddings `H = {h_i ∈ R^d}` pretrained by **node2vec** and looked up per point |
| **Abstraction pyramid** | `T⁽¹⁾ = Conv1D(T)` at `(d, n)`; `T⁽²⁾ = MaxPool1D(Conv1D(T⁽¹⁾))` at `(2d, n/2)`; `T⁽³⁾` likewise at `(4d, n/4)`. Channels double as length halves |
| **Per-level JEPA** | At each `l`: context encoder `E_θ⁽ˡ⁾`, target encoder `E_θ̄⁽ˡ⁾` (EMA of `E_θ⁽ˡ⁾`), predictor `D_φ⁽ˡ⁾`. All **1-layer** transformers, 8 heads, `d=256`, hidden 1024, learnable positional encoding |
| **Targets** | `M = 4` masked spans per level; ratio drawn uniformly from `r = {10,15,20,25,30}%`; with `p = 0.5` the mask is **successive**, else scattered |
| **Context** | one span at ratio `p_γ ∈ [85%, 100%]`, with all target-overlapping positions **deleted** (leakage guard) |
| **Prediction** | `S̃′⁽ˡ⁾(i) = D_φ⁽ˡ⁾(CONCAT(S′⁽ˡ⁾, PE(i) ⊕ z⁽ˡ⁾))` — mask tokens carrying target positional embeddings, as in I-JEPA |
| **Loss** | `L = 0.05·L⁽¹⁾ + 0.15·L⁽²⁾ + 0.8·L⁽³⁾`, each `L⁽ˡ⁾ = SmoothL1(S̃′⁽ˡ⁾, S⁽ˡ⁾) + VarLoss + CovLoss` on MLP-expanded context **and** target embeddings ([[wiki/entities/vicreg.md]] minus the invariance term, which the JEPA regression already is) |
| **Inference output** | `S′⁽¹⁾` — the **finest** context encoder, run on the full trajectory |

### The hierarchical interaction: a top-down attention spotlight, not a feature path

The only channel between levels is the multi-head **attention coefficient matrix**, upsampled and added downward:

```
A⁽ˡ⁾ ∈ [0,1]^{n⁽ˡ⁾×n⁽ˡ⁾}                     # softmax(QKᵀ/√d_k), concat over heads, projected by W^O
Ã⁽ˡ⁾ = ConvTranspose1d(A⁽ˡ⁾) ∈ [0,1]^{n⁽ˡ⁻¹⁾×n⁽ˡ⁻¹⁾}
A⁽ˡ⁻¹⁾ ← A⁽ˡ⁻¹⁾ + σ·Ã⁽ˡ⁾                     # σ learnable scalar
S⁽ˡ⁾   = A⁽ˡ⁾ V⁽ˡ⁾
```

Applied identically in the context and target branches. Coarse level decides *where* the fine level looks; the fine level's *values* are never mixed with the coarse level's. **This is the load-bearing choice** — see the ablation.

**Two structural notes the wiki should keep separate from the trajectory application.**

1. **The hierarchy is over sequence resolution, not over prediction horizon.** [[wiki/entities/h-jepa.md]]'s stack is defined by level 2 predicting *further ahead* on coarser representations; here every level predicts masked spans of the same sequence at its own granularity, with no time-scale differential and no actions. So this instantiates the *coarse-graining* half of the design and leaves the *jumpy-prediction* half untouched — which is the half the planning argument depends on.
2. **The loss weight is inverted with respect to the read-out.** The coarsest level carries `ν = 0.8`, 16× the finest level's `λ = 0.05`, yet the representation shipped at inference is level 1's. The gradient budget is spent on the abstraction and cashed out at the detail level, through the attention path only. Nobody ablates the weighting.

---

## Results

Metric is **mean rank** of a trajectory's held-out half when queried by its other half (odd- vs even-indexed points) against a distractor database; 1.000 is perfect, chance is `|D|/2`. `R₁…R₅` sweep database size 20→100%, downsampling rate `ρ_s` 0.1→0.5, and coordinate distortion `ρ_d` 0.1→0.5 independently.

### Trained in-distribution — a wash

| Dataset (R₅: hardest setting) | TrajCL | CLEAR | T-JEPA | HiT-JEPA |
|---|---|---|---|---|
| Porto, `\|D\|` 100% | **1.014** | 4.204 | 1.074 | 1.069 |
| Porto, `ρ_s` 0.5 | 68.557 | 123.921 | **23.900** | 28.770 |
| T-Drive, `ρ_s` 0.5 | 3.356 | 3.902 | 4.115 | **2.182** |
| T-Drive, `ρ_d` 0.5 | 1.179 | 1.172 | 1.078 | **1.031** |
| GeoLife, `ρ_s` 0.5 | 2.675 | 3.712 | **1.218** | 1.403 |

Porto (dense, 1.4M trajectories, fine sampling) goes to the contrastive baseline, which can exploit speed and orientation cues; GeoLife goes to single-level T-JEPA by 2.8%. HiT-JEPA wins T-Drive, whose sampling interval averages **3.1 minutes** — sparse and irregular, i.e. the regime where a coarse summary is the only stable signal.

### Zero-shot transfer (train Porto → test elsewhere, no adaptation) — not a wash

| R₁, `\|D\|` | TrajCL | CLEAR | T-JEPA | HiT-JEPA |
|---|---|---|---|---|
| FourSquare-TKY (sparse check-ins) | 17.590 | 119.561 | 1.948 | **1.515** |
| FourSquare-NYC | 4.336 | 19.693 | 1.450 | **1.393** |
| AIS(AU) vessels — **ocean scale, H3 res 4 vs 11** | 9.057 | 38.042 | 2.156 | **1.336** |

The AIS row is the paper's strongest: a model trained on taxi trajectories inside one city, evaluated on ship tracks spanning a continent at a 7-level-coarser spatial tokenisation, halves the single-level JEPA's error. Both contrastive baselines fall apart entirely (CLEAR is at 38 and 188 — near chance for `|D|=7000`).

### Downstream fine-tuning (frozen encoder + 2-layer MLP regressing four heuristic distances)

Average over EDR / LCSS / Hausdorff / Fréchet × HR@5, HR@20, R5@20:

| | TrajCL | CLEAR | T-JEPA | HiT-JEPA |
|---|---|---|---|---|
| Porto | 0.468 | 0.178 | **0.509** | 0.490 |
| T-Drive | 0.218 | 0.163 | 0.229 | **0.258** |
| GeoLife | 0.475 | 0.320 | 0.516 | **0.549** |

Same shape: −3.7% on the dense in-distribution set, +12.6% and +6.4% where data is sparse or heterogeneous.

**The consolidated reading: a hierarchy is an out-of-distribution device.** Across three evaluation protocols the stack is neutral-to-negative where train and test distributions match and clearly positive wherever the test distribution shifts — sparser sampling, a different city, a different vehicle, a different spatial scale. **(brainstorm)** This is what the coarse-graining argument predicts and the wiki had no measurement of: the fine level's features are tied to the training distribution's sampling statistics, the coarse level's are not, so the top-down spotlight is a mechanism for having the *distribution-invariant* part of the representation choose what the *distribution-tied* part attends to. If that reading is right, the same construction should show up as robustness on any benchmark with a train/test regime gap, and should show up as *nothing* on in-distribution accuracy — which is precisely the axis the entire self-supervised comparison literature ranks methods on (cf. [[wiki/entities/dinov2.md]]'s term-vs-read-out decomposition).

---

## Ablation (Porto self-similarity)

| Variant | `\|D\|` 20% | `\|D\|` 100% | `ρ_s` 0.5 | `ρ_d` 0.5 |
|---|---|---|---|---|
| **HiT_emb** — cross-level path carries *upsampled embeddings*, concatenated | 106.568 | **497.064** | 2171.331 | 507.082 |
| **HiT_single_layer** — level 1 only (≈ T-JEPA) | 1.037 | 1.111 | 39.660 | 1.188 |
| **HiT_no_attn** — three independent JEPAs, no cross-level path | 1.032 | 1.085 | 31.058 | 1.122 |
| **HiT-JEPA** | 1.027 | 1.069 | 28.770 | 1.107 |

Two results, of very different sizes:

- **The stack itself is worth little; the coupling is worth a little more.** 1.111 → 1.085 → 1.069. Three siloed JEPAs beat one, and wiring them beats siloing them, but on Porto the whole hierarchy recovers ~4% of mean rank. The hierarchy's value is in the transfer table, not here.
- **Swapping the cross-level channel from attention maps to embeddings destroys the model** — 1.069 → 497.064, a factor of 465. The authors attribute it to representation collapse.

**The collapse row is the part that generalises beyond trajectories, and it needs one correction.** 497 out of `|D| = 100,000` is not chance (50,000), and the variant's mean rank scales almost exactly linearly with database size (106.6 / 209.7 / 297.9 / 394.1 / 497.1 for 20→100%) — the signature of a representation that places the true match at a fixed **percentile** (~0.5%) rather than at a fixed rank. So this is severe informational collapse with coarse discriminability surviving, not the constant-encoder limit. What matters for gap G34 is the *cause*: **the objective was unchanged.** SmoothL1 in representation space plus VICReg variance and covariance terms, at every level, in both variants. Only the wiring between levels changed, and collapse followed. A per-branch variance hinge certifies its own branch's embedding and says nothing about whether a *concatenated* representation assembled from two branches carries information — the top level's coarse features, replicated across `n/4 → n` positions by upsampling, are a low-rank block that the fine level can lean on to satisfy the regression while its own features go slack.

---

## Hyperparameters that report as findings

| Knob | Result |
|---|---|
| Transformer layers **per level** (1 / 2 / 3) | **1 is best** on every setting; the authors attribute 2–3 to overfitting. Depth is spent on the hierarchy rather than inside a level |
| Batch size (16 / 32 / 64 / 128) | flat 32–128, sharply worse at 16 — consistent with the VICReg terms being batch statistics |
| Spatial tokenisation | H3 hexagons (six equidistant neighbours) over the rectangular grids all three baselines use; resolution set per study-area size, which is what makes the 7-level shift to AIS possible at all |

---

## Comparison to the JEPA family in the wiki

| | HiT-JEPA | [[wiki/entities/i-jepa.md]] | [[wiki/entities/v-jepa-2.md]] | [[wiki/entities/h-jepa.md]] (proposed) |
|---|---|---|---|---|
| Levels | **3, trained jointly** | 1 | 1 | ≥2 |
| What varies across levels | sequence resolution (÷2) and width (×2) | — | — | **prediction horizon** |
| Cross-level channel | **attention maps, top-down, learnable scale `σ`** | — | — | representations, bottom-up + subgoal costs, top-down |
| Anti-collapse | EMA + VICReg var/cov **per level** | EMA + predictor asymmetry only | EMA + predictor asymmetry | four criteria, unimplemented |
| Actions / planning | none | none | CEM over action sequences | gradient descent on a learned cost |
| Scale | 1-layer transformers, `d=256`, 20 epochs, 200k trajectories, one A5000 | ViT-B→G, 1200 GPU-h | 1B params, >1M video-h | — |

---

## Limitations

- **Not a reasoning system.** Trajectory retrieval; no compositional, relational or out-of-domain reasoning evaluation exists for it.
- **The hierarchy has no horizon differential**, so it does not test the argument that motivates a stack (long-range prediction *forces* abstraction). It tests only that multi-resolution encoders help.
- **Three levels, fixed, chosen.** Depth is a hyperparameter; nothing selects it, and there is no result on 2 or 4 levels.
- **Top-down only.** No level-1 → level-2 refinement path, so the coarse encoder never learns from the fine encoder's failures — the authors' Fig. 2 caption states propagation is top-to-bottom.
- **The `(λ, μ, ν) = (0.05, 0.15, 0.8)` weighting is unablated** despite being the most surprising number in the paper.
- **Collapse claim is asserted, not diagnosed** — no rank, variance or cosine-similarity measurement of the HiT_emb representation, only the mean-rank degradation.
- Interaction is Transformer-specific by construction (it propagates attention matrices); the authors name generalising it to CNN/Mamba/LSTM stacks as future work.

---

## Connections

- **[[wiki/entities/vl-jepa.md]]** — supplies the horizon differential this page could not: two prediction granularities at four anticipation times with the encoder held fixed, the coarser one winning from ~4 s out — but across two systems rather than two levels of one stack, so the argument for stacking gains a curve and still no in-stack test.
- **[[wiki/entities/h-jepa.md]]** — the first trained instance of the design's defining and least-evidenced component, and a narrowing of what that page's "no demonstration that a stack can be trained at all" concedes: the stack trains, jointly, on one GPU — but the level axis is sequence resolution rather than prediction horizon, there are no actions and no cost, and on in-distribution accuracy the stack is worth ~4%, with the entire payoff appearing under distribution shift.
- **[[wiki/entities/i-jepa.md]]** — the masking design copied wholesale (context deleted where targets overlap, `M` targets, mask tokens carrying target positional embeddings) and one addition its sampler lacks: a 50/50 mix of *successive* and *scattered* masks, whose stated purpose — forcing local and long-range dependence from the same encoder — is the same lever T167 prices at 15.5 → 54.2 on images.
- **[[wiki/entities/vicreg.md]]** — used as an auxiliary per-level regulariser on top of an EMA JEPA rather than as a standalone objective, and the source of a sharper limit than that page's coefficient-space result: the same variance and covariance terms, on the same branches, at the same weights, sit and watch while a change to the *inter-level wiring* costs a factor of 465 — so per-branch certification does not extend to a representation assembled across branches.
- **[[wiki/entities/v-jepa-2.md]]** — the complementary halves of [[wiki/entities/h-jepa.md]]: that page builds one level at 1B parameters, drives a robot, and reports autoregressive error accumulation as its limitation; this one builds three levels at toy scale with no actions, and shows the stack paying off exactly where the distribution shifts.
- **[[wiki/concepts/attention.md]]** — a top-down attention mechanism that is *learned end-to-end and sourced from a coarser copy of the same input*, not from a task specification: the coarse level's `softmax(QKᵀ/√d_k)` is deconvolved to the fine level's length and added with a learnable scale, which is the "goal-driven control of the spotlight" [[wiki/entities/h-jepa.md]]'s configurator leaves unspecified, minus the goal.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the contrast that isolates what a resolution hierarchy is not: levels here are fixed ÷2 poolings with no termination condition, no variable-length commitment and no horizon differential, so the abstraction is *spatial coarse-graining of a sequence* rather than temporal chunking of a policy.
- **[[wiki/concepts/event-segmentation.md]]** — the rival coarse-graining: max-pooling by a fixed factor of 2 places boundaries on a grid regardless of content, where a boundary detector places them at prediction-error peaks; HiT-JEPA is the cheap end of that trade and its robustness to irregular sampling (T-Drive, 3.1-min intervals) is the evidence that content-blind pooling is not fatal.
- **[[wiki/concepts/population-geometry.md]]** — the collapse row read geometrically: rank scaling linearly with database size is a representation preserving coarse neighbourhood structure while losing within-neighbourhood ordering, which is a *partial* dimensional collapse and is not what a constant-encoder diagnostic would catch.
- **[[wiki/concepts/cognitive-map.md]]** — the input tokenisation is a hexagonal tiling with node2vec-learned neighbour embeddings, i.e. a hand-supplied place-cell-like basis over space, and the resolution parameter is what lets the same trained model move from city blocks to ocean basins — the transfer result depends on the metric structure being in the tokeniser rather than in the encoder.
- **[[wiki/entities/lejepa.md]]** — the strongest per-branch anti-collapse provision available, and it would not have caught this page's failure either: SIGReg constrains each branch's *marginal distribution*, and the factor-465 collapse came from a representation assembled across levels that is nobody's argument.
