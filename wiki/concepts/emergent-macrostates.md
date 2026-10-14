# Emergent Macrostates — Which Coarse-Graining Is a Level of Description

**A macrostate set is the coarsest refinement of a chosen observation partition whose dynamics are Markovian, i.e. the causal states of the observed process. The observer picks the observables, and the microdynamics then fix the macrostates. A coarse level *emerges* from a finer one when it is a coarse-graining of it *and* is predicted more efficiently (`𝐄/C_μ` higher).**

[[wiki/concepts/causal-states.md]] gives the unique minimal optimal partition of one process. This page applies it to a process that is a **many-one view** `f` of a hidden Markov microdynamics. That turns it into a node-construction procedure with a computable stopping test (`G27`), and into a criterion for keeping a coarser level beside a finer one.

> **Provenance.** Shalizi & Moore 2003, *What Is a Macrostate? Subjective Observations and Objective Dynamics*, arXiv cond-mat/0303625 (`raw/shalizi-2003-what-is-a-macrostate-subjective-observations-objective-dynamics.md`). This is a conceptual paper. It has one worked calculation (argon) and no experiments. The theory is Shalizi & Crutchfield 2001. Two things are new here: the observation-partition setting, and the minimal-factor proposition (App. C). The ar5iv clip drops the text of footnotes 1–7.

---

## Formalism

| Object | Definition | Reading |
|---|---|---|
| Microdynamics | Phase space `Γ`, `𝐪_{t+1} = T𝐪_t`, possibly stochastic, with no hidden variables (so `{𝐪_t}` is Markov). The ensemble need not be invariant | The world. Never observed |
| Observation | `f : Γ → Ξ`, many-one, giving the partition `ℱ` of `Γ`. Observed process `S_t = f(𝐐_t)`, **not necessarily Markov** | The agent's sensors plus its interests: "a mixture of interest and feasibility" |
| History refinement | `ℱ_{x,y} = ℱ_y ∩ Tℱ_x`, extended to countable sequences | Each observation sequence picks out a finer region of `Γ` |
| Causal partition | The causal states `𝒮` of `S`, mapped back to a partition `𝒢` of `Γ` that is coarser than the infinite-history partition | Each causal state is a phase-space region, so "in principle" some coarse instrument could read it directly |
| `𝒳` | The partition of histories by their *present* observation | `𝒮 = 𝒳 ⟺ ℱ = 𝒢` |
| **Minimal factor** (Prop. 2) | `B` a refinement of `A` ⟹ there is a `C` with `B = A·C` and the fewest cells, `\|C\| = max_a n_a`, where `n_a` is the number of `B`-cells inside cell `a` of `A`. There are at most `∏_a n_a!` minimal factors, and each is **incomparable** with `A` | The smallest extra variable that completes a partition |
| **Predictive efficiency** | `𝐄 / C_μ` | The fraction of the information stored about the past that actually bears on the future |
| **Emergence** | `U` emerges from `V` iff (1) `U` is a coarse-graining of `V`, and (2) `𝐄_U/C_μ,U > 𝐄_V/C_μ,V`. The reverse case is called **submergence** (Crutchfield, personal communication) | A level is worth keeping when its own dynamics are more informative about themselves |

Identities when the observables already are the causal states (`ℱ = 𝒢`):

- `C_μ = H[S] = H[𝐐] − H[𝐐|S] = I[𝐐 ; S]`: statistical complexity equals the information the macrovariables carry about the microstate.
- For a first-order Markov chain, `𝐄 = C_μ − h_μ`.

When `𝒢 = ℱ·𝒵`:

- `H[𝒮] = H[S] + H[Z|S]`, and `H[Z|S]` is the **same for every minimal factor** `Z`.
- `I[𝒮 ; Z] = H[Z]` and `I[𝒮 ; Z | S] = H[Z|S]`: everything a factor carries is relevant to the causal state.

---

## The four cases: observation partition vs causal partition

