# Hippocampal Formation — the Store as a Circuit, Indexed

**The dentate gyrus, the CA fields and the subicular complex, with the entorhinal cortex as their only cortical gateway: one repeated trisynaptic circuit laid along a long axis, with a write port and a read port into the same recurrent field, an output stage typed by destination, and a return loop that carries a copy of its own write. The wiki holds this structure node by node and operation by operation on some thirty pages; this page is the index of those pages — which stage each one owns, where the registries pivot on the structure, and what no page holds yet.**

> **Epistemic status.** A hub, not an ingest. Every statement below is held by the page it names, and the number, species and caveat live there. **One exception:** the section *Edges the diagram omits* is held here, from van Strien, Cappaert & Witter 2009 (`raw/vanstrien-2009-anatomy-of-memory-parahippocampal-hippocampal-network.md`), with its functional transverse-axis table from Knierim & Neunuebel 2016 (`raw/knierim-2016-tracking-flow-hippocampal-computation.md`). It needs a hub because no stage page owns the edges that run *between* stages against the standard direction. Written because [[wiki/index-entities.md]] had carried "Hippocampus / medial temporal lobe" as referenced-but-not-paged while the structure was being cited on 157 pages, and because three `L1` tensions (`T28`, `T107`, `T203`) and the brain-candidate column of [[wiki/concepts/abstraction-graph.md]] turn on what "the hippocampus" is taken to include.

**Node definition.** Whether the entorhinal cortex belongs to the formation is a convention, not a fact, and the subiculum's own borders are disputed by the atlases ([[wiki/entities/subiculum.md]], [[wiki/concepts/node-definition-problem.md]]). This page includes the entorhinal cortex because every edge in and out of the store passes through it, and names the subicular complex (subiculum, presubiculum, parasubiculum, postsubiculum) as the exit. Primate orientation: the rodent dorsal → ventral axis is the primate posterior → anterior axis after a ~90° rotation ([[wiki/concepts/hippocampal-long-axis.md]]).

---

## Anatomy: one circuit, the pages that hold each stage

| Stage | What the wiki holds about it | Owning page |
|---|---|---|
| **Input stack** (perirhinal → parahippocampal → entorhinal) | Three association stages with their own intrinsic networks, so cross-modal mixing is finished before the store sees anything; the return is a broadcast, not cell-for-cell | [[wiki/concepts/hierarchy-of-associativity.md]], [[wiki/entities/perirhinal-cortex.md]] |
| **Entorhinal cortex** | Lateral vs medial as a fan-in difference over one circuit type; layer II (reelin⁺ → dentate/CA3, calbindin⁺ → CA1) with no stellate–stellate excitation; layer III → CA1/subiculum (temporoammonic); layer Vb as the comparator holding the hippocampal return plus a copy of the write; the grid torus | [[wiki/entities/entorhinal-cortex.md]] |
| **Dentate gyrus** | Expansion recoding and the separation front end; slope-vs-threshold (`T393`); adult neurogenesis as a separation and a clearance mechanism; hilar mossy cells and HIPP interneurons as the knob's actuators; the competitive-network capacity account | [[wiki/concepts/pattern-separation-completion.md]], [[wiki/entities/rolls-treves-hippocampal-model.md]], [[wiki/concepts/complementary-learning-systems.md]] |
| **CA3** | The diluted autoassociator with two addressed inputs: mossy-fibre write port, direct perforant-path read port; the capacity equations; the attractor seeded by the weakest afferent; discrete-vs-rate remapping set upstream by path-integrator coordinates; the symmetric STDP kernel that makes forward and reverse replay one weight matrix | [[wiki/entities/rolls-treves-hippocampal-model.md]], [[wiki/concepts/pattern-separation-completion.md]], [[wiki/concepts/attractor-dynamics.md]], [[wiki/concepts/offline-replay.md]] |
| **CA1** | No page of its own; three functions assigned across three pages (`T33`): linear relay, recombiner, sparse invertible decoder holding the learned return address; the one-shot BTSP rule; interneuron families as per-feature gain channels; the population manifold on which theta sequences are paths; the excitability-tagged allocation that cortex can override at a 7-day interval | [[wiki/concepts/complementary-learning-systems.md]], [[wiki/concepts/hippocampal-indexing-theory.md]], [[wiki/concepts/synaptic-plasticity.md]], [[wiki/concepts/inhibitory-control-of-coding.md]], [[wiki/concepts/population-geometry.md]], [[wiki/concepts/memory-allocation-excitability.md]] |
| **Subicular complex** | The exit partitioned by destination as a wiring fact: proximal class → accumbens, medial prefrontal, lateral entorhinal; distal class → retrosplenial, medial entorhinal, ventral thalamus; deep ovoid cells → anterior thalamus; each head broadcasting to a fixed suite; theta originating here and propagating backward. Pre-/para-/postsubiculum carry head-direction cells inside the formation | [[wiki/entities/subiculum.md]], [[wiki/entities/head-direction-system.md]], [[wiki/entities/dorsal-visual-stream.md]] |
| **Long axis** | A smooth connectivity-and-scale gradient superimposed on discrete gene-expression domains, with the association-fibre and theta-coherence seam at 2/3–1/3; the ventral end wired to the controller, the dorsal end to the Papez routes | [[wiki/concepts/hippocampal-long-axis.md]] |

