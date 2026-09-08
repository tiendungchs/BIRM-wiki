# Lateral Frontoparietal Network — Where the Relational Supermodule Sits

**Three cortical regions — rostrolateral prefrontal cortex (RLPFC), dorsolateral prefrontal cortex (DLPFC) and inferior parietal lobule/sulcus (IPL/IPS) — plus the long-range white matter joining the first and third. Proposed as the anatomy of higher-order relational thinking: the same set is recruited whenever a relation between relations must be evaluated, across memory, reasoning, decision-making and perception. Its RLPFC↔IPL link is the one connection in the set with no macaque analogue.**

> **Provenance (third ingest).** Hobeika, Diard‐Detoeuf, Garcin, Levy & Volle 2016, *General and specialized brain correlates for analogical reasoning: a meta-analysis of functional imaging studies*, Human Brain Mapping 37(5):1953–1969 (`raw/hobeika-2016-analogical-reasoning-metaanalysis.md`). The first two ingests cite it second-hand; this is the primary. A coordinate-based activation-likelihood-estimation (ALE) meta-analysis over **27 experiments, 40 contrasts, 506 subjects, 351 activation foci** — the only quantitative map on this page, and the only source that separates the analogy network by *content domain* and by *task format*. It adds the sections **The quantitative map** and **Matrix problems are not analogies**, and opens `T335`.

> **Provenance (second ingest).** Parsons & Davies 2022, *The neural correlates of analogy component processes*, Cognitive Science 46(11):e13116 (`raw/parsons-2022-analogy-component-processes.md`). A review asking a narrower question than Vendetti & Bunge: not *where* relational thinking runs, but whether the **subprocesses** the structure-mapping architectures assume (access, mapping, inference, schema induction) have separable neural correlates. It adds the VLPFC node below and the section **The four subprocesses** — and its main finding is negative.

> **Provenance.** Vendetti & Bunge 2014, *Evolutionary and developmental changes in the lateral frontoparietal network: a little goes a long way for higher-level cognition*, Neuron 84(5), 906–917, doi:10.1016/j.neuron.2014.09.035 (`raw/vendetti-2014-lateral-frontoparietal-evolution-development.md`). A Perspective, not a primary study: every comparative and developmental result below is reported second-hand, and the authors are reviewing their own lab's fMRI series (Wendelken, Bunge and colleagues). Two of the load-bearing developmental results — the longitudinal white-matter finding and the age×tract partial correlation — are cited to an unpublished dissertation (Whitaker 2012). No effect sizes are given for the Neurosynth meta-analysis.

---

## The three nodes and their division of labour

| Node | Proposed function | The measurement that assigns it |
|---|---|---|
| **IPL / IPS** | Represents the *first-order* relation itself | Activation scales with the **number** of relations to be considered (Crone et al. 2009; Hampshire et al. 2011; Watson & Chatterjee 2012); higher for **specific** relations ("the green ball is heavier than the orange ball") than for general association ("the green and orange balls are associated") (Wendelken & Bunge 2010) |
| **RLPFC** (frontopolar, ≈ Brodmann area 10) | Compares / integrates **several sets** of relational representations — the second-order operation | Selectively engaged by second-order > first-order contrasts at *identical stimulus displays* (Wendelken et al. 2012); **not** by difficulty (see below) |
| **DLPFC** | Working-memory manipulation, interference suppression, response selection — a general support tier | Activation scales with **task difficulty** across paradigms, including relational ones (Kroger et al. 2002; Cho et al. 2010; Krawczyk et al. 2010a) |
| **VLPFC** (≈ BA 44/45/47) — *the fourth node, added by Parsons & Davies 2022* | **Controlled access to semantic content**: anterior (BA 47) retrieves stored semantic knowledge, posterior (BA 45) *selects* among what retrieval returns | Tracks the **associative strength** between the words of a verbal analogy while RLPFC tracks integration demand in the same subjects and trials (Bunge et al. 2005); activates more for verbal-semantic than for visuospatial analogies in meta-analysis (Hobeika et al. 2016); has direct tracts to inferior/lateral temporal cortex and medial temporal lobe (Petrides & Pandya 2002; Croxson et al. 2005; Barredo et al. 2015) |

The VLPFC row is not a fourth function bolted on — it is the node that makes the network's *inputs* explicit. RLPFC integrates relations, IPL holds them, DLPFC pays for the effort, and VLPFC decides **which stored content the other three operate on**. Vendetti & Bunge's three-node account has no term for that, and every wiki architecture that "retrieves then maps" is asserting this edge without naming it ([[wiki/entities/macfac.md]]).

