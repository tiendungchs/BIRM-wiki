# MAC/FAC

**"Many Are Called but Few Are Chosen": a two-stage model of similarity-based retrieval from long-term memory. Stage 1 scores *every* item in memory with a dot product between vectors that count how often each functor occurs, and passes the survivors to stage 2, which runs a full structural alignment (SME) on them. Its design target is not accuracy — it is the human retrieval *error profile*.**

> **Provenance.** Gentner, D. & Forbus, K. D. (1991), *MAC/FAC: A Model of Similarity-based Retrieval*, Proceedings of the Cognitive Science Society (`raw/gentner-1991-macfac-similarity-retrieval.md`). The conference version.

> **Provenance (second ingest).** Forbus, K. D., Gentner, D. & Law, K. (1995), *MAC/FAC: A Model of Similarity-based Retrieval*, Cognitive Science 19(2), 141–205 (`raw/forbus-1995-macfac-similarity-retrieval.md`). The journal version. The architecture is unchanged; what it adds is **the validation apparatus** — a sensitivity analysis over the design space, a head-to-head against ARCS with a clock, and the match-criterion argument — plus the parts of the theory the conference paper compressed away (tiered identicality, trickle-down evaluation) and a set of empirical constraints on what a retrieval stage may be asked to do. Sections below are marked 1995 where they come from it.

The wiki has cited this architecture secondhand from [[wiki/entities/lisa.md]]'s literature (Holyoak 2012) and from Plate 1993 ([[wiki/concepts/vector-symbolic-binding.md]]). This page is the primary source: what the cheap stage actually computes, and why.

---

## Architecture

| Component | Stage 1 — **MAC** | Stage 2 — **FAC** |
|---|---|---|
| Applied to | every item in the memory pool | only MAC's output |
| Matcher | dot product of **content vectors** | SME (Structure-Mapping Engine, Falkenhainer, Forbus & Gentner 1989) in **literal-similarity** mode |
| Output per item | one scalar | correspondences + structural evaluation + **candidate inferences** |
| Selector | best match and everything within **10%** of it | same 10% rule |
| Cost | one `\|P\|`-dimensional dot product per item, parallelisable / connectionist-implementable | `O(n²)` match-hypothesis generation + greedy merge (Forbus & Oblinger 1990), `n` = items in base or target |
| Penetrable by task set? | "MAC is impenetrable" — instructing subjects to seek relational remindings does not increase them (1995) | **Tunable**: the same instruction halves surface remindings (1995) |

`P` = the set of functors (predicates, functions, connectives) appearing anywhere in probe or memory descriptions. The **content vector** of a description `D` is the `\|P\|`-tuple whose `i`-th component counts occurrences of functor `i` in `D` — a redundant, lossy re-encoding of a structured representation, computed by counting and stored alongside the item. Normalised variants were tried with no significant difference, but the authors expect normalisation to become necessary once thresholds are added.

**Order** (used throughout to define the match types): objects and constants are order 0; the order of a statement is `1 + max(order of its arguments)`. An analogy is a match on a common system of relations, especially higher-order ones.

---

## The one idea worth copying: the cheap stage estimates the expensive stage's *workload*, not its answer

MAC does not approximate FAC's structural evaluation. It approximates **numerosity** — the number of match hypotheses SME would generate if it were run:

```
score(probe, item) = ⟨cv(probe), cv(item)⟩
                   ≈ Σ_functors (#occurrences in probe)·(#occurrences in item)
                   ≳ number of local match hypotheses SME would create
```

Because SME only hypothesises a local match between two statements headed by the same functor, the product of corresponding components **over-estimates** the match hypotheses of that type, and few local matches entail that no large global interpretation can exist. That is the filter's soundness argument, and it is one-sided in the safe direction (over-count ⇒ do not drop a candidate that would have aligned well).

