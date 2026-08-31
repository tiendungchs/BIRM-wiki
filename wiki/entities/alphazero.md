# AlphaZero

**One policy-and-value network trained by self-play against nothing but the game rules, with Monte-Carlo tree search used at *both* ends — as the improvement operator that generates the training targets, and as the run-time planner.** Silver, Hubert, Schrittwieser, Antonoglou, Lai, Guez, Lanctot, Sifre, Kumaran, Graepel, Lillicrap, Simonyan & Hassabis 2017, arXiv:1712.01815. Source: `raw/silver-2017-alphazero-chess-shogi.md`.

The wiki has carried this lineage second-hand on four pages as "Monte Carlo tree search / expert Go play" ([[wiki/index-entities.md]]) and as [[wiki/concepts/causal-model-building.md]]'s sample-efficiency foil. The primary source fixes what the artefact actually demonstrates and what it does not: **the transition model is handed over, in full, as a perfect simulator**, so nothing here bears on [[wiki/concepts/latent-graph-discovery.md]]. What it does isolate is everything *downstream* of having the graph — search, valuation, and the compilation of search back into a cached policy.

---

## The algorithm

```
(p, v) = f_θ(s)          p_a = Pr(a|s) over the full action space;  v ≈ E[z|s]
π       = MCTS(s; f_θ)   normalised root visit counts after 800 simulations
l       = (z − v)² − πᵀ log p + c‖θ‖²
```

| Element | Spec |
|---|---|
| Self-play | Moves drawn `a_t ~ π_t` (proportional to root visit counts); at evaluation, greedy in visit count |
| Target | `z ∈ {−1, 0, +1}` from the terminal position under the rules; **expected** outcome, not win probability — draws are first-class (the AlphaGo Zero change forced by chess) |
| Search rule | Select the move with low visit count, high prior `p`, high mean value; 800 simulations per move in training |
| Exploration | Dirichlet noise on the root prior, `α = {0.3, 0.15, 0.03}` for chess/shogi/Go — scaled *inverse* to the typical legal-move count, the **only** per-game hyperparameter |
| Optimisation | 700k mini-batches of 4,096; LR 0.2 → 0.02 → 0.002 → 0.0002; 5,000 TPUv1 generating games, 64 TPUv2 training |
| Network updating | A **single** continually updated network; no best-player gating, no evaluation-and-replace step (AlphaGo Zero had one) |
| Symmetry | **None used.** Chess and shogi are not rotation/reflection symmetric, so the 8× data augmentation and the evaluation-time random transform of the Go system are simply dropped |

**Representation is grid-shaped on both sides.** Input is `N×N×(MT+L)` planes over a `T = 8` history, oriented to the mover: 17 planes (Go), 119 (chess), 362 (shogi). Output is a plane stack over *(from-square × move-type)* — 8×8×73 = 4,672 moves in chess (56 "queen" rays + 8 knight + 9 underpromotions), 9×9×139 = 11,259 in shogi (adding promoting moves and 7 drop planes). Illegal moves are masked and the remainder renormalised. **A flat move distribution works too, with training only slightly slower** — so the structured action encoding is a convenience, not a load-bearing prior.

## What is given, and what is learned

| Given | Learned |
|---|---|
| The rules, as a **perfect simulator** — used inside MCTS to generate successors, detect termination, and score terminal states | The prior `p` over moves (replacing killer/history/counter-move heuristics, SEE, MVV/LVA move ordering) |
| The grid structure of the board, as the plane encoding | The evaluation `v` (replacing piece-square tables, material imbalance, mobility, king safety, pawn structure, outposts, bishop pair, and their tuned weights) |
| The typical number of legal moves (noise scaling only) | Which variations are worth expanding (replacing null-move, futility and late-move pruning, aspiration windows, singular extensions, check extensions) |
| A maximum game length, beyond which the game is scored a draw | Openings — every one of the 12 most-played human openings is discovered in self-play, and their self-play frequencies *rise and then fall* as training proceeds |
| — | Nothing else: no opening book, no endgame tablebase, no quiescence search, no transposition table |

The Methods list domain knowledge as five numbered items and assert nothing beyond them is used. **The first two items are the wiki's whole hard problem, conceded at the outset** ([[wiki/concepts/latent-graph-discovery.md]], gap G27): the state discretisation is authored and the transition function is exact.

## Results

| | Chess | Shogi | Go |
|---|---|---|---|
| Wall-clock to beat the reigning champion program | 4 h (300k steps) vs Stockfish 8 | < 2 h (110k steps) vs Elmo | 8 h (165k steps) vs AlphaGo Lee |
| Total training | 9 h, 44M self-play games | 12 h, 24M games | 34 h, 21M games |
| 100-game match, 1 min/move | **28 W – 72 D – 0 L** vs Stockfish | **90 W – 2 D – 8 L** vs Elmo | 60–40 vs AlphaGo Zero (3-day) |
| Positions/second | 80k vs Stockfish's 70,000k | 40k vs Elmo's 35,000k | 16k |

