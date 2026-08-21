# Memory Read and Erase

**A store is not defined by what it holds but by a protocol: reads are scheduled events with an addressee and a lead time, and removal is a typed family of operations, not one primitive.** Every fast store in the wiki exposes two primitives — write, and read-on-demand as a pure function of the query — with forgetting supplied by a decay constant or an eviction policy. Prefrontal cortex runs at least five: prepare a specific item for a query that has not arrived yet, cancel that preparation when an earlier result makes the query unnecessary, deliver an inhibitory clear *to the sites holding the now-irrelevant content*, replace an item, and empty the buffer. This page is the access protocol; [[wiki/concepts/working-memory.md]] is the carrier.

The split matters for a reasoning model because the framing's fast level is a store that a controller queries during inference ([[wiki/concepts/latent-graph-discovery.md]]). If the read is free and always available, the controller only has to decide *what* it wants. If the read is a scheduled, metabolically priced event, the controller's output is an address **plus a time**, and a whole class of failure — the item is intact, the schedule was wrong — becomes possible, diagnosable and, so far, undesigned-for.

| Primitive | What the wiki's stores implement | What is measured biologically |
|---|---|---|
| **Read** | Pure function of the current query; recomputed every step (softmax attention), or a similarity match against keys | A prospective event: gamma ramps several hundred ms before the item is needed, for that item and no other, cancelled when the query becomes moot |
| **Replace** | Write over a matched slot — the standard case | Separable in cortical representational geometry from both suppress and clear |
| **Suppress** (drop one item, buffer stays occupied) | **Nothing** | Distinct in the frontoparietal and default-mode communities |
| **Clear** (empty the buffer) | Approximated by usage-driven eviction ([[wiki/entities/differentiable-neural-computer.md]]'s free list) | Distinct from suppress in three of four communities; the *only* operation somatomotor cortex separates |
| **Read schedule / lead time** | **Nothing** | The output format is known (item address + lead time); the policy is not |

The three gaps this page owns are [[wiki/architectural-gaps.md]] **G48** (content register vs. attentional pointer), **G49** (no store schedules its own reads, none has a relevance-addressed erase) and **G60** (every architecture derives its retrieval query from the goal; none *chooses* the query).

---

## Reading is a separate operation, and something schedules it

Most of the delay signal in dorsolateral prefrontal cortex is the pointer rather than the item ([[wiki/concepts/working-memory.md]], Lebedev et al. 2004; gap G48). Lundqvist et al. 2018 record the operation that pointer serves. Macaque prefrontal cortex, **two-object sequence** delayed match: sample 1 → 1 s → sample 2 → 1 s → test 1 → 1 s → test 2, with the bar release permitted only after the *whole* test sequence (95.5% correct). Because nothing is responded to at test 1, the read-out and evaluation of the first item is observable with no motor confound — the confound that makes most delayed-response recordings unusable for this question.

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

## What a machine store would have to add

The two measurements above are correlational and cued, so what they license is a *specification*, not a mechanism. Stated as one:

| Component | Signature to reproduce | Nearest thing in the wiki, and why it falls short |
|---|---|---|
| **Read scheduler** | Emit `(item address, lead time)`; start preparation before the query; cancel when the query becomes unnecessary | [[wiki/entities/pbwm.md]] learns a *write* gate by reinforcement and leaves the read ungated; softmax attention recomputes selection from the current query and therefore cannot prepare anything in advance ([[wiki/concepts/attention.md]]) |
| **Relevance-addressed erase** | Deliver a clear to the sites holding the content, dropping their information while sites holding nothing are unaffected | [[wiki/entities/differentiable-neural-computer.md]]'s free list frees by *usage* and orders by write time; neither is relevance |
| **Typed removal** | `replace` / `suppress` / `clear` as three operations, with `clear` not implemented as a loop over suppressions | Only `replace` exists; `clear` is approximated by eviction; `suppress` is absent everywhere |
| **Occupancy read-out** | The store reports how full it is, so the controller can decide *whether* to remove before deciding *what* | [[wiki/entities/conceptor.md]] is the one machine store that computes this from its own contents — used space `A^j = C¹∨…∨C^j`, quota `q = Σs_i(A^j)/N ∈ [0,1]`, novelty as the Boolean difference `C^{j+1} ∧ ¬A^j` — which is the write-side twin of a relevance-addressed erase (G42) |
| **Pointer register** | Carry *what is currently being tracked* as state that survives a step and is typed differently from the contents | No architecture has both; read-head state in a memory-augmented network is addressing bookkeeping, not a task-level pointer, and no gate clears it by relevance (G48) |
| **Query chooser** | Load the query register with whatever maximises predictive validity × detectability over the goal's associative neighbourhood, then monitor and reload | Every architecture sets `q = encode(goal)`; the proposer/scorer/monitor triple is unbuilt (G60) |

**(brainstorm) The cheapest experiment is a diagnostic, not an architecture.** Instrument any existing key-value or attention store to log *when* and *at what* it was read, then score the schedule separately from the contents. The prefrontal error pattern says the two dissociate — on non-match trials answered "match", the comparison at test 1 followed the correct trajectory and the deviation appeared in the *following* delay — so a store whose contents probe clean while its task accuracy falls is not a paradox but a locatable failure. No machine memory currently supports the measurement, and it needs no new architecture to make.

**(brainstorm) The type of the removal may not belong in the store at all.** Sensory cortex carries only the occupancy bit while the frontoparietal network carries the full four-way identity, so *why* an item was removed never reaches the carrier. That argues for keeping the operation code in the controller and shipping only its effect downstream, rather than tagging memory entries with a removal reason — the opposite of what a usage/priority field in a machine store does.

---

## Open problems

| # | Problem |
|---|---|
| 1 | **The schedule's policy.** The output format is known — an item address plus a lead time — and nothing says how the lead time is set, or what it should be a function of (item retrieval latency? deadline? confidence?) (G49) |
| 2 | **Whether `suppress` is worth having.** It is separable in cortex, and no machine argument yet says what a store gains from removing one item without either overwriting it or reclaiming the space |
| 3 | **Causal status.** Both primary sources are correlational; no manipulation links a network's representational pattern on a trial to whether the item was actually removed, and removal here is *cued*, so this is instructed forgetting rather than self-initiated forgetting ([[wiki/empirical-tensions.md]] T90) |
| 4 | **Where the read budget comes from.** A scheduled read has a metabolic cost paid only when it happens, which implies a budget; nothing in the wiki prices a read at all, so no controller can trade reads against anything |
| 5 | **Composition with consolidation.** A relevance-addressed erase and a recall-gated write are the same decision seen from two ends, and no architecture makes them one policy ([[wiki/concepts/recall-gated-consolidation.md]], [[wiki/concepts/offline-replay.md]]) |

---

## Connections

- **[[wiki/concepts/working-memory.md]]** — the carrier this page is the protocol for: that page asks what physically holds an item over a delay and what it costs to hold, this one asks when the held item is read, by whom, and how it is removed — and the two are dissociable in exactly the place the split predicts, since a correctly encoded item can still be read on the wrong schedule.
- **[[wiki/concepts/attention.md]]** — the operation whose machine form has no schedule: a softmax row is recomputed from the current query every step, which makes preparation-in-advance inexpressible and makes retrieval precision degrade with occupancy by arithmetic rather than by policy.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the closest existing read/erase machinery, and the measure of the gap: its free list and temporal-link matrix free by usage and order by write time, so it has an erase with the wrong address and a read with no lead time.
- **[[wiki/entities/pbwm.md]]** — the write-side twin: a gate learned by reinforcement decides what enters the store, and the same argument applied to the read side is what G49 asks for; the anatomical split it makes with basal ganglia matches the scheduler-is-a-different-circuit-from-the-store result here.
- **[[wiki/entities/conceptor.md]]** — the one machine store that reads its own occupancy from its own contents, which supplies the missing precondition for a removal policy: you cannot decide what to erase without knowing how full you are, and its Boolean difference `C^{j+1} ∧ ¬A^j` is a relevance-like test computed at write time rather than at erase time.
- **[[wiki/concepts/representation-probing.md]]** — supplies the instrument the removal result depends on: parcels partitioned by the similarity of their *similarity structures* rather than by connectivity or activation, which is what makes "these four subsystems cut the four operations differently" a measurable claim.
- **[[wiki/concepts/continual-learning.md]]** — the same question at the slow timescale: a relevance-addressed erase is targeted forgetting with the interference problem solved by addressing rather than by rehearsal or by regularisation.
- **[[wiki/concepts/retrieval-capacity.md]]** — the capacity story this page's read-side account competes with: if the bound is in the selection rather than in the carrier, then enlarging a store buys nothing, which is the assumption every key-value design makes and none tests.
- **[[wiki/concepts/priority-map.md]]** — the closest thing the wiki has to a relevance signal that could address an erase, currently used only to select *what to look at next* rather than *what to drop*.
- **[[wiki/concepts/cognitive-control.md]]** — the controller whose output format this page constrains: an address plus a lead time plus a removal type is strictly more than the "which slot" that every machine controller emits.
- **[[wiki/entities/stp-flickering-cann.md]]** — the substrate that makes an intermittent read cheap: if the item lives in short-term synaptic plasticity between bursts, expression is a scheduled event by construction rather than a continuous cost, which is what the gamma-burst measurement is evidence for ([[wiki/empirical-tensions.md]] T86).
- **[[wiki/concepts/latent-graph-discovery.md]]** — why this is not bookkeeping: the fast level of the framing is a store queried during inference, so a read protocol with a schedule and a typed erase is part of the specification of the instance-graph binder, not an implementation detail beneath it.
- **[[wiki/entities/arc-agi-3.md]]** — this page's missing primitive arriving as an engineering necessity rather than a proposal: 64×64 frames per turn exhaust an LLM's context, and both harnesses that solved the public environments did it by relevance-addressed reads over the agent's own history — arbitrary Python executed against the action log, or subagents returning compressed summaries to an orchestrator that never sees a raw frame.
