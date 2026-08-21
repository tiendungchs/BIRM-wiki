# Event Segmentation and Event Schemata

**Cut a continuous sensorimotor stream into discrete units by watching which predictive encodings are active: an *event* is a set of encodings that holds over an extended period, an *event boundary* is a significant lasting change in that set.**

This is where the wiki's graph gets its **nodes and edges** when experience arrives as a continuous stream rather than as pre-tokenised states. Every task in [[wiki/concepts/latent-graph-discovery.md]] so far assumed the discretisation was given. Source: Butz 2016, unifying the theory of event coding (Hommel et al. 2001) with event segmentation theory (Zacks et al. 2007).

---

## The set-based definition

| Term | Definition | Graph reading |
|---|---|---|
| **Event** | an active set of predictive encodings applying over an extended period | a **node** (a state that persists) |
| **Static event** | non-empty set of *spatial* + *top-down* encodings, no change predicted | a node with no self-transition — a scene |
| **Dynamic event** | the above plus *temporal* encodings predicting change | an **edge in progress** — a transition being traversed |
| **Event boundary** | a state at which encodings become applicable or stop being applicable | a **node boundary** — where one state ends and the next begins |
| **Event schema** | ⟨conditional encodings, event encodings, final event encodings⟩ | a **typed edge**: precondition → transition → postcondition |
| **Episode** | a set of event schemata and their typical ordering in time | a **path**, compressed into a single reusable encoding |

The definition is *derived*, not stipulated: it needs no segmentation module, only a change detector over the active set of [[wiki/concepts/predictive-coding-free-energy.md]] encodings. One detector then catches a wide and otherwise heterogeneous range of boundaries:

| Boundary kind | Example | Which encoding changes |
|---|---|---|
| motion onset / offset / reversal | a person starts running | temporal |
| appearance / disappearance | an object is occluded then revealed | top-down + spatial |
| property change | a bottle becomes light when emptied | top-down |
| affordance change | an object rotates into a graspable orientation | spatial → enables new temporal |
| contact | hand reaches the object, distance → 0 | spatial |

---

## Event schemata are the wiki's missing edge type

The triple ⟨condition, event, final⟩ is precondition–action–effect. Three things follow that the wiki's plain (node, edge, label) formalisation does not supply:

- **Backward chaining is free.** Because the *final* encodings of one schema are the *conditional* encodings of the next, schemata chain inversely: given a desired final event, activate whatever establishes its preconditions, recursively. This is path search expressed as constraint propagation rather than as forward rollout — "no food in reach, food consumption is the goal ⇒ find food, move it into reach". Same structure as hierarchical model-based reinforcement learning, without an explicit option framework.
- **Multi-scale nodes come for free.** Repeated schema clusters compress into *episodes* (eating, drinking, walking, grasping-to-hold), which themselves compose in parallel, in sequence, or **recursively** — "attending a lecture" ⊂ "studying at university" ⊂ "working on a career". This is exactly the coarse graph that jumpy, multi-scale planning needs ([[wiki/concepts/simulation-based-planning.md]]), obtained by compression of experience rather than by hand-designed temporal abstraction.
- **Partial observation is enough to identify the edge.** Because encodings co-occur systematically, seeing a fragment licenses inference of the whole episode — pantomime, occluded action, a movie shot implying years. Recognition and goal attribution are the *same* inference: activate the episode encoding that best explains the observed fragment. Action understanding and plan recognition are one mechanism.

**Motor primitives fit the slot.** Habitual, dynamic motion primitives are dynamic-event encodings; the schema's conditional encodings say when a primitive applies, and the mismatch between achieved and desired final event *is* the reinforcement signal. This makes the affordance-competition view (objects afford competing habitual interactions, arbitrated by current motivation) a statement about which edges are currently active in the graph.

---

## How boundaries get detected

Butz 2016 states plainly that deriving segmentation from free-energy inference **remains a future challenge**. Three working mechanisms are offered instead, plus one that segments without a detector at all:

| Mechanism | How it works | Cost |
|---|---|---|
| **Multiplicative gates (long short-term memory)** | a near-linear unit accumulates evidence; a saturating non-linear unit decides when the accumulation is passed on; identity recurrence maintains it until further notice. Linear part ≈ event progression, gate ≈ event boundary | trained by backpropagation through time — non-local, so the biological story is unpaid |
| **Explicit boundary monitors** | watch the continuous activation of predictive encodings; flag onset after prolonged inactivity, or cessation after prolonged activity | robust under very large sensory noise (demonstrated on doorway detection in the four-rooms task); but the thresholds are hand-set, not learned |
| **Driver/modulator wiring** | multiplicatively interacting predictive encodings, distinguishing driving from modulating inputs | shows the interaction is *expressible* in a predictive-coding substrate; not shown to segment anything |
| **Epistemic-uncertainty monitor** | run the same predictor `k` times under random dropout on the weights, take the variance across the `k` predictions as prediction uncertainty, threshold it. `k = 32` in the implementation (Gal & Ghahramani 2016; Kendall & Gal 2017) | still a hand-set threshold, but on a quantity that is *not* prediction error — and the one that turns out to matter more (Nguyen et al. 2025) |
| **Dynamical priors** | in a hierarchical dynamical model, the coupling between orders of motion (generalised coordinates) *is* what parses the stream: cutting those within-level self-connections in a synthetic songbird preserves frequency tracking but destroys sequential structure — the stream stops being segmented at all (Friston & Kiebel 2009) | no boundary is ever named or read out; segmentation is implicit in the flow, so nothing downstream can be indexed by it |
| **Batch optimal transport (offline, no detector)** | Segment the *whole corpus at once*: solve `min_Γ ⟨C,Γ⟩ + α·R_temp(Γ) + λ·D_KL(Γᵀ1_n ‖ q)` for a soft frame→skill assignment, where `C` is visual dissimilarity to `K` skill prototypes and `R_temp` is a Gromov–Wasserstein term penalising two frames within `nr` steps being assigned to different skills; boundaries are wherever `argmax_k Γ*_tk` changes (Xu & Gould 2024, as used by [[wiki/entities/hisd.md]]) | No boundary variable and no threshold at all — but the granularity knob is *explicit and interpretable*, since the radius `r` sets the minimum expected segment length. Costs: needs the whole trajectory set offline, a maximum skill count `K`, and pre-extracted features, so it cannot run on a stream |

The honest summary: the *definition* of a boundary is principled and the *detector* is not. The dynamical-prior row sharpens what is missing: a system can *behave* as if segmented without any explicit boundary variable, and the surprise of the lesion result is that this implicit route matters **more** than the top-down structural prior.

---

## The control signal is not one signal — error and uncertainty are dissociable

> Source: `raw/nguyen-2025-event-segmentation-mechanisms.md` — Nguyen, Etzel, Bezdek & Zacks, bioRxiv 2025.07.07.663487 (eLife 107955, 2026). 45 participants, fMRI during naturalistic video; human boundaries normed separately (30 raters, Bezdek et al. 2022); mean event length 21.4 s. Boundaries also generated by two computational models and used as regressors, so the two candidate control signals are measured *separately* rather than inferred from behaviour.

Every detector above assumes there is **one** quantity to threshold. Event Segmentation Theory says that quantity is prediction *error*; Baldwin & Kosie 2021 say it is prediction *uncertainty* — the model's confidence in its own prediction, independent of whether the prediction turns out wrong. The two co-occur in natural activity, so behaviour alone cannot separate them.

**Operationalisation.** Both models maintain one active event representation that continuously predicts the next scene vector, and both fire a boundary when an inference process, once triggered, *switches* representations. Only the trigger differs:

| Model | Trigger quantity | How computed |
|---|---|---|
| Error-driven | prediction **accuracy** | Euclidean distance ‖observed − predicted‖ over scene vectors, thresholded |
| Uncertainty-driven | prediction **precision** | epistemic variance across 32 predictions generated by random dropout on the model's own weights, thresholded |

**Result 1 — both signals are real, and uncertainty is the stronger one.** Regressing human boundary density jointly on both model densities (Gaussian kernel, bandwidth 4.45 s):

| Predictor | t (df = 1636) | Significance |
|---|---|---|
| Uncertainty-driven density | **14.32** | p < .001 |
| Error-driven density | **5.14** | p < .001 |
| correlation between the two predictors | 0.499 | 95% CI [0.401, 0.607] |

Each carries unique variance despite r ≈ 0.5 between them. Together they explain ~20% of variance in human boundaries against a ~36% ceiling set by inter-rater reliability (~0.6) — so ~55% of the *explainable* variance is accounted for by these two triggers alone.

**Result 2 — the two triggers drive different networks.** Fitting finite-impulse-response models to parcel-wise pattern dissimilarity (1 − r between successive voxel patterns within a Schaefer-400 parcel), ±20 s around each boundary type:

| | Error-driven | Uncertainty-driven | Both (shared) |
|---|---|---|---|
| Early pre-boundary shift (−11.9 s) | ventrolateral prefrontal cortex (control network) | temporal + dorsomedial/dorsolateral prefrontal, anterior temporal | — |
| Immediate pre-boundary shift (−4.5 s) | left ventrolateral prefrontal + anterior temporal pole | parietal, occipital, temporal, prefrontal — **strongest in the dorsal attention network** | — |
| Post-boundary (+11.8 s) | **widespread stabilisation**, strongest in prefrontal cortex | **almost none** — a patch of medial prefrontal cortex only | — |
| Uniquely responsive regions | ventrolateral prefrontal cortex | postcentral gyrus (dorsal attention), mid-cingulate (ventral attention), visual network | medial prefrontal cortex, temporal default-network parcels |

In the shared regions the *timecourses* still differ significantly (bootstrapped within-type null; prefrontal, posterior parietal, temporal cortex). So the dissociation is not merely anatomical — the same parcel is doing something different depending on which signal fired.

**Result 3 — human boundaries have a fixed three-stage profile**, and each stage belongs to a different trigger: anterior-temporal pattern shift at −11.9 s → parietal/dorsal-attention shift at −4.5 s → whole-brain stabilisation at +11.8 s. The first and third stages are the error model's signature, the second is the uncertainty model's.

**(brainstorm) The stabilisation asymmetry is the load-bearing result, and it reads as a commit/no-commit split.** Error says *the current model is wrong* → replace it, and the replacement shows up as a new attractor settling (widespread post-boundary stabilisation). Uncertainty says *the current model does not know* → the correct response is not to replace the model but to **go look**, and gathering information is exactly a pattern shift in the dorsal attention network with nothing to commit to afterwards. That is the pragmatic/epistemic split of [[wiki/concepts/expected-free-energy.md]] appearing as two physically separate boundary networks: `ℓ` (linear, accuracy-driven, terminates in a decision) versus `Φ` (the convex entropy term, curiosity-driven, terminates in a lookaround). If that reading holds, a segmentation architecture should emit **typed** boundaries — `REPLACE` and `INVESTIGATE` — and only the first should be allowed to write a new node into the graph. The wiki has one other typed-boundary source ([[wiki/entities/hbtom.md]], which types by *which latent* broke); this types by *what kind of failure* occurred, and the two typings are orthogonal.

**What this settles for the wiki.** The open problem "boundary detection vs. surprise" — what separates a real boundary from an outlier — was stated on this page as *a precision judgement the theory does not specify*. It is now specified and measured: precision is not a modulator of the error signal but a **separate, independently thresholded control signal with its own network**, and it is the better predictor of the two. Note the cost: this makes the detector *less* parsimonious, not more. The authors say so outright — an architecture with several distinct update triggers "would be inelegant—but evolution's engineering solutions are sometimes complex and kludgy rather than simple and sleek." Recorded as tension T121.

