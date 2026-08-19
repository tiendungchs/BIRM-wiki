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
| **Fit a weak classifier on intrinsic statistics only** | Decision tree on 6 features: firing irregularity `CV2`, autocorrelogram rise time, spike width, anatomical location, waveform asymmetry, firing rate. `CV2_i = 2·|ISI_{i+1} − ISI_i| / (ISI_{i+1} + ISI_i)`; the neuron's score is the mean over spikes |
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

- **What drives the channels?** The families' effects are characterized; what sets their gain trial-by-trial is not. G38's regress moves, it does not close.
- **The coupling estimates ignore third-party interactions and oscillation-phase-specific effects** — stated by the authors. A directed edge in the recovered graph may be mediated by an unrecorded family or hold only at one theta phase.
- **Subfamilies are unresolved.** Each of the four families contains many transcriptomic types; only the *Id2*/*Sncg* split has a physiological fingerprint so far. Whether the feature→channel assignment survives at subfamily resolution is untested.
- **Non-spatial generality is asserted, not shown.** The fingerprinting method is paradigm-independent, but every feature→channel assignment here was measured on a spatial alternation task. Whether *Sst* controls generalization for non-spatial contexts is the obvious next experiment and it has not been run.
- **The decoding parity test is small** (57 interneurons, five sessions, two mice) and cannot say whether the interneuron code is redundant with the pyramidal code or complementary to it.
- **Nothing in the wiki's models has more than one inhibitory channel.** [[wiki/entities/spiking-tem.md]] has a single global theta-locked inhibition term and gets grid-cell emergence out of it; four differentiated channels is an untested and cheap extension.

---

## Connections

- **[[wiki/concepts/pattern-separation-completion.md]]** — supplies the actuator that page's "the knob has a controller" section was missing: four inhibitory channels, each causally tied to a different feature of the code (generalization, selectivity, stability, information), running at spike timescale instead of the neuromodulatory second-scale switch (G38).
- **[[wiki/concepts/cognitive-map.md]]** — argues the map's *features* are not all built by the excitatory machinery that page describes: stability, context generalization and selectivity of place fields each track a different interneuron family, and interneuron populations decode position as well as size-matched pyramidal populations.
- **[[wiki/concepts/representation-probing.md]]** — contributes an instrument and a validation discipline: classify units by intrinsic activity statistics fitted on a small opto-labelled subset, then verify the taxonomy against properties withheld from the fit (oscillation phase, spatial tuning, gene-expression fractions) — the escape from probe circularity that page says the literature lacks.
- **[[wiki/entities/spiking-tem.md]]** — that model already makes oscillatory inhibition load-bearing (grid emergence 59.6% → 25.6% without it) with *one* global theta term; this page says biology runs four differentiated channels with separable targets, making the differentiated version the natural next ablation.
- **[[wiki/concepts/offline-replay.md]]** — the families are differentially engaged by sharp-wave ripples (all increase on average, but 25% of *Id2* and the *Id2-Sncg* subfamily are suppressed, each family with its own ripple phase preference), which is the cell-type resolution that page's "inhibitory activity determines replay firing order" claim needs to become a mechanism.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — that model uses interneuron inhibition as a single competitive-learning normalizer that enforces sparseness; this page says the same anatomy carries four channels with distinct, causally verified targets, so the normalizer abstraction discards the part that controls generalization.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the rival account of flexibility: remapping by rewriting excitatory weights versus remapping by re-mixing inhibitory gains, the second being fast, reversible and weight-free — with plasticity re-entering at the pyramidal→interneuron synapse, where it writes the within-field switching schedule rather than the field itself.
- **[[wiki/concepts/compositionality.md]]** — supplies a mechanism for G40's factorise-vs-entangle decision that costs no new representation: two inhibitory channels with different fan-in widths over the same population, the broad one enforcing generalization across contexts and the narrow one enforcing splitting.
- **[[wiki/concepts/contextual-inference.md]]** — the normative account says allocation is a responsibility posterior; this page says the split between generalizing and context-specific inhibitory signals is set by innervation density, so the posterior's effective pooling parameter has a wiring correlate rather than a neuromodulatory one.
- **[[wiki/concepts/population-geometry.md]]** — the same population measured at a different level: geometry asks what format the excitatory code is in, this page asks which control channel set the format, and the two answers are testable against each other because the format features (generalization, selectivity) are exactly the ones with named actuators.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — a candidate import of the gating/scheduling type: not a representation, but a differentiated control layer with per-feature outputs and a wiring rule (fan-in width) for assigning outputs to features.
