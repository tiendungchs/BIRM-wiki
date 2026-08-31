# LRU (Linear Recurrent Unit)

**A deep RNN reached from a vanilla RNN by four subtractions — delete the recurrent nonlinearity, diagonalise the state matrix over `C`, parameterise its eigenvalues in polar form `λ = exp(−exp(ν^log) + i·exp(θ^log))`, and rescale the input by `γ = √(1−|λ|²)` — whose eigenvalues are initialised *uniformly on a ring* in the unit disc and which matches S4/S4D/S5 on every Long Range Arena task, including Path-X, with no HiPPO, no discretisation, no continuous-time semantics and no non-normal structure.**

> **Provenance.** Orvieto, Smith, Gu, Fernando, Gulcehre, Pascanu & De 2023, *Resurrecting Recurrent Neural Networks for Long Sequences*, ICML 2023 (`raw/orvieto-2023-linear-recurrent-unit.md`, ar5iv HTML). Body and appendices present; **all figures are dropped** (Fig. 1 architecture/summary, Figs 2–3 spectra, Fig. 4 impulse-response kernels, Fig. 5 Path-X training curves, Figs 6–8 spectral leakage and parameterisation landscapes), so every figure-borne claim below is held from prose.

Why the wiki holds this page:

1. It is the **adjudication of T177's Position B.** [[wiki/entities/s4.md]] concluded "the result is the HiPPO initialisation". LRU keeps the *effect* and removes the *object*: uniform sampling on a slice of the unit disc, plus normalisation, reaches Path-X 94.2%. What the initialisation had to supply turns out to be two scalar ranges — eigenvalue **magnitude** and eigenvalue **phase** — not a polynomial-projection operator.
2. It **refutes the non-normality hypothesis** [[wiki/entities/s4.md]] states as a brainstorm and T174 leans on. A diagonal matrix is normal. LRU's recurrence is diagonal throughout, and at *matched initialisation spectrum* diagonalising the dense Glorot RNN **improves** sCIFAR 72.2 → 86.5 and ListOps 50.4 → 58.8. Non-normal structure is not how a contractive system holds 16K steps; it is one way, and the more expensive one ([[wiki/empirical-tensions.md]] T311).
3. It separates **horizon** from **content of memory** into two independent knobs on the same spectrum — `|λ|` sets how long the past survives, `arg λ` sets *what kind* of function of the past is stored (local oscillation vs global average) — and shows the second one is what Path-X actually needed. The wiki's entire timescale vocabulary ([[wiki/concepts/parallel-timescale-streams.md]], G67) had only the first.
4. It is the wiki's cleanest statement of the **nonlinearity-outside-the-recurrence** design rule, with an argument rather than an observation behind it (Koopman + spectral leakage).

---

## The object

`(u_1,…,u_L)`, `u_k ∈ R^{H_in}`; state `x_k ∈ C^N`. Learnable: `ν^log, θ^log, γ^log ∈ R^N`, `B ∈ C^{N×H_in}`, `C ∈ C^{H_out×N}`, `D ∈ R^{H_out×H_in}`.

```
Λ  = diag( exp( −exp(ν^log) + i·exp(θ^log) ) )        # |λ_j| < 1 by construction
x_k = Λ x_{k−1} + exp(γ^log) ⊙ (B u_k)
y_k = ℜ[ C x_k ] + D u_k
```

Block: `Norm → LRU → GLU → skip`, six layers, exactly the S4 macro-architecture with the SSM layer swapped out. Trained with AdamW, smaller learning rate and no weight decay on the recurrent parameters.

| Parameter | Initialisation | What it controls |
|---|---|---|
| `ν^log` | `log(ν)`, `ν = −½log(u₁(r²_max − r²_min) + r²_min)`, `u₁ ~ U[0,1]` (Lemma 2) | Eigenvalue **magnitude** → memory horizon. `[r_min, r_max] = [0,1]` reproduces Glorot's spectrum exactly in the wide limit; swept up to `r_max = 0.99` |
| `θ^log` | `θ = 2πu₂` in general; **`θ ∈ [0, π/10]` for Path-X** | Eigenvalue **phase** → oscillation frequency of the implied kernel |
| `γ^log` | `log(√(1−|λ_j|²))`, element-wise | Forward-pass gain compensation |
| `B, C` | Glorot on real and imaginary parts separately, variance halved | Input/output projection |

