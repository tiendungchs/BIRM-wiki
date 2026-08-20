# Attention

**Process a selected subset of the available information at each step, and use the freed capacity to update state and choose what to select next.**

Attention enters this wiki twice: as **external** selection (where to look in the input) and as **internal** selection (what to read from memory). The second is the operation that made multi-hop reasoning differentiable.

---

## The argument from modularity

The brain does not implement one global optimization principle in a uniform network; it is modular, with distinct interacting subsystems for memory, language and cognitive control (Hassabis et al. 2017). Attention is the most visible import of that stance into AI: the primate visual system does not process all input in parallel with equal priority, but shifts processing resources and representational coordinates among locations and objects in turn.

| Property of biological attention | Consequence when imported |
|---|---|
| Serial sampling of regions ("glimpses") | Architecture: take a glimpse, update internal state, select the next location |
| Prioritization of currently relevant information | Robustness to clutter — irrelevant objects can be ignored rather than encoded |
| Fixed processing resource independent of scene size | **Computational cost scales favourably with input size**, unlike whole-image convolution |
| Recentred representational coordinates | Object-centred rather than image-centred codes |

Reported results: glimpse-based models classify well under clutter where whole-image convolutional networks degrade; extensions outperform convolutional networks on difficult multi-object recognition in both accuracy and efficiency; attention improves image-to-caption generation.

**Attention selects core-typed objects, not regions.** Adult object-based attention inherits the object system's entry conditions and its capacity: 3–4 separately moving items can be tracked when their boundaries and motions obey cohesion and continuity, and entities *violating* those constraints cannot be tracked at all, at any set size (Scholl & Pylyshyn 1999; vanMarle & Scholl 2003; Marino & Scholl 2005; Spelke & Kinzler 2007). Two consequences for an imported attention mechanism: the unit of selection is supplied by an upstream prior rather than by the attention policy, and the capacity bound is a fixed small integer rather than a soft cost — dense machine attention has neither ([[wiki/concepts/core-knowledge.md]]).

---

## Internal attention: the spotlight turned on memory

Directing the same selection mechanism at the contents of memory rather than at the sensory input yields **content-addressable retrieval** — a concept itself imported into AI from neuroscience.

| Use | Effect |
|---|---|
| Read selection in memory-augmented networks | Enables the control/storage separation of [[wiki/concepts/working-memory.md]] |
| Alignment in machine translation | Selects which source positions inform each output step |
| Iterative "hops" through memory | Reasoning over multiple supporting statements that jointly answer a query — the differentiable form of multi-step inference |
| Incremental generation (attentional generative models) | Building an image by attending to one portion of a "mental canvas" at a time |

The memory-hop mechanism is also the paper's outstanding *prediction for neuroscience*: an equivalent iterative retrieval process has been proposed for human cognition, plausibly hippocampal, but no neural substrate has been described ([[wiki/concepts/neuroscience-ai-transfer.md]]).

---

## The spotlight has a persistent state, and it is held in prefrontal cortex

The sections above treat selection as an operation applied per step. Single-unit recordings say it is also a **maintained variable**, held across a delay in the same cells and the same area that the working-memory literature reads as a content buffer (Lebedev et al. 2004; [[wiki/concepts/working-memory.md]]). With a remembered location and a covertly attended location dissociated within one trial, 61% of spatially tuned dorsolateral prefrontal cells tracked *where attention was*, against 16% tracking the remembered location, and the attention signal **grew stronger late in the delay**, as the moment when the attended stimulus mattered approached, with the sensory input unchanged.

| Property of the prefrontal attention signal | Consequence for an attention mechanism |
|---|---|
| Persists across a 1.0–2.5 s delay with no attention-worthy event occurring | The spotlight has state; it is not recomputed from the current input each step |
| Strengthens as the moment of use approaches | The controller's priority is **anticipatory** — a schedule, not a response |
| Collapses for whichever location has become irrelevant, *before* the action that makes it so | Deselection is an explicit prospective operation, not decay |
| Ventrolateral zone: 28% attention vs. 2% memory cells; dorsomedial zone: 8% / 9% / 10% | Selection and content are partly **anatomically separated**, and the mixed zone is the smaller one |

