# Human Supragranular Pyramidal Neuron — what the human cortical unit has that the rodent one does not

**The principal excitatory cell of human cortical layers 2/3, read as a *unit specification* rather than as anatomy: ~3× the dendrite of a mouse cell, ~2× the synapses, dendritic branches that can compute exclusive-or, synapses that recover from depression ~3× faster, and firing that tracks inputs up to ~1000 Hz. The review's thesis is that human cortex scaled per-unit capacity and wiring rather than unit count, and that the same unit properties vary with intelligence *within* humans.**

> **Provenance.** `raw/galakhova-2022-evolution-of-cortical-neurons-supporting-human-cognition.md` — Galakhova, Hunt, Wilbers, Heyer, de Kock, Mansvelder & Goriounova, *Evolution of cortical neurons supporting human cognition*, Trends Cogn. Sci. 2022 (doi 10.1016/j.tics.2022.08.012). A review from the Amsterdam group behind the human-tissue IQ studies. **Every number below is reported second-hand through the review**; the primary study is named in each row. Human tissue comes from neurosurgery (the review does not state the patient conditions), and most comparisons are human vs **rodent**, not human vs other primates — the review's own first outstanding question.

This is the per-unit half of [[wiki/architectural-gaps.md]] `G101` (what a higher synapse-per-unit ratio buys), which [[wiki/concepts/cellular-scaling-rules.md]] answers only per clade.

---

## Anatomy and function — the measured differences

### Cortical sheet

| Property | Human | Comparison | Primary source |
|---|---|---|---|
| Supragranular (L2/L3) share of cortical thickness | **~50%** | Other primates 46%, carnivores 36%, rodents 19% | Hutsler et al. 2005 |
| Laminar origin of cortico-cortical projections | Shifted **up**, from L5/L6 to L2/L3 | Monkeys and other primates: more from deep layers | Goulas et al. 2018 |
| Neuron count | What a primate brain of that size predicts | Cortex holds 20–25% of brain neurons in most mammals, humans included, while cortex reaches 82% of brain mass | Herculano-Houzel 2012 |
| Neuron density vs brain size | Falls as brains and cortical thickness grow, across mammals "including primates" | — | DeFelipe 2011; Balaram & Kaas 2014; Semendeferi et al. 2011. **Conflicts with the invariant primate density of Herculano-Houzel 2009** — see `T301` |
| Synapse density | Roughly constant across species | → synapses **per neuron** highest in humans | Elston et al. 2001; Sherwood et al. 2020; Benavides-Piccione et al. 2002 |
| L5 extratelencephalic (subcortical-output) neurons | **2–6%** of L5 | Rodents 20–30% | Kalmbach et al. 2021 |

### Cell

| Property | Human | Comparison | Primary source |
|---|---|---|---|
| Dendrite size, L2/L3 | **~3×** mouse | Not an upscaled mouse cell: longer terminal segments | Mohan et al. 2015; Deitcher et al. 2017 |
| Dendritic growth | L3 basal dendrites keep branching through childhood and adolescence | — | Petanjek et al. 2008 |
| Synapses per L2/L3 neuron | **~2×** mouse or rat | — | DeFelipe et al. 2002 |
| Spines | Larger, longer, denser; apical tree most of all | — | Benavides-Piccione et al. 2002, 2013; Anton-Sanchez et al. 2017 |
| Presynaptic vesicle pool and active zone | **~3×** rodent | Larger single-connection currents | Molnár et al. 2016; Yakoubi et al. 2019 |
| Specific membrane capacitance, large L3 cells | **Lower** than rodent (cable-model fit) | Less charging current, so distal input reaches the soma with less loss | Eyal et al. 2016 |
| Hyperpolarization-activated current `I_h` (HCN channels) | High and ubiquitous in supragranular excitatory cells | Not in mouse | Kalmbach et al. 2018 |
| Transcriptomic types, L2/L3 temporal cortex | Five: *LTK*, *GLP2R*, *FREM3*, *CARM1P1*, *COL22A1*; *CARM1P1* and *COL22A1* have **no mouse homologue** | *FREM3* is the most abundant and most internally diverse type | Berg et al. 2021 |
| Within-type diversity | Larger than mouse in morphology, physiology and expression; in human L5, across-neuron variation exceeds the human–rodent difference for most physiological features | — | Berg et al. 2021; Kalmbach et al. 2021 |

### Synapse and spike