Unrolled: `x_k = Σ_{j<k} Λ^j B̄ u_{k−j}` — a bank of `N` independent complex exponential filters. Training parallelises by associative scan; inference is `O(N)` per step.

---

## The ladder, with the numbers

Each row is the previous row plus one change, in the same 6-layer block. This is the paper's actual contribution: an ablation that is a *derivation*.

| Step | sCIFAR | ListOps | Text | Retrieval | Pathfinder | Path-X |
|---|---|---|---|---|---|---|
| RNN-`tanh` (dense) | 69.9 | 43.9 | 87.2 | 88.9 | ✗ | ✗ |
| RNN-ReLU (dense) | 69.7 | 37.6 | 88.0 | 88.5 | ✗ | ✗ |
| **1. drop the recurrent nonlinearity** → RNN-Lin | 72.2 | 50.4 | 89.1 | 89.1 | ✗ | ✗ |
| **2. diagonalise over `C`**, spectrum matched (`Λ` as Re+Im) | 86.5 | 58.8 | — | — | ✗ | ✗ |
| **3a. polar (exponential) parameterisation** | 85.4 | 60.5 | — | — | 65.4 ±9.0 | ✗ |
| **3b. + enforce stability** (`|λ| = exp(−exp(ν^log))`) | 87.2 | 59.4 | — | — | **93.5** | ✗ |
| **3c. + ring init** (tune `r_min, r_max` toward 1) | 88.1 | 59.4 | — | — | 94.4 | ✗ |
| **4. + `γ` normalisation, + small init phase** = **LRU** | **89.0** | **60.2** | **89.4** | **89.9** | **95.1** | **94.2** |
| S4D (their reproduction) | 91.5 | 60.2 | 86.4 | 89.5 | 94.2 | 97.5 |
| S5 (their reproduction) | 88.8 | 58.5 | 86.2 | 88.9 | 95.7 | 96.0 |
| S4 (paper) | 91.1 | 59.6 | 86.8 | 90.9 | 94.2 | 96.4 |

Six-task average: **LRU 86.3 vs S4 86.09.** LRU wins Text and Retrieval, loses sCIFAR and Path-X by 2.5 and 3.3.

Training speed (steps/s, A100): `tanh` RNN 2.0 → LRU 15.9 on sCIFAR (**8×**), 0.5 → 14.7 on Text (**29×**), matching S5 exactly (15.9 / 14.4) and S4D closely.

**Three readings of the ladder:**

1. **The nonlinearity is a liability, not the engine.** Removing it helps on all four measurable tasks. In a single-layer control (learn one length-100 convolution kernel), the linear RNN converges faster than `tanh` at every learning rate in the grid — so the effect is not a deep-architecture artefact.
2. **Diagonalisation is not a concession.** The wiki had been reading diagonal SSMs as a computational compromise against S4's non-normal `A`. At matched initialisation spectrum, diagonalising *raises* accuracy by 14 points on sCIFAR and 8 on ListOps, and costs 8× less time.
3. **The last two steps are the ones that carry Path-X, and they are about the forward pass, not the model class.** Steps 1–3 leave PathX unreachable. `γ` normalisation plus a phase restricted to `[0, π/10]` is the whole of the difference, and neither is expressible as an architectural claim.

---

## What LRU establishes about S4

The paper's §4 is a point-by-point dissection of what discretisation was actually buying. Each row is an ablation the authors ran on S4D, not a rhetorical claim.

| S4 feature | LRU verdict | Mechanism |
|---|---|---|
| **HiPPO initialisation** | **Not necessary** — for the first time including Path-X | Uniform on a ring `[r_min, r_max]` near 1 with restricted phase suffices. "HiPPO theory, while fundamental for the development of this field, should not be thought of as the main source of S4 success" |
| **Matrix exponential** (from exact ZOH integration) | Necessary, but **not for the reason given** | The gain is **magnitude/phase decoupling** for Adam, a diagonal preconditioner. Learning `λ*` with `θ* → π/2` under Re+Im parameterisation puts the minimiser on a non-axis-aligned landscape; polar form aligns gradients with the phase. Nothing to do with integration accuracy |
| **The `(exp(ΔÃ) − I)Ã⁻¹B̃` input multiplier** | It is a **normaliser** | First-order expansion `ΔB̃` matches performance; without the `Δ` the state grows as `O(Δ⁻¹)`. LRU's `γ = √(1−|λ|²)` is the same correction derived directly from `E|x_∞|² = 1/(1−|λ|²)` (Prop. 3) |
| **`Δ` shared between `A` and `B`** (parameter sharing) | **Not necessary** | Decoupling them into two parameters at matched initialisation does not reduce performance |
| **Small `Δ` linking eigenvalue magnitude to phase** | The **phase restriction is necessary; the linkage is not** | S4D-Lin at `Δ=1e−3` initialises `|λ| ≈ 0.9995` and `θ ∈ [0, π/8]` — a small phase, hard-coded as a side effect. LRU sets the two independently and matches |
| **Continuous-time semantics** | **Not necessary** | LRU has none, and matches. The cost is that S4's test-time resolution rescaling (`Δ` retuning, 96.30% at half sampling rate) has no LRU analogue — see Limitations |

