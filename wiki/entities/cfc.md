# CfC (Closed-form Continuous-time Network)

**An LTC with its ODE solver deleted: the integral in the LTC solution is replaced by a closed-form expression in which `t` appears *explicitly*, so the hidden state at any time is one feed-forward evaluation rather than `K` integration steps — and the exponential decay is then swapped for a sigmoid, turning the continuous-time flow into a pair of gates whose argument is `(learned rate) × t`.**

> **Provenance.** Hasani, Lechner, Amini, Liebenwein, Ray, Tschaikowski, Teschl & Rus 2022, *Closed-form continuous-time neural networks*, Nature Machine Intelligence 4, 992–1003 (`raw/hasani-2022-closed-form-continuous-time-nets.md`). Same group as [[wiki/entities/ltc.md]]. **The article's Tables 1–4 and all ten Extended Data figures did not survive extraction** — the per-model accuracy/AUC numbers, the complexity table, and the hyperparameter grids are absent from the source file. Every figure quoted below comes from running prose, and the missing tables are the ones that would let the wiki check the headline claims per baseline.

Why the wiki holds this page separately from [[wiki/entities/ltc.md]]: it is the **vehicle for the compute-matched expressivity comparison the wiki said nobody had run** (T175), it is the **already-built instance of the factorised-LTC the LTC page proposed as a brainstorm** (G54), and it prices what removing a differential equation costs — invertibility, and the causal/verification reading — in the authors' own words.

---

## The derivation, in three steps

Start from the LTC initial-value problem (Eq. 1, unchanged from [[wiki/entities/ltc.md]]):

```
dx/dt = −[ w_τ + f(x, I, θ) ] ⊙ x(t) + A ⊙ f(x, I, θ)
```

| Step | Move | Result |
|---|---|---|
| **1. Integral solution** | Scalar case with no self-connection is *linear* in `x`; apply variation of constants | `x(t) = (x(0) − A)·e^{−w_τ t − ∫₀ᵗ f(I(s))ds} + A` — one integral left, over an arbitrary sensory signal, with no known closed form |
| **2. Piecewise-constant inputs** | Discretise `I` into segments `[τ_i, τ_{i+1})` with `I = γ_i` | `∫₀ᵗ f(I(s))ds = f(γ_k)(t − τ_k) + Σ_{i<k} f(γ_i)(τ_{i+1} − τ_i)` — exact, but a tight fit needs many break points |
| **3. The approximation (Lemma 1)** | Replace the whole integral term by a *product of two evaluations of `f` at the current instant* | `x̃(t) = (x(0) − A)·e^{−[w_τ + f(I(t))]t}·f(−I(t)) + A` |

**Theorem 1** is step 3 stated as the closed-form approximation of the scalar LTC. The trick worth extracting: the accumulated history `∫₀ᵗ f(I(s))ds` is approximated by `f(I(t))·t` for the *rate* and `f(−I(t))` for the *magnitude* — a monotone bounded `f` evaluated at the negated input plays the role of the entire past. The paper's own framing is that this replaces integration of a nonlinear DE with a **nonlinear forward operator applied to the inputs**, and that this is the step from a conductance-based model to a neural-mass model of the kind used in dynamic causal modelling.

### An assumption that is only checked numerically

The derivation needs a **second `w_τ` inserted into the drive term** — `+A·[w_τ + f(I(t))]` rather than `+A·f(I(t))` — "to introduce symmetry in the structure of the ODE, yielding a simpler expression". The authors concede this "may appear to profoundly alter the dynamics" and defend it only by the numerical fit below. So the object being solved in closed form is not exactly the LTC of the 2021 paper.

### What "tightly bounded" actually means

`|x(t) − x̃(t)| ≤ |x(0) − A|·e^{−w_τ t}` for all `t ≥ 0`, and Lemma 1 proves this bound is **sharp**: across all continuous input signals, `sup (x − x̃)/c = e^{−w_τ t}` exactly, with `inf = e^{−w_τ t}(e^{−t} − 1)`.

**Read carefully, this is a weak guarantee stated honestly.** The error envelope is *the same exponential* that bounds the signal's own deviation from `A` — i.e. in the worst case the relative error is 100%, and what saves the approximation is only that both the signal and the error decay at rate `w_τ`. The adversarial input that achieves the supremum is explicit in the proof (a long stretch at `−C` followed by a short stretch at `+C`, i.e. **a step change at the very end of the window**), which says exactly where the approximation fails: recent sharp transitions, the regime where `f(I(t))·t` mistakes an instantaneous value for an accumulated one. Practice is much better than the worst case — replaying a trained 19-neuron / 253-synapse Neural Circuit Policy's recorded driving parameters through the closed form reproduces the output neuron's ODE trajectory at **MSE 0.006** — but the wiki should carry the shape of the failure, not just the constant.

