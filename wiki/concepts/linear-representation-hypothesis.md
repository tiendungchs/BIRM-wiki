# Linear Representation Hypothesis

**A feature is a *direction* in activation space: the network's state is a superposition `R = Σ_i a_i v_i` of feature vectors, the value of feature `i` is recovered by projection `a_i ≈ R · p_i`, and a belief is changed by addition `R' ← R + α p_d`. If true, reading and writing a network's internal content are both single matrix operations.**

The hypothesis is old (word-vector arithmetic) and was long asserted without a case where the ground truth was known. It now has one: an emergent world model previously reported as *non-linear* is perfectly linear once the feature labels are written in the model's own frame, and the recovered directions steer behaviour by plain addition ([[wiki/entities/othellogpt.md]], Nanda et al. 2023).

---

## Why the linear case is not just a convenient case

| Property | Consequence |
|---|---|
| **The residual stream is a sum** — `x^{l+1} = x^l + Σ_h Att^h_l(x^l) + MLP_l(·)` | Any *linear* function of the stream distributes over that sum, so a read decomposes exactly into per-head, per-layer, per-neuron contributions. This is what makes direct logit attribution, path attribution and the tuned lens possible at all. A non-linearly coded feature admits no such decomposition, and mechanistic interpretability has no foothold |
| **Reads are projections** | The decoder is `d` numbers per feature; there is no capacity argument to be had about whether the probe "computed" the answer ([[wiki/concepts/representation-probing.md]]) |
| **Writes are additions** | An intervention needs no optimisation loop. Editing a belief costs one `axpy`, which turns an interpretability result directly into a **control primitive** |
| **Weight-space analysis becomes possible** | If both a feature direction and a component's output map are linear, their relationship is computable with no forward pass: `CosSim(Emb[m] @ Att_h.V @ Att_h.O, p_Empty(m)) = −0.862` establishes that a first-layer head writes `Not-Played` into other positions, from the weights alone |
| **Superposition** | `d` dimensions can carry ≫ `d` features as near-orthogonal directions, at the price of interference. Linearity is what makes the overcapacity possible *and* what makes the residual noise tolerable |

---

## Evidence

| System | Feature found as a direction | Strength |
|---|---|---|
| **[[wiki/entities/othellogpt.md]]** | Board square ∈ {Mine, Yours, Empty} | 99.6% linear-probe accuracy; **causal** — adding the direction changes play (0.10 / 0.02 errors vs 2.72 null), matching gradient-based editing |
| **[[wiki/entities/othellogpt.md]]** | `Flipped` (squares captured this move) — a *state difference*, not a state | `F1` 96.3; causal (0.486 vs 1.686 null) |
| **[[wiki/entities/maze-solving-transformers.md]]** | Wall presence per cell × direction, whole maze from one token | 0.83–0.99 per wall, correlational only |
| **Llama-3.2-3B-Instruct** (off-the-shelf, text-only) | Spatial relations `left/right`, `above/below`, `in front/behind`, read from the residual stream at layers 8/16/24 | Linear probe reported at parity with an MLP probe on the relation label; inverse pairs antipodal after projection (cos 0.978–0.997 at layer 24); **causal** — `h' ← h + α·v_r` before generation flips the model's stated direction on 74.3% of 600 trials (Tehenan et al. 2025) |
| **Llama-3.2-3B-Instruct** | An *object's position* on that same fitted basis | cos 0.97 between an object-group mean and the relation probe direction; k-means purity 77.5% against spatial labels; top 3 PCs ≈ 100% of probe-direction variance. Correlational |
| Word embeddings, iGPT | Analogy directions; linearly separable image classes from a next-pixel objective | The original observations; no causal test |
| Language-model steering | "Truthfulness" vectors, task vectors, steering vectors | Behavioural effect established; the *feature* is named by the intervention rather than verified against ground truth |
| AlphaZero (chess, Hex) | Human chess concepts linearly decodable | Correlational |
| Biology | Linear decodability of task variables from neural populations; CCGP as the format test | See [[wiki/concepts/population-geometry.md]] — the biological literature reached the same instrument independently, and found that *decodability* and *linear generalisability* dissociate. The convergence is explicit rather than coincidental: Bernardi et al. 2020 name word-embedding parallelogram analogies (`king − queen ≈ man − woman`) as the same coding principle as their parallelism score — one direction that can be translated across content to change one feature consistently — so this page's parallelogram and that page's coding-vector alignment are one measurement stated twice |

