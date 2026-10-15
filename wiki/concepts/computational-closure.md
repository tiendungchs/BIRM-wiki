# Computational Closure — When a Coarse Level Runs Like Software

**A coarse-graining `Z` of a micro process `X` is *causally closed* when the micro past adds nothing to predicting `Z`'s future beyond `Z`'s own past (information closure), equivalently when `Z`'s ε-machine equals its υ-machine. It is *computationally closed* when `Z`'s ε-machine is a coarse-graining of `X`'s ε-machine. For spatial coarse-grainings the first implies the second, and both reduce to lumpability of the micro causal-state chain. The closed levels of one system form a lattice, and the lattice of their ε-machines ("theory space") is the system's functional architecture: which computation runs at which level.**

[[wiki/concepts/causal-states.md]] gives one process's minimal optimal predictor. [[wiki/concepts/emergent-macrostates.md]] relates a coarse observation to hidden microdynamics, but only from the observer's side. This page adds the **micro-to-macro side**. It asks whether anything below a level still matters to that level. When nothing does, the level can be simulated, predicted and controlled with the micro level switched off.

> **Provenance.** Rosas, Geiger, Luppi, Seth, Polani, Gastpar & Mediano 2024, *Software in the natural world: A computational approach to hierarchical emergence*, arXiv:2402.09090v2 (`raw/rosas-2024-software-in-the-natural-world-hierarchical-emergence.md`). Theory paper with proofs (Appendix A) and six worked case studies; no fitted data. It extends *dynamical independence* (Barnett & Seth 2023). The clip is ar5iv HTML and has two gaps: the two commuting diagrams (rendered as images) and the text of footnotes 1–16 are missing. Source typos corrected on this page: the Hopfield field is `h^j = Σ_i w_ij X^i` (source: `X^j`); the sentence before Theorem 1 says "weaker than computational closure" where it means causal closure; Counterexample 5 invokes "Theorem 2" for information ⇒ causal closure, which is Theorem 1.

---

## Formalism

Setting: stationary, discrete-alphabet process `X`; coarse-graining `Z_t = g(←X_t)` (spatio-temporal) or `Z_t = f(X_t)` (spatial). `Z⁽¹⁾ ⪰ Z⁽²⁾` means `Z⁽¹⁾` is a coarse-graining of `Z⁽²⁾`. All coarse-grainings form a lattice (identity at the bottom, constant `𝟏` at the top); the spatial ones form a sub-lattice (Lemma 1).

| Object | Definition | Reading |
|---|---|---|
| ε-machine of `X` | Causal states `E_t`: micro pasts with equal `p(→x \| ←x)` | The micro "laws" |
| ε-machine of `Z` | Causal states `E′_t`: macro pasts with equal `p(→z \| ←z)` | The best theory of `Z` buildable from `Z` alone |
| **υ-machine of `Z`** (Def. 2) | `U_t = υ(←X_t)`: micro pasts with equal `p(→z \| ←x)` | The minimal micro information that drives `Z` — its "genuine cause" (Granger sense unless `X` is fully observed) |
| Prop. 1 | `U` is the coarsest coarse-graining of `←X` with `I(U; →Z^L) = I(←X; →Z^L)` for all `L` | The υ-machine is an information bottleneck with relevance variable = macro future |
| Lemma 2 | `I(U; →Z^L) ≥ I(E′; →Z^L)` (data processing) | Seeing the micro never predicts the macro worse |
| **Causal closure** (Def. 3) | `E′ ≅ U` (bijection) | Every difference that makes a difference to `Z` is visible at `Z` |
| **Information closure** (Def. 4) | `I(←X; →Z^L \| ←Z) = 0` for all `L` | `←Z` is a sufficient statistic of `←X` for `→Z` |
| **Computational closure** (Def. 5) | Automaton view: input coarse-graining `f` and state coarse-graining `f*` are closed if coarse states under coarse inputs are again a **deterministic** automaton. For processes: `E′_t = f*(E_t)` | Coarse-graining and building the ε-machine **commute**: the macro theory is the micro theory coarse-grained |
| Computational equivalence (Def. 6) | Two coarse-grainings with equivalent ε-machines | Same computation, different look |
| Unprocessed information | `Δ_L(X,Z) = I(←X; →X^L) − I(←Z; →Z^L) ≥ 0` | What `X` processes that `Z` does not |
| Strong / weak lumpability (Def. 7) | Markov `W` with `f(W)` Markov for **every** / **some** initial distribution | Lemma 4 (stationary, irreducible, aperiodic): strong ⟺ `H(Z_{t+1}\|Z_t) = H(Z_{t+1}\|X_t)`; weak ⟺ `H(Z_{t+1}\|Z_t) = H(Z_{t+1}\|←Z_t)` |

