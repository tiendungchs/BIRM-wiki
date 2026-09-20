# Effort-Based Decision-Making — the Cost Term, Made Measurable

**Cognitive effort has no objective definition and no global metabolic referent; the only construct that carries explanatory weight is the *decision* to engage — so effort is operationalised as a discount on reward elicited by choice, `SV(reward, demand) / reward`, and the thing an architecture must hold is a price that is revealed by preference rather than computed from the task.**

> **Provenance.** Westbrook & Braver 2015, *Cognitive effort: a neuroeconomic approach*, Cogn Affect Behav Neurosci 15(2):395–415 (`raw/westbrook-2015-cognitive-effort-neuroeconomic-approach.md`). A review plus a research programme; the new empirical content is the authors' own COGED (Cognitive Effort Discounting) paradigm and its validation, everything else cited to its original.

Why this earns a page. [[wiki/concepts/expected-value-of-control.md]] writes `Cost(signal)` into an equation and lists "what is the form of `Cost`?" as its first unanswered problem — asserted monotonic in intensity, never measured. This page is that measurement: a titration procedure that returns a per-agent cost function in reward units, plus the argument for why no *objective* substitute (glucose, arousal, performance, difficulty) can stand in for it. [[wiki/concepts/subjective-value.md]] supplies the elicitation machinery and the currency; this page adds a third discountable dimension to delay and risk and shows it is not reducible to either.

---

## What effort is not — four exclusions, each with a discriminating case

| Candidate identity | Why it fails | The case that separates them |
|---|---|---|
| **Attention** | endogenous attention is effortful, exogenous capture is not | the voluntary/involuntary split |
| **Motivation** | motivation can push effort *down* — a participant complying with a rest instruction is motivated to minimise it | resting-state scan instructions |
| **Difficulty** | **data-limited** tasks (reading degraded words) are hard and unimprovable by resource allocation; only **resource-limited** tasks are effortful (Norman & Bobrow) | "unlikely to succeed" is rated separately from "effortful" |
| **Cognitive control** | *flow* is control-demanding and reportedly effortless; effort attaches to the *decision* to engage control, not to control itself | high-proficiency demanding performance |

The residue after the four exclusions is volitional and motivational, which is why the paper's move is to define it at the choice point rather than during execution.

---

## COGED — the instrument

| Step | Detail |
|---|---|
| Familiarise | participant performs `N`-back at `N = 1…6` |
| Offer | paired choice: repeat a high-`N` level for more money, or the `N = 1` baseline for less |
| Titrate | step-wise until indifferent between baseline and each higher load |
| Read out | `SV = indifference amount / offered amount` (e.g. `$1.40 / $2.00 = 0.70`), one point per load → a preference function over demand |

**Two confounds are designed out by construction, not controlled statistically.** *Delay*: every load takes the same wall-clock time, so a steeper discount at `N = 3` than `N = 2` cannot be a delay discount. *Risk*: pay is explicitly not contingent on performance — it depends on willingness to "maintain effort" — so it cannot be a probability discount. This is the cleanest dissociation of effort from the wiki's two existing discount dimensions.

### Validation results

| Claim | Number |
|---|---|
| `SV` falls monotonically with `N`-back load | the core effect; duration and payment contingency equated across loads |
| `SV` is a trait measure | positively correlated with Need for Cognition |
| Group difference survives performance matching | older adults discount more than younger **even when `N`-back accuracy is matched** — so a "capacity" reading of aging effects is confounded with a *motivation* reading |
| The **amount effect** transfers from delay discounting | larger rewards discounted proportionally less; reward's weight grows relative to demand's as amounts rise |
| Effort and impulsivity share something | steeper effort discounters are steeper delay discounters — and the relation is **asymmetric**: agents who find effort cheap span the full impulsivity range |
| Not a wealth effect | age differences in *delay* discounting are absorbed by self-reported income; age differences in COGED survive that control |
| Not boredom | **reverse COGED** — start from equal offers and allow discounting in either direction: **2 of 85** participants paid to take a *harder* `N`-back. Demand is near-universally costly |

**The reverse-COGED row is the load-bearing control and the wiki has no analogue of it.** Every intrinsic-motivation formula in the wiki adds a bonus for novelty, progress or information and assumes difficulty is attractive; a two-sided elicitation asks the agent which sign the term has and, on this task, it is negative for 98% of them.

