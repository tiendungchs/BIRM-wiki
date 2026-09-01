# Analogical Mapping

**Given two relational structures — a base and a target — return the correspondence between their elements, then transfer the base structure the target lacks. Mapping is the operation that turns "this stored episode is similar" into "*this* element of it plays *that* role here", and it is the step every schema mechanism in the wiki assumes and none performs.**

[[wiki/concepts/subgraph-matching.md]] decides *whether* a stored structure applies; [[wiki/concepts/vector-symbolic-binding.md]] scores *how much* two structures resemble each other and explicitly stops there ("the correspondence itself is never computed, only scored"). This page holds the next operation: computing the correspondence, and using it to generate and *validate* new propositions about the target.

> **Provenance (second ingest).** Holyoak, K. J. (2012), *Analogy and relational reasoning*, in Holyoak & Morrison (eds.), *The Oxford Handbook of Thinking and Reasoning*, ch. 13 (`raw/holyoak-2012-analogy-relational-reasoning.md`). A review of the human literature — where the cost actually falls, what constrains inference, and what the prefrontal cortex contributes. Everything from it is marked in place; the section **The human process, priced** below carries the bulk.

> **Provenance.** Slipchenko & Rachkovskij, *Analogical mapping using similarity of binary distributed representations*, Int. J. Information Theories & Applications 16(3), 2009 (`raw/slipchenko-2009-analogical-mapping.md`). It also contains the wiki's most complete survey of the analogy-model landscape, reproduced in condensed form below. Some equations in the source are conversion-mangled and are restated here.

---

## The three processes, and where the cost is

| Process | Question | Cheap? | Wiki page |
|---|---|---|---|
| **Retrieval** | which stored episode is the closest analog to this one | Must be, it touches all of memory | [[wiki/entities/macfac.md]], [[wiki/concepts/vector-symbolic-binding.md]], [[wiki/concepts/subgraph-matching.md]] |
| **Mapping** | which element of the base corresponds to which element of the target | Traditionally not — this page | *here* |
| **Inference** | which base propositions transfer to the target, and are they any good | Downstream of mapping; needs an acceptance test | *here* + [[wiki/concepts/external-verification.md]] |

**Structural constraints on a legal mapping** (Markman & Gentner 2000): **parallel connectivity** — if two relations correspond, their arguments must correspond; **one-to-one** — each element maps to at most one element; **systematicity** — prefer the interpretation that preserves the largest interconnected system of higher-order relations. Analogy is not deduction: everything inference produces is a hypothesis and must be checked.

---

**Role-based relational reasoning** is the general capacity of which analogy is one case: *inferences about elements depend on commonalities in the roles they play, not on the elements' own features*. Something fills the role `barrier` if it blocks something else — landslide or poverty — and that binding alone licenses the inference that removing it ends the blockage. Analogy is the specific case where the source is a single case rather than a category.

---

## Stage 1 — Retrieval, where the cost actually is

The wiki's model table prices *mapping* (`n⁴`–`n!`) and treats retrieval as the cheap stage. The human data invert this:

| Measurement | Result |
|---|---|
| Tumour problem, no source analog (Gick & Holyoak 1980) | ~10% produce the convergence solution |
| Same, after studying the analogous "general" story, **no hint** | ~20% |
| Same, with the hint *"one of the stories you read earlier may help"* | **~75%** |
| Retrieval after 1–3 days: source in the **same** domain (Keane 1987) | **88%** retrieved |
| Same, source in a **remote** domain | **12%** retrieved |
| Transfer *once the source is cued*, same vs remote domain | **~86% either way** |

**Mapping is domain-blind; retrieval is not.** The entire distance penalty of a "far" analogy is paid at access. Holyoak's explanation is a computational asymmetry the wiki should adopt directly: in mapping, *which two things to compare has already been answered* and both sit in working memory, so relational comparison can run; in retrieval the question is open over all of long-term memory, and using relations as the cue costs working memory that is not available at that stage. Relational structure *does* influence retrieval — more so when some object similarity is also present, and more so for domain experts — but surface similarity dominates.

This is the empirical case for the two-stage MAC/FAC architecture ([[wiki/entities/macfac.md]]), and simultaneously the case that **stage 1 is where the intelligence has to go**: the human system already has a working stage 2 and fails anyway.

