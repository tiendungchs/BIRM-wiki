# Connectome State Transformation — The Map Between Graphs Is the Learnable Object

**A cognitive state does not merely index a different connectivity graph; the *transformation* carrying the task-free graph into the task graph is itself a single low-rank linear operator, estimated from a population, that generalises to individuals it was never fitted on. So even where there is no atlas of state-specific graphs, there can be an atlas of the *changes* — and the operator is small: ten regression components carry the task-induced reorganisation of 35,778 edges.**

> **Provenance.** Yoo, Rosenberg, Kwon, Scheinost, Constable & Chun 2022, *A cognitive state transformation model for task-general and task-specific subsystems of the brain connectome*, NeuroImage 257:119279, doi:10.1016/j.neuroimage.2022.119279 (`raw/yoo-2022-cognitive-state-transformation.md`). Connectome-to-connectome (C2C) state transformation, fitted on 316 unrelated Human Connectome Project (HCP) subjects across seven task states.

This is the empirical counterpart of the `A + Σ_k B^k u_k` factorisation that [[wiki/concepts/effective-connectivity.md]] states as a model form. There, the modulation `B^k` is a parameter *fitted per state, per session, inside one subject*, and the review's headline consequence is that no mechanistic-connectome atlas can exist. Here the modulation is estimated **across** subjects and then applied to held-out ones, which is the claim that page does not make: the graph is individual, but the way a task deforms it is shared.

---

## The model, in six lines

Three steps, all linear, deliberately kept transparent (Principal Component Analysis (PCA) + Partial Least Squares (PLS) regression):

| Step | Training | Test-time application |
|---|---|---|
| 1. Define rest subsystems | `S_R = R·W_R` — PCA on training subjects' rest connectomes, **100** components | `S_R^new = R^new·W_R` (frozen `W_R`) |
| 2. Transform state | `S_T ≈ β·S_R` — PLS regression, **10** components | `Ŝ_T = β·S_R^new` |
| 3. Reconstruct the graph | `S_T = T·W_T` — a *separate* PCA on the same subjects' task connectomes | `T̂ = Ŝ_T·W_T⁻¹` → full 268×268 matrix |

- Nodes: Shen 268-parcel functional atlas; edges: Pearson correlation of parcel mean time series ⇒ **35,778 unique edges** per state.
- One model per task state; seven tasks (Emotion, Gambling, Language, Social, Relational, Motor, Working Memory).
- 10-fold cross-validation, repeated 1000× with reshuffled fold assignment. Component counts 50–200 give similar results.
- **The input at test time is one resting scan and nothing else.** No task data from the target individual is ever used.

---

## What it buys

| Measure | Result |
|---|---|
| Spatial correlation, generated vs. empirical task connectome | `r = 0.643` (Emotion) … `0.723` (Working Memory); **higher than rest-vs-task in all seven states**, with the difference distribution entirely above zero across 1000 iterations |
| Edge-level mean squared error | Lower than the rest-vs-task error in all seven states |
| Seven-way **state fingerprinting** (does the generated connectome match its *own* task best?) | **74%** mean success vs. 14.3% chance; every state above chance |
| Fluid-intelligence prediction (connectome-based predictive modelling) | Working Memory state: `r = 0.180` from the generated connectome vs. `r = 0.076` from the observed rest connectome (`p < 0.01`); holds for all seven states |
| Sample efficiency | ~**100** subjects with C2C matches **300** subjects of raw rest data; crossover at 93 on average (range 79–102 across tasks) |
| Minimum viable training set | 45 subjects already beat the rest connectome on connectome similarity |
| Individuality | Within-individual similarity (generated vs. own empirical task connectome) > cross-individual, for every task |
| Zero-task-data subjects (`n = 27`) | Behavioural-prediction advantage replicates on people whose task scans do not exist |

**Two controls that make the result mean something.** (i) PCA denoising alone *decreases* rest-to-task similarity for every state — so the gain is the PLS transform, not the low-rank projection. (ii) The gain cannot be a group-average offset added to every subject: connectome-based predictive modelling is a linear regression, and adding a constant matrix to every input leaves its predictions unchanged. Whatever the operator does, it does per-subject.

---

## The decomposition: a bifactor structure written on the edges

