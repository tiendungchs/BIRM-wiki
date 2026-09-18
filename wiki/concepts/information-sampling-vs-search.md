# Information Sampling vs Information Search

**Two different problems wear one word. *Sampling* reduces uncertainty inside a task whose structure is already known, so the relevant cues form a small set and the value of a query is computable from the goal it serves. *Search* runs before the agent knows whether a pattern exists or what it would be, so no goal is available to price a query with — and every normative epistemic quantity in the wiki is defined only for the first case.**

> **Provenance.** Gottlieb & Oudeyer 2018, *Towards a neuroscience of active sampling and curiosity*, Nat. Rev. Neurosci. 19(12):758–770 (`raw/gottlieb-2018-active-sampling-and-curiosity.md`). A review: every number below is cited by it to a primary source, and the sampling/search distinction and the complexity argument are the authors' own contributions. Box 1 (artificial-curiosity algorithms) is absent from the clipped HTML.

This page is the *problem statement* whose candidate answers live on [[wiki/concepts/intrinsic-motivation-typology.md]] (the space of reward formulas) and whose measurements live on [[wiki/concepts/epistemic-value.md]] (what happens when one is switched off). Its content is the claim that those two pages answer **different** questions and only the first of them is posed by the tasks either page runs.

---

## The distinction

| | **Information sampling** | **Information search** |
|---|---|---|
| Known ex ante | task structure, goal, which cues are signal and which are noise | nothing — whether a learnable pattern exists is itself unknown |
| Candidate set | small, task-scoped ("which cue at this intersection") | large and unbounded ("what hypotheses might explain a spark") |
| Query pricing | value of outcome × marginal increase in `P(outcome)` when acting with vs. without the information | no outcome to price against; the investigation precedes the payoff by an unknown interval |
| Formal home | exploration–exploitation, POMDP observation actions, expected free energy's `E2`/`E4` | nothing normative — this page's central negative claim |
| Laboratory form | cued visual search, observing tasks, bandits with a costly probe | free play, trivia-curiosity ratings, open-ended robot interaction |
| Wiki row it opens | `T124`/`T125` (which epistemic term, does it pay) | `G72` (nothing infers what counts as success) |

**The simplifying assumption that both parent literatures share, stated as a lesion.** Decision models (signal detection, drift diffusion, sequential sampling) let the agent be uncertain about the *values* of decision-relevant states and even control how much evidence to gather — while assuming it already knows **which** portions of the environment are signal and which are noise. Attention studies let the brain weight cues differentially — while instructing the participant what to attend to ("look for the T among the Ls") or over-training the monkey on the feature. Neither models the computation that produces the priority map's contents. Active sampling is the methodological repair: let the participant choose which source to consult *before* choosing an action, which makes attention one action among others and makes "what should I look at?" a decision with its own value function.

---

## Instrumental sampling: the value of a query is derived, and the brain still encodes it separately from reward

Belief formalisation: a sampling action turns a prior belief over the relevant actions/states into a posterior; the query's worth is the expected change, scored by Shannon entropy reduction, `D_KL`, or probability gain. The driver looks at the traffic light and not the cloud because the light is expected to move the belief over `{accelerate, brake}` further.

| Finding | Substrate | Why it matters here |
|---|---|---|
| Lateral intraparietal (LIP) neurons encode the **relative reliability** of competing visual cues and predict which cue the monkey samples | LIP | the priority map is scored by *expected uncertainty reduction*, not only by expected reward |
| The same LIP cells differentiate informative cues of different reliability from **uninformative cues of equal reward probability** | LIP | the dissociation: expected reduction in uncertainty is encoded independently of expected gain, in a task where the two are normally confounded |
| Cue reliability is *learned* by tracking visual prediction errors — how often a cue's prediction is confirmed | temporal–parietal junction, putamen, frontal eye field, intraparietal sulcus (fMRI connectivity) | a cue's epistemic worth is acquired by the same error signal used for value, one level up: the error is on the *prediction*, not on the reward |
| Humans use **targeted** exploration — sampling the higher-uncertainty option when that maximises long-run gain; humans also detect structural change points and upregulate arousal and learning rate there | — | the instrumental case is solved well enough that its normative account is not in dispute |
| Monkeys' exploratory and exploitative saccades differ in frontal-eye-field activity; LIP shows correct temporal credit assignment to the *informative* step of a two-step task | FEF, LIP | credit for a query can be assigned across a delay to the step that only bought information |

