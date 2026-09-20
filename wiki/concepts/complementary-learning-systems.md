# Complementary Learning Systems

**Intelligence requires two memory systems with different learning rates — a fast, sparse, instance-based hippocampal store that encodes single experiences, and a slow, distributed neocortical store that extracts statistical structure — coupled by offline replay that transports information from the first into the second.**

Complementary learning systems (CLS) is the biological argument for the **two-timescale factorization** the wiki treats as mandatory: slow **W** (weights) / fast **M** (memory). See [[wiki/concepts/latent-graph-discovery.md]].

---

## Why two systems (the interference argument)

A single distributed learner trained on temporally correlated experience overwrites earlier solutions: parameters shift toward the optimum for task 2 and destroy the configuration that solved task 1 (catastrophic forgetting). Two escapes exist, and CLS takes both:

1. **Interleave** the experience — but real experience arrives correlated and sequential, not interleaved.
2. **Buffer it elsewhere first** — encode rapidly in a system whose code is sparse enough that new items do not overlap old ones, then *replay* from that buffer to the slow learner in interleaved order, offline.

CLS was proposed as the solution to this problem, which makes it a *derived* architecture rather than an anatomical accident: given correlated experience and a distributed slow learner, something with the hippocampus's properties is forced (Hassabis et al. 2017, reviewing McClelland, McNaughton & O'Reilly).

**The argument, measured in a seq2seq model, with the interference frequency-resolved** (Hupkes et al. 2020, [[wiki/entities/pcfg-set.md]]). Insert exceptions to an otherwise exceptionless rule at 0.01 / 0.05 / 0.1 / 0.5% of a function's occurrences, and track per epoch what fraction of exceptions the model answers with the *rule* (overgeneralisation) versus the *memorised* target:

| Exception rate | Behaviour of a single distributed learner |
|---|---|
| 0.01% | Both LSTMS2S and Transformer *never* learn the exception — they converge still applying the rule |
| 0.05–0.1% | Overgeneralise early, then trade smoothly into memorisation (ConvS2S, Transformer) |
| 0.5% | No overgeneralisation at all — the rule is not internalised as a rule |

Three things this buys the page. (i) The rule/exception trade-off has a **measured switching point** in a specific architecture class, which the interference argument predicts qualitatively and never quantifies. (ii) Overgeneralisation is *positive* evidence that the slow learner extracted the regularity — applying a rule where the data contradict it is the past-tense-debate signature (`goed`, `breaked`) and can only come from a rule. (iii) **One architecture demonstrably cannot host both.** After LSTMS2S detects that a sequence does not follow the rule, its overgeneralisation score falls without its memorisation score rising: it emits neither the rule output nor the exception target, for the rest of training. That is the interference argument's failure mode observed rather than assumed, and it is the case a second fast store exists to prevent.

## The two systems

| Property | Hippocampus / medial temporal lobe | Neocortex |
|---|---|---|
| Learning rate | Fast — one exposure | Slow — many interleaved exposures |
| Code | Sparse, instance-based, conjunctive | Dense, distributed, overlapping |
| Content | Specific episodes, bound in context | Statistical regularities, semantics, skills |
| Retrieval | Content-addressable | Generalization to new instances |
| Failure if used alone | No generalization, no compression | Catastrophic interference |
| Role in [[wiki/concepts/latent-graph-discovery.md]] | **Instance-graph** — this episode's topology, bound once | **Meta-graph** — structure shared across episodes |

**The rate split has a direct electrophysiological signature in *offline content*, not just in learning speed** (Ji & Wilson 2007, `raw/ji-2007-coordinated-replay-visual-cortex-hippocampus.md`). In well-trained rats, sleep *before* the day's running already contains above-chance high-order replay of the trajectory templates in deep-layer V1/V2 (`P = 1.4 × 10⁻⁶` pooled, 2 of 4 rats individually) but **not** in CA1 (`P = 0.16`, 0 of 3 rats); the experience of the intervening session raises replay in both. Reading, which is the source's own: what the slow store spontaneously expresses offline reflects the *accumulated* past, while the fast store's offline content is dominated by the most recent session — the two-timescale claim measured as a difference in what each area replays when nothing new has happened. Caveat the source states: the animals were over-trained, so what was recorded may already be the product of earlier consolidation rather than its ongoing operation.

**The teacher/student labelling survives the transfer step but not the selection step** (Rothschild, Eban & Frank 2017, `raw/rothschild-2017-cortical-hippocampal-cortical-loop.md`). Recording CA1 and auditory cortex together in sleeping rats, a cross-validated GLM finds that auditory-cortical ensemble patterns in the 400 ms *before* a ripple predict CA1 spiking during it (`P = 2.7 × 10⁻⁶`) while pre-ripple CA1 predicts cortex in no window, and that CA1 patterns during the ripple predict cortical spiking *after* it (`P = 1.3 × 10⁻⁵`) while the reverse arm is null — a cortical–hippocampal–cortical loop with the legs separated in time. Cargo still flows fast→slow, as this page has it; but the *choice of cargo* is biased by the slow learner's own state, which is set by intracortical plasticity and, in the same experiment, by a sound played during sleep whose effect on the cortical pattern outlives it by 2–14 s. So the student partly writes its own syllabus — a return path this page's channel does not have, and which the wiki's replay implementations all omit ([[wiki/empirical-tensions.md]] T377).

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

### The generator is also a clock, and the channel is duty-cycled

> Klinzing, Niethard & Born 2019 (`raw/klinzing-2019-mechanisms-of-systems-consolidation-during-sleep.md`). Full treatment: [[wiki/concepts/sleep-oscillation-nesting.md]].

Mander's result gives the channel a throughput variable (prefrontal slow-wave amplitude). This source says why an amplitude is the right variable: the slow oscillation's up-state is a **window**, and the transfer is licensed by a conjunction of three nested rhythms — ripple in spindle trough, spindle in up-state.

| Addition to this page | Statement |
|---|---|
| The channel is **duty-cycled by the receiver** | The slow learner emits the window signal; the store's output only becomes a cortical write inside it |
| Violating the protocol **inverts the sign** | A slow oscillation with no nested spindle depotentiates cortical synapses |
| The window is a **cell-level circuit state** | Pyramidal cells depolarised, parvalbumin interneurons clamping the soma, somatostatin-mediated dendritic inhibition withdrawn — write-enable with the read-out muted, and the same state supports plasticity during waking |
| Transport is embedded in **global downscaling** | Net synaptic weakening across sleep, with consolidation as the local exception; regulated per *dendritic branch* |
| The addressing is unexplained | Spindles are local, slow oscillations global, and the slow oscillation's location does not predict the nested spindle's — so something else decides which cortical network receives the update ([[wiki/empirical-tensions.md]] T373) |

**(brainstorm) What this costs the machine version.** Every CLS implementation here writes to the slow learner whenever a sample is drawn, with forgetting handled by a separate policy. The biological arrangement makes them one schedule: write in-phase-and-addressed, decay in-phase-and-unaddressed, and let the *source* ensemble be downscaled by the very event that transports it.

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

