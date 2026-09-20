# Learned Industriousness — the Cost Term Has a Conditioning History

**The aversiveness of effort is not a fixed parameter of the agent but a conditioned quantity: the *response-produced sensation* of high effort, paired with reinforcement, acquires secondary reward value that partially cancels the cost — and because the sensation is a property of exertion rather than of the task, the cancellation transfers to other tasks, other response dimensions, other modalities and other stimulus contexts.**

> **Provenance.** Eisenberger 1992, *Learned industriousness*, Psychological Review 99(2):248–267 (`raw/eisenberger-1992-learned-industriousness.md`; `LOSSY` — PDF converted by `tools/pdf2md.sh`, original in `raw/originals/`). A theoretical review assembling ~20 experiments from the author's own programme (rats, preadolescents, learning-disabled students, depressed inpatients, college students) plus the prior persistence literature. Every result below is cited there to its original.

Why this earns a page. [[wiki/concepts/effort-based-decision-making.md]] measures the cost term and then poses a fork it cannot settle: is effort endowed with **intrinsic** positive value that cancels part of the inherent cost, or is value attached only to effort's **extrinsic** products? That page also names the discriminating test — *an intrinsic value for exertion transfers to a new effortful task, an extrinsic one does not*. This source is thirty years of running exactly that test, with yoked controls that equate reward count, success rate and response count. It supplies the wiki's only **update rule for a cost term**, and it does so by pointing [[wiki/concepts/conditioned-reinforcement.md]]'s pairing mechanism at an interoceptive rather than an exteroceptive CS.

---

## The rule

| Element | Content |
|---|---|
| **CS** | the response-produced sensation of high effort — assumed qualitatively similar across the dimensions that produce it (frequency, force, duration, precision, speed, complexity), and across physical and cognitive exertion |
| **US** | the reinforcer delivered contingent on meeting the high-performance criterion |
| **Learned quantity** | secondary reward value attached to the *sensation*, reducing its aversiveness |
| **Symmetric case** | reinforcing **low** performance conditions secondary reward value to the low-effort sensation and extinguishes part of the value previously held by high effort |
| **Transfer law** | because the CS is response-produced and not task-bound, the acquired value is carried into any behaviour that produces the same sensation |
| **Context binding** | the value is conditioned *in relation to the stimulus context* and generalizes by similarity between training and transfer situations |

**The architectural claim in one line.** Incentive-motivational accounts route behaviour toward response-produced stimuli with the highest conditioned value; this account adds that **effort is a dimension of response-produced experience that is unusually sensitive to that conditioning**. So the cost term in a control equation is a *slot with a learning rule*, not a constant.

---

## What the transfer evidence controls for

The experiments are built to defeat three confounds in turn, and the yoking designs are what make them worth copying.

| Design | Confound removed | Result |
|---|---|---|
| Ratio training in one apparatus → extinction in a **different** apparatus (Wenrich et al. 1967; McCuller/Wong/Amsel 1976; free-operant replications) | task-specific learning | 15 runway trips per pellet → greater *lever-press* extinction performance than 1 trip per pellet; effect survives reacquisition and a second extinction series |
| **Force yoking**: presses failing the force criterion are added to the paired low-force animal's required count (Eisenberger, Carlson, Guile & Shapiro 1979) | high-force animals emit more responses per reinforcer | high-force training → substantially greater runway shuttling rate and extinction rate, with responses and time equated |
| **Anagram yoking**: yoked subject gets a *simple* anagram whenever its partner succeeded and an *unsolvable* one whenever its partner failed (Eisenberger & Leonard 1980, Exp. 3) | success/failure pattern; "low effort→success, high effort→failure" for the yoke | complex-anagram group persisted longest on later unsolvable perceptual problems |
| **Cross-modality**: rewarded high *pad-pressure*, then a new experimenter in a new room gives anagrams (Boyagian & Nation 1981) | context, demand characteristics, modality | high-pressure group solved anagrams faster — physical effort training transferring to cognitive performance |
| **Free-food yoking** on self-control (Eisenberger, Weier, Masterson & Theis 1989) | reinforcer count and temporal density | only the response-contingent fixed-ratio group shifted preference; yoked free-food groups did not move |

