# Equilibrium Propagation

**If a network's dynamics are the minimisation of an energy `F_w`, then its plasticity is fixed by the same scalar: relax to equilibrium with only the input given and step *up* the energy in weight space; nudge the output toward the target, relax again, step *down*. The two-term update is `∂F/∂W` evaluated at two equilibria — local, no weight transport, no backward pass.**

> **Provenance.** Scellier & Bengio 2017 (`raw/scellier-2017-equilibrium-propagation.md`); Litman 2025, *Equilibrium Propagation Without Limits* (`raw/litman-2025-eqprop-without-limits.md`); Kerjan, Scellier & Høier 2026 (`raw/kerjan-2026-predictive-coding-imagenet-eqprop.md`). Framing inherited from Whittington & Bogacz 2019.

Why this earns a page rather than a section of [[wiki/concepts/energy-based-models.md]]. It is a **learning rule** inside a page about a model class, it carries three primary sources including the only full-ImageNet result any biologically-motivated rule has produced, and it is the substrate of the wiki's best current answer to the empty-objective gap (G30): the cost `C` is a free design variable, so a structural objective can be hung on a fixed relaxation substrate and the local rule follows automatically.

---

## The rule, and what determines it

If a network's *dynamics* are the minimisation of `F_w`, then its *plasticity* is fixed by the same scalar (Scellier & Bengio 2017; Whittington & Bogacz 2019). Relax to equilibrium with only the input given and take a step **up** the energy in weight space; clamp the output nearer the target, relax again, take a step **down**. The two-term update is `∂F/∂W` evaluated at two equilibria — local, no weight transport, no backward pass — and it is what the contrastive Hebbian rule of [[wiki/entities/boltzmann-machine.md]] already was.

| Energy | Instance | Phases |
|---|---|---|
| Hopfield energy (dissimilarity between strongly connected nodes) | continuous Hopfield nets, contrastive learning | Two |
| Free energy (bounds `log p(target \| input)`) | predictive coding, dendritic error | **One** — the free phase already sits at the global minimum, so the first term vanishes |

Two things this is worth to a builder. (i) It removes a design choice: **specify architecture + energy, and the local learning rule is derived rather than invented** — the pitch of [[wiki/concepts/energy-based-models.md]]'s formalism extended from inference to learning. (ii) It supplies a *reason* to prefer a probabilistically interpretable energy over an arbitrary one: the biologically plausible networks that perform best minimise free energy, which is exactly the case where `F` is not merely a compatibility score but a likelihood bound. That cuts against the parent page's own "not a log-probability" stance and is logged there as such.

## The original statement (Scellier & Bengio 2017)

| Object | Statement |
|---|---|
| Internal energy | `E(u) = ½Σᵢuᵢ² − ½Σ_{i≠j} W_ij ρ(uᵢ)ρ(u_j) − Σᵢ bᵢρ(uᵢ)` — the continuous Hopfield energy, `W_ij = W_ji`, `ρ` a rate nonlinearity ([[wiki/entities/hopfield-network.md]]) |
| External potential | `βC` with `C = ½‖y − d‖²`. **The target enters as a second potential energy**, not as a signal on a separate wire — `β` ("influence parameter") sets how hard it pulls |
| Total energy | `F = E + βC`; dynamics `ds/dt = −∂F/∂s`, so `dF/dt = −‖ds/dt‖² ≤ 0` and the state descends to a fixed point. The force on unit `i` is `ρ'(sᵢ)(Σ_j W_ij ρ(u_j) + bᵢ) − sᵢ` — a **leaky integrator**, i.e. the same neuron model in both phases |
| Free phase | `β = 0`: input clamped, output free, relax to `u⁰`. The prediction is read out here (`argmax_i y_i⁰`; no softmax, no normalisation over outputs) |
| Nudged phase | `β` small: the output feels `β(dᵢ − yᵢ)` and nothing else changes. The perturbation starts at the output and travels *backwards* through the hidden layers as they re-equilibrate — this propagation is what carries the error derivatives |
| Update | `ΔW_ij ∝ (1/β)(ρ(u_i^β)ρ(u_j^β) − ρ(u_i⁰)ρ(u_j⁰))`, proved `= ∇_θ J` with `J = ½‖y⁰ − d‖²` as `β → 0`, for **arbitrary symmetric connectivity** — the layered case is an illustration, not an assumption |

