# Ventral Tegmental Area — Four Labelled Lines, Not One Broadcast Nucleus

**The ventral tegmental area (VTA) is not a single dopamine source emitting one scalar. It is a set of near-disjoint input→cell-group→target chains: laterodorsal tegmentum (LDT) → lateral VTA dopamine cells → nucleus accumbens (NAc) lateral shell produces *reward*; lateral habenula (LHb) → medial posterior VTA dopamine cells → medial prefrontal cortex (mPFC) produces *aversion*; the same LHb input drives GABAergic rostromedial tegmental nucleus (RMTg) cells that inhibit the reward line; and an NAc-medial-shell line receives neither input detectably. Which channel fires is decided by *which afferent nucleus is active*, and what the channel does is decided by *where its axons land*, with dopamine receptors at the target necessary in both cases.**

> **Provenance.** Lammel et al. 2012, *Input-specific control of reward and aversion in the ventral tegmental area*, Nature 491:212–217 (`raw/lammel-2012-input-specific-reward-aversion-vta.md`). Mouse. Six methods stacked on one claim: glycoprotein-deleted rabies virus (RV) retrograde labelling, *Phaseolus vulgaris* leucoagglutinin (PHA-L) anterograde tracing, fluorescent retrobead labelling of projection identity, channelrhodopsin-2 (ChR2) optogenetics in behaviour and in slice, whole-cell recording from retrogradely identified cells, and intra-target receptor pharmacology. This is close to the experiment [[wiki/concepts/broadcast-channel-decomposition.md]] names as the missing one — pathway assignment by measurement rather than by inference from response properties.

Why this earns a page: the wiki's most-used biological signal, `δ` ([[wiki/concepts/reward-prediction-error.md]]), is attributed to "midbrain dopamine neurons" as if to one module. This source is the circuit-level decomposition of that module, and it is the evidence under the *address-by-axon* answer to the address problem. The `L3`/`L4` detail lives here so the concept pages can cite a measurement instead of carrying anatomy.

---

## The four lines

| | **Reward line** | **Aversion line** | **Brake line** | **Unaddressed line** |
|---|---|---|---|---|
| Afferent | LDT | LHb | LHb | neither (no detectable input from either) |
| Afferent transmitter | glutamate — **95%** of LDT→VTA cells express the glutamate transporter EAAC1, only **~7%** choline acetyltransferase (ChAT) | glutamate (EAAC1⁺, ChAT⁻) | glutamate | — |
| VTA/adjacent cell group | lateral VTA dopamine cells | medial posterior VTA dopamine cells | RMTg GABAergic cells | medial VTA dopamine cells |
| Target | NAc **lateral** shell | mPFC | back onto the reward line's cells | NAc **medial** shell |
| Connection probability (light-evoked EPSC >10 pA) | **100%** from LDT; ~10% from LHb-target cells | **100%** from LHb | **100%** from LHb | ~30–40% from LDT; **undetectable** from LHb |
| Behaviour on phasic stimulation of the afferent | conditioned place **preference** (CPP) | conditioned place **aversion** (CPA) | — | — |
| Target-receptor necessity | D₁+D₂ antagonists in NAc lateral shell abolish the CPP | D₁ antagonist (SCH23390) in mPFC abolishes the CPA | — | — |

Substantia nigra dopamine cells behave like the unaddressed line: ~30–40% connection probability from LDT, undetectable from LHb.

**The numbers are the point.** 100% versus 0% is not a gradient. Whatever mixing exists in firing records, the *synaptic* input map is close to binary once cells are sorted by projection target.

---

## Corroborating measurements

| Measurement | Result |
|---|---|
| Immediate-early gene *Fos* after LDT stimulation | ~40% of lateral VTA dopamine cells positive; threefold fewer in medial VTA |
| *Fos* after LHb stimulation | ~12% of medial VTA dopamine cells, **<2%** of lateral VTA dopamine cells, **~80%** of non-dopaminergic RMTg cells |
| *Fos* after LHb stimulation, split by target within medial VTA | **~80%** of mPFC-projecting cells; **<10%** of NAc-medial-shell-projecting cells |
| Monosynaptic rabies tracing from dopamine cells (glycoprotein restricted to tyrosine-hydroxylase-positive cells) | LDT labelled almost only from the NAc lateral shell seed (18.75 ± 7.12 vs 1.25 ± 0.75 cells per animal); LHb almost only from the mPFC seed (8.25 ± 3.44 vs 0.5 ± 0.22); nothing without glycoprotein |
| Feed-forward inhibition | LHb stimulation evokes IPSCs in **~60%** of NAc-lateral-shell-projecting dopamine cells, and in **none** of the NAc-medial-shell-projecting cells |
| Collateralization of the afferents | LDT and LHb cells projecting to VTA almost never double-label for ventral pallidum, lateral septum, lateral hypothalamus, mPFC, mediodorsal thalamus or supraoculomotor central grey. Positive control: ~20% of dorsal raphe cells double-label for VTA + ventral pallidum |
| Specificity controls | control virus: no behavioural effect; low-frequency stimulation: no effect; no change in open-field anxiety or locomotion; direct intra-VTA axonal stimulation reproduces both CPP and CPA |

