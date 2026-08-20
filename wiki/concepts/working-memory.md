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

**Read against the maintenance evidence.** The paper does not deny prefrontal short-term memory; it denies that maintenance accounts for most of the delay signal, and it reinterprets two pillars of the opposite case — Funahashi et al.'s "mnemonic scotomas" after prefrontal inactivation are equally consistent with a localized failure to attend, and antisaccade/brightness tasks confound the cued location with the attention-attracting one.

---

## Reading is a separate operation, and something schedules it

The section above says most of the delay signal is the pointer. Lundqvist et al. 2018 record the operation that pointer serves. Macaque prefrontal cortex, **two-object sequence** delayed match: sample 1 → 1 s → sample 2 → 1 s → test 1 → 1 s → test 2, with the bar release permitted only after the *whole* test sequence (95.5% correct). Because nothing is responded to at test 1, the read-out and evaluation of the first item is observable with no motor confound — the confound that makes most delayed-response recordings unusable for this question.

| | **Gamma bursts** (~50–120 Hz) | **Beta bursts** (~20–35 Hz) |
|---|---|---|
| Relation to item information | Spiking **and** percent-explained-variance for object identity are higher *inside* bursts (`p` < 0.0001, `p` = 0.02) | Spiking suppressed inside bursts (`p` = 0.004) |
| Where | 160/188 sites gamma-modulated, overlapping the 130 informative sites (`p` < 6e−6, Fisher) | Same sites, opposite sign; anti-correlated over time **only** at informative sites (`r` = −0.40 vs. `r` = 0.08) |
| Across-site relation to peak information | `rho` = **+0.49** with stimulus-induced gamma | `rho` = **−0.44** with stimulus-induced beta |
| Time course | Brief bursts of varying centre frequency, weakly correlated across trials; per-neuron information tracks the gamma rate over time (`r` = 0.23, carried by the most informative neurons) | Elevated during delays and, especially, post-trial |

The trial-averaged "sustained" oscillation is an artefact of averaging — single trials show discrete bursts. So **expression of an item is intermittent even while the item is held**, and if different items burst at different times one store can hold several without interference (time-division multiplexing). The model under test is a short-term-plasticity one, so between bursts the item is in synapses ([[wiki/empirical-tensions.md]] T86, [[wiki/entities/stsp-working-memory-rnn.md]]).

### The read is item-specific, prospective, and gated by relevance rather than by predictability

| Event about to happen | Gamma ramp in the preceding delay? | Information ramp, and about what? |
|---|---|---|
| Test 1 (must be compared to sample 1) | **yes** (`p` < 0.0001) | yes, about **sample 1 only** (`p` = 0.003); sample 2 shows a non-significant *decline* |
| Test 2, after a *matching* test 1 | **yes** | yes, about **sample 2 only** (`p` = 0.0005) |
| Test 2, after a *non-matching* test 1 — the sequence is already decided | **no**; beta rises instead, at informative sites only | **no** (`p` = 0.001 vs. match trials) |
| Sample 2 — equally predictable, but nothing to read | **no** (non-significant decrease) | no |
| Tests 3/4 of the second, always-matching sequence — responded to, never evaluated | **no** (`p` = 0.46, 0.23) | no |

The last two rows carry the argument. Predictability of an event does not trigger a read; a forthcoming *query against the store* does. And the one object that is always responded to (test 4) gets no ramp while the one that is never responded to (test 1) does, so the ramp is not motor preparation.

### Clearing is a signal, and the schedule is where errors live

- **Post-trial.** The single largest time × frequency difference between informative and non-informative sites anywhere in the dataset is beta *elevation* at the informative sites after the response, while information about the last object drops sharply (`p` < 0.0001). Forgetting is a signal delivered to the sites that hold something, not a time constant running out.
- **Graded comparison in one channel.** Gamma during test 1 was lowest for a match, intermediate for an **order** violation, highest for an **identity** violation — so a single burst-rate channel carries a graded match score, and violating order registers as *less* of a mismatch than violating identity. Beta then separated match from non-match (either kind) and bridged the following second; gamma's distinction died within a few hundred ms.
- **Errors are control errors.** On non-match trials answered "match", gamma and beta *during* test 1 followed the correct non-match trajectory; the deviation appeared in the following delay, where gamma ramped up and beta was suppressed exactly as on match trials. The comparison was computed correctly and the **read schedule** was wrong. The mirror case (match answered "non-match") went wrong immediately, at test 1.