**Costs the instrumental account already needs and does not have.** Acquiring information lengthens fixations; changing the attentional set costs cognitive effort and degrades performance where flexibility is required; metacognitive accuracy is imperfect, and uncertainty-based control of behaviour matures slowly with age. A sampling policy is therefore not free even when its value is computable ([[wiki/concepts/cognitive-control.md]]).

---

## Non-instrumental demand: information is bought where it cannot be used

Non-instrumental ("observing") tasks: the animal can see a predictive cue but can take no action on it. Preference for informative over uninformative cues is robust in pigeons, monkeys and humans, and is encoded by **orbitofrontal** neurons and **midbrain dopamine** cells — the same populations that carry reward. Two incompatible readings of what is being bought, and they predict opposite sampling strategies (`T360`):

| Hypothesis | Quantity maximised | Predicted behaviour |
|---|---|---|
| **Early resolution of uncertainty** | accuracy/precision of beliefs, independent of material gain | seek the most *reliable* cue regardless of what it says |
| **Engagement with positive items** | anticipated hedonic state — savouring | seek pleasant-but-less-accurate cues; *avoid* accurate bad news (dread), i.e. information avoidance |

**Reward-based attentional bias is the second hypothesis' mechanism, and it is measurable.** A dopamine prediction error at a reward predictor assigns value to *engaging with the predictor itself*, above and beyond valuation of the rewarded action ([[wiki/concepts/incentive-salience.md]]):

- Sign-tracking rats orient to the reward-predicting light rather than to the magazine that delivers the reward.
- A reward-predictive cue at one location impairs saccades elsewhere; correlates in superior colliculus and LIP.
- Past-reward associations capture attention as irrelevant distractors (substantia nigra / ventral tegmental activation; suppression depends on frontoparietal control) — "reward-based salience", plasticity conferring visual salience with no reward anticipation.
- Monkeys proactively search for **redundant** reward cues — information demand with no predictive utility at all.
- With gain- and loss-avoidance targets matched for informativeness and operant value, object-selective cortex encodes the **gain** targets better while the intraparietal sulcus stays uncertainty-driven; the human N2pc scales with reward probability independently of predictive value.

Read as an architecture: the valence-biased channel and the uncertainty-driven channel coexist in the same selection system and are separable by area — a second instance of the wiki's recurring "two quantities, one selection stage" shape.

**A harder case for the first hypothesis, from the sign-tracking literature.** A cue that predicts reward on **50%** of trials draws *more* sign-tracking than a cue that predicts it on 100% of trials (Anselme, Robinson & Berridge 2013; Robinson et al. 2014a, via Robinson & Berridge 2025, [[wiki/concepts/incentive-salience.md]]). So uncertainty here does not raise the value of *consulting* the cue — it raises the value of **approaching** it, which is not a sampling act at all. Worse for any bonus formulation: cue–reward uncertainty sensitizes the mesolimbic system the way intermittent drug exposure does, so the elevation **survives the resolution of the uncertainty that produced it**. An epistemic drive written as a function of the belief cannot leave a residue; a gain on a cue can.

---

## Curiosity: the laboratory handle on search

