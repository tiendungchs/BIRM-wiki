# BB-Model — the Egocentric↔Allocentric Transform, Implemented

**A rate-coded, multi-region systems model in which egocentric parietal scene representations and allocentric medial-temporal ones are connected by a bidirectional gain-field bank in retrosplenial cortex, parameterised by a head-direction ring attractor. Perception runs the bank one way and self-localises; imagery runs the *same weights* the other way and reconstructs a viewpoint. Recall, scene construction, novelty detection, trace cells, mental navigation, shortcut planning and two classic amnesias fall out of that one interface plus a place-cell attractor and a grid module. It is the wiki's first implemented answer to `G39`'s anchoring operation — and, by construction, has no answer to `G43` at all.**

> **Provenance.** Bicanski & Burgess 2018, *A neural-level model of spatial memory and imagery*, eLife 7:e33752 (`raw/bicanski-2018-neural-level-model-of-spatial-memory-and-imagery.md`). Extends the Byrne–Becker–Burgess model of imagery in *empty* environments (Burgess et al. 2001a; Byrne et al. 2007) by adding objects, grid cells and planning. MATLAB source released. "BB-model" is the authors' own label.

---

## Architecture

Nine populations, three of them on the interface rather than in either store.

| Population | Frame | Assigned region | Codes | Size / note |
|---|---|---|---|---|
| **PWb** (parietal-window boundary) | Egocentric, head-centred | Medial parietal cortex / precuneus — "the parietal window" | Extended boundaries in peri-personal space (ahead / left / right), receptive fields rotating with the agent | Predicted by the model's predecessor; egocentric boundary cells subsequently reported (Hinman et al. 2017) |
| **PWo** (parietal-window object) | Egocentric | Same | Discrete objects in peri-personal space | **Predicted, novel** |
| **TR** (transformation circuit) | Conjunctive | Retrosplenial cortex | Head-direction-modulated boundary/object vector cells — 20 sublayers, each a full copy of the allocentric population tuned to one heading | **Predicted, novel**; 18° heading resolution |
| **HDC** | Allocentric heading | Papez circuit — lateral mammillary nucleus, anterodorsal thalamus, retrosplenial, subicular complex, medial entorhinal | Current heading; ring attractor updated by angular velocity | 100 cells; the model's most fragile population |
| **BVC** (boundary vector) | Allocentric | Subicular complex / parahippocampal | Boundary at (distance, allocentric bearing) — identity-blind | Predicted by Hartley et al. 2000, found by Lever et al. 2009 |
| **OVC** (object vector) | Allocentric | Hippocampus or one synapse out (lateral/medial entorhinal, parahippocampal) | Object at (distance, allocentric bearing) — identity-blind | **Predicted**; OVC-like cells reported by Deshmukh & Knierim 2013 and Høydal et al. 2017 |
| **PRb / PRo** (perirhinal) | Frameless | Perirhinal cortex, apex of the ventral visual stream | *Identity* of a boundary / object, irrespective of location | Driven by an unmodelled recognition process |
| **PC** (place) | Allocentric | Hippocampus | Position; **binds** every other population into one scene | 44×44 sheet; recurrent attractor |
| **GC** (grid) | Allocentric, modular | Medial entorhinal | Self-motion; translates the place bump | 7 modules × 100 cells, scale ratio `√2`; implemented as pre-computed cosine rate maps, not dynamics |

**Signal flow.**

```
perception :  sensory → PWb/PWo → TR → BVC/OVC → PC ⇄ PRb/PRo      (self-localisation from sensory input alone)
imagery    :  cue → PRo → PC → {BVC, OVC, PRb} → TR → PWb/PWo       (recall = rendering a viewpoint)
navigation :  mock motor efference → GC → PC → BVC → TR → PWb       (mental movement)
```

The two directions use the **same** weight matrices. Mode is a pair of scalar gains: the inactive direction is scaled to **5%** of maximum, and a single "bleed" parameter `B` slides between them continuously. The operation itself is on [[wiki/concepts/reference-frame-transformation.md]].

