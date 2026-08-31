# Neuron Complexity Index — Fitting a Cell's I/O with a Network and Reading Off Its Size

**Score a neuron by the smallest artificial network that reproduces its input/output map at single-spike, millisecond resolution. For a layer-5 cortical pyramidal cell the answer is a temporally convolutional network of 5–8 layers, 128 channels wide, reading 153 ms of synaptic history — and if the NMDA conductance is deleted from the same cell, the answer collapses to one hidden layer. The depth is not the morphology and not the sodium spike; it is the interaction between NMDA receptors and the dendritic tree.**

This is the empirical counterpart to [[wiki/concepts/circuit-size-separation.md]]: that page derives *lower* bounds on units by proof for hand-built witness functions, this one measures an *upper* bound by gradient descent on the real I/O map. The two brackets do not yet meet, but they are on the same axis — units-for-a-function — and that axis is the one the wiki uses to decide what a "unit" is worth.

> **Provenance.** `raw/beniaguev-2021-single-neurons-as-deep-networks.md` — Beniaguev, Segev & London, *Single cortical neurons as deep artificial neural networks*, Neuron 109:2727–2739, 2021. Everything measured is measured on **biophysical simulations**, not on cells: a 3D-reconstructed rat somatosensory L5PC compartmental model with full active conductances, and one basal branch of a mouse L23PC. No electrophysiology.

---

## The procedure

| Step | Choice made | Why it matters |
|---|---|---|
| Data | Simulate the compartmental model under in-vivo-like input: excitatory + inhibitory synapses uniform over the tree, Poisson activation with a piecewise-constant rate trajectory; ~200 h simulated time for the L5PC | The *training distribution* is a modelling decision, and it is what the resulting complexity number is conditioned on |
| Input representation | Binary matrix `N_syn × T`, 1 ms bins, `T` ms of preceding history | Makes the neuron a causal sequence-to-sequence map; `T` becomes a third complexity hyperparameter alongside depth and width |
| Output | **Dual**: binary spike at `t` **and** somatic subthreshold `V_m(t)` | The voltage head is what forces the network to model integration rather than only the threshold crossing |
| Architecture class | Fully connected (FCN) and temporal convolutional (TCN) only | The reported size is an upper bound *within this class*; a better architecture would lower it |
| Fidelity threshold | Spike-prediction **AUC ≥ 0.9910** | An arbitrary but fixed bar; the ranking of conditions is reported as insensitive to its exact value |
| Complexity readout | Smallest (depth, width, `T`) triple clearing the bar, over a grid of 137 trained networks (62 AMPA-only, 75 AMPA+NMDA) | The index |

---

## The measurements

| Neuron model | Minimal network | History `T` | Spike AUC | `V_m` RMSE / variance explained |
|---|---|---|---|---|
| Integrate-and-fire | 1 hidden layer, **1 hidden unit** | 80 ms | 0.9973 | 1.73 mV / 79.8% |
| One L23PC basal branch, 9 NMDA synapses | 1 hidden layer, **4 units** | — | — | — |
| **L5PC, AMPA only** (full morphology, Ca²⁺ spikes, all active conductances intact) | 1 hidden layer, **128 units** | 43 ms | 0.9913 | 0.58 mV / 95.0% |
| **L5PC, AMPA + NMDA** | **7 layers** × 128 channels (5–8 works) | 153 ms | 0.9911 | 0.71 mV / 94.6% |

**The controlled comparison is the whole result.** Same morphology, same active dendritic currents, same somatic spike mechanism, same output firing rate (AMPA rate raised to compensate for the lost NMDA current) — one conductance removed, and the required depth falls from seven layers to one. Depth is bought by a *receptor*, not by geometry.

Two supporting sweeps:

| Manipulation | Effect on required size |
|---|---|
| Restrict where synapses live: full tree → no tuft → basal only → proximal basal only | Monotone decrease in complexity; morphological extent and receptor nonlinearity are **additively** interacting, not redundant — segregated compartments are harder to fit even in the AMPA-only case |
| Raise maximal NMDA conductance from zero | Steep initial rise in complexity, then diminishing returns — the qualitative jump is at the *presence* of the conductance, not its magnitude |

---

## Why NMDA and not the calcium spike

The mechanism, read off the first-layer filters rather than asserted:

- **NMDA conductance is voltage-dependent**, so a synapse's effect is a function of its *neighbours'* recent activity and of its dendritic location — the input is no longer separable across synapses.
- Its current is **slow** (tens of ms), which is where the 153 ms vs 43 ms history difference comes from.
- **Without NMDA, apical tuft weights are essentially zero in every first-layer filter** — despite the model generating occasional nexus Ca²⁺ spikes. The tuft carries no information about somatic output. With NMDA, tuft weights become significant and their temporal filters become markedly *broader* than proximal ones: distal input matters, but its precise timing does not.

