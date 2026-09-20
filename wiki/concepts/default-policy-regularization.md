# Default-Policy Regularization — the Control Cost as the Thing That Manufactures Habits

**Charge every task-specific policy a divergence from a shared default policy, and distil the default from the task policies it prices: `max_i  E[r_i] − β·KL(π_i ‖ π₀)`, with `π₀ ← distil({π_i})`. The cost term is then not a modelled disutility but the *pressure that makes the default absorb what the tasks have in common* — which turns "why is control costly?" from a question about a scarce resource into a question about what a penalty on departure buys a multi-task learner.**

> **Provenance.** Kool & Botvinick 2018, *Mental labour*, Nat Hum Behav 2:899–908 (`raw/kool-2018-mental-labour.md`), final section and Fig. 5, reading Teh et al. 2017 (*Distral*, NeurIPS 30:4497–4507) as a psychological hypothesis. The architecture is Teh et al.'s and was not addressed to human psychology; the identification of `π₀` with automatic/habitual behaviour and of `KL(π_i ‖ π₀)` with the subjective cost of control is Kool & Botvinick's proposal. Related information-theoretic statement: Genewein et al. 2015.

Why this earns a page. Every other account of the effort cost in the wiki is **conservative** — the cost exists to protect a scarce resource (glucose, working-memory capacity, time), or it is a wired-in heuristic that prevents a regress of allocation decisions. Those accounts explain the cost's *existence* and say nothing about what it does to learning. This one is **constructive**: the cost is a term in a training objective whose effect is to shape the default, so paying it less over time is not merely economy — it *is* habit formation. It is also the only account in the wiki that is runnable as written.

---

## The three standing accounts of why control is costly, and what each denies

| Account | Scarce thing | Why a cost is needed | What it cannot explain |
|---|---|---|---|
| **Metabolic** | blood glucose | conserve fuel | the number: global cerebral glucose rises ≤ ~1% under load; the glucose/ego-depletion result has not held up (Inzlicht et al. 2014 vs Gailliot et al. 2007) — see [[wiki/concepts/effort-based-decision-making.md]] |
| **Opportunity cost** | control capacity, time, information | allocation to one goal precludes others; foregone reward is a real loss | *why a subjective cost is needed at all* — a rational allocator already maximises use of a limited resource without any disutility term |
| **Heuristic** (Kool & Botvinick 2013) | — | the optimal allocation computation is itself expensive, so evolution wires in a blunt discouragement instead | it is an explanation of last resort: it predicts the cost's *existence* and nothing about its shape, and it makes the cost a bug tolerated for tractability |
| **Default-policy regularization** (this page) | — | the cost *produces* a maximally useful default policy; without it nothing forces the common structure of the tasks into `π₀` | not yet shown to reproduce any human effort-choice datum; `β` is a hyperparameter, not a measured cost |

The opportunity-cost row carries the argument that motivates this page: **a limited resource is not sufficient to explain an effort cost.** If control capacity is scarce, the right response is an allocation policy, not a disutility. The default-policy account answers the objection by giving the cost a job that an allocation policy cannot do.

---

## The architecture

| Component | Content |
|---|---|
| `π₀` | a generic, task-agnostic stimulus–response policy — the *default* |
| `π_i` | one policy per task `i`, free to override the default |
| Distillation | `π₀` is updated by distilling `{π_i}`, absorbing their common features |
| Cost | each `π_i` is penalised for departing from `π₀` |
| Reported effect | greater stability and reliability of learning than architectures lacking either feature (Teh et al. 2017) |

**Two couplings, in opposite directions.** The default is pulled *toward* the task policies (distillation), and the task policies are pulled *toward* the default (the penalty). What survives in `π_i` after equilibrium is exactly the task-specific residue — the part that could not be shared — which is the formal version of "control overrides automaticity only where automaticity is wrong."

**The psychological mapping.**

