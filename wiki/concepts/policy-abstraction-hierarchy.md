# Policy Abstraction Hierarchy

**A rule is abstract to the degree that it selects among *sets of simpler rules* rather than among actions; that ordering is laid out along the rostro-caudal axis of frontal cortex, and — the load-bearing result — every level is searched *in parallel from the first trial*, with a level's involvement withdrawn only when the structure it is looking for fails to be rewarded.**

> **Provenance.** Badre, Kayser & D'Esposito 2010, *Frontal cortex and the discovery of abstract action rules*, Neuron 66:315–326 (`raw/badre-2010-frontal-abstract-action-rules.md`). Human fMRI, `n = 20` (6 further subjects excluded: 4 head motion, 2 never above chance). Unless marked otherwise, everything below is from that source; the rostro-caudal coordinates are inherited from Badre & D'Esposito 2007.

---

## The formalism: policy order

Abstraction here is **policy abstraction** — not sensory abstraction, not temporal scope.

| Order | Object | Form | Example |
|---|---|---|---|
| 1st | Policy | `π : s → a` | circle → left hand |
| 2nd | Policy over policies | `Π : c → π_i` | red border → *use the shape policy*; green → *use the size policy* |
| n-th | | `Π⁽ⁿ⁾ : c → Π⁽ⁿ⁻¹⁾_i` | |

The definition is worth stating precisely because it is the one that makes the levels *countable*: a rule is one order higher exactly when its output is the identity of a rule rather than the identity of an action. A stimulus that is both circular and small cues opposing responses under two independent 1st-order sets, so a 2nd-order rule is not a convenience — it is what makes the mapping a function at all.

---

## The task: a minimal, machine-runnable discriminator for abstraction

The design's whole force is that the two conditions are **identical in every measurable respect except whether a higher-order regularity exists in the reward table**. Subjects were never told a hierarchy might be present.

| | Both sets |
|---|---|
| Stimulus space | 3 shapes × 3 orientations × 2 border colours = **18 unique displays** |
| Response space | 3 buttons; deterministic, one correct button per display |
| Exposure | 360 trials per set, 6 runs, each display 20× |
| Feedback | Auditory, correct/incorrect, after a variable 0/1/2 s delay (so stimulus and feedback BOLD separate) |
| Instructions | Identical; no hint that structure exists |

| Set | Reward table | Minimal description |
|---|---|---|
| **Flat** | The 18 mappings arranged so that no higher-order relation holds | 18 independent 1st-order rules |
| **Hierarchical** | Colour A ⇒ only shape determines the response; colour B ⇒ only orientation does | 1 second-order rule (colour → dimension) + 2 × 3 first-order rules = **7 rules instead of 18** |

**(brainstorm)** This is a benchmark spec, not just an experiment, and the wiki has nothing equivalent. Every abstraction benchmark here ([[wiki/entities/arc-agi.md]]) varies the *task*; this varies only the *compressibility of the reward table* while holding the observation distribution, action space, trial count and instructions fixed. Any agent — including a language model or an RL agent — can be run on both and scored by the battery below. The Flat condition is the control that almost every claim of "the model learned an abstraction" in the machine literature lacks: it removes the structure without removing anything else.

---

## Behavioural signatures of having found the abstraction

Six measures, all computable from a learning curve alone, and therefore all portable to a machine learner:

| Signature | Prediction | Result (Hierarchical vs Flat) |
|---|---|---|
| Terminal accuracy | Generalization acquires more mappings | **84% vs 58%** (`F(1,19)=26.3, p<10⁻⁴`) |
| Proportion of individual rules learned | Same | **72% vs 43%** (`F(1,19)=14.6, p<.005`) |
| Learning trial (presentations before a given mapping is known) | Earlier | earlier (`t(19)=2.1, p=.05`) |
| Max 1st derivative (learning speed) | Larger — generalization is a jump | larger (`F>9.0, p<.01`) |
| Max 2nd derivative (change in speed) | Larger | larger (`F>9.0, p<.01`) |
| Sigmoid fit: slope `α`, offset `β` | Steeper, earlier step | `α` larger (`Z=2.5, p<.05`), `β` smaller (`Z=−2.9, p<.005`), goodness-of-fit equal (`Z=−0.75, p=.46`) |

