# Broadcast Channel Decomposition

**A diffuse modulatory projection is not one channel. The same nucleus carries at least three signals about the same events — a *signed* value error, a *rectified* salience magnitude, and a fast *alerting* burst keyed to nothing but "something unexpected and possibly important happened" — each with a different input source, a different sign convention, and a partly disjoint set of downstream targets. The address a broadcast scalar lacks is recovered not by putting an address *in* the signal but by splitting the signal across topographically separated populations whose axons go to different places.**

> **Provenance.** Bromberg-Martin, Matsumoto & Hikosaka 2010, *Dopamine in motivational control: rewarding, aversive, and alerting*, Neuron 68(5):815–834 (`raw/brombergmartin-2010-dopamine-motivational-value-salience-alerting.md`). A review with an explicit new hypothesis, no new data. The value/salience split rests on Matsumoto & Hikosaka's monkey recordings; the pathway assignments are, in the authors' own words, "inferred largely from indirect measures" — response properties and functional roles of candidate areas, not tract-tracing plus recording in one animal. Read the two-population claim as evidence and the wiring diagram as a program.

Why this earns a page rather than a paragraph on [[wiki/concepts/reward-prediction-error.md]]: that page's opening premise is *one* scalar with *no* address, and every architecture in the wiki inherits it. The decomposition is a different design object — how many broadcast channels a system needs, what distinguishes one from another, and what each one is allowed to reach — and it generalises past dopamine to any diffuse modulator.

---

## The three channels

| | **Motivational value** | **Motivational salience** | **Alerting** |
|---|---|---|---|
| Excited by | reward | reward **and** aversive events | unexpected cue of high potential importance |
| Inhibited by | aversive events | — (neutral events give weak responses) | — |
| Response to *omission* | full bidirectional error: strong inhibition on reward omission, mild excitation on aversive omission | **none** — excited when the salient event is present, silent when it is absent | n/a |
| Functional form | `δ = r + γV(s′) − V(s)` | a **rectified magnitude**, `≈ max(0, f(\|δ\|))`, present-trials only | a short-latency surprise/novelty burst |
| Latency, and what it reads | long; the precise identity of the stimulus | long; precise identity | **short**; rough features only — location, size, sensory modality |
| Correlates with | considered approach/avoid decisions | orienting, cognitive engagement, general drive | **speed of orienting and approach** |
| Located in | ventromedial substantia nigra pars compacta, lateral ventral tegmental area | dorsolateral substantia nigra pars compacta | broadcast throughout the substantia nigra pars compacta — **in the majority of both other populations** |

The value/salience difference is an **anatomical gradient**, not a partition: some neurons carry mixtures, and the authors flag further response types (visual-versus-auditory selectivity, first-versus-last-event-in-sequence, sustained activation by risky rewards, movement-related) that would subdivide the population further.

**The rectification is the sharpest single architectural fact here.** The salience channel is not `|δ|` — `|δ|` is large on omission and the salience channel is silent there. It is an *event-present magnitude*: `salience ≈ |outcome| · 1[outcome occurred]`. That is nearly the Pearce–Hall associability term, restricted to trials where something happened, and it is exactly the quantity a system needs to decide *how hard to engage* without first deciding *whether the news is good*.

---

## Sources and targets — the address spaces

| Channel | Proposed source | Proposed targets | What the target does with it |
|---|---|---|---|
| Value | lateral habenula, via `GPb → LHb → RMTg → DA` (LHb neurons are the sign-inverse of value DA neurons, at shorter latency); parabrachial nucleus supplies the **aversive-outcome component** specifically | orbitofrontal / ventromedial prefrontal cortex, nucleus accumbens **shell**, dorsal striatum | outcome evaluation, value learning, stimulus–response habits |
| Salience | central nucleus of the amygdala (candidate); basal forebrain, parabrachial nucleus | dorsolateral / lateral prefrontal cortex (primate-specific; rodent medial prefrontal cortex is the functional analogue), nucleus accumbens **core**, dorsal striatum | orienting, working memory and cognitive control, effort and general motivation |
| Alerting | **superior colliculus** (multimodal short-latency input, controls orienting, direct projection to both SNc and VTA); lateral habenula; pedunculopontine tegmental nucleus | both populations above, hence everywhere | immediate investigative reaction |