**The convergence result.** Neurosynth reverse inference over the term *relational* (46 studies spanning memory, reasoning, decision-making and higher-level perception) returns RLPFC, DLPFC and IPL/IPS as the voxels reported more selectively with *relational* than with any of 524 other terms; forward inference additionally returns hippocampus, insula and posterior cingulate. This is the wiki's first **anatomical** evidence for the supermodule claim in [[wiki/concepts/relational-reinterpretation.md]], which had argued for a shared relational competence purely from the fact that the same first-order/higher-order behavioural profile recurs in every domain. Convergence across task domains in a term-based meta-analysis is weak evidence — the term is applied by the original authors, not by the analysis — but it is evidence of the right *type*, and there was none before.

---

## The quantitative map: one domain-general node with domain-oriented flanks

Hobeika et al. 2016. Cluster-forming threshold `p < 0.001` uncorrected, cluster-level `p < 0.05`, 1000 permutations; contrast maps at `p < 0.05` uncorrected, ≥100 voxels, 10,000 permutations.

| Map | Peak clusters |
|---|---|
| **Global** (analogy + matrix, 27 experiments) | Left rostral inferior frontal sulcus/gyrus **BA 10** (5192 mm³, ALE 0.034, MNI −48/44/−8, **FWE-corrected**) extending to BA 47/45/46 and left insula; right posterior IFG/MFG BA 9/44 (FWE); right insula BA 13 (FWE); bilateral MFG BA 9; medial SFG/cingulate BA 6/32; bilateral superior parietal BA 7; left inferior parietal BA 40; bilateral posterior MFG/SFS BA 6 |
| **Semantic analogy** | A **left-lateral prefrontal** network only: rostrolateral IFG/MFG BA 10/47 and BA 46 (primary), posterior IFG BA 44, SFG BA 9 and BA 8, bilateral caudate head |
| **Visuospatial analogy** | Left rostrolateral IFS/IFG BA 10/47/46 (primary), right MFG BA 9, right anterior insula, cerebellum |
| **Matrix problems** | A large **bilateral** fronto-parietal network, 8 clusters: bilateral parietal BA 7/40 and precuneus BA 7/31 (largest), bilateral posterior IFS BA 6/44/9 with right predominance, posterior SFS BA 6/8, bilateral medial PFC, right anterior insula, left cingulate BA 32 |

**The left rostrolateral region of interest.** Semantic and visuospatial analogy maps overlap in one cluster — the rostral end of the left inferior frontal sulcus, BA 10 — and it is the cluster that survives voxel-level family-wise-error correction in the global map. The **right** rostrolateral cortex is not significant in either domain map. This upgrades the page's central claim from convergence-across-terms (Neurosynth, weak) to convergence-across-experiments with a coordinate and an effect: `n = 27` studies, and the same voxels appear whether the relation is *nose:smell :: mouth:taste* or a change of shape and size.

**Domain is carried by flanking regions on a dorsoventral axis, not by the integrator.** The subtraction maps place the two content feeds on opposite sides of the shared cluster:

| Contrast | Region | Reading |
|---|---|---|
| Semantic > visuospatial | Left anterior IFG **BA 47**, *ventral and posterior* to the shared cluster; plus left rostromedial BA 10 and left IFS BA 46 | Controlled semantic retrieval and selection — the VLPFC node above ([[wiki/concepts/controlled-semantic-cognition.md]]) |
| Visuospatial > semantic | Left anterior MFG **BA 10**, *dorsal* to the shared cluster; plus bilateral posterolateral PFC, left SPL/IPL/intraparietal sulcus, right fusiform BA 37 | Spatial-relation formation, spatial attention, and visual imagery of the schema |

**Why this is the architecturally interesting half.** The integrator is *not* re-instantiated per domain; what changes is which posterior/ventral store fans into it. That is `G21`'s switchable fan-in composer, measured: one fixed second-order site, content-specific afferents, and the domain difference living entirely in the afferents. The authors' own conclusion is the same — "the connectivity of this region with domain-oriented regions has a crucial role." A machine reading `(brainstorm)`: a single shared relational head over per-modality encoders should reproduce the whole pattern, and the ablation that tests it is per-domain — remove the semantic encoder and visuospatial analogy should survive, remove the head and neither should.

**The three networks the global map decomposes into.** Fronto-parietal control (DLPFC + posterior parietal), **salience** (anterior insula + posterior IFG + anterior cingulate), and **dorsal attention** (posterior SFS/frontal eye fields, premotor, SPL). The insula is bilateral and FWE-significant on the right — an unexpected node for a reasoning network, and the one this page's three-node account has no term for at all ([[wiki/entities/salience-network.md]]). Under the switching account the salience network would be what *hands control* to the fronto-parietal system and suppresses the default-mode network for the duration of the analogy, which is the mechanism behind the negative default-mode/accuracy correlation reported below.

