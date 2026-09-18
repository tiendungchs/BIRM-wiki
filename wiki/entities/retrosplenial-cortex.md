# Retrosplenial Cortex — the Region That Converts Between Frames, Named at Last

**Brodmann areas 29 and 30, immediately behind the splenium of the corpus callosum: a cortex reciprocally wired to the hippocampal formation, the anterior thalamic nuclei and the parietal/visual cortices, which carries head-direction but *no* place cells, and whose lesion costs little while one spatial mode suffices and a great deal the moment two modes conflict. What the region *does* is contested at the level of whether it does one thing at all. One review assigns it a single operation — it **translates between viewpoint-dependent (egocentric, parietal) and viewpoint-independent (allocentric, medial-temporal) frames**, using head direction to cancel the rotational offset, possibly buffering the representations while the translation runs. A second, over a decade of additional recording, finds that no isolated function fits and offers two non-exclusive generalisations instead: **shifting and relating perspectives** (of which egocentric↔allocentric is one special case) and **prediction plus error correction** of sensory state against internal representations, both riding on conjunctive tuning across sensory, motor and spatial streams. `T383`.**

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

**Its theta is its own — contested.** Vann et al. report a locally generated theta, only *partially* septal-dependent and independent of hippocampal theta, with hippocampal 8–12 Hz rhythmical slow activity partly mediated by retrosplenial cortex and/or the underlying cingulum ([[wiki/concepts/inter-areal-synchrony.md]]). Alexander et al. 2023 report the opposite relation on the field potential — retrosplenial theta is **largely coherent with CA1 pyramidal-layer theta**, like entorhinal layer III — while agreeing that retrosplenial *spiking* is not rhythmic. The two claims are reconcilable only if "independent" is read as "not a follower in its generation" and "coherent" as "phase-locked once both exist"; the wiki carries both and treats neither as settled (see the temporal-coupling table below).

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

## The 2023 re-reading: the same region, and no isolated function fits

> **Second provenance.** Alexander, Place, Starrett, Chrastil & Nitz 2023, *Rethinking retrosplenial cortex: perspectives and predictions*, Neuron 111(2):150–175 (`raw/alexander-2023-rethinking-retrosplenial-cortex.md`). A second review, fourteen years after Vann et al., over the decade of rodent electrophysiology (egocentric boundary vector cells, route coding, theta/sharp-wave-ripple coordination) and human fMRI that did not exist for the first. Its verdict is the opposite in form: retrosplenial anatomy and dynamics "are more consistent with roles in multiple sensorimotor and cognitive processes than with any isolated function". Two *generalized, explicitly non-exclusive* categories are offered instead — (1) shifting and relating perspectives, and (2) prediction and error correction of current sensory state against internal representations — both riding on the same substrate, conjunctive tuning across sensory, motor and spatial streams. `T383`.

### The connectivity fork the region's own literature cannot decide — `G122`

The review's Figure 2 states the question the wiki has never asked of any hub it carries. A region with ~15 afferent sources and ~11 efferent targets can be wired along two independent continua:

| Continuum | One extreme | Other extreme |
|---|---|---|
| **Afferent targeting** | *Mixed*: every source's terminals distribute evenly over retrosplenial neurons, so every cell sees every stream ([[wiki/concepts/population-geometry.md]]'s mixed selectivity) | *Discrete*: each source is biased toward a particular **projection-defined** sub-population, so the region is several semi-independent circuits sharing one cortical volume |
| **Intrinsic (`RSC`→`RSC`) density** | Dense — the sub-populations are re-mixed locally even if the afferents were segregated | Sparse — segregation survives, and the "hub" never integrates anything |

**It is undetermined, and the measurement that would settle it is named**: quantify, for each projection class (e.g. retrosplenial→anterior thalamus vs retrosplenial→secondary motor cortex), the input density from each afferent source *including other retrosplenial neurons*. The human version has not even been attempted — the review notes that breaking the region into subregions and measuring their mutual functional connectivity "has not been tested to the best of our knowledge", while the observed anterior↔posterior connectivity gradient (posterior/lateral → occipital and visual networks; anterior/medial → posterior cingulate, medial prefrontal, default network) makes large-scale overlap unlikely.

