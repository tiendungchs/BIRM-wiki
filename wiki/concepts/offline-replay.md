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

**Online sequences are not a separate object from the population's state space — they are paths through it.** In mouse CA1, 16 088 pairs of cells that reliably fire one after another are each active in only 3.6% of trials, yet reconstructing activity from the 5 latents of the population manifold re-detects them at TPR 0.87 / FPR 0.14, and the *length of the trajectory on the manifold* between the two firings predicts the elapsed time (Nieh et al. 2021, [[wiki/concepts/population-geometry.md]]). The source's proposal — untested, since no rest period was recorded — is that offline replay sequences in non-spatial tasks are organised by the same geometry. If so, the seven competing sampling distributions below are choices of *trajectory on a fixed surface* rather than choices among stored episodes, which is a much smaller arbitration problem than the one this page currently poses.

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

**The forward/reverse ratio is a representational knob.** Replaying trajectories in both directions with equal probability, under the *classical asymmetric* write rule, produces the same time-reversible successor representation that a symmetric rule produces online — because the rule's fixed point depends on the mixture `αP_forward + βP_backward` and reverse replay supplies the backward term (Keck et al. 2025, [[wiki/concepts/successor-representation.md]]). So the same map can be symmetrized either at the synapse or at the sampler, and the observed forward:reverse ratio becomes a *measurable* setting of how policy-contaminated the consolidated map is: all-forward stores the behavioural policy, balanced stores the geometry. This adds a further job — **de-biasing the stored transition structure toward uniform-policy geometry** — whose sampling criterion (mirror what was experienced) is unlike the other six.

**Offline plasticity is a hole, not a mechanism.** Whether synaptic weights change *within* hippocampus during rest has not been studied. The indirect evidence is suggestive: depolarisation during one SWR raises responsivity during subsequent SWRs (King et al. 1999); SWR-patterned spiking induces long-term potentiation in vitro (Sadowski et al. 2016); disrupting awake SWRs impairs learning even when online representations and post-experience replay stay intact (Jadhav et al. 2012). If plasticity does run offline, then the fast store is **refining its own content between exposures** — signal amplified, noise attenuated, before anything reaches cortex — and no machine replay buffer does anything of the kind.

---

## The jobs the wiki now assigns to one mechanism

| Job | Where | Sampling criterion it implies |
|---|---|---|
| **Interleaving** — decorrelate a sequential stream for a slow learner | [[wiki/concepts/complementary-learning-systems.md]] | Uniform, or reward-prioritised |
| **Consolidation** — move instance structure into meta structure | Gap G14 | Generalisability (this page) |
| **Planning** — roll out candidate trajectories at a choice point | [[wiki/concepts/simulation-based-planning.md]] | Value of information (Mattar & Daw 2018) |
| **Offline state-space construction** — path-integrate away from a reward to attach a goal-vector cell to every location | [[wiki/entities/tolman-eichenbaum-machine.md]], [[wiki/concepts/cognitive-map.md]] | Coverage of the space |
| **Amortization** — compile model-based rollouts into cached values | [[wiki/concepts/amortized-inference.md]] | Where the cache is stale |
| **Structural organisation** — train a generative model so that sequences are organised *into* a structure, i.e. learn `g` itself | [[wiki/entities/tolman-eichenbaum-machine.md]] (Whittington et al. 2020) | Whatever the generative model would sample — the wake-sleep criterion |
| **Edge construction** — write a *new* edge between two items never experienced together, and fire it in reverse to push value back along it | Section below (Barron et al. 2020) | Logical composability × reward: pairs that close a chain into a profitable outcome |

**The sixth job is the strongest architectural claim.** TEM's learning scheme is wake-sleep shaped — an inference network awake and observing, a generative network checking offline whether what was inferred is what it would have predicted — and hippocampal replay does appear to sample from a generative model rather than to rehearse recorded episodes. The proposal is therefore that replay's *fundamental* role is the organisation of sequences into structures, which makes replay the training signal for the structural code rather than a rehearsal of the instance store (Whittington et al. 2020). If true, jobs 1 and 2 are downstream of job 6 rather than alongside it.

