# HiSD — Hierarchical Skill Discovery

**A two-stage pipeline that turns unlabelled observation trajectories into a multi-level option library: temporal action segmentation (TAS (Temporal Action Segmentation)) cuts the pixel stream into `K` recurring skills by optimal transport, then a grammar-induction pass (Sequitur) compresses the resulting symbol strings into a context-free grammar whose parse trees *are* the task hierarchy — no actions, no rewards, no interaction, no subtask ordering, no hierarchy depth.**

> **Provenance.** Harvey, Nangue Tasse, Rosman, Ingram & James 2026, *Unsupervised Hierarchical Skill Discovery*, ICML (`raw/harvey-2026-hierarchical-skill-discovery.md`). Evaluated on Craftax (modified to be fully observable and deterministic) and on the full, unmodified Minecraft with raw keyboard/mouse control. Everything below is from that source unless marked.

This is the wiki's first *implemented* answer to the option-discovery problem ([[wiki/concepts/temporal-abstraction-options.md]], gap G33) that discovers the **nesting** as well as the options, and does it from observations alone.

---

## Architecture

| Stage | Input | Mechanism | Output |
|---|---|---|---|
| 0 · Features | raw pixels (274×274×3 Craftax; 640×360 Minecraft) | PCA (Principal Component Analysis), 650 components ≈ 99% variance (Craftax); MineCLIP 512-d embeddings (Minecraft) | `X_t ∈ ℝ^d` per frame |
| 1 · Segmentation | `{T^(1)…T^(N)}`, all trajectories as one batch | ASOT — unbalanced optimal transport, `min_Γ ⟨C,Γ⟩ + α·R_temp(Γ) + λ·D_KL(Γᵀ1_n ‖ q)`; hardening `z_t = argmax_k Γ*_tk` | frame-level skill indices `z_t ∈ {1…K}` |
| 2 · Symbolisation | `z_1:n` | collapse contiguous equal labels to one symbol — **duration is discarded**, only sequencing survives | per-episode string `S^(i)` over alphabet Σ, `\|Σ\| = K` |
| 3 · Grammar induction | `S_corp = S^(1) ⊕ φ ⊕ S^(2) ⊕ … ` | Sequitur, modified so the episode-boundary token `φ` may never enter a production rule | grammar `G`; parsing `S^(i)` with `G` gives tree `τ^(i)` |
| 4 · Deployment (separate phase) | segmented data **+ action labels** | per skill: behavioural cloning for `π_i(a\|s)`; positive-unlabelled classifiers for initiation `I_i` and termination `β_i(s)`; internal grammar nodes become composite options executing children in order; maskable PPO over options with `I_i` as the action mask | executable option hierarchy |

**The two ideas that carry the method:**

| Idea | Statement | Why it matters here |
|---|---|---|
| **Temporal regularity as a Gromov–Wasserstein term** | `C^v_ik = 1/r` for `1 ≤ \|i−k\| ≤ nr`, else 0; `C^a_jl = 1[j≠l]`; quadratic GW loss. Penalises assigning two frames within `nr` steps to *different* skills, and nothing else | The radius `r` **directly sets the minimum expected segment length** — one interpretable scalar controlling temporal granularity, where every other segmenter in the wiki has a hand-set error threshold |
| **Unbalanced transport with a KL marginal** | `λ·D_KL(Γᵀ1_n ‖ q)` is a *soft* constraint on the aggregate skill distribution | No skill must appear in every episode and no ordering is imposed; rare-but-critical interaction skills survive alongside skills that dominate the frames (Minecraft walking ≈ 6% of frames) |

Nothing in stage 1 predicts anything: boundaries fall out of clustering plus smoothness, not out of a broken forward model — which puts it against every detector on [[wiki/concepts/event-segmentation.md]] ([[wiki/empirical-tensions.md]] T139).

