# Retrieval-Mediated Learning

**A new event is encoded not only against what is present but against what the store *retrieves* while it is present: overlapping content cues reinstatement of a prior episode's unseen elements, and the current event is bound to the reinstated content rather than to the input alone. The composite `A–C` is therefore written at encoding time, before any query for it exists — not composed at retrieval.**

> **Provenance.** Zeithamova, Dominick & Preston 2012, *Hippocampal and ventral medial prefrontal activation during retrieval-mediated learning supports novel inference*, Neuron 75:168–179 (`raw/zeithamova-2012-retrieval-mediated-learning-inference.md`). 26 subjects, block-design fMRI, associative-inference triads (`A–B`, `B–C` interleaved; tested on `A–C`), with multivoxel pattern analysis used to read out the *unseen* third element during encoding. The wiki already carried this result secondhand through Preston & Eichenbaum 2013 ([[wiki/concepts/schema-assimilation.md]]); this is the primary source, and it supplies the measurement the review only summarised. A second primary source, Shohamy & Wagner 2008 (acquired equivalence with a midbrain gate and a latency test), has its own section below. A third, Schlichting et al. 2015 (item-level integration and separation codes, with the training schedule manipulated within subjects), has the section after it.

---

## The mechanism, as two separable stages

| Stage | Operation | Where measured | Signature |
|---|---|---|---|
| 1. **Reactivation** | Overlapping content (`B`) cues reinstatement of the associated-but-absent element (`C`) | Ventral temporal cortex (inferotemporal + fusiform + parahippocampal), read by a classifier trained elsewhere | Classifier evidence for the *unseen* content class rises across repetitions |
| 2. **Binding** | The reinstated content is bound to the currently presented pair | Hippocampus | Learning-related activation *decrease* predicts later inference |
| (3. **Transfer/organization**) | The integrated structure is taken up by the controller | Ventromedial prefrontal cortex | Learning-related activation *increase* predicts later inference |

The paper's own point is that prior work — Tse's schema rats, Iordanova's hippocampal-plasticity block — *presumed* stage 1 without measuring it. Everything downstream of "existing memories are reactivated during new learning" was inference from the behavioural consequence.

---

## The measurement, and why it is the importable part

The design isolates reactivation by holding *presented* content fixed and varying *unseen* content. Triads are typed by content class — three objects (`OOO`), two objects + a scene (`OOS`), three scenes (`SSS`), two scenes + an object (`SSO`). The `AB` pair of an `OOO` triad and the `AB` pair of an `OOS` triad are both object–object; they differ only in what `C` is.

```
scene reactivation  = Δ(scene classifier | OOS·AB) − Δ(scene classifier | OOO·AB)
object reactivation = Δ(object classifier | SSO·AB) − Δ(object classifier | SSS·AB)
reactivation index  = pooled, with Δ = (last AB repetition − first AB repetition)
```

| Repetition of `AB` | Classifier output for the unseen class | Reading |
|---|---|---|
| 1st (before any `BC` exposure) | **No difference** (p = 0.94 scenes; p = 0.87 objects) | The design's own null control — nothing to reactivate yet |
| 2nd | Significant (p = 0.04; p = 0.002) | Reinstatement is online and appears after one exposure to the overlap |
| 3rd | Significant (p = 0.02; p = 0.02) | Sustained |

Controls that make this a measurement rather than a correlation: item and association repetition counts are matched across the compared conditions, so novelty is differenced out; a three-way classifier reproduces the effect, so it is not an artefact of forced choice; inference accuracy is equal for within-content and cross-content triads (82% vs 83%), so it is not difficulty.

**Behaviour.** Direct associations 91.8% ± 5.8; inference (`A–C`) 82.3% ± 8.6, **range 66–98%** — the individual-difference spread is what the whole analysis is levered on.
**Reactivation index × inference accuracy: r = 0.46, p = 0.02.** Reinstating more of the absent element predicts inferring better later.

**(brainstorm) The runnable version, and it is cheap.** Any model with a content classifier over its hidden states can be given this design: train a probe on an independent localizer set, then present overlapping pairs and probe for the *third* item's class during re-presentation of the first pair. A model that composes at query time returns the first-repetition null at *every* repetition; a model that integrates at encoding returns the rising curve. This is a direct behavioural-free discriminator for [[wiki/empirical-tensions.md]] T334, it needs no new architecture, and no memory-augmented model in the wiki has been run against it.

---

## The regional dissociation: three regions, three different jobs, three different signs

Learning-related change = (last presentation − first presentation) of `AB`/`BC`. Correlated across subjects against the reactivation index and against inference accuracy. Thirteen ROIs tested; the specificity is the result.

| Region | Correlates with **reactivation index** | Correlates with **inference accuracy** | Survives partialling out premise memory |
|---|---|---|---|
| **Anterior MTL cortex** (perirhinal + entorhinal) | **r = 0.54, p = 0.004** — the *only* region of 13 | — | — |
| **Hippocampus** | not (r = 0.46 with aMTL change, but not with the index) | **decrease**, r = 0.51, p = 0.008 | right hemisphere only (partial r = 0.39) |
| **Ventromedial PFC** | no | **increase**, r = 0.38, p = 0.05 | **yes, and strengthens: partial r = 0.53, p = 0.007** |
| Frontal pole, precuneus, superior parietal | no | **no** (all r < 0.14) — despite rising hippocampal coupling | — |

