# Cognitive Control

**Control is a *task model* held as sustained activity — a pattern coding the current categories, rules and contingencies — broadcast as excitatory bias into the systems that do the work, where it settles a competition those systems were already running.**

> **Provenance.** Miller, Freedman & Wallis 2002, *The prefrontal cortex: categories, concepts and cognition*, Phil Trans R Soc Lond B 357:1123–1136 (`raw/miller-2002-prefrontal-categories-concepts.md`). A review of the authors' own monkey single-unit work (Freedman et al. 2001 categories; Wallis et al. 2001 abstract rules; Asaad et al. 1998, 2000 conditional associations and task sets) framed by the Miller & Cohen 2001 theory of prefrontal function.

The wiki's other control-layer pages ask *what is held* ([[wiki/concepts/working-memory.md]]), *what is selected* ([[wiki/concepts/attention.md]]) and *what binds a cue to an action* ([[wiki/concepts/arbitrary-sensorimotor-mapping.md]]). This page is the layer above all three: what a controller's state has to *contain*, in what format, and by what channel it reaches everything it controls. The answer on offer is unusually specific and unusually cheap to import — **a controller does not route, it biases** — and its central design claim is a claim about *representational format*, not about connectivity.

---

## What the control state codes: four levels, all in one population

Each row is a separate recording result in lateral prefrontal cortex, ordered by how far the code is from the sensory surface.

| Level | Experiment | Result | Why it is not the level below |
|---|---|---|---|
| **Conjunction** (cue × action) | Two cue objects, each instructing a left or right saccade, remapped across blocks (Asaad et al. 1998) | **44%** of randomly sampled lateral prefrontal cells code the *pairing*; cells coding cue alone or saccade alone are fewer. Tuning is **nonlinear** — activity for a combination is not predictable from the other combinations. (Reviewed elsewhere as ~50%; [[wiki/concepts/arbitrary-sensorimotor-mapping.md]]) | A linear cue + action code cannot express a mapping that swaps |
| **Task set** (which task is running) | Blocks alternating between object-matching, spatial-matching and associative rules (Asaad et al. 2000) | Many cells shift **baseline firing** by task; the shift begins in the *fixation* period, before the cue — for some cells at fixation onset, for others ramping as the cue becomes imminent | A baseline offset with no stimulus present cannot be a response to anything |
| **Concrete rule** | Same cue, two rules (spatial matching vs. associative) (White & Wise 1999; Hoshi et al. 1998) | A cell responds to a visual cue under the associative rule and weakly or not at all under the spatial rule, with sensory input and attention matched | The cue is identical; only the rule differs |
| **Abstract rule** | *Match* vs. *non-match*, cued by **juice or a low tone** (match) and **juice or a high tone** (non-match) — same-rule cues from different modalities, different-rule cues from the same modality (Wallis et al. 2001) | Rule coding is **the most prevalent activity across prefrontal cortex**. Same for either cue, for any remembered picture, before the response is knowable, with reward expectation equal for both rules. Monkeys performed above chance **on stimuli seen for the first time** | The cue-modality confound is designed out: nothing physical is shared within a rule, and everything physical is shared across rules |

**The abstract-rule row is the load-bearing one for this wiki.** It is the cleanest existence proof that a rule can be a *represented object* rather than an emergent property of the mapping it licenses (gap G8): the variable being coded has no sensory, motor or reward correlate left after the design's controls, and it transfers to novel stimuli on first exposure. The authors' own efficiency argument is the reason to expect it — solving the task per-modality needs one cell population per modality, so a third modality would need a third population, while an abstract code costs nothing extra.

---

## Categories are written into single-cell tuning, and they are rewritable

Freedman et al. 2001: 3D morphs between three cat and three dog prototypes, blended continuously so that stimuli **near the boundary on opposite sides are physically similar** while same-category stimuli (cheetah, house cat) can be dissimilar. Delayed match-to-category task.

