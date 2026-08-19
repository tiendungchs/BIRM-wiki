# Memory Allocation by Intrinsic Excitability

**A second write variable, orthogonal to synaptic strength: a cell-wide, transcription-dependent, *transient* gain term that decides **which units** a memory is written into, while the synapses decide **what** is written. Its time constant — hours — makes temporal proximity, not input similarity, the allocation prior.**

> **Provenance.** Lisman, Cooper, Sehgal & Silva 2018, *Memory formation depends on both synapse-specific modifications of synaptic strength and cell-specific increases in excitability*, Nat Neurosci 21(3):309–314 (`raw/lisman-2018-synaptic-strength-excitability.md`). A perspective: one hypothesis (allocate-to-link) with direct support, one (assembly consolidation) explicitly untested.

[[wiki/concepts/synaptic-plasticity.md]] covers every rule the wiki has for changing a weight. This page covers the variable that is *not* a weight and is not indexed by a synapse at all — one scalar per cell, set by a transcription factor, decaying over hours — and the two functions that scalar is claimed to serve.

---

## The capacity paradox that motivates the page

| Variable | Information capacity per pyramidal cell | Persistence |
|---|---|---|
| Synaptic strength | > 10,000 independently modifiable synapses (LTP is synapse-specific) | Long-term; the presumed storage substrate |
| Intrinsic excitability | ~1 scalar (cell-wide) | **Hours**, then back to baseline |

A cell-wide term stores essentially nothing, and modelling has long shown LTP alone is *sufficient* for distributed storage. So the review's question is the right one for a builder: **what does a near-zero-capacity variable buy that a 10,000-dimensional one does not?** The answer is that it is not a storage variable — it is an **addressing/eligibility** variable. It never carries content; it biases which cells are recruited, and only while it is elevated. The authors are explicit that transcriptional change cannot be the long-term store precisely because it is transient.

**(brainstorm)** Stated for a machine store, this is a per-slot write-eligibility vector `e ∈ ℝ^N` that decays with a time constant far longer than an episode and multiplies the probability that a slot is chosen by the allocator — architecturally distinct from both the key (address) and the value (content), and absent from every memory-augmented network in the wiki, all of which allocate by similarity or by a usage/least-recently-used counter.

---

## The mechanism, and the causal chain

| Step | Evidence | Note |
|---|---|---|
| Learning / LTP induction phosphorylates CREB (cAMP-Responsive Element-Binding protein) for **hours** | Hippocampal LTP and learning both leave persistent phospho-CREB | The eligibility tag |
| CREB raises intrinsic excitability | CREB-overexpressing cells fire more action potentials to the same current pulse; **reduced spike-frequency adaptation**; smaller post-burst after-hyperpolarization (AHP) at 300 ms (not at the negative peak) | The AHP is K⁺-mediated, so the tag acts by **reducing K⁺ conductance** — the same mechanism found in invertebrate sensitization (*Aplysia*) and *Hermissenda* conditioning decades earlier |
| Excitability biases recruitment into the memory trace | CREB-overexpressing cells show higher immediate-early gene (IEG) expression than neighbours **in trained animals only** | Allocation, not a constitutive activity increase |
| Excitability is *sufficient* | Dominant-negative KCNQ2/KCNQ3 (blocking the AHP K⁺ channels) → preferential allocation, measured by Arc; Kir2.1 (inward-rectifying K⁺ channel, lowering excitability) → **~5× less likely to be active** and excluded from the trace; step-function opsin raising excitability of amygdala neurons *just before* tone conditioning → those neurons store the tone–shock association | Bidirectional, and the last row is behavioural |
| The allocated cells are *necessary* | Inhibiting CREB-overexpressing cells impairs recall | Rules out epiphenomenal tagging |

**Bidirectional CREB manipulation converges:** knockdown of α/δ isoforms, antisense oligodeoxynucleotides, RNA interference and targeted mutation all impair memory; raising active CREB enhances it.

**The tag is anti-homeostatic, and that is the interesting part.** Homeostatic intrinsic plasticity has strong activity *lowering* excitability. CREB-dependent excitability has strong activity *raising* it — positive feedback with no built-in brake, which is exactly the runaway-potentiation hazard [[wiki/concepts/synaptic-plasticity.md]] flags for rule 1. The review's proposed brake is not a homeostatic term but **saturation of synaptic strength**: LTP has a ceiling, so the loop terminates at the synapse rather than at the cell ([[wiki/empirical-tensions.md]] T68).

---

## The gate: an AND over dendritic plasticity and somatic firing

Why does CREB activation need two anatomically separate pathways?

```
dendrite:  LTP → CaMKII → synGAP/Ras → ERK (+Jacob) --diffuses--> soma → phospho-CREB
soma:      action potential → voltage-gated Ca²⁺ channel → CaM → nucleus → CaMKIV → phospho-CREB
```

