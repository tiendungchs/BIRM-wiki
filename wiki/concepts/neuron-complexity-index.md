# Neuron Complexity Index — Fitting a Cell's I/O with a Network and Reading Off Its Size

**Score a neuron by the smallest artificial network that reproduces its input/output map at single-spike, millisecond resolution. For a layer-5 cortical pyramidal cell the answer is a temporally convolutional network of 5–8 layers, 128 channels wide, reading 153 ms of synaptic history — and if the NMDA conductance is deleted from the same cell, the answer collapses to one hidden layer. The depth is not the morphology and not the sodium spike; it is the interaction between NMDA receptors and the dendritic tree.**

This is the empirical counterpart to [[wiki/concepts/circuit-size-separation.md]]: that page derives *lower* bounds on units by proof for hand-built witness functions, this one measures an *upper* bound by gradient descent on the real I/O map. The two brackets do not yet meet, but they are on the same axis — units-for-a-function — and that axis is the one the wiki uses to decide what a "unit" is worth.

> **Provenance.** `raw/beniaguev-2021-single-neurons-as-deep-networks.md` — Beniaguev, Segev & London, *Single cortical neurons as deep artificial neural networks*, Neuron 109:2727–2739, 2021. Everything measured is measured on **biophysical simulations**, not on cells: a 3D-reconstructed rat somatosensory L5PC compartmental model with full active conductances, and one basal branch of a mouse L23PC. No electrophysiology.
>
> **Second source.** `raw/aizenbud-2026-dendritic-morphology-synaptic-nonlinearities-human-cortical-neurons.md` — Aizenbud, Yoeli, Beniaguev, de Kock, London & Segev, *Dendritic morphology and synaptic nonlinearities enhance functional complexity in human cortical neurons*, PNAS 123(28):e2533168123, 2026. Same lab, same fitting pipeline, run across **24 compartmental models** (12 rat, 12 human, 3 per layer L2/3, L4, L5, L6). Again simulations only. Supplementary figures (S1–S9, Tables S1–S2) were not clipped; their results are known only as the main text describes them. Its results are in the section *The cross-species run* below.

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

**(brainstorm) The index is a cross-species instrument nobody has run.** Fitting the same procedure to a human vs. mouse L5PC, or to a Purkinje cell vs. a CA1 cell, would turn "the human cortex is more powerful per neuron" from rhetoric into a number — and would be the first per-unit measurement to put alongside the per-clade neuron *counts* of [[wiki/concepts/cellular-scaling-rules.md]], which count units and say nothing about what one costs to imitate. The human cell's candidate extra ingredients are now listed (Galakhova et al. 2022, [[wiki/entities/human-supragranular-pyramidal-neuron.md]]): a Ca²⁺ branch nonlinearity that is *non-monotonic* in input strength and computes exclusive-or in one cell (Gidon et al. 2020), ~2× the synapses and ~3× the dendrite of a mouse L2/3 cell, and reduced distal electrogenesis in L5 (Beaulieu-Laroche et al. 2018). The prediction is a larger minimal network than the rodent's. **The fit has now been run, on a narrower model than this list**: human morphology and human NMDA synapses only, with active dendritic conductances left out, so the Ca²⁺ exclusive-or branch is not in it (next section).

---

## The cross-species run — fixed network, read the miss (Aizenbud et al. 2026)

### The readout is inverted

| | Beniaguev 2021 | Aizenbud 2026 |
|---|---|---|
| Held fixed | Fidelity bar (AUC ≥ 0.9910) | Network: TCN (Temporal Convolutional Network), **3 layers × 128**, 3 seeds per cell |
| Read off | Smallest (depth, width, `T`) that clears the bar | How far that fixed network falls short |
| Index | Network size | **FCI** (Functional Complexity Index) `= log₁₀(1000·(1−AUC)) / log₁₀(1000·(1−0.9))`: 0 at AUC 0.999, 1 at AUC 0.9, roughly linear between |
| Training / scoring target | Spike + subthreshold `V_m` / spike AUC | Same: trained on both, scored on spike AUC at 1 ms |
| Input | Poisson, piecewise-constant rate | Same, 1 excitatory + 1 inhibitory synapse per µm of dendrite; E/I input rates searched per cell so **output is 1 spike/s ± 0.01** (removes firing rate as a confound) |
| Cost | — | ~8.7 GPU-days per cell (12,000 × 10 s simulations); ~2.3 GPU-years for the study |

