# Digit Matrices and the GPT-3 analogy battery (Webb, Holyoak & Lu 2023)

**Four analogy task families scored on one language model and on human samples: a text-only Raven's isomorph (Digit Matrices), a new letter-string set, four published four-term verbal sets, and Gentner's causal story sets, plus a qualitative replay of Gick & Holyoak's radiation problem. GPT-3 (`text-davinci-003`) matches or beats undergraduates on the first three and loses on the fourth. Its item-level error profile correlates with the human one (`r = 0.39`, `r = 0.70`).**

> **Provenance.** Webb, T., Holyoak, K. J. & Lu, H. (2023), *Emergent analogical reasoning in large language models*, Nature Human Behaviour 7:1526–1541 (`raw/webb-2023-emergent-analogical-reasoning-large-language-models.md`, arXiv 2212.09196v3). All figures dropped in the clip. Every number below comes from the text's statistics. Bar heights (accuracy per condition) are **not** recoverable, and neither is Figure 4 (human Digit Matrices vs visual SPM). Problem sets and human data: `github.com/taylorwwebb/emergent_analogies_LLM`.

Why the wiki holds this page. It is the **primary** for `T212`'s Position A, which the wiki carried second-hand and partly wrong (see Limitations). It also supplies the wiki's only Raven-format task with the parse supplied **by construction**. That is the oracle-parse condition `T215` and [[wiki/concepts/perception-reasoning-dissociation.md]] list as unrun, here on Raven's rule structure rather than on ARC.

---

## Format

| Task family | Construction | Answer | Human sample | GPT-3 protocol |
|---|---|---|---|---|
| **Digit Matrices** | 3×3 matrix of bracketed digit cells, rule structure of Raven's SPM (Matzen et al. 2010). Transformation rules: constant, distribution-of-3, progression (±1/±2), 1–5 rules per problem, each rule bound to one within-cell position. Logic rules: OR / AND / XOR over digit sets, one per problem, elements **spatially aligned** or **permuted**. 32 subtypes in experiment 1 (42 in experiment 2), 7 procedurally generated distractors per item | Generate, then choose from 8 | `N = 40` (exp. 1, 3 of 43 excluded as random responders); `N = 47` (exp. 2) | No prompt, no example. Matrix as text up to an open bracket, truncated at the closing bracket. Multiple choice = highest **mean token log-probability** of each candidate. 40 instances × 32 subtypes |
| **Letter-string analogies** | `[a b c d] [a b c e] / [i j k l] [ ? ]`. 6 transformations (extend, successor, predecessor, remove redundant, fix sequence, sort) × 0–3 **generalizations** (letters→numbers, grouping, longer target, reversed, interleaved `x`, interval 2). Plus a letters→real-world-concepts set (`cold cool warm hot`, `penny nickel dime quarter`, …) | Generate | `N = 57`, 28 problems each | Prompt `"Let's try to complete the pattern:"`. Also run with no prompt and in sentence form |
| **Four-term verbal** | `A:B::C:?` from UCLA Verbal Analogy Test (VAT; 80 items: categorical, functional, antonym, synonym), Sternberg & Nigro 1980 (200; + linear order), SAT (374, 5 choices for C and D), Jones et al. 2022 (120; categorical, causal, compositional; near vs far semantic distance) | Choose | Published: 57, 20, SAT estimate, 241 | Each completion scored by log-probability. The chosen answer is **appended to the context** before the next item |
| **Story analogies** | Gentner, Rattermann & Forbus 1993, 18 sources. Two targets match the source on first-order relations, only one shares its **causal (higher-order)** relations. Near (same entities) vs far (different entities) | Choose A / B / equal | `N = 54` | 18 × 2 conditions × 2 orders = 72 comparisons, context cleared each time |
| **Analogical problem solving** | Radiation problem (Gick & Holyoak 1980), alternative sources (Holyoak & Koh 1987), gumball transfer (Holyoak, Junn & Billman 1984) | Free text | — (published human data only) | Single uncurated sessions. **Qualitative, `n = 1` per condition** |

All GPT-3 runs at temperature 0.

---

## Key results

### Digit Matrices — the human difficulty structure, reproduced

