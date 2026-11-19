# Least General Generalization — Anti-Unification

**The least general generalization (LGG) of a set of expressions is the most specific expression of which every member is an instance. It keeps what all members share, replaces each position where they differ by a variable, and reuses one variable wherever the same tuple of differing sub-expressions recurs. For atoms it exists whenever the expressions are compatible (same predicate, same sign), is unique up to renaming, and is computed by a terminating algorithm (anti-unification). For clauses it exists whenever one literal per clause can be paired, but its raw size is the product of the clause sizes and its cleanup needs subsumption tests. It is the dual of unification.**

> **Provenance.** Plotkin 1970, *A note on inductive generalization*, Machine Intelligence 5, pp. 153–163 (`raw/plotkin-1970-note-on-inductive-generalization.md`). A formal note with definitions, three theorems and their proofs, one worked board-game example, and a "Further results" section stated without proof. Plotkin credits R. J. Popplestone with the idea that generalizations and least generalizations of literals exist and are useful for induction. The clip is a lossy PDF conversion: the symbols for ≤, ~, ∨ and σ are garbled, Figures 1–4 are lost, and the board-game derivation table is partly unreadable. The statements below are reconstructed from the prose and the proofs. The source has no experiment and makes no neural or cognitive claim. Lines marked "general knowledge" are not in the source.

---

## Formalism

| Object | Definition (Plotkin 1970) | Reading |
|---|---|---|
| **Word** | A term or a literal | — |
| **Generality on words** | `W₁ ≤ W₂` (`W₁` more general) iff `W₁σ = W₂` for some substitution `σ` | Instantiation is the only step |
| **Generality on clauses** | `C₁ ≤ C₂` iff `C₁σ ⊆ C₂` (subsumption) | Instantiate a variable *and* add literals (preconditions) |
| **Why subsumption, not implication** | Whether implication between clauses is decidable was unknown; subsumption "allows a more manageable theory" | The ordering is chosen for tractability, not fidelity |
| **Compatible** | Both terms, or the same predicate letter and sign | The predicate symbol is never generalized |
| **LGG of a set `K`** | `W ≤ V` for every `V ∈ K`, and every other `W′` with that property has `W′ ≤ W` | Unique up to alphabetic variant (words), up to subsumption-equivalence (clauses) |
| **Category reading** | Objects are words; a morphism `V → W` exists iff `Vσ = W`. The LGG is the *product*; Robinson's (1965) most general unifier is the *coproduct* (Burstall's suggestion, not pursued) | Generalization and unification are one construction and its dual |

### Theorem 1: words

Every non-empty finite set of words has an LGG iff every two of them are compatible. The algorithm for two words (anti-unification):

1. `Vᵢ ← Wᵢ`, `sᵢ ← ∅`.
2. Find terms `t₁, t₂` at the same place in `V₁, V₂` with `t₁ ≠ t₂`, where either their leading function symbols differ or at least one of them is a variable.
3. If there are none, halt: `V₁ = V₂` is the LGG and `V₁sᵢ = Wᵢ`.
4. Take a fresh variable `x` and replace `t₁, t₂` by `x` **wherever they occur at the same place** in `V₁, V₂`.
5. `sᵢ ← {tᵢ/x}sᵢ`; go to 2.

The algorithm terminates because each replacement strictly lowers the number of replaceable places (Lemma 1.2). For `n` words, nest it: `inf{W₁, inf{W₂, …}}`. Example: `{P(f(a,g(y)), x, g(y)), P(h(a,g(x)), x, g(x))} → P(y, x, g(z))`.

**Lemma 2 gives the two properties a schema learner wants.** Let `W` be the LGG, with `Wμᵢ = Wᵢ`.

1. Every sub-term `t` of `W` is the LGG of its images `{tμᵢ}`, so structure is generalized position by position.
2. If two variables have the same image in every instance (`xμᵢ = yμᵢ` for all `i`), they are the same variable. **Co-reference is kept exactly:** each recurring tuple of instance terms gets one variable, so "the same object in two roles" survives generalization.

### Theorem 3: clauses

