# HAMI — Hippocampal-Augmented Memory Integration (Poursiami et al. 2025)

**An episodic-control agent in which the memory key is a *discretised symbol pair*, not a vector: two pretext-trained encoders (event, context) are quantised independently by a cosine-similarity threshold into a growing symbol alphabet, a sliding window of event-in-context symbols is the experience, and episodic memory is an exact-match table of (symbol window, action) → best return.** Poursiami, Moshruba, Cooper, Gobin, Kaiser, Singh, Noor, Shahbaba, Jaiswal, Fortin & Parsa, *Scientific Reports* 15, 2025 (`raw/poursiami-2025-hippocampal-rl-framework.md`).

This is the wiki's first primary source for **episodic control** — the row [[wiki/concepts/complementary-learning-systems.md]] carried on the strength of a survey. It is also the wiki's only fast store whose allocate-vs-reuse threshold has been **swept and mapped** rather than assumed (gap G38), and the only one that names a physical read mechanism (content-addressable memory) for the retrieval step.

---

## Architecture

| Stage | Operation | Claimed hippocampal analogue |
|---|---|---|
| Event / context encoders | Two Siamese convolutional nets, contrastive loss, 64-d embeddings, trained on 10,000 synthetic pairs for 10 epochs, *before* any RL | Lateral entorhinal cortex (event) / medial entorhinal cortex (context) — the source's own split by input statistics |
| Symbolic indexing associative memory | Cosine-similarity match of each embedding against existing entries; below threshold → **allocate a new symbol**. Event and context indexed *independently*, then paired. 6-bit symbols | Dentate gyrus separation + CA3 conjunction |
| Sequence buffer | Sliding window of recent event-in-context symbols; **reset each episode** | CA3 recurrence / replayable sequence code |
| Temporal integrator | Concatenates current symbol with the buffer → one structured experience | CA1 integration of past (entorhinal trace) and predicted-future (CA3) |
| Episodic memory | Table: (symbol window, action) → cumulative return. Exact match → take the argmax-return action. No match → random (training) / nearest stored (inference) | Episodic store queried for decision |
| Action selection | Retrieve-or-explore over the table | Prefrontal cortex |
| Memory formation / refinement | End of episode: novel experiences inserted (oldest evicted at capacity); existing experiences **replaced only if the new return is higher**, else the new one is discarded | Consolidation and updating |

**The load-bearing move is the quantisation.** Every other episodic-control method in the wiki's CLS table keys memory on a real vector and pays a `k`-nearest-neighbour search per decision. Here the key is a short bitstring, so retrieval is an equality test — which is what buys both the latency result and the hardware story below.

**Independent indexing is a compositionality claim, not an implementation detail.** Because events and contexts are symbolised separately and only then paired, a never-observed (event, context) pairing is representable as soon as both components have been seen alone. This is factorisation bought by *quantising the two factors apart*, with no structural code and no path integration ([[wiki/concepts/abstract-structural-codes.md]], [[wiki/concepts/compositionality.md]]).

---

## HiCoS — the environment

Hierarchical Contextual Sequences: a Gymnasium environment built to be the RL form of a rodent nonspatial-sequence task.

| Property | Value |
|---|---|
| Observation | Colored-MNIST: a digit (the *event*) on a colored background (the *context*) |
| Rule per context | red = consecutive descending, blue = consecutive ascending, green = even ascending, yellow = odd ascending — **never told to the agent** |
| Action | Binary: this observation is `InSeq` or `OutSeq` given the context's rule and the digits so far |
| Reward | +0.5, +1, +1.5 for successive correct steps (max 3/episode); −1 and **immediate termination** on any error |
| Chance baseline | −0.1875 expected reward |
| Key property | **Non-Markovian** — the current frame never determines the action; the rule must be inferred from context and the sequence position from memory |

