# RAVEN — procedurally generated Raven's-Progressive-Matrices problems, and what concept variations do to its scores

**70,000 machine-generated 3×3 matrix-completion problems with eight candidate answers, built so that deep networks have enough data to train on — and the wiki's clearest case of a benchmark whose shortcut sat in the *answer set* rather than in the model.**

> **Provenance.** Odouard & Mitchell 2022, *Evaluating Understanding on Conceptual Abstraction Benchmarks* (`raw/odouard-2022-conceptual-abstraction-benchmarks.md`, EBeM'22 workshop, Santa Fe Institute) supplies every concept-variation number and the account of the answer-set bias. The dataset itself (Zhang et al. 2018), its two repairs I-RAVEN and RAVEN-FAIR, PGM, MRNet and SCL are all reported **second-hand** through it; none of those primaries is in `raw/`. Human baseline, model architectures and the >90% context-blind result are therefore `(tentative)` at this page's level of evidence.

---

## Format

| Property | Value |
|---|---|
| Item | 3×3 matrix of figures, ninth cell missing; pick the filler from **8 candidates** |
| Generation | Sampled from a hierarchical stochastic image grammar — layout (Center, 2×2Grid, 3×3Grid, Out-InCenter, Out-InGrid, Left-Right, Up-Down) → shapes (circle, square, triangle, pentagon…) → attributes (colour/grey-scale, size, angle, number, position) → row relation (constant, progression, arithmetic) |
| Size | 70,000 problems: 42,000 train / 14,000 validation / 14,000 test |
| Human baseline | **84%** mean on the test set (Zhang et al. 2018) |
| Sibling | PGM — same idea, a different generator, and the one with a primary source in the wiki ([[wiki/entities/pgm.md]]) |

The generator is the point of contrast with [[wiki/entities/arc-agi.md]]: a master program that emits arbitrarily many i.i.d. items is what makes deep-network training possible *and* what sets the benchmark's generalization difficulty near zero for any solver that reverse-engineers it ([[wiki/concepts/skill-acquisition-efficiency.md]]).

---

## The answer-set shortcut

The original generator built the 7 distractors by **taking the correct answer and perturbing one attribute**. Consequences:

| Consequence | Statement |
|---|---|
| **Majority vote over the candidate set solves the item** | For each attribute, the modal value across the 8 candidates is the correct answer's value, because every distractor deviates from the correct answer in exactly one attribute |
| **Measured** | A network trained **solely on the answer choices**, never shown the matrix, exceeds **90%** — above the 84% human baseline `(tentative)` |
| **Repairs** | I-RAVEN and RAVEN-FAIR regenerate the candidate sets by less exploitable procedures; several groups then reported >84% on these versions too |

The super-human scores this table sits next to are logged as [[wiki/empirical-tensions.md]] T210: a leaderboard number here is a purchase from a public generator plus, on the original set, a leak from the answer set, and the concept-variation drops below are the other side of it.

**Why this belongs in the wiki.** It is a benchmark-side shortcut of the same family as the `argmax` tie-break and the missing negative image in the vision-language compositionality suites ([[wiki/concepts/cross-modal-grounding.md]]): the item is answerable without consulting the input the benchmark exists to test. And it retro-justifies an assertion [[wiki/entities/arc-agi.md]] makes on design grounds alone — *"a multiple-choice version would admit elimination shortcuts"* — with a measurement. Constructing the answer from scratch is not a stylistic preference; it deletes a channel that here was worth more than the entire human baseline.

Note the direction of the fix and its limit: I-RAVEN/RAVEN-FAIR repair the *distractor generator*, which closes this particular channel. They do not touch the generator that produces the matrices, so the underlying "one master program emits the whole set" property survives every repair.

---

## Concept-based evaluation, run on this benchmark

The paper's method (see [[wiki/concepts/shortcut-learning.md]] for the general statement): pick a concept the system is *known to get right* on i.i.d. items, hand-author items that instantiate the **same concept through different attributes and layouts**, and read the drop.

Setup: MRNet (Multi-scale Relation Network) and SCL (Scattering Compositional Learner), both public code, trained on 30,000 RAVEN items over five of the seven layouts, evaluated on 10,000 held-out items of those layouts. Both score each candidate independently, so neither is affected by the answer-set bias above — this is a clean measurement on the *original* dataset.

| Model | RAVEN test set (10,000) | *Sameness* variations (210) | *Progression* variations (80) |
|---|---|---|---|
| MRNet | 73% | **49%** | **44%** |
| SCL | 89% | **62%** | **68%** |

What the variations vary, holding the concept fixed:

- **Sameness** — all attributes constant along a row; only colour constant; number *and* shape constant; the inner object the same shape as the outer object. Both models solve the first two and fail the last two.
- **Progression** — progression in the number of polygon sides; the same relation with multiple objects at different positions; progression in the size of the *outer* figure; progression in the *number of objects*. SCL fails only the last; MRNet fails the multiple-object and count versions.

**The failure profile is the informative part.** Both models handle a relation carried by the attribute-slot the generator most often varies, and lose it when the same relation is carried by a *different* slot (count, or a relation between the inner and outer object). That is the relation being represented as a property of an attribute channel rather than as a relation — which is [[wiki/concepts/abstract-structural-codes.md]]'s content/structure split failing on the structure side, measured at 20–29 points.

Two caveats the authors state: the variations were authored by hand and believed easy for humans, but **no human baseline was collected on them**, and the sets are small (210 and 80). The variations therefore inherit the developer-authorship problem in full — the score is against *these* authors' notion of the concept.

---

## The same instrument on ARC

Applied to ARC-Kaggle2 (the 2020 Kaggle competition's second-place program, 19% on the hidden test set), on two concepts drawn from tasks the program answered **correctly**:

| Concept | Variations | Score (3 guesses/task) |
|---|---|---|
| Original ARC test set | — | 19% |
| **top / bottom** ("extract the colour of the topmost stripe" → "extract the topmost object" → "move the object below the stripe") | 14 | **29%** |
| **boundary** ("move all objects to the red boundary" → "extract the stripe reaching the blue boundary" → "move all objects to their closest outer vertical boundary") | 12 | **8%** |

**The non-monotone result is the finding, not noise in it.** A concept-variation score is not a harder version of the benchmark score: it went *up* on one concept and fell by more than half on the other, from the same program, on concepts it demonstrably handled on the original items. So a single benchmark number is a mean over a concept mixture with unmeasured per-concept variance, and the per-concept score is the quantity that carries information about which structures the system actually holds. This is [[wiki/entities/arc-agi.md]]'s unquantified-`GD` limitation (G31) approached from a direction Chollet's own proposal does not cover: not per-*task* difficulty, but per-*concept* coverage.

---

## Comparison

| | RAVEN (original) | I-RAVEN / RAVEN-FAIR | ARC | Concept-variation sets |
|---|---|---|---|---|
| Items generated by | Master grammar | Same grammar, repaired distractors | Hand-authored | Hand-authored around one concept |
| Answer | Choose from 8 | Choose from 8 | **Constructed from scratch** | As the base benchmark |
| Train/test relation | i.i.d. | i.i.d. | Disjoint tasks | **Deliberately non-i.i.d. *and* non-independent** |
| Size | 70,000 | 70,000 | 1,000 | 12–210 per concept |
| What a high score licenses | ≤ nothing (context-blind >90%) | Solving items from a known generator | Broad generalization on the sampled tasks | Use of one concept across instantiations |

---

## Connections

- **[[wiki/concepts/shortcut-learning.md]]** — the general statement of the instrument this page supplies numbers for: concept-based evaluation deliberately breaks both i.i.d. *and* independence, because the items are generated by varying one factor around a concept, and the drop from the i.i.d. score is the measurement.
- **[[wiki/entities/arc-agi.md]]** — two exchanges: this page supplies the measurement behind ARC's from-scratch-answer design decision (a context-blind RAVEN solver beats the human baseline), and ARC supplies the target for the same instrument's second run (ARC-Kaggle2 at 19% → 29% / 8% on two concepts it solves on the original items).
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — RAVEN is the case the theory predicts: a public master generator sets generalization difficulty near zero, so 70,000 items buy skill on the generator and the concept-variation scores are what is left when the generator is stepped outside of.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the diagnosis the failure profile points at: both models hold *Sameness* and *Progression* bound to the attribute channel they were trained through, and lose them when the identical relation is carried by count or by an inner/outer object pair, which is a relation encoded as content rather than as structure.
- **[[wiki/concepts/cross-modal-grounding.md]]** — the same species of benchmark-side defect: an item answerable without consulting the input under test, there by a tie-break and an absent negative image, here by a distractor generator that leaks the answer through attribute-wise majority vote.
- **[[wiki/concepts/analogical-mapping.md]]** — matrix completion is the psychometric form of the mapping problem, and the measured failure is on exactly the axis that page calls load-bearing: transfer of a relation across a change in the objects and attributes carrying it.
- **[[wiki/concepts/core-knowledge.md]]** — the concepts probed on the ARC side (*top/bottom*, *boundary*) are instances of the geometry-and-topology prior, and the 8% boundary score is evidence that solving items which *use* a prior does not mean the prior is installed.
- **[[wiki/entities/conceptarc.md]]** — this page's instrument scaled into a standing benchmark by the same group: 16 concepts × 10 variations × 3 test inputs, and a 415-participant human study that closes the exact caveat recorded above (variations "believed easy for humans", baseline never collected).
- **[[wiki/entities/pgm.md]]** — the sibling generator with its own primary source, and the measurement that prices this page's answer-set shortcut: PGM builds distractors without perturbing the correct answer, and its context-blind baseline is 22.4% against RAVEN's >90% — plus the axis this page has no version of, a train/test split declared over the abstraction (held-out triples, attributes, value ranges) rather than over pixels.
- **[[wiki/entities/gpqa.md]]** — the standing risk this page measured, in a knowledge benchmark: GPQA's defence against candidate-set shortcuts is that simple classifiers cannot infer the key from surface features, which rules out RAVEN-style perturbation tells but not elimination-by-plausibility — a strategy a strong language model has and GPQA's human non-expert control does not.
- **[[wiki/concepts/certification-instruments.md]]** — instrument `I10`'s origin, and the benchmark whose answer-set leak is worth more than its entire human baseline — the sharpest case for scoring a concept across instantiations rather than i.i.d.
- **[[wiki/concepts/human-baseline.md]]** — the baseline a context-blind network beats: 84% measured in 2018, exceeded at >90% by a model never shown the matrix, and still quoted against 2025 systems.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — the human latency curve on this benchmark's psychometric parent, and a scoring axis it does not have: on the 24-item Penn Matrix Reasoning Test, higher-scoring participants are *faster* on the first 8 items and *slower* on the remaining 16 (`N` = 1176), so solve time crosses over with difficulty — a profile no fixed-inference-budget solver can produce (Schirner et al. 2023).
