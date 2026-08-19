# Temporal Context Model (TCM)

**One leaky integrator, driven by *item-retrieved* input, is proposed to be the whole of medial temporal lobe representation: run it on words and you get episodic recall; run it on velocity and you get the entorhinal place code; let the hippocampus reinstate its past states and you get transitive inference.** (Howard, Fotedar, Datey & Hasselmo 2005)

The wiki's earliest unification of memory and navigation, and the only one whose spatial and non-spatial predictions come from *literally the same equation with different inputs*.

---

## The two equations

| # | Equation | Reading |
|---|---|---|
| Drift | `t_i = ρ_i t_{i-1} + β t_i^IN`, with `ρ_i` chosen so `‖t_i‖ = 1` | Context is a **normalised leaky integral of its inputs**. No input ⇒ `ρ_i = 1` ⇒ no change: context moves with *events*, not with clock time |
| Retrieved context | `t_{A_{i+1}}^IN = α_O t_{A_i}^IN + α_N t_{A_i}`, `γ := α_N/α_O` | What an item feeds back into context is part *what it fed back last time* (`α_O`) and part *the context it was experienced in* (`α_N`) |

Retrieval: context is the **sole** cue. `M^TF = Σ_i f_i t_i′` (Hebbian outer product), activation `a_i = f_i · (M^TF t)`, recall probability by a competitive (Luce) rule. There are **no item–item associations anywhere in the model** — all apparent item-to-item association is routed through context.

**Free parameters: two.** `β` (drift rate) and `γ` (new/old mix). Everything below is those two plus task-specific inputs.

---

## Mapping onto the medial temporal lobe

| TCM object | Anatomy | Evidence offered |
|---|---|---|
| Items `f` | Neocortical association areas (e.g. area TE) | Perception survives MTL lesion |
| Context `t_i`, and `t^IN` | Parahippocampal region, **entorhinal cortex** in particular | EC/perirhinal units hold stimulus-specific firing across intervening items; perirhinal/EC lesions impair recognition at 6–30 s delays while fornix transection and hippocampus-sparing lesions do not |
| `α_N > 0` — reinstating the EC state an item was previously experienced in | **Hippocampus proper** | Hippocampal lesion spares forward association, abolishes backward and transitive association (Bunsey & Eichenbaum 1996); lesion spares recency, impairs pre-recency serial positions |

**The hippocampus stores no memory in this model.** It is a *reinstatement operator* on entorhinal state: repetition of an item pulls back the context that surrounded it, and cortex does the remembering. This is hippocampal indexing theory expressed as one scalar, `α_N`.

---

## What the two components buy

`t^IN` (old component) enters context only *after* the item, so it cues **forward** only. `t_{A_i}` (new component) is the context surrounding the item, symmetric about it, so it cues **both directions**. Their sum is the observed asymmetric-but-bidirectional contiguity curve of free recall (the conditional response probability, CRP).

| Set | Predicted | Observed |
|---|---|---|
| `γ > 0` | Forward + backward + transitive association; recency | Intact animals/humans |
| `γ = 0` ("lesion") | Forward association and recency intact, backward and transitive gone | Hippocampal-lesioned rats |

Derived cue strength `A → C` after training `A→B` then `B→C`: `a_C = α_N ρ² β (α_O β + α_N)` — **zero iff `α_N = 0`**, while `a_B` and `a_C|B` do not depend on `α_N`. A single parameter dissociates pairwise from relational learning analytically, not by simulation tuning.

---

## The result that matters most here: context overlap becomes graph distance

Train the double-function chain `A→B→C→D→E→F` as disjoint pairs. With `α_N > 0`, the initially orthonormal `t^IN` vectors develop a similarity matrix whose off-diagonal decays with **distance along the chain**: `t_B^IN · t_D^IN > t_B^IN · t_E^IN`, for stimuli never presented together. With `α_N = 0` the representation never moves.

This is [[wiki/concepts/latent-graph-discovery.md]] in its cheapest possible form:

- **Input:** a stream of adjacent pairs (edges), presented in random order and interleaved with an unrelated chain.
- **Output:** an embedding in which inner product ≈ inverse graph distance, i.e. a metric over a graph never seen whole.
- **Cost:** one leaky integrator and one Hebbian outer product; no search, no objective, no gradient.

The paper's own reading: "transitive inference" in rodents needs no inference — an ordering along an abstract dimension falls out of contextual overlap, and *then* could be used by a logical inference if one exists. It also observes that Latent Semantic Analysis is the same two processes (co-occurrence + shared-context generalisation) applied to text, making TCM a retrieved-context account of semantic as well as episodic learning.

