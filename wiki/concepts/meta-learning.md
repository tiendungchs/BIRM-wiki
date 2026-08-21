# Meta-Learning (Learning to Learn)

**A slow outer optimization over a *distribution of tasks* shapes a fast inner learner, so that adaptation to a newly drawn task costs few samples.**

```
θ* = argmin_θ  E_{T ~ p(T)} [ L_T( A(θ, D_T^train) ) ]
```

`A` is the inner adaptation procedure and `θ` the slow parameters. The inner loop may be gradient descent, or — the case that matters most here — the *recurrent dynamics of a network whose weights are frozen*.

---

## Why it is load-bearing

Meta-learning is the optimization statement of the same two-level structure [[wiki/concepts/latent-graph-discovery.md]] reaches from sample complexity:

| Meta-learning | Latent-graph framing | CLS framing |
|---|---|---|
| Outer loop over `p(T)` | Meta-graph: structure shared across the environment family | Neocortex, slow |
| Inner loop within one `T` | Instance-graph: this task's topology, bound in-episode | Hippocampus, fast |
| Slow parameters `θ` | Slow **W** | Cortical weights |
| Inner-loop state | Fast **M** | Hippocampal trace |

A flat learner optimizes average performance *before* adaptation and therefore fits the mixture `E_θ[p(obs|θ)]`, which no individual instance follows. Meta-learning optimizes performance *after* adaptation — the objective that makes the two-level split explicit rather than emergent.

**A second, independent justification: identifiability.** Requiring cheap adaptation across many environments is connected to *identifying causal graphs*, because causal features are precisely those needing small changes when the environment changes (Geirhos et al. 2020). A correlational (shortcut) feature must be relearned in each new task and therefore costs the inner loop; an invariant one does not. So `p(T)` does double duty — it is the sample-complexity argument's environment family *and* the multi-environment signal under which the intended edge becomes distinguishable from a spurious one ([[wiki/concepts/shortcut-learning.md]]). Under a single environment the distinction is not merely hard to learn, it is not defined.

---

## Meta-RL: the inner learner as activity, not weights

Use reinforcement learning to optimize the weights of a recurrent network across many related tasks. The trained network's *activity dynamics* then implement a second, free-standing RL algorithm that learns within an episode, faster than the outer algorithm, with the weights held fixed. Two learners, one network, two substrates (weights vs. state).

**Biological reading** (Hassabis et al. 2017): a relatively slow dopaminergic RL algorithm trains prefrontal recurrent dynamics until those dynamics constitute a faster RL algorithm in their own right — a role for prefrontal cortex in RL alongside the established dopamine-based mechanism. This is the wiki's clearest *reverse* transfer: an AI construct that became a hypothesis about the brain ([[wiki/concepts/neuroscience-ai-transfer.md]]).

**The primary source, and what it pins down** (Wang et al. 2018, [[wiki/entities/meta-rl-agent.md]]). Three premises — a recurrent prefrontal circuit, weights trained by a model-free dopaminergic reward-prediction error, and a *series of interrelated* tasks — are jointly sufficient for the effect; none is new, the conjunction is. Six frozen-weight simulations put numbers on the two levels:

| Claim | Measurement |
|---|---|
| The inner learner is a real RL algorithm | Cumulative regret on two-armed bandits competitive with Gittins indices, Thompson sampling and UCB, with no exploration mechanism written in |
| It is *specialised to* `p(T)`, not merely initialised by it | Trained on anticorrelated bandits, it identifies the better arm faster than the independent-bandit network on the same test problem |
| It differs quantitatively from the algorithm that made it | Emergent learning rate rises in volatile blocks and is **orders of magnitude larger** than the outer loop's 0.00005; 37 ± 1% of units track volatility explicitly |
| It can be model-based although its trainer is not | Two-step task: model-based stay pattern, and model RPEs regressing on a model-based algorithm at `r² = 0.89` vs `5.8 × 10⁻⁷` model-free |
| It generalises to unseen stimuli | Harlow learning-to-learn with novel image pairs every 6 trials: one-shot from trial 2 after training (14/50 replicas reached that level) |

