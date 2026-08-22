# Vector-HaSH (Vector Hippocampal Scaffolded Heteroassociative Memory)

**A memory whose fixed points are built *before* any content arrives: a frozen grid-cell state set randomly projected into hippocampus generates exponentially many equal-sized attractors, and arbitrary content is then hung onto them by a separate plastic feedforward layer — so capacity and content are optimised independently, and sequences are stored as 2-D velocity vectors rather than as states.** (Chandra, Sharma, Chaudhuri & Fiete 2023)

The wiki's first memory architecture whose capacity is *derived* rather than tuned and whose overload is graceful rather than catastrophic — the direct answer to gap G42, and the first source to supply high capacity and structural reuse in one circuit ([[wiki/empirical-tensions.md]] T28).

> **Provenance.** `raw/chandra-2023-prestructured-hippocampal-memory.md` — Chandra, Sharma, Chaudhuri & Fiete, *High-capacity flexible hippocampal associative and episodic memory enabled by prestructured "spatial" representations*, bioRxiv 2023.11.28.568960 (published in *Nature*, 2024).

---

## Architecture

Three populations, four connection types, and the whole design is in which ones are allowed to learn.

| Connection | Plasticity | Role |
|---|---|---|
| Grid module internal recurrence | **Fixed, prestructured** | `M` modules, module `i` expressing `K_i` states on a 2-torus; jointly `∏_i K_i ≈ ⟨K⟩^M` states (coprime periods). Invariant across tasks, environments, sleep/wake |
| Grid → hippocampus (`N_g → N_h`) | **Fixed, random**, thresholded + rectified | High-rank random projection; the nonlinearity is what makes the resulting hippocampal state set *strongly full rank* |
| Hippocampus → grid | **Learned once** (Hebb-like), then frozen | Closes the loop so each grid state is a self-consistent fixed point |
| Hippocampus ↔ sensory/non-grid cortex (`N_s`) | **Bidirectionally plastic**, one-shot, online pseudoinverse (biologically plausible Hebb-like form) | Attaches content to a scaffold state — the only place memories live |
| Shift mechanism `v` | 2-D velocity input per module | Moves grid phases; driven by self-motion (spatial), by hippocampal state via a small MLP, or by *recalled sensory state* (episodic) |

The grid–hippocampal loop is the **scaffold**; the hippocampal–cortical loop is the **heteroassociative** layer. The paper's one-line thesis: **factorize the creation of fixed points from the storage of content.**

Read as an autoencoder, it is a maximally constrained one — fixed bottleneck code, fixed bottleneck dynamics, fixed decoder-side weights, all learning by local associative rules. It beats an unconstrained tail-biting autoencoder of the same layer sizes trained end-to-end with backpropagation.

---

## Results

| # | Result | Numbers |
|---|---|---|
| 1 | **All `∏K_i` grid states become stable fixed points** of the loop, for sufficiently large `N_h` | Numerics coincide exactly with closed-form theory; zero variance across random seeds; noise of 25% of state magnitude corrected in one round trip |
| 2 | **`N_h` grows linearly in the number of modules**, hence *logarithmically* in the number of fixed points, and is nearly independent of grid period | Fixed points exponential in scaffold neuron count |
| 3 | **No spurious minima; basins convex, uniform, maximal** | Proven (SI C.2/C.3) and confirmed numerically over all 3,600 fixed points |
| 4 | **Strong generalization** — learning the return weights on `O(M·K_max)` states makes *all* `O(K^M)` states fixed points | Requires the visited states to be traversed in **metric order** (a small contiguous region suffices). Random visiting order generalises far more weakly; shuffled non-grid patterns (MESH) generalise essentially not at all |
| 5 | **Memory continuum, not a memory cliff** | Perfect recall to `N_h` patterns; beyond, mutual information per pattern `∝ 1/N_patts`, saturating the theoretical bound `#synapses / (2·#patts)` all the way to the exponentially large scaffold capacity |
| 6 | **Recall precision is stratified** | Grid and hippocampal states recovered *exactly*; sensory state recovered only approximately — but **reliably**: every cue in a basin yields the same reconstruction, and it stays in the correct Voronoi cell of the memorised pattern |
| 7 | **Recognition memory for free** | A two-threshold classifier on *mean hippocampal firing rate* separates familiar from novel inputs |
| 8 | **Zero-shot spatial inference** | After one sparse traversal, landmarks along entirely novel routes are predicted, because path integration supplies the phases and the phases index the stored associations |
| 9 | **No catastrophic forgetting across 11 sequentially learned rooms** | No replay, no rehearsal, no consolidation pass. Random grid-phase initialisation per room puts maps far apart in the exponentially large coding space |
| 10 | **Sequence capacity via velocity, not via states** | Asymmetric Hopfield ≈50 steps; scaffold-assisted Hopfield ≈100; chaining *abstract grid states* ≈30 — all fail alike. Storing the **2-D shift** instead: 1.4×10⁴ states, and ~1.5×10⁵ steps at `N_h=500`, `N_g=275`, `λ=[5,9,13]` |
| 11 | **Episodic memory = sequence scaffold + heteroassociation** | Sensory recall fidelity degrades with sequence length, but per-step *identity* never drifts, because each step is cued by the exactly-recovered previous hippocampal state |
| 12 | **First circuit model of the method of loci** | Recalled (imprecise) landmarks of a familiar route act as a *second-order* scaffold with `N_s` states instead of `N_h`; new cortical items are then recalled near-perfectly deep into the memory continuum |
| 13 | **Hippocampal phenomenology** | Multiple-trace consolidation (repeated items survive simulated lesion better), splitter cells, route/directional/task-dependent tuning — all from context-triggered grid remapping; cross-room place-cell similarity statistics match recordings |

