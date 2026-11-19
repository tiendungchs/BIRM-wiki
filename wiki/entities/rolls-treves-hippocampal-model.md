# Rolls–Treves Hippocampal Model

**The hippocampus as three named network types wired in series, each with a closed-form capacity: a competitive network (dentate gyrus) that decorrelates, a single autoassociator (CA3) that stores arbitrary one-trial bindings and completes them from any part, and a reverse hierarchy of pattern associators (CA1 → entorhinal → neocortex) that reinstates the cortical activity present at encoding.** (Rolls 2013, developing Rolls 1989–2012 and Treves & Rolls 1992–1994)

The wiki's only source that prices pattern separation and completion in *synapses per neuron*. Where [[wiki/concepts/pattern-separation-completion.md]] gives the transfer curve as a phenomenon, this page gives the equations that say how many memories the curve buys and what wiring is needed to get them.

> **Provenance.** `raw/rolls-2013-pattern-completion-separation.md` — Rolls, *The mechanisms for pattern completion and pattern separation in the hippocampus*, Front. Syst. Neurosci. 7:74. `raw/kesner-2015-computational-theory-hippocampal-function-new-developments.md` — Kesner & Rolls, *A computational theory of hippocampal function, and tests of the theory: New developments*, Neurosci. Biobehav. Rev. 48:92–147 (2015): the same theory restated, plus Kesner's rat subregion-lesion programme (§ *Subregion tests* below). The clipped copy lost every equation, so the capacity forms on this page are carried from Rolls 2013.

---

## The circuit, in numbers (rat)

| Stage | Count | Connections onto each cell | Dilution | Network type |
|---|---|---|---|---|
| Dentate granule cells | 10⁶ | perforant path from EC layer II | — | **Competitive** (Hebbian + strong interneuron inhibition) |
| CA3 pyramidal cells | 3×10⁵ | ~46 mossy fibres | 4.6×10⁻⁵ | write port |
| " | " | ~3,600 direct perforant path | — | **Pattern associator** (read port) |
| " | " | ~1.2×10⁴ recurrent collaterals | 0.04 (≈2% bilateral) | **Autoassociator / attractor** |
| CA1 | — | Schaffer collaterals from CA3 | — | Competitive + pattern associator |
| Backprojection stages | growing per stage | `C^HBP` | — | **Pattern associators in series** |

Local neocortical recurrent dilution is ~0.1 — CA3 is *more* diluted than cortex, which the theory reads as capacity being at a premium there.

**The dilution figure is an estimate, and the direct measurement is higher.** Combined 3D electron microscopy (seven fully reconstructed CA3 axons, 1,062 annotated outgoing synapses, P31 mouse) and up-to-octuple patch-clamp (1,172 tested pairs, 52 mice) put local pyramidal→pyramidal connectivity at **11.2 ± 2.7% within 50 µm** falling to **5.5 ± 1.9% by 250 µm** (structural) and **8.8%** with no distance dependence to 430 µm (functional) — 2–3× the 0.04 assumed here and ~10× the 0.9% reported in rat by Guzman et al. 2016 (Sammons et al. 2023; [[wiki/empirical-tensions.md]] T49). Two consequences for the equations above: `C^RC = c·N` rises with `c`, so capacity 3 is an **under**estimate at fixed `N`; and the "avoid multi-synapse pairs" argument is weakened but not refuted — 10% of measured connections (96/947) use more than one synapse, and no autapses were seen.

## The four capacity equations

| # | Quantity | Form | Value at biological parameters |
|---|---|---|---|
| 1 | Autoassociator learning rule | `δw_ij = k · r_i · r'_j`, with heterosynaptic LTD required alongside LTP for efficient storage | — |
| 2 | Population sparseness | `a = (Σ_i r_i / N)² / (Σ_i r_i² / N)`; ranges `1/N` (grandmother) to `1` (dense) | macaque hippocampal pyramidal `a ≈ 0.33`; inferior temporal 0.77, orbitofrontal 0.61, amygdala 0.81 |
| 3 | CA3 attractor capacity | `p_max ≈ k · C^RC / (a · ln(1/a))`, `k ≈ 0.2–0.3` | `C^RC = 12,000`, `a = 0.02` → **~36,000 memories** |
| 4 | Pattern-associator capacity | `p_max ≈ k · C^PA / (a_o · ln(1/a_o))` | perforant-path feedforward route: `3,600/12,000` ≈ 30% of the recurrent route |
| 5 | Backprojection requirement | `C^HBP = C^RC · a_nc / a_CA3` | ≥12,000 afferents of hippocampal origin per neocortical cell — **impossible monosynaptically**, hence a polysynaptic reverse hierarchy with gradual fan-out |

Equation 5 is the paper's sharpest structural derivation: **the number of backprojections must roughly equal the number of forward projections**, and that is offered as the quantitative reason cortex has as many of one as the other.

---

## Why the connectivity is diluted, not dense

The wiki previously recorded CA3 recurrence as "dense auto-association". It is not — and the dilution is functional, not a budget compromise:

| Argument | Mechanism |
|---|---|
| **Avoid multi-synapse pairs** | With random wiring, two-or-more synapses between a neuron pair distort the energy landscape and dominate which attractors are stable; simulation shows this collapses capacity. Dilution makes such pairs rare |
| **Genomic economy** | Specify *two attributes* ("a CA3 cell connects to a random CA3 cell"), not a wiring diagram. Cell-type-specific NMDA receptor knockouts are the evidence that connectivity is specified at type level |
| **Less spiking noise** | Integrate-and-fire simulations at dilution 0.25/0.1 with the same synapse count per neuron give a *more* stable spontaneous state and more accurate decisions, at slightly slower decision times |

