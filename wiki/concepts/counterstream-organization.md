# Counterstream Organization

**Feedforward and feedback are not two pathways running between areas; they are two *counterstreams* running inside each of two laminar compartments. Ascending and descending axons are segregated into distinct sublayers (2/3A descending, 3B ascending) and almost never share a parent cell (<1–2% double-labelled), while the properties normally attributed to direction — topographic precision, axonal bifurcation, projection distance — turn out to be properties of the *layer*. Feedback looks diffuse only because infragranular cells dominate it.**

Every predictive architecture in the wiki buys its up/down asymmetry from an anatomical claim: feedforward is sparse, topographic and driving; feedback is divergent, diffuse and modulatory. This page holds the quantitative retrograde-tracing measurement of that claim on one macaque parcellation, and the measurement mostly takes the claim apart: the asymmetry is real but it is indexed by compartment, not by direction, and it only becomes a clean dichotomy at long range.

> **Provenance.** `raw/markov-2014-anatomy-of-cortical-hierarchy.md` — Markov, Vezoli, Chameau, Falchier, Quilodran, Huissoud, Lamy, Misery, Giroud, Ullman, Barone, Dehay, Knoblauch & Kennedy, *J. Comp. Neurol.* 522(1):225–259, 2014 (published online 2013). Primary data: quantitative retrograde tracing (Fast blue, Diamidino yellow) in **26 macaques**, 11 injected areas (V1, V2, V4, TEO, TEpd, MT, DP, STPc, 7A, 8L, 8m), **339 pathways**, plus paired side-by-side injections for topography, simultaneous V1+V4 injections for stream segregation, and *ex vivo* biocytin filling of 46 retrogradely identified V2 neurons for dendritic morphology. Anesthetized terminal experiments; no physiology in this paper — the frequency-band claims it cites are other people's.

---

## SLN%: what the measurement actually is

`SLN = S / (S + I)` — of the neurons retrogradely labelled in a source area after an injection in a target area, the fraction lying **above** layer 4. `FLN` (fraction of labelled neurons) is the same pathway's share of all labelled neurons in the hemisphere, i.e. its **weight**.

The hypothesis under test is that SLN is a ruler for hierarchical distance. Three versions, and only the weakest survives:

| Version | Prediction | Result |
|---|---|---|
| **Strong** — SLN differences are identical regardless of injection site (a rigid ruler that can be slid) | SLN values from a common source to two different injection sites fall on a line of **unit slope** | Holds for V1, V2, V4, TEO, TEpd, MT, DP. Fails for 8L, 8m, STPc, 7A |
| **Weak** — the ruler may stretch or contract per injection site | Any straight line, unconstrained slope | Correlations across all 11 areas: range (−0.15, 0.92), **mean 0.43**. Restricted to the seven consistent areas: **mean 0.67** |
| **Weak + probit transform** (SLN is bounded on (0,1), so variance is not homogeneous) | Same, on `Φ⁻¹(SLN)` | Seven-area mean rises to **0.73** (median 0.81). The high-order areas gain nothing; 8L and 8m, which are adjacent, show **no correlation at all** |

**The estimator.** Hierarchical levels `β` are fitted by maximum likelihood from `μ = Φ(Xβ)` where `X` is the incidence matrix of the injected cortical graph (one row per projection, `−1` source / `+1` target). Neuron counts are overdispersed, so a binomial GLM is rejected in favour of a **beta-binomial** with an explicit dispersion parameter `φ`; the probit link beats the identity link on predicted-vs-observed SLN (`z = 2.15`, `P = 0.03`). The model is singular by construction (rows sum to zero) — one area is pinned (V1 ≡ level 1) and the hierarchy is only determined up to an affine transform.

| What the fit buys | What it does not buy |
|---|---|
| A *continuous* hierarchical distance for every pathway, replacing FVE's discrete levels and their ~150,000 equally consistent orderings (Hilgetag et al. 1996) | A unique hierarchy. 95% confidence intervals on the estimated levels are **±1 to ±2 levels** |
| A distribution of SLN values that is **approximately uniform** above 0.1 with no clustering — i.e. positive evidence that levels are a continuum, not bins | Any hierarchy at all above the ventral stream: for 8m, STPc and 7A the SLN ruler is not consistent between injections |
| One concrete revision of Felleman & Van Essen: the frontal eye field **splits**, with 8L falling from level 8 to the level of **V4** while 8m stays high; V1 and V2 project directly to 8L | A causal or functional claim — the correlation with Granger-causal influence during attention (Vezoli et al.) is cited, not measured here |

