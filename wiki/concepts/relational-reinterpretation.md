# Relational Reinterpretation

**The claimed human-specific operation: take a first-order perceptual relation and re-encode it as an explicit token — a relation *qua* relation, with roles named separately from their fillers — so that relations *between* relations become representable and inferences over them become domain-independent. Everything below that line is demonstrated in nonhuman animals across many taxa; nothing above it has been demonstrated in any.**

The value of the source is not the discontinuity claim. It is that the claim is cashed out as a **decomposition of "symbolic" into eight separately-testable representational properties**, with the comparative evidence read off feature by feature — which turns "does architecture X reason relationally?" from an adjective into a checklist, and supplies a deflationary attack that every relational benchmark in this wiki is vulnerable to.

> **Provenance.** Penn, Holyoak & Povinelli 2008, *Darwin's mistake: Explaining the discontinuity between human and nonhuman minds*, Behavioral and Brain Sciences 31, 109–178 (`raw/penn-2008-darwins-mistake-discontinuity.md`) — target article, 28 open peer commentaries, and the authors' response including a falsification appendix. Every comparative result below is reported **second-hand** through it; the review is adversarial by design (the authors are arguing a negative), so the primaries it deflates are not in `raw/` and the deflations are the authors' readings of other groups' data. Newell's physical symbol system (PSS), van Gelder 1990 on compositionality, Smolensky 1999's Symbolic Approximation hypothesis, Horgan & Tienson 1996, Markman & Stilwell 2001 and Halford et al. 1998a are all cited through it.

---

## The ladder: "symbolic" decomposed into eight properties, four of which nonhumans have

The source's central methodological move. A PSS is treated not as a hypothesis to accept or reject but as a **heuristic decomposition** — and the comparative record then shows the properties are *dissociable*: "at least in biological organisms, the various representational capabilities putatively associated with a PSS are not a package deal as a matter of nomological necessity."

| # | Property | Statement | Nonhuman | Evidence cited |
|---|---|---|---|---|
| P1 | **Discrete, enduring representations** | Internal states about particular states of affairs that outlive the sensory input | **✓** | Honeybee landmark memory used off-line to home (Menzel et al. 2005); scrub-jay what/when/where over tens of thousands of caches |
| P2 | **Atomistic update** | One representation revisable by a single exposure without corrupting similar ones | **✓** | Single-trial cache updating (Clayton et al. 2003); "therefore functionally discrete" (Blackmon et al. 2004) |
| P3 | **Functional compositionality** (van Gelder 1990) | Reliable mechanisms to *produce* a complex representation from constituents and to *decompose* it back — by any means, concatenative or not | **✓** | Novel dyadic social relations composed from per-individual representations; means-ends and predicate-argument tracking |
| P4 | **Implicit syntactic structure** (Horgan & Tienson 1996) | When two relations predicate the same property, the sameness is manifest in the structural similarity of the two representations | **✓** | Same as P3 — and this "rules out most traditional associative and distributed connectionist models as plausible accounts of the *nonhuman* mind" |
| P5 | **Concatenative compositionality** | The compound preserves the *identity* of its constituents rather than sacrificing them to a conjunctive encoding | **✗** | No behaviour requires it; and it is what P6 needs |
| P6 | **Explicit type/token distinction — role-filler independence** | The `loves` relation is represented invariantly to whether John loves Mary or Mary loves John; roles are bound to fillers *dynamically* without either corrupting the other | **✗** | Nonhumans reason from **feature-based** categories, not **role-governed** ones (Markman & Stilwell 2001): "mother", "tool", "kin" as feature sets, never as positions in a schema |
| P7 | **Explicitly tokened structural relations** | The relation is itself an object that can fill a role in another relation; recursion over a hierarchy is therefore available | **✗** | No evidence any animal grasps the relation between `grandmother-of` and `mother-of`, or the analogy between `father-of` and `mother-of` |
| P8 | **Classical inferential systematicity** | `∀R, R transitive: R(a,b) ∧ R(b,c) ⊨ R(a,c)` — holding by structure, independently of domain or learning history | **✗** | See the transitive-inference row below |

**P4 vs P8 is the load-bearing distinction, and it has a name.** Nonhuman systematicity is **featural**: an animal that thinks `dominates(A,B)` will think `dominates(B,A)` for any conspecific of the right age and sex, because the argument slots are constrained only by *observable features of the candidate fillers*. That costs nothing and "is also the kind of systematicity that happens to be easily implemented by many nonclassical connectionist models." Classical systematicity is a different object: it is the claim that certain relations *necessarily imply* other relations by virtue of how the relation is defined, with no domain and no training context attached.

