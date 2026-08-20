# Shortcut Learning

**A shortcut is a decision rule that solves the training and i.i.d. test data but fails under distribution shift — the learner recovered a sufficient correlation instead of the intended structure (Geirhos et al. 2020).**

This is the failure mode the whole wiki is organized against. In the core framing ([[wiki/concepts/latent-graph-discovery.md]]) a shortcut is a **spurious edge that survives training because nothing in the objective distinguishes it from a causal one** — hardness source 5, gap G6. Geirhos et al. 2020 supply what that framing lacked: evidence that this is the *default* outcome across every subfield, an account of why, and the only measurement that detects it.

---

## Taxonomy of decision rules

Nested sets, each stricter than the last (Geirhos et al. 2020, Fig. 3):

| Rule class | Solves training set | Solves i.i.d. test | Solves o.o.d. test | Feature type |
|---|---|---|---|---|
| Non-solution | ✗ | ✗ | ✗ | uninformative |
| Overfitting solution | ✓ | ✗ | ✗ | overfitting |
| **Shortcut** | ✓ | ✓ | ✗ | shortcut |
| Intended solution | ✓ | ✓ | ✓ | intended |

**The decisive consequence: the top two rows are indistinguishable under i.i.d. evaluation.** Toy case — stars vs. moons separable by (a) shape, (b) white-pixel count, (c) location; a fully connected network learns (c). "Which rule is intended is in the eye of the beholder": *the intended solution is not a function of the training data.* It enters only through inductive bias.

For the wiki this is a statement about the meta-graph. The intended solution is the one whose edges hold across the whole environment family; a shortcut is an edge that holds only in the sampled instances. **A learner given one environment cannot tell them apart in principle** — which is why the two-level hierarchy is not merely a sample-complexity convenience but the *identifiability condition* for the intended rule.

---

## Where shortcuts come from

| Origin | Mechanism | Evidence |
|---|---|---|
| **Shortcut opportunities in data** | Systematic object↔context relations are natural, not artefactual (cows on grass; a hospital-specific metal token co-varying with pneumonia prevalence) | Persist at scale — "Big Data" does not dilute systematic bias; data alone rarely constrains a model, and cannot replace assumptions |
| **Discriminative feature selection** | Any feature sufficient to discriminate is taken; no notion of how features *combine* to define an object. Texture suffices for ImageNet, so global shape is largely ignored | Decision rules resting on a *single predictive pixel*; **excessive invariance** — models invariant to nearly every feature humans use |
| **Sub-symbolic subtlety** | High-frequency patterns invisible to humans are highly predictive; adversarial examples are perturbations of exactly these | Adversarial vulnerability read as a *symptom* of shortcut learning, not a separate defect |

