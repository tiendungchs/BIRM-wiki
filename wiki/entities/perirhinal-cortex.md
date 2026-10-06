# Perirhinal Cortex — an Item-Novelty Detector at the Top of the Ventral Stream, Kept Off the Store's Write Path

**The first multimodal stage between the ventral visual stream and the hippocampus (macaque areas 35/36; rat areas 35/36 beside the rhinal sulcus). About a quarter of its neurons, together with neurons in adjacent anterior area TE, fall in response the second time a stimulus is seen. The fall needs one exposure, lasts more than 24 h, holds for many stimuli at once, needs no training, and is readable ~75 ms after stimulus onset. The same neurons are rare in the hippocampus. Brown & Aggleton 2001 read this as a familiarity/recency discriminator for single items that works without the hippocampus. The hippocampus, by contrast, judges the prior occurrence of *arrangements* of items. Whether the two are separate modules or one store read two ways is `T407`.**

> **Provenance.** Brown & Aggleton 2001, *Recognition memory: what are the roles of the perirhinal cortex and hippocampus?*, Nat. Rev. Neurosci. 2:51–61 (`raw/brown-2001-recognition-memory-roles-perirhinal-cortex-hippocampus.md`). A review: monkey and rat single units, rat c-*fos* imaging, monkey and rat lesions, human cases, event-related potentials and fMRI. Table 1 and Figures 1–3 survive in the clip as titles only. Aggleton co-wrote the 1999 target article behind [[wiki/concepts/recollection-familiarity.md]] and several of the c-*fos* studies cited (Wan et al. 1999), and Brown's lab produced most of the recordings cited. So this page is **not independent** of the Aggleton-lab pages, and it is the dual-process camp's own summary.
>
> **Second source.** Bowles, Crupi, Mirsattari, Pigott, Parrent, Pruessner, Yonelinas & Köhler 2007, *Impaired familiarity with preserved recollection after anterior temporal-lobe resection that spares the hippocampus*, PNAS 104(41):16382–16387 (`raw/bowles-2007-impaired-familiarity-preserved-recollection-temporal-resection-sparing-hippocampus.md`). One human case (NB), four experiments, small matched control groups. Supplementary figures and tables are links only. Köhler's lab, with Yonelinas: dual-process camp, but **not** the Aggleton/Brown lab, and the data are its own.

Why this earns a page. Perirhinal cortex was named on 27 pages and owned by none. Its anatomy is on [[wiki/concepts/hierarchy-of-associativity.md]], its 1999 lesion matrix and debate on [[wiki/concepts/recollection-familiarity.md]], and its prefrontal input on [[wiki/entities/hippocampal-prefrontal-channel.md]]. What no page states is the module's own specification: what its familiarity signal is, how fast it arrives, and what it cannot see. A reasoning architecture's "have I seen this?" gate (`T407`, `G42`) would be built against that specification.

---

## Anatomy and connections (assembled from existing pages)

| Property | Value | Page |
|---|---|---|
| Position | Apex of the ventral visual stream; first stage of the medial-temporal stack (perirhinal → parahippocampal → entorhinal → hippocampus) | [[wiki/concepts/hierarchy-of-associativity.md]] |
| Afferents | Area TE (object vision), somatosensory, ventrolateral + orbitofrontal, cingulate, superior temporal sulcus polymodal cortex. V4 and posterior parietal cortex reach it only disynaptically, through parahippocampal cortex | [[wiki/concepts/hierarchy-of-associativity.md]] |
| To the store | → rostral two-thirds of entorhinal cortex (macaque); → lateral entorhinal cortex (rodent) | [[wiki/entities/entorhinal-cortex.md]] |
| To the thalamus | Proposed: → magnocellular mediodorsal (sparse in monkey, not shown in rat). Measured: **massive** → midline/intralaminar nuclei, reuniens and central medial included | [[wiki/entities/mediodorsal-thalamus.md]], [[wiki/entities/nucleus-reuniens.md]] |
| From the controller | Medial prefrontal → **superficial** perirhinal layers (strong, bidirectional); weaker to medial entorhinal cortex | [[wiki/entities/hippocampal-prefrontal-channel.md]] |
| Asymmetries | Frontal → perirhinal is much wider than the return; perirhinal → V4/TEO is wider than the input from them | [[wiki/concepts/hierarchy-of-associativity.md]] |
| Rhythm | No medial septal input. Its theta is imposed from deep entorhinal layers | [[wiki/concepts/hierarchy-of-associativity.md]] |
| Rat neighbour | Postrhinal cortex, analogous to parts of primate parahippocampal gyrus (areas TH/TF) | This source |

