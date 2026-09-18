# Homeostatic Need as a Teaching Signal

**A physiological need is carried by a small, need-specific neuron population whose activity *is* the negative valence. Reinforcement is the **fall** of that activity, not a property of the outcome: cues paired with elevated activity are devalued, cues paired with its reduction are preferred, and an outcome that no longer lowers it stops being worth working for. The fall is *predictive and learned* — it happens at the food-predicting cue, seconds before any nutrient — but only ingestion makes it stick.**

> **Provenance.** Betley, Xu, Cao, Gong, Magnus, Yu & Sternson 2015, *Neurons for hunger and thirst transmit a negative-valence teaching signal*, Nature 521:180–185 (`raw/betley-2015-hunger-thirst-negative-valence-teaching-signal.md`). Primary: cell-type-specific optogenetic and chemogenetic manipulation plus head-mounted deep-brain calcium imaging (GRIN lens, GCaMP6) of arcuate AGRP neurons and subforniceal NOS1 neurons in freely moving mice.

Why this earns a page. [[wiki/concepts/reward-prediction-error.md]] disputes what the broadcast *error* carries; [[wiki/concepts/incentive-salience.md]] splits the reward term `r` into a hedonic and a motivational quantity. Both leave `r` a property of the **outcome**. This page's source makes `r` a property of the outcome's **effect on an internal state variable** — and that variable is simultaneously an input to behaviour, which is the pairing `G57` says no architecture has.

---

## The measurements

| Manipulation | Result | Reading |
|---|---|---|
| AGRP photostimulation paired with one of two non-nutritive flavours, *ad libitum* fed mice | preference for the paired flavour **reduced** | elevated need activity has negative valence |
| AGRP photostimulation after a novel taste (saccharin) | **no** conditioned taste aversion, unlike LiCl | graded negative valence, *not* disgust or nausea — consistent with stimulation also eliciting copious eating |
| Chemogenetic AGRP silencing (PSAM<sup>L141F</sup>-GlyR + PSEM<sup>89S</sup>) paired with a flavour, food-restricted mice | preference **increased**; Δpreference correlated with the drop in chow re-feeding | removing the signal is reinforcing, in proportion to how much signal was removed |
| Same silencing, place conditioning, **no food present** | occupancy shifts to the paired side in food-restricted but **not** *ad libitum* mice; correlated with transduction efficiency, with the food-intake reduction, and across the two assays in the same mice | the reinforcer is the need reduction itself, not ingestion, and it is null when there is no need to reduce |
| Passive place conditioning to AGRP stimulation | not sufficient (Δ 28.4 ± 72 s, `P` = 0.70, `n` = 10); did not oppose cocaine place preference | weak on its own — the contrast must be experienced |
| **Closed-loop** place conditioning (stimulation triggered by entering the paired side) | avoidance develops over sessions, stronger in the **second half** of each session; extinction test then shows preference for the side where stimulation *ceased* | the minutes-long latency of AGRP-evoked feeding sets the timescale of the valence too |
| Lever-press or nose-poke to **turn off** stimulation (fed) or to silence AGRP (restricted) | **failed** in every attempt | a valid Pavlovian reinforcer that is not a valid instrumental one — see below |
| SFO<sup>NOS1</sup> photostimulation | drinking at 3.8 ± 0.5 min latency (20 Hz), water only, no food; closed-loop place **avoidance** over 7 sessions; extinction preference for the cessation side | the same design on a second need, with a different behavioural output |
| Chemogenetic subforniceal activation | water intake and progressive-ratio breakpoint for water up, food unaffected | the need channel is *need-specific*, not a general drive |

**The lateral-hypothalamic contrast is the paper's own, and it is the fork.** Stimulation of lateral hypothalamic neurons also elicits avid eating, but is **rewarding** and supports *both* Pavlovian and instrumental learning. Two populations, one behaviour, opposite valence — carried here as `T356`.

---

## The endogenous signal: two components on two timescales

Deep-brain imaging of individual AGRP neurons in freely moving mice.

