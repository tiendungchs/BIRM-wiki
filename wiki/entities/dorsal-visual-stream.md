# The Dorsal Visual Stream — One Name Over Three Pathways, and the Route by Which Vision Reaches the Map

**The occipito-parietal cascade (V1 → V6 → V6A/MIP (Medial IntraParietal area)/VIP (Ventral IntraParietal area)/LIP (Lateral IntraParietal area)/MT (Middle Temporal area)/MST (Medial Superior Temporal area) → inferior parietal lobule) does not terminate in parietal cortex. Beyond it the stream **trifurcates** into three anatomically separate pathways with three different targets and three different jobs: parieto-prefrontal (spatial working memory and eye movements), parieto-premotor (visually guided action), and parieto-medial-temporal (navigation) — the last running from the caudal inferior parietal lobule to the hippocampal formation both directly *and* through a serial relay in posterior cingulate then retrosplenial cortex. "Where" and "How" are each one third of the stream, and the third third is the wire the wiki's entire map literature depends on and had never drawn: the path by which a visual scene reaches an allocentric store.**

> **Provenance.** Kravitz, Saleem, Baker & Mishkin 2011, *A new neural framework for visuospatial processing*, Nat. Rev. Neurosci. 12:217–230 (`raw/kravitz-2011-new-neural-framework-for-visuospatial-processing.md`). A review, mostly macaque tract tracing plus macaque and human single units, fMRI and lesion cases, with human resting-state functional connectivity (Margulies et al.) as the cross-species check. Written by the lab that proposed the original two-stream framework, revising it.

**Why this earns a page.** The wiki holds [[wiki/entities/ventral-visual-stream.md]] — the `what` cascade with a stated success criterion — and has never held the other stream. Every spatial page here (`[[wiki/concepts/cognitive-map.md]]`, `[[wiki/concepts/path-integration.md]]`, [[wiki/entities/retrosplenial-cortex.md]], [[wiki/entities/subiculum.md]]) assumes visual input arrives at the map and says nothing about how. This source names the wire, stages it, and dissociates the stages by human lesion.

---

## The source circuit, before it splits

| Stage | Content |
|---|---|
| V1 (central **and peripheral** field) → V6 | V6 = part of parieto-occipital area PO, retinotopic, in the anterior wall of the parieto-occipital sulcus; also fed by V2, V3, V3A |
| V6 → medial branch | V6A, MIP, VIP — all **bimodal** (visual + somatosensory) |
| V6 → lateral branch | LIP, MT, MST |
| V1 → V2/V3/V4 → MT | The second, central-field-weighted route into MT |
| Lateral interconnection | V6A, MIP, VIP, LIP, MT, MST are strongly interconnected with each other *and* with both inferior-parietal subdivisions (caudal `cIPL`, rostral `rIPL`) |

**The circuit's representational commitment.** It integrates central and peripheral visual field roughly equally (unlike the ventral stream's foveal bias) and re-represents retinotopic input in **egocentric** frames defined on body parts — eye-, head-, hand- and arm-centred maps, plus optic flow and stimulus depth. Human egocentric hemispatial neglect follows inferior-parietal damage; *allocentric* (object-relative) neglect follows ventral/medial-temporal damage instead. So the split between the two frames is already a split between two lobes before any pathway is named.

---

## The trifurcation

| Pathway | Parietal source | Target | Target lamination | Function |
|---|---|---|---|---|
| **Parieto-prefrontal** | LIP, VIP, MT, MST | Prefrontal area 8A (pre-arcuate) and area 46 (principal sulcus) | **Granular** (6-layer, layer IV present) | Top-down control of eye movements; spatial working memory |
| **Parieto-premotor** | V6A + MIP → dorsal premotor (F2, F7); VIP + `rIPL` (PF, PFG) → ventral premotor (F4, F5) | Premotor cortex | **Agranular** (5-layer, no layer IV) | Reaching, grasping, eye movements — visually guided action in peri-personal space |
| **Parieto-medial-temporal** | `cIPL` (areas Opt, PG) | CA1/prosubiculum, pre- and parasubiculum, parahippocampal areas TF/TH — **directly**, and **indirectly** via posterior cingulate (areas 23, 31) → retrosplenial (areas 29, 30) | Granular | Navigation; spatial long-term memory |