The collateralization result is the one a builder should not skip: these are **dedicated wires**. The afferent cell that addresses a VTA channel does essentially nothing else. Compare the dorsal raphe control, where one-fifth of cells broadcast to two targets — the architecture can build fan-out and here chooses not to.

---

## What a builder takes

| Finding | Consequence for an architecture |
|---|---|
| The channel is selected by *which afferent fires*, not by the content of the outcome | Addressing is available at the **input** end as well as the output end. A router that picks a teaching channel by source identity needs no tag in the signal and no learned gate |
| Afferents to a channel do not collateralize | The selectivity is paid for in wiring, once, at development. Nothing is learned and nothing can be re-routed — the cost side of the address-by-axon trade on [[wiki/concepts/reward-prediction-error.md]] |
| Aversion is produced by dopamine *release*, not by dopamine *dip* | The standard scalar story makes bad news a decrement on one wire. Here bad news is an **increment on a different wire**, and blocking D₁ receptors at that wire's target abolishes the aversion. A signed scalar cannot express this; two rectified channels can |
| One afferent drives its own channel **and** inhibits the rival channel, di-synaptically | Opponency need not be a subtraction at the read-out. It can be a wired feed-forward inhibition inside the source nucleus, which costs one interneuron population and is not learnable |
| A third dopamine population receives neither input | Not every module in a broadcast system is on the reward/aversion axis at all. The NAc medial shell line is addressed by something not measured here |
| "LDT is cholinergic" is wrong for this projection | Transmitter identity of a nucleus is not the transmitter identity of its projection. ~7% cholinergic, 95% glutamatergic |

**(brainstorm) The cheapest machine version.** One outcome event, two afferent-tagged heads: `head_+` fires on appetitive evidence and writes to module set `A`; `head_−` fires on aversive evidence, writes to a disjoint module set `B`, *and* subtracts from `head_+`'s output. No sign bit anywhere, both heads non-negative, and the "value" a downstream observer would recover is `head_+ − head_−` while `head_+ + head_−` remains free — the free degree of freedom of [[wiki/concepts/affective-opponency.md]], obtained without ever representing a signed number. The prediction that distinguishes it from a signed scalar: ablate `head_−` and the agent should lose avoidance while keeping approach *and* keeping its estimate of how bad the outcome was on any channel `B` still reads.

---

## Open problems

- **No firing record.** Nothing here measures what the mPFC-projecting cells do to a *reward*, or to omission. Whether the second channel is an aversion channel or a valence-blind salience channel is therefore open, and it is the wiki's `T355`.
- **Stimulation is not physiology.** Phasic ChR2 drive of an afferent is a sufficiency test. It does not show that the LHb→mPFC line is what carries naturally occurring aversion, and low-frequency drive does nothing — so the effect exists only in a firing regime whose natural occurrence is unmeasured here.
- **The NAc medial shell line has no assigned input.** It is negative for both afferents tested and for the feed-forward inhibition; what addresses it is unknown.
- **Cell identification is by projection plus tyrosine hydroxylase, not by optogenetic tagging in a behaving animal** — better than the firing-property identification [[wiki/concepts/broadcast-channel-decomposition.md]] flags as unreliable in VTA, but the behavioural and the synaptic experiments are still in different preparations.
- **An unaddressed manipulation of this structure still produces an addressed result.** Sharpe et al. 2017 ([[wiki/concepts/state-prediction-error.md]]) drive or silence a virally and optically determined subset of these dopamine cells and obtain a *specific* cue→cue association rather than a diffuse one, which the labelled-line decomposition above does not predict: either the relevant line was hit by chance in every animal, or the content is supplied entirely downstream and the line identity is irrelevant to this particular learning product.
- **Whether the two channels are separately usable by one learner is untested** (`G117`). Both CPP and CPA are single-outcome conditioning; nothing requires the animal to learn a value and an engagement level about the same event — which is also why no architecture has been forced to carry one event on two differently-signed channels.

---

## Connections