---

## The basis problem — the hypothesis is not falsifiable one probe at a time

The Othello case is the clean demonstration. Li et al. 2022 fit linear and non-linear probes for {Black, White, Empty}; linear saturated at ~75% across six layers, the MLP reached 98.7%, and the field recorded "the world model is non-linear". Re-labelling the *same activations* as {Mine, Yours, Empty} — the square's colour relative to whoever moves — put a linear probe above the MLP at every layer (99.6%). The MLP had been spending its capacity re-deriving a parity transform the model never applied.

| Reading of a failed linear probe | Testable? |
|---|---|
| The content is absent | Yes — a stronger decoder settles it |
| The content is coded non-linearly | Assumed by default, and **this is the unsafe step** |
| The content is coded linearly in a basis the experimenter did not enumerate | Almost never tested; there is no procedure for enumerating candidate bases |

The source's own limiting case: suppose a physics model computes gravity and a neuron carries `√distance`. Is distance non-linearly represented, or is `d²` simply the natural feature and the code linear in it? **"Linear" is a property of the pair (representation, feature vocabulary), not of the representation.** Consequences a builder should carry:

- **A null probe result is nearly uninformative** unless the basis search was systematic — which compounds the null-result problem [[wiki/concepts/representation-probing.md]] already records for task distribution and site selection.
- **The wrong basis is the *human* basis by default.** Black/White is what a person looking at a board sees; Mine/Yours is what a legality predictor needs, because the rules are symmetric under colour swap. The general heuristic: **guess the frame the model's own loss is invariant under, not the frame the domain is described in.**
- **The only listed escape is basis-free discovery** — sparse dictionary learning over the activation space, which returns directions with no names and hands identification back to the experimenter, or input-side [[wiki/concepts/counterfactual-probing.md]], which returns a partition without fitting anything.

---

## Composition — the first measurement, and it lives inside a projection

This page's oldest open problem (*"whether relations compose linearly is the property the wiki's framing actually needs, and nothing measures it"*) now has one measurement. Tehenan et al. 2025 prompt an instruction-tuned 3B language model with synthetic two-object scenes ("The cup is above the table. The book is to the left of the cup." — 61 objects, 6 relations), take the mean residual-stream activation per relation class, and ask whether `µ_{above-and-right} ≈ µ_above + µ_right`.

| Space | 2-D relations (4 diagonals) | 3-D relations (12 diagonals) |
|---|---|---|
| **Raw residual stream** (layer 24) | cos **0.395**, angle **66.7°** | cos 0.25–0.41, angle 65.8–75.5° |
| **After projection onto the fitted 3-D PCA subspace** | cos **0.993**, angle **6.02°** | cos 0.82–0.998, angle 3.9–34.4° |

Inverse relations behave the same way: `r_right ≈ −r_left` holds at cos 0.997 in the subspace and 0.964 in the raw stream, while `in front ↔ behind` is *near-orthogonal* raw (cos 0.07–0.12, i.e. not antipodal at all) and 0.995 projected. Subspace quality rises monotonically with depth (above↔below: 0.729 → 0.789 → 0.978 at layers 8/16/24).

**The projection is not a cosmetic step, and the algebra says why.** PCA is linear, so `P(µ_a + µ_b) = Pµ_a + Pµ_b` exactly — projecting cannot create additivity that the *projected* vectors did not already have. What it removes is the component of each class mean lying outside the fitted 3-D subspace, and the 0.40 → 0.99 jump says that residual is **large and not itself additive**. So the honest statement is: *the model carries a 3-dimensional additive relation code plus a larger non-additive remainder at the same site.* Two readings, and nothing here separates them:

