# Valuation-System Decomposition (Pavlovian · Instrumental · Hedonic)

**One outcome supports at least four separately-stored valuations — a US-specific Pavlovian motivational value, a US-general "pure affect", an instrumental incentive value, and a hedonic value — held in different tissue, updated by different rules on different timescales, and separately removable. Behaviour is their joint product, so no measured choice, pursuit rate or consumption reads out "the value of the outcome": each assay reads a different one.**

> **Provenance.** Cardinal, Parkinson, Hall & Everitt 2002, *Emotion and motivation: the role of the amygdala, ventral striatum, and prefrontal cortex*, Neuroscience & Biobehavioral Reviews 26(3):321–352 (`raw/cardinal-2002-emotion-motivation-amygdala-ventral-striatum-pfc.md`). A review, no new data; every result below is cited there to its original. Load-bearing because it is the only source in the wiki that does the decomposition **from the assay side** — each valuation is individuated by a behavioural operation that isolates it, before any anatomy is assigned.

Why this earns a page. [[wiki/concepts/incentive-salience.md]] splits `r` into two quantities (hedonic impact, motivational gain) and reads both off one circuit. [[wiki/concepts/subjective-value.md]] treats value as one scalar on a common currency. This page says the count is higher than two and the split is not `value × gain`: the quantities sit in **different learning systems with different admissibility and different update rules**, which is a decomposition claim (`T359`), not a gain claim.

---

## The valuations, and the operation that isolates each

| Quantity | What it is | Isolating assay | Update rule | Substrate claimed |
|---|---|---|---|---|
| **CS → US(motivational)** | the current motivational value of the *specific* predicted outcome, retrievable by its cue | reinforcer devaluation after first-order conditioning; second-order conditioning (**disputed**, `T395`); conditioned reinforcement | tracks motivational state **directly**, with no relearning | basolateral amygdala ([[wiki/entities/amygdala.md]]) |
| **CS → affect** | a US-*general* value state ("pure" good/bad), carrying no outcome identity | **transreinforcer blocking** — a shock-paired CS blocks conditioning to a CS for omitted food, two reinforcers sharing nothing but aversiveness; and, on the rival reading, **second-order conditioning** (`T395`) | unknown; the source calls this representation "poorly understood" | unassigned; basal nucleus of the basolateral amygdala proposed (Gewirtz & Davis 2000) |
| **CS → US(sensory)** | the outcome's identity — appearance, taste, nutritive value — with no valence attached | **sensory preconditioning** (survives basolateral-amygdala lesion) | ordinary S–S association | perirhinal cortex (visual), gustatory/insular cortex (taste) |
| **CS → UR** | a sensorimotor link to a response, blind to the identity and current value of the outcome | a CR that survives devaluation and **cannot** support second-order conditioning | S–R | central nucleus of the amygdala; cerebellum for discrete skeletomotor CRs |
| **Instrumental incentive value** | the goal status of an outcome governing how hard an action is worked for | devaluation tested **in extinction** (Box 1) | **incentive learning** — changes only after the outcome is re-experienced | orbitofrontal cortex; retrieval via insular cortex |
| **Hedonic value** | the affective reaction to consumption | orofacial taste reactivity | changes **immediately** on the devaluing event | accumbens / ventral-pallidal hotspots ([[wiki/concepts/incentive-salience.md]]) |

Plus two non-valuation instrumental representations that gate how the above are used: the **action–outcome contingency** `P(o|a) − P(o|¬a)` (prelimbic cortex), and the **discriminative stimulus** `S^D`, which signals *which* response–reinforcer contingency is currently in force — a conditional, not a predictive, relation.

---

## The delayed write: incentive learning

The sharpest single result, and the one a builder can copy directly. Devalue a food by pairing it with lithium chloride; the animal will now reject the food. It nevertheless keeps working for it at the control rate until it has **eaten the devalued food once**.

| Stage | Control | | Devalued | Change in the devalued group |
|---|---|---|---|---|
| Training | `L → food` | | `L → food` | |
| Devaluation | food | | `food → LiCl` | **hedonic** value written |
| Test 1 (extinction) | `L` | `=` | `L` | — instrumental value **not yet written** |
| Re-exposure | food | | food | **incentive learning** |
| Test 2 (extinction) | `L` | `>` | `L` | instrumental value written |

(Balleine & Dickinson, as tabulated by the source. The same protocol run with a motivational-state shift — train hungry, test sated — gives the same result: responding stays at the hungry rate until the animal experiences the food while sated.)