**(brainstorm)** Seven jobs, seven incompatible sampling distributions, one substrate — and the newest of them (edge construction) is the only one whose output is *not* a resampling of anything stored. Either the brain arbitrates between them — in which case the arbitration policy is a missing component nobody has named — or the criteria coincide more than they appear to. [[wiki/concepts/successor-representation.md]] offers the only unification currently in the wiki: all five could be the *same eigenbasis* under different diagonal reweightings `ϒ`, which converts the arbitration problem into choosing one vector. That is the cheapest available hypothesis and it is testable — fit one basis, then check whether consolidation-replay and planning-replay differ only in `ϒ`.

---

## Ripples write edges that were never traversed

Every row above concerns *which* experienced sequence is resampled. Barron et al. 2020 is the wiki's first recording where ripple content is a pair that **was never experienced at all** — the transitive closure of two separately learned associations, formed offline, over days.

**The task** (sensory preconditioning, run identically in 22 humans under 7T fMRI and in mice with dorsal-CA1 tetrodes + optogenetics, one stage per day):

| Day | Contingency | Point |
|---|---|---|
| 1 | `Xₙ → Yₙ` (tone → light), no outcome | Learn one edge |
| 2 | `Yₙ → Zₙ` (light → sucrose for set 1, water for set 2) | Learn the adjacent edge |
| 3 | `Xₙ` alone | Test the composed edge `X₁ → Z₁`; both species show the reward-seeking bias |

**Offline result — ripples acquire the shortcut, not the chain.** Comparing early to late recording days, in awake SWRs:

| Measurement | Result | What it rules out |
|---|---|---|
| Triplet `X₁,Y₁,Z₁` coactivation in one ripple | Increases for reward set 1, not for neutral set 2 | Reward-blind consolidation |
| Triplet `X₁,Y₂,Z₁` — same endpoints, *wrong* intermediary | Increases equally | Ripples simulating the learned model `X₁→Y₁→Z₁`; the endpoints, not the path, are what is being linked |
| Pair `X₁,Z₁` with `Y₁` **absent** from the ripple | Increases with experience, and beyond the change in `X₁`-alone or `Z₁`-alone ripple rate | A rate artefact of reward cells firing more |
| Cross-set pair `X₂,Z₁` | No comparable increase | "Everything gets linked to reward" |
| Spike order within the ripple | `Z₁` cells fire **before** `X₁` cells — reverse to the inferred direction; no bias for the neutral set; absent in sleep | Ripples rehearsing the inference in the direction it will be used |
| Sleep vs awake | Same pattern, lower fidelity; reverse ordering awake only | Sleep as the privileged consolidation window for this operation |

**Read as a write rule:** the ripple is not resampling a trajectory, it is *computing the composition* `X→Y ∘ Y→Z ⟹ X→Z` and storing it as a direct edge — and the reverse firing order is the natural sign that what is travelling is credit rather than prediction, in the same direction as reverse replay after reward in space. This is the wiki's first direct evidence for the write half of the edge-construction claim [[wiki/concepts/latent-graph-discovery.md]] needs: a graph estimate that contains edges the agent never traversed, built between exposures, gated by whether closing the chain pays.

**The online half is a separate mechanism, and it does *not* compute the shortcut.** At the moment of inferential choice, hippocampal patterns (voxels in humans, spikes in mice) during `Xₙ` resemble the associated `Yₙ` and not the cross-set `Yₘ` — with mouse `Y`-cells spiking *after* `X`-cells, preserving the temporal order learned on day 1 — while the inferred outcome `Zₙ` is **not** decodable in hippocampus in either species, and optogenetic dCA1 silencing during `Xₙ` abolishes the inference bias while sparing first-order conditioned responding to `Yₙ`. So one substrate runs two different computations on the same knowledge: **chained mnemonic recall online** (retrieve the next link, one hop, temporally ordered) and **shortcut caching offline** (skip the link, store the endpoints, reverse-ordered). The wiki had been treating these as the same trajectory-generation machinery under different sampling policies; here they are dissociated *within one task*, by direction of firing and by content.

