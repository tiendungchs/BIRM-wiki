# Abstraction

**One word, eight operationalisations, in four families that answer different questions: what a *code* does under substitution of content, how far a *rule* sits from an action, what a *holder* can do with it, and how one is *obtained*. Four of the eight form a strict implication chain that the wiki has been reading as a single property — and every requirement the wiki places on `g` sits at the top of that chain while every biological measurement it cites sits two rungs down.**

> **Provenance.** Assembled from material already in the wiki rather than from a new ingest — the pattern of [[wiki/concepts/program-induction.md]]. The definitional passages are quoted from sources ingested for their *results*, with their definitions left unrecorded: `raw/courellis-2024-abstract-representations-hippocampus.md`, `raw/bernardi-2020-geometry-of-abstraction.md`, `raw/badre-2010-frontal-abstract-action-rules.md`, `raw/odouard-2022-conceptual-abstraction-benchmarks.md`, `raw/dicarlo-2012-brain-visual-object-recognition.md`, `raw/chollet-2019-measure-of-intelligence.md`, `raw/lecun-2022-autonomous-machine-intelligence.md`.

---

## The census

| # | Sense | Statement | Quantified over | Held in |
|---|---|---|---|---|
| **F1** | **Content-invariance** | A code represents position in a relational structure and does not change when the objects filling the structure change — the wiki's `g` against its `x` | A code, under substitution of content | [[wiki/concepts/abstract-structural-codes.md]] |
| **F2** | **Disentangled geometry** | Two variables lie along orthogonal directions, so activity projected along one is invariant to the value of the other | A population geometry | [[wiki/concepts/population-geometry.md]] |
| **F3** | **Cross-Condition Generalization Performance (CCGP)** | "A representation of a particular variable is abstract if a linear decoder trained to report the value of that variable can generalize to new conditions" (Courellis et al. 2024, stated as *the defining characteristic*) | A decoder's transfer across held-out values of the *other* variables | [[wiki/concepts/population-geometry.md]] |
| **F4** | **Untangling** | Manifolds that arrive curved and interleaved are made linearly separable for one classification | One read-out | `raw/dicarlo-2012-brain-visual-object-recognition.md`; used implicitly by every probing result |
| **O1** | **Policy order** | "A rule can be defined as abstract to the extent that it determines a set of simpler rules based on contextual information" (Badre et al. 2010) — abstract means *selects among rules*, not among actions | A rule's distance from an action | [[wiki/concepts/policy-abstraction-hierarchy.md]] |
| **O2** | **Temporal / state abstraction** | The reinforcement-learning pair: temporal abstraction reduces the dimensionality of *action sequences* (options); state abstraction hides state not critical to the reward | An action space / a state space | [[wiki/concepts/temporal-abstraction-options.md]] |
| **U1** | **Generative competence** | A concept is "a competence or disposition for generating infinite conceptualizations of a category" (Barsalou, via Odouard & Mitchell 2022); understanding a concept means using it across varied instantiations | Behaviour over an unbounded instantiation set | [[wiki/entities/conceptarc.md]], [[wiki/concepts/rule-level-evaluation.md]] |
| **P1** | **Long-range predictability** | "A representation is abstract because it is what stays predictable at long range" — abstraction level *is* prediction horizon | A training objective | [[wiki/concepts/abstract-structural-codes.md]] §Abstraction as long-range predictability |

Two further definitions are *processes* rather than properties and are treated separately below: Courellis et al.'s **compression** definition, and elicitability as a **negative proxy**.

---

## Family F — the format family is a ladder, and the wiki climbs it silently

The four format senses are not four views of one property. They are nested, each arrow one-way:

```
F1 content-invariance  ⟹  F2 disentangled  ⟹  F3 CCGP  ⟹  F4 untangled (linearly decodable)
```

| Arrow | Why it holds | Why it does not reverse |
|---|---|---|
| F1 ⟹ F2 | If the code does not vary with content at all, the content direction is degenerate and trivially orthogonal | A code can put two variables on orthogonal axes while both are fully present — nothing is discarded |
| F2 ⟹ F3 | Parallel coding vectors across values of the other variables are exactly what makes a decoder transfer; parallelism score is described in [[wiki/concepts/population-geometry.md]] as "the geometric reason CCGP succeeds" | CCGP can be passed by geometries that are not globally factorised — Bernardi et al. 2020 measure abstraction and high shattering dimensionality *co-existing*, against an explicit cuboid null |
| F3 ⟹ F4 | Generalising to held-out conditions entails separating the classes in the conditions used to train | **Measured, and the gap is large.** Bernardi et al.: cross-validated decoding succeeds for most of the 35 dichotomies in all three areas, while only context, value and action clear CCGP. "Decodability is nearly free; abstract format is not" |

