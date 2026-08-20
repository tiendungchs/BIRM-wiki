# Bayesian Program Learning (BPL)

**A concept is a simple stochastic program — a structured procedure that, when executed, generates new examples of the concept. Learning a concept is inferring that program from examples (Lake, Salakhutdinov & Tenenbaum 2015).**

BPL is the wiki's first worked instantiation of all three model-building ingredients at once: [[wiki/concepts/compositionality.md]], [[wiki/concepts/causal-model-building.md]] and learning-to-learn ([[wiki/concepts/meta-learning.md]]). It is also the wiki's first architecture whose headline result is *one-shot* rather than asymptotic.

> **Provenance.** Described second-hand through Lake, Ullman, Tenenbaum & Gershman 2017 (`raw/lake-2017-machines-learn-think-like-people.md`), which reports the model and its results; the primary source (Lake, Salakhutdinov & Tenenbaum 2015, *Science*) is not in `raw/`. Figures and numbers below are as reported there.

---

## Architecture

A hierarchy of generative levels. Only the top level is new for a new concept; everything below is shared.

| Level | Content | Shared across concepts? |
|---|---|---|
| **i. Primitives** | A library of primitive pen actions | Yes — learned in pre-training |
| **ii. Sub-parts** | Simpler movements composed from primitives | Yes |
| **iii. Parts** | Complex movements (strokes) built from sub-parts | Yes |
| **iv. Object template** | Parts plus **relations** (`attached along`, `attached at start`, spatial offsets) — a simple program | **No — this is the concept** |
| **v. Exemplars** | Tokens produced by running the program stochastically | Per-token |
| **vi. Raw data** | Rendered binary images | Per-token |

**Two senses of "model".** BPL as a whole is a generative model *over programs*; each inferred program is itself a generative model of one concept's tokens. Levels i–iii + relation types are the meta-graph; level iv is the instance-graph; levels v–vi are observations. This is the two-level hierarchy of [[wiki/concepts/latent-graph-discovery.md]] realized literally, with the level boundary drawn at *program vs. library*.

**Why it is causal, not merely generative.** The program's steps resemble the steps of writing — a concept is an abstract motor program. It sits at the causal end of the spectrum on [[wiki/concepts/causal-model-building.md]], though the source notes "even more causally faithful models are possible" (a real pen model rather than an abstract stroke).

---

## Results

| Task | Result |
|---|---|
| **One-shot classification** (novel character, one example, same-alphabet distractors) | Human-level; outperforms convolutional networks and Siamese-network approaches (Koch, Zemel & Salakhutdinov 2015) |
| **Generating new examples** | Passes a "visual Turing test" — human judges cannot reliably tell 9 human-drawn tokens from 9 BPL samples |
| **Parsing** into parts and relations | Produces human-like parses (Lake, Salakhutdinov & Tenenbaum 2012) |
| **Generating new concepts** in the style of an alphabet | Passes the same visual Turing test |
| **Pre-training required** | **5 alphabets (~150 character types)** suffices for human-level one-shot classification and generation |

**The comparison that matters.** With the same 5-alphabet pre-training, the best deep convolutional classifiers have ~5× the human error rate (**23% vs 4%**); with 6× more pre-training data (30 alphabets) they are still 2–3× worse. The claim is therefore about *sample efficiency of the learning-to-learn stage*, not about ceiling performance.

---

## Comparison

| Model | Representation | One-shot? | Generates? | Parses? | Creates new concepts? |
|---|---|---|---|---|---|
| **BPL** | Stochastic program over parts, sub-parts, relations | ✓ human-level | ✓ passes visual Turing test | ✓ human-like | ✓ |
| Convolutional classifier | Discriminative feature hierarchy | ✗ (23% error at matched pre-training) | ✗ | ✗ | ✗ |
| Matching networks (Vinyals et al. 2016) | Learned metric / attention over a support set | ✓ *across* alphabets; never directly compared with BPL's harder within-alphabet setting | ✗ | ✗ | ✗ |
| Recurrent handwriting generator (Graves 2014) | Sequence model over pen trajectories | ✗ — large corpus needed | ✓ impressive styles | ✗ | ✗ — not applied to other tasks |
| DRAW / one-shot DRAW (Gregor et al. 2015; Rezende et al. 2016) | Recurrent generation through an attentional window | ✓ partially | ✓ but **generalizes too broadly**, in non-human-like ways | ✗ | unclear; not shown to pass the visual Turing tests |

The row structure *is* the richness criterion of [[wiki/concepts/causal-model-building.md]]: the discriminating evidence between these models is the number of query types one representation supports, not accuracy on the first column.

---

## Limitations