---

## Why effort is aversive — three accounts, one of them with a negative result attached

| Account | Precious resource | Prediction | Status in the source |
|---|---|---|---|
| **Metabolic input** | blood glucose | cost accumulates with time-on-task; depletable; glucose predicts performance | **argued against** |
| **Metabolic waste** | amyloid-β production:clearance ratio (Holroyd) | effort tracks accumulation; sleep deprivation raises it | untested; may index fatigue rather than momentary effort |
| **Opportunity cost** | working-memory / control capacity | cost varies with the *value of the next-best use* of the resource, with no depletion required | endorsed; unmeasured |

**The metabolic negative, in numbers.** Global cerebral glucose consumption rises by **no more than ~1%** during vigorous task engagement, and the brain's resting dynamics are already expensive; astrocytic glycogen is better placed to serve *local*, transient demand than circulating glucose is; and manipulating a participant's **beliefs about willpower** determines whether blood-glucose changes affect self-control at all. So glucose can influence the decision without being its currency — a signal among several that track protracted engagement, not the constraint.

**What opportunity cost is missing.** The account names no function. Two open sub-questions the source states and the wiki inherits: does the brain track the value of *other available goals*, or only the current one — and if the former, what fixes the tracked set? Neither has an answer, which is why the term is directional and not quantitative.

**Two borrowed models, and exactly where each breaks.**

| Model | Transferable part | Where the analogy fails |
|---|---|---|
| **Vigour / average reward rate** (Niv et al.) — response latency set by trading energetic cost against reward forgone by sluggishness, reported by striatal dopamine tone | gives opportunity cost a computable local statistic; and the experienced-reward stream could include internally generated **pseudo-rewards** for subgoal completion ([[wiki/concepts/pseudo-reward-prediction-error.md]]) | vigour is **goal-general** (one rate over all behaviour) where effort is goal-specific; and errors should *raise* control intensity while *lowering* vigour, so the two make opposite predictions on the same event |
| **Adaptive gain theory** (Aston-Jones & Cohen) — norepinephrine-set neuronal gain, engagement tracking task utility, disengagement read as adaptive exploration | supplies the response- and goal-specificity vigour lacks: gain modulation time-locked to selected responses | says nothing about *where* the costs in "utility" come from, and addresses only ongoing engagement — it has no machinery for a **prospective** decision about effort not yet expended |

---

## Reward is not subjective value — the measurement argument

The dominant method in the effort literature is to manipulate cash and assume effort moves in proportion. It does not.

- Monetary incentives raise performance in roughly **55%** of laboratory studies; elsewhere they do nothing or hurt.
- Incentive effects are *weakest* for complex reasoning and problem-solving and *strongest* for simple vigilance and detection — i.e. incentives more reliably modulate the **effortless** forms of engagement.
- Participants offered **no** cash outperformed paid participants in one study: pay schedules are read as an incomplete contract that tells participants what their effort is worth. A paradigm intended to measure effort then measures **social fairness** instead.
- An fMRI `N`-back study found reward magnitude raised prefrontal recruitment with **no** effect on performance.

**Consequence for the wiki's instruments.** Any experiment — biological or machine — that reads effort off an incentive manipulation is reading a quantity whose relation to the cost term is unsigned. `SV` elicited by choice is the only reading in the wiki that is incentive-compatible by design, and it is obtained *before* engagement, so it is unambiguously an **input** to the engagement decision rather than a consequence of it. The same source shows why that matters: systolic blood pressure during a prior task has been interpreted as both an input to and an output from the effort decision *in the same study*, for younger and older adults respectively.

---

## Decision value vs outcome value — an unresolved placement

Neuroeconomics separates **decision values** (include effort costs, computed at choice) from **outcome values** (do not). fMRI puts both in medial and lateral orbitofrontal cortex but decision values *only* in ventral striatum. One cognitive-effort study nevertheless found ventral-striatal value signals reflecting effort discounting **at reward-cue delivery, after the effort had been expended** — either outcome values are effort-sensitive after all, or the ventral striatum carries decision values at an outcome-locked time. No study has yet run a valuation procedure on cognitive effort, so where an effort-sensitive decision value is represented is unmeasured.

