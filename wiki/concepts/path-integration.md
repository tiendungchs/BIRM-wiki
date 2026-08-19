# Path Integration

**Maintain a latent position code by *accumulating the actions taken*, so a state's identity is the composition of the moves that reached it rather than anything about what is observed there.**

`z_t = f(W z_{t-1} + B a_t)` — position updated by action, observation never consulted. Everything this page is worth follows from that one line (Whittington et al. 2022).

---

## The argument: representation instead of computation

Two ways to code location on a graph, and the choice decides what the rest of the system has to do.

| | Unique identifier per node (place-cell-like) | Path-integrated code ((x,y)-like, grid-cell-like) |
|---|---|---|
| Shortest route between two nodes | Search over neighbours | Subtract the two codes — a vector |
| Add a new node | New cell **and** new synapses to every neighbour | Nothing: the code already extends there (periodically) |
| Transfer to a new environment of the same shape | Requires re-alignment of every node — *graph matching*, NP-hard | Free: all positions are treated alike, so any code can play any role |
| Sensory aliasing | Broken — identical observations collapse | Immune: the code is a function of actions, not observations |
| Cost | Capacity linear in states | A few composition rules |

> "By a clever choice of *representation*, grid cells prevent the need for *computation*." (Whittington et al. 2022)

This is the wiki's cleanest statement of what an abstract structural code is *for*: the payoff is not a tidier `g`, it is the deletion of an online search.

---

## What makes it work: the actions must compose

A path-integrable domain is one whose actions satisfy closure relations — the code is only a position if every route accumulating the same total displacement lands in the same place.

| Domain | Composition rule |
|---|---|
| 2-D space | `North + East + South + West = 0` |
| Kinship graph | `Parent + Sibling + Niece = 0` |
| Arithmetic on a line | `+n` then `−n` = identity |
| Social network ("knows") | **None** — no consistent action labelling exists |

Two consequences the wiki did not previously have:

- **Gap G3 gets a mechanism, not a brainstorm.** [[wiki/concepts/abstract-structural-codes.md]] proposed that a periodic code commutes because displacement is added to a phase, and marked it speculative. Path integration is that proposal implemented in four model families and observed in three animal phyla. Path-consistency is a property of the *update rule*; no loss term enforces it.
- **And it is a precondition, not a universal.** Not all graphs can be path-integrated, because consistent actions do not always exist across a family of graphs. Whether a domain admits a path-integrable code is a structural fact about the domain that nothing in the wiki currently tests for (gap G41). A learner that assumes composition where none holds will build a code that silently aliases.

**Compression is the second payoff.** Storing every relation in a kinship graph is `O(n²)` facts; storing the composition rules is `O(|actions|)`. Adding "Chloe is Bob's sibling" then *implies* "Chloe is Alice's grandchild" with no observation of that pair. This is the concrete form of "learn so that you do not have to learn".

---

## Implementations

| Model | Update | Where `W` comes from | Result |
|---|---|---|---|
| **Continuous attractor network (CANN)** | `τ dz/dt = −z + f(Wz + Ba)` | Hand-designed | Head-direction, place and grid tunings, depending on `W`. Physically real: the fly ring attractor exists in connectivity *and* anatomy; rodent grid populations lie on an attractor manifold |
| **Velocity-coupled oscillators (VCO)** | Phase interference between a theta rhythm and velocity-modulated dendritic oscillations | Hand-designed | Path-integrated distance along an axis = a plane wave; a grid cell is the sum of three at π/3 |
| **Trained RNN / LSTM** | Discrete-time `z_t = f(Wz_{t-1} + Ba_t)` | Learned by predicting supplied spatial targets (place-cell activity, or (x,y)) | Periodic units emerge — but often amorphous and *four*-fold symmetric |
| **Trained on raw sensory prediction** ([[wiki/entities/tolman-eichenbaum-machine.md]]) | Same, plus a memory read | Learned by predicting observations across many environments | Path integration in whatever latent space best predicts the sensory future — space when the world is spatial, task structure when it is not |

**The 4-fold → 6-fold transition has a single cause.** An analytic result attributes hexagonal symmetry to a third-order regularisation term on grid activity — implementable by the biological constraint that firing rates are non-negative. So the most-cited signature of an abstract structural code is a consequence of a non-negativity constraint, not of the task.

**Many maps in one CANN.** Because place codes for different environments are near-uncorrelated, a single continuous attractor stores many "charts" simultaneously (Battaglia & Treves, via Rolls 2013) — so map selection is attractor selection and needs no separate index. The same network can also hold **mixed** continuous and discrete patterns, retrieving a position from an associated object or the object from the position, which is the network-level mechanism for object-place binding.

**A dissent on the site.** Rolls 2013 argues the *bumpiness* of the CA3 spatial representation fits episodic storage better than path integration, and assigns integration to entorhinal cortex — so the CANN row above describes the formalism CA3 shares, not a claim that CA3 integrates ([[wiki/entities/rolls-treves-hippocampal-model.md]]).

**One rule, many velocity sources.** Chen et al. 2022 propose that the grid, place and head-direction cells recorded in rat primary somatosensory (S1) and secondary visual (V2M) cortex arise from *the same* integration principle running on each area's own self-motion signal — optic flow in visual cortex, proprioceptive and locomotor feedback in somatosensory cortex, head movement in auditory cortex — and are complementary yet functionally *independent* of the entorhinal integrator. Two things follow for this page: the update rule is the shared primitive and the modality only supplies `a_t`; and a brain runs several integrators concurrently, which is G40's composition question posed by anatomy rather than by task design ([[wiki/concepts/distributed-reference-frames.md]]).

