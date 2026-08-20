# Priority Map

**Selection for action is a map over space whose value at each location is the *similarity* between the stimulus there and a held template — and the similarity and the argmax are computed by different populations, in different areas, in that order.**

> **Provenance.** Bichot, Heard, DeGennaro & Desimone 2015, *A source for feature-based attention in the prefrontal cortex*, Neuron 88(4):832–844 (`raw/bichot-2015-feature-based-attention-pfc.md`). Four macaques, free-viewing visual search over eight natural objects; simultaneous multi-contact recording in ventral prearcuate cortex (VPA), the ventral bank of the principal sulcus (VPS), frontal eye field (FEF) and inferior temporal cortex (IT), plus muscimol inactivation of VPA and of VPS with simultaneous FEF recording.

The wiki already has the *state* of the spotlight (persistent, anticipatory, prefrontal; [[wiki/concepts/attention.md]]) and the *format* of the control signal that sets it (sustained activity broadcast as bias; [[wiki/concepts/cognitive-control.md]]). Missing was the intermediate object both of them presuppose: the thing that converts "I am looking for `x`" into "act on location `ℓ`". A priority map is that object, and this source is a causal decomposition of it.

---

## The task, and why it separates the two factors

Cue one of eight natural objects at fixation (1000 ms) → delay (800 ms) → array of eight items containing one instance of the target → free gaze until 800 ms fixation on the target. Interleaved *detection* trials present the target alone, mapping receptive fields and object selectivity.

Feature and spatial selection are pulled apart within the same trials by conditioning on the saccade:

| Contrast | What varies | What it isolates |
|---|---|---|
| Target in receptive field, saccade *outside* it vs. distractor in receptive field, saccade outside it | Whether the item in the receptive field matches the template | **Feature selection**, with spatial attention held outside the receptive field |
| Target in receptive field, saccade *to* it vs. target in receptive field, saccade outside it | Whether this location is the one about to be acted on | **Spatial selection**, with the receptive field content held fixed |

Behaviour: target found on >95% of trials after 2.9 ± 0.2 saccades at 203.8 ± 3.8 ms latency — significantly better than serial or random inspection of eight items (`t` = 6.75 and 160.37, `P` < 10⁻⁸), so the template is genuinely guiding the scan.

---

## Four areas, two signals, and they do not co-localise

| | VPA (ventral prearcuate) | FEF (frontal eye field) | IT (inferior temporal) | VPS (ventral principal sulcus) |
|---|---|---|---|---|
| Object-selective units | 35% | **0%** | 48% | 27% |
| Extrafoveal receptive fields (of selective units) | 104/154 | (all, by construction) | 61/121 | 64/108 |
| Receptive-field size | small (≈ FEF) | small | large | largest |
| Template held through delay | **yes** | n/a (no object selectivity) | cue only | delay only |
| Template held *across saccades*, to targets and distractors | **yes** | n/a | no (target trials only) | **no** (VPA vs. VPS, `t` = 4.83–6.14, `P` < 10⁻⁵) |
| Feature-selection magnitude (100–200 ms post-array) | **+21.8%** | +8.1% | +4.2% n.s. | +1.1% n.s. |
| Feature-selection onset (population) | **90 ms** | 100 ms (n.s. vs. VPA, `P` = 0.62) | 189 ms (later than both, `P` = 0.015 / 0.024) | no measurable onset |
| Feature-selection onset (per unit, cumulative) | **earliest** — leads FEF by 20 ms at the 10th percentile, 58 ms at the 35th (`t` = 2.45, `P` = 0.016) | second | latest | latest |
| Spatial-selection onset (population) | 138 ms | **105 ms** (n.s., `P` = 0.35) | none | 140 ms |
| Spatial selection (per unit, AUROC) | second | **largest** (`F` = 33.56, `P` < 10⁻¹⁸; leads VPA by 16 ms at the 10th percentile, 39 ms at the 35th) | smallest | second |

