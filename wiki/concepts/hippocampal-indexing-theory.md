# Hippocampal Indexing Theory — a Memory Trace With No Content

**An episode is stored as a set of strengthened synapses in the hippocampus that records *which* neocortical modules were coactive, and nothing about what they represented. Retrieval is addressing: a fragment of the episode reactivates its cortical subset, that subset reactivates the index, and the index projects back to reinstate the whole cortical pattern. The content never leaves cortex, and no connection *between* cortical modules is changed at encoding.**

> **Provenance.** Teyler & Rudy 2007, *The hippocampal indexing theory and episodic memory: updating the index*, Hippocampus 17(12):1158–1169 (`raw/teyler-2007-hippocampal-indexing-theory-updated.md`) — the original authors' 20-year re-assessment of Teyler & DiScenna 1986. A commentary: no new data, and the behavioural ledger below is assembled from other groups' experiments. Converted from PDF (`LOSSY`) — Figures 1–5 are present as captions only. The wiki previously cited this theory only second-hand, through models that presuppose it ([[wiki/entities/tolman-eichenbaum-machine.md]], [[wiki/entities/tem-transformer.md]], [[wiki/entities/vector-hash.md]]).

---

## The four-step claim

| Step | Operation | What changes |
|---|---|---|
| 1. Experience | Episode features activate a distributed set of neocortical modules | Nothing yet |
| 2. Write | That pattern projects to hippocampus; synapses onto the responding hippocampal cells **and** among the coactivated hippocampal cells are strengthened | Hippocampal synapses only — **no modification among the neocortical patterns** |
| 3. Cue | A subset of the original features reactivates its cortical modules, which reactivate the index | Nothing |
| 4. Reinstate | The index projects back and activates the full cortical pattern | Nothing — retrieval is read-only |

The load-bearing asymmetry is step 2: a conventional associative account would strengthen the cortico-cortical links *between* the modules, and the theory's whole economy argument is that this is the expensive operation and must be deferred.

**The economy argument, stated as a design principle.** Most daily experience is of no lasting significance, so paying to bind cortical modules together is wasteful. The index is the cheap alternative: fast to write, and *designed to be lost* — either by decay of the labile potentiation that carries it or by depotentiation from interfering input. Forgetting is the default state of the store, not a failure of it, and an index persists only if the episode is repeated or carries neuromodulatory (reward/emotional) significance.

---

## The specificity problem, and the one mechanism offered for it

An index is only useful if it addresses *the* pattern it indexed. Hippocampal return projections are broad, so the naive scheme reinstates everything the hippocampus projects to. The theory imports O'Reilly & Rudy 2001's route:

| Element | Role |
|---|---|
| Entorhinal cortex → dentate gyrus → CA3 | Builds the index proper — the conjunctive representation |
| Entorhinal cortex → CA1 (direct) | Builds a **second** representation of the same episode |
| CA3 ↔ CA1 | Coactive, so strengthened — this is what lets the index reach CA1 |
| **CA1 → entorhinal cortex** | Coactive with the entorhinal cells the *experience* is driving, so the return synapses onto **exactly those cells** are strengthened at encoding |

So the return address is not wiring, it is **learned during the write**, on the CA1→entorhinal synapses, by the coincidence of a backward-driven CA1 cell and a forward-driven entorhinal cell. Retrieval: partial entorhinal input → CA3 completes → CA1 → the specific entorhinal pattern.

**(brainstorm) This is the write-side symmetry every machine store omits.** Retrieval-augmented and fast-weight architectures learn an addressing function into memory and read it out through a *fixed* decoder. Here the read-out is learned in the same event as the write, against the encoder's own activity as the target — one Hebbian coincidence produces both the address and its inverse. The machine version is cheap and nobody builds it: at write time, also potentiate the store→encoder path onto the units currently active, so the decoder is per-item rather than shared.

