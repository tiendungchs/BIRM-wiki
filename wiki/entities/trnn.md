# TRNN (Transient RNN)

**A vanilla recurrent network made incapable of persistent firing by three structural edits — per-neuron self-inhibition, sparse recurrence, and a sensory→association→motor block topology — so working memory has to be carried by a *moving* trajectory of sequentially peaking neurons instead of a held fixed point; the resulting network is both more like mouse recordings and better at every working-memory task tested, at equal parameter count.** Liu et al. 2025, *Communications Biology* 42003-024-07282-3.

The page exists because it is the wiki's only **controlled comparison of persistent against transient activity as maintenance designs** — same size, same parameter count, same training, same tasks, only the activity pattern differs.

---

## Model

| Component | Vanilla RNN (the attractor arm) | TRNN (the transient arm) |
|---|---|---|
| Hidden dynamics | `r_t = (1−α)r_{t−1} + α f(W_r r_{t−1} + W_in u_t + b_r + σ_r)` | same, minus `γV_t`: `r_t = (1−α_r)r_{t−1} + α_r(f(·) − γV_{t−1})` |
| Self-inhibition | none | `τ_v dV/dt = −V + m r` → `V_t = (1−α_v)V_{t−1} + α_v m r_{t−1}`, `α_v = 1/10`, `m = 2`, `γ = 2–10` by task |
| Recurrence | full | sparse: 0.9 connection ratio inside the sensory block, 1.0 inside association/motor, **0.8 across blocks** — still trainable after masking |
| Topology | one pool of 600 units | three blocks (sensory, association, motor) via an element-wise mask `W_m ⊙ W_r` |
| Units | 600, ReLU, excitatory:inhibitory initialised 4:1 (Gamma-distributed) | identical |
| Training | Adam, cross-entropy, activity regulariser `0.01·⟨r²⟩` | + L2 on `W_r` (factor 0.1) to keep sparsity |
| RL variant | 3 conv layers → RNN, asynchronous PPO | identical |

**The whole modification is one extra state variable per unit.** `V` is a low-pass copy of the unit's own recent activity, subtracted from its drive — spike-frequency adaptation written as a rate equation. A unit that has just fired loudly cannot keep firing, so whatever must survive the delay has to be handed to a *different* unit.

### The measurement: transient index (TI)

Because "persistent vs. transient" is a continuum, not a label, the paper defines a scalar and treats it as the independent variable. `TI` = sum of three normalised components:

| Component | What it measures | High when |
|---|---|---|
| Peak-firing-time entropy | Shannon entropy of the distribution of per-neuron firing-rate peak times | Peaks are spread across the delay, not synchronised |
| Ridge-to-background ratio | Sharpness of each neuron's peak | Firing is sharp, i.e. **not** persistent |
| Proportion of memory-related peaks | Fraction of neurons whose peak falls inside the delay | The tiling actually covers the delay |

Vanilla RNNs sit at low TI, mouse recordings at high TI, TRNNs at mouse-like TI. **Grouping is post-hoc and the boundary is not sharp** — the paper's own caveat: vanilla RNNs are *defined* as the attractor arm because they measured low, not because attractors were imposed.

---

## Results

Benchmark biology: Neuropixels across >30 mouse brain regions, 33,208 neurons, 113 sessions, olfactory delayed paired-association (ODPA, 1 s fixation / 1 s sample / 3–6 s delay / 1 s test).

| Claim | Number |
|---|---|
| Stimulus-selective units | TRNN **38.2%** vs. mouse **32.6%** |
| Selectivity is itself transient | Peak selectivity time tiles the delay in both TRNN and recordings |
| Region gradient reproduced | Proportion of selective neurons falls with the sensory-motor index (M1 output / olfactory-bulb input strength) in mouse; same trend across the TRNN's three blocks |
| Variable delay (3–6 s) tolerated | 92.19 ± 0.13% vs. 96.25 ± 0.26% for fixed delay — a cost, not a failure |
| Trajectory geometry (dPCA) | Sample odours split into two trajectories that keep **moving** through the delay; velocity does **not** decay toward the end — no fixed point is being approached |
| Information richness | Activity entropy rises ~linearly with TI across 100 size-matched networks |
| Energy | Mean squared firing rate falls stepwise with TI — transient maintenance is cheaper |
| Direction-following (PPO) | TRNN ≈ vanilla RNN ≫ feedforward |
| + 3 distractors | TRNN > vanilla RNN |
| Multi-item (2/4/6 directions in order) | TRNN > vanilla RNN, gap widening with item count; **primacy effect, no recency** (serial-recall design) |
| 9×9 grid water maze (spatial WM) | TRNN ≫ vanilla RNN ≈ feedforward — the vanilla arm barely beats a memoryless net |

Ablating the three edits separately: self-inhibition strength and sparsity both move TI **non-linearly**; hierarchical topology is close to necessary — without it TI stays low regardless of the other two.

---

## What this buys, and what it does not

