# Learnable Synaptic Delays

**Make the axonal transmission delay `d_ji` a trained parameter alongside the weight `w_ji`, optimised by an exact gradient on the same backward pass — so a network sets *when* a spike arrives rather than only *how much* it counts for.**

> **Provenance.** Mészáros, Knight & Nowotny 2025, *Efficient event-based delay learning in spiking neural networks*, Nature Communications 16, doi:10.1038/s41467-025-65394-8 (`raw/meszaros-2025-snn-delay-learning.md`). Extends the EventProp adjoint formalism (Wunderlich & Pehle 2021) to delays; implemented in mlGeNN 2.3.0 / GeNN 5.1.0.

This page closes the mechanism half of [[wiki/architectural-gaps.md]] `G80`. Until now the wiki held a theorem saying a delay is the most expressive parameter per unit count ([[wiki/concepts/circuit-size-separation.md]]: VC dimension `Θ(n log n)` against a weight's `Θ(n)`) and exactly one rule that could reach delays at all — Hebbian *selection* from a random bank ([[wiki/concepts/temporal-coding.md]]), which cannot produce a value the bank does not already contain. Here delays are **set**, by task error, in feedforward *and* recurrent connections, with multiple spikes per neuron.

---

## The gradient, and why it is free

Forward pass: leaky integrate-and-fire neurons with exponential current-based synapses. The only change from EventProp is that a spike emitted by neuron `n` at `t_k` jumps `I_m` at `t_k + d_mn` instead of at `t_k`.

The derivation splits the loss integral not at spike *times* but at the enlarged set of **event** times — emissions and arrivals both:

```
ℰ ≡ 𝒮 ∪ { t_k^spike + d_{m,n(k)}  |  k = 1..N_spike ,  m = 1..N }
```

Adjoint dynamics, run backwards in time, are **unchanged from the no-delay case**:

```
τ_m λ̇_V = −λ_V − ∂l_V/∂V
τ_s λ̇_I = −λ_I + λ_V
```

and the two gradients are read off the *same* adjoint trajectories, sampled at arrival time:

```
dL/dw_ji = −τ_s   Σ_{ t_k : n(k)=i }  λ_{I,j} |_{ t_k + d_ji }
dL/dd_ji = −w_ji  Σ_{ t_k : n(k)=i }  (λ_{I,j} − λ_{V,j}) |_{ t_k + d_ji }
```

| Consequence | Statement |
|---|---|
| **Delay learning costs one extra read** | Same backward ODEs, same event schedule; the delay gradient is a second sample of adjoint variables already being computed. There is no separate delay pass, no surrogate, no smoothing |
| **The backward pass is computable because delays are non-negative** | Running backwards, the postsynaptic adjoints at `t + d_ji` are always already resolved when neuron `i`'s adjoint at `t` is needed — causality holds in reverse time. A *negative* delay would break the schedule, which is why the parameter is one-sided and bounded below by construction |
| **The weight gradient also changed** | It is the original EventProp sum with `λ_I` evaluated at `t_k + d_ji` rather than `t_k`. Delays are not an add-on to a fixed weight rule; they move where the weight's blame is read |
| **`dL/dd ∝ w`** | A zero or near-zero synapse has no delay gradient. Delay learning is gated by the weight, so a pruned connection is frozen in time as well as silent — and the two parameters cannot be decoupled **(brainstorm)** |
| **Memory is per-neuron, not per-synapse** | Increasing the delay range enlarges a **per-neuron ring buffer**. Convolution-based delay learning (dilated kernels) enlarges a **per-synapse kernel**, so its cost grows with fan-in × range |

**The loss is not constrained to be a spike-train metric.** EventProp admits `L = l_p(𝒮) + ∫ l_V(V,t) dt` — any spike-time-dependent and/or voltage-dependent term. This is what lets the same machinery train a first-spike-latency objective (Yin-Yang) and a max-voltage classification objective (SHD/SSC/Braille) with no change of algorithm, and it is why this source moves [[wiki/architectural-gaps.md]] `G76` sideways rather than solving it: it supplies **deep credit assignment** in the timing domain without supplying a spike-train distance.

---

## The existence proof: two neurons, no weights

Two LIF inputs → two leaky-integrator outputs, **every weight fixed at 1**, only the 2×2 delay matrix trainable. Class 1 = input 1 spikes at 0 ms and input 2 at 10 ms; class 2 = the reverse. Read the class off whichever output reaches the higher `V_max`.

| | |
|---|---|
| Optimal delays | 10 on the diagonal, 0 elsewhere |
| **Initialisation** | The exact worst case — 0 on the diagonal, 10 elsewhere |
| Result | **100% accuracy after seeing each example 6 times** (learning rate 1) |

This is the smallest statement of what the mechanism buys: a coincidence detector becomes a **sequence detector**. Coincidence is order-blind by construction (`CD_n` on [[wiki/concepts/circuit-size-separation.md]] asks only whether two patterns overlap); adding a trained delay makes "A then B" separable from "B then A" in a two-unit circuit with no weights to speak of. Order is the cheapest relational primitive there is, and this is the wiki's cheapest device for detecting it.

---

## Benchmarks, and the size effect

All comparisons use held-out validation and early stopping — deliberately, because most published SHD numbers do not (see the methodology note below).

| Data set | Best configuration | Result | Comparison |
|---|---|---|---|
| **Yin-Yang** | Feedforward, hidden 5–30, delays init 0, range 0–10, single spike per neuron, time-invariant MSE on first output spike times | Matches DelGrad, as expected from gradient equivalence | Halving the hidden layer costs nothing **if delays are trained**; with parameter count unconstrained, weights + delays always beats weights alone |
| **SHD** (Spiking Heidelberg Digits) | 512 hidden, **recurrent**; feedforward delays `U(0, 150 ms)`, recurrent delays init 0; target 14 spikes/example, regularisation strength by 10-fold leave-one-speaker-out cross-validation | Train 98.47 ± 0.4%, **test 93.24 ± 1.0%** | Statistically indistinguishable from the delay-line state of the art (93.5 ± 0.7%, `p = 0.442`, `n = 8`) at **~5× fewer parameters**. 256 hidden loses nothing; at 128 the feedforward net degrades and the recurrent one does not; 1024 overfits |
| **SSC** (Spiking Speech Commands) | **2 feedforward** hidden layers with delays | Train 79.6 ± 1.0%, val 78.1 ± 1.0%, **test 76.1 ± 1.0%** | Beats Sadovsky et al. (72.03%) and Deckers et al.'s LIF variant (75.94%); below their constrained-adaptive-LIF variant (80.23%). Deeper *recurrent* nets were unstable even without delays |
| **Braille letter reading** | 2 feedforward hidden layers, 1024 each | **83.1 ± 1.5%** | Beats the original recurrent 450-unit, 8-input-copy model (80.9 ± 0.3%); a 256-unit version reaches 81.0 ± 0.7% at **half the parameters** |
| **Training cost** vs. dilated-convolution delay learning (SpikingJelly/PyTorch), matched 2-hidden-layer feedforward | — | **<½ the memory, up to 26× faster**, and nearly flat in the maximum delay | The per-neuron-buffer vs. per-synapse-kernel distinction, cashed. The residual slope is L2 cache eviction on the delay buffers, not algorithmic |

**The size effect is the result to carry, and it points the wrong way for the theory.** Delays gave *no* benefit to large recurrent networks on SSC and Braille and became "highly beneficial" only as the hidden layer shrank; recurrent delays specifically are what let the 128-unit SHD network hold its accuracy. So the measured value of a delay is not "more expressive per parameter, always" — it is **a substitute for units under a size constraint**. Logged as [[wiki/empirical-tensions.md]] T237.

---

## What the learned delays look like

- **Most stay short; a few grow long.** From uniform initialisation, the trained distribution is heavy-tailed rather than uniform. The authors' reading: this resembles a small-world structure — most connections local, a few long-range. The wiki should treat that as suggestive, not measured: no path-length or clustering statistic is reported **(tentative)**.
- **Feedforward initialisation has a symmetry that recurrent initialisation does not.** Initialising feedforward delays in `[0, d_max]` is arbitrary only up to a global shift — adding `x` to every delay in a layer gives the same computation on `[x, d_max + x]`. That argument fails for recurrent connections, where a delay enters a loop, so recurrent delay initialisation has no principled default and was set to 0 throughout.
- **Delays are discretised to integer multiples of the simulation timestep.** EventProp's favourable scaling is what permits a fine grid at all; the competing state-of-the-art models use 10 or 25 ms steps, which may be simplifying their tasks by shortening the effective sequence rather than merely saving memory. The authors' own prior work suggests these speech tasks do **not** require precise delays — so the mechanism's headline benchmarks are the ones least able to demonstrate what it is for.

---

## Where this sits among the wiki's temporal parameters

| Parameter | What it sets | How it is set | Needs a time origin? |
|---|---|---|---|
| Membrane / synaptic `τ` | How long a unit integrates | Grid search (everywhere), or learned per-neuron in a bi-level program ([[wiki/concepts/neuronal-parameter-heterogeneity.md]]) | No |
| Adaptation `τ_a` | Memory span of the threshold trace ([[wiki/concepts/spike-frequency-adaptation.md]]) | Grid search — [[wiki/architectural-gaps.md]] `G78` | No |
| Error-filter `τ_q` | Finest learnable output latency ([[wiki/concepts/spike-train-error-metrics.md]]) | Grid search — `G78` again | No |
| Delay bank mean/spread | Which offsets are *reachable* ([[wiki/concepts/temporal-coding.md]]) | Design time; selection prunes but cannot extend | No |
| **Delay `d_ji`** | **When a specific spike arrives at a specific target** | **Exact gradient on the task loss** | **No — a delay is relative by construction** |

Two things follow. First, this is the wiki's first temporal parameter *set by task error rather than by sweep*, so it is `G78`'s counter-example as well as `G80`'s answer — though `d_max` and the timestep grid are new sweep parameters standing behind it. Second, it is the one high-expressiveness timing mechanism that does **not** inherit `G77`'s missing-clock objection: unlike time-to-first-spike or phase, an arrival offset is measured from the presynaptic spike, and the presynaptic spike is in the network.

**Deliberately not combined with heterogeneous time constants.** The authors kept `τ_m`, `τ_s` homogeneous and fixed "so that the independent effect of delays would be clear". The composition with [[wiki/concepts/neuronal-parameter-heterogeneity.md]]'s bi-level learned `α^k` is therefore untried, and it is the obvious next experiment: `τ` sets how long evidence persists, `d` sets when it shows up, and nothing says the two are substitutes rather than complements **(brainstorm)**.

---

## Why this matters for a reasoning model

- **A delay is a stored temporal *relation* between two named units.** Weight matrices store "how much A bears on B"; a delay matrix stores "how far apart in time A and B belong". For [[wiki/concepts/latent-graph-discovery.md]] that is an edge attribute the wiki otherwise has no substrate for — a discovered graph whose edges carry *lags* is exactly what a partially observed dynamical environment looks like, and no rate architecture here can hold one without an explicit lag embedding.
- **Order detection without a sequence model.** The 2×2 existence proof detects "A before B" with two neurons, unit weights, and 6 training examples. Every wiki architecture that distinguishes order does it with recurrence, positional encodings or an explicit sequence axis; here it is a wiring property, learned.
- **It gives the accuracy-per-parameter axis a mechanism.** [[wiki/concepts/circuit-size-separation.md]] argues that unit count, not accuracy, is what the spiking substrate wins on, and complains that no benchmark reports units-to-competence. This source does: equal SHD accuracy at ~5× fewer parameters, and Braille accuracy above the prior model at half. It is the first entry in the wiki that trades parameters for time and reports the exchange rate.
- **The training cost argument is about deployment, not GPUs.** Because the method is event-based and needs only a per-neuron buffer, it is implementable on hardware that already supports per-synapse delays (SpiNNaker, Loihi) — and EventProp itself has already been run on SpiNNaker 2. Every competing delay-learning method is dense backpropagation through time with surrogate gradients, i.e. GPU-only. The gap between *what neuromorphic chips can execute* and *what delay-learning research uses* is what this closes.

---

## Open problems

- **`d_max` is a hyperparameter, and a load-bearing one.** The buffer bounds the representable lag; a task whose structure exceeds it is unreachable, and nothing estimates the required range from data. `G78`'s defect, relocated.
- **Recurrent delay initialisation has no principle.** The feedforward shift-symmetry argument does not extend to loops; all recurrent delays were initialised to 0, and the paper names this as open.
- **Offline, non-local, exact.** EventProp stores spike times for the backward pass and runs the adjoint system in reverse. It is event-*based*, not online or local — so this does not touch [[wiki/concepts/biologically-plausible-credit-assignment.md]]'s requirements, and the biological delay-tuning story remains Hebbian selection.
- **No task in the evaluation needs the mechanism.** The authors say so themselves: the speech benchmarks may not require precise delays, and SHD is saturating near 93% with overlapping Bayesian confidence intervals for 93/94/95% at `n = 2264` test items. The sequence-detection toy is the only task where delays are provably necessary, and it has two neurons. Sound localisation and motion detection are named as the missing evaluations.
- **The delay gradient vanishes with the weight.** `dL/dd ∝ w` means a synapse must already matter before its timing can be tuned, which makes the initialisation of `w` a prior over which lags are learnable at all. Unexamined.
- **Nothing composes delays with anything.** No experiment combines learned delays with learned time constants, with adaptation, or with a spike-train loss — each of which is a separate page in this wiki, and all four are edits to the same unit.

---

## Methodological note the wiki should adopt

The paper refuses the field's standard comparison and gives a reason: leading SHD/SSC numbers use the **test set** for validation and early stopping, and the practice is defended in print as being fair-by-convention. Two objections are raised — it is not clean, and it is not even fair, because the overfitting it permits is not equally available to all methods. Third: with `n = 2264` SHD test items, Bayesian confidence intervals on 93%, 94% and 95% overlap, so the top of that leaderboard is **not ordered by the evidence**. The authors report their own highest observed test accuracy (95.32%) alongside the properly validated 93.24% to make the size of the effect explicit.

This is the same defect [[wiki/concepts/benchmark-contamination.md]] and [[wiki/concepts/human-baseline.md]] track in the reasoning-benchmark literature, arriving independently in the neuromorphic literature: **a score is a protocol, and a leaderboard whose spread is inside its own confidence interval ranks nothing.**

---

## Connections

- **[[wiki/concepts/temporal-coding.md]]** — the page whose central limitation this removes: its only delay-learning rule (Gerstner et al. 1996) *selects* a coherent subset of a fixed random bank, driven by input coherence and unable to reach a value the bank does not contain, so the bank's mean and spread stayed design-time hyperparameters. Here the delay is set by task error, in recurrent as well as feedforward connections — and its design rule "over-provision delay lines and let a local rule kill the incoherent ones" is now the *biological* option rather than the only one.
- **[[wiki/concepts/circuit-size-separation.md]]** — supplies the reason to want this parameter (`n` delays carry VC dimension `Θ(n log n)` against `n` weights' `Θ(n)`; the `CD_n` construction uses delays alone with every weight fixed at 1) and receives the optimiser its closing complaint says does not exist — every construction there is hand-built. The measured size effect also qualifies the theorem's practical reading ([[wiki/empirical-tensions.md]] T237).
- **[[wiki/entities/spiking-neural-networks.md]]** — the substrate, and the routes table this belongs in as a sixth entry: not conversion, not surrogate-gradient BPTT, but an **exact** gradient computed event-based, whose memory does not scale with sequence length and which trains multi-layer and recurrent networks on parameters other than weights.
- **[[wiki/concepts/spike-train-error-metrics.md]]** — the complement and the contrast: that page derives *what the error between two spike trains is* and every rule in its inventory trains one postsynaptic neuron; this page supplies the deep, multi-spike, recurrent credit assignment that inventory lacks — but takes its loss to be a first-spike-latency or max-voltage objective rather than a train distance, so the two halves of `G76` have still not been assembled into one system.
- **[[wiki/concepts/neuronal-parameter-heterogeneity.md]]** — the sibling mechanism on the other temporal parameter: that page learns per-neuron `τ`, `C`, `v_th` in a bi-level program on a held-out split; this one learns per-**synapse** arrival offsets in the ordinary task loop. The two were deliberately kept apart here (time constants held fixed to isolate the delay effect), so their composition is untested.
- **[[wiki/concepts/spike-frequency-adaptation.md]]** — the timing variable that is still swept, next to the one that is now trained: `G78` names the defect (a time constant fixed at design time that the task varies at run time), and a trained delay is the first clean counter-example in the wiki — while `d_max` and the timestep grid reintroduce the same defect one level out.
- **[[wiki/concepts/latent-graph-discovery.md]]** — what the parameter is *for*, beyond accuracy: a delay matrix is a set of learned pairwise lags, i.e. an edge attribute that no weight matrix can carry, and the two-neuron sequence detector is the cheapest device in the wiki for the directed "A then B" relation a discovered graph is made of.
- **[[wiki/concepts/biologically-plausible-credit-assignment.md]]** — the boundary this does not cross: exact gradients via an adjoint system run backwards in time, with saved spike times, is offline and non-local. What it does buy that surrogate-gradient BPTT does not is a backward pass whose synaptic work is **event-based** and whose memory does not scale with sequence length, which is why it has already been run on neuromorphic hardware.
- **[[wiki/concepts/spike-encoding-schemes.md]]** — the one place `G77`'s missing time origin does not bite: every high-performing code there measures latency against stimulus onset, an oscillation or a clock, whereas a synaptic delay is measured from the presynaptic spike — a quantity the network generates itself.
- **[[wiki/entities/liquid-state-machine.md]]** — the alternative use of the same physics: a reservoir gets its temporal richness from *untrained* heterogeneous dynamics and puts all task content in a readout, whereas here the temporal structure itself is what the gradient adjusts — and the size effect suggests the two are substitutes, since delays helped precisely where units were scarce.
- **[[wiki/concepts/benchmark-contamination.md]]** — the same protocol defect found independently in the neuromorphic literature: SHD/SSC leaderboards select on the test set, and the top of the SHD table sits inside its own Bayesian confidence interval at `n = 2264`.
- **[[wiki/concepts/analog-in-memory-computing.md]]** — the accounting that explains this page's deployment win: a per-neuron ring buffer versus a per-synapse convolution kernel is the same read-cheap/write-expensive trade an in-memory substrate imposes on weights, applied to a non-weight parameter.
- **[[wiki/concepts/mean-field-reduction.md]]** — the same parameter one scale up, where it decides stability rather than expressivity: in a neural field with heterogeneous long-range fibres, the resting state's *oscillatory* instability is delay-driven and raising extrinsic transmission speed (myelination, `c/c_hom`) always enlarges the stable region, while the *non-oscillatory* route ignores delay entirely and depends only on coupling strength — two independently correctable failure modes for a modular network (Deco et al. 2008).
- **[[wiki/concepts/dynamic-repertoire.md]]** — the macroscopic argument that a delay matrix is worth learning: setting `τ_ij = 0` in a whole-brain model with everything else held fixed destroys the ultraslow oscillations and the inter-network anticorrelation outright, so delays carry network-level dynamical content that no weight matrix can substitute for (Deco, Jirsa & McIntosh 2011).
- **[[wiki/concepts/metastability.md]]** — the first numeric working range for this parameter at network scale: transient coalition formation on a human connectome requires conduction delays of **8–15 ms** at velocities of **5–20 m/s**, with default-mode correlations emerging at 5–10 m/s — so a delay has a two-sided optimum, not merely a destabilising sign (Cabral, Kringelbach & Deco 2014).
- **[[wiki/entities/virtual-brain-twin.md]]** — the only application in the wiki where a delay is the *inferred* quantity rather than a swept or trained one: conduction velocity estimated from MEG spectral features is lower in multiple-sclerosis patients and predicts clinical disability beyond lesion load, and a single scalar mapping lesion intensity to per-edge delay makes the whole delay matrix estimable from one parameter.
- **[[wiki/concepts/cortical-traveling-waves.md]]** — the dynamics-side argument for the same parameter: zeroing conduction delays on an intact connectome leaves waves present 24% of the time but destroys their direction entirely, so an instantaneous-propagation architecture forfeits gradient-directed flow by construction — while a *constant* 23 ms lag recovers 95% of it, meaning the cheap version of the parameter is enough (Koller et al. 2024).
- **[[wiki/concepts/small-world-topology.md]]** — what the "resembles a small-world structure" reading would need to become a measurement: clustering coefficient, average path length, and a degree-matched null at a stated threshold density, none of which the trained delay distribution alone supplies.
- **[[wiki/concepts/structured-flows-on-manifolds.md]]** — the spatial half of the same symmetry breaking: that page breaks symmetry by placing long-range edges, this one by setting how long each edge takes, and the delay structure spans a "resonance body" giving the network frequency-specific preferences — so a flow on a manifold and a delay distribution are two separable levers on the same shaped dynamics.