---

## Stage 2 — Mapping

Everything below is one stage. The model landscape prices the operation, the representation and re-representation sections say what a code must supply for the operation to be cheap, and the four human results at the end say what the operation is actually constrained by — which is not only structure.

### The model landscape, priced

| Model | Representation | Mapping mechanism | Complexity | Failure noted by the source |
|---|---|---|---|---|
| **SME** (Falkenhainer et al. 1989, [[wiki/entities/sme.md]]) | Symbolic propositions | Local match enumeration → merge into globally consistent interpretations → systematicity score | `O(n²)`–`O(n!)` | No account of semantic similarity; too expensive to run per candidate, hence MAC/FAC's two stages |
| **ACME** (Holyoak & Thagard 1989) | Localist connectionist | Parallel constraint-satisfaction network, one node per candidate match, relaxation to a fixed point | `O(n⁴)` | Soft constraints let it violate one-to-one; will map structures with no semantic commonality; hand-crafted pragmatics |
| **CAB** (Larkey & Love 2003) | Localist, two directed graphs | Interactive activation among correspondence nodes | — | Localist brittleness |
| **IAM** (Keane et al. 1994) | Symbolic, incremental | Serial commitment, order-of-presentation effects | — | Fully serial → does not scale |
| **LISA** (Hummel & Holyoak 1997/2003) | Localist hierarchy + distributed semantic micro-features | Dynamic binding by **synchrony**; working-memory span = number of simultaneous phases | — | Does not scale to large analogs; vector similarity measures do not apply to a synchrony code |
| **STAR2** (Gray et al. 1997) | Tensor products | ACME-style constraint net on top | Tensor rank grows with arity | Exponential representation, used deliberately as a working-memory limit |
| **DRAMA** (Eliasmith & Thagard 2001) | HRRs | HRRs only *initialise* an ACME network | ACME's | Distributed representation is decorative; the mapping is still localist relaxation |
| **Copycat / Tabletop / AMBR** | Coalitions of micro-agents | Representation-building and mapping interleaved, context-sensitive | — | Domain-specific knowledge per micro-domain; no domain-general account |
| **This source (APNN)** | Sparse binary code-vectors | `argmax` of a **dot product** between re-representation codes | **`O(n·n′)` – `O(n²M)`**, `M` constant | See Limits |

**Footnote on SME's price** (Gentner & Forbus 1991, [[wiki/entities/macfac.md]]): the survey's `O(n²)`–`O(n!)` conflates two steps that SME's authors separate. Match-hypothesis *generation* is `O(n²)` in the number of items in base or target; merging them into a global interpretation uses the **greedy merge** algorithm of Forbus & Oblinger 1990, quoted as roughly `O(n² log n²)` (the exponents are conversion-damaged in the source, but the stated form is logarithmic, not combinatorial). SME is therefore polynomial in practice, and the reason it is not run per memory item is the constant and the pool size, not an exponential — which is what makes a *filter* the right remedy rather than a better search. **The primary source ([[wiki/entities/sme.md]]) localises the factorial exactly**: it belongs to merge steps 2–3, step 3 is an already-optional maximality flag, and stopping after merge 1 yields the complete set of initial interpretations in `O(N²)` — so the 1990 greedy merge is a second concession, not the first. It also names the trigger: the factorial case requires a *flat* description language with heavy predicate repetition (one PHINEAS problem went 53 min → 34 s on the same content, re-described more systematically), so the complexity column above is a property of the representation rather than of the algorithm.

**What SME is allowed to call a match — tiered identicality** (Forbus, Gentner & Law 1995, [[wiki/entities/macfac.md]]). The survey rows above treat "semantic similarity" as a scalar each model sets differently; structure-mapping's position is that it is not a scalar at all, but a rule that differs by element type:

| Element type | Rule | Consequence |
|---|---|---|
| **Relations** — multi-argument predicates, plus every logical connective regardless of arity | identical, or **re-represented** until identical: decomposition into a canonical language (`bestow`/`bequeath` → `give`), or *minimal ascension* to a close common superordinate (Falkenhainer 1987) | the default is the cheapest possible test; weaker criteria are invoked only when the surrounding structure makes the match worth paying for |
| **Functions** — `HEIGHT(x)`, `PRESSURE(x)`: maps from entities to values on a dimension | may match **non-identically** when embedded in matching relational structure | this is what buys cross-dimensional mappings (`HEIGHT` ↔ `DARKNESS`; "Sally is sharper than Bill") |
| **Entities** | any pair may correspond, but only when relational structure proposes it | keeps object matching top-down rather than bottom-up over all pairs |

`HEAVIER[camel,cow]` vs `TALLER[giraffe,donkey]` fails as a relation match and succeeds once both are rewritten `GREATER[DIM(x), DIM(y)]` — **non-identity is not forbidden, it is relocated to the level where it is licensed**. Two consequences for this page:

- **Pure graph isomorphism is explicitly denied the status of analogy.** "Fred loves New York" / "General Motors sells cars" are isomorphic and not analogous; the ACME item that matches `smart/tall` to `hungry/friendly` is classified as a logic puzzle. Any matcher in the table above that scores topology alone will therefore accept comparisons humans reject — a failure mode orthogonal to the complexity column, and one the APNN route inherits, since its terminal codes are random and its similarity is all-or-none.
- **The remedy is a representation-language commitment, not a similarity table.** ACME/ARCS grade every predicate pair by a stored table or by WordNet links; the counter-argument is that WordNet is a lexicon rather than a language of thought, and that relations between *words* (synonym, antonym) are the wrong currency for operations over internal representations. Measured consequence in retrieval: stripping ARCS's WordNet similarity network — leaving identical-predicate matching only — removes most of its false positives ([[wiki/entities/macfac.md]]).

**Systematicity is scored by local message-passing, not by a global objective** (same source). Each match hypothesis gets an initial score, then scores **trickle down** the argument links, `W(MH₂) ← max{W(MH₂) + δ·W(MH₁), 1.0}` where `MH₂` matches an argument of a statement `MH₁` matches; an interpretation's structural evaluation is the sum over its correspondences. The alternative — weighting a match directly by its order — was tested and fits human soundness ratings *worse*, and is rejected as requiring a "bird's-eye view" of both structures that no local process has. This matters for any neural implementation: the systematicity preference of [[wiki/concepts/compositionality.md]] is expressible as a cascade along existing argument edges, with one free parameter.

The point of the table: every mature mapping model computes correspondence by **search or relaxation over a match hypothesis space**, and pays `n⁴`–`n!` for it. The claim under test is that a correspondence can be read off a *similarity ranking* instead, if the codes are built right — the mapping analogue of [[wiki/empirical-tensions.md]] T173.

---

### The representation: sparse binary code-vectors with a non-invertible binder

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

### Re-representation: mapping needs a code the retrieval code cannot supply

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

### Results

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

### Three constraints, jointly satisfied — and one of them is not about structure

Multiconstraint theory (Holyoak & Thagard 1989): a mapping is chosen by soft constraint satisfaction over

| Constraint | Content | Where it comes from |
|---|---|---|
| **Structural** | Parallel connectivity + one-to-one + systematicity | Gentner 1983; already on this page |
| **Semantic** | Prefer mappings that place *similar* elements in correspondence | Direct similarity predicts similar causal properties, so it is evidence, not noise |
| **Pragmatic centrality** | Prefer elements that are *relevant to the reasoner's current goal* | Holyoak 1985 — and it is decisive exactly when the analogy is ambiguous |

The Gulf-War/WWII probe is the cleanest demonstration that the constraints leave real residual ambiguity: undergraduates who mapped Saddam Hussein→Hitler split into **two internally coherent, mutually incompatible** solutions (US→US with Bush→Roosevelt, or US→Britain with Bush→Churchill). A **bistable** mapping — the analogy analogue of a Necker cube, and something no `argmax` mapper can produce.

**Cross-mapping** is the hard case: when one element maps one way by role and another way by direct similarity, performance drops *below* that of analogies with less semantic overlap. Perceptually rich stimuli lower relational responding; anything that raises attention to relations (mapping three objects at once, relational language) raises it.

### Comparison manufactures the differences