**The consequence for this wiki.** Every architecture here that claims compositionality claims P3/P4, and the tests it passes are P3/P4 tests. [[wiki/concepts/compositionality.md]]'s five Hupkes facets are graded measurements of P3, P4 and productivity; none of them separates P5–P8. The seq2seq systematicity scores of 0.53 / 0.56 / 0.72 ([[wiki/entities/pcfg-set.md]]) are attempts at featural systematicity that partly fail — i.e. the models are being scored *below* the animal line, on a property the source says every taxon has.

---

## The deflation: chunking and segmentation

The instrument. Any task that *looks* like it requires reasoning about a relation between relations can usually be solved by two cheap operations in sequence:

1. **Chunking** (Halford et al. 1998a) — collapse a relation into a single analog scalar. "Chunking reduces the complexity of processing a relation at the cost of losing the original structure and components of the relation itself, but suffices when the task does not require the structure of the relation itself to be taken into account."
2. **Segmentation** — apply an ordinary conditional discrimination to that scalar, and to the next one, sequentially, never holding two structures open at once.

Formally, the deflated solver for a putative higher-order task is `response = f(c(R₁), c(R₂))` where `c` is a scalar summary and `f` a learned conditional discrimination — as against the structural solver, which requires the *constituents* of `R₁` and `R₂` to remain addressable while the higher-order relation is evaluated.

| Task | Apparent claim | Deflation | The measurement that betrays it |
|---|---|---|---|
| **Same/different, relational match-to-sample** | Abstract sameness as a concept | `c` = perceptual variability (informational entropy, Shannon & Weaver 1949) of the display; then `if low variability, choose low-variability array` | **Set size runs the wrong way.** Pigeons and baboons find 16-item S/D *easier* than 2-item (Young & Wasserman 1997; Wasserman et al. 2001). Fagot et al. 2001: baboons and humans both pass a 16-icon RMTS; drop the sample to 2 icons and human performance is unaffected while baboons **fall to chance on `different` trials only** — exactly the asymmetry an entropy estimator predicts, since `same` stays at zero entropy and `different` drops to a small value hard to separate from zero |
| **Same/different transfer across domains** | One concept of sameness, freely generalised | Each discrimination is bound to its own source of stimulus control (entropy, oddity, edibility) | Baboons that had passed a perceptual S/D task and had a food/non-food categorisation needed **14,576 additional trials** on average to reach 80% on a "conceptual" S/D task (Bovet & Vauclair 2001) |
| **Analogy** (Sarah, Gillan et al. 1981) | Relations between relations | `c` = *number* of within-pair featural changes | Oden et al. 2001: Sarah treats colour+shape change as equivalent to size+fill change — two changes either way. The *kind* of relation is invisible; only its cardinality is read |
| **Rule learning** (`ga ti ga`, Hauser et al. 2002b tamarins) | Algebraic rules over variables | **Repeating** dependencies (an element predicts the *same* element later) carry a higher-order perceptual regularity; **non-repeating** ones do not, and are dissociable in humans (Tunney & Altmann 2001). Equivalently: pattern-based vs category-based rules (Gomez & Gerken 2000) | Only the repeating/pattern-based case was ever demonstrated. `noun-verb-noun` is the other kind and has never been shown in any animal |
| **Higher-order spatial relations** (scale model → room) | Map-to-world analogy | Learned association between a miniature and its full-sized twin | 6/7 chimpanzees succeed with object cues; **2/7** when position alone carries the answer — and the four hiding sites were *constant across every experiment*, so even those two may hold four learned location pairs (Kuhlmeier & Boysen 2001, 2002) |
| **Transitive inference** | `A>B, B>C ⊨ A>C` | An ordered analog representation of one's own choices, read egocentrically | Choice transitivity emerges from differential reinforcement without any transitive relation among the stimuli (Halford et al. 1998b; De Lillo et al. 2001; Wynne 1995). Crows need ordered post-choice feedback (Lazareva et al. 2004) — but pigeons pass the *same* protocol with constant feedback (Lazareva & Wasserman 2006), so the transitive perceptual cue is not computationally necessary either. In the wild, fish and jays predict **their own** relation to a rival (Grosenick et al. 2007; Paz et al. 2004) and are never tested on third-party dyads or omni-directional queries |
| **Hierarchical social structure** (baboon matrilines) | Rank nested under kinship | Between-family rank reversals are simply more disruptive, hence more salient | The authors' own control cuts against them: response strength was **unrelated to rank distance**. An integrated hierarchy predicts more surprise at a 1-vs-9 reversal than a 4-vs-5 reversal (Bergman et al. 2003) |
| **Causal understanding** (trap-tube) | Unobservable forces, gravity, support | Task-specific, body-specific contingency learning | 1/4 capuchins after ~90 trials — and that one kept avoiding the hole after it was rotated to be **causally irrelevant** (Visalberghi & Limongelli 1994). 3/7 chimpanzees as adults, **none** distinguishing trap-up from trap-down (Povinelli 2000). 3/10 apes at a mean of 44 trials, still failing the push-only version (Mulcahy & Call 2006). 7/8 rooks learn and **1/7** transfers when the visual cue is removed; zero in the replication (Seed et al. 2006; Tebbich et al. 2007). Children ≥3 years solve it in a few trials |
| **Theory of mind** (cache protection) | Attributing epistemic states | Rules over observables: *re-cache if a competitor oriented toward it*; *cache far from competitors* | Dally et al. 2006's own authors concede the behavioural-cue account suffices; so do Bugnyar & Heinrich 2006 |

