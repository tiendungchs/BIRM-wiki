# Hippocampal–Prefrontal Channel

**An inter-module *edge* studied as an object in its own right: the projection between the episodic store and the control layer, which turns out to carry a learning rule, a gain, a third-party lock on its own writability, a stress-set operating point, several logical channels multiplexed by frequency band, and two anatomically distinct directions with different endpoints and different cargo.**

> **Why this is an entity page and not a section.** Every architecture in the wiki draws inter-module connections as wires: a matrix, a gate, or a skip connection with at most a learned scalar. This pathway is the wiki's one worked example of a connection with **its own state, its own plasticity, its own external gate and its own failure signature** — a connection that can be lesioned, potentiated, depotentiated, locked and desynchronised independently of either endpoint. Gap **G52** is the statement that no wiki architecture has such a thing; this page is the specification it would be built from. Split out of [[wiki/entities/medial-prefrontal-cortex.md]] at the 125-ingest lint pass, where it had grown to ~30% of that page while being about neither endpoint.

**Sources.** Euston et al. 2012 (`raw/euston-2012-prefrontal-cortex-memory.md`); Spedding & Jay 2012 (`raw/spedding-2012-hippocampal-prefrontal-pathway.md`); Preston & Eichenbaum 2013 (`raw/preston-2013-hippocampus-prefrontal-memory.md`); Jin & Maren 2015 (`raw/jin-2015-prefrontal-hippocampal-interactions.md`); Sigurdsson & Duvarci 2016 (`raw/sigurdsson-2016-hippocampal-prefrontal-interactions.md`).

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
| **Direction typing** | Ventral hippocampus → ventral medial wall carries *context in*; anterior cingulate → dorsal CA1/CA3 carries a *retrieval trigger* out; prefrontal → reuniens → hippocampus carries a *goal-conditioned trajectory* down | Distinct, separately addressed forward and return links with different payload types | **No** — return arrows are transposes |
| **Target addressing** | The return arrow preferentially innervates high-degree hub neurons that *emerge after learning* | Addressing by the target's graph degree inside the store, rather than by content similarity | **No** ([[wiki/concepts/attention.md]] is content-addressed throughout) |

**(brainstorm)** Read as a whole, the table says the wiki has been modelling inter-module communication at roughly the level of detail it models a single synapse — and that the interesting variables all live one level up. The cheapest experiment that would put a number on it: take any two-module model with a learned interface, add *only* the write-mask row (a third module emitting a binary licence on the interface's plasticity), and measure whether continual-learning interference falls. Every other row costs an architecture change; that one costs a mask.

---

## Limitations

| Limit | Consequence |
|---|---|
| Almost all of the physiology is rat, and the primate/human evidence is coherence and diffusion imaging | The four-tuple of edge state is established in a species where the target region's homology to primate prefrontal cortex is itself contested ([[wiki/entities/medial-prefrontal-cortex.md]] limitations) |
| The dorsolateral prefrontal cortex receives only a *light* direct hippocampal projection | Most primate control-layer evidence in the wiki is about a region this channel barely reaches; human "hippocampal–prefrontal" working-memory results are medial/orbital, or multi-synaptic |
| The frequency-multiplexing claim rests on band correlations plus one terminal-silencing dissociation | "One wire, several logical channels" is the reading, not a demonstrated decoding of two independent payloads |
| Nothing measures what the channel *carries*, only when it is required and at what frequency | The cargo is inferred from the origin's tuning (ventral pole = context generality), never read off the axons |
| The psychiatric convergence is correlational | The "weak link" thesis is a strong organising claim built on coupling abnormalities that could be downstream of either endpoint |

---

## Connections

- **[[wiki/entities/medial-prefrontal-cortex.md]]** — one endpoint, and the page this one was split from: the medial wall's two tiers are the channel's two ports, and the tier that *receives* the store's context is not the tier that *writes back* to it.
- **[[wiki/entities/nucleus-reuniens.md]]** — the indirect return arm of this channel, with the detail that makes it more than a relay: single reuniens neurons collateralise to both endpoints, and the arm carries a goal-conditioned future path rather than a transposed copy of the forward message.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — the measurement apparatus for this channel: coherence, phase-locking and directed information are how the edge's state is read out at all, and this page supplies the case where a band dissociation (gamma at encoding, theta at choice) turns into a routing claim about two different pathways.
- **[[wiki/concepts/contextual-inference.md]]** — names the carrier of the context posterior: asymmetric disconnection of ventral hippocampus from prelimbic cortex abolishes fear renewal without degrading either memory, so cutting this edge removes the *selection* between contexts rather than any content.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — a worked instance of addressed suppression at the level of a whole projection: the channel's terminals drive feed-forward inhibition, so the context input withholds prefrontal output the context does not license, and removing it disinhibits the controller.
- **[[wiki/concepts/schema-assimilation.md]]** — supplies the channel's cargo type: the hippocampal long axis is a generality gradient and the controller is wired only to its general end, so what travels the edge is what all events of a context share, not an event.
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
