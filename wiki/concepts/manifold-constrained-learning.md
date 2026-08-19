# Manifold-Constrained Learning

**What a population can learn to do in hours is bounded by the co-modulation structure it already has: new activity patterns that lie inside the existing low-dimensional manifold are learnable, patterns that require leaving it are not.**

> **Provenance.** Sadtler et al. 2014, *Neural constraints on learning*, Nature 512:423–426 (`raw/sadtler-2014-neural-constraints-learning.md`). Two rhesus monkeys, 96-channel arrays in the proximal-arm region of M1 (Primary Motor cortex), 85–91 neural units, 109 sessions.

[[wiki/concepts/population-geometry.md]] measures the shape of a population's activity and repeatedly logs the same caveat: the measurement is correlational, nothing perturbed the population along a latent direction, so "the animal uses the geometry" stays unlicensed. This page is the closest thing the wiki has to the missing experiment. It does not perturb the neurons — it perturbs the *readout*, in two ways matched on every confound the authors could think of, and asks which one the animal can learn. The manifold turns out to have **causal status**: it predicts learnability.

---

## The paradigm

A closed-loop BCI (Brain–Computer Interface) is the instrument, and the reason it works is that the experimenter owns the whole map from activity to behaviour. Every neuron controlling the action is observed, and the set of activity patterns that would succeed is known in advance — so failure to learn cannot be attributed to an unobserved contribution.

| Object | Definition |
|---|---|
| **Neural space** | `R^q`, one axis per neural unit (`q` = 85–91); a 45 ms binned, z-scored spike-count vector `u ∈ R^q` is one point |
| **Intrinsic manifold (IM)** | The column space of `Λ` in a factor-analysis model `u = Λz + μ + ε`, `z ∈ R^10`, `ε ∼ N(0, ψ)` with `ψ` diagonal. The subspace spanned by the population's *natural patterns of co-modulation* |
| **Control space** | The 2-D subspace whose coordinates become horizontal and vertical cursor velocity |
| **Intuitive mapping** | Calibrated daily; a Kalman filter from the z-scored factors `ẑ` to cursor velocity. By construction the control space lies **inside** the IM |

The critical design move is that the decoder is factored as `u → z → velocity` rather than `u → velocity`. Each stage can be permuted independently, which yields two perturbations with the same functional form and opposite locus:

| Perturbation | Operation | What is preserved | What must change to relearn |
|---|---|---|---|
| **Within-manifold (WM)** | `ẑ ← η_WM ẑ`, `η_WM` a 10×10 permutation matrix | unit → factor map (the IM itself) | The association between existing co-modulation patterns and cursor kinematics |
| **Outside-manifold (OM)** | `u ← η_OM u`, `η_OM` a `q×q` permutation matrix | factor → velocity map | The unit → factor map: the animal must **generate co-modulation patterns the population does not naturally express** |

Both re-orient the control space; only OM moves it off the IM. Perturbations were selected per session so that predicted open-loop velocity errors fell in a fixed angular band (mean range 19.7° ± 7.0° to 44.4° ± 8.9°), i.e. hard enough to require learning, easy enough to be usable.

---

## The result

| Finding | Number | Reading |
|---|---|---|
| **WM perturbations are learned; OM are not** | Learning index (fraction of the intuitive-mapping performance recovered) significantly higher for WM (`n` = 28 / 14 per monkey) than OM (`n` = 39 / 15) | The IM predicts learnability of an arbitrary new sensorimotor map |
| **Aftereffects follow the same split** | On return to the intuitive mapping, performance is briefly impaired after WM and **not impaired** after OM | Independent confirmation: OM sessions left no trace, so no learning occurred to be washed out |
| **No improvement with months of exposure** | The WM/OM gap is present from the earliest sessions and does not shrink over the study | Not a matter of the animal learning *how to learn* off-manifold |
| **The dimension choice is not doing the work** | Estimated intrinsic dimensionality 9.81 ± 0.31 (cross-validated log-likelihood peak); the fixed 10-D model was within 1 standard error of the per-day optimum on 89% (78/88) of days, within 2 SE on all | The IM is a property of the data, not of a hyperparameter |

### Five confounds, all closed