| Contrast | Humans (odds ratio) | GPT-3 (odds ratio) | Literature signature |
|---|---|---|---|
| GPT-3 vs humans, generative | — | **1.88** (`p = 0.005`) | — |
| GPT-3 vs humans, multiple choice | — | **6.27** (`p = 2.3×10⁻⁸`) | — |
| Two-rule problems **with** a progression rule | 0.41 | **0.07** | Relations harder than features of single entities (Kroger, Holyoak & Hummel 2004) |
| Three-rule problems, per extra **unique** rule (total held fixed) | 0.61 | **0.25** | Relational complexity drives difficulty (Halford, Wilson & Phillips 1998) |
| Logic problems, spatially **permuted** vs aligned | 0.52 | **0.06** | More converging constraints make mapping easier (Matlen et al. 2020) |
| Item-profile correlation across 32 subtypes | `r(30) = 0.39`, `p = 0.027` | | |

- **The best human beat GPT-3.** One participant scored every problem correctly, so "beats humans" is a claim about the mean only.
- **Every human effect is stronger in GPT-3.** Each GPT-3 odds ratio is further from 1 than the human one. GPT-3 has a *steeper* difficulty gradient on the very variable the wiki treats as a capacity limit.
- **Order effects in both** (experiment 2, problems presented easy → hard). Both lose very little accuracy out to five-rule problems, unlike shuffled presentation. Placing distribution-of-3 problems just before progression problems *impairs* progression problems in both, and the authors read this as the progression rule being taken for distribution-of-3, which differs by one digit. This is a set (Einstellung) effect that GPT-3 picks up from its own context.
- **Perception removed, human difficulty unchanged.** Human error rates and their pattern across problem types are "very similar" for Digit Matrices and the image-based SPM (Figure 4, dropped from the clip; qualitative here). For humans, the parse is not where the cost of this rule structure lies.

### Letter strings

| Contrast | Result |
|---|---|
| GPT-3 vs humans | OR **1.76** (`p = 6.3×10⁻⁵`), driven by **zero-generalization** problems (OR 1.76) |
| Per added generalization | GPT-3 OR **0.51**, humans 0.66 |
| Item-profile correlation (41 of 252 subtypes with ≥5 trials each) | `r(39) = 0.70`, `p = 3.6×10⁻⁷` |
| No prompt / sentence format | Worse, still within 1 SD of the human mean, profile kept (`r = 0.60` / `0.76`) |
| Letters → real-world successorship | "Strong", with some transformation-type discrepancies (bar values dropped) |

### Four-term verbal

| Dataset | GPT-3 vs humans |
|---|---|
| UCLA VAT; Sternberg & Nigro | At or above human |
| SAT | Above the estimated high-school average |
| Jones et al. 2022 | In the human range, numerically below. **Semantic-distance effect reproduced** (OR 3.24, `p = 0.0165`) |

### Stories — the one human win

| | Near | Far | Overall |
|---|---|---|---|
| Humans (`N = 54`) | `t(53) = 21.5` | `t(53) = 16.7` | 15/54 perfect |
| GPT-3 (72 comparisons) | `p = 0.0039` | **`p = 0.065`, not significant** | OR **0.37** vs humans |
| GPT-4 (same 72, ChatGPT interface) | "nearly perfect" | above chance (Supplementary Figure 6, dropped) | — |

GPT-3's sensitivity to higher-order causal structure fails exactly when entity overlap is removed.

### Problem solving — mapping without transfer

