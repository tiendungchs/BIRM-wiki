# Hippocampal–Prefrontal Channel

**An inter-module *edge* studied as an object in its own right: the projection between the episodic store and the control layer, which turns out to carry a learning rule, a gain, a third-party lock on its own writability, a stress-set operating point, several logical channels multiplexed by frequency band, and two anatomically distinct directions with different endpoints and different cargo.**

> **Why this is an entity page and not a section.** Every architecture in the wiki draws inter-module connections as wires: a matrix, a gate, or a skip connection with at most a learned scalar. This pathway is the wiki's one worked example of a connection with **its own state, its own plasticity, its own external gate and its own failure signature** — a connection that can be lesioned, potentiated, depotentiated, locked and desynchronised independently of either endpoint. Gap **G52** is the statement that no wiki architecture has such a thing; this page is the specification it would be built from. Split out of [[wiki/entities/medial-prefrontal-cortex.md]] at the 125-ingest lint pass, where it had grown to ~30% of that page while being about neither endpoint.

**Sources.** Euston et al. 2012 (`raw/euston-2012-prefrontal-cortex-memory.md`); Spedding & Jay 2012 (`raw/spedding-2012-hippocampal-prefrontal-pathway.md`); Preston & Eichenbaum 2013 (`raw/preston-2013-hippocampus-prefrontal-memory.md`); Jin & Maren 2015 (`raw/jin-2015-prefrontal-hippocampal-interactions.md`); Sigurdsson & Duvarci 2016 (`raw/sigurdsson-2016-hippocampal-prefrontal-interactions.md`); Shin & Jadhav 2016 (`raw/shin-2016-hippocampal-prefrontal-interaction-modes.md`); Eichenbaum 2017 (`raw/eichenbaum-2017-prefrontal-hippocampal-episodic-memory.md`).

---

## The hippocampal link is one-way

> **Superseded twice below.** An indirect return path is named in "The return path, and what the channel does at each task phase" (nucleus reuniens), and a *direct* anterior-cingulate → CA1/CA3 projection in "The direct return arrow exists after all". Read this section as the anatomy of the ventral tier's **input** port only.

Hippocampal formation → medial prefrontal cortex is real, topographic (ventral subiculum and ventral CA1 → infralimbic and ventral prelimbic) and **essentially unreciprocated**: very few medial prefrontal fibres reach the hippocampal formation directly. Return influence must go through the entorhinal cortex (which *is* bidirectional with the medial wall) or through diencephalic relays. Parahippocampal coupling is bidirectional: perirhinal → infralimbic/ventral prelimbic predominantly, dorsolateral entorhinal → the whole medial wall.

**Why a builder should care.** Every schema-retrieval story in the wiki ([[wiki/concepts/complementary-learning-systems.md]], gap G37) draws a bidirectional arrow between the fast episodic store and the controller. The anatomy says the *direct* arrow runs one way: the store addresses the controller, the controller cannot address the store except through a third module. That makes "the controller queries memory" an operation requiring an intermediary — and makes entorhinal cortex, not hippocampus, the controller's actual read port.


---

## Replay, theta and the hippocampal channel

The anatomy above says hippocampus → medial wall is one-way. The physiology says what runs down it.

| Observation | Detail |
|---|---|
| **Replay exists in mPFC** | Task spike patterns replay in mPFC and nucleus accumbens during post-task rest, at an **accelerated rate** relative to behaviour, and **selectively for recently learned** events |
| **It is coupled to the hippocampus** | mPFC reactivation is strongest during high-density **low-voltage spindles**; hippocampal **sharp waves** and cortical spindles occur within a few hundred milliseconds of each other; sharp waves correlate with mPFC replay directly |
| **Direction unresolved** | Some measurements put hippocampal events first, others cortical; the proposed reconciliation is that cortical events *initiate* hippocampal replay which then reinforces the ongoing cortical replay — a loop, not a pipe |
| **Theta coupling during behaviour** | ~half of mPFC cells phase-lock to hippocampal theta; coherence **rises as the animal approaches a memory-guided choice point**, increases further **after a new rule is acquired**, and reductions in phase-locking **predict errors** |
| **No place fields, but room discrimination** | mPFC input arises from ventral/intermediate hippocampus, where fields are large enough to code global context — so the controller receives *context*, not position |
| **Disconnection ≈ bilateral lesion** | Because the pathway is unilateral, inactivating mPFC in one hemisphere and hippocampus in the other severs it while leaving one intact copy of each. Effects nearly match bilateral mPFC inactivation on water maze, T-maze, radial-arm win-shift and Hebb-Williams maze |

**The disconnection logic is a method worth keeping**, and it is available only because of the unilaterality this page establishes: it separates "this region is needed" from "this *edge* is needed" without damaging either endpoint. The machine analogue — zeroing one inter-module connection while both modules stay intact — is rarely run; ablation studies almost always remove nodes, not edges.


---

## The edge as the unit of analysis: the hippocampal→prefrontal channel has its own state

> **Provenance (third ingest).** Spedding & Jay 2012, *The hippocampal–prefrontal pathway: the weak link in psychiatric disorders?*, Eur Neuropsychopharmacol 24:1153–1165 (`raw/spedding-2012-hippocampal-prefrontal-pathway.md`). A review that takes the **projection**, not either endpoint, as the object of study — anatomy, synaptic physiology, plasticity, its behavioural necessity, its pharmacological control, and its failure signature across schizophrenia, major depression and post-traumatic stress disorder.

The sections above treat the hippocampal input as a wire that delivers context. This one measures the wire. It turns out to carry a **learning rule, a gain, a third-party lock on its writability, and a stress-set operating point** — four state variables that no inter-module connection in any wiki architecture has (gap G52).

### Where it runs

| | Rat | Monkey / human |
|---|---|---|
| Origin | Ventral CA1 and subiculum (strongest), light from intermediate third | Rostral CA1, prosubiculum, subiculum |
| Route | Fimbria/fornix, **ipsilateral** | Fimbria/fornix (inferred in humans from diffusion tensor imaging) |
| Target | Infralimbic, prelimbic, anterior cingulate; moderate to medial/ventrolateral/lateral orbital; intermediate-hippocampal subpopulation → insular | Orbital and medial prefrontal areas 11, 12, 13, 14c, 24, 25, 32; **light** to dorsolateral (areas 9, 46) |
| Reciprocity | Monosynaptic, **unidirectional** | Same; hippocampal lesion degrades ventromedial prefrontal white matter (monkey diffusion tensor imaging) |

