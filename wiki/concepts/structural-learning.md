# Structural Learning

**Randomly varying the *parameter* of a task while holding its *structure* fixed teaches the structure: the learner extracts the low-dimensional subspace of control space on which the family lies, plus a metaparameter that moves along it — and the acquired object is visible in the *variance* of the output, not in its mean.**

> **Provenance.** `raw/braun-2009-motor-task-variation-structural-learning.md` — Braun, Aertsen, Wolpert & Mehring, *Motor task variation induces structural learning*, Curr. Biol. 2009; 19(4):352–357. Human visuomotor adaptation in planar and 3D virtual reality; four groups, three experiments. No neural recording. (A "Neurophysiological Perspective on Structural Learning" exists in Supplemental Document S1, which is not in the clipped source.)

---

## The formalism

| | Statement |
|---|---|
| **Function-approximation account** (the target of the paper) | `u = Σ_i w_i φ_i(s)`, `φ_i` fixed basis functions, `w` adjustable. Learning = search in `w`-space; transfer = the new `w` being close to the old one |
| **Structure** | The task family does not span `w`-space but lies on a low-dimensional manifold `w = f(μ)`, `dim(μ) = k ≪ dim(w)` |
| **Structural learning** | Acquiring `f`. A new task on the same structure is then found by searching `μ ∈ R^k` instead of `w` |
| **Metaparameter** | `μ` — the single coordinate that slides the controller along the structure (here: rotation angle, or shearing coefficient) |

Two learnable levels, and they are *not* the wiki's usual fast/slow pair: both live in the controller, and the outer one is a **restriction on the search space of the inner one** rather than an initialisation for it.

---

## The design move that makes the result mean anything

The hidden parameter is varied with **expectation zero**. Rotation angle drawn `U[−90°, +90°]`, resampled every 8 trials (each of 8 targets once, pseudorandom order), 800 trials.

> If a learner only fits the average mapping — which is what the function-approximation account, and the prior literature on randomly varying transformations, predict for a randomly varying hidden variable — then `E[transformation] = identity` and **no learning of the transformation can occur**. Any measured facilitation is therefore attributable to the family's shape and not to its mean.

This is the cleanest control in the wiki for *did the learner acquire the family, or the mean of the family?*, and it is a design template, not a finding: it costs nothing to impose on a task sampler ([[wiki/concepts/meta-learning.md]]).

---

## Three predicted signatures, all measured

| Signature | Why the structure predicts it | Experiment | Result |
|---|---|---|---|
| **Structure-specific facilitation** | A `k`-dimensional search is faster than a `dim(w)` one | 800 random-rotation trials → fixed +60° block, against a no-transformation control | Faster feed-forward learning (initial angular error at 200 ms; `p < 0.01`, Wilcoxon rank-sum on mean error over first 10 trials), faster movements (`p < 0.001`) and lower cumulative trajectory error (`p < 0.001`) |
| **Structure-specific interference reduction** | Two opposing parameter settings on one structure are joined by a short path *inside* the subspace | +60° → −60° → +60° | Naive controls show the standard anterograde interference on −60°; the random-rotation group's is significantly reduced (`p < 0.01` feed-forward, `p < 0.001` cumulative). Retrograde interference on return to +60° is likewise markedly reduced (`p < 0.02` / `p < 0.01`) |
| **Structure-specific exploration** | Search should run *along* the structure and be damped off it | 3D VR, two orthogonal structures (random horizontal vs random vertical rotations, `U[−60°, +60°]`, resampled every 4 reaches), probed with 45° rotations of either type after a 4-trial null-rotation washout | On-matched probes: significantly smaller endpoint variance in the direction orthogonal to the learned structure (`p < 0.01`, one-tailed `F` on the orthogonal deviation), in feedback **and** feed-forward components. On-*mismatched* probes: exploration still carried a component along the previously learned structure (`p < 0.05`, two-sample Kolmogorov–Smirnov on absolute adaptation angles) |

**The feedback controller is structure-specific too**, which the facilitation result alone would not show. Rotation-trained vs shearing-trained groups given *identical* probe trials produced different hand paths and velocity profiles; performance was faster when probe structure matched training (`p < 0.001`, paired `t`), and peak positional variance across probe trials fell on compatible probes (`p < 0.005`, one-tailed `F`). Both tasks require feedback processing to solve, so feedback processing is not a generic adaptability that random exposure turns up — it is conditioned on the structure experienced.