---

## The results

| # | Statement | Consequence |
|---|---|---|
| **Thm 1** | For any coarse-graining (spatio-temporal included): causal closure ⟺ information closure ⟺ `I(U; →Z) = I(E′; →Z)` | Matching *amounts* of predictive information already forces matching *structure*. A one-number test certifies a structural property |
| **Prop. 2** | Spatial `f` ⇒ `U_t` is a coarse-graining of `E_t`; υ-machines form a lattice homomorphic to the coarse-graining lattice | The υ-machine is the part of the micro ε-machine that runs `Z` |
| **Thm 2** | Spatial + causally closed ⇒ computationally closed. Closed coarse-grainings form a sub-lattice that maps (possibly many-to-one) homomorphically onto a lattice of coarse-grainings of the micro ε-machine, and the diagram commutes | Closure has a computational reading: a closed level runs a sub-computation of the whole autonomously |
| Lemma 3 | Computationally closed spatial `Z` with `Δ = 0` ⇒ `Z` computationally equivalent to `X` | Zero lost information ⇒ same computation |
| **Prop. 3** | Chain `X = Z¹ ⪯ Z² ⪯ … ⪯ Zᵐ = 𝟏` of closed levels ⇒ `I(←X; →X) = Σ_k Δ(Zᵏ, Zᵏ⁺¹)` | Total predictive information splits exactly into per-level shares |
| **Prop. 4** | Stationary irreducible aperiodic Markov `X`: strongly lumpable under `f` ⇒ `Z` informationally closed; informationally closed and Markov `Z` ⇒ strongly lumpable | First-order case: closure = strong lumpability |
| **Thm 3** | (i) computationally closed ⇒ `E` weakly lumpable; weakly lumpable `f` on `E` ⇒ `f(E)` computationally closed. (ii) With `E` irreducible and aperiodic: informationally closed spatial `Z` ⇒ `E` strongly lumpable; strongly lumpable `f` on `E` ⇒ `f(E)` informationally closed | **A process has closed levels iff its causal-state chain is strongly lumpable.** Lumpability algorithms work as level detectors when run on the causal states, not on the raw observations |
| **Robustness** (after Thm 3) | Information closure is a property of the transition probabilities (strong lumpability). Computational closure, like weak lumpability, also depends on the marginal | Computational-only closure can break when the state distribution moves off the stationary one. Information closure cannot |

**Hierarchy of three lattices** (Fig. 6): all coarse-grainings (super-exponential in alphabet size) ⊃ causally closed ones ⊃ their image in theory space (strongly lumpable coarse-grainings of the micro ε-machine). Only the third deduplicates. It sends noise-only and copied levels to one node. The source proposes it as *the* blueprint of a system's functional architecture.

**Four placements of a closed level `Z` between `X` and `𝟏`** (Fig. 7, Example 2): (a) non-trivial and different from micro; (b) non-trivial and equivalent to micro; (c) trivial and different from micro; (d) trivial and equivalent to micro (`X` i.i.d.). The real-space lattice is identical in all four; only theory space separates them.

---

## Counterexamples (the boundaries of each implication)