**Sequitur's two invariants are the whole granularity control:** (1) *digram uniqueness* — no adjacent symbol pair occurs twice without becoming a rule; (2) *rule utility* — every rule is used at least twice or is expanded away. Linear time, deterministic, no depth parameter. The derivation tree is the hierarchy: root = episode, internal nodes = discovered subroutines, leaves = atomic skills; non-terminals may contain non-terminals, so depth is recursive and emergent.

---

## Supervision asymmetry (the actual claim)

| Method | Actions | Sub-task order | `K` | Other |
|---|---|---|---|---|
| **HiSD** | — | — | ✓ | — |
| CompILE | ✓ | ✓ (given at inference) | ✓ | segments per trajectory |
| OMPN (Ordered Memory Policy Network) | ✓ | ✓ (given at inference) | ✓ | hierarchy depth |

Baselines were run under their *most favourable* conditions — given the ground-truth subtask ordering — and still lost on every task but the shortest.

---

## Results

**Segmentation (Avg. mIoU (mean Intersection-over-Union), 5 seeds):**

| Task | HiSD | OMPN | CompILE |
|---|---|---|---|
| Craftax WSWS Random (2 skills, short) | 63% ±12 | 75% ±12 | **76% ±4** |
| Craftax Stone Pickaxe Static (5 skills) | **66% ±15** | 30% ±4 | 45% ±18 |
| Craftax Stone Pickaxe Random | **59% ±2** | 27% ±3 | 32% ±7 |
| Craftax Mixed Static (6 goal types) | **62% ±10** | 49% ±9 | 56% ±8 |
| Minecraft All (44 skills) | **31% ±2** | 14% ±6 | 6% ±3 |
| Minecraft Mapped (14 skills) | **38% ±5** | 14% ±6 | 6% ±1 |

The advantage appears exactly where horizon and skill count grow, and **inverts on the shortest task** — action supervision is worth more than temporal-coherence structure when there are two skills and nothing to compose.

**Hierarchy quality (unique trees ↓ = consistent reuse; ground truth = the same modified Sequitur run on clean labels):**

| Task | Truth | HiSD | OMPN | Note |
|---|---|---|---|---|
| WSWS Random | 9 | **9** | 499 | exact match |
| Stone Pickaxe Static | 1 | 36 | 500 | |
| Stone Pickaxe Random | 7 | 47 | 500 | |
| Mixed Static | 5 | 13 | 391 | |
| Minecraft All | 293 | 500 | 500 | tree *size* 22.7 (truth) → 283 (HiSD); max branching 28.7 |
| Minecraft Mapped | 151 | 500 | 500 | size 21.4 → 83.9; max branching 5.4 |

OMPN's failure is diagnosable from one column: mean branching 7.88 and max 43.9 in Minecraft means it emits a shallow fan, i.e. it never discovers intermediate subroutines at all.

**Downstream RL (options grounded by behavioural cloning; Craftax "Craft Wooden Pickaxe", sparse +1, 10 seeds):**

| Agent | Outcome |
|---|---|
| HiSD **hierarchy** | near-optimal reward by ≈30k steps; closely matches the ground-truth hierarchy |
| HiSD **skills only** (flat) | strictly worse than the same skills under the grammar |
| CompILE skills only | ≈0.7 reward |
| OMPN hierarchy | fails to converge — excessive branching inflates the option-level action space |
| Primitive-action PPO | fails entirely |
| Imitation learning | 0 reward |

Minecraft "Collect Log" mirrors it: HiSD hierarchy solves 50% of episodes, flat HiSD skills lower, ground truth 100%, primitive PPO fails. Demonstration sweep: the hierarchy reaches 0.94 ±0.08 mean reward at `N = 250` action-labelled episodes and matches the ground-truth hierarchy from `N = 350` — the *discovery* stage stays unsupervised throughout.

**The load-bearing measurement: hierarchy > skills-only, with the skill set held fixed.** This is the wiki's first isolation of the value of the *nesting* itself rather than of temporal abstraction in general — the flat and hierarchical agents draw from the same discovered options and differ only in whether the grammar's composite nodes are selectable.

