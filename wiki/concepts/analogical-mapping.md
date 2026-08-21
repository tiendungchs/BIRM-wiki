# Analogical Mapping

**Given two relational structures — a base and a target — return the correspondence between their elements, then transfer the base structure the target lacks. Mapping is the operation that turns "this stored episode is similar" into "*this* element of it plays *that* role here", and it is the step every schema mechanism in the wiki assumes and none performs.**

[[wiki/concepts/subgraph-matching.md]] decides *whether* a stored structure applies; [[wiki/concepts/vector-symbolic-binding.md]] scores *how much* two structures resemble each other and explicitly stops there ("the correspondence itself is never computed, only scored"). This page holds the next operation: computing the correspondence, and using it to generate and *validate* new propositions about the target.

> **Provenance.** Slipchenko & Rachkovskij, *Analogical mapping using similarity of binary distributed representations*, Int. J. Information Theories & Applications 16(3), 2009 (`raw/slipchenko-2009-analogical-mapping.md`). It also contains the wiki's most complete survey of the analogy-model landscape, reproduced in condensed form below. Some equations in the source are conversion-mangled and are restated here.

---

## The three processes, and where the cost is

| Process | Question | Cheap? | Wiki page |
|---|---|---|---|
| **Retrieval** | which stored episode is the closest analog to this one | Must be, it touches all of memory | [[wiki/concepts/vector-symbolic-binding.md]], [[wiki/concepts/subgraph-matching.md]] |
| **Mapping** | which element of the base corresponds to which element of the target | Traditionally not — this page | *here* |
| **Inference** | which base propositions transfer to the target, and are they any good | Downstream of mapping; needs an acceptance test | *here* + [[wiki/concepts/external-verification.md]] |

**Structural constraints on a legal mapping** (Markman & Gentner 2000): **parallel connectivity** — if two relations correspond, their arguments must correspond; **one-to-one** — each element maps to at most one element; **systematicity** — prefer the interpretation that preserves the largest interconnected system of higher-order relations. Analogy is not deduction: everything inference produces is a hypothesis and must be checked.

---

## The model landscape, priced

| Model | Representation | Mapping mechanism | Complexity | Failure noted by the source |
|---|---|---|---|---|
| **SME** (Falkenhainer et al. 1989) | Symbolic propositions | Local match enumeration → merge into globally consistent interpretations → systematicity score | `O(n²)`–`O(n!)` | No account of semantic similarity; too expensive to run per candidate, hence MAC/FAC's two stages |
| **ACME** (Holyoak & Thagard 1989) | Localist connectionist | Parallel constraint-satisfaction network, one node per candidate match, relaxation to a fixed point | `O(n⁴)` | Soft constraints let it violate one-to-one; will map structures with no semantic commonality; hand-crafted pragmatics |
| **CAB** (Larkey & Love 2003) | Localist, two directed graphs | Interactive activation among correspondence nodes | — | Localist brittleness |
| **IAM** (Keane et al. 1994) | Symbolic, incremental | Serial commitment, order-of-presentation effects | — | Fully serial → does not scale |
| **LISA** (Hummel & Holyoak 1997/2003) | Localist hierarchy + distributed semantic micro-features | Dynamic binding by **synchrony**; working-memory span = number of simultaneous phases | — | Does not scale to large analogs; vector similarity measures do not apply to a synchrony code |
| **STAR2** (Gray et al. 1997) | Tensor products | ACME-style constraint net on top | Tensor rank grows with arity | Exponential representation, used deliberately as a working-memory limit |
| **DRAMA** (Eliasmith & Thagard 2001) | HRRs | HRRs only *initialise* an ACME network | ACME's | Distributed representation is decorative; the mapping is still localist relaxation |
| **Copycat / Tabletop / AMBR** | Coalitions of micro-agents | Representation-building and mapping interleaved, context-sensitive | — | Domain-specific knowledge per micro-domain; no domain-general account |
| **This source (APNN)** | Sparse binary code-vectors | `argmax` of a **dot product** between re-representation codes | **`O(n·n′)` – `O(n²M)`**, `M` constant | See Limits |

The point of the table: every mature mapping model computes correspondence by **search or relaxation over a match hypothesis space**, and pays `n⁴`–`n!` for it. The claim under test is that a correspondence can be read off a *similarity ranking* instead, if the codes are built right — the mapping analogue of [[wiki/empirical-tensions.md]] T184.

---

## The representation: sparse binary code-vectors with a non-invertible binder

