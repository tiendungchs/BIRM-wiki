# OthelloGPT

**An 8-layer GPT trained only to predict legal Othello moves from a move sequence, which spontaneously builds a board-state representation — and that representation is *linearly* encoded once the labels are written in the model's own basis (Mine / Yours / Empty) rather than the human one (Black / White / Empty). Editing a single direction by vector addition changes the model's play as reliably as gradient-based editing, which makes this the wiki's first world-model claim that meets the intervention standard.**

> **Provenance.** Nanda, Lee & Wattenberg 2023, *Emergent Linear Representations in World Models of Self-Supervised Sequence Models* (`raw/nanda-2023-linear-representations-othello.md`), reanalysing the model and intervention benchmark of Li et al. 2022 (*Emergent World Representations*, the "synthetic" OthelloGPT). The transferable method lives on [[wiki/concepts/linear-representation-hypothesis.md]]; the instrument critique on [[wiki/concepts/representation-probing.md]].

---

## Setup

| Element | Choice |
|---|---|
| **Task** | Given move prefix `m_<t`, predict the next **legal** move. Moves in training are sampled **uniformly among legal moves**, not by a strategic policy — so the model is a legality predictor, not a player (contrast AlphaZero) |
| **Architecture** | 8 layers × 8 heads, `d = 512`, vocabulary of 60 tokens (one per playable square) |
| **What is *not* supplied** | No board, no rules, no notion of colour, flipping or adjacency. The only structure in the input is which square-token came in which order |
| **Probes** | Linear `p^λ(x_t^l) = softmax(W x_t^l)`, `W ∈ R^{512×3}`; non-linear `p^ν` = 2-layer MLP. One probe per layer; 3.5M game sequences available, converged after ≈100k; tested on 1,000 held-out games |
| **The one change from Li et al. 2022** | The *label set*. Li et al. classify each square as {Black, White, Empty}; Nanda et al. classify it **relative to whoever moves at that timestep** — {Mine, Yours, Empty}, so Black is `Mine` on odd plies and `Yours` on even ones |

---

## Result 1 — the representation was linear all along, under a different ontology

Board-state probe accuracy, by residual-stream index `x⁰ … x⁷` as printed by the source:

| Probe | x⁰ | x¹ | x² | x³ | x⁴ | x⁵ | x⁶ | x⁷ |
|---|---|---|---|---|---|---|---|---|
| Linear, on a **randomly initialised** GPT | 37.0 | 35.1 | 33.9 | 35.5 | 34.8 | 34.7 | 34.4 | 34.5 |
| Probabilistic prior (most likely colour per square) | 61.8 | | | | | | | |
| Linear {Black, White, Empty} | 62.2 | 74.8 | 74.9 | 75.0 | 75.0 | 74.9 | 74.8 | 74.4 |
| Non-linear {Black, White, Empty} | 63.4 | 88.6 | 93.3 | 96.3 | 97.5 | 98.3 | **98.7** | 98.3 |
| **Linear {Mine, Yours, Empty}** | 90.9 | 94.8 | 97.2 | 98.3 | 99.0 | 99.4 | **99.6** | 99.5 |

The absolute-colour linear probe saturates at ~75% and *stays there for six layers* — the signature of a genuinely missing feature, not of a weak decoder. Re-parameterising the same content into a player-relative frame moves a linear decoder above the MLP decoder at every layer. Two readings:

- **The prior result ("the world model is non-linear") was a statement about the experimenter's ontology, not about the model.** The MLP probe was spending its extra capacity computing `colour → relative` parity, i.e. re-deriving the basis the model already had.
- **A failed linear probe therefore has three explanations, not two**: the content is absent, the content is non-linearly coded, or *the content is linearly coded in a basis the experimenter did not enumerate*. Only the third is cheap to test and nobody tests it. See tension **T157**.

Corroborating architectural evidence for the relative frame: individual first-layer attention heads attend **only to even or only to odd timesteps** — heads 4 and 7 to My moves, heads 1, 3 and 8 to Yours — so the parity split is in the circuit, not only in the probe.

---

## Result 2 — steering by vector addition, at parity with gradient editing

The intervention is a single addition into the residual stream at **every** layer:

```
x' ← x + α · p^λ_d(x),   d ∈ {Mine, Yours, Empty}
```

Same 1,000-case benchmark and metric as Li et al. 2022: force a counterfactual board `B'`, take the top-`N` post-intervention moves where `N = |legal(B')|`, count false positives + negatives.

| Manipulation | Null intervention | Gradient-based edit through a non-linear probe (Li et al. 2022) | **Single vector addition** |
|---|---|---|---|
| Flip a square's colour | 2.723 errors | 0.12 | **0.10** |
| Erase a played square to Empty | 2.73 errors | 0.11 | **0.02** |
| Remove `Flipped` from one just-captured square | 1.686 | — | 0.486 |

Three things this buys that a probe alone does not:

| Claim | Now licensed |
|---|---|
| "The content is present" | Yes (probe) |
| "The content is *used*" | **Yes** — behaviour moves in the predicted direction, including on boards unreachable by legal play, so the effect is not a re-entry of a training correlation |
| "The direction *means* Mine / Yours / Empty" | **Yes** — the semantic label and the causal handle are the same vector; pushing along `Empty` erases, pushing along `Mine` flips. A probe direction that were merely correlated would not act |
| "This is the whole mechanism" | **No** — see Result 4 |

**Why the simplification matters more than the tie.** Li et al. needed iterative gradient descent against an MLP probe to move the model; here one addition of a fitted direction does the same job, better on the `Empty` case. Interpretability that lands on a *direction* yields a control primitive for free; interpretability that lands on a *decoder* does not. This is the same object as the activation-steering / task-vector line in language models, arrived at with a ground-truth world to check against.

---

## Result 3 — the `Empty` feature is a linear function of the token embeddings, and the circuit is readable

A square, once played, can change colour but never become empty again — so `Empty` is `Not-Played`, and "played" is broadcast by attention from the move token itself:

```
Played_h(m) = Emb[m] @ Att_h.V @ Att_h.O
max_h CosSim( Played_h(m), p^λ_Empty(m) )  =  −0.862   (mean over all 60 squares)
```

A near-perfect *anti*-alignment computed **from the weights alone, with no forward pass**. Consequences: `Empty` is available by `x^{0_mid}` — after the first attention sub-layer, before the first MLP — with binary Empty/Not-Empty accuracy rising 76.8% → 98.9% across that one sub-layer. The activation-side confirmation (clean/corrupt move sequences, `N = 4,569`, difference in probed `P(Empty)` per head) localises the same effect to the parity-specialised heads of layer 0.

**The `Flipped` feature is the surprise.** A separate linear probe classifies which squares are *being captured this timestep* — `F1` 74.8 → 96.3 across layers, ≥91.6 by layer 2 — and subtracting that direction changes play (0.486 vs 1.686 null). `Flipped` is the **difference** between consecutive board states. A recurrent system would naturally hold a state and apply deltas; a transformer cannot iterate, so it computes the delta as a *parallel* feature alongside the state it would explain. **(brainstorm)** That is a concrete architectural signature worth looking for elsewhere: where recurrence is unavailable, a model may represent `Δstate` as a first-class feature and reconcile it with `state` by addition in the residual stream — an unrolled, depth-parallel form of the update rule, and a place to look for the transition function of a learned world model that has no explicit one.

---

## Result 4 — MoveFirst: having a world model does not mean using it for every prediction

Measured per timestep: the earliest layer at which the probes recover all 64 squares, against the earliest layer at which the unembedding's top-`N` moves are all correct.

