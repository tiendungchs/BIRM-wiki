# MLC — Meta-Learning for Compositionality

**A standard 1.4M-parameter sequence-to-sequence transformer, meta-trained over a stream of episodes each defined by a randomly generated *interpretation grammar* that the network never sees, so that at test — weights frozen, no task-specific parameters — it infers word meanings from in-context study examples and composes them systematically (Lake & Baroni 2023).**

> **Provenance.** `raw/lake-2023-meta-learning-compositionality.md`, *Nature* 623 (2023). Framed as an answer to Fodor & Pylyshyn 1988's systematicity challenge ([[wiki/concepts/language-of-thought.md]]). Supplementary Information is a separate source and is not yet ingested; Tables 1–2 are figure-only in the source text, so the log-likelihood comparisons below are recorded as an *ordering* with the paper's own significance thresholds, not as numbers.

The reason this page exists: [[wiki/entities/pcfg-set.md]] measured systematicity in three standard sequence architectures trained i.i.d. and got 0.53 / 0.56 / 0.72 on data generated *by* the intended compositional rule. MLC holds the architecture class fixed, changes only what the outer loop samples, and gets 100%. **The wiki's locus for systematicity therefore moves from the architecture slot to the objective slot** ([[wiki/concepts/neuroscience-ai-transfer.md]]'s three-slot sort, G30).

---

## Architecture

| Component | Setting |
|---|---|
| Encoder / decoder | Standard seq2seq transformer, 3 layers each, 8 heads, embedding 128, feed-forward 512, GELU, sinusoidal positional encodings **added** to content embeddings |
| Size | ~1.4 million parameters — three orders below any language model the wiki cites |
| Encoder input | One concatenated source string: the query input **plus the full set of study (support) input/output pairs**, separated by `∣` and `→` |
| Encoder vocabulary | 8 words, 6 abstract outputs (coloured circles), 2 separator symbols |
| Test-time adaptation | **None.** Weights frozen, no task-specific parameters — all adaptation is in-context |
| Optimizer | Adam, cross-entropy averaged over tokens, batch 25 *episodes* (≈600 sequences), 50 epochs, lr 1e-3 with one warm-up epoch then linear decay to 5e-5, dropout 0.1, one Titan RTX |

Nothing here is new. The architecture is deliberately the null hypothesis: "innovations in the transformer architecture that were not envisioned in Fodor and Pylyshyn's arguments (variable-length input, parameter sharing, self-attention)" are load-bearing, but they are 2017 technology, and the same components trained without episodes score 0%.

---

## The episode generator — the actual contribution

Each of 100,000 training episodes is a *different* seq2seq task defined by a latent **interpretation grammar**: a set of compositional rewrite rules mapping instruction strings to output sequences, applied recursively until all symbols are terminal. The grammar is never observed and must be inferred implicitly from the study examples.

| Sampling step | What is drawn |
|---|---|
| Primitive rules (4) | Random pairing of individual input symbols to output symbols, **without replacement** |
| Function rules (3) | Left-hand side: which input symbol is the function name; arity 1 or 2 (name *after* the argument, or *between* arguments); and per argument, whether it accepts an arbitrary non-empty string (`x_i`) or only primitives (`u_i`) |
| Function bodies | Right-hand side: an arbitrary string of length ≤8 mixing and repeating the left-hand-side arguments (`⟦x₁⟧⟦u₁⟧⟦x₁⟧⟦u₁⟧⟦u₁⟧`), each argument evaluated **recursively** then concatenated |
| Fixed rule | One rule is the same in every episode: iconic left-to-right concatenation |
| Examples | 14 study + 10 query, sampled as arbitrary unique input strings (length ≤8) parseable to outputs (length ≤8); study order shuffled per episode; output symbols corrupted uniformly at random with p = 0.01 |

Three details are portable and none of them is about transformers:

**1. Episode-level leakage must be quotiented by the symmetry group.** Validation grammars count as new only if they match no meta-training grammar *under any permutation of rule ordering*; the gold grammar used for the human comparison additionally must not match under any permutation of input/output symbol assignments. Deduplicating episodes by surface identity would have silently leaked the test task — every architecture in the wiki that samples tasks from a generator has this hole and none of them states a check for it.

**2. The auxiliary copy task is load-bearing, not decorative.** "It is important to pass each study example (input sequence only) as an additional query." The network must therefore solve *retrieval-and-reproduce* — locate the study example matching the query and emit its output — jointly with generalisation, in one forward pass and one set of weights. This is the two-stage retrieve-then-map decomposition of [[wiki/entities/macfac.md]] fused into a single amortised pass, with the cheap stage supplied as an auxiliary objective rather than as a separate mechanism.