**Where the answer lives is not where the recall lives.** Whole-brain 7T searchlight puts the representation of the inferred outcome `Zₙ` in medial prefrontal cortex and putative dopaminergic midbrain — present even for the neutral outcome, so it is a sensory-identity code and not a value signal, and conditional on which cue predicted it, so it is computed online from a task model rather than transferred to `X` at encoding. Two consequences for a builder: **(i)** the fast relational store supplies *links*, and the composition is completed downstream, which is an argument against architectures that recirculate within the memory module until an answer appears; **(ii)** the midbrain acquiring an identity code for an outcome never paired with the cue is not producible by temporal-difference learning, and the SWR shortcut is the paper's proposed teacher for it **(brainstorm — the hippocampus→midbrain training-signal direction is hypothesised, not recorded here)**.

**(brainstorm) The cheapest machine import in this ingest is a rest-phase closure operator on the replay buffer.** Sample two stored transitions sharing an endpoint, emit the composed pair as a *synthetic* training item, and accept it with probability rising in the value of the terminal state. That is Dyna with composition instead of resampling, it needs no new representation, and Barron's controls give it three falsifiable properties: composition should survive substituting the intermediary, should not fire for value-mismatched pairs, and should update the *earlier* item from the later one.

---

## What replay costs in wiring: `c · M ≈ const`

Sammons et al. 2023 asks the quantitative version of the mechanism question — *how much recurrence does a sequence need to replay at all?* — in a spiking network built to the measured CA3 statistics.

| Model element | Setting |
|---|---|
| Population | `N` excitatory adaptive integrate-and-fire + `N/4` inhibitory; random E→E with probability `c` |
| Weights | Log-normal, SD = 4× mean (median set 50× below the 99th percentile) — the measured EPSP distribution, many negligible synapses and a few dominant ones |
| Memory | 10 assemblies of `M` cells, chained into a sequence by raising **<1%** of E→E weights to the 99th percentile — the sequence is embedded *in* the background distribution, not on top of it |
| Balance | Inhibitory STDP on I→E (Vogels-type, target rate 5 spikes/s) run until the net reaches an asynchronous-irregular state, then frozen |
| Probe | 150 pA / 5 ms to half of assembly 1; success = each assembly peaks at 60–360 spikes/s with consecutive peaks 1–20 ms apart |

**The result is a boundary, not a point.** Successful replay requires a minimum connectivity, and that minimum is set almost entirely by assembly size: the success frontier fits **`c · M = const`**. Network size `N` enters only weakly (bigger nets need slightly more of either), and raising the sequence weight lowers the minimum `M`. At the measured `c ≈ 8.8%` replay succeeds over a wide parameter range **with purely random connectivity** — no enrichment of disynaptic motifs, which is what the low-connectivity (0.9%) account needed to make completion work at all ([[wiki/empirical-tensions.md]] T49).

**Read as an exchange rate for a builder (brainstorm).** `c · M = const` says wiring density and representational redundancy are *substitutes* at fixed replay reliability: halve the connection probability and each memory must recruit twice the cells. With disjoint assemblies the number of storable sequences goes as `~N/M ∝ N · c`, so the product that matters is total recurrent synapse count — the same conclusion the capacity equation `p_max ≈ kC/(a ln(1/a))` reaches from the attractor side ([[wiki/entities/rolls-treves-hippocampal-model.md]]), now derived from *sequence propagation* rather than from fixed-point storage. Two design corollaries the wiki's replay buffers ignore: **(i)** the sparser the recurrence, the larger the minimum item — there is a floor below which a memory simply cannot be reactivated, and it is a wiring property, not a learning-rate property; **(ii)** the balancing step is load-bearing and separate from the memory — inhibitory plasticity is what keeps the network in the regime where an injected pulse propagates instead of igniting or dying, which is a second, so-far-unnamed job for the inhibitory-plasticity mechanism this page already credits with *filtering* replay.