Two readings for a builder. **The wiki's spotlight controller (below) has a candidate substrate and a candidate output format**: a spatial priority map maintained in prefrontal cortex, biasing posterior sensory areas top-down — which is what "attention effects originate in frontal cortex" has meant in this literature since. And **the maintained attentional state is the thing a machine attention layer most conspicuously lacks**: softmax attention recomputes its weights from the current query every step and has no register in which "what I am currently tracking" survives a step that does not query it.

**The spotlight is also a read schedule, and it is item-specific.** The same area supplies the timing half of the same signal (Lundqvist et al. 2018; [[wiki/concepts/working-memory.md]]). Monkeys held a sequence of two objects and compared it to a test sequence; in the delay before each test object, gamma bursting and spiking information ramped up **only for the object about to be tested**, while the other object's information declined. The ramp did not occur before an equally predictable sample presentation, did not occur before a test object rendered irrelevant by an earlier mismatch (beta rose there instead), and did not occur before the one object that always drew the motor response — so the internal spotlight is directed by *what will be queried next*, not by event predictability and not by response preparation.

**(brainstorm)** In the soft-adjacency reading below, a persistent attention signal is a *pinned node* in the one-step graph — a node kept in the query set across steps regardless of what the current content matches. That is one line of state and it is the difference between a graph walk that can hold a frontier and one that must rediscover it from content at every hop.

---

## The spotlight is computed in two stages, and they can be lesioned apart

Where the previous section localises the *state*, Bichot et al. 2015 localises the *computation*, and finds it split across two prefrontal stations that a softmax layer fuses ([[wiki/concepts/priority-map.md]]). Free-viewing search for one of eight natural objects, with feature and spatial selection dissociated by conditioning on where the saccade went:

| | Ventral prearcuate cortex | Frontal eye field |
|---|---|---|
| Object selectivity | 35% of units | **0%** |
| Template held through delay and *across saccades* | yes, to targets and distractors alike | n/a |
| Feature selection | +21.8%, onset 90 ms, earliest per unit (`t` = 2.45, `P` = 0.016) | +8.1%, 100 ms |
| Spatial selection | 138 ms, second | 105 ms, largest (AUROC `F` = 33.56, `P` < 10⁻¹⁸) |
| Silencing it (muscimol) | — | feature selection **abolished** (AUROC 0.633 → 0.508 = chance), spatial selection intact (0.717 → 0.698, `P` = 0.21) |

Three things this fixes for the machine analogue. **The query is a register, not a recomputation** — the same cells hold the cued object through an 800 ms delay and across saccades that replace the entire retinal input, which is the persistent state this page says softmax attention lacks, now with content rather than only a location. **Similarity and arbitration are separate stages** — `sim(template, stimulus(ℓ))` in one area, `argmax_ℓ` in another 15 ms later, with the winner fed back; `softmax(qKᵀ)V` computes both in one expression. **The scoring stage is independently ablatable** — removing it leaves search running and unguided, so the failure mode is content-blind inspection rather than inaction.

The same experiment also removes a common reading of feature attention in sensory cortex: feature selection is *later* in inferior temporal cortex (189 ms) than in either frontal area, and in V4 later than in the frontal eye field (Zhou & Desimone 2011), so extrastriate feature-gain effects are plausibly retinotopic frontal feedback addressed by location, not a feature-space bias signal.

The follow-up runs the same inactivation while recording **V4** (Bichot et al. 2019, 135 vs 127 units, 20-item colour×shape conjunction search). Feature selection in V4 — present from ~130 ms in control sessions — is eliminated in both monkeys before the first saccade and eliminated or two-thirds reduced afterwards, while **spatial** selection in the very same cells is untouched (all interactions n.s., `P` = 0.12–0.32) and saccades to an isolated target are unimpaired. Two consequences for the machine analogue: (i) sensory-layer attentional gain is **not one scalar** — feature gain and location gain arrive through separately ablatable controllers, so an attention layer may legitimately be built with a content-addressed and a location-addressed term under separate control rather than one blended score; (ii) a feature-selective layer does not defend its own feature selection — V4 loses feature modulation despite representing colour and shape itself, and the loss is independent of each unit's own tuning ([[wiki/empirical-tensions.md]] T112).

