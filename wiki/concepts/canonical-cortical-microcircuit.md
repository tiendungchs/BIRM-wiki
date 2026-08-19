# Canonical Cortical Microcircuit

**The same laminar wiring diagram — thalamus → L4 → L2/3 → L5 → L6 → L4, with feedforward output from L2/3 and feedback from L5/6 — is found wherever it has been looked for, across areas with utterly different functions and across species separated by 135 million years. If cortex runs one algorithm, this graph is its pseudocode, and the algorithm it suggests is *explore interpretations in the superficial layers, commit to one in the deep layers*.**

Every "cortical column" claim the wiki leans on — columns as reference-frame units voting on object identity ([[wiki/concepts/distributed-reference-frames.md]]), the uniformity argument that licenses importing a hippocampal or visual mechanism into a general architecture ([[wiki/concepts/inhibitory-control-of-coding.md]]) — presupposes that there *is* a canonical circuit. This page holds the anatomy those claims cash out to, and the numbers.

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

---

## Connections

- **[[wiki/concepts/distributed-reference-frames.md]]** — supplies the circuit that theory presupposes and never specifies: "columns vote on a consistent pose" becomes soft winner-take-all among superficial pyramids, with lateral patches carrying the vote between columns and L5 feedback carrying it between areas; it also supplies the uniformity evidence that whole argument rests on.
- **[[wiki/concepts/dendritic-computation.md]]** — the anatomy that makes the apical/basal split load-bearing: feedback and subcortical input terminate in layer 1 on distal apical tufts while drive arrives on basal and proximal compartments, so the prediction channel and the evidence channel are physically separated at the level of wiring, not just of theory.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the same interneuron populations sorted by a different criterion: that page splits them by transcriptomic family and assigns each a *code feature*, this one splits them by axon geometry and assigns each a *computational role* (perisomatic → selection, dendritic → transfer-function control) — and adds that which channels reach a cell is set by its layer, which is a wiring answer to that page's open "what sets the gains" question.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the laminar substrate that hierarchy assumes: feedforward from L2/3 into L4 of the area above, feedback from L5/6 into layer 1 below, with the SLN% distance rule making hierarchical depth a measurable continuous quantity rather than a stipulated layer index.
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
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — what the motif buys if the laminar loop is a learning circuit: the dendritic-error model needs exactly this wiring — feedback onto distal apical tufts, plus a vertically-projecting interneuron (Martinotti-like) that learns to cancel it — so an error term appears in the apical compartment with no dedicated error cell, and the model's unpaid debt is a one-to-one pyramidal→interneuron mapping this anatomy does not supply.