**A third subdivision the shell/core partition does not have room for.** The hedonic generator inside nucleus accumbens is a hotspot of roughly one cubic millimetre in rat — **10% of accumbens volume** — driven by opioid and endocannabinoid signalling, and dopamine stimulation *inside* it never enhances 'liking'; the remaining 90% generates intense motivation and no hedonic enhancement at all ([[wiki/concepts/incentive-salience.md]], Berridge & Robinson 2016). So "shell receives signed value, core receives rectified salience" is a partition of the *motivational* tissue, and whatever addresses the hedonic module is finer than either target named here.

**Shell versus core is the cleanest prediction in the paper.** Same structure, two subdivisions, and the claim is that they receive *different modulatory signals about the same event* — shell gets signed value, core gets unsigned salience. The functional dissociation it is read off is independent: core (not shell) is required to overcome effort costs, to set-shift, and to let reward cues raise general motivation. A caveat the authors state: long-timescale shell measurements come out mixed, so any value-coding is restricted to specific sites within it.

**(brainstorm)** In wiki terms this is *two broadcast scalars with different address spaces rather than one* — the resolution the retired `T313` proposed as speculation, here stated as a review position with an anatomy attached. It also answers, partially, the address problem [[wiki/concepts/reward-prediction-error.md]] leaves open: selectivity comes neither from the signal nor from the postsynaptic ensemble alone but from **which axons exist**. Address by wiring is the cheapest addressing scheme available — it costs nothing at run time and is entirely unlearnable within a lifetime, which is the trade.

---

## The alerting channel is dissociated from the value channel, three ways

The default explanation — alerting bursts are ordinary reward prediction errors emitted before the stimulus has been discriminated — is argued against on three grounds, and they are the load-bearing content of the paper's second half:

| Dissociation | Observation |
|---|---|
| **Task valence** | The burst to a trial-start cue is equally strong in an **aversive task with no rewards at all**, while conventional reward signals in the *same neurons* correctly report that the appetitive task has the higher expected value |
| **Memory trace** | Conventional reward signals are governed by a long-timescale trace optimised for prediction accuracy; the alerting response is governed by a *separate, short* trace resembling the one behind immediate orienting |
| **Spatial distribution** | Reward signals are concentrated ventromedially; alerting bursts are broadcast across the whole SNc |

Three further properties fix what the channel is keyed to. It fires only for cues that must be **examined** to be understood, never for intrinsically rewarding or aversive outcomes; only when the cue is task-relevant enough to trigger an orienting reaction; and it is enhanced when the cue demands an abrupt attention shift. Consequently **it relocates to the earliest unpredictably-timed event**: forewarn the animal with a trial-start cue one second ahead and the alerting response leaves the informative cues and moves to the trial-start cue. It also **generalises promiscuously** — any stimulus that slightly resembles a motivationally salient one gets it — which is why single dopamine neurons emit a *mixture*: a fast burst saying "potentially important" and a slower component saying what the thing actually is.

**The consequence the authors find hard to explain is the interesting one.** Alerting bursts occur in the *value*-coding population too. Under their own pathway diagram that means alerting events get assigned **positive value and are sought after like rewards**. Their defence is that this is correct behaviour rather than a bug: an alerting cue is the first warning that something important is coming and the first chance to act on it, and animals do prefer environments where outcomes — rewarding, aversive, *and neutral* — can be observed in advance. Dopamine neurons separately signal the behavioural preference to view reward-predictive information that conveys nothing about the reward itself.

**(brainstorm)** That is an **information bonus implemented by additive contamination**, not by a derived term. Instead of computing expected information gain and adding it to the objective, the architecture leaks a fast novelty/orienting signal into the value channel, and the value learner — which cannot tell the two apart — learns to seek states that emit it. It is far cheaper than anything on [[wiki/concepts/epistemic-value.md]]: no posterior, no entropy, no weight to tune. It is also strictly worse-behaved, because the bonus is keyed to *rough sensory features* rather than to actual uncertainty, so it is spoofable by anything that merely looks surprising. A machine test the wiki could run cheaply: add a decaying novelty burst to the reward channel of a standard agent, keyed to raw input-feature surprise, and compare against a proper information-gain bonus on the same task — the prediction is that the cheap version matches it on tasks where novelty and uncertainty are correlated and is catastrophically distractible where they are decoupled.

