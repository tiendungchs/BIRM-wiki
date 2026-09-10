# Visual Predictive Coder

**A ResNet-18 encoder–decoder with one self-attention layer trained on nothing but next-image prediction, whose latent space turns out to carry the environment's metric — no coordinates, no odometry, no path-integration signal, no place-cell readout, no spatial loss term. It is the wiki's one demonstration that a map can be a by-product of a sensory predictor rather than a thing a model is built to hold.**

> **Provenance.** `raw/gornet-2024-cognitive-maps-visual-predictive-coding.md` — Gornet & Thomson, *Nature Machine Intelligence* 6:820–833, 2024. Simulation only; no biological recording. Every "map" statement below is a *probe* result unless marked otherwise.

---

## The formal claim (the part that is not a simulation)

Expand the next-image posterior over an implicit set of latent coordinates `(x, θ)` the agent never observes:

```
P(I_{k+1} | I_0…I_k)
  = ∫_Ω dx dθ  P(x_0,θ_0,…,x_k,θ_k | I_0,…,I_k)   ← term 1: encoding
                · P(x_{k+1},θ_{k+1} | x_k,θ_k)     ← term 2: spatial transition
                · P(I_{k+1} | x_{k+1},θ_{k+1})     ← term 3: decoding
```

| Reading | Consequence |
|---|---|
| The factorisation is a **path integral** over Ω | Sequence prediction is a marginalisation over trajectories, not a regression on the last frame |
| Each term is a network | Term 1 = encoder + attention over the observation history; term 2 = a transition operator; term 3 = decoder. The architecture is *read off* the factorisation rather than designed |
| `(x, θ)` is never supervised | The coordinate system is whatever makes the three terms compose — an **implicit** frame, existing only because it is the cheapest sufficient statistic of the history for predicting the next frame |

This is the wiki's clearest statement of why a predictor should hold a map at all: the latent is a *sufficient statistic of the past for the future*, and in a spatially-embedded world position is that statistic. It is the same argument [[wiki/concepts/prediction-compression-equivalence.md]] makes in code-length terms, written as a marginalisation instead.

**What the derivation does not deliver.** Nothing forces gradient descent on pixel MSE to find *this* factorisation; it is an existence argument for a solution family, not an identification result. The trained network is offered as evidence that the family is reachable, and no term of the network is checked against its assigned term in the equation.

---

## Architecture and training

| Component | Detail |
|---|---|
| Encoder | ResNet-18, each frame of the sequence encoded independently |
| History | **One** multi-head attention layer, `h = 8` heads, over the sequence of frame latents. This is the only place the past enters |
| Decoder | ResNet-18 with transposed convolutions, U-Net skips from encoder |
| Latent | 128 units (analysed thresholded at their 90th percentile) |
| Objective | Mean-squared error to the *next* frame. Nothing else |
| Data | 82,630 samples; Malmo/Minecraft world 40 × 65 = 2,600 lattice units (cave = global landmark, forest = visual degeneracy, river + bridge = a traversal constraint); paths between random waypoints by `A*`, varying speed and heading |
| Optimisation | SGD + Nesterov 0.9, lr 0.1, weight decay 5 × 10⁻⁶, OneCycle, 200 epochs |
| Control | An auto-encoder: same ResNet-18/U-Net, **no attention, single frame in, same frame out** |

---

## Results

| Measurement | Predictive coder | Auto-encoder | Reference |
|---|---|---|---|
| Next/current-frame MSE | 0.094 | **0.039** | The better reconstructor is the worse mapper |
| Position decoded by a trained auxiliary net | mean 5.04 lattice units; >80% < 7.3 | >80% < 13.1 | True position + `N(0, σ=4)` noise: mean 4.98, >80% < 7.12 |
| Latent-vs-physical distance | `d(z,z′) = α·log‖x−x′+ε‖ + β`, Pearson `r = 0.827`, `D_KL = 0.429` bits | larger dispersion | — |
| Mutual information, latent distance × physical distance | **0.627 bits** | 0.227 bits | position + `N(0, σ=2)`: 0.911 bits |

**The metric is logarithmic.** Latent distance fits `log` of physical distance, not physical distance — the map compresses the far field. Nothing in the paper comments on this, and it is the one quantitative disagreement with the linear distance codes the wiki carries ([[wiki/concepts/vector-coding.md]], entorhinal Euclidean-distance-to-goal in [[wiki/concepts/cognitive-map.md]]).

**Position is recovered only to ±4 lattice units.** The headline "low prediction error" is calibrated against a Gaussian-noise oracle at `σ = 4` — roughly a tenth of the arena's short axis. The latent knows *which region*, not which square.

### The aliasing experiment, which is the load-bearing one

A circular corridor of rooms coloured, clockwise, **red, green, red, blue, yellow** — two rooms that are pixel-identical and maximally distant on the loop.