That last row is a concrete prediction about [[wiki/concepts/canonical-cortical-microcircuit.md]]'s feedback channel: **the layer-1 prediction pathway is electrically inert unless NMDA receptors are present**, so any model that treats the apical tuft as a top-down input port is implicitly assuming an NMDA-dependent one ([[wiki/concepts/dendritic-computation.md]], [[wiki/entities/thousand-brains-theory.md]]).

---

## A dendrite is a small bank of spatiotemporal templates

The one-branch case is the interpretable one. Nine excitatory NMDA synapses along a single L23PC basal dendrite are fit by **four hidden units**, and the four filters are legible:

| Unit | What it matches |
|---|---|
| 1 | Recent, **proximal** activation only |
| 2 | Recent, **distal** activation only |
| 3 | **Direction-selective** — distal→proximal temporal sequence |
| 4 | Prolonged distal summation **plus** precisely timed proximal input |

So nonlinear dendritic integration = *pattern matching against a handful of spatiotemporal templates*, and one of them is a sequence-order detector. This is the same primitive [[wiki/concepts/temporal-coding.md]] and [[wiki/concepts/learnable-synaptic-delays.md]] reach from the spiking side (order, not coincidence), obtained here without any delay parameter — the asymmetry comes from the cable and the NMDA time constant.

---

## Generalisation, and depth as the thing that buys it

Both fitted networks were trained **only** on random, uniformly distributed Poisson input, and both hold up far outside it:

- The 7-layer L5PC network reproduces somatic voltage and spikes under **spatially clustered** input restricted to subtrees, **temporally synchronous** volleys, and input with inhibition removed — regimes that evoke NMDA spikes the training set rarely contained (~230 min of test simulation).
- The 4-unit branch network, trained on random activation, predicts the response to the never-seen distal→proximal and proximal→distal ordered sequences, and predicts peak somatic voltage for arbitrary orderings **better than the hand-designed directionality index** it is compared against.
- **Deeper analogous networks generalise better out of distribution.** The paper's own sweep: OOD fidelity improves monotonically with depth, at fixed in-distribution accuracy.

That last point is the most transferable finding on this page and the least discussed in it: **within a family of networks all fitted to the same function to the same in-distribution accuracy, depth predicts out-of-distribution fidelity.** If it survives replication outside this setting it is a direct handle on [[wiki/empirical-tensions.md]] T6 — what OOD failure is a failure *of* — because here it is a failure of *capacity to represent the mechanism*, not of data coverage `(brainstorm)`.

---

## What it means for a cortical circuit

The paper's own architectural proposal, and the reason this page is not merely a neuroscience result:

- A cortical network of `L` anatomical layers is, computationally, a network of depth `~5–8 × L`. Anatomical connection counts **understate** circuit depth by nearly an order of magnitude.
- **But the extra depth is frozen.** In the analogous network, synaptic plasticity can only modify the **input layer** — the hidden layers encode the fixed biophysics of that cell type. The cortical circuit is therefore a stack of *learnable sparse projections interleaved with fixed deep nonlinear feature extractors*, not a deep trainable network.
- The caveat the authors raise: branch-specific and intrinsic plasticity are non-synaptic and could, in principle, reach into those hidden layers. Nobody has shown what they can move there.

**(brainstorm) This is a reservoir architecture with the reservoir inside the unit.** A fixed, high-dimensional, temporally extended random-ish nonlinear expansion with a trained linear-ish read-in is exactly the bargain [[wiki/entities/liquid-state-machine.md]] and [[wiki/concepts/autonomous-pattern-generation.md]] make at the network level — here it is made per neuron, ~10⁴ times per column, with the expansion *evolutionarily selected* rather than random. The transferable design is not "make units deeper"; it is **spend the parameter budget on the read-in to a fixed deep spatiotemporal feature bank**, which is cheap to train, cheap to store, and gives every downstream unit the same 153 ms of nonlinear history for free.

**(brainstorm) The index is a cross-species instrument nobody has run.** Fitting the same procedure to a human vs. mouse L5PC, or to a Purkinje cell vs. a CA1 cell, would turn "the human cortex is more powerful per neuron" from rhetoric into a number — and would be the first per-unit measurement to put alongside the per-clade neuron *counts* of [[wiki/concepts/cellular-scaling-rules.md]], which count units and say nothing about what one costs to imitate.

---

## Practical: the surrogate

Replacing the compartmental model with its fitted network gives a **~2000× speedup** over numerically integrating thousands of coupled nonlinear PDEs, at 94.6% voltage variance explained and single-spike accuracy. This is the standard amortisation trade ([[wiki/concepts/amortized-inference.md]]) applied to a simulator: pay once in training, then run large networks of biophysically faithful neurons at rate-network cost. The dataset of simulated L5PC I/O pairs is released.

