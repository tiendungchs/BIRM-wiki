# Lateral Habenula — A Convergence Funnel with an Inverting Relay and a Slow Gain

**The lateral habenula (LHb) is the wiki's clearest instance of *many sources collapsed onto one variable and then sign-inverted by wiring*. More than a dozen afferent pathways — basal-ganglia output, hypothalamus, ventral pallidum, septum, amygdala, medial prefrontal cortex, raphe, ventral tegmental area, and two visual pathways — converge on one small glutamatergic nucleus whose efferent is essentially one family: it excites the GABAergic rostromedial tegmental nucleus (RMTg), which inhibits *every* ascending aminergic system. Three architectural facts come with it: the sign flip is performed by an interposed inhibitory population rather than by a negative rate; valence within a single pathway is separated by **transmitter** rather than by target, in the limit as the GABA/glutamate *ratio* at one co-releasing terminal; and the channel's gain is a second, slow code dimension — the same cells switch between silent, tonic and burst firing, with the burst threshold set by an astrocytic potassium channel and the burst fraction more than doubling under chronic stress.**

> **Provenance.** Hu, Cui & Yang 2020, *Circuits and functions of the lateral habenula in health and in disease*, Nature Reviews Neuroscience 21(5):277–295 (`raw/hu-2020-lateral-habenula-circuits-and-functions.md`). Review; rodent unless stated, with monkey single-unit, zebrafish whole-brain imaging and human functional-imaging and deep-brain-stimulation data where cited. Negative-reward-prediction-error framing credited to Hikosaka and colleagues; input-specific optogenetics to many groups; the bursting/Kir4.1/ketamine mechanism to the authors' own lab.

Why this earns a page. The LHb is named on `T355`, `T132`, `T133`, `G116`, `G117`, [[wiki/entities/ventral-tegmental-area.md]], [[wiki/concepts/broadcast-channel-decomposition.md]] and [[wiki/concepts/affective-opponency.md]] with no page of its own; every one of those uses it as a *source* and none states what it computes or how its own signal is formed. The structure is conserved across essentially all vertebrates (dorsal/ventral habenula in fish and amphibians), which makes it a candidate primitive rather than a mammalian elaboration.

---

## Position in the circuit

```
limbic forebrain ┐
basal ganglia    ├─→ LHb (glutamatergic) ─→ RMTg (GABA) ─→ dopamine (VTA, SNc)
cortex           ┤                       └─→ raphe (5-HT), locus coeruleus (NA),
sensory/visual   ┘                            laterodorsal tegmentum (ACh)
```

| | Medial habenula (MHb) | **Lateral habenula (LHb)** |
|---|---|---|
| Transmitters | acetylcholine, substance P, glutamate | **glutamate** (VGLUT2 or VGLUT3, never VGLUT1); a small GAD2⁺/parvalbumin⁺ local inhibitory population, confirmed functionally |
| Main afferent | septum | basal ganglia + limbic forebrain, via the stria medullaris |
| Main efferent | interpeduncular nucleus | RMTg + midbrain aminergic centres, via the fasciculus retroflexus |
| Subdivisions | — | medial (LHbM) and lateral (LHbL) principal divisions, ≥7 subnuclei; LHbL takes basal-ganglia input, LHbM takes limbic input, in largely **parallel** streams |

Cross-hemisphere commissural projections are substantial and topographic, and the habenula is left–right **asymmetric** — most visibly in fish, still detectable in mammals. No architecture in the wiki has a lateralized modulatory nucleus.

---

## Afferents — one nucleus, at least a dozen input lines