Four things this changes for fast **M**:

- **Hold, read and clear are three operations with three signatures, and only one of them is expensive.** Every store in the wiki exposes a read as a pure function of the query, available whenever it is called. Here it is a scheduled event with an onset, a specific addressee, and a metabolic cost that is paid only when the read happens — which is what the activity-silent designs predict and this measures directly ([[wiki/entities/stp-flickering-cann.md]]).
- **The controller's output is an address *plus a time*.** The ramp starts several hundred milliseconds before the item is needed and names which item. A machine controller that emits only "which slot" is under-specified against this; the missing half is *when to have it ready*, which is exactly the state a store needs to be usable at a deadline. (gap G49)
- **Deletion has a dedicated channel with the right addressing.** Beta rises at informative sites and not elsewhere, i.e. the clear is delivered *to the sites holding the now-irrelevant content*, which is a content-addressed erase — the operation Lebedev's prospective decay implies and no key-value store in the wiki implements (gaps G48, G49; [[wiki/empirical-tensions.md]] T89; [[wiki/entities/differentiable-neural-computer.md]]'s free list is the closest and is addressed by usage, not by relevance).
- **(brainstorm) The failure mode to design against is a mis-scheduled read, not a corrupted item.** This is the wiki's only case where a memory error is localized to the control layer with the encoding verified intact on the same trials. It suggests a diagnostic no machine memory currently supports: log *when and at what* the store was read, and score the schedule separately from the contents.

**Where the control layer might live.** The authors place beta generation in the mediodorsal thalamus–prefrontal loop and the contents in superficial prefrontal layers, i.e. the scheduler is a different circuit from the store — the same split [[wiki/entities/pbwm.md]] makes on the write side with basal ganglia, and the anatomical version of this page's control/storage separation ([[wiki/concepts/canonical-cortical-microcircuit.md]]).

**Caveat.** Everything here is correlational: burst rates are local-field-potential measures with no causal manipulation, and "volitional" is inferred from the task-relevance contrasts rather than demonstrated by intervention.

---

## Removal is at least three operations, and different subsystems cut them differently

The section above treats the clear as one primitive delivered to the right address. DeRosa et al. 2024 (re-analysis of Kim et al. 2020; 55 humans, cued fMRI, 72 trials each of **maintain / replace / suppress / clear**, 360 Glasser parcels) show the primitive is a *family*, and that no single subsystem is responsible for distinguishing its members.

**Instrument.** Per-parcel representational similarity matrices over the 288 trial vectors → parcels clustered by how similar their *similarity structures* are (Spearman correlation → weighted k-nearest-neighbour graph → bagged Leiden community detection). The result is a partition of the brain by **representational geometry rather than by connectivity or by activation level** ([[wiki/concepts/representation-probing.md]]). Four communities fell out, aligned to conventional networks.

| Community | Cut it makes over the four operations | Pairwise classification (area under precision–recall curve; **low = the two operations look alike**) |
|---|---|---|
| **Visual** (76 parcels) | Binary: *is an item being held at all* — {maintain, replace} vs. {suppress, clear} | within-pair 0.610–0.698, across-pair 0.985–0.993 |
| **Somatomotor** (63) | `clear` singled out; everything else weakly separated | maintain vs. replace **0.532**; clear vs. maintain/replace 0.953–0.965 |
| **Default mode** (121) | Held vs. removed, **plus** suppress ≠ clear | all pairs 0.932–0.988 |
| **Frontoparietal control** (100) | All four distinct — the only community that does | all pairs 0.968–0.999; across-operation 0.956–0.980 |

Four consequences for a machine store:

- **"Delete" is under-specified as a single primitive.** Overwriting a slot with new content (`replace`), removing one item while the buffer stays occupied (`suppress`), and emptying the buffer (`clear`) are separable in representation, and only one of them is what a free list does. The wiki's stores implement `replace` (write over a matched slot) and a usage-driven approximation of `clear`; **none has `suppress`** — a targeted removal that leaves the rest of the store untouched and is not triggered by an incoming item needing the space (gap G49).
- **The cheap cut and the expensive cut are made by different subsystems.** Sensory cortex only needs the occupancy bit (held / not held); the control network carries the full 4-way identity. So the *type* of the removal is control-layer information that never reaches the store — an argument for keeping the operation code in the controller and shipping only its effect downstream, rather than tagging memory entries with why they were removed. (brainstorm)
- **`clear` is not the limit of `suppress`.** Emptying the buffer separates from suppressing one item in three of four communities, and in somatomotor cortex it is the *only* operation that separates at all — consistent with clear involving a shift away from external sensory/motor processing rather than a stronger version of item-targeted deletion. A store whose "clear all" is implemented as a loop over per-item suppressions is making an assumption the biology contradicts.
- **The operations run in parallel across communities, in different formats.** This is the same content represented under four different quotient maps simultaneously — which is what makes the causal question below undecidable from these data.