- Berlyne's kinds — **perceptual** (specific stimuli), **diversive** (novelty/sensation seeking), **epistemic** (specific topics) — plus a sensorimotor kind the robot-learning literature adds ("how do I make the toy light up?"). Common computational form: *autonomously generated motivation to answer a question in the absence of instrumental incentives*, about either the state of the world or how it can be manipulated.
- Higher curiosity ratings → caudate and substantia nigra / ventral tegmental activation; better memory for the answer, with enhanced ventral-tegmental↔hippocampal connectivity; perceptual curiosity engages frontoparietal control. Trait-curious participants explore scenes with more saccades; curiosity level is decodable from gaze alone, and high curiosity produces faster anticipatory shifts to where the answer will appear.
- **Inverted-U in confidence, not in novelty.** Information-gap theory: curiosity requires a question plus a generated set of candidate answers, so it peaks at *intermediate* confidence that one already knows the answer and falls at both high confidence and near-total ignorance. Memory is what makes search *specific* (epistemic) rather than a non-specific novelty hunt (diversive) — the mechanism by which lifelong interests compound within a domain.
- Aesthetic appreciation as the same variable (intermediate predictability/complexity), plus one dissociation worth holding: ~5% of humans get no pleasure from music with normal music perception and normal monetary-reward responses — a *domain-specific* reward channel on top of the general-purpose one.

---

## The complexity argument, which is the page's real payload

The authors' objection to normative accounts of search (free-energy principle, active Bayesian inference) is not that they are wrong but that they are **blind to the size of the hypothesis space**: quoting Bossaerts & Murawski, in normative theories "a decision problem with two alternatives is not distinguished from one with 2¹⁰⁰ alternatives". The empirical case:

| Evidence | Reading |
|---|---|
| Humans produce inconsistent solutions in moderately complex planning tasks and adopt frugal heuristics using a fraction of the available cues | the normative account does not describe the behaviour it is offered as a theory of |
| Active Bayesian inference scales poorly with problem complexity; non-parametric sampling reduces the cost but still fails on embodied control | the same objection inside machine learning, where it is uncontroversial |
| A humanoid robot with hidden object interdependencies (cylinder reachable only via a stick, plus uncontrollable distractors) learns nothing under external reward, which is too rare | the sparse-and-unknown-reward regime `G72` names |
| The same robot under a **learning-progress** intrinsic reward self-generates goals, moves from hand → stick → cylinder as each becomes a new niche of progress, and abandons distractors from which nothing can be learned | the heuristic substitutes for the optimisation, and the *environment's own couplings* supply the stepping stones |
| Learning-progress architectures reproduce phase transitions in infant vocalisation and tool use; learning-progress-sequenced exercises improve children's learning in schools | the heuristic transfers to the system it was abstracted from |
| Adults freely interacting with games of varying difficulty, with **no instructions**, survey the whole set, settle on games at **70–80% correct** for most of the session, and progress to harder ones | a self-organised curriculum measured in humans, matching the learning-progress prediction ([[wiki/concepts/curriculum-learning.md]]) — **now contested at group level** (`T370`): 186 uninstructed participants given a ladder with an unlearnable rung over-allocated to the *easiest* activity (33.00%, `p < 0.001`) and only 29.59% mastered the ladder, the intermediate operating point marking that subgroup rather than the condition ([[wiki/concepts/learning-progress.md]], Ten et al. 2021) |

**The status claim to hold.** Intrinsic motivations are proposed here as *heuristics for a computational-complexity problem*, not as approximations to a normative epistemic objective. That is a different justification from the one [[wiki/concepts/expected-free-energy.md]] offers (derivation from one free-energy functional) and it licenses exactly what the derivation forbids — several non-commensurable drives, chosen for tractability, with no single quantity they all approximate.

**And the drives are double-edged, by the authors' own summing-up.** In instrumental settings intrinsic preferences generate sampling biases and suboptimal learning; in open-ended settings they are the only available generators of **intermediate goals** and of investigations that would otherwise require implausible optimisation. Any architecture that carries one term for both regimes inherits both signs.

---

## Reading in the core framing

| Element | Latent-graph reading |
|---|---|
| Sampling | the graph's node and edge *set* is known; only edge weights/states are uncertain, so a probe's value is computable by marginalising over a known structure |
| Search | the node set itself is unknown — the agent does not know which variables are variables, which is [[wiki/concepts/node-definition-problem.md]] posed as an action problem |
| Reliability coding in LIP | an edge's *informativeness* stored as a learned property of the edge, updated by prediction error on the prediction rather than on the reward |
| Learning-progress niche | a frontier over the graph: the set of edges the agent is currently getting better at traversing, which moves as the couplings in the environment hand it new reachable structure |
| Non-instrumental demand | the agent pays to resolve an edge it cannot act on — only defensible if the structure will be reused, which is exactly the graph-discovery bet |