**The general shape.** In every row the deflated solver reproduces the positive result *and* predicts the specific failure that was found — set-size asymmetry, transfer cost in the thousands of trials, cardinality-not-kind, cue removal, rotation of an irrelevant feature. That is what makes it an instrument rather than a sceptical stance: **the chunk hypothesis is falsifiable and keeps being confirmed.**

---

## Two things this decides for a machine

### 1. A portable falsification test the wiki does not have: the set-size sweep `(brainstorm)`

The sharpest datum above is Fagot et al. 2001, and it generalises directly. A chunk-based solver's scalar summary gets *more* reliable as the number of elements over which the relation is computed grows; a structure-based solver is flat or degrades (more constituents to keep addressable). So:

> Hold the relation fixed and sweep the number of elements it is computed over. Report accuracy against set size, **split by relation polarity**. A rising curve, or an asymmetry between the polarity that maps to zero on the scalar and the polarity that does not, is positive evidence for a chunk.

It needs no held-out concepts, no human baseline, no ontology, and no distribution shift — the three things every instrument in [[wiki/concepts/certification-instruments.md]] pays for. It is recorded there as `I25`. Nothing in the wiki runs it: RAVEN and PGM fix the matrix at 3×3, ARC varies grid size but not the arity of the relation, and Hupkes et al.'s length sweep varies *expression* length rather than the size of the set a single relation ranges over.

### 2. Where the wiki's binding machinery sits on the ladder

| Architecture | Highest property clearly held | Why it stops there |
|---|---|---|
| Distributed / PDP, seq2seq ([[wiki/entities/pcfg-set.md]]) | P4, partially | Featural systematicity measured at 0.53–0.72 |
| HRR / VSA ([[wiki/concepts/vector-symbolic-binding.md]]) | **P3/P4, not P5** | `a ⊛ b` is *unlike both* `a` and `b` by design; which roles an object fills "is not a surface feature — it is recoverable only by unbinding, i.e. by computation, not by comparison". That is van Gelder's functional compositionality exactly, and it is the property the source assigns to honeybees |
| Contextualized HRR | P5 for *pre-computed* structural properties only | Role co-occurrence is folded into the code at encoding time; the independence is spent, not held |
| Sparse-binary code-vectors ([[wiki/concepts/analogical-mapping.md]]) | P5–P6, with re-representation | Roles are unioned in rather than multiplied through, so `⟨R_a, A⟩` keeps both parts readable — and the `lower ∨ upper` re-representation is precisely the type/token separation P6 asks for |
| **LISA** ([[wiki/entities/lisa.md]]) | **P6–P7, at 2–3 propositions** | Synchrony is the mechanism that keeps a role and its filler *simultaneously and independently active* while bound — which is what the source means by grafting concatenative compositionality onto a conjunctive substrate |