**Caveat, and it is the authors'.** The design cannot say whether an operation is implemented by the *conjunction* of the four network codes or by the frontoparietal network alone with the other three patterns as by-products of top-down control ([[wiki/empirical-tensions.md]] T90). Nothing here is causal: no manipulation, and no link between a network's representational pattern on a trial and whether the item was actually removed (the classifier-verified removal is in Kim et al. 2020, not re-linked here). Operations are also *cued*, so this is instructed removal, not self-initiated forgetting.

---

## The capacity limit can be in the read, not in the store

Every design above locates capacity in the carrier — distinguishable stable states, distinguishable facilitated populations, noisy transitions before the chain blurs. One measurement locates it in the *access* instead (Gong & Zhang 2024, [[wiki/concepts/attention.md]]). Minimal causal transformers (1 layer, 1 head, no feed-forward network, no layer norm; 50 models per condition) trained on the `N`-back task lose accuracy logarithmically as `N` grows, while the whole 24-item sequence sits well inside the context window — the item is present, uncorrupted and addressable, and the model still fails. Over training, attention aggregates onto the `i−N` diagonal; accuracy at `i` tracks the attention mass at `i−N`; and summed row entropy of the attention matrix rises with `N` exactly as accuracy falls.

- **This is the executive-attention account of human capacity, reproduced in an architecture not designed to have it**: the bound comes from the scarcity of selection, not of storage. It predicts that a store can be enlarged without raising capacity, which is what the wiki's key-value designs implicitly assume is false.
- **The competition is arithmetic.** A softmax row spreads one unit of mass over every candidate, so retrieval precision degrades with occupancy by construction — a capacity model that every attention-based store already has and none reads out (gap G42).
- **It largely disappears with two layers or a few heads** (>95% at every `N`, with a residual decline), so this is an existence proof that self-attention *can* be the binding constraint, not a measurement of the constraint in a large trained model.

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

## Open problems

- **Binding and variables.** The DNC demonstrates variable-binding-like behaviour without showing that a reusable variable *representation* exists; whether the binding generalizes to novel structures is untested here.
- **Capacity and interference in the buffer** — no account of what happens when the instance-graph exceeds the memory matrix. And the limit need not be the matrix at all: where reads are by softmax attention, precision falls with the number of competing entries before the store is anywhere near full (Gong & Zhang 2024).
- **Structural addressing.** Reads are by content similarity; navigation needs addressing by graph position (path-consistent `g`, gap G3).
- **Interpretability.** Networks with external memory are the case that resists virtual brain analytics most stubbornly.

---

## Connections

- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — derives the `7 ± 2` span from noise-driven transitions between asymmetrically coupled attractors, making capacity a dynamical rather than a slot limit, and puts serial order in the same recurrent network that stores episodes.

- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the only architecture in this ingest that performs explicit multi-hop graph traversal, and marks the boundary: it navigates a *given* graph, it does not discover one.
- **[[wiki/concepts/attention.md]]** — attention is also where this page's capacity limit can sit: in a minimal transformer trained on `N`-back the item stays inside the context window and the *read* is what degrades, logarithmically in the offset and in step with the entropy of the attention matrix (Gong & Zhang 2024). Attention is the read mechanism of an external memory, and the read is *scheduled*: gamma bursting and object information ramp up several hundred milliseconds before the item is queried, for that item only, and not before an equally predictable event that requires no read (Lundqvist et al. 2018); internal attention and content-addressable retrieval are the same operation — and in prefrontal cortex the two are not separable at the read-out: 61% of delay-tuned cells track the attended location and 16% the remembered one, so the store's persistent signal is mostly its own pointer (Lebedev et al. 2004).
- **[[wiki/concepts/complementary-learning-systems.md]]** — external memory is the engineering form of the fast store; working memory adds the controller that decides what is written and read.
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
