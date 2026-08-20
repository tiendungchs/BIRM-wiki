# Rolls–Treves Hippocampal Model

**The hippocampus as three named network types wired in series, each with a closed-form capacity: a competitive network (dentate gyrus) that decorrelates, a single autoassociator (CA3) that stores arbitrary one-trial bindings and completes them from any part, and a reverse hierarchy of pattern associators (CA1 → entorhinal → neocortex) that reinstates the cortical activity present at encoding.** (Rolls 2013, developing Rolls 1989–2012 and Treves & Rolls 1992–1994)

The wiki's only source that prices pattern separation and completion in *synapses per neuron*. Where [[wiki/concepts/pattern-separation-completion.md]] gives the transfer curve as a phenomenon, this page gives the equations that say how many memories the curve buys and what wiring is needed to get them.

> **Provenance.** `raw/rolls-2013-pattern-completion-separation.md` — Rolls, *The mechanisms for pattern completion and pattern separation in the hippocampus*, Front. Syst. Neurosci. 7:74.

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

The unresolved point the paper concedes: the natural site is CA3, but part of the temporal-order lesion evidence implicates CA1.

---

## Predictions and their tests

| Prediction | Test | Outcome |
|---|---|---|
| Mossy fibres needed to store, not to recall | Mossy-fibre disruption in rats | Confirmed (Lassalle 1998; Lee & Kesner 2004; Daumas 2009) |
| Direct perforant path needed for recall | Perforant-path lesion, Hebb–Williams maze | Confirmed (Lee & Kesner 2004) |
| CA3 needed for *arbitrary* place↔object associations, not for odour–object | Subregion lesions | Confirmed; odour–object association spared |
| CA3 needed for one-trial object-place recall in both directions | CA3 lesion | Chance performance both ways; matched-delay conditional task unimpaired |
| CA3 needed for completion from partial cue even in reference memory | CA3 NMDAR knockout | Confirmed (Nakazawa 2002; Gold & Kesner 2005) |
| Ambiguous environment → one attractor, not a blend | Square/circle morph recordings | Confirmed (Wills 2005); within-theta-cycle flickering between the two maps (Jezek 2011) |
| Completion within one theta cycle (~120 ms) | Same | Confirmed |
| Direct demonstration of CA3 completion | Voltage-sensitive dye in slice: LTP from two sites, then either site alone evokes the full pattern | Confirmed (Jackson 2013) |
| DG competitive learning turns grid cells into place fields | Simulation | Place-like fields form **only** with Hebbian training in the perforant path — untrained sparse projection is not enough |
| Hippocampal codes sparser than neocortical | Macaque recordings | Confirmed (0.33 vs 0.61–0.81) |

This settles an item [[wiki/concepts/pattern-separation-completion.md]] listed as open ("attractor dynamics in CA3 is a hypothesis with one supporting demonstration"): there are now four independent lines — slice VSD, morph recordings, theta-cycle flicker, and the NMDAR-knockout completion deficits.

---

## Limitations

- **Capacity numbers are the theory's whole content and are almost never the regime tested.** The paper says so directly: predictions about separation only bite when the store holds thousands of memories, and behavioural experiments load it with a handful. Every confirming test above is run far below capacity.
- **`a` is measured, `k` is not.** `k ≈ 0.2–0.3` "depends weakly on the detailed structure of the rate distribution" — the 36,000 figure inherits that.
- **Sparseness estimates from immediate-early genes are ill-defined** unless the stimulus set is fixed, which most environment-manipulation studies do not do.
- **Forgetting is asserted, not modelled.** The store must forget or overload; heterosynaptic LTD plus random reallocation of CA3 cells is offered as the mechanism, with no rate, no schedule, and no account of what determines the retention window (days? months?) beyond "the rate of new episodes".
- **No learning of structure.** The model stores and retrieves arbitrary bindings; nothing in it discovers that two episodes share a relational form. Generalisation appears only as pattern-associator smearing at the perforant-path and Schaffer stages — i.e. as *tolerance*, not as abstraction. Contrast [[wiki/entities/tolman-eichenbaum-machine.md]], which is the same anatomy built for exactly the thing this model does not do.
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

- **[[wiki/concepts/pattern-separation-completion.md]]** — supplies the quantitative substrate for that page's transfer curve: separation is five named mechanisms with a capacity payoff `p_max ≈ kC/(a ln(1/a))`, and completion is relaxation in a network whose *diluted* recurrence is what makes the basins clean.
- **[[wiki/concepts/complementary-learning-systems.md]]** — fills in the missing return path: recall to cortex is a reverse hierarchy of pattern associators whose fan-out must satisfy `C^HBP = C^RC a_nc/a_CA3`, which is why the backprojection is polysynaptic and why cortex has as many back- as forward projections.
- **[[wiki/concepts/energy-based-models.md]]** — the biological attractor priced: dilution is an energy-landscape argument (multi-synapse pairs distort the basins), and capacity is how many minima the landscape can hold before retrieval of *any* of them fails.
- **[[wiki/concepts/path-integration.md]]** — shares the continuous-attractor formalism and explicitly declines to put path integration in CA3, assigning it to entorhinal cortex; also supplies the many-charts-in-one-CANN result that makes map selection an attractor choice.
- **[[wiki/concepts/working-memory.md]]** — derives the `7 ± 2` span from noise-driven transitions between asymmetrically coupled attractors, i.e. capacity as a dynamical rather than a slot limit, and places order memory in the same recurrent network as episodic storage.
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
