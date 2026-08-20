# BTSP Content-Addressable Memory (Wu & Maass 2025)

**A content-addressable memory built by one-shot, *binary*-weight synaptic plasticity in a two-layer feedforward network with no recurrence: each memory neuron flips `w_i` between 0 and 1 for every active input, but only while a randomly-timed dendritic plateau holds its plasticity window open. The stochastic gate — not coactivity — decides which cells a memory is written into, and the depression half of the rule pushes traces for *similar* items apart.** Wu & Maass, *Nature Communications* 16:1, 2025 (`raw/wu-2025-btsp-content-addressable-memory.md`).

This is the wiki's first store whose write rule ignores postsynaptic firing entirely, and the first that reaches Hopfield-class content-addressable memory (CAM) performance with **two weight values**. It is the functional theory of rule 6 on [[wiki/concepts/synaptic-plasticity.md]]: that page has BTSP creating a *node*; this page asks what the whole population of nodes is worth as a memory system, and answers analytically.

---

## Architecture

| Component | Statement | Constraint that does the work |
|---|---|---|
| Input layer | `m` binary units = CA3 pyramidal cells; pattern `x ∈ {0,1}^m` with a fraction `f_p` of 1's | Sparse by design: `f_p = 0.005` from CA3 recordings, matched independently by <0.5% active in monkey V1 for natural images |
| Memory layer | `n` **disconnected** McCulloch–Pitts units = CA1 pyramidal cells; the memory trace `z(x)` is the set that fires | CA1 has almost no recurrent collaterals, so the store is feedforward — there is no energy function and nothing relaxes |
| Connectivity | Random, probability `f_w = 0.6` (≈15,000 of `m` inputs per memory neuron; CA1 cells carry ≈30,000 spines) | Fixed; only the binary values on existing connections are learned |
| Weights | `w_i ∈ {0,1}` | The whole point — see the capacity comparison below |
| Gate | Each memory neuron receives, per item, an independent plateau with probability `f_q` | The one parameter with **no analogue in any previous memory model** |
| Write | `Δw_i = +1` if `x_i = 1, w_i = 0`; `Δw_i = −1` if `x_i = 1, w_i = 1` — applied with probability 0.5 whenever input arrives inside the ≈10 s plateau window | An **involution**: the same event potentiates a silent synapse and depresses a strong one. No `x_post` term anywhere |
| Read | Threshold the weighted sum; trace appears in **one step** | Cf. 100 iterations for a Hopfield network to settle |
| Reconstruction | Random feedback `memory → input`, written by one-shot Hebbian plasticity | Deliberately the simplest possible generative path; the biological version is unknown |

**"Core BTSP"**: delete the probability-0.5 coin and halve `f_q` — same effective learning rate, same results, still stochastic because plateaus are. Use this variant when implementing; it has one fewer random number per synapse.

**Default parameters** are anatomy, not tuning: `m = 25,000`, `n = 39,000` (rat CA3/CA1 down-scaled ×1/10), `f_p = 0.005`, `f_w = 0.6`, `f_q = 0.005`. Only the firing threshold was grid-searched.

---

## The parameter that is new: `f_q`

`f_q` is the probability that a given memory neuron's plasticity window is open when an item arrives. It is a **memory-allocation rate**, and everything trades off against it:

| Raise `f_q` | Lower `f_q` |
|---|---|
| Larger memory traces (more cells per item) | Sparser traces |
| More overlap between traces for different items — bad | Less interference |
| More previously-set weights hit by the depression branch when later items arrive, so weighted sums drift down and masked cues stop reaching threshold | Better recall from partial cues, better input completion |
| Stronger repulsion of similar items | Weaker repulsion |

Measured value ≈0.005, which the paper argues is the sweet spot. **The seconds-long window is what puts it there**: plateaus are generated at ≈0.0005 per CA1 cell per second, so a 10 s window converts a rate into `f_q = 0.0005 × 10 = 0.005`. The biophysical duration is not a detail about eligibility traces — it is the **gain control on the memory-allocation rate**, and the only free parameter setting it.