---

## Signal flow: every edge with the page that owns it

```
 neocortex ──► perirhinal / parahippocampal ──► entorhinal II/III ──┐   [hierarchy-of-associativity]
                                                                     │
          ┌── II reelin⁺ ──► dentate ──mossy fibres──► CA3 ◄──┐      │   [pattern-separation-completion,
          │                                         (write)   │      │    rolls-treves-hippocampal-model]
          ├── II reelin⁺ ─────────────────────────► CA3 (read)│      │
          │                                           │ Schaffer      │
          ├── III ──temporoammonic──► CA1 ◄───────────┘              │   [entorhinal-cortex, complementary-
          │                            │                             │    learning-systems §3]
          │                            ▼                             │
          │                        subiculum ──► Vb ──► Va ──► cortex    [entorhinal-cortex: Vb holds the
          │                            │          ▲ (copy of the write)   return + a copy of what II sent]
          │                            │          └──► II/III
          ▼                            ▼
 CA1 ──► entorhinal (learned return address, written at encoding)        [hippocampal-indexing-theory]
                                       │
          ┌────────────────────────────┼───────────────────────────────┐
          ▼                            ▼                               ▼
 proximal class ──► accumbens,   distal class ──► retrosplenial,   deep ovoid ──► anterior thalamus
 medial prefrontal,              medial entorhinal, ventral        middle layer ──fornix──► mammillary
 lateral entorhinal              thalamus                          bodies ──► anterior thalamus
 [subiculum,                     [subiculum,                       [subiculum, hippocampal-diencephalic-
  hippocampal-prefrontal-channel] retrosplenial-cortex]             cingulate-network, mammillary-bodies]
```

**Controls on the circuit, by source and target.**

| Control | Enters at | What it sets | Page |
|---|---|---|---|
| Medial-septal acetylcholine | CA3 recurrents | Recurrent read-out gain down, recurrent learning rate up: the write/read mode scalar | [[wiki/entities/rolls-treves-hippocampal-model.md]] |
| Theta (4–8 Hz) | Whole structure | Encoding on one half-cycle, retrieval on the other; the two half-cycles as the phases of an error-driven rule. Within a cycle, 5–9 gamma-length assemblies are kept apart by perisomatic inhibition and ordered past → current → future, with lag ∝ distance. The carrier is intermittent in primates and absent in bat place and grid cells (Buzsáki & Moser 2013) | [[wiki/concepts/encoding-retrieval-alternation.md]], [[wiki/concepts/temporal-coding.md]] |
| CA3 → dentate backprojection | Mossy cells, HIPP interneurons | Closed-loop separation bias: how well CA3 completed sets how hard the dentate separates next | [[wiki/concepts/pattern-separation-completion.md]] |
| Ventromedial prefrontal → medial entorhinal | Entorhinal gateway | Write geometry: how much a new episode's dorsal-CA1 ensemble may overlap a prior one, switched on only once the cortical trace has matured | [[wiki/concepts/memory-allocation-excitability.md]], [[wiki/concepts/complementary-learning-systems.md]] |
| Medial prefrontal → perirhinal / lateral entorhinal deep layers | Input gateway | Top-down control applied to the interface, not the store (`G110`); costs the store one factor of its conjunctive code | [[wiki/entities/hippocampal-prefrontal-channel.md]] |
| Nucleus reuniens | CA1 | The controller's only indirect route in: a goal-conditioned trajectory, with single neurons collateralising to both endpoints | [[wiki/entities/nucleus-reuniens.md]] |
| Anterior cingulate → dorsal CA1/CA3 | Learned hub neurons | The direct return arrow: a retrieval trigger addressed by the target's degree | [[wiki/entities/hippocampal-prefrontal-channel.md]] |
| Amygdala | Hippocampal → prefrontal edge | A lock on that edge's writability, outside both endpoints (`G52`) | [[wiki/entities/hippocampal-prefrontal-channel.md]] |
| Cortical slow oscillation → thalamic spindle | Ripple timing and content | When the consolidation window is open; the cortical pre-ripple pattern tells the store which memory to reactivate | [[wiki/concepts/sleep-oscillation-nesting.md]], [[wiki/concepts/offline-replay.md]] |
| Anterior thalamic nuclei | Subiculum | Spatial firing throughout the subiculum depends on them, CA1 spared | [[wiki/entities/anterior-thalamic-nuclei.md]] |

