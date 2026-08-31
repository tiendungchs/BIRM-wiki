# Compositionality

**New representations are constructed by combining primitive elements, so a finite vocabulary generates an infinite set of representable things — and a new concept costs only the *arrangement*, because the parts already exist (Lake et al. 2017).**

In the core framing ([[wiki/concepts/latent-graph-discovery.md]]) compositionality is what makes the meta-graph *productive*: the shared level stores primitives, sub-parts, parts and relations, and an instance-graph is a particular arrangement of them. This is why instantiation can be binding rather than learning — the hierarchy `primitives → sub-parts → parts → object template → exemplar` is a re-use ladder, and only the top rung is new per concept ([[wiki/entities/bayesian-program-learning.md]]).

> **Provenance.** Lake, Ullman, Tenenbaum & Gershman 2017 (`raw/lake-2017-machines-learn-think-like-people.md`), which names compositionality as one of three ingredients of rapid model building, alongside causality ([[wiki/concepts/causal-model-building.md]]) and learning-to-learn ([[wiki/concepts/meta-learning.md]]). The composition *problem* — how outputs of separate modules are joined at all — is stated on [[wiki/concepts/core-knowledge.md]] and gaps G21–G22; this page is about composition *within* a vocabulary, which is the tractable half.

---

## The formal claim

| Property | Statement | Consequence for a model |
|---|---|---|
| **Productivity** | An infinite number of representations from a finite set of primitives — infinitely many thoughts, sentences, concepts (Fodor 1975; Fodor & Pylyshyn 1988; Marcus 2001; Piantadosi 2011) | The concept space is *generated*, not enumerated; the learner searches programs, not points |
| **Partonomy** | Parts compose from sub-parts, forming a part-whole hierarchy (Miller & Johnson-Laird 1976; Tversky & Hemenway 1984) | Recursion in the representation, so depth is a free parameter rather than an architecture choice |
| **Efficient description** | A function hierarchy compactly describes higher-level functions, like a part hierarchy for a complex scene (Bienenstock, Geman & Potter 1997) | The MDL argument of the two-level hierarchy, restated: `\|primitives\| + N·\|arrangement\|` beats `N·\|concept\|` |
| **Structural description** | A visual concept is a composition of *parts and relations* — two wheels joined by a platform, supporting a post, holding handlebars (Biederman 1987; Marr & Nishihara 1978; Winston 1975) | Relations are first-class content, not implicit in a feature vector — the edge set, made explicit |
| **Coherence is missing** | Free combination of parts is not enough; a composition must hang together. "Compositionality and learning-to-learn provide the parts, causality provides the glue" | A composer needs a second, non-combinatorial criterion — see below and gap G22 |

**Where compositionality does *not* depend on prior learning.** Bottom-up parts-based decomposition from geometry alone (Hoffman & Richards 1984) supplies primitives without a learned library, which matters because the usual route — parts and relations reused from previously learned concepts — makes compositionality a *special case of learning-to-learn* and therefore inherits its knowledge-boundedness limit.

---

## Instantiations

| Domain | Primitives | Relations | Source |
|---|---|---|---|
| **Handwritten characters** | Pen sub-strokes → strokes | `attached along`, `attached at start`, spatial offsets | Lake, Salakhutdinov & Tenenbaum 2015 ([[wiki/entities/bayesian-program-learning.md]]) |
| **Novel objects** | Wheels, motors, handlebars, platforms | `attached`, `powered by`, `supports` | Lake et al. 2017, Fig. 1B |
| **Spoken words** | Phonemes | Sequence | Lake, Lee, Glass & Tenenbaum 2014 |
| **Actions / dance** | Primitive body movements | Sequence, simultaneity | Lake et al. 2017 |
| **Game scenes** | Object *types* (bird, fish, ice floe, igloo), each instantiated many times | Intuitive physics and intuitive psychology "as glue" | Object-oriented RL (Diuk, Cohen & Littman 2008) |
| **Latent transformations** | VQ codebook symbols with no stipulated meaning, semantics supplied by one shared executor | Sequence (concatenation only — no arity, no binding) | Baek et al. 2026 ([[wiki/entities/neo-neural-theorizer.md]]) |
| **Spatial relations in a text-only LLM** | Three direction vectors in the residual stream — `left`, `above`, `in front` — with inverses as negation (`r_right = −r_left`) | Vector addition: `µ_{above-and-right} ≈ µ_above + µ_right` at cos 0.993 / 6.0° inside a fitted 3-D subspace (0.395 / 66.7° in the raw stream) | Tehenan et al. 2025 ([[wiki/concepts/linear-representation-hypothesis.md]]) |
| **Goals** | Sub-goals defined as *reaching a given object* | Sequencing into a larger goal | Hierarchical DQN (Kulkarni et al. 2016) — the reported route to playing sparse-reward games such as Montezuma's Revenge |

The last two rows are the ones this wiki has least of: composition at the level of **object types** and at the level of **goals**, rather than at the level of visual parts. Both give the same economy — many repetitions of one type share one model — and the goal row is the only cited mechanism in the source for making delayed sparse reward tractable, which is gap G20's problem approached from the representation side rather than from the update rule.

---

## What deep networks have, and what they lack

| Present | Absent |
|---|---|
| Part-like features in deeper layers; new object types activate novel combinations of feature detectors (Zeiler & Fergus 2014) | Explicit representations of **objects, identity, and relations** |
| Convolutional invariance makes repeated instances of one object share features | A notion of **coherence** over novel configurations |
| Neural networks used for efficient inference in structured generative models that explicitly represent *the number of objects in a scene* (Eslami et al. 2016) | Composition at the level of goals, except where sub-goals are hand-defined over given object representations |
| Differentiable programming: stacks, queues, random-access memory folded into gradient-based learners (Neural Turing Machine, Differentiable Neural Computer — [[wiki/entities/differentiable-neural-computer.md]], Neural Programmer-Interpreter) — "genuine programs, albeit in a representation more like assembly language" | The programs learned are algorithms over data structures, not causal models of a domain ([[wiki/concepts/working-memory.md]]) |

**The same failure, now with paired-image controls and a decade of scale behind it** (Bordes et al. 2024, [[wiki/concepts/cross-modal-grounding.md]]). Vision-language models trained on 400M–1.8B image–caption pairs name objects at or above supervised-ImageNet level and fail the arrangement:

| Instrument | Design | Result |
|---|---|---|
| **Winoground** | Two images, two captions differing *only in word order* ("some plants surrounding a lightbulb" / "a lightbulb surrounding some plants"); both pairings must be scored | Fails — and the failure is the field's standing puzzle |
| **ARO** | Negatives by swapping relation, attribute or order ("A horse eating grass" → "grass eating a horse"); no negative *image* | Fails, but the design admits a language-prior shortcut |
| **PUG** | Synthetic scenes built one element at a time — background, then animal, then the animal moved left or right | **Not better than random chance on spatial relations**, with object recognition in the same scenes intact |

