# Simple Cycle Reservoir (SCR) — universality of a one-parameter recurrent architecture

**A reservoir whose entire recurrent matrix is one number: units wired in a single ring, every ring edge carrying the same weight `λ ∈ (0,1)`, and every input weight drawn from `{−1,+1}`. Li, Fong & Tiňo (2024) prove — constructively — that this architecture approximates *any* linear reservoir system, and hence any time-invariant fading-memory filter, to arbitrary precision.**

The wiki's first universality theorem for a *constrained* architecture, and the sharpest available statement of what architecture does and does not buy. Every other recurrent design here is argued for on the grounds that its structure is the right structure; this result says that for the whole class of fading-memory filters, structure in the recurrent coupling is **free to throw away** — the expressive power relocates into state dimension and into the readout.

---

## The object

| Component | Definition (Li et al. 2024, Def. 1) |
|---|---|
| System | `R := (W, V, h)`, dimensions `(n, m, d)` |
| Dynamics | `x_t = W x_{t−1} + V c_t`, `y_t = h(x_t)` — **linear** state update, all nonlinearity in the readout |
| `W` | `n×n` dynamic coupling, strictly contractive `‖W‖ < 1` (operator norm) |
| `V` | `n×m` input-to-state coupling, **fixed, untrained** |
| `h` | `C^n → C^d`, continuous, **the only trained part** |
| Input | `{c_t}_{t∈Z⁻} ⊂ C^m`, uniformly bounded `‖c_t‖ ≤ M` |
| Solution | `x_t(c) = Σ_{k≥0} W^k V c_{t−k}` — a convolution of the input history with the powers of `W` |

Contractive `W` + bounded input ⇒ the reachable set `X ⊂ C^n` is compact ⇒ `h` is uniformly continuous on it. That single fact is the engine of every proof: any perturbation of the *state* trajectory below `δ` is a perturbation of the *output* below `ε`.

### The constrained families

| Family | `W` | `V` | Note |
|---|---|---|---|
| **SCR** | `λP`, `P` a full-cycle permutation (left circular shift) | `∈ M_{n×m}({−1,+1})` | Rodan & Tiňo's (2010) minimum-complexity reservoir, in linear form |
| **C-SCR** | `λP`, same | entries `∈ {±1, ±i}` | The complex-domain relaxation |
| **Multi-Cycle Reservoir, order `k`** | block-diagonal, `k` contractive full-cycle blocks `W_1…W_k` | `∈ M_{n×m}({−1,+1})` | Readout acts on a mixture `h(Σ_i a_i x^{(i)})`, `a_i ∈ C` |
| **SMCR** | as above with **`k` identical blocks** | same | Attractive for hardware: one physical ring, replicated |
| **Twin SCR** | Multi-Cycle of order **2** | same | The minimal fix for real-valued `±1` input weights |

Degrees of freedom in the recurrent coupling, in all four cases: **one scalar `λ`** (which equals `‖W‖`, hence also the spectral radius, since `P` is unitary). Plus the state dimension `n`.

---

## The theorem chain

Each arrow is `ε`-closeness of **outputs for every input stream**, not state isomorphism — Li et al. explicitly weaken equivalence from the (iso)morphism used in Grigoryeva & Ortega (2021) to *same inputs → same outputs*. That weakening is what makes the whole chain possible.