**The anatomy contests the metaphor even if the circuit is right.** The macaque tracer data say the medial-temporal return path is not cell-for-cell reciprocal with the input path ([[wiki/concepts/hierarchy-of-associativity.md]]): frontal → perirhinal is much wider than the reverse, perirhinal → V4/TEO is *more* widespread than the reverse. The CA1→entorhinal mechanism above rescues addressing only as far as entorhinal cortex; everything beyond it, out to the cortical modules that actually hold the content, is a broadcast into a partly different population. Under that reading reinstatement is **generative re-synthesis under a constraint vector**, not addressing, and the prediction is that reinstatement fidelity is ordered sensory > frontal (`T28`, untested).

---

## The plasticity requirement, and a second candidate substrate for the two rates

The theory needs the fast store's synapses to be *more labile* than the cortical ones, and derives the requirement from the economy argument rather than assuming it. Its proposed mechanism is an **induction-threshold / calcium-source** split, which is distinct from the wiring-plasticity account in [[wiki/concepts/complementary-learning-systems.md]]:

| Form | Induction requirement | Calcium source | Durability | Proposed job |
|---|---|---|---|---|
| **NMDA-receptor-dependent LTP** | Modest afferent input, modest depolarization | NMDAR influx | Rapid, and **reversible by low-frequency input** (depotentiation) | Writing the index; its reversibility *is* the forgetting mechanism |
| **VDCC-dependent LTP** | Strong input, large depolarization | Voltage-dependent calcium channels | Slower to develop, much more stable | Binding coactive neocortical ensembles — the expensive operation |

Two complications the authors raise themselves:

- **Both forms exist in both structures.** The split cannot be anatomical. What makes it work is that LTP is harder to induce in cortex *in vivo*, proposed to be strong inhibitory control preventing the depolarization NMDAR-LTP needs ([[wiki/concepts/excitation-inhibition-balance.md]]). The rate difference is therefore an **inhibition-set induction threshold**, not a different learning rule.
- **The hippocampus also has the durable form.** So repetition or reward can make the *index* permanent, independently of whether anything consolidated into cortex — a third outcome the two-store picture has no slot for.

**(brainstorm) The machine translation is a thresholded write, not a learning rate.** Every CLS implementation encodes "slow" as a small step size applied to every sample. This says the slow learner should apply *no* update below an activation threshold and a large, stable one above it, with the threshold set by an inhibitory gain that another system controls — which makes consolidation a gating decision rather than an integration, and makes the fast store's rate the same rule with the gain turned down. It also predicts that a cortical learner with its inhibition removed becomes a second fast store and inherits the interference the split exists to remove.

---

## Hierarchical indexing: the hippocampus does not index all of cortex

The 1986 version had the hippocampus indexing every neocortical locus. The update retracts this:

| Argument | Statement |
|---|---|
| Anatomy | Direct hippocampus↔neocortex projections are confined to the adjacent medial-temporal association cortices (entorhinal and related) |
| Scaling | Human neocortex expanded enormously with **no** proportional hippocampal expansion — an index addressing all of cortex would have had to grow with it |
| Revised scheme | Hippocampus indexes **association cortex**, which indexes the rest — "an association cortex for the association cortex" |

**(brainstorm) This converts a modelling convenience into a capacity claim with an exponent.** A flat index must scale with the number of addressable cortical sites; a two-level index scales with the number of *association-cortex* sites, and the fan-out is spent at the lower level, which is already a compression stage ([[wiki/concepts/hierarchy-of-associativity.md]]). The measurable version for a machine store: hold the store's size fixed, address a learned intermediate summary layer instead of the encoder's full activation, and the prediction is that capacity is set by the intermediate layer's dimension while retrieval fidelity is set by that layer's invertibility — two quantities the flat design confounds. No model in the wiki indexes anything but the encoder's own code.

---

## The behavioural ledger

The theory's five testable claims, with the evidence the update assembles (all cited, none run by the authors):

