# Parallel Timescale Streams — One State Alphabet Run at Six Speeds, Asynchronously

**The connectome does not run one sequence of co-activation states that each instrument samples at its own resolution. It runs at least six *concurrent* sequences — infraslow BOLD plus the δ, θ, α, β and γ amplitude envelopes — over the **same discrete state alphabet** (all 126 non-trivial combinations of seven canonical intrinsic connectivity networks), with mean state lifetimes spanning three orders of magnitude (~20 ms → ~3000 ms), *identical relative* transition structure across all six, and temporal overlap between streams indistinguishable from chance even after correcting for the haemodynamic delay. Shared spatial alphabet, shared sequencing rules, no shared clock.**

> **Provenance.** Alderson, Jun, Wirsich, Egan, ElSayed, Giakas, Mostame, Harper, Giraud, Malone, Iacono, Koyejo & Sadaghiani 2026, *Shared spatial and temporal principles govern connectome dynamics across timescales*, PNAS 123(25):e2535464123, doi:10.1073/pnas.2535464123 (`raw/alderson-2026-connectome-dynamics-timescales.md`). Concurrent resting-state EEG–fMRI, `N` = 26 (3 × 10 min), replicated on an independent concurrent EEG–fMRI cohort (`N` = 24, TR = 0.5 s) and a large EEG-only cohort (`N` = 443).

This is the empirical answer [[wiki/architectural-gaps.md]] `G67` has been missing — *how many timescales, and where do the boundaries go?* — measured rather than authored, and it comes back with an answer the wiki's own architectures do not implement: **many, at once, sharing a codebook and a transition prior but not a phase.**

---

## The measurement device: blueprint fitting

A deliberately *authored* state alphabet, so that fMRI and EEG can be scored in the same units.

| Step | Definition |
|---|---|
| Alphabet | 7 canonical intrinsic connectivity networks (ICNs — visual, sensorimotor, dorsal attention, ventral attention, limbic, frontoparietal, default mode) over 68 Desikan–Killiany cortical regions. A **blueprint** is a binary mask over the 7. `Σ_{k=1}^{6} C(7,k) = 126` blueprints; `k = 7` excluded because it covers the whole cortex and has no spatial specificity |
| Observation | fMRI: z-scored BOLD across the 68 regions per frame. EEG: source-localised (minimum-norm, 15,000 vertices → 68 regions), band-pass filtered into δ/θ/α/β/γ, Hilbert **amplitude envelope** per band |
| State assignment | `s(t) = argmax_b corr_spatial( blueprint_b , x(t) )` — frame-wise spatial Pearson correlation against all 126, winner takes the frame. Applied at each modality's **native** rate, no HRF convolution, no resampling |
| Read-outs | 126×126 transition matrix, fractional occupancy per blueprint, mean lifetime per blueprint — computed per subject per timescale |

The device matters as much as the result: unlike HMM- or ICA-derived states, the alphabet is fixed *a priori* and identical across modalities, which is what makes "the same state at two speeds" a well-posed question at all. The price is that the alphabet is authored (see Open problems).

**Neural timescale ≠ state-transition speed.** The band is the filter (Hz); the *envelope* of that band fluctuates more slowly than its carrier, and it is the envelope that sets how long a co-activation state persists. Lifetimes: **~20 ms** (γ) → **~3000 ms** (infraslow fMRI), tracking band centre frequency monotonically.

---

## Three results

| Claim | Evidence | Numbers |
|---|---|---|
| **Spatial principle is shared.** The same 126-state alphabet fits co-activation patterns at every timescale | Best-fit blueprint correlation vs two nulls — `Null_LabelPermute` (shuffle region→ICN labels) and `Null_PhasePermute` (per-region phase randomisation, spectra preserved) | `t(25)` = 19.32–35.68 and 18.23–37.36, all `p < .05/6`; replication `t(23)` = 22.47–46.32, `t(442)` = 83.09–109.01. Best- vs second-best blueprint `t(25) > 85`, Cohen's `d ≥ 16` (`≥ 2` after null correction) |
| **Temporal principle is shared.** The *relative* structure of transitions, occupancies and lifetimes is preserved across timescales | Within-subject correlation of the 15 timescale pairs' transition matrices, vs occupancy-preserving shuffles | Transition matrices `r = 0.90–0.96` within EEG bands, `r = 0.62–0.67` fMRI↔EEG (vs null: `t(25)` = 175–330). Occupancy "skyline" `r = 0.85–0.93` / `0.42–0.49`. Lifetime skyline `r = 0.83–0.89` / `0.17–0.19` |
| **The streams are asynchronous.** Identical states do not co-occur across timescales | Temporal overlap of identical blueprint labels for all 15 pairs, against a lifetime-preserving shuffle of one member; 6 s haemodynamic lag applied; also tested with full HRF convolution of the EEG correlation time series | **Null not exceeded anywhere**: `t(25)` = 0.04–1.09 (`p > .05/15`), and 0.02–0.25 after HRF convolution. EEG↔EEG overlap < 1.5% of frames |