| Observation | Number / detail | What it rules out |
|---|---|---|
| Behaviour is categorical | ~90% correct even at 60:40 blends; dog-like cats treated as cats | Similarity-based responding — the nearer neighbour is across the boundary |
| Neurons match the behaviour | Prefrontal cells differ sharply between 60% cat and 60% dog, and are *similar* between each and its prototype; population tuning shifted toward category over individual stimulus | Physical-shape tuning, which would vary smoothly through the boundary |
| The boundary is learned | Monkeys had no cat/dog experience before training | Innate category |
| **The boundary is replaceable** | Retrained with two new boundaries **orthogonal** to the first (three classes, each pairing one cat with one dog prototype): delay activity separates the new categories and shows **no** trace of the old cat/dog split | A fixed perceptual partition; and a code that merely accumulates categories |

Two consequences a builder should carry. First, **category membership is carried at the level of the single unit**, which the authors flag as a result that did not have to hold — the alternative, an ensemble-emergent property of feature-tuned cells, is what most machine models implement by default. Second, **the same cells are re-partitioned by retraining**, so the category axis is a *state* of the control layer, not a learned feature of the sensory hierarchy. The natural reading is that inferotemporal cortex stores the long-term visual knowledge and prefrontal cortex holds whichever partition of it the current task needs — supported by Tomita et al. 1999, where top-down prefrontal signals are *required* to activate long-term visual memories in inferotemporal cortex. The authors state plainly that the relative inferotemporal contribution is undetermined.

**(brainstorm)** The orthogonal-retraining manipulation is a directly runnable model experiment and the wiki has no analogue of it. Train a network on a categorical boundary in a continuous latent space, then retrain on an orthogonal one, and ask whether the old boundary survives in the representation. A machine model that *keeps* both is doing something the monkey does not — and would be more useful — but the biological result says the control layer's default is to overwrite, which is a capacity story ([[wiki/concepts/continual-learning.md]] reads the same overwrite as failure).

---

## The mechanism: bias, not routing

The Miller & Cohen model, stated as an algorithm:

1. **Bootstrap.** In an unfamiliar situation input flows into prefrontal cortex unfiltered. Reward-related signals — proposed to be dopamine from ventral tegmental area neurons, acting via basal ganglia — strengthen associations *among the prefrontal cells that were active just before reward*.
2. **Complete.** The resulting ensemble is a **task model**: the cues, the internal states, the responses and their relations. Once formed, a *subset* of it (the cues) reactivates the rest (the correct response). Formally a pattern-completion read over a learned association, not a computation.
3. **Bias.** Sustained excitatory output from that ensemble feeds back to the sensory, mnemonic and motor systems that supply its inputs, raising the activity of units representing task-relevant information.
4. **Compete.** Those systems already implement **mutual inhibition** among their units (biased competition, Desimone & Duncan 1995). A small excitatory bias therefore *decides* the local competition: raising the matching units suppresses the rest for free, and activity is steered down the required pathway.
5. **Self-reinforce, then withdraw.** The bias refines the inputs arriving back at prefrontal cortex, so the ensemble stabilises itself. With repeated selection the biased pathway strengthens directly, becomes independent of prefrontal cortex, and the behaviour becomes automatic — control *transfers out* of the controller.

The worked example: cue C1 (*want a beer*) with context C2 (*at home*) evokes response R1 (*get one*); C1 with C3 (*in a pub*) evokes R2 (*ask for one*). One cue, two responses, disambiguated by context — the `if–then` form that is the building block of voluntary behaviour.

| Design property this buys | Why it matters for a machine controller |
|---|---|
| **Control is additive, not architectural** | The controller does not gate, route or rewire; it adds a bias term to systems that keep running their own dynamics. No switching machinery is needed anywhere downstream |
| **Suppression is free** | Because the controlled systems mutually inhibit, "enhance the relevant" and "suppress the irrelevant" are one operation. A machine controller that only adds excitation gets no suppression unless the substrate competes |
| **Control is a fixed point of a loop, not a feed-forward command** | The bias improves its own inputs; the ensemble is stable because it is self-consistent with what it biases |
| **Automaticity is the same mechanism run to convergence** | Control usage is its own training signal for the direct pathway, which is a built-in curriculum from controlled to automatic and a built-in *release* of controller capacity |

**(brainstorm) Where the wiki already has this and does not say so.** H-JEPA's configurator ([[wiki/entities/h-jepa.md]]) modulates a module by injecting extra input tokens that change its connection graph — that is bias-by-additive-input in a transformer, and this page supplies the mechanism it is missing (the downstream competition that turns a small bias into a decision) plus the training story (reward-gated association among co-active controller units) it declines to specify. The competition half is cheap to add: softmax already normalises, so a bias vector added to attention logits *is* biased competition, and the missing piece is only that the bias be a **persistent, task-identified state** rather than recomputed per query.

