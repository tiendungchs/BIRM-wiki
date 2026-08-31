# Ignition — an All-or-None Commit Operation on a Shared Bus

**A stimulus that has been fully processed locally either does or does not trigger a sudden, self-amplifying, network-wide reverberation ~200–300 ms later. Below threshold the activity decays; above it, one coalition seizes a distributed long-range population, holds itself by recurrence, suppresses its competitors, and becomes readable everywhere. Ignition is the wiki's only mechanism in which "this representation is now the system's current content" is a discrete, dateable event rather than a matter of degree.**

> **Provenance.** Mashour, Roelfsema, Changeux & Dehaene 2020, Neuron 105(5):776–798 (`raw/mashour-2020-global-neuronal-workspace.md`), reviewing Dehaene et al. 2003, Dehaene & Changeux 2005, van Vugt et al. 2018, Joglekar et al. 2018 and ~20 years of human electrophysiology. Framework context: [[wiki/entities/global-neuronal-workspace.md]].

---

## The dynamics

Two regimes of one network, same stimulus:

| | **Sub-threshold** | **Ignited** |
|---|---|---|
| Feedforward sweep | Present, amplitude and duration ∝ input | Present, identical for the first ~200 ms |
| What follows | Slowly decaying wave in higher areas; can persist **> 1 s**, into the working-memory range | Cascading self-amplification → global self-sustained reverberation |
| Frontal signature | Transient, decaying PFC activity | Sudden, strong, **sustained** PFC activity |
| Competitors | Not suppressed | **Inhibited** — the ignited coalition is exclusive |
| Decodability | Content is decodable but the trajectory decays | Content decodable and *sustained*; trajectories for seen/unseen diverge sharply |

**The two-stage receptor structure is explicit and is the part that transfers:**

| Stage | Carrier | Function |
|---|---|---|
| 1. Feedforward | **AMPA** — fast | Propagate; amplitude tracks input strength; sufficient for a great deal of unconscious processing |
| 2. Feedback / recurrence | **NMDA** — slow, voltage-dependent, therefore *conditional* | Amplify the wave's own input in a cascade; this is where the non-linearity lives |

Pharmacological confirmation: the initial sweep relies on AMPA, later feedback on NMDA (Self et al. 2012); ketamine (NMDA antagonist) selectively impairs ignition and conscious perception, mimicking schizophrenia's raised perceptual threshold, and anti-NMDA-receptor encephalitis progresses from psychosis to complete loss of consciousness.

**(brainstorm) NMDA's voltage dependence *is* the threshold.** A conductance that is negligible until the postsynaptic cell is already depolarised is a multiplicative gate on feedback: feedback can only amplify what is already partly active. Every ReLU-and-residual feedback loop in machine learning has additive feedback with no such coincidence condition, which is why they need explicit gating to avoid runaway. A single `sigmoid(pre-activation)` factor on the *feedback* term — not on the feedforward term — is the minimal import, and it makes take-off depend on the joint state of both ends of the loop rather than on either alone.

---

## The stability condition: balanced amplification

Joglekar et al. 2018, starting independently of the framework and using macaque tract-tracing connectivity: ignition is not designed in, it **emerges** from reciprocal projections — but only inside a window.

| Regime | Outcome |
|---|---|
| Feedforward excitation too weak relative to local inhibition | The signal dies en route; no ignition at any input strength |
| Balanced (feedforward excitation offset by local inhibition) | Stable cascade with a late, sudden take-off — the observed behaviour |
| Too strong | Runaway; the network ignites on anything |

So an ignition mechanism has a *stability budget*, and it is the same budget [[wiki/concepts/excitation-inhibition-balance.md]] spends on speed–accuracy trade-off and working-memory thresholds. **One knob, three functions** — which means a system cannot tune its admission threshold independently of its decision speed unless it separates them by construction.

---

## The threshold is a signal-detection threshold

`van Vugt et al. 2018`, macaque V1/V4/dlPFC, contrast detection with hits, misses, correct rejections and false alarms:

| Signal detection theory | Neural realisation |
|---|---|
| Criterion | The ignition threshold in prefrontal cortex — a minimum arriving activity |
| Sensitivity `d′` | Efficiency of propagation V1 → V4 → PFC. Failures localise: very weak stimuli lost at V1→V4, stronger ones reach V4 but fail to ignite PFC |
| Bias | **Pre-stimulus distance from threshold.** High pre-stimulus firing across all recorded areas → more false alarms. Predictable from motivation and pre-stimulus EEG band power |
| False alarm | A **spontaneous** ignition with no stimulus — and it is reported exactly like a hit |

**Consequences for a machine system.** (1) A confidence threshold need not be a scalar compared against a score; it can be the bifurcation point of the recurrent stage, with "bias" implemented as resting-state gain. (2) The system *hallucinates by the same mechanism it perceives by* — a spontaneous supra-threshold cascade is indistinguishable, downstream, from a stimulus-driven one. Any architecture that gets its commit operation this way inherits the failure mode, and the only available fix is at the propagation stage (`d′`), not at the gate. (3) The gate can be pre-set: the state *before* the input already determines the hit and false-alarm rates, so an idle-state controller is a legitimate place to spend control effort.

---

## Timing: the commit is decoupled from the stimulus

| Observation | Number |
|---|---|
| Divergence between reported and unreported trials | **200–300 ms**; the first ~200 ms can be fully preserved on unreported trials, particularly under inattention |
| Late positive (P3) component | Vanishes almost entirely under inattention and during sleep; crossing the perceptual threshold produces a *sudden* P3 increase |
| Dual-task delay | Conscious access can be postponed **well beyond 300 ms** when attention is occupied elsewhere |
| Retro-cue | A cue arriving **900 ms after** a flashed stimulus can retrospectively make it consciously perceived when it would otherwise have been too weak |
| Infant homologue | Late non-linear slow wave at ~900 ms (5 months) → ~750 ms (12–15 months) → ~300 ms (adults) |

**The retro-cue is the important one.** A decaying sub-threshold trace remains ignitable for the better part of a second: the system holds an un-committed candidate and a later signal can promote it. That is a *deferred commit* — the architecture keeps a pool of live, unbroadcast partial results and decides which to publish after further evidence arrives. No wiki architecture has this. It is neither a buffer (the trace is decaying, not maintained) nor a re-computation (the original input is gone).

---

## Which areas must participate is task-dependent

| Task | Does V1 join the ignited set? |
|---|---|
| Contrast detection (van Vugt et al. 2018) | Barely — the hit/miss difference is late PFC activity, with only small (significant) late modulation in V1/V4 |
| Texture figure–ground (Supèr et al. 2001) | **Yes and necessarily** — feedforward responses are identical for figure and ground; only the late, feedback-driven enhancement discriminates them, and it is absent on misses |

So membership in the broadcast coalition is **set by the resolution the task requires**, not fixed anatomically. A system whose global workspace always contains only high-level summaries cannot perform tasks whose answer lives in the fine detail; a system that always includes the sensory layer pays full bandwidth for every commit. **The variable is the depth to which the recurrence reaches**, and it is exactly the *scope* variable [[wiki/concepts/broadcast-hierarchy.md]] names and no predictive-coding implementation exposes.

---

## The unresolved marker dispute

| | **P3 / late positive (~300 ms)** | **Visual awareness negativity (~260 ms, ~200 ms duration)** |
|---|---|---|
| Claim | The signature of conscious ignition; common across modalities and paradigms (masking, attentional blink) | The *earliest* electrophysiological correlate of visual awareness (corroborated with MEG) |
| Anatomy | Global recurrence including frontoparietal | Early recurrent loops within lower visual areas |
| Behaviour when the stimulus is task-**irrelevant** yet reported as seen | Absent | **Present** |
| Reading offered | The two usually succeed one another and jointly index the spread of ignition; VAN may mark *accessibility*, P3 genuine *access* and processing | Or: P3 is post-perceptual (report, decision, memory encoding) and awareness is already complete at VAN |

Unresolved in the source, and it matters architecturally rather than philosophically: **is there one commit or two?** A design with a local sensory-level recurrence stage *and* a separate global publication stage behaves differently from one with a single gate — the first can compute on content it never publishes. Logged as a tension.