**Choosing the network's capacity.** A network that is too expressive saturates and compresses the differences; one that is too weak inflates them. Depth sweep 1–9 on rat and human L2/3: performance **plateaus beyond 3–5 layers**, and the species gap is present at every depth. Eight cells re-scored at depth 2, 3 and 7 keep their ranking. Depth 3 was chosen as the cheapest point inside the stable range. So the instrument reports a **ranking**, checked for invariance across capacity, not an absolute size.

### Results

| Comparison | FCI | Test |
|---|---|---|
| Exemplar L2/3, human vs rat (identical passive membrane) | **0.4294 vs 0.1877** | `p` = 2.2e-5 |
| All 12 human vs all 12 rat | **0.3803 vs 0.2244** | `p` = 9.8e-12 |
| Rat by layer | **L5 > L2/3** | `p` = 0.048 |
| Human by layer | **L2/3 > L4, L2/3 > L5** | `p` = 0.013, 0.010 |
| Exemplar gap under structured spatiotemporal input on background noise, and under measured non-uniform synapse placement | Preserved | (Supplementary, not clipped) |

### What the gap is made of

| Manipulation | Result | Reading |
|---|---|---|
| **Rat synapses on every morphology** | Human > rat still, smaller gap (`p` = 0.022) | Morphology alone accounts for part of the gap |
| Full active dendritic complement (Na⁺, Ca²⁺, `I_h`, …) added to the rat L5 model | FCI rises significantly | The instrument detects dendritic nonlinearities other than NMDA |
| Human L5, passive dendrites, vs that active rat L5 | **Human still higher** | Morphology plus NMDA outweighs the whole active channel set, *on these models* |
| `I_h` alone added to passive rat L5 | No significant change | — |
| Four synapse types on every morphology: rat; hybrid A (rat conductance, human NMDA steepness `γ`); hybrid B (human ~3× NMDA conductance, rat `γ`); human | Human ≫ rat on rat, human and pooled morphologies; **both hybrids only slightly above rat** | Conductance and steepness are each weak alone and strong together, so they interact rather than add |
| 5 → 400 synapses driven on one oblique branch of a human L2/3 model | Human synapses turn supralinear at **~35 synapses** (NMDA spike); rat and hybrid A stay linear below 50 and saturate only at ~250 | The mechanism is combinatorial interaction among co-active synapses, not a larger EPSP |

NMDA voltage dependence: `B = 1/(1 + e^{−γV}·[Mg²⁺]/3.57 mM)` (Jahr & Stevens 1990). The human `γ` and ~3× conductance come from Eyal et al. 2018 and are **assumed** in the models, not measured in this paper.

### Which morphology features predict FCI

58 NeuroM features per cell, fitted by linear regression `FCI(m) = Σᵢ αᵢ fᵢ(m) + β` with up to 4 features:

| Features | `R²` |
|---|---|
| Total dendritic area (best single feature) | (value lost in the clip) |
| + longest bifurcation branch | **0.81** |
| + longest trunk branch | 0.85 |
| Best 4 | 0.88 |
| Number of bifurcation branches alone | "modest" |

- Features 3 and 4 (trunk and terminal branch lengths) have **negative** coefficients. At fixed total dendrite, length spent on *internal* branches (bifurcation to bifurcation) raises complexity, and length spent on the trunk or on terminal tips lowers it.
- The **branch count** is a weak predictor. Complexity follows size combined with internal branching, not the number of branches ([[wiki/concepts/dendritic-computation.md]], [[wiki/empirical-tensions.md]] T63).
- The paper states that 23 features "entirely" explain FCI. With 24 cells, 23 regressors fit any data perfectly, so that claim carries no information. Only the 1–4-feature numbers count.

### Against this page's earlier claims

