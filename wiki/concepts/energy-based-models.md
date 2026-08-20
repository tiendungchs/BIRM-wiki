# Energy-Based Models

**Treat a scalar compatibility function `F(x, y)` as the fundamental object — low energy where `x` and `y` go together, high energy elsewhere — and never require it to be a normalised probability. Inference is minimisation over the unobserved variables; reasoning is the same minimisation with the unobserved variables interpreted as actions.**

> **Provenance.** LeCun 2022, *A Path Towards Autonomous Machine Intelligence* (`raw/lecun-2022-autonomous-machine-intelligence.md`), §4.1–4.5, §3.1.4, §8.3.3. The architecture built on this formalism is [[wiki/entities/h-jepa.md]].

The load-bearing move for this wiki is the **refusal to predict**. An implicit function `F(x, y)` says *whether* a `y` is compatible with an `x`; an explicit predictor must *produce* the `y`. When the set of compatible `y` is a manifold, an infinite set, or a union of both, only the implicit form is representable at all. Every place the wiki has said "the future is not a function of the past" — multi-modal transitions, exogenous edge drivers, aleatoric uncertainty — is a place where the explicit form is the wrong object.

---

## The formalism

| Object | Statement |
|---|---|
| **Energy** | `F_w(x, y)` — scalar, low iff `x` and `y` are compatible. Not a log-probability; no partition function, no normalisation |
| **Latent variable** | `z` — the information about `y` not extractable from `x`. Parameterises *which* relationship holds between `x` and a compatible `y` |
| **Latent-variable EBM (LVEBM)** | `E_w(x, y, z)`; inference is `ž = argmin_{z ∈ Z} E_w(x, y, z)` |
| **Elimination of `z`** | `F_w(x, y) = min_{z ∈ Z} E_w(x, y, z)` — technically a zero-temperature free energy |
| **Training** | Find `w` such that `F_w(x, y) < F_w(x, ŷ)` for `ŷ ≠ y`. Pushing the data energy *down* is trivial; the whole problem is pushing everything else *up* |

**Worked latent:** `x` is a car approaching a fork, `y` the same car seconds later. The latent is one bit — left or right. `x` a photo of a scene, `y` the same scene from another viewpoint: the latent is the camera displacement, and inference *is* recovering the motion that explains one view from the other.

---

## Collapse: the failure mode that types the architecture

Without a provision pushing up on non-data `y`, the landscape goes flat — every `y` gets the same energy and the model has learned nothing. **Which architectures can collapse is a structural property, not a training accident:**

| Architecture | Collapses? | Mechanism |
|---|---|---|
| Deterministic prediction / regression | **No** | One `y` per `x`; the distance `D(y, ỹ)` guarantees a unique minimum. Also the reason it cannot represent multi-modality |
| Generative latent-variable (`ỹ = Dec(s_x, z)`) | **Yes** | If `z` has as many dimensions as `y`, every `y` is reachable at zero energy |
| Auto-encoder | **Yes** | If `dim(s_y) ≥ dim(y)`, the identity function reconstructs everything |
| Joint embedding (two encoders, energy = `D(s_x, s_y)`) | **Yes** | Encoders emit a constant: `s_x = s_y` for all inputs, zero energy everywhere |

**The generalisation:** collapse is *excess information capacity in whatever variable is free*. Rows 2–4 are the same defect located in `z`, in `s_y`, and in the encoders. That gives an anti-collapse recipe per architecture — restrict `z`'s capacity, restrict `s_y`'s capacity, maximise the encoders' information content — and it is why the training criteria of [[wiki/entities/h-jepa.md]] come in exactly four parts.

---

## Contrastive vs. regularised: the wiki's sharpest scaling argument

Two families of loss shape the landscape. They are compatible and can be used together; the source argues one of them does not scale.

