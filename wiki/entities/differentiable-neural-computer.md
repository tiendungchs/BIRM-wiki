# Differentiable Neural Computer (DNC)

**A recurrent controller coupled to an external `N × W` memory matrix through three differentiable addressing modes — content lookup, temporal linkage and usage-based allocation — trained end to end by gradient descent** (Graves et al. 2016).

The wiki quoted this system second-hand for a long time (via Hassabis et al. 2017, on [[wiki/concepts/working-memory.md]]) as *the* demonstration that control/storage separation buys graph traversal. This page is the primary source, and the thing worth taking from it is not the traversal result but the **addressing scheme**: the DNC is the wiki's only store whose write policy names, separately and differentiably, *where to put a new thing*, *what order things were put in*, and *what may be thrown away*.

---

## Architecture

| Component | Form |
|---|---|
| Controller | `(υ_t, ξ_t) = N([χ_1; …; χ_t]; θ)`, deep LSTM; input `χ_t = [x_t; r_{t−1}^{1..R}]` (previous read vectors concatenated to the input) |
| Output | `y_t = υ_t + W_r [r_t^{1..R}]` — a second path from memory to output, because feeding the current reads back into the controller would cycle the graph |
| Memory | `M_t ∈ R^{N×W}`; behaviour independent of `N` while not full, which is why the memory is called *external* |
| Read | `r_i = Σ_j M[j,·] w^r_i[j]`, `R` read heads |
| Write | `M_t[i,j] ← M_{t−1}[i,j](1 − w^w[i] e[j]) + w^w[i] v[j]` — erase-then-add, **one** write head |
| Interface vector `ξ_t` | write key `k^w`, write strength `β^w ∈ [1,∞)`, erase `e ∈ [0,1]^W`, write vector `v`, `R` read keys + strengths, `R` free gates `f_i ∈ [0,1]`, allocation gate `g^a`, write gate `g^w`, `R` read modes `π_i ∈ S_3` |

Weightings live in the "corner of the cube" (non-negative, sum ≤ 1), so a head may also attend to *nothing*.

### The three addressing modes

| Mode | Mechanism | What it buys |
|---|---|---|
| **Content lookup** | `C(M, k, β)` — softmax of `β ·` cosine similarity between key and every row | Associative recall; a *partial* key still attends strongly, so the read returns information absent from the key (pattern completion). Because a row's content can name other rows, key–value retrieval gives **pointers** and hence traversable data structures in memory |
| **Temporal linkage** | `L_t[i,j] ≈ 1` iff `i` was written immediately after `j`; precedence `p_t` tracks the last-written location; `f_i = L_t w^r_{i,t−1}` (forward), `b_i = L_t^⊤ w^r_{i,t−1}` (backward); diagonal forced to 0 | Recovery of sequences **in write order even when the writes were not adjacent in time or in address** — the property the NTM only had while it kept iterating over consecutive indices |
| **Dynamic allocation** | retention `ψ_t = Π_i (1 − f_i w^r_{i,t−1})`; usage `u_t = (u_{t−1} + w^w_{t−1} − u_{t−1} ⊙ w^w_{t−1}) ⊙ ψ_t`; free list `φ_t` = indices sorted by ascending usage; allocation weighting `a_t` picks the least used | A differentiable free list. Usage rises on write and falls when a read head opens its free gate, so the controller **reclaims** memory. Allocation is independent of memory size and content: train at 256 locations, deploy at more, no retraining |

Two gates then compose the modes into policies:

```
w^w = g^w [ g^a a_t + (1 − g^a) c^w ]          write: allocate a fresh slot vs. edit an existing one, vs. don't write
w^r_i = π_i[1] b_i + π_i[2] c^r_i + π_i[3] f_i  read: what came before, what matches, what came next
```

**This is the sharpest object on the page.** `g^a` is an *allocate-vs-reuse* decision emitted per step by a learned controller — gap G38's knob, in a machine, as a runtime variable rather than a design-time constant. The caveat is equally sharp: it is trained by backpropagation through time against task loss, so nothing makes it respond to *completion error* the way biology's candidates do.

**Cost.** `L` is `N × N`, `O(N²)`. Sparsifying `w^w` and `p` to their top `K` entries gives `O(N log N)` compute and `O(N)` memory with `K = 8` sufficient regardless of `N`, and no measurable loss (`K` between 2 and 20 behaves identically). The allocation sort is non-differentiable; its gradient discontinuities are simply ignored, apparently harmlessly.

---

## Key results