**Candidate cost-tracking regions and what each would mean.** dACC (specification, and the expected-value-of-control reading), or alternatively dACC as choice *difficulty* — peaking when the two `SV`s are closest, which is a different regressor entirely. DLPFC (volitional recruitment). Anterior insula (pain matrix; accumulating cost signal driving physical-effort disengagement; interoception). One measured result cuts against the dACC-as-effort reading: DLPFC and dACC recruitment both correlated with self-reported desire to avoid the task, but the **dACC correlation disappeared once errors and response times were partialled out** — leaving it a conflict/error monitor on that dataset rather than a subjective-effort signal.

---

## Cognitive effort is not physical effort — `T397`

The wiki's existing claim, from [[wiki/concepts/expected-value-of-control.md]], is that `Cost` is *not* specific to cognitive control: dACC tracks physical effort too and revises expected reward downward for it. This source supplies the dissociations that make the shared-cost reading an open question:

- A rat cognitive-effort task: **dopamine antagonism decreased preference for physical effort but not for cognitive effort**; amphetamine's effects on cognitive-effort preference are complex rather than monotone.
- The metabolic argument only bites on one side — physical action has a real energetic cost and cognitive action does not, so the resource whose opportunity cost is being paid is not the same resource.
- The computational argument likewise: vigour's average-rate regulation has no cognitive analogue (see the table above).
- Against: one incentive study finds ventral-striatal motivation signals common to both — but measured during passive cue viewing and during exertion, not during instrumental choice.

Physical effort is by contrast *well* dissociated from delay and risk: a dopamine antagonist reduced lever-pressing vigour with delay held constant (effort discounting selectively), while an NMDA-receptor antagonist raised delay discounting with effort discounting untouched (delay selectively); and anterior insula carries risk cost where supplementary motor area carries physical-effort cost.

---

## What a builder takes from this

| Finding | Consequence for an architecture |
|---|---|
| The cost function is **elicited**, not derived | An agent's control cost can be measured the way COGED measures a human's: offer the agent paired (task-load, reward) bundles, titrate to indifference, read `SV` per load. This is directly runnable on any RL agent with a reward channel and gives the curve [[wiki/concepts/expected-value-of-control.md]] leaves as a free function |
| Two-sided elicitation is the control that matters | Reverse COGED asks whether demand is a cost *or a bonus* for this agent. Every intrinsic-motivation family in [[wiki/concepts/intrinsic-motivation-typology.md]] hard-codes the sign; 98% of humans put it the other way on `N`-back |
| Cost is a **trait parameter with a wide spread** | Like `k` in [[wiki/concepts/subjective-value.md]], effort cost is per-agent and predicts downstream policy: the source's proposed test is whether effort `SV` predicts reliance on **model-based over model-free** control and on proactive over reactive control. An architecture with a fixed compute budget cannot express the individual difference that predicts which controller runs |
| Performance matching does not equate motivation | Two systems matched on task accuracy can differ in what they will pay to run the task. Any ablation or capacity claim read off matched performance is confounded with a cost difference — an `L0-INSTR` hazard for the whole wiki |
| Incentive manipulation is not effort manipulation | Scaling `r` changes engagement unreliably and changes *effortless* engagement most, so an agent's effort allocation cannot be probed by reward scaling alone |
| Prospective ≠ experienced cost | A dynamic, salience-driven leaky accumulator over features (rather than stable `SV` then comparison) predicts **unstable** effort preferences — the writing project one commits to and then abandons. An architecture computing a single stable `Cost(signal)` cannot produce that reversal |
| The decision is goal-directed, not habitual | Effort decisions about non-overlearned tasks should sit in the goal-directed system (action–outcome), and the goal-directed/habitual balance should itself be set by tolerance for goal-directed computation — a two-way coupling no arbitration scheme in the wiki has |

**(brainstorm) The psychometric–neurometric protocol on [[wiki/concepts/subjective-value.md]] transfers directly to the cost term and has never been run in either field.** Fit `SV(load)` to an agent's choices; fit the same functional form to the activations of the unit hypothesised to carry `Cost(signal)`; require covariation *and* zero mean offset. A controller whose internal cost signal merely correlates with load fails the offset half. In a machine this is cheap — the curve is elicited from the agent's own preferences, so the "subject-specific parameter" problem that made a population `k` fail in humans is solved by construction.

---

## Open problems