The third row is the one that closes the argument: because the scene is rendered twice with a single relation changed, "did not recognise the object" is excluded by construction, so the deficit is localised to the relation slot and nowhere else. **Objects are nodes and they bind; relations are edges and they do not** — at any scale yet tried, through any of the four training paradigms.

**The diagnostic failure.** A caption network gets the objects in a scene right and their causal relations wrong (Lake et al. 2017, Fig. 6 — a man being thrown off a horse captioned "a woman riding a horse on a dirt road"; a crashed airplane captioned "an airplane is parked on the tarmac"). Objects without relations is exactly the signature of a feature-set model: the parts are recovered, the arrangement is not represented at all, so the caption defaults to the arrangement most frequent in training. This is [[wiki/concepts/shortcut-learning.md]] localized to the relation slot.

---

## Reading in the core framing

| Compositional element | Latent-graph reading |
|---|---|
| Primitive library | The meta-graph's node and edge vocabulary — hardness source 2, if it must be induced; given, if it is installed ([[wiki/concepts/core-knowledge.md]]) |
| Parts and sub-parts | Intermediate nodes; the partonomy is a path in the generative hierarchy |
| Relations between parts | The typed edges the whole framing is about, appearing here inside a single concept rather than between states of the world |
| A concept = an arrangement | An instance-graph over the shared vocabulary — one-shot because only the arrangement is new |
| New concept from related concepts | Meta-graph reuse under a *different* binding — the operation [[wiki/concepts/meta-learning.md]] optimizes for |

**(brainstorm)** Compositionality sharpens gap G10 (unreliable self-generated intermediate nodes) into something testable. If a concept is a program over parts, then the model can be asked to *parse* — to emit its own intermediate structure — and the parse can be scored against human parses, which the character work does directly (Lake, Salakhutdinov & Tenenbaum 2012). Parsing is therefore a cheap probe for whether a model's intermediate nodes are real: a model that classifies well and parses badly has features, not parts. That is a G17-class instrument that needs no distribution shift, only a second query against the *same* representation. **This has now been built** — OTIB's support/query protocol is exactly a second query against the same representation, and the model that scores 0.994 on the first and 0.000 on the second is the wiki's cleanest demonstration that fit and structure are separable measurements ([[wiki/entities/neo-neural-theorizer.md]]).

---

## Bases that come pre-credit-assigned, and when factorisation stops paying

The hippocampal-formation models supply a vocabulary of *spatial* bases and one strong claim about what composition is for (Whittington et al. 2022).

| Basis type | Cells | Property |
|---|---|---|
| **Local bases** | Object-vector, border-vector, reward and goal-vector cells | Code *any* object/border/goal, irrespective of where it is — a slot with a free filler |
| **Global bases** | Grid cells | Describe information equally across the whole space |

Two exports:

**1. Composition can carry value, not just structure.** If a goal-vector basis is learned with a policy or value already attached, then a new goal configuration is handled by composing bases rather than by learning — the only online work is *inferring which bases apply*. Credit assignment becomes a retrieval-and-compose problem ([[wiki/concepts/cognitive-map.md]]). What makes this possible is that the bases path-integrate: one instance at the goal generates the rest for free ([[wiki/concepts/path-integration.md]]).

**2. Factorisation is a trade-off with a predicted switch.** Grid cells were thought factorised from everything non-spatial, but they *warp* toward consistently rewarded locations — and a warped code is by definition environment-specific, so it does not transfer. The proposed rule:

> When the set of tasks an animal faces is itself factorised, the representations for those tasks will be factorised; when task components always co-occur in the same combination, a bespoke entangled code is cheaper.

Storing one warped representation beats storing and combining many bases *if you never switch tasks*. This is the first statement in the wiki that compositional representation has a **cost** and that a non-compositional code can be the correct answer — and it makes a falsifiable prediction (vary how often reward configurations change; watch grid warping appear and disappear). Nothing controls this knob in a machine (gap G40).

