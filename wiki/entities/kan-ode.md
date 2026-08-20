# KAN-ODE (Kolmogorov-Arnold Network Ordinary Differential Equations)

**A continuous-time dynamics model in which the gradient-getter of a Neural ODE is a KAN (Kolmogorov-Arnold Network) rather than an MLP (Multi-Layer Perceptron), so the learned transition function is a sum of *individually plottable univariate activations* that optional symbolic regression can convert into a closed-form equation.**

> **Provenance.** Koenig, Kim & Deng 2024, *KAN-ODEs: Kolmogorov-Arnold Network Ordinary Differential Equations for Learning Dynamical Systems and Hidden Physics* (`raw/koenig-2024-kan-odes-dynamical-systems.md`), arXiv:2407.04192v1, MIT Mechanical Engineering. Three test cases, all **synthetic data from known equations**: Lotka-Volterra ODE, Fisher-KPP PDE, Burgers' equation. No real measurements, no partial observability, no actions, no benchmark against SINDy or PINN despite both being the stated comparison class.

Why the wiki holds a page on a scientific-machine-learning paper: it is the only entry so far in which a learned transition function is **read out as an equation rather than probed for one**, which is the readout half of gaps G8 and G11 and the only concrete route to the *verifiability* problem that [[wiki/concepts/learned-world-models.md]] leaves open.

---

## Architecture

| Component | Form | Note |
|---|---|---|
| Representation theorem | Kolmogorov-Arnold: `f(x) = Σ_{q=1}^{2n+1} Φ_q( Σ_{p=1}^{n} φ_{q,p}(x_p) )` | Replaces the universal approximation theorem that licenses MLPs. Learn the *activations* `φ`; the weights merely sum them |
| Deep form | `y = KAN(x) = (Φ_{L-1} ∘ … ∘ Φ_0)(x)`, each `Φ_l` a matrix of univariate `φ_{l,α,β}` | Layer notation `[n_l, n_{l+1}, N]` — in, out, grid size |
| Basis (this paper) | Gaussian RBF, `φ = Σ_i w^r_i ψ(‖x − c_i‖) + w^b b(x)`, `ψ(r) = exp(−r²/2h²)` | Liu et al.'s original B-splines swapped for RBFs for speed (Li 2024); inputs `tanh`-squashed to `[−1,1]` so the grid never needs re-fitting |
| Residual path | Swish `b(x) = x·sigmoid(x)` in parallel with the gridded path | Two pathways per layer: gridded (params = in × grid × out) and non-gridded (in × out) |
| Dynamics | `du/dt = KAN(u(t), θ)`, integrated `u(t) = u₀ + ∫ KAN(u(τ),θ) dτ` | KAN in-dim = out-dim = state dim. Tsit5 integrator, ADAM, Julia (`DifferentialEquations.jl`, `Lux.jl`) |
| Loss | `L(θ) = MSE(u^KAN(t,θ), u^obs(t))` | Trajectory-level, not one-step |
| Credit assignment | Adjoint sensitivity through the solver | Chosen over forward sensitivity for scaling in `\|θ\|` |

The consequence that matters architecturally: **the state variables are the interface**. A KAN-ODE's input and output dimensions are pinned to the dimension of `u`, so the model can only be interpretable to the extent that someone has already decided what the state coordinates are. Nothing in the method discovers them.

---

## Results

### Lotka-Volterra — the head-to-head against a Neural ODE

Same data, same solver, same windows; MLP architecture and training taken from a prior Neural ODE paper to avoid tuning the baseline down. Train on `t ∈ [0, 3.5]`, extrapolate to `t ∈ [3.5, 14]` **from the initial condition alone**.

| Model | Params | Train loss @ 10⁵ epochs | Test loss, epochs 90–100k (mean / min) | CPU-min per 10⁴ epochs |
|---|---|---|---|---|
| Neural ODE (MLP, depth 2, width 50) | 252 | `3×10⁻⁵` | `1.4×10⁻²` / `5.4×10⁻⁵` | ~7 |
| **KAN-ODE** `[2,10,5],[10,2,5]` | **240** | **`8.3×10⁻⁷`** | **`6.8×10⁻³`** / **`1.9×10⁻⁵`** | ~20 |

