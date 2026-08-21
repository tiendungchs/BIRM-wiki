# Spiking Hippocampal Content-Addressable Memory (Casanueva-Morato et al. 2024)

**A CA3-inspired spiking store that answers queries in *both* directions — `cue → content` and `content → {cues}` — by holding two spike-timing-dependent-plasticity (STDP) matrices wired in opposite directions, plus a two-interneuron gate that infers which of four operations (learn / recall-by-cue / recall-by-content / forget) is being requested purely from the *relative arrival time* of the cue and content volleys. Forgetting is never issued as a command: overwriting a cue emits its own correctly-addressed erase as a side effect of the write.** Casanueva-Morato, Ayuso-Martinez, Dominguez-Morales, Jimenez-Fernandez & Jimenez-Moreno, *Neural Networks* 178:106474, 2024 (`raw/casanuevamorato-2024-hippocampus-neuromorphic-cam.md`); implemented on SpiNNaker at 1 ms timestep, source public.

This is the wiki's first store that can be asked **"which stored items contain this?"**. Every other fast store here — attention, [[wiki/entities/hopfield-network.md]], [[wiki/entities/sparse-distributed-memory.md]], [[wiki/entities/btsp-cam.md]], [[wiki/entities/differentiable-neural-computer.md]] — exposes one read direction, `query → completed item`, and the reverse query is answerable only by scanning. What this paper shows is the *price* of the reverse read: a duplicate weight matrix, and an arbiter to stop the two directions corrupting each other. It does **not** show capacity — see the register-file objection below.

---

## Architecture

Three structures over eight leaky integrate-and-fire (LIF) subpopulations. The memory is split by fiat into a **cue** (one-hot) and a **content** (arbitrary binary vector).

| Structure | Subpopulations | Plastic synapses | Answers |
|---|---|---|---|
| **S1** — recall by cue | `S1Cue`, `S1Cont` | all-to-all STDP **`S1Cue → S1Cont`** | given a cue, emit its content |
| **S2** — recall by content | `S2Cue`, `S2Cont`, + interneurons `S2Int`, `S2Cond` | all-to-all STDP **`S2Cont → S2Cue`**, plus all-to-all *inhibitory recurrent* collaterals within `S2Cue` | given content, emit every cue whose content overlaps it at all |
| **Merge** | `MergeCue`, `MergeCont` | fixed | sum the two flows so output format = input format |

**S2 is fed from S1, not from the input.** This is load-bearing and non-obvious: during an overwrite the erase must reach *all* content units of the old memory, including those the new memory does not contain, and only S1's recall-by-cue output contains them. Wiring S2 to the external input instead would leave the old associations half-erased in the reverse matrix.

**The cue is one-hot because the dentate gyrus is assumed to be a maximal sparsifier.** The paper's stated reasoning: the dentate gyrus increases input sparsity by an unknown amount, so take the limit. The sparsifier itself is **not modelled** — it is future work.

### The gate: an operation code recovered from spike timing

`S2Cond` is a 1-to-1 relay `S1Cont → S2Cont`, inhibited all-to-all by `S1Cue` at **+1 ms delay**, and excited by `S2Int` (which fires whenever *any* `S1Cont` unit fires).

| What arrived | Timing at `S2Cond` | Gate | Operation performed |
|---|---|---|---|
| Cue **and** content together | inhibition and `S2Int` excitation coincide → cancel | **open** | **learn** (both matrices written) |
| Content alone | no `S1Cue` activity, no inhibition | **open** | **recall by content** |
| Cue alone | `S1Cont` fires one step *later* (via recall), so inhibition arrives **before** the excitation | **closed** | **recall by cue** (S2 protected from a post-before-pre volley that would erase the item) |

There is no opcode input and no controller. **The store types its own request from a 1 ms delay differential** — the operation is a function of the input's temporal structure, which is a property only a spiking substrate has.