---

## The familiarity code (Brown & Aggleton 2001)

| Property | Value |
|---|---|
| Sign | Response **reduction** on repetition. Enhancement is rare, and appears only after training that rewards a target's repetition |
| Prevalence | ~25% of recorded neurons in anterior inferior temporal cortex (perirhinal + area TE). **<~1%** in the hippocampus: low but above chance in two studies, at chance in two others |
| Latency | Population discrimination of prior occurrence at **~75 ms**, no slower than stimulus identification in the same cells |
| Learning | One trial, for an infrequently presented stimulus |
| Persistence | **>24 h**. Hippocampal repetition responses that do exist have longer latencies and are gone by 24 h |
| Capacity | High: the decrement holds when many stimuli must be remembered at once |
| Endogenous | Automatic: no training needed, present whether or not the animal must use the information |
| Content | Separate **recency** and **familiarity** information (Figure 2 title; populations on [[wiki/concepts/recollection-familiarity.md]]) |
| Species / modality | Rat and monkey. Perirhinal lesions also impair tactile and olfactory recognition, so the deficit is not visual-only |
| Origin | Repetition effects earlier in the visual pathway last only seconds or a few intervening trials. So the long-term signal is **generated** in perirhinal cortex/TE, not passed up from below |
| Share of the region | Only a proportion of perirhinal neurons decrement, so the region can also serve object perception and paired-associate learning |

**What is not the familiarity code.** Three other prior-occurrence-related signals exist in anterior temporal cortex. The source rules each out as a *general* item-familiarity substrate:

| Signal | Where | Why it is not the general substrate |
|---|---|---|
| Match/mismatch response in small-set delayed matching (stimuli repeat often, one held at a time) | Hippocampus **and** anterior temporal cortex | Signals *what was last presented*, not relative familiarity. A working-memory mechanism: perirhinal lesions impair the trial-unique variant and spare the repeating-set variant |
| Delay activity carrying the sample | Anterior inferior temporal cortex incl. perirhinal | Present only when one stimulus is held at a time |
| Response enhancement to a rewarded target | Same | Appears only after specific training |

**The latency argument for independence.** Prior occurrence can be read at the same latency as identity, which the source takes to exclude top-down input from the hippocampus or prefrontal cortex. Combined with the rarity and slowness of hippocampal repetition responses, the claim is that **familiarity is computed without the hippocampus**, not just alongside it.

---

## The dissociation evidence in this source

| Method | Perirhinal cortex | Hippocampus |
|---|---|---|
| Single units | Decrement to repeated items (above) | Place fields. Familiarity of *an item at a location* (monkey and rat); list membership (unpublished) |
| Rat c-*fos*, novel vs familiar single items (paired viewing, one eye per stimulus, so motivation and alertness are matched across hemispheres) | More neurons active for novel items (with area Te2) | No difference |
| Rat c-*fos*, new environment, or familiar objects in a new spatial arrangement | No difference | Active, **with postrhinal cortex** |
| Monkey lesion, object recognition | Severe and seemingly permanent | Mild and variable, most visible at long delays. One study normal at long delays (Murray & Mishkin 1998) |
| Rat lesion, object recognition | Impaired | No effect or very small |
| Rat lesion, spatial navigation and spatial working memory (recency of visited places) | Often no effect; when present, smaller | Devastating |
| Re-paired familiar items, rearranged scene elements | — | Reliably impaired; abnormal orienting to novel re-pairings (neurotoxic, rat) |
| Paired-associate (temporal) learning | Implicated | — |

**Other medial-temporal lesions, monkey object recognition:** entorhinal lesions are less severe and transient; lesions of parahippocampal areas TH/TF have no apparent effect. Severity is therefore not ordered by position in the stack (consistent with Meunier et al. 1993 on [[wiki/concepts/hierarchy-of-associativity.md]]).