---

## Matrix problems are not analogies, at least not to this network

The sharpest result on this page for anyone scoring a machine. Holding domain constant at *visuospatial*, four-term analogy and `3×3` matrix problems dissociate:

| Direction | What comes out |
|---|---|
| **Visuospatial analogy > matrix** | The left rostrolateral cluster (BA 10, extending 9/45/46), in the same location as the analogy-general region of interest — **and one cerebellar cluster. Nothing else.** |
| **Matrix > visuospatial analogy** | Bilateral posterior/dorsolateral PFC (BA 6/44/9, right-predominant), posterior SFS (BA 6/8), medial PFC (BA 9/32), left IPL/SPL (BA 7), right precuneus (BA 7/19/31), postcentral gyrus (BA 2/3), plus a *medial* left rostral BA 10 cluster distinct from the analogy region |

So the region that is present in **every** analogy contrast and causally required for analogy is the region matrix problems do not recruit; and what matrix problems add is the attention and executive control machinery. The proposed functional split inside the left frontal pole — a **ventral** site at the end of the inferior frontal sulcus for analogy, a **medial** site at the end of the superior frontal sulcus for matrix-format relational reasoning — is the authors' own and flagged by them as weak, since the medial cluster appears only in the subtraction and not in the matrix task map itself.

**This is opened as `T335`, at `L0-INSTR`,** because it puts the wiki's whole matrix-format benchmark stack ([[wiki/entities/raven.md]], [[wiki/entities/pgm.md]], [[wiki/entities/arc-agi.md]]) on a construct that the only quantitative neural comparison says is not the analogy construct. The source names three confounds that could dissolve it, and the first is serious: **response mode is collinear with format**. All but two matrix studies used forced-choice completion, all but four analogy studies used evaluation — and Wendelken et al. 2008b already showed left rostrolateral cortex engaged by *evaluating* an analogy and not by *completing* one, with completion recruiting medial prefrontal cortex, which reproduces this entire dissociation with format held constant. The other two: matrix items display more terms, so visuospatial load is higher; and more terms means more relations to integrate, which is the fronto-parietal control network's own load variable. **The discriminating experiment is cheap and unrun** — cross format with response mode on matched material.

> **The machine-side version is cheaper still `(brainstorm)`.** Train a solver on one format and test transfer to the other, both directions, against within-format transfer as the baseline. Under Position A the two formats are one construct and transfer should be near-free; under Position B a matrix-trained solver should be missing precisely the second-order comparison step. No wiki benchmark reports cross-format transfer, and [[wiki/entities/pgm.md]] — which declares its held-out abstractions — could run it without new items.

---

## The dissociation that matters most: relational demand is not difficulty

Second-order problems are almost always harder than first-order ones, so any second-order > first-order contrast is confounded with effort. Two designs break the confound in **opposite directions**, and RLPFC follows relations both times:

| Design | Difficulty ordering | Relational ordering | RLPFC | DLPFC |
|---|---|---|---|---|
| Working memory: hold **4 items**, **7 items**, or **4 items + 3 relations** (arrows: "Q comes before Z") — Wendelken et al. 2008a | 7 items > 4 items + 3 relations > 4 items | 4+3 relations > both item-only loads | Higher for 4 items + 3 relations than for 7 items; **does not distinguish 7 from 4** | Scales monotonically with load |
| Propositional analogy: evaluate a *given* relational term ("does *uses* describe writer–pen?") vs **complete** an analogy ("painter : brush :: writer : ?") — Wendelken et al. 2008b | Completion ≫ evaluation | Comparison (evaluation) invites a relation-between-relations; completion can be solved by constrained semantic retrieval | Higher for the **easier** comparison problems | — |

**Why this is the page's most exportable content.** It is a **crossed design**: relational demand high / difficulty low, and difficulty high / relational demand low, in the same subjects with the same stimuli. It converts "does this system integrate relations?" from an unanswerable question about an internal state into a two-cell contrast on any effort-like read-out. Recorded as `I36` on [[wiki/concepts/certification-instruments.md]].

A second consequence, for the wiki's load accounting: **items and relations are separate currencies.** Three relations over four items cost the RLPFC more than three extra items cost it, and cost the DLPFC less. [[wiki/concepts/working-memory.md]]'s capacity estimates are all in items; Halford's relational complexity ([[wiki/concepts/analogical-mapping.md]]) is in roles-to-be-integrated; this is the design that shows they dissociate in the substrate rather than only in theory.