**What this denies an architecture.** The instrumental value store **cannot be updated by inference**. The agent knows the outcome is now bad (it rejects it) and knows the action produces it (the contingency is intact), and still does not revise the action's worth. That is a cache with no invalidation-on-write: it invalidates only on **re-visit**, and the re-visit must be a first-person sample, not a simulated one. Every model-based agent in the wiki does the opposite — [[wiki/concepts/simulation-based-planning.md]] recomputes the action's value from the updated outcome value the moment either changes, and would pass Test 1 that animals fail.

**(brainstorm)** Read charitably this is not a bug but a **staleness policy on a learned value function**: an outcome's worth is a function of a body state the agent cannot introspect accurately, so the only trustworthy estimate is a fresh measurement, and the system refuses to propagate a predicted hedonic change into a stored incentive value. That is a falsifiable design: an agent whose value revisions require a sampled outcome is slower but immune to a class of error that a fully-inferential agent is exposed to — hallucinated revaluation, where an incorrect world model rewrites a good policy with no experience contradicting it. Nothing in the wiki tests the trade-off.

---

## The Pavlovian–instrumental interface

The nucleus accumbens (Acb) is not where goals live. Its lesion leaves goal-directed action intact by both of Dickinson & Balleine's criteria — sensitivity to contingency degradation **and** to outcome devaluation (Balleine & Killcross), and dopamine-receptor antagonists likewise leave instrumental incentive value alone. What the Acb carries is the **Pavlovian influence on instrumental behaviour**.

| Phenomenon | What it is | Requires | Does not require |
|---|---|---|---|
| Autoshaping / conditioned approach | approach to a CS that predicts food delivered elsewhere — a Pavlovian CR, not instrumental | AcbC, its dopamine innervation, CeA, anterior cingulate cortex (disconnection lesion abolishes it) | basolateral amygdala, mPFC, subiculum |
| Conditioned reinforcement (CRf) | working on a lever that delivers only the CS | basolateral amygdala (probably via orbitofrontal cortex) | AcbC, AcbSh, accumbens dopamine |
| **Amphetamine potentiation of CRf** | the same, with intra-accumbens dopamine agonist | AcbSh + accumbens dopamine (magnitude), AcbC (response selectivity), CeA, basolateral amygdala (specificity) | — |
| Pavlovian–instrumental transfer (PIT) | a non-contingent CS raises the rate of an unrelated instrumental response | AcbC, accumbens dopamine, CeA | basolateral amygdala (for the *general* form; specificity is lost without it) |
| Tolerance of delayed reward | choosing large-late over small-now | AcbC (lesion ⇒ impulsive choice), orbitofrontal cortex | anterior cingulate, mPFC |
| Unconditioned motivational impact | feeding driven by primary need; locomotion | AcbSh (and its lateral-hypothalamic interaction) | — |

**The factorization is content × gain, and the two arrive on different wires.** Glutamatergic afferents (basolateral amygdala → Acb for CRf specificity; anterior cingulate → AcbC for autoshaping) carry *which* cue and *which* response; the mesolimbic dopamine innervation, itself under central-amygdala control via the ventral tegmental area, sets *how much*. Dopamine measurements split along the same line: conditioned stimuli raise dopamine in the **core**, unconditioned stimuli (appetitive *and* aversive) in the **shell**.

**Two forms of PIT, and only one is a value.**

| Form | Effect | Condition |
|---|---|---|
| **General** (conditioned motivation) | a sucrose CS raises lever-pressing for *dry pellets* too | requires the predicted outcome to be relevant to the **current** motivational state — Pavlovian value tracks state directly, instrumental incentive value does not |
| **Outcome-specific** | the CS potentiates the action that shares its outcome, selectively | requires the US-specific representation; lost with basolateral-amygdala damage |

---

## What a builder takes