The general framework needs only `F`: set `E := F(β=0)` and `C := ∂F/∂β|_{β=0}`, and every other object (both fixed points, `J`, the gradient) is defined from it. **`F` is to this framework what the set of node functions is to a computational graph** — the whole model specification, with the difference that the prediction `s⁰` is defined *implicitly* by `∂E/∂s = 0` and must be found numerically, where a computational graph computes it analytically in one forward pass. That is the cost of the framework on digital hardware and the reason its authors point at analog circuits instead.

**The cost function is a free design variable, and that is the property worth taking.** In contrastive Hebbian learning and the Boltzmann machine the objective is *determined* by the energy — you may not choose it. Splitting `F = E + βC` decouples them: `C` can be anything, including a `θ`-dependent regulariser `λΩ(θ)`. **(brainstorm)** For this wiki that is the opening — a relational or graph-structured objective ([[wiki/concepts/subgraph-matching.md]], [[wiki/concepts/latent-graph-discovery.md]]) can be hung on a fixed relaxation substrate as an external potential, without redesigning the energy that defines the network, and the local learning rule follows automatically.

## Weak clamping is the whole algorithm

Every neighbouring algorithm differs from equilibrium propagation in what its *second phase* does, and each difference is a defect:

| Algorithm | Second phase | Objective | What weak clamping fixes |
|---|---|---|---|
| **Contrastive Hebbian learning** (Movellan 1990) | Output **fully** clamped — the `β → ∞` limit of the same equations | `J_CHL = E(u^∞) − E(u⁰)` | `J_CHL` can go **negative** when the free and clamped fixed points land in *different modes* of the energy landscape; the update is then inconsistent and learning deteriorates. A weakly clamped fixed point is a local perturbation of the free one, and the implicit-function theorem keeps them in the same mode |
| **Boltzmann machine / CD₁** | An independent clamped Markov chain | Log-likelihood, fixed by `E` | Two separate chains rather than one perturbation, so no backward-pass reading; `CD₁` is a biased estimator and provably the gradient of *no* objective (may cycle indefinitely — Sutskever & Tieleman 2010) |
| **Almeida–Pineda recurrent backpropagation** | Fixed-point iteration on a **linearised** copy of the network | The same `J` | The second phase is a different kind of computation from the first, so a biological substrate would need two circuits — exactly the objection that motivates the whole family |
| **Xie & Seung 2000** | Fully clamped, with feedback weights scaled by `γ^j`, `γ → 0` | CHL objective | Requires infinitesimal feedback (so the net is only nominally recurrent, behaving almost feedforward) and per-layer learning rates spanning orders of magnitude to compensate. Equilibrium propagation keeps feedforward and feedback strong and uses one learning rate |

**STDP is the mechanism, by integration rather than analogy.** Take the continuous rule `dW_ij/dt ∝ ρ(uᵢ)·dρ(u_j)/dt`, which reproduces the Bi & Poo 1998 window (see [[wiki/concepts/biologically-plausible-credit-assignment.md]]), and symmetrise it for tied weights: `dW_ij/dt ∝ d[ρ(uᵢ)ρ(u_j)]/dt`. Integrating along the second-phase trajectory from `u⁰` to `u^β` yields `ρ(u_i^β)ρ(u_j^β) − ρ(u_i⁰)ρ(u_j⁰)` — **the contrastive update is the time-integral of a spike-timing rule**, not a separate postulate that happens to resemble one. Two readings are offered and are experimentally distinguishable: either an anti-Hebbian update fires at the free fixed point and a Hebbian one at the nudged fixed point, or nothing happens in phase one and the synapse simply follows the derivative rule while the state moves.

## What it costs: the relaxation numbers

Permutation-invariant MNIST, `ε = 0.5`, `β = 1.0`, hard-sigmoid `ρ`, 0.00% training error throughout:

| Architecture | Free-phase iterations | Nudged-phase iterations | Test error |
|---|---|---|---|
| 784-500-10 | **20** | 4 | 2–3% |
| 784-500-500-10 | **100** | 6 | 2–3% |
| 784-500-500-500-10 | **500** | 8 | 2–3% |

