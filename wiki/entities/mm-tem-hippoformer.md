# mm-TEM and Hippoformer

**The third rewrite of [[wiki/entities/tolman-eichenbaum-machine.md]]'s relational memory: replace the Hebbian outer product (TEM) and the key/value cache ([[wiki/entities/tem-transformer.md]]) with a small MLP whose *fast weights* are updated online by gradient descent on a surprise-gated reconstruction loss — then bolt a 32-step transformer alongside it and let the two split the work by horizon.**

> **Provenance.** Li, Cao, Wang, Yang, Zou & Hong 2026, *Hippoformer: Integrating Hippocampus-inspired Spatial Memory with Transformers*, ICLR 2026 (`raw/li-2026-hippoformer-spatial-memory-transformer.md`). Two models: **mm-TEM** (meta-MLP TEM) and **Hippoformer** (mm-TEM ∥ transformer). The relational-memory machinery is Titans' (Behrouz et al. 2024) fast-weight MLP dropped into TEM's `g`/`x` slot.

---

## Architecture

| Component | mm-TEM | Wiki role |
|---|---|---|
| **Structural code `g`** | Two-layer ReLU MLP `f_g` maps the one-hot action `a_t` to a **transformation matrix** `W_t^g ∈ R^{d_g×d_g}`; `g_t = ℓ2-normalise(W_t^g g_{t-1})` | [[wiki/concepts/path-integration.md]] — an action-*generated* operator rather than one weight matrix per action |
| **Sensory code `x`** | 2-layer MLP encoder (2D) or 4-layer CNN + MLP (3D) | Node content |
| **Binding `p`** | `m_t = [g_t, x_t]` projected to `k_t, v_t, q_t`; a **3-layer MLP with fast weights `Θ_t`** learns `k_t ↦ v_t` online. Read is `f_MLP(q_t; Θ_t)`, interpreted as a joint reconstruction `m̂_t = [ĝ_t; x̂_t]` | Instance-graph as a *function* rather than a matrix or a cache |
| **Write rule** | `Θ_{t+1} ← α_t Θ_t − β_t · (momentum over ∇_Θ L(f_MLP(k_t;Θ_t), v_t))`, with `α_t = σ(W_α m_t)` (forget), `η_t = σ(W_η m_t)` (momentum), `β_t = σ(W_β m_t)` (rate) — all three gates are **data-dependent** | Only prediction error drives writes; forgetting is learned, not decayed on a clock |
| **Error correction** | `g_inf,t = g_gen,t + α(ĝ_gen,t − g_gen,t)·f_delta(g_gen,t, ĝ_gen,t, sg‖x_t − x̂_t‖²)` — the memory's structural read corrects the integrator, gated by how well its sensory read matched | Anchoring implemented as recall (G39), with the gate keyed on sensory reconstruction error |
| **Training** | Outer loop (Adam, BPTT) learns `W_k, W_v, W_q`, `f_g`, encoders; inner loop updates `Θ` — **and keeps updating it at test time** | [[wiki/concepts/meta-learning.md]] with an inner loop that is a *gradient step*, not a Hebbian write |

Loss: `L = γ_rel L_rel + γ_gen L_gen + γ_con L_con + γ_inf L_inf` — next-observation prediction from the path-integrated code, prediction from the corrected code, integrator/memory consistency, plus the relational term below.

### The relational loss is the whole trick

TEM injects the relational prior *architecturally* (a tensor product); TEM-t injects it as key/value structure. mm-TEM injects **no prior at all** and instead trains the memory with three retrieval directions:

| Term | Query | Target | Meaning |
|---|---|---|---|
| `L_x2g` | `[0, x_t]` | `g_t` | "where have I seen this" — content-addressed localisation |
| `L_g2g` | `[g_t, 0]` | `g_t` | autoassociative clean-up of the address itself |
| `L_g2x` | `[g_t, 0]` | `x_t` | "what is here" — the generative prediction, absorbed into `L_gen` |

So `L_rel = L_x2g + L_g2g`. **Ablation:** removing either term "significantly reduces" generalization; removing both degrades severely. Adding a fourth (`L_x2x`) was tested and is not kept.