| Earlier claim (Beniaguev 2021) | The 2026 run | Verdict |
|---|---|---|
| Depth needs NMDA; the Ca²⁺/Na⁺ spike machinery does not buy it (AMPA-only L5PC with all actives needs 1 layer) | With NMDA present, adding the active complement raises FCI | Refines the lead: NMDA is necessary for depth, and *given* NMDA, active conductances and morphology each add to it |
| Raising NMDA conductance past its first increment has diminishing returns | ~3× conductance with rat `γ` → only slight gain; with human `γ` → large gain | Consistent. The 2026 run adds that the steepness `γ` is what unlocks the conductance |
| Restricting synapses to smaller subtrees lowers complexity | Larger dendritic area is the best predictor | Consistent, now measured across cells rather than within one |
| L5PC needs 5–8 layers to clear AUC 0.991 | At fixed width 128, performance plateaus beyond 3–5 layers for L2/3 models | Different cells and bar; weak evidence that depth needs are cell-type dependent ([[wiki/empirical-tensions.md]] T302) |

### Limits specific to the 2026 run

| Limit | Consequence |
|---|---|
| **No active dendritic conductances in any human model** | The Gidon band-pass Ca²⁺ branch — the human cell's most distinctive nonlinearity ([[wiki/entities/human-supragranular-pyramidal-neuron.md]]) — is absent. The human–rat gap is measured without it |
| Identical passive membrane across species (`C_m` = 1 µF/cm², `R_m` = 20,000 Ω·cm², `R_a` = 150 Ω·cm) | Deliberate isolation. It also discards the lower human capacitance reported by Eyal et al. 2016 |
| Human NMDA parameters taken from another modelling paper | The synaptic half of the gap is conditional on those parameters. The authors frame it as "*if* human NMDA is larger and steeper" |
| 3 cells per layer per species | The layer reversal rests on `n` = 3 per cell group |
| One synapse per µm of dendrite | Synapse count scales with dendritic length. "Area predicts FCI" cannot separate more synapses from more cable, which is the separation [[wiki/architectural-gaps.md]] G101 needs |
| Spike AUC only, output fixed at 1 spike/s | Complexity is measured in one output regime. Nothing here is scored on a task |

**(brainstorm) The layer reversal is the most architectural result.** Rat per-cell complexity peaks in L5, the output tier to subcortex. Human per-cell complexity peaks in L2/3, the tier that is thicker in humans (~50% vs 19% of cortical thickness) and where more human cortico-cortical projections start ([[wiki/entities/human-supragranular-pyramidal-neuron.md]], [[wiki/concepts/canonical-cortical-microcircuit.md]]). Together these suggest the human cortex spends per-unit compute on the units that send **inter-module messages**, not on the units that drive actions. A model reading: make the units that write to the shared bus richer (more nonlinear dendrites) than the units that drive motor output.

**(brainstorm) FCI works as a general instrument for any learned module.** Fit a fixed, deliberately limited network to a module's I/O and treat the error as its complexity. Sweep the limited network's capacity and report only rankings that hold across that sweep. This is the depth-curve fix that [[wiki/concepts/representation-probing.md]] asks for, applied here to the question of how hard the module is to imitate rather than what it encodes.

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
| One input regime | The index is conditioned on uniform Poisson drive at in-vivo-like rates; a different input statistics could give a different minimal size. The 2026 run partly answers this: the human–rat ordering survives structured spatiotemporal input and measured non-uniform synapse placement |
| Threshold-dependent | The reported depths hang on AUC = 0.9910; the ordering is claimed robust, the absolute numbers are not |

---

## Connections