Under either extreme the region still has a *common* signal; what changes is what the common signal is for. Mixed: one broadcast variable (head direction, self-motion, location) modulates every circuit. Discrete: the shared object is a population conjunctively tuned to many variables, read differently by each output class.

### A third reference frame, and it is topological rather than metric

Beyond egocentric and allocentric the review argues for a **route-centered** frame — position along a trajectory of a given shape, first found in posterior parietal cortex and now here:

| Property | Posterior parietal cortex | Retrosplenial cortex |
|---|---|---|
| Codes progress through a route | Yes | Yes ("path-equivalent" coding) |
| Invariant to where the route sits in allocentric space | **Yes**, largely | **Split** — some cells invariant, some drastically modulated by the route's environmental position |
| Independent of the specific egocentric action | Yes | Yes |
| Ensemble readout | Reconstructs position within the route | Reconstructs position within the route |

The split row is the point: retrosplenial route cells are the only population in the wiki that carries a route-relative coordinate **and** its allocentric embedding in the same ensemble, which is what a converter between the two would have to hold.

**And the route code looks like a graph, not a metric.** On routes with recurrent structure, retrosplenial route cells show **periodic** spatial fields mapping onto both local and global topological features of the route space, and the distribution of periodicities **shifts between mazes of different geometry** — the code re-fits itself to the new topology. Posterior parietal route coding likewise rescales when route components change scale. In non-spatial domains, retrosplenial cortex codes structure within **social networks**. This is the wiki's first candidate biological carrier of a *topological* rather than metric map ([[wiki/concepts/latent-graph-discovery.md]], [[wiki/concepts/nonspatial-maps.md]]) — though the authors are explicit that neither the rescaling test nor a human route-coding test has been run.

### The case against localised translation

Four findings the translation account has to absorb, listed by how much they cost it:

| Finding | Cost |
|---|---|
| **Retrosplenial inactivation has little effect on boundary-anchored responses in medial entorhinal cortex** — the direct prediction of the model | Highest. The downstream consequence the model exists to produce is not observed |
| Conjunctive egocentric–allocentric cells (gain-field-like) are found in **many** structures besides this one | The transformation is *distributed*; conjunctive coding here is not diagnostic of a localised converter ([[wiki/concepts/distributed-reference-frames.md]]) |
| Human deficits after parietal/posterior-cingulate/retrosplenial damage are inconsistent across cases in whether map use or viewpoint use survives in isolation, and in recent vs remote spatial memory | The lesion evidence does not isolate the conversion |
| "Transformation" has no agreed operational definition — is binding-and-recall of co-occurring egocentric and allocentric signals a transformation, or does the term require a continuous active computation? | **The hypothesis is ill-posed, so falsification attempts cannot be decisive.** An `L0-INSTR`-shaped problem sitting under an `L2` claim |

The review's own replacement for "translator" is **perspective taking in general**: mentally rotating one's viewpoint to an avatar's or an arrow's position activates this region, and that is a shift between two *egocentric* viewpoints, with no allocentric term. The generalisation admits egocentric→egocentric, allocentric→allocentric, and intermediate (oblique) viewpoints, and extends past space into retrospection, prospection, counterfactual thought and social cognition — the same widening [[wiki/entities/default-mode-network.md]] performs, reached here from the frame side.

### The predictive-coding proposal

The second offered function. The claim is directional: retrosplenial cortex is a **top-down predictor** over sensory cortex, not a passive integrator.

| Evidence | Detail |
|---|---|
| Learning changes the direction of influence | Mouse primary visual cortex neurons reflect stimulus properties before learning and become **more strongly driven by top-down retrosplenial modulation after** it |
| An ordinal code independent of content | Multi-voxel human retrosplenial patterns classify an item's **position in a list** independent of item identity — an index, not a content code ([[wiki/concepts/hippocampal-indexing-theory.md]]) |
| Order assignment is lesion-sensitive at the timescale that needs a sequence | Retrosplenial-lesioned rats cannot assign relative temporal positions to objects *within* a continuous sequence, yet can still discriminate presentation order between blocks separated by 30-min intervals — recency across a gap survives, order within an episode does not |
| Stable plans over actions | Two-photon imaging decodes long sequences of left/right movement combinations from stable retrosplenial ensembles, and the active ensemble **re-orders** when the environment changes |
| Sequence-leading spikes | Subsets of subicular and retrosplenial neurons (including egocentric boundary vector cells) spike at **early** CA1 theta phases, ahead of the rest of the theta sequence — the position in the cycle a source of top-down constraint would have to occupy, not the position a recipient would |
| Mismatch is where the deficit lives | Lesion effects appear when distal cues are disabled or misaligned against learned local structure — a failure to use bottom-up prediction error to update a sensory prediction |

