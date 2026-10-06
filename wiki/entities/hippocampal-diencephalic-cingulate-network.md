# Hippocampal–Diencephalic–Cingulate Network — the Papez "Circuit" Is Two Efferent Routes, Not a Loop

**The structures Papez (1937) chained into one serial loop — hippocampal formation → (fornix) → mammillary bodies → (mammillothalamic tract) → anterior thalamic nuclei → cingulate cortex → parahippocampal region → hippocampus — as tract tracing in rat and macaque now draws them. Every link Papez named exists. Every link after the mammillary bodies is **reciprocal**, and many connections **skip stages**. The mammillary bodies are the only node with a single target. The better description is a **medial-temporal-lobe efferent system with two routes**: a subcortical *diencephalic* route (subiculum → fornix → mammillary bodies / anterior thalamus) and a cortical *cingulate* route (subiculum → retrosplenial cortex). The two routes reconverge on the anterior thalamic nuclei and the cingulate cortices. Both arise mostly from the posterior (rodent dorsal) hippocampus, and both add indirect hippocampus→prefrontal paths alongside the direct projection from the anterior hippocampus.**

> **Provenance.** Bubb, Kinnavane & Aggleton 2017, *Hippocampal–diencephalic–cingulate networks for memory and emotion: an anatomical guide*, Brain and Neuroscience Advances 1:2398212817723443 (`raw/bubb-2017-hippocampal-diencephalic-cingulate-networks-memory-emotion-anatomical-guide.md`). A review of tract-tracing studies in rat and macaque, plus human fibre dissection and diffusion tractography, with a lesion and neuropsychology section. Figures 3–10 are connection diagrams; in the clip they are images, so line strengths ("dense", "light") come from the prose. **The source contains no quantities apart from the fibre-share statements below.** Third author Aggleton also last-authored the tripartite review on [[wiki/entities/anterior-thalamic-nuclei.md]], so the two sources are not independent.

Why this earns a page. The wiki holds the network node by node: [[wiki/entities/subiculum.md]], [[wiki/entities/anterior-thalamic-nuclei.md]], [[wiki/entities/retrosplenial-cortex.md]], [[wiki/entities/posterior-cingulate-cortex.md]] and [[wiki/entities/entorhinal-cortex.md]]. Until now it held no source that traces the **circuit as a circuit**: which edges exist, which tract each one uses, and so which lesion cuts which edge. `T381` cannot be tested without this. Its `Closes when` asks for one stream to be cut *downstream of its branch point*, and only the route anatomy says where that point is.

---

## The edges

Rat and macaque agree unless a row says otherwise. "Route" is the tract the fibres travel in, and it decides what a tract lesion disconnects.

