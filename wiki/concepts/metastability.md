# Metastability — The Working Point Where Subsets Synchronise and the Whole Never Does

**Metastability is the regime in which coupled oscillators repeatedly form and dissolve partial coalitions: global coherence `R(t)` is never 0 and never 1, and the quantity that matters is not its mean but its *variance over time*, `σ_R`. It is a single scalar that can be measured on any modular system, it has an interior optimum, and — the load-bearing result — six whole-brain models built on incompatible node dynamics all reproduce empirical resting functional connectivity **only** when tuned to the edge of a bifurcation, which makes "sit near an instability" a design rule that survives the choice of substrate.**

> **Provenance.** Cabral, Kringelbach & Deco 2014, *Exploring the network dynamics underlying brain activity during rest*, Progress in Neurobiology 114:102–131, doi:10.1016/j.pneurobio.2013.12.005 (`raw/cabral-2013-resting-state-network-dynamics.md`). A review whose payload is a six-model comparison table on one axis — *where does the slow BOLD fluctuation come from?* — plus the measurement chain from simulated firing rates to the fMRI observable. Extends the three-model table on [[wiki/concepts/dynamic-repertoire.md]] (which supplies the manifold framing) with three further reduction lines; the node models themselves are rungs of [[wiki/concepts/mean-field-reduction.md]].

---

## The measure

Kuramoto phase oscillators on a structural connectome with distance-derived delays:

```
dθ_n/dt = ω_n + k Σ_p C_np sin( θ_p(t − τ_np) − θ_n(t) ),     τ_np = L_np / v
R(t) e^{iΦ(t)} = (1/N) Σ_n e^{i θ_n(t)}
```

| Quantity | Meaning | Regime it identifies |
|---|---|---|
| `R(t)` | instantaneous phase uniformity, 0 (incoherent) → 1 (globally locked) | `R ≈ 0`: independent modules · `R ≈ 1`: one global state, repertoire of size 1 |
| **`σ_R` = std(`R(t)`)** | **degree of metastability** | maximal in between — the system keeps assembling and dissolving coalitions |
| `k` | global coupling gain (scales all weights, leaves topology intact) | the one knob swept in every model here |
| `v` | conduction velocity, sets all delays | 5–20 m/s gives instability; DMN correlations emerge at **5–10 m/s**, delays **8–15 ms** |

`σ_R` is what the wiki has been missing: **an operating-point statistic computable from module activity alone, with no access to weights, no task, and no labels.** Mean coherence says which of the two useless extremes you are near; its variance says whether you are at the useful point between them.

**Metastability ≠ multistability.** Multistability is a property of the *landscape* (how many attractors exist, [[wiki/concepts/attractor-dynamics.md]]); metastability is a property of the *trajectory* (how much the coalition structure churns). The table below shows both can produce the same fMRI observable.

---

## Six models, one conclusion

All six couple region-level dynamical units on a diffusion- or tracer-derived connectome, pass the simulated activity through the same haemodynamic filter, and correlate the result against empirical resting functional connectivity. They disagree about everything except where the optimum sits.

| Node model | Local regime | Where the slow (<0.1 Hz) fluctuation comes from | Delays | Noise |
|---|---|---|---|---|
| Conductance-based mass (Honey et al.) | **chaotic** attractor | sporadic self-organising synchronised patterns emerging from chaos | no | no |
| FitzHugh–Nagumo (Ghosh et al.) | damped oscillator (~10 Hz) | network reverberation; slowest modes dominate the variance | **yes** | **yes** |
| Wilson–Cowan (Deco et al. 2009) | limit cycle, ~40 Hz once coupled | two structural modules **alternately** synchronise (a chimaera state) | **yes** | **yes** |
| Kuramoto phase oscillator (Cabral et al. 2011) | limit cycle, 40–60 Hz | **metastable** synchronisation of structural modules; `σ_R` is the signal | **yes** | no (instability is intrinsic) |
| Spiking attractor network (Deco & Jirsa) | asynchronous, near multistability | noise excursions into latent **ghost attractors** | no | **yes** |
| Linearised rate fluctuations (Deco et al.) | stable asynchronous fixed point | noise reverberated through the structural network, slowed by it | no | **yes** |