The dorsolateral prefrontal cortex — the primate region most of the wiki's control-layer evidence comes from — receives only a *light* direct hippocampal projection. Human working-memory results attributed to hippocampal–prefrontal interaction are therefore largely about a **medial/orbital** channel, or about a multi-synaptic route.

### Transmission is excitatory onto inhibitory cells: the context input acts as a *suppressor*

Ventral-hippocampal stimulation produces short-latency AMPA-receptor excitation in prelimbic cortex **followed by inhibition of pyramidal cells**, because the same glutamatergic terminals contact GABAergic interneurons and drive feed-forward inhibition. The causal test runs the right way round: chemical inactivation of ventral hippocampus **decreases** prelimbic interneuron activity and **increases** pyramidal firing, and in fear-extinguished rats specifically, increases freezing.

**So removing the context channel does not silence the controller — it disinhibits it.** The pathway's normal action is to *withhold* prefrontal output that the current context does not license. This inverts the wiki's standing picture of the channel as content delivery ([[wiki/empirical-tensions.md]] T98) and makes it a worked instance of addressed suppression ([[wiki/concepts/inhibitory-control-of-coding.md]]).

### The edge is where the memory is stored, and it is gated by a third region

| Property | Measurement |
|---|---|
| Plasticity repertoire | Long-term potentiation, long-term depression **and depotentiation**; bidirectional |
| Requirements | NMDA-receptor dependent, protein-kinase-A dependent; **dopamine D1 is the key regulator**, with serotonergic, noradrenergic and cholinergic modulation |
| **Metaplastic lock** | High-frequency stimulation of basolateral amygdala **prevents subsequent induction of potentiation** in the pathway. A third region decides whether this edge may be written |
| Behavioural read-out | Fear-extinction training **potentiates** the pathway; low-frequency stimulation of ventral hippocampus after extinction depotentiates it **and abolishes extinction recall** |
| Developmental gate | Stress at three weeks post-birth prevents extinction-induced potentiation **in adulthood**; the partial NMDA agonist d-cycloserine near extinction rescues it |
| Stress sensitivity | A *single* elevated-platform exposure blocks potentiation induction; reversed by antidepressants, by glucocorticoid-receptor antagonists, and by clozapine (at the dose that also restores hippocampal–prefrontal coherence). Chronic stress → prefrontal dendritic atrophy, lost potentiation, impaired working memory and behavioural flexibility |
| Molecular correlates of the stress effect | Region- and subunit-specific glutamate-receptor phosphorylation changes; MEK/MAPK and brain-derived neurotrophic factor downregulation, both antidepressant-reversible |

**(brainstorm) The importable object is an edge with a four-tuple of state**: `(weight, gain, writability, decay)`, where *weight* is set by the local Hebbian rule, *gain* by dopamine at the terminal, *writability* by a signal from a module that is neither endpoint (amygdala), and the whole tuple is displaced for hours-to-weeks by a scalar stress variable that reaches every edge in the network at once. The nearest machine construct is a gated skip connection with a learned scalar — but nobody gives that scalar its own plasticity, its own external lock, or a global mode switch. The concrete experiment: in a two-module model with a learned inter-module gate, let a third module emit a binary write-mask on that gate and check whether the resulting behaviour is *stateful in the order of training episodes* the way extinction-then-low-frequency-stimulation is. If the wiki's consolidation stories are right that only the *mapping* transports (Euston et al. 2012, [[wiki/entities/medial-prefrontal-cortex.md]]), then the mapping lives on edges, and edge-level state is where continual-learning protection should be applied — not on the units.

### Context selects which memory is expressed, and the disconnection proves it is this edge

Fear extinction does not erase the original association; it adds a second, context-limited one. Expression of the extinguished response outside the extinction context (**fear renewal**) is abolished by ventral-hippocampal inactivation *and* by asymmetric disconnection of ventral hippocampus from prelimbic cortex. The context posterior of [[wiki/concepts/contextual-inference.md]] therefore has a named carrier, and cutting the carrier does not degrade either memory — it removes the *selection* between them.

### Convergence and timing, at two downstream junctions

| Junction | Finding | Reading |
|---|---|---|
| Single mPFC neurons | Receive convergent basolateral-amygdala and ventral-hippocampal input; the **relative timing** of the two inputs strongly influences firing probability | A coincidence gate, not a sum: context and valence must arrive in a window |
| Single nucleus-accumbens neurons | Receive convergent ventral-hippocampal and prefrontal input; coincident activation drives goal-directed behaviour, and dopamine modulates the glutamatergic afferents | The action-selection stage is a second AND-gate, with the same neuromodulator setting its threshold |
| Ascending vs. descending amygdala link | Disrupting basolateral amygdala, accumbens core, or their communication **reduces** choice of the large-uncertain option; disrupting the **descending** prefrontal→amygdala direction **increases** it; the ascending direction does not (Floresco et al.) | Two directions of one reciprocal connection carry opposite behavioural terms — a directed-edge dissociation, obtainable only with per-direction manipulation |
| Dopamine on the channel | Dopamine applied to prefrontal cortex **increases** hippocampal–prefrontal coherence; D1 activation raises interneuron excitability; D1 blockade impairs working memory | The coherence the wiki treats as a measured signature is a *controllable* variable with a known knob |

### Human evidence, and the failure signature

- Intracranial recording in epilepsy patients: theta coherence between medial temporal lobe and prefrontal cortex **rises during memory recall**, with higher **directed information flow medial-temporal → prefrontal** — the human match to the rodent 50 ms hippocampus-leads phase lag.
- Hippocampus and medial prefrontal cortex are both default-network nodes and are functionally coupled at rest, so the same edge carries both task-driven and self-generated ("mental simulation") traffic.
- **The "weak link" thesis:** schizophrenia, major depression and post-traumatic stress disorder share cognitive impairment and emotional dysregulation, and each shows structural (fornix, hippocampal volume, prefrontal thinning) *and* coupling abnormalities on this pathway — present in first-episode and at-risk individuals, so not a consequence of chronicity or medication. Animal models converge: maternal immune activation lowers hippocampal–prefrontal theta coherence (clozapine-reversible, dose-dependent) and the 22q11.2-deletion Df(16)A± mouse shows impaired coherence alongside cognitive deficits.