**3. An inductive bias is installed by *sampling it at a measured rate*, not by writing it down.** Each query is paired with the grammar's algebraic output in 80% of cases (matching the measured human 80.7%) and with a heuristic in 20%: a fair coin between a stochastic **one-to-one translation** (each input symbol mapped to a single output symbol left-to-right, using an observed primitive mapping where one exists and an arbitrary symbol otherwise) and a **noisy rule application** (each binary function flips the roles of its two arguments with p = 0.5). The prior lives in the episode sampler at a calibrated frequency — a third route alongside "install the prior in the architecture" ([[wiki/concepts/core-knowledge.md]]) and "learn it from the data".

---

## Human behaviour, and MLC against it

Few-shot instruction learning (n = 25 after catch-trial exclusion): a curriculum of 14 study instructions in a pseudolanguage — four primitives (`dax` → RED), three functions (`fep` repeats its preceding primitive three times; `blicket` alternates its two primitive arguments; `kiki` concatenates its two arbitrary-string arguments in reverse order and takes scope over the others) — then 10 query instructions with the study items left on screen (so the measurement is generalisation without a working-memory load). Chance is 2.8% for a two-length output *when the length is known*, exponentially less otherwise.

| Quantity | Human | MLC (sampled) |
|---|---|---|
| Exact match to the algebraic standard | 80.7% | 82.4% |
| Correct on output sequences **longer than any seen in study** | 72.5% | 77.8% |
| Errors that are one-to-one translations | 24.4% of all errors | 56.3% |
| Errors on function 3 showing iconic concatenation | 23.3% | 13.8% |
| Per-item difficulty | — | Pearson r = 0.788, P = 0.031, n = 10 items |
| Best run, greedy decoding | — | **100% exact match**, plus correct inference of rules absent from meta-training |

Open-ended task (n = 29): guess outputs for seven instructions with **no examples at all**, so a priori preferences show through. Three biases, quantified for the first time in the wiki:

| Bias | Statement | Humans | MLC |
|---|---|---|---|
| **One-to-one** | Each input word maps to exactly one output symbol — treat everything as a primitive | 62.1% | 66.0% |
| **Iconic concatenation** | Preserve input word order in output symbol order | 79.3% | 85.0% |
| **Mutual exclusivity** | Unique words get unique meanings | 93.1% | 99.0% |
| Modal response pattern (all three simultaneously) | — | 58.6% of participants | 65.0% of samples |

Because participants answered all seven queries on one page and stayed consistent across them, MLC cannot answer independently; it factorises `P(y₁…y₇ ∣ x₁…x₇) = ∏ᵢ P(yᵢ ∣ xᵢ, x_{<i}, y_{<i})`, **feeding its own earlier answers back in as study examples**. Consistency across a response set is therefore produced by self-conditioning rather than by a constraint solver — the cheapest mechanism in the wiki for global coherence over a set of outputs.

---

## Model comparison (log-likelihood of human responses)

Significance thresholds are the paper's own: ≥8 natural log points (few-shot), ≥57 (open-ended, five-fold cross-validation over held-out participants).

| Model | Few-shot | Open-ended |
|---|---|---|
| **MLC (joint)** — one transformer optimized on both tasks plus "bridge" episodes with 0–14 study examples so episode type is not inferable from support-set size | **best overall** | **best overall** |
| **MLC** | beats symbolic (oracle), MLC (algebraic only), basic seq2seq, MLC (copy only) | beats *everything*, including symbolic (oracle/biases) |
| Symbolic (oracle/biases) — gold grammar + the same bias transformation | comparable to MLC | loses by ≥57 nats |
| Symbolic (oracle) — gold grammar + a fitted uniform lapse rate | loses | loses |
| MLC (algebraic only) — same episodes, strictly algebraic targets | loses | loses |
| Basic seq2seq — same architecture, no study examples in the input, trained on the 14 study instructions | loses; **0% exact match on all 10 runs** even with parameters selected on *test* loss | loses |
| MLC (copy only) — meta-trained only to match a query to an identical study example | loses | loses |

Two readings the wiki should carry. First, **the rigid-symbolic model is not the ceiling for modelling humans**: people are systematic *and* biased, and a model that is perfectly systematic must explain every deviation as an arbitrary lapse. Second, the few-shot task cannot separate MLC from a bias-augmented oracle — only the open-ended task can, because there the biases *are* the whole signal and a symbolic model that hard-codes three of them cannot fit the fourth thing people do.