**The named third mechanism is the wiki's other node-creation account.** ~16% of explainable variance is unaccounted for, and the paper's own candidate for it is **latent-cause inference** (Kuperberg 2021; Shin & DuBrow 2021): rather than monitoring one event model's prediction quality, track a posterior over unobservable latent causes and cut when it is uncertain *which cause is active*. That is precisely [[wiki/concepts/contextual-inference.md]] / [[wiki/entities/coin-model.md]], the Position B of tension T23 — so the two sides of T23 now have a shared, stated experimental route to comparison: run all three boundary generators against the same fMRI pattern-dissimilarity timecourses.

---

## Why this is a gap the wiki did not have

The graph formalisation assumes the node set exists. On a continuous stream it does not, and nothing else in the wiki supplies it — grid codes presuppose a metric space already carved up, core knowledge presupposes entities already individuated, and attention selects among items already formed. Event segmentation is the first mechanism the wiki has for **where discrete states come from**. Recorded as gap G27.

**And the gap has an orthogonal axis this page does not cover.** Everything above carves the stream in *time*; nothing carves a single frame into *entities*. [[wiki/entities/spelkenet.md]] does the second with a criterion that is neither predictive failure nor effect-equivalence: group the pixels that co-move under an imagined force, computed by poking a generative flow model and clustering its response distribution ([[wiki/concepts/counterfactual-probing.md]]). Three differences worth keeping. (i) It needs no threshold on a surprise signal — the only threshold is Otsu's, which is *derived* from the observed histogram rather than hand-set, which no detector in the table above manages. (ii) Its units are spatial and simultaneous, so the two mechanisms compose rather than compete: events say when the node changes, this says what the node is made of. (iii) It is the one carving criterion here that runs on a **single static frame**, because the temporal evidence has been absorbed into the model instead of being read off the stream.

Secondary consequence for aliasing (gap G2): because an event is a *set*, two identical observations belonging to different active sets are different events. Set membership is a de-aliasing tag that costs nothing extra, in the same way module membership does in [[wiki/concepts/core-knowledge.md]].

---

## Open problems

- **The boundary criterion itself is contested.** Every mechanism above thresholds the output of a *predictor*; the batch optimal-transport route segments high-dimensional pixel streams competitively with no dynamics model at all, by clustering plus a temporal-smoothness penalty ([[wiki/empirical-tensions.md]] T139). If clustering suffices, the discretisation can precede the world model rather than depend on it.
- **No learned boundary detector.** Between hand-set thresholds and backpropagation-through-time gates there is nothing local, learned, and derived from the objective.
- **The compression criterion is unspecified.** "Frequently encountered types of interaction may be clustered into episodes" names no clustering objective, no granularity control, and no stopping rule — so the depth of the temporal hierarchy is as unpinned as the planning horizon (gap G24).
- **Recursive composition is asserted, not demonstrated.** The lecture ⊂ studies ⊂ career example is the paper's own illustration; nothing shows a learned system building a recursion of that depth.
- **Boundary detection vs. surprise — *partly answered, at a price*.** What separates a real boundary from an outlier is a precision judgement, and Nguyen et al. 2025 show precision is not a modulator of the error term but a **second control signal** with its own network and its own (stronger) behavioural weight. The residual problem is that both signals are still read out by hand-set thresholds, and there is now no single quantity to threshold — so the arbitration between the two triggers is unspecified, and so is what happens when they disagree.
- **No boundary is typed.** Error-driven and uncertainty-driven boundaries have opposite post-boundary signatures (commit vs. no commit), so they should license different downstream actions — but every detector on this page emits an untyped `boundary` event, and nothing in the wiki consumes a boundary type.

---

## Connections