**Why this is worth a wiki slot.** It isolates the one demand most benchmarks confound: the *same* observation (digit 4) is `InSeq` or `OutSeq` depending on a latent rule indexed by a nuisance feature (color) and on unobservable history. That is hardness source 3 — aliasing — in a form where the correct de-aliasing key is known to the experimenter and can be read off the learned symbol table ([[wiki/concepts/latent-graph-discovery.md]]). Its limit is that the meta-graph is four hand-written rules over ten digits, so nothing about vocabulary co-discovery (G4) is tested.

---

## Results

| Metric | HAMI vs. baselines |
|---|---|
| Action accuracy | Highest of all models; ≈ **+13%** over augmented deep Q-learning |
| Inference latency | **24× faster** than Knowledge-Enhanced episodic control; still slightly slower than the deep Q-networks (memory query is the residual bottleneck) |
| Training time | Fastest of all evaluated models |
| Sample efficiency | Mean episode reward 2 (of 3) by **2500 episodes**; plateaus ≈5000 |
| Memory | Symbolic index + episodic memory together ≈ **32 KB**; total dominated by the frozen pretext network weights |
| Buffer occupancy | ≈**87%** after 20,000 episodes — i.e. it never had to evict, while both vector-keyed episodic-control baselines saturated and overwrote |
| Encoder quality | Normalised mutual information 0.9997 (color), 0.9682 (digit) |

**The buffer-occupancy row is the real explanation of the accuracy gap, and it is a compression result.** The baselines exhaust capacity because a vector key makes every noisy re-encounter a *new* entry; quantisation collapses the re-encounters onto one key, so the same buffer holds the same task in a bounded number of slots. Sample efficiency here is downstream of key cardinality, not of the learning rule.

---

## The threshold sweep — gap G38's knob, measured

The event and context similarity thresholds *are* the separation/completion bias: low → few symbols, distinct states merged (over-completion); high → many symbols, states split that should share (over-separation).

| Finding | Number |
|---|---|
| Threshold combinations reaching ≥90% accuracy | 43.54% of the swept space |
| Reaching ≥95% | 27.21% |
| Skew of the accuracy distribution | −0.495 (mass at the high end) |
| A contiguous high-accuracy region | context ∈ [0.20, 0.99], event ∈ [0.45, 0.95] → mean 95.03%, sd 2.34% |
| Failure mode at high threshold | Symbol count explodes → episodic buffer exhausts early → *longer* training and lower accuracy |

Three things the wiki did not have:

1. **The knob's failure is asymmetric and the costly side is over-separation.** Over-completion loses accuracy directly; over-separation loses it *through capacity* — a second-order path that no separation/completion account in the wiki models. This is the first joint statement of G38 (what sets the bias) and G42 (nothing knows when the store is full): here they are the same parameter.
2. **The context threshold is far more permissive than the event threshold** (usable from 0.20 vs. 0.45). **(brainstorm)** If that generalises it says the two factors of a conjunctive code want *different* separation biases — contexts few and coarse, events many and fine — which is an argument for two independently-controlled knobs rather than the single scalar every candidate controller in the wiki emits ([[wiki/concepts/pattern-separation-completion.md]], [[wiki/concepts/inhibitory-control-of-coding.md]]).
3. **The bias is static.** It is a constant set before training, which is precisely what G38 says it cannot be; the sweep shows a *wide tolerant plateau* rather than a controller. Read as evidence, the plateau weakens the urgency of G38 for tasks with a fixed observation distribution and says nothing about the non-stationary case ([[wiki/empirical-tensions.md]] T138).

---

## Retrieval as a hardware operation

The retrieval bottleneck is stated, not hidden: every decision must search the store. The proposed fix is that a fixed-width symbolic key is **directly a content-addressable memory (CAM) query** — a 2-transistor-2-resistor non-volatile cell (RRAM / MRAM / phase-change memory / ferroelectric FET) where a match keeps the precharged match line high and a mismatch discharges it, so the whole store is searched in one clock cycle.

