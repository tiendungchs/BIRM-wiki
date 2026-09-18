# Canonical Cortical Microcircuit

**The same laminar wiring diagram — thalamus → L4 → L2/3 → L5 → L6 → L4, with feedforward output from L2/3 and feedback from L5/6 — is found wherever it has been looked for, across areas with utterly different functions and across species separated by 135 million years. If cortex runs one algorithm, this graph is its pseudocode, and the algorithm it suggests is *explore interpretations in the superficial layers, commit to one in the deep layers*.**

Every "cortical column" claim the wiki leans on — columns as reference-frame units voting on object identity ([[wiki/concepts/distributed-reference-frames.md]]), the uniformity argument that licenses importing a hippocampal or visual mechanism into a general architecture ([[wiki/concepts/inhibitory-control-of-coding.md]]) — presupposes that there *is* a canonical circuit. This page holds the anatomy those claims cash out to, and the numbers. It also holds the **variations** half: the same circuit re-described by genetically defined cell class rather than by layer (Harris & Shepherd 2015), under which cortical areas are *serially homologous* — one topology whose per-area scalars can invert the sign of its response to the same top-down command, so uniformity buys the wiring and not the computation (`T371`).

> **Provenance.** `raw/douglas-2004-neocortical-circuits.md` — Douglas & Martin, *Annu. Rev. Neurosci.* 27:419–51, 2004. A review, not a new result: it aggregates intracellular-HRP reconstructions, tracer injections, immunochemistry and photostimulation across cat, ferret, rat, tree shrew, macaque and human. The functional model in its last section is explicitly labelled by the authors as "a tentative hypothesis".

---

## The canonical excitatory graph

Spiny (glutamatergic) neurons supply nearly all interlaminar and long-range excitation; smooth (GABAergic) neurons arborize mostly within their layer of origin. So the excitatory graph *is* the skeleton, and inhibition moulds it.

| Edge | Notes |
|---|---|
| Thalamus → **L4** (+ collateral to L6) | The driving afferent. Numerically tiny (see below) |
| **L4 → L2/3** | The major projection of L4 spiny stellates; stronger than L4 → L5 |
| **L2/3 → L5** | Upper L3 → lower L5, lower L3 → upper L5 in tree shrew (sublaminar matching) |
| **L5 → L6** | |
| **L6 → L4** | Closes the loop. Arbor diameter in L4 ≈ 590 µm — *wider* than the thalamic footprint it combines with |
| L5A → L2/3; L6 → L3; L6 → L6 | Modifications to the original Gilbert & Wiesel (1983) circuit |
| **L5 → subcortex** (basal ganglia, colliculus, ventral spinal cord) | The action output |
| **L6 → thalamus** (LGN, VPm/Po) | The modulatory return |
| **L2/3 → other areas, terminating in their L4** | Feedforward |
| **L5/L6 → other areas, terminating outside L4 (mostly L1)** | Feedback |

The same pattern holds in cat and macaque V1, macaque auditory and motor cortex, and rodent barrel cortex. Where species differ (macaque, tree shrew), the difference is *sublamination* — the same interlaminar motif duplicated and stacked to match a finer segregation of input streams — not a different circuit. The authors' image: a grandfather clock versus a Swiss chronometer.

**Layer 1 is the odd one out** and is called cortex's "crowning mystery": almost no cell bodies, mostly the distal apical tufts of pyramidal cells plus feedback and subcortical axons. That is, **the feedback channel arrives on the compartment that [[wiki/concepts/dendritic-computation.md]] identifies as a prediction channel rather than a drive channel.**

---

## The quantitative invariants

These are the numbers that make "canonical" a measurement rather than an impression.

| Invariant | Value | Where measured |
|---|---|---|
| Symmetric (GABAergic) synapses as a fraction of all synapses | **10–20%**, e.g. 11.5% vs 10.7% | Human anterolateral temporal cortex vs rat hindlimb S1 |
| Morphological types of smooth neuron | ~10, all found in all species | Golgi onward; marsupial and macaque V1 smooth cells are recognizably similar despite 135 My divergence |
| Overall synapse density | Near-invariant across areas and species | Cragg 1967; Rakic 1986; Schüz & Palm 1989 |
| Neurons under 1 mm² of superficial macaque V1 | 52,000, of which 17% GABAergic | Beaulieu 1992 |
| Double-bouquet axon bundles | Spaced **25 µm**, → 2,500 bundles/mm², 0.7 cells/bundle → 1,750 calbindin cells/mm² | Peters & Sethares 1997 |
| Calbindin⁺ share of superficial GABAergic cells | 20% (macaque V1), 20–30% (cat V1, macaque frontal) | Derived from the row above, then confirmed by direct counts |
| Interneuron composition is *not* invariant | Macaque V1 mostly parvalbumin⁺; macaque PFC is 45% calretinin, 24% parvalbumin, 20% calbindin | Condé 1994; Gabbott & Bacon 1996 |
| Pyramidal spine counts | Vary widely by area and species | Elston 2001, 2002 |

**So what is conserved is the E/I *ratio* and the connectivity motif; what varies is cell-intrinsic elaboration (spines, size) and interneuron proportions.** A machine analogue would fix the normalization budget and the wiring template and let the per-unit capacity be a free parameter — which is the opposite of the usual practice of fixing the unit and varying the connectivity.

---

## Functional efficacy is decoupled from synapse count — recurrence is the amplifier

The single most transferable result on this page:

| Fact | Number |
|---|---|
| LGN synapses as a fraction of excitatory synapses in L4 of cat/macaque V1 | **< 10%** |
| Inter-areal projection synapses as a fraction in their target layers | A few percent |
| Yet both are sufficient to *drive* their target areas | — |
| Are thalamic synapses individually stronger? | **No** — peak EPSP at most 2× a spiny-stellate synapse; they are exceptional only in low quantal variance |

The reconciliation offered (Douglas et al. 1989): **numerically small, moderately strong inputs are amplified by the recurrent cortical circuit.** The input does not carry the signal; it *selects* which recurrent state the circuit falls into.

**(brainstorm) This inverts how the wiki reads connectivity.** Every capacity and credit-assignment argument here counts synapses and weights their strength — `p_max ≈ kC/(a ln(1/a))` counts fan-in ([[wiki/entities/rolls-treves-hippocampal-model.md]]), attention weights are read as a one-step adjacency ([[wiki/concepts/attention.md]]). If a 5% input can dominate a circuit's output through recurrent gain, then **an edge's weight in a learned model is not an estimate of its causal influence**, and any interpretability method that ranks edges by magnitude is measuring the wrong quantity. The matching machine object is an attractor network whose input is a *cue* rather than a *drive* — which is exactly the regime [[wiki/entities/hopfield-network.md]] and [[wiki/entities/vector-hash.md]] already run in, and which no feedforward-weighted-sum reading of cortex captures.