## Why the two rates differ, and where the channel can be cut

> **Provenance.** Frankland & Bontempi 2005, *The organization of recent and remote memories*, Nat Rev Neurosci 6:119–130 (`raw/frankland-2005-organization-of-recent-and-remote-memories.md`). A review of >30 tabulated hippocampal-lesion studies of retrograde amnesia, the mouse-genetic consolidation experiments, and the (¹⁴C)2-deoxyglucose / immediate-early-gene imaging of memory age.

### 1. A candidate substrate for the rate split: weight plasticity vs wiring plasticity

The interference argument at the top of this page derives that there must be *two rates*; it says nothing about what makes the cortical rate slow, and the review names this as an open neurobiological question with one proposal attached:

| System | Dominant plasticity | Why the rate follows |
|---|---|---|
| Hippocampus | **Weight** plasticity — change the strength between neurons *already* connected (LTP-like) | One exposure suffices: the connectivity the binding needs already exists |
| Neocortex | **Wiring** plasticity — form new synapses between previously **unconnected** neurons (only a small fraction of possible cortical pairs are connected at all) | The substrate for an association must be *built* before it can be weighted, and structural change is slow |

Supporting evidence, indirect but of the right type: GAP43 (growth-associated protein 43), a synaptogenesis marker, is induced in cortex after recall of both spatial and contextual fear memories; and in parietal cortex the activated population shifts over weeks from layers V–VI to layers II–III/IV — the origin and termination of most cortico-cortical connections ([[wiki/concepts/canonical-cortical-microcircuit.md]]), i.e. exactly the layers new cortico-cortical wiring would have to appear in.

**(brainstorm) This breaks the machine analogy at its most load-bearing point.** Every machine CLS instance implements "slow" as a small step size on a **fixed** graph. If the biological slow rate is a *topology-search* cost instead, then (i) the slow learner should be **fast** wherever the required connection already exists — which is precisely the schema result ([[wiki/concepts/schema-assimilation.md]]), otherwise an unexplained exception; (ii) the right machine analogue of consolidation is growing edges/parameters, not annealing a learning rate; and (iii) the rate is not a hyperparameter at all but a function of the current connectivity, so it should drift as the slow learner fills in.

### 1b. A rival substrate for the rate split: one rule, two induction thresholds

> Teyler & Rudy 2007. Full treatment: [[wiki/concepts/hippocampal-indexing-theory.md]].

Section 1 makes the cortical rate slow because the *connection does not exist yet*. Indexing theory makes it slow because the *threshold to change it is higher*, with no topology change at all:

| | Fast write | Slow write |
|---|---|---|
| Form | NMDA-receptor-dependent LTP | Voltage-dependent-calcium-channel (VDCC) LTP |
| Trigger | Modest afferent input and depolarization | Strong input, large depolarization |
| Durability | Rapid, **reversible by low-frequency input** | Slow to develop, much more stable |
| Why cortex is the slow one | Not the rule — **both forms exist in both structures** | LTP is harder to induce in cortex *in vivo*, proposed to be strong inhibitory control preventing the required depolarization ([[wiki/concepts/excitation-inhibition-balance.md]]) |

Three consequences for this page:

- **The two rates are one rule under two gains**, so they are not separately parameterizable — which is the opposite of the genotype-level double dissociation in section 2, and the two accounts are not obviously compatible.
- **Decay of the fast write is the forgetting mechanism**, not a separate clearance process (contrast section 4): depotentiation by interfering input *is* the eviction policy, and it is the same synapses that stored the item.
- **The fast store can also make its own trace permanent.** VDCC-LTP is present in hippocampus too, so repetition or reward can produce an enduring *index* without anything consolidating into cortex — a third outcome the two-store picture has no slot for, and the one that would look like failed transport from outside (`T82`).

**(brainstorm)** The machine translation is a **thresholded** write rather than a small learning rate: no update to the slow learner below an activation threshold, a large and stable one above it, with the threshold set by an inhibitory gain some other system controls. That makes consolidation a gating decision instead of an integration, and predicts that a slow learner with its inhibition removed degrades into a second fast store and re-inherits the interference the split exists to remove.

### 2. The two learners are separately ablatable, and the fast store must survive for a week

| Manipulation | Recent (1–3 d) | Remote (10–50 d) | What it isolates |
|---|---|---|---|
| α-CaMKII<sup>+/−</sup> — global **cortical** plasticity deficit, hippocampal plasticity normal | Normal | **Impaired**, and the time-dependent cortical reorganization does not occur | The slow learner knocked out alone |
| Dominant-negative PAK (p21-activated kinase, a regulator of spinogenesis) — cortex-restricted: fewer spines, enlarged synapses, enhanced LTP + reduced LTD | Normal (1 d) | **Impaired** (21 d water maze; faster loss in contextual fear) | Same learner, unrelated lesion — so the effect is cortical plasticity, not one gene |
| Inducible CA1 NR1 (NMDA-receptor) deletion **in the week after training** | — | **Blocked** | The *fast store's* integrity is required post-encoding, not only at encoding |
| Forebrain dominant-negative α-CaMKII in the week after training | — | **Blocked** | Same window, different molecule |
| Either suppression started **after** that week | — | No effect | The window closes; matches hippocampal lesions being harmless after week 1 |

Two design consequences. **The transport is not a single pass**: the fast store must be maintained intact across a ~1-week window of repeated reactivation-dependent, gene-expression-requiring synaptic modification, so a machine buffer that evicts an item after one replay pass is not running this schedule. **The two learners are separately damageable with dissociable behavioural signatures**, which no single-network machine CLS instance on this page can reproduce — and the cortical-deficit rows are a genotype-level double dissociation of *rate* against *content*, the cleanest available support for the page's opening table.

### 3. The channel has a cuttable wire, and the cut is time-limited

Lesioning the **temporoammonic** projection — entorhinal layer III → CA1 ([[wiki/entities/entorhinal-cortex.md]]) — leaves the hippocampus functional and cuts cortical–hippocampal dialogue:

| Time of lesion | Water-maze acquisition | 1-day memory | 28-day memory |
|---|---|---|---|
| Before training | Normal | Normal | **Impaired** |
| 1 day after training | — | — | **Impaired** |
| 21 days after training | — | — | Normal |

So the channel is a wire that can be severed without damaging either endpoint, its traffic is required *after* encoding, and the requirement expires. Note the direction: this is a **cortex → fast store** projection, not the replay arrow — the third traffic direction this page now carries (with the vmPFC write-geometry control above), and here it is required for the *cortical* copy to form at all. **(brainstorm)** The cheap machine test is a disconnection rather than an ablation: hold both learners intact, zero the interface for a fixed window, and the prediction is intact one-shot performance with no asymptotic consolidation — a failure mode no current architecture would be instrumented to detect, since both components pass their own unit tests.

