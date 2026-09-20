# Conditioned Reinforcement — Manufacturing a Reinforcer Out of a Predictor

**A stimulus paired with a primary reinforcer acquires *conditioned value* — it will be worked for in its own right, sustains long behavioural chains with no primary reward present, substitutes partially for primary reward at a measurable exchange rate, and can outcompete the primary reward that created it. This is the only mechanism in the wiki that manufactures a want the environment never paid for, out of nothing but a pairing.**

> **Provenance.** Williams 1994, *Conditioned reinforcement: neglected or outmoded explanatory construct?*, Psychonomic Bulletin & Review 1(4):457–475 (`raw/williams-1994-conditioned-reinforcement-neglected-or-outmoded.md`; `LOSSY` — PDF converted by `tools/pdf2md.sh`, originals in `raw/originals/`). A review defending the construct against two decades of eliminativist attack, plus two new rat experiments (`n` = 23 at a 30-s delay; `n` = 60 at a 60-s delay). Every other result below is cited there to its original.

Why this earns a page. [[wiki/concepts/valuation-system-decomposition.md]] lists conditioned reinforcement as an assay and then records, in its own open problems, that *"conditioned reinforcement has no clean psychological decomposition"*. This source supplies the decomposition **from the behavioural side** — four rival mechanisms, each with a design that isolates it — and reports which ones survive. It is also the empirical half of what [[wiki/concepts/pseudo-reward-prediction-error.md]] assumes: that a self-set intermediate target can be made worth pursuing. Here the intermediate target's worth is *measured*, and it has dynamics the machine version does not (`G125`).

---

## Four mechanisms by which a contingent stimulus can control behaviour

The dispute was never whether contingent stimuli work. It was whether they work by having acquired value.

| Mechanism | Claim | What it needs the stimulus to be | Proponent |
|---|---|---|---|
| **Conditioned value** | the stimulus became a reinforcer; delivering it *is* payment | paired with the primary reinforcer | Hull, Skinner, Keller & Schoenfeld; Williams |
| **Marking** | the stimulus perceptually isolates the response, keeping it addressable in memory when the delayed outcome arrives | salient; **pairing irrelevant** | Lieberman et al. 1979, 1985 |
| **Bridging** | the stimulus spans the response–reward gap and carries the association across it | continuously present across the delay | Rescorla 1982 |
| **Discriminative / temporal proximity** | the stimulus only reports how far you are from food; behaviour is set by molar response–reward relations and needs no sub-goals at all | correlated with time-to-reward | Staddon 1983; Fantino's "conditioned confusion"; Baum 1973; Rachlin 1976 |

The last is the eliminativist position and is the one that matters architecturally: it says an agent traversing a chain needs **no intermediate reinforcer**, only a distance estimate. Every result below is an attempt to force a choice between it and conditioned value.

---

## The dissociating designs

| Design | Manipulation | Result | What it rules out |
|---|---|---|---|
| Royalty, Williams & Fantino 1987 — three-link chain, VI-33 s per link | insert an unsignalled 3-s delay between a response and **onset of the next link's stimulus**, shortening the schedule so the response→food relation is unchanged | response rate in *that link only* falls 75–80% (initial) / 60–70% (middle); adjacent links untouched | the temporal-proximity account: the response→**stimulus** contingency is load-bearing independently of response→food |
| Williams & Dunn 1991a — concurrent chains, **same** terminal stimulus on both sides | superimpose extra *extinction* presentations of the food-paired stimulus, 80% to one alternative, 20% to the other | all subjects prefer the alternative with **more** non-food stimulus presentations | Rachlin's two-hotels intuition; the stimulus is *wanted*, not merely informative |
| Schuster 1969 — the contrary result, kept | brief food-paired stimulus on FR-11 inside one terminal link | terminal-link **rate up**, initial-link **preference down** | that rate is a value read-out — two assays of one manipulation dissociate in sign |
| Williams & Dunn 1991b — repeated reversal learning, 5-s delay, tone in the delay | present the tone on *non-reinforced correct* trials | tone-alone worth **0.7** of a tone+food at 50% food, **0.4** at 30% food; worth **0** if the tone is never itself paired with food | that substitution is a stimulus property — it is an exchange rate set by the tone's own pairing probability |
| Cronin 1980 — 60-s-delay simultaneous discrimination, **reversed cue** | put the food-paired houselight colour immediately after the **S−** choice, the other colour immediately before food | pigeons choose the S− on ~**90%** of trials, stably | that conditioned value is a weak auxiliary — it beat the primary reward outright |
| Williams 1991b — reversal learning, five delay-interval conditions | marking (1-s tone after **both** S+ and S−) and bridging (continuous tone after both) vs. conditioned reinforcement (tone after S+ only) | CR conditions cut trials-to-criterion by ~**80%**; marking and bridging give **zero** benefit over no signal | marking and bridging as explanations *of this effect* |
| Williams 1994 Exp. 1 — naive rats, 30-s delay, leverpress acquisition | signal during first 5 s only (marking) vs. first 5 s **and** last 5 s (marking + pairing) vs. none | paired > onset-only > none; onset-only still beats none | marking as *sufficient*; it is real and it is not the whole effect |
| Williams 1994 Exp. 2 — naive rats, 60-s delay | continuous signal (bridging) vs. **beginning-and-end** with the middle deleted vs. none | **B&E > continuous > none** — a bridge with a missing middle works *better* | bridging outright: the association is not helped by a continuous linkage |