**(brainstorm) This is a design constraint the wiki has been treating as an implementation detail.** [[wiki/entities/sparse-distributed-memory.md]] and [[wiki/entities/btsp-cam.md]] both describe stores that are content-addressable *in principle*; this is the wiki's first statement of what the memory format must be for the read to be O(1) in silicon — fixed-width, discrete, exact-match. It is an argument *against* the vector-key fast stores the rest of the wiki assumes, made on grounds (energy, latency, density) that no other page prices. It also inverts the usual reading of quantisation as lossy: here discretisation is what makes the store physically realisable at all ([[wiki/concepts/sparse-distributed-representations.md]]).

---

## Limitations

| Limitation | Consequence |
|---|---|
| Encoders are pretrained and **frozen** | The hard half of symbol formation — learning a metric in which cosine similarity means "same event" — is solved offline and by supervision-by-construction (synthetic positive/negative pairs). Symbol allocation inherits a near-perfect metric (NMI 0.97–0.9997) |
| Retrieval is **exact match** | Graded similarity is named as future work; with a noisier encoder the whole scheme degrades to nearest-neighbour and the latency advantage goes |
| One environment, hand-written rules | No test of transfer, non-stationary contexts, or unseen rule families |
| No consolidation | The episodic table is the policy; nothing distils it into the slow learner, so this is gap **G14** exhibited again — the store is used directly rather than as a teacher |
| Return-max refinement | Keeping the maximum observed return per key is the MFEC rule and is **biased optimistic** in stochastic environments; HiCoS is deterministic so the bias never bites |
| Sequence buffer resets per episode | Nothing carries structure across episodes except the symbol alphabet and the table — there is no temporal abstraction, and the "CA1 predicts the future" analogue is a concatenation of the past only |

**(brainstorm) The frozen-encoder limitation is the interesting one, because it names the division of labour the wiki keeps rediscovering.** HAMI works because a *slow, supervised, offline* process supplies a metric, and a *fast, online, non-parametric* process does everything else. That is exactly the slow-**W**/fast-**M** split — except the slow side here learns no transitions and no policy at all, only what counts as the same thing. If that is generally the right assignment, the meta-graph's first job is not structure but **identity**: deciding which observations are the same node ([[wiki/concepts/latent-graph-discovery.md]], hardness source 3).

---

## Comparison

