# Offline Replay

**Temporally compressed reinstatement, during rest and sleep, of sequences of hippocampal activity — not a verbatim recording of experience but a filtered, resampled and sometimes never-observed sequence, which makes replay a *selection* mechanism rather than a playback mechanism (Liao & Losonczy 2024).**

[[wiki/concepts/complementary-learning-systems.md]] names replay as the channel carrying instance structure into meta structure and stops there. This page is what travels down the channel, what decides it, and what that costs a builder. The headline: **the statistics of what is replayed differ systematically from the statistics of what was experienced**, and the difference has the shape of a deliberate inductive bias toward transferable structure.

---

## Online and offline sequences are different objects

| | Online (theta) | Offline (sharp-wave ripple) |
|---|---|---|
| Behavioural state | Active exploration | Immobility, quiet rest, sleep |
| Carrier | 4–8 Hz theta oscillation; each cell's preferred phase **precesses** earlier across its field | Sharp-wave ripples (SWRs): synchronous high-frequency bursts |
| Compression | Whole upcoming trajectory compressed into one ~125 ms theta cycle | ~10–20× compressed relative to behaviour |
| Order | Forward only; population-coordinated so sequence order tracks physical order even for grossly overlapping fields (Dragoi & Buzsáki 2006) | **Forward *and* reverse** (Foster & Wilson 2006) |
| Content | Predictive of destination; read as current goal | Remote as well as local; sequences never observed; constrained by barriers |
| Function claimed | Compress behavioural-timescale distance into a spike-timing-dependent plasticity window | Consolidation, planning, offline construction |

**The theta cycle is a clock, and that is its computational point.** Behavioural co-occurrence runs at seconds; the STDP window runs at tens of milliseconds. Embedding a whole trajectory inside one theta cycle re-times the population so that ordered pairs fall inside the biophysical plasticity window — "distance in the sequence as a proxy for real distance". Without it, [[wiki/concepts/synaptic-plasticity.md]]'s edge-learning rule could not see the edges. (Time cells — cells responding at a fixed delay after a stimulus — are the second bridge across the same gap.)

---

## Replay is filtered, and the filter looks like a transfer prior

The specific-experience model predicts replay resembles individual experiences. It does not.

| Finding | Result | What it rules out |
|---|---|---|
| Random-cue task (Terada et al. 2022) | Salient random stimuli dominate online representation on every pass, yet cue-responsive CA3 Schaffer-collateral axons are **actively suppressed** during SWRs — not merely unselected | Replay as veridical sampling of experience |
| Goal-directed multi-arm task (Gillespie et al. 2021) | **Remote** experiences replayed more often than the imminent path | Replay as pure planning |
| Goal navigation (Grosmark et al. 2021) | Animals dwell near reward; replay **upsamples the regions where least time was spent** | Replay as frequency-matched rehearsal |
| Barriers (Widloski & Foster 2022) | Replayed sequences respect the current barrier configuration even as barriers move | Replay as a fixed learned trajectory set |
| Repeated exposure (Berners-Lee et al. 2022) | Replay appears after a *single* exposure, then **slows down and gains resolution** with experience | Replay content as static |
| Cortical reactivation (Sugden et al. 2020; Nguyen et al. 2024) | Cortical SWR-coupled reactivation is selective for task-relevant neurons and suppresses task-irrelevant ones; reactivations resemble *future* responses more than past ones | Consolidation as transport of a stored trace |

**The synthesis the review proposes:** a gradual transition from specific to generalisable content with exposure, converging from experiment (Ólafsdóttir et al. 2017; Terada et al. 2022) and theory (Liao et al. 2022; Sun et al. 2023). Replay's job is to *reduce recency and salience bias* — not fixating on the imminent goal, not neglecting rarely-visited space, not consolidating a salient but non-generalisable stimulus. Modelling work argues selectivity is necessary rather than optional: **consolidating everything overfits** (Sun et al. 2023).

