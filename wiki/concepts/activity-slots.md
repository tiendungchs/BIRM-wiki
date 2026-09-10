# Activity Slots

**A sequence memory held in neural activity decomposes into non-overlapping subspaces — *slots* — each holding one arbitrary observation, with the *contents* copied and shifted between slots by an action/velocity signal while the read-out weights stay fixed. This is the exact algebraic dual of a memory held in synapses, where the memory slots stay fixed and an abstract position code moves the *attention* over them.**

> Primary source: Whittington, Dorrell, Behrens, Ganguli & Duan 2025, *A tale of two algorithms: structured slots explain prefrontal sequence memory and are unified with hippocampal cognitive maps*, Neuron 113(2):321–333 (`raw/whittington-2025-tale-of-two-algorithms-structured-slots.md`). Code: `github.com/djcrw/em-wm-slots`. Abbreviations here: **EM** episodic memory, **WM** working memory, **PFC** prefrontal cortex, **ISR** immediate serial recall.

The wiki's fast **M** has always been "a store plus a controller" ([[wiki/concepts/working-memory.md]]). This page says the store/controller split is not the primitive one: what actually varies is **which side of the read moves**.

---

## The duality

The task family: `N` problem instances share one latent transition structure (a loop, a line, 2D space); each instance re-randomises the pairing of latent state `p` to observation `x`. The agent sees `(x_t, v_t)` and must predict the observation at some target offset. Structure must be meta-learned across instances; the instance binding must be acquired within one.

| | **EM solution** (hippocampal reading) | **WM solution** (prefrontal reading) |
|---|---|---|
| Where the memory is | Synaptic weights `M = Σ_p x_p g_pᵀ` — a modern Hopfield network / differentiable neural dictionary | RNN activity `h`, partitioned into slots |
| What the RNN represents | **Abstract position** `g_t = G_{v_t} ··· G_{v_1} g_0` — independent of observations | **All counterfactual (action, observation) pairs at once** |
| Recurrent operator | `G_v`, one per action; `G_north G_south = I` | `H_v` — the *transposed, expanded* `G_v`; larger by a factor of the number of latent states |
| Read | `x̂ = M g_t` — a learned, moving attention vector indexes fixed slots | `x̂ = w_outᵀ h_t` — fixed weights attend to **one** slot; the contents move to meet them |
| Write | Hebbian outer product into a fresh synaptic slot | Feed-forward weights deposit the observation into the input slot |
| Plasticity needed on a novel problem | **Yes** (fast weights in the memory module) | **None** — recurrent activity alone |
| Optimal basis | Grid-cell-like under simple constraints | Slot-local; one neuron per (observation × relative position) in the idealised basis |

`G_v` and `H_v` compute the same function. **The behavioural equivalence is exact**: once trained, the two networks generalise identically over novel state–observation pairings, because one is a rearrangement of the other.

**What a slot *means*.** Slot `k` is labelled by an action sequence, equivalently by a *relative position*, and its contents answer the counterfactual **"what would I see if I took that action sequence"**. Slot 1 (aligned to the read-out) holds the answer for the null action. Every real action changes every slot's correct answer, which is why the recurrence must copy-and-shift all of them each step. So a WM RNN is not a buffer of the past — it is a **simultaneously materialised set of one-step-to-`k`-step counterfactuals**, which is what makes it a cognitive map rather than a tape.

---

## The three trade-offs the duality exposes

| Axis | EM | WM | Measurement |
|---|---|---|---|
| **Neuron cost** | `O(\|states\|)` | `O(\|states\|²)` — one slot per relative position | At matched RNN neuron budget, WM accuracy degrades faster as task size grows, on all four tasks and both RNN variants |
| **Sample complexity** | Faster (except N-back) — the fast-binding inductive bias matches the task | Slower — no bias, must learn how to store | Learning curves; `GroupRNN` (velocity-dependent matrices) beats `RegularRNN` (velocity as additive input) on both, via a path-integration prior |
| **Parallelism** | Must sample states sequentially to plan | Whole problem present in activity at once — operations over states run in parallel | Argued, not measured |

