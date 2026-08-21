# Analog In-Memory Computing

**Store the weights as device conductances in a crossbar and let Ohm's and Kirchhoff's laws perform the matrix–vector multiply in place — so *reading* a weight matrix is nearly free and *writing* one is the expensive, stochastic, rate-limiting operation.**

```
inputs  v_i  applied on rows  →  I_j = Σ_i G_ij v_i  read on columns          (MVM, one analog step)
weights G_ij  stored as the crystalline/amorphous phase fraction of a device  (non-volatile, ~4-bit, drifting)
```

This inverts the cost model every other page in the wiki assumes. On a von Neumann machine a weight update is a store instruction and a matrix multiply is the expense; here the matrix multiply is one settling time over the whole array and a weight update is an iterative program-and-verify loop against a stochastic phase transition. **An architecture deployed on this substrate is therefore priced in *devices written*, not in gradient steps** — and that single change of denominator selects a different family of learning rules than plausibility arguments do.

> **Provenance.** Ortner, Petschenig, Vasilopoulos, Renner, Brglez, Limbacher, Piñero, Linares-Barranco, Pantazi & Legenstein 2025, *Rapid learning with phase-change memory-based in-memory computing through learning-to-learn* (`raw/ortner-2025-phase-change-memory-rapid-learning.md`, Nature Communications 16). Every number below is from it unless attributed otherwise.

---

## The substrate, specified once

| | IBM two-core phase-change-memory (PCM) platform |
|---|---|
| Array | 2 cores × 256 × 256 crossbar; unit cell **4R8T** (4 devices, 8 control transistors) — 2 devices for `BL⁺`, 2 for `BL⁻`, the unused pair held in a high-resistance RESET state, so a signed weight costs a differential pair |
| Devices | 262,144 per core; mushroom-type, doped Ge₂Sb₂Te₅, inserted in the back end of line at 14 nm |
| Weight encoding | Relative volume of crystalline (high-conductance) vs amorphous (low) material; gradual set, abrupt reset |
| Periphery | 256 digital-to-analog converters (signed 8-bit pulse-width modulation), 256 analog-to-digital converters, per-core digital unit doing affine correction; **4-phase MVM** (one input sign against one weight sign per phase) for precision |
| Abstraction to the software stack | Two independent **8-bit in / 8-bit out MVM units**, driven from PyTorch; convolutions mapped by `im2col`, arrays larger than 256 fragmented across regions and recombined |
| Effective weight precision | ≈ **4 bits** |
| Non-idealities | Programming is stochastic (needs read–write verify iterations); conductance **drifts** after programming, corrected by a per-column affine fit |

Everything that is *not* an MVM — nonlinearities, pooling, the loss, the update arithmetic — runs on the host. The substrate is a memory that multiplies, not a computer.

---

## The design rule this substrate imposes

| Constraint | What it forbids | What it selects |
|---|---|---|
| Writes are the dominant energy cost and are stochastic | An inner loop that touches every parameter | An inner loop that touches a **named, small** subset |
| No gradient can be backpropagated *through* the array cheaply | Backpropagation-through-time, and any update needing an error routed backwards through analog layers | Forward-only, local rules: a delta rule, e-prop, OSTL/OSTTP |
| Weights are ~4-bit and drift | Solutions that sit in narrow minima of the software loss | Solutions the outer loop has already made insensitive to weight perturbation |
| The array is fixed-size | Networks sized to the crossbar | — (Omniglot CNN reduced from 64 to **56** filters per layer purely to fit) |

**The measured version of row 1.** In the Omniglot experiment the whole convolutional network occupies **342,720 devices**; the inner loop updates only the dense output layer — **1120 devices, < 1% of the weights**, four times. That is the entire adaptation budget for learning five new character classes.

---

## Result 1 — initialization-based L2L reduced to a delta rule

Model-agnostic meta-learning (MAML) over 5-way 5-shot Omniglot, with the inner loop **restricted to the last dense layer**. Restriction is not a simplification, it is what makes the method implementable: with only the output layer plastic, the inner update stops being a gradient through the network and becomes

```
Δθ_lk = α (y_l^(d) − f_θ^j,l) h_k          (and Δb_l = α (y_l^(d) − f_θ^j,l) for the CIFAR variant)
```

— a Widrow–Hoff/delta rule on the pooling-layer output `h`, with **no backward pass anywhere on the chip**.

| Setting | Value |
|---|---|
| Meta-training | 30,000 outer iterations, batch 40, `β = 0.001`, Adam — **in software, full precision, no hardware model, no hardware-aware training** |
| Inner loop | `n = 4` steps, `α = 0.1`, batch of 25 (5 examples × 5 classes) |
| Evaluation | 100 unseen tasks = 500 novel classes |
| Meta-training loss | 0.163 ± 0.008 (32-bit) vs **0.241 ± 0.008** (4-bit quantized with stochastic rounding) |
| Accuracy | Software 32-bit ≈ software 4-bit ≈ **chip 32-bit ≈ chip 4-bit** — all four on par |
| Per-step | Chip lags software after gradient steps 1–2, on par by steps 3–4 |

