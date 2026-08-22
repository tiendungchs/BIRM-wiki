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

**That last claim, now unpacked from the source.** In a teacher–student–notebook model where reactivations *are* the slow learner's gradient steps, the optimal number of reactivations is finite and set by the predictability (SNR) of the relation being replayed: monotonic improvement only at infinite SNR, an interior optimum at intermediate SNR, and zero at low SNR, where continued replay drives generalization *below chance*. So the replay budget is a per-relationship ration rather than a per-episode allocation, and "how much to replay" is a separate control variable from "what to replay" — one this page's seven-way arbitration does not have a slot for ([[wiki/concepts/generalization-optimized-consolidation.md]]).

**A normative derivation of the same criterion, from a different direction.** If experience mixes patterns of synaptic update that *recur* with patterns that occur once, no synapse can tell them apart but the population can — so the optimal filter gates the long-term write on the fast store's own recall of the proposed update, and the resulting selection is exactly "keep what recurs, drop the one-off" (Lindsey & Litwin-Kumar 2024, [[wiki/concepts/recall-gated-consolidation.md]]). Two things this changes for this page. First, the Terada et al. 2022 row above stops being a curiosity: fixed-location cues are the *reliable* memories and randomly presented cues are the unreliable ones, so their differential ripple recruitment is the gate operating. Second, the criterion **does not require an offline period** — the gate is evaluated event-by-event at encoding, and selective replay is one implementation of it rather than its definition, which weakens the case that consolidation *must* be scheduled offline ([[wiki/empirical-tensions.md]] T34).

**And it has now been tested in a machine, with the prioritisation baselines run as controls** (Kessler et al. 2023, [[wiki/entities/continual-dreamer.md]]). A DreamerV2 agent learning 4–8 grid-world tasks in sequence, buffer management swept:

| Rule | Where it acts | Outcome |
|---|---|---|
| **Reservoir sampling** — store with probability `min(n/t, 1)`, i.e. uniform coverage of everything seen | admission | **Best.** Robustly mitigates forgetting; keeps the most uniform task distribution in the buffer |
| First-in-first-out | admission | Early tasks are gone from the buffer by 4M steps |
| Coverage maximisation — priority = median `L²` distance to 1000 stored trajectories | admission | Less forgetting than FIFO but inconsistent on performance, and it *drops the intermediate* tasks whose embeddings resemble the first |
| **Reward-proportional sampling** | mini-batch | **No improvement over uniform random** |
| **Uncertainty-proportional sampling** — episodes weighted by the model's own ensemble disagreement, the surprise/TD-error analogue | mini-batch | **Worst: performs like the non-continual baseline** — low performance, low transfer, high forgetting |

So the two machine-standard prioritisation criteria — reward and surprise — are the two that fail, and the rule that wins is the one whose only objective is even coverage. This is position B of [[wiki/empirical-tensions.md]] T30 arriving from reinforcement learning rather than from electrophysiology.

**One caveat that generalises past this system.** The reservoir rule is uniform over *episodes*, and episodes are not equal-sized: a mastered task emits short trajectories, a new one emits long ones (to a 100-transition cutoff), so each admission evicts several old episodes and the early tasks thin out anyway. Under deliberate task imbalance (0.4M steps then 2.4M into a 0.4M buffer) it forgets the first task exactly as badly as FIFO. **Uniform coverage of the arrival process is not uniform coverage of anything one wants covered** — and naming the partition one *does* want covered is what every task-agnostic method is trying to avoid.

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

**A sequence generator that stores no sequence.** Every candidate above reads out a *learned* transition structure. A continuous attractor with a slow adaptation current needs none: the adaptation destabilises whatever is currently active, so above `m = τ/τ_v` the bump sweeps the manifold spontaneously and, in principle, visits every stored state (Li, Chu & Wu 2024, [[wiki/entities/adaptive-cann.md]]). Two things this buys and one it does not. It supplies **exhaustive retrieval** — a memory-search primitive with no cue and no index — and, when the adaptation gain is noisy and parked near its threshold, the step-size distribution becomes a power law `p(‖Δz‖) ∝ ‖Δz‖^{−1−α}` with `α = 1 + 2μ/γ²`, i.e. Lévy flight, which matches reported statistics of place-cell reactivation during immobility and is the search strategy that is optimal for sparse targets. What it does not buy is *content*: the order visited is the geometry of the manifold, not the order of experience, so this mechanism can explain the never-observed and remote sequences on this page while being unable to produce a veridical replay at all. That makes it a candidate for the exploratory tail of the replay distribution rather than for consolidation **(brainstorm)**.