| | **Contrastive** | **Regularised (non-contrastive)** |
|---|---|---|
| Mechanism | Push down on `F(x, y)`, pull up on `F(x, ŷ)` for hallucinated contrastive `ŷ` | Push down on `F(x, y)`, and add a term that **minimises the volume of `y`-space assigned low energy** — "shrink-wrapping" the data manifold |
| Loss forms | Hinge with margin `[F_w(x,y) − F_w(x,ŷ) + m(y,ŷ)]^+`; InfoNCE | Capacity/volume regularisers on the free variable |
| Instances | Siamese nets, DrLIM, PIRL, MoCo, SimCLR, CPC; unnormalised maximum likelihood; MCMC / contrastive divergence; GANs (`ŷ` from a trainable generator); **denoising and masked auto-encoders** (`ŷ` by corrupting `y`) | Sparse modelling, sparse and noisy auto-encoders, VAE, VQ-VAE, implicit rank minimisation; VICReg, Barlow Twins, whitening, maximum coding-rate reduction |
| Cost | Energy is raised *only where a contrastive sample was placed*. In the worst case the number needed grows **exponentially with `dim(y)`** | No sample placement problem; the regulariser bounds the low-energy volume everywhere at once |
| Contrastive over | **Samples** (vectors must differ from each other) | **Dimensions** (components of one vector must differ from each other) — VICReg's variance + covariance terms |

**Why this matters beyond self-supervised learning.** The last row is a genuine change of axis: sample-contrastive methods need a batch large enough to cover the space, dimension-contrastive methods need only the representation width. And the classification is unflattering to a large class of currently dominant systems — masked language modelling is on the contrastive side of this table, which is the technical content of the source's claim that scaling generative token models is not a route to a world model (see [[wiki/entities/h-jepa.md]]).

**Four ways to restrict a latent's information content:** discretisation/quantisation (`k` discrete values ⟹ at most `k` zero-energy points, energy = the minimum of `k` quadratic wells); dimension or rank minimisation (`d`-dimensional `z` ⟹ a `d`-dimensional low-energy manifold); sparsification (`R(z) = α‖z‖₁` ⟹ the low-energy region becomes a *union of low-dimensional manifolds*, as in classical sparse coding); fuzzification (noise on `z`, as in the VAE). Which one is best is stated as open by the source.

---

## Reasoning as energy minimisation

The strongest architectural claim in the source, and the one that engages the core framing directly:

| Claim | Content |
|---|---|
| **Reasoning = constraint satisfaction = energy minimisation** | Deliberate ("Mode-2") behaviour is minimising a total energy `F(x) = Σ_t C(s[t])` over a sequence of action variables, by gradient descent through the unrolled world model or by gradient-free search |
| **Actions and latents are the same kind of object** | "There is no conceptual difference between an action and a latent variable." Both are free variables the optimiser instantiates; actions are minimised over, adversarial latents are *maximised* over. More generally actions are latents "representing abstract transformations from one state to the next" |
| **The architecture is a factor graph** | Cost modules are log factors, so probabilistic inference over graphical models is a special case — and the claim is that this form reaches *beyond* it, to reasoning by simulation and by analogy |
| **The symbol question is a smoothness question** | Discrete high-level choices ("turn left or right at the fork") admit no gradient. The proposal is not to add symbol machinery but to make the *world model's learned hierarchy* such that the discrete problem becomes a **continuous relaxation** of itself. Whether this covers all human reasoning is left explicitly open |

**(brainstorm)** Read against [[wiki/concepts/latent-graph-discovery.md]]: an edge label and a latent variable are the same free variable seen from two sides. Path search over a discovered graph is `argmin` over a *sequence* of latents; single-edge label induction (ARC-style) is `argmin` over one. On this reading the wiki's edge-vocabulary problem (hardness 2) becomes the latent-capacity problem above — how many bits the free variable may carry — which is a quantity a regulariser can actually control, unlike "how many primitives are there". That is the first time the vocabulary question has had a knob attached to it.

**(brainstorm)** The relation to [[wiki/concepts/predictive-coding-free-energy.md]] is close enough to be worth stating as a possible identity rather than an analogy: both minimise a scalar over activity at inference and over weights at learning, and both make thinking a relaxation. The differences are (i) energy here is *explicitly not* a log-probability, where free energy is a variational bound on one; (ii) collapse is named as the central technical obstacle here and does not appear there, because a residual against sensory input cannot go flat while the input is present — which suggests the anti-collapse machinery is precisely the price of decoupling from sensation.

---

## Landscape geometry: where the minima sit, not just how deep they are