---

## Edges the diagram omits

> van Strien, Cappaert & Witter 2009, Nat Rev Neurosci 10:272–282. Rat. The tracer literature compiled into ~1,600 connections and compared with the "standard model" that recent key studies use. The diagram above is that standard model plus the entorhinal loop. The source's warning: connections left out of models because they seem to have no function "tend to be erased from the common scientific memory". Density is shown as uniform, and sign is mostly unknown.

**Backprojections — the circuit is not unidirectional.**

| Edge | Origin → termination | Sign | Owning page |
|---|---|---|---|
| CA3 → dentate gyrus | CA3 pyramidal cells → hilus and inner molecular layer, at every septotemporal level, **strongest temporally** | Excitatory (principal cells) | [[wiki/concepts/pattern-separation-completion.md]] (the closed-loop separation controller) |
| CA1 → CA3 | Stratum radiatum / oriens of CA1 → the same strata of CA3 | **Probably inhibitory.** It does not come from the pyramidal layer, and *in vivo* labelling finds CA1 GABAergic neurons with the same origin and termination | — |
| Subiculum → CA1 | Subicular pyramidal layer → all layers of CA1 | **Unknown** | [[wiki/entities/subiculum.md]] |

**Recurrent fields — CA3 is not the only one.**

| Field | Loop | Extent |
|---|---|---|
| Dentate gyrus | Granule cell → several hilar mossy cells → back to granule-cell dendrites in the molecular layer | — |
| CA3 | Recurrent collaterals | The best known, the most extensive |
| CA1 | Recurrent loops | **Confined to one septotemporal level**, against "almost none" in [[wiki/concepts/hierarchy-of-associativity.md]] |
| Subiculum | Principal-cell collaterals onto pyramidal cells and interneurons | Spread over a large part of the subiculum *ventral* to the cell of origin |

**Bypasses — the trisynaptic path is not the only way in or out.**

| Edge | What it skips |
|---|---|
| Presubiculum, parasubiculum (all layers) → dentate gyrus, CA3, CA1, subiculum | The entorhinal cortex |
| Perirhinal (areas 35, 36), postrhinal → CA1, subiculum (postrhinal possibly to every field; the reports disagree) | The entorhinal cortex |
| Entorhinal layers III, V, VI → dentate gyrus. Layers II, V, VI → CA1/subiculum | The laminar in/out rule ([[wiki/entities/entorhinal-cortex.md]]) |
| CA1, subiculum → superficial entorhinal layers | Layer V |
| CA3, CA1, subiculum → pre-/parasubiculum. CA1, subiculum → perirhinal, postrhinal | The entorhinal cortex, on the way out |

**Inhibitory long-range coupling, inferred from layer of origin.** A projection that does not start in a principal-cell layer is probably GABAergic. The rule is checked on CA1 → CA3 (above) and on CA1 stratum-radiatum cells → dentate molecular layer and subiculum, where GABAergic axons are reported. Applied to the rest of the diagram, it flags four more edges: dentate hilus → CA1; subicular molecular layer → para-/presubiculum and postrhinal cortex; CA1 strata oriens/radiatum → both entorhinal divisions; subicular molecular layer → both entorhinal divisions. The proposed job is to couple the subregions and coordinate oscillations across the whole network. That would be a set of **timing wires anatomically separate from the content wires** (`G54`). But the inhibitory identity is inferred, and so is the job.

**Two transverse channels on the direct path, one mixed channel on the trisynaptic path.**

| Stage | Lateral-entorhinal (non-spatial) input | Medial-entorhinal (spatial) input |
|---|---|---|
| Dentate gyrus, CA3 | Same cells, outer / superficial dendritic band | Same cells, middle / deep band |
| CA1 | Distal | Proximal |
| CA3 → CA1 (Schaffer) | Proximal CA3 → distal CA1 | Distal CA3 → proximal CA1 |
| CA1 → subiculum | Distal CA1 → proximal subiculum | Proximal CA1 → distal subiculum |
| CA1, subiculum → entorhinal | Distal CA1, proximal subiculum → lateral | Proximal CA1, distal subiculum → medial |