---

## The four subprocesses, and the assignment that has not been earned

Parsons & Davies 2022 take the decomposition every structure-mapping architecture assumes — **access → mapping → inference → schema induction** ([[wiki/entities/sme.md]], [[wiki/entities/lisa.md]], [[wiki/entities/macfac.md]], Companion) — and ask which of the four each node implements.

| Subprocess | What the architecture claims | Best neural candidate | Evidence grade |
|---|---|---|---|
| **Access** — spontaneous retrieval of a source from long-term memory | Optional; omitted entirely by four-term tasks where both analogs are on screen | VLPFC (controlled semantic retrieval) + hippocampus | **None direct.** Never investigated in fMRI. Inferred from *relational retrieval*: DLPFC, VLPFC and hippocampus all scale with the relational complexity of recognised word pairs (Giovanello & Schacter 2012), and hippocampus activates for subliminally-encoded relational inference (Reber et al. 2012, 2014) |
| **Mapping** — correspondence by relational integration | Obligatory; "mapping makes the analogy" | RLPFC | The only one with converging evidence: present in every analogy contrast (Hobeika et al. 2016), causally required (Urbanski et al. 2016), functionally identified as relational integration. Still only *activation*, never *representation* — no MVPA has asked whether RLPFC voxels encode a correspondence |
| **Inference** — transfer of unmapped source propositions | Optional; downstream of mapping | Left middle frontal gyrus (BA 8) + medial frontopolar (BA 10); hippocampus | One study (Wendelken et al. 2008b), with the sign reversed (below) |
| **Schema induction** — the analogy itself becomes a reusable structure | LISA yes, Companion has no such stage | VLPFC/inferior frontal sulcus (BA 45) for the induction; VMPFC↔hippocampus for the store | Weakest. VMPFC is a poor analogy correlate — the network is lateral, and VMPFC codes subjective **value**, which analogy tasks never manipulate |

**The Find/Apply manipulation is the one clean handle on schema induction.** Give the source analog either as an instance the rule must be extracted from (*Find*) or as the stated rule (*Apply*). Inferior frontal sulcus (BA 45) is higher for *Find*, i.e. for **rule induction when no rule is supplied** (Aichelburg et al. 2016), with RLPFC proposed to re-represent the induced rule at a higher level of abstraction. Behaviourally the two conditions dissociate by modality: verbal analogies are *slower* under Find (Wendelken et al. 2008b), visuospatial ones are not (Volle et al. 2010; Aichelburg et al. 2016) — attributed to subjects accumulating the relational schema across repeated Find trials, which is [[wiki/concepts/schema-assimilation.md]] happening inside the control condition.

### Three results that break the pipeline reading

**(a) The phase with no mapping in it produces more activation than the phase with mapping in it.** Two studies split a trial into encoding / mapping-inference / response phases and found RLPFC, DLPFC *and* VLPFC more active during **encoding** (Krawczyk et al. 2010; Volle et al. 2010). Neither study had an access demand, so there was nothing to retrieve. Parsons' reading: telling a subject an analogy is coming installs a **goal state**, and the encoding window is then filled with anticipatory guesses at the missing term — many small analogies rather than a pre-analogical stage. If that is right, the phase-locked design measures the *instruction*, not the subprocess, and every stage-decomposed fMRI result in this literature inherits the confound (`L0-INSTR`).

**(b) Adding a demand *removed* activation.** Comparison (all four terms given, judge the match) vs completion (three terms, infer the fourth) — completion strictly adds inference. Completion engaged left BA 8 and medial BA 10; **bilateral RLPFC and VLPFC (BA 10/47) were higher for the easier comparison condition** (Wendelken et al. 2008b). Attributed to the absence of a concrete baseline: Krawczyk et al. 2010, with a baseline, recovers RLPFC and VLPFC for the mapping/inference phase.

> **This is a caveat on this page's own instrument.** The second reversal in `I36` — RLPFC higher for *evaluate* than for *complete* — is this same contrast, read there as relational demand dissociating from difficulty. Parsons reads the identical result as a subtraction artefact. Both readings cannot be load-bearing at once, and the discriminating experiment (the same contrast against an explicit baseline) has not been run on this pair.