| # | Construction | What fails |
|---|---|---|
| CE1 | 3-state chain; `a`,`b` share outgoing rows; no `c→b`; `Z` merges `b,c` | `Z` is non-Markov with causal states `{A, BA, BBA, …}` (infinitely many) while `X`'s ε-machine has 2. **In general, macro ε-machines are not coarse-grainings of micro ones** |
| CE2 | Same chain | `E′` is not a coarse-graining of `U` either (`U` ≤ 2 states) |
| CE3 | `X` i.i.d., `Z_t = X_{t−1}` | Temporal coarse-graining: `U` non-trivial while `E` is trivial — Prop. 2 needs spatial `f` |
| **CE4** (Pfante et al. 2014) | 4-state chain, uniform start, `Z` merges {1,2},{3,4} | `Z` is i.i.d., so it is Markov and computationally closed (trivially). Yet `X_t` determines `Z_{t+1}`: `I(←X; Z_{t+1} \| ←Z) = 1` bit. **Markov in its own past, weakly lumpable, and not closed** |
| CE5 | Markov `X`, `Z_t = X_{t−1}` | Informationally closed but not computationally closed (`E′_t = E_{t−1}`). Thm 2 needs spatial `f` |
| CE6 | Deterministic cycle `a→b→c→d`, `Z` merges {a,b},{c,d} | Informationally closed, second-order Markov, not first-order strongly lumpable |
| CE7 | Geiger & Temmel 2014 chain | Strongly 2-lumpable, yet `I ≥ 0.18` bits — **not** closed |
| Noise / copies | `X = (Y, W)` with `W` i.i.d.; `X = (U, V)` with `U = φ(V)` | `W` is closed but computationally trivial; `U` and `V` are two "closed levels" with one computation. Closure alone **overcounts** levels |

So **Markovianity of `Z` is neither sufficient (CE4) nor necessary (CE6) for closure** (`T410`).

---

## Evidence / instantiations

| System | Coarse-graining | Result | Class |
|---|---|---|---|
| Elementary cellular automaton rule 150 (`X^k ← X^{k−1}+X^k+X^{k+1}` mod 2, periodic) | Parity | Conserved, `H = 1` bit of the micro's `n`; a non-trivial invariant (information storage) | (a) |
| Rule 60 (`X^k ← X^k + X^{k+1}` mod 2) | Parity | Always even: trivial invariant; marks the odd-parity states as unreachable | (c) |
| Invariants in general | Any conserved `f` | Always informationally closed. Non-trivial iff the Markov chain is reducible (the invariant labels the closed class) | (a)/(c) |
| Ehrenfest urn, `n` molecules | Count in chamber 1 | Strongly lumpable (Kemeny & Snell) ⇒ closed. Setting `Z` gives all achievable control over future `Z`; `I(X_t;X_{t+1})` splits into macro + residual (Prop. 3) | (a) |
| Ising, Glauber dynamics, permutation-invariant Hamiltonian | Energy `𝓔(X)` | `p(Z_{t+1} \| X_t) = ψ(z, 𝓔(x))` ⇒ closed | (a) |
| Random walk on modular network (`M` modules, within-weight `r_w` ≫ uniform between-weight `r_b`) | Module label; then module-size class | **Both** closed ⇒ three nested levels: size class → module → node | (a) |
| Agent-based mobility model (refugee flows; `n` agents on `L` locations) | Agents per location | Lumpable under stated conditions ⇒ exact simulation at cost scaling with `L` rather than `n` | (a) |
| Hopfield network, `n` units, `m` Hebbian patterns, synchronous stochastic update | Overlaps `Z^μ = (1/n) Σ_i p^μ_i X^i` | `h^j = Σ_μ p^μ_j Z^μ`, so `P(X_{t+1} \| X_t)` depends on `Z_t` only ⇒ `H(Z_{t+1}\|X_t) = H(Z_{t+1}\|Z_t)` ⇒ closed. **Retrieval is an `m`-dimensional macro computation** | (a) |

Scope note on the Hopfield row: the argument uses the source's **synchronous** product update. Under the classical asynchronous update ([[wiki/entities/hopfield-network.md]]), flipping unit `i` shifts `Z` by `−2p^μ_i X^i/n`, which depends on `X^i` and not only on `Z`. The argument then fails as written. **(brainstorm)** The standard repair in the statistical mechanics of attractor networks is to track sub-lattice magnetisations (units grouped by their pattern-sign vector, up to `2^m` groups), a finer level that is closed.

---

## What it says for building a reasoning model