Two named ways numerosity nonetheless fails to predict interpretation size: (i) a match hypothesis can end up **ungrounded** because its arguments cannot be put into correspondence, and (ii) the **1:1 constraint** can shatter a large candidate interpretation into several small incompatible ones.

**(brainstorm) This is a distinct amortisation recipe and the wiki has no other instance of it.** Every other cheap first stage here — order embeddings ([[wiki/entities/neuromatch.md]]), an HRR dot product ([[wiki/concepts/vector-symbolic-binding.md]]), a responsibility posterior ([[wiki/concepts/contextual-inference.md]]) — approximates the expensive stage's *output*, and therefore needs either training data or a geometric guarantee. MAC approximates an *internal counter* of the expensive algorithm, which is (a) derivable analytically from the algorithm's own definition, (b) free of any learning, and (c) one-sided by construction. The recipe generalises: for any exact matcher, find a cheap statistic that bounds its search-space size, and filter on that. Applied to [[wiki/concepts/subgraph-matching.md]], the analogue would be filtering on per-label degree histograms — a bound on the number of candidate node mappings — rather than on a learned embedding of containment.

---

## Results

**Materials.** The "Karla the Hawk" story sets: a base story plus four variants generated by crossing two axes. All variants share first-order relations.

| | Common object attributes | No common object attributes |
|---|---|---|
| **Common higher-order relations** | **LS** literal similarity | **AN** analogy |
| **No common higher-order relations** | **SF** surface / mere-appearance | **FOR** first-order relations only |

**Human data** (memory set 32 stories = 20 base + 12 distractors; 20 probes; delay of a week or more; free written reminding):

| Probe type | Proportion of remindings |
|---|---|
| LS | .56 |
| SF | .53 |
| AN | .12 |
| FOR | .09 |

Order `LS ≈ SF ≫ AN ≈ FOR` was stable across three variations of the study. **Rated soundness runs the other way** — `AN, LS > SF, FOR` — and the dissociation holds *within subject*: subjects rating soundness immediately after cued retrieval judged the very matches that had come to mind most easily (mere-appearance) to be unsound. Access and evaluation are therefore qualitatively distinct processes, not two readings of one similarity number.

**Simulations** (9 of the 20 story sets encoded in predicate calculus = 45 stories; entries are proportion or mean number surviving each stage):

| Experiment | Memory pool | Probes | Retrieval, by type (MAC → FAC) |
|---|---|---|---|
| 1 | 9 base + 9 FOR (18) | LS, SF, AN variants | LS 1.0 → 1.0 · SF .89 → .89 · AN .67 → .56 |
| 2 | 36 (LS, SF, AN, FOR × 9 sets) | the 9 base stories | LS .78 → .78 · SF .67 → .44 · AN .33 → .11 · FOR .22 → .00 · other-set 1.33 → .22 |
| 3 | 27 (LS variants removed) | the 9 base stories | SF .89 → .78 · AN .56 → .45 · FOR .22 → .11 · other-set 1.11 → .11 |

Ordinal fit to the human ordering in all three. **Filter ratio, experiment 2: MAC emits 3.3 items on average, FAC accepts 1.5.**

> The 1995 journal version reports the same three experiments with small numeric differences — experiment 1 AN `.67 → .67`, experiment 2 SF `.78 → .44` and AN `.33 → .22`, experiment 3 SF `.88 → .78` and AN `.56 → .56`, filter ratio 3.4 → 1.6 — from re-encoded stories and a later SME build. The ordering and the argument are unchanged; the discrepancy is recorded because both sets of numbers are cited in the wiki. FAC behaves as designed — it accepts every LS match MAC proposes, some partial (SF, AN) matches, and rejects most FOR and cross-set matches, taking other-set intrusions from 1.33 to 0.22.

**Against the strongest rival.** ARCS (Thagard et al. 1990) — a localist constraint-satisfaction network integrating semantic, structural and pragmatic constraints, i.e. an ACME-style net built between the probe and *every* memory item — was given the Karla story plus 100 fables as distractors and produced asymptotic activations LS .67, FOR −.11, SF −.17, AN −.27: **two violations** of the human ordering. MAC/FAC fits the data better with no network and no relaxation.