**The unexpected asymmetry**: at *small* task sizes, EM networks also converge on the WM solution (position becomes undecodable, slot sequences become decodable). The authors' reading — slots are a *direct function of the input data* while position is abstract, so the slot solution is the easier local minimum whenever neurons are not scarce. Abstract structural codes are what you get when you run out of units, not what you get by default ([[wiki/concepts/abstract-structural-codes.md]]).

---

## The decoding test, and why it is not circular

Linear decoders are trained across *many* tasks, so what is recovered must generalise rather than overfit one problem.

| Predicted | Result |
|---|---|
| Abstract position decodable from EM RNNs, not WM RNNs | Confirmed, all four tasks (ISR, N-back, 1D navigation, 2D navigation), both RNN variants |
| **Slot sequences** decodable from WM RNNs | Confirmed |
| **Past sequences** (temporally shifted copies of the input) *not* decodable from WM RNNs | Confirmed — and this is the discriminating control, since for varying velocity the slot sequence is **not** a lagged copy of the input. Only on ISR and N-back do the two coincide |

Both signals vanish at large task sizes, where the network simply fails to learn — so the decoding curve is a learning curve, and absence of a code is not evidence of the other code.

---

## Slot algebra: the bound code supports linear operations

The property that separates this from every other slot store in the wiki. Slot representations are **compositional across problem instances of one task**: substituting the observation in slot 2 is a fixed vector offset, independent of what the other slots hold.

`h[a, b, c] − h[a, d, c] = h[a′, b, c′] − h[a′, d, c′]`