| Edge | Strength | Route | Detail |
|---|---|---|---|
| Subiculum → mammillary bodies | Dense | Postcommissural fornix; some fibres cross to the contralateral side | Arises from the subiculum (plus pre-/postsubiculum), **not** from the CA fields. Medial mammillary input comes from the **middle** subicular cell layer, lateral mammillary input from pre-/postsubiculum. Dorsal subiculum → dorsal medial mammillary and ventral → ventral (a horizontal topography). In monkey these fibres make up ~½ of the postcommissural fornix |
| Mammillary bodies → hippocampus | **None** | — | No return projection |
| Mammillary bodies → anterior thalamic nuclei | Very dense | Mammillothalamic tract | Unidirectional. Few or no interneurons, and essentially every mammillary neuron projects here. Medial mammillary → `AM`/`AV` (ipsilateral); lateral mammillary → `AD` (**bilateral**). This terminal map runs roughly **orthogonal** to the subicular map onto the mammillary bodies, so dorsal and ventral subicular inputs can reach the *same* thalamic site. Nothing reaches the laterodorsal nucleus |
| Subiculum → anterior thalamic nuclei (direct) | Dense | Mostly fornix. Some distal subiculum/presubiculum → dorsolateral `AV`, and most postsubiculum/parasubiculum → `AD`, travel in the **internal capsule** (nonfornical) | Arises from the **deepest** subicular layer, separate from the middle-layer mammillary-projecting cells. Mostly from dorsal (rodent) / posterior (primate) hippocampus, whereas mammillary inputs come from both ends. Rat: proximal subiculum → `AM`, distal subiculum → `AV`. Monkey: the cell populations are separated by lamina only |
| Anterior thalamic nuclei → subiculum, pre-/para-/postsubiculum | Dense in rat; light in monkey | Cingulum (`AD` partly direct) | Rat `AM` → perirhinal and entorhinal cortex; `AD` → entorhinal cortex. **Monkey anterior thalamic nuclei do not project to entorhinal cortex** |
| Anterior thalamic nuclei ↔ retrosplenial cortex | Dense, reciprocal, topographic | Thalamus → cortex: cingulum, via striatum or internal capsule + corpus callosum. Rat retrosplenial → thalamus: a direct path around the ventricle, through the internal capsule, across dorsal thalamus | `AV` ↔ granular area 29; `AM` ↔ dysgranular area 30 (rat) and area 23 (monkey); `AD` → area 29. The thalamic projections are ipsilateral. The return comes from cortical **layer VI** and reaches **both** hemispheres. Laminar targets: `AV` → layer I; `AD` → layers I + deep II/III; `AM` → layers I + V |
| Anterior thalamic nuclei ↔ anterior cingulate / prelimbic cortex (monkey areas 24, 25, 32) | Light–modest | Anterior limb of the internal capsule → cingulum | Restricted to `AM`. These cortices' **densest** thalamic partner is the **mediodorsal** nucleus |
| Retrosplenial → pre-/postsubiculum, entorhinal cortex, areas TH/TF | Dense | Cingulum | Few fibres reach the subiculum itself. This closes the notional loop, via presubiculum → entorhinal cortex → dentate gyrus/CA3 (layer II) or CA1/subiculum (layer III) |
| Subiculum, pre-/parasubiculum → retrosplenial cortex | Dense | **Not the cingulum**: in monkey the fibres cross directly through the presubiculum | Distal subiculum → area 29 (layers I–III). Topographic: anterior subiculum → ventral retrosplenial cortex, posterior subiculum → mid/dorsal retrosplenial cortex. Areas TH/TF and caudal entorhinal cortex also project here. In humans (diffusion imaging), retrosplenial cortex is the principal cingulate site of direct hippocampal connections |
| Retrosplenial → **dorsal hippocampus via the anterior thalamic nuclei** | A major pathway (viral tracing) | — | Prasad & Chudasama 2013 (cited). The cingulate→store direction runs largely through the thalamus |
| Retrosplenial → medial mammillary nucleus | Very light | Postcommissural fornix | — |
| Subiculum/CA1 → prefrontal areas 25, 32 (direct) | Dense | Fornix | From **anterior** hippocampus. The same areas receive `AM` input, so the direct and the multi-stage hippocampus→prefrontal paths converge on one target |

**Tract specificity.** The **mammillothalamic tract is the only pathway devoted to this network**. The fornix, cingulum and anterior thalamic radiations all carry fibres to other sites, so a lesion or a tractography measurement of any of them is never specific to this network. In humans most fibres of the fornix body enter the postcommissural fornix (fibre dissection), which ends mainly in the mammillary bodies and anterior thalamic nuclei.

**Species differences.** Rat retrosplenial cortex links to the anterior thalamic nuclei and **not** to the mediodorsal nucleus. Monkey retrosplenial cortex has light mediodorsal links, and monkey area 23 links to both. Areas 23/31 have no rat homologue (see [[wiki/entities/posterior-cingulate-cortex.md]]). In both species, retrosplenial cortex is the network's principal cingulate node.

---

## Four structural facts

| Fact | Consequence |
|---|---|
| **Stage-skipping is everywhere.** The anterior thalamic nuclei receive hippocampal input three ways: directly, via the mammillary bodies, and via retrosplenial cortex | Direct and indirect projections between the same pair of sites recur throughout the network. The source names their computational value as an open question |
| **Reciprocity everywhere except the mammillary bodies**, which have one target and receive no return | The network contains a one-way *feedforward* stage (subiculum → mammillary → anterior thalamus) inside an otherwise reciprocal graph |
| **Topography in every pathway** — each nucleus or subregion pairs with its own partners | Parallel subsystems share the same named tracts. One is the head-direction subsystem: lateral mammillary nucleus, `AD`, laterodorsal nucleus, retrosplenial cortex and postsubiculum all contain head-direction cells. Another is the `AM` (frontal-facing) versus `AV` (hippocampal-facing) split |
| **Laminar segregation of origin.** In the subiculum, the cells projecting to the anterior thalamic nuclei (deep layer) differ from those projecting to the mammillary bodies (middle layer) | The two diencephalic branches already separate **at the cell of origin**. Combined with the ~50% subiculum→retrosplenial cells that collateralise to the mammillary bodies ([[wiki/entities/anterior-thalamic-nuclei.md]]), there is no single downstream branch point |

