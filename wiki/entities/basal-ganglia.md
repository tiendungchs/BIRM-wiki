# Basal Ganglia (Striatal Direct / Indirect Pathways)

**A subcortical action-selection module in which one broadcast scalar — dopamine — produces *opposite* changes in excitability and in the sign of synaptic plasticity in two intermingled, anatomically dichotomous populations of striatal projection neuron, because the two populations express different receptors for the same molecule.**

> **Provenance.** Gerfen & Surmeier 2011, *Modulation of striatal projection systems by dopamine*, Annu Rev Neurosci 34:441–466 (`raw/gerfen-2011-striatal-dopamine-modulation.md`). A review, mostly rodent, built on bacterial-artificial-chromosome (BAC) transgenic mice in which enhanced green fluorescent protein or Cre-recombinase is driven by the D₁ or D₂ promoter — which is what let the two populations finally be recorded separately.

This is the biology [[wiki/entities/pbwm.md]] abstracts as `Go`/`NoGo` and a scalar `δ`. The page exists because the abstraction drops five things a builder needs: the *sign flexibility* of a pacemaker baseline, the *co-modulation* of gain and learning rate, the *asymmetry* of the two channels, the *directionality* of lateral inhibition, and a thalamically-triggered pause that has no counterpart in any wiki architecture.

---

## Architecture

| Stage | Cells | Projection |
|---|---|---|
| **Input** | Striatum: essentially all cortical areas (sensory, motor, associational) + intralaminar thalamus, both glutamatergic | Onto spiny projection neurons (SPNs, ~90% of striatal neurons) and four interneuron classes (~5–10%) |
| **Direct pathway** | D₁-expressing SPNs (~half) | GABAergic, straight to the output nuclei (internal globus pallidus GPi, substantia nigra pars reticulata SNr), plus a collateral to external globus pallidus (GPe) |
| **Indirect pathway** | D₂-expressing SPNs (~half) | GABAergic, to GPe *only*; GPe → subthalamic nucleus (STN, glutamatergic) and → output nuclei; STN → output nuclei in parallel |
| **Output interface** | GPi / SNr, tonically inhibitory | → thalamus, superior colliculus, pedunculopontine nucleus |
| **Teacher** | Substantia nigra pars compacta (SNc) dopamine neurons, autonomous pacemakers | Dense diffuse innervation of striatum; rewarding events raise firing transiently, aversive events lower it |

**Every downstream node (GPe, GPi, STN, SNr) is an autonomous pacemaker.** This is the load-bearing design fact and it is usually skipped. Two purely *inhibitory* striatal projections can nevertheless push the output in both directions, because the output is not at rest: direct-pathway firing pauses the tonic inhibition (movement occurs *during* the pause — Chevalier & Deniau 1985; saccades in the pause, Hikosaka & Wurtz 1983), indirect-pathway firing raises it via the double-inhibitory GPe route. **(brainstorm)** The machine lesson is that a nonnegative-weight module gets signed control for free if its readout has a nonzero tonic baseline — sign lives in the *set-point*, not in the weights. Every wiki architecture that needs opponency instead pays for it with signed weights or a subtraction (`[Go − NoGo]⁺` in PBWM).

### The two channels are not mirror images

| | Direct (D₁) | Indirect (D₂) |
|---|---|---|
| Total dendritic length | Longer, ~2 more primary dendrites | Shorter |
| Glutamatergic input (spine density equal) | ~50% *more* | Less |
| Intrinsic excitability (somatic current injection) | Lower | **Higher** |
| Dopamine ↑ | Excitability ↑ (Cav1 L-type ↑, somatic K⁺ ↓, SK via Cav2 ↓); up-state transition promoted | Excitability ↓ (Cav1 ↓, Nav1 ↓, K⁺ ↑, dendritic and NMDA Ca²⁺ entry ↓, presynaptic glutamate release ↓) |
| Dopamine ↑ at glutamatergic synapses | **LTP** (D₁-dependent) | **LTD** (endocannabinoid, D₂-dependent) |
| LTP requires | D₁ | **A2a adenosine receptor, not D₁** |
| Recurrent collaterals | Contact essentially only other direct-pathway SPNs | Contact **both** populations |
| Collateral GABA release under dopamine | Increased by D₁ | Decreased by D₂ |

So the opponent pair is **fewer inputs at higher gain versus more inputs at lower gain**, and the two arms of the opponency are driven by *different receptor systems*: the D₂ cell's potentiating arm is supplied by adenosine A2a, which shares D₁'s Gs → cyclic AMP → protein kinase A → DARPP-32 cascade. **(brainstorm)** A builder copying this does not need a second sign of the same modulator; it needs a second modulator that reaches the same cascade, which is a cheaper wiring problem and gives independent control of the two arms.

---

## The one result that matters for learning