**Two consequences the wiki has been carrying without stating.**

- **The `g` requirements sit at the top rung and nothing measured reaches it.** [[wiki/concepts/abstract-structural-codes.md]] states four requirements — content-invariance, relational content, path-consistency, decomposability — of which the first is F1. Courellis et al. 2024 dismiss F1 as a description of biology in one sentence: *"this kind of invariance is rarely observed in the brain."* Every population result the wiki cites as evidence for abstract codes is an F3 result. So the wiki's target and the wiki's evidence are two rungs apart, and no page says so.
- **"Untangled" and "disentangled" are not the same thing, and the source that supplies the wiki's instruments says so explicitly.** Bernardi et al.: *"untangled representations are not the same as disentangled representations"* — untangling typically requires either raising dimensionality by projection or lowering it by feature extraction, which is a statement about *one* read-out and carries no commitment about the nuisance variables' geometry. Every probing result in the wiki is F4 evidence being read as F1–F3 evidence.

---

## The disjunct the wiki dropped

Courellis et al.'s process definition, quoted in full because the second half is the part the wiki has never carried:

> **Abstraction is a process through which relevant shared structure in the environment is compressed and summarized, while superfluous details are discarded *or represented so that they do not interfere with the relevant ones*.**

Two admissible solutions, not one:

| Solution | Mechanism | Format rung reached |
|---|---|---|
| **Deletion** | The detail is not represented | F1 |
| **Quarantine** | The detail is represented, on directions the relevant read-out does not read | F2/F3 — and this is the one observed |

This is a live problem for three things the wiki already holds:

- **The capacity argument may require the disjunct the brain does not use.** [[wiki/entities/vector-hash.md]]'s exponential-capacity result turns on `g` being a *frozen, content-free* address; content-shuffled scaffold states with learned weights lose the exponential scaling. If biology quarantines rather than deletes, then either the capacity argument tolerates quarantine (untested — the wiki has no such measurement) or the observed codes are not the addresses the argument is about.
- **G30's objective slot has two targets, and they want different losses.** A loss that punishes content information in `g` targets deletion. A loss that punishes *interference* — content information in the read-out's potent subspace — targets quarantine, and is the weaker and more achievable of the two. [[wiki/concepts/output-null-subspace.md]] already supplies the geometry for stating the second precisely; nothing in the wiki does so.
- **Every certification the wiki has is a quarantine certificate.** CCGP passes under quarantine. So an instrument reported as certifying an abstract code is certifying the weak disjunct, which is a specific entry for gap `G17`'s ledger rather than a general complaint about probing.

---

## Family O — order, and the axis nobody crosses

O1 is ordinal and says nothing about format: *how many levels of rule sit between the code and an action*. A first-order rule can be held in a maximally content-invariant format; a fourth-order rule can be held in a code drenched in content. The two families are orthogonal, and the wiki has never measured a system on both.

| | F-low (decodable only) | F-high (CCGP or better) |
|---|---|---|
| **O1-low** (rule selects actions) | Standard supervised classifiers; every probing result reported without a cross-condition control | Bernardi et al.'s *value* and *action* variables |
| **O1-high** (rule selects rules) | **Empty in the wiki** — and this is the interesting cell: a hierarchical controller whose upper level is content-contaminated would look abstract behaviourally and fail every transfer test | **Empty in the wiki** — Badre et al. 2010 measures order without population geometry; Bernardi et al. and Courellis et al. measure geometry on flat, first-order tasks |

O2 is the machine-side restatement of the same family, split by *what* is being coarse-grained: options coarse-grain time ([[wiki/concepts/temporal-abstraction-options.md]]), state abstraction coarse-grains the state space and is, in Bernardi et al.'s own reading, what a neural function approximator does by default. Both are dimensionality claims, which is why [[wiki/concepts/broadcast-hierarchy.md]] can state abstraction as *anatomical* dimensionality reduction without contradicting either.

---

## Family U — use, and the only sense that survives a closed system

U1 is the only definition on this page that can be applied to a system whose internals are unavailable, and the only one that a lookup table cannot satisfy *provided the instantiation set is unbounded*. Its instruments, in increasing sharpness:

| Instrument | What it asks | Cost |
|---|---|---|
| Cross-domain transfer | Does the behaviour survive a distribution shift? | Confounded by whatever else the shift changed |
| **Concept-based evaluation** ([[wiki/entities/conceptarc.md]], Odouard & Mitchell 2022) | Does the behaviour survive across many instantiations of *one* concept, holding the concept fixed and varying everything else? | Abandons both i.i.d. *and* independence; the item set must be authored per concept |
| **[[wiki/concepts/rule-level-evaluation.md]]** | Is the rule the solver *states* the abstraction the task was authored around? | Every classification is manual — one rater plus consensus review, and the authors know of no algorithmic classifier |

**The identity nobody has written down.** Barsalou's criterion — a *finite* competence generating an *unbounded* set of conceptualizations — is [[wiki/concepts/intelligence-density.md]]'s criterion in words: `C(S)` fixed while `log₂N(S)` diverges, the distinction Choi 2026 calls **knowing versus memorizing**. The behavioural family and the wiki's one system-only formal measure are the same claim in two vocabularies, and neither page cites the other. Chollet's **extreme generalization** — "entirely new tasks that only share abstract commonalities with previously encountered situations" — is the same criterion again, scored rather than asserted ([[wiki/concepts/skill-acquisition-efficiency.md]]).

---

## Family P, and the negative proxy

- **P1 is the only sense stated as an objective**, and therefore the only one that is a candidate for G30 rather than a test applied afterwards. Its measured knob is mm-TEM's write interval `m_b`: longer horizon, coarser emergent code. Its limit is stated on the page that holds it — it rewards content-invariance but not path-consistency, so it can fill at most part of the slot.
- **Elicitability is an inverse proxy and belongs to none of the families.** [[wiki/concepts/perturbation-elicitability.md]]: the probability that a focal electrical edit changes reportable content falls from ~67% in unimodal cortex to 0% at the frontal pole. Read as an abstraction measure it says *abstract = unsteerable by a local edit*, which is a property of the code's spatial and dimensional layout rather than of what it represents. It requires causal access, returns a **rate over a region** rather than a verdict on a variable, and is the only sense here that predicts a *cost* — the same distribution that buys robustness forbids editing.

---

## What this page proposes the wiki commit to

**(brainstorm)** Not a single definition — the families answer different questions and collapsing them is what produced the confusion. Three rules instead:

1. **A format claim names its rung.** Write `abstract (F3)` or `abstract (F1)`, never `abstract`. The four are not interchangeable and the measured gap between F3 and F4 is the largest effect in Bernardi et al. 2020.
2. **A `g`/`x` claim names its disjunct.** Deletion and quarantine are different architectural requirements with different losses and different capacity consequences.
3. **A behavioural claim names the instantiation set and whether it is bounded.** U1 is only a non-trivial criterion when the set is unbounded; on a fixed benchmark it degenerates into F4-with-extra-steps.

And the one substantive position: the wiki's requirements on `g` should be restated as the **top rung of a ladder** with a note that no measurement it cites reaches it — rather than as a list of things a code must have, which is how [[wiki/concepts/abstract-structural-codes.md]] currently reads.

---

## Open problems

- **Format and order have never been measured on one system.** The O1-high row of the 2×2 above is empty in both cells. A hierarchical controller scored for CCGP at each policy order is a cheap experiment and nothing in the wiki has run it.
- **The disjunct is unresolved for capacity.** Does [[wiki/entities/vector-hash.md]]'s exponential scaling survive a `g` that quarantines content instead of deleting it? The shuffled-scaffold control answers a different question (learned vs. frozen), not this one.
- **No scalable instrument for family U.** Rule classification is manual by the admission of the only source that does it, which caps the sharpest behavioural instrument in the wiki at benchmark scale.
- **P1 and F1–F3 have never been evaluated together.** No model in the wiki is reported with both a prediction-horizon setting and a CCGP score, so "abstraction level = prediction horizon" is untested against the format ladder it claims to produce.
- **No sense here is defined for a *relation* rather than a variable.** Every format instrument scores a variable's code; [[wiki/concepts/analogical-mapping.md]]'s role-based requirement is about the format of an *edge*, and there is no CCGP for edges.

---

## Connections