### 4. Clearance is a required component with its own rate

Most consolidation models need redundant memories *cleared* from the fast store; in connectionist models the clearance rate is what sets gradient length (high decay → short gradient), and it is a free parameter nobody measures.

| Candidate clearance mechanism | Evidence |
|---|---|
| Basal protein-phosphatase-1 and NMDA-receptor-dependent processes actively expunging traces | Inhibiting either **after** learning, with no behavioural manipulation, *reduces* memory loss |
| Adult neurogenesis — new dentate granule cells rapidly synapsing onto CA3 destabilise the existing network | Fear-memory retention is **facilitated** in mice with reduced adult neurogenesis; cortical neurogenesis is far slower, matching cortex's slower assumed decay |

Read against Rolls' account above, these are two different theories of the same requirement: there, forgetting is passive *reallocation* forced by capacity; here it is an **active process with a pharmacologically separable rate**. Both make the retention window a function of the acquisition rate of new episodes rather than of a clock, and neither has a machine analogue — machine buffers evict by recency or by priority, never by a mechanism whose rate is a target of the system's own regulation (gap `G14`, `G42`).

---

## The 15-year retrospective: four revisions to the original statement

O'Reilly et al. 2011 is the CLS authors' own audit of McClelland, McNaughton & O'Reilly 1995 (MMO95). Their verdict is that the framework held; the interesting content is in what they *changed*.

### 1. The sparse store needs a sparse decoder, and that is what CA1 is for

The wiki has been treating pattern separation in DG/CA3 as sufficient to defeat interference. It is not, and the argument is short:

| Step | Claim |
|---|---|
| Suppose CA3 projected **directly** back to entorhinal cortex | The CA3 pattern for a new episode is pattern-separated, hence unrelated to anything seen before |
| So entorhinal cells must rapidly learn to associate that novel CA3 pattern with the current cortical input | But entorhinal activity is **dense** (~15% vs 0.05% in DG), so the same cells participate in very many memories |
| Therefore the write needed for the new episode has a substantial chance of corrupting an old one | **Catastrophic interference returns at the read-out**, however good the separation upstream was |
| CA1 is *relatively sparse*, so its cells participate in far fewer memories | Interposing CA1 as a **sparse, invertible mapping** of the entorhinal pattern makes the return path cheap |

**"Invertible" is the operative word**: CA1's job is to hold a code from which the *original cortical pattern* can be regenerated, not merely a code that identifies the episode. This is a different function from Rolls' CA1-as-recombiner and from Yassa & Stark's CA1-as-relay ([[wiki/empirical-tensions.md]] T33) — it is a **learned codec**, and the review is explicit that it is the *least* well-understood part of the circuit.

Two costs the review states and does not pay:

- The mapping must generalise to novel inputs, which requires a **combinatorial/componential** code — novel patterns represented as recombinations of existing elements ([[wiki/concepts/compositionality.md]]). Building one takes substantial learning.
- **In every CLS model to date this code is installed by hand**, through architecture design and pretraining. How the real system develops it is called a long-standing, still-unsatisfied goal.

**(brainstorm) The machine reading is a design rule the wiki's memory architectures violate uniformly.** Every external-memory system here (differentiable neural computer, HAMI, episodic control, retrieval-augmented transformers) writes a sparse or hashed key and reads back through a **dense** decoder — a linear read into a dense residual stream. This says the decoder's density is where the interference you removed at the encoder comes back, and that the fix is a sparse, *separately trained*, invertible intermediate layer between the store and the model (gap G97). It also composes with Rolls' fan-out constraint above: the reverse hierarchy is expensive *and* each stage of it must stay sparse.

### 2. Conjunctive coding is not the hippocampus's monopoly — *rapid incidental* conjunctive coding is

