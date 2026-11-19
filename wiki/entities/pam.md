# PAM (Probabilistic Analogical Mapping) over BART relation vectors

**Analogical mapping run as Bayesian graph matching between two *semantic relation networks*. Nodes are concept embeddings (Word2vec, 300-d). Edges are learned relation vectors (BART, 540-d). The correspondence matrix is found by graduated assignment under a soft one-to-one prior. There are no propositions and no hand-coded predicates once the key concepts are chosen, and no training on analogy problems. The bet: relation *content* on flat pairwise edges does the work that higher-order propositional *structure* does in SME and LISA.**

> **Provenance.** Lu, H., Ichien, N. & Holyoak, K. J. (2022), *Probabilistic analogical mapping with semantic relation networks*, Psychological Review 129(5):1078 (`raw/lu-2022-probabilistic-analogical-mapping-semantic-relation-networks.md`, arXiv:2103.16704, manuscript version with Supplemental Information). pdf2md, **lossy**: the equations are conversion-damaged and restated below, and Table 1 (pseudo-code) and all figures are lost. Simulation numbers come from the text and Tables S2–S6.

The wiki reaches this model from [[wiki/concepts/analogical-mapping.md]]. That page's model table is all hand-coded inputs, and its Limits section names "every analog is hand-authored" as the field's bottleneck. PAM is the first entry where the *edges* are computed rather than authored. It is a reference for row 3 (alignment) of the requirements table on [[wiki/concepts/abstraction-graph.md]], not a component.

---

## Architecture

| Stage | Module | Output | Learned from |
|---|---|---|---|
| 1. Concept meaning | Word2vec (Google News) | 300-d embedding per key concept → **node attribute** | Distributional statistics; generic, not trained for this task |
| 2. Relation eduction | **BART** (Bayesian Analogy with Relational Transformations; Lu, Wu & Holyoak 2019) | 270 relation posteriors + 270 role posteriors = **540-d edge attribute** per ordered pair | Supervised: 135 relations, each from about 12–25 positive pairs (79 relations from the Bejar/Jurgens 10-class taxonomy, 56 from Popov et al. 2017). Converses are obtained by swapping the two words' weights, giving 270 |
| 3. Graph construction | Heuristics | Nodes = key concepts. Word sets: bidirectional edges between all pairs. Texts: edges only between keywords in the same sentence; a subject–verb–object triple becomes three **unidirectional** edges (`dog→chase`, `chase→cat`, `dog→cat`) | Hand rules + NLP (word frequency, TextRank, 2-gram co-occurrence) + some human intervention |
| 4. Mapping | **PAM** | Probabilistic mapping matrix `m`, `m_ii′ = P(source node i ↔ target node i′)` | Nothing learned. Free parameters: `α`, `β`, 500 iterations |

The authors' framing: two traditions. *Representation matching* (SME, ACME, LISA, STAR) gives zero-shot analogy but uses hand-coded inputs. *End-to-end learning* (PGM-, RAVEN-trained networks on 1.42 M / 70 k problems) has automated inputs but transfers only to near-identical problems. PAM keeps the first tradition's comparison process and takes the second's goal of automated input formation.

### BART: a relation is a posterior vector over a learned relation vocabulary

| Step | Operation | Why |
|---|---|---|
| Input | concatenate the two words' 300-d embeddings → 600-d | — |
| Augment | for each feature, take the between-word difference, rank the features by difference magnitude, and append the raw features re-ordered by that rank → 1,200-d | Different instances of one relation use different features (`love:hate` emotion, `rich:poor` wealth), and embeddings are entangled. Ranking aligns "differences of similar size" with no prior knowledge of which features matter |
| Select | elastic-net logistic regression on difference vectors | picks the features that predict relation `R` |
| Fit | Bayesian logistic regression with a **contrast prior** (word-1 coefficient = stage-2 estimate, word-2 coefficient = its negative) | a relation as a weighted *difference* between the two terms |
| Read out | `P(R_i = 1 ∣ f₁, f₂) = ∫ P(R_i = 1 ∣ f₁, f₂, w) P(w ∣ training) dw`, for all 270 relations | the edge vector |
| Roles | `P(r_i = 1 ∣ w∘f₁)`: probability that the first word fills relation `i`'s first role. Trained by re-running Bayesian logistic regression on the relation-weighted features `w∘f`, with word 1 as positive and word 2 as negative | binding a concept to a role. **Relations first, roles extracted from them** — the reverse of DORA (Doumas et al. 2008, roles first, then combined into predicates). Goldwater, Markman & Stilwell 2011 (learning *to cake* licenses *caker*) is cited for this order |
| Sharpen | raise each element to the **power 5** ("winners take most"; power fit on Simulation 1, following Ichien et al. 2021) | lets the strongest relations dominate the cosine |