**This is the structural replay criterion the wiki listed as unexplored.** [[wiki/concepts/complementary-learning-systems.md]] carried reward-prioritisation as the only demonstrated selection rule, and prioritised experience replay in machines copies exactly that. Biology's criterion is closer to the opposite: **upsample the under-sampled, suppress the idiosyncratic, and keep what recurs.** A machine replay buffer weighted by inverse visitation and by cross-episode recurrence — rather than by reward or TD-error magnitude — is a directly testable import **(brainstorm)**.

---

## Mechanism candidates

| Component | Proposal | Status |
|---|---|---|
| **Sequence store** | CA3 recurrence learns the pairwise transitions; CA1 (few excitatory-excitatory connections) reads them out | Classical; **challenged** — inducing a place field in one CA1 cell makes an assembly of other CA1 cells acquire the same field (Geiller et al. 2022), and ablating CA1's sparse recurrence eliminates theta in a full-scale model (Bezaire et al. 2016) |
| **Forward *and* reverse** | CA3's STDP kernel is **symmetric**, not the classical asymmetric one (Mishra et al. 2016), which lets the same weight matrix generate both directions | Modelling support (Ecker et al. 2022; Liao et al. 2022; Milstein et al. 2023); different directions serve different functions in planning models (Mattar & Daw 2018) |
| **The filter** | Plasticity at **inhibitory (GABAergic) synapses** — a learned inhibitory mask that suppresses the replay of non-generalisable stimuli. Long-term plasticity of GABAergic synapses is observed in vitro, with a symmetric spike-timing rule reported in auditory cortex (D'amour & Froemke 2015) | Predicted by modelling (Liao et al. 2022; Vogels et al. 2011); **the Terada result is not reproducible without it**, but rival models reproduce other replay phenomena with no inhibitory plasticity at all |
| **Sequence order at the ripple** | Inhibitory activity before and during a SWR determines the firing order of pyramidal cells (Noguchi et al. 2022) | Observed; whether the inhibitory control itself is learned is open |
| **A developmental prior** | **Preplay**: replay-like sequences detectable *before* any experience of an environment, later matching trajectories through it; developmentally related, interconnected CA1 subnetworks form adjacent place fields and co-fire in SWRs (Geiller et al. 2022; Huszar et al. 2022) | Contested (c.f. Silva et al. 2015). Read as a **prior on which cells may become adjacent nodes** — connectivity constrains learning without determining it |

**Offline plasticity is a hole, not a mechanism.** Whether synaptic weights change *within* hippocampus during rest has not been studied. The indirect evidence is suggestive: depolarisation during one SWR raises responsivity during subsequent SWRs (King et al. 1999); SWR-patterned spiking induces long-term potentiation in vitro (Sadowski et al. 2016); disrupting awake SWRs impairs learning even when online representations and post-experience replay stay intact (Jadhav et al. 2012). If plasticity does run offline, then the fast store is **refining its own content between exposures** — signal amplified, noise attenuated, before anything reaches cortex — and no machine replay buffer does anything of the kind.

---

## The four jobs the wiki now assigns to one mechanism

| Job | Where | Sampling criterion it implies |
|---|---|---|
| **Interleaving** — decorrelate a sequential stream for a slow learner | [[wiki/concepts/complementary-learning-systems.md]] | Uniform, or reward-prioritised |
| **Consolidation** — move instance structure into meta structure | Gap G14 | Generalisability (this page) |
| **Planning** — roll out candidate trajectories at a choice point | [[wiki/concepts/simulation-based-planning.md]] | Value of information (Mattar & Daw 2018) |
| **Offline state-space construction** — path-integrate away from a reward to attach a goal-vector cell to every location | [[wiki/entities/tolman-eichenbaum-machine.md]], [[wiki/concepts/cognitive-map.md]] | Coverage of the space |
| **Amortization** — compile model-based rollouts into cached values | [[wiki/concepts/amortized-inference.md]] | Where the cache is stale |
| **Structural organisation** — train a generative model so that sequences are organised *into* a structure, i.e. learn `g` itself | [[wiki/entities/tolman-eichenbaum-machine.md]] (Whittington et al. 2020) | Whatever the generative model would sample — the wake-sleep criterion |

**The sixth job is the strongest architectural claim.** TEM's learning scheme is wake-sleep shaped — an inference network awake and observing, a generative network checking offline whether what was inferred is what it would have predicted — and hippocampal replay does appear to sample from a generative model rather than to rehearse recorded episodes. The proposal is therefore that replay's *fundamental* role is the organisation of sequences into structures, which makes replay the training signal for the structural code rather than a rehearsal of the instance store (Whittington et al. 2020). If true, jobs 1 and 2 are downstream of job 6 rather than alongside it.

**(brainstorm)** Six jobs, six incompatible sampling distributions, one substrate. Either the brain arbitrates between them — in which case the arbitration policy is a missing component nobody has named — or the criteria coincide more than they appear to. [[wiki/concepts/successor-representation.md]] offers the only unification currently in the wiki: all five could be the *same eigenbasis* under different diagonal reweightings `ϒ`, which converts the arbitration problem into choosing one vector. That is the cheapest available hypothesis and it is testable — fit one basis, then check whether consolidation-replay and planning-replay differ only in `ϒ`.

---

## Why this matters for a reasoning model

- **Replay is the only mechanism in the wiki that edits the training distribution from inside the agent.** Everything else on the control surface ([[wiki/concepts/three-component-framework.md]]) — architecture, objective, learning rule, data — is set by the builder. Replay is a *learned curriculum generator*, and gap G32 (nothing designs the experience stream) is exactly the slot it fills.
- **Selection is a structural bias, so it can encode `g`-preference where the objective cannot.** G16 says the intended graph is not identifiable from one environment's data; the replay filter acts across the *offline* period with knowledge of what recurred, which is a second environment's worth of information applied to the first. Suppressing the non-recurring stimulus is a mechanism that prefers the structural rule over the shortcut without ever computing an objective that distinguishes them **(brainstorm)**.
- **A single exposure already produces replay**, so the fast store is queryable immediately; the specific→general transition is then a property of the *filter's* maturation, not of the store's.

---

## Open problems

- **No arbitration policy across the five jobs** above.
- **Does plasticity run during replay?** Unstudied inside hippocampus; the review flags it as a critical knowledge gap and a major underexplored facet of consolidation.
- **What segments the stream into sequences?** The trajectory an animal traces is 1D and therefore encodable as a sequence, but "the factors that determine the length of these sequences and how the brain chooses to segment this continuous trajectory into sequence snippets remain unknown" — the same hole [[wiki/concepts/event-segmentation.md]] and gap G27 describe, restated at the sequence level rather than the node level.
- **Is the inhibitory filter learned?** Whether inhibitory control of replay order evolves with learning is unknown; if it does, the excitatory and inhibitory plasticity mechanisms interact in ways no model captures.
- **Preplay's status is contested**, and with it the size of the developmental prior on which cells can be adjacent nodes.
- **Extrahippocampal replay.** Ripples and reactivation are reported in prefrontal, motor and sensory cortex; whether sequential reactivation and fast oscillations coincide outside hippocampus is unexplored — this decides whether replay is one brain-wide primitive or a hippocampal specialisation.

---

## A dissent: consolidation should happen awake

Rolls 2013 rejects the sleep-transfer premise this page and [[wiki/concepts/complementary-learning-systems.md]] assume, on three grounds:

| Argument | Claim |
|---|---|
| **Relevance filtering** | Waking recall retrieves memories that are *currently useful*; only those seed semantic structure. Sleep replay has no access to current relevance, so it consolidates where one parked one's bicycle two weeks ago |
| **The dream argument** | Semantic construction during unguided noise-driven stochastic firing risks building the bizarre representations we in fact dream about; rational thought during waking is what organises retrieved episodes into useful semantics |
| **Non-retrieval as forgetting** | Memories *not* retrieved during waking are the ones left to be overwritten by fresh random CA3 allocations — so the retrieval schedule and the forgetting policy are one mechanism |

The third point is the one with teeth for a machine: it makes **use frequency the consolidation criterion**, which is neither reward-prioritisation (position A of [[wiki/empirical-tensions.md]] T30) nor the transferability bias (position B). It is also the only criterion of the three that a deployed system can compute without labels or an offline pass. Note that Rolls offers no data — the argument is normative, and the direct recordings all favour ripple-driven offline replay ([[wiki/empirical-tensions.md]] T34).

---

## Connections

- **[[wiki/entities/vector-hash.md]]** — narrows this page's remit: 11 environments learned in sequence with zero forgetting and *no replay of any kind*, because separation in a large prestructured address space already prevents interference. If that holds, replay's job is consolidation and generalisation, not protection of what is already stored.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the dissenting schedule above, plus the mechanism replay must operate through: completion in a diluted CA3 attractor within a single theta cycle (~120 ms), and a polysynaptic reverse hierarchy to get the reinstated pattern back to cortex.

- **[[wiki/concepts/complementary-learning-systems.md]]** — this page is the content of that page's coupling channel: CLS says replay transports episodes to cortex, and the transport turns out to be lossy *by design*, suppressing non-generalisable items rather than sampling experience faithfully.
- **[[wiki/concepts/synaptic-plasticity.md]]** — supplies the write rules replay operates on (symmetric CA3 STDP for bidirectional sequences, inhibitory plasticity for the filter), and receives from this page the theta-cycle compression that lets a millisecond plasticity window see second-scale behavioural transitions.
- **[[wiki/concepts/simulation-based-planning.md]]** — forward replay at choice points is that page's rollout mechanism; this page adds that most replay is *not* about the imminent path, so rollout and consolidation cannot be the same sampling policy.
- **[[wiki/concepts/latent-graph-discovery.md]]** — replay is where edges get written: sequential pairwise relationships accumulated offline are the adjacency of the instance-graph, and the filter decides which candidate edges survive into the meta-graph.
- **[[wiki/concepts/successor-representation.md]]** — offers the one available unification of replay's competing sampling policies: one eigenbasis with a per-use diagonal reweighting `ϒ`, of which replay statistics are one setting.
- **[[wiki/concepts/cognitive-map.md]]** — replay respects the current barrier configuration and preserves topological rather than metric adjacency, which is direct evidence that the thing being replayed is the graph and not the trajectory.
- **[[wiki/concepts/amortized-inference.md]]** — the fifth job: offline reactivation compiling model-based rollouts into cached values, using the same machinery with a staleness-driven sampling criterion.
- **[[wiki/concepts/continual-learning.md]]** — rehearsal is the machine form of this mechanism, and this page supplies the selection rule that machine rehearsal lacks: consolidating everything overfits, so the generator must cull.
- **[[wiki/concepts/event-segmentation.md]]** — the same unsolved discretisation, one level up: that page asks what licenses a new node, this one asks what sets the boundaries of a replayed *sequence*.
- **[[wiki/concepts/three-component-framework.md]]** — replay is a fifth lever the control surface does not list: an internally generated curriculum, learned rather than designed.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — supplies replay's fourth job (offline path integration to attach goal-vector cells to every location), which makes replay pattern a model prediction rather than an observation; and its sixth, in which offline generative sampling is what *builds* the structural code, so replay would be how `g` is learned rather than how episodes are rehearsed.
- **[[wiki/concepts/pattern-separation-completion.md]]** — completion is what makes replay possible at all (a partial ripple-triggered cue reinstates a whole stored sequence), and the filter described here is the first mechanism that decides *which* completions are worth performing.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — offline reactivation is generative-model sampling with the sensory input clamped off, which is the same forward pass the free-energy account uses for imagination, run for a learning rather than a control purpose.
- **[[wiki/entities/temporal-context-model.md]]** — supplies a mechanism replay could exploit: re-presenting an item reinstates the context surrounding it, which is how offline reactivation could propagate transitive structure across pairs that were never experienced together.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — a sixth candidate job for the same substrate, and the only one that makes alternation itself the computation: one hidden state sampled per theta cycle turns rapid map flickering into a posterior sample, predicting that switching rate declines as evidence accumulates.
