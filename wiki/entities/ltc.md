# LTC (Liquid Time-Constant Network)

**A continuous-time recurrent network whose state update is a *linear* first-order ODE whose decay rate is itself computed by a neural network from the current state and input — so every unit's memory horizon `τ_sys` is re-set at every instant by what it is currently seeing, and the nonlinearity that drives the state is the same one that sets how fast the state forgets.**

> **Provenance.** Hasani, Lechner, Amini, Rus & Grosu 2021, *Liquid Time-Constant Networks*, AAAI-21 pp. 7657–7666 (`raw/hasani-2021-liquid-time-constant-networks.md`). Bundled with an aggregator survey of the LTC line — CfC, Liquid-S4, LGTC, LTC-SE, NCP-on-Loihi (`raw/emergentmind-2026-liquid-time-constant-networks.md`), whose claims are marked `(tentative)` below: it is a topic page, not a peer-reviewed source, and its LaTeX rendering is broken in a way that **destroyed several of its numbers** (speed-up factors, accuracy deltas, the stated bounds) — those figures are unrecoverable from the file and are not reproduced here.

Why the wiki holds this page: it is the only architecture here in which **the timescale is a learned function of the input rather than a constant, a hyperparameter, or an external modulatory register** — and it is the wiki's second universality proof over a sequence-model class, arriving with an explicit argument about *why universality is the wrong measure*, which puts it in direct methodological opposition to [[wiki/entities/simple-cycle-reservoir.md]].

---

## The object

| | Equation | Reading |
|---|---|---|
| Neural ODE (Chen et al. 2018) | `dx/dt = f(x(t), I(t), t, θ)` | the network *is* the vector field |
| CT-RNN (Funahashi & Nakamura 1993) | `dx/dt = −x(t)/τ + f(x(t), I(t), t, θ)` | a fixed leak `1/τ` pulls the autonomous system to equilibrium |
| **LTC (Eq. 1)** | `dx/dt = −[ 1/τ + f(x(t), I(t), t, θ) ] ⊙ x(t) + f(x(t), I(t), t, θ) ⊙ A` | `f` appears **twice**: once as the drive toward `A`, once *inside the decay rate* |
| **Liquid time constant** | `τ_sys = τ / (1 + τ·f(x(t), I(t), t, θ))` | large `f` ⇒ short memory (fast forgetting, fast tracking); `f → 0` ⇒ horizon relaxes to `τ` |

Derivation is by substitution: take a linear state ODE `dx/dt = −x/τ + S(t)` and let the source be `S(t) = f(x, I, t, θ)·(A − x(t))`. The `−f·x` term that falls out of the product is the whole idea — the drive term is multiplied by a **driving force** `(A − x)` rather than added, which converts a rate of injection into a rate of *approach* to `A`, and hence into a rate.

Parameters: `τ ∈ R^N`, `A ∈ R^N` (per-unit bias/target), `γ ∈ R^{M×N}` input weights, `γ_r ∈ R^{N×N}` recurrent weights, `μ ∈ R^N` biases; e.g. `f = tanh(γ_r x + γ I + μ)`.

### Where the form comes from

Two derivations, both given by the authors, and they matter differently:

| Source | Correspondence | What it licenses |
|---|---|---|
| **Non-spiking neuron biophysics** (Lapicque 1907; Koch & Segev 1998; Wicks et al. 1996 on *C. elegans*) | Membrane potential `dv/dt = −g_l v(t) + S(t)`; steady-state synaptic current `S(t) = f(v, I)·(A − v)` with `f` a sigmoid over presynaptic potentials and `A` a **reversal potential**. Substituting gives Eq. 1 exactly | The liquid time constant is not a design trick: it is **conductance modulating the membrane time constant**, i.e. shunting. Synaptic input changes `g_total`, and `τ_m = C/g_total`, so a biological neuron's integration window is input-dependent by construction |
| **Dynamic Causal Models** (Friston, Harrison & Penny 2003) with bilinear approximation | `dx/dt = (A + I(t)B)x(t) + C·I(t)` — a state matrix *modulated by the input* | Eq. 1 is a diagonal nonlinear cousin of the model neuroimaging uses to infer effective connectivity; the authors flag causality as the reason to care and do nothing with it |