**Three mutually exclusive mechanisms for the same 0.1 Hz signal** — a *coalition-identity* code (rows 3, 4: which modules are locked switches slowly), an *amplitude* code (row 2: a 10 Hz carrier whose envelope is the signal), and a *rate-deviation* code with no oscillation at all (rows 5, 6). Delays are essential in three models and absent from three. Noise is essential in four and absent from two.

**The invariant.** *"The optimal fit with the empirical data is always found for a working point where the system operates at the edge of an instability, i.e. at the critical point of a bifurcation."* Every model, whatever it put at the node. This upgrades criticality from one model's tuning detail to the only property the six share, and it is the reason a builder can adopt it without first adopting a node model.

**Where "the edge" is, concretely** (spiking-attractor row). Sweep global coupling `W` and count attractors by iterating the mean-field equations from 1000 random initial conditions:

| `W` | Attractors | Entropy `H = −Σ p(i) log p(i)` | State |
|---|---|---|---|
| low | 1 | 0 | trivial low-firing state; nothing happens |
| **intermediate** | **many** (distinct high-firing foci) | **raised** | multistable |
| high | 1 | 0 | "epileptiform" — all excitatory populations saturated |

The best fit is **not** inside the multistable band. It is at its lower border: the system sits in the stable low-firing state, and the coexisting attractors are *latent*, deflecting the noise-driven trajectory without ever capturing it. Those are the **ghost attractors** — a repertoire that is present in the connectivity, costs nothing to maintain, and can be stabilised on demand by a task input.

---

## The measurement chain, and what it destroys

Every model above is scored on simulated BOLD, obtained by pushing the simulated rate `r_n(t)` through the Balloon–Windkessel haemodynamic model. The review runs the control nobody else does — compare that output against the *low-pass filtered rate*:

| Comparison | Result |
|---|---|
| Balloon–Windkessel output vs. rate low-passed at **0.35 Hz** | `r = 0.9`, lag **1.6 s** (= the haemodynamic time-to-peak) |
| Consequence | The haemodynamic nonlinearities contribute almost nothing; **the fMRI observable is a low-pass filter with a delay** |

**This is an identifiability bound, not a technical footnote.** If the observable is a 0.35 Hz low-pass of population rate, then any two mechanisms that differ only above 0.35 Hz are indistinguishable in fMRI *by construction* — which is exactly the situation in the six-model table, where a gamma-band coalition code and a noise-driven rate deviation reach the same low-frequency output. Fitting a functional connectivity matrix cannot arbitrate between them; only a measurement that survives the filter (M/EEG band-limited power, spatiotemporal rather than temporal statistics) can. It sharpens [[wiki/concepts/dynamic-repertoire.md]]'s "three mechanisms, one dataset" open problem into a statement about why: the instrument is a filter with a stated cutoff.

**And the fast side is itself contested.** Which carrier's power tracks BOLD is unsettled — intracranial recordings say gamma power, positively; EEG/MEG say alpha/beta power, negatively, and recover the same RSN maps from **beta-band amplitude envelopes**. Logged as [[wiki/empirical-tensions.md]] T242.

---

## Global coupling is the parameter, not the lesion site

Dropping `k` — globally or locally — and re-deriving graph statistics from the *simulated* functional connectivity gives one reorganisation signature:

| Rises | Falls |
|---|---|
| hierarchy, efficiency, robustness | small-worldness, clustering, degree-distribution width |

This matches the reported functional-network changes in schizophrenia, and the review's own conclusion is the uncomfortable one: **most disconnection pathologies, global or local, should produce the same qualitative signature.** Two consequences the wiki has to carry:

- A functional-graph statistic is a **readout of coupling gain**, not a localiser. Measuring reduced small-worldness in a functional network licenses "coupling is down somewhere", nothing more.
- Conversely, **one scalar gain reorganises the whole graph** — which is a cheap control handle for a builder, and the same handle that moves the system across the bifurcation above.

---

## Relevance to a reasoning model