**Transferable form (brainstorm).** For a machine fast store this reads as: hold the fan-in per unit fixed as the capacity budget, then *add units and reduce connection probability* rather than densifying. Capacity scales with fan-in `C`, stability improves with population size, and the extra units cost nothing in synapse count. Nothing in the wiki's memory architectures (key-value stores, Hopfield layers, attention) is built with a connection-probability knob at all — they are all fully connected by default.

---

## Five mechanisms for pattern separation, ranked

The theory's claim is that separation is *not one mechanism* but five contributions to decorrelating CA3 population vectors:

| # | Mechanism | How it decorrelates | Necessary for |
|---|---|---|---|
| 1 | **Sparse mossy-fibre connectivity** (~46 per CA3 cell) | *Randomizing*: which CA3 cells fire for an event is effectively a random draw, so any two events pick near-orthogonal sets | New learning only — predicted, and observed, to be dispensable at recall |
| 2 | **Sparse DG firing** | Few active granule cells × few connections → sparse CA3 drive, thresholded into sparse CA3 firing | Feeding 1 |
| 3 | **Large DG population** (10⁶ vs 3×10⁵ CA3) | Expansion recoding via competitive learning + interneuron inhibition | Converting grid codes to place-like fields |
| 4 | **Sparse CA3 representation** | Sparse vectors are more likely to be mutually decorrelated; graded rates through a non-linearity *increase* effective sparseness, which is itself a separation effect | Capacity (equation 3) |
| 5 | **Adult neurogenesis** | New granule cells bring *new random* mossy-fibre connections to CA3, so new patterns are uncorrelated with old ones | Small-separation discrimination (impaired-neurogenesis mice fail on close radial-maze arms, pass on far ones) |

Mechanism 1 is the conceptually distinctive one: **separation here is not a similarity-reducing transfer function at all, it is randomization.** The mossy-fibre projection does not compute a code for the input — it destroys the input's similarity structure and hands CA3 a random address. Rolls notes explicitly that neocortex has no mossy-fibre equivalent because cortex wants competitive learning (structure-preserving) rather than random reallocation.

**(brainstorm) This is a genuinely different design from everything else in the wiki.** [[wiki/entities/cscg.md]] allocates a clone, [[wiki/concepts/contextual-inference.md]] allocates by posterior responsibility, [[wiki/concepts/event-segmentation.md]] allocates at a boundary — all three *decide*. Random hashing decides nothing and gets orthogonality for free; the cost is that a repeated situation is not recognised as one, which is exactly why mechanism 1 is switched on only during storage (see the write/read split below). Read as a machine primitive: **locality-destroying hashing on the write path, similarity-preserving lookup on the read path** — the opposite of every learned-index retrieval system, which uses one embedding for both.

---

## The write/read split, mechanistically

| Port | Anatomy | Signal | Function | Capacity role |
|---|---|---|---|---|
| **Write** | Mossy fibres, ~46, large, proximal, mV-scale per synapse | Strong; dominates the recurrent input during storage | Force a random sparse pattern into CA3 so the RC synapses can store it | Perforant-path input alone is *too weak* to direct efficient storage — RC randomization drowns it |
| **Read** | Direct perforant path, ~3,600, weak | Numerically large, individually weak | A pattern associator applying the retrieval cue; *generalizes*, so a partial cue still lands close | Recall signal `∝ √(number of pp synapses)` — many weak inputs suffice to trigger, and the RCs finish |

The read port is also where `G97` bites: the sparse CA3 pattern leaves through the ~3,600 weak perforant-path and Schaffer synapses into a *dense* downstream code, so the separation bought at the dentate is spent again at the read-out, and the reverse hierarchy back to neocortex has to stay sparse at every stage for it to survive.

**The control signal is acetylcholine.** ACh turns *down* the efficacy of CA3→CA3 recurrent synapses while (in cortex) facilitating LTP in them, so cholinergic tone simultaneously lets mossy-fibre input dominate firing and licenses the RC write. That is a single scalar doing mode selection *and* plasticity gating — the concrete functional form gap G38 asks for, and one a machine can copy directly (scale the recurrent read-out gain down and the recurrent learning rate up, together).

---

## Continuous, discrete, and mixed attractors

| Type | Stored pattern | Stable states |
|---|---|---|
| Discrete autoassociator | Disjoint subsets of active units | Isolated basins; relaxes to the nearest stored pattern |
| **Continuous attractor (CANN)** | Gaussian-tuned overlapping fields | A continuum; the activity packet stays wherever it is put (global inhibition keeps one packet) |
| **Mixed** | Both in one network | Retrieve continuous position from a discrete object, or the object from the position |

Two results the wiki should carry:

- **Mixed storage works.** One attractor network storing continuous (place/view) and discrete (object) components jointly supports retrieval in *either* direction. This is the concrete mechanism behind object-place episodic memory, and it is the network-level answer to "how does a metric map coexist with symbolic content" ([[wiki/empirical-tensions.md]] T27).
- **Many charts fit in one CANN.** Because place representations in different environments are near-uncorrelated, many maps ("charts") coexist in one continuous attractor (Battaglia & Treves). Map selection is then attractor selection, not a separate indexing structure.

Rolls's own caveat: the *bumpiness* of the CA3 spatial representation is argued to fit episodic storage better than CA3-as-path-integrator (Cerasti & Treves; Stella et al.), i.e. this model does **not** claim CA3 performs path integration — that is pushed to entorhinal cortex ([[wiki/concepts/path-integration.md]]).

