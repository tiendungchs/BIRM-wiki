# The Three-Component Framework

**Do not design the computation. Design the *objective function*, the *learning rule*, and the *architecture*, and let the computation emerge from their interaction (Richards et al. 2019).**

This is the wiki's specification language for a model. Every other concept page names a mechanism; this page says which of the three slots that mechanism occupies, and therefore what it is competing against. It is also the closest thing the wiki has to an answer to "what does one actually write down when building a reasoning model" — the answer being three compact objects, not a circuit diagram.

---

## The three components

| Component | What it fixes | Formal object | Directly observable in the brain? |
|---|---|---|---|
| **Objective function** | The *goal*: what counts as improvement | `F(W)`, a function of synaptic weights and received data; definable **without reference to a specific task, dataset or environment** | **No** — must be inferred. May exist only implicitly, as whatever the plasticity rule happens to ascend |
| **Learning rule** | How parameters change | `ΔW`, a recipe for weight updates; used for supervised, unsupervised *and* reinforcement settings alike | Partly — synaptic plasticity is measurable, credit assignment much less so |
| **Architecture** | Which computations are possible at all, and how information flows | Units, cell types, connectivity (micro/meso/macro) | **Yes** — circuit tracing, lineage, projection mapping |

Deep learning is then not "a big network" but *end-to-end* training of a hierarchy, where plasticity at every level serves the same goal — which is exactly what makes credit assignment the load-bearing problem ([[wiki/concepts/biologically-plausible-credit-assignment.md]]). "Layers" map onto **brain regions**, not cortical laminae.

**Credit assignment, restated in this vocabulary.** For small `ΔW` and locally smooth `F`:

```
ΔF ≈ ΔWᵀ · ∇_W F            improvement to first order
ΔF ≈ η ∇_W Fᵀ · ∇_W F > 0    if ΔW = η ∇_W F
```

An (N−1)-dimensional manifold of updates yields the same improvement; the gradient is the choice that buys the most improvement per unit step. Credit assignment is the problem of selecting from that manifold using signals a synapse actually has.

---

## Why not design the computation directly

| Position | Outcome |
|---|---|
| Hand-assemble intelligent behaviour from elementary computations (classical AI) | "Underwhelming" on the AI Set; handcrafted features are practically unworkable at real-world complexity |
| Specify the three components, let the function emerge | Works — at the cost of a trained system characterized by millions of weights that resist verbal description |

**The compactness asymmetry is the whole argument.** The *framework* is compact; the *model it produces* is not, and need not be. The claim is not that neural responses will ever be predicted by a compact model, but that their **emergence** can be explained by a compact one — the same relation natural selection has to phylogeny: a few sentences explain why species arise as they do, and license building non-compact models of specific lineages.

Two supports for expecting the three components themselves to be simple:

- **The genome bottleneck.** Objectives, rules and architectures must pass to offspring through the genome, which plausibly lacks the capacity to specify vertebrate wiring. The *environment* has no such limit and can convey vastly more information. So compressibility is forced on the components and not on the learned computation.
- **Overparameterization is not a violation of Occam's razor.** Massively overparameterized learners generalize well for intrinsic mathematical reasons; brains hold an enormous number of adaptable parameters (synapses, dendritic channel densities), which makes large ANNs *more* apt as models, not less.

This cuts against the wiki's compression-based ceiling: [[wiki/concepts/universal-induction.md]] scores learnability by `K(µ)` of the *environment*, while this page bounds only the description length of the *design*, and explicitly assigns the environment the role of the high-entropy information source.

---

## Task sets: No Free Lunch, made constructive

No learning algorithm performs well on all problems. The design must therefore name the task set it targets:

| Set | Definition | Consequence |
|---|---|---|
| **AI Set** | What most animals do effortlessly — perception, control, long-term prediction, reasoning, planning, communication | What distinguishes AI from the rest of computer science; the target deep learning's inductive biases were tuned for |
| **Brain Set** (per species) | Tasks that matter for that species' survival and reproduction; overlaps the AI Set but not identically, since niches differ | Says which inductive biases a given animal should be expected to carry, and hence which model to build |

The wiki's own task set is the abstract-reasoning slice of the AI Set; the Brain Set idea is the reminder that a mechanism copied from a rodent was selected for a rodent's niche, which is a sharper version of the "guide, not requirement" caveat on [[wiki/concepts/neuroscience-ai-transfer.md]].