| Reading | Consequence |
|---|---|
| The remainder is interference — other features in superposition, plus prompt/format content — and the model's own downstream reads project it away | Composition is real and the subspace is the feature. The supporting evidence is that steering vectors built by projecting PCA directions *back* into the residual stream do move behaviour (74.3%), so at least part of that subspace is read |
| The remainder is content, and "compositional" is a property of the pair (representation, projection) chosen after the fact | Every geometry number reported in PCA space in this literature is a statement about a fitted 3-dimensional summary, not about the object the network computes on ([[wiki/empirical-tensions.md]] T159) |

**The composition claim is never tested causally.** Steering is run on the six *atomic* relations only. Nobody adds `v_above + v_right` and checks that the model says "above and to the right" — which is the one experiment that would move composition from a geometric observation to a mechanism, and it costs a second `axpy`.

**Geometric quality does not predict causal usability — the ranking inverts.** At layer 24 the best-aligned inverse pair is `in front ↔ behind` (cos 0.995) and the worst is `above ↔ below` (0.978); steering succeeds on 5% of `behind` trials and 100% of `above` and `below` trials (600 trials, 100 per relation; overall 74.3%, `left` 100%, `right` 79%, `in front` 62%). A clean antipodal geometry is therefore compatible with a direction the model does not act on, which adds a *fourth* thing a linear feature does not buy and is recorded as T160. The source's own explanation is tokenisation — `in front of` spans several tokens, so a single direction at a single token position cannot carry it — which, if right, means the unit of a linear feature is set by the tokeniser rather than by the concept.

---

## Depth destroys the decomposition, and the rate is measurable

The residual stream is a sum, which is what licenses per-component attribution — but every MLP writes a non-linear function into that sum, so the decomposition degrades with depth. Nanda et al. 2023 put a number on it in Pythia 2.8B by testing the defining property of a linear map on two-token names: if `f` is linear then `f(Michael Jordan) + f(Tim Duncan) = f(Michael Duncan) + f(Tim Jordan)`, so measure the distance between the two midpoints and normalise by the distance to arbitrary unknown names.

| Object | Fraction of the way to fully broken linear structure |
|---|---|
| MLP outputs, layers 2–6 | 60–70% |
| The same layers, weights and biases **randomly shuffled** | 20–40% |
| Residual stream after layer 2 → after layer 6 | 30% → 50% |

Two consequences, and the second is the uncomfortable one.

- **Breaking linear structure is a trained behaviour, not an artefact of nonlinearity.** The shuffled-weight control breaks it two to three times less, so the model is *using* its MLPs to destroy the additive structure of its own input — the hash half of hash-and-lookup ([[wiki/concepts/memorisation-vs-generalisation.md]], [[wiki/concepts/pattern-separation-completion.md]]).
- **Interference between linearly represented features accumulates over depth, and it is mistakable for computation.** If `is_a_mathematical_text` and `is_the_token_"the"` are both directions, an MLP that mixes them will produce a direction for their conjunction whether or not anything downstream reads it. Sparse-autoencoder dictionaries report exactly such features ("the token 'the' in mathematical texts"), and this measurement says the null hypothesis for any conjunctive feature is that depth manufactured it. The instrument that separates the two cases is **non-linear excess** across a single nonlinearity ([[wiki/concepts/memorisation-vs-generalisation.md]]): a unit that *computes* a conjunction shows a positive change in `E[a|A∧B] − E[a|¬A∧B] − E[a|A∧¬B] + E[a|¬A∧¬B]` across its own GELU; a unit that merely inherits one does not. In the sports circuit the median ratio of GELU-formed to total conjunction effect at the output head was **23%**, i.e. most of the AND arrived pre-formed.

---

## What a linear feature does *not* buy

