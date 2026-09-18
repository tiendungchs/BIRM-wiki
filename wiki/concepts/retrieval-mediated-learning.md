# Retrieval-Mediated Learning

**A new event is encoded not only against what is present but against what the store *retrieves* while it is present: overlapping content cues reinstatement of a prior episode's unseen elements, and the current event is bound to the reinstated content rather than to the input alone. The composite `A–C` is therefore written at encoding time, before any query for it exists — not composed at retrieval.**

> **Provenance.** Zeithamova, Dominick & Preston 2012, *Hippocampal and ventral medial prefrontal activation during retrieval-mediated learning supports novel inference*, Neuron 75:168–179 (`raw/zeithamova-2012-retrieval-mediated-learning-inference.md`). 26 subjects, block-design fMRI, associative-inference triads (`A–B`, `B–C` interleaved; tested on `A–C`), with multivoxel pattern analysis used to read out the *unseen* third element during encoding. The wiki already carried this result secondhand through Preston & Eichenbaum 2013 ([[wiki/concepts/schema-assimilation.md]]); this is the primary source, and it supplies the measurement the review only summarised.

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

**(brainstorm) Neither pure policy is right and the wiki should say what selects between them.** Write-time integration over every pair of overlapping episodes is combinatorially hopeless; query-time composition over an unbounded graph is the multi-hop failure every retrieval-augmented model shows. What this study supplies is a *trigger*: integration runs when reinstatement happens, and reinstatement happens when the current input overlaps a stored episode strongly enough to complete it. So the selection rule is not a policy choice but a property of the store — pattern completion decides, and the integration budget is spent exactly where the fast store cannot help firing ([[wiki/concepts/pattern-separation-completion.md]]). That is implementable and no memory architecture here does it.

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

## Connections

- **[[wiki/concepts/schema-assimilation.md]]** — supplies the primary source and the measurement behind that page's "conflict is the trigger" section: the reinstatement it asserts is read out directly by classifier, and the vmPFC effect is shown to survive partialling out premise memory, which is what makes integration-demand a real variable rather than a redescription of learning better.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the minimal latent-graph instance with its cost location settled: the unobserved `A–C` path is paid for at write time, speculatively, before the query exists, so the reader needs a lookup rather than a traversal operator.
- **[[wiki/concepts/offline-replay.md]]** — the same reinstatement operation moved online and given an input: replay without external drive transports and resamples, replay *during* an overlapping encoding episode manufactures the conflict that integration is triggered by, so the two are one mechanism distinguished by whether the world is clamped.
- **[[wiki/concepts/encoding-retrieval-alternation.md]]** — the direct friction: that page's theta model exists to keep completion out of the encoding phase, this one requires completed content to be present while the new pair is written, and nothing measures whether reinstated absent-item content is theta-phase-locked.
- **[[wiki/concepts/pattern-separation-completion.md]]** — proposes the trigger the integrate-vs-separate knob needs: integration runs where the store cannot help completing, so overlap-driven completion selects which episodes get merged rather than a policy deciding it.
- **[[wiki/concepts/complementary-learning-systems.md]]** — a third traffic direction on that page's channel, alongside the slow→fast write control it already carries: the fast store's *own* read is injected into its write, so the composite that eventually consolidates was never experienced.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — human evidence on that channel's encoding-phase role, with the unusual within-run/across-run control: coupling rises with repetitions of a particular overlapping set and not with time on task, so the channel's bandwidth tracks assembly of one structure rather than a task mode ([[wiki/empirical-tensions.md]] T100).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the human ventromedial arm measured at encoding rather than at expression: activation *increase* across repetitions predicts later inference over and above premise memory, which is the strongest evidence on that page that the controller is doing integration work at write time and not only selecting a schema at read time.
- **[[wiki/entities/temporal-context-model.md]]** — the rival account of the same behaviour: transitive/associative inference as a similarity gradient produced by retrieved context at test, with no integrated composite ever written ([[wiki/empirical-tensions.md]] T334).
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the query-time pole of the same trade-off in machine form: it answers first-presentation transitive inference from a structural code with no write-time integration at all, so the two together bracket where the path can be paid for.
- **[[wiki/entities/default-mode-network.md]]** — a coupling result with its own disconfirmation attached: hippocampal connectivity rose with four default-network regions and only one of them had activation predicting behaviour, which is a worked example of how little a network-level coupling change licenses.
- **[[wiki/concepts/representation-probing.md]]** — the design's methodological core: a classifier trained on an independent localizer, validated on guided recall, then applied to an experimental condition where the *decoded* content is absent from the stimulus — a probe used to detect what is not there, with a built-in first-repetition null control.
- **[[wiki/concepts/effective-connectivity.md]]** — this page's specificity control is that page's worked cautionary case: frontal pole, precuneus and superior parietal raised hippocampal coupling across repetitions exactly as vmPFC did and predicted nothing about inference, so a coupling change is licensed as evidence only when a behavioural contrast survives alongside it.
- **[[wiki/concepts/hierarchy-of-associativity.md]]** — turns this page's reinstatement measurement into a directional prediction: the medial-temporal return path is wide to early visual areas and narrow to frontal cortex and is not cell-for-cell reciprocal, so a decoded reinstated pattern should be systematically more faithful in sensory cortex than in frontal cortex — the opposite ordering a pointer-to-the-encoder account expects (`T28`).