This is the part worth copying as a template — the paper's claim is a *negative* result about one condition, so every alternative account of the asymmetry had to be equalised by design rather than argued away.

| Alternative | Control |
|---|---|
| OM mappings were simply harder to use at first | Initial performance impairment matched across types |
| OM control spaces were farther away, so harder to search for | Mean principal angles between intuitive and perturbed control spaces matched |
| OM required larger tuning changes | Predicted required change in preferred direction (PD), minimising firing-rate change, matched |
| OM had a larger search space (10! candidate `η_WM` vs `q!` candidate `η_OM`) | For monkey L, units were binned into 10 groups permuted as blocks, making the candidate set exactly 10! for both types |
| The animal was covertly moving its arm | Hand speed measured and negligible under both |

The residual honesty: for monkey J the search-space sizes were *not* equalised (39 ± 18 units permuted independently), so the load-bearing version of that control rests on one animal.

---

## Why this matters for building a reasoning model

**1. Low-dimensional structure is a constraint, not a description.** The paper's own framing: dimensionality reduction is not merely a visualisation tool — it reveals *causal* constraints on what a network can express. Everywhere the wiki treats a fitted manifold as a summary of activity, this licenses treating it as a boundary on the reachable set.

**2. Learnability is relative to what the learner already is.** [[wiki/concepts/skill-acquisition-efficiency.md]] defines intelligence as `skill · GD / (priors + experience)` and quantifies priors as a scalar fraction of the solution already present at `t=0`. This is the mechanistic version of that term, and it says the scalar is the wrong shape: what matters is not *how much* prior the system holds but whether the required solution lies in the **span** of the structure it holds. A learner can hold a great deal that is orthogonal to the task and be worse off than one holding little that is aligned.

**(brainstorm) An operational definition of generalization difficulty falls out.** G31 records that `GD` is uncomputable and unapproximated. For any system whose latent basis can be estimated, a computable proxy exists: fit the latent subspace on the pre-training activity, decompose the direction the new task requires into on-span and off-span components, and report the off-span fraction. It is not Kolmogorov complexity, but it is measurable, it is defined per (learner, task) pair rather than per task — which is what a developer-aware measure needs — and Sadtler et al. supply the validation that it predicts learning outcome in at least one real system.

**3. It supplies a mechanism for the two-timescale split the wiki keeps assuming.** The authors' proposal, marked as a posit rather than a result: WM learning harnesses fast **adaptation** mechanisms, OM learning requires the slower machinery of **skill learning** and would need multi-day exposure, possibly with the IM expanding or reorienting. That maps directly onto the fast/slow architecture of [[wiki/concepts/complementary-learning-systems.md]] and gives it an unusual signature — the two timescales are separated not by *how much* is learned but by *whether the change is inside the existing span*.

**(brainstorm) The machine-learning analogue is already deployed and nobody calls it this.** Fine-tuning a frozen backbone with a low-rank adapter or a re-fitted linear head *is* a within-manifold perturbation: the feature basis is preserved and only the readout of existing latents is re-associated. Full fine-tuning that changes the encoder is the outside-manifold case. The prediction this page makes is quantitative and testable on any pretrained model: hold the required output change fixed, decompose it into within-span and off-span components, and sample-efficiency should fall off with the off-span fraction — not with the total size of the change, which is the confound Sadtler et al. controlled with the matched principal angles.

**4. A candidate account of the difference between recombination and invention.** The paper's closing speculation, offered as analogy: **combinatorial creativity** — recombining existing cognitive elements — would be the generation of new patterns *within* the relevant IM, while **transformational creativity** — creating new elements — would require patterns outside it. If that transfers, the wiki's target behaviour (solving a task whose rule was never instantiated) is the expensive kind, and any architecture that only ever recombines an existing latent basis is structurally limited to the cheap kind. This is the same boundary [[wiki/concepts/compositionality.md]] draws between recombining a vocabulary and extending one, arrived at from network structure rather than from symbols.

**5. The unit of volitional control is the latent, not the neuron.** Stated by the authors as an implication rather than a measurement: low-dimensional co-modulation patterns may be the elemental controllables. A model that grants its optimiser free per-parameter access is granting a kind of control no biological learner has.