**(brainstorm)** For a builder this is the cleanest available implementation of gap G38's missing controller: one scalar, computable at runtime, moves the store continuously between separation (low `f_q`, sparse non-overlapping traces) and completion (high `f_q`, large overlapping traces). Unlike a sparsity hyperparameter it is a *rate over time*, so it can be modulated by novelty within an episode — which is consistent with BTSP being more strongly expressed in novel environments (Priestley et al. 2022, [[wiki/concepts/synaptic-plasticity.md]]).

---

## Results

| Claim | Number | Condition |
|---|---|---|
| Recall from partial cues | Works with up to **1/3 of the 1's masked**; two-sided perturbation (0→1 as well) is tolerated equally | `m = 25,000`, `n = 39,000` |
| Overlapping items | Stores and separates items sharing up to **30% of their 1's**, still recalled with 33% masking | Episodic/conjunctive memory needs exactly this |
| vs. continuous-weight Hopfield network | **Comparable, sometimes better**, on recall and on input reconstruction, at the same connection probability and same sparse patterns | Binary weights beating continuous ones is the headline |
| vs. binary-weight Hopfield network | No viable CAM at all | Quantizing a trained HFN collapses its capacity |
| Retrograde interference | Reconstruction error for the **first 100** and the **last 100** of 10,000 sequentially learned items is nearly identical | The postsynaptically-gated one-shot rule it is compared against (`SP`) degrades early traces badly |
| Scaled-up capacity | **800,000 items** recalled with up to 2/3 of the cue masked, at `m = 2.5×10⁶`, `f_p` reduced ×1/100 | **Theory only** — the simulation was not runnable at this size |
| Downstream robustness | A random thresholded linear readout (integer weights −8…+8) rarely flips class under masking; random projection flips often | Robustness measured on the *use* of the trace, not on the trace |
| Theory–simulation agreement | Analytic predictions track simulations across all figures | Required new combinatorial tools: unlike HFN theory, **the order of items matters**, because a weight set by item `k` can be depressed by item `k+j` |

---

## The three mechanisms, isolated

**1. Why a stochastic gate spreads memory load.** Every Hebbian-family one-shot rule recruits the cells that *fired*, so the same easily-driven cells are recruited over and over and early traces are overwritten. BTSP recruits cells that were *gated*, and gating is independent of the input, so the memory space is used uniformly by construction. The uniformity is what buys the flat first-100/last-100 curve above. **This is the sharpest argument in the wiki for divorcing the write-target decision from the activity that is being written** ([[wiki/concepts/memory-allocation-excitability.md]] makes the same move with a slow excitability tag instead of a fast plateau).

**2. Why a *learned* random projection has attractors and a fixed one does not.** Compare the distribution of a memory neuron's weighted sums over all stored items:

| | Distribution | Consequence |
|---|---|---|
| **Random projection / fly algorithm** | Unimodal. Any threshold admitting the required number of items leaves many of them sitting *just above* it | Masking a few 1's drops them below; no basin |
| **BTSP** | **Bimodal** — one cluster for items whose learning was accompanied by a plateau in this cell, one for the rest | Put the threshold in the gap; a perturbation cannot cross it. The basin is created by the learning, not by recurrence |

So BTSP is a random projection **tailored to the ensemble actually stored**, and that tailoring *is* the attractor property. It also drops the fly algorithm's two scaling requirements: no 40× expansion (CA1 is at most 1.5× CA3) and no global winner-take-all over the projection layer.

**3. Why the depression branch produces *repulsion*.** Learn two items with 40% shared 1's. A memory neuron that gets a plateau for both will have every shared-input weight set to 1 by the first and back to 0 by the second, so it fires for **neither** — and drops out of both traces. A neuron plateaued for two *dissimilar* items loses only the few weights they share and fires for both. Net effect: similar items' traces are pushed apart, dissimilar items' traces pulled together. Random projection does the opposite (more similar in → more similar out), and no previous learning rule reproduced it. Effect size is comparable to the human fMRI measurements it was modelled on.