**Emergence conditions.** Recurrence suffices — no particular gating mechanism is required — *provided* the inputs carry the previous action and reward and the dynamics maintain information over the task horizon. That is the scope statement the optimization equation above lacks: it says which circuits should and should not show the effect.

**Architectural consequence:** the fast level need not be a separate memory module. Fast **M** can be *state in a recurrent system*, provided the slow level has shaped the dynamics to make that state a useful learner. That is a genuinely different answer from CLS's "build a second system", and both are live ([[wiki/empirical-tensions.md]] T2).

**The weights/activity distinction may not survive contact.** In-context learning in Transformers and recurrent networks changes activations, not weights — yet parameter-sharing in a meta-learner leads to the *interpretation of activations as weights*, and self-attention's outer/inner products can be cast as learned weight updates that even implement gradient descent (Schmidgall et al. 2023). A fixed-weight model can therefore exhibit the learning capabilities of a plastic one, which reframes T2 as a change of basis rather than an architectural fork ([[wiki/concepts/meta-optimized-plasticity.md]]).

---

## Instantiations

| Instance | Inner loop | Result |
|---|---|---|
| **Learning sets** (animal learning) | Behavioural strategy shift across a series of problems | The original demonstration: animals learn *how to solve the problem class*, not the problem. Later restudied in developmental psychology |
| **One-shot concept learning** (structured probabilistic models; deep generative models) | Similarity to a support set / amortized inference | The "characters challenge": recognize and generate novel instances of an unfamiliar handwritten character from a single exemplar — easy for humans, hard for classical AI |
| **Meta-RL** (recurrent policy over a task distribution) | Recurrent activity | Within-episode learning faster than the outer algorithm |
| **Progressive networks** | Lateral connections into frozen prior columns | Far transfer between video games; simulation-to-real transfer for a robot arm with a large cut in real-world training time. Resembles a computational model of sequential task learning in humans |

Progressive networks are a boundary case: transfer without a meta-objective, by *keeping* prior solutions and adding capacity — non-forgetting bought with unbounded growth ([[wiki/concepts/continual-learning.md]]).

---

## What gets transferred, and why representation decides it

Lake et al. 2017 make a claim the optimization statement above does not contain: **learning-to-learn's payoff is bounded by the form of what it transfers**, so the same outer loop over the same task family buys far more when the representation is compositional and causal.

| Route | What is shared across tasks |
|---|---|
| **Hierarchical Bayes** | A prior over concepts, itself learned while learning the specific concepts (Salakhutdinov, Tenenbaum & Torralba 2012, 2013); used to explain human learning-to-learn in word learning, causal learning and intuitive theories of physical and social domains |
| **Hierarchical Bayes, worked** ([[wiki/entities/hbtom.md]]) | The same route with the levels named: a hyperprior (`Dir(1,…,1)` over goal preferences, `Inv-Gamma(1,1)` over rationality) shared across *all* agents = meta-graph; per-agent `(θ_n, β_n)` = instance-graph; per-trial goal = the binding. Adaptation is a **Dirichlet–categorical conjugate update** — exact, closed-form, no gradient step and no sampling — so 8 trials fix an agent's preference and the 9th is predicted. Costs the inner loop nothing because the shared level was written down rather than learned (Zhi-Xuan et al. 2022) |
| **Feature sharing** (deep nets) | Hidden-layer features reused across old and new objects/tasks — the dominant machine route |
| **Hyperparameter / update-rule meta-optimization** | The form of the weight update itself (Andrychowicz et al. 2016) — see [[wiki/concepts/meta-optimized-plasticity.md]] |
| **Compositional program transfer** ([[wiki/entities/bayesian-program-learning.md]]) | Primitives, sub-parts, parts *and relations*, plus **the typical variability within a generative model** — knowledge of how far and in what ways to generalize, "which on its own could not possibly carry any information about variance" from one example |

The last row is the one to steal. Learning-to-learn occurring **at multiple levels of a hierarchical generative process** is what lets a single example fix a whole distribution: the example fixes the arrangement, pre-training already fixed the spread. Feature sharing has no level at which to store that.

