# Entorhinal Cortex — the Store's Interface, and It Is Not a Layered Input–Output Structure

**The entorhinal cortex is the hippocampus's only major cortical gateway, split into a lateral and a medial division whose famous *what*/*where* phenotypes come mainly from which cortical areas project to them and only secondarily from differences in local circuitry — and whose laminar plan is not "superficial in, deep out" but a **deep-to-superficial loop**: layer II/III writes to the hippocampus, layer Vb receives the hippocampus's return *plus a copy of what layer II sent*, and projects that back up into layers II/III as well as out through layer Va.**

> **Provenance.** Witter, Doan, Jacobsen, Nilssen & Ohara 2017, *Architecture of the entorhinal cortex: a review of entorhinal anatomy in rodents with some comparative notes*, Front Syst Neurosci 11:46 (`raw/witter-2017-entorhinal-cortex-architecture.md`). Rodent-dominated anatomical review with comparative notes on monkey and human; the intrinsic-circuit sections rest on paired patch-clamp recordings from the authors' and others' labs, several explicitly preliminary.

Why this earns a page. The wiki cites "the entorhinal cortex" on twenty-odd pages as (i) the source of the grid code, (ii) the *what*/*where* two-stream split behind `G43`/`T47`, and (iii) the controller's read port into the episodic store ([[wiki/entities/hippocampal-prefrontal-channel.md]]). All three were held as one-line facts with no circuit under them. This is the circuit, and it changes two of the three readings: the two-stream split is a **fan-in** difference rather than two module types, and the interface is a **loop with a comparator in it** rather than a pair of one-way wires.

---

## Definition and subdivision — two divisions suffice

| Criterion | What it separates | Species |
|---|---|---|
| **Differential projection to dentate gyrus** | The classic and still-preferred defining criterion for lateral vs medial entorhinal cortex | Rodent (fails in monkey — the dentate terminal distribution gives no clean split) |
| **Topology of the projection to CA1 / subiculum** | Preserved in *every* mammal studied, primates included: **posteromedial** entorhinal → proximal CA1 (near dentate) + distal subiculum; **anterolateral** entorhinal → distal CA1 + proximal subiculum | Rat, monkey, human |
| **Presubicular input** | Terminates only in a caudal/dorsal zone = medial entorhinal cortex, in every non-primate studied and in a restricted posterior monkey zone | Rat, guinea pig, cat, monkey |
| **Cytoarchitecture** | Posteromedial: regular six layers, homogeneous (Brodmann 28b). Anterolateral: same laminar plan, markedly less regular (28a) | All studied |
| **Human connectional MRI** | Anterolateral vs posteromedial bipartition with rodent-like perirhinal/parahippocampal connectivity differences | Human |

**Naming caution the wiki should adopt.** "Lateral" and "medial" are hodological/architectural labels, **not** stereotaxic positions: in most species the lateral division sits rostrolaterally and the medial division caudomedially. Several cytoarchitectural schemes in primates find more than two subdivisions; the review's argument is that two suffice to describe the *functional* architecture.

Layer II is chemically bipartite in both divisions: **reelin**-expressing and **calbindin**-expressing principal cells. Their spatial arrangement is the part the wiki should not generalise from mouse — in mouse medial entorhinal cortex calbindin cells form clusters superficial to the reelin cells ("islands in an ocean"), but that arrangement is restricted to a limited posterior patch and is *reversed* over the larger part of entorhinal cortex, where reelin cells form the clusters (the human *verrucae* are reelin clusters).

---

## Extrinsic connectivity — the actual content of the two-stream split

| Target | Cortical inputs | Laminar termination |
|---|---|---|
| **Lateral entorhinal** | Olfactory bulb, anterior olfactory nucleus, piriform; insular; **perirhinal**; orbitofrontal (whole); parietal (moderate) | Olfactory → layer I onto layer II/III dendrites; insular/orbitofrontal anteriorly near the rhinal fissure; parietal → layers I and V |
| **Medial entorhinal** | **Postrhinal**; pre- and parasubiculum; ventral orbitofrontal only; visual (weak–moderate); parietal (moderate) | Pre-/parasubicular input reaches layer II/III dendrites **and** layer V |
| **Lateral, layer V** | Infralimbic + prelimbic (≈ equal to both divisions); **anterior cingulate** denser here | Layer V |
| **Medial, layer V** | Infralimbic + prelimbic; **retrosplenial almost exclusively here** | Layer V |

**The review's thesis, stated as a design claim:** the spatial phenotype of the medial division and the object-in-context phenotype of the lateral division "likely depend on the combinatorial effects of *small* differences in intrinsic organization and *substantial* differences in extrinsic inputs." Medial entorhinal cortex is wired to the posterior spatial-processing domain (postrhinal, retrosplenial, parietal, occipital, pre-/parasubiculum); lateral entorhinal cortex to anterior sensory, perirhinal, insular and orbitofrontal domains.

**(brainstorm) This is the cheapest possible answer to the wiki's two-stream question, and it is an architectural one.** Every wiki model that needs a *what* stream and a *where* stream instantiates two differently-designed blocks — a sensory encoder and a path integrator. The anatomy says one block type, twice, with different afferents: same six layers, same principal-cell chemistry, same three interneuron families, same laminar output rule. The machine version is a **single shared interface module replicated per content feed**, not two modules; and the prediction is that swapping the input distribution should be enough to move a copy's phenotype from grid-like to object-like, with no change of architecture, loss or update rule. Nothing in the wiki has tested that, and it is a one-afternoon experiment on any model with a structural code ([[wiki/entities/tolman-eichenbaum-machine.md]], [[wiki/entities/vector-hash.md]]). It is also the same question `T338` asks of the prefrontal relational integrator — one shared operator with routed inputs, or a tiled family wired to its own feeds — and this is the only place in the wiki where the two copies' *intrinsic circuits* have been compared rather than their activation maps. The converse warning is on the record in the same review: the *intrinsic* differences below are real, so "inputs alone" is the leading hypothesis, not the finding.

A gradient orthogonal to the split, conserved into primates: parvalbumin expression is **high near the rhinal fissure and falls ventrally** in both divisions (and along the collateral/rhinal sulcus in monkey and human) — an inhibition gradient running along the same axis as the hippocampal long axis ([[wiki/concepts/hippocampal-long-axis.md]]).

---

## Layer II — two isolated subcircuits, both inhibition-mediated, with different interneurons

| | Medial entorhinal layer II | Lateral entorhinal layer II |
|---|---|---|
| Reelin⁺ principal cell | **Stellate** cell (multiple primary dendrites, round soma) | **Fan** cell (stellate-like, *no* basal dendritic tree) |
| Calbindin⁺ principal cell | Pyramidal cell | Pyramidal cell (plus oblique pyramidals) |
| Intermediate types | Intermediate stellate (reelin⁺), intermediate pyramidal (mixed) | Oblique pyramidal (calbindin⁺), multipolar (both markers) |
| Dominant interneuron | **Parvalbumin⁺** fast-spiking — heavy somata and neuropil | **5HT3a receptor⁺** — parvalbumin staining weak, layer IIa nearly devoid |
| Principal→principal monosynaptic excitation | **Absent** between stellates; sparse between pyramidals | Fan→fan direct communication **present but not prevalent** (preliminary) |
| Electrophysiological separability of the four types | Clean | Poor — only the reelin/calbindin split shows subtle differences |

**Projection targets are chemically typed, and one axon serves two hippocampal fields.** Reelin⁺ cells (stellate/fan) → dentate gyrus **and** CA3, with single layer II cells collateralising to both (Tamamaki & Nojyo). Calbindin⁺ cells → CA1, contralateral entorhinal cortex, olfactory bulb and piriform cortex.

**The medial layer II circuit is two non-communicating networks, each closed through a *different* inhibitory cell class:**

- stellate ↔ stellate: **no** monosynaptic link; communication is **disynaptic inhibition** through a single interneuron type, the parvalbumin⁺ fast-spiking basket cell (Couey et al. 2013; Buetfering et al.; Armstrong et al.).
- pyramidal ↔ pyramidal: also disynaptic, but through the **5HT3a/cholecystokinin** population, and pyramidals are connected to parvalbumin⁺ and somatostatin⁺ cells in *neither* direction.
- stellate ↔ pyramidal monosynaptic connectivity is minimal; the only proposed coupling is via intermediate pyramidal cells, which contact both.

**Why this matters for the grid attractor.** The wiki's continuous-attractor formalism writes `τ dz/dt = −z + f(Wz + Ba)` with `W` a recurrent interaction kernel ([[wiki/concepts/path-integration.md]]). In the tissue where grid cells are densest, the excitatory half of `W` **does not exist**: the interaction is purely inhibitory and carried by one interneuron class. A continuous attractor built from inhibition alone is a different object from the Mexican-hat networks the wiki's models use — it needs an external excitatory drive to set the activity level, and its "kernel" is a property of the interneuron's fan-in rather than of the principal cells' weights. This is `L3` realization detail, so it gets no registry row, but it is the constraint any grid-module implementation should be checked against.

**(brainstorm) Two output channels out of one layer, kept apart by giving each its own interneuron.** The reelin route (→ dentate/CA3, i.e. the pattern-separation front end) and the calbindin route (→ CA1 and back out to olfactory cortex) share a layer and do not talk. In [[wiki/concepts/inhibitory-control-of-coding.md]] the interneuron families are assigned to *coding features* of one pyramidal population (stability, generalisation, selectivity, information). Here the assignment is by **target principal-cell class**: the family is what keeps two parallel channels from merging. Those are compatible but different jobs, and a machine that copies the first (four gain channels on one population) does not get the second (channel isolation) for free — isolation needs the inhibitory pool to be *partitioned*, which a global normalisation layer cannot express.

---

## Layer III — the opposite connectivity regime, and largely unknown

- Homogeneous spiny pyramidal cells → CA1 and subiculum (the temporoammonic route), plus non-spiny pyramidals and multipolar cells.
- **Strong monosynaptic principal→principal connectivity**, "markedly different" from layer II. So the two hippocampus-projecting layers are built on opposite principles: layer II recurrently *inhibited*, layer III recurrently *excited*.
- ~40% of medial-entorhinal layer III hippocampus-projecting cells also collateralise to the **contralateral** medial entorhinal cortex, terminating in layer III (layer II's small commissural contingent instead targets contralateral layer I).
- Layer III is the **main recipient of the deep-to-superficial projection from layer Vb**.
- No morphology↔connectivity↔physiology correlations have been reported at all. The review calls layer III "terra incognita".

**One functional assignment the connectivity review does not carry** (Frankland & Bontempi 2005, `raw/frankland-2005-organization-of-recent-and-remote-memories.md`, reviewing Remondes & Schuman 2004): lesioning the temporoammonic projection leaves the hippocampus working and cuts cortical–hippocampal dialogue, and the behavioural signature is **selective for the remote memory**.

| Lesion timing | Water-maze acquisition | 1-day memory | 28-day memory |
|---|---|---|---|
| Pre-training | Normal | Normal | **Impaired** |
| 1 day post-training | — | — | **Impaired** |
| 21 days post-training | — | — | Normal |

So layer III's hippocampal output is not required to acquire or to retrieve a spatial memory at short delay — it is required, for a bounded post-encoding window, for the *cortical* copy to form ([[wiki/concepts/complementary-learning-systems.md]]). That is a systems-consolidation job for a **cortex → fast store** wire, i.e. the direction opposite to replay, and it makes layer III the one cuttable point where the two learners can be disconnected without damaging either.

---

## Layer V — the loop, and the reappraisal

Two molecularly distinct sublayers across the whole extent of both divisions: **Va** (`Etv1`⁺, large pyramidals) and **Vb** (`Ctip2`⁺, smaller, densely packed).

| Sublayer | Receives | Sends |
|---|---|---|
| **Vb** | Hippocampal output (CA1 + subiculum); axon collaterals from layer II (in medial entorhinal cortex, specifically from **reelin⁺ stellates**, not calbindin⁺ pyramidals); retrosplenial cortex (medial division) | Layer Va, **and layers II/III** |
| **Va** | Layer Vb (disynaptic hippocampal return); probably superficially-terminating inputs onto its apical tufts | **The main entorhinal output** to widespread cortex and subcortex |

So the schema is not "superficial layers in, deep layers out". It is:

```
cortex → II/III → hippocampus → Vb → Va → cortex
                     ↘ (copy)  ↗        ↘
                        Vb ────────────→ II/III   (deep-to-superficial return)
```

**(brainstorm) Layer Vb is positioned as a comparator, and this is the wiki's best biological candidate for an efference-copy circuit inside a memory system.** Two things arrive at the same layer-Vb cells: a **copy of what layer II just sent to the hippocampus**, and the **hippocampally processed version of that same input**, delivered under a topology that is strictly preserved along the transverse axis in every mammal — so the copy and the return are *addressed to the same place*. That is the wiring an architecture needs to compute "what the store did to my query", and no model in the wiki has it: [[wiki/entities/tolman-eichenbaum-machine.md]], [[wiki/entities/vector-hash.md]] and every complementary-learning-systems variant deliver the store's output to a *downstream* reader that never saw the write. Concrete machine test: in a model with a fast store, route the store's output and a copy of the write to one shared layer and train on the residual; the prediction is (i) drift correction with no separate anchoring step ([[wiki/concepts/path-integration.md]]'s memory-based anchoring, `G39`) and (ii) a natural place for a novelty/mismatch signal that currently has to be bolted on. The predictive-coding literature puts exactly this subtract-the-prediction motif in cortex ([[wiki/concepts/predictive-coding-free-energy.md]]); the claim here is that the same motif sits at the *entrance to the episodic store*, and the deep-to-superficial arm is what makes it a loop rather than a readout.

Caveats the review states itself: the layer II → layer V collateral is reported in mouse and **conflicts** with rat and monkey reports of sparse layer V collaterals from layer II stellates (species difference or older-method insensitivity, unresolved); the layer Vb → superficial projection rests partly on the authors' preliminary data; input specificity onto Va vs Vb is unknown; and no detailed comparison of layer V between the two divisions exists — medial entorhinal Va has pyramidals with extensive basal dendrites confined to the somatic layer and no such cell has been reported in the lateral division.

Layer V also contains multipolar and GABA-negative/calretinin⁺ principal cells, and the muscarinic **persistent-firing** neurons (Egorov et al. 2002) have never been matched to any of these anatomical types.

---

## The prediction that fails: input and output are not reciprocated

The strict reciprocal topology of the entorhinal ↔ CA1/subiculum network predicts that a stream that carries information *in* should be the stream that carries it back *out*. The review says plainly that this is **not supported**:

| Study | Preparation | Result |
|---|---|---|
| Boeijinga & Lopes da Silva | Cat, freely behaving, EEG | Functional separation: lateral entorhinal cortex coupled to the olfactory domain, medial entorhinal cortex coupled to the hippocampus |
| Biella & de Curtis | Guinea pig, isolated *ex vivo* brain | Olfactory stimulation → sequential activation **lateral entorhinal → hippocampus → medial entorhinal → lateral entorhinal** |

Hippocampal output driven by an input that entered through the lateral division comes back preferentially to the **medial** division. Logged as [[wiki/empirical-tensions.md]] `T340`; the evidence is two old, sparse studies and the authors call the output-pathway specificity "underexplored".

**Why a builder should care.** Every architecture in the wiki treats the store's interface as one bidirectional port: the same code that addresses the store receives its return. If the return is routed to the *other* stream, then the write encoder and the read decoder are different modules and the store's output is obliged to arrive in the structural stream's coordinate system regardless of which stream wrote it — which would make "the hippocampus indexes cortical content" and "the hippocampus hands back a *position*" the same statement.

---

## Limitations

- **Rodent, and largely anatomy.** Comparative claims for monkey and human rest on tracer studies in few animals plus connectional MRI; the two-division scheme is explicitly a *proposal* that two subdivisions suffice, against cytoarchitectural schemes that find more.
- **The intrinsic-circuit half is thin on one side.** Lateral entorhinal layer II microcircuitry is preliminary (fan–fan pairs, "present but not prevalent"), basket cells there are described but untyped, and layer III microcircuitry is unknown in both divisions.
- **The central thesis is not tested.** "Phenotype = big input differences + small intrinsic differences" is an inference from two comparisons run separately, not from any manipulation that swaps inputs or circuits.
- **The mouse clustering picture is unrepresentative** and the review says so — the calbindin-island arrangement holds in a restricted posterior patch of mouse medial entorhinal cortex and inverts elsewhere, so any model motivated by "islands and ocean" is motivated by a special case.
- **No functional recordings here.** Grid cells, object-vector cells and lateral-entorhinal object coding are cited, not measured; the page's circuit claims and the wiki's coding claims meet only by juxtaposition. (The coding side is now held separately from a primary — [[wiki/concepts/vector-coding.md]] — but the juxtaposition stands: nothing links the object-vector code to any cell class or laminar position described above.)

---

## Connections

- **[[wiki/concepts/path-integration.md]]** — supplies the substrate constraint the formalism omits: in the layer where grid cells are densest there is **no** monosynaptic excitation between stellate cells, so the recurrent kernel `W` of a grid attractor is realised entirely as disynaptic inhibition through one parvalbumin⁺ interneuron class, and the interaction is a property of the interneuron's fan-in rather than of principal-cell weights.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the anatomy under the frame question: the wiki's *what*/*where* split is a difference in **afferents** to one repeated circuit type rather than two module designs, which pushes `T47` toward "one operator, routed inputs" and makes the frame count a question about input partitions rather than about integrators.
- **[[wiki/concepts/nonspatial-maps.md]]** — names what the non-spatial stream is wired to: the lateral division's object-in-context phenotype comes from olfactory, perirhinal, insular and orbitofrontal afferents onto a circuit architecturally near-identical to the grid-bearing one, so "maps outside space" is a claim about input distribution, not about a second mechanism.
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the gateway that page's top-down arm lands on, drawn at circuit level: the controller's cortical route reaches **deep** lateral-entorhinal layers, i.e. layer V, which is the loop's integrator and the origin of the store's outbound projection — so "control applied at the store's input gateway" is control applied to the layer that also holds the store's return (`G110`).
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the same three interneuron families in a second job: there the family sets a *coding feature* of one pyramidal population, here it keeps **two parallel principal-cell channels isolated** (parvalbumin⁺ for the reelin→dentate/CA3 route, 5HT3a/cholecystokinin for the calbindin→CA1 route), which a single global normalisation pool cannot express.
- **[[wiki/concepts/pattern-separation-completion.md]]** — types the input the separator receives: the dentate/CA3 front end is fed *only* by reelin⁺ layer II cells whose local network has no recurrent excitation, and single axons deliver the same vector to both dentate gyrus and CA3.
- **[[wiki/concepts/hippocampal-long-axis.md]]** — an inhibition gradient on the same axis: parvalbumin expression falls from the rhinal fissure ventrally in both entorhinal divisions and is conserved into monkey and human, so the long-axis gradient story has an interneuron-density term at the store's gateway as well as inside it.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the model this anatomy contradicts on one structural point: its `g`/`x` interface is a pair of one-way wires into and out of a store, where the tissue returns the store's output to a deep layer that also holds a **copy of the write** and projects that back up into the input layers.
- **[[wiki/entities/vector-hash.md]]** — the scaffold model's developmental ordering (layer II medial stellates mature first, then layer V, then layer II lateral) is an ordering over *these* cell classes, and this page supplies what matures: a reelin⁺ population with no recurrent excitation, then the deep-to-superficial return loop, then the object stream.
- **[[wiki/concepts/abstract-structural-codes.md]]** — where the grid code physically is, and in what circuit: layer II of the medial division, in both stellate-like and pyramidal-like cells, generated in a network whose only lateral interaction is inhibitory.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the same subtract-the-prediction motif proposed one synapse earlier: layer Vb receives a copy of what was sent to the hippocampus alongside the hippocampus's processed return, under a preserved topology, which is the wiring a comparator needs at the *entrance to a memory store* rather than inside a sensory hierarchy.
- **[[wiki/entities/thousand-brains-theory.md]]** — the theory assigns lateral entorhinal cortex "what" and medial entorhinal grid cells "where" as two functional types; the anatomy says one repeated circuit with two afferent sets, which weakens the case for treating them as different column components and strengthens the case for one column type replicated per input.
- **[[wiki/concepts/vector-coding.md]]** — the most abundant *measured* code in the superficial medial layers this page describes (14.7% of cells, above grid cells at 11.3%), and a functional constraint on the afferent story: the code degrades in darkness, so whatever computes it needs the postrhinal/visual fan-in this page assigns to the medial division rather than the self-motion drive the grid attractor uses.
- **[[wiki/entities/state-space-composition.md]]** — assigns this region's vector-cell zoo a computational job: border-, object- and reward-vector cells are *reusable building blocks* precisely because each is a complete path-integrable map in its referent's own frame, so a hippocampal conjunction of grid × vector code specifies a whole state space that arrives with its policy already attached (Bakermans et al. 2025).
- **[[wiki/concepts/hierarchy-of-associativity.md]]** — the two association stages *upstream* of this one, in macaque: perirhinal and parahippocampal cortices each run their own dense intrinsic associational network and supply two-thirds of the cortical input here, so most cross-modal mixing is finished before the entorhinal stage — and the same deep-to-superficial return loop is reported there independently, twenty years earlier.
- **[[wiki/concepts/complementary-learning-systems.md]]** — layer III's hippocampal output is that framework's severable wire: cutting the temporoammonic path disconnects the two learners without damaging either, and the memory that fails is the remote one, which assigns "terra incognita" a systems-consolidation job running cortex → fast store.
- **[[wiki/entities/retrosplenial-cortex.md]]** — the posterior partner that helps define this page's medial division, now paged: its axons terminate almost exclusively in medial entorhinal layer V, so the frame-conversion signal enters at the interface's *output* layer rather than at layer II/III, and the connection is reciprocal (Vann et al. 2009).