The segregation survives from the entorhinal cortex through CA1 and the subiculum and back. Only the dentate/CA3 stage puts both streams on one cell. The predicted consequence is that proximal CA1 is more spatial than distal CA1, and distal subiculum more spatial than proximal. CA1 has this in preliminary data (an abstract, McNaughton et al. 2008). The subiculum shows only a small difference (Sharp & Green 1994), which the authors attribute to its recurrent network re-mixing the streams. They also propose that CA1 is split into **subdomains** along both axes, each storing its own combination of inputs independently (`T33`). Untested.

**The transverse channels show up in function, under cue conflict** (Knierim & Neunuebel 2016, `raw/knierim-2016-tracking-flow-hippocampal-computation.md`, [[wiki/concepts/pattern-separation-completion.md]]).

| Stage | Behaviour under local-global cue conflict | Wiring read |
|---|---|---|
| Proximal CA3 (inside the dentate blades) | Separates, like the dentate gyrus (Lee et al. 2015) | Sparsest recurrent collaterals. Projects to distal (lateral-typed) CA1 |
| Intermediate/distal CA3 | Completes to the local frame | Densest recurrent collaterals. Projects to proximal (medial-typed) CA1 |
| CA2 | Like distal CA3 (Lee et al. 2015; Lu et al. 2015) | — |
| Proximal CA1 | Split: fields follow local or global cues in about equal numbers, and some fields split in two (Lee et al. 2004) | Distal CA3 (local, completed) plus medial entorhinal (global). Output to deep medial entorhinal cortex |

This is the first functional evidence for the brainstorm above. Proximal CA1 receives what the binder recalled (distal CA3) and what the medial stream says now. It sends both on rather than resolving them. A comparison has been proposed, not demonstrated. Distal CA1 has not been recorded under this protocol.

**(brainstorm) The reading for a builder.** The formation runs two codes in parallel. One is stream-typed, in which a reader can tell from transverse position which input stream a CA1/subiculum cell came from. The other is stream-mixed, in which a dentate/CA3 reader cannot. CA1 is where the two meet: each CA1 cell receives a mixed CA3 code plus one *typed* direct input, and which part of CA3 it hears is set by the transverse mapping. That makes CA1 a per-stream comparator between "what the binder recalled" and "what this stream says now". It is a narrower job than any of `T33`'s three positions. It is also a narrower version of the layer Vb comparator one stage on ([[wiki/entities/entorhinal-cortex.md]]).

---

## Computational role: operations, and the stage each is assigned to