### The transfer is to reinforced performance and to choice, not only to extinction

| Test | Effect |
|---|---|
| Acquisition of a *new* behaviour | FR-9 lever pressing → faster subsequent runway acquisition than CRF |
| Resistance to noncontingent punishment | 5 shuttles/pellet → less suppression of lever pressing by periodic shock than CRF |
| **Self-control over effort** (rats) | after ratio training, durable shift toward the *high-force, large-reward* compartment over *low-force, small-reward*; held across 12 sessions, with both alternatives thoroughly sampled at baseline |
| **Self-control over punishment** (rats) | after ratio training, durable preference for large-reward-plus-shock over small-reward-unshocked |
| **Self-control over effort** (children) | paid for high performance on counting/picture-memory/shape-matching → more choices of copying nonsense words for a large reward over a small reward for nothing |
| Clinical/educational populations | depressed inpatients rewarded per 4–5 custodial tasks later sorted more cards for a *different* experimenter; learning-disabled children on a high-ratio spelling/reading token schedule later worked more periods and solved more problems on a teacher-administered math test |
| Home-cage feeding | 27 days (not 9) of gnawing pellets through a hopper vs eating off the cage floor changed runway extinction performance in a different room — an unmanipulated husbandry variable acting as effort training |

---

## The generalization has structure — four facts a scalar cost cannot express

| Fact | Evidence | What it denies |
|---|---|---|
| **Intradimensional specificity** | rewarding reading *accuracy* transfers to drawing/story accuracy; rewarding reading *speed* transfers to story speed; each beats the other in its own dimension (Eisenberger et al. 1984) | a single scalar "effort" — the conditioned value is carried on a **vector** of partially-substitutable performance dimensions |
| **Concurrent multi-dimension transfer** | high lever force → faster runs *and* shorter inter-run pauses; complex cognitive tasks → longer essays *and* higher quality per unit length | that the dimensions trade off; they move together |
| **Variety beats repetition, at matched trial count** | anagrams + math + perceptual identification combined produced greater essay length and quality than any single training task with total trials equated | that the amount of effort training is what sets transfer breadth — the **diversity of contexts the value is conditioned to** is a separate factor |
| **Stimulus control by the reinforcing agent** | two experimenters alternate, one requiring 5 identifications per drawing pair and one requiring 1; the *high-ratio* agent's later essay assignment drew longer and better essays | an agent-global willingness to work — the price is conditioned to cues, including who is asking |

### Mediated generalization: the breadth of the *label* sets the breadth of transfer

Children rewarded for high recall were taught to say, on success, either the **narrow** attribution ("When I try hard, I do well remembering pictures") or the **broad** one ("When I try hard, I do well in all my school work"). Only the broad-categorization group showed increased generalized self-control on a later handwriting-for-reward choice — beating the untutored high-ratio group as well as the narrow one (Eisenberger 1990).

**(brainstorm) This is the wiki's cleanest behavioural demonstration that an explicit symbolic label controls the *support set* of a learned value.** The same reinforcement history, the same conditioned quantity, and a verbal token decides which future tasks inherit it. For a builder that is a proposal about where abstraction pays in a value function: not in computing the value, but in indexing it — a learned cost modifier keyed by a category embedding generalizes exactly as far as the category does, which makes transfer breadth a *designed* property rather than an emergent one. Nothing in [[wiki/concepts/abstraction.md]] or [[wiki/concepts/compositionality.md]] has this as a read-out, and no cost term in the wiki has an index at all.

---

## Effort self-control and delay self-control are separately trained — a double dissociation

Self-control is treated in the wiki mainly as delay discounting ([[wiki/concepts/subjective-value.md]]). This source separates the two costs by training:

| Training | Effect on delay self-control | Effect on effort self-control |
|---|---|---|
| Long intervals between **free** food presentations (rats) | increases it | **no measurable effect** (Eisenberger et al. 1989) |
| High required **response ratio** (rats) | **no measurable effect** (Eisenberger, Masterson & Lowman 1982) | increases it |
| Factorial high/low performance × short/long delay (preadolescents) | delay training raises delay self-control only | effort training raises effort self-control only (Eisenberger & Adornetto 1986) |

**Consequence.** "Self-control" is not one trained capacity; it is at least two costs with independent learning histories. An agent trained to wait does not thereby become an agent willing to work. This is the behavioural-training analogue of `T397`'s question about cognitive vs physical cost — the same dissociation logic applied to delay vs effort, and here the double dissociation is complete rather than one-sided, which makes the multi-dimensional cost reading the default rather than the contested one.

---

## Five rival accounts, and the datum that separates each

| Account | Claim | Discriminating result |
|---|---|---|
| **Rule learning** (Mowrer & Jones response-unit; Rachlin's suggestion) | the agent abstracts a rule "sustained activity is required for reward" | required **force** transfers with response count and time equated — no extra responses to abstract a rule from; and self-control shifts persist in animals *thoroughly familiar* with both alternatives' contingencies, where a rule about what is required has nothing left to teach |
| **Cognitive dissonance** / effort justification (Lawrence & Festinger) | high expenditure adds attraction to the *goal* | rats alternated between level and inclined alleys show **no preference** for the goal box attached to the inclined alley (Mirsky 1975); and transfer effects appear in children and adults given **no choice** about participating, which dissonance requires |
| **Frustration counterconditioning** (Amsel, Wong) | intermittent reward counterconditions anticipatory frustration into a general "try" strategy | applies only to the ratio manipulation, not to force/precision/complexity; cannot produce intradimensional specificity without positing dimension-specific frustration; and predicts that free-reward delay training should raise effort self-control — it does not |
| **Self-efficacy** (Bandura) | confidence in capability drives choice and persistence | the transfer tasks include tedium well inside demonstrated competence (copying nonsense words, already performed at baseline), where no capability doubt exists; and a confident agent may still desist because the exertion is unpleasant |
| **Learned helplessness / immunization** (Seligman) | contingent reward immunizes against later uncontrollability | true, and *strengthened* by requiring high performance: FR runway training reduced later shock-induced suppression relative to CRF, so contingency and effort-magnitude are separable contributors |

**The one the theory does not claim to cover.** Habituation to aversive stimulation raises later appetitive extinction performance (Chen & Amsel 1982) without any voluntary effortful response — outside the secondary-reward account unless adaptation is itself experienced as effortful. And the account is explicitly *not* a replacement for Amsel's or Capaldi's theories of response-specific persistence.

---

## The addendum to the law of least effort

Hull's law — given equal reinforcement, choose the less laborious sequence — survives; what changes is the exchange rate.

```
after effort training:   still prefer low effort at equal reward
                         but accept a larger increment of effort per unit of extra reward
```

Stated in the wiki's terms: effort training does not flip the sign of the cost (consistent with [[wiki/concepts/effort-based-decision-making.md]]'s reverse-COGED result that only 2 of 85 humans pay for more demand); it **rotates the indifference curve**. Eisenberger gives the translation into three formal frameworks explicitly: increased bowing of the indifference contours relating reinforcement and leisure utilities (economic models of operant performance); a reduced magnitude of the conserved-behaviour parameter (behavioural conservation); a reduced error signal when instrumental performance deviates from baseline, or reduced resistance to change (behavioural regulation). All three are parameter shifts in models the wiki already carries as fixed — the labour-supply surface on [[wiki/concepts/effort-based-decision-making.md]] is the first of them.

---

## What a builder takes