| System | Memory key | Retrieval | Capacity behaviour |
|---|---|---|---|
| Model-Free Episodic Control | Random-projected state vector | `k`-nearest-neighbour average | Grows with every distinct vector |
| Knowledge-Enhanced episodic control (this paper's strongest baseline) | Pretext embedding window | Mean cosine similarity | Saturates and overwrites; 24× slower |
| **HAMI** | Window of 6-bit event-in-context symbols | Exact match (CAM-able) | Bounded by symbol alphabet; 87% used at 20k episodes |
| [[wiki/entities/cscg.md]] | Clone index, allocated per observation | Transition inference | Clone pool fixed by hand |
| [[wiki/entities/sparse-distributed-memory.md]] | 1000-bit address | Hamming ball, distributed vote | Graded overload at ~10% of locations |
| [[wiki/entities/btsp-cam.md]] | Sparse binary input pattern | One-step threshold | Allocation-rate limited, not load limited |

HAMI and CSCG are the same idea at two levels: both replace a similarity metric with **discrete allocation**, and both then get their de-aliasing for free from the allocation bookkeeping. The difference is what the allocated symbol indexes — a latent *state* in CSCG (learned from transitions), a sensory *identity* in HAMI (learned from a static contrastive objective).

---

## Connections

- **[[wiki/concepts/complementary-learning-systems.md]]** — supplies the primary source for that page's *episodic control* row and sharpens its verdict: the fast store used directly for behaviour wins on sample efficiency because quantised keys keep its capacity bounded, and it still has no consolidation path back to the slow learner (G14).
- **[[wiki/concepts/pattern-separation-completion.md]]** — the transfer curve reduced to one thresholded comparison per factor, and then *swept*: this is the wiki's only map of accuracy over the whole separation/completion range, and it shows the two factors of a conjunctive code tolerating different biases (context from 0.20, event from 0.45).
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the opposite bet on the same problem: high-dimensional sparse codes make interference improbable while staying continuous, HAMI makes it *impossible* by quantising to a short exact-match key, at the cost of everything graded similarity buys.
- **[[wiki/concepts/latent-graph-discovery.md]]** — aliasing (hardness source 3) resolved by allocation rather than by inference: the same digit at different sequence positions is de-aliased by the symbol window, and the rule indexed by context is never represented as a rule at all, only as separate table entries.
- **[[wiki/concepts/abstract-structural-codes.md]]** — factorisation obtained by quantising two encoders apart instead of by learning a structural code, which is why an unseen (event, context) pairing is representable but an unseen *rule* is not.
- **[[wiki/entities/cscg.md]]** — the same discrete-allocation answer to aliasing, allocating over latent states inferred from transitions rather than over sensory identities scored by a frozen contrastive metric.
- **[[wiki/entities/sparse-distributed-memory.md]]** — the store this one is the discretised limit of: both make retrieval an address operation rather than a search, but SDM keeps a Hamming ball and a distributed vote where HAMI keeps only exact match, and both depend entirely on an encoder that maps semantic similarity onto the address metric.
- **[[wiki/entities/btsp-cam.md]]** — the other content-addressable fast store in the wiki, allocation-rate limited rather than load limited; read together they say a fast store's capacity is governed by whatever controls *key creation*, whether that is a stochastic plateau gate or a similarity threshold.
- **[[wiki/concepts/contextual-inference.md]]** — the rival treatment of the same context-dependent-rule setting: infer a posterior over an unbounded context set and weight every memory by responsibility, against HAMI's hard argmax over a discrete symbol with no uncertainty represented anywhere.
- **[[wiki/entities/spiking-neural-networks.md]]** — shares the neuromorphic constraint and reaches the opposite conclusion about what to put on the chip: spikes for compute, where this argues the win is in the *memory* array (non-volatile CAM) and the compute can stay conventional.
- **[[wiki/concepts/working-memory.md]]** — the sequence buffer is working memory with the controller deleted: a fixed-length sliding window, written unconditionally, cleared on episode boundary, with no gating decision anywhere (cf. G48, G49).
- **[[wiki/concepts/event-segmentation.md]]** — the episode boundary is supplied by the environment and used as the buffer's reset signal, which is exactly the segmentation decision this architecture would have to make for itself in a continuous stream.
- **[[wiki/concepts/compositionality.md]]** — this architecture is the floor that page's richer proposals have to beat: quantising two factors independently and pairing the symbols yields novel combinations for free, with no binding operator, no variable and no recursion.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — supplies that page's evidence that one broadcast scalar is not enough: the *event* and *context* factors of the conjunctive code have measurably different usable separation ranges (0.45–0.95 vs. 0.20–0.99), so the separation controller needs more than one output channel.
- **[[wiki/concepts/analog-in-memory-computing.md]]** — the same devices used for the other job: there a crossbar multiplies a weight matrix, here it would *be* the key store, which is the model-based branch of learning-to-learn that the phase-change-memory demonstrations name as the natural fit and do not run.
- **[[wiki/entities/cn-dpm.md]]** — the same growing library with the cheap key replaced by a principled one: a Chinese-restaurant prior times a learned joint likelihood decides allocate-vs-reuse where this page uses a cosine-similarity threshold. Both hyperparameters are hand-set, and only that page reports what fraction of its retrievals are correct (48.18% over five components) — the measurement this page's discrete keys never receive.