Each item `x` (object, attribute, relation) is a code-vector `X ∈ {0,1}^N` with `M = |X|` bits set, `M/N ≪ 1` — the regime of [[wiki/concepts/sparse-distributed-representations.md]]. Similarity is normalised overlap:

```
sim(X, Y) = |X ∧ Y| / |X|
```

**Binding = Context-Dependent Thinning (CDT)** (Rachkovskij & Kussul 2001). To bind `X₁ … X_S`:

```
Z    = ⋁_i X_i                              (superpose by OR)
⟨Z⟩  = Z ∧ ( ⋁_{k=1..K} Π_k(Z) )            (thin by K fixed random permutations)
```

Each `Π_k` is a fixed random permutation. `⟨Z⟩` keeps a subset of each `X_i`'s bits chosen *as a function of all of them*, which is what makes it a binding: the surviving bits of `X₁` record which other vectors it was bound with. Density is controlled by `K` (the experiments use thinning factor `|⟨Z⟩|/|Z| = 0.2`). Width never changes, so nesting is free — the same closure property circular convolution has.

A relation is role-filler structured, `R(A,B) ↦ ⟨R_a, A⟩ ∨ ⟨R_o, B⟩`, and an **episode is just the OR of its top-level relations**. Terminal code-vectors (roles, names, constants) are random and re-used identically at every occurrence.

**Three differences from HRR that matter:**

| | HRR (Plate) | APNN code-vectors (this source) |
|---|---|---|
| Vector | dense real, `N(0, 1/n)` | sparse binary, `M/N` ≈ 1–2% |
| Bind | circular convolution `⊛` | CDT: OR then permute-and-AND |
| Unbind | approximate inverse `†` (a permutation) | **none — CDT is lossy and non-invertible** |
| Similarity of a bound pair to its parts | ≈ 0 (randomizing) | **> 0 — `⟨Z⟩ ⊂ Z`, so a binding stays similar to its components** |

The last row is the design decision the whole method rests on: because thinning *preserves a subset of the constituent bits*, similarity of composite structures is directly readable without unbinding, and hierarchical similarity propagates upward through nesting for free. The price is that nothing can be decoded ([[wiki/empirical-tensions.md]] T187).

---

## Re-representation: mapping needs a code the retrieval code cannot supply

Mapping by direct similarity of the plain role-filler codes **fails**, and the source is explicit about why: an element's code contains only the codes of its *sub*-elements, whereas its correspondent is determined mostly by the relational system it sits *inside*. So the element code is rebuilt with an upward-looking half:

```
C*_x = C_x^lower ∨ C_x^higher ,     C_x^higher = ⋁_r C_r
```

where `r` ranges over the roles `x` fills in higher-level relations, recursively up to the top. `C_r` is the role code-vector itself, or the role bound with `C_x^lower`.

```
SUN* = SUN ∨ TEMPERATURE ∨ MASS ∨ ATTRACT₁ ∨ REVOLVE₁ ∨ GREATER₁
            ∨ GRAVITY₁ ∨ CAUSE₁ ∨ CAUSE₂ ∨ AND
```

Two properties follow. The code is now **episode-dependent** — the same object gets a different vector in a different relational context, which is exactly context-sensitivity, obtained by superposition rather than by a network. And the two halves are separable: `lower` carries semantics (and could be replaced by grounded rather than random terminals), `upper` carries structure. Memory stores the `lower` codes for retrieval; the `upper` half is what mapping adds.

**Mapping algorithm.**

1. For each top-level relation `t` of the target, `b′(t) = argmax_{b∈B} sim(C*_t, C*_b)`.
2. Descend under each mapped pair (parallel connectivity): score all child pairs `(t_i, b_j)` by `sim(C*, C*)`, discard everything below the random-overlap threshold, emit triples `(t, b, sim)`.
3. `b′(t) = argmax_b Σ sim(t, b)` — summing over the triples an element accumulates from the several top-level relations it participates in. One-to-one, if wanted, by greedy elimination in similarity order.

**Inference.** Copy-with-substitution-and-generation: unmapped base elements are transferred with their arguments replaced by the arguments' target correspondents, generating new entities where the target has none. Each transferred hypothesis `h` is then accepted iff

```
sim(C_h, C_target-episode)  >  sim(C_h, C_s)  for every target sub-element s under its mapping
```

i.e. **a candidate inference is accepted when it fits the whole target better than any of its parts** — a cheap, generator-independent acceptance test in the sense of [[wiki/concepts/external-verification.md]], using only the *lower* codes. Checked top-down, highest-level hypotheses first.