**Behind the marker dispute is a structural one:** whether there is a single commit event whose earliest correlate is being argued over, or *two* separable events — an early sensory-side threshold crossing and a later, distinct admission to the broadcast — with each camp measuring a different one ([[wiki/empirical-tensions.md]] T268). Under one commit, the ~260 ms and ~300 ms markers are early and late reads of the same transition and the dispute is about latency; under two, both markers are correct and name different operations, which is the reading a machine architecture would have to implement as separate gates.

---

## What this gives an abstract-reasoning architecture

| Property of ignition | Design consequence |
|---|---|
| **Discrete and dateable** | Supplies a *step boundary* for serial computation over parallel modules: step `k` ends when the workspace commits. Continuous-mixture architectures have no such marker and therefore no natural notion of an intermediate result being "done" |
| **Exclusive** | At most one content occupies the bus, so downstream consumers never have to disambiguate whose output they are reading. This is a cheaper solution to the binding problem than tagging |
| **Self-sustaining** | The committed content stays live and transformable without being copied to a store — maintenance and availability are the same state |
| **Thresholded on aggregate arriving evidence, not on any one input** | Gives a principled abstention: a coalition that cannot recruit enough support simply never publishes, and the system proceeds without it |
| **Threshold degrades gracefully** | Simulation: any reduction in workspace neuron count, connectivity or synaptic strength *raises* the threshold rather than breaking the mechanism — matching raised perceptual thresholds in frontal-lobe syndrome, neglect, multiple sclerosis and schizophrenia with abnormal long-distance tracts |
| **Engaged selectively** | Workspace activation rises during novel task acquisition, effortful execution and after errors (1998 Stroop simulation) — the bus is for when the cached policy fails, so the gate is also a *compute-allocation* signal |

**(brainstorm) The missing learning rule.** Nothing in this literature says how the threshold is set, how a coalition learns to be ignitable, or how credit reaches an admission decision whose consequence appears many steps later. The gate is the one component of the framework with no training story at all — which is the same shape as the write-gate problem [[wiki/entities/pbwm.md]] solves by reinforcement for a working-memory store. Applying that answer here would make "what is worth broadcasting" a learned policy over coalitions rather than a fixed threshold, and would predict that ignition thresholds are content-specific, which is testable and, as far as this source reports, untested.

---

## What the commit fires on: onset, not offset

> Naccache et al. 2025, Neurosci Conscious 2025(1):niaf037 (`raw/naccache-2025-gnw-adversarial-testing.md`), replying to the COGITATE adversarial collaboration (Cogitate et al. 2025, Nature). Commentary, no new data.

The preregistered collaboration formalised the framework as predicting **two** ignitions per stimulus — one at onset, one at offset — and found only the first. The reply's position:

| | Onset | Offset |
|---|---|---|
| Predicted? | **Core prediction**, and confirmed at 200–800 ms, independent of stimulus duration (500/1000/1500 ms) and of task relevance | **Not a prediction.** No simulation from 1998–2011 and no recording produced one; predicted *only* when the participant consciously attends the offset |
| Why the asymmetry | A new input captures attention and recruits a coalition | Nothing new arrives — the current content merely loses support. A commit is a *win*, and nothing wins by default when the incumbent fades |

**This makes the trigger "change in the attended content", not "change in the input"** — the two coincide at onset and separate at offset. For a machine step-boundary generator the difference is one boundary per stimulus versus two, and it is testable: enforce awareness of the offset (make it task-relevant) and a second ignition should appear. Logged as [[wiki/empirical-tensions.md]] T271.

**The primary record, and it raises the price of the deflection.** Ferrante et al. (COGITATE) 2025, Nature (`raw/ferrante-2025-gnwt-iit-adversarial-testing.md`), `n = 256`, fMRI + MEG + iEEG: **0 of 655 prefrontal electrodes** showed the onset-plus-offset profile (`BF₀₁ > 3` for every electrode, favouring an intercept-only or amplitude-varying model), while the *same* linear mixed model recovered that profile in **10 striate/extrastriate electrodes** — so the analysis can see the pattern where it exists. One prefrontal site (inferior frontal sulcus) showed it under an exploratory unrestricted-profile decoding, with transients ~0.15 s after onset and offset, earlier than predicted. Cross-temporal representational similarity found transient category representation at onset and none at offset **even in the task-relevant condition**, where the content signal was stronger, more stable and longer lasting — the nearest available approximation to the "attend the offset" condition the deflection asks for. The prefrontal onset representation is also temporally narrow: cross-task decoding generalised over **~0.2–0.4 s**, against roughly the whole stimulus duration posteriorly, which is what an *admission event* looks like and not an occupancy state.

