# The General Danger Channel

**One small brainstem population carries *everything bad* on one line. The same individual neurons respond to mechanical, thermal, electrical and chemical cutaneous pain, to visceral malaise, to itch, to meal-termination satiety, to an unfamiliar food or object, and to a tone that was paired with shock — graded by intensity, and driven *negative* by the anticipation of food. A reader of this line recovers *how bad* and *when*, and is architecturally denied *what* and *where*: modality and origin travel on parallel pathways. The channel is also reactivated by the aversive memory it helped create, and that reafference is what makes a fear state persist rather than extinguish.**

> **Provenance.** Campos, Bowen, Roman & Palmiter 2018, *Encoding of danger by parabrachial CGRP neurons*, Nature 555:617–622 (`raw/campos-2018-parabrachial-cgrp-danger-encoding.md`). Primary: single-cell calcium imaging (GCaMP6m, GRIN lens, head-mounted microscope, CNMF source extraction) of genetically identified CGRP-expressing neurons of the external lateral parabrachial nucleus (CGRP<sup>PBN</sup>) in mice, awake and anaesthetized, plus cell-type-specific silencing by Cre-dependent tetanus toxin light chain (TetTox).

Why this earns a page. [[wiki/concepts/homeostatic-need-signal.md]] answers the wiki's address problem structurally — *one broadcast channel per regulated variable*, so hunger and thirst never get confused. This source measures the next relay up and finds the opposite design: hunger's satiety signal, a footshock and a novel pellet all converge on **the same cells**, and the modality distinction that existed at the source is gone by the time the forebrain hears it. The two designs are both real and they are in the same animal, which is what makes this a page and not a paragraph.

---

## What the same neurons respond to

Within-neuron, not within-population: neurons were tracked across assays and the overlap is the result.

| Stimulus | Class | Response | Overlap evidence |
|---|---|---|---|
| Tail pinch | mechanical, cutaneous | activation | **384/384** neurons responded to ≥4 of 5 pinches in one session |
| Pinch to any of four paws; warm rod on the lip | mechanical / thermal, trigeminal and spinal | activation | the *same* neurons as tail pinch |
| Tail immersion, temperature ramp | thermal | silent below 44 °C, most neurons activated at ≥46 °C, amplitude rising with temperature | graded — the channel codes intensity, not just presence |
| Electrical tail or foot shock | electrical | fast, time-locked activation, amplitude rising with shock intensity | neighbouring OXTR<sup>PBN</sup> fluid-intake neurons show **no** fast response — the convergence is on this population, not on the nucleus |
| Intraperitoneal lipopolysaccharide | visceral malaise, vagal | activation | the pinch-responsive neurons |
| Subcutaneous chloroquine | itch — noxious but not painful | activation | most neurons |
| Chow presentation to a fasted mouse | appetitive anticipation | **inhibition**, beginning before the first bite; further dips before individual bites | nearly all neurons; all feeding-assay neurons also responded to tail pinch |
| Progressive consumption (30–60 min) | interoceptive satiety, via NTS | activation, rising as intake falls (0.71 g in 0–30 min → 0.22 g in 30–60 min) | same cells as pain |
| Novel high-fat pellet, first trial | novelty | activation at presentation **and** after each bite | reverses to inhibition once familiar |
| Novel inedible object (marble) | novelty | activation, dissipating with acclimation to *neutral* (no inhibition) | the appetitive inhibition needs the food, the novelty activation does not |
| Tone previously paired with footshock | learned, exteroceptive | activation during the 10 s tone, declining across extinction in step with freezing | absent in unpaired controls; the conditioning context alone also activates |

**The population moves as one number.** CNMF-extracted single traces are unsynchronized at rest, yet all neurons are similarly inhibited at food presentation and before bites. The channel is a scalar with a sign, driven up by threat of any kind and down by the prediction of relief.

**Two inputs set the baseline, and one of them is the hunger channel.** AGRP hunger neurons **inhibit** CGRP<sup>PBN</sup> (ablating AGRP neurons disinhibits them and causes severe anorexia); nucleus of the solitary tract neurons carrying vagal satiety signals **excite** them. Food restriction therefore lowers the whole danger channel's baseline. **(brainstorm)** That is a homeostatic deficit acting as a *gain control on a threat channel* — the mechanism under "a starving animal takes risks" — and no architecture in the wiki couples a need variable to the sensitivity of an aversive input rather than to the value of an outcome.

---

## What the channel is necessary for

TetTox silencing of the same population, against GFP controls.

