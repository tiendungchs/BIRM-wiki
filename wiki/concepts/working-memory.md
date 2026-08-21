# Working Memory

**Maintain and manipulate a small set of items in an active store over a delay, under the control of a process that is separate from the store itself.**

The classic cognitive decomposition — a central executive plus separate domain-specific buffers (e.g. a visuo-spatial sketchpad), instantiated in prefrontal cortex and interconnected areas — is the source of the **control/storage separation** that turned out to matter most for machine reasoning (Hassabis et al. 2017).

In the wiki's framing, working memory is the substrate of fast **M**: the place where an instance-graph is bound and held while it is being navigated. See [[wiki/concepts/latent-graph-discovery.md]].

---

## Two designs for holding information over time

| | **Entangled** (recurrent nets, LSTM) | **Separated** (external memory) |
|---|---|---|
| Storage | Distributed in the same units that compute | An explicit memory matrix |
| Control | Same weights that store also sequence the computation | A controller network that attends to, reads and writes memory |
| Biological analogue | Attractor dynamics; gated maintenance in prefrontal recurrent circuits | Central executive + domain-specific buffers |
| Capacity coupling | Memory capacity is tied to unit count and interferes with computation | Memory scales independently of the controller |
| Demonstrated ceiling | State of the art across many sequence domains; can report on latent variable state after training on program text | Tasks that elude LSTMs: **shortest path through a graph such as a subway map**, block manipulation in a Tower-of-Hanoi variant |

The lineage runs: neuroscience-inspired recurrent networks with attractor dynamics and rich sequential behaviour → detailed models of human working memory → **gating** (information admitted into a fixed activity state and maintained until output is required), which is the mechanism LSTMs share with prefrontal maintenance models. The reverse-direction influence also holds: LSTM gating motivated gating-based models of prefrontal working memory ([[wiki/concepts/neuroscience-ai-transfer.md]]).

---

## Why control/storage separation matters for reasoning

The differentiable neural computer (DNC, [[wiki/entities/differentiable-neural-computer.md]]) — a neural controller reading and writing an external memory matrix, trained end-to-end — solves tasks that were argued to require **symbol processing and variable binding**, and therefore to lie outside the reach of neural networks. Two of those tasks are literally latent-graph tasks:

| Task | Latent-graph reading |
|---|---|
| Shortest path in a subway map | **Path latent**: topology given as input, vocabulary known, the composition connecting two nodes must be searched |
| Tower-of-Hanoi block manipulation | Path latent under constraints, with a goal node that must be matched exactly |

**What this establishes:** an externalized, content-addressable, writable store is sufficient to make a differentiable network do explicit graph traversal. **What it does not establish:** discovery — in both tasks the graph is *given to the network as input*, so the hard part of LGD (inferring edges and vocabulary from observation) is not tested. Memory-augmented networks are evidence about the *navigate* half only.

And "solves" needs a number attached (Graves et al. 2016): 98.8% on 7-step traversal of the London Underground but **55.3%** on its 4-step shortest paths, with curriculum learning essential and an expert planner mixed into training. The capability claim is safe; the reliability claim is not.

## Order for free: noise-driven attractor transitions

A third design, and the only one in the wiki that derives the *capacity number* rather than stipulating it (Rolls 2013, [[wiki/entities/rolls-treves-hippocampal-model.md]]). Hippocampal and prefrontal neurons fire at different points within a delay period — a **rate code for time** — and a recurrent network reproduces this without any oscillatory clock:

| Ingredient | Effect |
|---|---|
| Several attractors with slightly stronger forward than reverse weights | The state walks the chain in order |
| Spiking noise | Drives each transition; nothing schedules it |
| Adaptation | Kills the current attractor and biases the next toward the least-recently-active one |

Two payoffs. **Order comes free with storage** — items bound to time-encoding populations by the same associative rule that binds them to places, so recall in the presented order needs no extra mechanism. And **the span is derived**: noise limits the chain to perhaps `7 ± 2` sequential states, offered as the origin of the classic capacity limit and of why recency items are naturally recalled in order. Under this account working-memory capacity is a *dynamical* property (how many noisy transitions stay distinguishable) rather than a slot count — which predicts capacity should vary with adaptation and noise level, not with unit count.

Rolls contrasts this directly with theta/gamma phase-coding accounts of serial order ([[wiki/empirical-tensions.md]] T32), and concedes the site is unsettled: the natural substrate is the CA3 recurrent network, while part of the temporal-order lesion evidence implicates CA1.

**Duration.** Nothing restricts these mechanisms to seconds: LSTMs and DNCs can maintain information across many thousands of training cycles, so the same machinery may serve longer-term memory (e.g. retaining the contents of a book). The functional distinction "working vs. long-term" does not map onto an architectural one here.


## Maintenance with no activity at all

The designs above hold information in *activity* — a buffer, a memory matrix, a chain of attractors, a bump. A fourth design holds it in the **state of the synapses**, so the maintaining population can be silent.

| | Activity-based maintenance | Synaptic (activity-silent) maintenance |
|---|---|---|
| Carrier | Firing rates / a persistent bump | Release probability `u` and available resources `x` at recently used synapses |
| Metabolic cost during the delay | Continuous spiking | ~none |
| Read-out | Direct — decode the population | **Indirect** — the trace is invisible until a probe input recruits the facilitated population |
| Decay | Set by network dynamics and noise | Set by `τ_f`, `τ_r` — a forget gate that is a biophysical constant, not learned |
| Capacity limit | Number of distinguishable stable states | Number of populations whose recent activation is still distinguishable |

The cleanest existence argument in the wiki is negative and comes from CA3 ([[wiki/entities/stp-flickering-cann.md]], Mark et al. 2017 on Jezek et al. 2011): after an abrupt environment switch, the correlation between CA3 activity and the *old* map essentially vanishes — there is no reverberatory trace of it — yet for several seconds the old map can still recapture individual theta cycles. Whatever holds it is not activity. A `τ_f > τ_r` short-term-plasticity rebound reproduces the effect, including its time course, its dependence on theta amplitude and its decay ([[wiki/concepts/synaptic-plasticity.md]]).

Three things this changes for fast **M**:

- **A store can be write-only until probed.** The trace does not compete for representational bandwidth with the current contents, which is the interference problem an activity-based buffer has by construction.
- **What is stored is a *bias*, not a value.** Synaptic state changes which pattern the network falls into, not what it currently represents — so the retrieved item is regenerated by the recurrent dynamics rather than read out, and a corrupted trace yields a valid stored pattern rather than a corrupted one.
- **The decay constant is the design parameter.** With no gate and no controller, everything about what survives the delay is set by `τ_f`, `τ_r` and how much the population fired. **(brainstorm)** In a machine store this is a per-slot recency scalar multiplying the retrieval score — the cheapest possible form of fast **M**, and one that no key-value memory in the wiki uses.

**The design has now been tested against the alternative on one task, with training held fixed** (Kozachkov et al. 2022, [[wiki/entities/stsp-working-memory-rnn.md]]). ~2000 recurrent networks trained on a distracted delayed-match-to-sample task, scored against macaque lateral prefrontal recordings from the same task:

| | Fixed-synapse RNN | STSP RNN | Prefrontal cortex |
|---|---|---|---|
| Sample decodable from spikes across a 4 s delay | yes | **no** | **no** (chance after ~1 s) |
| Sample decodable from synapses | n/a | **yes, whole delay** | not measurable |
| Survives ablation of half its synapses | no (fails at 10–20%) | **yes** | — |
| Survives process noise | **better** | worse | — |

Three additions to the rows above. **Reading the store is a separate operation from holding it**: the synaptic trace is invisible until spikes recruit the facilitated population, which predicts sparse spiking during maintenance and more spiking when the memory is *used* — so maintenance is cheap and read-out is not. **Storage and computation come apart without an external memory matrix**: the trained `W` is the computation and `u·a` is the memory, which is why ablating trained weights does not delete the item — the cheapest instance of this page's control/storage separation, bought by having no write policy at all. And **the robustness argument for the design is narrower than it looks**: LSTM and GRU beat every biological variant on both noise types while being the least brain-like of the six, so structural robustness, not robustness in general, is what STSP buys.

## Persistence with nothing to persist on

The wiki's designs above all hold information in *contents* — a buffer, a memory matrix, a chain of attractors. The fly ellipsoid-body compass holds a **reference frame** instead ([[wiki/entities/fly-central-complex.md]], Seelig & Jayaraman 2015): with the animal standing still in darkness — no landmark, no self-motion signal — the population keeps its heading bump for **>30 s**, two orders of magnitude beyond the calcium indicator's decay, and when walking resumes the bump reappears in exactly the wedges predicted by the last orientation. Persistence in the same population is also seen while standing in a lit scene, beyond the durations that adapt early visual circuits, so it is not a stimulus after-effect.

Three things follow for this page:

- **It is the cleanest instance of activity-based maintenance in the wiki**, and it is in a circuit small enough to be imaged whole — so "the fast level is recurrent activity rather than a second store" ([[wiki/empirical-tensions.md]] T2) has one fully observed existence proof, on one variable.
- **What is maintained is `g`, not `x`.** **(brainstorm)** Holding the pose and re-reading the content from the world on resumption costs `O(dim g)` instead of the scene, and it is the maintenance policy that degrades most gracefully: a stale heading is still usable, a stale scene is a hallucination. A reasoning system that must survive interruptions should be asked which of its state is pose and which is content.
- **The mechanism is undetermined.** Ring-attractor recurrence and cell-intrinsic persistence both predict this; the paper cannot separate them, which is the same ambiguity the attractor-chain account of span above rests on.

---

## Maintenance by not staying still

A fifth design keeps the item in activity but forbids any unit from holding it: the memory is a **trajectory** whose participating units peak in sequence and tile the delay (Liu et al. 2025, [[wiki/entities/trnn.md]]). Three structural edits to an otherwise ordinary trained recurrent net are enough — per-unit self-inhibition `τ_v dV/dt = −V + mr` subtracted from the drive, sparse recurrence, and sensory/association/motor blocks with sparser inter-block connectivity.

| | Persistent (vanilla RNN) | Transient trajectory (TRNN) |
|---|---|---|
| Carrier | Units held at a fixed rate for the delay | A moving pattern; each unit fires once, sharply |
| Delay-period geometry | Approach to a fixed point | dPCA trajectories keep moving, velocity does **not** decay |
| Activity entropy | Low | Rises ~linearly with the transient index |
| Metabolic proxy `⟨r²⟩` | High | Falls stepwise with the transient index |
| Variable delay (3–6 s) | Free by construction | Learned, at a ~4-point accuracy cost |
| Distractors, 2–6 items, spatial navigation | Worse; on the water maze no better than a memoryless net | Better on all three at equal parameter count |
| Match to recordings | Transient index far below mouse | Transient index mouse-like; 38.2% vs. 32.6% stimulus-selective units |

Three things this changes for fast **M**:

- **Persistence is the trained default, not the task requirement.** A vanilla recurrent net converges on something attractor-like without being asked; the three edits are subtractions, and every task metric improves. So "the fast store holds a value" is a claim about architecture, not about what the delay demands.
- **Capacity is bought with entropy.** Pinning units to one value for the whole delay spends them; letting them tile spends them on distinguishable states. This is the wiki's one measured item-capacity advantage of a dynamic code over a fixed-point code — and it is partly circular, since the information-richness measure is a component of the transience measure.
- **Holding and moving are the same knob, again.** The self-inhibition term is literally A-CANN's adaptation current ([[wiki/entities/adaptive-cann.md]]), whose closed form says `m > τ/τ_v` converts a held state into a travelling wave. The section above prices maintenance; this one says the far side of that price is not memory loss but a *usable* memory of a different kind.

---

## What the delay signal is *about*

Every design above reads sustained delay-period firing as *the item being held*. One experiment sets that reading against the alternative directly (Lebedev et al. 2004). Monkeys fixated centrally while a circle revolved from an initial location (which had to be **remembered**, and was then unmarked) to a final location (which had to be covertly **attended**, because a brief 150 ms dimming/brightening there carried both the go signal and the choice of which of the two locations to saccade to). Both locations were potential saccade targets and both were equally predictive of reward until the trigger, so reward anticipation cannot explain a preference for either.