Three claims a builder can use:

- **The store that binds is not the store that reports reactivation.** The proposed route is `hippocampus → anterior MTL cortex → ventral temporal reinstatement`, following the anatomy (ventral temporal reaches hippocampus only via entorhinal, which is fed by perirhinal/parahippocampal, with reciprocal return). So the magnitude of reinstatement is legible at the *interface* while the binding that determines success happens in the store — a module whose activity does not report its own critical operation.
- **The two signs are the division of labour.** Hippocampal activation *falls* across repetitions in good inferrers; vmPFC *rises*. Read as: the fast store's binding work is front-loaded and its demand decays as the structure stabilises (or its code sparsifies), while the controller's engagement accrues. Same task, same repetitions, opposite derivatives — and both predict the same behaviour.
- **The connectivity increase alone is not evidence of function.** Frontal pole, precuneus and superior parietal all increased hippocampal coupling across repetitions exactly as vmPFC did, and none of their activation predicted inference. Coupling changes are cheap; the paper's own specificity control is worth importing as a habit ([[wiki/concepts/effective-connectivity.md]]).

---

## The connectivity result has an unusual control built into it

Hippocampal-seeded connectivity with vmPFC increases with **repetition number within a run** (linear trend F(1,21) = 9.78, p = 0.005) and **not across runs** (F < 1; repetition × run interaction n.s.).

This is the shape that rules out the boring explanations. Time on task, fatigue, arousal drift and practice at the task *format* are all monotonic in run number and flat in within-run repetition; the effect is the reverse. What resets each run is the *set of overlapping associations being built*, so the coupling tracks the formation of a particular integrated structure and is discharged when that structure is done.

**(brainstorm)** That makes hippocampus–vmPFC coupling a per-structure transient rather than a mode. A machine analogue would be a controller–store bandwidth that rises while a new relational set is being assembled and falls once it is, which is a schedule no consolidation mechanism in the wiki has: replay filters *which* items move ([[wiki/concepts/offline-replay.md]]), recall-gating decides *whether* to move them ([[wiki/concepts/recall-gated-consolidation.md]]), nothing modulates *how wide the channel is* as a function of assembly progress.

---

## Why the partial correlation is the load-bearing statistic

Premise memory and inference accuracy correlate at r = 0.76. So any encoding signal that predicts inference could be predicting nothing but "this subject learned `A–B` and `B–C` well", with the inference then computed at test from two strong direct associations. That is the on-the-fly account, and it explains the raw correlations without any integration.

Partialling premise performance out:

| Effect | Raw | Partial |
|---|---|---|
| vmPFC increase → inference | r = 0.38 | **r = 0.53** (stronger) |
| Bilateral hippocampal decrease → inference | r = 0.51 | r = 0.22, n.s. |
| Right hippocampal decrease → inference | — | r = 0.39, p = 0.05 |
| Every other region (13 tested) | — | none (inferior frontal gyrus pars orbitalis r = 0.38, p = 0.06 trend) |

**vmPFC encoding activity predicts inference over and above how well the premises were learned.** That is the finding that makes the encoding-integration account non-vacuous, and it is why the study is cited as settling a controversy the fMRI literature had not been able to. Note the cost: the hippocampal effect mostly *does not* survive, which is a weaker result than the wiki's secondhand version implied.

**The lesion version of the partial correlation** (Spalding et al. 2018, [[wiki/entities/medial-prefrontal-cortex.md]]). Same task family, two of the same authors, blocked `AB` → `BC` training, 3AFC. Focal bilateral vmPFC lesions (`n = 5`) leave direct-pair accuracy equal to controls' and near ceiling. `AC` falls to 0.48 against 0.76 (chance 0.33). The deficit survives restricting to triads with both premises correct. Models fitted on control data predict the patients' `AC` from their premise scores and overshoot by 23–66%. So vmPFC is *necessary* for inference beyond premise accuracy, which is the causal form of the statistic above.

| What it adds | What it does not |
|---|---|
| Necessity, where this page had a between-subject correlation | **When** vmPFC acts. The lesion spans encoding and test, so it does not separate this page's write-time account from a read-time role |
| Explaining the structure before the test does not rescue inference, and awareness of the overlap does not differ between groups | Equal 3AFC accuracy is not equal trace strength. The vmPFC group's later `AB` retest drops more (0.96 → 0.78 vs 0.98 → 0.91), so weaker premises remain a live account ([[wiki/entities/remerge.md]]) |
| A second candidate job: the authors read that `AB` decline as retroactive interference that an integrated `ABC` would prevent | The decline cannot be told apart from decay: there is no non-overlapping control trained with `AB` |

---

## Where this sits in the core framing

In [[wiki/concepts/latent-graph-discovery.md]]'s terms, an associative-inference triad is the minimal latent graph: two observed edges `A–B`, `B–C`, one unobserved path `A–C`. There are exactly two places to pay for the path.

