# Affective Opponency (Valence × Action)

**Valence is not the axis the modulators are opponent on. Reward/punishment and invigoration/inhibition are two axes, they are *architecturally coupled* rather than orthogonal (Go wired to reward, No-Go wired to punishment), and the coupling is repaired at run time by **moving the origin of the valence axis** — so "safety" is coded exactly like reward and "frustration" exactly like punishment.**

> **Provenance.** Boureau & Dayan 2010, *Opponency revisited: competition and cooperation between dopamine and serotonin*, Neuropsychopharmacology 36:74–97 (`raw/boureau-2010-opponency-dopamine-serotonin.md`). A review, no new data. Load-bearing because it is a **retraction by its own authors**: it withdraws the tonic assignment of Daw, Kakade & Dayan 2002 (the source of `T134` position B) and replaces one-axis opponency with a two-axis, movable-origin account. Companion paper in the same issue, arriving at the same two axes from vigour rather than from Pavlovian–instrumental conflict: Cools et al. 2010.

---

## The affect–effect plot

The affective circumplex with the arousal ordinate replaced by **action** (Go ↔ No-Go), the valence abscissa left alone.

| Quadrant | Valence × action | Pavlovian and instrumental responses | Status |
|---|---|---|---|
| **Upper right** | reward × Go | approach, engagement, consumption, appetitive Pavlovian-instrumental transfer, vigour | **congruent** — learning is easy; dopamine's uncomplicated territory |
| **Lower left** | punishment × No-Go | behavioural inhibition, conditioned suppression, freezing at distance | **congruent** — serotonin's least complicated association |
| **Upper left** | punishment × Go | active avoidance, escape, fight/flight, proximal defence (dorsolateral periaqueductal grey) | **conflict** — reached only by moving the origin *left* |
| **Lower right** | reward × No-Go | omission schedules, differential reinforcement of low rates, waiting for a larger later reward | **conflict** — reached only by moving the origin *right*, and the source says this shift is the harder of the two |

**The coupling is in the wiring, not in the task.** The direct pathway is Go + thalamocortical excitation + reward; the indirect pathway is No-Go + thalamocortical inhibition + punishment ([[wiki/entities/basal-ganglia.md]]). Phasic dopamine drives Go through D₁ (low affinity, needs large transients); tonic dopamine releases No-Go through D₂ (high affinity, reads the baseline). So an architecture that inherits this circuit cannot represent `punishment × Go` directly — it has to *re-sign the outcome*.

---

## The movable origin

| Shift | Trigger | Effect | Cost |
|---|---|---|---|
| origin → left | prediction of danger | a neutral outcome now scores positive ⇒ **safety is a reward**, energizing and reinforcing; two-factor avoidance falls out | `V` is no longer absolute — the same outcome has two signs depending on the context baseline |
| origin → right | prediction of reward | a neutral outcome now scores negative ⇒ **frustration/omission is a punishment**, and the dopamine dip below baseline is its error | the source flags this shift as "more complicated" — omission schedules and low-rate reinforcement are exactly where animals fail |

**The origin shift, measured on cells, and written by a stressor.** Shabel et al. 2019 ([[wiki/entities/lateral-habenula.md]]) image the same identified habenular neurons before and during intermittent tail shock. Before: reward-selective cells *decrease* to sucrose and *increase* to its omission. During: the sucrose response **inverts in sign** and the omission response gets **larger**, in the same cells, while nonselective cells are unchanged and the animals' licking bout duration halves with no change in inter-lick interval.

```
a'(outcome) = a(outcome) + c ,  c > 0        reward: negative → positive ;  omission: positive → larger
```

