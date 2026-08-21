# Spike Encoding Schemes

**The map from a continuous signal to a spike train — the interface every spiking architecture in the wiki assumes and none specifies. The survey's finding is that it is not one choice but a taxonomy of at least fourteen, that the choice is not decidable from task accuracy, and that two of the most-used families require a time reference the system has no way to obtain.**

> **Provenance.** `raw/auge-2021-snn-encoding-techniques.md` — Auge, Hille, Mueller & Knoll, *A Survey of Encoding Techniques for Signal Processing in Spiking Neural Networks*, Neural Processing Letters 53:4693–4710, 2021. A survey with a proposed nomenclature; it reports no experiments of its own, so every number below is quoted from the works it cites.

The wiki's other spiking pages take the spike train as given: [[wiki/concepts/temporal-coding.md]] assumes a phase-locked input volley, [[wiki/entities/spiking-neural-networks.md]] assumes an input layer already emitting events, [[wiki/entities/spiking-tem.md]] assumes sensory and location observations already in spikes. This page holds the step before all of them.

---

## The taxonomy

The survey's organising claim: **every scheme reduces to one binary question — is the exact time and order of a spike load-bearing?** Population codes are *not* a third category; a population can carry either kind.

| Family | Scheme | Definition | What the decoder must know |
|---|---|---|---|
| **Rate** | **Count rate** (average over time) | `v = N_spike / T` | The window `T` |
| | **Density rate** (average over runs) | `p(t) = N_spike(t; t+Δt) / (K·Δt)` over `K` repetitions | That the stimulus is repeatable — **explicitly not biologically plausible**; the survey's own image is a frog averaging over several runs of the same fly trajectory |
| | **Population rate** (average over neurons) | `A(t) = N_spike(t; t+Δt) / (N·Δt)` | The population membership; with non-uniform tuning curves, the curves |
| **Temporal — global reference** | **Time-to-first-spike (TTFS)** | `Δt = 1/a` or `Δt = 1 − a` from stimulus onset | **The onset time** |
| | **Phase** | Spike time relative to a reference oscillation; the pattern repeats each cycle | **The oscillation's phase** |
| | **Rank-order coding (ROC)** | Only the *order* in which a population fires | Nothing global — but the absolute amplitude is unrecoverable, and a constant signal cannot be represented at all |
| | **Sequential binary** | One neuron, one bit per clock cycle: presence/absence, or first-half/second-half of the cycle | A clock |
| **Temporal — ISI** | **Inter-spike interval (latency)** | Information in the gaps between a neuron's own spikes | Nothing global |
| | **Burst** | Groups of spikes at very small ISI; membership set by an ISI threshold and expected spike count | The burst thresholds |
| **Temporal — correlation** | **Synchrony** | *Which* neurons fire together identifies the pattern | Nothing global |
| | **Sparse distributed representation** | A subset active at any instant ([[wiki/concepts/sparse-distributed-representations.md]]) | Nothing global |
| | **Amplitude** | Degenerate synchrony: one neuron per value, spikes when its threshold is crossed | Nothing |
| | **Parallel binary** | One neuron per bit of a word, read on synchrony | A word boundary |
| **Temporal — filter/optimizer** | **BSA / HSA** | Spike when the convolution of signal with a *known* filter exceeds threshold; input must be pre-normalised | The filter |
| | **GAGamma** | Encoding posed as compression with prior knowledge: maximise information subject to minimal spike density (mixed-integer optimisation) | A signal prior |
| **Temporal — contrast** | **TBR / step-forward / moving-window** | Spike on the *derivative*: emit ± when the change exceeds a threshold defined against the mean derivative, the previous sample, or a windowed mean | The threshold |

**The first thing to read off the table is the rightmost column.** TTFS, phase and both binary codes need an externally supplied origin — onset, oscillation, or clock. ROC, ISI, synchrony and temporal contrast need none. The survey records the resulting dispute in one line: Rullen & Thorpe argue ROC is more biologically realistic than TTFS *because the brain cannot know when a stimulus began*. That argument generalises past ROC and is the sharpest available statement of a gap the wiki had not named ([[wiki/architectural-gaps.md]] G77).

---