**(brainstorm) The diagnostic move is the one worth stealing, independent of the psychiatry.** A single shared edge failing produces a *joint* symptom profile that looks like several distinct disorders when scored per-symptom. Applied to model debugging: a family of seemingly unrelated behavioural failures (poor rule switching, poor extinction of a learned association, poor context-specific retrieval) is the predicted signature of one degraded inter-module channel, and the cheap test is the disconnection — sever the edge in an otherwise intact model and check whether the whole failure profile appears together. The wiki has no evaluation that scores a *profile* rather than a task.
---

## The return path, and what the channel does at each task phase

> **Provenance (fifth ingest).** Jin & Maren 2015, *Prefrontal-hippocampal interactions in memory and emotion*, Front Syst Neurosci 9:170 (`raw/jin-2015-prefrontal-hippocampal-interactions.md`). A review of both the direct and the **indirect** hippocampal–prefrontal pathways. Its reuniens material has its own page: [[wiki/entities/nucleus-reuniens.md]].

**The one-way section above is now half-retired.** The direct projection is still monosynaptic and unreciprocated, but the return route is named and lesioned: medial prefrontal cortex → **nucleus reuniens** → hippocampus, with a reciprocal arm and — the detail worth importing — *single* reuniens neurons collateralising to both endpoints. The prefrontal → reuniens → septal hippocampus arm carries the **future path** during goal-directed behaviour (Ito et al. 2015). So the two directions carry different types: the store sends *context* up, the controller writes a *goal-conditioned trajectory* down.

**The functional dependence was symmetric all along.** Prefrontal lesions disrupt the spatial firing of hippocampal place cells; hippocampal lesions disrupt anticipatory prefrontal activity in working-memory tasks (Kyd & Bilkey 2003; Burton et al. 2009). Mutual dependence under one-way direct wiring is the signature that predicted an indirect return path before one was demonstrated.

### The edge is needed at *encoding*, while the region is needed at *retrieval*

Spellman et al. 2015, optogenetic terminal inhibition of the ventral-hippocampus → medial-prefrontal projection in a four-goal T-maze:

| Observation | Detail |
|---|---|
| Epoch of necessity | Inhibiting the terminals during **cue encoding** impairs performance; the pathway is required for encoding task-relevant spatial cues at both neuronal and behavioural levels |
| Frequency band | **Gamma (30–70 Hz)** in the pathway correlates with successful cue encoding and with correct trials, and is abolished by terminal inhibition |
| Relation to theta | Theta (4–10 Hz) phase-locking, with prefrontal firing lagging the hippocampal local field potential, is the *coordination* signature; gamma is the *content-transfer* signature on the same wire |

This sets up a phase dissociation the wiki should carry explicitly ([[wiki/empirical-tensions.md]] T100): the **region** is dispensable at encoding and required at retrieval (spatial win-shift, [[wiki/entities/medial-prefrontal-cortex.md]]), while the **edge into it** is required at encoding. Both can be true — the controller acquires the cue→context mapping through this channel and is queried later — but no wiki architecture assigns different task phases to a module and to its input link, and lesion designs that hit the region cannot detect the difference.

### The context channel is also a gate on a third connection

- Ventral-hippocampal neurons projecting to **both** medial prefrontal cortex and amygdala are preferentially recruited during fear renewal (Jin & Maren 2015) — the same collateral-broadcast motif as reuniens, one axon addressing two targets.
- The hippocampus thereby **gates the reciprocal prefrontal↔amygdala circuit** that expresses and inhibits fear (Herry et al. 2008; Knapska & Maren 2009; Knapska et al. 2012), rather than only delivering context to the controller.

**(brainstorm)** Combined with the amygdala's metaplastic lock on hippocampal→prefrontal potentiation (Spedding & Jay 2012, above on this page), the three regions form a **mutual write-gating triangle**: each pair's edge is licensed by the third node. That is a strictly stronger construct than gap G52's single-edge state tuple — the write-mask is not an external signal but the network's own third vertex, so no node is privileged as the gate-setter.

### Frequency bands divide labour on the same channel

In monkeys learning object–paired associates, different frequency bands within hippocampus and prefrontal cortex carry different functional roles (Brincat & Miller 2015). With the gamma/theta split above, the channel is **frequency-multiplexed**: one anatomical wire, several concurrent logical channels distinguished by band. No architecture in the wiki has more than one logical channel per connection.

### The episodic-memory division of labour

Prefrontal damage spares familiarity-based recognition and impairs **recollection-based** memory — retrieval of contextual and temporal information, and resolution of interference. The proposed split (Dolan & Fletcher 1997): the controller integrates old and new memories that share **overlapping features**, the hippocampus forms new ones. This is the same variable as integration demand on [[wiki/concepts/schema-assimilation.md]], reached from the human neuropsychology side rather than the rodent lesion side.

---

## The direct return arrow exists after all, and it is addressed to hubs

> **Provenance (sixth ingest).** Sigurdsson & Duvarci 2016, *Hippocampal-prefrontal interactions in cognition, behavior and psychiatric disease*, Front Syst Neurosci 9:190 (`raw/sigurdsson-2016-hippocampal-prefrontal-interactions.md`). A review organized around the measurement of the interaction; its methodological core has its own page, [[wiki/concepts/inter-areal-synchrony.md]].

**The one-way section above is now fully retired.** A **monosynaptic** projection runs prefrontal cortex → dorsal hippocampus in the mouse (Rajasethupathy et al. 2015):

| Property | Detail |
|---|---|
| Origin | **Anterior cingulate** subdivision of the medial wall — the *dorsal* tier, not the ventral one that receives the hippocampal input |
| Termination | **CA1 and CA3** of the dorsal hippocampus |
| Causal status | Optogenetically **necessary and sufficient** for retrieval of a spatial memory (assayed by contextual fear) |
| Target selection | Preferentially innervates **highly connected "hub" neurons** within the hippocampal network — cells that *emerge after learning* |
| Other evidence | Prefrontal inactivation changes hippocampal place-cell activity in memory-guided tasks (Navawongse & Eichenbaum 2013) |