- **A set-point with a metric.** [[wiki/concepts/mean-field-reduction.md]] and [[wiki/concepts/dynamic-repertoire.md]] both argue a modular system should sit near an instability; neither says how to *tell*. `σ_R` does, and it is differentiable-friendly: compute phases from module activity (Hilbert transform), take the order parameter, maximise its temporal variance. **(brainstorm)** This is a candidate architectural regulariser with no task term in it — hold `σ_R` in a target band while training on the task loss, the way a firing-rate homeostat holds mean activity. The wiki has no such regulariser anywhere; every operating-point claim it carries is currently unenforceable.
- **Ghost attractors are capability without commitment.** The task repertoire lives in the coupling matrix as attractors that are never entered at rest. Nothing stores them, no per-task parameters exist, and a task input stabilises one by moving the system a short distance across a bifurcation it is already adjacent to. Compare the wiki's standard answer — a learned per-context mask or a separate landscape per context ([[wiki/entities/context-modular-memory-network.md]]) — which pays memory per context. Here the cost is zero and the price is that the repertoire is whatever the connectivity happens to imply, not what was asked for. **The open design question is whether a repertoire of ghost attractors can be *trained*, since nothing in any of these six models learns.**
- **Substrate-independence is the transferable part.** A conclusion that holds across chaotic nodes, damped oscillators, limit cycles, phase oscillators, spiking networks and linearised rate equations is a conclusion about *networks with delays and noise near a bifurcation*, not about brains. That is the level at which it can be imported.
- **Delay has a working range, not just a sign.** 5–20 m/s for instability, 8–15 ms delays for the metastable Kuramoto regime — the first numeric window in the wiki for [[wiki/concepts/learnable-synaptic-delays.md]]'s parameter at network scale. Below it the network locks; above it the coupling stops engaging.
- **Do not read a functional graph as topology.** For [[wiki/concepts/latent-graph-discovery.md]]: the discovered graph moves with a single global gain even when the underlying structure is untouched, so graph statistics estimated from correlations confound topology with coupling strength — on top of the window-dependence already logged (T240).

---

## Open problems

- **Nobody has run the controlled comparison.** The six models use different connectomes (macaque `N` = 38/47, human `N` = 66/90), different parcellations, different empirical FC targets. The review states plainly that a rigorous comparison would require all models on the same anatomy against the same functional data, and it has not been done — so "all fit best at criticality" is six studies agreeing, not one experiment.
- **Criticality may be partly an artefact of the fit criterion.** **(brainstorm)** Spatial variance of simulated correlations is maximised near an instability almost by definition; a scoring rule that rewards matching a high-variance empirical correlation structure will therefore point at the bifurcation regardless of mechanism. Nothing in the source separates "the brain is critical" from "correlation-matching selects for criticality".
- **Every fit is to a stationary target.** Functional connectivity matrices assume relationships are constant over the recording, and they are not. Non-stationary connectivity dynamics are named as the required next constraint and are unaddressed by all six models.
- **No model performs a task.** The entire literature scores itself on resting correlations. "The repertoire is the space of useful configurations" is never tested against a behavioural readout.
- **Nothing learns.** Weights are anatomy, delays are Euclidean distance over a swept velocity, coupling is a swept scalar. Same terminal limitation as the two pages below it on the ladder.
- **Subcortical routes are missing from the connectomes used**, and polysynaptic (e.g. cortico-cerebellar) pathways demonstrably carry resting functional connectivity — so a model fitted on cortico-cortical tracts alone is fitting a signal partly generated off its own graph.

---

## Connections