**(brainstorm)** This is the wiki's first case where bidirectional retrieval is *supervised as an objective* rather than obtained for free from the algebra of an outer product. It is a candidate deposit into the empty objective slot (G30): if `g` must be recoverable from `x` and from itself through the same store, the store is being pushed toward exactly the distinctness and path-invariance properties [[wiki/concepts/abstract-structural-codes.md]] derives from the address role — but as a loss term rather than as a consequence of the memory's form.

---

## Hippoformer

One-layer transformer with a **32-step window**, run in *parallel* with mm-TEM (`m_b = 8`); outputs combined and decoded. Nothing more elaborate — the authors call it "a straightforward parallelization" and flag it as the paper's weakest part.

| Module | What it holds | Evidence |
|---|---|---|
| Transformer | Precise short-range working memory | Best 1-step error; mm-TEM alone is *worse* than a transformer at 1 step in 3D (5.10 vs 1.29 ×10⁻³) |
| mm-TEM | Structural long-horizon abstraction | Best multi-step error alone (14.30 vs 33–36 ×10⁻³); the transformer's error oscillates and stacks after ~36–56 steps |
| Both | Wins at both ends | 1-step 1.27, multi-step **9.71** ×10⁻³ — below either component |

---

## Results

| Result | Number |
|---|---|
| **Training efficiency vs TEM** | ~90% test accuracy in 5,000 gradient steps; TEM ≈60% after 20,000. Faster than TEM-t in both gradient steps and wall-clock (TEM-t itself faster than TEM) |
| **Long-context generalization** | Trained at 128 steps; retains ≈40% 1-step accuracy at **4,096-step** contexts where transformer (windows 64/128) and Titans collapse |
| **Multi-step imagination** | Fixed 64-step context, then act blind. Transformer/Titans near-perfect inside the training horizon and falling off a cliff outside it; mm-TEM degrades slowly |
| **Direction transfer** | 11×11 circular grid explored clockwise, then imagined counter-clockwise: mm-TEM >90%, baselines drop up to 30 points |
| **Environment-size transfer** | 7×7 → 15×15 with no retraining: all decline, mm-TEM most slowly |
| **Grid-like codes emerge** | Periodic autocorrelation in the path-integration units, from next-observation prediction only |
| **Grid scale ← `m_b`** | Larger memory-update interval `m_b` (= longer effective prediction horizon) ⇒ **coarser** grids; smaller `m_b` ⇒ finer |
| **Grid score predicts generalization** | Multi-step accuracy at imagination length 512 vs grid score: Pearson `r = 0.647, p = 2e-4`; Spearman `ρ = 0.7833, p = 1e-6` |
| **Parameter counts** | mm-TEM 9.11M, Hippoformer 10.06M vs Transformer 29.63M, Titans 30.62M — the gains are not size |
| **3D (MemoryMaze3D)** | Egocentric pixels, continuous noisy actions; see the Hippoformer table above |

### The two controls that matter