---

## Limitations, and what each one localises

| Limitation | Consequence | Wiki reading |
|---|---|---|
| **Sequitur is deterministic and cannot absorb segmentation noise** | near-duplicate skill strings are treated as distinct symbol sequences, so no rule is reused; Minecraft All yields 500 unique trees for one shared task | The symbolic-level instance of over-separation ([[wiki/concepts/pattern-separation-completion.md]]): a fully separating code at the terminal alphabet destroys reuse downstream. Authors' own remedy — probabilistic grammars (PCFG, fragment grammars) marginalising over noisy parses — is pattern *completion* over parse trees |
| **`K` is a prior** | the maximum skill count must be supplied | Performance peaks when `K` matches ground truth and **degrades gracefully under over-estimation** rather than collapsing; proposed fix is a decreasing schedule of `K` with label-switching frequency or segmentation cost as the stopping criterion — i.e. the unpinned granularity of gap G24/G27 is at least *sweepable* here |
| **One discrete skill per timestep** | concurrent behaviours (grasping while walking) are unrepresentable | Shared with all TAS baselines; multi-label / factored optimal transport is the named extension — and factoring the skill is exactly the `(manoeuvre g, content x)` repair [[wiki/concepts/temporal-abstraction-options.md]] argues for |
| **Features are pre-extracted, not learned end-to-end** | PCA / MineCLIP fix what "visually similar" means, so the skill vocabulary inherits the encoder's invariances | The de-aliasing problem re-enters through the encoder: walking-toward-wood and walking-toward-stone are pixel-identical in first-person view and are separated *only* by the temporal-regularity prior, i.e. by context rather than content (gap G2) |
| **Discovery is observation-only, deployment is not** | grounding skills into policies needs action labels (`N ≈ 250–350` episodes) | The split is the point: structure scales to unlabelled video, control does not |

---

## Reading in the core framing

| Element | [[wiki/concepts/latent-graph-discovery.md]] reading |
|---|---|
| Skill (terminal symbol) | A compiled edge, discovered by *visual coherence + temporal contiguity* rather than by bottleneck-ness in an estimated transition graph |
| Run-length collapse | Edges are typed by identity and stripped of length — the graph is made purely topological before structure is induced |
| Non-terminal rule | A **path** reified as one edge, one level up; the option-of-options the four-rooms formalism allows and never builds |
| Rule utility ≥ 2 | The reuse criterion: an edge is admitted to the library only if the corpus traverses it twice |
| `φ` excluded from rules | An explicit prohibition on edges spanning episode boundaries — the only place the method uses a segmentation it did not derive |
| 500 unique trees | The library failed to compress: every episode got its own private path, which is memorisation with extra steps |

**(brainstorm) The interesting inversion versus the wiki's existing option-discovery families.** Botvinick's graph-partitioning family says: estimate the transition graph, find its access points, compile options through them — structure comes from *topology*. HiSD says: never estimate a graph at all; segment the observation stream by perceptual coherence, then let a compression algorithm find the recurring substrings. The subgoal is whatever *recurs*, not whatever *bottlenecks*. These will coincide when bottleneck states are the frames that look alike across episodes, and will diverge exactly when they are not — a testable difference the wiki can pose as a single experiment: run graph partitioning and HiSD on the same four-rooms corpus and check whether the doorway options and the induced non-terminals name the same states. If they do, compression is the cheaper route to the same object, because it needs no adjacency estimate.

**(brainstorm) Rule utility is the stopping rule [[wiki/concepts/event-segmentation.md]] says nobody has.** That page's open problem is that "frequently encountered interactions may be clustered into episodes" names no clustering objective, no granularity control and no stopping rule. Sequitur supplies all three as one criterion with no free parameter: compress until digrams are unique and every rule pays for itself twice. It is a crude minimum-description-length ([[wiki/glossary.md]] MDL) argument, and its crudeness is precisely the deterministic-grammar failure above — but it is the first mechanism in the wiki that decides *how deep the temporal hierarchy goes* from the data rather than from a hyperparameter.

