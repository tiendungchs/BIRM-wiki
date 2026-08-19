# Tolman-Eichenbaum Machine (TEM) and the Spatial Memory Pipeline (SMP)

**Two implementations of one idea: a reusable path-integrating structural code, plus a fast relational memory that ties that code to whatever this environment happens to contain — trained only to predict the next sensory observation, across many environments.**

This is the wiki's `p = f(g, x)` factorization built rather than posited. Three sources, in order of arrival: Whittington et al. **2018** (NeurIPS proto-TEM — hierarchical frequency bands, the entorhinal cell zoo as transition-statistic basis functions, first neural evidence that remapping is *not* random); Whittington et al. **2020** (*Cell* 183:1249–1263 — the primary TEM paper: full generative/inference model, non-spatial task results, remapping replication, prediction list); Whittington et al. **2022** (review, and the SMP comparison, Uria et al. 2020). Each has its own section below.

---

## Architecture

| Component | TEM | SMP | Wiki role |
|---|---|---|---|
| **Structural code `g`** | Path-integrating module, medial entorhinal analogue: `z_t = f(W z_{t-1} + B a_t)`. Shared across all environments | Same | Meta-graph; [[wiki/concepts/path-integration.md]] |
| **Sensory code `x`** | Lateral entorhinal analogue | Learned from pixels | Node content |
| **Binding `p`** | Hippocampal conjunctive cells, written by Hebbian learning into a Hopfield network | A machine-learning memory network | Instance-graph; fast **M** |
| **Prediction** | Path integrate `g`, then retrieve from memory at that location: *"what did I see the last time I was here"* | Same | Integrate-then-retrieve |
| **Input** | Allocentric actions and object identities are **supplied** | Egocentric pixels; actions and allocentric frame must be **inferred** | SMP pays more of the discovery cost |
| **Training signal** | Next observation, over a distribution of structurally similar worlds | Same | Meta-learning across an environment family |

`p(X) = Σ_Z Π_t p(x_t | z_t, M) p(z_t | z_{t-1}, a_t)` — the same factorisation as [[wiki/entities/cscg.md]], except that the emission is a *memory read* instead of a frozen clone table, and the transition is *shared across environments* instead of learned per environment.

**Why the memory has to be conjunctive.** Because TEM implements the link with Hebbian learning in neurons rather than an external memory matrix, the *same* units must know both the abstract location and the sensory prediction. That is a hard architectural consequence of a biological constraint — and conjunctive coding is what hippocampal neurons actually show.

**Remapping is the generalisation mechanism, not a nuisance.** The same `g` and the same `x` vocabulary are reused everywhere; what changes between worlds is which `g`–`x` pairs are bound. Hippocampal remapping is therefore *required* by transfer, which inverts the usual reading of it as instability.

---

## The 2018 precursor and what only it supplies

Whittington, Muller, Mark, Barry & Behrens 2018 (NeurIPS) is the proto-TEM: the same `p = f(g, x)` factorisation, trained by variational inference (ELBO, VAE framework) on agents walking 2D graphs whose vertices carry a **one-hot, non-unique** sensory stimulus, with only observations and actions as input. Three of its commitments are load-bearing and are not stated elsewhere in the wiki.

| Commitment | Mechanism | Why it matters |
|---|---|---|
| **Hierarchy of frequencies** | `g` and `p` are split into frequency bands `f`; `D_a` connects low→same-or-higher frequency only; `x_t` is exponentially smoothed into matching bands (an approximate Laplace transform, matching LEC cells) | High-frequency statistics are *reused across space*, so weight count does not scale with arena size — the structural code is compressed, not tabulated |
| **Grid code as memory address** | Hebbian write `M_t = λM_{t-1} + η(p_t − p̂_t)(p_t + p̂_t)ᵀ`, high→low frequency connections zeroed; read by attractor iteration `h_τ = f_p(αh_{τ−1} + M_t h_{τ−1})`, seeded by `f_g(g_t)` for generation and by the sensorium for inference | Retrieval is hierarchical (coarse band settles first), and `g` doubles as an index rather than only a state — one code paying for path integration *and* content-addressing |
| **Sensory→location inference is optional but helps** | `q_φ(g_t | g_{t−1}, a_t) · q_φ(g_t | x_≤t, M_{t−1})` — a retrieved memory refines the location estimate | Closes the loop the wiki usually draws one-way: memory corrects `g`, not just `g` addresses memory |

