# Posterior Cingulate Cortex — One Name Over Three Regions, and the Only Cortical Hub That Cannot Be Lesioned

**The caudal cingulate expanse (Brodmann areas 23, 31, 29, 30; ~18 cm² unfolded in humans), which the imaging literature treats as one default-network node and which anatomy, resting-state parcellation, task meta-analysis, non-human-primate single units and human intracranial recording independently split into **three**: a **dorsal PCC** coupled to frontoparietal/executive networks and carrying decision variables, a **ventral PCC** coupled to the default network and carrying autobiographical retrieval, and **retrosplenial cortex** coupled to the medial temporal lobe and carrying spatial processing. Two facts make this more than a parcellation refinement. The **precuneus (area 7m) is not cingulate cortex at all** and retrosplenial cortex does not connect to it, while dorsal and ventral PCC do — so the "PCC/precuneus" of the imaging literature is a union of four regions with three connectivity profiles. And the region has **no lesion literature**, not because nobody looked but because a dual blood supply from the posterior and middle cerebral arteries plus a deep midline position make focal damage nearly impossible — the causal instrument every other cortical function claim rests on is denied by vascular anatomy.**

> **Provenance.** Foster, Koslov, Aponik-Gremillion, Monko, Hayden & Heilbronner 2023, *A tripartite view of the posterior cingulate cortex*, Nat. Rev. Neurosci. 24(3):173–189, doi:10.1038/s41583-022-00661-x (`raw/foster-2023-tripartite-view-of-posterior-cingulate-cortex.md`). A Perspective, not a primary study: it synthesises non-human-primate tract tracing, human cytoarchitecture and sulcal morphometry, receptor autoradiography, resting-state and precision (7 T, repeated-session individual) parcellation, task meta-analyses, macaque single units and human intracranial electrocorticography/stereo-EEG, and proposes the tripartite division as the reconciliation. Every subregional functional assignment below is a *re-reading* of studies that mostly did not use these borders — the authors say so.

**Why this earns a page.** [[wiki/entities/default-mode-network.md]] carries "PCC/Rsp" as a single hub, and the wiki's open problem list on that page already flags that the posterior medial cortex fractionates. [[wiki/entities/retrosplenial-cortex.md]] split areas 29/30 off from 23/31 on connection density. This source supplies the other half of that split — what areas 23 and 31 are, and that they are *two* things — and is the node-definition fix `T267` and `T256` were both waiting on.

---

## The parcellation

| Subregion | Areas | Position | Share of posterior cingulate gyrus |
|---|---|---|---|
| **dorsal PCC** (`dPCC`) | dorsal + anterior 23, 31 | Below the marginal ramus of the cingulate sulcus, anterior to the ventral branch of the splenial sulcus | ~2/3 |
| **ventral PCC** (`vPCC`) | ventral + posterior 23, 31 | Posterior/inferior, wrapping the splenium | ~1/3 |
| **retrosplenial cortex** (`RSC`) | 29, 30 | Chiefly *inside the callosal sulcus*; its rostrocaudal extent spans the dPCC's anterior border to the vPCC's inferior border | — (not on the gyral surface) |
| **precuneus** | 7m | Beyond the splenial sulcus | **Not cingulate cortex.** PCC + precuneus = posterior medial cortex (`PMC`) |

**Boundaries.** Rostral border with mid-cingulate cortex ≈ medial aspect of the central sulcus; caudal border at the convergence of the parahippocampal gyrus and parieto-occipital sulcus. No overt sulcal boundary separates dPCC from vPCC — the **infra-marginal sulcus**, a tertiary sulcus present in humans and some non-human primates, is the one reproducible landmark, sitting 0.5–1 cm posterior to the PCC–MCC boundary and usually superior to the callosal isthmus.

**Receptor architecture** *(`L4`, carried for whoever chooses a realization).* dPCC has higher GABA<sub>B</sub>, muscarinic M<sub>3</sub> and 5-HT<sub>1A</sub> density and lower M<sub>1</sub> density than vPCC; the whole PCC has higher acetylcholine-receptor binding than anterior cingulate cortex. The functional interpretation of these differences is unknown and the authors say so.