| Condition | GPT-3 output | Human result it mirrors |
|---|---|---|
| Radiation problem alone | Brachytherapy (insert a source into the tumour). No convergence | ~10% convergence |
| After the General story | Convergence solution. Correct correspondences on request: general↔doctor, dictator↔tumour, army↔rays | Transfer once the source is available |
| After two lesser-known convergence sources (lasers; low-similarity ultrasound) | Convergence | Holyoak & Koh 1987 |
| General story **plus two distractor stories** | Brachytherapy again | ~20% without hint |
| Same, with the hint *"one of the stories you read before will give you a hint"* | Names the General story, gives convergence | **~75%** with hint |
| Gumball problem, after genie + **magic staff** story | Mechanically incoherent tube-and-string plan. Maps bottle↔bowl and jewels↔gumballs, maps staff to "rope and walking cane", never derives *pull the far bowl closer* | Children derive the cane solution |
| Gumball problem, after **magic carpet** story | Rolled-posterboard tube (the children's solution), with extra steps | Children use the posterboard over the ready-made tube |

**The magic staff row is the informative one.** Mapping succeeds and transfer fails. The authors attribute the failure to missing physical reasoning, not to mapping. On [[wiki/concepts/analogical-mapping.md]]'s pipeline, the transferred object is the source's causal/physical model, and GPT-3 has no target-domain model to elaborate.

---

## Model-variant dissociation (Supplementary §S2)

| Variant | Training | Digit Matrices, letter strings | Four-term verbal |
|---|---|---|---|
| `davinci` | Next-token prediction, web text | Weaker | Relatively good |
| `code-davinci-002` | + code | **Strong** | **Near chance** |
| `text-davinci-002` | code-davinci-002 + supervised instruction tuning | Good | Good |
| `text-davinci-003` | + RLHF | **Best** | **Best** |

Per the authors, the code-trained model's skill on synthetic, code-like relations "came at the cost" of real-world relational concepts. `(brainstorm)` This is a double dissociation produced by **training corpus**, at fixed architecture and size. Its shape matches the human lesion split on [[wiki/concepts/analogical-mapping.md]]: anterior temporal damage removes relational *content* uniformly (Morrison et al. 2004), frontal damage removes multi-relation *integration* (Waltz et al. 1999). In the model, the relation vocabulary appears to be a corpus-installed store that can be present for one domain and absent for another while the comparison machinery is shared. The test would be to probe whether the code model's verbal failure is a missing relation representation (a linear probe for BART-style relation vectors fails) or a failed comparison (the probe succeeds and the choice still fails).

---

## The mechanism question the authors leave open

GPT-3's internals are not probed. The authors name two transformer properties as candidates and a third as a warning.

| Candidate | Claim | Wiki status |
|---|---|---|
| **Pairwise similarity** | Self-attention computes a graded similarity between every pair of vectors at every layer. Graded vector similarity is the main constraint in PAM/visiPAM-style mappers | [[wiki/entities/pam.md]], [[wiki/entities/visipam.md]] map by exactly this kind of similarity, with an explicit one-to-one optimiser that attention lacks |
| **Indirection = variable binding** | Keys address values, one embedding set referring to another, "arguably a form of variable binding" | [[wiki/concepts/relational-bottleneck.md]] reads self-attention the other way: values are projected from the inputs, so content rides through and no bottleneck is enforced. [[wiki/entities/esbn.md]]'s comparison shows self-attention's relational generalization degrading with the entity encoder where the ESBN's does not |
| **Holistic parallel solution** | Through scale alone, the model may solve complex problems without the serial decomposition humans use (Carpenter, Just & Shell 1990) | Untested. A finer-grained correlation would test it, against the human order and set effects above |

Two caveats the authors state themselves:
- **Acquisition is not modelled.** The training data exceeds human linguistic input by orders of magnitude and consists of analogy-rich human text, so the capacity is "parasitic on natural human intelligence". It is not a model of development or evolution.
- **No episodic store.** Once the context is cleared, GPT-3 gives the non-analogical radiation solution again: "the system has learned nothing from processing the analogy". The fourth process, schema induction, is absent by construction.

---

## Limitations

| Limitation | Consequence |
|---|---|
| **One deterministic model compared with a population mean** | Temperature 0 makes GPT-3 a single subject. The odds ratios set one response vector against `N` humans. The paper gives no between-run variance (except 20 runs in experiment 2) |
| **"Zero-shot" is protocol-dependent** | Digit Matrices: no prompt, no examples. Letter strings: a task prompt. Four-term verbal: each earlier item **and the model's own answer** stays in context, which is in-context accumulation that the human protocol mirrors only loosely |
| **Format sensitivity** | Letter-string accuracy falls without the prompt or in sentence form. The headline uses the best format found |
| **Multiple choice by mean log-probability** | Mean token log-probability is not a decision. A candidate set with length or frequency confounds is scored on those as well. The distractor generator follows Matzen's SPM analysis, and the paper reports no context-blind baseline ([[wiki/entities/raven.md]]'s >90% answer-set leak is the precedent) |
| **Contamination checked by asking the model** | GPT-3 was asked whether it knew the materials and was prompted with partial items. It knew the 1980 radiation study's year and journal. Absence of recall is weak evidence |
| **Story and problem-solving evidence is small** | 72 story comparisons. Problem solving is single uncurated sessions with no statistics. GPT-4 was run only on stories, through the chat interface, with "very little" known about the model |
| **Human samples** | UCLA undergraduates for course credit, unsupervised online. Three Digit Matrices participants excluded for random responding. [[wiki/entities/conceptarc.md]] shows that faking failure is cheaper than solving, so such baselines are lower bounds |
| **Text only** | Digit Matrices hands the solver disentangled, pre-parsed tokens. The authors call it a test of rule induction from given representations, **not** of deriving them from pixels |