| Source | Transmitter to LHb | Effect of driving it | What it contributes |
|---|---|---|---|
| **Entopeduncular nucleus** (EPN; rodent equivalent of the internal globus pallidus), → LHbL | **GABA *and* glutamate co-released from the same terminals** | bidirectional modulation of LHb | the most promising source of the **negative reward prediction error**: EPN→habenula cells are *inhibited* by reward-predicting cues and *excited* by reward omission |
| Lateral hypothalamic area | glutamate | real-time place aversion; inhibition gives place preference | escape from foot shock and looming stimuli; negatively regulates feeding. **Activity-dependent plasticity is specific to this synapse** — not to EPN→LHb or VTA→LHb — and it is what instructs avoidance learning |
| Lateral preoptic area | ~75% glutamate, rest GABA | glutamatergic arm → aversion; GABAergic arm → **reward** | aversive stimuli activate *both* arms simultaneously |
| Ventral pallidum | mixed glutamate / GABA | glutamatergic → punishment avoidance; GABAergic → reward seeking | silencing the parvalbumin⁺ glutamatergic arm confers **resilience** to social-defeat stress |
| Paraventricular nucleus (vasopressin, magnocellular) | glutamate, onto putative GABAergic LHbM cells | — | correlative link from **thirst** to motivational state |
| Nucleus accumbens medial shell (100% GABA), septum (~75%), diagonal band (~80%) | GABA | — | encodes the valence of aggressive interactions |
| Medial septum | glutamate (and GABA on the same pathway) | aversion | converts **sound and touch** into aversive emotion, antagonized by the GABAergic arm of the same pathway |
| Ventral lateral geniculate / intergeniculate leaflet | GABA | suppresses LHb | receives melanopsin retinal ganglion cells — the candidate route for bright-light therapy |
| Ventral tegmental area (feedback) | **GABA and glutamate co-released**; no evidence of dopamine release | suppresses LHb firing; increases VTA dopamine firing in vivo | a **disinhibition loop** producing place preference and self-stimulation |
| Dorsal raphe | serotonin | suppresses excitability **presynaptically** | bath serotonin *inhibits* glutamatergic transmission in most LHbL cells and *enhances* it in most LHbM cells — opposite signs by subdivision, from receptor complement |
| Median raphe | glutamate (VGLUT2) | **triggers bursting**; place aversion and anhedonia | the one afferent named as driving the *mode* rather than the rate |
| Medial prefrontal cortex | glutamate | — | top-down; disrupting it reproduces LHb working-memory deficits |

**Two addressing schemes the wiki did not have.** [[wiki/entities/ventral-tegmental-area.md]] establishes *address by afferent nucleus* — which channel fires is set by which source is active. Here the address is finer in two ways, and both are cheaper than a learned gate:

| Scheme | Instance | Machine reading |
|---|---|---|
| **Address by transmitter within one pathway** | lateral preoptic area and ventral pallidum each send a glutamatergic and a GABAergic projection to the same target, and the two have **opposite valence**; aversive stimuli drive both | one wire bundle, two signed sub-channels, selected by which cell type the upstream computation recruits — a sign bit implemented as a cell-type identity |
| **Sign as a ratio at one synapse** | the EPN terminal co-releases GABA *and* glutamate; the **ratio** shifts toward excitation under chronic stress and cocaine withdrawal, and is normalized by selective serotonin reuptake inhibitors | a signed scalar transmitted over a single connection with non-negative quantities on both sides, whose sign is a *plastic, slowly-drifting* parameter rather than a per-event value |

Whether GABA and glutamate share the same vesicles at the EPN terminal is unresolved, which is exactly the question of whether the ratio is settable per event or only per synapse.

**The review's own instrument warning, and it is `G116`'s.** Almost every input pathway, on optogenetic activation, produces the same result — real-time place aversion. The authors ask whether that reflects genuine convergence or "the artificial patterns used in optogenetic stimulation". Real-time place aversion and preference are approach/avoid measures, so none of this evidence separates a valence signal from an action signal.

---

## Efferents — one output family

| Target | Route | Consequence of driving it |
|---|---|---|
| **RMTg** (GABAergic, "tail of the VTA") | dense, from LHbL, via the fasciculus retroflexus | the principal route. RMTg stimulation strongly suppresses VTA dopamine firing; RMTg inactivation raises it. Driving LHb→RMTg promotes active, passive and conditioned avoidance, **reduces effortful behaviour**, and speeds onset of learned helplessness |
| Dorsal raphe | strong RMTg→raphe inhibition, plus direct LHbM glutamate onto serotonergic *and* GABAergic raphe cells | LHb stimulation suppresses dorsal and median raphe firing in mice; the zebrafish result is mixed but net inhibitory |
| Ventral tegmental area (direct) | sparse glutamate onto both dopaminergic and GABAergic cells | place avoidance and despair-like behaviour — but the terminal fields overlap RMTg, so the attribution is unsafe |
| Locus coeruleus (NA), laterodorsal tegmentum (ACh), thalamic nuclei, superior colliculus | — | LHb→laterodorsal-tegmental-interneuron drive induces fear-like behaviour, mimicking predator odour |