**The cytoarchitectural test has not been run.** The Julich–Brain Atlas has not yet reported on the PCC. The tripartite claim's sharpest prediction — a cytoarchitectural demarcation of human areas 29/30 — is outstanding.

---

## Connectivity, by subregion

Non-human-primate tracer injections; most PCC–thalamic projections are reciprocal.

| | Thalamic input | Cortical | Network membership (human resting state) |
|---|---|---|---|
| **dPCC** | Posterolateral (somatosensory), central (basal-ganglia feedback), mediodorsal (prefrontal-coupled), ventral anterior + ventral lateral (basal ganglia / motor), anterior dorsal/ventral/medial (limbic) | Most prefrontal input of the three; reciprocal with precuneus; possibly primary somatosensory, V3, MST, auditory association (disputed — Parvizi et al. report *no* primary sensory connections, Morecraft et al. do) | Frontoparietal / executive control |
| **vPCC** | Anterior medial (limbic/memory), pulvinar, lateral dorsal (memory) | Fewer prefrontal, more temporal (non-hippocampal) than dPCC; reciprocal with precuneus | Default mode; also a memory/association network with medial temporal lobe + inferior parietal lobule |
| **RSC** | **Anterior thalamic nuclei** ([[wiki/entities/anterior-thalamic-nuclei.md]]), medial pulvinar | Most hippocampal, parahippocampal **and dorsolateral prefrontal** input of the three; **does *not* connect with precuneus** | Dissociable from both, in group and in precision individual parcellation |

Shared by the whole PCC: dorsolateral prefrontal cortex, anterior cingulate, lateral parietal, temporal pole, entorhinal cortex.

**The gradient the connectivity states.** dPCC → frontal; vPCC → frontal *and* temporal; RSC → medial temporal. Human tractography recovers the same dorsal/ventral pathway convergence. This is the only place in the wiki where a single named "hub" is resolved into three nodes by three different afferent sets **on the same tissue**.

---

## Comparative anatomy — the transfer warning

Primate areas 23/31 are distinguished from 29/30 by a **higher count of layer IV stellate cells**. Rodents have no cortical area with that count, and therefore, on the traditional view, **no dPCC or vPCC homologue at all** — only a large retrosplenial region occupying much of the posterior medial surface.

Consequences, and they are severe for a wiki that reads rodent circuits:

- Every rodent result about "posterior cingulate cortex" is a result about retrosplenial cortex. [[wiki/entities/retrosplenial-cortex.md]] already carries the inverse of this from Vann et al. 2009; the two sources agree.
- The two subregions that carry the **executive** and **mnemonic** assignments are the two that may be primate-only. The wiki's rodent-derived control and memory circuitry has no access to them.
- Conversely the **only** subregion with a rodent model is the one whose human anatomical definition is least settled (see Limitations).

---

## Function, by subregion

| | dPCC | vPCC | RSC |
|---|---|---|---|
| Assignment | Executive / decision | Mnemonic / contextual | Spatial |
| Memory task | **Item recognition**; familiarity even outside memory contexts; long-term-memory-guided attention | **Autobiographical recall**, effortful retrieval, semantic processing, self-and-other representation | Mnemonic reinstatement (integrative-memory model) |
| Visual category | Face-selective patch around the splenial sulcus | Place-selective (medial place area, extending into parieto-occipital sulcus) | Scene perception, navigational coding |
| Decision-making | Subjective value, risk/variance, uncertainty, context prediction errors, value updating, **change points**, explore-vs-exploit switching. Meta-analytically the *only* PCC subregion consistently engaged | Rare | Rare |
| Framework placement | Anterior temporal (`AT`) network of the `PMAT` framework; familiarity generation/evaluation in the integrative-memory model | Posterior medial (`PM`) network; recollection | Hub in both |

The dissociation survives the strongest available control: **the same stimuli** probed under autobiographical-recall vs item-recognition instructions still separate vPCC from dPCC. Human intracranial recording reproduces it directly — dPCC sites are selective for executive tasks (visual search, number addition) against vPCC sites, and the majority of dPCC *single units* in the same study fired selectively for specific executive conditions.

**The encoding/retrieval sign flip.** PCC activity is *suppressed* during episodic encoding — more suppressed for items that will later be remembered — and *enhanced* during successful retrieval. The locus of the flip moves between subregions depending on which mnemonic contrast is run, which is itself an argument for the parcellation.