| Case | Meaning | Repair | Physical example |
|---|---|---|---|
| **1. `𝒢 = ℱ`** | The observables are their own causal states. They are Markovian, and nothing predicts them better than their present value | None | Pressure, volume and temperature of an ideal gas near equilibrium |
| **2. `𝒢` finer than `ℱ`** | **Memory effects.** The observed dynamics are non-Markovian, and the current observables cannot be predicted optimally | (a) Observe a minimal factor `Z`: then `(S, Z)` is Markovian. *Which* factor is a practical choice (accessibility, smoothness, measurement noise); *how much* it carries, `H[Z\|S]`, is fixed. (b) If no factor is accessible, build the causal state from observation **histories** | Ferromagnetic hysteresis: response as a function of the field history ≡ a function of (current field, magnetisation). Chaotic dispersion in fluid jets (Lacorata et al.) |
| **2′. Many timescales** (an apparent counterexample) | Spin glasses respond differently over 16 orders of magnitude in frequency. Frustration creates many local minima, and crossing times grow exponentially with barrier height | Take as macrovariables the **occupancy probabilities of the metastable minima reachable on the observation timescale**. Treat higher barriers as infinite. The history of probability leakage between basins is not needed | "A macroscopic number of macroscopic degrees of freedom". The ensemble is always ageing and never equilibrated |
| **3. `𝒢` coarser than `ℱ`** | Some observed distinctions make no difference to the future | Merge. Three reasons: (i) a variable is **irrelevant** given the others; (ii) an **unphysical distinction** — the nematic director `𝐧 ≡ −𝐧`, so the observed sign is pure chance; (iii) a variable is **unpredictable at the sampling interval** and washes out. In the extreme the observed process is i.i.d. and `𝒢` is trivial | Ideal gas sampled once a year: pressure and internal energy have no predictive value |
| **4. Incomparable** | Listed, not analysed | — | — |

**Procedure** ("men in black" story, §VI):

1. Choose observables by interest and feasibility.
2. Refine using observation histories.
3. Build the causal states.
4. Add factor variables (new instruments, or logical constructions from history), or drop unphysical and unpredictive distinctions.
5. Stop when the macrostates are their own causal states.

The end point is the minimal variable set that predicts the chosen observables optimally and is causally complete. *"For every question we ask It, Nature has a definite answer; but Nature has no preferred questions."*

---

## Levels of description