**Three readings the numbers support.**

- **Selectivity, ~875×.** Equal-or-better play while evaluating three orders of magnitude fewer positions is the paper's central claim, and it localises the win in *where* compute is spent rather than how much: a learned prior does what decades of hand-authored move ordering did.
- **Search still scales at run time.** Elo rises with thinking time *faster* for AlphaZero's MCTS than for either alpha-beta engine — so the learned prior does not saturate the search, it steepens it. This is the counter-example to reading policy distillation as making run-time search redundant ([[wiki/empirical-tensions.md]] T180).
- **Robustness to the opening.** Started from each of the 12 human openings, it still beats Stockfish as either colour — competence is not a narrow self-play equilibrium.

## MCTS vs alpha-beta as an error-propagation choice

The Methods make an argument that generalises far past board games and is the single most transferable thing on this page:

| | Alpha-beta (Stockfish, Elmo, Deep Blue) | MCTS (AlphaZero) |
|---|---|---|
| Backup | Explicit **minimax** over the subtree | **Average** over the subtree's leaf evaluations |
| Evaluation | Linear in handcrafted features, `v(s,w) = ϕ(s)ᵀw`, plus a quiescence search to reach "quiet" positions | Deep nonlinear function approximation |
| Effect on evaluator error | A max propagates the **largest** approximation error to the root | Averaging makes errors **cancel** over a large subtree |

The claimed consequence: minimax and a noisy learned evaluator are incompatible, which is why every earlier neural chess program (NeuroChess, KnightCap, Giraffe, Meep, DeepChess — all listed in the Methods) bolted its network onto alpha-beta and none beat a fast handcrafted evaluator. Averaging is what lets a powerful-but-biased evaluator be used at all.

**(brainstorm)** The wiki has been treating compounding model error as a *horizon* problem — accuracy decays with rollout depth, so plan jumpily ([[wiki/concepts/simulation-based-planning.md]]). This says it is also a **backup-operator** problem: the same model error is fatal under `max` and survivable under `E`. Any planner in this wiki that runs on a learned world model and selects by argmax over rolled-out returns — model-predictive control with a learned cost, cross-entropy-method planning in [[wiki/entities/v-jepa-2.md]], expected-free-energy minimisation over action sequences — is choosing the operator that amplifies its own model's worst error, and none of them says why. The cheap experiment is to swap the root aggregation from max-over-samples to a visit-weighted mean and measure the gap as a function of model error, which is a one-line change in an existing planner.

## Limitations

| Limitation | Statement |
|---|---|
| **The model is not learned** | Rules given as an exact simulator. AlphaZero is evidence about search-and-valuation on a *known* graph, and about nothing else. Its successor MuZero removes this; that paper is not in `raw/` |
| **No re-goaling, no transfer** | One instance trained per game, from random initialisation. The *algorithm* generalises across three games at one hyperparameter setting; the *weights* generalise nowhere. Reward is not even an object in the system — it is the rules' terminal score, so there is nothing to swap (gap G28) |
| **Sample cost** | 44M self-play games in chess. The re-goaling argument the wiki carries from Lake et al. 2017 (Go variants: different board sizes, torus/Möbius boards, First Capture Go) is untouched by generality-of-*algorithm* results |
| **Search reports no uncertainty** | Visit counts and a mean value, never an estimate of what truncation cost — so the Daw et al. 2005 uncertainty-crossing stopping rule cannot be instantiated on it (gaps G15, G24) |
| **Depth is a constant** | 800 simulations per move, everywhere, in every position. The branch-choice policy is principled and adaptive; the budget is a hand-set schedule |
| **The comparison is contested at the margins** | Stockfish 8 was run at fixed 1 min/move with no opening book and a 1GB hash, which the computer-chess community disputed as unrepresentative of tournament conditions *(tentative — the objection is not in the source)* |

## Comparison