**The quantitative gap.** Actor-mimic (Parisotto et al. 2016) pre-trains on 13 Atari games (~4M frames each ≈ 18.5 h per game) by mimicking an expert network, then reaches in 1–2M frames on a new game what a fresh DQN needs 4–5M frames for — real transfer, still orders of magnitude short of the few minutes a human needs. On the character side, matched pre-training (5 alphabets) leaves convolutional classifiers at ~5× human error where a compositional program learner is at human level. Both comparisons hold the task family fixed and vary only the representation, which is what makes them evidence for the claim rather than for scale.

---

## The outer loop can buy a *competence*, not just a speed-up

Every instance above uses meta-learning to make adaptation cheap. Lake & Baroni 2023 ([[wiki/entities/mlc.md]]) use it to make a behaviour *exist at all*: a 1.4M-parameter seq2seq transformer trained over 100,000 episodes — each a different randomly generated **interpretation grammar**, never observed, inferable only from 14 in-context study examples — reaches 100% exact-match systematic generalization on a task the identical architecture scores **0% on in 10/10 runs** when trained on the same examples as a static corpus.

**The competence is seed-fragile, and the fragility is invisible in the fit.** Across 10 runs the task score is 92.9% (SD 8.2) while validation loss on held-out episodes barely moves (95.3%, SD 0.4) — "not every run optimizes successfully". So the outer loop does not *guarantee* the structural competence it can buy; it makes it likely, and the successful runs happen to be identifiable from validation or grammatical-output loss without test labels. Any claim of the form "meta-training over `p(T)` yields competence C" is a claim about a distribution over runs.

| Lever | Setting |
|---|---|
| `p(T)` | A hand-written **meta-grammar**: sample 4 primitive rewrite rules (random symbol pairing without replacement) + 3 function rules (name symbol, arity 1–2, argument type `u` = primitives only vs `x` = arbitrary string, body an arbitrary ≤8-symbol mix of the arguments, evaluated recursively) |
| Inner loop | In-context, weights frozen at test, no task-specific parameters |
| Auxiliary objective | Each study *input* is also passed as a query — an identity-match copy task solved jointly with generalization, and reported as necessary for optimization to work |
| Leakage control | Validation grammars must differ from every training grammar **under any permutation of rule order**, and the held-out gold grammar additionally under any permutation of symbol assignments |

Three exports:

**1. `p(T)` gets its first concrete generator in the wiki, and it is cheap.** A meta-grammar — a generator of task generators — costs a few dozen lines and answers this page's first open problem in one domain. It is still authored, so the third-level recursion is unresolved, but the recursion now has a worked base case.

**2. Any static corpus can be converted into a task distribution by permutation.** For SCAN and COGS, MLC's episodes are made by permuting content-word meanings within lexical classes per episode, leaving functional words (`twice`, `around`, `after`) stable. This is the **slow-W / fast-M split imposed by the sampler**: whatever the permutation destroys must be inferred in-context, whatever it leaves alone may live in the weights. Nothing else in the wiki lets a designer place that boundary directly.

**3. An inductive bias can be installed *at a measured rate* — but a rate is a marginal, not a conditional.** 80% of queries are paired with the grammar's algebraic output and 20% with a human-like heuristic, the ratio set to the measured human accuracy of 80.7%. Meta-learning is used here as hierarchical Bayes with neural expressive power — reverse-engineering a prior rather than tuning one ([[wiki/entities/hbtom.md]] is the conjugate-closed-form version of the same two-level shape). **The price is measured in the same paper's Supplementary Information:** probed in a context the sampler never varied, the frozen model applies mutual exclusivity essentially absolutely (98.0% of samples) where people apply it 68.2% of the time and grade it by counter-evidence and by the number of available output symbols, and its iconic concatenation *falls* to 66.7% (people: 93.9%) on mappings that violate one-to-one. Re-optimizing the same architecture on those participants recovers the human distribution (68.6% / 93.8%) — but only after the missing conditioning variable (the response pool) was added to the input as an extra study example. So installing a bias by sampling gives you the bias's *frequency* in the sampled setting and neither its *context-dependence* nor the input channel that context-dependence needs ([[wiki/empirical-tensions.md]] T202).

---

## A third thing the outer loop buys: tolerance of the machine the inner loop runs on

> Ortner et al. 2025 (`raw/ortner-2025-phase-change-memory-rapid-learning.md`, Nature Communications 16). Full treatment in [[wiki/concepts/analog-in-memory-computing.md]].