**The lamination column is the authors' own proposed explanatory variable and it is worth keeping.** The two "perception" pathways target granular cortex — the cortical type that everywhere else receives primary thalamocortical sensory input — while the "action" pathway targets agranular cortex of the same type as primary motor cortex. Their claim is that the conscious/non-conscious and perceptual/motoric differences among the three pathways may be **a property of the target's cortical type rather than of the pathway's content**. They flag it as unresolved.

**`cIPL` versus `rIPL` is the split that makes the third pathway possible.** Both are inferior parietal lobule; only the caudal part feeds the medial-temporal route.

| | `rIPL` (PF, PFG; area 7b) | `cIPL` (Opt, PG) |
|---|---|---|
| Somatosensory / motor neurons | Many; multimodal PFG units | **Few** |
| Responsive to observed and executed actions | Yes, component-selective | **No activation reported** in area Opt |
| Somatotopic maps, vestibular input from cerebellum | Yes | — |
| Eye position toward **extrapersonal** loci | — | Yes, preferred |
| Reference frames carried | Body-part-centred | Also **world-centred and object-centred** |
| Optic-flow speed sensitivity | — | Strong |
| Mental navigation of mazes | — | Direction coding reported |

---

## The third pathway, stage by stage

```
cIPL (Opt, PG)  ──direct──────────────────────────────────►  CA1/prosubiculum, pre-/parasubiculum, TF/TH
     │
     └──indirect──►  PCC (23, 31) ──►  RSC (29, 30) ──┬──►  pre-/parasubiculum   (head-direction cells)
                                                      └──►  TF, TH, TFO ──► CA1/prosubiculum (place cells,
                                                                            spatial view cells)
```

The two indirect terminations are not redundant — they land on **different cell types**, which the source uses to split the hippocampal contribution in two:

| Terminal | Cell population there | What the pathway therefore delivers |
|---|---|---|
| Pre- and parasubiculum | Head-direction cells, part of the anterior-thalamic/mammillary head-direction circuit | Directional information, bidirectionally: the cells can be *influenced by* descending `cIPL`/retrosplenial input and *supply* heading back to retrosplenial cortex |
| CA1 / prosubiculum (via TF/TH) | Place cells; in monkey also allocentric **spatial view** cells (fire when the animal looks at a part of the environment, regardless of distance) | Landmark-in-context, which is why place fields shift when a landmark moves relative to the boundaries |

**Stage functions, in the authors' reading:**

| Stage | Evidence |
|---|---|
| `cIPL` | World- and object-centred coding; optic-flow speed; extrapersonal eye position; maze-direction coding. Lesion → **egocentric disorientation** |
| PCC (areas 23/31) | Heavily connected with the supplementary eye field; units modulated by behaviourally relevant target onset, saccades to them, and their motivational value; **some units encode saccade target location in allocentric coordinates, preserved across whole-body rotation**; human activation during top-down attention shifts and under spatial-selection load; place-responsive units in monkey; **inactivation impairs following previously learned routes**; human activation to optic flow specifying an unambiguous heading |
| RSC (areas 29/30) | Coordinating and translating egocentric ↔ allocentric; lesion → **heading disorientation**; activation when heading is computed from optic flow and under learned heading direction; retrosplenial complex responds to landmarks, to familiar over unfamiliar scenes, to spatial over non-spatial judgments, and **extrapolates beyond the borders of a presented image**; rat retrosplenial damage degrades thalamic head-direction coding relative to landmarks |
| TFO (human: lingual gyrus) | Little known in monkey; human homologue lesion → **landmark agnosia** |
| TF/TH (human: parahippocampal place area, with TFO) | Ablation → location and object–place associative memory deficits; units weakly object-selective with wide, barely foveal receptive fields; PPA responds to scenes over objects, to spatial layout over semantic content, and **equally to a furnished room and the same room emptied** |

---

## The lesion taxonomy — four failures along one pathway

This is the source's strongest architectural content: topographic disorientation is not one syndrome, and which one a patient has predicts **where along the pathway the damage sits**.