**And the query need not be the goal.** In humans, four face↔scene pairings were learned, then a face cued search for that face among a race/gender-matched distractor (Zhou & Geng 2025; [[wiki/concepts/priority-map.md]]). Cross-task fMRI decoding over an 8 s blank delay finds the **associated scene** — never presented — in the inferior frontal junction, parietal eye fields and the parahippocampal place area, while the cued **face** is decodable nowhere in the template network (only left intraparietal sulcus, `P` = 0.019 uncorrected); no region carries both. The controller retrieved an associate in ventrolateral prefrontal cortex during the cue and installed *that* as the preparatory template, because the scenes were visually distinctive and the faces were not. Two things follow for a machine attention layer: the query is a **free variable chosen for detectability**, not a re-encoding of the goal — a sub-policy no architecture in the wiki has a slot for; and a swapped query needs a monitor, since on the 25% of trials where the associate misled, accuracy fell (`d` = 0.97) and anterior cingulate plus lateral prefrontal cortex activated to reload the veridical target.

---

## Selection is the capacity limit, and the softmax denominator is where it lives

The sections above treat selection as free once the target is known. Gong & Zhang 2024 measure what it costs when the target is *far*, in the smallest model that can express the task: a causal decoder-only transformer with **one layer, one head, no feed-forward network and no layer norm**, trained from scratch on the `N`-back task (24-letter sequences, 8 matches / 16 nonmatches, 50 independently trained models per `N`, 10 epochs).

| Result | Number |
|---|---|
| Test accuracy falls as `N` rises (1-layer 1-head) | Logarithmic decline over `N ∈ {1..6}`; Kruskal–Wallis `H` = 38.5, `p` < .001, `ε²` = 0.248 (1 vs 3: `r` = −0.68) |
| What the model learns | Attention starts near-uniform per row and **aggregates onto the `i−N` diagonal** over epochs; earlier positions converge first |
| Link between attention and behaviour | Accuracy at position `i` rises with the attention score at position `i−N`, most clearly for `N ≥ 2` |
| Where dispersion comes from | Attention spreads more at *later* positions — more preceding positions to compete for mass |
| The scalar that tracks capacity | `H_N = Σ_i H(A_{i,·})`, the summed row entropy of the causal attention matrix, **rises with `N` as accuracy falls** |
| Scaling it away | With 2 layers or 2–4 heads, most models exceed 95% at every `N` — but a slight decline with `N` survives |

Because a 24-token sequence is far inside any of these models' context, **nothing was forgotten**: the item was present and retrievable, and the model still failed. The limit is in the selection step, which is the executive-attention theory of human working-memory capacity (scarce attentional resource, not scarce storage) arriving intact in an architecture that was not built to have it ([[wiki/concepts/working-memory.md]]).

Three things this changes for a builder.

- **The `N`-back task is structural addressing, and this is what its failure curve looks like.** The model is not retrieving by content — every letter recurs, so content is ambiguous — it is retrieving by a *fixed relative offset* computed from position embeddings, i.e. the "retrieval by structural position rather than content" that this page's open problems and gap G3 ask for. It is learnable, and its reliability decays monotonically in the offset. That is a sharper result than "long chains are unreliable": a **one-hop** read at a known structural distance already degrades with distance.
- **Softmax normalisation is an implicit capacity model, and it is the one nobody reads.** Row `i` distributes a fixed unit of probability over `i` candidates, so every additional stored item dilutes the mass available to the right one. Precision therefore falls with *occupancy*, not with a hyperparameter — and the degradation is graded, not a cliff (gap G42).
- **(brainstorm) Row entropy is a free, per-query confidence signal.** `H(A_{i,·})` is computed for nothing extra on every read of every attention-based store in the wiki, and it says how nearly the read resolved to a single item. A controller could gate on it: re-query, widen, or refuse when the read is diffuse — the "know when the store is full / the read failed" instrument that no architecture here exposes. The summed form `H_N` is the store-level version of the same number.

**Caveat.** The models are deliberately crippled (no feed-forward network, no layer norm, one head) to make attention maps interpretable, and the capacity limit largely disappears with two layers or a few heads — so this is a demonstration that self-attention *can* be the binding constraint, not a measurement of the constraint in a trained large language model. The extrapolation to reported `N`-back declines in GPT-3.5/GPT-4 is the authors' hypothesis, not their result.

---

## Reading in the core framing

