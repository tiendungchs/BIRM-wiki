# Predictive Adequacy — When Does a Model of a Component Count as Understanding?

**A description of a component is adequate when it predicts that component's response to *arbitrary* inputs — scored on held-out data, expressed as a fraction of the **explainable** (noise-ceiling-corrected) variance, with every parameter fitted under one input distribution and then frozen before testing under another. Every weaker version of the claim — tuning curves reproduced, a story told, variance explained on the same stimulus class the model was fitted on — is compatible with the model being wrong.**

> **Provenance.** Carandini et al. 2005, *Do we know what the early visual system does?*, J Neurosci 25(46):10577–10597 (`raw/carandini-2005-early-visual-system.md`), whose seven authors agree on the standard above and disagree on almost everything else. The worked case is [[wiki/entities/early-visual-system.md]]; this page holds the transferable part. Its relation to the wiki's other evaluation pages: [[wiki/concepts/certification-instruments.md]] asks whether a *system* discovered the intended structure, [[wiki/concepts/representation-probing.md]] asks whether a system *contains* a hypothesised structure. This page asks the third question — whether **our description of a system** is right — and it is the only one of the three that a neuroscience literature has been forced to answer with a number.

---

## The measurement ladder

Ordered by how much a passing score licenses. The review's own complaint is that its seven sections used four different rungs, making their results incomparable.

| Rung | Statistic | What it fails to exclude |
|---|---|---|
| 0 | The model reproduces the **tuning curve** (preferred orientation, preferred frequency) | Almost nothing. Qualitative selectivity is reproduced by models that predict individual responses badly — V1 complex-cell models get orientation preference to 3.6° and still sit far below the noise ceiling on natural stimuli |
| 1 | Correlation `r` between predicted and measured response | Scale and offset errors; and `r` is not comparable across experiments with different noise levels |
| 2 | Fraction of **total** response variance, `r²` | Response variability the model was never expected to capture. A ceiling below 1 is charged to the model |
| 3 | Fraction of **explainable** variance — total variance minus the trial-to-trial variability estimated from repeats (Sahani & Linden 2003; Hsu et al. 2004) | The right denominator, and the review's recommendation. Still says nothing about *which* responses are missed |
| 4 | Prediction of **spike times**, not rates (Keat et al. 2001; Paninski et al. 2004) | The rung at which the Poisson assumption stops being free — and where a refractory integrate-and-fire generator improved prediction below 50 ms and exposed a published adaptation effect as an artefact of the Poisson fit |

**Rung 3 is a different kind of measurement from rungs 0–2, because it makes the *ceiling* an experimental quantity.** Without it, "40% of variance" and "80% of variance" cannot be compared across two preparations with different noise; with it, the residual is attributable. This is the same move as a human baseline on a benchmark ([[wiki/concepts/human-baseline.md]]) and has the same effect: it converts a raw score into a statement about the gap that remains.

---

## The freeze protocol

The single most transferable device on this page, and the reason the LGN result in [[wiki/entities/early-visual-system.md]] counts as evidence while several better-fitting models do not:

1. Fit every parameter of the model on **simple, controlled stimuli** (drifting gratings).
2. **Freeze them.** Allow at most a nuisance rescaling at test — in Mante's case exactly two free parameters, spontaneous and maximal firing rate.
3. Test on a **different stimulus class** (natural movies, cartoons) never used in fitting.
4. Give the **rival simpler model the same number of free parameters** at test.

The point of step 4 is stated explicitly by the authors: a more complex model given no extra fitting freedom *can lose*, so its winning is informative. The nonlinear gain-control model beat the linear receptive field on natural movies at two free parameters each. The authors also note the practical reason the protocol was available: the nonlinear model was too complex to fit on the movies directly — **the constraint that forces honest generalisation testing is often computational rather than methodological**, which means it disappears as fitting gets cheaper.

**(brainstorm) This is a benchmark design the wiki does not have.** Every architecture page here reports a score on data drawn from the distribution its parameters were selected on, with model complexity uncontrolled. The freeze protocol is cheap to run on any system: fit on the simple regime, freeze, test on the complex regime, and give the ablated baseline equal test-time freedom. It is a *within-system* out-of-distribution test that needs no new benchmark and no ground-truth structure, which makes it strictly cheaper than most instruments in [[wiki/concepts/certification-instruments.md]] — and unlike them, it certifies the *description*, not the system.

---

## The two epistemologies, and why the disagreement is real

| | **Constrain simple, test natural** | **Discover and constrain natural** |
|---|---|---|
| Claim | Neural models are so nonlinear that fitting them to complex stimuli is hopeless; get the mechanism from controlled input, then check generality | In a nonlinear system, responses to a reduced stimulus set do not determine responses to combinations of them, so a model that never saw natural input has no warrant to generalise to it |
| Precedent offered | Hodgkin & Huxley characterised the action potential under voltage clamp, not under naturalistic synaptic current — and the elegant equations would not have come out of the latter ([[wiki/entities/hodgkin-huxley-model.md]]) | Neurons past V1 are likely specialised for scene analysis that simple stimuli cannot probe at all; gratings may become useful only *after* natural stimuli have sketched the mechanism |
| Where it is strongest | Early stages, where the nonlinearity is a small number of named mechanisms with normative reasons to exist | Later stages, where no standard model exists and the hypothesis space is the thing being searched |
| Its characteristic failure | Fitting a description that is a property of the laboratory stimulus | Fitting a flexible model to a rich stimulus and being unable to say which mechanism did the work |