Three things this gives the page that it did not have. (i) The origin shift is a **physical write to an identified channel**, not an inference from choice behaviour — and a multiplicative gain cannot produce it, since scaling a non-negative gain never crosses zero and `κ<0` would invert *both* responses (`T362`). (ii) The trigger is a stressor unrelated to the task, not the threat *prediction* this page's leftward shift is derived from, so the register is writable by a controller outside the valuation loop. (iii) It shifts the **wrong way for the agent** and the failure mode is exactly what the page's guard-rail section predicts for an unbounded shift: every trial type now returns bad news, the outcome stops modulating the channel, and the behaviour is anhedonia — the agent keeps sensing and acting and stops pursuing, with nothing relearned. Whether the omission increase is really one offset or two separate modifications is `T369`.

**A rival mechanism for `punishment × Go`, and it does not move the origin.** Berridge & Robinson 2016 ([[wiki/concepts/incentive-salience.md]]) report that the same mesolimbic circuitry that generates incentive salience runs in a *different neurobiological mode* to generate an active-coping form of fear — percepts become attention-riveting with a threatening rather than an attractive aspect, calling out active coping (Richard & Berridge 2011). That reaches the upper-left quadrant without re-signing anything: no safety reward, no counterbalancing term, no bounded-magnitude guard rail. The two accounts are distinguishable — an origin shift makes the *outcome* score positive and should transfer to any reward-sensitive read-out, a mode switch changes only what the motivational circuit does with a cue — and it is further evidence for `G116`, since one circuit producing both desire and dread is an *effect* signal by construction.

**A third route to `punishment × Go`, and it re-signs nothing either.** Betley et al. 2015 ([[wiki/concepts/homeostatic-need-signal.md]]) report a negative-valence signal that *drives approach*: elevated AGRP neuron activity devalues a paired flavour and conditions place avoidance, and the same activity elicits eating and vigorous instrumental food-seeking within minutes. The quadrant is reached simply by the signal being a **need channel** — an internal variable whose level energizes and whose fall reinforces — with no origin shift and no mode switch. It also puts a limit on this page's valence×action coupling that neither rival does: the signal energizes an instrumental policy it demonstrably cannot *reinforce* (every attempt to train a lever-press that terminates the stimulation failed), so Go is driven without the reinforcement wire being present at all (`G119`).

**Why the left shift is the parsimonious design and not a kludge.** The set of actions that *continue* a punishment is enormous and must all be suppressed; the set that reaches safety is small and can be reinforced. Coding via safety converts an intractable suppression problem into an ordinary reward-maximisation problem. Its guard rail: the magnitude of the counterbalancing term must be bounded by the original, or the aggregate `punishment → cessation` becomes net appetitive and the agent seeks pain. The source notes animals are in fact **poor at this reweighting** (Pompilio et al. 2006; Clement et al. 2000).

**(brainstorm) This is a reference-point register, and no architecture in the wiki has one.** Every value function here is absolute: `V(s)` means the same thing in every context. The mechanism this page describes is a *context-set zero* against which the same outcome is scored positive or negative, with the set-point supplied by the current threat/reward prediction. That is one extra scalar per valuation module, it is what makes active avoidance learnable on a Go-biased substrate, and it makes the wiki's `T122`/`T85` firing disputes partly unfalsifiable as posed — a neuron reporting `r − origin` and a neuron reporting `r` differ only when the origin moves, and no recording protocol in the wiki's sources moves it deliberately (`G116`).

---

## Priors that buy out the sample complexity

The paper's framing argument: optimal control has three problems — computational complexity, sample complexity, and the fact that a single signed utility function does not fit neurons whose rates are non-negative. Pavlovian control is the third controller (beside model-based and model-free) and exists to answer the second: an animal that had to *learn* predator avoidance by repeated escape is dead. The priors are visible both in behaviour and in the architecture.