| Lesion site | Syndrome | Spared | Lost |
|---|---|---|---|
| Posterior parietal | **Egocentric disorientation** | — | Orienting the self within real *or imagined* environments; navigating; describing routes between familiar locations. Landmark memory also impaired |
| Retrosplenial (29/30) | **Heading disorientation** | Landmark recognition; in some cases the ability to **draw detailed maps** of familiar places | Extracting directional information from a recognised landmark ("turn right at the light"); describing routes through the map the patient just drew |
| Lingual gyrus (TFO) | **Landmark agnosia** | Orienting within an environment; map production | Recognising prominent, navigationally relevant landmarks |
| Parahippocampal (TF/TH) | **Anterograde topographic disorientation** | Orienting; previously learned routes | Forming representations of *new* environments; learning new routes |

**(brainstorm) Read as a specification, this is four separable modules with four stated interfaces**: a self-pose estimator, a landmark→heading converter, a landmark recogniser, and an environment-writer. The wiki has pages for the second ([[wiki/entities/retrosplenial-cortex.md]]) and the fourth ([[wiki/concepts/cognitive-map.md]], [[wiki/entities/subiculum.md]]) and has never separated the first from the second or the third from the fourth. The map-drawing/route-describing dissociation is the sharpest single item: a patient can emit the *stored structure* and cannot emit a *traversal of it*, which says the structure and the procedure for moving through it are held apart — exactly the read/traverse split [[wiki/concepts/latent-graph-discovery.md]] assumes and never sources.

---

## The architectural reading

**(brainstorm) The wiki's map pages have been assuming a wire that exists, is four synapses long, and is not one wire.** Every page here that says "visual input anchors the map" treats the anchoring input as a single arrival. What the anatomy supplies is a *staged pipeline* with a direct shortcut running alongside it (`cIPL` → hippocampal formation directly, *and* `cIPL` → PCC → RSC → hippocampal formation), and with the two indirect terminations separated by cell type — heading cells on one branch, place cells on the other. A machine module that takes a scene and returns an anchored position is collapsing at least three stages plus a bypass, and the human lesion taxonomy above says those stages fail independently.

**(brainstorm) A direct route parallel to a relayed route is the same motif the wiki has now met three times, and it should be named.** Retrosplenial cortex is a parallel indirect edge between hippocampal formation and anterior thalamus, which are also connected directly ([[wiki/entities/retrosplenial-cortex.md]]); the anterior thalamic system is a second stream beside the direct hippocampo-cortical one ([[wiki/entities/anterior-thalamic-nuclei.md]]); here `cIPL` reaches its hippocampal targets both directly and through a two-stage limbic relay. The architectural consequence is the same each time and it is a *measurement* consequence: **ablating the relay never removes the function**, so effect size measures the relay's share of traffic, not the relay's job ([[wiki/concepts/function-to-structure-inference.md]]). It also suggests what the relay is *for* — the direct edge cannot be conditioned on anything the relay computes, so a relay earns its existence only by inserting a parameter (here: heading) that the direct edge has no access to.

**The frames are not partitioned by region, and the source says so twice.** The headline is "parietal egocentric, medial-temporal allocentric" — and then `cIPL` units are reported coding in world- and object-centred frames, and pre-/parasubicular head-direction cells are reported inside the hippocampal formation. The authors' own resolution is a premise worth copying: *function is a gradient over connectivity, and densely reciprocally interconnected regions must share some functional properties*, so the frame labels are regional **biases** rather than regional contents. This is the anatomical version of `T47`'s difficulty: if every stage carries some of both frames, no experiment that localises a frame can adjudicate independent-versus-shared coding.

**(brainstorm) The lamination rule is a transferable design constraint if it survives.** Two pathways whose targets have a granular layer IV support conscious, reportable percepts; the one whose target is agranular supports fast non-conscious action. Layer IV is the canonical *input* layer ([[wiki/concepts/canonical-cortical-microcircuit.md]]) — the place a stream is re-sorted before being read. So the proposal reduces to: **a stream becomes reportable when it is re-formatted by an input stage before use, and stays non-reportable when it is consumed directly by the effector.** That is a claim about interfaces, not about content, and the wiki has no architecture in which reportability is a property of how a signal is *received*. Untested; the authors offer it as future research.