| Observation | Number | What it constrains |
|---|---|---|
| Food restriction raises activity over the fed state | 54/61 neurons | the population codes a scalar deficit, near-uniformly |
| Chow delivery to a restricted mouse suppresses activity | 106/110 (96%); 1/110 increased | not a sparse code — essentially the whole population moves together, so the broadcast is one number |
| Suppression begins **before** consumption | — | it is driven by the cue, not by nutrient |
| A *visible but inaccessible* pellet suppresses activity | nearly to the level of actual consumption | a pure prediction, with no consummatory contact at all |
| A **false food** object (wood block) suppresses only transiently, recovering rapidly **on contact** | — | the same shape as an omission dip: the prediction is issued, then retracted when disconfirmed |
| Food removed after <50 mg consumed | activity climbs back to slightly **below** the original baseline | the slow component moved a little; the fast component fully reverted |
| Repeated short food exposures | progressive decline in baseline, significantly larger than for false food | the slow component integrates actual nutrient |
| Pavlovian **trace conditioning** with a 200 ms audiovisual cue | naive: slight *increase* at the cue, drop just before consumption. After pairing: the **cue itself** elicits the drop, and food adds little | the drop migrates to the earliest reliable predictor — and does so *by learning* |
| Ghrelin injection | 81% of neurons brighten (4% dim), decaying with population `t½` = 19 min (individual range 5–46 min) | the hormonal input is slow and the cue-driven input is fast, in one population |

**(brainstorm) `−AGRP` behaves like `V`, not like `r`.** Every signature on this table is a temporal-difference signature read upside down: migration of the response to the earliest reliable cue, a retraction when the prediction is disconfirmed (false food), and a persistent shift only when the primary quantity actually arrives. The decomposition the data force is

```
AGRP(t)  ≈  deficit(t)  −  V̂_relief(t)
             ↑ slow integrator            ↑ fast learned predictor
             moved only by nutrient       moved by any cue that has predicted nutrient
reinforcement  ∝  −d/dt AGRP(t)
```

which is `δ` on a *negative* quantity whose baseline is an interoceptive state rather than a stored value. Two consequences the wiki has nowhere else. (i) The teaching signal and the state variable are the **same trace**, differing only in whether a consumer reads its level or its derivative — the pairing `G57` asks for. (ii) The "reward" has an address by construction: hunger and thirst are separate populations with separate targets, so the signal carries *which need* without carrying any tag. That is the direct answer to the worry Schultz, Dayan & Montague state and do not solve on [[wiki/concepts/reward-prediction-error.md]] — that an unaddressed scalar may make an agent "learn to approach food when it is actually thirsty". Biology's answer is not a tag and not a gate: it is **one broadcast channel per need**. That answer holds **at the source and not at the next relay**: the satiety signal this channel's target generates arrives at parabrachial CGRP neurons that carry footshock, visceral malaise, itch and food novelty on the same cells, and those neurons are in turn *inhibited by AGRP*, so the need channel both feeds and gains-controls a line on which its own modality is discarded ([[wiki/concepts/general-danger-channel.md]], `T357`).

---

## Reinforcement is drive reduction, and it can be switched off without touching the outcome

The progressive-ratio experiment is the sharpest result on the page because it manipulates nothing about the food.

| Step | Observation |
|---|---|
| Mice trained to lever-press for pellets under food restriction (PR7) | stable responding for 15 sessions |
| Re-fed *ad libitum*, then tested **with AGRP photostimulation held on** through the session and after levers and food were withdrawn | first session: lever-press rate and consumption indistinguishable from the restricted group (`P` = 0.49) |
| Subsequent sessions | progressive decline in presses, pellets consumed and breakpoint, to near the un-stimulated floor; **high-effort response ratios diminished most** |
| Controls | not long-term metabolic change; not food aversion or stimulation fatigue — *ad libitum* food intake under the extended protocol was unaltered |

Exogenously elevated AGRP activity cannot be lowered by eating. So the animal repeatedly experiences consumption that fails to relieve the need — and the food *loses instrumental value* while remaining perfectly edible. This is the falsification of the alternative the authors set up: if hunger worked by *potentiating the positive valence of food* rather than by *signalling a deficit to be reduced*, pressing would have stayed elevated.

**What a builder takes from it.** `r` is not stored on the outcome and looked up. It is computed at consumption time as the outcome's measured effect on an internal variable. An architecture with a fixed reward function cannot express this experiment at all: there is no intervention on it that devalues a food item while leaving the item, the policy, the values and the environment untouched.

---

## One reinforcer, two learning systems, and it only reaches one

The dissociation is stated flatly by the source: AGRP activity "is associated with a negative-valence signal that can mediate Pavlovian learning, but this property does not readily extend to instrumental conditioning."

| Learning system | AGRP signal | Evidence |
|---|---|---|
| **Pavlovian** (flavour preference, place preference, closed-loop place avoidance) | works, bidirectionally | four independent assays, with magnitude correlations across two of them |
| **Instrumental** (lever-press or nose-poke to terminate stimulation or to silence the neurons) | **fails** | every attempt; and passive place conditioning alone is also insufficient |
| **Instrumental performance** (vigour on an already-learned contingency) | works, and is *sensitive* to the signal | AGRP stimulation drives high-rate pressing, which then decays when relief never arrives |