- KAN-ODE reaches the MLP's *final* accuracy in **10⁴ epochs**, i.e. the MLP's 3× faster iteration is more than repaid.
- **Scaling exponent is the real claim.** Across model sizes, KAN-ODE tracks `N⁻⁴` error-vs-parameters; MLP Neural ODEs at depth 2 and depth 3 track `N⁻²` or worse. The KAN-ODE *saturates* its fourth-order regime at 240 parameters (480 and 960 buy `6.6×10⁻⁷` and `6.1×10⁻⁷` — nothing), while the authors estimate an MLP would need `10³–10⁴` parameters for parity if it does not plateau first.
- **The wrinkle the paper reports against itself:** the KAN-ODE's test loss visibly diverges from train loss in late epochs — it overfits *more* than the MLP qualitatively — and still wins on test loss quantitatively. Both models are best stopped at ~2×10⁴ epochs. So the scaling advantage is an advantage in the *approximation* term, and the generalisation term is untouched by it.
- Non-monotonicity worth noting: at fixed width 4, grid 3 → 4 → 5 gives `1.4×10⁻⁴ → 5.2×10⁻⁵ → 1.2×10⁻⁴`. Grid size is not a monotone capacity knob.

### Fisher-KPP — hidden-physics inference, and the only symbolic extraction

Ground truth `∂u/∂t = D ∂²u/∂x² + r·u(1−u)`. The diffusion term is **given**; only the reaction term is learned:

```
∂u/∂t = D ∂²u/∂x²  +  KAN(u, θ)          # KAN shape [1,1,5] — one node, five basis functions
```

Converges in ~5,000 updates. Symbolic regression (`SymbolicRegression.jl`, operators `[+,−,×,÷,sin,cos,exp]`) on that single learned activation returns

```
KAN(u) = 0.995311·u·(1.002448 − u)        vs. truth  r·u(1−u),  r = 1.0
```

— coefficients recovered to ~0.5% and 0.2%. This is the paper's load-bearing demonstration, and its conditions are strict: **one input, one output, one node, one term, the rest of the PDE supplied.** The symbolic step ran on a scalar function of a scalar, which is a curve fit; nothing here shows symbolic extraction surviving a multivariate `Φ` composition.

### Burgers' equation — grid-free interpolation

`[51,10,5],[10,51,5]` KAN-ODE learns the full spatiotemporal operator from **five snapshots** (`t ∈ {0.1,…,0.9}`), then predicts the withheld times `t ∈ {0.2,…,1.0}` including near the shock, where training sampling is sparsest. The 10-node bottleneck between 51-dim in and out is the only latent compression in the paper, and it is not analysed.

---

## What this contributes to a reasoning model

**1. A third position on the interpretability/prior-knowledge trade.** The paper's own framing (its Fig. 1) puts methods on a diagonal — more prior knowledge in, more interpretability out — and claims KAN-ODEs sit *below* it.

| Method | Prior knowledge required | Interpretability | Failure |
|---|---|---|---|
| Neural ODE (MLP) | none | none — 10³–10⁶ opaque parameters | uninspectable |
| PINN / CRNN | the governing equations | high, by construction | needs the answer to ask the question |
| SINDy | a candidate function library | high, within the library | a dynamic outside the library is unrepresentable |
| **KAN-ODE** | **none at training time** | **optional, post hoc** | interpretability is *discretionary and unvalidated* — nothing certifies that the symbolic fit is the function the model actually uses |

The transferable move is **making the symbolic commitment a postprocessing step rather than a training constraint**. SINDy must name the hypothesis class before it sees data; the KAN-ODE trains as a black box and *may* be symbolised afterwards, so a dynamic outside any candidate library still gets fitted — it just stays a plot instead of an equation. **(brainstorm)** For the wiki this is the right default polarity for the non-embeddable slice of gap G11: keep the continuous learner, attach a *lossy* symbolic decoder, and treat successful symbolisation as a signal about the environment (this subsystem is rule-shaped) rather than as a requirement on the learner. The wiki has no mechanism that decides *which* parts of a model to attempt symbolisation on — that is the missing controller, and it is the same shape as G12's routing policy.