| Finding | Number / statement |
|---|---|
| **MoveFirst** | From roughly move 30 (the game's midpoint) onward, the model often computes the correct legal moves at an **earlier** layer than the correct board state, increasingly often toward the end |
| **Board accuracy degrades late** | Probe accuracy falls in end games; some timesteps never yield a correct full board at any layer |
| **And yet the board circuit still works there** | Re-running the counterfactual intervention on 1,000 *end-game* positions still gives 0.112 errors |
| **Openings look memorised** | In the first few plies board and moves are both resolved at layer 1, and Othello has few openings |
| **Iterative refinement** | Probed board and unembedded move predictions both change monotonically across layers — the residual stream refines rather than computes-once |

The authors' reading, and the wiki's: **multiple circuits**. Late in the game most squares are filled and most empty squares are legal, so legality becomes predictable from cheap features (`Empty` ∧ something like *is-bordered-by-Mine*) with no board state needed — and the cheap circuit resolves earlier in depth. The expensive world-model circuit is still present and still causal.

This is a general hazard for emergent-world-model claims and it is new to the wiki: **a probe averaged over a dataset cannot say which of several circuits ran on a given input.** A model can hold a verified, causally efficacious world model and still answer most queries by a shortcut that bypasses it — and an aggregate intervention score, being an average over cases, hides exactly this. See tension **T158**.

---

## Limitations

| Limitation | Statement |
|---|---|
| **The probe is still supervised** | Mine/Yours/Empty are ground-truth labels. The result sharpens gap **G17** rather than relieving it: not only must the experimenter know the answer, they must know it *in the model's coordinates* |
| **"Linear" is basis-relative and the source says so** | Its own example: if a world model computed Newtonian gravity via a neuron carrying `√distance`, is distance non-linearly represented, or is `d²` the natural feature? Linearity is a property of the pair (representation, feature vocabulary) |
| **No account of *why* linearity emerges** | Explicitly left open. The gesture — matrix multiplication makes a different linear subset cheap to extract per neuron — is not an argument |
| **One synthetic domain with a known ground truth** | 60 tokens, full observability, uniform-random legal play. The move to a distribution with strategy in it (Li et al.'s championship model) is not analysed here |
| **The intervention is applied at every layer** | So it does not localise *where* the board is read; it establishes use, not the read site |
| **MoveFirst is a hypothesis with a correlational test** | "Simpler end-game circuits" is inferred from timing and from board-accuracy decay; the candidate features (`Is-Surrounded-By-Mine`, `Is-Border`) are named but not probed |

---

## Scoring against the six hardness sources

| Source | Reached? |
|---|---|
| 1. Two-level entanglement | **Partly, and by discovery rather than design** — the rules of Othello are constant and land in weights; the per-game board is in activations. The split is where the information is constant, not an enforced factorization |
| 2. Unknown vocabulary | **The one real success here.** The node set (64 squares), the state alphabet (3 values), the frame (relative-to-mover) and an edge-like feature (`Flipped`) are all induced from move sequences alone. Nothing was told to the model — though the *experimenter* still had to guess the frame to see it |
| 3. Observation aliasing | **Addressed implicitly** — the same move token means different things at different plies, and the parity-relative code is exactly the de-aliasing device |
| 4. Simultaneity | Not addressed — the board is recomputed per prefix; there is no discover-while-navigating loop |
| 5. Spurious edges | **Negatively informative** — MoveFirst is a cheap correlational route to the answer coexisting with the correct one, inside a model whose correct route is verified causal |
| 6. Non-stationary topology | Not addressed — Othello's rules are fixed |

---

## Comparison

| | **OthelloGPT** (Nanda et al. 2023) | **[[wiki/entities/maze-solving-transformers.md]]** (Ivanitskiy et al. 2023) | **[[wiki/entities/spelkenet.md]]** (Venkatesh et al. 2025) |
|---|---|---|---|
| Where the structure comes from | **Discovered** from move sequences | **Supplied** in the prompt (adjacency list), re-represented | Discovered from passive video |
| Probe target | Board state, player-relative | Wall existence per cell × direction | None — a partition is clustered out of responses |
| Labels needed | Yes, and in the right basis | Yes | Only to *score*, not to produce |
| Causal test | **Yes** — vector addition, 0.02–0.10 errors | **No** — deferred by the authors | **Yes by construction** — the probe is an intervention |
| Representation ⇒ competence? | Not asked; the model is ~always right | **No** — 13–16% wall-crossing rollouts with the maze decoded at ≥0.93 | n/a |
| The residual worry | Which circuit ran (MoveFirst) | Whether the decoded map is used at all | Whether the clustering names the right thing |

---

## Connections

- **[[wiki/concepts/linear-representation-hypothesis.md]]** — the concept page this entity is the strongest evidence for, and the source of both its instruments: features as directions makes the residual stream linearly decomposable into per-component contributions, and makes editing a belief a single vector addition.
- **[[wiki/concepts/representation-probing.md]]** — supplies the acceptance test this page is the wiki's first machine model to pass, and receives from it the failure mode that no probe protocol controls for: a null linear probe may be a wrong *feature basis* rather than a non-linear code.
- **[[wiki/entities/maze-solving-transformers.md]]** — the control case in both directions: there the graph is given and the causal step is missing; here the graph is discovered and the causal step is done, and the two together say that "emergent world model" covers two quite different achievements.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a worked discovery result on hardness source 2: node set, state alphabet, reference frame and a transition-difference feature all induced from raw move sequences with no schema supplied.
- **[[wiki/concepts/learned-world-models.md]]** — a world model with no world-model *module*, no decoder and no explicit transition function: the state lives in a residual stream and the transition shows up as a parallel `Flipped` feature rather than as a `p(z'|z,a)` the architecture names.
- **[[wiki/concepts/shortcut-learning.md]]** — MoveFirst is the sharpest form the page's problem takes: the shortcut circuit and the structural circuit coexist inside one model, both causally real, and no aggregate metric distinguishes which one produced a given answer.
- **[[wiki/concepts/abstract-structural-codes.md]]** — an unforced choice of *relative* frame: the model codes each square with respect to whoever is to move, which is a content-invariant re-referencing that makes one code serve both players and halves what must be learned.
- **[[wiki/concepts/attention.md]]** — parity-selective heads (attending only to My or only to Your moves) and the `Played` broadcast `Emb[m] @ V @ O` are attention used as a *write* operation into other positions' streams, readable off the weights without a forward pass.
- **[[wiki/concepts/population-geometry.md]]** — the same question in the opposite methodology: this page fixes a hypothesised feature and asks whether a direction exists, that one fits the manifold first and asks what lies on it; the Mine/Yours result is the case where the first method's answer depended entirely on guessing the coordinates right.
- **[[wiki/concepts/simulation-based-planning.md]]** — the counterfactual-board interventions are single-step imagined states that the model's own policy read-out then acts on, which is the cheapest existing demonstration that an internal state edit propagates to behaviour.
