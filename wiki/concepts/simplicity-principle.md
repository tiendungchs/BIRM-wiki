# Simplicity Principle

**The cognitive hypothesis that perception, language learning, categorisation and inference each choose, among the infinitely many patterns consistent with finite data, the one giving the shortest description of the data. Description length is the pattern's own code plus the data's code given the pattern. The claim is both normative (this choice solves the problem of induction) and descriptive (minds make this choice).**

[[wiki/concepts/universal-induction.md]] holds the formal ideal: the `2^−K` prior, dominance and convergence. This page holds the same prior offered as a *psychological* hypothesis, the evidence for it, and the two obstacles that stop it making precise predictions without a model of representation and search. Those two obstacles are the empirical forms of the ideal's machine dependence and its uncomputability.

> **Provenance.** Chater & Vitányi 2003, *Simplicity: a unifying principle in cognitive science?* (Trends in Cognitive Sciences 7(1):19–22; `raw/chater-2003-simplicity-unifying-principle-in-cognitive-science.md`). It is a short review. Every empirical result below is a citation in the review and is **second-hand**; none of the cited studies is ingested. The clip is complete, but Figure 1 and Box 1 Figure I survive only as captions and prose descriptions.

---

## Formalism

| Object | Statement | Reading |
|---|---|---|
| **Problem of induction** | Infinitely many curves, sequence continuations, grammars and perceptual organisations fit any finite data set. Enriching the input removes some of them and always leaves infinitely many | No amount of data selects the pattern. The selection must come from a principle, i.e. from a prior. This is the cognitive form of `G16` (the factorisation must be paid for with bias) |
| **Two criteria for a principle** | (1) It must solve induction. (2) It must fit empirical data on cognition | The review argues that simplicity meets (1) on mathematical grounds and (2) on the evidence table below |
| **Shannon code length** | `ℓ(x) = log₂(1/p(x))` | Applies where items carry probabilities: repeated low-level features, phonemes, words |
| **Kolmogorov complexity** | `K(x)` = length of the shortest program printing `x` on a universal machine. It is machine-invariant up to an additive constant and agrees with Shannon code length wherever Shannon applies | Applies to **individual objects**, with no probability attached |
| **Two-part code** (implicit in Box 1) | `L(H) + L(D | H)`: complexity of the pattern plus misfit of the data given the pattern | Data fit and pattern simplicity are traded in one currency (Box 1 cases a and b) |
| **Justifications for criterion (1)** (Vitányi & Li 2000) | (i) Under general conditions the shortest code is also the most probable hypothesis under the universal prior. (ii) Predicting from the shortest code converges, with high probability, on largely correct predictions. (iii) Description-length methods are in wide use in machine learning and statistics (decision trees, minimum message length, Rissanen's stochastic complexity) | (i) is why the review treats the simplicity principle and the Bayesian likelihood principle as **mathematically close** (Chater 1996). The remaining dispute is where the prior comes from |
| **Similarity as transformation** (Hahn et al. 2002) | The similarity of `x` and `y` is a decreasing function of the complexity of the simplest transformation that turns one representation into the other. In the wiki's notation, ≈ `K(y | x)` | A third notion of similarity, beside spatial distance and feature overlap. Its empirical predictions are reported to be confirmed where those two accounts fail |
| **Universal similarity metric** (Rathmanner & Hutter 2011, citing Cilibrasi & Vitányi) | `S(x,y) = max{K(x\|y), K(y\|x)} / max{K(x), K(y)}`: ≈0 for identical objects, ≈1 for unrelated ones. Computed by substituting a real compressor (Lempel–Ziv, gzip, bzip, Context Tree Weighting) for `K` | The computable, symmetrised and normalised form of similarity-as-transformation. Reported second-hand: from DNA alone it recovers the evolutionary tree of 24 mammals, it builds a tree of 50+ languages, and it groups music by composer and files by type. It needs no features and no alignment |
| **Shepard's universal law of generalisation** | Confusion probability is a negative exponential of distance in an internal space. Chater & Vitányi 2002 derive it from similarity-as-transformation-complexity, "with minimal additional assumptions" | **(brainstorm)** The natural reading: with distance `d = K(y | x)` in bits, `e^{−d}` is (up to base) `2^{−K(y|x)}`, the universal prior probability of the transformation. The derivation itself is not in this source |

**Scope note.** The review sets lossy compression aside explicitly. Everything here is lossless: the description must allow the data to be reconstructed. The wiki's lossy accounts ([[wiki/concepts/information-bottleneck.md]], the action-sufficient approximations on [[wiki/concepts/broadcast-hierarchy.md]]) are outside its claim.

---

## Evidence — where simplicity has been used as the organising principle

| Domain | Data → code | Finding the review cites | Machine counterpart |
|---|---|---|---|
| **Low-level perception** | Images → early-vision filters | Receptive fields and lateral inhibition look adapted to compress visual input (Blakemore 1990); sparse coding in primary visual cortex (Olshausen & Field 1997) | Image compression |
| **High-level perception** | Early-vision output → higher structure | Gestalt closure, good continuation and common fate read as a simplicity preference; simple items are easier to detect in noise (Hochberg & McAlister 1953; van der Helm & Leeuwenberg 1996) | Pattern theory (Mumford 1996) |
| **Structure and memory** | Stimulus → code | The more structure people find, the easier a stimulus is to process and remember (Garner 1974) and the less random it looks (Falk & Konold 1997) | — |
| **Concept learning** | Examples → Boolean rule | Learning speed for Boolean concepts (`A ∨ B ∨ C`, `A ∧ (B ∨ C)` …) is closely predicted by the shortest formula length (Feldman 2000) | Rule induction |
| **Language acquisition** | Linguistic input → structure | Phonology, morphology (Goldsmith 2001, 2002), word segmentation (Brent & Cartwright 1996) and grammar induction (Grünwald 1996) modelled as code-length minimisation | Text compression |
| **Similarity and generalisation** | Representation pair → transformation | Similarity as transformation (Hahn et al. 2002); Shepard's law derived (Chater & Vitányi 2002) | Information distance (Bennett et al. 1998) |
| **Categorisation** | Items → clusters | Unsupervised human categorisation by compression (Pothos & Chater 2002) | — |
| **Scientific inference** | Data → theory | Ockham, Newton, Mach's principle of economy | Minimum message length (Wallace & Freeman 1987), MDL (Rissanen 1989) |

### Box 1 — four perceptual cases, four distinct terms in the code

| Case | Input → preferred reading | Term doing the work |
|---|---|---|
| **a. Data fit** | A roughly triangular input is read as a triangle, not as a square | `L(D | H)`: a reading that fits well gives a short residual code |
| **b. Pattern simplicity** | A straight 2-D line is read as a line, not as an irregular 3-D curve that projects to a line from one exact viewpoint | `L(H)`: the irregular curve is a long pattern, however perfect its fit |
| **c. Precision** | A small ellipse is read as a frontal ellipse, not as a larger similar ellipse at a steep slant, although fit and pattern complexity are equal | The slant angle has to be coded **more precisely** to fit equally well, which costs bits. Stable interpretations are cheap |
| **d. Causal inference** | A cube-like projection is read as a rigid wire cube; an irregular figure as having possibly flexible joints | A simple arrangement that held by accident would be a coincidence, so simplicity licenses a **causal** link: rigid joints, as 100 heads licenses a biased coin |

---

## The two obstacles to testing it

Precise, non-asymptotic predictions need a full cognitive model, because of two problems.

| Problem | Statement | Formal root |
|---|---|---|
| **Representation** | Language invariance holds only in the limit. At finite data, which regularities are detectable, and so which pattern is shortest, depends on the mental representation, and that is contested | Machine dependence of `K` ([[wiki/concepts/universal-induction.md]]); the reference machine is the hypothesis space ([[wiki/concepts/inductive-bias.md]]) |
| **Search** | The system may prefer the simplest pattern *it can find* and fail to find the simplest one | Uncomputability of `K`; bounded optimality ([[wiki/concepts/resource-rationality.md]]) |

**Counter-evidence the review records itself.** Early vision looks compressive, yet theoretical and empirical arguments (Gardner-Medwin 2001; Olshausen & Field 1997) say the brain also uses **highly redundant sparse** codes. The review leaves this unresolved. **(brainstorm)** The two claims sit at different levels. Simplicity governs which *hypothesis* is chosen. Redundancy describes the *format* that carries it, and a format can be redundant while the hypothesis selection is simplicity-driven ([[wiki/concepts/sparse-distributed-representations.md]]).

---

## Design reading (brainstorm)

- **Description length selects structure only when the structure is in the code language.** In case d the 3-D cube is the short reading *because* the code has 3-D rigid-body primitives. In 2-D primitives the irregular planar figure would be as short. This is the representation problem seen from `G26`'s side: the shortest program recovers the graph when, and only when, the reference machine is written in the graph's vocabulary. The same mechanism appears on [[wiki/concepts/nameability.md]] (a natural-language vocabulary that already carries the world's concepts) and in NEO's shared executor ([[wiki/entities/neo-neural-theorizer.md]]).
- **Case c is the per-parameter price.** "The angle must be specified more precisely" is the `½log₂N`-bits-per-effective-parameter cost on [[wiki/concepts/predictive-information.md]] applied to one percept: an interpretation whose fit is sensitive to a parameter (high Fisher information) pays for that parameter's precision. A generic-viewpoint preference therefore falls out of the code, with no separate rule.
- **Case d is latent-edge inference by compression.** Positing a hidden causal link (rigid joint, biased coin) is adding an edge to the latent graph because the data compress better with it than as coincidence. For [[wiki/concepts/latent-graph-discovery.md]] this is a criterion for edge creation: add the edge when the bits it saves on the data exceed its own cost.
- **Feldman 2000 is the closed-domain precedent for `G31`'s validation loop.** A computable complexity (minimal Boolean formula length) predicts human learning difficulty. It validates code length under an experimenter-fixed representation, not generalisation difficulty, so it shows the loop can be run, not that `GD` is approximated.
- **Similarity-as-transformation gives retrieval a third metric.** The wiki's similarity machinery is either feature/vector overlap ([[wiki/concepts/vector-symbolic-binding.md]]) or structural alignment ([[wiki/concepts/analogical-mapping.md]]). `≈ K(y | x)` scores the *edit* between two structures. A store keyed by it would retrieve cases that are one cheap transformation away rather than cases that share content. The universal similarity metric above is the computable version, already run with off-the-shelf compressors. A retrieval experiment could therefore start with a compressor as the key function, before anything is learned.

---

## Open problems

- **No non-asymptotic test.** Every prediction depends on an assumed representation and an assumed search, so the principle has not been tested against a rival with both held fixed.
- **The source of the prior is undecided.** Simplicity (code-language prior) and likelihood (environment-frequency prior) coincide formally. They diverge only when the code language and the environment statistics disagree, and the review names no experiment that separates them.
- **Lossless only.** The review excludes lossy compression, while the wiki's cortical and bottleneck accounts are lossy. How the principle extends to a task-defined distortion is not addressed here.
- **Compression and redundancy coexist in early vision** without a reconciling account (see above).
- **Passive only.** Every case is perception or passive inference. The active-case failure on [[wiki/concepts/universal-induction.md]] (no `K(µ)`-only guarantee once actions shape observations) is not discussed.

---

## Connections

- **[[wiki/concepts/universal-induction.md]]** — the formal ideal this page tests as psychology: the review's justification (i) is that page's universal prior, and its representation and search problems are that page's machine dependence and uncomputability, recast as reasons the hypothesis makes no precise prediction without a cognitive model.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the measurement side of the same identity: `ℓ = log₂(1/p)` makes a predictor a compressor, so a model's code length is the computable stand-in for the simplicity this page attributes to the mind.
- **[[wiki/concepts/nameability.md]]** — the same correlation in an open domain: Feldman 2000 finds formula length predicts Boolean-concept learning speed, and nameability finds natural-language description length predicts ARC accuracy (`r = −0.50`); both measure code length in a representation chosen by the experimenter.
- **[[wiki/concepts/inductive-bias.md]]** — names this page's representation problem formally: the code language that decides which pattern is shortest is the hypothesis space `H`, so a simplicity prior is never bias-free at finite data.
- **[[wiki/concepts/resource-rationality.md]]** — names this page's search problem: "the simplest pattern it can find" is a bounded-optimal search over codes, so the principle's predictions depend on the search budget as well as on the prior.
- **[[wiki/concepts/predictive-information.md]]** — supplies the price behind Box 1 case c: an interpretation whose fit is sensitive to a parameter pays to specify it precisely, which is the `½log₂N` bits per effective parameter that source derives.
- **[[wiki/concepts/analogical-mapping.md]]** — similarity as the complexity of the simplest transformation between two representations is a third similarity metric beside feature overlap and structural alignment, and it scores the edit between structures rather than their shared content.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the counter-evidence the review records against compression in early vision: the brain also uses highly redundant sparse codes, which is reconcilable only if simplicity governs hypothesis selection and not code format (brainstorm).
- **[[wiki/concepts/latent-graph-discovery.md]]** — Box 1 case d is an edge-creation criterion: a hidden causal link is posited when the data compress better with it than as coincidence (brainstorm).
