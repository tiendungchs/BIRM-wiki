# Retrosplenial Cortex — the Region That Converts Between Frames, Named at Last

**Brodmann areas 29 and 30, immediately behind the splenium of the corpus callosum: a cortex reciprocally wired to the hippocampal formation, the anterior thalamic nuclei and the parietal/visual cortices, which carries head-direction but *no* place cells, whose lesion costs little while one spatial mode suffices and a great deal the moment two modes conflict, and whose leading functional account is that it **translates between viewpoint-dependent (egocentric, parietal) and viewpoint-independent (allocentric, medial-temporal) frames** using head direction to cancel the rotational offset — possibly buffering the representations while the translation runs.**

> **Provenance.** Vann, Aggleton & Maguire 2009, *What does the retrosplenial cortex do?*, Nat. Rev. Neurosci. 10(11):792–802 (`raw/vann-2009-what-does-the-retrosplenial-cortex-do.md`). A review across neuroanatomy (monkey and rat tract tracing), rodent lesion/inactivation/electrophysiology, human neuropsychology and fMRI. The translation model it endorses is Burgess and colleagues'; the scene-construction framing is Hassabis & Maguire's.

Why this earns a page. The wiki has cited "retrosplenial" on 20 pages — as the candidate cortical store for schematized maps ([[wiki/concepts/cognitive-map.md]]), as the carrier of the local↔global heading transform (`G43`), as the anchoring substrate (`G39`), as a default-network hub ([[wiki/entities/default-mode-network.md]]), as the posterior end of the entorhinal fan-in ([[wiki/entities/entorhinal-cortex.md]]) — and has never held a page on it. Every one of those citations was second-hand.

---

## Where it is, and why the boundary matters

| Level | Region | Lamination |
|---|---|---|
| — | Induseum griseum | least |
| ↓ | Area 26 (absent in monkey) | ↓ |
| ↓ | Lateral area 29 | 4 layers |
| ↓ | Medial area 29 (granular) | 4–5 layers |
| ↓ | Area 30 (dysgranular) | 6 layers, poorly defined layer IV |
| — | Area 23 | 6 distinct layers |

- **Retrosplenial cortex = areas 29 + 30 only.** Areas 23 and 31 are posterior cingulate but *not* retrosplenial; area 23 physically separates retrosplenial from precuneate cortex. Hippocampal and anterior thalamic connection densities to 29/30 are **much higher** than to area 23 — so the boundary is a connectivity boundary, not a cartographic convention.
- In the primate the region is buried deep in the midline, hidden from the medial surface: magnetoencephalography and transcranial magnetic stimulation cannot reach it, and fMRI reports routinely misattribute activation in areas 23/31, the parieto-occipital sulcus and anterior calcarine to it.
- **The rat has no areas 23 or 31**, so the whole rodent posterior cingulate region *is* retrosplenial cortex, subdivided (Van Groen & Wyss) into dysgranular `Rdg` (area 30), granular `Rga` and `Rgb` (area 29). It extends over half the length of the rat cerebrum — one of that species' largest cortical regions.
- Connectional properties are conserved across mammals; the *parcellation* is not. Any rodent→primate transfer of a retrosplenial result inherits this mismatch ([[wiki/concepts/node-definition-problem.md]]).

---

## The wiring

| Partner | Monkey | Rat |
|---|---|---|
| Hippocampal formation | Reciprocal: subiculum, presubiculum, parasubiculum | Reciprocal: subiculum, presubiculum, **postsubiculum** |
| Parahippocampal | Reciprocal: entorhinal cortex, areas TH/TF | Postrhinal |
| Limbic thalamus | Reciprocal: anterior + laterodorsal nuclei | **Dominant** input: anterior + laterodorsal nuclei |
| Prefrontal | Reciprocal with areas 46, 9, 10, 11 | Reciprocal with anterior cingulate |
| Sensory | Direct V2, V4, claustrum, lateroposterior thalamus, parietal area 7; area 7a/7b/LIP/DP → area 23 → retrosplenial | `Rdg` ↔ visual areas 17, 18b |
| Neuromodulatory | — | Raphe, locus coeruleus, diagonal band |
| Tract | Cingulum bundle carries the cortico-cortical and cortico-thalamic pathways | Same — and it is the confound in every aspiration/electrolytic lesion |