| # | Step | Mechanism | Price in dimension |
|---|---|---|---|
| Thm 11 | any contractive `W` → `W' = λU`, `U` **unitary** | **Egerváry dilation**: choose `N` with `2M‖V‖ λ^{N+1}/(1−λ) < δ`, then there is an `(N+1)n × (N+1)n` unitary `U` with `W₁^k = J*U^k J` for all `1 ≤ k ≤ N` (`W₁ = W/λ`, `J` the canonical embedding). Tail terms `k > N` are bounded by `λ^k` and fall inside `δ` | `n → (N+1)n`, with `N ~ log(1/δ)/log(1/λ)` |
| Prop 12 | similarity ⇒ equivalence | `W' = S⁻¹WS`, `V' = S⁻¹V`, `h'(x) = h(Sx)` — **exactly** the same outputs. Basis change is free | none |
| Prop 13 | unitary → cyclic permutation | An `ℓ×ℓ` full-cycle permutation is unitarily equivalent to `diag(R_ℓ)`, the complete set of `ℓ`-th roots of unity. So *perturb* `U`'s eigenvalues onto a subset of `R_{n₁}` and **direct-sum in a diagonal block carrying the missing roots** | `n → n₁ > n` |
| Thm 14 | ⇒ `W_c = λP` contractive full-cycle, `‖W_c‖ = ‖W‖` | Prop 13 then Prop 12 | as above |
| Lem 16 | `nk × nk` block-circulant of a full-cycle `P` is itself full-cycle **iff `gcd(n,k) = 1`** | number-theoretic; Example 1 shows `n=2, k=3` failing without it | `n → nk` |
| Lem 17 / Cor 19 | any real (resp. complex) `V` ≈ `(1/N) Σ_{j=1}^{k} F_j` with `F_j ∈ M({−1,1})` (resp. `M(±1) ∪ M(±i)`), `gcd(k,n)=1` | `M_{n×m}` has a basis of sign matrices; write `V = Σ a_i E_i` and quantise the coefficients. Remark 18: `k > k₀ = Σ|b_i| > nm` | `n → nk`, `k > nm` |
| **Thm 15** | any `R` ≈ **SMCR** | Thm 11 + 14 + 16 + 17 | product of the above |
| **Thm 20** | any `R` ≈ **C-SCR** (a *single* ring) | Thm 11 + 14 + 16 + Cor 19 | product of the above |
| **Thm 21** | any `R` ≈ **Twin SCR** | split `V = V_r + iV_i`, apply Lem 17 to each part, run two rings in parallel on the same input | product, ×2 blocks |
| **Thm 22** | **any time-invariant fading-memory filter** over uniformly bounded inputs ≈ SMCR / C-SCR / Twin SCR with polynomial readout | compose with Grigoryeva & Ortega (2018a) Cor. 11: linear reservoirs with polynomial readouts are universal. `h'` is `h` with linearly transformed domain, so it stays a polynomial of the **same degree** | — |

Two structural facts about the chain worth keeping:

- **`λ` is invariant along it.** `‖W‖ = ‖W'‖` at every step. The one free recurrent parameter of the approximant is *read off* the target, not searched.
- **Everything is constructive.** Given a target linear reservoir, the approximating ring is written down. This is the wiki's only case of an architecture being **derived rather than searched** ([[wiki/architectural-gaps.md]] G29).

---

## What this costs, and where the expressivity went

The theorem is not "structure does not matter". It is an **exchange rate**: structure in `W` can be bought with state dimension.

```
n' ≈ (N+1) · n · k ,     N ~ log(1/δ)/log(1/λ) ,     k > n·m
```

- The dilation factor `(N+1)` is the **memory depth** being made explicit — Egerváry's construction is literally a shift register appended to `W`, so the price of a unitary (hence lossless, non-contracting-in-direction) coupling is storing `N` past states.
- The factor `k > nm` is the price of **quantising the input weights to signs**: a real number is recovered as an average of `k` sign matrices, and each replica needs its own ring.
- The readout `h` is *unchanged in kind* (same degree polynomial, linearly transformed domain). Task-specific content never migrates into the recurrent part.

**The reading for architecture design.** Three architectures that differ visibly (one complex ring; two real rings; `k` identical real rings) are all universal, with one tunable recurrent parameter each. So **universality does not discriminate architectures**, and any argument of the form "this recurrent topology is the right one *because* it can express X" is empty for any X inside the fading-memory class. What is left to argue about is: sample efficiency, conditioning, the size of `n` needed at a given `ε`, and whether the target is inside the class at all.

---

## The boundary of the claim — and why it is the interesting part

