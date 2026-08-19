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

**Composition is a monoid, not a group — order matters.** The requirement is *path-invariance*, not commutativity, and the two come apart as soon as the domain is not Euclidean. TEM implements each action as its own weight matrix `W_a` and composes by matrix product, so `uncle = father ∘ brother ≠ brother ∘ father` is expressible and is explicitly demanded of the learned code (Whittington et al. 2020). Two corrections to this page's earlier framing follow:

- The "displacement added to a phase" intuition inherited from [[wiki/concepts/abstract-structural-codes.md]] describes the *abelian* special case. Kinship, transitive orders and task-cycle structure are non-abelian or at least order-sensitive, and a phase-addition code cannot represent them.
- What G3 actually needs is that every route reaching a given state produce the same `g` — a statement about the *relations that hold* in the domain, which a learned per-action operator can satisfy without commuting in general.

**The two constraints that generate the code.** Stated at their sharpest, `g` needs only: (1) **distinctness** — different states get different codes, or memories written at them collide; (2) **path-invariance** — the same state gets the same code from any direction, or the memory cannot be found. Both are consequences of `g` being used as a *memory address*, not of anything spatial. Whittington et al. 2020 claim these two are sufficient to produce grid and band codes, with no spatial target anywhere in the loss ([[wiki/concepts/objective-identifiability.md]], [[wiki/empirical-tensions.md]] T38).

Two consequences the wiki did not previously have:

- **Gap G3 gets a mechanism, not a brainstorm.** [[wiki/concepts/abstract-structural-codes.md]] proposed that a periodic code commutes because displacement is added to a phase, and marked it speculative. Path integration is that proposal implemented in four model families and observed in three animal phyla. Path-consistency is a property of the *update rule*; no loss term enforces it.
- **And it is a precondition, not a universal.** Not all graphs can be path-integrated, because consistent actions do not always exist across a family of graphs. Whether a domain admits a path-integrable code is a structural fact about the domain that nothing in the wiki currently tests for (gap G41). A learner that assumes composition where none holds will build a code that silently aliases.

**Sequence memory is the third payoff, and it is not spatial.** Chandra et al. 2023 chain the code by recalling, at each step, only the **2-D velocity that reaches the next state** rather than the next state itself. Chaining full grid states fails at ~30 steps — the same regime as an asymmetric Hopfield network — while chaining shifts reaches ~10⁵ steps in the same circuit, and recall length falls only as the *log* of the number of distinct admissible shifts. The general statement: on any latent with an action algebra, a sequence memory can pay `log|actions|` bits per step instead of `O(N)`, because the manifold's own dynamics regenerate the state. This makes path integrability a **capacity** argument for non-spatial episodic memory, not only a transfer argument ([[wiki/entities/vector-hash.md]]).

**Compression is the second payoff.** Storing every relation in a kinship graph is `O(n²)` facts; storing the composition rules is `O(|actions|)`. Adding "Chloe is Bob's sibling" then *implies* "Chloe is Alice's grandchild" with no observation of that pair. This is the concrete form of "learn so that you do not have to learn".

---

## Implementations

| Model | Update | Where `W` comes from | Result |
|---|---|---|---|
| **Continuous attractor network (CANN)** | `τ dz/dt = −z + f(Wz + Ba)` | Hand-designed | Head-direction, place and grid tunings, depending on `W`. Physically real: the fly ring attractor exists in connectivity *and* anatomy (Seelig & Jayaraman 2015, [[wiki/entities/fly-central-complex.md]]); rodent grid populations lie on an attractor manifold |
| **Velocity-coupled oscillators (VCO)** | Phase interference between a theta rhythm and velocity-modulated dendritic oscillations | Hand-designed | Path-integrated distance along an axis = a plane wave; a grid cell is the sum of three at π/3 |
| **Trained RNN / LSTM** | Discrete-time `z_t = f(Wz_{t-1} + Ba_t)` | Learned by predicting supplied spatial targets (place-cell activity, or (x,y)) | Periodic units emerge — but often amorphous and *four*-fold symmetric |
| **Trained on raw sensory prediction** ([[wiki/entities/tolman-eichenbaum-machine.md]]) | Same, plus a memory read | Learned by predicting observations across many environments | Path integration in whatever latent space best predicts the sensory future — space when the world is spatial, task structure when it is not |
| **Action-generated operator** ([[wiki/entities/mm-tem-hippoformer.md]]) | `g_t = ℓ2(W^g_t g_{t-1})` with `W^g_t = f_g(a_t)` produced by an MLP from the action | Learned by predicting observations, plus a feedback correction from the relational memory | One network generates a transition matrix *per action* instead of storing one, so a continuous or unseen action is expressible; grid period is set by the prediction horizon |