| Prior | Statement | Architectural expression |
|---|---|---|
| **Causality** | whatever preceded reward should be done more; whatever preceded punishment suppressed (law of effect) | the third-factor plasticity rule itself; overturned by experienced uncontrollability (learned helplessness) |
| **Engagement** | predicted reward availability should energize | tonic dopamine as an opportunity cost for time ⇒ vigour (Niv et al. 2007) |
| **Response type** | the *kind* of response is set by the predictor, not learned | species-typical defence; responses graded by defensive *distance*, not by threat magnitude |
| **Preparedness** | only some stimuli can support predictions about some outcomes | a constraint on the hypothesis class, absent from every model here |
| **Go/No-Go × valence** | distant punishment is avoided by inhibition, reward is gained by approach | the direct/indirect split above — the prior is *in the wiring* |
| **Threat pruning** | under substantial threat, downweight small rewards (unrealistic to accumulate past the punishment) | either a contrast enhancement on the reward signal, or punishment as a **motivational state** that flattens rewards irrelevant to escape — the two are dissociable and the experiment is unrun |
| **Value pruning** | stop evaluating a branch on encountering a large predicted punishment | serotonergic pruning of model-based search (Dayan & Huys 2008); makes normal evaluation *over-optimistic*, and depressive realism is what happens when the pruning fails |

**Threat pruning has a machine reading the source states and nobody has built:** flattening the spread of available option values is arithmetically identical to **raising the softmax temperature**, so "danger" and "explore more" are the same operation on the policy. Talmi et al. 2008 measured the appetitive-sensitivity drop under shock, which argues against a *generic* contrast enhancement — leaving the motivational-state reading live.

---

## Opponency has a free degree of freedom

Two systems with non-zero baselines representing one signed spectrum: the net value constrains only the **difference** of the two activations. The **sum** is unconstrained and available to carry a second quantity.

```
value   ∝  a_DA − a_5HT        (constrained by the outcome)
????    ∝  a_DA + a_5HT        (free — one whole extra channel, unused in every model here)
```

**(brainstorm)** The obvious candidates for the sum are the ones the wiki keeps needing and has nowhere to put: *salience* (the motivational-salience population fires to both valences), *precision* (`T122` position B), or the *magnitude of the origin shift* above. A two-population opponent code is therefore strictly more expressive than the signed scalar every architecture here uses, at the price of a second baseline that must be held stable.

**A rival arrangement that delivers the same two quantities, and it is not a sum.** Bromberg-Martin et al. 2010 ([[wiki/concepts/broadcast-channel-decomposition.md]]) make salience a *separate dopamine population* with its own inputs (central nucleus of the amygdala, proposed) and its own targets (accumbens core, dorsolateral prefrontal cortex) rather than a quantity recovered by adding two opponent activations. The two designs are cheap to tell apart and the wiki should not blur them:

| | **Sum of an opponent pair** (this page) | **Second population** (Bromberg-Martin et al.) |
|---|---|---|
| Wires | one pair, two quantities | two channels, one quantity each |
| Salience on reward *omission* | large — the difference goes negative, the sum need not | **zero** — the measured salience channel is silent when the event is absent, which a sum over two non-negative rates cannot generally reproduce |
| Failure mode | baseline drift in either population corrupts *both* value and salience | drift corrupts one quantity only |
| Targets | necessarily identical — one pair of wires reaches one place | independently routable |

The omission row is the discriminator and it currently favours the two-population account: a rectified, event-present magnitude is not a function of the opponent difference, so the information is not in the pair at all. That does not retire the free-sum observation — it says the free degree of freedom is real and is probably carrying something *other* than salience.

**A third arrangement, and it is the one with measured wiring.** Lammel et al. 2012 ([[wiki/entities/ventral-tegmental-area.md]]) find the opponency built as **feed-forward inhibition inside the source**: the lateral habenula excites its own dopamine channel (medial ventral tegmental area → medial prefrontal cortex, 100% connection probability) *and* drives GABAergic rostromedial tegmental nucleus cells that inhibit the rival channel (inhibitory postsynaptic currents in ~60% of accumbens-lateral-shell-projecting dopamine cells, 0% of medial-shell-projecting ones). So the subtraction is performed upstream, between two non-negative channels, and never appears as a signed rate anywhere:

```
head_+  ∝  a_LDT                       (reward channel, non-negative)
head_-  ∝  a_LHb                       (aversion channel, non-negative)
value   ∝  head_+ − head_-             (taken by wiring, not by a read-out)
????    ∝  head_+ + head_-             (still free)
```

This keeps the free-sum property while fixing the failure mode in the middle column of the table above — the two channels *are* independently routable, because the difference is taken at the source rather than at a shared target. It also supplies the anatomy for this page's `punishment × Go` problem from a different direction: aversion here is dopamine **release** on a second line whose target-receptor blockade abolishes the behaviour, so the upper-left quadrant is reached without moving any origin and without re-signing the outcome.

**A fourth arrangement, in which the pair is glutamatergic and the opponency is in the *plasticity*.** Namburi et al. 2015 ([[wiki/entities/amygdala.md]]) find the pair one synapse upstream of any modulator: two intermingled basolateral-amygdala populations, both glutamatergic, distinguished only by projection target, whose `AMPAR/NMDAR` ratios move in **opposite directions** after the same conditioning episode (accumbens projectors up after reward and down after fear; central-nucleus projectors the reverse), and whose photostimulation supports self-stimulation versus place avoidance respectively.

```
head_+  ∝  w_NAc · x         (accumbens projectors, non-negative)
head_-  ∝  w_CeM · x         (central-nucleus projectors, non-negative)
Δw_NAc  = +η·δ ,  Δw_CeM = −η·δ        (one event, one input x, opposite-signed learning)
```

Two things this adds that the three arrangements above do not have. First, **the address is the output wire and nothing else** — same transmitter, same afferent bundle, overlapping locations, near-identical transcriptomes — so building the pair costs a designer only two heads with separate consumers, not a second chemical or a second nucleus. Second, there is a measured **interaction**: photoinhibiting the negative channel during the unconditioned stimulus impairs fear learning *and enhances* reward learning, which neither a free-sum pair nor a feed-forward-inhibition pair predicts, since in both of those the channels are independent once the subtraction is taken. Whether this edge really is valence-dedicated, given a lesion literature that has it carrying appetitive conditioning too, is `T368`.

---

## The assignment, then and now

| Quantity | Daw, Kakade & Dayan 2002 (`T134` position B as the wiki records it) | Boureau & Dayan 2010 |
|---|---|---|
| phasic dopamine | reward prediction error | unchanged |
| phasic serotonin | punishment prediction error | still expected on opponency grounds; the direct evidence is thin — phasic nociceptive responses in dorsal-raphe serotonin neurons exist, but no invigoration-style tie to momentary inhibition |
| **tonic dopamine** | **average punishment** | **withdrawn** — average rate of reward *and of controllable punishment*, as an opportunity cost for the passage of time ⇒ vigour |
| **tonic serotonin** | **average reward** | **withdrawn** — average punishment, as an opportunity *benefit* for the passage of time ⇒ quiescence |

Three stated reasons for the withdrawal: the original account had no Pavlovian controller; it ignored the reward/punishment asymmetry (successful learning yields *repeated* reward but *avoided* punishment, so maintenance and extinction cannot be symmetric); and it is challenged by experiments that orthogonalize valence against action. The formal motivation for the old assignment — that in average-reward reinforcement learning the phasic error is antagonized by the long-run rate — survives, but the authors note the antagonism "could be realized in many other ways, for instance by a form of adaptation", so it no longer forces the chemical assignment.

**This changes `T134` in the wiki's favour on one side and costs the other.** Position B was stated here as *serotonin = predicted average reward*; one of B's authors now says serotonin reports average **punishment**. The sign flip removes B's straightforward-opponent property, which was B's main attraction, while leaving A (`γ`, the discount factor) untouched. The row stays `LIVE` because the discriminating experiment is still unrun.

---

## The opponency is hierarchical, not symmetric

