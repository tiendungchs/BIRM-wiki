# Expected Value of Control — the Cost Term Is Subtracted from the Control Signal, Not from the Outcome

**Deciding *whether, which and how much* control to deploy is itself a decision problem with its own value function: `EVC(signal, state) = Σ Pr(outcome | signal, state)·Value(outcome) − Cost(signal)`, maximised over candidate control signals — so the quantity that gates a capability is a net value carrying a disutility term attached to the *deployment*, not to the outcome.**

> **Provenance.** Shenhav, Botvinick & Cohen 2013, *The expected value of control: an integrative theory of anterior cingulate cortex function*, Neuron 79(2):217–240 (`raw/shenhav-2013-expected-value-of-control.md`). A theory review; no new data. Equations 1–3 are rendered as figure images in the clip and are reconstructed here from the paper's own prose definitions of each term.

Why this earns a page rather than a section on [[wiki/concepts/cognitive-control.md]]. That page answers *what a control state contains* and *how it acts* (a task model held as activity, broadcast as bias into a competition) — the **regulation** half. This page is the layer that decides whether that bias is emitted at all, and how strong it should be, on an explicit cost–benefit criterion. The two are separable in the theory by construction: dACC (dorsal Anterior Cingulate Cortex) is assigned **specification**, lateral prefrontal cortex is assigned **regulation**, and neither does the other's job.

---

## The three-way decomposition of control

| Function | Definition | Assigned to | The distinction it must not be confused with |
|---|---|---|---|
| **Regulation** | emitting the control signal so that it actually changes processing parameters (sensitivity, threshold, bias) downstream | lateral prefrontal cortex + basal ganglia, brainstem dopaminergic nuclei | — |
| **Specification** | *deciding* the control signal — its **identity** (which task) and its **intensity** (how vigorously) | dACC | not regulation: specification chooses, regulation implements |
| **Monitoring** | acquiring the state and outcome information the decision needs — conflict, errors, delays, negative feedback, pain, cues | dACC | not **valuation**: monitoring reads value signals, orbitofrontal / ventromedial prefrontal / insular cortex compute them |

Two cuts, one on each side of the decision: **monitoring ≠ valuation** on the afferent side, **specification ≠ regulation** on the efferent side. dACC gets the inner pair and neither outer one. This is the paper's architectural content; the equations are its formalisation.

**A control signal is a pair, not a scalar:** `signal = (identity, intensity)`. Identity names the task representation; intensity is both the literal activation of the task unit and the magnitude of its downstream effect. Most theories of dACC address one dimension or the other; the claim here is that they are two coordinates of one specification act.

---

## The equations

| # | Form | Reading |
|---|---|---|
| 1 | `EVC(signal, state) = Σ_outcomes Pr(outcome \| signal, state) · Value(outcome) − Cost(signal)` | expected payoff of deploying this control signal here, minus what deploying it costs |
| 2 | `Value(outcome) = ImmediateReward(outcome) + γ · max_i EVC(signal_i, outcome)` | value defined recursively through the *next* specification decision, so the criterion is a Bellman equation over control signals |
| 3 | `signal* = argmax_signal EVC(signal, state)` | specification is the `argmax`; `signal*` is held by the regulative system until monitoring says the state has moved |

`Cost(signal)` is a monotonic function of **intensity only** — identity is free, vigour is not. The authors flag the labour/leisure form (Kool & Botvinick 2012) as the richer alternative and do not commit to a functional form.

**The EVC term generalises a Q-value.** Equations 1–2 are `Q(s,a)` with the action slot occupied by a control signal and an action-dependent cost subtracted — which is the reason the same notation appears in the motor-control literature, and the reason the theory treats cognitive and motor control signals as undergoing the same optimisation.

**The optimum is interior.** Payoff rises with intensity (better performance) and cost rises with intensity; `EVC` is maximised where the slopes cancel. Under the paper's shape assumptions the optimum **rises with task incentive**, so predicted dACC activity grows with *both* difficulty and stakes — a dual dependence reported in one design (Kouneiher, Charron & Koechlin, as cited): dACC activity increased with trial difficulty **and** with the average stakes of the block, the latter regardless of whether a bonus was available on that particular trial.