---

## Machine-learning benchmarks: the facet split

SCAN (Systematic Compositionality benchmark: instructions → action sequences) and COGS (Compositional Generalization Challenge based on Semantic Interpretation: sentences → logical forms). Here the meta-learning is far cruder — **surface-level word-type permutation** of an existing corpus, no new data:

- SCAN: permute the six input primitives among themselves and the six output actions among themselves, per episode; functional words (`twice`, `thrice`, `around`, `opposite`, `and`, `after`) keep stable meanings and may live in the weights. 10 study + 2 query per episode, one of which is the copy task; 5% of episodes left unpermuted to break the symmetry that otherwise slows optimisation.
- COGS: permute within lexical classes (406 common nouns, 103 proper nouns, 22 dative verbs, 21 infinitives) on both input and output sides, with the input↔output correspondence *never used*; study examples chosen to share the permuted word with the query. One concession to semantics: common nouns are swapped for proper nouns with p = 0.01, with the matching structural edit to the logical form.

| Split | MLC | Basic seq2seq |
|---|---|---|
| SCAN `add jump`, `around right`, `opposite right` | ≤ **0.22%** error | ≥ 7× higher |
| COGS, 18 lexical generalization types | **0.87%** error | ≥ 7× higher |
| SCAN **length** split | **100% error** | — |
| COGS, 3 structural generalization types | **100% error** | — |

**This is the result to steal, and it is a statement about the sampler, not the model.** The same method, same architecture, gets 77.8% on longer-than-trained outputs in the instruction task — where episodes freely sampled input and output lengths up to 8 — and **exactly 0%** on SCAN's length split, where the episode transform is a symbol permutation that never varies structure or length. Hupkes et al.'s facets are therefore not properties of an architecture at all: *which facet you get is decided by what the episode generator varies*. Systematicity was bought because the sampler varied word→meaning assignments; productivity was not bought because nothing varied length. The authors say so explicitly — "the right meta-training procedure can promote productivity — a challenge we leave to future work."

---

## Handling long support sets: query-conditioned per-example encoding

Concatenating a query with 8–10 COGS study examples reaches source length S ≈ 1,500, and encoder self-attention is `O(S²)`. The fix:

```
for each of m study examples:  encode( [query input] ++ [study_i] )   → contextual embeddings
                              tag each embedding with an index embedding for i
                              set-union all m embedding sets → one message to the decoder
decoder cross-attention: O(S·T), and T ≪ S because the target has no study examples in it
```

Cost drops from `O(S²)` to `m·O((q+s)²)`. **The architectural content is that each memory is encoded *in the context of the query* and study examples never attend to one another** — cross-example integration is deferred entirely to decoder cross-attention. **(brainstorm)** That is a different point on the retrieval design space from everything in [[wiki/concepts/retrieval-capacity.md]]: a precomputed key per item cannot be query-conditioned, and joint scoring over the whole set is `O(S²)`; this is the middle option — per-item encoding that is query-aware but item-independent, which is exactly the regime where a rule over an unbounded instance set is *not* expressible, since no two study examples can be compared before the decoder sees them.

---

## Limitations