| Consequence | Detail |
|---|---|
| **The exact price of denying a level its substrate** (`L2`) **(brainstorm)** | A module that reads only `Z` loses nothing against one that also reads `X` iff `Z` is informationally closed. Otherwise the loss is exactly `I(←X; →Z \| ←Z)`. This turns "what may this reader be denied" into a number: train the macro predictor with and without the lower level's state and read off the gap. It is the opposite direction to `G59`, which denies the lower level the upper level's observation; here the upper level is denied the lower's state, and closure says when that denial is free |
| **Plan on closed levels** | In a closed level, macro interventions achieve all the control over the macro future that micro ones could (Ehrenfest, Ising). An abstract plan over closed states is executable however the micro state is filled in. **(brainstorm)** Reinforcement learning's model-irrelevance / bisimulation abstraction (Givan, Dean & Greig 2003; not in the source) is strong lumpability with equal rewards added. Closure is the reward-free version, so it applies to a world model before any task is posed |
| **Find levels on the latent chain, not on the observations** (`G27`) | By Thm 3, lumpability algorithms find closed levels when they are run on the causal-state transition matrix. The source lists coarsest-lumpable partition by search trees, eigenvector methods, successively lumpable chains, spectral (Jacobi) and information-theoretic quasi-lumpability, and annealing to avoid collapsing to a trivial partition (Amjad, Blöchl & Geiger 2020). **(brainstorm)** [[wiki/entities/cscg.md]]'s clone transition matrix is an estimated causal-state chain, and CSCG already partitions it, but with InfoMap. A quasi-lumpability partition in InfoMap's place would label each room-level graph as exactly closed, or say how far from closed it is |
| **Modular graphs are only approximately closed** **(brainstorm)** | In the source's random walk, the module level is closed *because* between-module weights are uniform, so the exit distribution depends only on the current module. On a generic modular graph, which node of a room you are in changes which room comes next. So hierarchical planning over communities is approximate, by an amount `I(←X; →Z \| ←Z)` measures, and doorway-based partitions are the case where that dependence is largest |
| **Require strong, not weak, lumpability of a learned abstraction** **(brainstorm)** | A level that is only computationally closed (weakly lumpable) holds only near the stationary distribution. A policy change shifts that distribution (`G63`), so such an abstraction can break with no change in the world. Test: re-check Markovianity of `Z` under several initial or behaviour distributions; strong lumpability survives all of them |
| **Count modules in theory space** | Two closed levels with the same ε-machine are one computation, and a noise level maps to the top of the lattice. **(brainstorm)** A modular architecture's count of "independent levels" should be reported after this deduplication, otherwise redundant copies inflate it |
| **A per-level information budget** | Prop. 3 splits total predictive information across a chain of closed levels. **(brainstorm)** A capacity allocation per tier of a hierarchy could be read off as `Δ(Zᵏ, Zᵏ⁺¹)` instead of being hand-set |
| **Multiple realisability yes, substrate independence no** | The same software can run on many micro systems, but which closed levels exist is fixed by the micro transitions. **(brainstorm)** A substrate choice (weight symmetry, update order, as in the Hopfield scope note) is also a choice of which macro computations are available |

---

## Open problems

- **Exact closure is non-generic.** Most coarse-grainings break Markovianity; the source calls lumpability "the exception and not the rule". The theorems are exact, and the graded (quasi-lumpable) version that real or learned systems need is only cited, through algorithms. No theorem says what approximate closure buys. **Across systems the count goes the other way** (Israeli & Goldenfeld 2006, [[wiki/concepts/exact-coarse-graining.md]]): 240 of 256 elementary cellular automata have an exact coarse-graining, and the probability that a random rule has one rises toward 1 as block size grows. The two claims use different quantifiers (most partitions of one system fail; most systems have at least one partition that succeeds), so they are compatible. The cost is in finding the partition, not in whether one exists.
- **Closure needs the micro level.** Information closure conditions on `←X`. An agent that only receives `Z` cannot certify it from its own stream: in CE4, `Z` is i.i.d. and looks perfectly self-contained while the micro determines it (`T410`). Interventions on `Z` are the unexamined way out.
- **Estimation.** Large ε-machines are the practical bottleneck. The source points to information-bottleneck estimators and state-space modelling as promising directions and leaves the estimation procedure to future work.
- **Spatial only.** Thm 2 and Prop. 2 fail for temporal coarse-grainings (CE3, CE5). The wiki's temporal abstractions (options, events) are exactly that case ([[wiki/concepts/temporal-abstraction-options.md]]).
- **Passive, stationary, discrete.** No actions or transducer version. Counterfactual guarantees hold only if `X` is fully observed (otherwise Granger sense).
- **No selection among closed levels.** The lattice lists them all. Choosing which to instantiate needs another criterion: predictive efficiency ([[wiki/concepts/emergent-macrostates.md]]), or the coarse-graining's own computational cost (Wolpert et al. 2014, which the source names as future work).
- **Deterministic automata only.** Other machines in the Chomsky hierarchy are named but not developed.