So the signal **energizes** an instrumental policy it cannot **reinforce**. In every architecture in the wiki a scalar that reaches a learner reaches all of it: `δ` trains the critic, the actor, and (in [[wiki/entities/meta-rl-agent.md]]) the recurrent dynamics as an input, with no notion of a reinforcer being admissible to one consumer and inadmissible to another. This is `G119`.

**(brainstorm) A cheap reading of why, and it is testable.** The failure tracks the signal's *timescale*, not its magnitude: AGRP-evoked feeding has a minutes-long latency, closed-loop avoidance only appears in the second half of a session, and instrumental conditioning needs an action-contingent change detectable within an action's credit window. A slow modulator is a perfectly good Pavlovian reinforcer — cue-outcome association tolerates a trace — and a useless instrumental one, because no single press moves it measurably. The machine version needs no biology: low-pass a reward signal at increasing time constants and measure at which constant Pavlovian-style state preference survives while action-contingent learning breaks. If the two break at the same constant, the biology is telling us something else and this row is wrong.

---

## What a builder takes

| Finding | Consequence |
|---|---|
| A need state and its teaching signal are one trace, read as level and as derivative | The `G57` pairing exists in biology and is cheap to build: one scalar per need, entering the policy input *and* the plasticity term, with the two roles separately ablatable |
| Reinforcement is `−Δ(need)`, computed at consumption | A fixed reward function cannot be devalued by an intervention that leaves the outcome intact; a need-derivative one can, and the devaluation is graded by effort cost |
| The need signal is need-specific, and there are several | Address-by-channel for the reward signal, obtained without any tag in the signal and without a learned gate — the structural answer to `G19`'s "approach food when thirsty" failure mode |
| The predictive drop is learned and migrates to the earliest cue | The need signal is not a raw interoceptive read-out; it has a value function subtracted from it upstream of anything the wiki models |
| Elevated need has negative valence but is not aversive (no taste aversion) | Magnitude and *kind* of negative signal are separate; a single signed scalar cannot distinguish "costly" from "poisonous", and the animal's learning differs on the two |
| The signal reinforces Pavlovian learning and not instrumental learning | Reinforcers are not fungible across an agent's controllers (`G119`); a design with one `δ` wired to everything has assumed a fungibility the biology denies |
| Two needs, same design (hunger, thirst) | The pattern is a *schema* for homeostatic variables, not a fact about feeding — cheap to instantiate for any internal variable with a set point |

---

## Open problems

- **Nothing here says what consumes the derivative.** The paper establishes that reducing AGRP activity conditions preference; the downstream circuit that converts `−dAGRP/dt` into a plasticity term is not identified, and is not obviously dopaminergic.
- **The Pavlovian/instrumental asymmetry has no mechanism**, only the authors' observation that the stimulation is not strongly aversive "such as a shock". The timescale reading above is this wiki's guess and is untested.
- **The slow and fast components are not separately manipulated.** Nutrient moves the baseline and cues move the transient, but no experiment holds one fixed and varies the other — which is what would show they are two quantities rather than one with two inputs.
- **`G116` bites here too.** Conditioned place preference and avoidance are approach/avoid measures, so "negative valence" is not separated from "an action signal" by any assay in this paper.
- **How several need channels are arbitrated is untouched.** Hunger and thirst are shown to be separate and need-specific; nothing measures what an animal does when both are elevated, which is the only interesting case for a builder.
- **Whether the need signal is one number or a population code is under-determined by the instrument.** 96% of imaged neurons move together on food delivery, but calcium imaging of a genetically defined population is biased toward exactly that conclusion.

---

## Connections