---

## Limitations

| Limit | Consequence |
|---|---|
| **Upper bound only** | A smaller network may exist and optimisation may have missed it. The I&F control (1 unit found when 1 unit sufficed) argues the bound is tight-ish, but does not prove it |
| Architecture class restricted to FCN/TCN | A recurrent or state-space unit with an internal time constant might fit the same map far more compactly — untested, and it is the obvious next experiment ([[wiki/entities/ltc.md]], [[wiki/entities/s4.md]]) |
| Fitted to a **model**, not to a neuron | Every number inherits the compartmental model's channel complement and parameters; the index measures the complexity of a *simulation* |
| Complexity ≠ computation | Knowing a cell needs 7 layers says nothing about what function it computes or whether the brain uses it. The authors propose training the analogous network on a real task and mapping it back — not done |
| One input regime | The index is conditioned on uniform Poisson drive at in-vivo-like rates; a different input statistics could give a different minimal size |
| Threshold-dependent | The reported depths hang on AUC = 0.9910; the ordering is claimed robust, the absolute numbers are not |

---

## Connections

- **[[wiki/concepts/dendritic-computation.md]]** — the same organ measured on a different axis and with a different verdict on depth: that page's segment bank is a *two-layer* read of the cell (detectors, then an OR), this page's fit needs 5–8 layers for the same cell type and names NMDA as the reason, which is the receptor that page's detector nonlinearity already is ([[wiki/empirical-tensions.md]] T302).
- **[[wiki/concepts/circuit-size-separation.md]]** — the other half of the units-for-a-function bracket: Maass proves `≥1663` sigmoidal hidden units are *necessary* for one dendritically-realistic neuron's element-distinctness function, this page finds ~7×128 units *sufficient* for the cell's whole I/O map — a proven lower bound on a chosen function against a measured upper bound on the full mapping, the first time the wiki has both ends on one scale.
- **[[wiki/entities/hodgkin-huxley-model.md]]** — the model being amortised: the compartmental Hodgkin–Huxley system with axial coupling is exactly what the fitted network replaces at ~2000× less cost, which retires that page's "too stiff to simulate at network scale" limitation for any cell type someone is willing to fit once.
- **[[wiki/entities/dendritic-ann.md]]** — the complementary ablation: that model imports the dendritic *connectivity graph* with no nonlinearity and gains parameter efficiency; this one holds morphology fixed and toggles the *nonlinearity*, and finds that is where the depth lives — so the two together say topology buys efficiency and NMDA buys depth ([[wiki/empirical-tensions.md]] T64).
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — turns anatomical layer counts into a depth estimate and then freezes most of it: computational depth is `~5–8 ×` the anatomical stage count, but only the inter-neuron (synaptic) layers are plastic.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — bounds what a local rule has to do: if the hidden layers of the analogous network are biophysically fixed, no credit-assignment scheme needs to reach them, and the entire learning problem for a cortical circuit is the input layer of each cell's private feature extractor.
- **[[wiki/concepts/amortized-inference.md]]** — the same trade with a simulator in the role of the posterior: an expensive iterative computation is replaced by a feedforward network trained on its input/output pairs, and the payoff is measured (~2000×).
- **[[wiki/concepts/temporal-coding.md]]** — supplies a direction-selective detector without delays: filter 3 of the single-branch fit prefers distal→proximal sequences purely from cable propagation and NMDA kinetics, so *order* selectivity is available to a rate-coded dendrite and does not require the delay machinery that page treats as its source.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the cleanest instance of level-1 transfer running *backwards*: a machine-learning method is used as a measuring instrument on biology rather than a biological mechanism being imported into a model, and the output is a number that any neuron type can be scored on (T1).
- **[[wiki/concepts/cellular-scaling-rules.md]]** — the missing per-unit term in that page's accounting: neuron counts and average neuron mass are measured across clades, but nothing measures what one neuron *costs to imitate*, and this index is the first candidate for that column.
- **[[wiki/entities/liquid-state-machine.md]]** — the architecture this result reduces to when the frozen hidden layers are taken seriously: a fixed nonlinear spatiotemporal expansion plus a trained read-in, differing from a liquid only in that evolution rather than randomness chose the expansion.
- **[[wiki/entities/ltc.md]]** — the untested rival unit: an input-dependent time constant `τ_sys = τ/(1+τf)` is precisely the mechanism NMDA implements (recent neighbouring activity lengthens integration), so a small LTC network may fit the L5PC map at a fraction of 7×128 — which, if true, would say the measured depth is an artefact of the TCN class rather than a property of the cell.