---

## Sustained activity as a format, not as a buffer

The sharpest transferable argument in the source, and the one the wiki's working-memory pages do not make. Given that long-term knowledge is stored in synaptic weights, why is the *control* variable carried by persistent firing instead?

| Property | Weights | Sustained activity |
|---|---|---|
| Duration | Indefinite | Seconds |
| Scope of influence | Only the neurons sharing that synapse, and only when that circuit fires | Tonic, propagates to every system the population projects to |
| Flexibility | Circuit fires the same way whenever triggered | Change the behaviour by changing the pattern |
| Cost | None at rest | Metabolically continuous; capacity-limited |

Control has to affect *many* circuits at once and change on the timescale of a trial. A weight change does neither: it is local to its synapse and expressed only when that circuit happens to be driven. So persistence is not primarily about bridging a temporal gap — that is a side benefit — it is about having the task's identity in a form that can be **broadcast and swapped** (O'Reilly & Munakata 2000; Miller & Cohen 2001).

**And the capacity limit falls out of the format.** If control is a distributed population code over simultaneously active neurons, then two control states at once impose two patterns on the same units and each degrades the other. The severe capacity limit of controlled processing — versus the unbounded parallelism of automatic processing — is therefore predicted by the choice of carrier, not an extra assumption.

- This is the wiki's only *derivation* of a capacity bound from a representational decision, and it is an interference bound, not a slot bound: it predicts graceful degradation with the number of concurrent control states and no fixed integer ([[wiki/concepts/working-memory.md]], gap G42).
- **It is a different bound from the read-side one.** Gong & Zhang 2024 locate capacity in the softmax denominator — competition among *stored items* at retrieval. This locates it in superposition among *concurrent control states* at maintenance. A machine controller can hit either; nothing in the wiki measures the second.
- **(brainstorm)** It also predicts a specific pathology no architecture here tests for: two task models held together should produce a *blend* — behaviour consistent with neither rule, rather than with one — which is a signature distinguishable from forgetting, and cheap to look for in any model that conditions on a task embedding.

---

## Learning is fast, and its signature is that activity moves earlier in the trial

| Observation | Timescale |
|---|---|
| Novel object→saccade mapping acquired | **5–15 trials** (Asaad et al. 1998) |
| As it is acquired, delay activity coding the forthcoming saccade appears **progressively earlier** — from just before execution/reward to nearly coincident with the cue | Within the same tens of trials |
| Frontal eye field cells acquire selectivity for a searched-for *feature* (e.g. red) | Minutes to one day's training (Bichot et al. 1996) |
| Yesterday's search target still functions as a distractor today, in the neurons *and* in the error rate | Across days (Bichot & Schall 1999) |

**The second row is the one to keep.** The controller's representation of the answer migrates backwards in time toward the earliest event that predicts it — which is exactly the reward-prediction-error shift in dopamine signalling (Schultz & Montague 1997) that the source invokes for the *learning rule*. The same temporal-shift signature appears in the thing being learned and in the teacher.

**(brainstorm)** That coincidence is either a strong hint or a confound, and the wiki can tell which. If the controller's activity shift is *caused* by the dopamine shift, the two must be measurable in the same session with the neural shift lagging the dopamine shift; if instead both are consequences of the same credit-assignment arithmetic (the earliest reliable predictor becomes the address), then in a TD-trained recurrent controller the internal state coding the response should migrate to cue onset **without** any explicit mechanism that moves it — which is a free, runnable check on any meta-RL agent already in the wiki ([[wiki/concepts/meta-learning.md]]).

---

## The lesion picture, and what it says the controller is *for*