**The one large caveat, and it is the source's own.** In both new experiments the advantage of pairing **disappears at asymptote** — after ~10 sessions the B-only and B&E groups, and the continuous and B&E groups, are indistinguishable. Conditioned value is demonstrated as a determinant of **acquisition rate**, not of steady-state maintenance. A builder reading this for a subgoal mechanism gets a learning-speed argument and not a performance argument, and the wiki has no source that closes the gap between the two.

Exp. 2's ordering also yields the quantity that explains it: value tracks **reinforcement rate per unit of stimulus time**, which the deleted middle raises. Signal duration itself is not the variable — collapsing 2/2, 5/5 and 10/10-s B&E variants produced no reliable difference.

---

## What sets conditioned value

Conditioned value follows the laws of Pavlovian conditioning, so the determinant is **predictiveness**, not pairing count. Four consequences, each with a machine analogue that does not exist.

### 1. Frequency and value trade off, inherently

Every delivery of a conditioned reinforcer that is not followed by the primary reward is **an extinction trial on the reinforcer itself**. Presenting it more often strengthens the behaviour it maintains *and* devalues it, with opposite sign and no theory saying which dominates — the source calls the resolution "an empirical issue, dependent upon the particular conditioning procedure". This is the single sharpest contrast with every internally-generated reward in the wiki, all of which are fixed functions immune to their own use (`G125`).

**It is worse than extinction, and the extra term has its own literature.** The second-order procedure — `S1` reinforced on every presentation *except* those accompanied by `S2` — is the **feature-negative discrimination**, the standard recipe for manufacturing a conditioned inhibitor (Gewirtz & Davis 2000, [[wiki/concepts/higher-order-conditioning.md]]). So an unbacked delivery does not merely fail to reinforce: it is a positive learning event for an antagonist, which grows slower than the excitation and ends up stronger, producing an **inverted U** in net response against training amount. Two consequences for this page. (i) The trade-off above is not "which of strengthening and devaluing dominates" but a sum of two separately-learned opposite-signed quantities, and it has a deliberate lever — partial reinforcement of `S1` during first-order training guts the inhibitor and spares the second-order excitation, because the subgoal's presence stops being the feature that predicts omission (`G126`). (ii) A manipulation that *lowers* measured conditioned reinforcement may have raised the inhibition, so every lesion and drug result in the substrate table below is ambiguous in direction unless the inhibitor was controlled — which none of them did.

### 2. Value is delay *reduction*, i.e. relative to the ambient rate

Delay-reduction theory (Fantino 1977): a stimulus's value is the fractional reduction in expected time-to-reinforcement its onset signals, relative to the situation's average time-to-reinforcement **computed without it**.

Fantino 1969, concurrent chains with terminal links fixed at VI 30 s vs. VI 90 s (a constant 3 : 1 rate ratio throughout):

| Initial link | Mean time to food | Delay reduction, VI-30 link | Delay reduction, VI-90 link | Predicted choice for VI-30 | Obtained |
|---|---|---|---|---|---|
| VI 600 s | 360 s | .92 | .75 | .55 | ≈ .55 |
| VI 120 s | 120 s | .75 | .25 | .75 | ≈ .75 |
| VI 40 s | 80 s | .63 | −.11 | 1.0 | ≈ 1.0 |