---

## Temporal order without oscillations

A distinct proposal, and the one that reaches furthest beyond memory: **rate-coded time.** Different hippocampal neurons fire at different points within a delay period (MacDonald et al. 2011), so the CA3 autoassociator can bind an item to a time-encoding population exactly as it binds an item to a place, and replaying the time sequence recalls the items in order.

| Hypothesis for generating the time code | Mechanism | Prediction |
|---|---|---|
| Adaptation-driven | Several attractors, weak mutual connections; the least-recently-active (least adapted) attractor wins next | Replays *whatever* order was presented |
| Asymmetric weights | Slightly stronger forward than reverse weights between attractors | Fixed learned sequence; noise-limited to perhaps **7 ± 2** transitions — offered as the origin of the short-term memory span |
| Heterogeneous time constants | Attractors started together with different adaptation time constants | Nested/staggered time fields |

All three make transitions **noise-driven and slow**, which turns spiking variability from a nuisance into the clock. Rolls contrasts this explicitly with theta/gamma phase-coding accounts of order (Lisman) — [[wiki/empirical-tensions.md]] T32.

The unresolved point the paper concedes: the natural site is CA3, but part of the temporal-order lesion evidence implicates CA1. **Kesner & Rolls 2015 move the site.** CA1 lesions impair temporal order for every content tested (places, visual objects, odours). CA3 lesions impair it only for places (§ *Subregion tests*). The 2015 mechanism therefore takes the time code off the recurrent network. Medial entorhinal timing cells (the adaptation time constants proposed to set grid scale) reach CA1 directly. Lateral entorhinal carries the object. CA1 competitive learning forms time × object conjunctions, and replaying the time code retrieves the object's position in the sequence. The CA3 chain is kept as the fallback hypothesis (ventral CA3, noise-driven slow transitions).

---

## Predictions and their tests

| Prediction | Test | Outcome |
|---|---|---|
| Mossy fibres needed to store, not to recall | Mossy-fibre disruption in rats | Confirmed (Lassalle 1998; Lee & Kesner 2004; Daumas 2009) |
| Direct perforant path needed for recall | Perforant-path lesion, Hebb–Williams maze | Confirmed (Lee & Kesner 2004) |
| CA3 needed for *arbitrary* place↔object associations, not for odour–object | Subregion lesions | Confirmed; odour–object association spared |
| CA3 needed for one-trial object-place recall in both directions | CA3 lesion | Chance performance both ways; matched-delay conditional task unimpaired |
| CA3 needed for completion from partial cue even in reference memory | CA3 NMDAR knockout | Confirmed (Nakazawa 2002; Gold & Kesner 2005) |
| Ambiguous environment → one attractor, not a blend | Square/circle morph recordings; cue-switch ("teleportation") recordings | Confirmed (Wills 2005). Jezek et al. 2011 supplies the stronger form and the only one with a null: after an instantaneous cue switch, CA3 theta cycles correlating with *both* charts are 1.25%, **below** a per-unit shuffle (`p < 0.03`) — the blend is not merely absent, it is suppressed past what independent cells would produce |
| Completion within one theta cycle (~120 ms) | Same | Confirmed — in 30.8% of flickers the alternative chart is fully expressed in the very next cycle and is complete at its onset (`r = −0.06 ± 0.11` for further growth within the flicker), so the settling time is bounded by one cycle rather than estimated from it |
| Direct demonstration of CA3 completion | Voltage-sensitive dye in slice: LTP from two sites, then either site alone evokes the full pattern | Confirmed (Jackson 2013) |
| CA3 output closer to the stored pattern than its *measured* input | Simultaneous CA3 + dentate recording under graded local-global cue conflict, with the entorhinal stage recorded in the companion study | Confirmed (Neunuebel & Knierim 2014) — the only line here in which the input was measured, so the only one the "it relayed an already-coherent input" objection cannot reach; holds to a 135° conflict and loses significance at 180° |
| DG competitive learning turns grid cells into place fields | Simulation | Place-like fields form **only** with Hebbian training in the perforant path — untrained sparse projection is not enough |
| Hippocampal codes sparser than neocortical | Macaque recordings | Confirmed (0.33 vs 0.61–0.81) |
| Dentate needed in proportion to spatial similarity | Delayed match-to-place on a cheeseboard, foil 15–105 cm from target, dorsal dentate lesion | Confirmed: deficit graded with proximity, gone at the largest separation (Kesner & Rolls 2015; primary citations stripped in the clipped copy) |
| High acetylcholine favours storage, low favours recall | Cholinergic drugs infused into CA3a,b | Confirmed as a **double dissociation**: the antagonist scopolamine impairs encoding and spares recall, the cholinesterase inhibitor physostigmine impairs recall and spares encoding, in three paradigms (Kesner & Rolls 2015) |
| One-trial object–place recall shows up in single primate neurons | Macaque, 347 hippocampal neurons | Confirmed. Object cells keep firing after the object is gone while its place is being recalled. Place cells fire for the *recalled* place even on error trials where the monkey touched the other side, so the signal is not motor (Kesner & Rolls 2015) |