**(c) The subprocesses may not be separable in principle.** Hummel & Holyoak's own statement is that "analog retrieval, mapping, inference, and schema induction, as well as rule-based reasoning, are all special cases of the same sequential, directional algorithm for mapping"; ARCS and MAC/FAC require access and mapping to run **simultaneously**, since structural, semantic and pragmatic constraints have to shape the memory search in real time. Mapping completes in hundreds of milliseconds. The one temporal decomposition that exists is an ERP study (Qiu et al. 2008): a negativity in rostral prefrontal cortex (BA 10) at **900–1200 ms** post-target aligned with completing the analogy, and a second in dorsal prefrontal cortex (BA 9) at **2000–2500 ms** read as verification of the inference. That is the wiki's only latency budget for analogy, and it is two components inside one 2.5 s window with no spatial resolution behind it. See `T330`.

### At the network level, the default-mode network is a cost, not a contributor

MVPA over a large analogy sample recovers four coactivation networks — visuospatial, executive, default-mode, attention-to-salience — and **default-mode activation is negatively related to analogy accuracy while executive frontoparietal activation is positively related** (Hammer et al. 2019). The open question Parsons leaves: an analogy *with* an access demand should require internally-directed retrieval, so a task that forces spontaneous access is where default-mode and executive-control networks would have to cooperate rather than trade off — untested, and the cleanest available test of whether access is a real subprocess at all ([[wiki/entities/default-mode-network.md]]).

---

## Development: the integrator is freed, not grown

Longitudinal and cross-sectional data on ages 6–18 (Wendelken et al. 2011; Whitaker 2012; Ferrer et al. 2013), `n = 165` for the behavioural trajectory.

| Age band | Second-order > first-order contrast |
|---|---|
| 7–10 | Only a small left-DLPFC cluster — RLPFC and IPL are engaged *equally* by first- and second-order trials |
| 11–14 | Bilateral DLPFC + dorsomedial prefrontal cortex |
| 15–18 | Left RLPFC + bilateral IPL — the adult pattern (Bunge et al. 2009) |

**The direction of the developmental change is the finding.** Plotted against age, RLPFC activation on second-order trials is **flat**; what falls is RLPFC activation on **first-order** trials. Structural equation modelling attributes part of that fall to cortical **thinning in IPL** — the thinner the parietal cortex, the more functionally specific the RLPFC.

> **The architectural reading `(brainstorm)`.** The integrator's apparent capacity grows because the *cheap* store downstream of it gets good enough to stop calling it. This is a scheduling/caching claim, not a capacity claim: nothing about the second-order machinery changes across a decade of development, and the entire measured gain is first-order work migrating out of the expensive component. For a machine: an integrator whose call rate is not gated will look capacity-limited even when it is not, and the way to raise effective relational capacity is to make the first-order representation self-sufficient rather than to widen the binder. This is a third mechanism for the relational shift, alongside the two in [[wiki/concepts/analogical-mapping.md]] (`T193`): not knowledge accretion, not executive maturation, but **offload**.

**White matter.** Probabilistic tractography identifies left and right RLPFC–IPL tracts. Cross-sectionally, their fractional anisotropy predicts reasoning ability *no better than a whole-brain white-matter average* — consistent with a general fluid-intelligence/white-matter relation (Chiang et al. 2009; Tamnes et al. 2010). Longitudinally, change in **left** RLPFC–IPL fractional anisotropy over ~1.5 years predicts change in reasoning after partialling out age and initial values, where the right tract and the global measure do not; the relation is mediated by processing speed. Functional connectivity moves the same way and *selectively*: RLPFC↔IPL coupling rises across childhood and adolescence while RLPFC↔superior-parietal coupling **falls**, so this is not the general long-range-connectivity increase of Fair et al. 2008.

**A methodological rule worth carrying** (`L0-INSTR`, `(brainstorm)`): the same tract is non-specific cross-sectionally and specific longitudinally. A between-subject correlation with a global confound (age, overall myelination, overall scale) cannot localise anything; only the within-subject change can. Every wiki claim that reads a capability off a between-model correlation — parameter count, layer count, training compute — is at the cross-sectional grade.

---

## Evolution: a new edge, not a new node

