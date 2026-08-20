# Complementary Learning Systems

**Intelligence requires two memory systems with different learning rates — a fast, sparse, instance-based hippocampal store that encodes single experiences, and a slow, distributed neocortical store that extracts statistical structure — coupled by offline replay that transports information from the first into the second.**

Complementary learning systems (CLS) is the biological argument for the **two-timescale factorization** the wiki treats as mandatory: slow **W** (weights) / fast **M** (memory). See [[wiki/concepts/latent-graph-discovery.md]].

---

## Why two systems (the interference argument)

A single distributed learner trained on temporally correlated experience overwrites earlier solutions: parameters shift toward the optimum for task 2 and destroy the configuration that solved task 1 (catastrophic forgetting). Two escapes exist, and CLS takes both:

1. **Interleave** the experience — but real experience arrives correlated and sequential, not interleaved.
2. **Buffer it elsewhere first** — encode rapidly in a system whose code is sparse enough that new items do not overlap old ones, then *replay* from that buffer to the slow learner in interleaved order, offline.

CLS was proposed as the solution to this problem, which makes it a *derived* architecture rather than an anatomical accident: given correlated experience and a distributed slow learner, something with the hippocampus's properties is forced (Hassabis et al. 2017, reviewing McClelland, McNaughton & O'Reilly).

## The two systems

| Property | Hippocampus / medial temporal lobe | Neocortex |
|---|---|---|
| Learning rate | Fast — one exposure | Slow — many interleaved exposures |
| Code | Sparse, instance-based, conjunctive | Dense, distributed, overlapping |
| Content | Specific episodes, bound in context | Statistical regularities, semantics, skills |
| Retrieval | Content-addressable | Generalization to new instances |
| Failure if used alone | No generalization, no compression | Catastrophic interference |
| Role in [[wiki/concepts/latent-graph-discovery.md]] | **Instance-graph** — this episode's topology, bound once | **Meta-graph** — structure shared across episodes |

**Replay** is the coupling: reinstatement, during sleep and quiet rest, of the structured activity patterns that accompanied the original event, driving consolidation into cortex. Replay is biased toward events that led to high reinforcement — but reward is **not** the criterion, and may not even be the main one. Replay upsamples rarely-visited space, prefers remote over imminent trajectories, and actively suppresses salient-but-idiosyncratic stimuli; consolidating everything overfits, so the channel is a *filter* rather than a pipe. Full account: [[wiki/concepts/offline-replay.md]] (Liao & Losonczy 2024).

---

## The return path has a wiring constraint

CLS names replay as the channel and stops. Rolls 2013 derives what the *retrieval* channel must look like, and the derivation is unusually strong for a biological argument because it is arithmetic.

Recall to cortex is a **reverse hierarchy of pattern associators**: CA3 → CA1 → deep entorhinal layers → parahippocampal/perirhinal → association cortex, each stage a heteroassociative net whose backprojecting synapses were modified during encoding (when forward-driven cortical firing coincided with backprojected hippocampal activity). Retrieval therefore *reinstates the cortical activity pattern present at encoding*, in every area that participated — the face in temporal cortex, the place in parietal, the reward in orbitofrontal.

| Constraint | Statement | Consequence |
|---|---|---|
| Per-stage capacity | Same form as the CA3 bound: `p ≈ k'C/(a ln(1/a))`, with `a` the local sparseness and `C` the backprojections received per cell | Every stage must carry at least as many memories as CA3 stores |
| Fan-out requirement | `C^HBP = C^RC · a_nc / a_CA3` — ≥ 12,000 hippocampally-originating afferents per cortical cell even in the best case | **A monosynaptic CA3→cortex readout is impossible**; each CA3 cell would need `C^HBP ×` (cortical cells / CA3 cells) synapses |
| Therefore | The backprojection must be **polysynaptic with gradual fan-out per stage** | Quantitative account of why cortex has as many backward as forward connections |