This settles an item [[wiki/concepts/pattern-separation-completion.md]] listed as open ("attractor dynamics in CA3 is a hypothesis with one supporting demonstration"): there are now five independent lines — slice VSD, morph recordings, theta-cycle flicker, the NMDAR-knockout completion deficits, and the input-measured cue-conflict recording. The fifth is the one that carries the argument, because the first four all infer completion from the output alone, which is formally insufficient: separation and completion are defined as a relation between input and output similarity, so an output that looks completed is equally consistent with an input that was never degraded. The model also collects an unpredicted result from the same experiment — CA3 completes toward the *weak* lateral-entorhinal/local-cue afferent and against the coherent medial-entorhinal one, which the model has no term for, since its `C^pp`/`C^mf` split prices the two hippocampal input paths by synapse count and not by which cortical stream feeds them.

---

## Subregion tests (Kesner & Rolls 2015)

All rat, mostly neurotoxic lesions of dorsal subfields. CA3a,b has recurrent collaterals. **CA3c has none**: it projects straight to CA1 and loops back into the dentate through hilar mossy cells, so lesion data treat it as part of the dentate circuit.

### Write port and read port, separated by lesion

| Manipulation (Hebb–Williams maze unless stated) | Within-day learning (encoding) | Next-day performance (retrieval) | Reads as |
|---|---|---|---|
| Dentate lesion, or CA3a,b lesion | Impaired | Spared | Write port = dentate → mossy fibres → CA3 |
| Lesion of the perforant-path input to CA3 | Spared | Impaired | Read port = direct entorhinal → CA3 |
| CA1 lesion | Spared | Impaired | Retention across days needs CA1 |
| Apomorphine (dopamine agonist) into CA1. Dopamine inhibits the direct entorhinal → CA1 input and spares the Schaffer input | Spared | Impaired (also 5-min delayed non-match-to-place, contextual fear) | The CA1 retrieval deficit is carried by CA1's **direct** entorhinal input, not by its CA3 input |
| Ventrolateral fimbria cut: CA3's subcortical output removed, septal input to the hippocampus intact | Impaired | Spared | Mimics a CA3 lesion. CA3's encoding role runs through its septal output, not through CA1 |

The authors' own caveat: across multi-trial acquisition, storage and retrieval both shape the learning curve. "Encoding deficit" labels a curve, not an isolated process.

### Which content needs which subfield

| Content or demand | Dentate | CA3 | CA1 |
|---|---|---|---|
| Spatial separation: target vs foil 15–105 cm apart | Deficit graded with proximity, gone at the largest separation | Deficit at **every** separation (read as a short-term memory loss, not a separation loss) | — |
| Geometry of the enclosure changed | Deficit | Spared (CA3a,b). CA3c lesion: metric object change only | — |
| Grey-shade context, three similarity levels | No graded separation effect (unpublished) | — | — |
| Odours: aliphatic alcohols 1–4 carbons apart, 60 s delay | **Ventral** dentate: graded deficit. Spared at a 15 s delay | — | — |
| Completion: 0–3 of 4 room cues removed at test | — | Deficit when 1–2 cues remain. Same deficit with the μ-opioid antagonist naloxone in CA3 | — |
| One-trial object → place and place → object recall (50 objects, 48 locations) | — | **Chance both ways** (CA3a,b). A fixed conditional task at the same delay is spared | — |
| Multi-trial paired associates, object–place or odour–place | Spared unless the places are close | Impaired | Spared |
| Object–odour (even with a delay) | — | Spared. Odour–odour, odour–reward, auditory–visual, object–object also spared by hippocampal lesions | — |
| Object, 10 s trace, then odour | — | Spared | **Never above chance** |
| Object, trace, then place | — | Impaired | Impaired |
| Temporal order of places, 0–6 intervening arms | Spared | Impaired | Chance at 0, 2, 4 |
| Temporal order of visual objects | — | Spared | Impaired |
| Temporal order of odours | — | — | Dorsal mild, ventral severe |
| Complete a learned 6-place sequence from a middle start | — | Impaired | Impaired |
| 10 s delayed non-match-to-place, novel room | — | Impaired (lesion and the NMDA-receptor antagonist AP5) | Spared |
| Same task at a 5 min delay | — | Impaired | Impaired (lesion, AP5, apomorphine) |

**The authors' summary rule.** CA3 handles space and the short term (~10 s). CA1 handles time and the intermediate term (5 min–24 h). The two cooperate when a task needs both. The short-term and intermediate-term effects dissociate in **both** directions, so the two stores run in parallel, not as a feedforward chain. Supporting the intermediate-term reading: CA1 immediate-early-gene induction appears at day 1 and is absent at 5 and 28 days. A post-training CA1 lesion at 24 h disrupts recall, and the same lesion at 3 weeks does not.

**The space/time half of the rule is contested** (Eichenbaum 2017, `raw/eichenbaum-2017-integration-space-time-memory.md`, `T414`).

| Against "CA3 = space, CA1 = time" | Finding |
|---|---|
| Lesion | Ten odour pairs, order test. At a 3 s gap, CA3 lesions disrupt order and CA1 lesions do not. At 10 s, both do (Farovik et al. 2010). So CA3 is needed for temporal order too, and the subfields differ by gap length |
| Recording | Time and place are signalled equivalently by CA1 and CA3 populations (Salz et al. 2016). CA1 and CA3 separate overlapping routes equally (Bahar et al. 2012) |
| For the rule | CA3 maps stable and box-specific, CA2 maps drifting over hours, CA1 both (Mankin et al. 2012). CA3 keeps one field across two routes, CA1 separates them (Ito et al. 2015) |

Eichenbaum's reading keeps the short-term/intermediate-term split and drops the space/time split: both fields process time, and the division is by duration bridged.

