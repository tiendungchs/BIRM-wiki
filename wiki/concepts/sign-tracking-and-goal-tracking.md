# Sign-Tracking and Goal-Tracking — One Contingency, Two Learners

**Given the identical Pavlovian pairing, some individuals learn to approach and work for the *cue*, others to approach the *place the reward will arrive*. The cue is an equally good **predictor** in both — same acquisition rate, same latency curve — but only in the first does it become an **incentive stimulus** that is approached, worked for, and pursued for its own sake. The two products of one contingency have different neurochemical signatures and different dopamine dependence: a dopamine receptor antagonist blocks *acquisition* of sign-tracking and leaves *acquisition* of goal-tracking intact. Individual differences are here a dissociation instrument, not noise.**

> **Provenance.** Flagel, Clark, Robinson, Mayo, Czuj, Willuhn, Akers, Clinton, Phillips & Akil 2011, *A selective role for dopamine in reward learning*, Nature 469(7328):53–57 (`raw/flagel-2011-selective-role-for-dopamine-in-reward-learning.md`). Rats: selectively bred high-responder (`bHR`) and low-responder (`bLR`) lines, generations S18–S22, plus commercially obtained outbred rats as replication. Three instruments on one paradigm — behaviour, fast-scan cyclic voltammetry (`FSCV`, 10 Hz) in the core of the nucleus accumbens, and systemic flupenthixol (a non-specific dopamine receptor antagonist).

---

## The paradigm, and why the design is the result

Lever-CS extends for 8 s → retracts → food-US delivered at a **separate location**. Nothing the animal does changes the outcome; the contingency is purely Pavlovian.

| Conditioned response | What the animal approaches during the CS | What the CS is |
|---|---|---|
| **Sign-tracking** | The lever-CS itself; goes to the food tray only at CS offset | A predictor **and** an incentive stimulus — attractive, and desired |
| **Goal-tracking** | The food tray, where nothing is yet available | A predictor only — an excitor evoking a CR, with no pull of its own |

**The methodological weapon: predictive strength is held constant and read off the behaviour.** `bHR` and `bLR` acquire their respective CRs *at the same rate* (phenotype × session interaction non-significant for contacts, `F₍₁,₂₃₆₎ = 3.02, P = 0.08`, and for latency, `F₍₁,₂₃₆₎ = 0.93, P = 0.34`; same null in the FSCV cohort, phenotype `F₍₁,₈₎ = 0.13, P = 0.73`). Pseudorandom CS/US presentation produces neither CR. So the CS is an equivalent predictor in both groups, and any group difference in dopamine or in dopamine-dependence cannot be a difference in how well the prediction was learned. **This is the manoeuvre that parses dopamine's role**, and it is transferable: to ask what a signal is *for*, find two populations matched on one product of learning and differing on another.

---

## Four measurements, and what each one denies

| Instrument | Sign-trackers (`bHR`) | Goal-trackers (`bLR`) | What it rules out |
|---|---|---|---|
| Approach | Lever contacts rise with session (`P ≤ 0.0001`) | Tray entries rise with session (`P ≤ 0.0001`) | That one group failed to learn |
| **Conditioned reinforcement** (nose-poke for brief lever-CS presentation, no food) | Active > inactive, and **above** the paired-control baseline; *more* than goal-trackers (phenotype × group `F₍₁,₃₃₎ = 4.82, P = 0.04`) | Active > inactive, but a weaker conditioned reinforcer | That "wanting" is all-or-none: both phenotypes manufacture a reinforcer out of a predictor, at different exchange rates |
| **CS-evoked accumbens dopamine** across 6 sessions | Rises (pairing × session `F₍₅,₃₅₎ = 4.58, P = 0.003`; trial-wise `r² = 0.14, P < 0.0001`) | **Flat** (`F₍₅,₃₅₎ = 0.94, P = 0.46`; `r² = 0.003, P = 0.54`); slopes differ, `P = 0.005` | That CS dopamine tracks the strength of the prediction — it does not, since the predictions are matched |
| **US-evoked accumbens dopamine** | **Falls** (session 6, `P = 0.002`); CS and US signals diverge (`F₍₅,₄₀₎ = 5.47, P = 0.0006`) | **Maintained** throughout (`F₍₅,₄₀₎ = 0.28, P = 0.92`) | That a prediction-error teaching signal was present in goal-trackers — by definition the error at a predicted reward must shrink, and it does not |
| **Flupenthixol during acquisition** (225 µg/kg, sessions 1–7), tested drug-free on session 8 | No sign-tracking CR on the drug-free test (`P ≤ 0.01` vs saline) — **learning blocked** | Full goal-tracking CR on the drug-free test (`P ≥ 0.6` vs saline; session 8 ≠ session 1 at `P ≤ 0.0002`) — **learning intact, only performance had been suppressed** | That intact dopamine transmission is a general requirement for stimulus-reward learning |