**The 4-fold → 6-fold transition has a single cause — contested.** An analytic result attributes hexagonal symmetry to a third-order regularisation term on grid activity — implementable by the biological constraint that firing rates are non-negative. So the most-cited signature of an abstract structural code would be a consequence of a non-negativity constraint, not of the task.

**But the trained-RNN row above is largely an artefact of the supervised target.** Across >11,000 networks swept over architecture, activation, optimizer and seed, most learn to path-integrate optimally and almost none develop grid-like units; grids appear only with Difference-of-Softmaxes readout targets (not Cartesian, polar, Gaussian, or equi-norm difference-of-Gaussians), their period is set monotonically by the readout width `σ_E`, only one module ever forms, and they vanish entirely once the readout population is given place-cell-like heterogeneity (multiple fields, multiple scales) while position decoding stays just as good (Schaeffer et al. 2022). The mechanism is that gradient descent on a readout reconstruction loss behaves like attractor dynamics whose interaction kernel *is* the readout correlation matrix — so a centre–surround target hand-builds the pattern-forming instability, and path integration contributes none of it. Two consequences for this page: the "Trained RNN" row is a demonstration that the *representation* is installable by choice of target, not that the task selects it; and G3 stays answered by the **update rule** (a hard architectural commitment) rather than by any objective ([[wiki/concepts/objective-identifiability.md]], [[wiki/empirical-tensions.md]] T38).

**The prediction horizon sets the scale.** In mm-TEM the relational memory is written only every `m_b` steps, so between writes the network must predict 1…`m_b` steps ahead with no access to the intervening `(g, s)` pairs — and the emergent grid period scales *monotonically with `m_b`*: long horizon → coarse grid, short horizon → fine grid, with no multiscale place basis supplied anywhere (Li et al. 2026, [[wiki/entities/mm-tem-hippoformer.md]]). This is the wiki's first mechanism for grid-scale *diversity* that is neither a hand-set module structure nor a reconstruction target's width: run the same integrator at several prediction horizons and the modules fall out. Two qualifiers. It is a **training-time** effect — a model trained at `m_b = 1` and tested at `m_b = 8` keeps its original scale, because the scale lives in the learned action→`g` map and in the stored `g`–`x` pairings, so the biological analogue would have to be a developmental gradient rather than a dynamic one. And only one scale forms per trained model, so the multi-module code remains unbuilt (the same hole Schaeffer et al. 2022 identify).

**And grid quality buys long-horizon accuracy — correlationally.** Across mm-TEM seeds and hyperparameters, grid score in the path-integration units predicts 512-step imagination accuracy (Pearson `r = 0.647, p = 2e-4`; Spearman `ρ = 0.783, p = 1e-6`). This is the wiki's first quantitative link from *how grid-like* a structural code is to *how well the system reasons* with it, and the first evidence that the periodicity is doing work rather than being a decorative by-product. What blocks the causal reading: no intervention on the code, and the same paper reports models with low grid scores and high accuracy that solve the task with a non-periodic representation, so periodicity is sufficient here and demonstrably not necessary ([[wiki/empirical-tensions.md]] T44).

