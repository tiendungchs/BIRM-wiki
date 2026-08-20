# Unity and Diversity of Control

**The control layer is not one resource and not *n* independent ones: it factors into a single common component that every control task loads on, plus a small number of operation-specific components with their own variance, their own pharmacology and their own genetics. Response inhibition has *no* specific component — it is the common one, measured.**

> **Provenance.** Friedman & Robbins 2021, *The role of prefrontal cortex in cognitive control and executive function*, Neuropsychopharmacology 47:72–89 (`raw/friedman-2021-prefrontal-cognitive-control.md`). A review joining two literatures that rarely meet: individual-differences psychometrics of executive function (Miyake/Friedman latent-variable models) and interventional prefrontal neuroscience (primate and rodent lesion, pharmacology, human imaging).

[[wiki/concepts/cognitive-control.md]] states the control *mechanism* — a task model held as activity, broadcast as bias — as if the controller were one homogeneous thing. [[wiki/entities/medial-prefrontal-cortex.md]] factorizes it by **output port**. This page factorizes it a third way, by **what varies independently**: not which regions exist, but which control abilities can move without dragging the others with them. That is the decomposition a builder actually needs, because it says how many separately parameterized pieces a control module requires — and the answer is **one shared piece plus two, not five, and not one**.

---

## The psychometric result, and why the correlations look weak until you fix the measurement

The core methodological point, which is directly importable as a benchmark-design rule.

| Level of analysis | Correlations among control measures | What follows |
|---|---|---|
| Individual tasks (Stroop, stop-signal, *n*-back, task-switching…) | `r = −0.05 … 0.34` | Reads as "control is a myth" — the classic null that stalled the field |
| Latent variables (common variance across ≥3 tasks per construct) | `r = 0.42 … 0.63` | All significantly > 0 (**unity**) and all significantly < 1 (**diversity**) |

The gap between the two rows is **task impurity**: control is by definition control *of* other processes, so every control task's score mixes the control ability with the perceptual, motor and mnemonic machinery it operates on. Extracting the shared variance across several tasks tapping the same construct removes both the impurity and the measurement noise (Miyake et al. 2000).

**(brainstorm) The wiki's machine-side evaluations are all single-task and therefore all impure.** Every capacity or control claim about a model here — *N*-back accuracy, switch cost, distractor resistance — is one task, so it is a mixture of the control operation and the model's encoder. The importable protocol is exact and cheap: run ≥3 structurally different tasks per control construct, fit a latent variable per construct, and report the *factor* correlations. A model whose task-level control scores are uncorrelated may still have a perfectly good unified controller — which is precisely the inference the biology literature got wrong for thirty years.

### The three model forms, and the one result that constrains architecture

| Model | Structure | Fit outcome |
|---|---|---|
| **Correlated factors** | Inhibition ↔ Updating ↔ Shifting, three correlated latents | Beats 1- and 2-factor models: diversity is real |
| **Higher-order** | One common factor above the three | The common factor predicts the **inhibition** factor almost perfectly; substantial residual variance remains in updating and shifting |
| **Bifactor** | Common factor + orthogonal specific factors | Yields an updating-specific and a shifting-specific factor and **no inhibition-specific factor at all** |

**The bifactor row is the load-bearing one.** The variance shared across response-inhibition tasks *is* the variance shared across all control tasks. So at the level of individual differences the decomposition is:

```
control_ability  =  Common  +  Updating-specific  +  Shifting-specific   (+ task-specific noise)
inhibition       =  Common                                              (no residual)
```