**Learning.** Two regimes, and the split matters. The boundary context (PC–PC, PC–BVC, PC–PRb) and the whole transformation circuit are wired in a **supervised setup phase** — 400,000 randomly oriented boundary-segment presentations for the bank, declared developmental and never revisited. Objects are learned **on the fly**: on approach within 55 cm ("salience"), Hebbian outer products bind PRo ⇄ {PC, HDC, OVC} and OVC ⇄ PC. Weights are normalised to unit sum per target neuron (homeostatic scaling) and scaled by per-pathway gains.

**Attention is load-bearing and unmodelled.** Binding object identity to object location requires that exactly *one* (PRo, PWo/OVC) pair be maximally co-active. With two objects in view the conjunction is ambiguous, so the model serialises: a fixed 600 ms attentional cycle is divided by the number of visible objects and each is driven in turn. This makes the binding capacity limit a **consequence** of the encoding scheme rather than a stipulation — too many objects and no one conjunction accumulates enough activity to write.

---

## What it reproduces, and what it predicts

| Simulation | Result |
|---|---|
| **Object-cued recall** | Injecting current into one PRo cell recovers the full scene: PC → pattern completion → BVC/PRb, and PRo→HDC reinstates the *encoding heading* so the bank renders the encoding viewpoint. Population-vector correlation recall-vs-encoding ≈ 1 for OVC and PC; lower for BVC (recall reactivates 360° against a 180° field of view at encoding) and lowest for the parietal window — **imagery is measurably blurrier than perception, and the blur is introduced by the transform** |
| **Papez-circuit lesion** (HD → TR set to zero) | *Anterograde*: perceived objects cannot reach the medial temporal lobe, so nothing new is encoded. *Retrograde*: stored scenes still activate via PRo → PC, but no coherent viewpoint can be instantiated, so recollection fails while **perirhinal recognition is spared**. Reproduces the recollection/familiarity dissociation of fornix and mammillary lesions (Tsivilis et al. 2008) from a single deleted parameter |
| **Hippocampal lesion** | Moved-object novelty signal collapses: residual OVC–PRo activity survives but is not location-specific, so the mismatch is equal for both objects. Residual case — if the agent happens to stand at the same distance and bearing as at encoding, perceptual and recalled OVC activity match, which is the amnesic ability to detect a familiar arrangement **only from the encoding viewpoint** (King et al. 2002) |
| **Damage tolerance** | 20% random cell deletion and 20% firing-rate noise both leave recall correlations near intact, *provided* the PC and HD attractor states stay stable. Parietal-window deletion degrades imagery **only in the peri-personal sector the missing cells coded** — representational neglect as a local, not global, failure |
| **Trace cells** | Periodic theta-rate switching of the mode scalar makes BVCs/OVCs fire for a *removed* boundary or object, and — the sharper result — makes a nominally **non-spatial perirhinal identity cell acquire a spatial firing field** at the encoding location. Offers a reconciliation of "lateral entorhinal cortex is non-spatial" with Tsao et al. 2013's spatially selective trace cells |
| **Mental navigation** | Mock motor efference drives GC → shifts the PC bump → pattern completion updates BVC → the bank renders a *flowing* egocentric scene. The agent passes an object from a novel direction and the bank correctly places it on the **right** where it was encoded on the left — an imagined representation never perceived |
| **Planning and shortcutting** | Unvisited territory has no PC–BVC weights, so a pool of **"reservoir" cells** with sparse random grid input (3%) and sparse recurrence (6%) fires in sequence as the grid sweep crosses the gap — preplay-like. After the barrier is removed and the route actually traversed, Hebbian BVC binding converts the reservoir cells into place cells firing **in the same order** |