- **A dynamic store is not a worse store.** The standing objection to transient trajectories — a moving code cannot survive an unknown delay length, because read-out has to know *when* — is met empirically: trained on mixed 3/6 s delays, peaks re-tile the whole window and accuracy drops ~4 points. Not a proof of generality, but the objection no longer stands unanswered.
- **Capacity, not just plausibility.** The multi-item and water-maze gaps are the load-bearing results: they are where "attractor networks struggle when items outnumber attractors" becomes a measured deficit at matched parameter count rather than a theoretical worry.
- **Entropy is the proposed currency.** Persistent activity pins many units to one value for the whole delay; transient activity spends those units on distinguishable states. The paper's information-richness measure is just the activity entropy already inside TI, so **the capacity argument and the transience measure are partly the same quantity** — a circularity the paper does not flag.
- **The negative control is weak.** In the water maze the vanilla RNN scores like a feedforward net, so it may simply have failed to learn the task rather than failed to remember; the paper says so.
- **Rate code only.** No spike timing, no spiking network — self-inhibition should transfer to SNNs, untested for lack of training methods.
- **(brainstorm)** The edit is one line and costs one extra state per unit, which makes it the cheapest architectural intervention in the wiki with a measured capacity payoff. The obvious machine experiment nobody has run: put `γV_t` on the recurrent state of a Transformer-free sequence model, or on the fast-weight store of a meta-learner, and see whether the entropy gain survives when the store is already externalised.

---

## Comparison to related designs

| | TRNN | [[wiki/entities/adaptive-cann.md]] | [[wiki/entities/stsp-working-memory-rnn.md]] | [[wiki/entities/rolls-treves-hippocampal-model.md]] |
|---|---|---|---|---|
| Where the memory lives | Moving pattern of activity | Bump position on a manifold | Synaptic `u·x` (activity-silent) | Which attractor in a chain is occupied |
| Destabiliser | `τ_v dV/dt = −V + mr`, `γ`-scaled | `τ_v dV/dt = −V + mU` — **the same equation** | none (activity decays on its own) | spike noise + adaptation |
| Where structure comes from | Trained `W_r` under a sparsity/block mask | Translation-invariant recurrence, hand-built | Trained `W`, memory not in `W` | Hebbian storage + asymmetric weights |
| Evidence | Trained on tasks, matched to mouse recordings | Analytic phase diagram | Trained + matched to macaque prefrontal | Analytic capacity `7±2` |
| Verdict on maintenance | Persistence is unnecessary and costly | Persistence is a regime, selected by `m` | Persistence in *spiking* is not what the brain does | Persistence in a chain gives order for free |

**The equation identity is the sharpest cross-page fact here.** A-CANN's mobility scalar `m` and the TRNN's self-inhibition are the same slow negative feedback; A-CANN derives that `m > τ/τ_v` turns a held bump into a travelling wave, and the TRNN is that regime *trained* — which is why the TRNN's trajectory velocity does not decay. The paper independently notes the known equivalence between this term and asymmetric connectivity in a CANN, and observes that both are present in its trained networks.

---

## Connections

- **[[wiki/concepts/working-memory.md]]** — supplies a fourth maintenance design to that page's list, and the wiki's only head-to-head performance comparison between maintenance designs at matched parameter count: transient wins on distractors, item count and spatial memory.
- **[[wiki/concepts/attractor-dynamics.md]]** — the counter-case: relaxation to a fixed point is here an *emergent default* of a trained recurrent net that three structural constraints remove, with the removal improving task performance — so persistence is a property of the architecture, not a requirement of the task.
- **[[wiki/entities/adaptive-cann.md]]** — same slow negative-feedback term (`τ_v dV/dt = −V + mU`) in a trained network instead of an analytic one: A-CANN proves the term converts a held state into a travelling wave above `m = τ/τ_v`, this page shows what that regime is good for when the weights are learned.
- **[[wiki/entities/stsp-working-memory-rnn.md]]** — the other challenger to persistent spiking, from the opposite direction: both reproduce the loss of a stable delay code, one by moving the code and one by hiding it in synapses, and neither needs a fixed point.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the discrete-attractor version of the same trajectory: adaptation there walks a chain of stored attractors and derives `7 ± 2`, here it walks a trained continuous trajectory and the item capacity is measured rather than derived.
- **[[wiki/entities/dense-sequence-memory.md]]** — the storage-side counterpart: this page's sequence is produced by destabilising the current state, that page's by an asymmetric term that releases it after `τ` steps, and both make the dwell timer a property of the dynamics rather than of a controller.
- **[[wiki/concepts/population-geometry.md]]** — the dPCA read-out is the method: separated, continually moving stimulus trajectories with non-decaying velocity is what distinguishes a dynamic code from a fixed point in population terms.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — sparsity here is imposed on the *connectivity* rather than on the code, and is one of the three knobs that raise the transient index, with a non-linear effect.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the hierarchy is load-bearing rather than decorative: sensory/association/motor blocks with sparser inter-block than intra-block connectivity are what makes the transient regime reachable at all, and they reproduce the recorded sensory-motor gradient of stimulus selectivity.
- **[[wiki/concepts/dynamic-network-connectivity.md]]** — supplies the reason this page's metabolic proxy `⟨r²⟩` matters biologically: recurrent prefrontal maintenance is expensive enough that dedicated signalling pathways exist to disconnect the network when energy is scarce — so `⟨r²⟩` is a control variable in biology and only a measurement here (Arnsten et al. 2010).
- **[[wiki/entities/spacetime-attractor.md]]** — the counter-case that keeps this page's result from generalising to all of prefrontal cortex: RNNs meta-trained on planning with reward that changes within the trial converge *onto* attractors rather than away from them, with discrete path switching under perturbation, which suggests the mechanism a trained network picks is set by the objective — hold an item versus satisfy constraints over a future trajectory ([[wiki/empirical-tensions.md]] T106).