| | Predictive coder | Auto-encoder |
|---|---|---|
| Mean position error | **0.071** lattice units | 5.004 (and it places left-red *inside* right-red) |
| Latent vs physical distance | `r = 0.827`, `D_KL = 0.250` | `r = 0.288`, `D_KL = 3.806` |
| Topology recovered | The loop, with the two red rooms separated | A line; the red rooms merged |

**Theorem 1 / Corollary 1.** If the observation map `f : x ↦ I` is not injective — `f(x₁) = f(x₂)` for some `x₁ ≠ x₂` — then no left inverse `d` exists, so no decoder recovers `x` from `I`, and none recovers `x` from an auto-encoder's `z = enc∘f(x)` either. One line, and it settles the aliasing case for *any* estimator of position from a single stationary observation, not just for the network tested.

---

## The code that emerges: overlapping place fields, and vector navigation on top

| Property | Value |
|---|---|
| Field shape | Each latent unit fires over a localised region; 2-D Gaussian fit, area at `P ≥ 0.0005` |
| Field size | mean **254.6** lattice units = 9.79% of the arena; 80% below 352.6 (13.6%) |
| Coverage | every lattice block has ≥1 active unit; the count of active units differs across **87.6%** of blocks — a combinatorial position code, not a labelled-line one |
| Stability under landmark change | remove and randomly redistribute the trees: **Jaccard 0.828** between old and new fields |
| Vector navigation | binary 128-d code `z` (90th-percentile threshold); linear decoder `x₁ − x₂ = W[z₁ − z₂] + b` gives distance mean 7.89 units (80% < 12.49) and direction mean 30.6° (80% < 48.04°); `r = 0.924` with direction, `0.718` with distance |
| Information in the difference code | Hamming distance carries **0.542** of the coder's 0.627 bits — the thresholded binary code retains most of the metric |

Two things the wiki did not have before:

- **A displacement read out of place-like units by subtraction alone.** [[wiki/concepts/displacement-codes.md]] and [[wiki/concepts/vector-coding.md]] treat vector navigation as a *grid*-code property (a torus has an algebra; a bag of blobs does not). Here the subtraction of two overlapping-field codes is linearly decodable to a heading, because overlap makes the code graded rather than one-hot. So a displacement algebra does not require periodicity — it requires **fields wide enough to overlap**, which is a much cheaper condition.
- **Landmark-independence at 0.828.** The fields survive the wholesale relocation of the movable landmarks — the boundary-primacy / stability-ranking bias of [[wiki/concepts/cognitive-map.md]] element 2, arrived at by an untutored network with no notion of a boundary.

---

## What is wrong with the paper's own headline

**Its claim:** predictive coding is *necessary* for mapping, and auto-encoding cannot do it.

**What is actually shown:** the theorem covers estimators that see **one stationary observation**. The auto-encoder is single-frame; the predictive coder is sequence-conditioned via its attention layer. So the comparison confounds two independent variables:

| Variable | Predictive coder | Auto-encoder |
|---|---|---|
| **Input window** | history `I_0…I_k` | current frame only |
| **Objective** | next frame | current frame |

The theorem bites the *input window*. It says nothing about the objective, and a sequence auto-encoder — attention layer intact, target moved from `I_{k+1}` back to `I_k` — is untested and is not excluded by any argument in the paper. This matters because most of the wiki's structure-from-prediction evidence ([[wiki/entities/tolman-eichenbaum-machine.md]], [[wiki/entities/cpc.md]], the JEPA family) credits the *prediction target*; if the de-aliasing work is done by conditioning on history rather than by predicting forward, that credit is misassigned. Logged as `T349`.

**And the map is decoded, never used.** Position comes from a trained auxiliary convnet (conv → ReLU → maxpool → 2 fully-connected layers, AdamW, 2 × 1,000 epochs); vector navigation comes from a fitted linear decoder. No agent in the paper navigates, plans, takes a shortcut or reaches a goal. By [[wiki/concepts/representation-probing.md]]'s decoded-but-unused criterion this is the discovery half with the routing half absent — the same shape as the maze-transformer result, minus the behavioural test that would expose it.

---

## Comparison

| Model | Where the map comes from | Coordinates supplied? | Aliasing handled by |
|---|---|---|---|
| **Visual predictive coder** | Emerges in the latent of a pixel-MSE next-frame predictor | none | attention over the observation history |
| [[wiki/entities/tolman-eichenbaum-machine.md]] | Next-observation prediction, but with a path-integrating structural module wired in and a Hebbian binding store | actions supplied as input to `g` | retrieval from the relational memory, plus the structural code |
| [[wiki/entities/cscg.md]] | Expectation-maximisation on a clone-structured hidden Markov model | none | clone pool per observation — de-aliasing *is* the learning problem |
| [[wiki/entities/gcq.md]] | Installed: the codebook is a frozen toroidal attractor's bump set | topology installed before training | `argmax` over the translation group across the whole init sequence |
| [[wiki/entities/vector-hash.md]] | Installed grid scaffold; hippocampal state is a content-free hash | grid modules given | distinct grid phases hash to distinct pointers |
| Auto-encoder control | nothing — image similarity only | none | **cannot be**, by Theorem 1 |