---

## The four criteria — a retrieval stage designed to be wrong

The paper states its design target as four properties, and the third and fourth are the ones the wiki's other retrieval mechanisms do not have:

| Criterion | Content | Satisfied by |
|---|---|---|
| **Primacy of the mundane** | most remindings should be literal-similarity matches, because mundane matches are usually the best guides to action (riding a new bicycle is like riding old ones) | FAC runs SME in *literal similarity* mode rather than analogy mode — deliberately, so surface remindings survive stage 2 |
| **Fallibility** | the model must *not* always produce the best structural match | content vectors discard relational structure |
| **Existence of rare events** | purely structural remindings must still occur at a low rate | AN matches survive both stages at .11–.45 |
| **Scalability** | must run over a memory pool the size of long-term memory | one dot product per item |

This inverts the normative framing the rest of the wiki uses. [[wiki/entities/neuromatch.md]]'s 49% precision at 97.9 AUROC is recorded as a defect ([[wiki/empirical-tensions.md]] T22) and G37's first missing piece is a *certificate* that would flag such errors; here the same class of error is the phenomenon to be reproduced ([[wiki/empirical-tensions.md]] T197).

Corollary the paper draws against case-based reasoning: intelligent indexing of structured representations "can predict superhuman access behavior" — that people should typically access the best structural match even with no surface similarity — and unique-description indexing is judged unlikely to scale, because dozens or hundreds of experiences can be similar enough to share an index entry while remaining worth storing separately.

---

## Sensitivity analysis: which design choices are load-bearing (1995)

The journal version's methodological contribution is generalisable past this model. A working simulation rests on three kinds of design choice — **forced by the theory**, **weakly constrained**, and **irrelevant but necessary to have a running artifact** — and a fit is only evidence for the theory if varying the first kind breaks it and varying the third kind does not. The test is run by sweeping the two selector widths (MAC × FAC, 1–100% in 10% steps, 121 cells, each cell a re-run of the two simulation experiments) and colouring each cell by *which criterion failed*, producing a map of viable and non-viable regions rather than a single fit score.

| Manipulation | Kind of choice | Viable region | Reading |
|---|---|---|---|
| Baseline (unit-normalised content vectors) | — | MAC 10–20% × FAC ≥ 10% | Robust — the reported 10%/10% setting is interior, not a knife-edge |
| **No normalisation** (raw counts) | theoretically irrelevant | ≈ same size and shape | Correctly not load-bearing |
| **Binary** content vectors (presence, not count) | weakly constrained | shifts to MAC 30–50%, same character | Measuring *how many predicates are shared* rather than *the pattern of their frequencies* costs a re-calibration of the selector, nothing more: mean MAC output rises 1.5 → 2 |
| **Attributes only** in the content vector | theoretically forced | **none, anywhere in the design space** | Relational content never cues retrieval, so the *rare insights* criterion cannot be met at any width |
| **Relations only** (attributes dropped) | theoretically forced | exists (MAC 40–50% × FAC 20–60%) but MAC then emits **≈ half the memory pool** | Fails *scalability*: the relational vocabulary alone does not discriminate, so the expensive stage is handed a large fraction of memory |

**The transferable result, and the wiki has no other statement of it: a cheap retrieval statistic must mix object-level and relation-level content, and the two failures are of opposite type.** Attributes alone lose the ability to ever surface a structural match; relations alone lose *discrimination*, and the cost surfaces not as a wrong answer but as a filter that stops filtering. Both diagnoses are argued at source to apply to any retrieval model, not just this one — which makes them a direct constraint on [[wiki/entities/neuromatch.md]]-style learned filters (trained on relational topology alone) and on the content of any first-stage index.