- **No functional form.** COGED returns indifference points, not a fitted `Cost` function; the source does not commit to hyperbolic, exponential or labour/leisure for effort.
- **What determines opportunity cost.** Whether the next-best goal's value is tracked, and how its set is fixed — the same under-specification [[wiki/concepts/expected-value-of-control.md]] carries for `state`.
- **Which control operation is priced.** Switching, maintenance, updating and inhibition are lumped into one demand axis (`N`-back load); nothing says whether they have one cost or several — and [[wiki/entities/lateral-frontoparietal-network.md]] already reports difficulty and relational structure as dissociable resources.
- **No valuation study of cognitive effort has been run in a scanner**, so no region is yet shown to carry an effort-sensitive *decision* value.
- **Arousal's direction is undetermined.** Pupil dilation, skin conductance, vasoconstriction, heart-rate variability and systolic blood pressure all track effortful engagement and none has been shown to be an input to the decision rather than an output of it.

---

## Connections

- **[[wiki/concepts/expected-value-of-control.md]]** — the equation this page measures a term of: `Cost(signal)` is asserted monotonic in intensity and never quantified there, and COGED returns it as a per-agent discount curve in reward units with delay and risk designed out. The two also disagree on the cost's scope (`T397`): that page reads dorsal anterior cingulate's sensitivity to physical effort as evidence `Cost` is domain-general, where this page's dopamine-antagonist dissociation (physical preference moves, cognitive preference does not) and its metabolic argument make cognitive and physical effort candidates for two separately-addressed costs.
- **[[wiki/concepts/subjective-value.md]]** — the same elicitation machinery applied to a third discount dimension: that page's hyperbolic delay kernel and this page's demand kernel land on one currency, replicate the same **amount effect**, and correlate across individuals — asymmetrically, since cheap-effort agents span the full impulsivity range. Its psychometric–neurometric two-part test is the instrument this page's cost term still needs.
- **[[wiki/concepts/cognitive-control.md]]** — the thing being priced, and the reason effort is not identical to it: control is a task model broadcast as bias, effort is the volitional decision to emit it, and *flow* is the case that separates them — control-demanding performance reported as effortless. This page also supplies a measured answer to that page's automaticity question in reverse: whether a system hands a task over depends on a price that differs across agents at matched performance.
- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — the sign check every family there omits: each specifies a bonus added to `r` for novelty, progress or information and assumes demand is attractive, where reverse COGED elicits the sign two-sidedly and finds it negative for 83 of 85 humans on `N`-back. The boredom case is the one condition under which those families' assumption holds, and it is a state, not a trait.
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — the candidate content of the experienced-reward stream that sets opportunity cost: if vigour-style regulation reads an average rate of experienced reward, internally generated pseudo-rewards for subgoal completion enter that average, so manufacturing subgoals would *lower* the effort cost of the task they decompose — a coupling between subgoal machinery and effort pricing that neither literature states and no wiki architecture implements.
- **[[wiki/concepts/valuation-system-decomposition.md]]** — the same "one outcome, several stored valuations" problem on the cost side: decision values include effort and outcome values do not, yet a ventral-striatal effort-discounted signal appears *after* expenditure, so which valuation an effort assay reads is as unsettled here as which one a devaluation assay reads there.
- **[[wiki/concepts/policy-abstraction-hierarchy.md]]** — the arbitration this page's trait parameter is proposed to predict: model-based over model-free, and proactive over reactive control, are both hypothesised to be selected by an agent's tolerance for the computational cost of the more expensive controller — which would make the hierarchy's occupancy a function of a priced quantity rather than of task structure.
- **[[wiki/entities/lateral-frontoparietal-network.md]]** — the evidence that this page's single demand axis is at least two: dorsolateral prefrontal activation tracks task difficulty while rostrolateral tracks relational structure independently of difficulty, so an `N`-back load curve prices one resource and leaves the other unmeasured.
- **[[wiki/concepts/working-memory.md]]** — the capacity whose opportunity cost the endorsed account names: allocation to any goal precludes allocation to others, so the price of control is the value of the next-best use of a sharply limited store — and the value-based gating literature (phasic dopamine training working-memory allocation) is that account's mechanism.
- **[[wiki/concepts/metacognitive-efficiency.md]]** — the self-report channel this page's instrument is argued to beat: COGED detected an aging group difference that the Need for Cognition self-report did not, so a revealed-preference readout of an internal cost is more sensitive than the agent's own statement of it.
