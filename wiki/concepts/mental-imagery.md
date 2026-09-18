# Mental Imagery — the sensory hierarchy driven backwards, and the wiki's only *measured* competition between a generated and a perceived signal

**A sensory representation produced by driving the visual hierarchy top-down from stored memory instead of from the retina: the same feature format, the same retinotopic and orientation locality, the same cortical sheet as afferent perception, at lower amplitude. It therefore *sums into* perception rather than replacing it — priming it when weak, adapting it when strong — and its strength is set by two continuous parameters (top-down drive against ongoing sensory noise) with no mode switch and no arbitrator anywhere in the account.**

> **Provenance.** Pearson 2019, *The human imagination: the cognitive neuroscience of visual mental imagery*, Nat. Rev. Neurosci. 20:624–634 (`raw/pearson-2019-human-imagination-visual-mental-imagery.md`). A review by the author of the binocular-rivalry imagery measure, written after the "imagery debate" (depictive vs propositional format) is declared over; human fMRI, multivariate decoding, psychophysics, anatomy (V1 surface area), TMS/tDCS and the aphantasia literature.

---

## One word, several computations

The review's own first warning, and the reason this page is a concept page and not a mechanism page: *imagining an apple*, *mental rotation* and *imagining a physical action* are three different tasks that "logically should involve different brain areas, yet all get referred to under the umbrella term 'imagery'" — which is [[wiki/concepts/node-definition-problem.md]] applied to a process rather than a region. Everything below is about **visual object imagery** unless stated.

| Type | Trigger | Where the content is | Frontal involvement |
|---|---|---|---|
| **Voluntary** | Endogenous, task- or goal-initiated | Sensory areas matched to the content (V1/V4 for colour, MT for motion) | Yes — but *content-independent* |
| **Involuntary, associative** | A learned association with a present stimulus (colour memory of a greyscale banana; conditioned absent stimulus) | Same sensory areas | **Unknown; no dataset** |
| **Involuntary, local perceptual** | Perceptual filling-in, neon colour spreading, low-contrast texture completion | V1/V2 retinotopic to the filled region | Assumed none |

**The involuntary row is the architecturally interesting one.** As learning proceeds between two stimuli, middle-temporal and inferotemporal neurons come to respond to the *absent* stimulus as if present; a prediction template for an upcoming stimulus is formed in V1 **even when the stimulus is never presented**. A generative prior firing without a command, on the same units that carry the percept — no controller, no gate, no separate decoder.

---

## The reverse hierarchy

The functional model: trigger (frontal cortex, medial temporal lobe) → high-level visual areas → early visual cortex, i.e. the perceptual cascade run in reverse.

| Stage | What is established | What is not |
|---|---|---|
| **Frontal** | Active during formation and manipulation; activity is **largely independent of imagery content** ⇒ an organisational/executive role, not a content store | How the areas cooperate dynamically to produce the image "remains unclear" |
| **Hippocampus** | BOLD response for complex/spatially distributed images; hippocampal damage → imagined experiences lacking spatial coherence and richness; a small percentage of human single units respond to imagery | Other studies find no role in imagery creation; net verdict "unclear" |
| **Default mode network** | Overlaps the networks for re-experiencing the past and constructing possible futures; dorsolateral prefrontal + posterior parietal + precuneus + occipital act as a network to *construct and deconstruct* non-episodic abstract images | Confounded — most studies use complex episodic scenes, so the temporal/memory components cannot be separated from the pure sensory generation |
| **V1/V2** | Imagery content is **decodable** despite low BOLD amplitude; decoders trained on *perception* decode *imagery*, and still do when constrained by voxel-wise models of perceptual features (contrast, spatial frequency) ⇒ imagery is composed of the same visual features as afferent perception | Amplitude above baseline is inconsistent across ~20 studies; the discrepancies are attributed post hoc to task, content complexity and individual imagery strength |

**The gradient is the transferable claim.** Patterns common to perception and imagery emerge as early as V1 but become **increasingly similar with ascent up the hierarchy** — explained by proximity to the driver: areas physically and synaptically closer to the frontal/medial-temporal trigger carry more perception-like representations than distant V1. A generator implemented as the encoder read backwards should therefore be expected to *degrade with depth of the reverse pass*, which is a prediction about decoder fidelity that no wiki architecture reports and which [[wiki/entities/bb-model.md]] independently exhibits (recall correlations highest for the populations nearest the store, lowest at the parietal rendering window).