The biophysical route is the load-bearing one for this wiki: it is a clean case of a mechanism that has **no rate-model description** (the driving force `(A − x)`, hence the reversal potential, hence the sign-and-magnitude asymmetry of excitation vs. shunting inhibition) being imported into an ML architecture and paying — evidence for position B of [[wiki/empirical-tensions.md]] T1.

---

## Forward and backward pass

**The ODE is stiff.** Runge–Kutta integrators need an exponential number of steps; Dormand–Prince (torchdiffeq's default) is explicitly declared unsuitable. The authors build a **fused solver**: replace only the `x(t_i)` occurring *linearly* in `f` by `x(t_{i+1})` (implicit where it is cheap, explicit elsewhere), then solve symbolically:

```
x(t+Δt) = [ x(t) + Δt · f(x(t), I(t), t, θ) ⊙ A ] / [ 1 + Δt · ( 1/τ + f(x(t), I(t), t, θ) ) ]
```

One update, no inner iteration; `O(L·T)` for `L` unfolding steps over a length-`T` sequence — same order as an LSTM of equal width.

**Trained by vanilla BPTT (Backpropagation Through Time), not the adjoint method,** and the justification is a real trade rather than convenience:

| | Vanilla BPTT | Adjoint |
|---|---|---|
| Time | `O(L·T·2)` | `O(L·T)` |
| Memory | `O((L_f + L_b)·T)` | **`O(1)`** |
| Graph depth | `O(L)` | `O(L_b)` |
| Forward accuracy | High | High |
| **Backward accuracy** | **High** | **Low** |

The adjoint integrates backwards from the final state and therefore *forgets the forward trajectory*; for a stiff system the reconstructed reverse trajectory is not the forward one. LTC pays constant-factor time and **linear memory** to keep the gradient honest. This is the wiki's clearest statement that constant-memory credit assignment in continuous-time models is bought with gradient error — the same currency [[wiki/concepts/biologically-plausible-credit-assignment.md]] trades in, arrived at from numerics rather than from anatomy.

---

## Stability: both bounds, and what they cost

| Theorem | Statement | Consequence |
|---|---|---|
| **Thm 1** | For a unit with `M` incoming connections and bounded monotone sigmoidal `f`, `τ_sys` is **bounded to a finite range** determined by `τ` and the extremes of `f` (the closed-form range is in a figure the source extraction dropped) | The horizon can be modulated but not made arbitrarily long: `f ≥ 0` ⇒ `τ_sys ≤ τ`. Adaptation only ever *shortens* memory relative to the learned ceiling |
| **Thm 2** | On a finite interval, every hidden state `x_i(t)` is **bounded** (proof by sign analysis of Eq. 1's compartments plus explicit-Euler approximation; the closed form is likewise in a dropped figure) | State stability: outputs cannot explode even for inputs growing without bound — the property [[wiki/concepts/attractor-dynamics.md]] usually has to buy with a normalisation or an energy function, here obtained from the driving-force term for free |

**The boundary this creates is the same wall [[wiki/entities/simple-cycle-reservoir.md]] draws, and the paper walks into it in its own limitations section:** LTCs "express the vanishing gradient phenomenon" and "would not be the obvious choice for learning long-term dependencies". `τ_sys ≤ τ` with `τ` a finite learned constant means the memory still fades exponentially; the liquid mechanism re-times the fade, it does not remove it. So the SCR theorem's exclusion list — held variable bindings, a rule inferred at step 1 applied at step 10⁶, discrete state — survives an input-dependent nonlinear rate. **That is a strengthening of SCR's negative result beyond the linear class in which it was proved, supplied by an architecture built to escape it.**

---

## Expressivity: the paper's central methodological move

Universality first (**Thm 3**): for any autonomous `C¹` system `ẋ = F(x)` on a compact subset, simulated on a bounded interval, there is an LTC with `N` hidden units approximating every rollout to `ε`. The proof embeds the `n`-dimensional target in a higher-dimensional LTC; it differs from the CT-RNN universality proof (Funahashi & Nakamura 1993) precisely because the input-dependent term sits *inside* the time constant.

And then the authors immediately discard it:

> "The theorem however, does not yield a concrete measure on where the separation is between different neural network architectures."

This is the wiki's sharpest instance of a field's own practitioners stating [[wiki/entities/simple-cycle-reservoir.md]]'s conclusion — and then doing the thing SCR's result implies you must do: **replace universality with a finer, architecture-sensitive measure.** Theirs is **trajectory length** (Raghu et al. 2017), extended here from static to continuous-time networks: drive the network with a circular input `I(t) = (sin t, cos t)`, PCA the hidden activations, and measure the arc length of the trajectory in the leading 2-D latent plane (>80% variance explained).

**Theorems 4 and 5** lower-bound that growth for Neural ODEs / CT-RNNs and for LTCs respectively (exact bounds in dropped figures; the qualitative content is recoverable from the discussion). What the bounds and the sweeps say:

| Lever | Neural ODE | CT-RNN | LTC |
|---|---|---|---|
| Solver steps `L` | exponential in `L` | exponential, **smaller base** than Neural ODE | exponential |
| Width `k` | linear | linear | **linear** (confirmed empirically, log-scale) |
| Weight variance `σ_w²` | grows | grows | **faster than linear** |
| **Depth** | flat for tanh/sigmoid | flat | **flat** |
| Choice of ODE solver | negligible (RK2(3), RK4(5), ABM1(13), TR-BDF2 all agree) | " | " |

Representative measured lengths (hard-tanh, width 100, `σ_w²=2`, `σ_b²=1`, layer 3): Neural ODE `2.6×10⁵`, CT-RNN `1.6×10⁴`, **LTC `1.8×10⁴`** — note LTC is *not* always longest with piecewise-linear activations; with `σ_w²=4` at depth 1 it is `2.8×10⁵` against Neural ODE's `227`. With ReLU at width 200 the ordering is `111 / 55 / 527`; with hard-tanh at width 200, `138 / 121 / 5.4×10⁴`.

### Two findings here that generalise past this architecture

**(1) Depth is not an expressivity lever in continuous-time networks.** Observation IV: with tanh or sigmoid activations, trajectory length *does not grow with depth* in any of the three CT families (`438 → 367 → 406 → 358 → 329` across five LTC layers) — the exact opposite of the static-network result the measure was invented to establish. In a continuous-time model, **the integrator's step count `L` occupies the role depth plays in a feedforward stack**, and the paper's own definition concedes it: total computational depth `= n × L`.

**(2) …which makes the headline comparison compute-confounded.** Table 2 measures `L`, the average number of integration steps the solver takes per input sample:

| Activation | Neural ODE | CT-RNN | **LTC** |
|---|---|---|---|
| tanh | 0.56 ± 0.02 | 4.13 ± 2.19 | **9.19 ± 2.92** |
| sigmoid | 0.56 ± 0.00 | 5.33 ± 3.76 | **7.00 ± 5.36** |
| ReLU | 1.29 ± 0.10 | 4.31 ± 2.05 | **56.9 ± 9.03** |
| hard-tanh | 0.61 ± 0.02 | 4.05 ± 2.17 | **81.01 ± 10.05** |

LTC takes **up to 133× more solver steps than a Neural ODE on the same input** under a variable-step integrator, because its ODE is stiff. Since trajectory length is exponential in `L` for every family, a large part of the measured separation is *bought compute*, not architecture — and the exponent's base is the only part left that is architectural. The paper never runs the comparison at matched `L`, and its own limitations section concedes "significantly enhances the expressive power… at the expense of elevated time and memory complexity". **The honest form of the claim is: at equal parameter count and unequal compute, LTC reaches longer latent trajectories.** `(brainstorm)` The fix is cheap and nobody has run it — fix `L` for all three families with the fused fixed-step solver and re-measure; if the separation survives, it is the first compute-matched expressivity separation inside a class where every member is a universal approximator. **The vehicle now exists**: [[wiki/entities/cfc.md]] has no solver at all, so its per-input cost is a discrete RNN's by construction, and trajectory length measured on a CfC is the missing `L`-free data point. It has not been measured.

---

## Results

Eleven experiments; mean ± sd over n=5. Bold = best in row.

| Dataset (metric) | LSTM | CT-RNN | Neural ODE | CT-GRU | **LTC** |
|---|---|---|---|---|---|
| Gesture (acc) | 64.57 ± 0.59 | 59.01 ± 1.22 | 46.97 ± 3.03 | 68.31 ± 1.78 | **69.55 ± 1.13** |
| Occupancy (acc) | 93.18 ± 1.66 | 94.54 ± 0.54 | 90.15 ± 1.71 | 91.44 ± 1.67 | **94.63 ± 0.17** |
| Activity recognition (acc) | 95.85 ± 0.29 | 95.73 ± 0.47 | **97.26 ± 0.10** | 96.16 ± 0.39 | 95.67 ± 0.58 |
| Sequential MNIST (acc) | **98.41 ± 0.12** | 96.73 ± 0.19 | 97.61 ± 0.14 | 98.27 ± 0.14 | 97.57 ± 0.18 |
| Traffic (sq. err ↓) | 0.169 ± 0.004 | 0.224 ± 0.008 | 1.512 ± 0.179 | 0.389 ± 0.076 | **0.099 ± 0.010** |
| Power (sq. err ↓) | 0.628 ± 0.003 | 0.742 ± 0.005 | 1.254 ± 0.149 | **0.586 ± 0.003** | 0.642 ± 0.021 |
| Ozone (F1) | 0.284 ± 0.025 | 0.236 ± 0.011 | 0.168 ± 0.006 | 0.260 ± 0.024 | **0.302 ± 0.016** |

| Extra setting | Result |
|---|---|
| Person Activity, setting 1 | LTC **85.48 ± 0.40** vs CT-GRU 85.27 ± 0.39 (overlapping), LSTM 83.59, CT-RNN 81.54, Latent ODE 76.48 |
| Person Activity, setting 2 (Rubanova et al. protocol) | LTC **0.882 ± 0.005** vs Latent ODE (ODE-enc.) 0.846 ± 0.013, ODE-RNN 0.829, GRU-D 0.806 |
| Half-Cheetah autoregressive kinematics (MSE ↓, 5% random actions) | LTC **2.308 ± 0.015** vs LSTM 2.500 ± 0.140, CT-RNN 2.838, CT-GRU 3.014, Neural ODE 3.805 |

**Reading.** LTC wins 4 of 7 in Table 3 and one of those (Person Activity setting 1) is inside noise. Its single largest margin is on **traffic** (0.099 vs LSTM's 0.169), an irregularly-structured continuous signal; it *loses* sequential MNIST to LSTM, which is the one task in the set with a long, uniformly-sampled dependency and no time-varying rate to exploit. That split is the cleanest empirical statement of what a liquid time constant buys and where it is inert: **it pays when the informative timescale of the input changes, and not otherwise.** Setting 2 is the strongest single number — +3.6 points over the best Latent ODE under someone else's protocol.

### The downstream line (aggregator source, `(tentative)`)

| Variant | Claim |
|---|---|
| **CfC** (Closed-form Continuous-time, Hasani et al. 2022) | A tightly-bounded *analytical* approximation of the LTC solution — no internal ODE solver, direct feed-forward computation. Removes the stiffness/step-count problem, and with it the confound above. **Now ingested as a primary source: [[wiki/entities/cfc.md]]** |
| **Liquid-S4** (Hasani et al. 2022) | The liquid mechanism inside a structured state-space model: diagonal-plus-low-rank operator, causal convolution, extra "liquid kernel" terms encoding multi-way input correlations. **87.32% avg on Long Range Arena, 96.78% Speech Commands, ~30% fewer parameters than S4** — i.e. the mechanism survives being moved into a model whose recurrence is a fixed convolution |
| **LGTC / CfGC** (Marino et al. 2024) | Per-node liquid time constants coupled through graph filters; stability by matrix-contraction analysis; flocking control at reduced communication |
| **NCP on Loihi-2** (Zong et al. 2025) | Sparse LTC as Neural Circuit Policies on neuromorphic hardware: >91% CIFAR-10 at sub-millijoule per frame; LTC 12K parameters vs LSTM 22K, ~10% less memory |

Liquid-S4 is the entry that matters for the wiki: it says the input-dependent-rate idea is **separable from the ODE-solver implementation**, which is what would let it be attached to a sequence model that is not stiff.

---

## Comparison

| | **LTC** | CT-RNN | Neural ODE | [[wiki/entities/kan-ode.md]] | [[wiki/entities/simple-cycle-reservoir.md]] | LSTM |
|---|---|---|---|---|---|---|
| Time | continuous | continuous | continuous | continuous | discrete | discrete |
| Timescale | **learned, per-unit, input-conditioned** `τ_sys(x,I)` | learned constant `τ` | none explicit | none explicit | one global `λ`, fixed | per-gate, input-conditioned (but not a rate — a mask) |
| State update | linear in `x`, nonlinearly rate-modulated | nonlinear drive + fixed leak | fully nonlinear | fully nonlinear | **linear** | nonlinear |
| Nonlinearity location | rate **and** drive (same `f`) | drive | vector field | vector field | **readout only** | gates |
| Recurrent params | `N²` learned | `N²` learned | all learned | all learned | **1** (`λ`) | `4N²` |
| Universality | proved (Thm 3) | proved (Funahashi & Nakamura 1993) | proved | via KAT | **proved, constructively** | proved |
| Stability guarantee | **state + `τ_sys` bounded** (Thms 1–2) | none stated | none | none | `‖W‖<1` by construction |none |
| Non-fading dependencies | **excluded** (`τ_sys ≤ τ`, vanishing gradients conceded) | excluded | not excluded in principle | not excluded in principle | **excluded** (proved) | partially handled by the cell state |
| Readable as an equation | no | no | no | **yes, post hoc** | trivially (`λ`) | no |
| Gradient method | BPTT (memory for accuracy) | BPTT | adjoint | adjoint | none (ridge readout) | BPTT |

---

## Limitations

| Limitation | Consequence for this wiki |
|---|---|
| **No long-term dependencies** | Conceded outright. `τ_sys ≤ τ` plus vanishing gradients ⇒ everything on [[wiki/entities/simple-cycle-reservoir.md]]'s exclusion list (variable binding, discrete state, a rule applied 10⁶ steps later) stays excluded. An adaptive rate is not a memory mechanism |
| **Expressivity comparison is not compute-matched** | Up to 133× more solver steps than the Neural ODE baseline, and trajectory length is exponential in step count for every family. The architectural component of the separation is unquantified |
| **Stiffness ⇒ solver-coupled performance** | "Majorly influenced" by off-the-shelf explicit Euler; needs the fused solver or a good variable-step integrator. An architecture whose behaviour depends on its integrator is an architecture with a hidden hyperparameter |
| **Time and memory** | Slower than Neural ODEs, `O((L_f+L_b)T)` memory against the adjoint's `O(1)`, and the authors flag reducing it as future work |
| **All tasks are time-series regression/classification** | No abstract reasoning, no compositional generalisation, no held-out structure. The claim proved is about approximating trajectories of a system, which is [[wiki/concepts/latent-graph-discovery.md]]'s *navigate* half with the graph handed over as a continuous flow |
| **`f` does two jobs** | The same network sets the drive and the forgetting rate; nothing lets a controller set the horizon independently of what is being written. See below |
| **Causality asserted, not tested** | The DCM resemblance is offered as motivation for a future direction; no interventional experiment anywhere |
| **Aggregator numbers are damaged** | The bundled survey's speed-up factors, LTC-SE accuracy/depth deltas and the closed-form bounds were destroyed by a rendering bug in the source file |

---

## What this contributes to a reasoning model

**1. The timescale becomes a learned, endogenous, per-unit variable — and that is a new slot in the wiki.** Every other treatment of memory horizon here is either a constant ([[wiki/entities/simple-cycle-reservoir.md]]'s `λ`, CT-RNN's `τ`), a hyperparameter (BPTT truncation), or an *external* modulatory register ([[wiki/concepts/neuromodulatory-metaparameters.md]]). LTC makes it a function of the current input, computed by the network itself, with a proof that the result stays bounded. The transferable primitive is one line: **multiply the drive by a driving force `(A − x)` and the rate falls out of the same nonlinearity.**

**2. …and it fuses the content channel with the timing channel, which gap G54 asks to separate.** G54 wants an architecture that distinguishes a connection carrying content from one carrying only timing. LTC is the extreme opposite: one `f` is the content and the timing. The obvious variant is the **factorised LTC** — `dx/dt = −[1/τ + g(x,I)]x + f(x,I)⊙A` with `f ≠ g`, so a separate small network owns the horizon. That is (i) a direct instance of G54 and (ii) the architectural form of a neuromodulator, since `g` is then a gain-on-forgetting with its own inputs. **It has been built: [[wiki/entities/cfc.md]] Eq. 4 gives the rate its own head `θ_f` inside `σ(−f·t)` and the content two others (`θ_g, θ_h`), over a shared backbone that the authors keep deliberately, to *couple* the time constant to the state nonlinearity.** The verdict there is null — Cf-S (no split), CfC-noGate and full CfC perform comparably, dataset-dependent — which relocates rather than answers G54: the benchmarks are time-series regression/classification, where nothing ever needs to hold a horizon fixed while content changes. `(brainstorm)` The test G54 wants is a cue that sets the delay without being the content remembered. Whether the biology supports the split is separately open: shunting conductance *is* both, but neuromodulators change `g_leak` without carrying signal content.

**3. It supplies the response the wiki needs to T174/SCR's negative result, and shows how expensive that response is.** SCR says universality cannot discriminate architectures. LTC agrees in print, and its answer — measure the geometry of the induced latent trajectory instead — is the right *kind* of answer. That it comes out compute-confounded is a lesson about the measure, not about the strategy: **any expressivity measure sensitive to how much computation is spent per input will separate a stiff model from a non-stiff one for reasons that are not architectural.** A usable measure must be per-FLOP or per-step. Nothing in the wiki has one.

**4. Bounded stability without an energy function.** `dx/dt = −(rate)·x + (rate)·A` is contraction toward a moving target; the state cannot leave the hull of `A` and 0 regardless of input magnitude. [[wiki/concepts/attractor-dynamics.md]] usually obtains boundedness from symmetric weights and a Lyapunov function, at the price of no traversal; here it is obtained from the *form of the drive* while the recurrent matrix stays free and asymmetric. `(brainstorm)` That is an underused trick: driving-force multiplication is a stability guarantee that costs nothing structurally, so it composes with any recurrent topology — including the ring of [[wiki/entities/simple-cycle-reservoir.md]] and the grown graph of [[wiki/entities/hag-reservoir.md]], neither of which has one.

**5. A negative result on depth that the wiki should carry.** Stacking layers does not lengthen the latent trajectory in a continuous-time model. If depth is the wrong scaling axis for CT networks, then the axes that remain are width (linear), weight variance (super-linear) and integration steps (exponential) — and only the last is *adaptive per input*, which makes an adaptive solver's step-size controller the closest thing a CT network has to variable-effort computation. That is the same signal [[wiki/entities/kan-ode.md]] flags as a free event-segmentation boundary detector, seen from the compute side rather than the segmentation side.

---

## Connections

- **[[wiki/entities/cfc.md]]** — the same equation with the integrator removed: the LTC solution's remaining integral `∫₀ᵗ f(I(s))ds` is replaced by `f(I(t))·t` plus `f(−I(t))`, under a sharp-but-total worst-case bound, and the exponential decay is then swapped for a sigmoid so the flow becomes a gate whose argument is `rate × elapsed time`. It answers two open items on this page (the factorised-`f`/`g` variant, the compute-matched trajectory measure) and prices what the solver was buying — invertibility, the DCM causal reading, and the state-boundedness theorems, none of which survive the substitution.
- **[[wiki/entities/simple-cycle-reservoir.md]]** — the direct counterpart, and the pair brackets the question: SCR proves universality for a one-parameter recurrent coupling and concludes architecture is expressively free inside the fading-memory class; LTC proves universality too, says in its own words that the theorem cannot separate architectures, and imports trajectory length to separate them anyway ([[wiki/empirical-tensions.md]] T175) — while independently *confirming* SCR's boundary, since a bounded input-dependent `τ_sys ≤ τ` still fades and the authors concede they cannot do long-term dependencies.
- **[[wiki/entities/kan-ode.md]]** — the wiki's other continuous-time model, and the complementary bet: KAN-ODE puts the learnable structure in the *functional form* of the vector field so it can be read as an equation, LTC puts it in the *rate* of a deliberately linear state update so the horizon can vary with input; they share the solver-step-count-as-compute observation and disagree on whether the drive should be nonlinear at all.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the same functional role reached from inside instead of outside: a neuromodulator sets a network-wide gain or time constant from a separate system, whereas `τ_sys = τ/(1+τf)` is set per-unit, per-instant, by the very signal being integrated — so LTC is what a fully endogenous, fully local metaparameter looks like, and the factorised variant above is the architecture that would give it a separate controller.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the finest-grained end of that page's hierarchy question: where an option is a temporally extended commitment with a termination condition, a liquid time constant is a *continuously varying integration window* with no discrete boundary at all, so the two are the extreme discrete and continuous answers to "over what interval does this computation hold" and neither has been built into the other.
- **[[wiki/concepts/working-memory.md]]** — a negative result the page should carry: making the decay rate input-dependent, learned, per-unit and provably bounded does **not** yield working memory, because the bound runs the wrong way (`τ_sys ≤ τ`); an adaptive fading horizon and a maintained variable are different mechanisms, and this is the strongest evidence in the wiki that the first cannot be stretched into the second.
- **[[wiki/concepts/attractor-dynamics.md]]** — boundedness obtained from the *drive* rather than from symmetry: multiplying the input by a driving force `(A − x)` makes every unit contract toward a moving target, so the state stays bounded for unbounded input with the recurrent matrix left free and asymmetric — a stability guarantee that composes with any topology, unlike the Lyapunov route.
- **[[wiki/concepts/dendritic-computation.md]]** — the biophysics LTC actually imports: the liquid time constant *is* conductance-dependent membrane integration (`τ_m = C/g_total`), i.e. shunting, which is the same mechanism that page treats as sublinear input interaction — read here as a change of *rate* rather than a change of *gain*, and the two readings have never been reconciled in one model.
- **[[wiki/entities/spiking-neural-networks.md]]** — the non-spiking half of the same biophysics: LTC is the *C. elegans* graded-potential neuron with conductance synapses written as a trainable layer, which is why the aggregator's Loihi-2 deployment is unsurprising — and it is evidence for T1 position B from an unusual direction, since the imported detail (the reversal potential in the driving force) has no rate-model description and is what produces the stability theorem.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — a numerical instance of that page's central trade: the adjoint method is the `O(1)`-memory, biologically-attractive backward pass and it is rejected here because it forgets the forward trajectory and returns a low-accuracy gradient on a stiff system; constant-memory credit assignment costs gradient fidelity in numerics for the same structural reason it does in anatomy.
- **[[wiki/concepts/causal-model-building.md]]** — the unexploited claim: Eq. 1 is a diagonal nonlinear relative of the bilinear Dynamic Causal Model used to infer effective connectivity from fMRI, so the architecture has an input-modulated state matrix of exactly the form causal inference in neuroimaging assumes — and the paper runs no interventional experiment, leaving the resemblance as motivation rather than evidence.
- **[[wiki/concepts/latent-graph-discovery.md]]** — sits entirely on the *navigate* side: the system to be approximated is handed over as a continuous flow, the state variables are the observation dimensions, and nothing discovers nodes, edges or a vocabulary; what it adds is that traversal speed along the flow becomes a learned function of position and input.
- **[[wiki/entities/hag-reservoir.md]]** — the opposite lever on the same substrate: HAG grows the recurrent *graph* under a fixed neuron model, LTC fixes nothing about the graph and makes the *neuron's rate* adaptive, and the two are orthogonal and untested together — a grown reservoir of liquid units would have both, with LTC's driving-force term supplying the stability HAG currently obtains by rescaling `ρ(W) ≈ 2.89` back into range.
- **[[wiki/entities/s4.md]]** — the complementary half of the same design space, and the missing baseline for the Liquid-S4 row above: LTC makes the *rate* input-dependent and concedes it cannot do long range, S4 fixes the operator entirely (linear time-invariant, one kernel for all content) and carries 16,384 steps, and Liquid-S4 — which has both — reports 87.32% Long Range Arena average against S4's 86.09% at ~30% fewer parameters, i.e. **+1.2 points for the mechanism this whole line is built on**. S4 also supplies the external counterpart to this page's endogenous timescale: `Δ` is a global, content-independent resolution knob settable at test time, which `τ_sys = τ/(1+τf)` is by construction unable to be (Gu et al. 2022).
- **[[wiki/entities/ms-ssm.md]]** — the opposite factorisation of the same variable, and the one that passes G54 where this page fails it by construction: LTC computes a *continuous* horizon per unit per instant from the very signal it is integrating, so rate and content are one function; MS-SSM freezes a *discrete* bank of `S+2` horizons at initialisation and lets a content-derived row vector pick a mixture over it, changing none of them — cleanly separated, but expressively confined to the horizons it was initialised with. On ListOps the frozen bank reaches 63.04 against Liquid-S4's 62.75 (Karami et al. 2025).
- **[[wiki/concepts/neuronal-parameter-heterogeneity.md]]** — the missing middle row of this page's timescale table, and the one that passes `G54` where LTC fails it: `τ` is learned *per unit* on a separate optimisation loop rather than recomputed from the input, so the content channel (`W`) and the timing channel (`α`) stay separable — at the cost of freezing the horizon at deployment, which is exactly what LTC's `τ_sys(x, I)` buys back.
- **[[wiki/concepts/effective-connectivity.md]]** — what the neuroimaging side actually does with the bilinear equation this architecture is a diagonal nonlinear relative of: invert it against fMRI to recover directed, signed couplings per subject, choose between candidate graphs by model evidence, and treat the fitted system as a controller — the three uses that would give the causal resemblance flagged here empirical content.
- **[[wiki/concepts/neuron-complexity-index.md]]** — the experiment that would test this unit against the biology directly: NMDA-mediated integration is an input-dependent time constant by another name (recent neighbouring activity lengthens the integration window), and the 7-layer × 128-channel temporal-convolutional fit to an L5PC was searched only over fully connected and convolutional classes — if a small LTC network clears the same AUC bar, the measured depth is a property of the architecture class, not of the cell.
- **[[wiki/entities/lru.md]]** — the opposite subtraction from the same object, with the controlled experiment this page's design assumes away: LTC pushes more nonlinearity *into* the recurrence (an input-dependent rate inside the ODE) and concedes it cannot do long range, while LRU deletes the recurrent nonlinearity entirely and reaches 16,384 steps — and on a single-layer control (learn one length-100 convolution kernel, Glorot init both arms) the linear recurrence converges faster than `tanh` at **every** learning rate in the grid, which is evidence that the recurrent nonlinearity costs optimisation speed rather than buying expressivity (Orvieto et al. 2023).