| Operation | Stage | What the wiki has established | Page |
|---|---|---|---|
| Expansion and separation | Entorhinal → dentate → CA3 | A transfer-function knob, not a region label; five decorrelation mechanisms, the distinctive one being randomisation by the mossy fibres rather than a similarity-reducing map | [[wiki/concepts/pattern-separation-completion.md]], [[wiki/entities/rolls-treves-hippocampal-model.md]] |
| One-shot write | CA3 recurrents; CA1 by dendritic plateau | Write and read use different inputs into the same recurrent field, so the store never chooses between separation and completion globally; BTSP writes a whole field in one event, more strongly in novel environments | [[wiki/entities/rolls-treves-hippocampal-model.md]], [[wiki/concepts/synaptic-plasticity.md]], [[wiki/entities/btsp-cam.md]] |
| Allocation (which cells) | CA1, amygdala | A cell-wide excitability tag with an hours-long time constant makes temporal proximity the allocation prior; cortex adds a content-sensitive term through the entorhinal cortex | [[wiki/concepts/memory-allocation-excitability.md]] |
| Completion from a fragment | CA3 attractor | Completion holds against a destroyed dentate input; the attractor is placed by the weaker, lateral-entorhinal afferent; whether the place code is an attractor at all is `T389` | [[wiki/concepts/pattern-separation-completion.md]], [[wiki/concepts/attractor-dynamics.md]], [[wiki/concepts/attractor-identification.md]] |
| Map switching | Upstream of the dentate | Discrete vs rate remapping is set by whether the enclosures received different path-integrator coordinates at first encounter, not by input similarity; the rival reading is a posterior over hidden states (`T394`) | [[wiki/concepts/cognitive-map.md]], [[wiki/entities/hidden-state-inference-remapping.md]], [[wiki/concepts/path-integration.md]] |
| Indexing and the return address | CA1 → entorhinal | The index records which cortical modules were coactive and nothing about content; the return address is learned in the same event as the write; the index addresses association cortex, not all of neocortex | [[wiki/concepts/hippocampal-indexing-theory.md]] |
| Sparse read-out to cortex | CA1 → entorhinal → reverse hierarchy | A dense decoder returns the interference the encoder removed, so CA1 must be a sparse invertible codec and the backprojection polysynaptic with gradual fan-out (`G97`) | [[wiki/concepts/complementary-learning-systems.md]] |
| Binding across a window | Long axis, theta | Phase precession compresses a trajectory into one theta cycle; wider ventral fields and slower theta let non-adjacent assemblies bind, the proposed substrate of transitive inference | [[wiki/concepts/hippocampal-long-axis.md]], [[wiki/concepts/temporal-coding.md]] |
| Encoding against what is retrieved | Whole store at write time | The unobserved `A–C` path is written before it is queried | [[wiki/concepts/retrieval-mediated-learning.md]] |
| Inference by recirculating the output | Entorhinal deep → superficial → dentate/CA3, at test | The unobserved `A–C` path is composed at the query by feeding the store's output back as input; human 7 T data place the loop inside entorhinal cortex and its strength predicts inference (`T334`) | [[wiki/entities/remerge.md]], [[wiki/entities/entorhinal-cortex.md]] |
| Offline selection | CA3 sequence generation, CA1 ripples | Replay is filtered, resampled and sometimes never observed; the filter is plasticity at inhibitory synapses; replay composes vector-cell blocks onto unvisited locations; awake ripples tag, sleep ripples transfer | [[wiki/concepts/offline-replay.md]], [[wiki/entities/inhibitory-replay-filter.md]], [[wiki/entities/state-space-composition.md]], [[wiki/concepts/replay-prioritisation.md]] |
| Consolidation gating | Fast store ↔ cortex | Write to the slow store only what the fast store already recalls; stop at minimum held-out error; the fast store must survive intact for about a week; the cuttable wire is the temporoammonic path | [[wiki/concepts/recall-gated-consolidation.md]], [[wiki/concepts/generalization-optimized-consolidation.md]], [[wiki/concepts/complementary-learning-systems.md]], [[wiki/concepts/schema-assimilation.md]] |
| Context to the controller | Ventral CA1/subiculum → medial prefrontal | The controller receives context, not position, because its input leaves the wide-field end of the axis; the edge has its own state | [[wiki/entities/hippocampal-prefrontal-channel.md]], [[wiki/entities/medial-prefrontal-cortex.md]] |
| Heading and recollection to the diencephalon | Subiculum → fornix → mammillary → anterior thalamus | Two efferent routes reconverging on the anterior thalamus, branching at the cell of origin; recollection runs this route while familiarity does not | [[wiki/entities/hippocampal-diencephalic-cingulate-network.md]], [[wiki/entities/mammillary-bodies.md]], [[wiki/concepts/recollection-familiarity.md]] |
| Beyond space | Same circuit | Fourteen non-spatial domains with the map's signatures, and the one element with no non-spatial version | [[wiki/concepts/nonspatial-maps.md]] |

**What the formation does not compute.** Item familiarity is a perirhinal repetition decrement readable before the store responds, and the store signals arrangement novelty instead ([[wiki/concepts/recollection-familiarity.md]], [[wiki/entities/perirhinal-cortex.md]]). Heading is generated below the store and delivered to it ([[wiki/entities/head-direction-system.md]]). The egocentric-to-allocentric transform is retrosplenial ([[wiki/entities/retrosplenial-cortex.md]]). Cross-modal mixing is done upstream ([[wiki/concepts/hierarchy-of-associativity.md]]).

---

## Where the registries pivot on this structure

| Row | What the formation decides | Status |
|---|---|---|
| `T28` | Map (edges between hippocampal cells) or index (conjunctions binding cortical codes); the proposed schedule is map in novel structure, index once cortex has structured that world | `LEANING` |
| `T33` | CA1 as relay, recombiner, or learned invertible decoder | `LIVE` |
| `T107` | Whether the graph a plan runs on is here or in the cortical controller | `LIVE` |
| `T203` | Whether abstract format is a hippocampal specialisation or shared with prefrontal cortex | `LIVE` |
| `T340` | Whether the store returns its output to the stream that wrote it; reciprocity holds as anatomy at the subiculum, and the two functional studies find stream-crossing | `LIVE` |
| `T381` | Whether the diencephalic route is a relay or a second stream; the branch point is at the subicular cell of origin | `LIVE` |
| `T389` / `T394` | Attractor or feedforward conjunction; hidden-state posterior or preconfigured coordinates | `LIVE` |
| `T393` | Dentate separator as slope or threshold | `LIVE` |
| `T407` | Familiarity as a read of the store or a module that survives it | `LIVE` |
| `T100` | Which task phase the hippocampal → prefrontal channel is needed at; the distal subicular class is needed for encoding and not retrieval | `LIVE` |
| `T82` / `T97` | Permanent hippocampal dependence as optimal refusal or transport failure; whether the controller holds a memory from the start | `LIVE` / `LEANING` |
| `G2` | De-aliasing by sparse conjunctive codes, without a hand-built state space | `PARTIAL` |
| `G14` | The consolidation channel: part of its selectivity is wiring at the subicular exit, the rest is gating | `PARTIAL` |
| `G37` / `G38` | Which stored structure applies; what sets the separation/completion bias, with four candidate controllers and no controller for the controller | `PARTIAL` |
| `G39` | Anchoring a retrieved structure: the anchor is delivered from below the store, and the chart deforms while the grid torus does not | `OPEN` |
| `G52` / `G110` | An inter-module edge with its own state; control applied to the interface rather than the module | `OPEN` |
| `G97` | A sparse decoder between the store and the model | — |
| `G122` | Mixed vs projection-typed afferents, measured at the subiculum with neither extreme holding | `OPEN` |

