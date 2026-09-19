# Numerosity

**Cardinality — the number of elements in a set — carried by single neurons tuned to a preferred count, invariant to what the elements are, how they are arrayed in space, whether they arrive at once or one at a time, and which sense delivered them; the wiki's only vocabulary primitive whose code is measured *and* whose grain is set by a stated principle rather than by an author's hand.**

> **Provenance.** Nieder 2016, *The neuronal code for number*, Nat. Rev. Neurosci. 17(6):366–382 (`raw/nieder-2016-neuronal-code-for-number.md`). A review of the author's own macaque single-unit programme (lateral prefrontal cortex and intraparietal sulcus) plus the human imaging and neuropsychology literature. Box 1 (*sense of number*) and Box 2 (convergent evolution in non-primate endbrains) are referenced in the clip and their bodies are not — claims attributed to them are second-hand.

Every other wiki page that needs a discrete symbol either installs one ([[wiki/entities/gcq.md]]), induces one from a bottleneck ([[wiki/concepts/affordance-grounded-symbols.md]]) or declares one in a DSL ([[wiki/entities/ilp-arc-synthesizer.md]]), and in each case the *resolution* of the symbol set is a free parameter (`G4`). Number is the case where biology fixes it by a law.

---

## The code

| Property | Measurement | Architectural reading |
|---|---|---|
| **Labelled-line rate code** | A neuron has a maximum discharge rate at its preferred numerosity and falls off monotonically with numerical distance — a peak-tuned function, holding across spatiotemporal formats, modalities and sensory-motor domains | A basis over the magnitude axis, not a scalar register. The value is read from *which* lines fire, not from how much one line fires |
| **Bell-shaped, and symmetric only on a log axis** | Tuning curves and behavioural performance functions are asymmetric on a linear number scale and symmetric under logarithmic compression | The axis is `log n`, so the same code is used for 2 and for 20 |
| **The grain follows from the compression** | Log scaling buys three things at once: tuning widths equal for all numbers (**scale invariance**), response variability independent of number preference, and agreement with the Weber–Fechner law | **This is the row `G4` asks for.** The vocabulary's resolution is not chosen; it is a consequence of one decision about the axis |
| **Distance effect** | Numerically distant numbers are easier to discriminate (2 vs 6 > 5 vs 6) | Falls out of tuning-curve overlap — no separate comparison mechanism is needed |
| **Size effect** | At fixed distance, small numbers discriminate better (2 vs 3 > 8 vs 9) | Falls out of tuning curves and population activity broadening with magnitude on a linear readout |
| **Zero has a line** | Neurons respond selectively to a numerosity of zero | The empty set is a value in the vocabulary, not the absence of one — which no machine counting primitive in the wiki represents |
| **Rate plus time** | A statistical classifier decodes quantity category from tuned cells (high accuracy) **and, less accurately, from cells with flat spike-count tuning** — temporal discharge structure carries supplementary number information. Both signals collapse on error trials | A unit that looks untuned to the wiki's usual instrument (mean rate per condition) can still be carrying the variable. Any "this population does not code X" claim from rate alone is under-powered |

**Where the tuned units come from.** A numerosity-detector model derives peak-tuned, log-scaled detectors by combining **summation units** — neurons whose rate increases or decreases monotonically with count — from parallel input. The serial alternative is the mode-control accumulator (one pacemaker impulse per enumerated element), imported from animal timing. Both yield analogue representations and predict Weber–Fechner. The spatial-array data fit the detector model; whether it extends to serial presentation is open.

---

## Abstraction is a two-stage hierarchy with a measured gradient

| | **Intraparietal sulcus** (ventral intraparietal area) | **Lateral prefrontal cortex** |
|---|---|---|
| Share of randomly sampled neurons number-selective | 15–20% | 20–30% |
| Latency to number | Earlier (simultaneous parietal + frontal recordings, repeatedly) | Later |
| Sensitivity to co-varying sensory features | Higher | Lower |
| Cross-modal (visual + auditory) tuning in the same cell | **Absent** — intermingled cells code visual *or* auditory numerosity | **Present** — 11% of all recorded cells respond to the same count in both |
| Numerosity ↔ arbitrary sign (a learned shape for '3') | Not signalled | Signalled across time |
| Delay-period tuning (working memory) | 10–20% | 20–30% |
| Rule tuning (greater-than / fewer-than) | Present, less frequent | ~20% of cells |