---

## What the criterion buys: one class where the wiki keeps three

Control is needed exactly when the specified task is *less automatic* than the default behaviour in that circumstance — **default override**. The paper's move is to put three literatures in that one cell:

| Behaviour | The default being overridden | Why EVC predicts dACC |
|---|---|---|
| **Exploration** | exploitation of the known best option | sampling costs immediate reward for information about future reward; decisions to explore raise dACC in humans and monkeys |
| **Foraging** | staying with the current option set | switching carries a near-term cost for a higher-mean alternative; dACC tracks *alternative-minus-current* mean value and correlates with the decision to switch |
| **Intertemporal choice** | the immediacy bias | patient choice is the non-default one, and engages control machinery including dACC |

**(brainstorm)** This is the cheapest available unification of the wiki's epistemic quantities with its effort accounting. [[wiki/concepts/information-sampling-vs-search.md]] observes that a query's price and its expected information gain are never compared in the same units anywhere in that literature. Equation 1 is exactly that comparison written down: the information-seeking option's payoff enters through `Σ Pr·Value` (with the value of information folded into the recursive term), and its price enters through `Cost(signal)` in the same currency. What the equation does *not* supply is either function — neither a computable epistemic payoff nor a measured cost function — so it is a schema for the comparison rather than the comparison.

---

## Evidence marshalled, by which term it supports

| Term | Result | Reading |
|---|---|---|
| Monitoring (intensity) | conflict during processing indicates control is insufficient, earlier and more sensitively than explicit error feedback | conflict is *one* intensity cue among many (delays, errors, negative feedback, pain), not the function itself |
| Specification (identity) | overlapping dACC populations encode the **value** and the **direction/target** of a chosen saccade, and of a covert attention shift independent of any eye movement | value-selective *and* content-selective in one population — what `argmax` over `(identity, value)` requires |
| Specification is causal, not just read-out | macaque dACC theta-band local field potentials discriminate which stimulus–response rule will be used **before stimulus onset**; the selectivity is **absent before error trials**; microstimulation during response preparation speeds antisaccades without raising errors; rostral dACC lesions give the worst scores on a cross-task cognitive-control factor | anticipatory + lesion + stimulation, which is what separates specification from monitoring |
| Cost is registered | dACC response during a demanding task predicts *reduced* subsequent nucleus-accumbens response to monetary reward ("payment"); dACC is highest on trials the participant chooses to **forgo**; dACC engagement predicts which task is later avoided | effort discounting with the discount visible in a downstream reward signal |
| Cost is general | dACC also tracks physical effort and revises expected reward downward for it | `Cost` is not specific to cognitive control |

**Willingness to pay.** Because cost is monotonic in intensity, dACC output is readable two ways at once — as the specified intensity, or as the price licensed for it. Medial frontal damage then predicts apathy/abulia not as a loss of capability but as a collapsed willingness to pay.

---

## What a builder takes from this

| Finding | Consequence for an architecture |
|---|---|
| Control has its own value function | An agent that computes `Q(s,a)` over environment actions has no representation of *how hard it is trying*. EVC adds a second `argmax` whose action space is the controller's own configuration — a policy over policies, priced |
| The cost is on the **signal**, not the outcome | Every reward-shaping term in the wiki modifies `r`. `Cost(signal)` modifies neither `r` nor `V`: it is subtracted at the deployment decision, so the same outcome can be worth pursuing under one control budget and not another with the reward function untouched |
| Identity and intensity are separate coordinates | An architecture with a task-selection mechanism and no gain on it (most of the wiki: [[wiki/entities/pbwm.md]], [[wiki/entities/rims.md]]) can express *which* module runs but not *how hard* — half the specification problem is missing |
| Value is recursive through future control decisions | Eq. 2's `max_i EVC(signal_i, outcome)` means the worth of a state includes the control it will demand later. A planner that scores rollouts by outcome reward alone systematically overvalues trajectories through control-expensive states |
| Level-generality | The theory predicts dACC engagement for a motor action, an abstract strategy and a temporally extended task alike; the sole determinant is whether the process can run on prespecified parameters. For a builder this says the control-cost term should be attached at *every* level of a hierarchy, not only at the top |
| Withdrawal criterion, supplied | [[wiki/concepts/cognitive-control.md]]'s open problem — no threshold for when a behaviour is handed over to automaticity — has a candidate here: hand over when `EVC(default) ≥ max_i EVC(signal_i)`, i.e. when the automatic pathway's payoff net of zero cost beats the best controlled option net of its cost. Untested, and it makes automaticity a *decision* rather than a consequence of practice |