The `S2Cue` recurrent inhibition serves the complementary job: it suppresses recall-by-content *during* learning and forgetting, which would otherwise activate cues of unrelated memories in an order that erases parts of them ("memory leakage").

---

## The four operations, priced

| Operation | Mechanism | Latency (1 ms steps) | Minimum gap to next op |
|---|---|---|---|
| **Learn** | pattern held at input for **3 consecutive steps** — two coincident pre/post activations are needed for enough potentiation, and the refractory period forbids two in a row | 7 | 7 |
| **Recall by cue** | one-hot cue → STDP-weighted fan-out in S1 | 6 | 6 |
| **Recall by content** | content → S2Cont → STDP fan-in to `S2Cue`; returns the **union** of every cue sharing ≥1 content unit | 6 | 6 |
| **Forget** | never invoked; falls out of Learn (below) | — | — |

Underlying constraint: **≥4 steps between two STDP activations**, or the two operations interfere and the stored content degrades. Everything above is that constant plus pipeline depth.

### Forgetting is a side effect of writing, and its address is computed by the refractory period

Present a new memory on a cue that is already occupied. Within the 3-step write window:

1. steps 1 and 3 — new cue and new content fire together → **potentiation** of the new association;
2. step 2 — the cue, alone for one step, performs a recall-by-cue of the *old* content. That content fires **after** the cue, i.e. post-before-pre with respect to the `S1Cue → S1Cont` synapses → **depression**, tuned so a single activation suffices;
3. old content units that are *also* in the new memory fired at step 1 and are therefore **refractory** at step 2 — they never join the depressing volley and their new associations survive.

So the erase is (i) never commanded, (ii) addressed exactly at the cue being overwritten, and (iii) made selective at unit granularity by a membrane property rather than by a comparison. This is the closest thing in the wiki to the relevance-addressed erase [[wiki/concepts/memory-read-and-erase.md]] specifies and gap **G49** says nothing implements — with the qualification that "relevance" here means only "shares my cue", which is `replace`, not `suppress`.

---

## Results

| Experiment | Configuration | Outcome |
|---|---|---|
| Operation test | 5 memories × 15 units (5 cue + 10 content), 86 ms | 3 learns, 2 recall-by-cue, 3 recall-by-content, 1 learn-with-forget, all correct; recall-by-content from a multi-unit query returns the sum of the per-unit recalls |
| **MemTest86** adaptation (3 sweeps: identity content, complement, complement again) | same 5×15 model, **851 ms** | **60 operations** — 15 learns (10 of them overwriting), 15 recall-by-cue, 30 recall-by-content — at maximum operation rate and maximum occupancy, content consistent throughout |
| Robot environment map | 4×4 grid, 16 cues × 6 content units (one per position state) | after a 112 ms traverse, four successive **single-operation** queries ("which positions are on the path / obstacle-free / obstacles / unknown") each answered in 6 ms |
| Non-orthogonal patterns | overlapping contents | Works — the prior spiking-CAM proposals it cites worked only for orthogonal patterns |

The robot experiment is the one that shows what the reverse read is *for*: a spatial search that would otherwise be a scan over 16 stored maps becomes one 6 ms memory operation with no iteration and no comparison.

---

## Limitations