Under this reading the region's job is to emit a prediction of the *full situational context* — sensory, motor and spatial conjunction — and to be corrected by feedforward residuals from sensory areas, which makes perspective taking the *content* and prediction the *mechanism* (the authors' own formulation, offered alongside the alternative that perspective taking is itself a kind of prediction).

### Temporal coupling to the hippocampus, and what it denies

| Measure | Value |
|---|---|
| Retrosplenial local-field theta | Prominent during mobility, **coherent with CA1 pyramidal-layer theta** (like entorhinal layer III) |
| Retrosplenial cells firing rhythmically across continuous theta cycles | **~5%** |
| Cells *modulated* relative to CA1 theta phase | ~35% dysgranular, ~65% granular |
| Gamma within theta | Retrosplenial low→high gamma transitions at theta peaks, shadowing CA1, but **phase-shifted** relative to matching CA1 frequencies |
| Sharp-wave ripples | Retrosplenial high-frequency oscillations and rates often coherent with hippocampal ripples, but individual cells show a **range of excitation and inhibition** at ripple onset |

**The first two rows together are an architectural statement**: the region is entrained by a rhythm it does not itself reproduce in its spiking. A shared clock is imposed on the field potential while individual units stay non-rhythmic, so theta here is a **timing channel without a content code** — `G54`'s distinction, measured. The phase shift and the early-phase leading cells then make the coupling *directional*: an ensemble that fires at the start of a cycle can bias which memory or perspective the rest of the cycle retrieves.

### And the consolidation direction is reversed

Vann et al. report retrograde amnesia for **recent** more than remote autobiographical events and greater retrosplenial engagement at recent retrieval. This review reports the opposite gradient: emergent retrosplenial activity at retrieval of **stable, remote** episodic memories; distinct primate retrosplenial activation for object–scene pairs retrieved a year after encoding versus newly learned ones; preferential activation for familiar scenes; post-training muscimol in anterior retrosplenial cortex impairing memory 24 h later. Its framing is multiple-trace systems consolidation with this region as the cortical trace. `T384`.


---

## The architectural reading

**(brainstorm) This is `G39`'s anchoring operator with the per-instance parameter's *source* named.** `G39` assembled the shape of anchoring — a small per-instance transform against a large reusable code, an `argmax` over a symmetry group — and repeatedly found that the group has to be installed. Here the group is installed (rotation in the plane), a population enumerates its elements (head-direction cells), and the crucial addition is that **the parameter is not inferred inside the transform module**. It is computed by a *separate* integrator (anterior thalamic/postsubicular head-direction system), delivered as an input, and merely *applied* here. That is a design: factor the converter from the estimator of what to convert by. A machine analogue costs one module that outputs a group element and one that applies it — and it predicts the observed failure mode, since damaging the applier leaves both representations intact and breaks only the change of perspective.

**(brainstorm) The lesion profile is the empirical signature `G43` has been asking for.** `G43` asks how concurrent reference frames are arbitrated and finds the biological case weak because abstract-task frames come out *registered* to one angle. This region's deficit profile is the missing positive: near-normal performance while one frame suffices, and a large, robust deficit exactly when two frames are placed in **conflict** (intra- vs extra-maze cues) or must be **switched** (light → dark, local → distal). An arbitration module is invisible until its inputs disagree, which is why every single-frame task under-estimates it. Design consequence for the wiki's evaluation inventory: **a frame-arbitration mechanism can only be measured by a cue-conflict design**, and no benchmark in the wiki contains one.

**(brainstorm) A buffer inside a coordinate transform means the transform is not a matrix multiply.** If the conversion were feedforward — one rotation applied to a vector — there would be nothing to hold. The review's buffer suggestion implies an iterative settle, which is what a gain-field / attractor implementation of the transform would require and what a single linear map would not ([[wiki/concepts/attractor-dynamics.md]]). This is a testable architectural fork that the wiki can carry forward into any module it builds for `G39`.

