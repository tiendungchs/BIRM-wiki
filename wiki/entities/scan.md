# SCAN — the compositional instruction benchmark, and its three splits

**A finite, exhaustively enumerated instruction→action language (20,910 commands, 13 input words, 6 output actions) whose train/test splits are declared over the *interpretation function* rather than over the inputs, so a failure localises to a named form of compositional generalisation (Lake & Baroni 2018).**

> **Provenance.** `raw/lake-2018-scan-generalization-without-systematicity.md`, ICML 2018 (arXiv 1711.00350). SCAN = **S**implified version of the Comm**A**I **N**avigation tasks. The wiki has cited SCAN's `add jump` and `length` splits since [[wiki/entities/mlc.md]] without ever holding the source; this page is the artefact.

The reason this page exists: SCAN is the benchmark that made "architecture X composes" falsifiable five years before [[wiki/entities/pcfg-set.md]] decomposed the adjective and [[wiki/entities/mlc.md]] moved the locus to the task distribution. Its three splits are still the coordinates those later results are reported in.

---

## The language

Finite (no recursion), unambiguous, and *fully specified* — the grammar and the interpretation function are both printed, so the intended solution is a known object.

| Layer | Content |
|---|---|
| Primitives | `walk`, `look`, `run`, `jump` (undirected `U`); `turn left`, `turn right` (directed `D`) |
| Modifiers | `left` / `right` (prefix a turn), `opposite` (two turns then act), `around` (act at each of four turning steps), `twice` / `thrice` (repeat scope) |
| Conjunctions | `and` (left-then-right), `after` (**right-then-left** — the only order-reversing rule) |
| Interpretation | `⟦x twice⟧ = ⟦x⟧⟦x⟧`; `⟦x₁ after x₂⟧ = ⟦x₂⟧⟦x₁⟧`; `⟦u around left⟧ = LTURN ⟦u⟧ LTURN ⟦u⟧ LTURN ⟦u⟧ LTURN ⟦u⟧` |
| Size | 20,910 commands, ≤9 input tokens, ≤48 output actions |

Two structural properties matter for a builder. **The command length and the action length are decoupled** — `jump around right` is three words and eight actions — so length extrapolation on the *output* side can be tested without changing the input distribution, which no natural-language benchmark permits. And **the interpretation is a lookup table over a small closed vocabulary**, so the "learn the function, not the pairs" pressure that [[wiki/entities/pcfg-set.md]] engineers by an unbounded 520-symbol argument alphabet is *absent* here — a point the later benchmark makes against this one.

---

## The three splits, and what each holds out

Models: SRN, LSTM, GRU × {attention, none} × {1,2} layers × {25…400} units × {0, 0.1, 0.5} dropout = 180 architectures, 5 seeds each, 100K training presentations. Training accuracy >99.5% for the overall-best model in every experiment.

| Split | Held out | Best architecture (%) | Overall-best 2-layer LSTM (%) |
|---|---|---|---|
| **Random (Exp 1)** | 20% of commands, i.i.d. | **99.8** | 99.7 |
| **Length (Exp 2)** | Every command whose *action sequence* exceeds 22 (train 16,990 / test 3,920, lengths 24–48) | **20.8** (GRU + attention, 50 units) | 13.8 |
| **Add primitive (Exp 3, `jump`)** | Every *composed* use of one verb; the primitive itself is over-sampled to 10% of presentations | **1.2** | 0.08 |
| **Add primitive (Exp 3, `turn left`)** | Same design, different verb | **90.3** | 90.0 |

Four things only the primary source carries:

**1. The random split is passed from sparse coverage, and the sparse coverage is not sparse.** 1% of commands → 5%; 2% → 54%; 4% → 93%. But at the 2% split every conjunction-free test command *also* occurs in training (mean 8 occurrences); at 1%, all but one do (mean 4). So the impressive-looking sample efficiency is recombination of well-attested parts, and the source says so.

**2. The length failure is not a decoder-termination artefact.** Two controls. (a) For nearly every error the network assigns its own output *higher* log-likelihood than the target — not a search failure. (b) Giving an oracle the correct output length at evaluation moves the overall-best model 13.8 → 23.6 and the top model 20.8 → **60.2**, and even the fixed-length top model decays 95.8% (24 actions) → 22.8% (48 actions). Length is partly an emission problem and mostly not.

**3. The `turn left` / `jump` asymmetry names the channel composition actually travels through, and it is the *output* vocabulary.** `turn left` is held out from composed *commands*, but its action `LTURN` appears constantly inside composed action sequences (`walk left and jump left` → `LTURN WALK LTURN JUMP`). `JUMP` appears only in the one-word command. So the model generalises a modifier to a new verb exactly when it has already seen the verb's *action symbol* used compositionally — not when it has seen the word. **A held-out primitive is only held out if its output symbol is held out too**, and every "add primitive" split in the literature inherits this confound.