### Compilation

Algorithm 1 **compiles an existing LTC network into its closed form**: for each neuron, sum the per-synapse closed-form expression over incoming synapses, with `W_Adj` of arbitrary sparsity (no DAG requirement). Note that the theorem is scalar and assumes *no self-connections*, so the network-level compilation is a per-synapse superposition of a scalar result — an additional approximation on top of Lemma 1's, and one the paper does not bound.

---

## From the solution to a trainable layer

Equation 3 is the direct vectorisation, `x(t) = B ⊙ e^{−[w_τ + f(x,I;θ)]t} ⊙ f(−x,−I;θ) + A`, and it does not train: the exponential drives the state to `A` exponentially fast, i.e. **the closed form *is* a vanishing-gradient factor written explicitly**. Four repairs, each a transferable design move:

| Repair | Change | Reason |
|---|---|---|
| **Sigmoidal decay** | `e^{−(·)t}` → `σ(−(·)t)`, still ≈1 at `t=0` and →0 as `t→∞` | Same limits, much gentler transition ⇒ better-conditioned loss surface. A gate replaces a decay |
| **Learnable biases** | `B` folded into a network, `A` → a network `h(·)` | Constants become functions of state and input |
| **Gating balance** | multiply `h(·)` by `(1 − σ(·))` | The time-decaying sigmoid becomes a **convex interpolation between the `t → −∞` and `t → +∞` limits of the ODE trajectory** |
| **Backbone** | `f`, `g`, `h` share the first layers, then branch into heads | Shared representation for stability; *and* it couples the time constant to the state nonlinearity while letting the heads explore temporal and structural dependence independently |

**The CfC layer (Eq. 4):**

```
x(t) = σ(−f(x,I;θ_f)·t) ⊙ g(x,I;θ_g)  +  [1 − σ(−f(x,I;θ_f)·t)] ⊙ h(x,I;θ_h)
```

`t` is supplied per sample: for irregular data it is the timestamp; for ordinary sequences it is sampled at equidistant intervals between two hyperparameters `a, b`. Time complexity equals a discretised RNN's.

**This is the wiki's first gate whose argument is a time, not a value.** An LSTM gate is a mask computed from content; `σ(−f·t)` is a mask computed from content *multiplied by elapsed time*, so the same input produces a different mix depending on how long ago the last sample arrived, with `f` playing the role of a rate. That is the mechanism by which a discrete recurrent cell handles irregular sampling without an integrator.

### Variants

| Variant | Definition | When |
|---|---|---|
| **Cf-S** | Eq. 3 verbatim, no repairs | Fastest inference |
| **CfC-noGate** | Eq. 4 without the `(1 − σ)` branch | Try as a hyperparameter |
| **CfC** | Eq. 4 | Default up to a few hundred steps |
| **CfC-mmRNN** | CfC as the memory state of an LSTM (mixed-memory, after ODE-LSTM) | Long-range dependence |

---

## Results

Numbers below are the ones present in prose; the per-baseline tables were lost in extraction.

| Task | Finding |
|---|---|
| **Human activity recognition** (561-dim inertial, per-step, Rubanova split) | Cf-S, CfC-noGate and CfC-mmRNN outperform all baselines "with a high margin", at **+8,752% speed** over the best ODE model (Latent-ODE-ODE) — the gap is large precisely because stiff dynamics make the solver take many steps |
| **Walker2D** (irregularly sampled MuJoCo kinematics, next-state regression) | CfC best by a large margin, **18% over transformers** |
| **Event-based sequential MNIST** (784 → 256 events, irregular) | **State of the art: CfC-mmRNN 98.09%, CfC-noGate 96.99%**, at 200–400% the speed of GRU-ODE / ODE-RNN. ODE-RNN, CT-RNN, GRU-ODE and plain LSTM fail this task |
| **Bit-stream XOR** (every element matters equally) | *Regular* sampling: many models reach 100%. *Irregular*: only GRU-D, ODE-LSTM, CfC and CfC-mmRNN. ODE-based RNNs fail **regardless of solver** — vanishing/exploding gradients, not integration error |
| **PhysioNet 2012** (8,000 ICU patients, 37 features, irregular in time *and* feature) | Competitive AUC; **160× faster than ODE-RNN, 220× than continuous latent models, 3× faster than advanced gated discrete RNNs** |
| **IMDB sentiment** | Only CfC-mmRNN beats the advanced RNN benchmarks — the mixed-memory variant, not the CfC itself |
| **Full-scale autonomous driving** (1 km road, Lexus RX450H, imitation from 3 h expert data) | CfC keeps an NCP-like VisualBackProp attention profile **under added sensory noise**, where CNN and LSTM attention degrades; **~4,000 trainable parameters** in the RNN block |
| Aggregate | "over 150-fold improvements" in accuracy per unit compute time vs ODE-based blocks; 1–5 orders of magnitude faster training/inference |