| Claim | Statement |
|---|---|
| **Coexisting levels** | Different measurement partitions induce different causal states. Thermodynamic and hydrodynamic descriptions coexist "because they are intended to answer different questions — not because one is more objective than the other" |
| **Markov is not inherited** | A coarse-graining of a Markovian partition is generally not Markovian. Its causal states lie between the coarse partition and the fine one, and can coincide with the coarse one |
| **Argon, 1 cm³, fixed T, P, N** | Macro (internal energy, 1 ms step): `C_μ = 33.3` bits, `h_μ = 4.4`, `𝐄 = 28.9`, **efficiency 0.87**. Micro (1 ns step): `C_μ = 6.6·10²⁰` bits, `h_μ = 3.3·10²⁰`, `𝐄 = 3.3·10²⁰`, **efficiency 0.5**. At matched resolution, macro efficiency is ≈ 1 and micro efficiency at the macro timescale is ≈ 0 |
| **Hydrodynamics → thermodynamics** | Thermodynamics emerges from hydrodynamics (per Shalizi's thesis). Local densities are not predicted from global quantities, and global sums do not need local densities. The source also says "the hydrodynamic level itself emerges from the thermodynamic one". Its own definition rules that out, since emergence requires a coarse-graining, so it is probably a slip for the molecular level |
| **Local causal states form a Markov random field** | They therefore have a Gibbs distribution over configurations. Coherent structures in non-equilibrium flows that obey Gibbs statistics (vortex lines) are read as local causal states. *"If what we find doesn't look Gibbsian, it means we can do better"* |
| **Cellular automata and lattice gases** | Understanding comes from deliberately discarding microscopic detail to find coarse observations with Markovian dynamics (lattice-gas hydrodynamics, the Creutz automaton, Potts vortices). Spatial computational mechanics filters out low-information domains to expose emergent structures |

---

## What it says for building a reasoning model

| Consequence | Detail |
|---|---|
| **A computable stopping test for the node set** (`G27`) | Nodes are finished when they predict their own future: `I[→S ; ←S \| current node] = 0`. The test is computed from the stream and needs no threshold on surprise. It is relative to `f`: the criterion completes a carving and does not choose the observables. **(brainstorm)** Every `G27` family can be scored by it after the fact. A segmenter's events are a legitimate level iff the event sequence is Markov. **Contested** (Rosas et al. 2024, [[wiki/concepts/computational-closure.md]], `T410`): a Markov coarse level can still be fully predicted by the micro level it came from. In their Counterexample 4 the macro process is i.i.d. while the micro state fixes the next macro symbol (1 bit). So the test certifies predictive completeness relative to the observables, not self-containment, which needs `I(←X; →Z \| ←Z) = 0` (strong lumpability) |
| **A non-Markovian residual is the trigger to create a variable, and the factor's size is fixed** | Case 2 says when a latent variable is missing: history still predicts beyond the present node. It also says how much the variable must carry, `H[Z\|S]`, the same for every minimal factor. **(brainstorm)** The two repairs, *new instrument* and *construct from history*, are active sensing and a working-memory register. They are two realisations of one factor. App. B's case is position-only observation, which is second-order; adding velocity makes it first-order. This is a missing state variable, not `G69`'s minted individual |
| **Re-carving moves a density prior** | Merging cells is a regrouping. A uniform prior on {black, white, coloured} becomes `2(1−θ′)` on {black, non-black}, so a learner with a density or max-entropy prior over its node alphabet changes its beliefs when it merges or factors states, with no new evidence. No acceptable density is regrouping-invariant universally. The universal prior `2^{−K}` is approximately invariant, because it weighs a hypothesis's description rather than its volume (Rathmanner & Hutter 2011, [[wiki/concepts/universal-induction.md]]). **(brainstorm)** The quotient and factor moves on this page therefore need the prior carried as a description-length weight, or re-weighted at each merge |
| **Merging finds invariances** | Case 3(ii) discovers a symmetry as a **quotient**: if the sign of `𝐧` is unpredictable, identify `𝐧` with `−𝐧`. **(brainstorm)** The nuisance group is read off predictive statistics rather than declared, which is the move `G95` asks for. It is limited to distinctions the dynamics randomise |
| **The node set is indexed by sampling interval** | Case 3(iii) and the spin-glass case: one system, one `f`, different `Δt`, different macrostates. **(brainstorm)** A level is the triple `(f, prediction target, Δt)`. Nothing here chooses `Δt`; it is a scale variable left exogenous (`G67`) |
| **A selection rule among abstraction levels** | Keep a coarse level iff its predictive efficiency exceeds the level below. This is a third state-abstraction criterion, beside reward relevance (*hide what is not reward-critical*, and Nachum's return bound) and reconstruction ([[wiki/concepts/abstraction.md]]). It consults neither reward nor reconstruction. **(brainstorm)** It is a candidate rule for which tiers a hierarchy instantiates. It answers which levels, not how many tiers the meta-graph needs (`G9` unchanged) |
| **Basin occupancy as the state when timescales do not separate** | Case 2′ makes the node a *distribution over metastable attractors reachable within `Δt`*, not a point. **(brainstorm)** This links to [[wiki/concepts/attractor-dynamics.md]]: at each timescale the right state of a multistable store is its basin-occupancy vector, and barriers above the timescale define the effectively disconnected components of the graph |
| **The observation map is a design commitment, not a nuisance** | The source accepts that the causal states depend on the initial observables. That is non-invertible observation dependence, which says nothing directly about `T409`'s invertible recodings but locates `C_μ` relative to `f` on Position A's own side |
| **The Gibbs diagnostic** **(brainstorm)** | For a spatial decomposition (objects, slots, parcels), local causal states form a Markov random field and so are Gibbsian. Fitting a Gibbs model with local potentials to the discovered units' configuration statistics, and finding a misfit, flags an incomplete local state set. The test is untried, and the source's own example is qualitative |

---

## Open problems

- **The observables are given.** The procedure starts from `f`, which comes from "interest and feasibility". So `G27`'s carving of a raw continuous stream into a first alphabet is untouched, and so is `G75`'s parse choice.
- **Which minimal factor?** There are up to `∏ n_a!` of them, all carrying the same `H[Z|S]`. Selection is "practical considerations" with no stated criterion. **(brainstorm)** Smoothness over `Γ` or reachability by an action are candidates (cf. [[wiki/concepts/independent-causal-mechanisms.md]]'s intervenability).
- **Case 4 (incomparable partitions) is not analysed.** It is probably the generic case for a learned `f`.
- **Reusable macrovariables are unexplained.** Temperature works across radically different microphysics; order parameters do not transfer (a nematic director means nothing in an antiferromagnet). The authors have no answer. This is the meta-graph question of [[wiki/concepts/latent-graph-discovery.md]] in physical form: which variables survive across environment families.
- **Why extensive variables?** A sketch is given: sums over near-independent subsystems satisfy large-deviation principles, which makes them good observables. Untested.
- **Finite samples.** Everything assumes exact conditional distributions. Reconstruction algorithms "converge under mild assumptions", with no rates (as on [[wiki/concepts/causal-states.md]]).
- **The emergence criterion compares levels at mismatched timescales.** The authors concede the argon comparison is "unfair" to the macro level. No protocol says at which `Δt` two levels should be compared.
- **Passive only.** As on [[wiki/concepts/causal-states.md]], no actions. An agent's policy would make the macrostates policy-dependent (`G63`).

---

## Connections

- **[[wiki/concepts/causal-states.md]]** — the theory this page applies. That page gives the unique minimal optimal partition of a given process. This page makes the process a many-one view of hidden microdynamics, so the same construction becomes a refine-or-merge procedure over observables and a relation between levels.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the framing's node set for a fixed observation map: nodes are the coarsest Markovian refinement of what is observed. The unexplained reusability of temperature is the meta-graph question asked of physics.
- **[[wiki/concepts/node-definition-problem.md]]** — answers that page's non-convergence complaint conditionally: once the observables and prediction target are fixed, a unique coarsest Markovian vertex set exists. The residual freedom is moved into the choice of observables and of `Δt`, where that page's conservation law still applies.
- **[[wiki/concepts/mean-field-reduction.md]]** — supplies the legitimacy test for each rung of that ladder: a rung is a level iff its state is Markovian. The neural mass's after-offset ringing, which depends on how synchronised the ensemble became, is case 2: the mean alone has memory, and a variance-like factor is the missing variable **(brainstorm)**.
- **[[wiki/concepts/abstraction.md]]** — adds a third state-abstraction criterion to family O2: Markov closure plus predictive efficiency. It consults neither reward nor reconstruction, and it selects levels rather than ranks them by rule order.
- **[[wiki/concepts/predictive-information.md]]** — supplies `𝐄`, the numerator of predictive efficiency. Emergence is defined as a ratio of that page's finite-class quantity to `C_μ`, so the criterion is undefined in the divergent classes.
- **[[wiki/concepts/attractor-dynamics.md]]** — the spin-glass case reads a multistable landscape at a timescale: the macrostate is the occupancy distribution over basins reachable within `Δt`, and barriers above `Δt` disconnect the graph.
- **[[wiki/concepts/event-segmentation.md]]** — a scoring rule for its detectors: a segmentation is a legitimate level iff the event sequence is Markov, which is computed from the stream instead of from a surprise threshold.
- **[[wiki/concepts/independent-causal-mechanisms.md]]** — gives a partial answer to that page's "coarse-graining has no general theory": Markov closure of the coarse variables is a stated sufficient condition for a self-contained coarse dynamics. It is Humean screening-off, not well-defined interventions, so the interventional half stays open.
- **[[wiki/concepts/computational-closure.md]]** — the micro-side test this page's observer-side test lacks: a level is self-contained only when the micro past adds nothing to predicting it (information closure, equivalently strong lumpability of the causal states), which a Markov macro level can fail (`T410`). It also gives a second emergence criterion beside `𝐄/C_μ`: closure plus non-trivial computation, read off a lattice of ε-machines.
- **[[wiki/concepts/universal-induction.md]]** — supplies the prior that survives this page's merges: merging observation cells is a regrouping, under which every density prior shifts and the universal prior is approximately invariant, so a learner that re-carves its node set needs description-length weights or it changes its beliefs with no evidence (Rathmanner & Hutter 2011).
- **[[wiki/concepts/exact-coarse-graining.md]]** — cites this page for the same objectivity position (the system fixes which projections are valid, interest picks among them) and runs it as a search over exact block projections of cellular automata. Its irrelevant-DOF merges are this page's case 3, and its relevant-DOF merges are the lossy levels this page's emergence criterion would rank (Israeli & Goldenfeld 2006).
