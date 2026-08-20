# STSP Working-Memory RNNs

**Recurrent networks trained on a distracted delayed-match-to-sample task with and without short-term synaptic plasticity (STSP), scored against monkey lateral prefrontal recordings from the same task — the wiki's one controlled comparison of activity-based against synaptic working-memory maintenance, on brain-similarity and on two kinds of robustness separately** (Kozachkov et al. 2022, `raw/kozachkov-2022-short-term-plasticity-working-memory.md`).

The result that matters for a builder is a **dissociation**: fixed-synapse networks solve the task with persistent attractors and are not brain-like; STSP networks solve it with near-silent delays and are; and LSTM/GRU are the most robust of all and the least brain-like. Robustness and brain-similarity are therefore independent axes, and STSP buys one particular robustness — to *structural* damage — not robustness in general.

---

## The comparison

| Model | Maintenance mechanism | Constraint needed to train it |
|---|---|---|
| **FS-tanh** | Fixed weights, `tanh`; point attractors | none |
| **FS-relu** | Fixed weights, ReLU; line attractors | none |
| **PS-pre** | Mongillo-style presynaptic STSP (Tsodyks–Markram `u`, `a`), trained as in Masse et al. | Excitatory/inhibitory populations kept separate by `W = [W̃]⁺D`; `u, a` clamped to `[0,1]` |
| **PS-hebb** | Excitatory **anti-Hebbian** / inhibitory Hebbian plastic weights, `Ẇ = −γW + K ∘ (…)` with `K` positive and positive-definite | `K = BᵀB ∘ O + I` parameterization, which makes the network **provably stable** (contracting) throughout training |
| **LSTM / GRU** | Learned gates | none; biologically implausible by construction, included to dissociate robustness from brain-similarity |

`τ = 100 ms`, Euler `dt = 15 ms`, process noise `σ_rec = 0.05`, backpropagation through time (Adam), ~2000 models over a 10 × 10 × 3 sweep of hidden size (100–1000), activity regularization (1e-3 → 1e2) and weight decay. Task: 8 samples, 500 ms presentation, delay ∈ {1, 1.41, 2, 2.83, 4} s, a neutral distractor mid-delay on 50% of trials.

**Ground truth:** 256 electrodes bilaterally in dorsolateral and ventrolateral prefrontal cortex of one macaque performing the same task at ~99% accuracy; multi-unit activity smoothed with a 10 ms Gaussian kernel, decoded with a linear support vector machine in 50 ms bins.

---

## Results

| Measurement | Prefrontal cortex | FS-tanh / FS-relu | PS-pre / PS-hebb |
|---|---|---|---|
| Sample decoding from **spike rates** across the delay | Falls steadily to chance after ~1 s | Stays high for the whole delay | Falls, matching the brain |
| Sample decoding from **synaptic weights** | not measurable | no such variable | **Stays high across the full 4 s delay** |
| Recovery from mid-delay distractor (neural) | Trajectories diverge, reconverge with `τ ≈ 200 ms` | Same (attractor recapture) | Same |
| Recovery from distractor (synaptic) | — | — | Decays *slower* than the synaptic time constants — neurons and synapses interact to raise the effective time constant — **without** costing task accuracy (>90% on distractor trials) |
| Brain-similarity (Pearson `r` between decoder-accuracy curves) | — | lower, across every hyperparameter setting | **PS-hebb highest**; for PS-pre, more activity regularization → more brain-like |
| Robustness to **synaptic ablation** | — | degrades at 10–20% ablated | **>50% of synapses ablated, performance still high** |
| Robustness to **process noise** | — | *better* than STSP | worse |
| LSTM / GRU | — | — | most robust on both noise types, least brain-like of the six |

A control matters for the first row: subsampling RNN units at 0.01 / 1 / 10 / 100% does not change the conclusion, so the brain's decoding collapse is not an artefact of recording a fraction of the population. A second control rules out the trivial explanation: a classifier trained to separate pre- from post-sample activity **succeeds** throughout the delay, so prefrontal activity has not simply returned to baseline — it has returned to a state that no longer carries *which* sample.

---

## What this establishes

| Claim | Consequence for an architecture |
|---|---|
| **A store can be read only by probing it** | The synaptic trace is invisible to any read-out until spikes recruit the facilitated population. Spiking is sparse while a memory is *maintained* and rises when it is *used* (Masse et al.; Lundqvist et al. 2018 measure the ping directly — gamma bursts and object information ramp up in the delay before the item is compared to a test stimulus, for that item only, and not before an equally predictable event that requires no read) — so "ping the store" is a distinct operation from "hold the store", and only the ping is metabolically expensive |
| **Structural robustness and process robustness are different quantities, and STSP trades one for the other** | Halving the synapses of a fixed-synapse RNN destroys it because its attractor landscape is *fine-tuned*; the STSP network's memory does not live in the trained weights, so ablation cannot delete it. The paper's inference: biology optimizes for structural robustness, consistent with ~40% dendritic-synapse turnover every five days |
| **Brain-similarity ⊥ robustness** | LSTM/GRU dominate both robustness measures and lose on brain-similarity. A biologically-motivated mechanism is therefore *not* justified by a robustness argument alone, and the wiki should stop treating the two as one endorsement **(brainstorm)** |
| **The plastic rule has to be anti-Hebbian to be trainable** | Purely Hebbian STSP was difficult to train (positive feedback, as [[wiki/concepts/synaptic-plasticity.md]] rule 1 predicts); the excitatory-anti-Hebbian/inhibitory-Hebbian form trained without any weight clipping, because the same term that stores is the term that contracts. Stability was *parameterized in*, not obtained by tuning |
| **Stability is a modularity precondition** | Contracting modules can be composed with other contracting modules and the composite is still stable, so a new module can be added without retraining the whole network. This is the paper's own reading of why STSP matters beyond working memory, and it is the wiki's only mechanical argument for why a control layer should be built from provably stable parts |