CIFAR100-FS repeats it at a size the prototype cannot hold (4 conv layers × 256 channels + two dense layers), using a device emulator calibrated on **one million PCM devices**: 37,000 outer iterations, `n = 5` (4 suffices — accuracy is already ≈100% by the fourth step), emulated hardware on par with full-precision software again.

**Two negative results carry more weight than the accuracies.**

- **Quantization-aware meta-training bought nothing.** Meta-training at 4 bits with stochastic rounding — a deliberate imitation of the device — did *not* beat meta-training at 32 bits on either dataset. So the usual pipeline (build an accurate hardware model, meta-train through it) is unnecessary here, which is the paper's headline and the reason the method is deployable to *many* chip instances from one software meta-training run.
- **Without the outer loop the same updates overfit.** Training the same network from scratch by backpropagation on the 25 support images fits them in very few steps and generalizes poorly to the query images. The four cheap updates are not what produces few-shot generalization; the 30,000 expensive ones are. **Rapid adaptation on-chip is bought entirely off-chip.**

---

## Result 2 — parameter-generation L2L: a network that emits the learning signal

The second experiment replaces the learned initialization with a learned *teacher*. **Natural e-prop** — a prior algorithm, adopted here — pairs two spiking networks:

| Network | Composition | Job |
|---|---|---|
| **Trainee** | 250 leaky integrate-and-fire neurons + linear readout; input = a clock-like signal only (5 neurons, sequentially active 50 ms each over a 250 ms trial) | Emit angular velocities for two robot joints |
| **Learning signal generator (LSG)** | 800 neurons, 30% adaptive-threshold (ALIF); input = the same clock **plus the target 3D trajectory** on 53 input neurons | Emit one learning signal `L_l^t` per trainee neuron per millisecond |

```
θ¹ = θ − α Σ_t L^t ⊙ e^t                     one inner update, per-synapse
e_ji^{t+1} = h_j^t Σ_{t′≤t} γ^{t−t′} z_i^{t′}  eligibility trace: local, forward-computable
L_j^t = α_e L_j^{t−1} + Σ_i ψ_ji^out ξ_i^t     learning signal: low-pass filtered LSG output
θ, ψ = argmin Σ_{T_i∼F(T)} L_{T_i}(θ − α Σ_t L^t ⊙ e^t)   outer loop, BPTT, in software
```

Only `θ^in` and `θ^rec` of the trainee are adapted, and only those matrices are mapped to a core; non-plastic weights stay in software. The trial is: run both nets 250 ms with the target visible to the LSG → apply **one** weight update → run the trainee again on the clock alone → the robot executes the trajectory.

| Measurement (4 target trajectories) | Software 32-bit | On chip | Real ED-Scorbot arm |
|---|---|---|---|
| Joint angular-velocity RMSE (base / shoulder), rad s⁻¹ | 0.0381 ± 0.0070 / 0.0363 ± 0.0057 | 0.1274 ± 0.0811 / 0.0668 ± 0.0079 | — |
| End-effector deviation from target, cm | 2.21 ± 1.10 | 6.69 ± 3.40 | 7.82 ± 2.50 |

Before the single update the trainee's output is ≈ 0 — it holds no prior trajectory, so the whole behaviour is written by one application of `L ⊙ e`.

**What this is, structurally.** The LSG is the answer to the standing objection that e-prop *needs a real-time error signal it has no way to obtain* ([[wiki/concepts/biologically-plausible-credit-assignment.md]]): the error is not measured, it is **generated** by a second network that was meta-trained to produce whatever signal makes one update suffice. The target enters through the LSG's input, never through a loss on the trainee. Two costs the framing hides: the LSG is 3.2× the trainee's size, and the objection is displaced rather than removed — the LSG itself is trained by BPTT in software over the task family.

**The more surprising half.** A recurrent SNN has far more sensitive dynamics than a feedforward CNN, and its low-precision analog weights still cost only a few centimetres of end-effector accuracy. The authors' own hypothesis — that **L2L produces a network robust to device variation** — is offered explicitly as unproven ("more analysis would be needed"). It is the sharpest open question this substrate raises for the wiki: if true, meta-training is not just a sample-efficiency device but a *hardware-tolerance* device, and flat-minimum robustness ([[wiki/concepts/meta-optimized-plasticity.md]]) is the mechanism to look at first.

---

## Where the three L2L families land on this substrate

| Family | Inner-loop cost in writes | Status here |
|---|---|---|
| **Initialization-based** (MAML) | One layer, `n` steps — a delta rule if the plastic layer is last | Demonstrated on-chip; the cheapest option, and the one that needs no error transport |
| **Parameter-generation** (natural e-prop, learned optimizers) | Input + recurrent matrices, **one** step | Demonstrated on-chip; buys online recurrent learning at the price of a second, larger network |
| **Model-based** (memory-augmented networks) | Writes to an external store, not to weights | **Not** demonstrated: the controller doing read/write is typically an LSTM trained by BPTT and wants a CPU. Proposed as the natural fit, since a crossbar *is* an addressable store |