**A second number from the same study bears on what the commit publishes.** Adding prefrontal regions of interest to a posterior decoder did not improve — and sometimes reduced — accuracy, at `BF₀₁ = 1.94 × 10⁴` (category, iEEG) and `1,205` (orientation). The framework predicts exactly this (workspace neurons broadcast, they do not add information), so the commit is *informationally transparent*: after ignition the bus carries no more than the sender had. For a builder that is a strong constraint — a broadcast stage that transforms its payload would be detectable as added decodable information, and here there is none.

**The corresponding claim about duration**: as long as a content occupies the workspace it is *explicitly* encoded there, so decoding should be **continuous**, not intermittent. The collaboration's transient "silent states" are attributed to the content having left the bus — plausible under long, monotonic, task-irrelevant stimuli, and unfalsifiable without report. The framework's no-report methodology and its continuous-encoding claim are therefore in direct tension: removing the report removes the only handle on occupancy. **For a builder this is the more useful reading:** if occupancy is exclusive and the bus wanders, "the current content is decodable" is a statement about the *controller*, and any architecture that infers commitment from a decoder needs an independent occupancy signal — which a machine, unlike an experimenter, can simply expose.

**Decoding failure ≠ absence of the content.** The same source's second move: prefrontal cortex has no strong columnar organisation and codes with mixed selectivity, so field-scale instruments (fMRI, MEG, iEEG) average the code away, while visual cortex's columnar clustering makes linear decoding easy — easy enough that it succeeds on **non-conscious** stimuli too. Ignition's evidence therefore rests on propagation and timing rather than on where content decodes best. See [[wiki/concepts/population-geometry.md]] and [[wiki/empirical-tensions.md]] T272.

---

## The commit with no input change, measured at unit resolution

> Kapoor et al. 2022, Nat Commun 13:1535 (`raw/kapoor-2022-conscious-transitions-pfc.md`). 987 units, macaque ventrolateral prefrontal inferior convexity, no-report binocular rivalry; perception inferred from optokinetic nystagmus, never reported.

Binocular rivalry is the paradigm that isolates this page's claim from every alternative reading: the retinal input is **constant and dichoptic**, and the content switches anyway, on a gamma-distributed dwell time. So a prefrontal signal that tracks the switch cannot be a relayed feedforward response, cannot be a report, and cannot be a decision about which button to press — the animals were never trained to report anything.

| Observation | Consequence for the commit |
|---|---|
| Feature-selective prefrontal units follow the *percept*, not the input: ~90% of strongly selective units (`d′ > 1`) fire more when their preferred motion is dominant, whether dominance is externally imposed (flash suppression) or arises spontaneously | The bus carries the winner even when nothing new arrived to win |
| A **strong transient** accompanies externally induced dominance and is **absent** at spontaneous switches, while the sustained modulation is the same size in both | The feedforward burst is separable from the content signal, and is not its source. The commit does not need an onset |
| Single-trial decoding of the current percept up to **95%**, with a classifier trained on one trial type generalising to the other | Occupancy is readable per-event, not only in the trial average |
| Cross-temporal generalisation is broad rather than diagonal | A **static** code during dominance — the property this page attributes to a self-sustaining ignited state, measured directly |

**What this settles and what it does not.** It settles the sign of T272 for prefrontal cortex: the named resolving measurement returns *content present*, so the coarse-scale null licenses nothing. It does **not** measure ignition — no threshold, no dateable take-off and no all-or-none transition is reported here; the paper measures the *held* state, not its admission. The interesting residue is that this is the wiki's only recording of a prefrontal content switch with **no external trigger at all**, which is T271's other half: if the commit fires on change in the attended content rather than change in the input, then rivalry produces a boundary from an internal competition alone — and the internal generator that produces it is exactly what gap `G90` says no architecture here has.

---

## The admission event, measured — and it fires with no request