- **[[wiki/entities/vl-jepa.md]]** — this page's boundary rule implemented on a *semantic* stream and priced: Ward-variance agglomerative clustering with a temporal-connectivity constraint over a non-autoregressive embedding stream Pareto-dominates uniform sampling and matches 1 Hz decoding at 0.35 Hz, with the granularity `N` still set by hand and the clustering offline rather than online.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the substrate this page abstracts over: events are sets of *its* active encodings, so segmentation needs no machinery beyond a change detector on that set; its hierarchical-dynamical form also supplies the implicit alternative, where priors on *motion* parse the stream and lesioning them costs more than lesioning the top-down priors (Friston & Kiebel 2009).
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the discretisation the graph formalisation assumes: events are nodes, event schemata are typed edges with preconditions and effects, episodes are compressed paths.
- **[[wiki/concepts/simulation-based-planning.md]]** — episode encodings are the coarse level that jumpy multi-scale planning needs, and backward chaining through schema preconditions is path search run in reverse from the goal.
- **[[wiki/concepts/working-memory.md]]** — the multiplicative gate that detects a boundary is the same gate that maintains an item, so segmentation and maintenance are one mechanism seen at two timescales.
- **[[wiki/concepts/attention.md]]** — a boundary is where the currently relevant set of encodings changes, i.e. an event boundary is a re-selection signal.
- **[[wiki/concepts/abstract-structural-codes.md]]** — an event schema is content-invariant in the same sense `g` is: the schema "reaching to contact" is defined by relative distance reaching zero, whatever object fills it.
- **[[wiki/concepts/core-knowledge.md]]** — the rival account of where discrete entities come from: individuation by entry-gated core systems rather than by temporal change in the active encoding set (tension T12).
- **[[wiki/concepts/meta-learning.md]]** — episode encodings are the meta-graph level made concrete: what is shared across instances is the schema, what varies is the binding of items to its slots.
- **[[wiki/entities/h-jepa.md]]** — the alternative to a boundary detector: fixed temporal pooling between prediction levels coarse-grains time without ever naming a boundary, which is cheaper and cannot produce variable-length events.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the engineered stand-in for boundary discovery: a token vocabulary is a hand-chosen discretisation of the stream (gap G27), and its cost is measurable in bits — larger vocabularies help small models and hurt large ones.
- **[[wiki/entities/hbtom.md]]** — supplies a typed boundary signal: surprise decomposed per latent (goal / rationality / whole-model likelihood) says not only that prediction broke but which variable to re-infer, which a monolithic predictor cannot produce.
- **[[wiki/entities/irene.md]]** — the matching negative result: a single scalar `max_t` prediction error as the surprise signal leaves the model at chance on exactly the violations that are not violations of predicted *position magnitude*, and swapping max for mean moves scores by up to 16 points.
- **[[wiki/concepts/subgraph-matching.md]]** — mechanises the step that fires a schema: testing whether a schema's precondition pattern occurs in the current state is a subgraph query, and the encoder's depth bounds how large a precondition may be.
- **[[wiki/concepts/contextual-inference.md]]** — the rival boundary criterion, and the one that supplies what this page lacks: a new node is created when the *novel-context* responsibility is high under a sticky hierarchical Dirichlet process, so the clustering objective, the granularity control (`γ`) and the stopping rule are one prior — paid for with a scalar node content (Heald et al. 2021; tension T23).
- **[[wiki/concepts/pattern-separation-completion.md]]** — the graded counterpart of a boundary decision: when experience gets a fresh code is set by a continuous separation bias rather than a discrete test, and the cholinergic storage/recall switch is a candidate boundary signal (Yassa & Stark 2011).
- **[[wiki/concepts/cognitive-map.md]]** — temporal boundaries cut episodic memory the way walls cut space, which is the only anchoring cue that has been shown to carry out of the spatial domain (Epstein et al. 2017).
- **[[wiki/concepts/offline-replay.md]]** — the same discretisation question one level up: what sets the boundaries of a replayed *sequence* (its length, where it is cut from the continuous trajectory) is explicitly unknown, as is what licenses a new node here.
- **[[wiki/entities/temporal-context-model.md]]** — the graded alternative to a boundary detector: context drifts continuously and the similarity between two context states *is* the segmentation, so "same event?" is a distance rather than a change-point decision.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — shows the timescale question is unavoidable rather than incidental: that model fixes "one observation = one session" by fiat while acknowledging hippocampal map switches at 100 ms–1 s, and names event segmentation as a candidate rule for when the posterior is recomputed at all.

