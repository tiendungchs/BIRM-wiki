# Maze-Solving Transformers (`hallway`, `jirpy`)

**Small decoder-only GPTs trained by next-token prediction on token-serialised mazes (adjacency list → origin → target → shortest path), interpreted post-hoc: the whole maze is linearly decodable from a *single* token's residual stream at layer 2, coordinate embeddings acquire lattice geometry, and one attention head attends only to in-context topological neighbours — while the rollouts those representations support still walk through walls (Ivanitskiy et al. 2023).**

> **Provenance.** Ivanitskiy, Spies, Räuker et al. 2023 (Colorado School of Mines / Imperial / NII Tokyo), *Structured World Representations in Maze-Solving Transformers*, NeurIPS 2023 UniReps workshop (`raw/ivanitskiy-2023-maze-solving-transformers.md`). The transferable ideas live on [[wiki/concepts/representation-probing.md]].

---

## Setup

| Element | Choice |
|---|---|
| **Task** | Shortest path between two cells of an `n × n` lattice maze, as autoregressive token prediction (offline RL with *global* observations — the maze is fully given in the prompt) |
| **Serialisation** | `<ADJLIST_START> (0,0) <–> (1,0) ; … <ADJLIST_END> <ORIGIN_START> … <TARGET_START> … <PATH_START> (1,3) (0,3) … <PATH_END>`; adjacency-pair order **randomised**, so sequence proximity carries no lattice information |
| **Vocabulary** | One orthogonal token per lattice coordinate + delimiters — **no spatial structure supplied at input** |
| **Maze generators** | Randomised depth-first search (RDFS, acyclic spanning trees); "forkless" sparse trees (≤2 connections per node, i.e. a corridor); RDFS + percolation `p = 0.1` (pRDFS, may contain cycles) |
| **`hallway`** | ~1.2M parameters, trained on forkless mazes only; gradients from the whole sequence |
| **`jirpy`** | ~9.6M parameters, trained on sparsely connected forking mazes of varying size; gradients only from path tokens |
| **Probe** | `n_layers × m × m × 4` linear probes on the residual stream: `R_l(t) · p_l(x, y, dir) > 0.5 ⟺ wall(x, y, dir)`, with `t` fixed to `<PATH_START>` (the last prompt token, so it has seen everything) |
| **Other instruments** | Direct logit attribution per attention head; TunedLens translators `L_l(R_l(t)) = R_l_final(t)`; probe sets re-trained at training checkpoints |

Single-token sub-tasks isolate what a rollout mixes together: `path_start`, `origin_after_path_start`, **`first_path_choice`**, `rand_path_token(_nonend)`, `final_before_path_end`, `path_end`. Only `first_path_choice` requires a *decision* in a forkless maze; the rest are following and delimiting.

---

## Key results

