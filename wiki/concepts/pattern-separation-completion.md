# Pattern Separation and Completion

**One knob, not two mechanisms: a network's *transfer function* mapping input similarity to output similarity. Push output apart where input overlaps (separation) and you can store two similar episodes without interference; pull it together (completion) and you can retrieve a whole episode from a fragment.**

The pair is the hippocampus's answer to the write/read conflict that every fast store faces: the same code that makes storage interference-free makes retrieval from a partial cue fail, and vice versa. Yassa & Stark 2011 is the wiki's evidence base for the claim that this is a real, localisable computation rather than a modelling convenience.

---

## The formalism

Let `s_in` be the similarity of two input patterns and `s_out` the similarity of the representations they evoke. The identity line `Δs_out = Δs_in` is the reference; the *computation* is the deviation:

| Regime | Condition | Effect |
|---|---|---|
| **Separation** | `Δ output > Δ input` — similarity is decreased | Overlapping inputs stored orthogonally; no catastrophic interference |
| **Completion** | `Δ output < Δ input` — similarity is increased | Degraded or partial cues filled in to the stored pattern; generalization over noise |
| **Linear** | `Δ output = Δ input` | Neither; the region relays |

**Two consequences the wiki should carry forward:**

1. Separation and completion are **not** binary region labels. The *same* region does both, at different points on its transfer curve — CA3 completes for small input changes and separates for large ones. What identifies a region is the *shape* of the curve, not which side of the diagonal it sits on.
2. A measurement of the output alone is uninterpretable. Separation is defined relative to the *upstream* input, so claiming a region computes separation requires recording what it received. "Region X's codes were dissimilar" is compatible with X relaying already-dissimilar input.

---

## Where it happens: the trisynaptic circuit

Entorhinal cortex (EC) layer II → dentate gyrus (DG) → CA3 → CA1, a primarily feedforward chain with a bypass:

| Pathway | Property | Computational role |
|---|---|---|
| **Perforant path**, EC II → DG | Distributed EC codes onto a far larger, sparsely firing granule-cell population | Expansion recoding — the substrate of strong, domain-agnostic separation |
| **Mossy fibers**, DG → CA3 | Few, very large "detonator" synapses on proximal apical dendrites; strongly depolarizing | *Forces* a separated code onto CA3 — the write path |
| **Perforant path**, EC II → CA3 (bypassing DG) | Weak, direct | Supplies the retrieval *cue* — the read path |
| **Recurrent collaterals**, CA3 → CA3 | Auto-association — and *diluted*, not dense: ~1.2×10⁴ synapses over 3×10⁵ cells = 0.04 (≈2% bilateral), *more* diluted than local neocortex (~0.1) (Rolls 2013). Direct measurement puts local connectivity *above* that assumption: mouse 3D electron microscopy gives 11.2 ± 2.7% within 50 µm of the presynaptic soma, 5.5 ± 1.9% by 250 µm; octuple patch-clamp in the same paper gives 8.8% (103/1,172 tested pairs) with no distance dependence out to 430 µm (Sammons et al. 2023) — against 0.9% in rat (Guzman et al. 2016), [[wiki/empirical-tensions.md]] T49 | Attractor dynamics → completion; dilution is functional, keeping multi-synapse pairs rare so the basins are not distorted — 10% of measured connections are multi-synapse pairs, so the assumption is approximate rather than exact (Sammons et al. 2023) |
| **Schaffer collaterals**, CA3 → CA1 | Contested. Yassa & Stark 2011: CA1 relays linearly, and hippocampal output is not the DG/CA3 signal. Rolls 2013: CA1 recombines the separately-stored sub-parts of an episode by competitive learning and generalizes to the nearest CA1 pattern when CA3 completion was imperfect | Either a linear relay or a second completion stage — [[wiki/empirical-tensions.md]] T33 |

**The write/read dissociation is anatomical, and it is causal.** Inactivating mossy fibers impairs new learning and spares recall; lesioning the direct EC→CA3 perforant path impairs retrieval and spares encoding. So the same recurrent network is addressed by two different inputs depending on whether it is being written to or read from — which is the wiki's first concrete mechanism for a store that does not have to *choose* between separation and completion globally.

## Transfer curves by subfield

| Region | Curve shape | Evidence |
|---|---|---|
| **DG** | Separates at the *smallest* input changes; steeply nonlinear | Simultaneous DG/CA3 recordings under incremental environment morphs |
| **CA3** | Nonlinear but shifted right: completes for small input changes (cue rotation within a room), separates for large ones (different room) | Cue-mismatch recordings, two-environment recordings, and immediate-early gene (IEG) population imaging — three studies that looked contradictory until plotted against input magnitude |
| **CA1** | Linear — neither separates nor completes | Same studies; human high-resolution fMRI — though the human study's own bias score puts CA1 at 0.59–0.83, i.e. completion-biased rather than on the identity line (Bakker et al. 2008, below) |

**Two codes for separation, not one** (DG/CA3 recordings):

| Mechanism | What changes | When |
|---|---|---|
| **Rate remapping** | Firing rates change within a stable place map; new activity pattern largely orthogonal to old | Smaller input change (medial entorhinal input unchanged) |
| **Global remapping** | Rate *and* place statistically independent — complete reorganization | Larger input change (different room) |