**This is the wiki's answer to a question it has been asking without a criterion.** [[wiki/concepts/language-of-thought.md]] records T8 as undecidable because "neither side has a criterion separating productive composition from associative combination." P5–P8 *are* that criterion, stated behaviourally and with protocols attached. What they say about the wiki's own inventory is unflattering: the wiki's most-used structural code (VSA) is at the animal level on this decomposition, and the one architecture above the line is the one that "does not scale to large analogs."

---

## The evolutionary argument, and what it says about model design

The source's positive proposal is a **graft**, not a replacement: a modular system approximating a language of thought "has evolved *on top of* and reinterprets the output of the proto-symbolic systems we still share with other animals." Three consequences it draws that are architecture claims:

- **Against a modular explanation.** The same profile — first-order relations present, higher-order relations absent — appears in same/different, space, transitivity, hierarchy, tools and mindreading. Independent per-domain adaptations would not produce one profile; a shared **supermodule** would. It is claimed **necessary but not sufficient** for each human-unique capability, not identical with any of them.
- **Against language-only.** An agrammatic aphasic with no vocabulary for mental states managed his family's finances and passed causal-reasoning and theory-of-mind batteries (Varley & Siegal 2000); frontal-variant frontotemporal dementia selectively destroys higher-order visuospatial integration (Waltz et al. 1999) and theory-of-mind performance (Gregory et al. 2002) with language largely intact. The **double dissociation** localises higher-order relational reasoning outside narrow syntax — which is the wiki's sharpest evidence against reading [[wiki/concepts/discrete-infinity.md]]'s single recursive operator as the whole story ([[wiki/empirical-tensions.md]] T289). And decades of ape language training bought symbol-object association and word-order sensitivity while buying *no* improvement on causal, mentalistic or analogical tasks: "you cannot create a human mind simply by taking a nonhuman one and teaching it to use language-like symbols."
- **The local-minimum argument, and it is the one a builder should carry.** From LISA's construction the authors read off an evolutionary claim: approximating P5–P8 in a neural substrate is *hard*, whereas approximating P1–P4 is easy — "there is no simple next step that will transform a clever PDP model into a full-fledged PSS complete with dynamic role-filler binding." So nonhuman architectures sit in **local minima** of the space of biological neural systems, and one lineage paid the cost of leaving. Transposed: the wiki's scaling results are evidence *for* this, not against it — P1–P4 is what gradient descent on a prediction objective reliably finds, and no amount of it produces P6.

---

## The falsification protocols

The response appendix specifies experiments per domain. Two are directly reusable as machine benchmarks because they are stated as **quantitative predictions about relational complexity** rather than as pass/fail:

| Protocol | Prediction |
|---|---|
| **Raven-style matrices adapted for nonhumans** | Zero-relation problems: solvable by many species, "even non-enculturated pigeons." One-relation problems: some species. **Two or more relations: no nonhuman animal** (following Waltz et al. 1999) |
| **First-trial generalisation on a transitive series** | Train a novel stimulus `X` against a feedback cue of a given magnitude; a logically-underpinned reasoner chooses correctly between `X` and any of `A`–`E` **on the first trial**. Never demonstrated |

The first is the more useful export: it makes *number of relations that must be integrated simultaneously* the independent variable, which is the same load variable LISA derives from its phase capacity and the same one [[wiki/entities/raven.md]]'s concept-variation failures point at without measuring. **No wiki benchmark reports a per-item count of relations that must be jointly bound**, so no wiki system has a position on this axis.

---

## Open problems

- **The negative claim is unfalsifiable in the direction it is asserted.** Every row of the deflation table is "the positive result does not require the structural mechanism", which is an argument about sufficiency and never about what the animal does. The response concedes the point by supplying an appendix of experiments — none of which had been run.
- **The deflation applies to humans too, and the source does not run it.** Humans also show entropy sensitivity on S/D tasks (Castro et al. 2007; Young & Wasserman 2001). The claim of a "qualitatively distinct system" for humans rests on a *categorical* boundary between zero and non-zero variability, which is a difference in the response function, not a demonstration that the structural mechanism is what produces it.
- **P5 is asserted to be necessary for P6 and never shown to be.** "Maintaining role-filler independence while dynamically binding roles and fillers seems to require the kind of concatenative compositionality posited by the PSS hypothesis" — a hedge, cited to Hummel & Holyoak. If a compressed conjunctive code with a scheduled unbinding operator suffices, the entire architectural conclusion moves ([[wiki/empirical-tensions.md]] T293).
- **No model of the nonhuman level exists.** The source's own "most glaring weakness": nobody has built a computationally feasible, behaviourally accurate model of the P1–P4 system that the graft is supposed to sit on. The wiki's position is the mirror image — it is full of P1–P4 systems and has one partial P6 system.
- **The supermodule's interface is unspecified.** How one relational system takes inputs from "a motley collection of perceptual and conceptual modules" is conceded as unsolved — which is `G21` arriving from the comparative side, with the additional constraint that the composer must reinterpret rather than merely concatenate its inputs.

