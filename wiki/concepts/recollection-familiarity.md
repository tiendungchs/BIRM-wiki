# Recollection and Familiarity — Two Signals Behind One Recognition Judgement, and Whether They Need Two Modules

**A recognition judgement ("have I seen this before?") can rest on two signals. *Familiarity* is a fast scalar computed from the item alone. *Recollection* is a slower retrieval of the item's context: where, when, and with what. Aggleton & Brown 1999 assign the two signals to two parallel temporal–thalamic systems: perirhinal cortex → mediodorsal thalamus for familiarity, and hippocampus → fornix → mammillary bodies → anterior thalamic nuclei for recollection. On this account, damage to the episodic store costs recollection and spares familiarity. Whether the two signals come from two modules or from one store read two ways is contested (`T407`).**

> **Provenance.** Aggleton & Brown 1999, *Episodic memory, amnesia, and the hippocampal–anterior thalamic axis*, Behav. Brain Sci. 22(3):425–489 (`raw/aggleton-1999-episodic-memory-amnesia-hippocampal-anterior-thalamic-axis.md`). Target article, 27 open peer commentaries and the authors' response. Converted from PDF (`LOSSY`). Table 1 (the rat lesion matrix) lost its tick/cross symbols, so the double-dissociation rows below come from the prose. Figures are captions only. Commentary claims are attributed to the commentator by name. The thalamic half of the model is on [[wiki/entities/anterior-thalamic-nuclei.md]] and [[wiki/entities/mediodorsal-thalamus.md]].

Why this earns a page. The wiki uses the recollection/familiarity split in at least six places and never states it. [[wiki/entities/esbn.md]] gets it from ablating one scalar. [[wiki/entities/bb-model.md]] gets it from a Papez lesion. [[wiki/concepts/key-value-memory.md]] reads familiarity as a key match. [[wiki/entities/posterior-cingulate-cortex.md]] assigns it to a subregion, and [[wiki/entities/hippocampal-prefrontal-channel.md]] says prefrontal damage spares it. This is the source that put the split on anatomy, and the debate that followed shows which parts are measured.

---

## Formalisms