**(brainstorm) The machine reading is a cost model nobody applies.** Every retrieval-augmented architecture in the wiki treats the read-out from the fast store as free — one attention operation from a memory matrix into the model's residual stream. This says the *decompression* side of consolidation is the expensive half, that its cost scales with the ratio of cortical sparseness to store sparseness, and that the only affordable implementation is a staged expansion. A fast store that is very sparse (good for capacity) is *harder* to read back out, which is a trade-off the sparse-memory literature does not price.

**Two further CLS commitments the source revises:**

- **Forgetting is required, and it is reallocation.** The store has a hard capacity; exceeding it loses most of what is retrievable, not the marginal item. Heterosynaptic LTD overwriting old memories, plus fresh random CA3 sets for new episodes, is the proposed mechanism — so the retention window is set by *the acquisition rate of new episodes*, not by a clock. Testable and untested: in a constant restricted environment, hippocampal representations should remain stable indefinitely and no retrograde-amnesia gradient should be demonstrable.
- **"Neocortical representations changed after learning" is not evidence of transfer.** If the CA1 code changes, downstream cortical firing changes through *fixed* connections. Any consolidation claim needs to separate a changed input from a changed weight — a confound the machine analogue (frozen encoder, changed memory contents) has exactly.

---

## The channel has a generator, and it sits in the *receiver*

CLS names replay as the channel and (above) prices its return wiring. Mander et al. 2013 measures the channel's *throughput* in humans and locates what sets it: a slow oscillation generated by the cortical learner itself.

Design: 18 young (20.4±2.1 yr) and 15 cognitively normal older (72.1±6.6 yr) adults, word-pair associative recognition trained to criterion in the evening, tested at 10 min and again after an 8 h polysomnographically recorded sleep (retention = long-delay − short-delay recognition); separate wake-delay control groups; structural MRI plus retrieval fMRI the next morning.

| Link measured | Result |
|---|---|
| age → NREM slow-wave activity (SWA, 0.8–4.6 Hz) | `r = −0.86`; SWA maximal over prefrontal derivations in *both* age groups |
| age → medial prefrontal (mPFC) grey matter | `r = −0.94`; peak whole-brain age difference is in mPFC |
| mPFC grey matter → SWA | `r = 0.89` (young 0.60, older 0.52 separately); **age stops predicting SWA once mPFC volume enters the model** (Sobel `P = 0.005`) |
| Regional specificity | precuneus, hippocampus and temporal-lobe grey matter also shrink with age but **do not** mediate the SWA decline (all Sobel `P > 0.13`) |
| SWA → overnight retention | `r = 0.81` global and prefrontal; holds within young (0.77) and older (0.71) separately |
| age / mPFC → retention | `r = −0.61` / `0.64`, **both non-significant once SWA enters the model** (Sobel all `P < 0.001`) |
| SWA → hippocampal retrieval activation | Negative. Older adults show *greater* post-sleep hippocampal activation at retrieval and *reduced* hippocampal–mPFC functional connectivity |
| Specificity of the sleep variable | Fast spindle density, stage-2 sigma power, total sleep time, sleep efficiency, %stage-1, circadian preference, subjective and objective alertness, neuropsychological scores — **and hippocampal volume** — none predicts retention once age or SWA is in the model |

Only young adults showed the sleep-over-wake retention advantage; older adults lost it while SWA still predicted retention *within* the older group — so the channel is throttled, not switched off.

Three consequences this page did not state:

1. **Transport bandwidth is a property of the slow learner, not of the fast store.** The variable carrying the entire effect is generated by mPFC — the *receiving* side — and hippocampal volume predicts nothing. In every machine instantiation below, replay rate is a hyperparameter of the buffer; here it is a state variable of the cortical network, degradable independently of what is stored or of how well the store works. **(brainstorm)** The machine analogue nobody builds is a consolidation schedule whose rate is *read out of the slow learner's own dynamics* rather than set by the designer — which would make an under-trained or damaged slow learner consolidate less, exactly backwards from current practice.
2. **Offline *time* is not the quantity being spent.** Sleep duration, efficiency, stage composition and spindles all drop out; only the amplitude of the <5 Hz oscillation survives. Consolidation is priced in coordination events, not in seconds — the natural unit for the reactivation-count rationing of [[wiki/concepts/generalization-optimized-consolidation.md]].
3. **Failed transport has a signature, and it is the same signature Go-CLS predicts for optimal *refusal*.** Low SWA yields persistently hippocampus-dependent retrieval plus weak hippocampal–mPFC coupling; a low-predictability relation that was correctly never consolidated looks identical from outside ([[wiki/empirical-tensions.md]] T82).

Stated caveat: cross-sectional mediation across a 50-year age gap, no manipulation — the paper is explicit that it does not establish causality. The causal arm it leans on is elsewhere (transcranial slow-oscillation stimulation over PFC enhancing retention in young adults, cited not run).

---

## The channel also runs backwards, at encoding time

This page's coupling is unidirectional: fast → slow, by replay, offline. Rolls' reverse hierarchy adds cortex ← hippocampus at *retrieval*. de Sousa et al. 2026 adds a third traffic direction the wiki had no slot for — **slow → fast, during encoding, controlling how the fast store writes**.

| Property | Consequence for this page |
|---|---|
| vmPFC activity during a new episode tracks its contextual similarity to a *prior* episode and the time since it | The slow store is consulted at write time, not only at read time |
| Inhibiting vmPFC→MEC makes dCA1 write the new episode into the old episode's cells (~15% → ~25% overlap); activating it forces separation even when the contexts are identical | Cortex sets the fast store's *write geometry*, bidirectionally, without touching the content |
| The effect exists at a 7 d interval and is absent at 5 h | The control path requires a matured cortical trace — i.e. it is **switched on by consolidation itself** |
| Single-episode encoding, exploration and social behaviour are unaffected | It is an organization channel, not a general encoding gate |

**(brainstorm) What this costs the standard picture.** Under CLS the fast store is an unopinionated buffer and all the structure-extraction happens downstream. Here the slow learner reaches back and decides which new experiences get bound to which old ones *before* replay ever runs, so part of the meta-graph's influence is exercised at encoding. Two things follow for gap G14: the transported unit is not chosen only by an offline filter ([[wiki/concepts/offline-replay.md]], [[wiki/concepts/recall-gated-consolidation.md]]) — some of the grouping is already fixed at write time by an *online* similarity test against consolidated content; and the loop is self-reinforcing, since more consolidation buys a better arbiter, which buys better-organized new memories. No machine CLS implementation has a cortex→buffer path at all.

---

## What actually moves: the mapping, not the terms

Euston et al. 2012 read the rodent medial prefrontal literature as one associator observed at three ages of its content, and the reading puts a constraint on the cargo this page's channel carries.

| Interval | Where the association lives | Where the representations live |
|---|---|---|
| Acquisition | Hippocampus (rapid binding) | Already in cortex |
| Recent (1–2 d) | Hippocampus | Cortex *represents* context, events and responses — but not the mapping between them |
| Remote (≥30 d, shown to 200 d) | Cortex | Cortex, now holding both |

Consequences this page did not state:

- **Transport is not "move the memory".** The slow learner has the vocabulary from the start; what consolidates is the association among items it could already represent. This predicts the otherwise awkward asymmetry that a cortical lesion costs *more* at remote delays than at recent ones without the region being dispensable early — at remote delays it is the only copy of the mapping, at recent delays it is one of two systems representing the terms.
- **A bounded consolidation window.** Disrupting medial prefrontal cortex 0–2 h after a task destroys recall 24–48 h later; the same disruption outside the window does not, and a plasticity-enhancing or glucocorticoid agent inside it *improves* retention. Rat cortical consolidation then continues for ~2 weeks.
- **Necessity at learning and necessity at consolidation come apart.** Several tasks are acquired normally without medial prefrontal cortex yet lose their memory to post-task disruption of it. The proposed patch is compensation — another frontal area takes over *if* the region was offline during learning, but cannot substitute once it was engaged — which makes a module's necessity depend on its own availability history. **(brainstorm)** That invalidates single-module ablation as a functional assay for any architecture with redundant parallel learners, biological or machine, and no ablation study in the wiki checks for it.

**(brainstorm) The runnable version.** Freeze the slow learner's input and output representations and let replay write only the associative weights between them; under this reading consolidation should lose nothing, while the reverse ablation should fail. No machine consolidation scheme here factorises transport this way — self-distillation ([[wiki/concepts/generalization-optimized-consolidation.md]]) moves whatever the loss moves, experience replay moves everything.

---

## Machine instantiations

| System | Mechanism | What it borrows | What it drops |
|---|---|---|---|
| **Experience replay** (deep Q-network) | Buffer of past transitions sampled during training | The interleaving function of replay: decorrelates consecutive experience, stabilizes value learning in structured sequential environments, multiplies data efficiency | A flat uniform store — no sparse conjunctive code, no context binding |
| **Prioritized replay** | Sample transitions in proportion to reward / error magnitude | Matches the biological finding that replay favours highly rewarding events; empirically improves on uniform replay | Priority is a scalar, not a structural criterion |
| **Episodic control** | Store (state, action, return); act by similarity between the current input and stored events | The *fast* system used directly for behaviour, not only as a teacher for the slow one | No consolidation path back into the slow learner |
| **Memory-augmented networks** | External content-addressable matrix read/written by a learned controller | Content-addressable retrieval; explicit control/storage split ([[wiki/concepts/working-memory.md]]) | Controller weights are the only slow learning; no replay-driven consolidation |

**The key empirical claim** (Hassabis et al. 2017): episodic control outperforms deep RL *early* in learning and succeeds on tasks that depend heavily on one-shot learning, where deep RL architectures fail — the signature predicted by the normative theory *before* the architectures existed. This is the paper's cleanest example of neuroscience acting as a validation channel ([[wiki/concepts/neuroscience-ai-transfer.md]]).

---

## Mapping to the wiki's core framing

| CLS element | Latent-graph element |
|---|---|
| Neocortex, slow, many episodes | Slow **W** ← meta-graph: transition structure shared across the environment family |
| Hippocampus, fast, one episode | Fast **M** ← instance-graph: this task's particular topology |
| Sparse conjunctive coding | De-aliasing (hardness source 3): the same observation at structurally distinct positions receives distinct codes |
| Replay / consolidation | The channel by which instance experience *becomes* meta-structure — no machine architecture in this ingest does this online (gap G14) |
| One-shot encoding | Instantiation is **binding**, not learning: a schema's free slots filled in a single pass |

**(brainstorm)** The wiki justifies the W/M split by sample complexity — nothing identifies a high-dimensional instance function from a handful of examples. CLS supplies an *independent* derivation of the same split from interference alone. Two unrelated arguments converging on one factorization is the strongest structural evidence the wiki currently holds that the split is not an arbitrary modelling choice.

---

## Open problems