| | **Write-time (integrative encoding)** | **Query-time (on-the-fly composition)** |
|---|---|---|
| What is stored | A composite structure in which `A` and `C` already co-occur | Two independent edges |
| What the reader needs | A one-step lookup | A traversal / composition operator, run under the query's latency budget |
| Cost profile | Paid once per encoding episode, whether or not the path is ever queried | Paid per query, scaling with path length |
| Failure mode | Loss of the individual episodes' distinctness; the schema distorts the item | Failure at depth; each hop compounds error |
| Evidence here | Reactivation curve; vmPFC partial correlation | The premise/inference r = 0.76 the partial correlation exists to remove |

The paper argues the brain pays at write time and does it *speculatively* — the `A–C` composite is built during learning for a query that has not been asked, which is what "memory is intrinsically prospective" cashes out to mechanically. This is the sharpest instance in the wiki of a store that anticipates its own read.

**(brainstorm) Neither pure policy is right and the wiki should say what selects between them.** Write-time integration over every pair of overlapping episodes is combinatorially hopeless; query-time composition over an unbounded graph is the multi-hop failure every retrieval-augmented model shows. That failure is partly a *single-read* failure: re-grounding each hop with its own retrieval gives 40–50% fewer chains with a factual error than one question-based read, still with nothing integrated at write time ([[wiki/entities/ircot.md]], Trivedi et al. 2023). What this study supplies is a *trigger*: integration runs when reinstatement happens, and reinstatement happens when the current input overlaps a stored episode strongly enough to complete it. So the selection rule is not a policy choice but a property of the store — pattern completion decides, and the integration budget is spent exactly where the fast store cannot help firing ([[wiki/concepts/pattern-separation-completion.md]]). That is implementable and no memory architecture here does it.

---

## Relation to the other reinstatement mechanisms in the wiki

| Mechanism | When it runs | External input present? | What it is for |
|---|---|---|---|
| **Retrieval-mediated learning** (this page) | During encoding of an overlapping event | **Yes** — retrieval *inside* an encoding episode | Manufacture the conflict/overlap that integration needs |
| [[wiki/concepts/offline-replay.md]] | Rest, sleep, ripple events | No | Transport, tagging, resampling the experience stream |
| [[wiki/concepts/encoding-retrieval-alternation.md]] | Every theta cycle, 4–8 Hz | Alternating | Keep the two modes from corrupting each other; supply a contrastive delta |

**The third row is the interesting friction.** Hasselmo's theta model exists precisely to *prevent* retrieval and encoding from co-occurring, because completion contaminating the encoding phase destroys separation. Retrieval-mediated learning requires the contamination — the reinstated `C` must be present while `A–B` is being written, or there is nothing to bind. The reconciliation available: alternation separates them at 150 ms while binding operates across the cycle, so the reinstated content is *held* from the trough into the next peak rather than being co-active within one phase. Nobody has measured whether reinstated absent-item content respects theta phase, and if it does not, one of the two models is wrong about what the phase gates.

---

## The default-network coincidence, and what it is worth

Hippocampal coupling rose with vmPFC, frontal pole, precuneus and superior parietal — a default-network set ([[wiki/entities/default-mode-network.md]]) also engaged by future simulation and episodic construction. The authors read this as support for the default network building prospective mental models.

**Caveat the paper's own data supplies:** three of the four regions' activation predicted nothing about inference. The coupling is real; the functional attribution rests entirely on the network label. Recorded here as network-level evidence of the weak kind ([[wiki/empirical-tensions.md]] T262 on what a coupling change licenses).

---

## Limitations

- **Every brain–behaviour claim is a between-subject correlation** on n = 26, with three subjects excluded for poor performance — which truncates the low end of exactly the individual-difference axis the analysis depends on. r = 0.38 at p = 0.05 is one subject away from nothing.
- **Block design, standard-resolution fMRI.** Hippocampal subfields are not separable, so "the hippocampus binds" is a claim about a mixed CA1/CA3/DG/subiculum signal; the authors say high-resolution multivariate work is needed to isolate reactivation from binding *within* the medial temporal lobe.
- **Activation decrease is over-determined.** Repetition suppression, sparsification of an integrated code, decreased binding demand, and memory search are all offered by the authors as readings of the same falling hippocampal signal, and the design does not distinguish them. Any model that predicts a *rise* is not thereby refuted.
- **Reactivation is measured for content class, not content.** The classifier reads "a scene was reinstated", not "*that* scene". Whether the reinstated representation is item-specific — which is what binding requires — is not shown.
- **The vmPFC interpretation is unconstrained.** Rising vmPFC is compatible with (i) transfer of the integrated memory to cortex for permanent storage, (ii) online organization/resolution of the overlapping representations, and (iii) schema selection. The authors state (i) and (ii) as alternatives and pick neither.

---

## The named rival, and why the source that proposes it says the evidence cannot separate them

> Kumaran & McClelland 2012 (`raw/kumaran-2012-generalization-recurrent-interaction-episodic-memories-remerge.md`), and its summary in Kumaran, Hassabis & McClelland 2016 (`raw/kumaran-2016-complementary-learning-systems-updated.md`). Full treatment: [[wiki/entities/remerge.md]].

