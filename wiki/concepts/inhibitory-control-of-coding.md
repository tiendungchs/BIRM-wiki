# Inhibitory Control of Coding Features

**The properties of a representation — how stable it is, how selective, how much it generalizes across contexts, how much information it carries — are set by separable inhibitory channels acting on a shared excitatory population, not only by the excitatory weights that build the representation.**

Every other account in the wiki of where a place code comes from is excitatory: recurrent CA3 attractors ([[wiki/entities/rolls-treves-hippocampal-model.md]]), entorhinal grid input ([[wiki/concepts/abstract-structural-codes.md]]), or plasticity in either ([[wiki/concepts/synaptic-plasticity.md]]). Inhibition enters those accounts as one global scalar — a normalizer that enforces sparsity and nothing else. Valero et al. 2025 record members of all four genetically defined interneuron families simultaneously and show the scalar is really **four channels with different jobs**, each biasing a different *feature* of the pyramidal code, and each causally verifiable by activating that family alone.

This matters to this wiki for one reason: the features these channels control are exactly the knobs the wiki has repeatedly identified as unset — the separation/completion bias (gap G38), the factorise-vs-entangle decision (G40), and the allocate-vs-reuse trade-off ([[wiki/concepts/pattern-separation-completion.md]]). Biology does not leave them as hyperparameters; it wires a dedicated cell family to each and runs them at activity timescale.

---

## The division of labour

Four families cover >95% of GABAergic neurons in neocortex and hippocampus: *Pvalb* (parvalbumin), *Sst* (somatostatin), *Vip* (vasoactive intestinal peptide), *Id2* (inhibitor of DNA binding 2, containing both neurogliaform and *Sncg*-expressing cholecystokinin basket cells). Pyramidal cells are *CaMK2α*.