---

## How it maps to model components

Per [[wiki/concepts/abstraction-graph.md]], a computational model is a reference for how a requirement row was approximated, not a component. The rows the formation is the brain candidate for: **2a** (binder for ground facts), **9** (provenance by reinstating the intermediary), **11** (one-shot write for ground facts), and the store rows of the holding-state table (labile and durable episodic index); it is one leg of **6** through its input gateway, and the thing row **13**'s slow store is complementary to.

| Model | Stage of the circuit it realises | What it omits, per its own page |
|---|---|---|
| [[wiki/entities/rolls-treves-hippocampal-model.md]] | Dentate competitive net → mossy randomisation → diluted CA3 autoassociator → reverse hierarchy of pattern associators, with closed-form capacities | Measured CA3 connectivity is higher than assumed; CA1 as recombiner is one side of `T33` |
| [[wiki/entities/tolman-eichenbaum-machine.md]] | Hippocampus as index: conjunction of a path-integrating structural code with sensory codes, trained on prediction across worlds | The entorhinal interface as a pair of one-way wires, where the tissue has the Vb loop with a copy of the write |
| [[wiki/entities/vector-hash.md]] | Frozen grid states randomly projected into hippocampus, giving pre-built attractors; content hung on by a separate plastic layer | — |
| [[wiki/entities/cscg.md]] | Hippocampus as map: clone pools per observation, transitions learned by local rules, matched to the dorsal-CA1 learning trajectory | Transfer across environments only by hand-freezing the transition matrix |
| [[wiki/entities/btsp-cam.md]] | CA1 one-shot binary-weight write under a stochastic plateau gate, no recurrence | — |
| [[wiki/entities/spiking-hippocampal-cam.md]] | CA3-inspired content-addressable memory with a reverse read and an operation code recovered from timing | One-hot cue makes capacity equal cue count |
| [[wiki/entities/inhibitory-replay-filter.md]] | CA3 model whose inhibitory plasticity selects what ripples replay, tested by implanting representations | Generation and selection are separate questions |
| [[wiki/entities/state-space-composition.md]] | Hippocampal state space assembled at entry from cortical vector-cell blocks; replay writes it to unvisited locations | — |
| [[wiki/entities/hidden-state-inference-remapping.md]] | Remapping as a posterior over which hidden state generated the observations | Theory only; `T394`'s rival is the coordinate-binding account |
| [[wiki/entities/remerge.md]] | Localist dentate gyrus–CA3 conjunctive units read through the entorhinal big loop, iterated to settling; the loop's deep → superficial arm is measured in humans | Learning is not modelled; nothing selects which traces enter the loop in a large store |
| [[wiki/entities/temporal-context-model.md]] | One leaky integrator yielding the entorhinal place code and free-recall contiguity, with hippocampus reinstating past context | — |
| [[wiki/entities/bb-model.md]] | Place-cell attractor and grid module behind a retrosplenial transform bank | Silencing the bank should leave boundary-anchored entorhinal responses uninstantiated; inactivation finds them intact (`T383`) |
| [[wiki/entities/spiking-tem.md]], [[wiki/entities/mm-tem-hippoformer.md]], [[wiki/entities/tem-transformer.md]] | The index factorisation rebuilt in spiking, multimodal and attention form | — |
| [[wiki/entities/thousand-brains-theory.md]] | The formation's what/where binding miniaturised and replicated per cortical column | No equation, simulation or result |