A machine controller built to this spec has **three sets of parameters, not one and not five**: a shared goal-maintenance/biasing resource that every operation draws on, plus separate parameters for updating the store's contents and for reconfiguring the task set. Nothing in the wiki is built this way — every controller here is either a single monolithic module ([[wiki/entities/h-jepa.md]]'s configurator) or a set of fully independent mechanisms ([[wiki/entities/pbwm.md]]'s per-stripe gates) with no shared component at all.

---

## What the common factor *is*: three readings, one of them eliminable

| Reading | The argument for it | The problem |
|---|---|---|
| **It is inhibition** | Zero inhibition-specific variance; every control operation can be described as requiring suppression — of intruding items at encoding, of no-longer-relevant items at removal, of the abandoned task set at a switch | Assumes processes sharing the *word* "inhibition" share a mechanism. They dissociate empirically, and some are not neural inhibition at all. This is a naming argument, not a mechanism |
| **It is goal maintenance and biasing** | To perform *any* control task you need an accurate, actively held goal that directs attention to task-relevant information. Inhibition tasks load on it hardest because when the goal representation lapses the prepotent response simply wins by default — the failure is maximally visible there | Predicts stopping failures come from goal lapse rather than from a weak stop process; requires that inhibition-specific machinery (global motor suppression) have *low* between-subject variance, which is assumed rather than shown |
| **It is `g`** | Common control correlates with intelligence at `r = 0.53 … 0.91` across studies; Duncan's multiple-demand network links goal neglect to fluid intelligence | **Eliminated as identity.** In adult samples the correlation is `0.53–0.68`, significantly below 1 even at the latent level; control predicts ADHD symptoms and lack of self-restraint *controlling for* intelligence; and `g` additionally loads on the *updating-specific* variance, so it is not the common factor wearing a different name |

**The wiki's own mechanism page already picks a side and did not know it was picking one.** [[wiki/concepts/cognitive-control.md]]'s guided-activation account — sustained goal representation biasing a competition resolved by lateral inhibition — is reading 2, and it *derives* reading 1 as a consequence: because the biased systems mutually inhibit, "enhance the relevant" and "suppress the irrelevant" are one operation. The bifactor result is then not a coincidence but a prediction: an architecture whose only control primitive is additive bias into a competitive substrate **cannot** have an inhibition-specific factor, because it has no inhibition-specific parameters. That is the sharpest confirmation of the guided-activation architecture available anywhere in the wiki, and it comes from psychometrics rather than from recording.

**(brainstorm) It is also a runnable model test that would falsify the architecture.** Build two controllers on the same backbone — (a) bias-only into a softmax-competitive substrate, (b) bias plus a dedicated suppression channel ([[wiki/concepts/inhibitory-control-of-coding.md]]'s addressed-erase design) — train a population of instances with varied seeds/hyperparameters, run a battery of inhibition/updating/shifting tasks, and fit a bifactor model over the population. Architecture (a) must yield no inhibition-specific factor; architecture (b) must yield one. This is the rare case where a psychometric prediction discriminates two machine designs, and it costs only a seed sweep.

---

## Diversity is not a statistical artefact: the interventional table

Each row is a double dissociation — the manipulation impairs one control operation and spares (or improves) another, with the reverse pattern available for a second manipulation.

| Manipulation | Impaired | Spared / improved | What it separates |
|---|---|---|---|
| dorsolateral prefrontal (BA-46 / sulcus principalis) lesion, primate | Spatial delayed response | Reversal learning, Go/No-Go | Maintenance vs. flexibility |
| Orbitofrontal (BA-11/13) excitotoxic lesion, marmoset — replicated in rat, mouse, human | **Reversal learning** | Extra-dimensional set-shifting | Value-level flexibility |
| Ventrolateral prefrontal (BA-12/47) excitotoxic lesion, marmoset | **Extra-dimensional set-shifting** | Reversal learning; and no on-line working-memory deficit | Dimension-level flexibility — the mirror of the row above |
| BA-8 (posterior dorsolateral) damage | Conditional selection of motor responses to stimuli (task-set learning) | Monitoring / *n*-back | [[wiki/concepts/arbitrary-sensorimotor-mapping.md]] vs. monitoring |
| BA-9/46 (mid-dorsal) damage | Monitoring and tagging of recently selected items (self-ordered, *n*-back) | Conditional response selection | The reverse of the row above |
| Right inferior frontal gyrus (BA-44/45) lesion, human | Stop-signal reaction time — **the only prefrontal sector correlating with it** | Go reaction time (related to other sectors) | Stopping vs. going |

**Two readings of the same table, and both are architecturally consequential.**

- *Cognitive flexibility is itself two things.* Reversal learning (the value of *this object* flipped) and extra-dimensional shifting (attend to a different *feature dimension*) are doubly dissociable within prefrontal cortex and conform to a hierarchy: reversing object–value contingencies sits **below** re-directing attention to a perceptual dimension. Any machine "task switching" benchmark that does not separate these two is scoring a mixture of two circuits.
- *The construct boundaries the psychometrics found are not the construct boundaries the lesions found.* The lesions cut flexibility into two; the factor analysis leaves shifting whole and instead splits off updating. The two decompositions are cut on different axes, and the review's own future-research recommendation is to decompose updating and shifting further before mapping them onto circuits.

### Stopping has a specific circuit even though it has no specific factor

The apparent contradiction — response inhibition is *statistically* the common factor, yet *anatomically* the most localized operation in the table — resolves into a design claim.

| Component | Evidence |
|---|---|
| Braking pathway | Right inferior frontal gyrus modulates an excitatory pre-supplementary-motor→**subthalamic nucleus** influence, amplifying polysynaptic inhibition from subthalamic nucleus to motor cortex (best-fitting Bayesian effective-connectivity model); diffusion imaging of the same tracts predicts individual stopping efficiency |
| It is not motor-specific | The right-frontal beta-power signature of successful stopping also appears when suppressing an *unwanted thought*; anterior nodes of the right middle frontal gyrus mediate cognitive and emotional inhibition, posterior nodes motor inhibition; memory retrieval is inhibited by a dorsolateral-prefrontal→hippocampus pathway via mid-temporal or retrosplenial relays |
| It is lateralized | Right-hemisphere dominant across behavioural, cognitive and emotional stopping; the left inferior frontal homologue does semantic retrieval |
| The hub is still multiple-demand | Patients with right inferior frontal lesions *also* show spatial working-memory deficits |
| The subthalamic node is separately settable | Deep brain stimulation of the subthalamic nucleus *increases* impulsive responding under conflict, with a speedup specific to high-conflict trials; stimulation of the ventral internal capsule in the same disorder produces neither signature and instead slows deliberation on a value-based choice — so threshold and control gain are two parameters of one loop, reachable at different nodes (Widge et al. 2019, [[wiki/concepts/cognitive-control.md]]) |

**The resolution:** the region is a **hub with operation-specific spokes**. Its shared component (goal maintenance / adaptive coding) is what varies between individuals and produces the common factor; the stop-specific spoke (→ subthalamic nucleus) is a fixed pathway that is either triggered or not, and contributes little between-subject variance. A machine controller can copy this directly: one shared control state, plus **typed output channels** whose parameters are near-constant across instances.

**(brainstorm)** This is the first thing in the wiki that suggests a *general* stop primitive rather than a modality-specific one — one braking channel that takes an action, a thought, or a retrieval as its argument. Every erase/suppress operation the wiki has collected is typed to its store ([[wiki/concepts/working-memory.md]]'s three-way replace/suppress/clear family, [[wiki/concepts/inhibitory-control-of-coding.md]]'s four interneuron channels). A single polymorphic `stop(x)` with per-target relays is a cheaper design and it has a shared electrophysiological signature to justify it.

---

## The strongest evidence that the components have separate parameters is pharmacological

Neuromodulators dissociate control components — and in one case move them in **opposite directions**, which no shared-resource model can produce.

| Manipulation | Effect | Component separated |
|---|---|---|
| Dopamine depletion, marmoset prefrontal cortex | **Impairs** spatial delayed response, **enhances** extra-dimensional set-shifting | Updating vs. shifting, anticorrelated |
| D1 vs. D2 receptors (rodent) | D1 → working memory; D2 → cognitive flexibility | Same split, receptor-level |
| L-Dopa, Parkinson's disease | Improves working memory and task-set switching; **impairs** reversal learning and decision-making | Dorsal vs. ventral striatal-frontal loops |
| Serotonin depletion, marmoset orbitofrontal cortex | Impairs reversal learning; spares extra-dimensional shifting | Value flexibility vs. dimensional flexibility |
| Atomoxetine (noradrenaline reuptake inhibitor), human | Improves stop-signal; no effect on probabilistic (orbitofrontal) learning | Stopping vs. value learning |
| Citalopram (serotonin reuptake inhibitor), human | The exact reverse of atomoxetine | — |
| All of the above | **Inverted-U dose–response** | Every component has an *operating point*, not a monotone gain |

**Two things a builder must take from this table.**

1. **Anticorrelated components rule out a single control budget.** If control were one resource split among operations, a manipulation could trade one against another — but dopamine depletion *degrades the substrate* and one operation gets **better**. The natural reading is a **stability–flexibility axis**: the same parameter that stabilises an attractor for maintenance is what makes a set hard to abandon. High gain buys updating and costs shifting. This is a single scalar with opposite signs on two components, which is a different object from a shared factor and the wiki has no page for it ([[wiki/concepts/attractor-dynamics.md]] has the mechanism and never states the trade-off).
2. **The inverted U makes every control parameter a *tuned* quantity.** Not "more neuromodulation is better", but "each component has an optimum, and the optima differ". A machine controller with a single temperature/gain hyperparameter is therefore mis-specified by construction: it cannot sit at two optima at once. **(brainstorm)** The minimal fix is per-component gain, and the interesting fix is a controller that *sets* its own gains from task demand — which is [[wiki/concepts/cognitive-control.md]]'s bias signal aimed at its own dynamics rather than at the sensory surface, and is the same missing edge as gap G50.

---

## The network picture: unity is a network property, not a region

| Network | Composition | Role |
|---|---|---|
| Frontoparietal (central executive) | dorsolateral + dorsomedial prefrontal, posterior parietal | Flexible adaptive control; reconfigures per task |
| Cingulo-opercular (overlaps salience) | anterior cingulate, insula, subcortical | Sustained task-set maintenance |
| **Multiple-demand** | Frontoparietal ∪ cingulo-opercular | Active across *any* goal-directed task; adaptive coding — the same ensembles recruited for superficially different tasks |
| Default mode | medial prefrontal + posterior cortex | Anticorrelated with the above during external tasks; "internal" control |

Meta-analysis of 193 imaging studies: working-memory, flexibility and inhibition tasks all activate BA-9, BA-46 and BA-32 plus superior and inferior parietal cortex — **conjunction is the rule**, with small task-unique additions (flexibility alone recruits BA-11).

**But mean activation and individual differences are different questions, and the wiki has been conflating them.** Everyone activates the frontoparietal network on a demanding task; that does *not* imply that people who activate it more perform better. One study looking directly for conjunction of *individual-difference* maps across three control tasks found **no overlapping regions**, despite strong mean-activation overlap. Correlates of the common factor instead include regions outside the multiple-demand network entirely (visual network activity, insular volume), and global connectivity of dorsolateral prefrontal cortex to the rest of the brain.

The variables that *do* predict the common factor are graph-theoretic rather than regional:

| Predictor | Direction | Interpretation |
|---|---|---|
| **Modularity** of white-matter networks (stronger within-, weaker between-network connections), especially frontoparietal | Higher → better control; mediates the age-related rise in control across ages 8–22 | Specialization reduces cross-network interference |
| **Global efficiency** (path length for information flow across networks) | Higher → better control | Coordination, in tension with the row above |
| **Task-driven reconfiguration** (how much connectivity *changes* with cognitive demand) | More → better control | Adaptive control as a dynamic quantity |

**(brainstorm) These three are a directly measurable specification for a machine controller and nothing in the wiki reports any of them.** Modularity and global efficiency pull against each other, and the biological answer is *both* — a modular architecture with high-bandwidth cross-module paths, plus demand-dependent re-wiring. That combination is exactly the shape [[wiki/concepts/compositionality.md]] argues for and never quantifies. All three are computable on any multi-module model's activation-covariance graph, per task condition, at no training cost — which would give the wiki its first architecture-level number that is comparable to a brain measurement rather than to a benchmark score.

---

## Hot and cool control

| | Cool | Hot |
|---|---|---|
| Stimuli | Non-emotional (colour-word Stroop, letter *n*-back) | Emotionally salient (affective Stroop, gambling, delay of gratification) |
| Shared substrate | dorsal anterior cingulate, anterior insula, lateral and medial prefrontal — **the same control regions** | |
| Additional substrate | — | Amygdala, rostral anterior cingulate and medial prefrontal, orbitofrontal cortex |
| Behavioural separability | Dissociable in children by correlational structure | |

The picture is **one control mechanism with an extra content stream**, not two controllers. The load-bearing consequence for the wiki is the ventromedial/orbitofrontal case: patients with orbitofrontal and ventromedial damage show catastrophic everyday decision-making with **intact IQ and intact classical frontal tests** — a control deficit that no cool control measure detects. Any evaluation suite composed only of cool tasks scores such a system as unimpaired.

**Also worth carrying:** the goal-directed/habitual dichotomy that the whole control-versus-automaticity story rests on may be too coarse. A third mode — model-based and model-free computations arbitrated by **successor representations** — supports behaviour that is simultaneously flexible and cheap ([[wiki/concepts/successor-representation.md]]), and a measured compulsivity factor tracks a bias toward model-free responding.

---

## Reading in the core framing

| This page | Latent-graph reading |
|---|---|
| Common factor | The single shared operation of holding the active subgraph and pushing its edge weights outward — one resource, drawn on by every traversal |
| Updating-specific | Editing which nodes are live without changing the graph — the write port |
| Shifting-specific | Replacing the live subgraph — reconfiguration, and it is genetically distinct from the write port |
| Reversal vs. extra-dimensional shift | Changing an edge *weight* vs. changing which *edge type* is attended — two levels of the same operation, doubly dissociable |
| Stability–flexibility axis (dopamine) | A single scalar setting how deep the current subgraph's basin is; deep = maintainable and inescapable |
| Modularity + global efficiency | The meta-graph's own topology as a predictor of how well it can be navigated |
| Hot control | The same traversal with value-annotated edges, requiring extra machinery that reads the annotation |

---

## Open problems

- **The two decompositions do not align.** Psychometrics splits control into common/updating/shifting; lesions split it into maintenance/reversal/dimensional-shifting/conditional-selection/stopping/monitoring. Nothing maps one onto the other, and the review's own recommendation is to decompose the psychometric constructs further before trying.
- **The common factor has no mechanism, only three candidate descriptions**, and the discriminating evidence (does inhibition-specific machinery have low between-subject variance?) has never been measured.
- **Individual-difference maps and mean-activation maps do not converge.** The multiple-demand network is what everyone activates and is *not* reliably what distinguishes good from poor controllers. Every "region X does control" claim in the wiki rests on the mean-activation form of the evidence.
- **Modularity and global efficiency are in tension and nothing states the trade-off curve** — only that both correlate positively with control in the same sample.
- **The stability–flexibility trade-off is inferred from one anticorrelated dissociation, not measured.** No dose–response curve for both components in the same animals exists, so "one scalar, opposite signs" remains the simplest story rather than the demonstrated one.
- **Whether unity and diversity is species-general is untested**, and the review flags it as a precondition for using animal models of control at all.
- **Task impurity is unsolved for machines and unaddressed.** The latent-variable fix requires multiple tasks per construct and a population of instances; no benchmark in the wiki is built to support it, so every model-side control measurement here is confounded with the model's encoder.

---

## Connections

- **[[wiki/concepts/priority-map.md]]** — an anatomical instance of the shifting-specific factor, isolated by lesion rather than by factor analysis: inactivating the ventral bank of the principal sulcus costs nothing when the search cue is repeated in blocks and impairs search when it changes trial-to-trial, while the adjacent prearcuate region's loss impairs both (Bichot et al. 2015).
- **[[wiki/concepts/cognitive-control.md]]** — supplies the individual-differences decomposition its mechanism implies: an architecture whose only control primitive is additive bias into a mutually inhibiting substrate predicts exactly the observed bifactor structure (updating- and shifting-specific factors, **no** inhibition-specific factor), so the psychometrics confirm guided activation from a direction no recording study can. That page also carries the interventional complement to this page's inverted-U claim: control performance is raised by a scalar applied to the loop, and the same scalar has the opposite sign on a task where fast default responding is correct — an operating point rather than a monotone gain, measured behaviourally in humans (Widge et al. 2019).
- **[[wiki/concepts/working-memory.md]]** — locates the store's operations inside the control factor structure: updating has variance, genetics and a dopamine D1 dependence of its own, separable from set-shifting; and `g` loads on the *updating-specific* component as well as on the common one, so working-memory capacity is not merely a symptom of general control.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the mechanism side of this page's null result: response inhibition has no specific factor, which is what a design with *no dedicated suppression channel* predicts — so that page's addressed inhibitory channels are a positive claim this page's psychometrics would detect as an inhibition-specific factor if they carried between-subject variance.
- **[[wiki/concepts/controller-knowledge-vs-process.md]]** — the same unity/diversity question one level up: that page asks whether the controller is one adaptive pool or partitioned by *content*, this one shows it is partitioned by *operation* with a shared component, and the multiple-demand network is the shared component both pages are arguing about ([[wiki/empirical-tensions.md]] T96).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — a third factorization of the same controller, cut by output port rather than by operation; the two are compatible and jointly say a machine controller needs shared state, operation-specific parameters, *and* typed output channels.
- **[[wiki/concepts/attractor-dynamics.md]]** — the candidate mechanism for this page's stability–flexibility anticorrelation: one gain parameter setting basin depth would make maintenance and set-shifting move in opposite directions under a single neuromodulatory manipulation, which is what dopamine depletion does.
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — separated by lesion from monitoring within lateral prefrontal cortex: BA-8 damage impairs conditional stimulus→response selection while sparing *n*-back, and BA-9/46 damage does the reverse, so cue→action binding is its own circuit rather than a use of the working-memory one.
- **[[wiki/concepts/attention.md]]** — supplies the boundary between two kinds of flexibility this page's lesion table separates: reversing a value under a fixed dimension is orbitofrontal, redirecting attention to a different feature dimension is ventrolateral prefrontal, and only the second is an attentional operation.
- **[[wiki/concepts/successor-representation.md]]** — offered here as the third control mode between goal-directed and habitual, with a clinical anchor: a measured compulsivity factor tracks a bias toward model-free responding, so the arbitration this page needs is the one that page formalizes.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — puts a currency on control's shared component: if every operation draws on one common factor, then a skill's control cost is a draw on a single budget, and the anticorrelated components say that budget cannot be redistributed freely.
- **[[wiki/entities/pbwm.md]]** — the architecture with maximal diversity and no unity: independent per-stripe gates, no shared control resource, so it should show *no* common factor across control tasks — a directly testable mismatch with the biological decomposition.
- **[[wiki/concepts/compositionality.md]]** — supplies the network-topology numbers that page's argument needs: modularity *and* global efficiency both predict control ability in the same sample, so the target is a modular architecture with high-bandwidth cross-module paths plus demand-dependent reconfiguration.
- **[[wiki/concepts/population-geometry.md]]** — adaptive coding is a geometric claim (one ensemble re-used across tasks) and this page adds the constraint it must satisfy: re-use must still leave operation-specific variance, since updating and shifting are separable in behaviour, pharmacology and genetics.
- **[[wiki/concepts/dynamic-network-connectivity.md]]** — the spine-level mechanism behind this page's inverted-U row: each modulator sets a shunt conductance through a second-messenger cascade, so control components have an operating point by construction — and the two knobs are separable in the same way the factor structure is (α2A raises signal, D1 suppresses noise, on disjoint spine populations) (Arnsten et al. 2010).