**The wiki's previous statement of this rule was too strong.** [[wiki/concepts/canonical-cortical-microcircuit.md]] carried "ranking by SLN% yields a **single** hierarchy". It yields an *optimized* one with a stated uncertainty of one to two levels, over a subgraph, and the authors' own closing speculation is that "the functional hierarchy is dynamic and task-dependent, with the structural hierarchy providing boundary values" — a range, not a coordinate. Recorded as [[wiki/empirical-tensions.md]] `T378`.

---

## SLN is not a primitive: it is generated by two distance constants

The finding that makes SLN mechanistically legible. Split each pathway's weight into its supragranular and infragranular parts (`SLN·FLN` and `(1−SLN)·FLN`) and regress each on physical distance through white matter:

| Pathway type | Which layer's weight decays faster with distance | Therefore |
|---|---|---|
| **Feedback** (n = 88) | Supragranular steeper (`F(1,173) = 37.4`, `P < 0.001`) | Infragranular cells project *further* downward → SLN falls as FB distance grows |
| **Feedforward** (n = 39) | Infragranular steeper (`F(1,75) = 8.92`, `P < 0.01`) | Supragranular cells project *further* upward → SLN rises as FF distance grows |

So SLN is a **combinatorial distance rule**: each compartment has its own space constant in each direction, and the observed laminar ratio is their ratio at a given separation. Restated as four streams:

| Stream | Layer | Direction | Range |
|---|---|---|---|
| 3B | supragranular | feedforward | **long** |
| 2/3A | supragranular | feedback | **short** |
| 5/6 | infragranular | feedforward | short |
| 6 | infragranular | feedback | **long** |

Weight follows: `FLN` is highest at `SLN ≈ 0.5` (adjacent or lateral pairs, short distance) and falls toward both `SLN → 0` and `SLN → 1`. Hierarchical distance and physical distance are the same axis, seen twice.

**(brainstorm) The transferable object is a hierarchy that is emergent rather than declared.** A builder normally writes depth in as a layer index. Here depth is a *read-out* of two exponential connection-probability kernels with different length constants for the two directions — i.e. fix `p(edge | Δx, type)` per port type and the hierarchy falls out of the geometry, with the continuous SLN estimate recoverable from the trained model's typed edges. That is the same low-rank generator [[wiki/concepts/canonical-cortical-microcircuit.md]] proposes from IT subclasses, arrived at from distance statistics instead of from genes, and it explains why a discrete depth index is under-determined: the underlying quantity is continuous and noisy.

---

## Topographic precision is a property of the layer, not of the direction

The load-bearing negative result. Side-by-side dual-tracer injections (2–3 mm apart) in V1 and in V4 let projection-zone area, overlap and double-labelling be compared between compartments *within* the same pathway.

| Measurement | Result |
|---|---|
| Infragranular vs supragranular projection-zone area, V1 injections (3 animals, sources V2/V3/MT, 18 observations) | Infragranular **~12× larger** (`F(3,13) = 74.7`, `t(8) = 6.47`, `P < 0.0001`) |
| Same, V4 injections (3 animals, sources V3/MT/TE/TEO) | Infragranular **~2× larger** (`t(11) = 4.83`, `P < 0.0001`) |
| Overlap extent and double-labelled fraction | Higher in infragranular in every case |
| Supragranular **feedback** pathways vs supragranular **feedforward** pathways | "Very similar" point-to-point precision |

So convergence, divergence and axonal bifurcation rate track the compartment and are indifferent to whether the pathway ascends or descends. Feedback pathways are diffuse *on average* only because infragranular cells contribute most of them.

**This removes an argument the wiki has been leaning on.** The standard licensing story for hierarchical generative models (Friston) pairs FF = sparse-bifurcating + topographic + supragranular against FB = abundantly-bifurcating + diffuse + infragranular, and reads the asymmetry as driver-vs-modulator. The source states the objection directly: *"these characteristics do not distinguish between FF and FB so much as between infragranular and supragranular pathways."* Both pathways have both components; the labels inherited the properties of whichever compartment happens to dominate. A model that wants a genuinely asymmetric top-down channel has to justify it from something other than topography — and the only place the dichotomy is clean is **long range**, where FF comes uniquely from 3B, is point-to-point and targets layer 4, while FB comes uniquely from layer 6, is diffuse and targets layer 1. Seventy-five percent of corticocortical neurons are short-to-medium range and show no such split.

---

## The counterstreams are segregated at sublayer resolution and almost never share a cell