- **[[wiki/concepts/memory-allocation-excitability.md]]** — a purely temporal segmentation running underneath the predictive-encoding one: everything encoded inside an hours-long excitability window is bound into one linked unit whether or not the active encoding set changed, so a boundary detector and an allocation tag can disagree about where an episode ends.

- **[[wiki/concepts/controller-knowledge-vs-process.md]]** — claims this page's episodes as the *contents of the control layer* and adds three properties they lack: a goal, a maintenance window that terminates on goal completion rather than by decay, and a partial-order variant that commits only some of the ordering (Wood & Grafman 2003).

- **[[wiki/concepts/schema-assimilation.md]]** — the same stored object indexed by overlap instead of by time, and with a content specification this page lacks: the situational reading of ventromedial prefrontal cortex says the stored unit carries spatial, temporal, causal, **evaluative and social** aspects bound together, and no prediction-error boundary detector produces the last two (Lieberman & Meyer 2018).
- **[[wiki/entities/pfc-columnar-planning-model.md]]** — the spatial instance of this page's boundary rule: a change-point in a self-motion statistic (probability of a sharp turn) recruits a new coarse column, chunking a whole corridor into one graph node exactly as a prediction-error boundary chunks a stream into one episode (Martinet et al. 2011).
- **[[wiki/concepts/expected-free-energy.md]]** — the normative reading of the error/uncertainty dissociation: the accuracy trigger is the linear pragmatic cost `ℓ` and the uncertainty trigger is the convex entropy term `Φ`, so the two boundary networks are the two terms of one planning objective realised as separate circuits (brainstorm, from Nguyen et al. 2025).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the one region whose patterns shift for *both* boundary types, with significantly different timecourses for each, which makes it the arbitration site the threshold accounts leave unspecified (Nguyen et al. 2025).
- **[[wiki/concepts/attention.md]]** — the dorsal attention network carries the uncertainty-driven boundary and *only* that one, and it shows almost no post-boundary stabilisation, so an uncertainty boundary is a look-here signal rather than a node-creation signal.
- **[[wiki/entities/coin-model.md]]** — supplies the granularity control and stopping rule for node creation that this page lacks (`γ`, `κ`, `α` under a sticky hierarchical Dirichlet process), at the price of a node whose content is one scalar (T23).
- **[[wiki/entities/basal-ganglia.md]]** — the action-side counterpart of a boundary signal, on dedicated hardware: a thalamic burst at a salient stimulus drives striatal cholinergic interneurons into a burst-pause that first mutes cortical drive presynaptically (M2) and then leaves a ~1 s window in which the *suppression* pathway is selectively more responsive (M1) — an interrupt triggered by the arrival of an unmodelled event rather than by any property of the input's content.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the action-side counterpart of a boundary: segmentation cuts the *observed* stream where the event model breaks, an option terminates the *acted* stream where a subgoal is reached, and the two coincide only if subgoals are chosen at predictability boundaries — which no option-discovery mechanism requires, so a learner can have two incompatible segmentations of the same episode (Botvinick, Niv & Barto 2009).
- **[[wiki/entities/hami.md]]** — segmentation supplied by fiat: the environment's episode boundary is used directly as the memory buffer's reset signal, so the architecture never has to detect a boundary — which localises exactly what this page's mechanism would have to supply before such a store could run on a continuous stream (Poursiami et al. 2025).
- **[[wiki/entities/hisd.md]]** — supplies the two things this page's open problems say are missing, offline and at corpus scale: segment granularity set by one interpretable scalar (a Gromov–Wasserstein radius `r` that fixes the minimum expected segment length) instead of a hand-set error or uncertainty threshold, and a stopping rule for the episode hierarchy (a grammar rule is kept only if the corpus uses it twice) — paid for with a required maximum skill count `K` and no online operation (Harvey et al. 2026).
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — the complementary carving criterion for gap G27: this page cuts the stream where *prediction fails*, that one cuts it where *the agent's actions stop distinguishing consequences* — and a schema `⟨precondition, transition, effect⟩` is the same object as a distilled PDDL rule, so the two families produce interchangeable edges from non-interchangeable signals (Taniguchi et al. 2023).
- **[[wiki/entities/spelkenet.md]]** — the spatial half of gap G27, and the only discretiser in the wiki that runs on one static frame: entities recovered as clusters of co-response to an imagined poke, with a derived (Otsu) threshold instead of a hand-set one on a surprise signal (Venkatesh et al. 2025).
- **[[wiki/concepts/counterfactual-probing.md]]** — the sibling carving criterion stated generally, and the complementary axis: this page cuts a stream where its own predictions break, that one cuts a scene where a model's *counterfactual* responses stop co-varying, so one produces nodes in time and the other the entities each node is about.
- **[[wiki/entities/kan-ode.md]]** — **(brainstorm)** a boundary signal this page could get for free: a continuous-time model integrated by an adaptive solver already computes a step size that collapses exactly where the state changes fastest, so the integrator's own error controller is a segmentation detector requiring no separate prediction-error monitor and no threshold on a learned model's surprise.
- **[[wiki/concepts/violation-of-expectation.md]]** — the same scalar under a different use: a prediction-error spike is this page's segmentation signal and that page's violation signal, so one trace serves both and a violation detector comes free with a segmenter.
- **[[wiki/entities/hit-jepa.md]]** — the cheap rival to a boundary detector: max-pooling by a fixed factor of 2 places segment boundaries on a grid regardless of content, and the resulting representation is nonetheless the most robust of four methods on trajectories sampled at irregular 3.1-minute intervals — evidence that content-blind coarse-graining is not fatal where boundary placement is noisy anyway (Li et al. 2025).
- **[[wiki/entities/ms-ssm.md]]** — the frequency-domain alternative to a boundary detector: rather than cutting the stream where the predictive model breaks, a learned undecimated wavelet cascade decomposes it into `S+2` scales that *coexist* and are re-weighted per position, so multi-grain temporal structure is handled with no segmentation decision anywhere — which sidesteps G27's missing detector for the purpose of *reading* the stream while supplying nothing at all for the discrete nodes a graph formalisation needs (Karami et al. 2025).
- **[[wiki/concepts/problem-framing.md]]** — this page is the wiki's nearest mechanism for constructing part of a representation out of a raw stream, and the residual it leaves is what that page names: the *type* of the extracted object (an event schema ⟨precondition, transition, effect⟩) is chosen by the designer, so segmentation populates a framing rather than choosing one.
- **[[wiki/concepts/synaptic-plasticity.md]]** — a recurrence detector that needs no boundary computation and no clock: spike-timing plasticity concentrates weight on afferents that fire consistently early, so the postsynaptic latency *shortens* with each repetition of a spatio-temporal pattern and "this segment recurred" becomes a timing difference a downstream coincidence detector reads for free (Guyonneau et al. 2005, via Tavanaei et al. 2019).
- **[[wiki/concepts/spike-encoding-schemes.md]]** — this page's boundary test relocated into the sensor: a temporal-contrast encoder (event camera) emits a signed event exactly when a signal departs from its own recent baseline past a threshold, so an architecture reading it receives pre-segmented change events without running any predictive model **(brainstorm)**.