Universality here is **over time-invariant fading-memory filters over uniformly bounded inputs**. Fading memory (FMP) is a *continuity* requirement: two inputs with similar recent histories must give similar present outputs, formalised by continuity in a weighted sup-norm `‖c‖_w = sup_t ‖w_t c_t‖` with `w` strictly decreasing into the past. The systems here satisfy the stronger `λ`-exponential FMP, `w_t = e^{λt}`.

Abstract reasoning is, characteristically, **outside this class**:

| Reasoning requirement | Why FMP excludes it |
|---|---|
| Variable binding held over an arbitrary interval | The bound value's influence must **not** decay; FMP requires it to |
| A rule inferred at step 1 applied at step 10⁶ | Same — exponential forgetting with rate `λ` is built into `x_t = Σ_k W^k V c_{t−k}` |
| Discrete state (a counter, a stack, an open bracket) | Two inputs agreeing on recent history but differing in deep past must produce *different* outputs — the exact negation of FMP |
| Chaotic / non-contracting dynamics | `ρ(W) < 1` is equivalent to the echo state property for linear reservoirs (Grigoryeva & Ortega 2021, Prop. 4.2(i)); leaving it leaves the theorem |

So the same paper that makes reservoir architecture look free also draws a **formal line under the whole family**: no `ρ(W) < 1` recurrent system — reservoir, echo state network, or any linear state-space model in the same regime — can carry a dependency that does not decay, no matter how it is wired or how wide it is. Enlarging `n` buys a longer `λ`-exponential horizon, never a non-fading one.

This retro-illuminates a measurement the wiki already holds: variance-HAG ([[wiki/entities/hag-reservoir.md]]) grows reservoirs whose spectral radius lands at **1.24, 2.89, 1.99** on three datasets, held stable only by a saturation rescaling. Read against Thm 22, the grown networks that most improved classification did so by **leaving the class the universality theorem covers** — which is either the most interesting thing in that paper or an artefact of the rescaling, and nothing measures which. `(brainstorm)`

---

## Comparison

| | SCR / C-SCR / Twin SCR | Random ESN | [[wiki/entities/hag-reservoir.md]] | [[wiki/entities/kan-ode.md]] |
|---|---|---|---|---|
| Recurrent coupling | Ring, one weight `λ` | Random dense/sparse, fixed | **Grown** from data, symmetric, excitatory | Learned continuous-time vector field |
| Free recurrent parameters | **1** | `n²` (unsearched) | edge set, by local rule | all, by gradient |
| Expressivity claim | **Proved universal** over fading-memory filters | Existential universality (Grigoryeva & Ortega 2018a,b) | none | universal approximation of the ODE right-hand side |
| How the architecture is obtained | **Constructed** from the target | Sampled | Searched, one unsupervised pass | Fixed; values learned |
| Where nonlinearity lives | Readout only (polynomial suffices) | Reservoir (`tanh`) + linear readout | Reservoir (`tanh`) | Vector field |
| Nonfading dependencies | Excluded by `‖W‖ < 1` | Excluded by ESP | `ρ(W) > 1` empirically, unanalysed | Not excluded in principle |

---

## Limitations

| Limitation | Consequence |
|---|---|
| **Linear state dynamics throughout** | Every theorem is about `x_t = Wx_{t−1} + Vc_t`. Practical ESNs use `tanh`; nothing here transfers to them directly, and the empirical SCR results being "supported" (Rodan & Tiňo 2010; Wang et al. 2019) are nonlinear-reservoir results |
| **No rate** | Purely existential in `n'`: the constructions give a dimension for each `ε`, but no lower bound and no claim that `n'` is anywhere near minimal. `k > nm` is a *sufficient* replication count, and Remark 18 concedes it is typically much larger |
| **`ε`-closeness is uniform over inputs but says nothing about learnability** | The readout is claimed trainable and is fitted in practice by ridge regression, but the theorem is about which functions are representable, not which are recoverable from finite data at a given conditioning of the `n'`-dimensional state |
| **Universality is the weakest possible architectural virtue** | Precisely what this paper demonstrates: it holds for three visibly different designs at once, so it cannot be used to *choose* |
| **No experiments** | Pure theory. Whether a constructed C-SCR approximant of a fitted ESN performs comparably at comparable `n` is untested |