Prediction is each link's share of the summed delay reductions, e.g. `.92 / (.92 + .75)`. Two things a builder takes: preference swings from indifference to exclusivity **with the terminal links unchanged**, and a delay reduction can be **negative** — a stimulus whose onset predicts a longer-than-average wait is an aversive event. Every value function in the wiki is absolute; none is referred to a context baseline, and none can represent a state-signal with negative value for reporting *below-average news* rather than *bad news*. (Its assumptions coincide with scalar expectancy theory, Gibbon & Balsam 1981, arrived at independently; several findings sit outside it and the source calls it "a valuable first approximation", not a theory.)

### 3. The aggregator over future rewards is immediacy, not rate

Preference is predicted by the **sum of reciprocals of the delays to each individual reinforcer**, `Σ 1/t_i`, with no residual effect of reinforcement rate. Killeen 1968: choice between mixed-interval terminal links is fitted by the harmonic mean of the component intervals, not the arithmetic mean. Shull, Spear & Bryson 1981, with rate placed in direct opposition: one reinforcer at 30 s is preferred over **two** at 60 s and 90 s (`1/30 = .033 > 1/60 + 1/90 = .028`).

**This contradicts a wiki claim and gets no registry row, because which kernel a value function uses is an `L3` realization choice.** [[wiki/concepts/subjective-value.md]] reports a hyperbolic kernel `SV = A/(1 + kD)` with a finite subject-specific `k`, median `R² = .95`, fitted to human intertemporal choice and matched in tissue. `Σ 1/t_i` is that kernel in the `kD ≫ 1` limit *and* commits to summation across all rewards the stimulus predicts. The two positions: (A) one kernel with a fitted `k`, applied to each outcome and summed — human money-choice data; (B) pure reciprocal summation, `k` effectively infinite — pigeon seconds-scale schedule data. They are not reconcilable by rescaling, because at finite `k` the two-reinforcer option wins Shull's comparison and it loses. The honest reading is that the kernel's curvature is a function of the timescale and the reward type, and neither source samples the other's regime. What survives for any builder is the weaker claim both support: **the aggregator is not exponential.**