**Parallel redundancy makes ablation a weak instrument — quantitatively.** The retrosplenial deficit is smaller than the hippocampal or anterior thalamic one *because* the three structures are directly interconnected as well as indirectly. The wiki's lesion-derived module assignments generally inherit this: in a densely recurrent triad, effect size measures **how much of the traffic the ablated edge carried**, not how important the computation is. This is the causal-manipulation counterpart of [[wiki/concepts/function-to-structure-inference.md]]'s correlational bound.

**The unique contribution is sensory, and that reframes what the region is for.** The one property retrosplenial cortex has that neither the hippocampus nor the anterior thalamus has is *earlier-processed sensory input*. Read with the `Rdg` result — lesions there let the anterodorsal head-direction signal drift — the region's job is where the **path-integrated estimate meets the visual evidence that corrects it** ([[wiki/concepts/path-integration.md]]). That is the same two-input structure as the fly's ring-attractor plus landmark reset ([[wiki/entities/fly-central-complex.md]]), one cortical level up and with a whole scene rather than a bar as the landmark.

**And the region is the wiki's second case of a system named for a function its own data cannot identify.** "It is hard to find a navigation or topographical memory task in which the retrosplenial cortex is not activated"; it is also activated by speech, motivation and pain. The review's closing paragraph is a list of alternatives the evidence does not discriminate — translation, its own stored environmental representations, scene processing, scene construction — and its own title is a question. Same shape as [[wiki/entities/default-mode-network.md]], and the same diagnosis: ubiquity of activation is an *obstacle* to function attribution, not evidence for a general function.

**(brainstorm) `G122`: the wiki builds hubs and has never specified their internal wiring.** Every multi-input module the wiki carries — a workspace, a relational bottleneck, a router, this region — is drawn as one box with `n` inputs and `m` outputs, which silently commits to the *mixed* extreme: every unit sees every stream, every output class reads the same population. The Figure 2 fork says the opposite arrangement is equally available and empirically undecided: afferents biased toward projection-defined sub-populations, with sparse local recurrence, so the box is `k` semi-independent circuits sharing a volume and integrating nothing. The two are not a realization detail. They differ in what is **architecturally denied**: under `discrete`, the retrosplenial→secondary-motor circuit cannot read the thalamic head-direction stream at all, and any capability requiring that conjunction is impossible rather than merely untrained. `G122`.

**(brainstorm) The route code is the first biological candidate for a map that is a graph.** A population whose fields are *periodic in route topology* and whose periodicity distribution **changes when the maze geometry changes** is not storing a metric embedding — it is storing recurrence structure, re-fitted per environment. [[wiki/concepts/latent-graph-discovery.md]] has asked throughout for a code over graph structure rather than over coordinates, and `G47` asks what learns a manifold's topology; this is a measured population that appears to do it, in a region with no place cells to embed anything in. The missing tests are named by the authors (rescaling routes; a human route-coding paradigm), so the wiki carries it as a candidate, not a result.

**A prediction that failed is worth more here than the ten that succeeded.** The translation model's one downstream prediction — silence this region and boundary-anchored responses in medial entorhinal cortex should degrade — has been tested and is essentially null, while the supporting evidence (conjunctive cells, connectivity, lesion deficits) is all *compatibility* evidence. This is the wiki's cleanest instance of the asymmetry [[wiki/concepts/function-to-structure-inference.md]] formalises: a hypothesis can accumulate arbitrary amounts of consistency and still fail its one entailment, because consistency with a hub's data is nearly free.

**The definitional failure is the deeper one, and it generalises to every module the wiki names.** The authors' own diagnosis is that "transformation" has no operational definition, so the hypothesis is ill-posed and falsification attempts cannot be decisive. The wiki assigns operations to modules constantly — *anchor*, *arbitrate*, *gate*, *bind*, *broadcast*, *consolidate* — and almost none of those verbs has a stated neural-code criterion for having been performed. **The transferable discipline: a module's job description must come with the measurement that distinguishes performing it from merely co-representing its arguments.** Binding-and-recall of two co-occurring codes is not a transformation unless something says why not.