This page's mechanism is what the complementary-learning-systems literature calls an **encoding-based overlap** model — the hippocampus stores a representation that *integrates* overlapping pairs. REMERGE is the **retrieval-based** alternative built to get the same behaviour without giving up pattern separation: the similarity computation over separated traces is recirculated — its output combined with the external input and fed back — until the system settles, and the higher-order similarity that links `A` to `C` through `B` appears in the settled state rather than in any stored code.

| | This page (encoding-based) | REMERGE (retrieval-based) |
|---|---|---|
| When the composite exists | during encoding of the overlapping episode | only while the query is settling |
| What the store holds | an integrated `ABC` representation | separated `AB`, `BC` traces |
| Predicted dissociation | reactivation magnitude at encoding predicts inference (measured here, r = 0.46) | inference **lags** premise memory and is lost first when premise traces weaken. The review's "weak traces suffice" holds only for categorization ([[wiki/entities/remerge.md]]) |
| What explains good vs poor generalizers | an integrated representation in good generalizers only | premise weights 1.52 vs 1.47 fit 73% vs 54% inference (Zeithamova & Preston 2010 data) |
| Cost | paid once per episode, queried or not | paid per query, bounded by settling time |
| Test latency, unobserved vs trained pair | equal: 39 ms gap in the best acquired-equivalence generalizers (Shohamy & Wagner 2008, below) | longer, if settling cycles map onto response time. Not simulated **(brainstorm)** |

**The source's verdict is that the two are not currently distinguishable**, that both may run depending on paradigm, training amount and training–test delay, and — importantly for `T334` — that the distinction is **not absolute**: *generalized replay* (simultaneous reactivation of several related traces, offline) can write a settled state back as a new trace, at which point a retrieval-based mechanism has manufactured the composite this page measures. So the wiki's two positions are plausibly the same loop observed at different points, with the offline period as the converter.

**What this page's measurement still buys against REMERGE.** The reactivation curve is read out during re-presentation of `AB` **with no query pending** — nothing is being asked, so there is no settling process to attribute it to. A pure retrieval-based account has to explain why the absent element is reinstated at encoding time at all. That is the sharpest constraint in the wiki on the retrieval-only pole, and neither source states it. **It is weaker than it looked.** The primary REMERGE paper fits a hippocampal encoding effect of the same kind (activity on `BC` trials predicts later `A–C`, Zeithamova & Preston 2010) as plain completion of the stronger `AB` trace when `B` reappears. That reinstatement needs no query and no integrated unit. So reinstatement of an absent element at encoding does not by itself favour this page. The part that still does is the ventromedial prefrontal effect surviving the partialling-out of premise memory, which trace strength cannot produce.

**The rival now has the circuit measurement this page has for its own side** (Koster et al. 2018, [[wiki/entities/remerge.md]]). The same paired-associate design is used, with two changes that favour retrieval: only **two** exposures per pair, and `AC` tested before its premises. The measurement is taken at **test** instead of encoding. The absent `B` is decodable from the superficial (input) entorhinal layers on `AC` trials, and deep → superficial connectivity predicts that, re-entry into dentate gyrus/CA3, and `AC` accuracy (r = 0.38). Deep-layer reinstatement does not predict accuracy (r = −0.20). That is the only signal an encoding-based composite would put there. `AC` is ~800 ms slower than `BC`. Reinstatement of an absent element is therefore measured at both ends: at encoding with no query (this page) and at test, travelling back into the store (there). No study has measured both in one set of subjects, which is `T334`'s `Closes when`.

---

## Second primary source: integration gated by the midbrain (Shohamy & Wagner 2008)

> Shohamy & Wagner 2008, *Integrating memories in the human brain: hippocampal–midbrain encoding of overlapping events*, Neuron 60:378–389 (`raw/shohamy-2008-integrating-memories-hippocampal-midbrain-overlapping-events.md`). n = 24 (3 non-learners excluded), event-related fMRI, acquired-equivalence design. The supplement was not clipped, so claims that rest on it are marked *(suppl.)*. The Figure 6 caption lost its subscripts, so the text's reading is used. Before this ingest the wiki carried the study only through REMERGE's fit to it ([[wiki/entities/remerge.md]]).

**Design.**

| Phase | Content |
|---|---|
| Learning (two scans: early, late) | 12 sets × 3 trained pairs `F1–S1`, `F2–S1`, `F1–S2` (36 pairs). A face is shown, the subject picks 1 of 2 scenes, feedback follows. 8 repetitions per pair, **intermixed** (no pair twice in a row). The correct scene for one face is the foil for another, so stimulus–response learning cannot solve the task |
| Test (no feedback) | Trained pairs plus the untrained `F2–S2`, each shown 6 times |
| Pre-exposure | Half the stimuli shown alone beforehand. No effect on learning or generalization, so the data are collapsed across it |

`F2–S2` is **acquired equivalence**: `F1` and `F2` share `S1`, so what `F1` gets (`S2`) transfers to `F2`. It is not a chain `A–B–C` with a hidden middle item.