**Drivers vs. modulators** (Crick & Koch 1998; Sherman & Guillery 1996), imported by the review: two excitatory connection *types*, distinguishable morphologically. Drivers — thick axons, grape-like clusters of large boutons, usually from L5 — set the qualitative structure of the target's receptive field. Modulators — thin axons, small en-passant boutons, usually from L6 — change the response quantitatively but not its structure. The same two bouton morphologies appear in direct inter-areal projections, where their function is unexplored. **This is a typed edge set inside a single excitatory transmitter**: a graph in which "A excites B" is not one relation but two, one changing *what* B represents and one changing *how strongly*.

---

## Lateral connections: patches, and the argument that like does *not* connect to like

Superficial pyramidal cells are the one population with heavy *intralaminar* recurrence, and their lateral axons form discrete patches.

| Quantity | Value |
|---|---|
| Patch diameter | 200–500 µm (mean 320 µm across areas/species) |
| Inter-patch spacing | ≈ **2× patch diameter** (mean 680 µm) — holds in macaque, cat, tree shrew |
| Patches labelled per injection | 10–30, arranged like the petals of a daisy |
| L3 pyramidal basal dendritic spread | ~200 µm — **scales with patch diameter across areas** (largest patches, 481 µm, in macaque motor cortex, which has the largest pyramids) |
| Patches are reciprocal | Labelled patches contain both cells and axons |

**Two incompatible readings of the same anatomy** (the source states both and endorses the second):

| Reading | Mechanism | Consequence |
|---|---|---|
| *Like connects to like* — "cells that fire together wire together" | Hebbian clustering over correlated tuning | Patches are functional equivalence classes; the lateral net is an associative memory over tuning similarity |
| *Malach's diversity argument* | Patch diameter matches dendritic spread, so only a cell at a patch's centre samples pure patch input; centre-of-gap cells sample pure non-patch; everything in between mixes | Size matching **maximizes the diversity of a cell's inputs** — most cells receive a *mixture*, so like does **not** connect to like |

Supporting the second: like-to-like correlations appear only at 400–1000 µm from the injection; at short range axons freely innervate functionally diverse territory. Recorded as [[wiki/empirical-tensions.md]] T65.

**The fan-out rule is the same within and between areas.** Individual projection neurons rarely innervate more than one other cortical area, even though each area connects to many; and within a patch, individual cells each target a *different subset* of the patch set. So a patch is a heterogeneous cluster whose members' outputs diverge — **the population, not the cell, is the addressed unit, and no cell knows the whole address space.**

**Lamination as a wiring-cost solution.** The stated general purpose of layers is to be "a scaffold that constrains the way in which neurons can connect", minimizing wire (Mitchison 1991: one undivided cortical area instead of hundreds would need ~10× the volume for the same circuits). **(brainstorm)** The transferable form: an architectural prior expressed as a *connectivity mask* costs nothing at inference and buys an order of magnitude in connection cost — the same argument [[wiki/entities/dendritic-ann.md]] makes empirically for tree-partitioned connectivity, arrived at from cortical volume rather than from parameter count.

---

## The hierarchy is a graded, measurable quantity

The laminar feedforward/feedback rule gives an anatomical hierarchy (Felleman & Van Essen 1991), but it is badly **under-constrained** — enormous numbers of equally consistent hierarchies satisfy it (Hilgetag et al. 1996).

The fix is the **SLN% distance rule** (Kennedy & Bullier 1985; Barone et al. 2000): measure the *proportion* of a projection's source cells that lie in the superficial layers. The higher the SLN%, the closer the two areas in the hierarchy.

| Injection in V4 | SLN% at source |
|---|---|
| V1 | 100% |
| V2 | 93% |
| V3A | 60% |

Ranking by SLN% yields a **single** hierarchy, and it disagrees with the binary one: frontal eye field drops from level 8 to level 4, alongside V3/V3A.

**(brainstorm) This is a directly usable evaluation instrument and the wiki has no analogue.** Hierarchy depth in a learned model is normally read off the architecture (layer index) rather than measured from the connectivity. The cortical version says: *depth is estimable from the mixing proportion of two connection types*, it is continuous, and the continuous estimate resolves a degeneracy that the discrete one cannot. Applied to a trained network with typed edges (e.g. feedforward drive vs. top-down modulation), the same statistic would give a *learned* hierarchy that could be compared against the *designed* one — a test for gap G17-style claims about whether a model built the structure it was supposed to.

**A second, independent laminar estimate of depth — and a coupling rule SLN% does not express.** The *structural model* (Barbas; summarised in Satpute et al. 2026, `raw/satpute-2026-dmn-hierarchical-generative-model.md`) grades an area by **its own laminar differentiation** rather than by the layer-of-origin of its projections: allocortex (3–4 layers; hippocampus, limbic lobe) → dysgranular (4–6, poorly differentiated) → eulaminate I → II → III → koniocortex (primary sensory), with differentiation increasing as hierarchical position falls.

| | SLN% distance rule | Laminar differentiation (structural model) |
|---|---|---|
| Measured on | a *projection* — superficial fraction of its source cells | an *area* — number and differentiation of its own layers |
| Yields | a relative distance between two areas | an absolute level per area, comparable across the whole cortex |
| Says about coupling | nothing — it describes projections that exist | the **laminar type rule**: areas preferentially connect to areas of *similar* laminar profile (granular↔granular, agranular↔agranular) |

The laminar type rule is the load-bearing addition, because it turns depth from a coordinate into an **eligibility constraint**: with several laminar types present inside one network, level-matched channels run in parallel and no single serial pathway carries the traffic — a heterarchy rather than a chain ([[wiki/concepts/broadcast-hierarchy.md]]). The two estimates have not been compared on the same areas anywhere in the wiki, and they need not agree: an area with a high SLN%-derived position could still be laminarly differentiated, in which case the rules predict different partners for it.

---

## Two inhibitory geometries, two jobs

The ~10 smooth-cell types collapse to **two functional classes by axon geometry** — which is the review's cleanest structural inference:

| Class | Exemplars | Marker | Target compartment | Proposed job |
|---|---|---|---|---|
| **Horizontal** | Large/small basket, chandelier | Parvalbumin | Axon initial segment, soma, proximal dendrite — the *output* path | **Selection**: soft winner-take-all / soft-max across the local population |
| **Vertical** | Double bouquet, Martinotti, bipolar, axonal arcades | Calbindin (partly) | Distal basal dendrites and apical branches — the *input* sites | **Transfer-function control**: dynamically set which inputs a cell's dendrites pass |

Geometry table: a large L3 basket cell's dense perisomatic arbor is ~280 µm across — matching one patch — plus ~5 thin radial branches extending ~650 µm, which is *not* a patch shape. So the same cell exerts patch-wide dense inhibition and long-range inhibition focused along a few narrow radial paths. Double-bouquet axons form a regular 25-µm lattice through the superficial layers, and 40%/60% of their boutons land on spines / small distal dendritic shafts.