**Physiological confirmation of the embedding, not just the behaviour:** in area TE, units responding to the *i*-th stimulus of a fixed-order sequence come to respond to nearby-in-sequence stimuli, with correlation falling off with sequence distance (Miyashita 1988); pair-coding is stronger and ~100 ms earlier in perirhinal cortex, and is **abolished by entorhinal/perirhinal lesion** even for stimuli already over-trained. The similarity structure is imposed on cortex by MTL feedback, exactly as `t^IN` predicts.

---

## The spatial half: a *leaky* path integrator

Feed the same drift equation velocity vectors (`t_i^IN = v_i`, head-direction tuning × speed) and simulate at the cell level with EC layer V integrator cells (Egorov et al. 2002: stable firing without input, step to a new stable rate on each suprathreshold input) plus activity-inverse gain modulation for the normalisation.

Compare `p_i = ρ p_{i-1} + v_i` across `ρ`:

| `ρ` | Representation | Retrospective coding? |
|---|---|---|
| 0 | Head direction only | No |
| **0 < ρ < 1** | **Weighted sum over recent movements — a trajectory** | **Yes** |
| 1 | Perfect path integration; true position | No |

Both extremes fail: the pure place code cannot distinguish two visits to the same arm of a W-maze, and the head-direction code cannot code place at all. Only the leaky regime reproduces what EC actually does (Frank et al. 2000).

| Simulated | Matches |
|---|---|
| Large, noisy, irregular place fields spanning much of an open field | EC place cells (Quirk et al. 1992), unlike compact hippocampal fields |
| Same field locations in a cylinder and a square | EC field correlation across enclosures — because the *set of paths* reaching analogous positions is analogous |
| Trajectory coding; long fields along maze arms | Frank et al. 2000 |
| Retrospective coding (robust) and prospective coding (fragile) | Frank et al. 2000 — note the model contains **no** future information: "prospective" cells are responding to small head-direction changes just before the choice point |

**Why leakiness is an engineering advantage, not a defect.** A perfect integrator accumulates unbounded error and needs dedicated error correction; with `ρ < 1` the error is non-zero but **stationary**, since old contributions decay before their error compounds. The model buys bounded drift with graded forgetting, and gets history-dependence (splitter-like coding) for free from the same knob.

---

## Limits

| Limit | Consequence |
|---|---|
| **Pre-grid-cell** | Written as grid cells were being reported; it explains EC place-like firing as a movement trace, and says nothing about hexagonal periodicity or module structure. Modern accounts of `g` ([[wiki/concepts/path-integration.md]], [[wiki/concepts/successor-representation.md]]) supersede its spatial half |
| **Two regimes, two `γ`s** | The spatial simulations set `γ = 0` — i.e. a *lesioned* hippocampus — while the relational simulations need `γ = 1`. What an "item" is during navigation is unresolved by the paper's own admission |
| **`M^FT` is not anatomy** | The learning rule that implements the retrieved-context equation is admitted to correspond to no structure; only the functional rule `t^IN = α_O(old) + α_N(new)` is claimed |
| **Orthonormal items assumed** | Item vectors are given, fixed and non-overlapping — the discovery of the node vocabulary is entirely outside the model |
| **Similarity ≠ inference** | The embedding orders stimuli but supplies no operator that *uses* the ordering; the Van Elzakker et al. 2003 finding that `B,E` beats `B,D` argues rodent "transitive inference" is this associative gradient rather than inference |
| **Scalar lesion** | Hippocampal function reduced to one number (`α_N`); anything the hippocampus does that is not context reinstatement is invisible |

---

## Comparison

| | **TCM** | [[wiki/entities/tolman-eichenbaum-machine.md]] | [[wiki/entities/cscg.md]] | [[wiki/concepts/successor-representation.md]] |
|---|---|---|---|---|
| State code | Leaky integral of retrieved context | Path-integrated `g` + memory-bound `p` | Clone of an observation | Discounted future occupancy |
| De-aliasing | Partial — history-dependence separates same-place visits | Yes, by binding | Yes, by clone allocation | None (assumes states) |
| Cross-environment transfer | None stated | Yes, shared `g` | None | None |
| Learns graph distance | **Yes, as inner product between context inputs** | Implicitly via `g` | As transition structure | Yes, as `S` |
| Direction of prediction | Retrospective (past-weighted) | Forward (integrate then read) | Forward | Forward |
| Fit cost | 2 parameters, closed-form derivations | Gradient training over environment families | EM per environment | Matrix power series |