**Biological parallel (the paper's central move): shortcut learning is a property of learning systems, not of deep networks.**

| System | Phenomenon | Failure |
|---|---|---|
| Rats in a maze | *Unintended cue learning* — apparent colour discrimination was odour discrimination of the paint | Ability vanishes when smell is controlled |
| Students | *Surface learning* — rote reproduction | Scores *well* on multiple-choice, fails on essay questions |
| Animal conditioning | *Blocking effect* — an already-predictive cue prevents association of a new, equally predictive one | The behavioural analogue of excessive invariance |
| Language change | *Principle of least effort* — form erodes toward minimal speaker effort, shaped by anatomy (architecture) and prior experience (data) | — |

**Implication for the brain-as-prior argument.** The brain does not escape this failure mode; it is *subject* to it. So the biology cannot be mined for a shortcut-proof learning rule — what differs is which solutions are cheap, i.e. the priors ([[wiki/concepts/neuroscience-ai-transfer.md]]).

---

## Generalisation is misdirected, not absent

Deep networks generalise o.o.d. *enormously* — an abstract pattern with a curved body and strings is classified "guitar" with high certainty; huge sets of images humans see as noise map confidently to object categories. Conversely, rotation, blur, a few pixels of translation, or a texture swap on intact shape derail predictions.

> **Generalisation failure is neither a failure to learn nor a failure to generalise — it is a failure to generalise in the *intended direction*. Using a feature set creates insensitivity to everything else; the model generalises o.o.d. exactly along the axes its chosen features ignore.**

This cuts against reading o.o.d. failure purely as capacity or as mixture-fitting — recorded as T6 in [[wiki/empirical-tensions.md]]. Operationally the two readings differ in prescription: *fit the right object* (add hierarchy) vs. *choose the right invariances* (add bias).

---

## The four levers: inductive bias

Whether a solution is easy to learn — and shortcuts are learned because they are easy — is fixed by four components jointly, not by data alone (Geirhos et al. 2020, Box II). This is the wiki's **control surface**: the complete list of places a bias toward graph-structured solutions can be inserted.

| Lever | How it biases | Known effects |
|---|---|---|
| **Structure — architecture** | Convolution makes *location* hard to use, a prior strong enough that untrained networks support inpainting and denoising; transformer attention layers model inter-word relations | Implicit priors are mostly opaque; even ReLU produces unwarranted far-from-data confidence |
| **Experience — training data** | Blocking a specific shortcut by construction | Works for adversarial vulnerability and texture bias; adding *more* data does not |
| **Goal — loss function** | **Cross-entropy stops learning once a simple sufficient predictor is found**; modifications force use of all available information; regularizers using extra dataset information disentangle intended from shortcut features | The most direct lever on "how much evidence must the rule use" |
| **Learning — optimisation** | Stochastic gradient descent is biased toward simple functions; *large* learning rates learn simple patterns shared across examples, *small* ones enable complex-pattern learning and memorisation | Architecture×optimiser interaction poorly understood; strong claims only in simple cases |

**Three levers or four?** Richards et al. 2019 give the same control surface with **training data removed**: objective function, learning rule, architecture are the three things a designer specifies, and the environment is "a crucial consideration to anchor the core components, but not one of the components itself" — on the grounds that the components must pass through the genome while the environment supplies the unbounded information. Geirhos et al. 2020's data lever is the one that blocks a shortcut *by construction*, which is precisely what this page shows is needed and what the three-component reading demotes. Recorded as [[wiki/empirical-tensions.md]] T15; full statement of the rival framing on [[wiki/concepts/three-component-framework.md]].

**(brainstorm)** Read against the wiki's target: the factorization `p = f(g, x)` is a *shortcut-avoidance device*. A shortcut is by construction a rule that reads `x` where the intended rule reads `g`; nothing in the data distinguishes them, so the split must be imposed on one of these four levers. The wiki has so far treated `g`/`x` separation as something an architecture would *discover* (G1). This source says it cannot be — it must be *paid for* by bias, and the four rows above are the exhaustive set of accounts to pay from. The cross-entropy row is the sharpest candidate: a loss that terminates at the first sufficient predictor will never search for the structural one when a content one is available.

---

## Diagnosis and measurement

| Practice | Statement |
|---|---|
| **Dataset ≠ ability** | ImageNet was meant to measure object recognition; models largely count texture patches. A dataset is useful only while it remains a proxy for the ability. Reproducing labels per se is uninteresting — a lookup table does that |
| **Morgan's Canon for machine learning** | *Never attribute to high-level abilities that which can be adequately explained by shortcut learning.* Blocks the **same-strategy assumption**: human-level performance does not license inferring a human-like algorithm (Marr's algorithmic level is unconstrained by matched behaviour) |
| **Surprisingly strong baselines** | Run a model that provably lacks the intended feature — local features only, single cue words, answering movie questions without the movie. If it scores well, the benchmark admits a shortcut |
| **o.o.d. testing as default** | The i.i.d. assumption has been called "the big lie in machine learning"; i.i.d. validation is structurally incapable of separating rows 3 and 4 of the taxonomy |

**The strong baseline built into the *trial set* rather than run as a separate model** (Qu et al. 2026). On a 2-D rank map, every comparison is either **congruent** (one item dominates on both dimensions, so "which one usually wins" answers it) or **incongruent** (each item dominates on a different dimension, so only the joint structure answers it). The two trial types are visually and procedurally identical and are matched in frequency across all subjects, so the contrast holds everything fixed and varies only whether the shortcut is available.