---

## Results

Same probe as the HRR experiments (*Spot bit Jane, causing Jane to flee from Spot*), same taxonomy under different names:

| This source | Wiki / Plate label | Episode |
|---|---|---|
| LS | LS | Fido bit John causing John to flee from Fido |
| SF (Surface Features) | SS | John fled from Fido causing Fido to bite John |
| CM (Cross-Mapped) | AN^cm | Fred bit Rover causing Rover to flee from Fred |
| AN | AN | Mort bit Felix causing Felix to flee from Mort |
| FOR (First-Order Relations) | FA | Mort fled from Felix causing Felix to bite Mort |

`N = 10⁵`, `M(object) = M(attribute) = 1000`, `M(role) = 2000` (roles given more bits to weight relations up), thinning 0.2 — parameters inherited from the *retrieval* experiments, not re-tuned for mapping.

| Code used | Correct mappings |
|---|---|
| Plain role-filler (`lower` only) | LS only; AN correct on relations but not entities; **SF, CM, FOR fail** |
| Re-representation (`lower ∨ upper`) | **all five**, with the similarity matrix's main diagonal strictly largest (e.g. Probe↔FOR: 0.81 on-diagonal vs 0.45 off for the entity pair, 0.47 vs 0.30 for the relations) |

The FOR case is the diagnostic one: the correct correspondence there is *not* obvious to a reader, and is forced by shared roles in the higher-order `cause` — which is precisely the information the `upper` half injects.

**Complex analogies** (the standard test set): Water-Flow ↔ Heat-Flow, Solar-System ↔ Atom, Old-School ↔ New-School.

- Water/Heat: correct one-to-one mappings; the target-irrelevant base elements (`clean(beaker)`, `liquid(water)`, `flat-top(water)`, the diameter comparison) score **below random overlap and simply do not map** — no explicit "ignore this" mechanism needed. The unmapped `cause(...)` passes the acceptance test and is inferred.
- Solar System/Atom: hypotheses generated and validated at several levels; three mapping *groups* emerge, of which the third (temperature-difference ↔ mass-difference) is below random overlap in combined weight and is discarded.
- Schools: all four `cause()` relations present in the base and absent in the target are transferred and accepted.

**Dimension.** Averaged over 100 random terminal-vector draws, mapping accuracy and inference recall/precision/F1 are both reliable at `N ≈ 1000–10 000` at fixed `p = M/N` — three orders of magnitude below the `10⁵` used in the main experiments, and the same band [[wiki/concepts/vector-symbolic-binding.md]] reports for HRRs.

---

## Why this matters to the rest of the wiki

**1. It converts G37's second stage from `n!` to `n²`.** The wiki's answer to "which stored structure applies" was a cheap *score*; the expensive part was always assumed to be the alignment that follows. Here the alignment is `n·n′` dot products over sparse binary vectors, using an index (`lower` codes) that retrieval already built. The two-stage MAC/FAC architecture survives, but stage 2 stops being the bottleneck that motivated it.

**2. It gives the wiki a candidate-inference *acceptance test* that needs no external checker.** `sim(hypothesis, whole episode) > sim(hypothesis, any part)` is computed from the same representation as everything else, and it is what stops copy-with-substitution from flooding the target with junk. This is the cheapest rejector in [[wiki/concepts/external-verification.md]]'s ladder and the only one that is *internal* to a distributed memory — and correspondingly the weakest: it tests coherence with the target, not truth.

**3. Structural context can be a bag of role labels.** Plate makes role co-occurrence a surface feature by blending each filler with the *typical fillers* of its other roles, recovered by unbinding. This source makes it a surface feature by superposing the *role vectors themselves* — no unbinding, no content, no inverse operator required. On the same taxonomy, both work ([[wiki/empirical-tensions.md]] T186).

**4. (brainstorm) The `lower`/`upper` split is a two-index scheme, and only one index needs storing.** `lower` is context-free, identical for every occurrence, and is what long-term memory holds; `upper` is episode-specific and is constructed at mapping time from the retrieved episode's structure. That is an explicit division of labour between a permanent store and a working representation — the source lists "which of the two is actually stored" as an open question, and it is the same question [[wiki/concepts/working-memory.md]] and [[wiki/concepts/complementary-learning-systems.md]] ask about every fast/slow pair in the wiki.