| Limitation | Statement |
|---|---|
| **Poorer relational repertoire than people** | Both people and model represent characters as strokes plus relations, but "people have a far richer repertoire of structural relations between strokes" |
| **No integration across multiple examples** | People combine several tokens of a character to infer which elements are *optional* (the cross-bar on a '7'), merging variants into one coherent representation; BPL does not |
| **Some structure is built in, not learned** | Important generalization-supporting structure "is built in to the prior and not learned from the background pre-training, whereas people might learn this knowledge" — so BPL's learning-to-learn is shallower than the human case |
| **Inference cost** | Inference over programs is an intractable search in general; this is the cost [[wiki/concepts/amortized-inference.md]] exists to pay down |
| **Domain scope** | Demonstrated on handwritten characters. Analogous claims for speech (phonemes) and gestures are stated, not shown |

---

## Scoring against the hardness sources

Against the six sources of [[wiki/concepts/latent-graph-discovery.md]]:

| Source | Reached? |
|---|---|
| 1. Two-level entanglement | **Yes, by construction** — library vs. program is an explicit factorization, and it is one of the very few in the wiki that is *architectural* rather than emergent |
| 2. Unknown vocabulary | **Partly** — primitives are learned in pre-training, but the *form* of the vocabulary (strokes, relations of given types) is given by the prior |
| 3. Observation aliasing | Not addressed — the domain has no path-dependent identity |
| 4. Simultaneity | Not addressed — clean discovery-then-use separation |
| 5. Spurious edges | **Partly** — the causal (motor) parameterization makes the appearance-only rule inexpressible, which is the architecture lever of [[wiki/concepts/shortcut-learning.md]] used deliberately. Never tested under distribution shift, so unscored by gap G17's standard |
| 6. Non-stationary topology | Not applicable |

**(brainstorm)** The interesting entry is source 1. BPL is the wiki's clearest existence proof that a `g`/`x` factorization *can* be installed and pay off in sample efficiency — but it is installed by the modeller, in a domain where the generative process is known and observable (stroke data). The open question the wiki should carry forward from it: does the factorization survive when the generator is unobserved, or is BPL's success an artefact of a domain where the causal trace can be recorded?

---

## Connections

- **[[wiki/concepts/compositionality.md]]** — the worked five-level compositional hierarchy, and the evidence that re-use of parts and relations is what makes one-shot learning possible.
- **[[wiki/concepts/causal-model-building.md]]** — sits at the causal end of the generative spectrum (concepts as motor programs), and is the model the richness criterion was built around.
- **[[wiki/concepts/meta-learning.md]]** — learning-to-learn operating at *multiple levels of a hierarchical generative process*: primitives, sub-parts, relations, and the typical variability within a program, all learned in pre-training and reused per concept.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the two-level hierarchy made architectural: a shared library (meta-graph) and a per-concept program (instance-graph), with binding rather than learning at the instance level.
- **[[wiki/concepts/amortized-inference.md]]** — the standing cost: program inference is intractable in general, and the proposed remedy is a neural bottom-up proposer inside the structured model.
- **[[wiki/concepts/shortcut-learning.md]]** — a deliberate use of the architecture lever: parameterizing concepts by the production process makes appearance-only rules inexpressible, at the price of needing causal (stroke) data.
- **[[wiki/concepts/core-knowledge.md]]** — the same "format installed, details learned" pattern as the number system, applied to a learned domain: the relation *types* are given by the prior, the primitive library is learned.
- **[[wiki/entities/aixi.md]]** — the same program-induction framing at the tractable end: BPL restricts the program space by hand to make search feasible, where AIXI keeps the full computable class and loses computability.
- **[[wiki/entities/arc-agi.md]]** — the same library-plus-instance-program architecture set as a benchmark rather than a model, with the one difference that decides the problem: ARC forbids authoring the primitive library, which is what this page does by hand.
- **[[wiki/entities/hbtom.md]]** — the sibling architecture from the same programme, with the hierarchy placed over *agents* rather than over motor programs; both make the meta/instance split structural, and both are handed their primitive vocabulary.
- **[[wiki/entities/neuromatch.md]]** — the discriminative counterpart for the same question ("which stored structure accounts for this instance?"): it buys millisecond retrieval with an un-flagged error rate where program search buys a posterior with search cost.
- **[[wiki/concepts/program-induction.md]]** — the reduction this page instantiates at the tractable end, and the source of the four standing costs it pays: an authored library, intractable search, a length prior known to be wrong, and one bit per rejected candidate.
- **[[wiki/concepts/language-of-thought.md]]** — a probabilistic-language-of-thought instance in all but name: a prior over structured expressions with concepts as posterior programs, which is the format claim made in a domain where the generative process is observable.