- **The boundary, stated precisely.** "Meta-learning succeeds when generalization makes a new episode **in-distribution with respect to the training episodes**, even when the specific test items are out-of-distribution with respect to the study examples **in the episode**. However, meta-learning alone will not allow a standard network to generalize to episodes that are in turn out-of-distribution with respect to the ones presented during meta-learning." Two nested notions of OOD, and only the inner one is bought. This is [[wiki/concepts/meta-learning.md]]'s knowledge-boundedness limit measured rather than asserted.
- **No mechanism for emitting new symbols** (Marcus's version of the challenge). Symbols introduced through the study examples would need an added pointer/copy mechanism.
- **Biases it was not optimized for do not transfer** — an additional behavioural experiment in the Supplementary Information shows MLC failing to generalize to nuances of the biases outside its meta-training. The installed-by-sampling route buys exactly what was sampled.
- **Developmentally implausible as stated.** Optimizing over many random grammar tasks is not what a child does; the defended claim is the weaker one — that systematicity can be honed by incentive and practice.
- **Untested on natural language, at scale, or in any other modality.** The proposal for scale is to alternate next-token pretraining with MLC meta-training episodes that continually introduce novel words.
- **The behavioural comparison is generous to humans in one respect and to MLC in another**: study items stayed on screen (no memory load), while MLC's 82.4% is an average over 100 random word/colour assignments and its 100% is the best of 10 runs.
- **GPT-4 is still challenged** on this material (Supplementary Information 3), so the result is not that scale solved it.

---

## Comparison

| System | Where systematicity comes from | Systematicity | Productivity |
|---|---|---|---|
| **MLC** | The episode distribution (a meta-grammar sampling latent interpretation grammars) | 100% on the human task; ≤0.22% error on SCAN lexical splits | 77.8% where the sampler varied length; **0%** where it did not |
| [[wiki/entities/pcfg-set.md]] architectures (LSTMS2S/ConvS2S/Transformer, i.i.d.) | Nowhere — assumed to follow from the data being compositionally generated | 0.53 / 0.56 / 0.72 | 0.30 / 0.31 / 0.50 |
| Symbolic (oracle) | Stipulated — the gold grammar is given | Perfect by construction | Perfect by construction |
| [[wiki/entities/bayesian-program-learning.md]] | Stipulated — a hand-built compositional generative hierarchy over pen primitives | By construction | By construction |
| [[wiki/entities/neo-neural-theorizer.md]] (OTIB) | An induced vocabulary plus one shared executor, trained per domain | — | 0.845 transfer, 4–8 primitives from 1–3 |

The first two rows are the matched pair: **same architecture family, same "the data is compositional" premise, opposite outcome, and the only difference is whether the training signal arrived as a static corpus or as a stream of tasks.**

---

## Connections

- **[[wiki/concepts/meta-learning.md]]** — the sharpest instance in the wiki of the outer loop buying a *structural* competence rather than a speed-up, and the source of the precise two-level statement of the knowledge-boundedness limit (in-distribution *episode*, out-of-distribution *item*).
- **[[wiki/concepts/compositionality.md]]** — relocates systematicity from the architecture to the episode sampler, and shows the five facets come apart along the same seam: what the generator varies is what the model gets.
- **[[wiki/entities/pcfg-set.md]]** — the matched control: the same architecture class scored on the same facets after i.i.d. training on compositionally generated data, failing systematicity where MLC passes it.
- **[[wiki/concepts/language-of-thought.md]]** — the Fodor & Pylyshyn challenge answered on its own terms for systematicity and conceded for productivity, with a bonus finding the LoT position does not predict: a perfectly systematic symbolic model is a *worse* account of human behaviour than a biased neural one.
- **[[wiki/concepts/program-induction.md]]** — the counter-case where the grammar is inferred but never emitted: MLC recovers an interpretation grammar's behaviour without representing the program, so execution accuracy and program recovery are separable.
- **[[wiki/entities/macfac.md]]** — the retrieve-then-map decomposition fused into a single amortised forward pass, with the cheap stage installed as an auxiliary copy objective instead of as a separate filter.
- **[[wiki/entities/transformer.md]]** — the architecture used unmodified, and the demonstration that its compositional ceiling is set by the training distribution rather than by attention.
- **[[wiki/concepts/core-knowledge.md]]** — the third route to installing a prior: sample it into the task distribution at a measured frequency, rather than writing it into the architecture or hoping the data supplies it.
- **[[wiki/concepts/objective-identifiability.md]]** — the partial counterweight to G16: the intended rule *is* selectable from data, but only when the data arrive as a stream of tasks whose latent parameter changes, not as a corpus generated by one grammar.
- **[[wiki/concepts/shortcut-learning.md]]** — permuting word meanings every episode makes the surface word→meaning association worthless to store in weights, so the shortcut is destroyed by the sampler rather than penalised by the loss.
- **[[wiki/concepts/retrieval-capacity.md]]** — the `m`-fold encoder: each memory encoded in the context of the query but independently of every other memory, a middle point between a precomputed key per item and joint scoring over the whole set.
- **[[wiki/concepts/amortized-inference.md]]** — grammar inference amortised into a frozen forward pass: the posterior over interpretation grammars is never represented, only its consequence for the query.
- **[[wiki/entities/arc-agi.md]]** — the same shape of task (infer a latent transformation rule from a handful of demonstrations, apply it to a held-out input) with the episode generator missing; MLC's result is an argument that ARC's difficulty is partly the absence of a `p(T)` to meta-train on.
- **[[wiki/concepts/analogical-mapping.md]]** — the open-ended task's self-conditioning is mapping-by-consistency without a mapper: each answer becomes a study example for the next, so correspondences are enforced by conditioning rather than by a structural constraint network.