| Change | Evidence | Grade |
|---|---|---|
| **RLPFC↔mid-IPL resting-state connectivity exists in humans and not in macaques** — no analogue even at a much relaxed threshold | Structural-connectivity-constrained resting-state fMRI, human vs macaque (Mars et al. 2011); DLPFC seeds by contrast give closely matching frontoparietal maps in both species | The single sharpest claim on this page, and a cross-species comparison of a fitted connectivity map |
| **RLPFC may have no macaque homologue**, and its function may map onto macaque DLPFC rather than macaque frontopolar cortex | Neubert et al. 2014 | Contested; parcellation-dependent |
| **The prefrontal hierarchy is inverted.** Human fMRI places RLPFC at the apex of a rostrocaudal hierarchy (Badre & D'Esposito 2009); in the macaque, frontopolar cortex ranks *below* both DLPFC and VLPFC in a structural-connectivity hierarchy recovered by simulated annealing over the acyclic-graph approximation | Goulas et al. 2014 | Structural tract-tracing, but the "hierarchy" is an inferred ordering |
| **Frontoparietal regions have higher node degree in humans than macaques** — more highly connected hubs distributed across the network | Miranda-Dominguez et al. 2014 | Graph statistic, sensitive to parcellation ([[wiki/concepts/node-definition-problem.md]]) |
| **Cortical expansion is concentrated in association cortex**, greatest in Brodmann area 10; primary motor and sensory surface area is *smaller* in humans than chimpanzees relative to total. The regions most expanded across evolution overlap those most expanded across human development | Buckner & Krienen 2013; Fjell et al. 2013 | Volumetric |
| **More neuropil per neuron in the expanded regions.** Prefrontal/parietal layer III has *fewer* pyramidal neurons spaced further apart in humans than in chimpanzees and macaques (greater horizontal spacing distance); human prefrontal and parietal pyramidal cells carry greater dendritic length, density and spine count than human primary motor or superior temporal cells | Semendeferi et al. 2011; Spocter et al. 2012; Bianchi et al. 2013 | Cytoarchitecture; small `n` per species |

**"A little goes a long way" is a specific architectural claim, and it is not the same as either side of `T289`.** Position B there (Sherwood et al. 2008) says the human capacity needed no new component, only re-weighting and a shifted growth schedule. This page's proposal is narrower and more testable: one **long-range edge** between two existing regions, plus expansion of the neuropil at its endpoints, plus a **re-ordering** of an existing hierarchy so that the frontopolar node moves from below DLPFC to above it. That is not a new operator (Position A) and not a pure re-weighting either — it is a change in the *graph*, at fixed node inventory.

This is the first source in the wiki to propose an anatomical correlate for the behavioural discontinuity, which is one of the two disjuncts in `T289`'s closing condition. It does **not** settle the tension: the same three facts are read by these authors as continuity ("small changes") and could equally be read by Position A as exactly the novelty it predicts. See the note on `T289`.

---

## Comparative behaviour: the discontinuity may be a *rate*, not a boundary

The review concedes more to the animals than [[wiki/concepts/relational-reinterpretation.md]] does — great apes (Flemming et al. 2008; Haun & Call 2009) and Old World monkeys (Flemming et al. 2013) do solve relational match-to-sample — and relocates the difference:

| Quantity | Human | Nonhuman |
|---|---|---|
| Trials to 80% on `AAAA` matches `BBBB`, not `CDEF`, by trial and error | **35** | **~400** (baboons; Flemming et al. 2013) |
| Acquisition from verbal instruction | Immediate (Cole et al. 2011) | Not available |
| Accuracy vs set size on relational match-to-sample | ≥86% at every set size | Chance on *different* trials below set size 4 (Fagot et al. 2001) |

**Why a builder should care about the middle row rather than the top one.** The wiki's discontinuity evidence is almost entirely about *what can be represented*. A 10× sample-efficiency gap on a task both species eventually solve is a different axis, and it is the axis machine models are actually measured on. A model that reaches human final accuracy on a relational task after a large number of gradient steps has matched the human on the capability axis and sits on the baboon side of this one — and no wiki benchmark reports trials-to-criterion against a human trials-to-criterion. [[wiki/concepts/skill-acquisition-efficiency.md]] is where the quantity belongs; this is the comparative anchor for it (`(brainstorm)`).

---

## What this does and does not decide for a model

- **It supplies a shape, not a mechanism.** Three components — relation store, integrator, general-purpose effort tier — with a privileged edge between the first two. It says nothing about *how* the integrator integrates; LISA's synchrony ([[wiki/entities/lisa.md]]) and the vector-symbolic binders remain the only mechanistic candidates, and neither is tested against this anatomy.
- **The integrator is a small, specialised, expensive component that most inputs should not reach.** Every wiki architecture that composes runs its composition on everything. The developmental result says the mature system is the one that composes *rarely*.
- **The relational store is parietal and the integrator is frontal, and they are separately damageable.** This matches the four-way decomposition already read off the analogy literature ([[wiki/concepts/analogical-mapping.md]]: temporal content store, hippocampal episode store, frontopolar integrator, inferior-frontal suppressor) and adds the parietal first-order term to it.
- **`G21`'s composer now has a candidate location.** The gap asks what composes the outputs of two encapsulated modules. This page's answer: a single region whose coupling to *whichever* posterior module supplies the current relational content is itself task-dependent — RLPFC's coupling to visuospatial vs semantic processing regions changes with the type of relation being considered (Wendelken et al. 2012). That is a composer implemented as a **switchable fan-in** rather than as a fixed wiring, which is precisely the "afferent diversity" mechanism `T289` Position B names and nowhere instantiates.

---

## Open problems

| Problem | Why it is open |
|---|---|
| **RLPFC has no agreed function** | The review lists prospective memory, abstract thinking, counterfactual thinking, tracking alternative outcomes, and planning as separately proposed accounts and states plainly that no consensus exists. "Comparison and/or integration of several sets of mental representations" is these authors' own candidate, not a settled result |
| **The species comparison rests on fitted connectivity maps** | "No macaque analogue" is a null in a resting-state analysis across species with different scanner protocols, anaesthesia states, parcellations and brain sizes. The review calls for chimpanzee parcellation work that does not exist |
| **The developmental mediation is correlational** | Cortical thinning in IPL "accounts for" the RLPFC first-order decrease through structural equation modelling on observational data; no intervention, and cortical thinning is itself of contested cellular meaning (pruning vs. grey/white boundary shift under myelination) |
| **Nothing separates the integrator from a general effort signal at the region level** | The two crossed designs are the *only* evidence that RLPFC is not difficulty-driven, they come from one lab, and each has a single-cell-of-the-design reversal doing all the work |
| **No study has measured all four analogy subprocesses, and one of them has never been measured at all** | Access has no direct fMRI investigation in the literature (Parsons & Davies 2022); the proposed remedy is a train-then-probe design — pre-train relational categories on `A:B` pairs, then present `C:D` pairs in the scanner and ask whether the category is familiar, so access and mapping fire together against a comparison-only control |
| **Every region↔subprocess assignment here is univariate** | Activation says *how much* a region responds, not *what it represents*. MVPA and model-based fMRI (using LISA's or Companion's own predicted per-trial quantities as regressors) are both available and neither has been applied to the subprocesses — so "RLPFC is the mapping region" is currently an inference from co-occurrence |
| **The integrator's left lateralisation has no account** | Both semantic *and* visuospatial analogy maps are significant in left rostrolateral cortex and neither is in the right, so it is not a verbal-material effect; the meta-analysis rules out the only available explanation and offers none in its place. It also sits awkwardly with the primary sources for both the left-lateralised claim and the visuospatial half being partly the same lab, and with `T289`'s lesion evidence pointing at a right frontal network |
| **Task-format and response-mode confounds are unresolved throughout** | `T335`: the analogy/matrix dissociation, the domain dissociation and `I36`'s second arm are all contrasts in which evaluate-vs-complete varies with the thing of interest. The meta-analysis inherits every design decision of its 27 inputs and can control none of them |
| **The claim is about second-order relations and stops there** | Third-order and deeper are never tested, so whether RLPFC is a general recursion site or a fixed-depth two-slot comparator is unaddressed — which is exactly the question `G104` and [[wiki/entities/lisa.md]]'s phase capacity raise |

---

## Connections

- **[[wiki/concepts/relational-reinterpretation.md]]** — supplies the anatomy that page's supermodule argument lacked: the same three regions recur across memory, reasoning, decision-making and perception whenever a relation between relations is evaluated, which is the cross-domain convergence that page inferred from behaviour alone.
- **[[wiki/concepts/analogical-mapping.md]]** — the four-way functional decomposition on that page (content store, episode store, frontopolar integrator, inferior-frontal suppressor) with the missing fifth term supplied: parietal cortex holds the first-order relations that the frontopolar integrator compares, and the developmental data say the integrator's effective capacity is set by how much the parietal store can handle alone.
- **[[wiki/concepts/working-memory.md]]** — the design that shows items and relations are separate load currencies: three relations over four items engage RLPFC more than three extra items do, and engage DLPFC less, so a capacity measured in items does not bound relational integration.
- **[[wiki/concepts/cognitive-control.md]]** — separates two things that page's bias signal conflates: DLPFC activation tracks task difficulty across paradigms (the effort tier), while RLPFC tracks relational structure independently of difficulty, so "control" and "integration" are dissociable by a crossed design rather than being one graded resource.
- **[[wiki/concepts/certification-instruments.md]]** *(second link)* — home of `I38`, the domain-crossed relational battery abstracted from this page's semantic-vs-visuospatial subtraction maps: intersect the components two content domains recruit for the same relational operation to locate the domain-general operator, difference them to locate the content feeds.
- **[[wiki/concepts/certification-instruments.md]]** — home of `I36`, the relational-demand × difficulty crossing derived from this page's two reversal designs: the cheapest way to show a system's effort read-out is driven by structure rather than by cost.
- **[[wiki/entities/salience-network.md]]** — the same network under its other wiki description; that page's triple-network model treats "frontoparietal" as DLPFC + posterior parietal doing attention and working memory — the externally directed mode — and this page adds the rostrolateral node and the relational-integration function the switching account has no use for.
- **[[wiki/entities/lisa.md]]** — the mechanism candidate for the box this page localises: synchrony-based role-filler binding at a capacity of 2–3 propositions is what a frontopolar integrator with a two-slot second-order comparator would look like, and the anatomy neither confirms nor constrains it.
- **[[wiki/entities/default-mode-network.md]]** — shares the inferior parietal lobule as a node, which is a warning about both: a region-level function attribution built from one literature's contrasts collides with another literature's when the same coordinates carry two names ([[wiki/concepts/node-definition-problem.md]]).
- **[[wiki/concepts/developmental-heterochrony.md]]** — the same evolution/development coincidence measured rather than asserted: this page reports that the cortical regions most expanded across primate evolution overlap those most expanded across human development, which is the timing-shift hypothesis stated at the level of surface area.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — where this page's comparative anchor belongs: 35 vs ~400 trials to criterion on the same relational task relocates part of the human/nonhuman discontinuity onto a *rate* axis, and no wiki benchmark reports trials-to-criterion against a human.
- **[[wiki/concepts/node-definition-problem.md]]** — the standing discount on every claim here: node degree, hierarchy rank and "no analogue" are all parcellation-dependent statistics, and the cross-species comparison changes the parcellation by construction.
- **[[wiki/concepts/emergent-modularity.md]]** — a shared relational competence called by many functional modules, now with a location; the switchable RLPFC↔posterior coupling is what a learned rather than wired composer would look like in fMRI.
- **[[wiki/entities/macfac.md]]** — the two-stage retrieval architecture whose first stage this page's VLPFC node is the candidate substrate for, and the reason the assignment is unsafe: MAC/FAC's stage 1 is deliberately structure-blind, while VLPFC's measured sensitivity is to *associative strength*, which is the same surface quantity — so the anatomy is consistent with the model precisely where the model is known to be inadequate.
- **[[wiki/concepts/schema-assimilation.md]]** — supplies the induction half of that page's assimilation loop with a location and a manipulation: inferior frontal sulcus (BA 45) is engaged more when the rule must be extracted from an instance than when it is stated, and repeated extraction trials erase the behavioural cost, which is a schema being built inside a control condition.
- **[[wiki/entities/sme.md]]** — the architecture whose stage decomposition this page tests against brains and cannot confirm: access, mapping, inference and schema induction are separable in the code and, on the available imaging, are not separably measurable in the tissue (`T330`).
- **[[wiki/concepts/controlled-semantic-cognition.md]]** — the overlap and the non-overlap between two control networks: intraparietal sulcus and inferior frontal sulcus appear in both as the domain-general selection term, while the semantic-control nodes (posterior middle temporal gyrus, ventral prefrontal cortex) appear nowhere in this page's relational set — evidence that control is organised per representation-store rather than as one supermodule serving all content.
- **[[wiki/entities/raven.md]]** — the benchmark this page's task-format contrast puts a construct question under (`T335`): holding the visuospatial domain fixed, matrix problems recruit the attention and fronto-parietal control networks and *not* the left rostrolateral cluster that every four-term analogy contrast shares, so a matrix score indexes visuospatial load and multi-relation bookkeeping rather than the second-order integrator.
- **[[wiki/entities/pgm.md]]** — the one matrix benchmark that could run `T335`'s discriminating machine-side test without new items: its held-out abstractions are declared over the generator, so cross-format transfer (matrix-trained → four-term analogy) can be measured against its own within-format regimes as the baseline.
- **[[wiki/entities/arc-agi.md]]** — inherits the same exposure one step further out: grid-completion items are scored as evidence about analogy-grade abstraction, and the neural comparison behind `T335` says the format sits on the control-network side of the dissociation.
- **[[wiki/entities/lateral-frontal-pole.md]]** — the same tissue this page calls RLPFC, read from the decision-making literature instead of the analogy one, and the two function assignments are rivals rather than complements: *comparison of several sets of relational representations* here, *goal-conditioned multi-head decomposition of high-dimensional input into a low-dimensional feature basis* there, with a filter-count ablation behind the second and nothing yet relating it to the first. It also supplies this page's missing causal and connectivity detail — FPl vs FPm parcellation, TMS dissociating directed from random exploration, and the finding that the rostro-caudal apex claim reverses when the ordering criterion becomes effective connectivity (`T332`).