---

## Open problems

- **Robustness-by-meta-learning is a hypothesis, not a result.** Two tasks, one device family, no ablation that varies device noise and measures the degradation curve for meta-trained vs conventionally-trained models of the same architecture. The cheap experiment is exactly that sweep.
- **Nothing here adapts the *feature extractor*.** Both demonstrations freeze everything but a thin plastic layer. The general case — many-layer on-chip adaptation without a backward pass — is left to OSTL/OSTTP, which are named as future work and not run.
- **The outer loop is unbudgeted.** 30,000–37,000 iterations of software meta-training amortize only if one meta-trained model is deployed to many chips against tasks from the *same* family; nothing measures what happens when the deployment site's task is outside `p(T)`, which is the knowledge-boundedness limit of [[wiki/concepts/meta-learning.md]] with an energy bill attached.
- **Drift is corrected, not modelled.** A per-column affine fit handles conductance drift at inference. Nothing states how a weight *written on-chip during adaptation* ages relative to one written at deployment, so the retention interval of an inner-loop update is unspecified.
- **(brainstorm) The write-cost asymmetry is an argument for the wiki's slow-W/fast-M split at the level of physics, not biology.** If reads are free and writes are expensive and stochastic, then a system that stores structure in a rarely-written slow matrix and binds instances in a small, frequently-written fast region is not a cognitive hypothesis — it is the layout that minimises energy on this substrate. That is a second, independent derivation of the same architecture that [[wiki/concepts/complementary-learning-systems.md]] derives from interference, and it makes a different prediction: the optimal size of fast **M** should scale with the *write* cost ratio, a quantity no biological argument mentions.
- **(brainstorm) The delta-rule reduction generalises past hardware.** "Restrict the inner loop to the last layer so the update needs no backward pass" costs almost nothing here (< 1% of weights, accuracy on par) and is the same move [[wiki/concepts/test-time-training.md]] does *not* make. Whether last-layer-only test-time training holds its ARC-AGI numbers is an unrun, cheap ablation with a large consequence for deployment cost.

---

## Connections

- **[[wiki/concepts/meta-learning.md]]** — supplies the substrate's reason to exist here: the outer loop is what makes an inner loop small enough to run on a device where writing is the expensive operation, and it is measured to be the source of generalization (backpropagation from scratch on the same 25 examples overfits) rather than a speed-up.
- **[[wiki/concepts/meta-optimized-plasticity.md]]** — the family this page's second result belongs to: the learning signal itself is the meta-learned object, generated by a co-trained network instead of derived from a loss, and its flat-minimum argument is the candidate explanation for why 4-bit analog weights cost so little accuracy.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — e-prop's blindness to the future is dodged rather than solved here: a meta-trained learning-signal generator manufactures `L_j^t` from a target it can see, so the real-time error the rule requires is produced by a second network rather than measured.
- **[[wiki/entities/spiking-neural-networks.md]]** — the deployment target that turns this page's cost model into that page's efficiency claim: a recurrent SNN's input and recurrent matrices held in PCM, adapted on-chip in one update, at a measured accuracy cost of ~4.5 cm of end-effector error.
- **[[wiki/concepts/test-time-training.md]]** — the same operation with the outer loop deleted and the write budget ignored: TTT fine-tunes the base model's own weights at deployment, which on this substrate would be the most expensive thing a system can do.
- **[[wiki/entities/btsp-cam.md]]** — the same argument for a *memory* rather than a classifier: a one-shot, two-state, local write rule is what crossbars can run on-chip, and this page prices why (device count, write energy, and the many distinguishable resistance states a many-valued store would need).
- **[[wiki/entities/hami.md]]** — the complementary use of the same devices: not a matrix that multiplies but a content-addressable array that matches a fixed-width key in one cycle, which is the "model-based L2L on a crossbar" row this page lists as undemonstrated.
- **[[wiki/concepts/complementary-learning-systems.md]]** — receives an independent, non-biological derivation of the slow/fast split: write cost, not interference, and with a different scaling prediction for the size of the fast store.
- **[[wiki/entities/sigma-pi-reservoir.md]]** — the other end of the same design pressure: there the chip's primitives (graded spikes, a product neuron) select the *representation*, here the chip's write cost selects the *learning rule*.
- **[[wiki/concepts/learnable-synaptic-delays.md]]** — the parameter that is nearly free on this substrate and expensive on a GPU: a per-neuron ring buffer versus a per-synapse convolution kernel, which is the same read-cheap/write-expensive accounting applied to a non-weight parameter.
- **[[wiki/concepts/continual-learning.md]]** — the deployment story this page assumes and does not test: one meta-trained model written to many chips, each adapting to its own task from the family, with nothing said about a chip that must then adapt again without forgetting the first task.