Two orderings, opposite in direction, measured in the same trials: **feature-match first in VPA, spatial choice first in FEF**. Combined with the earlier finding that feature selection in FEF precedes V4 (Zhou & Desimone 2011), the match is not computed in sensory cortex at all — the areas with feature *selectivity* (IT, V4) show feature *selection* last.

---

## The causal test: the two factors dissociate under inactivation

Muscimol into central VPA (six sessions, two monkeys), with 42 FEF units recorded before and after:

| Measure in FEF | Pre | Post | Verdict |
|---|---|---|---|
| Feature selection (AUROC, 100–200 ms) | 0.633 | **0.508** (`t` = 13.27, `P` < 10⁻²¹; post-effect `t` = 0.64, `P` = 0.53) | **abolished — at chance** |
| Spatial selection (AUROC) | 0.717 | 0.698 (`t` = 1.25, `P` = 0.21) | intact |
| Detection-trial responses (target alone) | — | unchanged (`F` = 0.06, `P` = 0.80) | intact |

Behaviour degrades only in the contralateral hemifield and on the midline: more saccades, longer search, more misses, and a changed pattern of *which* distractors are fixated (Fisher-`z` correlation of pre/post distractor-fixation patterns 0.65 contralateral vs. 0.82 ipsilateral, `t` = 8.11, `P` < 10⁻³) — the monkey still searches, it just stops preferring items that match the cue. Saccades to a target presented alone are unimpaired, so this is not a motor or spatial deficit (unlike FEF inactivation). A within-session control rules out fatigue: feature selection in FEF is equal in the first and second halves of non-injection sessions (`t` = 0.30, `P` = 0.77).

**This is the sharpest controller-lesion datum in the wiki, and it does not look like graded bias.** Removing the source did not weaken the downstream feature signal, it deleted it (0.633 → 0.508 = chance) while leaving the same cells' spatial signal untouched. A downstream area running its own competition that VPA merely tilts should retain a residual; FEF retains none, because it has no object selectivity of its own to compete with ([[wiki/empirical-tensions.md]] T112).

---

## The same lesion, measured one stage further down: V4 (2019)

> **Provenance.** Bichot, Xu, Ghadooshahy, Williams & Desimone 2019, *The role of prefrontal cortex in the control of feature attention in area V4*, Nature Communications 10:5727 (`raw/bichot-2019-prefrontal-feature-attention-v4.md`). Two macaques (one shared with the 2015 study), free-viewing search over 20 colour×shape conjunction stimuli; V4 recording during 14 control and 12 unilateral VPA-muscimol sessions (135 vs 127 units).

The 2015 experiment silenced VPA and recorded FEF — an area with **no** feature selectivity of its own. The 2019 experiment repeats the manipulation and records V4, an area that *is* feature-selective. Same task family, same dissociation-by-saccade logic (measure the receptive-field stimulus while the saccade goes elsewhere), one stage further down.