| Finding | Consequence for an architecture |
|---|---|
| The cost term has an **update rule** | Pair the agent's own exertion signal (rollout depth, control intensity, sample count) with reward arrival and learn a multiplier on `Cost`. Every cost in the wiki — `Cost(signal)` in [[wiki/concepts/expected-value-of-control.md]], the KL penalty in [[wiki/concepts/default-policy-regularization.md]], the compute budget in [[wiki/concepts/adaptive-computation-time.md]] — is a fixed function of load with no write port. `G128` |
| The CS is **response-produced**, not exteroceptive | The conditionable quantity must be an *internal* signal the agent emits, which means an architecture needs an explicit, readable effort variable before it can have a learnable price for it. Most agents do not expose one |
| Transfer breadth is **set by training diversity**, at matched volume | A curriculum that rewards high demand across *varied* tasks buys wider transfer than the same number of trials on one — a concrete, cheap prescription for [[wiki/concepts/curriculum-learning.md]] that does not require a difficulty schedule |
| Transfer breadth is **also set by an explicit label** | Tagging the training episode with a broad category token widened transfer in children beyond what the same reinforcement produced untagged. Directly testable in a language-conditioned agent, and it is a rare case where a symbolic annotation has a measured effect on a *scalar* rather than on a policy |
| The cost is **vector-valued and dimension-indexed** | Reinforcing accuracy buys accuracy elsewhere, not speed. A single scalar effort budget cannot produce this; a per-dimension price with partial cross-generalization can |
| The cost is **cue-conditioned** | Which experimenter asks changed how hard students worked. The machine analogue — the price of control depending on the task-issuer or context embedding rather than on the task — is unimplemented, and is what lets one agent be industrious in one regime and lazy in another without two policies |
| Yoking is the control the ML literature lacks | Every claim here is protected by a yoked group that equates reward count, success rate, response count or temporal density. Any machine claim that "training on hard tasks makes agents work harder" needs the same: a control that received the same reward stream without the demand contingency |
| Delay and effort train separately | An agent trained for patience is not thereby trained for exertion. Two costs, two curricula |

---

## Open problems

- **No mechanism for the conditioning, only the behaviour.** The source is at the behavioural level throughout; which structure holds a conditioned value for an interoceptive effort signal is untouched. [[wiki/concepts/conditioned-reinforcement.md]]'s substrate assignment (basolateral amygdala via orbitofrontal cortex) is for exteroceptive CSs and has never been tested on a response-produced one.
- **Does the conditioned effort value extinguish?** The symmetric prediction — reinforcing low performance extinguishes high effort's acquired value — is asserted and only indirectly tested (low-effort training groups fail to shift, rather than shifting *down* from a trained high baseline). `G125`'s audit question applies here too and is unanswered.
- **No functional form.** The account predicts a rotation of the effort/reward trade-off and never fits one, so it cannot arbitrate `T398` (convex vs hyperbolic cost).
- **The cross-modal claim rests on one experiment.** Physical→cognitive transfer (Boyagian & Nation 1981) is described by the source itself as "preliminary evidence"; it is also the single result that would bear most directly on `T397`, and it points the opposite way from the dopamine dissociation.
- **Where the fatigue boundary sits.** The theory requires effort to be aversive-but-conditionable and separately admits genuine capacity decrements from prolonged performance; nothing states how a system distinguishes a price it has learned to pay from a resource it has actually spent.
- **Individual differences are measured by questionnaire, not elicited.** Work-ethic scores predict persistence and interact with training (high-work-ethic students were already at ceiling for resistance to cheating; effort training moved only the low group) — a ceiling that an elicited cost curve would quantify and a median split cannot.

---

## Connections