| Claim | Key evidence | Reading |
|---|---|---|
| The hippocampus captures **context** as a conjunction | Context pre-exposure / immediate-shock: pre-exposure to the *intact* context rescues immediate-shock conditioning; pre-exposure to the **separated features** (floor texture, illumination, shape, sound) does **not**. Blocked by dorsal-hippocampal lesion, by muscimol at pre-exposure, shock *or* test, and by d-AP-5 at pre-exposure but not at shock | The stored object is the conjunction, and it is written by NMDAR plasticity at the *exploration* stage, not at the reinforcement stage |
| It captures information **automatically** | Object recognition is context- and location-bound in intact rats with nothing in the task demanding it; hippocampal damage leaves novelty preference intact but removes the object↔context and object↔location binding | The index is written without an encoding instruction — an always-on write policy |
| It captures **single** episodes | Daily-changing hidden-platform water maze: intact rats improve on trial 2 at a 2 h inter-trial interval, hippocampal-lesioned rats do not; intra-hippocampal d-AP-5 before trial 1 impairs trial 2 | One-shot write, plasticity-dependent |
| It supports **pattern completion** | Conditioning to the *memory* of a context: a transport cue previously linked to context A, presented before immediate shock in a novel context C, produces fear of **A** and not of B — abolished by dorsal-hippocampal lesion or inactivation. CA3-restricted NR1 knockout and CA3 ibotenic lesion impair recall when 2–3 of 4 cues are removed but not with the full cue set | Cued recall exists in animals, and the retrieved representation is associable — an index read-out can enter *new* learning ([[wiki/concepts/retrieval-mediated-learning.md]]) |
| It supports **pattern separation** | Hippocampal-lesioned rats generalize fear to a similar-but-unshocked context more than intact rats; dentate-lesioned rats fail to discriminate two identical objects as the spatial distance between them shrinks | Graded in input similarity — the transfer-curve discipline of [[wiki/concepts/pattern-separation-completion.md]] |

**The conditioning-to-a-memory result is the strongest item here and the wiki under-uses it.** It is the only experiment in the ledger where the *reinstated* representation is shown to be functionally equivalent to the stimulus: a retrieved context supports new associative learning on its own. That makes the index read-out a first-class input to the rest of the system, which is exactly the property a reasoning architecture needs from memory and which recall-accuracy metrics do not measure.

---

## What the theory declares *not* load-bearing

Systems consolidation — the eventual hippocampus-independence of old memories — is presented as a *permitted* consequence of the architecture, not a commitment. The authors call it unsettled, citing lesion studies in which retrograde damage impairs place learning and contextual fear **regardless** of the training–surgery interval against others showing a gradient, and then state explicitly that the theory survives either outcome: what motivates it is that the index is cheap and most of what it stores should be forgotten.

This matters for two rows. `T97` and `T82` both treat the recent/remote gradient as evidence about the channel; here the theory's own authors decline to stake it. And `G14`'s question — what selects material for transport — is orthogonal to indexing: an index with no transport at all is still the theory.

**And the theory has a maintenance problem its own descendants name and nobody has solved.** Kumaran, Hassabis & McClelland 2016 (`raw/kumaran-2016-complementary-learning-systems-updated.md`) list the **index maintenance problem** as an Outstanding Question: an index points at a *cortical activity pattern*, and the slow learner's representations change continuously as it consolidates, so every stored index is silently invalidated by the very process the index is supposed to feed. Are hippocampal representations updated to track the drift, and if so how?

Three things follow that this page should carry.

- **The problem is specific to content-free indexing** and is the price of the theory's central economy. A store that holds content degrades gracefully as cortex drifts; a pointer is either valid or dangling, so drift converts to hard retrieval failure rather than to blur.
- **It composes badly with rapid schema-dependent consolidation** ([[wiki/concepts/schema-assimilation.md]]): the faster cortex reorganises around a new schema, the faster the outstanding index set rots, so the two mechanisms this page's parent theory now endorses are in tension on the same timescale.
- **(brainstorm) It is measurable in a machine today and nobody reports it.** Any retrieval-augmented system whose encoder is fine-tuned after the index was built has exactly this failure — stored keys were computed under old parameters — and the standard remedy is a full re-index, which is precisely what a brain cannot do. The wiki has no mechanism for *pointer repair*; the two candidate shapes are re-encoding on read (validate the retrieved pattern against the current encoder and rewrite the key) and a slow-drift-tolerant address space, and neither has been stated as a design in any source here.