*(The source's results table is flattened in the Markdown extraction; the column assignment below — three datasets × two models — is inferred from the surrounding text, which independently states the qualitative pattern.)*

| Measurement | Value |
|---|---|
| **Rollouts, `jirpy` on in-distribution RDFS** | exactly correct 82.4% · topology-valid 84.0% · target reached 99.2% |
| **Rollouts, `jirpy` on out-of-distribution pRDFS (cycles)** | 70.7% · 87.1% · 100.0% |
| **Rollouts, `hallway` on out-of-distribution RDFS** | 24.2% · **37.5%** · **94.5%** — arrives at the target in 19 of 20 mazes while respecting the walls in fewer than 2 of 5 |
| **Hardest sub-task, every model × dataset** | `first_path_choice`: 66.4–86.7%, against 84–100% on every following/delimiting sub-task |
| **Linear probe accuracy (`jirpy`, layer 2, `<PATH_START>`, 15,000 mazes)** | 0.83–0.99 per wall position, most cells ≥0.93 — the *entire maze* reconstructed from one latent vector |
| **Where the world model lives** | 4/5 of the models exceeding 90% probe accuracy peak at **layer 2**, 1/5 at layer 3; models that solve mazes poorly acquire the representation only at later layers and never exceed 80% |
| **TunedLens** | After layer 1 the residual stream already says the next token is a coordinate; the probability mass on *connected* (as against merely adjacent) neighbours rises after layer 2 and is refined monotonically to the output |
| **Embedding geometry** | `‖E(a) − E(b)‖` correlates with the Manhattan distance `‖a − b‖₁` for short distances, though every vocabulary vector is orthogonal and adjacency-list order is randomised |
| **Adjacency head (L5H3)** | Attention concentrated on tokens at **path length 1** from the current position — not merely at Manhattan distance 1; it respects the *in-context* topology, walls included |
| **Target head (L1H2)** | Attends to `<TARGET_END>` across all tasks; hypothesised as half of a *reversed* induction head, a later head reading the token before it to recover the goal |
| **Positional head (L5H0)** | Attends to recent occurrences of the current coordinate token; correspondingly absent on `origin_after_path_start`, where the current token is not a coordinate |
| **Onset** | Probe accuracy and exact-path accuracy improve together across training, in grokking-like steps; `hallway` never acquires a clear linear maze representation at all |

---

## The two dissociations

The reason this source is worth its length. Both directions of "structured representation ↔ competent behaviour" come apart *within one paper*:

| Direction | Instance | Reading |
|---|---|---|
| **Representation without use** | `jirpy` reconstructs the maze at 0.83–0.99 per wall, then produces topology-violating paths in 13–16% of rollouts (and `hallway`, in 62% out of distribution) | An accurate, decodable graph estimate is **not sufficient** for valid navigation. Discovery and use are separately failing components, not one capability read out twice |
| **Use without representation** | `hallway` solves forkless mazes without ever acquiring a linearly decodable maze representation | A decodable graph is **not necessary** where the task degenerates — a corridor needs following, not search. The world model appears exactly when forks force a decision |

**(brainstorm)** The pairing is the interesting part. Together they say the linear world model is neither necessary nor sufficient for the behaviour, and that its *presence* tracks the presence of branching in the task distribution rather than performance. That is a cheap, task-side prediction the wiki can carry: **branching factor in the training distribution, not scale, is what forces a graph estimate into the weights.** A curriculum knob rather than an architectural one.

And the failure profile is legible in the framing's own vocabulary: the models are near-perfect on *goal identification* (`path_end`, target reached ≈100%) and worst on `first_path_choice` — the single token where a path must be *selected* rather than continued. The graph is recovered, the goal is recovered, and what fails is the **search** between them.

---

## Limitations

| Limitation | Statement |
|---|---|
| **No causal evidence** | The entire case is correlational: probes, direct logit attribution and lens readings. The authors explicitly defer ablations and interventions on the identified heads to future work, so "the model uses the representation it contains" is unestablished (contrast Li et al. 2022 on Othello, where probe-directed interventions changed play) |
| **The graph is given, not discovered** | The adjacency list is in the prompt. Nothing here recovers topology from experience; the achievement is *re-representation* of an explicitly supplied graph into a parallel-accessible form |
| **Probes are supervised** | Ground-truth walls train the decoder, so the instrument requires knowing the answer in advance — it cannot be run on a domain whose structure is what one is trying to find (gap G17) |
| **Grokking claim is temporal co-occurrence** | Representation improvement and generalisation improvement coincide in training time; no intervention separates cause from common cause |
| **Scale and domain** | <10⁷ parameters, 6×6–7×7 lattices, one task family. Universality across architectures and input encodings is named as future work, not shown |
| **Metric only** | The lattice is the friendliest possible case for an emergent geometric embedding — this says nothing about the non-embeddable symbolic slice (gap G11) |

---

## Scoring against the six hardness sources

| Source | Reached? |
|---|---|
| 1. Two-level entanglement | **Partly, and emergently** — the lattice geometry shared by every maze lands in the *embedding weights* (slow **W**), while per-maze connectivity can only be acquired in-context, in activations (fast **M**). The split is a consequence of where the information is constant, not a designed factorization, and there is no `p = f(g, x)` conjunction |
| 2. Unknown vocabulary | Not addressed — coordinates and delimiters are supplied |
| 3. Observation aliasing | Not addressed — each coordinate has a unique token |
| 4. Simultaneity | Not addressed — the maze is fully specified before the first path token; clean discovery-then-use separation |
| 5. Spurious edges | **Negatively informative** — the wall-crossing rollouts are edges the model traverses that the in-context graph does not contain, produced by a model that simultaneously represents the correct adjacency |
| 6. Non-stationary topology | Not addressed — topology fixed within a sequence |

---

## Connections

- **[[wiki/concepts/representation-probing.md]]** — the instrument page this entity is the worked example of: linear probes, direct logit attribution and the TunedLens, together with the decoded-but-unused failure they exposed here.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the cleanest available separation of the framing's two halves: the graph estimate is verifiably present and the navigation over it is still wrong, so *discovery* and *use* are shown to be independently failable.
- **[[wiki/concepts/attention.md]]** — turns the page's "attention weights are a soft adjacency" brainstorm into a measurement: L5H3 attends to nodes at *path* length 1, i.e. it has learned the in-context adjacency matrix rather than the lattice's.
- **[[wiki/concepts/abstract-structural-codes.md]]** — emergent metric structure with no metric supplied: embedding distance tracks Manhattan distance from orthogonal one-hot inputs, which is a content-invariant positional code arising from the objective alone.
- **[[wiki/concepts/simulation-based-planning.md]]** — the model has the map and still cannot reliably route on it; `first_path_choice` (the fork decision) is the worst sub-task everywhere, which localises the failure in search rather than in the world model.
- **[[wiki/concepts/working-memory.md]]** — an existence proof that multi-hop traversal can run without a separate addressable store: the whole graph is held in the residual stream of one token, and the failure mode is exactly the reliability degradation that store was meant to fix.
- **[[wiki/concepts/shortcut-learning.md]]** — reaching the target while crossing walls is a shortcut with the map in hand: goal-direction heuristics are cheaper than path validity, and the training loss never separates them.
- **[[wiki/entities/h-jepa.md]]** — the contrast case for where a world model lives: H-JEPA stipulates a separate world-model module, and here an equally usable world model emerges inside a generic decoder at layer 2 with no such module.