| Finding | Consequence |
|---|---|
| Four valuations of one outcome, individuated by assay before any anatomy | An agent with one `r` has not simplified the biology — it has chosen one of four quantities and thrown away the other three, and which one it chose depends on which assay its training signal was fitted to (`G118`) |
| Instrumental incentive value updates only on re-experience | A value cache invalidated by re-visit, not by inference. Free to build, never built here, and it changes what devaluation tests measure |
| The assay that individuates the S–R channel is devaluation-survival | So the `CS → UR` row above is defined by what it *lacks*, and at least three other processes produce the same survival — including a cue-bound motivational gain the devaluation never touched (`G121`). The row is an assay result, not an identified mechanism |
| Pavlovian value tracks motivational state directly; instrumental incentive value does not | The two differ in *when* state enters — at retrieval versus at the last sampled update. A satiety manipulation therefore moves them apart with no intervening learning |
| Goal-directed action survives accumbens lesion and dopamine blockade | Whatever the mesolimbic 'wanting' gain multiplies, it is **not** the instrumental action values (`T359`). An architecture that scales one set of `Q` values by a state gain has merged two systems the biology separates |
| The Pavlovian channel's content and its gain arrive on separate afferents | Two inputs to one node, one selective and one amplifying — the cleanest biological instance of a learned representation whose influence is set by a signal it does not itself carry |
| Some responses cannot be brought under instrumental control at all | Chicks in a looking-glass runway never learn to run *away* from food to obtain it; rats cannot learn to withhold approach to a CS in order to be rewarded; rodents are near-impossible to train to scratch for reward. A response-side admissibility restriction (`G119`) |
| The anterior cingulate's deficit appears only with **multiple** CSs | Lesioned rats do simple conditioned approach, conditioned reinforcement, conditioned freezing and PIT normally, and fail autoshaping and every multi-CS task — so the function is *disambiguating similar cues by their differential reinforcement*, preventing generalization, not conditioning as such |

---

## Open problems

- **How central states of "affect" relate to the values governing instrumental action is unstated by the source** — the CS→affect representation has an assay (transreinforcer blocking) and no substrate and no update rule. [[wiki/concepts/higher-order-conditioning.md]] offers a second assay and a candidate substrate for it, at the price of taking second-order conditioning away from the row above (`T395`), and still supplies no update rule.
- **Conditioned reinforcement has no clean psychological decomposition.** A stimulus paired with reward becomes something an animal will work for; whether it acquires instrumental incentive value, acts through PIT, or both, is undetermined — and it is the mechanism by which an agent pursues distant goals, so the wiki's subgoal rows inherit the ambiguity.
- **'Liking' still has no consumer.** This source adds that it is also the *writer* of instrumental incentive value, through incentive learning — the first stated computational role for a hedonic quantity in the wiki, and it is a write-port on another module rather than a term in any objective.
- **Nothing says how learning is coordinated across these systems.** The source's own closing concession: performance depends on many representations, learning theory assumes one limited-capacity learner, and either a complex associative rule is embedded consistently in every tissue or some unknown central mechanism regulates distributed learning. The wiki's architectures all assume the former without stating it.
- **The count is a lower bound and the list is not orthogonal.** Pavlovian US-specific value and instrumental incentive value are dissociated pharmacologically and by lesion, but nobody has shown they are not one representation read by two consumers.

---

## Connections