| Architecture | Cognitive reading |
|---|---|
| `π₀` | automatic / habitual behaviour ([[wiki/concepts/amortized-inference.md]]'s cache, [[wiki/concepts/cognitive-control.md]]'s default) |
| `π_i` | controlled behaviour — a task model broadcast as bias |
| `KL(π_i ‖ π₀)` | the subjective cost of control; zero when the controlled policy coincides with the habit |
| `β` | the agent's price of control — the trait parameter [[wiki/concepts/effort-based-decision-making.md]] elicits per person |
| Falling `KL` over training | habitisation, with no separate habit-learning system |

---

## What a builder takes from this

| Property | Consequence |
|---|---|
| **The cost is a function of the control signal's *content*, not its intensity** | [[wiki/concepts/expected-value-of-control.md]] asserts `Cost(signal)` is monotonic in intensity and free in identity. Here it is monotonic in **distance from the default**, which makes identity costly too — and predicts that two equally demanding tasks differ in cost according to how far each departs from what the agent habitually does. A directly testable disagreement, and nothing in the wiki has run it |
| The cost term is **measurable inside the agent** | `KL(π_i ‖ π₀)` is computed, not elicited, so an architecture holding both policies has a cost signal available for free — no COGED titration required, and the two readings (internal `KL` vs elicited `SV`) can be compared in one system. That comparison is the psychometric–neurometric protocol [[wiki/concepts/subjective-value.md]] specifies, with the "subject-specific parameter" problem solved by construction |
| Habits are a **consequence of pricing**, not of repetition | The wiki's standing account of habitisation is practice-driven (uncertainty curves crossing, [[wiki/concepts/amortized-inference.md]]; model-free caching). Here a task can be practised indefinitely and never habitise if its optimal policy conflicts with other tasks' — the constraint is *interference across the task set*, not repetition count |
| Automaticity is **shared across tasks by construction** | A single `π₀` distilled from all tasks is the wiki's cheapest mechanism for transfer of the automatic level, and predicts that acquiring a new task lowers the control cost of old tasks that share structure |
| The default is a **learned prior over action**, not a fixed baseline | Same object as the amortized latent prior in [[wiki/concepts/amortized-inference.md]]: a distribution that biases sampling toward plausible continuations. Here it is the action-shaped instance, priced |
| `β` sets the automatic/controlled balance with one dial | High `β` ⇒ everything collapses to the default (apathy/abulia, the "collapsed willingness to pay" reading of medial frontal damage); low `β` ⇒ no habits form and the default never carries anything |

**(brainstorm) The prediction that separates this account from every other on the page.** Under conservative accounts, effort cost should scale with *demand* however measured. Under this one it scales with **conflict between the controlled policy and the distilled default**, so a high-load task the agent has been doing for years should be cheap and a low-load task that contradicts a strong habit should be expensive. Reverse-COGED on a Stroop-like low-load/high-conflict task against a high-load/low-conflict task is the experiment, and it is runnable on humans and on any agent with an elicited discount curve.