---

## Lesion evidence, read through the route anatomy

| Lesion | Effect | Anatomical reading |
|---|---|---|
| Fornix | **Sufficient for anterograde amnesia** (human colloid cysts; monkey and rat) | Cuts subiculum → mammillary bodies and most of subiculum → anterior thalamus. It spares subiculum → retrosplenial cortex and the internal-capsule fibres to `AD`/dorsolateral `AV` |
| Mammillary bodies | Milder than anterior thalamic lesions (rat delayed non-match to position; reinforced spatial alternation) | Bypassed by the dense direct subicular → thalamic projection |
| Anterior thalamic nuclei | **Vital for hippocampal-dependent learning**; usually worse than mammillary lesions, and sometimes worse than fornix lesions | The **convergence point** of the direct, mammillary and retrosplenial routes, so the only site where one lesion can disconnect all three |
| Retrosplenial cortex | Effects often mitigated (rat) | Parallel hippocampus ↔ thalamus routes bypass it |
| Cingulum bundle | **Not amnesic** in humans (cingulotomy) and mild on hippocampus-sensitive rat spatial tasks | The dense subiculum → retrosplenial projection and some retrosplenial ↔ thalamic fibres **do not travel in the cingulum**. A cingulum lesion is therefore not the cortical-route counterpart of a fornix lesion |
| Anterior cingulate cortex | No anterograde amnesia; costs cognitive control and schema use | Belongs mainly to the amygdala-centred "basolateral" limbic system. It links to this network through `AM` and the mediodorsal nucleus |

**The authors' reading of the asymmetry.** If the hippocampus is the centre of a loop around which information flows unchanged, fornix and cingulum lesions should cost the same. They do not, and the route anatomy explains why. In a network with bypasses, **lesion severity measures convergence**: how many routes run through the cut. It does not measure how much the cut node contributes. The anterior thalamic nuclei are the exception because they are the convergence node. [[wiki/entities/retrosplenial-cortex.md]] makes the same point for one triad. This network shows it across the whole system.

**Not purely relayed.** The source cites Dillingham 2015b and Wright 2015 for contributions of the mammillary bodies and anterior thalamic nuclei to learning that *do not depend solely on their hippocampal inputs*. This is Position B evidence on `T381`, in a review whose last author also wrote that position.

---

## The long axis, once more

| | Posterior (primate) / dorsal (rodent) hippocampus | Anterior / ventral |
|---|---|---|
| Network routes | Both: mammillary + direct anterior-thalamic + retrosplenial | Mammillary input only (rodent ventral subiculum → ventral medial mammillary) |
| Direct prefrontal projection | Light | **Dense** (to areas 25, 32 via the fornix) |
| Other targets | — | Amygdala, nucleus accumbens, medial and orbital prefrontal cortex |
| Function bias (source's reading) | Mnemonic | Emotional (anxiety, posttraumatic stress disorder, schizophrenia) |

So the network engages mainly the posterior hippocampus. The hippocampal projections most linked to emotion largely bypass it, which inverts Papez's original assignment. See [[wiki/concepts/hippocampal-long-axis.md]] for the axis itself.

---

## How it maps to model components

| Network element | Model reading |
|---|---|
| Subiculum's laminar output split | One store, **several typed write paths** that leave from different cell populations. The branch is set by which cell fires, not by a routing decision downstream ([[wiki/entities/subiculum.md]]'s typed-head reading, one axis further) |
| Mammillary bodies | A **pure feedforward transform** stage: no interneurons, every cell projecting to one target, no feedback. It also re-maps the store's long axis orthogonally, so dorsal and ventral store content can converge on one thalamic site |
| Anterior thalamic nuclei | A **convergence node** with three copies of the store's output, each sent by a different route with a different number of intervening stages. Their arrival delays therefore differ by construction |
| Retrosplenial cortex | A cortical **parallel edge** between store and thalamus that also carries sensory input. It is the reciprocal partner of both |
| The direct + indirect motif | The same node pair joined by a monosynaptic and a multi-stage path. The source names this motif, and asks what it computes, without answering. One answer was proposed 18 years earlier (below) |

