# REMERGE — generalization by recirculating an episodic store's own output

**An exemplar model made recursive: the similarity computation over stored episodic traces does not terminate at its first output but is fed back in as a new input, iterated inside a recurrent circuit until the system settles. Links between items never experienced together fall out of the settled state, so inference is produced *at retrieval* from pattern-separated traces, with nothing integrated at encoding.**

> **Provenance.** Kumaran & McClelland 2012, *Generalization through the recurrent interaction of episodic memories: a model of the hippocampal system*, Psychol Rev 119:573–616 — ingested second-hand through the complementary-learning-systems update that the model was written to rescue (Kumaran, Hassabis & McClelland 2016, `raw/kumaran-2016-complementary-learning-systems-updated.md`, Box 6). The wiki holds no primary source for the model itself; the equations and simulation results below are **not** available here, only the mechanism and what it is claimed to buy.

---

## The problem it exists to solve

| Step | Claim |
|---|---|
| Complementary learning systems assigns generalization to the slow cortical learner and specifics to the sparse hippocampal store | [[wiki/concepts/complementary-learning-systems.md]] |
| Paired-associate inference (study `AB`, `BC`; test `A–C`) and transitive inference are solved **within or shortly after one session**, and are hippocampus-dependent | So a system whose representations are maximally non-overlapping is somehow doing cross-item inference |
| The standard repair is **encoding-based overlap**: the hippocampus stores an integrated `ABC` representation built when `BC` reinstates `A` | [[wiki/concepts/retrieval-mediated-learning.md]] — which abandons pattern separation for exactly the items most likely to interfere |
| REMERGE's repair: keep the separated traces, make the *read* recurrent | Generalization is a property of the retrieval dynamics, not of the stored code |

---

## The mechanism

| Property | Statement |
|---|---|
| Base operation | Exemplar/instance-based similarity: compute the similarity of the current input to each stored trace (the cognitive-science exemplar model, machine-learning `k`-NN) |
| The addition | **Recurrent similarity computation** — the retrieved products of step 1 are combined with the external sensory input and a second round of similarity computation is run over the same store |
| Termination | Iterate until a stable state (an attractor basin) is reached; the settled state, not the first-pass output, is the answer |
| What it buys | **Higher-order similarity**: `A` and `C` are linked through `B` even though their pairwise similarity is uninformative, because `B`'s reinstatement changes the input on the next iteration |
| What it preserves | Pattern-separated traces for individual episodes — the property [[wiki/concepts/pattern-separation-completion.md]] says the fast store exists to have |
| Anatomical claim | The recurrence is the hippocampal system's own (CA3 recurrent collaterals plus the entorhinal–hippocampal loop), so no new structure is postulated |

**Two predictions it makes that a static store does not.**

1. Hippocampal activity should sometimes **combine information from several separate episodes** — a single population state that is not any one stored trace. The source reports rodent recordings consistent with this ("generalized replay": simultaneous reactivation of multiple related traces, during testing or offline).
2. **Weak traces suffice for generalization.** Because the answer is an attractor over many traces, item recognition can be near-chance while inference is near-normal — a dissociation an integrated-representation account has no natural route to.

---

## Where it sits in the wiki's write-time/read-time trade-off

| | Write-time integration | **REMERGE** | Query-time composition (naive) |
|---|---|---|---|
| What is stored | a composite the agent never experienced | separated traces only | separated traces only |
| Who pays for the unobserved path | the encoder, speculatively | the retrieval dynamics, per query | a traversal operator, per hop |
| Cost profile | once per overlapping episode, queried or not | settling time, bounded by the attractor | compounding error per hop |
| Failure mode | schema distorts the item | a settled state that mixes the wrong traces | multi-hop collapse |

This makes REMERGE the mechanistic form of Position B in [[wiki/empirical-tensions.md]] T334, and a sharper one than the wiki's existing occupants of that position: the temporal context model derives the ordering from retrieved-context overlap at test, and [[wiki/entities/tolman-eichenbaum-machine.md]] answers from a structural code that had to be learned first. REMERGE needs neither a context gradient nor a trained generative model — only a store and a loop.

**The source's own verdict is that the evidence does not decide.** Encoding-based overlap and retrieval-based models make divergent predictions and no experiment separates them; both may run, selected by paradigm, amount of training and training–test delay. And the boundary is not sharp from REMERGE's side either: *generalized replay* — simultaneous reactivation of several related traces offline — can **write the settled state back** as a new trace ("stored generalizations"), at which point a retrieval-based mechanism has manufactured the composite the encoding-based account assumes.

---

## The machine parallel, stated by the source