**The convergence answer to the original two-stream question.** Ungerleider & Mishkin 1982 ended by asking where the two streams' object and spatial information are re-integrated. This source's answer is the **medial temporal lobe**: the ventral stream supplies parahippocampal cortex with the form information needed to represent a landmark, and the parieto-medial-temporal pathway supplies the spatial information that marks it as navigationally relevant, with both converging in hippocampus. Landmark = object identity × spatial relevance, bound at the store rather than in either stream — which makes the hippocampal formation the binding site for `what` and `where` and not merely their consumer.

**The two "perception" pathways converge too, and the wiki has the edge already.** Parieto-prefrontal and parieto-medial-temporal meet through prefrontal ↔ hippocampal projections in the **cingulum bundle** — proposed as the coordination of spatial working memory with navigation from long-term memory, and as associative retrieval of one by the other ([[wiki/entities/hippocampal-prefrontal-channel.md]]). Motor output from either then has to be routed through the premotor pathway, so the architecture is two perception streams sharing a control loop and one action stream they both have to speak to.

---

## Limitations

- **The functional evidence does not respect the anatomical divisions.** The authors state that the parietal functions for all three pathways are distributed across overlapping posterior-parietal subdivisions, that little research directly compares the competing functional properties (peripersonal vs extrapersonal coding) *within the same region*, and that such research is what would establish the functional biases the framework asserts.
- **The trifurcation is a claim about weighting, not about segregation.** The three pathways have "differently weighted parietal inputs"; only the parieto-medial-temporal one is strongly source-specific (`cIPL`).
- **The intermediate stages are the least studied.** Very little is known about PCC and RSC in monkey; the relative dominance of egocentric versus allocentric coding at each stage is unmeasured, and — the authors' own closing ask — **the neural mechanism of the frame transformation is unidentified at every stage**.
- **Three pathways is a floor, not a count.** The authors explicitly decline to claim there are only three, naming an MT/superior-temporal-sulcus motion-and-form stream as a candidate fourth.
- **Human evidence is coarse.** Differentiation among posterior parietal areas in humans is called difficult; the human pathway rests on resting-state functional connectivity plus lesion syndromes, not on tracing.
- **The lamination proposal has no test in the source** — it is offered as a coincidence worth pursuing.
- **The lesion taxonomy is built from case reports**, with the usual confounds: lesions large enough to produce a clean syndrome are rarely confined to one stage, and retrosplenial cases in particular are confounded with cingulum-bundle damage ([[wiki/entities/retrosplenial-cortex.md]]).
- **Nothing here is non-spatial.** Every frame, every deficit and every cell type in the source is physical-spatial; the source offers no analogue outside navigation, which is the residue `G39` carries.

---

## Connections