Simultaneous Diamidino yellow in V1 and Fast blue in V4, read in V2 and V3 — where the V1-projecting cells are *feedback* and the V4-projecting cells are *feedforward*:

| Observation | Value |
|---|---|
| Supragranular split (regression-tree model over 19 pathways, areas V1/V2/V4/STP/TEO/8L) | Upper **2/3A = FB**, lower **3B = FF**, split at mid-depth of the supragranular compartment |
| Infragranular split | FB dense in the lower two-thirds (layer 6 + bottom of 5); FF spread throughout 5 and 6 — the two are **intermingled** |
| Cells with both an FF and an FB collateral | **<1% in V2, 2.2% in V3**, and largely infragranular |
| Cells projecting to both V1 and V4 when *both* projections are FB (areas above V4) | 6% → **30%**, rising with hierarchical distance |
| Local integration: supragranular cells with an intrinsic axon collateral | **2.6%** of V1→V4 FF cells vs **13.6%** of V4→V1 FB cells |

The last two rows are the interesting asymmetry. A cell may freely broadcast the *same* descending message to several targets — and does so more as distance grows — but a single cell essentially never carries one message up and another down. Direction is a property of the cell, and the two directions are **anatomically prevented** from being emitted by one neuron. This confirms Ullman's counterstream hypothesis on segregation and refutes it on reciprocity: FB pathways are **~2× as numerous** as FF pathways and reach further, so many FB pathways have no FF counterpart.

| Incidence and weight (339 pathways) | |
|---|---|
| FB pathways vs FF pathways per target area | **~2:1**, and the ratio holds for mid-hierarchy targets (TEpd, TEO, DP, MT, V4, 8m, 8L), so it is not a V1/V2 artefact |
| Cumulative FLN of FF vs FB into a given area | **not significantly different** → mean FF pathway weight exceeds mean FB pathway weight |
| Share of neurons in projections **< 10 mm** | ~**80% feedforward** |
| Share of neurons in projections **> 10 mm** | ~**60% feedback** |

**(brainstorm) Read as a budget this is a dense short-range ascending net wrapped in a sparse long-range descending web.** Top-down is many-thin-channels, bottom-up is few-thick-channels, at equal total investment. The machine analogue is not a symmetric autoencoder: it is a forward path with high per-edge bandwidth and a context path with high fan-out and low per-edge bandwidth — closer to a wide, low-rank conditioning signal than to a transposed weight matrix. It also says a top-down signal is cheap to address to *many* levels at once and expensive to address precisely, which is the resource story [[wiki/concepts/broadcast-hierarchy.md]] needs and argues from a different dataset.

---

## Chains and loops, and what layer 6 is denied