**Four relational representations, which do not replace one another** (the authors' "re-representation" ladder; Penn, Holyoak & Povinelli 2008, [[wiki/concepts/relational-reinterpretation.md]]):

| # | Object | Explicit? | Job |
|---|---|---|---|
| 1 | Word2vec embedding | Implicit, entangled relational features | Concept meaning (node) |
| 2 | BART weight distribution over word features | Implicit | **Eduction of relations** (Spearman 1923: from two terms, produce the relation between them) for *any* pair, including pairs never trained |
| 3 | One relation's posterior | A disentangled "relation feature" | — |
| 4 | The 540-d relation vector | Explicit, distributed, separate from the node attributes | **Eduction of correlates** (compare `A:B` with `C:D`) |

**BART relations are *internal* relations.** They are read off generic embeddings of the two terms, so they hold by the nature of the terms (`pansy` is a `flower`; `read` is done to a `book`). Verbs such as `chase`, `give`, `kill` are *external* relations, probably not features of any relation vector. This is the stated difference in goal from DORA, which learns predicates. A verb therefore enters PAM as a **node**, linked to its arguments by internal-relation edges.

### PAM: the objective

Source graph `g`, target graph `g′`. `A_ii` = node attribute, `A_ij` = edge attribute, `S` = cosine similarity after normalisation:

```
P(m ∣ g, g′) ∝ P(g, g′ ∣ m) · P(m)      s.t.  Σ_i′ m_ii′ = 1 ∀i,   Σ_i m_ii′ = 1 ∀i′

log P(g, g′ ∣ m) = Σ_i Σ_{j≠i} Σ_i′ Σ_{j′≠i′} m_ii′ m_jj′ S(A_ij, A_i′j′)   +   α Σ_i Σ_i′ m_ii′ S(A_ii, A_i′i′)
                   └─────────── edge (relation) term ───────────┘          └──── node (lexical) term ────┘

P(m) = exp( (1/β) Σ m_ii′ log m_ii′ )       (maximal at a deterministic m: the soft one-to-one prior)
```

- **Bistochastic normalisation of `S`** (Cour, Srinivasan & Shi 2006, balanced graph matching): `Σ_{i′,j′} S = 1` and `Σ_{i,j} S = 1`. An edge similar to *many* edges in the other analog is down-weighted; an edge similar to one edge only is up-weighted.
- **Solver:** graduated assignment (Gold & Rangarajan 1996). Mapping values are relaxed to `[0, 1]`, softmax is annealed toward 0/1 over iterations, and row/column normalisation approximates one-to-one. A fixed 500 iterations was "reliably sufficient". *(The source's Eq. 5–6 signs and the direction of `β` are conversion-damaged; the solver is read here as standard graduated assignment.)*
- **`α`** weights entity similarity against relation similarity. The authors read it as the global factor behind the relational shift, behind time-pressure effects and behind sparse-vs-rich object effects. Values used: 0.1 (Simulation 1), 1 (Simulations 2–3, older children), 2 (younger children).
- **Attention weights** on chosen nodes or edges carry pragmatic goals (Nosofsky 1986).
- **Cost.** Exhaustive search over mappings is `O(n!)`: 10 concepts gives 3.6 M orderings. The paper quotes PAM as `O(n²)` in *space*. **Wiki computation:** the edge term compares every source pair with every target pair, so each iteration reads an `n(n−1)·n′(n′−1)` similarity tensor. Per-iteration time is `O(n²n′²)`, the same order as ACME's `O(n⁴)`.

The objective is a **quadratic assignment problem** in Lawler's general form (a compatibility score for every pair of candidate correspondences), plus an entropy prior. *(Wiki reading.)* The multiconstraint theory of ACME (Holyoak & Thagard 1989) survives term by term: node term = semantic constraint, edge term = structural constraint, attention weights = pragmatic constraint, entropy prior = soft one-to-one.

---

## Key results

| Sim | Task | PAM (BART-full) | Human | Decisive control |
|---|---|---|---|---|
| **1** (new experiment) | Map a scrambled triplet onto an ordered `A:B:C`. 12 **Category** triplets (`mammal:dog:beagle`) and 12 **Part-Object-Location** triplets (`fin:fish:ocean`), all 132 ordered pairs of each. 1,329 MTurk participants (49 excluded), one problem of each type each. `α = 0.1` | All-correct **0.83** (Category), **0.89** (Part-Object-Location). Item-level RMSD (root-mean-square deviation) from humans **0.22** | 0.74, 0.79 | Same BART vectors, exhaustive search: 0.69 / 0.86, RMSD .29. Word2vec-diff edges (either solver): **0.35** / 0.68, RMSD .39. Nodes-only: 0.33 / 0.67, RMSD .38 |
| 1, position effects | Which word in the triplet is mis-mapped | Predicts lowest accuracy for the **middle** word (Category) and the **first** word, the part (Part-Object-Location) | Same pattern: type × position `F(2,524) = 17.78`, `p < .001`. Category middle < first, `t(131) = 4.48`. Part-Object-Location first < middle `t = 3.93`, < last `t = 5.01` | BART-rel (relation half only) misses the Category pattern. Nodes-only and Word2vec-diff miss the Part-Object-Location pattern |
| **2** | Turney 2008: 10 science analogies + 10 analogical metaphors (solar system/atom, computer/mind, war/argument …), 5–9 keywords each, no text. **No word pair was in BART's training set** | **85%** keywords correct. Science 0.79 < metaphor 0.90 | 88% (22 people); science 0.85, metaphor 0.91. LRME (Latent Relation Mapping Engine, corpus co-occurrence) 92% | Nodes-only 77% with **no** science/metaphor difference (.78/.77). Word2vec-diff 77%. BART-role alone 85%. Edges-only 67%. Adding subject–verb–object edges to solar system/atom: 5/7 → **7/7** |
| **3** | Spellman & Holyoak 1996 Exp. 2: non-isomorphic planet stories. Barebrute maps to Hungerall (economic aid) or Millpower (military aid). Every country gets the Word2vec vector for `country`, so node similarity cannot discriminate | Goal = attention weights on goal-relevant edges, sampled `U[1, 1.1]` over 1000 runs. Reproduces the shift **and** its asymmetry (military emphasis moves the mapping more). `r = .96` over 10 conditions | Same shift and asymmetry; about half of control participants map both | Edges-only: shift yes, **asymmetry no**, `r = .80`. The asymmetry comes from node similarities: `economic` is closer to `rich/poor/strong/weak` than `military` is. Nodes-only: no shift. Word2vec-diff: cannot run (identical node vectors → zero difference vectors) |
| **4** | Gentner & Toupin 1986, children: systematic vs non-systematic source × high/medium/low compatibility (cross-mapping), 8 animal sets | `α = 2` (age 4–6) vs `α = 1` (age 8–10) gives both main effects, their interaction, and the larger systematicity benefit at the older age. Older, systematic vs non-systematic: 3 / 3 / 2.75 vs 3 / 1.31 / 0.94 correct of 3 | Same qualitative pattern | The *only* input difference between versions is the keyword `jealous` (twice in the systematic text; two NLP keyword extractors pick it, and neither picks `strong`). **No higher-order relation is given to either version.** Nodes-only: systematicity has no effect. Edges-only: perfect on every systematic condition |
| **5** | Gick & Holyoak 1980: *The General* → radiation problem, non-isomorphic short texts | 7/7 human-agreed correspondences (army→ray, fortress→tumour, commander→doctor, country→patient, large→high, capture→destroy, controls→uses), plus attack→destroy. Unmatchable concepts (dictator, landmines, roads) are forced into arbitrary pairs | — | Word2vec-diff **2/7**. Nodes-only 4/7. Edges-only 3/7. BART-role 7/7, BART-rel 6/7. Inputs: 14 and 10 NLP-selected keywords, synonym replacement by hand, and two subject–verb–object relations added by hand ("commander controls army", "doctor uses rays") |
| **6** | Keane 1987 retrieval: near (surgeon/brain tumour) vs far (general/fortress) source for the radiation target | Both sources mapped correctly. Mapping score `G` = **2.216** near vs **1.665** far | 88% vs 12% retrieved; about 86% solve once cued, either source | — |
| **7** | Rank all 20 Turney sources for each target by `G` | Intended source top-1 for **17/20**. In the 3 misses a *nearer* analog wins (planetary motion → solar system; sound waves → the other sound-waves set; molecular heat → combustion), and the intended source is ranked second | — | — |

`G = log P(g, g′ ∣ m̂)`: Eq. 4 evaluated at the MAP mapping `m̂`. **Retrieval and mapping read the same objective**: mapping is its `argmax`, retrieval its `max`.

### What the ablations establish

1. **Relation content, not graph form, carries mapping.** With graph structure and solver held fixed, swapping BART edges for difference vectors drops Simulation 1 from 0.83 to 0.35 and Simulation 5 from 7/7 to 2/7. Difference vectors are the standard "relation = embedding offset" encoding, and they score at the nodes-only level on every task.
2. **The comparator is not a mere approximation.** PAM beats exhaustive search on identical vectors (0.83 vs 0.69) because bistochastic normalisation lets the discriminative edges dominate, whereas exhaustive search weights every pair equally. Search exactness lost to *edge weighting by informativeness*.
3. **Neither half suffices, and the mix is task-dependent.** Edges-only matches the full model when `α` is small anyway (Simulation 1), and fails on Turney (.67), on the goal asymmetry (Simulation 3) and on the convergence analogy (3/7). The **role** half alone equals the full model in Simulations 2, 3 and 5; the relation half alone fails the Category position effect.
4. **`(brainstorm)` The retrieval/mapping dissociation is `argmax` vs `max` of one objective.** The edge term fixes the argmax and the node term barely moves it, so mapping looks domain-blind. The node term adds to the value, so a near source scores higher and retrieval looks domain-sensitive. The paper reports the pattern (Simulation 6); the reading is the wiki's. It is a candidate for the second branch of `T330`'s `Closes when` and does not close it (see that row).

---

## Higher-order relations, argued away for mapping

The paper's strongest theoretical claim. It contradicts the systematicity definition the wiki carries ([[wiki/concepts/analogical-mapping.md]]: "prefer the interpretation that preserves the largest interconnected system of higher-order relations"). Logged as `T416`.

| Argument | Content |
|---|---|
| Simulation 4 | Gentner & Toupin's systematicity effect was attributed to a higher-order `cause`. It is reproduced with no higher-order relation, from one extra keyword. Proposed mechanism: text coherence (Kintsch 1988), with keyword extraction as its proxy. Any textual cue that sets up unambiguous relations among *several interconnected keyword pairs* helps mapping |
| Linguistic | Most evidence for higher-order relations in mapping uses `cause` alone (Clement & Gentner 1991; Gentner et al. 1993; Forbus et al. 2017). Direct causation is usually single-clause ("the boy broke the vase"), not a sentential complement (Kemmer & Verhagen 1994; Wolff 2003) |
| Inferential | Relations syntactically equivalent to `cause` (`temporally prior to`) do not support inference the same way (Lassaline 1996). `cause` is special because of its pragmatic relevance and its role in causal networks: inference is sensitive to generative vs preventive causes and to predictive vs diagnostic direction (Holyoak, Lee & Lu 2010; Lee & Holyoak 2008) — not because of its syntactic order ([[wiki/concepts/causal-model-building.md]], `T192`) |
| Concession | Propositions (or at least natural-language syntax) are probably needed for **inference, schema induction and explanation**. The proposed division of labour: PAM gives a fast "quick sketch" of a mapping plus a quality score `G`, and propositional machinery develops a promising mapping and generates inferences from it by copy-with-substitution. Worked example: "the commander divides the army" + `commander→doctor`, `army→ray` gives "the doctor divides the ray" |

---

## Limitations

| Limitation | Stated? | Consequence |
|---|---|---|
| **Nodes are chosen, not discovered.** Keywords are picked by hand or by frequency/TextRank, with hand synonym substitution and hand-added subject–verb–object relations in Simulation 5 | Stated ("some human intervention is still required") | The hand-coding bottleneck is narrowed to node selection and edge presence, not removed. Simulation 4's systematicity result rests on a keyword choice (`G27`) |
| **The relation vocabulary is given.** BART is supervised on a human taxonomy of 135 relations, and thematic verb–noun relations are poorly covered | Stated (proposed: train on more relations) | Edges are *computed* but the relation alphabet is *authored* (`G4`) |
| **All relations are binary.** Ternary relations (`b is between a and c`, `x gave y to z`) and sentential complements are proposed via flat dependency parses, untested | Stated | Pairwise all the way down, in the representation as well as the objective (`G105`) |
| **Everything maps.** No slack column, so unmatched concepts get arbitrary partners | Stated (slack column proposed) | No abstention, no "nothing corresponds here". Contrast LISA's unmatched-inhibition signal ([[wiki/entities/lisa.md]]) |
| **One mapping per run.** Ambiguity appears only as an average over runs with jittered attention weights (Simulation 3) | Visible | Pairwise *coherence* between alternatives (Bush→Roosevelt *with* US→US) is not represented in the marginal `m` (`T306`) |
| **Parameters set per simulation.** `α` (0.1 / 1 / 2), power 5 (fit on Simulation 1), attention weights on modeller-chosen edges | Visible | Hierarchical-Bayesian `α` search is proposed, not run |
| **No inference, no schema induction** | Stated | Mapping only |
| **Retrieval maps against every stored source.** `G` is not size-normalised and has no inter-source competition (footnote 3) | Stated (authors say mapping every stored case "seems unlikely", and propose a "finalists" filter) | Qualitative rank-order predictions only (`T185`, `G37`) |
| **Verbal only** | Stated (visual extension proposed) | — |
| **No neural implementation** ("could in principle be instantiated in a neural network") | Stated | — |
| MTurk participants score below the model | Visible ("perhaps due to variable effort") | Item-level RMSD is the fairer comparison |

---

## Comparison to related models

| | **PAM + BART** | [[wiki/entities/sme.md]] | [[wiki/entities/lisa.md]] | ACME | APNN ([[wiki/concepts/analogical-mapping.md]]) | End-to-end matrix solvers ([[wiki/entities/pgm.md]]) |
|---|---|---|---|---|---|---|
| Analog representation | Attributed graph: embedding nodes, **learned** pairwise relation-vector edges | Predicate calculus with higher-order propositions | Localist propositions over distributed semantic units | Localist propositions | Sparse binary codes, re-represented upward | Learned features, no explicit relation |
| Relation match | Graded cosine on 540-d posteriors | Identical predicates, or re-represented until identical | Through shared semantic units | Graded similarity table | Dot product | Implicit |
| Higher-order relations | **None** (argued unnecessary for mapping) | Central (systematicity) | Nested propositions | Yes | Yes (via `upper` codes) | — |
| Mapping | Graduated assignment, soft 1:1, bistochastic weighting | Enumerate all gmaps | Hebbian under a phase budget | Relaxation | `argmax` | No separable mapping step |
| Cost | `O(n²n′²)` per iteration (wiki), 500 iterations | `O(N²)` to `O(N!)` | Serial load cycles | `O(n⁴)` | `O(n·n′)` | One forward pass after training |
| Input formation | Edges and node attributes computed; **nodes chosen** | Hand-coded | Hand-coded | Hand-coded | Hand-coded | Raw pixels |
| Analogy training | None | None | None | None | None | 10⁴–10⁶ problems |
| Retrieval | `G` = the same objective's maximum | MAC/FAC first stage | Semantic-unit pathway without mapping weights | ARCS | Dot product on `lower` codes | — |

**`(brainstorm)` Where PAM sits for a builder.**
- **BART is a relational bottleneck with a named output space.** An edge depends on the pair only through a learned relation readout, like the inner products of [[wiki/concepts/relational-bottleneck.md]]. Its outputs are posteriors over 270 named relations rather than a similarity, so the code is disentangled by construction and its dimensions are inspectable. The cost is the authored taxonomy.
- **`α` is the graded bottleneck that page lists as unbuilt**, located in the mapper, not the learner. It is a single scalar set per experiment, and nothing decides it.
- **The cheapest upgrade the paper names but does not test is a slack row/column** in `m`. It would give the matcher the abstention it lacks and turn "everything maps" into a per-node decision.

---

## Connections

- **[[wiki/concepts/analogical-mapping.md]]** — the page whose model table this joins as the first row with computed rather than authored edges: it keeps multiconstraint theory term by term (node term = semantic, edge term = structural, attention = pragmatic, entropy prior = soft one-to-one) and swaps the hand-coded propositions for learned pairwise relation vectors.
- **[[wiki/entities/sme.md]]** — the rival bet on what carries a mapping: SME enumerates interpretations over identical predicates and prefers higher-order systematic structure, while PAM matches graded relation vectors on a flat pairwise graph and reproduces a systematicity effect with no higher-order relation (`T416`).
- **[[wiki/entities/lisa.md]]** — the same laboratory's earlier model, with the opposite trade: LISA binds roles by synchrony and maps Hebbianly under a 2–3-proposition budget over hand-coded propositions; PAM has no capacity limit, computes its relation codes, and extracts roles *from* learned relations — the reverse of the roles-first order of LISA's DORA extension.
- **[[wiki/concepts/relational-bottleneck.md]]** — BART's edge is a relational readout over pairs of object codes with a named, disentangled output space, and PAM's `α` is the graded object-vs-relation dial that page lists as unimplemented, built into a mapper as a scalar the modeller sets.
- **[[wiki/entities/lateral-frontoparietal-network.md]]** — where BART vectors have already been tested against tissue: RSA of word-pair patterns during verbal `A:B::C:D` evaluation against BART relation vectors (Chiang et al. 2021) finds the code in several areas including superior parietal lobule while `A:B` is shown alone, and in anterior lateral prefrontal plus parietal cortex once comparison is possible, and BART but not Word2vec-diff fits that similarity structure.