| Property | Human | Rodent | Primary source |
|---|---|---|---|
| L2/L3 excitatory connections | Stronger and more reliable; L3 cells give the largest excitatory responses of any layer | — | Campagnola et al. 2022; Hunt et al. 2022; Seeman et al. 2018 |
| Recovery from short-term depression | **~3× faster** | — | Testa-Silva et al. 2014 |
| Information transferred per connection during spike trains | Up to **9×** rodent | Rodent depressing synapses predicted optimal only at very low rates (Fuhrmann et al. 2002) | Testa-Silva et al. 2014 |
| Short-term plasticity sign by sublayer | **L2 facilitates, L3 depresses** | — | Campagnola et al. 2022 |
| Local routing | Preferentially one-way, L2 → L3 | — | Campagnola et al. 2022 |
| Single presynaptic spike | Can trigger a cascade of precisely timed polysynaptic events | — | Molnár et al. 2008; Szegedi et al. 2017 |
| Input frequency tracked by spike timing | **Up to ~1000 Hz** | 200–300 Hz | Testa-Silva et al. 2014 |
| Spike onset speed during sustained firing | Maintained at task-level rates (~30 Hz for minutes) | Degrades | Testa-Silva et al. 2010 |
| Concept-cell sparseness | **0.2–1%** (human medial temporal lobe) | 33% (monkey inferotemporal cortex) | Waydo et al. 2006; Young & Yamane 1992 |

---

## Computational role

| Claim | Evidence grade | Content |
|---|---|---|
| **A dendritic branch can compute exclusive-or** | Direct recording, human L2/3 (Gidon et al. 2020) | Dendritic Ca²⁺ action potentials fire only inside a **narrow window of input strength**; above it the response falls. One strong input is passed, two coincident inputs are cancelled, so one cell computes XOR — a function a single threshold unit cannot compute. Rodent L2/3 dendrites are not readily excitable in this way (Larkum 2022) |
| **Branches are more separate compartments** | Contested within human L5 | For: human L5 distal dendrites are *less* electrogenic than rodent, rabbit, marmoset or macaque, and K⁺ and HCN currents are lower than cell size predicts (Beaulieu-Laroche et al. 2018, 2021). Against: human L5 extratelencephalic cells show strong dendritic electrogenesis and high-frequency bursts at near-threshold input (Kalmbach et al. 2021). The review attributes the split to recording site and targeted subtype, and says other mechanisms may be involved |
| **Distal input is accelerated, not just preserved** | Modelling on measured cells | `I_h` makes synaptic input arrive at the soma sooner, and distal inputs on large L3 cells gain most (Kalmbach et al. 2018); low capacitance adds to this (Eyal et al. 2016) |
| **Bandwidth** | Paired recordings plus models | Fast recovery from depression plus fast spike onset — the large dendrite acts as a current sink (Eyal et al. 2014) — lets one connection carry high-rate trains |
| **Human cells are harder to imitate, and the gap peaks in L2/3** | Modelling on reconstructed cells (Aizenbud et al. 2026) | Fixed 3-layer network fitted to 24 compartmental models. Functional Complexity Index **0.38 human vs 0.22 rat**. Human per-cell complexity peaks in **L2/3**, rat in **L5**. Part of the gap is morphology alone (rat synapses on human trees still score higher). The rest needs NMDA conductance *and* steepness together; each alone adds little. Human models had no active dendritic conductances, so the band-pass Ca²⁺ branch above is **not** part of this gap ([[wiki/concepts/neuron-complexity-index.md]]) |
| **Sparser codes follow from richer units** | The review's inference, untested | More computation per cell → fewer cells per concept. The 0.2–1% vs 33% comparison mixes brain areas (medial temporal lobe vs inferotemporal cortex) and sparseness measures, so it does not isolate a species effect |

---

## Within humans: the same variables track intelligence

| Study | Finding | Grade |
|---|---|---|
| Goriounova et al. 2018 (temporal cortex, neurosurgical tissue vs preoperative IQ) | Higher IQ ↔ thicker temporal cortex, **larger, more complex L2/L3 dendrites**, and spike onset that stays fast during repeated firing; models built on the measured dendrites process fast inputs with higher temporal precision | Correlational |
| Heyer et al. 2021 | Higher general and verbal IQ ↔ thicker **L2/L3 only**, other layers unchanged; the thicker layers hold **larger cells at lower density, not more neurons** | Correlational |
| Meta-analyses (McDaniel 2005; Pietschnig et al. 2015) | Brain volume correlates with IQ across individuals | Correlational, population design |

**The review's thesis:** the features that separate human from rodent cortex (thicker L2/L3, larger and more complex dendrites, faster signalling) are the same features that vary with IQ within humans. **Its own caveat:** every link between neuronal features and cognition is correlational, and no manipulation has been run.

**Collision with [[wiki/concepts/cellular-scaling-rules.md]]:** that page reports that brain size does **not** correlate with cognitive ability *within human families*; the meta-analyses above report that it does *across* individuals. The two designs differ — a within-family comparison removes shared background — so both can hold, but they disagree about whether volume is a cause or a correlate of shared background.

---

## How it maps to model components

