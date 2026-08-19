# Representation Probing

**Test whether a trained network *contains* a hypothesised structure by fitting a deliberately weak decoder from its internal activations to that structure — and, if the decoder succeeds, ask separately whether the network itself uses what the decoder found.**

Every other evaluation instrument in the wiki scores a system from outside: behaviour on shifted tasks ([[wiki/concepts/shortcut-learning.md]]), code length on a stream ([[wiki/concepts/prediction-compression-equivalence.md]]), skill per unit of prior and experience ([[wiki/concepts/skill-acquisition-efficiency.md]]), outputs per bit of description ([[wiki/concepts/intelligence-density.md]]). Probing is the wiki's first instrument that looks **inside**, and therefore the first that can, in principle, answer gap G17's question directly rather than by proxy. It comes with a matching set of ways to be wrong.

---

## The instruments

| Instrument | Object fitted | What it reads out |
|---|---|---|
| **Linear probe** | `p ∈ R^d` per property, on activations `R_l(t)` at layer `l`, token `t`; predict `[R_l(t) · p] > θ` | Whether property `y` is *linearly* decodable from that site. Restricting to a linear (or thresholded-linear) decoder is the whole point: a strong decoder proves only that the information survived, not that it is in usable form |
| **Direct logit attribution** | `C_{l,h} = E_{(p,c)~D} [ R_{l,h}(p) · (E(c) − r(c)) ]` — head output dotted into the correct-token direction | Which component *writes* toward the answer, per sub-task. Correlational and additive: it decomposes the logit, not the computation |
| **Logit / tuned lens** | Affine translator `L_l : R^d → R^d` with `L_l(R_l(t)) ≈ R_{l_final}(t)`, then the model's own unembedding | The layerwise trajectory of the model's belief in vocabulary terms — where information enters and how it is refined |
| **Intervention (the standard the above do not meet)** | Edit the activation along the probe direction, ablate the head, patch it from another input | Whether the represented content is **causally load-bearing**. Only this licenses "the model uses X" |
| **Similarity-matrix regression against a graph kernel** | Pairwise representational similarity `RSM_ij` regressed on a kernel of the task graph — adjacency `A`, shortest path, Euclidean embedding, or a weighted path sum (`e^A`, `(I − γA)⁻¹`) | *Which metric* over the graph the site carries, not merely whether the graph is decodable. Needs no labels beyond the graph itself and no fitted decoder, so it cannot be won by decoder capacity; the competing kernels are the hypothesis set. The form used to read a predictive map out of human entorhinal cortex (Garvert et al. 2017) |
| **Sparse autoencoder / `k`-sparse classifier** | Overcomplete dictionary with a sparsity penalty on the activation space | Candidate features when the hypothesis set is *not* known in advance — the one instrument here that does not require the answer up front |
| **Manifold inference** | A low-dimensional surface fitted to the activity itself (from temporal transition probabilities, not just the state cloud), then task variables regressed onto its coordinates | The *shape* of the representation before any hypothesis is named, plus an intrinsic-dimension count. Names nothing, so it cannot beg the discovery question the way a probe does — and it is what makes population-level claims measurable ([[wiki/concepts/population-geometry.md]]) |
| **Cross-system alignment over a symmetry group** | One rotation `R ∈ SO(d)` between two systems' `d`-dimensional embeddings; score = fraction of decoding variance the rotation transfers | Whether two systems learned the *same* structure, with no shared units, no per-system probe and no cell-to-cell matching. Works model↔model, model↔brain and brain↔brain with one procedure (Nieh et al. 2021: 69–75% shared between mice). It presupposes the group, so a permutation, reparameterisation or nonlinear warp reads out as absent structure |

**Worked example.** Ivanitskiy et al. 2023 run the first four on maze-solving transformers: `n_layers × m × m × 4` wall probes on the residual stream of a single token reconstruct an entire maze at 0.83–0.99 per-wall accuracy from layer 2, direct logit attribution isolates an *adjacency head* attending to in-context path-length-1 neighbours, and the tuned lens shows valid-neighbour probability rising from the same layer. See [[wiki/entities/maze-solving-transformers.md]].

