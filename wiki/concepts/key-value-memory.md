# Key-Value Memory

**A store whose *address* and its *contents* are separate learned representations: write the pair `(k_n, v_n)`, read `v̂ = σ(S(K, q))·V`. The separation is the whole content of the idea — keys can be optimised for discriminability (so that queries land on one memory) while values are optimised for fidelity (so that what comes back is the episode), and no single-code store can do both. Every similarity-based memory in the wiki is the special case `K = V`, i.e. the constraint that the address *is* the content.**

> **Provenance.** Gershman, Fiete & Irie 2025, *Key-value memory in the brain*, arXiv 2501.02950v2 (`raw/gershman-2025-key-value-memory-in-the-brain.md`). A review with two toy simulations; the authors state plainly that the brain mapping is speculative. The formal taxonomy below is their restatement of Kohonen 1972, Millidge et al. 2022 and Irie et al. 2022; the empirical ledger is other groups' experiments.

The wiki had the machinery — [[wiki/entities/sparse-distributed-memory.md]], [[wiki/entities/vector-hash.md]], [[wiki/entities/three-factor-key-value-memory.md]], [[wiki/concepts/fast-weight-programming.md]], [[wiki/concepts/attention.md]] — and no page stating what the address/content split *buys*. This is that page.

---

## The read, and the two dials that generate every store on this wiki

```
write   ΔM ∝ k_nᵀ v_n                           (Hebbian, keys × values)
read    v̂  = q M  ∝  Σ_n α_n v_n ,   α = σ(S(K, q))
```

`S(·,·)` is a **similarity kernel** (how a query matches an address); `σ(·)` is a **separation operator** (how sharply the best match is preferred). Fixing the two recovers the wiki's memories as points in one family:

| Store | `S(K, q)` | `σ(α̃)` | Key/value relation |
|---|---|---|---|
| Correlation-matrix memory (Kohonen 1972) | `qKᵀ` linear | identity | free — heteroassociative |
| [[wiki/entities/hopfield-network.md]] and autoassociative models | `qKᵀ` | sign / threshold | **`K = V`** |
| [[wiki/entities/sparse-distributed-memory.md]] | Hamming ball | threshold | `K` fixed random, `V` plastic |
| [[wiki/entities/dense-associative-memory.md]] | `qKᵀ` | rectified polynomial `x^n` | `K = V` |
| [[wiki/entities/transformer.md]] self-attention | `qKᵀ/√D` | softmax | learned `W_k, W_q, W_v` |
| Linearised attention / [[wiki/concepts/fast-weight-programming.md]] | `φ(q)φ(K)ᵀ` | identity | learned; recurrent form, linear cost |
| Kernel attention (RBF) | explicit infinite-dim kernel | softmax | learned |
| Noiseless ideal | any | `max` | — |

Three consequences a builder can use:

- **`σ = max` is optimal and unusable.** It always returns the value of the matching key and is maximally brittle to noise, so every real store is a point on a **separability–robustness** curve. The softmax's `β` and the dense-memory exponent `n` ([[wiki/entities/dense-associative-memory.md]]) are the same dial seen twice, and [[wiki/entities/continuous-modern-hopfield-network.md]]'s measurement that trained heads sit in the *metastable* (deliberately unseparated) regime says transformers choose the robust end (`T390`).
- **Autoassociation is a constraint, not a design.** `K = V` buys content-addressability for free and pays by making one representation serve two objectives that this page's simulation shows pull in different directions: trained on the same retrieval task, 2-D keys migrate to opposite quadrants (dot-product separability) while 2-D values migrate to the class feature vectors (content fidelity). Every capacity number in `G42` derived for a `K = V` store is therefore a number for the *constrained* case.
- **The kernel is where non-linear matching goes.** Any positive semi-definite kernel is an inner product under some `φ`, so "a better address match" and "a feature transform on the keys" are the same move — which is why `retrieval-capacity`'s rank bound on factorised scores ([[wiki/concepts/retrieval-capacity.md]]) applies to the whole family and not only to attention.

---

## The equivalence that makes every trained linear layer a memory

Irie et al. 2022, reproduced here: a linear layer `y = xW` trained by gradient descent for `N` steps has

```
W = W_0 + Σ_n x_nᵀ e_n ,        e_n = −η_n (∇_y L)_n
y = x W_0 + Σ_n α_n v_n ,       k_n = x_n ,  v_n = e_n ,  q = x
```