So the circuit is not "store addresses controller, controller replies through a relay". It is **two direct arrows with different endpoints**: ventral hippocampus → ventral medial wall (context in), anterior cingulate → dorsal CA1/CA3 (retrieval trigger out). The two tiers of the medial wall ([[wiki/entities/medial-prefrontal-cortex.md]]) are the two ports: the tier that receives from the store is not the tier that writes to it.

**(brainstorm) Addressing by connectivity rank is a memory-system primitive the wiki has no version of.** Every read in the wiki is content-addressed — a query vector against stored keys ([[wiki/concepts/attention.md]], [[wiki/concepts/pattern-separation-completion.md]]). Here the controller's axons find their targets by the targets' *graph degree inside the store*, and that degree is itself a product of learning. A one-line write to a learning-created hub triggers completion of the whole pattern, which is a retrieval interface whose bandwidth is independent of the memory's size — and it makes hub formation, not the memory trace, the thing consolidation has to produce ([[wiki/concepts/engram.md]], [[wiki/concepts/latent-graph-discovery.md]]).

### The choice-phase requirement runs on a different route than the encoding one

Silencing the direct ventral-hippocampal terminals abolishes pathway **gamma** and impairs the **sample** phase, and leaves **theta** — the band that rises at the **choice** point — untouched ([[wiki/concepts/inter-areal-synchrony.md]]). Since the choice phase is when theta coupling peaks and predicts correctness, the two task phases are served by **different pathways**, not merely by different bands of one: encoding by the direct projection, choice by an indirect route (reuniens, ventral hippocampus as synchronizer, septum). This sharpens [[wiki/empirical-tensions.md]] T100 from a phase puzzle into a routing claim.

Two further constraints from the same source:

- **Coupling with the ventral pole exceeds coupling with the dorsal pole** (Adhikari et al. 2010; O'Neill et al. 2013), matching the monosynaptic origin — and inactivating ventral hippocampus **desynchronizes prefrontal–dorsal-hippocampal theta**, so the ventral pole is also the other two nodes' synchronizer, not only the wiki's "context supplier".
- **The coupling is acquired.** Theta synchrony rises across learning of a spatial working-memory task in parallel with performance (Sigurdsson et al. 2010), and its loss is the measured phenotype in every 22q11.2, *Zdhhc8*, neuregulin, maternal-immune-activation and neurodevelopmental-lesion model examined — with synchrony deficits correlating with working-memory impairment, and, in *Zdhhc8* mice, with **reduced axonal branching of ventral-hippocampal terminals in prefrontal cortex** (Mukai et al. 2015). That is the wiki's one case where a behavioural deficit is traced to the *wiring of a single edge* rather than to either module.


---

## Two communication modes on one wire, and the selector is the animal's behavioural state

> **Provenance (seventh ingest).** Shin & Jadhav 2016, *Multiple modes of hippocampal-prefrontal interactions in memory-guided behavior*, Curr Opin Neurobiol 40:161–169 (`raw/shin-2016-hippocampal-prefrontal-interaction-modes.md`). The review that states the multiplexing claim above as a *thesis* rather than an inference from a band correlation: network patterns are not epiphenomena of local processing but **conduits selected by current cognitive demand and internal state**.

### The modes, and what each is anchored to

| Mode | Band | Behavioural epoch it occupies | What is coordinated across the two regions | Causal status |
|---|---|---|---|---|
| **Theta** | 6–12 Hz | Locomotion, active exploration, approach to a choice point | Prefrontal cells phase-lock to hippocampal theta at region-characteristic phases; coherence rises at the choice point, is higher on correct trials, and **emerges only after the rule is learned** | Correlational. Inactivating the *direct* hippocampus→prefrontal terminals leaves theta synchrony intact (T333 Position B); ventral-hippocampal inactivation disrupts it — so the theta mode is carried by a relay, not by these axons |
| **Awake sharp-wave ripple** | 150–250 Hz, ~100 ms transients | Immobility, consummatory behaviour at reward wells — i.e. the complement of the theta epoch | Coordinated *reactivation*: hippocampal place-cell sequence replay co-occurs with structured prefrontal ensemble activity representing the same trajectory | Awake ripple disruption impairs spatial learning (Jadhav et al. 2012); the *coordination* itself has not been perturbed |
| **Gamma** | slow 40–60 Hz, fast 80–120 Hz | Both epochs — nested under theta during running, and under ripples at rest | Prefrontal gamma is coordinated with hippocampal theta; silencing ventral-hippocampal terminals abolishes prefrontal gamma and prefrontal task representations, and selectively impairs *encoding* (T100 Position A) | Interventional on one direction. **Hippocampal–prefrontal gamma *coherence* itself is asserted, not measured** — the source's own caveat |
| **Beta, 4 Hz** | 15–20 Hz; ~4 Hz | Proposed, not localised | — | Named only |

**The two principal modes are mutually exclusive in time and the exclusion is not negotiated between the endpoints.** Theta runs while the animal moves; ripples occur when it stops. The variable that selects which logical channel is open is **running speed / behavioural state** — a signal both endpoints have access to and neither computes. No wiki architecture has this: an inter-module link whose active channel is set by a *global state scalar external to both modules*, rather than by a gate computed from the content on the wire.

### The ripple-mode read rule is content-addressed and two-sided

The one mechanism here that is specific enough to implement (Jadhav et al. 2016, the source's ref 26):

- Prefrontal cells whose spatial representation **overlaps** the hippocampal sequence being replayed are **excited** during the ripple.
- Prefrontal cells whose representations are **unrelated** are **suppressed**.
- The reactivated content mirrors the hippocampal–prefrontal pairings that were coordinated during the *theta* mode earlier in the same session.

So the offline mode is not a broadcast into the controller: it is a **match-gated read with an inhibitory complement**, and its addressing key is the receiver's own tuning. Two consequences a builder can take:

- Every replay interface in the wiki writes *additively* into a downstream learner ([[wiki/concepts/offline-replay.md]], [[wiki/concepts/complementary-learning-systems.md]]). Here the same event **lowers** the activity of the non-matching part of the target — which is a signal-to-noise operation on the receiver, not a delivery, and is the population-level twin of the inhibitory selectivity [[wiki/entities/inhibitory-replay-filter.md]] localises inside the store.
- The third bullet makes the two modes *sequentially coupled*: theta-mode coactivation during behaviour determines which cell pairs are eligible for ripple-mode reactivation at rest. The online mode writes the address book the offline mode reads.

**(brainstorm)** Written as an update rule for a two-module machine: online, `s ∈ {move, still}` selects the channel; in `move`, module pairs that co-fire accumulate an eligibility `e_{ij}`; in `still`, a sampled sequence from the store drives target units with gain `+g·e_{ij}` and non-matching units with `−g·(1−e_{ij})`. That is three lines on top of any replay buffer and it makes the offline pass contrast-enhancing rather than merely rehearsing — testable directly against an additive-replay control on any continual-learning benchmark.

### The causal test none of the modes has passed, and its shape

The source's methodological core, and it is a specification for an instrument the wiki keeps needing: **real-time pattern detection closed onto temporally precise perturbation.** Detect a ripple, a theta phase, or a bout of high inter-regional coherence *as it happens*, and perturb only then. Demonstrated for patterns *within* hippocampus (Jadhav et al. 2012); never yet for an inter-regional coupling. The stricter version — perturb the *coherence* without perturbing either population's firing — has no known method, since it would require changing one region's oscillation frequency by neuromodulation alone.

Why this matters beyond neuroscience: the analogous machine experiment is equally unrun. Cutting an inter-module link and cutting the link *only during events of a named type* are different ablations, and only the second discriminates a communication mode from a wire ([[wiki/concepts/certification-instruments.md]], [[wiki/concepts/perturbation-elicitability.md]]).

### What the modes are still missing

| Open question | Why it is load-bearing |
|---|---|
| Are prefrontal representations aligned with hippocampal **theta sequences** — the within-cycle compressed trajectories — or only with the theta rhythm? | Decides whether the theta mode transports *content* (a candidate future trajectory) or only a timing frame. This is G54's question asked of the wiki's best-characterised edge, and it is open |
| Is ripple-mode coordinated reactivation **retrospective** (consolidating what happened) or **prospective** (proposing what to do)? | The same event would be a consolidation write or a planning read; the two demand opposite arbitration policies in [[wiki/concepts/offline-replay.md]]'s eight-job table |
| How do the two modes **trade off across learning**? Theta coherence appears after learning; ripples are upregulated by novelty and reward | If the mode mixture is a function of learning stage, the state variable that selects the channel is not just behavioural state but a competence estimate |

---

## The third route is cortical, and it is where the controller does its suppressing

> **Provenance (eighth ingest).** Eichenbaum 2017, *Prefrontal–hippocampal interactions in episodic memory*, Nat Rev Neurosci 18:547–558 (`raw/eichenbaum-2017-prefrontal-hippocampal-episodic-memory.md`). A review that assembles the direct pathway, the thalamic relay and a **third, cortical** route into one circuit model of context-cued retrieval, and assigns each route a task phase.

The page has carried two routes: the direct ventral-hippocampal input and the reuniens relay. There is a third, and it is the one the top-down half of every schema story in the wiki has been missing a carrier for.

| Route | Wiring | Cargo assigned by the model | Task phase |
|---|---|---|---|
| **Direct** | Ventral/intermediate CA1 + proximal subiculum → **all layers** of medial and orbital prefrontal cortex | *Context* — broad spatial/contextual code of the ventral pole, not detailed memories | Context entry / sample |
| **Thalamic** | Medial prefrontal ↔ **nucleus reuniens** ↔ CA1 (whole dorsal–ventral extent), perirhinal and entorhinal cortex | Coordination — which direction is open, and when | Both, as the selector |
| **Cortical** | Medial prefrontal → **superficial** layers of perirhinal cortex and **deep** layers of lateral entorhinal cortex; reciprocal back to prefrontal layers I, II, VI. Projection to *medial* entorhinal cortex is **weaker** | *Rule-based suppression* of context-inappropriate object and event representations | Choice / retrieval |

Two things the asymmetry buys a builder:

- **The top-down arm is typed for objects and events, not for space.** Perirhinal and lateral entorhinal cortex represent items and specific behavioural events ([[wiki/concepts/nonspatial-maps.md]]); the medial entorhinal projection is weak. So the controller's write is addressed to the *what* stream of the store's input and largely bypasses the *where* stream — the two-stream split of `G43`/`T47` read from the control side.
- **The suppression is applied at the store's input gateway, not at the store.** Perirhinal and lateral entorhinal cortex gate what enters the hippocampus at all; the prefrontal cortex projects to inhibitory neurons in cortical targets. So "top-down control of retrieval" is implemented as narrowing the *input* the store is allowed to complete from, not as filtering the store's output — an arrangement no wiki architecture has (`G110`).

### The controller's contribution to the store's code is one feature dimension, and it is measured

Navawongse & Eichenbaum 2013 — dorsal CA1 recorded in a context-guided object–reward task, before and after muscimol inactivation of either prefrontal cortex or medial entorhinal cortex. The channel page's limitation "nothing localises the content on this channel" now has a partial exception:

| Inactivation | Effect on dorsal CA1 conjunctive cells |
|---|---|
| Medial prefrontal, **bilateral** — or **unilateral ipsilateral** to the recorded cells | **Object selectivity lost, spatial specificity intact.** Cells that had fired for one object in one place now fire for *multiple* objects in that same place |
| Medial prefrontal, unilateral **contralateral** | No effect — the influence is ipsilateral, matching the crossed-lesion result |
| Medial entorhinal | Broad **remapping** of both object and spatial coding: cells fall silent, acquire new place or object fields, or change unpredictably |

**The reading.** The entorhinal input sets the *organisation* of the store's code; the controller sets the *selectivity* of one dimension inside it. Removing the controller does not degrade the store toward noise — it degrades one factor of a conjunctive code toward *promiscuity*, which is the population-level version of the behavioural failure mode below. This is the sharpest content localisation the wiki has for any controller→store arrow, and it is a **factorised** result: an architecture in which the controller's write is a global gain or a retrieval query cannot produce a lesion that touches one factor of a conjunction and leaves the other exact.

### The controller's failure mode is confident intrusion, not forgetting

The double dissociation that types the two modules, run on the same odour-list recognition task in rats:

| Lesion | Failure |
|---|---|
| Hippocampus | Memory for odours on **today's** list is lost (Fortin et al.) |
| Prefrontal cortex | Today's list is remembered; odours from **previous days' lists** are falsely recognised (Farovik et al.) |
| Ageing | **Both** failures together |

The human match: patients with prefrontal damage learning `A–B` then `A–C` paired associates are severely impaired on the second set, and the impairment takes the form of **intrusions of the original associate** — and memory for one list is compromised by intrusions from the other even when the two lists share no items. Extinction of contextual fear and selective attention to specific cues fail the same way.

**This is exactly `T98` Position B's predicted ablation signature — but it is produced by removing the *controller*, not by removing the hippocampal input to it.** The reconciliation the model offers: the forward leg delivers *context content* up, and the suppression happens on the *return* leg, applied by the controller to perirhinal/lateral entorhinal cortex. Content and gain are then not competing readings of one wire; they are the two legs of a loop, and `T98`'s dissociation experiment should be run per-direction.

Miller & Cohen's framing, which the review adopts: the hippocampus lays down **tracks**, the prefrontal cortex **switches between them** by contextual rule. The interference results say the switch's failure is not a stall — it is running the previous track confidently.

### The direction of the channel reverses *within* a trial, and both reversals predict accuracy

| Task epoch | Lead | Band | Trials on which it appears |
|---|---|---|---|
| Waiting in the start box during a memory delay (delayed spatial alternation) | Dorsal hippocampus leads prefrontal by **~30 ms** | Theta | Correct only |
| Traversing the choice point, memory-driven decision | Prefrontal leads dorsal hippocampus | **Low gamma, 30–80 Hz** | Correct only |
| Entering a spatial context (context-guided memory) | Hippocampus leads prefrontal by **~30 ms** | Theta | Correct only |
| Sampling an object before the decision, same task | **Prefrontal leads hippocampus by ~30 ms** | Theta | Correct only |

Neither direction appears in a control task that makes no trial-specific memory demand. In the context-guided study the correct/error comparison is restricted to trials with the *same* behavioural response, so the connectivity difference is not a motor or reward-expectation confound — a control worth importing into any claim that a measured coupling "predicts performance".

Three constraints follow:

- **The two studies disagree on the band of the return leg** (low gamma vs theta) while agreeing on its direction and its timing. The review leaves this open; it is a live problem for the band-types-the-mechanism rule at [[wiki/concepts/inter-areal-synchrony.md]].
- **~30 ms exceeds the monosynaptic conduction delay of ~15 ms.** So the lead is not the wire's latency. Two readings offered: the theta rhythm synchronises the two areas and information moves in **~30 ms packets, one gamma cycle each**; or the transfer is polysynaptic even inside the "monosynaptic" pathway, via interneurons at the target. **(brainstorm)** The first reading is the importable one — it says the inter-module link has a **quantum**, a fixed-size packet whose duration is set by a nested faster rhythm and not by the message. Every inter-module link in the wiki transfers a whole tensor per step at whatever size it happens to be; nothing has a per-transfer budget that the sender must chunk into.
- **Direction is a per-epoch variable, not a property of the architecture.** The same pair of modules runs store→controller during the delay and controller→store at the decision, with a third module (reuniens) doing the switching. No wiki architecture re-selects which way an edge runs partway through one forward pass (`G110`).

### The relay may not be carrying anything

The reuniens evidence in this review argues against the content reading [[wiki/entities/nucleus-reuniens.md]] takes from Ito et al. 2015:

- Reuniens firing rates **differentiate** left-turn from right-turn routes on the common maze segment, but the firing patterns **contain no detailed trajectory information** — enough to bias, not enough to specify (Ito et al., continuous spatial alternation). Optogenetic inactivation of reuniens eliminates the *rate coding* of trajectory in CA1 itself.
- **Artificial** optogenetic drive of reuniens works: net excitation increases freezing in a novel context, net inhibition decreases it (Xu & Südhof 2013). A channel whose *arbitrary* activation improves the specificity of a memory is not delivering that memory's content.
- Muscimol inactivation of reuniens during the delay or the choice phase reduces prefrontal phase-locking to dorsal-hippocampal theta and **eliminates bidirectional functional connectivity** — the relay's measured effect is on the coupling, not on either representation.
- Prefrontal→reuniens inactivation leaves contextual-fear *acquisition* intact and causes **overgeneralisation** to a different context, and only when applied during training.

Logged as [[wiki/empirical-tensions.md]] `T339`. The distinction matters because the two readings need different machine constructs: a content relay is a trained module with its own representation, a coordinator is a low-dimensional switch that opens one direction of an existing edge and carries no payload at all.

### What the model predicts and nobody has run

The review's own missing element, and it is a clean experimental specification the wiki can hold as an open row: **the perirhinal/lateral-entorhinal route has never been manipulated.** The predictions are (i) prefrontal inactivation should reduce the *specificity* of representations in perirhinal and lateral entorhinal cortex, and (ii) inactivation of perirhinal/lateral entorhinal cortex should reduce dorsal-CA1 cells' ability to respond to specific stimuli. Until (i) is run, the claim that the controller suppresses at the gateway rests entirely on the CA1 read-out two synapses downstream.


---

## The channel as a specification, in one table

What a builder would have to implement to have this edge rather than a weight matrix.

| Property of the edge | Measured statement | Machine construct that would carry it | Present in any wiki architecture? |
|---|---|---|---|
| **Weight** | Bidirectional plasticity — potentiation, depression *and* depotentiation — NMDA- and protein-kinase-A-dependent | A learned inter-module projection | Yes, universally |
| **Gain** | Dopamine at the terminal raises hippocampal–prefrontal coherence; D1 blockade impairs the task | A learned or state-set scalar on the projection | Rarely; a gated skip connection is the nearest |
| **Writability** | High-frequency amygdala stimulation *prevents* subsequent potentiation of this edge — a third region licenses the write | A write-mask on the projection emitted by a module that is neither endpoint | **No** (G52) |
| **Operating point** | One elevated-platform stress exposure blocks induction; developmental stress blocks it into adulthood; reversed pharmacologically | A global scalar displacing the whole tuple, on a timescale far longer than the task | **No** |
| **Sign at the target** | Terminals contact GABAergic interneurons; inactivating the source *disinhibits* the target | A projection whose default action is suppression, not delivery | **No** — every wiki channel is additive content |
| **Multiplexing** | Gamma carries content at encoding; theta carries coordination at choice; the two dissociate under terminal silencing | Several logical channels on one anatomical connection, separated by band | **No** — one logical channel per connection |
| **Mode selection** | Theta mode during locomotion, ripple mode during immobility; the two never overlap and the selector is the animal's running speed | A global state scalar, computed by neither endpoint, choosing which logical channel is open | **No** — where a wiki channel is gated at all, the gate is a function of the content on it |
| **Read rule of the offline mode** | Ripple-coordinated reactivation *excites* target cells whose representation matches the replayed sequence and *suppresses* those whose does not | A match-gated write with an inhibitory complement on the receiver | **No** — every replay interface in the wiki writes additively |
| **Direction typing** | Ventral hippocampus → ventral medial wall carries *context in*; anterior cingulate → dorsal CA1/CA3 carries a *retrieval trigger* out; prefrontal → reuniens → hippocampus carries a *goal-conditioned trajectory* down | Distinct, separately addressed forward and return links with different payload types | **No** — return arrows are transposes |
| **Target addressing** | The return arrow preferentially innervates high-degree hub neurons that *emerge after learning* | Addressing by the target's graph degree inside the store, rather than by content similarity | **No** ([[wiki/concepts/attention.md]] is content-addressed throughout) |
| **Direction, per epoch** | Hippocampus leads by ~30 ms at context entry, prefrontal leads by ~30 ms at object sampling, in the same task and only on correct trials; a third module (reuniens) does the switching | An edge whose direction is re-selected partway through one forward pass by a signal from neither endpoint | **No** (`G110`) |
| **Transfer quantum** | The ~30 ms lead exceeds the ~15 ms monosynaptic delay; proposed as one gamma-cycle packet inside a theta frame | A per-transfer size budget the sender must chunk its message into | **No** — every link moves a whole tensor per step |
| **Site of top-down control** | The controller projects to perirhinal/lateral entorhinal cortex, which gate the store's *input*, and its removal costs the store one factor of a conjunctive code (object selectivity) while sparing the other (place) | Control applied to the interface module upstream of the store rather than to the store or its output | **No** (`G110`) |

**(brainstorm)** Read as a whole, the table says the wiki has been modelling inter-module communication at roughly the level of detail it models a single synapse — and that the interesting variables all live one level up. The cheapest experiment that would put a number on it: take any two-module model with a learned interface, add *only* the write-mask row (a third module emitting a binary licence on the interface's plasticity), and measure whether continual-learning interference falls. Every other row costs an architecture change; that one costs a mask.

---

## Limitations

| Limit | Consequence |
|---|---|
| Almost all of the physiology is rat, and the primate/human evidence is coherence and diffusion imaging | The four-tuple of edge state is established in a species where the target region's homology to primate prefrontal cortex is itself contested ([[wiki/entities/medial-prefrontal-cortex.md]] limitations) |
| The dorsolateral prefrontal cortex receives only a *light* direct hippocampal projection | Most primate control-layer evidence in the wiki is about a region this channel barely reaches; human "hippocampal–prefrontal" working-memory results are medial/orbital, or multi-synaptic |
| The frequency-multiplexing claim rests on band correlations plus one terminal-silencing dissociation | "One wire, several logical channels" is the reading, not a demonstrated decoding of two independent payloads |
| Nothing measures what the channel *carries*, only when it is required and at what frequency | The cargo is inferred from the origin's tuning (ventral pole = context generality), never read off the axons |
| The mode taxonomy is built from separate experiments, never from one recording of a full learning curve | "Two modes trading off across learning" is a proposal; no study measures theta coherence and ripple coordination in the same animals from naive to expert (Shin & Jadhav 2016) |
| No mode has been perturbed *as a mode* | Every causal result cuts an anatomical link or silences a region for a block of time; closed-loop detection-triggered perturbation of an inter-regional pattern has not been done, so "communication mode" rests on the co-occurrence of a band and an epoch |
| The cortical (perirhinal / lateral entorhinal) route has never been manipulated | The claim that the controller suppresses at the store's input gateway rests on a CA1 read-out two synapses downstream, plus anatomy; Eichenbaum 2017 states the two missing experiments himself |
| The direction-reversal studies disagree on the band of the return leg | Low gamma in one task, theta in another, with the same ~30 ms lead and the same correct-trials-only signature — so the band-types-the-mechanism rule does not yet cover the return direction |
| Rodent–primate prefrontal homology is unresolved and the review says so | Every pathway assignment on this page is rat; which human prefrontal region inherits which route is not settled |
| The psychiatric convergence is correlational | The "weak link" thesis is a strong organising claim built on coupling abnormalities that could be downstream of either endpoint |

---

## Connections

- **[[wiki/entities/medial-prefrontal-cortex.md]]** — one endpoint, and the page this one was split from: the medial wall's two tiers are the channel's two ports, and the tier that *receives* the store's context is not the tier that *writes back* to it.
- **[[wiki/entities/nucleus-reuniens.md]]** — the indirect return arm of this channel, with the detail that makes it more than a relay: single reuniens neurons collateralise to both endpoints, and the arm carries a goal-conditioned future path rather than a transposed copy of the forward message.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — the measurement apparatus for this channel: coherence, phase-locking and directed information are how the edge's state is read out at all, and this page supplies the case where a band dissociation (gamma at encoding, theta at choice) turns into a routing claim about two different pathways.
- **[[wiki/concepts/contextual-inference.md]]** — names the carrier of the context posterior: asymmetric disconnection of ventral hippocampus from prelimbic cortex abolishes fear renewal without degrading either memory, so cutting this edge removes the *selection* between contexts rather than any content.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — a worked instance of addressed suppression at the level of a whole projection: the channel's terminals drive feed-forward inhibition, so the context input withholds prefrontal output the context does not license, and removing it disinhibits the controller.
- **[[wiki/concepts/schema-assimilation.md]]** — supplies the channel's cargo type: the hippocampal long axis is a generality gradient and the controller is wired only to its general end, so what travels the edge is what all events of a context share, not an event.
- **[[wiki/concepts/certification-instruments.md]]** — the instrument this channel's evidence is missing and names: every causal result here cuts a wire or silences a region, while discriminating a *communication mode* from an anatomical link requires closed-loop detection of the pattern gating a perturbation to just those events.
- **[[wiki/entities/inhibitory-replay-filter.md]]** — the same sign trick one level down: this channel's ripple mode suppresses non-matching prefrontal cells while exciting matching ones, and that model derives the intra-hippocampal version of the selectivity from Hebbian potentiation at inhibitory synapses.
- **[[wiki/concepts/offline-replay.md]]** — the channel's idle-time traffic: prefrontal replay is accelerated, selective for rewarded routes, and coupled to hippocampal sharp waves via spindles, with the initiating direction still unresolved.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the architectural claim this channel tests: the fast/slow arrow every version of that theory draws bidirectionally is, anatomically, two separate directed edges with different endpoints, different cargo and different task phases.
- **[[wiki/concepts/engram.md]]** — the return arrow's targets are high-degree hub neurons that emerge *after* learning, which makes hub formation rather than the trace itself the thing consolidation has to produce.
- **[[wiki/concepts/latent-graph-discovery.md]]** — addressing by connectivity rank is a retrieval interface whose bandwidth is independent of memory size: a one-line write to a learning-created hub triggers completion of the whole pattern, which is graph structure being used as an address space.
- **[[wiki/concepts/attention.md]]** — the contrast that makes the hub finding interesting: every read in the wiki is content-addressed (a query against stored keys), and this channel's return arrow is addressed by the target's degree inside the store instead.
- **[[wiki/concepts/pattern-separation-completion.md]]** — what the hub write triggers: a one-line input to a high-degree node runs completion over the stored pattern, so the channel's bandwidth requirement is set by the store's attractor structure rather than by the memory's size.
- **[[wiki/concepts/dynamic-network-connectivity.md]]** — the same "gain register separate from the weight register" idea at a different scale: that page places it on a single spine, this one places the whole four-tuple on an inter-regional projection, and dopamine is the shared knob.
- **[[wiki/concepts/working-memory.md]]** — the phase dissociation this channel forces on the store's evaluation: the *edge into* the controller is required at encoding while the *region* is required at retrieval, and no lesion design that hits the region can detect the difference.
- **[[wiki/concepts/cognitive-map.md]]** — the store at the other end: the channel reads from the ventral/anterior pole, whose fields are large enough to code global context rather than position, so the controller receives the map's coarse level and never its places.
- **[[wiki/concepts/continual-learning.md]]** — where the amygdala write-lock lands as a proposal: if only the *mapping* transports, the mapping lives on edges, and edge-level write protection is a target for interference control that unit-level importance weighting cannot express.
- **[[wiki/concepts/reward-prediction-error.md]]** — the same structural-credit trick reached from the credit side: a module emitting a licence on its own participation turns a broadcast scalar into an addressed one, which is `δ_j = snr_j · δ` and this page's write-mask proposal (G52) as one experiment.
- **[[wiki/entities/default-mode-network.md]]** — the resting-state context for this edge, with a routing twist: the medial temporal and dorsomedial prefrontal subsystems are *anticorrelated* and reach each other through shared hubs (posterior cingulate/retrosplenial, ventral medial prefrontal), not directly.
- **[[wiki/entities/lisa.md]]** — the open question this channel is the anatomy for: prefrontal role binding by synchrony and hippocampal/medial-temporal binding are both phase claims, running over a wire whose theta and gamma channels are separately silenceable, and no account says whether a role binding is ever *transferred* across it or independently re-derived at each end (Knowlton, Hummel & Holyoak 2012 flag it as unspecified).
- **[[wiki/concepts/retrieval-mediated-learning.md]]** — human encoding-phase evidence on this channel with an unusual control attached: hippocampus–ventromedial-prefrontal coupling rises with repetition number *within* a run and not across runs, so the channel's bandwidth tracks assembly of one particular overlapping structure rather than time on task or a task mode (`T100`).
- **[[wiki/concepts/nonspatial-maps.md]]** — types the top-down leg's cargo: the controller's cortical route lands on perirhinal and lateral entorhinal cortex, which code items and events, and only weakly on the medial entorhinal cortex, so the write is addressed to the *what* stream of the store's input (Eichenbaum 2017).
- **[[wiki/concepts/hippocampal-long-axis.md]]** — explains why the channel originates where it does: the controller is wired to the end of a scale gradient whose fields are widest and whose code generalizes over the events of a context, so the anatomy fixes the cargo's grain before any computation does; the same gradient carries the cingulate input topography in the other direction.
- **[[wiki/entities/entorhinal-cortex.md]]** — draws the gateway this page's top-down arm lands on: the controller's cortical route targets the **deep** layers of lateral entorhinal cortex, which is the sublamina (Vb) that receives the hippocampal return *and* a copy of what layer II wrote, so "control applied at the store's input gateway" is control applied to the loop's integrator rather than to a feedforward encoder (`G110`, Witter et al. 2017).
- **[[wiki/entities/a24b-m2-v1-projection.md]]** — the wiki's other projection-as-entity, and the contrast that makes the method legible: this edge carries *context* upward from a fast store to a controller and owns a learning rule, a gain and a third-party lock; that one carries *predicted content* downward from a controller to a sensory area and owns a coordinate system, a topography and a relearning schedule. Two edges, no shared state variables — which is the argument that an inter-module wire is a designed object rather than a matrix (`G52`).
- **[[wiki/concepts/perturbation-elicitability.md]]** — supplies the instrument this page's modes have never been tested with, and the reason the test is owed here specifically: closed-loop detect-and-perturb has been run on a pattern *within* hippocampus (Jadhav et al. 2012) and never on an inter-regional coupling, so every claim on this page that a mode is a communication channel rather than the anatomy it rides on rests on an ablation that cannot discriminate the two.
- **[[wiki/entities/amygdala.md]]** — gives the structure this page treats as a lock on the edge its own computation, and splits it: the basolateral nucleus (the one with prefrontal and hippocampal connectivity) retrieves the current value of a specific predicted outcome, while the central nucleus does the brainstem and neuromodulatory control — a distinction the amygdala-lock account here does not make.
- **[[wiki/concepts/hierarchy-of-associativity.md]]** — the same non-reciprocity at a second edge of this interface: frontal cortex projects to perirhinal cortex far more widely than perirhinal cortex projects back, matching this page's unreciprocated hippocampus → medial prefrontal arm, so asymmetric edges are the rule at the store's boundary rather than a quirk of one pathway (Lavenex & Amaral 2000).