**New cell types predicted:** egocentric object cells (PWo), head-direction-modulated boundary *and* object vector cells (the bank's sublayers), and allocentric object vector cells — the last since observed.

---

## The architectural reading

**(brainstorm) This is `G39`'s anchoring operator, built, and it does not search.** `G39` assembled the shape — a small per-instance transform against a large reusable code, an `argmax` over a symmetry group, needing both an installed group and a population enumerating its elements. Here all three are present and the `argmax` is **deleted**. The group is installed (planar rotation), the enumerating population is the 20 sublayers, and selection is one global interneuron thresholding *total* head-direction activity so that blanket inhibition is overcome in exactly the sublayer whose tuning matches the bump. There is no scoring, no fit, no posterior. Anchoring is a **disinhibition gate over a bank of pre-wired conditional maps**, and the parameter is computed elsewhere. Compare [[wiki/entities/gcq.md]], where the same operation is a batch least-squares fit over `K` codewords: same group, same bank, and the entire difference is whether the element is inferred from the content or delivered by an integrator that never sees the content.

**(brainstorm) The model that most explicitly holds two frames at once has no arbitration — and that is a result, not an omission.** `G43` asks how concurrent reference frames are reconciled. This architecture holds an egocentric and an allocentric code simultaneously, converts between them continuously, and **cannot represent their disagreement**: there is one head-direction bump, one gate, one selected sublayer. Conflict is architecturally denied. The cost is visible in the model's own boundary: it simulates only *familiar* environments with a heading it trusts, and the review literature's cue-conflict lesion signature — near-normal until intra- and extra-maze cues disagree ([[wiki/entities/retrosplenial-cortex.md]]) — is precisely the regime this implementation does not enter. **The transferable statement: a single-parameter transform is an arbitration-free design, and its failure mode is not error but undefined behaviour when the parameter population holds two bumps.**

**(brainstorm) `G110`'s arrangement, implemented, on the machine side.** `G110` asks for a controller whose only write lands on the *interface* rather than on a module or its output. That is exactly the mode scalar: neuromodulation scales the transformation circuit's afferent and efferent gains, and touches neither the store nor the parietal representation. Three properties the arrangement buys that a gain on a module would not. It is **symmetric** — one knob sets which of two stores drives the other, so encode/retrieve is a single parameter rather than two control paths. It is **graded** — the `B` parameter gives partial top-down during perception, which is what produces trace cells and memory-guided attention. And it is **content-blind** — the controller cannot select *what* is converted, only *how strongly and which way*, which is a much smaller control surface than the query-conditioning and output-filtering the wiki's machine constructs use.

**(brainstorm) Coherence is enforced by the interface, not by a loss term.** The discussion's sharpest point: an enormous number of combinations could be retrieved from a long-term store, but only a small subset is consistent with **one point of view**. Forcing retrieval through a transform parameterised by a single heading is therefore a hard constraint that the reconstruction be self-consistent — and it is free, because it is the wiring. For [[wiki/concepts/latent-graph-discovery.md]] this is a candidate general principle: **validate a retrieved subgraph by requiring it be renderable from a single origin**, and get the filter from the rendering interface rather than from a scoring function. The open question is what "single origin" means for a non-spatial structure, which is `G39`'s standing residue.

**Novelty detection is a difference taken in the actionable frame.** Running both directions at once and differencing gives a mismatch signal in the **egocentric** window, so it carries a location in peri-personal space and can be handed straight to attention. A mismatch computed inside the allocentric store would report *that* something changed and not *where to look*. Cheap, and the wiki's clearest case of a monitoring signal whose usefulness depends on which frame it is computed in ([[wiki/concepts/violation-of-expectation.md]], [[wiki/concepts/priority-map.md]]).

**The generator is the encoder read backwards.** No separate decoder is trained. The medial temporal store plus the bank *is* a generative model over scene populations, with the mode scalar as a precision term. Machine practice — encoder and decoder as separate parameter sets — is the assumption this model declines to make, and the price is visible: imagery is systematically blurrier than perception because the same matrices are lossy in the reverse direction.

**Preplay from uncommitted capacity is an allocation mechanism, and it is nearly free.** Reservoir cells are unwired place cells with sparse random grid input and mutual inhibition against the committed population. A grid sweep across unexplored space drives a *reproducible* subset of them in sequence — reproducible because it is determined by the fixed random GC→PC projection — and actual traversal then binds them to sensory input. This is a concrete answer to "where do new place cells come from": **a random projection makes the assignment before experience, and experience only supplies the bindings** ([[wiki/concepts/memory-allocation-excitability.md]], [[wiki/concepts/random-feedback-addressing.md]]).

**And it is the model form of `T383` Position A.** The localised-converter hypothesis is not a sketch here — it is code with a downstream entailment: silence the transformation circuit and boundary-anchored medial-temporal responses should fail to be instantiated. Alexander et al. 2023 report that retrosplenial inactivation leaves boundary-anchored entorhinal responses largely intact. The wiki therefore holds this model as **the sharpest available statement of the hypothesis and not as evidence for it** — its value is that it makes Position A falsifiable, which the review-level version was not.

---

## Comparison

| | BB-model | [[wiki/entities/tolman-eichenbaum-machine.md]] | [[wiki/entities/thousand-brains-theory.md]] | [[wiki/entities/gcq.md]] |
|---|---|---|---|---|
| Frames held | 2 (ego, allo) + heading | 1 (`g`), rebound per world | thousands, object-anchored | 1 (torus) |
| Conversion between frames | Explicit, banked, bidirectional | None needed — one frame | Asserted (voting); no rule | None |
| Transform parameter | External integrator (head direction) | n/a | Unspecified | Inferred by batch least squares |
| Anchoring | Disinhibition gate, no search | Retrieve-and-correct loop | Lateral voting to consensus | One-shot fit over `K` codewords |
| Learning | Bank supervised & frozen; objects Hebbian online | End-to-end on next-observation prediction | Hebbian per column | End-to-end |
| Arbitration when frames disagree | **Impossible by construction** | n/a | The unspecified core | n/a |
| Generation | Encoder run backwards | Sampled from the generative model | n/a | Rollout |

---

## Limitations

- **The bank is not learned.** 400,000 supervised boundary-segment presentations set the transformation circuit up, and the authors assign this to development without proposing a developmental rule. Nothing in the model discovers `K`, discovers each sublayer's tuning, or keeps the two directions mutually consistent.
- **`K = 20` is a parameter, not a derivation.** Heading resolution is 18° by fiat; behaviour between grid points is unaddressed.
- **Boundaries are hard-coded**; every simulation is a *familiar* environment. Remapping between environments is discussed and not simulated, so the model has never been asked to choose a map.
- **Grid cells are lookup tables.** Rate maps are pre-computed from superimposed cosines and sampled by position; there are no grid dynamics, so the model cannot speak to how the sweep is generated or steered.
- **Rate-coded throughout.** Replay, preplay and forward sweeps occur in the model at behavioural speed; the compressed timescales that define them experimentally (sharp-wave ripples, theta sequences) are out of reach and the authors say so. What the model reproduces is the *sequence*, not the phenomenon ([[wiki/concepts/offline-replay.md]]).
- **Four control signals are supplied from outside the model**: the encode/retrieve mode scalar, the recall cue current `I_cue`, the attentional cycle, and perirhinal identity (a ventral-stream recognition process explicitly not modelled). Everything the model would need an agent for, it is handed.
- **Attention's capacity limit is a consequence of an unmodelled mechanism.** The 600 ms cycle is stipulated; the prediction that too many objects break binding is real but rests on a timing constant with no derivation.
- **Single point of failure.** Damage tolerance holds *only* while the place-cell and head-direction attractors remain stable; the HD population is 100 cells and was excluded from the lesion study for being too small to lesion meaningfully.
- **Scope is coherent spatial scenes in familiar space.** No semantic memory, no fictional scenes or novel configurations, no non-spatial content — the authors state that scene construction and episodic future thinking extend past the model in exactly the direction the wiki needs.
- **The model's one downstream entailment is contradicted** by the retrosplenial inactivation result (`T383`), and "transformation" still has no operational criterion separating it from co-representation of the two codes.

---

## Connections

- **[[wiki/concepts/reference-frame-transformation.md]]** — the operation this model implements, abstracted from it: the twenty-sublayer gain-field bank, the one-hot disinhibition gate, the externally supplied parameter and the single weight set read in both directions.
- **[[wiki/entities/retrosplenial-cortex.md]]** — the region the transformation circuit is assigned to, and the reason the assignment is contested: this model is the executable form of that page's translation account, so it inherits `T383` entire and supplies the downstream prediction the 2023 review reports as null.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the rival arrangement, priced: this model pays `K × |population|` for *one* bank at *one* site, whereas a frame in every cortical area needs a bank and a parameter feed per area — so the localised/distributed choice is a concrete unit-count difference rather than a matter of taste.
- **[[wiki/concepts/vector-coding.md]]** — the allocentric code on the store side of the interface, and the model that predicted it: object-vector cells were introduced here as a parsimonious analogue of boundary-vector cells reusing the same bank, and were subsequently measured.
- **[[wiki/concepts/cognitive-map.md]]** — the orientation half of that page's retrieval/orientation split made mechanical: place cells deliver *which* structure, the bank plus one heading delivers *where on it the agent stands*, and the second is a gated lookup rather than an inference.
- **[[wiki/concepts/path-integration.md]]** — supplies the transform parameter and, separately, the mental-navigation drive: the model's claim is that imagined movement and path integration are **the same grid-to-place mechanism** run with and without sensory input, so the two are not analogous but identical.
- **[[wiki/concepts/attractor-dynamics.md]]** — the model's load-bearing assumption and its single point of failure: pattern completion across place, boundary and perirhinal populations is what turns a cue into a whole scene, and 20% cell loss is survivable exactly while the attractor states are.
- **[[wiki/concepts/encoding-retrieval-alternation.md]]** — the temporal schedule of the mode scalar, with a concrete target: theta here is not a gate between two processes but a periodic *comparison*, and the intermediate "bleed" setting is what generates trace fields and memory-guided attention.
- **[[wiki/concepts/offline-replay.md]]** — the preplay case and its caveat: a grid sweep over uncommitted reservoir cells produces the pre-traversal sequence that is later recapitulated, but at behavioural speed, so the model supplies a candidate *origin* for preplay sequences and nothing about the ripple timescale that defines them.
- **[[wiki/concepts/simulation-based-planning.md]]** — a rollout whose state is a rendered scene rather than a latent vector: planning here is mental navigation with the viewpoint reconstructed at every step, which makes the plan inspectable in the same format as perception and bounds it to space the store can render.
- **[[wiki/concepts/violation-of-expectation.md]]** — novelty as a difference between the two directions of one interface, taken in the egocentric frame so that it carries a location; the hippocampal lesion simulation shows what is left when the allocentric reference is removed and the mismatch loses its *where*.
- **[[wiki/concepts/pattern-separation-completion.md]]** — completion is doing the retrieval work here: a single perirhinal identity cue recovers a full multi-population scene, and the model's amnesia simulations are entirely about which populations remain reachable once one input is cut.
- **[[wiki/concepts/hippocampal-indexing-theory.md]]** — indexing in explicit form: place cells hold no scene content, they bind the boundary, object and identity populations that do, and the model's object encoding is literally the writing of an index entry.
- **[[wiki/entities/entorhinal-cortex.md]]** — the assigned locus of the grid module and a candidate locus for object-vector cells, and the site of the model's failed entailment: boundary-anchored medial entorhinal responses should degrade when the transformation circuit is silenced, and largely do not (`T383`).
- **[[wiki/entities/anterior-thalamic-nuclei.md]]** — the parameter source, and the reason the Papez lesion simulation is the model's cleanest dissociation: deleting the heading input leaves both stores intact and destroys only the conversion, which is the factorised signature a global gain could not produce.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the same `g`/`x` factorisation reached from the opposite direction: TEM *learns* one structural code end-to-end from prediction and never converts between frames, while this model *wires* the code and spends its whole architecture on the conversion — so the pair brackets how much of a spatial system can be derived versus installed.
- **[[wiki/concepts/memory-allocation-excitability.md]]** — the reservoir-cell result as an allocation rule: a fixed sparse random grid projection decides *which* uncommitted cells will represent unvisited space before it is visited, so allocation precedes experience and experience only supplies the bindings.
- **[[wiki/concepts/working-memory.md]]** — the model's stated hole: egocentric scene representations persist only while driven, so anything held across a gap has to be maintained by a mechanism the model names and does not include.
- **[[wiki/entities/posterior-cingulate-cortex.md]]** — the demarcation problem under the model's egocentric pole: the "parietal window" is assigned to medial parietal cortex/precuneus, which that page shows is not cingulate cortex and is the one region retrosplenial cortex does *not* connect to — so the model's core edge, transform → egocentric window, crosses a boundary whose anatomy it does not address.