A transient **rise** in dopamine, at a moment fixed by action outcome:

```
direct-pathway SPNs :  excitability ↑   and   corticostriatal Δw ← LTP
indirect-pathway SPNs: excitability ↓   and   corticostriatal Δw ← LTD
```

and a transient **fall** does the mirror. Two consequences the `Go/NoGo` abstraction hides:

1. **Gain and learning rate are co-modulated by one signal.** The same scalar that decides which pathway runs *now* also decides which pathway's cortical inputs are strengthened *for next time*, and in the same direction. Selection and credit assignment are not two mechanisms sharing a wire — they are one modulation read at two timescales. No learning rule in [[wiki/concepts/synaptic-plasticity.md]] couples its third factor to the activation function of the same units.
2. **The scalar carries the sign; the cortical ensemble carries the address.** Dopamine is diffuse and unaddressed, so *which* synapses move is decided entirely by which SPNs the current cortical ensemble happened to drive. This is the read of gap G19 (no local rule is selective about what it writes) that the biology actually implements: selectivity is *not* in the rule and *not* in the modulator — it is in the conjunction, and the price is that a coincidentally-active ensemble is potentiated exactly as readily as a causal one.

**But the selection story the mechanism supports is not a balance.** Mink's elaboration of the classical model has both pathways active during a movement — direct-pathway ensembles releasing the selected program, indirect-pathway ensembles suppressing the competitors — and primate limb-reaching recordings confirm activity *rising* in both (Turner & Anderson 1997). If that is right, the informative variable is which ensembles are co-active and with what relative timing, and a scalar difference over each channel discards exactly that ([[wiki/empirical-tensions.md]] T129). In Parkinson's models it is again timing, not level, that predicts movement choice (Bevan et al. 2002).

The review is explicit that the debate over *what* SNc firing encodes (reward prediction error vs. anything else) is not load-bearing for this mechanism — the mechanism needs only that the signal moves bidirectionally with outcome. That is a useful licence: [[wiki/empirical-tensions.md]] T122 (dopamine as prediction error vs. as inferred precision) can be settled either way without touching the opponent-plasticity architecture, since a precision signal read as a learning-rate gain would be consumed by exactly the same D₁/D₂ split with opposite signs.

---

## Input gating before selection

**The down-state / up-state threshold.** At rest, inwardly rectifying Kir2 K⁺ channels clamp an SPN near the K⁺ equilibrium potential (~−90 mV), far from spike threshold. Non-convergent cortical input is *shunted* by these constitutively open channels and produces nothing. Only spatially and temporally convergent input overwhelms and closes them; Kir2 closure plus Kv4 (A-type) inactivation then raises dendritic input impedance, shortens electrotonic length, and puts the soma near threshold for hundreds of milliseconds (the up-state), during which spikes are driven by a *separate*, uncorrelated input.

**(brainstorm)** This is a hard convergence gate applied to the cortical stream *before* any selection happens, and it is not a soft nonlinearity — sub-threshold input is actively erased rather than attenuated, and the erasure is *state-dependent* (the shunt removes itself once beaten). A machine equivalent is a gated linear layer whose gate is a function of the input's own spatial clustering, i.e. selection on evidence *convergence* rather than on evidence magnitude. It also means the striatum never sees the low-convergence tail of cortical activity, which is a free shortcut-filter of a kind [[wiki/concepts/shortcut-learning.md]] has no other example of: a spurious feature that drives few afferents cannot register at all.

**Feedforward inhibition (cortex → fast-spiking parvalbumin interneuron → SPN perisomatic).** Suppresses SPNs in circuits for unwanted actions; preferentially contacts direct-pathway SPNs. Dopamine controls it twice over — D₅ raises fast-spiking interneuron excitability, while D₂ depresses the GPe → interneuron GABAergic input (GPe cells also express D₂). Net: the feedforward brake is *held down by basal dopamine and released fast when dopamine falls*.

**The thalamic burst-pause window.** Thalamostriatal synapses have high release probability (suited to transient events) and drive the cholinergic interneuron, which answers a salient stimulus with a **burst then a ~1 s pause** (Ding et al. 2010). During the burst, presynaptic M2 receptors transiently suppress corticostriatal release onto *both* populations; the pause then removes that suppression while postsynaptic M1 signalling has left the *indirect*-pathway SPNs selectively more responsive (by closing Kir2 and raising dendritic input resistance — Shen et al. 2007). **(brainstorm) This is a salience-triggered "stop and reconsider" primitive with no counterpart anywhere in the wiki**: an unexpected event mutes the current cortical drive for tens of milliseconds and then opens a second-long window biased toward the *suppression* channel. Every gated architecture in the wiki ([[wiki/entities/pbwm.md]], [[wiki/entities/differentiable-neural-computer.md]]) gates on the *contents* of the input; this gates on the *arrival of an unmodelled event*, on a separate afferent, and biases the outcome toward not-acting. It is the missing action-side counterpart of [[wiki/concepts/event-segmentation.md]]'s boundary signal.

