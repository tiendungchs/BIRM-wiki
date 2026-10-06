# Mammillary Bodies — One Feedforward Stage Carrying Two Signals: Heading as Content, Theta as Timing

**Two nuclear groups at the posterior hypothalamus that receive the hippocampal formation, send everything to the anterior thalamic nuclei, and return nothing to the hippocampus. The lateral mammillary nucleus (`LMN`) carries a head-direction signal and drives the anterodorsal thalamic one. The medial mammillary nucleus (`MMN`) carries hippocampal theta and relays it to the anteroventral thalamus. The two share every named tract and target, but reach different subregions of each target. Damage to both looks like one function because the two systems contribute to the same classes of learning and their effects add.**

> **Provenance.** Vann & Aggleton 2004, *The mammillary bodies: two memory systems in one?*, Nat. Rev. Neurosci. 5:35–44 (`raw/vann-2004-mammillary-bodies-two-memory-systems-in-one.md`). A review of rat and primate tract tracing, single-unit recording, selective lesions in rat and monkey, and human case neuropsychology. Box 1 (Korsakoff's syndrome) and Figures 1–5 are absent or images in the clip. Second author Aggleton also wrote the reviews behind [[wiki/entities/anterior-thalamic-nuclei.md]] and [[wiki/entities/hippocampal-diencephalic-cingulate-network.md]], so the three sources are not independent.

Why this earns a page. The wiki held the mammillary bodies as one edge in [[wiki/entities/hippocampal-diencephalic-cingulate-network.md]]: "a pure feedforward transform stage". This source splits that stage into **two parallel channels with different cargo on the same tracts**. One carries a represented variable (heading) and one carries a rhythm (theta). That is `G54`'s content/timing split, sitting in one anatomical structure with a lesion for each half.

---

## Anatomy

| Part | Size / cells | Notes |
|---|---|---|
| Medial mammillary nucleus `MMN` | The larger group; 1–5 subnuclei, depending on species and anatomist | Cytoarchitecture varies inside it, and its thalamic projection is highly topographic (Shibata 1992, cited) |
| Lateral mammillary nucleus `LMN` | Largest cells, small volume. Its share of the whole is near-constant across species: 5.8% mouse, 6.6% rhesus, 6.1% human infant | The porpoise may have no `LMN` and no clearly differentiated `MMN`. This has been used as an argument against a memory role |
| Excluded by most anatomists | Supramammillary nucleus; caudal tuberomammillary nucleus | They sit close enough that "mammillary" lesions often include them. The supramammillary nucleus **sets the frequency of hippocampal theta**, so involving it can enlarge a lesion's effect |

**Three connection sets, each split in parallel between the two nuclei** (rat; the primate pattern matches as far as it is known):

| Set | Direction | `MMN` | `LMN` |
|---|---|---|---|
| Hippocampal formation | **Afferent only** | Rostral (septal) subiculum via the postcommissural fornix; medial entorhinal cortex | Pre-, para- and postsubiculum |
| Anterior thalamic nuclei (mammillothalamic tract) | **Efferent only** | → `AM`, `AV`, ipsilateral | → `AD`, **bilateral** |
| Tegmentum (Gudden's nuclei) | **Reciprocal** | ↔ ventral tegmental nucleus of Gudden | ↔ dorsal tegmental nucleus of Gudden (`DTN`) |
| Other | Afferent | Supramammillary, tuberomammillary, septal; reticular tegmental (different parts per nucleus) | Same |

**Structural consequences the source draws:**

1. Both nuclei connect to the same structures but to **different subregions** of each.
2. The hippocampus drives the mammillary bodies directly. The mammillary bodies reach the hippocampus **only through the anterior thalamic nuclei**.
3. The anterior thalamic nuclei are the sole outlet. Any mammillary effect elsewhere passes through them.
4. The hippocampus reaches the anterior thalamus by two routes, one direct and one through the mammillary bodies. A mammillary lesion can therefore **underestimate** the region's normal role, if the direct route can stand in for it.

---

## Two systems

| | **Lateral system**: `DTN` ↔ `LMN` → `AD` | **Medial system**: ventral Gudden ↔ `MMN` → `AV` (+ `AM`) |
|---|---|---|
| Signal | Head direction. `LMN` also has **head-pitch** and **angular-head-velocity** cells (Stackman & Taube 1998) | Cells firing rhythmically in phase with hippocampal theta, correlated most with the **CA1** theta generators (Kocsis & Vertes 1994) |
| Source of the signal | Vestibular information transformed with `DTN`. Not wholly vestibular: visual stimuli influence `LMN` directional tuning | **Descending hippocampal input.** Septal inactivation removes theta from the mammillary bodies but not from the adjacent supramammillary nucleus (Kirk et al.). So the supramammillary nucleus *paces* hippocampal theta and the medial mammillary nucleus *receives* it |
| Causal role downstream | `LMN` signal **leads** the `AD` signal in time. Bilateral, not unilateral, `LMN` lesions abolish `AD` head-direction tuning (Blair, Cho & Sharp 1998, 1999), matching the bilateral projection. `AD` is in turn required for postsubicular head direction (Goodridge & Taube 1997), so an `LMN` lesion also removes it there, one step later | ~75% of `AV` cells fire in synchrony with hippocampal theta (Vertes et al. 2001); theta units are also found in the connected tegmentum |
| Independence from the store | Lesions of the postsubiculum or the **hippocampus** leave anterior-thalamic head direction intact (Golob & Taube 1997), so the signal is generated upstream of and independently of the store | None. The theta is the hippocampus's own rhythm, so this channel adds nothing the store does not already emit, unless the mammillary stage transforms it (open, below) |
| Segregation | **Almost complete** | **Leaky**: a few theta cells in `LMN` and in `AD` |

**Where in the lateral system the attractor sits, and what drives it** (Cullen & Taube 2017, [[wiki/entities/head-direction-system.md]]). The ring attractor is hypothesised to run across the reciprocal `DTN` ↔ `LMN` connections. The evidence is lesion-pattern logic. Lesions upstream (nucleus prepositus, supragenual nucleus) leave the bump **drifting**: the network is intact but untethered. Lesions at or below the attractor abolish directional firing. Visual landmark correction enters at dorsal presubiculum and descends to `LMN`. The "vestibular" label on the input is contested (`T408`). The first central vestibular stage attenuates self-generated head motion by ~70%, so during active behaviour the ring's velocity input must include efference or proprioceptive signals.

**The velocity code changes across the ring's two nuclei** (Shinder & Taube 2014, [[wiki/entities/head-direction-system.md]]). `DTN`: ~75% angular-head-velocity cells, many **asymmetric** (tuned to one turn direction; all 35/35 in Sharp et al. 2001b, ~36% in Bassett & Taube 2001) and **multimodal** (also pitch, translation or heading). `LMN`: ~44% angular-head-velocity cells, **symmetric** (insensitive to turn direction; half speed-up, half speed-down) and **unimodal**. So the signed velocity sits one synapse below the nucleus that drives `AD`, and `LMN`'s velocity cells carry speed only. **(brainstorm)** In a ring model, the unsigned half would act as a gain on the bump shift rather than as its drive. At `DTN`, most cells *lose* velocity tuning under passive rotation (8/12, hand-held), the opposite of what a relayed vestibular-only signal predicts (`T408`).

A possible **third system**: `MMN` → `AM`. `AM` differs from the rest of the anterior thalamus. It has stronger links to anterior cingulate and prefrontal cortex and **no theta-related cells**. With the topographic mammillothalamic map and the cytoarchitectonic variety inside `MMN`, the source leaves room for further functions.

**Two later corrections from the same group** (Jankowski et al. 2013, [[wiki/entities/anterior-thalamic-nuclei.md]]). (i) The "no theta cells in `AM`" premise matches one urethane-anaesthetised study (Vertes 2001). Albo et al. 2003 found theta-modulated cells in `AM` and `AD`, and the authors' unpublished freely moving recordings find them in `AM`. (ii) The two systems are segregated through the mammillary stage, but they **merge one synapse later**. 39% of `AV` head-direction cells fire in theta-rhythmic trains in the preferred direction (Tsanov et al. 2011a). So the heading and theta systems first meet in `AV`, not in retrosplenial cortex. The same review counts ~23% theta-entrained bursters in freely moving `AV`, against the ~75% theta-synchronous figure above from anaesthetised rats.

---

## Lesion evidence

**Animals.** All of it predates any lesion confined to one nucleus. Mammillothalamic-tract lesions disconnect both.

| Result | Detail |
|---|---|
| Impaired | T-maze spatial alternation; radial-arm spatial working memory; water-maze reference memory (contested) and working memory; monkey spatial memory |
| Spared | Conditional learning that pairs an object with a body turn or a location; matching / non-matching to lever position; tasks solved with a fixed spatial response or non-allocentric cues |
| Accounts rejected | Proactive interference and retention-delay sensitivity. Lesions had no effect when interference was raised or delays were lengthened in some studies |
| Account kept | **Failure of rapid allocentric encoding**, i.e. learning a specific location in a cognitive map fast (Vann & Aggleton 2003). Deficits are largest early in training and in one-trial spatial working memory with non-allocentric strategies blocked |
| Severity | Less than hippocampectomy; usually less than anterior thalamic lesions. **Diminishes with training**. Candidate reasons: alternate strategies, or gradual recruitment of the direct hippocampus → anterior thalamus route |
| Where the route cannot be bypassed | Monkey object-in-place (scene) discrimination: fornix, mammillary and anterior thalamic lesions give **equivalent** deficits (Parker & Gaffan 1997). Rat scene task requiring object-place integration: all three lesions give the same abnormality, and it is a **gain** in performance, read as a failure to process all objects in a scene at once |
| Modality specificity | Mammillothalamic-tract lesions impair first acquisition of a *visual* contextual discrimination and spare a formally identical *thermal* one |
| Indirect evidence for the medial system | Selective `AD` lesions impair spatial memory **less** than complete anterior thalamic lesions; `AM`-centred lesions sparing `AD` give mild working-memory deficits; complete anterior thalamic lesions exceed combined `AD`+`AV` lesions in the water maze. The effects **add**, so heading does not account for the whole thalamic deficit |

**Humans.**

| Case | Damage | Memory |
|---|---|---|
| B.J. (snooker cue through the nostril; Dusoir et al. 1990) | Bilateral mammillary bodies, adjacent hypothalamus, pituitary; supramammillary nucleus and mammillothalamic tract possibly | Marked anterograde amnesia. Immediate recall often normal, **delayed recall impaired** (Wechsler Memory Scale-Revised Delayed Memory Index 56). Recognition within normal limits on many tests. **Retrograde memory largely intact.** Impaired at spotting which items in a picture had moved. Positron emission tomography (PET) shows **hippocampal hypoactivity** in the more-damaged hemisphere |
| N.A. (fencing foil through the nostril) | Bilateral mammillary bodies plus left dorsal thalamus | Similar to B.J. |
| Tumour cases | Mammillary region; one also with anterior temporal pole | Moderate anterograde amnesia, delayed recall worst (Delayed Memory 59). Recall worse than recognition; **source and context judgements impaired** |
| Two suprasellar tumours (Kapur et al. 1998) | Mammillary bodies obliterated, slight thalamic disruption | Mild to moderate recall deficits on some subtests; recognition largely intact. "Memory impairment but not amnesia" |
| Thalamic infarcts | Never confined to the tract | Mammillothalamic-tract pathology is the **best predictor** of anterograde amnesia |
| Korsakoff's syndrome (contrast) | Wider diencephalic damage | Much worse general memory, recognition and retrograde memory |

**The clinical pattern.** Needed for normal episodic recall, with deficits that grow with retention interval. Milder than other amnesias, perhaps because the direct hippocampus → anterior thalamus link survives. Pre-injury memory and recognition are relatively spared, which fits the dual-process prediction on [[wiki/concepts/recollection-familiarity.md]]. MRI cannot say whether a case damaged one nucleus or both, so the two systems cannot be separated in patients.

---

## Why diencephalic amnesia exists: the source's three candidates

| Candidate | Source's verdict for the mammillary bodies |
|---|---|
| The diencephalic stage contributes to mnemonic processing through its direct and indirect projections to the medial temporal lobe | **Best supported.** Anterior thalamic lesions depress hippocampal activity (Fos imaging); B.J.'s hippocampal hypoactivity is on the more-damaged side |
| It disconnects the temporal lobe from another site, e.g. frontal cortex | Not excluded |
| It causes widespread cortical dysfunction, independent of the temporal lobe | Not excluded; may explain why mammillary amnesia is more selective than other diencephalic amnesias |

---

## What each system is for: the source's proposals

| System | Proposal | Evidence against or missing |
|---|---|---|
| Lateral (heading) | Episodes are events in a spatial and temporal context, and heading is tightly coupled to place, so heading helps build **contextual scenes**. Stronger version (Burgess 2002): retrieving a spatial episode means **setting a viewpoint**, and heading, via parietal and retrosplenial cortex, lets the system translate allocentric into egocentric representations and back. Fits the relative sparing of context-free recognition | Lesions of the anterior-thalamic part of the head-direction system do **not** destabilise hippocampal place cells; they only add noise (Calton et al. 2003). The decisive lesion has not been run: does a selective `LMN` lesion, which abolishes thalamic heading, reproduce a whole-mammillary spatial deficit? |
| Medial (theta) | Theta as a **significance signal**: hippocampal long-term potentiation is induced best by theta-frequency stimulation, and stimulation on the positive theta phase potentiates. Information arriving with theta is more likely to be stored. Hasselmo et al. 2002: relaying theta helps **separate encoding from retrieval**, reducing interference | The interference prediction (more proactive interference after mammillary damage) has partial support in Korsakoff patients and is contradicted by rat studies. **Redundancy problem:** the anterior thalamus has its own hippocampal input, so a pure theta relay through the mammillary bodies would be redundant. The source says the live question is whether `MMN` processes theta in a way that does not depend on the hippocampus |
| Both together | They interact somewhere downstream, most plausibly retrosplenial cortex or the hippocampal formation (untested). The joint function: **rapid creation of distinct, separate spatial scenes** | Speculative in the source |

---

## How it maps to model components

| Element | Model reading |
|---|---|
| One stage, two channels on shared tracts | A projection that carries a **content variable** (heading) and a **clock** (theta) as separate sub-populations. Each can be removed without the other: bilateral `LMN` lesion for heading, septal inactivation for theta. This is the separability `G54` asks for |
| Lateral chain `DTN` ↔ `LMN` → `AD` → postsubiculum | The integrator's **feedforward estimate path**. A parameter (heading) is computed from self-motion, below and independently of the store, and delivered to it. Hippocampal lesions do not touch it ([[wiki/concepts/path-integration.md]], [[wiki/concepts/reference-frame-transformation.md]]) |
| Medial chain CA1 → subiculum → `MMN` → `AV` | The store's **phase signal exported** to a downstream module. This is the "who sets the phase for the receiver?" open problem on [[wiki/concepts/encoding-retrieval-alternation.md]]: the clock leaves the hippocampus by a dedicated relay, and ~75% of the receiving nucleus is locked to it |
| No return projection | A **one-way** stage. The store cannot write to it, so its signal cannot be contaminated by the store's state |
| Additive lesion effects | Two components, each with a partial cost, whose sum looks like one function. A machine ablation that removes a whole module would report one function here too |

**(brainstorm) A receiver needs the sender's clock to know when the sender's content is valid.** If the medial system's job is to deliver the hippocampal theta phase to the anterior thalamus, the thalamus can gate its own plasticity on the store's encode half-cycle without reading the store's content. A machine version: a store exports a 1-bit or phase variable `φ(t)` on a separate wire. Every consumer updates on store output only when `φ` is in the write half. This is cheap. It also makes the consumer's learning schedule a property of the edge rather than of the consumer, the same conclusion as the opposite plasticity rules on the two tracts into the anterior thalamus ([[wiki/entities/anterior-thalamic-nuclei.md]]). Untested in the source. The redundancy objection (the thalamus already has theta from the direct path) applies.

**(brainstorm) Heading plus a write-clock is the minimum to file a scene under a viewpoint.** The source's joint function, "rapid creation of distinct, separate spatial scenes", decomposes into two inputs a fast store needs per write: *which way am I facing* (so the stored scene is indexed by viewpoint and two views of one place do not collide) and *is this a write cycle* (so the write is not contaminated by retrieval). Read as a design rule for `G39`: anchoring a retrieved structure needs a frame parameter that the store did not produce. The mammillary lateral system is that parameter's supply line, and it survives hippocampal loss.

---

## Limitations

- **No nucleus-selective behavioural lesion exists.** Every behavioural claim about the two systems is inferred from anterior thalamic sub-lesions, whose targets also receive direct hippocampal input.
- **Clinical lesions are whole-structure and contaminated.** Supramammillary, hypothalamic, pituitary or thalamic damage accompanies every case, and MRI cannot resolve the nuclei.
- **The theta-relay function is untested.** No study removes the medial mammillary theta while sparing the direct hippocampal theta path into the thalamus.
- **2004 review.** The `LMN` causal results and the theta-cell counts come from the late 1990s and early 2000s rat literature. Later sources on [[wiki/entities/anterior-thalamic-nuclei.md]] supersede some of the thalamic detail.
- **Same lab as the other Papez-network pages.** Not an independent check on them.

---

## Connections

- **[[wiki/entities/anterior-thalamic-nuclei.md]]** — the sole outlet of both mammillary systems, split by nucleus: `LMN` drives `AD`'s head-direction signal (bilaterally, and ahead of it in time), `MMN` feeds `AV`, where ~75% of cells follow hippocampal theta, and `MMN` → `AM` may be a third system. Selective `AD` lesions cost less than whole anterior-thalamic lesions, which is the evidence that the two mammillary inputs add.
- **[[wiki/entities/hippocampal-diencephalic-cingulate-network.md]]** — the network in which this structure is the one-way stage with a single target; this page splits that stage into a heading channel and a theta channel that share every tract but reach different subregions.
- **[[wiki/entities/subiculum.md]]** — the origin of both afferent sets, split by subfield: rostral subiculum (via the postcommissural fornix) → medial nucleus, pre-/para-/postsubiculum → lateral nucleus. The postsubiculum is also downstream of the lateral system through `AD`, which closes a heading loop that has no hippocampal stage.
- **[[wiki/concepts/path-integration.md]]** — the lateral system is the integrator's vestibular front end: `LMN` with the dorsal tegmental nucleus of Gudden turns vestibular signals into heading, and holds the angular-head-velocity and head-pitch cells an integrator needs as input. Its signal survives hippocampal lesions, so the estimate is computed outside the store.
- **[[wiki/concepts/encoding-retrieval-alternation.md]]** — the medial system answers part of that page's "who sets the phase for the receiver?" problem: hippocampal theta, driven from CA1, is relayed through `MMN` to `AV`. The relay was proposed to separate encoding from retrieval (Hasselmo et al. 2002), and its interference prediction is only partly supported.
- **[[wiki/concepts/recollection-familiarity.md]]** — the clinical anchor for the dual-process prediction: B.J. and the tumour cases lose delayed recall and source/context judgements and keep recognition, the familiarity-sparing profile predicted for damage anywhere on the hippocampal–mammillary–anterior-thalamic route.
- **[[wiki/concepts/reference-frame-transformation.md]]** — Burgess's viewpoint proposal, the lateral system's suggested episodic role: heading from this chain, via parietal and retrosplenial cortex, sets the transform between allocentric and egocentric scene representations. It is the parameter that a transform bank consumes, and it is supplied from outside the bank.
- **[[wiki/entities/retrosplenial-cortex.md]]** — the source's best candidate for where the heading and theta systems meet, and the cortical site of the allocentric↔egocentric translation the lateral system is proposed to feed. Neither the meeting point nor the translation was tested in the source. A later review puts the first meeting point earlier, in `AV`'s head-direction-by-theta cells (Jankowski et al. 2013).
- **[[wiki/entities/bb-model.md]]** — the implemented form of the lateral system's proposed job: its head-direction population lists `LMN` among its anatomical sources and gates the transformation bank, and removing that input reproduces the mammillary clinical profile (anterograde amnesia, recollection lost, familiarity spared) with both stores intact.
- **[[wiki/entities/head-direction-system.md]]** — the full chain the lateral system sits in. `DTN` ↔ `LMN` is its hypothesised attractor, placed there because upstream lesions leave the bump drifting rather than abolished. The source also questions whether the lateral system's input is vestibular at all during active movement (`T408`).
- **[[wiki/concepts/cognitive-map.md]]** — the behavioural deficit is in rapid allocentric encoding, i.e. placing a location in a map in one trial. Incremental fixed-response learning is spared, and the deficit fades with training.
