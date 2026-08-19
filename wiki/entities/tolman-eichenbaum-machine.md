# Tolman-Eichenbaum Machine (TEM) and the Spatial Memory Pipeline (SMP)

**Two implementations of one idea: a reusable path-integrating structural code, plus a fast relational memory that ties that code to whatever this environment happens to contain — trained only to predict the next sensory observation, across many environments.**

This is the wiki's `p = f(g, x)` factorization built rather than posited (Whittington et al. 2020 and Uria et al. 2020, as reviewed and extended by Whittington et al. 2022; the primary TEM source is a separate ingest). The line starts with Whittington et al. 2018, whose distinct contributions — hierarchical frequency bands, the entorhinal cell zoo as transition-statistic basis functions, and the neural evidence that place-cell remapping is *not* random — are in their own section below.

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

## Results

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
| **No hierarchy** | The proposed prefrontal module that would carry "location in task" above space is a sketch with a predicted cell type (route-dependent goal-vector cells), not an implementation |

**Hardness-source coverage** ([[wiki/concepts/latent-graph-discovery.md]]): source 1 (two-level) ✓ — this is the clearest existing realisation of the meta/instance split · source 3 (aliasing) ✓ · source 4 (simultaneity) ✓ · source 2 ✗ · source 5 ✗ · source 6 ✗.

---

## Connections

- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the same anatomy optimised for the opposite quantity: capacity and one-trial arbitrary binding there, transfer and structural generalisation here, with no model in the wiki supplying both.

- **[[wiki/concepts/latent-graph-discovery.md]]** — the two-level hierarchy built rather than argued: a slow, shared path-integrating meta-graph plus a one-shot memory binding this environment's contents, trained by nothing but next-observation prediction.
- **[[wiki/concepts/path-integration.md]]** — supplies this architecture's `g` and the reason it transfers; conversely this architecture is what makes path integration trainable from raw observations instead of from supplied spatial targets.
- **[[wiki/concepts/abstract-structural-codes.md]]** — the strongest existing demonstration that `g` can be *learned*: content-invariant, reused across environments, and yielding grid-like codes in space and non-spatial latent structure elsewhere.
- **[[wiki/concepts/complementary-learning-systems.md]]** — hippocampal indexing theory implemented: the fast store holds only pointers binding two cortical codes, so consolidation is cortex learning the structure that makes those pointers predictable.
- **[[wiki/entities/cscg.md]]** — the complementary architecture, and the proposed merge (a TEM whose hippocampus also predicts future hippocampal states) that would give fast novel-map construction and transfer at once.
- **[[wiki/concepts/pattern-separation-completion.md]]** — conjunctive hippocampal codes are the separation mechanism here, and remapping is separation applied to whole maps in the service of transfer rather than to episodes.
- **[[wiki/concepts/cognitive-map.md]]** — the model side of that page's evidence: it produces the spatial code, leaves anchoring implicit, and reproduces the non-spatial map results the page catalogues.
- **[[wiki/concepts/meta-learning.md]]** — an outer loop over an environment family shaping a fast inner binder, with the inner loop being a memory write rather than a gradient step.
- **[[wiki/concepts/compositionality.md]]** — learns factorised bases (object-vector, border, grid) that recombine to describe new configurations, and shows where the factorisation stops: a fixed task × space pairing does not survive a change of maze topology.
- **[[wiki/concepts/offline-replay.md]]** — the model contributes replay's fourth job (offline path integration binding a goal-vector cell to every location) and in return inherits that page's problem: measured replay content is filtered for generalisability, not for coverage.
- **[[wiki/entities/temporal-context-model.md]]** — the same anatomical division of labour reached 15 years earlier with the opposite codes: entorhinal cortex carries a decaying trace of *content* rather than a content-blind path-integrated `g`, and the hippocampus reinstates past entorhinal states rather than binding structure to sensation.
- **[[wiki/concepts/objective-identifiability.md]]** — the standard this model's grid-like units have to meet, and the reason it partly does: its structural code is trained on raw-observation prediction across worlds rather than on a hand-shaped centre–surround spatial readout, which is the ingredient shown to be doing the work elsewhere.
- **[[wiki/entities/hidden-state-inference-remapping.md]]** — the rival account of the same phenomenon, and now constrained by it: any allocate-vs-reuse posterior must produce a *new* map whose place-to-grid relationship is preserved, which a state-identity prior alone does not specify.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the architectural contrast: this model runs one structural code rebound per environment, that page's proposal runs many concurrent codes anchored to different objects, which trades TEM's single arbitration-free `g` for redundancy plus an unsolved consensus problem.