| Task | DNC | Baseline |
|---|---|---|
| bAbI, 20 question types jointly, **word-level** tokens (no sentence embeddings) | 3.8% mean error, 2 tasks failed (>5%) | 7.5% / 6 failed for the best previous jointly-trained result (MemN2N); LSTM and NTM much worse |
| Random-graph traversal curriculum | 98.8% on the final lesson after ~1M examples | Best LSTM from an extensive sweep: 37% after ~2M examples, never cleared lesson 1 |
| London Underground, 7-step traversal, **zero retraining** | 98.8% | — |
| London Underground, all 4-step shortest paths | **55.3%** | — |
| Family tree, 4-step relation inference (a relation label aliases a 2–5 edge sequence the network is *never shown*) | 81.8% | — |
| Mini-SHRDLU (RL; policy-DNC + value-DNC, policy gradient; ≤10 goals × 6 constraints) | Completed the 25-lesson curriculum; solves most instances optimally | LSTM never completed the curriculum in 20 seeds |
| Copy, 10 slots for 50 vectors, feedforward controller | Free gates fire on read, allocation gate on write — the same 10 slots recycled | — |
| Copy, link matrix disabled | Fails (order unrecoverable) | `K = 5` sparse ≈ dense |

### What the analyses show, which matters more than the scores

- **The memory layout mirrors the data structure.** One graph triple per location; the number of locations needed tracks the number of triples, and a network trained with 256 slots exploits whatever it is given at test time.
- **Two heads, two addressing modes, simultaneously.** On Underground traversal, read head 1 rides temporal links *forward* to replay the query's edge list in order while read head 2 uses *content lookup* to find the station triples. The read-mode vector is a learned division of labour between a trajectory address and a content address.
- **The plan is written before it is executed.** In Mini-SHRDLU the first action is decodable by logistic regression from the memory contents *at the time-step the goal was written* — up to ~60 steps before the action — at 89% vs. 17% for an action-frequency baseline. Goal labels are geometrically clustered in location contents (t-SNE).
- **Curriculum learning was essential everywhere except bAbI**, with 10% of exemplars drawn from earlier lessons to stop regression, and shortest path additionally needed DAGGER-style mixing with an optimal planner.

---

## Limitations

| Limit | Consequence |
|---|---|
| The graph is **given as input** in every graph task | Tests the *navigate* half of latent-graph discovery only; no edge or vocabulary is inferred from observation (the inference task infers *relation sequences*, which is vocabulary induction over a hand-fixed 400-label alias set — the one partial exception) |
| Shortest path on the real map: 55.3% | The hardest task fails more often than not, on the smallest realistic graph tested |
| Curriculum + expert mixing required | Nothing in the architecture makes the search tractable from the target task alone |
| ≤512 locations; scaling untested | The regime the authors want — memory holding more than the controller's weights, knowledge acquired without parameter updates — is stated as future work |
| One write head | No concurrent edits; the write is a single erase-then-add per step |
| Reads are `O(N)` per head per step | Every read touches every location; nothing prunes the search over slots the way content-addressing is supposed to |
| Nothing consolidates | Memory content never migrates into controller weights (gap G14); the "regularities in weights, variability in memory" split is asserted in the discussion and never trained for |
| The planning phase is hand-scheduled | Shortest path and inference get a fixed 10-step input-free window to compute in — the *when/how deep* of gap G15 supplied by the experimenter |

---

## Comparison

| | DNC | NTM (predecessor) | LSTM | [[wiki/entities/pbwm.md]] | [[wiki/entities/tem-transformer.md]] |
|---|---|---|---|---|---|
| Where to write | Content lookup **or** least-used location, one learned gate | Content **or** index-shift from the last address | Every cell, every step | Learned Go/NoGo per stripe | By fiat, every token |
| Interference control | Free list allocates single locations irrespective of index | None — allocated blocks can overlap | — | Stripes are disjoint by construction | None (one shared cache) |
| De-allocation | Free gates, per read head | **None** — no reuse over long sequences | Forget gate (destructive, in place) | Go overwrites (no separate erase) | — |
| Write order recoverable | Yes, via `L`, across jumps | Only while iterating consecutively | Implicit in the state | No | No |
| Credit for the write policy | BPTT | BPTT | BPTT | RL from an associative critic | — |

---

## Reading it against the wiki