**What is architecturally denied to a reader of this store** (`L2`). Modality of origin is mixed away upstream, so a reader cannot recover which sense an index came from. **Stream** of origin (lateral vs medial entorhinal) survives one stage further, and only on the direct path: a CA1 or subicular reader can recover it from transverse position, and a dentate/CA3 reader cannot (*Edges the diagram omits*). **A conflict between frames** is erased at distal CA3, whose attractor settles on one frame. It survives in proximal CA1, which carries both. So only a reader downstream of CA1 can detect that the inputs disagreed (Knierim & Neunuebel 2016). Item novelty is not signalled by the store. The controller cannot address the store except through the entorhinal cortex or the reuniens. Consumers within one subicular output suite cannot be addressed separately. The medial prefrontal cortex receives context and no position, because its input leaves the wide-field end of the axis. Beyond the entorhinal cortex, reinstatement reaches a partly different population from the one that wrote, so the return is re-synthesis rather than addressing.

---

## Not held in the wiki

| Missing | Where the nearest material sits |
|---|---|
| A dentate gyrus page | Held inside [[wiki/concepts/pattern-separation-completion.md]] and [[wiki/entities/rolls-treves-hippocampal-model.md]] |
| A CA1 page | Spread across the `T33` pages; the three CA1 functions have never been compared in one place. CA1's own recurrent loops, its transverse stream typing and the subdomain proposal are in *Edges the diagram omits* |
| CA2 | Two incidental mentions ([[wiki/entities/inhibitory-replay-filter.md]], [[wiki/concepts/inhibitory-control-of-coding.md]]), plus one second-hand functional datum: it behaves like distal CA3 under cue conflict (*Edges the diagram omits*). No source on its social-memory or sequence role |
| Medial septum as theta generator | Named as the cholinergic mode switch; no page on the pacemaker or on theta's own origin, which [[wiki/entities/subiculum.md]] contests |
| Sharp-wave ripple generation | Ripple content is paged; the CA3 → CA1 generation mechanism is not |
| Pre-, para-, postsubiculum | Inside [[wiki/entities/head-direction-system.md]], [[wiki/entities/subiculum.md]], [[wiki/entities/dorsal-visual-stream.md]] |
| Fornix lesion record | Listed as unpaged in [[wiki/index-entities.md]]; the tract is traced edge by edge on [[wiki/entities/hippocampal-diencephalic-cingulate-network.md]] |
| Time cells and theta sequences as objects | No page. Theta-sequence mechanics are on [[wiki/concepts/temporal-coding.md]]. Time tracking by self-generated sequences, and re-timing when the delay changes, is on [[wiki/concepts/path-integration.md]]. Mentions on [[wiki/concepts/offline-replay.md]] and [[wiki/concepts/working-memory.md]] |

---

## Connections