| Object | Statement | Source of the form |
|---|---|---|
| Dual-process signal detection | `P("old" | studied) = R + (1 − R)·P(f > c)`, `P("old" | new) = P(f₀ > c)`; `R` is a threshold recollection probability, and `f`, `f₀` are equal-variance Gaussian familiarity values separated by `d′`. On the receiver-operating-characteristic (ROC) curve, `R` sets the y-intercept and `d′` sets the curvature | Yonelinas 1994; used in the Yonelinas et al. commentary. The equation is the standard form and is **not printed in the source** |
| Remember/know correction | "Know" responses are only possible when recollection fails, so `F = P(K) / (1 − P(R))`. Raw know rates underestimate familiarity | The constraint is stated in the source (Yonelinas et al.; authors' response). The correction formula is standard |
| Cue direction | Recall = retrieve an item from a context cue. Recognition = retrieve the context from an item cue | Hasselmo & Wyble 1997 model, cited by Mayes et al. A "biochemical lesion" in that model disrupts recall and spares recognition, with no familiarity term at all |

---

## The two systems

| | **Familiarity ("knowing")** | **Recollection ("remembering")** |
|---|---|---|
| Anatomy (A&B) | Perirhinal cortex → magnocellular mediodorsal thalamus (inferior thalamic peduncle, not the fornix) → medial/orbital prefrontal cortex | Hippocampus/subiculum → fornix → mammillary bodies + anterior thalamic nuclei → cingulate, prefrontal cortex. Return to the temporal lobe via the cingulum |
| Cue | The item alone | The item plus its spatial/temporal context |
| Process | Automatic | Effortful |
| Retrieval onset | ~100 ms **earlier** (Hintzman response-signal intercepts) | Later |
| Neural latency | Repetition decrement at 70–80 ms in inferotemporal cortex (Miller et al. 1993, cited by Hintzman) | 140–260 ms in hippocampus (Rolls et al. 1993, cited by Hintzman) |
| Best task | Item recognition, especially two-alternative forced choice | Free recall, associative recognition, source and order judgements |
| Lesion that removes it | Perirhinal cortex (object recognition) | Hippocampus, fornix, mammillary bodies, anterior thalamic nuclei (allocentric spatial memory, object-in-place, recall) |

Most amnesias damage **both** systems, which is why recall and recognition usually fall together. A&B's claim is that the two can come apart, not that they usually do.

---

## The perirhinal familiarity code

Brown's recordings in monkey (and rat) perirhinal cortex, as summarised in the target article.

| Property | Value |
|---|---|
| Sign | A **decrement**: the response to a repeated stimulus falls. Monkey cells that *increase* on repetition occur less often than chance |
| Learning | **One trial** is enough |
| Persistence | Often survives 24 h, or hundreds of intervening stimuli |
| Specificity | Stimulus-specific. A cell that has habituated to one stimulus still responds strongly to a novel one |
| Fraction | ~20–25% of visually responsive perirhinal neurons. The rest code physical properties and do not change with repetition |
| Cell types | *Recency* cells (seen recently, regardless of how often), *familiarity* cells (seen often, regardless of how recently), *novelty* cells (first presentations only) |
| Where else | Area TE and entorhinal cortex. Medial-dorsal and paraventricular thalamic neurons also decrement, in small numbers (Fahy et al. 1993) |
| Where not | Rare in monkey and rat hippocampus. Rat c-*fos* confirms this |
| Endogenous | Present under passive viewing, and for stimulus types the animal was never trained on |

**The readout is relational.** Changing and unchanging cells are intermingled, so comparing the two gives a prior-occurrence signal that controls for stimulus drive. Population measures can therefore separate recency from familiarity.

**Eacott's dissent.** Perirhinal lesions spare small-stimulus-set match-to-sample and impair learning with many or confusable stimuli. Her reading is that perirhinal cortex *identifies objects uniquely*, and the novelty response is a by-product of building a new representation. A&B reply that mediodorsal lesions show the same set-size effect and cannot be perceptual.

---

## What the hippocampus signals: arrangement novelty, not item novelty

| Result | Reading |
|---|---|
| Rat c-*fos*, novel vs familiar objects, within-subject paired viewing: perirhinal cortex, TE and ventral lateral geniculate rise; **hippocampus does not** (Zhu et al. 1996) | Item novelty does not engage the store |
| Novel vs familiar **context**: hippocampus (CA1–4) shows a fourfold increase relative to perirhinal cortex (Zhu et al. 1997) | Context novelty does |
| Novel **rearrangement** of familiar objects: postrhinal cortex and CA1 rise, dentate gyrus and subiculum *fall* (Wan et al. 1999) | The store responds to a new configuration of known parts. Its subfields respond with opposite signs |
| Hippocampal lesions spare orienting and habituation to novel stimuli, and abolish orienting when familiar cross-modal pairs are **re-paired** (Honey et al. 1998) | Lesion version of the same result: novelty detection survives, mismatch detection does not |
| Fornix lesions impair place discrimination only when the places share elements in rearranged positions (Gaffan & Harrison 1989). Object-in-place learning needs the fornix, mammillary bodies and anterior thalamic nuclei; cingulate ablation is mild (Parker & Gaffan 1997) | The "snapshot" of a scene's arrangement is what the circuit stores |
| Large featureless test boxes make rat recognition hippocampus-dependent. Small boxes, encoded as objects, do not (Cassaday & Rawlins 1995, 1997) | Whether a stimulus is an *object* or an *array* decides which system handles it |
| Mayes et al.'s selective-hippocampal patient: normal item recognition; impaired object–location, temporal-order and face–voice recognition | The split runs between item and association, not between recognition and recall |
| Item recognition rests mainly on familiarity, associative recognition on recollection (Yonelinas 1997 ROC) | The same split, measured in healthy subjects |

---

## The double dissociation

| Lesion (rat unless noted) | Allocentric spatial memory (T-maze alternation, radial maze, delayed non-match to position, water maze) | Object recognition (spontaneous, delayed non-match to sample) |
|---|---|---|
| Hippocampus, fornix, anterior thalamic nuclei | Impaired (largest) | Spared |
| Mammillary bodies, cingulum bundle | Impaired (smaller) | Spared |
| Same four sites, **egocentric** constant-turn task | Spared | — |
| Perirhinal cortex | Spared (Ennaceur et al.; contested by Bilkey: deficits at delays > 1 min, radial and water maze) | Impaired |
| Perirhinal + postrhinal + TE together | Spared, including radial maze with arm rotation and a 30-min delay. Some spatial tasks are **enhanced** (Bussey et al. 1999) | Impaired |
| Monkey fornix vs perirhinal (Gaffan 1994a) | Fornix: severe spatial reversal deficit. Perirhinal: none | Perirhinal: severe scene-recognition deficit. Fornix: mild |

Mumby's commentary adds a **within-subject** version (Glenn & Mumby 1996). The same rats were tested on both tasks, with the same delays and trial-unique stimuli. Hippocampal lesions impaired delayed match to place and spared object non-match; perirhinal lesions did the reverse.

---

## Clinical anchors

| Case or group | Pattern |
|---|---|
| 112 amnesics in 11 aetiologies on Warrington's Recognition Memory Test (Aggleton & Shaw 1996) | Three groups scored at age norms: hypoxic hippocampal, fornix, and selective diencephalic |
| Colloid-cyst surgery, 10 patients (authors' response) | Only the 3 with **bilateral** fornix interruption had severe new-learning deficits. Their recognition was disproportionately spared |
| The same 3, Recognition Memory Test given twice in a row | The fornix deficit **grows** on the second pass, when every stimulus is familiar |
| Mammillary-region case BJ (Dusoir et al. 1990) | Permanent recall deficit; normal delayed match-to-sample on abstract patterns, where other amnesics with matched recall scores failed |
| Anterior thalamic infarct (Schnider et al. 1996) | Recognition marred by false positives; normal with nonsense words and designs, where context cannot help |
| Three developmental hippocampal cases (Vargha-Khadem et al. 1997) | Episodic amnesia with relatively preserved recognition and near-normal semantic learning |
| Patient EP (Hamann & Squire 1997) | Chance recognition with intact priming. Familiarity is therefore not priming |
| Thalamic infarct at the internal medullary lamina, sparing mediodorsal, anterior nuclei and mammillothalamic tract (Witter & Van der Werf) | The reverse: impaired face recognition, spared visual association learning |

---

## Contested points

| Claim | Challenger | Evidence | A&B's reply |
|---|---|---|---|
| Hippocampal damage spares item recognition | Zola & Squire | 6 of 7 monkey studies with lesions limited to the hippocampus find recognition deficits. CA1-only patients RB and GD are impaired. Severity grows with the number of medial-temporal structures damaged | Ischaemia brings hidden pathology (the ischaemic group's published 10-min score is 61%, not 68.1%). Neurotoxic lesions show no deficit at 40 min (Murray & Mishkin 1998). Amnesics are impaired at 40 s, and no monkey hippocampectomy reproduces that |
| Remember and know are independent | Knowlton | Over one week, 29% of items move from remember to know and 10% the other way. Her conclusion: know is redundant with remember | Know is mathematically constrained by remember, so conversion rates cannot test independence |
| Recognition has two processes | Pickering | In 6 yes/no studies, a familiarity-only model fits ROCs better than a dual-process model, and neither fits acceptably. Two-alternative forced-choice data fit worse | Unresolved; more studies needed |
| Amnesia spares familiarity | Yonelinas et al. | Re-analysis with bias correction (remember/know, process dissociation, ROC) converges: amnesics lose both, and recollection disproportionately | Consistent with the model, since most amnesics have both systems damaged |
| The split is by **attribute**, not process | Kesner; Knowlton; Mumby | The hippocampus does familiarity and recollection for space, perirhinal cortex does both for objects | Combined perirhinal + postrhinal lesions spare spatial memory although that cortex receives spatial input. Cytoarchitecture differs: convergent columns in ventral temporal cortex, divergence in the hippocampus |
| The thalamic leg is the mediodorsal nucleus | Witter & Van der Werf; Mair et al.; Parker | Perirhinal → mediodorsal fibres are sparse. Perirhinal cortex projects massively to midline/intralaminar nuclei. Mediodorsal deficits look prefrontal | Partly conceded: prefrontal interactions "may prove to be partly at the expense of" the perirhinal–mediodorsal link |
| Familiarity is fluency (priming) | Mayes et al. | Parsimony | Rejected. Hintzman: changing study modality leaves the recognition intercept unchanged, so exact perceptual repetition is not what recognition reads |

---

## How it maps to model components

| Signal | Machine reading |
|---|---|
| Perirhinal repetition decrement | A **one-shot, item-level novelty scalar** computed on the encoder's own representation, with no binding. It persists across hundreds of intervening items and is specific to each item |
| Hippocampal arrangement response | A **mismatch signal on associations**: known parts in an unexpected configuration |
| Recollection | An associative read of the store that returns the item's bindings (context, location, order) |
| Familiarity's earlier onset | A cheap gate available before any value is read, the role [[wiki/concepts/key-value-memory.md]] assigns to key matching |

**(brainstorm) Node novelty and edge novelty are two different update triggers, and every machine novelty signal merges them.** In [[wiki/concepts/latent-graph-discovery.md]] terms, perirhinal cortex reports an **unseen node** and the hippocampus reports an **unseen arrangement of seen nodes**. Each calls for a different write: allocate a node, or revise an edge. A system with one novelty signal (prediction error, count-based curiosity, a reconstruction loss) cannot tell "a new thing" from "familiar things in a new configuration". The c-*fos*, Honey and Cassaday results say the brain keeps the two on separate populations and lesions them separately. The buildable version is two detectors: a per-item habituation trace on the encoder's output, and a mismatch on the store's predicted bindings. Their disagreement then chooses the write. Nothing in the wiki builds either one as a routing signal.

**(brainstorm) Familiarity fails in high-reuse regimes, which is where reasoning tasks live.** The fornix group's deficit grew when the Recognition Memory Test was repeated and every stimulus became familiar. Owen & Butler's fornix-lesioned monkeys were likewise worse with repeated stimuli. Once all candidates are familiar, familiarity carries no information, and only recollection (which context this item was in) can discriminate. Abstract-reasoning benchmarks draw on small, heavily reused vocabularies (the same colours, shapes and tokens in every problem). A model that answers "did this occur?" by a match score will therefore saturate exactly there. Its retrieval needs a context-bound read, not a stronger match.

**(brainstorm) The two signals arrive in the order a controller needs them.** Familiarity becomes available ~100 ms before contextual detail. That is the timing for a "should I retrieve?" gate ahead of an expensive retrieval. Under Position B of `T407`, the gate is computed by a module *outside* the store, so it survives the store's failure and could supervise it. Under Position A, it is the store's own key match and fails with it.

---

## Open problems

- **No recording separates the two streams' cargo.** The decomposition rests on lesion double dissociations and on c-*fos*, a coarse activity marker. Bures & Fenton argue the c-*fos* decrement could be habituation, not recognition.
- **Recognition in animals cannot be assigned to a process.** Mumby: rats may solve delayed non-match to sample by whichever strategy their lesion leaves. A&B concede that no independent test shows when an animal is using recollection.
- **Episodic memory has no rat assay.** Clayton & Dickinson 1998's what–where–when test exists for scrub jays only. Rat "recollection" results are spatial or scene results, and Burwell & Eichenbaum, Bures & Fenton, and Whishaw all object to treating space as a proxy for episodes.
- **The human perirhinal boundary is uncertain** (Graham & Hodges), so human perirhinal cases cannot yet test the familiarity half.
- **The thalamic leg of familiarity is unassigned**: mediodorsal, midline/intralaminar, or mediodorsal acting through prefrontal cortex.

---

## Connections

- **[[wiki/entities/anterior-thalamic-nuclei.md]]** — the thalamic node of the recollection system. A&B's 1999 reformulation put these nuclei at the core of anterograde amnesia, and their lesions reproduce the hippocampal profile: allocentric spatial and object-in-place deficits with object recognition spared.
- **[[wiki/entities/mediodorsal-thalamus.md]]** — the proposed thalamic node of the familiarity system. Its neurons decrement on repetition and its lesions impair recognition for large stimulus sets as perirhinal lesions do, but the perirhinal input is sparse, and A&B partly concede that its role runs through prefrontal cortex.
- **[[wiki/entities/hippocampal-diencephalic-cingulate-network.md]]** — the anatomy of the recollection system traced edge by edge. The 1999 "extended hippocampal system" is this network's fornix-borne diencephalic route, picked out because it carries the store's output to the diencephalon.
- **[[wiki/concepts/key-value-memory.md]]** — the computational reading of familiarity as a key match that completes before any value is read. Hintzman's ~100 ms earlier recognition intercept is the timing evidence for it. `T407` asks whether that key belongs to the store or to a separate cortical module.
- **[[wiki/entities/esbn.md]]** — the same split produced by ablating one scalar: without the per-row confidence, tasks that need *how well* a memory matched fail and tasks that need *which* row matched survive. That is the familiarity/recollection pattern inside one store, which is Position A's shape.
- **[[wiki/entities/bb-model.md]]** — the recollection half run as a model: removing the head-direction input to its frame-conversion bank abolishes recollection and leaves perirhinal recognition intact, which is the 1999 prediction for a Papez-circuit lesion.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the two-store account this page splits further. CLS's fast store does recollection, but A&B put familiarity in a third place: neither the fast store nor the slow neocortical learner, but a perirhinal item code learned in one trial.
- **[[wiki/concepts/hippocampal-indexing-theory.md]]** — its behavioural ledger has the same dissociation in rat form: hippocampal damage leaves novelty preference intact and removes object–context and object–location binding. An index that holds no content matches recollection's job and leaves familiarity to cortex.
- **[[wiki/entities/nucleus-reuniens.md]]** — a candidate thalamic node for familiarity. Witter & Van der Werf report that perirhinal cortex projects massively to reuniens and the central medial nucleus and only sparsely to mediodorsal, and they report a familiarity deficit from a midline/intralaminar infarct.
- **[[wiki/entities/posterior-cingulate-cortex.md]]** — places the split on cortex: the dorsal subregion supports item recognition and familiarity, the ventral one autobiographical recall and recollection, so the two signals stay separate past the thalamus.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the prefrontal side of the split: prefrontal damage spares familiarity-based recognition and impairs recollection-based retrieval. A&B add that prefrontal cortex receives both signals and that its role in recognition is likely underestimated.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the node/edge reading: perirhinal cortex flags unseen items (nodes), and the hippocampus flags familiar items in an unseen arrangement (edges). These are two different triggers for revising a discovered graph, and machine novelty signals do not separate them.