**4. Even the 90% success is not rule-shaped.** All 45 errors of the median `turn left` run are conjunctions with `turn left` or `turn left thrice` as a component — while `turn left thrice and turn left` is correct. A system that gets `jump right and turn left twice` right and `jump right and turn left` wrong did not learn `⟦x₁ and x₂⟧`.

---

## The titration curve — systematicity has a sample complexity, and it is not zero

Re-train the best `jump` model with `n` *composed* `jump` commands added (still 10% over-sampled):

| Composed `jump` examples in training | Generalisation to the rest of the paradigm |
|---|---|
| 0 | ~0 |
| 8 | 38.3% |
| 16 | 77.8% |
| 32 | **88.4%** |

This is the paper's most under-cited result and it cuts both ways. It refutes the "the model had no evidence that jumping is like walking" defence — evidence was given and the curve is smooth. And it refutes the all-or-nothing framing of the systematicity debate as a *description of the network*: the network is not a broken rule-follower, it is a working example-hungry generaliser. **(brainstorm)** The curve, not the pass/fail number, is the instrument: report the *number of composed examples* needed to reach criterion, and a symbolic system scores 0, a human scores ~1, this LSTM scores ~16–32. That converts a binary philosophical claim into a scalar with a human reference point, and it is measurable on any architecture the wiki holds — see `I31` on [[wiki/concepts/certification-instruments.md]].

---

## The representation diagnosis

Cosine between **final encoder hidden states** over whole commands, against all training commands (Table 1). `run` was trained compositionally; `jump` was not.

| Query | Nearest training command | Cosine |
|---|---|---|
| `run` | `look` | .73 |
| `jump` | `run` | **.15** |
| `run twice` | `look twice` | .72 |
| `jump twice` | `walk and walk` | **.19** |

The encoder never placed `jump` in the primitive class, so there was no class from which to inherit modifier behaviour. Note the level: this is a **sequence-level state**, not an input embedding — and it is informative here, where [[wiki/entities/pcfg-set.md]]'s *embedding* distances were not ([[wiki/concepts/representation-probing.md]]). Distributional isolation is visible in the representation that does the composing, and invisible in the one that stores the tokens.

---

## Experiment 4 — the same failure outside the toy language

Standard seq2seq English→French on short sentences (10,000 train / 1,180 test, LSTM + attention, 28.6 BLEU). Add 1,000 repetitions of `I am daxy` → `je suis daxiste`, then test `daxy` in eight constructions (`you are`, `he is`, negation, `très`) each attested with ~22 other predicates.

| Adjective | Constructions seen in training | Correct at test |
|---|---|---|
| `daxy` | 1 | **1 / 8** |
| `tired` | 80 | **8 / 8** |

Small, informal (one hyper-parameter sweep, no seeds reported), and the only evidence in the source that the SCAN result is not an artefact of a 13-word language. It is also the titration curve again — 1 context versus 80.

---

## What the source proposed, and where each proposal landed in the wiki

| Proposal (§5) | Wiki status |
|---|---|
| Learning-to-learn over many rule-governed environments | **Done, and it works**: [[wiki/entities/mlc.md]] — 100% systematicity, ≤0.22% error on these very splits, same architecture class |
| Learned per-modifier functions, composed by the RNN (modular networks, program induction) | [[wiki/entities/neural-module-networks.md]] buys productivity over layout depth by declaring a type system; [[wiki/entities/dreamcoder.md]] induces the library itself |
| Differentiable stacks / tapes / RAM for separate variable storage | [[wiki/entities/differentiable-neural-computer.md]] — programs over data structures, not causal models; no systematicity number |
| *Ad-hoc* copy mechanisms and novel-word embedding initialisation | Dismissed by the authors in advance as SCAN-specific — and the warning held: the length split resisted every one of them |

---

## Limitations

- **Finite and recursion-free.** Productivity in the formal sense (unbounded depth) cannot be tested; the length split tests extrapolation over a *bounded* range that the grammar itself caps at 48 actions.
- **A lookup table over the argument set is expressible.** With 4 undirected verbs the interpretation of `twice` can be memorised per verb, which is exactly the shortcut the `add jump` split then punishes — [[wiki/entities/pcfg-set.md]] designs this out with a 520-symbol never-repeated argument alphabet.
- **`jump`'s split is confounded by output-symbol frequency** (see point 3 above); the paper reports the confound but the split is still used as a clean systematicity test throughout the later literature.
- **And the confound is not the only one.** Re-measured on [[wiki/entities/cfq.md]]'s divergence scale (Keysers et al. 2020, Appendix G), `primitive<jump>` has **atom divergence 0.08** and `primitive<turn left>` **0.07** — 3–4× over DBCA's `D_A ≤ 0.02` admission threshold — so both splits shift the *rule* distribution as well as the compound distribution, and are partly domain-adaptation tests. They also differ in coverage: training covers **63%** of the space for `jump` against **94%** for `turn left`. The output-symbol mechanism above remains the sharpest single explanation of the 1.2%/90.3% gap, but it is confounded with a 31-point coverage difference and a divergence difference that no experiment here separates.
- **The length numbers are recurrent-model numbers.** The same splits run on transformers give **0%** (Transformer and Universal Transformer) against the LSTM's ~14%, so the 13.8–20.8% band on this page is not an architecture-independent floor ([[wiki/entities/cfq.md]]).
- **No compositional *structure* is ever probed.** The model is scored on exact-match strings only; there is no analogue of PCFG SET's localism unroll or consistency score, so a failure cannot be assigned to a parse step.
- **2018 model set.** SRN/LSTM/GRU with Bahdanau attention; no transformer, no pretraining, ≤400 units.