---

## Inductive biases as the currency between the three components

Prior knowledge embedded in an optimization system; generic (hierarchy) or specific (convolution). In the brain, shaped by evolution both for life on Earth broadly and for a niche.

| Bias (Richards et al. 2019, Box 2) | Machine implementation | Where the wiki carries it |
|---|---|---|
| **Simple explanations** (Occam) | Bayesian formulations; sparse representations | [[wiki/concepts/universal-induction.md]] — the simplicity prior, and the proof it does not by itself buy structure |
| **Object permanence** — the world is made of spatiotemporally constant objects | Representations assuming consistent movement in sensory space | [[wiki/concepts/core-knowledge.md]] — the same prior stated as an innate, entry-gated system |
| **Visual translation invariance** | Convolution | [[wiki/concepts/shortcut-learning.md]] — the architecture lever's canonical example |
| **Focused attention** — some inputs matter more | Attention mechanisms | [[wiki/concepts/attention.md]] |

Two corrections this framing forces:

- **"Deep learning is a blank slate" is false**, and so is "deep learning is only compute". Its successes come from a *balance* between useful inductive biases and emergent computation — nature and nurture, in the paper's own analogy.
- **"Deep networks need too much data" is a claim about biases, not about learning.** Networks with good biases work in low-data regimes and can learn to learn ([[wiki/concepts/meta-learning.md]]); humans also develop slowly on very large experiential data.
- **Innate behaviour is not a counterexample to the framework — it is a strong inductive bias learned on an evolutionary timescale.** Hardwired behaviour remains modifiable (horses still improve at running), so an optimization account applies to circuits that learn very little.

**But biases alone are insufficient.** The paper's closing position: inductive biases must be *paired with learning and credit assignment*, and Hebbian rules must be designed *with objectives and architecture in mind*, or they do not reach AI-Set performance. This is the direct rebuke to a wiki reading in which installing enough core knowledge ([[wiki/concepts/core-knowledge.md]]) substitutes for solving structure discovery.

---

## Candidate objective functions for a brain

The paper advocates none; it argues only that objectives are inferable and necessary.

| Objective | Statement | Status as a brain objective |
|---|---|---|
| **Homeostasis** | Distance between a physiological variable and its set-point | Uncontroversial baseline — brains demonstrably optimize something |
| **Description length** | Bits needed to encode sensory data in the neural representation | The predictive-coding objective ([[wiki/concepts/predictive-coding-free-energy.md]]) |
| **Reward-weighted log-probability of action sequences** | The policy-gradient objective | Backed by dopamine's relation to reinforcement-learning quantities |
| **Mutual information with the environment** | Maximize information shared with the world | Ecologically specifiable |
| **Empowerment** | Degree of control the agent has over its environment | Ecologically specifiable; goal-free |
| **Cross-entropy** | Categorization loss | **Rejected as a brain objective** — requires the correct category for every sensory input |

**A candidate the paper does not list, added by ingest** ([[wiki/entities/h-jepa.md]], [[wiki/concepts/energy-based-models.md]]): a four-term objective that is *not* description length and not reward —

```
maximize I(s_x; x)   maximize I(s_y; y)   minimize D(s_y, Pred(s_x, z))   minimize I(z; ·)
```

It belongs in this table because it is definable without reference to a task, dataset or environment — the paper's own admission criterion — and because it is jointly a specification of all three slots rather than of one. Its distinguishing property is that **three of the four terms exist only to prevent the degenerate solution**: without terms 1, 2 and 4 the constant encoder wins. That is a shape the objectives above do not have, and it suggests a general lesson for the objective slot — an objective for a *representation* may need more anti-degeneracy machinery than signal, because the cheapest satisfier of any predictability criterion is to predict nothing.

Complications the paper concedes: the brain likely optimizes **multiple** objectives at once; some objectives are themselves *learned* (learning to learn a board game); others were optimized over evolution rather than within a lifetime.

**Why identifying an objective is not optional.** It is the criterion that separates *learning* from mere *change*: if nothing gets better according to some metric, plasticity is not learning. This gives the wiki a usable test for any proposed fast-**M** write rule — name the quantity it improves, or admit it is drift ([[wiki/concepts/synaptic-plasticity.md]], gap G19).

---

## Learning rules need not be gradients — the vector-field decomposition