| Attention operation | Latent-graph reading |
|---|---|
| Select next glimpse location | Choosing which edge to traverse when the evidence about the graph is gathered by acting |
| Content-addressable read | Retrieval of a node by its content `x` |
| One hop through memory | One edge traversal; a chain of hops is a path |
| Attention weights as a soft adjacency | **(brainstorm)** A query–key similarity matrix over stored items *is* a weighted adjacency over those items — attention is a dense, learned, one-step graph, which is why it substitutes for explicit traversal on short paths and degrades on long ones |
| Cost scaling with input size | The reason selection is mandatory: a full graph over all observations is quadratic and mostly empty |

**(brainstorm)** If attention is a soft adjacency, then the difference between attention and navigation is *how many steps of it the architecture can chain reliably*, and whether the adjacency is recomputed from content each time (attention) or persisted as structure (a graph). Persisting it is exactly what fast **M** is for.

---

## Open problems

- **What controls attention?** Selection policies here are learned end-to-end for a task; no account of goal-driven control of the spotlight, which is the same gap as "what initiates a rollout" in [[wiki/concepts/simulation-based-planning.md]]. Lebedev et al. 2004 localizes the *state* of the spotlight (persistent, anticipatory, prefrontal) without supplying the policy that sets it — the same shape of partial answer as the configurator below. The one architectural proposal in the wiki is H-JEPA's **configurator** — a module that primes perception, world model and cost for the current task by modulating their parameters and attention circuits, implemented in transformer modules as *extra input tokens* that change the connection graph. It supplies the interface and not the policy: how it chooses a task decomposition is left unspecified by its own author (gap G33). A second, narrower version of the same hole: even given the goal, *what to look for* is underdetermined — the biology loads the template with a learned associate chosen for detectability rather than with the goal itself, and no architecture here has a proposer or scorer for that choice (gap G60; Zhou & Geng 2025).
- **Hop depth.** Multi-hop retrieval works for a few supporting statements; reliability along long chains is untested here and is the same problem as self-generated intermediate nodes (gap G10). The *one*-hop version now has a curve: accuracy on a read at a known structural offset `N` falls logarithmically in `N` in a minimal transformer, tracked by the entropy of the attention matrix (Gong & Zhang 2024).
- **Content vs. structure addressing.** Attention retrieves by similarity of content; a navigator needs retrieval by structural position. Position embeddings supply a weak version of the second — a fixed relative offset is learnable — and it is exactly the version that degrades with distance and with the number of competing entries.
- **Where does the unit of selection come from?** Glimpse models select regions; biological object-based attention selects *objects*, individuated by a prior that runs before selection. Nothing here specifies who computes that individuation, which is gap G23's entry test in another place.
- **Serial vs. parallel.** Biological attention is serial and resource-bounded; dense machine attention is parallel and quadratic — the biological constraint may carry computational content the import dropped.

---

## Connections