| Delay-period tuning in dorsolateral prefrontal cortex (n = 303 spatially tuned) | Share | Mean selectivity index |
|---|---|---|
| Attended location only ("attention cells") | **61%** | `I_Att` = 1.84 ± 0.08 |
| Remembered location only ("memory cells") | **16%** | `I_Rem` = 1.21 ± 0.02 |
| Both ("hybrid cells") | 23% | — |

Preferred-minus-least-preferred rate difference: 8.8 spikes/s for the attended location vs. 5.3 for the remembered one. Ensemble neuron-dropping decoding gives the same ordering. Three controls make this hard to explain away: tuning to the circle's location was **stronger late in the delay than early** (1.83 vs. 1.46), with sensory input identical in every coordinate frame, so it is not a visual response; memory tuning was **absent at stimulus onset and developed during the trial**, so it is not a decaying replica of the cue response; and after the saccade the decoding of whichever location had become irrelevant *decayed* while the newly relevant one *improved*, with the switch preceding saccade onset.

Three things this changes for fast **M**:

- **Delay-period activity is not, by itself, evidence that anything is being maintained.** A persistent, decodable, spatially tuned signal in the canonical working-memory area is mostly about where the controller is *pointing*, not about what it is *holding* ([[wiki/empirical-tensions.md]] T88). Every claim in the sections above that reads prefrontal delay firing as an item — including the attractor and STSP comparisons — inherits this confound wherever the task left attention uncontrolled, which is most of them.
- **A store needs a pointer register as well as a content register, and the wiki has no design that separates them** (gap G48). The two variables here are the same *type* (a location) and live in one population, which is exactly the case where a read-out cannot tell them apart.
- **Deletion is by relevance, and it is prospective.** The irrelevant location's representation decays only once it stops mattering, and the reweighting happens before the action that makes it irrelevant — a controller-driven clear, not a time constant. **(brainstorm)** This is the cheapest missing operation in every key–value store in the wiki: not "forget the oldest" but "unmark whatever the next step will not query".

**A third thing the delay signal can be about: something never presented.** Human cross-task decoding over an 8 s blank delay after a cued target face recovers the *associated scene category* — learned the previous day, absent from the display — in the inferior frontal junction, parietal eye fields and parahippocampal place area, while the cued face itself is absent from all of them (Zhou & Geng 2025; [[wiki/concepts/priority-map.md]]). So the taxonomy of delay-period content is at least three-way: the item, the pointer, and a *retrieved associate loaded because it is the more useful query*. For a builder this is worse than the attention confound, not better — a decoder that finds the cue in the buffer confirms maintenance, but a decoder that finds neither the cue nor the attended location has to search the cue's associative neighbourhood before it can call the buffer empty.

**Read against the maintenance evidence.** The paper does not deny prefrontal short-term memory; it denies that maintenance accounts for most of the delay signal, and it reinterprets two pillars of the opposite case — Funahashi et al.'s "mnemonic scotomas" after prefrontal inactivation are equally consistent with a localized failure to attend, and antisaccade/brightness tasks confound the cued location with the attention-attracting one.


### Three more confounds, from the rodent side

Euston et al. 2012 argue the rodent medial prefrontal working-memory literature is largely unusable for the same reason, and name the confounds separately ([[wiki/entities/medial-prefrontal-cortex.md]]):

| Confound | The datum that exposes it | What it costs a claim |
|---|---|---|
| **Delay length is confounded with task novelty** | Rats trained at 5 s then switched to 20 s show lesion deficits; rats trained from the start on randomly shuffled delays show none | The signature "errors grow with delay" can be a deficit in handling a *changed* task, not a decaying store |
| **Delay activity may be embodied** | The same cells resolve position and trajectory differences of ~1 cm | Persistent firing can be a readout of a differential *behaviour* adopted during the delay — a mediating strategy, not a maintained item |
| **Working memory is confounded with reference memory** | A protein-synthesis blocker given *after* each daily session — never present during the task — abolishes acquisition of a spatial win-shift | The impairment can be in consolidating the task *rules*, with the trial-specific store intact |

What survives the controls is narrow and is not about stimuli: delayed alternation with mediating strategies excluded; one-third of dorsal medial prefrontal cells modulated while a lever is held, **half of them predictive of premature release**; one-fifth responding differently after error trials and carrying that state into the *next* trial. Short-term memory for **actions and errors**.

**(brainstorm)** The first and third confounds have exact machine forms and are never controlled: a model evaluated at a delay it was not trained on is being tested for length generalization, and a model whose task rules are learned in the same weights as its content cannot have "memory" ablated without ablating the task. The clean design is the shuffled-delay curriculum plus a rule-frozen ablation, and no benchmark in the wiki runs either.

---

### The input link and the region are needed at different task phases

Optogenetic terminal inhibition separates the *edge* from its endpoint (Spellman et al. 2015, in Jin & Maren 2015; [[wiki/entities/medial-prefrontal-cortex.md]]). In a four-goal T-maze, the ventral-hippocampus → medial-prefrontal projection is required during **cue encoding**, and gamma-band (30–70 Hz) activity on that pathway tracks successful encoding and correct trials, disappearing under terminal inhibition. The region itself, by the best-controlled rodent result, is required at **retrieval** and not at encoding or during the delay (spatial win-shift, Euston et al. 2012).

| Manipulation | Encoding | Delay | Retrieval |
|---|---|---|---|
| Inhibit the ventral-hippocampus → prefrontal **terminals** | **Impaired** | — | — |
| Inactivate **medial prefrontal cortex** | No effect | No effect | **Impaired** |
| Lesion **nucleus reuniens** (the return bus) | Radial-arm maze and delayed-non-match-to-position both impaired; phase not resolved | | |

**The two phases are also two *pathways*.** Terminal silencing removes pathway **gamma** and the encoding-phase requirement, but leaves **theta** — the band whose coupling rises at the choice point and collapses on error trials (Jones & Wilson 2005; Sigurdsson & Duvarci 2016, [[wiki/concepts/inter-areal-synchrony.md]]). So the choice-phase demand is carried by an indirect route (nucleus reuniens, medial septum, or ventral hippocampus acting as synchronizer), not by the wire that carries the cue. Two more constraints from the same review: the coupling **increases across learning** in parallel with performance, so the inter-module link is trained rather than fixed; and in humans, coupling with load goes **up** in some studies and **down** in others, so human load-dependence is not usable as a constraint.