Markman & Gentner's three-way split — **commonalities**, **alignable differences** (differences between *mapped* elements), **non-alignable differences** (differences involving unmapped elements) — comes with a counter-intuitive result: people list a difference faster for *hotel–motel* than for *kitten–magazine*. Alignable differences are more salient, more memorable, weigh more in similarity judgments and more in choice.

**(brainstorm) This is a free contrastive signal every wiki architecture throws away.** A mapping does not only output correspondences; it partitions the two structures into shared / aligned-but-different / unaligned. The middle class is exactly the set of *minimal contrasts* — same role, different filler — which is the supervision signal a contrastive learner has to construct by sampling ([[wiki/concepts/divergence-objectives.md]] samples negatives blind; G66 asks for a sampler that draws pairs with respect to the quantity being learned). An alignment-derived negative is guaranteed to differ in one structural place. Nobody in the wiki generates negatives this way.

### Two routes, and only one of them costs working memory

| | System 2: deliberate mapping | System 1: relational priming |
|---|---|---|
| Mechanism | Retrieve → align → CWSG | Activation of one or more relational concepts |
| Evidence | Everything above | BIRD–NEST primes BEAR–CAVE at 400 ms SOA (Spellman, Holyoak & Morrison 2001); Schunn & Dunbar 1996: subjects exposed to enzyme *inhibition* solve a molecular-genetics problem by inhibition a day later **with no awareness of the earlier problem**; Day & Goldstone 2011: strategy transfer uncorrelated with recognising the analogy |
| Cost | Heavy — working memory, prefrontal cortex | Cheap, automatic |
| Systematicity | Full correspondence | **None** — "piecemeal transfer based on activation of one or more key relational concepts" |
| Fragility | Fails under load, anxiety, frontal damage | Needed explicit instructions to attend to relations at short SOA; robust when the prime was processed deeply |

**Traditional connectionist systems, lacking variable binding, model the second route and not the first** — Holyoak's explicit concession, and a useful one: it says the wiki's distributed-similarity machinery is not failing at analogy, it is succeeding at a *different, real* analogy-adjacent mechanism, and the two are separately measurable in humans.

Bassok's **semantic alignment** is the same route made content-specific: two same-category sets (cats, dogs) align with the *addends* of addition and two functionally related sets (birds, cages) do not, and this automatically modulates activation of arithmetic facts — *without helping performance*. Structure selection driven by object type, running below the level of deliberate reasoning.

### The capacity variable is *relational complexity*, and it is prefrontal

Relational complexity = the number of relational roles that must be **integrated** for one inference (Halford). It, not item count, is the load variable.

| Manipulation | Effect | Source |
|---|---|---|
| Dual task (random digit generation) during mapping | Relational responses ↓, similarity-based responses ↑ | Waltz et al. 2000 |
| Induced anxiety (timed arithmetic beforehand) | Same shift | Tohill & Holyoak 2000 |
| Frontal-lobe damage | Marked deficit on **two-relation** Raven's-type problems; **normal** on zero- or one-relation problems | Waltz et al. 1999 |
| Anterior temporal damage | Uniform decline across all analogy conditions — loss of the *conceptual content* needed to encode the relations | Morrison et al. 2004 |
| Frontal damage + semantically related distractor (negative semantic facilitation) | **Selective** impairment relative to neutral/positive | Morrison et al. 2004; Krawczyk et al. 2008 |

And a **functional dissociation inside prefrontal cortex** (Cho et al. 2010; Christoff et al. 2001; Kroger et al. 2002; Bunge et al. 2005; Green et al. 2006, 2010):

| Demand | Region |
|---|---|
| Integrating **multiple relations** | **Frontopolar / rostrolateral** prefrontal cortex — still selectively active after controlling for solution time, and rising with the *semantic distance* between the A:B and C:D pairs |
| Controlling **interference** from goal-irrelevant relations | Inferior frontal gyrus |
| Storing the relations themselves | Anterior temporal cortex |
| Spatial relations | Parietal cortex |
| Episodic access to the source | Hippocampus |

**The architectural reading.** Analogy is not one module. It is a *store of relational content* (temporal), a *store of episodes* (hippocampal), an *integrator* whose capacity is the number of simultaneously bound roles (frontopolar), and a *suppressor* of the perceptually obvious wrong answer (inferior frontal) — and the two prefrontal functions are separable by manipulation. [[wiki/entities/lisa.md]] is the model built to have exactly this shape.