**Failure shapes are informative too.** Too narrow on either stage (1%) ⇒ no analogies at all; MAC broad (≥30%) plus FAC broad ⇒ first too many analogies, then junk retrievals from unrelated story sets. The shape of the viable region says **MAC does most of the filtering** — which is what it was designed to do, and therefore evidence the fit comes from the theory rather than from somewhere else.

---

## Against ARCS, with a clock — and why precision beats recall at scale (1995)

ARCS (Thagard et al. 1990) builds a localist constraint-satisfaction network between the probe and every memory item sharing a WordNet-similar predicate, then relaxes. Both systems were run on the *same* machine over ARCS's own hand-encoded databases (100 Aesop's fables, 25 Shakespeare plays, the Karla story set, the Sour Grapes set).

| Probe / memory | ARCS | MAC/FAC |
|---|---|---|
| Sour Grapes variants / 100 fables | correct, 81–123 s | correct, 0.2–0.3 s |
| Sour Grapes variants / 125 fables+plays | **analog probe now retrieves *The Taming of the Shrew*** | unchanged, 0.3–0.4 s |
| Hamlet / 125 | Romeo & Juliet then 5 others, **4112 s** | Romeo & Juliet alone, **26 s** |
| West Side Story / 125 | *A Midsummer Night's Dream* ranked above Romeo & Juliet | Romeo & Juliet (FAC 16.51 — near-isomorphic encodings) |
| Karla variants / 125 | Karla base falls from rank 9 to rank 18 when 25 plays are added | Karla base retrieved first for every variant |

Three readings, in increasing order of transferability:

1. **Two orders of magnitude**, typical across the set. Per-comparison: MAC 0.002 s per content-vector pair against SME's 1–11 s (mean ≈ 4 s) per structured pair — a stage-cost ratio of ~2×10³, which is the number that makes the two-stage split worth having at all.
2. **Relative activations are not a stable retrieval measure.** Growing memory by 25% reorders ARCS's output and reverses the FOR/AN ordering; it also shows a size bias toward larger descriptions. A model whose predicted retrieval *probabilities* are relative activations in a network that includes every candidate cannot be evaluated independently of the distractor set — a hazard for every scoring scheme that normalises over the whole pool.
3. **The match criterion dominates the architecture.** Re-running ARCS with its WordNet similarity network removed — so only identical predicates create local matches — fixes most of the false positives (Sour Grapes no longer distracted by plays; Romeo & Juliet recovered for West Side Story). The looseness of the semantic-similarity test, not the constraint-satisfaction architecture, was doing the damage.

**The economics, stated as a principle: in a large memory, false positives cost more than false negatives, *because retrieval is iterative*.** A miss can be recovered by reformulating or re-representing the probe and querying again (retrieval interleaved with reasoning); a false positive consumes the expensive stage and can only be caught after paying for it. This inverts the usual recall-oriented framing of approximate retrieval and is the argument for a *tight* match criterion at stage 1 — the opposite of Holyoak & Thagard's position that broader semantic similarity is needed to avoid missed retrievals. **(brainstorm)** It also gives the wiki's approximate matchers a design rule they currently lack: the acceptable error asymmetry is a function of whether the query can be cheaply re-issued with a modified probe, which is an architectural property, not a tuning choice.

---

## Tiered identicality, and the typology that is not notation (1995)

What stage 2 is *allowed* to call a match:

| Element | Match rule |
|---|---|
| **Relations** (multi-argument predicates, and all logical connectives regardless of arity) | must match **identically** — or be **re-represented** into a form that does: decomposition into a canonical language (`bestow`/`bequeath` → `give`), or *minimal ascension* (a close common superordinate, Falkenhainer 1987) |
| **Functions** (`HEIGHT(x)`, `PRESSURE(x)` — map entities to values on a dimension) | may match **non-identically** if embedded in matching relational structure — this is what buys cross-dimensional matches (`HEIGHT` ↔ `DARKNESS`, "Sally is sharper than Bill") |
| **Entities** | any two may correspond, if relational structure suggests it |