**Net:** the success of diagonal SSMs is *linear recurrence + complex diagonal exponential parameterisation + the normalisation and initialisation that discretisation happened to induce*. The ODE story and the polynomial-projection story are scaffolding.

---

## The two knobs on the spectrum, and why Path-X needed the second

This is the part of the paper with no precedent in the wiki.

Write `λ_j = exp(−ν_j + iθ_j)`. The impulse response of channel `j` is `λ_j^k = e^{−ν_j k}(cos θ_j k + i sin θ_j k)`.

| Knob | Sets | Failure mode when wrong |
|---|---|---|
| `ν` (magnitude) | **How long** the past survives: `|x_k| ~ e^{−νk}` | Too large → vanishing gradients, no long range. Too small → forward-pass blow-up by `1/(1−r²)` (Prop. 3), training loss diverges at init |
| `θ` (phase) | **What** is stored: number of oscillations of the kernel over the sequence | Uniform `θ ~ U[0,2π]` at `L = 16k` means most channels oscillate many times over the window — each channel is then a *local average* of an oscillation pattern, not a global summary. The optimiser converges to a suboptimal minimiser at chance test accuracy and never escapes |

The Path-X evidence is the sharp form: with normalisation but uniform phase, training accuracy rises and **test accuracy stays at chance**; with normalisation plus `θ ∈ [0, π/10]`, both converge. Without normalisation, phase restriction alone does not train at all. The two are jointly necessary.

`(brainstorm)` The wiki's timescale vocabulary — G67, [[wiki/concepts/parallel-timescale-streams.md]], [[wiki/entities/ms-ssm.md]]'s stratified bands, [[wiki/entities/s4.md]]'s `Δ` — is entirely about `ν`. Every "bank of horizons" in the wiki is a partition of eigenvalue *magnitude*. LRU says the phase axis is orthogonal, hand-set, and worth the difference between chance and 94.2% on the longest task available. A stratified bank over the *joint* `(ν, θ)` measure — some bands slow-and-global, others slow-and-oscillatory — has never been built here, and the failure mode LRU names ("most state dimensions become local-oscillation averages") is exactly the one a magnitude-only stratification cannot see.

---

## Why a linear recurrence loses nothing (the expressivity argument)

Two independent arguments, both in §E.1, both figure-dependent and therefore held from prose.