> Dwarakanath et al. 2023, Neuron 111(10):1666–1683.e4 (`raw/dwarakanath-2023-prefrontal-bistability-consciousness.md`). Same preparation as the row above, one level down: local field potentials from the same macaque ventrolateral prefrontal arrays, 573 spontaneous no-report rivalry transitions. Full treatment: [[wiki/concepts/cortical-state-bistability.md]].

The companion recording measured the *held* state and explicitly not its admission. This one measures the admission, and it turns out to be a **content-free** event in a different signal:

| | Measured |
|---|---|
| What precedes a spontaneous switch | A 1–9 Hz burst regime that suppresses the ongoing 20–40 Hz beta regime, peaking at **−60 ± 222 ms** and with the last burst at **−198 ± 133 ms** — earlier than the end of the incumbent's own dominance (−97.4 ± 140 ms, `p < 10⁻⁶⁷`) |
| When the content-selective units change | Ensemble crossover at **+209 ± 295 ms**; the state event leads it in 86–89% of transitions |
| Both ignition modes, separated | Low-frequency burst *amplitude* ramps **linearly** (slope 0.61, `R² = 0.34`), while the *number of recruited sites* jumps **non-linearly** just before the switch. Neither is present before a physical switch |
| That the threshold is real | Sub-threshold release produces **piecemeal** perception — a failed switch, burst rate 0.147 vs 0.17 for a completing one, with the beta antagonism absent — against a sustained-dominance noise floor of **0.015** and site recruitment of 51% vs **100%** |
| Ordering flip | The identical low-frequency-suppresses-beta motif follows a *physical* stimulus change (+64 ms, the visual evoked potential) and precedes a *spontaneous* one |

Three consequences for this page. **(i) The commit does not require an admission request.** Every formulation above derives the take-off from sensory evidence crossing a criterion; here the take-off is generated internally, ramps with no input change, and the same oscillator free-runs at a matched rate in resting state with no stimulus at all (gamma-distributed beta dwell 1.2 s vs 1.54 s perceptual dominance). **(ii) The gate and the content are different signals.** The releasing event carries no information about what will be admitted — it dissolves the beta coherence that binds the incumbent ensemble and lets whoever is phase-advantaged win — which means "commit" and "which content" are separately schedulable, and no wiki architecture separates them. **(iii) The all-or-none claim gains its missing intermediate case:** piecemeal is what a half-executed commit looks like from the outside, and it is a state a continuous mixture cannot produce.

---

## Connections