**The entorhinal cell zoo as basis functions over transition statistics.** Grid, band, border and object-vector cells are one family — bases for constructing transition statistics — and *which* basis emerges is set by the transition distribution, not the architecture: bias the agent to dwell near boundaries → border cells; bias it toward particular stimuli → object-vector cells; unbiased 2D walk → grids and bands (square here, because actions are four-way embedded on four-connected space). The proposed use is on-line reweighting of a fixed basis set once task structure is guessed. **(brainstorm)** This is the cheapest available answer to "how does `g` arise for a *new* domain" ([[wiki/concepts/abstract-structural-codes.md]]): not learn a new code, but reweight learned bases from the observed transition statistics — an inference over basis weights rather than a gradient problem.

**The structure/content dissociation is testable at the cell level.** Object-vector cells in the `g` layer generalise over object identity within *and* across environments; the corresponding landmark cells in the `p` layer do not — they are object-specific. Same architecture, same training, opposite invariance, exactly as recorded. This is the wiki's sharpest single measurement that the `g`/`x` split is real rather than a modelling convenience.

**Place fields explained as a consistency region.** A place cell fires wherever the environment is consistent with *both* the grid input it receives and the sensory code it carries. This derives field *size* (how large the consistent region is) and *multiplicity* (several disjoint consistent regions) from one rule, and yields a manipulation-based experimental programme — perturb grid input or environmental cues while recording both populations.

**Results specific to this paper**

| Result | Number |
|---|---|
| One-shot learning | Prediction accuracy is high on the *first* revisit to a node, i.e. the attractor retrieves after a single Hebbian write |
| Zero-shot link inference | Unseen edges predicted well above chance (`1/n_s = 0.02`) on loop closure, flat across the fraction of graph visited — structure, not coverage, is doing the work |
| Memory beyond the gradient horizon | BPTT truncated at 25 steps, memories retrieved 400+ steps later — the Hebbian store's retention is not bounded by the credit-assignment window |
| Grid code invariant to arena size | The same grid cells, same phases, in environments of different sizes — a representation of 2D-ness, not a per-environment template |