The argument for two is a *selectivity* argument, and it is the sharpest thing on this page for gap G19:

- **A somatic spike is not evidence of learning** — it can be produced entirely by previously potentiated synapses.
- **A dendritic LTP event is not evidence either** — LTP can occur in one branch without a somatic sodium spike, and a cell should join an ensemble only if enough branches were driven that it actually fires.
- Therefore the cell should be tagged only when **both** hold. Two pathways with different origins, converging on one substrate, is a biochemical **AND** — "there was a learning event in my dendrites *and* it was strong enough to make me fire."

**(brainstorm)** This is a write-selectivity rule of a kind the wiki does not have: not a licensing signal delivered from outside (BTSP's entorhinal plateau, whose source is unknown) and not an error-gated write (sparse distributed memory's read-before-write), but a **conjunction of two internally available signals at different spatial scales** — local evidence of change × global evidence that the change mattered. Both are computable in any machine architecture with a two-compartment unit: `tag_j ← σ(‖Δw_j‖) · σ(a_j)`. It selects the *unit*, not the weight, so it composes with any of [[wiki/concepts/synaptic-plasticity.md]]'s rules rather than replacing one.

---

## Function 1 — allocate-to-link (supported)

**Claim:** memories encoded within the excitability window are written into **overlapping** populations, and that overlap *is* the linkage between them.

| Result | Finding |
|---|---|
| Miniature-microscope Ca²⁺ imaging, mouse CA1 (Cai et al. 2016 as reviewed) | Ensembles for two contexts explored **5 h apart** overlap far more than for contexts explored **7 d apart** |
| Transfer of fear | Shock in context C → freezing also in the linked context B (never paired with shock); an unlinked context D shows significantly less |
| Amygdala, two auditory fear memories acquired within 6 h | Share an ensemble; **silencing the shared cells abolishes the behavioural interaction between the two tasks while leaving retrieval of each intact** |

The last row is the load-bearing one: the shared subpopulation is a *separable* carrier of the relation, dissociable from the memories it relates.

**Window:** demonstrated ≥5 h, presumed up to ~1 day. Note this is 3–5 orders of magnitude longer than every plasticity window in [[wiki/concepts/synaptic-plasticity.md]] (STDP tens of ms, BTSP seconds) — it is the only mechanism in the wiki that binds events at the timescale at which *episodes* are separated.

### Why this matters for the core framing

[[wiki/concepts/latent-graph-discovery.md]] needs edges between things never observed in the same instant. Allocate-to-link supplies a mechanism whose edge criterion is **temporal proximity at encoding**, implemented with no comparison, no similarity metric and no retrieval:

| | Allocation by excitability | Standard associative write |
|---|---|---|
| What is compared | Nothing — the tag is already on the cell | Current input against stored patterns |
| Edge criterion | "encoded within `τ ≈ hours`" | "co-active now" or "similar to" |
| Cost of the link | Zero at link time; paid in advance by the tag | A retrieval and a comparison |
| Failure mode | Spurious linkage of coincidentally-proximal episodes | Spurious linkage of superficially-similar episodes |

**(brainstorm)** This is the *inverse* of pattern separation and deliberately so. [[wiki/concepts/pattern-separation-completion.md]] pushes overlapping inputs apart to prevent interference; allocate-to-link pulls non-overlapping inputs *together* to create relations. The two are not in conflict because they key on different axes — separation on input similarity, allocation on encoding time — and a store that does only the first can never represent "these two unrelated things happened in the same afternoon". A machine store therefore needs **two independent bias terms**, not one knob (G38 is about the wrong number of knobs as well as the wrong controller).

**(brainstorm)** It is also the mechanistic sibling of [[wiki/entities/temporal-context-model.md]]: TCM binds items to a slowly drifting context vector and reads contiguity off the overlap of contexts. Here there is no context vector — the "drift" *is* the decay of a per-cell tag, and the overlap is population overlap. TCM's `β` (drift rate) and the excitability decay constant are the same parameter measured two ways, which makes the free-recall contiguity curve and the 5 h / 7 d fear-transfer result predictions of one quantity. Nothing in the wiki tests that identification.

---

## Function 2 — assembly consolidation (proposed, untested)

**Claim:** the excitability tag persists into the post-learning rest period, so tagged cells participate more in sharp-wave ripples (SWRs), so *their* synapses get the repeated coactivation that consolidation requires — the ensemble stabilises itself.

```
tag (hours) → ↑ SWR participation → ↑ replay of this ensemble → ↑ synaptic consolidation of its internal edges
```