| Direction | Evidence | Reading |
|---|---|---|
| serotonin → dopamine | extensive: raphe lesions raise accumbal dopamine turnover; 5-HT_2C tonically inhibits release; 5-HT_1A, 5-HT_2A, 5-HT_3, 5-HT_4 *stimulate* it; net excitatory influence on the ventral tegmental area | strong, and **not one-signed** |
| dopamine → serotonin | little data; unclear whether excitatory or inhibitory | consistent with a **hierarchy**: serotonin exerts its affective effects *by manipulating dopamine*, not in parallel with it |

**"Serotonin inhibits dopamine" is not a well-formed statement.** 5-HT_2A and 5-HT_2C are both constitutively active and exert *opposite* control over accumbal and striatal release; 5-HT_2C blockade raises impulsivity via one route and 5-HT_2A blockade lowers it via another; constitutive 5-HT_2C activity in medial prefrontal cortex *raises* accumbal dopamine after cocaine. The receptor complement is the address ([[wiki/concepts/neuromodulatory-metaparameters.md]] `T281`), and a scalar `5-HT → DA` gain in a model is choosing one receptor's behaviour and calling it the chemical's.

---

## A third opponency: engagement, and it is not dopamine's

Noradrenaline and serotonin, read as the *ergotropic* (toward work and energy expenditure) versus *trophotropic* (toward nourishment and replenishment) poles, the central analogue of sympathetic versus parasympathetic.

- Noradrenaline: arousal, exploration, active processing of salient and action-relevant stimuli.
- Serotonin: **disengagement from sensory stimuli** even with no threat and no reinforcing benefit of No-Go — latent inhibition (the stimulus predicted nothing), extinction (it no longer predicts), satiety, fatigue.
- The two inhibit each other while both controlling dopamine release.

This matters to a builder because it separates two things the wiki collapses: *not acting* (behavioural inhibition, the lower half of the action axis) and *not attending* (disengagement, dropping a stimulus from the input). Serotonin's satiety, latent-inhibition and extinction roles do not fit the aversive-congruence story at all and fit disengagement exactly.

---

## What a builder takes

| Finding | Consequence |
|---|---|
| Valence and action are coupled in the substrate | A gating architecture with a Go/No-Go split inherits a *prior*, not a neutral mechanism; `punishment × Go` needs the origin shift or it is unreachable |
| The origin of the valence axis moves | One extra scalar per valuation module (the context baseline); without it, active avoidance must be learned as a special case rather than falling out |
| Both congruent quadrants learn fast; both conflict quadrants learn slowly | A curriculum and a failure prediction, free: an agent with this prior should be measurably worse on `reward × No-Go` than on `reward × Go` at matched difficulty |
| Opponency leaves the sum free | A two-population code carries value *and* one more quantity on the same pair of wires |
| Any dopamine or serotonin manipulation confounds affect with effect | No result in the wiki's neuromodulator literature discriminates a valence signal from an action signal, because no cited task orthogonalizes them (`G116`) |
| Tonic and phasic are separately regulated and pharmacology moves the tonic level | Depletion, lesion and dietary manipulations are evidence about tonic levels; conclusions about *phasic* coding drawn from them are unlicensed, and autoreceptor feedback can invert the sign |

---

## Open problems