- **Consolidation is missing in silico.** Machine replay serves *stabilization of one learner*, not *transport between two*. The direction hippocampus→cortex — instance structure becoming meta structure — has no machine analogue here.
  - **Now built, in a linear model, and it comes with a stopping rule.** Sun et al. 2023 run the transport explicitly: a sparse Hopfield notebook one-shot-binds a random index to the slow learner's activity, settles into that index from random initialisation offline, drives the slow learner's input and output layers through the return weights, and the slow learner does gradient descent on *its own reactivated targets* — self-distillation from the fast store, with the environment never re-seen. The result is that this page's central assumption is wrong as stated: transport past a finite point *increases* generalization error, and for a relation the slow learner cannot model the optimal amount of transport is zero. Partial and permanent hippocampal residence are therefore the predicted normal case ([[wiki/concepts/generalization-optimized-consolidation.md]]).
  - **Partly answered, without replay.** Whittington et al. 2018 train the two learners *jointly*: a fast Hebbian write into the conjunctive store and slow gradient descent over the structural generator, end-to-end, so the slow learner is optimised precisely for *making the fast store's contents predictable and addressable*. Transport is continuous and online rather than an offline replay episode. Evidence that the coupling works: memories survive 400+ steps although backpropagation through time is truncated at 25, i.e. the retention is the Hebbian store's and the addressing is the gradient learner's. What it does not model is the CLS claim proper — nothing ever *moves* into cortex, so the fast store is never relieved ([[wiki/entities/tolman-eichenbaum-machine.md]]).
- **"Slow" is a property of the *content*, not of the cortex.** With a matching cortical schema already in place, a new flavour–place pair is acquired in a single trial and survives 24 h, and hippocampal lesions block retention only within ~3 h of acquisition rather than 24–48 h — so the same tissue consolidates an order of magnitude faster when the new item fits an existing structure, and the benefit does not transfer from a schema built in a different environment. The interference argument at the top of this page derives the *existence* of two systems; it does not predict that the slow one's rate is a function of what it already holds ([[wiki/concepts/schema-assimilation.md]], Tse et al. 2007 via Preston & Eichenbaum 2013).
- **Fast level: separate system or recurrent state?** CLS says a second anatomical store; meta-RL says activity dynamics of one network ([[wiki/concepts/meta-learning.md]]). Unresolved — see [[wiki/empirical-tensions.md]] T2.
- **What gets replayed** — **partly answered, and against the machine version.** Reward-prioritisation is what machine replay copies; biology's demonstrated criteria run the other way (upsample the under-visited, suppress the non-recurring, prefer remote to imminent), and the proposed principle is an inductive bias toward *transferable* content rather than toward valuable content (Liao & Losonczy 2024; [[wiki/concepts/offline-replay.md]]). What remains open is the mechanism — inhibitory plasticity is predicted by modelling and not established — and whether the criterion is structural in the graph-disambiguating sense.
  - **Now with a normative derivation and a computable statistic.** Lindsey & Litwin-Kumar 2024 show that "keep what recurs" is the *optimal* filter when experience mixes reliably recurring update patterns with one-off ones, and that the separating statistic is the fast store's own recall of the proposed update — realised as prediction accuracy, decision confidence or familiarity depending on the learning problem. The filter therefore needs no offline pass at all ([[wiki/concepts/recall-gated-consolidation.md]]).
- **One mechanism, five sampling policies.** Interleaving, consolidation, planning, offline state-space construction and amortization each imply a different replay distribution, and nothing arbitrates between them ([[wiki/concepts/offline-replay.md]]).
- **When to trust the fast system.** Episodic control wins early and loses late; nothing arbitrates the handover.
- **When does transport happen?** The standard answer is sleep. Rolls 2013 argues for *waking*: recall during waking retrieves the relevant memories under rational guidance, so only useful episodes seed semantic structure, whereas noise-driven stochastic firing in sleep risks consolidating confabulation — the dream argument. [[wiki/empirical-tensions.md]] T34.
- **Capacity and generalisation are optimised by different models of the same tissue.** The most quantitative hippocampal model in the wiki ([[wiki/entities/rolls-treves-hippocampal-model.md]]) has no transfer story at all; the models with a transfer story state no capacity. Nothing has both.

---

## Connections