**Results.**

| Measure | Result |
|---|---|
| Trained accuracy | 57% → 80% (scan 1), 86% → 93% (scan 2), 93% at test |
| Generalization | 81% mean, **range 38–100%**, stable over the 6 test repeats |
| Good vs poor (median split) | 96% vs 66% generalization. The gap is larger than on trained pairs, and persists when trained performance is equated *(suppl.)* |
| Encoding predictor | The early → late **increase** in bilateral hippocampus and VTA/SN (ventral tegmental area / substantia nigra) correlates with generalization (p < .05, small-volume corrected). It survives dropping the >95% generalizers (n = 16: r = .60 left hippocampus, .68 right, .63 midbrain) |
| Group × learning phase | The good group increases (p < .001), the poor group is flat (p > .60). Right hippocampus F(1,22) = 4.31, midbrain 4.70, left hippocampus 3.25 (p = .08) |
| Midbrain–hippocampus covariance | Across subjects, the midbrain change predicts the hippocampal change (p < .001 both sides; r = .59 / .75 without the two most extreme subjects). Selective to hippocampus *(suppl.)* |
| Striatum (caudate) | Engaged by feedback learning, declines as errors decline, unrelated to generalization *(suppl.)* |
| Test-phase activation | No hippocampal difference between generalization and trained probes, and no correlation with generalization *(suppl.)*. This is a null result |
| Latency | (trained − generalization RT gap) × generalization accuracy: **r = −0.69**. Group × trial type F(1,22) = 31.3. On the first encounter alone, F = 4.61, p < .05. Top quartile (n = 6): **39 ms** gap, and half of them were faster on generalization probes |
| Event type | The correlation is strongest for `F2–S1` learning trials, and the midbrain good-group increase is selective to them. There is no trial-type interaction, so this is suggestive only |
| Awareness | 2 of 24 noticed novel pairs at test, both poor generalizers |

**What it adds to the write-time account.**

| Finding | Consequence for a builder |
|---|---|
| Good generalizers answer the untrained pair as fast as the trained ones | A behavioural discriminator that needs no probe: a query-time composer pays per hop at test, a write-time integrator does not. **(brainstorm)** It runs on any machine with variable compute (settling steps, retrieval rounds, reasoning tokens). Compare the compute spent on `F2–S2` with that spent on trained probes. Equal compute means the link was stored, extra compute means it was composed |
| **The midbrain gate.** The source's mechanism, built on Lisman & Grace 2005's hippocampal–VTA loop: `S1` in an `F2–S1` trial retrieves `F1`. Its mismatch with the present `F2` produces a hippocampal novelty signal, which drives the VTA. Dopamine then raises hippocampal plasticity, and the two episodes are encoded as one | Integration is triggered by an **episodic prediction error**: a mismatch between retrieved and present content, not between expected and received reward. This is the same family as [[wiki/concepts/state-prediction-error.md]]. The evidence is human and correlational here, causal and in rats there. **(brainstorm)** The loop is a biological form of *read before you write*: the store's own retrieval decides whether a write is needed ([[wiki/gaps/g019.md]]'s Kanerva entry), with a broadcast gain in place of a target |
| Midbrain and hippocampal activity *rise* while errors and striatal activity fall | Not a reward prediction error on the feedback, because the feedback becomes more predictable as learning goes on. The driver is associative novelty (new combinations of familiar items), not item novelty *(suppl.)* |
| `F2–S1` is the integration trial | It is the trial whose overlap cues a two-step retrieval chain (`S1` → `F1` → `S2`). Pattern completion of the overlapping trace picks which episodes merge, which is the trigger stated above, now with a candidate gain signal |
| The training schedule selects the mechanism | Here the overlapping pairs are intermixed. Blocked designs show test-time hippocampal inference effects (Heckers et al. 2004; Preston et al. 2004). Transitive inference shows them only when the non-overlapping pairs are trained first (Titone et al. 2004, via this source). The source's claim is that both mechanisms exist and the structure of the experience decides between them ([[wiki/empirical-tensions.md]] T334) |
| Generalizers do not know they generalized | The generated `F2–S2` link is retrieved as if it had been experienced. The source calls this a false memory: an internally generated association misattributed to experience (Underwood 1965). A link integrated at write time carries no provenance mark ([[wiki/gaps/g071.md]]) |

**(brainstorm) Acquired equivalence has two write-time solutions, and this design cannot tell them apart.** (i) Store the `F2–S2` link, which is the source's reading. (ii) Merge `F1` and `F2` into one equivalence class, a single latent node in the sense of [[wiki/concepts/latent-graph-discovery.md]], so `F2` inherits every edge of `F1` with nothing link-specific written. (ii) is deliberate state aliasing. Test: after training, add a new `F1–S3` pair with no further `F2` trials. (ii) predicts that `F2–S3` transfers with no extra integration episode. (i) predicts transfer only if encoding `F1–S3` reinstates `F2`.

**Conflicts and caveats.**