What it buys: 8-year-olds score well above chance overall (0.64) — and that aggregate is entirely carried by congruent trials (0.68 vs **0.53, chance**, difference `p` < 0.001). A single accuracy number would have reported partial competence where there is none. The split also has a neural moderator: the congruency gap shrinks with age *only* in subjects with strong entorhinal grid codes (three-way age × grid-strength × congruency interaction, `β` = 0.024, `p` = 0.002), which is the wiki's only case of a structural-code measurement predicting *which of two strategies* a subject uses rather than how well they perform ([[wiki/concepts/abstract-structural-codes.md]]).

**(brainstorm) This generalises to any benchmark whose items live in a product space, ARC included** ([[wiki/entities/arc-agi.md]]): partition the item set by whether a marginal statistic suffices, and report the two accuracies separately. It is cheaper than every instrument below it — no second model, no distribution shift, no new data — and it converts Morgan's Canon from a warning into a number, because the shortcut-solvable subset *is* the surprisingly-strong-baseline score. Its limit is that it needs the intended structure known in advance to define the partition, which is exactly what the identifiability problem denies in the general case (G16).

**Two instruments that need no distribution shift** (Lake et al. 2017). Both hold the trained model fixed and vary the *query* instead of the data:

- **The richness protocol.** A concept, if it is a model, supports classification, generation, parsing, creation of new concepts, explanation and communication. A shortcut rule is by construction a mapping to one output type, so it answers row 1 and fails the rest ([[wiki/concepts/causal-model-building.md]]).
- **The re-goaling protocol.** Fix the transition structure, swap the reward function, and see how much retraining is needed. Humans re-goal a video game to any of a dozen novel objectives with little or no relearning; a model-free network must be retrained ([[wiki/concepts/simulation-based-planning.md]]).

Their limitation is the mirror of their cheapness: a system trained multi-task on all the queries could pass without any of the abilities being consequences of one underlying model.

**Where the relation slot fails.** Caption networks return the key objects of a scene and the wrong relations between them — a man being thrown off a horse read as "a woman riding a horse on a dirt road", a crashed airplane as "an airplane is parked on the tarmac". This is a shortcut with an unusually clean localization: the parts are recovered, the arrangement is not represented at all, so the model emits the arrangement most frequent in training ([[wiki/concepts/compositionality.md]]).

**Three conditions for a good o.o.d. test:** (1) a *clear distribution shift*, human-perceptible or not; (2) a *well-defined intended solution* (training on natural images and testing on white noise is a shift with no solution); (3) *current models struggle* — most conceivable shifts are uninteresting. Benchmarks must co-evolve with models: the Winograd Schema Challenge, designed to close Turing-test shortcuts, was later found to contain more shortcut opportunities than intended.

**o.o.d. benchmark families named** (no wiki pages yet — see [[wiki/index-entities.md]]): adversarial attacks (model-specific worst case) · ARCT with shortcuts removed · cue-conflict stimuli (texture vs. shape, directly human-comparable) · ImageNet-A (natural worst case) · ImageNet-C (15 corruptions) · ObjectNet (scientific controls over background, rotation, viewpoint) · PACS (domain generalisation by design) · Shift-MNIST / biased CelebA / unfair dSprites (injected correlations; measures how prone an architecture+loss pair is to taking a shortcut).

The last family is the instrument the wiki actually needs: a *controlled* shortcut with a known intended rule turns "does this architecture recover structure?" into a measurable quantity.

---

## Routes beyond shortcuts