**A 1999 answer to the motif question: the indirect path gates the direct one** (Krieckhaus, commentary on Aggleton & Brown 1999, `raw/aggleton-1999-episodic-memory-amnesia-hippocampal-anterior-thalamic-axis.md`). The hypothesis is one commentator's and is untested.

| Element | Claim |
|---|---|
| Anatomy | `AV` receives the subiculum twice: directly, on distal dendrites (cortical feedback), and indirectly via fornix → medial mammillary → mammillothalamic tract, on proximal dendrites inside glomeruli with GABAergic interneurons. Krieckhaus calls this unique: no other thalamic nucleus takes its "driver" input from the same cortex it projects back to |
| Gating rule | **Proximal gates distal.** Mammillary excitation does not drive `AV`. It sets whether the distal subicular input can reach the soma. Remove it, and interneuron inhibition shuts the distal input out |
| Prediction | Mammillary or mammillothalamic lesions should cost *more* than fornix lesions, because they remove the gate *and* silence the distal path. A fornix cut removes the gate's scene content and leaves general subicular feedback |
| Authors' reply | No animal study shows mammillary > fornix. They offer a different route to the same pattern: the laterodorsal nucleus gets non-fornical subicular input, so `ATN` lesions that include it can exceed fornix lesions |

**(brainstorm)** Read as a design, the two paths are not redundant copies. They are a **value and its gate, from one source**. The module's direct output is admitted at the target only when its own transformed copy, after a feedforward stage with no feedback, agrees to admit it. This gives `G52` an edge with state (gate open or shut) set by the sender's own other output. That differs from this page's three-delay coincidence reading, where every copy carries content.

**The 1999 lesion record that fixed this network as one system** (Aggleton & Brown 1999; full treatment on [[wiki/concepts/recollection-familiarity.md]] and [[wiki/entities/anterior-thalamic-nuclei.md]]). Following Delay & Brion (1969), the target article named hippocampus + fornix + mammillary bodies + anterior thalamic nuclei (+ possibly the cingulum bundle) the **extended hippocampal system**. Bilateral damage to any part gives anterograde amnesia. Damage to any part spares familiarity-based object recognition, which runs through perirhinal cortex instead. Two results bear on the route anatomy above:

| Result | Bearing |
|---|---|
| Crossed fornix × `ATN` and hippocampus × `ATN` lesions impair rat spatial working memory; same-side pairs do not | The diencephalic route is a functional serial path for this task. The fornix cut must include the hippocampal commissure, as this page's note on crossing subicular fibres predicts |
| Rat T-maze alternation: hippocampus ≈ fornix ≈ `ATN` > mammillary ≈ cingulum. Cingulate cortex cytotoxic lesions are near-null; monkey cingulate ablation is mild on object-in-place | The same severity ordering as the 2017 table, from lesions made before the route anatomy existed |

**(brainstorm) Three delays onto one node is a coincidence detector's input, and the tripartite account already needs one.** [[wiki/entities/anterior-thalamic-nuclei.md]] proposes that consolidation needs synchronous arrival of two streams at a convergence zone. This page shows the anterior thalamic nuclei already receive the store's output by a 1-stage (direct), 2-stage (mammillary) and 2-stage cortical (retrosplenial) route. On the mammillothalamic and subicular inputs to that node, plasticity runs in opposite directions. A machine version: send one module's output to a target by `k` paths of different depth. Let the target's update fire only when the `k` copies arrive in a set temporal relation. The copies then **stop being redundant**: each path's transform is a different view of the same source, and their agreement is a learned check. This gives `G52` a reason for an edge's state that no single-path design has. It also predicts the lesion profile above: cutting one path weakens the check, and cutting the node removes it.

**(brainstorm) A circuit diagram and an efferent system make different architectural commitments.** A loop implies a recurrent controller that re-enters the store, so every stage is optional infrastructure for the store. An efferent system implies the store **exports** to several consumers by several routes, with returns that are modulatory. The second matches the wiki's typed-read-head picture of the store ([[wiki/entities/subiculum.md]]) and makes the anterior thalamus a consumer with its own job. It does not settle which is right. The reciprocal connections, and theta running through every node, are what keep "circuit" defensible, and the authors concede both.