**A laminar corollary with no wiki analogue:** because interneuron types are distributed unevenly across layers, *which* inhibitory channels act on a pyramidal cell is set by its laminar position — L3 pyramids receive far more chandelier input than L6 pyramids simply because L3 has more chandelier cells. **Inhibitory control is therefore position-dependent by construction**, which is a wiring-level answer to the "what sets the channel gains" regress left open by [[wiki/concepts/inhibitory-control-of-coding.md]].

---

## The variations half: the same circuit re-keyed to cell class rather than to layer

> Harris & Shepherd 2015, *Nat. Neurosci.* 18(2):170–181 (`raw/harris-2015-neocortical-circuit-themes-and-variations.md`). Review of optogenetic circuit mapping, paired recording, transgenic markers and *in vivo* imaging, largely rodent sensory and motor cortex. Thesis: cortical areas are **serially homologous** — hands and feet, not copies — and *"lamination is not the sole or even primary organizing principle of neocortex. Instead, what different regions share is their hodology: the patterns of connection between different genetically defined cell classes."* Everything above this section is keyed to layers; this section is the same circuit keyed to classes, and the two keys do not commute.

### The three excitatory classes (Table 1, condensed)

| | **IT** — intratelencephalic | **PT** — pyramidal tract | **CT** — corticothalamic |
|---|---|---|---|
| Layer | L2–L6; **L4 IT** a hodologically distinct subclass | L5B, thick-tufted | L6 |
| Genes | *Satb2* (*Rorb* in L4) | *Fezf2*, *Ctip2* | *Tbr1* |
| Local excitatory input | Many, from L4 IT and other IT | Many, **mainly from IT** | Few, mainly deep-layer (L5B/6) IT |
| Local excitatory output | IT, PT, CT | **Few** — a local sink | Some IT, possibly PT |
| Long-range input | Thalamus, higher *and* lower cortex | Thalamus (core-type), higher and lower cortex | **Higher-order cortex**, not thalamus, not local |
| Long-range output | Telencephalon only (cortex, striatum, amygdala, claustrum); **the only excitatory class with callosal axons** | Brainstem, tectum, spinal cord, thalamus, basal ganglia; intracortical collaterals ipsilateral only, seen mostly in *feedback*-type projections | Thalamus only; **the only excitatory class with no long-range corticocortical axon** |
| *In vivo* rate | Sparse (L2 sparser than L3) | **Dense — the highest of all excitatory classes** | Very sparse; "remarkably silent" across behaviours |

**Sequential hodology:** `L4 IT → IT of other layers → PT`, asymmetric at every step (L4 receives little back; PT gives little back). The interneurons are sequential too — `Vip ⊣ Sst ⊣ Pvalb ⊣ pyramidal cell` — and the same order is reported in several areas.

**The caveat the authors put in italics and that simplified schematics lose:** the sequence is *not* a pipeline. Every excitatory class has its own long-range input (multiple **entry** points) and every excitatory class is a projection neuron (multiple **exit** points). A three-stage local chain with an independent input and an independent output at each stage is a different object from a three-layer feedforward net — it is closer to a bus with taps.

### What the re-keying does to this page's canonical graph

| Edge as stated above (Douglas & Martin 2004) | Under Harris & Shepherd 2015 |
|---|---|
| `L5 → L6 → L4` closes the loop | Not a step in the local excitatory sequence. PT is the **terminus**, giving little back locally; CT sits off the path, driven by higher-order *cortex* rather than by local cells |
| `L6 → L4` | In rodent, L6→L4 excitation is weak-to-absent and its net effect is often **inhibitory** — in mouse S1 CT cells innervate L5A IT but indirectly *inhibit* L4; in V1 they inhibit all other layers via a Pvalb subclass. The loop closes as gain control, not as re-entrant excitation |
| "L5" and "L6" as tiers | Both layers are **class-mixed**: IT and PT intermingle in L5B, IT and CT in L6. A laminar electrode, a laminar lesion or a laminar term in a model pools two classes with opposite jobs (one broadcasting subcerebrally at the highest rate in cortex, one nearly silent) |
| Feedback comes from "L5/6" | CT has no corticocortical axon at all, so the feedback sender is IT subclasses plus PT collaterals — a **class** statement, and PT's systematic contribution to feedback is flagged as untested |
| Thalamus → L4 is *the* driving afferent | Core-type thalamic input also reaches **PT directly, strongly enough to drive it without L2/3** — the deep tier is not downstream-only |

### Serial homology: identical topology, opposite sign

The sharpest result for anyone copying a column:

| Area | Locomotion's effect on Vip cells | Locomotion's effect on superficial excitatory-cell sensory responses |
|---|---|---|
| V1 | **Increase** | **Increase** (via Vip-mediated disinhibition) |
| A1 | **Increase** | **Decrease** in L2/3 IT and Pvalb cells |

Both effects are mimicked by optogenetic drive of the higher-order cortical input, so the same top-down command produces opposite-signed changes through apparently identical hodology. The authors' analogy: one electronic topology is an amplifier or an attenuator depending on component impedances; candidate loci are the relative strengths of Vip→Sst / Vip→Pvalb / Vip→pyramidal inhibition, neuromodulator sensitivity per interneuron class, or the strength of top-down input onto each class.

**(brainstorm) This is the load-bearing qualification on cortical uniformity, and the wiki has been running without it.** Every argument on this page that licenses copying one column everywhere ([[wiki/concepts/distributed-reference-frames.md]], [[wiki/entities/thousand-brains-theory.md]]) buys the *wiring* and not the *computation*: sign-inverted behaviour is reachable from one topology by changing scalars. The right machine analogue is therefore **shared topology with per-module gains**, not weight sharing — a hypernetwork emitting a small per-area parameter vector over a fixed connectivity mask. It also predicts the failure mode of the uniformity programme: a single trained column transplanted to a new modality will be functionally wrong even when it is structurally right, and the error will be in a handful of scalars rather than in the graph.

### Cell class, not laminar position, determines connectivity