**The inversion is a relay, not a rate.** The LHb is glutamatergic and its aversive signal is an *increase*; the suppression of dopamine is produced by one interposed GABAergic population. A non-negative source therefore delivers `−1` to the dopamine channel and, via the same axons ([[wiki/entities/ventral-tegmental-area.md]]), `+1` to the medial-VTA→medial-prefrontal channel. Sign is in the wiring; nothing anywhere holds a negative number.

---

## Firing mode as a second code dimension

| Mode | Resting membrane potential | Share, normal rat | Share, depression models | Mechanism |
|---|---|---|---|---|
| Silent | ~−48 mV average (range −60 to −40) | 40–50% | — | — |
| Tonic (regular or irregular) | as above | 40–50% | disputed whether raised | — |
| **Burst** (clusters of high-frequency spikes) | ~−60 mV | **<10%** | **2–3×** higher — congenital learned helplessness, chronic stress, maternal deprivation, social defeat, chronic mild stress, hemiparkinsonian rats | low-voltage-sensitive T-type calcium channels de-inactivate below −55 mV and open the burst; **NMDA receptors** take the relay as the calcium channels inactivate, sustaining it |

- **Nearly all LHb neurons can burst** if hyperpolarized — the mode is a function of the membrane potential, not of cell identity. In vivo the three modes alternate *within the same neuron*; the fixed assignment is a slice artefact.
- Bursting intensifies output by reducing synaptic failure and synchronizing the population, so it is a **multiplicative gain** on the same wire, not a different message.
- **The set-point is glial.** Kir4.1, an astrocytic potassium channel on processes wrapping LHb somata, clears extracellular potassium; overexpressing it hyperpolarizes the neurons, increases bursting and *precipitates* depressive-like behaviour, while knockdown depolarizes, eliminates bursting and reverses it. A gain variable held outside both the neuron and its synapses.
- **The gain is pharmacologically separable from the rate.** Ketamine and the NMDA blocker AP5 instantly abolish bursting in slice; local infusion into the LHb alleviates depressive-like symptoms within an hour. T-type calcium blockers (ethosuximide, mibefradil) do the same. Nothing in the wiki has a knob that removes a channel's gain mode while leaving its rate code intact.
- Postsynaptic and presynaptic plasticity move the same output: CaMKIIβ upregulation inserts AMPA receptors and raises spike output; PP2A upregulation weakens GABA_B inhibition; stress facilitates long-term potentiation and impairs endocannabinoid-dependent long-term depression in the LHb. (`L3`/`L4` detail, kept here.)

**(brainstorm) The builder's version.** Give an aversive channel two variables: an event-locked rate `a_LHb(t)` and a slow scalar `g` gating a burst mode that multiplies the channel's downstream impact. `g` is written by a *different* controller on a timescale of days (here: stress → glial potassium handling), is invisible to the fast learning rule, and is the natural home for anything the wiki calls mood, context baseline or the movable origin of [[wiki/concepts/affective-opponency.md]]. The failure mode is measured and it is not subtle: raising `g` alone, with no change in the input, produces anhedonia and behavioural despair — an agent that stops trying without having learned anything new.

---

## What it computes