- **It does not say the feature is used.** Directions can be present and behaviourally inert ([[wiki/empirical-tensions.md]] T25); only intervention settles it, and this page's central case is valuable precisely because it did the intervention.
- **It does not say the feature is used *on this input*.** In OthelloGPT the board direction is verified causal and the model still often computes legal moves at an earlier layer than the board in end games (`MoveFirst`), which implies a second, cheaper circuit running in parallel (T158). An averaged intervention score cannot separate "always used, partially" from "fully used, sometimes".
- **It does not say the direction is one feature.** Under superposition a fitted direction may be a mixture of several sparsely-active features that happen to co-occur on the probe set.
- **It does not explain itself.** Why linear codes emerge from gradient descent is open. The only gesture on offer — a matrix multiplication can cheaply extract a *different* linear subset of features for each downstream unit, so linear encoding is the format that makes every downstream read cheap — is a plausibility argument, not a derivation. Nothing in any objective in the wiki rewards it (gap **G30**).

---

## Applying it to build a reasoning model

| Use | How |
|---|---|
| **Make the `g`/`x` split checkable** | If structural position and content are separate *subspaces*, factorization becomes a measurable angle rather than an aspiration: fit `p_g` and `p_x` at the same site and test mutual generalisation (gap G1) |
| **Make path-consistency a vector identity** | G3 asks that the same graph position reached by different routes give the same code. With linear features this is a residual `‖g(path₁) − g(path₂)‖`, and — more usefully — the composition of edge-actions can be tested as *addition* of edge directions |
| **Turn a probe into an actuator** | A verified feature direction is a write port. Installing a goal, a context or a counterfactual state needs no retraining and no gradient loop — one addition at inference. This is the cheapest existing mechanism for "tell the architecture its latent structure" (gap G45) |
| **Prefer relative frames when the loss has a symmetry** | The model chose a mover-relative code because legality is colour-symmetric. Building the invariance into the code halves what must be learned and de-aliases repeated observations (G2) — and it is the machine analogue of an egocentric frame |
| **Look for `Δstate` as a feature** | A transformer cannot iterate, so where a recurrent system would apply a delta to a carried state, a depth-parallel one may represent the delta *itself* (`Flipped`). In a learned world model with no explicit transition function, the transition may be findable as a direction |
| **Report the basis, always** | Any probe table without its label ontology stated is uninterpretable, since the ontology can move a result from 75% to 99.6% with nothing else changed |

---

## Open problems

- **No procedure enumerates candidate bases.** The single most consequential free parameter on this page is chosen by intuition.
- **No objective rewards linearity**, so it remains a by-product that a change of architecture or scale could remove without warning (G30).
- **Superposition and identification are unresolved together**: sparse autoencoders escape the labelling circularity but produce features whose names must still be guessed, and whose count is a hyperparameter.
- **Linearity of *composition* is measured once, and only geometrically.** Relation directions in a 3B language model add to within 6° of the directly-learned composite — but only after projection onto a fitted 3-D subspace, where the raw-space angle is 67°, and with no causal test of the composed direction. The free parameter has moved from the label basis to the *subspace*, and no procedure sets that either (Tehenan et al. 2025, T159).
- **Geometry and causality are not the same ranking.** The most perfectly antipodal relation pair in that model is the one steering cannot move (5% vs 100%), so a well-formed direction is not evidence that the direction is a handle (T160).
- **The causal tests are all additive edits at every layer.** None localises where a direction is *read*, so "the model uses it" is established without the read site being known.

---

## Connections