---

## What a successful probe does and does not establish

| Claim | Licensed? |
|---|---|
| "The information is present at this site" | **Yes**, up to probe capacity |
| "It is present in linearly readable form" | **Yes**, if the probe is linear and the site/token is fixed in advance |
| "It is present by layer `l`" | **Yes** — and the layer index is informative: a world model appearing at layer 2 of 11 has 9 layers left to be used by |
| "The model uses it" | **No.** Requires intervention. Probe accuracy and task accuracy can move together across training and still share a common cause |
| "The model discovered it" | **No.** The probe is trained on ground-truth labels, so it can only confirm a structure the experimenter could already write down |
| "The structure the model has is *this* structure" | **No.** Probing tests containment of a *named* hypothesis; a different, better structure the experimenter did not think of reads out as a failed probe |

**The circularity.** A probe needs labels, and labels are the answer. So probing converts "did this system recover the latent graph?" into "does this system contain the graph I already have?" — which is exactly the move gap G17 forbids for *discovery* claims and permits for *re-representation* claims. It is a strong instrument for the second question and structurally unable to answer the first. The only listed escape is unsupervised dictionary learning over the activation space, which returns features without names and hands the identification problem back to the experimenter.

---

## The decoded-but-unused failure

The finding that makes this a concept page rather than a methods note. In the maze setting, both implications fail:

- **Representation ⇏ competence.** A model whose residual stream reconstructs the maze at ≥0.93 for most cells still emits paths that cross walls (13–16% of rollouts in distribution; 62% for the smaller model out of distribution), while reaching the target ≈100% of the time.
- **Competence ⇏ representation.** A model trained on corridor mazes solves them without ever acquiring a linearly decodable maze representation — the world model shows up when the task distribution contains forks.

| Consequence | Statement |
|---|---|
| **Discovery and use are separately failable** | The wiki's framing splits into estimate-the-graph and route-on-it; here the estimate is verified good and the routing is bad, so a single end-to-end score cannot be attributed to either half |
| **"Emergent world model" claims need the second half** | The literature's headline result is the probe; the behavioural consequence is what the architecture argument actually needs |
| **Probe accuracy is a poor optimisation target** | Maximising decodability optimises for the instrument. Nothing forces the network's own downstream reads to use the direction the probe found |
| **(brainstorm) The right measurement is a gap, not a level** | Report *decodable structure minus behaviourally expressed structure*. On the maze task that is ~0.95 probe accuracy against 84% topology-valid rollouts. A large positive gap localises the deficit in the *use* half (gaps G5, G15) and says the discovery machinery needs no further work — which is the opposite of the conclusion an end-to-end score would suggest |

---

## Applying it to build a reasoning model

| Use | How |
|---|---|
| **Locate the graph estimate** | Probe every layer × token for adjacency; the layer where accuracy peaks is where the estimate is complete, and everything after it is the navigation stack |
| **Verify the `g`/`x` split** | Two probe families — one for structural position, one for content — trained at the same site. The factorization gap G1 tracks is measurable as *whether a content probe generalises across structural positions and vice versa*, which no behavioural test isolates |
| **Test path-consistency (G3)** | Probe the same structural position after distinct routes and compare the decoded codes; commutativity becomes a measurable residual rather than an aspiration |
| **Curriculum diagnosis** | Probe across training checkpoints and across task distributions; the maze result says the branching factor of the training distribution decides whether a graph estimate forms at all |
| **Intervention as the acceptance test** | Before crediting an architecture with a world model, edit the probe direction and check that behaviour changes in the predicted way |

---

## Open problems