**"Statistically independent" is a claim about place cells alone, and it does not survive conditioning on the grid code.** Simultaneously recorded grid and place cells in two cue-different environments retain their relationship across a global remap — grid rate at the place-field peak, and place-peak-to-grid-peak distance, are both correlated across environments (Whittington et al. 2018; [[wiki/empirical-tensions.md]] T39). So separation at the level of the hippocampal population is compatible with *no* separation at the level of the `g`↔`p` mapping, which is what lets a remapped map inherit structure instead of starting over ([[wiki/entities/tolman-eichenbaum-machine.md]]).

Under global remapping the two subfields differ in *kind*: DG re-codes within the **same** active cells, CA3 recruits a **different population**. Whether these are two mechanisms or one continuum, and what selects between them, is stated as open.

---

## Measuring the bias without unit resolution

Bakker et al. 2008 is the wiki's primary human source for the DG/CA3 separation claim, and its transferable contribution is not the localisation but a **scalar estimator of where a layer sits on the transfer curve, computed from mean activity alone** — no unit resolution, no upstream recording, no labels.

Design: 18 subjects, high-resolution fMRI (1.5 mm³), *incidental* encoding — subjects judged whether each pictured object is typically indoor or outdoor, never whether they had seen it. Each trial is one of three types: **first presentation**, exact **repeat**, or **lure** (a slightly different picture of the same object; 144 such sets, plus unrelated foils). Repetition suppression supplies two anchors — activity for a novel item and activity for a known one — and the lure is the probe placed between them:

```
bias = (1st − Lure) / (1st − Repeat)
```

| bias | Reading |
|---|---|
| → 0 | the lure was treated as a novel item — a new code was allocated — **separation** |
| → 1 | the lure was treated as a repeat — the stored code was reinstated — **completion** |

| Region | bias | Lure vs. repeat | Lure vs. first |
|---|---|---|---|
| **CA3/DG** (bilateral) | **0.15** | different, `p < 0.001` both sides | *not* different (`p = 0.075`, `p = 0.871`) |
| CA1 (right), CA1/3/DG (left), subiculum, entorhinal cortex, parahippocampal cortex | **0.59 – 0.83** | not different | different (`p < 0.001` to `p < 0.01`) |

Three things this buys the wiki that the rodent transfer-curve literature does not:

1. **Separation is domain-general, not spatial.** The stimuli are object photographs and the task is not overtly mnemonic or spatial, yet the DG/CA3 bias is as extreme as in place-cell remapping experiments. The fast store's de-aliasing operation is not a navigation mechanism that reasoning would have to borrow — it already runs on arbitrary content.
2. **A cover task is methodologically necessary, not just convenient.** An explicit "old / similar / new" judgement invites a *recall-to-reject* strategy: retrieve the original (completion), then compare it to the stimulus. Any explicit discrimination task therefore measures separation, completion, encoding and retrieval mixed together. The bias score avoids this only because the subject is never asked to discriminate.
3. **The estimator needs only three stimulus conditions and one scalar per site.** **(brainstorm)** The machine version is immediate and cheap: present a model triplets of (novel input, exact repeat, near-duplicate), take any layer's mean activation, and compute the same ratio. It yields a per-layer separation/completion profile with self-generated anchors and no ground-truth labels — i.e. the first runtime-measurable read-out of gap G38's knob, usable both as a diagnostic and as the error signal a controller would descend.