Three things in that table. (i) **The free phase is the entire cost and it explodes with depth** — ×5 per added hidden layer, against a nudged phase growing by 2 — which is the concrete measurement behind the "iteration count does not scale" complaint on [[wiki/concepts/biologically-plausible-credit-assignment.md]] and the reason these demonstrations stop at MNIST. (ii) **The second phase is deliberately not run to equilibrium.** The leaky-integrator time constant is `τ = 1`, so `N` steps suffice for the perturbation to cross `N` layers; only the *onset* of the movement is needed, since the update integrates the path rather than reading its endpoint. (iii) Accuracy is flat in depth — extra layers buy nothing here.

Three implementation facts that the theory does not predict and a builder pays anyway: **persistent particles** (cache each training example's free fixed point and restart next epoch from it — the PCD trick, and the only reason the 500-iteration case is trainable at all); **randomising the sign of `β`** each example, which regularises (the update is sign-consistent because of the `1/β` factor); and **per-layer learning rates chosen so `‖ΔW_k‖/‖W_k‖` matches across layers**, needed despite the theory demanding a single rate — attributed to finite precision in approaching the fixed points, i.e. the theory holds exactly *at* equilibrium and the simulation is never there.

**The unpaid bill is weight symmetry.** `W_ij = W_ji` is used to derive the leaky-integrator dynamics itself, and nothing in the framework produces it. The offered hopes are all external: denoising autoencoders trained without tied weights tend to learn symmetric ones (Vincent et al. 2010); the symmetric solution minimises the reconstruction error between successive ReLU layers (Arora et al. 2015), suggesting symmetry could fall out of an *additional* autoencoder objective per layer; and feedback alignment shows forward weights can align to *random* fixed feedback (Lillicrap et al. 2016). None of these is inside the model. **(brainstorm)** The Arora route is the one to test, because it costs nothing structurally: add a per-layer reconstruction term to `E` and check whether the symmetry the dynamics assume is produced by the energy the dynamics minimise. That would make the framework self-consistent instead of self-referential.

## Finite nudging: the contrastive update is exact, not approximate (Litman 2025)

The frame above inherits two assumptions that never held: the nudge `β` must be **infinitesimal** for the update to be a gradient, and the state is a **single energy minimum**. Both are dropped by replacing the deterministic minimiser with a Gibbs–Boltzmann distribution over states.

| Object | Statement |
|---|---|
| **Objective kernel** | `F(θ,β,s) = E(θ,s) + β·ℓ(s)` — energy plus loss weighted by nudging strength `β ∈ [0,1]`; `ℓ` does not depend on `θ` |
| **State distribution** | `ρ_β(s;θ) = exp(−F(θ,β,s)/T) / Z_β(θ)`. `ρ_0` = **free** phase, `ρ_1` = **nudged** phase. `T → 0` recovers the deterministic minimiser |
| **Helmholtz free energy** | `A(θ,β) = −T log Z_β(θ)` — the statistical generalisation of `min_s F(s)`, i.e. of the parent page's `F_w(x,y) = min_z E_w(x,y,z)` |
| **Objective** | `J(θ) = A(θ,1) − A(θ,0)` — the thermodynamic work of moving the ensemble from free to target-aware. **This is what a contrastive rule actually descends** |

Two exact gradient representations, both proved with nothing but the Leibniz rule (no convexity, no unique minimum, no symmetric weights, no small `β`):

| # | Representation | Reads as |
|---|---|---|
| 1 | `∇_θ J = E_{ρ_1}[∇_θ E(θ,s)] − E_{ρ_0}[∇_θ E(θ,s)]` | **The classic contrastive Hebbian update, certified.** Two phases, local statistics, difference of expectations — and it is the *exact* gradient of `J`, for **arbitrary finite `β`**, not an approximation to anything |
| 2 | `∇_θ J = −(1/T) ∫₀¹ Cov_{ρ_β}[ℓ(s), ∇_θ E(θ,s)] dβ` | The same gradient as a **path integral of loss–energy covariance** along the nudging path. Classical equilibrium propagation is the first-order Taylor expansion of this integral around `β = 0`; learning means making high-loss states anti-correlate with `θ`-sensitive states |

What the "bias" of a large nudge actually is (Theorem 5.1):

```
J(θ) = E_{ρ_1}[ℓ(s)]  +  T · KL(ρ_1 ‖ ρ_0)
```

— residual loss in the nudged phase **plus** a divergence penalty between the two phases, with `J(θ) ≤ E_{ρ_0}[ℓ(s)]` (a lower bound on the supervised loss, tight, and zero exactly when the supervised loss is zero for non-negative `ℓ`). So finite nudging is not a corrupted gradient of the supervised loss; it is a clean gradient of a **regularised** one, whose regulariser forces the free dynamics to emulate the nudged phase — supervision distilled into the network's spontaneous behaviour rather than transported into it. The temperature `T` is the regularisation coefficient.

**The empirical inversion.** Fashion-MNIST, one hidden layer of `tanh` units, only the learning rule and `β` varied:

| Rule | Test accuracy | Note |
|---|---|---|
| Infinitesimal equilibrium propagation (`β = 0.01`) | **20–30% — fails, near chance** | The regime the theory was built for |
| Finite-nudge (`β = 1.0`) | ~80% | Tracks the baseline |
| Discrete path-integral variant (representation 2) | ~80% | Tracks the baseline |
| Backpropagation | ~80% | Reference |

Mechanism: the signal-to-noise ratio of the state perturbation `Δs = s_β − s_0` is **indistinguishable from sampling noise for `β ≲ 10⁻²`** and improves by an order of magnitude as `β → 1`; cosine similarity of the update with both `∇L_sup` and the Monte-Carlo `∇J_β` rises monotonically from ~0 at `β ≈ 10⁻³` to ~0.5 at `β = 1`. **The infinitesimal limit is not a safer approximation, it is an unusable one** — the quantity being differenced is smaller than the noise floor of the sampler that measures it.

Three consequences, two of them for [[wiki/concepts/energy-based-models.md]]. (i) The zero-temperature `min_z` elimination in that page's formalism table is a *limit*, not the definition; at finite `T` the free energy is the right object and the contrastive rule is its exact gradient. (ii) This is a sample-contrastive method whose second term is nevertheless not a sample-placement problem in the usual sense — the "contrastive sample" is the model's own nudged equilibrium, so the exponential-in-`dim(y)` cost of the parent page's contrastive-methods table is replaced by the cost of sampling `ρ_β`. (iii) It supplies a second, independent argument for a probabilistically interpretable energy: `A` is a log-partition function, so the free-energy preference recorded above stops being an empirical observation and becomes a definition.

## ImageNet at 13.23% top-5: the relaxation cost is a property of the energy, not of the framework (Kerjan et al. 2026)

> `raw/kerjan-2026-predictive-coding-imagenet-eqprop.md` — Kerjan, Scellier & Høier (Rain AI), 2026. First demonstration of **either** equilibrium propagation **or** a predictive-coding network at full-size ImageNet (1.28M images, 224×224, 1000 classes).

Every equilibrium-propagation number above stops at MNIST, and the "free phase is the entire cost and it explodes with depth" table is why. That table is a fact about the **Hopfield** energy, not about equilibrium propagation. Swap in the predictive-coding energy

```
E_PCN(θ, x, h) = ½ Σ_{k=1..L} ‖h_k − f_k(θ_k, h_{k−1})‖²
```

and the free equilibrium is the *unique global minimum* with `E = 0`, reached by **one forward pass** — the 20/100/500-iteration column collapses to 1 at every depth. The nudged phase is the only iterative part, and its cost is `K ≈ L` iterations, not `5^L`. This is the row the framework table at the top of this page already had ("free energy … one phase — the free phase already sits at the global minimum") turned into the reason the method scales.

| Result (VGG10, full ImageNet, 50 epochs) | Top-1 | Top-5 |
|---|---|---|
| Equilibrium propagation, centered scheme | 33.81 | **13.23** |
| Equilibrium propagation, random scheme (single equilibrium) | 34.73 | 14.02 |
| Backpropagation baseline | 32.35 | 12.20 |
| *Prior best for a predictive-coding net* (Qi et al. 2025, Tiny ImageNet: 13× fewer images, 12× smaller, 5× fewer classes) | 44.69 | 20.70 |
| *Prior best for equilibrium propagation* (Nest & Ernoult 2024, ImageNet 32×32) | 54.0 | 30.0 |

The gap to backpropagation is **~1 point of top-5 error**, and 13.23% beats AlexNet's 15.3%. Adding strided 1×1 skip connections (VGG10Skip) changes nothing (13.32% vs. 12.1%).

**Four things a builder should take from it.**

| # | Finding | Why it matters here |
|---|---|---|
| 1 | **Nudging beats clamping, and the margin appears only when the task is hard.** On CIFAR-100 the two are indistinguishable; on ImageNet 32×32 cross-entropy-nudging is far ahead of both mean-squared-error nudging and clamping | Clamping (`h_out^β = (1−β)h_out⁰ + βy`, O'Reilly 1996) defines **no cost function**, so its update is the gradient of nothing even as `β → 0`. The claim above that "the cost function is a free design variable, and that is the property worth taking" now has its price tag: on ImageNet 32×32, choosing cross-entropy over mean-squared error moves top-5 error 55.9 → 36.6 |
| 2 | **The finite-difference scheme barely matters.** Centered, random and backward are all competitive at ImageNet scale — contradicting Laborieux et al. 2021, where the centered scheme's `O(β²)` bias reduction was the headline | For a predictive-coding energy `∂F/∂θ` **vanishes at the free equilibrium**, so the random/backward update needs only the *nudged* state: `∇_θC ≈ (1/β)·∂F_PCN/∂θ(θ, β, h_β⋆)`. **One equilibrium, one phase, half the wall-clock** (10 days vs. 18 on a single A100), and no free-phase measurement to store or compare against — which is the phase-control objection (objection 6 on [[wiki/concepts/biologically-plausible-credit-assignment.md]]) partly dissolved rather than answered |
| 3 | **`β` can be tiny.** Error rate is flat for `0.0002 ≤ β ≤ 0.1` and `K ≥ 4`; the optimal `K` is *the number of layers*, i.e. exactly the time for the perturbation to travel output → input (two layers per iteration under the even/odd asynchronous traversal) | Directly contradicts the Litman 2025 result above, where `β = 0.01` was near chance — see T120. It also makes `K` a **derived** hyperparameter: nudge for as many steps as the network is deep |
| 4 | **The nudged state is not a minimum of `F`.** Equilibration curves spike and settle at `ΔF > 0` relative to the free equilibrium; the dynamics are better read as fixed-point iteration onto a *critical point* of `F` | Equilibrium propagation only ever needed the first-order condition `∂F/∂h = 0`. The wiki should stop describing the second phase as "settling into a lower-energy state" — a saddle serves |

**The nudged dynamics, written out** (what actually runs, and it is not gradient descent as usually pictured): projected gradient descent with step size `α = 1` on `F_PCN` makes the `h_k` terms cancel, leaving `h_k ← ReLU(f_k(θ_k, h_{k−1}) + ∂ε²_{k+1}/∂h_k)` — bottom-up prediction plus top-down error, one line, no learning rate. Two deviations were needed to make it work at depth: **asynchronous traversal** (update even-indexed layers, then odd — synchronous updates diverge, as in deep Boltzmann machines), and **mod-PGD**, `h_k ← ReLU(a_k + ∂ε²_{k+1}/∂h_k)` using the *pre-activation* `a_k` rather than `ReLU(a_k)`. The difference bites in one quadrant only: with plain projected gradient descent, a unit whose bottom-up drive is inhibitory (`a_k < 0`) *ignores* that inhibition when the top-down error is positive; mod-PGD lets the negative drive act as an **inhibitory buffer**, so a bottom-up-suppressed unit stays silent unless top-down evidence is strong. Tempering top-down signals this way keeps the nudged state near the free one — and is the difference between training and diverging to NaN on CIFAR-10 at `K = 5`. **(brainstorm)** This is a precision-weighting mechanism arrived at empirically: it is the same "how much should top-down override bottom-up" knob that [[wiki/concepts/predictive-coding-free-energy.md]] parameterises as `Σ`, discovered here as a projection rule rather than a variance.

**What the result does *not* buy.** Equilibrium propagation cost 18 days on one A100 against 36 hours for backpropagation — ~12× wall-clock for ~1 point of accuracy, in a setting with **no hardware payoff**, since the authors are explicit that it is unknown whether `F_PCN` and the mod-PGD dynamics can be realised physically at all. The result is an argument about *the framework*, not a proposal: it decouples "equilibrium propagation does not scale" from "the physical networks people run equilibrium propagation on do not scale", and lands the blame on the second. And it sharpens the identifiability line — EP tracks backpropagation under every variation of batch size, cost function and initialisation gain tested, so **the learning algorithm is the least load-bearing choice in the pipeline** ([[wiki/concepts/objective-identifiability.md]]).

---

---

## Open problems

- **The finite-nudge result buys exactness and pays in sampling.** Both gradient representations are expectations under `ρ_β`; nothing bounds the mixing time of the sampler that estimates them, and the ruggedness that makes the landscape a memory is what makes the sampler slow. The theory removed the convexity assumption and moved the difficulty into the estimator.
- **The path-integral representation is a free hyperparameter in disguise.** How many `β` quadrature points, and where, is unspecified; the demonstration uses a "discrete path-integral variant" without a rule for choosing the discretisation.
- **`T` is the regularisation coefficient and nobody sets it.** It multiplies `KL(ρ_1‖ρ_0)` in the decomposition, so temperature trades supervised fit against how far the free phase may sit from the nudged one — the same untuned knob [[wiki/entities/boltzmann-machine.md]] flags, now with a stated role.
- **Weight symmetry is unpaid.** `W_ij = W_ji` is used to derive the leaky-integrator dynamics itself and nothing in the framework produces it; every offered route (denoising autoencoders, the Arora per-layer reconstruction argument, feedback alignment) is external to the model.
- **The two `β` results contradict each other.** `β = 0.01` is near chance in Litman 2025 and inside the flat optimum in Kerjan et al. 2026 ([[wiki/empirical-tensions.md]] T120); the energy differs between them, which is the leading suspect and has not been tested.
- **No hardware payoff has been demonstrated.** The scaling argument is about the framework; whether `F_PCN` and the mod-PGD dynamics can be realised physically at all is stated as unknown, and on digital hardware the method costs ~12× wall-clock for ~1 point of accuracy.

---

## Connections

- **[[wiki/concepts/energy-based-models.md]]** — the parent formalism: this rule is what that page's `F_w` implies for plasticity once the same scalar that defines inference is also read in weight space, and the finite-temperature result here promotes its `min_z` elimination from definition to zero-temperature limit.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — the family this rule belongs to and the objections it partly answers: no weight transport and no separate backward circuit, at the price of an iteration count that the relaxation table here measures, and with the phase-control objection dissolved rather than answered by the single-equilibrium scheme.
- **[[wiki/concepts/synaptic-plasticity.md]]** — supplies the local mechanism by integration rather than analogy: the contrastive update is the time-integral of a spike-timing rule along the second-phase trajectory, so the rule is not a separate postulate that happens to resemble STDP.
- **[[wiki/entities/boltzmann-machine.md]]** — the neighbouring algorithm whose second phase is an independent clamped Markov chain rather than a perturbation of the free state, which is why `CD₁` is the gradient of no objective while weak clamping is the exact gradient of a regularised one.
- **[[wiki/entities/hopfield-network.md]]** — the energy the original statement uses, and the one that makes the method look unscalable: its free phase costs ×5 iterations per added hidden layer, which is a fact about this energy and not about the rule.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the energy that rescues the scaling, and a mechanism arrived at twice: `E_PCN` has its free equilibrium as the unique global minimum reached in one forward pass, and mod-PGD's inhibitory buffer is that page's `Σ` knob discovered as a projection rule rather than as a variance.
- **[[wiki/concepts/objective-identifiability.md]]** — the sharpest negative reading of the ImageNet result: this rule tracks backpropagation under every variation of batch size, cost function and initialisation gain tested, which makes the learning algorithm the least load-bearing choice in the pipeline.
- **[[wiki/concepts/latent-graph-discovery.md]]** — why the free cost function matters here: a relational or graph-structured objective can be hung on a fixed relaxation substrate as an external potential `βC`, without redesigning the energy that defines the network.
- **[[wiki/concepts/subgraph-matching.md]]** — the concrete candidate for that external potential: a structural matching score is exactly the kind of `C` that contrastive Hebbian learning and the Boltzmann machine may not choose and this decomposition may.
