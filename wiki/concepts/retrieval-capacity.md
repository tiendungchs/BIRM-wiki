# Retrieval Capacity

**A store read by ranking `⟨q, v_i⟩` over `d`-dimensional vectors cannot be asked for arbitrary subsets of its contents: if every `k`-subset of `n` items must be returnable as the top-`k` for *some* query, with a score margin `γ`, then `C(n,k) ≤ (1 + 1/γ)^d`. The binding resource is not how many items are stored but how many distinct *retrieval sets* can be addressed, and it is fixed by the embedding dimension before any training happens.**

Every capacity number elsewhere in this wiki counts **items**: how many patterns a Hopfield store holds ([[wiki/entities/hopfield-network.md]]), how many sparse codes are discriminable at a false-positive rate ([[wiki/concepts/sparse-distributed-representations.md]]), `p_max ≈ k·C/(a ln(1/a))` for CA3. This page carries the other quantity — **how many different questions the store can be asked** — which no page here had priced, and which is the one that binds as soon as queries become compositional.

> **Provenance.** Weller, Boratko, Naim & Lee 2026, *On the Theoretical Limitations of Embedding-Based Retrieval*, ICLR 2026 (`raw/weller-2026-embedding-retrieval-limits.md`). One theorem, one best-case optimisation study, one benchmark (LIMIT).

---

## The bound

Unit document vectors `v_1..v_n ∈ ℝ^d`, unit queries `u ∈ ℝ^d`. A `k`-subset `S ⊆ [n]` is **realized with margin `γ`** if some unit `u_S` satisfies

```
min_{i∈S} ⟨u_S, v_i⟩  ≥  max_{j∉S} ⟨u_S, v_j⟩ + 2γ            (feasible only for 0 < γ ≤ 1)
```

**Theorem (dimension lower bound).** If every `k`-subset is realized with margin `γ`, then

```
C(n,k) ≤ (1 + 1/γ)^d       ⟺       d ≥ log C(n,k) / log(1 + 1/γ)
n ≫ k:   d = Ω( k·log(en/k) / log(1 + 1/γ) )
```

**Proof in one line, and it is worth carrying:** for `S ≠ T` pick `i ∈ S\T`, `j ∈ T\S`; the two margin conditions add to `⟨u_S − u_T, v_i − v_j⟩ ≥ 4γ`, and `‖v_i − v_j‖ ≤ 2` forces `‖u_S − u_T‖ ≥ 2γ`. The `C(n,k)` query vectors are therefore pairwise `2γ`-separated on the unit sphere, so `C(n,k)` disjoint balls of radius `γ` fit inside a ball of radius `1+γ` — **sphere packing**, and the whole result is a volume count. The distinguishing feature against Johnson–Lindenstrauss is direction: JL gives a dimension *sufficient* to preserve pairwise distances; this gives one *necessary* to realize all retrieval sets.

Lower bounds at `γ = 0.1` (score gap 0.2, roughly what deployed models show):

| Corpus `n` | `k`=2 | `k`=10 | `k`=100 | `k`=1000 |
|---|---|---|---|---|
| 10³ | 6 | 23 | 135 | *trivial* |
| 10⁶ | 12 | 52 | 425 | 3296 |
| 10⁹ | 17 | 81 | 713 | 6177 |
| 10¹¹ | 21 | 100 | 905 | 8098 |

Deployed embeddings are quantised or Matryoshka-truncated to < 1k dimensions; the largest in research are 4096. The bound alone already exceeds that for large `k` — and it is an *extreme* under-estimate, because it assumes free vectors with no gradient descent, no tokenizer and no generalisation requirement.

**The margin is what makes it bite, not the combinatorics.** Dropping `γ` reduces the question to the qrel matrix's **sign-rank**: with `A ∈ {0,1}^{m×n}` the relevance matrix and `B = UᵀV` the score matrix,

```
rank±(2A − 1) − 1  ≤  rank_rop A = rank_rt A  ≤  rank_gt A  ≤  rank±(2A − 1)
```

and Alon, Frankl & Rodl 1985 give sign-rank `≤ 2k` for any qrel matrix with at most `k` relevant documents per query. So `2k+1` dimensions suffice *in principle* — at infinite precision. **Capacity is destroyed by the requirement that the separation be robust, not by the number of subsets**, which is the same lesson as every noise-tolerance result on this wiki and the reason quantisation is not a free deployment choice.