| Biological feature | Model component | Note |
|---|---|---|
| Band-pass Ca²⁺ branch (Gidon et al. 2020) | A branch with a **non-monotonic** (bump) activation | The branch-detector model of [[wiki/concepts/dendritic-computation.md]] is monotone (fire above `θ`), so it cannot express this. (brainstorm) A unit made of bump-activated branches computes parity-like functions with no hidden layer — the within-unit form of the "reader nonlinear in the group" that [[wiki/concepts/higher-order-interactions.md]] says pairwise readers lack |
| 2× synapses at similar or lower cell density | Fan-in per unit raised at fixed unit count | This is exactly the `G101` axis. Heyer et al. 2021 is the closest the wiki has to an experiment on it: variation in cell size at no gain in cell number, tracking a behavioural score — but it is observational, not a sweep |
| Fast recovery from depression | Tsodyks–Markram synapse with small `τ_r` | Moves the depressing synapse from a low-pass change detector to a high-rate channel ([[wiki/concepts/synaptic-plasticity.md]]) |
| L2 facilitating, L3 depressing, one-way L2 → L3 | Two stacked sublayers with **opposite short-term plasticity sign** | (brainstorm) A filter pair: facilitating synapses weight sustained high-rate input, depressing synapses weight sparse onsets. The review reads L3 as favouring "sparse but strong" activation |
| Cortico-cortical output shifted to L2/L3 | Inter-module messages sent from the recurrent tier rather than the output tier | In [[wiki/concepts/canonical-cortical-microcircuit.md]] L2/L3 is where recurrent amplification happens; in humans it is also where more inter-areal messages start |
| Within-type diversity larger than across-species difference | Per-unit parameter heterogeneity | The biological premise of [[wiki/concepts/neuronal-parameter-heterogeneity.md]] |
| Human-only types (*CARM1P1*, *COL22A1*) | New unit types, not only rescaled old ones | The one row where human cortex is argued to have *added* a component — contrast the "no new modules" result of [[wiki/concepts/emergent-modularity.md]] |

---

## Limitations

| Limit | Consequence |
|---|---|
| Review; all numbers second-hand | Primary methods, sample sizes and effect sizes are not in the source |
| Human vs rodent, not human vs ape | Which features are human-specific rather than primate-general is the review's first open question |
| Neurosurgical tissue | Tissue is resected from patients; the review does not state the conditions, so a disease effect on the IQ correlations is not excluded |
| Correlational throughout | No manipulation links a gene, a cellular phenotype and a cognitive score |
| Compartmentalization result contested | The sign of the human L5 difference depends on recording site and subtype |
| Neuron density claim conflicts with whole-brain counts | Falling density with brain size "including primates" vs invariant primate density — `T301` |

---

## Connections

- **[[wiki/concepts/dendritic-computation.md]]** — adds a second branch nonlinearity to that page's monotone NMDA detector: a human L2/3 Ca²⁺ branch that responds only inside an input-strength window, so one cell computes XOR where that page's detectors-then-OR cell cannot.
- **[[wiki/concepts/neuron-complexity-index.md]]** — the instrument that has now scored this cell: human L2/3 models are the most complex cells in either species (FCI 0.43 vs rat L2/3 0.19), which the dendritic area and the NMDA steepness this page lists explain, while the band-pass branch, also listed here, was left out of the models (Aizenbud et al. 2026).
- **[[wiki/concepts/cellular-scaling-rules.md]]** — supplies the per-unit half that page's per-clade accounting lacks: synapse density held roughly constant while dendrites grow means synapses per neuron rise, which is growth of `s̄` inside a clade whose exponent says `s̄` is fixed.
- **[[wiki/concepts/emergent-modularity.md]]** — adds second-hand support to that page's "scale-up is neuropil" row (neuron density falling with brain size, synapses per neuron highest in humans) and one counter-row to its "no new modules" null: two L2/L3 transcriptomic types with no mouse homologue.
- **[[wiki/concepts/synaptic-plasticity.md]]** — sets the Tsodyks–Markram parameters per species and per sublayer: recovery from depression ~3× faster than mouse, and opposite short-term plasticity sign in L2 and L3 of one area.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — supplies the measured human coding level (0.2–1% concept-cell sparseness) and the review's untested claim that richer units buy sparser codes.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — gives human data for a circuit mostly described from one mouse strain: thicker L2/L3, cortico-cortical output shifted into it, one-way L2 → L3 routing, and extratelencephalic L5 output cells at 2–6% instead of 20–30%.
- **[[wiki/concepts/neuronal-parameter-heterogeneity.md]]** — supplies the biological spread that page learns: within-type diversity in human cortex exceeds the mouse's, and in human L5 across-neuron variation exceeds the human–rodent difference.
- **[[wiki/concepts/apical-amplification.md]]** — tests that page's rat-L5 rule in human cells and finds the sign disputed: human L5 distal dendrites are reported both less electrogenic (more compartmentalized) and strongly electrogenic in extratelencephalic cells, which decides whether the apical zone can reach the axon at all.
- **[[wiki/concepts/higher-order-interactions.md]]** — a single-cell case of that page's reducibility criterion: a branch that is non-monotonic in its summed input is nonlinear in the group, so it sees the exclusive-or that any reader linear in pairs misses.