The review does not settle it. **The settled part is the test**: whichever way the model was obtained, it is scored by cross-class prediction at rung 3.

---

## The finding that makes the disagreement unavoidable: a fitted description is a property of a *pair*

David et al. 2004 estimated a separate spatiotemporal receptive field for the same V1 neurons under three stimulus classes — white-statistics gratings, natural images with white temporal statistics, and full natural-vision movies:

| Result | Consequence |
|---|---|
| A receptive field estimated within one class predicts responses **within that class better than across classes** | The receptive field is not a parameter of the neuron; it is a parameter of (neuron, input distribution) |
| **Temporal** statistics have a large effect — as input becomes less white, temporal responses become bimodal and short-term adaptation increases | The dominant residual in the V1 model was a *temporal* nonlinearity, which a linear temporal filter cannot express |
| **Spatial** statistics have a subtle and *asymmetric* effect: excitatory tuning is stable across classes, inhibitory tuning changes structure | The stable part of a fitted description and the unstable part are not the same components — and it is the suppressive machinery that moves |
| Natural images drive cat V1 cells with **higher contrast-response gain** than random stimuli matched in the same analysis (Felsen et al. 2005) | Even the recovered filters being similar does not mean the recovered model is |

**(brainstorm) The asymmetry is the reusable finding.** If excitatory selectivity is a property of the unit and suppressive/normalizing structure is a property of the unit-under-a-distribution, then interpretability results split into two classes with different shelf lives: "what makes this unit fire" transfers across probe distributions, "what makes it stop firing" does not. Every wiki instrument that characterises a unit by its *preferred* input is on the stable side; every claim about a unit's inhibitory or contextual surround is licensed only for the distribution it was probed under. Nobody in the wiki reports which side of that line their result falls on. Directly testable: re-run any probe under two input distributions and score the excitatory and suppressive components of the fit separately.

---

## The five biases, generalised

Olshausen & Field's audit of V1 (see [[wiki/entities/early-visual-system.md]] for the biological numbers) is a checklist for **any** claim that a component of a complex system has been characterised. Each maps onto current practice in mechanistic interpretability, and the mapping is close enough to be uncomfortable.

| Bias | Original form | Machine-interpretability form |
|---|---|---|
| **Biased unit sampling** | Microelectrode search finds high-firing cells; ~60% of V1 may never have been recorded | Features are found by looking at units/directions that activate strongly on the probe corpus. Dead, low-rate, and polysemantic-but-weak units are systematically under-reported, and sparse-autoencoder dictionaries inherit the corpus's activation statistics |
| **Biased stimuli** | Gratings and white noise are optimal for characterising linear systems and cannot determine a nonlinear one | Probing with in-distribution text/images cannot determine behaviour on the distributions the deployment cares about. The neuroscience answer — build a *parametric generative model of the natural stimulus distribution* and sample from it (Heeger & Bergen 1995), or use adaptive stimulus search — has no interpretability analogue in this wiki |
| **Biased theories** | Publication rewards showing a theory fits, not showing it fails; the simple/complex dichotomy may be a lens artefact | Circuit stories are reported when they close. A named feature is a category imposed by the analysis, and the failure case is identical: "V1 detects edges" survived decades despite no simple- or complex-cell filter ever recovering an object outline in computer vision |
| **Interdependence / context** | ~60–80% of a layer-4 V1 cell's response variance comes from other V1 cells and non-thalamic input; the surround-configuration space explodes combinatorially | Single-unit and single-head explanations in a residual stream face the same accounting. The neuroscience conclusion is the sharp one: *describing one unit will require including the simultaneously recorded others* — i.e. the single-unit description is the wrong object, not merely an incomplete one |
| **Ecological deviance** | Models fitted on laboratory stimuli deviate under natural viewing, and deviate **qualitatively** — missing events entirely rather than mis-scaling them | An explanation validated on curated prompts and failing on deployment traffic. The qualitative/quantitative distinction is the diagnostic: a gain error is a missing term, a missing event is a missing mechanism |

---

## The depth gradient

The one quantitative regularity across the whole cascade, and the reason this page exists rather than being a paragraph on the entity page:

```
retina  ~81% of variance (within stimulus class)
LGN     linear + 2 gain controls → captures the gist across stimulus classes
V1      ~40% of explainable variance
V4      ~10% of explainable variance
IT+     no commonly accepted model to score
```

**Adequacy falls with hierarchical depth, and the *failure mode changes type* as it falls.** In LGN the linear model predicts nearly every response event and gets the amplitudes wrong — a scalar error, and gain control corrects it. In V1 under time-varying natural input the model misses events entirely and hallucinates others; the review's judgement is that this "will require more than tweaking." The distinction is worth stating as a diagnostic in its own right:

> **A residual that is a monotone function of the prediction is a missing term. A residual that is uncorrelated with the prediction is a missing mechanism.** Only the first is fixable by adding a pointwise nonlinearity or a gain stage.

**(brainstorm) The gradient predicts where mechanistic description stops being the right ambition.** It is not that later stages are harder in the same way; it is that the *unit of description* fails. The stated reason V1 resists is that most of its variance is contributed by the simultaneously active population, which is a claim that the single-neuron receptive field is the wrong object above LGN — exactly the move [[wiki/concepts/population-geometry.md]] makes for a different reason. If that is right, the analogous claim for artificial networks is that per-unit or per-head feature descriptions have a depth below which they are adequate and above which no amount of refinement will close the gap, and the empirical signature of crossing it is the residual switching from correlated to uncorrelated with the prediction. Nobody has measured that crossing in a transformer, and the measurement is cheap: fit the best available per-component description at each layer, and plot residual-prediction correlation against depth. The two readings of the gradient are [[wiki/empirical-tensions.md]] T277, and the missing controller the LGN half of it implies is gap `G94`.

---

## Open problems

- **No agreed timescale.** Some models predict individual spikes, most predict rates in ~10 ms bins, and the review names this as one of three obstacles to comparing models at all. A model can be adequate at one timescale and not another, and the choice is rarely stated.
- **The noise ceiling is itself estimated**, from a finite number of stimulus repeats. Rung 3 buys attributability at the price of a second estimation problem.
- **Adequacy has no compositional theory.** Retinal and LGN models are adequate-ish; the V1 model that consumes their output is not; and nobody has built a V1 model that includes the *known* dynamical nonlinearities (synaptic depression, surround suppression, adaptation, realistic spiking) and tested that composite on movies. Until that is run, "V1 is poorly understood" and "the standard model has never been assembled" are not distinguishable.
- **Cross-class freezing has no analogue for a learned system whose parameters are the object of study.** The protocol assumes the model's parameters are the modeller's; when the system under description is itself trained, "fit on class A" and "the system was trained on class A" are confounded.

---

## Connections

- **[[wiki/entities/early-visual-system.md]]** — the worked case: every number on this page comes from that cascade, and its stage-by-stage scorecard is what makes the depth gradient a measurement rather than an intuition.
- **[[wiki/concepts/certification-instruments.md]]** — the sibling question. Those instruments ask whether a system found the intended structure and mostly need a declared ground truth; the freeze protocol here asks whether a *description* of a system is right, needs no ground truth at all, and is the cheapest out-of-distribution test in the wiki because it reuses data the experiment already has.
- **[[wiki/concepts/representation-probing.md]]** — inherits the five biases directly, and gains a testable split from David et al. 2004: a probe result for what *drives* a unit is stable across probe distributions while a result about its suppressive/contextual structure is not, so probe findings should be reported with the distribution they were measured under.
- **[[wiki/concepts/shortcut-learning.md]]** — the same failure at the level of the system rather than the description: a receptive field fitted under one stimulus class that predicts only within that class is the modeller's version of a rule that fits the training distribution and nothing else.
- **[[wiki/concepts/human-baseline.md]]** — the same structural move as rung 3: making the ceiling an experimentally estimated quantity so the residual becomes attributable rather than being charged to the model by default.
- **[[wiki/concepts/population-geometry.md]]** — the constructive response to the depth gradient's terminal case: when a single unit's response is mostly a function of the simultaneously active population, the population state is the object that can be described, and single-unit adequacy is not a target that further refinement reaches.
- **[[wiki/concepts/node-definition-problem.md]]** — the "biased theories" row instantiated: the simple/complex cell dichotomy may be a category produced by the receptive-field mapping procedure (which subtracts dark from bright responses to force a single-valued field) rather than a fact about the tissue.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — sets the price of every row of that page's track record: an imported mechanism carries only as much warrant as the predictive adequacy of the model it was extracted from, and for the convolutional row that is ~40% of explainable variance.
- **[[wiki/entities/hodgkin-huxley-model.md]]** — the precedent cited for the constrain-simple-test-natural position: characterisation under voltage clamp produced equations that naturalistic current injection would not have, which is the strongest available argument that reduced stimuli are a method and not a bias.
- **[[wiki/entities/ventral-visual-stream.md]]** — the depth gradient's terminal case, and the response it provoked: where no encoding model exists, DiCarlo et al. 2012 concede the per-unit target outright (recovering an inferior-temporal neuron's image→rate function may be "practically impossible with current methods") and substitute a *decoding* criterion that rises across the same stages this page's score falls across.
- **[[wiki/concepts/manifold-untangling.md]]** — the alternative adequacy claim in general form: fix the reader's complexity, hold out *transformation* conditions rather than samples, and score whether the format improved — a criterion that needs no noise ceiling, no encoding model and no ground truth, and that applies exactly where this page's ladder runs out.