| Control | Finding | Consequence |
|---|---|---|
| **Positional-encoding baselines** | Transformer/Titans with sinusoidal, rotary, or **dynamic PE (mm-TEM's own path-integration module used as a positional encoder)**. Rotary and dynamic close the gap at 1-step, sometimes matching mm-TEM(`m_b`=1) — and *none* approach it on multi-step prediction or circular-grid transfer | A path-integrated position code is **not** the active ingredient. What the baselines lack is the relational memory with its bidirectional losses and the feedback error-correction loop. This is the sharpest dissociation in the wiki between "having a structural code" and "having the memory that makes it pay" |
| **Truncated vs full BPTT** | At 512-step training, Hippoformer with BPTT truncated at 256 beats a transformer with full 512-step BPTT | Long-range dependency is bought by the architectural prior, not by the length of the unrolled credit-assignment window — the same point TEM 2018 made with a 25-step truncation and 400-step retrieval |

### The grid-scale claim, and its own control

The headline mechanistic proposal: **grid-scale diversity is multi-timescale prediction at the implementation level.** The memory is updated only every `m_b` steps, so between updates the model must predict 1…`m_b` steps ahead with no access to intervening `(g, s)` pairs; larger `m_b` = longer horizon = coarser grid. Unlike Stachenfeld et al. 2017 and Dordek et al. 2016 (grids as basis functions of a *pre-supplied* multiscale place code), nothing multiscale is imposed — the scale falls out of one integer hyperparameter, end to end. Biological handle offered: dorsal–ventral gradients in oscillation frequency (Goyal et al. 2020) and receptor expression (Strange et al. 2014).

**But the effect is a training-time effect only.** Train at `m_b = 1` and *test* at `m_b = 8` — for memory updates alone, or for memory updates and error-correction feedback together — and the grid scale is unchanged. The authors' explanation: scale is fixed by the action→`g` mapping learned in `f_g` and by the stored `g`–`x` pairings, neither of which `m_b` touches at test time. So the horizon shapes the code *while the operator is being learned*; it is not a runtime knob on an existing code. This matters for the biological reading, which would need the gradient to be developmental rather than dynamic.

### Grid quality vs performance: correlational, and with a live counterexample

Higher grid score → better long-horizon accuracy, at `ρ = 0.78`. But the paper also reports models with **low grid scores and high accuracy**, whose autocorrelation maps show "alternative" (non-hexagonal) solutions — the sentence describing them is cut off by a page break in this conversion. Read straight: a periodic `g` is *sufficient but not necessary* for the long-horizon transfer, and the correlation is over seeds/hyperparameters with no intervention on the code itself ([[wiki/empirical-tensions.md]] T44).

---

## What this changes for the wiki

| Claim | Effect |
|---|---|
| **The fast store can be a function, not a table** | TEM stores `M = Σ p_τᵀp_τ` (capacity-limited outer products), TEM-t stores a growing cache (context-window-limited). mm-TEM stores *weights of a 3-layer MLP*, size fixed, written by gradient descent on surprise. This is the first fast **M** in the wiki with a **learned forgetting gate** rather than a decay constant or a novelty check |
| **Surprise-gated writing is now implemented twice** | TEM-t writes only conjunctions not already stored (a dot-product check); mm-TEM writes in proportion to `∇_Θ L` — the same policy expressed as a magnitude rather than a boolean, with the momentum term averaging surprise over a tunable window |
| **Structural memory and attention are complements, not rivals** | The equivalence result ([[wiki/entities/tem-transformer.md]]) says TEM *is* a transformer; this paper's empirical result says a bounded-window transformer and a structural memory divide labour cleanly by horizon and beat either alone. Both can be true: the equivalence is about one attention step, the division of labour is about what a *finite* window plus a *persistent* structural code each buy |
| **A negative result on positional encoding** | Giving a transformer a path-integrating position code (dynamic PE) buys short-range accuracy and no structural transfer — which is a direct empirical qualifier on TEM-t's "position encodings should carry the task's structure" proposal |

---

## Limitations

| Limit | Consequence |
|---|---|
| **Hippoformer is a parallel concatenation** | Single layer, no interaction between the two memories beyond the shared decoder; the authors state this and name multi-layer scaling as future work. No scaling curve is run |
| **Same task envelope as TEM** | 2D: 64 i.i.d. sensory objects on an 11×11 grid, allocentric actions supplied and labelled — hardness source 2 untouched, sensory correlation between adjacent nodes deliberately absent. 3D adds egocentric pixels and continuous noisy actions, which is a genuine widening, but the layout is an empty plane with random textures |
| **Generalization is over edges, not states** | The paper says so: unvisited states are unpredictable by construction in the 2D setting, so "generalization" means unseen *transitions* between visited nodes |
| **The grid emergence audit is partial** | Grid scores are reported as a distribution over seeds and correlated with accuracy (better than most), and the `m_b` train/test control is run — but module structure is absent (one scale per `m_b`), adjacent-scale ratios are not reported, and no filtered-noise control appears ([[wiki/concepts/objective-identifiability.md]]) |
| **No capacity result** | The fast weights `Θ` are a fixed-size MLP with a learned forget gate, so the store *must* have a capacity and a forgetting regime — neither is characterised, measured, or plotted (gap G42) |
| **Comparison against TEM is the authors' own re-run** | As with TEM-t's speed claim, the direction is credible and the factor is not audited |
| **No biological validation** | Unlike TEM and spiking-TEM, no recorded data are re-analysed; the dorsal–ventral proposal is offered as an interpretation, not tested |

**Hardness-source coverage** ([[wiki/concepts/latent-graph-discovery.md]]): source 1 ✓ · source 3 ✓ · source 4 ✓ · sources 2, 5, 6 ✗ — inherited unchanged from TEM.

---

## Connections

- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the same `p = f(g, x)` factorisation with the Hebbian tensor-product store replaced by a meta-learned MLP whose fast weights are written by surprise-gated gradient descent: it removes the outer-product capacity cost and the hand-designed memory-management heuristics, reaches ~90% accuracy in 5k gradient steps against TEM's ~60% in 20k, and pays for it by *supervising* the bidirectional retrieval that TEM's algebra provided for free.
- **[[wiki/entities/tem-transformer.md]]** — the other rewrite of the same store, and its empirical counterweight: where that page derives the equivalence between the Hebbian read and one attention step, this one measures what a bounded transformer window and a persistent structural memory each contribute, finds them complementary by horizon (transformer ≤32 steps, mm-TEM to 4,096), and rules out the cheap version of the equivalence's proposal by showing that giving a transformer a path-integrating position encoding improves one-step accuracy without producing any structural transfer.
- **[[wiki/concepts/path-integration.md]]** — supplies this model's `g`, and receives from it a determinant of the code's *scale*: the memory-update interval `m_b` sets the effective prediction horizon, and the horizon sets grid period — plus the finding that grid score predicts long-horizon accuracy (ρ = 0.78) while some low-grid models match it anyway.
- **[[wiki/concepts/abstract-structural-codes.md]]** — makes that page's "abstraction level = prediction horizon" claim quantitative in the structural code itself: one integer controlling how far ahead the model must predict controls how coarse the emergent periodic code is, with no multiscale place basis supplied.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — the fast store as a meta-learned plasticity rule: the outer loop learns the projections and the gate networks, the inner loop is online gradient descent on a reconstruction loss with data-dependent forgetting, momentum and learning rate — the wiki's clearest instance of activations-as-weights in a *relational* memory rather than a generic one.
- **[[wiki/concepts/working-memory.md]]** — a division of labour by horizon rather than by store type: a 32-step attention window for precise recent content, a fixed-size fast-weight memory keyed by a path-integrated address for everything older, and empirically each fails where the other works.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the meta/instance split with a third implementation of the instance level: slow weights hold the transition operator generator, the MLP's fast weights hold this environment's `g`–`x` bindings, and the write is a gradient step on surprise rather than a Hebbian outer product or a cache append.
- **[[wiki/entities/vector-hash.md]]** — the opposite bet on the same store: freeze `g` and the grid↔hippocampal weights to get exponential capacity with no learning, versus learn everything including the memory's own update rule and report no capacity result at all — so between them the wiki has a capacity model with no learning and a learning model with no capacity model (gap G42).
- **[[wiki/entities/spiking-tem.md]]** — the other 2025–26 rewrite of TEM, moving in the opposite direction: down to leaky integrate-and-fire units and biological plasticity, where this one moves up to fast-weight MLPs and pixel inputs — and the two disagree about what the conjunction is for, since spiking-TEM must *delete* `g̃ ⊙ x̃` to keep its grid code while mm-TEM never forms an explicit conjunction at all, binding by concatenation into a learned MLP instead.
- **[[wiki/concepts/objective-identifiability.md]]** — a further one-hot-target emergence case against the centre–surround-readout account of grid formation, and the first to run the train-time/test-time control on the hyperparameter it claims sets the scale.
- **[[wiki/concepts/attention.md]]** — the complement measured rather than derived: self-attention over a finite window is the precise short-range read, and it degrades to memorisation exactly where a structural address keeps working.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the same "two access disciplines beat one" result obtained inside a single memory matrix: each read head mixes a content address with forward/backward write-order addresses, so the short-precise / long-structural split this page buys with two memories is there a learned read-mode vector.
- **[[wiki/entities/spiking-hippocampal-cam.md]]** — the wiki's other bidirectionally-addressable store, reached by the expensive route: two physical STDP matrices wired in opposite directions plus a two-interneuron arbiter to stop them corrupting each other, against this page's auxiliary supervised losses on a single memory — bidirectionality as wiring versus bidirectionality as an objective, with the wiring version needing no outer loop and no gradient.
- **[[wiki/concepts/fast-weight-programming.md]]** — the linear rival to this model's choice: the delta rule is one closed-form gradient step on a *linear* reconstruction loss, so it keeps a capacity result (`d_dot`) and a single read per write, where this model's nonlinear MLP fast weights buy expressivity and give up any capacity statement at all (gap G42) — the same design decision taken opposite ways (Schlag et al. 2021).