**(brainstorm)** No store in the wiki is specified with a phase-typed input port. The reading that fits both rows is that the channel *writes* the trial's context→cue mapping into the controller during encoding and the controller is *queried* later, so ablating the module and ablating its input link should give opposite phase signatures — a prediction that costs one extra ablation condition and that no machine memory evaluation runs. It also means "the module is not needed at encoding" and "nothing reaches the module at encoding" are routinely conflated.

---

## Reading, clearing and removal have moved

Three operations that this page used to carry — the *scheduled, item-specific read* (Lundqvist et al. 2018), the *relevance-addressed clear*, and the finding that deletion is a typed family rather than one primitive (`replace` / `suppress` / `clear`, DeRosa et al. 2024) — are the store's **access protocol** rather than its carrier, and now live on [[wiki/concepts/memory-read-and-erase.md]] together with the gap cluster they generate (G48, G49, G60).

What stays here is the consequence for the carrier: hold, read and clear are three operations with three signatures and **only one of them is expensive**, which is what the activity-silent designs above predict and what the burst measurement shows directly. A store whose read is free cannot express the difference.

---

## The capacity limit can be in the read, not in the store

Every design above locates capacity in the carrier — distinguishable stable states, distinguishable facilitated populations, noisy transitions before the chain blurs. One measurement locates it in the *access* instead (Gong & Zhang 2024, [[wiki/concepts/attention.md]]). Minimal causal transformers (1 layer, 1 head, no feed-forward network, no layer norm; 50 models per condition) trained on the `N`-back task lose accuracy logarithmically as `N` grows, while the whole 24-item sequence sits well inside the context window — the item is present, uncorrupted and addressable, and the model still fails. Over training, attention aggregates onto the `i−N` diagonal; accuracy at `i` tracks the attention mass at `i−N`; and summed row entropy of the attention matrix rises with `N` exactly as accuracy falls.

- **This is the executive-attention account of human capacity, reproduced in an architecture not designed to have it**: the bound comes from the scarcity of selection, not of storage. It predicts that a store can be enlarged without raising capacity, which is what the wiki's key-value designs implicitly assume is false.
- **The competition is arithmetic.** A softmax row spreads one unit of mass over every candidate, so retrieval precision degrades with occupancy by construction — a capacity model that every attention-based store already has and none reads out (gap G42).
- **It largely disappears with two layers or a few heads** (>95% at every `N`, with a residual decline), so this is an existence proof that self-attention *can* be the binding constraint, not a measurement of the constraint in a large trained model.

---

## Or the limit can be a safety margin the store imposes on itself

Every locus above is a ceiling the substrate *suffers*: distinguishable stable states, distinguishable facilitated populations, noisy transitions, softmax competition at the read. Arnsten et al. 2010 name a fourth that the store *chooses* ([[wiki/concepts/dynamic-network-connectivity.md]]).

Recurrent excitation is intrinsically unsafe, so prefrontal microcircuits run a negative feedback loop — delay activity → Ca²⁺ through NMDA receptors → small-conductance Ca²⁺-activated K⁺ channels → shunt of the network input at the spine.

| Manipulation in rat prefrontal cortex | Effect on working memory |
|---|---|
| Apamin (blocks the SK potassium channel) | **Improves** performance; also increases the prefrontal NMDA current |
| Xestospongin C (blocks IP₃-mediated intracellular Ca²⁺ release) | **Improves** performance |
| Genetic loss of the same brakes (HCN reduction; a mutation preventing protein kinase A from opening KCNQ2/3) | Lowered cortical seizure threshold; childhood epilepsy |

Three things this changes:

- **The store is running below its achievable capacity, and the shortfall is recoverable pharmacologically** — which no resource account predicts ([[wiki/empirical-tensions.md]] T104). The price of removing the margin is named in the third row: seizures.
- **The handoff to the episodic store gets a cause.** The authors offer the same feedback as the reason hippocampal connections are required beyond ~10–30 s, so the fast-**M**/slow-store boundary is set by a stability constraint rather than by a decay constant.
- **(brainstorm) Every recurrent store in the wiki pays this tax and none reports it as a capacity number.** Spectral-radius clipping, activity normalisation and adaptation currents ([[wiki/entities/adaptive-cann.md]]) are all stability regularisers. The experiment is one sweep: lower the regulariser until the network destabilises, recording item capacity along the way. A monotone rise up to the instability point would say the wiki's stores are all holding an unmeasured margin too.

---

## Mapping to the core framing

| Working-memory element | Latent-graph element |
|---|---|
| Buffer contents | Fast **M** — the instance-graph binding for this episode |
| Controller | The search/navigation policy over that graph |
| Gating (what enters, what is protected) | Which observations count as evidence about the current instance |
| Content-addressable read | Retrieval by node content `x`; the missing piece is retrieval by structural position `g` |
| Iterative memory "hops" | Multi-hop traversal — reasoning over several supporting statements ([[wiki/concepts/attention.md]]) |

### The world state as a writable store

A distinct argument for the same architecture, from efficiency rather than from capability ([[wiki/entities/h-jepa.md]]): a typical action modifies a *small part* of the world, but a network that passes state as a vector rewrites all of it every step. So the world state should live in a key-value memory with one entry per entity — move a bottle from the kitchen to the dining room and exactly three entries change.

| Operation | Form |
|---|---|
| Read | `v = Σ_j Normalize(Match(k_j, q))_j · v_j`, with `Normalize` competitive/thresholded, e.g. `c_j = exp(c̃_j) / (γ + Σ_k exp(c̃_k))` |
| Write | `Update(r, v, c) = c·r + (1−c)·v` on matched entries |
| **Allocate** | If the query is far from every key (the `γ` threshold), create a new slot with key `q` |

All differentiable, so gradients pass through the store. Two readings this wiki should carry:

- **Update locality is architecturally enforced**, which is what an instance-graph in fast **M** needs and what a monolithic state vector cannot provide.
- **The allocation threshold is a de-aliasing decision** (gap G2): "far from every key" means *this is a new node*, not a noisy version of an old one. It is the wiki's cheapest de-aliasing mechanism so far, and also its most fragile — identity is decided by a single scalar in a learned metric, with nothing path-sensitive about it.

