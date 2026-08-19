# Distributed Reference Frames

**The claim that grid-like location coding is not a specialisation of one structure but a *replicated cortical primitive* — every sensory and higher-order area running its own reference frame over its own input space, rather than one central map serving all of them.**

The wiki's map pages all assume a single hippocampal-entorhinal map that everything else reads. Chen et al. 2022 argue the opposite architecture: grid computation is a general solution to "where is this, relative to what", instantiated wherever that question arises. If true, the `g` of [[wiki/concepts/abstract-structural-codes.md]] is not one code but thousands of parallel codes needing arbitration — which is a different engineering problem from the one the wiki has been solving.

This is an opinion/prediction paper. Its evidence is a literature roundup plus preliminary rodent recordings from the authors' own lab; four of its five load-bearing claims are explicitly labelled speculation by the authors.

---

## The evidence for replication

| Site | Finding | Method |
|---|---|---|
| Rat primary somatosensory cortex (S1, hindlimb area, layers IV–VI) | Grid cells, place cells and head-direction cells; conjunctive head-direction coding in the grid cells | Freely-foraging electrophysiology (Long & Zhang 2021) |
| Rat secondary visual cortex (V2M, superficial and deep layers) | Same three cell types | (Long et al. 2021a) |
| Both | Spatial modulation **persists under whisker trimming and in darkness**; theta oscillations present in both areas, supplying speed/acceleration input | Sensory-deprivation controls |
| Human medial entorhinal + cingulate | Grid-like units during virtual-reality exploration | Intracranial (Jacobs et al. 2013; Nadasdy et al. 2017) |
| Human orbitofrontal, ventromedial prefrontal, anterior and posterior cingulate | Hexadirectional BOLD modulation during conceptual tasks — and the entorhinal and ventromedial-prefrontal grid *angles are aligned to each other* (`t21 = 2.18`), stable within a day and across a week | fMRI (Constantinescu et al. 2016; Bao et al. 2019) |
| Human entorhinal + medial prefrontal + posterior cingulate + temporoparietal junction + superior temporal sulcus | Grid-like code over *inferred, never-traversed* vectors in a discrete social-hierarchy decision space — and **all of these regions are modulated in alignment with the entorhinal grid angle**, which is itself stable across sessions ~9 days apart | fMRI (Park et al. 2021) |
| Human entorhinal (grid) + prefrontal/orbitofrontal/cingulate (distance) | Grid code over relative angular positions of newly learned words in a "word space" | fMRI (Viganò et al. 2021) |
| Monkey medial entorhinal | Grid-like coding of *gaze* position during free viewing, no locomotion | Head-fixed electrophysiology (Killian et al. 2012) |
| Rat orbitofrontal, piriform cortex | Up to 80% location-selective tuning conjoined with future-goal coding (orbitofrontal); spatial map carried alongside odour identity (piriform) | (Basu et al. 2021; Poo et al. 2022) |

**The one measured relation *between* two frames points the other way from independence.** This source's mechanistic proposal is that each area's integrator is "complementary yet functionally independent" of the entorhinal one. But in every case where two or more frames' orientations have been estimated in the same task, they agree: entorhinal and ventromedial-prefrontal hexagonal codes over the same conceptual space share a grid angle, and each region's angle is itself stable across sessions a week apart (Constantinescu et al. 2016). Park et al. 2021 extends this from a pair to a **network** — medial prefrontal, posterior cingulate, temporoparietal junction and superior temporal sulcus are all tested against the *entorhinal* angle and all show six-fold modulation aligned to it, with the alignment reproducible across days. So the count of independently oriented frames observed in a single abstract task is still one. Two readings, both useful:

| Reading | Consequence for G43 |
|---|---|
| **Registered, not independent** | Concurrent frames are held in a common orientation, so their outputs are already commensurate and arbitration reduces to weighting rather than to coordinate conversion — the cheapest possible answer to the arbitration gap. Park et al. 2021 adds the functional consequence: a *downstream readout* (decision value in medial prefrontal cortex and temporoparietal junction) is significantly stronger for queries aligned to the shared angle, so registration is not decorative — it sets how well the frame can be read |
| **One frame, read out in many places** | vmPFC modulation is entorhinal output propagated, and there is only one code — which would shrink the replication claim to the single-unit S1/V2 rows and remove every fMRI row from the evidence for it |

Nothing in the data separates these, since BOLD cannot say where the code is computed ([[wiki/empirical-tensions.md]] T47). The discriminating experiment is a *conflict* design: put the two regions' preferred structures in disagreement (two spaces navigated at once, or a space whose conceptual axes rotate relative to its spatial ones) and see whether the angles dissociate.

The darkness/whisker-trim controls are the load-bearing ones: they make the S1 and V2 grids *not* a read-out of the sensory input those areas process, which is what licenses calling them a second reference frame rather than a sensory response.