- **[[wiki/concepts/broadcast-channel-decomposition.md]]** — the concept this page is the measurement for, and a partial correction of it: the review's inferred diagram makes LHb the *sign-inverting source* of the value channel, while here LHb is also the monosynaptic excitatory driver of a second dopamine population whose transmitter release is necessary for aversion, and the review's shell/core partition is cut across by a lateral-shell/medial-shell partition it does not name.
- **[[wiki/entities/amygdala.md]]** — the same addressing principle in a structure of a different kind: there two *glutamatergic* projection populations in a cortex-like nucleus are separated by target alone — intermingled, same transmitter, near-identical transcriptomes — and what differs between the channels is the **sign of plasticity** after one event rather than the sign of a firing rate. Two independent demonstrations that valence separation is carried by the output wire and not by cell type (`T368`).
- **[[wiki/concepts/reward-prediction-error.md]]** — the evidence under that page's *address by axon* row, upgraded from claimed to measured, plus an addition: the address is on the **input** side too, since which channel fires is set by which afferent nucleus is driven rather than by anything in the outcome.
- **[[wiki/concepts/affective-opponency.md]]** — a third arrangement for opponency, neither a signed scalar nor the difference of two tonic rates: one afferent excites its own dopamine channel and di-synaptically inhibits the rival channel through a GABAergic nucleus, so the subtraction happens in the source and the two channels' sum stays free.
- **[[wiki/entities/basal-ganglia.md]]** — the receiving structure, subdivided finer than that page represents: accumbens lateral shell and medial shell take different afferents, different feed-forward inhibition and different behavioural consequences, which the D₁/D₂ opponent account does not currently distinguish.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the aversion channel's target, and the point where this page's circuit meets that page's dorsoventral split: mPFC's strong back-projection to the ventral tegmental area is documented there, so the structure this channel teaches is also one of the structures that addresses it.
- **[[wiki/concepts/incentive-salience.md]]** — the behavioural dissociation this anatomy has to accommodate: a ~1 mm³ hedonic hotspot sits inside accumbens and is dopamine-insensitive even locally, so neither of this page's two dopamine lines can be the one that generates 'liking'.
- **[[wiki/concepts/vectorized-instructive-signals.md]]** — the anatomical intermediate made concrete: a handful of instructive channels, addressed end-to-end by dedicated non-collateralizing wires, sitting between one global scalar and one error per synapse.
- **[[wiki/concepts/latent-graph-discovery.md]]** — what dedicated wiring buys and costs for structure learning: the agent gets a prior partition of teaching signals for free at development, and can never re-partition it when the task's own decomposition turns out different.
- **[[wiki/concepts/homeostatic-need-signal.md]]** — the same address-by-anatomy principle applied to a different partition: here the channel is selected by which afferent nucleus responds to an external event, there by which internal variable is out of range, and both partitions carry no tag in the signal and are fixed at development rather than learned.
- **[[wiki/concepts/general-danger-channel.md]]** — the same question one stage upstream, answered the other way: here two afferent nuclei *select* two near-disjoint dopamine channels, so the address is in the wiring; there one parabrachial population *collapses* cutaneous pain, visceral malaise, itch, satiety, novelty and a learned fear cue onto shared cells before the midbrain hears any of it. The two results bound where in the hierarchy a broadcast signal's address survives (`T357`), and the collapsing relay is the nucleus this page's sources name as the supplier of the aversive-outcome component.
- **[[wiki/entities/amygdala.md]]** — the afferent proposed to select among this structure's lines during appetitive conditioning: the central nucleus of the amygdala has no direct accumbens projection and is required for autoshaping, Pavlovian–instrumental transfer and amphetamine potentiation of conditioned reinforcement, so its control of behaviour is a claim about control of these cell groups — by a nucleus that is not valence-selective, which the line-level valence assignments here do not inherit.
- **[[wiki/entities/lateral-habenula.md]]** — the afferent that selects two of this page's four lines, given its own decomposition: the signal it delivers is itself assembled from more than a dozen convergent sources with valence separated by transmitter within a pathway, its sign is inverted by an interposed GABAergic relay rather than carried as a negative rate, and habenular lesion removes the dopamine dip on **reward omission** while leaving the dip on aversive events intact — which asks what this page's "aversion line" is a line of (`T361`).
- **[[wiki/concepts/valuation-system-decomposition.md]]** — the decomposition this structure supplies the gain term for: that page factors incentive into content × gain and names this structure as the route by which a Pavlovian cue sets accumbens dopamine, since the central amygdala has no direct accumbens projection of its own.
- **[[wiki/concepts/sign-tracking-and-goal-tracking.md]]** — a functional-necessity constraint on this structure's channel partition: accumbens-core dopamine carries the full prediction-error signature in an animal that attributes incentive value to a cue and *none* in one that learns the same prediction without doing so, and systemic receptor blockade during acquisition costs the second animal nothing — so whatever teaches it is not among the lines traced here (`T404`).
- **[[wiki/concepts/state-prediction-error.md]]** — the learning product this structure's transients are shown sufficient and necessary for, and a problem for the labelled-line reading: 2 s of phasic drive to an unselected subset of these cells writes a specific, devaluation-sensitive link between two neutral cues, so for this product the address is not in the line.