| Function | Evidence | Reading |
|---|---|---|
| **Negative reward prediction error** | LHb cells are excited by reward omission and punishment and inhibited by unexpected reward — the mirror image of dopamine cells, in monkey; confirmed in human functional imaging for both omitted positive and unexpected negative feedback. LHb also encodes reward **probability** and **magnitude** | the sign-inverse of the dopamine value signal, upstream of it |
| **…but not the whole of it** | LHb lesion in mice abolishes the negative prediction error in VTA dopamine cells caused by **reward omission**, and leaves intact the one caused by **aversive stimuli** | the LHb is the *disappointment* route specifically; aversive events reach dopamine by some other path. This is `T361` |
| Aversive state | shock, restraint, illness, maternal deprivation, social defeat all activate LHb (Fos, calcium, firing), especially LHbM; 78% of foot-shock-responsive LHb cells are excited, the rest inhibited; inhibition of LHb is anxiolytic and antidepressant | an aversive-state variable, not only an error |
| **Behavioural flexibility** | lesion or inactivation blocks **reversal** in both appetitive and aversive tasks: the animals learn the initial strategy normally and cannot abandon it | the anti-reward channel is the *policy-abandonment* signal. Deleting it does not make an agent fearless — it makes it unable to stop doing what it was doing |
| Motor suppression | lesions make animals hyperactive, distractible and prematurely responsive; burst drive reduces struggling in the forced-swim test but **not** open-field locomotion | suppression of *motivated* action specifically, not of movement |
| Memory | inactivation impairs Morris-water-maze performance when given before training or before retrieval, and **not** when given after training; prelimbic-mPFC→LHb disruption reproduces working-memory deficits | an **online** contributor to encoding and retrieval, with no consolidation role — the opposite profile to the hippocampal systems in the wiki |
| Circadian timing | the LHb has its **own** clock: isolated slices with no suprachiasmatic input sustain daily rhythmic firing, driven by cyclic clock-gene expression, higher in the light phase; it is also entrained by melanopsin retinal ganglion cells | the aversive channel's baseline is time-varying and locally generated, so "the same event" is not the same signal at two times of day |
| Sleep | habenula output removal cuts REM sleep and its atonia, fragments non-REM sleep, shortens hippocampal theta | — |
| Pain | LHb cells respond to noxious stimuli, mostly with excitation, blocked by systemic morphine; μ-opioid receptor expression peaks at the MHb/LHb boundary | a second collapse point for pain, downstream of [[wiki/concepts/general-danger-channel.md]]'s |

**The value-state / value-change hypothesis the review advances.** Dopamine cells signal value *changes* (motivation, 'wanting'); serotonin cells reflect a value *state* updated tonically (mood, 'liking'). The LHb is one of very few structures controlling both, which makes it the proposed integration node for change and state. For the wiki this is a concrete proposal about where [[wiki/concepts/incentive-salience.md]]'s two dissociable quantities could be jointly addressed — by a nucleus that writes to both, without computing either.

---

## Mapping to model components

| Biological element | Model component | Where the mapping breaks |
|---|---|---|
| >12 afferents → one nucleus | a summing junction over heterogeneous bad-news sources, with per-source weights | no wiki architecture has one; every aversive term enters the reward scalar already summed |
| RMTg relay | a fixed `×(−1)` edge to the reward channel | trivial in a model, and that is the point — biology pays one interneuron population rather than allowing a signed rate |
| EPN GABA/glutamate ratio | a per-synapse sign parameter on a slow timescale | plasticity rules in the wiki learn magnitudes; none learns a sign that is also the channel's baseline |
| burst/tonic mode + Kir4.1 | a slow multiplicative gain, written by a controller outside the fast loop | [[wiki/concepts/neuromodulatory-metaparameters.md]] has metaparameters with no author; this is an author with a measured knob |
| reversal deficit after lesion | ablating the negative channel should leave acquisition intact and break switching | a cheap, unrun ablation on any actor-critic with split heads |
| own circadian clock | a slowly oscillating channel baseline, endogenous | every baseline in the wiki is stationary |

---

## Limitations

- **Review, not primary data**, and the strongest mechanistic claims (bursting, Kir4.1, ketamine site of action) come from the authors' own laboratory.
- **Almost all causal evidence is optogenetic sufficiency read out as real-time place aversion** — an approach/avoid measure that cannot separate valence from action (`G116`), on firing patterns whose natural occurrence the review says is unmeasured for every pathway.
- **Subnucleus resolution is not reached.** The review concedes that virus and drug infusions leak into neighbouring regions and that lesions damage beyond the LHb; whether LHbM and LHbL have distinct functions is stated as an open question, not an answer.
- **Species differences in a load-bearing pathway**: the internal-globus-pallidus/EPN → LHb projection — the proposed negative-prediction-error source — is substantially *smaller* in monkey and cat than in rat, while the negative-prediction-error recordings are in monkey.
- **The dopaminergic innervation of the LHb has no established source**, despite dopamine receptors being present and local dopamine raising LHb firing.
- **Whether the LHb is a site of association or only a relay** is not settled for most pathways; only the lateral-hypothalamus→LHb synapse has demonstrated learning-related plasticity.