The collapse taxonomy above is about the *volume* assigned low energy. A second, independent property is the **mutual geometry of the minima**, and it has a known optimum (Englert et al. 2026, [[wiki/entities/fcann.md]]; Kanter & Sompolinsky 1987):

| Property | Statement |
|---|---|
| **Kanter–Sompolinsky projector network** | An attractor net whose stored states are mutually *orthogonal*. Maximal capacity and error-free recall; the attractors coincide with the positive-eigenvalue eigenvectors of the coupling matrix `J` |
| **Not what Hebbian storage gives** | Storing correlated patterns by a Hebbian outer-product rule yields overlapping basins and spurious minima; orthogonality has to be produced by the learning rule |
| **The rule that produces it** | `ΔJ_ij ∝ σ_iσ_j − L(b_i + Σ_k J_ik σ_k)σ_j` — observed correlation minus the correlation the network already predicts. Claimed to be the only known *local, incremental, single-phase* rule approximating a K-S network (the "dreaming"/unlearning alternatives need two phases) |
| **Free test** | Alignment between a network's attractors and the eigenvectors of its own weights is checkable with no data and no labels |
| **Symmetry is not required for the landscape** | Decompose `J = J^S + J^A`. Only `J^S` enters the steady-state distribution; `J^A` breaks detailed balance and adds solenoidal flow *tangential to the level sets* of `p*`. So an asymmetric network still has a well-defined energy landscape — the asymmetry moves the state *along* the contours, it does not deform them |

The last row qualifies the standard statement (carried on [[wiki/entities/dense-sequence-memory.md]]) that `J ≠ Jᵀ` leaves no Lyapunov function: what is lost is a *descent* reading of the dynamics, not the landscape itself, which the symmetric part continues to define.

---

## Open problems

- **Which latent regulariser.** Discrete, low-dimensional, sparse and noisy are all offered; nothing says which is best, and the choice determines the *shape* of the representable outcome set (points vs. manifold vs. union of manifolds).
- **The energy is not calibrated.** Low energy means *consistent*, not *likely* and not *correct* — the same criticism [[wiki/concepts/predictive-coding-free-energy.md]] carries. Nothing converts an energy gap into a confidence.
- **Gradient-based inference may fail exactly where reasoning starts.** Where the action-to-cost map is discontinuous — high abstraction levels, qualitative choices — the differentiability that motivated the whole design buys nothing, and the fallbacks (dynamic programming, MCTS, SAT, beam search) are the classical methods the design was meant to replace.
- **Multi-modal exploration is unmechanised.** The formalism represents alternative interpretations as alternative `z`; nothing systematically *cycles* through them. The source names the Necker cube as the human capability that has no counterpart here.
- **No implementation of the reasoning claim.** Energy minimisation as reasoning is asserted; the paper reports no system doing it.
- **The finite-nudge result buys exactness and pays in sampling.** Both gradient representations are expectations under `ρ_β`; nothing bounds the mixing time of the sampler that estimates them, and the ruggedness that makes the landscape a memory is what makes the sampler slow. The theory removed the convexity assumption and moved the difficulty into the estimator.
- **The path-integral representation is a free hyperparameter in disguise.** How many `β` quadrature points, and where, is unspecified; the demonstration uses a "discrete path-integral variant" without a rule for choosing the discretisation.
- **`T` is the regularisation coefficient and nobody sets it.** It multiplies `KL(ρ_1‖ρ_0)` in the decomposition, so temperature trades supervised fit against how far the free phase may sit from the nudged one — the same untuned knob [[wiki/entities/boltzmann-machine.md]] flags, now with a stated role.

---

## Equilibrium propagation: the energy determines the learning rule

If a network's *dynamics* are the minimisation of `F_w`, then its *plasticity* is fixed by the same scalar (Scellier & Bengio 2017; Whittington & Bogacz 2019). Relax to equilibrium with only the input given and take a step **up** the energy in weight space; clamp the output nearer the target, relax again, take a step **down**. The two-term update is `∂F/∂W` evaluated at two equilibria — local, no weight transport, no backward pass — and it is what the contrastive Hebbian rule of [[wiki/entities/boltzmann-machine.md]] already was.