| Route | Mechanism | Relation to the framing |
|---|---|---|
| **Domain-specific prior knowledge** | Architectural invariance or data augmentation for known-irrelevant transformations; auto-augment as its general form; extreme augmentation is the core of current semi- and self-supervised methods | Hand-specified `g`/`x` split for one known nuisance axis; does not scale to unknown structure |
| **Adversarial robustness** | Adversarial examples as *counterfactual explanations* — the smallest input change producing a given output; robust models are somewhat more human-aligned and generalise better | Ties robustness to causality: aligning counterfactuals is aligning edges |
| **Domain adaptation / generalisation / randomisation** | Multiple training distributions; under assumptions the intended (or causal) rule is identifiable from several environments. Domain randomisation closes the simulation-to-real gap | **The environment family of the two-level hierarchy is exactly this multi-environment signal** — the meta-graph is what is invariant across instances |
| **Meta-learning** | Representations that adapt quickly to new conditions; fast adaptation is connected to *identification of causal graphs*, since causal features require small changes when the environment changes | Direct: [[wiki/concepts/meta-learning.md]] gets a second justification — not just sample efficiency but shortcut resistance |
| **Generative modelling and disentanglement** | Modelling every variation forces the network to account for all of it; disentanglement seeks the true generating factors via independent causal mechanisms | Generation alone does not give useful or o.o.d.-robust representations; the structure has to be demanded of the latent space |

---

## Open problems

- **Identifiability.** No procedure recovers the intended rule from data alone; the assumptions must come from outside. What is the minimal set for graph-structured solutions?
- **Which lever, and how much?** The four levers interact and the interactions are not understood. There is no theory saying which one to spend on for a given shortcut.
- **Is the multi-environment signal sufficient?** Invariance across environments identifies causal edges *under assumptions*. Whether an environment family generated by real task variation meets them is untested.
- **Cheap o.o.d. tests.** No simple, general procedure exists to replace i.i.d. benchmarking; every listed benchmark is domain-specific and hand-designed.
- **Can shortcut learning be eliminated at all?** The paper's own position is that full elimination may be impossible — only better alignment between learned and intended solution.

---

## Connections