- **[[wiki/concepts/abstract-structural-codes.md]]** — the page that holds sense F1 and states it as a requirement; this page's contribution is that F1 is the strongest rung of a four-rung ladder, that Courellis et al. call it rare in biology, and that the "discarded *or* quarantined" disjunct gives the requirement an admissible weaker form the wiki does not carry.
- **[[wiki/concepts/population-geometry.md]]** — where senses F2 and F3 live as instruments; the measured F3⟹F4 gap ("decodability is nearly free; abstract format is not") is the empirical content of this page's claim that the ladder's rungs are not interchangeable.
- **[[wiki/concepts/policy-abstraction-hierarchy.md]]** — sense O1, and the demonstration that it is orthogonal to the format family: Badre et al. 2010 vary rule order with no population-geometry measurement, so the wiki knows how abstraction-as-order behaves and how abstraction-as-format behaves and never both at once.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — sense O2 on the time axis, and the machine restatement of the same coarse-graining move; the RL taxonomy that pairs it with state abstraction comes from the same source that supplies the wiki's format instruments.
- **[[wiki/concepts/rule-level-evaluation.md]]** — the sharpest instrument for sense U1, and the one that shows why the families cannot be substituted: a grid score is an F4-grade signal, a stated rule is a U1-grade signal, and they disagree in opposite directions in the two modalities.
- **[[wiki/entities/conceptarc.md]]** — where Barsalou's generative definition entered the wiki and stopped; the benchmark operationalises U1 by holding a concept fixed and varying its instantiations, which is the only design here that tests a competence rather than a code.
- **[[wiki/concepts/intelligence-density.md]]** — the formal twin of U1: "a competence for generating infinite conceptualizations" and "`C` fixed while `log₂N` diverges" are the same criterion, so the behavioural family already has a formalism and was not using it.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — U1 turned into a score: extreme generalization is defined as handling tasks that share only *abstract* commonalities with what was seen, which makes the generalization spectrum an abstraction ladder read from behaviour.
- **[[wiki/concepts/perturbation-elicitability.md]]** — the negative proxy: abstraction as what a focal edit cannot move, the only sense here obtained causally and the only one that prices the property rather than certifying it.
- **[[wiki/concepts/reasoning.md]]** — the companion census: reasoning's definitions are about an *operation* over a representation, abstraction's are about the representation's *format, order and use*, and the two meet at the framing stage that every reasoning definition presupposes.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the core framing's dependence on this page: `g` is defined there as position in the meta-graph, which is sense F1, so the ladder above is a ladder of how much of that framing any measurement actually certifies.
- **[[wiki/concepts/shortcut-learning.md]]** — the reason the ladder matters rather than being pedantry: a shortcut is a rule reading `x` where the intended rule reads `g`, and an F4-grade certificate is exactly the evidence a shortcut can produce.
- **[[wiki/concepts/problem-framing.md]]** — the upstream question this page does not answer: every sense above scores an abstraction *over a given variable set*, and none of them can say that the variable set is the wrong one.
- **[[wiki/concepts/broadcast-hierarchy.md]]** — abstraction stated as anatomical dimensionality reduction, which is family O implemented in wiring rather than in rule order, and the one place in the wiki where the level structure is a property of endpoints instead of a property of a code.
- **[[wiki/concepts/output-null-subspace.md]]** — the geometry that makes the quarantine disjunct precise: "represented so as not to interfere" means confined to the read-out's null space, which is a statable loss and a measurable quantity rather than a verbal hedge.
- **[[wiki/concepts/controlled-semantic-cognition.md]]** — a further operationalisation from the clinical side, orthogonal to the census's four families: a concept is abstract to the degree its retrieval is invariant to stimulus modality, response modality and knowledge type, which is what turns semantic dementia's cross-task item consistency into a measurement of abstraction rather than of severity.
- **[[wiki/entities/lateral-frontal-pole.md]]** — family O2 with a measured parameter attached: abstraction as dimensionality reduction, but explicitly **multi-headed**, and the plurality is the load-bearing part — a network's representational similarity to the region falls monotonically as its four decomposition filters are reduced toward one, so a single learned summary statistic is not what the reference system does.
- **[[wiki/entities/vector-hash.md]]** — the capacity argument that depends on which disjunct of the census is right: its exponential scaling assumes a content-*free* address (deletion), and whether it survives an address that merely quarantines content on non-interfering directions — the form actually observed — is untested by the shuffled-scaffold control.
- **[[wiki/concepts/structural-learning.md]]** — T93 position B in its purest form, with the cost measured: the learned structure predicts nothing about the new task's parameter and cannot produce the movement, it only shrinks the search to one dimension — and a family specified one level too loosely makes feed-forward learning *slower than no abstraction at all* (Braun et al. 2009).
- **[[wiki/concepts/learned-industriousness.md]]** — a measured effect of an explicit category label on a *scalar* rather than on a policy or a representation: with reinforcement history held identical, children taught the broad self-attribution "when I try hard I do well in all my school work" transferred a conditioned effort value further than children taught the narrow "…at remembering pictures". The label is functioning as the index of the learned quantity's support set, which is a read-out of abstraction level that no page here has.