---

## Where this puts the wiki's dopamine disputes

| Row | What this source does to it |
|---|---|
| `T313` (retired, `L4`) — do dopamine neurons respond to aversive events? | **Both records can stand.** The value population is inhibited by aversive events, the salience population excited; the disagreement was a sampling question about which gradient position was recorded. The paper also reconciles the classic "DA prefers reward cues to aversive cues" result on different grounds: in that study reward cues predicted reward at >90% and aversive cues predicted aversion at <10%, so *both* populations should have been near-silent to the aversive cues |
| `T122` — reward prediction error or precision? | Neither position gets a clean win, and both get an extra obligation. Position A must now say *which* population it is describing, since only one of the two carries a complete bidirectional error. Position B gains a natural occupant for the rectified channel — an unsigned, event-present magnitude is much closer to a precision/gain term than to a value error — but loses the argument that aversive excitations force the precision reading, since a signed-value account covers them once the population is split |
| `T85` — prediction or association? | Untouched; this source assumes the prediction reading throughout |
| `G116` — no design orthogonalizes valence against action | **Sharpened, not answered.** Value and salience are here dissociated by *valence congruence* (opposite versus same sign for reward and aversion), which the standard two-congruent-cell paradigms do separate. The action axis is not crossed anywhere in the cited work |

---

## The instrument caveat, and it applies to everything above

Behaving-animal recordings identify dopamine neurons **indirectly** — firing rate, spike waveform, sensitivity to D2 receptor agonists. The authors judge this reliable in the substantia nigra pars compacta and **unreliable in the ventral tegmental area**, where dopaminergic and non-dopaminergic cells have a wider spread of cellular properties. Direct measurement of downstream dopamine concentration does not rescue it either, since concentration is also set by glutamatergic activation of dopamine axon terminals and by fast changes in transporter activity. The fix named is optogenetic tagging combined with extracellular recording.

This bites the two-population claim exactly where it is most load-bearing: the shell/core and value/salience assignments in the ventral tegmental area rest on the least reliable identification. Against that, the split is also visible in SNc, where identification is sound.

---

## What a builder takes

| Finding | Consequence |
|---|---|
| One modulator, three signals | "Add a neuromodulator" is underspecified. The design question is *how many channels, with what sign conventions*, before it is *what chemical* |
| The salience channel is rectified | A magnitude channel that is silent on omission is not `\|δ\|` and is not obtainable by post-processing a signed error — the information is destroyed. It must be computed separately or taken from a separate source |
| Address by axon, not by signal | Selectivity is buyable structurally: two populations reading the same events with different sign conventions and projecting to different targets give addressing with zero run-time cost and zero learnability |
| Alerting is keyed to rough features and leaks into value | An exploration bonus can be had for almost nothing, at the price of being driven by surface novelty rather than by uncertainty |
| The alerting burst migrates to the earliest unpredictably-timed event | The same migration signature as the value burst, but driven by *timing predictability* rather than by value — so two different learning processes produce the same backward-shift phenomenology, and observing the shift does not identify which one ran |

---

## Open problems