The drug arm carries the argument because it separates *performance* from *learning* with a single drug-free probe session: flupenthixol flattened both CRs while on board, and only the sign-tracking group failed to reveal a learned CR once it was off.

**Replication controls the obvious confound.** The same dopamine pattern appears in **outbred** rats sorted post hoc by CR (stimulus × session for sign-trackers `F₍₅,₅₀₎ = 4.43, P = 0.002`; for goal-trackers `F₍₅,₄₀₎ = 0.48, P = 0.72`), which have matched baseline locomotion and matched baseline reward-related dopamine release. So the signature is a property of *which CR the animal learned*, not of the breeding line, and basal dopaminergic tone does not predict it: **the mechanisms that set basal dopamine and those that set cue-evoked dopamine responsiveness are different.** Extended training (4 extra sessions) leaves the divergence stable, so it is not a transient of early acquisition.

---

## What this does to the prediction-error account

The source's own three-part negative claim, stated as constraints rather than as a refutation of temporal-difference learning:

1. **No dopamine prediction error is present in goal-trackers.** US-evoked release does not decline across training; a teaching signal on a reward that is becoming predicted must.
2. **CS-evoked dopamine does not index associative strength.** Both groups learned the association equally; only one group's CS signal grew.
3. **Learning a goal-tracking CR does not require dopamine.** Antagonism during acquisition costs nothing measurable once the drug is off.

Together: dopamine is **not a universal teaching signal for stimulus–reward learning**; it participates selectively in the attribution of incentive salience. The residual escape route the authors concede is anatomical — the recordings are in accumbens core only, so a prediction error in another terminal field is not excluded — but the *systemic* antagonist result blocks the general version of that escape, because a teaching signal the learning needs cannot be one that pharmacology can remove without cost.

**(brainstorm)** Read as architecture, this is a claim that the wiki's `δ` is the teaching signal of **one** learning system among at least two, and that the second system — the one that builds a predictive CS→US map and directs behaviour to the outcome's location — runs on a signal not yet identified anywhere in the wiki. A builder who trains every block on one broadcast scalar has, by this result, built only the sign-tracker.

---

## Individual differences as an architecture question

| Fact | Consequence for a builder |
|---|---|
| Two stable phenotypes under one contingency, present in outbred animals | The same training data and the same objective admit **two different learned solutions** that are behaviourally distinguishable and neurochemically distinguishable. A model class whose training run is reproducible up to seed cannot express this |
| The phenotype is predictable from an unrelated prior trait in the bred lines (locomotor response to novelty), but **not** in outbred rats | The trait that selects the solution is not the trait that is measured; selective breeding created a correlation that normal variation does not have. A caution for any claim that reads a learning style off a personality-like covariate |
| Sign-trackers show greater behavioural disinhibition and poorer impulse control | The cue-bound solution is the one that generalises badly to any task whose goal lies away from the cue — the failure mode is *architectural*, not a control lapse |
| Baseline dopamine and cue-evoked dopamine dissociate | Two parameters, not one: a tonic level and a *learned responsiveness profile*. Setting a global gain does not set what the gain will come to respond to |

---

## What a builder takes

| Finding | Consequence |
|---|---|
| A predictor and an incentive stimulus are separable products of one pairing | Two things are learned from a CS→US contingency, and an architecture with one association per pair cannot hold them apart (`G118`, `G119`) |
| One teaching signal is required for one product and not the other, in one task | The cleanest available instance of **non-fungible reinforcement**: the admissibility relation is between a signal and a *learning rule*, with the sensory situation, the reinforcer and the motor capacity all held constant (`G119`) |
| Conditioned reinforcement is present in **both** phenotypes, stronger in one | The manufactured want of [[wiki/concepts/conditioned-reinforcement.md]] is a graded quantity that co-varies with incentive attribution, not a separate faculty — so a "does the subgoal have value?" test is the wrong shape; the question is *how much*, per individual |
| Dopamine antagonism flattens performance of both CRs while blocking learning of only one | Any ablation read at the time of the manipulation measures performance; only a drug-free probe separates the two. The wiki's dopamine-lesion evidence is mostly the unseparated kind |
| Matching two groups on one learning product to test a signal's necessity for the other | A reusable ablation design for artificial agents: match two seeds/architectures on predictive accuracy, then remove a signal and see which downstream product dies |
| The cue-directed solution is the impulsive one | Where a cue becomes the target, the goal stops being the target. A pull toward a *predictor* is a documented way for a well-predicted world model to produce bad policies |