**Subregional split by partner.** Granular `Rga`/`Rgb` are reciprocally connected with the sites that *contain head-direction cells* (laterodorsal and anterodorsal thalamus, postsubiculum); dysgranular `Rdg` is connected with visual cortex. The division is between the directional signal and the visual evidence that pins it.

**The region is a parallel edge, not a bottleneck.** In both rodent and monkey, retrosplenial cortex provides a reciprocal *indirect* route between the hippocampal formation and the anterior thalamic nuclei — which are also densely connected **directly**. Disconnection confirms the three-way dependency: a unilateral retrosplenial lesion plus a contralateral hippocampal *or* contralateral anterior thalamic lesion impairs fixed-platform water-maze learning, so all three are required together.

**What it has that neither endpoint has** — the authors' own method for isolating a unique contribution, and the answer is input-side:

1. Reciprocal connections with dorsolateral prefrontal areas 46 and 9 — an indirect hippocampus ↔ executive-cortex route.
2. A **different cholinergic source**: basal nucleus of Meynert (retrosplenial) vs medial septum/vertical diagonal band (hippocampus) vs laterodorsal tegmental nucleus (anterior thalamus). Three neuromodulatory channels over one functional triad.
3. **More early-processed sensory information than either the hippocampus or the anterior thalamic nuclei.** Retrosplenial cortex is where a visual scene and a heading estimate are close enough to be compared.

---

## What it codes

| Cell type | Present? | Detail |
|---|---|---|
| Head-direction | **Yes**, ~10% of cells | Equally distributed across granular and dysgranular; in granular only, tuning is modulated by locomotion velocity |
| Place | **No** — never detected | — |
| Grid | Not reported | — |
| Conjunctive | Yes | Some cells fire to particular combinations of location, direction *and* movement |
| Reward | Yes | Differential responses to reward type; many cells fire **exclusively during the physical response** to obtain reward, not during the conditioned stimulus |

**Direction without position.** The structure carries heading and route-relative conjunctions and does not carry a place code. Against the [[wiki/concepts/cognitive-map.md]] split of map-based navigation into *context retrieval* ("which map?") and *orientation* ("where and facing where on it?"), this is the cleanest anatomical statement of the split the wiki has: the hippocampus holds positions, retrosplenial cortex holds the orientation that makes them readable.

**It does not generate the head-direction signal, it stabilises it.** Retrosplenial cortex is not required for head-direction generation, but caudal `Rdg` lesions make anterodorsal thalamic head-direction cells' preferred firing direction **unstable and prone to drift** — consistent with `Rdg` supplying the visual evidence that re-pins the integrator. The same relation runs into the hippocampus: temporary retrosplenial inactivation transiently changes hippocampal place-cell spatial tuning while leaving other electrophysiological properties intact.

**Its theta is its own.** Locally generated, only *partially* septal-dependent, and independent of hippocampal theta — though hippocampal 8–12 Hz rhythmical slow activity is partly mediated by retrosplenial cortex and/or the underlying cingulum ([[wiki/concepts/inter-areal-synchrony.md]]).

---

## The lesion signature: a switch, not a store

| Impaired | Spared |
|---|---|
| Water maze, fixed *and* daily-changing platform | Novel **object** detection |
| Radial-arm maze working memory (light and dark) | Visuospatial conditional tasks (also spared after mammillary body and fornix lesions) |
| Directional tasks (alternate position around a fixed direction) | Head-direction signal generation |
| Path integration from ideothetic cues | |
| Object-**in-place** novelty detection | |
| Compound-feature negative discrimination; contextual fear conditioning; two-way active avoidance; rabbit acoustic avoidance | |