Both experiments there meta-train **entirely in software at full precision, with no model of the hardware**, then deploy onto analog phase-change-memory crossbars whose weights carry ≈4 bits and drift — and the deployed models are on par with their software equivalents. Two of the results bear on this page directly:

| Finding | Consequence here |
|---|---|
| **Meta-training with 4-bit stochastically-rounded weights does not beat 32-bit meta-training** on either Omniglot or CIFAR100-FS, on chip or in a device emulator calibrated on 10⁶ devices | The outer loop's product is robust to a perturbation it was never shown. Whether that is *caused* by meta-learning (flat minima) or is a property of these two architectures is explicitly unresolved by the authors |
| **The control that isolates what the outer loop paid for**: backpropagation from scratch on the same 25 support images fits them in a few steps and generalizes poorly to the query images | The `n = 4` cheap updates are not the source of few-shot generalization; the 30,000 expensive ones are. Adaptation speed and adaptation *quality* come from different loops, and only the second is bought by `p(T)` |

**The deployment shape this enables is new to the page.** One software meta-training run → many hardware instances, each running the inner loop alone against its own task from the family. That makes `p(T)` an economic object as well as an epistemic one: the outer loop amortizes over deployment sites, and a site whose task falls outside the family pays the full cost with no way to detect it in advance (the limit below, with an energy bill attached).

---

## The knowledge-boundedness limit

The inner learner adapts only within the envelope the outer loop sampled. `p(T)` is a hard boundary: a family the outer loop never saw is not "few-shot hard", it is out of scope. Any claim that a meta-learned system generalizes structurally has to specify the task distribution it was trained over.

**The limit now has a precise two-level statement and a measurement** (Lake & Baroni 2023):

> Meta-learning succeeds when generalization makes a new episode **in-distribution with respect to the training episodes**, even when the specific test items are out-of-distribution with respect to the study examples **within** the episode. Meta-learning alone will not let a standard network generalize to episodes that are themselves out-of-distribution with respect to those presented during meta-training.

Two nested notions of "out of distribution", and only the inner one is bought. The measurement is the cost of the outer one: the same method that scores 77.8% on longer-than-trained outputs in the instruction task — where episodes varied length — scores **100% error** on SCAN's length split and on three COGS structural types, where the episode transform was a symbol permutation that never varied structure. So `p(T)` does not merely bound *how far* the inner learner generalizes; it decides **which kind** of generalization the system has at all, and no procedure here audits that coverage ([[wiki/architectural-gaps.md]] G66).

**(brainstorm)** This makes the wiki's target *not* "better meta-learning" but a **third level**: the outer loop's task distribution should itself be discoverable rather than given. That is the same recursion as the rewrite-graph in hardness source 6, and the same problem as gap G9 — two levels suffice while the family is fixed.

**Self-referential meta-learning** is the first candidate mechanism for that third level (Schmidgall et al. 2023). Plasticity approaches have exactly two levels — a meta-learner that is fixed after meta-optimization, and the rule it discovered. Self-referential architectures let the network modify *all* of its parameters recursively, so the learner can modify the meta-learner: learning, meta-learning, meta-meta-learning without a ceiling. Some variants still meta-learn the initialization (which needs a hardwired meta-learner); others self-modify in a way that eliminates even that. Details: [[wiki/concepts/meta-optimized-plasticity.md]].

---

## Open problems