**Why the sequence trick works, stated generally.** Conventional sequence memory must reconstruct the whole next state from the current one — `O(N)` bits per step of recurrent storage. Vector-HaSH reconstructs only a **tangent vector on a low-dimensional manifold**, and the manifold's own dynamics regenerate the state. Recall length degrades as the *log* of the number of distinct admissible shift vectors, which is the exact statement of the cost model.

---

## The three claims worth stealing

1. **Prestructure the fixed points, then hang content on them.** The paper's clothesline image: in a Hopfield network the content decides where the minima are, their depth and their width, which is why the basins are uneven and spurious minima proliferate. Fix the landscape first with content-free states and the basins are provably convex, uniform and maximal — *content never touches the recurrent dynamics*.
2. **Reliability beats fidelity for anything that will be scaffolded again.** Sensory reconstruction is lossy but deterministic, and that is sufficient to serve as the address space for a second layer of memory (result 12). A lossy-but-repeatable decoder is a valid key; a high-fidelity-but-cue-dependent one is not.
3. **Store the increment, not the state.** Result 10 generalises past grid cells: any latent with an action algebra ([[wiki/concepts/path-integration.md]]) lets a sequence memory pay `log|actions|` bits per step instead of `O(N)`.

**(brainstorm)** Read against [[wiki/concepts/latent-graph-discovery.md]], Vector-HaSH is a complete *storage-and-addressing* layer for the instance level with the discovery layer deliberately absent: `g` is frozen at birth, the assignment of content to `g` is **random**, and the sequence of `g` traversed by a non-spatial episode is chosen by the modeller (a space-filling hairpin). It is therefore not a competitor to [[wiki/entities/tolman-eichenbaum-machine.md]] but the missing capacity substrate underneath it — TEM decides *which* `g` a state should get and has no capacity theory; Vector-HaSH has the capacity theory and decides nothing. The obvious merge is a TEM-learned map from observations to scaffold states over a Vector-HaSH scaffold, which nobody has built.

**(brainstorm)** The random content→scaffold assignment is also why result 9 holds, and it is the same primitive as the mossy-fibre randomization of [[wiki/entities/rolls-treves-hippocampal-model.md]] moved one stage earlier: orthogonality by hashing, with no allocate-vs-reuse decision to get wrong (G38). The cost is identical in both models — nothing recognises that two episodes are *the same kind of episode*, which is precisely what "enabling hierarchical and similarity-respecting representations for distinct but similar memories" is listed as future work.

---

## Limitations

| Limit | Consequence |
|---|---|
| **The scaffold is assumed, not learned** | Grid module count, periods and torus topology are given. Where a prestructured code for a *non-spatial* domain comes from is untouched — the model assumes one already exists and only exploits its algebra |
| **Content→address mapping is random** | No similarity structure survives storage; two near-identical memories are as far apart as two unrelated ones. Explicitly listed as future work |
| **The episodic trajectory is chosen by hand** | For non-spatial episodes the path through scaffold space is a modeller-supplied hairpin; nothing decides what sequence of `g` an event should occupy |
| **The shift is 2-D and unstructured** | Per-step information is capped, capacity declines as `log(#distinct shifts)`, and branching (a graph rather than a path) is not modelled at all |
| **Sensory detail is genuinely lost** | The memory continuum means MI per input bit `∝ 1/N_patts`; the model returns "the right memory, blurred", which is a design *choice* about what degradation looks like, not a way of avoiding it |
| **Random projections are shown sufficient, not necessary** | The paper draws the analogy with expander graphs: non-random constructions may exist and have been hard to find |
| **Anatomical prediction outstanding** | Requires the deep→superficial entorhinal projection to close a fully self-consistent loop — offered as a connectomic test, with recent reports of deep-EC copies back to hippocampus as the encouraging precedent |
| **No relational inference** | It stores and retrieves; nothing in it notices that two stored episodes share a form. Same shortfall as Rolls–Treves, now at exponential capacity |