---

## Open problems

- **What teaches the goal-tracker?** The source shows dopamine is unnecessary for it and names no substitute. Nothing in the wiki supplies a second teaching signal for a Pavlovian CS→US map.
- **What selects the phenotype?** Not basal dopamine tone (outbred controls), not the novelty-response trait outside the bred lines. The variable that decides which of two solutions a learner converges to is unidentified.
- **Whether the two CRs are two systems or one system with two read-outs** — `T359`'s dispute, arriving here with the roles reversed: the dissociation is between two *Pavlovian* products, not between Pavlovian and instrumental.
- **The recording is one terminal field.** Prediction-error signals elsewhere in the dopamine projection are not excluded by the voltammetry, only by the systemic-antagonist arm, which is a weaker instrument for localisation.
- **No artificial agent has ever been shown to have two phenotypes on one task.** The result's most transferable content is a *behavioural* one the wiki cannot currently reproduce, and reproducing it would require the sources of variation in a training run to be treated as a design variable rather than a nuisance.
- **Conditioned reinforcement was measured once, in extinction, at one exchange rate.** Whether the goal-tracker's weaker conditioned reinforcer extinguishes faster — the dynamic [[wiki/concepts/conditioned-reinforcement.md]] says every manufactured want has — is untested.

---

## Connections

- **[[wiki/concepts/incentive-salience.md]]** — supplies the primary result that page's sign-/goal-tracker fork is cited to, and adds what a behavioural dissociation alone cannot: the gain's *acquisition* is dopamine-dependent while the co-acquired prediction is not, so the multiplier is not merely expressed through dopamine but **built** by it.
- **[[wiki/concepts/reward-prediction-error.md]]** — the sharpest necessity test on that page's reading 1: within one paradigm, an animal learns a CS→US association with no declining US-evoked dopamine and under receptor blockade, so `δ` is the teaching signal of one learning system rather than of learning as such (`T404`).
- **[[wiki/concepts/conditioned-reinforcement.md]]** — measures that page's manufactured want in two individuals trained identically: both work for the paired stimulus, the sign-tracker more, so the exchange rate that page treats as a property of the pairing is partly a property of the learner.
- **[[wiki/concepts/valuation-system-decomposition.md]]** — a second cut through that page's Pavlovian system, and one it does not have: two Pavlovian conditioned responses to one contingency with different dopamine dependence, which makes the Pavlovian side itself decomposable rather than a single valuation opposed to the instrumental one (`T359`).
- **[[wiki/concepts/information-sampling-vs-search.md]]** — the mechanism behind the sign-tracking evidence that page's `T360` position B leans on: value attached to the predictor itself is here shown to be dopamine-dependent and dissociable from predictive accuracy, so "approaching the cue" and "consulting the cue" are separately manipulable.
- **[[wiki/entities/ventral-tegmental-area.md]]** — the source of the accumbens-core signal measured here; this page is the functional-necessity complement to that page's anatomical addressing, and it constrains the partition: whatever the channels are, one of them is dispensable for a learning product that still gets learned.
- **[[wiki/entities/basal-ganglia.md]]** — the accumbens core is where both the recording and the proposed attribution site sit, and the dissociation says the structure's dopamine input is doing selective work rather than gating all reward learning through one relay.
- **[[wiki/concepts/broadcast-channel-decomposition.md]]** — an alternative reading of the same negative result: if the goal-tracker's teaching signal rides a dopamine population this electrode did not sample, the dissociation is address-by-axon rather than a second chemistry — a possibility the systemic-antagonist arm argues against but does not close.
- **[[wiki/concepts/higher-order-conditioning.md]]** — the same "pull without outcome identity" profile approached from the associative-structure side: there the cue's pull lacks an outcome representation by construction of the procedure, here it lacks one by phenotype, and both predict a target that is approached rather than a goal that is sought.
- **[[wiki/concepts/state-prediction-error.md]]** — the opposing necessity test on the same projection: here systemic receptor blockade during acquisition leaves the predictive cue–outcome map intact, there timed optogenetic suppression across a cue→cue transition abolishes the predictive link in a task with no value in it at all, so whether dopamine is required for predictive learning as such now has two measurements pointing opposite ways (`T404`).