- **[[wiki/entities/amygdala.md]]** — the structure that holds two of these valuations and splits them by *format rather than valence*: the basolateral nucleus retrieves the specific outcome's current value (appetitive and aversive alike), the central nucleus holds outcome-blind sensorimotor links, and the double dissociation between them is the anatomical form of this page's assay-level split.
- **[[wiki/concepts/incentive-salience.md]]** — the two-quantity version of this decomposition, and the disagreement over what the second quantity is: 'wanting' is a multiplier on one learned association, this page's evidence makes the motivational term a **separate Pavlovian valuation system** whose ablation leaves instrumental incentive value untouched (`T359`). Both agree the hedonic quantity is generated apart; only this page gives it a job (writing instrumental value during incentive learning). **The one place the two literatures run the same experiment they get opposite answers, and the difference is which valuation is read out:** this page's *incentive learning* says a devalued outcome must be re-experienced before instrumental responding drops, while Zhang et al. 2009 report a cue whose motivational value reverses sign under a never-before-experienced sodium appetite **before the outcome is re-tasted at all** — so re-exposure is a requirement of the instrumental store and not of the Pavlovian one, and the same animal can hold a stale instrumental value and a freshly revalued cue at the same moment.
- **[[wiki/concepts/affective-opponency.md]]** — supplies the lesion data its quadrants need: basolateral-amygdala damage removes instrumental avoidance (`punishment × Go`) while sparing conditioned suppression (`punishment × No-Go`), central-nucleus damage does the reverse, and an appetitive analogue of the same task is reported — a partial four-cell design on the substrate rather than on a modulator (`G116`). It also supplies the instrumental counterpart of that page's *preparedness* prior: some responses are inadmissible to instrumental conditioning entirely.
- **[[wiki/concepts/simulation-based-planning.md]]** — the case this page's incentive-learning result rules out for biological instrumental value: the animal holds an updated outcome value and an intact action–outcome contingency and still does not recompute the action's worth until it samples the outcome, which is exactly the inference a planner performs for free.
- **[[wiki/concepts/reward-prediction-error.md]]** — constrains what a fitted `δ` can be an error *about*: choice, pursuit rate and consumption read out three different valuations here, so the identity of `r` in any model follows from the assay used to fit it rather than from the theory.
- **[[wiki/concepts/homeostatic-need-signal.md]]** — the same non-fungibility from the signal side: a need signal is a competent Pavlovian reinforcer and an incompetent instrumental one, where this page reports responses that are competent Pavlovian CRs and cannot be instrumentally conditioned at all (`G119`).
- **[[wiki/entities/basal-ganglia.md]]** — the ventral extension of that circuit given a specific job: the accumbens is not a site of Pavlovian association and not required for goal-directed action, but is required for Pavlovian cues to invigorate and direct instrumental responding, with core and shell splitting conditioned from unconditioned motivational impact.
- **[[wiki/entities/ventral-tegmental-area.md]]** — the source of the gain term in this page's content × gain factorization, and a proposed controller for it: the central amygdala has no direct accumbens projection but projects to the ventral tegmental area, which is the route by which a Pavlovian cue is claimed to set accumbens dopamine.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the two prefrontal write-ports this decomposition needs: prelimbic cortex for the action–outcome contingency (its lesion leaves performance intact and removes sensitivity to contingency degradation), and anterior cingulate cortex for disambiguating similar cues rather than for conditioning.
- **[[wiki/concepts/latent-graph-discovery.md]]** — denies that an edge carries one weight: the same transition holds a state-tracking Pavlovian value, a stale instrumental value refreshed only by traversal, and an identity-only sensory link, and which one a behavioural probe reads depends on whether the probe is a choice, a rate or a consumption.
- **[[wiki/concepts/expected-value-of-control.md]]** — the control-side version of the same boundary, and the reason its payoff term is under-specified: that theory cuts *monitoring* from *valuation* on the afferent side, reading value signals it does not compute — but this page says there is no single value to read, since one outcome carries at least four separately-stored valuations and which one reaches the control decision depends on the assay.
- **[[wiki/entities/subiculum.md]]** — resolves the "subiculum" term in this page's circuit tables into a specific tile: the ventral and proximal excitatory classes are the ones wired to nucleus accumbens, amygdala, bed nucleus of the stria terminalis and the hypothalamic–pituitary–adrenal axis, encoding reward history and task engagement and bidirectionally controlling approach (Kinman et al. 2026).
- **[[wiki/concepts/conditioned-reinforcement.md]]** — the behavioural decomposition this page's open problems ask for: four rival accounts of the conditioned-reinforcement assay (acquired value, marking, bridging, bare temporal proximity) separated by design, with value surviving and marking and bridging giving zero benefit where they were directly raced (Williams 1991b). It leaves this page's question untouched by construction — every assay there is a rate or a preference and neither individuates a valuation — and adds a warning about the assays themselves, since one manipulation can raise response rate and lower preference at once (Schuster 1969).
- **[[wiki/concepts/higher-order-conditioning.md]]** — contests this page's assay table at one row and fills its emptiest one. Second-order conditioning is listed here as isolating the *specific*-outcome Pavlovian valuation, but at `S2` the outcome is unreachable: US devaluation and inflation leave it untouched, conditioned-response topography does not track the reinforcer's identity, and `S1` extinction does not reduce it — so `S2` looks like the `CS → affect` row instead, which would give that row a second assay and a candidate substrate (basal nucleus, downstream of the lateral nucleus's `S1`/US convergence) (`T395`). The basolateral-lesion result this page relies on is recoverable either way, because a lesion of the complex removes both serially arranged stages.
- **[[wiki/concepts/effort-based-decision-making.md]]** — this page's "which valuation does the assay read" problem restated on the cost side: neuroeconomics separates **decision** values (include effort costs, computed at choice) from **outcome** values (do not), with fMRI placing both in orbitofrontal cortex but decision values only in ventral striatum — and a cognitive-effort study nonetheless finds effort-discounted ventral-striatal value at **reward-cue delivery, after expenditure**. So either outcome values are effort-sensitive or the ventral striatum carries decision values at an outcome-locked time, and no valuation procedure for cognitive effort has yet been run to separate them (Westbrook & Braver 2015).
- **[[wiki/concepts/sign-tracking-and-goal-tracking.md]]** — cuts this page's Pavlovian system in two: one contingency produces two conditioned responses at matched acquisition rates, and a dopamine receptor antagonist during training blocks learning of only the cue-directed one — so the Pavlovian side is not a single valuation opposed to the instrumental one but itself decomposable, and the assay that shows it is the same conditioned-reinforcement test this page already lists (`T359`, `T404`).
