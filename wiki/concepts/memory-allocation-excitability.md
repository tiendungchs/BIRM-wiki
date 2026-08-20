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

---

## The allocation prior has a top-down controller, and it is cortical

> **Provenance.** de Sousa, Zeidler, Almeida-Filho, Shen, Luchetti, Simanian, Mardini, DeNardo & Silva 2026, *The prefrontal cortex controls memory organization in the hippocampus*, Nat Neurosci (`raw/desousa-2026-prefrontal-controls-memory-organization.md`). Miniscope Ca²⁺ imaging + chemogenetics + projection-specific optogenetics in mice; same lab and same 5 h / 7 d paradigm as the Cai et al. result above, run in the other direction.

Everything above treats allocation as **local and content-blind**: a decaying per-cell scalar, no comparison, no similarity metric. This source keeps the tag but adds a second, *content-sensitive* term computed outside the hippocampus entirely — the ventromedial prefrontal cortex (vmPFC), acting through the medial entorhinal cortex (MEC), sets how much the second episode's ensemble is allowed to overlap the first's.

### The controller's input variables are exactly the two the tag cannot see

vmPFC population activity (Ca²⁺ event rate) during the *second* context exposure:

| Interval between episodes | Same context | Different contexts |
|---|---|---|
| **5 h** | ↓ activity | ↓ activity |
| **7 d** | ↓ activity | **↑ activity** |

One cell in the 2×2 is different, and it is the one where the memories *should* be kept apart: distinct contexts, far apart in time. So the controller is high exactly when separation is required, and it computes that from **contextual similarity × elapsed time** — the second of which the excitability tag encodes implicitly (by having decayed) and the first of which it cannot represent at all. Unlike dCA1, vmPFC ensemble overlap for the *same* context does not differ between 5 h and 7 d: the cortical representation is drift-resistant, which is what makes it usable as a reference against which similarity is judged.

### Causal, bidirectional, and it moves the same number in both directions

| Manipulation (during encoding of context B, 7 d after A) | dCA1 ensemble overlap | Behaviour |
|---|---|---|
| Control, different contexts | ~15% | No linking (freezing in A low) |
| Control, same context | ~25% | Linking |
| **Inhibit vmPFC** (chemogenetic, pan-neuronal or excitatory-specific), different contexts | ↑ to ~25% | **Linking appears** — freezing in A rises to context-B levels, novel context C unaffected (not generalization) |
| **Inhibit vmPFC→MEC projections only** (intersectional; or eOPN3 terminal inhibition) | ↑ to ~25% | Reproduces the full vmPFC effect |
| **Activate vmPFC→MEC terminals** (ChrimsonR), *same* context | ↓ 24% → 12% | Separation forced where integration is the default; also lowers overlap at the 5 h interval, overriding local hippocampal integration |
| Inhibit vmPFC→dHPC projections | — | Impairs encoding of B itself (not an organization effect) |
| Inhibit vmPFC→LEC projections | — | Freezing rises in A *and* in novel C — genuine generalization, a different failure |

Number of active dCA1 cells is unchanged throughout, so the manipulation moves *which* cells, not *how many* — the definition of an allocation effect rather than an excitability-level effect. A c-Fos/TRAP2 replication gives the same result and localises it: overlap rises in **dCA1 only**, with dCA3 and dorsal dentate gyrus unchanged.

### It overrides the pre-learning-excitability prior

The sharpest result for this page. Composition of the top 10% most-active dCA1 neurons during context B (7 d after A):

| Source of those neurons | Control (different contexts) | vmPFC→MEC inhibited | Control, same context |
|---|---|---|---|
| Also top-10% in **context A** (7 d earlier) | 15% | **27%** | ≈ inhibited profile |
| Also top-10% in the **home cage immediately before** | 24% | **18%** | — |
| Both | 16% | — | — |
| Unique to B | 45% | 38% | — |

Under the excitability account, the home-cage-active cells are the ones carrying a fresh tag and they should win the competition. Inhibiting the top-down projection *demotes* them and promotes cells tagged 7 days earlier — a population whose CREB tag has long since decayed. Allocation is therefore not a winner-take-all over current excitability; it is that competition **plus a top-down bias whose argument is the content of prior memories** ([[wiki/empirical-tensions.md]] T83). Note the asymmetry: activating the projection *also* reduced the home-cage fraction (19% → 8%), so inhibition and activation are not clean opposites of one variable.

### The circuit, and where the gate physically sits

```
vmPFC (deep layers, excitatory, GAD67-negative)
   └─▶ MEC layers V (48%) / II (25%) / III (23%)  [neurons that themselves project to dCA1]
          └─▶ stratum lacunosum moleculare of dCA1
                 └─▶ NDNF⁺ neurogliaform (NGF) interneurons
                        └─┤ gate on temporoammonic (EC→CA1) vs CA3 input to CA1 pyramids
```