**The transition motif.** Matrices are diagonal-dominant with a pointed-oval off-diagonal band: **~70% of all transitions are between blueprints differing by one ICN** (Hamming-1 on the mask), ~10% are between highly dissimilar blueprints, at every timescale. Gradual reconfiguration as the default with a preserved rate of long jumps — which is what makes coverage of the 126-state space efficient rather than diffusive.

**Occupancy.** Single-ICN states (blueprints 1–7) take only **12.2%** of the recording (per-blueprint 1.05–3.87%); multi-ICN blueprints dominate. Complementary blueprints (opposite masks) have matched occupancy. Two of the most-occupied states co-activate the default mode network with frontoparietal, ventral *and* dorsal attention networks simultaneously — the "task-positive/task-negative" pairs whose anticorrelation is usually treated as structural. That is a positive datum for [[wiki/concepts/dynamic-repertoire.md]]'s claim that anticorrelation is an emergent, window-averaged property rather than an antagonistic link.

**Robustness.** Effects survive source-leakage correction by orthogonalisation (reduced, as expected, since it removes real zero-lag coupling); survive a 300-region Schaefer parcellation on the fMRI side; survive a fourfold faster TR (0.5 s) with **unchanged** blueprint lifetimes — i.e. the ~3 s infraslow lifetime is not a sampling-rate artefact; and are not driven by head motion.

---

## What the paper does not show

- **Effect sizes on the fit are small.** Blueprints explain a modest share of instantaneous variance; the authors' own reading is that the residual belongs to circuit-, layer- and modality-specific processes the ICN alphabet does not name.
- **fMRI↔EEG correlations are the weak ones** (`r = 0.17` for lifetimes), plausibly because ~3 s states under-sample 126 blueprints in a 10-min run. The cross-modal half of the "shared temporal principle" rests on the smallest numbers in the paper.
- **Asynchrony is a null result.** It is a failure to exceed a shuffled-sequence null, with `N` = 26 — evidence *against* strict temporal alignment, not proof of independence. Partial coupling weaker than the null's resolution is not excluded.
- **No task, no behaviour.** Everything is resting state; the claim that parallel streams serve multi-timescale processing (phonemes/words/themes) is an argument, not a measurement.

---

## Relevance to a reasoning model

- **`G67` gets a target specification, not just a complaint.** Every timescale bank in the wiki ([[wiki/entities/ms-ssm.md]]'s `S = 3` strata, [[wiki/entities/s4.md]]'s common `Δ` rescaling) is a set of *decay constants* over one state stream. This source says the biological arrangement is different in two ways that are cheap to copy: (i) the streams share **one discrete state codebook**, so they are comparable and mutually readable without any learned adapter; (ii) they share the **transition prior** (relative structure) while differing only in the diagonal (persistence), so a bank needs one transition matrix plus one scalar per stream, not `S` independent dynamics models.
- **The state is a binary coalition mask, and the dynamics are bit-edits. (brainstorm)** With modules as bits, `s(t) ∈ {0,1}^M`, the measured policy is: toggle one bit ~70% of the time, jump to a distant mask ~10%. That is a runnable controller — a Hamming-1 random walk with a fixed restart rate — and it has the property a scheduler wants: locality (successive coalitions share most modules, so partial results survive a transition) with guaranteed ergodic coverage of `2^M` from the restarts. Nothing in the wiki's routing machinery ([[wiki/concepts/priority-map.md]], [[wiki/concepts/cognitive-control.md]]) specifies a transition rule at all; this is one, with a measured mixing ratio.
- **Combinatorial, not menu-driven, module composition.** Near the full 126-combination space is used at rest, and single-module states are 12% of the time. A mixture-of-experts or module-router that learns a small set of favoured coalitions is fitting the wrong object; the biological arrangement keeps the whole combination space live and *pre-visits* it in the absence of demand — the assembly-side reading of [[wiki/concepts/dynamic-repertoire.md]]'s "prior over configurations, generated by running".
- **Parallel-with-no-clock is an architecture choice, and a cheap one.** Asynchronous streams need no synchronisation barrier between the fast and slow parts of a model — the coupling is through the shared alphabet, at whatever moment each stream next lands on a state, not through aligned time steps. This is the opposite of the standard hierarchical-RNN arrangement (slow layer ticks every `k` fast steps, phase-locked by construction), and it removes the need to choose `k`.
- **A measurement discipline for any modular model.** Fit an authored alphabet of module-coalition masks to a network's own activations at several filter bands, then compare transition matrices across bands. If a trained multi-timescale model runs one stream sampled at several rates, its cross-band overlap will exceed the shuffle null; if it runs parallel streams, it will not. That test costs one forward pass over held-out data and is not run anywhere in the wiki.