- **[[wiki/entities/vector-hash.md]]** — the fast store built and priced, with an explicit verdict against content compression: the hippocampal state is a content-independent *pointer* into cortex, and an autoencoder bottleneck that compresses the content instead loses capacity, forgetting-resistance and sequence memory at matched size (Chandra et al. 2023).
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the biological derivation of the slow-W / fast-M split, and maps hippocampal sparse coding onto the de-aliasing requirement.
- **[[wiki/concepts/continual-learning.md]]** — same interference problem, different solution: add a second fast system rather than gate plasticity within one; replay and weight protection are complementary, not rival.
- **[[wiki/concepts/meta-learning.md]]** — the rival implementation of the same two-timescale factorization, with the fast level carried by recurrent activity instead of a separate store.
- **[[wiki/concepts/simulation-based-planning.md]]** — replay (backward, for consolidation) and preplay (forward, for planning) are the same hippocampal trajectory-generation machinery serving two functions.
- **[[wiki/concepts/working-memory.md]]** — external content-addressable memory is the engineering form of the fast store; working memory adds the controller that decides what is written and read.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the most productive single transfer in the historical record, and the one case where a normative biological prediction was confirmed after the fact in machines.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the hippocampal–entorhinal system holds the fast instance store and the structural code in one anatomy, which is what makes binding content to graph position cheap.
- **[[wiki/concepts/synaptic-plasticity.md]]** — short- and long-term plasticity give the same fast/slow timescale split *within a single synapse*, so the separation this page states anatomically is already present one level down and does not require two systems to exist.
- **[[wiki/concepts/core-knowledge.md]]** — an entity typed by a different core system is individuated without path context, so module membership supplies a discrete de-aliasing tag alongside the sparse conjunctive code.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — reaches the same two-timescale split from a third premise: one free-energy objective minimised over *activity* (fast) and over *weights* (slow), so the split needs neither two anatomies nor a sample-complexity argument (Butz 2016).
- **[[wiki/concepts/amortized-inference.md]]** — a third job for the same offline replay machinery: not decorrelating a training stream and not consolidating episodes, but compiling model-based rollouts into model-free cached values during dreaming or quiet wakefulness.
- **[[wiki/entities/hbtom.md]]** — localises what a missing fast store costs: deep baselines match a structured model on within-trajectory judgements and collapse to chance exactly where a latent must persist across trials and stay keyed to an agent identity.
- **[[wiki/concepts/contextual-inference.md]]** — a third answer to the same interference problem: not one fast store plus one slow store, but a *growing set* of slow stores with an inference process deciding which is being written to, so protection comes from low responsibility rather than from sparse coding (Heald et al. 2021).
- **[[wiki/concepts/pattern-separation-completion.md]]** — supplies the mechanism behind "sparse conjunctive code": the fast store's non-overlap is a tunable transfer curve implemented by dentate-gyrus expansion recoding, with a separate anatomical read port so retrieval need not fight storage (Yassa & Stark 2011).
- **[[wiki/concepts/cognitive-map.md]]** — the consolidation gradient measured on *structure*: maps learned before medial temporal damage survive it in schematized form, with retrosplenial/medial parietal cortex the cortical store and the hippocampus still required for fine spatial detail (Epstein et al. 2017).
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — hippocampal indexing theory implemented: the fast store holds only bindings between two cortical codes (structure and sensory), which makes consolidation the learning of what makes those bindings predictable rather than the transport of episodes — and its 2018 precursor runs the fast Hebbian write and the slow gradient step in one end-to-end objective, which is the wiki's only online version of this page's coupling.
- **[[wiki/entities/cscg.md]]** — the opposite assignment of the same anatomy: the *map itself* lives in the fast store, so cortex consolidates already-de-aliased state spaces rather than raw experience ([[wiki/empirical-tensions.md]] T28).
- **[[wiki/concepts/successor-representation.md]]** — makes "what gets replayed" a parameter: every multi-step transition shares one eigenbasis, so diffusive, super-diffusive (Lévy) and successor-distance sampling differ only in a diagonal reweighting.
- **[[wiki/concepts/offline-replay.md]]** — the contents of this page's coupling channel: replay is filtered rather than veridical, which turns "transport episodes to cortex" into "decide which episodes deserve to become structure".
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — supplies the missing return path with a wiring constraint (`C^HBP = C^RC a_nc/a_CA3`, hence a polysynaptic reverse hierarchy), a capacity bound on the fast store, and forgetting-as-random-reallocation instead of decay.
- **[[wiki/entities/temporal-context-model.md]]** — the limiting case of a contentless fast store: the hippocampus only reinstates entorhinal states, so cortex does all the remembering, and the abolition of pair-coding in area TE by rhinal lesion shows the similarity structure being *imposed* on cortex by medial temporal feedback.
- **[[wiki/entities/tem-transformer.md]]** — hippocampal indexing theory in closed form, with the scaling result that makes it affordable: one memory neuron can index a pattern across three or more cortical areas, so binding another modality costs extra *feature* neurons only, against the multiplicative blow-up an outer-product conjunction would pay.
- **[[wiki/entities/sparse-distributed-memory.md]]** — the fast store priced from memory engineering rather than from interference: one-shot writes, capacity ~10% of the location count, graded overload, and a per-bit confidence read-out — against a slow layer trained iteratively. It also states the division's precondition from the other end: the store is only as useful as an encoder that maps semantic similarity onto Hamming distance, so most of the work is in what feeds it.
- **[[wiki/entities/context-modular-memory-network.md]]** — the same slow-write/fast-select division drawn *inside a single synapse* rather than between two systems: the Hebbian weight is the slow indiscriminate generative write, the per-context mask is the fast discriminative reversible select, which predicts that recall practice can sharpen a memory with no weight changing.
- **[[wiki/entities/hopfield-network.md]]** — the fast system's defining capability in its minimal form: a one-shot, local, content-addressable write, together with the argument that a rule needing 10⁴–10⁶ exposures cannot be the episodic mechanism because an episode happens once.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — quantifies the "sparse conjunctive code" this page's fast store is asserted to require: two random sparse patterns share almost no coordinates, so the interference a new write inflicts on an old detector is exactly a false-positive rate, and ~25 bits per item is enough to hold it below 1 in 10⁹ across 10⁶ items.