- **Where does `p(T)` come from?** Every result above assumes a hand-built task distribution; self-generated curricula are the unaddressed half. The wiki now has one worked generator — a meta-grammar sampling latent interpretation grammars ([[wiki/entities/mlc.md]]) — and a demonstration that a static corpus can be converted into one by within-class symbol permutation, but both are authored and neither audits its own coverage.
- **Nothing measures what a task sampler covers.** A held-out set drawn from the same sampler cannot see the hole: MLC's validation episodes are new grammars and pass, while an entire facet (length extrapolation) is absent from the sampler and fails at 100%. Coverage of `p(T)` is a design object with no instrument (G66).
- **Does the inner loop learn structure or select among encoded rules?** Recurrent inner learners are not shown to acquire *new* transition rules. **The one direct test now in the wiki is passed, at the content level** ([[wiki/entities/mlc.md]], SI-1.2): 26 rules were withheld from the 100,000 meta-training episodes under a *semantic-equivalence* quotient — novel means no meta-training rule is equivalent modulo rule name and renaming of the argument variables — and the frozen network infers and applies them at **99.3–99.8%** exact match across 130 test episodes. Selection from a stored inventory of rule *contents* is therefore excluded. Selection over rule *forms* is not: the novel rules are still drawn from the same meta-grammar (same argument types, same ≤8-symbol bodies), so this is the inner OOD level only, and the outer one is still untested by construction.
- **Weights vs. activity for the fast level** — CLS and meta-RL disagree, and they may be complementary (episodic fast-M for bindings, recurrent fast-M for policies).
- ~~**Meta-learning the plasticity rule** rather than the initialization is a distinct, less-explored branch.~~ **Now paged:** [[wiki/concepts/meta-optimized-plasticity.md]] (Schmidgall et al. 2023). It inherits this page's knowledge-boundedness limit and adds a sharper version — the *larger* the rule search space, the *worse* the discovered rule generalizes, so the branch's expressiveness is in direct tension with its transfer.
- **Is the causal-identification claim earned?** Invariance across environments identifies causal structure *under assumptions* about how the environments differ. No result shows a meta-learned inner loop actually recovering causal edges rather than a shortcut that happens to be stable across the sampled `p(T)` — and a shortcut shared by every sampled task is invisible to the objective.

---

## Connections

- **[[wiki/concepts/epistemic-value.md]]** — the slow/fast split appearing as a condition for a sum to converge: per-step information gain about the parameters is additive over a horizon *only* because `θ` is frozen during the rollout, so the slow level must be held still while the fast level plans over it or per-probe gains double-count.

