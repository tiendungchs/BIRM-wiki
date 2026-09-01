# ESBN (Emergent Symbol Binding Network)

**Binding by *co-location in two aligned lists*, not by an algebraic operation on a compound. A controller writes a key it invents; the perceptual encoder writes the image embedding as the value; the two never meet in a vector. Because the controller sees the image only through the key it gets back, the rule it learns cannot be a function of the entity — and near-perfect generalisation to entities never seen follows, from as few as two training entities.**

> **Provenance.** Webb, Sinha & Cohen, *Emergent Symbols through Binding in External Memory*, ICLR 2021 (`raw/webb-2021-emergent-symbols-external-memory.md`, ar5iv HTML of arXiv:2012.14601). Code released. All numbers below are that paper's, mean ± SEM over 10 trained networks.

---

## Architecture

Two streams, one shared row index.

| Stream | Component | What it emits | Sees |
|---|---|---|---|
| Perceptual | encoder `f_e` (3 conv layers → FC 256 → FC 128) | value `z_t` — the image embedding, **unmodified by the controller** | the image `x_t` |
| Control | LSTM controller `f_s` (1 layer, 512 units) + output heads | key `k_{w_t}` (256, ReLU), gate `g_t` (1, sigmoid), prediction `ŷ` | **only `k_{r_{t-1}}`** — the key retrieved last step |

Memory is two matrices grown by one row per step: `M_k` (keys, controller-authored) and `M_v` (values, encoder-authored). Row `i` *is* the binding.

```
w_{k_t} = softmax(M_{v_{t-1}} · z_t)                          # address by perceptual match
c_{k_t} = σ(γ (M_{v_{t-1}} · z_t) + β)                        # per-row confidence, γ β learned
k_{r_t} = g_t · Σ_i w_{k_t}(i) ( M_{k_{t-1}}(i) ‖ c_{k_t}(i) )   # retrieve key, gated
M_{k_t} ← {M_{k_{t-1}}, k_{w_t}} ;  M_{v_t} ← {M_{v_{t-1}}, z_t}  # write
```

**Three properties fall out of the wiring, not out of training:**

1. **Indirection.** The read is keyed by a *value* and returns a *key* — query with what you see, get back what you called it. The reverse direction (query key → return value, for prediction in image space) is available and not used here.
2. **Total entity-blindness of the controller.** `z_t` never enters `f_s`. The LSTM has no channel through which an entity identity could reach the rule.
3. **No unbinding operator, and none needed.** The constituents were never combined, so role-filler independence during binding is free — the cost is that the binding is not a vector and cannot be superposed, compared or nested.

**Temporal context normalization (TCN)** — normalise `z_1 … z_T` over the problem's own temporal window rather than over the batch — is applied to all models. It is load-bearing rather than cosmetic; see T322.

---

## Tasks and the generalisation protocol

100 Unicode characters as entities; `m` of them **withheld** from training, tested only on the withheld `m`. `m = 98` on same/different means the model was trained on **4 problems built from 2 entities**.