**The remapping analysis (the paper's empirical contribution).** Re-analysing Barry lab recordings of grid *and* place cells in two same-size, different-cue environments (7 rats, 115 place-cell/grid-cell pairs, ideal-grid fits, grid score > 0.8, scale < 50 cm, place peaks > 10 cm from borders):

| Measure | Within environment (trials 1 vs 5) | Across environments (trials 1 vs 4) |
|---|---|---|
| **gridAtPlace** — grid rate at the place-field peak, correlated across trials | r = 0.386, p ≈ 0 | **r = 0.320, p = 0.002** |
| **minDist** — place-peak-to-nearest-grid-peak distance, normalised by grid scale | r = 0.377, p ≈ 0 | **r = 0.170, p = 0.028** |

The model's own rate maps give across-environment gridAtPlace correlations of 0.3–0.35, matching. The grid–grid correlation matrix is preserved across environments in both data and model (p < 0.001). **Conclusion: place cells remap, but not randomly — they remap to positions consistent with a preserved grid code.** This is the first neural-activity evidence for non-random remapping ([[wiki/empirical-tensions.md]] T39), and it is the precondition for the whole transfer story: if remapping scrambled the `g`↔`p` relationship, there would be nothing for a new environment to inherit.

**Its bearing on T38.** Grid-like, band, border and object-vector units emerge here with **no spatial supervision at all** — no `(x,y)` target, no ground-truth place cells, no centre–surround readout kernel; the only target is a one-hot categorical over sensory identities. The Schaeffer et al. 2022 mechanism (readout correlation matrix = attractor interaction kernel) has no purchase on a one-hot target, so this is the wiki's cleanest surviving emergence result for a periodic `g` ([[wiki/concepts/objective-identifiability.md]]). What it does *not* supply is an audit: fraction-of-runs, seed sensitivity, module structure and grid-score-vs-filtered-noise controls are all unreported, and the paper explicitly declines to claim strong performance ("didactic approach").

---

## The 2020 primary source

Whittington, Muller, Mark, Chen, Barry, Burgess & Behrens 2020, *Cell*. Same factorisation as 2018, now with the full model written out, the non-spatial tasks run, and the remapping claim replicated in a second lab's data.

### The computational chain

Generative (predict), left column, and inference (observe), right column — one time-step each. `W` are backprop-learned network weights, `M` the Hebbian memory.

| Generative step | Equation | Inference step | Equation |
|---|---|---|---|
| Path-integrate | `g_t ~ N(μ = f_g(g_{t-1} + W_a g_{t-1}), σ = f_σg(g_{t-1}))` | Compress + temporally filter `x` | `x^f_t = (1−α_f)x^f_{t−1} + α_f f_c(x_t)` |
| Entorhinal → hippocampus | `g̃_t = W_repeat f_down(g_t)` | Sensory → hippocampus | `x̃_t = W_tile w_p f_n(x^f_t)` |
| Retrieve memory | `p_t ~ N(μ = attractor(g̃_t, M_{t−1}), ·)` | Retrieve memory *by content* | `p^x_t = attractor(x̃_t, M_{t−1})` |
| Predict observation | `x_t ~ Cat(softmax(f_d(w_x W_tileᵀ p_t + b_x)))` | Infer location | `g_t ~ q_φ(g_t ∣ p^x_t, g_{t−1}, a_t)` |
| | | Infer conjunction | `p_t ~ N(μ = f_p(g̃_t ⊙ x̃_t), ·)` |
| | | Write memory | `M_t = hebbian(M_{t−1}, p_t)` |

Four things in that table the wiki did not previously have from a primary source:

| Detail | Why it matters |
|---|---|
| **`p_t` is an elementwise product `g̃_t ⊙ x̃_t`** | Conjunction is literally multiplicative gating, not a learned MLP over the concatenation — a hippocampal cell fires only if *both* its structural and its sensory input are active. Every remapping result below is a corollary of this single line |
| **Memory is read from *both* ends** | `attractor(g̃, M)` gives "what is here"; `attractor(x̃, M)` gives "where have I seen this" and feeds the location posterior. Path-integration drift is corrected by content-addressed recall, which is the loop the wiki usually draws one-way |
| **Two learning timescales, explicitly separated** | `W` slow, by backprop-through-time, *shared across environments* (this is what generalises); `M` fast, Hebbian, every step, **reset on entering a new environment** (this is what individuates). Transition weights `W_a` are shared between generative and inference nets — atypical for a VAE, adopted "for biological considerations" |
| **Sensory input is Laplace-transformed before binding** | The exponential filter `x^f` approximates a Laplace transform with real coefficients, matching reported LEC cells — so `x` entering the conjunction is a decaying *history*, not the instantaneous observation. This is the same primitive as [[wiki/entities/temporal-context-model.md]], embedded inside the rival architecture |

`W_a` is a **separate weight matrix per action**, so relations compose by matrix product and are therefore **non-commutative by construction**: `uncle = father ∘ brother ≠ brother ∘ father`. Path integration on arbitrary graphs needs exactly this — see [[wiki/concepts/path-integration.md]].

### The derivation of the entorhinal codes

The paper's central theoretical move is that two requirements on `g`, both imposed purely by its use as a *memory address*, are claimed **sufficient** to produce grid and band codes:

1. **Distinctness** — different states must get different `g`, or their memories collide.
2. **Path-invariance** — the same state must get the same `g` however it is reached, or the memory cannot be retrieved.

No spatial supervision, no periodicity prior, no `(x,y)` target; the only loss is a categorical cross-entropy over one-hot sensory identities. Grid modules at multiple frequencies, within-module phase offsets, and band cells all emerge, and their *second-order* structure (which grid cells fire next to which) is preserved across environments of different sizes — a representation of 2D-ness rather than of any one arena.

### Results specific to 2020

| Result | Detail |
|---|---|
| **Data efficiency tracks nodes, not edges** | Performance follows the fraction of *nodes visited*, not edges traversed. On the illustrative graph, 18 steps suffice to infer all 42 links. The contrast is formalised as a "node agent" vs an "edge agent" — structural knowledge converts `O(E)` experience into `O(V)` |
| **First-presentation transitive inference** | After training on line graphs (lengths 4–6, fully connected, edges labelled by ordinal offset), TEM answers "what is 3 more than E" with "B" in a *new* task with new stimuli, zero additional experience |
| **First-presentation social-hierarchy inference** | Family-tree graphs, 10 relation types (sibling, parent, grandparent, child 1/2, aunt-uncle, niece-nephew 1/2, cousin 1/2), 3–4 levels (15 or 31 states). "Bob is Cat's brother, Cat is Fran's mother" → "who is Bob's niece?" → "Fran" |
| **Learning-to-learn curve** | Early in training TEM needs many visits per node; after many environments it predicts a node correctly on the *second* visit regardless of the edge taken. The structure and the memory policy are learned together |
| **Remapping non-randomness replicated** | Second dataset (Chen et al. 2018, 4 mice, real + VR arenas 60×60 cm): gridAtPlace correlates across environments, `r = 0.273`, `p < 0.05` (64 conservative pairs); `r = 0.544`, `p < 0.05` (148 liberal pairs). Dataset 1 (Barry et al. 2012, 7 rats): `r = 0.322`, `p < 0.01` (115 conservative); `r = 0.63`, `p < 0.05` (255 liberal). Model gives `r = 0.31` against data `r = 0.27–0.32` |
| **Four-lap task, three cell types** | Reward every 4 laps of a circular track (Sun et al. 2020). TEM's hippocampal layer reproduces all three recorded populations: pure place cells, lap-specific place cells, and lap-*counting* cells with graded firing. "Reward" is nothing but a sensory symbol that repeats every 4 laps |
| **Non-spatial remapping — a confirmed prediction** | Across two sensorially different versions of the 4-lap task, TEM predicts hippocampal cells *spatially* remap while *retaining lap specificity*, because sensory observations repeat each lap so lap selectivity is driven by MEC alone. Measured by event-specific-rate (ESR) correlation across environments, this holds in TEM and in Sun et al.'s mice: ESR correlations concentrated high and significantly above shuffle, while spatial correlations are near-uniform |
| **Which cells are active where** | The same `g̃ ⊙ x̃` gate explains why a cell active in one environment is silent in another (structural and sensory input fail to align), for non-spatial cells as well as spatial ones — approximate independence of recruitment, in model and data |

**The interpretive payoff of the non-spatial remapping result.** One mechanism produces *both* a scrambled and a preserved dimension in the same cells at the same time. Remapping is therefore not a property of a cell or of a map; it is a property of each *factor* of the conjunction independently. Whatever the structural code holds constant survives the remap; whatever the sensory code re-shuffles does not. **(brainstorm)** This is the sharpest available operational definition of the `g`/`x` split: run the same task twice with different surface features and ask, dimension by dimension, which survives — no model fitting, no cell typing, and it applies to any conjunctive representation, artificial included.

### Predictions still open

| Prediction | Test |
|---|---|
| LEC↔hippocampus relationship also preserved across maps | Simultaneous LEC + hippocampus recording in a remapping experiment |
| **Multiple place fields within one environment are the same phenomenon as remapping** | The grid–place correlation of the remapping analysis should hold *between the several fields of one cell in one arena* |
| MEC contains lap-specific and lap-counting cells | Not recorded — Sun et al. 2020 recorded hippocampus only; entorhinal inactivation disrupting lap cells is the only current support |
| Latent-state cells (splitter, inbound, outbound) generalise across sensory versions of a task in **MEC but not hippocampus** | Factorial design varying stimuli and structure independently |
| **Structural remapping**: MEC cell–cell correlation structure changes when *transition statistics* change, gradually and parametrically | Early fMRI support (Baram et al. 2019); easiest in primates where tasks need not be spatial |
| In VR where a track section looks different on each lap, **all** hippocampal cells in that section become lap-specific (no place or counting cells) | The paper flags this as "particularly stark" and as a test of its simplification that the hippocampus does *only* binding |

### Framing claims

- **Wake-sleep, not just VAE.** Inference net = awake, observing; generative net = asleep, checking whether what was inferred is what it would have predicted. Errors at all three levels `[g, p, x]` per step, accumulated over a sequence, BPTT.
- **Replay's job is structural organisation.** Because TEM's learning scheme is Helmholtz-machine-shaped and hippocampal replay appears to sample from a generative model, the paper's proposal is that replay exists to *organise sequences into structures* rather than to rehearse episodes ([[wiki/concepts/offline-replay.md]]).
- **Remapping and transitive inference are the same coin.** The structural knowledge transferred during remapping *is* what supports transitive generalisation — one mechanism, two literatures that had never been connected.
- **Cortex→hippocampus, not only hippocampus→cortex.** Standard consolidation has the hippocampus teaching cortex; TEM adds the return path — cortical structural representations feed back to *organise* new hippocampal experience ([[wiki/concepts/complementary-learning-systems.md]]).

### Limitations stated by the paper

| Limit | Consequence |
|---|---|
| **Sensory observations are i.i.d. across nodes by design** | Real worlds have sensory correlations between adjacent locations; these were deliberately removed so that transition structure is the *sole* cause of the learned representations. Clean attribution, but the model has never been asked to handle the correlated case, where much cheaper non-structural solutions exist |
| **Not biophysically realistic** | Explicitly a computational-level model; anatomy is used only to constrain which population computes what |
| **Hippocampus does binding and nothing else** | Acknowledged as a simplification; the VR prediction above is its stress test |
| **Actions/relations are supplied and labelled** | Every task hands the model an action vocabulary (`north`, `uncle`, `+3`) — hardness source 2 untouched, and the non-commutative composition result presupposes the labels are already correct |

---

## Results from the 2022 review (TEM and SMP together)

| Result | Detail |
|---|---|
| **Recapitulates the cell zoo** | Place, grid, band, border and object-vector responses emerge from next-observation prediction alone |
| **Non-spatial latent states** | Trained on spatial alternation (`left → right → left …`), TEM learns **both** splitter cells (position in the "big loop") and place cells (position in space) — the two levels of abstraction simultaneously |
| **Lap cells** | On a reward-every-4-laps task, cells for position-in-lap *and* cells for which-lap, matching rodent hippocampus |
| **Evidence accumulation** | On a cue-counting T-maze, a 2-D map spanned by physical position × accumulated evidence, as recorded |
| **Transitive inference** | Solves classical relational-memory tasks that depend on the hippocampal formation |
| **Compositional entorhinal codes** | Learns factorised bases in both spatial and non-spatial tasks |
| **SMP-specific** | Because it starts from egocentric pixels, it also produces the egocentric→allocentric transformation cells, and performs vector-based navigation and shortcutting |

**The load-bearing claim behind the table:** hippocampal cells that look like they code odd task variables are *latent states*, and they exist for exactly two reasons — separate states with different futures, and generalise. Every level of abstraction must be represented at once, because you cannot know in advance which one the next task needs. A model that learns only the de-aliasing level (CSCG) reproduces the splitter cells and misses the place cells.

---

## Limitations

| Limit | Consequence |
|---|---|
| **Slow to learn a novel map** | Transfer is bought by gradient training over many environments; a genuinely new structure cannot be acquired in one traversal ([[wiki/entities/cscg.md]] is the mirror image) |
| **Hippocampus carries no map** | All predictive capability is cortical; hippocampus is a pure index. This is an extreme position in a live debate ([[wiki/empirical-tensions.md]] T28) |
| **Fixed configuration of factors** | The learned latent space for a T-maze task would not survive the T-maze becoming a W-maze: space and task were learned in one fixed combination, not factorised (gap G40) |
| **Actions supplied (TEM)** | The action vocabulary — the thing path integration composes — is given, so hardness source 2 is untouched |
| **No emergence audit (2018)** | Grid-like units appear with no spatial supervision, but fraction-of-runs, seeds, module structure and filtered-noise controls are unreported, so the result answers [[wiki/concepts/objective-identifiability.md]]'s audit item 2 and none of the others |
| **The conjunctive place cell is a modelling choice, not a measurement** | The `g̃ ⊙ x̃` outer product is what predicts non-random remapping and multiple fields, and it costs `×n_c` hippocampal neurons per additional bound cortical region. The transformer rewrite of this same model gets place fields from *memory-index* neurons at `+n_c` cost instead, and predicts random remapping ([[wiki/entities/tem-transformer.md]], [[wiki/empirical-tensions.md]] T40) |
| **No hierarchy** | The proposed prefrontal module that would carry "location in task" above space is a sketch with a predicted cell type (route-dependent goal-vector cells), not an implementation |

**Hardness-source coverage** ([[wiki/concepts/latent-graph-discovery.md]]): source 1 (two-level) ✓ — this is the clearest existing realisation of the meta/instance split · source 3 (aliasing) ✓ · source 4 (simultaneity) ✓ · source 2 ✗ · source 5 ✗ · source 6 ✗.

---

## Connections

- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the same anatomy optimised for the opposite quantity: capacity and one-trial arbitrary binding there, transfer and structural generalisation here, with no model in the wiki supplying both.
- **[[wiki/entities/vector-hash.md]]** — the capacity substrate this model never states: it freezes `g` and the grid↔hippocampal weights to get exponentially many convex attractors and a graceful `1/N_patts` degradation, then assigns content to them *at random* — so it supplies exactly what this page lacks (a derived capacity, no memory cliff, non-interference across 11 maps with no replay) and lacks exactly what this page supplies (any decision about which structural code a state should receive). The two are stackable; the incompatibility is that learning the grid↔hippocampal weights, as this model does throughout, is reported there to destroy the exponential capacity ([[wiki/empirical-tensions.md]] T41).

- **[[wiki/concepts/latent-graph-discovery.md]]** — the two-level hierarchy built rather than argued: a slow, shared path-integrating meta-graph plus a one-shot memory binding this environment's contents, trained by nothing but next-observation prediction — and it supplies that page's measure of how much meta-graph a system has, since knowing the structure converts `O(edges)` experience into `O(nodes)`.
- **[[wiki/concepts/path-integration.md]]** — supplies this architecture's `g` and the reason it transfers; conversely this architecture is what makes path integration trainable from raw observations instead of from supplied spatial targets, and it forces the non-commutative case, since one weight matrix per action makes `uncle = father ∘ brother ≠ brother ∘ father` expressible and required.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the strongest existing demonstration that `g` can be *learned*: content-invariant, reused across environments, and yielding grid-like codes in space and non-spatial latent structure elsewhere; it also *derives* that page's requirement list from one role, since distinctness, path-invariance and content-invariance are all forced by `g` being a memory address.
- **[[wiki/concepts/complementary-learning-systems.md]]** — hippocampal indexing theory implemented: the fast store holds only pointers binding two cortical codes, so consolidation is cortex learning the structure that makes those pointers predictable.
- **[[wiki/entities/cscg.md]]** — the complementary architecture, and the proposed merge (a TEM whose hippocampus also predicts future hippocampal states) that would give fast novel-map construction and transfer at once.
- **[[wiki/concepts/pattern-separation-completion.md]]** — conjunctive hippocampal codes are the separation mechanism here, and remapping is separation applied to whole maps in the service of transfer rather than to episodes.
- **[[wiki/concepts/cognitive-map.md]]** — the model side of that page's evidence: it produces the spatial code, leaves anchoring implicit, and reproduces the non-spatial map results the page catalogues — but that page also carries the domain-matched human null (hippocampus for spatial and not social relational search over the same graph, Kumaran & Maguire 2005, [[wiki/empirical-tensions.md]] T45), which is a direct challenge to this model's premise that one structural module serves family trees and rooms alike.
- **[[wiki/concepts/meta-learning.md]]** — an outer loop over an environment family shaping a fast inner binder, with the inner loop being a memory write rather than a gradient step.
- **[[wiki/concepts/compositionality.md]]** — learns factorised bases (object-vector, border, grid) that recombine to describe new configurations, and shows where the factorisation stops: a fixed task × space pairing does not survive a change of maze topology.
- **[[wiki/concepts/offline-replay.md]]** — the model contributes replay's fourth job (offline path integration binding a goal-vector cell to every location) and in return inherits that page's problem: measured replay content is filtered for generalisability, not for coverage.
- **[[wiki/entities/temporal-context-model.md]]** — the same anatomical division of labour reached 15 years earlier with the opposite codes: entorhinal cortex carries a decaying trace of *content* rather than a content-blind path-integrated `g`, and the hippocampus reinstates past entorhinal states rather than binding structure to sensation. The 2020 model narrows the gap by adopting the other side's primitive: `x` is exponentially filtered (an approximate Laplace transform) before entering the conjunction, so a decaying content trace is *inside* this architecture and the residual dispute is whether a content-blind `g` runs alongside it.
- **[[wiki/concepts/objective-identifiability.md]]** — the standard this model's grid-like units have to meet, and the reason it partly does: its structural code is trained on raw-observation prediction across worlds rather than on a hand-shaped centre–surround spatial readout, which is the ingredient shown to be doing the work elsewhere.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — the rival account of the same phenomenon, and now constrained by it: any allocate-vs-reuse posterior must produce a *new* map whose place-to-grid relationship is preserved, which a state-identity prior alone does not specify.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the architectural contrast: this model runs one structural code rebound per environment, that page's proposal runs many concurrent codes anchored to different objects, which trades TEM's single arbitration-free `g` for redundancy plus an unsolved consensus problem.
- **[[wiki/entities/spiking-tem.md]]** — the same equations rewritten in spikes, and the wiki's one implementation-level check on this page: the factorisation, the realignment/remapping dissociation and grid emergence from one-hot next-observation prediction all survive leaky integrate-and-fire units — but only when three mechanisms this page does not contain (theta-phase inhibition, STDP, a learnable neuromodulatory gain) are present, and only after the `g̃ ⊙ x̃` conjunction is *deleted*, which otherwise abolishes the grid code entirely ([[wiki/empirical-tensions.md]] T42).
- **[[wiki/entities/tem-transformer.md]]** — the same equations rewritten as self-attention: the Hebbian outer-product store is a key/value cache, `g` is a position encoding, one attractor step is one attention block, and the `Λ_x Λ_g` weightings are what the softmax replaces. The rewrite is worth having for three reasons this page cannot supply — a large sample-efficiency gain, conjunction across three or more cortical regions at *additive* rather than multiplicative neuron cost, and a route out of navigation (a position encoding keyed to grammar rather than to space).
- **[[wiki/entities/mm-tem-hippoformer.md]]** — the third rewrite of this page's relational memory, and the one that trades the algebra for an objective: a 3-layer MLP whose fast weights are written by surprise-gated gradient descent replaces the Hebbian outer product, so bidirectional retrieval (`x → g`, `g → g`) has to be *supervised* by auxiliary losses instead of falling out of the tensor product — bought at ~90% accuracy in 5k gradient steps against this model's ~60% in 20k, and extended to egocentric pixels in 3D by running a 32-step transformer alongside it.