**Lateral inhibition is directed, and its direction is set by dopamine.** Because direct-pathway SPNs contact only each other while indirect-pathway SPNs contact both, and because D₁ *raises* collateral GABA release while D₂ *lowers* it: a dopamine transient sharpens competition *within* the direct pathway (winner-take-all sculpting among candidate actions, on cells whose excitability is simultaneously raised), while a dopamine dip does the same *within* the indirect pathway. The competition therefore runs in whichever channel is currently being selected for, and never across the two.

---

## The dendritic problem

Back-propagating action potentials from the axon initial segment decay steeply in SPN dendrites: they produce only a modest depolarization at 80–100 µm, less than half the way out along dendrites of 250–400 µm, and repetitive somatic spiking does not fix it (worse in direct-pathway SPNs; Day et al. 2008). Spine density peaks at 50–60 µm and stays high to the tips.

**So a large fraction of the corticostriatal synapses in the brain's action-selection module receive no somatic feedback at all about what the cell did.** Spike-timing-dependent plasticity, which is present in SPNs, can only be the rule for the proximal subset. The proposal for the rest is local regeneration — Cav3 (low-threshold) and Cav1 channels plus NMDA receptors are all expressed distally, so convergent input on a distal branch could fire a plateau potential that both licenses local plasticity and, by collapsing the cell's electrotonic structure, pulls the whole neuron into an up-state. That would make the up-state a *dendritically triggered* event rather than a somatic one, which is consistent with the observed lack of temporal correlation between up-state onset and spiking (Stern et al. 1998).

Two things follow if this is right. It would "significantly increase their pattern recognition capacity" in the Poirazi & Mel 2001 sense — the SPN becomes a two-layer network over independent branch detectors ([[wiki/concepts/dendritic-computation.md]]) — and dendritic D₁/D₂ receptors, which is where *most* dopamine receptors sit, would be modulating the branch detections rather than the somatic gain. The review's own concession: "virtually nothing is known about the integrative mechanisms of SPN dendrites."

---

## The Parkinson's-disease evidence, and the homeostatic catch

Dopamine-neuron loss shifts the two pathways in opposite directions — direct-pathway excitability and LTP down, indirect-pathway excitability and LTP up (Shen et al. 2008) — producing the classic hypokinetic imbalance, confirmed by selective optogenetic activation of each pathway in mouse models (Kravitz et al. 2010) and by antidromically identified SPNs in lesioned rats (Mallet et al. 2006). Intrinsic-excitability change and plasticity-bias change move *together*, as the healthy mechanism predicts.

**The catch is homeostatic and it is a warning for any architecture built on an opponent modulator.** Sustained imbalance triggers set-point-restoring adaptation that partly cancels it: in over-active indirect-pathway SPNs, L-type Ca²⁺ entry → calcineurin → dephosphorylated myocyte enhancer factor 2 (MEF2) → *Arc* and *Nur77* → dramatic loss of glutamatergic synapses on spines (Day et al. 2006; Tian et al. 2010); recurrent collateral strength collapses (Taverna et al. 2008); somatostatin/nitric-oxide interneuron activity rises; cholinergic signalling strengthens. Gene expression takes **weeks** to stabilise after the lesion. So the difference between the two channels is *attenuated* by the very homeostasis that keeps them stable (Flores-Barrera et al. 2010) — a persistent bias in the third factor gets partly erased by structural rescaling, and what is measured after the transient is a mixture of the primary effect and its own compensation. This is the mechanism version of [[wiki/concepts/continual-learning.md]]'s metaplasticity row, running against the learning signal rather than in service of it.

Also: in Parkinson's models it is the **timing** of activity in the two pathways, not the overall level, that best predicts movement choice and initiation (Bevan et al. 2002) — which the balance model does not represent at all. And chronic L-DOPA reshapes the D₁ cell's own signalling, coupling D₁ to ERK1/2 and mTOR and abolishing the regional and compartmental structure of its gene-expression response — a receptor whose downstream cascade is itself rewritten by the history of the signal it receives.

---

## Limitations