- **[[wiki/concepts/dynamic-repertoire.md]]** — the same object seen as a manifold rather than as a statistic: that page says the repertoire exists and needs criticality to be expressible, this one supplies the scalar that measures how much of it is being visited (`σ_R`), the model-independence argument for the operating point across six rather than three reduction lines, and the ghost-attractor version where the repertoire is latent rather than traversed.
- **[[wiki/concepts/mean-field-reduction.md]]** — the rung below: it derives the node models tabulated here (Wilson–Cowan mass, neural field, linearised density) and establishes delay as a stability parameter; here every one of those rungs is assembled on a connectome and they all land on the same working point, which makes the choice of rung matter less than the choice of operating point.
- **[[wiki/concepts/attractor-dynamics.md]]** — the distinction this page turns on: metastability is a trajectory property and multistability a landscape property, and the best-fitting whole-brain model sits *outside* the multistable region with the attractors acting as ghosts — capability that is never entered and therefore never costed.
- **[[wiki/entities/fcann.md]]** — the wiki's whole-brain attractor model, and the page whose "ghost attractor on the basin boundary" now has a mechanism and a working-point account: its landscape is the multistable band this page's optimum sits just below, and its coupling matrix is estimated through the 0.35 Hz low-pass described here.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — supplies this page's carrier-frequency problem and inherits its bound: the gamma-envelope bridge between electrophysiology and BOLD is contested by the MEG/EEG evidence tabulated here (T242), and the haemodynamic filter's 0.35 Hz cutoff is why the two literatures cannot arbitrate the question with fMRI.
- **[[wiki/concepts/learnable-synaptic-delays.md]]** — the network-scale numbers: metastable coalitions require conduction delays of 8–15 ms at velocities of 5–20 m/s, so the delay parameter has a two-sided working range rather than merely a destabilising sign.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a second confound on the discovery side, alongside window-dependence: a single global coupling gain reorganises every graph statistic of the recovered functional network without touching the structure, so an inferred graph reports gain and topology jointly.
- **[[wiki/concepts/precision-weighting.md]]** — a measurable set-point to sit beside `C_sens/C_sheet`: distance to the bifurcation, read off the temporal variance of the global order parameter, and regulated by one scalar gain that the disconnection results show moves the whole network at once.
- **[[wiki/concepts/temporal-coding.md]]** — the fast/slow bridge with its arbitration bound attached: the same 0.1 Hz envelope is produced by a coalition-identity code, an amplitude code, and a rate-deviation code with no oscillation at all, and a 0.35 Hz low-pass observable cannot separate them.
- **[[wiki/concepts/population-geometry.md]]** — what the order parameter is, geometrically: `R(t)` is the length of the mean phase vector, a one-dimensional summary of the population's angular distribution, and its variance is the only part of that summary that identifies the useful regime.
- **[[wiki/concepts/node-definition-problem.md]]** — why the six-model comparison could not have been clean: the models use different connectomes at different parcellations, and a change of parcellation is not cosmetic — it moves relational content between node-internal structure and edges, so `σ_R` and every graph statistic here are reported against a vertex set that was chosen rather than measured.
- **[[wiki/concepts/effective-connectivity.md]]** — the estimation side of the same models, with a payoff and a hard limit: fitting a whole-brain model to the probabilistic metastable-substate space lets *in silico* stimulation force transitions (sleep↔wake; precuneus as the best ageing-reversal target), and maximal metastability with critical slowing down is explicitly underivable from functional connectivity — yet the estimators that reach per-subject whole-brain scale are linear, so the bifurcation this page's working point sits on is outside their model class (Li & Yap 2022).
- **[[wiki/concepts/structured-flows-on-manifolds.md]]** — the working point measured by a second statistic and given a mechanism: "fluidity" (variance of functional connectivity dynamics) peaks in the same narrow coupling band as `σ_R`, and — the non-obvious part — effective dimensionality *falls* there rather than rising, because time-scale separation at the instability produces both the churn and the collapse onto few order parameters.
- **[[wiki/entities/virtual-brain-twin.md]]** — the working point given an external validation: fluidity of spontaneous activity separates conscious report under propofol, xenon and ketamine as well as the perturbational complexity index does, so a passive statistic matches an active TMS probe — the strongest evidence in the wiki that the operating point is a measured quantity rather than a fitting artefact (Hashemi et al. 2025).
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — the structural counterpart of this page's functional graph statistics: small-worldness, clustering and degree spread measured on *anatomy* cannot be confounded with coupling gain, which is why the core's membership is stable while the functional statistics move with a single global scalar.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the estimation-side consequence of a metastable working point: functional connectivity computed over a window is a time-average over coalitions, so a 998-node model with a fixed coupling matrix reproduces functional connectivity to itself at only `r = 0.69–0.80` across consecutive 8-minute windows.
- **[[wiki/concepts/integration-segregation-balance.md]]** — the same working point measured with a graph statistic instead of a phase statistic, and where the two disagree: participation coefficient `B` rises monotonically with task difficulty and the *most integrated* states give the fastest drift rate, while `σ_R` says approaching global coherence collapses the repertoire — [[wiki/empirical-tensions.md]] T249.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — the working-point question asked with a per-edge control variable instead of one global gain `G`: tuning each pair's long-range excitation/feedforward-inhibition mixture fits individual resting functional connectivity at `r > 0.97`, an order of magnitude closer than a global-gain sweep reaches, at the cost of ~143,000 non-identifiable parameters (Schirner et al. 2023).
- **[[wiki/concepts/anatomical-harmonic-modes.md]]** — the axes `σ_R`'s variance would be expressed in: an anatomically-generated orthogonal basis whose low-frequency modes carry the bulk of both spontaneous and task activity, with no dynamics yet placed on the coefficients (Vohryzek et al. 2024).