**Many maps in one CANN.** Because place codes for different environments are near-uncorrelated, a single continuous attractor stores many "charts" simultaneously (Battaglia & Treves, via Rolls 2013) — so map selection is attractor selection and needs no separate index. The same network can also hold **mixed** continuous and discrete patterns, retrieving a position from an associated object or the object from the position, which is the network-level mechanism for object-place binding.

**The bump has a velocity of its own, and it competes with the action signal.** Add to the same CANN a slow negative-feedback current tracking recent activity (`τ_v dV/dt = −V + mU`, `τ_v ≫ τ`) and the bump's speed becomes proportional to the *lag* between activity and adaptation: `τ A_u dz/dt = s_v A_v + ⟨I^ext, u₁⟩` (Li, Chu & Wu 2024, [[wiki/entities/adaptive-cann.md]]). Three consequences for this page. (i) Motion no longer requires `a_t` — above `m = τ/τ_v` the bump travels at an intrinsic speed `v_int = (a/τ_v)√(mτ_v/τ − √(mτ_v/τ))` in complete silence, so "drift in darkness" and "spontaneous sweep" are the same term at different gains. (ii) When a velocity input *is* present, the two drives compete, and if `v_int > v_ext` the bump **leads** the input with a lead time `t_ant ≈ (A_uτ_v/α)(m − τ/τ_v)` that is independent of input speed — which is the measured 20–25 ms speed-independent anticipation of anterior-thalamic head-direction cells, obtained with no forward model and no delay estimate. (iii) At intermediate gain the tracking state becomes a limit cycle (Hopf bifurcation) whose frequency lands in the theta band and is independent of running speed, reproducing theta sweeps and phase precession — so an integrator does not necessarily report its current estimate, it may report a scan around it.

**A dissent on the site.** Rolls 2013 argues the *bumpiness* of the CA3 spatial representation fits episodic storage better than path integration, and assigns integration to entorhinal cortex — so the CANN row above describes the formalism CA3 shares, not a claim that CA3 integrates ([[wiki/entities/rolls-treves-hippocampal-model.md]]).

**One rule, many velocity sources.** Chen et al. 2022 propose that the grid, place and head-direction cells recorded in rat primary somatosensory (S1) and secondary visual (V2M) cortex arise from *the same* integration principle running on each area's own self-motion signal — optic flow in visual cortex, proprioceptive and locomotor feedback in somatosensory cortex, head movement in auditory cortex — and are complementary yet functionally *independent* of the entorhinal integrator. Two things follow for this page: the update rule is the shared primitive and the modality only supplies `a_t`; and a brain runs several integrators concurrently, which is G40's composition question posed by anatomy rather than by task design ([[wiki/concepts/distributed-reference-frames.md]]).

**And in the one abstract case, the velocity signal is explicit.** Where "movement along attribute dimensions" was a phrase, Constantinescu et al. 2016 give it a form: a trajectory through a two-attribute concept space has direction `θ = atan2(dℓ/dt, dn/dt)` — the *ratio of the rates of change* of two features (leg and neck length of a morphing bird) — and hexagonal modulation by `θ` appears in entorhinal and ventromedial prefrontal cortex, specific to sixfold symmetry. Three things follow: `a_t` in an abstract domain can be a vector of attribute derivatives, which is available whenever the domain has continuous attributes and no actions at all; the code is stable enough to cross-validate its orientation over a week, so this is a persistent frame rather than a within-trial construction; and it is a *closure-friendly* case by construction, because attribute increments commute — so it says nothing about the non-abelian domains this page's open problems name (G41).

**And they need not agree about which cue stream to trust** ([[wiki/empirical-tensions.md]] T46).

**And at least two of them already integrate different quantities.** With visual and physical motion decoupled in mouse virtual reality, mEC grid cells predominantly follow *physical motion* while hippocampal place cells predominantly follow *visual input* (Chen et al. 2019). Mouse mEC grid firing also survives complete darkness on non-visual self-motion alone (Dannenberg et al. 2020) — the integrator is genuinely action-driven, as the defining equation requires.

**Why grids and not place fields for this job:** periodic codes extend to unvisited space; periodicity is inherently error-correcting; the same spatial precision costs far fewer cells; and grid cells are experimentally driven more by path-integration signals than place cells are.