| Result | Statement |
|---|---|
| **Existence** | A finite set `S` of clauses has a non-empty LGG iff `S` has a *selection* (one literal from each clause, all compatible). Otherwise its only generalization is the empty clause `□` |
| **Algorithm** | Pair every literal of `C₁` with every compatible literal of `C₂`, and anti-unify all pairs *jointly* (packed into one atom, so that shared terms get shared variables). Read the result back as a clause |
| **Raw size** | Up to `\|C₁\|·\|C₂\|` literals. Two 9-literal descriptions with one predicate (tic-tac-toe) give ≥ 81 |
| **Reduction** | Equivalent clauses need not be alphabetic variants (`{P(x), P(f())} ~ {P(f())}`). Each class has a *reduced* member, one equivalent to no proper subset of itself, which is unique up to renaming. It is computed by deleting literals while a subsumption test still succeeds |
| **Bottleneck** | The subsumption test inside the reduction is "the main computational weakness": deciding whether an 81-literal clause subsumes an 80-literal one |

### Further results (stated without proof)

- Subsumption-equivalence classes form a lattice. Meet = LGG; join = union after renaming the two clauses apart. The lattice is not modular.
- **Infinite chains toward the specific end.** `C₁ = {P(x₀,x₁)}`, `Cᵢ = Cᵢ₋₁ ∪ {P(xᵢ₋₁,xᵢ)}` are directed paths of growing length. Each is strictly more specific than the one before, and all are more general than `{P(x,x)}`.
- **Infinite chains toward the general end.** One exists that is function-free and uses one binary and one unary predicate. Every such chain is bounded by `□`.

### Worked examples

| Instances | LGG | What the operation did |
|---|---|---|
| `Bitofiron(bit1) ∧ Heated(bit1, 419) → Melted(bit1)` and the same for `bit2` | `∀x Bitofiron(x) ∧ Heated(x, 419) → Melted(x)` | The shared constant `419` stays. The differing pair `(bit1, bit2)` becomes one variable, co-referenced across three literals |
| Two won positions on a two-square board (squares `10`, `20`): `X` in `10`, `O` in `20`; and `X` in `10`, `X` in `20` | Raw LGG has 5 literals. Reduced: `Occ(10, X, p) ∧ Occ(20, x, p) → Win(p)` | "An `X` in square 1 and anything in square 2 is a win": a rule from two positives, which Plotkin calls "fairly reasonable" given the evidence |

---

## What it gives the wiki `(brainstorm)`

| Wiki object | What the LGG supplies | Where it stops |
|---|---|---|
| Meta-graph = the *lowest* common lit ancestor ([[wiki/concepts/abstraction-graph.md]], Scoring) | On the subsumption fragment of that page's generality order (instantiate a variable, add a precondition), the lowest common ancestor of two schemas exists whenever they share a predicate, is unique up to equivalence, and is computable. The conjecture becomes an operation | The page's order also has chain and unfold edges. Those are implication, which Plotkin set aside as possibly undecidable |
| "The generaliser makes the invariant part a node and the varying part a slot" ([[wiki/concepts/abstraction-graph.md]], Fidelity) | Anti-unification is exactly that operation for slots over individuals, and it keeps co-reference (Lemma 2.2), which row 1 of the requirements table needs | A slot over *values* (a coarse variable) is not covered: two unequal constants become a free variable, never a coarser value |
| The discovery case: "where no common lit ancestor exists" | In this ordering, a common generalization other than `□` fails to exist exactly when the schemas share no predicate-and-sign pair. The discovery case is then a *vocabulary mismatch* | Pushes the problem onto re-representation: [[wiki/entities/sme.md]]'s identicality constraint, gap `G4` |
| Alignment (requirements row 3) | The clause LGG never *chooses* a correspondence. It takes the product of all compatible pairings and lets reduction delete redundancy | Paid as `\|C₁\|·\|C₂\|` raw literals followed by subsumption tests. [[wiki/entities/sme.md]] instead commits to one-to-one mappings |
| Schema induced from two analogs ([[wiki/concepts/schema-assimilation.md]]) | "The schema is the intersection the mapping exposes", with a minimality proof, and for atoms with no mapping step at all | Unshared content is *deleted*, not down-weighted as in [[wiki/entities/lisa.md]]: one atypical example removes a literal for good, and frequency never enters |
| `G26` (selection by structure, not length) | A selection rule of opposite sign to Occam: the *most specific* clause covering every positive. The board-game LGG keeps `Occ(20, x, p)`, which a shortest consistent rule would drop | Positives only. It keeps every shared accident, and nothing stops it short of the full intersection |
| Generality depth ([[wiki/concepts/abstraction-graph.md]], Open problems) | Under subsumption, depth cannot be a count of strict generalization steps: infinite strict chains exist between finite clauses | — |