---

## Connections

- **[[wiki/concepts/causal-states.md]]** — the object this page lifts to several levels: the υ-machine is the causal-state construction with the relevance variable moved to a coarser future. Thm 2 gives that page's missing hierarchical reconstruction, a lattice of strongly lumpable coarse-grainings of one ε-machine. It holds only for spatial, closed levels; in general (CE1) the macro ε-machine is not a coarse-graining of the micro one.
- **[[wiki/concepts/emergent-macrostates.md]]** — the observer-side companion: that page completes a carving until the macrostates predict their own future; this page asks whether the micro still predicts them better. CE4 shows the first test can pass while the second fails (`T410`). The two emergence criteria (efficiency `𝐄/C_μ` vs closure) also differ.
- **[[wiki/concepts/independent-causal-mechanisms.md]]** — answers part of that page's "coarse-graining has no general theory": the condition under which coarse variables carry self-contained dynamics is information closure (strong lumpability of the causal states), not Markovianity. The interventional reading holds only under full observation of the micro.
- **[[wiki/entities/hopfield-network.md]]** — the neural case study: with Hebbian weights, every unit's field is a function of the `m` pattern overlaps, so retrieval is a closed `m`-dimensional computation over an `n`-dimensional substrate. That holds under synchronous update; the asynchronous update that page uses needs a finer sub-lattice level.
- **[[wiki/concepts/abstraction.md]]** — a fourth state-abstraction criterion for family O2, beside reward relevance, reconstruction and predictive efficiency: a coarse level is legitimate when the level below has nothing further to say about it.
- **[[wiki/concepts/node-definition-problem.md]]** — a test for when a coarser vertex set is a level of its own rather than a summary: the coarse dynamics must be strongly lumpable from the fine ones. Most parcellations of a dynamical system fail it, which makes the non-convergence there expected.
- **[[wiki/concepts/mean-field-reduction.md]]** — the exact end of that ladder: the Ehrenfest count and the Ising energy are reductions that lose nothing about their own future. The neural mass's moment coupling is the measured case of a mean that is not closed.
- **[[wiki/concepts/information-bottleneck.md]]** — Prop. 1 states the υ-machine as that page's minimal sufficient statistic with `X` = micro past and `Y` = macro future. Thm 1 says closure is the case where the bottleneck can be taken at the macro level at no loss.
- **[[wiki/concepts/temporal-abstraction-options.md]]** — marks where the theory stops: closure ⇒ computational closure is proved only for spatial coarse-grainings and fails for temporal ones (CE5). Options and events coarse-grain time, so the guarantee does not reach them.
- **[[wiki/entities/cscg.md]]** — the system where Thm 3 could run today: the clone transition matrix is an estimated causal-state chain, and its offline InfoMap partition could be replaced or scored by a (quasi-)lumpability partition, which certifies whether each room level is closed **(brainstorm)**.
- **[[wiki/concepts/latent-graph-discovery.md]]** — says when a coarse graph of the latent graph is itself exact: the walk over communities must be strongly lumpable. Otherwise a planner on the quotient graph is approximate, by a measurable conditional mutual information.
- **[[wiki/concepts/exact-coarse-graining.md]]** — the deterministic, local version of this page's automaton-form closure, with a search attached: `P·f_A^T = f_B·P` for every initial condition, found by exhaustive or seed-and-close search over block projections of cellular automata. It adds the relevant/irrelevant split of what a closed level discards and a measured rise in the probability that a closed level exists as block size grows. This page's theory space is the filter that would separate its trivial Garden of Eden levels from non-trivial ones (Israeli & Goldenfeld 2006).
- **[[wiki/concepts/abstraction-graph.md]]** — **(brainstorm)** this page bounds the error on that graph's *lossy* edges: a rule stated over a coarse-graining that is computationally closed holds with `ε = 0`, and otherwise with an error the conditional mutual information measures — which is the "error register per coarse concept" its requirements table asks for and nothing tracks.