### Two controls that make the facilitation attributable to structure rather than to exposure

| Alternative | Control | Outcome |
|---|---|---|
| The group had recently seen an angle near +60° | Correlate first-trial error in the +60° block against the rotation angle of the preceding two random blocks | `r² < 0.07` and `r² < 0.001`; mean preceding angle was −12° (penultimate −6°), i.e. any correlation would have worked *against* the group |
| The group had accumulated memories of ±60° specifically | A **random-linear** group given the same number of ±60° rotation trials, embedded in a looser structure (rotation + shearing + scaling) | Worse than the random-rotation group (`p < 0.01`) in both measures; cumulative error resembled the naive controls, and feed-forward learning was *slower than naive* — the group had learned to lean on feedback instead |

The second control is the load-bearing one and its shape is unusual: **the same parameter exposure inside a larger structure class produces no benefit, and a measurable cost.** Structure size is not free; a family specified too loosely is worse than no family.

---

## What this contributes

**1. Exploration becomes an output of what was learned, not a schedule (`G61`).** Every other exploration mechanism in the wiki is an external rate — `Random Go` at `p = .1`, an annealed temperature, an ensemble-disagreement bonus with grid-searched mixing coefficients. Here the learned object *shapes the exploration distribution directly*: variance is suppressed orthogonal to the structure and, on a task off the structure, the initial search still runs along it. Two qualifications keep this from closing the row: it is a constraint on the **direction** and anisotropy of exploration, not on its **rate**; and nothing here is a mechanism, only a behavioural measurement.

**2. A manifold generated by the task sampler's second moment (`G82`).** `G82`'s complaint is that every low-dimensional manifold in the wiki is recovered post hoc by dimensionality reduction and none is produced by a stated construction. This supplies a fifth candidate generator, and the cheapest one to implement: **the covariance of the task distribution**. Sample the family's parameter at zero mean and the subspace the controller ends up confined to is the one that parameter sweeps out. What it does not supply is a readout — `μ` is never measured, only inferred from behaviour — so the generator is exhibited without the coordinates.

**3. A task sampler whose entire product is in the second moment.** [[wiki/concepts/meta-learning.md]]'s outer loops all change the mean policy. Here `E[T] = identity` by construction and the transfer is nonetheless large, which separates two things the meta-learning literature routinely conflates: what the sampler's *mean* installs (nothing, here) and what its *support* installs (the subspace). The design rule that falls out is one line: to install a structure without installing a bias, sample its parameter symmetrically about the identity.

**4. The transferred object is measured in variance, not in accuracy.** `(brainstorm)` The exportable machine test needs no new instrument: train on a family with a zero-mean parameter, then on a held-out task measure the **anisotropy of the policy's exploration** — the ratio of output variance along the family's subspace to variance orthogonal to it — early in adaptation. A learner that acquired only the mean scores 1. This is a *representation* probe that requires no probing classifier and no access to internals, and it discriminates a structural learner from a fast adapter, which a learning curve cannot ([[wiki/concepts/contextual-inference.md]], `G17`).

**5. The authors' own extrapolation, and it is the wiki's target.** "Learning to learn" phenomena in categorisation and concept learning — facilitation after random exposure to other items of a category — are recast as structural learning, with scalable motor structures proposed as a precursor to **motor concepts**. Untested here in any non-motor domain.

---

## Where it sits against the wiki's other account of the same data

Reduced interference between ±60° rotations is also the signature [[wiki/entities/coin-model.md]] explains — by allocating the two perturbations to *separate discrete contexts* whose responsibilities do not compete. This paper explains it by the two being *two settings of one continuous metaparameter*, joined by a fast low-dimensional path. Same paradigm, same laboratory, incompatible decompositions of the stored object. Logged as [[wiki/empirical-tensions.md]] T350.

---

## Open problems