**(brainstorm)** The DNC result and the CLS story converge on the same object from opposite directions: an external, content-addressable, fast-written store. Working memory contributes the part CLS lacks — an explicit **controller** with a learned read/write policy. A reasoning architecture plausibly needs one store with two access disciplines (episodic write-once for consolidation; controller-driven read/write for manipulation), not two stores.

---

## Maintenance has a price, and it is a threshold

The designs above treat holding and updating as separate problems. In a continuous attractor they are the *same* parameter (Li, Chu & Wu 2024, [[wiki/entities/adaptive-cann.md]]): a stored value is stable precisely because it resists being moved, which is what makes it slow to update and impossible to search. Adding a slow negative feedback `τ_v dV/dt = −V + mU` and raising its gain buys mobility at the exact cost of maintenance, with the exchange rate in closed form:

| Adaptation gain | What the store does |
|---|---|
| `m < τ/τ_v` | Holds — a genuinely persistent value |
| `m ≳ τ/τ_v`, weak input | Value drifts on its own; maintenance has failed |
| `m` intermediate, driven | Value oscillates around the input — samples rather than holds |
| `m` large | Value ignores the input entirely — search |

Two consequences. **Persistence is not free and not binary**: how long a value survives is set by a gain that also determines how quickly it can be replaced, so a system that needs both must modulate the gain rather than pick a design. And **the failure mode of an over-mobile store is not decay but drift** — the value is still there, fully sharp, in the wrong place, which no read-out can detect from the state alone.

---

## Where the gate sits, and whether it lets go

Every gated design in this page borrows one anatomy — basal-ganglia disinhibition of a cortical store — and the computational literature built on that anatomy has **three incompatible readings of what the gate is gating**, none of which a behavioural datum has separated (Helie, Chakravarthy & Moustafa 2013, `raw/helie-2013-basal-ganglia-cognitive-models.md`, reviewing 19 models).

| Reading | Loop that holds the item | What the module does | Prediction that distinguishes it |
|---|---|---|---|
| **Gate a thalamo-cortical loop** (Monchi et al. 2000; FROST, Ashby et al. 2005) | Prefrontal cortex ↔ thalamus reverberation, released when the direct pathway pauses the tonic inhibition of thalamus | Write-enable, then out of the way | Thalamic lesions abolish maintenance; the thalamus needs as many dedicated cells as prefrontal cortex does |
| **Gate a cortico-cortical loop** (Frank et al. 2001; Moustafa & Maida 2007; [[wiki/entities/pbwm.md]]) | Two prefrontal populations reverberating with each other; the module only flips a switch that must coincide with drive from the partner population | Write-enable, then out of the way | Thalamic lesions spare maintenance; the *coincidence* requirement predicts failures to store when the store is already busy |
| **Be the loop** (Schroll et al. 2012) | The reverberation runs *through* the direct pathway | Not a gate at all — the maintenance mechanism itself, with the hyperdirect pathway supplying the reset that ends it | The module is occupied for the whole retention interval, so maintaining `k` items should cost selection capacity for other actions |

The third is the recent and most capable one — the only reviewed model that both **learns what deserves maintenance** (dopamine-gated reinforcement on the cortex→striatum *and* cortex→subthalamic weights) and simulates the hard tasks (delayed alternation, 1-2-AX) — and it departs from the other four without arguing for the departure. See [[wiki/empirical-tensions.md]] T130.

**Two things the census settles that the disagreement obscures.** First, **maintenance is always a closed prefrontal loop** — all five models agree on the store and disagree only about the enabling circuit, which makes the gate the contested component and the recurrence the uncontested one. Second, **only two of five learn what to gate at all** (Moustafa & Maida 2007; Schroll et al. 2012, alongside PBWM); the rest assume the relevant items have already been filtered by something upstream that is not modelled. That is the same silent pre-filter this page's `N`-back result exposes from the read side — a store whose contents were chosen for it is not being tested on the operation that makes working memory hard.

**(brainstorm)** The distinguishing experiment is cheap in simulation and nobody has run it: give a single agent a maintenance task and an unrelated action-selection task concurrently. Under the two gating readings, interference should scale with the *rate of writes*; under Schroll's, with the *number of items held*. Any machine architecture makes the same choice implicitly — a transformer's key/value cache is the "gate then let go" design taken to its limit (write cost per token, zero holding cost), and any architecture that maintains by recirculating through its controller pays the other way.

---

## The load variable for reasoning is relations integrated, not items held

Every capacity account above counts *items*. The analogy literature counts something else and gets a cleaner dissociation (Holyoak 2012, [[wiki/concepts/analogical-mapping.md]]): **relational complexity**, the number of relational roles that must be integrated to license one inference (Halford).

| Manipulation | Effect |
|---|---|
| Frontal-lobe damage, **two-relation** Raven's-type problems | Marked deficit |
| Same patients, **zero- or one-relation** problems | **Normal** |
| Dual task (random digit generation) during a mapping task | Relational responses ↓, similarity-based responses ↑ |
| Induced anxiety before the task | The same shift |
| Preschoolers, two relations to integrate *or* a perceptually similar distractor present | Relational responses ↓; reliable by 13–14 years |

Two things follow for a builder. **(1) The bound is on simultaneous *bindings*, not on stored symbols** — [[wiki/entities/lisa.md]] derives it rather than stipulating it, by carrying role-filler bindings in mutually out-of-phase time slots, so ~2–3 propositions can be live and a complex mapping must be serialised across load cycles. **(2) Exceeding the bound does not produce a miss, it produces a confident wrong answer** drawn from direct similarity — the degradation mode is a fallback onto the cheaper route, which no capacity curve in this page's designs predicts and every one of them could be tested for.

---

## Open problems

- **Binding and variables.** The DNC demonstrates variable-binding-like behaviour without showing that a reusable variable *representation* exists; whether the binding generalizes to novel structures is untested here.
- **Capacity and interference in the buffer** — no account of what happens when the instance-graph exceeds the memory matrix. And the limit need not be the matrix at all: where reads are by softmax attention, precision falls with the number of competing entries before the store is anywhere near full (Gong & Zhang 2024).
- **Structural addressing.** Reads are by content similarity; navigation needs addressing by graph position (path-consistent `g`, gap G3).
- **Interpretability.** Networks with external memory are the case that resists virtual brain analytics most stubbornly.

---

## Connections