| Energy | Instance | Phases |
|---|---|---|
| Hopfield energy (dissimilarity between strongly connected nodes) | continuous Hopfield nets, contrastive learning | Two |
| Free energy (bounds `log p(target \| input)`) | predictive coding, dendritic error | **One** — the free phase already sits at the global minimum, so the first term vanishes |

Two things this is worth to a builder. (i) It removes a design choice: **specify architecture + energy, and the local learning rule is derived rather than invented** — the pitch of this page's formalism extended from inference to learning. (ii) It supplies a *reason* to prefer a probabilistically interpretable energy over an arbitrary one: the biologically plausible networks that perform best minimise free energy, which is exactly the case where `F` is not merely a compatibility score but a likelihood bound. That cuts against this page's own "not a log-probability" stance and is logged as such.

### The original statement (Scellier & Bengio 2017)

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

### Weak clamping is the whole algorithm

Every neighbouring algorithm differs from equilibrium propagation in what its *second phase* does, and each difference is a defect:

| Algorithm | Second phase | Objective | What weak clamping fixes |
|---|---|---|---|
| **Contrastive Hebbian learning** (Movellan 1990) | Output **fully** clamped — the `β → ∞` limit of the same equations | `J_CHL = E(u^∞) − E(u⁰)` | `J_CHL` can go **negative** when the free and clamped fixed points land in *different modes* of the energy landscape; the update is then inconsistent and learning deteriorates. A weakly clamped fixed point is a local perturbation of the free one, and the implicit-function theorem keeps them in the same mode |
| **Boltzmann machine / CD₁** | An independent clamped Markov chain | Log-likelihood, fixed by `E` | Two separate chains rather than one perturbation, so no backward-pass reading; `CD₁` is a biased estimator and provably the gradient of *no* objective (may cycle indefinitely — Sutskever & Tieleman 2010) |
| **Almeida–Pineda recurrent backpropagation** | Fixed-point iteration on a **linearised** copy of the network | The same `J` | The second phase is a different kind of computation from the first, so a biological substrate would need two circuits — exactly the objection that motivates the whole family |
| **Xie & Seung 2000** | Fully clamped, with feedback weights scaled by `γ^j`, `γ → 0` | CHL objective | Requires infinitesimal feedback (so the net is only nominally recurrent, behaving almost feedforward) and per-layer learning rates spanning orders of magnitude to compensate. Equilibrium propagation keeps feedforward and feedback strong and uses one learning rate |

**STDP is the mechanism, by integration rather than analogy.** Take the continuous rule `dW_ij/dt ∝ ρ(uᵢ)·dρ(u_j)/dt`, which reproduces the Bi & Poo 1998 window (see [[wiki/concepts/biologically-plausible-credit-assignment.md]]), and symmetrise it for tied weights: `dW_ij/dt ∝ d[ρ(uᵢ)ρ(u_j)]/dt`. Integrating along the second-phase trajectory from `u⁰` to `u^β` yields `ρ(u_i^β)ρ(u_j^β) − ρ(u_i⁰)ρ(u_j⁰)` — **the contrastive update is the time-integral of a spike-timing rule**, not a separate postulate that happens to resemble one. Two readings are offered and are experimentally distinguishable: either an anti-Hebbian update fires at the free fixed point and a Hebbian one at the nudged fixed point, or nothing happens in phase one and the synapse simply follows the derivative rule while the state moves.

### What it costs: the relaxation numbers

Permutation-invariant MNIST, `ε = 0.5`, `β = 1.0`, hard-sigmoid `ρ`, 0.00% training error throughout:

| Architecture | Free-phase iterations | Nudged-phase iterations | Test error |
|---|---|---|---|
| 784-500-10 | **20** | 4 | 2–3% |
| 784-500-500-10 | **100** | 6 | 2–3% |
| 784-500-500-500-10 | **500** | 8 | 2–3% |

Three things in that table. (i) **The free phase is the entire cost and it explodes with depth** — ×5 per added hidden layer, against a nudged phase growing by 2 — which is the concrete measurement behind the "iteration count does not scale" complaint on [[wiki/concepts/biologically-plausible-credit-assignment.md]] and the reason these demonstrations stop at MNIST. (ii) **The second phase is deliberately not run to equilibrium.** The leaky-integrator time constant is `τ = 1`, so `N` steps suffice for the perturbation to cross `N` layers; only the *onset* of the movement is needed, since the update integrates the path rather than reading its endpoint. (iii) Accuracy is flat in depth — extra layers buy nothing here.