---

## The dPCC's decision variable is probably not value

Two results in tension across the same region, both from macaque single units:

- dPCC firing tracks the **variance of risky offers**, which varies with subjective but not objective expected value — placing it in the "subjective value network" alongside ventral striatum and ventromedial prefrontal cortex.
- A later study that explicitly dissociated **value** (preference for a choice) from **salience** (absolute deviation of an outcome from baseline, unsigned) found **salience the better explanation** of dPCC firing. Neurons in dorsal anterior cingulate encode both; dPCC responses are dominated by salience.

This contradicts [[wiki/concepts/subjective-value.md]], where posterior cingulate is one of three regions whose blood-oxygen signal carries a hyperbolically discounted value matching each subject's own behavioural `k` — logged as [[wiki/empirical-tensions.md]] T382. The authors themselves use the salience reading to explain why PCC appears in far fewer human subjective-value studies than ventral striatum and ventromedial prefrontal cortex do.

---

## The electrophysiology, and the muscimol paradox

**Timescale is the dPCC's most distinctive physiological property.** Post-trial reward encoding lasts a few hundred milliseconds in dorsal anterior cingulate and **several seconds — often several trials** — in dPCC. Inter-trial activity is not idle: it records the previous trial's outcome and predicts (the authors say causes) the next behavioural adjustment. This is the single-unit form of the long **temporal receptive window** reported for PCC and precuneus in humans.

**Tonic deactivation is conserved to the single-unit level.** In a delayed-saccade task, macaque dPCC firing is lower during the task period than in the inter-trial interval, and lower still under active working-memory maintenance. Activity drops after task switches and climbs with trials since the last switch. Human high-frequency activity (70–200 Hz) falls during target detection, visual search, mental calculation and sustained attention, and **deeper suppression predicts better performance**. Suppression arrives late — >300 ms, after the lateral temporal default node and after the dorsal attention network's ~200 ms engagement, before medial prefrontal cortex.

**And then the inactivation result runs the other way.** dPCC neurons signal performance errors with activity peaking around the error — consistent with the "activity is inimical to performance" reading. But **muscimol inactivation of dPCC *reduced* learning**. So the error-locked activation is a *consequence of the repair process*, not the fault. Converging: tonic dPCC activity is *higher* on explore trials (more learning) than exploit trials.

This is the most architecturally important result in the source. The default-mode literature's standard reading of deactivation — the internal mode getting out of the way — predicts that silencing the region should help or do nothing. It hurts.

**Oscillations.** Resting PCC has an intrinsic **theta** peak (4–7 Hz), distinct from the neighbouring occipital alpha (8–10 Hz), with theta-phase to high-frequency-amplitude cross-frequency coupling — the same profile as hippocampus. **vPCC–medial temporal theta synchronisation precedes** vPCC high-frequency activation during autobiographical retrieval and item recall, which is the directional evidence for vPCC's place in the medial temporal memory system.

---

## Why there is no causal literature

| Obstacle | Detail |
|---|---|
| **Dual blood supply** | Posterior *and* middle cerebral arteries, plus one of the most densely vascularised regions of the brain — ischaemic stroke is rare (in the neighbouring precuneus, <1% of stroke cases) |
| Deep midline position | Focal damage is anatomically improbable; insults that reach it typically take the cingulum bundle or corpus callosum with them, so the deficit is a disconnection |
| Non-invasive electrophysiology cannot reach it | Magneto- and electroencephalography cannot isolate PCC given depth and sensorimotor proximity; intracranial coverage is clinically, not experimentally, determined |
| Stimulation results are heterogeneous | Ranges from no subjective report at all to somatosensory/motor effects (plausibly current spread to adjacent motor and visual cortex) to derealization and dissociated sense of self (area 31), with small samples and epilepsy confounds. The one quantified behavioural effect: stimulation during word-list encoding worsened subsequent recall and raised hippocampal gamma power, with the gamma increase predicting the recall loss |