**Reading.** Two distinct claims are bundled and only one is well supported by the prose. The *speed* claim is enormous and mechanistically explained (no solver ⇒ `O(K̃)` in input steps rather than `O(Kp)` in solver steps, with `K̃` one to three orders below `K`). The *accuracy* claim rests on tables the extraction lost — the strongest surviving statement is that four variants "achieve comparable results to each other while one comes on top depending on the dataset", which is the signature of a **flat variant landscape**: Eq. 3 raw, Eq. 4 gated, and Eq. 4 half-gated all land in the same place, so the three repairs after the sigmoid substitution are not carrying the performance.

---

## What this changes in the wiki

### 1. T175's compute confound now has a fix, and half of it is already run

[[wiki/entities/ltc.md]] separates architectures by **trajectory length**, but trajectory length is exponential in solver step count `L` and a stiff LTC buys up to 133× more steps than a Neural ODE on the same input — so the separation is partly bought compute. CfC removes `L` entirely: there is no solver, `t` enters the formula directly, and the paper says the notion of approximation error from a `p`-th order integrator "becomes irrelevant". **A CfC therefore has a well-defined per-input compute cost equal to a discrete RNN's**, and running the trajectory-length measure on CfC vs LTC vs Neural ODE at that fixed cost is the compute-matched experiment T175 asks for. `(brainstorm)` The prediction that would settle it: if LTC's long trajectories were bought with solver steps, CfC's trajectory length should collapse toward the CT-RNN's while its *task* accuracy holds — which is what the accuracy results here already hint at, since CfC matches or beats LTC-based NCPs at a fraction of the compute. Nobody has measured trajectory length for a CfC.

### 2. G54's factorisation exists — the LTC page's brainstorm was already built

[[wiki/entities/ltc.md]] proposes a "factorised LTC", `dx/dt = −[1/τ + g(x,I)]x + f(x,I)⊙A` with `f ≠ g`, so a separate network owns the memory horizon, and flags it as unrun. **Eq. 4 is that architecture.** `f` sets the rate (it appears only inside `σ(−f·t)`), `g` and `h` supply the two content endpoints, and they are separate heads over a shared backbone. The result is more informative than a clean split would have been:

- The separation is **partial by design** — the shared backbone is justified in the paper as *coupling* the time constant to the state nonlinearity, so the architecture asserts that content and timing should share features but not parameters.
- The empirical verdict on the split is **null so far**: CfC-noGate (which drops one content branch) and Cf-S (which has no split at all) perform comparably. If separating the timing channel from the content channel mattered on these benchmarks, the variant ladder should have been monotone, and it is not.
- `(brainstorm)` So G54 is not answered, it is **relocated**: these are time-series regression and classification tasks, where nothing needs to hold a horizon fixed while content changes. The test G54 actually wants is a task where the *right* memory horizon is set by a cue that is not the content being remembered — e.g. a delayed-match task where a colour cue announces the delay length. No benchmark here does that.

### 3. The price of deleting the differential equation, stated by the authors ([[wiki/empirical-tensions.md]] T176)

| Lost | Why it matters |
|---|---|
| **Invertibility** | An ODE under uniqueness conditions can be run backwards in time, so it is a bijection — the property continuous normalising flows are built on. "CfCs only approximate ODEs and therefore no longer necessarily form a bijection." Generative modelling stays with ODEs |
| **Causal reading** | The authors "speculate that inferring causality from ODE-based networks might be more straightforward than a closed form" — the Dynamic Causal Model correspondence that motivates LTC ([[wiki/concepts/causal-model-building.md]]) is a statement about a differential operator, and a sigmoid-gated interpolation does not obviously inherit it |
| **Verification** | Open question in the paper: whether verifying a continuous neural flow is more tractable in ODE or closed form |
| **Physics/PDE modelling** | Implicit ODE- and PDE-based models remain the right choice for continuously defined physics and control |