**Hardness-source coverage** ([[wiki/concepts/latent-graph-discovery.md]]): source 3 (aliasing) ✓ — by random hashing plus path-integrated position · source 1 ✗ (the shared level is installed, not learned) · sources 2, 4, 5, 6 ✗.

---

## Comparison

| | Vector-HaSH | Hopfield / asymmetric Hopfield | MESH (Sharma et al.) | [[wiki/entities/tolman-eichenbaum-machine.md]] | [[wiki/entities/rolls-treves-hippocampal-model.md]] |
|---|---|---|---|---|---|
| Fixed points set by | Prestructured grid states | Stored content | Prestructured random patterns | Learned `g ⊙ x` conjunctions | Stored content in CA3 |
| Capacity | Exponential in scaffold size; `∏K_i` | `≈0.14N`, then **cliff** | Exponential | Unstated | `p_max ≈ kC/(a ln(1/a))` — ~36,000, then cliff |
| Overload behaviour | Graceful — MI per pattern `∝ 1/N_patts` | Total loss of all patterns | Graceful | — | Catastrophic |
| Grid–hippocampal weights | Random forward, learned-once return, then **frozen** | — | No grid code | **Learned throughout** | Learned (perforant path, Hebbian) |
| Strong generalization | Yes (`O(MK_max)` visits stabilise `O(K^M)` states) | — | **No** — needs exponentially many patterns | Generalisation is the model's point, by a different route | No |
| Sequence capacity | ~10⁵ steps (velocity-coded) | ~50 steps | Not addressed | Not a capacity model | 7±2 transitions (noise-driven) |
| Transfer to a new environment | Free (new random phase init) | None | None | The point of the model | None |
| Structure discovery | **None** | None | None | Yes | None |

The instructive row is the fourth. Vector-HaSH shows that making the grid↔hippocampal weights *learnable* collapses the capacity result — shuffled-but-statistically-matched hippocampal states with bidirectionally learned weights lose the exponential scaling entirely. Both TEM and Rolls–Treves learn exactly those weights ([[wiki/empirical-tensions.md]] T41).

---

## Connections

- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the same capacity question answered with the opposite topology: content-defined CA3 attractors with a closed-form bound and a cliff, versus content-free prestructured attractors with exponential capacity and a continuum; both use randomization to de-alias, but here it is the *grid→hippocampal* projection rather than the mossy fibres, and here the resulting place-like tuning needs no Hebbian training of the projection at all ([[wiki/empirical-tensions.md]] T41).
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the complementary half of the same anatomy: TEM learns *which* structural code a state deserves and has no capacity theory; this model has the capacity theory and assigns codes at random, so the two are stackable rather than rival, and it removes the standing objection that capacity and generalisation had no shared model ([[wiki/empirical-tensions.md]] T28).
- **[[wiki/concepts/path-integration.md]]** — extends the update rule beyond space: the same 2-D velocity shift that integrates self-motion is what makes *non-spatial* sequence memory high-capacity, because a step costs a tangent vector rather than a state, and the metric ordering of the visited states is also what buys strong generalization.
- **[[wiki/concepts/abstract-structural-codes.md]]** — supplies the sharpest functional reason for a `g` that is invariant and content-free: it is the **address space**, and freezing it is what makes the address book exponentially large and the basins uniform, while any content leaking into it destroys the capacity.
- **[[wiki/concepts/pattern-separation-completion.md]]** — separation without a separator: random projection from a prestructured code yields convex, uniform, spurious-free basins by construction, so the transfer curve is set once at design time rather than controlled at runtime (G38).
- **[[wiki/concepts/continual-learning.md]]** — catastrophic forgetting avoided with no weight protection, no replay and no task boundary: new environments take random scaffold states in an exponentially large space, so non-interference is a property of the address book rather than of the plasticity rule.
- **[[wiki/concepts/complementary-learning-systems.md]]** — the fast store priced and built: hippocampus as a content-independent *pointer* into cortex rather than a compressor of it, with the explicit finding that content-based compression (an autoencoder bottleneck) is the worse design.
- **[[wiki/concepts/cognitive-map.md]]** — the argument that the map machinery is not *for* space: spatial and episodic memory are co-localised because the low-dimensional vector-updatable code is what a high-capacity sequence memory needs, whether or not the episode has spatial content.
- **[[wiki/concepts/offline-replay.md]]** — a counterexample to replay's necessity for the interference job: 11 maps learned in sequence with zero forgetting and no replay at all, which narrows replay's remit toward consolidation and generalisation rather than protection.
- **[[wiki/concepts/energy-based-models.md]]** — the landscape designed rather than fitted: minima positioned, sized and shaped before any data arrives, which is the concrete alternative to shaping an energy function by training.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a complete instance-level store with the discovery layer removed by construction: the structural code is installed, the content-to-position assignment is random, and the traversal order is supplied.
- **[[wiki/entities/mm-tem-hippoformer.md]]** — the opposite bet on the same store, and together they bracket gap G42: that model learns everything including the memory's own update rule (fast-weight MLP, learned forget gate) and reports no capacity result at all, while this one installs the scaffold and derives capacity exactly — so the wiki has a capacity model with no learning and a learning model with no capacity model.
- **[[wiki/concepts/population-geometry.md]]** — this page's central cost argument confirmed as a measurement rather than a derivation: in mouse CA1 a sequence of cell activations is fully accounted for by a path on a ~5-dimensional manifold — identity at TPR 0.87 / FPR 0.14 from 5 latents, and inter-event *timing* from path length — which is "store a tangent vector and let the manifold regenerate the state" observed in a real circuit, for sequences too rare (3.6% of trials) to have been learned pairwise.
- **[[wiki/entities/sparse-distributed-memory.md]]** — this page's design split (fixed addressing stage, plastic contents stage) stated thirty years earlier without a grid code, which isolates what the scaffold actually buys: the random address sample gives capacity `0.1·M` and no way to move between neighbouring addresses, while a path-integrable address space gives exponential capacity and zero-shot inference at the price of assuming the code. It also supplies the caution behind this page's own random-assignment limitation — random addressing is optimal only for uniform data, and every fix known there is to draw the addresses from the data distribution or adapt the activation radius per location ([[wiki/empirical-tensions.md]] T55).
- **[[wiki/entities/dense-sequence-memory.md]]** — the rival account of this page's Result 10: the ≈50-step asymmetric-Hopfield baseline dismissed here is weak because of its *interaction function*, and sharpening that function alone gives exponential sequence capacity while still paying `O(N)` bits per step, against this page's `log|actions|` ([[wiki/empirical-tensions.md]] T57).
- **[[wiki/entities/hopfield-network.md]]** — the design this page directly rebuts: there content decides where the minima sit and how deep and wide they are, which is the common cause of uneven basins, spurious states and the `0.14N` cliff; prestructuring the fixed points removes content from the recurrent dynamics entirely.
- **[[wiki/concepts/attractor-dynamics.md]]** — the prestructured-scaffold regime — where the fixed points come from frozen dynamics rather than from the stored content, which is what makes the basins convex and the overload graceful.
- **[[wiki/entities/btsp-cam.md]]** — the other way to put randomness before content, and the counterexample to doing it *in advance*: here the random gate is applied **during** learning, so the resulting projection is tailored to the ensemble actually stored and acquires basins, which a frozen projection of the same density cannot have.
- **[[wiki/entities/gcq.md]]** — the same frozen grid scaffold pointed at perceptual compression rather than memory capacity: bumps as codewords, actions as bump displacements, and an `n`-frame sequence stored as one index plus the shifts — this page's "store the tangent vector, not the state" result restated for an encoder. Both get their properties from the scaffold being frozen and neither explains where it comes from (G47).
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the same content-free-address argument applied to *roles*: HRR role vectors are drawn i.i.d. random precisely so binding does not leak content into the address, which is this page's condition for exponential address capacity stated for a relational code instead of a spatial one.
- **[[wiki/concepts/random-feedback-addressing.md]]** — a second job for a frozen random projection: here randomness makes basins convex and spurious-free on the way in, there it makes off-target feedback cancel on the way out — and both properties are destroyed by the same modification, making the projection depend on the content it carries.
- **[[wiki/concepts/multi-token-embedding.md]]** — the same address-then-look-up factorisation as it appears in a pretrained transformer, with both halves left implicit: the early MLPs compute an address for *any* token combination but hold an entry only for entities seen in training, so the addressing is total and the table partial — this page is what that scheme looks like when capacity is derived and the write is exposed at inference.