- **[[wiki/entities/ventral-visual-stream.md]]** — the other half of the original two-stream framework and the page this one completes: that page's cascade is scored by how simply a downstream reader can decode object identity, this one has no such criterion at any stage, and the two are proposed to re-converge in the medial temporal lobe, where form information from the ventral stream becomes a *landmark* only once this stream marks it navigationally relevant.
- **[[wiki/entities/retrosplenial-cortex.md]]** — the third pathway's last cortical stage, and the source of this page's most usable dissociation: heading disorientation (landmark recognised, direction not derivable, map drawable but not describable) sits one stage past landmark agnosia and one stage before anterograde topographic disorientation, so the conversion this region is credited with is bracketed by lesions that spare it.
- **[[wiki/entities/posterior-cingulate-cortex.md]]** — the stage before it, with its own evidence rather than as a boundary case: areas 23/31 carry allocentric saccade-target coding preserved across whole-body rotation, and inactivation impairs following *previously learned* routes — so the egocentric→allocentric conversion has already begun one relay upstream of retrosplenial cortex, which neither the tripartite parcellation nor the translation account predicts.
- **[[wiki/concepts/distributed-reference-frames.md]]** — supplies the anatomy for that page's Prediction 4: posterior parietal cortex is named there as a candidate site of a universal egocentric→allocentric conversion, and here it is the *source* of a three-stage pathway that performs it, with world- and object-centred cells already present in the caudal inferior parietal lobule — so the conversion is staged along a route rather than performed at a site.
- **[[wiki/concepts/reference-frame-transformation.md]]** — the pathway the operation runs on, and a constraint on any implementation of it: the conversion has at least three serial stages with independently failing lesions, so a single gain-field bank at one site is a compression of the biology, and the direct `cIPL` → hippocampal-formation shortcut means the store can be addressed *without* the conversion at all.
- **[[wiki/concepts/cognitive-map.md]]** — the missing input wire for that page's map: visual scene information reaches the allocentric store through `cIPL` → (PCC → RSC) → pre-/parasubiculum and TF/TH → CA1, with the two branches landing on head-direction and place populations respectively, which is why a landmark's displacement relative to boundaries shifts place fields.
- **[[wiki/entities/anterior-thalamic-nuclei.md]]** — the same head-direction circuit reached from the visual side: the pre- and parasubicular terminals of this pathway are part of the anterior-thalamic/mammillary head-direction system, so the descending visual route and the ascending diencephalic route converge on one population.
- **[[wiki/entities/subiculum.md]]** — the terminal this pathway is aimed at, at the resolution that matters: `cIPL` and the limbic relay both target CA1/prosubiculum and the pre-/parasubiculum specifically rather than the subicular complex as a whole, so the store's *input* stage is partitioned by source in the same way its output stage is partitioned by destination.
- **[[wiki/concepts/node-definition-problem.md]]** — the clearest case in the wiki of a label outliving its referent: "the dorsal stream" named a pathway to the inferior parietal lobule, was relabelled twice on functional grounds ("Where", then "How"), and denotes a source circuit feeding three pathways with three targets — and the inferior parietal lobule itself splits into `cIPL` and `rIPL`, only one of which is in the navigation route.
- **[[wiki/concepts/function-to-structure-inference.md]]** — a third instance of the wiki's relay problem: a direct `cIPL` → hippocampal-formation projection runs parallel to the two-stage limbic relay, so no ablation of the relay can remove the function, and the relay's justification has to be the parameter it inserts (heading) rather than the traffic it carries.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — where two of the three pathways meet: the parieto-prefrontal and parieto-medial-temporal routes converge through prefrontal ↔ hippocampal projections in the cingulum bundle, which the source proposes as the coordination of spatial working memory with long-term-memory navigation and as cross-retrieval of one from the other.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the substrate of the source's one novel explanatory proposal: the two pathways supporting reportable perception target granular cortex with a layer IV, the pathway supporting non-conscious visually guided action targets agranular cortex without one, so reportability may be a property of whether a stream is re-sorted by an input stage before use.
- **[[wiki/concepts/attention.md]]** — the parietal source circuit read as the substrate this page's first pathway controls: posterior cingulate activity tracks top-down attention shifts, cued-target speed-up and spatial-selection load, while the parieto-prefrontal route supplies prefrontal cortex the input it needs to direct eye movements top-down.
- **[[wiki/concepts/path-integration.md]]** — the visual-evidence supply line for the integrator: optic-flow speed coding in `cIPL`, heading-from-optic-flow responses in posterior cingulate and retrosplenial cortex, and the rat result that retrosplenial damage degrades thalamic head-direction coding *relative to landmarks* — one route carrying the correction from scene to integrator.
- **[[wiki/concepts/mental-imagery.md]]** — the generator that runs back down this stream: dorsal damage disrupts visualising locations and spatial transformations while sparing shape imagery, and congenital aphantasia is the reverse dissociation (object imagery at floor, spatial imagery slightly *above* controls) — so `what` and `where` fail independently in generation as in perception.
- **[[wiki/concepts/visual-routines.md]]** — the computational job description this anatomy has never been given: establishing spatial relations by tracing, marking and bounded activation is the traffic the parieto-prefrontal pathway would have to carry, and the shift-related physiology catalogued in 1984 (area 7, frontal eye fields, superior colliculus) is mostly *saccade*-related rather than routine-related, leaving the internal-shift controller unlocated.
- **[[wiki/concepts/active-vision.md]]** — the functional reading that cuts across this page's anatomy: identification and location are the two *tractable corners* of a many-models × many-image-parts matching problem rather than two pathways, and the location computation is claimed to **begin** in the ventral stream (a remembered feature vector propagated down feedback connections and correlated at every location and scale) and **end** as a saliency map in the dorsal one. So neither operation belongs to a stream, and the trifurcation here is a partition of targets rather than of jobs (Ballard et al. 1997).