- **[[wiki/entities/othellogpt.md]]** — the page's strongest evidence and the source of every number on it: a world model reported as non-linear turns out to be linear under a re-parameterised label set, and its directions steer behaviour by plain addition at parity with gradient editing.
- **[[wiki/concepts/representation-probing.md]]** — the instrument page this one supplies the underlying hypothesis for: probing is only a cheap, capacity-free instrument *because* features are conjectured to be directions, and the basis problem here is a new way for a probe null to be wrong.
- **[[wiki/concepts/population-geometry.md]]** — the same claim from the neural side and with a stronger vocabulary: directions are the elementary case of a geometry, and the biological instruments (CCGP, parallelism) test not just whether a linear read exists but whether it *transfers*, which is what "in usable form" should mean here too.
- **[[wiki/concepts/abstract-structural-codes.md]]** — states the factorization this page makes measurable; the mover-relative Othello code is a content-invariant re-referencing discovered by gradient descent rather than built in.
- **[[wiki/concepts/attention.md]]** — linearity is what lets an attention head's *function* be read from `Emb @ V @ O` without a forward pass, which is how the `Played`/`Empty` circuit was identified.
- **[[wiki/concepts/shortcut-learning.md]]** — a linear feature being causal does not mean it is on the path taken: the same model that provably uses its world model also has a cheaper circuit that bypasses it.
- **[[wiki/concepts/counterfactual-probing.md]]** — the alternative when the basis cannot be guessed: intervene on the *input* of a generative model and cluster the responses, which needs no feature vocabulary at all.
- **[[wiki/entities/maze-solving-transformers.md]]** — the same instrument on a supplied rather than discovered graph, and the one that stops before the causal step; together the two bracket what a linear-probe result can mean.
- **[[wiki/concepts/compositionality.md]]** — the property this page's newest section measures: relations as directions that *add* is compositionality reduced to vector arithmetic, with inverses as negation, and it is the cheapest possible instantiation of a primitive-plus-arrangement vocabulary.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the axis that fails is the one whose frame is ambiguous: `above/below` is gravity-anchored and steers at 100%, `in front/behind` needs a viewpoint convention and steers at 5%, which is a frame-selection problem showing up inside a probe result.
- **[[wiki/concepts/energy-based-models.md]]** — the constructed counterpart: where a latent is designed low-capacity and discrete, linear readability is stipulated instead of hoped for, which is this page's requirement met by architecture rather than by luck.
- **[[wiki/entities/dinov2.md]]** — the engineering form of this page's premise: fine-tuning a 1.1B backbone end-to-end beats a single linear layer on its frozen features by 2.0–2.2 points, and depth — never trained on — is linearly decodable from patch tokens, so "the underlying information is readily available" is a deployment claim before it is an interpretability one.
- **[[wiki/entities/arc-vsa-solver.md]]** — linear readability as a design constraint instead of an empirical finding: the learned rule condition is a unit-norm vector in the same algebra as the objects it classifies, so "the concept" and "a direction" are the same object by construction and the classifier is a prototype similarity plus a learned sigmoid.
- **[[wiki/entities/conceptor.md]]** — the same commitment with the represented object enlarged from a direction to a weighted *set* of directions: a positive semi-definite `C` with singular values in `[0,1]` is a soft subspace, reads are the quadratic form `x'Cx`, and the operations defined on it are logical (`∧ ∨ ¬`, Löwner abstraction) rather than arithmetic — which is what a direction alone cannot support (Jaeger 2014).
- **[[wiki/entities/ventral-visual-stream.md]]** — the hypothesis' strongest biological warrant and the reason a capped reader is a method rather than a convenience: no information is created along a sensory cascade, so a fixed-complexity decoder measures *format*, and by that measure identity decodability rises monotonically V1 → V4 → inferior temporal cortex.
- **[[wiki/concepts/manifold-untangling.md]]** — states what "linearly decodable" buys geometrically (flat, separated, aligned object manifolds) and what it costs to test honestly (held-out transformation conditions, not held-out samples).
- **[[wiki/concepts/memorisation-vs-generalisation.md]]** — the rate at which this page's premise decays with depth, plus the regime where the premise is beside the point: trained MLPs break the residual stream's additive structure two to three times harder than shuffled weights do, so conjunctive "feature A in context B" directions are the expected by-product of depth rather than evidence of computation — and for a task with no macrofeatures, a direction can be exactly recovered and still name nothing.
- **[[wiki/concepts/multi-token-embedding.md]]** — this page's premise doing load-bearing work and being undermined in the same circuit: an entity's attributes are read by projection from the residual stream (linear, and the model's own extraction head agrees with a fitted probe to 86%), while the layers that *build* that representation are the ones measured to destroy additive decomposability fastest.