---

## Best case: free embeddings

Optimise the vectors themselves (no encoder, no language), unit-normalised by projected gradient descent, full-dataset-batch InfoNCE, Adam, directly against the *test* qrel matrix — an upper bound on what any embedding model could do, since it need not generalise. Increase `n` at fixed `d` until 100% accuracy is unreachable: the **critical-`n`**.

| `d` | 4 | 8 | 12 | 16 | 20 | 30 | 40 | 45 |
|---|---|---|---|---|---|---|---|---|
| critical-`n` (`k`=2) | 10 | 28 | 47 | 79 | 120 | 261 | 460 | 626 |

Cubic fit `critical-n = −10.53 + 4.03d + 0.052d² + 0.0037d³` (`r² = 0.999`), extrapolating to 500k docs at `d`=512, 1.7m at 768, 4m at 1024, 107m at 3072, 250m at 4096 — **for `k` = 2**, the easiest non-trivial case.

Two readings a builder should take:

- **The theorem under-states reality by a constant multiplier.** At `n` = 100 the bound gives `d ≥ 4`; free embeddings need `d > 18`. A ~4.5× gap already appears in the setting with *no* natural language and *no* generalisation, so real requirements sit further out again.
- **Optimisation, not geometry, is the operative limit for real models.** LIMIT-small (46 documents) is representable in 12 dimensions by free optimisation; real embedding models at 64 dimensions and above cannot solve it. Everything between those two numbers is learnability, not capacity.

---

## LIMIT: the bound instantiated in trivial natural language

Construction: take the densest qrel matrix that fits ~1000 queries at `k`=2 — all `C(46,2) = 1035` pairs over 46 documents — and instantiate it as *`Jon likes Apples`* / *`who likes Apples?`*, padded to 50k documents with irrelevant people. Queries ask for one attribute; documents are one person's attribute list. Nothing here is semantically hard.

| Model | dim | R@2 | R@10 | R@100 (full 50k) |
|---|---|---|---|---|
| Qwen3 Embed | 4096 | 0.8 | 1.8 | 4.8 |
| Snowflake Arctic L | 1024+ | 0.4 | 0.8 | 3.3 |
| E5-Mistral 7B | 4096 | 1.3 | 2.2 | 8.3 |
| GritLM 7B | 4096 | 2.4 | 4.1 | 12.9 |
| Gemini Embed | 3072 | 1.6 | 3.5 | 10.0 |
| Promptriever Llama3 8B | 4096 | 3.0 | 6.8 | **18.9** |
| GTE-ModernColBERT (multi-vector) | — | 23.1 | 34.6 | 54.8 |
| BM25 (sparse lexical) | — | **85.7** | 90.4 | 93.6 |

On the 46-document version the best single-vector model reaches R@2 = 54.3 (Promptriever, 4096) and **no single-vector model solves it even at recall@20**, while BM25 gets 97.8 at R@2 and 100 at R@10.

Four controls that make the result hard to explain away:

| Control | Result | What it rules out |
|---|---|---|
| Fine-tune on an in-domain *train* split | R@10 0.0 → 2.8 | Domain shift |
| Fine-tune on the *test* split | R@2 85.5 at `d`=32, 96.5 at 1024 | Anything intrinsic to the task's language |
| Truncate dimension (MRL) within one model | Monotone rise with `d` throughout | That dimension is incidental |
| Correlation with BEIR/MTEB score | None (Table 7: Qwen3 62.76 BEIR / 4.8 LIMIT; Promptriever 56.40 / 18.9) | That the standard leaderboard measures this at all |

**Why standard benchmarks hide it.** QUEST has 325k documents at `k`=20, so `C(325000, 20) ≈ 7×10⁹¹` possible top-`k` sets and 3357 annotated queries — an infinitesimal sample of the combination space, chosen for annotation cost rather than because the other combinations are unaskable. Instruction-following and logical-operator queries (*"Moths or Insects or Arthropods of Guadeloupe"*) are exactly the device that makes arbitrary combinations *askable*.

**A hardness statistic that is computable from a dataset with no model.** Treat the qrel matrix as a graph (documents as nodes, edge iff co-relevant to some query):

| Dataset | Graph density | Avg. query strength |
|---|---|---|
| NQ | 0 | 0 |
| HotpotQA | 0.000037 | 0.11 |
| SciFact | 0.0014 | 0.42 |
| FollowIR Core17 (instruction-following) | 0.026 | 0.59 |
| LIMIT | 0.085 | 28.5 |