---

## Open problems

- **The alphabet is authored.** 7 ICNs from the Yeo parcellation, assigned to Desikan regions by geometric distance. The combinatorial framing is only as good as the base set, and [[wiki/concepts/node-definition-problem.md]] applies to the base set with full force — a different parcellation gives different bits, and nothing here learns them.
- **Why these speeds?** The lifetimes track band centre frequencies, but nothing explains why the brain provisions six bands rather than three or twelve, and the proposed substrates (myelinated vs unmyelinated fibres; superficial-γ vs deep-β laminar gradient) are hypotheses attached post hoc.
- **Asynchrony has no mechanism.** If the six streams share a spatial alphabet and a transition prior, *something* imposes those regularities across them, and it is not a common clock. No candidate coupling is offered.
- **No power-law test within a timescale.** The scale-overarching claim is made across bands; whether sequences within a band are scale-free is left explicitly for future work.
- **Nothing learns anything.** Same terminal limitation as the rest of the wave-12 cluster: the alphabet is fixed, the transition structure is measured, and no plasticity shapes either.

---

## Connections

- **[[wiki/concepts/dynamic-repertoire.md]]** — the repertoire this page counts and times: that page says a resting network is a frequently-visited region of a manifold whose extent depends on the observation window, and this page shows the window question is not one question — six windows are being occupied at once, by the same alphabet of configurations, without temporal alignment.
- **[[wiki/concepts/metastability.md]]** — the coalition churn measured as a discrete symbol sequence rather than as `σ_R`: metastability says how much the coalition structure changes, this page says *which* coalitions and *in what order*, and finds the ordering rule (70% Hamming-1, ~10% long jump) preserved across three orders of magnitude of churn rate.
- **[[wiki/concepts/temporal-coding.md]]** — the arbitration this page performs on that page's fast/slow bridge: if a slow envelope were the amplitude modulation of a fast carrier's coalition structure, identical states would co-occur across bands; measured overlap does not exceed a shuffle null, so the slow stream is not a read-out of the fast one ([[wiki/empirical-tensions.md]] T253).
- **[[wiki/concepts/connectome-state-transformation.md]]** — the same object with the timescale collapsed: a linear operator mapping a window-averaged rest connectome to a window-averaged task connectome fixes the destination and says nothing about visiting order or speed, which is exactly the content this page recovers — and it now has six destinations to map, one per stream.
- **[[wiki/concepts/integration-segregation-balance.md]]** — the coarse-grained version of this page's state variable: participation coefficient `B` summarises a coalition mask in one number at ~10 s resolution, so the axis it measures is the projection of this page's 126-state walk onto "how many bits are set", and it is measured only in the slowest of the six streams.
- **[[wiki/concepts/node-definition-problem.md]]** — the constraint on the alphabet: the 7 ICNs over 68 regions are a parcellation choice, and this page's whole combinatorial state space inherits whatever content that choice moved between nodes and edges.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — the signal this page is built from on the EEG side: band-limited amplitude envelopes, without leakage correction in the main analysis, so the co-activation of two ICNs is a shared-envelope measurement and carries that page's inference limits.
- **[[wiki/concepts/working-memory.md]]** — the timescale bank stated as a demand: multi-timescale maintenance in the wiki is one store with a decay constant, while the measured arrangement is six concurrent streams over one codebook, which is a different provisioning of the same capacity.
- **[[wiki/entities/default-mode-network.md]]** — one letter of this page's 126-mask alphabet given its own anatomy and function, and a qualification in the other direction: default × dorsal-attention × frontoparietal co-activation is among the most frequent states here, which strict anticorrelation does not predict.