Task subsystems were matched to rest subsystems by maximal spatial similarity, then the PLS coefficient vectors of the *i*-th component were correlated **across the seven task states**. High cross-state similarity of coefficients = the component reorganises the same way regardless of task.

| Tier | Components | Content |
|---|---|---|
| **State-general** | 1 | The group-mean connectome — within-network connectivity of all eight canonical networks. Loads almost entirely on rest component 1, negligibly on the rest. Preserved unchanged by every task |
| **Domain-general** | 2, 3, 6, 7, 8 | Change from rest *consistently across all tasks*, but **not** by a one-to-one map: each is a mixture of several rest components with near-identical mixture weights in every task. Component 6 = default-mode within-network connectivity plus its connectivity to others, with moderate medial-frontal/frontoparietal loading; 2 = medial-frontal↔motor plus frontoparietal and subcortical/cerebellar; 7 = subcortical/cerebellar; 8 = frontoparietal |
| **Task-specific** | 4, 5, 9, 11, … | Cross-state coefficient similarity `r ≲ 0.2`; no distinctive weight on any single rest component, i.e. produced by a *different* combination of rest components in each task. Component 9 = frontoparietal + default-mode, with the two networks' connectivity in **opposite** sign; 11 = medial frontal |

**The load-bearing observation is about what individuates a subsystem.** Components 6 and 9 involve the *same* networks — frontoparietal and default-mode — and land in opposite tiers. What separates them is the sign pattern of the interaction and which third network is included, not the participant list. A subsystem is a pattern of interaction, not a set of nodes.

This is the same three-tier shape that [[wiki/concepts/control-unity-and-diversity.md]] recovers from behavioural psychometrics — one common factor plus a small number of operation-specific ones — arrived at from whole-brain connectivity with no behavioural measurements in the fit. Two independent measurement modalities, the same count of separately parameterised pieces.

---

## For a builder

- **Store one graph per individual plus one operator per context, not one graph per context.** The operator's measured rank is small: 10 PLS components suffice for 35,778 edges of change, and 45 people suffice to estimate it. This is the concrete costing of the `A` + `B^k u_k` storage argument.
- **The split is empirical and it runs the way a slow-`W`/fast-`M` design wants it to.** The *graph* is individual and must be measured per person; the *deformation* is population-level and transfers to unseen people. [[wiki/concepts/latent-graph-discovery.md]]'s two-level factorisation is usually asserted; here each level has a sample cost attached.
- **Context enters as an operator on the connectivity, not as an input to the units.** [[wiki/entities/context-modular-memory-network.md]] does this with a binary mask on a fixed weight matrix — full-rank, discrete, authored. The C2C operator is the learned, continuous, low-rank version of the same move, and it says the rank needed is roughly 10 for a 268-node graph.
- **(brainstorm) A deterministic linear map adds no information and still doubles a downstream linear reader's accuracy.** By the data-processing inequality `T̂ = f(R)` cannot contain more about the subject than `R` does. The gain therefore measures a *basis mismatch*: the behaviourally relevant variance was in `R` all along, in directions the reader's edge-selection step could not see. That is a general and cheap trick — learn a transform into the basis a fixed downstream reader is good at, rather than improving the reader — and it is the wiki's clearest case that a representation's usefulness is defined relative to a specific consumer ([[wiki/empirical-tensions.md]] T247).
- **The correspondence step is unprincipled and load-bearing.** Task components are matched to rest components greedily by spatial similarity under an assumed one-to-one map with a constant component count; the authors state plainly that a task subsystem may be a merge or split of several rest subsystems and that they ignored this for simplicity. Any architecture that transports structure between contexts needs this matching, and nothing supplies a principled version ([[wiki/concepts/subgraph-matching.md]]).
- **The context label must be known to apply the model, but can be recovered to read it.** Generation requires knowing which of seven operators to use; the state-fingerprinting direction infers the state from a connectome at 74%. The pair is a controller and its own state estimator, and only the estimator half is inference ([[wiki/concepts/contextual-inference.md]]).

---

## Open problems