---

## Connections

- **[[wiki/entities/lisa.md]]** — the existence proof this page's hypothesis rests on, and the source of its evolutionary argument: synchrony grafts role-filler independence onto a conjunctive long-term store, and the fact that this is *hard* to do in a network is read as why only one lineage did it.
- **[[wiki/concepts/compositionality.md]]** — supplies the distinction that page's five facets do not draw: functional compositionality (produce and decompose by any means) is universal across taxa, while concatenative compositionality (constituent identity preserved in the compound) is the human-specific claim, so a model can pass every facet test and still be on the animal side.
- **[[wiki/concepts/vector-symbolic-binding.md]]** — where this page's checklist lands hardest: circular convolution is functionally compositional and deliberately *not* concatenative (`a ⊛ b` is unlike both parts), which places the wiki's principal structural code at P3/P4 unless something schedules the unbinding.
- **[[wiki/concepts/analogical-mapping.md]]** — the operation the discontinuity is defined by: analogy *sensu stricto* requires asymmetric role-governed relations and cannot be reduced by chunking, which is why the source treats relational match-to-sample as a non-precursor rather than a cognitive primitive for it.
- **[[wiki/concepts/language-of-thought.md]]** — supplies the missing criterion behind T8's undecidability: P5–P8 separate productive composition from associative combination behaviourally, and the source's own position ("every species gets the syntax it deserves") makes the language of thought graded rather than present/absent.
- **[[wiki/concepts/shortcut-learning.md]]** — the same phenomenon named from the comparative side: chunking-and-segmentation is a shortcut that is *representationally* rather than statistically characterised, so it predicts which perturbation will break the solver rather than only that one will.
- **[[wiki/concepts/certification-instruments.md]]** — home of `I25`, the set-size sweep this page derives from the baboon/human RMTS asymmetry: the cheapest chunk-detector available, and unrun anywhere in the wiki.
- **[[wiki/concepts/causal-model-building.md]]** — the source's sharpest domain distinction: causes that are *temporarily hidden* are learnable by many animals, causes that are *in principle unobservable* (gravity, support, mental states) are not, which splits a construct the wiki treats as one thing.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the `g`/`x` split restated as a comparative claim: an animal has content codes and implicit structure, and what it lacks is a `g` that can be *tokened and reasoned about* rather than merely occupied.
- **[[wiki/concepts/discrete-infinity.md]]** — the rival narrow hypothesis, and the evidence against it: a double dissociation (agrammatic aphasics reasoning normally about causes and minds; frontal degeneration destroying relational integration with language intact) places higher-order relational reasoning outside narrow syntax.
- **[[wiki/concepts/shared-intentionality.md]]** — the same negative comparative record read for a different missing operator; the two are compatible and differ in what they call primitive — a relational supermodule that theory of mind is one consumer of, versus a social operation that relational reasoning is downstream of.
- **[[wiki/entities/raven.md]]** — the benchmark the falsification appendix adapts, and the axis it adds: number of relations that must be jointly integrated (0 / 1 / 2+), which is the load variable the concept-variation failures point at and no wiki benchmark reports.
- **[[wiki/concepts/working-memory.md]]** — where the ladder becomes a capacity claim: the properties above the line all require several constituents to stay simultaneously addressable, so P6–P8 are bounded by however many bindings can be held apart at once.
- **[[wiki/concepts/human-baseline.md]]** — the comparative version of the same measurement problem: a species baseline, like a human baseline, is only interpretable once the cheapest solver for the protocol has been written down.
- **[[wiki/concepts/emergent-modularity.md]]** — the supermodule claim in that page's vocabulary: one shared relational competence called by many functional modules, argued for from the fact that the same first-order/higher-order profile recurs in every domain rather than from any anatomy.
- **[[wiki/concepts/motivation-representation-synergy.md]]** — the standing rival reading of every comparative null on this page: a chunk-based deflation and an undeployed competence predict the same data, and only the second predicts a frame in which the behaviour appears (T291, T292).