**And at least two of them already integrate different quantities.** With visual and physical motion decoupled in mouse virtual reality, mEC grid cells predominantly follow *physical motion* while hippocampal place cells predominantly follow *visual input* (Chen et al. 2019). Mouse mEC grid firing also survives complete darkness on non-visual self-motion alone (Dannenberg et al. 2020) — the integrator is genuinely action-driven, as the defining equation requires.

**Why grids and not place fields for this job:** periodic codes extend to unvisited space; periodicity is inherently error-correcting; the same spatial precision costs far fewer cells; and grid cells are experimentally driven more by path-integration signals than place cells are.

---

## Where the observations come back in

Path integration alone drifts and cannot say *what is here*. Two couplings, and the wiki needs both:

| Coupling | Mechanism | Page |
|---|---|---|
| **Correct the code from the world** | Anchoring: boundaries and geometry reset position and heading | [[wiki/concepts/cognitive-map.md]] (G39) |
| **Read content off the code** | Bind observation to position in a fast memory, then predict by *integrate-then-retrieve* | [[wiki/entities/tolman-eichenbaum-machine.md]] |

The second is the important one architecturally: it makes sensory prediction a two-step operation — imagine the transition in `g`, then retrieve "what did I see the last time I was *here*" from `M`. The structural code never has to carry content, which is exactly the `g`/`x` factorization the wiki asks for, arrived at from an efficiency argument.

---

## Open problems

- **Which domains admit it?** No test decides whether a set of observed actions composes (G41). "Social networks merely describe generic relationships" is the paper's own counterexample and it has no diagnostic.
- **Where do the actions come from in an abstract domain?** In space, self-motion is measured. In a kinship graph or a task, the action labels are supplied by the modeller — this is hardness source 2 ([[wiki/concepts/latent-graph-discovery.md]]) untouched.
- **Composition of integrators.** A recipe is transferable across kitchens only if task-position and space are path-integrated *separately* and combined per instance; nothing specifies how many integrators to run or how they factorise (G40) — and the sensory-cortex results make this concrete rather than hypothetical, since several integrators demonstrably run at once with no known arbitration (G43).
- **Non-sequential domains.** The extension offered is analogical only: {size, shape, colour} of an object admit "actions" (add-red, bigger, remove-red, smaller) that return you to the same object, so a manifold with composition exists — but nothing learns it from unordered data here.
- **Precision under noise.** Periodicity is error-correcting for accumulated noise; nothing states the bound, or what happens at a module boundary.

---

## Connections

- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — shares the continuous-attractor formalism while declining to place path integration in CA3, and adds two properties of the same network type: many uncorrelated charts coexist, and continuous and discrete patterns can be stored together and retrieved from each other.

- **[[wiki/concepts/abstract-structural-codes.md]]** — supplies the mechanism behind that page's central speculation: `g` is path-consistent because it is *built* by composing displacements, so gap G3 is answered by the update rule rather than by a training signal — at the price of a precondition (the actions must compose) that page did not state.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the compressed alternative to storing the graph: path integration represents a node's position by the actions that reach it, which makes new nodes free and de-aliases (hardness source 3) without a sparse code.
- **[[wiki/concepts/cognitive-map.md]]** — the missing complement in both directions: path integration supplies the coordinates that anchoring must reset, and anchoring supplies the observations that stop the integrator drifting.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the architecture that turns this page's update rule into a learned system by pairing it with a relational memory, so the integrator is trained by predicting raw observations rather than supplied spatial targets.
- **[[wiki/entities/cscg.md]]** — the alternative solution to the same problem: de-alias by allocating a clone per context instead of by integrating actions. Fast and local but per-environment; path integration is slow to learn and reusable.
- **[[wiki/concepts/successor-representation.md]]** — the same computation in an eigenbasis: action-dependent transition matrices in space share eigenvectors and differ only in (complex) eigenvalues, so path integration reduces to successively adding eigenvalues, unifying attractor networks, oscillator models and predictive maps.
- **[[wiki/concepts/simulation-based-planning.md]]** — planning by vector arithmetic rather than by rollout: with a path-integrated code, "where is the goal from here" is a subtraction, which is the cheapest planner in the wiki and the one that needs no search.
- **[[wiki/concepts/compositionality.md]]** — composition here is *algebraic on actions* rather than part-whole on content, and it is the one form the wiki has whose closure is enforced by construction.
- **[[wiki/concepts/core-knowledge.md]]** — a plausible instance of an installed format: what would be innate is the composition rule set, with the resolution of the code trained afterwards.
- **[[wiki/concepts/distributed-reference-frames.md]]** — generalises this page's update rule across cortex: the same integration run once per modality on that modality's own velocity signal (optic flow, proprioception, head movement), which makes path integration the shared primitive and the input merely the supplier of `a_t`.
- **[[wiki/entities/temporal-context-model.md]]** — the leaky counter-proposal: with `ρ < 1` the same accumulation is a weighted sum over *recent* movements rather than a position, which bounds accumulated error without any error-correction machinery and is the only version that reproduces retrospective coding — at the cost of the exact metric this page trades on (tension T31).