**Separation is not a hippocampal monopoly.** Lesions including the dentate spare separation of visual objects, of reward value and of motor responses. The source assigns these to inferior temporal and perirhinal cortex, orbitofrontal cortex and amygdala, and caudate respectively, and assigns odour to piriform cortex plus ventral dentate. This is against the human fMRI reading that dentate/CA3 separation is domain-general (`T413`).

### The mode scalar, by dendritic layer

| Site | Effect of acetylcholine | Consequence |
|---|---|---|
| CA3 recurrents and Schaffer collaterals (stratum radiatum) | Presynaptic inhibition of glutamate release through M4 muscarinic receptors | Recurrent read-out and CA3 → CA1 transmission turned **down** |
| Mossy fibres (stratum lucidum), perforant path (stratum lacunosum-moleculare) | Weak | Write port and cue port left **on** |
| Dentate granule cells | Disinhibition: hilar interneurons providing tonic inhibition are suppressed | Write port turned **up** |

- **Evidence that the scalar moves both ways.** The scopolamine/physostigmine double dissociation (*Predictions* table) held in spatial exploration, the Hebb–Williams maze and delay fear conditioning. Depleting septal cholinergic cells (192 IgG-saporin) impairs acquisition.
- **Timescale split.** Septal GABAergic input runs at millisecond, within-theta timescales. Acetylcholine sets the mode over seconds to minutes.
- **The source of the scalar is driven by the store's own output.** CA3 projects through the fimbria to lateral and medial septum. CA1 projects through the dorsal fornix to the same nuclei. The septum's cholinergic projection returns mostly to CA3, and the fimbria cut (above) impairs encoding as a CA3 lesion does.
- **(brainstorm) Machine form.** Make the mode scalar a *signed vector over input classes*: recurrent and output gains down, write-port gain up, cue port unchanged. Drive it from the store's own output. That is closer to `G38`'s closed-loop candidate than to a free-standing mode bit.

### Capacity as a write-rate budget

Retrograde amnesia gradient ≈ 5 weeks (≈ 50,000 min) in monkey. CA3 capacity `p ≈ 50,000`. So average storage is at most **≈ 1 new memory per minute** (the peak rate may approach 1 per second). Prediction: a retrograde gradient is demonstrable only when many new memories are being acquired, not with the few hundred laboratory tasks load. Two more capacity points from the update:

- In the whole-circuit simulation, CA3 stores more patterns with **binary** than with graded rates, because total retrievable information is roughly fixed and graded rates spend it per pattern.
- Human left and right CA3 may be separate networks (left verbal, right spatial), which would roughly double capacity, since `p_max` is set per network by `C^RC`.

### CA1 as recoder (Position B of `T33`, stated in full)

- **Conjunctive recoding.** CA3 holds an episode as linked component ensembles A…E. CA1 competitive learning allocates cells to larger conjunctions (ABC, BDE), so each cortical cell needs fewer, larger fragments at recall. Prediction: relatively more component cells (object *or* place) in CA3 and more object × place cells in CA1. Not yet counted.
- **Expansion for noise robustness.** Spread CA3's information over more CA1 cells and each carries fewer bits (2 → 1 in the worked example). Human CA1 has 4.6 × 10⁶ cells.
- **The direct input.** About 1/6 of CA1's synapses come from entorhinal layer III. They carry the cue's detail alongside CA3's recalled episode.
- **The CA3 → CA1 synapses must be associatively modifiable**, matching the recurrent collaterals' plasticity. Otherwise much of what CA3 recalled is lost at CA1.

### Two output routes, and a test nobody has run

| Route | Fibres | Proposed use |
|---|---|---|
| CA1 → entorhinal → cortical backprojections | Numerically large | Any recall whose target is cortical, e.g. **place → object** (objects are represented in cortex) |
| CA1/subiculum → fornix → mammillary bodies → anterior thalamus → cingulate | ~10⁶ axons | Possibly **object → place / spatial response**, which needs only to pick a response |
| CA3 → fimbria → septum | ~2,000 medial-septal cholinergic cells (rat) | Regulating the hippocampus, not specifying behaviour |

Proposed test: compare object → place and place → object cued recall after cutting the subcortical outputs. Prediction: place → object recall needs CA1 and the cortical route.

### What the theory says the hippocampus is not

- **Not a spatial computer** (against O'Keefe's geometric-map theory, a later goal-cell gradient-ascent model, and a vector-subtraction "compass" model). Its evidence: hippocampal damage impairs learning a new environment but not navigating a familiar one. Parietal and parahippocampal damage give topographical agnosias. Parietal-lesioned monkeys fail a landmark task. In rats, parietal and prelimbic lesions also impair object–place paired-associate learning. Spatial computation is placed in neocortex, using recalled content where needed (`T28`).
- **Not a pointer store** (against indexing theory, [[wiki/concepts/hippocampal-indexing-theory.md]]). Recall to cortex does work like a pointer: "de-addressing" by associatively modified backprojection synapses. But the hippocampus also holds spatial and timing content of its own and binds objects to it.
- **Semantic consolidation happens during waking, not sleep.** Restructuring a semantic store (a bat flies but is not a bird) uses thought and often language. Episodes not actively recalled are overwritten. A new argument against reading post-learning cortical change as transfer: if the CA1 vector changes, fixed CA1 → cortex weights already change cortical firing with no cortical learning (`T34`).

---

## Limitations