---

## Comparison

| Benchmark | Split declared over | Facets separable | Memorisation priced out | Passed by anything in the wiki |
|---|---|---|---|---|
| **SCAN** | The interpretation function (length, primitive) | 2 (systematicity, length extrapolation) | No — small closed argument set | Systematicity yes ([[wiki/entities/mlc.md]]); length **no** (100% error) |
| [[wiki/entities/pcfg-set.md]] | Function pairs, length, synonyms, sub-expressions | 5, plus a label-free consistency score | Yes, by construction | No |
| [[wiki/entities/pgm.md]] | `[relation, object, attribute]` triples | Recombination vs. constituent novelty | n/a (visual) | Recombination partly; novel constituent no |
| [[wiki/entities/arc-agi.md]] | Nothing — tasks withheld from the developer | None; one number | n/a | No |

---

## Connections

- **[[wiki/concepts/compositionality.md]]** — the source of the wiki's oldest compositional-generalisation coordinates, and of the finding that qualifies them: the modifier transfers to a new verb when the verb's *action symbol* has appeared in composed outputs, so the composition channel is the output vocabulary rather than the input word.
- **[[wiki/entities/cfq.md]]** — the instrument that re-scores this page's splits on a computed scale: `add primitive` comes back at `D_A` = 0.07–0.08 against a 0.02 admission threshold and at unequal coverage (63% vs 94%), so the splits are partly domain shifts, and the hand-picked holdout is shown to be one point on a divergence axis that can be swept continuously.
- **[[wiki/entities/mlc.md]]** — the split-for-split answer to this page: the same architecture class, meta-trained over latent grammars, drops the `add jump`-style lexical error to ≤0.22% while scoring **100% error** on this page's length split, which is exactly the split its episode sampler never varied.
- **[[wiki/entities/pcfg-set.md]]** — the successor instrument: same "compositional artificial language" genre, but the interpretation functions are systematic rather than enumerated and the argument alphabet is unbounded, so the lookup-table solution this page's small vocabulary permits is not even expressible.
- **[[wiki/concepts/language-of-thought.md]]** — the empirical test case for Fodor & Pylyshyn's systematicity challenge, and the result that complicates the dichotomy: the network is not a failed rule-follower but a smooth example-hungry generaliser (38.3 → 77.8 → 88.4% at 8 → 16 → 32 composed examples).
- **[[wiki/concepts/certification-instruments.md]]** — supplies `I31`, the composed-example titration curve: sweep how many composed uses of a held-out primitive are needed to reach criterion, and report a scalar sample complexity instead of a pass/fail systematicity verdict.
- **[[wiki/concepts/representation-probing.md]]** — the level-of-representation correction: distributional isolation of a held-out primitive is visible in the *sequence-level encoder state* (cosine .15 to its own class) and invisible in the token embeddings that PCFG SET measured.
- **[[wiki/concepts/shortcut-learning.md]]** — the shortcut named by the length split: a model that is right only on the test commands most similar to training (8–9 tokens, shortest action sequences) learned the surface statistics of the length range, not the interpretation rule.
- **[[wiki/entities/transformer.md]]** — absent by date; every model here is a 2018 recurrent seq2seq, which is why the wiki's transformer numbers on these splits all come through later sources.
- **[[wiki/entities/neural-module-networks.md]]** — the source's own second proposal, built: per-modifier functions with composition legality declared as a type check, which buys the productivity facet this page's length split measures.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the source's third proposal, built: quasi-discrete external memory for separate variable storage, which yields programs over data structures and no reported systematicity number.
- **[[wiki/concepts/meta-learning.md]]** — the source's first proposal ("expose the network to many learning environments regulated by similar rules"), stated here in 2018 as a conjecture and confirmed in 2023 on these splits.
- **[[wiki/concepts/program-induction.md]]** — the alternative the source argues for in words: a model that operates in "rule space" (`translate(x and y) = translate(x) translate(y)`) needs no learning at test time, which is the program-induction claim reached from a failure analysis rather than from a prior.
- **[[wiki/entities/arc-agi.md]]** — the opposite end of the split-design axis: this page declares exactly what is withheld (a length range, a verb's composed uses) so a failure is attributable to the named generalisation, where ARC-AGI withholds the tasks themselves and returns one number that no split can decompose.
- **[[wiki/entities/pgm.md]]** — the visual match for this page's recombine-versus-extend cliff: a relation carried onto an unseen attribute fails there the way a modifier carried onto a verb seen only in isolation collapses to 1.2% here, one level up in the same hierarchy of held-out combinations.