| Behaviour | Effect of silencing | Reading |
|---|---|---|
| Chloroquine-induced scratching | attenuated | the channel is a required relay, not an epiphenomenal correlate |
| Sticker-removal attempts (mechanical, non-painful) | attenuated | including for a stimulus with no nociceptive component |
| Food neophobia | attenuated on the first two exposures to a novel palatable diet | novelty avoidance is *carried by the danger line*, not by a separate exploratory system |
| Fear expression on the **first** extinction trial, weeks after conditioning | **unchanged** | recall and expression of the fear memory do not need this channel |
| Fear **persistence** across extinction training | collapses — minimal freezing by the second extinction session, matching never-conditioned controls | the channel maintains the state; it does not retrieve it |

---

## The teaching signal is regenerated by the memory it built

The extinction dissociation is the sharpest architectural result here, because the two halves come from one manipulation applied *after* learning was complete.

```
conditioning:   shock ──► CGRP_PBN ──► CeA/BNST ──► fear memory        (primary relay; established previously)
recall:         tone  ──► [forebrain] ──► CGRP_PBN ──► fear state       (measured here)
                                          └─ silenced ⇒ first trial unchanged, extinction ~4× faster
```

The conditioned stimulus re-drives the **same line the unconditioned stimulus used**. So the learned predictor's output is fed back into the channel that taught it, and the loop is what resists updating: with the loop cut, the memory behaves like an ordinary predictor and extinguishes at the rate the evidence supports; with it intact, every recall re-supplies a fragment of the original teaching signal and either restrengthens the aversive association or blocks consolidation of a competing safe one (the source's own two readings, which its data do not separate).

No architecture in the wiki does this. A temporal-difference agent's `δ` is emitted by the environment plus the critic and never by the retrieved memory; extinction is therefore always monotone in disconfirming evidence, and a persistent state that outlives its evidence is not expressible. This is `G120`. It is adjacent to but distinct from `G57`: `G57` asks for a teaching signal that is also a *state observation*; this asks for a teaching signal that is also an *output of the predictor it trains*.

---

## Novelty arrives with negative valence

A novel palatable pellet drives the danger channel on the first trial — at presentation and after every bite — and silencing the channel removes the resulting neophobia. Acclimation flips the response to the appetitive inhibition seen for familiar chow, and consumption latency falls `115.2 ± 16.0 s → 20.4 ± 4.1 s`. For the inedible marble, the activation dissipates to neutral instead.

Every epistemic-drive construct in the wiki gives novelty the **opposite sign**: expected free energy adds a parameter-novelty term as a *reward*, and in the environments where it matters that term carries essentially the whole effect ([[wiki/concepts/epistemic-value.md]]). Here first contact with the unknown is routed through the same cells as a footshock, and the animal's default is avoidance that decays with exposure. Carried as `T358`. **(brainstorm)** The cheap reconciliation is that biology's exploration bonus is a *negative* one that anneals — the drive to sample is the relief of removing a standing penalty on the unfamiliar, which is the same arithmetic as [[wiki/concepts/homeostatic-need-signal.md]]'s `r = −Δ(need)` applied to uncertainty, and it has a safety property an additive bonus lacks: the agent cannot be baited into a novel state by a bonus it has not yet paid for.

---

## Against address-by-channel

| Claim | Source | Where it holds |
|---|---|---|
| The address of a broadcast scalar is *which channel moved*; one channel per regulated variable | Betley et al. 2015, [[wiki/concepts/homeostatic-need-signal.md]] | at the hypothalamic **source** — AGRP hunger and SFO<sup>NOS1</sup> thirst are separate populations with different targets and need-specific behavioural outputs |
| The same neurons carry cutaneous pain, visceral malaise, itch, satiety, novelty and a learned fear cue; modality travels on parallel pathways | Campos et al. 2018, this page | at the parabrachial **relay**, one synapse downstream of the satiety signal |

Both are measured, in the same species, on partly the same circuit. The reconciliation the authors offer is a division of labour — CGRP<sup>PBN</sup> "conveys negative valence, while parallel pathways are likely to provide information regarding sensory modality and stimulus origin" — which is a claim about a *second* channel that this paper does not record and no cited study has recorded alongside it. Until it is, the wiki has an unresolved question about where in a hierarchy the address survives, carried as `T357`. What is not in dispute is the direction: addressing is **lost going up**, not gained, and the forebrain reads a scalar that its own input stage manufactured by discarding modality.

This also revises a row on [[wiki/concepts/broadcast-channel-decomposition.md]], where the parabrachial nucleus appears as the supplier of dopamine's "aversive-outcome component specifically". Measured, the supply is not specific to aversive outcomes: it includes satiation and novelty, and it is *suppressed* by appetitive anticipation.

---

## What a builder takes