| REMERGE | **Memory networks** (Weston et al. 2014) |
|---|---|
| similarity of input to stored episodic traces | dense learned feature vector of the query matched against sentences in a database |
| recirculate the retrieved product with the input | combined representation of query + retrieved sentence used to retrieve the next sentence |
| iterate to a stable state | iterate until a response is emitted |
| slow cortical learner supplies the representation the similarity is computed in | the feature representation is trained gradually over a large corpus |

So the question-answering architecture and the hippocampal model have the same shape, and the source reads the shared dependence — gradually-trained representation + individually-stored items — as complementary learning systems appearing in machine learning without being imported. The external memory of the [[wiki/entities/differentiable-neural-computer.md]] lineage is the same content-addressable store with the loop left out.

**(brainstorm) The unrun ablation is one line.** Every retrieval-augmented model in the wiki performs a *single* retrieval pass per query; REMERGE says the multi-hop capability those models lack is bought by re-querying with the concatenation of query and retrieved content until the retrieved set stops changing, with no change to the index and no write. The prediction is specific: iterative re-query should help exactly on queries whose answer requires an item with low similarity to the original query and high similarity to a first-pass hit, and should do nothing otherwise. Present-day retrieval-augmented systems with a fixed hop budget are the truncated version of this, and nobody reports the settling curve.

---

## Limitations

- **No primary source in the wiki.** Everything above is the 2016 review's summary of its own earlier model; no equations, no simulation numbers, no fits to the paired-associate-inference data are available here.
- **Settling is not free.** The cost of the recurrent read is never priced against the write-time alternative, and an attractor over a growing store has the usual capacity problem ([[wiki/entities/rolls-treves-hippocampal-model.md]]) with no statement of how many traces the loop tolerates.
- **Nothing selects which traces enter the loop.** The similarity computation is over the whole store; in a large store the first pass returns mostly noise, which is the failure mode [[wiki/entities/macfac.md]] measures in human relational retrieval (~.12 structural vs ~.53 surface).
- **The concept-cell data are argued to be compatible, not predicted.** Invariant "concept cell like" responses in entorhinal/parahippocampal cortex versus image-discriminating responses in CA3/DG are reconciled by making pattern separation a matter of degree, which weakens the store-side commitment the model depends on.

---

## Connections

- **[[wiki/concepts/complementary-learning-systems.md]]** — the amendment this model was built to license: the fast store generalizes after all, without giving up pattern separation, so the theory's original fast-specific/slow-general dichotomy softens on the *fast* side rather than being abandoned.
- **[[wiki/concepts/retrieval-mediated-learning.md]]** — the direct rival mechanism for the same behaviour: that page pays for the unobserved `A–C` path at encoding by binding a reinstated element into a live episode, this one pays at retrieval by recirculating the store's own output, and the source states the evidence does not separate them ([[wiki/empirical-tensions.md]] T334).
- **[[wiki/concepts/pattern-separation-completion.md]]** — what the model is designed to keep: generalization is moved into the read dynamics precisely so the stored code can stay separated, which makes "separate or integrate" a question about the retrieval loop rather than about the write.
- **[[wiki/concepts/attractor-dynamics.md]]** — the settling process is an attractor relaxation over a store rather than over a learned energy landscape, so the answer to an inference query is a fixed point whose basin was never explicitly trained.
- **[[wiki/entities/temporal-context-model.md]]** — the other retrieval-time account of inference in the wiki, differing in what is recirculated: retrieved *context* there, retrieved *items* here, with the same commitment that no composite is stored.
- **[[wiki/entities/tolman-eichenbaum-machine.md]]** — the structural-code answer to the same test: transitive inference on first presentation from a learned generative model, i.e. the path is paid for by pretraining rather than by settling, which brackets the cost space with this page.
- **[[wiki/concepts/offline-replay.md]]** — supplies the model's offline form and the route by which it stops being purely retrieval-based: generalized replay reactivates several related traces at once, and writing the settled state back creates the composite that a write-time account assumes.
- **[[wiki/entities/differentiable-neural-computer.md]]** — the same content-addressable store with the loop present but untrained for this purpose: read heads can chain, and nothing in the objective asks the chain to run to a fixed point.
- **[[wiki/entities/hopfield-network.md]]** — the minimal form of the settling half without the exemplar half: iterate to an attractor, but over a superposed weight matrix rather than over separately stored traces addressed by similarity.
- **[[wiki/concepts/latent-graph-discovery.md]]** — a path query answered without ever estimating the path: the graph stays implicit in the trace set and the traversal is performed by relaxation, so what a builder needs is a settling rule rather than an edge estimator.
- **[[wiki/entities/macfac.md]]** — supplies the retrieval-stage failure this model has no defence against: a first-pass similarity computation over a large store returns surface matches at .53 against .12 for structural ones, so what enters the loop is mostly wrong before the loop starts.