The re-representation ladder in one line: `HEAVIER[camel,cow]` vs `TALLER[giraffe,donkey]` do not match as relations, but rewriting both as `GREATER[DIM(x), DIM(y)]` makes the mismatch a *function* mismatch, which is permitted. Non-identity is thus not banned — it is **relocated to a level where it is cheap**.

The corresponding rejection: pure graph isomorphism is not analogy. "Fred loves New York" / "General Motors sells cars" are isomorphic and not analogous; the authors classify Holyoak & Thagard's smart/tall–hungry/friendly item as a logic puzzle rather than an analogy. **This is a live constraint on every structure-only matcher in the wiki** ([[wiki/concepts/subgraph-matching.md]], [[wiki/concepts/analogical-mapping.md]]): a matcher that scores topology alone will accept comparisons humans reject, and the fix proposed here is not a similarity table but a canonical representation language plus cheap inference to reach it.

**The typology is load-bearing, and there is one measurement.** Re-encoding ARCS's Karla representations *without* functions (so every predicate is an attribute or a relation) leaves the MAC scores identical — content vectors count identical functors either way — but knocks the correct base story out of the **FAC** output, because the story's causal structure can then no longer be consistently mapped across non-identical relations. Attribute/relation/function is therefore a distinction in the matcher's *rules*, not in the notation, and it changes retrieval outcomes.

---

## Structural evaluation is a local computation (1995)

Systematicity is scored without any global view of the two structures. Every match hypothesis gets an initial score (this enforces the size preference); scores then **trickle down** the argument links:

```
W(MH₂) ← max{ W(MH₂) + δ·W(MH₁), 1.0 }      MH₂ matches an argument of MH₁'s statements
structural evaluation of an interpretation = Σ W(MH) over its correspondences
```

so object correspondences supporting a deep relational structure accumulate weight from above. The alternative — weight a match by its order directly — was tested and fits human soundness ratings **worse** (Forbus & Gentner 1989), and is rejected on architectural grounds as requiring a "bird's-eye view" of the representations that no local process has. **The systematicity preference is therefore a message-passing rule, not a global objective** — directly implementable, and the form a neural version would need.

---

## Stage 1 is impenetrable; stage 2 is tunable (1995)

Schumacher & Gentner: subjects reading test proverbs either wrote down any reminding, or were instructed to report **only structural** remindings and to maximise them. The instruction **halved surface matches and left the number of analogies unchanged**.

**A task set can filter what retrieval returns; it cannot make retrieval look harder for structure.** Mapped onto the architecture: FAC is penetrable, MAC is not — consistent with the separate finding that once *both* items are in working memory people can select either relational or surface matches at will (triads tasks), which SME models by choosing an interpretation and ACME cannot (it emits one compromise). For a builder this is the hardest constraint in the paper: **a surface-driven index cannot be queried for structure**, so a system that wants more relational retrievals must change what is *encoded*, not what is *asked*.

---

## Relational retrieval without indices: expertise is vocabulary uniformity (1995)