Three methodological facts that decide whether a retrosplenial lesion study means anything: **caudal** tissue is the part that matters (rostral-only lesions produced the early null results); aspiration and electrolytic methods sever the cingulum and disconnect the whole cingulate cortex; and the amount of pre- and post-surgical training changes the outcome.

**The load-bearing finding.** The deficit magnitude is *smaller* than for hippocampal or anterior thalamic damage — the parallel interconnections compensate — and **the full impact emerges only when the animal must shift or integrate modes of spatial learning**: light → dark, local → distal cues, and most robustly when intra-maze cues are placed *in conflict* with extra-maze cues. Rats with retrosplenial lesions cannot switch or integrate parallel modes of task performance.

**Subregional dissociations, both single-sided.** `Rgb` (not `Rga`) lesions disrupt delayed matching to position in a water maze; selective `Rdg` lesions impair use of visual allocentric cues in the radial-arm maze. The two subregions have never been dissociated on the same task in the same study.

---

## Human evidence

| Source | Finding |
|---|---|
| Lesion | Difficulty acquiring new verbal or visual information; retrograde amnesia for **recent** more than remote autobiographical events (extent varies 1–10 years across cases) |
| Lesion | Selective **topographical disorientation**: patients recognise neighbourhood landmarks but cannot derive *directional* information from them. Hippocampal patients are also impaired at navigation but can usually orient in familiar environments and may have a preserved sense of direction — a double contrast of landmark identity against landmark-to-heading conversion |
| Lesion | Unilateral deficits can resolve over months, with recovery supported by the *remaining* retrosplenial tissue |
| fMRI | Near-ubiquitous in navigation and episodic/autobiographical memory — "often the brightest blob on the brain activation maps"; also reported for speech production and comprehension, motivation and pain |
| fMRI | Activity is **phasic, not tonic**: during virtual navigation of central London it rises specifically when topographical representations must be updated, integrated or manipulated for route planning, or when new topographical information is acquired (Spiers & Maguire) |
| fMRI | Engaged by three-dimensional geometric structure in scenes, and *not* by the contextual-association account (Henderson et al., against Bar) |
| fMRI | Dissociates from areas 23/31 *in the same study*: 23/31 are more active for real than imagined events across all categories; ventral parieto-occipital sulcus extending into retrosplenial cortex is activated specifically by real **and** imagined events that involve the participant **personally** |

The last row is the strongest functional argument for the translation account: what separates autobiographical events from remembered movies and news clips is that the participant must maintain and update a **first-person perspective** against a changing spatial context, which is precisely the operation the translation model assigns to this region.

---

## The translation model

The proposal the review endorses (Burgess and colleagues, extended to episodic and autobiographical memory):

```
allocentric (hippocampal / medial temporal)  ⇄  egocentric (posterior parietal)
                         ↑
        rotational offset θ, supplied by anterior thalamic head-direction cells
        (θ = allocentric heading subtracted from allocentric landmark direction)
```

- The hippocampus **indexes the location** embodied in a memory, scene or imagined event, in an allocentric frame ("a landmark 10 m north").
- Retrosplenial cortex **translates** it into egocentric directions so it can be viewed from, and acted on from, a specific viewpoint ("10 m ahead" if facing north, "10 m to the left" if facing east).
- The translation may run in a **short-term buffer** held by the region while the conversion completes.

This makes scene construction, autobiographical recall, imagining the future and navigation one operation run at different settings of *whose viewpoint* and *which tense* — the same collapse [[wiki/entities/default-mode-network.md]] performs over its ten function hypotheses, reached here from the anatomy rather than from the task inventory.

---

## The architectural reading