---

## Imagery behaves like weak perception — the evidence that fixes its format

| Effect | Measurement |
|---|---|
| Priming | Imagining an oriented grating biases subsequent binocular-rivalry dominance toward that grating, as a *weak physical* stimulus does; the effect survives an intervening demanding cognitive task |
| **Energy law** | The strength × duration ("energy") of the prior signal decides the sign: weak/brief → facilitation (priming); strong/long → suppression (adaptation). Longer imagery epochs prime more strongly |
| Perceptual learning | Imagined content induces visual perceptual learning, improving later sensitivity to those stimuli |
| Associative learning | Imagined content can be conditioned to an emotional stimulus, and the association transfers to perceptual stimuli in an early-visual-specific way |
| Autonomic read-out | Imagined brightness produces the corresponding **pupil diameter** change with no stimulus present |
| Locality | Effects are local in retinotopic and orientation space, like perception |
| Decoding | Perception-trained BOLD classifiers decode imagery content; deep networks trained on a limited set of perceptual features decode *untrained* features in imagery |
| Not attention | Imagery and attention effects dissociate by timing and by susceptibility to sensory disruption; priming tracks reported vividness **trial by trial** |

**Instrument.** The binocular-rivalry priming paradigm is what makes "imagery strength" an objective quantity rather than a questionnaire score, and it is what converts the whole topic from introspection into a dial an architecture could copy: report the imagined signal's effect on a subsequent perceptual decision rather than asking the system how vivid it was ([[wiki/concepts/certification-instruments.md]]).

---

## The two-parameter account: drive over noise

The review's mechanistic proposal is that early visual cortex is a **"representational blackboard"** written from either direction, so imagery strength is not one variable but a ratio:

```
imagery strength  ≈  top-down drive ("chalk contrast")  /  ongoing intrinsic activity ("noise on the board")
```

| Observation | Value / direction |
|---|---|
| V1 **and** V2 surface area vs imagery strength (binocular rivalry) | **Negative** — stronger imagers have smaller primary visual cortices. V3 does not predict |
| V1 surface area vs imagery *precision* (spread over orientation and retinotopic space) | **Positive**, as it is for perception ⇒ **strength and precision trade off**: the strongest imagers are not the most precise |
| V1 size vs frontal size | Reciprocal — smaller V1 predicts larger frontal areas, i.e. potentially more top-down control per unit of sheet |
| Resting excitability (TMS phosphene thresholds, resting fMRI activity) | Stronger imagery ↔ **lower** resting visual-cortex activity; tDCS shifts imagery strength weakly in both directions |
| Vividness over time | **Not a trait** — fluctuates moment to moment within an individual, predicted by whole-brain activity including the degree of perceptual overlap |
| Clinical trend (correlational) | Schizophrenia: V1 neuron count and size down ~25% against ~2% whole-brain, with *enhanced* imagery vividness; PTSD (Post-Traumatic Stress Disorder) and stimulant dependence: stronger imagery alongside reduced visual-cortex grey matter |

**Why a ratio and not a switch is the architectural payload.** Every generative mode in the wiki is entered by a mode variable — a gain scalar, a precision term, a gate ([[wiki/entities/bb-model.md]], [[wiki/concepts/predictive-coding-free-energy.md]]). Here the same continuum is produced by *two* separately measurable quantities on the same sheet, one of which (noise) is a property of the substrate the controller does not write. That makes imagery strength a quantity the system cannot simply set, and predicts an individual-differences axis in any architecture that generates into its own sensory layer — which no wiki model reports because none has a noise term at the generated layer at all.

---

## Aphantasia and hyperphantasia: the ends of the axis, and one negative result that matters