**This is a measurement fact with an inferential consequence.** The absence of a PCC lesion syndrome is why no unifying theory formed, which is why nobody ran the targeted experiments, which is why the region stayed unexplained — the authors name this explicitly as the reason the anterior cingulate has a computational literature and the posterior does not. The "spotlight effect" they diagnose (human imaging studies the PCC's memory functions, macaque electrophysiology studies its decision functions, and each begets more of itself) is the same bias one level up.

---

## The unifying proposal, and its analogy

The authors' single functional statement for the whole region:

```
lateral parietal cortex : integrates SENSORY evidence     → action
posterior cingulate     : integrates INTERNAL / MNEMONIC  → future actions and strategies
                          evidence (vPCC supplies it,
                          dPCC spends it)
```

with the timescale falling out of the substitution: sensory evidence is about the present and immediate past, mnemonic evidence about the remote past and distant future, so the region that integrates the second must have the longer integration window — which is measured.

**(brainstorm) This is a two-stage architecture with the stages named and separately addressable, which is exactly what the wiki's retrieval-augmented systems lack.** [[wiki/entities/default-mode-network.md]] already supplies a store (medial temporal subsystem) and a constructor (dorsomedial prefrontal) that do not talk directly and meet on hubs. Read with this page, the hub is not one bus: **vPCC is the store's port and dPCC is the consumer's port, and they are in different large-scale networks.** So the interface between an episodic store and a decision process is not a shared buffer but a *pair* of buffers with a gradient between them — and the anatomy says which end the prefrontal cortex reads (dPCC) and which end the temporal lobe writes (vPCC). No wiki architecture separates the write port from the read port of its retrieval interface.

**(brainstorm) "Mnemonic decision" is a task type the wiki's evaluation inventory has no instance of.** Every decision benchmark here presents its options; every memory benchmark here scores recall. The claim needing a test is that one mechanism spans them — that item recognition *is* a decision made on retrieved evidence, which is why a decision region carries it. A generated task would fix the decision structure and vary only whether the evidence arrives from perception or from retrieval, and score whether the same internal mechanism is used. Nothing in the wiki does this.

**(brainstorm) The muscimol paradox generalises the `G90` correction.** `G90` asks for an internally generated mode with an arbitrator, and the wiki's working picture has the internal mode *suppressed* for external tasks. The dPCC data say: suppressed, correlated with performance, **and required**. An architecture that implements the internal mode as a subsystem gated off during task execution cannot produce this; one that implements it as a slow, always-running monitor whose *output bandwidth* is throttled while its computation continues can. The distinguishing experiment is exactly the one run here — ablate during the task where the region is most suppressed, and see whether performance improves or degrades.

**(brainstorm) A salience-dominated, seconds-to-trials-long, post-outcome signal is a learning-rate controller, not a value estimate.** Unsigned deviation from baseline, integrated over a window far longer than one trial, rising at change points and on explore trials, and required for learning — that is the signature of a quantity that sets *how much to update*, not *what to choose*. [[wiki/concepts/neuromodulatory-metaparameters.md]] holds the wiki's account of learning-rate control; nothing there has a cortical carrier with a multi-trial memory of outcome surprise.

---

## Limitations

| Limit | Consequence |
|---|---|
| **This is a re-reading, not a re-analysis** | Most cited studies did not use these borders, or used different ones; the authors interpret prior results "with these divisions in mind rather than the original designations of the authors". No study in the source tests dPCC against vPCC against RSC in one design with one parcellation — except the one intracranial study that tests dPCC against vPCC |
| **The RSC is the weakest leg and the authors say so** | Human RSC demarcation "varies widely"; contemporary anatomy differs greatly from common translations of Brodmann's maps; RSC can be **inadvertently excised** by cortical-surface reconstruction pipelines that exclude the corpus callosum. The tripartite view is explicitly least secure exactly where the wiki's [[wiki/entities/retrosplenial-cortex.md]] page is most invested |
| No cytoarchitectural confirmation exists | The Julich–Brain Atlas has not reported on PCC; the tripartite division rests on connectivity and function plus older cytoarchitecture |
| fMRI parcellation is haemodynamic | Sensitive to vascular organisation, which in *this* region is unusual (dual supply, dense vascularisation) — so the boundary most likely to be a vascular artefact is being drawn in the region with the most distinctive vasculature |
| The species split is a confound, not a control | Macaque work targeted dPCC (area CGp) almost exclusively; human intracranial coverage is clinically determined. The apparent human-memory / macaque-decision species difference is, on the authors' reading, an absence of experiments |
| No computational theory | The authors' closing ask is for one; the region has no model, and the "integration of internal evidence" proposal is stated in words with no equation, no update rule and no free parameter |
| The dPCC/vPCC pair may be primate-specific | Which removes the rodent preparation from two-thirds of the tripartite claim, and leaves optogenetics and cell-type tools available only for RSC |

---

## Connections

- **[[wiki/entities/default-mode-network.md]]** — the node-definition fix that page's open-problem list asks for: its single "PCC/Rsp" hub is three regions in three different large-scale networks (dPCC ↔ frontoparietal, vPCC ↔ default, RSC ↔ medial temporal), which reframes the network's central hub as a *pair of ports* — the store's write port and the decision layer's read port — rather than one shared bus (`T267`).
- **[[wiki/entities/retrosplenial-cortex.md]]** — the complementary half of the same boundary: that page establishes what areas 29/30 are and that 23/31 are not them, this one establishes that 23/31 are themselves two regions, and both sources agree the rodent posterior cingulate is entirely retrosplenial — so a rodent result can never speak to the executive or mnemonic subregion.
- **[[wiki/concepts/node-definition-problem.md]]** — the most consequential instance in the wiki: one canonical hub, resolved into three nodes by three afferent sets, with a fourth region (precuneus, area 7m) that is not cingulate cortex and that retrosplenial cortex does not connect to at all, while the label "PCC/precuneus" has been carrying all four.
- **[[wiki/concepts/subjective-value.md]]** — the same voxels given a different variable: where that page's posterior cingulate carries a hyperbolically discounted subjective value matching each subject's own `k`, macaque single units in the same region are better explained by unsigned salience once value and salience are dissociated (`T382`).
- **[[wiki/concepts/function-to-structure-inference.md]]** — the causal instrument denied by vascular anatomy rather than by inferential logic: a dual blood supply and dense vascularisation make focal damage nearly impossible, so this region's function claims are correlational *by construction*, and the absence of a lesion syndrome is itself what prevented a theory forming.
- **[[wiki/concepts/activity-baseline.md]]** — the same tissue's metabolism read from the other side: that page's selectively vulnerable, 40%-above-mean posterior cingulate is here the most densely vascularised and dual-supplied cortex in the brain, so the high tonic rate and the protection against focal ischaemia are properties of one vascular arrangement.
- **[[wiki/entities/anterior-thalamic-nuclei.md]]** — the thalamic input that defines the retrosplenial subregion against the other two, which receive posterolateral/central/mediodorsal (dPCC) and anterior medial/pulvinar/lateral dorsal (vPCC) instead — three subregions separated by three thalamic sources on one cortical expanse.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — a candidate cortical carrier for the update-size parameter: an unsigned, salience-dominated, post-outcome signal integrated over seconds-to-trials, rising at context change points and on explore trials, whose inactivation *reduces* learning.
- **[[wiki/concepts/parallel-timescale-streams.md]]** — the anatomical end of the timescale gradient, with a mechanism attached: dorsal posterior cingulate reward responses last several seconds and several trials where dorsal anterior cingulate's last a few hundred milliseconds, which the authors derive from the kind of evidence each integrates rather than from position in a hierarchy.
- **[[wiki/entities/salience-network.md]]** — a name collision with a real distinction: that network's salience is a stimulus-relevance detector that *switches* the default network off, while the salience better explaining dorsal posterior cingulate firing is an unsigned deviation of a decision *outcome* from baseline, carried by a region that is itself part of the system being switched.
- **[[wiki/concepts/cognitive-control.md]]** — where the executive subregion lands: dorsal posterior cingulate tracks uncertainty, context prediction errors, change points and explore-vs-exploit switching, and drops its firing after task switches while climbing with trials since one — a control-adjacent signal in a region the control literature classifies as task-negative.
- **[[wiki/concepts/event-segmentation.md]]** — the decision-side reading of the same boundary code: dorsal posterior cingulate activity correlates with change points in context and predicts switch decisions in bandit and foraging tasks, which is that page's segmentation signal read out as a policy variable rather than as a memory index.