## The capacity arithmetic — the one quantitative comparison available

| Code | Bits carried by `N_spikes` spikes | Source |
|---|---|---|
| Count rate | `log₂(N_spikes + 1)` | Rullen & Thorpe 2001 |
| Rank-order | `log₂(N_spikes!)` | Thorpe et al. |

At `N = 10` that is 3.5 bits against 21.8 bits — order carries **six times** the information of count for the same energy, and the gap grows without bound. A second, smaller arithmetic runs the same way: reconstructing an analog value from a count rate has error falling as `1/N_spikes` if the spike times are exact, but only `1/√N_spikes` if they are Poisson-distributed — so *the same nominal rate code* loses half its precision exponent to the stochasticity usually added to make it look biological.

**The survey then disowns its own numbers.** Reducing a code to a bit count "lacks the consideration of many other aspects", chiefly that **the processing architecture must match the code**: a code that packs many bits into few spikes buys nothing if the downstream network cannot read it. This is the same argument the wiki makes about intelligence measured per parameter ([[wiki/concepts/intelligence-density.md]]) — capacity is a property of a code *plus its reader*, and only the pair can be scored.

---

## Why a benchmark cannot pick the code

The survey assembles MNIST accuracies across coding schemes and immediately warns that the comparison is void: the publications differ in learning method and architecture as well as code, so "the accuracies provide information on the general system performance but not on the coding schemes themselves". Every headline in the table below is confounded.

| Code | Best MNIST reported | Confounded with |
|---|---|---|
| Count rate, converted from an ANN | 99.42% (Esser et al.); 90.85% CIFAR-10 with conversion vs 75.42% without | Offline backpropagation on a rate network ([[wiki/empirical-tensions.md]] T231) |
| Count rate, STDP-trained | 95% (2015) → 97%+ (2019) | Single trainable layer |
| Sparse population TTFS (Gaussian receptive fields) | 98.4%, Caltech-101 and ETH-80 also reported | Hand-built difference-of-Gaussian front end + SVM readout |
| TTFS, converted | Error within 2% of the ANN, at **7× lower computational cost** on LeNet-5 (Rueckauer & Liu) | Conversion again |
| Phase, converted | Accuracy preserved, fewer spikes and lower inference latency | Conversion again |
| Burst | Reported fast and energy-efficient on MNIST and CIFAR | Deep architecture |

**The one clean comparison in the survey is not on MNIST.** A microelectronic gas sensor (Chen et al.) ran the *same* sensor, *same* network and *same* task under two codes: **ROC 95.2%, TTFS 100%**. The stated cause is mechanical — under ROC the spikes fall very close together, so small jitter permutes the order and the classification flips. Read against the capacity table this is the whole trade in one measurement: **rank order carries `log₂(N!)` bits and spends its entire margin on jitter tolerance.** A builder choosing a code is choosing a position on that exchange, not a better code.

---

## Constructive recipes worth keeping

| Recipe | Construction | Why it matters here |
|---|---|---|
| **Gaussian receptive fields → sparse TTFS** | A bank of overlapping Gaussian fields tiles the input range; each field's response becomes a firing *delay*; responses below a cut-off emit no spike at all | The wiki's cheapest scalar-to-population encoder. It produces sparsity as a by-product of the cut-off rather than by an inhibitory circuit ([[wiki/concepts/inhibitory-control-of-coding.md]]), and it is what the survey re-labels from the original authors' "population coding" |
| **Random rather than structured input wiring** | Connecting receptive fields to input neurons at random beat one-neuron-per-field rows, learning *faster and to higher accuracy* (iris) | An expansion-recoding result arriving from the encoder side; same direction as reservoir practice ([[wiki/concepts/autonomous-pattern-generation.md]]) |
| **ON/OFF centre pairs before any coding** | Delorme & Thorpe's input layer emits spikes from intensity *differences* across paired cells, then orientation-selective cells, then class | The encoding and the first feature extraction are the same operation — the code is not a neutral transport layer |
| **Temporal contrast in hardware** | The event camera (Lichtsteiner, Posch & Delbruck): each pixel emits ± events on *relative* intensity change, transmitting only coordinates and a timestamp | Because the change is relative per pixel, scenes with uneven lighting are captured at high dynamic range — the code, not the sensor's photodiodes, is what buys the range. Nothing is transmitted where nothing changes |
| **Adaptive rate / exponential neurons** | Zambrano & Bohte adapt the firing rate to cut spike count; Zhang et al. use global-referenced binary codes with exponential-input neurons to reach the *same activation* as a count rate at far fewer spikes | The count rate's spike budget is not intrinsic to what it represents |