**Correction carried to `T212`.** The wiki's second-hand Position A (via Moskvichev et al. 2023) said "GPT-3/GPT-4" matched humans on letter strings. The primary tests letter strings on **GPT-3 only**; GPT-4 was run on the story analogies alone.

---

## Comparison

| | **Digit Matrices** | [[wiki/entities/raven.md]] | [[wiki/entities/pgm.md]] | [[wiki/entities/conceptarc.md]] |
|---|---|---|---|---|
| Input | Text digits, **parse given** | Images | Images | Grids (text or image) |
| Rule source | SPM rule structure (Matzen et al. 2010) | Stochastic image grammar | `[relation, object, attribute]` triples | Hand-authored concept groups |
| Answer | Generate + choose from 8 | Choose from 8 | Choose from 8 | Construct |
| Human baseline | `N = 40` / `47`, same items | 84% (second-hand) | none | 415 participants |
| Training items for the solver | **None** (zero-shot) | 42,000 | 1.2M | none (zero-shot for GPT-4) |
| Scored on | Accuracy **and** item-profile correlation with humans | Accuracy | Accuracy per regime | Accuracy per concept |
| GPT-class result | GPT-3 > human mean | — | — | GPT-4 0.03–0.33 per concept |

The last row is `T212`. One model family is above humans on a 1-D, pre-parsed Raven isomorph and far below them on 2-D grid concepts, so the gap between the two benchmarks cannot be a general deficit in analogical mapping. [[wiki/concepts/rule-level-evaluation.md]]'s 2025 frontier rerun moves ConceptARC to 75.6% in text, which shrinks the contrast without explaining it.

---

## Connections

- **[[wiki/concepts/analogical-mapping.md]]** — supplies a model without a prefrontal integrator that reproduces this page's human signatures. The unique-relation effect is stronger in GPT-3 (OR 0.25 vs 0.61), as are the relation-over-feature effect, the alignment effect and the hint-dependent retrieval of the General story. It also maps the gumball analogy correctly and still fails to transfer, which places the cost at the target-domain model, as that page's Stage 3 argues.
- **[[wiki/concepts/perception-reasoning-dissociation.md]]** — the parse-supplied design that page lists as missing, built as an isomorph rather than substituted. Human error rates and their pattern match image SPM, so on Raven's rule structure perception costs humans little. A text-only model given the parse beats the human mean.
- **[[wiki/concepts/relational-bottleneck.md]]** — the opposite corner of that page's trade. GPT-3 has no bottleneck (attention values carry content) and enormous data, and it reaches human-level zero-shot relational induction while showing the human semantic-distance effect, the graded content effect a strict bottleneck cannot produce.
- **[[wiki/entities/transformer.md]]** — the authors' two candidate mechanisms for emergent analogy both sit in that page's operator: `QKᵀ` as the pairwise graded similarity analogy mappers use, and key-to-value indirection as variable binding. Neither has been probed in a trained model.
- **[[wiki/entities/conceptarc.md]]** — the other half of `T212`. The same model family is above the human mean on 1-D, pre-parsed relational induction here and at 0.03–0.33 per concept on 2-D grid concepts there, so "LLMs do analogy" depends on the format.
- **[[wiki/entities/raven.md]]** — the psychometric parent with the parse removed. Same rule vocabulary (constant, distribution-of-3, progression, logic), but the solver gets disentangled digits instead of pixels, and the human difficulty profile survives the change.
- **[[wiki/entities/pam.md]]** — same lab, same General → radiation materials, opposite route: PAM recovers the correspondences by explicit graduated assignment over learned relation vectors, GPT-3 states the same correspondences (general↔doctor, army↔rays) when asked, with no mapper and no named relation vocabulary. GPT-3's far-story failure on causal structure is also a datum for `T416`, the dispute over whether mapping needs explicit higher-order relations.
- **[[wiki/entities/visipam.md]]** — the authors' own explicit-mapping counterpart, published the same year. Zero-shot mapping by an authored algorithm over frozen features, against zero-shot behaviour from next-token prediction, both scored against human item-level data (visiPAM `r = 0.70` on parts, GPT-3 `r = 0.70` on letter-string subtypes).
- **[[wiki/entities/esbn.md]]** — the evidence against the authors' "indirection = binding" reading as sufficient. In that comparison, self-attention's relational generalization depends on the entity encoder, where ESBN's architectural binding does not.