The layer **is** a key-value memory whose keys are its training inputs and whose values are its own **error signals**. Two things follow that the wiki has nowhere else:

1. **A gradient-trained layer never forgets.** The sum retains every `(x_n, e_n)` pair indefinitely; what is lost under continual training is *retrieval access*, not the trace. This is an identity, not an empirical claim.
2. **The stored content is error, not experience.** What a slow learner memorises is the set of places it was wrong — which is a different object from the episodes a fast store holds, and makes `W_0` the only part of the layer that is not a memory.

**The simulation that cashes this out.** One-hidden-layer network, MNIST (digits 0/1) then FashionMNIST (T-shirt/trouser), 5 epochs each, no rehearsal: task-1 test accuracy 99% → ~9%, task-2 → ~95% — textbook catastrophic forgetting ([[wiki/concepts/continual-learning.md]]). Now multiply the keys of *all* task-1 key-value pairs by a scalar `β ≥ 1`. Task-1 accuracy recovers **with no retraining and no task-1 data**. The forgotten memories were present in the parameters the whole time; only their attention weights had been swamped.

**The caveat that keeps this from being a method.** `β` is applied to a set the experimenter labels "task 1". The result demonstrates *presence*, not *recoverability* — nothing in the model identifies which stored pairs to amplify, which is exactly the missing piece that `G49` and `G60` name (no store schedules its own reads; nothing chooses the query). It is a diagnostic, not an eviction-free continual learner.

---

## Where the addresses come from: learned, fixed, or drifting

| Scaffold | Address structure | Instantiation | Price |
|---|---|---|---|
| **Learned** | `k = xW_k`, `q = xW_q` end-to-end | transformers, fast weight programmers | needs a credit-assignment path into `W_k`; suffers a **memory cliff** at capacity |
| **Fixed random** | similar keys do *not* index similar values — digital RAM | [[wiki/entities/sparse-distributed-memory.md]] | no structure to exploit; address space must be huge |
| **Fixed structured** | modular attractor states (grid modules) randomly projected | [[wiki/entities/vector-hash.md]], MESH | expressible states are products of rigid module states |
| **Slowly drifting random** | random addresses that change slowly, so temporal proximity ⇒ address similarity | [[wiki/entities/temporal-context-model.md]] | structure is temporal only |
| **Autoassociative** | address = content | [[wiki/entities/hopfield-network.md]] | one code, two objectives |

The review's sharpest empirical claim is on the third row: fixed grid-module scaffolds give a large address space with **large, uniform basins**, so overload degrades gracefully as memories come to share addresses instead of falling off a cliff — and they **outperform a flexible encoder trained end-to-end to minimise reconstruction error**. A learned address space is not obviously the better one, which is the reverse of the default assumption in every machine store here. Fiete's line reads this as evidence that the entorhinal-hippocampal system is an addressing system rather than a content store (see [[wiki/concepts/hippocampal-indexing-theory.md]]).

The open design question the authors leave standing: does a system want *both* — a fixed scaffold for robustness plus learned key mappings for task-specific discriminability — and if so what arbitrates between them? No source in the wiki has built the hybrid.

---

## The biological claim, and its ledger

Three claims, each with the evidence the review assembles (all cited, none run by these authors).

### 1. Storage is effectively indelible; retrieval interference is the binding constraint

| Evidence | Reading |
|---|---|
| Capacity estimates `10⁷–10¹⁵` bits against `10¹³–10¹⁷` bits of sensory input | compression makes storage plausibly non-binding — weak, assumption-laden |
| Memories survive decades unrehearsed, yet 5–20-item lists are forgotten within minutes | the two cannot both be storage limits |
| Shiffrin's list-before-last recall: performance depends on the length of the list **being recalled**, not the length of the intervening list | forgetting is not displacement by new items |
| Berens et al.: over a retention interval, **accessibility** declines while **precision** does not | memories vanish whole and return sharp — the signature of an addressing failure |
| Retrograde amnesia shrinks; protein-synthesis-inhibition amnesia recovers on delayed test, and can be reversed *by the amnestic agent itself* | the trace outlived the loss of access |
| Extinction is followed by spontaneous recovery and single-reminder reinstatement | same, in conditioning |

### 2. Keys are hippocampal, values neocortical