**Spectral.** A linear RNN approximates any shift-invariant linear map, but cannot move energy between frequencies: sine in, scaled and shifted sine of the same frequency out. A position-wise ReLU applied to the output **leaks** energy across frequency components (Prop. 4 characterises the leakage exactly, over the ReLU's activated regions `P_i = [p_i − L_i, p_i + L_i]`). So `linear recurrence → position-wise nonlinearity → linear recurrence` is a composition where the recurrence supplies memory and the nonlinearity supplies spectral mixing, and neither has to do the other's job.

**Koopman.** Any regular nonlinear dynamical system is representable by a *linear* operator after a nonlinear reparameterisation of the observables — which is what an MLP can perform. Stacking linear RNNs with MLPs between them is therefore a modular recipe for nonlinear transition maps. The authors mark the connection as conceptual: no quantitative rate is given.

**Against them:** a single-layer linear RNN is not Turing-complete, where a `tanh`/sigmoid one is. The claim is only that *deep stacks* of linear recurrences with interleaved nonlinearity lose nothing worth having — an empirical claim on LRA, not a theorem.

---

## Comparison

| | **LRU** | [[wiki/entities/s4.md]] | [[wiki/entities/ms-ssm.md]] | [[wiki/entities/simple-cycle-reservoir.md]] | [[wiki/entities/ltc.md]] |
|---|---|---|---|---|---|
| State update | linear, LTI, **diagonal (normal)** | linear, LTI, **maximally non-normal** | linear, LTI, diagonal, `S+2` bands | linear, LTI, single ring | nonlinear rate |
| `A` obtained by | uniform draw on a ring `[r_min, r_max]`, phase `[0,θ_max]` | HiPPO, then trained | disjoint-interval draw per band | constructed, one `λ` | trained |
| Recurrent params | `2N` (`ν^log, θ^log`) + `N` (`γ^log`) | `5N` per channel | `2N` per band | **1** | `N²` |
| Continuous-time reading | **none** | native (`Δ`) | none | none | native |
| Test-time resolution change | **no** | **yes**, no retraining | no | no | native |
| Complex arithmetic | yes (avoidable, §E.3) | yes | yes | optional (`±i` signs) | no |
| LRA 6-task avg | **86.3** | 86.09 | — (91.89 on the 5-task subset) | — | — |
| Path-X | 94.2 | 96.35 | — | excluded (proved) | excluded (conceded) |
| Content-dependent read | no | no | **band selection only** (`E_t`) | no | rate only |

---

## Limitations

| Limitation | Consequence |
|---|---|
| **Still linear time-invariant** | No copying, no binding, no input-conditioned skipping, no content-addressed read. The entire content of S4's LTI boundary carries over unchanged; LRU makes S4 *simpler*, not more expressive |
| **`r_min`, `r_max`, `θ_max` are swept hyperparameters** | Three hand-set scalars per task, one of which (`θ_max`) is the difference between chance and 94.2% on Path-X and was found by hand for exactly one task. Nothing learns the eigenvalue measure — see [[wiki/architectural-gaps.md]] G67 |
| **Loses Path-X and sCIFAR to S4D by 3.3 and 2.5** | The claim is "matches", and the six-task average supports it, but on the two hardest columns the structured model is still ahead. The authors state surpassing S4 was not the goal |
| **No test-time resolution rescaling** | Deleting the continuous-time semantics deletes the one capability S4 had that nothing else in the wiki has ([[wiki/concepts/neuromodulatory-metaparameters.md]]). `Δ` is gone; there is no scalar left that re-tunes all horizons together |
| **No abstract reasoning task** | ListOps 60.2 is the closest and is again the weakest column by 29 points. Same boundary as every sequence model here |
| **Phase restriction explored on Path-X only** | The authors say they did not try it elsewhere and believe it might help. So the `θ` finding rests on one task |
| **All figures dropped** | Fig. 5 (the Path-X normalisation/phase curves), Fig. 8 (the parameterisation landscape) and Fig. 4 (impulse responses) are the visual evidence for three of this page's central claims, held from prose |
| **Only LRA** | Six tasks, one benchmark, 6-layer models, 3 seeds. No language modelling, no scaling study — where the S4 line's later weaknesses (associative recall) actually show up |

---

## Connections

- **[[wiki/entities/s4.md]]** — the model this page dissects: LRU keeps S4's macro-architecture and its LTI boundary while deleting HiPPO, discretisation, parameter sharing and non-normal structure, and matches the six-task Long Range Arena average (86.3 vs 86.09) including Path-X at 94.2% — so S4's ablation conclusion "the result is the initialisation" survives with its object replaced: what the initialisation had to supply was an eigenvalue magnitude near 1 and a *restricted phase*, and the `(exp(ΔÃ)−I)Ã⁻¹B̃` multiplier S4 inherits from ZOH is shown by first-order expansion to be a normaliser equivalent to LRU's `γ = √(1−|λ|²)` (Orvieto et al. 2023).
- **[[wiki/entities/simple-cycle-reservoir.md]]** — the same object class from the empirical end, and the resolution of its central price: SCR pays state dimension `n' ≈ (N+1)nk` to reach a *perfectly conditioned* (unitary-dilated) equivalent of any fading-memory filter, and LRU shows that at 16,384 steps a **normal, diagonal** recurrence with no dilation and `2N` recurrent parameters is not merely adequate but *better than the dense non-normal alternative at matched initialisation spectrum* (72.2 → 86.5 sCIFAR) — so the conditioning SCR buys by construction is worth having, and the discriminating experiment both pages name (compare at matched `n`) now has a cheap surrogate: LRU is the diagonal arm.
- **[[wiki/entities/ms-ssm.md]]** — the two ways to set a spectrum, on axes that do not overlap: MS-SSM stratifies eigenvalue **magnitude** into `S+2` disjoint bands and buys 25 ListOps points at fixed state, while LRU holds a single unstratified magnitude ring and buys Path-X by restricting eigenvalue **phase** to `[0, π/10]` — neither page's initialisation measure contains the other's variable, and the joint `(ν, θ)` bank neither builds is the obvious next object.
- **[[wiki/entities/ltc.md]]** — the opposite subtraction from the same starting point: LTC pushes *more* nonlinearity into the recurrence (an input-dependent rate inside the ODE) and concedes it cannot do long range, LRU deletes the recurrent nonlinearity entirely and reaches 16,384 steps, and LRU's single-layer control — learning one length-100 convolution kernel, where linear beats `tanh` at every learning rate — is the cleanest available evidence that the recurrent nonlinearity is costing optimisation speed rather than buying expressivity.
- **[[wiki/entities/transformer.md]]** — the second attention-free model to carry 16,384 steps where all 11 Transformer variants sit at chance, and the cheaper one: a bank of `N` scalar complex exponentials with `2N` recurrent parameters and no content-dependent scoring anywhere, which strengthens T179's Position B by removing the last structured component (HiPPO) that could be read as a substitute for path length.
- **[[wiki/concepts/attention.md]]** — the minimal counterexample to "long range needs content-dependent scoring": the entire recurrent core is `x_k = Λx_{k−1} + γ⊙Bu_k` with `Λ` diagonal and fixed across positions, and it matches state-of-the-art on all six Long Range Arena tasks — leaving the content-addressed *read*, not the range, as the property attention supplies and this model structurally cannot.
- **[[wiki/concepts/parallel-timescale-streams.md]]** — the axis this concept does not have: every timescale bank in the wiki partitions decay constants (`|λ|`), and LRU shows the *phase* of the same eigenvalue independently determines whether a channel stores a global summary or a local oscillation average, with a uniform phase draw at `L = 16k` producing a model that trains and generalises at chance until the phase range is cut to `[0, π/10]`.
- **[[wiki/concepts/working-memory.md]]** — a second, sharper instance of the horizon/variable separation: 16,384-step dependencies fall to `N` independent scalar exponential filters with three hand-set hyperparameters and no gate, no write, and no addressable slot — so a long horizon is now demonstrably cheap, and what remains diagnostic of working memory is holding a value against interference and reading it on demand.
- **[[wiki/concepts/three-component-framework.md]]** — the fourth slot, priced down: S4 put >15 points of validation accuracy outside architecture/learning-rule/objective and into an initialisation; LRU shows the occupant of that slot is not a structured operator but a **measure over the unit disc**, specified by three scalars (`r_min`, `r_max`, `θ_max`) — a fourth slot with three knobs is a much weaker claim than a fourth slot containing HiPPO, and it is still not in any of the three.
- **[[wiki/concepts/manifold-constrained-learning.md]]** — the geometry-is-chosen claim survives with a cheaper geometry: the state trajectory lives in the span of `N` complex exponentials whose rates and frequencies are drawn from a hand-specified product measure rather than derived from a polynomial projection of history, and the drawn version generalises as well as the derived one on five of six tasks.
- **[[wiki/concepts/latent-graph-discovery.md]]** — Path-X, the wiki's only reachability query at 16K observations, answered a second time by a fixed content-independent filter bank — and this time the filters are `N` independent complex exponentials with restricted phase, i.e. a set of *global low-frequency summaries* of the raster, which makes the "smoothing rather than walking" reading of the mechanism concrete rather than inferred from a dropped figure.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the negative result for the timescale register: LRU deletes the continuous-time semantics and with it `Δ`, the wiki's only demonstrated externally-settable global timescale knob, and matches S4 anyway — so the register is not load-bearing for long-range performance, and anything that wants it must keep the continuous-time reading for its own sake.
- **[[wiki/concepts/fast-weight-programming.md]]** — the two constant-state routes at their extremes: a linear-attention head's state is an `N×N` matrix written by outer products and read by a query, LRU's is an `N`-vector updated by element-wise multiplication with no write rule at all, and LRU is the demonstration that the second buys 16,384 steps of range for `2N` recurrent parameters — so the matrix state is paying entirely for the content-addressed read, not for the horizon.