**Two reviews, same region, opposite verdicts on whether a function exists — and the second had more data.** Vann et al. 2009 converge on one operation; Alexander et al. 2023, with a decade of additional recording, conclude that no isolated function fits. The wiki's default assumption that more evidence narrows a functional attribution is contradicted here: the additional evidence *broadened* it, because each new recording added another variable the region turned out to encode. If that is the generic trajectory for association cortex ([[wiki/concepts/hierarchy-of-associativity.md]]), then module-level function labels in a brain-inspired architecture should be treated as **provisional compressions of a tuning inventory**, not as design intent recovered from biology.

---

## Limitations

- **The translation model is untested.** The authors say so explicitly: it is not known whether retrosplenial damage specifically disrupts translation between hippocampal and parietal codes, nor — if it does — whether the cause is degraded egocentric and allocentric representations or a selective failure of the perspective-change process itself. The alternative that the region stores its **own** environmental representations is not excluded.
- **Human selective lesions are rare**, frequently bilateral without being detected as such, and confounded with damage to neighbouring posterior cingulate areas, the fornix and the hippocampus. Laterality of the verbal/visual deficits is inconsistent across cases.
- **fMRI localisation is unreliable at this boundary.** Meta-analyses pool retrosplenial with other posterior cingulate activations; activation in areas 23/31, the parieto-occipital sulcus and anterior calcarine has been misattributed here.
- **Rodent and primate parcellations do not correspond** — the rat has no area 23 or 31 — so "retrosplenial cortex" names a different cortical volume in each half of the evidence base.
- **The rodent lesion effects are modest and method-sensitive**, with cingulum damage, lesion rostro-caudal extent and training schedule each able to flip an outcome.
- **The subregional story rests on two studies**, neither of which dissociated `Rdg` from `Rga`/`Rgb` on the same task.
- **Nothing here is non-spatial in the sense the wiki needs.** Every reference frame in the evidence is a physical one; the review offers no landmark, boundary or heading analogue outside space — the same residue `G39` carries.
- **The 2023 review's two proposed functions are declared non-exclusive and are not dissociated from each other**, nor from the alternatives it lists (binding hippocampal output to sensory context; comparator; associator). It offers no experiment that separates "perspective taking" from "prediction" — the authors even suggest each may be a special case of the other.
- **The route-centered frame has never been tested in humans**, the topological rescaling prediction has never been run in this region, and the periodic-field result rests on one rodent study.
- **The mixed-vs-discrete connectivity question (`G122`) is open in every species**, and the human sub-region mutual-connectivity measurement that would bear on it has not been attempted.
- **The two reviews disagree on the theta relation and on the consolidation gradient** (`T384`), and neither disagreement has been adjudicated by a study designed to do so.

---

## Connections