| | Finding |
|---|---|
| **Aphantasia** (congenital absence of voluntary visual imagery) | Floor on vividness questionnaires *and* significantly reduced on the objective binocular-rivalry measure ⇒ not a reporting-criterion artefact |
| Spared in aphantasia | **Spatial** imagery — aphantasics score *slightly higher* than controls on spatial-imagery questionnaires ⇒ the deficit follows the ventral `what` and spares the dorsal `where`/transformation route |
| Also spared | Easy and medium visual working-memory tasks (hard ones fail); reported episodic memories, though rated low on "reliving"; visual imagery **during dreams** ⇒ involuntary routes may be intact |
| **Hyperphantasia / eidetic imagery** | 0–11% of children; images stay still while the eye moves (unlike afterimages), positive colours, projected into space, present-tense description; random-dot stereogram depth recoverable by combining a remembered image with a perceptual one **up to 24 h later**. No modern psychophysics, fMRI or TMS data exist |

**The negative result:** performance on a compound task cannot distinguish a person who solves it by rendering from a person who solves it some other way. Only strong imagers are impaired by irrelevant visual input during visual working memory — i.e. visual-cortex involvement in that task is a **per-individual strategy**, not an architectural fact about the task. The review draws the methodological conclusion directly: any study of visual working or episodic memory that does not measure imagery ability is averaging over two mechanisms. Logged as [[wiki/empirical-tensions.md]] T386, because the wiki's own retrieval machinery assumes the render is on the path.

---

## The architectural reading

**(brainstorm) There is no arbitrator here, and the account does not need one.** `G90` asks for an internally generated mode that competes with the input-driven one plus something to assign between them. Imagery supplies the competition with a *measured* price and deletes the assigner: the generated signal lands on the same units as the afferent one and is summed, so the interaction is settled by the **energy law** (weak → priming, strong → adaptation) rather than by a scheduler. Two consequences. (i) The "competition" is not for the channel but for the *sheet* — the Tetris result (playing a visuospatial game after traumatic footage reduces later intrusive imagery) is the same claim as an occupancy limit: units carrying a percept are not available to carry a generated image, which is a capacity constraint no wiki architecture imposes on its generator. (ii) An architecture generating into its own input layer gets the mode boundary *wrong by design* unless something else maintains it — and the review's own list of open questions includes why imagery is not confused with perception, which is exactly the maintenance problem `G90` names.

**(brainstorm) The controller carries no content, and that is a measurement, not a design choice.** Frontal activity during imagery is largely content-independent across studies. Read as an interface specification this is the arrangement `G110` asks for and [[wiki/entities/bb-model.md]] implements with its mode scalar: the controller writes *strength and direction*, never *what*. The addition here is that the biology apparently does not even route the content through the controller — the trigger is frontal/medial-temporal, the content is assembled in sensory cortex, and the review has no account of how the trigger selects which memory is read.

**(brainstorm) Imagery is the wiki's cleanest available ablation instrument for feedback.** Perception is constitutively interactive, so feedforward and feedback contributions cannot be separated in it. Voluntary imagery is the review's candidate for *the only sensory representation attributable solely to feedback signals*, obtainable in complete sensory isolation. For an architecture this translates into a runnable test with no new machinery: drive the generator with the input clamped off and measure what the sensory layers produce — the resulting representation is the feedback pathway's output, unmixed. It is the natural partner to T278's demand that reentrance-requiring tasks be named before reentrance is claimed necessary ([[wiki/entities/ventral-visual-stream.md]]).

**(brainstorm) The `what`/`where` split survives into the generator.** Ventral damage disrupts visualising shape; dorsal damage disrupts visualising locations and spatial transformations; aphantasia removes object imagery and leaves spatial imagery intact or better. So the reverse pass is not one generator but at least two, running back down two streams with independent failure — which matches the wiki's split between [[wiki/entities/ventral-visual-stream.md]] and [[wiki/entities/dorsal-visual-stream.md]] and says a system can render *where* without being able to render *what*.

---

## Open problems

- **Why imagery is not mistaken for perception.** Stated as an open question by the author; no mechanism is proposed, and the two-parameter account predicts confusion at high drive and low noise rather than forbidding it.
- **What turns it on.** No policy for initiation, duration or content selection; the voluntary/involuntary split is a taxonomy, not a controller (`G15`).
- **Whether imagery *adds* activity to visual cortex or only modulates it** — undecided in the source, and the two readings imply different implementations of the generator (additive drive vs gain change on ongoing activity).
- **Whether unconscious imagery exists.** Images can apparently form prior to conscious voluntary effort; if so, "imagery" is not coextensive with the experience it is named after.
- **Aphantasia: one end of a spectrum or a separate category?** Unresolved, and it decides whether the drive parameter is continuous down to zero or whether a component is absent.
- **All strength/anatomy links are correlational.** The V1-size and excitability results do not specify a functional mechanism, and tDCS — the only causal handle — has a weak effect.
- **The hippocampal role is contradictory across studies**, so the review's own diagram (trigger includes medial temporal lobe) is asserted at lower confidence than the sensory half.