**(brainstorm) Which edge to cut is an `L0-INSTR` question this page can now answer.** To test a two-stream model, cut each stream after the branch and spare the other:

| Target | Available cut | What it misses |
|---|---|---|
| Diencephalic route only | Fornix transection | Internal-capsule fibres to `AD` and dorsolateral `AV`; some entorhinal/perirhinal → thalamic fibres |
| Cortical route only | Not the cingulum. It would have to be the subiculum → retrosplenial fibres crossing the presubiculum, a cut no study cited here makes | — |
| Both, at convergence | Anterior thalamic lesion | Not a stream cut: it removes the destination, too |

`T381`'s `Closes when` is therefore stricter than it reads. The converse cut has no clean surgical form, and the one tract lesion with a human literature (the cingulum) is the wrong one.

---

## Limitations

- **Anatomy, not function.** Every functional claim is a re-reading of lesion studies that were not designed against this route map. The review contains no recording.
- **Human connectivity is inferred from rat and macaque.** Fibre dissection and diffusion imaging cannot tell fibre direction, miss diffuse pathways, and cannot isolate this network on any tract except the mammillothalamic one.
- **Strength labels are qualitative** ("dense", "light"). The source gives no counts, and the figures are images in the clip.
- **Not independent of the tripartite model.** It shares an author (Aggleton) and a lab's tracing studies with [[wiki/entities/anterior-thalamic-nuclei.md]].
- **The emotion section is historical and surgical** (cingulotomy, capsulotomy, posterior cingulectomy). The outcome reports were not designed to measure memory, so "memory spared" is an absence of reports.
- **Other connections are out of scope.** Every node has many connections outside the network. The source covers none of them, so "only target" and "convergence node" hold within this network only.

---

## Connections

- **[[wiki/entities/anterior-thalamic-nuclei.md]]** — the convergence node of this network. It receives the store's output directly, via the mammillary bodies and via retrosplenial cortex, so it is the only site where one lesion disconnects all three routes. That is why its lesion rivals fornix lesions, and the route anatomy is what `T381`'s stream cuts must be planned against.
- **[[wiki/entities/subiculum.md]]** — the origin of both routes, split by lamina: deep cells → anterior thalamus, middle-layer cells → mammillary bodies, distal cells → retrosplenial cortex. The typed-head reading of the store's exit therefore also holds on the superficial–deep axis.
- **[[wiki/entities/retrosplenial-cortex.md]]** — the cortical route's node. Its dense subicular input bypasses the cingulum, and its main route back into dorsal hippocampus runs through the anterior thalamic nuclei. Both facts explain why its lesions and cingulum lesions cost less than fornix lesions.
- **[[wiki/entities/posterior-cingulate-cortex.md]]** — the monkey areas 23/31 that the rat network lacks. Area 23 connects to both the anterior thalamic and mediodorsal nuclei, and retrosplenial areas 29/30 are where the network's direct hippocampal input lands, matching that page's retrosplenial-as-medial-temporal subregion.
- **[[wiki/concepts/hippocampal-long-axis.md]]** — the network draws mainly on the posterior/dorsal hippocampus. The anterior/ventral end reaches prefrontal areas 25/32 directly and reaches the network only through the mammillary bodies, where an orthogonal re-map lets both ends converge on one thalamic site.
- **[[wiki/concepts/transthalamic-context-routing.md]]** — the same direct-plus-indirect motif at a different site. There, a direct cortico-cortical edge and a thalamic detour carry different cargo. Here, the store reaches the anterior thalamus by a direct and by two multi-stage routes, and the source names what such pairs compute as unknown.
- **[[wiki/concepts/recollection-familiarity.md]]** — what this network was proposed to *do* before its routes were traced: Aggleton & Brown 1999 named its fornix-borne diencephalic route the recollection system, which is necessary for recall and allocentric scene memory and dispensable for familiarity-based recognition, which uses the perirhinal–mediodorsal route outside the network.
- **[[wiki/concepts/hippocampal-indexing-theory.md]]** — Gabriel & Smith's reading of this network's thalamo-cingulate end: the anterior thalamus and posterior cingulate cortex produce context-specific activation patterns to a cue within ~80 ms, store no content, and retrieve content held elsewhere, which is the content-free index carried past the hippocampus.