| Evidence | Reading |
|---|---|
| Cortical encoding patterns are reinstated at retrieval; reinstatement is hippocampus-dependent and necessary for recall | the index addresses cortical content |
| Semantic dementia: profound semantic loss with relatively intact recent recognition | an episodic key with no value is an empty vessel |
| Winocur et al.: context-specific fear generalises after a week; a reminder restores specificity — and the reminder effect is **abolished by hippocampal lesion** | without keys, values can only be accessed diffusely → overgeneralisation |
| Hippocampal engrams are sparse, conjunctive, and causally sufficient; hub connectivity to cortex | key-like: discriminative, not contentful |
| Food-caching birds: unique hippocampal ensembles for **>100 cache sites**, reactivated at retrieval | address space measured, in an animal that needs one |
| Chanales et al.: overlapping routes drive **repulsion** of hippocampal representations, gradually, past the point of reversing objective similarity, correlated with discrimination accuracy | keys are optimised *against* input similarity — the discriminability objective, measured |

The repulsion result is the load-bearing one: it is representational change driven by **retrieval demand** rather than by input statistics, which is what "optimised for discriminability" has to mean mechanistically. It is also where this framing makes a falsifiable prediction the authors flag as untested — **repulsion should be reversible** when the discrimination demand is removed.

### 3. Keys are matched but never recalled

| Evidence | Reading |
|---|---|
| Feeling-of-knowing predicts later recognition of currently unrecallable items | the store reports a match without returning a value |
| Reder: answerability judged **faster** than the answer is produced | the key match completes before the value read |
| Cue familiarity inflates feeling-of-knowing without improving recall | the signal is key-query match strength, and it can be spoofed |
| Change detection without identification; "butcher on the bus" familiarity without recollection | content-addressable keys that do not obligatorily activate values |

**This is the payload for a reasoning model, and the wiki has been missing it.** Key-query matching yields a *metamemory* scalar — do I hold anything relevant? — computed **before and without** the value read. Every confidence signal in the wiki is derived from an answer already produced ([[wiki/concepts/confidence-calibration.md]], [[wiki/concepts/selective-prediction.md]]); this one is available from the address stage alone, is cheaper than retrieval, and is what a controller would need to decide *whether to bother retrieving*. Standard similarity-based models cannot express it, because with `K = V` checking whether something is stored **is** retrieving it.

**(brainstorm) The buildable version is small.** In any attention-based store, `max_n α̃_n` before the softmax is a raw key-match score that the normalisation then destroys (softmax is shift-invariant, so an all-irrelevant cache and a perfect-hit cache can produce identical attention weights). Exposing the pre-normalisation max as a gate — read only if it clears a threshold, otherwise decline — costs one scalar per head and gives the "I don't know" that `G42`'s silent-failure complaint and the selective-prediction literature both ask for. Nothing in the wiki does this; [[wiki/entities/continuous-modern-hopfield-network.md]]'s separation `Δ_i` is the store-level version of the same quantity, computed from keys with no query.

---

## Limitations

- **A review whose central mapping is admitted to be speculative.** Hippocampus = keys, neocortex = values is an *interpretation* of the complementary-learning-systems and indexing literatures; no experiment here separates a key representation from a value representation directly.
- **The simulations are demonstrations, not results.** 2-D keys/values with two or three classes; a one-hidden-layer MNIST/FashionMNIST pair. Neither touches capacity, scale, or naturalistic data.
- **The `β` recovery needs an oracle** (above) — it labels the task-1 key-value pairs by construction.
- **"Never erased" is an argument from behaviour, not a measurement.** Every cited recovery shows *some* memories return under *some* cue; none shows that nothing is ever lost. The wiki's own stores contain explicit erase mechanisms (`T392`).
- **Where pattern separation/completion happens is left open** — the review explicitly declines between recurrent entorhinal-hippocampal loop ([[wiki/entities/vector-hash.md]]) and dentate-separation/CA3-completion ([[wiki/concepts/pattern-separation-completion.md]], `T49`).
- **No forgetting rate, no write refusal, no occupancy read** — the framing inherits all three of `G42`'s standing holes and adds none.
- **The split says nothing about orientation.** A key matches and a value is returned; nothing in the framing identifies *where on the returned structure the agent currently is*, and the separation makes it a live question rather than a settled one — anchoring is a key problem if the address must be recomputed from the present situation, and a value problem if the returned structure carries its own slots (`G39`).