- **[[wiki/concepts/memory-allocation-excitability.md]]** — inserts a third timescale between the fast store and the slow cortex: an hours-long excitability tag that groups temporally proximal episodes into one assembly *before* consolidation runs, so what the replay channel transports may be a cluster of episodes rather than an episode — already one step of abstraction over the instance-graph (G14).
- **[[wiki/concepts/recall-gated-consolidation.md]]** — puts a valve on this page's coupling channel and derives what opens it: the slow store writes only when the fast store already recalls the proposed update, which filters one-off experience out of long-term storage, and the same theory re-derives this page's sparse-fast / dense-slow asymmetry from an optimal coding level `f* ∝ λ` (Lindsey & Litwin-Kumar 2024).
- **[[wiki/entities/btsp-cam.md]]** — weakens the usual urgency argument for the fast→slow channel: a fast store whose write target is chosen by an input-independent gate does not degrade its own earlier traces (first 100 and last 100 of 10,000 sequentially learned items recall equally well), so interference is bounded by the allocation rate rather than by how much has been stored.
- **[[wiki/concepts/manifold-constrained-learning.md]]** — proposes a boundary between fast and slow that is geometric rather than quantitative: within-span re-association of existing population patterns is learned in one session (adaptation), while changing the span itself is not learned at all on that timescale and is the posited job of multi-day skill learning — a fast/slow split diagnosable from the population geometry before any training is run (Sadtler et al. 2014). Golub et al. 2018 name the two processes and their timescales — re-association of a fixed activity repertoire over hours, repertoire realignment over days to weeks, with only a residual trace of the slow one detectable within a session.
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — supplies the sign condition this page never states: transport helps only while it lowers generalization error, so for a relation the slow learner cannot model the optimal transfer is *zero* and the memory stays hippocampal permanently — which turns partial consolidation from an anomaly into the predicted normal case, and prices the two-system advantage as maximal exactly where the stored-example count matches the slow learner's parameter count (Sun et al. 2023).
- **[[wiki/concepts/offline-replay.md]]** — supplies the carrier for the throughput result above: sharp-wave ripples are nested in the cortical slow oscillation whose amplitude (SWA) is what predicts overnight retention, so the prefrontal generator measured by Mander et al. 2013 is plausibly gating *when* the fast store's ripples are allowed to write — a scheduler for that page's seven competing sampling policies that lives outside the hippocampus entirely **(brainstorm)**.
- **[[wiki/concepts/memory-allocation-excitability.md]]** — supplies the reverse channel above: a consolidated vmPFC trace, acting through MEC onto CA1 neurogliaform interneurons, decides at encoding time whether a new episode is allocated to the cells holding an old one — so the slow store shapes the fast store's writes, and only after consolidation has built the trace it uses to do so (de Sousa et al. 2026).
- **[[wiki/concepts/engram.md]]** — what the fast store's sparse conjunctive code looks like when measured brain-wide: not one hippocampal pattern but a tuple of region-local sparse ensembles (amygdala, hippocampus, cortex, and also thalamus, hypothalamus, brainstem) each holding one aspect, bound by nothing except a shared write window **(tentative)**.
- **[[wiki/entities/differentiable-neural-computer.md]]** — states the CLS division as an explicit design target (domain regularities in the controller's slow weights, episode-specific variability in the fast memory matrix) and supplies no channel between them, which is gap G14 exhibited inside one architecture.
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — the fast/slow dissociation on material with no internal regularity: hippocampal ablation blocks acquisition of *new* arbitrary cue→action mappings while pre-lesion mappings are performed normally with the same cues and movements, so the cortical residue cannot be a compressed structure — and the acquisition rate the fast store must support is measured (~3 trials/cue to substantial learning, 24 new mappings/day) (Wise & Murray 2000). It also supplies a fast store that is *untyped by content* — the hippocampal system holds exemplars, higher-order rules and problem-solving strategies over the intermediate term and hands each to a different cortical destination — plus the control this page's evidence base mostly omits: post-lesion sparing of old material is a preserved store only when performance is good immediately after surgery, not across days of re-exposure (Murray et al. 2000).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — breaks the symmetry this page's fast-store/controller arrow assumes: ventral subiculum and ventral CA1 project to infralimbic and ventral prelimbic cortex with almost no direct return, so the episodic store addresses the controller directly while the controller must reach the store through entorhinal cortex or a diencephalic relay.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — constrains the cargo: the cortical learner already represents the context, event and response terms at acquisition, so what the replay channel transports is the *association* among them — which is why a cortical lesion costs more at remote than at recent delays, and why the transport budget is spent inside a 0–2 h post-task window (Euston et al. 2012).
- **[[wiki/concepts/schema-assimilation.md]]** — re-indexes this page's transport by overlap instead of by time: an item that fits an existing cortical structure is learned in one trial and consolidated within ~3 h, an item with no matching structure follows the slow interleaved route, so "cortex learns slowly" is the no-schema special case rather than the rule (Tse et al. 2007, via Preston & Eichenbaum 2013) — and it reverses the write-time geometry, since events inside a schema are initially coded by the *same* cells as the old ones and differentiate only over days.
- **[[wiki/entities/nucleus-reuniens.md]]** — names and lesions the controller→fast-store arrow this page draws freehand: prefrontal cortex reaches the hippocampus through a midline thalamic relay whose neurons collateralise to *both* structures, so the return path is a shared bus delivering one copy to each rather than a directed write (Jin & Maren 2015).