| Limitation | Statement |
|---|---|
| **It is a register file, not an associative store, on the cue side** | The cue is one-hot, so the number of storable memories **equals the number of cue units** and cue addressing is not associative at all — it is a decoder. Against `p_max ≈ k·C^RC/(a ln(1/a))` ≈ 36,000 for CA3 ([[wiki/entities/rolls-treves-hippocampal-model.md]]) or 800,000 for [[wiki/entities/btsp-cam.md]], the 5- and 16-memory demonstrations are not a capacity claim, and the paper makes none. **What is demonstrated is the operation set, not the store.** |
| **The sparsifier that would justify the one-hot cue is absent** | The dentate-gyrus stage is assumed, not built; the paper lists it as future work. Until it exists, "the cue must be correctly dispersed" is a precondition on the *caller*, which means the hard half of addressing has been moved outside the model |
| **Recall by content returns cues, not memories** | And it returns the **union** over any-overlap, with no score, no threshold and no ranking — asking for the *best* match is inexpressible. The paper names both an exact-match variant and a return-the-whole-memory variant as future work |
| **Residual STDP wear** | The forgetting decrement must be large enough that one activation erases; consequently every memory whose content *partly* participates in an unrelated operation is degraded a little. There is no measurement of how many operations this survives |
| **Platform-level weight decay** | SpiNNaker's STDP implementation has a residual >0 term at long inter-spike intervals, so dynamic weights degenerate on **every** operation regardless of the model |
| **Operations are serialised on a global clock** | 4-step STDP separation, 6–7-step pipeline. Two queries cannot overlap, and there is no account of what a concurrent read/write would do beyond "degradation" |
| **Not compared to non-spiking CAM** | The competitiveness claim ("6 steps is competitive with state-of-the-art CAM") is explicitly conditioned on a direct hardware implementation that does not exist |

---

## Where it sits among the wiki's stores

| | [[wiki/entities/hopfield-network.md]] | [[wiki/entities/sparse-distributed-memory.md]] | [[wiki/entities/btsp-cam.md]] | **This model** |
|---|---|---|---|---|
| Read directions | 1 (any part → whole) | 1 | 1 | **2** (cue→content, content→{cues}) |
| Cost of the second direction | — | — | — | **a second weight matrix + a 2-interneuron arbiter** |
| Address | content itself | fixed random | learned gating | **one-hot cue supplied by the caller** |
| Capacity | `0.14N` | `τ ≈ 0.10·M` | ~800k (theory) | **= number of cue units** |
| Erase | overwrite / spurious minima | graded cross-talk | involution parity | **emitted by the write, addressed by cue, selective by refractoriness** |
| Operation type | implicit | implicit | implicit | **decoded from input timing** |
| Reported latency | ~100 relaxation steps | 1 step | 1 step | 6–7 ms steps |

---

## Why it matters for a reasoning model

- **The reverse read is a distinct primitive, and it costs a duplicate store.** [[wiki/concepts/latent-graph-discovery.md]]'s instance graph needs both "what is attached to node `n`?" and "which nodes carry attribute `a`?", and the second is what every key-value design answers by scanning. This paper's answer — keep two matrices and arbitrate — is crude but it is a *measured* price, and it sets the bar any cheaper scheme has to beat. The only other bidirectional store in the wiki, [[wiki/entities/mm-tem-hippoformer.md]], buys the same property with an auxiliary supervised loss on **one** store, which is the cheaper option and pays in requiring an outer loop.
- **An operation code recovered from timing, not received from a controller.** [[wiki/concepts/memory-read-and-erase.md]] concludes that the removal *type* is control-layer information that never reaches the carrier. Here the type is recovered *inside* the carrier from a 1 ms delay differential, and the controller emits nothing but content. That is a substrate-specific capability with no rate-network analogue — a concrete deposit on [[wiki/empirical-tensions.md]] T1, and a cheaper answer to G49's typed-removal requirement than a control channel.
- **(brainstorm) The refractory period is being used as a set-difference operator.** Step 2's depressing volley reaches `old_content` but the units in `old_content ∩ new_content` are silenced by their own refractoriness, so the erase lands on `old \ new` exactly. No comparison, no mask, no bookkeeping — a set difference computed by a membrane time constant. Any store built on units with a refractory period gets this for free, and none of the wiki's machine stores has a unit-level state that could express it.
- **(brainstorm) It evades the retrieval-capacity bound by refusing to rank.** [[wiki/concepts/retrieval-capacity.md]] bounds how many top-`k` subsets a `d`-dimensional inner-product store can address, `C(n,k) ≤ (1 + 1/γ)^d`. Recall-by-content is not a ranking at all — it is a Boolean OR over stored content rows, so the addressable answer sets are exactly the unions of those rows, no margin required and no dimension spent. The price is precisely what the bound was buying: you cannot ask for the best match, only for everything that touches. Worth stating as a design axis the wiki has not had — **rank-free retrieval trades selectivity for unbounded addressability.**
- **The demonstration to copy is the robot query, not the memory.** Turning "which of my 16 stored positions have state X" from a 16-way scan into one 6 ms store operation is the shape a planner wants from an instance-graph store, and it is what recall-by-cue alone cannot give.