---

## Connections

- **[[wiki/entities/ventral-tegmental-area.md]]** — the downstream structure this one addresses, and the place its output splits in two: the same habenular axons excite the medial-VTA→medial-prefrontal dopamine line at 100% connection probability *and* drive the GABAergic rostromedial tegmental cells that inhibit the accumbens-lateral-shell reward line, so one non-negative source delivers opposite signs to two channels purely by wiring. This page adds what that one lacks — where the habenular signal itself comes from, and the finding that habenular lesion removes only the *omission*-driven dopamine dip.
- **[[wiki/concepts/broadcast-channel-decomposition.md]]** — that page's inferred `GPb → LHb → RMTg → DA` value-channel source, given its own afferent map and a correction: the habenula is not a single sign-inverting node but a convergence funnel whose inputs carry reward omission, pain, thirst, sound, touch, light and social defeat, and whose valence within a pathway is separated by transmitter rather than by target.
- **[[wiki/concepts/affective-opponency.md]]** — supplies both of that page's missing mechanisms from one structure: a sign carried as the GABA/glutamate *ratio* at a single co-releasing terminal, which is how a signed error survives non-negative firing rates without an opponent pair; and a slow, externally-written burst gain that is a literal context baseline — raising it alone produces anhedonia, which is the movable origin failing in the direction that page predicts.
- **[[wiki/concepts/reward-prediction-error.md]]** — the upstream inverse of that page's `δ`, and a dissociation it does not carry: the habenular route is necessary for the dopamine dip on *reward omission* and not for the dip on *aversive events*, so the negative half of `δ` is not one signal with one source (`T361`).
- **[[wiki/entities/basal-ganglia.md]]** — a third job for that page's output nucleus: the entopeduncular/internal-pallidal cells projecting here are inhibited by reward-predicting cues and excited by omission, so basal-ganglia output is not only a tonic gate on thalamus and colliculus but also the proposed source of a **teaching signal**, delivered on a co-releasing terminal whose sign is itself plastic.
- **[[wiki/concepts/general-danger-channel.md]]** — the second collapse point in the same series: the parabrachial population multiplexes pain, malaise, itch, satiety and novelty before the midbrain hears any of it, and this nucleus performs a second, larger convergence (basal ganglia, hypothalamus, pallidum, septum, cortex, retina) one stage later — two funnels in a row, which sharpens `T357` from *where does the address survive* to *how many times is it destroyed*.
- **[[wiki/entities/amygdala.md]]** — a parallel aversive route the review names as unresolved against this one: the central nucleus projects here *and* directly to the brainstem and to every ascending modulatory nucleus, so the wiki now has two structures claiming to be the aversive system's write-port, with no experiment separating parallel specification from serial intensification.
- **[[wiki/concepts/incentive-salience.md]]** — the proposed joint address for that page's two dissociable quantities: dopamine carries value *change* ('wanting') and serotonin a tonic value *state* ('liking'/mood), and this is one of the few structures that writes to both — without computing either.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the single upstream node that can move the whole metaparameter vector at once: its one output family suppresses dopamine, serotonin, noradrenaline and acetylcholine together, so "bad news" here is not a term in a value function but a simultaneous write to the learning rate, the temperature and the arousal level.
- **[[wiki/concepts/homeostatic-need-signal.md]]** — a need channel entering this one: vasopressin paraventricular cells signal water deprivation onto putative inhibitory habenular cells, so an internal-variable channel reaches the aversive hub as *disinhibition* rather than as an additive term, and water deprivation measurably reduces freezing and behavioural despair.
- **[[wiki/concepts/latent-graph-discovery.md]]** — what the reversal deficit says about structure learning: removing the negative channel leaves an agent able to acquire its first policy and unable to abandon it, so the anti-reward signal is what licenses *revising* a discovered structure rather than what builds it.