**(brainstorm) This is `G39`'s anchoring operator with the per-instance parameter's *source* named.** `G39` assembled the shape of anchoring — a small per-instance transform against a large reusable code, an `argmax` over a symmetry group — and repeatedly found that the group has to be installed. Here the group is installed (rotation in the plane), a population enumerates its elements (head-direction cells), and the crucial addition is that **the parameter is not inferred inside the transform module**. It is computed by a *separate* integrator (anterior thalamic/postsubicular head-direction system), delivered as an input, and merely *applied* here. That is a design: factor the converter from the estimator of what to convert by. A machine analogue costs one module that outputs a group element and one that applies it — and it predicts the observed failure mode, since damaging the applier leaves both representations intact and breaks only the change of perspective.

**(brainstorm) The lesion profile is the empirical signature `G43` has been asking for.** `G43` asks how concurrent reference frames are arbitrated and finds the biological case weak because abstract-task frames come out *registered* to one angle. This region's deficit profile is the missing positive: near-normal performance while one frame suffices, and a large, robust deficit exactly when two frames are placed in **conflict** (intra- vs extra-maze cues) or must be **switched** (light → dark, local → distal). An arbitration module is invisible until its inputs disagree, which is why every single-frame task under-estimates it. Design consequence for the wiki's evaluation inventory: **a frame-arbitration mechanism can only be measured by a cue-conflict design**, and no benchmark in the wiki contains one.

**(brainstorm) A buffer inside a coordinate transform means the transform is not a matrix multiply.** If the conversion were feedforward — one rotation applied to a vector — there would be nothing to hold. The review's buffer suggestion implies an iterative settle, which is what a gain-field / attractor implementation of the transform would require and what a single linear map would not ([[wiki/concepts/attractor-dynamics.md]]). This is a testable architectural fork that the wiki can carry forward into any module it builds for `G39`.

**Parallel redundancy makes ablation a weak instrument — quantitatively.** The retrosplenial deficit is smaller than the hippocampal or anterior thalamic one *because* the three structures are directly interconnected as well as indirectly. The wiki's lesion-derived module assignments generally inherit this: in a densely recurrent triad, effect size measures **how much of the traffic the ablated edge carried**, not how important the computation is. This is the causal-manipulation counterpart of [[wiki/concepts/function-to-structure-inference.md]]'s correlational bound.

**The unique contribution is sensory, and that reframes what the region is for.** The one property retrosplenial cortex has that neither the hippocampus nor the anterior thalamus has is *earlier-processed sensory input*. Read with the `Rdg` result — lesions there let the anterodorsal head-direction signal drift — the region's job is where the **path-integrated estimate meets the visual evidence that corrects it** ([[wiki/concepts/path-integration.md]]). That is the same two-input structure as the fly's ring-attractor plus landmark reset ([[wiki/entities/fly-central-complex.md]]), one cortical level up and with a whole scene rather than a bar as the landmark.

**And the region is the wiki's second case of a system named for a function its own data cannot identify.** "It is hard to find a navigation or topographical memory task in which the retrosplenial cortex is not activated"; it is also activated by speech, motivation and pain. The review's closing paragraph is a list of alternatives the evidence does not discriminate — translation, its own stored environmental representations, scene processing, scene construction — and its own title is a question. Same shape as [[wiki/entities/default-mode-network.md]], and the same diagnosis: ubiquity of activation is an *obstacle* to function attribution, not evidence for a general function.

---

## Limitations

- **The translation model is untested.** The authors say so explicitly: it is not known whether retrosplenial damage specifically disrupts translation between hippocampal and parietal codes, nor — if it does — whether the cause is degraded egocentric and allocentric representations or a selective failure of the perspective-change process itself. The alternative that the region stores its **own** environmental representations is not excluded.
- **Human selective lesions are rare**, frequently bilateral without being detected as such, and confounded with damage to neighbouring posterior cingulate areas, the fornix and the hippocampus. Laterality of the verbal/visual deficits is inconsistent across cases.
- **fMRI localisation is unreliable at this boundary.** Meta-analyses pool retrosplenial with other posterior cingulate activations; activation in areas 23/31, the parieto-occipital sulcus and anterior calcarine has been misattributed here.
- **Rodent and primate parcellations do not correspond** — the rat has no area 23 or 31 — so "retrosplenial cortex" names a different cortical volume in each half of the evidence base.
- **The rodent lesion effects are modest and method-sensitive**, with cingulum damage, lesion rostro-caudal extent and training schedule each able to flip an outcome.
- **The subregional story rests on two studies**, neither of which dissociated `Rdg` from `Rga`/`Rgb` on the same task.
- **Nothing here is non-spatial in the sense the wiki needs.** Every reference frame in the evidence is a physical one; the review offers no landmark, boundary or heading analogue outside space — the same residue `G39` carries.