Three implementation facts that the theory does not predict and a builder pays anyway: **persistent particles** (cache each training example's free fixed point and restart next epoch from it — the PCD trick, and the only reason the 500-iteration case is trainable at all); **randomising the sign of `β`** each example, which regularises (the update is sign-consistent because of the `1/β` factor); and **per-layer learning rates chosen so `‖ΔW_k‖/‖W_k‖` matches across layers**, needed despite the theory demanding a single rate — attributed to finite precision in approaching the fixed points, i.e. the theory holds exactly *at* equilibrium and the simulation is never there.

**The unpaid bill is weight symmetry.** `W_ij = W_ji` is used to derive the leaky-integrator dynamics itself, and nothing in the framework produces it. The offered hopes are all external: denoising autoencoders trained without tied weights tend to learn symmetric ones (Vincent et al. 2010); the symmetric solution minimises the reconstruction error between successive ReLU layers (Arora et al. 2015), suggesting symmetry could fall out of an *additional* autoencoder objective per layer; and feedback alignment shows forward weights can align to *random* fixed feedback (Lillicrap et al. 2016). None of these is inside the model. **(brainstorm)** The Arora route is the one to test, because it costs nothing structurally: add a per-layer reconstruction term to `E` and check whether the symmetry the dynamics assume is produced by the energy the dynamics minimise. That would make the framework self-consistent instead of self-referential.

### Finite nudging: the contrastive update is exact, not approximate (Litman 2025)

The frame above inherits two assumptions that never held: the nudge `β` must be **infinitesimal** for the update to be a gradient, and the state is a **single energy minimum**. Both are dropped by replacing the deterministic minimiser with a Gibbs–Boltzmann distribution over states.

| Object | Statement |
|---|---|
| **Objective kernel** | `F(θ,β,s) = E(θ,s) + β·ℓ(s)` — energy plus loss weighted by nudging strength `β ∈ [0,1]`; `ℓ` does not depend on `θ` |
| **State distribution** | `ρ_β(s;θ) = exp(−F(θ,β,s)/T) / Z_β(θ)`. `ρ_0` = **free** phase, `ρ_1` = **nudged** phase. `T → 0` recovers the deterministic minimiser |
| **Helmholtz free energy** | `A(θ,β) = −T log Z_β(θ)` — the statistical generalisation of `min_s F(s)`, i.e. of this page's `F_w(x,y) = min_z E_w(x,y,z)` |
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

Three consequences for this page. (i) The zero-temperature `min_z` elimination in the formalism table is a *limit*, not the definition; at finite `T` the free energy is the right object and the contrastive rule is its exact gradient. (ii) This is a sample-contrastive method whose second term is nevertheless not a sample-placement problem in the usual sense — the "contrastive sample" is the model's own nudged equilibrium, so the exponential-in-`dim(y)` cost of the table above is replaced by the cost of sampling `ρ_β`. (iii) It supplies a second, independent argument for a probabilistically interpretable energy: `A` is a log-partition function, so the free-energy preference recorded above stops being an empirical observation and becomes a definition.

### ImageNet at 13.23% top-5: the relaxation cost is a property of the energy, not of the framework (Kerjan et al. 2026)

> `raw/kerjan-2026-predictive-coding-imagenet-eqprop.md` — Kerjan, Scellier & Høier (Rain AI), 2026. First demonstration of **either** equilibrium propagation **or** a predictive-coding network at full-size ImageNet (1.28M images, 224×224, 1000 classes).

Every equilibrium-propagation number above stops at MNIST, and the "free phase is the entire cost and it explodes with depth" table is why. That table is a fact about the **Hopfield** energy, not about equilibrium propagation. Swap in the predictive-coding energy

```
E_PCN(θ, x, h) = ½ Σ_{k=1..L} ‖h_k − f_k(θ_k, h_{k−1})‖²
```

and the free equilibrium is the *unique global minimum* with `E = 0`, reached by **one forward pass** — the 20/100/500-iteration column collapses to 1 at every depth. The nudged phase is the only iterative part, and its cost is `K ≈ L` iterations, not `5^L`. This is the row the framework table already had ("free energy … one phase — the free phase already sits at the global minimum") turned into the reason the method scales.

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
| 1 | **Nudging beats clamping, and the margin appears only when the task is hard.** On CIFAR-100 the two are indistinguishable; on ImageNet 32×32 cross-entropy-nudging is far ahead of both mean-squared-error nudging and clamping | Clamping (`h_out^β = (1−β)h_out⁰ + βy`, O'Reilly 1996) defines **no cost function**, so its update is the gradient of nothing even as `β → 0`. The page's claim that "the cost function is a free design variable, and that is the property worth taking" now has its price tag: on ImageNet 32×32, choosing cross-entropy over mean-squared error moves top-5 error 55.9 → 36.6 |
| 2 | **The finite-difference scheme barely matters.** Centered, random and backward are all competitive at ImageNet scale — contradicting Laborieux et al. 2021, where the centered scheme's `O(β²)` bias reduction was the headline | For a predictive-coding energy `∂F/∂θ` **vanishes at the free equilibrium**, so the random/backward update needs only the *nudged* state: `∇_θC ≈ (1/β)·∂F_PCN/∂θ(θ, β, h_β⋆)`. **One equilibrium, one phase, half the wall-clock** (10 days vs. 18 on a single A100), and no free-phase measurement to store or compare against — which is the phase-control objection (objection 6 on [[wiki/concepts/biologically-plausible-credit-assignment.md]]) partly dissolved rather than answered |
| 3 | **`β` can be tiny.** Error rate is flat for `0.0002 ≤ β ≤ 0.1` and `K ≥ 4`; the optimal `K` is *the number of layers*, i.e. exactly the time for the perturbation to travel output → input (two layers per iteration under the even/odd asynchronous traversal) | Directly contradicts the Litman 2025 result above, where `β = 0.01` was near chance — see T120. It also makes `K` a **derived** hyperparameter: nudge for as many steps as the network is deep |
| 4 | **The nudged state is not a minimum of `F`.** Equilibration curves spike and settle at `ΔF > 0` relative to the free equilibrium; the dynamics are better read as fixed-point iteration onto a *critical point* of `F` | Equilibrium propagation only ever needed the first-order condition `∂F/∂h = 0`. The wiki should stop describing the second phase as "settling into a lower-energy state" — a saddle serves |

**The nudged dynamics, written out** (what actually runs, and it is not gradient descent as usually pictured): projected gradient descent with step size `α = 1` on `F_PCN` makes the `h_k` terms cancel, leaving `h_k ← ReLU(f_k(θ_k, h_{k−1}) + ∂ε²_{k+1}/∂h_k)` — bottom-up prediction plus top-down error, one line, no learning rate. Two deviations were needed to make it work at depth: **asynchronous traversal** (update even-indexed layers, then odd — synchronous updates diverge, as in deep Boltzmann machines), and **mod-PGD**, `h_k ← ReLU(a_k + ∂ε²_{k+1}/∂h_k)` using the *pre-activation* `a_k` rather than `ReLU(a_k)`. The difference bites in one quadrant only: with plain projected gradient descent, a unit whose bottom-up drive is inhibitory (`a_k < 0`) *ignores* that inhibition when the top-down error is positive; mod-PGD lets the negative drive act as an **inhibitory buffer**, so a bottom-up-suppressed unit stays silent unless top-down evidence is strong. Tempering top-down signals this way keeps the nudged state near the free one — and is the difference between training and diverging to NaN on CIFAR-10 at `K = 5`. **(brainstorm)** This is a precision-weighting mechanism arrived at empirically: it is the same "how much should top-down override bottom-up" knob that [[wiki/concepts/predictive-coding-free-energy.md]] parameterises as `Σ`, discovered here as a projection rule rather than a variance.

**What the result does *not* buy.** Equilibrium propagation cost 18 days on one A100 against 36 hours for backpropagation — ~12× wall-clock for ~1 point of accuracy, in a setting with **no hardware payoff**, since the authors are explicit that it is unknown whether `F_PCN` and the mod-PGD dynamics can be realised physically at all. The result is an argument about *the framework*, not a proposal: it decouples "equilibrium propagation does not scale" from "the physical networks people run equilibrium propagation on do not scale", and lands the blame on the second. And it sharpens the identifiability line — EP tracks backpropagation under every variation of batch size, cost function and initialisation gain tested, so **the learning algorithm is the least load-bearing choice in the pipeline** ([[wiki/concepts/objective-identifiability.md]]).

---

## Connections

- **[[wiki/entities/vector-hash.md]]** — the landscape *designed* rather than fitted: minima are positioned, sized and shaped by a frozen code before any data arrives, which is why they come out convex, uniform and spurious-free, and content is attached by a separate feedforward layer that never touches the energy function.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — a biological energy landscape with its capacity computed: `p_max ≈ kC/(a ln(1/a))` counts how many minima it can hold, and *diluted* connectivity is justified as landscape hygiene — duplicate synapses between a neuron pair distort the basins and dominate which states are stable.

- **[[wiki/entities/h-jepa.md]]** — the architecture this formalism is built for: a joint-embedding predictive architecture is an EBM whose energy is prediction error *in representation space*, trained by the regularised branch of the table above.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies an alternative statement of the whole framing: a graph is an energy landscape, an edge label is a latent variable, and path search is `argmin` over a latent sequence — which attaches a capacity knob to the edge-vocabulary problem (hardness 2).
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the near-identity: both make inference a scalar minimisation over activity and learning a minimisation over weights, differing on whether the scalar is a probability in disguise and on whether collapse is a live threat.
- **[[wiki/concepts/simulation-based-planning.md]]** — planning is this page's minimisation with the free variables read as actions; the cost module supplies the objective and the world model supplies the constraints.
- **[[wiki/concepts/amortized-inference.md]]** — latent inference by minimisation is onerous, and the stated remedy is an amortised module that *predicts* the minimising latent, which is this page's expensive step compiled away.
- **[[wiki/concepts/shortcut-learning.md]]** — collapse is the shortcut problem in its purest form: a constant encoder is the cheapest possible rule that satisfies the training objective, and the four training criteria exist solely to make it unavailable.
- **[[wiki/concepts/three-component-framework.md]]** — a rare proposal that fills all three slots at once: energy as the objective, non-contrastive regularisation as the learning rule, joint embedding as the architecture — and it supplies the objective slot with a concrete quantity where gap G30 finds it empty.
- **[[wiki/concepts/compositionality.md]]** — constraint satisfaction is a composition operator: several cost terms are combined by *addition* of energies, so composing goals is free where composing modules is not.
- **[[wiki/concepts/universal-induction.md]]** — the volume-minimising regulariser is a description-length argument in continuous clothing: restricting a latent's information content is bounding the bits available to name a hypothesis.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the discrete form of the same description-length move: charging a model for its own parameters (two-part code) and bounding a latent's information content are one regulariser in two representations.
- **[[wiki/concepts/divergence-objectives.md]]** — states what refusing to normalise buys: a forward-KL-trained predictor's specified optimum on a one-to-many transition is mass *between* the branches, and an unnormalised `F(x,y)` is subject to neither direction of the divergence. The finite-nudge decomposition adds the case that page's table lacks — a divergence between two phases of *one* model, `T·KL(ρ_1‖ρ_0)`, with the data in neither argument.
- **[[wiki/concepts/subgraph-matching.md]]** — a contrastive energy whose *shape* encodes an algebra: `E = ‖max{0, z_q − z_u}‖²₂` enforces transitivity, anti-symmetry and closure under intersection by construction, and its asymmetry makes collapse self-punishing rather than needing a fourth criterion (gap G34).
- **[[wiki/concepts/representation-probing.md]]** — the same property from the other direction: where a latent is deliberately low-capacity and discrete, linear decodability is stipulated by construction rather than discovered by an instrument.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the biological instance of relaxation as retrieval: CA3 completion is energy minimisation over the free variables of a partial cue, and pattern separation is the constraint keeping two stored patterns in distinct basins.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — proposes a *mixture of Boltzmann machines* as the implementation of a nonparametric latent-state posterior: a state-dependent energy function plus a distribution over states, which is how a discrete context library and an energy landscape become the same object.
- **[[wiki/entities/sparse-distributed-memory.md]]** — attractor behaviour from a network with no recurrent weight matrix: the loop runs *read-out → next address*, and a 20%-corrupted cue converges to an unstored prototype in two or three reads. So relaxation-as-retrieval needs a feedback path, not a symmetric energy — and the per-bit margin `|s_u|` is a read-out of how deep in the basin the answer sits.
- **[[wiki/entities/dense-sequence-memory.md]]** — the asymmetric half of associative memory, where the energy formalism stops applying: `J ≠ Jᵀ` admits no Lyapunov function, so retrieval is a driven traversal rather than a descent, and the `MixedNet` writes both in one weight matrix with `λ` trading landscape depth against transition drive.
- **[[wiki/entities/adaptive-cann.md]]** — a mechanism for this page's unmechanised multi-modal exploration: adaptation raises the energy of whichever minimum is currently occupied, so the state cannot rest, and one gain interpolates between resting in a minimum, oscillating around it, and traversing the landscape — Necker-cube alternation as a dynamical property of the energy function rather than an added sampler.
- **[[wiki/entities/context-modular-memory-network.md]]** — a *family* of energy functions carried by one weight matrix: a discrete context imposes a binary mask `a_i^k a_j^k c_ij^k` on the couplings, so `H^(k)` reshapes without any weight changing, and minima can be deleted on demand — the landscape becomes a controllable object rather than a consequence of what was stored.
- **[[wiki/entities/fcann.md]]** — the landscape measured rather than trained, at whole-brain scale: couplings are the inverse covariance of activity, the attractors coincide with the eigenvectors of those couplings (a Kanter–Sompolinsky projector network, i.e. the capacity-optimal geometry), and `J = J^S + J^A` shows that only the symmetric part shapes the energy while the antisymmetric part adds circulating flow along its level sets.
- **[[wiki/entities/hopfield-network.md]]** — the minimal complete instance of this page's formalism: a quadratic energy `F(s) = −½ sᵀWs` whose inference is literally descent to a minimum, and the Hebbian write that produces the overlapping basins and spurious minima the "landscape geometry" section contrasts with orthogonal storage.
- **[[wiki/entities/boltzmann-machine.md]]** — the mechanism behind this page's central asymmetry (pushing data energy down is trivial, pushing everything else up is the whole problem): `−log Z` is the "everything else", and its gradient is estimated by free-running the network, which is the MCMC/contrastive-divergence row of the table above written out as an update rule.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the closest biological reading of relaxation-as-inference: superficial cortical layers settling under mutual perisomatic inhibition toward an interpretation consistent with feedforward, lateral and feedback input, with the deep layers acting as the read-out that commits and then constrains the input stream (Douglas & Martin 2004).
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — the biological payoff of the energy formalism: equilibrium propagation turns `∂F/∂W` at two equilibria into a local Hebbian/anti-Hebbian rule, so an energy-based net is trainable without weight transport or a backward pass.
- **[[wiki/concepts/attractor-dynamics.md]]** — an attractor is a local minimum of the scalar compatibility function, so relaxation is the dynamical form of `argmin` over it.
- **[[wiki/entities/spacetime-attractor.md]]** — planning as `argmin` with the terms named: the free variable is the whole trajectory, reward enters as a per-timestep input term and realisability as the adjacency-matrix recurrence, so the settled state is the minimum-energy compatible future (Jensen et al. 2026).
- **[[wiki/concepts/expected-free-energy.md]]** — the same "minimise a scalar" move made over a *policy* instead of an activity, and the difference that buys: the scalar is convex on a compact flow polytope, so the minimisation comes with an existence proof and an `O(1/K)` rate where relaxation on an energy landscape has neither (Milosevic et al. 2026).
- **[[wiki/entities/neuromatch.md]]** — a contrastive energy whose asymmetric hinge `‖max{0, z_q − z_u}‖²` makes representational collapse self-defeating, so no separate anti-collapse term is needed.
- **[[wiki/concepts/objective-identifiability.md]]** — the ImageNet sweep here is an identifiability result: cost function and batch size determine performance while the choice between equilibrium propagation and backpropagation does not, so the learning rule is not recoverable from accuracy.