*(form reconstructed — the clipper stripped the display equations; the source states the relation holds for problems differing only in slot 2, with the other slots' contents arbitrary)*

Scored as `ε_algebra / ε_baseline`, the squared error of the predicted sum against the squared difference of two measured representations. Low = obeys the algebra.

| Architecture | How velocity enters | Slot algebra |
|---|---|---|
| **GroupRNN** | Modulates the *synapses* (velocity-dependent matrices) | Low on every task; improves further with a KL consistency regulariser across timesteps |
| **RegularRNN** | Additive input to the units | Low **only on ISR**, the one task needing no velocity signal |
| **BioRNN** | Integrated in a *separate population* from the memory activity | Low on every task — and its architecture is the fly head-direction circuit ([[wiki/entities/fly-central-complex.md]]) |

**This is a structural design rule, not a benchmark score.** The algebra survives exactly when velocity does not modulate the memory units themselves. Two ways to buy that: put velocity in the weights, or put velocity in a different population. Mixing velocity into the stored activity destroys compositionality while leaving task performance intact — so a system can pass the task and fail the algebra, and only the algebra is checkable without a task.

---

## Velocity is computed, not given — progress cells and hierarchical slots

The models above are handed `v_t`. Brains are not. For spatial tasks the answer is head-direction and speed cells; for non-spatial tasks it was unknown.

Modelling Basu et al. (2-goal) and El-Gaby et al. (4-goal) rodent sequence tasks as 2-ISR / 4-ISR **with delays** — random across problem instances, but *constant across loops within* an instance, and with no velocity input supplied:

- **Progress and progress velocity are both decodable** from the trained WM RNN, with single-neuron progress tuning.
- Slots become **task-progress structured**: slot identity is "25% / 150% of the way since the observation", continuous rather than discrete (bumps on an attractor manifold), with progress velocity gating the shift. This is what maps variable-length delays onto one generalisable slot structure.
- **Task-progress slot neurons** — fire at a particular progress after a *preferred* observation — are recorded in rodent mPFC; the pathway linking one observation across slots is El-Gaby et al.'s "structured memory buffer".

**Hierarchical slots.** In 4-ISR-with-delays, each of the four delays must be measured on the first loop and recalled on later ones. The network builds a second, higher tier of slots holding the four *delays* (i.e. inverse velocities), which then control the shift rate of the lower task-progress slots. Decodable. **This is the wiki's cleanest mechanistic proposal for cognitive control**: control is not a separate module but a slot tier whose contents are the *velocities* of the tier below ([[wiki/concepts/cognitive-control.md]], [[wiki/concepts/policy-abstraction-hierarchy.md]]).

---

## Four PFC datasets under one mechanism

| Study | Finding | Slot reading |
|---|---|---|
| Xie et al. (3-ISR saccade sequence, monkey PFC) | Delay activity decomposes into **three orthogonal subspaces**, first/second/third saccade target in first/second/third subspace | Three slots under constant velocity; WM networks learn the same decomposition |
| Panichello & Buschman (cued colour retrieval, monkey PFC) | Two orthogonal subspaces for top/bottom colour; after the cue, correct-top and correct-bottom codes lie in **parallel** subspaces | **A sensory cue acting as a velocity signal**: the cue routes the selected colour into the read-out slot, which is why the post-cue subspaces are parallel |
| El-Gaby et al., Basu et al. (rodent mPFC goal sequences) | Goal-progress cells invariant to goal distance; structured memory buffers | Task-progress slots plus a computed progress velocity |
| Human mPFC scene construction (fMRI) | Activity obeys **scene algebra** | The same linear compositionality as slot algebra, on a non-sequential compositional task |

The Panichello row is the load-bearing generalisation: **velocity is not restricted to self-motion**. Anything that determines which memory should meet the fixed read-out next — an external action, an internally computed progress rate, or a sensory cue — is a velocity signal. That collapses "routing", "gating" and "path integration" into one operator, differing only in where the signal comes from.

---

## What this changes for the wiki

- **The EM/WM distinction is not hippocampus vs. prefrontal cortex — it is synapses vs. activity.** The authors state this directly. Prefrontal cortex projects to hippocampus via entorhinal cortex and can therefore *also* carry position codes (grid-like coding is reported in mPFC), and any region storing memories in activity should use slots. So "which region" and "which algorithm" are separate questions, and the wiki's regional assignments are weaker claims than they read as ([[wiki/empirical-tensions.md]] T28, T92).
- **A behavioural benchmark cannot identify the store.** Two architectures with an exact algebraic duality produce identical generalisation on the whole task family. The only separating measurements are neuron-budget scaling curves, sample complexity, and representational decoding — none of which any benchmark in the wiki reports (`G112`).
- **The formalism is a selective state-space model**, and the GroupRNN is one. So this is simultaneously a claim about the mechanism learned by state-space models and transformers.
- **Continuous slots may give length generalisation.** The authors' analogy: as the grid-cell hierarchy codes environments larger than its largest scale, a *hierarchical continuous* slot manifold could code sequences longer than trained. Proposed, unbuilt.

---

## Open problems

- **Not universal.** Naive activity slots are *not* learned on some sequential WM tasks (the source's own supplementary cases). The claim is that slots are a general-purpose solution, not that they are always the solution found.
- **Slot identity is positional.** A slot is labelled by a relative position / action sequence, not by a role type. So the role vocabulary is the action group, and there is no route here to an arbitrary named role (`G104`).
- **The capacity evidence runs the wrong way for biology.** The small WM networks exceed human WM capacity, because they are noiseless and trained on one task type. The reconciliation with continuous-resource models (chunk, or crowd bumps closer on the slot manifold) is argued, not simulated.
- **Short-term synaptic plasticity is the untested rival.** The authors concede recent modelling suggests PFC responses may be better explained by synaptic storage ([[wiki/entities/stsp-working-memory-rnn.md]]) — which, under this page's own duality, is a claim that PFC runs the *EM* algorithm. The duality makes the rival harder to exclude, not easier.
- **No 2D PFC data.** Every PFC dataset explained here has loop or line structure. The prediction that PFC carries **2D slots** when trained on 2D sequences is stated and unrun.

---

## Connections

- **[[wiki/concepts/working-memory.md]]** — supplies the mechanism that page's prefrontal subspace results were missing: the concurrent orthogonal delay subspaces are slots, the store's capacity cost is `O(\|states\|²)` neurons rather than a slot count, and "no synaptic plasticity is needed" becomes a derived property rather than an assumption.
- **[[wiki/concepts/cognitive-map.md]]** — makes a WM buffer a map: each slot holds a counterfactual "what would I see after this action sequence", so the whole map is materialised in activity at once rather than visited one state at a time.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the two solutions are the two ways to hold an instance-graph: EM binds observations to a meta-graph position code and stores the binding in weights; WM holds the whole instance-graph's one-step-to-`k`-step consequences in activity, with the meta-graph in the recurrent operators `H_v`.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the EM half of this duality is that model's architecture, and this page derives its dual: the same computation with the position code removed and the memory moved from synapses into activity, which is why TEM's "cortex holds structure, hippocampus holds the binding" is a claim about a *carrier*, not about a computation ([[wiki/empirical-tensions.md]] T28).
- **[[wiki/entities/vector-hash.md]]** — the same EM factorisation pushed to a content-free scaffold; this page says the scaffold-plus-heteroassociation design has an activity-only dual with identical behaviour and a quadratic neuron cost, which is the price of removing the fast weights.
- **[[wiki/entities/spacetime-attractor.md]]** — the nearest relative and the sharpest contrast: both hold one population per *offset* and read the whole structure at once, but there slots are indexed by future delay and wired by the environment's adjacency matrix for planning, here they are indexed by relative position to a stored observation and wired by the action group for recall — so "sequence memory" and "planning" are the same slot architecture pointed at the past and the future.
- **[[wiki/concepts/tensor-product-representation.md]]** — the theoretical frame: a slot is a filler bound to a **one-hot role code**, and slot algebra is the linearity that a tensor-product binding guarantees — measured here, on a trained network, with the conditions under which it *fails* named (velocity mixed into the memory units) ([[wiki/empirical-tensions.md]] T317).
- **[[wiki/concepts/vector-symbolic-binding.md]]** — the contrast case for role-filler preservation: here both constituents stay separately addressable while bound (the slot is the role, its contents the filler), and the bound code still supports a linear algebra — which is the combination a compressed conjunctive code cannot offer (`G104`, [[wiki/empirical-tensions.md]] T293).
- **[[wiki/entities/esbn.md]]** — the same trick with the algebra removed: there the binding is a shared row index in an external store and there is no vector to operate on, here the binding is a subspace of one activity vector and substitution is a fixed offset — so this is the ESBN's role-filler independence with a usable bound object attached, at the cost of a quadratic neuron budget.
- **[[wiki/entities/pbwm.md]]** — the same one-hot role code with the write policy learned instead of the transport: stripes are gated open by reinforcement-trained basal-ganglia disinhibition, slots are shifted by a velocity operator, and neither has an arbitrary role vocabulary ([[wiki/empirical-tensions.md]] T317).
- **[[wiki/concepts/fast-weight-programming.md]]** — the EM half in machine form (state *is* a weight matrix, written by outer product, read by query); this page's duality says the same sequence model has an activity-only implementation and prices it, so "where the state lives" is a neuron-count decision rather than a capability one.
- **[[wiki/concepts/path-integration.md]]** — generalised past space: the velocity that shifts slot contents can be an action, an internally computed *task-progress* rate, or a sensory cue, and all three are the same operator applied to a different signal source.
- **[[wiki/entities/fly-central-complex.md]]** — the circuit motif that passes the compositionality test: integrating velocity in a *separate* population from the stored activity is what keeps slot algebra intact, and the BioRNN that does so is the fly head-direction circuit.
- **[[wiki/concepts/cognitive-control.md]]** — a mechanistic proposal for the controller: a higher slot tier whose contents are the *velocities* of the tier below, so control is the same storage primitive applied one level up rather than a separate module.
- **[[wiki/concepts/abstract-structural-codes.md]]** — an inversion worth carrying: at small task sizes even the EM network abandons the abstract position code for slots, because a slot code is a direct function of the input while position is not — so abstraction is what a neuron budget forces, not what training prefers.
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — the region the PFC evidence comes from, and the region the duality declines to privilege: any structure storing in activity should show slots, and mPFC can also carry grid-like position codes, so a slot finding does not localise the algorithm.
- **[[wiki/concepts/attractor-dynamics.md]]** — where the continuous version lives: task-progress slots are bumps on a continuous manifold rather than discrete registers, which is how variable-length delays across problems map onto one generalisable slot structure.
- **[[wiki/entities/stsp-working-memory-rnn.md]]** — the direct rival, re-typed by this page: short-term synaptic storage in prefrontal cortex is not an alternative *mechanism* for WM but a claim that prefrontal cortex runs the **EM** side of this duality, which the behavioural equivalence makes hard to adjudicate.
- **[[wiki/concepts/compositionality.md]]** — a measured compositionality criterion for a trained network that needs no task: substitution in one slot must be a fixed vector offset regardless of the other slots' contents, and the architectures that fail it still solve the task.