---

## Stage 3 — Transfer

CWSG's stated failure mode, in Holyoak's words: without additional constraints, **any** unmapped source proposition generates a target inference, and since the source is essentially never isomorphic to a subset of the target, this produces rampant error. The constraint that works is *causal*:

- **Lassaline 1996.** Source and target animals both have a weak immune system. If the source states the weak immune system **causes** an acute sense of smell, the inference transfers more strongly than if it merely "and"s the two properties — and the boost shrinks if the link is weakened to "develops before".
- **Lee & Holyoak 2008.** If the source shows the effect **despite** a preventive cause, people judge the effect **more** likely in a target that lacks the preventer — *even though removing the preventer lowers overall source–target similarity*. Inference strength and analog similarity dissociate, with the sign reversed.
- **Holyoak, Lee & Lu 2010** formalise this: extend a Bayesian causal-strength model so that the source's causal network **plus** the mapping is the input to CWSG, and the output is an elaborated causal model of the target which is then queried for arbitrary inferences.

**This is the single hardest constraint this page carries on the wiki's own acceptance test.** The Slipchenko test — accept a hypothesis iff `sim(C_h, whole target) > sim(C_h, any mapped part)` — is a *coherence-with-the-target* criterion computed from the same similarity that produced the mapping. Lee & Holyoak's result is a case where the correct inference is the one that similarity argues *against*. See [[wiki/empirical-tensions.md]] T192.

The pipeline Holyoak recommends is worth stating as an architecture, because it is not the one the wiki has: **learn the source's causal structure → map → CWSG to augment the target's causal model → query the resulting model**, plus a post-analogical **adaptation** step for goal-relevant target features the source cannot predict. The transferred object is a *model*, not a set of propositions, and it is what makes an open-ended range of later inferences answerable.

---

## Where the capacity comes from, developmentally