---

## Open problems

The authors' own four, which the wiki inherits unanswered:

- **Where does the candidate set come from?** Eq. 3 maximises over "all feasible control signals". Nothing says how that set is learned or enumerated — the same hole as [[wiki/concepts/cognitive-control.md]]'s "nothing says which task model is retrieved", now visible as a candidate-generation problem rather than a retrieval one.
- **What is the form of `Cost`?** Asserted monotonic in intensity, never measured. Without it the theory predicts the *direction* of every effect and the magnitude of none.
- **What does estimating EVC itself cost?** The theory's own regress: a cost-benefit analysis of control is itself a controlled process. Untreated.
- **How is any of this approximated by neurons?** Eq. 2 is a full Bellman backup over control signals; nothing says what tractable estimator stands in for it.

Two more from the wiki's side:

- **The theory is explicitly silent on hierarchy**, while the evidence it reviews is not: progressively anterior dACC signals progressively more complex demands (motor conflicts caudally → strategy conflicts rostrally), and anterior vs posterior dACC/lPFC pairs are recruited by block-level vs trial-level incentives. EVC says level is irrelevant to *whether* dACC engages; the gradient data say something is organised by level anyway (`T364`).
- **Nothing in the theory selects `state`.** `EVC(signal, state)` takes the current state as given, including "motivational state, task difficulty" — so the same under-specification the wiki carries for a state register ([[wiki/concepts/homeostatic-need-signal.md]], `G56`) sits inside the control criterion too.

---

## Connections