- **Capacity numbers are the theory's whole content and are almost never the regime tested.** The paper says so directly: predictions about separation only bite when the store holds thousands of memories, and behavioural experiments load it with a handful. Every confirming test above is run far below capacity.
- **`a` is measured, `k` is not.** `k ≈ 0.2–0.3` "depends weakly on the detailed structure of the rate distribution" — the 36,000 figure inherits that.
- **Sparseness estimates from immediate-early genes are ill-defined** unless the stimulus set is fixed, which most environment-manipulation studies do not do.
- **Forgetting is asserted, not modelled**, and it is `G42`'s cleanest statement: the store has the wiki's most exact capacity formula and no way to know it is near it. The store must forget or overload; heterosynaptic LTD plus random reallocation of CA3 cells is offered as the mechanism, with no rate, no schedule, and no account of what determines the retention window (days? months?) beyond "the rate of new episodes".
- **No learning of structure.** The model stores and retrieves arbitrary bindings; nothing in it discovers that two episodes share a relational form. Generalisation appears only as pattern-associator smearing at the perforant-path and Schaffer stages — i.e. as *tolerance*, not as abstraction. Contrast [[wiki/entities/tolman-eichenbaum-machine.md]], which is the same anatomy built for exactly the thing this model does not do.
- **The premise — that CA3 autoassociates *sensory features* — has a designed experiment against it.** Colgin et al. 2010 morphed a square into a circle for two groups of rats trained identically except that one could walk between the two enclosures through a corridor beforehand. Only that group's CA3 switched abruptly and coherently between two orthogonal maps (square-vs-circle population-vector correlation `0.03 ± 0.11`, sigmoid slopes ~5× steeper, 30/34 fields at one transition point); the group shown both shapes at a single location changed firing **rate** only, linearly, with field locations fixed. Feature coactivation in the recurrent collaterals was equally available to both arms and produced no attractor dynamics, and the authors conclude that "the available evidence does not favour the theory that CA3 is a standard autoassociative network whose purpose is to encode associations among the sensory features of the environment", proposing instead that the collaterals generate **phase sequences** of place codes — routes, and index-code sequences for cortical recall. Two qualifications for this page. The experiment localises the landscape upstream (the sharpest transitions were in CA1, which has almost no recurrence) without showing CA3 has none, and it leaves this page's capacity equations untouched — what it removes is the claim about what is *written* into `C^RC`, not the arithmetic of how much fits (`T389`, `T394`, [[wiki/concepts/attractor-identification.md]]).
- **The dentate/CA3 role assignment has a rival that reverses it** (Lisman 1999, `raw/lisman-1999-relating-hippocampal-circuitry-to-function.md`, `T415`). There the dentate's granule → mossy cell → granule loop is the autoassociator, and CA3 is a **heteroassociator**: its > 100 ms NMDAR window links each item to the next. The two meet through the CA3 → dentate backprojection, which this model leaves without a function. That rival is a theory without a test. This model's input-measured completion result and the symmetric CA3 STDP kernel (Mishra et al. 2016) both count against it. What it adds is a job this model does not cover: keeping a *multi-step* recall from compounding its errors, which a single autoassociator settling once per cue does not address.
- **The CA3 short-term attractor is not what holds the delay once a task is learned** (Kesner & Rolls 2015). CA3 lesions impair acquiring the 10 s delayed non-match-to-place task and transferring it to a new room. Once the task is acquired, CA3 is not needed for it. The theory keeps CA3's role in acquisition (learning the room's cues) and concedes the predicted maintenance role.
- **The source contradicts itself on the sign of the septal loop.** §3.2.7 says CA3's fimbria efferents produce **net inhibition** of the medial septum/diagonal band and CA1's produce net excitation. §3.3.5 explains the fimbria-cut encoding deficit by *assuming* the fimbria output to septum is **excitatory**, so that cutting it lowers acetylcholine. Both cannot hold for the same projection. The closed-loop reading in § *The mode scalar* inherits this unresolved sign.
- **Cell counts in the source are inconsistent.** It says rats have "more CA1 cells than CA3 cells (2.5 × 10⁵)" while giving CA3 as 3 × 10⁵. So the CA1-expansion argument rests on the human figure (4.6 × 10⁶) alone.
- **Primate/rodent divergence is used both ways.** Spatial view cells motivate the primate story; place cells motivate the rodent one; the reconciliation (retinal field of view determines whether a visual-feature conjunction is a "view" or a "place") is a plausibility argument with no measurement.

---

## Comparison to related models

| | Rolls–Treves | [[wiki/entities/tolman-eichenbaum-machine.md]] | [[wiki/entities/cscg.md]] | [[wiki/entities/temporal-context-model.md]] |
|---|---|---|---|---|
| What hippocampus is | An autoassociative *store* | An *index* binding cortical `g` to sensory `x` | The graph itself | A reinstatement operator over EC states |
| Learning | One-trial Hebbian, no objective | Gradient on next-observation prediction | Expectation–maximisation | Hebbian outer product |
| Separation | Random hashing (mossy fibres) | Conjunctive `g × x` | Clone allocation | None — graded overlap |
| Capacity | Closed form, `~C/(a ln(1/a))` | Unstated | Clone-pool hyperparameter | Unstated |
| Transfer across environments | **None** | The point of the model | None | Via context similarity |
| Time | Rate-coded time cells + slow attractor transitions | Not modelled | Sequence states | The core variable |

Read together, the row that matters is the last-but-one: this is the wiki's most quantitatively developed hippocampal model and it has *no* transfer story. Capacity and generalisation are being optimised by different models of the same tissue ([[wiki/empirical-tensions.md]] T28) — **and one source now has both**: [[wiki/entities/vector-hash.md]] keeps a closed-form (exponential) capacity while getting free transfer to a new environment, by making the attractors content-free and prestructured rather than content-defined. The price is that its content-to-address assignment is random, so it inherits this page's other shortfall — nothing notices that two episodes share a form — undiminished.