**The measured hippocampus→cortex coupling is very weak, and the review that reports it says so** (O'Reilly et al. 2011, on Ji & Wilson 2007). The whole consolidation story rests on hippocampal and cortical replay being *coordinated*; the counts are:

| Quantity | Cortex | Hippocampus |
|---|---|---|
| Candidate events meeting minimal criteria | 5,808 | 1,555 |
| Statistically significant replay events | 366 | 121 |
| **Coordinated cortical–hippocampal activations** | **9** | |

Statistically significant, magnitudinally tiny. The review's own verdict: "it remains unclear how much actual consolidation this level of actual replay could support." Two readings, and the wiki should carry both — either the transported quantity per event is large (a single coordinated event moves a whole schema, not a gradient step), or the measurement is missing most of the traffic, which the off-manifold ripples above independently suggest. **The causal evidence is in better shape than the correlational**: stimulating rat hippocampus at sharp-wave onset degrades radial-maze performance against a yoked control receiving the same stimulation uncoupled from ripples (Girardeau et al. 2009). **(brainstorm)** For a builder the ratio is the interesting number — if 9/366 is the real coupling rate, then a machine consolidation loop that replays *every* buffered item into the slow learner is running the channel three orders of magnitude harder than the system it copies, which is exactly the over-replay regime that drives generalization below chance ([[wiki/concepts/generalization-optimized-consolidation.md]]).

**REM sleep may run the channel backwards, to protect what is already stored** (Norman, Newman & Perotte 2005; Buzsáki 2002; Louie & Wilson 2001). The proposed division:

| Stage | Direction | Content | Job |
|---|---|---|---|
| Slow-wave sleep | Hippocampus → neocortex | Recent experience | Consolidate the new |
| REM | Neocortex → hippocampus, plus endogenous CA3 activity | **Already well-learned** patterns | Reduce forgetting — re-equalise the strength of old memories against newly added ones |

The mechanism proposed for the REM half is not replay-as-rehearsal but **oscillating inhibition** on the theta rhythm, with the sign of plasticity keyed to the phase: in the low-inhibition half-cycle, units belonging to *competing* traces intrude and are **weakened**; in the high-inhibition half-cycle, units that should belong to the target trace fall silent and are **strengthened**. The net effect is re-encoding for lower overlap — interference reduced by editing the stored patterns, complementary to the architectural separation that prevented it at write time ([[wiki/concepts/encoding-retrieval-alternation.md]], [[wiki/concepts/pattern-separation-completion.md]]).

**This is a distinct job — the eighth in the table below — and the only one that is not about new information at all.** Every row in the jobs table below transports, plans, constructs or tags something about recent experience. This one spends offline budget on *old* content, with no new data involved, purely to keep the store's existing items separable — the maintenance operation no machine replay buffer performs, and the direct ancestor of the "consolidating everything overfits" result.

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
| **Maintenance / re-equalisation** — re-encode *already stored* patterns to reduce their mutual overlap and restore the strength of old items against new ones | Section above (Norman et al. 2005), proposed for REM | Whatever is already well learned — no dependence on recent experience at all |

**The sixth job is the strongest architectural claim.** TEM's learning scheme is wake-sleep shaped — an inference network awake and observing, a generative network checking offline whether what was inferred is what it would have predicted — and hippocampal replay does appear to sample from a generative model rather than to rehearse recorded episodes. The proposal is therefore that replay's *fundamental* role is the organisation of sequences into structures, which makes replay the training signal for the structural code rather than a rehearsal of the instance store (Whittington et al. 2020). If true, jobs 1 and 2 are downstream of job 6 rather than alongside it.

**(brainstorm)** Eight jobs, eight incompatible sampling distributions, one substrate — and the newest of them (edge construction) is the only one whose output is *not* a resampling of anything stored. Either the brain arbitrates between them — in which case the arbitration policy is a missing component nobody has named — or the criteria coincide more than they appear to. [[wiki/concepts/successor-representation.md]] offers the only unification currently in the wiki: all five could be the *same eigenbasis* under different diagonal reweightings `ϒ`, which converts the arbitration problem into choosing one vector. That is the cheapest available hypothesis and it is testable — fit one basis, then check whether consolidation-replay and planning-replay differ only in `ϒ`.

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

## Awake ripples tag, sleep ripples transfer — a two-stage schedule

> **Provenance.** `raw/talk-nd-memory-gating.txt` — explainer talk on a 2025 *Science* paper; authors and title not stated in the talk, and the paper itself has not been read. Everything in this section is **(tentative)**.

Every job above asks *what* is resampled offline. This source splits the offline period in two and gives the awake half a distinct function: **awake ripples do not consolidate, they select.**

**Task and readout.** Mice alternate arms in a figure-8 maze (reward alternates left/right) across days of run → sleep → run; ~400 CA1 cells recorded. UMAP is fitted **only to running activity**, yielding a looped manifold that reproduces the maze layout without ever seeing position, with a second, systematic drift across trial number (learning progression). Ripple population vectors are then projected onto that behaviourally-fitted manifold, so ripple *content* is read out as a (position, trial) coordinate.

| Observation | Reading |
|---|---|
| Awake ripples at the reward site project onto the manifold as compressed replays of **the trial just completed** — trial index decodable, not merely position | Awake replay is recency-locked to the specific successful trajectory, not a generic map sample |
| Sleep ripples after learning project onto the **same trials and locations** as the preceding awake ripples | The awake selection, not experience frequency, predicts what sleep repeats |
| Sleep ripples recorded **before** learning contain unrelated patterns | The correspondence is acquired, not a fixed manifold attractor |
| Awake replay rate is far **lower** than sleep replay rate | Awake events cannot themselves supply the repetitions consolidation needs — they are a pointer, not a transfer |
| Many ripples fall **off** the manifold and are simply undecodable | The method reads only the fraction of replay expressible in the running reference frame; "off-manifold" ≠ noise (other memories, planning, non-spatial content) |

**Why two stages at all**, on the talk's argument: (i) cortex is only receptive in the sleep state, so transfer cannot run on demand; (ii) transfer needs many repetitions, and the awake hippocampus is busy tracking ongoing experience and maintaining the map. So selection is placed where the evidence about importance is (immediately after the event) and transfer where the bandwidth is (sleep).

**The proposed carrier of the tag is local plasticity, and it is unmeasured.** The talk's own hypothesis: awake ripples induce plasticity *within* hippocampus that biases which sequences reactivate during sleep — "carving preferred paths" in the network's dynamics. That is exactly the hole this page names above ("offline plasticity is a hole, not a mechanism"), now load-bearing: with no intrahippocampal plasticity during rest, there is no substrate for a tag that survives hours of intervening behaviour.

**What this adds to the jobs table.** A ninth entry, and the only one whose output is not a training update at all:

| Job | Sampling criterion | Output |
|---|---|---|
| **Tagging** — mark an event during waking for priority replay during sleep | Recency × salience/reward at the moment of the event | A persistent bias on the *later* sampling distribution, not a weight change in the slow store |

This partly dissolves the arbitration problem rather than adding to it: if awake ripples write the priority and sleep ripples spend it, then two of the incompatible sampling policies are **sequential stages of one pipeline** rather than competitors for one budget — awake selection can be reward- and recency-driven (position A of [[wiki/empirical-tensions.md]] T30) while the sleep distribution it seeds is still filtered toward transferable content (position B). It also narrows T34: the *criterion* is computed awake, the *transfer* runs asleep, which is a schedule both Rolls and the ripple recordings can accept.

**(brainstorm) The machine form is a two-timescale priority buffer with no rehearsal at write time.** At the end of each episode segment, emit a *tag* — one scalar per stored item, written online from reward and recency — and do no replay whatsoever during the online phase; then draw the offline rehearsal distribution from the tags rather than from TD-error recomputed at sample time. This differs from prioritised experience replay in exactly the way the biology does: priority is a **stale, cheap quantity fixed at encoding**, never refreshed, which costs accuracy but frees the online phase entirely — the same trade the hippocampus is described as making because it "can't dedicate itself to endless replay". Falsifiable against the wiki: tag priority ∝ excitability ([[wiki/concepts/memory-allocation-excitability.md]]) predicts *cluster*-level tagging, whereas this source's trial-index decoding implies the tag is trajectory-specific.

**Methodological import, independent of the result.** Fitting a low-dimensional manifold on behaviour and then projecting offline events onto it is the first instrument in the wiki that gives replay content a *coordinate* rather than a template match — including a trial index, i.e. a position along the learning trajectory. [[wiki/concepts/population-geometry.md]] had this as an untested prediction (sequences are paths on a manifold, so replay should be too); this is a direct test of it, with the caveat that the manifold is defined by the running data and therefore cannot represent anything the animal never expressed while running.

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
  - **Partly answered for medial prefrontal cortex.** Task spike patterns replay there (and in nucleus accumbens) during post-task rest, **time-compressed** relative to behaviour and **selective for recently learned** events; mPFC reactivation is strongest during low-voltage spindles, hippocampal sharp waves and cortical spindles co-occur within a few hundred milliseconds, and sharp waves correlate with mPFC replay directly. What is *not* settled is direction: some measurements put hippocampal events first, others cortical, and the standing reconciliation is a loop — cortical events initiate hippocampal replay, which then reinforces the ongoing cortical replay (Euston et al. 2012, [[wiki/entities/medial-prefrontal-cortex.md]]). A builder cannot yet write down which module is the scheduler.
  - The same source dates the **critical window**: disrupting mPFC 0–2 h after a task destroys the memory a day or two later, while the same disruption outside that window does nothing — so the transport budget is spent in a short bounded interval, not distributed over the retention period.

---

## A dissent: consolidation should happen awake

Rolls 2013 rejects the sleep-transfer premise this page and [[wiki/concepts/complementary-learning-systems.md]] assume, on three grounds:

| Argument | Claim |
|---|---|
| **Relevance filtering** | Waking recall retrieves memories that are *currently useful*; only those seed semantic structure. Sleep replay has no access to current relevance, so it consolidates where one parked one's bicycle two weeks ago |
| **The dream argument** | Semantic construction during unguided noise-driven stochastic firing risks building the bizarre representations we in fact dream about; rational thought during waking is what organises retrieved episodes into useful semantics |
| **Non-retrieval as forgetting** | Memories *not* retrieved during waking are the ones left to be overwritten by fresh random CA3 allocations — so the retrieval schedule and the forgetting policy are one mechanism |

**The counterweight, in humans and quantitative.** Rolls's argument is normative; the strongest opposing datum is a dose–response one. Across a 50-year age gap, prefrontal NREM slow-wave activity (0.8–4.6 Hz) predicts overnight retention of word pairs at `r = 0.81`, statistically absorbs the effects of both age and medial-prefrontal atrophy on retention, and negatively predicts next-day hippocampal retrieval activation — while sleep duration, sleep efficiency, stage composition, spindle density and circadian and alertness measures predict nothing once age is controlled (Mander et al. 2013). Two things this pins down that the recordings above do not: the consolidation-relevant variable is a **specific oscillation amplitude**, not offline time; and its generator is **cortical, not hippocampal** — mPFC grey matter mediates the whole age effect on SWA while hippocampal volume predicts neither SWA nor retention. Read against Rolls: waking recall cannot be the only channel, because a variable measurable *only during sleep* carries the between-subject variance in what is retained ([[wiki/concepts/complementary-learning-systems.md]], [[wiki/empirical-tensions.md]] T34).

The third point is the one with teeth for a machine: it makes **use frequency the consolidation criterion**, which is neither reward-prioritisation (position A of [[wiki/empirical-tensions.md]] T30) nor the transferability bias (position B). It is also the only criterion of the three that a deployed system can compute without labels or an offline pass. Note that Rolls offers no data — the argument is normative, and the direct recordings all favour ripple-driven offline replay ([[wiki/empirical-tensions.md]] T34).

---

## Connections

- **[[wiki/entities/continual-dreamer.md]]** — this page's selection criterion tested in a machine with the alternatives run as controls: uniform-coverage admission (reservoir sampling) beats first-in-first-out and a distance-based rule, while prioritising the mini-batch by reward gains nothing and prioritising it by the model's own uncertainty is worse than not doing continual learning at all.
- **[[wiki/entities/vector-hash.md]]** — narrows this page's remit: 11 environments learned in sequence with zero forgetting and *no replay of any kind*, because separation in a large prestructured address space already prevents interference. If that holds, replay's job is consolidation and generalisation, not protection of what is already stored.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the dissenting schedule above, plus the mechanism replay must operate through: completion in a diluted CA3 attractor within a single theta cycle (~120 ms), and a polysynaptic reverse hierarchy to get the reinstated pattern back to cortex; and the two pages now price the same wiring from opposite ends — its `p_max ≈ kC/(a ln(1/a))` counts fixed points storable at a given fan-in, while `c · M ≈ const` counts what fan-in a *sequence* needs to propagate, both landing on total recurrent synapse count as the budget.

- **[[wiki/concepts/memory-allocation-excitability.md]]** — the tagging stage above needs a carrier that survives hours of intervening behaviour, and the decaying excitability tag is the wiki's only candidate; the two disagree on granularity — the tag glues a *cluster* of episodes, whereas awake-ripple content decodes to one specific trial.
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
- **[[wiki/entities/spiking-tem.md]]** — the mechanistic dissociation this page's theta row lacked: in a trained spiking cognitive map, a learnable neuromodulatory gain drives spikes *earlier* (phase precession, 100% of grid cells when it alone is on) while oscillatory inhibition pins them to a fixed phase (phase locking, 100% when it alone is on), and the recorded MEC II-precesses/MEC III-locks mixture appears only with both — so the compression this page relies on has two named, separately dialable causes.
- **[[wiki/concepts/population-geometry.md]]** — supplies the instrument that gives replay content a coordinate: fit a manifold on running activity, project ripple population vectors onto it, and read out position *and* trial index — which turns that page's untested "replay is a path on the same surface" prediction into a measurement, at the cost that off-manifold ripples become undecodable rather than absent (`raw/talk-nd-memory-gating.txt`, **(tentative)**).
- **[[wiki/concepts/population-geometry.md]]** — a second candidate unification of the competing sampling policies, from the online side: a sequence is fully accounted for by a path on a ~5-dimensional population manifold (identity at TPR 0.87 / FPR 0.14, and timing from path length), so if replay runs on the same surface then the seven jobs become seven trajectory distributions over one geometry rather than seven ways of selecting stored episodes.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — gives this page's "inhibition sets ripple firing order" claim cell-type resolution: the four interneuron families have distinct ripple phase preferences and modulation magnitudes, and while all increase on average, ~25% of *Id2* neurons and the *Id2-Sncg* (cholecystokinin-basket-like) subfamily are *suppressed* during sharp-wave ripples — so the candidate substrate of the replay filter is a differentiated set of channels, not one inhibitory pool.
- **[[wiki/entities/stp-flickering-cann.md]]** — awake re-expression of a representation the current input does not support, at theta rather than ripple timescale and driven by short-term synaptic state rather than by reactivation: the same recurrent network, a different clock and a different trigger.
- **[[wiki/entities/dense-sequence-memory.md]]** — prices the substrate replay runs on: a trajectory can be re-expressed only for as many steps as the sequence capacity allows, and because the transition/sequence capacity gap can diverge with network size, reliable single-step reactivation is no evidence that the whole trajectory replays.
- **[[wiki/entities/adaptive-cann.md]]** — a generator for spontaneous sequences that stores no sequence: raising adaptation gain past `τ/τ_v` makes the bump sweep the manifold on its own, and parking the gain *at* the threshold with noise on it yields power-law step sizes (`α = 1 + 2μ/γ²`), matching reported Lévy statistics of place-cell reactivation during immobility — replay content as a dynamical regime rather than as a read of stored order.
- **[[wiki/entities/boltzmann-machine.md]]** — gives free-running offline activity a term in an objective: the negative phase `⟨s_i s_j⟩_free` cannot be measured from data at all, so sampling from one's own generative model is *required* by maximum likelihood, and it enters the weight update with a minus sign (the unlearning reading of sleep).

- **[[wiki/concepts/memory-allocation-excitability.md]]** — a candidate content-blind sampling prior for this page's seven-way arbitration: cells carrying a CREB-dependent excitability tag are predicted to dominate sharp-wave-ripple participation, so replay priority would be a decaying per-cell scalar set at encoding rather than a value-of-information computed at rest. The middle link is unmeasured, and it is the whole of the assembly-consolidation hypothesis (Lisman et al. 2018).
- **[[wiki/concepts/recall-gated-consolidation.md]]** — supplies the normative theory behind this page's measured filter: "keep what recurs" is optimal because reliable and unreliable synaptic updates are separable only at the population level, and the separating statistic is the fast store's own recall of the update. It also detaches selection from the offline schedule — the same gate runs event-by-event during waking, with selective replay only one possible implementation (Lindsey & Litwin-Kumar 2024).
- **[[wiki/concepts/manifold-constrained-learning.md]]** — the counter-case to this page's forward-*and*-reverse replay: in M1, macaques cannot volitionally emit a learned trajectory in reverse even under a corridor constraint that makes reversal the only way to be rewarded, so reversibility of a population sequence is an area- and regime-specific property — plausibly bought here by CA3's symmetric spike-timing kernel and offline, not online, generation (talk-nd-brain-learning-limits, **(tentative)**; [[wiki/empirical-tensions.md]] T80).
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — turns this page's borrowed aside ("consolidating everything overfits") into the derivation behind it: replay reactivations are the gradient steps, their optimal *number* is finite and set by the predictability of each relation, and past that number the slow learner's generalization falls below chance — so the replay budget is rationed per relationship rather than allocated per episode (Sun et al. 2023).
- **[[wiki/concepts/complementary-learning-systems.md]]** — prices this page's channel from the *receiving* end: the slow-wave amplitude that predicts overnight retention is generated by medial prefrontal cortex, so how much gets replayed into cortex is a state variable of the slow learner rather than a property of the store, and it degrades with cortical atrophy while the hippocampus is intact (Mander et al. 2013).
- **[[wiki/concepts/engram.md]]** — adds an edge-writing job to this page's list: repeated *simultaneous* reactivation of two initially disjoint traces grows their population overlap and creates a shared assembly that carries the link and not the content, so any replay that co-activates two memories is editing the graph, not only strengthening its nodes **(tentative)**.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the receiving end of this page's channel, measured: time-compressed, recency-selective replay in the cortical target, phase-tied to hippocampal sharp waves through cortical spindles, inside a 0–2 h post-task window outside which disruption has no effect.
- **[[wiki/concepts/schema-assimilation.md]]** — adds an online, encoding-time member to this page's list of jobs: while a human encodes an overlapping B–C pair the prior A associate is reinstated into the episode, and the resulting mnemonic conflict — not its absence — predicts successful later inference, so replay here manufactures the conflict that drives integration instead of resolving it offline.
- **[[wiki/concepts/inter-areal-synchrony.md]]** — the measurement caveats that apply to every sharp-wave/spindle coupling result here: co-occurrence within a few hundred milliseconds is a cross-correlation statistic, field-potential-only measures volume-conduct, and a correlation between two structures survives cutting the wire between them, so co-occurrence alone does not establish transfer.
- **[[wiki/entities/spacetime-attractor.md]]** — a new consumer for replay: a spacetime attractor needs one copy of the adjacency matrix between every pair of consecutive delay-subspaces, which is redundant to learn independently, so hippocampus→cortex replay of experienced trajectories is proposed as the shared training cache that writes all copies from the same data (Jensen et al. 2026).
- **[[wiki/entities/pfc-columnar-planning-model.md]]** — a forward trajectory sequence generated without an episodic store: the anterograde path wave lays out the planned state order in advance (prospective units anticipating place units, sequence-order ranking as in monkey prefrontal cortex) using only synaptic propagation, so sequence generation need not be resampling of stored experience (Martinet et al. 2011).
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the wire the cortical end of replay runs on: prefrontal replay is time-compressed, selective for rewarded routes and coupled to hippocampal sharp waves through spindles, with the initiating direction still unresolved.
- **[[wiki/concepts/default-self-model.md]]** — a competing claim on the same resource: the idle period this page spends consolidating experience into transferable structure is the same "cognitive downtime" the default self-model is said to spend updating a competence inventory, and nothing in the wiki splits the budget.
- **[[wiki/entities/default-mode-network.md]]** — a third claimant on the same idle budget, and the source of the only causal-grade mechanism in its review: hippocampal ensembles sweeping ahead down each arm at a high-cost choice point (~10% of the dwell time) and back down the correct path after errors.
- **[[wiki/concepts/encoding-retrieval-alternation.md]]** — the same oscillatory scaffold running online: theta phase sets encode-vs-retrieve during behaviour, and the sleep model above is that mechanism repurposed offline with the plasticity sign, rather than the drive, flipped across the half-cycles — so one clock serves error-driven learning awake and interference reduction asleep (Norman et al. 2005, 2007).
- **[[wiki/entities/cn-dpm.md]]** — the anti-replay datum, from a buffer of the same size run under both policies: extending each task from 1 to 10 epochs *lowers* reservoir-sampling replay (44.00 → 43.82) and *raises* an expansion learner whose buffer is discarded at every consolidation (45.21 → 46.98), because a fixed sample re-presented as the past is something the learner can overfit and transient scaffolding is not.