---

## Connections

- **[[wiki/concepts/complementary-learning-systems.md]]** — CLS re-read as an addressing architecture rather than two content stores: the hippocampus holds keys optimised for discriminating episodes, neocortex holds values optimised for semantic fidelity, and the division of labour is then a consequence of the two objectives rather than of the two learning rates.
- **[[wiki/concepts/hippocampal-indexing-theory.md]]** — the same claim reached from the anatomy side and thirty years earlier: an index is a key with an empty value, and this page supplies the computational reason the index must be a *separate* representation (discriminability and fidelity cannot be optimised in one code).
- **[[wiki/entities/three-factor-key-value-memory.md]]** — the write rule this page's framing needs and does not supply: a presynaptic-only key write and a Hebbian value write, recovered by meta-learning rather than assumed, which is the mechanistic form of "keys and values want different objectives".
- **[[wiki/entities/vector-hash.md]]** — the fixed structured scaffold, and the review's strongest empirical support: a grid-module address space with large uniform basins degrades gracefully instead of hitting a memory cliff, and beats a reconstruction-trained encoder — evidence that the address space should *not* be learned end-to-end.
- **[[wiki/entities/sparse-distributed-memory.md]]** — the fixed *random* scaffold, the other pole of the same axis: similar keys deliberately do not index similar values, which is what buys RAM-like addressing and what forfeits any structure in the address space.
- **[[wiki/concepts/attention.md]]** — self-attention as one point in the `(S, σ)` family (`qKᵀ/√D`, softmax), with the consequence that the softmax discards the absolute key-match score a metamemory read would need.
- **[[wiki/concepts/fast-weight-programming.md]]** — the `σ = identity` corner, where the read becomes a recurrent outer-product store; this page adds Irie's dual showing that an ordinary gradient-trained linear layer is already such a store, with training inputs as keys and error signals as values.
- **[[wiki/entities/dense-associative-memory.md]]** — the separation operator pushed to a polynomial: the capacity exponent `n` and the softmax `β` are the same separability dial, and both are read here against the robustness cost of `σ = max`.
- **[[wiki/entities/continuous-modern-hopfield-network.md]]** — the same read written as an energy descent, supplying the store-level version of the metamemory signal this page identifies: separation `Δ_i` computable from the keys alone, where the behavioural evidence here asks for a per-query match score.
- **[[wiki/concepts/retrieval-capacity.md]]** — the constraint that survives the split: keys optimised for discriminability still score by a factorised inner product, so the `d ≥ log C(n,k)/log(1+1/γ)` bound on askable query sets applies to the address space no matter how it was learned.
- **[[wiki/concepts/continual-learning.md]]** — catastrophic forgetting recast as retrieval interference: in the key-value dual of a trained linear layer the old task's pairs are still present, and a scalar gain on their keys restores the old task with no retraining, which relocates the problem from parameter overwriting to addressing (`T392`).
- **[[wiki/concepts/engram.md]]** — the biological counterpart of the `β` simulation: optogenetic reactivation of a silent engram after retrograde amnesia is the same intervention — amplify the address of a trace whose content survived — done in tissue.
- **[[wiki/concepts/memory-read-and-erase.md]]** — the protocol page this framing argues against on one primitive: if forgetting is always retrieval failure, an erase operator is unnecessary and the family of removal operations collapses to gain control on keys (`T392`).
- **[[wiki/concepts/pattern-separation-completion.md]]** — what the key stage must do *before* matching, because the hippocampus receives noisy input and can address the wrong key: separation and completion are the error-correction on the address, not on the content.
- **[[wiki/concepts/confidence-calibration.md]]** — a confidence signal available from the address stage alone: key-query match strength predicts retrievability without the value being read, where every other confidence estimate in the wiki is computed from an answer already produced.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the key-value reading of TEM (via Whittington et al.): the medial-entorhinal structural code is a **learned position encoding**, i.e. an address space adapted to the structure of the environment, and its structure-sensitive cell types do not appear under the fixed positional encodings a standard transformer uses.
- **[[wiki/entities/temporal-context-model.md]]** — the drifting-scaffold row: random addresses that change slowly make temporally adjacent items similar in address space, which accounts for a large body of human and animal memory data with no learned key mapping at all.