---

## Connections

- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the same CA3 read as a recurrent autoassociator with closed-form capacity, and the contrast that dates this one: there the recurrent collaterals *are* the store and dilution is the capacity argument, here CA3 is factored into two directed feedforward matrices with the recurrence demoted to an inhibitory arbiter — which buys a reverse read and gives up every capacity equation on that page.
- **[[wiki/entities/btsp-cam.md]]** — the other explicitly-CAM hippocampal store, and the complementary half: that one has capacity theory, one-step reads and no addressing decision; this one has a second read direction, a typed operation set and a store whose size equals its cue count. Neither has both, and their limitations are disjoint.
- **[[wiki/concepts/memory-read-and-erase.md]]** — the closest thing the wiki has to the specification that page writes: a relevance-addressed erase whose address is the overwritten cue and whose per-unit selectivity comes from the refractory period, plus an operation type decoded from input timing rather than supplied by a controller. It implements `replace` correctly and still has no `suppress`, and its read has no schedule (G49).
- **[[wiki/entities/spiking-neural-networks.md]]** — the substrate cashing out as a *capability* rather than as efficiency: the four-way operation demultiplex is a 1 ms delay comparison, which is exactly the coincidence-detection primitive that costs one spiking unit and `Ω(n)` sigmoidal ones — an instance of the substrate argument applied to memory control instead of to classification.
- **[[wiki/concepts/pattern-separation-completion.md]]** — takes the separation limit as an axiom rather than as a mechanism: the cue is one-hot because the dentate gyrus is assumed to sparsify maximally, so the store sits permanently at the separation extreme with no bias to set (G38) — and pays for it by requiring the caller to supply an already-separated address.
- **[[wiki/concepts/retrieval-capacity.md]]** — a store outside that page's bound: recall-by-content is a Boolean OR over stored content rows rather than an inner-product ranking, so its addressable answer sets need no margin and no dimension, and the price is that "best match" is not expressible.
- **[[wiki/entities/mm-tem-hippoformer.md]]** — the other bidirectionally-addressable store in the wiki and the cheaper route to it: supervised auxiliary losses (`x → g`, `g → g`) on a single fast-weight memory, against this page's two physical matrices plus an interneuron arbiter — bidirectionality as an objective versus bidirectionality as wiring.
- **[[wiki/concepts/synaptic-plasticity.md]]** — STDP used as a *protocol* rather than as a learning rule: the sign of `Δw(Δt)` is the whole mechanism for learning, for erasing and for keeping the two apart, so the store's correctness depends on the rule's time constants and on the platform's residual-decay term rather than on any objective.
- **[[wiki/concepts/temporal-coding.md]]** — spike timing carrying *control* information rather than stimulus content: the operation being requested is encoded in the inter-volley interval between cue and content, which is the only case in the wiki where a code's referent is the memory operation itself.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — inhibition as an arbiter rather than as a sparsifier: two interneuron populations, one delayed inhibitory all-to-all projection and one recurrent inhibitory collateral, exist solely to prevent the two read directions from corrupting each other's weights.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies an edge-store with two query directions and no discovery: attributes can be looked up from a node and nodes from an attribute, but the cue vocabulary is supplied one-hot by the caller and nothing here proposes, merges or names a node.