**Repulsion is not in conflict with the attractor property**, and the distinction is the useful part: similarity encountered **during learning** is repelled, similarity encountered **during recall only** (a masked cue) is completed. The store separates what it has to distinguish and completes what it has merely to recognise, from one rule with no arbitration.

---

## Where it sits among the wiki's stores

| | Hopfield | Sparse distributed memory | Vector-HaSH | **BTSP CAM** |
|---|---|---|---|---|
| Fixed points defined by | Stored content | Fixed random addresses | Frozen grid scaffold | **Learned gating** — cells the plateau selected |
| Weight resolution | Grows linearly with item count | Saturating counters | — | **1 bit** |
| Recurrence needed | Yes (relaxation) | No | Yes | **No** |
| Recall latency | ~100 steps | 1 step (+ iterations) | Few steps | **1 step** |
| Similar items | Merge into spurious minima | Collide | Distinct addresses | **Actively repelled** |
| Overload | Catastrophic cliff | Graceful | Graceful, degrades resolution | Not characterised past the tested range |
| Write selectivity | None | None | None | **None about content** — the gate is random, not informative |

---

## Limitations

| Limitation | Statement |
|---|---|
| **The gate carries no information** | `f_q` decides *how much* is written, never *what is worth writing*. Gap G19 is untouched: a shortcut-driven pattern is stored exactly as readily as a structural one. What the gate buys is uniform load, not selectivity |
| **The teacher is still unexplained** | Same problem [[wiki/concepts/synaptic-plasticity.md]] logs for BTSP generally: modelling plateaus as an input-independent Poisson process is a *convenience that does the work*. If real plateaus are driven by entorhinal content, every uniformity argument on this page has to be redone |
| **Binary weights may be a modelling choice, not biology** | Justified by positing several release sites per connection, each binary. The average number of release sites at a CA1 synapse is unknown |
| **No capacity model of the usual kind** | The theory predicts recall quality at given loads; it names no `p_max` and no overload behaviour, so the store still cannot tell when it is full (G42) |
| **Feedback path is a placeholder** | Input reconstruction needs random feedback weights written by a *separate* one-shot Hebbian rule — a second, unmodelled learning system whose biological implementation the paper calls opaque |
| **Largest claim is unsimulated** | The 800,000-item result is theory extrapolated to human CA3 scale |
| **No sequences, no structure** | Items are unordered bit vectors. Nothing here links traces, so the store holds nodes and no edges |

---

## Why it matters for a reasoning model

- **One-shot binding of an instance-graph gets cheap.** A fast **M** written at 1 bit per synapse, in one exposure, read in one step, without recurrence, is the least expensive fast store in the wiki — and it is the only one whose cost model transfers directly to hardware (memristor crossbars with two resistance states and on-chip learning, versus off-chip training of many-valued devices for Hopfield-style CAM).
- **Repulsion is a mechanism for the operation abstraction needs.** Two experiences differing in a few but salient features must be *differentially* processed downstream; a store whose default is completion returns a neighbour instead. BTSP supplies the pushing-apart as a free consequence of depression, at learning time, with no comparison step and no similarity computation.
- **(brainstorm) The involution is a novelty detector nobody has read as one.** `w_i ← 1 − w_i` on every gated active input means a synapse's state encodes the *parity* of how many gated presentations that input has had in this cell. A trace survives to the extent its input set is *not* re-presented under a plateau — so the rule silently implements "store what has not recently been stored", which is the inverse of [[wiki/concepts/recall-gated-consolidation.md]]'s rule and reaches a similar end (spending capacity where it is informative) with no population statistic and no gate. Whether the parity reading survives realistic plateau statistics is untested.
- **The order-dependence is a warning for every other store in the wiki.** Because a later item can depress an earlier item's weights, HFN-style capacity theory does not apply — the state of the store depends on the *sequence*, not the set. Any architecture with bounded, flippable weights inherits this, and none of the wiki's other capacity claims are stated sequence-dependently.