**(brainstorm) Temporal contrast is a derivative code, and the wiki wants derivative codes elsewhere.** [[wiki/concepts/event-segmentation.md]] posits that a boundary is where a prediction fails; a temporal-contrast encoder emits an event exactly when a signal departs from its own recent baseline by more than `θ`, which is the same test one level down and with no model at all. An architecture whose *input* is already segmented into change events never has to detect change as content — the same free-lunch argument the SNN page makes for directed edges via STDP asymmetry.

---

## Hybrid coding — named, unspecified

The survey's closing position is that rate and temporal codes should be combined, and it lists three incompatible proposals for how, none implemented:

| Proposal | Unit of switching |
|---|---|
| Fairhall et al. | **Timescale** — one spike train carries several channels, each at its own timescale, each with its own code |
| Park et al. (burst) | **Layer** — the code differs between network layers |
| Rullen & Thorpe | **Neuron state** — a single neuron switches code |

Its verdict: "not yet clearly defined and needs further investigations." The wiki already holds one measured instance of the first: the hippocampal–prefrontal wire is frequency-multiplexed, theta phase-locking carrying coordination while gamma tracks encoding success ([[wiki/concepts/temporal-coding.md]]) — one anatomical connection, several logical channels. That is a hybrid code observed but not designed.

---

## Open problems

- **No selection procedure.** The survey's own question — which scheme for which application — is answered with a list of qualitative trade-offs (accuracy, dynamics, latency, noise vulnerability, energy, hardware) and no procedure. Since task accuracy is confounded and bit counts are reader-dependent, there is currently no way to *score* an encoding at all.
- **The reference origin is never supplied.** TTFS, phase and binary codes are the best-performing temporal families and each needs an external onset, oscillation or clock. Where it comes from is unaddressed (G77).
- **Encoding is treated as an input-side problem only.** The survey notes in passing that "neurons driving actuators will have to use different coding schemes than sensors" and never returns to it. Nothing here says how a *decision* or a *structured answer* should be encoded — which is [[wiki/architectural-gaps.md]] G76 (a temporally coded output has no loss function) met from the representation side rather than the training side.
- **Density rate is in the taxonomy and cannot be in a brain.** It requires repeated trials of an identical stimulus. It is kept because it is useful in simulation — a reminder that this taxonomy is of engineering practice, not of biology.
- **No compositional encoding.** Every scheme listed encodes a *scalar* or a *vector of scalars*. None encodes a relation, a binding or a structure, so the interface into every spiking architecture in the wiki is flat ([[wiki/concepts/vector-symbolic-binding.md]] is the only wiki mechanism that would need otherwise).

---

## Connections