- **No probe certifies discovery.** Labels are required, so the instrument is confined to re-representation claims (gap G17 stands). The two additions above narrow the hole without closing it: manifold inference finds a *shape* without labels, and group alignment compares two systems without either one's ground truth — but both still need the experimenter to name the task variables before the shape means anything.
- **Probe capacity has no principled setting.** Linear is a convention; the boundary between "the model represents it" and "the probe computed it" moves with the decoder class.
- **Intervention is rare.** Most published probes, including the maze work, stop before the causal step and report a correlation.
- **Site selection is manual.** Which token, which layer, which stream — chosen by the experimenter, and a negative result is uninformative if the choice was wrong.
- **Nothing connects probe geometry to the loss.** No training signal rewards a network for making its internal structure decodable, so decodability is a lucky by-product (gap G30).

---

## Connections

- **[[wiki/entities/maze-solving-transformers.md]]** — the worked instance of every instrument on this page, and the source of the decoded-but-unused failure and its converse.
- **[[wiki/concepts/latent-graph-discovery.md]]** — supplies the one measurement that separates the framing's two halves inside a single trained model, rather than inferring the split from behaviour.
- **[[wiki/concepts/shortcut-learning.md]]** — the complementary instrument: shifted test sets show that the rule is wrong from outside, probes show what the network holds from inside, and neither alone says which rule is being executed.
- **[[wiki/concepts/skill-acquisition-efficiency.md]]** — the behavioural scoring instrument this one is meant to supplement; probing can pass on a task whose developer-aware generalization difficulty is zero, so it does not replace the shift requirement.
- **[[wiki/concepts/abstract-structural-codes.md]]** — makes `g` empirically checkable: content-invariance and path-consistency are both probe comparisons before they are architectural claims.
- **[[wiki/concepts/attention.md]]** — direct logit attribution is how an attention head is shown to implement a specific relational operation (the adjacency head), turning the soft-adjacency reading from an analogy into a measurement.
- **[[wiki/concepts/objective-identifiability.md]]** — extends the decoded-but-unused problem to two more instruments: a grid score and a linear regression onto neural data are both decodability measures, and the second is confounded by the model's intrinsic dimensionality (participation ratio), so "best matches area X" can be won by being higher-dimensional than the competitors.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the outside-in counterpart: code length says how much structure was exploited without saying what it is, probing names a structure without saying it was used. The pair brackets gap G26 from both sides.
- **[[wiki/concepts/simulation-based-planning.md]]** — supplies the diagnostic that planning failures are not always model failures: if the map probes clean, the deficit is in search, valuation or control (G15).
- **[[wiki/concepts/energy-based-models.md]]** — a probe is a linear read of a latent; where the latent is designed to be low-capacity and discrete, decodability is stipulated rather than discovered, which is the same claim arrived at by construction instead of by measurement.
- **[[wiki/concepts/pattern-separation-completion.md]]** — imposes the same discipline from neuroscience: an internal code's dissimilarity is uninterpretable without the upstream input's, so a separation claim requires recording the source region, just as a probe requires a control for what was already in the input.
- **[[wiki/concepts/pattern-separation-completion.md]]** — also supplies the wiki's one *label-free* internal instrument: the lure bias score `(1st − Lure)/(1st − Repeat)` reads a site's separation/completion position off mean activity using three stimulus conditions as its own anchors, so unlike every probe on this page it needs no ground-truth target and cannot beg the discovery question — at the cost of being blind wherever mean activity is constant across conditions (Bakker et al. 2008).
- **[[wiki/concepts/successor-representation.md]]** — supplies the strongest kernel for the similarity-regression row and a non-obvious prediction to test with it: the biological target is the *traffic-weighted* path sum, so a model whose representational distances match adjacency exactly should score worse against brain data than one whose distances are warped by how often each edge is used.
- **[[wiki/concepts/population-geometry.md]]** — the same inside-the-system ambition run without naming a hypothesis first: fit the manifold, then ask what lies on it, and compare two systems by the rotation between their geometries rather than by two separately trained probes. It also bounds this page's dimensionality confound with a number — a linear PC count can exceed the true latent dimension by 7–8×.
- **[[wiki/concepts/distributed-reference-frames.md]]** — the neuroscience form of this page's discipline: a grid score is a decodability instrument, and the source that argues grids are everywhere also states that its standard autocorrelation detector generates false positives without spike-shuffle controls ([[wiki/empirical-tensions.md]] T37).