---

## Connections

- **[[wiki/concepts/cognitive-map.md]]** — supplies the substrate that page's anchoring element (`G39`) names and never describes: a region with head-direction but no place cells, whose damage leaves landmark *recognition* intact and destroys landmark-to-heading conversion, which is exactly the orientation half of that page's retrieval/orientation split.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the named candidate for that page's Prediction 4, a universal egocentric→allocentric conversion: here the conversion is localised to one region, driven by an externally supplied rotation parameter, rather than replicated across every sensory cortex.
- **[[wiki/concepts/path-integration.md]]** — the correction stage for the integrator: retrosplenial lesions impair ideothetic path integration, and dysgranular lesions let the anterodorsal head-direction signal drift, so this is where visual evidence re-pins an accumulating estimate.
- **[[wiki/entities/entorhinal-cortex.md]]** — the other end of the posterior fan-in that defines the medial entorhinal division: retrosplenial axons terminate almost exclusively in medial entorhinal layer V, so the directional/frame-conversion signal arrives at the hippocampal interface's *output* layer rather than its input layer.
- **[[wiki/entities/default-mode-network.md]]** — splits that page's "PCC/Rsp" hub: hippocampal and anterior thalamic connection densities are much higher to areas 29/30 than to area 23, and the two dissociate within one fMRI study (23/31 track real-vs-imagined, retrosplenial tracks self-involvement), so the hub is at least two nodes.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the causal-manipulation counterpart of that page's correlational bound: in a triad with direct *and* indirect edges, lesion effect size measures how much traffic the cut edge carried, and this region's small deficits coexist with its being required.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the candidate cortical store for consolidated maps, with a temporal signature: retrosplenial damage disproportionately spares *remote* autobiographical memory while impairing recent, and fMRI shows greater retrosplenial engagement for recent than remote retrieval.
- **[[wiki/concepts/hippocampal-long-axis.md]]** — fixes this region's position on that gradient: retrosplenial cortex reaches the hippocampus only through dorsolateral entorhinal cortex and therefore only *dorsal* hippocampal levels, the opposite end from the prefrontal loop.
- **[[wiki/entities/fly-central-complex.md]]** — the same two-input architecture two levels of complexity apart: a self-motion-integrated heading estimate plus a sensory landmark signal that resets it, implemented there as a ring attractor with a single visual bar and here as a cortex receiving V2/V4/parietal input alongside thalamic head direction.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — a locally generated theta only partially dependent on septal input and independent of hippocampal theta, while hippocampal 8–12 Hz activity is partly mediated by this region — a second cortical oscillator in the memory system rather than a follower of the hippocampal one.
- **[[wiki/concepts/node-definition-problem.md]]** — the boundary is load-bearing and species-dependent: areas 29/30 versus 23/31 differ by an order of magnitude in hippocampal and thalamic connection density, the rat has no 23/31 at all, and fMRI routinely mislabels adjacent tissue as retrosplenial.
- **[[wiki/entities/anterior-thalamic-nuclei.md]]** — the source of this region's dominant thalamic input, and the reason a retrosplenial deficit may not be retrosplenial: anterior thalamic lesions leave this cortex persistently hypoactive with de-regulated gene transcription, while `AV` excitation and CA1 inhibition oppose each other in layer 1 with both necessary for contextual fear conditioning — making this the worked-out case of the tripartite model's two-stream convergence zone.