---

## Connections

- **[[wiki/concepts/synaptic-plasticity.md]]** — the functional theory of that page's rule 6: BTSP written as a binary involution `Δw_i = ±1` gated by a stochastic plateau, and evaluated as a memory *system* rather than as a receptive-field creator. It also lands the page's strongest claim about what a plasticity rule can be — no `x_post` term at all, which puts BTSP outside the Hebbian family by definition rather than by degree.
- **[[wiki/entities/hopfield-network.md]]** — the direct rival, beaten on its own benchmark: binary weights matching or exceeding continuous-weight Hopfield recall and reconstruction for sparse patterns, in one step instead of ~100, with no recurrence and no energy function — and binary-weight Hopfield networks providing no CAM at all on the same items.
- **[[wiki/concepts/attractor-dynamics.md]]** — a counterexample to this page's framing: an attractor-like basin (perturbed cues map to the stored trace) produced by a *feedforward* map with no relaxation, because learning makes each cell's weighted-sum distribution bimodal and the threshold sits in the gap. Basins here are defined by neither content nor scaffold but by which cells were gated.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the transfer curve made *signed by when the similarity occurs*: items similar at learning time are repelled (below the identity line), cues similar to a stored item at recall time are completed (above it), from one rule with no arbitration — and `f_q` is a single runtime scalar moving the whole curve (G38).
- **[[wiki/concepts/sparse-distributed-representations.md]]** — supplies the coding regime this store assumes and depends on: `f_p = 0.005`, matched independently in monkey V1, is what makes binary weights and a single threshold sufficient, and the capacity claims do not survive dense codes.
- **[[wiki/concepts/memory-allocation-excitability.md]]** — the same architectural move at a different timescale: which neurons a memory is written into is decided by a variable that is not a weight and not the input. Excitability tags decay over hours and bias allocation toward recently-active cells; plateaus are seconds-long and input-independent, which is what makes the load *uniform* rather than clustered.
- **[[wiki/entities/sparse-distributed-memory.md]]** — the engineered version of the same feedforward, address-then-store design, with the address fixed and random rather than learned and gated; BTSP's bimodality argument is exactly why a data-independent address layer tolerates less cue corruption.
- **[[wiki/entities/vector-hash.md]]** — the other prestructured store, and the closest comparison for "randomness before content": there the randomisation is a frozen projection of a grid code, here it is a random gate applied *during* learning, so the projection ends up tailored to the stored ensemble and acquires basins the frozen one cannot have.
- **[[wiki/concepts/recall-gated-consolidation.md]]** — the opposite answer to the same question of which writes to keep: recall-gating spends capacity on patterns the store already partly holds; BTSP's involution spends it on inputs whose gated-presentation parity is odd, i.e. on what has *not* just been written.
- **[[wiki/concepts/complementary-learning-systems.md]]** — a fast-system write rule that does not degrade its own earlier traces, which removes the usual motivation for rapid consolidation-or-lose-it: interference here is bounded by the gating rate, not by the number of items stored.
- **[[wiki/concepts/dendritic-computation.md]]** — the gate is a dendritic event: the plateau that licenses a write arrives on the apical tuft from entorhinal cortex, so the memory-allocation rate `f_q` is set in a compartment that the somatic output never sees.
- **[[wiki/entities/spiking-neural-networks.md]]** — the implementation target: a local, two-state, one-shot rule is what on-chip learning in memristor crossbars can actually run, where Hopfield-style CAM needs off-chip training and many distinguishable resistance states.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the node store for the instance graph: high-capacity, one-shot, order-dependent, and with *no* edges — the traces are unordered and unlinked, so what this store contributes is the vocabulary, not the structure.
- **[[wiki/entities/hami.md]]** — the other content-addressable fast store in the wiki, and the same lesson about capacity from the other side: here allocation is rate-limited by a stochastic plateau gate, there by a similarity threshold, and in both cases what governs the store's usable capacity is whatever controls *key creation* rather than how much has been stored (Poursiami et al. 2025).