- **[[wiki/concepts/priority-map.md]]** — the two-stage decomposition of this page's spotlight: a persistent template register and a per-location similarity computed in ventral prearcuate cortex, an argmax over a retinotopic map taken in the frontal eye field, with a causal double dissociation between them — the operations `softmax(qKᵀ)V` fuses into one expression (Bichot et al. 2015); the 2019 follow-up carries the same lesion into V4 and shows feature gain and spatial gain in one sensory population run through different controllers (Bichot et al. 2019); and the human version shows the register's *content* is itself chosen — a learned associate of the target can occupy the template while the target is evicted from the network entirely (Zhou & Geng 2025).
- **[[wiki/concepts/working-memory.md]]** — attention is the read/write access discipline for an external memory; the controller acts on the store only through it — and the two are confounded in the substrate, since most of the delay-period signal in prefrontal cortex encodes the attended location rather than the remembered one ([[wiki/empirical-tensions.md]] T88). And the store's *capacity* is a property of this page's mechanism rather than of the store: in a minimal transformer the sequence sits well inside the context window, so nothing is forgotten and the read is what fails, with summed attention-matrix entropy tracking the failure (Gong & Zhang 2024).
- **[[wiki/concepts/population-geometry.md]]** — supplies the mechanism by which one population can carry both an attended and a remembered location without either being lost: hybrid cells whose preferred location for the two variables *differs* are what resolves the ambiguity that same-preference cells create.
- **[[wiki/concepts/latent-graph-discovery.md]]** — attention weights are a content-computed soft adjacency, i.e. a one-step graph recomputed per query rather than a persisted structure.
- **[[wiki/concepts/neuroscience-ai-transfer.md]]** — the clearest case of an import that arrived largely unacknowledged, and the source of an open prediction (a neural substrate for memory hops).
- **[[wiki/concepts/simulation-based-planning.md]]** — both need a control policy that decides where the next computation is spent; neither has one.
- **[[wiki/concepts/shortcut-learning.md]]** — selecting a feature subset is also *deselecting* everything else, so an attention policy fixes which invariances the decision rule has, i.e. which shortcuts remain available to it.
- **[[wiki/concepts/core-knowledge.md]]** — raises attention from an efficiency device to a binding bottleneck: competition for a limited attentional resource is the stated reason two specialized modules cannot pool their outputs into one representation.
- **[[wiki/concepts/predictive-coding-free-energy.md]]** — recovers attention as *action abstracted from execution*: active inference pointed at internal predictive encodings instead of at the world, which makes attentional control and behavioural control one mechanism and supplies the selection policy this page lacks (Butz 2016).
- **[[wiki/concepts/event-segmentation.md]]** — an event boundary is a lasting change in the currently active encoding set, i.e. the signal that says *now re-select*; segmentation supplies the timing that attention supplies the target for.
- **[[wiki/concepts/amortized-inference.md]]** — attention is how a fast amortized mapping is decomposed into a sequence of sub-queries rather than one shot: caption models attend to each object as it is mentioned, and generative models attend to one image region at a time, which is what makes a feed-forward pass a *proposal* rather than an answer.
- **[[wiki/concepts/three-component-framework.md]]** — lists focused attention as one of four canonical inductive biases, i.e. a prior inserted through the architecture slot rather than learned from data.
- **[[wiki/entities/h-jepa.md]]** — its configurator is the goal-driven spotlight controller this page lacks, and it makes modulation-by-token the concrete mechanism: extra transformer inputs reconfigure the connection graph of the module being primed.
- **[[wiki/concepts/subgraph-matching.md]]** — the rival retrieval mechanism: a dot-product score is content similarity against a one-step soft adjacency, where an order embedding tests *containment of a whole multi-hop pattern*, which is what querying a schema library requires and similarity cannot express.
- **[[wiki/entities/maze-solving-transformers.md]]** — the soft-adjacency brainstorm above, measured: one head (L5H3) places its attention on tokens at *path* length 1 from the current position, i.e. it has learned the in-context adjacency matrix rather than the lattice's, and a second appears to be half a reversed induction head pointing at the goal (Ivanitskiy et al. 2023).
- **[[wiki/concepts/representation-probing.md]]** — supplies the instrument that identified those heads (direct logit attribution) and the caveat attached to it: decomposing a logit says which head writes toward the answer, not what computation it performs.
- **[[wiki/entities/tem-transformer.md]]** — the brainstorm above at its strongest: self-attention is *derived* as one read of a Hebbian associative memory, with keys carrying structural addresses and values carrying content, so an attention head is exactly one integrate-then-retrieve step over a stored graph — and its sparsely-firing memory neurons are place cells.
- **[[wiki/entities/mm-tem-hippoformer.md]]** — the complement measured rather than derived: attention over a finite window is the accurate short-range read and degrades to memorisation exactly where a path-integrated structural address keeps working, so the two are stacked in parallel rather than one replacing the other.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — the cheap degenerate case of content-addressable retrieval: a Boolean-OR union answers "is this cue one of my `M` stored items" in a single thresholded dot product, `O(1)` in `M` with a computable false-positive rate, where attention scores every entry — the price is that the union returns membership rather than a value-weighted mixture.
- **[[wiki/concepts/dendritic-computation.md]]** — a hardware realisation of the same select-and-match operation with no softmax: each dendritic segment holds one key (`s ≈ 30` synapses) and emits one bit when the query overlaps it by `θ`, so a cell is ~100 parallel key matches and the normalisation attention needs is supplied externally by inhibition.
- **[[wiki/concepts/canonical-cortical-microcircuit.md]]** — the biological form of the soft-max and two ways it differs: selection is implemented by perisomatic inhibition and *iterated* (the winners feed back onto the dendrite-targeting interneurons and change what each unit integrates before the next round), so the competition and the representation co-evolve rather than the query being scored once against a fixed set of keys (Douglas & Martin 2004). A rival account of the same circuit makes attention multiplicative rather than competitive: precision `Π` sits on the superficial pyramidal cell's postsynaptic gain, so attending scales the *prediction-error* channel — which predicts that an unpredicted stimulus raises the response when unattended and lowers it when attended (Kok et al. 2011; Bastos et al. 2012).
- **[[wiki/entities/thousand-brains-theory.md]]** — attention as a *motor* output: the same layer-5 pathway that moves an effector selects which lower-level columns supply the next input, so the spotlight controller is not a separate module and is trained by sensorimotor prediction error rather than by task loss.
- **[[wiki/entities/pbwm.md]]** — the same selection operation on the write side of the store: basal-ganglia Go/NoGo gating decides what is admitted rather than what is read out, and unlike a read it must be trained against consequences that arrive many steps later.
- **[[wiki/concepts/inhibitory-control-of-coding.md]]** — the deselection half of internal attention with a named channel: prefrontal beta bursts suppress gamma and informative spiking at the sites holding an item that is no longer needed, so "stop attending to this" is an addressed inhibitory signal rather than the absence of a query (Lundqvist et al. 2018).
- **[[wiki/entities/differentiable-neural-computer.md]]** — attention used as a memory read, and the wiki's clearest case of attention switching between *address spaces* rather than items: a three-way read mode mixes content lookup with forward and backward traversal of write order, learned per head per step.
- **[[wiki/concepts/prediction-compression-equivalence.md]]** — the complementary bound on the same store: that page limits the fast level by context *length* (a few kilobytes, quadratic cost), this one by the dispersion of the read inside it, and the second binds first.
- **[[wiki/concepts/cognitive-control.md]]** — answers this page's "what controls attention?" at the level of mechanism rather than policy: a sustained prefrontal pattern coding the current task adds excitatory bias to the units representing the expected stimulus, and the mutual inhibition already running among the competitors converts that small bias into selection — so enhancing the relevant and suppressing the rest are one operation, and the machine import is a persistent task-identified bias vector added to attention logits rather than a query recomputed per step (Desimone & Duncan 1995, in Miller et al. 2002).
- **[[wiki/entities/medial-prefrontal-cortex.md]]** — gives the orienting drive a nucleus and a port: intralaminar thalamic nuclei (orienting, attention) terminate in deep layers of the dorsal medial wall while midline nuclei (arousal, visceral state) terminate in the ventral one, so attentional and interoceptive input enter the controller through separate channels rather than summing into one state.
- **[[wiki/concepts/control-unity-and-diversity.md]]** — draws the boundary between two flexibilities that behavioural switching tasks blend: reversing a value within a fixed dimension is orbitofrontal and survives ventrolateral lesions, while redirecting to a different feature *dimension* is ventrolateral and survives orbitofrontal lesions — only the second is this page's operation (Friedman & Robbins 2021).
- **[[wiki/concepts/expected-free-energy.md]]** — makes the epistemic/pragmatic trade-off this page inherits from active inference precise: `⟨ℓ,μ⟩ + Φ(μ)`, a linear preference cost plus a convex negative-entropy term, with no free mixing coefficient between them — the balance is set by the objective's own geometry, not by a tuned weight (Milosevic et al. 2026).
- **[[wiki/entities/hippocampal-prefrontal-channel.md]]** — the contrast that makes the hub result interesting: every read on this page is content-addressed (a query against stored keys), while the channel's return arrow is addressed by the target's *degree inside the store*.
- **[[wiki/entities/c-ts-model.md]]** — dimensional attention read as a structural hypothesis rather than a gain: mixture-of-experts weights over C-TS / S-TS / flat decide *which dimension indexes rules*, not how strongly a feature is amplified.
- **[[wiki/concepts/event-segmentation.md]]** — the dorsal attention network carries the *uncertainty*-driven event boundary and only that one, with almost no post-boundary pattern stabilisation, so a boundary reaching this system is a redirect-the-sampling signal rather than a replace-the-model signal (Nguyen et al. 2025).
- **[[wiki/concepts/precision-weighting.md]]** — the rival account of the same phenomenon: attention as multiplicative gain on a prediction error, set by inferred precision, with no normalising denominator and therefore no built-in capacity limit — where this page derives selection from a softmax competition (Friston 2009).