**The specificity control is the part to keep.** A faster overall curve proves nothing — the Hierarchical set is simply easier. So: define a *known 2nd-order set* as a colour for which all 9 constituent 1st-order rules were learned (this never occurred in the Flat set). Then

- members of known 2nd-order sets are learned earlier than Flat rules (`t(19)=3.8, p<.005`);
- **within the Hierarchical set**, members are learned earlier than non-members (`t(19)=2.5, p<.05`);
- non-members are indistinguishable from Flat rules (`t(19)=1.5, p=.2`).

So the speed-up is not a property of the condition, it is a property of *those specific edges covered by an acquired abstraction*. **(brainstorm)** This is a per-edge attribution test and it is the honest version of a transfer claim: it demands that the benefit appear only where the abstraction applies, and that the un-covered edges in the *same* run behave like the control condition. No wiki architecture has been scored this way; the closest analogue would be masking a learned rule variable in a trained model and showing the loss increase falls only on the covered subset.

---

## The anatomy: one level per band, fixed by position

Regions of interest defined *a priori* from an independent dataset (Badre & D'Esposito 2007), where they showed parametric increases in 1st- through 4th-order control:

| ROI | Coordinates | Level in the prior study | Hierarchical vs Flat here |
|---|---|---|---|
| **PMd** — dorsal premotor | −30 −10 68 (~BA 6) | 1st-order | **no difference** (`F=.4`) |
| **prePMd** — dorsal anterior premotor | −38 10 34 (~BA 6/44) | 2nd-order | **difference** (`F(1,19)=5.0, p<.05`) |
| **mid-DLPFC** | −50 26 24 (~BA 9/46) | 3rd-order | no difference (`F<.9`) |
| **FPC** — frontal polar | −36 50 6 (~BA 10/46) | 4th-order | no difference (`F<.9`) |

The whole-brain task-vs-baseline contrast reproduced the full rostro-caudal band structure plus SMA, anterior insula, superior and inferior parietal lobules, and bilateral caudate and anterior putamen.

**The selectivity is the result, not the activation.** Only the band whose order matches the order actually present in the reward table (2nd) distinguishes the conditions. Two bands *above* it are active but condition-indifferent. So the level is addressed by the structure of the problem, not by its difficulty — and the mapping from "the task has order `k`" to "band `k` differentiates" is precise enough to be a design constraint.

---

## The load-bearing result: levels are searched in parallel, and pruned by reward

Two accounts predict the same endpoint difference in prePMd and are told apart by its *time course*:

| Account | Prediction for prePMd |
|---|---|
| **Serial / bottom-up** — search for a 2nd-order rule begins only once 1st-order rules are known | At baseline early; rises late, and only in the Hierarchical set |
| **Parallel** — all levels are searched from the outset; a level disengages if unrewarded | Above baseline early in **both** sets; sustained in Hierarchical, **declining** in Flat |

The data give the second, three ways:

1. **Beginning phase:** PMd *and* prePMd both above baseline (`t(19)>3.9, p<.001`) with **no** difference between Flat and Hierarchical (`F<1.9`) — prePMd is engaged in the condition where no 2nd-order rule exists to find.
2. **Middle and End:** the difference emerges (`F(1,19)=4.2`, then `6.4`, `p<.05`) and it is driven by a **decline in the Flat set** (`F(1,19)=4.3, p<.05`) with no change in Hierarchical (`F=.05`). Confirmed on performance-equated rather than time-equated bins (ROI × set `F(1,19)=12.4, p=.002`; ROI × epoch `F(2,38)=12.6, p=.0001`; prePMd differs at PE-2, PE-3 but not PE-1).
3. **Brain–behaviour:** *early* prePMd activity, **collapsed across both conditions**, predicts across subjects the eventual Hierarchical−Flat difference in learning trial (`R=.51`), terminal accuracy (`R=.56`), max 1st derivative (`R=.51`), max 2nd derivative (`R=.39, p=.09`). PMd predicts none of them (`R<.3, p>.21`). Early activity in the band that searches for abstractions predicts who finds one; early activity in the band that learns the concrete edges does not.

Late in learning PMd *rises* for the Hierarchical set (`F(1,18)=4.9, p<.05`) — the concrete layer ends up carrying more, not less, once the abstraction has pruned it.

**(brainstorm) What this specifies for a builder.** The architecture is a fixed stack of `k` candidate-structure searchers, all running from trial 1 on the same input stream, each hypothesising relations of its own order, with per-level credit assignment that attenuates a level whose hypotheses go unrewarded. This is not a router (nothing decides which level to use), not a curriculum (no level waits for another), and not a bandit over levels (all levels pay their cost every trial). Its cost is `O(k)` in fixed compute and its benefit is that the correct level is found in the time it takes to *reject* the others, rather than after the levels below it converge. Every hierarchical machine architecture in the wiki does the opposite — options/subgoals are trained after or above a converged base policy — and the biology says the expensive thing (running all levels always) is what buys the step-shaped learning curve. The concrete import: give each level its own scalar engagement gain, drive it by the reward attributable to that level's hypotheses, and let it decay rather than gating it on a criterion.

---

## The second disengagement trigger: a level withdraws when its output stops varying

> **Companion.** Matsuzaka, Akiyama, Tanji & Mushiake 2012, *Neuronal activity in the primate dorsomedial prefrontal cortex contributes to strategic selection of response tactics*, PNAS 109:4633–4638 (`raw/matsuzaka-2012-dmpfc-response-tactic-selection.md`). Two *Macaca fuscata*, single units: 330 posterior medial prefrontal (pmPFC), 225 pre-SMA, 185 SMA response-period neurons, plus 260 in cingulate cortex. Everything in this section is from that source.

**The task, in this page's formalism.** Two-choice reach; cue colour says which target (red → right, green → left); the cue appears either ipsilateral to the correct target (**concordant** — "reach toward the light") or contralateral (**discordant** — "reach away from it"). Each of *reach-toward* / *reach-away* is a 1st-order policy over the same cue; the mapping from the cue to which of them is live is the 2nd-order rule. The authors call the 1st-order policies **tactics** and define the distinction exactly as this page defines order: action selection is "what to do", tactic selection is "the internal protocol of *how to decide* what to do".

| Condition | Live tactic set | Action still varies? | pmPFC response-period population |
|---|---|---|---|
| Concordant + discordant randomly mixed | 2 | yes | Full; **51%** (167/330) differentiate the two tactics (pre-SMA 35%, SMA 26%) |
| Concordant-only (after 2 wk retraining) | 1 | yes | Task-related neurons per penetration **drop** (`p < 0.01`, χ²); pre-SMA and SMA unchanged |
| Mixed again | 2 | yes | **Returns to its original size** — the drop is not electrode damage |
| Discordant-only (after 2 wk retraining) | 1 | yes | Drops again |

Error rate was 99–100% in every condition and the reach direction varied trial to trial throughout, so what was removed is the *choice of tactic* and nothing else.

**Four controls that make this a statement about level engagement rather than about anything cheaper:**

| Alternative account | How it is excluded |
|---|---|
| **Response conflict** | Three ways: 3 months of training abolished the 42 ms discordance cost in reaction time (multiple regression finds no concordance effect) and there is no Gratton sequential-conflict effect; the *majority* of selective cells prefer the concordant (no-conflict) trials; and the maximal-conflict condition — discordant-only — is one of the two that silences the population. In the cingulate cortex, where conflict monitoring is conventionally placed, **5 of 260** task-related neurons were concordance-selective |
| **Rule form (spatial vs. colour-conditional)** | Control experiment recolouring the cue so cyan = *reach toward* and blue = *reach away*: the tactic set is unchanged while the rule changes from spatial to colour-conditional. Only **4%** (13/330) of pmPFC cells are rule-selective. The code names the tactic, not the rule that selects it |
| **Target selection** | With a delay inserted between tactic determination and the target cue, **16 of 41** pmPFC neurons carry tactic selectivity during the delay, with no target yet knowable |
| **Motor or sensory identity of the area** | pmPFC lies rostral to pre-SMA, does not respond to visual or tactile stimuli outside the task, and microstimulation evokes no arm or eye movement — so it is neither pre-SMA nor the supplementary eye field |

Timing: the pmPFC ensemble separates the two tactics at **125–145 ms**, well before reaction times of 247–313 ms; the 167 target × tactic cells predict the impending response combination at **>95%**.

**What this adds to the parallel-search story.** Badre et al. give one disengagement trigger — a level withdraws when *no structure of its order exists to be found*. This is a second, and it fires in the opposite regime: here the 2nd-order structure is fully known and correct, and the level withdraws because **its output has become constant**. Both collapse into one rule that a builder can implement directly:

> A level is engaged iff it has a live decision — i.e. iff the entropy of its output over recent trials is non-zero.

**(brainstorm)** That is a computable engagement gain and it is *not* any of the quantities an architecture would reach for first. Error, difficulty, conflict and uncertainty are all equated across the conditions here or run backwards (the single-tactic conditions are the easier ones and reaction times *fell*), while output entropy tracks the population exactly. The concrete import into the parallel stack this page describes: gate level `k`'s cost on a running estimate of the entropy of level `k`'s own output, so a stack of `k` searchers costs `O(k)` only while `k` levels are actually deciding something, and collapses toward `O(1)` as the task's structure is pinned down. No architecture in the wiki computes this (gap G58).

**Two caveats the source itself supplies.** (i) The measure is the *number of task-related neurons per penetration*, not per-neuron firing rate — what withdraws is participation in the task representation, not activity. (ii) The single-tactic blocks also made the cue→target spatial relation constant, so the monkeys could have developed an automatic stimulus-response habit; the authors read the reduced single-tactic reaction times as evidence they did, which makes the withdrawal partly a controlled→automatic transfer and not purely the removal of a choice ([[wiki/empirical-tensions.md]] T94). The two readings are separable by a design in which the tactic is fixed but the cue→target relation is not, which was not run.

---

## The interface between levels: the resolved variable, not the operands

> **Companion.** Awan, Mushiake & Matsuzaka 2020, *Neuronal representations of tactic-based sensorimotor transformations in the primate medial prefrontal, presupplementary, and supplementary motor areas*, Front. Syst. Neurosci. 14:536246 (`raw/awan-2020-tactic-based-sensorimotor-transformations.md`). Same two *Macaca fuscata* and the same laboratory as the 2012 result above; the neuron set overlaps Matsuzaka et al. 2016. Analysed here: 153 pmPFC, 113 pre-SMA, 73 SMA neurons, **mixed-tactic condition only**.

The 2012 result says *which* level holds the tactic. This one says **what each level along the rostro-caudal chain is allowed to see** while the tactic is being applied to a cue.

**Task.** Colour of the central fixation LED cues the tactic (cyan = pro-reach, blue = anti-reach), 0.5 s, then a 1–1.5 s delay, then one of two buttons is lit and simultaneously a go tone sounds. Tactic and cue are therefore separated in time, and the action is computable only at the moment of the cue. Gaze is fixed at the centre throughout, so the cue position is not confounded with an eye movement.

**Measure.** Time-resolved variance partition, not spike-count selectivity: `IFR(t) = a₁(t)·tactic + a₂(t)·action + a₃(t)·cue-position + b(t) + ε(t)` in a 200 ms window stepped by 20 ms; per-factor **coefficient of partial determination** `CPD(X,t) = (SSE_partial − SSE_full)/SSE_partial`; population mean baselined to the pre-cue period and tested against 10 000 permutations at a 99% confidence interval.

| Area | Tactic | Cue position | Action | Reading |
|---|---|---|---|---|
| **pmPFC** (rostral) | Yes — selection, delay and response periods; onset time varies neuron to neuron | **Yes**, response period | Yes, response period | Holds all three operands of the transformation, so the binding `action = f(tactic, cue)` can be computed here and only here |
| **pre-SMA** | Yes — delay and response, onset varies | **No** — not significant at the population level | Yes, response period | Receives *which protocol is running* and *what was decided*, never the sensory argument the decision was made from |
| **SMA** (caudal) | Minority of cells during the delay; population mean does not sustain it to the response | No | Yes, strong, from go-signal onset | Receives only the result |

**The load-bearing null is the pre-SMA cue-position cell.** It is not an absence of spatial capability: earlier recordings find pre-SMA neurons spatially tuned during sequential and free-choice reaching. The authors' account is architectural — pre-SMA gets few direct parietal projections and is fed mostly by prefrontal cortex, so its visuospatial input is *gated by* pmPFC, and when pmPFC is engaged (which, by the 2012 result, happens exactly when more than one tactic is live) pre-SMA is relieved of holding the argument at all. They call the rostral→caudal handover **dynamic supervisory control**: pmPFC integrates tactic with cue and determines the action; pre-SMA implements it; SMA executes; supervision lapses once execution begins.

**(brainstorm) What this specifies for a builder, and it contradicts standard practice.** Every hierarchical controller in the wiki — options, feudal manager/worker, PBWM stripes ([[wiki/entities/pbwm.md]]), any two-level policy — hands the lower level a *goal or context vector alongside the same observation the upper level saw*. The biology hands down a strictly narrower interface: the abstract variable (`tactic`) plus the resolved output (`action`), with the observation withheld. Three consequences worth testing:

- **Variable binding happens at exactly one level.** If only one level ever holds `{rule, argument, result}` simultaneously, the composition step has a unique address, and the "where does binding occur" question has an answer that is anatomical rather than emergent — where PBWM makes binding a property of *which stripe is gated* ([[wiki/entities/pbwm.md]]), this makes it a property of *which area holds all three terms at once*.
- **Withholding the observation is a credit-assignment device.** A worker that cannot see the cue cannot learn a shortcut mapping cue→action that bypasses the manager, which is the standard failure mode of feudal architectures (the worker solves the task and the manager's goal channel goes unused). The biology enforces non-bypassability by *wiring*, not by a loss term.
- **What the level below still needs the tactic for.** pre-SMA gets the action already determined, yet still codes the tactic through the response period — so the tactic is not merely an intermediate consumed upstream. **(brainstorm)** The cheapest account is that the implementation stage is parameterised by the protocol (timing, vigour, expected sensory consequence of a reach *away from* a lit target differs from one *toward* it), i.e. the downstream module receives the abstract variable as a *mode setting* rather than as an argument to re-evaluate.

**Two cautions.** (i) The design has no single-tactic condition, so this paper cannot itself show the pre-SMA null is contingent on pmPFC engagement — that inference is imported from the 2012 study and from the discrepancy with earlier pre-SMA recordings; the discriminating experiment (record pre-SMA cue-position CPD under mixed vs. single-tactic blocks) is not run ([[wiki/empirical-tensions.md]] T111). (ii) All three areas are recorded, but never simultaneously and never with an interaction test between them, so "gated by" is an anatomical inference from projection densities, not a measured directional influence.

---

## The frontostriatal loop is common across levels

Stimulus-locked striatal activity (caudate and anterior putamen) *increased* with learning for the Hierarchical set but not the Flat (`F(1,19)=6.9, p<.05`; left putamen `t=2.2`, right caudate `t=2.4`, left caudate `t=1.9, p=.07`) — the opposite sign from prefrontal cortex, and consistent with the striatum accumulating what the cortex has found.

Granger causality on the BOLD series:

`putamen → {PMd, prePMd} → caudate`

with putamen → cortex at `p<.05` and cortex → caudate at `p<.0005`, and — the informative null — **no difference between rule sets** (`p>.18`) and no change across the course of learning.

So the *dynamics* of the learning machinery are identical at both levels of abstraction; only the cortical band that participates changes. **(brainstorm)** That is the cheapest possible answer to "what does a second level of abstraction cost": one more copy of the same cortico-striatal loop, wired to a more anterior cortical patch, with the same update rule. It is also a direct answer to the long-running frontal-vs-striatal precedence dispute (Graybiel 1998: cortex finds patterns, striatum consolidates; Houk & Wise 1995: striatum finds contingencies worth cortical processing) — the measured system is bidirectional, with the two striatal territories on opposite sides of the cortex, and stable throughout learning.

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| Flat vs Hierarchical reward table | The same observation distribution over two latent graphs, one factorizable and one not |
| 2nd-order rule | A reified edge-*type* — a node whose value names which relation is live (gap G8) |
| Parallel multi-level search | Simultaneous hypothesis search at several factorization depths, rather than a routing decision (gap G12, gap G5) |
| Withdrawal of prePMd in Flat | The learner's own estimate that *no structure exists at this depth* — computed within ~120 trials and without ever being told |
| Rostro-caudal band | Depth of factorization as an **anatomical address**, not a learned variable |

---

## Open problems

- **The credit signal per level is not named.** Something must decide that prePMd's hypotheses are going unrewarded while PMd's are not. Reward is scalar and shared; the two levels see the same feedback. Nothing in the source says how the reward is attributed to a level, and this is the same unnamed error signal that [[wiki/concepts/arbitrary-sensorimotor-mapping.md]] and [[wiki/concepts/cognitive-control.md]] both record as missing for the abstraction layer. **(brainstorm)** The one clue is asymmetric: the level that *should* disengage is the one whose hypothesis space contains no consistent member, so the natural quantity is not reward but the residual inconsistency of the best hypothesis at that order — computable without knowing the right answer, and untested. Matsuzaka et al. 2012 supply a *second* trigger that needs no credit assignment at all — the level's output entropy — but it only covers the case where the level's rule is already correct, so the two triggers together still leave the unrewarded-hypothesis case unexplained.
- **Engagement is slow, and nothing says on what timescale it should be.** The pmPFC population withdrew and returned only across **two-week** retraining blocks, so the gain is a learned property of the task *distribution*, not a per-trial gate. No experiment interleaves single- and mixed-tactic blocks on a trial-by-trial schedule, which is what would decide whether the engagement signal is an online entropy estimate or a consolidated statistic — and the two make very different architectural demands (a register updated each trial vs. a slow weight).
- **Two bands were active and never differentiated.** Mid-DLPFC and FPC are engaged throughout and distinguish nothing here. Either they search orders 3 and 4 fruitlessly in both conditions (which the parallel account predicts, and which fMRI cannot separate from a task-general signal), or they do something else entirely. The design has no order-3 condition, so the ladder above 2 is untested in this paradigm.
- **Parallel search is inferred from a decline, not observed.** The evidence that prePMd is *searching* early is that it is active early and its early level predicts later success. No measure shows what hypothesis it holds, and an alternative reading — prePMd is engaged by any unfamiliar task and habituates faster when the task is easier — is only partly excluded (the Hierarchical set is the easier one, and it is the one that does *not* decline).
- **The stack is fixed, and nothing says where its depth comes from.** Four bands, assigned by anatomy. A learner facing a 5th-order problem has no described mechanism for growing a level, and one facing a 1st-order problem pays for four anyway. Whether the depth is developmental, or whether the bands are a continuum discretised by the ROI choice, is not addressed.
- **fMRI cannot separate searching for a rule from executing one.** Every contrast here is stimulus-locked activity on correct trials; both processes are present in the same window throughout the middle of learning.

---

## Connections

- **[[wiki/concepts/cognitive-control.md]]** — supplies the axis that page's single controller lacks: control states are ordered by whether their output names an action or names another control state, that order is laid out rostro-caudally, and the band engaged is fixed by the *order of the structure in the task* rather than by its difficulty. It also sharpens that page's unspecified withdrawal criterion — withdrawal is graded, level-specific, and triggered by a level's hypotheses going unrewarded rather than by the behaviour becoming automatic (Badre et al. 2010).
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — the same three-level rule ladder (exemplar / higher-order rule / strategy) re-derived as a policy-order hierarchy with the levels made countable, and it disputes that page's *learning-selective* classification of prefrontal decline: prefrontal activity declines during learning only when the rule being learned is 1st-order, and is **sustained** throughout when a 2nd-order rule is genuinely present — so the classical learning/execution dissociation may be an artefact of studying only flat mappings. It also localises that page's transformation to a single station and denies the sensory argument to everything downstream of it (Awan et al. 2020).
- **[[wiki/concepts/latent-graph-discovery.md]]** — a measured search policy for the framing's central problem: run hypothesis search at every factorization depth concurrently from the first observation and let unrewarded depths decay, rather than deciding which depth to search. It also supplies the framing's cleanest behavioural discriminator — two reward tables over an identical observation and action space, differing only in whether a compressing latent exists.
- **[[wiki/entities/c-ts-model.md]]** — the computational model of the same phenomenon and the source of a direct disagreement about its cost: C-TS has subjects *imposing* a context→task-set hierarchy where none is rewarded and paying a measured price for it, while this page's prefrontal signal *withdraws* from a rule set with no higher-order structure within ~120 trials ([[wiki/empirical-tensions.md]] T110). Both agree the hierarchical hypothesis is entertained from the outset.
- **[[wiki/entities/pbwm.md]]** — the architecture this result constrains: PBWM's stripes are homogeneous, and the biology says the level of abstraction a loop searches is fixed by *which cortical band* sits in it, with all bands running at once and the same striatal update rule at every level — so the machine form is `k` banks of stripes, differing only in what they take as input, all gated from trial one. A second constraint from the same medial-wall recordings: the interface between two such loops is a *narrowing* — the caudal loop gets the abstract variable and the resolved action, never the observation — which this model has no analogue of, since every stripe reads the same input layer (Awan et al. 2020, gap G59).
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — quantifies what abstraction buys in the units that page asks for: with the abstraction available, 7 rules replace 18, terminal accuracy goes 58% → 84%, and the gain is attributable *per edge* to those covered by an acquired higher-order rule.
- **[[wiki/concepts/representation-probing.md]]** — this page's engagement gain is that page's worst confound made concrete: a level whose output has stopped varying has *no detectable representation of the task* in the tissue that computes it, reversibly and in the same animals, so a null probe result measures the task distribution rather than the model (Matsuzaka et al. 2012). And it supplies that page's per-factor variance-partition measure (coefficient of partial determination in a 200 ms sliding window, permutation-tested), which reports all competing task factors at once instead of decoding one (Awan et al. 2020).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — supplies the monkey medial-wall region that carries this page's tactic level (posterior medial prefrontal cortex, rostral to pre-SMA, sensory-unresponsive and microstimulation-silent), and separates it from the cingulate cortex, where 5 of 260 task-related neurons carried the tactic distinction. That region is also the only medial-wall stage that holds tactic, cue position and action simultaneously, which is what makes it the address of the binding (Awan et al. 2020).
