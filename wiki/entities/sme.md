# SME — the Structure-Mapping Engine

**Given a base and a target description in predicate calculus, emit *every* structurally consistent correspondence between them, the propositions each one licenses transferring, and a score — without search and without backtracking. The engine's one design commitment: *which* interpretations exist is decided by structure alone; the numbers only rank them.**

> **Provenance.** Falkenhainer, B., Forbus, K. D. & Gentner, D. (1989), *The Structure-Mapping Engine: Algorithm and Examples*, Artificial Intelligence 41, 1–63 (`raw/falkenhainer-1989-structure-mapping-engine.md`; pdf2md, **lossy** — Appendix A's rule listings and several figures did not survive; the rules quoted below are the ones given inline in the body).

The wiki has cited SME secondhand — as stage 2 of [[wiki/entities/macfac.md]], as the `O(n²)`–`O(n!)` row in [[wiki/concepts/analogical-mapping.md]]'s model table, and as the classical baseline in T173. This page is the primary source: what the four stages actually do, where the exponent is and how to get rid of it, and what the authors themselves proposed instead.

---

## What it takes in

| Construct | Definition | Why the distinction exists |
|---|---|---|
| **Entity** | logical individual or constant | may correspond to any entity — but only when relational structure proposes it |
| **Function** | maps entities to a value on a dimension: `PRESSURE(piston)` | **substitutable** — functions are an indirect way of *referring* to an entity, so `PRESSURE ↔ TEMPERATURE` is legal |
| **Attribute** | one-argument, truth-valued: `RED(x)` | dropped in analogy mode unless embedded in higher-order structure |
| **Relation** | multi-argument truth-valued, plus **every logical connective regardless of arity** | must match **identically** — `GREATER` matches only `GREATER` |
| **Dgroup** | a description group: entities + expressions about them | the unit of comparison |

**Order** (the paper's, not logic's): entities are order 0; `order(P) = 1 + max order of its arguments`. Order measures *depth of the structure below an item* — so `CAUSE[GREATER(...), FLOW(...)]` is higher-order, and a deeply justified explanation is automatically high-order. Systematicity is a preference over this quantity.

`:commutative?` and `:n-ary?` are declared per predicate and consumed by the matcher (commutative predicates get an extra intern rule that drops the corresponding-argument-position requirement).

---

## The four stages

### 1. Local match construction — `O(N²)`, and deliberately sparse

Two rule triggers, and the whole similarity taxonomy is a choice between rule *sets*:

```lisp
;; :filter — run on every (base item, target item) pair
(MHCrule (:filter ?b ?t :test (equal (expression-functor ?b) (expression-functor ?t)))
         (install-MH ?b ?t))

;; :intern — run on each newly created match hypothesis
;; "if the MH concerns two facts, create MHs between corresponding arguments
;;  that are both functions or entities"
```

The `:intern` restriction is where the power is. Entity pairs are **never enumerated**; a match hypothesis between two entities exists only because some relation match above it needs it. This is what the paper calls **"middle out"** matching, and it is the specific reason SME does not pay Winston's `N_Eb!/(N_Eb − N_Et)!` entity-pairing cost.

| Rule set | What it matches | Models |
|---|---|---|
| **AN** (analogy) | higher-order relational systems; attributes only when embedded in one | soundness judgements |
| **LS** (literal similarity) | both low-order and higher-order structure | ordinary remindings — the mode [[wiki/entities/macfac.md]]'s stage 2 runs in |
| **MA** (mere appearance) | attributes and first-order relations only | retrieval / accessibility |

**Justification holes** are pruned here: a match hypothesis whose arguments failed to match can never satisfy support, so it is deleted — which is what stops an eighth-order `IMPLIES` from being placed against a second-order one.

### 2. Global match construction — the consistency algebra

A collection of match hypotheses is **structurally consistent** iff:

1. **one-to-one** — no base item to two targets, no target to two bases;
2. **support** — if `MH` is in, so are the MHs pairing all arguments of its base and target items.

A **gmap** is a *maximal* structurally consistent collection. Three sets, all computable as bit-vector operations over a unique bit position per MH:

```
Emaps(MH)        = union of entity/function correspondences implied by MH's descendants
Conflicting(MH)  = { MH(b_k,t_j) : b_k ≠ b_i } ∪ { MH(b_i,t_k) : t_k ≠ t_j }     (local, 1:1 violations)
NoGood(MH)       = Conflicting(MH) ∪ ⋃_{MH_j ∈ descendants} NoGood(MH_j)          (propagated upward)

Inconsistent(MH) ⟺ Emaps(MH) ∩ NoGood(MH) ≠ ∅        (two subtrees demand incompatible bindings)
Consistent(G_i, G_j) ⟺ Elements(G_i) ∩ NoGood(G_j) = ∅ ∧ NoGood(G_i) ∩ Elements(G_j) = ∅
```

Then three merges: **(a)** each consistent root plus its reachable subgraph becomes an initial gmap (recurse into offspring where the root is inconsistent); **(b)** merge gmaps sharing base structure — *this is the step that creates candidate inferences*, because the shared base root is precisely the structure the target lacks; **(c)** merge remaining independent gmaps into maximal combinations.

### 3. Candidate inferences

Base structure not in the gmap but **structurally grounded** in it (its subexpressions intersect the gmap's base items) is carried over with the gmap's substitutions applied. A base entity with no correspondent becomes a **skolem**: `(:skolem pipe)` — an explicitly conjectured entity the target is now asserted to contain. The only validity check is structural: discard a candidate inference whose arguments are a permutation of an existing target expression under a non-commutative predicate.

Everything else — truth, relevance, usefulness — is **out of scope by construction** and delegated to whatever module consumes SME's output.

### 4. Structural evaluation score (SES)

Numbers enter *only here*. A Belief Maintenance System (Dempster–Shafer-flavoured, belief as `(s(A), s(¬A))`) propagates:

```lisp
;; local evidence: same functor ⇒ 0.5 for the match
(assert! (implies same-functor (MH ?b ?t) (0.5 . 0.0)))

;; systematicity: 80% of a match's belief flows to its arguments' matches
(assert! (implies (MH ?b1 ?t1) (MH ?b2 ?t2) (0.8 . 0.0)))     ; MH2 matches children of MH1
```

`SES(gmap) = Σ evidence over its match hypotheses`. **Systematicity is implemented as a downward cascade along argument edges** — no global objective, no bird's-eye count of order. The more matched structure sits above a correspondence, the more it is believed; entity mappings inside a large systematic structure inherit high scores for free.

---

## The separation that is the actual contribution

> "the process of gmap construction is completely independent of gmap evaluation. Which gmaps are constructed depends solely on structural consistency. Numerical evidence is used only to compare their relative merits."

The paper reports that gmap *rankings* are insensitive to the evidence weights in their exploration, and that in the whole cognitive-simulation programme the rule sets never had to be tuned per example. For a builder this is a hard architectural claim: **the discrete/structural half and the continuous/scoring half of analogy factor cleanly**, and only the second half is where a learned component could go. Every neural analogy model in the wiki — ACME, LISA, the APNN `argmax` of [[wiki/concepts/analogical-mapping.md]] — fuses them, which is why none of them can enumerate alternatives.

---

## Complexity, and where the exponent actually lives

| Step | Worst case | Typical / measured |
|---|---|---|
| 1 — `:filter` rules | `O(N_b·N_t)` = `O(N²)` | MHs number ≈ `cN`, `c < 5` observed ⇒ `:intern` ≈ `O(N)` |
| 2 — `Conflicting` | `O(N²)` | `C` (alternate matches per item) always `< 10` observed ⇒ between `O(N)` and `O(N²)` |
| 3 — `Emaps` / `NoGood` | `O(M)` = `O(N²)` | each node touched once (queue + caching) |
| 4a — initial gmaps | `O(M)` | — |
| **4b, 4c — merges** | **`O(N!)`** | worst case for one is best case for the other; 4b "almost always" near-best-case |
| 5 — candidate inferences | `O(N³)` (loose bound `O(J·s_b·s_t)` = `N⁴`) | constant when there is a single gmap |
| 6 — SES via BMS | — | **70–80% of total runtime**; removable — the pre-BMS version ran in `O(M)` |

**The exponent is representation-dependent, not size-dependent.** Worst case (`O(N!)`) requires a *flat* description language with the same predicate repeated many times — that reduces to finding all isomorphic mappings between two equal-size sets. Two measurements:

- A PHINEAS problem taking **53 minutes** dropped to **34 seconds** purely by imposing more systematic structure on the same content.
- SME **cannot complete** Kline's baseball analogy in hours, because the description is flat (`(MALE catcher)`, `(BATS left-fielder)`, …).

> "SME will perform badly on large descriptions with no structure and extensive predicate repetition, but SME will perform well on large descriptions with deep networks of diverse higher-order relationships … The better organized and justified the knowledge, the better SME will perform."

**And the escape hatch is stated:** stop after merge step 1 and you have a complete set of initial gmaps in `O(N²)`; drive merges 2–3 by beam or best-first search instead. Merge 2 is required (it is what generates candidate inferences); merge 3 — the maximality step — is already an optional flag in the implementation. **This is the correct reading of the wiki's `O(n²)`–`O(n!)` row: SME is `O(N²)` up to a maximality guarantee you can decline to buy.** (Forbus & Oblinger's 1990 greedy merge, cited on [[wiki/entities/macfac.md]], is the later version of the same concession.)

Timings (Symbolics 3640, 8 MB): simple water/heat 0.70 s BMS + 0.23 s match; solar-system/atom 0.91 + 0.28; the largest example (PHINEAS behavioural, 40/8 base vs 27/6 target, 69 MHs, 6 gmaps) 9.68 + 1.92 — and the slowdown there is attributed to *flat* representations, not size.

---

## Results

**Solar system → Rutherford atom.** Three interpretations, ranked by SES with no domain knowledge anywhere:

| Gmap | SES | Content |
|---|---|---|
| 1 | **6.03** | sun↔nucleus, planet↔electron via the *mass* inequality; infers that mass difference + mutual attraction causes revolution — the standard reading |
| 2 | 4.04 | same entities, `TEMPERATURE` difference ↔ mass difference; loses because temperature has no mappable systematic structure *in the target* |
| 3 | 1.87 | spurious (mass of sun ↔ mass of electron) |

> "The interpretation preferred on structural grounds is also the one with the most inferential import. This is not an accident; the systematicity principle captures the structural features of well-supported arguments."

Note gmap 2's failure condition: the base may contain arbitrarily rich thermal knowledge and it still will not map, because **mappability is a joint property — a base system needs relational ground in the *target*** to be preferred.

**Karla the hawk (story set 5), the double dissociation on one engine.** Same base story, two targets (a true analogy, a mere-appearance match), two rule sets:

| Rule set | → analogy target (TA5) | → mere-appearance target (MA5) | Models the human measure |
|---|---|---|---|
| **AN** | **22.36** | 16.82 | soundness ratings — analogies judged more sound |
| **MA** | 6.41 | **7.70** | accessibility — surface matches retrieved more often |

The orderings reverse, from the same program on the same pair of stories, by swapping a rule file. This is SME's strongest cognitive claim: the surface-driven-retrieval / structure-driven-soundness dissociation that motivates [[wiki/entities/macfac.md]] is reproduced *without* two mechanisms — one matcher, two match criteria. (The paper concedes the MA run is "not a true simulation": it is bookkeeping over given pairs, not search over a memory pool — which is exactly the hole MAC/FAC was built to fill two years later.)

---

## PHINEAS: SME run twice, the second run constrained by the first

The one worked example of analogy doing real work, and the architecture is more interesting than the result.

1. **Behavioural match.** Observed heat-flow history vs a stored, already-explained water-flow history. Output: `Pressure↔Temp`, `Amount-of↔Heat`, `beaker↔horse-shoe`, `vial↔water`, `S0↔S0`, `S1↔S1`.
2. **Theory transfer.** SME is invoked *again* — base is the Qualitative Process Theory model of liquid flow, target is the current situation — with a match constructor rule that **freezes** the first run's correspondences:

```lisp
(MHC-rule (:filter ?b ?t :test (sanctioned-pairing? (expression-functor ?b)
                                                   (expression-functor ?t)))
          (install-MH ?b ?t))
```

Unmatched entities and functions remain free. Output: a gmap whose content is **almost entirely candidate inferences** — the flow-rate proportionality, the `I+`/`I−` influences on heat — plus `(:skolem pipe)` for the heat path, which downstream reasoning later resolves to physical contact.

Three transferable points:

- **The model was *constructed* by analogy, not augmented by it.** The system had no theory of heat flow; everything in the output is inferred.
- **A cheap surface/behavioural match becomes a hard constraint on an expensive deep match.** This is a two-pass schedule the wiki does not otherwise have: correspondence discovered on observable dynamics is *imposed* on the theory-level alignment, which collapses the second search. The general form — *align on what is observable, then transfer on what is not, under the first alignment's bindings* — is directly implementable and directly relevant to [[wiki/concepts/schema-assimilation.md]] and [[wiki/concepts/causal-model-building.md]].
- **Skolem entities are a usable output.** A conjectured object with no evidence yet is not an error state; the paper's analogy is the luminiferous ether, postulated because other waves needed a medium. Much refinement can proceed with the entity left conjectural.

---

## What the authors proposed instead of their own algorithm (§6.2.2)

The match-hypothesis graph *already is* a constraint network: support links are excitatory, `Conflicting` links are lateral inhibition. Run relaxation on it and the best gmap emerges without any gmap ever being enumerated; inhibit the winner's nodes to force the second-best up, and so on.

> "SME would be able to establish a global interpretation simply as an indirect consequence of the establishment of local structural consistency and systematicity. This would eliminate the single most expensive computation of the SME algorithm … the complexity of the algorithm could drop to the `O(N²)` required to generate the connectionist network."

This matters for three wiki rows. (i) It is ACME (Holyoak & Thagard, same year) proposed by structure-mapping's own authors, so the symbolic/connectionist split in [[wiki/concepts/analogical-mapping.md]]'s model table is a smaller disagreement than the table suggests — the objection to ACME is that its constraints are *soft* (so it violates one-to-one and maps semantically unrelated structures), not that it relaxes. (ii) The `O(N²)` network is exactly the object [[wiki/concepts/attractor-dynamics.md]] and [[wiki/concepts/energy-based-models.md]] describe, so "settle a support/inhibition graph" is the mechanistic form of T173's claim that correspondence need not be searched. (iii) The **inhibit-and-resettle** trick is the missing piece of the neural route: the APNN `argmax` and every relaxation model commits to one interpretation, and this is a one-line recipe for enumerating the rest in rank order — which is what SME's discrete enumeration was buying.

Also stated: every stage parallelises, most to log time in the input size (the propagations are upward sweeps; the merges are pairwise trees).

---

## Limitations, stated

| Limitation | Consequence |
|---|---|
| **SES is not normalised** by base or target size | comparable across *bases against one target*, or *targets against one base*; **not** across two different analogies — so SES cannot serve as an absolute retrieval score (the same missing-absolute-threshold hole as [[wiki/entities/macfac.md]]'s relative 10% selector, G38) |
| **SES omits real structural factors** | number and size of connected components, and the structure of the candidate inferences themselves, do not enter |
| **The abstraction-level window** (§6.1) | base and target must be described at compatible levels of abstraction or no analogy is found at all: too abstract ⇒ no predicate overlap (`GREEK-TRAGEDY` vs `SHAKESPEARE-DRAMA`) or bare identity; too detailed ⇒ spurious matches. Proposed fix: invoke SME repeatedly, sliding descriptions up and down the abstraction ordering using predicate definitions — **not implemented**, and it is the same re-representation gap this wiki logs as G4/G27 |
| **Attribute/function-plus-constant asymmetry** | `RED(x)` and `= (COLOR x) RED` are logically equivalent and behave differently under matching; the model simply assumes a reasoner holds one form at a time |
| **Representation is hand-authored** | mitigated, not solved, by three methodological guards: a fixed rule set across all experiments, an accumulated shared description vocabulary, and descriptions generated *automatically* by qualitative simulators (GIZMO) — on which SME does **better** than on hand-built ones |
| **No access stage, no evaluation stage** | scope is mapping only, by decomposition |

---

## Two positions worth carrying

**Many-to-one should be multiple analogies, not relaxed consistency.** SPROUTER, THOTH and RELAX allow many-to-one bindings; Kline's example is `(male NLpitcher)` needing to match both `(male ALpitcher)` and `(male ALdesignatedhitter)`. SME's answer: keep one-to-one, and let a postprocessor retain *several* gmaps — the baseball case is an offence interpretation and a defence interpretation. **Retaining `k` consistent interpretations dominates emitting one inconsistent one**, and it is a design rule for any wiki matcher that currently returns a single `argmax` — against which the same paper's own §6.2.2 relaxation proposal, and every scalable matcher in the wiki, commits to one ([[wiki/empirical-tensions.md]] T306).

**Structure-mapping neither subsumes nor is subsumed by unification.** `CAUSE(FLY(P1), FALL(P1))` / `CAUSE(FLY(P2), FALL(P2))` is a legitimate analogy and does not unify (distinct constants); `CAUSE(?X(P1), FALL(P1))` / `CAUSE(FLY(?Y), FALL(?Z))` unifies and is not an analogy (variables are treated as constants, so `?X ≠ FLY`, and `?Y`, `?Z` may not both map to `P1`). The goals differ: unification seeks substitutions making two statements **identical**; structure-mapping seeks correspondences that **suggest new inferences**, and partial matches are the point.

---

## Connections

- **[[wiki/concepts/analogical-mapping.md]]** — this is the model that page's landscape table prices first and the operation it names as its subject: the primary source relocates the `O(n!)` to a single optional maximality merge, and supplies the construction/evaluation separation the page's neural candidates all collapse.
- **[[wiki/entities/macfac.md]]** — the retrieval stage built two years later around this engine's cost: MAC's functor-count dot product is an analytic over-estimate of *this* algorithm's step-1 match-hypothesis count, and FAC is this engine in literal-similarity mode with the 10% selector on its SES.
- **[[wiki/concepts/subgraph-matching.md]]** — the same alignment problem with the constraint moved into the geometry: containment is decided by a coordinate comparison over learned embeddings where this decides correspondence by consistency algebra over bit vectors, and only this one returns *which node is which* plus a transferable remainder.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the rival cost model and the one this engine's own §6.2.2 concedes ground to: a dot product over structure-sensitive codes replaces the merge steps, and the systematicity preference that this page implements as an 0.8 belief cascade becomes an emergent property of nested binding.
- **[[wiki/entities/lisa.md]]** — the same mapping problem solved by synchrony rather than enumeration: LISA's capacity limit is the number of simultaneous phases, where this engine has no capacity limit and instead pays combinatorially exactly where descriptions are flat.
- **[[wiki/concepts/compositionality.md]]** — systematicity made mechanical: the preference for interconnected higher-order structure is computed by an 0.8 belief cascade down argument edges, which is the cheapest local implementation of "meaning depends on arrangement, not only on parts" in the wiki.
- **[[wiki/concepts/attractor-dynamics.md]]** — the implementation the authors proposed for their own most expensive step: support links as excitation, `Conflicting` links as lateral inhibition, and the best interpretation read off the settled state — with inhibit-and-resettle giving the second-best on demand.
- **[[wiki/concepts/energy-based-models.md]]** — the match-hypothesis network is a constraint-satisfaction energy whose minima are the gmaps, so structural consistency is expressible as hard constraints in an energy function rather than as an algebra over bit vectors.
- **[[wiki/concepts/external-verification.md]]** — the engine deliberately stops one step short of this page: candidate inferences are surmises with only a permuted-argument sanity check, and validity, relevance and usefulness are delegated by explicit design decomposition.
- **[[wiki/concepts/causal-model-building.md]]** — what PHINEAS actually transferred: a qualitative process model, constructed entirely out of candidate inferences because the target had no theory at all, with the unmatched causal medium retained as a skolem entity.
- **[[wiki/concepts/schema-assimilation.md]]** — the two-pass schedule this page contributes: align on observable behaviour first, then impose those correspondences as hard constraints on the theory-level match, so slot-filling for the expensive structure is decided by the cheap one.
- **[[wiki/concepts/program-induction.md]]** — the identicality constraint is a claim about the primitive vocabulary: relations match only when identical, so all semantic flexibility is pushed into re-representing descriptions in a canonical language, which makes the language the learned object.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the engine assumes both graphs and discovers neither, and says so: its abstraction-level window problem is the statement that even *given* two graphs, mapping fails unless they were carved at compatible grain.
- **[[wiki/entities/dreamcoder.md]]** — a mechanism for the re-representation SME presupposes: its abstraction phase searches *semantically equivalent refactorings* of solved programs for a shared fragment, which is exactly the operation that turns `HEAVIER`/`TALLER` into a common `GREATER[DIM(x), DIM(y)]` — done by compression over a corpus rather than by a matcher's tiered-identicality rules.