| Link | Evidence |
|---|---|
| vmPFC→MEC inhibition ⇒ ↓ MEC c-Fos | Direct count |
| ⇒ ↓ GAD67⁺/c-Fos⁺ cells in **SLM only** (not stratum oriens or radiatum); ↓ NDNF⁺/c-Fos⁺ by RNAscope | Layer- and marker-specific; SOM⁺, PV⁺, VIP⁺ populations across dCA1 all unchanged |
| MEC activity ↔ SLM inhibitory activity | Positively correlated in controls; optogenetic MEC stimulation raises SLM c-Fos; inhibiting MEC→HPC neurons lowers SLM GAD67⁺/c-Fos⁺ |
| NGF cells are *naturally* modulated by the same variable | Fewer NDNF⁺/c-Fos⁺ cells when the two contexts are the *same* (integration) than when different (separation) |
| NGF cells are causally sufficient for the effect | Chemogenetic inhibition of NDNF⁺ SLM cells alone reproduces it: ↑ dCA1 overlap, ↑ Ca²⁺ event rate |

So the actuator is one inhibitory cell type in one layer, and the controller is a cortical region three synapses upstream — the first place in the wiki where an allocation/separation knob has *both* ends identified ([[wiki/concepts/inhibitory-control-of-coding.md]], gap G38).

### The controller comes online only after consolidation

vmPFC inhibition does nothing at the 5 h interval — not to overlap, not to behaviour, and not to retrieval of an already-linked pair. It changes everything at 7 d. The authors' reading, and the one this wiki should carry: **a cortical trace must first mature through systems consolidation before cortex can arbitrate what the hippocampus writes next** ([[wiki/concepts/complementary-learning-systems.md]], [[wiki/concepts/generalization-optimized-consolidation.md]]). Within the tag's own lifetime, allocation is left to the local, content-blind mechanism.

Specificity limits worth carrying: the effect appears only when the two episodes share features. vmPFC inhibition did **not** raise overlap between a context and the home cage, nor between a context and a different hippocampus-dependent task (social transmission of food preference) encoded 7 d apart. The controller adjudicates *near*-misses, which is precisely the regime where a similarity threshold is hard to set.

**(brainstorm) The machine reading.** The write-eligibility vector `e ∈ ℝ^N` above becomes `e ← e_local ⊙ σ(−β·g(x_t, S))`, where `S` is the slow learner's consolidated content and `g` a similarity between the current episode and it. Three properties are worth copying and none is present in any memory-augmented model in the wiki: (i) the gate is computed by the **slow** store and applied to the **fast** store's allocator, which is the reverse of every replay/consolidation channel the wiki holds — information flows cortex→hippocampus at *encoding* time; (ii) it is a **multiplicative bias on the allocator, not on the content**, so it changes the geometry of what is written without touching what is encoded (single-memory encoding, exploration and social behaviour were all unaffected); (iii) it is **inhibitory-mediated and weight-free**, so the same store can be pushed to either end of the overlap axis within one episode and back again.

**(brainstorm)** This also supplies the missing brake on Function 1's failure mode. Allocate-to-link "cannot tell apart" two unrelated events encoded 3 h apart from two causally related ones — stated below as a hard limit. The limit is real *inside* the tag window and false outside it: past ~a day, a content-sensitive cortical term takes over and the temporal prior is overruled by similarity. The two mechanisms therefore partition the time axis rather than competing, which is a cheap architecture: cheap-and-blind at short lag, expensive-and-informed at long lag.

## What it does *not* do

- **It is not storage.** Transient by construction; the review is emphatic that CREB-dependent transcription cannot mediate long-term memory, and that long-term storage remains synaptic (or possibly other, non-CREB transcriptional programs).
- **It has no content selectivity.** The tag says *this cell*, never *this pattern*. Two unrelated events encoded 3 h apart are linked exactly as strongly as two causally related ones — the mechanism cannot tell them apart, so it inherits [[wiki/concepts/shortcut-learning.md]]'s problem at the level of the episode. **Content selectivity is supplied from outside, and late**: the vmPFC→MEC→NGF gate is content- and similarity-sensitive but is only load-bearing at the 7 d interval, so inside the tag window the blindness stands (de Sousa et al. 2026).
- **It does not say how large the tagged population should be.** Allocation is competitive (relative CREB levels matter, not absolute), but nothing sets the fraction.

---

## Open problems