- **Dysexecutive syndrome / goal neglect.** Prefrontal damage leaves perception, movement, memory and conversation broadly intact and destroys the ability to stay on task (Baddeley & Della Sala 1996; Duncan et al. 1996). The dissociation is the behavioural signature of a control layer that is *separate* from everything it controls.
- **Behaviour reverts to the strongest available association.** Shallice & Burgess 1991's shopping test: patients execute each cued routine and cannot sequence them, entering irrelevant shops because they passed them. Utilization behaviour: an object in front of the patient is used. Without bias signals, whatever the environment most strongly triggers, wins — which is exactly what step 4 above predicts when the bias term is set to zero.
- **Wisconsin Card Sorting Test** (Milner 1963): the first sorting rule is learned normally and cannot be escaped when it changes. Monkeys with prefrontal lesions show the same (Dias et al. 1996). **The deficit is in replacing the control state, not in forming one.**
- **Conditional learning** is impaired by prefrontal damage in monkeys and humans, and also by *disconnecting* prefrontal cortex from its sensory inputs — [[wiki/concepts/arbitrary-sensorimotor-mapping.md]] carries the ablation table and the caveat that a disconnection deficit does not localise the computation.

---

## Reading in the core framing

| Control element | Latent-graph reading |
|---|---|
| Task model | The currently selected **subgraph** of the meta-graph — which nodes and edges are live for this episode |
| Bias signal | Edge *weights* pushed into the systems that would otherwise traverse by default salience |
| Cue subset completing the model | Pattern completion over the meta-graph: partial evidence retrieves the whole applicable structure — a candidate answer to gap G37 (which stored structure applies?) |
| Abstract rule cell | A **reified edge-type**: a variable naming a relation that holds across instantiations, which is what gap G8 asks for |
| Category boundary | A learned quotient over `x`, held in the control layer and swappable — the partition, not the content |
| Automaticity transfer | An edge that has been traversed enough times becomes a direct edge and leaves the controlled graph |

---

## Open problems

- **Nothing says which task model is retrieved.** Step 2 is pattern completion from a cue subset, which presupposes that the right model is the one the cues most nearly match. That fails exactly where control is most needed — ambiguous contexts, novel situations, and the case where the correct model is the one the environment does *not* suggest (gap G37). The Wisconsin deficit is the biological form of the failure and the model has no account of the healthy case.
- **The bias signal has no addressing scheme.** "Excitatory feedback to the regions that provide input" says which *regions*, not which units within them. For the visual-attention case a feature template supplies the addressing; for "select the neural pathways needed to solve the task at hand" in general, nothing does.
- **How an abstract rule is *learned* is not addressed at all.** Reward-gated association among co-active prefrontal cells explains a conjunction; it does not explain a variable that is deliberately decorrelated from every co-active sensory event, which is what the match/non-match design constructed. The rule cells are demonstrated, never derived. This compounds the same gap on [[wiki/concepts/arbitrary-sensorimotor-mapping.md]]: no source in the wiki supplies an error signal for the abstraction layer.
- **Sharp category boundaries are reported, not explained.** Nothing states what makes prefrontal tuning discontinuous at a boundary that is smooth in the input, and the obvious candidate — the decision read-out feeding back — is untested and would make the categorical code an epiphenomenon of the response.
- **The controller is not vacated by practice, and the theory has no transfer step.** Wood & Grafman 2003 score guided activation as representational, testable and consistent with prefrontal biology, but reject two of its claims: prefrontal neurons respond to *known* actions, and overlearned tasks activate medial and slightly more posterior prefrontal cortex rather than none at all (novel tasks activate anterior prefrontal cortex) — so practice appears to *relocate* the representation within the control layer. The theory is also "not explicit about how these new representations are transferred to the posterior regions that store representations of well-learned behaviours", which is the missing mechanism the whole automaticity story rests on ([[wiki/concepts/controller-knowledge-vs-process.md]], [[wiki/empirical-tensions.md]] T94, gap G51).
- **The withdrawal criterion is unspecified.** "With repeated selection the pathway becomes independent of prefrontal cortex" gives no threshold, no measure of when a behaviour has been handed over, and no mechanism for taking it *back* when the environment changes — which is the operation the Wisconsin test scores.
- **The capacity claim is an argument, not a measurement.** Interference among superposed control patterns is asserted from the format; no number, no degradation curve, no experiment holding two task models at once.
- **The prefrontal/inferotemporal division of labour is undetermined**, stated as such by the authors: category information may be *stored* in inferotemporal cortex and retrieved into prefrontal cortex for use, or held in prefrontal cortex outright, and the recordings reported here cannot separate the two.