---

## Where the observations come back in

Path integration alone drifts and cannot say *what is here*. Two couplings, and the wiki needs both:

| Coupling | Mechanism | Page |
|---|---|---|
| **Correct the code from the world** | Anchoring: boundaries and geometry reset position and heading | [[wiki/concepts/cognitive-map.md]] (G39) |
| **Read content off the code** | Bind observation to position in a fast memory, then predict by *integrate-then-retrieve* | [[wiki/entities/tolman-eichenbaum-machine.md]] |

**And a third that is really the first run backwards.** The same memory read content-addressed by the *sensorium* — `p^x_t = attractor(x̃_t, M_{t−1})` — returns the set of previously visited places carrying a similar observation, and that set is fed into the posterior over `g_t` alongside the path-integrated estimate (Whittington et al. 2020). So drift correction needs no boundary, no landmark and no anchoring machinery: recognising *what* you are seeing partially tells you *where* you are, using the same store that the forward direction writes. This is anchoring implemented as memory recall rather than as a reset (G39).

**And the arbitration is a reset, not a blend — measured.** In the fly ellipsoid body the whole integrating population can be imaged at once, so cue conflict is directly testable ([[wiki/entities/fly-central-complex.md]]). Displace the landmark instantaneously and the heading bump jumps to follow it while *preserving its offset*; vary the closed-loop gain between the animal's turning and the scene's rotation and the bump tracks the **cue**, scaling only weakly with the animal's own rotation. So when landmark and self-motion disagree, the landmark overwrites the integrator rather than being averaged into it. Two further measurements this page previously had to assume: in darkness the same population integrates turning *and visibly drifts*, missing small and slow rotations; and with the animal standing in darkness — no landmark, no velocity — the code persists for >30 s. Drift is therefore not a modelling concession but the measured cost of the update rule, and correction is discrete. One qualification: the bump does not always jump instantly (a second displacement in the same trial moved it slowly), so the reset has its own time constant, which no model here has.

The second coupling is the important one architecturally: it makes sensory prediction a two-step operation — imagine the transition in `g`, then retrieve "what did I see the last time I was *here*" from `M`. The structural code never has to carry content, which is exactly the `g`/`x` factorization the wiki asks for, arrived at from an efficiency argument.

---

## Open problems