**The graph reading** (general knowledge, not in source). Function-free clauses over one binary predicate are directed graphs, and subsumption between them is graph homomorphism. The clause LGG is the categorical (direct) product of the two graphs, and the reduced clause is the product's core. So the LGG of two relational structures is the most specific pattern that both map onto *homomorphically*. That is a many-to-one notion of shared structure, unlike the injective one in [[wiki/concepts/subgraph-matching.md]]. Deciding subsumption is NP-complete (general knowledge), which is why reduction is the bottleneck Plotkin names.

---

## Instantiations

| System | Relation to the LGG |
|---|---|
| [[wiki/entities/ilp-arc-synthesizer.md]] | The opposite search direction. FOIL-style top-down search starts general and adds body literals. The LGG is the most specific end of the same clause-length dial: the most literals that any clause covering all positives can keep |
| — | No ingested system computes LGGs. No neural or cognitive implementation is in the wiki |

---

## Open problems

- **Positives only.** No negative example enters, so there is no stopping rule short of the full intersection, and a single noisy positive deletes structure. [[wiki/entities/ilp-arc-synthesizer.md]]'s negatives manufactured from overgeneration are the missing half.
- **Size grows as a product.** For `n` clauses the raw LGG grows as `∏|Cᵢ|`, and reduction needs repeated subsumption tests.
- **Purely syntactic.** No background knowledge enters. Two schemas that are equivalent through a definition but written differently get a needlessly general LGG. The relative LGG over background knowledge (Plotkin 1971, not ingested) is the known extension.
- **First-order only.** Predicate letters are never generalized, so a variable that ranges over relations (the Width row of [[wiki/concepts/abstraction-graph.md]]) is outside the operation.
- **No neural realization.** `(brainstorm)` Over role–filler codes ([[wiki/concepts/tensor-product-representation.md]]), roles are the "places": compare fillers role by role, keep equal ones, and replace unequal ones by a variable *keyed by the filler pair*. Lemma 2.2's co-reference rule then needs a code conjunctive over the two instances' fillers, which is the product construction again, in units.

---

## Connections

- **[[wiki/concepts/abstraction-graph.md]]** — turns that page's "meta-graph = lowest common lit ancestor" conjecture into an operation on the subsumption fragment of its generality order. It names the generaliser of its Fidelity row as anti-unification with co-reference kept. Its infinite chains show that depth on the generality axis cannot be a step count.
- **[[wiki/concepts/program-induction.md]]** — the bottom-up, specific-to-general route to a clause, which the family's inductive-logic-programming member searches top-down. It also supplies a selection rule (least generality) that is not description length.
- **[[wiki/entities/ilp-arc-synthesizer.md]]** — the opposite end of that system's clause-length dial: FOIL adds literals from the general end, while the LGG is the most specific clause covering all positives. That system's manufactured negatives are what the LGG lacks to stop anywhere short of the full intersection.
- **[[wiki/concepts/schema-assimilation.md]]** — the formal version of "a schema is the intersection that comparing two analogs exposes": minimal and unique. It differs from LISA's induction by deleting unshared content rather than down-weighting it.
- **[[wiki/entities/sme.md]]** — the dual of the unification that page contrasts structure-mapping with. It shares structure-mapping's identicality constraint at the predicate level (only same-predicate literals pair), but drops one-to-one: the product keeps every pairing and lets reduction prune.