The original Sutherland & Rudy 1989 configural theory predicted that any task requiring a conjunction of cues be hippocampus-dependent. The data refused (Rudy & Sutherland 1996). The repaired claim (O'Reilly & Rudy 2001):

| System | Can learn conjunctions? | Under what conditions |
|---|---|---|
| Neocortex | **Yes** | When task contingencies *force* it — i.e. when gradient pressure over many trials makes the elemental solution fail |
| Hippocampus | Yes | **Rapidly and incidentally**, with no task demand at all — a rat briefly pre-exposed to a context forms a bound representation of it, which later shows up as elevated fear conditioning (Rudy & O'Reilly 1999) |

So the fast/slow distinction in the table above is not *what can be represented* but **what is represented without being asked**. For a builder that is a sharper specification than "conjunctive vs distributed": the fast store is the component that binds co-occurring content **unsupervised and in one pass**, and the slow learner will reach the same code only if the objective happens to require it.

### 3. Consolidation is **transformation**, not transfer

Winocur et al. 2010, endorsed by the CLS authors as what MMO95 should have said:

| Original framing | Revised |
|---|---|
| The memory moves from hippocampus to cortex | Nothing moves. Cortex **learns its own version** of what the hippocampus encoded |
| The hippocampal trace is transient | The episodic trace **stays in the hippocampus for as long as the memory is retained at all**; CLS is *agnostic* about transience, and MMO95's transient reading rested on data now much less certain |
| The consolidated copy is the same content, differently stored | The consolidated copy is **semanticised gist** with a similarity structure the hippocampal trace never had — which is what makes it generalise |
| One system hands off to the other | Dynamic interplay; either may dominate depending on circumstance |

This is the same conclusion [[wiki/concepts/generalization-optimized-consolidation.md]] reaches from a model (partial and permanent hippocampal residence is the predicted normal case), arriving from the lesion literature instead — two independent routes to "consolidation does not empty the fast store".

**And the standard evidence for consolidation is in worse shape than in 1995.** Retrograde gradients — recent memories more impaired by hippocampal damage than remote ones — are the signature finding, and they appear in some studies and not others. Sutherland et al. 2008's well-controlled rat fear-conditioning series found gradients **flat at every lesion size**, with only a main effect of lesion size on overall memory. That is inconsistent with standard consolidation theory *and* with multiple trace theory, which predicts steeper gradients for smaller lesions ([[wiki/empirical-tensions.md]] T280).

### 4. The two systems are **synergistic**, not merely complementary

The division-of-labour framing predicts the cortex should *drag down* episodic performance. Run together, it does the opposite (Bhattacharyya, Howard & O'Reilly, unpublished data in the review; AB–AC paired-associate task, the canonical catastrophic-interference benchmark):

| Network | AB retention after AC training |
|---|---|
| Cortex alone, **AB and AC trained concurrently** | Learns both — so capacity is not the issue |
| Cortex alone, AB then AC | **>50% of AB trials wrong** — catastrophic interference |
| Hippocampus alone | ~70–80% of AB associates retained |
| **Cortex + hippocampus** | Learns **faster** *and* forgets **less** than either alone |

**The proposed mechanism is a cue-quality argument, and it is quantitative in origin.** Completion in CA3 is very sensitive to how much of the pattern the cue supplies (O'Reilly & McClelland 1994). The cortical network — even while confused between the AB and AC associations — settles toward an attractor near the target, and that coarse partial answer is enough to move the hippocampus into a regime where completion succeeds. So the slow learner's *interference-corrupted* output is still a useful cue.

**(brainstorm) This inverts the usual arbitration question.** [[wiki/concepts/latent-graph-discovery.md]] and the open problem below ("when to trust the fast system") both assume the two systems produce competing answers that something must select between. Here they are **staged**: the slow system's output is the fast system's *input*, so there is nothing to arbitrate. The machine form is cheap and nobody runs it — use the parametric model's top-1 output as the retrieval query into the episodic store rather than as a competitor to it, and expect the largest gain exactly where the parametric model is interfering, because a wrong-but-nearby answer is still a good address. The AB–AC numbers say the composition beats both components on the benchmark designed to break the parametric one.

---

### 5. Rapid cortical learning is licensed by a conjunction, not by congruence alone

> **Provenance.** Gilboa & Marlatte 2017 (`raw/gilboa-2017-neurobiology-of-schemas.md`). Full treatment on [[wiki/concepts/schema-assimilation.md]].

The one-trial-cortical-learning exception to this page's slow-cortex premise is usually stated as "schema-congruent material integrates fast". The review states three conditions instead, and two of them are constraints the wiki's machine consolidation mechanisms violate:

| Condition | Consequence for a builder |
|---|---|
| Prior knowledge must be **co-active** with the incoming information; amodal hubs (ventromedial prefrontal, anterior temporal) potentiate the synchronous neocortical activity that allows it | the write is a Hebbian coincidence between a reinstated template and a live input, **not** a replayed sample — so this route does not run offline at all |
| New associations must be **related but non-overlapping**; related *and* overlapping material still interferes | the licence is a conjunction, not a similarity scalar. Overlap forces the expensive hippocampal route; relatedness without overlap licenses the cheap cortical one |
| The rapid change occurs in **representational** layers rather than hidden layers (lateral/inferior temporal cortex, temporoparietal junction) | a *partial* write confined to the read-out, which composes with the Euston et al. constraint above (freeze the terms, write only the mapping) |

This is the interference argument at the top of the page with its exception made precise: the reason distributed networks were thought incapable of fast integration is the overlapping case, and connectionist models that update representational layers show little interference on related non-overlapping material. It also sharpens `T82` and `G14`, and it makes the acceleration reported by the sleep literature (spindle density predicting accelerated hippocampal disengagement for schema-dependent material) a consequence of a licence rather than of a rate.

---

## The 21-year retrospective: the dichotomy softens on both sides

> **Provenance.** Kumaran, Hassabis & McClelland 2016, *What learning systems do intelligent agents need? Complementary learning systems theory updated*, Trends Cogn Sci 20(7):512–534 (`raw/kumaran-2016-complementary-learning-systems-updated.md`). The second authorial audit on this page (O'Reilly et al. 2011 is the first), written against two empirical challenges — hippocampal generalization, and rapid schema-dependent consolidation — and with an explicit machine-learning half.

The review states **two amendments** to the 1995 statement, and both cut the same way: the opening table of this page is a pair of endpoints, not a pair of systems.

| Original tenet | Amendment | Consequence for a builder |
|---|---|---|
| Cortical learning **must** be slow, to avoid catastrophic interference | True **only when new information is inconsistent with existing knowledge**. MMO95's interference simulations used inconsistent material and never varied consistency, so the tenet was never tested where it fails | "Slow" is not a property to be implemented; it is an outcome of a mismatch measure |
| Slow parametric cortex vs fast instance-based hippocampus | The neocortical rate is **dependent on prior knowledge**, not slow *per se* — and because hippocampal input *is* the cortical representation, hippocampal learning inherits the same dependence | The rate is a function of state, on **both** sides, so neither learning rate is a hyperparameter |
| The hippocampus stores specifics; generalization is cortical | Recurrent activation over pattern-separated traces supports some generalization inside the fast store ([[wiki/entities/remerge.md]]) | The fast store needs a *read loop*, not just a read |

**The second amendment is the load-bearing one and the page has been understating it.** Every other source here makes the schema exception a property of the cortical learner. This one propagates it: the fast store sees the world through the slow store's representation, so a system with a good model has a *better fast store too*. That predicts a compounding loop — more consolidation buys better cortical codes, which buys better hippocampal bindings, which consolidate more easily — and it is the same loop the vmPFC write-geometry result above reaches from anatomy (de Sousa et al. 2026). No machine two-store system shares the representation this way; the buffer holds raw transitions.

### The simulation behind the schema exception

The mechanism [[wiki/concepts/schema-assimilation.md]] describes behaviourally, run in the network architecture MMO95 used to argue for slow cortical learning in the first place (McClelland 2013):

| Step | Result |
|---|---|
| Train the network to acquire a schema (properties of animals: *canary is a bird, can fly*) | the slow, interleaved regime of the original argument |
| Train on a new item `X` **consistent** with it (`X is a bird and can fly`) | **rapid** learning, existing knowledge undisrupted |
| Train on a new item `X` **inconsistent** with it (`X is a bird but swims, not flies`) | slow; requires interleaving with known examples or catastrophic interference follows |
| Weight-change amplitude, **same learning-rate parameter in both conditions** | **large** for consistent material, small for inconsistent — matching the schema-dependent neocortical plasticity-gene expression measured 80 min after learning in the event arena (Tse et al. 2011) |

**The last row is the importable part and the wiki had only the biology.** A single small learning rate produces two different effective rates because the *gradient* is larger when the input is compatible with the representation already built — the theoretical analysis of deep linear networks says the rate always depends on the state of knowledge and on the compatibility of new inputs with it (Saxe et al.). So the schema effect needs **no mechanism at all**: it is a property of gradient descent in a network that has already learned structure, and any architecture here would show it if anyone measured per-condition gradient norms. That also dissolves the wiring-plasticity account above as a *necessary* explanation (section 1) without refuting it: the rate split is over-determined.

### The proposal this page has no slot for: the fast store exists to *bias* the slow one

The review's own extension. The hippocampus is positioned — polymodal input plus neuromodulatory afferents — to **reweight individual experiences by significance** (surprise, novelty, reward magnitude of either sign, information value), and the reweighting sets both persistence *and* replay probability, so a statistically rare but important event is not swamped by the mass of typical ones. Molecular stabilization mechanisms let this run **retrospectively**: an episode's replay probability can be raised by events occurring after it.

This is a *normative* claim, and it contradicts the selection criterion this page currently carries (upsample the under-visited, suppress the salient-but-idiosyncratic). Registered as [[wiki/empirical-tensions.md]] T375; the review's own Outstanding Question #1 is whether the reweighting produces a biased model, and post-traumatic stress disorder is offered as the runaway case.

### Pattern separation is also a continual-learning mechanism, before any transport happens

The page's interference argument makes the fast store a *buffer* whose value is realised when replay runs. The review names a second, immediate value that needs no consolidation at all: orthogonal codes let an agent hold **many** task/context representations concurrently without interference, over the short timescale *before* systems-level consolidation. The existence proof is spatial — rodents sustain robust representations of >10 environments, each a pattern-separated chart in CA3 ([[wiki/concepts/attractor-dynamics.md]]), with locations individuated inside each.

**(brainstorm)** That makes the fast store a **task-boundary-free module allocator**, which is the component [[wiki/concepts/continual-learning.md]]'s expansion methods build by hand and gate badly. The machine reading: a sparse conjunctive encoder over (observation, context) allocates near-disjoint code for a new task automatically, with no task label and no gating network, and the measurable is exactly the chart count — how many task-codes stay mutually decodable as the store fills.

---

## Machine instantiations

| System | Mechanism | What it borrows | What it drops |
|---|---|---|---|
| **Experience replay** (deep Q-network — [[wiki/entities/dqn.md]]) | Buffer of the last 10⁶ frames, sampled **uniformly**, minibatch 32; paired with a target network frozen for `C` steps | The interleaving function of replay: decorrelates consecutive experience, stabilizes value learning in structured sequential environments, multiplies data efficiency | A flat uniform store — no sparse conjunctive code, no context binding. And, per the primary source, the *reason*: Mnih et al. 2015 justify replay as breaking gradient correlation and averaging the behaviour distribution over past parameter settings — an optimisation fix, with the hippocampal parallel offered afterwards as convergent support. **Size of the effect, from the ablation the primary source tabulates without numbering in text: removing replay drops performance to at best ~30% of the with-replay score** (Kumaran et al. 2016) — so the interleaving half alone, with no second learner, is worth a 3× factor |
| **Prioritized replay** ([[wiki/concepts/replay-prioritisation.md]]) | `P(i) ∝ (\|δᵢ\|+ε)^α` over the same buffer, with an importance-sampling correction annealed to unbiasedness; ~2× faster learning, median Atari 111% → 128% (Schaul et al. 2016) | The claim that replay *order* is a control variable — an exponential sample-complexity gap on a sparse-reward chain with everything but the sampling rule held fixed | **The deployed criterion is TD-error magnitude, not reward.** Return-based prioritisation is listed in that paper's appendix as the neuroscience-motivated alternative and was never run. Priority is a scalar, not a structural criterion |
| **Episodic control** ([[wiki/entities/model-free-episodic-control.md]], Blundell et al. 2016; [[wiki/entities/neural-episodic-control.md]], Pritzel et al. 2017; [[wiki/entities/hami.md]]) | Store (state, action, return); act by similarity between the current input and stored events. In NEC: one dictionary per action, kernel-weighted 50-NN read, values updated at a tabular `α` far above the embedding's learning rate `η` | The *fast* system used directly for behaviour, not only as a teacher for the slow one — and, in NEC, the slow learner reduced to supplying the *metric* in which stored keys are compared | No consolidation path back into the slow learner, and the price is now dated: NEC leads every parametric Atari agent below 20M frames (54.6% vs 22.4% median human-normalised at 10M) and is overtaken at 40M. **And the Atari half of that price is not stratified**: the founding paper measures 10–60% exact state-action revisits on those games against <0.1% in 3-D Labyrinth, so an unknown fraction of the early lead is lookup (`T353`) |
| **Wake–sleep library learning** ([[wiki/entities/dreamcoder.md]], Ellis et al. 2021) | Wake solves tasks and stores their programs; an **abstraction** sleep phase compresses fragments shared across those programs into new library primitives; a **dreaming** phase trains a proposer on replays *and* fantasies sampled from the library | The **transport** half, which every row above drops: instance solutions become shared structure, and the phase halts by its own posterior when no addition pays. Two sleep phases with different jobs, mapped by the authors onto slow-wave (declarative abstraction) and REM (procedural skill + dreaming) | The slow store is a *symbolic library*, not distributed weights, so there is no interference to protect against and no gradual-interleaving argument; crisp symbolic tasks only, one domain per run |
| **Memory-augmented networks** | External content-addressable matrix read/written by a learned controller | Content-addressable retrieval; explicit control/storage split ([[wiki/concepts/working-memory.md]]) | Controller weights are the only slow learning; no replay-driven consolidation |

**What the borrowing actually was.** DQN has no second learner, so "replay" there names the *interleaving* half of this page's argument with the *transport* half absent — the fast store is the buffer and there is nothing for it to teach. Everything this page calls consolidation is therefore still unborrowed at the point the transfer is usually credited (Mnih et al. 2015).

**The key empirical claim** (Hassabis et al. 2017), now with a primary-source number and a crossing point (Pritzel et al. 2017, [[wiki/entities/neural-episodic-control.md]]): episodic control outperforms deep RL *early* in learning and succeeds on tasks that depend heavily on one-shot learning, where deep RL architectures fail — the signature predicted by the normative theory *before* the architectures existed. This is the paper's cleanest example of neuroscience acting as a validation channel ([[wiki/concepts/neuroscience-ai-transfer.md]]).

---

## Mapping to the wiki's core framing

| CLS element | Latent-graph element |
|---|---|
| Neocortex, slow, many episodes | Slow **W** ← meta-graph: transition structure shared across the environment family |
| Hippocampus, fast, one episode | Fast **M** ← instance-graph: this task's particular topology |
| Sparse conjunctive coding | De-aliasing (hardness source 3): the same observation at structurally distinct positions receives distinct codes — the state space that gets de-aliased is handed to every machine model by construction (`G2`) |
| Replay / consolidation | The channel by which instance experience *becomes* meta-structure — no machine architecture in this ingest does this online (gap G14) |
| One-shot encoding | Instantiation is **binding**, not learning: a schema's free slots filled in a single pass |

**(brainstorm)** The wiki justifies the W/M split by sample complexity — nothing identifies a high-dimensional instance function from a handful of examples. CLS supplies an *independent* derivation of the same split from interference alone. Two unrelated arguments converging on one factorization is the strongest structural evidence the wiki currently holds that the split is not an arbitrary modelling choice. What neither argument delivers is the factorization itself: both derive that there must be *two rates*, and every architecture in the wiki implements the split as a timescale difference rather than as a separation of variables (`G1`).

---

## Open problems

- **Consolidation is missing in silico.** Machine replay serves *stabilization of one learner*, not *transport between two*. The direction hippocampus→cortex — instance structure becoming meta structure — has no machine analogue here.
  - **Now built, in a linear model, and it comes with a stopping rule.** Sun et al. 2023 run the transport explicitly: a sparse Hopfield notebook one-shot-binds a random index to the slow learner's activity, settles into that index from random initialisation offline, drives the slow learner's input and output layers through the return weights, and the slow learner does gradient descent on *its own reactivated targets* — self-distillation from the fast store, with the environment never re-seen. The result is that this page's central assumption is wrong as stated: transport past a finite point *increases* generalization error, and for a relation the slow learner cannot model the optimal amount of transport is zero. Partial and permanent hippocampal residence are therefore the predicted normal case ([[wiki/concepts/generalization-optimized-consolidation.md]]).
  - **Partly answered, without replay.** Whittington et al. 2018 train the two learners *jointly*: a fast Hebbian write into the conjunctive store and slow gradient descent over the structural generator, end-to-end, so the slow learner is optimised precisely for *making the fast store's contents predictable and addressable*. Transport is continuous and online rather than an offline replay episode. Evidence that the coupling works: memories survive 400+ steps although backpropagation through time is truncated at 25, i.e. the retention is the Hebbian store's and the addressing is the gradient learner's. What it does not model is the CLS claim proper — nothing ever *moves* into cortex, so the fast store is never relieved ([[wiki/entities/tolman-eichenbaum-machine.md]]).
- **"Slow" is a property of the *content*, not of the cortex.** With a matching cortical schema already in place, a new flavour–place pair is acquired in a single trial and survives 24 h, and hippocampal lesions block retention only within ~3 h of acquisition rather than 24–48 h — so the same tissue consolidates an order of magnitude faster when the new item fits an existing structure, and the benefit does not transfer from a schema built in a different environment. The interference argument at the top of this page derives the *existence* of two systems; it does not predict that the slow one's rate is a function of what it already holds ([[wiki/concepts/schema-assimilation.md]], Tse et al. 2007 via Preston & Eichenbaum 2013).
  - **A mechanism that would make this the expected case rather than an exception**: if the cortical rate limit is *wiring* plasticity — building connections between previously unconnected neurons — then material whose connections already exist consolidates at hippocampal speed, and the schema result stops being an anomaly (section 1 above, Frankland & Bontempi 2005). Untested as stated; the discriminating measurement would be whether schema-consistent consolidation is accompanied by the synaptogenesis markers that schema-inconsistent consolidation is.
- **Fast level: separate system or recurrent state?** CLS says a second anatomical store; meta-RL says activity dynamics of one network ([[wiki/concepts/meta-learning.md]]). Unresolved — see [[wiki/empirical-tensions.md]] T2.
- **What gets replayed** — **partly answered, and against the machine version.** Error-prioritisation is what machine replay actually copies (reward-prioritisation is the version biology motivates and machines never deployed — [[wiki/concepts/replay-prioritisation.md]]); biology's demonstrated criteria run the other way (upsample the under-visited, suppress the non-recurring, prefer remote to imminent), and the proposed principle is an inductive bias toward *transferable* content rather than toward valuable content (Liao & Losonczy 2024; [[wiki/concepts/offline-replay.md]]). What remains open is the mechanism — inhibitory plasticity is predicted by modelling and not established — and whether the criterion is structural in the graph-disambiguating sense.
  - **Now with a normative derivation and a computable statistic.** Lindsey & Litwin-Kumar 2024 show that "keep what recurs" is the *optimal* filter when experience mixes reliably recurring update patterns with one-off ones, and that the separating statistic is the fast store's own recall of the proposed update — realised as prediction accuracy, decision confidence or familiarity depending on the learning problem. The filter therefore needs no offline pass at all ([[wiki/concepts/recall-gated-consolidation.md]]).
- **One mechanism, five sampling policies.** Interleaving, consolidation, planning, offline state-space construction and amortization each imply a different replay distribution, and nothing arbitrates between them ([[wiki/concepts/offline-replay.md]]).
- **When to trust the fast system.** Episodic control wins early and loses late — measured, on 57 Atari games, as a crossing at ~40M frames against prioritised replay ([[wiki/entities/neural-episodic-control.md]]) — and nothing arbitrates the handover. **A staging answer that dissolves the question**: if the slow system's output is used as the *cue* for the fast system rather than as a rival answer, the integrated network beats both components on AB–AC (section 4 above), and no arbiter is needed. Untested outside one unpublished simulation.
  - **A second answer, and it is two-factor rather than uncertainty-only.** Blundell et al. 2016 ([[wiki/entities/model-free-episodic-control.md]]) posit four control systems — model-based planning (prefrontal), habitual model-free (dorsolateral striatum), model-free episodic, model-based episodic — and claim the *time and working-memory resources available for the decision* gate which systems are available at all, with residual uncertainty of the slower system selecting only among those. Under time pressure there is nothing to arbitrate between the planners because neither can run, so the hard version of this open problem applies to a reduced set. The predicted experiment is stated and unrun: manipulate decision timing or load working memory with an orthogonal task, and measure medial-temporal-lobe-to-output coherence under different statistical conditions.
  - **And the handover is not always desirable.** A scrub jay recovering a cache is better off recalling the exact hiding spot than sampling a distribution over likely ones (Clayton & Dickinson 1998, via the same paper). Where the reward structure is a set of particulars rather than a statistical regularity, the instance store is the asymptotically correct system — the behavioural form of [[wiki/concepts/generalization-optimized-consolidation.md]]'s result that optimal transport can be zero, and a bound on how universally `G14`'s channel is wanted.
- **Nobody builds the decoder.** The fast store's read-out must itself be sparse and invertible or the interference removed at the encoder returns at the read-out (section 1 above). CLS models install this code by pretraining; how it develops, and what the machine equivalent is, is open.
- **When does transport happen?** The standard answer is sleep. Rolls 2013 argues for *waking*: recall during waking retrieves the relevant memories under rational guidance, so only useful episodes seed semantic structure, whereas noise-driven stochastic firing in sleep risks consolidating confabulation — the dream argument. [[wiki/empirical-tensions.md]] T34.
- **Capacity and generalisation are optimised by different models of the same tissue.** The most quantitative hippocampal model in the wiki ([[wiki/entities/rolls-treves-hippocampal-model.md]]) has no transfer story at all; the models with a transfer story state no capacity. Nothing has both. So no machine fast store on this page knows when it is full, and the handover question above has no occupancy term in it (`G42`).

---

## Connections

- **[[wiki/entities/continual-dreamer.md]]** — the fast-store/slow-learner pair in a reinforcement-learning agent with the *filter* made the experimental variable: uniform-coverage admission beats first-in-first-out and beats prioritisation by reward or by surprise, which is the machine measurement this page's replay-selection question was missing.
- **[[wiki/entities/pcfg-set.md]]** — the interference argument run as an experiment in a single distributed learner: exceptions below 0.5% of a rule's occurrences are overgeneralised away, and one of the three architectures cannot hold a rule and its exception simultaneously at any rate, degrading to outputs that match neither.
- **[[wiki/concepts/priority-map.md]]** — the fast/slow split appearing inside the *control* layer rather than inside memory: repeating a search cue in blocks removes the need for the template-switching stage entirely and part of the need for the matching stage, so a recurring query is progressively absorbed into slower structure (Bichot et al. 2015).
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
- **[[wiki/concepts/offline-replay.md]]** *(also)* — the return path this page's channel lacks: the slow learner's pre-ripple ensemble state predicts what the fast store replays and the reverse prediction is null, so "fast teaches slow" holds for the cargo and inverts for the selection, and a sensory cue during sleep is enough to set the syllabus (Rothschild et al. 2017).
- **[[wiki/concepts/offline-replay.md]]** — the contents of this page's coupling channel: replay is filtered rather than veridical, which turns "transport episodes to cortex" into "decide which episodes deserve to become structure". It also carries this page's rate split measured at the two ends of the channel simultaneously — pre-session sleep replays the templates in cortex but not in hippocampus — plus the coordination statistic (11/11 trajectories by interval analysis) that makes the channel's nine-event count a detection artefact rather than its throughput (Ji & Wilson 2007).
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
- **[[wiki/concepts/dynamic-network-connectivity.md]]** — one scalar with opposite signs across the two systems: raising prefrontal cAMP impairs working memory and strengthens long-term consolidation, so holding a binding and committing it can be traded by a shared gain instead of scheduled by separate machinery (Arnsten et al. 2010).
- **[[wiki/entities/meta-rl-agent.md]]** — the rival answer to this page's fast level, now with a primary source: frozen-weight recurrent activity performing within-episode RL competitive with Gittins/Thompson/UCB, i.e. a fast learner with no second store and no second learning rule ([[wiki/empirical-tensions.md]] T2; Wang et al. 2018).
- **[[wiki/entities/pfc-columnar-planning-model.md]]** — restates the division of labour as a difference of representational *format* rather than of storage site: hippocampus holds instances (places, routes), the cortical controller holds the topology abstracted over them, and the cortical code is measurably sparser at each stage (Martinet et al. 2011).
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — breaks the bidirectional arrow this theory draws: anatomically it is two separate directed edges with different endpoints, different cargo and different task phases — context in to the ventral tier, a retrieval trigger out from anterior cingulate.
- **[[wiki/concepts/population-geometry.md]]** — the awkward datum for the fast-store story: hippocampus fires ~60% *less* once it learns to infer and rearranges its geometry instead, so a one-shot behavioural flip need not correspond to a new trace.
- **[[wiki/entities/model-free-episodic-control.md]]** — the founding architecture behind this page's *episodic control* row, and the source of two things the row needed: a four-system arbitration proposal in which decision time and working-memory load gate which controllers are *available* before uncertainty selects among them, and the scrub-jay argument that for a reward structure made of particulars the optimal transport out of the fast store is zero.
- **[[wiki/entities/neural-episodic-control.md]]** — the *episodic control* row's canonical implementation, and the sharpest test of this page's transport claim: with no channel from the fast store into the slow learner, the fast-store agent extracts far more from the first 20M frames and less from the next 20M, so G14's missing channel shows up as a datable crossing point rather than as a qualitative deficiency. It also inverts the page's assignment — the slow learner holds no structure, only the similarity metric.
- **[[wiki/entities/hami.md]]** — the primary source behind this page's *episodic control* row, and its sharpest result: quantising the memory key into a short symbol pair keeps the fast store from saturating (87% of buffer used after 20,000 episodes, where vector-keyed episodic control exhausts and overwrites), so the fast system's sample-efficiency advantage is bought by key cardinality rather than by any learning rule — with still no channel back into the slow learner (G14) (Poursiami et al. 2025).
- **[[wiki/concepts/policy-abstraction-hierarchy.md]]** — a second axis of the fast/slow split that is not a storage-site difference: within the cortico-striatal loops the dorsomedial/associative loop dominates early acquisition and the dorsolateral/sensorimotor loop takes over once the program is automated, so the hand-off this page describes between systems also happens *between loops of one system*.
- **[[wiki/concepts/test-time-training.md]]** — the arrangement this page's fast/slow split exists to rule out, working anyway: gradient descent on a handful of test-time examples straight into the slow system's own weights, one throwaway model per task. Why the prior knowledge survives the write is unexplained by any source in the wiki, and the fact that nothing is written back is gap G14 in its purest form.
- **[[wiki/concepts/refinement-loop.md]]** — a fast-level learner with no slow-level write-back in every 2025 instance but one (SOAR fine-tunes the model on its own search traces), so the missing consolidation channel recurs verbatim across weights, symbolic programs, prose programs and prompting harnesses.
- **[[wiki/entities/bib.md]]** — a fast-**M** probe in benchmark form: its Multi-Agent task requires a per-entity latent written from eight observations, retrieved by identity and *not* transferred when the identity changes, and the benchmark scores the non-transfer explicitly as a "no expectation" outcome.
- **[[wiki/concepts/analog-in-memory-computing.md]]** — an independent, non-biological derivation of this page's split: where a weight write costs far more than a read, storing structure in a rarely-written slow matrix and binding instances in a small frequently-written region is an energy-minimising layout — and it predicts fast-**M** size should scale with the write/read cost ratio, which no interference argument mentions.
- **[[wiki/entities/default-mode-network.md]]** — the same fast-store/slow-constructor division observed at rest rather than during consolidation: a medial temporal subsystem supplying associations and episodic detail to a dorsomedial prefrontal constructor, recruited in proportion to how much the simulation must be constrained by real episodes.
- **[[wiki/concepts/encoding-retrieval-alternation.md]]** — makes this page's fast store a *learner* rather than a buffer: at 4–8 Hz the hippocampus alternates completion (a prediction) with encoding (its outcome), and the difference is an error signal, so the store writes what it got wrong instead of writing what it was given — and the alternation is fast enough that no controller has to decide when to encode and when to recall (O'Reilly et al. 2011, reviewing Hasselmo et al. 2002).
- **[[wiki/concepts/compositionality.md]]** — the precondition for the CA1 codec above: a mapping that regenerates *novel* cortical patterns needs a componential code in which new patterns are recombinations of existing elements, which is why the decoder is the part of the CLS circuit no model learns from scratch.
- **[[wiki/entities/cn-dpm.md]]** — a machine two-store loop with the transport direction inverted: the fast store buffers only the items no slow module explains, and its consolidation product is a **new slow module** trained offline to convergence rather than an interleaved update to an existing one — which is why it forgets nothing (88.20% → 88.20% per component) and equally why nothing can ever be revised, and it relocates the interference problem from the write to the read (48.18% gating accuracy at five modules, 31.14% at twenty).
- **[[wiki/entities/ch-hnn.md]]** — a machine CLS with the fast/slow roles assigned by *paradigm* (rate ANN as mPFC-CA1 regularity extractor, spiking network as DG-CA3 specific store) rather than by learning rate, and the wiki's only running measurement of the **feedback** arrow: retraining the generaliser incrementally on the classes the fast store is learning improves both its downstream accuracy and the agreement between its modulation-signal correlations and the sample correlations (Shi et al. 2025).
- **[[wiki/concepts/developmental-heterochrony.md]]** — a second axis on the same factorization: this page separates two components by *rate*, both present from step 0, where that one separates them by **phase** — when each component's plasticity window closes — and shows the phase offset is the variable primate evolution actually moved.
- **[[wiki/entities/dqn.md]]** — the primary source for the transfer this page is usually credited with, and the measurement of how partial it was: a replay buffer stabilising a *single* learner, uniform rather than prioritised, with no slow system to consolidate into.
- **[[wiki/concepts/replay-prioritisation.md]]** — the sampling rule over this page's transport channel, from the machine side: reading the buffer in a value-propagating order is worth an exponential factor on a sparse-reward chain, so *when* an item is interleaved matters as much as *that* it is.
- **[[wiki/entities/elastic-weight-consolidation.md]]** — the argument for skipping the fast system entirely, and its scaling premise: system-level consolidation by replay needs stored memories proportional to the number of tasks, so the weights are made to carry the summary instead — which works within capacity and inverts past it, where the accumulated importance estimate retains less than no protection at all.
- **[[wiki/entities/dreamcoder.md]]** — a machine two-speed system that keeps the transport half and drops the interference half: consolidation is compression of solved instances into a symbolic slow store, with the two sleep phases assigned different jobs on the authors' own slow-wave/REM analogy.
- **[[wiki/entities/esbn.md]]** — the recollection/familiarity dissociation produced by ablating one scalar: removing the ESBN's per-row confidence value destroys same/different (100 → 50) and leaves distribution-of-three and identity rules untouched, because the first needs *how well* a memory matched and the second only *which* one did.
- **[[wiki/concepts/retrieval-mediated-learning.md]]** — a fourth traffic direction on this page's channel: the fast store's own *read* is injected into its own *write*, so what eventually consolidates to cortex is a composite the animal never experienced, and hippocampal engagement across repetitions falls while ventromedial prefrontal engagement rises in the same subjects who later infer best.
- **[[wiki/entities/state-space-composition.md]]** — sharpens what each store is supposed to hold: the slow store holds the reusable *primitives* and the policy over them, the fast store holds only which primitives sit where, so what consolidation must extract from experience is a **new primitive** rather than a new map — and a poorly modelled experience, not a rewarded one, is what should trigger it (Bakermans et al. 2025).
- **[[wiki/concepts/hierarchy-of-associativity.md]]** — supplies the encoder this page leaves implicit: the fast store's input arrives through two further recurrent association stages that make it supermodal before the store sees it, and the feedback arm is causally required to install an association in neocortex (entorhinal+perirhinal lesion abolishes pair-coding in area TE), which is consolidation-by-feedback measured rather than assumed (Higuchi & Miyashita 1996, via Lavenex & Amaral 2000).
- **[[wiki/entities/entorhinal-cortex.md]]** — supplies the one place this page's channel can be cut without damaging either learner: lesioning the temporoammonic projection (layer III → CA1) leaves acquisition and 1-day memory intact and abolishes the 28-day memory, and only if the cut is made inside a post-encoding window (Frankland & Bontempi 2005).
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — gives the cortical half of consolidation a laminar address: recall-evoked activation in parietal cortex migrates from layers V–VI to layers II–III/IV over weeks, i.e. into the layers that carry cortico-cortical connections, which is what the wiring-plasticity account of the slow rate predicts and what regional-resolution imaging cannot see.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — adds a second job to the receiving end of this page's channel: on a successful remote read the controller appears to *suppress* the fast store (hippocampal activity below control, released when the cortical match fails), so the slow learner gates the fast store's re-encoding rather than only consuming its output (Frankland & Bontempi 2005).
- **[[wiki/concepts/sleep-oscillation-nesting.md]]** — supplies the schedule this page's coupling channel runs on: a three-rhythm nesting generated in the receiver licenses the write, the licence inverts to depotentiation when the nesting fails, and the transfer is a local exception inside a global synaptic downscaling.
- **[[wiki/entities/remerge.md]]** — the amendment that softens this page's dichotomy on the *fast* side: recirculating an episodic store's own similarity computation until it settles yields links between items never experienced together, so the fast store generalizes without giving up the pattern-separated code the interference argument requires (Kumaran & McClelland 2012, via Kumaran et al. 2016).
- **[[wiki/concepts/hippocampal-indexing-theory.md]]** — the theory this page's fast store is usually read through, with a rival account of *why* the two rates differ: one plasticity rule under two induction thresholds (NMDA-receptor vs voltage-dependent-calcium-channel LTP), cortex made slow by inhibition preventing the required depolarization rather than by having to build connections.
- **[[wiki/entities/retrosplenial-cortex.md]]** — the candidate cortical store for consolidated spatial structure, with a temporal signature to match: retrosplenial damage impairs recent autobiographical retrieval while sparing remote, and fMRI shows greater retrosplenial engagement for recent than remote events (Vann et al. 2009). The signature is now contested in sign (`T384`): the second review of the same region reports emergent activity at *remote* retrieval, distinct primate activation for object–scene pairs recalled a year later, and post-training muscimol impairing 24-h memory — the standard cortical-trace gradient, opposite to the recent-biased lesion and fMRI evidence (Alexander et al. 2023).
- **[[wiki/entities/anterior-thalamic-nuclei.md]]** — offers a replacement for this page's transport framing of consolidation: two parallel streams (hippocampal–cortical and medial-diencephalic–cortical) converge on shared cortex where plasticity is proposed to require **synchronous arrival from both**, making the consolidation criterion a coincidence gate at the destination rather than a schedule at the source (`T381`).
- **[[wiki/entities/subiculum.md]]** — converts part of the consolidation channel's selectivity from a computed gate into a wiring fact: the fast store's output stage is partitioned by destination — distinct excitatory subtypes, each with its own afferents, firing phenotype and single projection target — so *which consumer receives what* is decided by which cell fires (`G14`; Kinman et al. 2026).
- **[[wiki/entities/three-factor-key-value-memory.md]]** — the fast half done without attractor dynamics, and priced: one-shot writes, graded overload, capacity linear in slots, and a neuromodulatory write-enable on the front door that decides what the slow system will ever see — which puts the division of labour's gate at the fast store's *input* rather than at the consolidation step (Tyulmankov et al. 2021).
- **[[wiki/concepts/key-value-memory.md]]** — the same two-store split re-derived from an *objective* rather than from a learning rate: hippocampus holds keys optimised for discriminating episodes, neocortex holds values optimised for semantic fidelity, and the division of labour follows because one code cannot serve both — with the hippocampal-lesion abolition of the reminder effect (Winocur et al.) as the causal evidence that without keys, cortical values can only be reached diffusely.
- **[[wiki/entities/go-explore.md]]** — the two-store split built as an engineering pipeline with the teacher removed: a fast non-parametric archive searches and accumulates specific trajectories, then a slow parametric policy is trained offline from those trajectories in a noise-injected copy of the world, so the episodic store acts as its own demonstrator and consolidation becomes learning-from-demonstrations on self-generated data.