| Family | Place-code feature it covaries with | Effect of activating it alone (during behaviour) | Own spatial properties |
|---|---|---|---|
| **Pvalb** | **Stability** (first-half vs. second-half rate-map correlation) — the only family with a stability relationship, and it is weak | Suppresses the **first half** of the place field; suppresses `CaMK2α`-deep more than `CaMK2α`-sup and suppresses other *Pvalb* | Stability comparable to place cells; generalizes across maze arms |
| **Sst** | **Context generalization** (left-trial vs. right-trial rate-map correlation) — the strongest single relationship on the matrix | Strongest overall suppression of place-field rate; suppresses the **second half** of the field | Generalizes across arms; *lowest* selectivity of any family |
| **Vip** | **Space-rate mutual information**; secondarily selectivity | *Increases* place-field amplitude — the only family that does, via disinhibition (it suppresses *Sst*) | Highest space-rate MI and highest selectivity of the four |
| **Id2** (non-*Sncg*) | **Selectivity** (peak-to-mean rate ratio), jointly with *Pvalb* and *Sst* | Suppresses **all** families; suppresses the second half of the field | Stability comparable to place cells; *context-specific*, unlike *Pvalb*/*Sst* |
| **Id2-*Sncg*** (CCK-basket-like) | — | — | Suppressed or weakly entrained during sharp-wave ripples; theta-peak preference; low gamma entrainment; lower space-rate MI than *Id2*–non-*Sncg* |

**The correlational matrix and the causal matrix agree.** Feature covariation was computed from mutual-information coupling between each place cell and each predicted family; the perturbation matrix was computed from optogenetic activation of one family at a time (100 ms pulses at random 300–500 ms intervals, with running speed and alternation performance unchanged, so the circuit effect is not a behavioural confound). The two matrices correlate (`p = 0.007` over interneurons). This is the rare case where the wiki can take a feature→mechanism assignment as causal rather than as a correlation with a story attached.

### The wiring rule behind the assignment

The generalize/specialize split is not a property of the interneuron's transmitter or target compartment — it follows from **how broadly it samples the pyramidal population**:

| Family | Innervation by pyramidal cells | Consequence |
|---|---|---|
| *Pvalb*, *Sst* | Dense | Arm-specific pyramidal cells all drive them equally → the inhibitory signal *averages over* context → generalizes |
| *Id2* | Sparse | A few arm-specific pyramidal cells dominate → the inhibitory signal inherits their context specificity → splits |

**(brainstorm) One transferable design rule: a control channel's selectivity is set by its fan-in breadth, not by its output.** A gain/normalization module that pools over many units necessarily enforces generalization across whatever those units distinguish; a sparsely-pooled gate necessarily enforces splitting. A machine that wants both must instantiate *two* control paths with different pooling widths over the same population — which is precisely what a single global normalization layer, the standard machine analogue of inhibition, cannot do. This is a concrete, cheap architectural prescription and no model in the wiki has it.

---

## Time-division control within a single field

The three suppressive families do not act on the same part of a traversal:

| Phase of place-field traversal | Suppressed by | Interpretation offered |
|---|---|---|
| First half (entering the field) | *Pvalb* | Entorhinal input is the dominant excitation here; depression of the place-cell→*Pvalb* synapse is what hands control over |
| Second half (leaving the field) | *Sst*, *Id2* | Potentiation of the place-cell→OLM (*Sst*) synapse gradually cancels the entorhinal drive; CA3 recurrent input becomes the dominant source |

**Read as an architecture, this is an input router implemented in inhibition.** The same pyramidal cell is driven by a *different source* at different points along the same trajectory, and which source wins is set by which inhibitory channel is currently loaded — with the switch schedule itself written by short-term plasticity at the pyramidal→interneuron synapse, i.e. learned from the traversal rather than clocked externally.

**(brainstorm)** This is a mechanism for the thing [[wiki/concepts/latent-graph-discovery.md]] needs and no model implements: a *within-step* schedule that says "use the structural prediction to enter this state, use the stored transition memory to leave it." A machine mixture over an EC-like generative path and a CA3-like retrieval path, with mixture weights that are a learned function of position *within* the current node's occupancy, is directly buildable and is not the static weighted sum every hybrid model in the wiki uses.

**The global scalar does one thing the four-channel picture does not name: it is the medium of competition between whole representations.** In a network holding two maps in overlapping populations, inhibition is what makes them mutually exclusive — and because it scales with *total* activity, any periodic dip in activity is a periodic release of the loser. Mark et al. 2017 run exactly this: a 10 Hz theta modulation of the drive makes each cycle a fresh contest, and the map with the momentary gain advantage can take a cycle back ([[wiki/entities/stp-flickering-cann.md]]). So the abstraction this page argues discards too much also carries a function — **rhythm as competition scheduling** — that the differentiated-channel account has not yet been asked to explain, and it predicts that flicker rate should rise with the amplitude of the inhibitory oscillation (observed: partial `r = 0.44` with theta power).

---

## Interneurons carry the spatial code, not merely shape it

| Result | Number |
|---|---|
| Interneurons of all four families show stable, position-tuned rate modulation tiling the whole maze | 3710 units, 17 mice |
| Position decoding (CEBRA) from **interneurons only** vs. pyramidal cells down-sampled to the same count | Statistically indistinguishable (`p = 0.63`) |
| Leaving one family out of the interneuron decoder | Error rises; largest for *Vip*, *Id2*, *Pvalb* (`p < 0.03`) |

A dense, fast-firing, non-sparse population decodes position as well as the sparse selective one. That does not overturn the capacity argument for sparse storage — the two populations are not doing the same job, and 57 units is a small test — but it does break the inference chain "position is decodable here ⇒ this population is the spatial code." See [[wiki/empirical-tensions.md]] T52.

---

## Physiological fingerprinting: cell classes from intrinsic dynamics

The method is separable from the biology and is the transferable half for machine interpretability.

| Step | Detail |
|---|---|
| **Label a subset** | Optogenetically tag a small number of units of known family (`n = 785` across hippocampus + neocortex; 39–70 per interneuron family) |
| **Fit a weak classifier on intrinsic statistics only** | Decision tree on 6 features: firing irregularity `CV2`, autocorrelogram rise time, spike width, anatomical location, waveform asymmetry, firing rate. `CV2_i = 2·\|ISI_{i+1} − ISI_i\| / (ISI_{i+1} + ISI_i)`; the neuron's score is the mean over spikes |
| **Accuracy** | >89.7% for five families across regions; a CA1-specific five-feature version (`CV2`, ACG rise time, spike width, theta modulation, waveform asymmetry) reaches 97.8% over all neurons and 91.6% over interneurons only |
| **Apply to unlabelled populations** | 5276 CA1 units, 155 sessions, 30 mice, at a ≥95% per-family confidence cutoff |
| **Validate on properties never used for training** | (i) predicted family *fractions* correlate with gene-expression fractions from the Allen Brain Map; (ii) spike-phase preferences for theta, three gamma bands and sharp-wave ripples correlate between tagged and predicted families; (iii) spatial coding features correlate between tagged and predicted |
| **Recurse for subfamilies** | An SVM splits *Id2* into putative *Sncg* and non-*Sncg* at 100%, matching known CCK-basket physiology |

**The validation discipline is the exportable part.** The taxonomy is fitted on features collected during *spontaneous home-cage activity* — paradigm-independent — and then checked against properties (oscillation phase, spatial tuning) that were withheld from the fit. That is the escape route [[wiki/concepts/representation-probing.md]] says the probing literature lacks: the classifier cannot have manufactured the held-out correlations, so "these units form a real class" is licensed in a way that "a probe decoded my labels" is not.

**(brainstorm) The machine version.** Cluster or classify units of a trained network by their *intrinsic activity statistics* — firing-rate distribution across inputs, autocorrelation timescale of the unit's activation across a sequence, irregularity, response-onset latency under perturbation — rather than by their tuning. Then test whether the resulting classes predict a property that was never in the feature set: oscillation-phase analogue (position within the layer's update cycle), causal effect on downstream units when ablated, or which loss term the unit's gradient loads on. The wiki has no unit taxonomy for any model it holds, and gap G44's question (how much of an emergent phenomenon came from the training target) is partly a question about which unit classes exist and what each one does.

---

## Circuit motifs recovered three ways, and conserved across regions

| Method | What it gives |
|---|---|
| Optogenetic activation of one family, response of all others | Signed, directed, causal adjacency |
| Mutual information between spike trains (10 ms bins, shuffle-tested) | Functional adjacency — correlates with the causal one, `p < 10⁻⁸` |
| Generalized linear model fit to spike trains | Same matrix again |

Recovered graph: `Vip ⊣ Sst`, `Sst ⊣ {all except Id2-non-Sncg}`, `Id2 ⊣ all`, `Pvalb ⊣ {CaMK2α, Pvalb}`, `CaMK2α → all`. Net effect of *Vip* on pyramidal cells is **disinhibition**. The same functional coupling matrix is obtained in neocortex, so the motif is a **cortex-wide primitive**, not a hippocampal specialization — which is what licenses importing it into a general architecture rather than into a navigation module.

---

## One channel with a job *and* a controller: NDNF⁺ neurogliaform cells

The taxonomy above assigns *Id2* the **selectivity** feature and leaves "what drives the channels?" open. de Sousa et al. 2026 take the neurogliaform (NGF) subset of that family — NDNF⁺ cells in the stratum lacunosum moleculare (SLM) of dorsal CA1 — and close both halves for one control problem: how much two episodes' ensembles are allowed to overlap.

| Question | Answer in this circuit |
|---|---|
| **What feature does the channel set?** | Ensemble overlap between two episodes encoded 7 d apart. Chemogenetic inhibition of SLM NDNF⁺ cells alone raises dCA1 overlap and raises pyramidal Ca²⁺ event rate |
| **Is it naturally modulated?** | Yes, by the variable it should track: fewer NDNF⁺/c-Fos⁺ cells when the two contexts are the *same* (integration is appropriate) than when different (separation is required) |
| **What drives it?** | A cortical input three synapses up: vmPFC (deep, excitatory) → MEC layers II/III/V → SLM. Inhibiting vmPFC→MEC lowers MEC c-Fos, lowers GAD67⁺/c-Fos⁺ and NDNF⁺/c-Fos⁺ counts in SLM, and reproduces the overlap effect; optogenetic MEC stimulation *raises* SLM c-Fos |
| **Is the effect channel-specific?** | Yes. SOM⁺, PV⁺ and VIP⁺ c-Fos across dCA1 are all unchanged; the GAD67 effect is confined to SLM (not stratum oriens, not radiatum) |
| **Why this layer** | SLM is where the temporoammonic (EC→CA1) path arrives; NGF cells there gate entorhinal against CA3 drive onto the same pyramids, which is the encoding/retrieval balance rather than a gain change |

**This is the wiki's first end-to-end control loop for a coding feature**: a named cortical controller, a named pathway, a named interneuron subtype, a measured actuation, and a behavioural read-out — where the four-family matrix above supplies actuators with no controller and the neuromodulatory candidates supply a controller with no per-feature resolution (gap G38).

**(brainstorm) The transferable shape.** The controller is *not* in the circuit it controls, its input is a comparison between the current episode and consolidated cortical content, and its output is a single inhibitory channel that changes the write geometry without changing the content written. In machine terms: a slow module reads similarity between the current input and its own stored structure, and emits one scalar that multiplies an inhibitory gate on the fast store's allocator. That is a *cross-module* control path, and every gating mechanism the wiki holds is intra-module. It also predicts the fan-in rule above should hold for the NGF channel — sparse innervation → context-specific splitting — which is consistent with *Id2* being the context-specific family and is untested here.

**Caveat carried from the source:** all interneuron read-outs are c-Fos/RNAscope counts (activity proxies at 90 min resolution), not recordings, so "the NGF channel carries the signal" rests on a causal inhibition plus a correlated marker, not on spike data.

---

## A fifth channel that is a rhythm, not a cell type

The four families above are actuators defined by *who they inhibit*. Prefrontal cortex supplies one defined by *when it fires*, at a coarser grain and with a job the cell-type taxonomy does not cover: **beta bursts (~20–35 Hz) decide when and where information is allowed to be expressed** (Lundqvist et al. 2018, macaque prefrontal cortex, sequence delayed-match).

| Property | Measurement |
|---|---|
| What it suppresses | Gamma bursts and the informative spiking that rides them — spiking is reduced inside beta bursts (`p` = 0.004) and elevated inside gamma bursts (`p` < 0.0001) |
| Where it acts | Anti-correlated with gamma over time **only** at sites whose spiking carries object information (`r` = −0.40 vs. `r` = 0.08 at non-informative sites) |
| When it rises | When content stops being needed: post-trial at informative sites (the largest time × frequency effect in the dataset), and before an already-irrelevant test object |
| When it falls | Several hundred milliseconds before the held item must be compared against a test object |
| Likely generator | Mediodorsal thalamus–prefrontal loop, with the contents in superficial layers — a controller anatomically outside the population it gates. **Now measured at cell-type resolution**: a persistent mediodorsal population supplies inhibitory functional input to prefrontal cue-selective cells, couples more strongly to the fast-spiking cells than the transient population does (`p = 0.78 × 10⁻²`), and its suppression raises out-of-context spiking while lowering fast-spiking firing ([[wiki/entities/mediodorsal-thalamus.md]], Rikhye et al. 2018) |

**The transferable claim: a spatiotemporal filter.** The same signal addresses *which* sites (only those holding something) and *when* (release before a read, raise after use). The four-family matrix gives per-feature actuators with no controller; this gives a controller with no per-feature resolution — the two are the same design read at different grains, and the honest summary is that inhibition here is not a gain on a representation but the **schedule** of its expression ([[wiki/concepts/working-memory.md]]).

**(brainstorm)** Read against the fan-in rule above, an oscillation is the limiting case of *broad* pooling — a population-wide channel — yet it achieves site specificity anyway, by being anti-correlated with the excitatory drive rather than by wiring. So a machine does not need a sparsely-innervated gate to get selective suppression; it can get it from a global inhibitory signal whose phase relationship to local activity differs by site. No model in the wiki has an inhibitory channel with a *phase*, only ones with a gain.

---

## Why this is a candidate answer to gap G38

G38 says nothing in the wiki sets the separation/completion bias, and that it cannot be a constant. The candidates the wiki had were a global neuromodulator (acetylcholine switching storage vs. recall) and a closed-loop CA3→DG backprojection. This adds a third architecture, and it is the one with the most resolution:

| Property | Neuromodulatory switch | CA3→DG backprojection | Interneuron families |
|---|---|---|---|
| Granularity | One scalar for the whole structure | One scalar, closed-loop | **Four channels, one per code feature** |
| Timescale | Seconds (diffusion) | Fast | Milliseconds, spike-locked, and *within* a single field traversal |
| Reversible without weight change | Yes | Yes | Yes |
| Verified causally per feature | No | No | **Yes** |
| What sets *its* setting | Unaddressed | Completion error | **Unaddressed** — the regress is not closed, only pushed back one level |

The last row is the honest limit. This supplies the *actuator* for G38 with four separately addressable outputs; it does not supply the controller that drives them. What the paper does add on that front is that the actuator's own routing is not hand-set — it falls out of innervation density and of short-term plasticity at the pyramidal→interneuron synapse, so the schedule is learned from the same experience that builds the excitatory code.

---

## Open problems

- **What drives the channels?** The families' effects are characterized; what sets their gain trial-by-trial is not — **except for one channel**: the NGF/NDNF⁺ subset of *Id2* in SLM is driven by vmPFC→MEC input, whose own gain tracks contextual similarity and elapsed time (de Sousa et al. 2026). The other three families still have no identified controller, and what function vmPFC computes to set *its* gain is unmeasured, so the regress moves one more level rather than closing.
- **The coupling estimates ignore third-party interactions and oscillation-phase-specific effects** — stated by the authors. A directed edge in the recovered graph may be mediated by an unrecorded family or hold only at one theta phase.
- **Subfamilies are unresolved.** Each of the four families contains many transcriptomic types; only the *Id2*/*Sncg* split has a physiological fingerprint so far. Whether the feature→channel assignment survives at subfamily resolution is untested.
- **Non-spatial generality is asserted, not shown.** The fingerprinting method is paradigm-independent, but every feature→channel assignment here was measured on a spatial alternation task. Whether *Sst* controls generalization for non-spatial contexts is the obvious next experiment and it has not been run.
- **The decoding parity test is small** (57 interneurons, five sessions, two mice) and cannot say whether the interneuron code is redundant with the pyramidal code or complementary to it.
- **Nothing in the wiki's models has more than one inhibitory channel.** [[wiki/entities/spiking-tem.md]] has a single global theta-locked inhibition term and gets grid-cell emergence out of it; four differentiated channels is an untested and cheap extension.