**(brainstorm) The two stages have opposite noise tolerances, and that is the design flaw.** Stage 1 is deliberately soft — unbalanced transport, KL marginals, a smoothness radius, all built to survive imperfect demonstrations. Stage 2 is exact-match over symbol strings. Feeding a soft segmenter's argmax into a deterministic grammar throws away all the uncertainty the first stage carefully maintained at the one point where it would have paid: a probabilistic parser given `Γ*` rather than `argmax Γ*` could marginalise over the segmentations that differ by one flickering frame, which is where the 500-unique-trees failure comes from.

---

## Comparison

| | HiSD | OMPN | CompILE | Options (Botvinick) | H-JEPA |
|---|---|---|---|---|---|
| Needs actions | no (discovery) | yes | yes | n/a (online) | yes |
| Needs reward / interaction | no | no | no | yes | yes |
| Multi-level hierarchy | **yes, emergent depth** | yes, depth given | no (flat) | in principle, never built | fixed time-scales |
| Variable-length units | yes | yes | yes | yes | **no** |
| Where structure comes from | corpus-level string compression | learned memory stack | latent segment model | bottlenecks / pseudo-reward | none — levels are architectural |
| Termination condition | PU classifier, learned post hoc | — | — | `β(s)`, part of the option | none |

---

## Connections

- **[[wiki/concepts/temporal-abstraction-options.md]]** — supplies a **sixth** option-discovery family the five-family census does not contain: compress a symbolised observation corpus with a grammar and take the recurring substrings as options, so subgoals are defined by *recurrence* rather than by bottleneck-ness, reward, novelty or a teacher — and it is the first mechanism that also produces the option-of-options nesting that framework permits but never builds.
- **[[wiki/concepts/event-segmentation.md]]** — supplies both halves that page lacks: a boundary detector whose granularity is one interpretable scalar (the Gromov–Wasserstein radius `r` sets the minimum segment length) rather than a hand-set error threshold, and a stopping rule for the episode hierarchy (Sequitur's rule-utility ≥ 2), at the price of requiring the whole corpus offline and a maximum skill count `K`.
- **[[wiki/concepts/compositionality.md]]** — a context-free grammar induced over *behaviour* rather than over form: terminals are skills, non-terminals are subroutines, and productivity is bought by the same digram-uniqueness rule that makes the compression lossless — with the failure mode the page predicts, since a symbol vocabulary that over-separates leaves nothing to share.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the alternative order of operations: every other route in the wiki estimates the transition graph and then partitions it, while this one skips the graph entirely and recovers hierarchy from string statistics over a perceptually derived alphabet.
- **[[wiki/concepts/pattern-separation-completion.md]]** — the same separation/completion trade at the symbolic level: an over-separating terminal alphabet (44 Minecraft skills, noisy) yields 500 unique parse trees and zero subroutine reuse, and the proposed fix — a probabilistic grammar marginalising over parses — is completion applied to structure rather than to patterns.
- **[[wiki/concepts/simulation-based-planning.md]]** — grounds the "who sets the subgoals?" problem in a measurement: composite grammar nodes used as selectable options beat the same options used flat, so the value of the *decomposition* is separable from the value of temporal abstraction.
- **[[wiki/entities/h-jepa.md]]** — the contrast on where hierarchy depth comes from: H-JEPA fixes levels architecturally as time-scales with no termination function, while HiSD's depth is whatever the corpus compresses to — but HiSD has no world model and cannot plan, only select among compiled options.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the conversion-rate claim made operational: a fixed unsupervised discovery budget plus ≈250–350 action-labelled episodes converts into near-ground-truth performance on a held-out task, so the discovered hierarchy is a measured prior rather than an asserted one.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the equivalence applied to action streams: the hierarchy is literally the by-product of compressing a corpus of behaviour, so "better model of the task" and "shorter description of the demonstrations" are the same objective here, with the tree count as the readout.