Relational access is not uniformly poor. It rises with **expertise** (Novick 1988: experts retrieve structurally similar problems more, and reject surface-similar ones faster) and with **intensive encoding** (Faries & Reiser 1988; comparison of two prior analogs — Gick & Holyoak 1983, Catrambone & Holyoak 1987/89; writing out a proverb's meaning; studying themes before judging). The model's explanation uses no new machinery:

- Experts have a **more uniform internal relational vocabulary** within their domain, because a comprehensive domain theory promotes canonical relational encodings.
- Any higher-order relational predicate that is widely used in a domain is automatically in the content vector of every item encoded with it, so uniformity of encoding *is* uniformity of the index.
- Therefore **content vectors are indices that update automatically with any change in the representation** — and with enough domain structure MAC/FAC's behaviour converges on that of a case-based reasoner with rich indices, *without anyone building indices*.

The converse is the failure route: Bassok's finding that verb interpretation depends on the attached nouns means the relational encoding is idiosyncratically tied to surface content, which is offered here as a *cause* of poor relational access — the same mechanism the wiki records as G23's sharpest measurement ([[wiki/concepts/schema-assimilation.md]], Bassok, Wu & Olseth 1995). New tension: [[wiki/empirical-tensions.md]] T199.

---

## Scaling the content vector's vocabulary (1995)

A psychologically plausible predicate vocabulary is 10⁵–10⁶ functors, against the few hundred used here; sparse encoding is admitted to be an implementation trick that may not survive, and it says nothing about a substrate with limited hardware bandwidth. Two proposed routes, both untested:

| Route | Construction | What it buys / costs |
|---|---|---|
| **Semantic compression** | Take the specialisation lattice over predicates; choose any partition of it; each component of the compressed vector counts occurrences of its predicate *and everything below it in the partition* | Dimension set by the chosen level of abstraction, and the compression is *semantically* principled rather than random. Cost: the partition is a free choice, and two items distinguished only below it become indistinguishable at stage 1 |
| **Factorisation** | Partition predicates into tightly interrelated subsets, one content vector per subset | Fixed bound on any single module's width; requires several modules to be synchronised well enough to accumulate scores |

**(brainstorm)** Both are recognisable in the wiki's vocabulary — the first is a coarse-to-fine hierarchy over the index, the second is a modular store whose per-module dimension is capped ([[wiki/concepts/retrieval-capacity.md]]'s escape routes seen from the symbolic side). The interesting one is compression by lattice partition, because it is the only proposal in the wiki where a retrieval index's dimension is reduced by *taking a quotient of the representation language* rather than by projecting the vector — the abstraction level becomes a tunable, and running several partitions at once would be the symbolic analogue of the multi-resolution allocate/reuse proposal in G38.

---

## Two readouts the architecture gets for free (1995)

- **A pre-retrieval familiarity signal.** The authors conjecture that the MAC stage's output is *not* consciously inspectable as items, but its strength is — "there are possible matches, and roughly how strong", without knowing what they are. That is the feeling-of-knowing, which Metcalfe (1993) shows subjects report *before* they can report a particular retrieval, and which Reder (1988) argues is what decides whether to keep searching. Machine reading: **stage 1's score distribution is a usable control signal even when no item survives stage 2** — a scalar novelty/occupancy readout obtained without a threshold and without item identity, the same kind of signal [[wiki/entities/vector-hash.md]] gets from mean store activity and the closest thing this architecture has to a "nothing applies" report.
- **Iterative access, which is also the missing proposal step.** For active (as opposed to spontaneous) retrieval the proposal is to run MAC/FAC in a loop: partial matches indicate which aspects of the probe are carrying the match, those are up- or down-weighted **in the probe's content vector**, and the next iteration returns different items. This is the cheapest concrete answer in the wiki to G37's "the candidate set is assumed to be given" — the candidate set is regenerated by editing the query, and the edit is computed from the previous round's correspondences. The same loop is offered as a route to *ad hoc* relational categories ("things to take on a picnic"), which would make category formation a by-product of repeated retrieval rather than a separate operation.

---

## What the model does not do, restated in 1995

- **Purely exemplar-based, no inter-item effects.** No competition between memory items, no averaging across retrieved items, no global familiarity from summed activations. Wharton et al. (1994) show competition between exemplars *heightens* the relative effect of structural similarity — an effect ARCS captures and this model cannot, and the clearest thing the two-stage architecture gives up by scoring each item independently. Three extensions are floated (compare MAC's outputs; build a Minsky similarity network from retrieval history; run SME across FAC's outputs to abstract), none run.
- **Goals are not privileged.** Pragmatics enter only through what is encoded in the probe, so goals are ordinary higher-order structure. This is defended: models that index by goal predict that retrieval *requires* a common goal, and people retrieve across differing goal structures.
- The Hamlet probe shows the selector interacting with the data rather than the theory: FAC scores were Romeo & Juliet 6.79, Julius Caesar 5.49, Macbeth 3.72, Othello 2.67 — a 20% drop-off, so the 10% band returns exactly one item because the gap happened to exceed it.