**And the embedding is nearly free.** Strengthening <1% of synapses to a value already inside the tail of the natural weight distribution is enough to encode a ten-step sequence, leaving the weight histogram essentially unchanged. A stored memory is therefore not detectable as an anomaly in the weight statistics — which is why connectomics alone cannot read out content, and why a machine store using a heavy-tailed weight prior can write sequences without perturbing its own initialization **(brainstorm)**.

---

## Why this matters for a reasoning model

- **Replay is the only mechanism in the wiki that edits the training distribution from inside the agent.** Everything else on the control surface ([[wiki/concepts/three-component-framework.md]]) — architecture, objective, learning rule, data — is set by the builder. Replay is a *learned curriculum generator*, and gap G32 (nothing designs the experience stream) is exactly the slot it fills.
- **Selection is a structural bias, so it can encode `g`-preference where the objective cannot.** G16 says the intended graph is not identifiable from one environment's data; the replay filter acts across the *offline* period with knowledge of what recurred, which is a second environment's worth of information applied to the first. Suppressing the non-recurring stimulus is a mechanism that prefers the structural rule over the shortcut without ever computing an objective that distinguishes them **(brainstorm)**.
- **A single exposure already produces replay**, so the fast store is queryable immediately; the specific→general transition is then a property of the *filter's* maturation, not of the store's.

---

## Open problems

- **No arbitration policy across the jobs** above.
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
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the dissenting schedule above, plus the mechanism replay must operate through: completion in a diluted CA3 attractor within a single theta cycle (~120 ms), and a polysynaptic reverse hierarchy to get the reinstated pattern back to cortex; and the two pages now price the same wiring from opposite ends — its `p_max ≈ kC/(a ln(1/a))` counts fixed points storable at a given fan-in, while `c · M ≈ const` counts what fan-in a *sequence* needs to propagate, both landing on total recurrent synapse count as the budget.