The row that matters: this is the only entry whose map has **no installed structure and no explicit state-space learning problem**. It is also the weakest map in the table — coarse, logarithmically warped, and never used.

---

## Limitations

- One 2,600-unit gridworld and one corridor, both authored; `A*` waypoint paths, not a behaving policy.
- Nothing is compared against a sequence auto-encoder, an ablated attention layer, or a shuffled-frame-order control — so "the temporal dependency did it" is asserted from one contrast that varies three things.
- No grid-like units reported, and none looked for. Given the periodic corridor, this is a missed measurement rather than a null.
- No agent, no goal, no detour — Tolman's own criterion for a map is untested here.
- The extension to "auditory, tactile and linguistic" mapping, and the reading of large language models as cognitive-map builders, are **discussion-section conjecture** with no experiment (`(tentative)`).

---

## Connections

- **[[wiki/concepts/cognitive-map.md]]** — the cheapest route in the wiki to that page's element 1: a distance-preserving code falling out of next-frame prediction with no coordinates, no path-integration input and no place-cell target — and it arrives without element 2 or element 3, since nothing anchors the frame online and nothing navigates on it.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — supplies the missing derivation of *why* a residual-minimising hierarchy should hold a spatial state at all: expand the next-observation posterior over latent coordinates and encoder/transition/decoder are the three factors, so the generative model's hidden state is position because position is the sufficient statistic of the history.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the same claim in the other currency: the map is the shortest description of the observation history that suffices for the next observation, here obtained by marginalising a path integral rather than by minimising a code length.
- **[[wiki/concepts/vector-coding.md]]** — a displacement code with no periodicity and no referent object: subtract two overlapping-place-field codes and a linear decoder recovers distance (`r = 0.718`) and direction (`r = 0.924`), so the vector algebra needs field *overlap* rather than a torus.
- **[[wiki/concepts/displacement-codes.md]]** — the agent-to-agent case of that page's algebra, run on learned blobs instead of on a grid module, which removes the assumption that the format has to be periodic for subtraction to mean anything.
- **[[wiki/concepts/representation-probing.md]]** — a textbook decoded-but-unused result: every map claim here comes from an auxiliary decoder trained after the fact, and no behaviour in the paper consumes the latent, so the discovery/use gap that page measures is total by construction.
- **[[wiki/concepts/pattern-separation-completion.md]]** — de-aliasing by temporal context instead of by sparsification: two pixel-identical rooms are separated because the histories reaching them differ, which is the same job the dentate does with orthogonalisation and a different mechanism for it.
- **[[wiki/entities/cscg.md]]** — the same aliasing problem made the *explicit* learning target rather than a side-effect: clone pools de-alias by construction and the transition matrix is the map, where here the de-aliasing is whatever an attention layer happens to do and the map is only decodable.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the same objective (next-observation prediction) with the structural module installed; this page is the ablation nobody ran on it — remove `g`, remove the actions, keep the prediction, and a coarse metric map still appears, though grid-like units are not reported.
- **[[wiki/entities/gcq.md]]** — the opposite pole on the installed/emergent axis: there the map's topology and symmetry group are frozen before training and anchoring is an `argmax` over that group; here nothing is installed, and the price is that the frame can never be anchored because there is no group to anchor it in (`G39`).
- **[[wiki/entities/mae.md]]** — the pixel-reconstruction sibling with the target left at the *current* input, which is exactly this page's auto-encoder control scaled up; Theorem 1 says such an objective cannot recover position in an aliased world however good its reconstructions are, and the 0.039-vs-0.094 MSE inversion here is that statement in one number.
- **[[wiki/entities/cpc.md]]** — the same next-latent premise with the residual replaced by a contrastive discrimination; both claim the name "predictive coding" and neither computes a Rao–Ballard residual in observation space — this one at least does compute a residual, in pixels.
- **[[wiki/concepts/objective-identifiability.md]]** — the concrete case that makes that page's problem operational: two systems differing in both input window and target produce different representations, and the paper's theorem licenses only the input-window explanation, so the objective is *not* identified by the representation it accompanies (`T349`).
- **[[wiki/concepts/latent-graph-discovery.md]]** — discovery with the graph left implicit: the latent recovers the environment's metric and its loop topology without ever materialising nodes or edges, which is the framing's estimate-the-graph half satisfied in a format nothing can route over.