- **[[wiki/concepts/cognitive-map.md]]** — supplies the substrate that page's anchoring element (`G39`) names and never describes: a region with head-direction but no place cells, whose damage leaves landmark *recognition* intact and destroys landmark-to-heading conversion, which is exactly the orientation half of that page's retrieval/orientation split.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the named candidate for that page's Prediction 4, a universal egocentric→allocentric conversion: Vann et al. localise the conversion to one region driven by an externally supplied rotation parameter, while Alexander et al. 2023 report gain-field-like conjunctive egocentric–allocentric cells in *many* structures and a null effect of retrosplenial inactivation on entorhinal boundary coding — which returns the conversion to that page's distributed reading (`T383`).
- **[[wiki/concepts/path-integration.md]]** — the correction stage for the integrator: retrosplenial lesions impair ideothetic path integration, and dysgranular lesions let the anterodorsal head-direction signal drift, so this is where visual evidence re-pins an accumulating estimate.
- **[[wiki/entities/entorhinal-cortex.md]]** — the other end of the posterior fan-in that defines the medial entorhinal division: retrosplenial axons terminate almost exclusively in medial entorhinal layer V, so the directional/frame-conversion signal arrives at the hippocampal interface's *output* layer rather than its input layer.
- **[[wiki/entities/default-mode-network.md]]** — splits that page's "PCC/Rsp" hub: hippocampal and anterior thalamic connection densities are much higher to areas 29/30 than to area 23, and the two dissociate within one fMRI study (23/31 track real-vs-imagined, retrosplenial tracks self-involvement), so the hub is at least two nodes.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the causal-manipulation counterpart of that page's correlational bound: in a triad with direct *and* indirect edges, lesion effect size measures how much traffic the cut edge carried, and this region's small deficits coexist with its being required.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the candidate cortical store for consolidated maps, with a temporal signature the two reviews sign oppositely: Vann et al. report retrosplenial damage sparing *remote* autobiographical memory while impairing recent, and greater engagement at recent retrieval; Alexander et al. 2023 report emergent activity at *remote* retrieval and a post-training muscimol effect, i.e. the standard cortical-trace gradient (`T384`).
- **[[wiki/concepts/hippocampal-long-axis.md]]** — fixes this region's position on that gradient: retrosplenial cortex reaches the hippocampus only through dorsolateral entorhinal cortex and therefore only *dorsal* hippocampal levels, the opposite end from the prefrontal loop.
- **[[wiki/entities/fly-central-complex.md]]** — the same two-input architecture two levels of complexity apart: a self-motion-integrated heading estimate plus a sensory landmark signal that resets it, implemented there as a ring attractor with a single visual bar and here as a cortex receiving V2/V4/parietal input alongside thalamic head direction.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — a locally generated theta only partially dependent on septal input and independent of hippocampal theta, while hippocampal 8–12 Hz activity is partly mediated by this region — a second cortical oscillator in the memory system rather than a follower of the hippocampal one.
- **[[wiki/concepts/node-definition-problem.md]]** — the boundary is load-bearing and species-dependent: areas 29/30 versus 23/31 differ by an order of magnitude in hippocampal and thalamic connection density, the rat has no 23/31 at all, and fMRI routinely mislabels adjacent tissue as retrosplenial.
- **[[wiki/entities/anterior-thalamic-nuclei.md]]** — the source of this region's dominant thalamic input, and the reason a retrosplenial deficit may not be retrosplenial: anterior thalamic lesions leave this cortex persistently hypoactive with de-regulated gene transcription, while `AV` excitation and CA1 inhibition oppose each other in layer 1 with both necessary for contextual fear conditioning — making this the worked-out case of the tripartite model's two-stream convergence zone.

- **[[wiki/entities/posterior-cingulate-cortex.md]]** — the other side of this page's boundary claim: where this page establishes that areas 23/31 are not retrosplenial, that page establishes that 23/31 are themselves *two* regions (dorsal = executive, ventral = mnemonic), both of which may be primate-only since rodents lack the layer IV stellate count that defines them — so the rodent lesion literature here speaks to no part of posterior cingulate cortex except this one, and this region is conversely the leg of the tripartite division its own authors call weakest, with human demarcation varying widely and surface reconstruction pipelines liable to excise it outright.

- **[[wiki/concepts/latent-graph-discovery.md]]** — the first measured population that may carry a *topological* rather than metric map: route cells with periodic fields matched to local and global recurrence structure of the route space, whose periodicity distribution re-fits when the maze geometry changes (Alexander et al. 2023).
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the second of the 2023 review's two proposed functions, with this region as a top-down predictor over sensory cortex: primary visual neurons become more strongly driven by retrosplenial modulation *after* learning, and the lesion deficit appears exactly when a learned prediction is violated by misaligned distal cues.
- **[[wiki/concepts/hippocampal-indexing-theory.md]]** — a content-free ordinal index measured in cortex rather than hippocampus: multi-voxel retrosplenial patterns classify an item's position in a list independently of the item's identity.
- **[[wiki/concepts/hierarchy-of-associativity.md]]** — the association-cortex trajectory in one worked case: a decade of additional recording *broadened* rather than narrowed the functional attribution, because each new variable the region encodes is another function it could be said to serve.
- **[[wiki/concepts/population-geometry.md]]** — the fork `G122` opens under that page's mixed-selectivity assumption: this region's afferents may spread evenly over its neurons (one mixed population) or be biased toward projection-defined sub-populations with sparse local recurrence (several semi-independent circuits sharing a volume), and the measurement that would decide it — input density per afferent source per projection class — has not been made in any species.
- **[[wiki/entities/subiculum.md]]** — names the origin population of the hippocampal input this page treats as one wire: the *distal*/dorsal subicular class, which is also where speed-coding cells concentrate, so what arrives here is one projection-typed output stream of the store rather than the store's output (Kinman et al. 2026) — and the same page measures both of `G122`'s continua in a neighbouring structure, finding neither extreme.