**5. (brainstorm) Sub-random similarity as a free relevance filter.** Nothing in the algorithm decides what to ignore; elements whose best score falls below the random-overlap baseline are dropped, and in the Water-Flow case that alone removed every distractor. A calibrated null distribution is available in closed form for sparse binary codes ([[wiki/concepts/sparse-distributed-representations.md]]), so "below chance overlap ⇒ not a correspondent" is a *computable* abstention criterion — which is more than any of the wiki's approximate matchers ([[wiki/entities/neuromatch.md]], G37 (i)) currently has.

---

## Limits, stated or visible

- **Every analog is hand-authored.** Predicate-calculus episodes, hand-chosen roles, hand-chosen decomposition. The source spends several pages calling this the field's real bottleneck ("one of the Holy Grails of AI") and does nothing about it.
- **Terminal codes are random**, so semantic similarity is all-or-none — the very brittleness the paper criticises symbolic models for. The stated fix (grounded or corpus-derived terminals) is not run.
- **The `upper` half is order-blind.** It is a *set* of higher-level roles, so two episodes containing identical relations arranged differently can be given identical structural context. The source acknowledges this and proposes binding roles to each other instead — untested.
- **No competition, no dynamics, no alternatives.** `argmax` commits; there is no mechanism for the same element to map several ways, and no relaxation between competing correspondences (both listed as future work).
- **One-to-one is enforced by greedy elimination**, not by the representation, so it inherits every ordering pathology of greedy matching.
- **The similarity threshold is a tuned constant.** Parameters (`M(role) = 2·M(object)`, thinning 0.2) were selected on the retrieval task; the mapping results at `N = 10⁵` are then reported without re-tuning, but the "three mapping groups" case shows the accept/reject boundary doing real work.
- **No certificate**, same as every approximate matcher in the wiki (G37, G17): a wrong correspondence is indistinguishable from a right one at the score level.
- **Nothing scales past toy analogs.** The `O(n²)` claim is argued, not measured; the largest tested episode has ~15 elements, and the target application (mapping knowledge-base fragments) is proposed, not run.

---

## Connections

- **[[wiki/concepts/vector-symbolic-binding.md]]** — the same problem one step earlier and in the dense/invertible regime: HRR contextualization makes structure a surface feature for *ranking*, this page makes it a surface feature for *correspondence*, and the two disagree about whether the binding operator needs an inverse (T186, T187).
- **[[wiki/concepts/sparse-distributed-representations.md]]** — supplies the substrate and the null model: CDT is a binding operator built entirely from OR, AND and permutation over sparse binary codes, and the random-overlap baseline that decides "this does not map" is that page's closed-form false-match rate.
- **[[wiki/concepts/subgraph-matching.md]]** — the rival cost model for the same alignment: an order embedding answers *containment* with a learned encoder, where this answers *correspondence* with a hand-built code and no training, and both replace exponential structure search with a coordinate comparison.
- **[[wiki/concepts/external-verification.md]]** — supplies the rejector the transfer step needs: candidate inferences are generated blindly by copy-with-substitution and filtered by an acceptance test (fits the whole target better than any part) whose criterion is independent of how the candidate was produced.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the operation that makes a retrieved graph usable: retrieval returns a similar structure, mapping returns the node correspondence, and without the second the first cannot transfer anything — while the whole scheme presupposes the graph, and discovers none of it.
- **[[wiki/concepts/schema-assimilation.md]]** — the mechanism a schema needs to bind a new instance to an existing frame: mapping is what fills the schema's slots from the current situation, and copy-with-substitution is what the schema then predicts.
- **[[wiki/concepts/compositionality.md]]** — the systematicity constraint made operational: correspondence is forced to respect argument structure (parallel connectivity), which is the requirement that makes a structure's meaning a function of its parts *and their arrangement* rather than of its parts alone.
- **[[wiki/concepts/working-memory.md]]** — where the `upper` half of a re-representation would live: an episode-specific, context-dependent recode of items whose permanent codes are context-free, which is the same fast/slow division working memory imposes on content.
- **[[wiki/concepts/retrieval-capacity.md]]** — the bound this method is exploiting rather than evading: correspondence is decided by `argmax` of a bilinear score, so what makes it work is the re-encoding (the `upper` half), not the comparator.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the same structure/content factorisation with the opposite arrow: TEM binds a content code into a *learned* structural address, where re-representation superposes structural role labels into the content code at use time, with no learning anywhere.
- **[[wiki/entities/neuromatch.md]]** — the trained counterpart of the same abstention problem: both return a graded score with no certificate, but a sparse binary code has a computable chance baseline where a learned embedding has only a validation-set threshold.