| Issue | Detail |
|---|---|
| The hippocampal predictor has the opposite sign to Zeithamova et al. 2012 | Here an early → late *increase* predicts generalization. There a first → last *decrease* predicts inference. The paradigm (acquired equivalence vs associative inference), schedule (intermixed vs blocked) and time window (scan vs repetition) all differ. The source contrasts its rise with the usual decline on non-overlapping pairs (Kohler et al. 2005; Zeineh et al. 2003). Rises and falls are both read as integration, so the BOLD sign does not test the mechanism (`L4`, no registry row) |
| "Functional interaction" is a between-subject covariance of change scores | It is not within-subject timecourse coupling, and BOLD in VTA/SN is not dopamine. The midbrain region is two 10 mm spheres around the peaks of Adcock et al. 2006 |
| The test-phase null rests on the supplement | No hippocampal inference signal at test is a null result at n = 23 |
| "Equated for trained performance" | Equal accuracy near 93% is not equal premise strength (as in T411). REMERGE's lag generalization turns a small premise-weight gap into a larger group gap on generalization than on trained pairs ([[wiki/entities/remerge.md]]), so this control is weaker than stated |
| Latency over 6 test repeats | With no feedback, `F2–S2` could be integrated on its first test trial. The first-encounter analysis (F = 4.61) is the clean one |

---

## Third primary source: item-level codes, with the schedule manipulated (Schlichting, Mumford & Preston 2015)

> Schlichting, Mumford & Preston 2015, *Learning-related representational changes reveal dissociable integration and separation signatures in the hippocampus and prefrontal cortex*, Nat Commun 6:8151 (`raw/schlichting-2015-learning-related-representational-changes-integration-separation.md`). n = 26 (30 scanned; 4 excluded, 1 of them for direct-pair memory below 80%). High-resolution fMRI (1.7 mm isotropic voxels). Figures and supplement were not clipped, so claims that rest on them are marked *(suppl.)*.

**Design.**

| Element | Content |
|---|---|
| Stimuli | 36 novel 3-D objects in 12 `ABC` triads, chosen to have no pre-existing representations |
| Study (not scanned) | 24 pairs × 12 presentations. **Blocked** (6 triads): all 12 `AB` presentations before any `BC`. **Intermixed** (6 triads): `AB` and `BC` alternate. Within subjects, order counterbalanced. The overlap is not disclosed |
| Exposure scans, before and after study, identical order | Single items for 300 ms under an orthogonal fixation-colour task. Each item twice per run, 4 runs per phase |
| Test (after scanning) | Surprise `AC` inference first, then `AB` and `BC`. Two-alternative forced choice, foils from another triad of the same condition |
| Measure | Searchlight representational similarity analysis (RSA): `ΔRS = z(post) − z(pre)` for `A–C` pairs, **within-triad minus across-triad**, cross-run pairs only. Integration = within > across, separation = within < across. Correct-inference triads only |

**Behaviour.** `AB` 95.8%, `BC` 97.4%, `AC` 90.4%. `AC` blocked 92.3% vs intermixed 88.5%: no condition effect (F = 0.43) and no interaction.

**Results by region** (MNI coordinates, mm).

| Region | Signature | Detail |
|---|---|---|
| Posterior hippocampus, right (28/−37/−1) | **Separation under both schedules** | each schedule p < 0.005 *(suppl.)* |
| Anterior hippocampus (left −17/−16/−21; right 29/−11/−27) | **Blocked → integration, intermixed → separation** | Right: both effects significant (p < 0.047). Left: intermixed separation p < 0.0001, blocked integration a trend (p = 0.081) |
| Anterior MPFC (medial prefrontal cortex; 1/58/−20) | Separation under both | both p < 0.03 |
| Mid MPFC (−8/44/−17) | **Integration under both** | both p < 0.002. The only region-of-interest cluster that integrates whatever the schedule |
| Subgenual MPFC (3/15/−17; −7/18/−24) | Blocked → integration, intermixed → separation | Same pattern as anterior hippocampus |
| IFG (inferior frontal gyrus): left anterior BA 45 (−47/29/6), right posterior BA 44 (50/6/−2) | Separation under both | all p < 0.020 |
| IFG, more medial (−29/30/−2; 41/10/3, extending into insula) | Blocked → integration, intermixed → separation | |
| Whole brain *(suppl.)* | Only two integration-main-effect clusters, both prefrontal. Separation is widespread (ventral occipitotemporal, temporal pole, insula). Midbrain shows separation plus blocked → integration. Precuneus, middle temporal gyrus and dorsal PFC show the reverse interaction (intermixed → integration) | |
| Every ROI | No intermixed → integration cluster. Across-triad similarity unchanged | |

**Structure.** Anterior hippocampal (head) volume predicts blocked-condition integration across subjects (r = 0.43, p = 0.027). In a regression with body and tail, only head volume predicts it (β = 0.50). No subregion's volume predicts intermixed separation.

**What it adds.**