The ordering is suggestive rather than proven — the source says so — but it gives a **pre-registerable difficulty axis for any retrieval-style benchmark**, and instruction-following datasets are already the closest to LIMIT.

---

## The escape routes, and what each costs

| Architecture | Score form | On LIMIT | Cost |
|---|---|---|---|
| **Single vector (two-tower)** | `⟨u_q, v_d⟩` — score matrix `B = UᵀV` has rank ≤ `d` | fails | The bound above; first-stage retrieval is `O(1)` per document with a precomputed index |
| **Multi-vector / late interaction** | MaxSim over token vectors | 23.1 → 83.5 R@2, far from solved | Storage ×tokens; no theory covers it; barely used for instruction/reasoning retrieval |
| **Sparse lexical (BM25)** | Very high-dimensional sparse vector | near-solved (85.7 / 97.8) | **Keyword-only.** Replace items with synonyms and BM25 drops > 89% — below the neural models it just beat, which drop ~39% |
| **Cross-encoder (Gemini 2.5 Pro, 46 docs + 1000 queries in one context)** | Joint `F(q, d)` — no factorisation | **100%** | No precomputable index; cost is `O(n)` model calls (or one long context) per query |

The synonym control is the sharpest line in the paper: **dimension and graded similarity are traded against each other**, and no listed architecture has both. That is [[wiki/concepts/sparse-distributed-representations.md]]'s regime (dimension buys combinatorial addressability, sparsity buys interference-freedom, neither buys semantic tolerance) meeting [[wiki/concepts/population-geometry.md]]'s (a low-dimensional manifold buys generalisation and forfeits addressability) as a single measured trade-off rather than as two literatures — see [[wiki/empirical-tensions.md]] T50, T75.

---

## Why this generalises past information retrieval

The theorem constrains **any** read implemented as *rank a fixed set of stored vectors by inner product with a query vector*, in any modality — the source says so explicitly, and nothing in the proof mentions text. That description covers most of the wiki's memory reads:

| Wiki mechanism | Is it exposed? |
|---|---|
| Attention read over a cache, `softmax(qKᵀ)V` ([[wiki/concepts/attention.md]]) | **Yes** — head dimension `d_head` is typically 64–128, so per head, only a small number of top-`k` key subsets are addressable. The softmax is a *second*, separate capacity limit on top of this one |
| Schema retrieval by order embedding ([[wiki/concepts/subgraph-matching.md]]) | **Partly** — the comparison is `‖max{0, z_q − z_u}‖²` rather than an inner product, so the theorem does not transfer verbatim; the counting argument (a `D`-dimensional geometry realizes a bounded number of distinct query answers) does |
| Sparse-code union membership ([[wiki/concepts/sparse-distributed-representations.md]]) | **Not by this bound** — `n` = 10⁴–10⁵ binary dimensions is exactly the BM25 regime; the union's limit is mix-and-match error (4–16 patterns), and its weakness is the same synonym brittleness |
| Relaxation onto an attractor ([[wiki/concepts/attractor-dynamics.md]]) | **No** — retrieval is not a ranked subset selection; the store returns one state, and its limit is `p_max`, an item count |
| Cross-encoder / joint scoring, MaxSim, hypernetwork queries | **No** — the compatibility function is not factorised through two independent encodings, so no rank constraint applies |

**(brainstorm) The general statement is about factorisation, not about retrieval.** Any compatibility computed as `F(q, x) = ⟨f(q), g(x)⟩` is a **rank-`d` bilinear form** in the two encodings, so the set of realizable relevance patterns is bounded by the sign-rank of the target pattern matrix. This is the price of the two-tower shape — the shape adopted every time a system precomputes one side of an interaction — and it names a limit that applies to every joint-embedding architecture in the wiki, [[wiki/entities/h-jepa.md]] and the JEPA family included. The predictor in a JEPA partially escapes it (a learned map is not a bilinear form), which makes the predictor's *width* a capacity parameter nobody in that lineage reports.

**(brainstorm) The compositional-query consequence is the one that matters for reasoning.** `C(n,k)` grows because logical operators let a query name any subset: *X and Y*, *X or Y but not Z*. A store whose read is a single dot product therefore has a hard ceiling on the compositional queries it can answer, and the ceiling scales as `k log(n/k)` in dimension — so representing a rule over an unbounded instance set ([[wiki/concepts/compositionality.md]], gap G18) cannot be done by precomputing a key per instance. Either the query is composed *at scoring time* against each candidate (cross-encoder, which is a search), or the store is addressed by structure rather than by similarity.