- **Three addresses, and the fourth is the one the wiki needs.** The DNC can address by *content* (`x`), by *write order*, and by *vacancy*. It cannot address by **structural position** — nothing answers "the location standing in relation `r` to this one" except by storing the relation as content and chasing pointers. Temporal linkage is the only non-content address in the system and it encodes the *writer's trajectory*, not the *data's topology*: replay the same graph in a different input order and `L` is different while the graph is not. Gap G3's `g` is exactly the missing mode.
- **Two addressing modes for one store beats one.** The traversal analysis is the wiki's clearest demonstration that read heads specialise: a *sequence* address and a *content* address running in parallel on the same matrix. **(brainstorm)** [[wiki/entities/mm-tem-hippoformer.md]] found the same shape one level up — a short precise window plus a long structural store, both beating either alone. The DNC gets the analogous split for free out of `π_i` without two memories.
- **Temporal linkage is the Temporal Context Model, discretised.** `L w` forward, `L^⊤ w` backward is the contiguity effect with a sign asymmetry available as a learned prior on `π`; the authors make the connection themselves. **(brainstorm)** TCM's forward-asymmetric contiguity curve is a *fixed* mixture of `f` and `b`; the DNC's is emitted per read per step, so a machine version of free recall would predict the asymmetry to be task-dependent rather than constant.
- **The plan-before-act result is the cheapest thing here to steal.** Nothing in the training objective asked the DNC to decide its first move while reading the instructions; it did, because writing a *decision* is cheaper than re-deriving it from constraints at execution time. That is amortisation of a rollout into a store — an alternative to the rollout-control policy gap G15 asks for, rather than an instance of it.
- **The hippocampal parallels are the authors' own and are structural, not evidential**: one-shot write ≈ CA3/CA1 associative LTP; usage-based allocation and sparse weightings ≈ dentate neurogenesis raising representational sparsity and capacity; temporal links ≈ hippocampus-dependent free-recall contiguity. None is tested; they are offered as convergence, and the mechanisms were chosen for computational reasons.

---

## Connections

- **[[wiki/concepts/working-memory.md]]** — the primary source for this page's long-standing claim that control/storage separation makes a differentiable network do explicit graph traversal, and the place where the store's *controller* (a learned read/write policy) is specified rather than assumed.
- **[[wiki/concepts/latent-graph-discovery.md]]** — navigates a *given* graph and discovers none of it: the traversal, shortest-path and inference tasks all receive the edge set as input, so this is evidence about the navigate half only, with the relation-alias induction as the single partial exception.
- **[[wiki/concepts/attention.md]]** — content lookup is soft attention used as a memory read, and the read-mode vector `π` is the wiki's clearest case of attention *switching between address spaces* (content vs. write-order) rather than between items.
- **[[wiki/concepts/compositionality.md]]** — the concrete instance of "differentiable programming": pointers (a row's content naming another row) are what make composition over data structures possible here, and are also why the learned program reads as assembly rather than as a causal model.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the flagship product of the central-executive/buffer transfer, and a case where the borrowing was avowedly computational first with the biological parallels (CA3 one-shot write, dentate sparsity, free-recall contiguity) noticed afterwards.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the allocation gate `g^a` is a learned, per-step separate-vs-complete decision (gap G38's runtime knob in a machine), with usage playing the role of the sparsity/novelty signal — but trained against task loss, not against completion error.
- **[[wiki/concepts/complementary-learning-systems.md]]** — states the CLS division as a design target (regularities in the controller's weights, episode-specific variability in the memory matrix) and supplies no consolidation channel between them, which is gap G14 in one architecture.
- **[[wiki/concepts/simulation-based-planning.md]]** — plans by *writing the decision down* rather than by rolling out: the first Mini-SHRDLU action is decodable from memory ~60 steps before execution, so search happens at write time and execution is a read.
- **[[wiki/entities/temporal-context-model.md]]** — the same contiguity mechanism in discrete form: `L w` / `L^⊤ w` are forward and backward recall over write order, but the mixture is emitted per step by a controller instead of being a fixed drift rate, and the link is to the writer's trajectory rather than to a decaying content trace.
- **[[wiki/entities/pbwm.md]]** — the biological counterpart of the write gate with the credit problem solved differently: a per-stripe Go/NoGo trained by reinforcement from an associative critic, versus a write/allocation gate trained by backpropagation through time.
- **[[wiki/entities/maze-solving-transformers.md]]** — the control condition for this page: the same class of graph task solved with *no* external store, the whole maze held in one token's residual stream, showing that the external matrix is a scaling and interference argument rather than a possibility argument.
- **[[wiki/entities/mm-tem-hippoformer.md]]** — the same "two access disciplines beat one" result at the level of separate memories (short precise window + long structural store), which the DNC obtains inside one matrix by giving each read head its own read-mode mixture.
- **[[wiki/entities/h-jepa.md]]** — the same key-value store proposed for *world state* instead of episodic content, with the same threshold-triggered slot allocation; the DNC supplies the trained precedent for that allocation rule and shows it recycles slots under pressure.
- **[[wiki/entities/sparse-distributed-memory.md]]** — the fixed-address ancestor: addressing there is random and frozen with only contents plastic, so capacity is closed-form; here addressing is learned and dynamic, which buys reuse and pointers and loses any capacity accounting.
- **[[wiki/concepts/cognitive-map.md]]** — the subway-map result is route planning with the map handed over, which is the boundary case that page's non-spatial and inferential findings sit beyond.
- **[[wiki/entities/stsp-working-memory-rnn.md]]** — the opposite trade on the same separation: storage is split from computation with no memory matrix, no addressing and no write policy (whatever fires is written, and decay is the only forget gate), which costs every capability this page's addressing buys and gains a store that survives ablation of half the network's synapses.