---

## Why this matters for a reasoning model

- **It removes an argument, which is worth more than adding one.** The wiki repeatedly reaches for architecture as the heaviest design lever ([[wiki/architectural-gaps.md]] G16, G29). This result says that *within a stated function class*, the recurrent-connectivity part of that lever is a no-op — anything reachable is reachable from a ring. The lever therefore has to be justified by something other than expressivity: conditioning, dimension needed, sample efficiency, or membership of the class.
- **It gives a criterion for when to stop caring about recurrent topology.** Ask whether the target dependency fades. If it does, the topology is a free choice and `λ` plus `n` are the only knobs. If it does not, *no* choice inside the contractive family works and the architecture question is a different one entirely — gating, discrete state, or an addressable store ([[wiki/concepts/working-memory.md]], [[wiki/entities/differentiable-neural-computer.md]]).
- **It is the wiki's cleanest instance of "capacity is dimension, structure is convenience".** The whole proof is an exchange of connectivity richness for width, at an explicit rate. That is the same currency [[wiki/concepts/retrieval-capacity.md]] trades in (dimension bounds *which questions can be asked*), and the opposite sign from T75's warning that expansion past a tipping point erodes class structure — here expansion is exactly what *pays for* the structural simplification. Both cannot be the whole story; see [[wiki/empirical-tensions.md]] T174.
- **(brainstorm) The dilation step is a shift register, and this may be the point.** Egerváry's `U` is `W` in the corner plus an explicit `N`-deep delay line. If the price of a "structureless" recurrent coupling is exactly the memory it had to be storing anyway, then the theorem is quietly saying that a fading-memory recurrent network *is* a tapped delay line with a learned readout — which is the "trade time for space" approach the paper's own introduction contrasts recurrence against (auto-regressive models, transformers). The two approaches meet at the constructive proof.
- **(brainstorm) A one-parameter recurrent core is an architecture that can be *scheduled*.** If the entire dynamic coupling is `λ`, then a controller that sets `λ` sets the memory horizon of the whole reservoir with one scalar — a neuromodulatory-style timescale register ([[wiki/concepts/neuromodulatory-metaparameters.md]]) with a proved guarantee that no expressivity is lost at any setting. Multi-cycle reservoirs with **different** `λ` per block would then be a bank of horizons with a mixture readout `h(Σ a_i x^{(i)})`, which is the architecture the paper defines (Def. 7, non-identical blocks) and never exploits.

---

## Connections