Read as a design: **the same variable is re-represented twice, and the second copy differs from the first only by having discarded `x`.** The parietal copy is cheaper and modality-bound; the frontal copy is supramodal, sign-linkable and rule-usable. This is the wiki's cleanest biological instance of the `g`/`x` split appearing as *two stages of one pathway* rather than as two channels ([[wiki/concepts/abstract-structural-codes.md]]) — and the author's stated payoff for the second stage is compute, not fidelity: stripping sensory specificity reduces signal complexity, speeds processing, and is what makes the numerosity→arbitrary-sign association learnable at all.

**Operationalised abstractness.** The source declines the philosophical version and adopts: *neuronal populations that code numerical quantity and are insensitive to the form of input in which the numerical information was presented*. Prefrontal number responses generalise across spatial arrangement, density and total area; across simultaneous vs sequential presentation; across vision vs audition; and across dot arrays vs learned signs. Four invariances, each tested by controlling one confound at a time — the discipline is forced, because varying count necessarily varies something else (fix total area and item size must shrink per added item).

---

## The code is not a training artefact, and it is causally load-bearing

| Claim | Evidence |
|---|---|
| **Not built by the task** | Number-tuned cells with preferred numerosities are found in ventral intraparietal area and lateral prefrontal cortex of monkeys **never trained to judge number** |
| **Sensory-like** | Numerosity estimates **adapt** (set sizes underestimated after exposure to a high count), across sequential presentation, across modalities, across spatiotemporal formats — and the adaptation is *spatially selective*, implicating cells with restricted response fields |
| **Necessary** | Pharmacological inactivation of parietal area 5 in monkeys trained to make one to five hand movements causes **omitted individual movements** — not a motor deficit, not an action-selection deficit |
| **Behaviourally read** | On error trials the discharge to the preferred number is markedly reduced, and a population decoder can no longer classify the numerosity the monkey saw |

The naive-monkey row is the one that matters for the installed-vs-learned dispute ([[wiki/concepts/core-knowledge.md]], [[wiki/empirical-tensions.md]] T12): the code exists before the task that reads it. It is *not* an innateness proof — a lifetime of visual experience precedes the recording — but it removes the strongest deflation, that number tuning is sculpted by the discrimination training.

---

## Discrete, continuous, and the same neurons

Many parietal and prefrontal cells respond to **length, distance and time** as well as to count, with number-tuned and length-tuned cells anatomically intermingled and some cells coding both. Two consequences the source draws:

- **A single-neuron readout of magnitude is uninformative or ambiguous** — uninformative if the cell is tuned to a magnitude that is not currently relevant, ambiguous if it encodes more than one. The population code is therefore not an accuracy optimisation but a **disambiguation requirement**: the *pattern* of relative activity across differently tuned cells is what identifies both the magnitude type and its value.
- This distributed tuning predicts the overlapping imaging activations and the behavioural interference between magnitudes, and motivates a **generalised magnitude system** over number, space and time.

**(brainstorm)** For a builder this inverts the usual motivation for population codes. The wiki's standing argument for them is noise robustness; here the argument is *type disambiguation* — one population serves several quantity dimensions, and which dimension is being reported is recoverable only jointly with its value. A machine primitive library built the same way would have no per-primitive slot at all: `COUNT`, `LENGTH` and `DURATION` would share units and be separated by the readout, which is cheaper than three heads and is the only account in the wiki of why an architecture *should* entangle nominally distinct primitives.

---

## Microcircuit: the tuning width is set by inhibition

Extracellular prefrontal recordings, separating putative pyramidal cells (broad waveform, low rate) from putative inhibitory interneurons (narrow waveform, high rate), with functional connectivity read from temporally correlated discharges:

| Pair | Tuning relationship | Mechanism |
|---|---|---|
| Adjacent **pyramidal–pyramidal**, functionally connected | *Similar* numerosity tuning, synchronous excitation | Shared excitatory input |
| **Interneuron–pyramidal**, functionally connected | **Inverted** tuning profiles, negatively correlated in time — interneuron discharge coincides with marked pyramidal inhibition | The interneuron's preferred numerosities are the pyramidal cell's *flanks*, so lateral inhibition lowers the shoulders and **sharpens** the curve. Blocking GABAergic inhibition broadens the profiles |

The same wiring then does double duty: once a number is encoded, recurrent excitation among the tuned pyramidal cells sustains the code through a delay, while local interneurons suppress pyramidal cells with a *different* numerosity preference — persistence and selectivity from one circuit ([[wiki/concepts/working-memory.md]], [[wiki/concepts/inhibitory-control-of-coding.md]]).

**This is the sharpest available statement of what a machine normalisation layer is missing.** Tuning width — the grain of the vocabulary — is here a *controlled* quantity, set by an inhibitory population whose own tuning is the complement of the cell it sharpens. A global softmax or LayerNorm pools over everything and therefore cannot implement "inhibit exactly the flanks".

---

## Working memory: the frontal copy is overwritten, the parietal copy is not

A distractor number is inserted into the delay of a delayed-match-to-number task ([[wiki/concepts/working-memory.md]]), with simultaneous prefrontal and ventral-intraparietal recording:

| Epoch | Lateral prefrontal cortex | Ventral intraparietal area |
|---|---|---|
| Delay 1 (after sample) | Tuned persistent activity for the sample number | Tuned persistent activity for the sample number |
| Distractor | **Sample information overwritten** — neurons respond strongly and in a tuned manner to the *distractor*, sometimes with a different preferred numerosity | **Largely unaffected**; sample representation retained |
| Delay 2 | Sample representation **regenerated**, in time to solve the task | Retained |

Behaviour: monkeys resist the distractor most of the time, with a small error increase.

The spatial working-memory literature reports the **opposite** assignment — prefrontal cells respond only mildly to distractors (read as the gate that protects the store) while parietal cells encode any stimulus regardless of relevance (read as an inferior correlate of memory). The source's reading is that prefrontal activity is not memory storage but a **top-down selection signal** that must represent the irrelevant item in order to filter it, with the actual maintenance living in the ventral intraparietal area; prefrontal lesions then impair interference resistance because *control* is dysfunctional, not because storage is lost. Logged as [[wiki/empirical-tensions.md]] **T385**, and it is the third distinct reading of prefrontal delay activity the wiki carries alongside `T88`'s item-vs-pointer split.

---

## Rules over the code

Monkeys switching between **greater-than** and **fewer-than** rules — sample numerosity, memory delay, rule cue, rule delay, comparison — generalise to novel numerosities, i.e. learn the principle rather than the pairs.

| Finding | Number / detail |
|---|---|
| Rule-selective prefrontal cells | **~20%**, split roughly half/half between the two rules |
| What the selectivity survives | The sample numerosity the rule applies to; the sensory appearance of the rule cue; motor preparation (the comparison number is not yet available, so no response can be prepared) |
| Timecourse | Rule selectivity evolves **gradually** through the rule delay |
| Behavioural coupling | On wrong decisions, the rule-delay response to the preferred rule is markedly reduced |
| **Rule specialists vs rule generalists** | Applying quantity rules to *number* and to *line length*: most rule cells fire for the rule applied to one magnitude type only (specialists); others represent the overarching magnitude rule across both (generalists) |
| Population form | Rule coding is a **dynamic trajectory through activity state space**, with distinct greater-than / fewer-than trajectories visible in three dimensions |
| Neuromodulation | D₁ and D₂ dopamine receptor families **cooperatively enhance** number coding by distinct physiological mechanisms (micro-iontophoresis during single-cell recording) |
| Lesion signature | *Task-switching acalculia* — a frontal-lesion patient whose calculation is intact but who cannot switch between multiplication, addition and subtraction; cognitive-estimation deficits across size, weight, numerosity and time with semantic number representations spared |