- **[[wiki/concepts/temporal-coding.md]]** — this page is the taxonomy of *writing* a timing code, that page the mechanism of *reading* one; they meet at the reference problem — that page's coincidence detector requires an already-coherent input volley, and this page's survey records the biological objection that no such reference exists for TTFS or phase, which is why rank-order and inter-spike-interval codes are argued to be more realistic despite being measurably more jitter-fragile (ROC 95.2% vs TTFS 100% on the same gas-classification task).
- **[[wiki/entities/spiking-neural-networks.md]]** — supplies the input stage that page's architecture table leaves blank, and turns two of its results into statements about codes rather than networks: the conversion route's accuracy lead belongs specifically to the **count rate** code (the only one equivalent to a ReLU activation), and the same converted networks re-coded as TTFS or phase keep the accuracy while cutting spikes and latency — so the code and the training route are separable choices that the literature has been varying together.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — placed by this survey inside the *synchrony* family: an SDR is a temporal code whose message is which subset is co-active at an instant, which supplies the missing temporal reading of a construct the wiki has only ever treated as a static binary vector, and identifies its degenerate limit (one active neuron per value = amplitude coding).
- **[[wiki/concepts/intelligence-density.md]]** — the same measurement failure in a different currency: bits-per-spike is meaningless without the reader that decodes them, exactly as capability-per-parameter is meaningless without the deployment that uses them; both pages conclude a ratio can only be scored for a code-plus-reader pair.
- **[[wiki/concepts/event-segmentation.md]]** — temporal-contrast encoding is that page's boundary test moved into the sensor: an event is emitted when the signal departs from its own recent baseline past a threshold, so an architecture reading an event camera receives pre-segmented change without running a predictive model **(brainstorm)**.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — an alternative route to the same sparsity: a Gaussian-receptive-field TTFS encoder gets a sparse code from a response cut-off at the input, with no lateral inhibition and no active regulation of the firing fraction.
- **[[wiki/concepts/autonomous-pattern-generation.md]]** — the encoder-side echo of the reservoir result: random connections between receptive fields and input neurons learned faster and more accurately than structured one-per-row wiring, so expansion recoding pays before the network as well as inside it.
- **[[wiki/concepts/latent-graph-discovery.md]]** — where the choice bites the target problem: an encoder is a commitment about which observational differences are *representable at all*, made before any structure learning starts, and every scheme catalogued here encodes scalars only — so no encoder in this literature can present a relation to the discoverer.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the GAGamma scheme states the encoding problem as compression outright: maximise information subject to minimum spike density given a prior on the signal, which makes the choice of code a rate–distortion problem rather than a design preference.
- **[[wiki/entities/thousand-brains-theory.md]]** — hierarchical temporal memory appears here as the applied instance of synchrony coding: a spatial pooler learning which input neurons fire together and a temporal memory over the resulting sequences, deployed for anomaly detection and sequence prediction.
- **[[wiki/concepts/spike-frequency-adaptation.md]]** — the reader turns out to constrain the code: Poisson, rate and population encoding are named inadequate for adaptive neurons because their elevated timing sensitivity converts presynaptic jitter a plain LIF unit absorbs into information loss, so an encoding cannot be scored independently of the neuron model downstream (Ganguly et al. 2024; T232).
- **[[wiki/concepts/circuit-size-separation.md]]** — where this page's reference-signal objection does the most damage: every proven size separation between spiking and rate networks is cashed in **linear temporal coding** (`x_i ↦ T_in − x_i·c`), which is time-to-first-spike under another name and inherits its need for an externally supplied onset — so the strongest formal case for the spiking substrate rests on the scheme this page records as the least biologically defensible, and no separation has been re-derived under a self-referenced code ([[wiki/architectural-gaps.md]] G77).
- **[[wiki/concepts/cross-paradigm-interface.md]]** — this page's whole taxonomy is one factor of a larger composition `Q·F·H·W`: every scheme here is a choice of the discretisation stage `Q` with windowing, kernel and nonlinearity left at identity, and stating it that way makes the encoder a *trainable* module between two networks rather than a fixed front end — which is the shape this page's "no selection procedure" problem needs, though nobody has yet learned `Q` itself (Zhao et al. 2022).
- **[[wiki/concepts/spike-train-error-metrics.md]]** — the output-side counterpart of this page: here a signal is turned into spikes, there an emitted train is scored against a target one. The two share a defect — a target spike *time* presupposes the same missing origin that [[wiki/architectural-gaps.md]] `G77` charges against time-to-first-spike and phase codes — and a shared number: the achievable precision is millisecond-scale on both sides.
- **[[wiki/concepts/neuronal-parameter-heterogeneity.md]]** — where T232's confound gets worse: an adaptive unit's timing sensitivity already makes the best code depend on the neuron model reading it, and this mechanism gives *every neuron a different one* — a single global input code now faces a population of readers with different learned time constants and thresholds, which nothing in either page's evidence measures.
- **[[wiki/concepts/learnable-synaptic-delays.md]]** — the one timing quantity in the wiki that escapes `G77` by construction: a synaptic delay is measured from the *presynaptic spike*, a reference the network itself produces, so unlike time-to-first-spike or phase it needs no stimulus onset, oscillation or clock — and no encoding scheme here has been rebuilt on that observation.