| Finding | Consequence for a builder |
|---|---|
| **The same `A` and `C` are coded as integrated in one region and as separated in another, at the same time** | The store does not have to pick one policy per pair. It can hold a separated code and an integrated code of one triad in parallel, which moves the integrate-vs-separate question from storage to the reader: which copy does a query consult? **(brainstorm)** This is the first human item-level measurement of both codes at once |
| **The schedule sets the hippocampal bias, and recency does not** | Intermixed `AB` is more recent when `BC` first appears, and it gives separation. Blocked `AB` is older but established, and it gives integration. The authors' reading is that completion during new encoding needs a strong prior trace (O'Reilly & Rudy 2001). That adds a precondition to the trigger stated above (integration runs where the store completes): the overlapping trace must be strong enough to complete *at the first overlap* ([[wiki/gaps/g038.md]]) |
| **Inference accuracy is the same under both schedules** | In the intermixed condition, correct `AC` inference happened while anterior hippocampus was separating. So an integrated hippocampal code is not necessary for inference here. Mid-MPFC's integrated code (present under both schedules) or retrieval-time recombination of separated traces is enough ([[wiki/empirical-tensions.md]] T334) |
| **The controller integrates under both schedules, the store only under one** | Mid-MPFC integrates either way, anterior hippocampus only after blocked training. **(brainstorm)** This fits Zeithamova et al. 2012 above, where the vmPFC effect survives the premise-memory control and the hippocampal one does not: the controller's integration is the schedule-robust one |
| **Midbrain follows the anterior-hippocampal pattern** | The authors read it as a mismatch response that switches between separation (encoding) and integration by completion (retrieval). That would make the Shohamy & Wagner gate above a separation/completion switch as well as a write gain. Speculation in the source |
| **The item-level design rules out a process account** | Within-minus-across-triad ΔRS cancels any process engaged by every item (retrieving a narrative label, a novelty response). The authors use this to criticise Milivojevic et al. 2015, where narrative membership was confounded with temporal proximity. It is a probe rule worth importing ([[wiki/concepts/representation-probing.md]]) |

**(brainstorm) Separation as clone allocation.** The authors offer a second reading of a similarity decrease. Viewing `A` completes `B_A` (B in the context of A) and viewing `C` completes `B_C`, so `A` and `C` drift apart because they retrieve different copies of `B`. Integration is then completion to one shared `B`. In latent-graph terms the separating region has split the shared node into two context-specific clones, and the integrating region holds one node with two edges. This matches the clone-allocation reading of separation in [[wiki/entities/cscg.md]]. The design cannot tell a stored representational change from automatic completion at viewing, but under either reading the two codes coexist.

**Conflicts and caveats.**

| Issue | Detail |
|---|---|
| Schedule direction vs Shohamy & Wagner 2008 | There, *intermixed* overlapping pairs gave the encoding-phase integration signal (a hippocampal activation rise predicting generalization), and blocked designs elsewhere gave test-phase effects. Here intermixed gives hippocampal *separation* and blocked gives integration. The measures differ (activation change vs item-similarity change), and so do the paradigms (acquired equivalence vs associative inference), so this is not a clean reversal. But the schedule → mechanism mapping recorded in `T334` does not survive as stated |
| Zeithamova et al. 2012 also trained interleaved | and found the absent element reinstated during encoding. Reinstatement during intermixed encoding and separated item codes afterwards are compatible: the `B_A`/`B_C` reading needs completion to a different copy of `B`, not an absence of completion |
| Separation is widespread in neocortex | This looks like a conflict with complementary learning systems (neocortex integrates). The authors' answer is timescale: one session is short, and cortical integration may need more experience or consolidation. Blocked training may beat interleaved for integration on short timescales and lose on long ones ([[wiki/concepts/complementary-learning-systems.md]]) |
| Only correct-inference triads analysed | No subject-level link between code type and inference is tested, so neither code is shown to cause inference |
| Volume–integration correlation | r = 0.43 at n = 26, one test. It conflicts with "smaller anterior hippocampus = better recollection" (Poppenk et al. 2013) unless integration costs detail recall. That is the authors' reconciliation, and it is untested |
| Supplement and figures not clipped | Per-schedule follow-up tests, the whole-brain table and the null effect of condition order rest on them |

---

## Connections