- **[[wiki/entities/hag-reservoir.md]]** — the same substrate with the opposite thesis and the opposite lever: HAG *grows* the recurrent graph because a random fixed one is "the antithesis of the optimal", while this proves a ring with one weight loses nothing expressively; the two are compatible only if what growth buys is conditioning, effective dimension or sample efficiency rather than representable functions ([[wiki/empirical-tensions.md]] T174), and HAG's best variant reaches `ρ(W) ≈ 2.89`, i.e. outside the class this theorem covers.
- **[[wiki/architectural-gaps.md]]** — bears on G29 from the other side: architecture here is neither searched nor hand-built but **constructed** from a target system in closed form, which is an existence proof that the architecture lever can be mechanised — and simultaneously narrows what the lever is worth, since three different constructions are equally universal.
- **[[wiki/concepts/three-component-framework.md]]** — a maximally clean separation of the three slots: architecture is one scalar, the learning rule is ridge regression on a linear readout, and the objective is squared error, yet the triple is universal over a whole function class. It is the wiki's strongest case that the slots are not equally load-bearing, and that "which architecture" can be the *cheapest* of the three questions rather than the most expensive.
- **[[wiki/concepts/working-memory.md]]** — the formal complement: fading memory is exactly the property a working-memory mechanism exists to violate, and this page supplies the theorem that says a contractive recurrent network cannot supply it by any wiring or width.
- **[[wiki/concepts/attractor-dynamics.md]]** — the contractive regime `‖W‖<1` has a single global fixed point driven by input, i.e. no multistability at all; the ring coupling `λP` is that page's `J^A` (antisymmetric/traversal) half in its purest form — pure rotation with uniform decay, no `J^S` and hence no stored states.
- **[[wiki/concepts/retrieval-capacity.md]]** — the same currency: both convert an architectural or representational demand into a required dimension, and both find dimension monotonically good, against T75's tipping-point result.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — expansion recoding given a second, non-statistical justification: dimension is what *pays for* constraining the recurrent coupling to a ring and the input weights to signs, independently of any Cover's-theorem separability argument.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the timescale question stated as a single parameter: `λ` sets an exponential memory horizon and Def. 7's non-identical multi-cycle blocks give a bank of horizons read out by a linear mixture, which is the crudest possible temporal hierarchy and the one with a universality guarantee attached.
- **[[wiki/entities/kan-ode.md]]** — the other end of the fixed-vs-learned-dynamics axis: KAN-ODE learns and then *reads* the transition function, while SCR fixes the transition function to a rotation and proves the readout can absorb whatever the dynamics were, so interpretability of the state update and expressivity of the system are decoupled.
- **[[wiki/entities/spiking-neural-networks.md]]** — the deployment argument the constraint exists for: a ring of identical weights with `±1` input signs is realisable on photonic and delay-line neuromorphic substrates with no weight storage at all, and the paper's contribution is that this costs no expressivity, only device count.
- **[[wiki/entities/ltc.md]]** — the direct counterpart on both claims: LTC also proves universality, states in print that universality "does not yield a concrete measure on where the separation is between different neural network architectures", and answers with trajectory-length lower bounds that *do* separate Neural ODE / CT-RNN / LTC ([[wiki/empirical-tensions.md]] T175, with the confound that a stiff LTC buys up to 133× more solver steps) — while independently confirming the boundary drawn here, since a learned input-dependent rate is still bounded by `τ_sys ≤ τ` and its authors concede vanishing gradients and no long-term dependencies, so the exclusion list survives outside the linear class it was proved in.
- **[[wiki/entities/cfc.md]]** — a third independent confirmation of the exclusion list from outside the linear class: removing the integrator from a liquid continuous-time model changes its cost by up to five orders of magnitude, fixes irregular sampling outright (event-based XOR, which ODE-RNNs fail *for every solver*), and moves long-range dependence not at all — the authors recommend an LSTM wrapper. The fading-memory boundary is insensitive to whether time is integrated or evaluated in closed form.
- **[[wiki/entities/s4.md]]** — the same object class from the opposite end, and the page that prices what this one leaves open. S4's state update is `x_k = Āx_{k−1} + B̄u_k` with all nonlinearity outside the recurrence, and its Lemma 3.1 is this page's Prop. 12 verbatim — but S4 finds that the state matrices worth having are **maximally non-normal** (the HiPPO matrix's diagonaliser has entries up to `2^{4N/3}`, making exact diagonalisation numerically infeasible), and escapes by splitting off a rank-1 correction rather than by dilating to a unitary. Two consequences: (i) the exclusion list here survives untouched, but its practical corollary does not — a fading-memory model carries a 16,384-step dependency (Path-X 96.35%) at `N` in the tens, so what governs the usable horizon inside the class is the *spectrum and its conditioning*, the quantity [[wiki/empirical-tensions.md]] T174/T175 name as unmeasured; (ii) this page's closing brainstorm — a one-parameter recurrent core is an architecture that can be *scheduled* — is demonstrated, with `Δ` retuned at test time for a 0.5× sampling-rate change at no accuracy cost (Gu et al. 2022).