| Limit | Consequence |
|---|---|
| Almost entirely rodent, largely *in vitro*, with interneurons pharmacologically blocked in most SPN recordings | The clean dichotomy is measured in a preparation with the microcircuits removed; the review says so explicitly |
| The sign of striatal plasticity flips with brain state | 5 Hz motor-cortex stimulation gives LTP under barbiturate anaesthesia and **LTD** in awake rats (Stoetzner et al. 2010). Which sign the healthy mechanism above delivers is not a property of the synapse alone |
| Corticostriatal and thalamostriatal synapses are not reliably distinguished | Everything called "corticostriatal plasticity" is glutamatergic plasticity of unknown origin |
| Whether the two pathways receive the *same* cortical information is unresolved and hard to resolve | If they do not, the whole opponent reading changes — the two channels would be selecting over different action sets rather than voting on one |
| The microcircuits play no role in the action-selection model | Feedforward, feedback, cholinergic and interneuron circuits are characterised, and then omitted from the functional account |
| Sparse connectivity defeats the standard experiments | One cortical axon makes 1–2 *en passant* synapses on an SPN, so no electrode can reliably stimulate a set of synapses on one dendrite; the dendritic hypothesis above is untested for want of optogenetics or two-photon uncaging at the time of writing |

---

## Connections

- **[[wiki/entities/pbwm.md]]** — the model this page is the biology of, and the four things the model's `[Go − NoGo]⁺` drops: the tonic pacemaker baseline that supplies sign without signed weights, the co-modulation of gain and learning rate by one scalar, the structural asymmetry of the two channels (indirect = fewer inputs, higher gain), and the fact that a D₂ cell's potentiating arm comes from adenosine A2a rather than from dopamine at all — so the two arms of the opponency have independent handles.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the third factor with its sign supplied by the *receptor on the target* rather than by the signal: one unaddressed broadcast scalar yields LTP in one population and LTD in the other, so opponent credit assignment costs one wire and two cell types. It also shows the address problem in its bare form — dopamine says which way, the active cortical ensemble says where, and nothing says whether that ensemble was causal (gap G19).
- **[[wiki/concepts/dendritic-computation.md]]** — where the action-selection module runs into this page's problem: back-propagating spikes die by 80–100 µm of a 250–400 µm dendrite, so most corticostriatal synapses get no somatic feedback and their plasticity would have to be licensed by *local* NMDA/Cav plateaus — making the SPN a bank of branch detectors and putting the majority of its D₁/D₂ receptors on the detectors rather than on the somatic gain.
- **[[wiki/concepts/cognitive-control.md]]** — supplies the substrate for that page's automaticity claim ("repeated biasing strengthens the direct pathway until the behaviour is automatic") and prices it: strengthening the direct pathway means D₁-gated LTP at corticostriatal synapses under dopamine transients, so a controller can only hand a behaviour over on trials that *end well*, and the handover is undone by dopamine dips rather than by disuse.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — three distinct inhibitory control channels on one module, each with its own modulatory handle: cortex-driven feedforward inhibition through parvalbumin interneurons (gated by D₅ excitation and D₂ suppression of its GPe input), *directed* lateral inhibition through recurrent collaterals whose direction is set by which dopamine level is current, and the double-inhibitory GPe route by which an inhibitory projection produces excitation at the output.
- **[[wiki/concepts/policy-abstraction-hierarchy.md]]** — the internal wiring of one band of that page's cortico-striatal loops, plus the dorsomedial→dorsolateral shift the band story does not cover: the associative loop dominates early skill acquisition and the sensorimotor loop takes over once the action program is automated, which is a *second* axis of loop specialisation orthogonal to rostro-caudal policy order.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the input side of this circuit typed by cortical layer: superficial prefrontal layers reach the striatal matrix (ordinary bias on selection) while deep layers reach the patch compartment, which contacts SNc/VTA dopamine cells directly — so a controller can address either the selector on this page or the teaching signal that trains it (gap G50).
- **[[wiki/concepts/event-segmentation.md]]** — the action-side counterpart of a boundary signal, on separate hardware: a thalamic burst at a salient stimulus drives cholinergic interneurons into a burst-pause that first mutes cortical drive presynaptically and then leaves a ~1 s window biased toward the indirect (suppression) pathway — an interrupt triggered by event arrival rather than by input content.
- **[[wiki/concepts/precision-weighting.md]]** — the architecture is indifferent to which reading of dopamine wins (T122): a signal read as inferred precision would be consumed by the same D₁/D₂ split with the same opposite signs, so the opponent-plasticity mechanism survives either interpretation and cannot be used as evidence for either.
- **[[wiki/concepts/continual-learning.md]]** — homeostasis running *against* the learning signal: a sustained shift in the opponent modulator is partly cancelled over weeks by L-type Ca²⁺ → calcineurin → MEF2 → *Arc*/*Nur77* spine elimination in the over-active pathway, so any architecture that encodes a decision in a persistent neuromodulatory imbalance must expect the imbalance to be structurally re-normalised away.
- **[[wiki/concepts/shortcut-learning.md]]** — a filter that costs nothing and no wiki model has: Kir2 shunting erases cortical input that lacks spatial and temporal convergence rather than attenuating it, so a spurious feature driving few afferents never reaches the selector at all — selection on evidence *convergence* instead of evidence magnitude.