- **Which domains admit it?** No test decides whether a set of observed actions composes (G41). "Social networks merely describe generic relationships" is the paper's own counterexample and it has no diagnostic.
- **Where do the actions come from in an abstract domain?** In space, self-motion is measured. In a kinship graph or a task, the action labels are supplied by the modeller — this is hardness source 2 ([[wiki/concepts/latent-graph-discovery.md]]) untouched.
- **Composition of integrators.** A recipe is transferable across kitchens only if task-position and space are path-integrated *separately* and combined per instance; nothing specifies how many integrators to run or how they factorise (G40) — and the sensory-cortex results make this concrete rather than hypothetical, since several integrators demonstrably run at once with no known arbitration (G43).
- **Non-sequential domains.** The extension offered is analogical only: {size, shape, colour} of an object admit "actions" (add-red, bigger, remove-red, smaller) that return you to the same object, so a manifold with composition exists — but nothing learns it from unordered data here.
- **Precision under noise.** Periodicity is error-correcting for accumulated noise; nothing states the bound, or what happens at a module boundary.
- **Path integration is not a sufficiently constraining task.** No trained system in the wiki produces the *multi-module* code that makes the biological one unambiguous over large ranges, and adjacent-period ratios come out near 1 rather than ≈1.4. The proposed missing constraints are exponential coding capacity, intrinsic error correction and whitened information across cells (Schaeffer et al. 2022) — none of which is an objective anything here optimizes ([[wiki/concepts/objective-identifiability.md]]).

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
- **[[wiki/concepts/objective-identifiability.md]]** — the audit of this page's own evidence base: training on this update rule's task does not yield grid cells generically, so the hexagonal code is an architecture-and-target result rather than something the path-integration objective selects.
- **[[wiki/entities/temporal-context-model.md]]** — the leaky counter-proposal: with `ρ < 1` the same accumulation is a weighted sum over *recent* movements rather than a position, which bounds accumulated error without any error-correction machinery and is the only version that reproduces retrospective coding — at the cost of the exact metric this page trades on (tension T31).
- **[[wiki/entities/vector-hash.md]]** — converts this page's update rule into a memory-capacity result: storing the tangent vector rather than the state raises sequence capacity from ~30 to ~10⁵ steps with no change in network size, and the *metric ordering* of the visited states is separately what lets return weights learned on `O(MK_max)` states stabilise `O(K^M)` of them — so path integrability buys capacity and generalisation, not only path-consistency.
- **[[wiki/entities/tem-transformer.md]]** — identifies this page's update rule with a transformer's position encoding: `e_{t+1} = σ(e_t W_a)` learned per action makes the usual sinusoidal encoding the degenerate case (one action repeated), and it supplies a drift-correction mechanism as a second attention head keyed on the stimulus rather than as an anchoring reset.
- **[[wiki/entities/spiking-tem.md]]** — the update rule realised in leaky integrate-and-fire units with no spatial target, plus a determinant of whether it gets built at all: grid coding peaks at *intermediate* sensory ambiguity (~20 sensory neurons for 64 states) and collapses when observations uniquely identify position, so a periodic `g` is a compensation for aliasing rather than a general consequence of integrating actions — and its 4-fold-only grids independently support this page's non-negativity account of the 4→6-fold transition, since no such constraint was imposed.
- **[[wiki/entities/mm-tem-hippoformer.md]]** — supplies a determinant of the code's *scale* rather than of its existence: the interval between memory writes sets how far ahead the network must predict, and that horizon sets the grid period (coarser with longer horizon), with no multiscale place basis supplied — plus the first quantitative link from grid quality to reasoning performance (grid score vs 512-step imagination accuracy, ρ = 0.78) and the control that qualifies it, since the horizon only shapes the code during training and changing it at test time leaves the scale untouched.
- **[[wiki/entities/fly-central-complex.md]]** — this page's update rule caught in the act in a complete, identified population: an anatomical ring carrying one bump, integrating angular velocity in darkness with measurable drift, holding its state >30 s with no input, and resetting to a visual landmark by offset preservation rather than by blending — so drift, persistence and anchoring are measurements here rather than modelling assumptions.
- **[[wiki/concepts/population-geometry.md]]** — the composition-of-integrators question made concrete in one recorded population: on the CA1 manifold a trial advances along a position gradient and *splits* along an independent accumulated-evidence gradient, so a spatial integrator and a non-spatial one share the same cells while remaining separable directions in the geometry — and the manifold's dimensionality drops when the task supplies fewer quantities to integrate.
- **[[wiki/entities/adaptive-cann.md]]** — the same substrate moved by an internal rather than an external velocity: a slow adaptation current lagging the bump generates motion with no `a_t` at all (`τA_u dz/dt = s_v A_v`), so intrinsic mobility and the action-driven update are competing drives on one bump — and their competition is what makes tracking *anticipative*, with a lead time independent of input speed.
- **[[wiki/entities/thousand-brains-theory.md]]** — this update rule replicated once per cortical column, with `a_t` supplied by the column's own layer-5 efference copy rather than externally; in higher areas the action is a shift of attention, which extends the composition precondition (G41) from physical movements to inferential operators.
- **[[wiki/concepts/temporal-coding.md]]** — the same periodicity trade in the time domain: a code of period `T` is precise within a cycle and ambiguous across cycles, so a 5 kHz and a 2 kHz channel are jointly unique the way two grid modules are, and neither page has a mechanism that *builds* the several coexisting periods the disambiguation needs.
- **[[wiki/concepts/attractor-dynamics.md]]** — the continuous-manifold regime is what makes displacement accumulation path-consistent by construction; without a continuum the update has nowhere to move.