- **Both structural assumptions are known to be wrong.** A constant number of subsystems per state and a one-to-one cross-state correspondence contradict the hierarchical, modular organisation of the brain network and the observed dynamic merging and splitting of subnetworks; incorporating integration/segregation is named as the next step.
- **The transform is between two window-averaged static graphs.** Nothing in it is a dynamics: it says where the connectome ends up, not the trajectory or the timescale of getting there ([[wiki/concepts/dynamic-repertoire.md]]).
- **The edges are descriptive.** Pearson correlation ⇒ symmetric, unsigned-by-construction, no within-node recurrence; the operator inherits every limitation of the functional connectome it maps between ([[wiki/concepts/effective-connectivity.md]]).
- **Task coactivation is not fully separable from task-evoked connectivity.** The behavioural-prediction gain argues the model captures genuine task-evoked modulation (coactivation alone does not predict intelligence, Greene et al. 2020), but the generated connectomes contain coactivation effects too.
- **Nothing here is a mechanism.** A fitted linear map is not a process by which a brain reconfigures; the authors close by warning that the framework's parameters should not be treated as machine-learning hyperparameters to optimise, since the object is a model of a brain.
- **No parcellation-independence check.** The whole operator is defined on one 268-node atlas ([[wiki/concepts/node-definition-problem.md]]).

---

## Connections

- **[[wiki/concepts/effective-connectivity.md]]** — this page is the empirical form of that page's `A + Σ_k B^k u_k` factorisation, and it answers the "there is no atlas" claim in the one way that page does not consider: the state-*change* operator is atlas-able and transfers across people, even though the state-specific graphs are individual and must be measured.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies a measured cost for the framing's two-level split: the instance-level graph needs one scan per individual and does not transfer, while the meta-level deformation is rank-10, needs ~45–100 individuals, and applies to people it was never fitted on.
- **[[wiki/concepts/control-unity-and-diversity.md]]** — the same one-common-plus-a-few-specific decomposition reached from the opposite direction: a bifactor structure derived from behavioural task batteries there, and from cross-state similarity of connectome-transformation coefficients here, with no behaviour in the fit.
- **[[wiki/entities/context-modular-memory-network.md]]** — the architecture that already implements context-as-modulation-of-connectivity with a binary mask; this page is the learned, continuous, low-rank measurement of what that mask should be, including how much rank it needs.
- **[[wiki/concepts/node-definition-problem.md]]** — supplies the 268 vertices the whole operator is defined over, and marks the untested dependency: nothing shows that a rank-10 transformation between connectomes survives a change of parcellation.
- **[[wiki/concepts/dynamic-repertoire.md]]** — the missing dimension: if the connectome of a state is a frequently-visited region of a repertoire rather than a fixed object, then this operator maps one time-averaged summary onto another and says nothing about the trajectory between them.
- **[[wiki/concepts/subgraph-matching.md]]** — the unowned step inside the method: transporting structure between two independently derived component bases requires a correspondence, and the greedy maximal-similarity one used here is explicitly an expedient rather than a solution.
- **[[wiki/concepts/contextual-inference.md]]** — the complementary half: the C2C generator must be told which state it is transforming into, while the state-fingerprinting analysis recovers the state from the connectome at 74% of seven-way choices, so the pair separates "select the operator" from "infer which operator applies".
- **[[wiki/concepts/cognitive-control.md]]** — a connectivity-level statement of the same claim: task set is a reconfiguration applied on top of an intrinsic architecture that survives it, with component 1 (the group-mean within-network structure) untouched by every task and the reconfiguration confined to cross-network components.
- **[[wiki/architectural-gaps.md]]** — G83: this is the wiki's first mechanism whose output is a *map between structures* rather than a structure, and the first evidence that such a map is low-rank and transfers to unseen instances.
- **[[wiki/concepts/connectome-hubs-and-cores.md]]** — the fixed scaffold underneath the graphs this page transforms: the structural core does not change with task state, so the state-general subsystem the bifactor split isolates is a candidate functional signature of that anatomy rather than of the task.
- **[[wiki/concepts/function-to-structure-inference.md]]** — the resting-state baseline this page's task states are measured against, and the reason a *map* between connectomes may be more stable than either endpoint: a single functional connectome is window-dependent, distance-contaminated and path-closed even when the underlying anatomy is fixed.
- **[[wiki/concepts/integration-segregation-balance.md]]** — the rest→task change reduced to one number instead of a rank-10 operator: position along a between-module-connectivity axis, graded monotonically from the motor task to the N-back — this is the integration/segregation account this page names as its own missing next step.