---

## Open problems

- **Which combinations fail is unpredictable.** The theorem says some `k`-subsets are unrealizable; nothing says *which*, so a deployed store cannot be told in advance what it will never return. There is no certificate — the same hole G37's geometric answer already has.
- **No bound for approximate retrieval.** Everything above requires *all* combinations. The realistic setting — capture most of them, tolerate a failure rate — is unbounded (the source points to Ben-David et al. 2002).
- **Loss shape changes the answer and nobody knows why.** Sigmoid contrastive losses solve the free-embedding problem in *fewer* dimensions than InfoNCE (Bangachev et al. 2025), because InfoNCE maximises margin and the margin is what the bound charges for. The vision-language community uses sigmoid by default and the text community almost never does; this is an open learnability question sitting inside a settled geometry one ([[wiki/concepts/divergence-objectives.md]]).
- **Multi-vector has no theory.** MaxSim is empirically much better and formally uncovered; the source states this as its own principal limitation.
- **Nothing measures the learnability gap.** The distance between "12 dimensions suffice" and "64 real dimensions fail" is the whole practical effect, and it is currently one anecdote rather than a curve.

---

## Connections

- **[[wiki/concepts/attention.md]]** — the wiki's default memory read is exactly the operation this page bounds: per head, `softmax(qKᵀ)V` ranks stored keys by inner product in 64–128 dimensions, so the addressable set of top-`k` key subsets is capped by head width *before* the softmax's occupancy-dilution limit is reached; the two are separate capacity models on one mechanism.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the same variable (`d`) priced for the opposite property: dimension buys per-item recognition accuracy there and combinatorial addressability here, and BM25's near-solution of LIMIT followed by an 89% collapse under synonyms is the measured cost of the high-dimensional sparse regime.
- **[[wiki/concepts/subgraph-matching.md]]** — supplies the capacity ceiling that page's amortisation argument had no term for: precomputing target embeddings makes schema retrieval cheap and simultaneously caps how many distinct schema-query answers the geometry can realize.
- **[[wiki/concepts/amortized-inference.md]]** — the sharpest instance of what amortisation costs: compiling one side of an interaction into a fixed vector is what makes retrieval `O(1)`, and it is exactly what imposes the rank bound; the cross-encoder that solves LIMIT is the un-amortised version.
- **[[wiki/concepts/energy-based-models.md]]** — a factorised energy `F(q,x) = −⟨f(q), g(x)⟩` is a rank-`d` bilinear form, so the joint-embedding architecture's expressive limit is a *sign-rank* limit on the compatibility patterns it can express — a structural constraint on the same family the collapse table types.
- **[[wiki/entities/barlow-twins.md]]** — a third thing embedding dimension can buy, and the only one that is discarded after training: the width that keeps paying there is the *projector's* (monotone to 16384 above a fixed 2048-d representation), so those dimensions carry decorrelation constraints on the deployed code rather than addressable retrieval sets.
- **[[wiki/concepts/divergence-objectives.md]]** — InfoNCE's margin-maximising behaviour is what makes the `γ` term in the bound expensive, and a sigmoid loss reportedly needs fewer dimensions for the same qrel matrix, so the objective choice moves a capacity limit and not just a convergence rate.
- **[[wiki/concepts/compositionality.md]]** — prices the retrieval side of composition: logical operators over attributes make `C(n,k)` combinations askable, and a similarity-ranked store can address only `(1+1/γ)^d` of them, so a rule over an unbounded instance set cannot be answered by a precomputed key.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the qrel matrix *is* a bipartite query–document graph, and its graph density and average query strength (LIMIT 0.085 / 28.5 against NQ 0 / 0) are the first model-free statistics on this wiki that predict how hard a store will be to query.
- **[[wiki/concepts/population-geometry.md]]** — the other end of the same trade: low-dimensional abstraction geometry buys generalisation and costs exactly the addressability this page counts (T50, T75).
- **[[wiki/concepts/shortcut-learning.md]]** — the benchmark-side lesson: BEIR/MTEB scores are uncorrelated with LIMIT, so a leaderboard can be saturated by models that fail a trivially simple instance of the task the leaderboard claims to measure.