- **[[wiki/entities/hag-reservoir.md]]** — the objection transposed onto architecture search: a purely unsupervised structural rule wires together whatever co-fluctuates in the input, so a high-variance nuisance regularity gets an edge as readily as a task-relevant one — "task-specific" there means specific to the input distribution, never to the task.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a shortcut *is* hardness source 5 realized: an edge that fits in-distribution and breaks out of it; this page supplies the evidence that it is the default outcome and that i.i.d. evaluation cannot detect it.
- **[[wiki/concepts/meta-learning.md]]** — the environment family the outer loop samples is the multi-environment signal that makes invariant (causal) edges identifiable, so fast adaptation and shortcut resistance are the same property viewed twice.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — Morgan's Canon is the discipline this transfer channel needs in reverse: matched behaviour licenses no inference about the algorithm, and biological learners take shortcuts too, so the brain supplies better priors rather than immunity.
- **[[wiki/concepts/abstract-structural-codes.md]]** — a shortcut is a rule that reads content `x` where the intended rule reads structure `g`; a content-invariant code is the architectural lever that makes the structural rule the cheaper one.
- **[[wiki/concepts/attention.md]]** — attention chooses which features enter the decision, so it is a shortcut-selection mechanism as much as a retrieval one: what it fails to select becomes an excessive invariance.
- **[[wiki/concepts/continual-learning.md]]** — a shortcut consolidated into slow weights is worse than one held transiently, since importance-gated plasticity will protect it; what gets written must be validated o.o.d. first.
- **[[wiki/concepts/synaptic-plasticity.md]]** — a purely local rule is by construction a coactivity detector, so it has no lever by which to prefer a causal edge and reproduces this failure mode inside the fast store (gap G19).
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — applies the optimizer lever to the update rule rather than to the weights, which is the one route by which the multi-environment identifiability argument could reach a local plasticity rule.
- **[[wiki/concepts/core-knowledge.md]]** — the concrete content of the architecture lever: a specific enumerated set of relational priors, each gated by an applicability test, which is the property every machine prior on this page lacks.
- **[[wiki/concepts/universal-induction.md]]** — the limit case of the inductive-bias argument: the simplicity prior is the one bias provably sufficient to identify any computable rule, and it works *only* where the learner's outputs do not shape its data, so on the active slice the identifiability problem survives a perfect Occam bias.
- **[[wiki/concepts/causal-model-building.md]]** — the same distinction stated positively: the intended rule is the one whose steps match the world's generative steps, and the fix is partly a *training-data* lever, since the criticized models were never given causal data nor an incentive to recover the process.
- **[[wiki/concepts/compositionality.md]]** — supplies the sharpest localized instance (objects right, relations wrong) and the cheapest probe for it: ask the model to parse, and compare its intermediate structure with a human parse.
- **[[wiki/concepts/simulation-based-planning.md]]** — supplies the re-goaling protocol: hold transitions fixed, swap the reward, and measure retraining — an intended-solution test that costs no distribution shift.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — a concrete bet on the architecture lever: three *typed* prediction channels (top-down, spatial, temporal) in which a purely appearance-based rule is not expressible by the spatial or temporal channel, so the structural rule is the cheap one by construction (Butz 2016).
- **[[wiki/entities/bayesian-program-learning.md]]** — the architecture lever used deliberately and successfully: parameterizing concepts by their production process makes an appearance-only rule inexpressible, at the price of needing causal (stroke-order) training data.
- **[[wiki/concepts/three-component-framework.md]]** — the same control surface counted as three rather than four: objective, learning rule, architecture, with training data demoted to an anchor rather than a lever ([[wiki/empirical-tensions.md]] T15).
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — prices the shortcut: skill on a known task is purchasable outright with priors or with data, so a benchmark whose generalization difficulty is zero cannot detect a shortcut at any performance level.
- **[[wiki/entities/arc-agi.md]]** — a benchmark where every design choice removes one shortcut channel (private evaluation set, ~3 examples per task, no data generator, hand-authored tasks); the residual admitted risk is an unforeseen channel surviving.
- **[[wiki/concepts/energy-based-models.md]]** — supplies the cleanest instance of the phenomenon: *representational collapse* is the cheapest rule satisfying a self-supervised objective (make the encoders constant and every input is compatible with every other), so three of a joint-embedding architecture's four training criteria exist purely to outlaw it.
- **[[wiki/entities/h-jepa.md]]** — an architecture-lever bet against shortcuts: predict in a space trained to be simultaneously maximally informative about its input and maximally predictable from the previous state, so a rule reading only appearance is not expressible in it. Untested.
- **[[wiki/entities/hbtom.md]]** — a shortcut caught *below* chance: behavioural-cloning nets score 26.3% on the Baby Intuitions preference task, meaning they learned a rule anti-correlated with the intended one, and only the paired plausible/implausible protocol makes that visible.
- **[[wiki/concepts/divergence-objectives.md]]** — the loss-lever complaint made formal: cross-entropy is a functional of the predictive distribution alone, so a shortcut rule and the intended rule that induce the same `Q` have identical loss at every point.
- **[[wiki/entities/maze-solving-transformers.md]]** — a shortcut taken with the correct map in hand: models reach the target in ≈100% of rollouts while crossing walls in 13–62% of them, because goal-direction is cheaper than path validity and next-token loss never separates the two (Ivanitskiy et al. 2023).
- **[[wiki/concepts/representation-probing.md]]** — the inside-out complement to shifted test sets: a probe says what the network holds, a shift says whether the executed rule is wrong, and neither alone identifies which rule is running.
- **[[wiki/concepts/cognitive-map.md]]** — a second site for the same failure: a model can recover the right structure and still bind it to the least stable cue available, where the biological policy is stability-ranked (boundaries over objects, objects only once learned to be fixed).
- **[[wiki/concepts/objective-identifiability.md]]** — Morgan's Canon turned on the modeller: never attribute to an objective what is adequately explained by the second-order statistics of the supervised target, and never read a linear-regression fit to neural data as similarity when representational dimensionality predicts the score.
- **[[wiki/concepts/recall-gated-consolidation.md]]** — bounds what a recurrence-based consolidation filter buys: it keeps one-off noise out of long-term storage, but a shortcut that is stably predictive across encounters passes the gate exactly as readily as a causal edge, so reliability filtering is orthogonal to causal validity.
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — the complementary failure mode of the same slow learner: there the fitted structure is *unpredictable* noise and stopping early fixes it, here it is reliably predictive but non-causal and no amount of early stopping touches it — so predictability filtering and causal validity are orthogonal, exactly as recurrence filtering is.
