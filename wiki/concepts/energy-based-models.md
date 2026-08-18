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

## Open problems

- **Which latent regulariser.** Discrete, low-dimensional, sparse and noisy are all offered; nothing says which is best, and the choice determines the *shape* of the representable outcome set (points vs. manifold vs. union of manifolds).
- **The energy is not calibrated.** Low energy means *consistent*, not *likely* and not *correct* — the same criticism [[wiki/concepts/predictive-coding-free-energy.md]] carries. Nothing converts an energy gap into a confidence.
- **Gradient-based inference may fail exactly where reasoning starts.** Where the action-to-cost map is discontinuous — high abstraction levels, qualitative choices — the differentiability that motivated the whole design buys nothing, and the fallbacks (dynamic programming, MCTS, SAT, beam search) are the classical methods the design was meant to replace.
- **Multi-modal exploration is unmechanised.** The formalism represents alternative interpretations as alternative `z`; nothing systematically *cycles* through them. The source names the Necker cube as the human capability that has no counterpart here.
- **No implementation of the reasoning claim.** Energy minimisation as reasoning is asserted; the paper reports no system doing it.

---

## Connections

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
- **[[wiki/concepts/divergence-objectives.md]]** — states what refusing to normalise buys: a forward-KL-trained predictor's specified optimum on a one-to-many transition is mass *between* the branches, and an unnormalised `F(x,y)` is subject to neither direction of the divergence.
- **[[wiki/concepts/subgraph-matching.md]]** — a contrastive energy whose *shape* encodes an algebra: `E = ‖max{0, z_q − z_u}‖²₂` enforces transitivity, anti-symmetry and closure under intersection by construction, and its asymmetry makes collapse self-punishing rather than needing a fourth criterion (gap G34).