| Finding | Consequence |
|---|---|
| One line multiplexes interoceptive and exteroceptive threat, with modality stripped | A negative-valence scalar is a legitimate design, but it must be paired with an explicit parallel modality path — otherwise the downstream learner cannot tell "stop eating" from "flee", which is the [[wiki/concepts/reward-prediction-error.md]] address problem reappearing one level up after biology had apparently solved it |
| The channel is bidirectional: threat up, predicted relief down | One signed scalar covers both "danger present" and "relief predicted"; the appetitive direction is a *dip*, exactly as in the need-signal design, and it is cue-driven and pre-consummatory |
| It codes intensity with a threshold (silent <44 °C, graded above 46 °C) | The transfer function is rectified-with-threshold, not linear — a wide neutral band, so ordinary variation never reaches the forebrain |
| Novelty enters here, not on a separate exploratory channel | An exploration term and a threat term may be the same register with opposite sign conventions (`T358`) |
| Silencing leaves recall intact and accelerates extinction | Persistence of a learned affective state is a *separate mechanism* from its retrieval, and it lives in the teaching channel (`G120`) |
| A need signal sets the channel's baseline (AGRP inhibits it) | Risk sensitivity is a cheap scalar gain driven by a homeostatic variable, not a policy-level trade-off that must be learned |
| Projections to CeA and BNST from one source | The same scalar is read by two targets presumed to act on different timescales; the broadcast is one number, the *interpretations* are several |

---

## Open problems

- **The parallel modality pathway is asserted, not recorded.** Nothing here shows that anything downstream of the parabrachial nucleus recovers which stimulus fired the channel. Until a modality-carrying line is imaged in the same animal, `T357` cannot close.
- **Nothing distinguishes "the same neurons respond" from "the same neurons respond differently".** Amplitude, duration and downstream target could all differ by stimulus; the authors explicitly speculate that behaviours are tuned by magnitude and duration. A scalar that is really a low-dimensional trajectory would restore some addressing without a second channel.
- **The forebrain inputs that drive the channel during neophobia and fear recall are unidentified.** "Numerous forebrain projections to the PBN are candidates" — so the reafference loop in `G120` has a measured output and an unmeasured return path.
- **`G116` bites throughout.** Freezing, scratching, avoidance and consumption latency are all action measures; "negative valence" is not separated from "an action signal" by any assay here.
- **Calcium imaging of a genetically defined population is biased toward finding uniformity.** The same instrument caveat as [[wiki/concepts/homeostatic-need-signal.md]]: near-complete co-activation is what this method reports most readily.
- **Intensity coding and multiplexing are not reconciled.** If one scalar carries both *which threat* (it does not) and *how bad*, then a mild shock and severe nausea are the same number, and nothing in the paper says whether downstream behaviour treats them as such.

---

## Connections

- **[[wiki/concepts/homeostatic-need-signal.md]]** — the direct counterpart and the direct conflict: that page's AGRP hunger signal *inhibits* the population on this one, so a need channel sets the danger channel's baseline, and the satiety signal that terminates a meal arrives here on the very cells that carry footshock. Its "one broadcast channel per regulated variable" answer to the address problem holds at the hypothalamic source and fails at this relay (`T357`); its `r = −Δ(need)` arithmetic is reused here for novelty (`T358`).
- **[[wiki/concepts/reward-prediction-error.md]]** — the aversive half of that page's `r`, measured: a single unaddressed negative scalar that is graded by intensity, bidirectional, and manufactured by discarding modality — which reopens that page's address problem one synapse above the place [[wiki/concepts/homeostatic-need-signal.md]] appeared to close it, and adds a consumer relationship no `δ` in the wiki has (`G120`: the learned predictor re-drives the channel that taught it).
- **[[wiki/concepts/broadcast-channel-decomposition.md]]** — supplies the measured content of a source that page names: the parabrachial nucleus appears there as the "aversive-outcome component" of the value channel and as a candidate salience source, and it is neither purely aversive (satiety, novelty) nor purely rectified (it is suppressed below baseline by appetitive anticipation), so the input to the dopamine channels is already a multiplexed scalar before the split.
- **[[wiki/concepts/affective-opponency.md]]** — an instance of that page's `punishment × Go` conflict quadrant with the origin *not* moved: the channel drives escape, scratching and sticker removal (active responses to negative valence) from the same line that drives freezing, so valence and action are separated by the downstream target rather than by re-signing the outcome. Its movable origin also predicts the neophobia result — under a prediction of danger, the familiar scores as safety — without predicting that novelty rides the danger channel itself.
- **[[wiki/concepts/epistemic-value.md]]** — the opposite sign on the same quantity: there novelty is an additive *reward* term that carries the whole effect wherever sensing does not alter the sensor; here first exposure to a novel food or object drives the danger channel and silencing it abolishes the avoidance, so the biological exploration drive looks like an annealing *penalty* on the unfamiliar rather than a bonus for it (`T358`).
- **[[wiki/entities/ventral-tegmental-area.md]]** — address by axon at the *next* stage: there two afferent nuclei select two near-disjoint dopamine channels, so which channel fires carries the address; here one relay does the reverse, collapsing several afferent modalities onto one population before the forebrain reads it. The two results bound where in the hierarchy addressing survives.