**What the estimator cannot see** (the source's own limits, and they transfer with it):

- It is a *contrast* measure. A layer that separates while holding mean activity constant across the three conditions is invisible to it — a real hazard for machine layers with normalised activations.
- It cannot distinguish separating from *receiving already-separated input*. Sites downstream of a separator score the same as the separator.
- A rate-coding alternative survives: the same population firing at novelty-graded rates, with DG/CA3 simply less tolerant of small changes, would produce the same numbers. The authors argue against it (the pattern is unlike known MTL novelty signals, and rodent recordings do show population re-coding) but do not exclude it.
- fMRI cannot resolve CA3 from DG at any achievable resolution, so the 0.15 is a property of the combined write-and-store stage, not of either alone.

**The CA1 numbers do not say "linear".** [[wiki/empirical-tensions.md]] T33 records this study on the side of "CA1 relays"; what it actually shows is a CA1 bias of 0.59–0.83, i.e. squarely on the *completion* side, statistically indistinguishable from a true repeat. The support it gives position A is only the negative half — CA1 does not separate — and the positive half (CA1 sits on the identity line) is not in this data.

---

## What the curve is worth: the capacity account

Rolls 2013 prices the same two operations in synapses per neuron. The whole point of separation is that correlated patterns *cost capacity*, and the whole point of dilution is that the capacity is spent well.

| Quantity | Form | At biological parameters (rat) |
|---|---|---|
| Population sparseness | `a = (Σr_i/N)² / (Σr_i²/N)` | macaque hippocampal pyramidal `a ≈ 0.33`, against 0.61–0.81 in orbitofrontal/inferior-temporal/amygdala — the hippocampus really is the sparse one |
| CA3 attractor capacity | `p_max ≈ k · C^RC / (a ln(1/a))`, `k ≈ 0.2–0.3` | `C^RC = 12,000`, `a = 0.02` → ~36,000 memories |
| Feedforward (perforant-path) capacity | `p_max ≈ k · C^PA / (a_o ln(1/a_o))` | `C^PA = 3,600` → ~30% of the recurrent route, which is the argument against CA3-as-pattern-associator |

Three consequences for a builder:

1. **Capacity scales with fan-in, not with population size** — so the design move is *more units at lower connection probability*, holding synapses-per-unit fixed. Diluted integrate-and-fire attractors are additionally measured to be *more* stable and more accurate than fully connected ones with the same fan-in.
2. **Sparsity enters as `1/(a ln(1/a))`**, so the separation knob and the capacity budget are the *same* parameter viewed from two ends. Graded (exponential/gamma) firing rates passed through a non-linearity raise effective sparseness — Rolls counts that as a pattern-separation mechanism in its own right.
3. **Heterosynaptic LTD is not optional.** Efficient storage in an associative network requires depression alongside potentiation, and it is also the proposed forgetting mechanism — the store must overwrite or it overloads, and overload loses *all* retrievable memories, not the marginal one.

**Does the capacity account compete with the abstraction account for the same population?** The standard framing says yes: decorrelation buys capacity by pushing patterns apart into a high-dimensional code, and abstraction buys transfer by collapsing them onto a few shared coding directions, so a hippocampus optimised for one is mis-optimised for the other. The one dataset that measures both quantities in one population against a behavioural contrast says the trade-off is not forced — human hippocampal populations became more *disentangled* (cross-condition generalization for latent context and for stimulus identity) and more *expressive* (shattering dimensionality 0.57 → 0.62, the parity dichotomy becoming decodable) in the same sessions, as one-shot inference appeared (Courellis et al. 2024, [[wiki/concepts/population-geometry.md]], [[wiki/empirical-tensions.md]] T50). What changed was which directions are parallel across conditions, not how many directions there are.

**A second capacity account, feed-forward and with an explicit sparsity optimum** (Kanerva 1993, [[wiki/entities/sparse-distributed-memory.md]]). Sparse distributed memory replaces the DG expansion with a random `N → M` expansion (1,000 → 10⁶) and the sparsity knob with a Hamming radius `H`, and then derives what Rolls' `a` is left to fit:

| Quantity | Form | Reading here |
|---|---|---|
| Overlap between two cues' active sets | `p²M` against `pM` for a cue with itself | Separation *before any learning*: the ratio is `1/p ≈ 2,000` at the sample parameters, produced by the dimension of the address space alone |
| Signal / noise of a read | `μ = pM`, `σ² ≈ pM[1 + pT(1 + p²M)]` | Cross-talk grows linearly in stored-item count `T`, so overload is graded, not a cliff |
| **Optimal activation probability** | **`p = (2MT)^(−1/3)`** | The separation bias has a closed-form optimum, and it **depends on how full the store is** |
| Capacity | `τ = T_max/M = 1/[Φ⁻¹(φ)]²` → `≈ 0.10` at `φ = 0.999` | ~10% of locations, *independent of pattern size* |

The third row is the one this page did not have. Every bias-setting proposal in the wiki — cholinergic mode bit, DG↔CA3 closed loop, learned `α`, interneuron vector — treats the target as a fixed point to be tracked; `p ∝ T^(−1/3)` says the target itself **moves as the store fills**, on a known exponent, and it moves further with data statistics (larger by up to ~2× when retrieval cues are noisy, *smaller* when the data are clustered rather than uniform). A machine store knows `T` exactly, so this is the one controller for G38 that needs no error signal at all.

The same source supplies the biological instance of a *runtime* threshold controller: in Marr's cerebellar model the Golgi cells hold 500–5,000 of 200,000 granule cells active regardless of how many inputs are firing — feedback inhibition implementing exactly the "keep the active fraction on target" policy, which is [[wiki/concepts/inhibitory-control-of-coding.md]]'s actuator running against a set point.

**Separation is five mechanisms, not one** (Rolls 2013): sparse mossy-fibre connectivity (~46 per CA3 cell, the *randomizing* effect), sparse DG firing, the large DG population (expansion recoding by competitive learning), sparse CA3 coding, and neurogenesis supplying new random connections. See [[wiki/entities/rolls-treves-hippocampal-model.md]] for the ranked table.

**The randomization mechanism is a different kind of thing from a transfer curve.** A steep transfer function still *computes with* input similarity; mossy-fibre hashing destroys it, handing CA3 an address drawn effectively at random. That is why the mechanism is confined to the write path (strong, proximal, mV-scale synapses that dominate during storage) and switched out of the read path (a numerically large but weak perforant-path input whose job is to *generalize* enough that a fragment lands in the right basin, with recall signal `∝ √C^PA`). **(brainstorm)** For a machine store the prescription is unusual and cheap: **hash on write, embed on read.** Every learned-index retrieval system in use does the opposite — one embedding serving both — and thereby inherits the interference that the write-side randomization exists to remove.

---

## Necessity, not just correlation

| Manipulation | Result | Reads as |
|---|---|---|
| DG lesion (rat) | Fails to re-explore when two objects move 60 cm → 40 cm apart | DG *necessary* for spatial separation |
| NR1 subunit of the NMDA receptor knocked out in DG granule cells | Contextual fear *discrimination* impaired; plain contextual conditioning and water-maze learning spared; CA3 rate remapping disrupted downstream | Separation needs NMDA-receptor plasticity, and the DG's output is what drives CA3 rate remapping |
| CA3 lesion (rat/mouse) | One-trial object-place recall impaired; accuracy collapses when only 1–2 of 4 trained extra-maze cues are present | CA3 *necessary* for completion from a partial cue |
| NR1 knocked out in CA3 | Impaired when familiar cues are removed | Same, plasticity-dependent |
| Ablate adult neurogenesis (x-irradiation) | Impaired at *low* sample-target separation (2 intervening radial-maze arms), unimpaired at high (3–4) | Newborn granule cells matter specifically where separation demand is high |
| Genetically enhance newborn-neuron survival | Better contextual fear discrimination | Gain-of-function in the same direction |

The parametric structure of the last two rows is the methodological point worth importing: the manipulation is scored **as a function of input similarity**, so the claim is about a transfer curve, not about a task.

---

## The knob has a controller

Unregulated separation destroys recall — nothing would ever be recognised as a repeat. The review's Box 1 names the candidate control signals:

| Controller | Direction | Note |
|---|---|---|
| Hilar **mossy cells** (excitatory) | ↑ separation | Under direct CA3→DG backprojection — i.e. the *output* stage sets the *input* stage's bias |
| **HIPP** interneurons targeting the perforant path (inhibitory) | ↓ separation | Same backprojection |
| **Cholinergic** input from medial septum | Switches storage (separation) vs. recall (completion) modes | The closest biological analogue of an explicit write/read mode bit. **Rolls 2013 gives it a functional form:** acetylcholine *reduces the efficacy of the CA3→CA3 recurrent synapses* (Hasselmo) while facilitating LTP in them, so one scalar simultaneously lets the mossy-fibre write dominate firing and licenses the recurrent write. In machine terms: scale recurrent read-out gain **down** and recurrent learning rate **up**, together |
| **Noradrenergic** input from locus coeruleus | Unknown | Innervation of the DG polymorphic layer is orders of magnitude denser than elsewhere in the hippocampus |
| **Interneuron families**, one channel per code feature (CA1) | Separately: ↑↓ generalization (*Sst*), ↑↓ selectivity (*Pvalb*, *Sst*, *Id2*–non-*Sncg*), ↑↓ stability (*Pvalb*), ↑↓ space-rate information (*Vip*, by disinhibition) | The only controller here verified **causally and per feature**: activating one genetically defined family at a time during behaviour changes the named place-field property, and the perturbation matrix correlates with the coupling-based correlational matrix (`p = 0.007`). Millisecond timescale, no weight change, and differentiated where every other row is one scalar (Valero et al. 2025) — see [[wiki/concepts/inhibitory-control-of-coding.md]] |

**(brainstorm)** The cholinergic switch and the CA3→DG backprojection are two different control architectures for the same knob: one *external and global* (a neuromodulator sets the mode for the whole structure), one *internal and closed-loop* (how well CA3 completed the current cue sets how hard DG separates the next input). The second is the interesting one for a machine, because it is a **self-supervised** setting rule — completion error is measurable at runtime without labels, and it is exactly the signal that says "this is a new situation, write it separately" versus "I have this one, retrieve it". Nothing in the wiki implements it (gap G38).

**A third architecture, and it is the one with resolution.** Both of the above set *one* number. The interneuron-family row sets four, one per code feature, and the assignment of channel to feature is not hand-designed — it falls out of how broadly each family is innervated by pyramidal cells (dense → the inhibitory signal averages over contexts and generalizes; sparse → it inherits context specificity and splits). So the separation/completion bias is not a single knob at all but a small vector, and its routing is a wiring property that experience sets ([[wiki/concepts/inhibitory-control-of-coding.md]]). What none of the three supplies is the *controller* that drives the actuator — G38's regress moves back one level rather than closing.

---

## Mapping to the core framing

| Biology | [[wiki/concepts/latent-graph-discovery.md]] element |
|---|---|
| Pattern separation | **De-aliasing** (hardness source 3, gap G2): the same observation at structurally distinct positions must receive distinct codes |
| Pattern completion | **Retrieval / instance binding** (gap G37): find the stored meta-graph fragment this partial observation belongs to |
| The transfer curve | The **allocate-vs-reuse decision**, made continuously and by degree, rather than by a discrete new-node test |
| Mossy-fiber write path vs. perforant-path read path | The store's two ports: what makes an allocate and a retrieve *different operations on the same memory* |
| DG steep, CA3 shifted, CA1 linear | A **cascade** of curves, not one decision — the separation bias is set once at the input and partially undone downstream |
| Neurogenesis | Capacity *added* where separation demand is high, rather than reallocated ([[wiki/concepts/synaptic-plasticity.md]]) |

**The wiki's two answers to allocate-vs-reuse are the same question at different resolutions — and this is no longer a brainstorm.** [[wiki/concepts/contextual-inference.md]] answers it with a posterior over a growing context library and a nonparametric allocation rule — discrete, probabilistic, and normative. This page answers it with a tunable transfer curve — continuous, mechanistic, and with no probability anywhere. Sanders et al. 2020 state the identification directly: *"inference about new states vs. old states is conceptually similar to the distinction between pattern separation in the dentate gyrus and pattern completion in CA3. The attractor network describes **how** pattern separation and completion work. The hidden state inference model describes **why** they work the way they do"* ([[wiki/entities/hidden-state-inference-remapping.md]]). The bridge they propose between the two levels is a **mixture of Boltzmann machines** — a state-dependent energy function plus a distribution over states — which makes each basin the feature configuration of one hidden state ([[wiki/concepts/energy-based-models.md]]).

The CA3 transfer curve is then what a responsibility posterior looks like after it has been compiled into a fixed network: a soft threshold on input similarity, whose steepness plays the role of the concentration parameter `α` and whose position plays the role of the prior over new contexts. **(brainstorm)** The neuromodulatory controllers above are the biological form of setting `α` online — which is the one thing the nonparametric account leaves as a fitted constant. Sanders et al. add two independent routes to the same knob that do not need a neuromodulator: `α` could be *learned* (an animal raised in an enriched environment should adopt a larger `α`, because a larger repertoire has been adaptive), and it could be *spatially graded* — the dorsoventral gradient in place-field size read as the same inference run in parallel at several values of `α`, so two observations share a state at one end of the axis and not at the other. Both are cheap to build and neither has been tested.

**The x-axis is not the input at all, and there is now a direct measurement.** In mouse CA1 learning the 2ACDC task, four track regions with *identical* visual input — plus two reward zones with identical cues on the two trial types — are progressively driven to near-orthogonality (population-vector angle → 90°) over weeks, while the track start and end, which are *equally* identical, stay correlated throughout because at those positions the animal genuinely has no trial-type information (Sun et al. 2025, [[wiki/entities/cscg.md]]). Input similarity is constant across both sets; what predicts separation is whether the latent states differ. Three consequences for this page:

- **Separation is not a function of the present input; it is a function of the inferred state, and it takes weeks.** A transfer curve `output_sim = f(input_sim)` cannot express either fact — it is instantaneous and stateless. The measured object is a curve whose input coordinate is a *history-dependent posterior*, which is the inference account's position stated as data rather than as an interpretation.
- **The bias is not one number even within one animal at one time.** Different track positions decorrelate in a fixed order (ambiguous within-track regions → pre-far-reward → pre-near-reward) and some never decorrelate, so a single scalar knob is the wrong shape for what CA1 does here — consistent with the per-feature, per-channel picture the interneuron-family row above forces (G38).
- **Feedback inhibition alone is sufficient for the endpoint.** A spiking recurrent network with soft winner-take-all and a purely local timing-based Hebbian rule — no task, no error signal — reaches the same orthogonalized representation. That is the wiki's cheapest mechanistic account of separation-by-competition, and it needs neither sparse random projection nor a neuromodulatory controller ([[wiki/concepts/inhibitory-control-of-coding.md]]).

**The transfer curve's uncalibrated x-axis has a normative replacement.** This page's own caveat is that "environmental change" is not a measurable quantity, so a subfield's curve position is not comparable across studies. The inference account says the axis was wrong in kind, not just in units: what should predict allocation is not the *magnitude* of the input change but its **likelihood under the state's learned generative distribution** — a change along a feature that has historically varied within that state is tolerated, an equal-sized change along a feature that never varies is not. That is directional, per-feature, and experimentally confirmed (Plitt & Giocomo 2019). A similarity metric cannot express it.

---

## What breaks when the knob is stuck

Neurocognitive aging is the wiki's cleanest natural experiment on a mis-set separation bias:

| Finding | Species |
|---|---|
| **Representational rigidity** — the same map is reused across similar environments; bias shifted from separation toward completion | rat, human |
| CA3 neurons show abnormally *elevated* firing, attributed to disinhibition following interneuron and perforant-path deterioration, reinforcing the recurrent network | rat |
| Perforant-path integrity (diffusion imaging) declines with age; the decline correlates with both the rigidity and the behavioural discrimination deficit | rat, human |
| Older adults require *more* dissimilarity before DG/CA3 separates | human |

**Read as an engineering result:** the failure mode of a fast store whose separation bias drifts down is not forgetting — it is **over-generalization**, confidently retrieving an old episode for a new one. Degrading the input pathway (perforant path) shifts the balance toward the recurrent network, i.e. toward completion, i.e. toward hallucinated recall. **(brainstorm)** The analogue in a machine store is a retrieval index whose embedding quality decays while the attractor dynamics on top of it do not: the system does not report failure, it reports a neighbour.

---

## Caveats the review states about its own evidence

- **The Δ-input axis is not calibrated.** Studies alter cue configurations, object identities, rooms, or picture categories, and plot them all as "environmental change". Linearly distorting the environment need not linearly distort the internal representation, so the *position* of a subfield's curve is not comparable across studies. Strictly the axis should be the **neural** input from EC, which is not manipulable.
- **Remapping ≠ separation, stability ≠ completion.** They coincide only when the input patterns were similar-but-not-identical and the upstream input is known.
- **Multi-day discrimination-learning tasks do not isolate separation** unless input similarity is manipulated parametrically with an unimpaired high-dissimilarity control.
- **fMRI cannot resolve DG from CA3**, even at high resolution — the primary human study says so explicitly and reports a combined CA3/DG region throughout (Bakker et al. 2008) — which may be the whole source of the human/rodent discrepancy (humans separate at the smallest increments; rodent CA3 completes there), if the blood-oxygen-level-dependent signal is dominated by DG perisynaptic activity.
- **DG/CA3 activity is not hippocampal output.** It passes through CA1, and an overt recognition task recruits separation-consistent activity across the *whole* hippocampus, while DG/CA3 activity is abrupt where behaviour is graded. The mapping from an internal separation signal to behavioural discrimination is unestablished — the same measurement problem [[wiki/concepts/representation-probing.md]] raises for probes.

---

## Open problems

- **What sets the knob?** The controllers are named, none is characterised as a function. See gap G38. **One instance now has both ends identified** (de Sousa et al. 2026): for the overlap between two episodes encoded days apart, the actuator is NDNF⁺ neurogliaform interneurons in the stratum lacunosum moleculare and the controller is a vmPFC→MEC projection whose activity tracks contextual similarity × elapsed time, bidirectionally moving dCA1 ensemble overlap between ~12% and ~25% with no weight change. Still not a *function* — what similarity metric vmPFC computes, over what representation, is unmeasured — but it is the first controller→actuator→feature chain the wiki holds.
- **Which subfield the bias is applied in.** This page places the separating machinery in DG/CA3 and leaves CA1 as a relay or second completion stage (T33). The top-down overlap control acts in **dCA1 only** — dCA3 and dorsal dentate gyrus overlap are unchanged by the same manipulation — so the episode-level integrate-vs-separate decision is made *downstream* of the classical separator, on a population whose inputs (entorhinal vs CA3) are what the gate selects between. Whether this is a different knob from the DG/CA3 one, or the same knob applied at a different stage, is unaddressed.
- **Rate vs. global remapping.** What selects the code, and are they combined? A normative answer exists — one axis of log posterior odds with rate remapping at the weakly-positive end and global remapping at the strongly-negative end, plus a Beta-distributed spread across cells that makes the two co-occur by construction (Sanders et al. 2020) — but it is a re-description of the data, not a mechanism, and it does not say which circuit implements which end.
- ~~**Attractor dynamics in CA3 is a hypothesis with one supporting demonstration**~~ — **closed by Rolls 2013**, which assembles four independent lines: voltage-sensitive-dye imaging in slice (LTP from two sites, then either site alone evokes the full pattern; Jackson 2013), all-or-none selection of one learned environment under a square/circle morph (Wills 2005), within-theta-cycle flickering between two maps implying completion inside ~120 ms (Jezek 2011), and the CA3 NMDA-receptor-knockout completion deficits already listed above.
- **Newborn vs. mature granule cells.** Loss/gain-of-function says newborn cells enable separation; a computational account says immature cells are too broadly tuned to separate and instead *integrate* patterns; a reactivation study suggests mature cells may be functionally retired. Unresolved — [[wiki/empirical-tensions.md]] T26.
- **Only mammals evolved a DG.** Birds solve the same computational problem another way, which means the anatomy is one solution rather than the solution — relevant to whether a machine should copy the circuit or the transfer curve.
- **Non-visual and temporal separation are untested** at the subfield level (the human evidence is object pictures — visual but non-spatial, so *domain* generality is established and *modality* generality is not); lesion work suggests spatial and temporal separation dissociate across subfields.
- **Does reward or prediction error regulate separation?** Suggested, not established.
- **Is CA1 a relay or a second completion stage?** [[wiki/empirical-tensions.md]] T33.
- **Every confirming experiment runs the store far below capacity.** Rolls 2013 states the predictions only bite at thousands of stored memories and that behavioural work loads it with a handful — so the separation literature is testing the mechanism outside the regime its theory is about.
- **Temporal pattern separation** has a proposed mechanism now (noise-driven transitions between attractors of rate-coded time cells) that predicts a span of ~7 ± 2 and sits in CA3, while part of the lesion evidence points at CA1 — unresolved in the source.

---

## Connections

- **[[wiki/concepts/population-geometry.md]]** — the level at which the separation-vs-abstraction trade-off is actually decided: decorrelation for capacity and disentanglement for transfer were measured together in one hippocampal population and rose together, so a code can be expressive and abstract at once (T50).

- **[[wiki/entities/vector-hash.md]]** — separation with no separator and no controller: a random fixed projection from a prestructured grid code yields attractors that are provably convex, equal-sized and free of spurious minima, so the transfer curve's steepness and offset are set once by the architecture instead of being tuned at runtime (G38) — and completion is one round-trip pass rather than a relaxation whose depth depends on what was stored.
- **[[wiki/concepts/complementary-learning-systems.md]]** — supplies the mechanism behind the "sparse conjunctive code" that page asserts: separation is what makes the fast store's codes non-overlapping, and it is a tunable transfer curve rather than a fixed sparsity level.
- **[[wiki/concepts/latent-graph-discovery.md]]** — separation is de-aliasing (hardness source 3) and completion is retrieval; the transfer curve is the allocate-vs-reuse decision made by degree.
- **[[wiki/concepts/contextual-inference.md]]** — the same allocate-vs-reuse question answered normatively (a responsibility posterior over a growing library) rather than mechanistically; the transfer curve is what that posterior looks like compiled into fixed circuitry.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — bounds what separation is allowed to do: whole-map separation must preserve the place-to-grid relationship, otherwise the structural code cannot be reused in the new map (T39).
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — states the how/why relation to this page explicitly, replaces the uncalibrated input-change axis with likelihood under a learned generative distribution, and offers `α` as a learnable and anatomically graded version of the separation knob (gap G38).
- **[[wiki/concepts/continual-learning.md]]** — names catastrophic interference as the problem separation exists to prevent, and supplies the alternative solution family (gate the weights) to this one (orthogonalize the codes before writing).
- **[[wiki/concepts/synaptic-plasticity.md]]** — separation and completion are both NMDA-receptor-dependent, and adult neurogenesis appears here as the capacity-adding mechanism whose learning role that page lists as unestablished.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the same hippocampal-entorhinal anatomy carries both; separation supplies distinct codes for repeated content, while `g` supplies position — two different routes to the same de-aliasing requirement.
- **[[wiki/concepts/event-segmentation.md]]** — a discrete new-event decision and a continuous separation bias are two answers to when experience gets a fresh code; the cholinergic storage/recall switch is a candidate boundary signal.
- **[[wiki/concepts/energy-based-models.md]]** — completion is attractor relaxation, i.e. energy minimisation over the free variables of a partial cue; separation is the constraint that keeps two stored patterns in distinct basins.
- **[[wiki/concepts/subgraph-matching.md]]** — completion from a partial cue is the same query as "does this fragment occur in the store, and where", solved by dynamics rather than by an order embedding.
- **[[wiki/concepts/representation-probing.md]]** — measuring a transfer curve requires recording the *upstream* input, which is the same discipline probes need: an internal code's dissimilarity means nothing without the input's. The lure bias score runs the other way: it is a label-free instrument that page lacks, buying immunity from the probe circularity by using novel/repeat activity as its own anchors (Bakker et al. 2008).
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — a candidate import of the *scheduling/gating* type rather than the representation type: a mode signal that switches a store between writing separately and reading associatively.
- **[[wiki/concepts/cognitive-map.md]]** — the same transfer curve one level up: the separated unit is a whole map, not an episode, with global/rate remapping as the separation end and all-or-nothing attractor selection under ambiguous cues — in human multivoxel patterns as well as rodent place cells — as the completion end (Epstein et al. 2017).
- **[[wiki/entities/cscg.md]]** — separation reduced to bookkeeping: allocating a fresh clone of an observation *is* the separation operation, with the clone-pool size standing in for the separation/completion bias as a hand-set hyperparameter (gap G38). It also supplies this page's demonstration that the separation axis is latent-state distance and not input distance, and reproduces the *order* in which CA1 separates its aliased regions (Sun et al. 2025).
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — separation in the service of transfer: conjunctive structure × sensory codes are what makes hippocampal remapping the mechanism of generalisation rather than a source of instability.
- **[[wiki/concepts/offline-replay.md]]** — completion is what makes replay possible (a ripple-triggered partial cue reinstates a whole stored sequence); the replay filter is the first mechanism that decides *which* completions are worth running, and inhibitory plasticity is its candidate substrate.
- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the quantitative version of this page: separation decomposed into five mechanisms with a capacity payoff `p_max ≈ kC/(a ln(1/a))`, completion as relaxation in a *diluted* attractor, and the write/read split given synapse counts and a neuromodulatory control law.
- **[[wiki/entities/temporal-context-model.md]]** — completion reduced to a single scalar: `α_N` is an operator that takes a repeated item and reinstates the whole entorhinal state it was first experienced in, and the resulting overlap between context inputs is the anti-separation direction of this page's transfer curve.
- **[[wiki/entities/tem-transformer.md]]** — separation as a normalisation choice rather than an expansion: a softmax over memory neurons is what makes them sparse and place-like, and completion of the conjunction from either factor alone (`g` → what is here, `x` → where was I) falls out of the same attention read.
- **[[wiki/entities/spiking-tem.md]]** — reproduces the sparsity side quantitatively without fitting it (90.0% silent dentate units against 85.8% in vivo, 50.3% silent hippocampal units against ~60%), and makes sparsity causal upstream: removing the hippocampal sparsity term drops entorhinal grid emergence from 59.6% to 0.875%, so separation in the fast store is a precondition for the structural code rather than only a consequence of it.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — supplies the actuator this page's controller section lacked: four inhibitory channels, each causally tied to one feature of the code (generalization, selectivity, stability, information), acting at spike timescale without weight change — and a wiring rule (fan-in width) that says which channel gets which feature (G38).
- **[[wiki/entities/sparse-distributed-memory.md]]** — the transfer curve derived instead of measured, in a store with no plasticity in the separating stage: expansion into a much wider layer plus a Hamming-ball threshold makes two dissimilar cues share `p²M` locations against the `pM` a cue shares with itself, the position on the curve is the single scalar `H`, and its optimum `p = (2MT)^(−1/3)` *falls as the store fills* — the wiki's only statement that the bias should not be constant even in principle (G38).
- **[[wiki/entities/stp-flickering-cann.md]]** — completion to the *wrong* stored pattern, by design: seconds after the cue set switches, a residual synaptic gain bias in the abandoned map wins individual theta cycles, so the separation/completion outcome depends on what was recently active as well as on input similarity.
- **[[wiki/entities/dense-sequence-memory.md]]** — separation moved out of the code and into the read-out: passing the pattern overlap through `f(x)=x^d` widens the target-vs-distractor margin with sparsity, dimensionality and the learning rule all untouched, and the biased-pattern bound `P < ε^{−(2d+1)}+1` is what skipping the representational fix costs.
- **[[wiki/entities/context-modular-memory-network.md]]** — separation moved into the *connectivity*: competing patterns are neither orthogonalised nor suppressed but removed from the energy function by a per-context mask, so the bias this page tunes becomes a mask density, and the accessible/inaccessible stability ratio `κ̄_acc/κ̄_inacc` is a direct read-out of where the network sits on the axis (G38).
- **[[wiki/entities/hopfield-network.md]]** — completion in its purest form and separation entirely absent: descent from a corrupted state restores the nearest stored pattern unconditionally, with basin shape set by pattern correlations, which is why every biologically grounded successor bolts a separating stage onto the input.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — puts a hard floor under the curve: at 50% activity *no* threshold gives robust subsampled recognition at any dimension, so the sparsity of the code constrains where on the transfer curve a region can be placed before its threshold is set, and `θ/s` is then the knob (low `θ` completes and risks false positives, high `θ` separates and risks misses) with a computable error rate on each side.

- **[[wiki/concepts/memory-allocation-excitability.md]]** — the opposite bias keyed on a different axis: this page pushes *similar* inputs apart to prevent interference, while an hours-long excitability tag pulls *temporally proximal* inputs into overlapping populations to create a relation between them, with the shared subpopulation causally dissociable (silencing it removes the behavioural link and spares each memory). A fast store therefore needs a recency knob alongside the similarity knob, which is a second sense in which G38 has the wrong number of knobs.
- **[[wiki/concepts/attractor-dynamics.md]]** — completion *is* relaxation, and the separation/completion bias is the steepness of the basin walls this page describes.
- **[[wiki/concepts/recall-gated-consolidation.md]]** — a second, independent reason for the fast store to be sparse: separability of reliable from unreliable candidate updates for a consolidation gate, which is a different objective from non-overlap of stored items and points the same way; and its autoassociative gating signal `x·(Wx)` is completion strength used as a write license rather than as a read-out.
- **[[wiki/entities/btsp-cam.md]]** — the transfer curve made conditional on *when* the similarity is encountered: items that are similar at learning time are pushed apart (the depression branch zeroes the weights they share in any unit gated for both, so that unit joins neither trace), while cues that are similar to a stored item only at recall time are completed. One rule, no arbitration, and the repulsion is quantitatively comparable to the human fMRI effect no previous learning rule reproduced. Its `f_q` (the plateau/allocation rate) is a single runtime scalar moving the whole curve, which is a candidate controller for G38.
- **[[wiki/concepts/generalization-optimized-consolidation.md]]** — this mechanism used as a pure index in a working consolidation model: random sparse patterns bound one-shot to cortical activity, retrieved by recurrent completion from random initialisation, carrying no content of their own — and the theory's conclusion that the index must be *permanent* for unpredictable experience gives the separation capacity a steady-state role, not just a staging one.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — beyond the four-channel actuator, the one place where a channel's *controller* is also identified: SLM neurogliaform cells set how much two episodes' CA1 ensembles overlap, and a vmPFC→MEC projection sets them, which puts the integrate-vs-separate decision in CA1 rather than in DG/CA3 and makes it a cortical arbitration rather than a local transfer curve (de Sousa et al. 2026, T33, T83).
- **[[wiki/concepts/engram.md]]** — the antagonist mechanism made explicit: linking two memories *means* increasing the overlap of their populations, at encoding (shared excitability window) or afterwards (repeated co-retrieval), so every edge written pushes the pair toward being completed as one — separation and relation-writing compete for the same variable (G38).
- **[[wiki/entities/differentiable-neural-computer.md]]** — gap G38's knob in a machine: an allocation gate `g^a` emitted per step interpolates between writing to the least-used location (separate) and editing the content-matched one (complete), with usage as the novelty signal — but trained by backpropagation through time against task loss, not against completion error.
