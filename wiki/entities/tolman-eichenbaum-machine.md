# Tolman-Eichenbaum Machine (TEM) and the Spatial Memory Pipeline (SMP)

**Two implementations of one idea: a reusable path-integrating structural code, plus a fast relational memory that ties that code to whatever this environment happens to contain — trained only to predict the next sensory observation, across many environments.**

This is the wiki's `p = f(g, x)` factorization built rather than posited (Whittington et al. 2020 and Uria et al. 2020, as reviewed and extended by Whittington et al. 2022; the primary TEM source is a separate ingest).

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
- **[[wiki/concepts/distributed-reference-frames.md]]** — the architectural contrast: this model runs one structural code rebound per environment, that page's proposal runs many concurrent codes anchored to different objects, which trades TEM's single arbitration-free `g` for redundancy plus an unsolved consensus problem.