- **[[wiki/concepts/dendritic-computation.md]]** — the same organ measured on a different axis and with a different verdict on depth: that page's segment bank is a *two-layer* read of the cell (detectors, then an OR), this page's fit needs 5–8 layers for the same cell type and names NMDA as the reason, which is the receptor that page's detector nonlinearity already is ([[wiki/empirical-tensions.md]] T302).
- **[[wiki/concepts/circuit-size-separation.md]]** — the other half of the units-for-a-function bracket: Maass proves `≥1663` sigmoidal hidden units are *necessary* for one dendritically-realistic neuron's element-distinctness function, this page finds ~7×128 units *sufficient* for the cell's whole I/O map — a proven lower bound on a chosen function against a measured upper bound on the full mapping, the first time the wiki has both ends on one scale.
- **[[wiki/entities/hodgkin-huxley-model.md]]** — the model being amortised: the compartmental Hodgkin–Huxley system with axial coupling is exactly what the fitted network replaces at ~2000× less cost, which retires that page's "too stiff to simulate at network scale" limitation for any cell type someone is willing to fit once.
- **[[wiki/entities/dendritic-ann.md]]** — the complementary ablation: that model imports the dendritic *connectivity graph* with no nonlinearity and gains parameter efficiency; this one holds morphology fixed and toggles the *nonlinearity*, and finds that is where the depth lives — so the two together say topology buys efficiency and NMDA buys depth ([[wiki/empirical-tensions.md]] T64).
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — turns anatomical layer counts into a depth estimate and then freezes most of it: computational depth is `~5–8 ×` the anatomical stage count, but only the inter-neuron (synaptic) layers are plastic. It also places per-cell complexity by layer: highest in L5 for rat and in L2/3 for human (Aizenbud et al. 2026), so which tier holds the richest units is species-dependent.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — bounds what a local rule has to do: if the hidden layers of the analogous network are biophysically fixed, no credit-assignment scheme needs to reach them, and the entire learning problem for a cortical circuit is the input layer of each cell's private feature extractor.
- **[[wiki/concepts/amortized-inference.md]]** — the same trade with a simulator in the role of the posterior: an expensive iterative computation is replaced by a feedforward network trained on its input/output pairs, and the payoff is measured (~2000×).
- **[[wiki/concepts/temporal-coding.md]]** — supplies a direction-selective detector without delays: filter 3 of the single-branch fit prefers distal→proximal sequences purely from cable propagation and NMDA kinetics, so *order* selectivity is available to a rate-coded dendrite and does not require the delay machinery that page treats as its source.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the cleanest instance of level-1 transfer running *backwards*: a machine-learning method is used as a measuring instrument on biology rather than a biological mechanism being imported into a model, and the output is a number that any neuron type can be scored on (T1).
- **[[wiki/concepts/cellular-scaling-rules.md]]** — the missing per-unit term in that page's accounting: neuron counts and average neuron mass are measured across clades, but nothing measures what one neuron *costs to imitate*, and this index now puts the first two-species numbers in that column: human pyramidal models score FCI 0.38 against 0.22 for rat, with most of the gap coming from dendritic area rather than from neuron count (Aizenbud et al. 2026).
- **[[wiki/entities/liquid-state-machine.md]]** — the architecture this result reduces to when the frozen hidden layers are taken seriously: a fixed nonlinear spatiotemporal expansion plus a trained read-in, differing from a liquid only in that evolution rather than randomness chose the expansion.
- **[[wiki/entities/ltc.md]]** — the untested rival unit: an input-dependent time constant `τ_sys = τ/(1+τf)` is precisely the mechanism NMDA implements (recent neighbouring activity lengthens integration), so a small LTC network may fit the L5PC map at a fraction of 7×128 — which, if true, would say the measured depth is an artefact of the TCN class rather than a property of the cell.
- **[[wiki/concepts/apical-amplification.md]]** — the mechanistic reduction this page's fitting prices: three compartments (tuft, coupler, soma) with bidirectional threshold lowering, against 5–8 fitted layers for the same L5 cell — and the two agree on where the discrepancy lives, since the A/B/C model assumes away exactly the NMDA-mediated interaction between branches (`T302`).
- **[[wiki/entities/human-supragranular-pyramidal-neuron.md]]** — the cell this page's cross-species proposal needs: human L2/3 has a non-monotonic Ca²⁺ branch that computes exclusive-or, ~2× the synapses and ~3× the dendrite of mouse L2/3, so the minimal fitting network should be larger than the rodent L5 figure (Galakhova et al. 2022). That prediction is now confirmed for morphology plus NMDA only (FCI 0.38 vs 0.22), with the Ca²⁺ branch left out of every model (Aizenbud et al. 2026).
- **[[wiki/concepts/representation-probing.md]]** — the same capacity problem from the other side: a probe that is too strong computes the answer itself, and an imitation network that is too strong hides complexity differences. FCI is the one instrument in the wiki that handles this by sweeping read-out depth and reporting only rankings that hold across the sweep (Aizenbud et al. 2026).