- **[[wiki/concepts/priority-map.md]]** — delay-period content caught in the act of being *used*: the persistent object code that a delayed-match task reads out as "the remembered item" is the query a search computation matches every location against, and it survives saccades that overwrite the whole retinal input — an update-invariant register rather than a decaying trace (Bichot et al. 2015) — and the human version shows the register's content need not be the cue at all, but a learned associate of it retrieved because it is easier to detect (Zhou & Geng 2025).
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — derives the `7 ± 2` span from noise-driven transitions between asymmetrically coupled attractors, making capacity a dynamical rather than a slot limit, and puts serial order in the same recurrent network that stores episodes.

- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the only architecture in this ingest that performs explicit multi-hop graph traversal, and marks the boundary: it navigates a *given* graph, it does not discover one.
- **[[wiki/concepts/attention.md]]** — attention is also where this page's capacity limit can sit: in a minimal transformer trained on `N`-back the item stays inside the context window and the *read* is what degrades, logarithmically in the offset and in step with the entropy of the attention matrix (Gong & Zhang 2024). Attention is the read mechanism of an external memory, and the read is *scheduled*: gamma bursting and object information ramp up several hundred milliseconds before the item is queried, for that item only, and not before an equally predictable event that requires no read (Lundqvist et al. 2018); internal attention and content-addressable retrieval are the same operation — and in prefrontal cortex the two are not separable at the read-out: 61% of delay-tuned cells track the attended location and 16% the remembered one, so the store's persistent signal is mostly its own pointer (Lebedev et al. 2004).
- **[[wiki/concepts/complementary-learning-systems.md]]** — external memory is the engineering form of the fast store; working memory adds the controller that decides what is written and read.
- **[[wiki/entities/nucleus-reuniens.md]]** — the bus between the store and the controller is itself a lesionable cause of working-memory deficit: reuniens damage reproduces the radial-arm-maze and delayed-non-match-to-position failures of a hippocampal–prefrontal disconnection while both endpoints stay intact, so a maintenance deficit need not be located in any maintaining structure.
- **[[wiki/concepts/meta-learning.md]]** — meta-RL's inner learner lives in recurrent activity, i.e. in entangled working memory; its capacity limits are working-memory limits.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — control/storage separation is the transfer that produced graph-traversal-capable networks, and gating is the case where influence ran both ways.
- **[[wiki/concepts/simulation-based-planning.md]]** — the controller/model split used for planning is the same separation applied to an environment model instead of a memory matrix.
- **[[wiki/concepts/core-knowledge.md]]** — the object system's set-size limit (~3 in infants, 4 in monkeys, 3–4 in adult object tracking) is the same small-integer capacity this page's store has, and it holds across species and cultures, so the bound may be one shared resource rather than a coincidence of two.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — under parameter sharing, activations are interpretable as weights and attention as a weight update, so an activity-based store and a plastic-weight store are the same object in different bases and this page's capacity limits transfer directly onto plastic memory.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — active maintenance falls out as the limiting case `α = β = γ = 0` of the predictive-coding update (hold the current encoding when neither top-down prediction nor bottom-up error is precise), so a store is not needed as separate machinery (Butz 2016).
- **[[wiki/concepts/event-segmentation.md]]** — the multiplicative gate that maintains an item until further notice is the same gate that detects an event boundary; maintenance and segmentation are one mechanism read at two timescales.
- **[[wiki/entities/h-jepa.md]]** — applies the control/storage separation to the *environment model*: world state held in a per-entity key-value store with sparse updates and threshold-triggered slot allocation, so an action edits three entries instead of rewriting a state vector.
- **[[wiki/concepts/compositionality.md]]** — differentiable programming (external memory, stacks, queues, Neural Turing Machine → Differentiable Neural Computer → Neural Programmer-Interpreter) is the machine route to composition over data structures, and the reason those systems are read as learning *programs* — in a representation "more like assembly language" than a causal model of a domain (Lake et al. 2017).
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — prices the in-context store: a Transformer compresses only a few kilobytes at a time, so the fast level's capacity is a fixed byte budget with quadratic cost, and its value is measurable as bits saved per additional byte of context.
- **[[wiki/concepts/intelligence-density.md]]** — promotes recurrence from an efficiency choice to a necessary condition: without a loop the domain is pinned to the input dimension, so reuse of a rule across positions is impossible and `ℐ` cannot diverge (Choi 2026).
- **[[wiki/concepts/subgraph-matching.md]]** — supplies the missing addressing mode for the fast store: retrieval keyed by structural *shape* (does this pattern occur here?) rather than by content vector, answered as a coordinate comparison against precomputed neighbourhood embeddings.
- **[[wiki/concepts/contextual-inference.md]]** — gives fast **M** a specific content: not the instance-graph but the *mixing weights over stored memories*, which is what a working-memory distractor task disrupts (producing evoked recovery in a motor-adaptation paradigm; Heald et al. 2021).
- **[[wiki/entities/maze-solving-transformers.md]]** — multi-hop traversal without a separate addressable store: an entire graph held in the residual stream of one token, with the reliability degradation along the path that an external store was introduced to fix (Ivanitskiy et al. 2023).
- **[[wiki/concepts/cognitive-map.md]]** — supplies the map this page assumes: shortest-path traversal over a subway map is route planning with the graph handed over, and that page is where the graph, its anchoring to the world, and its goal-distance read-outs come from.
- **[[wiki/entities/temporal-context-model.md]]** — recency without a buffer and without prefrontal cortex: a unit-norm leaky integrator that advances only when input arrives gives short- and long-term recency from one mechanism, with maintenance placed in entorhinal cortex.
- **[[wiki/entities/tem-transformer.md]]** — a fully specified store discipline: the key/value cache is the memory, the query is a structural address, and the *write* policy is stated rather than assumed — store a conjunction only if it is not already there, else attention is biased toward whatever was revisited most.
- **[[wiki/entities/mm-tem-hippoformer.md]]** — splits the store by *horizon* instead of by type and measures the split: a 32-step attention window carries precise recent content and collapses beyond its training range, a fixed-size fast-weight memory addressed by a path-integrated code carries structure to 4,096 steps and is worse at one step, and running both in parallel beats either at both ends.
- **[[wiki/entities/fly-central-complex.md]]** — the wiki's one fully observed case of activity-based maintenance: a heading code held for >30 s with no sensory or self-motion input, in a completely imaged population, and maintaining a *reference frame* rather than a content buffer.
- **[[wiki/entities/stp-flickering-cann.md]]** — the activity-silent design: a hippocampal short-term memory that survives seconds with no reverberatory trace of its contents, held as a gain bias in synaptic release variables and expressed only when a probe (a theta trough releasing global inhibition) recruits the facilitated population.
- **[[wiki/entities/dense-sequence-memory.md]]** — maintenance and transition built from one weight matrix: the `MixedNet`'s symmetric term holds the current pattern for `τ` steps while its asymmetric term (driven by a low-pass filtered state) releases it, so the gate and the dwell timer are properties of the store rather than of a separate controller — and holding the *timing* needs a stronger nonlinearity than getting the order right.
- **[[wiki/entities/adaptive-cann.md]]** — prices maintenance exactly: the same slow negative feedback that makes a held state quick to update is what ends the holding, and `m = τ/τ_v` is the closed-form point at which a maintained value starts moving on its own — the continuous-manifold counterpart of the adaptation term in this page's noise-driven attractor chain.
- **[[wiki/entities/context-modular-memory-network.md]]** — storage/control separation implemented at the connectivity rather than at the buffer: the control variable holds no content (`s` discrete states) yet determines the whole set of retrievable attractors, so the controller's state is a handful of bits and its effect is an entire energy landscape.
- **[[wiki/concepts/attractor-dynamics.md]]** — maintenance is occupancy of a fixed point, and the noise-driven attractor chain is where sequence order comes from without a scheduler.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the primary source for this page's control/storage argument, and the store whose *addressing* is fully specified: content lookup, write-order links and a usage-based free list, with one learned gate choosing between allocating a fresh slot and editing a matched one.
- **[[wiki/entities/stsp-working-memory-rnn.md]]** — the controlled comparison of this page's two maintenance designs on one task, and the design whose central prediction this page's read-out section measures (information is expressed in bursts, not continuously): the synaptic store reproduces prefrontal cortex's collapse of delay decoding while the attractor store does not, reading it requires spiking (so maintain and use are separate metabolic regimes), and it survives ablation of half its synapses because the memory is not in the trained weights.
- **[[wiki/entities/pbwm.md]]** — the one design in this page where the *write policy itself* is learned: prefrontal stripes hold, basal-ganglia disinhibition enables the write, and which inputs deserve a write is trained by reinforcement — with the ablation (no dopamine modulation → 0% of networks learn any task) that shows a store without a trained gate is useless.
- **[[wiki/entities/trnn.md]]** — the fifth maintenance design and the only head-to-head performance test: a memory carried by a moving trajectory of sequentially peaking units, matched to mouse recordings by a transient index, more information-rich and cheaper than the persistent solution, and better on distractors, multiple items and spatial navigation at equal parameter count (Liu et al. 2025).
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — supplies the channel that decides *when* a held item is expressed: prefrontal beta bursts suppress gamma and informative spiking at exactly the sites that carry information, drop when a read is due and rise when the content stops being needed, so "which item is readable right now" is set by an inhibitory rhythm rather than by the store (Lundqvist et al. 2018).
- **[[wiki/concepts/population-geometry.md]]** — the level at which this page's store can be read at all: when two same-type variables share one prefrontal population (the held item and the attended location), what keeps both decodable is anti-aligned mixed selectivity in hybrid cells, not separate cells for each (Lebedev et al. 2004).
- **[[wiki/concepts/representation-probing.md]]** — supplies the instrument behind this page's removal-operations table (per-site representational similarity matrices clustered by their mutual similarity), and takes back the lesson that a distinction can exist in one subsystem and not another: four cortical communities represent the same four operations under four different quotient maps, and only the frontoparietal control network keeps all four apart (DeRosa et al. 2024).
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — what the store is for on the control side: an arbitrary rule set is swapped between blocks on the timescale of trials, which is only possible if the mapping is an addressable object rather than compiled into weights — and prefrontal cells coding the cue→action pairing are the wiki's evidence that it is (Wise & Murray 2000). It also carries the sharpest limit on how much of prefrontal cortex this page may claim: removing ventral prefrontal cortex leaves 8 s retention of nonspatial visual stimuli intact, and abolishes arbitrary mapping in a task where the cue never leaves the screen — so maintenance is not the region's specialized function ([[wiki/empirical-tensions.md]] T92, Murray et al. 2000).
- **[[wiki/concepts/cognitive-control.md]]** — supplies the reason this store is built out of activity rather than weights, which none of the maintenance designs above argue for: a control variable has to be broadcast to every system it recruits and swapped within a trial, and a synaptic change is local to its synapse and expressed only when that circuit fires. The same choice of carrier then predicts a capacity limit for free — superposed control patterns on one population interfere — which is an interference bound with graceful degradation rather than the slot count the designs here assume (Miller et al. 2002).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — localises maintenance within the medial wall: delay-dependent error growth (10 → 40 s) and spatial working memory impaired by muscarinic blockade occur for prelimbic/infralimbic cortex and not for anterior cingulate, and the deficit is reversed by co-applied oxotremorine — so the cholinergic gate on maintenance is a subregion parameter, not a global prefrontal one — and then bounds how much of that evidence survives: delay-length effects are confounded with novelty, delay firing with mediating behaviour, and trial memory with rule memory, leaving short-term memory for *actions and errors* as the well-controlled residue (Euston et al. 2012).
- **[[wiki/concepts/controller-knowledge-vs-process.md]]** — dissolves this page's store into a duration: if a "process" is just a set of long-term representations held active, then working memory has no occupancy of its own, and its capacity claim becomes how many stored items can be co-activated rather than how many slots exist (Wood & Grafman 2003).
- **[[wiki/concepts/inter-areal-synchrony.md]]** — the measurement layer under this page's phase dissociation: the encoding requirement lives on the direct link (gamma, abolished by terminal silencing) and the choice-point requirement on an indirect route (theta, untouched), so a spatial working-memory deficit can be a lesion of either pathway or of the clock that times them.
- **[[wiki/concepts/control-unity-and-diversity.md]]** — places this store's operations inside the control layer's factor structure: updating carries variance, genetics and a dopamine D1 dependence separable from set-shifting, and intelligence loads on that updating-specific component *in addition to* the common control factor — so capacity is not a symptom of general control (Friedman & Robbins 2021).
- **[[wiki/concepts/dynamic-network-connectivity.md]]** — a fourth locus for this page's capacity limit, and the only one that is *imposed rather than suffered*: prefrontal recurrence is held below its achievable level by a Ca²⁺→K⁺ shunt that exists to prevent runaway excitation, and blocking that shunt (apamin, xestospongin C) improves working memory — which also supplies a cause for the ~10–30 s handoff to the hippocampal store (Arnsten et al. 2010).
- **[[wiki/entities/meta-rl-agent.md]]** — makes maintenance a precondition for learning rather than for storage: the inner RL algorithm exists only as sustained recurrent state, so its adaptation horizon is this store's maintenance horizon, and the theory's stated emergence conditions require inputs carrying the previous action and reward (Wang et al. 2018).
- **[[wiki/entities/spacetime-attractor.md]]** — reinterprets the concurrent prefrontal sequence subspaces as a planner's state variable rather than a store: if those subspaces are wired to each other by the environment's adjacency matrix and receive time-indexed reward, maintaining a sequence and inferring one become the same relaxation, which unifies sequence working memory with planning in one circuit (Jensen et al. 2026).
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — a phase dissociation no store here can express: the *edge into* the controller is required at encoding while the *region* is required at retrieval, and any lesion design that hits the region cannot detect the difference.
- **[[wiki/entities/c-ts-model.md]]** — a maintenance mechanism priced by the *errors* it causes rather than by the delay it bridges: persistence of the gated prefrontal stripe across trials is the entire source of switch costs there.
- **[[wiki/entities/coin-model.md]]** — the experimental basis for identifying working memory with maintenance of the context probabilities: a working-memory distractor task produces evoked recovery of a previously-expressed memory.
- **[[wiki/entities/basal-ganglia.md]]** — the anatomy underneath every gated design on this page, and the reason the designs disagree: the module's own wiring supports releasing a thalamo-cortical loop, flipping a cortico-cortical switch, or carrying the reverberation itself, and the biology does not choose (T130). It also supplies the write-side operation none of the five models has — a thalamically-triggered cholinergic burst-pause that interrupts on the *arrival of an unmodelled event* rather than on input content.
- **[[wiki/entities/hami.md]]** — this page's architecture with the controller removed: a fixed-length sliding window of symbols, written unconditionally, cleared at the episode boundary, and read by exact match — enough to solve a non-Markovian task, and a clean measure of what the gating decision (G48, G49) is actually for (Poursiami et al. 2025).
- **[[wiki/entities/simple-cycle-reservoir.md]]** — the formal complement to this page's existence: fading memory is a *continuity* requirement that forces the influence of any past input to decay, so Li, Fong & Tiňo's theorem simultaneously makes contractive recurrent architecture free (any ring will do) and proves that no such network — at any width or wiring — can hold a bound value over an arbitrary interval, which is exactly the job a gated store is here to do.
- **[[wiki/entities/ltc.md]]** — a negative result worth carrying explicitly: making the decay rate learned, per-unit, input-conditioned and provably bounded does *not* produce maintenance, because the bound runs the wrong way — `f ≥ 0` gives `τ_sys ≤ τ`, so adaptation only shortens memory below a learned ceiling, and the authors concede vanishing gradients and that LTCs are not the choice for long-term dependencies. An adaptive fading horizon and a held variable are different mechanisms, and this is the wiki's strongest evidence that the first cannot be stretched into the second.
- **[[wiki/entities/cfc.md]]** — the same negative result one step further along: removing the ODE solver entirely, which buys 1–5 orders of magnitude in speed, moves nothing on long-range dependence — the authors' own remedy is to wrap the continuous-time cell *inside an LSTM* (CfC-mmRNN), and that mixed-memory variant is the only one that wins IMDB. Maintenance keeps having to be imported from a discrete gated cell rather than obtained from continuous dynamics.
- **[[wiki/entities/s4.md]]** — the strongest available separation between a long *horizon* and a maintained *variable*: a fixed linear time-invariant kernel with an `O(N)` state and no gate carries a dependency across 16,384 steps (Path-X 96.35%, every attention baseline at chance), which removes "handles long-range dependencies" as evidence for a working-memory mechanism — what stays diagnostic is holding a value against interference and reading it on a content-dependent query, and an LTI convolution can express neither (Gu et al. 2022).
- **[[wiki/concepts/autonomous-pattern-generation.md]]** — states the demand this page exists to meet, from the output side: under the echo state property with a periodic drive the network state is a function of clock *phase alone*, so successive cycles are indistinguishable and any generator whose next phrase depends on the previous one requires exactly the non-fading, phase-breaking variable this page supplies.
- **[[wiki/entities/transformer.md]]** — this page's negative case in its most explicit architectural form: nothing in the layer stack is a register — the query is recomputed from the current token at every step, the key/value cache is append-only and never rewritten, and the only state surviving a step is the token sequence itself — so the architecture has a growing verbatim log and no maintained variable, which is the distinction long-range benchmark results do not test (Vaswani et al. 2017).
- **[[wiki/concepts/vector-symbolic-binding.md]]** — what a fast store would hold if its contents were structured: one vector per episode supporting both similarity ranking and slot-level interrogation (`P ⊛ role†` plus cleanup) on the same representation, rather than a set of unstructured content slots.
- **[[wiki/concepts/analogical-mapping.md]]** — a concrete division of labour between a permanent and an active code: an element's context-free code is what memory stores, while the episode-specific re-representation (the same code superposed with the roles it fills *here*) exists only during the comparison — with which of the two is actually stored left open by the source.
- **[[wiki/entities/lisa.md]]** — the one model in the wiki whose capacity limit is a consequence rather than a parameter: bindings are phases, so the number of simultaneously maintainable role-filler bindings is the number of resolvable phases, and relational complexity becomes the load variable in place of item count.
- **[[wiki/concepts/memory-read-and-erase.md]]** — the access protocol split out of this page: this page is the carrier (what holds an item, what holding costs, where the capacity ceiling sits), that one is the read schedule and the typed erase, and the dissociation is measured — a correctly encoded item can still be read at the wrong time, which is where the prefrontal errors live.