**This is the wiki's cleanest example of a solved efficiency problem that costs a *semantic* property rather than an accuracy point.** The closed form is faster, equally accurate, and strictly less interpretable-as-a-dynamical-system: you can no longer differentiate it and read off a vector field, run it backwards, or fit it as an effective-connectivity model.

### 4. The long-range wall is unmoved

CfCs "might express vanishing gradient problems"; the recommendation for long-term dependence is CfC-mmRNN (an LSTM wrapper) or constrained transition matrices. IMDB is won only by the mixed-memory variant. So the exclusion list of [[wiki/entities/simple-cycle-reservoir.md]] — held bindings, a rule inferred at step 1 applied much later, discrete state — survives the removal of the solver exactly as it survived the input-dependent rate. **What CfC does fix is a different failure: irregular sampling.** ODE-RNNs fail the event-based XOR task *for every solver*, and the CfC's `σ(−f·t)` gate solves it — so the gradient pathology of continuous-time RNNs on irregular data was never an integration problem.

---

## Comparison

| | **CfC** | [[wiki/entities/ltc.md]] | Neural ODE / ODE-RNN | LSTM | [[wiki/entities/simple-cycle-reservoir.md]] |
|---|---|---|---|---|---|
| Time enters | **explicitly, as `t` inside a gate** | implicitly, via the integrator | implicitly, via the integrator | not at all (step index) | not at all |
| Solver | **none** | fused implicit/explicit Euler (stiff) | adaptive `p`-th order | — | — |
| Inference cost | `O(K̃)` in input steps | `O(K·p)` in solver steps | `O(K·p)` | `O(K̃)` | `O(K̃)` |
| Rate/content split | **separate heads, shared backbone** | one `f` does both | one vector field | gates vs cell | none |
| Irregular sampling | **native** (timestamp → `t`) | native | native but gradient-pathological | needs `Δt` concatenation or imputation | no |
| Invertible | **no** | yes (it is an ODE) | yes | no | no |
| Long-range dependence | no (needs mmRNN wrapper) | no | no | partially (cell state) | no (proved) |
| Stability guarantee | none stated (the ODE's Thms 1–2 do not transfer through the sigmoid substitution) | state and `τ_sys` bounded | none | none | `‖W‖ < 1` |
| Universality | inherited, as an approximation of an ODE system | proved | proved | proved | proved constructively |

---

## Limitations

| Limitation | Consequence |
|---|---|
| **Sharp bound ≠ small error** | The proved envelope `|x − x̃| ≤ |x₀ − A|e^{−w_τ t}` is attained; worst-case relative error is total, and the adversarial signal is a late step change. Only the exponential decay makes it usable |
| **The solved ODE is not quite the LTC** | The symmetry assumption inserts a second `w_τ` into the drive; defended by one MSE-0.006 replay, not by analysis |
| **Network-level compilation is unbounded** | Theorem 1 is scalar and self-connection-free; Algorithm 1 superposes it across synapses with no error statement |
| **Tables lost in extraction** | Every per-baseline accuracy/AUC number and the complexity table are absent from the source file; the wiki holds prose claims only |
| **Variant ladder is flat** | Cf-S ≈ CfC-noGate ≈ CfC ≈ CfC-mmRNN depending on dataset — so the architectural repairs after the sigmoid substitution are unvalidated as *improvements* |
| **No stability theorem** | LTC's boundedness came from the driving-force form of the ODE; replacing `e^{−(·)t}` with `σ(−(·)t)` and `A` with a network `h(·)` discards that argument. Boundedness now rests only on `h`'s output range, which is not discussed |
| **Every task is time-series** | Activity recognition, physics kinematics, ICU mortality, sentiment, sequential MNIST, lane-keeping. No abstract reasoning, no compositional generalisation, no held-out structure — same boundary as [[wiki/entities/ltc.md]] |
| **Not for language** | The authors concede transformers are the right choice where data and compute are abundant; CfC's stated niche is irregular/limited data, embedded efficiency, and interpretability |

---

## Connections

- **[[wiki/entities/ltc.md]]** — the parent, and the page this one exists to correct in two places: CfC *is* the factorised-LTC that page proposes as an unrun brainstorm (rate `f` and content `g,h` are separate heads over a shared backbone) and it reports a null result on the split, and CfC's removal of the solver supplies the vehicle for the compute-matched trajectory-length measurement that page flags as the cheap unrun fix to T175.
- **[[wiki/entities/kan-ode.md]]** — the opposite response to the same fact that a continuous-time model's compute is its solver's step count: KAN-ODE keeps the solver and reads the *learned vector field* as an equation, CfC deletes the solver and thereby gives up having a vector field to read — so the wiki's two continuous-time models now trade interpretability against cost in opposite directions, and CfC's own limitations section (no invertibility, causality "less straightforward") is that trade admitted.
- **[[wiki/entities/simple-cycle-reservoir.md]]** — the exclusion list survives again: removing the integrator changes the cost of a continuous-time recurrent model by up to five orders of magnitude and moves nothing on long-range dependence, which the authors concede by recommending an LSTM wrapper — so the fading-memory boundary is insensitive to whether time is integrated or evaluated in closed form.
- **[[wiki/concepts/working-memory.md]]** — a second negative datum of the same shape as LTC's: the fix for long-term dependence is to *wrap the continuous-time cell inside an LSTM* (CfC-mmRNN), i.e. maintenance is imported from a discrete gated cell rather than obtained from the continuous dynamics, and it is the only variant that wins IMDB.
- **[[wiki/concepts/attention.md]]** — the efficiency argument from the other side: CfC's inference is `O(K̃)` in input steps against a transformer's quadratic sequence cost, and it beats transformers by 18% on irregularly sampled Walker2D kinematics while the authors concede transformers own language modelling — so the discriminator on offer is *irregular, limited, physically-generated* data versus abundant token data, not sequence length as such.
- **[[wiki/concepts/causal-model-building.md]]** — the DCM correspondence is a property of the *differential operator*, and this paper is where the group states it may not survive the closed form ("inferring causality from ODE-based networks might be more straightforward"), which makes the resemblance LTC advertises an argument for keeping the solver rather than a free property of the architecture family.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the horizon-setting channel given its own parameters: `σ(−f(x,I;θ_f)·t)` isolates the rate network `θ_f` from the content networks `θ_g, θ_h`, which is what an endogenous metaparameter with a dedicated controller looks like — and the flat variant ladder says these benchmarks cannot tell whether the separation buys anything.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — a gate whose argument is `rate × elapsed time` is the smooth version of a termination condition: it interpolates between the `t → −∞` and `t → +∞` endpoints of the underlying flow, so "how long this computation holds" becomes a learned scalar multiplying a real duration rather than a discrete decision, and irregular sampling is handled for free by feeding the timestamp in.
- **[[wiki/concepts/latent-graph-discovery.md]]** — still entirely on the *navigate* side and now cheaper there: the flow is handed over, nothing discovers nodes or edges, and what the closed form adds is that a position on the trajectory can be evaluated directly from `(state, input, elapsed time)` without walking the intervening path — jumping rather than traversing, which is the property a planner would want and no experiment here uses.
- **[[wiki/entities/s4.md]]** — both models refuse to run an integrator, for different reasons and at different prices: CfC deletes the solver because stiffness made step count the dominant cost, losing invertibility and the causal reading with it; S4 keeps a continuous-time semantics it never integrates, evaluating the convolution kernel through a truncated generating function at the roots of unity. The result is that S4's `Δ` remains a *physical* sampling resolution that can be rescaled after training (0.5× frequency, 96.30% vs 98.32%, no gradient step), where CfC's `t` is a per-sample scalar fed into a gate — the same continuous-time affordance realised as an external register rather than as an input (Gu et al. 2022).
- **[[wiki/entities/ms-ssm.md]]** — the architecture this page's null result asked for: splitting `θ_f` from `θ_g, θ_h` buys nothing measurable here, and the discriminating case was named as "a cue that sets the horizon without being the content remembered"; MS-SSM's `E_t` is that cue — derived from the raw input, selecting among frozen band horizons and altering none — and its ablation that gating from the raw `x_t` beats gating from a band's own representation `x̂^s_t` states the principle directly: a band-limited channel cannot judge its own relevance, so the rate selector must sit outside the filter it selects (Karami et al. 2025).
- **[[wiki/entities/transformer.md]]** — the architecture this page's efficiency argument is made against, now sourced: quadratic `O(n²·d)` per layer is conceded in the original and restricted `r`-neighbourhood attention is pre-announced there as future work (raising maximum path length back to `O(n/r)`), which is the exact trade CfC's `O(K̃)` cost avoids on irregularly sampled physical data while its authors concede language modelling to attention (Vaswani et al. 2017).