**(brainstorm) The distinction gives the wiki a benchmark axis it does not have.** Every epistemic-value ablation in the wiki runs in the *sampling* regime — grid-worlds with a known reward, a known state space and a designated sensing action — and then the result is discussed as if it said something about curiosity. A search-regime harness is cheap to state: no reward at all, an environment with hidden couplings and at least one uncontrollable distractor, scored on the number of *distinct controllable effects* discovered per unit time. `E1`–`E4` have never been run against it; learning progress and competence progress have never been run against a sampling benchmark. Nothing in the wiki says the winner is the same on both.

**(brainstorm) The 70–80% set-point is the most transferable number on this page — and it is now the most contested one.** It is the operating point of a self-paced learner with no teacher, it is what a learning-progress maximiser is *supposed* to converge to, and it is directly checkable against any curriculum a machine learner generates for itself — a target for `G32`'s generator with a human measurement attached.

---

## Open problems

- **No normative theory is posed for search, and this page does not supply one.** The positive proposal is "heuristic preferences over cognitive states", which is a family name and not a decision rule; which heuristic to run in which environment is `G30`, unresolved and here explicitly declined.
- **The sampling/search boundary is not operationalised.** Every real task is partly both, and nothing here measures *how much* structure an agent must already hold before a query becomes priceable. The obvious instrument — vary the size and specificity of the candidate hypothesis set and find where normative planning stops predicting behaviour — has not been run.
- **Whether the brain implements learning progress is untested.** The parallels are behavioural (phase transitions, free-play difficulty ordering); no neural measurement of a learning-progress signal is cited, and the review says so.
- **The two accounts of non-instrumental demand have never been separated in one experiment** (`T360`) — and the same ambiguity taints the dopamine and orbitofrontal correlates, which are compatible with either.
- **Intrinsic preferences' cost in instrumental settings is asserted and barely measured.** Sign-tracking and value-driven capture are the evidence; nobody has priced what an agent loses in a known task by carrying a search-regime drive.
- **Effort is named as the missing half of every sampling policy.** Changing the attentional set costs something, sampling policies are top-down and memory-dependent, and the review defers to the cognitive-effort literature rather than pricing a query in the same units as its expected gain. **One source prices it, and the price is not the one this page expects** ([[wiki/concepts/active-vision.md]], Ballard et al. 1997): a look is charged against the cost of *carrying the value it would replace*, not against uncertainty, and the exchange rate is measurable — 70° of separation between model and workspace moves fixations from 1.3 to 1.0 per block. The direction is wrong for any policy maximising information gain per unit time: the modal human strategy re-acquires information it already has, at 1.0–1.5 s per block, under an explicit speed instruction. So the currency exists; it is a memory-carrying cost rather than an effort cost, and nothing in the sampling literature has that term.

---

## Connections