- **[[wiki/concepts/cognitive-control.md]]** — the same control layer cut at a different joint: that page supplies *regulation* (a task model broadcast as bias into a competition) and this one supplies *specification*, the prior decision of whether to emit the bias and how strongly, on an explicit `payoff − cost` criterion. The theory makes the two anatomically disjoint (dACC specifies, lateral prefrontal cortex regulates), which turns that page's unanswered "what engages the controller" into a maximisation with a named cost term — and offers its missing withdrawal threshold as `EVC(default) ≥ max EVC(signal)`.
- **[[wiki/concepts/subjective-value.md]]** — the two halves of the same subtraction, measured in different tissue: that page's ventral striatal / medial prefrontal / posterior cingulate signal is the `Value(outcome)` term with the agent's own discount kernel already applied, and this page's dACC signal is the `− Cost(signal)` term. A common-currency scalar is the precondition for Eq. 1's subtraction to be well-posed, and neither source measures both terms in one design.
- **[[wiki/concepts/valuation-system-decomposition.md]]** — supplies the reason `Value(outcome)` cannot be a single lookup: one outcome carries at least four separately-stored valuations with different update rules, so the payoff term of Eq. 1 is under-specified until the assay fixes which valuation feeds it — and this page's monitoring/valuation cut is the same boundary drawn from the control side.
- **[[wiki/concepts/information-sampling-vs-search.md]]** — the schema for the price comparison that page reports is never made: exploration is classed here as *default override*, so a query's expected information gain enters Eq. 1's payoff term and its effort enters `Cost(signal)` in the same units — with neither function supplied, so the units are asserted rather than computed.
- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — the missing subtrahend for that page's reward formulas: every family listed there specifies a bonus added to `r` and none prices the computation that earns it, where this page makes the cost a term of the same equation and attaches it to the controller's intensity rather than to the outcome.
- **[[wiki/concepts/empowerment.md]]** — the complementary reward-free scalar with the opposite sign convention: empowerment scores how much a state's *actuators* can achieve and is climbed, where `Cost(signal)` scores how much the *controller* must spend and is subtracted — so an agent holding both has a capacity term and a price term without any source in the wiki putting them on one axis.
- **[[wiki/concepts/policy-abstraction-hierarchy.md]]** — the direct disagreement (`T364`): that page orders control states by what their output names and places the orders in rostro-caudal frontal bands, while this page's criterion is level-blind — dACC should engage for a motor action and an abstract strategy alike, the only determinant being non-automaticity. The rostral-to-caudal dACC complexity gradient the theory reviews is evidence the theory declines to explain.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the rival reading of the same tissue: the hierarchical-reinforcement-learning account (Holroyd & Yeung) makes dACC an *option selector* for superordinate, temporally extended actions, where EVC makes it a level-general specifier of control identity and intensity. Under EVC an option's cost is its control intensity and is paid continuously, which is a different price than an option's termination-condition bookkeeping.
- **[[wiki/concepts/epistemic-value.md]]** — the payoff side of the exploration row above, with the address that page supplies: state-uncertainty and parameter-novelty terms are valued in separate regions, so Eq. 1's `Σ Pr·Value` is at least two signals arriving at dACC rather than one, and the subtraction is over a sum this page never decomposes.
- **[[wiki/concepts/evidence-accumulation.md]]** — one of the processing parameters a control signal sets: thresholds and response biases governing the speed–accuracy tradeoff are named as control-signal targets, so post-error slowing is an intensity re-specification rather than a change of evidence.
- **[[wiki/entities/salience-network.md]]** — the same dACC tissue given a different job: a bottom-up detector deciding *whether* the system is externally directed, against this page's normative evaluator deciding which control signal maximises net value — the two differ in whether dACC output is a switch or an `argmax`.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the rodent anatomy behind the specification/regulation split, and the complication: outcome anticipation and outcome evaluation are carried by physically separate neuron pools there, which is what Eq. 1's `Pr(outcome·)·Value(outcome)` probability–value product requires as two separately-addressed inputs rather than one wire.
- **[[wiki/entities/lateral-frontoparietal-network.md]]** — the crossed design that splits this page's single cost term: dorsolateral prefrontal activation tracks task *difficulty* while rostrolateral tracks *relational structure* independently of difficulty, so "effort" is at least two dissociable resources and `Cost(signal)` is a scalar over something that is not one.
- **[[wiki/concepts/motivation-representation-synergy.md]]** — the normative rule that page's gap needs: a system that holds a capability and declines to deploy it is, under Eq. 3, one for which `EVC(that signal, state) < EVC(default, state)` — competence intact, expression withheld because the price exceeded the payoff (`G102`).
- **[[wiki/concepts/homeostatic-need-signal.md]]** — a third route by which an internal state can change behaviour, alongside that row's two: state enters `EVC(signal, state)` and can move the *cost* of deployment with `r` and `V` untouched, which is neither a potentiation of outcome value nor a deficit whose fall is the reinforcement (`T356`).
- **[[wiki/entities/global-neuronal-workspace.md]]** — the same allocate-when-cached-policy-fails story with a criterion attached: workspace activation rises during novel acquisition, effortful execution and after errors, which is this page's monitoring input list, and EVC supplies the missing rule for how much to allocate rather than merely whether.
- **[[wiki/concepts/multi-horizon-value-learning.md]]** — what Eq. 2's single `γ` flattens: the recursion discounts future control decisions at one rate, so a control-expensive state's cost and a distant reward's payoff are compressed onto one horizon, and the mixture-of-horizons machinery that recovers non-exponential kernels has no counterpart on the cost term.
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — the strongest evidence yet for this page's rival on the same tissue (`T364` position B), and unusually clean: dorsal anterior cingulate activation scales with a prediction error about distance to a **subgoal** while distance to the rewarded goal is held constant by the task's ellipse geometry, with response conflict, latency and displacement magnitude all regressed out — a level-indexed signal for which `EVC(signal, state)` contains no term, though it also forbids none (Ribas-Fernandes et al. 2011).