---

## Connections

- **[[wiki/concepts/working-memory.md]]** — supplies the reason the store is made of activity rather than weights: a control variable must be broadcast to many circuits and swapped within a trial, which a synaptic change can do neither of — and the same choice of carrier is what predicts the capacity limit, as interference among superposed patterns rather than as a slot count (Miller et al. 2002).
- **[[wiki/concepts/attention.md]]** — answers that page's "what controls attention?" with the mechanism rather than the policy: a sustained prefrontal pattern adds excitatory bias to units representing the expected stimulus, and mutual inhibition among the competitors converts it into selection — so attention is this page's operation applied to sensory cortex, and a machine bias added to attention logits is the direct import.
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — the level below: that page's rule hierarchy tops out at "which input type instructs the action", this one adds a rule with **no** stimulus or action content at all (match vs. non-match, cued across modalities) and the conjunctive-cell number the hierarchy rests on (44% of lateral prefrontal cells coding the cue×action pairing, with nonlinear tuning; Asaad et al. 1998) — and the two sources disagree about what abstraction *buys* ([[wiki/empirical-tensions.md]] T93).
- **[[wiki/concepts/abstract-structural-codes.md]]** — a content-invariant code obtained without a metric: the abstract rule generalises across sensory modality and to stimuli never seen, so `g` here is a relation over the task rather than a position in a space — and the category result adds a property that page's grid candidates lack, a partition that is *overwritten* by retraining on an orthogonal boundary.
- **[[wiki/concepts/population-geometry.md]]** — the geometric statement of this page's category result: sharp boundaries with within-category collapse is a low-shattering, high-abstraction code, and the orthogonal-retraining manipulation is a ready-made test of whether an old dichotomy survives in the geometry after a new one is trained.
- **[[wiki/entities/pbwm.md]]** — the closest implementation and the point where it differs: PBWM gates *what enters* a stripe, this page's controller never gates anything — it adds a bias to systems that keep running, and lets their mutual inhibition decide. The two make opposite predictions about what a controller lesion does downstream.
- **[[wiki/concepts/meta-learning.md]]** — a task model is the outer loop's product held as activity, and the shift of response-coding activity toward cue onset over 5–15 trials is the inner loop learning, visible as a *time* signature rather than as a weight change.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the complement of biased competition: this page gets suppression for free from lateral inhibition among competitors, that page has suppression as an *addressed* signal aimed at specific contents, so the two disagree about whether "stop processing this" needs its own channel.
- **[[wiki/concepts/continual-learning.md]]** — the category-overwrite result read as interference: retraining on an orthogonal boundary erases the previous one from the same cells, so a control layer's default is catastrophic in exactly the sense that page tries to prevent — and here it may be the correct design rather than a failure.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — control-to-automatic transfer is a conversion rate stated in the right units: repeated biasing strengthens the direct pathway until the controller is unnecessary, so a skill's cost is how much control it still consumes.
- **[[wiki/concepts/simulation-based-planning.md]]** — shares the missing policy: what evokes the right task model here is the same unanswered question as what initiates a rollout there, and both currently rely on the situation supplying the cue.
- **[[wiki/entities/h-jepa.md]]** — its configurator is this page's controller with the substrate assumption removed: modulation by injected tokens is additive bias, but a transformer module has no mutual inhibition to convert bias into decision except the softmax, and nothing in it makes the configurator's state persistent and task-identified.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the anatomical decomposition of this page's single controller: the bias signal is emitted by two tiers with disjoint output ports (dorsal → sensorimotor cortex, accumbens core, superior colliculus; ventral → hippocampus, amygdala, hypothalamus, autonomic brainstem, monoaminergic nuclei), which turns "which systems get biased" into a property of *which tier holds the task model* — and its prelimbic→infralimbic goal-directed→habit shift disputes this page's account of automaticity as the controller dropping out ([[wiki/empirical-tensions.md]] T94).
- **[[wiki/concepts/controller-knowledge-vs-process.md]]** — the level above this page: it asks whether the control layer has parameters of its own at all, scores this page's theory against seven rivals on a common rubric, and supplies the two data that dispute its automaticity claim — prefrontal responses to known actions, and an anterior→posterior shift of activation with overlearning rather than a withdrawal.