- **The structure is supplied by the experimenter.** Rotation, shearing, and the loose "linear transformation" class are chosen and then trained; nothing discovers `f` from a stream, and the random-linear control shows the *grain* matters — a family specified one level too loosely produces worse-than-naive feed-forward learning. That is `G27`'s granularity problem in continuous clothing, with no `γ`/`α` knob to point at.
- **`μ` is never read out.** The metaparameter is the whole content of the claim and is inferred entirely from error curves and variance ellipses. No measurement locates a metaparameter anywhere, in behaviour or in tissue.
- **`k = 1` throughout.** Every structure tested is one-dimensional. Whether a family with a multi-dimensional metaparameter, or a *hierarchy* of nested structures, behaves the same is untested — and a hierarchy is what the concept-learning extrapolation would require.
- **No mechanism, no substrate.** The paper closes by naming recurrent networks as the place to look and does not look. The nearest candidate the wiki carries is a paired forward/inverse module set selected by responsibility ([[wiki/entities/cerebellum.md]]), which is a discrete library and therefore the opposite decomposition.
- **Feed-forward and feedback are both structure-specific, and how they interact is stated as future work.** The two components are separated by measurement (initial angular error vs cumulative trajectory error) and never by manipulation.
- **`(brainstorm)` The zero-mean design does not generalise for free.** It works because the transformation group has an identity and the family is symmetric about it. For a task family with no natural identity element, "sample at zero mean" has no referent, and the control that makes this paper's inference valid is unavailable.

---

## Connections

- **[[wiki/concepts/meta-learning.md]]** — the same outer/inner split with the outer loop's product restricted to the *support* of the task distribution rather than its mean: `E[T] = identity` by construction, so nothing is installed in the mean policy and the transfer is entirely the subspace the parameter sweeps out — which is a design rule for `p(T)` rather than a source for it.
- **[[wiki/concepts/manifold-constrained-learning.md]]** — the same subspace constraint measured from the other end: there the manifold is fixed by the population's existing co-modulation and bounds what can be learned in hours, here the manifold is *installed* by a training statistic and bounds where the learner searches — so the two pages are the read and write halves of one constraint, and neither has the other's operation.
- **[[wiki/concepts/contextual-inference.md]]** — the rival decomposition of the same motor-memory data: a growing library of exchangeable contexts against a continuous parametric family, with the reduced ±60° interference explained by non-competing responsibilities there and by a short in-subspace path here (T350) — and the direct answer to that page's own open problem that "context 5 cannot be context 3 with one edge flipped".
- **[[wiki/entities/coin-model.md]]** — the formal statement of the atoms position in T350, fit to the same paradigm by the same laboratory: scalar states indexed by a discrete context, with no coordinate along which two memories can be near each other.
- **[[wiki/entities/cerebellum.md]]** — the discrete-library mechanism this page's continuous family is defined against, and the one candidate substrate on offer: MOSAIC's fixed module set with responsibility-weighted mixing gets a new task by *interpolating between modules*, which is a convex hull rather than a learned subspace and cannot extrapolate along a structure.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the mechanistic content of the `priors` term stated as a *shape* rather than a quantity, and a warning about the denominator: the random-linear group had the same parameter exposure and learned more slowly than naive controls, so experience can enter that ratio with a negative sign when it installs the wrong-sized family.
- **[[wiki/concepts/compositionality.md]]** — the alternative to composing atoms: a family is covered by one structure plus a continuous coordinate rather than by a library of parts, which buys interpolation and extrapolation along the coordinate and buys nothing at all off it.
- **[[wiki/concepts/population-geometry.md]]** — a behavioural readout of a subspace where that page needs a recording: the anisotropy of exploration variance identifies the learned subspace from output statistics alone, with no units, no projection choice, and therefore none of T159's projection-artefact exposure.
- **[[wiki/concepts/learned-world-models.md]]** — what a forward model must be parameterised by if it is to be re-used across a family: not one map per environment but a map plus a metaparameter, which is the identification step that makes a world model transferable rather than re-fitted.
- **[[wiki/architectural-gaps.md]]** — `G61` gets its only case of exploration shaped by what was learned rather than by a schedule (direction and anisotropy, not rate); `G82` gets a fifth manifold generator, the task sampler's covariance, which is the cheapest to implement and the only one with no readout for its coordinates.
- **[[wiki/concepts/abstraction.md]]** — the rate-multiplier reading of abstraction in its purest form (T93 position B): the structure predicts nothing about the new task's parameter and cannot solve it, it only makes the search cheap — and the cost is quantified, since a family specified too loosely makes the search *more* expensive than no family at all.