- **[[wiki/concepts/latent-graph-discovery.md]]** — meta-learning is the optimization statement of LGD's two-level hierarchy: the outer loop learns the meta-graph, the inner loop binds the instance-graph.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the same two-timescale factorization realized across two anatomical systems rather than in weights-vs-activity within one network.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — meta-RL is the wiki's clearest AI→neuroscience transfer, supplying a hypothesis about prefrontal recurrent dynamics.
- **[[wiki/concepts/continual-learning.md]]** — meta-learning optimizes forward transfer to *new* tasks; continual learning protects retention of *old* ones; progressive networks sit in both.
- **[[wiki/concepts/working-memory.md]]** — recurrent activity is the substrate meta-RL uses for its inner loop, so the capacity and gating limits of activity-based memory bound what the inner learner can hold.
- **[[wiki/concepts/abstract-structural-codes.md]]** — a content-invariant structural code is what would let the outer loop's learned regularity be reused in a domain populated by entirely new objects.
- **[[wiki/concepts/simulation-based-planning.md]]** — reusing a plan across structurally similar environments is meta-learning's objective restated in planning terms: the outer loop supplies the schema the rollout instantiates.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — the branch where the inner loop is a written-down plasticity rule rather than emergent recurrent dynamics, which makes the two-level split architectural instead of post-hoc.
- **[[wiki/concepts/shortcut-learning.md]]** — the task distribution `p(T)` doubles as the multi-environment signal under which causal (invariant) edges become identifiable, so fast adaptation and shortcut resistance are the same property seen twice (Geirhos et al. 2020).
- **[[wiki/concepts/core-knowledge.md]]** — the limiting case of the outer loop: a meta-graph fixed by evolution instead of optimized over a task distribution, which is what makes instance binding one-shot.
- **[[wiki/concepts/universal-induction.md]]** — a `2^-(program length)` mixture over all computable environments is the non-parametric limit of an outer loop over a task distribution; meta-learning is what the outer loop becomes when the mixture must fit in finite weights.
- **[[wiki/entities/aixi.md]]** — shows the slow/fast split is not logically necessary: a full posterior over environments transfers without ever representing a meta-level, so the two-level architecture is a finite-capacity requirement.
- **[[wiki/concepts/compositionality.md]]** — names *what* a successful outer loop transfers: a library of parts and relations rather than a weight initialization, which is why transfer over non-compositional representations stays weak however large the task family.
- **[[wiki/entities/bayesian-program-learning.md]]** — the instance where learning-to-learn runs at several levels of one generative hierarchy, including the level that stores how much within-concept variability to expect.
- **[[wiki/concepts/causal-model-building.md]]** — makes causal structure a precondition rather than a sibling of transfer: the full benefit of learning-to-learn is claimed to require compositional and causal representations to operate over.
- **[[wiki/concepts/amortized-inference.md]]** — the same outer-loop shape applied to an inference problem instead of a task distribution, and it inherits the identical hard boundary at the edge of what was sampled.
- **[[wiki/concepts/event-segmentation.md]]** — episode encodings are the meta-graph made concrete for temporally extended structure: the event schema is what is shared across instances, the binding of items to its slots is what varies (Butz 2016).
- **[[wiki/concepts/three-component-framework.md]]** — supplies the reply to "deep networks need too much data": a network with good inductive biases can learn to learn in the low-data regime, with evolution as the outer loop that installed the biases.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the measurement counterpart of the outer loop: a meta-learner optimizes exactly the quantity that page scores, and the task sampler is the curriculum the measure says is under-specified.
- **[[wiki/entities/h-jepa.md]]** — the two-level split relocated into inference: one shared world-model engine plus a task-specific modulation computed by a configurator, so adaptation is *reconfiguration* rather than an inner-loop weight or activity update — and the price is that only one task can be run at a time.
- **[[wiki/entities/hbtom.md]]** — the cleanest architectural version of the two-level split in the wiki, and the cheapest inner loop: conjugacy makes instance-binding an exact closed-form update, which is what "instantiation is binding, not learning" looks like when the meta level is a hyperprior instead of a weight vector.
- **[[wiki/entities/irene.md]]** — a full curriculum ablation over the outer-loop task set with a non-monotone result: the training task matching the evaluation task gives chance, an unrelated task supplies the missing behavioural statistic (does the agent traverse the grid?), and adding a third destroys it — so the task distribution cannot be chosen by task identity.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — measures the inner loop: with parameters frozen, all compression beyond the marginal is in-context, so the rate-vs-position curve is a bits-denominated readout of adaptation speed (Delétang et al. 2023).
- **[[wiki/concepts/contextual-inference.md]]** — the two-level split written as a prior rather than as an optimisation loop: global transition probabilities `β` pooled across contexts (meta) and per-context rows `π_j` (instance), coupled by a Dirichlet-process concentration parameter, with adaptation by filtering instead of gradient descent (Heald et al. 2021).
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — assigns this family the supervisor role in consolidation: the prior linking observable data statistics to a relation's predictability is proposed to be meta-learned over developmental and evolutionary timescales, so *how much* to consolidate becomes an outer-loop output rather than something the inner loop can infer.
- **[[wiki/entities/pbwm.md]]** — the two-loop shape with an explicit write-enable: the slow loop learns a *gating policy* rather than a recurrent dynamics, so the inner learner in activity is told when to accept new content instead of leaving that implicit in the weights.
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — the inner/outer split made surgically rather than architecturally: a problem-solving strategy (Repeat-Stay/Change-Shift) survives hippocampal ablation while acquisition of new instances fails, and dies with ventral/orbital prefrontal cortex — so the outer loop's product is a separately stored object worth an exact 33 percentage points of error rate, and it is *not* required to learn the instances, only to learn them faster (Murray et al. 2000).
- **[[wiki/concepts/cognitive-control.md]]** — the outer loop's product held as activity rather than weights (a task model, swapped per block by a shift in prefrontal baseline firing that begins before the cue appears), and an inner-loop learning signature stated in time rather than in parameters: over the 5–15 trials it takes to acquire a new cue→saccade mapping, the delay activity coding the response migrates backwards toward cue onset — the same temporal shift as the dopamine reward-prediction signal that is proposed to teach it (Asaad et al. 1998, in Miller et al. 2002).
- **[[wiki/concepts/controller-knowledge-vs-process.md]]** — names the assumption this page's architectures make without arguing for it: a meta-learner's controller is contentless machinery with task knowledge in activations, whereas a representational control layer would have the outer loop write *stored goal-structured plans* into the controller itself — a different location for the meta-graph.
- **[[wiki/entities/meta-rl-agent.md]]** — the primary source and worked instance of the meta-RL row above: three premises (recurrence, model-free dopaminergic training, a task *series*) are jointly sufficient, and the six frozen-weight simulations supply this page's only measurements of an inner algorithm's competence, specialisation and generality (Wang et al. 2018).
- **[[wiki/entities/spacetime-attractor.md]]** — the meta-RL split with the fast level made legible: world structure and the planning scaffold live in weights, while the trial's reward landscape and wall configuration enter as inputs that gate the scaffold, so adaptation to a new environment happens in dynamics with no plasticity at all (Jensen et al. 2026).
- **[[wiki/entities/c-ts-model.md]]** — the two-loop shape realised anatomically rather than in one recurrent net: the slow loop's product is a *library* of policies indexed by context and the fast operation is selecting one, which is retrieval rather than adaptation.
- **[[wiki/entities/coin-model.md]]** — the two-level split expressed as a prior rather than as an optimisation loop: a shared `β` across contexts with per-context `π_j`, under a hierarchical Dirichlet process.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — an outer loop over an environment family shaping a fast inner binder whose inner step is a memory write rather than a gradient step.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the same job — setting the parameters that govern how the inner learner learns — done by feedback instead of by an outer loop: no task distribution, no episodes, no gradient through the inner learner, with `γ` set from the variance of the TD error, `α` from its sign oscillation and `β` from the value estimate, so the setting tracks non-stationarity inside one lifetime. The natural composition is to meta-learn the *gains* of those control laws rather than the metaparameters themselves (Doya 2002).
- **[[wiki/entities/mlc.md]]** — the case where the outer loop buys a structural competence rather than a speed-up (0% → 100% systematic generalization with the architecture unchanged), the wiki's first concrete `p(T)` generator, the sharpest statement of this page's boundedness limit (episodes in-distribution, items out-of-distribution, and a facet the sampler never varied failing at 100%), and — from its Supplementary Information — the direct test of *learn vs. select*: 99.3–99.8% on rules withheld under a semantic-equivalence quotient, against a bias that is applied at the sampled rate but without the human context-dependence.
- **[[wiki/concepts/test-time-training.md]]** — this page's anatomy with the outer loop deleted: an inner adaptation loop that writes the base model's own weights from ~3 labelled pairs, with nothing having meta-trained it to adapt — currently the strongest transduction method on ARC-AGI-1 (≤11% without it, 53.5% with), and the reason "does the inner loop have to be gradient descent on weights?" is an open, answerable question against [[wiki/entities/mlc.md]].
- **[[wiki/concepts/refinement-loop.md]]** — the inner loop with no outer loop, generalised past weights: every 2025 ARC system hand-designs its own mutation operator and stopping rule, which is meta-learning's job left to the developer in four different substrates at once.
- **[[wiki/entities/anli.md]]** — the environment family generated in closed loop on the learner rather than sampled from a fixed distribution: a human adversary is paid to find inputs the *current* model misclassifies, and at matched training-set size that substitution is worth +27.5 / +16.8 / +14.9 points on the three rounds with i.i.d. scores unmoved — the failure-conditioned task sampler no outer loop in the wiki implements (Nie et al. 2020).
- **[[wiki/concepts/neuronal-parameter-heterogeneity.md]]** — the two-level split drawn along a substrate boundary instead of a task boundary: the slow loop optimises each neuron's biophysical constants `[τ, γ, C, u_th, u_re]` on a held-out split while the fast loop optimises weights on the training split, alternating, with the second-order `∇_α W*(α)` term dropped to first order at no measured accuracy cost — an outer loop with no task distribution at all, whose product is insensitivity to the inner learner's initialisation.
- **[[wiki/concepts/analog-in-memory-computing.md]]** — the outer loop priced against a substrate: on a crossbar where a weight write is the dominant energy cost, meta-learning is what shrinks the inner loop to 1120 of 342,720 devices and four steps — and it transfers to ≈4-bit drifting analog weights with no hardware model in the loop, so the same optimization also appears to buy device tolerance (Ortner et al. 2025).
- **[[wiki/concepts/default-self-model.md]]** — where competence self-knowledge should live in a machine: a trait inventory is the biological format, but the useful machine analogue is a meta-level posterior over task families, updated by the outer loop.