The controlling delay is measured **from stimulus onset, not from the response** (Dunn, Williams & Royalty 1987 — varying the stimulus's food correlation while holding response–reinforcer delays constant moves preference). Mazur 1991 needs the harmonic mean computed over *accumulated stimulus time since the last reinforcer in that stimulus*, surviving interruption by the intertrial interval, the choice phase and exposure to the alternative — an integrator with a per-stimulus register and no reset on task interruption, which nothing here has.

### 4. Each extra link in a chain attenuates value, by an amount nobody can compute

Leung & Winton 1988: two concurrent-chains terminal links of identical duration, one a single stimulus, one **segmented** into two. Preference goes to the unsegmented link; the effect is larger at FI 30 s than FI 15 s, and — the part with no account — depends strongly on **where the cut falls**, being much stronger for an early cut (2 s / 28 s of a 30-s interval) than a central or late one.

Qualitatively this is higher-order conditioning: the unsegmented stimulus is first-order, the segmented link's first stimulus is second-order and carries less value for the extra associative step. [[wiki/concepts/higher-order-conditioning.md]] supplies what the attenuation *is* — the second link is not a weakened copy of the first but a different association, formed at a different point in the circuit, carrying valence with the outcome's identity stripped (`T395`) — which explains a loss with each step without predicting its dependence on boundary location. The source's verdict is the useful one: *"no extant theory of conditioning provides a basis for understanding why the segmentation effect varies with the temporal location of segmentation"*, and *"we have little basic understanding of the quantitative properties of how conditioned value is transmitted across successive stimuli."* Opposite-signed segmentation effects are reported in other preparations (Gormezano & Kehoe 1982).

For the wiki this is the **price of a subgoal, measured and unexplained** — [[wiki/concepts/optimal-hierarchy-criterion.md]] scores a decomposition by model evidence and charges nothing for the extra level; here inserting one boundary into an interval measurably reduces what the interval is worth, by an amount that depends on where the boundary goes.

---

## The payload: conditioned reinforcers become autonomous subgoals

Behaviour maintained by conditioned reinforcement is **less sensitive to motivational change** than behaviour on primary reinforcement.

| Evidence | Result |
|---|---|
| Morgan 1974, reviewing "resistance to satiation" | operant behaviour persists under satiation while the animal refuses to consume the reinforcer once obtained |
| Rescorla 1977, complex maze run after satiation | choices degrade **near the goalbox first**; early-maze behaviour is still intact when late-maze behaviour has broken |
| Holland & Rescorla 1975, second-order conditioning | devaluing the US reduces responding to `S1` and leaves `S2` **unaffected** |
| Rescorla 1980, reviewing `S1` extinction | extinguishing `S1` usually leaves `S2` responding intact; the exception is autoshaping with *similar* `S1`/`S2` (Nairne & Rescorla 1981) |

**The architectural consequence.** A conditioned reinforcer, once written, runs detached from the primary reward that created it: devalue the primary, and the subgoal still pulls. Combined with Cronin 1980 — where the immediate conditioned reinforcer captured the policy *against* the true objective, 90% of trials — this is a want with no primary backing, empirically real, generated by pairing alone, and not removable by revaluing what it was built from. It is a mechanism for `G72`'s missing quantity and simultaneously a demonstration of why the credit-assignment worry behind `T367` is not hypothetical: an agent that pays itself for reaching a subgoal *will* prefer the subgoal to the goal if the subgoal's payment arrives sooner.

The smoking application the source uses as its stress test makes the same point clinically: nicotine replacement reduces withdrawal symptoms and barely touches craving, because the sensory properties of smoking acquired hedonic value of their own; mimicking them (inhaled dilute citric-acid aerosol) reduces craving comparably to a cigarette (Rose & Levin 1991).

---

## Two phenomena re-read as conditioned reinforcement

Both are cases where a "special" learning mechanism dissolves into pairing plus an operant contingency the procedure created without anyone noticing. `(tentative)` — these are the source's reinterpretations, argued not demonstrated.

**Autoshaping.** A keylight paired with food acquires conditioned value; approaching it increases sensory contact with it, so the procedure contains an implicit conditioned-reinforcement contingency on approach and contact. Pecking surviving the omission contingency then shows only that the immediate conditioned-reinforcement contingency outweighs the delayed primary one — not that operant contingencies are absent. Wessells 1974 supports it: imposing omission on *approach* (terminating the CS when the pigeon comes within a criterion distance) eliminated approach, where omission on pecking does not (conflicting result: Peden, Browne & Hearst 1977). Second-order autoshaping is the cleaner argument — a noise `S1` that elicits no pecking produces pecking to a keylight `S2` through `S2`–`S1` pairings with no food, and `S1` extinction does not touch it, so what transferred was *value*, not a response and not a mediated `S2`–food association. The rival stands (Jenkins & Moore 1973: the CR's form depends on the reinforcer's identity, which value transfer does not predict).

**Imprinting.** Hoffman & Ratner 1973: flickering light / rapid retinal illumination change is *innately* reinforcing for young birds; a moving object produces it; the object's specific features have no reinforcing property until paired with it and acquire one afterwards. The critical period is not a special window — it is the interval before maturation of fear-of-novelty makes the bird avoid new objects and so blocks the pairing. Birds prevented from escaping imprint well outside it. The claimed generalisation is that primate socialisation is the same process over a different set of innate reinforcers.

**What a builder takes from the pair (brainstorm):** a small hard-wired set of innately reinforcing *perceptual events* plus conditioned reinforcement is enough to bootstrap a value system over arbitrary content, with the "critical period" an emergent consequence of a second developmental process gating exposure rather than a scheduled annealing. That is a cheaper origin story for a value function than anything in the wiki, and it predicts that the content of the innate set — not the learning rule — determines what an agent ends up wanting.

---

## Value transfer does not require awareness

Baeyens et al. 1990, 1992, human evaluative conditioning: neutral pictures followed by positively- or negatively-rated pictures shift in rated value toward the follower, and the shift is **independent of whether the subject was aware of the pairing sequence**. The same technique measurably moves consumer attitudes (Stuart, Shimp & Engle 1987).

This is the source's answer to Brewer 1974 (no conditioning in adult humans without contingency awareness) and, for the wiki, a constraint on where a value-transfer mechanism may sit: it cannot be a declarative inference over a stored event record, because it runs in subjects who cannot report the record. It is consistent with [[wiki/concepts/valuation-system-decomposition.md]]'s incentive-learning result from the other direction — there, a value the agent *can* state fails to propagate into a stored one; here, a value propagates into a stored one the agent cannot state.

---

## What a builder takes

| Finding | Consequence for an architecture |
|---|---|
| A predictor becomes a reinforcer through pairing alone | The wiki's cheapest mechanism for manufacturing a target the environment never rewards — and the only one that derives the new target's *value* rather than assuming it (`G72`) |
| Substitution rate is measured: 0.7 at 50% pairing, 0.4 at 30%, 0 at 0% | Supplies the `r̃` : `r` ratio `G33` flags as set "by fiat" in every hierarchical learner. It is not a hyperparameter — it is the conditioned reinforcer's own pairing probability, and it is *learned* |
| Every unbacked delivery of a conditioned reinforcer extinguishes it | No internally-generated reward in the wiki has this. A pseudo-reward, an eigenpurpose or a relabelled hindsight reward can be farmed indefinitely at no cost to its value (`G125`) |
| Value is fractional delay *reduction* against the context's average, and can be negative | Value functions here are absolute. A context-relative value makes the same stimulus worth different amounts in a rich and a lean environment with no relearning — which is also a normalisation an absolute critic cannot express |
| Aggregation is `Σ 1/t_i` over predicted reinforcers, not exponential | Whatever the correct kernel, the aggregator is not `γ^t`; and both the pigeon and the human data agree on that much |
| The delay that matters runs from **stimulus onset**, not from the response | The value of an option is a property of its *entry state*, not of the action that selected it — which is what the options formalism already assumes and never justified empirically |
| Inserting one segmentation boundary lowers the interval's value, by an amount depending on where it falls | A quantitative, unexplained cost per hierarchy level. Nothing in the wiki charges for a level at all |
| Behaviour on conditioned reinforcement resists devaluation of the primary | Subgoals become autonomous. An agent whose objective is revalued does not thereby revalue the subgoals it built under the old one — the silent-failure shape of `G118` moved up a level |
| The cue-bound subgoal beat the true objective 90% of the time (Cronin 1980) | The "agent pays itself" failure of hierarchical RL is an observed animal behaviour, not only a theoretical worry (`T367`) |
| Two assays of one manipulation dissociate in sign (rate up, preference down — Schuster 1969) | Rate of responding is not a value read-out. Any wiki claim of the form "the model prefers X" that rests on a frequency statistic inherits this (`G116`, `G121`) |
| Marking is real and orthogonal to value | A credit-assignment mechanism with no value content: a salient event that makes a past action addressable at outcome time. That is an eligibility-trace *tag* placed by salience rather than by recency, and nothing here has one |

## Open problems

- **Why does the pairing advantage vanish at asymptote?** Conditioned value speeds acquisition and then stops mattering. Either the steady-state behaviour is maintained by something else, or the signal at delay onset comes to be directly associated with food across the gap (the source's own suggestion, and it has no evidence either way). A builder cannot tell from this literature whether a conditioned reinforcer is a *bootstrapping* device to be annealed away or a permanent part of the value system.
- **Nothing predicts which of frequency and value wins.** The trade-off is stated and left to be settled per procedure.
- **The quantitative law of value transmission across successive stimuli is unknown**, including the sign, which reverses across preparations.
- **How a subject integrates accumulated stimulus time across interruptions** (Mazur 1991) is called a puzzle by the source and remains one.
- **The psychological decomposition is still open**, as [[wiki/concepts/valuation-system-decomposition.md]] states: whether conditioned value is instrumental incentive value, Pavlovian–instrumental transfer, or both is undetermined by every experiment here, because all of them read behaviour and none dissociates the valuation systems.
- **Marking has no mechanism.** "Perceptually isolates the response, making it more salient in memory" is a description of an effect.

---

## Connections

- **[[wiki/concepts/valuation-system-decomposition.md]]** — supplies the behavioural decomposition that page's open problems ask for, and inherits that page's residual ambiguity: four rival mechanisms are separated here by design (value beats marking, bridging and temporal proximity), but *which valuation system* holds the conditioned value is untouched, because every assay here is a rate or a preference and neither individuates a valuation.
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — the measured error against a subgoal value, to this page's measured *value* of the subgoal: there `r̃ = 1` by fiat and never changes, here the intermediate target's worth is set by its own pairing probability and is extinguished by every delivery the primary does not back, so the two pages describe the same signal with incompatible dynamics (`G125`).
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the empirical price list for that formalism: a chain link's stimulus-onset contingency is independently load-bearing (Royalty et al. 1987), option value attaches to the *entry state* rather than to the selecting action, and inserting one option boundary into an interval measurably lowers what the interval is worth.
- **[[wiki/concepts/subjective-value.md]]** — the same question asked of a different species at a different timescale, with an incompatible answer: hyperbolic with a finite fitted `k` in human money choice, pure reciprocal summation `Σ 1/t_i` in pigeon schedule choice, where at finite `k` Shull et al.'s two-reinforcer option would have been preferred and was not. No registry row — the kernel is an `L3` choice — but the shared negative claim is that the aggregator is not exponential.
- **[[wiki/concepts/multi-horizon-value-learning.md]]** — the machine construction that could carry both kernels at once: `d(t) = ∫₀¹ w(γ)γᵗ dγ` recovers hyperbolic discounting as a weighted set of exponentials, so a single torso can hold the human and the pigeon aggregator as two settings of `w`; nobody has fitted `w` to schedule-choice data.
- **[[wiki/concepts/incentive-salience.md]]** — the neural half of this page's autonomous-subgoal result: a cue-bound motivational pull that survives devaluation of what created it, with a mechanism (`κ` at retrieval) that this behavioural literature has no access to; conversely this page supplies the *origin* of an arbitrary cue's pull, which `κ` multiplies but does not explain.
- **[[wiki/concepts/reward-prediction-error.md]]** — bounds what `δ` may be fitted to: the Schuster 1969 dissociation shows response rate and preference move in opposite directions under one manipulation, so an `r` fitted to a rate statistic and an `r` fitted to a choice statistic are not the same quantity.
- **[[wiki/concepts/hindsight-goal-relabelling.md]]** — the other way to manufacture intermediate reward, and the contrast that makes `G125` sharp: a relabelled goal's reward is recomputed from a designer-given predicate and is unaffected by how often it is claimed, where a conditioned reinforcer devalues itself each time it is delivered without the primary following.
- **[[wiki/concepts/eigenoption-discovery.md]]** — supplies intrinsic rewards derived from graph structure with no primary reward consulted; this page supplies the rival origin, where the intermediate target's value is *inherited* from the primary reward by pairing and so cannot exist before one has been encountered. The two bracket the options: structure-derived and reward-derived subgoal value.
- **[[wiki/concepts/optimal-hierarchy-criterion.md]]** — charges nothing for adding a level; the segmentation result (Leung & Winton 1988) is a measured per-boundary cost whose dependence on boundary *location* no theory of conditioning explains, so any model-evidence score over decompositions is missing a term the behaviour clearly has.
- **[[wiki/concepts/curriculum-learning.md]]** — the imprinting re-reading as a curriculum mechanism: the "critical period" is not a schedule but the window before a second maturing process (fear of novelty) gates off the exposure the pairing needs, so a developmental stage boundary emerges from the interaction of two learners rather than from a clock.
- **[[wiki/concepts/latent-graph-discovery.md]]** — what the eliminativist position denied and this page restores: a node's value is not reducible to its distance from a terminal node, because the edge into it carries a separately-learned, separately-extinguishable weight that can be manipulated with distance held constant (Royalty et al. 1987) and can dominate the terminal signal outright (Cronin 1980).
- **[[wiki/entities/amygdala.md]]** — the structure the conditioned-reinforcement assay is assigned to (basolateral, via orbitofrontal cortex, and independent of accumbens dopamine); this page is the behavioural literature that assay comes from, including the frequency/value trade-off no anatomical result controls for.
- **[[wiki/concepts/higher-order-conditioning.md]]** — the same chain read for *content* rather than for worth, and the two compose into one account: this page measures that value attenuates per link and reports that no theory explains it, that page says the added link is a different association type entirely — `S2` is immune to US devaluation, to US inflation and to `S1` extinction, and drives a conditioned response whose form differs from `S1`'s — so what a subgoal inherits is sign and magnitude without outcome identity (`T395`). It also supplies the antagonist this page's extinction account is missing (`G126`) and the substrate depth claim (lateral nucleus for first-order, basal for second-order) that the conditioned-reinforcement lesion assay cannot resolve.
- **[[wiki/concepts/token-reinforcement.md]]** — the same manufactured reinforcer given an inventory and a redemption contingency, which changes two of this page's claims: the delay that controls choice is the delay to *exchange*, not to the conditioned reinforcer (a complete preference reversal with the token contingency untouched — Jackson & Hackenberg 1996), and unbacked delivery does not extinguish the currency to zero but to a floor (exchange extinction holds responding at 30–40% of baseline — Pietras & Hackenberg 2005). It also supplies the marking dissociation at very long delays: a token present across the gap sustains 1–24 h breakpoints where the same token deposited immediately sustains under 3 min (`G127`).