| System | Transition model | Backup | Search budget | What transfers |
|---|---|---|---|---|
| **AlphaZero** | Given, exact | Mean over subtree | Fixed 800 sims | The algorithm and hyperparameters, across 3 games |
| **Stockfish / Elmo** | Given, exact | Minimax with pruning | Time-controlled, iterative deepening | Nothing — hand-authored per game |
| [[wiki/entities/dqn.md]] | None | `max` in the TD target | Zero (one forward pass) | Architecture and hyperparameters across 49 games; nothing else |
| [[wiki/entities/neural-episodic-control.md]] | None | Max over per-action dictionaries of `N`-step returns | Zero (one kernel read) | Same conv stack; the store is per-task |
| [[wiki/entities/continual-dreamer.md]] | **Learned** | Policy gradient in imagination | Rollouts in latent space | Fails re-goaling with the layout held fixed |
| [[wiki/entities/v-jepa-2.md]] | **Learned**, latent | `argmin` cost over sampled action sequences (cross-entropy method) | 800 samples, horizon 1–2 | Zero-shot to unseen labs and objects |
| [[wiki/entities/cscg.md]] | **Learned**, discrete | None — planning by conditioning a generative model | n/a | The learned graph itself |

## Why this matters for a reasoning model

**(brainstorm) AlphaZero is the wiki's clean upper control, as [[wiki/entities/dqn.md]] is its clean null.** Hand it a perfect graph and a terminal reward, and search-plus-a-learned-prior reaches superhuman performance in three structurally unrelated domains in hours, with one hyperparameter set. That prices what the wiki's actual problem is *not*: not the search algorithm, not the value approximator, not the policy-improvement loop. Every remaining difficulty in the framing sits in the two things the paper is handed — the discretisation (G27) and the transition function — plus the two it never attempts: composing the model with a new objective (G28), and setting its own budget (G15, G24).

**(brainstorm) The self-play loop is plan amortisation with a measured improvement operator.** `π` (search) is strictly better than `p` (network prior); training `p → π` compiles that improvement into weights; the improved `p` makes the next search better still. This is the cleanest instance in the wiki of [[wiki/concepts/amortized-inference.md]]'s second mode, and it is the only one where the expensive process is *guaranteed* to dominate the cached one, because it is the cached one plus lookahead on an exact model. Remove the exactness and the guarantee goes with it — which is exactly where a brain-inspired version has to live, and why the error-averaging argument above is the precondition for the loop to work at all on a learned model.

---

## Connections

- **[[wiki/concepts/simulation-based-planning.md]]** — the page's strongest machine instantiation and its sharpest boundary: search on a *given* exact model is shown sufficient for superhuman play in three domains, so the page's open problems all relocate into "learning the model without priors" and "when to stop".
- **[[wiki/concepts/amortized-inference.md]]** — plan amortisation with the improvement operator made explicit: MCTS visit counts are a provably better policy than the network prior that seeded them, and the cross-entropy term `−πᵀ log p` is the compilation step, run continuously rather than offline.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the negative result the wiki needs stated plainly: the graph is handed over as a perfect simulator and the authored state/action discretisation is listed as domain knowledge, so nothing here bears on discovery (gap G27).
- **[[wiki/entities/dqn.md]]** — the other pole of the same lab's Atari-era work: DQN has no model and backs up with `max`; AlphaZero has an exact model and backs up with a mean, and the two differ on transfer in the same way (one instance per task in both cases).
- **[[wiki/entities/neural-episodic-control.md]]** — the opposite trade on where compute goes at decision time: a single kernel read from a stored table versus 800 simulations, both replacing a slow gradient-fed value function.
- **[[wiki/entities/v-jepa-2.md]]** — the same planner shape on a *learned* latent model, and the one that inherits this page's warning: it selects by `argmin` over sampled action sequences, i.e. the backup operator that propagates its world model's largest error.
- **[[wiki/entities/cscg.md]]** — the complement: CSCG learns the graph and then plans by conditioning rather than by search, where AlphaZero is given the graph and does nothing but search.
- **[[wiki/concepts/causal-model-building.md]]** — supplies the primary numbers for the sample-efficiency argument the page carried second-hand (44M self-play games in chess, 24M in shogi, 21M in Go), and narrows it: the generality demonstrated is of the training algorithm, never of a trained agent.
- **[[wiki/concepts/linear-representation-hypothesis.md]]** — the system whose learned value network human chess concepts were later found linearly decodable from; this page supplies what that network is and how it was trained.
- **[[wiki/concepts/replay-prioritisation.md]]** — the contrast case for what a "training distribution" means in reinforcement learning: AlphaZero regenerates its own data from the latest parameters rather than sampling a buffer, so the prioritisation question is replaced by an exploration-noise question at the search root.
- **[[wiki/concepts/external-verification.md]]** — a verifier that is exact and free: the rules score every terminal state, which is what makes the self-play loop self-correcting and is precisely the ingredient absent from open-ended reasoning domains.
- **[[wiki/concepts/test-time-training.md]]** — the counterpoint on where adaptation happens: nothing is adapted per position beyond running search, and the Elo-vs-thinking-time curve is what a pure test-time-*compute* (not training) scaling law looks like.