**(brainstorm) The regress the heuristic account was invented to stop does not arise here.** Kool & Botvinick 2013 introduce the cost as a heuristic precisely because computing the optimal control allocation is itself costly ([[wiki/concepts/expected-value-of-control.md]]'s third open problem, "what does estimating EVC cost?"). `KL(π_i ‖ π₀)` is a *gradient term*, paid during learning and read off at inference without any allocation computation — which is the first candidate in the wiki for a cost term that does not reintroduce the regress it prices.

---

## Open problems

- **No behavioural validation.** The architecture was built for multi-task robustness; no human effort datum has been fit with it, and the functional form implied for `Cost` (a divergence) is untested against the hyperbolic/convex candidates in `T398`.
- **`β` is not derived.** Nothing says what sets the exchange rate between reward and divergence; the psychological account needs it to be a trait, and the engineering account treats it as a tuning knob.
- **One default, or many?** A single `π₀` over all tasks is the strong version. A hierarchy of defaults (per context, per level of [[wiki/concepts/policy-abstraction-hierarchy.md]]) would price control relative to the nearest habit rather than to a global one, and is what the context-specificity of control adaptation suggests (Schouppe et al. 2014).
- **Interaction with the opportunity-cost account is unstated.** The two are not incompatible — a divergence penalty could be the *mechanism* by which a capacity opportunity cost is charged — and no source in the wiki writes both terms in one objective.
- **It is silent on prospective choice.** The penalty is paid during execution. The effort decisions [[wiki/concepts/effort-based-decision-making.md]] measures are made *before* engagement, and a `KL` that only exists once `π_i` is running cannot be consulted at the choice point unless the agent can predict it.

---

## Connections

- **[[wiki/concepts/effort-based-decision-making.md]]** — the elicited quantity this page proposes a generative account of: that page measures the control cost as a discount on reward and endorses opportunity cost without naming a function, where this page makes the cost a divergence from a distilled default and thereby predicts a different *argument* for it (distance from habit, not demand). The two readings of `β` — internal `KL` and elicited `SV` — are comparable inside one agent, which neither literature has done.
- **[[wiki/concepts/expected-value-of-control.md]]** — the direct disagreement about what `Cost` is a function of: that theory prices **intensity** and declares identity free, this one prices **content** (departure from the default), so two control signals of equal intensity have different costs whenever they sit at different distances from habit. It also supplies a non-regressive candidate for that page's "what does estimating EVC itself cost?" — a gradient term paid during learning rather than an allocation computation performed at choice.
- **[[wiki/concepts/cognitive-control.md]]** — the withdrawal criterion, restated as a training dynamic: control is handed to automaticity when `KL(π_i ‖ π₀) → 0`, i.e. when distillation has absorbed the task model into the default, which makes automatisation a consequence of *cross-task compatibility* rather than of practice on the task itself.
- **[[wiki/concepts/amortized-inference.md]]** — the same cache/compute split with the price attached and the arbitration removed: the default policy is plan amortization's cached policy, but here the two systems are not in competition for control — the controlled policy *is* the default plus a penalised deviation, so there is no switch to arbitrate and habitisation is the deviation shrinking.
- **[[wiki/concepts/divergence-objectives.md]]** — the same "divergence as a *term*, not the objective" move that page identifies in equilibrium propagation: neither argument of the `KL` is the data, and what is minimised is the gap between what the system does when task-driven and what it does when left alone. That page's observation that the useful direction is fixed by *which phase you want to become the default* is literally the design decision here.
- **[[wiki/concepts/policy-abstraction-hierarchy.md]]** — where a hierarchy of defaults would live: pricing control relative to the nearest habit rather than a global one requires one default per level, which would make the rostro-caudal ordering a ladder of increasingly abstract defaults rather than of control states.
- **[[wiki/concepts/continual-learning.md]]** — the same two-speed write with the opposite sign: there a penalty on parameter movement protects old tasks from new ones, here a penalty on policy movement pulls new tasks *toward* a shared default that old tasks also wrote. Both buy stability by charging for departure; only this one distils the thing departed from.
- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — the subtrahend those families lack, in a form they can use: every family there adds a bonus to `r`, and a divergence-from-default penalty is a bonus term with the opposite sign that is computable from quantities a multi-task agent already holds.
- **[[wiki/concepts/learned-industriousness.md]]** — the rival origin account for the same cost, and the design that discriminates them: a distance-from-default penalty predicts that a **familiar** high-load task is cheap, while a conditioned value on the effort sensation predicts that an **unfamiliar** task is cheap if the agent's history rewarded high exertion elsewhere. The transfer experiments run that comparison — new apparatus, new response dimension, new modality, yoked on reward count and success rate — and they come out on the conditioning side for biological agents, which is the one empirical check this page's account has not passed.