- **Excitability → SWR participation is unmeasured.** The whole assembly-consolidation hypothesis rests on it.
- **What terminates the window?** ~~The decay constant of phospho-CREB is the *de facto* answer~~ — **partly answered from outside the cell**: the window is not terminated, it is *overruled*. Past ~a day a cortical controller with access to contextual similarity sets the overlap directly, in either direction, and can force separation even at 5 h (de Sousa et al. 2026). What remains open is the within-window case the original problem named — an afternoon of one task versus an afternoon of unrelated ones — where the controller is demonstrably not engaged.
- **What sets the controller's own gain?** vmPFC activity tracks similarity × lag, but nothing measures the *function*: what similarity metric, over what representation, with what threshold. The regress has moved from the hippocampus to cortex rather than closing (same limit as [[wiki/concepts/inhibitory-control-of-coding.md]] one level down).
- **Positive feedback with an external brake.** If the only brake is synaptic saturation ([[wiki/empirical-tensions.md]] T68), then a store whose weights are unbounded — i.e. most machine implementations — reproduces the mechanism *without* its stabiliser.
- **Is the AND-gate real?** The two-pathway convergence is anatomically established; the claim that it computes a conjunction is the authors' interpretation, with no experiment dissociating "dendritic ERK alone" from "somatic Ca²⁺ alone".
- **No account of the population fraction.** Allocation is relative, so what fixes the size of an engram is unaddressed here (cf. the sparsity optimum `p = (2MT)^(−1/3)` in [[wiki/entities/sparse-distributed-memory.md]], which does fix it and *falls as the store fills*).

---

## Connections

- **[[wiki/concepts/synaptic-plasticity.md]]** — the complementary write variable: that page's rules set *what* is stored at a synapse, this one sets *which cells are eligible to store at all*, on a timescale (hours) three to five orders of magnitude longer than any window there, and by reducing K⁺ conductance rather than by changing a weight.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — supplies the actuator this page's top-down controller acts through, and receives from it the controller that page was missing: NDNF⁺ neurogliaform (*Id2*-family) interneurons in the stratum lacunosum moleculare are the single cell type whose inhibition reproduces the whole allocation effect, and vmPFC→MEC input is what drives them (de Sousa et al. 2026).
- **[[wiki/concepts/pattern-separation-completion.md]]** — the opposing bias on a different axis: separation pushes similar inputs into disjoint codes, allocate-to-link pulls temporally proximal inputs into *overlapping* codes, so a fast store needs both a similarity knob and a recency knob rather than one transfer curve (G38).
- **[[wiki/concepts/offline-replay.md]]** — supplies a content-blind sampling prior for that page's seven-way arbitration: tagged cells are predicted to dominate SWR participation, making replay priority a decaying scalar rather than a computed value-of-information (untested link).
- **[[wiki/concepts/latent-graph-discovery.md]]** — an edge-writing mechanism whose criterion is *when* rather than *what*: two episodes encoded within the tag's lifetime share cells and are thereby related, with no comparison, no retrieval and no similarity metric.
- **[[wiki/entities/temporal-context-model.md]]** — the same contiguity phenomenon with the drifting context vector replaced by a decaying per-cell tag; TCM's `β` and the CREB decay constant are candidate measurements of one quantity, which would put free-recall contiguity and 5 h fear-transfer under one parameter **(brainstorm)**.
- **[[wiki/concepts/event-segmentation.md]]** — an implicit, purely temporal segmentation running underneath the predictive-encoding one: everything inside the excitability window is one linked unit regardless of whether the encoding set changed, so the two mechanisms can disagree about where an episode ends.
- **[[wiki/entities/context-modular-memory-network.md]]** — that model's `c`-fraction mask is the engineering form of what the tag does biologically: choose a subpopulation per context and let the rest sit inaccessible; here the subpopulation is chosen by a decaying excitability scalar rather than by a chosen mask density.
- **[[wiki/concepts/complementary-learning-systems.md]]** — adds a third timescale between the fast store and the slow cortex: an hours-long tag that groups episodes *before* consolidation, so what is transported may be a cluster rather than an episode (G14). It also adds a channel running the *other* way: the consolidated cortical trace gates which hippocampal cells the next episode is written into, and only once that trace has matured (7 d yes, 5 h no), so cortex→hippocampus traffic exists at encoding time and not only at retrieval (de Sousa et al. 2026).
- **[[wiki/concepts/dendritic-computation.md]]** — supplies the spatial premise of the AND-gate: LTP in one branch without a somatic spike is a real state, which is what makes "dendritic plasticity" and "the cell fired" independent signals worth conjoining.
- **[[wiki/concepts/recall-gated-consolidation.md]]** — the rival consolidation criterion, and cleanly separable from this one: an excitability tag is set at *encoding*, is content-blind and groups episodes by temporal proximity, while the recall gate is evaluated at *every recurrence* and is content-specific. The tag decides which episodes share an assembly; the gate decides which assembly earns a long-term write.
- **[[wiki/entities/btsp-cam.md]]** — the same architectural move — *which* neurons a memory is written into decided by a variable that is neither a weight nor the input — at a different timescale and with the opposite statistics: a seconds-long dendritic plateau arriving input-independently at rate `f_q ≈ 0.005`, which spreads memory load **uniformly** where this page's hours-long excitability tag deliberately clusters it on recently-active cells.
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — supplies the reason the top-down controller can only be a *late* mechanism: it needs a cortical trace that transport has already built, which is why the vmPFC gate is load-bearing at 7 d and inert at 5 h, and it makes the amount of consolidation a determinant of how well new memories are organized rather than only of how well old ones are retained.