- **[[wiki/concepts/reward-prediction-error.md]]** — supplies the `r` that page differences, and reinterprets it: `r` is the measured fall of an interoceptive need variable rather than a property of the outcome, so a food item is devalued by making its consumption fail to lower the variable, with the item unchanged. It also answers that page's stated address problem structurally — one broadcast channel per need rather than a tag in the signal — and reproduces the page's temporal-difference signatures (migration to the earliest cue, retraction on disconfirmation) on a *negative* quantity.
- **[[wiki/concepts/incentive-salience.md]]** — the other attack on the same scalar, from the opposite side: that page splits `r` into hedonic impact and motivational gain at the *cue*, this one makes `r` a derivative of an internal state at the *outcome*. They are compatible and jointly fatal to a one-number reward — and the two are dissociated here, since AGRP stimulation raises pursuit (a 'wanting'-like effect) while the same manipulation devalues the paired flavour. The rival account's closed form makes the disagreement arithmetic rather than verbal: under `Ṽ(s_t) = κ(state)·r_t + γV̂(s_{t+1})` (Zhang et al. 2009) a need cannot be spent by consumption, so an unrelievable need holds pursuit up, where this page's measurement has it collapse (`T356`) — and that model's own strongest datum, a cue re-valued by a never-before-experienced sodium appetite with the outcome never re-tasted, is a case this page's `r = −Δ(need)` has to reach by some other route.
- **[[wiki/concepts/affective-opponency.md]]** — an instance of that page's `punishment × Go` conflict quadrant resolved by neither of its mechanisms: elevated need is a negative-valence signal that *drives* vigorous approach, and it reaches the quadrant by being a need channel rather than by moving the valence origin or by a mode switch. It also supplies a clean case of that page's movable origin measured on an internal variable — the same food is reinforcing or not depending on the current deficit — and a limit on the coupling, since the signal energizes an instrumental policy it cannot reinforce.
- **[[wiki/concepts/broadcast-channel-decomposition.md]]** — extends the channel count past the dopaminergic ones: hunger and thirst are two further broadcast scalars with their own sources (arcuate, subfornical organ), their own hormonal inputs and their own need-specific behavioural outputs, so "how many broadcast channels" is answered partly by "how many regulated internal variables".
- **[[wiki/entities/ventral-tegmental-area.md]]** — the same address-by-anatomy principle one level up: there the partition of *events* into channels is made by which afferent nucleus responds, here it is made by which homeostatic variable is out of range, and neither partition carries a tag or is learnable within a lifetime.
- **[[wiki/concepts/subjective-value.md]]** — the state dependence that page's values lack: the worth of an outcome here is not a stable per-agent quantity but a function of the current deficit, so a discount rate or value estimate measured in one need state does not transfer to another.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the closest existing framing: a set point plus a prediction error on an interoceptive channel is exactly this signal, and the measured result adds the part that framing asserts rather than shows — that the *reduction* of the interoceptive error is what conditions preference for exteroceptive cues.
- **[[wiki/concepts/latent-graph-discovery.md]]** — what the need channel does to edge values: the worth of an edge is the change it produces in an internal variable, so the same graph carries different edge weights under different needs and an agent with several needs is navigating one graph with a bank of weightings rather than a single value function.

- **[[wiki/concepts/general-danger-channel.md]]** — the immediate downstream limit on this page's address-by-channel answer, and a reciprocal coupling: AGRP neurons *inhibit* the parabrachial CGRP population, so an energy deficit lowers the baseline of a general threat channel (the circuit form of risk-taking under starvation), while the satiety signal that ends a meal reaches that population on the very cells that carry footshock — one relay up, need identity is gone (`T357`). This page's `r = −Δ(need)` arithmetic reappears there applied to novelty (`T358`).
- **[[wiki/concepts/valuation-system-decomposition.md]]** — the same non-fungibility approached from the response side rather than the signal side: there a fully competent Pavlovian CR cannot be brought under instrumental control at all, matching this page's reinforcer that teaches one system and only energizes the other (`G119`). It also separates this page's state term from the instrumental store — Pavlovian value tracks motivational state directly, instrumental incentive value does not move until the outcome is re-experienced in the new state.
- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — the boundary this page's signal sits on: it is internal, adaptive and homeostatic, but defined over a *named* channel, so the permutation test that defines an intrinsic reward (relabel every sensor and motor; if the reward changes it is extrinsic) excludes it — which makes the need channel the extrinsic value source that the label-free curiosity formulas have to be combined with, by a rule neither literature supplies.
- **[[wiki/entities/lateral-habenula.md]]** — a need channel entering the aversive hub by the unexpected sign: vasopressin paraventricular cells signal water deprivation onto *putative inhibitory* habenular neurons, so thirst reaches the anti-reward funnel as disinhibition rather than as an additive bad-news term, and water deprivation measurably reduces freezing after predator exposure and immobility in the forced-swim test.
- **[[wiki/concepts/empowerment.md]]** — the unsatiable, channel-agnostic drive this page's signal has to be combined with: empowerment is defined over *any* actuator/sensor labelling and has no set point, so an agent carrying both has two currencies with no exchange rate — and the empowerment literature offers none, naming the integration of an explicit goal or need with capacity maximisation as fully open (Salge et al. 2013).
- **[[wiki/concepts/expected-value-of-control.md]]** — a third route by which an internal state reaches behaviour, and the reason it complicates `T356`'s closing assay: state is an argument of the control *decision*, so a need can move the price an agent will pay with the reward and the value function untouched — which makes a progressive-ratio decay evidence against a multiplicative account only once the manipulation is shown not to have raised `Cost(signal)`.