- **Nothing in the wiki has more than one broadcast channel for the same event** (`G117`). Every architecture here has one scalar per quantity; none splits one outcome into a signed channel and a rectified channel with disjoint targets.
- **The pathway diagram is inference, not measurement.** Source and target assignments come from response properties and functional roles of candidate areas. The paper names the test — optogenetic control plus DA-specific measurement — and notes that several candidate structures are themselves topographic, so the communication may be topographic on both ends.
- **Is salience a separate population or the *sum* of an opponent pair?** [[wiki/concepts/affective-opponency.md]] shows a two-population opponent code constrains only the difference, leaving the sum free to carry a second quantity — salience being the obvious candidate. This source instead makes salience its own population with its own inputs and outputs. The two are architecturally very different (one pair of wires versus two) and nothing here decides between them.
- **Is the salience population the same thing as incentive salience?** [[wiki/concepts/incentive-salience.md]] reaches a valence-blind, cue-triggered, attention-directing mesolimbic quantity from a behavioural dissociation — and reports the same circuitry generating an active-coping *fearful* salience in an aversive mode (Richard & Berridge 2011), which is independent support for a valence-blind population and a partial answer to the row below. The two constructs are defined by incompatible evidence classes (a firing profile versus a depletion/stimulation dissociation) and nobody has measured them in one animal.
- **Whether alerting responses occur for stimuli resembling *only* aversive cues is unknown** — stated by the authors as an open question. It decides whether the alerting channel is valence-blind or appetitively biased.
- **The rectified channel's downstream consumer is unidentified.** Salience-coding targets are proposed on functional grounds; no recording shows a target neuron consuming an unsigned magnitude as a gain.
- **"Rewarding" and "aversive" are too coarse.** The authors' own closing caveat: a prolonged internally-caused illness and a brief external air puff demand different responses and probably different systems, and some dopamine neurons may not lie on a good/bad axis at all.

---

## Connections

- **[[wiki/concepts/reward-prediction-error.md]]** — the channel this page decomposes away from, and a direct qualification of its opening premise: the "one broadcast scalar with no address" is one of at least three signals in the same projection, and the address it lacks is supplied by which population's axons reach which target rather than by any content in the signal.
- **[[wiki/concepts/incentive-salience.md]]** — the same valence-blind motivational quantity reached from behaviour rather than from a firing profile, plus a finer address problem for this page's shell/core claim: the hedonic generator is a ~1 mm³ hotspot nested inside accumbens whose remaining 90% does motivation only, and dopamine cannot drive it even locally.
- **[[wiki/concepts/affective-opponency.md]]** — the rival arrangement for the same requirement: there value and a free second quantity ride on the *difference* and *sum* of one opponent pair, here they are two separately-sourced populations; both deliver value plus salience, at different wiring costs and with different failure modes if one baseline drifts.
- **[[wiki/concepts/vectorized-instructive-signals.md]]** — the intermediate point on that page's axis, which was stated as a dichotomy: between one global scalar and one signal per neuron sits a *handful* of broadcast channels addressed by projection target — coarse vectorization bought with anatomy rather than with a backward pass.
- **[[wiki/concepts/priority-map.md]]** — what the salience and alerting channels are for at the output end: the alerting burst is short-latency, keyed to rough features, correlated with orienting speed and generated by the superior colliculus, which is the priority map's own substrate — so the modulatory burst and the saccade target are two readouts of one selection.
- **[[wiki/concepts/epistemic-value.md]]** — the cheap rival to every derived exploration term on that page: an orienting signal leaked additively into the value channel makes information-bearing states valuable with no posterior, no entropy and no weight, at the price of being driven by surface novelty rather than by uncertainty.
- **[[wiki/entities/basal-ganglia.md]]** — where the two channels are claimed to land differently inside one structure: nucleus accumbens shell for signed value, core for rectified salience, with the dorsal striatum receiving both — a subdivision distinction that circuit's D₁/D₂ account does not currently represent.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the taxonomy this page cuts across: there one chemical carries one quantity, here one chemical carries three, so "dopamine = `δ`" is a claim about a subpopulation and the mapping from chemicals to slots is many-to-many in both directions.
- **[[wiki/concepts/precision-weighting.md]]** — the natural occupant of the rectified channel: an unsigned, event-present magnitude consumed as a gain is what that page needs and what a signed value error cannot be, which relocates `T122`'s dispute from *which reading is right* to *which population*.
- **[[wiki/entities/salience-network.md]]** — the same functional role one level up: a dedicated detector whose output reassigns processing mode rather than being scored as an outcome, here implemented as a subcortical modulatory population instead of a cortical network, with the same unresolved question of what consumes the estimate.
- **[[wiki/concepts/attention.md]]** — the channel that pays for engagement rather than for learning: the salience population's targets are the cognitive-control regions, so the quantity that decides *how hard to engage* is broadcast separately from the one that decides *what the news was*.
- **[[wiki/concepts/latent-graph-discovery.md]]** — three different teaching signals about one event means three different things can be learned from it: which edges are worth traversing (value), which nodes are worth the cost of visiting (salience), and which observations are worth making at all (alerting).