## Limitations, stated at source

- **No absolute threshold anywhere.** Both selectors are *relative* (best + 10%), so the system has no way to say "nothing in memory applies". The authors call an absolute threshold psychologically plausible but omit it because they "have not yet found good constraints on them" — a MAC threshold and an FAC structural-evaluation threshold are both listed as planned. The three routes to a null reminding are therefore: MAC passes nothing (needs the unimplemented threshold), FAC generates no match hypotheses (observed, rare), or a structural-evaluation threshold (not implemented).
- **The 10% band is fitted to an outcome, not derived.** Chosen in pilot studies because it "generally returns a single result"; a hard upper bound of two is floated as an alternative.
- **The memory pool is unmodelled.** The model is explicitly uncommitted about whether the pool is all of long-term memory or a subset produced by spreading activation or indexing, and about the global structure of long-term memory generally.
- **Scale is untested.** 18–36 hand-encoded stories against a human memory set of 32 *plus vast background knowledge*; larger-knowledge-base experiments (CYC, the ILS Story Archive) are listed as in preparation. MAC/FAC's absolute performance is well *above* the human rate, which the authors attribute to the small pool and the absence of a week's decay.
- **Representations are hand-encoded predicate calculus**, and content vectors inherit whatever functor vocabulary the encoder chose — the same G23 exposure every symbolic system here has.
- **No abstraction or index construction.** How access could incrementally build abstractions and indexing to structure long-term memory is posed as an open question, not answered.
- **(1995) Four years on, the threshold is still missing.** The journal version restates that the *only* route to a null reminding in the implemented model is FAC failing to generate any structurally sound match hypothesis — observed, but rare — and again proposes absolute thresholds on both stages without supplying one. The 10% band is now at least *shown* to be non-critical over a range (sensitivity analysis) rather than merely asserted.
- **(1995) The comparison against ARCS is on ARCS's own encodings, not this model's.** The authors could not get ARCS to run on the representations used in their own experiments — networks failing to settle after 1000 iterations, runs of up to 12 hours — so the head-to-head is run entirely on Thagard et al.'s sparser encodings, which the authors themselves judge unnaturally thin in surface information (and blame for the one implausible result: the FOR probe retrieving the base story).

---

## Comparison — the first-stage question, five ways

| Mechanism | What stage 1 computes | Structure-sensitive at access? | Can report "nothing applies"? | Cost per stored item |
|---|---|---|---|---|
| **MAC/FAC** (this page) | functor-count dot product ≈ SME's match-hypothesis count | **No, by design** | No (relative selector only) | one dot product |
| **HRR dot product** (Plate 1993, [[wiki/concepts/vector-symbolic-binding.md]]) | similarity of a convolution-bound code | **Yes** — reproduces `LS > AN^cm > AN > SS > FA` with no alignment search | Not addressed | one dot product |
| **Order embeddings** ([[wiki/entities/neuromatch.md]]) | learned geometric containment `z_q ≼ z_u` | Yes (learned) | No certificate | one coordinate comparison |
| **Responsibility posterior** ([[wiki/concepts/contextual-inference.md]]) | `p(context ∣ cue, feedback, history)` | No internal structure matched | **Yes** — and allocates a new context | one scalar |
| **Attractor relaxation** ([[wiki/entities/vector-hash.md]]) | settling to the nearest stored attractor | No | Weakly — mean store activity separates familiar from novel | none (one settling pass total) |