---

## Connections

- **[[wiki/concepts/priority-map.md]]** — the enhancement half of the same selection step, with no addressed suppression at all: unselected locations lose by failing the argmax rather than by being targeted, so the two pages bracket whether "stop processing this" needs its own channel.
- **[[wiki/entities/hag-reservoir.md]]** — the case where inhibition turns out to be *substitutable*: growing recurrent edges between long-window-correlated units drives pairwise and distance correlation in an excitatory-only reservoir down to the level a signed excitatory–inhibitory network reaches, so decorrelation — one of the coding features this page assigns to an inhibitory channel — is also obtainable from graph structure alone (Cazalets et al. 2025).
- **[[wiki/entities/cscg.md]]** — the strongest functional case for feedback inhibition in the wiki: a spiking recurrent network whose only competitive element is soft winner-take-all, trained by a local timing-based Hebbian rule with no task and no error signal, reaches the same orthogonalized state representation mouse CA1 reaches — so the inhibitory mechanism, not the learning rule, is what carries the de-aliasing (Sun et al. 2025).
- **[[wiki/concepts/pattern-separation-completion.md]]** — supplies the actuator that page's "the knob has a controller" section was missing: four inhibitory channels, each causally tied to a different feature of the code (generalization, selectivity, stability, information), running at spike timescale instead of the neuromodulatory second-scale switch (G38).
- **[[wiki/concepts/cognitive-map.md]]** — argues the map's *features* are not all built by the excitatory machinery that page describes: stability, context generalization and selectivity of place fields each track a different interneuron family, and interneuron populations decode position as well as size-matched pyramidal populations.
- **[[wiki/concepts/representation-probing.md]]** — contributes an instrument and a validation discipline: classify units by intrinsic activity statistics fitted on a small opto-labelled subset, then verify the taxonomy against properties withheld from the fit (oscillation phase, spatial tuning, gene-expression fractions) — the escape from probe circularity that page says the literature lacks.
- **[[wiki/entities/spiking-tem.md]]** — that model already makes oscillatory inhibition load-bearing (grid emergence 59.6% → 25.6% without it) with *one* global theta term; this page says biology runs four differentiated channels with separable targets, making the differentiated version the natural next ablation.
- **[[wiki/concepts/offline-replay.md]]** — the families are differentially engaged by sharp-wave ripples (all increase on average, but 25% of *Id2* and the *Id2-Sncg* subfamily are suppressed, each family with its own ripple phase preference), which is the cell-type resolution that page's "inhibitory activity determines replay firing order" claim needs to become a mechanism.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — that model uses interneuron inhibition as a single competitive-learning normalizer that enforces sparseness; this page says the same anatomy carries four channels with distinct, causally verified targets, so the normalizer abstraction discards the part that controls generalization.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the sharpest computational role inhibition plays in the wiki: a *stochastic winner-take-all* circuit behind an STDP layer turns the output spike into a sample from a normalized posterior, which is what makes the local rule an online expectation-maximization step on a latent-cause mixture rather than a coactivity detector (Nessler et al. 2009, 2013) — so the objective belongs to the inhibitory circuit, not to the synapse. It also supplies a hard limit on how the four channels could be *built*: excitatory synapses onto GABAergic cells show no spike-timing plasticity in either direction in hippocampal culture (0.3 ± 3.4% and −1.7 ± 2.0%, both `p` < 0.001 against glutamatergic targets; Bi & Poo 1998), so if that holds in vivo the interneurons' input weights are set by wiring rather than written by correlated activity — and the channel assignments this page measures would be developmental, matching the innervation-density account of the generalize/specialize split. Beyond that, the rival account of flexibility: remapping by rewriting excitatory weights versus remapping by re-mixing inhibitory gains, the second being fast, reversible and weight-free — with plasticity re-entering at the pyramidal→interneuron synapse, where it writes the within-field switching schedule rather than the field itself.
- **[[wiki/concepts/compositionality.md]]** — supplies a mechanism for G40's factorise-vs-entangle decision that costs no new representation: two inhibitory channels with different fan-in widths over the same population, the broad one enforcing generalization across contexts and the narrow one enforcing splitting.
- **[[wiki/concepts/contextual-inference.md]]** — the normative account says allocation is a responsibility posterior; this page says the split between generalizing and context-specific inhibitory signals is set by innervation density, so the posterior's effective pooling parameter has a wiring correlate rather than a neuromodulatory one.
- **[[wiki/concepts/population-geometry.md]]** — the same population measured at a different level: geometry asks what format the excitatory code is in, this page asks which control channel set the format, and the two answers are testable against each other because the format features (generalization, selectivity) are exactly the ones with named actuators.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — a candidate import of the gating/scheduling type: not a representation, but a differentiated control layer with per-feature outputs and a wiring rule (fan-in width) for assigning outputs to features.
- **[[wiki/entities/stp-flickering-cann.md]]** — the single-scalar abstraction put to work: global inhibition as the medium of competition between two whole maps, with the theta trough acting as a periodic reset of that competition rather than as a sparsity constraint.
- **[[wiki/entities/dense-sequence-memory.md]]** — inhibition as a per-*edge* switch: in the bipartite form of an asymmetric associative memory each hidden unit carries one stored transition, so silencing it deletes that transition from the dynamics — the cortico-basal-ganglia-thalamo-cortical reading of a sequence memory, and a job for inhibition that is neither sparsification nor gain control.
- **[[wiki/entities/adaptive-cann.md]]** — global inhibition abstracted to a single divisive-normalisation scalar `k`, and that scalar carrying a phase boundary: the bump exists only for `k < k_c2 = ρJ₀²/(8√(2π)a(1+m)²)`, so the abstraction this page argues against is here the difference between a network that represents something and one that represents nothing.
- **[[wiki/entities/context-modular-memory-network.md]]** — a computational job for inhibition at a scale above per-edge gating: a per-context inhibitory mask on neurons and synapses deletes whole sets of stored attractors from the energy function, buying a capacity multiple and driving hidden memories' stability to zero — and the paper's own concession, that per-synapse control is implausible while dendritic-branch control is not, sets the resolution at which this page's dendrite-targeting families would have to implement it.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — states what the inhibitory channels are *for* in error terms: the closed-form robustness of a subsampling detector holds only while the presynaptic active fraction sits in the 0.5–3% band, so the gain/normalization channels are not tuning a hyperparameter but holding the code inside the regime where recognition works at all.
- **[[wiki/concepts/dendritic-computation.md]]** — the excitatory unit the channels act on, one level finer: if the computational unit is a dendritic segment with its own threshold rather than a cell, a channel's fan-in breadth decides which *segments* it can veto, and dendrite-targeting versus soma-targeting interneurons become functionally distinct controllers rather than two ways of subtracting drive.
- **[[wiki/entities/hodgkin-huxley-model.md]]** — the biophysical origin of the distinction this page treats functionally: because ionic current is `g(V − E)`, a synapse whose reversal potential sits at rest contributes conductance without current and *divides* rather than subtracts, so shunting versus hyperpolarizing inhibition is a receptor fact and the divisive-normalization scalar used elsewhere in the wiki is its coarse-grained form.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the same interneuron population cut by axon geometry instead of transcriptomic family: perisomatic (basket, chandelier) cells implement selection over the local population while dendrite-targeting (double bouquet, Martinotti) cells set which inputs a cell can integrate — and because interneuron types are distributed unevenly across layers, which channels reach a pyramidal cell is fixed by its laminar position, a wiring answer to this page's open question about what sets the gains (Douglas & Martin 2004).
- **[[wiki/concepts/memory-allocation-excitability.md]]** — the control problem that gave one of these channels a controller: whether a new episode is written into the cells that hold an old one is set by SLM NDNF⁺ neurogliaform cells, driven by a vmPFC→MEC projection, and inhibiting that single cell type reproduces the whole effect — so an allocation prior the wiki had treated as intrinsic to the pyramidal cell is actuated by inhibition and commanded from cortex (de Sousa et al. 2026).
- **[[wiki/concepts/engram.md]]** — the write-budget job for the same machinery: engram size is held at a region-specific set-point (10–20% in lateral amygdala, 2–6% in dentate gyrus) by principal cells recruiting interneurons that suppress their neighbours, and blocking those interneurons *enlarges* the trace — so `k` in a k-winner-take-all is an inhibitory gain, not a firing threshold **(tentative)**.
- **[[wiki/concepts/working-memory.md]]** — where this page's control channels acquire a schedule: prefrontal beta bursts suppress gamma and informative spiking at exactly the sites that carry an item, fall before that item is read and rise once it is no longer needed, making inhibition the timer of expression rather than a gain on the code (Lundqvist et al. 2018).
- **[[wiki/entities/stsp-working-memory-rnn.md]]** — inhibition as the trainability condition: a recurrent net with plastic synapses trains stably only when the plastic term is anti-Hebbian at excitatory and Hebbian at inhibitory synapses, so the sign of plasticity is assigned by cell class and the inhibitory population is what makes the network contracting (Kozachkov et al. 2022).
- **[[wiki/concepts/cognitive-control.md]]** — the competing account of where suppression comes from: under biased competition the controlled systems already inhibit each other laterally, so an excitatory bias on the relevant units suppresses the rest for free and no inhibitory signal needs an address — where this page's beta bursts are aimed at specific informative sites. The disagreement is whether "stop processing this" requires its own channel or falls out of normalisation (Miller et al. 2002).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — a worked biological instance of addressed suppression: infralimbic cells fire to an extinguished tone only on recall day and dampen basolateral amygdala output, with the size of the response predicting how little the animal freezes — suppression carried by a dedicated projection rather than falling out of local competition. The *incoming* long-range channel is built the same way: hippocampal terminals excite prelimbic interneurons as well as pyramidal cells, so inactivating the source lowers interneuron firing and *raises* pyramidal firing, making a long-range excitatory pathway function as a net inhibitory gate on the controller (Spedding & Jay 2012, [[wiki/empirical-tensions.md]] T98).
- **[[wiki/concepts/control-unity-and-diversity.md]]** — the psychometric shadow this page's channels should cast and apparently do not: response inhibition has no ability-specific factor once the common control factor is removed, which is what a design with no dedicated, individually varying suppression parameter predicts — so an addressed inhibitory channel must be near-constant across individuals or it would show up (Friedman & Robbins 2021).
- **[[wiki/concepts/dynamic-network-connectivity.md]]** — a non-GABAergic channel doing this page's selectivity job: dopamine D1 stimulation shunts inputs from dissimilarly tuned prefrontal neurons, sharpening the preferred/nonpreferred contrast exactly as lateral inhibition does, but with a strength arousal can retune within a trial and an inverted-U past which all tuning collapses (Arnsten et al. 2010).
- **[[wiki/entities/pfc-columnar-planning-model.md]]** — a prediction that inhibition *carries* planning signal rather than only gating it: blind clustering places recorded prefrontal interneurons in the same cluster as the model's goal-propagating units (Martinet et al. 2011).
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — addressed suppression at the scale of a whole projection: the channel's glutamatergic terminals drive feed-forward inhibition, so inactivating the source *disinhibits* the target — a context input whose normal action is to withhold output the context does not license.
- **[[wiki/concepts/attention.md]]** — the deselection half of internal attention, with a named channel: prefrontal beta bursts suppress gamma and informative spiking at the site holding a no-longer-needed item, so 'stop attending to this' is an addressed inhibitory signal rather than the absence of a query.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a within-step schedule the framing assumes away: which excitatory source drives the code is handed over mid-traversal of a single node, so estimating the graph and reading the stored transition are time-multiplexed inside one step rather than being separate stages.
- **[[wiki/entities/basal-ganglia.md]]** — three inhibitory control channels on one module, each with a separate neuromodulatory handle: cortex-driven feedforward inhibition via parvalbumin interneurons (excited by D₅, disinhibited when D₂ releases its external-pallidal input), recurrent-collateral lateral inhibition that is *directed* — direct-pathway cells contact only each other while indirect-pathway cells contact both — with dopamine deciding which channel's competition is sharpened, and a double-inhibitory route in which an inhibitory projection produces net excitation at the output because the output is a tonic pacemaker.
- **[[wiki/entities/hami.md]]** — evidence that G38's controller may need more than one output: separation thresholds for the *event* and *context* factors of a conjunctive code have measurably different usable ranges (0.45–0.95 vs. 0.20–0.99), so a single broadcast scalar cannot set both, and the multi-channel actuator described here is the kind of thing that could (Poursiami et al. 2025).
- **[[wiki/concepts/spike-encoding-schemes.md]]** — a sparse code obtained without this page's actuator: a Gaussian-receptive-field time-to-first-spike encoder drops sub-threshold responses at the input, so the active fraction is set by a response cut-off rather than by any regulation of firing (Auge et al. 2021).
- **[[wiki/concepts/spike-frequency-adaptation.md]]** — delayed lateral and feedback inhibition is one of the three mechanisms producing adaptation, and the unsupervised-STDP models (Diehl & Cook, Querlioz et al.) run the adaptive threshold together with lateral inhibition purely as a division-of-labour regulariser — the same variable used to enforce coding sparsity rather than to store anything.
- **[[wiki/concepts/cross-paradigm-interface.md]]** — the engineering version of this page's channels, coarser by an order: one scalar threshold per neuron, emitted by a separate network trained on inter-task similarity, already buys reuse-within-group and non-interference-across-group on a 40-task sequence — so it sets the floor a four-family division of labour has to beat, and shows the *addressing* problem (which neurons to bias) can be answered by a learned map from context.
- **[[wiki/entities/spiking-hippocampal-cam.md]]** — inhibition as an arbiter rather than as a sparsifier: two interneuron populations, a delayed all-to-all inhibitory projection and a recurrent inhibitory collateral exist solely to keep a store's two read directions from corrupting each other's weights — the only case here where the inhibitory circuit's job is protocol enforcement rather than gain or selectivity control.
- **[[wiki/concepts/effective-connectivity.md]]** — the measurement problem this page's quantity creates at whole-brain scale: excitation/inhibition balance, including within-region recurrent inhibition, is unreadable from any correlational connectome and only becomes estimable once edges are signed parameters of a fitted two-population model — which is how a depression result localised to decreased recurrent inhibition in the amygdala and a sign flip on a parietal→prefrontal edge (Li et al. 2021).
- **[[wiki/entities/mediodorsal-thalamus.md]]** — the measured controller behind the beta channel this page could only name: a thalamic population whose functional input to prefrontal cortex is inhibitory, whose coupling is strongest onto the fast-spiking cells rather than onto pyramidal cells, and whose suppression is addressed at exactly the content the current context does not license — a controller anatomically outside the population it gates, with its gate variable pooled from that same population (Rikhye et al. 2018).
- **[[wiki/entities/early-visual-system.md]]** — the circuit divisive normalization was abstracted *from*, and the detail the abstraction dropped: the V1 normalizing pool is the set of neurons whose receptive fields cover the same visual-field location, and the LGN contrast-gain pool is a set of small nonlinear subunits coextensive with the classical receptive field — a local, content-defined pool, which is precisely the geometry this page argues one global normalization layer cannot express (Carandini et al. 2005).
- **[[wiki/concepts/manifold-untangling.md]]** — normalization's largest claimed payoff and the one that needs no learning: normalized-LN stacks with **random, unlearned** filters already produce more linearly decodable object manifolds, so a measurable share of invariance is architectural rather than trained (Pinto et al. 2008b; Jarrett et al. 2009).
- **[[wiki/entities/ventral-visual-stream.md]]** — the cascade where that flattening is claimed to accumulate stage by stage, and the source of the AND-like/OR-like alternation whose two operations are both variants of one normalized-LN form.