---

## Open problems

- **Is the IM a hard wall or a slow one?** Nothing here rules out that OM mappings become learnable over days or weeks; the authors expect they might, via IM expansion or reorientation. What the study does show is that ~2 years of alternating exposure did not make OM learning *easier*, which constrains the "just needs practice" reading without killing it. Logged as [[wiki/empirical-tensions.md]] T77.
- **The manifold is linear here.** The IM is a 10-D *subspace* from factor analysis. [[wiki/concepts/population-geometry.md]] establishes that a linear count can overstate a curved manifold's true latent dimension by 7–8×, so it is unknown whether the constraint is really the linear span or a curved surface within it — and the two make different predictions about which "within-manifold" targets are actually reachable.
- **The perturbation is a permutation, which is an odd thing to ask a cortex to represent.** An OM perturbation demands a specific re-assignment of units to latent factors. Whether a failure to learn a *permutation* generalises to a failure to learn any off-manifold pattern is untested; a smoother off-manifold target might behave differently.
- **No mechanism for the constraint.** "Underlying network circuitry" is the stated cause and nothing measures it. The IM is inferred from the very activity it is meant to explain, so the argument that it reflects connectivity is an interpretation, not a measurement ([[wiki/entities/fcann.md]] is the wiki's one case where the low-dimensional structure is instead derived from a coupling matrix).
- **One area, one behaviour.** M1 with a motor readout. Whether an association or prefrontal area's manifold constrains *cognitive* learning the same way is the extrapolation the paper offers and does not test — and it is the one the wiki actually needs.
- **Off-manifold learning has no reported intermediate.** Performance stayed impaired; nothing says whether the animals were partially reorganising, searching unproductively, or not trying. A learning-trajectory measurement of the IM itself during OM exposure is the missing experiment.

---

## Connections

- **[[wiki/concepts/population-geometry.md]]** — supplies the object this page constrains learning by, and receives from it the causal status its own open problems say is missing: the manifold is not only what the activity looks like, it predicts which new activity patterns can be produced after training.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the mechanistic content of that page's `priors` term: what limits learning is not the quantity of prior structure but whether the required solution lies in its span, which also yields a computable proxy for generalization difficulty (G31).
- **[[wiki/concepts/synaptic-plasticity.md]]** — the timescale bound read from the other end: whatever local rules operate over hours can re-weight existing co-modulation patterns but cannot manufacture new ones, so a plasticity rule's expressive reach is bounded by the network's current latent basis.
- **[[wiki/concepts/continual-learning.md]]** — the same span argument with the sign flipped: address-space separation buys non-interference by placing new tasks orthogonally to old ones, and this page says that orthogonal placement is exactly what a network cannot reach quickly — so cheap continual learning and cheap new-skill learning pull against each other.
- **[[wiki/concepts/complementary-learning-systems.md]]** — a candidate signature for the fast/slow boundary that is not about how much is learned: within-span re-association is the fast system's regime, changing the span is the slow system's, and the BCI paradigm separates the two experimentally.
- **[[wiki/concepts/attractor-dynamics.md]]** — the mechanism most likely to *be* the constraint: recurrence that stabilises a manifold is also what forbids leaving it, which makes this page the behavioural cost of G47's built-in topology.
- **[[wiki/concepts/compositionality.md]]** — the same recombine-versus-extend boundary in a different vocabulary: within-manifold patterns are recombinations of an existing basis, outside-manifold patterns require new primitives, and only the first is learnable in hours.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a hard constraint on the discovery half: a learner cannot represent a recovered structure that its current latent basis does not span, so structure discovery is bounded by structure already held — the network-level version of the identifiability problem.
- **[[wiki/concepts/objective-identifiability.md]]** — the strongest available answer to its central complaint: population-level structure is a legitimate target *and*, here, an intervention-supported one, since the same geometry that was fitted to the data goes on to predict the outcome of a manipulation it never saw.
- **[[wiki/architectural-gaps.md]]** — G47 gets its consequence: if a model's manifold topology is imposed by the designer and is wrong for the domain, this page says the error is not merely a representational inaccuracy — it is a region of behaviour the model cannot learn at all.