**3. Where the knob has been read off a brain, it is set to *factorise*.** Zheng et al. 2024 put two relational structures over one set of objects — a transition graph learned the previous day, and lifetime semantic taxonomy — and found both mapped in the hippocampal formation with **non-overlapping** clusters (semantic posterior, transition anterior; each effect ≈ 0 in the other's region of interest), with no conjunctive code detectable ([[wiki/concepts/cognitive-map.md]]). The conditions are the ones rule 2 says should favour *entangling*: the two structures always co-occur (they are carried by the very same items, on every trial), and no task ever required either. The brain factorises anyway. Two readings, and they price the rule differently:

| Reading | Statement | What it would mean for a builder |
|---|---|---|
| **Factorisation is the default, entangling is the exception** | Rule 2's switch fires only for a specific pressure (a reward configuration held constant), and absent that pressure separate structures stay separate | Cheap: default to factored, and warp only under a detected constant | 
| **The rule's argument is acquisition, not co-occurrence** | The two structures differ in *mode and timescale of acquisition* (implicit/one day vs explicit/a lifetime) — the source's own framing — so what recombines across episodes is the acquisition process, not the content | Expensive: the controller must key on *how* a structure was learned, a variable no machine architecture records |

Neither is testable in the design, because the confounds are total (recency, explicitness, relation type and consolidation stage all covary). What the result does settle is the direction of the null hypothesis: a single embedding whose metric mixes all available relations over an item is not what the biological system builds, so an architecture that learns one distance function per entity is not the conservative choice.

---

## Compositionality decomposed: one adjective, five separately failable behaviours

Hupkes, Dankers, Mul & Bruni 2020 (`raw/hupkes-2020-compositionality-decomposed.md`) supply the thing this page has been asserting without: a **task-independent** test suite, because Partee's principle ("the meaning of a whole is a function of the meanings of the parts and of the way they are syntactically combined") is formally vacuous on its own — Janssen 1983 shows arbitrary expression sets can be mapped to arbitrary meanings without violating it, as long as the syntax is free. So "compositional" has to be cashed out as behaviours, and there are at least five, which come apart:

| Facet | Behavioural test | Result on three seq2seq architectures ([[wiki/entities/pcfg-set.md]]) |
|---|---|---|
| **Systematicity** | Recombine constituents never seen *together* | 0.53 / 0.56 / 0.72 — against task accuracies of 0.79 / 0.85 / 0.92 |
| **Productivity** | Generalise beyond training *length* | 0.30 / 0.31 / 0.50, with early `<eos>` emission accounting for only 22 / 6 / 8% of it |
| **Substitutivity** | Output unchanged under synonym substitution | 0.80 / 0.95 / 0.98 when synonyms are distributionally matched; 0.60 / 0.58 / 0.90 when one is seen only in primitive contexts; **0.14 / 0.09 / 0.34** on the measure that excludes "both answers were simply correct" |
| **Localism** | Meaning of a compound depends only on its immediate children | 0.46 / 0.59 / 0.54 — feeding the model its own intermediate answers changes the final answer about half the time |
| **Overgeneralisation** | Applies the rule where the data contradicts it (evidence the rule was internalised) | 0.68 / 0.79 / 0.88 peak at 0.1% exceptions; **absent** at 0.5% |

Three exports for a builder:

**1. A compositionally-generated dataset does not force a compositional solution.** PCFG SET contains no non-compositional phenomena by construction, argument strings are never repeated, and the alphabet is large enough that memorisation does not pay — and a model still reaches 0.92 by learning *function pairs as units* rather than functions. The wiki's standing move ("design the data so only the intended rule works") is therefore not available even in the limit; this is the cleanest instance of G16 in the wiki, since the data were generated by the intended rule itself.

**2. An operation learned at one argument size is a different object from the same operation at another.** The localism failures localise entirely to arguments longer than the training maximum of 5 — and the follow-up sweep shows LSTMS2S dropping to **exactly zero** at length 6 for every function and every seed, with ConvS2S and Transformer decaying smoothly to ~12 and ~9. A cliff at the training boundary means the model never held `copy`; it held `copy-for-length-≤5`. Productivity, on this page's formal-claim table, requires the opposite, and it is why the wiki's induced programs cannot iterate (G70) and cannot bind a free-length argument (G69).

**3. The rule/exception dial has a measured location and nothing sets it.** Below 0.5% contradictory examples all three architectures apply the rule anyway; at 0.5% none of them do. The switch is a property of the *data*, not a controller in the model — the same shape as the factorise-vs-entangle knob (G40), and the point at which [[wiki/concepts/complementary-learning-systems.md]]'s division of labour would have to be invoked. One architecture cannot hold both at once: after LSTMS2S abandons the rule for an exception, it emits neither the rule output nor the memorised target for the rest of training.

**The instrument is separable from the benchmark, and is the more portable half.** Substitutivity and localism are scored by a **consistency score** — compare the model's output against *its own* output under a meaning-preserving transform of the input, never against the target. It needs no labels, no distribution shift and no ontology; it is scoreable on a model that is failing the task; and its error-consistency refinement (restrict to items the model got wrong) removes competence as an explanation of agreement. That is a G17-class probe of a shape the wiki did not have ([[wiki/concepts/representation-probing.md]]).

---

## The channel composition travels through is the *output* vocabulary, and systematicity has a sample complexity

Lake & Baroni 2018 (`raw/lake-2018-scan-generalization-without-systematicity.md`, [[wiki/entities/scan.md]]) is the measurement the two sections above are reported against, and it carries two results neither of them reproduces.

**1. The "add primitive" split is confounded, and the confound names the mechanism.** Hold out every *composed* use of a verb, over-sample its isolated form to 10% of presentations, and the outcome depends entirely on which verb:

| Held-out verb | Its action symbol during training | Generalisation to its composed paradigm |
|---|---|---|
| `turn left` | `LTURN` occurs constantly *inside* composed action sequences (`walk left and jump left` → `LTURN WALK LTURN JUMP`) | **90.0–90.3%** |
| `jump` | `JUMP` occurs only as the one-word command's output | **0.08–1.2%** |

So a modifier transfers to a new argument exactly when the argument's **output symbol** has already been seen in composed outputs — not when the input word has. Every add-primitive split in the wiki inherits this: a primitive is only held out if its output symbol is held out too. It also relocates the failure — the encoder never placed `jump` in the primitive class at all (cosine .15 to `run`, against .73 for `run`↔`look`), so there was no class from which to inherit modifier behaviour.

**2. The all-or-nothing framing is wrong as a description of the network.** Titrate composed uses of `jump` back into training: 8 → 38.3%, 16 → 77.8%, 32 → **88.4%**. The curve is smooth. This kills the standard defence ("the model had no evidence that jumping is like walking") and simultaneously kills the standard indictment ("the model cannot compose"): what it lacks is not the rule but the *one-example* acquisition of it. Reporting the `n` at which criterion is reached turns the systematicity debate into a scalar with reference points — symbolic composer 0, human ~1, 2-layer LSTM 16–32 (`I31`, [[wiki/concepts/certification-instruments.md]]). The same shape appears outside the toy language: an English→French seq2seq gets a new adjective right in 1 of 8 constructions after 1 attested context, and 8 of 8 for an adjective attested in 80.

**3. Length extrapolation is the facet nothing has moved.** 13.8–20.8% on outputs longer than trained; an oracle handing the model the correct output length recovers it only to 23.6–60.2%; and MLC, which buys systematicity outright, scores **100% error** on this same split. Across the wiki, productivity is the facet with no positive result anywhere.

---

## The facets are properties of the task distribution, not of the architecture

Lake & Baroni 2023 (`raw/lake-2023-meta-learning-compositionality.md`, [[wiki/entities/mlc.md]]) hold the architecture class fixed at the one the section above scores worst-to-middling and change only how the training signal arrives — a stream of 100,000 episodes, each a *different* latent interpretation grammar inferred from 14 in-context study examples, instead of one static corpus.

| | i.i.d. training ([[wiki/entities/pcfg-set.md]]) | Meta-training over grammars ([[wiki/entities/mlc.md]]) |
|---|---|---|
| Systematicity | 0.53 / 0.56 / 0.72 | **1.00** on the human few-shot task; ≤0.22% error on SCAN's lexical splits, 0.87% on COGS's 18 |
| Productivity | 0.30 / 0.31 / 0.50 | **0.778** where the episode sampler varied length; **0.000** where it did not (SCAN length split, 3 COGS structural types, both at 100% error) |
| Same architecture without episodes | — | **0% exact match**, 10/10 runs, even with parameters selected on *test* loss |

**The load-bearing line is the productivity row, because both numbers come from one method.** MLC extrapolates to longer outputs in the instruction task — where episodes sampled input and output lengths freely — and fails completely on SCAN's length split, where episodes are built by permuting word types and nothing ever varies structure. So a facet is bought exactly when the episode generator varies the thing the facet tests. Systematicity was bought because word→meaning assignments were resampled every episode; productivity was not bought because length was not.

Three consequences for this page:

**1. "Architecture X composes" was the wrong question.** The falsifiable claim is *architecture X trained on distribution p(T) composes*, and the same transformer sits at both ends of the range. This moves the wiki's locus for compositionality out of the architecture slot and into the objective slot ([[wiki/concepts/neuroscience-ai-transfer.md]], G30) — the slot the wiki has least in.

**2. An inductive bias can be installed by sampling it at a measured rate.** MLC pairs each query with the algebraic output 80% of the time and with a *heuristic* output 20% (a one-to-one translation, or a rule with its binary arguments flipped), the ratio set to the measured human 80.7%. The bias ends up in the sampler, not in the architecture and not in a hand-written prior — a third route alongside [[wiki/concepts/core-knowledge.md]]'s installed modules. Its price is exact: biases outside the sampled set do not transfer.

**3. Human compositionality is systematic *and* biased, and the purely algebraic model is not the ceiling.** People hit 80.7% exact algebraic match, 72.5% on longer-than-trained outputs, and their errors are structured — one-to-one translation (24.4% of errors), iconic concatenation (23.3% of function-3 errors), mutual exclusivity (93.1% of participants in a no-example probe). A gold-grammar oracle must call all of that an arbitrary lapse, and loses to MLC at predicting human responses ([[wiki/empirical-tensions.md]] T201). The human biases are also *graded* — mutual exclusivity weakens with counter-evidence and with the number of available output symbols — and a sampled prior reproduces the rate without the gradient (T202).

**4. Support-set order is a systematicity probe, and the standard in-context reasoner fails it.** On the same task, GPT-4 scores 58.0% (SD 14.0) with the 14 study examples batched and sorted shortest-to-longest — a setting that leaks expected output length — and **14.0% (SD 19.0)** when the identical examples are shuffled; GPT-3.5 goes 27% → 17%; adding five worked meta-training episodes to the prompt *lowers* GPT-4 to 33.0%. Humans score 80.7% and MLC runs average 92.9–96.8% (Lake & Baroni 2023 SI-3). **(brainstorm)** A rule inferred from a support set must be invariant to the order of that set, so **permute the support and report the variance** is a cheap falsification test for any few-shot reasoner — one MLC passes by construction, because its sampler shuffles study order every episode, and one no benchmark in the wiki currently runs.

---

## Recombination and vocabulary extension are separately failable, and only the first is trainable

Barrett et al. 2018 ([[wiki/entities/pgm.md]]) run the facet split above on a *visual* benchmark whose abstract content is an explicit symbolic object — a set of triples `[relation, object, attribute]` — so the held-out set can be specified at the level of the abstraction. Eight regimes, one architecture (WReN), all against a measured 22.4% answer-set baseline (chance 12.5%):

| Held out | Test (%) | + symbolic auxiliary loss (%) |
|---|---|---|
| Nothing (neutral) | 62.6 | 76.9 |
| **Pairs** of triples never co-occurring | 41.9 | **56.3** |
| **Pairs** of attributes never co-occurring | 27.2 | **51.7** |
| A **triple** (7 of 29) | 19.0 | 20.1 |
| A relation on an **unseen attribute** (line-type, shape-colour) | 14.4 / 12.5 | 16.4 / 13.0 |
| The upper half of a **value range** | 17.2 | 15.5 |

Two exports.

**1. The boundary is between recombining seen constituents and acquiring an unseen one, and it is a cliff, not a gradient.** Both pair regimes stay far above the blind baseline; every constituent-novelty regime lands at or below it. A relation the model applies perfectly to the colour of lines is at chance on the colour of shapes — which is Fodor & Pylyshyn's systematicity failing not at recombination but one level down, at the point where a *known* function must accept a *new* argument type. This page's productivity failures (early `<eos>`, `copy-for-length-≤5`) are the same shape in the sequence domain: the operation was learned bound to the argument set it was trained on.

**2. Supervising the symbolic explanation buys recombination and nothing else.** Adding a 12-bit "meta-target" naming which relations, objects and attributes are present (`L = L_target + β·L_meta-target`) nearly doubles the attribute-pair regime and adds ~14 to the triple-pair regime — and moves the four constituent-novelty regimes by ≤ +2.0, one of them negative. So a discrete-symbol decoding pressure makes existing pieces composable; it does not manufacture pieces. That is the strongest available statement of where the loss-slot lever ends, and it is why the wiki's vocabulary-origin open problem below cannot be answered by better supervision on a fixed vocabulary.

---

## The split axis is a computed quantity, and it has a dose-response curve

Keysers et al. 2020 (`raw/keysers-2020-cfq-measuring-compositional-generalization.md`, [[wiki/entities/cfq.md]]) attack the *instrument* rather than the architecture. Generate every example from rules and keep the derivation DAG; call the rules **atoms** and the weighted subgraphs **compounds**; then build the train/test split by optimising two divergences at once — hold `D_A ≤ 0.02` (atoms matched, so the split is not a domain shift over primitives) while driving `D_C` to a swept target.

| Split method (CFQ) | `D_C` | What it is maximal on |
|---|---|---|
| Random | 0.000 | nothing |
| Output pattern (the field's default "query split") | **0.008** | output-pattern coverage → 0 |
| Input length | 0.062 | length ratio 0.578 |
| Output length | 0.176 | length ratio 0.486 |
| **MCD₁₋₃** | **0.694–0.713** | nothing observable — train and test samples are indistinguishable by eye |

Three consequences for this page.

**1. Compositional difficulty is measurable before a model is run, and it dominates.** Accuracy against `D_C` gives `R² = 0.81–0.88` for LSTM+attention, Transformer and Universal Transformer on *both* CFQ and SCAN; accuracy against input/output length ratio gives `R² = 0.11–0.22`. All three architectures score >95% i.i.d. (with 10× less data) and 14.9–18.9% at maximum divergence, and the gain flattens at ~80k training examples — so the facet failures above are not a data-quantity problem. This is the first thing in the wiki that makes o.o.d. difficulty **comparable across split methods and across datasets**, and the first reading of it is deflationary: the standard hard split of the semantic-parsing literature is a `D_C = 0.008` split.

**2. It re-scores the splits the sections above are reported on, and two of them fail their own control.** SCAN's `primitive<jump>` and `primitive<turn left>` come back at `D_A` = 0.08 and 0.07, 3–4× over the admission threshold, with training covering 63% and 94% of the space respectively. The output-symbol mechanism in the section above is still the sharpest single explanation of the 1.2%/90.3% gap, but it is confounded with an atom-distribution shift and a 31-point coverage difference that no experiment separates. Every add-primitive result in the wiki inherits both confounds, not just the first.

**3. It puts the facet decomposition itself in question.** If one scalar over derivation subgraphs predicts accuracy at `R² = 0.81–0.88`, the five facets may be regions of one axis rather than five independent dimensions — against which stands MLC's dissociation (systematicity to ≤0.22% error and productivity unmoved at 100% error under a single training-distribution change) and CFQ's own residual (the output-length split scores worse than its `D_C` predicts). Logged as [[wiki/empirical-tensions.md]] T312; the two instruments have never been run on the same data.

**And a protocol rule that applies to every number on this page**: hyperparameters must be tuned on a *random* split, never on an o.o.d. validation set, or the reported score measures the ability to be tuned into one known generalisation rather than generalisation to an unknown shift. This leaks through the hyperparameters, needs no test items, and leaves no trace in the score — a channel none of the wiki's shortcut inventory covers.

---

## Functional vs concatenative composition — the split every facet test above misses

> Penn, Holyoak & Povinelli 2008 (`raw/penn-2008-darwins-mistake-discontinuity.md`), reading van Gelder 1990 and Horgan & Tienson 1996 against the comparative record. Full decomposition at [[wiki/concepts/relational-reinterpretation.md]].

| Kind | Criterion | Who has it |
|---|---|---|
| **Functional** (van Gelder 1990) | Reliable, effective mechanisms exist to (1) *produce* a complex representation from its constituents and (2) *decompose* it back — **by any means**, concatenative or not | Every taxon examined. Novel dyadic social relations, means-ends contingencies and predicate-argument tracking all require it; the source calls the comparative evidence on this "no doubt" |
| **Concatenative** (Fodor & Pylyshyn 1988) | The compound **preserves the identity of its constituents** rather than sacrificing them to a conjunctive encoding — so both parts remain separately addressable *while* bound | Claimed human-only, and claimed necessary for role-filler independence |
| **Featural systematicity** | `R(a,b)` implies `R(b,a)` where the argument slots are constrained only by *observable features of the fillers* | Every taxon. Explicitly "the kind of systematicity that happens to be easily implemented by many nonclassical connectionist models" |
| **Classical systematicity** | `∀R transitive: R(a,b) ∧ R(b,c) ⊨ R(a,c)` — holding by how the relation is *defined*, independently of domain or learning history | Claimed human-only; no comparative evidence in any species |

**Three things this does to the sections above.**

**1. The five Hupkes facets all live inside functional compositionality.** Produce-and-decompose is what a seq2seq model is scored on, and the source's claim is that a honeybee has it. So the 0.53–0.72 systematicity scores are not near-misses on a human property; they are partial failures on the *animal* property, and no facet in the suite would separate a system that preserves constituent identity from one that does not.

**2. It supplies a second reading of the relation-slot failures.** Objects recovered, arrangement not represented (the caption networks, PUG at chance, [[wiki/entities/irene.md]]'s unbound preference) is what a code with functional but not concatenative composition looks like from outside: the constituents went in, something came out, and the roles were never separately addressable at any point.

**3. It puts a criterion under this page's open problems.** "Systematicity is tested; the *symmetric* case still is not" is the featural/classical distinction in the wiki's own words — role reversal over feature-constrained slots is the cheap version, and the version worth testing is whether the reversal holds because the relation is *defined* structurally.

---

## Open problems

- **Coherence has no operational definition.** "Causality is the glue" names the requirement without saying what computes it. The wiki's only mechanised candidate is composition-as-relaxation to a joint free-energy minimum, where a composition that has no low-energy state is simply never built ([[wiki/concepts/predictive-coding-free-energy.md]], gap G22).
- **Where does the primitive library come from?** Every instantiation above except the last uses a hand-specified or pre-trained primitive set. Bottom-up geometric decomposition is the only *cited* route that does not, and it is restricted to shape. **The wiki now has one worked answer**: fit the vocabulary and one shared execution operator jointly to raw observation pairs, and primitives that never appear in isolation are still recovered (primitiveness 1.000 at 33% composition coverage, [[wiki/entities/neo-neural-theorizer.md]]) — in synthetic domains, with ≤8 primitives, and with the pressure supplied by two terms nobody would have predicted: a decode–encode consistency loss on *intermediate* states, and a simplicity weight that destroys the vocabulary if set 20% too high.
- **Compositionality of goals is barely explored.** Sub-goals in hierarchical DQN are defined *by the experimenter* over object representations that are also given. Nothing induces the sub-goal vocabulary.
- **The cheapest possible composition operator has now been *found* rather than built, and it is addition.** A 3B language model nobody trained for it holds spatial relations as directions whose sums approximate the directly-learned composites, with opposites as negations — i.e. a finite primitive set generating unseen arrangements by vector arithmetic, which is this page's productivity claim with the arrangement operator costing zero parameters. Three caveats keep it from being a mechanism: the additivity holds only after projection onto a fitted 3-D subspace ([[wiki/empirical-tensions.md]] T159); the composed direction is never steered, so composition is a geometric observation while only the *atomic* relations are shown causal; and the composites tested (`above and right`) do appear in the training corpus of English, so this is composition *observed*, not composition *generalised* to a held-out arrangement — the length-OOD test OTIB runs has no counterpart here.
- **Systematicity *is* now tested — see the section above — and it fails; the vision-language benchmarks that try are additionally scoreable by a collapsed model.** Winoground/ARO/SUGARCREPE-style tests are binary discriminations resolved by `argmax`, which does not handle ties — so a model whose parameters are all zero, assigning both captions the same representation, wins every item where the correct caption is listed first (Bordes et al. 2024). Any published compositionality number produced without a tie check is uninterpretable, and the fix is an epsilon of noise ([[wiki/concepts/cross-modal-grounding.md]]).
- **Systematicity is tested; the *symmetric* case still is not.** Being able to represent "X prefers Y" does not guarantee "Y prefers X" (Fodor & Pylyshyn 1988). Hupkes et al. 2020 test the weaker, sufficient-for-falsification version — hold out four function *pairs* and score recombination — and all three seq2seq architectures fail it (0.53 / 0.56 / 0.72 against task accuracies of 0.79 / 0.85 / 0.92), so "architecture X composes" is now falsifiable and has been falsified for the standard three ([[wiki/entities/pcfg-set.md]]). What no benchmark in the wiki still checks is role reversal specifically ([[wiki/concepts/core-knowledge.md]], open problems). **Productivity now is** (OTIB's length-OOD split: compose 4–8 primitives having trained on 1–3), and the *instrument* generalises further than its benchmark — induce a structure from a support pair, execute it on a query pair, and the gap between the two scores separates "fits this instance" from "recovered the mechanism" with one number ([[wiki/entities/neo-neural-theorizer.md]]). That is the G17-class probe this page's brainstorm asked for, in a machine, and it says nothing about the symmetric case. **And systematicity has now also been *passed*** — by the same architecture class that failed it, after the training signal was restructured as a stream of tasks ([[wiki/entities/mlc.md]]), which converts this bullet from a claim about architectures into a claim about task distributions.
- **Nothing chooses which facet the task sampler covers.** MLC's episode generator varies word→meaning assignments and so buys systematicity; it does not vary length in the benchmark variant and so scores exactly 0 on productivity. The sampler is authored, its coverage is not measured, and a test set drawn from the same sampler cannot reveal the hole (G66). This is the compositionality-specific instance of "where does `p(T)` come from" ([[wiki/concepts/meta-learning.md]], G9).
- **Compositionality and learning-to-learn are entangled.** Parts and relations are themselves products of previous learning, so the sample-efficiency credit assigned to compositionality may belong to the pre-training that supplied the parts.

---

## Connections

- **[[wiki/entities/pcfg-set.md]]** — the operationalisation of this page: five task-independent behavioural tests that split "compositional" into separately failable facets, plus the consistency score, which measures composition without measuring competence.
- **[[wiki/entities/cfq.md]]** — makes the split axis a computed quantity instead of a hand-picked holdout: compound divergence over derivation subgraphs predicts accuracy at `R² = 0.81–0.88` where length ratio predicts it at 0.11–0.22, which both re-scores every benchmark on this page and puts the facet decomposition itself in question (T312).
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the productivity of the meta-graph: a finite installed vocabulary generates an unbounded set of instance-graphs, which is why binding can be one-shot.
- **[[wiki/concepts/causal-model-building.md]]** — the paired ingredient: composition supplies the parts, causality supplies the coherence criterion that decides which arrangements are legal, and neither is sufficient alone.
- **[[wiki/concepts/meta-learning.md]]** — compositionality is *what* learning-to-learn transfers when it works: the transferred object is a library of parts and relations, not a weight initialization, and the source claims transfer is weak in deep networks precisely because the representation is not compositional.
- **[[wiki/entities/bayesian-program-learning.md]]** — the worked instantiation: a five-level compositional hierarchy over pen strokes, with one-shot human-level classification as the result.
- **[[wiki/concepts/core-knowledge.md]]** — the installed-vocabulary case, and the harder problem this page brackets: composing *across* encapsulated modules with different formats (gap G21), as opposed to composing within one vocabulary.
- **[[wiki/concepts/shortcut-learning.md]]** — the caption failure (objects right, relations wrong) is a shortcut localized to the relation slot: a model with no explicit relation representation defaults to the most frequent arrangement in training.
- **[[wiki/concepts/simulation-based-planning.md]]** — constructive recombination, listed there as a property machines lack, *is* compositionality applied to imagined scenarios; a planner cannot recombine what the representation does not factor.
- **[[wiki/concepts/working-memory.md]]** — differentiable programming (external memory, stacks, queues) is the machine-learning route to composition over data structures, and the source's candidate for uniting program induction with gradient learning.
- **[[wiki/concepts/abstract-structural-codes.md]]** — a part-relation description is content-invariant by construction: the same relation set applies to wheels, strokes or ice floes, which is what a structural code `g` is supposed to give.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — the one mechanised proposal for coherence: hold two encodings active and let mutual constraint satisfaction settle, so compositions with no low-energy state are never formed.
- **[[wiki/entities/arc-agi.md]]** — makes compositional reuse the *evaluation criterion*: the proposed solver searches a domain-specific language and recombines sub-programs that worked on earlier tasks, so scoring well requires the productivity this page describes rather than merely exhibiting it.
- **[[wiki/concepts/energy-based-models.md]]** — composition of *goals* is free where composition of modules is not: cost terms combine by addition of energies, so several simultaneous constraints form one objective without any binding mechanism.
- **[[wiki/concepts/intelligence-density.md]]** — makes composition constitutive rather than instrumental: meaning over a domain *is* the correct selection and ordering of primitive functions, so a system that generalizes necessarily holds a compositional arrangement, and syntax fails to be semantics exactly when the arrangement does not generalize.
- **[[wiki/concepts/subgraph-matching.md]]** — composition dictating a training schedule: subgraph containment composes across message-passing layers, so a matcher must be trained on monotonically growing queries (+6% AUROC, lower variance) rather than on the full distribution at once (Ying et al. 2020).
- **[[wiki/concepts/contextual-inference.md]]** — the counterexample that shows retrieval and composition are separable: it gets allocation and graded retrieval over an unbounded memory library right while the memories remain exchangeable atoms with no internal structure to compose (Heald et al. 2021).
- **[[wiki/concepts/path-integration.md]]** — a second, algebraic kind of composition: actions compose by addition with closure enforced by the update rule, which is the only case in the wiki where a composition's coherence is guaranteed rather than checked.
- **[[wiki/concepts/successor-representation.md]]** — the default-representation variant composes at the level of cell types (grid × border to represent an inserted barrier) with no retraining, which is composition of *state-space bases* rather than of concepts.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — learns factorised entorhinal bases from next-observation prediction, and marks the boundary: space and task were learned in one fixed pairing, so a T-maze-to-W-maze change breaks it.
- **[[wiki/concepts/cognitive-map.md]]** — the one measurement of this page's factorise-vs-entangle knob in a brain: two relational structures over the same objects are held in separate hippocampal territory rather than fused, which sets the default to factored and leaves *what selects between them* unaccounted for (Zheng et al. 2024).
- **[[wiki/concepts/distributed-reference-frames.md]]** — a third kind: an object-anchored frame makes a feature's position *relative to the object* the reusable unit, so a part-whole description carries a metric with it, and recognition is a consensus rule over many such descriptions rather than a single parse.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — a mechanism for the factorise-vs-entangle decision (G40) that costs no new representation: two inhibitory channels with different fan-in widths over one excitatory population, the broadly-innervated one (*Pvalb*, *Sst*) averaging over contexts and enforcing generalization, the sparsely-innervated one (*Id2*) inheriting context specificity and enforcing splitting.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — offers a disjunctive primitive the wiki otherwise lacks: a Boolean-OR union tests membership in a set of patterns without enumerating them, which is the representation a rule needs when applied to an unbounded instance set — bounded, on the numbers given, at 4–16 patterns per slot before mix-and-match errors bite.
- **[[wiki/entities/thousand-brains-theory.md]]** — part-whole description with a metric attached and a consensus rule over it: a feature's position relative to the object transfers across scenes, and an object is recognised as the unique hypothesis surviving intersection across columns at matched locations.
- **[[wiki/concepts/manifold-constrained-learning.md]]** — the recombine-versus-extend boundary drawn at the network level: new patterns *within* an existing low-dimensional basis are learnable in hours, patterns requiring new basis directions are not, which is the source's own proposed split between combinatorial and transformational creativity and makes vocabulary extension the expensive operation (Sadtler et al. 2014). Tightened one level: inside the basis the population does not even generate new patterns over hours, it re-labels existing ones with new intents, so fast learning is re-binding an existing vocabulary rather than recombining it (Golub et al. 2018).
- **[[wiki/entities/pbwm.md]]** — binding by routing: a control input decides which memory stripe an item is gated into, so the same filler reaches different slots and novel sequences generalize — and the authors' own limit (each stripe must learn to encode its fillers, each reader must learn to decode that stripe) measures exactly how far this is from a symbolic variable.
- **[[wiki/entities/neural-module-networks.md]]** — productivity measured over *layout depth* rather than over token sequences, and passed: withholding every 6-module layout from training raises size-6 accuracy (85.2 → 89.7), because composition legality is a declared type check (`combine: Attention × Attention → Attention`) rather than a statistic learned over seen structures — which is this page's productivity claim bought by authoring the type system (Andreas et al. 2016).
- **[[wiki/entities/differentiable-neural-computer.md]]** — the primary source for the differentiable-programming row: pointers (a memory row's content naming another row) are what let composition run over data structures, and are also why the learned program reads as assembly rather than as a causal model.
- **[[wiki/concepts/arbitrary-sensorimotor-mapping.md]]** — the layer underneath that is explicitly *not* compositional: an arbitrary cue→action edge shares no structure with any other, so it cannot be derived from parts — every compositional system needs a non-compositional binding store supplying the primitives it recombines (Wise & Murray 2000).
- **[[wiki/concepts/controller-knowledge-vs-process.md]]** — supplies a compositional format for *plans* that no sequence model here implements: a partially ordered stored event sequence commits only the necessary precedences, so two such plans interleave without either being rewritten, which total-order episodes cannot do.
- **[[wiki/concepts/control-unity-and-diversity.md]]** — supplies the network-topology numbers this page argues for without quantifying: white-matter modularity *and* global efficiency both predict control ability in the same sample, and modularity mediates its developmental rise — so the target is modular specialization plus high-bandwidth cross-module paths, both computable on any multi-module model (Friedman & Robbins 2021).
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — names the mechanism that would actually score well on a conversion-rate measure — recombining sub-programs that worked on earlier tasks, so experience amortises as reusable vocabulary rather than as data.
- **[[wiki/entities/neuromatch.md]]** — a curriculum justified by composition: the order constraint composes across message-passing layers, so query complexity has to grow monotonically during training (+6%).
- **[[wiki/concepts/temporal-abstraction-options.md]]** — the failure that names the requirement in the action domain: options cannot express the overlap between "spread jam on bread" and "spread icing on a cake", because an option is an atom with a policy attached rather than a manoeuvre composed with its arguments — so quasi-hierarchical human behaviour is evidence for factorising the *unit of skill* itself (Botvinick, Niv & Barto 2009).
- **[[wiki/entities/hami.md]]** — the cheapest possible compositional store: quantise two factors independently and pair the symbols, and novel combinations of seen components come free, with no binding operator, no variable and no recursion — which sets the floor that any richer proposal on this page has to beat (Poursiami et al. 2025).
- **[[wiki/entities/hisd.md]]** — a context-free grammar induced over *behaviour*: terminals are unsupervised skills, non-terminals are subroutines, recursive depth is emergent rather than specified, and the productivity is bought by the same digram-uniqueness invariant that makes the compression lossless — with this page's predicted failure attached, since an over-separated terminal alphabet (noisy Minecraft skills) leaves no substring to share and the grammar degenerates to one private parse per episode (Harvey et al. 2026).
- **[[wiki/concepts/affordance-grounded-symbols.md]]** — primitives grounded rather than stipulated, plus a measurable factorisation test: split the symbol code and recombine the parts, and factorise only if effect prediction is unchanged — a criterion unavailable to any objective scored on reconstruction (gap G40).
- **[[wiki/concepts/learned-world-models.md]]** — compositionality bought from an external vocabulary: factorising video generation along language primitives generalises a world model to unseen object–action combinations, which is the undergenerating horn of G22 traded for a working system (RoboDreamer, in Long et al. 2025).
- **[[wiki/entities/irene.md]]** — the complement of the caption-network failure: hand the model the relation slot for free (typed spatial edges, message passing) and objects-plus-relations still does not yield binding — a preference stays unbound to the agent that held it, at chance across every architecture and curriculum variant tried.
- **[[wiki/entities/kan-ode.md]]** — a compositional decomposition of *function space* rather than of concepts, and the wiki's clearest case of one being usable: the Kolmogorov-Arnold theorem writes any multivariate continuous function as a finite composition of univariate ones, and putting the learnable parameters in those univariate factors is exactly what makes the learned dynamics individually plottable and symbolically extractable.
- **[[wiki/entities/adaworld.md]]** — the cheapest composition mechanism in the wiki and the least tested: two induced action codes are merged by averaging them in a continuous latent space, which also does duty as *within*-action denoising over 100 samples — so the same operation is claimed to both average out variation and combine distinct meanings, on one qualitative figure.
- **[[wiki/entities/neo-neural-theorizer.md]]** — the primitive library induced rather than supplied, and the parse-based instrument this page proposed for G17 built as a benchmark protocol: transferability (support pair → query pair) scores the arrangement, not the fit.
- **[[wiki/concepts/linear-representation-hypothesis.md]]** — composition reduced to arithmetic: if primitives are directions, an arrangement is a weighted sum and an inverse is a negation, which makes this page's productivity claim a measurable angle — and supplies the caveat that the measurement is taken in a fitted subspace rather than in the space the network computes in.
- **[[wiki/concepts/program-induction.md]]** — the reduction that makes composition literal: parts are sub-programs and productivity is code re-use, so this page's criteria become the search space's closure properties.
- **[[wiki/concepts/language-of-thought.md]]** — the claim that the composition this page describes is carried by a syntax over discrete typed expressions, with productivity and systematicity as its two diagnostics (Fodor & Pylyshyn 1988).
- **[[wiki/concepts/cross-modal-grounding.md]]** — this page's relation-slot deficit measured at web scale with the confound removed: PUG re-renders one scene with a single spatial relation changed, and models that recognise every object in it score at chance on which relation holds.
- **[[wiki/concepts/retrieval-capacity.md]]** — the retrieval-side price of composition: logical operators over attributes make all `C(n,k)` subsets askable, while a similarity-ranked store can address only `(1+1/γ)^d` of them, so a rule over an unbounded instance set cannot be answered by a precomputed key per instance and must be scored jointly at query time.
- **[[wiki/entities/dinov2.md]]** — a part vocabulary emerging from an objective that never mentions parts: PCA components of patch tokens split foreground from background and then align *object parts* across pose, style and category, and patch-feature assignment matches a plane's wing to a bird's wing — structural correspondence without a compositional prior or a symbolic slot anywhere in the model.
- **[[wiki/concepts/external-verification.md]]** — recombination and *justified* recombination separate under measurement: 2026 systems with near-identical final-answer scores differ by 30+ points on proof-grade grading, so producing the right composed answer does not imply the composition can be checked step by step (Raiyan et al. 2026).
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the composition operator with an arity and an inverse, which the addition-only cases on this page lack: convolution binds a filler to a *named role*, the bound relation is the same width as an object so nesting is free, and unbinding recovers the argument — productivity in a metric space rather than in a symbol string (Plate, NIPS 7).
- **[[wiki/concepts/analogical-mapping.md]]** — systematicity as an operational constraint rather than a property claim: parallel connectivity forces the arguments of corresponding relations to correspond, so a mapping is legal only if it respects arrangement and not merely parts — and the correspondence is what lets structure learned about one instance be applied to another.
- **[[wiki/entities/ilp-arc-synthesizer.md]]** — composition as sequential state update rather than function application: the parts of an induced ARC program do not compose independently of the order they run in, because an object already drawn occludes anything drawn over it.
- **[[wiki/entities/corethink-compositional-reasoner.md]]** — a system that defines composition (`π = p_{a_m} ∘ … ∘ p_{a_1}`) and never invokes it: the surviving patterns are forwarded as an unordered natural-language hint, and the residual failures on ARC-AGI-2 are precisely the multi-stage compositional tasks.
- **[[wiki/entities/mlc.md]]** — the counter-experiment to this page's architecture-centred framing: a standard transformer meta-trained over a stream of latent grammars reaches 100% systematicity where the same architecture trained i.i.d. reaches 0%, and its productivity is non-zero exactly where the episode sampler varied length — so the facets are properties of `p(T)` (Lake & Baroni 2023).
- **[[wiki/entities/arc-vsa-solver.md]]** — a case where the *code* composes and the *search* does not: fixed-width binding permits arbitrary nesting, while the solver's one-operation-per-object restriction forbids chained transforms on a persistent object, so the compositional ceiling sits in the synthesiser rather than the representation.
- **[[wiki/entities/arc-agi-2.md]]** — a four-way taxonomy of compositional failure authored specifically against systems that already handle single-rule composition: simultaneous interacting rules, sequential state dependence (step `N` requires executing step `N−1`), contextual gating of a rule by a cue, and in-context symbol definition.
- **[[wiki/entities/pgm.md]]** — the facet split measured on a visual benchmark with the held-out set declared over the abstraction: recombining seen `[relation, object, attribute]` triples costs 20 points, while a relation carried onto an unseen attribute or an unseen value range falls to the answer-set baseline — and a symbolic auxiliary loss moves the first and not the second.
- **[[wiki/entities/bib.md]]** — systematic generalisation declared over the *training distribution* rather than the input: each of its five evaluations is solvable only by conjoining two deliberately separated training tasks (navigate × prefer), so failure localises to composition and not to any missing ingredient.
- **[[wiki/entities/baba-is-ai.md]]** — composition over *world edits* rather than over descriptions: `break`, `make` and `goto` are each demonstrated in context, and each rewrites the transition function the next one runs under, so the held-out `break; make; goto` is three environments rather than a longer expression — and all three frontier models fail it under every rotation of which triple is shown.
- **[[wiki/entities/sigma-pi-reservoir.md]]** — composition justified by approximation theory instead of productivity: binding is chosen because the similarity of a composed representation is the *product* of its constituents' similarities (conjunctive: alike only if alike in every part) where superposition gives a *sum* (disjunctive: alike if alike in any part), so the two composition operators are distinguished by the semantics of their inner products rather than by what they can express.
- **[[wiki/concepts/complementary-learning-systems.md]]** — where a componential code becomes a hard requirement rather than a desideratum: the hippocampal read-out (CA1) must regenerate *novel* cortical patterns from a sparse code, which is only possible if new patterns are recombinations of existing elements — and every CLS model installs that code by pretraining rather than learning it (O'Reilly et al. 2011).
- **[[wiki/concepts/discrete-infinity.md]]** — the comparative coordinate for this page's productivity facet: the finite-state/phrase-structure boundary that cotton-top tamarins fail and human adults cross implicitly places the 0.30–0.50 seq2seq productivity scores on the *animal* side of a boundary measured in biology, and names the missing part as one recursive operator rather than a training deficiency.
- **[[wiki/concepts/relational-reinterpretation.md]]** — the comparative decomposition that splits this page's central adjective in two: functional composition (produce and decompose by any means) is universal across taxa, concatenative composition (constituent identity preserved in the compound) is the claimed human-specific property, and every facet test on this page measures only the first.
- **[[wiki/concepts/emergent-modularity.md]]** — supplies a wiring account of the recombination facet: human inferior frontal cortex gains a markedly stronger arcuate-fasciculus projection from middle-temporal-gyrus semantic areas than chimpanzee or macaque, and generalised systematicity is proposed to be what afferent *diversity* into one composition site buys — turning this page's hardest facet into a sweepable fan-in parameter.
- **[[wiki/concepts/environment-invariance.md]]** — composition proposed as a *substitute* for environment diversity: invariance gives no guarantee where the environments' input supports are disjoint, and a compositional restriction on the classifier is what would license learning in one region and evaluating in another (Arjovsky et al. 2019, concluding dialogue) **(brainstorm)**.
- **[[wiki/entities/sme.md]]** — systematicity implemented as a local cascade: 80% of a match's belief flows down argument edges, so the preference for interconnected higher-order structure needs no global objective and no bird's-eye count of order — the cheapest mechanisation of "arrangement matters" in the wiki.
- **[[wiki/entities/dreamcoder.md]]** — the two-level MDL argument run as an optimisation instead of asserted: primitives are adopted only when they shorten library + corpus, and library *depth* correlates with held-out tasks solved at `r = 0.79`.
- **[[wiki/entities/scan.md]]** — the benchmark that made this page's facets falsifiable, plus the mechanism behind its own headline split: a modifier transfers to a held-out primitive only when that primitive's *output* symbol has appeared inside composed outputs, and the transfer arrives as a smooth curve in the number of composed examples (38.3/77.8/88.4% at 8/16/32) rather than as a rule switching on.