**Cooperation.** Combined perirhinal + postrhinal removal impairs object–location tasks and spares standard spatial tasks. Crossed unilateral lesions (perirhinal cortex in one hemisphere, fornix in the other) impair monkey tasks where tying an object to a place in a scene helps. Perirhinal cortex therefore supplies object information to hippocampal association, but **nothing shows that this supply depends on the familiarity mechanism**. Lesion mismatches suggest it does not.

**Entorhinal cortex as a junction.** Its neurons carry both stimulus familiarity and spatial information, in line with its position between the two systems ([[wiki/entities/entorhinal-cortex.md]]).

---

## Human evidence

| Evidence | Pattern | Reading for `T407` |
|---|---|---|
| Familiarity is not priming | Medial-temporal amnesics show normal repetition priming with poor recognition. A herpes-encephalitis patient with bilateral hippocampal + perirhinal damage stays at chance on recognition for material he is primed on. Cortical damage elsewhere disrupts priming and spares recognition | Double dissociation: priming and familiarity have different substrates. A shared early mechanism is not excluded |
| Parkin et al. case (anterior communicating artery aneurysm, hippocampus and its outputs not directly involved) | Preserved recognition that appears familiarity-based | B, weak (pathology not hippocampal) |
| Mayes et al. case: bilateral hippocampal shrinkage, adjacent cortex apparently spared | Persistent episodic deficit; item recognition strikingly preserved; deficits mainly on associative recognition (A paired with B, not C) | B |
| Vargha-Khadem et al. 1997, early hippocampal damage | Selective associative-recognition deficits | B |
| Reed & Squire 1997; Manns & Squire, hypoxic hippocampal cases | Impaired on a wide range of recognition tests | A, but both models predict *some* recognition deficit. The test is whether the deficit is confined to recollection |
| Knowlton & Squire 1995, hippocampus-centred amnesics, remember/know | Both components impaired | A (the source's own concession). Full pathology unconfirmed |
| Scalp event-related potentials | Frontal **FN400**, 300–500 ms, old items only, insensitive to depth of processing → familiarity. Left parietal **P600**, 400–800 ms, sensitive to depth → recollection. A third parietal component insensitive to accuracy → priming | Two qualitatively different generators. Anatomy unresolved at scalp resolution |
| Intracranial subsequent-memory potentials (Fernandez et al. 1999) | 310 ms in anterior parahippocampal gyrus, 500 ms in hippocampus | Fits fast perirhinal + slow hippocampal, but cannot separate *serial* from *parallel* |
| Event-related fMRI (Eldridge et al. 2000) | Hippocampal activity rises only for "remember". "Know" is indistinguishable from correct rejections and misses | B's strongest human datum: K is **not a weaker R** in the hippocampus |
| fMRI repetition decrements | Parahippocampal signal falls as scenes become familiar; decrements also in inferior temporal and perirhinal cortex | Same sign as the animal code |
| Reaction time | Know decisions faster than remember decisions, unless instructions force recollection first | Parallels FN400 → P600 ordering |

---

## The human reverse case: patient NB (Bowles et al. 2007)

Every human dissociation above is hippocampal damage sparing familiarity. A single dissociation of that kind fits a one-store account in which perirhinal cortex carries only a weak, poorly differentiated memory and the hippocampus the strong one: damage the hippocampus and only the "hard" part (recollection) goes. That account cannot produce the reverse: **familiarity lost, recollection kept, after damage upstream of an intact hippocampus**.

**The lesion.**

| Property | Value |
|---|---|
| Cause | Left anterior temporal lesionectomy (≈1.7 cm of lateral and medial temporal cortex) for drug-resistant epilepsy from a left amygdala mass (likely ganglioglioma). Seizure-free after surgery |
| Removed | Most of the left amygdala; **part** of left perirhinal and entorhinal cortex; temporopolar cortex |
| Spared | Left hippocampus and parahippocampal cortex (gross structure intact along the whole length); entire right hemisphere |
| Confound | Left hippocampal volume below right. Already visible pre-operatively, posterior to the resection, mild atrophy; the perirhinal volume loss is disproportionately larger and abrupt at the surgical site |
| Clinical profile | Normal in every domain, memory included (97th percentile, Wechsler Memory Scale III auditory delayed recall). One weak score: semantic fluency, 21st percentile |
| Pre-surgical seizures | Accompanied by déjà vu, a symptom linked to abnormal familiarity signals and perirhinal dysfunction |

**Four experiments, three methods, verbal material** (left-hemisphere lesion). NB compared with age- and education-matched controls (n = 7–12 per experiment) using single-case abnormality tests.

| Experiment | Method | Recollection | Familiarity | Overall |
|---|---|---|---|---|
| 1 | Remember/know, 50 words, ~1 h delay | Above average (z = 3.65) | Lowest of all controls: z = −1.83 corrected for independence (P < 0.07); z = −7.02 raw "know" (P < 0.0005), driven by "know" false alarms (z = 5.47) | d′ normal (z = −0.63) |
| 2 | Remember/know/guess, 200 words, fast sentence verification at study (blocks idiosyncratic elaborative encoding, NB's own reported strategy) | Upper normal (z = 1.52) | Impaired: z = −2.12 corrected (P < 0.05), −2.73 raw | — |
| 3 | 6-point confidence receiver-operating-characteristic (ROC), deep vs shallow encoding, least-squares dual-process fit | Normal | Deep: z = −1.98 (P = 0.056). Shallow: low-normal (z = −1.05) but below every control | — |
| 3, ROC shape | No process model assumed | — | ROC more **linear** in probability space (R² = 0.88, above every control) and more **U-shaped** in z-space (quadratic b = 0.08, z = 2.27, P < 0.05, deep). Avoids low-confidence responses "3"/"4" (z = −2.53, P < 0.05) | — |
| 4 | Yes/no at a 400 ms vs 2,000 ms response deadline; no introspective judgement | — | Lowest of all at 400 ms; above average at 2,000 ms. Fast/slow ratio disproportionately reduced (P < 0.05) | — |

**Why each experiment closes a loophole.**

| Objection to a familiarity deficit | Answer in the source |
|---|---|
| High recollection mechanically lowers the corrected familiarity estimate | Experiment 2 blocks elaboration; recollection drops to upper normal, familiarity stays impaired |
| Remember/know rests on introspection | Experiment 3 (confidence, not process labels) and Experiment 4 (no metamemory judgement at all) |
| The estimate depends on assuming independent processes | Raw "know" rates show the deficit without the correction; the ROC shape shows it before any model is fitted |
| A response-bias shift toward high confidence | Bias moves points **along** one ROC; it cannot change the curve's shape |

**The ROC shape is the mechanism-level datum.** Under the dual-process form on [[wiki/concepts/recollection-familiarity.md]], removing the graded familiarity term leaves a threshold process, whose ROC is a straight line in probability space. NB's curve moved toward that line, and she stopped using the graded middle of the confidence scale: her recognition behaves **all-or-none**. No single-strength model predicts a lesion that makes the ROC more linear.

**What the source concludes, and what it does not.**

- Recollection runs normally with part of its main cortical input (perirhinal → entorhinal → hippocampus) removed. So the hippocampus does not need an intact familiarity signal **as its input** to recollect.
- Perirhinal/entorhinal cortex does more than relay to the hippocampus: removing part of it costs a process the hippocampus does not replace.
- **Not concluded:** the lesion is partial and unilateral, so a larger perirhinal or entorhinal lesion could still impair hippocampal function. Entorhinal rather than perirhinal damage may cause the deficit (monkey entorhinal lesions mildly impair recognition). The authors' independence claim holds either way. Amygdala and temporal pole are argued out (neutral words; the temporal pole serves naming of unique entities, not prior occurrence).
- Semantic fluency, the only clinical deficit, has been tied to perirhinal function, and familiarity has been read as an expression of semantic memory (Tulving 2001, cited). Recollection is the episodic read.

---

## Why have a separate familiarity system: the source's computational argument

1. **Speed and economy.** A Hebbian network with long-term potentiation/depression rules (Bogacz, Brown & Giraud-Carrier 1999/2001, cited) performs familiarity discrimination with **fewer neurons and faster decisions** than systems that use associative learning, and its units reproduce perirhinal response types. Modelling suggests a system optimised for speed may be *unable* to provide associative recollection.
2. **It keeps writes out of the categorisation network.** With a separate familiarity network, perceptual categorisation networks need not change their synapses every time a novel stimulus appears. The novel item is identified by its activation pattern in the unchanged categoriser, and its occurrence is registered in the familiarity network. The categoriser is modified only when the item's *associations* must be stored or a *new category* formed, and that is the job of a second, associative (hippocampal) system.

**Qualitative or quantitative?** The source's own scorecard:

| Evidence class | Verdict |
|---|---|
| Activity in the intact brain (units, c-*fos*, fMRI, event-related potentials) | **Qualitative**: double dissociations, opposite directions for different functions, not explainable by one trace strength |
| Animal lesion behaviour | **Quantitative** per lesion (in some studies both lesions cost something on both task types), but a double dissociation between item and spatial recognition |
| Human lesion behaviour | **Equivocal** |

Conclusion as stated: convincing evidence for a qualitative difference in contributions, while "the behavioural case for dissociation remains to be proved".

---

## How it maps to model components

| Biological property | Machine reading |
|---|---|
| Item-specific decrement, one trial, >24 h | A per-item **habituation trace** on the encoder's output: a separate, sparsely updated population, not a change to encoder weights |
| ~75 ms, same latency as identity | Computed in the **forward pass**, from the encoder's own representation, with no query to the store |
| Rare in the hippocampus; blind to arrangements | The gate sees **nodes, not edges**. Novel arrangements of familiar items are invisible to it |
| Recency and familiarity carried separately | Two statistics per item, last-seen time and exposure count, not one novelty scalar |
| Categoriser left unchanged by novel items | Occurrence is recorded **off** the representation-learning path. Encoder weights change only on an associative or category-forming write |
| Supplies object identity to hippocampal binding, independently of its familiarity signal | One region, two outputs: an identity code to the store and a novelty scalar to the controller (thalamus/prefrontal). Bowles et al. 2007: partial removal costs the scalar and leaves the store's recollection normal, so the two outputs are separable by lesion |
| NB: deficit only under a 400 ms deadline, gone at 2,000 ms | The gate's value is **latency**. With time to retrieve, the store's read covers for it |
| NB: ROC turns linear, low-confidence responses vanish | Without the gate, the remaining read is thresholded: hit or nothing, no graded "probably seen" |

**(brainstorm) Argument 2 is a write-gate for the encoder, and it is the mirror of recall-gated consolidation.** [[wiki/concepts/recall-gated-consolidation.md]] gates the *slow* store's write on the fast store's recall of the *update pattern*, and it says explicitly that this is not a stimulus-novelty detector. Brown & Aggleton's argument uses a stimulus-novelty detector for the opposite job: to *exempt* the categoriser from writing. Mere occurrence is logged in a cheap side memory, and representation change is reserved for new associations or categories. Put together, a continual learner gets three write classes: (i) seen-before → no write, (ii) new item, no new association → side-memory write only, (iii) new association → store write, then consolidation if it recurs. [[wiki/concepts/continual-learning.md]]'s families gate writes by importance, replay, task boundaries, context, or recall of the update pattern. None of them vetoes *encoder* plasticity on item occurrence alone.

**(brainstorm) A reasoning benchmark is the regime where this gate tells you least.** Every ARC colour and shape is familiar after a few tasks, so an item-level gate saturates at "seen". The informative novelty is entirely arrangement novelty, which is the hippocampal side. A model whose only novelty signal is perirhinal-like will treat every new puzzle as old. This sharpens the high-reuse brainstorm on [[wiki/concepts/recollection-familiarity.md]].

**(brainstorm) NB gives a machine ablation its protocol.** Remove a model's item-novelty gate (or the pre-normalisation key-match scalar on [[wiki/concepts/key-value-memory.md]]) and score recognition at two compute budgets: few recurrent steps or an early exit, and the full budget. Bowles et al.'s prediction for a separate gate: accuracy falls only at the short budget, and the confidence distribution loses its middle. A gate that is just the store's own key match cannot show that pattern, because removing it also removes the read. So the ablation separates `T407`'s positions in a model the same way the deadline did in NB. An accuracy-only score at full budget would miss the deficit, as NB's clinical tests did.

---

## Limitations

- **One camp's review.** Written by the dual-process authors, citing mostly their own recordings and c-*fos* studies. Contrary data (Reed & Squire; Knowlton & Squire) are reported, but the scorecard is theirs.
- **The human perirhinal case is one partial, unilateral case.** Brown & Aggleton 2001 have no reverse case. Bowles et al. 2007 supply one (NB, above), but the resection also took amygdala, temporal pole and part of entorhinal cortex, the right hemisphere is intact, only verbal material was tested, and the left hippocampus is mildly atrophic. It is not the perirhinal-restricted lesion `T407`'s `Closes when` asks for.
- **NB's familiarity estimates are mostly borderline.** Experiments 1 and 3 reach P < 0.07 and P = 0.056 on the corrected estimates. The clearly significant results are raw "know" rates, Experiment 2, the ROC shape and the deadline ratio.
- **c-*fos* is coarse.** It shows which population changed, not what it computed, and Bures & Fenton's habituation reading (on [[wiki/concepts/recollection-familiarity.md]]) is not answered here.
- **"Perirhinal" usually means perirhinal + anterior TE.** The recording claims are about anterior inferior temporal cortex. How much of the code is perirhinal proper is not resolved.
- **The model is cited, not specified.** Bogacz et al.'s network is described only by its rule family and its efficiency claim. No equations or capacity figures are in the source.
- **Clip loss.** Table 1 (perirhinal vs hippocampal summary) and all figure content are absent.

---

## Connections

- **[[wiki/concepts/recollection-familiarity.md]]** — this region is the familiarity half of that page's dual-process model. That page holds the 1999 lesion matrix and the commentary debate; this page holds the module's specification (decrement, ~75 ms, >24 h, rare in the hippocampus) and the 2001 additions (c-*fos* double dissociation, Eldridge et al.'s "know is not a weak remember").
- **[[wiki/concepts/hierarchy-of-associativity.md]]** — supplies this region's place in the medial-temporal input stack and its afferents. The familiarity code adds a function to the stack's first stage: it registers prior occurrence before anything reaches the store. NB shows that this function is not just relaying: a partial first-stage removal costs familiarity and leaves the store's recollection normal (Bowles et al. 2007).
- **[[wiki/entities/ventral-visual-stream.md]]** — the encoder this region sits on top of. The long-term repetition signal is generated in perirhinal cortex/anterior TE, because repetition effects earlier in the cascade last only seconds, and a separate familiarity network lets the categorising cascade identify a novel item without rewriting its weights.
- **[[wiki/entities/entorhinal-cortex.md]]** — the next stage and the junction between the two systems: its neurons carry both stimulus familiarity and spatial information. Perirhinal cortex feeds its lateral (rodent) or rostral (macaque) part, and entorhinal lesions cost object recognition less, and less lastingly, than perirhinal ones.
- **[[wiki/concepts/key-value-memory.md]]** — the rival placement of the familiarity signal. That page reads it as the store's own key match; this region computes it at identification latency, outside the store, which is `T407` Position B's specification for where the gate lives. NB tests the placement: with part of this region removed, the store's recollection stays normal while the gate's graded signal is lost (Bowles et al. 2007).
- **[[wiki/entities/mediodorsal-thalamus.md]]** — the 1999 thalamic target for this region's familiarity output, now weakened: the perirhinal projection there is sparse, and mediodorsal lesions cost recognition less than perirhinal ones.
- **[[wiki/entities/nucleus-reuniens.md]]** — the measured thalamic target. This region projects massively to reuniens and the other midline/intralaminar nuclei, which makes them the candidate relay for the familiarity scalar.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the controller's write lands here: medial prefrontal cortex projects to superficial perirhinal layers and suppresses context-inappropriate object representations at the store's input. So this region is both a novelty reporter to the controller and a site the controller gates.
- **[[wiki/concepts/recall-gated-consolidation.md]]** — the mirror-image write gate. That page licenses slow-store writes when the fast store recalls the update pattern; Brown & Aggleton use a stimulus-novelty detector to *exempt* the categorising network from writing on mere occurrence.
- **[[wiki/concepts/complementary-learning-systems.md]]** — supplies the third memory system that page's two-store split omits: a one-trial item-occurrence record that is neither the fast store nor the slow learner, and that saves the slow learner from writing on every novel item.
- **[[wiki/entities/bb-model.md]]** — models this region's identity code (PRb/PRo) as frameless and handed in from outside. Its Papez lesion spares perirhinal recognition, which is the dissociation this page documents, but the model has no familiarity signal of its own.