Combining the retrograde results with the anterograde literature gives each stream a dendritic as well as an axonal address (the source's Figure 12B):

| Stream | Receives via | Emits to | Reading |
|---|---|---|---|
| **3B FF** | basal dendrites in 3B/4 — direct FF input from 3B of the area below | layer 4 of higher areas | an **FF chain**: level → level, no exit |
| **2/3A FB** | apical tuft in **layer 1** | layers 1 and 2/3A of lower areas | an **FB chain** |
| **layer 6 FB** | apical dendrite in **layer 4** | layer 6 of adjacent areas; **layer 1** of far-distant lower areas | an **FB loop** — reads the ascending stream |
| **layer 5 FF** | apical dendrite reaching layer 1 in 4 of 9 filled cells ("tall simple" type) | higher areas | an **FF loop** — reads the descending stream |

Cell filling (46 recovered V2 neurons, all pyramidal): every supragranular cell had a tufted apical dendrite whether FF or FB; layer 6 cells of both directions and layer 5 FB cells had slender apicals that do not reach layer 1; **4 of 9 layer-5 FF cells did reach layer 1**, three branching there. FF somata were larger than FB somata.

**The architectural denial, and it is sharp.** The *major* feedback population — layer 6, the one carrying long-distance FB — has **no apical tuft in layer 1**. Layers 2/3 and 5 are the only layers reported to respond to layer-1 stimulation and to show monosynaptic responses to feedback. So the coincidence-detection port that [[wiki/concepts/apical-amplification.md]] makes the site of cortical association is available to **feedforward** cells and to **short-range feedback** cells, and is *not* available to the long-range descending stream. Top-down gain control via layer 1 therefore modulates the ascending stream and the local descending stream, but cannot modulate the long-range descending stream in the same way — the broadcast arm is not itself apically gated. Any architecture that implements "feedback gates feedback" through the apical mechanism is asserting something the anatomy denies at its longest range.

---

## What the paper says about drivers and modulators

The FF-drives / FB-modulates rule is treated as a useful approximation with documented exceptions, all inherited:

| Exception | Source cited |
|---|---|
| Long-term V1 lesion leaves robust visual activity in V2 (though acute V1 inactivation silences it) — V2 has its own moderate LGN input | Schmid et al.; Girard & Bullier; Markov et al. |
| Silencing **V2** *facilitates* V1 responses by reducing surround suppression | Nassi et al. |
| After thalamic inactivation, superficial cat V1 cells still respond — and that response is abolished by removing **V2** | Mignard & Malpeli |
| Frontal feedback **drives** memory recall | Tomita et al. |
| Inactivating MT abolishes the visual response of some superficial V2 cells | Hupé et al. |
| Attentional gamma coherence originates in FEF, *precedes* the V4 firing-rate increase, and comes from FEF **supragranular** cells | Gregoriou et al. |

Plus the frequency split the paper uses to argue that the two compartments have distinct dynamics, not just distinct wiring: **gamma in supragranular, beta (and alpha) in infragranular** (Buffalo et al.; Bollimunta et al.; Xing et al.), with a functional distance rule built from interareal Granger-causal influence during attention reported to correlate with SLN (Vezoli et al.). That correlation is the hinge between this page's anatomy and [[wiki/entities/early-visual-system.md]]-scale dynamics, and it is cited here rather than measured. **It has since been measured** — next section.

---

## The head-to-head: the same hierarchy read off dynamics

> `raw/bastos-2015-feedforward-feedback-frequency-channels.md` — Bastos et al., *Neuron* 85(2):390–401, 2015. Subdural ECoG over 8 of this page's areas in 2 awake macaques, correlated against SLN from the 25-monkey tracing set. Full measurement on [[wiki/concepts/inter-areal-synchrony.md]]; what belongs here is what it does to the anatomy.

| Question this page left open | Answer |
|---|---|
| Does the compartment→frequency mapping (supragranular gamma, infragranular beta) survive as a *directed* interareal claim? | Yes, and it is read off a correlation spectrum rather than assumed: Granger-influence asymmetry correlates **positively** with SLN at theta (~4 Hz) and gamma (60–80 Hz), **negatively** at beta (14–18 Hz) |
| Is a hierarchy recoverable from dynamics alone? | Yes — a multiband asymmetry index reproduces the fitted anatomical hierarchy at `R = 0.93`, and is as globally consistent as the anatomy is (86% of pairs vs. 80% of pathways, `p = 0.79`) |
| Is the anatomical hierarchy a coordinate or a boundary condition? | **A boundary condition, and only for the posterior areas.** The correlation between the two hierarchies is `R = 0.93` postcue, `R = 0.91` precue and **not significant before stimulus onset**; V1→7A hold their order throughout while 8L and 8m fall to the bottom of the functional hierarchy prestimulus |

**Two independent methods fail on the same areas.** This page's own limitation — 8m, STPc and 7A give SLN that is inconsistent between injections, and 8L and 8m correlate at ~0 — is not a tracing artefact peculiar to anatomy. The frontal areas are also the only ones whose *functional* level moves with task epoch. An area whose depth cannot be measured consistently and an area whose depth genuinely changes are indistinguishable in a single-epoch anatomical study, which is a live reading of `T378` this page should carry: the ruler may be failing in frontal cortex because there is nothing static there to measure.

**The mechanism the anatomy supplies for the override.** Every short-to-medium-range pathway on this page mixes both compartments (75% of corticocortical neurons), so a change in the *laminar balance of drive* to one area reweights its two counterstreams without any change of wiring. Bastos et al. state the consequence as a control law: superficial drive raises an area's gamma output and moves it **down** the hierarchy; deep drive raises its beta output and moves it **up**. Hierarchical position becomes a per-area scalar with a named actuator — untested, and it requires the multilayer multi-area recording neither paper has.

**(brainstorm)** This is the cleanest reading available of what the anatomy is *for*: the two distance constants of the section above fix a **prior** over depth (with the ±1–2 level interval as its width), and the laminar gain balance supplies the **posterior** per task. A builder copying this gets a depth index that is neither hard-coded nor free — a learned per-edge bias plus a runtime scalar per node, where the bias is expensive to change and the scalar is cheap.

---

## Limitations

| Limit | Consequence |
|---|---|
| Retrograde tracing counts **cell bodies**, not synapses | Every weight on this page is a neuron count; a pathway with few parent cells and large terminal arbors would be scored weak. The authors flag anterograde quantification at synaptic resolution as the missing complement |
| The hierarchy is fitted, not observed | Levels carry ±1–2 level confidence intervals and are identified only up to an affine transform, with V1 pinned by fiat |
| It fails where the wiki most needs it | 8m, STPc and 7A — association cortex — give inconsistent SLN across injections; two adjacent frontal-eye-field subdivisions correlate at ~0 |
| Prefrontal areas were **excluded** from the distance-rule fit | They "overrun the distance and hierarchy rules"; the combinatorial distance rule is a visual/posterior result |
| Anesthetized, terminal, macaque visual cortex, one parcellation (M132) | Nothing here constrains rodent, where feedforward and feedback populations are reported not always to occupy different layers ([[wiki/concepts/canonical-cortical-microcircuit.md]]) |
| Cell morphology: **n = 46** filled neurons, **9** layer-5 FF cells, in juveniles (21–60 days) | The tall-simple layer-5 FF finding — the cell that gives the FF loop its layer-1 access — rests on 4 cells in immature animals |
| No physiology | Every dynamical claim (gamma/beta, Granger, attention) is cited from other papers; the compartment-to-frequency mapping is an inference from two separate literatures |
| "Lateral" connections are abolished by fiat | The FVE category of same-level connections is not used here; pathways near `SLN = 0.5` are simply short ones, which is a modelling choice with consequences for any heterarchy claim |

---

## Connections

- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — supplies the quantitative version of that page's SLN% section and weakens its claim: the rule yields an optimized hierarchy with ±1–2 level confidence intervals over the ventral stream rather than a single cortical ordering, and the laminar properties that page attributes to feedforward and feedback pathways (topography, bifurcation, divergence) are shown to belong to the supragranular/infragranular compartments regardless of direction.
- **[[wiki/concepts/apical-amplification.md]]** — the anatomical restriction on where that mechanism can run: layer-6 cells, which carry the long-range feedback, have slender apical dendrites that never reach layer 1, so the apical coincidence port is available to feedforward and short-range feedback cells and architecturally denied to the long-range descending stream.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — removes one of the anatomical arguments that framework uses for its up/down asymmetry (feedforward topographic and driving, feedback divergent and modulatory) by showing the asymmetry indexes layer rather than direction, and leaves it standing only for the long-range pathways that originate exclusively from layer 3B and layer 6.
- **[[wiki/concepts/broadcast-hierarchy.md]]** — an independent anatomical route to the same asymmetry measured on a different dataset: descending pathways outnumber ascending ones ~2:1 and cross more levels at equal cumulative weight, so top-down is many low-weight wide-fan channels, which is the resource profile a broadcast apex requires.
- **[[wiki/concepts/dendritic-computation.md]]** — where the compartment story becomes a cell story: which stream a projection neuron belongs to predicts whether its apical dendrite is tufted in layer 1 or slender, so the input compartments available to a cell are set by its projection role rather than only by its layer.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — the dynamical counterpart the anatomy predicts, now measured against it in the same areas: Granger-influence asymmetry correlates positively with this page's SLN at theta and gamma and negatively at beta, so the compartment→frequency mapping does survive as a directed interareal claim — and because every short-range pathway mixes both compartments, the frequency-tagged hierarchy is free to move with task where the SLN-derived one cannot (Bastos et al. 2015).
- **[[wiki/concepts/timescale-hierarchy.md]]** — a caution on the axis that page lays its gradient along: the anatomical depth coordinate is continuous, uncertain by one to two levels, and not consistently defined for association cortex, so any monotone gradient claimed against it inherits that uncertainty.
- **[[wiki/entities/early-visual-system.md]]** — the parcellation and the pathways this hierarchy is fitted on, with one concrete revision: area 8L of the frontal eye field sits at the level of V4 and receives direct V1 and V2 input, which is compatible with its driving attentional effects in V4 rather than sitting eight levels above it.
- **[[wiki/entities/ventral-visual-stream.md]]** — the only part of cortex where the ruler works: V1, V2, V4, TEO and TEpd (plus MT and DP) give consistent SLN across injections, which is why the ventral stream is where a depth coordinate is safe to assume and association cortex is where it is not.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a worked case of inferring hidden structure from observations with the uncertainty carried: the hierarchy is a maximum-likelihood fit of a latent node ordering to edge-level laminar ratios under a beta-binomial noise model, and the honest output is an interval per node, not a rank.