---

## Connections

- **[[wiki/entities/inhibitory-replay-filter.md]]** — the same CA3 recurrent store with the inhibitory pool made plastic and made *informative*: here inhibition holds sparseness constant so the attractor's capacity formula applies, there its trained structure is a memory of which representations were unpredictable, read out during ripples. The two uses are compatible but nothing prices them together — a mask that varies across cells is a departure from the uniform sparseness the capacity bound assumes.
- **[[wiki/concepts/pattern-separation-completion.md]]** — supplies the quantitative substrate for that page's transfer curve: separation is five named mechanisms with a capacity payoff `p_max ≈ kC/(a ln(1/a))`, and completion is relaxation in a network whose *diluted* recurrence is what makes the basins clean.
- **[[wiki/concepts/complementary-learning-systems.md]]** — fills in the missing return path: recall to cortex is a reverse hierarchy of pattern associators whose fan-out must satisfy `C^HBP = C^RC a_nc/a_CA3`, which is why the backprojection is polysynaptic and why cortex has as many back- as forward projections.
- **[[wiki/concepts/energy-based-models.md]]** — the biological attractor priced: dilution is an energy-landscape argument (multi-synapse pairs distort the basins), and capacity is how many minima the landscape can hold before retrieval of *any* of them fails.
- **[[wiki/concepts/path-integration.md]]** — shares the continuous-attractor formalism and explicitly declines to put path integration in CA3, assigning it to entorhinal cortex; also supplies the many-charts-in-one-CANN result that makes map selection an attractor choice.
- **[[wiki/concepts/working-memory.md]]** — derives the `7 ± 2` span from noise-driven transitions between asymmetrically coupled attractors, i.e. capacity as a dynamical rather than a slot limit, and places order memory in the same recurrent network as episodic storage. It also supplies a lesion-level split: two hippocampal short-term memories run in parallel — CA3 (~10 s, spatial, needed to acquire a delay task but not to perform it once learned) and CA1 (5 min–24 h, carried by the direct entorhinal input) — with prefrontal cortex as the buffer that must take over when the delay contains distraction (Kesner & Rolls 2015).
- **[[wiki/concepts/offline-replay.md]]** — the dissenting position on consolidation: retrieval to cortex should happen during *waking*, because relevance-filtered recall is what should seed semantic structure, and sleep-driven transfer risks consolidating noise-driven confabulation; it also carries the sequence-side counterpart of this page's capacity equations, `c · M ≈ const` — replay of an embedded assembly chain trades connection probability against assembly size at fixed reliability, measured in a spiking net built to the same CA3 statistics whose connectivity this page under-estimates (T49).
- **[[wiki/concepts/synaptic-plasticity.md]]** — states a requirement most Hebbian accounts omit: heterosynaptic LTD is *necessary* alongside LTP for efficient storage and is the proposed forgetting mechanism; also names non-associative mossy-fibre plasticity as a signal-to-noise device.
- **[[wiki/concepts/cognitive-map.md]]** — mixed continuous/discrete attractors are the network-level mechanism for binding an object to a place, and multiple charts in one network are the mechanism for holding many maps at once.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the counterexample: grid codes are treated here as *unsuitable* for episodic binding and are converted by dentate competitive learning into place-like conjunctions, so structural code and memory code are different objects at different stages.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — same anatomy, opposite target: capacity and one-trial arbitrary binding here, transfer and structural generalisation there, with no model doing both.
- **[[wiki/entities/temporal-context-model.md]]** — the rival account of hippocampal time: a graded leaky context integrator versus discrete time-encoding cell populations traversed by noise-driven attractor transitions.
- **[[wiki/entities/cscg.md]]** — the same write-side problem solved by explicit bookkeeping instead of randomization; clone allocation is a decision, mossy-fibre hashing is not.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a fully worked *storage-and-retrieval* layer with the discovery layer absent: arbitrary bindings, exact completion, no mechanism that notices two episodes share a form.
- **[[wiki/entities/vector-hash.md]]** — the rival answer to this page's own question, built on the opposite topology: fixed points prestructured by a frozen grid code instead of defined by stored content, which converts the cliff at `p_max ≈ kC/(a ln(1/a))` into a graceful `1/N_patts` continuum at exponential capacity — and which reports that place-like hippocampal tuning arises from an *untrained* random projection, against this page's simulation result that Hebbian perforant-path training is required ([[wiki/empirical-tensions.md]] T41).
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — the normative layer above this one: attractor dynamics say *how* a map is selected and completed, hidden-state inference says *why* the boundaries fall where they do, with a mixture of Boltzmann machines named as the bridge between basins and hidden states.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the abstraction this model makes and what it costs: interneuron inhibition appears here as a single competitive-learning normalizer enforcing sparseness `a`, but the same anatomy carries four channels with separately verified targets, one of which (*Sst*) controls context generalization — a quantity the sparseness parameter cannot express.
- **[[wiki/entities/sparse-distributed-memory.md]]** — the same capacity question posed feed-forward: fixed points come from the *address sample* rather than from stored content, so capacity (`τ ≈ 0.10·M`) is independent of pattern size and overload is graded cross-talk rather than a cliff. Its optimal sparsity `p = (2MT)^(−1/3)` is this page's `a` derived and made load-dependent, and its address-decoder stage is the dentate's mossy-fibre randomisation running in a cerebellar circuit.
- **[[wiki/entities/stp-flickering-cann.md]]** — takes this model's multi-chart CANN as given and asks what happens *between* charts: which of two stored maps is expressed is `input × gain`, and short-term synaptic facilitation makes gain history-dependent, so attractor selection is not determined by the current cue alone.
- **[[wiki/entities/dense-sequence-memory.md]]** — the machine dual of this page's capacity calculation: identical cross-talk argument, but capacity is bought by steepening the read-out nonlinearity at fixed code rather than by sparsifying the code at fixed fan-in — and it shows the same catastrophic failure on *correlated* patterns that this page's near-orthogonality assumption conceals.
- **[[wiki/entities/adaptive-cann.md]]** — the continuous-manifold version of this page's noise-plus-adaptation walk through stored attractors: the same slow negative feedback, but the state moves along a continuum at a derived speed `v_int` rather than hopping between discrete basins at a noise-set rate, and the transition condition is a closed-form threshold instead of a barrier-crossing statistic.
- **[[wiki/entities/context-modular-memory-network.md]]** — this page's capacity mechanism made reversible: capacity is still bought by lowering effective activity, but the reduction is a per-context mask rather than an anatomical sparsity, so `a` becomes a control variable — and its derived optimum (~20–30% active for tens to hundreds of contexts) coincides with the excitability-based engram sparsity this model treats as fixed.
- **[[wiki/entities/fcann.md]]** — the macroscale counterpart built the other way round: weights measured from activity covariance across 122 whole-brain parcels rather than derived from anatomy, capacity argued from attractor orthogonality rather than computed, and convergence speed validated against a degree-preserving permutation of the same connectome.
- **[[wiki/entities/hopfield-network.md]]** — the abstract model this page makes biological: CA3 recurrent collaterals as the symmetric weight matrix, with sparse coding and dilution added, replacing `0.14N` by `p_max ≈ kC/(a ln(1/a))` — capacity set by fan-in rather than by population size.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the same variables (`a`, fan-in, threshold) entering a recognition-error bound rather than a storage-capacity bound, and the same 1990 observation about sparse codes plus NMDA nonlinearity taken to closed form on binary overlap instead of Euclidean distance; the two disagree about what the storage unit is (T63).
- **[[wiki/concepts/attractor-dynamics.md]]** — the quantitative biological instance of content-defined relaxation — the capacity formula and the catastrophic-overload failure mode this page treats as the regime's price.
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — this model stripped to its function and used as the fast store in a working transport loop (sparse random index, one-shot Hebbian binding, recurrent completion), with a new consequence for the capacity bound: because unpredictable experience never consolidates, the store's capacity constrains steady-state behaviour rather than only the length of the consolidation lag.
- **[[wiki/entities/trnn.md]]** — the same adaptation-walks-the-state mechanism in a trained network with no stored chain: item capacity is measured on tasks (transient nets beat persistent ones with 2/4/6 items) rather than derived, and it shows the primacy-without-recency pattern that a serial-recall design predicts (Liu et al. 2025).
- **[[wiki/entities/spiking-hippocampal-cam.md]]** — the same CA3 built as an engineering artefact and factored the opposite way: the recurrent collaterals that carry this page's capacity are replaced by two directed STDP matrices (`cue→content`, `content→cue`) with recurrence demoted to an inhibitory arbiter, which buys a reverse read this page's autoassociator cannot express and gives up `p_max ≈ kC/(a ln(1/a))` entirely — its capacity is the number of one-hot cue units. It also takes this page's dentate randomisation as an *axiom* (one-hot cue, sparsifier unmodelled) rather than as a mechanism.
- **[[wiki/concepts/hippocampal-long-axis.md]]** — bounds this model's autoassociator: the CA3 longitudinal collaterals that *are* the recurrent matrix diverge freely within the dorsal two-thirds and within the ventral third but barely cross between them, so the closed-form capacity applies to a portion of the axis rather than to CA3 as a whole — and the represented scale differs ~tenfold between the two portions.
- **[[wiki/entities/two-body-dense-associative-memory.md]]** — a rival reading of the same tissue with a different capacity currency: there CA3 is *bipartite* (some pyramidal cells are feature neurons, the rest memory neurons, with place cells proposed as the latter) and capacity is capped by the hidden count `N_h`, where this page reads CA3 as one recurrent population whose capacity is set by fan-in `p_max ≈ kC^RC/(a ln(1/a))`. The two disagree about what a CA3 pyramidal cell is; the cell counts quoted there (≈3×10⁵ rat, 2.3×10⁶ human) come from the same anatomy this page's `C^RC` does (Krotov & Hopfield 2021).
- **[[wiki/concepts/path-integration.md]]** — the rival account of the same tissue, and the one with the discriminating manipulation: attractor dynamics in CA3 are produced by binding cues to coordinates on a preconfigured integrator map rather than by associating the cues with each other, so on that reading this page's recurrent matrix stores routes rather than feature conjunctions (Colgin et al. 2010).
- **[[wiki/concepts/hippocampal-indexing-theory.md]]** — the rival account of what the store holds. Both use learned backprojection synapses to reinstate cortex, which Kesner & Rolls 2015 liken to following a pointer. But this model stores spatial and timing content in the hippocampus and binds objects to it, where indexing theory stores only which cortical modules were coactive.
- **[[wiki/entities/hippocampal-formation.md]]** — the hub that lists this model as the reference for the formation's entire feedforward chain and takes its cholinergic mode scalar as the first row of the circuit's control table, with the connectivity revision as the model's stated omission.