**(brainstorm) The exportable piece is the *retrospective* embedding.** Every other structural code in the wiki is built forward — predict the next state, integrate the next action, discount the future. TCM builds the same kind of metric backwards, out of what preceded each item, and gets the graph metric with no prediction objective at all. A modern restatement is nearly free: keep a unit-norm exponential-moving-average of encoder outputs as a "context" vector, cue retrieval with it, and add a term that pushes an item's write vector toward the running context at the time it was seen (`α_N`). That is one EMA and one auxiliary loss on top of any sequence model, and the prediction is that ablating the `α_N` term should selectively destroy backward/transitive generalisation while leaving next-token accuracy intact — a *dissociation*, which is a sharper test than an aggregate score.

**(brainstorm) The `ρ < 1` argument deserves lifting out of the spatial context.** Any recurrent state that accumulates a latent quantity faces the perfect-vs-leaky choice, and the paper's point is that leak converts a growing error into a bounded one at the cost of a bounded horizon. A model with a *bank* of integrators at different `ρ` would trade horizon against precision per channel — which is what Howard's later work makes explicit as a Laplace-domain timeline, and what multi-scale grid modules do spatially.

---

## Connections

- **[[wiki/entities/rolls-treves-hippocampal-model.md]]** — the rival account of hippocampal time: discrete time-encoding cell populations traversed by noise-driven attractor transitions (span `7 ± 2`) versus one graded leaky context integrator, both binding items to time by the same associative rule.

- **[[wiki/concepts/path-integration.md]]** — the same update rule with the leak turned on: this page's `ρ < 1` claims that the biological integrator is deliberately imperfect, which buys bounded error and history-dependent (retrospective) coding at the cost of a metric, and directly contradicts the error-corrected perfect integrator that page's model families assume ([[wiki/empirical-tensions.md]] T31).
- **[[wiki/concepts/successor-representation.md]]** — the temporal mirror image: both turn co-occurrence into a distance-like inner product, but the SR sums *future* occupancy under a policy while retrieved context sums *past* context, so the SR's policy-dependence is replaced here by trajectory-dependence.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the cheapest recovery of a graph metric in the wiki: pairwise edges presented in random order produce an embedding whose inner products decay with graph distance, using one leaky integrator and one Hebbian matrix, with no objective and no search.
- **[[wiki/concepts/cognitive-map.md]]** — supplies the strongest version of "the map is a memory mechanism seen in a spatial task": one equation gives the entorhinal spatial code and the free-recall contiguity curve, which is the domain-generality that page's non-spatial grid findings argue for from the other direction.
- **[[wiki/concepts/complementary-learning-systems.md]]** — an extreme reading of the fast store: the hippocampus holds no content at all and only *reinstates* entorhinal states, so consolidation is cortex inheriting a similarity structure that MTL feedback imposed on it — and the abolition of pair-coding in TE by rhinal lesion is direct evidence of that feedback.
- **[[wiki/concepts/working-memory.md]]** — the case for recency without a buffer: a normalised leaky integrator that only moves when input arrives reproduces short- and long-term recency with one mechanism, and places the maintenance in entorhinal cortex rather than prefrontal cortex.
- **[[wiki/concepts/event-segmentation.md]]** — the graded alternative to a boundary detector: context drifts continuously and similarity of contexts *is* the segmentation, so "which event is this" is a distance in `t` rather than a discrete change-point decision.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the same repetition-driven reinstatement read as completion: `α_N` is a completion operator whose input is an item and whose output is a whole past context state, and the accumulating overlap between `t^IN`s is the anti-separation direction of the transfer curve.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the modern successor with the responsibilities re-assigned: both put a reusable code in entorhinal cortex and a binding operation in hippocampus, but TEM's code is path-integrated and content-blind while TCM's is a decaying trace of content itself, and TEM predicts forward while TCM embeds backward.
- **[[wiki/entities/cscg.md]]** — the rival treatment of same-place-different-history: clone allocation makes the distinction discrete and exact, whereas leaky integration makes it graded and automatic but never fully separates two visits.
- **[[wiki/concepts/offline-replay.md]]** — supplies a use for the reinstatement operator this page defines: replaying an item pulls back its stored context, which is the mechanism by which offline reactivation could propagate transitive structure without new experience.