Treat a plasticity rule as a vector field over weight space. Any such field decomposes into a component along `∇_W F` and components orthogonal to it:

| Field | Behaviour | Learning? |
|---|---|---|
| Aligned with the gradient | Ascends directly to the optimum | Yes |
| Orthogonal to the gradient | Never approaches the optimum | **No** — change without learning |
| Partially aligned | Reaches the optimum indirectly | Yes |

So "not gradient-based" does not disqualify a biological rule; **only orthogonality does**. This is the wiki's cleanest resolution of the standing worry on [[wiki/concepts/synaptic-plasticity.md]] that Hebbian-family rules approximate no gradient: they need only a positive projection onto one.

**Bias–variance as the scoring axis for candidate rules** (Richards et al. 2019, Fig. 2 — positions known only for backpropagation, feedback alignment and node/weight perturbation; the rest are the paper's guesses, marked with question marks):

| Rule | Bias vs. true gradient | Variance | Note |
|---|---|---|---|
| Backpropagation | ~0 | ~0 | Reference point |
| Node / weight perturbation | Low | **High** | Reinforces random weight changes via reward |
| Feedback alignment | **High** | Low | Random feedback weights carry the error |
| Contrastive Hebbian, predictive coding, dendritic error, regression-discontinuity design, attention-gated reinforcement learning | *unknown* | *unknown* | Placed by conjecture only |

This is a second axis over the families tabulated on [[wiki/concepts/biologically-plausible-credit-assignment.md]], and it reframes that page's generalization deficit: a local rule can fail either by pointing systematically wrong (bias) or by pointing noisily (variance), and the two call for different repairs.

---

## The empirical program

A model built from the three components should check out on three levels at once:

1. **Solves** the tasks in the Brain Set under consideration.
2. **Is consistent** with known anatomy and plasticity.
3. **Reproduces** measured representations *and their changes during learning*.

The worked prediction: a hierarchical network trained with a reward objective on grating discrimination predicts that tuning changes are **largest high in the cortical hierarchy, smaller in V4, smallest in V1** — a magnitude-ordering that is testable in vivo. The methodological consequence for experiments: record *during* learning, not only after performance stabilizes, because the changes are the signal.

**The modularity payoff:** because the framework factorizes, each component can be studied in isolation — architecture by circuit tracing and by fitting ANN layers to brain areas (striate cortex ↔ early layers, inferotemporal ↔ late layers), learning rules by watching representations change and inferring the rule, objectives by inverse reinforcement learning, by comparing representational geometries, or by asking what a circuit can optimize when driving a brain–computer interface.

---

## Relevance to a reasoning model

- **It names the wiki's control surface minus one lever.** [[wiki/concepts/shortcut-learning.md]]'s four levers are architecture, data, loss, optimizer; these three are architecture, objective, learning rule. The disagreement is over the **data/environment** lever, which this source deliberately excludes — an anchor for choosing the components, not a component ([[wiki/empirical-tensions.md]] T15).
- **It tells you where a proposal is allowed to be vague.** A mechanism that cannot be stated as an objective, a rule, or a connectivity constraint is not yet a design.
- **(brainstorm)** The wiki's `p = f(g, x)` factorization has never been given an *objective*. It has been argued for architecturally (G1) and shown to be un-discoverable from data (G16), but no page states a quantity that is maximized when `g` is path-consistent and minimized when it is content-contaminated. On this page's terms that is the missing third of the specification, and it is a more precise statement of gap G3 than "nothing enforces path consistency".
- **(brainstorm)** Objectives are the one component the paper says is **not directly observable** in brains. That is also where the biology→AI transfer channel has sent the least ([[wiki/concepts/neuroscience-ai-transfer.md]] — nearly every entry is a representation, a gating policy or a local rule). The channel's silence on factorizations may be a special case of its silence on objectives.

---

## Caveats the paper raises against itself

- Studying components rather than coding properties looks like discarding tuning-curve knowledge — but convolution came *from* complex cells, and tuning changes are the measurement that constrains rules and objectives.
- Neural **dynamics** is not one of the three components; the claim is that dynamics can be repurposed as evidence about the three, not that it is dispensable.
- Optimization is not the only constraint: phylogenetic hold-overs shape physiology independently of any objective. The framework's bet is that diversity arises from optimization *within* those constraints.
- Positing objectives may be premature given how little is known — a dissent registered by some of the paper's own authors.
- There is **no guarantee** that the function of a single central-nervous-system neuron is compressible into human-interpretable words at all.

---

## Open problems

- Nothing says how to *find* an objective function from data; inverse reinforcement learning and representational-geometry matching are proposals, not procedures.
- The bias/variance positions of most biologically plausible rules are unknown — the scoring axis exists but is mostly unpopulated.
- Multiple simultaneous objectives are conceded and nowhere formalized: no account of how they are weighted, arbitrated, or kept from conflicting.
- If some objectives are learned, the framework is recursive — a learned objective needs an objective — and the paper does not close the regress ([[wiki/concepts/meta-optimized-plasticity.md]], gap G9).

---

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the specification language for every candidate answer on that page: a mechanism counts as a design only once it is stated as an objective, a learning rule, or a connectivity constraint, and the `g`/`x` factorization currently has no objective.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — that page's families are all *learning-rule* proposals, and this page adds the bias/variance axis on which they are scored against backpropagation.
- **[[wiki/concepts/shortcut-learning.md]]** — the same control surface counted differently: four levers including training data versus three components excluding it, which is the substantive disagreement recorded as tension T15.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the vector-field decomposition licenses non-gradient biological rules (a positive projection suffices) while the "improvement or it is not learning" criterion demands each one name the quantity it improves.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — states what the transfer channel is *for*: not compact models of neurons but a compact normative explanation of how their responses emerge, of which the transferred mechanisms are components.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — supplies the paper's flagship ecologically plausible objective (description length), and is the case where objective, learning rule and architecture are proposed as a single package rather than independently.
- **[[wiki/concepts/core-knowledge.md]]** — core systems are inductive biases in the architecture slot, installed by evolution; this page's counterweight is that biases without credit assignment do not reach AI-Set performance.
- **[[wiki/concepts/meta-learning.md]]** — the mechanism behind the rebuttal that deep networks need large data: good biases plus learning-to-learn cover the low-data regime, and evolution is the outer loop that installed the biases.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — the framework applied to itself: if some objectives are learned and learning rules are searched, two of the three components become optimization targets rather than design choices.
- **[[wiki/concepts/universal-induction.md]]** — the rival compactness argument: this page compresses the *design* and hands the environment unlimited entropy, while universal induction scores learnability by the environment's own description length.
- **[[wiki/concepts/attention.md]]** — listed as one of four canonical inductive biases (some inputs matter more than others), i.e. a bias inserted through the architecture slot.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the wiki's candidate `g`, proposed as connectivity and representation only; gap G30 is the observation that its objective-function slot is empty.
- **[[wiki/concepts/energy-based-models.md]]** — supplies a second candidate for the objective slot (informativeness + predictability + latent parsimony) and the observation that most of a representational objective's terms are anti-degeneracy machinery rather than signal.
- **[[wiki/entities/h-jepa.md]]** — the wiki's most complete three-slot specification, and the first in which the *cost function* is designed while the behaviour is left to emerge from minimising it.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the wiki's first candidate content for the near-empty objective slot (gap G30): a computable approximation of skill-acquisition efficiency would be an objective to optimize, not only a yardstick to score against.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — names what already occupies the objective slot in every autoregressive model — code length — and shows the genome-bottleneck compactness argument is a two-part code with the design/parameter split moved (Delétang et al. 2023).
- **[[wiki/concepts/intelligence-density.md]]** — a candidate for the objective slot that fails the test: `ℐ` is asymptotic and defined through Kolmogorov complexity, so it diagnoses a finished design without supplying anything a learning rule could ascend.
- **[[wiki/concepts/divergence-objectives.md]]** — identifies the objective slot's default occupant and its hidden parameter: cross-entropy, plus a choice of which argument of the divergence the model occupies, which the three-component specification does not currently record.
- **[[wiki/concepts/offline-replay.md]]** — a lever the control surface does not list: an internally generated curriculum that reweights the experience stream from inside the agent, which is the data component made learnable rather than designed.
- **[[wiki/concepts/objective-identifiability.md]]** — the limit on this specification: the three slots are not separately identifiable from a trained system's behaviour or representations, because many objectives share minima and one objective has many minima. Its worked case shows a celebrated "objective result" (grids from path integration) resolving into an architecture-and-target result, and it supplies the wiki's most concrete candidate contents for the empty objective slot — exponential coding capacity, intrinsic error correction, whitened information across cells.