Plate's result is the sharpest challenge to this page: MAC's structure-blindness is defended as the reason the first stage can be cheap, and an HRR shows a structure-*sensitive* first stage costing exactly the same one dot product ([[wiki/empirical-tensions.md]] T185). What MAC/FAC still has that Plate's scheme does not is the derivation — the score means something about the second stage rather than being an empirically good proxy.

---

## Connections

- **[[wiki/concepts/analogical-mapping.md]]** — supplies the retrieval stage that page presupposes: mapping only ever sees the 1.5 items per probe that survive both selectors, so what analogy can do is bounded by a filter that never looks at relational structure.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the same two-stage skeleton with the first stage rebuilt: a convolution-bound code makes stage 1 structure-sensitive at identical cost, which is a direct attack on this model's central design assumption.
- **[[wiki/concepts/amortized-inference.md]]** — the wiki's only cheap stage that approximates the expensive stage's *internal search-space size* rather than its output, hence derivable analytically and one-sided by construction instead of trained and two-sided.
- **[[wiki/concepts/subgraph-matching.md]]** — the same filter-then-verify structure with the filter learned rather than derived; the transferable suggestion here is to filter on a statistic that *bounds the matcher's own candidate count*, which comes with a soundness argument an embedding does not.
- **[[wiki/concepts/retrieval-capacity.md]]** — the price of compiling a structured item into a fixed vector, paid here in the most extreme form: the content vector keeps only functor counts, so every structural distinction is invisible to the comparator and the second stage exists to restore it.
- **[[wiki/entities/lisa.md]]** — the rival architecture for the same job: LISA also separates retrieval from mapping and runs the retrieval on a non-structural pathway (driver propositions activating shared *semantic* units in long-term memory), but its limit on how much survives to mapping is derived from the synchrony code rather than imposed by a fitted 10% band.
- **[[wiki/entities/neuromatch.md]]** — the modern engineering answer to the same query, with the opposite attitude to error: it treats un-flagged false positives as the defect to remove, where MAC/FAC treats them as the behaviour to reproduce.
- **[[wiki/concepts/contextual-inference.md]]** — the retrieval mechanism that has what this one lacks: a posterior with an absolute scale, so it can decide that *no* stored structure applies and allocate a new one, where MAC/FAC's relative selector always returns something.
- **[[wiki/concepts/schema-assimilation.md]]** — the failure mode this model makes quantitative: what gets assimilated is whatever the surface-driven filter returns, so a schema can be applied on the strength of shared object attributes with no shared relational structure at all.
- **[[wiki/concepts/latent-graph-discovery.md]]** — retrieval is the step that decides which stored graph the current observations are matched against, and this model shows the decision being made on a bag of node-and-edge labels, before any graph structure is consulted.
- **[[wiki/concepts/program-induction.md]]** — the tiered-identicality doctrine is a claim about the representation language: non-identical relations are matched by *canonicalising* them (decomposition, minimal ascension) rather than by a similarity table, which makes the primitive vocabulary the thing that has to be learned right.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the 1995 scaling problem in its terms: a 10⁵–10⁶-functor content vector is a sparse high-dimensional code, and the two proposed fixes (lattice compression, factorisation into per-subset vectors) are the symbolic versions of reducing dimension by quotient and by modularity rather than by projection.
- **[[wiki/entities/mlc.md]]** — the two stages fused into one amortised pass: a single frozen transformer must both locate the study example matching a query (installed as an auxiliary *copy* objective, reported as necessary for optimization) and compose the inferred rules to answer a novel query — so the cheap filter becomes a training signal rather than a separate mechanism, and the price is that no candidate is ever explicitly scored or rejected.
- **[[wiki/entities/sme.md]]** — the engine this model wraps, now held primarily: MAC's content-vector dot product over-estimates *its* step-1 match-hypothesis count, FAC is it in literal-similarity mode, and its 1989 paper already reproduces this model's surface/structure dissociation on one engine by swapping rule sets — with the retrieval search over a pool explicitly named as the missing piece.