| Task | `T` | Relation arity | Minimum entities |
|---|---|---|---|
| Same/different | 2 | binary | 2 |
| Relational match-to-sample (RMTS) | 6 | binary-of-binary | 4 |
| Distribution-of-three (stripped-down RPM row rule) | 9 | **ternary** | 3 |
| Identity rules (visual ABA/ABB/AAA — Marcus et al.'s infant task) | 9 | **ternary** | 4 |

Training sets are `10⁴` problems out of a space `~10⁹`; at `m ≥ 95` only a few hundred (or 4) problems exist to train on. This protocol is the paper's real instrument: the withheld-entity sweep turns "does it generalise" into a dose–response curve, which is what `G17` asks benchmarks for.

---

## Key results

Test accuracy, all models with TCN, hardest regimes only (full tables in the source's A.5.1):

| | Same/diff `m=98` | RMTS `m=95` | Dist-of-three `m=95` | Identity rules `m=95` |
|---|---|---|---|---|
| **ESBN** | **100.0 ± 0.0** | **95.0 ± 0.7** | **99.7 ± 0.1** | **99.2 ± 0.4** |
| Transformer | 72.3 ± 5.2 | 79.8 ± 2.5 | 32.1 ± 1.0 | 67.1 ± 2.4 |
| NTM | 53.3 ± 1.4 | 80.1 ± 2.3 | 34.0 ± 0.5 | 64.9 ± 1.2 |
| MNM (Metalearned Neural Memory) | 52.3 ± 0.5 | 50.0 ± 0.2 | 32.2 ± 0.6 | 61.5 ± 1.5 |
| LSTM | 54.8 ± 1.1 | 60.7 ± 3.7 | 34.8 ± 0.8 | 62.5 ± 1.1 |
| PrediNet | 61.6 ± 2.3 | 68.4 ± 2.7 | 27.8 ± 0.5 | 59.9 ± 2.6 |
| Relation Net (RN) | 66.8 ± 6.6 | 79.6 ± 2.1 | 26.5 ± 0.3 | 41.4 ± 2.0 |

(Chance: 50% binary, 25% four-way.) ESBN is flat across `m`; every alternative has a cliff. **Sample efficiency separates as sharply as accuracy**: ESBN converges in **100–200 updates**, the others in thousands to tens of thousands.

### The three analyses that carry the argument

| Analysis | Result | What it rules out |
|---|---|---|
| **Encoder swap** (conv → MLP → *untrained random projection*) | ESBN unchanged (`p = 0.1`, `p = 0.13` paired-`t` across all task×`m` cells); Transformer significantly hurt by the random projection (`t = −4.0`, `p = 0.001`) | That the generalisation is convolutional shape-transfer. ESBN generalises over an **arbitrary** entity encoding — the rule is abstracted from the code, not just from the identity |
| **Key PCA** (distribution-of-three, `m = 95`) | Keys written at `t = 1,2,3` are tightly clustered and **completely overlapping between train and test**; keys at `t = 4…9` diffuse and disjoint from them; keys *retrieved* on second appearance match the written distribution | That the controller learned entity-specific keys. It learned `first image`, `second image`, `third image` — variables whose representation does not move when the values do |
| **Confidence ablation** | Same/different collapses to **50.0** (chance); RMTS slows; distribution-of-three and identity rules **unaffected** | That `c_k` is a nicety. Tasks needing only *which* row matched are indifferent to it; tasks needing *how well* it matched cannot be done without it — a recollection/familiarity dissociation falling out of an ablation |

The confidence channel has an architectural substitute: seeding memory with **one learned default key/value row** restores 100.0 at every `m` on same/different without any explicit confidence value, because a novel item then retrieves a *mixture* of weakly-matched rows and the mixedness is itself the familiarity signal. This is the wiki's cleanest instance of a metacognitive signal obtained for free from a store's own read geometry rather than from a calibration head ([[wiki/concepts/selective-prediction.md]], [[wiki/concepts/metacognitive-efficiency.md]]).

---

## Where it sits among the wiki's binding schemes

| | ESBN | HRR/VSA | LISA | PBWM | TPR |
|---|---|---|---|---|---|
| Binding carrier | **Row index of two aligned lists** | Algebraic `⊛` on one vector | Phase | Gated stripe (address) | Outer product |
| Constituents preserved while bound? | **Yes, trivially — never combined** | No (recoverable only by `†`) | Yes | Yes | Yes |
| Similarity on the bound object? | **No** — there is no bound vector | Yes (dot product) | No | No | Partial |
| Nesting / superposition | **None** | Free | Via P-units | None | Grows multiplicatively |
| Capacity | One row per timestep; tested to `T = 9` | Dimension-limited, graceful | **2–3 propositions** | Number of stripes | `dim V_F · dim V_R` |
| Role vocabulary | **Learned, and positional** (`t`-indexed) | Designed or random | Localist predicate units | One-hot per stripe | Designed |
| Who supplies the role? | The controller invents it | The designer | The designer | The designer | The designer |

**The trade.** ESBN buys the property `G104` asks for — role and filler separately addressable while bound, at a capacity beyond LISA's, on a task where the rule must survive a total entity swap — by giving up every operation that needs the binding to *be* something. A key/value row cannot be compared to another key/value row, superposed with it, or made the filler of a further binding. It is a **list, not an algebra**: exactly the structure [[wiki/entities/differentiable-neural-computer.md]] has, minus the addressing machinery, plus the one constraint that makes it generalise (the controller cannot see the values).

---

## Limitations

- **The keys are positional, not minted.** The PCA shows keys are a learned function of the timestep. This is a positional role set, which [[wiki/concepts/tensor-product-representation.md]] flags as strictly less faithful than a contextual one, and it means the model does **not** answer `G69`: nothing here creates a variable *on demand*, keyed by identity rather than by arrival order. Two entities of the same type at the same step remain indistinguishable.
- **TCN dependence is not discussed as a confound.** Without TCN, ESBN scores 50.0 on same/different at *every* `m` — chance, worse than a plain LSTM (88.2 at `m=0`) — and 62.0 on distribution-of-three at `m=95`. The architectural claim is stated as though the binding mechanism does the work; the ablation table shows a normalisation trick is a precondition for it on two of four tasks (T322).
- **The strict two-stream division is untested as a requirement.** The authors name softening it (a regulariser rather than an architectural wall) as future work; no experiment reports what a partially-permeable version does.
- **Nothing parses.** All tasks present pre-segmented single-character images in a fixed sequence. Extension to real RPM-like benchmarks ([[wiki/entities/raven.md]], [[wiki/entities/pgm.md]]) is stated to require visual attention that the model does not have — so `G75` sits directly in front of it.
- **Rules are selected, not constructed.** The output is a 1-of-2 or 1-of-4 choice. The paper notes value-side retrieval could produce predictions in image space; it was not run, so the generative form of the tasks is untested (cf. G17's generative/selective distinction).
- **Ternary is the ceiling reached, not the ceiling probed.** `T = 9`, four rule types, one rule per problem.

---

## What it settles elsewhere in the wiki

- **`G105` becomes empirical.** The Relation Net — pairwise by construction — sits at 26.5 and 41.4 on the two **ternary** tasks *even at `m = 0`*, where it is at 100.0 on both binary tasks. A ternary-subsampling variant (Temporal Relation Network) does not fix it; 10× training data partially does. The wiki's claim that pairwise estimators cannot reach `n ≥ 3` relations had been "structural rather than empirical"; this is the measurement.
- **`G104` gets its first partial that scales past LISA.**
- **`T293` gets a fourth system type** the row's discriminating experiment never listed: not a preserving compound and not an invertible compound, but *no compound at all*.
- **The NTM's in-principle capacity for variable-binding does not emerge in practice.** Both NTM and Fast Weights can implement indirection; a prior result cited by the paper found they do so given densely sampled 50-dimensional object vectors. Here, with high-dimensional images and hundreds of problems, NTM fails at `m ≥ 95`. **Expressible ≠ learned** is the transferable statement, and it is the same shape as [[wiki/concepts/objective-identifiability.md]]'s argument at the level of architecture rather than loss.

---

## Connections

- **[[wiki/concepts/vector-symbolic-binding.md]]** — the opposite design point on one axis: an algebra compresses the binding into a single comparable vector and pays with an unbinding step and decode noise; ESBN refuses to compress at all, keeping both constituents addressable and losing every similarity, superposition and nesting operation that algebra provides.
- **[[wiki/concepts/tensor-product-representation.md]]** — the uncompressed binder ESBN is the *non-algebraic* limit of: TPR keeps both constituents by making the compound a rank-1 outer product (dimension `dim V_F · dim V_R`), ESBN keeps them by never forming a compound (two lists, shared row index), so it escapes the annihilator obstruction `G106` and the multiplicative capacity cost at once.
- **[[wiki/entities/lisa.md]]** — the wiki's other code that preserves constituents while bound: synchrony gives it at 2–3 propositions with no dot-product read; ESBN gives it at one row per timestep with a dot-product read on the *value* column, so it inherits LISA's virtue without inheriting the phase code's incompatibility with similarity-based retrieval.
- **[[wiki/entities/pbwm.md]]** — binding by address, one level more abstract: PBWM's stripes must each be decoded by every reader because the role code is one-hot over hardware, while ESBN's keys are controller-authored vectors in one shared space, so a single read path serves every role (T317's `Ψ_R` axis with the role code made *learned* rather than designed).
- **[[wiki/entities/differentiable-neural-computer.md]]** — the same controller/external-memory split with the opposite conclusion about what matters: DNC invests in addressing modes (content, temporal link, usage), ESBN keeps naive content addressing and invests instead in *cutting the controller's access to the content*, and outperforms the NTM by a wide margin at `m ≥ 95` on that difference alone.
- **[[wiki/entities/transformer.md]]** — the strongest alternative on these tasks and the informative failure: it holds up while entities are plentiful and breaks under a random-projection encoder (`p = 0.001`), showing its relational generalisation rides on the *encoding* of entities rather than being abstracted from it.
- **[[wiki/concepts/abstract-structural-codes.md]]** — an architectural rather than emergent `g`/`x` split: the key column is `g`, the value column is `x`, and the split is enforced by wiring (the controller has no input line from the encoder) rather than induced by an objective, which is the cleanest available answer to `G1` at the cost of being hand-drawn.
- **[[wiki/concepts/complementary-learning-systems.md]]** — a two-timescale system with the fast store's read *dissociated by ablation*: removing the confidence channel kills tasks needing familiarity and leaves tasks needing recollection intact, which is the CLS recollection/familiarity distinction obtained from an ablation of a single scalar rather than from a lesion.
- **[[wiki/concepts/selective-prediction.md]]** — a match-strength signal produced by the store itself: `c_k = σ(γ M_v·z + β)` is a learned-gain confidence read off the same dot products that do the addressing, and the default-memory variant shows the signal survives removing the explicit channel because a novel item retrieves a *mixture*.
- **[[wiki/concepts/relational-reinterpretation.md]]** — a candidate for the operation Penn, Holyoak & Povinelli place above the line: role-filler independence held *during* binding, demonstrated on a same/different generalisation that the source treats as the diagnostic case, with no phase code and no symbolic machinery.
- **[[wiki/concepts/compositionality.md]]** — recombination on the *entity* axis in its purest form: the vocabulary of entities is swapped wholesale between train and test while the rule vocabulary is held fixed, which isolates one facet of the facet-vector and shows it can be made near-perfect architecturally.
- **[[wiki/entities/raven.md]]** and **[[wiki/entities/pgm.md]]** — the benchmarks these tasks are the deliberately stripped ancestors of: distribution-of-three is one RPM row rule with the perceptual parsing removed, so ESBN's result is a claim about the rule-abstraction component only, and the gap to those benchmarks is exactly the visual-attention machinery the paper names as missing.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the same two-stream idea with the streams joined instead of separated: TEM binds `g ⊗ x` into a conjunctive hippocampal code and learns `g` from transition statistics, where ESBN keeps `g` (keys) and `x` (values) in adjacent columns and gets `g` from the controller's task loss.
- **[[wiki/concepts/fast-weight-programming.md]]** — the rival fast store on the same problem: a delta-rule outer-product memory whose keys and values are also self-invented, but whose write *superposes* into one matrix, so it inherits crosstalk that ESBN's row-append avoids and gains a correction operation ESBN lacks.
- **[[wiki/concepts/working-memory.md]]** — the paper's own framing of its store as episodic rather than working memory: bindings are semi-permanent rows resolved by retrieval and context, not maintained by activity, so no unbinding mechanism is required — the hippocampal account of variable-binding rather than the synchrony or tensor-product ones.
- **[[wiki/concepts/certification-instruments.md]]** — the withheld-entity sweep as a reusable instrument: `m ∈ {0, 50, 85, 95, 98}` at a fixed problem count converts an OOD claim into a curve, and the `m = 98` cell (2 entities, 4 problems) is the strongest entity-abstraction test in the wiki.