**The specialist/generalist mixture is the transferable part.** The same population simultaneously holds an operator bound to its argument type and an operator abstracted over argument types, with the generalists placed one level up the functional hierarchy because they extend the rule to new circumstances. Every rule representation in the wiki is one or the other by construction ([[wiki/concepts/cognitive-control.md]]'s abstract rule cells are generalists; a DSL primitive is a specialist). **(brainstorm)** A mixture is strictly better for `G4`-style vocabulary growth: the specialists supply the cheap, immediately-executable path for the argument types already seen, and the generalists supply the transfer path for a type never seen — and because both are present, the system does not have to *decide* which level to represent the rule at, which is the decision `T151` and `G75` keep discovering nobody makes.

---

## The three regimes, and where the discretisation switches

Three processes are held to underlie nonverbal number (glossary of the source):

| Regime | Range | Obeys Weber's law? | Mechanism named |
|---|---|---|---|
| **Subitizing** | up to ~4 | — | Object-file / object-tracking system: assign a *file* or *pointer* per item |
| **Number estimation** (analogue magnitude) | small and large | **Yes** | This page's tuned, log-scaled code |
| **Texture-like** | very many, densely packed | **No** | Unnamed |

This is `G27`'s discretisation question posed at a scale where the answer is known — and the answer is that there is no single answer: **the same input is carved by three different mechanisms and the boundary between them is set by set size and density, not by a criterion the system computes.** The subitizing row is also a pointer-without-a-description — a *file* assigned to an item with no claim about what the item is — arriving here from the quantity side rather than from the tracking side.

---

## Reading in the core framing

| Element | Latent-graph reading |
|---|---|
| A number neuron | One node of an installed vocabulary, with a measured basis function attached |
| Log-compressed axis | The **grain rule**: resolution per node is fixed by the axis's compression, so the vocabulary size is derived rather than chosen |
| Supramodal prefrontal copy | `g` with `x` stripped, obtained by a second pass rather than by a separate channel |
| Numerosity ↔ arbitrary sign linkage | The attachment point for an *external* symbol system — the same mechanism [[wiki/concepts/core-knowledge.md]] nominates for overriding core priors |
| Greater-than / fewer-than rule cell | A reified edge-type over the magnitude axis (`G8`), with a generalist variant that is edge-type-over-edge-types |
| Magnitude-general population | Several primitive dimensions sharing one substrate, separated at readout rather than at storage |

---

## Open problems

- **The grain rule is stated, not derived.** Logarithmic compression is conceded by the source to be "a mathematical approximation" — it is preferred because it yields the most symmetric tuning functions compared with alternatives such as peak power functions, which is a curve-fitting argument, not a normative one. `G4` therefore gets an existence proof of a principled grain and not a principle.
- **No mechanism converts the analogue code to the exact one.** The parieto-frontal system is called a *preadaptation* for symbolic mathematics and the symbolic system is said to "co-opt" or "recycle" it; nothing specifies the conversion. The open-ended precise integer list is exactly what [[wiki/concepts/discrete-infinity.md]] finds absent in every non-human species that has this code.
- **The serial case is unmodelled.** The numerosity-detector model handles spatial arrays; the mode-control accumulator handles sequences; nothing reconciles them, although the *same neurons* are tuned across both formats.
- **Population decoding is proposed, not built.** Population-vector and maximum-likelihood readouts are borrowed from motor and sensory work and said to need "adaptations"; no decoder is specified for the case where the population is simultaneously reporting number, length and duration — which is the case the same source argues is the real one.
- **Nothing says what sets a cell's preferred number.** Tuning is measured everywhere and its origin is left to the summation-unit hypothesis, which itself presupposes monotonic accumulators whose gain nobody specifies.
- **Both instruments are correlational where the interesting claim is causal.** The only causal manipulation is inactivation of parietal area 5 for *hand movements*; the abstraction gradient, the distractor dissociation and the rule hierarchy all rest on recordings plus error-trial correlations.

---

## Connections

- **[[wiki/concepts/core-knowledge.md]]** — supplies the cellular code for that page's number system, and converts two of its behavioural claims into measurements: modality-invariance becomes 11% of prefrontal cells tuned to the same count in vision and audition, and the "format installed, precision learned" split becomes a log-compressed axis whose compression *is* the format and whose tuning width is the precision.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the `g`/`x` split realised as two stages of one pathway rather than two channels: the parietal copy is modality-bound and sensory-feature-sensitive, the prefrontal copy is supramodal and sign-linkable, and the stated payoff for the second stage is reduced signal complexity rather than better fidelity.
- **[[wiki/concepts/discrete-infinity.md]]** — the code on the shared side of that page's comparative subtraction: approximate, Weber-limited magnitude is present in monkeys with a measured neuronal basis, and the successor-generated integer list that is absent has no candidate mechanism here either, so the boundary is now drawn between a described code and an undescribed one.
- **[[wiki/concepts/cognitive-control.md]]** — the same prefrontal population carrying an abstract rule, with one property that page's match/non-match cells do not have: a *specialist/generalist mixture*, where some cells bind the greater-than rule to one magnitude type and others abstract it over number and length at once.
- **[[wiki/concepts/working-memory.md]]** — a delayed-match task in which the prefrontal delay representation is overwritten by a distractor and regenerated while the parietal one is not, which reverses the region assignment the spatial working-memory literature uses (`T385`) and supplies a microcircuit — recurrent pyramidal excitation for persistence, flank-tuned interneurons for selectivity — for tuned persistent activity.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the same "inhibition sets a coding feature" claim in cortex and at the level of a *tuning curve*: functionally connected interneurons have inverted numerosity tuning relative to the pyramidal cells they inhibit, so selectivity width is an addressed inhibitory output rather than a consequence of excitatory weights.
- **[[wiki/concepts/population-geometry.md]]** — two results in this code's terms: rule identity is a dynamic trajectory through state space rather than a static pattern, and quantity category is decodable from cells whose *spike-count* tuning is flat, so a population's information can exceed what per-condition mean rates report.
- **[[wiki/concepts/evidence-accumulation.md]]** — the same Weber-limited discrimination approached from the decision side; here the ratio limit comes from overlap of log-scaled tuning curves rather than from the probability of reaching a firing rate, so the two pages hold independent derivations of one psychophysical law.
- **[[wiki/concepts/relational-bottleneck.md]]** — the competing account of the same capacity signature: subitizing's ~4-item limit is read there as interference among compositional bindings, and here as a separate object-file regime sitting beside the analogue code, which predicts a discontinuity at the boundary rather than a graded cost.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the vocabulary-primitive slot filled once, completely: a node type with a measured basis function, a derived grain, an invariance profile, a causal test and a rule layer above it — the specification every other primitive in the wiki is missing at least half of.
- **[[wiki/entities/arc-agi-3.md]]** — the benchmark generation that *dropped* number and counting from its declared prior list, which this page prices: the dropped prior is the one core system with a measured neuronal code, so the exclusion removes the best-specified item rather than a marginal one.
- **[[wiki/concepts/certification-instruments.md]]** — the Weber ratio is instrument `I2`'s worked example of a quantitative constant, and this page supplies what the instrument assumes and never had: the constant's mechanism (log compression) and the circuit that sets its value (flank-tuned lateral inhibition), so a model's Weber ratio can now be predicted from its code rather than only measured.
- **[[wiki/concepts/visual-routines.md]]** — the direct rival for small-`n`: subitizing derived as index → mark → re-index using operations that exist for other reasons, with the explicit argument that a dedicated counting network is not worth building — against which this page's tuned number neurons are exactly that network, measured; the joint reading is that exact/small and approximate/large are different mechanisms, which supplies `G27` a criterion (must the answer be exact, hence must individuals be marked one at a time).
- **[[wiki/concepts/visual-indices.md]]** — the subitizing regime's *entry condition*, measured: the same squares subitize side by side and do not when concentrically nested, and precuing item locations speeds counting but not subitizing — so small-`n` is "read off how many pointers are active" and is available only when items are preattentively individuable, which is a property of the display rather than of set size, and is the criterion `G27` records as missing between the regimes (Trick & Pylyshyn 1994; Pylyshyn 2001).
- **[[wiki/entities/blindtest.md]]** — the machine profile against both regimes on this page: accuracy holds to `N = 5` and falls off a cliff rather than degrading with Weber-scaled imprecision, which is the signature of a retrieved configuration rather than of either the exact serial routine or the tuned approximate code — and it disappears when the shape is changed to one with no famous 5-instance arrangement.