Young children map by object similarity when similarity and structure conflict; reliance on relational structure grows with age (Gentner & Rattermann's **relational shift**). Two explanations, both with evidence:

- **Knowledge accretion** (Goswami): the capacity is present in infancy (some analogical ability at 1 year); what grows is knowledge of the relevant relations. Expertise predicts analogical skill even in adults.
- **Executive maturation** (Richland, Morrison & Holyoak 2006): preschoolers give fewer relational responses when *either* a similar distractor is present *or* two relations must be integrated — the two manipulations that load the maturing prefrontal cortex. By 13–14 years, relational responding is reliable even with both. Children with autism matched on executive function show comparable trends.

See [[wiki/empirical-tensions.md]] T193. For a builder the distinction is the difference between scaling the relation vocabulary and scaling the binding budget, and the second is a *capacity* parameter no wiki architecture currently exposes.

---

## Limits, stated or visible

- **Every analog is hand-authored.** Predicate-calculus episodes, hand-chosen roles, hand-chosen decomposition. The source spends several pages calling this the field's real bottleneck ("one of the Holy Grails of AI") and does nothing about it.
- **Terminal codes are random**, so semantic similarity is all-or-none — the very brittleness the paper criticises symbolic models for. The stated fix (grounded or corpus-derived terminals) is not run.
- **The `upper` half is order-blind.** It is a *set* of higher-level roles, so two episodes containing identical relations arranged differently can be given identical structural context. The source acknowledges this and proposes binding roles to each other instead — untested.
- **No competition, no dynamics, no alternatives.** `argmax` commits; there is no mechanism for the same element to map several ways, and no relaxation between competing correspondences (both listed as future work). SME enumerates the alternatives instead and defends doing so — including as the right handling of many-to-one cases — while conceding it is the step that costs ([[wiki/empirical-tensions.md]] T306).
- **One-to-one is enforced by greedy elimination**, not by the representation, so it inherits every ordering pathology of greedy matching.
- **The similarity threshold is a tuned constant.** Parameters (`M(role) = 2·M(object)`, thinning 0.2) were selected on the retrieval task; the mapping results at `N = 10⁵` are then reported without re-tuning, but the "three mapping groups" case shows the accept/reject boundary doing real work.
- **No certificate**, same as every approximate matcher in the wiki (G37, G17): a wrong correspondence is indistinguishable from a right one at the score level.
- **Nothing scales past toy analogs.** The `O(n²)` claim is argued, not measured; the largest tested episode has ~15 elements, and the target application (mapping knowledge-base fragments) is proposed, not run.

---

---

### Two results that should worry anyone building this

**(a) An analogical inference is not tagged as an inference.** Blanchette & Dunbar 2002: after reading a target text (marijuana legalisation) and then a source (alcohol prohibition), with *no* instruction to map and *no* statement of correspondences, subjects later "recognised" never-presented CWSG inferences as having been in the target text **50%** of the time, against a **25%** base rate — at 15 minutes and at one week, familiar and unfamiliar materials. Replicated (Perrott, Gentner & Bodenhausen 2005), foreshadowed by Schustack & Anderson 1979.

So: transfer runs spontaneously on mere juxtaposition, its products are written into the target representation, and **provenance is lost**. That is a confabulation mechanism with a measured rate, and it is the same failure a retrieval-augmented generator exhibits when a retrieved passage's content resurfaces as asserted fact. Gap **G71**.

**(b) A pre-existing schema silently rewrites the mapping, and can take transfer to zero.** Bassok, Wu & Olseth 1995: formally isomorphic permutation problems, differing only in whether objects were assigned to people (OP) or people to objects (PO). People interpret "assign an object to a person" through an overlearned **get** schema in which the person is the recipient — regardless of which entity the stated relation puts in which role.

| Source | Target | Transfer accuracy |
|---|---|---|
| OP | OP | **89%** |
| OP | PO | **0%** |

Isomorphic problems, one schema, a 89-point swing. The relation *as stated* was overridden by a relation the reasoner already had. This is [[wiki/architectural-gaps.md]] G23 measured: an unconditional prior with no entry test, firing on object *types*, silently re-parsing the input — and the mapping machinery downstream is working perfectly on the wrong parse (G27).

## Why this matters to the rest of the wiki

**1. It converts G37's second stage from `n!` to `n²`.** The wiki's answer to "which stored structure applies" was a cheap *score*; the expensive part was always assumed to be the alignment that follows. Here the alignment is `n·n′` dot products over sparse binary vectors, using an index (`lower` codes) that retrieval already built. The two-stage MAC/FAC architecture survives, but stage 2 stops being the bottleneck that motivated it.

**2. It gives the wiki a candidate-inference *acceptance test* that needs no external checker.** `sim(hypothesis, whole episode) > sim(hypothesis, any part)` is computed from the same representation as everything else, and it is what stops copy-with-substitution from flooding the target with junk. This is the cheapest rejector in [[wiki/concepts/external-verification.md]]'s ladder and the only one that is *internal* to a distributed memory — and correspondingly the weakest: it tests coherence with the target, not truth.

**3. Structural context can be a bag of role labels.** Plate makes role co-occurrence a surface feature by blending each filler with the *typical fillers* of its other roles, recovered by unbinding. This source makes it a surface feature by superposing the *role vectors themselves* — no unbinding, no content, no inverse operator required. On the same taxonomy, both work ([[wiki/empirical-tensions.md]] T186).

**4. (brainstorm) The `lower`/`upper` split is a two-index scheme, and only one index needs storing.** `lower` is context-free, identical for every occurrence, and is what long-term memory holds; `upper` is episode-specific and is constructed at mapping time from the retrieved episode's structure. That is an explicit division of labour between a permanent store and a working representation — the source lists "which of the two is actually stored" as an open question, and it is the same question [[wiki/concepts/working-memory.md]] and [[wiki/concepts/complementary-learning-systems.md]] ask about every fast/slow pair in the wiki.

**5. (brainstorm) Sub-random similarity as a free relevance filter.** Nothing in the algorithm decides what to ignore; elements whose best score falls below the random-overlap baseline are dropped, and in the Water-Flow case that alone removed every distractor. A calibrated null distribution is available in closed form for sparse binary codes ([[wiki/concepts/sparse-distributed-representations.md]]), so "below chance overlap ⇒ not a correspondent" is a *computable* abstention criterion — which is more than any of the wiki's approximate matchers ([[wiki/entities/neuromatch.md]], G37 (i)) currently has.

---

---

## Open problems

| Stated limitation | Wiki row |
|---|---|
| "Knowledge representations typically must be hand-coded by the modeler … an indefinite number of free parameters to facilitate data-fitting" | G4, and this page's own Limits |
| Flexible **re-representation** is needed: `lift(John, hammer)` ≡ `cause(John, rise(hammer))`; people see analogies across such forms, models cannot | G4/G27 — the chunked-predicate case of choosing a discretisation |
| The stage decomposition (retrieve→map→infer→abstract) is "oversimplified"; real use is cyclic, interactive, open-ended, with the source's representation *developed during* reasoning, and multiple or imagined sources | G5 (no joint discover-and-navigate loop) |
| "Typically there is no firm boundary around the information that counts as an individual analog" | G37/G27 — the same undefined-membership problem [[wiki/concepts/schema-assimilation.md]] has for "the same schema" |
| No integration with problem solving: sequencing operators, subgoals, combining rules for non-isomorphic problems are "beyond the capabilities of current computational models of analogy" | G33 |
| Perceptual encoding difficulty drives transfer difficulty (Tower-of-Hanoi isomorphs) and no analogy model accounts for it | G27 |
| A full Bayesian computational-level account is "challenging, perhaps even intractable" because relation types are indefinitely diverse; needs role-based representations integrated with probabilistic inference | G26/G11 |

---

## Connections

- **[[wiki/concepts/nonspatial-maps.md]]** — the competing explanation for the same data: a code that generalises across domains and a mapping that transfers across domains predict the same signatures, and no experiment in that table separates them.

- **[[wiki/entities/pcfg-set.md]]** — substitutivity is the minimal mapping problem — two atoms with identical roles ought to be interchangeable — and on the measure that excludes competence as an explanation (consistency restricted to *incorrect* outputs) no seq2seq architecture exceeds 0.34.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the same problem one step earlier and in the dense/invertible regime: HRR contextualization makes structure a surface feature for *ranking*, this page makes it a surface feature for *correspondence*, and the two disagree about whether the binding operator needs an inverse (T186, T187).
- **[[wiki/concepts/sparse-distributed-representations.md]]** — supplies the substrate and the null model: CDT is a binding operator built entirely from OR, AND and permutation over sparse binary codes, and the random-overlap baseline that decides "this does not map" is that page's closed-form false-match rate.
- **[[wiki/concepts/subgraph-matching.md]]** — the rival cost model for the same alignment: an order embedding answers *containment* with a learned encoder, where this answers *correspondence* with a hand-built code and no training, and both replace exponential structure search with a coordinate comparison.
- **[[wiki/concepts/external-verification.md]]** — supplies the rejector the transfer step needs: candidate inferences are generated blindly by copy-with-substitution and filtered by an acceptance test (fits the whole target better than any part) whose criterion is independent of how the candidate was produced.
- **[[wiki/entities/macfac.md]]** — the stage before this one, and the bound on it: mapping only ever runs on what a structure-blind functor-count filter passed (measured at 1.5 items per probe from a 36-item pool), so an analogy the filter never surfaces is not a mapping failure at all.
- **[[wiki/entities/macfac.md]]** *(second link, 1995)* — also the source of two rules this page's mapping step runs on: **tiered identicality** (relations identical or re-represented, functions and entities free), which is what stops a matcher from calling any isomorphism an analogy; and **trickle-down** structural evaluation, which computes the systematicity preference by local cascade along argument edges rather than by a global order weighting.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the operation that makes a retrieved graph usable: retrieval returns a similar structure, mapping returns the node correspondence, and without the second the first cannot transfer anything — while the whole scheme presupposes the graph, and discovers none of it.
- **[[wiki/concepts/schema-assimilation.md]]** — the mechanism a schema needs to bind a new instance to an existing frame: mapping is what fills the schema's slots from the current situation, and copy-with-substitution is what the schema then predicts.
- **[[wiki/concepts/compositionality.md]]** — the systematicity constraint made operational: correspondence is forced to respect argument structure (parallel connectivity), which is the requirement that makes a structure's meaning a function of its parts *and their arrangement* rather than of its parts alone.
- **[[wiki/concepts/working-memory.md]]** — where the `upper` half of a re-representation would live: an episode-specific, context-dependent recode of items whose permanent codes are context-free, which is the same fast/slow division working memory imposes on content.
- **[[wiki/concepts/retrieval-capacity.md]]** — the bound this method is exploiting rather than evading: correspondence is decided by `argmax` of a bilinear score, so what makes it work is the re-encoding (the `upper` half), not the comparator.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the same structure/content factorisation with the opposite arrow: TEM binds a content code into a *learned* structural address, where re-representation superposes structural role labels into the content code at use time, with no learning anywhere.
- **[[wiki/entities/lisa.md]]** — the model built to the shape the human data imply: role bindings carried by synchrony, so the capacity limit *is* the number of relations that can be integrated at once, correspondence grown Hebbian rather than searched, and inhibition of the featurally-similar distractor a required step rather than an afterthought.
- **[[wiki/concepts/causal-model-building.md]]** — what analogical transfer actually moves, on the human evidence: the source's causal network is mapped and used to elaborate the target's, which is why an inference can strengthen while overall similarity falls (Lee & Holyoak 2008) and why a similarity-based acceptance test is the wrong filter (T192).
- **[[wiki/concepts/cognitive-control.md]]** — the two prefrontal contributions the mapping process needs, dissociated by manipulation: frontopolar cortex integrating multiple relations and inferior frontal gyrus suppressing goal-irrelevant ones, with frontal damage collapsing relational responses onto direct similarity exactly as a removed bias signal predicts.
- **[[wiki/entities/neuromatch.md]]** — the trained counterpart of the same abstention problem: both return a graded score with no certificate, but a sparse binary code has a computable chance baseline where a learned embedding has only a validation-set threshold.
- **[[wiki/entities/mlc.md]]** — consistency across a set of answers enforced by self-conditioning instead of by a mapper: the open-ended task is factorised as `∏ᵢ P(yᵢ | xᵢ, x_{<i}, y_{<i})`, so each answer becomes a study example for the next and mutual exclusivity emerges (99.0% unique responses vs 93.1% in people) with no correspondence network anywhere.
- **[[wiki/entities/raven.md]]** — the psychometric form of this page's problem, measured: matrix completion solved at 73–89% i.i.d. drops to 44–68% when the same relation is re-carried by a different attribute, which is mapping failing on exactly the transfer this page calls load-bearing.
- **[[wiki/entities/pgm.md]]** — matrix completion solved by exhaustive pairwise comparison and nothing else: an MLP over all panel pairs, summed, with no alignment, no one-to-one constraint and no candidate structure, beats a ResNet by 20 points — and then fails precisely where structure-mapping theory predicts a non-mapper would, on carrying a familiar relation to unfamiliar objects and attributes (Barrett et al. 2018).
- **[[wiki/entities/math-perturb.md]]** — the near-miss measured at scale: a retrieval stage recovers the original problem from its method-invalidating perturbation with MRR 0.986, so retrieval by similarity provably cannot reject the wrong source and the rejection has to happen at mapping time — which is the stage no language model runs as a separate step.
- **[[wiki/concepts/emergent-modularity.md]]** — a wiring account of analogy rather than a matching-algorithm one: Sherwood et al. 2008 treat "light as a wave" as the direct consequence of one sequencing operator acquiring arguments from multiple semantic domains via an expanded arcuate fasciculus, which predicts analogical ability should scale with the number of distinct representational sources routed into a shared composition site.
- **[[wiki/concepts/relational-reinterpretation.md]]** — the comparative argument that this operation, and not similarity judgement, is the discontinuity: relational match-to-sample is deflated as a *non*-precursor for analogy (its relations are symmetric and feature-based, and it reduces to an entropy chunk plus a conditional discrimination), so the one unreplicated nonhuman analogy result turns out to track the *number* of featural changes rather than their kind.
- **[[wiki/entities/sme.md]]** — the primary source for this page's first table row, and it changes the row: the `O(n!)` belongs to a single *optional* maximality merge (stop after merge 1 and the complete set of initial interpretations costs `O(N²)`), the exponent is triggered by flat descriptions rather than by size, and gmap *construction* is provably independent of the evidence weights — so the discrete half and the scored half of mapping factor, which no neural candidate on this page preserves.