---

## Limitations

- **A commentary, not a result.** No new data; the plasticity split is a plausibility argument built from slice and in-vivo LTP studies, and no experiment ties either LTP form to an index specifically.
- **The specificity mechanism is borrowed and unmeasured.** The CA1→entorhinal learned return address is O'Reilly & Rudy's model; nothing here measures encoding-time potentiation of that projection.
- **No computational account.** The authors state plainly that indexing theory offers no account of *how* the subfields perform completion or separation, and defer to [[wiki/entities/rolls-treves-hippocampal-model.md]] and O'Reilly's line of models.
- **The hierarchical-indexing retraction rests on a scaling intuition** (human cortex grew, hippocampus did not) plus two rodent tracer studies — not on any measurement of what is addressed.
- **Content-free is asserted, not tested.** "The hippocampus has neither the computing power nor the functional organization" to hold content is an argument from anatomy; the wiki's own contrary evidence — place fields carrying vector-to-landmark structure, hippocampal populations becoming disentangled *and* expressive with learning — is not addressed (`T28` position A).

---

## Connections

- **[[wiki/concepts/complementary-learning-systems.md]]** — supplies the *reason* the two rates differ that CLS leaves open, and it is a different reason from the wiring-plasticity account on that page: an induction threshold set by cortical inhibition, with two calcium sources giving a labile fast write and a stable slow one, plus the consequence CLS has no slot for — that the fast store can also make its own trace permanent.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the operation this theory's retrieval step *is*: completion is the index reinstating a whole cortical pattern from a fragment, separation is the reason two overlapping episodes get distinct indexes, and the page's behavioural necessity table and this page's ledger cite the same CA3-NR1 and dentate-lesion experiments from opposite ends.
- **[[wiki/concepts/hierarchy-of-associativity.md]]** — the anatomical stack that makes hierarchical indexing possible and simultaneously breaks its addressing metaphor: the hippocampus reaches only the medial-temporal association cortices, and their return to neocortex is not cell-for-cell reciprocal, so reinstatement past entorhinal cortex is re-synthesis rather than addressing.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the theory implemented: hippocampal cells as conjunctions binding a cortical structural code to a cortical sensory code, which is step 2 of the four-step claim with the cortical patterns named.
- **[[wiki/entities/tem-transformer.md]]** — the theory in closed form, and the scaling result the theory needed: one index neuron can bind three or more cortical areas, so the cost of another modality is linear — the affordability claim the economy argument asserts without arithmetic.
- **[[wiki/entities/vector-hash.md]]** — the theory pushed to its limit: the hippocampal state is a content-free *hash*, not even a conjunction, and capacity, forgetting-resistance and sequence memory all survive — which removes the cost the content-free commitment was assumed to carry.
- **[[wiki/entities/temporal-context-model.md]]** — the same commitment expressed as one scalar: the hippocampus is a reinstatement operator on entorhinal state and stores nothing, with `α_N` setting how strongly a repeated item pulls back its context.
- **[[wiki/concepts/retrieval-mediated-learning.md]]** — where the ledger's strongest result lands: conditioning to the memory of a context shows a reinstated representation supporting *new* associative learning, i.e. the index read-out is a usable input rather than only an answer.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the two LTP forms as an entry in that page's substrate table: the same rule family separated by induction threshold and calcium source rather than by mechanism, which is where "labile" and "stable" become one parameter.
- **[[wiki/concepts/engram.md]]** — the rival reading of the same trace: the engram literature tags and reactivates hippocampal cells as *sufficient* for a memory, which an index is also predicted to be, so sufficiency does not discriminate content-bearing from content-free stores.