Mutually suppressive transcription factors specify the top-level classes (*Fezf2*/*Ctip2* → PT, *Satb2* → IT, *Tbr1* → CT), and downstream gene modules control the axon-guidance and synapse-formation machinery that gives each class its connectivity profile. Manipulating those factors in **postmigratory** neurons changes their connectivity and physiology — the cell has already reached its layer and its wiring changes anyway. The review's conclusion: *it is the genetically specified cell class, rather than laminar location per se, that is the fundamental determinant of cortical connectivity.*

Area differences then arise two ways: (i) graded transcription-factor expression across the cortical sheet sets long-range targets and the quantitative circuit parameters, (ii) thalamocortical innervation and afferent activity sculpt the thalamorecipient tier — barrel formation, spiny-stellate dendrite retraction and L4-specific gene expression all require thalamocortical input, and barrel cortex adapts to the number of intact whiskers.

Against every laminar assignment above — Douglas–Martin's explore/exploit split, Bastos et al.'s one-quantity-per-population table — this says the layer index is a **proxy for a type label**, and the proxy fails exactly where the two class-mixed layers are. Recorded as [[wiki/empirical-tensions.md]] `T371`.

### L4 is where areas actually differ

| Observation | Area/species |
|---|---|
| Spiny stellates present | cat and monkey V1 |
| Spiny stellates absent | rodent V1; generally absent in A1 |
| L4 markers present without a granular layer | agranular motor cortex ("rudimentary L4") |
| L4 stratified into input-stream sublayers | primate and human V1 |
| L4 carries a map of the nose | star-nosed mole S1 |
| L4 receives massive core-type thalamocortical input and little else | primary sensory cortex generally |
| L4 receives lower-order *cortical* input | higher-order sensory areas — the input pattern used to define hierarchy |

Outside L4 the review finds "little evidence for major inter-areal differences in local circuit hodology". **(brainstorm)** The importable shape is a conserved trunk with a **per-modality input adaptor** whose architecture is *sculpted by its own input statistics during development* rather than designed — which is what "input-driven malleability of L4 might help accelerate the evolution of new sensory strategies" says. In model terms: freeze the shared body, let the front end's connectivity (not just its weights) be produced by the data it is trained on.

### Thalamic input is typed, and the type is relative to the target

| Type | Source | Termination | Reading |
|---|---|---|---|
| **Core** | First-order relay nuclei (VPM, ventral MGN, dorsal LGN) | L4, topographic; also L3, L5B/6; drives PT directly | Rapid sensory/motor content; the *driver* |
| **Matrix** | Higher-order nuclei (POm, dorsal/medial MGN, LP/LD) | **L1** and L5A; **avoids L4** | Cargo "poorly understood" — arrives on the apical tuft, i.e. on the compartment [[wiki/concepts/dendritic-computation.md]] types as the prediction/context channel |
| **Intralaminar** | Intralaminar nuclei | L5/6 of motor and frontal cortex, plus striatum | A third stream that no laminar scheme in the wiki represents |

Two refinements worth carrying. **(i) The typing is not intrinsic to the source:** matrix-type nuclei projecting to *secondary* somatosensory and auditory cortex terminate heavily in L4 and appear to **drive** those areas, while the same class of cell modulates primary areas. Driver/modulator is therefore a property of the edge, not of the sending nucleus — which sharpens the typed-edge claim made in the driver/modulator paragraph above and constrains [[wiki/concepts/transthalamic-context-routing.md]]'s per-edge context channel. **(ii) The two streams are split at single-cell resolution and by sublayer:** L3 IT receives core input on its **basal** dendrites and matrix plus higher-order cortical input on its **apical** tuft; L2 IT receives matrix input but little core, its basal dendrites barely overlapping the core axons. So the evidence/context separation is implemented twice — once by compartment, once by sublayer — and the supragranular layer that most models treat as one population is at least two.

### IT subclasses as a generator for the inter-areal connectivity matrix

The SLN% rule above makes hierarchy a laminar measurement. In rodent it partly fails: feedforward and feedback projections arise from **distinct populations that do not always occupy different layers**, with the main laminar signature being feedback's avoidance of L4. The proposed replacement:

- A molecularly distinct deep-layer subclass (latexin⁺, *Nr4a2*⁺) in secondary visual, auditory and somatosensory cortex sends feedback to the **corresponding primary area** and rarely anywhere else — a gene module that appears to specify a projection *role*.
- Within superficial barrel cortex, distinct IT subclasses project to M1 versus S2, with different intrinsic physiology and different coding *in vivo* — hypothesised as homologues of the dorsal (where) and ventral (what) streams, whose primate counterparts also differ in firing pattern.
- Hypothesis: a small set of homologous IT subclasses, each with a gene module fixing its input connectivity, physiology and long-range target class, diversified by area-specific gradients that say *which* area of that class to target (V2→V1 rather than V2→A1).

**(brainstorm) Read as a parameterization this is a low-rank factorization of the connectome**: instead of `N²` free inter-areal weights, `k` subclass types × an areal gradient, with the type fixing *what kind* of edge and the gradient fixing *which* endpoint. That is directly buildable — a growing modular architecture where a new module instantiates the same `k` port types and an embedding picks its partners — and it makes hierarchy a *consequence* of port types rather than a designed depth index, which is what [[wiki/concepts/broadcast-hierarchy.md]] needs and what a layer index cannot express. It also says the primate/rodent laminar disagreement may be a **re-layering of conserved types**, not a different circuit: homology at the level of classes, not of positions.

---

## The Douglas–Martin functional model: explore in the superficial layers, exploit in the deep

The review's closing hypothesis, and the reason a 2004 anatomy paper belongs on a reasoning wiki:

| Step | Circuit | Computation |
|---|---|---|
| 1 | A patch of L2/3 pyramids receives feedforward input (thalamic, inter-areal, intra-areal) **plus** feedback from the deep pyramids below it, from neighbouring patches, and from other areas' L5 | Assemble evidence and context into one population |
| 2 | Vertical smooth cells (double bouquet) set the dendritic transfer functions of those pyramids | **Hypothesis space shaping** — which combinations of inputs are currently expressible |
| 3 | Horizontal smooth cells (basket, chandelier) mediate competition among the pyramids' outputs | **Soft winner-take-all / soft-max selection** (Maass 2000; Riesenhuber & Poggio 1999) |
| 4 | The selected pyramids feed back onto the vertical smooth cells | The selection **re-shapes the hypothesis space**, so steps 2–3 iterate |
| 5 | Superficial output → L5, which has its own soft-selection network | **Commitment**: the decision on the output to motor structures |
| 6 | L5 → L6 → L4 | The committed output **constrains the incoming evidence** |
| 7 | L5 → superficial layers of *other* areas (feedback) | Broadcast the commitment as context for other areas' step 1 |

> *"The superficial layers are organized to distribute and explore possible interpretations, whereas the deeper layers are organized to exploit the evolving interpretations."*

**Why this is worth having.** It is the only account in the wiki of a **cortex-wide arbitration mechanism** that names its parts: the thing being arbitrated is an interpretation, the arbitration is soft-WTA over a population, the arbitration is *iterated* rather than one-shot because the winners rewrite the dendritic transfer functions, and consensus spreads laterally (patches) and hierarchically (L5 feedback) through the same primitive. [[wiki/concepts/distributed-reference-frames.md]] assumes exactly this operation — "recognition is voting across frames" — and specifies none of it; here it is a circuit.

**(brainstorm) The machine object this describes is not a feedforward stack.** It is: *iterated soft-max selection over a population, with a learned per-step gate on which inputs each unit integrates, plus a commitment head whose output is fed back both to the evidence stream and to peer modules.* Steps 2→3→4 are a two-timescale loop with no gradient in sight — the selection changes the representation, which changes the selection. The nearest existing objects are relaxation in an energy-based model ([[wiki/concepts/energy-based-models.md]]) and the explore/commit split in [[wiki/concepts/simulation-based-planning.md]], but neither has the transfer-function-modulation channel, which is the part that makes the search over interpretations *structured* rather than a settling.

---

## The predictive-coding assignment: the same graph, one quantity per cell class

> `raw/bastos-2012-canonical-microcircuits.md` — Bastos, Usrey, Adams, Mangun, Fries & Friston, *Neuron* 76:695–711, 2012. A review that does one thing the wiki has no other instance of: it takes a set of *differential equations* (generalised predictive coding, Eq. 1 of [[wiki/concepts/predictive-coding-free-energy.md]]) and asks which measured cell population computes each term, then checks the resulting graph against the quantitative connectivity of Haeusler & Maass (2007) / Thomson et al. (2002).

**The assignment.** Two variable types (hidden causes `v`, hidden states `x`) × two roles (expectation `μ`, prediction error `ξ`) = four quantities, plus a precision. Each lands on a distinct population:

| Population | Quantity | Why that cell |
|---|---|---|
| **L4 spiny stellate (excitatory)** | prediction error on **causes**, arriving from the level below | Feedforward extrinsic input terminates here |
| **L4 inhibitory interneuron** | prediction error on **hidden states** | Assigned "for symmetry"; hidden-state dependencies are confined to a node, so they must stay intracolumnar |
| **L2/3 excitatory interneuron** | expectation on **causes** | ~half of L2/3 excitatory cells do not leave the column (Callaway & Wiser 1996) |
| **L2/3 inhibitory interneuron** | expectation on **hidden states** | Node-local, so inhibitory |
| **L2/3 pyramidal** | prediction error on causes, **broadcast forward** | Superficial cells are the source of feedforward extrinsic connections |
| **L5/6 pyramidal + deep excitatory interneuron** | the **prediction** itself (nonlinear `g`, `f` of the expectations) | Deep cells are the source of feedback extrinsic connections; ~80% of L5 excitatory cells stay in the column |
| **Gain of the L2/3 pyramidal cell** | **precision `Π`** of the ascending error | Superficial layers carry the nonlinear dendritic/neuromodulatory infrastructure needed to scale, not just relay |

The structural regularity that makes this non-arbitrary: **causes are excitatory, states are inhibitory; expectations sit supragranular, errors sit granular/superficial-pyramidal.** Because a graphical model confines hidden-state dependencies to a node, the state variables must be encoded by cells that do not project out of the column — which is what forces them onto interneurons.

**A rival assignment of the same cells** (Keller & Mrsic-Flogel 2018, [[wiki/concepts/prediction-error-neurons.md]]). Built from mouse two-photon work rather than from the differential equations, it disagrees with the table above on two cell classes:

| Cell class | Bastos et al. 2012 | Keller & Mrsic-Flogel 2018 |
|---|---|---|
| **L2/3 inhibitory interneurons** | encode *expectations on hidden states* — a represented variable, node-local, hence inhibitory | a **relay**: a somatostatin-expressing subset carries the bottom-up drive that the negative-error cell's top-down excitation is compared against; other subsets carry top-down inhibition to positive-error cells |
| **L2/3 pyramidal** | one population, one precision-weighted residual `ξ` on causes | **two** populations of opposite wiring and opposite effect on the target — positive error (bottom-up minus top-down inhibition) and negative error (top-down minus bottom-up inhibition) |
| **L5/6** | the prediction itself, `g`/`f` of the expectations | the **internal representation** from which predictions are generated — conjectured, with the explicit admission that no such cell class has been demonstrated |

The two schemes therefore predict **opposite results from silencing supragranular interneurons**: under Bastos a represented variable disappears and the state estimate loses its dynamical term; under Keller the comparator loses one of its two inputs and the error cells' responses invert in sign. Recorded as [[wiki/empirical-tensions.md]] **T341** for the population count and **T118** for what the pyramidal spike means.

**It nearly matches the measured circuit, and the misses are a prediction.** Every edge predictive coding requires exists in the quantitative microcircuit *except two*: projections onto the granular inhibitory cells from supragranular inhibitory and infragranular excitatory populations. Those are required because a state-error unit must compare *expected* change in hidden states against *actual* change, so it needs both. The paper predicts these connections exist and are feedback-type (prediction-carrying). **This is the wiki's cleanest example of a computational specification generating a falsifiable anatomical claim** — the equations say which wires must exist, and two of them had not been reported.

**Two functional readings of the same lamination, now both explicit:**

| | Douglas–Martin (2004) | Bastos et al. (2012) |
|---|---|---|
| Superficial layers | **Explore** interpretations (iterated soft-WTA) | Compute and broadcast **prediction error** |
| Deep layers | **Commit** to one, drive motor output | Hold **expectations**, emit **predictions** |
| What ascends | The selected interpretation | The residual only |
| What the loop does | Selection re-shapes the hypothesis space | Error accumulation smooths into an estimate |
| Inhibition's job | Selection (perisomatic) + transfer-function control (dendritic) | *Encoding a variable* — inhibitory cells hold hidden-state quantities |

They disagree on what a superficial pyramidal spike *means* (a candidate interpretation vs. a residual) and on what inhibition is *for* (competition vs. representation). Recorded as [[wiki/empirical-tensions.md]] T118.

**(brainstorm) The transferable object.** Take the two readings together and the column is: a population that holds a state estimate, a second population that holds only the residual against it, a per-unit gain register on the residual population that is set by uncertainty, and a nonlinear read-out that converts state → prediction for a peer module. That is a **typed register file with a learned precision term**, not a layer of a network. The wiki's machine architectures collapse all four onto one activation vector; the cost of the collapse is that nothing in them can be *attended to* (gain of the error channel) independently of being *represented* (state channel) — the split G56 asks for, delivered at cell-class resolution.

**Feedback is inhibitory in effect and driving-plus-modulatory in mechanism** — a resolution the wiki should carry, because the two readings look contradictory in the raw data:

| Observation | Reading under predictive coding |
|---|---|
| Optogenetic drive of V1 L6 suppresses LGN visual responses by 76% and V1 L2–5 by 80–84% (Olsen et al. 2012) | Predictions subtract; feedback's *net* effect is suppression |
| Cooling V5/MT or V2 **decreases** V1 firing for stimuli confined to the classical receptive field, but **increases** it when the surround is stimulated (Hupé et al. 1998; Bullier et al. 1996) | Higher levels learn features spanning many lower receptive fields (Rao & Ballard 1999); with no surround there is nothing to predict, so removing feedback removes drive, not explanation |
| Cortico-cortical feedback evokes driving-type responses between proximate areas (Covic & Sherman 2011) | Predictions must *obligatorily* elicit responses in error units — a weak modulator could not cancel a driving input |
| Feedback terminates in L1, which is <0.5% of cells, almost all inhibitory, strongly interconnected, monosynaptically inhibiting L2/3 pyramids (Chu et al. 2003; Meyer et al. 2011) | The anatomical route by which an excitatory long-range projection delivers net inhibition to the error population |

Extrinsic connections are glutamatergic; the inhibition is **polysynaptic and local**, so "feedback is inhibitory" is a statement about effective connectivity, not about the transmitter. A machine analogue must therefore implement subtraction with a *learned local circuit*, not with a negative weight on the descending link.

**Prediction-error signatures the assignment has to explain** (the paper's Table 1, worth carrying as a test battery): enhanced firing in monkey inferotemporal cortex to violated learned image pairings (Meyer & Olson 2011); enhanced V1–V3 firing to stimuli violating natural-image statistics; mismatch negativity and enhanced gamma to deviants in an auditory stream (Garrido et al. 2007; Todorovic et al. 2011); enhanced BOLD to incoherent form/motion and to apparent motion; **sign-flipping with attention** — unpredicted stimuli raise the BOLD response when unattended and lower it when attended (Kok et al. 2011), which is precisely what a precision gain on the error population predicts and what a pure subtraction account cannot produce.

**Transthalamic routing is an unresolved alternative to the direct cortico-cortical edges.** The posterior medial nucleus can relay S1→S2 (Theyel et al. 2009), and higher-order thalamus has been proposed as a synchronizer of cortical responses (Saalmann et al. 2012). Whether the feedforward/feedback typing survives being routed through thalamus is open — and it matters for any model that treats inter-areal edges as direct.

---

## The laminar assignment has a time axis: where a memory is read from moves upward over weeks

> Frankland & Bontempi 2005, Nat Rev Neurosci 6:119–130 (`raw/frankland-2005-organization-of-recent-and-remote-memories.md`), reviewing Bontempi et al. 1999 and Frankland et al. 2004. Cellular imaging (*Zif268*/*c-fos*) of mice recalling a spatial discrimination at recent vs. remote delays.