- **[[wiki/concepts/complementary-learning-systems.md]]** — this page is the content of that page's coupling channel: CLS says replay transports episodes to cortex, and the transport turns out to be lossy *by design*, suppressing non-generalisable items rather than sampling experience faithfully.
- **[[wiki/concepts/synaptic-plasticity.md]]** — supplies the write rules replay operates on (symmetric CA3 STDP for bidirectional sequences, inhibitory plasticity for the filter), and receives from this page the theta-cycle compression that lets a millisecond plasticity window see second-scale behavioural transitions.
- **[[wiki/concepts/simulation-based-planning.md]]** — forward replay at choice points is that page's rollout mechanism; this page adds that most replay is *not* about the imminent path, so rollout and consolidation cannot be the same sampling policy.
- **[[wiki/concepts/latent-graph-discovery.md]]** — replay is where edges get written: sequential pairwise relationships accumulated offline are the adjacency of the instance-graph, and the filter decides which candidate edges survive into the meta-graph.
- **[[wiki/concepts/successor-representation.md]]** — offers the one available unification of replay's competing sampling policies: one eigenbasis with a per-use diagonal reweighting `ϒ`, of which replay statistics are one setting.
- **[[wiki/concepts/successor-representation.md]]** — and a second, mechanistic link: balanced forward/reverse replay under an asymmetric write rule builds the *time-reversible* SR, so replay direction statistics set whether the consolidated map encodes the policy or the geometry (Keck et al. 2025).
- **[[wiki/concepts/cognitive-map.md]]** — replay respects the current barrier configuration and preserves topological rather than metric adjacency, which is direct evidence that the thing being replayed is the graph and not the trajectory.
- **[[wiki/concepts/amortized-inference.md]]** — the fifth job: offline reactivation compiling model-based rollouts into cached values, using the same machinery with a staleness-driven sampling criterion.
- **[[wiki/concepts/amortized-inference.md]]** — and the strongest biological instance of that job: awake ripples cache a two-hop composition as a one-hop link, which is amortization of an inference the animal can also perform online by chained recall (Barron et al. 2020).
- **[[wiki/entities/temporal-context-model.md]]** — the rival account of the same behaviour: TCM derives transitive-like performance from retrieved-context overlap *inside* the medial temporal lobe, whereas the ripple result puts the composed link in hippocampus and the inferred outcome downstream in medial prefrontal cortex and midbrain ([[wiki/empirical-tensions.md]] T48).
- **[[wiki/concepts/continual-learning.md]]** — rehearsal is the machine form of this mechanism, and this page supplies the selection rule that machine rehearsal lacks: consolidating everything overfits, so the generator must cull.
- **[[wiki/concepts/event-segmentation.md]]** — the same unsolved discretisation, one level up: that page asks what licenses a new node, this one asks what sets the boundaries of a replayed *sequence*.
- **[[wiki/concepts/three-component-framework.md]]** — replay is a fifth lever the control surface does not list: an internally generated curriculum, learned rather than designed.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — supplies replay's fourth job (offline path integration to attach goal-vector cells to every location), which makes replay pattern a model prediction rather than an observation; and its sixth, in which offline generative sampling is what *builds* the structural code, so replay would be how `g` is learned rather than how episodes are rehearsed.
- **[[wiki/concepts/pattern-separation-completion.md]]** — completion is what makes replay possible at all (a partial ripple-triggered cue reinstates a whole stored sequence), and the filter described here is the first mechanism that decides *which* completions are worth performing.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — offline reactivation is generative-model sampling with the sensory input clamped off, which is the same forward pass the free-energy account uses for imagination, run for a learning rather than a control purpose.
- **[[wiki/entities/temporal-context-model.md]]** — supplies a mechanism replay could exploit: re-presenting an item reinstates the context surrounding it, which is how offline reactivation could propagate transitive structure across pairs that were never experienced together.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — a sixth candidate job for the same substrate, and the only one that makes alternation itself the computation: one hidden state sampled per theta cycle turns rapid map flickering into a posterior sample, predicting that switching rate declines as evidence accumulates.
- **[[wiki/entities/spiking-tem.md]]** — the mechanistic dissociation this page's theta row lacked: in a trained spiking cognitive map, a learnable neuromodulatory gain drives spikes *earlier* (phase precession, 100% of grid cells when it alone is on) while oscillatory inhibition pins them to a fixed phase (phase locking, 100% when it alone is on), and the recorded MECII-precesses/MECIII-locks mixture appears only with both — so the compression this page relies on has two named, separately dialable causes.
- **[[wiki/concepts/population-geometry.md]]** — a second candidate unification of the competing sampling policies, from the online side: a sequence is fully accounted for by a path on a ~5-dimensional population manifold (identity at TPR 0.87 / FPR 0.14, and timing from path length), so if replay runs on the same surface then the seven jobs become seven trajectory distributions over one geometry rather than seven ways of selecting stored episodes.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — gives this page's "inhibition sets ripple firing order" claim cell-type resolution: the four interneuron families have distinct ripple phase preferences and modulation magnitudes, and while all increase on average, ~25% of *Id2* neurons and the *Id2-Sncg* (cholecystokinin-basket-like) subfamily are *suppressed* during sharp-wave ripples — so the candidate substrate of the replay filter is a differentiated set of channels, not one inhibitory pool.
- **[[wiki/entities/stp-flickering-cann.md]]** — awake re-expression of a representation the current input does not support, at theta rather than ripple timescale and driven by short-term synaptic state rather than by reactivation: the same recurrent network, a different clock and a different trigger.
- **[[wiki/entities/dense-sequence-memory.md]]** — prices the substrate replay runs on: a trajectory can be re-expressed only for as many steps as the sequence capacity allows, and because the transition/sequence capacity gap can diverge with network size, reliable single-step reactivation is no evidence that the whole trajectory replays.