**2. The grey-box composition is a working instance of a wiki gap.** `∂u/∂t = D∂²u/∂x² + KAN(u,θ)` composes a hand-written module with a learned one inside a single differentiable objective, and the learned module is *forced* to be the residual because the known term is already accounted for. Gap **G21** (nothing composes the outputs of two specialized modules) is answered here in the easiest possible case — the composition operator is addition, and it is written by hand. But note what the arrangement buys: the residual slot is what makes the learned part small enough (`[1,1,5]`, five parameters of real content) to be symbolised at all. **Interpretability came from the factorisation, not from the KAN.**

**3. Parameter count as an explicit target.** `N⁻⁴` vs `N⁻²` is a statement about `C(S)` in [[wiki/concepts/intelligence-density.md]]'s ratio: the same `log₂N(S)` at roughly a square-root of the description length, in the regime where both are far from saturation. This is the second measured cut to `C` in the wiki after [[wiki/entities/dendritic-ann.md]], and it comes from a different place — the basis functions are learned per-edge rather than shared per-node, which is a *reallocation* of parameters, not a sparsification.

**4. Continuous time is the underused property.** Every transition model in [[wiki/concepts/learned-world-models.md]]'s trichotomy is a discrete-step map `z' = f(z,a)`. A KAN-ODE emits `dz/dt`, so it is grid-agnostic by construction: train on one temporal sampling, query at any other, take large steps where the gradient landscape is flat. **(brainstorm)** Two things follow that the paper does not say. (a) An adaptive solver's own step-size controller is a free, unsupervised **event segmentation** signal — step size collapses exactly where the dynamics change fast, which is where [[wiki/concepts/event-segmentation.md]] wants a boundary, and it costs nothing because the integrator computes it anyway. (b) *Jumpy prediction*, which [[wiki/entities/h-jepa.md]] wants from a hierarchy of trained encoders, is available in a flat continuous model as a solver tolerance setting — a different and much cheaper answer to temporal abstraction than stacking predictors.

---

## Limitations, as they bear on this wiki

| Limitation | Consequence |
|---|---|
| **State variables are given** | The input/output dimensions *are* the physical state. This supplies nothing for G27 (discretisation) or G4 (vocabulary co-discovery); it presupposes both. Contrast [[wiki/concepts/affordance-grounded-symbols.md]], where the carving is the output |
| **Fully observed, noiseless, synthetic** | All three cases integrate a known equation to make the data. No partial observability, no measurement noise, no distribution shift |
| **No actions** | `du/dt = KAN(u)` is autonomous. Every question about intervention, counterfactuals and behaviour-policy contamination ([[wiki/concepts/learned-world-models.md]], `ρ_tr`) is outside the setting |
| **Symbolic extraction demonstrated on `[1,1,5]` only** | Scaling the readout to a composed multivariate KAN is asserted as plausible ("we hypothesize this could be sparsified") and not shown |
| **No fidelity check on the symbolic form** | The extracted equation is compared to the *ground truth*, never re-integrated and scored against the KAN it replaced. Whether symbolisation preserves the model's dynamics is untested — the same decoded-but-unused problem [[wiki/concepts/representation-probing.md]] raises for probes, one level up |
| **Selected by MSE only** | Every architectural choice is made on training loss. Gap **G62** / tension **T144** apply unchanged: nothing here scores the model by what could be done with it |
| **Stated rivals never run** | SINDy and PINN are the paper's positioning targets and neither is benchmarked. Only the MLP Neural ODE is |
| **Cost** | 3× slower per epoch, 20 CPU-min per 10⁴ epochs on a 240-parameter model. Repaid here by faster convergence; unverified at scale |

---

## Comparison to related models

| | KAN-ODE | Neural ODE (MLP) | SINDy | RSSM / Dreamer | [[wiki/entities/h-jepa.md]] |
|---|---|---|---|---|---|
| Time | continuous | continuous | continuous | discrete steps | discrete steps |
| What is learned | per-edge univariate basis functions | node weights, fixed activations | coefficients over a fixed library | latent transition + decoder | latent predictor |
| Prior needed | none | none | candidate function set | none | none |
| Readable as an equation | **yes, post hoc** | no | yes, by construction | no | no |
| Stochastic futures | no | no | no | yes | no |
| Actions | absent | optional | optional | central | central |
| Observation model | identity (state given) | identity | identity | learned decoder | none (embedding space) |

---

## Connections

- **[[wiki/concepts/learned-world-models.md]]** — supplies the transition family that page's trichotomy omits: a continuous-time deterministic `dz/dt` that is grid-agnostic and, uniquely, convertible into a closed-form equation, which is the only concrete attack the wiki holds on that page's *verifiability* open problem — bought by assuming the state variables, no actions and no partial observability, i.e. exactly the conditions that page's other entries are built for.
- **[[wiki/concepts/intelligence-density.md]]** — a measured cut to `C(S)`: `N⁻⁴` error-vs-parameter scaling against an MLP's `N⁻²` means matching accuracy at roughly the square root of the description length, and it saturates (240 → 960 parameters buys nothing), which is the shape `ℐ` predicts for a system that has captured the structure rather than memorised the trajectory.
- **[[wiki/concepts/representation-probing.md]]** — the limiting case of that page's instruments: where a probe fits a weak decoder to *activations*, symbolic regression fits a closed form to the learned *function*, so the structure is read off the parameters with no decoder capacity to be won by — and it inherits the page's central caveat in a new form, since the extracted equation is never re-integrated to check that it reproduces the model it came from.
- **[[wiki/empirical-tensions.md]]** — opens **T147** (*does making a learned model inspectable require a discrete bottleneck?*): this page is position B, the claim that putting the learnable parameters in the functional form makes a model readable with the state left continuous and no quantisation anywhere.
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the complementary half of the same ambition: that page discovers *what the symbols are* from action consequences but gets its transition rules by distilling a decoder into PDDL; this one gets an exact continuous transition law but must be handed the state variables, so the two fail on disjoint halves of G27 + G8.
- **[[wiki/concepts/causal-model-building.md]]** — the grey-box slot (`known operator + KAN residual`) is model-building with the known part frozen, which is why the learned part is small enough to interpret; it is also the setting's boundary, since an autonomous ODE with no action input cannot answer an interventional query at all.
- **[[wiki/concepts/event-segmentation.md]]** — **(brainstorm)** an adaptive ODE solver's step-size controller is a free segmentation signal: step size collapses where the dynamics change fastest, which is that page's boundary criterion computed as a by-product of integration rather than from a separate prediction-error monitor.
- **[[wiki/entities/dendritic-ann.md]]** — the other measured parameter-count cut in the wiki, and the contrast that matters: that one *removes* connections via fixed masks, this one *reallocates* the same budget from node weights into per-edge learned basis functions, so the two savings compose in principle and have never been tried together.
- **[[wiki/entities/h-jepa.md]]** — a cheaper route to that design's jumpy prediction: continuous-time dynamics make temporal abstraction a solver-tolerance setting rather than a stack of separately trained encoders — at the cost of the JEPA property that motivates the stack, since a KAN-ODE predicts the state it was given rather than an abstraction it chose.
- **[[wiki/concepts/compositionality.md]]** — the Kolmogorov-Arnold theorem is a compositional claim about function space (every multivariate continuous function is a finite composition of univariate ones), and this paper is the wiki's clearest case of that decomposition being *usable*: the univariate factors are individually plottable, which is what makes any of the interpretability above possible.
- **[[wiki/entities/simple-cycle-reservoir.md]]** — the opposite end of the fixed-vs-learned-dynamics axis: KAN-ODE learns a transition function and then *reads* it symbolically, while SCR fixes the transition to a rotation with one parameter and proves a continuous readout absorbs whatever the dynamics were — so interpretability of the state update and expressivity of the system are decoupled, and a readable `f` is a choice rather than a requirement.
- **[[wiki/entities/ltc.md]]** — the wiki's other continuous-time model and the complementary bet: KAN-ODE makes the *functional form* of the vector field learnable so it can be read as an equation, LTC keeps the state update deliberately linear and makes the *decay rate* a learned function of the input; both then run into the same fact from opposite sides — in a continuous-time network the solver's step count, not depth, is the compute axis (LTC measures it: 0.61 steps for a Neural ODE against 81.01 for an LTC on the same input), which is this page's free segmentation signal seen as a cost rather than a cue.