The premises are individually supported — SWRs replay recent experience, and disrupting SWRs causes strong memory deficits — but the middle link (excitability → SWR participation) is stated as *likely*, not shown. For [[wiki/concepts/offline-replay.md]] this is a candidate answer to that page's open arbitration problem: a **cheap, content-blind prior on what gets replayed**, requiring no evaluation of generalisability, no reward and no value-of-information computation. Replay priority ∝ excitability tag is one multiplication.

**(brainstorm)** If both functions are real, one variable does double duty in a way that is architecturally suspicious and worth exploiting: the same tag that decides *which cells encode next* also decides *which cells are rehearsed offline*, so temporally-linked memories are consolidated **together** as one assembly rather than as two episodes plus a relation. That is a concrete mechanism for gap G14's missing transport: what crosses into cortex is not the episode but the *cluster of episodes the tag glued together*, which is already a step of abstraction over the instance-graph.

---

## What it does *not* do

- **It is not storage.** Transient by construction; the review is emphatic that CREB-dependent transcription cannot mediate long-term memory, and that long-term storage remains synaptic (or possibly other, non-CREB transcriptional programs).
- **It has no content selectivity.** The tag says *this cell*, never *this pattern*. Two unrelated events encoded 3 h apart are linked exactly as strongly as two causally related ones — the mechanism cannot tell them apart, so it inherits [[wiki/concepts/shortcut-learning.md]]'s problem at the level of the episode.
- **It does not say how large the tagged population should be.** Allocation is competitive (relative CREB levels matter, not absolute), but nothing sets the fraction.

---

## Open problems

- **Excitability → SWR participation is unmeasured.** The whole assembly-consolidation hypothesis rests on it.
- **What terminates the window?** The decay constant of phospho-CREB is the *de facto* answer, and nothing says it is regulated by task demands — yet an agent should link events across an afternoon of one task and *not* across an afternoon of unrelated ones.
- **Positive feedback with an external brake.** If the only brake is synaptic saturation ([[wiki/empirical-tensions.md]] T68), then a store whose weights are unbounded — i.e. most machine implementations — reproduces the mechanism *without* its stabiliser.
- **Is the AND-gate real?** The two-pathway convergence is anatomically established; the claim that it computes a conjunction is the authors' interpretation, with no experiment dissociating "dendritic ERK alone" from "somatic Ca²⁺ alone".
- **No account of the population fraction.** Allocation is relative, so what fixes the size of an engram is unaddressed here (cf. the sparsity optimum `p = (2MT)^(−1/3)` in [[wiki/entities/sparse-distributed-memory.md]], which does fix it and *falls as the store fills*).

---

## Connections

- **[[wiki/concepts/synaptic-plasticity.md]]** — the complementary write variable: that page's rules set *what* is stored at a synapse, this one sets *which cells are eligible to store at all*, on a timescale (hours) three to five orders of magnitude longer than any window there, and by reducing K⁺ conductance rather than by changing a weight.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the opposing bias on a different axis: separation pushes similar inputs into disjoint codes, allocate-to-link pulls temporally proximal inputs into *overlapping* codes, so a fast store needs both a similarity knob and a recency knob rather than one transfer curve (G38).
- **[[wiki/concepts/offline-replay.md]]** — supplies a content-blind sampling prior for that page's seven-way arbitration: tagged cells are predicted to dominate SWR participation, making replay priority a decaying scalar rather than a computed value-of-information (untested link).
- **[[wiki/concepts/latent-graph-discovery.md]]** — an edge-writing mechanism whose criterion is *when* rather than *what*: two episodes encoded within the tag's lifetime share cells and are thereby related, with no comparison, no retrieval and no similarity metric.
- **[[wiki/entities/temporal-context-model.md]]** — the same contiguity phenomenon with the drifting context vector replaced by a decaying per-cell tag; TCM's `β` and the CREB decay constant are candidate measurements of one quantity, which would put free-recall contiguity and 5 h fear-transfer under one parameter **(brainstorm)**.
- **[[wiki/concepts/event-segmentation.md]]** — an implicit, purely temporal segmentation running underneath the predictive-encoding one: everything inside the excitability window is one linked unit regardless of whether the encoding set changed, so the two mechanisms can disagree about where an episode ends.
- **[[wiki/entities/context-modular-memory-network.md]]** — that model's `c`-fraction mask is the engineering form of what the tag does biologically: choose a subpopulation per context and let the rest sit inaccessible; here the subpopulation is chosen by a decaying excitability scalar rather than by a chosen mask density.
- **[[wiki/concepts/complementary-learning-systems.md]]** — adds a third timescale between the fast store and the slow cortex: an hours-long tag that groups episodes *before* consolidation, so what is transported may be a cluster rather than an episode (G14).
- **[[wiki/concepts/dendritic-computation.md]]** — supplies the spatial premise of the AND-gate: LTP in one branch without a somatic spike is a real state, which is what makes "dendritic plasticity" and "the cell fired" independent signals worth conjoining.