- **The free sum has no architectural competitor here, and the rival arrangement is unbuilt** (`G117`). This page's opponent pair leaves the sum available for a second quantity on *one* pair of wires; the midbrain evidence instead splits one event across two channels with disjoint targets and different sign conventions. No architecture in the wiki implements either, so the two arrangements have never been compared.
- **The `reward × No-Go` shift has no mechanism.** The left (safety) shift is derived; the right (frustration) shift is asserted and the behavioural evidence — omission schedules, negative automaintenance — is that it works badly.
- **Nothing here reaches the goal-directed controller.** The source's own stated lacuna: where the model-based system sits in the affect–effect plot "is unfortunately less clear", and the priors above are all Pavlovian or habitual. The one candidate bridge is serotonergic value-pruning of search.
- **Pavlovian evaluation may itself be model-based or model-free** (outcome-specific versus general Pavlovian-instrumental transfer) and nobody has separated them in aversive contexts.
- **The contrast-enhancement versus motivational-state readings of threat pruning are dissociable and unrun** — compare rewards irrelevant to safety (money) against rewards relevant to it (shock cessation) under threat.
- **The discounting account of serotonin (`T134` position A) is stated here as hard to integrate**, with the authors' only reconciliation being "a different function of a separate group of 5-HT neurons" — which is an appeal to topography, the same move that resolved the dopamine dispute.

---

## Connections