- **[[wiki/concepts/cortical-state-bistability.md]]** — the admission event this page could not see, measured: a content-free 1–9 Hz release regime antagonistic to a 20–40 Hz hold regime, leading the content change by ~300 ms, thresholded (piecemeal = failed commit), and free-running in resting state — which makes the commit generable with no evidence to admit.
- **[[wiki/entities/global-neuronal-workspace.md]]** — the framework this mechanism serves: ignition is the admission gate on the shared bus, and the framework supplies the processors, the long-axon population and the broadcast that make the gate worth having.
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — the stability condition: balanced amplification is what makes a reciprocal network ignite rather than die or run away, so the admission threshold and the speed–accuracy point are set by the same knob — and the ordering flip that page reports between prefrontal and parietal ramping is the same signature read at a lower dose.
- **[[wiki/concepts/evidence-accumulation.md]]** — supplies the threshold that page lists as unmodelled: the criterion is a bifurcation point, the bias term is the pre-stimulus distance from it, and both are measurable before the stimulus arrives.
- **[[wiki/concepts/attractor-dynamics.md]]** — ignition is a fast transition into a self-sustaining state, but the source describes the ignited regime as a *series of metastable states* rather than one fixed point, which is the difference between a commit and a lock-in.
- **[[wiki/concepts/metastability.md]]** — the ignited state is metastable rather than stable: it must be occupiable for hundreds of milliseconds and then vacatable, and that dwell time is what sets the step rate of serial reasoning.
- **[[wiki/concepts/broadcast-hierarchy.md]]** — supplies the *scope* variable this page's task-dependence needs: whether V1 joins the ignited coalition is a choice of how deep the broadcast reaches, which is the same update-scope parameter that page says the precision gates cannot express.
- **[[wiki/concepts/working-memory.md]]** — ignition is the transition of a weak sensory signal *into* the attended working-memory state, and the same MEG signature appears at encoding and at each refresh, so entry into memory and entry into the workspace are one event.
- **[[wiki/concepts/attention.md]]** — attention is a stack of filters of which only the last one gates ignition, so most attentional selection is complete *before* the commit and does not itself require it.
- **[[wiki/concepts/event-segmentation.md]]** — a discrete, dateable commit is a candidate boundary generator: if serial computation advances only when the workspace ignites, then step boundaries and event boundaries could be the same signal read at two scales.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — the carrier: ignition shows as increased local gamma power plus cross-area gamma synchrony, with the top-down alpha/beta versus bottom-up gamma split falling out of laminar connectivity rather than being assumed.
- **[[wiki/concepts/precision-weighting.md]]** — the alternative reading of the same gate: a precision term multiplies a prediction-error channel continuously, where ignition is discrete and exclusive, so the two accounts differ on whether "what the system is currently working on" is a scalar field or a winner.
- **[[wiki/entities/pbwm.md]]** — the trained-gate answer to this page's missing learning rule: basal-ganglia Go/NoGo gating learns *what deserves admission* by reinforcement across delayed consequences, which is exactly the credit-assignment problem the ignition threshold has no story for.
- **[[wiki/concepts/dynamic-repertoire.md]]** — what a system without working ignition looks like from the outside: the functional-connectivity repertoire collapses onto the anatomical matrix, since spontaneous supra-threshold cascades are what let functional connectivity deviate from structure at all.
- **[[wiki/concepts/simulation-based-planning.md]]** — a discrete commit gives a planner its step: each broadcast publishes one intermediate state that the next attentional operation consumes, which is the serial control this page's Raven's-matrices example depends on.
- **[[wiki/concepts/perturbation-elicitability.md]]** — the commit tested by perturbation rather than by decoding: stimulating the prefrontal population where ignition is claimed to be densest almost never changes what the patient is currently experiencing, which is what a *routing* component predicts and a content-holding one does not, and it leaves the evidence for the gate resting on propagation (`d′`) rather than on its locus.
- **[[wiki/entities/integrated-world-modeling-theory.md]]** — the same event re-read as a self-organizing harmonic mode: a synchronous complex that is simultaneously a workspace, a Φ-complex and one converged round of message passing, with the prediction that Φ trades off inversely between modules and workspace across the cycle and that entrainment direction flips at the commit.
- **[[wiki/concepts/population-geometry.md]]** — why the gate cannot be verified by a probe: a mixed-selective code is invisible to field-scale decoders and a columnar one is legible even when unconscious, so where content decodes best tracks the *geometry of the read-out* rather than what is on the bus (Naccache et al. 2025).
- **[[wiki/concepts/attractor-dynamics.md]]** — the alternative generator for this page's internally driven switch: binocular rivalry's stochastic, gamma-distributed alternation under constant input is competition-plus-adaptation-plus-noise hopping between basins, which produces a content change with no admission event, so a landscape and a threshold are two different stories about the same measured switch (Kapoor et al. 2022).
- **[[wiki/entities/integrated-information-theory.md]]** — the rival that needs no commit: if the maximally integrated complex *is* the experience, there is no admission event to date, and the preregistered test that broke its sustained-connectivity prediction is the same one that failed to find this page's offset commit.
- **[[wiki/concepts/loopy-belief-propagation.md]]** — the computation the commit is committing: if the ignited content is the MAP estimate of a converged loopy posterior, then "commit when the loop converges" replaces the threshold, and the number of rounds — hence the latency — becomes a function of input ambiguity rather than a constant.
- **[[wiki/concepts/sparse-expert-routing.md]]** — the same discrete commit with the threshold removed: a mixture-of-experts router commits at every layer for every token by argmax, so it can never fail to publish and never signals "nothing here" — and its instabilities are exactly what a threshold-free commit costs, which is why the fixes (router z-loss, float32 router precision) all regularise the logit scale in place of a criterion.
- **[[wiki/concepts/constitutive-vs-enabling.md]]** — the audit of this page's evidence base: a reported-minus-unreported contrast is a readout-cell contrast by construction, so the commit's frontal locus is only as strong as the no-report replications, and those relocate most of the content-specific effect posteriorly.