Every layer assignment on this page is stated as fixed wiring. In parietal cortex it is not fixed over the life of a memory: recall-evoked activation shifts from the **deep layers V–VI** at recent delays to **layers II–III and IV** at remote ones, while regional-level activation in some areas does not change at all.

| Reading | Consequence |
|---|---|
| Layers II/III are the origin and termination of most cortico-cortical connections | The shift is what "new cortico-cortical connections were established" would look like at cellular resolution, i.e. consolidation moves a trace *into the lateral graph* of this page |
| Deep layers are the subcortical/inter-areal output tier | At recent delays the same content is read out through the descending tier instead |
| The shift is **sub-regional** | Regional-level imaging (human fMRI, 2-deoxyglucose at coarse resolution) is blind to it, which the reviewers offer as why cortical remote-memory activation has been hard to find in humans |

**(brainstorm)** For a builder the useful form is that laminar identity indexes *the age of what is being read*, not only the direction of a signal — so a column's supragranular and infragranular populations can hold the same content at different stages of consolidation, and an instrument that averages over depth cannot see the transition. It also predicts that the superficial/deep functional split of the Douglas–Martin model above (explore vs. exploit) should be measurably confounded with content age in any task run over weeks; no experiment here controls for it.

---

## Limitations

| Limit | Consequence |
|---|---|
| **No quantitative connectivity matrix exists** | The review states it plainly: nobody knows what proportion of synapses in a lamina any given spiny class contributes. Every edge in the graph above is a direction without a weight |
| Photostimulation strength ≠ anatomy | Uncaged-glutamate maps could reflect cell counts, indirect activation, or the driver/modulator distinction; the review cannot separate them |
| The functional model is untested | Labelled "a tentative hypothesis" by its own authors; no simulation, no fit, no prediction discharged |
| What the lateral patches are *for* remains unanswered | The review's own verdict: "yards of ignorance remain at even the most basic level" — what sets patch number, extent, or where a patch's cells send their outputs |
| Nonclassical-receptive-field explanations are contested | Whether the lateral spread exceeds the classical receptive field by 8× or matches it is disputed within the cited literature |
| Rodent V1/S1 lack the patchy connections | The patch motif, the most distinctive feature here, is the *least* canonical thing on this page |
| The evidence base is skewed to visual cortex of cat and primate | Canonicity is partly an extrapolation from where people looked |
| The hodological evidence is skewed the other way — to one mouse strain | The sequential excitatory and inhibitory hodologies come largely from techniques applied only in rodent (much of it C57BL/6 *Mus musculus*); Harris & Shepherd state there are as yet insufficient data to know whether the sequence holds in other mammals, so "themes" and "variations" rest on partly disjoint evidence bases |
| The subclass homologies are a hypothesis, not a result | The IT-subclass generator for inter-areal connectivity is offered as an extrapolation from one clear case (latexin⁺/*Nr4a2*⁺ feedback cells); whether top-level classes even have homologous *long-range inputs* across areas is unknown (PT cells in barrel cortex get almost no matrix-type thalamic input — nobody has checked elsewhere) |
| CT is a hole in every functional model on this page | L6 is a substantial fraction of cortical volume; CT cells are driven mainly by higher-order cortex rather than locally or thalamically, are near-silent *in vivo*, and their strongest measured effect is inhibition of other layers. No assignment here — modulator, location code, gain control — has been tested against that profile |

- **The L6 typing is doing work it was never tested for.** Douglas & Martin's driver/modulator distinction was imported from thalamic work with its inter-areal function stated as unexplored, and the Thousand Brains Theory assigns the same layer a *content* role — a path-integrated location code that is half of a conjunctive object representation. Modulator or location code is [[wiki/empirical-tensions.md]] T66, and it decides whether a machine column's location input is a multiplicative gain on an evidence stream or a first-class content input.

---

## Connections

- **[[wiki/concepts/distributed-reference-frames.md]]** — supplies the circuit that theory presupposes and never specifies: "columns vote on a consistent pose" becomes soft winner-take-all among superficial pyramids, with lateral patches carrying the vote between columns and L5 feedback carrying it between areas; it also supplies the uniformity evidence that whole argument rests on — and now the qualification on it: identical hodology in V1 and A1 produces opposite-signed responses to the same top-down drive, so a transplanted column is functionally wrong while structurally right, and what must be per-area is a handful of scalars (Harris & Shepherd 2015).
- **[[wiki/concepts/dendritic-computation.md]]** — the anatomy that makes the apical/basal split load-bearing: feedback and subcortical input terminate in layer 1 on distal apical tufts while drive arrives on basal and proximal compartments, so the prediction channel and the evidence channel are physically separated at the level of wiring, not just of theory — separated twice over, since matrix-type thalamic input and higher-order cortex land on the L3 pyramid's apical tuft while core-type thalamic input lands on its basal dendrites, and L2 IT cells receive the matrix stream with barely any core stream at all.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the same interneuron populations sorted by a different criterion: that page splits them by transcriptomic family and assigns each a *code feature*, this one splits them by axon geometry and assigns each a *computational role* (perisomatic → selection, dendritic → transfer-function control) — and adds that which channels reach a cell is set by its layer, which is a wiring answer to that page's open "what sets the gains" question; a third cut, by genetic class, recovers that page's `Vip ⊣ Sst ⊣ Pvalb` chain in neocortex as a *sequential hodology* running parallel to the excitatory one, with Vip addressed by layer-1 corticocortical axons and ionotropic acetylcholine/serotonin receptors and Pvalb the only interneuron class on the feedforward drive path.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the laminar substrate that hierarchy assumes: feedforward from L2/3 into L4 of the area above, feedback from L5/6 into layer 1 below, with the SLN% distance rule making hierarchical depth a measurable continuous quantity rather than a stipulated layer index — and the rival functional assignment to this page's explore/exploit reading: superficial pyramids are **error units** (the only thing that goes up is prediction error) and deep pyramids **state units** (the only thing that comes down is a prediction), which explains the driver/modulator asymmetry as linear bottom-up error mixing against nonlinear top-down entry through `f, g`, and predicts that local field potentials measure prediction error directly (Friston & Kiebel 2009). Bastos et al. 2012 completes that assignment to cell-class resolution (causes excitatory, states inhibitory; expectations supragranular, errors granular and superficial-pyramidal; precision on the L2/3 pyramid's gain) and derives the gamma-superficial / beta-deep asymmetry from the fact that expectations integrate errors.
- **[[wiki/concepts/attention.md]]** — the biological form of the soft-max: selection over a population implemented by perisomatic inhibition, iterated rather than one-shot, and with a second channel (dendrite-targeting inhibition) that changes what each unit can integrate before the competition runs — a control the standard attention block has no counterpart for.
- **[[wiki/concepts/energy-based-models.md]]** — the closest machine reading of the explore/exploit lamination split: superficial layers relaxing toward a consistent interpretation under mutual inhibition is a settling process, and the deep layers are the read-out that commits and then constrains the input.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — where the sparsity comes from mechanically: perisomatic soft winner-take-all is the operation that holds the active fraction in the band those results require, and the conserved 10–20% symmetric-synapse fraction is a measured budget for it.
- **[[wiki/concepts/population-geometry.md]]** — a wiring-level prediction about mixing: if Malach's size-matching argument holds, most superficial pyramids sample a *mixture* of patch and non-patch input by construction, so mixed selectivity is a consequence of dendrite-to-patch scale matching rather than of a learned code.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a typed-edge lesson for the framing: cortex distinguishes driver edges (set what the target represents) from modulator edges (set how strongly), so an inferred graph with one edge type is under-specified, and edge *magnitude* is a poor proxy for causal influence when recurrent amplification lets a 5% input select the state.
- **[[wiki/concepts/three-component-framework.md]]** — an architecture-slot contribution with an unusual property: the wiring template is specified in detail (laminar graph, patch geometry, two inhibitory classes) while the objective and the learning rule are entirely absent, which is the mirror image of most entries in the wiki.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — a test case for what a *connectivity* import looks like: not a representation or a rule but a graph with typed edges and measured scale ratios, transferable without any biophysics — and a caution, since the review's functional interpretation of that graph is admittedly a hypothesis.
- **[[wiki/entities/dendritic-ann.md]]** — the same wiring-cost argument from the other end: lamination is described here as a scaffold that buys ~10× in cortical volume for the same circuits, which is the biological version of that model's demonstration that a constrained connectivity template beats a matched unconstrained one on parameter efficiency.
- **[[wiki/entities/hopfield-network.md]]** — what "recurrent amplification of a numerically small input" means formally: an input that is a cue selecting a basin rather than a drive summed into the output, which is the regime in which <10% of the synapses can determine the answer.
- **[[wiki/entities/thousand-brains-theory.md]]** — the most specific functional assignment anyone has hung on this graph, and a partial disagreement with it: layer 6 is the modulator-type source here but carries the location code that decides what a column represents there, and the theory's L5→L6 efference copy and L6→thalamus→L2/3 broadcast are edges this page contains without functional interpretation.
- **[[wiki/concepts/vectorized-instructive-signals.md]]** — the layer-1 termination zone used causally rather than descriptively: optogenetically driving layer-1 NDNF⁺ interneurons switches off the feedback arriving on distal apical tufts, which abolishes the task- and reward-related information carried there and blocks learning — so this page's feedback-into-layer-1 wiring is load-bearing for plasticity, not only for gain.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — what the motif buys if the laminar loop is a learning circuit: the dendritic-error model needs exactly this wiring — feedback onto distal apical tufts, plus a vertically-projecting interneuron (Martinotti-like) that learns to cancel it — so an error term appears in the apical compartment with no dedicated error cell, and the model's unpaid debt is a one-to-one pyramidal→interneuron mapping this anatomy does not supply.
- **[[wiki/entities/trnn.md]]** — the coarsest possible version of this motif — sensory / association / motor blocks with sparser inter-block than intra-block recurrence — turns out to be near-necessary for transient working-memory dynamics in a trained network, and reproduces the recorded fall in stimulus selectivity along the sensory-to-motor gradient (Liu et al. 2025).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the strongest claim in the wiki that the canonical circuit is *sufficient for control*: medial prefrontal cortex is argued to differ from sensory cortex only in what it is wired to, not in its local architecture, so the control layer would be this page's circuit at an unusual pair of ports — asserted by Euston et al. 2012 and never tested by comparing the two circuits directly.
- **[[wiki/entities/pfc-columnar-planning-model.md]]** — assigns the column/minicolumn motif a concrete computational job (one column = one graph node, its minicolumns = that node's outgoing edges) while conceding this page's open problem: no general function for the column is established (Martinet et al. 2011).
- **[[wiki/concepts/inter-areal-synchrony.md]]** — the measurement that discriminates the two functional readings of this graph without tracing an axon: superficial gamma and deep beta, coherent within compartments and not across, with feedforward influence carried at higher frequencies than feedback — a spectral read-out of which population holds the estimate and which the residual.
- **[[wiki/concepts/attention.md]]** — a second, sharper contact: putting precision on the superficial pyramidal cell's gain makes attention a multiplier on the *error* channel, which predicts the observed sign flip (unpredicted stimuli raise the response when unattended, lower it when attended) that no selection-only account of this circuit produces.
- **[[wiki/concepts/precision-weighting.md]]** — what the `Π` on the superficial pyramidal gain *is*: a third represented quantity alongside states (activity) and parameters (efficacy), inferred by the same gradient descent and necessarily on a slower timescale than the activity it scales (Friston 2009).
- **[[wiki/entities/spiking-neural-networks.md]]** — the computational model built *for* this anatomy: the liquid state machine is a sparsely connected recurrent spiking reservoir with the cortex's ~80:20 excitatory:inhibitory ratio and distance-decaying connection probability, proposed as what the minicolumn computes — and NeuCube is the rival claim that reservoir properties belong to the *macro*-scale connectome (DTI/fMRI) rather than to this circuit, which is a testable disagreement about the level at which the motif repeats (Tavanaei et al. 2019).
- **[[wiki/entities/liquid-state-machine.md]]** — the computational proposal for this anatomy, stated as a theorem plus a simulation: a 135-neuron 80:20 excitatory/inhibitory column with distance-decaying connectivity and measured Tsodyks–Markram synapse statistics is used as an untrained filter, and the paper's cortical reading is that neighbouring columns are each other's **readouts**, every column serving both roles. Its `λ` sweep also gives this page's connectivity statistic a computational score rather than an anatomical one — mostly local plus a few long-range beats both extremes.
- **[[wiki/concepts/mean-field-reduction.md]]** — supplies the coarse-grained form of this circuit: a neural mass indexes populations by a subscript that names both the structure and the cell type (pyramidal, interneuron), sums synaptodendritic subpotentials linearly at the soma, and converts them to a firing rate through a sigmoid whose width *is* the population's threshold distribution — so this page's cell-class inventory becomes the state vector of a whole-brain model, and its connectivity statistics split into a translation-invariant intracortical kernel (≤1 cm, unmyelinated) and a patchy corticocortical one (up to 20 cm, 50–100 ms delays) that the field equation must treat separately (Deco et al. 2008).
- **[[wiki/concepts/effective-connectivity.md]]** — where this circuit became the state vector of an *estimator*: the current Dynamic Causal Model for fMRI puts four coupled populations per region, with inter- and intra-laminar connections and two hidden states each, in place of the abstract bilinear graph — so laminar connection strengths become quantities fitted to imaging data rather than anatomical priors (Friston et al. 2019, in Li & Yap 2022).
- **[[wiki/concepts/broadcast-hierarchy.md]]** — the second laminar hierarchy metric and what it buys: laminar differentiation grades an area by its own layering rather than by its projections' origins, and the laminar type rule that comes with it (similar profiles connect) converts hierarchical depth from a coordinate into a coupling-eligibility constraint, which is how a deep system can nevertheless be a heterarchy.
- **[[wiki/concepts/microarchitectural-topography.md]]** — where the laminar-type coupling rule stops coinciding with locality: on a smooth cytoarchitectural gradient the type-matched partner is the spatial neighbour, on an interdigitated patch it is the next-but-one patch, which is the pattern prefrontal tract-tracing reports.
- **[[wiki/concepts/transthalamic-context-routing.md]]** — the measurement this page's open transthalamic question was waiting for, and a partial answer that changes the question: the disynaptic mirror of a feedforward edge (V1→LP→PM) does not carry re-typed content but the sender's arousal state, since silencing it leaves the target's visual responses near-intact and deletes its pupil-linked modulation — so the feedforward/feedback typing may not apply to the transthalamic route at all (Neske & Cardin 2025, [[wiki/empirical-tensions.md]] T276) — and the anatomical typing is itself target-relative, since matrix-type (higher-order) nuclei modulate primary cortex through L1 while the same class drives *secondary* sensory cortex through L4 (Harris & Shepherd 2015).
- **[[wiki/entities/early-visual-system.md]]** — the functional readout of this circuit at the one place it has been modelled quantitatively, and the number that frames the contextual-modulation problem: ~60–80% of a layer-4 V1 cell's response variance is contributed by other V1 neurons or by non-geniculate input, so the feedforward drive this page types so carefully is a minority shareholder in the response it is supposed to explain (Olshausen & Field 2005, in Carandini et al. 2005).
- **[[wiki/entities/ventral-visual-stream.md]]** — a *functional* proposal for a unit deliberately an order of magnitude larger than this page's circuit: a ~500 µm, ~40K-neuron, ~10K-in/~10K-out dimensionality-preserving block, on the argument that the canonical microcircuit is too small to have a population-level job description at all.
- **[[wiki/concepts/neuron-complexity-index.md]]** — multiplies this page's stage count and then freezes most of the product: fitting one L5 pyramidal cell's I/O needs 5–8 network layers, so a circuit's computational depth is `~5–8 ×` its anatomical depth, but only the synaptic (between-cell) layers are plastic. It also makes the layer-1 feedback channel conditional on a receptor: with NMDA deleted, apical tuft synapses carry *zero* weight in every fitted filter even though nexus Ca²⁺ spikes still occur (Beniaguev et al. 2021).
- **[[wiki/concepts/timescale-hierarchy.md]]** — the dynamical payoff of this page's SLN% coordinate: scaling every area's recurrent excitatory gain by `(1 + η h_i)` along the SLN-derived hierarchy, on a weighted directed macaque connectome, generates time constants from tens of milliseconds to seconds — and the same coordinate correlates with layer-3 pyramidal spine count, which is the anatomical quantity the gradient is a proxy for (Chaudhuri et al. 2015).
- **[[wiki/concepts/intrinsic-timescale-measurement.md]]** — the dynamical validation of this page's laminar depth coordinate: the discrete hierarchy defined by laminar patterns of long-range projections predicts the measured ordering of areal time constants at `r_s = 0.97` across seven macaque areas, with orbitofrontal cortex the single area where laminar rank and physiological rank come apart.
- **[[wiki/concepts/prediction-error-neurons.md]]** — the rival cell-class assignment on the same lamination, built from mouse closed-loop physiology instead of from the equations: it splits this page's single L2/3 error population in two by sign and demotes L2/3 interneurons from *encoding a variable* to *relaying the drive a comparator subtracts*, so the two schemes predict opposite effects of silencing the same cells.
- **[[wiki/concepts/displacement-codes.md]]** — a functional reading of two edges this page leaves uninterpreted, and a direct challenge to a third: L6a→L4 plus L4→L6a (~45% of L4's synapses, narrow arbor) becomes the feature×location binding loop, and the L5 thick-tufted branch to higher-order thalamus becomes a composite-object representation rather than the efference copy Guillery & Sherman read it as (`T344`, Hawkins et al. 2019).
- **[[wiki/entities/a24b-m2-v1-projection.md]]** — a measured laminar termination pattern to test this page's feedback assignment against: dense axons in L1 and L6, main postsynaptic targets L2/3 excitatory, L6 excitatory and PV interneurons, monosynaptic responses in 85%/73%/73% of L1/L2/3/L6 cells against 8% in L5 and 0% in L4 — a real feedback projection's port list, with the input layer excluded.
- **[[wiki/concepts/complementary-learning-systems.md]]** — puts a time axis on this page's laminar assignment: as a memory consolidates, the population activated at recall shifts from the deep tier into layers II–III/IV, so layer identity indexes the *age* of the content being read as well as the direction of the signal.
- **[[wiki/concepts/apical-amplification.md]]** — reads this page's laminar rule as the wiring of a cellular AND gate: middle-layer feedforward input and layer-1 feedback are delivered to the two spike-initiation zones of one L5 pyramid, so the "crowning mystery" layer is a data port whose payload is multiplied into the cell's own drive; it also makes the feedback edge non-hierarchical, since layer-1 horizontal fibres carry input from many higher areas and from thalamus onto every level at once (Larkum 2013, `T259`).