- **[[wiki/entities/remerge.md]]** — the named rival mechanism for this page's behaviour: recirculate the store's own similarity computation until it settles instead of binding a reinstated element at write time, which keeps the separated code and moves the whole cost to the query ([[wiki/empirical-tensions.md]] T334). Its loop is now measured at test, where this page measures at encoding: entorhinal recirculation of the absent `B` predicts inference after two exposures, and deep-layer reinstatement does not (Koster et al. 2018).
- **[[wiki/entities/ircot.md]]** — the query-time column of this page's table, measured in a machine: per-hop retrieval cuts the per-hop error compounding the table assigns to query-time composition, so the cost of the unobserved path moves into the number of reads rather than into accuracy.
- **[[wiki/concepts/schema-assimilation.md]]** — supplies the primary source and the measurement behind that page's "conflict is the trigger" section: the reinstatement it asserts is read out directly by classifier, and the vmPFC effect is shown to survive partialling out premise memory, which is what makes integration-demand a real variable rather than a redescription of learning better.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the minimal latent-graph instance with its cost location settled: the unobserved `A–C` path is paid for at write time, speculatively, before the query exists, so the reader needs a lookup rather than a traversal operator.
- **[[wiki/concepts/offline-replay.md]]** — the same reinstatement operation moved online and given an input: replay without external drive transports and resamples, replay *during* an overlapping encoding episode manufactures the conflict that integration is triggered by, so the two are one mechanism distinguished by whether the world is clamped.
- **[[wiki/concepts/encoding-retrieval-alternation.md]]** — the direct friction: that page's theta model exists to keep completion out of the encoding phase, this one requires completed content to be present while the new pair is written, and nothing measures whether reinstated absent-item content is theta-phase-locked.
- **[[wiki/concepts/pattern-separation-completion.md]]** — proposes the trigger the integrate-vs-separate knob needs: integration runs where the store cannot help completing, so overlap-driven completion selects which episodes get merged rather than a policy deciding it.
- **[[wiki/concepts/complementary-learning-systems.md]]** — a third traffic direction on that page's channel, alongside the slow→fast write control it already carries: the fast store's *own* read is injected into its write, so the composite that eventually consolidates was never experienced.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — human evidence on that channel's encoding-phase role, with the unusual within-run/across-run control: coupling rises with repetitions of a particular overlapping set and not with time on task, so the channel's bandwidth tracks assembly of one structure rather than a task mode ([[wiki/empirical-tensions.md]] T100).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the human ventromedial arm measured at encoding rather than at expression: activation *increase* across repetitions predicts later inference over and above premise memory, which is the strongest evidence on that page that the controller is doing integration work at write time and not only selecting a schema at read time. Its lesion counterpart makes the region necessary: vmPFC damage removes `A–C` inference with premises at ceiling, against controls at 0.76. But the lesion cannot say whether the region acts at write time or at test (Spalding et al. 2018).
- **[[wiki/entities/temporal-context-model.md]]** — the rival account of the same behaviour: transitive/associative inference as a similarity gradient produced by retrieved context at test, with no integrated composite ever written ([[wiki/empirical-tensions.md]] T334).
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the query-time pole of the same trade-off in machine form: it answers first-presentation transitive inference from a structural code with no write-time integration at all, so the two together bracket where the path can be paid for.
- **[[wiki/entities/default-mode-network.md]]** — a coupling result with its own disconfirmation attached: hippocampal connectivity rose with four default-network regions and only one of them had activation predicting behaviour, which is a worked example of how little a network-level coupling change licenses.
- **[[wiki/concepts/representation-probing.md]]** — the design's methodological core: a classifier trained on an independent localizer, validated on guided recall, then applied to an experimental condition where the *decoded* content is absent from the stimulus — a probe used to detect what is not there, with a built-in first-repetition null control.
- **[[wiki/concepts/effective-connectivity.md]]** — this page's specificity control is that page's worked cautionary case: frontal pole, precuneus and superior parietal raised hippocampal coupling across repetitions exactly as vmPFC did and predicted nothing about inference, so a coupling change is licensed as evidence only when a behavioural contrast survives alongside it.
- **[[wiki/concepts/hierarchy-of-associativity.md]]** — turns this page's reinstatement measurement into a directional prediction: the medial-temporal return path is wide to early visual areas and narrow to frontal cortex and is not cell-for-cell reciprocal, so a decoded reinstated pattern should be systematically more faithful in sensory cortex than in frontal cortex — the opposite ordering a pointer-to-the-encoder account expects (`T28`).
- **[[wiki/concepts/hippocampal-indexing-theory.md]]** — the behavioural existence proof this page's mechanism needs: a rat conditioned on the *retrieved* memory of a context it is not currently in shows fear to that context and not to a control context, and the effect is abolished by dorsal-hippocampal inactivation, so an index read-out can serve as the input to new associative learning.
- **[[wiki/concepts/state-prediction-error.md]]** — supplies the causal half of this page's candidate write gate: there a ventral tegmental dopamine transient is necessary and sufficient to write a valueless cue→cue link in rats, while here midbrain activity rising with hippocampal activity across learning predicts which humans integrate overlapping pairs. The source names the trigger an *episodic* prediction error, a mismatch between retrieved and present content (Shohamy & Wagner 2008).
- **[[wiki/entities/ventral-tegmental-area.md]]** — the proposed gain source for integration, through the hippocampal–VTA loop: hippocampal mismatch drives the midbrain, and dopamine back in the hippocampus raises the chance that the present and retrieved episodes are written as one. Here the midbrain change covaries with hippocampus and not striatum, so the line involved is a hippocampal-projecting one, not among the four that page traces.
- **[[wiki/concepts/hippocampal-long-axis.md]]** — places this page's integration at the anterior end and makes it depend on the schedule: posterior hippocampus separates `A` from `C` under any schedule, anterior hippocampus integrates only blocked triads, and head volume predicts how much (Schlichting et al. 2015).
- **[[wiki/entities/lateral-frontoparietal-network.md]]** — supplies the item-level separating code beside this page's integrating one: lateral IFG (left BA 45, right BA 44) pushes indirectly related items apart under both schedules while mid-MPFC pulls the same items together, so the two prefrontal resolution policies run in parallel on one triad (Schlichting et al. 2015).