| Measure in V4 | Control | VPA inactivated (same hemisphere) |
|---|---|---|
| Feature selection, array onset → 1st saccade | present from ~130 ms (`t` = 8.9 / 8.8, `P` < 10⁻¹¹) | **eliminated**, both monkeys (`P` = 0.10 / 0.98; interaction `F` = 24.2 / 32.1, `P` < 10⁻⁵ / 10⁻⁷) |
| Feature selection, subsequent fixations | `t` = 10.8 / 8.6, `P` < 10⁻¹² | eliminated (monkey J, `P` = 0.36); **reduced but surviving** (monkey F, `t` = 3.4, `P` = 0.001) |
| Feature contrast ratio (median, 1st / subsequent) | F 0.063 / 0.068 · J 0.030 / 0.030 | F 0.027 / 0.022 · J 0.007 / 0.010 (all `P` < 10⁻³); differs from zero **only** for monkey F, subsequent saccades |
| Spatial selection (saccade to RF vs away) | `P` < 10⁻⁶ … 10⁻²⁷ | **intact**, all four interactions n.s. (`P` = 0.12–0.32); contrast ratios 0.047–0.109 unchanged |
| Detection-trial response (target alone in RF) | — | unchanged (monkey F's late-window drop survives a responsiveness-matched subsample with feature selection still abolished, `F` = 24.8, `P` < 10⁻⁵) |
| Behaviour | 4.8 / 4.7 saccades to target (vs 10.5 expected serial) | contralateral hemifield only: more saccades, longer search, more errors; **detection saccades unimpaired** (`P` = 0.92 / 0.81) |

Three things this adds that the FEF experiment could not.

- **The elimination is not an artefact of the recorded area lacking the variable.** T112's proposed discriminating test — *does the downstream area independently represent the biased dimension?* — is run here, and the answer is mostly "still eliminated": V4 is colour- and shape-selective and still loses feature selection almost entirely. The residual predicted by biased competition appears in exactly one monkey, in one time window, at a third of its control size. Supplementary analysis further reports the loss is **independent of each V4 unit's own tuning** for the colours and shapes used — so local selectivity does not buy local competition. Bias-over-a-competent-substrate survives only as a small correction term.
- **Feature and spatial gain in sensory cortex are separately addressable.** The same V4 cells, in the same sessions, keep full spatial modulation while losing feature modulation. Whatever V4's attentional gain is, it is not one scalar: at least two independent write-ports exist onto the same units, and only one of them runs through VPA.
- **Feature-match enhancement is graded and asymmetric.** Enhancement for a *distractor* sharing only the target colour is modest but real, and is also abolished by inactivation; enhancement for a distractor sharing only the target **shape** is never significant in V4 — even though behaviourally the monkeys fixate same-shape distractors far above chance (`t` = 21.9 / 11.2, `P` < 10⁻⁹ / 10⁻⁷). Guidance by shape exists in the eye movements without a matching V4 signal ([[wiki/empirical-tensions.md]] T114).

**Route unresolved, deliberately.** VPA's projection to V4 is not established; the authors leave two candidates open — indirect via IT/TEO feedback (which would explain why feature attention is expressed globally, given large IT receptive fields), or via the FEF/LIP priority maps, whose feedback is retinotopic. Their own discriminating test: a **spatially addressed** route cannot produce feature attention in transparent or overlapping-dot displays, where target and distractor features occupy the same locations. That experiment has not been run.

**(brainstorm)** The two-write-port result is the cleanest architectural licence in this page for splitting an attention layer's gain into a *content-addressed* term and a *location-addressed* term with separate controllers, rather than one blended score. Under that split, the 2015 caution stands — apparent feature-tuned modulation in a sensory layer can be produced entirely by the location-addressed port — but the 2019 data say the content-addressed port must still exist somewhere upstream, because killing one controller removes feature gain while leaving location gain at full strength.

---

## Two routes to a template, and only one of them is maintained

Repeating the cue for blocks of 20 trials changes what the inactivation costs:

| Design | VPA inactivation | VPS inactivation |
|---|---|---|
| Random (cue changes per trial) | Behavioural deficit; FEF feature selection abolished (0.633 → 0.508) | Behavioural deficit |
| Blocked (cue repeated) | Deficit **reduced but present**; FEF feature selection reduced, still significant (0.672 → 0.559, `t` = 12.22, `P` < 10⁻¹⁸) | **No deficit at all** |

Read as an architecture: VPS is needed to *load and switch* the template, VPA to *hold and apply* it. When the same query recurs, the loading stage becomes dispensable and the matching stage becomes cheaper but not free — i.e. a repeated query is partly absorbed into slower structure (weights, priming, or a settled attractor) and partly still executed by the maintained-activity route. This is the two-timescale split of [[wiki/concepts/complementary-learning-systems.md]] appearing inside the *control* layer rather than inside memory, and it is a directly testable prediction for any architecture that caches queries.

---

## What the mechanism has to be

The template in VPA is *persistent object-selective firing*: VPA cells fire more throughout the whole trial when their preferred object is the cue — through the delay, through the array response, and across intervening saccades, on fixations landing on distractors as well as on the target. That is a register whose content is the query, still valid after an action that changed the entire retinal input.

Given that register, the map falls out of one operation:

```
priority(ℓ) = sim( template , stimulus(ℓ) )        # computed in VPA, ~90 ms, per receptive field
action       = argmax_ℓ  priority(ℓ) (+ spatial bias, history, value)   # computed in FEF, ~105 ms
```

with the caveat that VPA units also carry spatial selection late (138 ms) — the argmax is fed *back* into the map, so the two stages are a loop, not a feedforward pipeline. VPA additionally shows feature enhancement for its *non*-preferred object when that is the target (weaker, later), so the similarity is computed against the current template rather than being a fixed tuning gain — which is what makes it a `sim(·,·)` and not a bias vector.

**Consequence the source draws explicitly:** feature-attention effects in extrastriate cortex may be *downstream* of this loop rather than its source — FEF feedback is retinotopic, so enhancing "locations containing target-like stimuli" produces V4/IT modulation that looks like feature-based gain but is addressed by location. The wiki's earlier reading of feature-similarity gain in sensory cortex as a top-down *feature*-space bias is not what this experiment supports. The 2019 follow-up sharpens rather than settles this: V4 feature gain and V4 spatial gain fall to *different* controllers, so at least one of them is not delivered by the retinotopic route.

---

## Reading in the core framing

| Element | Latent-graph reading |
|---|---|
| Template register (VPA) | The **query** of a content-addressable read, pinned across steps and across actions that change the input ([[wiki/concepts/attention.md]]) |
| `sim(template, stimulus(ℓ))` | The dot-product scores of one attention head, computed once per candidate node |
| Priority map (FEF) | The **normalised** score vector — the softmax denominator's job — over spatially addressed candidates |
| argmax → saccade | Edge traversal: the selected node becomes the next observation, so the *next* query is conditioned on this choice |
| Feature/spatial dissociation | Score computation and score arbitration are separable modules with separate failure modes |

**(brainstorm) Softmax attention fuses exactly the two stages this experiment separates.** `softmax(qKᵀ)V` computes similarity and arbitration in one expression, in one place, from a query recomputed every step. The biology splits them across areas with a 15 ms lag, keeps the query in a register that survives an action, and lets the arbitration feed back into the scoring. Three importable consequences: (i) a persistent query register makes "what am I looking for" ablatable independently of "where am I going", which no transformer layer permits; (ii) a scoring stage that can be lesioned while arbitration survives predicts the *specific* failure seen here — search continues, guidance does not, i.e. the model degrades to random inspection rather than to no action; (iii) because arbitration is retinotopic and feedback is addressed by location, an architecture can get apparent feature-selectivity in its sensory layers without any feature-addressed pathway existing — a caution for interpretability work that reads feature-tuned modulation as evidence of a feature-space control signal.

**(brainstorm)** The blocked-cue result gives a cheap benchmark axis missing from every attention evaluation here: hold the task fixed and vary only *query volatility*. A cached-query architecture and a maintained-query architecture score identically on blocked trials and diverge on interleaved ones — the same manipulation that dissociates VPS from VPA.

---

## Open problems

- **Where does the template come from?** VPA holds and applies it; VPS is implicated in loading/switching it (blocked-design result) but that is an inference from a null, not a positive measurement. Nothing here identifies the pathway that writes a cue into the register — the same missing write-policy as gap G33's configurator.
- **Is the similarity computed on features or on learned object identity?** The source cannot say: multi-unit recording, eight over-trained objects. Component-feature tuning and learned target-identity tuning predict the same data, and they differ exactly on generalisation to a *novel* target — the case abstract reasoning cares about.
- **Is a residual real?** Only one monkey retained any V4 feature modulation after inactivation, and only after the first saccade. Two animals cannot distinguish partial muscimol coverage (the injections did not cover all of VPA) from a genuine locally-generated remainder — the number that decides T112 is currently a single `P` = 0.001.
- **One map or several?** LIP and superior colliculus carry priority maps too; only FEF was recorded. Whether the argmax is taken once over a shared map or separately in each is untested, and it is the difference between one arbitration module and a voting ensemble.
- **Does VPA feed sensory cortex directly?** Still open after the 2019 V4 experiment, which shows VPA is *necessary* for feature attention in V4 without identifying the pathway: IT/TEO feedback and FEF/LIP retinotopic feedback both predict the result. The discriminating experiment is a display where target and distractor features share a location (transparent surfaces, overlapping dot fields), which a spatially addressed route cannot handle (Bichot et al. 2019).
- **Anatomy is descriptive.** "VPA" is a location (likely areas 45A/12, possibly 46v), not a functionally-bounded area; the authors decline to claim it is one. Proposed human homologue: the inferior frontal junction (Baldauf & Desimone 2014).

---

## Connections

- **[[wiki/concepts/attention.md]]** — supplies the object that page's spotlight controller was missing a mechanism for, and splits it: the query is held as persistent object-selective firing in ventral prearcuate cortex, the similarity is computed there (~90 ms), and the arbitration over locations happens 15 ms later in the frontal eye field — so the two halves fused inside `softmax(qKᵀ)V` are separable modules with a causal double dissociation, and the same lesion in V4 shows the split reaches sensory cortex: feature gain and location gain onto one population arrive through different controllers (Bichot et al. 2015, 2019).
- **[[wiki/concepts/cognitive-control.md]]** — a controller-lesion datum its bias account has to absorb: silencing the source *eliminates* downstream feature selection (AUROC 0.633 → 0.508, chance) rather than reducing it, while spatial selection in the same cells is untouched — biased competition predicts a residual where the target area has its own selectivity, and the 2019 test in V4, which does have colour and shape tuning, returns only a one-monkey one-window remainder ([[wiki/empirical-tensions.md]] T112).
- **[[wiki/concepts/working-memory.md]]** — the delay-period content here is *used* rather than reported: the same persistent object code that a delayed-match task would read out as the remembered item is what the search computation takes as its query, and it survives saccades that overwrite the entire retinal input — an update-invariant register, not a decaying trace.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the fast/slow split appearing inside the control layer: repeating the cue removes the need for the switching stage entirely (VPS inactivation costs nothing under a blocked design) and part of the need for the matching stage, so a recurring query is progressively absorbed into slower structure.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the complementary half of selection at the same station: this page's map enhances matching locations, that page's beta-addressed suppression removes items that stopped mattering; here suppression is implicit (unselected locations simply lose the argmax) and nothing addresses a location for removal.
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — the same frontal machinery under a different contingency: there a cue specifies *which action*, here a cue specifies *what to find* and the action is chosen by the map — so a template is a cue→predicate mapping rather than a cue→response mapping, and it composes with an arbitrary number of locations.
- **[[wiki/concepts/control-unity-and-diversity.md]]** — an anatomical instance of its shifting-specific factor: the region whose loss matters only when the target changes trial-to-trial (VPS) is separable from the one whose loss matters whether or not it changes (VPA), which is switching cost isolated from maintenance by a lesion rather than by factor analysis.
- **[[wiki/concepts/population-geometry.md]]** — what is missing here and would settle the mechanism: multi-unit recording cannot say whether object identity and location are conjunctive in single cells or superposed across the population, and only the second permits `sim(·,·)` to be read off a linear projection.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the acting-to-observe loop in its cheapest form: the argmax over the priority map determines the next fixation, hence the next observation, hence the next query — evidence about the scene is gathered by a policy the scene's own contents wrote.
- **[[wiki/concepts/shortcut-learning.md]]** — the deficit's shape is a shortcut in reverse: with the matching stage silenced, behaviour does not collapse but degrades to inspecting distractors in an unchanged serial fashion, i.e. the fallback policy is intact and content-blind — a reminder that a system can look functional while the only task-relevant computation has been removed.