- **[[wiki/concepts/epistemic-value.md]]** — supplies the regime label those four quantities are silently defined in: `E1`–`E4` are all *sampling* quantities (known state space, known reward, designated sensing action), so the ablation record on that page is evidence about sampling and not about search, and the LIP dissociation here is its one neural datum where expected uncertainty reduction is encoded independently of expected reward.
- **[[wiki/concepts/intrinsic-motivation-typology.md]]** — the space of formulas this page's search regime is the *problem* for, and it re-justifies them: the typology's rewards are proposed here as heuristics for a complexity problem rather than as approximations to any normative objective, which is what licenses several non-commensurable drives at once.
- **[[wiki/concepts/expected-free-energy.md]]** — the target of the complexity objection: a derivation that assigns value to every hypothesis in a space it never counts, so its epistemic term is well-posed and its optimisation is the thing the review says does not scale — a criticism of tractability rather than of the algebra.
- **[[wiki/concepts/priority-map.md]]** — what determines the map's *contents*, which that page leaves open: a candidate location's priority includes its expected reduction of the agent's uncertainty (LIP reliability coding, learned from prediction errors on the cue's own predictions), so a sampling policy is a priority map whose scoring function is epistemic rather than template-similarity.
- **[[wiki/concepts/attention.md]]** — the reframing that makes attention a decision: an eye movement is one action among others whose value is the uncertainty it resolves, which supplies the "what controls attention?" policy that page lacks for the sampling case and explicitly fails to supply it for search.
- **[[wiki/concepts/incentive-salience.md]]** — the valence-driven channel of this page's non-instrumental demand: a cue's motivational gain makes the *predictor* worth engaging with independently of the rewarded action, which is the mechanism behind sign-tracking, value-driven capture and the search for redundant reward cues — information demand with no information in it. It also supplies the case that no belief-indexed epistemic term can produce: an *uncertain* cue is approached more than a certain one, and the elevation outlasts the uncertainty because it is stored as a sensitized gain on the cue.
- **[[wiki/concepts/curriculum-learning.md]]** — the human measurement of a self-paced `λ`: free interaction with games of varying difficulty settles at 70–80% correct with no instructions and progresses upward, which is the competence-frontier pace that page lists as missing, measured rather than proposed.
- **[[wiki/concepts/node-definition-problem.md]]** — what makes search hard rather than merely large: in the search regime the agent does not yet know which variables are variables, so the hypothesis set cannot be enumerated and no expectation over it can be taken.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the two regimes as two phases of one problem: sampling resolves uncertainty *within* a known graph, search decides what the graph's nodes are, and the review's claim is that only the first has a value function.
- **[[wiki/concepts/active-vision.md]]** — the one place a query is priced in the same units as what it buys, and the answer embarrasses the *sampling* framing: an eye movement is charged against the cost of carrying the value it would otherwise have to hold, with a measured exchange rate, and humans re-acquire information they already possess at 1.0–1.5 s per block while instructed to be fast — so the value of a look here is not uncertainty reduction at all.
- **[[wiki/concepts/cognitive-control.md]]** — the cost side the sampling account defers: maintaining and switching an attentional set is effortful, so a query's price and its expected information gain are never compared in the same units anywhere in this literature.
- **[[wiki/concepts/metacognitive-efficiency.md]]** — the precondition an uncertainty-driven sampling policy quietly assumes: the agent must know how uncertain it is, and measured metacognitive accuracy is imperfect and matures late, so a policy that reads its own uncertainty reads a noisy estimate.
- **[[wiki/concepts/general-danger-channel.md]]** — the opposite sign on the same drive: this page's curiosity peaks at *intermediate* confidence and its novelty preference is appetitive, while the measured first response to an unfamiliar object is threat (`T358`), so the two literatures disagree about what an unfamiliar stimulus is worth before it is sampled.
- **[[wiki/concepts/empowerment.md]]** — a candidate for the *search* regime that sidesteps this page's complexity objection instead of answering it: channel capacity from actions to later sensors is computed from local dynamics over the agent's own action set, so nothing is summed over an uncounted hypothesis space, and the resulting drive is terminable without any criterion for what a pattern would be — at the price that it prefers states with many perceptible outcomes rather than states that teach anything, and will not visit a goal state that happens to be poorly empowered (Salge et al. 2013).
- **[[wiki/concepts/expected-value-of-control.md]]** — the schema for the price comparison this page reports is missing: exploration is classed there as *default override*, so a query's expected payoff enters `Σ Pr·Value` and its effort enters `Cost(signal)` in one equation — the same currency this page says the literature never supplies, with the caveat that neither function is given, so the comparison is written down rather than computed.
- **[[wiki/concepts/learning-progress.md]]** — the search-regime heuristic this page endorses, fitted to individuals instead of demonstrated in a robot: a two-term utility `w_PC·PC + w_LP·LP` beats either term alone in ~72% of 382 participants, and the progress weight alone predicts avoidance of an *unlearnable* activity — which is this page's "abandons what it cannot learn from" claim measured, while its 70–80% free-play set-point comes out of the same experiment contested (`T370`).