---

## Connections

- **[[wiki/entities/bb-model.md]]** — the implemented form of this page's reverse hierarchy, with the two things the review lacks supplied: a mode scalar that sets direction and strength without touching content, and a measured blur that grows with distance from the store — and the two things it lacks supplied here: an intrinsic-noise term at the generated layer, and the observation that the same individual's render strength fluctuates rather than sitting at a set gain.
- **[[wiki/concepts/reference-frame-transformation.md]]** — the "same weights read backwards" premise tested in biology rather than assumed: imagery is decodable by classifiers trained on perception and built from the same voxel-wise perceptual features, which is the empirical warrant for a single bidirectional weight set, while the perception-to-imagery amplitude drop is the cost that page charges to the reverse direction.
- **[[wiki/entities/ventral-visual-stream.md]]** — the cascade this page runs in reverse, and its complement as an instrument: that page measures what the feedforward wave finishes in 100 ms with feedback excluded, this one isolates the feedback pathway by removing the input entirely, so the pair brackets T278's feedforward-sufficiency claim from both sides.
- **[[wiki/entities/dorsal-visual-stream.md]]** — the second generator: dorsal damage removes the ability to visualise locations and spatial transformations while leaving shape imagery intact, and aphantasia is the reverse dissociation, so the reverse pass fails independently along the two streams.
- **[[wiki/entities/early-visual-system.md]]** — the sheet the generated signal lands on, priced: imagery strength is inversely related to V1/V2 surface area and to resting excitability, so the stage that page models as a feedforward filter bank is here a shared substrate whose intrinsic noise is one of the two parameters deciding what a generator can write.
- **[[wiki/concepts/working-memory.md]]** — the compound task this page dissolves into two mechanisms: only strong imagers are disrupted by irrelevant visual input during visual working memory, aphantasics pass easy and medium loads without any sensory render, and the two populations are indistinguishable by performance alone (`T386`).
- **[[wiki/concepts/constitutive-vs-enabling.md]]** — that page's canonical example, now with its own evidence and its own counterexample: imagery is the case where content occurs with the input pathway silent, *and* the aphantasia data show the sensory content can be absent while the dependent cognitive functions survive — so the render is enabling for some individuals and apparently not even that for others.
- **[[wiki/entities/default-mode-network.md]]** — the network credited with constructing and deconstructing mental images, including non-episodic ones, and the reason the crediting is weak: most studies use complex episodic scenes, so the imagery contribution cannot be separated from the memory and temporal components; the review's own proposed fix is to compare the network against pure abstract-feature imagery.
- **[[wiki/concepts/simulation-based-planning.md]]** — what a rollout costs when its states are rendered in sensory format: the render competes for the same units as perception (the visuospatial-interference result), degrades with depth of the reverse pass, and is absent in a fraction of the population that plans anyway.
- **[[wiki/concepts/cortical-state-bistability.md]]** — shares the instrument and inverts its use: binocular rivalry is the wiki's model of internally driven content switching, and here the same paradigm is run as a *measurement* of an imagined signal's sensory energy by how it biases the next dominance.
- **[[wiki/concepts/precision-weighting.md]]** — the same generated-versus-afferent arbitration written as one gain, against this page's two independent quantities (top-down drive, intrinsic noise) of which only the first is controllable — so a single precision term cannot reproduce the strength/precision trade-off the anatomy shows.
- **[[wiki/concepts/node-definition-problem.md]]** — "imagery" as a label spanning object imagination, mental rotation and motor simulation, which the review says should involve different areas and which the literature nonetheless averages over — the process-level analogue of that page's region-level cases.
- **[[wiki/concepts/visual-routines.md]]** — the complementary use of the same sheet: imagery drives the base representation top-down from memory so it *depicts* something else, where a routine writes task-dependent structure (a colouring, a mark, a trace) onto it without changing what it depicts — two distinct ways early visual cortex carries something other than the current retinal input.