**(brainstorm)** The cleanest way to read the dissociation: a fixed-synapse network stores the memory *in the same object it computes with*, so damage to the computation is damage to the memory. STSP separates them — the trained `W` is the computation, `u·a` (or the plastic `W` increment) is the memory — which is [[wiki/concepts/working-memory.md]]'s control/storage separation obtained without an external memory matrix, an addressing scheme, or a controller. It is the cheapest version of that separation in the wiki, and it pays for it by having no write policy at all: what enters the store is whatever fired.

---

## Limitations

- **One animal, one task family.** The paper concedes replication is needed. It also names the confound that decides the general claim: **spatial delayed-response tasks report much more delay spiking than delayed-match-to-sample**, plausibly because the former requires withholding a *known* motor response rather than holding information for later computation ([[wiki/empirical-tensions.md]] T86). **And the residual delay signal may not be about the sample at all**: with attention dissociated from memory inside a trial, 61% of spatially tuned dorsolateral prefrontal cells track the attended location and 16% the remembered one, so "sample decoding falls to chance while the activity has not returned to baseline" has a second reading — what the population is coding after 1 s is where the animal is looking for the probe (Lebedev et al. 2004, [[wiki/empirical-tensions.md]] T88).
- **Brain-similarity is a correlation between decoder-accuracy curves** — a one-dimensional summary of the population. Two networks with identical decodability time-courses and different geometry score identically.
- **PS-hebb could not be scaled**: parameter count is quadratic in neurons because every synapse is a state variable, so its sweep ran at 10–100 units against 100–1000 for the others. The brain-similarity comparison is therefore not size-matched.
- **The store is reset at every trial**, so nothing here tests interference between successive instance-graphs, or capacity beyond one item.
- **The distractor is neutral by construction** (drawn from two objects never used as samples). Robustness to a distractor that is a *valid* sample — the case where a store must refuse a write — is untested.

---

## Connections

- **[[wiki/concepts/working-memory.md]]** — supplies the controlled test of that page's activity-silent design against its activity-based ones, on the same task with the same training: the synaptic store matches prefrontal decoding while the attractor store does not, and reading the synaptic store requires spikes, which makes "maintain" and "use" separate metabolic regimes.
- **[[wiki/concepts/synaptic-plasticity.md]]** — the short-term-plasticity row trained end-to-end rather than hand-set: the anti-Hebbian form is the one that trains, because its stabilization is a parameterization rather than a patch, and the resulting network survives ablation of half its synapses.
- **[[wiki/concepts/attractor-dynamics.md]]** — the negative result for the page's default: fixed-synapse RNNs solve the task with point (tanh) or line (ReLU) attractors and are *less* brain-like than a network with no persistent delay activity at all, and their fine-tuned landscape is exactly what makes them fragile to synapse loss.
- **[[wiki/entities/stp-flickering-cann.md]]** — the same mechanism as a hand-built hippocampal model rather than a trained one; that page shows a `τ_f > τ_r` rebound is *sufficient* to hold an abandoned attractor, this page shows a trained network chooses that solution and is thereby more brain-like than the alternative.
- **[[wiki/entities/pbwm.md]]** — the opposite pole on write policy: PBWM learns *when* to write by reinforcement and holds by bistability; this page writes automatically at every spike and holds by decay constants, and gets prefrontal-like delay activity that PBWM's persistent stripes would not.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the engineered version of the same separation: an explicit memory matrix with learned addressing, against a store that is implicit in the synapses with no addressing at all; the DNC can traverse a graph, this network can only hold one item.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the trainability result runs through the inhibitory population: stability comes from making excitatory plasticity anti-Hebbian *and* inhibitory plasticity Hebbian, so the sign of the plastic term is assigned by cell class rather than by the learning problem.
- **[[wiki/entities/spiking-neural-networks.md]]** — the energy argument this page leaves as a conjecture: STSP's advantage over LSTM/GRU is not robustness, so the remaining candidates are metabolic cost and structural robustness, both of which are substrate-level properties.
- **[[wiki/entities/trnn.md]]** — the other route to a prefrontal-like delay code without a fixed point: instead of hiding the item in synapses, it keeps the item in activity but keeps the activity moving — same verdict against persistent spiking, opposite carrier, and unlike this page it also reports a task-performance advantage (Liu et al. 2025).