- **[[wiki/entities/entorhinal-cortex.md]]** — the gateway this page includes in the formation by convention: every edge in and out of the store passes through its layer II/III write and its layer Vb return, so the formation's interface is that page's loop with a comparator.
- **[[wiki/entities/subiculum.md]]** — the formation's exit stage: this page's output branches (prefrontal, retrosplenial, diencephalic) are that page's projection-typed cell classes, so routing by destination is settled at the cell of origin.
- **[[wiki/concepts/hippocampal-long-axis.md]]** — the axis along which this page's single circuit is repeated: the gradient-plus-domains organisation decides which exit each level joins and what grain the controller receives.
- **[[wiki/concepts/pattern-separation-completion.md]]** — owns the dentate and CA3 stages of this page's signal flow: the transfer-function knob, its four candidate controllers, and the write/read dissociation.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the reference model for this page's whole feedforward chain: the only place the circuit is priced in synapses per neuron, and the source of the mode scalar in this page's control table.
- **[[wiki/concepts/hippocampal-indexing-theory.md]]** — owns the CA1 → entorhinal edge of this page's diagram: the return address learned at encoding, and the retraction that the index addresses association cortex only.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the two-store framing this page's circuit is the fast half of: the sparse-decoder argument for CA1, the week-long survival requirement, and the temporoammonic path as the cuttable wire.
- **[[wiki/concepts/offline-replay.md]]** — owns this page's offline operation: what the CA3 sequence generator emits, what filters it, and what the ripples write that was never traversed.
- **[[wiki/concepts/sleep-oscillation-nesting.md]]** — the clock on this page's offline edges: the ripple is nested inside a cortical and thalamic container the formation does not generate.
- **[[wiki/concepts/cognitive-map.md]]** — the map this circuit holds: spatial coding is the formation's, anchoring and route planning are shared with retrosplenial and prefrontal cortex.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the proximal/ventral exit of this page studied as an edge with its own state, and the source of three rows in this page's control table (gateway control, reuniens, the amygdala lock).
- **[[wiki/entities/hippocampal-diencephalic-cingulate-network.md]]** — the dorsal/posterior exits traced route by route: the fornix and retrosplenial branches of this page's diagram reconverge on the anterior thalamus there.
- **[[wiki/entities/mammillary-bodies.md]]** — the one feedforward node in this page's output graph: receives the subiculum, returns nothing, and relays theta and heading to the anterior thalamus.
- **[[wiki/entities/anterior-thalamic-nuclei.md]]** — the node where this page's two efferent routes reconverge, and the structure whose lesion silences subicular spatial firing while sparing CA1.
- **[[wiki/entities/retrosplenial-cortex.md]]** — the cortical exit of the distal subicular class and the egocentric-to-allocentric transform this page lists as computed outside the formation.
- **[[wiki/entities/head-direction-system.md]]** — supplies the heading this page's pre-/para-/postsubiculum carry: generated below the store, delivered to it, never computed by it.
- **[[wiki/concepts/hierarchy-of-associativity.md]]** — the input stack above this page's gateway: where cross-modal mixing happens, and why the store's reader cannot recover modality of origin.
- **[[wiki/entities/perirhinal-cortex.md]]** — the stage computing the item familiarity this page lists as not the formation's: a repetition decrement readable before the store responds.
- **[[wiki/concepts/recollection-familiarity.md]]** — the two-system split that assigns this page's diencephalic route to recollection and leaves familiarity outside it (`T407`).
- **[[wiki/concepts/synaptic-plasticity.md]]** — the one-shot BTSP rule in this page's CA1 row, established there and extended to CA3, stronger in novel environments.
- **[[wiki/concepts/memory-allocation-excitability.md]]** — the allocation variable in this page's CA1 row, and the cortical override of it that enters through the medial entorhinal cortex.
- **[[wiki/concepts/encoding-retrieval-alternation.md]]** — the theta row of this page's control table: the write/read conflict resolved as a schedule rather than a setting.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the per-feature gain channels on this page's CA1 population, the one controller verified causally per feature.
- **[[wiki/concepts/attractor-dynamics.md]]** — owns `T389` and the Colgin dissociation this page's map-switching row rests on: discrete switching set by the integrator's coordinates, not by CA3's collaterals.
- **[[wiki/concepts/nonspatial-maps.md]]** — the evidence that this page's circuit is a general relational substrate, with the one element that has no non-spatial version.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the index-side reference model in this page's model table, and the one the entorhinal Vb loop contradicts on the interface.
- **[[wiki/entities/vector-hash.md]]** — the reference model that builds this page's CA3 attractors before content arrives, from a frozen grid projection.
- **[[wiki/entities/cscg.md]]** — the map-side reference model in this page's table, matched to the dorsal-CA1 learning trajectory rather than its endpoint.
- **[[wiki/entities/btsp-cam.md]]** — the reference model for this page's CA1 one-shot write without recurrence.
- **[[wiki/entities/inhibitory-replay-filter.md]]** — the reference model for this page's offline selection row, and one of the wiki's two incidental mentions of CA2.
- **[[wiki/entities/state-space-composition.md]]** — the reference model in which this page's store is assembled at entry from cortical vector-cell blocks and extended by replay.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — the posterior-over-maps reading of this page's map-switching row (`T394`).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the controller this page's ventral exit addresses and that reaches back only through the entorhinal cortex and the reuniens.
- **[[wiki/entities/nucleus-reuniens.md]]** — the one indirect route by which the controller reaches CA1 in this page's control table.
- **[[wiki/concepts/abstraction-graph.md]]** — the requirements table this page's circuit is the brain candidate for in rows 2a, 9 and 11, and the decision rule under which this page's model table lists references rather than components.
- **[[wiki/concepts/node-definition-problem.md]]** — the reason this page's node set is a convention: the entorhinal cortex is included by choice and the subiculum's borders are disputed.
- **[[wiki/entities/default-mode-network.md]]** — the cortical system that lists the formation as its medial temporal subsystem, supplying stored associations to a prefrontal constructor.
- **[[wiki/entities/dorsal-visual-stream.md]]** — the input wire into this page's CA1/prosubiculum and pre-/parasubiculum, staged and partitioned by source as the exit is by destination.
- **[[wiki/entities/remerge.md]]** — the reference model for this page's recirculation row: separated dentate gyrus–CA3 traces with the entorhinal return edge used as a read loop, so cross-episode inference is composed at the query rather than stored.
- **[[wiki/concepts/temporal-coding.md]]** — owns the within-cycle mechanics behind this page's theta control row: assemblies defined by a reader's 10–30 ms window, 5–9 per cycle, segregated by perisomatic inhibition, with lag proportional to distance and a sigmoid limit on how far ahead one cycle resolves.