- **[[wiki/concepts/effort-based-decision-making.md]]** — supplies the answer to that page's stated fork and uses that page's own named test: an intrinsic value for exertion transfers to a new effortful task, and it does, across apparatus, response dimension and modality, with yoked controls equating rewards, successes and response counts. It also adds the direction of travel that page's static `SV` curve cannot show — the curve is a snapshot of a conditioning history, so COGED run before and after a high-demand-rewarded curriculum should move, which nobody has done (`G128`). Conversely that page bounds this one: reverse COGED shows the sign is not flipped for 98% of humans, which matches this page's retention of the law of least effort as a rotation rather than a reversal.
- **[[wiki/concepts/conditioned-reinforcement.md]]** — the same pairing mechanism with an **interoceptive** CS, which is the extension that makes it a cost-learning rule rather than a subgoal-value rule: pairing an external stimulus with reward manufactures a want, pairing a *response-produced sensation* with reward makes an action cheaper. That page's dynamics are the ones this page's open problems inherit — whether an unbacked exertion extinguishes the acquired value, and at what exchange rate — and neither has been measured for a sensation rather than a stimulus.
- **[[wiki/concepts/expected-value-of-control.md]]** — writes `Cost(signal)` as a fixed function of control intensity; this page makes it a quantity with a history, a context index and a per-dimension decomposition. The regress that page carries (computing the optimal allocation is itself controlled and therefore costly) is eased rather than solved: a conditioned price is a cached answer to an allocation question, updated by outcome rather than recomputed, which is the same move [[wiki/concepts/amortized-inference.md]] makes one level up.
- **[[wiki/concepts/subjective-value.md]]** — the delay kernel this page dissociates from effort by *training* rather than by correlation: free-delay training moves delay self-control and leaves effort self-control untouched, and ratio training does the reverse, in rats and in children. That is a stronger separation than the individual-difference correlation those two pages share, and it says the two discount dimensions have independent write paths.
- **[[wiki/concepts/curriculum-learning.md]]** — a prescription that is about the reward contingency rather than the difficulty schedule: rewarding *high* performance in a **variety** of tasks, at matched trial volume, buys broader transfer than the same volume on one task, and the transferred quantity is a price rather than a skill. Also supplies a negative for that page: continuous reinforcement of easy increments (Skinner's programmed instruction) produces less later resistance to failure than intermittent reinforcement does.
- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — the origin story for a term every family there hard-codes: if demand's sign in the objective is a *conditioned* quantity, then an exploration bonus for difficulty is not a design choice but a learned state of the agent, and two agents with different reward histories should carry different signs on the same term. None of those families has a write path to its own bonus coefficient.
- **[[wiki/concepts/default-policy-regularization.md]]** — the rival origin account for the same cost, and the two are testable against each other here: a distance-from-default penalty predicts that a *familiar* high-load task is cheap, while this page predicts that an *unfamiliar* task is cheap if the agent's history rewarded high exertion elsewhere. The transfer-to-a-new-task designs above are exactly the discriminating case, and they come out on this page's side for biological agents.
- **[[wiki/concepts/pseudo-reward-prediction-error.md]]** — the complementary route to the same end: manufacturing subgoals lowers the effective cost of a task by injecting reward into it, where this page lowers the price of exertion itself. An architecture could do either, and they differ in transfer — a subgoal decomposition is task-bound, a conditioned effort price is not.
- **[[wiki/concepts/cognitive-control.md]]** — what gets bought when the price falls: the deployment decision, not the control computation. This page adds that the deployment threshold is trainable by a reward contingency applied to *any* demanding task, including a physically demanding one, which no control-training protocol in the wiki assumes.
- **[[wiki/concepts/adaptive-computation-time.md]]** — the machine cost term closest to this page's target: a ponder penalty fixed by the designer, with no mechanism by which an agent whose extra computation reliably paid off could come to charge itself less for it (`G128`).
- **[[wiki/concepts/abstraction.md]]** — a rare measured effect of an explicit category label on a scalar rather than on a policy: broad self-attribution ("all my school work") widened the transfer of a conditioned cost where narrow attribution ("remembering pictures") did not, which makes the label the index of the value's support set.
- **[[wiki/concepts/self-boosting-knowledge-acquisition.md]]** — the benefit-side twin of this page's conditioned cost, and cited by that source as such: here a history in which exertion paid writes *down* the price of effort, there a history of successful acquisition writes *up* both the supply and the value of the reward, so both terms of the same subtraction are conditioned by the agent's own past and neither has a write port in any wiki architecture (`G128`, `G129`).