---

## The architectural proposal

**Cortical columns as reference-frame units** (Mountcastle 1978; Hawkins et al. 2019, via this source). Each column runs grid-like computation over the location of *its own input* relative to the object being sensed — visual features relative to the object viewed, tactile features relative to the object touched. The object is then represented not by a code but by a **set of columns voting on a consistent pose**.

| Property | Consequence for a reasoning model |
|---|---|
| The frame is per-column, not per-brain | Structure is discovered redundantly and in parallel; no module owns the map |
| Each frame is anchored to an *object*, not to the world | Allocentric-relative-to-thing, which is the composable version — a part's position in an object transfers across scenes |
| Recognition is voting across frames | Consensus over many partial, independently-derived structures rather than one inference over one graph |
| Cortical uniformity is the argument | The same circuit is claimed to do this everywhere, so the primitive must be domain-general or the theory fails |

Hinton's capsule networks are named by the source as the same idea arrived at from computer vision: units carrying an explicit coordinate frame, doing coincidence voting for view-invariant recognition.

**Dynamic resource allocation (the authors' hypothesis).** Grid cells in sensory cortex are sparse, heterogeneous and not layer-confined, unlike the dense layer-II mEC population. The proposal is that a *subset* of sensory neurons is recruited into grid-like computation, with tuning that is dynamic and task-context-dependent. **(brainstorm)** If correct this is not "an extra module per area" but a *mode* the same population enters — the machine analogue is a shared parameter pool with a context-gated readout, not a bank of dedicated integrators. It also explains the small proportions, and it makes "how many reference frames are running" a question with no fixed answer (G43).

---

## Where the frames come from

The source's mechanistic speculation, which is the part directly usable:

> Sensory cortical grid cells emerge from a **generalized path-integration principle** running on each modality's own self-motion signal — optic flow in visual cortex, proprioceptive/locomotor feedback in somatosensory cortex — and are *complementary yet functionally independent* of the mEC grid cells.

| Modality | "Movement" that is integrated |
|---|---|
| Touch | Hand/limb movement, proprioception |
| Audition | Head movement |
| Vision | Optic flow; also gaze, given the monkey result |
| Abstract concept space | Movement along attribute dimensions ("the attribute space replaces physical space") |

This makes [[wiki/concepts/path-integration.md]] the *shared* primitive and the modality only a supplier of velocity — which is the cleanest form of the wiki's claim that `g` is built by the update rule rather than by the input.

**The independence claim has a dissociation behind it.** In mouse virtual reality with visual and physical motion decoupled, mEC grid cells follow *physical motion* while hippocampal place cells follow *visual input* (Chen et al. 2019) — so at least two of these frames already demonstrably integrate different quantities.

---

## The measurement problem, stated by the source itself

The paper argues for near-universal grid coding and then undercuts its own detector:

- Identifying grid patterns is "a relatively arbitrary threshold phenomenon"; the standard spatial-autocorrelation method **generates false positives**, and shuffle controls that randomise spike timing while preserving rate are needed to bound the false-detection rate.
- fMRI BOLD does not measure spiking, so hexadirectional modulation cannot be read as a grid population the way a spike train can.
- **No single-unit grid representation in a conceptual space has ever been recorded**, in humans or animals — the entire abstract-grid case is fMRI.
- Grid patterns are also *missed*: mismatched grid scale versus enclosure size hides them, and nobody looked in non-traditional areas until recently.

Recorded as [[wiki/empirical-tensions.md]] T37. This qualifies every "grids outside space" row in [[wiki/concepts/abstract-structural-codes.md]] and [[wiki/concepts/cognitive-map.md]].

**A second qualifier on what a grid *is*.** Rueckemann et al. 2021: grid firing supports a *learned topology of ordered experience*, not a rigid coordinate frame bound to physical measurement. That reading moves grid codes to the topological side of [[wiki/empirical-tensions.md]] T27, and it is what makes replication across non-metric domains coherent at all.

---

## The transformation the source predicts must exist

Prediction 4: **a universal egocentric→allocentric conversion implemented across sensory cortices**, since every modality's input arrives self-centred and the frames above are object- or world-centred.

| Candidate | Role |
|---|---|
| Posterior parietal cortex | Bridges perception, action and cognition; projects to sensory cortex, entorhinal cortex and frontal cortex; carries spatially-modulated cells. Testable by optogenetic inactivation → do S1/V2 grids survive? |
| Thalamus | Proposed **multiplexer**: relays and processes multisensory streams to every cortical region reciprocally, with bursting neurons plus theta/gamma coordination as the multiplexing mechanism |

This is the wiki's first *biological* candidate machinery for gap G39 (anchoring) — but only inside space, and it is a hypothesis with no supporting experiment.

---

## Open problems

- **How many frames, and who arbitrates?** Voting is asserted, not specified; nothing says how inconsistent frames are reconciled or how a frame is instantiated for a new object (G43).
- **Are these frames independent or downstream?** No causal dissection exists. S1 grid coding could be locomotion feedback from motor cortex or ascending proprioception rather than a local integrator; descending influence from limbic navigation circuits onto sensory cortex is untested.
- **Orthogonality in feature space is untested.** mEC grid modules are mutually orthogonal in phase/frequency over physical space; whether V2 or S1 grid cells preserve orthogonality over the *visual* or *tactile* feature space is unknown — and that is exactly the question of whether these are reference frames for content or only for the body.
- **The conceptual-space experiments use very few attributes.** All human abstract-grid tasks navigate 2-D hand-designed feature planes; whether a grid code is detectable — or exists — in an unstructured task is unknown, and the source concedes the lack of structure may itself be why nothing is found.
- **No account of learning.** How sensory cortical grid cells are generated and adapted over the course of learning is stated as unknown.

---

## Connections

- **[[wiki/concepts/abstract-structural-codes.md]]** — turns that page's "is periodic coding general or spatial?" open problem into a positive architectural thesis (it is general because it is replicated per cortical area) and simultaneously supplies the detector caveat that weakens every fMRI-based instance of it.
- **[[wiki/concepts/path-integration.md]]** — supplies the mechanism this page runs on, once per modality: each frame integrates its own self-motion signal (optic flow, proprioception, head movement), so the update rule is shared and only the velocity source differs.
- **[[wiki/concepts/cognitive-map.md]]** — the direct rival architecture: one map anchored and searched, versus many object-anchored frames voting. It also inherits this page's egocentric→allocentric prediction as the first biological candidate for its missing anchoring operation (G39).
- **[[wiki/concepts/compositionality.md]]** — an object-anchored frame is a part-whole description with a metric attached: a feature's position *relative to the object* is reusable across scenes in the way a part-and-relation vocabulary is, and the column-voting scheme is a consensus rule over such descriptions.
- **[[wiki/concepts/successor-representation.md]]** — the alternative derivation the source also endorses: grid-like codes as eigenvectors of the transition matrix, which would make replication across areas a consequence of each area running the same spectral decomposition over its own transition statistics rather than of a shared circuit motif.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the single-frame realisation this page contrasts with: one structural code rebound per environment, rather than many concurrent codes anchored to different objects.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the parallel-discovery reading of the framing: many partial graph estimates built redundantly over different input spaces, with consensus rather than a single posterior as the integration mechanism.
- **[[wiki/concepts/representation-probing.md]]** — the measurement problem here is that page's problem in neuroscience form: a grid score, like a linear probe, certifies that a pattern is *findable*, and the source's own false-positive warning is the sharpest statement in the wiki of what a decodability instrument does not buy.
- **[[wiki/concepts/objective-identifiability.md]]** — the model-side twin of this page's detector caveat: the same grid score applied to trained networks shows periodicity is installed by the choice of readout target rather than selected by the task, so T37 (is the biological signal real?) and T38 (is the modelled signal earned?) are one measurement problem in two systems.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the same commitment to frame-transformation as a core cortical operation: posture-dependent mappings between reference frames, learned from multimodal correlation and localised to posterior parietal cortex, which is this page's Prediction 4 arrived at from the predictive-processing side.
- **[[wiki/entities/fly-central-complex.md]]** — the single-frame architecture this page argues against, measured rather than assumed: one ring, one heading, one landmark selected winner-take-all, and no consensus mechanism anywhere — plus the demonstration that concurrent integrators in different animals already disagree about which cue stream to trust ([[wiki/empirical-tensions.md]] T46).
- **[[wiki/concepts/dendritic-computation.md]]** — the same programme's cellular level: the columns that vote here are built from cells whose ~100 dendritic segments each detect one pattern by thresholded overlap, which is what makes "each column recognises the object from its own partial input" affordable — a column's vote is a set of segment matches, not a learned classifier.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the circuit this page's central claim assumes and never specifies: cortical columns are canonical because the laminar excitatory graph is conserved across areas and species, and "columns voting on a consistent pose" cashes out as soft winner-take-all among superficial pyramids, propagated between columns by lateral patches and between areas by layer-5 feedback (Douglas & Martin 2004).
- **[[wiki/entities/thousand-brains-theory.md]]** — the source theory of this page's architectural proposal, at circuit level: the per-column frame is a layer-6 grid population path-integrating an efference copy from layer 5, bound in layer 2/3 to the layer-4 feature by layer-1 dendritic priming, and the voting this page leaves unspecified becomes a second, lateral layer-2/3 output — still with no rule for making two object-anchored frames commensurate (G43).