- **[[wiki/entities/basal-ganglia.md]]** — the circuit in which this page's central claim is a wiring fact rather than a hypothesis: direct/D₁/Go is soldered to reward and indirect/D₂/No-Go to punishment, with the affinity difference making phasic transients drive Go and the tonic level release No-Go, so the two conflict quadrants are architecturally denied and must be reached by re-signing the outcome.
- **[[wiki/concepts/reward-prediction-error.md]]** — supplies the quantity this page relativises: `δ` is computed against an origin this page makes movable, so the same outcome yields opposite-signed errors under threat and under reward expectation, and a recorded `δ` cannot be read as an absolute utility.
- **[[wiki/concepts/neuromodulatory-metaparameters.md]]** — the rival job description for the same two chemicals: there serotonin is `γ` (a metaparameter of the learning rule), here it is an opponent *signal* on the action axis with a withdrawn tonic assignment, and the receptor-level heterogeneity documented here is the concrete form of that page's `T281` objection to one-chemical-one-slot.
- **[[wiki/concepts/precision-weighting.md]]** — a candidate occupant for the free degree of freedom this page identifies: the *sum* of an opponent pair is unconstrained by value, and precision is exactly a non-negative second quantity that the difference-coded value cannot carry.
- **[[wiki/concepts/subjective-value.md]]** — the reference-point problem at the choice end: that page's values are absolute and idiosyncratically discounted, this page's are scored against a threat- or reward-set zero, and the two cannot both be what a valuation module computes.
- **[[wiki/concepts/policy-abstraction-hierarchy.md]]** — where vigour enters as a control variable rather than a policy: the average-rate opportunity cost sets *how fast* a selected action is performed, which is a dimension none of that page's loops represent.
- **[[wiki/concepts/cognitive-control.md]]** — threat pruning as a control output with a stated arithmetic: flattening the spread of option values under danger is the same operation as raising the softmax temperature, so "be careful" and "explore" are one knob and the controller cannot issue them independently.
- **[[wiki/concepts/simulation-based-planning.md]]** — the serotonergic pruning rule applied to rollout: stop expanding a branch on encountering a large predicted punishment, which bounds search cost and *biases* the surviving estimate upward — the search-control mechanism whose failure mode (depressive realism) is more accurate than its success.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the third-factor slot read at two timescales: this page separates the phasic error from the tonic average rate carried by the same chemical, so a rule consuming "dopamine" is consuming two signals whose pharmacological manipulations move mainly the second.
- **[[wiki/concepts/multi-horizon-value-learning.md]]** — the alternative home for the average-rate term: average-reward reinforcement learning antagonizes the phasic error with the long-run rate, and this page's authors concede the antagonism "could be realized in many other ways" — a bank of discount factors being one, which is why the withdrawal of the tonic assignment costs the chemistry and not the algebra.
- **[[wiki/concepts/incentive-salience.md]]** — a second route into this page's `punishment × Go` quadrant that leaves the valence origin alone: the 'wanting' circuit running in an aversive mode generates attention-riveting active coping directly, and its motivational multiplier is applied at the *cue* where this page's origin shift is applied to the *outcome*. **That page's own model contains this page's operator**, however: Zhang et al. 2009 keep an additive sub-type `r + log κ` beside their multiplicative gain for exactly the cases where valence reverses, and give the argument this page never states — an origin shift is required rather than a sign flip because it preserves the *rank order* of a graded family, so the once-most-attractive member stays the best of a bad lot. The two together are the positive affine group, and which one a given state change uses is `T362`.
- **[[wiki/entities/ventral-tegmental-area.md]]** — the third arrangement, with the wiring measured: one afferent excites its own dopamine channel and di-synaptically inhibits the rival channel, so the opponent subtraction happens in the source between two non-negative rates, the sum stays free, and the `punishment × Go` quadrant is reached by release on a second line rather than by moving the origin.
- **[[wiki/concepts/broadcast-channel-decomposition.md]]** — the rival arrangement for this page's free degree of freedom: salience as a separately-sourced, separately-routed dopamine population rather than as the unconstrained *sum* of an opponent pair, with reward-omission trials discriminating the two because the measured salience channel is silent there and a sum need not be.
- **[[wiki/concepts/homeostatic-need-signal.md]]** — a third route into this page's `punishment × Go` quadrant, and the movable origin measured on an internal variable: a need signal's level energizes approach while its elevation is negative valence, so the quadrant is reached by channel identity rather than by re-signing the outcome, and the same food is reinforcing or worthless depending on the current deficit rather than on a threat-set zero.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the priors as a restriction on the hypothesis space: preparedness, species-typical response types and the Go/No-Go × valence coupling are constraints on *which* edges an agent will entertain, bought at the cost of the edges it can never learn.
- **[[wiki/concepts/general-danger-channel.md]]** — this page's `punishment × Go` quadrant reached without moving the origin: one parabrachial population drives scratching, sticker removal and escape (negative valence with Go) from the same line that drives freezing (negative valence with No-Go), so valence and action are separated by which downstream target reads the scalar rather than by re-signing the outcome. It also supplies the danger *prediction* that this page's leftward origin shift is triggered by, and shows that prediction re-entering the primary aversive channel rather than only adjusting a baseline.
- **[[wiki/entities/amygdala.md]]** — a fourth arrangement of this page's opponent pair and the cheapest one: two intermingled glutamatergic populations addressed only by projection target, learning with opposite sign from one event, with suppression of the negative channel *improving* appetitive learning — an interaction no algebra on this page produces (`T368`). Also a substrate-side partial four-cell design for this page's plot: in one task basolateral-amygdala lesions remove instrumental avoidance (`punishment × Go`) while sparing conditioned suppression (`punishment × No-Go`) and central-nucleus lesions do the reverse, with an appetitive analogue reported — the quadrants are separable in tissue, by a lesion rather than by a modulator (`G116`).
- **[[wiki/concepts/valuation-system-decomposition.md]]** — the instrumental counterpart of this page's *preparedness* prior: some responses cannot be brought under an action–outcome contingency at all (chicks will not run away from food to reach it, rats will not withhold approach to a CS to be rewarded), so the constraint on the hypothesis class applies to responses as well as to stimulus–outcome pairs (`G119`).
- **[[wiki/entities/lateral-habenula.md]]** — this page's movable origin measured directly, plus two of its missing mechanisms. The origin: stress adds a constant to one identified population's outcome response, inverting the sign of the reward response while enlarging the omission response — the operator of this page's `punishment × Go` repair, running in the opposite direction and producing anhedonia (`T362`, `T369`). The mechanisms: a sign carried as the GABA/glutamate **ratio** at a single co-releasing pallidal terminal — so a signed error crosses one connection with non-negative quantities on both sides, and the ratio is itself slowly plastic (it tilts toward excitation under chronic stress and is normalized by selective serotonin reuptake inhibitors) — and a slow, glially-written burst gain that is a literal context baseline, whose elevation alone produces anhedonia and behavioural despair with no change in input.
